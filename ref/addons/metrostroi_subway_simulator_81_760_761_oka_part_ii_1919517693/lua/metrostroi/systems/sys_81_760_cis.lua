--------------------------------------------------------------------------------
-- ЦИС Шина
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_760_CIS")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.TriggerNames = {
		"CISRestart",
	}
	self.Triggers = {}
	for k,v in pairs(self.TriggerNames) do
		if self.Train[v] then self.Triggers[v] = self.Train[v].Value > 0.5 end
	end
	self.Prev = 0
	
	self.Advert = 0
	self.Date = "00.01.2010 00:00"
	self.Line = 1
	self.BMCISInit = false
	self.DoorAlarm = false
	self.DoorClosed = false
	self.InitTimer = CurTime()
	
	self.PassSchemeArr = 0
	self.PassSchemeCurr = 1
	self.LastSt = false
end

function TRAIN_SYSTEM:Outputs()
	--return {"State","ControllerState"}
end

function TRAIN_SYSTEM:Inputs()
	return {}
end
if TURBOSTROI then return end

function TRAIN_SYSTEM:TriggerInput(name,value)
end
if SERVER then
	function TRAIN_SYSTEM:Get(id) 
		return self[id]
		--local Commands = self.Train.CIS
		--return Commands[id]
	end
	function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,data)
		--if sourceid == self.Train:GetWagonNumber() then return end
		local Train = self.Train
		if textdata == "CISRestart" or textdata == "Restart" then
			if Train.BMCIS and textdata == "CISRestart" and CurTime()-(self.Timer1 or 0) > 12 then
				self.Train:SetNW2Bool("BMCISInitialize",true)	
				Train.BMCIS.InitializeTimer = CurTime()								
				local rand = math.Rand(2,3)
				Train.BMCIS.RestartTimer = CurTime()+rand
				Train.Speedometer.RestartTimer = CurTime()+rand--+(self.Selected == 5 and math.Rand(2,4) or math.Rand(4,6))
				Train.Speedometer.State = -1	
				self.Timer1 = CurTime()
			end			
			Train.BNT.State = -1
			Train.BackTicker.AdvertSymbol = -utf8.len(Train.BackTicker.CurrentAdvert)*10-30
			Train.BackTicker.Advert = -1
			Train.BackTicker.TickerCurr = false					
		elseif textdata == "BackTickerAdvert" and self.Advert ~= (Train.BackTicker.Work and data or -1) then
			self.Advert = Train.BackTicker.Work and data or -1
			if Train.BackTicker.Advert ~= data then
				Train.BackTicker.AdvertSymbol = -utf8.len(Train.BackTicker.CurrentAdvert)*10-30
			end
		elseif self[textdata] ~= data then	
			self[textdata] = data		
		end
	end
	
	function TRAIN_SYSTEM:Trigger(name,value)
		--local name = name:gsub("BMCIS","")
		local Train = self.Train
		local Power = Train.Electric.Battery80V > 62 --and Train.SF12.Value+Train.SF13.Value > 0
		if Power then
			if name == "CISRestart" and value and CurTime()-self.Prev > 0 then
				Train:CANWrite("CIS",self.Train:GetWagonNumber(),"CIS",nil,"CISRestart",0)								
				self.Prev = CurTime()+10
			elseif name ~= "CISRestart" then
				Train:CANWrite("CIS",self.Train:GetWagonNumber(),"CIS",nil,name,value)
			end
		end
	end
	
	function TRAIN_SYSTEM:Think(dT)
		local Train = self.Train
		local Power = Train.Electric.Battery80V > 62 and Train.BUV.Power*(Train.SF37.Value+Train.SF38.Value) > 0
		if Power ~= self.Power then
			if Power then
				self.BMCISInit = false
				self.Date = nil
				self.PassSchemeArr = 0
				self.PassSchemeCurr = 1
				self.LastSt = false
			end
			self.Power = Power
		end
		if Train.Electric.Battery80V > 62 then
			if not self.InitTimer then 
				self.InitTimer = CurTime()
			end		
		elseif self.InitTimer then
			self.InitTimer = nil
		end
		if Power then
			if self.BMCISInit then
				self.Date = os.date("%d.%m.%Y %H:%M",Metrostroi.GetSyncTime())
			else
				self.Date = "00.01.2010 "..(os.date("%H:%M",CurTime()-self.InitTimer+75600))
			end
			if self.DoorAlarm and CurTime()-self.DoorAlarm > 25 then
				self.DoorAlarm = false
			end
			if self.DoorAlarm then
				local state = (CurTime()-self.DoorAlarm)%1 < 0.5
				self.Train:SetNW2Bool("DoorAlarmState",state)
				if self.DoorAlarmState ~= state then
					self.DoorAlarmState = state
					if state then
						Train:PlayOnce("door_alarm","",0.6,1.05)
					end
				end
			elseif self.Train:GetNW2Bool("DoorAlarmState",false) or self.DoorAlarmState ~= nil then
				self.Train:SetNW2Bool("DoorAlarmState",false)
				self.DoorAlarmState = nil
			end
			--Train:SetNW2Bool("DoorAlarm", self.DoorAlarm)
		else
			self.DoorAlarm = false
		end
		self.TickerEnglish = self.BMCISInit and Metrostroi.CISConfig[Train.CISConfig] and Metrostroi.CISConfig[Train.CISConfig][self.Line or 1] and Metrostroi.CISConfig[Train.CISConfig][self.Line or 1].English or false		

		for k,v in pairs(self.TriggerNames) do
			if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
				self:Trigger(v,Train[v].Value > 0.5)
				self.Triggers[v] = Train[v].Value > 0.5
			end
		end
	end
--else
	
end


