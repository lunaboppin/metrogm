-- Контроллер вентиляции SMODE
Metrostroi.DefineSystem("81_540_2k_smode")
TRAIN_SYSTEM.DontAccelerateSimulation = true
function TRAIN_SYSTEM:Initialize() 
    self.State = -2
    self.Page = 0
    self.TempInt = 15
    -- self.LoadingTimer = CurTime()+30
    self.Train:LoadSystem("SMODE_Up","Relay","Switch",{bass = true })
    self.Train:LoadSystem("SMODE_Down","Relay","Switch",{bass = true })
    self.Train:LoadSystem("SMODE_Next","Relay","Switch",{bass = true })
    self.Train:LoadSystem("SMODE_Prev","Relay","Switch",{bass = true })
    self.Train:LoadSystem("SMODE_Enter","Relay","Switch",{bass = true })
    self.Train:LoadSystem("SMODE_Escape","Relay","Switch",{bass = true })
    for i=1,6 do 
    self.Train:LoadSystem("SMODE_F" .. i,"Relay","Switch",{bass = true })
    end 
    for i=0,9 do 
    self.Train:LoadSystem("SMODE_" .. i,"Relay","Switch",{bass = true })
    end 
    
    self.TriggerNames = { 
        "SMODE_Up",
        "SMODE_Down",
        "SMODE_Next",
        "SMODE_Prev",
        "SMODE_Enter",  
        "SMODE_Escape",
        "SMODE_F1",
        "SMODE_F2",
        "SMODE_F3",
        "SMODE_F4",
        "SMODE_F5",
        "SMODE_F6",
        "SMODE_0",
        "SMODE_1",
        "SMODE_2",
        "SMODE_3",
        "SMODE_4",
        "SMODE_5",
        "SMODE_6",
        "SMODE_7",
        "SMODE_8",
        "SMODE_9"
    }
    self.Triggers = {}
end 
if TURBOSTROI then return end 

function TRAIN_SYSTEM:Inputs()
    return {}
end

if SERVER then 
      function TRAIN_SYSTEM:Trigger(name,value)
       local name = name:gsub("SMODE_","")
       local Train = self.Train 
       if name == "F5" and self.State == 1 then self.State = 5 self.EndWorkTimer = CurTime()+1 self.StartWorkTimer = nil end
       if name == "F5" and self.State == -3 and value then 
          self.StartWorkTimer = CurTime()+1  
          self.LoadingTimer = CurTime()+5
       end 
       if self.State == 1 and name == "F1" and value then 
                self.State = 2 
                if not self.Page then self.Page = 0 end
                self.Page = 1
       end   
       if self.State == 2 and value then
        if not self.Page then self.Page = 0 end
         if name == "Prev" and self.Page == 1 and value then self.State = self.State - 1 end 
         if name == "Prev" and self.Page > 1 and value then self.Page = self.Page - 1 end 
         if name == "Next" and value then self.Page = self.Page + 1 end
         if name == "1" or name == "2" or name == "3" and value then self.State = 3 end -- было лень делать для каждого стейт, да и я хз что там да как
         if name == "4" and value then self.State = 4 end
         if name == "5" and value then self.State = 6 end
        end 
       if self.State == 3 and value then if name == "Prev" and value then self.State = self.State -1 end if name == "F1" then self.State = 2 end end  
       if self.State == 4 and value then 
            if not self.TempInt then self.TempInt = 0 end
            if not self.DSelected then self.DSelected = 0 end 
            
            if name == "Up" and value then if self.TempInt > 20 then return end self.TempInt = self.TempInt + 1 end 
            if name == "Down" and value then  self.TempInt = self.TempInt - 1 end 
            if name == "Prev" and value then self.State = self.State - 1 end 
            if name == "F1" and value then self.State = 2 end 
          
       end 
       if self.State == 6 and value then 
        if name == "1" or name == "2" or name == "3" or name == "4" and value then 
            self.DSelected = tonumber(name)
        end 
        if name == "Enter" and value then 
            if self.DSelected == 1 then self.D1 = not self.D1  end 
            if self.DSelected == 2 then self.D2 = not self.D2  end 
            if self.DSelected == 3 then self.D3 = not self.D3 end  
            self.DSelected = 0
        end
        if name == "F1" then self.State = 2 end
    end 
      end
      function TRAIN_SYSTEM:Think(dt)
        local Train = self.Train 
        local Power = Train.VB.Value*Train.A75.Value > 0
        if not Power then self.State = -2 end
        if self.State == 0 then self.State = 1 end
        for k,v in pairs(self.TriggerNames) do
            if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
                self:Trigger(v,Train[v].Value > 0.5)
                self.Triggers[v] = Train[v].Value > 0.5
            end
        end 
        if Power and self.State == -2 then self.State = -1 end
        if self.State == -2 then self.LoadingTimer = CurTime()+30 end 
        if self.State == -1 and not self.LoadingTimer then self.LoadingTimer = CurTime()+30 end 
        if self.State == -1 and self.LoadingTimer and CurTime()-self.LoadingTimer > 1 then 
          self.State = 1   
        end   
        if self.State == 5 and self.EndWorkTimer and CurTime()-self.EndWorkTimer > 1 then 
         self.State = -3 
        end 
        if self.State == -3 and self.StartWorkTimer and CurTime()-self.StartWorkTimer > 1 then 
            self.State = -1
        end  
           
        Train:SetNW2Int("Smode:State",self.State)
        Train:SetNW2Int("Smode:Page",self.Page) 
        Train:SetNW2Int("Smode:TempInt",self.TempInt)
        Train:SetNW2Int("Smode:DSelected",self.DSelected)
        Train:SetNW2Bool("Smode:D1",self.D1)
        Train:SetNW2Bool("Smode:D2",self.D2)
        Train:SetNW2Bool("Smode:D3",self.D3)
      end 
end       

if CLIENT then 
    local function createFont(name,font,size)
        surface.CreateFont("Metrostroi_2K"..name, {
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
    createFont("Smode","Liquid Crystal Display",30)
    function TRAIN_SYSTEM:ClientThink()
        if not self.Train:ShouldDrawPanel("SmodeScreen") then return end
        if not self.DrawTimer then
			render.PushRenderTarget(self.Train.SmodeScreen,0,0,512, 128)
            render.Clear(0, 0, 0, 0)
            render.PopRenderTarget()
        end
        if self.DrawTimer and CurTime()-self.DrawTimer < 0.1 then return end
        self.DrawTimer = CurTime()	
        render.PushRenderTarget(self.Train.SmodeScreen,0,0,512, 128)
		render.Clear(0, 0, 0, 0)
		cam.Start2D()
			self:SmodeScreen(self.Train)
		cam.End2D()           
		render.PopRenderTarget()
    end 
    function TRAIN_SYSTEM:PrintText(x,y,text,inverse,m)
      local str = {utf8.codepoint(text,1,-1)}
        for i=1,#str do
            local char = utf8.char(str[i])
            if inverse then
                draw.SimpleText(string.char(0x7f),"Metrostroi_2KSmode",(x+i)*20.5+5,y*40+40,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText(char,"Metrostroi_2KSmode",(x+i)*20.5+5,y*40+40,Color(140,190,0,150),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            elseif m then 
                draw.SimpleText(" ","Metrostroi_2KSmode",(x+i)*20.5+5,y*40+40,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            else
                draw.SimpleText(char,"Metrostroi_2KSmode",(x+i)*20.5+5,y*40+40,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            end
        end
    end 
    function TRAIN_SYSTEM:SmodeScreen(Train) 
             local State = Train:GetNW2Int("Smode:State",-1) 
            if State == -2 or State == -3 then return end 
    
             surface.SetDrawColor(140,190,0)
             surface.DrawRect(0,0,512,128)	  
            if State == -1 then 
                self:PrintText(0,1.5, "Загрузка системы ...............")
            end 
            if State == 1 then 
                self:PrintText(0,1.5, "F1 - Меню ========================")
            end 
            if State == 2 then 
                 local page = Train:GetNW2Int("Smode:Page",1)
                 self:PrintText(1,-0.5, "=== Главное меню ===")
                 if page == 1 then 
                    self:PrintText(0,0.2, "1.Уставки")
                    self:PrintText(0,1, "2.Автомат.управл.")
                    self:PrintText(0,1.8, "3.Ручное управление")
                 elseif page == 2 then 
                    self:PrintText(0,0.2, "2.Автомат.управл.")
                    self:PrintText(0,1, "3.Ручное управление")
                    self:PrintText(0,1.8, "4.Температуры")
                 elseif page == 3 then 
                    self:PrintText(0,0.2, "3.Ручное управление")
                    self:PrintText(0,1, "4.Температуры")
                    self:PrintText(0,1.8, "5.Датчики")
                 end 
            end 
            if State == 3 then 
                self:PrintText(1,-0.5, "Пусто")
            end 
            if State == 4 then 
            
                self:PrintText(0,-0.5, "t уставка")
                self:PrintText(0,0.3, "t компрессор")
                self:PrintText(0,1, "t салон")
                self:PrintText(0,1.7, "t улица")
                if Train:GetNW2Int("Smode:TempInt") > 0 and Train:GetNW2Bool("Smode:D2") then 
                    self:PrintText(19,1, "+"..Train:GetNW2Int("Smode:TempInt",0)  )
                elseif Train:GetNW2Int("Smode:TempInt") < 0 and Train:GetNW2Bool("Smode:D2") then
                self:PrintText(19,1, tostring(Train:GetNW2Int("Smode:TempInt",0))   )
                elseif not Train:GetNW2Bool("Smode:D2") then 
                self:PrintText(18,1, "Д.Выкл"  )  
                end 
                self:PrintText(18,-0.5, "Д.Нету")
                if not Train:GetNW2Bool("Smode:D1") then 
                    self:PrintText(18,0.3, "Д.Выкл") 
                elseif Train:GetNW2Bool("Smode:D1") then 
                    self:PrintText(19,0.3, "+60") 
                end 
                if not Train:GetNW2Bool("Smode:D3") then  
                    self:PrintText(18,1.7, "Д.Выкл") 
                else 
                    self:PrintText(19,1.7, "+20") 
                end 
             
            end 
            if State == 5 then 
                self:PrintText(1,-0.5, "Завершение работы...",nil,RealTime()%1 > 0.5)
            end 
            if State == 6 then 
                self:PrintText(3,-0.5, "=== Датчики ===")
                self:PrintText(0,0.3, "Д.компрессор")
                self:PrintText(0,1, "Д. салон")
                self:PrintText(0,1.7, "Д. улица")
                local ds = Train:GetNW2Int("Smode:DSelected",0) 
                if ds == 1 then 
                    self:PrintText(18,0.3, Train:GetNW2Bool("Smode:D1") and "Д.Вкл" or "Д.Откл",nil,RealTime()%1 > 0.3)
                else 
                self:PrintText(18,0.3, Train:GetNW2Bool("Smode:D1") and "Д.Вкл" or "Д.Откл")
                end 
                if ds == 2 then 
                    self:PrintText(18,1, Train:GetNW2Bool("Smode:D2") and "Д.Вкл" or "Д.Откл",nil,RealTime()%1 > 0.3) 
                else 
                self:PrintText(18,1, Train:GetNW2Bool("Smode:D2") and "Д.Вкл" or "Д.Откл"  ) 
                end 
                if ds == 3 then 
                    self:PrintText(18,1.7, Train:GetNW2Bool("Smode:D3") and "Д.Вкл" or "Д.Откл",nil,RealTime()%1 > 0.3) 
                else 
                self:PrintText(18,1.7, Train:GetNW2Bool("Smode:D3") and "Д.Вкл" or "Д.Откл") 
                end 
            end 
    end 
end         