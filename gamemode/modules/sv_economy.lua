METRO.Economy = METRO.Economy or {}

local function isWholeNumber(value)
	return isnumber(value) and value == math.floor(value)
end

local function resolveActorSteamId(actor)
	if actor and IsValid(actor) then
		return actor:SteamID64()
	end
	return nil
end

local function commitMutation(ply, delta, balanceAfter, reason, actor, cb)
	METRO.Storage.LogTransaction({
		steamid64 = ply:SteamID64(),
		actor_steamid64 = resolveActorSteamId(actor),
		delta = delta,
		balance_after = balanceAfter,
		reason = reason,
	}, function(txErr)
		if txErr then
			cb("failed to write audit row: " .. tostring(txErr))
			return
		end

		METRO.Players.Save(ply, function(saveErr)
			if saveErr then
				cb("failed to persist record: " .. tostring(saveErr))
				return
			end

			METRO.Network.PushStats(ply)
			cb(nil)
		end)
	end)
end

local function getLoadedRecord(ply)
	if not METRO.Players.IsLoaded(ply) then
		return nil
	end
	return METRO.Players.Get(ply)
end

function METRO.Economy.AddMoney(ply, delta, reason, actor, cb)
	cb = cb or function() end

	if not isWholeNumber(delta) then
		cb("delta must be a whole number")
		return
	end

	local record = getLoadedRecord(ply)
	if not record then
		cb("player record has not loaded")
		return
	end

	record.money = record.money + delta
	commitMutation(ply, delta, record.money, reason, actor, cb)
end

function METRO.Economy.SetMoney(ply, amount, reason, actor, cb)
	cb = cb or function() end

	if not isWholeNumber(amount) then
		cb("amount must be a whole number")
		return
	end

	local record = getLoadedRecord(ply)
	if not record then
		cb("player record has not loaded")
		return
	end

	local delta = amount - record.money
	record.money = amount
	commitMutation(ply, delta, record.money, reason, actor, cb)
end

function METRO.Economy.AddXp(ply, delta, reason, actor, cb)
	cb = cb or function() end

	if not isWholeNumber(delta) then
		cb("delta must be a whole number")
		return
	end

	local record = getLoadedRecord(ply)
	if not record then
		cb("player record has not loaded")
		return
	end

	record.xp = record.xp + delta
	if record.xp < 0 then
		record.xp = 0
	end
	record.level = METRO.Levels.LevelForXp(record.xp)

	commitMutation(ply, delta, record.money, "xp: " .. tostring(reason), actor, cb)
end
