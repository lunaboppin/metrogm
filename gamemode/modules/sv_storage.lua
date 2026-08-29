METRO.Storage = METRO.Storage or {}

local active
local activeName

local function useSqlite(cb)
	active = METRO.Backends.sqlite
	activeName = "sqlite"
	active.Connect(cb)
end

local function useMysql(cb)
	active = METRO.Backends.mysql
	activeName = "mysql"
	active.Connect(function(err)
		if err then
			active = nil
			activeName = nil
		end
		cb(err)
	end)
end

local function pickBackend(cb)
	local config = METRO.Config

	if config.backend == "mysql" then
		useMysql(function(err)
			if err then
				cb("backend forced to mysql but connection failed: " .. tostring(err))
				return
			end
			cb(nil)
		end)
	elseif config.backend == "sqlite" then
		useSqlite(cb)
	else
		useMysql(function(err)
			if err then
				print("[metro] mysql unavailable (" .. tostring(err) .. "), falling back to sqlite for this session")
				useSqlite(cb)
				return
			end
			cb(nil)
		end)
	end
end

function METRO.Storage.Connect(cb)
	if active then
		cb(nil)
		return
	end

	pickBackend(function(err)
		if err then
			cb(err)
			return
		end
		print("[metro] storage backend selected for this session: " .. string.upper(activeName))
		cb(nil)
	end)
end

function METRO.Storage.GetBackendName()
	return activeName
end

local function ensureActive(cb)
	if not active then
		cb("storage backend not connected")
		return false
	end
	return true
end

function METRO.Storage.RunMigrations(cb)
	if not ensureActive(cb) then
		return
	end
	active.RunMigrations(cb)
end

function METRO.Storage.LoadPlayer(steamid64, cb)
	if not ensureActive(cb) then
		return
	end
	active.LoadPlayer(steamid64, cb)
end

function METRO.Storage.CreatePlayer(steamid64, name, cb)
	if not ensureActive(cb) then
		return
	end
	active.CreatePlayer(steamid64, name, cb)
end

function METRO.Storage.SavePlayer(record, cb)
	if not ensureActive(cb) then
		return
	end
	active.SavePlayer(record, cb)
end

function METRO.Storage.LogTransaction(entry, cb)
	if not ensureActive(cb) then
		return
	end
	active.LogTransaction(entry, cb)
end

function METRO.Storage.RunUnavailableGuardTest(cb)
	local savedActive = active
	local savedActiveName = activeName

	active = nil
	activeName = nil

	local checks = {
		{ "RunMigrations", function(next) METRO.Storage.RunMigrations(next) end },
		{ "LoadPlayer", function(next) METRO.Storage.LoadPlayer("0", next) end },
		{ "CreatePlayer", function(next) METRO.Storage.CreatePlayer("0", "guard-test", next) end },
		{ "SavePlayer", function(next) METRO.Storage.SavePlayer({ steamid64 = "0" }, next) end },
		{ "LogTransaction", function(next)
			METRO.Storage.LogTransaction({ steamid64 = "0", delta = 0, balance_after = 0, reason = "guard-test" }, next)
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

	active = savedActive
	activeName = savedActiveName

	if #failures > 0 then
		cb(table.concat(failures, "; "))
		return
	end

	cb(nil)
end
