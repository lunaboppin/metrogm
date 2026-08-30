--------------------------------------------------------------------------------
-- 81-718 additional switch equipment unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_718_BKVA")

function TRAIN_SYSTEM:Initialize()
    self.KM1 = 0 -- Electric heater contactor
    self.KM2 = 0 -- Electric compressor contactor
    self.KM3 = 0 -- Contactors for the car's control circuits
    self.KM4 = 0 -- Door relay
    self.KM5 = 0 -- Sub-exciter contactor
end

function TRAIN_SYSTEM:Inputs()
	return {  }
end

function TRAIN_SYSTEM:Outputs()
	return {  }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end

function TRAIN_SYSTEM:Think()
end
