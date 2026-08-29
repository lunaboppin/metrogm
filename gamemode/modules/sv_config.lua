local CONFIG_GAME_PATH = "gamemodes/metro/config/database.lua"
local EXAMPLE_GAME_PATH = "gamemodes/metro/config/database.lua.example"

local VALID_BACKENDS = {
	auto = true,
	mysql = true,
	sqlite = true,
}

function METRO.LoadDatabaseConfig()
	if not file.Exists(CONFIG_GAME_PATH, "GAME") then
		error(
			"metro: missing config file garrysmod/" .. CONFIG_GAME_PATH ..
			" -- copy garrysmod/" .. EXAMPLE_GAME_PATH ..
			" to garrysmod/" .. CONFIG_GAME_PATH .. " and fill in your database credentials",
			0
		)
	end

	local source = file.Read(CONFIG_GAME_PATH, "GAME")
	local chunk, compileErr = CompileString(source, "metro_database_config", false)
	if not isfunction(chunk) then
		error("metro: garrysmod/" .. CONFIG_GAME_PATH .. " failed to compile: " .. tostring(compileErr), 0)
	end

	local ok, config = pcall(chunk)
	if not ok then
		error("metro: garrysmod/" .. CONFIG_GAME_PATH .. " failed to run: " .. tostring(config), 0)
	end

	if type(config) ~= "table" then
		error("metro: garrysmod/" .. CONFIG_GAME_PATH .. " must return a table", 0)
	end

	if not VALID_BACKENDS[config.backend] then
		error(
			"metro: garrysmod/" .. CONFIG_GAME_PATH .. " has invalid backend '" .. tostring(config.backend) ..
			"' -- must be \"auto\", \"mysql\" or \"sqlite\"",
			0
		)
	end

	return config
end
