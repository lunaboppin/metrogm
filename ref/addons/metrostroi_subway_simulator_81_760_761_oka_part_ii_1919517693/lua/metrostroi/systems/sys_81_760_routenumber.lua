--------------------------------------------------------------------------------
-- route number
--------------------------------------------------------------------------------

Metrostroi.DefineSystem("81_760_RouteNumber")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.RouteNumber = -1
	self.CurrentLastStation = ""
	self.LastStation = ""
	
	self.LastStationState = 0
	self.IgnoreRoute = false
	self.IgnoreLast = false	
	self.NextLastStation = ""
	self.NextRouteNumber = -1
	self.NextBool = true	
end

function TRAIN_SYSTEM:Outputs()
    return {}
end

function TRAIN_SYSTEM:Inputs()
    return {}
end
if TURBOSTROI then return end
	
local alphabet = {
--              1         2       3        4        5        6        7         8       9        10       11       12       13       14       15       16
	["0"] = {"001100","011110","110011","110011","110011","110011","110011","110011","110011","110011","110011","110011","110011","110011","011110","001100"},
	["1"] = {"001100","001100","011100","111100","101100","001100","001100","001100","001100","001100","001100","001100","001100","001100","111111","111111"},
	["2"] = {"001100","011110","110011","110011","000011","000011","000011","000011","000110","001100","011000","110000","110000","110000","111111","111111"},
	["3"] = {"001100","011110","110011","110011","000011","000011","000011","001110","001110","000011","000011","000011","110011","110011","011110","001100"},
	["4"] = {"000011","000111","000111","001111","001011","011011","010011","110011","100011","111111","111111","000011","000011","000011","000011","000011"},
	["5"] = {"111111","111111","110000","110000","110000","110000","111100","111110","000011","000011","000011","000011","110011","110011","011110","001100"},
	["6"] = {"001100","011110","110011","110011","110000","110000","111100","111110","110011","110011","110011","110011","110011","110011","011110","001100"},
	["7"] = {"111111","111111","000011","000011","000011","000011","000110","001100","011000","110000","110000","110000","110000","110000","110000","110000"},
	["8"] = {"001100","011110","110011","110011","110011","110011","011110","011110","110011","110011","110011","110011","110011","110011","011110","001100"},
	["9"] = {"001100","011110","110011","110011","110011","110011","110011","110011","011111","001111","000011","000011","110011","110011","011110","001100"},
--              1         2       3        4        5        6        7         8       9        10       11       12       13       14       15       16
	["а"] = {"011110","111111","110011","110011","110011","111111","111111","110011","110011","110011","110011","110011"}, 
	["б"] = {"111111","111111","110000","110000","110000","111110","111111","110011","110011","110011","111111","111111"}, 
	["в"] = {"111110","111111","110011","110011","110011","111110","111110","110011","110011","110011","111111","111110"}, 
	["г"] = {"111111","111111","110000","110000","110000","110000","110000","110000","110000","110000","110000","110000"}, 
	["д"] = {"0011100","0110110","0110110","0110110","0110110","0110110","0110110","0110110","0110110","0110110","1111111","1111111"}, 
	["е"] = {"111111","111111","110000","110000","110000","111110","111110","110000","110000","110000","111111","111111"}, 
	["ё"] = {"110011","000000","111111","111111","110000","110000","110000","111110","111110","110000","110000","110000","111111","111111"}, 
	["ж"] = {"110001100011","110001100011","110001100011","011001100110","001101101100","000111111000","000111111000","001101101100","011001100110","110001100011","110001100011","110001100011"}, 
	["з"] = {"011110","111111","110011","000011","000011","001110","001110","000011","000011","110011","111111","011110"}, 
	["и"] = {"1100011","1100011","1100011","1100111","1100111","1101111","1111011","1110011","1110011","1100011","1100011","1100011"}, 
	["й"] = {"0010100","0011100","1100011","1100011","1100011","1100111","1100111","1101111","1111011","1110011","1110011","1100011","1100011","1100011"}, 
--              1         2       3        4        5        6        7         8       9        10       11       12       13       14       15       16		
	["к"] = {"110011","110011","110011","110011","110010","111100","111110","110011","110011","110011","110011","110011"}, 
	["л"] = {"0011111","0111111","1110011","1100011","1100011","1100011","1100011","1100011","1100011","1100011","1100011","1100011"}, 
	["м"] = {"1100011","1100011","1110111","1110111","1111111","1101011","1101011","1100011","1100011","1100011","1100011","1100011"}, 
	["н"] = {"110011","110011","110011","110011","110011","111111","111111","110011","110011","110011","110011","110011"}, 
	["о"] = {"011110","111111","110011","110011","110011","110011","110011","110011","110011","110011","111111","011110"}, 
	["п"] = {"111111","111111","110011","110011","110011","110011","110011","110011","110011","110011","110011","110011"}, 
	["р"] = {"111110","111111","110011","110011","110011","111111","111110","110000","110000","110000","110000","110000"}, 
	["с"] = {"011110","111111","110011","110000","110000","110000","110000","110000","110000","110011","111111","011110"}, 
	["т"] = {"11111111","11111111","00011000","00011000","00011000","00011000","00011000","00011000","00011000","00011000","00011000","00011000"}, 
	["у"] = {"110011","110011","110011","110011","110011","111111","011111","000011","000011","000011","111111","111110"}, 
	["ф"] = {"01111110","11111111","11011011","11011011","11011011","11111111","01111110","00011000","00011000","00011000","00011000","00011000"}, 
--              1         2       3        4        5        6        7         8       9        10       11       12       13       14       15       16		
	["х"] = {"1100011","1100011","1100011","1100011","0110110","0011100","0011100","0110110","1100011","1100011","1100011","1100011"}, 
	["ц"] = {"1100110","1100110","1100110","1100110","1100110","1100110","1100110","1100110","1100110","1100110","1111110","1111111","0000011","0000011"}, 
	["ч"] = {"110011","110011","110011","110011","110011","111111","011111","000011","000011","000011","000011","000011"}, 
	["ш"] = {"1100110011","1100110011","1100110011","1100110011","1100110011","1100110011","1100110011","1100110011","1100110011","1100110011","1111111111","1111111111"}, 
	["щ"] = {"11001100110","11001100110","11001100110","11001100110","11001100110","11001100110","11001100110","11001100110","11001100110","11001100110","11111111111","11111111111","00000000011","00000000011"}, 
	["ъ"] = {"11110000","11110000","00110000","00110000","00110000","00110000","00111110","00111111","00110011","00110011","00111111","00111110"}, 
	["ы"] = {"110000011","110000011","110000011","110000011","110000011","110000011","111110011","111111011","110011011","110011011","111111011","111110011"}, 
	["ь"] = {"110000","110000","110000","110000","110000","110000","111110","111111","110011","110011","111111","111110"}, 
	["э"] = {"011110","111111","110011","000011","000011","001111","001111","000011","000011","110011","111111","011110"}, 
	["ю"] = {"110011110","110111111","110110011","110110011","110110011","111110011","111110011","110110011","110110011","110110011","110111111","110011110"}, 
	["я"] = {"011111","111111","110011","110011","110011","011111","011111","110011","110011","110011","110011","110011"}, 
--              1         2       3        4        5        6        7         8       9        10       11       12       13       14       15       16		
	["A"] = {"011110","111111","110011","110011","110011","111111","111111","110011","110011","110011","110011","110011"}, 
	["B"] = {"111110","111111","110011","110011","110011","111110","111110","110011","110011","110011","111111","111110"}, 
	["C"] = {"011110","111111","110011","110000","110000","110000","110000","110000","110000","110011","111111","011110"}, 
	["D"] = {"111110","111111","110011","110011","110011","110011","110011","110011","110011","110011","111111","111110"}, 
	["E"] = {"111111","111111","110000","110000","110000","111110","111110","110000","110000","110000","111111","111111"}, 
	["F"] = {"111111","111111","110000","110000","110000","111110","111110","110000","110000","110000","110000","110000"}, 
	["G"] = {"001100","011110","110011","110011","110000","111100","111110","110011","110011","110011","011110","001100"}, 
	["H"] = {"110011","110011","110011","110011","110011","111111","111111","110011","110011","110011","110011","110011"}, 
	["I"] = {"11","11","11","11","11","11","11","11","11","11","11","11"}, 
	["J"] = {"000011","000011","000011","000011","000011","000011","000011","000011","110011","110011","011110","001100"}, 
--              1         2       3        4        5        6        7         8       9        10       11       12       13       14       15       16				
	["K"] = {"110011","110011","110011","110011","110010","111100","111110","110011","110011","110011","110011","110011"}, 
	["L"] = {"110000","110000","110000","110000","110000","110000","110000","110000","110000","110000","111111","111111"}, 
	["M"] = {"1100011","1100011","1110111","1110111","1111111","1101011","1101011","1100011","1100011","1100011","1100011","1100011"}, 
	["N"] = {"1100011","1100011","1100011","1110011","1110011","1111011","1101111","1100111","1100111","1100011","1100011","1100011"}, 
	["O"] = {"011110","111111","110011","110011","110011","110011","110011","110011","110011","110011","111111","011110"}, 
	["P"] = {"111110","111111","110011","110011","110011","111111","111110","110000","110000","110000","110000","110000"}, 
	["Q"] = {"01111000","11111100","11001100","11001100","11001100","11001100","11001100","11001100","11001100","11001100","11111100","01111111","00000011","00000011"}, 
	["R"] = {"111110","111111","110011","110011","110011","111110","111110","110011","110011","110011","110011","110011"}, 
	["S"] = {"011110","111111","110011","110000","110000","011100","001110","000011","000011","110011","111111","011110"}, 
	["T"] = {"11111111","11111111","00011000","00011000","00011000","00011000","00011000","00011000","00011000","00011000","00011000","00011000"}, 
--              1         2       3        4        5        6        7         8       9        10       11       12       13       14       15       16				
	["U"] = {"1100011","1100011","1100011","1100011","1100011","1100011","1100011","1100011","1100011","1100011","1111111","0111110"}, 
	["V"] = {"11000011","11000011","11000011","11000011","11000011","11000011","11000011","11000011","11000011","01100110","00111100","00011000"}, 
	["W"] = {"11000000011","11000000011","11000000011","11000000011","11000000011","11000100011","11000100011","11001110011","11001010011","01101010110","00111011100","00010001000"}, 
	["X"] = {"1100011","1100011","1100011","1100011","0110110","0011100","0011100","0110110","1100011","1100011","1100011","1100011"}, 
	["Y"] = {"110011","110011","110011","110011","110011","111111","011111","000011","000011","000011","111111","111110"}, 
	["Z"] = {"111111","111111","000011","000011","000011","000110","001100","011000","110000","110000","111111","111111"}, 
	
	["."] = {"00","00","00","00","00","00","00","00","00","00","11","11"}, 
	[" "] = {"0","0","0","0","0","0","0","0","0","0","0","0"}, 	
	["x"] = {"000","000","101","010","101","000","000","000","000","000","000","000"}, 	
	["y"] = {"0000","0001","0011","0011","1111","0011","0011","0011","0011","0011","0011"}, 	
	["z"] = {"0000","0110","1001","1001","0001","0001","0010","0100","1000","1000","1111"},--{"01110","11111","11011","00011","00011","00110","01100","11000","11000","11000","11111","11111"}, 	
}
local alphabetparamaters = {
	["ц"] = 0,["щ"] = 0,["Q"] = 0,
	["1"] = 0.5,["2"] = 0.5,["3"] = 0.5,["4"] = 0.5,["5"] = 0.5,["6"] = 0.5,["7"] = 0.5,["8"] = 0.5,["9"] = 0.5,["0"] = 0.5,
}
local symb = {
	["А"] = 'а',["Б"] = 'б',["В"] = 'в',["Г"] = 'г',["Д"] = 'д',["Е"] = 'е',["Ё"] = 'ё',["Ж"] = 'ж',["З"] = 'з',["И"] = 'и',["Й"] = "й",
	["К"] = "к",["Л"] = "л",["М"] = 'м',["Н"] = 'н',["О"] = 'о',["П"] = 'п',["Р"] = 'р',["С"] = 'с',["Т"] = 'т',["У"] = 'у',["Ф"] = 'ф',
	["Х"] = 'х',["Ц"] = 'ц',["Ч"] = 'ч',["Ш"] = 'ш',["Щ"] = 'щ',["Ъ"] = 'ъ',["Ы"] = 'ы',["Ь"] = 'ь',["Э"] = 'э',["Ю"] = 'ю',["Я"] = 'я',

	["a"] = "A",["b"] = "B",["c"] = "C",["d"] = "D",["e"] = "E",["f"] = "F",["g"] = "G",["h"] = "H",["i"] = "I",["j"] = "J",["k"] = "K",["l"] = "L",["m"] = "M",
	["n"] = "N",["o"] = "O",["p"] = "P",["q"] = "Q",["r"] = "R",["s"] = "S",["t"] = "T",["u"] = "U",["v"] = "V",["w"] = "W",["x"] = "X",["y"] = "Y",["z"] = "Z", 
}	
local s2 = 'аеёиоуыэюяьAEIOUY'
TRAIN_SYSTEM.RouteNumberFont = {}
for i,num in pairs(alphabet) do
    --if not TRAIN_SYSTEM.RouteNumberFont[i] then TRAIN_SYSTEM.RouteNumberFont[i] = {} end
    TRAIN_SYSTEM.RouteNumberFont[i] = {}
	local numtbl = TRAIN_SYSTEM.RouteNumberFont[i]
    for ir,row in pairs(num) do
        if not numtbl[ir] then numtbl[ir] = {} end
        local rowtbl = numtbl[ir]
        for ic=1,#row do
            rowtbl[ic] = (row[ic] ~= "0")
        end
    end
	--[[
	if alphabetparamaters[i] then
		TRAIN_SYSTEM.RouteNumberFont[i].ignorey = true
	end]]
end
TRAIN_SYSTEM.RouteNumberFontX = {}
for i,num in pairs(alphabet) do
	TRAIN_SYSTEM.RouteNumberFontX[i] = {}
	for x=1,#num[1] do
		TRAIN_SYSTEM.RouteNumberFontX[i][x] = {}
		for y=1,#num do
			TRAIN_SYSTEM.RouteNumberFontX[i][x][y]=(num[y][x] ~= "0")	
		end
		if alphabetparamaters[i] then
			TRAIN_SYSTEM.RouteNumberFontX[i][x].ignorey = alphabetparamaters[i]
		end
		if string.find(i,s2) then
			TRAIN_SYSTEM.RouteNumberFontX[i][x].vowel = true 
		end
	end
	if alphabetparamaters[i] then
		TRAIN_SYSTEM.RouteNumberFontX[i].ignorey = alphabetparamaters[i]
	end		
	if string.find(i,s2) then
		TRAIN_SYSTEM.RouteNumberFontX[i].vowel = true 
	end	
end
TRAIN_SYSTEM.RouteNumberFontX[" "].special = true
TRAIN_SYSTEM.RouteNumberFontX[" "][1].special = true

local function sl(s,pr,br)
	if not s or utf8.len(s) == 0 then return "" end
	if s == "                        xxx   y   xxx" or s == "                        xxx   z   xxx" then return s end
	s=string.lower(s)
	local s1 = ''
	local str = {utf8.codepoint(s,1,-1)}
	for i=1,#str do	
		local char1 = utf8.char(str[i])	
		local char = symb[char1] or char1
		--if i >= 10 and utf8.len(s) > 12 and not string.find(s2,char) and not br then
			--s1=s1..char.." ."
			--break
		--else
		if i == #str then
			s1=s1..char --..(pr and #str ~= i and " " or "")
		else
			s1=s1..char.." "
		end
		--end
	end
	return s1
end

function TRAIN_SYSTEM:findpixels(text)
	if utf8.len(text) == 0 then return 0 end
	local x0,char = 112	
	local str,count = {utf8.codepoint(text,1,-1)},0
	for k=1,#str do
		char = utf8.char(str[k])
		local tbl = self.RouteNumberFont[char]
		if tbl then
			if x0+5*#tbl[1] >= 540 and k+2 ~= #str or x0+5*#tbl[1] > 545 then
				tbl=self.RouteNumberFont["."]
			end		
			--if char ~= " " then
			count=count+#tbl[1]+1
			--end
			if x0+5*#tbl[1] >= 540 and k+2 ~= #str or x0+5*#tbl[1] > 545 then
				break
			end
			x0=x0+5*(#tbl[1]+1)	
		end
	end
	--count = count--+(self.RouteNumberFont[char] and #self.RouteNumberFont[char][1] or 0)
	return count--+(self.RouteNumber ~= -1 and 18 or 0)
end


if SERVER then
	function TRAIN_SYSTEM:TriggerInput(name,value,value2)
		if value and name == "LastStation" then
			if (self.NextLastStation ~= value or (not value2 or self.NextRouteNumber ~= value2)) and not self.NextLastStationTimer then
				self.NextLastStation = value
				if value2 then
					self.NextRouteNumber = value2
				end
				self.LastStationState = -1												
				self.NextLastStationTimer = CurTime()
			end
		end
		--[[
		if name == "RouteNumber" and value then
			--self.RouteNumber = value
			if self.RouteNumber ~= value then
				if not self.NextLastStationTimer and self.LastStationState == math.max(self:findpixels(sl(self.CurrentLastStation)),self:findpixels(sl(self.NextLastStation)))+18 then
					self.NextRouteNumber = value
					self.LastStationState = -1							
					self.NextLastStationTimer = CurTime()
				end
			end
		end
		if name == "LastStation" and value then
			if self.LastStation ~= value then
				if not self.NextLastStationTimer then
					self.NextLastStation = value
					self.LastStationState = -1												
					self.NextLastStationTimer = CurTime()
				end
			end
		end]]
	end
	function TRAIN_SYSTEM:Think(dT)
		local Train = self.Train
		local Power = Train.Electric.Battery80V > 0
		Train:SetNW2Bool("RouteNumberPower",Power)
		local Power1 = (Train.SF37.Value+Train.SF38.Value > 0) --Train.SF12.Value+Train.SF13.Value > 0
		Train:SetNW2Bool("RouteNumberPower1",Power1)
		if Power1 or self.LastStationState > 0 then
			local num = math.max(self:findpixels(sl(self.CurrentLastStation)),self:findpixels(sl(self.NextLastStation)))+18--+(self.RouteNumber and 18 or 0)
			if self.LastStationState >= 18 and self.RouteNumber ~= self.NextRouteNumber and not self.NextLastStationTimer then
				self.RouteNumber = self.NextRouteNumber
			end
			if self.NextLastStationTimer and CurTime()-self.NextLastStationTimer > 2 then--and self.LastStationState == self:findpixels(sl(self.LastStation)) then
				self.NextLastStationTimer = nil
                self.LastStationState = -1 --self.LastStationState-1								
				--self.CurrentLastStation = self.NextLastStation
				self.NextBool = true
			end
			if Power then
				if Power1 then
					if not self.NextLastStationTimer and (not self.LastStationUpdateDelay or self.LastStationUpdateDelay and CurTime()-self.LastStationUpdateDelay > 0.1) then
						--[[
						if self.LastStationState >= 0 and (self.LastStation ~= self.NextLastStation or self.IgnoreLast) then
							self.LastStationState = -1 --self.LastStationState-1
							--Train:PlayOnce("blinker_off"..(self.LastStationState%2+1),"bass",0.6+math.random()*0.3,1)					
						end]]
						
						--print(self.LastStation,self.NextLastStation,num,self.LastStationState)
						if self.LastStationState < num and not self.IgnoreLast and not self.NextBool then--self.LastStation == self.CurrentLastStation and not self.IgnoreLast then
							self.LastStationState = self.LastStationState+1
							if self.LastStationState == num then
								self.CurrentLastStation = self.NextLastStation
								self.NextBool = false
							end
							--Train:PlayOnce("blinker_on"..(self.LastStationState%2+1),"bass",0.6+math.random()*0.3,1)
						end
						if self.LastStationState <= 0 and (self.NextBool or self.IgnoreLast) then
							self.LastStationState = self.LastStationState+1
							self.IgnoreLast = false			
							self.NextBool = false
							--Train:PlayOnce("blinker_on"..(self.LastStationState%2+1),"bass",0.6+math.random()*0.3,1)
						end
						self.LastStationUpdateDelay = CurTime()				
					end
				else
					if not self.LastStationUpdateDelay or self.LastStationUpdateDelay and CurTime()-self.LastStationUpdateDelay > 0.1 then
						self.LastStationState = math.max(0,self.LastStationState - 1)
						self.LastStationUpdateDelay = CurTime()					
					end
				end
			end
		end
		if Power1 ~= self.Power1 then	
			self.Power1 = Power1
			if not Power1 then
				self.CurrentLastStation = ""
			else
				self.RouteNumber = -1
			end
			self.IgnoreLast = not Power1
		end
		if Power ~= self.Power then
			self.Power = Power
			self.IgnoreLast = false
		end
        Train:SetNW2Int("LastStationState",self.LastStationState)
		Train:SetNW2Int("RouteNumber:RouteNumber",self.RouteNumber)
        Train:SetNW2Int("RouteNumber:LastStation",self.CurrentLastStation)--self.LastStation)		
		Train:SetNW2Int("NextRouteNumber",self.NextRouteNumber)
		Train:SetNW2String("NextLastStation",self.NextLastStation)
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
            shadow = false,
            additive = false,
            outline = false,
            extended = true,
            scanlines = scanlines or false,
        })
    end
	createFont("bmt09","bmt09",125,400,0,0,false)--125 25
	createFont("bmt091","bmt pixel",125,400,0,0,false)--125 25
	function TRAIN_SYSTEM:ClientInitialize()
        self.RouteNumberNeedUpdate = true
        self.Work = false		
		self.Power = false
		self.CurrentLastStation = ""		
		self.LastStationState = 0
		self.NextLastStation = ""
        self.CurrentRouteNumber = -1
		self.NextRouteNumber = -1
		--self.X = -2
		--self.Y = 0
	end
    function TRAIN_SYSTEM:ClientThink()
		local Train = self.Train
        if Train:ShouldDrawPanel("RouteNumber") and self.RouteNumberNeedUpdate then	
			render.PushRenderTarget(Train.RouteNumbers,0,0,552, 128)
			render.Clear(0, 0, 0, 0)
			cam.Start2D()
				self:RouteNumber(Train)
			cam.End2D()
			render.PopRenderTarget()
            self.RouteNumberNeedUpdate = false
		end
		local routenum,work,work2,lastst = Train:GetNW2Int("RouteNumber:RouteNumber",-1),Train:GetNW2Bool("RouteNumberPower",false),Train:GetNW2Bool("RouteNumberPower1",false),Train:GetNW2String("RouteNumber:LastStation")--Train:GetNW2String("BMCISLastSt","")--,Train:GetNW2Int("NextRouteNumber",0)
        local state2 = self.Train:GetNW2Int("LastStationState",0)		
		if self.Work ~= work or self.Power ~= work2 or (routenum ~= self.CurrentRouteNumber or self.CurrentLastStation ~= lastst  or state2 ~= self.LastStationState) then --or self.NextRouteNumber ~= nextroute then
            self.RouteNumberNeedUpdate = true	
			--self.X=-2
			--self.NextRouteNumber = nextroute
			self.Work = work
			self.Power = work2
			if self.Work then
				self.CurrentRouteNumber = routenum			
				self.CurrentLastStation = lastst
				self.LastStationState = state2
				self.NextRouteNumber = Train:GetNW2Int("NextRouteNumber",-1)
				self.NextLastStation = Train:GetNW2String("NextLastStation","")
			end
			--self.CurTime2 = CurTime()
		end
		--self.RouteNumberNeedUpdate = true
    end
	local function utf8sub(s,i,j) 
		i = i or 1
		j = j or -1
		if i<1 or j<1 then
			local n = utf8.len(s)
			if not n then return nil end
			if i<0 then i = n+1+i end
			if j<0 then j = n+1+j end
			if i<0 then i = 1 elseif i>n then i = n end
			if j<0 then j = 1 elseif j>n then j = n end
		end
		if j<i then return "" end
		i = utf8.offset(s,i)
		j = utf8.offset(s,j+1)
		if i and j then return s:sub(i,j-1)
			elseif i then return s:sub(i)
			else return ""
		end
	end
	local font = "Metrostroi_760_bmt09"	
	local col2 = Color(47,85,16)
	function TRAIN_SYSTEM:PrintText(x0,y0,text,col)
		local str = {utf8.codepoint(text,1,-1)}
		for k=1,#str do
			local char = utf8.char(str[k])
			--draw.SimpleText(char,font,x1,y1,col,TEXT_ALIGN_LEFT)
			local tbl = self.RouteNumberFont[char]
			if tbl then
				local y1 = y0
				if #tbl > 12 and not tonumber(char) then y1 = y0-5*(#tbl-12)*(alphabetparamaters[char] or 1) end
				if tonumber(char) then y1 = y0-10 end
				for x=0,#tbl[1]-1 do
					for y=0,#tbl-1 do
						if tbl[y+1][x+1] then --and (self.X+2 > x0+5*x or self.X+2 == x0+5*x and -self.Y > -(y1+5*y)) then
							draw.SimpleText(sl(".",false),font.."1",x0+7+5*x,y1+5*y,col,TEXT_ALIGN_LEFT)											
						end			
					end
				end
				x0=x0+5*(#tbl[1]+1)
				--if utf8.char(str[k]) ~= utf8.char(str[#str-(utf8.len(text) == len(text) and 1 or 2)]) and utf8.char(str[k]) ~= utf8.char(str[#str]) then
					if x0+5*#tbl[1] >= 535 then
						draw.SimpleText(sl(".",false),font.."1",x0+7,y1+55,col,TEXT_ALIGN_LEFT)												
						draw.SimpleText(sl(".",false),font.."1",x0+7,y1+50,col,TEXT_ALIGN_LEFT)												
						draw.SimpleText(sl(".",false),font.."1",x0+12,y1+55,col,TEXT_ALIGN_LEFT)												
						draw.SimpleText(sl(".",false),font.."1",x0+12,y1+50,col,TEXT_ALIGN_LEFT)												
						return
					end
				--end
			end
			--x=x+50
		end
	end	
	function TRAIN_SYSTEM:RouteNumber(Train)
		if not self.Power and (self.LastStationState <= 0) then return end
		local maxnum = math.max(self:findpixels(sl(self.CurrentLastStation)),self:findpixels(sl(self.NextLastStation)))
		local col = self.Work --[[self.LastStationState == maxnum]] and Color(141,255,49) or Color(47,85,16)--Color(0,255,0)
		--[[
		if self.CurrentRouteNumber ~= -1 then
			local routen = Format("%03d",self.CurrentRouteNumber)--.."   "..Train:GetNW2String("BMCISLastSt","")
			draw.SimpleText(sl(routen,true),font,7,-18,col,TEXT_ALIGN_LEFT)
		end]]
		--local count = self.LastStationState
		--if self.CurrentRouteNumber ~= -1 then
		local num = self.CurrentRouteNumber == -1 and "ННН" or Format("%03d",self.CurrentRouteNumber)
		local nextnum = self.NextRouteNumber == -1 and "ННН" or Format("%03d",self.NextRouteNumber)
		--local x0 = -5
		if self.Power then
			for k=1,3 do
				local number = self.RouteNumberFont[num[k]]
				local number2 = self.RouteNumberFont[nextnum[k]]
				for x=0,5 do
					for y=0,15 do
						if self.LastStationState <= (x+1)+6*(k-1) then
							if number and number[y+1][x+1] then
								draw.SimpleText(sl(".",false),font.."1",-33+35*k+5*x,-94+5*y,col,TEXT_ALIGN_LEFT)											
							end
						end
						if self.LastStationState >= (x+1)+6*(k-1) then
							if number2 and number2[y+1][x+1] then
								draw.SimpleText(sl(".",false),font.."1",-33+35*k+5*x,-94+5*y,col,TEXT_ALIGN_LEFT)											
							end
						end
					end
				end
			end		
		else
			for k=1,3 do
				local number2 = self.RouteNumberFont[nextnum[k]]
				for x=0,5 do
					for y=0,15 do
						if self.LastStationState >= (x+1)+6*(k-1) then
							if number2 and number2[y+1][x+1] then
								draw.SimpleText(sl(".",false),font.."1",-33+35*k+5*x,-94+5*y,col,TEXT_ALIGN_LEFT)											
							end
						end
					end
				end
			end		
		end
		if self.NextLastStation ~= "" then
			local last = sl(self.CurrentLastStation)
			local nextlast = sl(self.NextLastStation)
			local x0 = 0
			local tbl,count = {},0
			if utf8.len(last) > 0 then
				local str = {utf8.codepoint(last,1,-1)}
				for i=1,#str do
					local char = utf8.char(str[i])
					if self.RouteNumberFontX[char] then
						for k=1,#self.RouteNumberFontX[char] do
							count=count+1
							tbl[count] = self.RouteNumberFontX[char][k]
							--tbl[count].ignorey = self.RouteNumberFontX[char].ignorey
						end
					end
				end
			end
			local str = {utf8.codepoint(nextlast,1,-1)}
			local tbl2,count = {},0
			for i=1,#str do
				local char = utf8.char(str[i])
				if self.RouteNumberFontX[char] then
					for k=1,#self.RouteNumberFontX[char] do
						count=count+1
						tbl2[count] = self.RouteNumberFontX[char][k]
						--tbl2[count].ignorey = self.RouteNumberFontX[char].ignorey
					end
				end
			end				
			if self.Power then
				for x=0,maxnum do --self.LastStationState-18 do
					local tbl1 = tbl2[x]
					if self.LastStationState-18 >= x then		
						--print(tbl1)
						if tbl1 then
							for y=1,#tbl1 do
								if tbl1[y] then -- == "1" then
									draw.SimpleText(sl(".",false),font.."1",107+x*5,-89+5*y+5*(#tbl1 > 12 and (tbl1.ignorey and tbl1.ignorey or 1)*(12-#tbl1) or 0),col,TEXT_ALIGN_LEFT)			
								end
							end
							--print(tbl1.special and x+12, self.LastStationState-18 )
							if (tbl1.special) and x+13 >= 87 then
								local lasts = x
								for k=x,math.max(87,self.LastStationState-18) do
									local tbl3 = tbl2[k]
									if tbl3 and tbl3.special then
										lasts = k
										break
									end
								end
								--print(lasts,x)
								if lasts >= 83 and lasts == x then
									draw.SimpleText(sl(".",false),font.."1",107+x*5+5*(x>=87 and 0 or 1),-29,col,TEXT_ALIGN_LEFT)												
									draw.SimpleText(sl(".",false),font.."1",112+x*5+5*(x>=87 and 0 or 1),-29,col,TEXT_ALIGN_LEFT)												
									draw.SimpleText(sl(".",false),font.."1",107+x*5+5*(x>=87 and 0 or 1),-34,col,TEXT_ALIGN_LEFT)												
									draw.SimpleText(sl(".",false),font.."1",112+x*5+5*(x>=87 and 0 or 1),-34,col,TEXT_ALIGN_LEFT)	
									break					
								end
							end			
						end
					end
					if self.LastStationState-18 <= x then
						local tbl1 = tbl[x] 
						if tbl1 then
							for y=1,#tbl1 do
								if tbl1[y] then-- == "1" then
									draw.SimpleText(sl(".",false),font.."1",107+x*5,-89+5*y+5*(#tbl1 > 12 and (tbl1.ignorey and tbl1.ignorey or 1)*(12-#tbl1) or 0),col,TEXT_ALIGN_LEFT)			
								end
							end
							if (tbl1.special) and x+13 >= 87 then
								local lasts = x
								for k=x,math.max(87,self.LastStationState-18) do
									local tbl3 = tbl[k]
									if tbl3 and tbl3.special then
										lasts = k
										break
									end
								end
								--print(lasts,x)
								if lasts >= 83 and lasts == x then
									draw.SimpleText(sl(".",false),font.."1",107+x*5+5*(x>=87 and 0 or 1),-29,col,TEXT_ALIGN_LEFT)												
									draw.SimpleText(sl(".",false),font.."1",112+x*5+5*(x>=87 and 0 or 1),-29,col,TEXT_ALIGN_LEFT)												
									draw.SimpleText(sl(".",false),font.."1",107+x*5+5*(x>=87 and 0 or 1),-34,col,TEXT_ALIGN_LEFT)												
									draw.SimpleText(sl(".",false),font.."1",112+x*5+5*(x>=87 and 0 or 1),-34,col,TEXT_ALIGN_LEFT)	
									break					
								end
							end				
						end						
					end
				end
				--[[
				for k=1,math.max(str and #str or 0,str2 and #str2 or 0) do
					local char,char2 = utf8.char(str[k]),utf8.char(str2[k])
					local tbl = self.RouteNumberFont[char] or {}
					local tbl2 = self.RouteNumberFont[char2] or {}
					for x=0,math.max(#tbl > 0 and #tbl[1]-1 or 0,#tbl2 > 0 and #tbl2[1]-1 or 0) do
						for y=0,math.max(#tbl-1,#tbl2-1) do
							if self.LastStationState-18 < count+x then
								if tbl and tbl[y+1] and tbl[y+1][x+1] then
									draw.SimpleText(sl(".",false),font.."1",112+x0+x*5,-84+5*y,col,TEXT_ALIGN_LEFT)
								end
							else
								if tbl2 and tbl2[y+1] and tbl2[y+1][x+1] then
									draw.SimpleText(sl(".",false),font.."1",112+x0+x*5,-84+5*y,col,TEXT_ALIGN_LEFT)									
								end
							end
						end
					end		
					x0=x0+math.max(#tbl > 0 and #tbl[1] or 0,#tbl2 > 0 and #tbl2[1] or 0)*5+5
					count = count+math.max(#tbl > 0 and #tbl[1] or 0,#tbl2 > 0 and #tbl2[1] or 0)
				end]]
			else
				for x=0,self.LastStationState-18 do --self.LastStationState-18 do
					local tbl1 = tbl2[x]
					--print(tbl1)
					if tbl1 then
						for y=1,#tbl1 do
							if tbl1[y] then -- == "1" then
								draw.SimpleText(sl(".",false),font.."1",107+x*5,-89+5*y+5*(#tbl1 > 12 and (tbl1.ignorey and tbl1.ignorey or 1)*(12-#tbl1) or 0),col,TEXT_ALIGN_LEFT)			
							end
						end
						--print(tbl1.special and x+12, self.LastStationState-18 )
						if (tbl1.special) and x+13 >= 87 then
							local lasts = x
							for k=x,math.max(87,self.LastStationState-18) do
								local tbl3 = tbl2[k]
								if tbl3 and tbl3.special then
									lasts = k
									break
								end
							end
							--print(lasts,x)
							if lasts >= 83 and lasts == x then
								draw.SimpleText(sl(".",false),font.."1",107+x*5+5*(x>=87 and 0 or 1),-29,col,TEXT_ALIGN_LEFT)												
								draw.SimpleText(sl(".",false),font.."1",112+x*5+5*(x>=87 and 0 or 1),-29,col,TEXT_ALIGN_LEFT)												
								draw.SimpleText(sl(".",false),font.."1",107+x*5+5*(x>=87 and 0 or 1),-34,col,TEXT_ALIGN_LEFT)												
								draw.SimpleText(sl(".",false),font.."1",112+x*5+5*(x>=87 and 0 or 1),-34,col,TEXT_ALIGN_LEFT)	
								break					
							end
						end			
					end
				end
			end
		end
		--draw.SimpleText(sl("1234567890",true,Train:GetNW2Bool("BMCISLastSt1",false)),font,114,-18,col,TEXT_ALIGN_LEFT)
		--draw.SimpleText(sl("3",true),font,7,-18,col,TEXT_ALIGN_LEFT)
		
		--self.CurTime=CurTime()
		--render.SetScissorRect( 2,0,self.X+2,90,false)		
	end
end
