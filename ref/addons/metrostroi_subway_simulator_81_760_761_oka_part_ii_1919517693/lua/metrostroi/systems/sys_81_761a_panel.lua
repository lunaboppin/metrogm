--------------------------------------------------------------------------------
-- 81-761A
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_761A_Panel")
TRAIN_SYSTEM.DontAccelerateSimulation = false

function TRAIN_SYSTEM:Initialize()
    self.Train:LoadSystem("Battery","Relay","Switch",{bass=true})
	self.Train:LoadSystem("PowerOn","Relay","Switch",{bass=true})		
    --Автоматы
	for i=31,59 do
		self.Train:LoadSystem("SF"..i,"Relay","Switch",{normally_closed = true,bass=true})
	end
	self.SalonLighting1 = 0
	self.SalonLighting2 = 0
	self.PassSchemes = 0
	self.PassSchemesL = 0
	self.PassSchemesR = 0
	self.LV = 0		
	if self.Train.AsyncInverter then 
		self.WorkFan = 0
	end
end

function TRAIN_SYSTEM:Inputs()
    return { }
end

function TRAIN_SYSTEM:Outputs()
    return {"SalonLighting1","SalonLighting2","PassSchemes","PassSchemesL","PassSchemesR","WorkFan","LV" }
end
