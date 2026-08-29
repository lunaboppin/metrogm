Metrostroi.DefineSystem("81_760A_RVS_1")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.Train:LoadSystem("RVS_KV","Relay","Switch",{bass = true})
    self.Train:LoadSystem("RVS_UKV","Relay","Switch",{bass = true })
    self.Train:LoadSystem("RVS_S","Relay","Switch",{bass = true })
    self.Train:LoadSystem("RVS_F","Relay","Switch",{bass = true })
	for i=0,9 do
		self.Train:LoadSystem("RVS_"..i,"Relay","Switch",{bass = true })
	end
    self.TriggerNames = {
		"RVS_KV",
		"RVS_UKV",
		"RVS_S",
		"RVS_F",
		"RVS_1",
		"RVS_2",
		--[[
		"RVS_3",
		"RVS_4",
		"RVS_5",
		"RVS_6",
		"RVS_7",
		"RVS_8",
		"RVS_9",
		"RVS_0",	
				]]
    }
    self.Triggers = {}
	for k,v in pairs(self.TriggerNames) do
		self.Triggers[v] = false
	end
	self.Power = true
	self.Channel = 1
	self.UKV = false
	self.PRD = false
	self.State = -1
	self.RVSVal = 0	
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
	function TRAIN_SYSTEM:Trigger(name,value)
		local name = name:gsub("RVS_","")
		local Train = self.Train
		local Power = (Train.Electric.Battery80V > 62 or Train.PowerReserve.Value > 0) and Train.SF21.Value > 0.5
		if Power and self.State ~= 0 then
			if name == "F" and value then
				self.Power = not self.Power
			end
		end
		if self.State == 1 then
			local char = tonumber(name)
			if name == "UKV" and value then
				self.UKV = true
			end
			if name == "KV" and value then
				self.UKV = false
			end
			if name == "S" and value then
				self.PRD = true
			end
			if name == "S" and not value then
				self.PRD = false
			end
			if char and value then
				self.Channel = char
			end
		end
	end
	function TRAIN_SYSTEM:Think(dT)
		local Train = self.Train
		local Power = (Train.Electric.Battery80V > 62 or Train.PowerReserve.Value > 0) and self.Power and Train.SF21.Value > 0.5
		Train:SetNW2Int("RVSState",self.State)
		if not Power then
			self.UKV = false
			self.PRD = false
			self.Channel = 1
			self.State = -1
		end
		if Power and self.State == -1 and not self.RestartTimer then
			self.State = 0
			self.RestartTimer = CurTime()+4
		end
		if self.RestartTimer and CurTime()-self.RestartTimer > 0 then
			self.State = 1
			self.RestartTimer = nil
		end
		
		Train:SetNW2Bool("RVSUKV",self.State >= 1 and self.UKV)	
		Train:SetNW2Bool("RVSKV",self.State >= 1 and not self.UKV)	
		Train:SetNW2Bool("RVS1",self.State >= 1 and self.Channel == 1 and not self.UKV)
		Train:SetNW2Bool("RVS2",self.State >= 1 and self.Channel == 2 and not self.UKV)
		Train:SetNW2Bool("RVSKVPRD",self.State >= 1 and not self.UKV and self.PRD)
		Train:SetNW2Bool("RVSUKVPRD",self.State >= 1 and self.UKV and self.PRD)
		Train:SetNW2Bool("RVSPRD",self.State >= 1 and self.PRD)
	
		if self.State >= 1 and self.RVSVal > 0 then -- Train:GetNW2Bool("RVSButtonsState",false) then
			--Train:PlayOnce("rvs1","",1,1)	
		end		
		if self.State == 1 then		
			Train:SetNW2Int("RVSChannel",self.Channel)
		end
		for k,v in pairs(self.TriggerNames) do
			if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
				self:Trigger(v,Train[v].Value > 0.5)
				self.Triggers[v] = Train[v].Value > 0.5
			end
		end		
	end
else
    local function createFont(name,font,size,weight,blur,scanlines,underline)
        surface.CreateFont("Metrostroi_"..name, {
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
            shadow = false,
            additive = false,
            outline = false,
            extended = true,
            scanlines = scanlines or false,
        })
    end
	createFont("RVS","haxr",33,800,0,0,false)--125 25  
	createFont("RVS1","haxr",26,1000,0,0,false)--125 25  
	createFont("RVS2","haxr",23,500,0,0,false)--125 25  
    function TRAIN_SYSTEM:ClientThink()
        if not self.Train:ShouldDrawPanel("RVSScreen") then return end
	    if not self.DrawTimer then
			render.PushRenderTarget(self.Train.RVSScr,0,0,256,256)
            render.Clear(0, 0, 0, 0)
            render.PopRenderTarget()
        end
        if self.DrawTimer and CurTime()-self.DrawTimer < 0.1 then return end
        self.DrawTimer = CurTime()	
		
		render.PushRenderTarget(self.Train.RVSScr,0,0,256,256)
		render.Clear(0, 0, 0, 0)
		cam.Start2D()
			surface.SetDrawColor(0,0,0)
			--surface.DrawRect(0,0,1024,1024)
			self:RVSScreen(self.Train)
		cam.End2D()
		render.PopRenderTarget()		
    end
	local font = "Metrostroi_RVS"
	local black = Color(25,25,25)
	function TRAIN_SYSTEM:RVSScreen(Train)
		local State = Train:GetNW2Int("RVSState",-1)
		if State == -1 then
			return
		end		
		if State == 0 then
			surface.SetDrawColor(234,253,255)		
			surface.DrawRect(0,2,256,140)		
		elseif State == 1 then
			surface.SetDrawColor(234,253,255)		
			surface.DrawRect(0,2,256,140)		
			local UKV = Train:GetNW2Bool("RVSUKV",false)        
			draw.SimpleText(UKV and "УКВ" or "КВ",font,30,25,black,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

			local Channel = Train:GetNW2Int("RVSChannel",1).."к"
			draw.SimpleText(Channel,font,140,25,black,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			
			local PRD = Train:GetNW2Bool("RVSPRD",false)
			if PRD then
				draw.SimpleText("ПРД",font,220,25,black,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)			
			end
			draw.SimpleText("РВС-1",font.."1",135,70,black,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			
			draw.SimpleText("Метро-локомотив",font.."2",130,90,black,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("Нет ПП",font,13,120,black,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
		end
	end
end