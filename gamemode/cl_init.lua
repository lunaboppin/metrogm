include("shared.lua")

local FIRST_MODULE = "modules/sh_language.lua"

METRO.Include(FIRST_MODULE)
METRO.Lang.LoadFromDir("languages")

METRO.IncludeDir("modules", false, {[FIRST_MODULE] = true})
