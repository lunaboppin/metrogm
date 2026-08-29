METRO.Players = METRO.Players or {}

local AUTOSAVE_INTERVAL = 120

local records = {}
local sessionStart = {}
local pendingLoad = {}
local saveQueues = {}

local function steamID64(ply)
	return ply:SteamID64()
end

local function freezeForLoading(ply)
	ply:Lock()
	ply:SetMoveType(MOVETYPE_NONE)
	ply:SetNoDraw(true)
	ply:SetNotSolid(true)
	ply:GodEnable()
end

local function releasePlayer(ply)
	ply:UnLock()
	ply:SetMoveType(MOVETYPE_WALK)
	ply:SetNoDraw(false)
	ply:SetNotSolid(false)
	ply:GodDisable()
end

local function normalizeRecord(record)
	record.money = tonumber(record.money) or 0
	record.xp = tonumber(record.xp) or 0
	record.level = METRO.Levels.LevelForXp(record.xp)
	record.playtime_seconds = tonumber(record.playtime_seconds) or 0

	local function normalizeTimestamp(value)
		local numeric = tonumber(value)
		if numeric then
			return numeric
		end

		if isstring(value) then
			local year, month, day, hour, minute, second = string.match(
				value,
				"^(%d%d%d%d)%-(%d%d?)%-(%d%d?)%s+(%d%d?):(%d%d?):(%d%d?)$"
			)

			if year then
				return os.time({
					year = tonumber(year),
					month = tonumber(month),
					day = tonumber(day),
					hour = tonumber(hour),
					min = tonumber(minute),
					sec = tonumber(second),
				})
			end
		end

		return os.time()
	end

	record.first_seen = normalizeTimestamp(record.first_seen)
	record.last_seen = normalizeTimestamp(record.last_seen)
	return record
end

local function syncPlaytime(ply, record)
	local sid = steamID64(ply)
	local start = sessionStart[sid]
	if not start then
		return
	end

	local now = os.time()
	local elapsed = now - start
	if elapsed > 0 then
		record.playtime_seconds = (tonumber(record.playtime_seconds) or 0) + elapsed
	end

	sessionStart[sid] = now
end

local function snapshotRecord(record)
	return {
		steamid64 = record.steamid64,
		name = record.name,
		money = record.money,
		xp = record.xp,
		level = record.level,
		playtime_seconds = record.playtime_seconds,
		first_seen = record.first_seen,
		last_seen = record.last_seen,
	}
end

local function processSaveQueue(steamid64)
	local state = saveQueues[steamid64]
	if not state or state.active then
		return
	end

	local item = state.items[1]
	if not item then
		saveQueues[steamid64] = nil
		return
	end

	state.active = true
	METRO.Storage.SavePlayer(item.record, function(err)
		state.active = false
		table.remove(state.items, 1)
		item.cb(err)

		if #state.items > 0 then
			processSaveQueue(steamid64)
		else
			saveQueues[steamid64] = nil
		end
	end)
end

local function queueSave(steamid64, record, cb)
	local state = saveQueues[steamid64]
	if not state then
		state = { active = false, items = {} }
		saveQueues[steamid64] = state
	end

	table.insert(state.items, {
		record = snapshotRecord(record),
		cb = cb,
	})
	processSaveQueue(steamid64)
end

function METRO.Players.Get(ply)
	if not IsValid(ply) then
		return nil
	end

	return records[steamID64(ply)]
end

function METRO.Players.IsLoaded(ply)
	return METRO.Players.Get(ply) ~= nil
end

function METRO.Players.Save(ply, cb)
	cb = cb or function() end

	if not IsValid(ply) then
		cb("player is not valid")
		return
	end

	local sid = steamID64(ply)
	local record = records[sid]
	if not record then
		cb("player record is not loaded")
		return
	end

	syncPlaytime(ply, record)
	record.last_seen = os.time()

	queueSave(sid, record, cb)
end

local function finishLoad(ply, record)
	if not IsValid(ply) then
		return
	end

	local sid = steamID64(ply)
	normalizeRecord(record)

	records[sid] = record
	sessionStart[sid] = os.time()
	pendingLoad[sid] = nil

	releasePlayer(ply)
	METRO.Network.PushLoadState(ply, "ready")
	METRO.Network.PushStats(ply)
end

local function loadPlayer(ply)
	if not IsValid(ply) then
		return
	end

	local sid = steamID64(ply)
	METRO.Storage.LoadPlayer(sid, function(loadErr, record)
		if not IsValid(ply) or not pendingLoad[sid] then
			return
		end

		if loadErr then
			METRO.Network.PushLoadState(ply, "error", tostring(loadErr))
			return
		end

		if record then
			finishLoad(ply, record)
			return
		end

		METRO.Storage.CreatePlayer(sid, ply:Name(), function(createErr, created)
			if not IsValid(ply) or not pendingLoad[sid] then
				return
			end

			if createErr then
				METRO.Network.PushLoadState(ply, "error", tostring(createErr))
				return
			end

			finishLoad(ply, created)
		end)
	end)
end

hook.Add("PlayerInitialSpawn", "MetroPlayersGatedSpawn", function(ply)
	local sid = steamID64(ply)
	pendingLoad[sid] = true

	freezeForLoading(ply)
	METRO.Network.PushLoadState(ply, "loading")

	METRO.Boot.WaitForReady(function(bootErr)
		if not IsValid(ply) or not pendingLoad[sid] then
			return
		end

		if bootErr then
			METRO.Network.PushLoadState(ply, "error", tostring(bootErr))
			return
		end

		loadPlayer(ply)
	end)
end)

hook.Add("PlayerSpawn", "MetroPlayersHoldUntilLoaded", function(ply)
	if pendingLoad[steamID64(ply)] then
		freezeForLoading(ply)
	end
end)

hook.Add("Think", "MetroPlayersEnforceHold", function()
	for _, ply in ipairs(player.GetAll()) do
		if IsValid(ply) and pendingLoad[steamID64(ply)] then
			freezeForLoading(ply)
		end
	end
end)

hook.Add("PlayerDisconnected", "MetroPlayersFinalSave", function(ply)
	local sid = steamID64(ply)
	pendingLoad[sid] = nil

	local record = records[sid]
	if not record then
		return
	end

	syncPlaytime(ply, record)
	record.last_seen = os.time()

	queueSave(sid, record, function(saveErr)
		if saveErr then
			print("[metro] failed to save player " .. sid .. " on disconnect: " .. tostring(saveErr))
		end
	end)

	records[sid] = nil
	sessionStart[sid] = nil
end)

hook.Add("ShutDown", "MetroPlayersShutdownSave", function()
	for _, ply in ipairs(player.GetAll()) do
		if METRO.Players.IsLoaded(ply) then
			METRO.Players.Save(ply, function(saveErr)
				if saveErr then
					print("[metro] failed to save player " .. steamID64(ply) .. " on shutdown: " .. tostring(saveErr))
				end
			end)
		end
	end
end)

timer.Create("MetroPlayersAutosave", AUTOSAVE_INTERVAL, 0, function()
	for _, ply in ipairs(player.GetAll()) do
		if METRO.Players.IsLoaded(ply) then
			METRO.Players.Save(ply, function(saveErr)
				if saveErr then
					print("[metro] autosave failed for " .. steamID64(ply) .. ": " .. tostring(saveErr))
				end
			end)
		end
	end
end)
