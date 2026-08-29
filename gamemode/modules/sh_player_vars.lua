METRO.Players = METRO.Players or {}
METRO.Players.Vars = METRO.Players.Vars or {}
METRO.Players.VarOrder = METRO.Players.VarOrder or {}

if METRO.Players.PlayerVarsLoaded then
	return
end

METRO.Players.PlayerVarsLoaded = true

local function copyDefault(value)
	if istable(value) then
		return table.Copy(value)
	end

	return value
end

local function upperName(name)
	return name:sub(1, 1):upper() .. name:sub(2)
end

local function normalizeName(name)
	if not isstring(name) or not name:match("^[%a_][%w_]*$") then
		error("[metro] invalid player variable name '" .. tostring(name) .. "'")
	end

	return name
end

local function defaultValue(variable)
	if isfunction(variable.default) then
		return variable.default()
	end

	return copyDefault(variable.default)
end

local function normalizeValue(variable, value)
	if value == nil then
		value = defaultValue(variable)
	end

	if variable.normalize then
		return variable.normalize(value)
	end

	if variable.storageType == "bigint" then
		return METRO.Integer.Normalize(value) or "0"
	elseif variable.storageType == "integer" then
		return math.floor(tonumber(value) or 0)
	elseif variable.storageType == "number" then
		return tonumber(value) or 0
	elseif variable.storageType == "boolean" then
		return value == true or value == 1 or value == "1"
	elseif variable.storageType == "string" then
		return tostring(value or "")
	end

	return value
end

function METRO.Players.RegisterVar(name, data)
	name = normalizeName(name)
	data = data or {}

	if METRO.Players.Vars[name] then
		error("[metro] player variable '" .. name .. "' is already registered")
	end

	local variable = table.Copy(data)
	variable.name = name
	variable.field = variable.field or name
	variable.storage = variable.storage ~= false
	variable.storageType = variable.storageType or "string"
	variable.default = variable.default
	variable.isLocal = variable.isLocal == true
	variable.bNoNetworking = variable.bNoNetworking == true

	if variable.storage and (not isstring(variable.field) or not variable.field:match("^[%a_][%w_]*$")) then
		error("[metro] invalid storage field for player variable '" .. name .. "'")
	end

	METRO.Players.Vars[name] = variable
	table.insert(METRO.Players.VarOrder, name)

	local getterName = "Get" .. upperName(name)
	local setterName = "Set" .. upperName(name)

	METRO.Players[getterName] = function(target, fallback)
		return METRO.Players.GetVar(target, name, fallback)
	end

	METRO.Players[setterName] = function(target, value, ...)
		return METRO.Players.SetVar(target, name, value, ...)
	end

	return variable
end

function METRO.Players.GetVarDefinition(name)
	return METRO.Players.Vars[name]
end

function METRO.Players.GetVarDefault(name)
	local variable = METRO.Players.Vars[name]
	if not variable then
		return nil
	end

	return defaultValue(variable)
end

function METRO.Players.GetVars()
	local result = {}
	for _, name in ipairs(METRO.Players.VarOrder) do
		result[name] = METRO.Players.Vars[name]
	end
	return result
end

function METRO.Players.GetStorageVars()
	local result = {}
	for _, name in ipairs(METRO.Players.VarOrder) do
		local variable = METRO.Players.Vars[name]
		if variable.storage then
			table.insert(result, variable)
		end
	end
	return result
end

function METRO.Players.GetNetworkVars()
	local result = {}
	for _, name in ipairs(METRO.Players.VarOrder) do
		local variable = METRO.Players.Vars[name]
		if not variable.bNoNetworking then
			table.insert(result, variable)
		end
	end
	return result
end

function METRO.Players.NormalizeVar(name, value)
	local variable = METRO.Players.Vars[name]
	if not variable then
		return value
	end

	return normalizeValue(variable, value)
end

function METRO.Players.DefaultRecord()
	local record = {}
	for _, variable in ipairs(METRO.Players.GetStorageVars()) do
		record[variable.field] = defaultValue(variable)
	end
	return record
end

function METRO.Players.NormalizeRecord(record)
	for _, variable in ipairs(METRO.Players.GetStorageVars()) do
		record[variable.field] = normalizeValue(variable, record[variable.field])
	end

	return record
end

function METRO.Players.GetVar(target, name, fallback)
	local variable = METRO.Players.Vars[name]
	if not variable then
		return fallback
	end

	local record = target
	if not istable(target) or target.steamid64 == nil or isfunction(target.SteamID64) then
		record = METRO.Players.Get(target)
	end

	if not record then
		if fallback ~= nil then
			return fallback
		end
		return defaultValue(variable)
	end

	local value = record[variable.field]
	if value == nil then
		if fallback ~= nil then
			return fallback
		end
		return defaultValue(variable)
	end

	return value
end

METRO.Players.RegisterVar("name", {
	field = "name",
	storageType = "string",
	sqlType = { mysql = "VARCHAR(64)", sqlite = "VARCHAR(64)" },
	default = "",
	isLocal = true,
})

METRO.Players.RegisterVar("money", {
	field = "money",
	storageType = "bigint",
	sqlType = { mysql = "BIGINT", sqlite = "INTEGER" },
	default = "0",
	isLocal = true,
	auditKind = "money",
})

METRO.Players.RegisterVar("xp", {
	field = "xp",
	storageType = "bigint",
	sqlType = { mysql = "BIGINT", sqlite = "INTEGER" },
	default = "0",
	isLocal = true,
	auditKind = "xp",
})

METRO.Players.RegisterVar("level", {
	field = "level",
	storageType = "integer",
	sqlType = { mysql = "INT", sqlite = "INTEGER" },
	default = 1,
	isLocal = true,
	bDerived = true,
})

METRO.Players.RegisterVar("playtime_seconds", {
	field = "playtime_seconds",
	storageType = "bigint",
	sqlType = { mysql = "BIGINT", sqlite = "INTEGER" },
	default = "0",
	isLocal = true,
})

METRO.Players.RegisterVar("first_seen", {
	field = "first_seen",
	storageType = "datetime",
	sqlType = { mysql = "DATETIME", sqlite = "DATETIME" },
	default = 0,
	isLocal = true,
	schemaDefault = "1970-01-01 00:00:00",
})

METRO.Players.RegisterVar("last_seen", {
	field = "last_seen",
	storageType = "datetime",
	sqlType = { mysql = "DATETIME", sqlite = "DATETIME" },
	default = 0,
	bNoNetworking = true,
	schemaDefault = "1970-01-01 00:00:00",
})
