METRO.Network = METRO.Network or {}

util.AddNetworkString("MetroStats")
util.AddNetworkString("MetroLoadState")

local function writeStats(record)
	net.WriteString(record.name or "")
	net.WriteDouble(tonumber(record.money) or 0)
	net.WriteUInt(tonumber(record.xp) or 0, 32)
	net.WriteUInt(tonumber(record.level) or 1, 8)
	net.WriteUInt(tonumber(record.playtime_seconds) or 0, 32)
	net.WriteUInt(tonumber(record.first_seen) or 0, 32)
end

function METRO.Network.PushStats(ply)
	if not IsValid(ply) then
		return
	end

	local record = METRO.Players.Get(ply)
	if not record then
		return
	end

	net.Start("MetroStats")
	writeStats(record)
	net.Send(ply)
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
