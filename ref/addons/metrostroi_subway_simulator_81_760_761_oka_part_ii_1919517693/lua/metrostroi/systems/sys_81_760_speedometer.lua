--------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_760_Speedometer")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.State = -1
	self.F3 = false
	self.RestartTimer = CurTime()
	
	self.Train:LoadSystem("SpeedometerF3","Relay","Switch",{bass=true})

	self.TriggerNames = {
		"SpeedometerF3",
	}
	self.Triggers = {}
	for k,v in pairs(self.TriggerNames) do
		if self.Train[v] then self.Triggers[v] = self.Train[v].Value > 0.5 end
	end	
end

function TRAIN_SYSTEM:Outputs()
	return {"State"}
end

function TRAIN_SYSTEM:Inputs()
	return {}
end
if TURBOSTROI then return end

function TRAIN_SYSTEM:TriggerInput(name,value)
end
if SERVER then
	function TRAIN_SYSTEM:Trigger(name,value)
		local name = name:gsub("Speedometer","")
		local Train = self.Train
		if self.State > 0 then
			if name == "F3" and value then
				self.F3 = not self.F3
				Train:SetNW2Bool("BMCISF3",self.F3)
			end
		end
	end
	function TRAIN_SYSTEM:Think(dT)
		local Train = self.Train
		self.Power = Train.Electric.Battery80V > 62 and Train.SF12.Value+Train.SF13.Value > 0
		if not self.Power and self.State ~= -2 then self.State = -2 self.RestartTimer = 1e9 end
		if self.Power and self.State == -2 then self.State = -1 self.RestartTimer = CurTime()+6 end
		if self.State == -1 and CurTime()-self.RestartTimer > 0 then self.RestartTimer = CurTime()+8 self.State = 0 end
		if self.State == 0 and self.RestartTimer and CurTime()-self.RestartTimer > 0 then
			self.State = 1
			self.RestartTimer = nil
			self.F3 = false
			self.Timer = CurTime()
		end
		for k,v in pairs(self.TriggerNames) do
			if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
				self:Trigger(v,Train[v].Value > 0.5)
				self.Triggers[v] = Train[v].Value > 0.5
			end
		end			
		Train:SetNW2Bool("80km",self.Timer and CurTime()-self.Timer < 1)
		Train:SetNW2Int("SpeedometerState",self.State)
		--if self.State == 0 then
			Train:SetNW2String("BMCISTime1",os.date("%H %M",Metrostroi.GetSyncTime()))	
			Train:SetNW2Int("BMCISSpeed",math.floor(Train.Speed+0.8))
			Train:SetNW2Int("BMCISSpeedAng",Train.Speed*10)	
			Train:SetNW2Bool("BMCISDoors",Train.BUKP.DoorClosed)
			Train:SetNW2Bool("BMCISBARS",(Train.RV.KRRPosition ~= 0 or Train.RV.KROPosition ~= 0) and not Train:GetNW2Bool("DisableDrive",false) and (Train.BUKP.State == 5 or Train.BUKP.State <= 0))
			Train:SetNW2Bool("BMCISBTB",Train.BUV.BTB)
			Train:SetNW2Bool("BMCISEmergency",Train.BUV.States.EmergencyBrakeGood and Train.Pneumatic.EmergencyBrakeActive and (Train.RV.KRRPosition ~= 0 or Train.RV.KROPosition ~= 0))			
			Train:SetNW2Bool("BMCISLN",Train.BARS.LN)
			if Train.BARS.Active == 0 or Train.RV.KRRPosition ~= 0 then
				Train:SetNW2Bool("BMCISBARS1", Train.BUKP.err > 0 and (Train.SF5.Value > 0.5 or Train.Panel.Controller <= 0) or Train.BUKP.State < 5) --"АРС"
				Train:SetNW2Bool("BMCISBARS2", Train.BUKP.err > 0 and (Train.SF4.Value > 0.5 or Train.Panel.Controller <= 0) or Train.BUKP.State < 5) --"АРС"					
			else
				Train:SetNW2Bool("BMCISBARS1",--[[Train.Pneumatic.BrakeCylinderPressure > 0.1 and]] (Train.BARS.PN1 == 1) and Train.SF5.Value > 0.5)--or Train.BUV.BARSBrakeTimer or BARS.Brake == 1)) --"АРС"
				Train:SetNW2Bool("BMCISBARS2",--[[Train.Pneumatic.BrakeCylinderPressure > 0.1 and]] (Train.BARS.PN1 == 1) and Train.SF4.Value > 0.5)--or Train.BUV.BARSBrakeTimer or BARS.Brake == 1)) --"АРС"	
			end			
		--end
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
	createFont("Monitor","Helvetica",34,0,0,0,false)
	createFont("MonitorA","Helvetica",70,0,0,0,false)	
	createFont("MonitorB","Helvetica",38,0,0,0,false)	
	createFont("MonitorC","Helvetica",44,1000,0,0,false)	
	local arrow = surface.GetTextureID("bmcis/cis_white_parts/arrow")
	local speedometer = surface.GetTextureID("bmcis/cis_1")
	local red_lamps = surface.GetTextureID("bmcis/red_lamps")
	local lamps_half = surface.GetTextureID("bmcis/lamps_half")
	local lamps_full = surface.GetTextureID("bmcis/lamps_full")
	local glass_heating = surface.GetTextureID("bmcis/glass_heating")
	local wiper = surface.GetTextureID("bmcis/wiper")
	local red0_20 = surface.GetTextureID("bmcis/red0_20")
	local red20_40 = surface.GetTextureID("bmcis/red20_40")
	local red40_60 = surface.GetTextureID("bmcis/red40_60")
	local red60_70 = surface.GetTextureID("bmcis/red60_70")
	local red70_80 = surface.GetTextureID("bmcis/red70_80")
	local red80_100 = surface.GetTextureID("bmcis/red80_100")
	local yellow0_20 = surface.GetTextureID("bmcis/yellow0_20")
	local yellow20_40 = surface.GetTextureID("bmcis/yellow20_40")
	local yellow40_60 = surface.GetTextureID("bmcis/yellow40_60")
	local yellow60_70 = surface.GetTextureID("bmcis/yellow60_70")
	local yellow70_80 = surface.GetTextureID("bmcis/yellow70_80")
	local triangle = surface.GetTextureID("bmcis/cis_white_parts/triangle")
	local green_arrow = surface.GetTextureID("bmcis/cis_white_parts/green_arrow")
	local cis_load = surface.GetTextureID("bmcis/cis_load")	
	local cis_1_info = surface.GetTextureID("bmcis/cis_1_info")
	
	local tbltex = {
		["0_20"] = surface.GetTextureID("bmcis/cis_white_parts/0_20"),
		["20_40"] = surface.GetTextureID("bmcis/cis_white_parts/20_40"),
		["40_60"] = surface.GetTextureID("bmcis/cis_white_parts/40_60"),
		["60_70"] = surface.GetTextureID("bmcis/cis_white_parts/60_70"),
		["70_80"] = surface.GetTextureID("bmcis/cis_white_parts/70_80"),
		["80_100"] = surface.GetTextureID("bmcis/cis_white_parts/80_100"),
		["35_100"] = surface.GetTextureID("bmcis/cis_white_parts/35_100"),
		["0_35"] = surface.GetTextureID("bmcis/cis_white_parts/0_35"),
	}
	local paramtex = {
		["0_20"] = {62,412,64,256},--{62,407,64,256},
		["20_40"] = {158,271,256,256},--{157,246,256,256},
		["40_60"] = {294,179,256,64},
		["60_70"] = {403,183,128,64},
		["70_80"] = {485,235,128,128},
		["80_100"] = {558,341,128,256},
		["35_100"] = {377,357,512,512},
	}

	function TRAIN_SYSTEM:ClientThink()
		if not self.Train:ShouldDrawPanel("Speedometer") then return end
        if not self.DrawTimer then
			render.PushRenderTarget(self.Train.Speedometer,0,0,1024,1024)
            render.Clear(0, 0, 0, 0)
            render.PopRenderTarget()
        end
        if self.DrawTimer and CurTime()-self.DrawTimer < 0.1 then return end
        self.DrawTimer = CurTime()
		
		render.PushRenderTarget(self.Train.Speedometer,0,0,1024,1024)
		render.Clear(0, 0, 0, 0)
		cam.Start2D()
			surface.SetDrawColor(255,255,255)
			--surface.DrawRect(0,0,800,600)
			self:Speedometer(self.Train)
		cam.End2D()
		render.PopRenderTarget()
	end
	
	local red = Color(177,20,20)
	local red2 = Color(180,20,20)
	local yellow2 = Color(235,215,0)
	local green = Color(80,225,85)--Color(100,200,150)
	local blue = Color(120,200,210)
	local yellow = Color(225,220,30)
	local white = Color(255,255,255)
	local font = "Metrostroi_760_Monitor"
	function TRAIN_SYSTEM:Speedometer(Train)
		local state = Train:GetNW2Int("SpeedometerState",-1)
		if state == 0 then
			surface.SetDrawColor(255,255,255)
			surface.SetTexture(cis_load)
			surface.DrawTexturedRectRotated(542,629,1024,1024,0)	
		elseif state == 1 then
			surface.SetDrawColor(255,255,255)
			surface.SetTexture(speedometer)
			surface.DrawTexturedRectRotated(542,629,1024,1024,0)	
			
			local RezhimARS = Train:GetPackedBool("SA14") and "2/6" or (Train:GetNW2Bool("STL",false) and "ДАУ" or "1/5")			
			local SpeedAng = Train:GetNW2Bool("80km",false) and 80 or Train:GetNW2Int("BMCISSpeedAng",0)/10			
			local speedl = Train.BUKP.SpeedLimit or 0			
			local speed = Train:GetNW2Bool("80km",false) and 80 or math.floor(Train:GetNW2Int("BMCISSpeed",0))
			local Time = Train:GetNW2String("BMCISTime1","00 00")
			draw.SimpleText(Time,font.."B",326,480,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)--326 480
			if CurTime()%2 < 1 then
				draw.SimpleText(":",font.."B",326,478,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)--326 480		
			end
			local speedln
			if (RezhimARS == "2/6" or RezhimARS == "ДАУ") --[[and Train.BUKP.SpeedLimitNext]] and Train.BUKP.SpeedLimitNext ~= -1 then
				speedln = Train.BUKP.SpeedLimitNext or 0
			end
			--print(speedln)
			surface.SetDrawColor(red2)
			surface.SetTexture(arrow)
			local mat1 = Matrix()
			mat1:Translate(Vector(311,430,0))--365 425
			mat1:Rotate(Angle(0,-105+1.95*SpeedAng,0))
			mat1:Translate(Vector(0,-72.5,0))		
			cam.PushModelMatrix(mat1)
			surface.DrawTexturedRectRotated(0,0,64,512,0)
			cam.PopModelMatrix()	
			surface.SetDrawColor(255,255,255)

			if speedl == 35 then
				if speedln and speedln == 0 then
					surface.SetDrawColor(yellow2)
					surface.SetTexture(tbltex["0_35"])		
					surface.DrawTexturedRectRotated(97,357,128,512,0)	
				end
				surface.SetDrawColor(red2)
				surface.SetTexture(tbltex["35_100"])		
				surface.DrawTexturedRectRotated(377,357,512,512,0)
			else
				surface.SetDrawColor(red2)--235,215
				surface.SetTexture(tbltex["80_100"])
				surface.DrawTexturedRectRotated(558,341,128,256,0)
				if speedl >= 19 and speedl <= 21 then
					speedln = 0
				elseif speedl == 0 then
					speedln = nil
				end
				local s = speedln or speedl
				for i=80,math.max(70,s+10),-10 do
					local str = tostring(i-10).."_"..tostring(i)
					if speedln and i == speedl then
						surface.SetDrawColor(yellow2)
					end					
					surface.SetTexture(tbltex[str])
					surface.DrawTexturedRectRotated(paramtex[str][1],paramtex[str][2],paramtex[str][3],paramtex[str][4],0)				
				end		
				for i=60,math.max(20,s+20),-20 do
					local str = tostring(i-20).."_"..tostring(i)
					if speedln and i == speedl then
						surface.SetDrawColor(yellow2)
					end	
					surface.SetTexture(tbltex[str])
					surface.DrawTexturedRectRotated(paramtex[str][1],paramtex[str][2],paramtex[str][3],paramtex[str][4],0)				
				end			
			end			
			draw.SimpleText(math.Round(speed),font.."A",565,475,(math.Round(speed) > speedl) and red or (speedln and math.Round(speed) <=speedl and math.Round(speed) > speedln) and yellow or green,TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)--Color(117,255,100)
	
			surface.SetDrawColor(green)	
			surface.SetTexture(triangle)
			surface.DrawTexturedRectRotated(70,494,32,64,105)				

			surface.SetDrawColor(Train:GetPackedBool("BacklightsEnabled") and Color(160,0,0) or Color(255,255,255))
			surface.SetTexture(red_lamps)
			surface.DrawTexturedRectRotated(535,212,64,32,0)
			surface.SetDrawColor((Train:GetPackedBool("HeadlightsEnabled1") or Train:GetPackedBool("HeadlightsEnabled2")) and Color(0,160,0) or Color(255,255,255))
			surface.SetTexture(lamps_half)
			surface.DrawTexturedRectRotated(595,210,64,32,0)
			surface.SetDrawColor(Train:GetPackedBool("HeadlightsEnabled2") and Color(160,160,0) or Color(255,255,255))
			surface.SetTexture(lamps_full)
			surface.DrawTexturedRectRotated(640,212,64,32,0)
			surface.SetDrawColor(Train:GetPackedBool("GlassHeating") and Color(0,160,0) or Color(255,255,255))
			surface.SetTexture(glass_heating)
			surface.DrawTexturedRectRotated(590,277,64,32,0)
			surface.SetDrawColor(Train:GetPackedBool("Wiper") and Color(160,160,0) or Color(255,255,255))
			surface.SetTexture(wiper)
			surface.DrawTexturedRectRotated(635,278,64,32,0)
			
			draw.SimpleText("ДВЕРИ",font,160,150,Train:GetNW2Bool("BMCISDoors",false) and green or red,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)--160 150
			if Train.BUKP and Train.BUKP.State > 0 then
				draw.SimpleText(Train:GetNW2Bool("VityazUOS",false) and "УОС" or Train:GetNW2Bool("VityazAB",false) and "АБ" or RezhimARS,font,74,150,yellow,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			draw.SimpleText("БТБ",font,475,150,Train:GetNW2Bool("BMCISBTB",false) and red or green,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("АРС1",font,545,150,Train:GetNW2Bool("BMCISBARS",false) and (Train:GetNW2Bool("BMCISBARS1",false) and red or green) or yellow,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("АРС2",font,620,150,Train:GetNW2Bool("BMCISBARS",false) and (Train:GetNW2Bool("BMCISBARS2",false) and red or green) or yellow,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			
			local KRO = (Train:GetPackedRatio("KRO",0)-0.5)*2
			local KRR = (Train:GetPackedRatio("KRR",0)-0.5)*2
			surface.SetDrawColor(green)
			if Train:GetNW2Bool("BIForward",false) and not Train:GetNW2Bool("BIBack",false) or Train:GetNW2Bool("80km",false) then
				--draw.SimpleText("⬆",font.."A",627,467,green,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				surface.SetTexture(green_arrow)
				surface.DrawTexturedRectRotated(627,473,32,32,0)
			elseif Train:GetNW2Bool("BIBack",false) and not Train:GetNW2Bool("BIForward",false) then
				--draw.SimpleText("⬇",font.."A",627,467,green,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				surface.SetTexture(green_arrow)
				surface.DrawTexturedRectRotated(627,473,32,32,180)	
			end
			surface.SetDrawColor(255,255,255) 			
			if Train:GetNW2Bool("BMCISEmergency",false) then--and (KRO ~= 0 or KRR ~= 0) then
				draw.SimpleText("ЭТ",font.."C",626,407,red,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)	
			end
			if Train:GetNW2Bool("BMCISLN",false) and (KRO ~= 0 or KRR ~= 0) then--?
				draw.SimpleText("Н",font,111,216,green,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)			
			end
			if Train.BUKP.AO then
				draw.SimpleText("АО",font,70,216,red,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)					
			end
			if (KRO ~= 0 or KRR ~= 0) and not Train.BUKP.AO and (Train:GetNW2Int("VityazSpeedLimit",0) == 19 --[[or Train:GetNW2Int("VityazSpeedLimitNext",0) == -1]]) then-- not Train:GetNW2Bool("ALS",false) then
				draw.SimpleText("ОЧ",font,70,216,red,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)								
			end
			if (KRO ~= 0 or KRR ~= 0) and Train:GetNW2Bool("RS",false) and Train:GetNW2Int("VityazSpeedLimit",0) > 21 and not Train.BUKP.AO then
				draw.SimpleText("РС",font,70,216,green,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)											
			end
			
			if Train:GetNW2Bool("BMCISF3",false) then
				surface.SetTexture(cis_1_info)
				surface.DrawTexturedRectRotated(348,358,512,256,0)	
			end
		end
	end
end
