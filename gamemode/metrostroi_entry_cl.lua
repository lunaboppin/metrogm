if Metrostroi then
	Metrostroi.GetTimedT = Metrostroi.GetTimedT or function(notsync)
		local T0 = GetGlobalFloat("MetrostroiT0", os.time()) + GetGlobalFloat("MetrostroiTY")
		local T1 = GetGlobalFloat("MetrostroiT1", CurTime())

		if notsync then
			return (os.time() - T0) - (CurTime() - T1)
		end

		return (os.time() - T0 + (CurTime() % 1.0)) - (CurTime() - T1)
	end
	Metrostroi.GetSyncTime = Metrostroi.GetSyncTime or function(notsync)
		return os.time() - Metrostroi.GetTimedT(notsync)
	end
	print("[metro] Metrostroi global already present, workshop scripts addon has loaded, skipping vendored copy")
	return
end

local rawFileFind = file.Find
local rawInclude = include
local gamemodeLuaPrefix = engine.ActiveGamemode() .. "/gamemode/"
function file.Find(path, domain, sorting)
    if domain == "LUA" and path:sub(1, 10) == "metrostroi" then
        return rawFileFind(gamemodeLuaPrefix .. path, domain, sorting)
    end
    return rawFileFind(path, domain, sorting)
end

function include(path)
    if path:sub(1, 10) == "metrostroi" then
        return rawInclude(gamemodeLuaPrefix .. path)
    end
    return rawInclude(path)
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
