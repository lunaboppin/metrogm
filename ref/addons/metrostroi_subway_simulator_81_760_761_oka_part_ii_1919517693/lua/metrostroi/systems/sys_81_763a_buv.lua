--------------------------------------------------------------------------------
-- Блок Управления Вагоном
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_763A_BUV")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	if TURBOSTROI then
	else
		self.TrainIndex = self.Train:GetWagonNumber()
	end
	self.Battery = false
	self.Power = 0
	self.States = {}
	self.Commands = {}

	self.Slope = false

	self.PSN = 0
	self.MK = 0

	self.Reverser = 0
	self.PN2 = 0
	self.Brake = 0
	self.Drive = 0
	self.DriveStrength = 0
	self.Disassembly = 0

	self.Vent1 = 0
	self.Vent2 = 0
	self.Cond1 = 0
	self.Cond2 = 0

	self.PowerTimer = CurTime()
	self.PowerTbl = {
		[1] = 0.0425,   --X1 150A
		[2] = 0.1295,   --X2 200A
		[3] = 0.2345,   --X3 260A
		[4] = 0.3565,   --X4 330A
		-------------------
		[0] = 0,
		-------------------
		[-1] = -0.0185, --T1 -150A
		[-2] = -0.2150, --T2 -260A
		[-3] = -0.3044, --T3 -310A
	}
	self.DriveTimer = CurTime()

	self.CurTime = CurTime()

	self.IVO = -08	

	self.FirstHalf = false
	self.Strength = 0
	self.TargetStrength = 0
	self.PowerOff = 0
	
	self.AKBVoltage = 0
	self.MainLights = 0
end

function TRAIN_SYSTEM:Outputs()
	return {"Brake", "Drive", "DriveStrength", "Disassembly" ,"PSN","MK","Vent1","Vent2","Cond1","Cond2","Strength","Recurperation","Slope","Slope1","AKBVoltage","PowerOff","MainLights","Power"}
end

function TRAIN_SYSTEM:Inputs()
	return {}
end
function TRAIN_SYSTEM:CState(name,value)
	if self.CurrentBUP and (self.Reset or self.States[name] ~= value) then
		self.States[name] = value
		self.Train:CANWrite("BUV",self.Train:GetWagonNumber(),"BUKP",self.CurrentBUP,name,value)
	end
end
-- Door8Closed t/f
-- Door7Closed t/f
-- Door6Closed t/f
-- Door5Closed t/f
-- Door4Closed t/f
-- Door3Closed t/f
-- Door2Closed t/f
-- Door1Closed t/f
-- NoAssembly t/f
-- ParkingBrakeEnabled t/f
-- BEPPBroken t/f
-- EmergencyBrake t/f
-- ReserveChannelBraking t/f
-- PTEnabled t/f
-- PTBad t/f
-- PTReady t/f
-- PTReplace t/f
-- TLPressure 0-10
-- BLPressure 0-10
-- BCPressure 0-6
-- HPPressure 0-6
-- WeightLoad 0-1
-- PantDisabled t/f
-- EnginesBroken t/f
-- BBEEnabled t/f
-- BBEBroken t/f
-- HVBad t/f
-- LVBad t/f
-- EnginesDone t/f
-- EnginesBrakeBroke t/f
-- PassLightEnabled t/f
-- BVEnabled t/f
-- DriveStrength ~
-- BrakeStrength ~
-- VagEqConsumption 0-60A
-- HVVoltage 0-1500A
-- LVVoltage 0-100A
-- MKVoltage 0-50A
-- VentEnabled t/f
-- HeatEnabled t/f
-- MKWork --Исправность МК
-- BUVWork --Исправность БУВ
-- WagNOrientated t/f
-- Orientation t/f
function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata) 
    if textdata == "BUPWork" and not numdata then
        self.Commands[sourceid] = {}
    elseif textdata == "Orientate" then
        self.OrientateBUP = sourceid
        self.FirstHalf = numdata
        self.Reset = CurTime()
    elseif self.CurrentBUP then
        if not self.Commands[sourceid] then self.Commands[sourceid] = {} end
        self.Commands[sourceid][textdata] = numdata
    end
end
function TRAIN_SYSTEM:Get(id)
	local Commands = self.Commands[self.CurrentBUP]
	if Commands then
		return Commands[id]
	end
end
function TRAIN_SYSTEM:Get1(id) 
	return self.Train.CIS[id]
end
function TRAIN_SYSTEM:TriggerInput(name,value)
end
local SFTbl = {
	[11] = "31",
	[12] = "32",
	[13] = "47",--АДУД
	[14] = "45",
	[15] = "43",
	[16] = "33",
	[17] = "36",
	[18] = "48",--АДУВ

	[21] = "49",
	[22] = "34",
	[23] = "50",
	[24] = "51",
	[25] = "39",
	[26] = "40",
	[27] = "52",

	[31] = "41",
	[32] = "53",
	[33] = "54",
	[34] = "42",
}
local function PrevTrain(Train,front)
	if front and IsValid(Train.FrontTrain) then
		if not (Train:ElectricConnected(Train,not front)) then return end
	elseif not front and IsValid(Train.RearTrain) then
		if not (Train:ElectricConnected(Train,not front)) then return end
	end
	return (front and Train.FrontTrain or not front and Train.RearTrain)
end
local function Orient(Train,front)
	local Or = not front and IsValid(Train.RearTrain) and (Train.RearTrain.FrontTrain == Train) or front and IsValid(Train.FrontTrain) and (Train.FrontTrain.RearTrain == Train) or nil
	return Or
end
local function PrintTbl(tbl)
	for k,v in pairs(tbl) do
		print(k,IsEntity(v) and v.WagonNumber or v)
	end
end
local function CheckSF33(Train,val)
	local tbl,numtbl = {Train},{}
	numtbl[Train.WagonNumber] = true
	local Ft,Rt = PrevTrain(Train,true),PrevTrain(Train)
	local SF33 = Train.SF1 and Train.SF1.Value or Train.SF33.Value	
	if (not Train.SF1 or Train.SF1.Value == 1) then
		local i=0
		while IsValid(Ft) and not Train.SF1 do
			i=i+1
			if not Ft.SF1 and Ft.SF33.Value == 0 then
				if (Ft.RearTrain ~= tbl[i]) then
					table.insert(tbl,Ft)
					numtbl[Ft.WagonNumber] = true					
				end
				break
			elseif not Ft.SF1 or Ft.SF1.Value == 1 then
				table.insert(tbl,Ft)
				numtbl[Ft.WagonNumber] = true				
				if Ft.SF1 then
					break
				end
			end
			if IsValid(PrevTrain(Ft,true)) and not numtbl[PrevTrain(Ft,true).WagonNumber] then
				Ft = PrevTrain(Ft,true)
			elseif IsValid(PrevTrain(Ft)) and not numtbl[PrevTrain(Ft).WagonNumber] then
				Ft = PrevTrain(Ft)
			else
				break
			end
		end
		local k = i
		while IsValid(Rt) and SF33 > 0 do
			i=i+1		
			if not Rt.SF1 and Rt.SF33.Value == 0 then
				if (Rt.RearTrain ~= tbl[i] and Rt.RearTrain ~= tbl[i-k]) then
					table.insert(tbl,Rt)
					numtbl[Rt.WagonNumber] = true					
				end
				break
			elseif not Rt.SF1 or Rt.SF1.Value == 1 then
				table.insert(tbl,Rt)
				numtbl[Rt.WagonNumber] = true				
				if Rt.SF1 then
					break
				end
			end		
			if IsValid(PrevTrain(Rt,true)) and not numtbl[PrevTrain(Rt,true).WagonNumber] then
				Rt = PrevTrain(Rt,true)
			elseif IsValid(PrevTrain(Rt)) and not numtbl[PrevTrain(Rt).WagonNumber] then
				Rt = PrevTrain(Rt)
			else
				break
			end	
		end
		tbl["i"] = i
		tbl["k"] = k
	end
	local valu = false
	for _,v in pairs(tbl) do
		if IsEntity(v) and (v.SF1 and (v == Train or v.SF1.Value > 0) or not v.SF1 and v.SF32.Value > 0) and v.Battery.Value > 0 then
			valu = true
			break
		end
	end	
	local value = true
	if Train.SF1 then
		value = false
		local prev = PrevTrain(Train)
		if IsValid(prev) then
			value = (not prev.SF1 and CheckSF33(prev,1) or prev.SF1 and prev.Battery.Value*prev.SF1.Value == 1)
			if not prev.SF1 and not Orient(Train) and prev.SF33.Value == 0 then
				value = false
			end
		end
		if not value then
			value = (SF33 == 1)
		end
	end
	if val == true then 
		return tbl
	elseif val and val == 1 then
		return (valu and value)
	elseif not val then
		return (valu and value or (Train.SF1 and Train.SF1.Value or 1)*Train.Battery.Value > 0)
	end
end

local function CheckVoltage(Train)
	local tbl = CheckSF33(Train,true)
	local V = 0
	local i,k,max = (tbl["i"] or 0)+1,(tbl["k"] or 0)+1,#tbl
	if (Train.SF31.Value+Train.SF32.Value) > 0 then
		local Rt,Ft = nil,nil
		local j = 1	
		while (j < k) and tbl[j+1] do
			j=j+1
			if tbl[j].SF1 and tbl[j].SF1.Value == 1 or not tbl[j].SF1 and tbl[j].SF32.Value > 0 then
				Ft = tbl[j] 
				break
			elseif tbl[j].SF1 then
				break
			end	
		end
		j=k
		while (j < max) and tbl[j+1] do
			j=j+1
			if tbl[j].SF1 and tbl[j].SF1.Value == 1 or not tbl[j].SF1 and tbl[j].SF32.Value > 0 then
				Rt = tbl[j]			
				break
			elseif tbl[j].SF1 then
				break
			end	
		end	
		V = math.max(V,IsValid(Ft) and IsValid(Rt) and math.max((Ft.BUV.AKBVoltage-4.4)*(not Ft.Electric.KM2 and 1 or Ft.Electric.KM2),(Rt.BUV.AKBVoltage-4.4)*(not Rt.Electric.KM2 and 1 or Rt.Electric.KM2)) or IsValid(Ft) and (Ft.BUV.AKBVoltage-4.4)*(not Ft.Electric.KM2 and 1 or Ft.Electric.KM2) or IsValid(Rt) and (Rt.BUV.AKBVoltage-4.4)*(not Rt.Electric.KM2 and 1 or Rt.Electric.KM2) or 0)
		--print(Rt.BUV.AKBVoltage-4.4,Ft.BUV.AKBVoltage-4.4)

	end
	return V > 62 and (CheckSF33(Train) and 1 or 0)*V or 0
end
function TRAIN_SYSTEM:Think()
	if CurTime()-self.CurTime < 0.1 then return end
	self.DeltaTime = CurTime()-self.CurTime
	self.CurTime = CurTime()

	local Train = self.Train
	local wagcount = #Train.WagonList

	self.AKBVoltage = CheckVoltage(Train)
	
	self.Power = (Train.Electric.Battery80V > 62 and Train.Electric.Power == 1 and (Train.SF31.Value+Train.SF32.Value > 0 or CheckSF33(Train,1))) and 1 or 0
	self.State = self.Power > 0 --[[and (Train.SF31.Value+Train.SF32.Value > 0)]] 

	self.ADUVWork = (Train.Battery.Value*Train.SF48.Value*Train.Electric.KM2 > 0) or self.States.BCPressure == nil
	self.ADUTWork = (Train.Electric.BUFT > 0) or self.States.BCPressure == nil
	self.ADUDWork = (Train.Battery.Value*Train.SF47.Value*Train.Electric.KM2 > 0.5)--or self.States.LeftDoorsOpened == nil

	--if self.State and Train.Electric.Power == 1 and Train.SF46.Value > 0.5 then
	if self.State and Train.SF46.Value > 0.5 then
		if not self.States.BUVWork then
			self.Train:CANWrite("BUV",Train:GetWagonNumber(),"BUKP",nil,"Get",1)
		end
		self:CState("Battery",Train.Battery.Value == 1)		
		--local doorleft,doorright = true,true
		for i=1,4 do
			self:CState("Door"..i.."Closed", self.ADUDWork and Train.Pneumatic.LeftDoorState[i] == 0 or not self.ADUDWork and Train.Battery.Value > 0 and self.States["Door"..i.."Closed"])
			self:CState("Door"..(i+4).."Closed", self.ADUDWork and Train.Pneumatic.RightDoorState[i] == 0 or not self.ADUDWork and Train.Battery.Value > 0 and self.States["Door"..(i+4).."Closed"])
		end
		self:CState("LeftDoorsOpened",self.ADUDWork and Train.LeftDoorsOpened or not self.ADUDWork and Train.Battery.Value > 0 and self.States.LeftDoorsOpened)
		self:CState("RightDoorsOpened",self.ADUDWork and Train.RightDoorsOpened or not self.ADUDWork and Train.Battery.Value > 0 and self.States.RightDoorsOpened)			

		--self:CState("DoorTorec", Train.RearDoor or Train.FrontDoor)
		--self:CState("DoorBack", Train.PassengerDoor or Train.CabinDoorLeft or Train.CabinDoorRight)
		self:CState("EmPT",Train:ReadTrainWire(28) > 0)
		self:CState("NoAssembly",self.TargetStrength > 0)--K3_4 == 1
		local emer = Train:ReadTrainWire(45)+Train:ReadTrainWire(19)
		local bv = Train.BV.Value
		local strength,brake,drive = 0,0,0
		if emer > 0 then
			strength = Train:ReadTrainWire(45) > 0 and 4 or Train:ReadTrainWire(19) > 0 and 2 or 0
			drive = strength*bv --*Train.Electric.BUTP
		else
			brake = self.Brake--*Train.Electric.BUTP
			drive = self.Drive*bv--*Train.Electric.BUTP
			strength = self.DriveStrength
		end
		self.Scheme = (Train.Speed < 0.4 and 0 or Train.Electric.Brake)+drive > 0
		self:CState("Strength",self.Strength)
		self:CState("Scheme", (Train.Speed < 6.5 and 0 or brake)+drive > 0 and (drive > 0 and Train.Pneumatic.BrakeCylinderPressure < 0.7 or brake > 0 and Train.Pneumatic.BrakeCylinderPressure < 1.7+Train.Pneumatic.WeightLoadRatio*0.5+Train.Pneumatic.BrakeCylinderRegulationError))
		self:CState("ParkingBrakeEnabled", self.ADUTWork and 3.8-Train.Pneumatic.ParkingBrakePressure > 0 or not self.ADUTWork and self.States.ParkingBrakeEnabled)
		--self:CState("Blocks", self.BlockTorec)
		self:CState("BEPPBroken", false)
		for i=1,8 do
			self:CState("DPBT"..i,self.ADUVWork and Train:GetPackedBool("BC"..i) or not self.ADUVWork and self.States["DPBT"..i])
			--self:CState("DPBTPressure"..i,Train:GetPackedRatio("DPBTPressure"..i))			
		end
		--[[
		for i=31,57 do
			if i ~= 35 then
				self:CState("SF"..i,Train["SF"..i] and Train["SF"..i].Value == 1)
			end
		end]]
		for k,v in pairs(SFTbl) do
			self:CState("SF"..v,Train["SF"..v] and Train["SF"..v].Value == 1)
		end
		self:CState("EmergencyBrakeGood", Train.Pneumatic.BrakeCylinderPressure > (1.75+Train.Pneumatic.BrakeCylinderRegulationError+Train.Pneumatic.WeightLoadRatio*1.3)-0.05)
		self:CState("EmergencyBrake",self.States.EmergencyBrakeGood and Train.Pneumatic.EmergencyBrakeActive)-- and Train:ReadTrainWire(28) == 0	)
		self:CState("ReserveChannelBraking", self.Recurperation)--Train.Pneumatic.EmerBrakeWork)--Train:ReadTrainWire(28)>0)
		self:CState("PTBad", Train.K31.Value == 0)--false)
		self:CState("PTReady", Train.Pneumatic.AirDistributorPressure >= (2.4+Train.Pneumatic.WeightLoadRatio*0.9)-0.1)
		self:CState("PTReplace", self.PTReplace)--and CurTime()-self.PTReplace > 1.5)
		self:CState("BTBReady", Train.Pneumatic.BTBReady)

		self:CState("BCPressure", (self.ADUVWork and self.ADUTWork) and math.Round(Train.Pneumatic.BrakeCylinderPressure,1) or (not self.ADUVWork or not self.ADUTWork) and self.States.BCPressure)	
		self:CState("PantDisabled", self.ADUVWork and self.Pant or not self.ADUVWork and self.States.PantDisabled)

		self:CState("PTEnabled", (self.States.BCPressure or 2.3) > 0.22)--(not self.States.DPBT1) == true or (self.States.BCPressure and self.States.BCPressure or 2.3)>0.22)
		self:CState("HPPressure", self.ADUTWork and math.Round(Train.Pneumatic.AirDistributorPressure,1) or not self.ADUTWork and self.States.HPPressure)
		self:CState("ParkingBrakePressure",self.ADUTWork and math.Round(Train.Pneumatic.ParkingBrakePressure,1) or not self.ADUTWork and self.States.ParkingBrakePressure)
		self:CState("TLPressure", self.ADUTWork and math.Round(Train.Pneumatic.TrainLinePressure,1) or not self.ADUTWork and self.States.TLPressure)
		self:CState("BLPressure", self.ADUTWork and math.Round(Train.Pneumatic.BrakeLinePressure,1) or not self.ADUTWork and self.States.BLPressure)
		
		self:CState("WeightLoad", math.Round(Train.Pneumatic.WeightLoadRatio,2))
		self:CState("ElectricEnergyUsed",Train.Electric.ElectricEnergyUsed/(3.6e6))
		--print(Train.Electric.ElectricEnergyUsed)
		--self:CState("EnginesBroken", not self:Get("PVU9") and Train.Battery.Value*Train.SF52.Value == 1)
		self:CState("LV", Train.Electric.Battery80V)
		--self:CState("PSNEnabled", self.PSN)
		--self:CState("PSNWork",not self:Get("PVU8") and Train.Battery.Value*Train.SF45.Value == 1)
		--self:CState("PSNBroken", false)
		self:CState("HVBad", Train.Electric.Main750V < 550)
		self:CState("LVBad", Train.Electric.Battery80V < 62)
		self:CState("EnginesDone", self.EnginesDone)-- and math.abs(Train.Speed) < 7.5)
		--self:CState("EnginesBrakeBroke", (self:Get("Brake") or 0) > 0 and Train.BV.Value == 0 or Train.Electric.Brake > 0 and (Train.K3_4.Value*Train.K5_6.Value == 0))
		self:CState("PassLightEnabled", self.MainLights == 1)
		--self:CState("BVEnabled", Train.BV.Value > 0)
		self:CState("DriveStrength", 0)--(Train.AsyncInverter.Drive*Train.AsyncInverter.Torque)/3.6)
		self:CState("BrakeStrength", 0)--(Train.AsyncInverter.Brake*Train.AsyncInverter.Torque)/3.6)
		self:CState("VagEqConsumption", self.IVO)-- -00.1)--15-25
		self:CState("I", 0)
		self:CState("HVVoltage", math.floor(Train.Electric.Main750V))
		self:CState("LVVoltage", math.floor(Train.Electric.Battery80V))
		--self:CState("MKVoltage", math.Round(Train.Electric.MK*math.Round(math.Rand(12,15)*(Train.Pneumatic.Compressor and (CurTime()-Train.Pneumatic.Compressor > 0 and 1 or CurTime()-Train.Pneumatic.Compressor > -4 and (4+(CurTime()-Train.Pneumatic.Compressor))/4 ) or 0  ))))
		self:CState("Cond1", self.Cond1>0)
		self:CState("Cond2", self.Cond2>0)
		self:CState("HeatEnabled", false)
		--self:CState("MKWork", not self:Get("PVU3") and Train.SF34.Value == 1)
		self:CState("BUVWork", true)
        self:CState("WagNOrientated", self.Orientation  == self.RevOrientation)
		self:CState("AsyncInverter",false)
		self:CState("Orientation", self.Orientation)
		self:CState("BadCombination", (Train:ReadTrainWire(3)*Train:ReadTrainWire(4)) > 0)
		self:CState("WagType", Train.SubwayTrain.WagType)
		self:CState("WagNumber", Train.WagonNumber)
	else
		self:CState("BUVWork", false)
		for k,v in pairs(self.Commands) do
			self.Commands[k] = false
		end
	end
	--print(Train.Electric.ElectricEnergyUsed)
	if self.Reset and self.Reset ~= CurTime() then
		self.Reset = nil
	end
	--self.IVO = Train.Electric.Battery80V > 67 and self.PSN > 0 and self.I*10+math.Round(math.Rand(2,6),1) or -00.1	
	--self.PSN = 0 --not self:Get("PVU8") and Train.Electric.Battery80V > 67 --[[and self:Get("PSN")]] and Train.Battery.Value*Train.SF45.Value or 0
	--if Train.Electric.Main750V < 550 or Train.Electric.Main750V > 975 then self.PSN = 0 end
	if self.States.BUVWork then
		self.PassLight = self:Get("PassLight")
		self.PowerOff = (self:Get("PowerOff") or Train.SF35 and Train.SF35.Value == 0) and 1 or 0
	elseif Train.Electric.Power == 0 then
		self.PassLight = false
		self.PowerOff = 0
	end
	--print(self.PowerOff)
	if self.PassLight and self.MainLights == 1 and not self.MainLightsTimer then self.MainLightsTimer = CurTime() end
	--if self.AKBVoltage < 70 and self.PSN > 0 then self.PSN = 0 end
	if self.AKBVoltage > 75 or self.MainLights == 0 or self.MainLightsTimer and CurTime()-self.MainLightsTimer > 20 then self.MainLightsTimer = nil end
	
	self.MainLights = not self:Get("PVU5") and (self.AKBVoltage > 75 or self.MainLightsTimer) and self.PassLight and 1 or 0

	if self:Get("Slope") then self.Slope = CurTime() elseif Train:ReadTrainWire(5) > 0 and self.Slope then self.Slope = false end
	if self.Slope and self.TargetStrength > 0 then
		self.SchemeSlope = true
	end
	if self.SchemeSlope and self.TargetStrength <= 0 then
		self.SchemeSlope = false
	end	
	if not self:Get("Slope") and self.Slope and (self:Get("SlopeSpeed") and self.TargetStrength > 0 and CurTime()-self.Slope > 2 or not self:Get("SlopeSpeed") and self.TargetStrength ~= 0) then self.Slope = false end --Train.Pneumatic.BrakeCylinderPressure < 1.5 then self.Slope = false end
	if self.Slope then self.Slope1 = true end
	if self.Slope1 and Train.Pneumatic.BrakeCylinderPressure < 0.1 then self.Slope1 = false end
	self.Reverser = Train:ReadTrainWire(12)
	local brake = self:Get("Brake") or 0
	local strength = not self:Get("PVU9") and (self.Slope1 and true or brake>0 and Train.Pneumatic.BrakeCylinderPressure < 1.7+Train.Pneumatic.WeightLoadRatio*0.5+Train.Pneumatic.BrakeCylinderRegulationError or brake==0 and (self:Get("Slope") or Train.Pneumatic.BrakeCylinderPressure < 0.7)) and self:Get("DriveStrength") or 0
	if not self:Get("PVU9") and brake==0 and Train.Pneumatic.BrakeCylinderPressure < 0.4 then
		self.DriveTimer = CurTime()
	end

	if brake==0 and not self:Get("PVU9") then
		if Train:ReadTrainWire(45) == 1 then
			strength = 4
		elseif Train:ReadTrainWire(19) == 1 then
			strength = 2
		end
	end
	local drive = math.min(1,(1-brake)*strength)
	if strength == 0 then
		brake=0
		drive=0
	end
	self.Brake = brake
	self.Drive = drive
	self.Strength = (self.Brake == 1 and -1 or 1)*strength
	self.TargetStrength = (self:Get("Brake") == 1 and -1 or 1)*(self:Get("DriveStrength") or 0)+((Train:ReadTrainWire(45) == 1 and 4 or Train:ReadTrainWire(19) == 1 and 2) or 0)
	--if self:Get("BARSBrake") then self.Strength = -3 end
	--self.BlockTorec = not self:Get("PVU6") and self:Get("DoorTorec") and Train.SF42.Value*Train.Battery.Value > 0
	self.DriveStrength = strength

	if not self.Slope then
		self.EnginesDone = true
		if (self.EnginesDone or self.States.EnginesDone) and self.Strength < 0 and Train.Speed > 7 then
			self.EnginesDone = false
			self.States.EnginesDone = false
		end
		if self.TargetStrength < -1 and not self.PTReplaceTimer then
			self.PTReplaceTimer = CurTime()
		elseif self.TargetStrength >= 0 and self.PTReplaceTimer then
			self.PTReplaceTimer = nil
		end
		if self.PTReplaceTimer and CurTime()-self.PTReplaceTimer > 0.5 or (Train.Speed < 7 and self.TargetStrength<-1) then
			self.PTReplace = true
		elseif not self.PTReplaceTimer and self.PTReplace then
			self.PTReplace = false
		end
	end
	if (not self.EnginesDone or not self.States.EnginesDone) then --and (self:Get("BARSBrake") or self:Get("AO")) then
		self.EnginesDone = true
		self.States.EnginesDone = true
	end
	local PN = self.PTReplace --self.PTReplace and CurTime()-self.PTReplace > 1.2 or self.States.EnginesDone
	self.PN1 = (self:Get("PN1") and self:Get("PN1") > 0) or PN and (self:Get("DriveStrength") and self:Get("DriveStrength") > 1) or self:Get("PR") and self.TargetStrength <=0 --or self.TargetStrength < -1-- --or (self.Pant and Train.TR.Main750V == 0 or Train.BV.Value*Train.GV.Value == 0) --or (Train.AsyncInverter.PrevVoltage > 975 or Train.AsyncInverter.PrevVoltage < 550) and Train.AsyncInverter.Brake > 0.5) and self.Strength < 0
	self.PN2 = self.Slope and self:Get("SlopeSpeed") --[[or (self:Get("PN2") and self:Get("PN2") > 0)]] or PN and (self:Get("DriveStrength") and self:Get("DriveStrength") > 2) --[[and not (self:Get("BARSBrake") or self:Get("AO"))]] -- or (self.Pant and Train.TR.Main750V == 0 or Train.BV.Value*Train.GV.Value == 0) --or (Train.AsyncInverter.PrevVoltage > 975 or Train.AsyncInverter.PrevVoltage < 550) and Train.AsyncInverter.Brake > 0.5) and self.Strength < -1
	self.BTB = Train.Pneumatic.RVTBLeak == 1 --or Train.Pneumatic.EmergencyBrakeActive
	self.OpenLeft = not self:Get("PVU2") and (self:Get("OpenLeft") and self.Orientation or self:Get("OpenRight") and not self.Orientation)
	self.OpenRight = not self:Get("PVU2") and (self:Get("OpenRight") and self.Orientation or self:Get("OpenLeft") and not self.Orientation)
	self.CloseDoors = not self:Get("PVU2") and self:Get("CloseDoors")
	--self.Vent1 = self:Get("Vent1") and 1 or 0
	--self.Vent2 = self:Get("Vent1") and self:Get("Vent2") and 1 or 0
	self.Cond1 = self:Get("Cond1") and Train.Battery.Value*Train.Electric.KM2*Train.SF56.Value*Train.SF57.Value > 0 and 1 or 0
	if Train.Electric.Main750V < 550 or Train.Electric.Main750V > 975 then self.Cond1 = 0 end	
	self.Cond2 = self.Cond1 == 1 and 1 or 0
	self.Recurperation = not self:Get("ReccOff") and 1 or 0	
	
    self.Orientation = Train:ReadTrainWire(3) > 0
    self.RevOrientation = Train:ReadTrainWire(4) > 0
    --print(Train:ReadTrainWire(3),Train:ReadTrainWire(4))
    --if self.Orientation == self.RevOrientation then print(Train:ReadTrainWire(3),Train:ReadTrainWire(4)) end
    local BadOrientation = self.Orientation and self.Orientation  == self.RevOrientation
    if self.State and self.Orientation ~= self.RevOrientation then
        if not self.BadOrientation and self.OrientateBUP and (not self.Commands[self.OrientateBUP] or self.Orientation and self.Commands.Forward ~= self.OrientateBUP or self.RevOrientation and self.Commands.Back ~= self.OrientateBUP) then
            --print(Train:GetWagonNumber(),"New BUP",self.Orientation and "Forward" or "Back",self.OrientateBUP)
            if self.Orientation then self.Commands.Forward = self.OrientateBUP else self.Commands.Back = self.OrientateBUP end
            self.OrientateBUP = nil
        end
    end

    local ReOrientation = self.State and (self.Orientation or self.RevOrientation) and (self.Orientation ~= self.PrevOrientation or self.RevOrientation ~= self.PrevRevOrientation or self.CurrentBUP ~= (self.Orientation and self.Commands.Forward or self.Commands.Back))
    if ReOrientation then
        self.CurrentBUP = self.Orientation and self.Commands.Forward or self.Commands.Back
        --print(Train:GetWagonNumber(),"Reorientate",self.Orientation and "Forward" or "Back",self.CurrentBUP)
        self.Reset = CurTime()
        if self.CurrentBUP then
            self.Commands[self.CurrentBUP]  = {}
            Train:CANWrite("BUV",Train:GetWagonNumber(),"BUKP",self.CurrentBUP,"Get")
        end
    end
    self.BadOrientation = BadOrientation
    self.PrevOrientation = self.Train:ReadTrainWire(3) > 0
    self.PrevRevOrientation = self.Train:ReadTrainWire(4) > 0
	
	if self.ADUVWork then
		if (self:Get("PVU4") and Train.SF53.Value*Train.Electric.KM2 > 0 or self:Get("PantDisabled") and Train.Electric.Main750V < 20) and Train.Battery.Value > 0 then-- Train.Electric.Main750V < 20 and (self:Get("TP1") and self.FirstHalf or self:Get("TP2") and not self.FirstHalf) then
			self.Pant = true
		else
			self.Pant = false
		end
	end
end
