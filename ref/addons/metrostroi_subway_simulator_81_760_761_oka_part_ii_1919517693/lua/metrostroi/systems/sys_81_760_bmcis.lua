--------------------------------------------------------------------------------
-- БМЦИС01
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_760_BMCIS")
TRAIN_SYSTEM.DontAccelerateSimulation = true
local ANNOUNCER_CACHE_LIMIT = 30

function TRAIN_SYSTEM:Initialize()
	self.State1 = 0
	self.State = -1
	self.Str2 = 0
	
    self.Schedule = {}		
	
	self.Train:LoadSystem("BMCISUp","Relay","Switch",{bass=true})
	self.Train:LoadSystem("BMCISDown","Relay","Switch",{bass=true})
	self.Train:LoadSystem("BMCISEnter","Relay","Switch",{bass=true})
	self.Train:LoadSystem("BMCISEsc","Relay","Switch",{bass=true})	
	self.Train:LoadSystem("BMCISF1","Relay","Switch",{bass=true})
	self.Train:LoadSystem("BMCISF2","Relay","Switch",{bass=true})
	self.Train:LoadSystem("BMCISF3","Relay","Switch",{bass=true})
	self.Train:LoadSystem("BMCISF4","Relay","Switch",{bass=true})
	
	self.Train:LoadSystem("R_ToBack","Relay","Switch",{bass=true})
	self.Train:LoadSystem("R_ChangeRoute","Relay","Switch",{bass=true})
	self.Train:LoadSystem("R_Micro","Relay","Switch",{bass=true})		
	self.Train:LoadSystem("R_LineN","Relay","Switch",{bass=true})	
	self.TriggerNames = {
		"BMCISUp",
		"BMCISDown",
		"BMCISEnter",
		"BMCISEsc",
		"BMCISF1",
		"BMCISF2",
		"BMCISF3",
		"BMCISF4",
		"R_Program1","R_Program11",
		"R_Micro",
		--"R_Program2",
		"R_ToBack",
		"R_ChangeRoute",
		"R_LineN",
		"CISRestart",
	}
	self.Triggers = {}
	for k,v in pairs(self.TriggerNames) do
		if self.Train[v] then self.Triggers[v] = self.Train[v].Value > 0.5 end
	end
	
	self.RouteNumber = 0
	self.Selected = 0
	self.LastSt = false	
	self.StateTimer = CurTime()
	self.Timer = CurTime()
	self.Line = Metrostroi.ASNPSetup and Metrostroi.ASNPSetup[1] and 1 or -2
	self.Path = false	
	self.Reserve = false
	self.NumLines = 0
	self.Adverts = {}
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
	util.AddNetworkString("metrostroi_cis_announcer")
	function TRAIN_SYSTEM:Zero()
		self.Station = self.Path and self.LastStation or self.FirstStation
		self.Arrived = true
		self:UpdateBoards()
	end
	function TRAIN_SYSTEM:Next(special)
		local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
		if not tbl then return end		
		if tbl.Loop then
			if self.Arrived then
				if self.Path then
					self.Station = self.Station - 1
				else
					self.Station = self.Station + 1
				end
				if self.Station == 0 or self.Station > #tbl then
					self.Station = self.Station == 0 and #tbl or 1
				end
				if self.Station == 0 or self.Station > #tbl then
					self.Station = self.Station == 0 and (self.LastStation > 0 and self.LastStation or #tbl) or 1
				end
				self.Arrived = false
				--self.Station = 1
			else
				self.Arrived = true
			end
		else
			if self.Arrived then
				if self.Station ~= (self.Path and self.FirstStation or self.LastStation) then
					if self.Path then
						self.Station = math.max(self.FirstStation,self.Station - 1)
					else
						self.Station = math.min(self.LastStation,self.Station + 1)
					end
					self.Arrived = false
				else
					self:UpdateBoards(true)
				end
			else
				self.Arrived = true
			end
		end
		if not special then
			self:UpdateBoards((self.Station == (self.Path and self.FirstStation or self.LastStation) and true))
		end
	end
	function TRAIN_SYSTEM:Prev(special)
		local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
		if not tbl then return end
		if tbl.Loop then
			if not self.Arrived then
				if self.Path then
					self.Station = self.Station + 1
				else
					self.Station = self.Station - 1
				end
				if self.Station == 0 or self.Station > #tbl then
					self.Station = self.Station == 0 and (self.LastStation > 0 and self.LastStation or #tbl) or 1
				end
				--self.Station = 1
				self.Arrived = true
			else
				self.Arrived = false
			end
		else
			if not self.Arrived then
				if self.Path then
					self.Station = math.min(self.LastStation,self.Station + 1)
				else
					self.Station = math.max(self.FirstStation,self.Station - 1)
				end
				self.Arrived = true
			else
				if self.Station ~= (self.Path and self.LastStation or self.FirstStation) then
					self.Arrived = false
				end
			end
		end
		if not special then
			self:UpdateBoards()
		end
	end
	function TRAIN_SYSTEM:CabinQueue(msg)
		if msg and type(msg) ~= "table" then
			self:CabQueue{msg}
		else
			self:CabQueue(msg)
		end
	end		
	function TRAIN_SYSTEM:AnnQueue(msg)
		local Announcer = self.Train.Announcer
		if msg and type(msg) ~= "table" then
			Announcer:Queue{msg}
		else
			Announcer:Queue(msg)
		end
	end
	function TRAIN_SYSTEM:Play(dep,not_last,spec)
		if self.Line < 1 then return end
		local message
		local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
		--if self.Line >= 1 then
		local stbl = tbl[self.Station]
		local last,lastst
		if not spec then self.LastSt = false end
		if tbl.Loop then
			last = self.LastStation
			if self.LastStationEntered ~= 0 then last = self.laststbl[self.LastStationEntered] end
			lastst = not dep and self.LastStation > 0 and self.Station == last and tbl[last].arrlast
		else
			last = self.Path and self.FirstStation or self.LastStation
			if self.LastStationEntered ~= 0 then last = self.laststbl[self.LastStationEntered] end
			lastst = not dep and self.Station == last and tbl[last].arrlast
		end
		if self.LastStationEntered and ((self.Path and self.Station < last or not self.Path and self.Station > last) or (self.Station == last) and self.Arrived) then
			--print(self.Station,last,self.Path,self.Arrived)
			self.LastStationEntered = 0
			self.Train:SetNW2Int("BMCISLastStationEntered",0)

			if tbl.Loop then
				last = self.LastStation
				lastst = not dep and self.LastStation > 0 and self.Station == last and tbl[last].arrlast
			else
				last = self.Path and self.FirstStation or self.LastStation
				lastst = not dep and self.Station == last and tbl[last].arrlast
			end	
		end
		
		if dep then
			message = stbl.dep[self.Path and 2 or 1]
		else
			if lastst then
				message = stbl.arrlast[self.Path and 2 or 1]
				self.Arrived = not self.Arrived
			else
				message = stbl.arr[self.Path and 2 or 1]
			end
		end
		if spec then
			self:CabinQueue{"click1"}
			self:CabinQueue(message)
			local stbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line][self.Station]
			if self.LastStation > 0 and self.Station ~= last and tbl[last].not_last and (stbl.have_inrerchange --[[and not dep]] or --[[dep and]] math.abs(last-self.LastStation)<=3) and dep then
				self:CabinQueue(tbl[last].not_last)
			end
			self:CabinQueue{"click2"}
			--self:UpdateBoards()			
		else
			self:AnnQueue{"click1"}
			self:AnnQueue(message)
			if lastst and not stbl.ignorelast then
				self:AnnQueue(-1)
				--table.insert(message,1,-1)
			end
			if lastst then
				self.LastSt = true
			end
			local stbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line][self.Station]
			if self.LastStation > 0 and self.Station ~= last and tbl[last].not_last and (stbl.have_inrerchange --[[and not dep]] or --[[dep and]] math.abs(last-self.LastStation)<=3) and dep then
				self:AnnQueue(tbl[last].not_last)
			end
			self:AnnQueue{"click2"}
			self:UpdateBoards()
		end
		if lastst then
			self.Arrived = not self.Arrived			
		end
		--end
	end
	function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
		if sourceid == self.Train:GetWagonNumber() then return end
		if textdata == "RouteNumber" then self.RouteNumber = numdata end
		if textdata == "Connection" then
			self.Train:SetNW2Bool("BMCISConnection",numdata > 0)
		end
		if textdata == "Path" then self.Path = numdata > 0 end
		if textdata == "Line" then self.Line = numdata end
		if textdata == "FirstStation" then self.FirstStation = numdata end
		if textdata == "LastStation" then self.LastStation = numdata end
		if textdata == "Activate" and self.Line >= 1 then
			local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
			self.Station = tbl.Loop and 1 or self.Path and self.LastStation or self.FirstStation
			self.Arrived = true
			self.State1 = 7		
			if not self.laststbl then self.laststbl = {} end			
		end
		if textdata == "Off" and numdata ~= -1 then
			local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)] and Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
			if tbl then
				self.laststbl = {}
				for i=1,#tbl do
					if tbl[i].arrlast then table.insert(self.laststbl,i) self.Train:SetNW2String("BMCISLast"..#self.laststbl,tbl[i][4] or tbl[i][2]) end
				end
				self.Train:SetNW2Int("BMCISLasts",#self.laststbl)	
			end
		
		
			for i=1,#self.Train.WagonList do
				local wag = self.Train.WagonList[i]
				if not wag.BUV then break end
				wag:SetNW2Bool("BMCISExtra",false)
			end				
			self.Train.Announcer:Reset()
			self:CabReset()
			self.Extra = false
				
			self.State = 1
			self.Selected = 0
			self.LastStationEntered = 0
			self.Train:SetNW2Int("BMCISLastStationEntered",0)		
			local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)] and Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
			if tbl then
				self.Train:SetNW2String("BMCISLastSt",tbl[self.Path and 1 or #tbl][2])
				self.Train:SetNW2Bool("BMCISLastSt1",false)
			end
			--self.Train.RouteNumber.RouteNumber = self.RouteNumber	
			--self.Train.RouteNumber:TriggerInput("RouteNumber",self.RouteNumber)

			self.Train.RouteNumber:TriggerInput("LastStation",self.Train:GetNW2String("BMCISLastSt"),self.RouteNumber)
		end
	end
	function TRAIN_SYSTEM:SyncBMCIS()
		--self.LastSt = false
		--if not self.laststbl then self.laststbl = {} end	
		self.Train:CANWrite("BMCIS",self.Train:GetWagonNumber(),"BMCIS",nil,"RouteNumber",self.RouteNumber)
		self.Train:CANWrite("BMCIS",self.Train:GetWagonNumber(),"BMCIS",nil,"Path",self.LastStation == 0 and (self.Path and 1 or 0) or self.Path and 0 or 1)
		self.Train:CANWrite("BMCIS",self.Train:GetWagonNumber(),"BMCIS",nil,"Line",self.Line)
		self.Train:CANWrite("BMCIS",self.Train:GetWagonNumber(),"BMCIS",nil,"FirstStation",self.FirstStation)
		self.Train:CANWrite("BMCIS",self.Train:GetWagonNumber(),"BMCIS",nil,"LastStation",self.LastStation)
		self.Train:CANWrite("BMCIS",self.Train:GetWagonNumber(),"BMCIS",nil,"Activate")
		self.Train:CANWrite("BMCIS",self.Train:GetWagonNumber(),"BMCIS",nil,"Off",self.State == 2 and 0 or -1)
		--self.Train.RouteNumber.RouteNumber = self.RouteNumber
		--self.Train.RouteNumber:TriggerInput("RouteNumber",self.RouteNumber)
		self.Train.RouteNumber:TriggerInput("LastStation",self.Train:GetNW2String("BMCISLastSt"),self.RouteNumber)

		self.Train.CIS:Trigger("BMCISInit",not self.InitializeTimer)
		if self.InitializeTimer then
			self.Train.CIS:Trigger("PassSchemeCurr", 1)
			self.Train.CIS:Trigger("PassSchemeArr", 0)
		end

		for i=1,#self.Train.WagonList do
			local wag = self.Train.WagonList[i]
			if not wag.BUV then break end
			wag:SetNW2Bool("BMCISExtra",false)
		end				
		self.Train.Announcer:Reset()
		self:CabReset()
		self.Extra = false
		
	end
	function TRAIN_SYSTEM:UpdateBoards(special)
		if self.State1 < 7 or self.Line < 1 then
			return
		end
		local CIS = self.Train.CIS
		local tbl = Metrostroi.CISConfig[self.Train.CISConfig] and Metrostroi.CISConfig[self.Train.CISConfig][self.Line] or Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
		local stbl = tbl.LED
		local curr = 0		
		if self.Path then
			for i=#stbl,self.Station+1,-1 do curr = curr + stbl[i] end
		else
			for i=1,self.Station-1 do curr = curr + stbl[i] end
		end
		local nxt = 0
		if (self.Arrived or self.Station == (self.Path and self.FirstStation or self.LastStation) and self.Arrived) and stbl[self.Station] then
			curr = curr + stbl[self.Station]
		else
			nxt = stbl[self.Station]
		end
		if self.State > 1 then
			CIS:Trigger("BMCISInit",not self.InitializeTimer)
			CIS:Trigger("Line",self.Line)
			--CIS:Trigger("Date",(self.Date1 or "00.01.2010").." "..(self.Time or "00:00"))			
		end			
		CIS:Trigger("PassSchemeCurr",curr,nil,true)
		CIS:Trigger("PassSchemeArr",nxt,nil,true)
		--[[
		if Train:GetNW2Bool("PassSchemesRotated") then
			--CIS:Trigger("PassSchemePath",not self.Path,nil,true)
		else
			--CIS:Trigger("PassSchemePath",self.Path,nil,true)
		end]]

		if not tbl or not tbl[self.Station][2] then
			return 
		end
		CIS:Trigger("PassSchemePath",self.Path,nil,true)
		CIS:Trigger("LastSt",self.LastSt,nil,true)		
		CIS:Trigger("TickerNext",not self.Arrived,nil,true)
		CIS:Trigger("TickerCurr",tbl[self.Station][2],nil,true) 
		CIS:Trigger("TickerEn",tbl[self.Station][3] or tbl[self.Station][2],nil,true)
		CIS:Trigger("TickerLine",tbl.Line,nil,true)	
		CIS:Trigger("TickerLineColor",tbl.Color,nil,true)	
		if tbl[self.Station][4] then
			CIS:Trigger("TickerIn",tbl[self.Station][5],nil,true)
			CIS:Trigger("TickerInToLine",tbl[self.Station][6],nil,true)
			CIS:Trigger("TickerInEn",tbl[self.Station][7],nil,true)			
			CIS:Trigger("TickerInToLineColor",tbl[self.Station][8],nil,true)			
		else
			CIS:Trigger("TickerIn",tbl[self.Station][5] or nil,nil,true)
			CIS:Trigger("TickerInToLine",tbl[self.Station][6] or nil,nil,true)
			CIS:Trigger("TickerInEn",tbl[self.Station][7] or nil,nil,true)
			CIS:Trigger("TickerInToLineColor",tbl[self.Station][8] or nil,nil,true)					
		end
		CIS:Trigger("TickerIn1",tbl[self.Station][9] or nil,nil,true)
		CIS:Trigger("TickerInToLine1",tbl[self.Station][10] or nil,nil,true)
		CIS:Trigger("TickerInEn1",tbl[self.Station][11] or nil,nil,true)
		CIS:Trigger("TickerInToLineColor1",tbl[self.Station][12] or nil,nil,true)		
	end
	
	function TRAIN_SYSTEM:Set(special,spec)
		if self.Line < 1 or not Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)] then return end
		local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
		if not tbl then return end
		if (self.PrevR_Change ~= self.Train.R_ChangeRoute.Value or self.PrevLine ~= self.Line) or spec then
			if self.PrevLine ~= self.Line then
				self.laststbl = {}				
				for i=1,#tbl do
					if tbl[i].arrlast then table.insert(self.laststbl,i) self.Train:SetNW2String("BMCISLast"..#self.laststbl,tbl[i][4] or tbl[i][2]) end
				end
				self.Train:SetNW2Int("BMCISLasts",#self.laststbl)
				self.MaxNumSel = nil
				self.PrevLine = self.Line			
			end
			self.State1 = 3
			self:Trigger("R_ASNPMenu",true)--to4
			--if tbl.Loop and self.PrevR_Change == 0 then--if (not self.PrevR_Change and self.Train.R_ChangeRoute.Value == 0) or self.PrevR_Change and self.PrevR_Change ~= self.Train.R_ChangeRoute.Value then --tbl.Loop and self.PrevR_Change == 0 then
				--self:Trigger("R_ASNPDown",true)
			--end
			if tbl.Loop then
				self.Path = self.Train.R_ChangeRoute.Value == 1			
			end
			if self.Train.R_ChangeRoute.Value == 1 and not tbl.Loop then
				for i=1,#self.laststbl-1 do
					self:Trigger("R_ASNPDown",true)
				end
			end
			self:Trigger("R_ASNPMenu",true)--to5
			if self.Train.R_ChangeRoute.Value == 1 and not tbl.Loop then				
				for i=1,#self.laststbl-2 do
					self:Trigger("R_ASNPUp",true)
				end				
			end
			self:Trigger("R_ASNPMenu",true)--to6
			self:Trigger("R_ASNPMenu",true)--to7
			if special then
				--self.InitializeTimer = CurTime()
				--self.Train:SetNW2Bool("BMCISInitialize",true)		
				self.Reserve = false
			end
			self.PrevR_Change = self.Train.R_ChangeRoute.Value
		elseif self.State == 2 then
			for i=1,self.Selected+self.Str do
				--self:Trigger("Up1",true)
				self:Prev(true)
			end
		end
		if self.Train.BKL then self:UpdateBoards() end	
		self.Str = 0
		self.Selected = 0		
	end
	
    function TRAIN_SYSTEM:CabQueue(tbl)
 		if not self.AnnTable then self.AnnTable = self.Train.Announcer.AnnTable end
        if not Metrostroi[self.AnnTable] then return end

        for k, v in pairs(tbl) do
            local tbl = Metrostroi[self.AnnTable][self.Train:GetNW2Int("Announcer", 1)]
            if v~=-2 then
                table.insert(self.Schedule, tbl[v] or v)
            else
                self:CabReset()
            end
        end
    end
    function TRAIN_SYSTEM:CabReset()
        if #self.Schedule > 0 then
            self.Schedule = {}
            self.AnnounceTimer = nil
            if self.BuzzWork then self:CabQueue{"buzz_end"} end
        end
        self:CabWriteMessage("_STOP")
    end	
	
    function TRAIN_SYSTEM:CabWriteMessage(msg)
        net.Start("metrostroi_cis_announcer", true)
        net.WriteEntity(self.Train)
        net.WriteString(msg)
        net.Broadcast()
    end	
	
	function TRAIN_SYSTEM:Trigger(name,value)
		local name = name:gsub("BMCIS","")
		local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)]
		local Train = self.Train
	    if Train.SF6.Value == 0 and Train.Electric.Battery80V*(Train.RV.KRRPosition ~= 0 and 1 or 0) < 62 then return end
		--[[
		if name == "R_Program2" and value and #self.Train.Announcer.Schedule==0 then
			if self.State1 ~= 7 and tbl[self.Line] and tbl[self.Line].spec_last then
				self:AnnQueue{"click1"}
				self:AnnQueue(-1)
				self:AnnQueue(tbl[self.Line].spec_last)
				self:AnnQueue{"click2"}
			elseif self.State1 == 7 then
				local ltbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
				local last,lastst
				if self.Arrived then
					if tbl.Loop then
						ltbl = self.LastStation
						lastst = self.LastStation > 0 and self.Station == last and ltbl[last].arrlast
					else
						last = self.Path and self.FirstStation or self.LastStation
						lastst = self.Station == last and ltbl[last].arrlast
					end
				end
				if lastst then
					self:AnnQueue{"click1"}
					self:AnnQueue(-1)
					self:AnnQueue(ltbl.spec_last)
					self:AnnQueue{"click2"}
				else
					self.StopMessage = not self.StopMessage
					self:AnnQueue{"click1"}
					self:AnnQueue(ltbl.spec_wait[self.StopMessage and 1 or 2])
					self:AnnQueue{"click2"}
				end
			end
		end
		]]
		if self.State == 1 then
			if name == "Enter" and value and self.Selected < 3 then
				self.Selected = (self.Selected == 0 and 2 or self.Selected + 1)
			elseif name == "Enter" and value and self.Selected == 3 then
				self.Selected = 1
			end
			if name == "Up" and value and Format("%03d",self.RouteNumber)[math.max(1,self.Selected)] ~= "9" then
				self.RouteNumber = math.min(999,self.RouteNumber+10^(3-math.max(1,self.Selected)))
			end
			if name == "Down" and value and Format("%03d",self.RouteNumber)[math.max(1,self.Selected)] ~= "0" then
				self.RouteNumber = math.max(0,self.RouteNumber-10^(3-math.max(1,self.Selected)))
			end	
			if name == "R_ToBack" and value then
				self.R_ToBackTimer = CurTime()
			end			
			if name == "ToState3" then
				if Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)] then
					self.NumLines = #Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)]
					Train:SetNW2Int("NumLines",self.NumLines)
				end
				if Train:GetNW2String("BMCISWagN1","-----") == "-----" then
					for i=1,math.min(8,#Train.WagonList) do
						if (Train.WagonList[i].NumberRanges[1][1] == 30001 or Train.WagonList[i].NumberRanges[1][1] == 37095) then
							Train:SetNW2String("BMCISWagN"..i,Train.WagonList[i].WagonNumber)
						end
					end		
				end				
				self.State = 3
				self.Selected = self.Line+3
			end				
			if name == "ToState2" then
				self.Selected = 0
				self:Set(true,true)
				if Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)] then
					self.NumLines = #Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)]
					Train:SetNW2Int("NumLines",self.NumLines)
				end
				if Train:GetNW2String("BMCISWagN1","-----") == "-----" then
					for i=1,math.min(8,#Train.WagonList) do
						if (Train.WagonList[i].NumberRanges[1][1] == 30001 or Train.WagonList[i].NumberRanges[1][1] == 37095) then
							Train:SetNW2String("BMCISWagN"..i,Train.WagonList[i].WagonNumber)
						end
					end		
				end 
				if self.SelectedState then self.Selected = self.SelectedState self.SelectedState = nil end
				if self.StrState then self.Str = self.StrState self.StrState = nil end
				self.Adverts = {}
				for i=1,(Metrostroi.TickerAdverts and #Metrostroi.TickerAdverts or 0) do
					Train:SetNW2Bool("BMCISTicker"..i,false)
				end
				for i=1,#Train.WagonList do
					Train.WagonList[i].BackTicker.Adverts = {}
				end				
				self.State = 2	

				--Train.ASNP.State = 3
				--Train.ASNP.Path = self.Path
				self:SyncBMCIS()				
			end		
		end
		if self.State1 == 1 and name == "R_ASNPMenu" and value then
			self.State1 = 2
			self.Selected = 0
		elseif self.State1 == 2 and value then
			if name == "R_ASNPMenu" then
				self.Selected = self.Selected + 1
				if self.Selected > 2 then
					self.State1 = 3
				end
			end
			--[[
			if (name == "R_ASNPUp" or name == "R_ASNPDown") and self.Selected < 2 then
				local sel = 2-self.Selected
				local num = Format("%03d",self.RouteNumber)[self.Selected+1]
				if name == "R_ASNPUp" then if num == "9" then self.RouteNumber = self.RouteNumber - 10^sel*9 else self.RouteNumber = self.RouteNumber + 10^sel end end
				if name == "R_ASNPDown" then if num == "0" then self.RouteNumber = self.RouteNumber + 10^sel*9 else self.RouteNumber = self.RouteNumber - 10^sel end end
			end]]
			if (name == "R_ASNPUp" or name == "R_ASNPDown") and self.Selected == 2 then self.Selected = 0 end
		elseif self.State1 == 3 and value then
			if name == "R_ASNPDown" and value then
				self.Line =self.Line + 1
				if self.Line > #tbl then self.Line = 1 end
			end
			if name == "R_ASNPUp" and value then
				self.Line = math.max(1,self.Line - 1)
				if self.Line < 1 then self.Line = #tbl end
			end
			if name == "R_ASNPMenu" and value then
				if not tbl[self.Line].Loop then
					self.FirstStation = 1
				end
				self.State1 = 4
			end
		elseif self.State1 == 4 and value and not tbl[self.Line].Loop then --Не кольцевой
			local stbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
			if name == "R_ASNPDown" then
				local found = false
				for i=self.FirstStation+1,#stbl do
					if stbl[i].arrlast then self.FirstStation = i;found=true;break end
				end
				if not found then
					for i=1,#stbl do
						if stbl[i].arrlast then self.FirstStation = i;break end
					end
				end
			end
			if name == "R_ASNPUp" then
				local found = false
				for i=self.FirstStation-1,1,-1 do
					if stbl[i].arrlast then self.FirstStation = i;found=true;break end
				end
				if not found then
					for i=#stbl,1,-1 do
						if stbl[i].arrlast then self.FirstStation = i;break end
					end
				end
			end
			if name == "R_ASNPMenu" then
				self.State1 = 5
				for i=#stbl,1,-1 do
					if i ~= self.FirstStation and stbl[i].arrlast then self.LastStation = i;break end
				end
			end
		elseif self.State1 == 4 and value and tbl[self.Line].Loop then --Кольцевой
			--if name == "R_ASNPDown" or name == "R_ASNPUp" then
				--self.Path = not self.Path
			--end
			if name == "R_ASNPMenu" then
				self.LastStation = 0
				self.FirstStation = 0
				self.State1 = 5
			end
		elseif self.State1 == 5 and value and not tbl[self.Line].Loop then --Не кольцевой
			local stbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
			if name == "R_ASNPDown" then
				local found = false
				for i=self.LastStation+1,#stbl do
					if i ~= self.FirstStation and stbl[i].arrlast then self.LastStation = i;found=true;break end
				end
				if not found then
					for i=1,#stbl do
						if i ~= self.FirstStation and stbl[i].arrlast then self.LastStation = i;break end
					end
				end
			end
			if name == "R_ASNPUp" then
				local found = false
				for i=self.LastStation-1,1,-1 do
					if i ~= self.FirstStation and stbl[i].arrlast then self.LastStation = i;found=true;break end
				end
				if not found then
					for i=#stbl,1,-1 do
						if i ~= self.FirstStation and stbl[i].arrlast then self.LastStation = i;break end
					end
				end
			end
			if name == "R_ASNPMenu" then
				self.Path = self.FirstStation > self.LastStation
				self.Station = self.FirstStation
				if self.Path then
					local first = self.LastStation
					self.LastStation = self.FirstStation
					self.FirstStation = first
				end
				self.Arrived = true
				self.State1 = 6
			end
		elseif self.State1 == 5 and value and tbl[self.Line].Loop then --Кольцевой
			local stbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
			if name == "R_ASNPDown" then
				local found = false
				for i=self.LastStation+1,#stbl do
					if stbl[i].arrlast then self.LastStation = i;found=true;break end
				end
				if not found and self.LastStation ~= 0 then
					self.LastStation = 0
				end
			end
			if name == "R_ASNPUp" then
				local found = false
				if self.LastStation == 1 then
					self.LastStation = 0
					found = true
				end
				for i=self.LastStation-1,1,-1 do
					if stbl[i].arrlast and stbl[i].arrlast[self.Path and 2 or 1] then self.LastStation = i;found=true;break end
				end
				if not found then
					for i=#stbl,1,-1 do
						if stbl[i].arrlast and stbl[i].arrlast[self.Path and 2 or 1] then self.LastStation = i;break end
					end
				end
			end
			if name == "R_ASNPMenu" then
				self.State1 = 6
				self.Station = 1
				self.Arrived = true
			end
		elseif self.State1 == 6 and value then
			local stbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
			if name == "R_ASNPDown" or name == "R_ASNPUp" then
				self.State1 = 2
				self.Selected = 0
			end
			if name == "R_ASNPMenu" then
				if self.FirstStation ~= 0 then--Информатор готов к работе
					--[[
					if self.Path then
						self.Train.Announcer:Queue{"click1","announcer_ready",stbl[self.LastStation].arrlast[3],stbl[self.FirstStation].arrlast[3],"click2"}
					else
						self.Train.Announcer:Queue{"click1","announcer_ready",stbl[self.FirstStation].arrlast[3],stbl[self.LastStation].arrlast[3],"click2"}
					end
					]]
				end
				self.State1 = 7
				if Train.BKL then self:UpdateBoards() end
				--self:SyncBMCIS()
				self.StopMessage = false
			end
		elseif self.State == 2 then-- and self.State1 == 7 then
			if self.Line >= 1 and Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)] then
				local stbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
			end
			if name == "R_ASNPMenu" and value then self.ReturnTimer = CurTime() end
			if name == "R_ASNPMenu" and not value and self.ReturnTimer and self.ReturnTimer - CurTime() < 0.7 then
				self.ReturnTimer = nil
			end
			if name == "Down" and value then
				self.DownTimer = CurTime()
			end
			if name == "Down" and not value then
				self.DownTimer = nil
				self.Down = false
			end			
			if name == "Down1" and value and self.Station ~= (self.Path and self.FirstStation or self.LastStation) then
				self:Next(true)
				if math.min(self.Str,self.Reserve and 3 or 12) == (self.Reserve and 3 or 12) then
					self.Selected = self.Selected+1
				else
					self.Str = self.Str + 1
				end 
			end
			if name == "Up" and value then
				self.UpTimer = CurTime()
			end
			if name == "Up" and not value then
				self.UpTimer = nil
				self.Up = false
			end
			if name == "Up1" and value then
				if self.LastStation == 0 then
					self:Prev(true)
					if math.max(0,self.Str) == 0 then
						self.Selected = self.Selected-1--math.max(0,self.Selected-1)
					else
						self.Str = self.Str - 1
					end		
				else
					self:Prev(true)
					if math.max(0,self.Str) == 0 then
						self.Selected = math.max(0,self.Selected-1) --(Metrostroi.ASNPSetup[Train:GetNW2Int("Announcer",1)][self.Line].Loop and self.Selected-1 or (self.Selected < 1 and 0 or self.Selected-1)
					else
						self.Str = self.Str - 1
					end
				end
			end
			if name == "R_ToBack" and value then
				self.R_ToBackTimer = CurTime()
			end
			if name == "ToState2" then
				self:Set(false,true)				
				self.Selected = 0
				self.Str = 0
				self:SyncBMCIS()
				--self:Trigger("Up",true)
			end
			if name == "Enter" and value and #self.Schedule == 0 then
				--if self.InitializeTimer then Train:SetNW2Bool("BMCISInitialize",false) self.InitializeTimer = nil end	
				self:Play(self.Arrived,nil,true)
			end			
			if (name:find("R_Program1")) and value and #self.Train.Announcer.Schedule==0 then
				if self.InitializeTimer then Train:SetNW2Bool("BMCISInitialize",false) self.InitializeTimer = nil end	
				if not self.Arrived and self.Station == (self.Path and self.FirstStation or self.LastStation) then
					self:Play(self.Arrived)
					self.DoorAlarm = false
				else
					self:Play(self.Arrived)
					if math.min(self.Str,self.Reserve and 3 or 12) == (self.Reserve and 3 or 12) then
						self.Selected = self.Selected + 1
					else
						self.Str = self.Str + 1
					end		
					if self.Line >= 1 then
						self.DoorAlarm = self.Arrived and CurTime()
					end
					self:Next()	
				end		
				--self.DoorAlarm = self.DoorAlarm and CurTime()
				self.DoorClosed = Train.BUKP.DoorClosed or false
			end	
			if name:find("F") and value then
				self.State = 3+tonumber(name[2])
				self.Selected2State = self.Selected	
				self.PrevReserve = self.Reserve
				self.Selected = 1
			end
			if name == "Esc" and value then
				self.ExtraTimer = CurTime()				
			end
			if name == "Esc" and not value then
				--self.ExtraTimer = nil
			end			
		end
		if self.State == 3 then
			if name == "Down" and value then
				self.Selected = math.min(self.NumLines+3,self.Selected + 1)
			end
			if name == "Up" and value then
				self.Selected = math.max(1,self.Selected - 1)
			end
			if name == "Enter" and value then
				self.Line = self.Selected - 3
				if self.Line < 1 then
					self.DoorAlarm = false
				end
				--if self.Line >= 1 then
					self:Set(false,true)
				--end
				self:SyncBMCIS()				
				self.State = 2
			end
		end
		if self.State>=4 and not self.RestartTimer then
			if not self.MaxNumSel then
				self.MaxNumSel = {
					[1] = 3,
					[2] = (self.laststbl and #self.laststbl or 2)-2,
					[3] = (Metrostroi.TickerAdverts and #Metrostroi.TickerAdverts or 0),
					[4] = 6,
					[5] = 2,
				}
			end
			if self.State == 8 and not self.Extra or self.State ~= 8 then
				if self.State == 6 and not self.Reserve or self.State ~= 6 then 
					if name == "Down" and value then
						self.Selected = math.min(self.MaxNumSel[self.State-3],self.Selected + 1) 
					end
					if name == "Up" and value then
						self.Selected = math.max(1,self.Selected-1)
					end
				end
			end
			if name:find("F") and value then
				self.State = 3+tonumber(name[2])
				self.Selected = 1
			end
			if name:find("R_Program1") and value and #self.Train.Announcer.Schedule==0 and self.State ~= 8 then	
				if self.InitializeTimer then Train:SetNW2Bool("BMCISInitialize",false) self.InitializeTimer = nil end				
				if not self.Arrived and self.Station == (self.Path and self.FirstStation or self.LastStation) then
					self:Play(self.Arrived)
					self.DoorAlarm = false					
				else
					self:Play(self.Arrived)
					if math.min(self.Str,self.Reserve and 3 or 12) == (self.Reserve and 3 or 12) then
						self.Selected2State = self.Selected2State + 1
					else
						self.Str = self.Str + 1
					end		
					self.DoorAlarm = self.Arrived and CurTime()				
					self:Next()	
				end
				--self.DoorAlarm = self.DoorAlarm and CurTime()
				self.DoorClosed = Train.BUKP.DoorClosed or false
				
				if math.min(self.Str,self.Reserve and 3 or 12) == (self.Reserve and 3 or 12) then
					self.Selected2State = self.Selected2State + (self.Str-(self.Reserve and 3 or 12))
					self.Str = self.Reserve and 3 or 12
				end
				self.Selected = self.Selected2State
				self.State = 2				
			end		
			if name == "Esc" and value and self.State ~= 8 then
				self.ExtraTimer = CurTime()		
			end		
			if name == "Esc" and not value then
				--self.ExtraTimer = nil
			end
		end
		if self.State == 4 then
			if name == "Enter" and value and #self.Train.Announcer.Schedule==0 then
				local ltbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)] and Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
				if ltbl then
					--if self.InitializeTimer then Train:SetNW2Bool("BMCISInitialize",false) self.InitializeTimer = nil end								
					self:AnnQueue{"click1"}
					if self.Selected == 1 then
						self:AnnQueue(-1)
						self:AnnQueue(ltbl.spec_last)
					elseif self.Selected == 2 then
						self:AnnQueue(ltbl.spec_wait[1])
					elseif self.Selected == 3 then
						self:AnnQueue(ltbl.spec_wait[2])
					end
					self:AnnQueue{"click2"}
				end
			end
		end
		if self.State == 5 then 
			if name == "Enter" and value and self.LastStationEntered == 0 then
				self.LastStationEntered = self.Selected+1
			elseif name == "Enter" and value and self.LastStationEntered > 0 then
				self.LastStationEntered = 0
			end
			if name == "Enter" and value then
				Train:SetNW2Int("BMCISLastStationEntered",self.LastStationEntered or 0)
			end
		end
		if self.State == 6 then
			if self.Reserve then
				if name == "Up" and value then
					if self.Selected > 1 then
						self.Selected = math.max(1,self.Selected - 1)
					else
						self.Str2 = math.max(0,self.Str2 - 1)
					end
				end
				if name == "Down" and value then
					if self.Selected < 7 then
						self.Selected = self.Selected+1
					elseif self.Str2+self.Selected < (Metrostroi.TickerAdverts and #Metrostroi.TickerAdverts or 0) then
						self.Str2 = self.Str2 + 1
					end
				end
			end
			if name == "Enter" and value then
				--[[
				for i=1,#Train.WagonList do
					if Train.WagonList[i].BackTicker and Train.WagonList[i].Advert ~= -1 then
						Train.WagonList[i].BackTicker.Advert = self.Selected
						Train.WagonList[i].BackTicker.NewAdvert = true
					end
				end]]
				self.Adverts[self.Selected+self.Str2] = not self.Adverts[self.Selected+self.Str2]
				Train:SetNW2Bool("BMCISTicker"..(self.Selected+self.Str2),self.Adverts[self.Selected+self.Str2])				
				for i=1,#Train.WagonList do
					Train.WagonList[i].BackTicker.Adverts[self.Selected+self.Str2] = self.Adverts[self.Selected+self.Str2]
				end
			end
		end
		if self.State == 7 then
			if name == "Enter" and value then
				if self.Selected == 1 then
					self.Selected = 0
					self.SelectedState = self.Selected
					self.StrState = self.Str
					self.State = 1
				elseif self.Selected == 2 then
					self.Reserve = not self.Reserve
					self.Str2 = 0
					if self.Reserve and self.Str > 3 then
						--print(self.Str,self.Selected)
						self.Selected2State = self.Selected2State + (self.Str-3)
						self.Str = 3
						--self.Selected = self.Selected+(self.Str-3)
						--self.Str = 3
					elseif not self.Reserve and self.Str then
						--local stbl = Metrostroi.ASNPSetup[Train:GetNW2Int("Announcer",1)][self.Line]
						--print(self.Str+self.Selected2State,2*(#stbl-1))	
						local sum = self.Str+self.Selected2State
						if sum >= 13 then
							self.Selected2State = (sum-12)
							self.Str = sum-self.Selected2State							
						else
							self.Selected2State = 0
							self.Str = sum
						end
					end
				elseif self.Selected == 3 or self.Selected == 4 then
					self.RestartTimer = CurTime()+math.Rand(2,4)
				elseif self.Selected == 5 or self.Selected == 6 then
					Train.Speedometer.RestartTimer = CurTime()+(self.Selected == 5 and math.Rand(2,4) or math.Rand(4,6))
					Train.Speedometer.State = -1
				end
			end
		end
		if self.State == 8 then
			if name == "Enter" and value and not self.Extra then
				local tbl
				self.ExtraDir = (self.Selected == 1)
				self.Extra = true
				--[[
				if Metrostroi.ASNPSetup[Train:GetNW2Int("Announcer",1)] then
					tbl = Metrostroi.ASNPSetup[Train:GetNW2Int("Announcer",1)]
				end
				if Metrostroi.CISConfig[Train.CISConfig] then
					tbl = Metrostroi.CISConfig[Train.CISConfig]
				end	]]			
				for i=1,#Train.WagonList do
					local wag = Train.WagonList[i]
					if not wag.BUV then break end
					wag:SetNW2Bool("BMCISExtra",true)
					wag:SetNW2Bool("BMCISExtraDir",(wag.BUV.Orientation and self.ExtraDir) or (not wag.BUV.Orientation and not self.ExtraDir))
					--wag:SetNW2String("BMCISExtraSt",tbl[self.Line][self.Station][2])
				end	
				
				if #Train.Announcer.Schedule > 0 then
					Train.Announcer:Reset()
				end
				if #self.Schedule > 0 then
					self:CabReset()
				end						
				self:AnnQueue(-1)	
			
				if not Metrostroi.AnnouncementsASNP then Metrostroi.AnnouncementsASNP = {} end
				Metrostroi.AnnouncementsASNP.cis_evac_back = {"subway_trains/760/cis_evac_back_romanova.wav",15.072}--cis_evac_back
				Metrostroi.AnnouncementsASNP.cis_evac_forward = {"subway_trains/760/cis_evac_forward.wav",15.072}--18.57
				if not Metrostroi[Train.Announcer.AnnTable] then Metrostroi[Train.Announcer.AnnTable] = {} end
				if not Metrostroi[Train.Announcer.AnnTable][self.Train:GetNW2Int("Announcer",1)] then Metrostroi[Train.Announcer.AnnTable][self.Train:GetNW2Int("Announcer",1)] = {} end
				Metrostroi[Train.Announcer.AnnTable][self.Train:GetNW2Int("Announcer", 1)].cis_evac_back = {"subway_trains/760/cis_evac_back_romanova.wav",15.072}
				Metrostroi[Train.Announcer.AnnTable][self.Train:GetNW2Int("Announcer", 1)].cis_evac_forward = {"subway_trains/760/cis_evac_forward.wav",18.57}
				self:AnnQueue({"cis_evac_"..(self.ExtraDir and "forward" or "back")})	
				
			end
			if name == "Esc" and self.Extra and value then
				for i=1,#Train.WagonList do
					local wag = Train.WagonList[i]
					if not wag.BUV then break end
					wag:SetNW2Bool("BMCISExtra",false)
				end				
				Train.Announcer:Reset()
				self:CabReset()
				
				self.Selected = self.Selected2State
				self.ExtraTimer = nil					
				
				self.Extra = false
				self.State = 2
			end
		end
		if self.State >= 2 then
			if name == "R_ToBack" and value then
				self.R_ToBackTimer = CurTime()
			end			
			if name == "ToState3" then
				if Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)] and not self.NumLines then
					self.NumLines = #Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)]
					Train:SetNW2Int("NumLines",self.NumLines)
				end			
				self.State = 3
				self.Selected = self.Line+3
			end	
		end
		if self.State > 0 then
			if name == "R_Micro" and value then
				if Train.R_Line.Value == 1 and self.State >= 2 then
					if #Train.Announcer.Schedule > 0 then
						Train.Announcer:Reset()
					end
					if #self.Schedule > 0 then
						self:CabReset()
					end
				end				
				Train:SetNW2Bool("BMCISMicroCabin",Train.R_Line.Value == 0)		
				Train:SetNW2Bool("BMCISMicro",true)
				Train:CANWrite("BMCIS",self.Train:GetWagonNumber(),"BMCIS",nil,"Connection",1-Train.R_Line.Value)				
			end
			if name == "R_Micro" and not value then
				Train:SetNW2Bool("BMCISMicro",false)
				Train:SetNW2Bool("BMCISMicroCabin",false)
				Train:CANWrite("BMCIS",self.Train:GetWagonNumber(),"BMCIS",nil,"Connection",0)								
			end		
		end
	end
	function TRAIN_SYSTEM:Reset(fast,route)
		self.LastStationEntered = 0
		self.Train:SetNW2Int("BMCISLastStationEntered",0)
		if route then self.RouteNumber = 0 end
		self.Selected = 0
		self.State = fast and 1 or -1
		self.PrevR_Change = nil
		self.PrevLine = nil
		self.MaxNumSel = nil
		self.Str = 0
		--self.Line = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)] and 1 or -2
		self.RestartTimer = nil
		self.InitializeTimer = CurTime()		
		self.Train:SetNW2Bool("BMCISInitialize",true)			
	end
	local SpecialLines = {
		[-2] = "        обкатка",
		[-1] = "       перегонка",
		[ 0] = "          в депо",
	}		
	function TRAIN_SYSTEM:Think(dT)
		local Train = self.Train
		local Power = Train.Electric.Battery80V > 62 and Train.SF12.Value+Train.SF13.Value > 0
		if self.Power ~= Power then
			self.Power = Power
			if not self.Power and (--[[Train.BUV.CurrentBUP==Train.WagonNumber or]] self.State > 1) then
				Train.CIS:Trigger("Restart",0)
				for i=1,#self.Train.WagonList do
					local wag = self.Train.WagonList[i]
					if not wag.BUV then break end
					wag:SetNW2Bool("BMCISExtra",false)
				end				
				self.Extra = false
				if #Train.Announcer.Schedule > 0 then
					Train.Announcer:Reset()
				end
				if #self.Schedule > 0 then
					self:CabReset()
				end			
				Train.CIS:Trigger("BMCISInit",false)
			end
		end
		if self.State <= 0 then
			self.RouteNumber = 0
			self.Selected = 0
			self.PrevR_Change = nil
			self.PrevLine = nil
			self.MaxNumSel = nil
			self.Str = 0
			--self.Line = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)] and 1 or -2
			self.LastStationEntered = 0
			self.InitializeTimer = CurTime()
			self.Train:SetNW2Bool("BMCISInitialize",true)
			Train:SetNW2Int("BMCISLastStationEntered",0)			
		end
		if self.DoorAlarm and (not self.DoorClosed and Train.BUKP.DoorClosed or CurTime()-self.DoorAlarm > 25) then
			self.DoorAlarm = false
		end
		if self.State > 1 then
			Train.CIS:Trigger("DoorAlarm",self.DoorAlarm)
		end
		--print(self.LastStation)
		--print(Train.Owner:GetInfo("760_last"))
		if self.State >=1 then
			local owner = IsValid(Train.Owner) and Train.Owner or CPPI and Train:CPPIGetOwner()
			if IsValid(owner) and owner:GetInfo("760_last") ~= "" and owner:GetInfo("760_last") ~= Train.RouteNumber.NextLastStation then--Train:GetNW2String("BMCISLastSt") then
				Train:SetNW2String("BMCISLastSt",owner:GetInfo("760_last"))
				Train:SetNW2Bool("BMCISLastSt1",false)	
				Train.RouteNumber:TriggerInput("LastStation",owner:GetInfo("760_last"),self.State > 1 and self.RouteNumber)--self.Train:GetNW2String("BMCISLastSt"))
				
				--Train.RouteNumber:TriggerInput("LastStation",owner:GetInfo("760_last"))
			elseif ((IsValid(owner) and owner:GetInfo("760_last") == "" or not IsValid(owner)) and (self.Line >=1) and self.laststbl and #self.laststbl > 0 and (self.LastStationEntered ~= 0 and Train:GetNW2String("BMCISLast"..self.LastStationEntered) or self.LastStation == 0 and "                        xxx   "..(self.Path and "z" or "y").. "   xxx" or Train:GetNW2String("BMCISLast"..(self.Path and 1 or #self.laststbl))) ~= Train.RouteNumber.NextLastStation) then--Train:GetNW2String("BMCISLastSt")) then
				Train:SetNW2String("BMCISLastSt",self.LastStationEntered ~= 0 and Train:GetNW2String("BMCISLast"..self.LastStationEntered) or Train:GetNW2String("BMCISLast"..(self.Path and 1 or #self.laststbl)),self.State > 1 and self.RouteNumber)
				if self.LastStation == 0 then--кольцевая надпись для табло
					Train:SetNW2String("BMCISLastSt","                        xxx   "..(self.Path and "z" or "y").. "   xxx")		
					Train:SetNW2Bool("BMCISLastSt1",true)
				else
					Train:SetNW2Bool("BMCISLastSt1",false)
				end
				Train.RouteNumber:TriggerInput("LastStation",self.Train:GetNW2String("BMCISLastSt"),self.State > 1 and self.RouteNumber)--self.LastStationEntered ~= 0 and Train:GetNW2String("BMCISLast"..self.LastStationEntered) or Train:GetNW2String("BMCISLast"..(self.Path and 1 or #self.laststbl)),self.State > 1 and self.RouteNumber)
				
				--Train.RouteNumber:TriggerInput("LastStation",self.LastStationEntered ~= 0 and Train:GetNW2String("BMCISLast"..self.LastStationEntered) or Train:GetNW2String("BMCISLast"..(self.Path and 1 or #self.laststbl)))				
			elseif (IsValid(owner) and owner:GetInfo("760_last") == "" or not IsValid(owner)) and (self.Line < 1) and SpecialLines[self.Line] ~= Train.RouteNumber.NextLastStation then-- Train:GetNW2String("BMCISLastSt") ~= SpecialLines[self.Line] then
				Train:SetNW2String("BMCISLastSt",SpecialLines[self.Line])
				Train:SetNW2Bool("BMCISLastSt1",false)
				--Train.RouteNumber:TriggerInput("LastStation",SpecialLines[self.Line])
				Train.RouteNumber:TriggerInput("LastStation",SpecialLines[self.Line],self.RouteNumber)

			end
		end
		for k,v in pairs(self.TriggerNames) do
			if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
				self:Trigger(v,Train[v].Value > 0.5)
				self.Triggers[v] = Train[v].Value > 0.5
			end
		end	
		if self.UpTimer and CurTime()-self.UpTimer > 0.5 then
			if (CurTime()-self.UpTimer)%0.2 < 0.1 and not self.Up then
				self:Trigger("Up1",true)
				self.Up = true
			elseif (CurTime()-self.UpTimer)%0.2 > 0.1 and self.Up then
				self.Up = false
			end
		elseif self.UpTimer and not self.Up then
			self:Trigger("Up1",true)		
			self.Up = true
		end
		if self.DownTimer and CurTime()-self.DownTimer > 0.5 then
			if (CurTime()-self.DownTimer)%0.2 < 0.1 and not self.Down then
				self:Trigger("Down1",true)
				self.Down = true
			elseif (CurTime()-self.DownTimer)%0.2 > 0.1 and self.Down then
				self.Down = false
			end
		elseif self.DownTimer and not self.Down then
			self:Trigger("Down1",true)
			self.Down = true
		end		
		if self.ExtraTimer then
			if CurTime()-self.ExtraTimer > 5 and Train.BMCISEsc.Value == 1 then
				self.Selected2State = self.Selected	
				self.PrevReserve = self.Reserve
				self.Selected = 1				
				self.ExtraTimer = nil			
				self.State = 8
			elseif self.State>=4 and not self.RestartTimer and Train.BMCISEsc.Value == 0 and self.State ~= 8 then
				self.State = 2
				self.Selected = self.Selected2State
				self.ExtraTimer = nil				
			end
		end
		if self.Extra and #Train.Announcer.Schedule == 0 then
			self:AnnQueue({"cis_evac_"..(self.ExtraDir and "forward" or "back")})
			for i=1,#Train.WagonList do
				local wag=Train.WagonList[i]
				if not wag.BUV then return end
				wag:SetNW2Float("PassengerCount",0)
			end
		end
		if not self.Power then self.Timer = CurTime() end
		if not self.Power and self.State ~= -1 then self.State = -1 end
		if CurTime()-self.Timer > 0.3 and CurTime()-self.Timer < 0.45 and self.Power then Train:SetNW2Bool("Merc",true) else Train:SetNW2Bool("Merc",false) end
		if self.State == -1 and not self.Power then self.StateTimer = CurTime()+6 end
		if self.Power and self.State == -1 and self.StateTimer and CurTime()-self.StateTimer > 0 then self.StateTimer = CurTime()+8 self.State = 0 end		
		if self.Power and self.State ==  0 and self.StateTimer and CurTime()-self.StateTimer > 0 then self.State = 1 end		
		if self.RestartTimer and CurTime()-self.RestartTimer > 0 then self:Reset((self.State == 7 and self.Selected == 3) ,true) end
		if self.PassSchemeWork ~= (Train.PassScheme.Value>0 and self.State1==7) then
			self:UpdateBoards()
			self.PassSchemeWork = Train.PassScheme.Value>0 and self.State1==7
		end
		Train:SetNW2Int("BMCISState",self.State)
		if self.State < 1 and self.R_ToBackTimer then self.R_ToBackTimer = nil end
		if self.R_ToBackTimer and CurTime()-self.R_ToBackTimer >=3  then
			self:Trigger("ToState3")
			self.R_ToBackTimer = nil
		elseif self.R_ToBackTimer and Train.R_ToBack.Value == 0 then
			self:Trigger("ToState2")
			self.R_ToBackTimer = nil
		end
		if self.State > 0 then
			--[[
			if self.State >= 2 then
				if self.Train.RouteNumber.NextRouteNumber ~= self.RouteNumber then
					self.Train.RouteNumber:TriggerInput("RouteNumber",self.RouteNumber)
				end	
			end]]
			self.Date = os.date("%d.%m.%y",Metrostroi.GetSyncTime())
			self.Time = os.date("%H:%M",Metrostroi.GetSyncTime())	
			if (self.InitializeTimer or self.State < 2) then self.Date1 = nil self.Time = os.date("%H:%M",CurTime()-self.Timer+75600) end
			if not self.InitializeTimer and self.State >= 2 then self.Date1 = os.date("%d.%m.%Y",Metrostroi.GetSyncTime()) end
			Train:SetNW2String("BMCISDate",self.Date)
			Train:SetNW2String("BMCISDate1",self.Date1)				
			Train:SetNW2String("BMCISTime",self.Time)
			Train:SetNW2Int("BMCISSelected",self.Selected)	
			Train:SetNW2Int("BMCISRouteNumber",self.RouteNumber)
			
			if self.State == 2 then
				Train:SetNW2Int("BMCISLastStation",self.LastStation)	
				Train:SetNW2Int("BMCISFirstStation",self.FirstStation)
				Train:SetNW2Int("BMCISStr",self.Str)
				Train:SetNW2Bool("BMCISArrived",self.Arrived)
				Train:SetNW2Int("BMCISStation",self.Station)	
				Train:SetNW2Bool("BMCISPath",self.Path)
				Train:SetNW2Int("BMCISLine",self.Line)		
				Train:SetNW2Bool("BMCISPlaying",#self.Train.Announcer.Schedule>0 or #self.Schedule > 0)
			end
			if self.State == 6 then
				Train:SetNW2Int("BMCISStr2",self.Str2)			
			end
			Train:SetNW2Bool("BMCISReserve",self.Reserve)
			Train:SetNW2Bool("RouteNumber",self.RouteNumber)
			if self.Reserve and self.State >=2 then

			end
		elseif self.State == -1 then
			self.Date1 = nil self.Time = os.date("%H:%M",CurTime()-self.Timer+75600)
		end
		
		--CabAnnouncer
        while #self.Schedule > 0 and (not self.AnnounceTimer or CurTime() - self.AnnounceTimer > 0) do
            local tbl = table.remove(self.Schedule, 1)
            if type(tbl) == "number" then
                self.AnnounceTimer = CurTime() + tbl
            elseif tbl == "noise_start" then
                self.NoiseWork = true
            elseif tbl == "noise_end" then
                self.NoiseWork = false
            elseif tbl == "buzz_start" then
                self.BuzzWork = true
            elseif tbl == "buzz_end" then
                self.BuzzWork = false
            elseif type(tbl) == "table" then
                self:CabWriteMessage(tbl[1])
                self.AnnounceTimer = CurTime() + tbl[2]
            else
                ErrorNoHalt("Announcer error in message "..tbl.."\n")
            end
        end
        if #self.Schedule == 0 and self.AnnounceTimer and CurTime() - self.AnnounceTimer > 0 then
            self.AnnounceTimer = nil
            if self.BuzzWork then self:CabQueue{"buzz_end"} end
        end
        if #self.Schedule > ANNOUNCER_CACHE_LIMIT then
            self:CabReset()
        end				
	end
else
	local function createFont(name,font,size,weight,blur,scanlines,underline)
		surface.CreateFont("Metrostroi_760_"..name, {
			font = font,
			size = size,
			weight = weight or 400,
			blursize = blur or false,
			antialias = true,
			underline = underline,
			italic = false,
			strikeout = false,
			symbol = false,
			rotary = false,
			shadow = true,
			additive = false,
			outline = false,
			extended = true,
			scanlines = scanlines or false,
		})
	end
	createFont("BMCIS","Calibri",28,0,0,0,false)
	createFont("BMCIS11","Calibri",30,0,0,0,false)
	createFont("BMCIS1","Calibri",90,0,0,0,false)
	createFont("BMCIS2","Helvetica",32,0,0,0,false)	
	createFont("BMCIS3","Helvetica",50,0,0,0,false)	
	createFont("BMCIS4","Helvetica",24,0,0,0,false)		
	--createFont("BMCIS2","ArialUnicodeMS",50,0,0,0,false)	
	local bmcis2 = surface.GetTextureID("bmcis/cis_2_default")
	local bmcis2_add = surface.GetTextureID("bmcis/cis_2_add")
	local bmcis2_start = surface.GetTextureID("bmcis/cis_2_start")
	local bmcis2_reserve = surface.GetTextureID("bmcis/reserve_default")
	local bmcis2_reserve_add = surface.GetTextureID("bmcis/reserve_add")
	local bmcis2_reserve_speed = surface.GetTextureID("bmcis/cis_white_parts/arrow_reserve")--local bmcis2_reserve_speed = surface.GetTextureID("bmcis/arrow_reserve")
	local bmcis2_rect = surface.GetTextureID("bmcis/rect")
	local red_lamps = surface.GetTextureID("bmcis/red_lamps")
	local lamps_half = surface.GetTextureID("bmcis/lamps_half")
	local lamps_full = surface.GetTextureID("bmcis/lamps_full")
	local glass_heating = surface.GetTextureID("bmcis/glass_heating")
	local wiper = surface.GetTextureID("bmcis/wiper")	
	local triangle = surface.GetTextureID("bmcis/cis_white_parts/small_green_triangle")
	local green_arrow = surface.GetTextureID("bmcis/green_arrow")
	local cis_load = surface.GetTextureID("bmcis/cis_load")

	local function utf8sub(s,i,j)
	   i = i or 1
	   j = j or -1
	   if i<1 or j<1 then
		  local n = utf8.len(s)
		  if not n then return nil end
		  if i<0 then i = n+1+i end
		  if j<0 then j = n+1+j end
		  if i<0 then i = 1 elseif i>n then i = n end
		  if j<0 then j = 1 elseif j>n then j = n end
	   end
	   if j<i then return "" end
	   i = utf8.offset(s,i)
	   j = utf8.offset(s,j+1)
	   if i and j then return s:sub(i,j-1)
		  elseif i then return s:sub(i)
		  else return ""
	   end
	end	
	CreateConVar("760_last", "", FCVAR_USERINFO )

	function TRAIN_SYSTEM:ClientThink()
        if not self.Train:ShouldDrawPanel("BMCIS") then return end
	    if not self.DrawTimer then
			render.PushRenderTarget(self.Train.BMCIS,0,0,1024,1024)
            render.Clear(0, 0, 0, 0)
            render.PopRenderTarget()
        end
        if self.DrawTimer and CurTime()-self.DrawTimer < 0.1 then return end
        self.DrawTimer = CurTime()	
	
		render.PushRenderTarget(self.Train.BMCIS,0,0,1024,1024)
		render.Clear(0, 0, 0, 0)
		cam.Start2D()
			surface.SetDrawColor(0,0,0)
			--surface.DrawRect(0,0,1024,1024)
			self:BMCIS(self.Train)
		cam.End2D()
		render.PopRenderTarget()
	end
	local SpecialLines = {
		[-2] = "Обкатка",
		[-1] = "Перегонка",
		[ 0] = "В Депо",
	}			
	local AttentionMessages = {
		[1] = "Конечная. Поезд дальше не идёт...",
		[2] = "Поезд скоро отправится",
		[3] = "Поезд отправляется",
	}
	local ServiceMenu = {
		[1] = "Изменить номер маршрута",
		[2] = "Резервный спидометр вкл./выкл.",
		[3] = "Быстрый перезапуск информатора (экспериментально)",
		[4] = "Полная перезагрузка информатора",
		[5] = "Быстрый перезапуск спидометр (экспериментально)",
		[6] = "Полная перезагрузка спидометра",
	}
	local ExtraMenu = {
		[1] = "Эвакуация по ходу",
		[2] = "Эвакуация против хода",
	}
	local blue = Color(100,200,210)
	local white = Color(255,255,255)
	local red = Color(177,20,20)
	local red2 = Color(180,20,20)
	local green = Color(80,225,85)--Color(100,200,150)
	local yellow = Color(225,220,30)
	local yellow2 = Color(176,159,27)
	local font = "Metrostroi_760_BMCIS"
	function TRAIN_SYSTEM:BMCIS(Train)
		local state = Train:GetNW2Int("BMCISState",0)
		local date = Train:GetNW2String("BMCISDate","00.00.00")
		local time = Train:GetNW2String("BMCISTime","00:00:00") 
		local sel = Train:GetNW2Int("BMCISSelected",0)
		local reserve = Train:GetNW2Bool("BMCISReserve",false)		
		--local route = Route[1].."  "..Route[2].."  "..Route[3]
		if reserve and state >=2 then
			local speedL = Train.BUKP.SpeedLimit or 0
			local speed = math.floor(Train:GetNW2Int("BMCISSpeed",0))--math.min(100,math.floor(Train:GetNW2Int("BMCISSpeed",0)))		
			local Speed = math.min(100,Train:GetNW2Int("BMCISSpeedAng",0)/10)--math.min(100,Train:GetNW2Int("BMCISSpeedAng",0)/20)
			local RezhimARS = Train:GetPackedBool("SA14") and "2/6" or (Train:GetNW2Bool("STL",false) and "ДАУ" or "1/5")
			local speedln
			if (RezhimARS == "2/6" or RezhimARS == "ДАУ") --[[and Train.BUKP.SpeedLimitNext]] and Train.BUKP.SpeedLimitNext ~= -1 then
				speedln = Train.BUKP.SpeedLimitNext or 0
			end
			if speedL >= 19 and speedL <= 21 then
				speedln = 0
			elseif speedL == 0 then
				speedln = nil
			end			
			
			if state == 2 then
				surface.SetDrawColor(255,255,255)
				surface.SetTexture(bmcis2_reserve)
				surface.DrawTexturedRectRotated(537,522,1024,1024,0)--surface.DrawTexturedRectRotated(512,512-52,1024,1024,0)	
			else
				surface.SetDrawColor(255,255,255)
				surface.SetTexture(bmcis2_reserve_add)
				surface.DrawTexturedRectRotated(537,522,1024,1024,0)--surface.DrawTexturedRectRotated(512,512-52,1024,1024,0)				
			end
			
			surface.SetDrawColor(red2)
			surface.SetTexture(bmcis2_reserve_speed)
			surface.DrawTexturedRectRotated(33+Speed*5,160,32,64,0)

			if speedln then
				if speedln < speedL then
					surface.SetDrawColor(yellow)
					surface.DrawRect(33+speedln*5,116,(speedL-speedln)*5,16)
				end
			end
			if speedL >= 19 and speedL <=21 then
				surface.SetDrawColor(yellow)			
				surface.DrawRect(33,116,133,16)
			end
			
			surface.SetDrawColor(red2)--surface.SetDrawColor(123,31,29)
			surface.DrawRect(33+speedL*5,116,498-speedL*5,16)
			
			surface.SetDrawColor(255,255,255)
			surface.SetTexture(bmcis2_rect)
			surface.DrawTexturedRectRotated(28,162,5,128,0)		
			surface.SetDrawColor(green)
			surface.SetTexture(triangle)
			surface.DrawTexturedRectRotated(38,124,16,32,0)	
			surface.SetDrawColor(255,255,255)
			
			draw.SimpleText(speed,font.."1",655,145,(math.Round(speed) > speedL) and red or (speedln and math.Round(speed) <=speedL and math.Round(speed) > speedln) and yellow or green,TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)	
			if Train.BUKP and Train.BUKP.State > 0 then
				draw.SimpleText(Train:GetNW2Bool("VityazUOS",false) and "УОС" or Train:GetNW2Bool("VityazAB",false) and "АБ" or RezhimARS,font.."2",73,40,yellow,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			draw.SimpleText("ДВЕРИ",font.."4",150,40,Train:GetNW2Bool("BMCISDoors",false) and green or red,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			--draw.SimpleText("",font.."2",368,210,green,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("БТБ",font.."2",309,40,Train:GetNW2Bool("BMCISBTB",false) and red or green,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("АРС1",font.."2",388,40,Train:GetNW2Bool("BMCISBARS",false) and (Train:GetNW2Bool("BMCISBARS1",false) and red or green) or yellow,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("АРС2",font.."2",464,40,Train:GetNW2Bool("BMCISBARS",false) and (Train:GetNW2Bool("BMCISBARS2",false) and red or green) or yellow,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

			--draw.SimpleText("РС",font.."2",130,280,green,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			
			local KRO = (Train:GetPackedRatio("KRO",0)-0.5)*2
			local KRR = (Train:GetPackedRatio("KRR",0)-0.5)*2			
			if Train:GetNW2Bool("BIForward",false) and not Train:GetNW2Bool("BIBack",false) then
				--draw.SimpleText("⬆",font.."3",625,36,green,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				surface.SetTexture(green_arrow)
				surface.DrawTexturedRectRotated(619,38,32,32,0)				
			elseif Train:GetNW2Bool("BIBack",false) and not Train:GetNW2Bool("BIForward",false) then
				--draw.SimpleText("⬇",font.."3",625,36,green,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				surface.SetTexture(green_arrow)
				surface.DrawTexturedRectRotated(619,38,32,32,180)						
			end	
			if Train:GetNW2Bool("BMCISEmergency",false) then
				draw.SimpleText("ЭТ",font.."2",540,40,red,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)	
			end
			if Train:GetNW2Bool("BMCISLN",false) and (KRO ~= 0 or KRR ~= 0) then--?
				draw.SimpleText("Н",font.."2",152,87,green,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)			
			end			
			if Train.BUKP.AO then
				draw.SimpleText("АО",font.."2",73,87,red,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)					
			end	
			if (KRO ~= 0 or KRR ~= 0) and not Train.BUKP.AO and Train:GetNW2Int("VityazSpeedLimit",0) == 19 then-- not Train:GetNW2Bool("ALS",false) then
				draw.SimpleText("ОЧ",font.."2",73,87,red,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)								
			end
			if (KRO ~= 0 or KRR ~= 0) and Train:GetNW2Bool("RS",false) and Train:GetNW2Int("VityazSpeedLimit",0) > 21 and not Train.BUKP.AO then
				draw.SimpleText("РС",font.."2",73,87,green,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)											
			end
			
			surface.SetDrawColor(Train:GetPackedBool("BacklightsEnabled") and Color(160,0,0) or Color(255,255,255))
			surface.SetTexture(red_lamps)
			surface.DrawTexturedRectRotated(227,87,64,32,0)
			surface.SetDrawColor((Train:GetPackedBool("HeadlightsEnabled1") or Train:GetPackedBool("HeadlightsEnabled2")) and Color(0,160,0) or Color(255,255,255))
			surface.SetTexture(lamps_half)
			surface.DrawTexturedRectRotated(305,87,64,32,0)
			surface.SetDrawColor(Train:GetPackedBool("HeadlightsEnabled2") and Color(160,160,0) or Color(255,255,255))
			surface.SetTexture(lamps_full)
			surface.DrawTexturedRectRotated(382,87,64,32,0)
			surface.SetDrawColor(Train:GetPackedBool("GlassHeating") and Color(0,160,0) or Color(255,255,255))
			surface.SetTexture(glass_heating)
			surface.DrawTexturedRectRotated(462,87,64,32,0)
			surface.SetDrawColor(Train:GetPackedBool("Wiper") and Color(160,160,0) or Color(255,255,255))
			surface.SetTexture(wiper)
			surface.DrawTexturedRectRotated(541,87,64,32,0)			
		end
		if state == 0 then
			surface.SetDrawColor(255,255,255)		
			surface.SetTexture(cis_load)
			surface.DrawTexturedRectRotated(537,522,1024,1024,0)	
		elseif state == 1 then
			local Route = Format("%03d",Train:GetNW2String("BMCISRouteNumber",0))

			surface.SetDrawColor(255,255,255)
			surface.SetTexture(bmcis2_start)
			surface.DrawTexturedRectRotated(537,522,1024,1024,0)	
		
			--draw.SimpleText("Блок не активен",font,512,270,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)	
			--draw.SimpleText("№ маршрута",font,512,500,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)				
			--[[
			draw.SimpleText("█   █   █",font,512,660,Color(9,13,20),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			for i=1,2 do
				draw.SimpleText("■",font,482+sel*23.5+(sel == 2 and 1 or 0),517+i*13,blue,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)			
			end]]
			if sel ~= 0 then
				draw.SimpleText("█",font,285+sel*30,299,blue,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			for i=1,3 do
				draw.SimpleText(Route[i],font,315+29.9*(i-1),300,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)			
			end
			Metrostroi.DrawRectOutline(275+math.max(1,sel)*30,286,21,29,white,1)		
			if CurTime()%1 < 0.35 then draw.SimpleText("|",font,278+math.max(1,sel)*30,299,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end						
		elseif state == 2 then
			local line = Train:GetNW2Int("BMCISLine",1)
			local station = Train:GetNW2Int("BMCISStation",1)
			local stationarr = Train:GetNW2Bool("BMCISStationArr")			
			local str = math.max(0,math.min(12,Train:GetNW2Int("BMCISStr",0)))
			local stbl
			if Metrostroi.ASNPSetup[Train:GetNW2Int("Announcer",1)] then
				stbl = Metrostroi.ASNPSetup[Train:GetNW2Int("Announcer",1)]
			end
			if Metrostroi.CISConfig[Train.CISConfig] then
				stbl = Metrostroi.CISConfig[Train.CISConfig]
			end
			local path = Train:GetNW2Bool("BMCISPath",false)			
			if reserve then
				if line >= 1 and stbl then
					local ann = stbl[line]			
					surface.SetDrawColor(Color(20,90,250))
					surface.DrawRect(33,267+str*23,624,24)		
					--draw.SimpleText("Линия:"..line.." Путь:"..(path and "2" or "1"),font,32,86,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
					for i=(ann.Loop and math.ceil(sel/2) or math.max(1,math.ceil(sel/2))),math.max(1,math.floor(sel/2))+8 do
						local a
						local ann2
						if ann.Loop then
							if i > #ann then a = i-#ann*math.floor(i/#ann-0.1) else a=i end
							local num = path and #ann-a+2 or a
							if num > #ann then num = num-#ann elseif num < 0 then num=num%#ann end
							if num == 0 then num = #ann end
							ann2 = stbl[line][num]
						else
							if not stbl[line][path and #ann-i+1 or i] then break end
							ann2 = stbl[line][path and #ann-i+1 or i]
						end
						if (i-sel/2)*48 > 148 then break end
						local pos1 = 255+(i-sel/2)*48-50
						local pos2 = 279+(i-sel/2)*48-50
						if pos1 > 270 and pos1 < 370 then
							draw.SimpleText(ann2[2],font,35,pos1,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
						end
						if pos2 > 270 and pos2 < 370 and (ann2 ~= stbl[line][path and 1 or #stbl[line]] or ann.Loop) then
							draw.SimpleText((ann2[2]).." отпр.",font,35,pos2,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
						end
					end	
				end
				if stbl then
					--draw.SimpleText("Линия:"..(line>=1 and (stbl[line].Loop and "Кольцевая" or line) or SpecialLines[line])..(line>=1 and (" Путь:"..(path and "2" or "1")) or ""),font,32,250,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
					draw.SimpleText("Линия:"..(line>=1 and (stbl[line].Loop and "Кольцевая" or stbl[line].Name:gsub("Линия ",""):gsub(" линия","")) or SpecialLines[line])..(line>=1 and (" Путь:"..(path and "2" or "1")) or ""),font,32,250,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				elseif line < 1 then
					draw.SimpleText("Линия:"..SpecialLines[line],font,32,250,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)					
				end				
				for i=1,8 do
					draw.SimpleText(Train:GetNW2String("BMCISWagN"..i,"-----"),font,i*70+30,436,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)										
				end
							
				if Train:GetNW2Bool("BMCISMicro",false) or Train:GetNW2Bool("BMCISConnection",false) then
					if Train:GetNW2Bool("BMCISMicroCabin",false) then
						draw.SimpleText("Межкабинная связь",font,35,472,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
					elseif Train:GetNW2Bool("BMCISConnection",false) then
						draw.SimpleText("Межкабинная связь(прием)",font,35,472,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)						
					else
						draw.SimpleText("Громкая связь в вагоне",font,35,472,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)												
					end
				elseif Train:GetNW2Bool("BMCISPlaying",false) then
					draw.SimpleText("Воспроизведение...",font,35,472,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)						
				elseif Train:GetNW2Bool("BMCISInitialize",false) then
					draw.SimpleText("Инициализация завершена",font,35,472,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)								
				end					
			else				
				surface.SetDrawColor(255,255,255)
				surface.SetTexture(bmcis2)
				surface.DrawTexturedRectRotated(537,522,1024,1024,0)	
				--surface.DrawTexturedRectRotated(536,523,1024,1024,0)--surface.DrawTexturedRectRotated(512,512,1024,1024,0)	
				
				if line >= 1 and stbl then
					local ann = stbl[line]			
					surface.SetDrawColor(Color(20,90,250))
					surface.DrawRect(33,43+str*24.5,624,24)		
					--draw.SimpleText("Линия:"..line.." Путь:"..(path and "2" or "1"),font,32,86,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
					for i=(ann.Loop and math.ceil(sel/2) or math.max(1,math.ceil(sel/2))),math.max(1,math.floor(sel/2))+8 do
						local a
						local ann2
						if ann.Loop then
							if i > #ann then a = i-#ann*math.floor(i/#ann-0.1) else a=i end
							local num = path and #ann-a+2 or a
							if num > #ann then num = num-#ann elseif num < 0 then num=num%#ann end
							if num == 0 then num = #ann end
							ann2 = stbl[line][num]
						else
							if not stbl[line][path and #ann-i+1 or i] then break end
							ann2 = stbl[line][path and #ann-i+1 or i]
						end
						if (i-sel/2)*48.8 > 368 then break end
						local pos1 = 33+(i-sel/2)*48.8-50
						local pos2 = 57+(i-sel/2)*48.8-50
						if pos1 > 35 and pos1 < 350 then
							draw.SimpleText(ann2[2],font,35,pos1,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
						end
						if pos2 > 35 and pos2 < 350 and (ann2 ~= stbl[line][path and 1 or #stbl[line]] or ann.Loop) then
							draw.SimpleText((ann2[2]).." отпр.",font,35,pos2,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
						end
					end	
				end
				if stbl then
					--draw.SimpleText("Линия:"..(line>=1 and (stbl[line].Loop and "Кольцевая" or line) or SpecialLines[line])..(line>=1 and (" Путь:"..(path and "2" or "1")) or ""),font,32,27,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
					draw.SimpleText("Линия:"..(line>=1 and (stbl[line].Loop and "Кольцевая" or stbl[line].Name:gsub("Линия ",""):gsub(" линия","")) or SpecialLines[line])..(line>=1 and (" Путь:"..(path and "2" or "1")) or ""),font,32,27,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				elseif line < 1 then
					draw.SimpleText("Линия:"..SpecialLines[line],font,32,27,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)					
				end
				--draw.SimpleText((line>=1 and ("Путь:"..(path and "2" or "1")) or ""),font,464,27,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)				
				for i=1,8 do
					draw.SimpleText(Train:GetNW2String("BMCISWagN"..i,"-----"),font,i*70+30,436,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)										
				end
				if Train:GetNW2Bool("BMCISMicro",false) or Train:GetNW2Bool("BMCISConnection",false) then
					if Train:GetNW2Bool("BMCISMicroCabin",false) then
						draw.SimpleText("Межкабинная связь",font,35,472,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)	
					elseif Train:GetNW2Bool("BMCISConnection",false) then
						draw.SimpleText("Межкабинная связь(прием)",font,35,472,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)							
					else
						draw.SimpleText("Громкая связь в вагоне",font,35,472,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)												
					end
				elseif Train:GetNW2Bool("BMCISPlaying",false) then
					draw.SimpleText("Воспроизведение...",font,35,472,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)								
				elseif Train:GetNW2Bool("BMCISInitialize",false) then
					draw.SimpleText("Инициализация завершена",font,35,472,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)								
				end		
			end
		elseif state == 3 then
			local NumLines = Train:GetNW2Int("NumLines",0)	
			local stbl
			if Metrostroi.ASNPSetup[Train:GetNW2Int("Announcer",1)] then
				stbl = Metrostroi.ASNPSetup[Train:GetNW2Int("Announcer",1)]
			end
			if Metrostroi.CISConfig[Train.CISConfig] then
				stbl = Metrostroi.CISConfig[Train.CISConfig]
			end
			if reserve then
				surface.SetDrawColor(Color(20,90,250))
				surface.DrawRect(33,240+sel*24,624,24)
				
				draw.SimpleText("Выбор линии",font,320,247,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)	

				for i=1,3 do
					draw.SimpleText("-"..SpecialLines[i-3].."-",font,35,250+i*24,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				end	
				for i=1,NumLines do
					if not stbl[i] then return end
					if stbl[i].Loop then
						draw.SimpleText("Кольцевая",font,35,322+24*i,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)						
					else
						draw.SimpleText(stbl[i].Name,font,35,322+24*i,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)	
					end
				end				
			else			
				surface.SetDrawColor(255,255,255)
				surface.SetTexture(bmcis2_add)
				surface.DrawTexturedRectRotated(537,522,1024,1024,0)--surface.DrawTexturedRectRotated(505,486,1024,994,0)	
				
				surface.SetDrawColor(Color(20,90,250))
				surface.DrawRect(33,19+sel*24,624,24)
				
				draw.SimpleText("Выбор линии",font,320,27,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)			
				
				for i=1,3 do
					draw.SimpleText("-"..SpecialLines[i-3].."-",font,35,31+24*i,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				end
				for i=1,NumLines do
					if not stbl[i] then return end
					if stbl[i].Loop then
						draw.SimpleText("Кольцевая",font,35,103+24*i,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)						
					else
						draw.SimpleText(stbl[i].Name,font,35,103+24*i,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)	
					end
				end
			end
		elseif state == 4 then
			if reserve then
				surface.SetDrawColor(Color(20,90,250))
				surface.DrawRect(33,240+sel*24,624,24)	
				
				draw.SimpleText("Предупредительные сообщения",font,320,247,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				
				for i=1,3 do
					draw.SimpleText(AttentionMessages[i],font,35,250+i*24,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				end			
			else
				surface.SetDrawColor(255,255,255)
				surface.SetTexture(bmcis2_add)
				surface.DrawTexturedRectRotated(537,522,1024,1024,0)--surface.DrawTexturedRectRotated(505,486,1024,994,0)	
				
				surface.SetDrawColor(Color(20,90,250))
				surface.DrawRect(33,19+sel*24,624,24)
				
				draw.SimpleText("Предупредительные сообщения",font,320,27,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				
				for i=1,3 do
					draw.SimpleText(AttentionMessages[i],font,35,31+i*24,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				end
			end
		elseif state == 5 then
			local numlasts = Train:GetNW2Int("BMCISLasts",0)
			local currlast = Train:GetNW2Int("BMCISLastStationEntered",0)
			if Train:GetNW2Int("BMCISLine",1) >= 1 then
				if reserve then
					if Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)] then
						surface.SetDrawColor(Color(20,90,250))
						surface.DrawRect(33,240+sel*24,624,24)	
					end
					
					draw.SimpleText("Ограничение маршрута",font,320,247,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					for i=2,numlasts-1 do
						draw.SimpleText("до ст. "..Train:GetNW2String("BMCISLast"..i,""),font,60,226+24*i,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)			
					end
					surface.SetDrawColor(2,2,2)
					surface.DrawRect(35,241+24*sel,20,20)	
					if currlast > 0 then
						surface.DrawRect(35,217+24*currlast,20,20)					
						Metrostroi.DrawLine(39,221+24*currlast,51,233+24*currlast,white,3)
						Metrostroi.DrawLine(39,233+24*currlast,51,221+24*currlast,white,3)		
					end			
				else
					surface.SetDrawColor(255,255,255)
					surface.SetTexture(bmcis2_add)
					surface.DrawTexturedRectRotated(537,522,1024,1024,0)--surface.DrawTexturedRectRotated(505,486,1024,994,0)	
					
					if Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)] then
						surface.SetDrawColor(Color(20,90,250))
						surface.DrawRect(33,19+sel*24,624,24)	
					end
					
					draw.SimpleText("Ограничение маршрута",font,320,27,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					for i=2,numlasts-1 do
						draw.SimpleText("до ст. "..Train:GetNW2String("BMCISLast"..i,""),font,60,7+24*i,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)			
					end
					surface.SetDrawColor(2,2,2)
					surface.DrawRect(35,22+24*sel,20,20)	
					if currlast > 0 then
						surface.DrawRect(35,-2+24*currlast,20,20)									
						Metrostroi.DrawLine(39,2+24*currlast,51,14+24*currlast,white,3)
						Metrostroi.DrawLine(39,14+24*currlast,51,2+24*currlast,white,3)		
					end
				end
			elseif reserve then
				draw.SimpleText("Ограничение маршрута",font,320,247,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			
			else			
				surface.SetDrawColor(255,255,255)
				surface.SetTexture(bmcis2_add)
				surface.DrawTexturedRectRotated(537,522,1024,1024,0)--surface.DrawTexturedRectRotated(505,486,1024,994,0)	

				draw.SimpleText("Ограничение маршрута",font,320,27,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)				
			end
		elseif state == 6 then
			if reserve then
				if Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)] then
					surface.SetDrawColor(Color(20,90,250))
					surface.DrawRect(33,240+sel*24,624,24)	
				end
					
				draw.SimpleText("Дополнительные сообщения",font,320,247,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				local maximum = (Metrostroi.TickerAdverts and math.min(7,#Metrostroi.TickerAdverts) or 0)
				local str2 = Train:GetNW2Int("BMCISStr2",0)
				for i=1,maximum do --(Metrostroi.TickerAdverts and #Metrostroi.TickerAdverts or 0) do
					if not Metrostroi.TickerAdverts[i+str2] then return end
					if utf8.len(Metrostroi.TickerAdverts[i+str2]) > 42 then
						draw.SimpleText((string.match(utf8sub(Metrostroi.TickerAdverts[i+str2],0,42),"^.* ") or utf8sub(Metrostroi.TickerAdverts[i+str2],0,42)).." ...",font,60,250+i*24,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)						
					else
						draw.SimpleText(Metrostroi.TickerAdverts[i+str2],font,60,250+i*24,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)	
					end	
					surface.SetDrawColor(2,2,2)
					surface.DrawRect(35,241+24*i,20,20)					
					if not Train:GetNW2Bool("BMCISTicker"..(i+str2),false) then									
						Metrostroi.DrawLine(39,245+24*i,51,257+24*i,white,3)
						Metrostroi.DrawLine(39,257+24*i,51,245+24*i,white,3)		
					end						
				end		
			else
				surface.SetDrawColor(255,255,255)
				surface.SetTexture(bmcis2_add)
				surface.DrawTexturedRectRotated(537,522,1024,1024,0)--surface.DrawTexturedRectRotated(505,486,1024,994,0)	
				
				if Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)] then
					surface.SetDrawColor(Color(20,90,250))
					surface.DrawRect(33,19+sel*24,624,24)	
				end
				
				draw.SimpleText("Дополнительные сообщения",font,320,27,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				
				for i=1,(Metrostroi.TickerAdverts and #Metrostroi.TickerAdverts or 0) do
					if not Metrostroi.TickerAdverts[i] then return end
					if utf8.len(Metrostroi.TickerAdverts[i]) > 42 then
						draw.SimpleText((string.match(utf8sub(Metrostroi.TickerAdverts[i],0,42),"^.* ") or utf8sub(Metrostroi.TickerAdverts[i],0,42)).." ...",font,60,31+24*i,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)						
					else
						draw.SimpleText(Metrostroi.TickerAdverts[i],font,60,31+24*i,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)	
					end		
					surface.SetDrawColor(2,2,2)
					surface.DrawRect(35,22+24*i,20,20)					
					if not Train:GetNW2Bool("BMCISTicker"..i,false) then									
						Metrostroi.DrawLine(39,26+24*i,51,38+24*i,white,3)
						Metrostroi.DrawLine(39,38+24*i,51,26+24*i,white,3)		
					end					
				end
			end
		elseif state == 7 then
			if reserve then
				surface.SetDrawColor(Color(20,90,250))
				surface.DrawRect(33,240+sel*24,624,24)	

				draw.SimpleText("Сервисное меню",font,320,247,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				
				for i=1,6 do
					draw.SimpleText(ServiceMenu[i],font,35,250+i*24,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)				
				end
			else
				surface.SetDrawColor(255,255,255)
				surface.SetTexture(bmcis2_add)
				surface.DrawTexturedRectRotated(537,522,1024,1024,0)--surface.DrawTexturedRectRotated(505,486,1024,994,0)	
				
				surface.SetDrawColor(Color(20,90,250))
				surface.DrawRect(33,19+sel*24,624,24)	

				draw.SimpleText("Сервисное меню",font,320,27,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				
				for i=1,6 do
					draw.SimpleText(ServiceMenu[i],font,35,31+i*24,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)				
				end
			end 
		elseif state == 8 then
			if reserve then
				surface.SetDrawColor(Color(20,90,250))
				surface.DrawRect(33,240+sel*24,624,24)	

				draw.SimpleText("Экстренные сообщения",font,320,247,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				
				for i=1,2 do
					draw.SimpleText(ExtraMenu[i],font,35,250+i*24,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)				
				end			
			else
				surface.SetDrawColor(255,255,255)
				surface.SetTexture(bmcis2_add)
				surface.DrawTexturedRectRotated(537,522,1024,1024,0)--surface.DrawTexturedRectRotated(505,486,1024,994,0)	
				
				surface.SetDrawColor(Color(20,90,250))
				surface.DrawRect(33,19+sel*24,624,24)	

				draw.SimpleText("Экстренные сообщения",font,320,27,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				
				for i=1,2 do
					draw.SimpleText(ExtraMenu[i],font,35,31+i*24,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)				
				end
			end 	
			if Train:GetNW2Bool("BMCISExtra",false) then
				surface.SetDrawColor(Color(117,119,140))
				surface.DrawRect(100,200,500,100)
					
				draw.SimpleText("Воспроизведение экстренного сообщения",font,350,235,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("<Esc> - прервать",font,350,263,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)		
			end			
		end
		if state >=1 then
			draw.SimpleText(date,font,604,472,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)						
		end		
		if Train:GetNW2Bool("Merc",false) then
			surface.SetDrawColor(255,255,255)
			surface.DrawRect(0,0,800,600)
		end
	end
    net.Receive("metrostroi_cis_announcer", function(len, pl)
        local train = net.ReadEntity()
        if not IsValid(train) or not train.RenderClientEnts then return end
        local snd = net.ReadString()

		local v = train.AnnouncerPositions[1]
		train:PlayOnceFromPos("announcer1", snd, v[3] or 1, 1, v[2] or 400, 1e9, v[1])
    end)	
end


