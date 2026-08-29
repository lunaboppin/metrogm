METRO.Stats = METRO.Stats or nil
METRO.LoadState = METRO.LoadState or "loading"
METRO.LoadError = METRO.LoadError or nil

net.Receive("MetroStats", function()
	local name = net.ReadString()
	local money = net.ReadDouble()
	local xp = net.ReadUInt(32)
	local level = net.ReadUInt(8)
	local playtimeSeconds = net.ReadUInt(32)
	local firstSeen = net.ReadUInt(32)

	METRO.Stats = {
		name = name,
		money = money,
		xp = xp,
		level = level,
		playtime_seconds = playtimeSeconds,
		first_seen = firstSeen,
	}

	hook.Run("MetroStatsUpdated")
end)

net.Receive("MetroLoadState", function()
	local state = net.ReadString()
	local message = net.ReadString()

	METRO.LoadState = state
	METRO.LoadError = state == "error" and message or nil

	if state ~= "ready" then
		METRO.Stats = nil
		hook.Run("MetroStatsUpdated")
	end
end)
