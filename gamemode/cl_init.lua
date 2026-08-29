include("shared.lua")

local SHARED_MODULES = {
	"modules/sh_levels.lua",
}

local CLIENT_MODULES = {
	"modules/cl_stats.lua",
	"modules/cl_hud.lua",
	"modules/cl_menu.lua",
}

for _, path in ipairs(SHARED_MODULES) do
	include(path)
end

for _, path in ipairs(CLIENT_MODULES) do
	include(path)
end
