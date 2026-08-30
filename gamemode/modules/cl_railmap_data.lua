METRO.RailmapData = METRO.RailmapData or {}

local cache

local function parseVector(text)
	local x, y, z = string.match(text, "^%[%s*(-?[%d.]+)%s+(-?[%d.]+)%s+(-?[%d.]+)%s*%]$")
	if not x then
		return nil
	end

	return tonumber(x), tonumber(y), tonumber(z)
end

local function trackPath()
	return "metrostroi_data/track_" .. game.GetMap() .. ".lua"
end

local function build(raw)

	local decoded = raw and raw ~= "" and util.JSONToTable(raw)
	if type(decoded) ~= "table" then
		return { available = false, paths = {} }
	end

	local paths = {}
	local minX, minY, maxX, maxY
	local points = 0

	for _, rawPath in ipairs(decoded) do
		if type(rawPath) == "table" then
			local path = {}

			for _, entry in ipairs(rawPath) do
				if type(entry) == "string" then
					local x, y = parseVector(entry)
					if x then
						path[#path + 1] = { x = x, y = y }
						points = points + 1
						minX = math.min(minX or x, x)
						maxX = math.max(maxX or x, x)
						minY = math.min(minY or y, y)
						maxY = math.max(maxY or y, y)
					end
				end
			end

			if #path > 1 then
				paths[#paths + 1] = path
			end
		end
	end

	return {
		available = #paths > 0,
		paths = paths,
		points = points,
		bounds = minX and { minX = minX, minY = minY, maxX = maxX, maxY = maxY } or nil,
	}
end

local requested

function METRO.RailmapData.Load()
	if cache then
		return cache
	end

	cache = build(file.Read(trackPath(), "LUA"))

	if not cache.available and not requested then
		requested = true
		net.Start("MetroRailmapTrackRequest")
		net.SendToServer()
	end

	return cache
end

net.Receive("MetroRailmapTrack", function()
	if not net.ReadBool() then
		return
	end

	local length = net.ReadUInt(32)
	local raw = util.Decompress(net.ReadData(length))
	local built = build(raw)

	if built.available then
		cache = built
		hook.Run("MetroRailmapTrackLoaded")
	end
end)

function METRO.RailmapData.Reset()
	cache = nil
end
