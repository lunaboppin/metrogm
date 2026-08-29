AddCSLuaFile("shared.lua")
include("shared.lua")

local SHARED_MODULES = {
}

local SERVER_MODULES = {
	"modules/sv_config.lua",
	"modules/sv_migrations.lua",
	"modules/sv_storage_sqlite.lua",
	"modules/sv_storage_mysql.lua",
	"modules/sv_storage.lua",
	"modules/sv_selftest.lua",
	"modules/sv_boot.lua",
}

for _, path in ipairs(SHARED_MODULES) do
	AddCSLuaFile(path)
	include(path)
end

for _, path in ipairs(SERVER_MODULES) do
	include(path)
end
