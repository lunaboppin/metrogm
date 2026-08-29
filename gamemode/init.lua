AddCSLuaFile("shared.lua")
include("shared.lua")

local SHARED_MODULES = {
	"modules/sh_levels.lua",
}

local SERVER_MODULES = {
	"modules/sv_config.lua",
	"modules/sv_migrations.lua",
	"modules/sv_storage_sqlite.lua",
	"modules/sv_storage_mysql.lua",
	"modules/sv_storage.lua",
	"modules/sv_network.lua",
	"modules/sv_players.lua",
	"modules/sv_economy.lua",
	"modules/sv_admin.lua",
	"modules/sv_selftest.lua",
	"modules/sv_boot.lua",
}

local CLIENT_MODULES = {
	"modules/cl_stats.lua",
	"modules/cl_hud.lua",
	"modules/cl_menu.lua",
}

for _, path in ipairs(CLIENT_MODULES) do
	AddCSLuaFile(path)
end

for _, path in ipairs(SHARED_MODULES) do
	AddCSLuaFile(path)
	include(path)
end

for _, path in ipairs(SERVER_MODULES) do
	include(path)
end
