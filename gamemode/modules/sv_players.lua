METRO.Players = METRO.Players or {}

local AUTOSAVE_INTERVAL = 120

local records = {}
local sessionStart = {}

local function steamID64(ply)
	return ply:SteamID64()
end

local function freezeForLoading(ply)
	ply:Lock()
	ply:SetNoDraw(true)
	ply:SetNotSolid(true)
	ply:GodEnable()
end

local function releasePlayer(ply)
	ply:UnLock()
	ply:SetNoDraw(false)
	ply:SetNotSolid(false)
	ply:GodDisable()
end

local function normalizeRecord(record)
	record.money = tonumber(record.money) or 0
	record.xp = tonumber(record.xp) or 0
	record.level = tonumber(record.level) or 1
	record.playtime_seconds = tonumber(record.playtime_seconds) or 0
	record.first_seen = tonumber(record.first_seen) or os.time()
	record.last_seen = tonumber(record.last_seen) or os.time()
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

	METRO.Storage.SavePlayer(record, cb)
end

local function finishLoad(ply, record)
	if not IsValid(ply) then
		return
	end

	local sid = steamID64(ply)
	normalizeRecord(record)

	records[sid] = record
	sessionStart[sid] = os.time()

	releasePlayer(ply)
	METRO.Network.PushLoadState(ply, "ready")
	METRO.Network.PushStats(ply)
end

hook.Add("PlayerInitialSpawn", "MetroPlayersGatedSpawn", function(ply)
	freezeForLoading(ply)
	METRO.Network.PushLoadState(ply, "loading")

	local sid = steamID64(ply)

	METRO.Storage.LoadPlayer(sid, function(loadErr, record)
		if not IsValid(ply) then
			return
		end

		if loadErr then
			METRO.Network.PushLoadState(ply, "error", loadErr)
			return
		end

		if record then
			finishLoad(ply, record)
			return
		end

		METRO.Storage.CreatePlayer(sid, ply:Name(), function(createErr, created)
			if not IsValid(ply) then
				return
			end

			if createErr then
				METRO.Network.PushLoadState(ply, "error", createErr)
				return
			end

			finishLoad(ply, created)
		end)
	end)
end)

hook.Add("PlayerDisconnected", "MetroPlayersFinalSave", function(ply)
	local sid = steamID64(ply)
	local record = records[sid]
	if not record then
		return
	end

	syncPlaytime(ply, record)
	record.last_seen = os.time()

	METRO.Storage.SavePlayer(record, function(saveErr)
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
