Metrostroi.DefineSystem("81_760_AsyncInverter")
TRAIN_SYSTEM.DontAccelerateSimulation = false

function TRAIN_SYSTEM:Initialize()
    -- Train state/sensors
    self.Speed = 0                  -- Speed of train in km/h

    -- Physics state
    self.RotationRate = 0.0         -- Rate of engine rotation, rpm
    self.Torque = 0.0               -- Relative units of torque
    self.TargetCurrent = 0.0        -- Target Current, that inverter will hold

    -- Inverter state
    self.Mode = 0                   -- 0: coast, 1: drive, -1: brake
    self.Power = 0
    self.EDone = 0
    self.State = 0.0                -- Inverter on/off
    self.InverterFrequency = 0.0    -- Output per-phase frequency, Hz
    self.Current = 0.0              -- Total electric current, A

    -- Inverter input signals
    self.Voltage = 750              -- Third rail voltage
    self.Drive = 0                  -- Drive mode signal
    self.Brake = 0                  -- Brake model signal
    self.State = 0                  -- Power level (PWM)
end

function TRAIN_SYSTEM:Inputs()
    return { "Voltage", "Speed",
             "Drive", "Brake", "Power",}
end

function TRAIN_SYSTEM:Outputs()
    return { "Drive","Brake","Mode","Torque", "Current", "State", "InverterFrequency","EDone","Power" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
    if self[name] then self[name] = value end
end

local function Rand(a,b)
	return a+(b-a)*math.random()
end

local function lerp(min,max, alpha)
    return min + math.min(1,math.max(0,alpha))*(max-min)
end
local function interpolate(tbl, num)
  for i=1,#tbl do
    local curr,next = tbl[i],tbl[i+1]
    if not next then
      return curr[2]
    elseif curr[1] <= num and num <= next[1] then
      return curr[2] + (next[2]-curr[2])*((num-curr[1])/(next[1]-curr[1]))
    end
  end
end

TRAIN_SYSTEM.xTorque = {
	{0	,1.65},
	{150,1.65},
	{200,1.7},
	{260,1.26},
	{320,1.11},
	{340,1.05},
}
TRAIN_SYSTEM.xF = {
	{0, 0.10},
	{1, 1.507},
	{3, 4.16},
	{5, 6.96},
	{10, 14.16},
	{15, 21.31},
	{20, 28.30},
	{30, 41.71},
	{40, 55.01},
	{60, 81.67},
	{80, 108.33},
	{90, 121.61},
}


local max,min,abs,pi = math.max,math.min,math.abs,math.pi
function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    local v = max(1,self.Speed)--при малой скорости игнорирует сигналы

    self.Voltage = Train.Electric.Main750V
	
	local HV = self.Voltage >= 550 and self.Voltage <= 975
    -- Generate on/off signal
    local TargetMode = 0
    if self.Brake*self.Power > 0.5 and (self.Mode<0 or HV) then--self.Voltage>550) then
        TargetMode = -1
    elseif self.Drive*self.Power > 0.5 then
        TargetMode = 1
    end
    self.EDone = self.Brake*((v<=7 or self.Mode>=0 and not HV) and 1 or 0)
    -- Check correct mode
    if TargetMode ~= self.Mode then
         if self.State < 0.01 then
             self.Mode = TargetMode
         end
     end
    if self.Power == 0 or (not HV and self.Mode > 0) then
        self.Mode = 0
    end

    local Inverter_PWM0 = 1.5     -- PWM On
    local Inverter_PWM1 = 2--TargetMode==0 and 0.5 or 1.5     -- PWM Off
    -- PWM target command
    -- Adjust state as defined by mode
    if self.Mode == TargetMode and TargetMode ~= 0 and self.EDone ==0 then
		self.State = max(0,min(1,self.State + (abs(self.TargetCurrent)-abs(self.Current))/400*Rand(0.9,1.15)*Inverter_PWM0*dT))		
    else
        self.State = max(0, self.State - Inverter_PWM1*Rand(0.9,1.15)*dT)
    end
    -- Generate voltage/frequency
	self.InverterFrequency = interpolate(self.xF,v)
	
    -- Voltage set by inverter
    local V = 750 * self.State * self.Mode

    -- Physical parameters for the engine
    local P = 4     -- No of poles          Poles in the engine
	
    local R1 = 0.03 -- Ohm                  Active stator resistance
    local R2 = 0.03 -- Ohm                  Active rotor resistance
    local X1 = 1.1  -- Ohm reactive         Reactive stator resistance
    local X2 = 1.1  -- Ohm reactive         Reactive rotor resistance
    local Xm = 30   -- Ohm reactive         Air gap reactive resistance
	-- Get rate of engine rotation
    local n = min(3607,3200 * (v/80))
    self.RotationRate = self.RotationRate + 5.0 * (n - self.RotationRate) * dT

    -- Frequency set by inverter
    local f = self.InverterFrequency --(n/26.3)^0.978 --self.InverterFrequency -- Hz

    -- Synchronous RPM, synchronous rate and slip
    local ns = 120*(f/P)			-- rpm
    local ws = (2*pi*ns)/60  	    -- rad/sec
    local s = (ns - n)/ns			-- slip
	
	local R = math.sqrt((R1+R2/s)^2+(X1+X2)^2)
	local I = V/Xm+V/R -- I=I0(Iпуска = U/Zk)+I2п(Iротора)             значение тока ротора (I2) в рабочем контуре Г-образной схемы замещения, где знаменатель представляет полное сопротивление рабочего контура	
	local xTorque = interpolate(self.xTorque,abs(I))
	local Torque = (2*3*V^2*R2/(2*pi*f*s*R^2))*0.000744*self.Mode*xTorque -- *0.000736
	
	--print(string.format("v=%.1fкм/ч a=%.2fм/с^2  I=%.1fА s=%.3f f=%.2f",self.Speed, Torque, I,s,f))
	
	-- Output torque
    self.Current = I
    self.Torque = Torque
end
