---------------------------------------------------------------------------------------------------------------
--  Automatic System Fire Signalization for 81-717.5P train
--  Автоматическая Система Пожарной Сигнализации для состава 81-717.5П
--  Made by Ven, 2020-2021 (Discord: Вэн#2254)
---------------------------------------------------------------------------------------------------------------
--  TODO:
--  Сделать логирование ошибок (Исправленные ошибки переходят из ТЕКущих ушибок в ПАМять)

Metrostroi.DefineSystem("81_717_5P_ASPS")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	--self.Train:LoadSystem("ASPS_Restartk","Relay","Switch",{bass = true})
	self.Train:LoadSystem("ASPS_Restart","Relay","Switch",{bass = true})
	self.Train:LoadSystem("ASPS_View","Relay","Switch",{bass = true})
	self.Train:LoadSystem("ASPS_Esc","Relay","Switch",{bass = true})
    self.TriggerNames = {
		"ASPS_Restart",
		"ASPS_View",
		"ASPS_Esc"
    }
    self.Triggers = {}
	for k,v in pairs(self.TriggerNames) do
		self.Triggers[v] = false
	end
	
	self.State = 0
	self.Initialized = false
	
	self.Wagons = {}
	
	self.ASPSLamps = {
		["AO_Ready"] = false,
		["AO_Fire"] = false,
		
		["Ready"] = false,
		["Error"] = false,
		
		["PI"] = false,
		["OSP"] = false,
		["HVOff"] = false,
	}
end

function TRAIN_SYSTEM:Outputs()
    return {"ASPSLamps"}
end

function TRAIN_SYSTEM:Inputs()
    return {}
end
if TURBOSTROI then return end

TRAIN_SYSTEM.Errors = {
	"Отказ пульта",
	"Отказ блока контроля",
	"Отказа пожарного извещателя",
	"Отказ блока соединтельного",
	"Срабатывание ОСП",
	"Отключение вагонных цепей",
	"Выключение звукового\nсигнала",
	"Перезапуск  АСПС",
	"Превышение порогового\nзначения температуры",
	"НЕТ СВЯЗИ"
}
--[[
	-5 = Рестарт АСПС
	-3 = Горят все лампочки 
	-2 = Инициализация
	-1 = Ошибка, если не инициализирован блок
	 0 = Нет питания
	 1 = Основной режим
	 2 = Просмотр журнала
]]
function TRAIN_SYSTEM:TriggerInput(name,value)
end
if SERVER then
	function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
		if sourceid == self.Train:GetWagonNumber() then return end
		if textdata == "Slave" then
			self.Train:SetNW2Bool("ASPS:Master",false)
		end
		if textdata == "Init" then
			self.State = 1
			for i=1,#self.Train.WagonList do
				self.Wagons[i] = self.Train.WagonList[i]:GetWagonNumber()
			end
			self.Initialized = true
			self.Train:SetPackedBool("ASPS:Ring",false)
		end
		if textdata == "Check" then
			self:CANWrite("Answer")
		end
		if textdata == "Answer" then
			if not self.BackASPS then
				self.BackASPS = {
					id=sourceid,
					LastAnswer = CurTime(),
					state = numdata
				}
			elseif self.BackASPS.id ~= sourceid then
				self.BackASPS = nil
				self.CANIgnore = CurTime()
			else
				self.BackASPS.LastAnswer = CurTime()
			end
		end
    end
	function TRAIN_SYSTEM:SyncASPS()
		self.Train:CANWrite("ASPS",self.Train:GetWagonNumber(),"ASPS",nil,"Slave")
		self.Train:CANWrite("ASPS",self.Train:GetWagonNumber(),"ASPS",nil,"Init")
	end
	function TRAIN_SYSTEM:Trigger(name,value)
		local Train = self.Train
		local Power = Train.VB.Value>0
		if self.State == -1 then
			if name == "ASPS_View" and value then
				Train:SetPackedBool("ASPS:Ring",false)
				self.State = -11
				self.LoadingTimer = CurTime()
				Train:SetNW2Bool("ASPS:Master",true)
			end
			if name == "ASPS_Esc" and value then
				Train:SetPackedBool("ASPS:Ring",false)
				self.State = 1
				self.LoadingTimer = nil
				Train:SetNW2Bool("ASPS:Master",true)
				self:SyncASPS()
			end
		end
		if self.State > -3 then
			if name == "ASPS_Restart" then
				if value then
					self.RestartTimer = CurTime()
				else
					if CurTime() - self.RestartTimer > 2 then
						self.State = -5
						self.RestartTimer = nil
					else
						self.RestartTimer = nil
					end
				end
			end
		end
		if self.State == 1 then
			if name == "ASPS_View" and value then
				self.State = 2
			end
		end
		if self.State == 2 then
			if name == "ASPS_Esc" and value then
				self.State = 1
			end
		end
	end
	function TRAIN_SYSTEM:CANWrite(name,value,number)
		if self.State < 1 then return end
		if self.CANIgnore and CurTime()-self.CANIgnore < 1 then return end
		local source = self.Train:GetWagonNumber()
		self.Train:CANWrite("ASPS",source,"ASPS",number,name,value)
	end
	function TRAIN_SYSTEM:Think(dT)
		local Train = self.Train
		local Power = Train.VB.Value > 0 and Train.A76.Value > 0
		
		-------------------------------------------------------------LOADING
		if not Power and self.State ~= 0 then
			self.State = 0
			self.Error = 0
			self.BackCheckTimer = nil
			self.LoadingTimer = nil
			for k,v in pairs(self.ASPSLamps) do
				self.ASPSLamps[k] = false
			end
			Train:SetPackedBool("ASPS:Ring",false)
		end
		if Power and self.State == 0 then
			self.LoadingTimer = CurTime()
			self.State = -3
		end
		if self.State == -3 and CurTime() - self.LoadingTimer > 2.4 then
			for k,v in pairs(self.ASPSLamps) do
				self.ASPSLamps[k] = false
			end
			self.State = -2
			self.LoadingTimer = CurTime()
		end
		--------------------------------------------------------------
		
		--------------------------------------------------------------THINK
		if self.State == -5 then --Перезагрузка АСПС
			if not self.RestartTimer then self.RestartTimer = CurTime() end
			if CurTime() - self.RestartTimer > 4 then
				self.RestartTimer = nil
				self.State = 0
			end
		end
		
		if self.State == -3 then
			Train:SetPackedBool("ASPS:Ring",CurTime() - self.LoadingTimer < 0.5)
			for k,v in pairs(self.ASPSLamps) do self.ASPSLamps[k] = true end
		end
		
		if self.State == -2 then --Чекаем вагоны
			for i=1,#Train.WagonList do
				if self.Wagons[i] ~= Train.WagonList[i]:GetWagonNumber() then self.Initialized = false end
			end
			if CurTime() - self.LoadingTimer > 20 then
				if not self.Initialized then
					self.State = -1
					Train:SetPackedBool("ASPS:Ring",CurTime()%1 > 0.5)
				else
					self.State = 1
					self.LoadingTimer = nil
				end
			end
		end
		
		if self.State == -11 then --Инициализация вагонов
			self.Wagons = {}
			for i=1,#Train.WagonList do
				self.Wagons[i] = Train.WagonList[i]:GetWagonNumber()
			end
			if CurTime() - self.LoadingTimer > 8 then
				self.State = 1
				self.LoadingTimer = nil
				self.Initialized = true
				self:SyncASPS()
			end
		end
		
		if self.State == 1 then
			if not self.ASPSLamps.Ready then self.ASPSLamps.Ready = true end
		end
		
		--Связь с задним АСПС
		if (not self.BackCheckTimer or CurTime()-self.BackCheckTimer > 1) then
            self:CANWrite("Check")
            self.BackCheckTimer = CurTime()
        end
        if self.BackASPS and CurTime()-self.BackASPS.LastAnswer > 2 then
            self.BackASPS = nil
        end
		
		--Ошибки
		if self.BackASPS == nil then
			self.Error = 10
		else
			self.Error = 0
		end
		
		if self.State > -3 then
			self.ASPSLamps.Error = (self.Error > 0 or not self.Initialized) and Power
		end
		
		for k,v in pairs(self.TriggerNames) do
			if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
				self:Trigger(v,Train[v].Value > 0.5)
				self.Triggers[v] = Train[v].Value > 0.5
			end
		end
		
		Train:SetNW2Int("ASPS:State",self.State)
		Train:SetNW2Int("ASPS:Error",self.Error)
	end
else
    local function createFont(name,font,size,weight,blur,scanlines,underline)
        surface.CreateFont("Metrostroi_"..name, {
            font = font,
            size = size,
            weight = weight or 400,
            blursize = false,
            antialias = true,
            underline = underline,
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
	createFont("ASPS","Liquid Crystal Display",34,400,0,0,false)
	function TRAIN_SYSTEM:PrintText(x,y,text)
		local str = {utf8.codepoint(text,1,-1)}
        for i=1,#str < 17 and #str or 16 do
            local char = utf8.char(str[i])
            draw.SimpleText(char,"Metrostroi_ASPS",8+(x+i)*25,30+y*44,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
    end
    function TRAIN_SYSTEM:ClientThink()
		if not self.Train:ShouldDrawPanel("ASPSScreen") then return end
        if not self.DrawTimer and self.Train:GetNW2Int("ASPS:State",0) ~= 0 then
            render.PushRenderTarget(self.Train.ASPSScr,0,0,512, 128)
            render.Clear(0, 0, 0, 0)
            render.PopRenderTarget()
        end
        if self.DrawTimer and CurTime()-self.DrawTimer < 0.1 then return end
		
		if self.Train:GetNW2Int("ASPS:State",0) == 0 or self.Train:GetNW2Int("ASPS:State",0) == -3 then
			render.PushRenderTarget(self.Train.ASPSScr,0,0,512, 128)
            render.Clear(0, 0, 0, 0)
            render.PopRenderTarget()
		end
		
        self.DrawTimer = CurTime()
        render.PushRenderTarget(self.Train.ASPSScr,0,0,512, 128)
        --render.Clear(0, 0, 0, 0)
        cam.Start2D()
			self:ASPSScreen(self.Train)
        cam.End2D()
        render.PopRenderTarget()
    end
	function TRAIN_SYSTEM:ASPSScreen(Train)
		local state = Train:GetNW2Int("ASPS:State",-1)
		if state == 0 or state == -3 then
            return
        end
		if state ~= 0 then
            surface.SetDrawColor(140,190,0,self.Warm and 130 or 255)
            self.Warm = true
        else
            self.Warm = false
        end		
        surface.DrawRect(0,0,440,106)
		
		surface.SetDrawColor(110,150,0,100)
		for i=0,15 do
			surface.DrawRect(23+i*25,16,21,31)
			surface.DrawRect(23+i*25,60,21,31)
		end
        if state == -5 then
			self:PrintText(0,0,self.Errors[8])
		elseif state == -1 then
			self:PrintText(2,0,"НЕСБОР АСПС")
		elseif state == -11 then
			self:PrintText(2,0,"ПОИСК БК")
		elseif state == 1 then
			local err = Train:GetNW2Int("ASPS:Error",0)
			if err > 0 then
				self:PrintText(0,0,self.Errors[err])
			else
				self:PrintText(0,0,Format("ТЕК:%d",0))
				self:PrintText(8,0,Format("ПАМ:%d",0))
				self:PrintText(0,1,os.date("!%d/%m   %H:%M:%S",Metrostroi.GetSyncTime()))
				self:PrintText(6,1,Train:GetNW2Bool("ASPS:Master") and "О" or "В")
			end
		elseif state == 2 then
			self:PrintText(1,0,Format("%d",0)) --Номер просматриваемой ошибки в логе
			self:PrintText(4,0,"ВАГОН")
			self:PrintText(11,0,Format("%05d",0)) --Номер вагона ошибки
			self:PrintText(0,1,"ОШИБОК НЕТ")
			--local n = 1
			--self:PrintText(0,1,self.Errors[n]) --Текст ошибки
		end
	end
end