METRO.Levels = METRO.Levels or {}

local XP_CURVE_COEFFICIENT = 50
local MAX_LEVEL = 100

function METRO.Levels.TotalXpForLevel(level)
	if level <= 1 then
		return 0
	end

	if level > MAX_LEVEL then
		level = MAX_LEVEL
	end

	return XP_CURVE_COEFFICIENT * (level - 1) * level
end

function METRO.Levels.LevelForXp(xp)
	xp = METRO.Integer.Normalize(xp)
	if not xp or METRO.Integer.Compare(xp, "0") < 0 then
		return 1
	end

	local level = 1
	while level < MAX_LEVEL and METRO.Integer.Compare(xp, METRO.Levels.TotalXpForLevel(level + 1)) >= 0 do
		level = level + 1
	end

	return level
end

function METRO.Levels.GetMaxLevel()
	return MAX_LEVEL
end

function METRO.Levels.Progress(xp)
	xp = METRO.Integer.Normalize(xp) or "0"
	if METRO.Integer.Compare(xp, "0") < 0 then
		xp = "0"
	end

	local level = METRO.Levels.LevelForXp(xp)

	if level >= MAX_LEVEL then
		return level, 0, 0, 1
	end

	local floor = METRO.Levels.TotalXpForLevel(level)
	local ceiling = METRO.Levels.TotalXpForLevel(level + 1)
	local span = ceiling - floor
	local into = tonumber(xp) - floor

	return level, into, span, into / span
end
