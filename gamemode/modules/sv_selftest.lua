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
		cb(nil)
		return
	end

	local failures = {}
	local function addFailure(steamid64, tableName, err)
		if err then
			table.insert(failures, tableName .. " cleanup for " .. steamid64 .. " failed: " .. tostring(err))
		end
	end

	for _, steamid64 in ipairs(steamids) do
		rawQuery("DELETE FROM metro_transactions WHERE steamid64 = '" .. steamid64 .. "'", function(transactionErr)
			addFailure(steamid64, "transaction", transactionErr)
			rawQuery("DELETE FROM metro_players WHERE steamid64 = '" .. steamid64 .. "'", function(playerErr)
				addFailure(steamid64, "player", playerErr)
				remaining = remaining - 1
				if remaining == 0 then
					if #failures > 0 then
						cb(table.concat(failures, "; "))
						return
					end
					cb(nil)
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

local function runIntegerPrecisionTest(cb)
	local high = "9007199254740993"
	local highPlusOne = "9007199254740994"
	local highMinusOne = "9007199254740992"

	if not assertEqual(METRO.Integer.Normalize(high), high, "BIGINT normalization above 2^53", cb) then
		return
	end
	if not assertEqual(METRO.Integer.Add(high, "1"), highPlusOne, "BIGINT addition above 2^53", cb) then
		return
	end
	if not assertEqual(METRO.Integer.Subtract(high, "1"), highMinusOne, "BIGINT subtraction above 2^53", cb) then
		return
	end
	if not assertEqual(METRO.Integer.Compare(highPlusOne, high) > 0, true, "BIGINT comparison above 2^53", cb) then
		return
	end
	if not assertEqual(METRO.Integer.Normalize("9223372036854775808"), nil, "BIGINT positive overflow rejection", cb) then
		return
	end
	if not assertEqual(METRO.Integer.Normalize("-9223372036854775809"), nil, "BIGINT negative overflow rejection", cb) then
		return
	end
	if not assertEqual(METRO.Levels.LevelForXp(high), METRO.Levels.GetMaxLevel(), "level for BIGINT XP", cb) then
		return
	end

	cb(nil)
end

local function runPlayerVarRegistryTest(cb)
	local expected = {
		name = { storage = true, networking = true },
		money = { storage = true, networking = true },
		xp = { storage = true, networking = true },
		level = { storage = true, networking = true },
		playtime_seconds = { storage = true, networking = true },
		first_seen = { storage = true, networking = true },
		last_seen = { storage = true, networking = false },
	}

	for name, expectation in pairs(expected) do
		local variable = METRO.Players.GetVarDefinition(name)
		if not variable then
			cb("missing registered player variable: " .. name)
			return
		end

		if not assertEqual(variable.storage, expectation.storage, name .. " storage registration", cb) then
			return
		end

		if not assertEqual(not variable.bNoNetworking, expectation.networking, name .. " networking registration", cb) then
			return
		end
	end

	local record = METRO.Players.DefaultRecord()
	record.steamid64 = "registry-test"
	record.money = "73"
	record.xp = "305"
	record.level = METRO.Levels.LevelForXp(record.xp)

	if not assertEqual(METRO.Players.GetMoney(record), "73", "generated money getter", cb) then
		return
	end

	if not assertEqual(METRO.Players.GetXp(record), "305", "generated xp getter", cb) then
		return
	end

	if not assertEqual(METRO.Players.GetLevel(record), METRO.Levels.LevelForXp(record.xp), "generated level getter", cb) then
		return
	end

	cb(nil)
end

local function runStorageRoundTripTest(cb)
	local steamid64 = newSyntheticSteamId()
	local name = "metro-selftest"
	local function fail(message)
		cb(message, steamid64)
	end

	METRO.Storage.CreatePlayer(steamid64, name, function(err, record)
		if err then
			fail("CreatePlayer failed: " .. tostring(err))
			return
		end
		if not record then
			fail("CreatePlayer returned no record")
			return
		end

		if not assertEqual(METRO.Integer.Normalize(record.money), "0", "initial money", fail) then
			return
		end

		record.money = "9007199254740993"
		record.xp = "9007199254740993"
		record.level = METRO.Levels.LevelForXp(record.xp)
		record.playtime_seconds = "9007199254740993"

		METRO.Storage.SavePlayer(record, function(saveErr)
			if saveErr then
				fail("SavePlayer failed: " .. tostring(saveErr))
				return
			end

			METRO.Storage.LoadPlayer(steamid64, function(loadErr, reloaded)
				if loadErr then
					fail("LoadPlayer failed: " .. tostring(loadErr))
					return
				end

				if not reloaded then
					fail("LoadPlayer returned no record after save")
					return
				end

				if not assertEqual(METRO.Integer.Normalize(METRO.Players.GetMoney(reloaded)), "9007199254740993", "saved money", fail) then
					return
				end

				if not assertEqual(METRO.Integer.Normalize(METRO.Players.GetXp(reloaded)), "9007199254740993", "saved xp", fail) then
					return
				end

				if not assertEqual(METRO.Players.GetLevel(reloaded), METRO.Levels.GetMaxLevel(), "saved level", fail) then
					return
				end

				if not assertEqual(METRO.Integer.Normalize(METRO.Players.GetVar(reloaded, "playtime_seconds")), "9007199254740993", "saved playtime", fail) then
					return
				end

				METRO.Storage.LogTransaction({
					steamid64 = steamid64,
					actor_steamid64 = nil,
					delta = "9007199254740993",
					balance_after = "9007199254740993",
					kind = "money",
					reason = "selftest-roundtrip",
				}, function(txErr)
					if txErr then
						fail("LogTransaction failed: " .. tostring(txErr))
						return
					end

					rawQuery(
						"SELECT delta, balance_after, kind, reason FROM metro_transactions WHERE steamid64 = '"
						.. steamid64 .. "' AND reason = 'selftest-roundtrip'",
						function(queryErr, rows)
							if queryErr then
								fail("audit row verification failed: " .. tostring(queryErr))
								return
							end

							if not rows or not rows[1] then
								fail("audit row verification failed: no matching metro_transactions row found")
								return
							end

							if not assertEqual(METRO.Integer.Normalize(rows[1].delta), "9007199254740993", "audit row delta", fail) then
								return
							end

							if not assertEqual(METRO.Integer.Normalize(rows[1].balance_after), "9007199254740993", "audit row balance_after", fail) then
								return
							end

							if not assertEqual(rows[1].kind, "money", "audit row kind", fail) then
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
	local record = { steamid64 = steamid64, name = "metro-economy-stub", money = "0", xp = "0", level = 1, playtime_seconds = "0" }
	local ply = { stubRecord = record }

	function ply:SteamID64()
		return steamid64
	end

	return ply, record
end

local function runEconomyStubTest(cb)
	local steamid64 = newSyntheticSteamId()
	local ply, record = makeStubPlayer(steamid64)
	local function fail(message)
		cb(message, steamid64)
	end

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
			fail("AddMoney did not refuse a mutation against an unloaded record")
			return
		end

		METRO.Economy.AddMoney(ply, 100, "selftest-stub-addmoney", nil, function(err)
			if err then
				restore()
				fail("Economy.AddMoney failed against stubbed player: " .. tostring(err))
				return
			end

			if not assertEqual(record.money, "100", "stub money after AddMoney", function(msg) restore(); fail(msg) end) then
				return
			end

			METRO.Economy.SetMoney(ply, "9007199254740993", "selftest-stub-setmoney", nil, function(setErr)
				if setErr then
					restore()
					fail("Economy.SetMoney failed against stubbed player: " .. tostring(setErr))
					return
				end

				if not assertEqual(record.money, "9007199254740993", "stub money after SetMoney", function(msg) restore(); fail(msg) end) then
					return
				end

				METRO.Economy.AddXp(ply, "9007199254740993", "selftest-stub-addxp", nil, function(xpErr)
					if xpErr then
						restore()
						fail("Economy.AddXp failed against stubbed player: " .. tostring(xpErr))
						return
					end

					if not assertEqual(record.xp, "9007199254740993", "stub xp after AddXp", function(msg) restore(); fail(msg) end) then
						return
					end

					if not assertEqual(record.level, METRO.Levels.GetMaxLevel(), "stub level after AddXp", function(msg) restore(); fail(msg) end) then
						return
					end

					if saveCalls < 3 then
						restore()
						fail("Economy mutations did not call METRO.Players.Save for every mutation, got " .. saveCalls)
						return
					end

					if pushStatsCalls < 3 then
						restore()
						fail("Economy mutations did not call METRO.Network.PushStats for every mutation, got " .. pushStatsCalls)
						return
					end

					restore()

					rawQuery(
						"SELECT delta, balance_after, kind FROM metro_transactions WHERE steamid64 = '"
						.. steamid64 .. "' AND reason = 'selftest-stub-setmoney'",
						function(queryErr, rows)
							if queryErr then
								fail("stub audit row verification failed: " .. tostring(queryErr))
								return
							end

							if not rows or not rows[1] then
								fail("stub audit row verification failed: no matching metro_transactions row for SetMoney")
								return
							end

							if not assertEqual(METRO.Integer.Normalize(rows[1].delta), "9007199254740893", "stub SetMoney audit delta", fail) then
								return
							end

							if not assertEqual(METRO.Integer.Normalize(rows[1].balance_after), "9007199254740993", "stub SetMoney audit balance_after", fail) then
								return
							end

							if not assertEqual(rows[1].kind, "money", "stub SetMoney audit kind", fail) then
								return
							end

							rawQuery(
								"SELECT delta, balance_after, kind FROM metro_transactions WHERE steamid64 = '"
								.. steamid64 .. "' AND reason = 'selftest-stub-addxp'",
								function(xpQueryErr, xpRows)
									if xpQueryErr then
										fail("stub xp audit row verification failed: " .. tostring(xpQueryErr))
										return
									end

									if not xpRows or not xpRows[1] then
										fail("stub xp audit row verification failed: no matching metro_transactions row for AddXp")
										return
									end

									if not assertEqual(METRO.Integer.Normalize(xpRows[1].delta), "9007199254740993", "stub AddXp audit delta", fail) then
										return
									end

									if not assertEqual(METRO.Integer.Normalize(xpRows[1].balance_after), "9007199254740993", "stub AddXp audit balance_after", fail) then
										return
									end

									if not assertEqual(xpRows[1].kind, "xp", "stub AddXp audit kind", fail) then
										return
									end

									cb(nil, steamid64)
								end
							)
						end
					)
				end)
			end)
		end)
	end)
end

local function runRollbackTest(cb)
	local steamid64 = newSyntheticSteamId()
	local ply, record = makeStubPlayer(steamid64)

	METRO.Players = METRO.Players or {}
	METRO.Network = METRO.Network or {}
	METRO.Storage = METRO.Storage or {}

	local savedGet = METRO.Players.Get
	local savedIsLoaded = METRO.Players.IsLoaded
	local savedSave = METRO.Players.Save
	local savedPushStats = METRO.Network.PushStats
	local savedLogTransaction = METRO.Storage.LogTransaction

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
			return
		end
		if savedPushStats then
			savedPushStats(target)
		end
	end

	METRO.Storage.LogTransaction = function(_, txCb)
		txCb("forced failure for rollback test")
	end

	local function restore()
		METRO.Players.Get = savedGet
		METRO.Players.IsLoaded = savedIsLoaded
		METRO.Players.Save = savedSave
		METRO.Network.PushStats = savedPushStats
		METRO.Storage.LogTransaction = savedLogTransaction
	end

	record.money = "250"
	record.xp = "120"
	record.level = METRO.Levels.LevelForXp(120)

	METRO.Economy.AddMoney(ply, 75, "rollback-test-addmoney", nil, function(addErr)
		if not addErr then
			restore()
			cb("AddMoney did not report the forced audit-write failure")
			return
		end

		if not assertEqual(record.money, "250", "money unchanged after failed AddMoney", function(msg) restore(); cb(msg) end) then
			return
		end

		METRO.Economy.SetMoney(ply, 999, "rollback-test-setmoney", nil, function(setErr)
			if not setErr then
				restore()
				cb("SetMoney did not report the forced audit-write failure")
				return
			end

			if not assertEqual(record.money, "250", "money unchanged after failed SetMoney", function(msg) restore(); cb(msg) end) then
				return
			end

			METRO.Economy.AddXp(ply, 50, "rollback-test-addxp", nil, function(xpErr)
				if not xpErr then
					restore()
					cb("AddXp did not report the forced audit-write failure")
					return
				end

				if not assertEqual(record.xp, "120", "xp unchanged after failed AddXp", function(msg) restore(); cb(msg) end) then
					return
				end

				if not assertEqual(record.level, METRO.Levels.LevelForXp(120), "level unchanged after failed AddXp", function(msg) restore(); cb(msg) end) then
					return
				end

				restore()

				if saveCalls > 0 then
					cb("Players.Save was called despite every mutation's audit write failing, got " .. saveCalls .. " calls")
					return
				end

				cb(nil)
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

		runIntegerPrecisionTest(function(err)
			record("BIGINT precision and arithmetic", err)

			runPlayerVarRegistryTest(function(err)
				record("player variable registry and generated accessors", err)

				runStorageRoundTripTest(function(err, steamid64)
					record("storage round-trip and audit row", err, steamid64)

					runMigrationsIdempotencyTest(function(err)
					record("migrations idempotent on populated database", err)

						runEconomyStubTest(function(err, steamid64)
						record("economy contract against stubbed player", err, steamid64)

							runRollbackTest(function(err)
							record("failed audit write leaves record unchanged", err)

								cleanupSyntheticRows(cleanupIds, function(cleanupErr)
									record("synthetic data cleanup", cleanupErr)
									cb(results)
								end)
							end)
						end)
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
