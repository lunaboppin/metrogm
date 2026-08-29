if Metrostroi then
    print("[metro] Metrostroi global already present, workshop scripts addon has loaded, skipping vendored copy")
    return
end

local rawFileFind = file.Find
local gamemodeLuaPrefix = engine.ActiveGamemode() .. "/gamemode/"
function file.Find(path, domain, sorting)
    if domain == "LUA" and path:sub(1, 10) == "metrostroi" then
        return rawFileFind(gamemodeLuaPrefix .. path, domain, sorting)
    end
    return rawFileFind(path, domain, sorting)
end

include("metrostroi.lua")
include("prop_button.lua")
include("prop_float_ex.lua")

hook.Add("InitPostEntity", "MetroRescanMetrostroiTrainClasses", function()
    if not Metrostroi or #Metrostroi.TrainClasses > 0 then return end
    for name in pairs(scripted_ents.GetList()) do
        local prefix = "gmod_subway_"
        if string.sub(name, 1, #prefix) == prefix and scripted_ents.Get(name).Base == "gmod_subway_base" then
            table.insert(Metrostroi.TrainClasses, name)
            Metrostroi.IsTrainClass[name] = true
        end
    end
end)
