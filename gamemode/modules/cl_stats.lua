METRO.PlayerVars = METRO.PlayerVars or {}
METRO.Stats = METRO.Stats or nil
METRO.LoadState = METRO.LoadState or "loading"
METRO.LoadError = METRO.LoadError or nil

net.Receive("MetroPlayerVars", function()
	local count = net.ReadUInt(16)
	METRO.PlayerVars = {}

	for _ = 1, count do
		METRO.PlayerVars[net.ReadString()] = net.ReadType()
	end

	METRO.Stats = {}
	for _, variable in ipairs(METRO.Players.GetNetworkVars()) do
		local value = METRO.PlayerVars[variable.name]
		if value == nil then
			value = METRO.Players.GetVarDefault(variable.name)
		end
		METRO.Stats[variable.field] = METRO.Players.NormalizeVar(variable.name, value)
	end

	hook.Run("MetroStatsUpdated")
end)

net.Receive("MetroLoadState", function()
	local state = net.ReadString()
	local message = net.ReadString()

	METRO.LoadState = state
	METRO.LoadError = state == "error" and message or nil

	if state ~= "ready" then
		METRO.PlayerVars = {}
		METRO.Stats = nil
		hook.Run("MetroStatsUpdated")
	end
end)
