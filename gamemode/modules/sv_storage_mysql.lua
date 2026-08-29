local backend = {}
backend.dialect = "mysql"
backend.name = "mysql"

local db
local down = false
local reconnectAttempt = 0
local connectCallback

local function scheduleReconnect()
	reconnectAttempt = reconnectAttempt + 1
	local delay = math.min(2 ^ reconnectAttempt, 60)
	timer.Simple(delay, function()
		if down and db then
			print("[metro] attempting MySQL reconnect (try " .. reconnectAttempt .. ")")
			db:connect()
		end
	end)
end

local function onConnected()
	if down then
		print("[metro] MySQL reconnected, resuming normal operation")
	end
	down = false
	reconnectAttempt = 0
	if connectCallback then
		local cb = connectCallback
		connectCallback = nil
		cb(nil)
	end
end

local function onConnectionFailed(_, err)
	if connectCallback then
		local cb = connectCallback
		connectCallback = nil
		cb("mysql connection failed: " .. tostring(err))
		return
	end

	if not down then
		down = true
		ErrorNoHalt("[metro] MySQL connection lost (" .. tostring(err) .. "), refusing mutations until reconnected\n")
	end

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

	db = mysqloo.connect(config.host, config.username, config.password, config.database, config.port)
	db.onConnected = onConnected
	db.onConnectionFailed = onConnectionFailed
	db:connect()
end

local function exec(sqlText, cb)
	if down or not db then
		cb("mysql backend unavailable")
		return
	end

	local query = db:query(sqlText)

	function query:onSuccess(data)
		cb(nil, data or {}, query:lastInsert())
	end

	function query:onError(err)
		local message = tostring(err)
		if string.find(message, "gone away") or string.find(message, "Lost connection") then
			if not down then
				down = true
				ErrorNoHalt("[metro] MySQL connection lost mid-query, refusing mutations until reconnected\n")
				scheduleReconnect()
			end
		end
		cb(err)
	end

	query:start()
end

local function esc(value)
	return db:escape(tostring(value))
end

function backend.RunMigrations(cb)
	METRO.RunMigrationsAgainst("mysql", exec, cb)
end

function backend.LoadPlayer(steamid64, cb)
	exec("SELECT * FROM metro_players WHERE steamid64 = '" .. esc(steamid64) .. "'", function(err, rows)
		if err then
			cb(err)
			return
		end
		cb(nil, rows[1])
	end)
end

function backend.CreatePlayer(steamid64, name, cb)
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
	local actor = entry.actor_steamid64 and ("'" .. esc(entry.actor_steamid64) .. "'") or "NULL"
	local query = string.format(
		"INSERT INTO metro_transactions (steamid64, actor_steamid64, delta, balance_after, reason, created_at) " ..
		"VALUES ('%s', %s, %d, %d, '%s', '%s')",
		esc(entry.steamid64), actor, entry.delta, entry.balance_after, esc(entry.reason),
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

METRO.Backends.mysql = backend
