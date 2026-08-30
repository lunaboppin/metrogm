METRO.Railmap = METRO.Railmap or {}

local SIGNAL_CLASS = "gmod_track_signal"
local requestTimes = {}

util.AddNetworkString("MetroRailmapRoutes")
util.AddNetworkString("MetroRailmapOpen")
util.AddNetworkString("MetroRailmapClose")

local function playerKey(ply)
	return ply:SteamID64()
end

local function allowedRequest(ply, action)
	local now = CurTime()
	local key = playerKey(ply) .. "/" .. action
	if requestTimes[key] and requestTimes[key] > now - 0.5 then
		return false
	end

	requestTimes[key] = now
	return true
end

hook.Add("PlayerDisconnected", "MetroRailmapCleanup", function(ply)
	local prefix = playerKey(ply) .. "/"
	for key in pairs(requestTimes) do
		if string.sub(key, 1, #prefix) == prefix then
			requestTimes[key] = nil
		end
	end
end)

local function resolveSignal(index)
	local entity = Entity(index)
	if not IsValid(entity) or entity:GetClass() ~= SIGNAL_CLASS then
		return nil
	end

	if type(entity.Routes) ~= "table" or #entity.Routes == 0 then
		return nil
	end

	return entity
end

local function resolveRouteIndex(entity, routeName, fallbackToLast)
	if routeName and routeName ~= "" then
		local upper = string.upper(routeName)
		for index, route in ipairs(entity.Routes) do
			if route.RouteName and string.upper(route.RouteName) == upper then
				return index
			end
		end
		return nil
	end

	if #entity.Routes == 1 then
		return 1
	end

	if fallbackToLast and entity.LastOpenedRoute and entity.Routes[entity.LastOpenedRoute] then
		return entity.LastOpenedRoute
	end

	return nil
end

local function routeSuffix(entity, routeIndex)
	local route = entity.Routes[routeIndex]
	if route.RouteName and route.RouteName ~= "" then
		return " (route " .. route.RouteName .. ")"
	end
	return ""
end

local function logAction(ply, action, entity, routeIndex)
	local route = entity.Routes[routeIndex]
	print(string.format(
		"[metro] railmap %s by %s (%s) signal=%s route=%s dest=%s",
		action,
		ply:Name(),
		ply:SteamID64(),
		entity.Name or "?",
		route.RouteName or tostring(routeIndex),
		route.NextSignal or ""
	))
end

local function sendRoutes(ply, index, entity)
	net.Start("MetroRailmapRoutes")
	net.WriteUInt(index, 16)
	net.WriteBool(entity ~= nil)
	if entity then
		local count = math.min(#entity.Routes, 255)
		net.WriteUInt(count, 8)
		for routeIndex = 1, count do
			local route = entity.Routes[routeIndex]
			net.WriteUInt(routeIndex, 8)
			net.WriteString(route.RouteName or "")
			net.WriteString(route.NextSignal or "")
		end
	end
	net.Send(ply)
end

function METRO.Railmap.HandleRoutesRequest(ply, index)
	if not IsValid(ply) or not ply:IsAdmin() or not allowedRequest(ply, "routes") then
		return
	end

	sendRoutes(ply, index, resolveSignal(index))
end

function METRO.Railmap.HandleOpen(ply, index, routeName)
	if not IsValid(ply) or not ply:IsAdmin() or not allowedRequest(ply, "open") then
		return
	end

	local entity = resolveSignal(index)
	if not entity then
		ply:NotifyLocalized("railmapInvalidSignal")
		return
	end

	local routeIndex = resolveRouteIndex(entity, routeName, false)
	if not routeIndex then
		ply:NotifyLocalized("railmapRouteUnknown", entity.Name or "")
		return
	end

	entity:OpenRoute(routeIndex)
	logAction(ply, "open", entity, routeIndex)
	ply:NotifyLocalized("railmapSignalOpened", entity.Name or "", routeSuffix(entity, routeIndex))
end

function METRO.Railmap.HandleClose(ply, index, routeName)
	if not IsValid(ply) or not ply:IsAdmin() or not allowedRequest(ply, "close") then
		return
	end

	local entity = resolveSignal(index)
	if not entity then
		ply:NotifyLocalized("railmapInvalidSignal")
		return
	end

	local routeIndex = resolveRouteIndex(entity, routeName, true)
	if not routeIndex then
		ply:NotifyLocalized("railmapRouteUnknown", entity.Name or "")
		return
	end

	entity:CloseRoute(routeIndex)
	logAction(ply, "close", entity, routeIndex)
	ply:NotifyLocalized("railmapSignalClosed", entity.Name or "", routeSuffix(entity, routeIndex))
end

net.Receive("MetroRailmapRoutes", function(_, ply)
	local index = net.ReadUInt(16)
	METRO.Railmap.HandleRoutesRequest(ply, index)
end)

net.Receive("MetroRailmapOpen", function(_, ply)
	local index = net.ReadUInt(16)
	local routeName = net.ReadString()
	METRO.Railmap.HandleOpen(ply, index, routeName)
end)

net.Receive("MetroRailmapClose", function(_, ply)
	local index = net.ReadUInt(16)
	local routeName = net.ReadString()
	METRO.Railmap.HandleClose(ply, index, routeName)
end)
