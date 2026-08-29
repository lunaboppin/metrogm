AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner
ENT.SyncTable = {
    "A53","A56","A54","A24","A39","A23","A14","A13","A31","A32","A16","A12","A49","A15","A27","A50","A8","A52","A19","A10","A22","A30","A1","A2","A3","A4","A5","A6","A72","A38","A20","A25","A37","A55","A45","A66","A51","A65","A28",
    "A70","A81","A80","A18",
    "VB","GV",
    "DriverValveBLDisconnect","DriverValveTLDisconnect","ParkingBrake",
    "A84","BPSNon","ConverterProtection","L_1","Start","VozvratRP"
}

function ENT:Initialize()
    self.Plombs = {
        A84 = true,
        Init = true,
    }
    self.LampType = 1

    -- Set model and initialize
    self:SetModel("models/metrostroi_train/81-5402/81-7145p_body.mdl")
    self.BaseClass.Initialize(self)
    self:SetPos(self:GetPos() + Vector(0,0,140))

    -- Create seat entities
    self.DriverSeat = self:CreateSeat("driver",Vector(-415-16,0,-48+2.5+6),Angle(0,-90,0),"models/vehicles/prisoner_pod_inner.mdl")

    -- Hide seats
    self.DriverSeat:SetColor(Color(0,0,0,0))
    self.DriverSeat:SetRenderMode(RENDERMODE_TRANSALPHA)

    -- Create bogeys
    if Metrostroi.BogeyOldMap then
        self.FrontBogey = self:CreateBogey(Vector( 317-5,0,-84),Angle(0,180,0),true,"717")
        self.RearBogey  = self:CreateBogey(Vector(-317+0,0,-84),Angle(0,0,0),false,"717")
        self.FrontCouple = self:CreateCouple(Vector( 414+6.545,0,-62),Angle(0,0,0),true,"717")
        self.RearCouple  = self:CreateCouple(Vector(-419.5-6.545,0,-62),Angle(0,180,0),false,"717")
    else
        self.FrontBogey = self:CreateBogey(Vector( 317-11,0,-80),Angle(0,180,0),true,"717")
        self.RearBogey  = self:CreateBogey(Vector(-317+0,0,-80),Angle(0,0,0),false,"717")
        self.FrontCouple = self:CreateCouple(Vector( 410-2,0,-66),Angle(0,0,0),true,"717")
        self.RearCouple  = self:CreateCouple(Vector(-423+2,0,-66),Angle(0,180,0),false,"717")
    end

    local pneumoPow = 1.1+(math.random()^0.4)*0.3
    self.FrontBogey.PneumaticPow = pneumoPow
    self.RearBogey.PneumaticPow = pneumoPow

    -- Initialize key mapping
    self.KeyMap = {
        [KEY_1] = "StartSet",
        [KEY_8] = "StartSet",
        [KEY_W] = "StartSet",
        [KEY_PAD_DIVIDE] = "StartSet",
        [KEY_0] = "RV+",
        [KEY_9] = "RV-",
        [KEY_PAD_PLUS] = "RV+",
        [KEY_PAD_MINUS] = "RV-",
        [KEY_G] = "VozvratRPSet",
        [KEY_L] = "HornEngage",

        [KEY_F] = "PneumaticBrakeUp",
        [KEY_R] = "PneumaticBrakeDown",
        [KEY_PAD_1] = "PneumaticBrakeSet1",
        [KEY_PAD_2] = "PneumaticBrakeSet2",
        [KEY_PAD_3] = "PneumaticBrakeSet3",
        [KEY_PAD_4] = "PneumaticBrakeSet4",
        [KEY_PAD_5] = "PneumaticBrakeSet5",
        [KEY_PAD_6] = "PneumaticBrakeSet6",
        [KEY_PAD_7] = "PneumaticBrakeSet7",
        [KEY_PAD_0] = "DriverValveDisconnect",

        [KEY_BACKSPACE] = "EmergencyBrakeValveToggle",

        [KEY_LSHIFT] = {
            [KEY_L] = "DriverValveDisconnect",
        },

        [KEY_RSHIFT] = {
            [KEY_L] = "DriverValveDisconnect",
        },
    }


    self.InteractionZones = {
        {
            ID = "FrontBrakeLineIsolationToggle",
            Pos = Vector(461.5, -34, -53), Radius = 8,
        },
        {
            ID = "FrontTrainLineIsolationToggle",
            Pos = Vector(461.5, 33, -53), Radius = 8,
        },
        {
            ID = "RearBrakeLineIsolationToggle",
            Pos = Vector(-474.5, 33, -53), Radius = 8,
        },
        {
            ID = "RearTrainLineIsolationToggle",
            Pos = Vector(-474.5, -34, -53), Radius = 8,
        },
        {
            ID = "ParkingBrakeToggle",
            Pos = Vector(-469, -54.5, -53), Radius = 8,
        },
        {
            ID = "FrontDoor",
            Pos = Vector(451.5,35,4), Radius = 20,
        },
        {
            ID = "RearDoor",
            Pos = Vector(-464.8,-35,4), Radius = 20,
        },
        {
            ID = "GVToggle",
            Pos = Vector(140.50,62,-64), Radius = 10,
        },
        {
            ID = "VBToggle",
            Pos = Vector(-470 -15, 53), Radius = 20,
        },
        {
            ID = "AirDistributorDisconnectToggle",
            Pos = Vector(-177, -66, -50), Radius = 20,
        },
    }

    -- Lights
    self.Lights = {
        -- Interior
        [11] = { "dynamiclight",    Vector( 200, 0, 0), Angle(0,0,0), Color(255,245,245), brightness = 3, distance = 400 , fov=180,farz = 128 },
        [12] = { "dynamiclight",    Vector(   0, 0, 0), Angle(0,0,0), Color(255,245,245), brightness = 3, distance = 400, fov=180,farz = 128 },
        [13] = { "dynamiclight",    Vector(-200, 0, 0), Angle(0,0,0), Color(255,245,245), brightness = 3, distance = 400 , fov=180,farz = 128 },

        -- Side lights
        [15] = { "light",Vector(-52,67,45.5)+Vector(0,0.9,3.25), Angle(0,0,0), Color(254,254,254), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [16] = { "light",Vector(-52,67,45.5)+Vector(0,0.9,-0.02), Angle(0,0,0), Color(40,240,122), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [17] = { "light",Vector(-52,67,45.5)+Vector(0,0.9,-3.3), Angle(0,0,0), Color(254,210,18), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [18] = { "light",Vector(39,-67,45.5)+Vector(0,-0.9,3.25), Angle(0,0,0), Color(254,254,254), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [19] = { "light",Vector(39,-67,45.5)+Vector(0,-0.9,-0.02), Angle(0,0,0), Color(40,240,122), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [20] = { "light",Vector(39,-67,45.5)+Vector(0,-0.9,-3.3), Angle(0,0,0), Color(254,210,18), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },

        [21] = { "light",Vector(-6.5,67,51.2)+Vector(3.25,0.9,-0.02), Angle(0,0,0), Color(254,254,254), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [22] = { "light",Vector(-6.5,67,51.2)+Vector(-0.06,0.9,-0.02), Angle(0,0,0), Color(40,240,122), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [23] = { "light",Vector(-6.5,67,51.2)+Vector(-3.33,0.9,-0.02), Angle(0,0,0), Color(254,210,18), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [24] = { "light",Vector(-6.5,-67,51.2)+Vector(3.33,-0.9,-0.02), Angle(0,0,0), Color(254,254,254), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [25] = { "light",Vector(-6.5,-67,51.2)+Vector(0.06,-0.9,-0.02), Angle(0,0,0), Color(40,240,122), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
        [26] = { "light",Vector(-6.5,-67,51.2)+Vector(-3.28,-0.9,-0.02), Angle(0,0,0), Color(254,210,18), brightness = 0.1, scale = 0.2, texture = "sprites/light_glow02.vmt" },
    }


    -- Cross connections in train wires
    self.TrainWireInverts = {
        [28] = true,
        [34] = true,
    }
    self.TrainWireCrossConnections = {
        [5] = 4, -- Reverser F<->B
        [31] = 32, -- Doors L<->R
    }

    -- Setup door positions
    self.LeftDoorPositions = {}
    self.RightDoorPositions = {}
    for i=0,3 do
        table.insert(self.LeftDoorPositions,Vector(353.0 - 35*0.5 - 231*i,65,-1.8))
        table.insert(self.RightDoorPositions,Vector(353.0 - 35*0.5 - 231*i,-65,-1.8))
    end

    -- BPSN type
    self.BPSNType = 5
    self:SetNW2Int("BPSNType",self.BPSNType)
    self.OldTexture = 0

    self.otsek_torec_1_bm = false
	self.otsek_torec_2_bm = false
	self.otsek_torec_3_bm = false
    self.otsek_torec_5_bm = false
	self.otsek_torec_6_bm = false

    self.Lamps = {}

    self:TrainSpawnerUpdate()
end
function ENT:TrainSpawnerUpdate()
    local typ = self:GetNW2Int("Type")
    local num = self.WagonNumber
    math.randomseed(num+817171)
    local passtex = "Def_717SPBWhite"
    if typ == 1 then --PAKSDM
        self.Electric:TriggerInput("X2PS",0)
        self.Electric:TriggerInput("Type",self.Electric.LVZ_3)
    elseif typ == 2 then --PUAV
        self.Electric:TriggerInput("X2PS",1)
        self.Electric:TriggerInput("Type",self.Electric.LVZ_2)
    end
    self:SetNW2String("PassTexture",passtex)
    self.Pneumatic.ValveType = 2
    self.Announcer.AnnouncerType = self:GetNW2Int("Announcer",1)
    self:UpdateTextures()

    self:SetNW2Float("UPONoiseVolume",math.Rand(0,0.4))
    self:SetNW2Float("UPOVolume",math.Rand(0.9,1))
    self:SetNW2Float("UPOBuzzVolume",math.Rand(0.6,0.9))

    local pneumoPow = 1.3+(math.random()^1.2)*0.3
    if IsValid(self.FrontBogey) then
        self.FrontBogey:SetNW2Int("SquealType",math.floor(math.random()*7)+1)
        self.FrontBogey.PneumaticPow = pneumoPow
    end
    if IsValid(self.RearBogey) then
        self.RearBogey:SetNW2Int("SquealType",math.floor(math.random()*7)+1)
        self.RearBogey.PneumaticPow = pneumoPow
    end
    math.randomseed(os.time())
end

--------------------------------------------------------------------------------
function ENT:Think()
    local retVal = self.BaseClass.Think(self)
    local Panel = self.Panel

    local SalonLightning = self.Panel.EmergencyLights > 0 or self.Panel.MainLights > 0
    for i = 1,12 do
        self:SetPackedBool("lightsActive"..i,SalonLightning)
    end
    self:SetLightPower(11, SalonLightning,SalonLightning and 1 or 0)
    self:SetLightPower(12, SalonLightning,SalonLightning and 1 or 0)
    self:SetLightPower(13, SalonLightning,SalonLightning and 1 or 0)
    -- Side lights
    self:SetLightPower(15, Panel.DoorsW > 0.5)
    self:SetLightPower(18, Panel.DoorsW > 0.5)
    self:SetLightPower(16, Panel.GreenRP > 0.5)
    self:SetLightPower(19, Panel.GreenRP > 0.5)
    self:SetLightPower(17, Panel.BrW > 0.5)
    self:SetLightPower(20, Panel.BrW > 0.5)

    --self:SetLightPower(21, Panel.DoorsW > 0.5)
    --self:SetLightPower(24, Panel.DoorsW > 0.5)
    --self:SetLightPower(22, Panel.GreenRP > 0.5)
    --self:SetLightPower(25, Panel.GreenRP > 0.5)
    --self:SetLightPower(23, Panel.BrW > 0.5)
    --self:SetLightPower(26, Panel.BrW > 0.5)
    self:SetPackedBool("DoorsW",self.Panel.DoorsW > 0)
    self:SetPackedBool("GRP",self.Panel.GreenRP > 0)
    self:SetPackedBool("BrW",self.Panel.BrW > 0)

    self:SetPackedBool("M1_3",Panel.M1_3 > 0)
    self:SetPackedBool("M4_7",Panel.M4_7 > 0)

    -- Signal if doors are open or no to platform simulation
    self.LeftDoorsOpen =
        (self.Pneumatic.LeftDoorState[1] > 0.5) or
        (self.Pneumatic.LeftDoorState[2] > 0.5) or
        (self.Pneumatic.LeftDoorState[3] > 0.5) or
        (self.Pneumatic.LeftDoorState[4] > 0.5)
    self.RightDoorsOpen =
        (self.Pneumatic.RightDoorState[1] > 0.5) or
        (self.Pneumatic.RightDoorState[2] > 0.5) or
        (self.Pneumatic.RightDoorState[3] > 0.5) or
        (self.Pneumatic.RightDoorState[4] > 0.5)

    --self:SetPackedRatio("Crane", self.Pneumatic.RealDriverValvePosition)
    --self:SetPackedRatio("Controller", (self.KV.ControllerPosition+3)/7)
    self:SetPackedRatio("BLPressure", self.Pneumatic.BrakeLinePressure/16.0)
    self:SetPackedRatio("TLPressure", self.Pneumatic.TrainLinePressure/16.0)
    self:SetPackedRatio("BCPressure", self.Pneumatic.BrakeCylinderPressure/6.0)

    self:SetPackedRatio("BatteryVoltage",self.Panel["V1"]*self.Battery.Voltage/150.0)
    self:SetPackedBool("Compressor",self.Pneumatic.Compressor > 0)
    self:SetPackedBool("RK",self.RheostatController.Velocity ~= 0.0)
    self:SetPackedBool("BPSN",self.PowerSupply.X2_2 > 0)
    self:SetPackedRatio("RV",self.RV.Value/2)
    self:SetPackedRatio("CranePosition", self.Pneumatic.RealDriverValvePosition)
    self:SetPackedBool("RZP",Panel.RZP > 0)


    self:SetPackedBool("FrontDoor",self.FrontDoor)
    self:SetPackedBool("RearDoor",self.RearDoor)
    self:SetPackedBool("CouchCap",self.CouchCap)
	self:SetPackedBool("otsek_torec_1_cp",self.otsek_torec_1_bm)
	self:SetPackedBool("otsek_torec_2_cp",self.otsek_torec_2_bm)
	self:SetPackedBool("otsek_torec_3_cp",self.otsek_torec_3_bm)
	self:SetPackedBool("otsek_torec_5_cp",self.otsek_torec_5_bm)
	self:SetPackedBool("otsek_torec_6_cp",self.otsek_torec_6_bm)

    self:SetPackedBool("AnnouncerBuzz",Panel.AnnouncerBuzz > 0)
    self:SetPackedBool("AnnPlay",Panel.AnnouncerPlaying > 0)

    self:SetPackedRatio("Speed", self.Speed/100)
    self.Engines:TriggerInput("Speed",self.Speed)
    if IsValid(self.FrontBogey) and IsValid(self.RearBogey) and not self.IgnoreEngine then
        local A = 2*self.Engines.BogeyMoment
        --self.FrontBogey.MotorForce = 27000+1000*(A < 0 and 1 or 0)
        --self.RearBogey.MotorForce  = 27000+1000*(A < 0 and 1 or 0)
        self.FrontBogey.MotorForce = 22500+5500*(A < 0 and 1 or 0)
        self.RearBogey.MotorForce  = 22500+5500*(A < 0 and 1 or 0)
        self.FrontBogey.Reversed = (self.Reverser.NZ > 0.5)
        self.RearBogey.Reversed = (self.Reverser.VP > 0.5)

        -- These corrections are required to beat source engine friction at very low values of motor power
        local A = 2*self.Engines.BogeyMoment
        --[[ if self.Speed < 15 then
            local pow = 1-0.7*(15.0-self.Speed)/15.0
            A = A < 0 and -math.abs(A)^pow or A^pow
        end--]]
        local P = math.max(0,0.04449 + 1.06879*math.abs(A) - 0.465729*A^2)
        if math.abs(A) > 0.4 then P = math.abs(A) end
        if math.abs(A) < 0.05 then P = 0 end
        if self.Speed < 10 then P = P*(1.0 + 0.5*(10.0-self.Speed)/10.0) end
        self.RearBogey.MotorPower  = P*0.5*((A > 0) and 1 or -1)
        self.FrontBogey.MotorPower = P*0.5*((A > 0) and 1 or -1)

        -- Apply brakes
        self.FrontBogey.PneumaticBrakeForce = 50000.0-2000
        self.FrontBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.FrontBogey.ParkingBrakePressure = math.max(0,(2.6-self.Pneumatic.ParkingBrakePressure)/2.6)
        self.FrontBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
        self.RearBogey.PneumaticBrakeForce = 50000.0-2000
        self.RearBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.RearBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
        --self.RearBogey.ParkingBrake = self.ParkingBrake.Value > 0.5
    end

    self:GenerateJerks()

    -- Send networked variables
    --self:SendPackedData()
    return retVal
end


--------------------------------------------------------------------------------
function ENT:OnCouple(train,isfront)
    if isfront and self.FrontAutoCouple then
        self.FrontBrakeLineIsolation:TriggerInput("Open",1.0)
        self.FrontTrainLineIsolation:TriggerInput("Open",1.0)
        self.FrontAutoCouple = false
    elseif not isfront and self.RearAutoCouple then
        self.RearBrakeLineIsolation:TriggerInput("Open",1.0)
        self.RearTrainLineIsolation:TriggerInput("Open",1.0)
        self.RearAutoCouple = false
    end
    self.BaseClass.OnCouple(self,train,isfront)
end
function ENT:OnButtonPress(button,ply)
    if button == "otsek_torec_1_bm" then self.otsek_torec_1_bm = not self.otsek_torec_1_bm end
	if button == "otsek_torec_2_bm" then self.otsek_torec_2_bm = not self.otsek_torec_2_bm end
	if button == "otsek_torec_3_bm" then self.otsek_torec_3_bm = not self.otsek_torec_3_bm end
    if button == "otsek_torec_5_bm" then self.otsek_torec_5_bm = not self.otsek_torec_5_bm end
	if button == "otsek_torec_6_bm" then self.otsek_torec_6_bm = not self.otsek_torec_6_bm end
    if button == "FrontDoor" then self.FrontDoor = not self.FrontDoor end
    if button == "RearDoor" then self.RearDoor = not self.RearDoor end
    if button == "CouchCap" then
        if self.CouchCap and self.Pneumatic.DriverValvePosition>2 then return end
        self.CouchCap = not self.CouchCap
    end
    if not self.CouchCap and (not button:find("VB") and not button:find("GV") and not button:find("Isolation") and not button:find("Parking")) then return true end

    if button == "DriverValveDisconnect" then
        if self.DriverValveBLDisconnect.Value == 0 or self.DriverValveTLDisconnect.Value == 0 then
            self.DriverValveBLDisconnect:TriggerInput("Set",1)
            self.DriverValveTLDisconnect:TriggerInput("Set",1)
        else
            self.DriverValveBLDisconnect:TriggerInput("Set",0)
            self.DriverValveTLDisconnect:TriggerInput("Set",0)
        end
        return
    end
    if string.find(button,"PneumaticBrakeSet") then
        self.Pneumatic:TriggerInput("BrakeSet",tonumber(button:sub(-1,-1)))
        return
    end
end

function ENT:OnButtonRelease(button)
    if string.find(button,"PneumaticBrakeSet") then
        local pos = tonumber(button:sub(-1,-1))
        if button == "PneumaticBrakeSet1" then
            self.Pneumatic:TriggerInput("BrakeSet",2)
        end
        return
    end
end