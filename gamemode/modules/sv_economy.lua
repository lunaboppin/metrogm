METRO.Economy = METRO.Economy or {}

local function normalizeInteger(value)
	return METRO.Integer.Normalize(value)
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

	delta = normalizeInteger(delta)
	if not delta then
		cb("delta must be a whole number")
		return
	end

	local record = getLoadedRecord(ply)
	if not record then
		cb("player record has not loaded")
		return
	end

	local previousMoney = METRO.Integer.Normalize(record.money) or "0"
	local newMoney = METRO.Integer.Add(previousMoney, delta)
	if not newMoney then
		cb("money exceeds BIGINT range")
		return
	end
	record.money = newMoney

	local function revert()
		record.money = previousMoney
	end

	commitMutation(ply, "money", delta, record.money, reason, actor, revert, cb)
end

function METRO.Economy.SetMoney(ply, amount, reason, actor, cb)
	cb = cb or function() end

	amount = normalizeInteger(amount)
	if not amount then
		cb("amount must be a whole number")
		return
	end

	local record = getLoadedRecord(ply)
	if not record then
		cb("player record has not loaded")
		return
	end

	local previousMoney = METRO.Integer.Normalize(record.money) or "0"
	local delta = METRO.Integer.Subtract(amount, previousMoney)
	if not delta then
		cb("money exceeds BIGINT range")
		return
	end
	record.money = amount

	local function revert()
		record.money = previousMoney
	end

	commitMutation(ply, "money", delta, record.money, reason, actor, revert, cb)
end

function METRO.Economy.AddXp(ply, delta, reason, actor, cb)
	cb = cb or function() end

	delta = normalizeInteger(delta)
	if not delta then
		cb("delta must be a whole number")
		return
	end

	local record = getLoadedRecord(ply)
	if not record then
		cb("player record has not loaded")
		return
	end

	local previousXp = METRO.Integer.Normalize(record.xp) or "0"
	local previousLevel = record.level

	local newXp = METRO.Integer.Add(previousXp, delta)
	if not newXp then
		cb("xp exceeds BIGINT range")
		return
	end
	if METRO.Integer.Compare(newXp, "0") < 0 then
		newXp = "0"
	end
	record.xp = newXp
	record.level = METRO.Levels.LevelForXp(record.xp)

	local appliedDelta = METRO.Integer.Subtract(record.xp, previousXp)

	local function revert()
		record.xp = previousXp
		record.level = previousLevel
	end

	commitMutation(ply, "xp", appliedDelta, record.xp, reason, actor, revert, cb)
end

function METRO.Economy.SetXp(ply, amount, reason, actor, cb)
	cb = cb or function() end

	amount = normalizeInteger(amount)
	if not amount then
		cb("amount must be a whole number")
		return
	end

	local record = getLoadedRecord(ply)
	if not record then
		cb("player record has not loaded")
		return
	end

	local previousXp = METRO.Integer.Normalize(record.xp) or "0"
	local previousLevel = record.level
	local newXp = METRO.Integer.Compare(amount, "0") < 0 and "0" or amount
	record.xp = newXp
	record.level = METRO.Levels.LevelForXp(newXp)

	local function revert()
		record.xp = previousXp
		record.level = previousLevel
	end

	commitMutation(ply, "xp", METRO.Integer.Subtract(newXp, previousXp), newXp, reason, actor, revert, cb)
end
