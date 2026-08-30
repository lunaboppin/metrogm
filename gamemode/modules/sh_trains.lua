METRO.Trains = METRO.Trains or {}

local function invalidConfig(message)
	error("[metro] invalid train config: " .. message, 0)
end

local function isWholeNumber(value)
	return type(value) == "number"
		and value == math.floor(value)
		and value ~= math.huge
		and value ~= -math.huge
		and value == value
end

local function validateConfig(config)
	if type(config) ~= "table" then
		invalidConfig("config/trains.lua must return a table")
	end

	local enabledStarters = 0
	for className, entry in pairs(config) do
		if type(className) ~= "string" or className == "" then
			invalidConfig("every catalogue key must be a non-empty class name")
		end

		if type(entry) ~= "table" then
			invalidConfig("entry '" .. className .. "' must be a table")
		end

		if entry.enabled then
			if type(entry.displayNameKey) ~= "string" or entry.displayNameKey == "" then
				invalidConfig("enabled entry '" .. className .. "' needs a displayNameKey")
			end

			if not isWholeNumber(entry.price) or entry.price < 0 then
				invalidConfig("enabled entry '" .. className .. "' needs a non-negative whole price")
			end

			if not isWholeNumber(entry.requiredLevel)
				or entry.requiredLevel < 1
				or entry.requiredLevel > METRO.Levels.GetMaxLevel() then
				invalidConfig("enabled entry '" .. className .. "' needs a requiredLevel from 1 to " .. METRO.Levels.GetMaxLevel())
			end

			if type(entry.starter) ~= "boolean" then
				invalidConfig("enabled entry '" .. className .. "' needs a boolean starter field")
			end

			if type(entry.enabled) ~= "boolean" then
				invalidConfig("enabled entry '" .. className .. "' needs a boolean enabled field")
			end

			if not isWholeNumber(entry.sortOrder) then
				invalidConfig("enabled entry '" .. className .. "' needs a whole sortOrder")
			end

			if entry.starter then
				enabledStarters = enabledStarters + 1
				if entry.price ~= 0 or entry.requiredLevel ~= 1 then
					invalidConfig("starter entry '" .. className .. "' must have price 0 and requiredLevel 1")
				end
			end
		end
	end

	if enabledStarters ~= 1 then
		invalidConfig("exactly one enabled starter is required, found " .. enabledStarters)
	end
end

validateConfig(METRO.TrainConfig)

local registry = {
	aliases = {},
	heads = {},
	refreshed = false,
}

local function getDefinition(className)
	if not scripted_ents then
		return nil
	end

	if scripted_ents.GetStored then
		local stored = scripted_ents.GetStored(className)
		if stored then
			return stored.t or stored
		end
	end

	if scripted_ents.Get then
		return scripted_ents.Get(className)
	end
end

local function getRegisteredClasses()
	local names = {}
	local seen = {}

	if Metrostroi and type(Metrostroi.TrainClasses) == "table" then
		for _, className in pairs(Metrostroi.TrainClasses) do
			if type(className) == "string" and not seen[className] then
				seen[className] = true
				table.insert(names, className)
			end
		end
	end

	if #names == 0 and scripted_ents and scripted_ents.GetList then
		for className in pairs(scripted_ents.GetList()) do
			if type(className) == "string"
				and string.sub(className, 1, 12) == "gmod_subway_"
				and not seen[className] then
				seen[className] = true
				table.insert(names, className)
			end
		end
	end

	table.sort(names)
	return names
end

local function isSelectable(definition)
	return type(definition) == "table"
		and definition.Base == "gmod_subway_base"
		and type(definition.SubwayTrain) == "table"
		and type(definition.Spawner) == "table"
end

local function copyEntry(entry, canonicalClass)
	return {
		displayNameKey = entry.displayNameKey,
		price = entry.price,
		requiredLevel = entry.requiredLevel,
		starter = entry.starter,
		enabled = entry.enabled,
		sortOrder = entry.sortOrder,
		className = canonicalClass,
		canonicalClass = canonicalClass,
	}
end

function METRO.Trains.Refresh()
	local selectable = {}
	local canonicalByClass = {}

	for _, className in ipairs(getRegisteredClasses()) do
		local definition = getDefinition(className)
		if isSelectable(definition) then
			local canonicalClass = definition.Spawner.head
			if type(canonicalClass) ~= "string" or canonicalClass == "" then
				canonicalClass = className
			end

			selectable[className] = definition
			canonicalByClass[className] = canonicalClass
		end
	end

	local heads = {}
	for _, canonicalClass in pairs(canonicalByClass) do
		local headDefinition = selectable[canonicalClass]
		if headDefinition then
			local headAlias = headDefinition.Spawner.head
			if not headAlias or headAlias == "" or headAlias == canonicalClass then
				heads[canonicalClass] = headDefinition
			end
		end
	end

	local aliases = {}
	for className, canonicalClass in pairs(canonicalByClass) do
		if heads[canonicalClass] then
			aliases[className] = canonicalClass
		end
	end

	registry.selectable = selectable
	registry.heads = heads
	registry.aliases = aliases
	registry.refreshed = true

	return true
end

local function ensureRefreshed()
	if not registry.refreshed then
		METRO.Trains.Refresh()
	end
end

function METRO.Trains.ResolveClass(className)
	ensureRefreshed()
	if type(className) ~= "string" or className == "" then
		return nil
	end

	local definition = getDefinition(className)
	if not isSelectable(definition) then
		return nil
	end

	local canonicalClass = registry.aliases[className]
	if not canonicalClass then
		canonicalClass = definition.Spawner.head
		if type(canonicalClass) ~= "string" or canonicalClass == "" then
			canonicalClass = className
		end
	end

	if not registry.heads[canonicalClass] then
		return nil
	end

	return canonicalClass
end

function METRO.Trains.Get(className)
	local canonicalClass = METRO.Trains.ResolveClass(className)
	if not canonicalClass then
		return nil
	end

	local entry = METRO.TrainConfig[canonicalClass]
	if not entry or entry.enabled ~= true then
		return nil
	end

	return copyEntry(entry, canonicalClass), canonicalClass
end

function METRO.Trains.GetCatalogue()
	ensureRefreshed()

	local catalogue = {}
	for canonicalClass in pairs(registry.heads) do
		local entry = METRO.TrainConfig[canonicalClass]
		if entry and entry.enabled == true then
			table.insert(catalogue, copyEntry(entry, canonicalClass))
		end
	end

	table.sort(catalogue, function(left, right)
		if left.sortOrder == right.sortOrder then
			return left.canonicalClass < right.canonicalClass
		end
		return left.sortOrder < right.sortOrder
	end)

	return catalogue
end

function METRO.Trains.CanSpawn(ply, className)
	if not IsValid(ply) or (ply.IsPlayer and not ply:IsPlayer()) then
		return false, "trainProfileLoading"
	end

	if ply:IsSuperAdmin() then
		if METRO.Trains.ResolveClass(className) then
			return true
		end

		return false, "trainUnavailable"
	end

	if not METRO.Players
		or type(METRO.Players.IsLoaded) ~= "function"
		or type(METRO.Players.Get) ~= "function"
		or not METRO.Players.IsLoaded(ply) then
		return false, "trainProfileLoading"
	end

	local entry, canonicalClass = METRO.Trains.Get(className)
	if not entry then
		return false, "trainUnavailable"
	end

	local record = METRO.Players.Get(ply)
	if not record then
		return false, "trainProfileLoading"
	end

	if (tonumber(record.level) or 1) < entry.requiredLevel then
		return false, "trainLevelLocked"
	end

	if entry.starter then
		return true
	end

	if hook.Run("MetroTrainIsOwned", ply, canonicalClass) == true then
		return true
	end

	return false, "trainNotOwned"
end

hook.Add("InitPostEntity", "MetroTrainsRefresh", function()
	METRO.Trains.Refresh()
end)
