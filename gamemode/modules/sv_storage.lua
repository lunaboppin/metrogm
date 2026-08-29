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

function METRO.Storage.RunMigrations(cb)
	active.RunMigrations(cb)
end

function METRO.Storage.LoadPlayer(steamid64, cb)
	active.LoadPlayer(steamid64, cb)
end

function METRO.Storage.CreatePlayer(steamid64, name, cb)
	active.CreatePlayer(steamid64, name, cb)
end

function METRO.Storage.SavePlayer(record, cb)
	active.SavePlayer(record, cb)
end

function METRO.Storage.LogTransaction(entry, cb)
	active.LogTransaction(entry, cb)
end
