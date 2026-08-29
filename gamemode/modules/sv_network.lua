METRO.Network = METRO.Network or {}

util.AddNetworkString("MetroPlayerVars")
util.AddNetworkString("MetroLoadState")

local function networkValue(record, variable)
	local value = record[variable.field]
	if value == nil then
		value = METRO.Players.GetVarDefault(variable.name)
	end
	return value
end

function METRO.Network.SyncVars(ply)
	if not IsValid(ply) then
		return
	end

	local record = METRO.Players.Get(ply)
	if not record then
		return
	end

	local variables = METRO.Players.GetNetworkVars()
	net.Start("MetroPlayerVars")
	net.WriteUInt(#variables, 16)
	for _, variable in ipairs(variables) do
		net.WriteString(variable.name)
		local value = networkValue(record, variable)
		if variable.storageType == "bigint" then
			net.WriteString(METRO.Integer.Normalize(value) or "0")
		else
			net.WriteType(value)
		end
	end
	net.Send(ply)
end

function METRO.Network.PushVar(ply)
	METRO.Network.SyncVars(ply)
end

function METRO.Network.PushStats(ply)
	METRO.Network.SyncVars(ply)
end

function METRO.Network.PushLoadState(ply, state, message)
	if not IsValid(ply) then
		return
	end

	net.Start("MetroLoadState")
	net.WriteString(state)
	net.WriteString(message or "")
	net.Send(ply)
end
