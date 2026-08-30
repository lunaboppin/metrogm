--------------------------------------------------------------------------------
-- 81-718 HV switch equpment unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_718_BSKA")

function TRAIN_SYSTEM:Initialize()
    -- Line contactor K1 (KR)
    self.Train:LoadSystem("K1","Relay","PK-162",{bass = true,close_time=0.1})
    -- Line contactor K2 (Drive)
    self.Train:LoadSystem("K2","Relay","PK-162",{bass = true,close_time=0.1})
    -- Line contactor K3 (Brake)
    self.Train:LoadSystem("K3","Relay","PK-162",{bass = true,close_time=0.1})

    -- Reverser contactor(s), "Forward"
    self.Train:LoadSystem("KMR1","Relay","PK-162",{bass = true,close_time=0.1})
    -- Reverser contactor(s), "Reverse"
    self.Train:LoadSystem("KMR2","Relay","PK-162",{bass = true,close_time=0.1})
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
