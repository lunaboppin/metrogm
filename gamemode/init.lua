AddCSLuaFile("shared.lua")
include("shared.lua")

local FIRST_MODULE = "modules/sh_language.lua"

local ORDERED_MODULES = {
	"modules/sv_storage_sqlite.lua",
	"modules/sv_storage_mysql.lua",
	"modules/sv_storage.lua",
}

local FINAL_MODULE = "modules/sv_boot.lua"

local skip = {[FIRST_MODULE] = true, [FINAL_MODULE] = true}
for _, path in ipairs(ORDERED_MODULES) do
	skip[path] = true
end

METRO.Include(FIRST_MODULE)
METRO.Lang.LoadFromDir("languages")

for _, path in ipairs(ORDERED_MODULES) do
	METRO.Include(path)
end

METRO.IncludeDir("modules", false, skip)

METRO.Include(FINAL_MODULE)
