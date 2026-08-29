Metrostroi.DefineSystem("81_717_5P_KTS_O")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.Train:LoadSystem("KTSO_Menu","Relay","Switch",{bass = true})
    self.Train:LoadSystem("KTSO_Up","Relay","Switch",{bass = true })
    self.Train:LoadSystem("KTSO_Down","Relay","Switch",{bass = true })
    self.Train:LoadSystem("KTSO_Enter","Relay","Switch",{bass = true })
    self.TriggerNames = {
		"KTSO_Menu",
		"KTSO_Up",
		"KTSO_Down",
		"KTSO_Enter"
    }
    self.Triggers = {}
	for k,v in pairs(self.TriggerNames) do
		self.Triggers[v] = false
	end
	
	self.State = 0
	self.Line = 1

	self.Time = 0
	
end

function TRAIN_SYSTEM:Outputs()
    return {}
end

function TRAIN_SYSTEM:Inputs()
    return {}
end
if TURBOSTROI then return end

function TRAIN_SYSTEM:TriggerInput(name,value)
end
if SERVER then
	--self.Train:CANWrite("KTS_O)",self.Train:GetWagonNumber(),"Ticker",nil,"Something",значение)
	function TRAIN_SYSTEM:Trigger(name,value)
		local Train = self.Train
		if name == "KTSO_Menu" and not value then
			if self.State == 1 then
				self.State = 2
				self.Select = 1
			elseif self.State == 2 then
				self.State = 1
			elseif self.State == 21 or self.State == 24 or self.State == 25 then
				self.State = 2
				self.Select = self.SelectS
			elseif self.State == 22 or self.State == 23 then
				self.SelChange = 0
				self.State = 2
				self.Select = self.SelectS
			elseif self.State == 121 or self.State == 221 or self.State == 321 then
				self.State = 21
				self.Select = self.SelectS1
			elseif self.State == 125 or self.State == 225 or self.State == 325 or self.State == 425 then
				self.State = 25
				self.Select = self.SelectS1
			end
		end
		
		if self.State == 2 then
			if name == "KTSO_Up" and value then
				self.Select = math.max(1,self.Select-1)
			end
			if name == "KTSO_Down" and value then
				self.Select = math.min(5,self.Select+1)
			end
			if name == "KTSO_Enter" and not value then
				self.State = self.Select + 20
				self.SelectS = self.Select
				self.Select = 1
			end
		end
		
		if self.State == 21 then
			if name == "KTSO_Up" and value then
				self.Select = math.max(1,self.Select-1)
			end
			if name == "KTSO_Down" and value then
				self.Select = math.min(3,self.Select+1)
			end
			if name == "KTSO_Enter" and value then
				self.State = self.Select * 100 + 21
				self.SelectS1 = self.Select
				self.Select = 1
			end
		end
		
		if self.State == 210 then
			if name == "KTSO_Enter" and not value and self.Select ~= 1 then
				self.State = 21
				self.Select = self.SelectS1
			end
			if name == "KTSO_Enter" and  value and self.Select == 1 then self.Select = 2 end
		end
		
		if self.State == 22 then
			if name == "KTSO_Enter" and value then
				self.Select = self.Select < 3 and self.Select + 1 or 1
				self.SelChange = 0
			end
			if name == "KTSO_Up" and value then
				self.SelChange = self.Select
				if self.Select == 1 then
					self.Time = self.Time + 3600
				elseif self.Select == 2 then
					self.Time = self.Time + 60
				elseif self.Select == 3 then
					self.Time = self.Time + 1
				end
			end
			if name == "KTSO_Down" and value then
				self.SelChange = self.Select
				if self.Select == 1 then
					self.Time = self.Time - 3600
				elseif self.Select == 2 then
					self.Time = self.Time - 60
				elseif self.Select == 3 then
					self.Time = self.Time - 1
				end
			end
		end
		
		if self.State == 23 then
			if name == "KTSO_Enter" and value then
				self.Select = self.Select < 3 and self.Select + 1 or 1
				self.SelChange = 0
			end
			if name == "KTSO_Up" and value then
				self.SelChange = self.Select
				if self.Select == 1 then
					self.Time = self.Time + 86400
				elseif self.Select == 2 then
					local nmonth = tonumber(os.date("!%m",self.Time))
					--self.Time = self.Time + 2419200 + ( (nmonth == 4 or nmonth == 6 or nmonth == 9 or nmonth == 11) and 172800 or (nmonth == 2 and tonumber(os.date("!%Y",self.Time) % 4 == 0)) and 86400 or 259200)
					self.Time = self.Time + 2629743
				elseif self.Select == 3 then
					--self.Time = self.Time + (tonumber(os.date("!%Y",self.Time) % 4 == 0 and 31622400 or 31536000))
					self.Time = self.Time + 31556926
				end
			end
			if name == "KTSO_Down" and value then
				self.SelChange = self.Select
				if self.Select == 1 then
					self.Time = self.Time - 86400
				elseif self.Select == 2 then
					local nmonth = tonumber(os.date("!%m",self.Time))
					--self.Time = self.Time - (2419200 + ( (nmonth == 4 or nmonth == 6 or nmonth == 9 or nmonth == 11) and 172800 or (nmonth == 2 and tonumber(os.date("!%Y",self.Time) % 4 == 0)) and 86400 or 259200))
					self.Time = self.Time - 2629743
				elseif self.Select == 3 then
					--self.Time = self.Time - (tonumber(os.date("!%Y",self.Time) % 4 == 0 and 31622400 or 31536000))
					self.Time = self.Time - 31556926
				end
			end
		end
		
		if self.State == 24 then
			if name == "KTSO_Up" and value then
				self.Select = math.max(1,self.Select-1)
			end
			if name == "KTSO_Down" and value then
				self.Select = math.min(3,self.Select+1)
			end
		end
		
		if self.State == 25 then
			if name == "KTSO_Up" and value then
				self.Select = math.max(1,self.Select-1)
			end
			if name == "KTSO_Down" and value then
				self.Select = math.min(6,self.Select+1)
			end
			if name == "KTSO_Enter" and value then
				self.State = self.Select * 100 + 25
				self.SelectS1 = self.Select
				self.Select = 1
			end
		end
		
		if self.State == 525 then
			if name == "KTSO_Enter" and not value and self.Select ~= 1 then
				self.State = 25
				self.Select = self.SelectS1
			end
			if name == "KTSO_Enter" and not value and self.Select == 1 then self.Select = 2 end
		end

		Train:SetNW2Int("KTS-O:Select",self.Select)
	end
	
	function TRAIN_SYSTEM:Think(dT)
		local Train = self.Train
		local Power = Train.VB.Value > 0 and Train.A76.Value > 0
		if not Power and self.State ~= 0 then
			self.State = 0
		end
		if Power and self.State == 0 then
			self.State = 1
		end
		if Power then
			if (self.State == 121 or self.State == 221 or self.State == 321) and not Metrostroi.MilasSetup then
				self.State = 210
			end
			if self.State == 22 or self.State == 23 then
				Train:SetNW2Int("KTS-O:SelChange",self.SelChange)
			end
		end
		for k,v in pairs(self.TriggerNames) do
			if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
				self:Trigger(v,Train[v].Value > 0.5)
				self.Triggers[v] = Train[v].Value > 0.5
			end
		end
		Train:SetNW2Int("KTS-O:Time",self.Time)
		Train:SetNW2Int("KTS-O:Line",self.Line)
		Train:SetNW2Int("KTS-O:State",self.State)
	end
else
    local function createFont(name,font,size,weight)
        surface.CreateFont("Metrostroi_"..name, {
            font = font,
            size = size,
            weight = weight or 400,
            blursize = 0,
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
        })
    end
    createFont("U1","Unifont",16)
    createFont("UTime","Unifont",24,800)
    createFont("U1B","Unifont",20)
	
	local tday = {[0] ="Вс","Пн","Вт","Ср","Чт","Пт","Сб",}
	local tmonth = {"Январь","Февраль","Март","Апрель","Май","Июнь","Июль","Август","Сентябрь","Октябрь","Ноябрь","Декабрь"}
	
	local close = surface.GetTextureID("kts_o/icons/close")
	local dot = surface.GetTextureID("kts_o/icons/dot")
	local err = surface.GetTextureID("kts_o/icons/err")
	local full = surface.GetTextureID("kts_o/icons/full")
	
	local menu = surface.GetTextureID("kts_o/icons/menu/menu")
	local date = surface.GetTextureID("kts_o/icons/menu/date")
	local route = surface.GetTextureID("kts_o/icons/menu/route")
	local settings = surface.GetTextureID("kts_o/icons/menu/settings")
	local sound = surface.GetTextureID("kts_o/icons/menu/sound")
	local time = surface.GetTextureID("kts_o/icons/menu/time")
	
	local copy = surface.GetTextureID("kts_o/icons/menu/route/copy")
	local del = surface.GetTextureID("kts_o/icons/menu/route/del")
	local dest = surface.GetTextureID("kts_o/icons/menu/route/dest")
	local brick = surface.GetTextureID("kts_o/icons/menu/route/brick")
	
	local mixer = surface.GetTextureID("kts_o/icons/menu/sound/mixer")
	
    function TRAIN_SYSTEM:ClientThink()
    if not self.Train:ShouldDrawPanel("KTSOScreen") then return end
		-- if not self.DrawTimer and self.Train:GetNW2Int("KTS-O:State",0) ~= 0 then
            -- render.PushRenderTarget(self.Train.KTSOScr,0,0,320, 240)
            -- render.Clear(0, 0, 0, 0)
            -- render.PopRenderTarget()
        -- end
        -- if self.DrawTimer and CurTime()-self.DrawTimer < 0.1 then return end
		
		-- if self.Train:GetNW2Int("KTS-O:State",0) == 0 then
			-- render.PushRenderTarget(self.Train.KTSOScr,0,0,320, 240)
            -- render.Clear(0, 0, 0, 0)
            -- render.PopRenderTarget()
		-- end
		
        self.DrawTimer = CurTime()
        render.PushRenderTarget(self.Train.KTSOScr,0,0,320, 240)
        render.Clear(0, 0, 0, 0)
        cam.Start2D()
			self:KTSOScreen(self.Train)
        cam.End2D()
        render.PopRenderTarget()
    end
	function TRAIN_SYSTEM:KTSOScreen(Train)
		local state = Train:GetNW2Int("KTS-O:State",0)
		local TDev = Metrostroi.GetSyncTime() + Train:GetNW2Int("KTS-O:Time",0)
		local EnLang = Train:GetNW2Bool("KTS-O:English",false)
		local color = Color(30,71,0)
		local colorinv = Color(80,190,0)
		local stbl = nil
		local RouteName = Metrostroi.MilasSetup and Metrostroi.MilasSetup[Train:GetNW2Int("Announcer",1)][Train:GetNW2Int("KTS-O:Line",0)].Name or "Не выбрано"
		if RouteName ~= "Не выбрано" then RouteName = #string.gsub(RouteName," линия","") <= 20 and RouteName or string.sub(string.gsub(RouteName," линия",""),0,16).."." end
		local ann = stbl and stbl[Train:GetNW2Int("KTS-O:Line",0)] or {[1] = {[2] = ""}} --ann[i][2] - писок станций
		if state == 0 then return end
		if state ~= 0 then
			surface.SetDrawColor(80,190,0,255)
			surface.DrawRect(0,0,320,240)
			--surface.SetDrawColor(255,255,255,127)
			--surface.SetTexture(clscr)
			--surface.DrawTexturedRectRotated(256,128,512,256,0)
		end
		if state > 0 then
			surface.SetDrawColor(30,71,0,255)
			for i=0,3 do
				surface.DrawRect(3+79*i,216,77,22)
			end
			if state > 1 then
				surface.SetDrawColor(30,71,0,210)
				surface.SetTexture(dot)
				surface.DrawTexturedRectRotated(270,11,16,16,0)
				surface.SetTexture(full)
				surface.DrawTexturedRectRotated(288,11,16,16,0)
				surface.SetTexture(close)
				surface.DrawTexturedRectRotated(306,11,16,16,0)
			end
		end
		if state == 1 then
			--Текст
			draw.SimpleText(Format("Маршрут: %s",RouteName),"Metrostroi_U1",240,10,color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(Format("%s-%s",#ann[1][2] <= 14 and ann[1][2] or string.sub(ann[1][2],0,14)..".",#ann[#ann][2] <= 14 and ann[#ann][2] or string.sub(ann[#ann][2],0,14).."."),"Metrostroi_U1",240,32,color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(Format("%s, %s %d",tday[tonumber(os.date("!%w",TDev))],tmonth[tonumber(os.date("!%m",TDev))],os.date("!%d",TDev)),"Metrostroi_U1",79,10,color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(os.date("!%H:%M:%S",TDev),"Metrostroi_UTime",79,28, color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			
			--Графика
			Metrostroi.DrawRectOutline(0,0,159,42,color,1)
			Metrostroi.DrawRectOutline(161,22,158,20,color,1)
			draw.SimpleText("Меню","Metrostroi_U1",41,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		elseif state == 2 then
			local sel = Train:GetNW2Int("KTS-O:Select",0)
			local menulist = {
				"Управление маршрутом",
				"Установка времени",
				"Установка даты",
				"Громкость и звук",
				"Настройки устройства"
			}
			local menutex = {
				route,
				time,
				date,
				sound,
				settings
			}
			
			surface.SetDrawColor(30,71,0,210)
			surface.SetTexture(menu)
			surface.DrawTexturedRectRotated(12,11,16,16,0)
			surface.SetDrawColor(color)
			surface.DrawRect(22,2,234,18)
			draw.SimpleText("Меню","Metrostroi_U1",26,10,colorinv,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			
			
			surface.SetDrawColor(color)
			surface.DrawRect(1,22+(sel-1)*24,318,24)
			surface.SetDrawColor(colorinv)
			surface.DrawRect(4,26+(sel-1)*24,16,16)
			
			for i=1,#menulist do
				surface.SetDrawColor(30,71,0,210)
				surface.SetTexture(menutex[i])
				surface.DrawTexturedRectRotated(12,34+(i-1)*24,16,16,0)
				draw.SimpleText(Format("%d. %s",i,menulist[i]),"Metrostroi_U1",28,32+(i-1)*24,sel == i and colorinv or color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			end
			
			draw.SimpleText("Отмена","Metrostroi_U1",42,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			if sel > 1 then draw.SimpleText("Вверх ","Metrostroi_U1",124,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end
			if sel < #menulist then draw.SimpleText("Вниз","Metrostroi_U1",198,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end
			draw.SimpleText("Выбор","Metrostroi_U1",278,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		elseif state == 21 then
			local sel = Train:GetNW2Int("KTS-O:Select",0)
			local menulist = {
				"Установка маршрута",
				"Выбор направления",
				"Выбор станции",
				--"Копирование маршрутов",
				--"Удаление маршрутов"
			}
			local menutex = {
				route,
				dest,
				brick,
				--copy,
				--del
			}
			
			surface.SetDrawColor(30,71,0,210)
			surface.SetTexture(route)
			surface.DrawTexturedRectRotated(12,11,16,16,0)
			surface.SetDrawColor(color)
			surface.DrawRect(22,2,234,18)
			draw.SimpleText("Управление маршрутом","Metrostroi_U1",26,10,colorinv,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			
			surface.SetDrawColor(color)
			surface.DrawRect(1,22+(sel-1)*24,318,24)
			surface.SetDrawColor(colorinv)
			surface.DrawRect(4,26+(sel-1)*24,16,16)
			
			for i=1,#menulist do
				surface.SetDrawColor(30,71,0,210)
				surface.SetTexture(menutex[i])
				surface.DrawTexturedRectRotated(12,34+(i-1)*24,16,16,0)
				draw.SimpleText(Format("%d. %s",i,menulist[i]),"Metrostroi_U1",28,32+(i-1)*24,sel == i and colorinv or color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			end
				
			draw.SimpleText("Отмена","Metrostroi_U1",42,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			if sel > 1 then draw.SimpleText("Вверх ","Metrostroi_U1",124,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end
			if sel < #menulist then draw.SimpleText("Вниз","Metrostroi_U1",198,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end
			draw.SimpleText("Выбор","Metrostroi_U1",278,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		elseif state == 210 then
			surface.SetDrawColor(30,71,0,210)
			surface.SetTexture(err)
			surface.DrawTexturedRectRotated(12,11,16,16,0)
			surface.SetDrawColor(color)
			surface.DrawRect(22,2,234,18)
			draw.SimpleText("Ошибка","Metrostroi_U1",26,10,colorinv,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			
			draw.SimpleText("Каталоги маршрутов отсутствуют на","Metrostroi_U1",160,112,color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("диске.","Metrostroi_U1",160,128,color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			
			draw.SimpleText("Готово","Metrostroi_U1",278,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		elseif state == 22 then
			local sel = Train:GetNW2Int("KTS-O:Select",0)
			local selch = Train:GetNW2Int("KTS-O:SelChange",0)
			surface.SetDrawColor(30,71,0,210)
			surface.SetTexture(time)
			surface.DrawTexturedRectRotated(12,11,16,16,0)
			surface.SetDrawColor(color)
			surface.DrawRect(22,2,234,18)
			draw.SimpleText("Время","Metrostroi_U1",26,10,colorinv,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			
			draw.SimpleText("Час","Metrostroi_UTime",240,38,color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			Metrostroi.DrawRectOutline(164,56,129,28,color,2)
			surface.SetDrawColor(color)
			surface.DrawRect(294,55,21,14)
			surface.DrawRect(294,70,21,14)
			surface.SetDrawColor(colorinv)
			draw.NoTexture()
			surface.DrawPoly({
				{ x = 298, y = 65 },
				{ x = 305, y = 58 },
				{ x = 312, y = 65 }
			})
			surface.DrawPoly({
				{ x = 305, y = 81 },
				{ x = 298, y = 74 },
				{ x = 312, y = 74 }
			})
			if selch == 1 then
				surface.SetDrawColor(color)
				surface.DrawRect(166,58,28,23)
			end
			draw.SimpleText(os.date("!%H",TDev),"Metrostroi_UTime",166,68,selch == 1 and colorinv or color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText(Format("%s",(sel == 1 and CurTime()%1 > 0.5) and "|" or ""),"Metrostroi_UTime",189,68,color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			
			draw.SimpleText("Мин","Metrostroi_UTime",240,100,color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			Metrostroi.DrawRectOutline(164,118,129,28,color,2)
			surface.SetDrawColor(color)
			surface.DrawRect(294,117,21,14)
			surface.DrawRect(294,132,21,14)
			surface.SetDrawColor(colorinv)
			draw.NoTexture()
			surface.DrawPoly({
				{ x = 298, y = 127 },
				{ x = 305, y = 120 },
				{ x = 312, y = 127 }
			})
			surface.DrawPoly({
				{ x = 305, y = 142 },
				{ x = 298, y = 135 },
				{ x = 312, y = 135 }
			})
			if selch == 2 then
				surface.SetDrawColor(color)
				surface.DrawRect(166,120,28,23)
			end
			draw.SimpleText(os.date("!%M",TDev),"Metrostroi_UTime",166,130,selch == 2 and colorinv or color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText(Format("%s",(sel == 2 and CurTime()%1 > 0.5) and "|" or ""),"Metrostroi_UTime",189,130,color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			
			draw.SimpleText("Сек","Metrostroi_UTime",240,164,color,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			Metrostroi.DrawRectOutline(164,180,129,28,color,2)
			surface.SetDrawColor(color)
			surface.DrawRect(294,179,21,14)
			surface.DrawRect(294,194,21,14)
			surface.SetDrawColor(colorinv)
			draw.NoTexture()
			surface.DrawPoly({
				{ x = 298, y = 189 },
				{ x = 305, y = 182 },
				{ x = 312, y = 189 }
			})
			surface.DrawPoly({
				{ x = 305, y = 205 },
				{ x = 298, y = 198 },
				{ x = 312, y = 198 }
			})
			if selch == 3 then
				surface.SetDrawColor(color)
				surface.DrawRect(166,182,28,23)
			end
			draw.SimpleText(os.date("!%S",TDev),"Metrostroi_UTime",166,192,selch == 3 and colorinv or color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText(Format("%s",(sel == 3 and CurTime()%1 > 0.5) and "|" or ""),"Metrostroi_UTime",189,192,color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			
			Metrostroi.DrawRectOutline(6,26,152,182,color,2)
			surface.SetDrawColor(color)
			for i=0,11 do
				local a = math.rad((i/12)*(-360))
				surface.DrawLine(81 + math.sin(a)*68,115 + math.cos(a)*68,81 + math.sin(a)*72,115 + math.cos(a)*72)
			end
			local second = 30 - tonumber(os.date("!%S",TDev))
			local minutes = 30 - tonumber(os.date("!%M",TDev))
			local hours = 6 - tonumber(os.date("!%H",TDev)) + (minutes - 30)/60
			
			--Эти стрелки - ёбаный пиздец, не пытайся понять, как они работают
			surface.SetDrawColor(color)
			draw.NoTexture()
			surface.DrawPoly({
				{ x = 81 + math.sin(math.rad( ((second-5)/60)*360 ))*-5, y = 115 + math.cos(math.rad( ((second-5)/60)*360) )*-5},
				{ x = 81 + math.sin(math.rad(  (second/60)     *360))*73,y = 115 + math.cos(math.rad(  (second/60)    *360) )*73},
				{ x = 81 + math.sin(math.rad( ((second+5)/60)*360 ))*-5, y = 115 + math.cos(math.rad( ((second+5)/60)*360) )*-5},
			})
			
			surface.DrawPoly({
				{ x = 81 + math.sin(math.rad( ((minutes-5)/60)*360 ))*-5, y = 115 + math.cos(math.rad( ((minutes-5)/60)*360) )*-5},
				{ x = 81 + math.sin(math.rad(  (minutes/60)   *360))*61,y = 115 + math.cos(math.rad( (minutes/60)    *360) )*61},
				{ x = 81 + math.sin(math.rad( ((minutes+5)/60)*360 ))*-5, y = 115 + math.cos(math.rad( ((minutes+5)/60)*360) )*-5},
			})
			
			surface.DrawPoly({
				{ x = 81 + math.sin(math.rad( ((hours-2)/12)*360 ))*-5, y = 115 + math.cos(math.rad( ((hours-2)/12)*360) )*-5},
				{ x = 81 + math.sin(math.rad(  (hours/12)    *360))*57,y = 115 + math.cos(math.rad(    (hours/12)    *360) )*57},
				{ x = 81 + math.sin(math.rad( ((hours+2)/12)*360 ))*-6, y = 115 + math.cos(math.rad( ((hours+2)/12)*360) )*-6},
				{ x = 81 + math.sin(math.rad( ((hours)/12)*360 ))*-8, y = 115 + math.cos(math.rad( ((hours)/12)*360) )*-8},
			})
			
			draw.SimpleText("Отмена","Metrostroi_U1",42,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("Вверх ","Metrostroi_U1",124,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("Вниз","Metrostroi_U1",198,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("Далее","Metrostroi_U1",278,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		elseif state == 23 then
			local sel = Train:GetNW2Int("KTS-O:Select",0)
			local selch = Train:GetNW2Int("KTS-O:SelChange",0)
			
			surface.SetDrawColor(30,71,0,210)
			surface.SetTexture(date)
			surface.DrawTexturedRectRotated(12,11,16,16,0)
			surface.SetDrawColor(color)
			surface.DrawRect(22,2,234,18)
			draw.SimpleText("Дата","Metrostroi_U1",26,10,colorinv,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			
			Metrostroi.DrawRectOutline(10,102,48,28,color,2)
			surface.DrawRect(59,101,21,14)
			surface.DrawRect(59,116,21,14)
			surface.SetDrawColor(colorinv)
			draw.NoTexture()
			surface.DrawPoly({
				{ x = 63, y = 111 },
				{ x = 63+7, y = 111-7 },
				{ x = 63+14, y = 111 }
			})
			surface.DrawPoly({
				{ x = 63+7, y = 119+7 },
				{ x = 63,   y = 119 },
				{ x = 63+14,y = 119 }
			})
			if selch == 1 then
				surface.SetDrawColor(color)
				surface.DrawRect(12,104,28,23)
			end
			draw.SimpleText(os.date("!%d",TDev),"Metrostroi_UTime",12,114,selch == 1 and colorinv or color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText(Format("%s",(sel == 1 and CurTime()%1 > 0.5) and "|" or ""),"Metrostroi_UTime",35,114,color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			
			Metrostroi.DrawRectOutline(90,102,126,28,color,2)
			if sel == 2 then
				surface.SetDrawColor(color)
				surface.DrawRect(91,103,123,25)
			end
			draw.SimpleText(Format("%s",tmonth[tonumber(os.date("!%m",TDev))]),"Metrostroi_UTime",92,114,sel == 2 and colorinv or color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			
			
			Metrostroi.DrawRectOutline(226,102,65,28,color,2)
			surface.DrawRect(292,101,21,14)
			surface.DrawRect(292,116,21,14)
			surface.SetDrawColor(colorinv)
			draw.NoTexture()
			surface.DrawPoly({
				{ x = 296, y = 111 },
				{ x = 296+7, y = 111-7 },
				{ x = 296+14, y = 111 }
			})
			surface.DrawPoly({
				{ x = 296+7, y = 119+7 },
				{ x = 296,   y = 119 },
				{ x = 296+14,y = 119 }
			})
			if selch == 3 then
				surface.SetDrawColor(color)
				surface.DrawRect(228,104,56,23)
			end
			draw.SimpleText(os.date("!%Y",TDev),"Metrostroi_UTime",230,114,selch == 3 and colorinv or color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText(Format("%s",(sel == 3 and CurTime()%1 > 0.5) and "|" or ""),"Metrostroi_UTime",279,114,color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			
			draw.SimpleText("Отмена","Metrostroi_U1",42,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("Вверх ","Metrostroi_U1",124,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("Вниз","Metrostroi_U1",198,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("Далее","Metrostroi_U1",278,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		elseif state == 24 then
			local sel = Train:GetNW2Int("KTS-O:Select",0)
			local menulist = {
				"Звуки клавиш",
				"Громкость в кабине",
				"Громкость в салоне",
			}
			local menutex = {
				route,
				mixer,
				mixer,
			}
			
			surface.SetDrawColor(30,71,0,210)
			surface.SetTexture(sound)
			surface.DrawTexturedRectRotated(12,11,16,16,0)
			surface.SetDrawColor(color)
			surface.DrawRect(22,2,234,18)
			draw.SimpleText("Громкость и звук","Metrostroi_U1",26,10,colorinv,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			
			surface.SetDrawColor(color)
			surface.DrawRect(1,22+(sel-1)*24,318,24)
			surface.SetDrawColor(colorinv)
			surface.DrawRect(4,26+(sel-1)*24,16,16)
			
			for i=1,#menulist do
				surface.SetDrawColor(30,71,0,210)
				surface.SetTexture(menutex[i])
				surface.DrawTexturedRectRotated(12,34+(i-1)*24,16,16,0)
				draw.SimpleText(Format("%d. %s",i,menulist[i]),"Metrostroi_U1",28,32+(i-1)*24,sel == i and colorinv or color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			end
			
			draw.SimpleText("Отмена","Metrostroi_U1",42,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			if sel > 1 then draw.SimpleText("Вверх ","Metrostroi_U1",124,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end
			if sel < #menulist then draw.SimpleText("Вниз","Metrostroi_U1",198,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end
			draw.SimpleText("Выбор","Metrostroi_U1",278,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		elseif state == 25 then
			local sel = Train:GetNW2Int("KTS-O:Select",0)
			local menulist = {
				"Язык интерфейса",
				"Стили окон",
				"Стиль оформления",
				"Подсветка экрана",
				--"Другие настройки",
				"Информация о системе",
				--"Копировать журнал событий",
				"Сброс настроек"
			}
			local menutex = {
				language,
				stylewin,
				style,
				sun,
				--othermenu,
				info,
				--copylog,
				reset
			}
			
			surface.SetDrawColor(30,71,0,210)
			surface.SetTexture(settings)
			surface.DrawTexturedRectRotated(12,11,16,16,0)
			surface.SetDrawColor(color)
			surface.DrawRect(22,2,234,18)
			draw.SimpleText("Настройки устройства","Metrostroi_U1",26,10,colorinv,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			
			surface.SetDrawColor(color)
			surface.DrawRect(1,22+(sel-1)*24,318,24)
			surface.SetDrawColor(colorinv)
			surface.DrawRect(4,26+(sel-1)*24,16,16)
			
			for i=1,#menulist do
				surface.SetDrawColor(30,71,0,210)
				--surface.SetTexture(menutex[i])
				--surface.DrawTexturedRectRotated(12,32+(i-1)*24,16,16,0)
				draw.SimpleText(Format("%d. %s",i,menulist[i]),"Metrostroi_U1",28,32+(i-1)*24,sel == i and colorinv or color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			end
			
			draw.SimpleText("Отмена","Metrostroi_U1",42,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			if sel > 1 then draw.SimpleText("Вверх ","Metrostroi_U1",124,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end
			if sel < #menulist then draw.SimpleText("Вниз","Metrostroi_U1",198,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end
			draw.SimpleText("Выбор","Metrostroi_U1",278,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		elseif state == 125 then
			local sel = Train:GetNW2Int("KTS-O:Select",0)
			local menulist = {
				"English (Английский)",
				"Russian (Русский)"
			}
			
			surface.SetDrawColor(30,71,0,210)
			--surface.SetTexture(language)
			surface.DrawTexturedRectRotated(12,11,16,16,0)
			surface.SetDrawColor(color)
			surface.DrawRect(22,2,234,18)
			draw.SimpleText("Язык устройства","Metrostroi_U1",26,10,colorinv,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			
			surface.SetDrawColor(color)
			surface.DrawRect(1,22+(sel-1)*24,318,24)
			surface.SetDrawColor(colorinv)
			surface.DrawRect(4,26+(sel-1)*24,16,16)
			
			for i=1,#menulist do
				surface.SetDrawColor(30,71,0,210)
				--surface.SetTexture(menutex[i])
				--surface.DrawTexturedRectRotated(12,32+(i-1)*24,16,16,0)
				draw.SimpleText(Format("%d. %s",i,menulist[i]),"Metrostroi_U1",28,32+(i-1)*24,sel == i and colorinv or color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			end
		elseif state == 525 then
			local t1 = {
				"HW Revision",
				"GNU/Linux",
				"uClibc",
				"dosfstools",
				"e2fsprogs",
				"BusyBox",
				"Qt-Library",
				"MM-Informer",
				"Free Memory"
			}
			local t2 = {
				"0x0000 (Build 747)",
				"2.6.27.7-milas1",
				"0.9.30",
				"3.0.0",
				"1.41.3",
				"1.14.0.svn",
				"3.3.8b",
				"0.3 (01.12.2008)",
				"50120 K"
			}
			surface.SetDrawColor(30,71,0,210)
			--surface.SetTexture(info)
			surface.DrawTexturedRectRotated(12,11,16,16,0)
			surface.SetDrawColor(color)
			surface.DrawRect(22,2,234,18)
			draw.SimpleText("Информация о системе","Metrostroi_U1",26,10,colorinv,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			
			for i=1,#t1 do
				draw.SimpleText(Format("%s:",t1[i]),"Metrostroi_U1",4,42+(i-1)*18,color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText(Format("%s",t2[i]),"Metrostroi_U1",120,42+(i-1)*18,color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			end
			
			draw.SimpleText("Выход","Metrostroi_U1",278,226,colorinv,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
	end
end