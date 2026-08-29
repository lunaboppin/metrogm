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

local function commitMutation(ply, kind, delta, balanceAfter, reason, actor, revert, cb)
	METRO.Storage.LogTransaction({
		steamid64 = ply:SteamID64(),
		actor_steamid64 = resolveActorSteamId(actor),
		delta = delta,
		balance_after = balanceAfter,
		kind = kind,
		reason = reason,
	}, function(txErr)
		if txErr then
			revert()
			cb("failed to write audit row: " .. tostring(txErr))
			return
		end

		METRO.Players.Save(ply, function(saveErr)
			if saveErr then
				revert()
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

	local previousMoney = record.money
	record.money = previousMoney + delta

	local function revert()
		record.money = previousMoney
	end

	commitMutation(ply, "money", delta, record.money, reason, actor, revert, cb)
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

	local previousMoney = record.money
	local delta = amount - previousMoney
	record.money = amount

	local function revert()
		record.money = previousMoney
	end

	commitMutation(ply, "money", delta, record.money, reason, actor, revert, cb)
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

	local previousXp = record.xp
	local previousLevel = record.level

	record.xp = previousXp + delta
	if record.xp < 0 then
		record.xp = 0
	end
	record.level = METRO.Levels.LevelForXp(record.xp)

	local appliedDelta = record.xp - previousXp

	local function revert()
		record.xp = previousXp
		record.level = previousLevel
	end

	commitMutation(ply, "xp", appliedDelta, record.xp, reason, actor, revert, cb)
end
