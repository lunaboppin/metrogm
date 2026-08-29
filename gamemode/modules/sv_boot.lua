METRO.Boot = METRO.Boot or {}

local bootState = "pending"
local bootError
local bootWaiters = {}

function METRO.Boot.IsReady()
	return bootState == "ready"
end

function METRO.Boot.GetError()
	return bootError
end

function METRO.Boot.WaitForReady(cb)
	if bootState == "ready" then
		cb(nil)
		return
	end

	if bootState == "error" then
		cb(bootError)
		return
	end

	table.insert(bootWaiters, cb)
end

local function finishBoot(state, err)
	bootState = state
	bootError = err

	local waiters = bootWaiters
	bootWaiters = {}

	for _, cb in ipairs(waiters) do
		cb(err)
	end
end

function GM:Initialize()
	METRO.Config = METRO.LoadDatabaseConfig()

	METRO.Storage.Connect(function(connectErr)
		if connectErr then
			ErrorNoHalt("[metro] FATAL: could not establish any storage backend: " .. tostring(connectErr) .. "\n")
			finishBoot("error", tostring(connectErr))
			return
		end

		METRO.Storage.RunMigrations(function(migrateErr, result)
			if migrateErr then
				ErrorNoHalt("[metro] FATAL: migrations failed: " .. tostring(migrateErr) .. "\n")
				finishBoot("error", tostring(migrateErr))
				return
			end

			if result and #result.applied > 0 then
				print("[metro] applied migrations: " .. table.concat(result.applied, ", ") .. " (schema version " .. result.version .. ")")
			else
				print("[metro] schema already up to date (version " .. tostring(result and result.version) .. "), no migrations applied")
			end

			finishBoot("ready")
		end)
	end)
end
