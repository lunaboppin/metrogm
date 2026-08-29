METRO.Integer = METRO.Integer or {}

local MAX_MAGNITUDE = "9223372036854775807"
local MIN_MAGNITUDE = "9223372036854775808"

local function stripLeadingZeros(value)
	value = value:gsub("^0+", "")
	return value == "" and "0" or value
end

local function compareMagnitude(left, right)
	if #left ~= #right then
		return #left < #right and -1 or 1
	end

	if left == right then
		return 0
	end

	return left < right and -1 or 1
end

local function normalizeString(value)
	if not value:match("^[+-]?%d+$") then
		return nil
	end

	local sign = ""
	local first = value:sub(1, 1)
	if first == "+" or first == "-" then
		sign = first == "-" and "-" or ""
		value = value:sub(2)
	end

	value = stripLeadingZeros(value)
	if value == "0" then
		return value
	end

	local limit = sign == "-" and MIN_MAGNITUDE or MAX_MAGNITUDE
	if compareMagnitude(value, limit) > 0 then
		return nil
	end

	return sign .. value
end

local function normalizeNumber(value)
	if value ~= value or value == math.huge or value == -math.huge or value ~= math.floor(value) then
		return nil
	end

	return normalizeString(string.format("%.0f", value))
end

function METRO.Integer.Normalize(value)
	if type(value) == "number" then
		return normalizeNumber(value)
	end

	if type(value) == "string" then
		return normalizeString(value)
	end

	return nil
end

function METRO.Integer.IsValid(value)
	return METRO.Integer.Normalize(value) ~= nil
end

function METRO.Integer.Compare(left, right)
	left = METRO.Integer.Normalize(left)
	right = METRO.Integer.Normalize(right)
	if not left or not right then
		return nil
	end

	local leftNegative = left:sub(1, 1) == "-"
	local rightNegative = right:sub(1, 1) == "-"
	if leftNegative ~= rightNegative then
		return leftNegative and -1 or 1
	end

	local leftMagnitude = leftNegative and left:sub(2) or left
	local rightMagnitude = rightNegative and right:sub(2) or right
	local result = compareMagnitude(leftMagnitude, rightMagnitude)
	return leftNegative and -result or result
end

local function addMagnitude(left, right)
	local index = math.max(#left, #right)
	local leftOffset = index - #left
	local rightOffset = index - #right
	local carry = 0
	local result = {}

	while index > 0 do
		local leftIndex = index - leftOffset
		local rightIndex = index - rightOffset
		local leftDigit = leftIndex > 0 and tonumber(left:sub(leftIndex, leftIndex)) or 0
		local rightDigit = rightIndex > 0 and tonumber(right:sub(rightIndex, rightIndex)) or 0
		local sum = leftDigit + rightDigit + carry
		result[index] = tostring(sum % 10)
		carry = math.floor(sum / 10)
		index = index - 1
	end

	if carry > 0 then
		table.insert(result, 1, tostring(carry))
	end

	return table.concat(result)
end

local function subtractMagnitude(left, right)
	local index = #left
	local rightOffset = #left - #right
	local borrow = 0
	local result = {}

	while index > 0 do
		local digit = (tonumber(left:sub(index, index)) or 0) - borrow
		local rightIndex = index - rightOffset
		local rightDigit = rightIndex > 0 and tonumber(right:sub(rightIndex, rightIndex)) or 0
		if digit < rightDigit then
			digit = digit + 10
			borrow = 1
		else
			borrow = 0
		end
		result[index] = tostring(digit - rightDigit)
		index = index - 1
	end

	return stripLeadingZeros(table.concat(result))
end

function METRO.Integer.Negate(value)
	value = METRO.Integer.Normalize(value)
	if not value then
		return nil
	end

	if value == "0" then
		return value
	end

	if value:sub(1, 1) == "-" then
		return value:sub(2)
	end

	return "-" .. value
end

function METRO.Integer.Add(left, right)
	left = METRO.Integer.Normalize(left)
	right = METRO.Integer.Normalize(right)
	if not left or not right then
		return nil
	end

	local leftNegative = left:sub(1, 1) == "-"
	local rightNegative = right:sub(1, 1) == "-"
	local leftMagnitude = leftNegative and left:sub(2) or left
	local rightMagnitude = rightNegative and right:sub(2) or right
	local result

	if leftNegative == rightNegative then
		result = addMagnitude(leftMagnitude, rightMagnitude)
		if leftNegative then
			result = "-" .. result
		end
	else
		local comparison = compareMagnitude(leftMagnitude, rightMagnitude)
		if comparison == 0 then
			return "0"
		end

		if comparison > 0 then
			result = subtractMagnitude(leftMagnitude, rightMagnitude)
			if leftNegative then
				result = "-" .. result
			end
		else
			result = subtractMagnitude(rightMagnitude, leftMagnitude)
			if rightNegative then
				result = "-" .. result
			end
		end
	end

	return METRO.Integer.Normalize(result)
end

function METRO.Integer.Subtract(left, right)
	return METRO.Integer.Add(left, METRO.Integer.Negate(right))
end

function METRO.Integer.DivmodSmall(value, divisor)
	value = METRO.Integer.Normalize(value)
	divisor = tonumber(divisor)
	if not value or value:sub(1, 1) == "-" or not divisor or divisor < 1 or divisor ~= math.floor(divisor) then
		return nil
	end

	local quotient = {}
	local remainder = 0
	for index = 1, #value do
		local current = remainder * 10 + (tonumber(value:sub(index, index)) or 0)
		local digit = math.floor(current / divisor)
		remainder = current % divisor
		if #quotient > 0 or digit > 0 then
			table.insert(quotient, tostring(digit))
		end
	end

	return #quotient > 0 and table.concat(quotient) or "0", remainder
end

function METRO.Integer.FormatGrouped(value)
	value = METRO.Integer.Normalize(value) or "0"
	local sign = ""
	if value:sub(1, 1) == "-" then
		sign = "-"
		value = value:sub(2)
	end

	local grouped = value:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
	return sign .. grouped
end
