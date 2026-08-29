--------------------------------------------------------------------------------
-- Announcer and announcer-related code
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_760_ASNP")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.TriggerNames = {
        "R_ASNPMenu",
        "R_ASNPUp",
        "R_ASNPDown",
        "R_ASNPOn",
        "R_Program1",
        "R_Program2",
        --R_Announcer
        --R_Line
    }
    self.Triggers = {}
    for k,v in pairs(self.TriggerNames) do
        self.Triggers[v] = false
    end
	
    self.State = 0

    self.Line = 1
    self.Path = false
    self.Station = 1
    self.Arrived = true
	self.Selected = 0
	
    self.RouteNumber = 0

    self.Line = 1

    self.Train:LoadSystem("R_ASNPOn","Relay","Switch",{ normally_closed = true, bass = true })
    self.Train:LoadSystem("R_ASNPMenu","Relay","Switch",{bass = true })
    self.Train:LoadSystem("R_ASNPUp","Relay","Switch",{bass = true })
    self.Train:LoadSystem("R_ASNPDown","Relay","Switch",{bass = true })
	
	
	self.Timer = CurTime()
	self.Init = false	
end

if TURBOSTROI then return end
function TRAIN_SYSTEM:ClientInitialize()
end
if TURBOSTROI then return end

function TRAIN_SYSTEM:Inputs()
    return {}
end

function TRAIN_SYSTEM:Outputs()
    return {}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end
if CLIENT then
    local function createFont(name,font,size)
        surface.CreateFont("Metrostroi_760_"..name, {
            font = font,
            size = size,
            weight = 500,
            blursize = false,
            antialias = true,
            underline = false,
            italic = false,
            strikeout = false,
            symbol = false,
            rotary = false,
            shadow = false,
            additive = false,
            outline = false,
            extended = true,
            scanlines = false,
        })
    end
    createFont("ASNP","Liquid Crystal Display",30,400)
    function TRAIN_SYSTEM:ClientThink()
		if not self.Train:ShouldDrawPanel("ASNPScreen") then return end
        if not self.DrawTimer then
        render.PushRenderTarget(self.Train.ASNP,0,0,512, 128)
            render.Clear(0, 0, 0, 0)
            render.PopRenderTarget()
        end
        if self.DrawTimer and CurTime()-self.DrawTimer < 0.1 then return end
        self.DrawTimer = CurTime()
        if self.Train:GetNW2Int("ASNP:State",-1) == 0 then
	        render.PushRenderTarget(self.Train.ASNP,0,0,512, 128)
            render.Clear(0, 0, 0, 0)
            render.PopRenderTarget()	
            return
        end		
        render.PushRenderTarget(self.Train.ASNP,0,0,512, 128)
	
        --render.Clear(0, 0, 0, 0)
        cam.Start2D()
            self:ASNPScreen(self.Train)
        cam.End2D()
        render.PopRenderTarget()      
    end
	local symb = {
		["а"] = 'А',["б"] = 'Б',["в"] = 'В',["г"] = 'Г',["д"] = 'Д',["е"] = 'Е',["ё"] = 'Ё',["ж"] = 'Ж',["з"] = 'З',["и"] = 'И',["й"] = "Й",
		["к"] = "К",["л"] = "Л",["м"] = 'М',["н"] = 'Н',["о"] = 'О',["п"] = 'П',["р"] = 'Р',["с"] = 'С',["т"] = 'Т',["у"] = 'У',["ф"] = 'Ф',
		["х"] = 'Х',["ц"] = 'Ц',["ч"] = 'Ч',["ш"] = 'Ш',["щ"] = 'Щ',["ъ"] = 'Ъ',["ы"] = 'Ы',["ь"] = 'Ь',["э"] = 'Э',["ю"] = 'Ю',["я"] = 'Я',
		
		["a"] = "A",["b"] = "B",["c"] = "C",["d"] = "D",["e"] = "E",["f"] = "F",["g"] = "G",["h"] = "H",["i"] = "I",["j"] = "J",["k"] = "K",["l"] = "L",["m"] = "M",
		["n"] = "N",["o"] = "O",["p"] = "P",["q"] = "Q",["r"] = "R",["s"] = "S",["t"] = "T",["u"] = "U",["v"] = "V",["w"] = "W",["x"] = "X",["y"] = "Y",["z"] = "Z", 
	}	
    function TRAIN_SYSTEM:PrintText(x,y,text,inverse,align,station)
        local str = {utf8.codepoint(text,1,-1)}
		if align == "right" and str then x = x-#str end		
        for i=1,#str do
            local char = utf8.char(str[i])
            if inverse then
                draw.SimpleText(string.char(0x7f),"Metrostroi_760_ASNP",(x+i)*20.5+5,y*40+40,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText(char,"Metrostroi_760_ASNP",(x+i)*20.5+5,y*40+40,Color(140,190,0,150),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            else
				if char == "I" and text:find("II") and self.Train:GetNW2Int("ASNP:State",-1) == 6 then
					draw.SimpleText("I","Metrostroi_760_ASNP",(x+i)*20.5-1,y*40+40,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					draw.SimpleText("I","Metrostroi_760_ASNP",(x+i)*20.5+11,y*40+40,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					break
				else
					draw.SimpleText(station and symb[char] or char,"Metrostroi_760_ASNP",(x+i)*20.5+5,y*40+40,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				end
            end
        end
    end

    TRAIN_SYSTEM.LoadSeq = "/-\\|"
    function TRAIN_SYSTEM:ASNPScreen(Train)
        local State = self.Train:GetNW2Int("ASNP:State",-1)	
        if State ~= 0 then
            surface.SetDrawColor(140,190,0,self.Warm and 130 or 255)
            self.Warm = true
        else
            surface.SetDrawColor(20,50,0,230)
            self.Warm = false
        end		
        surface.DrawRect(0,17,512,94)
        if State == 0 then
            return
        end	

        if State == -2 then
            self:PrintText(0,0,"Ошибка памяти")
            self:PrintText(0,1,"Карта не поддерживается")
            return
        end
		
        if State == -1 then
            --self:PrintText(0,0,"Нажмите \"MENU\"")
            --self:PrintText(0 ,1,"для начала настройки")
			self:PrintText(0,0,"ПНМ6 .760 ваг.N "..tostring(Train.WagonNumber):sub(2,5))
			self:PrintText(0,1," ver.N.04 IR_PR 2019г.")
        end		
        if State > 1 and not Metrostroi.ASNPSetup then
            self:PrintText(0,0,"Client error")
            self:PrintText(0,1,"ASNPSetup nil")
            return
        end
        local stbl = Metrostroi.ASNPSetup and Metrostroi.ASNPSetup[Train:GetNW2Int("Announcer",1)]
        if State > 2 and not stbl then
            self:PrintText(0,0,"Client error")
            self:PrintText(0,1,"ASNPSetup[ann] nil")
            return
        end
        if State == 2 then
            local sel = Train:GetNW2Int("ASNP:Selected",0)
			local path = Train:GetNW2Bool("ASNP:Path",false)
            self:PrintText(0,0,"Выбор направления -")
			self:PrintText(2,1,"ПУТЬ "..string.rep("I",path and 2 or 1))
        elseif State == 3 then
            local RouteNumber = Format("%02d",Train:GetNW2Int("ASNP:RouteNumber",0))
            local sel = Train:GetNW2Int("ASNP:Selected",0)
            self:PrintText(0,0,"Выбор N маршрута")
			if RouteNumber[1] ~= "0" then
				self:PrintText(0,1,RouteNumber[1])--,sel==0 and  RealTime()%1 > 0.5)
			end
            self:PrintText(1,1,RouteNumber[2])--,sel==1 and  RealTime()%1 > 0.5)
        elseif State == 4 then
            local sel = Train:GetNW2Int("ASNP:Selected",0)
            local Line = Train:GetNW2Int("ASNP:Line",1)
			local path = Train:GetNW2Bool("ASNP:Path",false)

            local ltbl = stbl[Line]
			local curr = ltbl[sel][2]
			local find = false
			for i=1,#stbl do
				local l = stbl[i]
				for k = 1,#l do
					if l[k][2] == curr and i ~= Line then
						find = true
					end
				end
			end
			
			self:PrintText(0,0,"Текущая станция  -")			
			self:PrintText(0,1,curr..(find and (" ("..Line..")") or ""),false,false,true)
		elseif State == 5 then
            local sel = Train:GetNW2Int("ASNP:Selected",0)
            local Line = Train:GetNW2Int("ASNP:Line",1)
			local station = Train:GetNW2Int("ASNP:Station",1)
			local path = Train:GetNW2Bool("ASNP:Path",false)			
            local ltbl = stbl[Line]
			local curr = ltbl[sel]
			if not self.tbllasts or Line ~= self.PrevLine or path ~= self.PrevPath or station ~= self.PrevStation then
				self.tbllasts = {}
				if ltbl.Loop then
					table.insert(self.tbllasts,"Кольцевой")
				end					
				if path then
					for i=1,math.min(station,#ltbl-1) do
						if ltbl[i].arrlast then
							table.insert(self.tbllasts,ltbl[i])
						end
					end 			
				else
					for i=math.max(2,station),#ltbl do
						if ltbl[i].arrlast then
							table.insert(self.tbllasts,ltbl[i])
						end
					end 				
				end			
				self.PrevLine = Line
				self.PrevPath = path
				self.PrevStation = station
			end
			
			self:PrintText(0,0,"Выбор ст. оборота -")
			--if sel == # and ltbl.Loop then
				--self:PrintText(0,1,"Кольцевой")
			--else
			self:PrintText(0,1,istable(self.tbllasts[sel]) and self.tbllasts[sel][2] or self.tbllasts[sel],false,false,true)
			--end
			--self:PrintText(0,1,if sel == 1 and ltbl.Loop and "Кольцевой" or self.tbllasts[sel][2])
		elseif State == 6 then
			local path = Train:GetNW2Bool("ASNP:Path",false)	
            local RouteNumber = Format("%02d",Train:GetNW2Int("ASNP:RouteNumber",0))
            local Line = Train:GetNW2Int("ASNP:Line",1)
			local station = Train:GetNW2Int("ASNP:Station",1)
            local ltbl = stbl[Line]			
			local last = Train:GetNW2Int("ASNP:LastStation",1)
			if Train:GetNW2Bool("STL",false) then
				self:PrintText(0,0,"Приб.")
			end
			self:PrintText(0,1,path and "II" or "I")
			if Train:GetNW2Bool("ASNP:IKPORT",false) then
				self:PrintText(5,0,"$")				
			elseif Train:GetNW2Bool("ASNP:StationArr",false) then
				self:PrintText(5,0,"+")
			end
			if RouteNumber[1] ~= "0" then
				self:PrintText(2,1,RouteNumber[1])--,sel==0 and  RealTime()%1 > 0.5)
			end
			self:PrintText(3,1,RouteNumber[2])
			self:PrintText(7,0,ltbl[station][2],false,false,true)
			if last == -1 then
				self:PrintText(7,1,"КОЛЬЦЕВОЙ")			
			else
				self:PrintText(7,1,ltbl[last][2],false,false,true)
			end
		end
    end
    return
end
function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
    if sourceid == self.Train:GetWagonNumber() then return end
    if textdata == "RouteNumber" then self.RouteNumber = numdata end
    if textdata == "Path" then self.Path = numdata > 0 end
    if textdata == "Line" then self.Line = numdata end
    if textdata == "Station" then self.Station = numdata end
    if textdata == "LastStation" then self.LastStation = numdata end
    if textdata == "Activate" then
        local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
        --self.Station = tbl.Loop and 1 or self.Station
		self.Init = true
        self.State = 6
    end
end
function TRAIN_SYSTEM:SyncASNP(special)
	local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
    self.Train:CANWrite("ASNP",self.Train:GetWagonNumber(),"ASNP",nil,"RouteNumber",self.RouteNumber)
	if not special then
		self.Train:CANWrite("ASNP",self.Train:GetWagonNumber(),"ASNP",nil,"Path",self.Path and 0 or 1)
	end
    self.Train:CANWrite("ASNP",self.Train:GetWagonNumber(),"ASNP",nil,"Line",self.Line)
    self.Train:CANWrite("ASNP",self.Train:GetWagonNumber(),"ASNP",nil,"Station",self.LastStation == -1 and self.Station or self.Path and 1 or self.LastStation)
    self.Train:CANWrite("ASNP",self.Train:GetWagonNumber(),"ASNP",nil,"LastStation",self.LastStation == -1 and -1 or self.Path and #tbl or 1)
    self.Train:CANWrite("ASNP",self.Train:GetWagonNumber(),"ASNP",nil,"Activate")
end

function TRAIN_SYSTEM:Trigger(name,value)
    local stbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)]
	if not stbl then return end
	local ltbl = stbl[self.Line]
	if not ltbl then return end
	if self.State >= 1 then
		if name == "R_ASNPUp" and value then
			self.UpTimer = CurTime()
		end
		if name == "R_ASNPUp" and not value then
			self.UpTimer = nil
			self.Up = false
		end	
		if name == "R_ASNPDown" and value then
			self.DownTimer = CurTime()
		end
		if name == "R_ASNPDown" and not value then
			self.DownTimer = nil
			self.Down = false
		end	
	end
	if self.State == 1 and value then
		if name == "R_ASNPMenu" then
			self.Selected = 0
			self.State = 2
			self.ReturnTimer = CurTime()
		end
	elseif self.State == 2 and value then	
		if name == "R_ASNPMenu" then
			self.State = 3
			self.ReturnTimer = CurTime()		
		end		
		if (name == "Up1" or name == "Down1") then
			self.Path = not self.Path
			self.ReturnTimer = CurTime()		
		end
	elseif self.State == 3 and value then
		if name == "R_ASNPMenu" then
			--self.Line = 1
			self.Selected = self.Station		
			self.State = 4
			self.ReturnTimer = CurTime()
		end
		if name == "Up1" then
			self.RouteNumber = self.RouteNumber == 99 and 0 or self.RouteNumber + 1
			self.ReturnTimer = CurTime()
		end
		if name == "Down1" then
			self.RouteNumber = self.RouteNumber == 0 and 99 or self.RouteNumber - 1
			self.ReturnTimer = CurTime()
		end		
	elseif self.State == 4 and value then	
		if name == "Down1" then
			if ltbl[self.Selected+1] then
				self.Selected = self.Selected + 1
			else
				if self.Line ~= math.min(#stbl,self.Line+1) then
					self.Selected = 1
				end
				self.Line = math.min(#stbl,self.Line+1)
			end
			self.ReturnTimer = CurTime()
		end
		if name == "Up1" then
			if self.Selected ~= 1 then
				self.Selected = math.max(1,self.Selected - 1)
			else
				local change = self.Line ~= math.max(1,self.Line-1)
				self.Line = math.max(1,self.Line-1)
				if change then
					self.Selected = #stbl[self.Line]
				end
			end
			self.ReturnTimer = CurTime()
		end
		if name == "R_ASNPMenu" then
			self.Station = self.Selected
			self.Selected = self.LastStationSelected or 1
			self.State = 5
			self.ReturnTimer = CurTime()
		end
	elseif self.State == 5 and value then
		local tbl = {}
		if ltbl.Loop then
			table.insert(tbl,"Кольцевой")
		end		
		if self.Path then
			for i=1,math.min(self.Station,#ltbl-1) do
				if ltbl[i].arrlast then
					table.insert(tbl,{ltbl[i],i})
				end
			end 			
		else
			for i=math.max(2,self.Station),#ltbl do
				if ltbl[i].arrlast then
					table.insert(tbl,{ltbl[i],i})
				end
			end 				
		end	

		if name == "Up1" then
			self.Selected = math.max(1,self.Selected - 1)
			self.ReturnTimer = CurTime()
		end
		if name == "Down1" then
			self.Selected = math.min(#tbl,self.Selected + 1)
			self.ReturnTimer = CurTime()
		end
		if name == "R_ASNPMenu" then
			self.LastStation = isstring(tbl[self.Selected]) and -1 or tbl[self.Selected][2]
			--self.LastStationSelected = self.Selected
			self.Init = true			
			self:SyncASNP()
			self.State = 6
			self.ReturnTimer = nil
		end
	elseif self.State == 6 and value then	
		if name == "Up1" then
			if self.LastStation == -1 then--кольцевой
				self.Station = self.Path and (self.Station == #ltbl and 1 or self.Station+1) or (self.Station == 1 and #ltbl or self.Station-1)
			else
				self.Station = self.Path and math.min(#ltbl,self.Station+1) or math.max(1,self.Station-1)
			end
		end
		if name == "Down1" then
			if self.LastStation == -1 then--кольцевой
				self.Station = self.Path and (self.Station == 1 and #ltbl or self.Station-1) or (self.Station == #ltbl and 1 or self.Station+1)	
			else
				self.Station = self.Path and math.max(self.LastStation,self.Station-1) or math.min(self.LastStation,self.Station+1)
			end
		end
		if name == "R_ASNPMenu" then
			self.State = 2
			self.ReturnTimer = CurTime()
		end
	end
end

function TRAIN_SYSTEM:Think()
    local Train = self.Train
    local Power = Train.Electric.Battery80V > 62
    local ASNPWork = Power and Train.R_ASNPOn.Value*Train.SF18.Value > 0.5
    if not ASNPWork and self.State ~= 0 then
        self.State = 0
        self.ASNPTimer = nil
    end
    if ASNPWork and self.State == 0 then
        self.State = -1
        self.ASNPTimer = CurTime()+math.Rand(6,8)--CurTime()-math.Rand(-0.3,0.3)
    end
    if self.State == -1 and self.ASNPTimer and CurTime()-self.ASNPTimer > 1 then
        self.State = Metrostroi.ASNPSetup[Train:GetNW2Int("Announcer",1)] and 1 or -2
    end

    if ASNPWork and self.State > -1  then
        for k,v in pairs(self.TriggerNames) do
            if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
                self:Trigger(v,Train[v].Value > 0.5)
                self.Triggers[v] = Train[v].Value > 0.5
            end
        end
    end
	if ASNPWork and self.State > 1 and self.State ~= 6 and self.ReturnTimer and CurTime()-self.ReturnTimer > 10 then
		for i=1,6-self.State do
			self:Trigger("R_ASNPMenu",true)
		end
		--self.State = 6
	end
	if self.Init and self.State == 1 then
		self.State = 6
	end
	if not self.Init and self.State == 1 and Metrostroi.ASNPSetup[Train:GetNW2Int("Announcer",1)] then
		local ltbl = Metrostroi.ASNPSetup[Train:GetNW2Int("Announcer",1)][self.Line]
		for i=1,(ltbl.Loop and 5 or 4) do
			self:Trigger("R_ASNPMenu",true)
			if i == 4 and not ltbl.Loop then
				local tbl = {}	
				if self.Path then
					for i=1,math.min(self.Station,#ltbl-1) do
						if ltbl[i].arrlast then
							table.insert(tbl,{ltbl[i],i})
						end
					end 			
				else
					for i=math.max(2,self.Station),#ltbl do
						if ltbl[i].arrlast then
							table.insert(tbl,{ltbl[i],i})
						end
					end 				
				end				
				self.LastStation = tbl[#tbl][2]	
				self:SyncASNP(true)
				self.State = 6
			end
		end
		self.Init = true
	end
    if (not Metrostroi.ASNPSetup or not Metrostroi.ASNPSetup[Train:GetNW2Int("Announcer",1)]) and self.State > 0 then
        self.State = -2
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
	
    Train:SetNW2Int("ASNP:State",self.State)
    Train:SetNW2Int("ASNP:RouteNumber",self.RouteNumber)
	Train:SetNW2Bool("ASNP:Path",self.Path)
	Train:SetNW2Int("ASNP:Station",self.Station)
	Train:SetNW2Int("ASNP:LastStation",self.LastStation)
	
    Train:SetNW2Int("ASNP:Selected",self.Selected)
    Train:SetNW2Int("ASNP:Line",self.Line)

    --Train:SetNW2Bool("ASNP:Playing",#Train.Announcer.Schedule>0)
	
	if self.State == 6 then
		local path = Train:ReadCell(49170)
		local station = Train:ReadCell(49169)		
		local stbl
		if station ~= 0 and path ~= 0 then
			stbl = Metrostroi.Stations[station][path]
			local ltbl = Metrostroi.ASNPSetup[Train:GetNW2Int("Announcer",1)][self.Line]
			--local x = Metrostroi.GetPositionOnTrack(Train:GetPos(),Train:GetAngles())[1] and Metrostroi.GetPositionOnTrack(Train:GetPos(),Train:GetAngles())[1].x or nil
			local dist = Train:ReadCell(49165)-6.5
			if not dist or Train:ReadCell(49165) == 0 then return end
			--print(station,path)
			local find,find2 = false,false
			if dist < 40 then
				if CurTime()-self.Timer > 0 then
					self.Timer = CurTime()+math.Rand(2.5,3)		
				end
				if CurTime()-self.Timer > -1 and CurTime()-self.Timer < 0 then
					local st = 0
					for i=1,#ltbl do
						local Map = game.GetMap() or ""
						if ltbl[i][1] == station or (Map:find("gm_metro_crossline_c") and ltbl[i][1] == station-799) then
							st=i
							break
						end
					end
					if st == 0 then return end	
					if (self.Path and st >= self.LastStation or not self.Path and st <= self.LastStation) or self.LastStation == -1 then
						if self.Station ~= st then
							self.Station = st			
						end
					end		
					find = true								
				end
				--find = (st ~= 0)
			end
			find2 = math.abs(dist) < 9 and (CurTime()%2 < 0.2 or CurTime()%2 > 1.8)--IKPORT
			if find2 then
				if path ~= 0 and self.Path ~= (path == 2) then
					self.Path = (path == 2)
				end
				local st = 0
				local Map = game.GetMap() or ""
				for i=1,#ltbl do
					if ltbl[i][1] == station or (Map:find("gm_metro_crossline_c") and ltbl[i][1] == station-799) then
						st=i
						break
					end	
				end
				if st == 0 then return end					
				if (self.Path and st >= self.LastStation or not self.Path and st <= self.LastStation) or self.LastStation == -1 then
					if self.Station ~= st then
						self.Station = st			
					end
					find = true			
				end						
			end
			Train:SetNW2Bool("ASNP:StationArr",find)
			Train:SetNW2Bool("ASNP:IKPORT",find2)			
		end
	end
end
