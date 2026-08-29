--------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_760_Ticker")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
end

if TURBOSTROI then return end

function TRAIN_SYSTEM:Inputs()
	return {}
end

function TRAIN_SYSTEM:Outputs()
	return {}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end
if CLIENT then
	function TRAIN_SYSTEM:ClientInitialize()
	end
  local function createFont(name,font,size)
  	surface.CreateFont("Metrostroi_760_"..name, {
  		font = font,
  		size = size,
  		weight = 00,
  		blursize = false,
  		antialias = true,
  		underline = false,
  		italic = false,
  		strikeout = false,
  		symbol = false,
  		rotary = false,
  		shadow = false,
  		additive = true,
  		outline = false,
  		extended = true,
  		scanlines = false,
  	})
  end
  --createFont("Tickers","Advanced LED Board-7",49,400)
  createFont("BIT","Moscow metro 1 v2 round",39)
  function TRAIN_SYSTEM:ClientThink()
		local str = self.Train:GetNW2String("TickerMessage","")
		local pos = self.Train:GetNW2Int("TickerState",0)
		if self.Text ~= str or self.Position ~= pos then
			self.Text = str
			self.Position = pos
	  	render.PushRenderTarget(self.Train.Tickers,0,0,1024*2,2*64)
	  	render.Clear(0, 0, 0, 0)
	  	cam.Start2D()
	  		self:Tickers(self.Train)
	  	cam.End2D()
	  	render.PopRenderTarget()
		end
  end
  function TRAIN_SYSTEM:PrintText(x,text,inverse)
  	local str = {utf8.codepoint(text,1,-1)}
  	for i=0,#str-1 do
			local xpos = i*30.66+x*3.005
			--if i*26.5+x*3.005+20 < 0 then continue end
			--if (i-33)*26.5+x*3.005+20 > 0 then continue end
			if -26.5 < xpos and xpos < 472.5 then--27*17.5 then
				local char = utf8.char(str[i+1])
				local advert = self.Train:GetNW2Int("TickerAdvert",0)
				local init = self.Train:GetNW2Bool("TickerInit",false)
				draw.SimpleText(char,"Metrostroi_760_BIT",xpos+20,30,init and Color(255,133,0) or (self.Train:GetNW2Bool("TickerRed",false) and Color(255,0,0) or (advert == 0 or advert == #Metrostroi.TickerAdverts+1) and Color(80,255,120) or Color(255,133,0)),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
      --draw.SimpleText(char,"Metrostroi_Tickers",(x+i)*20.5+8,34,Color(0,255,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
  	end
  end

  function TRAIN_SYSTEM:Tickers(Train)
		if self.Text  ~= "" then
    	self:PrintText(self.Position,self.Text)
		end
  end 
  return
end
function TRAIN_SYSTEM:Initialize()
	self.Advert = -1
	self.AdvertSymbol = 0
	self.CurrentAdvert = ""
	self.Adverts = {}	
end
function TRAIN_SYSTEM:Think()
  local Train = self.Train
  local CIS = Train.CIS
  local Power = Train.Electric.Battery80V > 62 and CIS.Power--*(Train.SF37.Value+Train.SF38.Value) > 0--and Train.SFV30.Value > 0
  --if CIS.CISRestart then Power = false end
	local Work = Power --[[and CIS.Ticker]] and Metrostroi.TickerAdverts and #Metrostroi.TickerAdverts > 0
	self.Work = Work
	if (self.Work or Train.BMCIS and Train.BMCIS.State > 1)  then
		local MetrostroiAdverts = Metrostroi.TickerAdverts and #Metrostroi.TickerAdverts or 0
		--[[
		if self.Advert ~= self.PrevAdvert and not self.AdvertTimer then
			self.AdvertTimer = CurTime()
			self.PrevAdvert = self.Advert
		end
		if self.AdvertTimer and CurTime()-self.AdvertTimer < 4 then
			self.AdvertSymbol = 2
		else
			self.AdvertSymbol = self.AdvertSymbol - 90*Train.DeltaTime
			self.AdvertTimer = nil 
		end
		]]
		if not CIS.BMCISInit then
			if self.CurrTimer and CurTime()-self.CurrTimer > 0 then self.CurrTimer = nil self.AdvertSymbol = -utf8.len(self.CurrentAdvert)*10-20 end
			self.AdvertSymbol = self.CurrTimer and 0 or self.AdvertSymbol - 90*Train.DeltaTime
			if self.AdvertSymbol < -utf8.len(self.CurrentAdvert)*10-20  then
				self.CurrentAdvert = (self.CurrentAdvert == "Цифровая информационная система ЦИС-01 НПП \"САРМАТ\" +7(863)2037715" and CIS.Date or "Цифровая информационная система ЦИС-01 НПП \"САРМАТ\" +7(863)2037715")--"НИИ Фабрики SENT БЕГУЩАЯ СТРОКА v1.1 0123456789"
				if self.CurrentAdvert == CIS.Date then
					self.CurrTimer = CurTime()+2
					
				end
				self.AdvertSymbol = 40*7
			end
			self.Advert = -1
		else
			local lastst = CIS.LastSt and Train.STL
			if self.TickerNext ~= CIS.TickerNext or self.TickerCurr ~= CIS.TickerCurr then
				self.AdvertSymbol = -utf8.len(self.CurrentAdvert)*10-30		
			elseif self.CurrTimer then
				self.AdvertSymbol = (self.Advert >= MetrostroiAdverts+1 or lastst or self.Advert == 0 and not self.ToSt) and 0 or (41*4-utf8.len(self.CurrentAdvert)*10)/2 --0
			else
				self.AdvertSymbol = self.AdvertSymbol - 90*Train.DeltaTime
			end
			if self.CurrTimer and (self.Advert < MetrostroiAdverts+1 and self.Advert ~= 0 or self.CurrentAdvert == "Цифровая информационная система ЦИС-01 НПП \"САРМАТ\" +7(863)2037715") then
				self.CurrTimer = nil
			end
			Train:SetNW2Bool("TickerRed",lastst and self.AdvertSymbol < -utf8.len(self.CurrentAdvert:sub(1,string.find(self.CurrentAdvert,". ")))*10)
			--self.AdvertSymbol = 0
			--self.Advert = #Metrostroi.TickerAdverts+1
			--self.CurrentAdvert = "00000000000000000000000000000000"
			--print(utf8.len(self.CurrentAdvert)*10-40 > 40*7)
			--if self.CurrTimer and CurTime()-self.CurrTimer > 3.5 then self.AdvertSymbol = -160 end
			--print(English)
			--self.CurrentAdvert = "AaBbCcDdEe IiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz "
			--self.AdvertSymbol = 0
			if not self.CurrentAdvert then self.CurrentAdvert = "" end
			if self.CurrTimer and CurTime()-self.CurrTimer > 0 and self.CurrentAdvert then 
				if not lastst and (self.Advert ~= 0 or self.ToSt) then self.AdvertSymbol = -utf8.len(self.CurrentAdvert)*10-30 end
				self.CurrTimer = nil
			end
			if self.AdvertSymbol < -utf8.len(self.CurrentAdvert)*10-20 then
				self.AdvertSymbol = 40*7--40*7
				--if Work then
					if self.TickerNext ~= CIS.TickerNext or self.TickerCurr ~= CIS.TickerCurr then
						self.Advert = 0
						self.TickerNext = CIS.TickerNext
						self.TickerCurr = CIS.TickerCurr	
						if CIS.TickerEnglish then
							self.TickerEn = CIS.TickerEn
						end	
						if self.TickerNext then
							self.CurrTimer=nil
						end
					elseif not self.TickerCurr or not self.TickerNext and self.TickerCurr then
						local rnd = not self.TickerCurr and (self.Advert == 0 and MetrostroiAdverts+1 or 0) or 0
						--repeat rnd = (rnd == 0 and #Metrostroi.TickerAdverts+1 or 0) until (rnd ~= self.Advert and not self.Adverts[rnd])
						self.Advert = rnd
					elseif not self.NewAdvert then
						local rnd
						repeat rnd = math.random(0,MetrostroiAdverts+1) until (rnd ~= self.Advert and not self.Adverts[rnd])
						self.Advert = (Train.BMCIS and Train.BMCIS.State > 1) and rnd or Train.CIS.Advert
					end
					if (Train.BMCIS and Train.BMCIS.State > 1) then
						Train.CIS:Trigger("BackTickerAdvert",self.Advert)
					end
					if self.Advert == 0 then
						if not self.TickerCurr then
							--self.Advert = #Metrostroi.TickerAdverts+1
							self.CurrentAdvert = "Цифровая информационная система ЦИС-01 НПП \"САРМАТ\" +7(863)2037715"
						elseif self.TickerNext then
							self.CurrentAdvert = Format("Следующая станция %s.",self.TickerCurr):gsub("Й","й")
							if CIS.TickerEnglish then
								self.CurrentAdvert = self.CurrentAdvert..Format("                The next station is %s.",self.TickerEn):gsub("Й","й")
							end
						else
							if CIS.TickerEnglish and self.CurrentAdvert == Format("%s.",self.TickerCurr):gsub("Й","й") then
								self.CurrentAdvert = Format("This is %s.",self.TickerEn):gsub("Й","й")
							else
								self.CurrentAdvert = Format("%s.",self.TickerCurr):gsub("Й","й")
							end
							if lastst then
								self.CurrentAdvert = self.CurrentAdvert.."                Поезд дальше не идет, просьба выйти из вагона. Уважаемые пассажиры! За проезд в поездах, не осуществляющих или прекративших перевозку, предусмотрена административная ответственность.   "
								self.CurrTimer = CurTime()+2
							end
							if utf8.len(self.CurrentAdvert)*10 < 170 then
								self.CurrTimer = CurTime()+(CIS.TickerEnglish and 2 or 1e9)
								self.ToSt = true 
							else
								self.CurrTimer = CurTime()+2
								self.ToSt = false
							end
						end
					else
						if self.Advert >= MetrostroiAdverts+1 then
							self.CurrentAdvert = CIS.Date
							self.CurrTimer = CurTime()+2
							self.ToSt = true 
						else	
							self.CurrentAdvert = Metrostroi.TickerAdverts[self.Advert]:gsub("Й","й")					
						end
					end
					if self.NewAdvert then self.NewAdvert = false end
				--end
			end
		end
	else
		self.AdvertSymbol = 40*8
		self.CurrentAdvert = "Цифровая информационная система ЦИС-01 НПП \"САРМАТ\" +7(863)2037715"--"НИИ Фабрики SENT БЕГУЩАЯ СТРОКА v1.1 0123456789"
		self.Advert = -1
	end
	--self.CurrTimer = CurTime()+1e9
	--self.CurrentAdvert = "AaBbCcDdEeFfGgJj"
	
	--[[
	local str = ""
	for p, c in utf8.codes(self.CurrentAdvert) do
		str = str..utf8.char(c+10)
	end]]
	Train:SetNW2String("TickerMessage",self.Work and self.CurrentAdvert or "")
	Train:SetNW2Int("TickerAdvert",self.Advert)
	--Train:SetNW2Int("TickerState",math.ceil(math.min(0,self.AdvertSymbol)))
	Train:SetNW2Int("TickerState",math.ceil(self.AdvertSymbol))
	Train:SetNW2Bool("TickerInit",not self.TickerCurr)
end
