METRO.Service = METRO.Service or {}

local DATA_DIRECTORY = "metro/depots"
local DEFAULT_DEPOT = "depot"
local WAGON_COUNT = 3
local sessions = {}
local requestTimes = {}

util.AddNetworkString("MetroServiceStart")
util.AddNetworkString("MetroServiceFleetRequest")
util.AddNetworkString("MetroServiceFleet")
util.AddNetworkString("MetroServiceSpawn")
util.AddNetworkString("MetroServiceResult")
util.AddNetworkString("MetroDepotList")
util.AddNetworkString("MetroDepotListRequest")
util.AddNetworkString("MetroDepotManage")

local function playerKey(ply)
	return ply:SteamID64()
end

local function validName(name)
	if type(name) ~= "string" then
		return nil
	end

	name = string.lower(name)
	if not string.match(name, "^[a-z0-9_-]+$") or #name > 32 then
		return nil
	end

	return name
end

local function mapPath()
	local map = string.gsub(game.GetMap(), "[^a-zA-Z0-9_-]", "_")
	return DATA_DIRECTORY .. "/" .. map .. ".json"
end

local function readDepots()
	local raw = file.Read(mapPath(), "DATA")
	if not raw or raw == "" then
		return {}
	end

	local depots = util.JSONToTable(raw)
	if type(depots) ~= "table" then
		return {}
	end

	for name, depot in pairs(depots) do
		if type(depot) == "table" then
			if depot.position and not depot.default then
				depots[name] = {
					label = depot.label or name,
					default = {
						position = depot.position,
						forward = depot.forward,
						up = depot.up,
					},
					placements = {},
				}
			else
				depot.label = depot.label or name
				depot.placements = type(depot.placements) == "table" and depot.placements or {}
			end
		end
	end

	return depots
end

local function writeDepots(depots)
	file.CreateDir(DATA_DIRECTORY)
	file.Write(mapPath(), util.TableToJSON(depots, true))
end

local function vectorTable(vector)
	return { x = vector.x, y = vector.y, z = vector.z }
end

local function tableVector(value)
	if type(value) ~= "table" then
		return nil
	end

	local x, y, z = tonumber(value.x), tonumber(value.y), tonumber(value.z)
	if not x or not y or not z then
		return nil
	end

	return Vector(x, y, z)
end

local function result(ply, action, success, message, className)
	if not IsValid(ply) then
		return
	end

	net.Start("MetroServiceResult")
	net.WriteString(action)
	net.WriteBool(success)
	net.WriteString(message or "")
	net.WriteString(className or "")
	net.Send(ply)
end

local function allowedRequest(ply, action)
	local now = CurTime()
	local key = playerKey(ply) .. "/" .. (action or "default")
	if requestTimes[key] and requestTimes[key] > now - 0.5 then
		return false
	end

	requestTimes[key] = now
	return true
end

local function forgetRequests(ply)
	local prefix = playerKey(ply) .. "/"
	for key in pairs(requestTimes) do
		if string.sub(key, 1, #prefix) == prefix then
			requestTimes[key] = nil
		end
	end
end

local function resolveDepot(name)
	local depots = readDepots()
	local depot = depots[name]
	if not depot then
		local names = {}
		for depotName in pairs(depots) do
			table.insert(names, depotName)
		end
		table.sort(names)
		depot = depots[names[1]]
	end

	return depot
end

function METRO.Service.ResolvePlacement(name, className)
	local depot = resolveDepot(name)
	if type(depot) ~= "table" then
		return nil
	end

	local placement = className and type(depot.placements) == "table" and depot.placements[className]
	return placement or depot.default
end

local function depotTrace(name, className)
	local placement = METRO.Service.ResolvePlacement(name, className)
	if type(placement) ~= "table" then
		return nil
	end

	local position = tableVector(placement.position)
	local forward = tableVector(placement.forward)
	local up = tableVector(placement.up)
	if not position or not forward or not up or not Metrostroi or not Metrostroi.RerailGetTrackData then
		return nil
	end

	local track = Metrostroi.RerailGetTrackData(position, forward)
	if not track then
		return nil
	end

	local trackForward = track.forward or forward
	local trackUp = track.up or up

	return {
		Hit = true,
		HitPos = track.centerpos,
		HitNormal = trackUp,
		StartPos = track.centerpos - trackForward * 128,
		Normal = trackForward,
	}
end

local function settingDefaults(definition)
	local settings = {
		Train = definition.ClassName,
		WagNum = WAGON_COUNT,
		AutoCouple = true,
		SpawnMode = 1,
	}

	for _, setting in ipairs(definition.Spawner or {}) do
		if setting[3] == "List" then
			local default = setting[5]
			if default == nil and type(setting[4]) == "table" then
				default = #setting[4] > 0 and 1 or next(setting[4])
			end
			settings[setting[1]] = default
		elseif setting[3] == "Boolean" then
			settings[setting[1]] = setting[4]
		elseif setting[3] == "Slider" then
			settings[setting[1]] = setting[7]
		end
	end

	return settings
end

local function ownedWagons(ply)
	local wagons = {}
	for _, entity in ipairs(ents.GetAll()) do
		if METRO.Trains.ResolveClass(entity:GetClass()) then
			local owner = entity.CPPIGetOwner and entity:CPPIGetOwner() or entity.Owner
			if owner == ply then
				if entity.UpdateWagonList then
					entity:UpdateWagonList()
				end
				for _, wagon in ipairs(entity.WagonList or { entity }) do
					wagons[wagon] = true
				end
			end
		end
	end
	return wagons
end

local function removeWagons(wagons)
	for wagon in pairs(wagons) do
		if IsValid(wagon) then
			wagon:Remove()
		end
	end
end

local function sendFleet(ply)
	local fleet = METRO.Trains.GetFleet()
	net.Start("MetroServiceFleet")
	net.WriteUInt(#fleet, 16)
	for _, train in ipairs(fleet) do
		local permitted, reason = METRO.Trains.CanSpawn(ply, train.className)
		local status = permitted and "available" or (train.configured and "locked" or "comingSoon")
		net.WriteString(train.className)
		net.WriteString(train.displayName)
		net.WriteString(status)
		net.WriteString(reason or "")
		net.WriteUInt(train.requiredLevel or 0, 8)
	end
	net.Send(ply)
end

hook.Add("MetroPlayerReady", "MetroServiceSessionGate", function(ply)
	sessions[playerKey(ply)] = { started = false }
	return true
end)

hook.Add("PlayerDisconnected", "MetroServiceSessionCleanup", function(ply)
	sessions[playerKey(ply)] = nil
	forgetRequests(ply)
	requestTimes[playerKey(ply)] = nil
end)

hook.Add("PlayerSpawn", "MetroServiceRespawnGate", function(ply)
	local session = sessions[playerKey(ply)]
	if session and not session.started then
		METRO.Players.Hold(ply)
	end
end)

net.Receive("MetroServiceStart", function(_, ply)
	if not allowedRequest(ply, "start") or not METRO.Players.IsLoaded(ply) then
		return
	end

	local session = sessions[playerKey(ply)]
	if not session then
		return
	end

	session.started = true
	METRO.Players.Release(ply)
	result(ply, "start", true)
end)

net.Receive("MetroServiceFleetRequest", function(_, ply)
	if allowedRequest(ply, "fleet") and METRO.Players.IsLoaded(ply) then
		sendFleet(ply)
	end
end)

net.Receive("MetroServiceSpawn", function(_, ply)
	if not allowedRequest(ply, "spawn") or not METRO.Players.IsLoaded(ply) then
		return
	end

	local session = sessions[playerKey(ply)]
	local className = net.ReadString()
	if not session or not session.started or session.spawning then
		result(ply, "spawn", false, "serviceStartRequired")
		return
	end

	local allowed, reason = METRO.Trains.CanSpawn(ply, className)
	local canonicalClass = METRO.Trains.ResolveClass(className)
	if not allowed or not canonicalClass then
		result(ply, "spawn", false, reason or "trainUnavailable")
		return
	end
	session.spawning = true
	local function fail(message, trains)
		if trains then
			removeWagons(trains)
		end
		session.spawning = false
		result(ply, "spawn", false, message)
	end

	local trace = depotTrace(session.depot or DEFAULT_DEPOT, canonicalClass)
	if not trace then
		fail("depotUnavailable")
		return
	end

	local definition = scripted_ents.Get(canonicalClass)
	if not definition or type(definition.Spawner) ~= "table" then
		fail("trainUnavailable")
		return
	end

	if WAGON_COUNT > GetConVarNumber("metrostroi_maxwagons") then
		fail("spawnFailed")
		return
	end

	if ply:InVehicle() then
		ply:ExitVehicle()
	end
	removeWagons(ownedWagons(ply))
	local settings = settingDefaults(definition)
	if Metrostroi.TrainCountOnPlayer(ply) + WAGON_COUNT > GetConVarNumber("metrostroi_maxtrains_onplayer") * GetConVarNumber("metrostroi_maxwagons")
		or Metrostroi.TrainCount() + WAGON_COUNT > GetConVarNumber("metrostroi_maxtrains") * GetConVarNumber("metrostroi_maxwagons")
		or hook.Run("MetrostroiSpawnerRestrict", ply, settings) then
		fail("spawnFailed")
		return
	end

	ply:Give("gmod_tool")
	local tool = ply:GetTool("train_spawner")
	if not tool then
		fail("spawnFailed")
		return
	end

	tool.Train = definition
	tool.Settings = settings
	tool.AllowSpawn = true
	ply:SetNW2Bool("metrostroi_train_spawner_rev", false)
	local spawned, trains = pcall(function()
		return tool:SpawnWagon(trace)
	end)
	if not spawned then
		fail("spawnFailed", ownedWagons(ply))
		return
	end
	if type(trains) ~= "table" or #trains ~= WAGON_COUNT or not IsValid(trains[1]) then
		fail("spawnFailed", type(trains) == "table" and trains or nil)
		return
	end

	timer.Simple(1, function()
		local lead = trains[1]
		if not IsValid(ply) or not IsValid(lead) or not IsValid(lead.DriverSeat) then
			fail("spawnFailed", trains)
			return
		end

		ply:EnterVehicle(lead.DriverSeat)
		if ply:GetVehicle() ~= lead.DriverSeat then
			fail("spawnFailed", trains)
			return
		end

		session.spawning = false
		result(ply, "spawn", true, "", canonicalClass)
	end)
end)

local function trainFromEntity(entity)
	if not IsValid(entity) then
		return nil
	end

	if METRO.Trains.ResolveClass(entity:GetClass()) then
		return entity
	end

	local parent = entity.GetNW2Entity and entity:GetNW2Entity("TrainEntity") or nil
	if IsValid(parent) and METRO.Trains.ResolveClass(parent:GetClass()) then
		return parent
	end

	parent = entity.SubwayTrain
	if IsValid(parent) and METRO.Trains.ResolveClass(parent:GetClass()) then
		return parent
	end

	return nil
end

function METRO.Service.NormaliseDepotName(name)
	return validName(name)
end

function METRO.Service.ListDepots()
	local depots = readDepots()
	local list = {}
	for name, depot in pairs(depots) do
		local classes = {}
		for className in pairs(type(depot.placements) == "table" and depot.placements or {}) do
			table.insert(classes, className)
		end
		table.sort(classes)
		table.insert(list, {
			name = name,
			label = depot.label or name,
			hasDefault = depot.default ~= nil,
			placements = classes,
		})
	end
	table.sort(list, function(a, b) return a.name < b.name end)
	return list
end

function METRO.Service.RemoveDepot(depotName)
	local name = validName(depotName)
	local depots = readDepots()
	if not name or not depots[name] then
		return false, "depotUnknown"
	end

	depots[name] = nil
	writeDepots(depots)
	return true, "depotRemoveSuccess", name
end

function METRO.Service.RemovePlacementClass(depotName, className)
	local name = validName(depotName)
	local depots = readDepots()
	local depot = name and depots[name]
	if type(depot) ~= "table" then
		return false, "depotUnknown"
	end

	if type(depot.placements) ~= "table" or not depot.placements[className] then
		return false, "depotNoPlacement"
	end

	depot.placements[className] = nil
	writeDepots(depots)
	return true, "depotPlacementCleared", className, depot.label or name
end

function METRO.Service.SavePlacement(ply, depotName, label, asDefault)
	local name = validName(depotName)
	if not name then
		return false, "depotNameInvalid"
	end

	local train = trainFromEntity(ply:GetEyeTrace().Entity)
	if not train then
		return false, "depotNoTrainAimed"
	end

	local track = Metrostroi and Metrostroi.RerailGetTrackData
		and Metrostroi.RerailGetTrackData(train:GetPos(), train:GetForward())
	if not track then
		return false, "depotOffTrack"
	end

	local placement = {
		position = vectorTable(track.centerpos),
		forward = vectorTable(track.forward),
		up = vectorTable(track.up),
	}

	local depots = readDepots()
	local depot = depots[name]
	if type(depot) ~= "table" then
		depot = { label = label ~= "" and label or name, placements = {} }
		depots[name] = depot
	elseif label and label ~= "" then
		depot.label = label
	end

	depot.placements = type(depot.placements) == "table" and depot.placements or {}

	local className = METRO.Trains.ResolveClass(train:GetClass()) or train:GetClass()
	if asDefault or not depot.default then
		depot.default = placement
	end
	if not asDefault then
		depot.placements[className] = placement
	end

	writeDepots(depots)
	return true, asDefault and "depotDefaultSaved" or "depotPlacementSaved", className, depot.label
end

function METRO.Service.ClearPlacement(ply, depotName)
	local name = validName(depotName)
	local depots = readDepots()
	local depot = name and depots[name]
	if type(depot) ~= "table" then
		return false, "depotUnknown"
	end

	local train = trainFromEntity(ply:GetEyeTrace().Entity)
	if not train then
		return false, "depotNoTrainAimed"
	end

	local className = METRO.Trains.ResolveClass(train:GetClass()) or train:GetClass()
	if type(depot.placements) ~= "table" or not depot.placements[className] then
		return false, "depotNoPlacement"
	end

	depot.placements[className] = nil
	writeDepots(depots)
	return true, "depotPlacementCleared", className, depot.label
end

concommand.Add("metro_depot_set", function(ply, _, args)
	if not IsValid(ply) or not ply:IsSuperAdmin() then
		return
	end

	local success, message = METRO.Service.SavePlacement(ply, args[1] or DEFAULT_DEPOT, args[2] or "", true)
	ply:ChatPrint(L(success and "depotSetSuccess" or message, ply, validName(args[1] or DEFAULT_DEPOT) or ""))
end)

concommand.Add("metro_depot_list", function(ply)
	if IsValid(ply) and not ply:IsSuperAdmin() then
		return
	end

	local names = {}
	for name in pairs(readDepots()) do
		table.insert(names, name)
	end
	table.sort(names)
	local message = L("depotList", ply, #names > 0 and table.concat(names, ", ") or L("depotNone", ply))
	if IsValid(ply) then
		ply:ChatPrint(message)
	else
		print(message)
	end
end)

concommand.Add("metro_depot_remove", function(ply, _, args)
	if IsValid(ply) and not ply:IsSuperAdmin() then
		return
	end

	local name = validName(args[1] or "")
	local depots = readDepots()
	if not name or not depots[name] then
		if IsValid(ply) then
			ply:ChatPrint(L("depotRemoveFailed", ply))
		else
			print(L("depotRemoveFailed", nil))
		end
		return
	end

	depots[name] = nil
	writeDepots(depots)
	if IsValid(ply) then
		ply:ChatPrint(L("depotRemoveSuccess", ply, name))
	else
		print(L("depotRemoveSuccess", nil, name))
	end
end)

net.Receive("MetroDepotListRequest", function(_, ply)
	if not IsValid(ply) or not ply:IsSuperAdmin() or not allowedRequest(ply, "depotList") then
		return
	end

	local list = METRO.Service.ListDepots()
	net.Start("MetroDepotList")
	net.WriteUInt(math.min(#list, 255), 8)
	for index, entry in ipairs(list) do
		if index > 255 then break end
		net.WriteString(entry.name)
		net.WriteString(entry.label)
		net.WriteBool(entry.hasDefault)
		net.WriteUInt(math.min(#entry.placements, 255), 8)
		for classIndex, className in ipairs(entry.placements) do
			if classIndex > 255 then break end
			net.WriteString(className)
		end
	end
	net.Send(ply)
end)

net.Receive("MetroDepotManage", function(_, ply)
	if not IsValid(ply) or not ply:IsSuperAdmin() or not allowedRequest(ply, "depotManage") then
		return
	end

	local depotName = net.ReadString()
	local className = net.ReadString()

	local success, message, first, second
	if className == "" then
		success, message, first = METRO.Service.RemoveDepot(depotName)
	else
		success, message, first, second = METRO.Service.RemovePlacementClass(depotName, className)
	end

	ply:NotifyLocalized(message, first or "", second or "")
end)
