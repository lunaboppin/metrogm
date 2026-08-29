METRO.Format = METRO.Format or {}

function METRO.Format.Money(amount)
	return METRO.Integer.FormatGrouped(amount)
end

function METRO.Format.Playtime(totalSeconds)
	totalSeconds = METRO.Integer.Normalize(totalSeconds) or "0"
	local sign = ""
	if totalSeconds:sub(1, 1) == "-" then
		sign = "-"
		totalSeconds = METRO.Integer.Negate(totalSeconds)
	end

	if METRO.Integer.Compare(totalSeconds, 60) < 0 then
		return sign .. totalSeconds .. "s"
	end

	local days, remainder = METRO.Integer.DivmodSmall(totalSeconds, 86400)
	local hours, remainderHours = METRO.Integer.DivmodSmall(remainder, 3600)
	local minutes = math.floor(remainderHours / 60)

	local parts = {}
	if days ~= "0" then
		table.insert(parts, days .. "d")
	end
	if hours ~= "0" then
		table.insert(parts, hours .. "h")
	end
	if minutes > 0 and days == "0" then
		table.insert(parts, minutes .. "m")
	end

	return sign .. table.concat(parts, " ")
end

function METRO.Format.FirstSeen(value, unknownText)
	if isnumber(value) then
		return os.date("%Y-%m-%d", value)
	end

	if isstring(value) and value ~= "" then
		return value:match("^(%d%d%d%d%-%d%d%-%d%d)") or value
	end

	return unknownText
end

function METRO.Format.Clamp01(fraction)
	fraction = tonumber(fraction) or 0

	if fraction < 0 then
		return 0
	elseif fraction > 1 then
		return 1
	end

	return fraction
end

function METRO.Format.SegmentFraction(progress, segmentCount)
	segmentCount = tonumber(segmentCount) or 0

	if segmentCount <= 0 then
		return 0
	end

	return METRO.Format.Clamp01((tonumber(progress) or 0) / segmentCount)
end

function METRO.Format.Approach(current, target, maxDelta)
	current = tonumber(current) or 0
	target = tonumber(target) or 0
	maxDelta = math.abs(tonumber(maxDelta) or 0)

	if current < target then
		return math.min(current + maxDelta, target)
	elseif current > target then
		return math.max(current - maxDelta, target)
	end

	return current
end

function METRO.Format.Darken(color, factor)
	factor = tonumber(factor) or 0.5

	return {
		r = math.max((color.r or 0) * factor, 0),
		g = math.max((color.g or 0) * factor, 0),
		b = math.max((color.b or 0) * factor, 0),
		a = color.a or 255,
	}
end

function METRO.Format.SortedKeys(map, comparator)
	local keys = {}

	for key in pairs(map) do
		table.insert(keys, key)
	end

	table.sort(keys, comparator or function(a, b)
		return tostring(a) < tostring(b)
	end)

	return keys
end
