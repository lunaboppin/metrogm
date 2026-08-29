local function assertEqual(actual, expected, label, cb)
	if actual ~= expected then
		cb(string.format("%s mismatch: expected %s, got %s", label, tostring(expected), tostring(actual)))
		return false
	end
	return true
end

local function runSelfTest(cb)
	local steamid64 = "9" .. tostring(os.time()) .. tostring(math.random(100, 999))
	local name = "metro-selftest"

	METRO.Storage.CreatePlayer(steamid64, name, function(err, record)
		if err then
			cb("CreatePlayer failed: " .. tostring(err))
			return
		end

		if not assertEqual(tonumber(record.money), 0, "initial money", cb) then
			return
		end

		record.money = 500
		record.xp = 120
		record.level = 2
		record.playtime_seconds = 42

		METRO.Storage.SavePlayer(record, function(saveErr)
			if saveErr then
				cb("SavePlayer failed: " .. tostring(saveErr))
				return
			end

			METRO.Storage.LoadPlayer(steamid64, function(loadErr, reloaded)
				if loadErr then
					cb("LoadPlayer failed: " .. tostring(loadErr))
					return
				end

				if not reloaded then
					cb("LoadPlayer returned no record after save")
					return
				end

				if not assertEqual(tonumber(reloaded.money), 500, "saved money", cb) then
					return
				end

				if not assertEqual(tonumber(reloaded.xp), 120, "saved xp", cb) then
					return
				end

				METRO.Storage.LogTransaction({
					steamid64 = steamid64,
					actor_steamid64 = nil,
					delta = 500,
					balance_after = 500,
					reason = "selftest",
				}, function(txErr)
					if txErr then
						cb("LogTransaction failed: " .. tostring(txErr))
						return
					end

					cb(nil)
				end)
			end)
		end)
	end)
end

concommand.Add("metro_selftest", function(ply)
	if IsValid(ply) and not ply:IsSuperAdmin() then
		return
	end

	print("[metro] running self-test against backend: " .. tostring(METRO.Storage.GetBackendName()))

	runSelfTest(function(err)
		if err then
			print("[metro] SELF-TEST FAILED: " .. err)
		else
			print("[metro] SELF-TEST PASSED")
		end
	end)
end)
