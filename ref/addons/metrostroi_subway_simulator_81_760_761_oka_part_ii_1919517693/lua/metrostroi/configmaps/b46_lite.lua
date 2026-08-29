local Map = game.GetMap():lower() or ""

if Map:find("gm_metrostroi") and Map:find("lite") then
else
    return
end