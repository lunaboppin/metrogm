METRO.Format = METRO.Format or {}

function METRO.Format.Money(amount)
	amount = math.floor(tonumber(amount) or 0)

	local sign = ""
	if amount < 0 then
		sign = "-"
		amount = -amount
	end

	local digits = tostring(amount)
	local grouped = digits:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")

	return sign .. grouped
end

function METRO.Format.Playtime(totalSeconds)
	totalSeconds = math.floor(tonumber(totalSeconds) or 0)

	if totalSeconds < 60 then
		return totalSeconds .. "s"
	end

	local days = math.floor(totalSeconds / 86400)
	local hours = math.floor((totalSeconds % 86400) / 3600)
	local minutes = math.floor((totalSeconds % 3600) / 60)

	local parts = {}
	if days > 0 then
		table.insert(parts, days .. "d")
	end
	if hours > 0 then
		table.insert(parts, hours .. "h")
	end
	if minutes > 0 and days == 0 then
		table.insert(parts, minutes .. "m")
	end

	return table.concat(parts, " ")
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
