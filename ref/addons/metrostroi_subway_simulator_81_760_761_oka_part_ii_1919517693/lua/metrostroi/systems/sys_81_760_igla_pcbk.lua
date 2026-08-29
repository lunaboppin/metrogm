--------------------------------------------------------------------------------
-- АСОТП "ИГЛА"
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_760_IGLA_PCBK")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.States = {}
	self.State = -1
	self.Timer = 0
	self.Time = 0

end
if TURBOSTROI then return end
function TRAIN_SYSTEM:Inputs()
	return {  "" }
end
function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
	if textdata== "Update" then
		self.Update = true
	end
end
function TRAIN_SYSTEM:CANWrite(name,value)
	self.Train:CANWrite("IGLA_PCBK",self.Train:GetWagonNumber(),"IGLA_CBKI",nil,name,value)
end
function TRAIN_SYSTEM:CState(name,value)
	if self.Update or self.States[name] ~= value then
		self.States[name] = value
		self.Train:CANWrite("IGLA_PCBK",self.Train:GetWagonNumber(),"IGLA_CBKI",nil,name,value)
	end
end
function TRAIN_SYSTEM:Think(dT)
	local Train = self.Train
	if (Train.Electric.Battery80V < 62 or (Train.SF36 and Train.BUV.Power*Train.SF36.Value < 0.5)) or self.Reset then
		self.Reset = false
		if self.State ~= -1 then
			self.State = -1
			self.Timer = nil
		end
	end
	if self.State == -1 and (Train.Electric.Battery80V > 62 and (not Train.SF36 or Train.BUV.Power*Train.SF36.Value > 0.5)) then
		self.State = 0
		self.Timer = CurTime()+math.random()*0.3
	end
	if self.State == 0 and CurTime()-self.Timer > 1.2 then
		self.State = 1
		self.Time = CurTime()
		self.EngageTimer = nil
	end
	if self.State == 1 and (CurTime() - self.Time) > 1.4 then
		if self.Update then
			self:CANWrite("Timer",CurTime())
		end
		self.Time= CurTime()+math.random()*0.4
	
		self.Update = false
	end
end
