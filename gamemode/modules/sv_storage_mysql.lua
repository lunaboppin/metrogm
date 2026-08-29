local backend = {}
backend.dialect = "mysql"
backend.name = "mysql"

local db
local down = false
local connected = false
local reconnectAttempt = 0
local reconnectScheduled = false
local connectCallback
local pendingQueries = {}

local function scheduleReconnect()
	if reconnectScheduled or not db then
		return
	end

	reconnectAttempt = reconnectAttempt + 1
	local delay = math.min(2 ^ reconnectAttempt, 60)
	reconnectScheduled = true
	timer.Simple(delay, function()
		reconnectScheduled = false
		if down and db then
			print("[metro] attempting MySQL reconnect (try " .. reconnectAttempt .. ")")
			db:connect()
		end
	end)
end

local function isConnectionError(err)
	local message = string.lower(tostring(err))
	return string.find(message, "gone away", 1, true)
		or string.find(message, "lost connection", 1, true)
		or string.find(message, "not connected", 1, true)
		or string.find(message, "connection reset", 1, true)
		or string.find(message, "server shutdown", 1, true)
end

local function markDown(err)
	connected = false
	if down then
		return
	end

	down = true
	ErrorNoHalt("[metro] MySQL connection lost (" .. tostring(err) .. "), queueing operations until reconnected\n")
	scheduleReconnect()
end

local runPendingQueries

local function onConnected()
	if down then
		print("[metro] MySQL reconnected, retrying queued operations")
	end
	connected = true
	down = false
	reconnectAttempt = 0
	if connectCallback then
		local cb = connectCallback
		connectCallback = nil
		cb(nil)
	end
	runPendingQueries()
end

local function onConnectionFailed(_, err)
	connected = false
	if connectCallback then
		local cb = connectCallback
		connectCallback = nil
		cb("mysql connection failed: " .. tostring(err))
		return
	end

	markDown(err)
	scheduleReconnect()
end

function backend.Connect(cb)
	if not util.IsBinaryModuleInstalled("mysqloo") then
		cb("mysqloo binary module is not installed")
		return
	end

	local ok = pcall(require, "mysqloo")
	if not ok or not mysqloo then
		cb("mysqloo module failed to load")
		return
	end

	local config = METRO.Config
	connectCallback = cb
	connected = false
	down = false

	db = mysqloo.connect(config.host, config.username, config.password, config.database, config.port)
	db.onConnected = onConnected
	db.onConnectionFailed = onConnectionFailed
	db:connect()
end

local function enqueueQuery(sqlText, cb)
	table.insert(pendingQueries, { sql = sqlText, cb = cb })
end

local function runQuery(sqlText, cb)
	if not db then
		cb("mysql backend unavailable")
		return
	end

	local query = db:query(sqlText)

	function query:onSuccess(data)
		cb(nil, data or {}, query:lastInsert())
	end

	function query:onError(err)
		if isConnectionError(err) then
			markDown(err)
			enqueueQuery(sqlText, cb)
			return
		end
		cb(err)
	end

	query:start()
end

runPendingQueries = function()
	if down or not connected or not db then
		return
	end

	local queued = pendingQueries
	pendingQueries = {}
	for _, operation in ipairs(queued) do
		runQuery(operation.sql, operation.cb)
	end
end

local function exec(sqlText, cb)
	if not db then
		cb("mysql backend unavailable")
		return
	end

	if down or not connected then
		enqueueQuery(sqlText, cb)
		return
	end

	runQuery(sqlText, cb)
end

local function esc(value)
	return db:escape(tostring(value))
end

local function ensureAvailable(cb)
	if not db then
		cb("mysql backend unavailable")
		return false
	end
	return true
end

function backend.RunMigrations(cb)
	METRO.RunMigrationsAgainst("mysql", exec, cb)
end

function backend.LoadPlayer(steamid64, cb)
	if not ensureAvailable(cb) then
		return
	end

	exec("SELECT * FROM metro_players WHERE steamid64 = '" .. esc(steamid64) .. "'", function(err, rows)
		if err then
			cb(err)
			return
		end
		cb(nil, rows[1])
	end)
end

function backend.CreatePlayer(steamid64, name, cb)
	if not ensureAvailable(cb) then
		return
	end

	local now = os.date("%Y-%m-%d %H:%M:%S")
	local query = string.format(
		"INSERT INTO metro_players (steamid64, name, money, xp, level, playtime_seconds, first_seen, last_seen) " ..
		"VALUES ('%s', '%s', 0, 0, 1, 0, '%s', '%s')",
		esc(steamid64), esc(name), now, now
	)
	exec(query, function(err)
		if err then
			cb(err)
			return
		end
		backend.LoadPlayer(steamid64, cb)
	end)
end

function backend.SavePlayer(record, cb)
	if not ensureAvailable(cb) then
		return
	end

	local query = string.format(
		"UPDATE metro_players SET name = '%s', money = %d, xp = %d, level = %d, playtime_seconds = %d, last_seen = '%s' " ..
		"WHERE steamid64 = '%s'",
		esc(record.name), record.money, record.xp, record.level, record.playtime_seconds,
		os.date("%Y-%m-%d %H:%M:%S"), esc(record.steamid64)
	)
	exec(query, function(err)
		cb(err)
	end)
end

function backend.LogTransaction(entry, cb)
	if not ensureAvailable(cb) then
		return
	end

	local actor = entry.actor_steamid64 and ("'" .. esc(entry.actor_steamid64) .. "'") or "NULL"
	local kind = entry.kind or "money"
	local query = string.format(
		"INSERT INTO metro_transactions (steamid64, actor_steamid64, delta, balance_after, reason, kind, created_at) " ..
		"VALUES ('%s', %s, %d, %d, '%s', '%s', '%s')",
		esc(entry.steamid64), actor, entry.delta, entry.balance_after, esc(entry.reason), esc(kind),
		os.date("%Y-%m-%d %H:%M:%S")
	)
	exec(query, function(err, _, insertId)
		if err then
			cb(err)
			return
		end
		cb(nil, insertId)
	end)
end

function backend.RunUnavailableGuardTest(cb)
	local savedDb = db
	local savedDown = down
	local savedConnected = connected
	local savedPendingQueries = pendingQueries

	db = nil
	down = true
	connected = false
	pendingQueries = {}

	local checks = {
		{ "LoadPlayer", function(next) backend.LoadPlayer("0", next) end },
		{ "CreatePlayer", function(next) backend.CreatePlayer("0", "guard-test", next) end },
		{ "SavePlayer", function(next)
			backend.SavePlayer({ steamid64 = "0", name = "guard-test", money = 0, xp = 0, level = 1, playtime_seconds = 0 }, next)
		end },
		{ "LogTransaction", function(next)
			backend.LogTransaction({ steamid64 = "0", delta = 0, balance_after = 0, reason = "guard-test" }, next)
		end },
	}

	local failures = {}

	for _, check in ipairs(checks) do
		local name, run = check[1], check[2]
		local gotErr = nil
		local ok, luaErr = pcall(run, function(err) gotErr = err end)
		if not ok then
			table.insert(failures, name .. " raised a lua error: " .. tostring(luaErr))
		elseif gotErr == nil then
			table.insert(failures, name .. " did not report an error through its callback")
		end
	end

	down = savedDown
	db = savedDb
	connected = savedConnected
	pendingQueries = savedPendingQueries

	if #failures > 0 then
		cb(table.concat(failures, "; "))
		return
	end

	cb(nil)
end

METRO.Backends.mysql = backend
