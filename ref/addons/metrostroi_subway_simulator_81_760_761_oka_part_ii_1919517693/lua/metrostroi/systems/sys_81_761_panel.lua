--------------------------------------------------------------------------------
-- 81-761 
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_761_Panel")
TRAIN_SYSTEM.DontAccelerateSimulation = false

function TRAIN_SYSTEM:Initialize()
    self.Train:LoadSystem("Battery","Relay","Switch",{bass=true})
    --Автоматы
	for i=31,57 do
		if i~=35 then self.Train:LoadSystem("SF"..i,"Relay","Switch",{normally_closed = true,bass=true}) end
	end
	self.SalonLighting1 = 0
	self.SalonLighting2 = 0
	self.PassSchemes = 0
	self.PassSchemesL = 0
	self.PassSchemesR = 0
	self.WorkFan = 0
	self.LV = 0	
end

function TRAIN_SYSTEM:Inputs()
    return { }
end

function TRAIN_SYSTEM:Outputs()
    return {"SalonLighting1","SalonLighting2","PassSchemes","PassSchemesL","PassSchemesR","WorkFan","LV" }
end