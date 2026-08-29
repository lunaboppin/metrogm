--------------------------------------------------------------------------------
-- РПДП 760
--------------------------------------------------------------------------------

Metrostroi.DefineSystem("81_760_RPDP")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	--self.Train:LoadSystem("","Relay","Switch",{bass = true})
    self.TriggerNames = {
    }
    self.Triggers = {}
	for k,v in pairs(self.TriggerNames) do
		self.Triggers[v] = false
	end
	self.State = -1
	self.CurTime = CurTime()
	self.tbl = {}	
	self.sum = 0
	self.v0 = 0
	self.prevtime = CurTime()
	self.tblTrains = {self.Train.WagonNumber}
	--self.tblTrains = {self.Train:GetWagonNumber()}
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
	util.AddNetworkString("metrostroi_rpdp")
	util.AddNetworkString("metrostroi_rpdp_send")
	
	function TRAIN_SYSTEM:Trigger(name,value)
		local Train = self.Train
		
	end
	local function Send(ply,str,self)
		if not self then return end
		net.Start("metrostroi_rpdp")
		net.WriteTable(self.tbl[str])
		net.WriteEntity(self.Train)
		net.Broadcast()	 
	end
	local function send(ln,ply)--,str,train)
		local str = net.ReadString()
		local train = net.ReadEntity()	
		--print(str,train.RPDP.tbl[str])
		if CPPI and train.CPPICanPhysgun and not train:CPPICanPhysgun(ply) then--доступ к составу
			return
		end
		
		--Send(ply,str,train.RPDP)
		--print(str,train)

		--print(str)		
		
		--send(ply,str,train)	
		timer.Simple(0,function()
			net.Start("metrostroi_rpdp_send")
			net.WriteString(str)
			net.WriteTable(train.RPDP.tbl[str] or {})
			--net.WriteTable(train.RPDP.tblTrains)
			--net.WriteEntity(train)
			--net.Broadcast()
			net.Send(ply)
			--net.Broadcast()--(ply)
		end)
	end
	local C_RPDP = CreateConVar("metrostroi_rpdp_on",0, FCVAR_ARCHIVE,"On RPDP for 760 trains")

	function TRAIN_SYSTEM:Think(dT)
		if not C_RPDP:GetBool() or CurTime()-self.CurTime < 0 then return end
		self.CurTime = CurTime()+(1-dT)*0.499
		local deltaTime = CurTime()-self.prevtime--(1-dT)*0.499
		local Train = self.Train
		local deltasum = (self.v0+Train.Speed)*deltaTime/7.2--self.DeltaTime -- *Train.SpeedSign)
		self.sum = self.sum + deltasum
		if Train.BUKP.Trains ~= self.tblTrains then
			self.tblTrains = Train.BUKP.Trains
		end
		
		local Power = Train.Electric.UPIPower > 0 --Train.Electric.Battery80V > 62 and Train.SF6.Value > 0
		for k,v in pairs(self.TriggerNames) do
			if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
				self:Trigger(v,Train[v].Value > 0.5)
				self.Triggers[v] = Train[v].Value > 0.5
			end
		end		
		Train:SetNW2Int("RPDPState",self.State)
		if not Power and self.State ~= -1 then
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
		if self.State == 1 then
			local timenow = os.date("%H:%M:%S %d.%m.%Y",Metrostroi.GetSyncTime())
			local train = Train.BUKP.Trains[Train.BUKP.Trains[1]]
			local BARS = Train.BARS			
			if train then		
				if not self.tbl[timenow] then
					--print(train.BLPressure)
					self.tbl[timenow] = {}
					self.tbl[timenow]["train"] = Train
					self.tbl[timenow]["wags"] = self.tblTrains
					local stength = Train:GetNW2Bool("VityazBARSPN2",false) and -2 or Train:GetNW2Int("VityazType",0)
					self.tbl[timenow][1] = {
						["s"] = deltasum,
						
						(BARS.NoFreq or BARS.NextNoFq) and 1 or 0,
						Train.RV.KRRPosition+Train.RV.KROPosition == 0 and 1 or 0,
						Train.RV.KROPosition > 0 and 1 or 0,
						Train.RV.KROPosition < 0 and 1 or 0,
						Train.RV.KRRPosition ~= 0 and 1 or 0,
						Train.Pneumatic.EmerBrakeWork and 1 or 0,
						--["Uкс (в1)"] = Format("% 4.1f",train.HVVoltage),
						--["Uбс (в1)"] = Format("% 4.1f",train.LVVoltage),
						--["Pтм (в1)"] = Format("% 4.1f",train.BLPressure),
						BARS.PN1,
						BARS.PN2,
						--["Вкл МК"] = train.MKVoltage > 0 and 1 or 0,
						Train.BUKP.Slope and 1 or 0,
						train.Scheme and 0 or 1,
						--["АЛС"] = BARS.PrevALS,
						--["КАХ"] = Train.KAH.Value,
						3.8-(train.ParkingBrakePressure or 4) > 0 and 1 or 0,
						stength,
						--stength == 3 and 1 or 0,
						--stength == 2 and 1 or 0,
						--stength == 1 and 1 or 0,
						--stength == 0 and 1 or 0,
						--stength == -1 and 1 or 0,
						--stength == -2 and 1 or 0,
						--stength == -3 and 1 or 0,
						BARS.KVTTimer and 1 or 0,
						Train.BUV.States["EmergencyBrake"] and 1 or 0,
						(BARS.SpeedLimit < 21 and not BARS.NoFreq or BARS.NextLimit and BARS.NextLimit < 21 and not BARS.NextNoFq) and 1 or 0,
						BARS.UOS and 1 or 0,
						(Train.Pr.Value > 0 and stength <= 0) and 1 or 0,
						Train.ALS.Value,
						Train.KAH.Value,
						
						math.floor(BARS.SpeedLimit),
						BARS.NextLimit and math.floor(BARS.NextLimit) or 0,
						train.HVVoltage,
						train.LVVoltage,
						train.BLPressure,						
						Train:GetNW2Int("VityazPMin",0),--train.DPBTPressure2,	
						IsValid(Train.FrontBogey) and Train.FrontBogey.Speed or 0,
						IsValid(Train.RearBogey) and Train.RearBogey.Speed or 0,
						--["ПСН вкл"] = 1,
						
					}

					--net.Start("metrostroi_rpdp")
					--net.WriteTable(self.tbl)
					--net.WriteEntity(Train)
					--net.Broadcast()	 				
				elseif not self.tbl[timenow][2] then
					local stength = Train:GetNW2Bool("VityazBARSPN2",false) and -2 or Train:GetNW2Int("VityazType",0)
					self.tbl[timenow][2] = {
						["s"] = deltasum,
					
						--["Vфакт"] = math.Round(Train.Speed,1),
						--["Vдоп"] = math.Round(math.floor(BARS.SpeedLimit),1),
						--["Vпр"] = math.Round(math.floor(BARS.NextLimit),1),		
						(BARS.NoFreq or BARS.NextNoFq) and 1 or 0,
						Train.RV.KRRPosition+Train.RV.KROPosition == 0 and 1 or 0,
						Train.RV.KROPosition > 0 and 1 or 0,
						Train.RV.KROPosition < 0 and 1 or 0,
						Train.RV.KRRPosition ~= 0 and 1 or 0,
						Train.Pneumatic.EmerBrakeWork and 1 or 0,
						--["Uкс (в1)"] = Format("% 4.1f",train.HVVoltage),
						--["Uбс (в1)"] = Format("% 4.1f",train.LVVoltage),
						--["Pтм (в1)"] = Format("% 4.1f",train.BLPressure),
						BARS.PN1,
						BARS.PN2,
						--["Вкл МК"] = train.MKVoltage > 0 and 1 or 0,
						Train.BUKP.Slope and 1 or 0,
						train.Scheme and 0 or 1,
						--["АЛС"] = BARS.PrevALS,
						--["КАХ"] = Train.KAH.Value,
						3.8-(train.ParkingBrakePressure or 4) > 0 and 1 or 0,
						stength,
						--stength == 3 and 1 or 0,
						--stength == 2 and 1 or 0,
						--stength == 1 and 1 or 0,
						--stength == 0 and 1 or 0,
						--stength == -1 and 1 or 0,
						--stength == -2 and 1 or 0,
						--stength == -3 and 1 or 0,
						BARS.KVTTimer and 1 or 0,
						Train.BUV.States["EmergencyBrake"] and 1 or 0,
						(BARS.SpeedLimit < 21 and not BARS.NoFreq or BARS.NextLimit and BARS.NextLimit < 21 and not BARS.NextNoFq) and 1 or 0,
						BARS.UOS and 1 or 0,
						(Train.Pr.Value > 0 and stength <= 0) and 1 or 0,
						Train.ALS.Value,
						Train.KAH.Value,
						
						math.floor(BARS.SpeedLimit),
						BARS.NextLimit and math.floor(BARS.NextLimit) or 0,
						train.HVVoltage,
						train.LVVoltage,
						train.BLPressure,						
						Train:GetNW2Int("VityazPMin",0),--train.DPBTPressure2,	
						IsValid(Train.FrontBogey) and Train.FrontBogey.Speed or 0,
						IsValid(Train.RearBogey) and Train.RearBogey.Speed or 0,						
						--["ПСН вкл"] = 1,
						
					}
				end			
			end 

			--net.Receive("metrostroi_rpdp",send)
		end
		self.v0 = Train.Speed--*Train.SpeedSign
		self.prevtime = CurTime()
	end
	net.Receive("metrostroi_rpdp",send)
	
else
    function TRAIN_SYSTEM:ClientInitialize()
		self.tbl = {}
    end
    function TRAIN_SYSTEM:ClientThink(dT)
		
	end 
	CreateClientConVar( "metrostroi_rpdp","0", false, true )	
	CreateClientConVar( "metrostroi_rpdp_start","0",false,true)
	CreateClientConVar( "metrostroi_rpdp_info","0",false,true)
	--CreateClientConVar( "metrostroi_rpdp_end","0",true,true)
	
	local function Receive(len,ply)
		Metrostroi.RPDPTbl = net.ReadTable()
		--Metrostroi.RPDPTrain = net.ReadEntity() 
		--return
	end
	--Metrostroi.RPDPTable = {}
	local function ReceiveINFO(Train,str)
		timer.Simple(1,function()
			net.Start("metrostroi_rpdp")
			net.WriteString(str)
			net.WriteEntity(Train)
			net.SendToServer()
		end)
		
		--timer.Simple(1,function()

		--end)
		
		--return Metrostroi.RPDPTbl--,Metrostroi.RPDPTrain}
	end
	timer.Simple(0,function()
		net.Receive("metrostroi_rpdp_send", function( len, ply )
			--Metrostroi.RPDPTbl = net.ReadTable()			
			local str = net.ReadString()
			--print(str)
			if Metrostroi.RPDPTable[str] then return end
			--print(str)
			--local tabl
			Metrostroi.RPDPTable[str] = net.ReadTable()
			--[[
			if table.Count(Metrostroi.RPDPTable) == 1 then
				tabl = net.ReadTable()
			end]]
			
			--if not IsValid(ply) then return end
			--PrintTable(Metrostroi.RPDPTable[str])
			--print(str,ply)
			local s = 0		
			for k=1,2 do
				local stength = Metrostroi.RPDPTable[str][k] and Metrostroi.RPDPTable[str][k][12] or 1000
				if stength ~= 1000 then
					Metrostroi.RPDPTable[str][k][12] = stength == 4 and 1 or 0
					for i=13,19 do	
						table.insert(Metrostroi.RPDPTable[str][k],i,-stength+16 == i and 1 or 0)
					end
					s=s+Metrostroi.RPDPTable[str][k]["s"]
					if table.Count(Metrostroi.RPDPTable) == 1 and Metrostroi.RPDPTable["wags"] ~= Metrostroi.RPDPTable[str]["wags"] then
						Metrostroi.RPDPTable["wags"] = Metrostroi.RPDPTable[str]["wags"]
					end					
				end
			end
			Metrostroi.RPDPS = Metrostroi.RPDPS + s
			--print(s) 
			--Metrostroi.RPDPTrain = net.ReadEntity() 		
		end)
	end)
	
	local function ReceiveInf(Train,timenow)
		local tbl = {}
		for i=1,23 do
			local val = Train:GetNW2Int("RPDP "..timenow.." "..i,0)
			table.insert(tbl,val)
		end
		return tbl
	end
	
	local nametbl = {"ОЧ","РВ 0","РВ Вп","РВ Наз","РВ Рез","ТорРез","ТормАРС (ПЦБ1)","ТормАРС (ПЦБ2)","Подъем","Несбор схемы","Ст. тормоз прижат","Ход 4","Ход 3","Ход 2","Ход 1","Выбег","Тормоз 1","Тормоз 2","Тормоз 3","КВТ","ТормЭкст","0","УОС","прогрев колодок","АЛС","КАХ"}
	local colortbl = {Color(255,0,0),Color(40,40,255),Color(40,255,40),Color(214,150,124),Color(0,0,0),Color(255,0,0),Color(255,0,0),Color(255,0,0),Color(113,162,161),Color(0,0,100),Color(0,0,0),Color(40,255,40),Color(40,255,40),Color(40,255,40),Color(40,255,40),Color(40,40,255),Color(255,0,0),Color(255,0,0),Color(255,0,0),Color(87,102,169),Color(255,0,0),Color(255,0,0),Color(255,145,67),Color(0,0,0),Color(0,0,0),Color(0,0,0)}
	local nametbl2 = {"Vдоп","Vпр","Uкс (в1)","Uбс (в1)","Pтм","Pтц min","Vфакт (2-я ось)","Vфакт (1-я ось)"}
	local colortbl2 = {Color(111,212,126),Color(249,100,168),Color(155,79,170),Color(244,156,245),Color(255,0,0),Color(0,0,0),Color(0,0,255),Color(0,0,255)}
	local nametbl3 = {"№ Вагона:","№ РПДП:","ПО РПДП:","Нач.время:","Кон.время:","Путь:"}
	local infos2 = {"№ Вагонов","1 - ","2 - ","3 - ","4 - ","5 - ","6 - ","7 - ","8 - "}
	
	local tables = {}
	--for k,v in pairs(nametbl) do
		--table.insert(tables,k,{nametbl[k],true})
		--tables[nametbl[i]] = true
	--end
	--for k,v in pairs(nametbl2) do
		--table.insert(tables,{nametbl2[k],true})
		--tables[nametbl[i]] = true
	--end
	local tables = {{"Vфакт (2-я ось)",Color(0,0,255),true},{"Vфакт (1-я ось)",Color(0,0,255),true},{"Vдоп",Color(111,212,126),true},
					{"Vпр",Color(249,100,168),false},{"ОЧ",Color(255,0,0),false},{"РВ 0",Color(40,40,255),true},{"РВ Вп",Color(40,255,40),true},
					{"РВ Наз",Color(214,150,124),true},{"РВ Рез",Color(0,0,0),true},{"Тор Рез",Color(255,0,0),true},{"Uкс (в1)",Color(155,79,170),true},
					{"Uбс (в1)",Color(244,156,245),false},{"Pтм",Color(255,0,0),true},{"ТормАРС (ПЦБ1)",Color(255,0,0),true},{"ТормАРС (ПЦБ2)",Color(255,0,0),true},
					{"Подъем",Color(113,162,161),true},{"АЛС",Color(0,0,0),false},{"КАХ",Color(0,0,0),false},{"Pтц min",Color(0,0,0),true},
				}
				
	local conv = {[1] = 5,[2] = 6,[3] = 7,[4] = 8,[5] = 9,[6] = 10,[7] = 14,[8] = 15,[9] = 16,[25] = 17,[26] = 18,[27] = 3,[28] = 4,[33] = 2,[34] = 1,[29] = 11,[30] = 12,[31] = 13,}
	
	--[[
	local function OpenConfigWindow()
		local function UpdateList()
			if not List then return end
			List:Clear()
			for k,v in pairs(tables) do
				List:AddLine(v[1],v[2])
			end
		end
		local function RowSelect(self,k, par2)
			--print(self,k,par2)
			tables[k][2] = not tables[k][2]
			UpdateList()
			--SelectedPath = lineID
		end		
	
		local function AddButton(parent,cmd,label,tooltip)
			local Button = vgui.Create("DButton",parent)
			Button:SetText(label)
			Button:SizeToContents()
			--Button:SetConsoleCommand(cmd)
			Button:SetSize(100,30)
			Button:DockMargin(2,2,2,2)
			Button:SetColor(color_black)
			Button:SetToolTip(tooltip)
			return Button
		end
		
		local function AddLabel(parent,str)
			local Label = vgui.Create("DLabel",parent)
			Label:SetText(str)
			Label:SizeToContents()
			Label:SetContentAlignment(5)
			Label:DockMargin(2,2,2,2)
			return Label
		end
		
		--Main frame
		local Frame = vgui.Create("DFrame")
		Frame:SetPos(surface.ScreenWidth()/5,surface.ScreenHeight()/3)
		Frame:SetSize(250,400)
		Frame:SetTitle("Metrostroi rpdp editor")
		Frame:SetVisible(true)
		Frame:SetDraggable(true)
		Frame:ShowCloseButton(true)
		
		List = vgui.Create("DListView",Frame)
		List:DockMargin(2,2,2,2)
		List:Dock(FILL)
		List:SetMultiSelect(false)

		List:AddColumn("Parameters")
		List:AddColumn("Values")
		List:SetTall(100)
		List.OnRowSelected = RowSelect --SetSelectedPath
		--List.OnRowRightClick = ShowRowMenu
		UpdateList()
		
		Frame:SizeToContents()
		Frame:MakePopup()		
	end	]]	
	local function OpenConfigWindow()
		local function CheckBoxOnChange(panel,val)
			local i = panel.Val 
			tables[i][3] = val
		end
		
		local function AddLabel(parent,str)
			local Label = vgui.Create("DLabel",parent)
			Label:SetText(str)
			Label:SizeToContents()
			Label:SetContentAlignment(5)
			Label:DockMargin(2,2,2,2)
			return Label
		end
		
		local ply = LocalPlayer()
		if not IsValid(ply) then return end
		
		local localy = 15
		if GetConVarNumber("developer") == 1 then
			localy = 77
		end
		local wep = ply:GetActiveWeapon()
		if IsValid(wep) and wep:GetClass() == "gmod_tool" then
			localy = 188
		end			
		
		--Main frame
		local Frame = vgui.Create("DFrame")
		Frame:SetPos(570,localy+25)--570,250
		Frame:SetSize(280,640)
		Frame:SetTitle("")--Metrostroi RPDP editor")
		Frame:SetVisible(true)
		Frame:SetDraggable(false)
		Frame:ShowCloseButton(true)
		
		local inf = GetConVar("metrostroi_rpdp_info")
		local dat = os.date("%H:%M:%S %d.%m.%Y",inf:GetInt())		
		if not Metrostroi.RPDPTable or table.Count(Metrostroi.RPDPTable) == 0 then
			ply:ChatPrint("RPDP: Error (no info)")
			Frame:Close()
			return
		end
		local Train = Metrostroi.RPDPTable[dat] and Metrostroi.RPDPTable[dat]["train"]
		if not IsValid(Train) then
			ply:ChatPrint("RPDP: Error (no Train)")
			Frame:Close()	
			return
		end
		local infos = {Train:GetWagonNumber(),Train:GetWagonNumber()-36983,3.9,os.date("%H:%M:%S",inf:GetInt()),os.date("%H:%M:%S",inf:GetInt()+40),Format("%.01f",Metrostroi.RPDPS).."m"}
		local wags = Metrostroi.RPDPTable[dat]["wags"]
		
		--one:SetPos(4,30)
		
		--local two = vgui.Create("DIconLayout",Frame)
		--two:SetPos(40,40)
		
		local Scroll = vgui.Create( "DScrollPanel", Frame ) -- Create the Scroll panel
		Scroll:Dock( FILL )

		local List = vgui.Create( "DIconLayout", Scroll )
		List:Dock( FILL )
		List:SetSpaceY( 6 ) -- Sets the space in between the panels on the Y Axis by 5
		List:SetSpaceX( 6 ) -- Sets the space in between the panels on the X Axis by 5	
		
		local ListItem = List:Add("DPanel")
		ListItem:SetSize( 250, 22*6 ) -- Set the size of it

		local label = vgui.Create("DLabel",ListItem)
		label:SetText("Параметры")
		label:SetTextColor(Color(0,0,0))
		label:SetPos(25,7)	
		
		local postbl3 = {2,9,7,0,0,28}
		for i=1,#nametbl3 do
			local label = vgui.Create("DLabel",ListItem)
			label:SetText(nametbl3[i].."  "..infos[i])
			label:SetTextColor(Color(0,0,0))
			label:SetPos(4+postbl3[i],10+i*15)
			label:SizeToContents()		
		end
		for i=1,#infos2 do
			local label = vgui.Create("DLabel",ListItem)
			label:SetText(infos2[i].." "..(i > 1 and (wags[i-1] or "- - - - -") or ""))
			label:SetTextColor(Color(0,0,0))
			label:SetPos(184,i*13)
			label:SizeToContents()				
		end
		
		for i = 1, #tables do
			local ListItem = List:Add( "DPanel" )
			ListItem:SetSize( 250, 22 )
			local checkbox = vgui.Create("DCheckBoxLabel",ListItem)
			checkbox:SetPos(3,3)
			local tbl = tables[i]-- or {"check",Color(0,0,0),true}
			checkbox:SetTextColor(tbl[2])
			checkbox:SetText(tbl[1])
			checkbox:SetValue(tbl[3])
			checkbox.Val = i
			checkbox.OnChange = CheckBoxOnChange 			
		end		
		
		Frame:SizeToContents()
		Frame:MakePopup()	

		return Frame
	end	
	
	concommand.Add("metrostroi_rpdp_editor",OpenConfigWindow,nil,"GUI for rpdp editor")
	
	--Metrostroi.ThinkDT = 0
	hook.Add("HUDPaint","RPDPDebug",function()
		--local dT = CurTime()-Metrostroi.ThinkDT
		--print(dT)
		--Metrostroi.ThinkDT = CurTime()
		--net.Start("metrostroi_rpdp")
		--net.SendToServer()
		local conVar = GetConVar("metrostroi_rpdp")
		local startT = GetConVar("metrostroi_rpdp_start"):GetString()--,GetConVar("metrostroi_rpdp_end"):GetString()
		local inf = GetConVar("metrostroi_rpdp_info")
		--print(conVar:GetBool())
		--print(conVar:GetBool())
		local ply = LocalPlayer()
		
		if not IsValid(ply) then return end
		if startT ~= Metrostroi.RPDPStartTime then
			Metrostroi.RPDPStartTime = startT
			Metrostroi.RPDPErrorDate = CurTime()+11
			if startT == "1" or startT == 1 then
				GetConVar("metrostroi_rpdp_start"):SetString(os.date("%H:%M:%S",Metrostroi.GetSyncTime()-40))
			end
			if Metrostroi.RPDPFrame and IsValid(Metrostroi.RPDPFrame) then
				Metrostroi.RPDPFrame:Close()
				Metrostroi.RPDPFrame = nil
			end
		end
		if conVar:GetInt() ~= 0 and (startT ~= "0") and startT ~= "1" then--and endT ~= "0") then 
			if true then
				local firstdate = {
					year = startT:sub(16,19) ~= "" and startT:sub(16,19) or os.date("%Y",Metrostroi.GetSyncTime()),
					month = startT:sub(13,14) ~= "" and startT:sub(13,14) or os.date("%m",Metrostroi.GetSyncTime()),
					day = startT:sub(10,11) ~= "" and startT:sub(10,11) or os.date("%d",Metrostroi.GetSyncTime()),
					hour = (startT:sub(1,2)),
					min = (startT:sub(4,5)),
					sec = (startT:sub(7,8)),
				}
				--[[ 
				local lastdate = { 
					year = tonumber(endT:sub(16,19)),
					month = tonumber(endT:sub(13,14)),
					day = tonumber(endT:sub(10,11)),
					hour = tonumber(endT:sub(1,2)),
					min = tonumber(endT:sub(4,5)),
					sec = tonumber(endT:sub(7,8)),				
				}
				]]
				local first = os.time(firstdate)--,os.time(lastdate)

				--local colortbl = {Color}
				--local Train = LocalPlayer():GetViewEntity()
				local Train
				for k,v in pairs(ents.FindByClass("gmod_subway_81-760*")) do 
					if v:GetWagonNumber() == conVar:GetInt() then
						Train = v
					end
				end
				if not IsValid(Train) then
					if not Metrostroi.RPDPErrorDate then
						ply:ChatPrint("RPDP: No info (Error train)")
						Metrostroi.RPDPErrorDate = true
					end
					return
				end
				surface.SetFont("DebugBoxText")

				local localy,localx = 15,140 --+ 65
				if GetConVarNumber("developer") == 1 then
					localy = 77
				end
				local wep = ply:GetActiveWeapon()
				if IsValid(wep) and wep:GetClass() == "gmod_tool" then
					localy = 188
				end

				surface.SetTextColor(0,0,0)
				--surface.SetAlphaMultiplier(0.8)
				surface.SetDrawColor(Color(200,200,200))
				surface.DrawRect(10,localy,840,680)
				--surface.SetAlphaMultiplier(1)	
				--surface.SetAlphaMultiplier(1)				
				surface.SetDrawColor(200,200,200) --surface.SetDrawColor(100,100,100)--
				--surface.DrawRect(345,localy+25,421,605)
				surface.SetAlphaMultiplier(1)
				
				local i1 = 1
				for k,v in pairs(nametbl) do
					if not conv[k] or tables[conv[k]][3] then
						surface.SetTextColor(colortbl[k])
						local Width, Height = surface.GetTextSize(v)
						surface.SetTextPos(140-Width,localy+230+16*i1)
						surface.DrawText(v)
						i1 = i1 + 1				
					end
				end
				--local nametbl2 = {["Vфакт"] = Color(0,0,255),["Vдоп"] = Color(111,212,126),["Vпр"] = Color(249,100,168),["Uкс (в1)"] = Color(155,79,170),["Uбс (в1)"] = Color(244,156,245),["Pтм"] = Color(255,0,0)}
				local m = 1
				for k,v in pairs(nametbl2) do
					--if tables[k+24][2] then
					if not conv[k+26] or tables[conv[k+26]][3] then					
						surface.SetTextColor(colortbl2[k])
						surface.SetTextPos(600,localy+160+16*m)
						surface.DrawText(v)
						m = m + 1
					end
				end
				
				surface.SetTextColor(Color(0,0,0))
				surface.SetTextPos(604,localy+30)
				surface.DrawText("Параметры")
				for k,v in pairs(nametbl3) do
					local Width, Height = surface.GetTextSize(v)
					surface.SetTextPos(650-Width,localy+30+16*k)
					surface.DrawText(v)
				end
				surface.SetTextColor(Color(0,0,0))
				surface.SetDrawColor(Color(0,0,0))				
				for i=1,11 do
					local v = 11-i.."x"
					local Width, Height = surface.GetTextSize(v)
					surface.SetTextPos(125-Width,localy+10+20*i)
					surface.DrawText(v)		
					surface.DrawLine(130,localy+16+20*i,140,localy+16+20*i)		
				end
				surface.DrawLine(140,localy+26,140,localy+236)
				surface.SetDrawColor(Color(250,250,250))
				surface.DrawRect(150,localy+26,415,635)
				
				surface.SetDrawColor(Color(217,217,217))
				surface.DrawRect(145,localy+25,4,635)
				--surface.SetDrawColor(Color(217,217,217))
				surface.DrawRect(145,localy+660,420,4)		
				surface.DrawRect(145,localy+25,420,4)
				surface.DrawRect(565,localy+25,4,639)
				surface.DrawRect(145,localy+243,420,4)
				
				surface.SetTextColor(Color(200,200,200))
				for i=1,11 do
					--local v = 11-i
					surface.SetTextPos(154,localy+5+20*i)
					surface.DrawText("__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __")
				end				
			
				
				--[[
				net.Start("metrostroi_rpdp")
				net.WriteString(os.date("%H:%M:%S %d.%m.%Y",first))
				net.SendToServer()
				
				net.Receive("metrostroi_rpdp",function()
					Metrostroi.RPDPTbl = net.ReadTable()
					Metrostroi.RPDPTrain = net.ReadEntity()
				end)]]
				if conVar:GetInt() ~= Metrostroi.RPDPNewTrain or first ~= inf:GetInt() then
					inf:SetInt(first)
					--Metrostroi.RPDPTime2 = first			
					if conVar:GetInt() ~= Metrostroi.RPDPNewTrain then
						Metrostroi.RPDPNewTrain = conVar:GetInt()
						Metrostroi.RPDPErrorDate = CurTime()+11
						--Metrostroi.RPDPErrorDate = false
					end
				
					if Metrostroi.RPDPFrame and IsValid(Metrostroi.RPDPFrame) then
						Metrostroi.RPDPFrame:Close()
						Metrostroi.RPDPFrame = nil
					end
				
					--ReceiveINFO(os.date("%H:%M:%S %d.%m.%Y",first),Train)
					Metrostroi.RPDPTable = {}
					Metrostroi.RPDPS = 0
					--Metrostroi.RPDPTable[os.date("%H:%M:%S %d.%m.%Y",first)] = Metrostroi.RPDPTbl
					
					for k=0,40 do
						local i = first+k					
						timer.Simple(0.13*(k+1),function()
							local timenow = os.date("%H:%M:%S %d.%m.%Y",i)

							local tbl = ReceiveINFO(Train,timenow)
						end)
					end

					--[[
					timer.Simple(1,function()
						for k=0,20 do
							local i = first+k
							local timenow = os.date("%H:%M:%S %d.%m.%Y",i)

							local tbl = ReceiveINFO(Train,timenow)
						end 
					end)
					timer.Simple(2,function()
						for k=21,40 do
							local i = first+k
							local timenow = os.date("%H:%M:%S %d.%m.%Y",i)

							local tbl = ReceiveINFO(Train,timenow)
						end
					end) ]]
					--print(inf:GetInt())
				end

				local scales = {1,1,0.1,1,10,1,1,1}
				for k = 0,80 do--    40 sec * 2
					local i = first+k*0.5
					local timenow = os.date("%H:%M:%S %d.%m.%Y",i)
					local timeprev = k == 0 and timenow or os.date("%H:%M:%S %d.%m.%Y",i-0.5)
					--ReceiveINFO(timenow,Train)	
					local info,previnfo = Metrostroi.RPDPTable[timenow] and Metrostroi.RPDPTable[timenow][1+k%2] or {},Metrostroi.RPDPTable[timeprev] and Metrostroi.RPDPTable[timeprev][1+(1-k%2)] or {}
					if info and #info > 0 then
						local i1 = 1
						for k2,v2 in ipairs(info) do
							if not conv[k2] or tables[conv[k2]][3] then	
								if k2 <= 26 then--and tables[k2][2] then
									local y = 200+16*k2
									local col = v2 and v2 == 1 and colortbl[k2] or Color(255,255,67)
									--[[
									surface.SetDrawColor( col )
									surface.DrawLine(352+10*k,localy+237+16*k2,362+10*k,localy+237+16*k2)	]]
									Metrostroi.DrawLine(153+5*k,localy+237+16*i1,158+5*k,localy+237+16*i1,col,2)
									i1 = i1 + 1
								elseif k2 > 26 and k2 < 35 then --and (tables[k2][2] or true) then
									local col = colortbl2[k2-26]
									local y1,y2 = 1-scales[k2-26]*v2/100,1-scales[k2-26]*previnfo[k2]/100
									--[[
									surface.SetDrawColor( col )
									surface.DrawLine(352+10*k,localy+36+200*y2,362+10*k,localy+36+200*y1)]]
									Metrostroi.DrawLine(152+5*k,localy+36+200*y2,157+5*k,localy+36+200*y1,col,col == Color(0,0,255) and 3 or 2)
									--print(k2,v2)
								end
							end
						end
						if Metrostroi.RPDPErrorDate and isnumber(Metrostroi.RPDPErrorDate) then
							if CurTime()-Metrostroi.RPDPErrorDate > 0 then
								if table.Count(Metrostroi.RPDPTable) > 0 and Metrostroi.RPDPTable[os.date("%H:%M:%S %d.%m.%Y",first+40)] and #Metrostroi.RPDPTable[os.date("%H:%M:%S %d.%m.%Y",first+40)] > 0 then
									ply:ChatPrint("RPDP: Loaded")--(train №"..Train:GetWagonNumber()..") "..os.date("%H:%M:%S %d.%m.%Y",first).."-"..os.date("%H:%M:%S %d.%m.%Y",first+40))
									Metrostroi.RPDPErrorDate = false
									
									if Metrostroi.RPDPFrame and IsValid(Metrostroi.RPDPFrame) then
										Metrostroi.RPDPFrame:Close()
										Metrostroi.RPDPFrame = nil
									end
									
									timer.Simple(1,function()
										Metrostroi.RPDPFrame = OpenConfigWindow()
									end)
									
								--else
									--ply:ChatPrint("No info at RPDP "..timenow.." train №"..Train:GetWagonNumber())
									--Metrostroi.RPDPErrorDate = true							
								end
							end
						end						
					else
						if Metrostroi.RPDPErrorDate and isnumber(Metrostroi.RPDPErrorDate) then
							if CurTime()-Metrostroi.RPDPErrorDate > 0 then
								ply:ChatPrint("RPDP: No info at "..timenow.." train №"..Train:GetWagonNumber())
								Metrostroi.RPDPErrorDate = true
							elseif CurTime() == Metrostroi.RPDPErrorDate-11 then
								ply:ChatPrint("RPDP: Loading data (train №"..Train:GetWagonNumber()..") "..os.date("%H:%M:%S %d.%m.%Y",first).."-"..os.date("%H:%M:%S %d.%m.%Y",first+40))
							end
						end
						--ply:ChatPrint("Loading RPDP data")
						return
						--break
					end
					if k%20 == 0 then
						surface.SetTextColor(Color(0,0,0))
						--local Width, Height = surface.GetTextSize(v)
						surface.SetTextPos(131+k*5,localy+10)
						surface.DrawText(timenow:sub(1,8))
						--[[
						surface.SetDrawColor(Color(70,100,255))
						surface.DrawLine(355+10*k,localy+25,355+10*k,localy+630)]]
						Metrostroi.DrawLine(155+5*k,localy+30,155+5*k,localy+660,Color(70,100,255),1)
					end	
				end
				
				surface.SetTextColor(Color(0,0,0))
				local infos = {Train:GetWagonNumber(),Train:GetWagonNumber()-36983,3.9,os.date("%H:%M:%S",first),os.date("%H:%M:%S",first+40),Format("%.01f",Metrostroi.RPDPS).."m"}
				for k,v in pairs(infos) do
					surface.SetTextPos(654,localy+30+16*k)
					surface.DrawText(v)
				end
				local wags = Metrostroi.RPDPTable["wags"] or {}
				for k,v in pairs(infos2) do
					surface.SetTextPos(754,localy+15+14*k)
					surface.DrawText(v..(k > 1 and (wags[k-1] or "-----") or ""))
				end
				Metrostroi.DrawLine(730,localy,730,localy+165,Color(217,217,217),3)							
				Metrostroi.DrawLine(730,localy+165,850,localy+165,Color(217,217,217),3)
			end
				
			--for i=first,last do
			--end
					
			--local timenow = os.date("%H:%M:%S %d.%m.%Y",Metrostroi.GetSyncTime())		
			
			--end)
		else
			return
		end
	end)
end