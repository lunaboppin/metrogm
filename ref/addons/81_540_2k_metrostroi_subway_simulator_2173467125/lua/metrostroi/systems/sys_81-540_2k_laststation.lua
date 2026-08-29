-- Электронный маршрутный указатель
Metrostroi.DefineSystem("81_540_2k_laststation")
TRAIN_SYSTEM.DontAccelerateSimulation = true
function TRAIN_SYSTEM:Initialize()
        self.CurrStation = ""
        self.Work = false 
        self.Train:LoadSystem("Last_Prev","Relay","Switch",{bass = true})
        self.Train:LoadSystem("Last_Next","Relay","Switch",{bass = true})
        self.TriggerNames = {"Last_Prev", "Last_Next"}  
        self.Triggers = {}
        for k,v in pairs(self.TriggerNames) do
            self.Triggers[v] = false
        end
end 
if TURBOSTROI then return end

function TRAIN_SYSTEM:Inputs()
    return {}
end
if SERVER then 

function TRAIN_SYSTEM:Trigger( n, v )
         local n = n:gsub("Last_","")
         if not v then return end 
         local Train = self.Train 
         if n == "Prev" then 
           if not i then i = 0 end 
           i = i - 1 
           local stations = Prishelez.Lasts or { "обкатка" }
           if i < 0 then i = #stations end 
           self.CurrStation = stations[i]
         end 
         if n == "Next" then 
         if not i then i = 0 end 
         i = i + 1 
         local stations = Prishelez.Lasts or { "обкатка" }
         if i > #stations then i = 0 end 
         self.CurrStation = stations[i]  
         end 
end 

function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
	for k,v in pairs(self.TriggerNames) do 
        if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
            self:Trigger(v,Train[v].Value > 0.5)
            self.Triggers[v] = Train[v].Value > 0.5
        end
    end
    Train:SetNW2String("Inf:Tablo1",self.CurrStation)
end            
end 
