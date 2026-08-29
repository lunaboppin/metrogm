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
		return nil, "no target specified"
	end

	if string.match(identifier, "^%d+$") and #identifier >= 15 then
		for _, candidate in ipairs(player.GetAll()) do
			if candidate:SteamID64() == identifier then
				return candidate
			end
		end
		return nil, "no online player with SteamID64 " .. identifier
	end

	local lowered = string.lower(identifier)
	local matches = {}
	for _, candidate in ipairs(player.GetAll()) do
		if string.find(string.lower(candidate:Name()), lowered, 1, true) then
			table.insert(matches, candidate)
		end
	end

	if #matches == 0 then
		return nil, "no online player matching '" .. identifier .. "'"
	end

	if #matches > 1 then
		local names = {}
		for _, candidate in ipairs(matches) do
			table.insert(names, candidate:Name())
		end
		return nil, "'" .. identifier .. "' is ambiguous, matches: " .. table.concat(names, ", ")
	end

	return matches[1]
end

local function parseWholeNumber(raw)
	if not raw then
		return nil, "amount is required"
	end

	local value = tonumber(raw)
	if not value then
		return nil, "'" .. raw .. "' is not a numeric amount"
	end

	if value ~= math.floor(value) then
		return nil, "'" .. raw .. "' must be a whole number, fractional amounts are not allowed"
	end

	return value
end

local function requireLoadedTarget(commandName, identifier, cb)
	local target, resolveErr = resolveTarget(identifier)
	if not target then
		cb(nil, commandName .. " failed: " .. resolveErr)
		return nil
	end

	if not METRO.Players.IsLoaded(target) then
		cb(nil, commandName .. " failed: " .. target:Name() .. "'s record has not loaded yet")
		return nil
	end

	return target
end

concommand.Add("metro_setmoney", function(ply, _, args)
	if not isAuthorized(ply) then
		feedback(ply, "metro_setmoney denied: super admin required")
		return
	end

	local target = requireLoadedTarget("metro_setmoney", args[1], function(_, err) feedback(ply, err) end)
	if not target then
		return
	end

	local amount, amountErr = parseWholeNumber(args[2])
	if not amount then
		feedback(ply, "metro_setmoney failed: " .. amountErr)
		return
	end

	local reason = args[3] or "admin setmoney"

	METRO.Economy.SetMoney(target, amount, reason, ply, function(err)
		if err then
			feedback(ply, "metro_setmoney failed: " .. err)
			return
		end
		feedback(ply, "set " .. target:Name() .. "'s money to " .. amount)
	end)
end)

concommand.Add("metro_addmoney", function(ply, _, args)
	if not isAuthorized(ply) then
		feedback(ply, "metro_addmoney denied: super admin required")
		return
	end

	local target = requireLoadedTarget("metro_addmoney", args[1], function(_, err) feedback(ply, err) end)
	if not target then
		return
	end

	local delta, deltaErr = parseWholeNumber(args[2])
	if not delta then
		feedback(ply, "metro_addmoney failed: " .. deltaErr)
		return
	end

	local reason = args[3] or "admin addmoney"

	METRO.Economy.AddMoney(target, delta, reason, ply, function(err)
		if err then
			feedback(ply, "metro_addmoney failed: " .. err)
			return
		end
		feedback(ply, "added " .. delta .. " money to " .. target:Name())
	end)
end)

concommand.Add("metro_setxp", function(ply, _, args)
	if not isAuthorized(ply) then
		feedback(ply, "metro_setxp denied: super admin required")
		return
	end

	local target = requireLoadedTarget("metro_setxp", args[1], function(_, err) feedback(ply, err) end)
	if not target then
		return
	end

	local amount, amountErr = parseWholeNumber(args[2])
	if not amount then
		feedback(ply, "metro_setxp failed: " .. amountErr)
		return
	end

	local reason = args[3] or "admin setxp"
	local record = METRO.Players.Get(target)
	local delta = amount - record.xp

	METRO.Economy.AddXp(target, delta, reason, ply, function(err)
		if err then
			feedback(ply, "metro_setxp failed: " .. err)
			return
		end
		feedback(ply, "set " .. target:Name() .. "'s xp to " .. amount .. " (level " .. record.level .. ")")
	end)
end)
