Metrostroi.DefineSystem("81_717_5P_ECRS")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.Train:LoadSystem("ECRS_BRT","Relay","Switch",{bass = true })
    self.Train:LoadSystem("ECRS_F1","Relay","Switch",{bass = true })
    self.Train:LoadSystem("ECRS_Cancel","Relay","Switch",{bass = true })
    self.Train:LoadSystem("ECRS_F2","Relay","Switch",{bass = true })
    --self.Train:LoadSystem("ECRS_up","Relay","Switch",{bass = true })
   -- self.Train:LoadSystem("ECRS_down","Relay","Switch",{bass = true })
    self.Train:LoadSystem("ECRS_left","Relay","Switch",{bass = true })
    self.Train:LoadSystem("ECRS_right","Relay","Switch",{bass = true })

	--[[for i=0,9 do
		self.Train:LoadSystem("ECRS_"..i,"Relay","Switch",{bass = true})
	end]]
    self.TriggerNames = {
		"ECRS_Cancel",
		"ECRS_F1",
		"ECRS_F2",
		"ECRS_BRT",
		"ECRS_right",
		"ECRS_left",
		--[["ECRS_down",
		"ECRS_up",		
		"ECRS_1",
		"ECRS_2",
		"ECRS_3",
		"ECRS_4",
		"ECRS_5",
		"ECRS_6",
		"ECRS_7",
		"ECRS_8",
		"ECRS_9",
		"ECRS_0",	--]]
    }
    self.Triggers = {}
	for k,v in pairs(self.TriggerNames) do
		self.Triggers[v] = false
	end
	self.Enabled = true
	self.Power = 1
	self.Channel = self.Train.Electric.Type == 3 and 4 or 2
	self.TargetChannel = -1
	self.State = -1
	self.BRT = 1
	self.MTLight = 0
	self.MTGreen = 0
	self.MTRed = 0
end

function TRAIN_SYSTEM:Outputs()
    return {"Power", "MTLight", "MTGreen", "MTRed"}
end

function TRAIN_SYSTEM:Inputs()
    return {}
end
if TURBOSTROI then return end

function TRAIN_SYSTEM:TriggerInput(name,value)
	if name == "Enable" and value > 0 then
		timer.Simple(1, function()
			self.Enabled = true
			self.RestartTimer = CurTime()
		end)
    end
end

local Channels = {			
	"ПРС-1",
	"ПРС-2",
	"ПРС-3",
	"ПРС-4",
	"ПРС-5",
	"МРС ТЧ-1",
	"МРС ТЧ-2",
	"МРС ТЧ-3",
	"МРС ТЧ-4",
	"МРС ТЧ-5",
	"МРС ТЧ-6",
	"МРС ТЧ-7",
}


if SERVER then
	function TRAIN_SYSTEM:Trigger(name,value)
		local name = name:gsub("ECRS_","")
		local Train = self.Train
		if self.Power and (self.State >= 10 or self.State == -1) and (self.Power or self.State == -1) then
			if value and self.State >= 10 then
				Train:PlayOnce("ECRS", "ECRS", 1, 1)
			end

			if name == "Cancel" and value then
				self.StartTimer = CurTime()
			end
			if name == "BRT" and value then
				if self.BRT >= 0.25 then
					self.BRT = self.BRT - 0.125
				else
					self.BRT = 1
				end
			end
			if self.State == 10 then
				if name == "left" and value then
					self.State = 11
					self.TargetChannel = self.Channel
					if self.TargetChannel > 1 then
						self.TargetChannel = self.TargetChannel - 1 
					else 
						self.TargetChannel = #Channels 
					end
				end
				if name == "right"and value then
					self.State = 11
					self.TargetChannel = self.Channel
					if self.TargetChannel < #Channels then
						self.TargetChannel = self.TargetChannel + 1
					else 
						self.TargetChannel = 0
					end
				end

				if name == "F1" and value then
					self.bCancelTimer = CurTime()+0.15
				end
				if name == "F2" and value then
					self.bEnterTimer = CurTime()+0.15
				end
			elseif self.State == 11 then
				if name == "left" and value then
					if self.TargetChannel > 1 then
						self.TargetChannel = self.TargetChannel - 1 
					else 
						self.TargetChannel = #Channels 
					end
				end
				if name == "right" and value then
					if self.TargetChannel < #Channels then
						self.TargetChannel = self.TargetChannel + 1
					else 
						self.TargetChannel = 1
					end
				end
				if name == "F2" and value then
					self.Channel = self.TargetChannel
					self.TargetChannel = -1
					self.State = 10
					self.bEnterTimer = CurTime()+0.15
				end

				if (name == "F1") and value then 
					self.TargetChannel = -1 
					self.State = 10
					self.bCancelTimer = CurTime()+0.15
				end
				if (name == "Cancel") and value then 
					self.TargetChannel = -1 
					self.State = 10
				end
			end
		end
	end


	function TRAIN_SYSTEM:Think(dT)
		local Train = self.Train
		local B = (Train.Battery.Voltage > 55) and 1 or 0
		self.Power = (((Train:ReadTrainWire(10) + (B*Train.VB.Value*Train.A56.Value)) * Train.AR63.Value) + (B*Train.AV3.Value)) > 0
	
		if not self.Power then
			self.ShutDownTimer = nil
			self.RestartTimer = nil
			self.StartPlayed = false
			self.Enabled = false
		end
		if not self.Enabled then self.State = -1 end

		if self.Enabled and self.State == -1 and not self.RestartTimer then
			self.State = 0
			self.RestartTimer = CurTime()
		end
		if self.RestartTimer and CurTime()-self.RestartTimer > 8 then
			self.State = 10
			self.StartPlayed = false
			self.RestartTimer = nil
		elseif self.RestartTimer and CurTime() - self.RestartTimer > 6 then 
			self.State = 3
			if not self.StartPlayed then 
				self.StartPlayed = true
				Train:PlayOnce("ECRS", "", 1, 1)
			end
		elseif self.RestartTimer and CurTime() - self.RestartTimer > 4 then self.State = 2
		elseif self.RestartTimer and CurTime() - self.RestartTimer > 2 then self.State = 1 end
	
		if self.StartTimer and Train.ECRS_Cancel.Value < 0.5 then self.StartTimer = nil end
		if self.StartTimer and CurTime() - self.StartTimer > 2 then
			if self.State == -1 then
				self.Enabled = true
				self.StartTimer = nil
			elseif self.State >= 10 then
				self.State = 5
				Train:PlayOnce("ECRS", "", 1, 1)
				self.ShutDownTimer = CurTime()
				self.StartTimer = nil
			end
		end

		if self.ShutDownTimer and self.State == -1 then self.ShutDownTimer = nil end
		if self.ShutDownTimer and CurTime() - self.ShutDownTimer > 5 then
			self.ShutDownTimer = nil
			self.Enabled = false
		end

		if self.bEnterTimer and CurTime() > self.bEnterTimer then self.bEnterTimer = nil end
		if self.bCancelTimer and CurTime() > self.bCancelTimer then self.bCancelTimer = nil end

		self.MTGreen = (self.State >= 10 or (self.State <= 5 and self.State > 2)) and CurTime()%2.5>2.4 and 1 or 0
		self.MTRed = (self.State > 0 and self.State <= 2) and 1 or 0
		self.MTLight = self.State >= 1 and 1 or 0

		if self.Enabled then
			local ButtonPushed = ((self.bEnterTimer and "1" or "0") .. (self.bCancelTimer and "1" or "0"))
			ButtonPushed = string.Replace(ButtonPushed, " ", "")
			Train:SetNW2String("ECRSButtonPushed", ButtonPushed)
			Train:SetNW2Float("ECRSBrightness",self.BRT)
			Train:SetNW2Int("ECRSChannel",self.Channel)
			Train:SetNW2Int("ECRSTargetChannel",self.TargetChannel)
		end
		Train:SetNW2Int("ECRSState",self.State)

		for k,v in pairs(self.TriggerNames) do
			if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
				self:Trigger(v,Train[v].Value > 0.5)
				self.Triggers[v] = Train[v].Value > 0.5
			end
		end		
	end
else
    local function createFont(name,font,size)
        surface.CreateFont("Metrostroi_"..name, {
            font = font,
            size = size,
            weight = 800,
            blursize = false,
            antialias = true,
            underline = false,
            italic = string.find(name, "it") and true or false,
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
    createFont("ECRS15","Arial",15)
    createFont("ECRS16","Arial",16)
    createFont("ECRS15it","Arial",15)
    createFont("ECRS17","Arial",17)
    createFont("ECRS17it","Arial",17)
    createFont("ECRS19","Arial",19)
    createFont("ECRS20","Arial",20)
    createFont("ECRS25","Arial",25)
    createFont("ECRS30","Arial",30)
    createFont("ECRS30it","Arial",30)
    function TRAIN_SYSTEM:ClientThink()
        if not self.Train:ShouldDrawPanel("ECRSScreen") then return end
	    if not self.DrawTimer then
			render.PushRenderTarget(self.Train.ECRSScr,0,0,256,256)
            render.Clear(0, 0, 0, 0)
            render.PopRenderTarget()
        end
        if self.DrawTimer and CurTime()-self.DrawTimer < 0.1 then return end
        self.DrawTimer = CurTime()	
		
		render.PushRenderTarget(self.Train.ECRSScr,0,0,256,256)
		render.Clear(0, 0, 0, 0)
		cam.Start2D()
			surface.SetDrawColor(0,0,0)
			--surface.DrawRect(0,0,1024,1024)
			self:ECRSScreen(self.Train)
		cam.End2D()
		render.PopRenderTarget()		
    end

    local black = Color(0,0,0)
    local cPushed = Color(114,89,186)
    local cNotPushed = Color(139,200,235)

	function TRAIN_SYSTEM:ECRSScreen(Train)
		local State = Train:GetNW2Int("ECRSState",-1)
		local BRTLVL = math.Clamp(Train:GetNW2Float("ECRSBrightness", 1), 0.001, 1)

		local ButtonPushed = Train:GetNW2String("ECRSButtonPushed", "00")
		if State == -1 then
			return
		end
		if State == 0 then	
			--surface.SetDrawColor(Color(0,0,0))
			--surface.DrawRect(0,0,189+62,138)
		elseif State == 1 then	
			surface.SetDrawColor(Color(39,146,255))
			surface.DrawRect(0,0,189+62,138)
		elseif State == 2 or State == 5 then
			surface.SetDrawColor(Color(239,231,255))
			surface.DrawRect(0,0,189+62,138)
			surface.SetDrawColor(Color(234, 155, 138))
			for i=1,16 do
				surface.DrawCircle((189+60)/2, 138/2-10, i, 0, 69, 183, 50)
			end
			draw.SimpleText("M","Metrostroi_ECRS30it",(189+60)/2-2, 138/2-10,Color(250,250,250,200),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("MOTOROLA","Metrostroi_ECRS15it",(189+60)/2, 138/2+13,Color(0,0,100,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(State == 2 and (Train.WagonNumber and Train.WagonNumber or "----") or "Выкл-е питания","Metrostroi_ECRS17",(189+60)/2, 122,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		elseif State == 3 then
			surface.SetDrawColor(Color(239,231,255))
			surface.DrawRect(0,0,189+62,138)
			draw.RoundedBox( 6, 0, 14, 189, 118, Color(89, 150,175) )
			draw.RoundedBox( 6, 1, 15, 187, 116, Color(139,200,235) )
			draw.SimpleText("Индивидуальный","Metrostroi_ECRS17",94, 34,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("номер:","Metrostroi_ECRS17",94, 54,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			if (Train.WagonNumber) then
				local WN = tonumber(Train.WagonNumber) * 300
				draw.SimpleText(WN,"Metrostroi_ECRS17",94, 54+20,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end			
			draw.SimpleText("Вер. ПО:","Metrostroi_ECRS17",94, 54+20+20,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("R17.020.1419","Metrostroi_ECRS17",94, 54+20+20 +20,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		elseif State >= 10 then
			surface.SetDrawColor(Color(239,230,230))
			surface.DrawRect(0,0,189+60,138)
			
			-- Значек Моторолы
			surface.SetDrawColor(Color(234, 155, 138, 140))
			for i=1,17 do
				surface.DrawCircle(189/2-30, 138/4*2.8, i, 234, 155, 138, 40)
			end
			draw.SimpleText("M","Metrostroi_ECRS30it",189/2-32, 138/4*2.8,Color(255,255,255,120),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

			-- Кнопка Верх
			draw.RoundedBox( 6, 189, 0, 65, 58, Color(89, 150,175) )
			draw.RoundedBox( 6, 190, 1, 65, 56, string.sub(ButtonPushed, 2,2) == "1" and cPushed or cNotPushed )

			if State == 10 or State == 11 then
				-- Кнопка Меню
				draw.RoundedBox( 6, 189, 58, 65, 21, Color(89, 150,175) )
				draw.RoundedBox( 6, 190, 59, 65, 19, Color(139,200,235) )

				-- Кнопка Меню - Значек
				draw.RoundedBox( 0, 214, 63, 13, 13, Color(0,0,0) )
				draw.RoundedBox( 0, 212, 61, 13, 13, Color(240,240,210) )
				Metrostroi.DrawLine(214, 64, 223, 64,Color(0,0,0),1)
				Metrostroi.DrawLine(214, 66, 223, 66,Color(0,0,0),1)
				Metrostroi.DrawLine(214, 68, 223, 68,Color(0,0,0),1)
				Metrostroi.DrawLine(214, 70, 223, 70,Color(0,0,0),1)
				Metrostroi.DrawLine(214, 72, 223, 72,Color(0,0,0),1)
			end
			-- Кнопка низ
			draw.RoundedBox( 6, 189, 79, 65, 58, Color(89, 150,175) )
			draw.RoundedBox( 6, 190, 80, 65, 56, string.sub(ButtonPushed, 1,1) == "1" and cPushed or cNotPushed )

			-- Статус бар --
			-- Антенка
			Metrostroi.DrawLine(12, 2, 11, 14,Color(0,29,168),2)
			draw.RoundedBox(2, 9, 1, 4, 4, Color(187,58,38) )
			Metrostroi.DrawLine(16, 1, 15, 5,Color(0,29,168),2)
			draw.RoundedBoxEx( 3, 7, 7, 9, 7, Color(0,29,168), true, true, false, false)
			draw.RoundedBoxEx( 4, 9, 9, 5, 3, Color(218,218,215), true, true, false, false)


			-- Уровнь сети
			Metrostroi.DrawLine(20, 10, 20, 14,Color(060,240,106),3)
			Metrostroi.DrawLine(24, 8, 24, 14,Color(060,240,106),3)
			Metrostroi.DrawLine(28, 6, 28, 14,Color(060,240,106),3)
			Metrostroi.DrawLine(32, 4, 32, 14,Color(060,240,106),3)

			if State == 10 or State == 11 then
				draw.SimpleText("ЕЦРС","Metrostroi_ECRS20",94,25,black,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		        draw.SimpleText("Линия","Metrostroi_ECRS20",94,45,black,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		        local Channel = Train:GetNW2Int("ECRSChannel",1)
		        local TargetChannel = Train:GetNW2Int("ECRSTargetChannel", -1)
		        draw.SimpleText(State == 10 and (Channels[Channel] and Channels[Channel] or "----") or Channels[TargetChannel] and Channels[TargetChannel] or "----","Metrostroi_ECRS25",94,68,black,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
       		    draw.SimpleText(Train.WagonNumber and Train.WagonNumber or "----","Metrostroi_ECRS20",94,108-20,black,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		        local date = Metrostroi.GetSyncTime()
		        draw.SimpleText(os.date("!%d/%m/%y",date) .. " " .. os.date("!%H:%M",date),"Metrostroi_ECRS20",94,108,black,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		        -- Кнопки
		        if State == 10 then
		        	draw.SimpleText("Конт.","Metrostroi_ECRS16",220, 29,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					draw.SimpleText("Парам.","Metrostroi_ECRS16",220, 108,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		        elseif State == 11 then
		        	draw.SimpleText("Отм.","Metrostroi_ECRS16",220, 29,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					draw.SimpleText("Выбрать","Metrostroi_ECRS16",220, 108,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		        end

        	elseif State == 12 then
        	
        	end
            
			surface.SetAlphaMultiplier(1-BRTLVL)
			surface.SetDrawColor(Color(20,20,20))
			surface.DrawRect(0,0,189+62,138)
			surface.SetAlphaMultiplier(1)

		end
	end
end