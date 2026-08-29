include("shared.lua")

METRO.Include("metrostroi_entry_cl.lua", "client")

local FIRST_MODULE = "modules/sh_language.lua"

METRO.Include(FIRST_MODULE)
METRO.Lang.LoadFromDir("languages")

METRO.IncludeDir("modules", false, {[FIRST_MODULE] = true})
