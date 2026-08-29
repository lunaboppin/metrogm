METRO.Admin = METRO.Admin or {}

local function feedback(ply, message)
	print("[metro] " .. message)
	if IsValid(ply) then
		ply:ChatPrint("[metro] " .. message)
	end
end

local function isAuthorized(ply)
	if IsValid(ply) and not ply:IsSuperAdmin() then
		return false
	end
	return true
end

local function resolveTarget(identifier)
	if not identifier or identifier == "" then
		return nil, "adminNoTarget"
	end

	if string.match(identifier, "^%d+$") and #identifier >= 15 then
		for _, candidate in ipairs(player.GetAll()) do
			if candidate:SteamID64() == identifier then
				return candidate
			end
		end
		return nil, "adminNoOnlinePlayerSteamID", identifier
	end

	local lowered = string.lower(identifier)
	local matches = {}
	for _, candidate in ipairs(player.GetAll()) do
		if string.find(string.lower(candidate:Name()), lowered, 1, true) then
			table.insert(matches, candidate)
		end
	end

	if #matches == 0 then
		return nil, "adminNoOnlinePlayerMatch", identifier
	end

	if #matches > 1 then
		local names = {}
		for _, candidate in ipairs(matches) do
			table.insert(names, candidate:Name())
		end
		return nil, "adminAmbiguousTarget", identifier, table.concat(names, ", ")
	end

	return matches[1]
end

local function parseWholeNumber(raw)
	if not raw then
		return nil, "adminAmountRequired"
	end

	local value = tonumber(raw)
	if not value then
		return nil, "adminAmountNotNumeric", raw
	end

	if value ~= math.floor(value) then
		return nil, "adminAmountNotWhole", raw
	end

	return value
end

local function requireLoadedTarget(commandName, identifier, ply, cb)
	local target, errKey, a1, a2 = resolveTarget(identifier)
	if not target then
		cb(nil, L("adminCommandFailed", ply, commandName, L(errKey, ply, a1, a2)))
		return nil
	end

	if not METRO.Players.IsLoaded(target) then
		cb(nil, L("adminTargetNotLoaded", ply, commandName, target:Name()))
		return nil
	end

	return target
end

concommand.Add("metro_setmoney", function(ply, _, args)
	if not isAuthorized(ply) then
		feedback(ply, L("adminDenied", ply, "metro_setmoney"))
		return
	end

	local target = requireLoadedTarget("metro_setmoney", args[1], ply, function(_, err) feedback(ply, err) end)
	if not target then
		return
	end

	local amount, errKey, errArg = parseWholeNumber(args[2])
	if not amount then
		feedback(ply, L("adminCommandFailed", ply, "metro_setmoney", L(errKey, ply, errArg)))
		return
	end

	local reason = args[3] or "admin setmoney"

	METRO.Economy.SetMoney(target, amount, reason, ply, function(err)
		if err then
			feedback(ply, L("adminCommandFailed", ply, "metro_setmoney", err))
			return
		end
		feedback(ply, L("adminSetMoneySuccess", ply, target:Name(), amount))
	end)
end)

concommand.Add("metro_addmoney", function(ply, _, args)
	if not isAuthorized(ply) then
		feedback(ply, L("adminDenied", ply, "metro_addmoney"))
		return
	end

	local target = requireLoadedTarget("metro_addmoney", args[1], ply, function(_, err) feedback(ply, err) end)
	if not target then
		return
	end

	local delta, errKey, errArg = parseWholeNumber(args[2])
	if not delta then
		feedback(ply, L("adminCommandFailed", ply, "metro_addmoney", L(errKey, ply, errArg)))
		return
	end

	local reason = args[3] or "admin addmoney"

	METRO.Economy.AddMoney(target, delta, reason, ply, function(err)
		if err then
			feedback(ply, L("adminCommandFailed", ply, "metro_addmoney", err))
			return
		end
		feedback(ply, L("adminAddMoneySuccess", ply, delta, target:Name()))
	end)
end)

concommand.Add("metro_setxp", function(ply, _, args)
	if not isAuthorized(ply) then
		feedback(ply, L("adminDenied", ply, "metro_setxp"))
		return
	end

	local target = requireLoadedTarget("metro_setxp", args[1], ply, function(_, err) feedback(ply, err) end)
	if not target then
		return
	end

	local amount, errKey, errArg = parseWholeNumber(args[2])
	if not amount then
		feedback(ply, L("adminCommandFailed", ply, "metro_setxp", L(errKey, ply, errArg)))
		return
	end

	local reason = args[3] or "admin setxp"
	local record = METRO.Players.Get(target)
	local delta = amount - record.xp

	METRO.Economy.AddXp(target, delta, reason, ply, function(err)
		if err then
			feedback(ply, L("adminCommandFailed", ply, "metro_setxp", err))
			return
		end
		feedback(ply, L("adminSetXpSuccess", ply, target:Name(), amount, record.level))
	end)
end)
