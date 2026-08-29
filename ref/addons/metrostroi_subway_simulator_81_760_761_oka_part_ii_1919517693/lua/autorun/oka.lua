timer.Simple(0,function()
	if not Metrostroi then return end
	Metrostroi.CISConfig = {}
	function Metrostroi.AddCISConfig(name,datatable)
		if not datatable then return end
		for k,v in pairs(Metrostroi.CISConfig) do
			if v.name == name then
				Metrostroi.CISConfig[k] = datatable
				Metrostroi.CISConfig[k].name = name
				print("Metrostroi CIS: Changed \""..name.."\" config.")
				return
			end
		end
		local id = table.insert(Metrostroi.CISConfig,datatable)
		Metrostroi.CISConfig[id].name = name
		
		print("Metrostroi CIS: Adding \""..name.."\" config")
	end
	local models = {
		["models/metrostroi_train/81-760/81_760_body.mdl"] = true,
		["models/metrostroi_train/81-760/81_761_body.mdl"] = true,

		["models/metrostroi_train/81-760/81_760a_body.mdl"] = true,	
		["models/metrostroi_train/81-760/81_761a_body.mdl"] = true,
		["models/metrostroi_train/81-760/81_760_fence_corrugated.mdl"] = true,
		
		["models/metrostroi_train/81-760/81_760_bogey_f.mdl"] = true,
		["models/metrostroi_train/81-760/81_760_bogey.mdl"] = true,
		["models/metrostroi_train/81-760/81_763_bogey.mdl"] = true,
		["models/metrostroi_train/81-760/81_760_wheels.mdl"] = true,
		
		["models/metrostroi_train/81-760/81_760_couple_wtht_ekk.mdl"] = true,
		["models/metrostroi_train/81-760/81_760_couple_ekk.mdl"] = true,
		["models/metrostroi_train/81-760/81_763a_couple_ekk.mdl"] = true,
		
		--"models/metrostroi_train/81-760/81_760_int.mdl",
		
	}
	if CLIENT then
		local path = "models/metrostroi_train/81-760/"
		local files = file.Find(path.."*.mdl","GAME")
		for _,filename in pairs(files) do
			if not models[path..filename] then
				models[path..filename] = true
			end
		end
		path = "models/metrostroi_train/81-760/numbers/"
		files = file.Find(path.."*.mdl","GAME")
		for _,filename in pairs(files) do
			if not models[path..filename] then
				models[path..filename] = true
			end
		end
		--table.insert(models,"models/metrostroi_train/81-760/81_760_int.mdl")
	end
	print("[Metrostroi 81-760] Precache models")
	for k,v in pairs(models) do
		if v then
			util.PrecacheModel(k)
		end
	end
	if SERVER then
		util.AddNetworkString("gmod_metrostroi_getlang")

		local files = file.Find("metrostroi/configmaps/*.lua","LUA")
		for _,filename in pairs(files) do
			AddCSLuaFile("metrostroi/configmaps/"..filename)
			include("metrostroi/configmaps/"..filename)
		end
		
		timer.Simple(1,function()
			local tbl = scripted_ents.Get("gmod_train_bogey")
			if tbl then
				tbl.Types["760F"] = {
					"models/metrostroi_train/81-760/81_760_bogey_f.mdl",
					Vector(0,0.0,-21.3),Angle(0,-90,0),"models/metrostroi_train/81-760/81_760_wheels.mdl",
					Vector(0,-62,-26),Vector(0,62,-26),
					47,
					Vector(-10.8,-61.4,-14.5),Vector(10.8,61.4,-14.5),
				}		
				tbl.Types["760"] = {
					"models/metrostroi_train/81-760/81_760_bogey.mdl",
					Vector(0,0.0,-21.3),Angle(0,-90,0),"models/metrostroi_train/81-760/81_760_wheels.mdl",
					Vector(0,-62,-26),Vector(0,62,-26),
					47,
					Vector(-10.8,-61.4,-14.5),Vector(10.8,61.4,-14.5),
				}		
				tbl.Types["763"] = {
					"models/metrostroi_train/81-760/81_763_bogey.mdl",
					Vector(0,0.0,-21.3),Angle(0,-90,0),"models/metrostroi_train/81-760/81_760_wheels.mdl",
					Vector(0,-62,-26),Vector(0,62,-26),
					47,
					Vector(-10.8,-61.4,-14.5),Vector(10.8,61.4,-14.5),
				}		
				scripted_ents.Register(tbl,"gmod_train_bogey")
			end
			tbl = scripted_ents.Get("gmod_train_couple")
			if tbl then
				tbl.Types["760"] = {
					"models/metrostroi_train/81-760/81_760_couple_ekk.mdl",Vector(65,0,0),Vector(65.1,1,-4.9),Angle(0,-90,0)
				}
				tbl.Types["763"] = {
					"models/metrostroi_train/81-760/81_763a_couple_ekk.mdl",Vector(65,0,0),Vector(65.1,1,-4.9),Angle(0,-90,0)			
				}
				scripted_ents.Register(tbl,"gmod_train_couple")			
			end
		end)	
	else
		local files = file.Find("metrostroi/configmaps/*.lua","LUA")
		for _,filename in pairs(files) do   include("metrostroi/configmaps/"..filename) end
		language.Add("SBoxLimit_spawner_restrict_ru","Этот поезд запрещен для вас")
		
		local function SEND()
			net.Start("gmod_metrostroi_getlang")
			net.WriteString(Metrostroi.ChoosedLang ~= "" and Metrostroi.ChoosedLang or "en")
			net.SendToServer()	
		end
		net.Receive("gmod_metrostroi_getlang",function(ln,ply)
			SEND()
		end)
		
	end

	if CLIENT then return end
	local workshopid = {
		1919516717,--Ока 1
		1919517693,--Ока 2
		1605301295,--ПрОст
	}
	print("[Metrostroi 81-760] Adding "..#workshopid.." workshop addons...")
	for k,v in pairs(workshopid) do
		resource.AddWorkshop(tostring(v))
	end

	hook.Add("SetupPlayerVisibility","PVSDormantFix1",function(ply)
	  for _,ent in pairs(ents.FindByClass("env_*")) do
		if ent.DormantFix1 then
		  ent:SetPreventTransmit(ply,not ply:TestPVS(ent))
		end
	  end
	end)
end)
