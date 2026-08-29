--------------------------------------------------------------------------------
-- Панель управления 
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_760A_Panel")
TRAIN_SYSTEM.DontAccelerateSimulation = false

function TRAIN_SYSTEM:Initialize()
	self.Train:LoadSystem("Stand","Relay","Switch",{bass=true})
	self.Train:LoadSystem("BTB","Relay","Switch",{bass=true})
	self.Train:LoadSystem("BTBk","Relay","Switch",{bass=true,normally_closed = true})	
	self.Train:LoadSystem("SD","Relay","Switch",{bass=true})
	self.Train:LoadSystem("SDk","Relay","Switch",{bass=true,normally_closed = true})	
	self.Train:LoadSystem("Ticker","Relay","Switch",{bass=true})
	self.Train:LoadSystem("KAH","Relay","Switch",{bass=true})
	self.Train:LoadSystem("KAHk","Relay","Switch",{bass=true,normally_closed = true})
	self.Train:LoadSystem("ALS","Relay","Switch",{bass=true})
	self.Train:LoadSystem("ALSk","Relay","Switch",{bass=true,normally_closed = true})	
	self.Train:LoadSystem("FDepot","Relay","Switch",{bass=true})
	self.Train:LoadSystem("PassScheme","Relay","Switch",{bass=true})
	self.Train:LoadSystem("EmergencyCompressor","Relay","Switch",{bass=true})--
	self.Train:LoadSystem("EnableBV","Relay","Switch",{bass=true})
	self.Train:LoadSystem("EnableBVEmer","Relay","Switch",{bass=true})
	self.Train:LoadSystem("DisableBV","Relay","Switch",{bass=true})
	self.Train:LoadSystem("Ring","Relay","Switch",{bass=true})
	self.Train:LoadSystem("R_Program2","Relay","Switch",{bass=true})
	self.Train:LoadSystem("R_Announcer","Relay","Switch",{bass=true})
	self.Train:LoadSystem("R_Line","Relay","Switch",{bass=true})
	self.Train:LoadSystem("R_Emer","Relay","Switch",{bass=true})
	self.Train:LoadSystem("R_Program1","Relay","Switch",{bass=true})
	self.Train:LoadSystem("R_Program11","Relay","Switch",{bass=true})
	self.Train:LoadSystem("Pr","Relay","Switch",{bass=true})
	self.Train:LoadSystem("OtklR","Relay","Switch",{bass=true})
	self.Train:LoadSystem("GlassHeating","Relay","Switch",{bass=true})
	self.Train:LoadSystem("Washer","Relay","Switch",{bass=true})
	self.Train:LoadSystem("SC","Relay","Switch",{bass=true})
	self.Train:LoadSystem("HeadlightsSwitch","Relay","Switch",{maxvalue=2,defaultvalue=0,bass=true})
	self.Train:LoadSystem("Micro","Relay","Switch",{bass=true})
	
	self.Train:LoadSystem("EmergencyControls","Relay","Switch",{bass=true})
	self.Train:LoadSystem("EmergencyControlsK","Relay","Switch",{defaultvalue=1,bass=true})
	self.Train:LoadSystem("Wiper","Relay","Switch",{bass=true})
	self.Train:LoadSystem("AutoDrive","Relay","Switch",{bass=true})

	self.Train:LoadSystem("AB","Relay","Switch",{bass=true})
	
	self.Train:LoadSystem("DoorSelectL","Relay","Switch",{bass=true})
	self.Train:LoadSystem("DoorSelectR","Relay","Switch",{bass=true})
	self.Train:LoadSystem("DoorBlock","Relay","Switch",{bass=true})
	self.Train:LoadSystem("DoorLeft","Relay","Switch",{bass=true})
	self.Train:LoadSystem("AccelRate","Relay","Switch",{bass=true})
	self.Train:LoadSystem("EmerBrakeAdd","Relay","Switch",{bass=true})
	self.Train:LoadSystem("EmerBrakeRelease","Relay","Switch",{bass=true})
	self.Train:LoadSystem("EmerBrake","Relay","Switch",{bass=true})
	self.Train:LoadSystem("EmergencyBrake","Relay","Switch",{bass=true})
	self.Train:LoadSystem("DoorRight","Relay","Switch",{bass=true})
	self.Train:LoadSystem("HornB","Relay","Switch",{bass=true})

	self.Train:LoadSystem("DoorClose","Relay","Switch",{bass=true})
	self.Train:LoadSystem("AttentionMessage","Relay","Switch",{bass=true})
	self.Train:LoadSystem("Attention","Relay","Switch",{bass=true})
	self.Train:LoadSystem("AttentionBrake","Relay","Switch",{bass=true})

	self.Train:LoadSystem("VentCondMode","Relay","Switch",{maxvalue=3,defaultvalue=2,bass=true})
	self.Train:LoadSystem("VentStrengthMode","Relay","Switch",{maxvalue=3,defaultvalue=2,bass=true})
	self.Train:LoadSystem("VentHeatMode","Relay","Switch",{maxvalue=1,defaultvalue=0,bass=true})

	self.Train:LoadSystem("EmerX1","Relay","Switch",{bass=true})
	self.Train:LoadSystem("EmerX2","Relay","Switch",{bass=true})
	self.Train:LoadSystem("EmerCloseDoors","Relay","Switch",{bass=true})
	self.Train:LoadSystem("EmergencyDoors","Relay","Switch",{bass=true})
	
	
	for i=1,17 do
		self.Train:LoadSystem("SA"..i,"Relay","Switch",{normally_closed = false,bass=true})
	end
	self.Train:LoadSystem("SA1k","Relay","Switch",{normally_closed = true,bass=true})
	self.Train:LoadSystem("SA10k","Relay","Switch",{normally_closed = true,bass=true})
	self.Train:LoadSystem("SA14k","Relay","Switch",{normally_closed = true,bass=true})

	for i=1,29 do
		self.Train:LoadSystem("SF"..i,"Relay","Switch",{bass=true})
	end
	
	for i=31,57 do
		if i~=35 then self.Train:LoadSystem("SF"..i,"Relay","Switch",{normally_closed = true,bass=true}) end
	end
	--self.Train:LoadSystem("SA16","Relay","Switch",{bass=true})
	--self.Train:LoadSystem("SA17","Relay","Switch",{bass=true})
	--self.Train:LoadSystem("SA15","Relay","Switch",{bass=true})
	self.Train:LoadSystem("BARSBlock","Relay","Switch",{maxvalue=3,defaultvalue=0,bass=true})
	self.Train:LoadSystem("PowerReserve","Relay","Switch",{maxvalue=2,defaultvalue=0,bass=true})
	self.Train:LoadSystem("Battery","Relay","Switch",{bass=true})
	self.Train:LoadSystem("PowerOn","Relay","Switch",{bass=true})
	self.Train:LoadSystem("PowerOff","Relay","Switch",{bass=true})

	--self.Train:LoadSystem("SA14","Relay","Switch",{bass=true})

	self.Train:LoadSystem("PB","Relay","Switch",{bass=true})
	self.Controller = -3
	self.TargetController = -3

    self.AnnouncerPlaying = 0
	
	self.AppLights = 0
	self.CabLight = 0
	self.PanelLights = 0
	self.HeadlightsHalf = 0
	self.HeadlightsFull = 0
	self.RedLights = 0
	
	self.CabVent = 0
	
	self.DoorLeftL = 0
	self.DoorRightL = 0
	self.DoorCloseL = 0
	self.DoorBlockL = 0
	
	self.EmerBrakeL = 0
	self.EmerXodL = 0
	self.KAHl = 0
	self.ALSl = 0
	self.PRl = 0
	self.OtklRl = 0
	self.R_Linel = 0
	self.R_ChangeRoutel = 0
	self.Washerl = 0
	self.Wiperl = 0
	self.EmergencyControlsl = 0
	self.EmergencyDoorsl = 0
	self.GlassHeatingl = 0
	self.PowerOnl = 0
	self.PowerOffl = 0
	
	self.SalonLighting1 = 0
	self.SalonLighting2 = 0
	self.PassSchemes = 0
	self.PassSchemesL = 0
	self.PassSchemesR = 0
	self.WorkFan = 0
	self.LV = 0	
end

function TRAIN_SYSTEM:Inputs()
	return { "KVUp", "KVDown", "KV1", "KV2", "KV3", "KV4", "KV5", "KV6", "KV7", "KV8","KVUp_Unlocked"}
end

function TRAIN_SYSTEM:Outputs()
	return { "Controller","AnnouncerPlaying","TargetController",
			"AppLights","CabLight","PanelLights","HeadlightsHalf","HeadlightsFull","RedLights",
			"CabVent","WorkFan","LV",
			"DoorLeftL","DoorRightL","DoorCloseL","DoorBlockL",
			"EmerBrakeL","EmerXodL","KAHl","ALSl","PRl","OtklRl","R_Linel","R_ChangeRoutel","Washerl","Wiperl","EmergencyControlsl","EmergencyDoorsl","GlassHeatingl","PowerOffl","PowerOnl",
			"SalonLighting1","SalonLighting2","PassSchemes","PassSchemesL","PassSchemesR", 
	}
end
--if not TURBOSTROI then return end
function TRAIN_SYSTEM:TriggerInput(name,value)
	if name == "KVUp" and value > 0 and self.TargetController < 4 and self.Controller ~= -1 then
		self.TargetController = math.min(4,self.TargetController + 1)
	end
	if name == "KVUp_Unlocked" and value > 0 and self.TargetController < 4 then
		self.TargetController = math.min(4,self.TargetController + 1)
	end
	if name == "KVDown" and value > 0 and self.TargetController > -3 then
		self.TargetController = math.max(-3,self.TargetController - 1)
	end
	if name == "KV4" and value > 0 then self.TargetController = 4 end
	if name == "KV3" and value > 0 then self.TargetController = 3 end
	if name == "KV2" and value > 0 then self.TargetController = 2 end
	if name == "KV1" and value > 0 then self.TargetController = 1 end
	if name == "KV5" and value > 0 then self.TargetController = 0 end
	if name == "KV6" and value > 0 then self.TargetController = -1 end
	if name == "KV7" and value > 0 then self.TargetController = -2 end
	if name == "KV8" and value > 0 then self.TargetController = -3 end
	self.ControllerTimer = CurTime()-1
end
function TRAIN_SYSTEM:Think()
	if self.ControllerTimer and CurTime() - self.ControllerTimer > 0.06 and self.Controller ~= self.TargetController then
		local previousPosition = self.Controller
		self.ControllerTimer = CurTime()
		if self.TargetController > self.Controller then
			self.Controller = self.Controller + 1
		else
			self.Controller = self.Controller - 1
		end
		self.Train:PlayOnce("KV_"..previousPosition.."_"..self.Controller, "cabin",0.25,self.TargetController == self.Controller and 1.2 or 1.3)
	end
	if self.Controller == self.TargetController then
		self.ControllerTimer = nil
	end
end
