local function assertEqual(actual, expected, label, cb)
	if actual ~= expected then
		cb(string.format("%s mismatch: expected %s, got %s", label, tostring(expected), tostring(actual)))
		return false
	end
	return true
end

local function newSyntheticSteamId()
	return "9" .. tostring(os.time()) .. tostring(math.random(1000, 9999))
end

local mysqlVerifyDb

local function withMysqlVerifyConnection(cb)
	if mysqlVerifyDb then
		cb(nil, mysqlVerifyDb)
		return
	end

	local ok = pcall(require, "mysqloo")
	if not ok or not mysqloo then
		cb("mysqloo module not available for verification queries")
		return
	end

	local config = METRO.Config
	local db = mysqloo.connect(config.host, config.username, config.password, config.database, config.port)

	function db:onConnected()
		mysqlVerifyDb = db
		cb(nil, db)
	end

	function db:onConnectionFailed(_, err)
		cb("verification connection failed: " .. tostring(err))
	end

	db:connect()
end

local function rawQuery(sqlText, cb)
	local backendName = METRO.Storage.GetBackendName()

	if backendName == "sqlite" then
		local result = sql.Query(sqlText)
		if result == false then
			cb(sql.LastError())
			return
		end
		cb(nil, result or {})
		return
	end

	if backendName == "mysql" then
		withMysqlVerifyConnection(function(connErr, db)
			if connErr then
				cb(connErr)
				return
			end

			local query = db:query(sqlText)

			function query:onSuccess(data)
				cb(nil, data or {})
			end

			function query:onError(err)
				cb(err)
			end

			query:start()
		end)
		return
	end

	cb("unknown backend for verification query: " .. tostring(backendName))
end

local function cleanupSyntheticRows(steamids, cb)
	local remaining = #steamids
	if remaining == 0 then
		cb()
		return
	end

	for _, steamid64 in ipairs(steamids) do
		rawQuery("DELETE FROM metro_players WHERE steamid64 = '" .. steamid64 .. "'", function()
			rawQuery("DELETE FROM metro_transactions WHERE steamid64 = '" .. steamid64 .. "'", function()
				remaining = remaining - 1
				if remaining == 0 then
					cb()
				end
			end)
		end)
	end
end

local function runLevelCurveTest(cb)
	local cases = {
		{ xp = 99, expected = 1 },
		{ xp = 100, expected = 2 },
		{ xp = 299, expected = 2 },
		{ xp = 300, expected = 3 },
		{ xp = 600, expected = 4 },
	}

	for _, case in ipairs(cases) do
		local level = METRO.Levels.LevelForXp(case.xp)
		if not assertEqual(level, case.expected, "level for xp=" .. case.xp, cb) then
			return
		end
	end

	cb(nil)
end

local function runStorageRoundTripTest(cb)
	local steamid64 = newSyntheticSteamId()
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
		record.level = METRO.Levels.LevelForXp(120)
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

				if not assertEqual(tonumber(reloaded.level), METRO.Levels.LevelForXp(120), "saved level", cb) then
					return
				end

				METRO.Storage.LogTransaction({
					steamid64 = steamid64,
					actor_steamid64 = nil,
					delta = 500,
					balance_after = 500,
					reason = "selftest-roundtrip",
				}, function(txErr)
					if txErr then
						cb("LogTransaction failed: " .. tostring(txErr))
						return
					end

					rawQuery(
						"SELECT delta, balance_after, reason FROM metro_transactions WHERE steamid64 = '"
							.. steamid64 .. "' AND reason = 'selftest-roundtrip'",
						function(queryErr, rows)
							if queryErr then
								cb("audit row verification failed: " .. tostring(queryErr))
								return
							end

							if not rows or not rows[1] then
								cb("audit row verification failed: no matching metro_transactions row found")
								return
							end

							if not assertEqual(tonumber(rows[1].delta), 500, "audit row delta", cb) then
								return
							end

							if not assertEqual(tonumber(rows[1].balance_after), 500, "audit row balance_after", cb) then
								return
							end

							cb(nil, steamid64)
						end
					)
				end)
			end)
		end)
	end)
end

local function runMigrationsIdempotencyTest(cb)
	METRO.Storage.RunMigrations(function(err, result)
		if err then
			cb("re-running migrations failed: " .. tostring(err))
			return
		end

		if not result then
			cb("re-running migrations returned no result")
			return
		end

		if #result.applied > 0 then
			cb("re-running migrations against a populated database was not a no-op, applied: "
				.. table.concat(result.applied, ", "))
			return
		end

		cb(nil)
	end)
end

local function makeStubPlayer(steamid64)
	local record = { steamid64 = steamid64, name = "metro-economy-stub", money = 0, xp = 0, level = 1, playtime_seconds = 0 }
	local ply = { stubRecord = record }

	function ply:SteamID64()
		return steamid64
	end

	return ply, record
end

local function runEconomyStubTest(cb)
	local steamid64 = newSyntheticSteamId()
	local ply, record = makeStubPlayer(steamid64)

	METRO.Players = METRO.Players or {}
	METRO.Network = METRO.Network or {}

	local savedGet = METRO.Players.Get
	local savedIsLoaded = METRO.Players.IsLoaded
	local savedSave = METRO.Players.Save
	local savedPushStats = METRO.Network.PushStats

	local pushStatsCalls = 0
	local saveCalls = 0

	METRO.Players.Get = function(target)
		if target == ply then
			return record
		end
		if savedGet then
			return savedGet(target)
		end
		return nil
	end

	METRO.Players.IsLoaded = function(target)
		if target == ply then
			return true
		end
		if savedIsLoaded then
			return savedIsLoaded(target)
		end
		return false
	end

	METRO.Players.Save = function(target, saveCb)
		if target == ply then
			saveCalls = saveCalls + 1
			saveCb(nil)
			return
		end
		if savedSave then
			savedSave(target, saveCb)
			return
		end
		saveCb("no player module loaded")
	end

	METRO.Network.PushStats = function(target)
		if target == ply then
			pushStatsCalls = pushStatsCalls + 1
			return
		end
		if savedPushStats then
			savedPushStats(target)
		end
	end

	local function restore()
		METRO.Players.Get = savedGet
		METRO.Players.IsLoaded = savedIsLoaded
		METRO.Players.Save = savedSave
		METRO.Network.PushStats = savedPushStats
	end

	local unloadedPly = { }
	function unloadedPly:SteamID64() return steamid64 .. "-unloaded" end

	METRO.Economy.AddMoney(unloadedPly, 10, "should-refuse", nil, function(refuseErr)
		if not refuseErr then
			restore()
			cb("AddMoney did not refuse a mutation against an unloaded record")
			return
		end

		METRO.Economy.AddMoney(ply, 100, "selftest-stub-addmoney", nil, function(err)
			if err then
				restore()
				cb("Economy.AddMoney failed against stubbed player: " .. tostring(err))
				return
			end

			if not assertEqual(record.money, 100, "stub money after AddMoney", function(msg) restore(); cb(msg) end) then
				return
			end

			METRO.Economy.SetMoney(ply, 40, "selftest-stub-setmoney", nil, function(setErr)
				if setErr then
					restore()
					cb("Economy.SetMoney failed against stubbed player: " .. tostring(setErr))
					return
				end

				if not assertEqual(record.money, 40, "stub money after SetMoney", function(msg) restore(); cb(msg) end) then
					return
				end

				METRO.Economy.AddXp(ply, 305, "selftest-stub-addxp", nil, function(xpErr)
					if xpErr then
						restore()
						cb("Economy.AddXp failed against stubbed player: " .. tostring(xpErr))
						return
					end

					if not assertEqual(record.xp, 305, "stub xp after AddXp", function(msg) restore(); cb(msg) end) then
						return
					end

					if not assertEqual(record.level, METRO.Levels.LevelForXp(305), "stub level after AddXp", function(msg) restore(); cb(msg) end) then
						return
					end

					if saveCalls < 3 then
						restore()
						cb("Economy mutations did not call METRO.Players.Save for every mutation, got " .. saveCalls)
						return
					end

					if pushStatsCalls < 3 then
						restore()
						cb("Economy mutations did not call METRO.Network.PushStats for every mutation, got " .. pushStatsCalls)
						return
					end

					restore()

					rawQuery(
						"SELECT delta, balance_after FROM metro_transactions WHERE steamid64 = '"
							.. steamid64 .. "' AND reason = 'selftest-stub-setmoney'",
						function(queryErr, rows)
							if queryErr then
								cb("stub audit row verification failed: " .. tostring(queryErr))
								return
							end

							if not rows or not rows[1] then
								cb("stub audit row verification failed: no matching metro_transactions row for SetMoney")
								return
							end

							if not assertEqual(tonumber(rows[1].delta), -60, "stub SetMoney audit delta", cb) then
								return
							end

							if not assertEqual(tonumber(rows[1].balance_after), 40, "stub SetMoney audit balance_after", cb) then
								return
							end

							cb(nil, steamid64)
						end
					)
				end)
			end)
		end)
	end)
end

local function runSuite(cb)
	local results = {}
	local cleanupIds = {}

	local function record(name, err, steamid64)
		table.insert(results, { name = name, err = err })
		if steamid64 then
			table.insert(cleanupIds, steamid64)
		end
	end

	runLevelCurveTest(function(err)
		record("level curve boundaries", err)

		runStorageRoundTripTest(function(err, steamid64)
			record("storage round-trip and audit row", err, steamid64)

			runMigrationsIdempotencyTest(function(err)
				record("migrations idempotent on populated database", err)

				runEconomyStubTest(function(err, steamid64)
					record("economy contract against stubbed player", err, steamid64)

					cleanupSyntheticRows(cleanupIds, function()
						cb(results)
					end)
				end)
			end)
		end)
	end)
end

local function runGuardSelfTests(cb)
	METRO.Storage.RunUnavailableGuardTest(function(facadeErr)
		if facadeErr then
			print("[metro] FACADE UNAVAILABLE-GUARD TEST FAILED: " .. facadeErr)
		else
			print("[metro] FACADE UNAVAILABLE-GUARD TEST PASSED")
		end

		METRO.Backends.mysql.RunUnavailableGuardTest(function(mysqlErr)
			if mysqlErr then
				print("[metro] MYSQL UNAVAILABLE-GUARD TEST FAILED: " .. mysqlErr)
			else
				print("[metro] MYSQL UNAVAILABLE-GUARD TEST PASSED")
			end

			cb(facadeErr or mysqlErr)
		end)
	end)
end

concommand.Add("metro_selftest", function(ply)
	if IsValid(ply) and not ply:IsSuperAdmin() then
		return
	end

	print("[metro] running self-test against backend: " .. tostring(METRO.Storage.GetBackendName()))

	runSuite(function(results)
		local failures = 0

		for _, result in ipairs(results) do
			if result.err then
				failures = failures + 1
				print("[metro] SELF-TEST FAILED: " .. result.name .. ": " .. result.err)
			else
				print("[metro] SELF-TEST PASSED: " .. result.name)
			end
		end

		if failures == 0 then
			print("[metro] SELF-TEST SUMMARY: all " .. #results .. " checks passed")
		else
			print("[metro] SELF-TEST SUMMARY: " .. failures .. " of " .. #results .. " checks FAILED")
		end

		runGuardSelfTests(function() end)
	end)
end)
