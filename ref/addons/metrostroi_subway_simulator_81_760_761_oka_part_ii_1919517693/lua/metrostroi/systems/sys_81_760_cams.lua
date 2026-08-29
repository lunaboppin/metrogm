--------------------------------------------------------------------------------
-- БВК-М
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_760_CAMS")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.State = -1
	self.Selected = 0
	
	self.Train:LoadSystem("CAMS1","Relay","Switch",{bass=true})
	self.Train:LoadSystem("CAMS2","Relay","Switch",{bass=true})
	self.Train:LoadSystem("CAMS3","Relay","Switch",{bass=true})
	self.Train:LoadSystem("CAMS4","Relay","Switch",{bass=true})	
	self.Train:LoadSystem("CAMS5","Relay","Switch",{bass=true})
	self.Train:LoadSystem("CAMS6","Relay","Switch",{bass=true})
	self.Train:LoadSystem("CAMS7","Relay","Switch",{bass=true})
	self.Train:LoadSystem("CAMS8","Relay","Switch",{bass=true})
	self.Train:LoadSystem("CAMS9","Relay","Switch",{bass=true})
	self.Train:LoadSystem("CAMS10","Relay","Switch",{bass=true})
	
	self.TriggerNames = {
		"CAMS1",
		"CAMS2",
		"CAMS3",
		"CAMS4",
		"CAMS5",
		"CAMS6",
		"CAMS7",
		"CAMS8",
		"CAMS9",
		"CAMS10",		
	}

	self.Triggers = {}
	for k,v in pairs(self.TriggerNames) do
		if self.Train[v] then self.Triggers[v] = self.Train[v].Value > 0.5 end
	end
	--self.Brightness = 100
		
	self.Tbl = {
		[ 5] = {
			[1] = {false,true},
			[2] = {true,false},
		},
		[ 6] = {
			[1] = {false,false},
			[2] = {true,true},
		},
		[ 7] = {
			[1] = {false,false},
			[2] = {true,false},
		},
		[ 8] = {
			[1] = {false,true},
			[2] = {true,true},
		},				
		[ 9] = {
			[1] = {true,false},
		},
		[10] = {
			[1] = {false,false},
		},
	}	
	self.StateTimer = CurTime()
	self.LastEntered = 0
	
	--self.Cam1,self.Cam1E = true,self.Train
	--self.Train:SetNW2Bool("CAMSCam1Pos",false)
	--self.Cam2,self.Cam2E = true,self.Train
	--self.Train:SetNW2Bool("CAMSCam2Pos",true)
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
	function TRAIN_SYSTEM:Trigger(name,value)
		local name = name:gsub("CAMS","")
		local Train = self.Train
		--[[
		if value then
			if name == "1" then
				self.Brightness = math.min(100,self.Brightness + 5)
			end
			if name == "2" then
				self.Brightness = math.max(0,self.Brightness - 5)
			end
		end
		]]
		if self.State >= 0 then
			local numname = tonumber(name) or 0
			if value then
				local WagNum = Train:GetNW2Int("CAMSWagNum")
				if numname >= 5 and (self.LastEntered ~= numname) then
					self.Cam1,self.Cam1E = CurTime()+math.Rand(0.8,2),(self.Tbl[numname][1][2] and Train.WagonList[WagNum] or Train)
					self.Cam2 = false
					Train:SetNW2Bool("CAMSCam1Pos",self.Tbl[numname][1][1])
					Train:SetNW2Entity("CAMSCam2E",nil)
					if self.Tbl[numname][2] then
						self.Cam2,self.Cam2E = self.Cam1,(self.Tbl[numname][2][2] and Train.WagonList[WagNum] or Train)
						Train:SetNW2Entity("CAMSCam2E",self.Cam2E)
						Train:SetNW2Bool("CAMSCam2Pos",self.Tbl[numname][2][1])
					end
					self.Selected = 0
					if self.State ~= 0 then self.State = 0 end
					self.LastEntered = numname				
				end
				if numname == 3 and self.Selected > 0 then
					if self.LastEntered ~= self.Selected then
						self.Cam4,self.Cam4E = CurTime()+math.Rand(0.8,2),Train.WagonList[math.min(self.Selected,WagNum)]
						Train:SetNW2Entity("CAMSCam4E",self.Cam4E)
						self.Cam5,self.Cam6,self.Cam7 = false,false,false
						Train:SetNW2Entity("CAMSCam5E",nil)
						if self.Selected <= WagNum then
							Train:SetNW2Entity("CAMSCam5E",Train.WagonList[self.Selected])
							self.Cam5,self.Cam5E = CurTime()+math.Rand(0.8,2),Train.WagonList[self.Selected]
							self.Cam6,self.Cam6E = CurTime()+math.Rand(0.8,2),Train.WagonList[self.Selected]
							self.Cam7,self.Cam7E = CurTime()+math.Rand(0.8,2),Train.WagonList[self.Selected]
						else
							self.Cam5E = false
							self.Cam6E = false
							self.Cam7E = false
						end
					end
					self.LastSelected = self.Selected
					self.LastEntered = self.Selected
					self.Selected = 0
					self.State = 1
				end
				if numname == 4 then
					self.Selected = self.LastSelected or (self.Selected >= (WagNum+(Train:GetNW2Bool("CAMSLast",false) and 1 or 0)) and 1 or self.Selected + 1)
					self.LastSelected = nil
				end
			end
		end
	end
	function TRAIN_SYSTEM:Think(dT)
		local Train = self.Train
		self.Power = Train.Electric.Battery80V > 62 and Train.SF19.Value > 0.5
		if not self.Power and self.State ~= -4 then self.LastEntered = 0 self.Selected = 0 self.State = -4 self.StateTimer = nil end
		--if self.State == -4 and not self.Power then self.StateTimer = CurTime()+math.Rand(10,12) end
		if self.State == -4 and self.Power then self.State = -3 self.StateTimer = CurTime()+math.Rand(7,9) end
		if self.Power and self.State == -3 and CurTime()-self.StateTimer > 0 then
			self.State = -2
			self.StateTimer = CurTime()+math.Rand(9,11)
		end
		if self.Power and self.State == -2 and CurTime()-self.StateTimer > 0 then
			self.State = -1
			self.StateTimer = CurTime()+math.Rand(17,19)
		end
		if self.State == -1 and CurTime()-self.StateTimer > 0 then
			self.State = 0
			self:Trigger("5",true)

			--self.StateTimer = nil
			--self.LastSelected = nil
			--self.LastEntered = 5
			if Train:GetNW2Int("CAMSWagNum",0) == 0 then
				local wagn = math.min(8,#Train.WagonList)
				Train:SetNW2Int("CAMSWagNum",wagn)
				Train:SetNW2Bool("CAMSLast",Train.WagonList[wagn].WagonNumber > 37000)
			end
			if self.Inv == nil then
				self.Inv = Train:GetWagonNumber() > Train.WagonList[#Train.WagonList]:GetWagonNumber()
				Train:SetNW2Bool("CAMSInv",Train:GetWagonNumber() > Train.WagonList[#Train.WagonList]:GetWagonNumber())
			end

		end
		for k,v in pairs(self.TriggerNames) do
			if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
				self:Trigger(v,Train[v].Value > 0.5)
				self.Triggers[v] = Train[v].Value > 0.5
			end
		end
		if self.State == 0 then
			local cam1,cam2 = false,false
			for i=1,#Train.WagonList do
				local train = Train.WagonList[i]
				if train.SF54 and train.Battery.Value*train.SF54.Value*(train.Electric.KM2 and train.Electric.KM2 or 1)  == 1 then
					if self.Cam1E == train then cam1 = true end
					if self.Cam2E == train then cam2 = true end
				end
			end
			if self.Cam1 == true and (not IsValid(self.Cam1E) or not cam1) then self.Cam1 = false end		
			if self.Cam1 == true then
				Train:SetNW2Bool("CAMSCam1C",true)
				Train:SetNW2Entity("CAMSCam1E",self.Cam1E)
			else
				if self.Cam1 and self.Cam1 ~= true and CurTime()-self.Cam1 > 0 then self.Cam1 = true end
				if not self.Cam1 and cam1 then self.Cam1 = CurTime()+math.Rand(0.8,2) end
				Train:SetNW2Bool("CAMSCam1C",false)
			end
			if self.Cam2 == true and (self.LastEntered > 8 or not IsValid(self.Cam2E) or not cam2) then self.Cam2 = false end		
			if self.Cam2 == true then
				Train:SetNW2Bool("CAMSCam2C",true)
				Train:SetNW2Entity("CAMSCam2E",self.Cam2E)
			else
				if self.Cam2 and self.Cam2 ~= true and CurTime()-self.Cam2 > 0 then self.Cam2 = true end
				if not self.Cam2 and cam2 then self.Cam2 = CurTime()+math.Rand(0.8,2) end
				Train:SetNW2Bool("CAMSCam2C",false)
			end		
		end
		if self.State == 1 then
			local cam4,cam5,cam6,cam7 = false,false,false,false
			for i=1,#Train.WagonList do
				local train = Train.WagonList[i]
				if train.SF54 and train.Battery.Value*train.SF54.Value*(train.Electric.KM2 and train.Electric.KM2 or 1) == 1 then
					if self.Cam4E == train then cam4 = true end
					if self.Cam5E == train then cam5 = true end
					if self.Cam6E == train then cam6 = true end
					if self.Cam7E == train then cam7 = true end
				end
			end
			if self.Cam4 == true and (not IsValid(self.Cam4E) or not cam4) then self.Cam4 = false end		
			if self.Cam4 == true then
				Train:SetNW2Bool("CAMSCam4C",true)
				Train:SetNW2Entity("CAMSCam4E",self.Cam4E)
			else
				if self.Cam4 and self.Cam4 ~= true and CurTime()-self.Cam4 > 0 then self.Cam4 = true end
				if not self.Cam4 and cam4 then self.Cam4 = CurTime()+math.Rand(0.8,2) end
				Train:SetNW2Bool("CAMSCam4C",false)
			end
			if self.Cam5 == true and (not IsValid(self.Cam5E) or not cam5) then self.Cam5 = false end		
			if self.Cam5 == true then
				Train:SetNW2Bool("CAMSCam5C",true)
				Train:SetNW2Entity("CAMSCam5E",self.Cam5E)
			else
				if self.Cam5 and self.Cam5 ~= true and CurTime()-self.Cam5 > 0 then self.Cam5 = true end
				if not self.Cam5 and cam5 then self.Cam5 = CurTime()+math.Rand(0.8,2) end				
				Train:SetNW2Bool("CAMSCam5C",false)
			end
			if self.Cam6 == true and (not IsValid(self.Cam6E) or not cam6) then self.Cam6 = false end		
			if self.Cam6 == true then
				Train:SetNW2Bool("CAMSCam6C",true)
				Train:SetNW2Entity("CAMSCam6E",self.Cam6E)
			else
				if self.Cam6 and self.Cam6 ~= true and CurTime()-self.Cam6 > 0 then self.Cam6 = true end
				if not self.Cam6 and cam6 then self.Cam6 = CurTime()+math.Rand(0.8,2) end								
				Train:SetNW2Bool("CAMSCam6C",false)
			end
			if self.Cam7 == true and (not IsValid(self.Cam7E) or not cam7) then self.Cam7 = false end		
			if self.Cam7 == true then
				Train:SetNW2Bool("CAMSCam7C",true)
				Train:SetNW2Entity("CAMSCam7E",self.Cam7E)
			else
				if self.Cam7 and self.Cam7 ~= true and CurTime()-self.Cam7 > 0 then self.Cam7 = true end
				if not self.Cam7 and cam7 then self.Cam7 = CurTime()+math.Rand(0.8,2) end												
				Train:SetNW2Bool("CAMSCam7C",false)
			end		
		end
		
		Train:SetNW2Int("CAMSState",self.State)	
		Train:SetNW2Int("CAMSSelected",self.Selected)	
		Train:SetNW2Int("CAMSLastSelected",self.LastSelected or 0)
		Train:SetNW2Int("CAMSLastEntered",self.LastEntered or 0)
		Train:SetNW2Int("CAMSTimer",self.StateTimer and (CurTime()-self.StateTimer)*20 or 0)
		--Train:SetNW2Int("CAMSBrightness",self.Brightness)		
	end
else
	local function createFont(name,font,size,weight,blur,scanlines,underline)
		surface.CreateFont("Metrostroi_760_"..name, {
			font = font,
			size = size,
			weight = weight or 400,
			blursize = blur or false,
			antialias = true,--(name ~= "CAMS2"),
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
	createFont("CAMS","Arial",38,0,0,0,false)
	createFont("CAMS1","Arial",26,0,0,0,false)
	createFont("CAMS3","Arial",30,601,0,0,false)
	createFont("CAMS2","TerminessTTF NF",20,0,0,0,false)
	
	local cam_icons_default = surface.GetTextureID("bvk-m/cam_icon_default")
	local cam_icons_head_default = surface.GetTextureID("bvk-m/cam_icon_head")
	local cam_icons_head_select = surface.GetTextureID("bvk-m/cam_icons_head_select")
	local cam_icons_select = surface.GetTextureID("bvk-m/cam_icon_select")
	local cam_icons_tail_default = surface.GetTextureID("bvk-m/cam_icon_tail")
	local cam_icons_tail_select = surface.GetTextureID("bvk-m/cam_icon_tail_select")
	local camera_preset_icon = surface.GetTextureID("bvk-m/cam_icon_preset")
	local linux_logo = surface.GetTextureID("bvk-m/linux_logo")
	local camera_preset_set_icon = surface.GetTextureID("bvk-m/cam_icon_preset_select")
	
	local tbl = {
		[ 5] = {
			[1] = {-1,-1},
			[2] = {-1, 1},
		},
		[ 6] = {
			[1] = { 1,-1},
			[2] = { 1, 1},
		},
		[ 7] = {
			[1] = {-1,-1},
			[2] = { 1,-1},
		},
		[ 8] = {
			[1] = {-1, 1},
			[2] = { 1, 1},
		},				
		[ 9] = {
			[1] = {-1,-1},
		},
		[10] = {
			[1] = { 1,-1},
		},
	}
	
    function TRAIN_SYSTEM:ClientInitialize()
	
        self.Cam1 = self.Train:CreateRT("760CAMSC1",1024,768,true)
        self.Cam2 = self.Train:CreateRT("760CAMSC2",512,768,true)
        self.Cam3 = self.Train:CreateRT("760CAMSC3",512,768,true)
		
		self.Cam4 = self.Train:CreateRT("760CAMSC4",512,384,true)
		self.Cam5 = self.Train:CreateRT("760CAMSC5",512,384,true)
		self.Cam6 = self.Train:CreateRT("760CAMSC6",512,384,true)
		self.Cam7 = self.Train:CreateRT("760CAMSC7",512,384,true)
		
		self.scalex,self.scaley = ScrW()/1024,ScrH()/661 --ScrW()/1768*1.725,ScrH()/992*1.5 
		
		--self.scalex,self.scaley = ScrW()/1768*1.725,ScrH()/992*1.5 
    end
    local CamRT = surface.GetTextureID( "pp/rt" )
    local CamRTM = Material( "pp/rt" )
    local CamsPos = Vector(477,34,-14)
    function TRAIN_SYSTEM:ClientThink()
		if not self.Train:ShouldDrawPanel("CAMS") then return end
		self.scalex,self.scaley = ScrW()/1024,ScrH()/661 --ScrW()/1768*1.725,ScrH()/992*1.5 
	
        local train = self.Train
		local lastenter = train:GetNW2Int("CAMSLastEntered",0) > 8
        local state = train:GetNW2Int("CAMSState",0)
        --local camstate = train:GetNW2Int("CAMSCamState",1)
		--local brightness = train:GetNW2Int("CAMSBrightness",100)
        if state == 0 then
			local Cam1,Cam1E,Cam1Pos = train:GetNW2Bool("CAMSCam1C"),train:GetNW2Entity("CAMSCam1E"),train:GetNW2Bool("CAMSCam1Pos",false)
			local Cam2,Cam2E,Cam2Pos = train:GetNW2Bool("CAMSCam2C"),train:GetNW2Entity("CAMSCam2E"),train:GetNW2Bool("CAMSCam2Pos",false)		
			
            if Cam1 and not Cam2 and lastenter then
				Metrostroi.RenderCamOnRT(train,CamsPos,"Cam1",math.Rand(0.2,0.5),self.Cam1,Cam1E,Vector(445,-69,22)+(Cam1Pos and Vector(0,144,0) or Vector(0,0,0)),Angle(5,180,0),1024,768,1,1,1)
			end

			--[[
            if Cam1 and Cam2 then
				Metrostroi.RenderCamOnRT(train,CamsPos,"Cam3",math.Rand(0.2,0.5),self.Cam2,Cam1E,Vector(445,-74,22)+(Cam1Pos and Vector(0,144,0) or Vector(0,0,0)),Angle(5,180,0),512,768,1,1,1)
				Metrostroi.RenderCamOnRT(train,CamsPos,"Cam2",math.Rand(0.2,0.5),self.Cam3,Cam2E,Vector(445,-69,22)+(Cam2Pos and Vector(0,144,0) or Vector(0,0,0)),Angle(5,180,0),512,768,1,1,1)
			end]]
            if Cam1 then
				Metrostroi.RenderCamOnRT(train,CamsPos,"Cam3",math.Rand(0.2,0.5),self.Cam2,Cam1E,Vector(445,-74,22)+(Cam1Pos and Vector(0,144,0) or Vector(0,0,0)),Angle(5,180,0),512,768,1,1,1)
			end
			if Cam2 then
				Metrostroi.RenderCamOnRT(train,CamsPos,"Cam2",math.Rand(0.2,0.5),self.Cam3,Cam2E,Vector(445,-69,22)+(Cam2Pos and Vector(0,144,0) or Vector(0,0,0)),Angle(5,180,0),512,768,1,1,1)
			end		
        end
		if state == 1 then
			local WagNum = train:GetNW2Int("CAMSWagNum",0)
			local Cam4,Cam4E = train:GetNW2Bool("CAMSCam4C"),train:GetNW2Entity("CAMSCam4E")
			local Cam5,Cam5E = train:GetNW2Bool("CAMSCam5C"),train:GetNW2Entity("CAMSCam5E")
			local Cam6,Cam6E = train:GetNW2Bool("CAMSCam6C"),train:GetNW2Entity("CAMSCam6E")
			local Cam7,Cam7E = train:GetNW2Bool("CAMSCam7C"),train:GetNW2Entity("CAMSCam7E")
			if IsValid(Cam5E) then
				if Cam4 then
					Metrostroi.RenderCamOnRT(train,CamsPos,"Cam4",math.Rand(0.2,0.5),self.Cam4,Cam4E,Vector(447+(Cam5E.SubwayTrain.WagType == 1 and -70 or 0),0,50),Angle(29,180,0),1024,768,1.7,210,1)						
				end
				if Cam5 then
					Metrostroi.RenderCamOnRT(train,CamsPos,"Cam5",math.Rand(0.2,0.5),self.Cam5,Cam5E,Vector(-452+(Cam5E.SubwayTrain.WagType == 1 and 35 or 0),0,50),Angle(29,0,0),1024,768,1.7,210,1)						
				end
				if Cam6 then
					Metrostroi.RenderCamOnRT(train,CamsPos,"Cam6",math.Rand(0.2,0.5),self.Cam6,Cam6E,Vector(-75,-50,50),Angle(18,110,0),1024,768,1.4,32,1)						
				end
				if Cam7 then
					Metrostroi.RenderCamOnRT(train,CamsPos,"Cam7",math.Rand(0.2,0.5),self.Cam7,Cam7E,Vector(75,50,50),Angle(18,-70,0),1024,768,1.4,32,1)						
				end
			end
			if Cam4 and not IsValid(Cam5E) then
				Metrostroi.RenderCamOnRT(train,CamsPos,"Cam3",math.Rand(0.2,0.5),self.Cam3,Cam4E,Vector(454,59.5,53),Angle(65,-90,0),1024,768,1.4,1,1)						
			end
		end

		if state == -4 then
			render.PushRenderTarget(self.Train.CAMS,0,0,1024,768)
			render.Clear(0, 0, 0, 0)
			render.PopRenderTarget()	
			return
		end

		if self.state ~= -3 then	
			render.SetColorMaterial(0,0,0) 
			render.PushRenderTarget(self.Train.CAMS,0,0,1024,768)
			render.Clear(0, 0, 0, 0)
			cam.Start2D()
				if state ~= -4 then
					surface.SetDrawColor(0,0,0)
					surface.DrawRect(0,0,1024,768)
				end
				self:CAMS(self.Train)	
			cam.End2D()
			render.PopRenderTarget()
		end
		self.state = state
	end
	local blue = Color(0,50,255)
	local white = Color(255,255,255)
	local font = "Metrostroi_760_CAMS"
	function TRAIN_SYSTEM:CAMS(Train)
		local scx,scy = self.scalex,self.scaley
		local state = Train:GetNW2Int("CAMSState",0)
		local sel = Train:GetNW2Int("CAMSSelected",0)
		local wagnum = Train:GetNW2Int("CAMSWagNum",0)
		local statetimer = Train:GetNW2Int("CAMSTimer",0)/20
		local lastenter = Train:GetNW2Int("CAMSLastEntered",0) > 8
		--RunConsoleCommand("say",statetimer)
		if state == -4 then
			return
		end
		--state = -3
		surface.SetDrawColor(Color(255,255,255))		
		if state == -3 then
			surface.SetDrawColor(white)
			surface.DrawRect(0,0,200,768)
			surface.DrawRect(600,0,280,768)
			for i=1,10 do
				Metrostroi.DrawLine(720+i,0,720+i,768,Color(255*math.random(),255*math.random(),255*math.random()),1)			
			end
			for i=1,40 do
				Metrostroi.DrawLine(840+i,0,840+i,768,Color(255*math.random(),255*math.random(),255*math.random()),1)
			end
			--draw.SimpleText("полосочки",font,512,368,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)	
		elseif state == -2 then
			--draw.SimpleText("пингивинчики",font,512,368,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)	
			surface.SetTexture(linux_logo)
			surface.DrawTexturedRectRotated(60,64,128,128,0)
			surface.DrawTexturedRectRotated(158,64,128,128,0)
		
		elseif state == -1 then
			--for i=1,48 do
				--draw.SimpleText(i,font.."2",15,0+i*16,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)	
			--end
			local y = 16
			if statetimer > -5.2 then
				draw.SimpleText("Ubuntu 12.04.1 LTS variscite-desktop tty1",font.."2",5,16,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				draw.SimpleText("variscite-desktop login: root (automatic login)",font.."2",5,48,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				draw.SimpleText("Last login: Sat Jan  3 23:26:26 MSK 2015 on tty1",font.."2",5,64,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				y=80
			end
			if statetimer > -4.2 then
				draw.SimpleText("Welcome to Ubuntu 12.04.1 LTS (GNU/Linux 3.4.0-1487-omap4 armv71)",font.."2",5,80,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				draw.SimpleText(" * Documentation:  https://help.ubuntu.com/",font.."2",5,112,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				draw.SimpleText("189 packages can be updated.",font.."2",5,144,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				draw.SimpleText("52 updates are security updates.",font.."2",5,160,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				y=176
			end
			--if statetimer > -3.9 then
				--draw.SimpleText("mount: special device /dev/sda1 does not exist",font.."2",5,192,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				--y=208
			--end
			if CurTime()%1 < 0.4 and statetimer > -5.36 then
				draw.SimpleText("_",font.."2",5,y,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
			end			
			--local text = 
		elseif state == 0 then	

			local LastEntered = Train:GetNW2Int("CAMSLastEntered",0)
			local Cam1,Cam1E,Cam1Pos = Train:GetNW2Bool("CAMSCam1C"),Train:GetNW2Entity("CAMSCam1E"),Train:GetNW2Bool("CAMSCam1Pos",false)
			local Cam2,Cam2E,Cam2Pos = Train:GetNW2Bool("CAMSCam2C"),Train:GetNW2Entity("CAMSCam2E"),Train:GetNW2Bool("CAMSCam2Pos",false)
			if IsValid(Cam2E) then
				draw.SimpleText("ПОДКЛЮЧЕНИЕ К КАМЕРЕ ...",font,256,384,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)	
				draw.SimpleText("ПОДКЛЮЧЕНИЕ К КАМЕРЕ ...",font,768,384,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			elseif not Cam1 then
				draw.SimpleText("ПОДКЛЮЧЕНИЕ К КАМЕРЕ ...",font,512,384,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			if not IsValid(Cam2E) then
				if Cam1 and not Cam2 and lastenter then
					render.DrawTextureToScreenRect(self.Cam1,scx*1024,0,-1024*scx,768*scy)				
				end				
			elseif Cam1 or Cam2 then
				if LastEntered == 8 then
					if Cam2 then render.DrawTextureToScreenRect(self.Cam3,scx*512,0,scx*512,scy*768) end				
					if Cam1 then render.DrawTextureToScreenRect(self.Cam2,0,0,scx*512,scy*768) end		
				elseif LastEntered == 6 then
					if Cam2 then render.DrawTextureToScreenRect(self.Cam3,scx*512,0,512*scx,768*scy) end
					if Cam1 then render.DrawTextureToScreenRect(self.Cam2,scx*512,0,-512*scx,768*scy) end
				else
					if Cam2 then render.DrawTextureToScreenRect(self.Cam3,scx*512,0,-512*scx,scy*768) end
					if Cam1 then render.DrawTextureToScreenRect(self.Cam2,scx*(1024+(LastEntered == 5 and -512 or 0)),0,-512*scx*(LastEntered == 5 and -1 or 1),768*scy) end
				end
			end
			if sel == 0 and (Cam1 or Cam2) then
				surface.SetDrawColor(white)
				surface.SetTexture(camera_preset_icon)
				surface.DrawTexturedRectRotated(105,120,64,128,0)

				surface.SetTexture(camera_preset_set_icon)
				surface.DrawTexturedRectUV(89+tbl[LastEntered][1][1]*18.5,104+tbl[LastEntered][1][2]*27.5,32,32,0,0,-tbl[LastEntered][1][1],-tbl[LastEntered][1][2],1)
				--surface.DrawTexturedRectUV(89+(Cam1Pos and -18.5 or 18.5)*(Train == Cam1E and 1 or -1),104+(Cam1Pos and -1 or 1)*(Train == Cam1E and -27.5 or 27.5)*(Train:GetNW2Int("CAMSLastEntered",0) == 9 and -1 or 1),32,32,0,0,(Cam1Pos and 1 or -1)*(Train == Cam1E and 1 or -1),Train == Cam1E and 1 or -1)

				if not lastenter then
					surface.SetTexture(camera_preset_set_icon)
					surface.DrawTexturedRectUV(89+tbl[LastEntered][2][1]*18.5,104+tbl[LastEntered][2][2]*27.5,32,32,0,0,-tbl[LastEntered][2][1],-tbl[LastEntered][2][2],1)					
					--surface.DrawTexturedRectUV(89+(Cam2Pos and -18.5 or 18.5)*(Train == Cam2E and 1 or -1),104+(Cam2Pos and -1 or 1)*(Train == Cam2E and 27.5 or -27.5),32,32,0,0,(Cam2Pos and 1 or -1)*(Train == Cam2E and 1 or -1),Train == Cam2E and 1 or -1)
				end
			end
			if statetimer > 0 and statetimer < 5 then
				surface.SetDrawColor(Color(88,90,104))
				surface.DrawRect(150,70,850,90)
				draw.SimpleText("Состояние БХД:",font.."3",176,80,Color(50,183,193),TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				draw.SimpleText("Дата/время БХД:",font.."3",176,115,Color(50,183,193),TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				draw.SimpleText("Ожидайте ...",font.."3",396,80,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				draw.SimpleText("Ожидайте ...",font.."3",396,115,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				surface.SetDrawColor(Color(255,255,255))
			end			
		elseif state == 1 then
			local Cam4,Cam4E = Train:GetNW2Bool("CAMSCam4C"),Train:GetNW2Entity("CAMSCam4E")
			local Cam5,Cam5E = Train:GetNW2Bool("CAMSCam5C"),Train:GetNW2Entity("CAMSCam5E")
			local Cam6,Cam6E = Train:GetNW2Bool("CAMSCam6C"),Train:GetNW2Entity("CAMSCam6E")
			local Cam7,Cam7E = Train:GetNW2Bool("CAMSCam7C"),Train:GetNW2Entity("CAMSCam7E")
			if IsValid(Cam5E) then
				draw.SimpleText("ПОДКЛЮЧЕНИЕ К КАМЕРЕ ...",font,256,192,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)	
				draw.SimpleText("ПОДКЛЮЧЕНИЕ К КАМЕРЕ ...",font,768,192,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)	
				draw.SimpleText("ПОДКЛЮЧЕНИЕ К КАМЕРЕ ...",font,256,576,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)	
				draw.SimpleText("ПОДКЛЮЧЕНИЕ К КАМЕРЕ ...",font,768,576,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			elseif not Cam4 then
				draw.SimpleText("ПОДКЛЮЧЕНИЕ К КАМЕРЕ ...",font,512,384,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)					
			end
			if IsValid(Cam5E) then
				local LastEntered = Train:GetNW2Int("CAMSLastEntered",0)
				local WagNumber = Cam4E:GetWagonNumber()			
				local id = Train:GetNW2Bool("CAMSInv",false) and wagnum-LastEntered or LastEntered-1
				local str = id ~= 0 and id or ""

				surface.SetDrawColor(2,2,2)--,230)
				if Cam4 then
					render.DrawTextureToScreenRect(self.Cam4,0,0,512*scx,331*scy) --400x250
					surface.DrawRect(0,0,512,40)				
					draw.SimpleText(WagNumber.."_"..str.."2",font.."1",5,20,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				end
				if Cam5 then
					render.DrawTextureToScreenRect(self.Cam5,0,331*scy,512*scx,331*scy) --384
					surface.DrawRect(0,384,512,40)
					draw.SimpleText(WagNumber.."_"..str.."3",font.."1",5,404,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				end
				if Cam6 then
					render.DrawTextureToScreenRect(self.Cam6,512*scx,0,512*scx,331*scy)
					surface.DrawRect(512,0,512,40)
					draw.SimpleText(WagNumber.."_"..str.."4",font.."1",517,20,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				end
				if Cam7 then
					render.DrawTextureToScreenRect(self.Cam7,512*scx,331*scy,512*scx,331*scy)
					surface.DrawRect(512,384,512,40)
					draw.SimpleText(WagNumber.."_"..str.."5",font.."1",517,404,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)				
				end
			elseif Cam4 and not IsValid(Cam5E) then
				local WagNumber = Cam4E:GetWagonNumber()			
			
				render.DrawTextureToScreenRect(self.Cam3,0,0,1024*scx,768*scy)	
				surface.SetDrawColor(2,2,2,230)
				surface.DrawRect(0,5,1024,60)	
				draw.SimpleText(WagNumber,font,5,30,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)				
			end		
		end
		if sel > 0 and state >= 0 then
			local last = Train:GetNW2Bool("CAMSLast",false)
			for i=1,wagnum do
				local s = 328-wagnum*40 --384-wagnum*40-40-16
				draw.SimpleText(i,font,50,s+80*i,i == math.min(wagnum,sel) and blue or white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)	
				surface.SetDrawColor(Color(190,190,190))
				if i > 1 then
					surface.SetTexture(cam_icons_default)	
					surface.DrawTexturedRectRotated(110,s+80*i,64,128,0)
				else
					surface.SetTexture(cam_icons_head_default)
					surface.DrawTexturedRectRotated(110,s+80*i,64,128,0)
				end
				if i == sel then
					surface.SetTexture(cam_icons_select)
					surface.DrawTexturedRectRotated(106,s+80*i+1,64,128,0)
				end				
				--surface.DrawTexturedRectRotated(70,80*i+25,64,128,0)
				if i == wagnum and last then
					if i+1 == sel then 
						surface.SetTexture(cam_icons_tail_select)
					else
						surface.SetTexture(cam_icons_tail_default)	
					end
					surface.DrawTexturedRectRotated(110,s+80*i+54,64,32,0)
				end
			end
		end		
		
		--surface.DrawRect(512,0,1,768)
	end	
end

