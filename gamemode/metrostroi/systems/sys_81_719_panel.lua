--------------------------------------------------------------------------------
-- 81-719 controller panel
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_719_Panel")

function TRAIN_SYSTEM:Initialize()
    -- Battery switch (VB)
    self.Train:LoadSystem("VB","Relay","Switch",{bass = true})

    self.Train:LoadSystem("SF2" ,"Relay","Switch", {bass = true, normally_closed = true})   --Train power supply
    self.Train:LoadSystem("SF3" ,"Relay","Switch", {bass = true, normally_closed = true})   --Car power supply, TsUV (car central control unit)
    self.Train:LoadSystem("SF4" ,"Relay","Switch", {bass = true, normally_closed = true})   --Power supply for BUV (car control unit), PTTI, BSKA, TsUV
    self.Train:LoadSystem("SF5" ,"Relay","Switch", {bass = true, normally_closed = true})   --BKTsU (centralized control unit) control
    self.Train:LoadSystem("SF10","Relay","Switch", {bass = true, normally_closed = true})   --Ventilation fans group 1
    self.Train:LoadSystem("SF11","Relay","Switch", {bass = true, normally_closed = true})   --Ventilation fans group 2
    self.Train:LoadSystem("SF12","Relay","Switch", {bass = true, normally_closed = true})   --BBE (electro-pneumatic brake unit) turn-on
    self.Train:LoadSystem("SF13","Relay","Switch", {bass = true, normally_closed = true})   --BBE turn-off
    self.Train:LoadSystem("SF14","Relay","Switch", {bass = true, normally_closed = true})   --TsUV contactor
    self.Train:LoadSystem("SF15","Relay","Switch", {bass = true, normally_closed = true})   --Backup TsUV turn-on
    self.Train:LoadSystem("SF16","Relay","Switch", {bass = true, normally_closed = true})   --Saloon lighting control
    self.Train:LoadSystem("SF17","Relay","Switch", {bass = true, normally_closed = true})   --Door closing
    self.Train:LoadSystem("SF18","Relay","Switch", {bass = true, normally_closed = true})   --Left door opening
    self.Train:LoadSystem("SF19","Relay","Switch", {bass = true, normally_closed = true})   --Backup door closing
    self.Train:LoadSystem("SF20","Relay","Switch", {bass = true, normally_closed = true})   --Right door opening
    self.Train:LoadSystem("SF21","Relay","Switch", {bass = true, normally_closed = true})   --Main compressor motor (MK) control
    self.Train:LoadSystem("SF22","Relay","Switch", {bass = true, normally_closed = true})   --Backup compressor motor (MK) control
    self.Train:LoadSystem("SF23","Relay","Switch", {bass = true, normally_closed = true})   --Ventilation fan group 1 contactor
    self.Train:LoadSystem("SF24","Relay","Switch", {bass = true, normally_closed = true})   --Ventilation fan group 2 contactor
    self.Train:LoadSystem("SF25","Relay","Switch", {bass = true, normally_closed = true})   --Current collectors group 1
    self.Train:LoadSystem("SF26","Relay","Switch", {bass = true, normally_closed = true})   --VZ (backup brake valve) No.1
    self.Train:LoadSystem("SF27","Relay","Switch", {bass = true, normally_closed = true})   --Power supply for BVA (Automatic Circuit Breakers Unit)

    self.Train:LoadSystem("SF29","Relay","Switch", {bass = true, normally_closed = true})   --VZ No.2

    self.Train:LoadSystem("SF34","Relay","Switch", {bass = true, normally_closed = true})   --Power supply for ventilation fan group 1
    self.Train:LoadSystem("SF35","Relay","Switch", {bass = true, normally_closed = true})   --Power supply for ventilation fan group 2

    self.Train:LoadSystem("SF42","Relay","Switch", {bass = true, normally_closed = true})   --Auxiliary excitation
    self.Train:LoadSystem("SF43","Relay","Switch", {bass = true, normally_closed = true})   --Saloon emergency lighting
    self.Train:LoadSystem("SF44","Relay","Switch", {bass = true, normally_closed = true})   --Saloon lighting power supply
    self.Train:LoadSystem("SF45","Relay","Switch", {bass = true, normally_closed = true})   --BBE and saloon lighting contactor control
    self.Train:LoadSystem("SF46","Relay","Switch", {bass = true, normally_closed = true})   --BVA control power supply

    self.Train:LoadSystem("SF56","Relay","Switch", {bass = true})   --Electric compressor (intermediate car)

    self.Train:LoadSystem("SF72","Relay","Switch", {bass = true, normally_closed = true})   --Parking brake


    --[[ ----------------- PPU (assistant driver's panel) -----------------
    self.Train:LoadSystem("SBU1" ,"Relay","Switch") --Drive 1
    self.Train:LoadSystem("SBU2" ,"Relay","Switch") --VZ
    self.Train:LoadSystem("SAU2" ,"Relay","Switch") --Compressor
    self.Train:LoadSystem("SBU3" ,"Relay","Switch") --BV (high-speed circuit breaker) off
    self.Train:LoadSystem("SBU4" ,"Relay","Switch") --BBE on--]]
    self.EL1 = 0
    self.EL3_6 = 0
    self.EL7_30 = 0
    self.HL13 = 0
    self.HL46 = 0
    self.HL25 = 0
    self.HL6 = 0
    self.TW28 = 0

    self.AnnouncerPlaying = 0
    self.AnnouncerBuzz = 0

    self.V1 = 0
end

local outputs = {"EL1","EL3_6","EL7_30","HL13","HL46","HL25","HL6","TW28","V1","AnnouncerPlaying","AnnouncerBuzz",}
function TRAIN_SYSTEM:ClientInitialize()
end

function TRAIN_SYSTEM:Outputs()
    return outputs
end

