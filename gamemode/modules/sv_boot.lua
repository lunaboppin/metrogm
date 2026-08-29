function GM:Initialize()
	METRO.Config = METRO.LoadDatabaseConfig()

	METRO.Storage.Connect(function(connectErr)
		if connectErr then
			ErrorNoHalt("[metro] FATAL: could not establish any storage backend: " .. tostring(connectErr) .. "\n")
			return
		end

		METRO.Storage.RunMigrations(function(migrateErr, result)
			if migrateErr then
				ErrorNoHalt("[metro] FATAL: migrations failed: " .. tostring(migrateErr) .. "\n")
				return
			end

			if result and #result.applied > 0 then
				print("[metro] applied migrations: " .. table.concat(result.applied, ", ") .. " (schema version " .. result.version .. ")")
			else
				print("[metro] schema already up to date (version " .. tostring(result and result.version) .. "), no migrations applied")
			end
		end)
	end)
end
