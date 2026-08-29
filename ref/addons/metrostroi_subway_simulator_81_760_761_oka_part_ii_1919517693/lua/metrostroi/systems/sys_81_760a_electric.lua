--------------------------------------------------------------------------------
-- ������������� ����
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_760A_Electric")
TRAIN_SYSTEM.DontAccelerateSimulation = false

local function Clamp(val,min,max)
    return math.max(min,math.min(max,val))
end

local function Rand(a,b) 
	return a+(b-a)*math.random()
end

local function sign(x)
	return (x>0 and 1 or x < 0 and -1 or 0)
end

function TRAIN_SYSTEM:Initialize()
	-- General power output
	self.Main750V = 0.0
	self.Aux750V = 0.0
	self.Power750V = 0.0
	self.Aux80V = 0.0
	self.Lights80V = 0.0
	self.Battery80V = 0.0

	-- Total energy used by train
	self.ElectricEnergyUsed = 0 -- joules
	self.ElectricEnergyDissipated = 0 -- joules
	self.EnergyChange = 0

	--Train wire outside power
	-- Need many iterations for engine simulation to converge
	self.SubIterations = 16
	-- ������� �����������

	self.Train:LoadSystem("BV","Relay")
	self.Train:LoadSystem("GV","Relay","GV_10ZH",{bass=true})

	self.BTB = 0
	self.Brake = 0
	self.Drive = 0	

	self.BUTP = 0
	self.BUFT = 0
	self.BTBr = 0
	
    self.Recurperation = 0
    self.Iexit = 0
    self.Chopper = 0	
	self.MK = 0
	self.V2 = 0
	self.V1 = 0
	self.SD = 0
	self.KM2 = 0

	self.Slope = 0
	self.command = 0
	self.commandTimer = 0

	self.EmerXod = 0
	self.UPIPower = 0
	self.Power = 1
	self.Power1 = 0
	self.PowerReserve = 0
	--self.Power = nil
	--self.Train:LoadSystem("Telemetry",nil,"",{"Electric","Panel","Engines"})
end


function TRAIN_SYSTEM:Inputs()
	return { "EnergyChange","PowerTimer","Slope" }
end

function TRAIN_SYSTEM:Outputs()
	return {  "Brake", "Drive","V2","V1",
			 "Main750V", "Power750V", "Aux750V", "Aux80V", "Lights80V", "Battery80V", 
			 "BTB","BTBr",
			 "MK","Power","SD","KM2","EmerXod","Power1","UPIPower","PowerReserve",
			"Recurperation","Iexit","Itotal","Chopper","ElectricEnergyUsed","ElectricEnergyDissipated","EnergyChange","BUFT"
		}
end
--[[
TRAIN_SYSTEM.ENGConfig = {
	{
		{  0,0.50},
		{  1,0.70},
		{  5,0.90},
		{ 10,1.15},
		{ 15,1.25},--1.33
		{ 20,1.38},
		{ 30,0.98*1.43},
		{ 40,0.76*1.43},
		{ 50,0.60*1.43},
		{ 60,0.50*1.43},
		{ 70,0.43*1.43},
		{ 80,0.37*1.43},--0.35
		{100,0.29*1.43},
	},
	{
		{  0,0.50},
		{  1,0.70},
		{  5,0.78},
		{ 10,0.82},
		{ 15,0.86},--1.33 1.25
		{ 20,0.90},--1.35
		{ 30,0.98*1.45},--0.98*1.5
		{ 40,0.76*1.45},
		{ 50,0.60*1.45},
		{ 60,0.50*1.45},
		{ 70,0.43*1.45},
		{ 80,0.35*1.45},
		{100,0.29*1.45},	
	}
}
TRAIN_SYSTEM.PowerConfig = {
	{
		[1] = 0.40,
		[2] = 0.60,
		[3] = 0.75,
		[4] = 1.00,
	},
	{
		[1] = 0.60,
		[2] = 0.75,
		[3] = 1.00,
	}
}
TRAIN_SYSTEM.CurrentConfig = {
	[1] = 150,
	[2] = 200,
	[3] = 260,
	[4] = 340,
	[-1]= 150,
	[-2]= 200,
	[-3]= 340,	
}
]]
TRAIN_SYSTEM.CurrentConfig = {
	{
		[1] = 150,
		[2] = 200,
		[3] = 260,
		[4] = 320,
		[0] = 0,
		[-1]= 150,
		[-2]= 200,
		[-3]= 320,
	},
	{
		[1] = 0.67,
		[2] = 0.69,
		[3] = 0.77,
		[4] = 0.79,
		[0] = 0,
		[-1]= 0.55,
		[-2]= 0.60,
		[-3]= 0.85,
	},
}

local function interpolate(tbl, num)
  for i=1,#tbl do
    local curr,next = tbl[i],tbl[i+1]
    if not next then
      return curr[2]
    elseif curr[1] <= num and num <= next[1] then
      return curr[2] + (next[2]-curr[2])*((num-curr[1])/(next[1]-curr[1]))
    end
  end
end

function TRAIN_SYSTEM:TriggerInput(name,value)
	if name == "Power" and value then
		self.PowerTimer = CurTime()+6
		self.PowerTimer = CurTime()+6
		--self.PowerTimer = CurTime()+6
	end
	if name == "Slope" then
		self.Slope = value
	end
end
local S = {}
local function C(x) return x and 1 or 0 end
local min,max,abs = math.min,math.max,math.abs
--------------------------------------------------------------------------------
function TRAIN_SYSTEM:Think(dT,iter)
	local Train = self.Train
	local Async = Train.AsyncInverter	
	local Panel = Train.Panel
	local BUV = Train.BUV
	local RV = Train.RV
	--	local dT = dT/8
	
	self.Battery80V = BUV.AKBVoltage --((Train.SF1 and Train.SF1.Value or 1)*Train.Battery.Value > 0) and (PSN and 80 or 69) or Train:ReadTrainWire(1) > 0.5 and 66 or 0

	local P = C(self.Battery80V > 62)-- and 1 or 0
	self.Power1 = P
	local PowerPSN = C(self.Battery80V > 79)-- and 1 or 0
	local HV = C(550 <= self.Main750V and self.Main750V <= 975)-- and 1 or 0
	local BO = C(self.Battery80V > 67)-- and 1 or 0	

	----------------------------------------------------------------------------
	-- Information only
	----------------------------------------------------------------------------
	-- ������� ��������������� ����� 80V
	local PSN = BUV.PSN*BO > 0
	self.Aux80V = PSN and 80 or 69
	-- ������� ��������� 80V
	self.Lights80V = PSN and 80 or 0--Train.PowerSupply.XT3_4

    self.BUFT = P*Train.Battery.Value*Train.SF55.Value*self.KM2

	----------------------------------------------------------------------------
	-- Voltages from the third rail
	----------------------------------------------------------------------------
	-- ���������� � ������� ������������� �����
	local dU = (Train.TR.Main750V-self.Main750V)
	if Train.TR.Main750V < 550 and self.Main750V >= 550 then
		if not self.Main750VTimer then self.Main750VTimer = CurTime()+Rand(0.4,0.8) end
		dU = 0
		if CurTime()-self.Main750VTimer > 0 then self.Main750V = math.max(530,Train.TR.Main750V) self.Main750VTimer = nil end
	end
	self.Main750V = self.Main750V + dU*dT/((dU < 0 and self.Main750V < 530 and 0.016 or 0.0014)*1100)
	-- ���������� � �������������� ������������� �����
	self.Aux750V  = self.Main750V -- * Train.PNB_1250_2.Value * Train.KVC.Value
	-- ������� ���������� ������� �����
	self.Power750V = self.Main750V*Train.GV.Value
	
	if RV then
		Train:WriteTrainWire(72,P*Train.SF27.Value*Train.PowerOn.Value)--вкл бс
	end
	--if RV then
		--Train:WriteTrainWire(8,P*(Train.PowerOff.Value+(1-Train.SF27.Value)))--выкл бс
	--end
	if self.Battery80V < 62 and self.Power then--67
		self.Power = nil
	elseif (BUV.PowerOff or 0)+(2-(Train.SF35 and Train.SF35.Value or 1)-(Train.SF58 and Train.SF58.Value or 1)) > 0 and not self.PowerOffTimer then
		self.PowerOffTimer = CurTime()+Rand(1,3)
	elseif (Train:ReadTrainWire(72) > 0 or P*(Train.SF58 and Train.SF58.Value or 1)*(Train.SF35 and Train.SF35.Value or 1)*Train.PowerOn.Value > 0) and not self.PowerTimer then
		self.PowerTimer = CurTime()+Rand(1,2)
	end
	if self.PowerTimer and self.PowerOffTimer then self.PowerTimer = nil end
	if self.PowerTimer and CurTime()-self.PowerTimer > 0 then
		self.Power = 1
		self.PowerTimer = nil
	end
	if self.PowerOffTimer and CurTime()-self.PowerOffTimer > 0 then
		self.Power = 0
		self.PowerOffTimer = nil
	end
	self.Power = (P == 0) and nil or self.Power
	if not RV then
		Train:WriteTrainWire(75,P*(self.Power or 0))
		Train:WriteTrainWire(74,P*(1-(self.Power or 0)))
	end
	self.KM2 = RV and 1 or (self.Power and self.Power == 1 and 1 or 0)
	
	--Train:WriteTrainWire(1,self.Battery80V > 67 and 1 or 0)
	--Train:WriteTrainWire("AKB",self.Battery80V)

	----------------------------------------------------------------------------
	-- Some internal electric
	----------------------------------------------------------------------------

	if RV then
		local UPIPower = P*Train.SF6.Value
		self.UPIPower = UPIPower
		local PowerReserve = P*min(1,(1-Train.SF6.Value)*abs(RV.KRRPosition)+Train.SF6.Value)--self.Battery80V*(1-Train.SF6.Value)*(RV.KRRPosition ~= 0 and 1 or 0) > 62 or power	
		self.PowerReserve = PowerReserve
		--local HeadlightsPower = power and (Train.SF16.Value*Train.SF17.Value > 0 and (RV["KRO11-12"] > 0 and Train.HeadlightsSwitch.Value > 1 or Train.SA13.Value*Train.EmergencyControls.Value > 0) and 1 or (Train.HeadlightsSwitch.Value > 0 and RV["KRO11-12"] > 0 or Train.EmergencyControls.Value > 0.5) and Train.SF16.Value+(Train.HeadlightsSwitch.Value > 1 and Train.SF17.Value or 0) > 0 and 0.5) or 0
		Train:WriteTrainWire(20,P*Train.SF29.Value*Train.SA15.Value)
	
		Train:WriteTrainWire(2,P*Train.SF7.Value*Train.EnableBVEmer.Value)
		--Train:WriteTrainWire(34,P*(RV["KRO1-2"]--[[*Train.SF2.Value]] + RV["KRR1-2"]--[[*Train.SF3.Value]]))
		Train:WriteTrainWire(35,P*(RV["KRO1-2"]--[[*Train.SF2.Value]] *Train.SF7.Value + RV["KRR1-2"]*Train.SF8.Value))
		Train:WriteTrainWire(36,Train.SF3.Value*Train.EmergencyControls.Value)

		local Drive = Train.BARS.Drive
		--local PowerReserve = (self.Battery80V*(1-Train.SF6.Value)*(RV.KRRPosition ~= 0 and 1 or 0) > 62 or self.Battery80V*Train.SF6.Value > 62) and 1 or 0
		local Orientation = C(Train.SF9.Value+RV["KRR7-8"] > 0)
		Train:WriteTrainWire(19,PowerReserve*(1-Train.SD3.Value)*RV["KRR7-8"]*Drive*Train.EmerX1.Value)--*((Train.SF6.Value+(Train.BARS.UOS and Train.BARS.UOS and 1 or 0) > 0) and 1 or 0))  --*Train.PB.Value) --[[*Train.SF9.Value]]
		Train:WriteTrainWire(45,PowerReserve*(1-Train.SD3.Value)*RV["KRR7-8"]*Drive*Train.EmerX2.Value)--*((Train.SF6.Value+(Train.BARS.UOS and Train.BARS.UOS and 1 or 0) > 0) and 1 or 0))  --*Train.PB.Value) --[[*Train.SF9.Value]] 
		self.EmerXod = PowerReserve*RV["KRR7-8"]*Drive*min(1,Train.EmerX1.Value+Train.EmerX2.Value)
		S["RV"] = P*(Train.BUKP.InitTimer and Train.BUKP.InitTimer > 0 and 1 or RV["KRO9-10"]*Train.SF2.Value+RV["KRR7-8"]*Train.SF3.Value)--*Orientation
		Train:WriteTrainWire(3,S["RV"]*Orientation)--S["RV"]*Orientation)		
		Train:WriteTrainWire(4,0)
		Train:WriteTrainWire(5,P*RV["KRR7-8"]*Orientation)
		Train:WriteTrainWire(6,P*RV["KRO1-2"]*Orientation)
		local KM1 = P --[[*Train.SF6.Value]] *RV["KRO11-12"]*Train.SF2.Value
		local KM2 = P --[[*Train.SF6.Value]] *RV["KRO15-16"]
		--Train:WriteTrainWire(11,P*Train.SA1.Value)
		Train:WriteTrainWire(12,P*(RV["KRR3-4"]*Train.SF3.Value+KM1))--*Train.SF9.Value)
		Train:WriteTrainWire(13,P*(RV["KRR9-10"]+KM2))--*Train.SF9.Value)
		Train:WriteTrainWire(14,P*RV["KRR3-4"]*Orientation*Train.SF3.Value)--*Train.SF9.Value)
		Train:WriteTrainWire(15,P*RV["KRR9-10"]*Orientation*Train.SF3.Value)--*Train.SF9.Value)
		
		local BTB = P*(RV["KRO13-14"]*Train.SF2.Value*Train.SF7.Value + RV["KRR11-12"]*Train.SF3.Value*Train.SF8.Value)--*Train.SF6.Value
		if P*Train.SD.Value > 0 then
			if S["RV"] ~= self.rv then
				self.rv = S["RV"]
				if self.rv ~= 0 then
					self.SDActive = true
				end
			end
			self.SD = C(S["RV"] > 0 and (self.SDActive or Train.SD2.Value == 0))-- and 1 or 0
		else
			self.SD = 0
			self.SDActive = false
		end
		local BTBp = BTB*min(1,(1-Train.SD2.Value+self.SD))
		self.V2 = BTB --P*(RV["KRO13-14"]*Train.SF7.Value + RV["KRR11-12"]*Train.SF8.Value)--*Train.SF6.Value
		self.V1 = UPIPower*Train.HornB.Value --[[*(RV["KRO13-14"]*Train.SF7.Value + RV["KRR11-12"]*Train.SF8.Value)]]

		Train:WriteTrainWire(27,BTB)
		Train:WriteTrainWire(11,BTB*Train.SA1.Value)
		Train:WriteTrainWire(31,BTB*(1-Train.SA1.Value))
		Train:WriteTrainWire(28,BTB*Train.EmerBrake.Value)
		Train:WriteTrainWire(29,BTB*Train.EmerBrake.Value*Train.EmerBrakeAdd.Value)
		Train:WriteTrainWire(30,BTB*Train.EmerBrake.Value*Train.EmerBrakeRelease.Value)
		
		--Train:WriteTrainWire(34,min(1,self.SD+BTBp))--BTB*(1-Train.Pneumatic.SD2))

		--local BTB = P
		Train:WriteTrainWire(24,BTBp*(1-Train:ReadTrainWire(41)))--BTB*(1-Train.BUKP.EmergencyBrake))     --(1-Train.EmergencyBrake.Value)*(1-Train.Prost_Kos.EmergencyBrake))--*(1-Train.BUKP.EmergencyBrake))
		Train:WriteTrainWire(25,BTBp == 0 and Train:ReadTrainWire(26) > 0 and Train:ReadTrainWire(24)*self.BTB or 0)
		Train:WriteTrainWire(26,BTBp*Train.BARS.BTB*(1-self.BTBr)*(1-Train.BUKP.EmergencyBrake))--(1-Train:ReadTrainWire(32)))         --BTB*(Train.BARS.BTB)*(1-Train.BUKP.BTB))
		
		Train:WriteTrainWire(41,Train.EmergencyBrake.Value)
		Train:WriteTrainWire(32,Train.BTB.Value) 
		if Train:ReadTrainWire(32) > 0 then self.BTBr = 1 elseif Train:ReadTrainWire(27) == 0 then self.BTBr = 0 end
		if Train:ReadTrainWire(26) > 0 and Train:ReadTrainWire(24) == 0 then self.BTB = 0 elseif Train:ReadTrainWire(26) == 0 then self.BTB = 1 end

		Train:WriteTrainWire(10,P*Train.Battery.Value*Train.EmergencyCompressor.Value)
	
		local CurrentSpeed = C(Train.BUKP.CurrentSpeed < 1.8)
		local EmergencyDoors = Train.SF6.Value*Train.EmergencyDoors.Value*S["RV"]--
		Train:WriteTrainWire(40,EmergencyDoors)
		Train:WriteTrainWire(39,EmergencyDoors*Train.EmerCloseDoors.Value)--Двери закрытие
		Train:WriteTrainWire(38,EmergencyDoors*Train.SF11.Value*Train.DoorLeft.Value*CurrentSpeed)
		Train:WriteTrainWire(37,EmergencyDoors*Train.SF11.Value*Train.DoorRight.Value*CurrentSpeed)

		local ASNP_VV = Train.ASNP_VV
        ASNP_VV.Power = P*Train.SF18.Value*Train.R_ASNPOn.Value
		
		Panel.AppLights = P*Train.SF15.Value*Train.SA8.Value
		Panel.CabLight = Train.SF15.Value*min(2,P*(Train.SA6.Value+(Train.SA6.Value*Train.SA7.Value)) + Train.SA10.Value)
		Panel.PanelLights = PowerReserve*Train.SF17.Value
		
		Panel.HeadlightsFull = UPIPower*Train.SF16.Value*Train.SF17.Value*(RV["KRO11-12"]*max(0,Train.HeadlightsSwitch.Value-1)+Train.SA13.Value*Train.EmergencyControls.Value)
		Panel.HeadlightsHalf = UPIPower*(Train.SF16.Value+Train.SF17.Value)*(RV["KRO11-12"]*Train.HeadlightsSwitch.Value+Train.EmergencyControls.Value)
		
		Panel.RedLights = Train.SF28.Value + (RV["KRO7-8"]+Train.EmergencyControls.Value)*Train.SF1.Value*P
		
		Panel.CabVent = P*Train.SF23.Value
		
		Panel.DoorLeftL = UPIPower*Train.DoorSelectL.Value*(1-Train.DoorSelectR.Value)
		Panel.DoorRightL = UPIPower*Train.DoorSelectR.Value*(1-Train.DoorSelectL.Value)
		Panel.DoorCloseL = UPIPower*Train.DoorClose.Value
		Panel.DoorBlockL = UPIPower*Train.DoorBlock.Value
		
		Panel.EmerBrakeL = PowerReserve*C(Train.Pneumatic.EmerBrakeWork == 1 or Train.Pneumatic.EmerBrakeWork == true)*BTB
		Panel.EmerXodL = PowerReserve*abs(RV.KRRPosition)*(1-Train.SD3.Value)*Train.BARS.Drive
		
		Panel.KAHl = UPIPower*Train.KAH.Value
		Panel.ALSl = UPIPower*Train.ALS.Value
		Panel.PRl = UPIPower*Train.Pr.Value
		Panel.OtklRl = UPIPower*Train.OtklR.Value
		Panel.R_Linel = PowerReserve*Train.R_Line.Value
		Panel.R_ChangeRoutel = PowerReserve*Train.R_ChangeRoute.Value
		Panel.Washerl = PowerReserve*Train.Washer.Value
		Panel.Wiperl = PowerReserve*Train.Wiper.Value*Train.SF23.Value
		Panel.EmergencyControlsl = UPIPower*Train.EmergencyControls.Value
		Panel.EmergencyDoorsl = UPIPower*Train.EmergencyDoors.Value
		Panel.GlassHeatingl = PowerReserve*Train.GlassHeating.Value	
	
		Panel.PowerOnl = P*Train.SF27.Value*min(1,Train:ReadTrainWire(75))
		Panel.PowerOffl = P*Train.SF27.Value*min(1,Train:ReadTrainWire(74))
	
		Panel.LV = min(1,Train.Battery.Value+Train.SF1.Value)*self.Battery80V--/150
	else
		Panel.LV = Train.Battery.Value*self.KM2*Train.SF44.Value*self.Battery80V--/150
	end
	if not Async then
		Panel.SalonLighting1 = min(1,Train:ReadTrainWire(20))*Train.Battery.Value*Train.SF44.Value
		Panel.SalonLighting2 = P*self.KM2*Train.Battery.Value*Train.SF43.Value*BUV.MainLights
	else
		Panel.WorkFan = P*Train.Battery.Value*Train.GV.Value*HV
	
		Panel.SalonLighting1 = P*self.KM2*Train.Battery.Value*Train.SF44.Value
		Panel.SalonLighting2 = P*self.KM2*Train.Battery.Value*Train.SF43.Value*BUV.MainLights
	end
	
	Panel.PassSchemes = P*min(1,Train.SF37.Value+Train.SF38.Value)*BUV.Power--*C(Train.CIS.BMCISInit)
	Panel.PassSchemesL = P*BUV.Power*Train.SF37.Value
	Panel.PassSchemesR = P*BUV.Power*Train.SF38.Value
		
	if not Async then return end
	self.MK = Train.Battery.Value*PowerPSN*BUV.PSN*HV*self.KM2*Train.SF34.Value*(BUV.MK > 0 and 1 or Train:ReadTrainWire(10))	
	
	local command = BUV.Strength or 0--+0.5*(BUV.Strength > 0 and BUV.Slope1 and 1 or 0)
	local speed = Async.Speed
	if self.command ~= command and CurTime()-self.commandTimer > (0.3+(command ~= 0 and speed > 2 and sign(command) ~= sign(self.command) and 0.6 or 0)) then
		self.commandTimer = CurTime()
		self.command = command
	end

	Async:TriggerInput("Power",BO*self.KM2*(Train.SF52 and Train.Battery.Value*Train.SF52.Value or 1)*Train.GV.Value*Train.BV.Value)--*HV--*(1-BUKV.DisableTP))
	--print(string.format("%.2f %.2f %d %.2f",command,Async.Speed,Async.Mode,Async.Torque))
	if self.command > 0 then--and Train.GV.Value*Train.BV.Value == 1 then--and Train.BV.Value > 0 and Train.AsyncInverter.Drive == 0 and Train.TR.Main750V > 20 then
		Async:TriggerInput("Drive",self.command)
		Async:TriggerInput("Brake",0)
	elseif self.command < 0 then--and Train.GV.Value*Train.BV.Value == 1 then--and Train.AsyncInverter.Brake == 0 then
		Async:TriggerInput("Drive",0)
		Async:TriggerInput("Brake",abs(self.command))
	else
		Async:TriggerInput("Drive",0)
		Async:TriggerInput("Brake",0)		
	end		
    --local speed = (command <= 0 and math.abs(Async.Speed) or math.max(9.6,math.abs(Async.Speed)))
	local targetI,k = self.CurrentConfig[1][self.command],self.CurrentConfig[2][self.command]
    if self.command > 0 then
		Async:TriggerInput("TargetCurrent",targetI*(1+(self.Slope == 1 and 0.1 or Train.Pneumatic.WeightLoadRatio*0.1))*((1-k)+k*Clamp((speed-3)/16,0,1)))--*(0.22+0.78*Clamp((speed-3)/14,0,1)))--*(speed > 50 and 1-(speed-50)/150 or 1) )--*(speed < 20 and 0.23+Clamp(speed/22,0,1)*0.77 or 1))--330
    elseif self.command < 0 then
		Async:TriggerInput("TargetCurrent",targetI*(1+(self.Slope == 1 and 0.1 or Train.Pneumatic.WeightLoadRatio*0.1))*((1-k)+k*Clamp((speed-3)/22,0,1)))--*Clamp((speed-2)/18,0,1))--*(Clamp(speed/30,0,1)+(speed < 10 and 0.035 or 0) ))--330
    else
        Async:TriggerInput("TargetCurrent",0)
    end
	self.EnergyChange = Async.Mode>0 and (Async.Current^2)*2.2 or 0
    self.Itotal = Async.Current
    --[[ if self.Main750V > 900 or Async.Mode>0 then
        self.Recurperation = false
    elseif self.Main750V < 875 and Async.Mode<0 then
    end--]]
    if Async.Mode<0 and Async.State>0 then
        self.Recurperation = C(self.Main750V > 749 and self.Main750V < 921)*BUV.Recurperation
        self.Iexit = self.Iexit+(-Async.Current*2*self.Recurperation-self.Iexit)*dT*2
        --[[ if self.Main750V>550 then
            self.Iexit = self.Iexit+(-Async.Current*2*self.Recurperation-self.Iexit)*dT*2
        else
            self.Iexit = 0
        end--]]
        self.Chopper = (self.Main750V>=921 or self.Main750V<550)  and 1 or 0
    else
        self.Recurperation = 0
        self.Iexit = 0
        self.Chopper = 0
    end
    --print(self.Recurperation,self.Iexit,self.Main750V)
    self.ElectricEnergyUsed = self.ElectricEnergyUsed + max(0,self.EnergyChange)*dT
    self.ElectricEnergyDissipated = self.ElectricEnergyDissipated + max(0,-self.EnergyChange)*dT
end