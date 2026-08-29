Metrostroi.DefineSystem("81_717_5P_Ticker")
TRAIN_SYSTEM.DontAccelerateSimulation = true

TRAIN_SYSTEM.TickerAdverts = {".                    .                    .                    .                    .                    .", "Единый номер экстренных служб - 112.", "Не забывайте свои вещи в салоне вагона. Если вы обнаружили бесхозные предметы, немедленно сообщите машинисту или дежурному по станции."}

function TRAIN_SYSTEM:Initialize()
    self.Advert = -1
    self.AdvertSymbol = 0
    self.CurrentAdvert = ""
end

if TURBOSTROI then return end

if SERVER then
    function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
        if textdata == "Curr" then
            self.TickerCurr = numdata
        end
        if textdata == "Next" then
            self.TickerNext = numdata
        end
        if textdata == "Last" then
            self.TickerLast = numdata
        end
        self.NextAdvertStation = true
        self.BeStation=false
    end
    function TRAIN_SYSTEM:Think()
        local Train = self.Train
        local Power = Train.VB.Value>0
        local Work = Train.VB.Value>0
        if Power and (Work or self.Advert ~= -1) then
            self.AdvertSymbol = self.AdvertSymbol-70*Train.DeltaTime
            if self.AdvertSymbol < -utf8.len(self.CurrentAdvert)*6-40 then
                self.AdvertSymbol = 140
                if Work then
                    if self.NextAdvertStation then
                        self.Advert = 0
                        self.NextAdvertStation = false
                    else
                        local rnd
                        repeat rnd = math.random(0,#self.TickerAdverts+1) until rnd ~= self.Advert
                        self.Advert = rnd
                    end
                    if self.BeStation then
                        self.CurrentAdvert = Format("ПОЕЗД СЛЕДУЕТ ДО СТАНЦИИ %s",self.TickerLast):gsub("Й","й")
                        self.BeStation=false
                    elseif self.Advert == 0 then
                        if not self.TickerCurr then
                            self.CurrentAdvert = ".                        .                        .                        .                        .                        ."
                        elseif self.TickerNext then
                            self.CurrentAdvert = Format("СЛЕДУЮЩАЯ СТАНЦИЯ %s",self.TickerCurr):gsub("Й","й")
                            self.BeStation=self.TickerLast
                        else
                            self.AnnouncerPlay = Format("СТАНЦИЯ %s",self.TickerCurr):gsub("Й","й")
                            self.BeStation=self.TickerLast
                        end
                    else
                        if self.Advert > #self.TickerAdverts then
                            self.CurrentAdvert = os.date("!%H : %M    %d.%m.%Y         ",Metrostroi.GetSyncTime())
                        else
                            self.CurrentAdvert = self.TickerAdverts[self.Advert]:gsub("Й","й")
                        end
                    end
                else
                    self.CurrentAdvert = "81-717.5П БЕГУЩАЯ СТРОКА v1.2 01234567890"
                    self.Advert = -1
                    self.AdvertSymbol = 40*8
                end
            end
        else
            self.AdvertSymbol = 40*8
            self.CurrentAdvert = "81-717.5П БЕГУЩАЯ СТРОКА v1.2 01234567890"
            self.Advert = -1
        end
        Train:SetNW2String("TickerMessage",self.CurrentAdvert)
        Train:SetNW2Int("TickerState",self.Advert > #self.TickerAdverts and 2 or math.ceil(self.AdvertSymbol))
    end
else
    function TRAIN_SYSTEM:ClientInitialize()
        self.Position = 0
        self.Text = ""
    end
    local function createFont(name,font,size)
        surface.CreateFont("Metrostroi_7175P_"..name, {
            font = font,
            size = size,
            weight = 0,
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
    createFont("Tickers","Moscow metro 1 v2 round",42)
    function TRAIN_SYSTEM:ClientThink(dT)
        if not self.Train:ShouldDrawPanel("Tickers") then return end
        render.PushRenderTarget(self.Train.Tickers,0,0,1024, 64)
        render.Clear(0, 0, 0, 0)
        cam.Start2D()
            render.SetScissorRect(3,1,693,44, true)
            self:Tickers(self.Train,dT)
            render.SetScissorRect(0, 0, 0, 0, false)
        cam.End2D()
        render.PopRenderTarget()
    end
  
    function TRAIN_SYSTEM:PrintText(x, text, inverse)
        local str = {utf8.codepoint(text, 1, -1)}
        for i=0,#str-1 do
            local xpos = x*5.4+i*32.4
            if xpos<681 then
                local char = utf8.char(str[i + 1])
                draw.SimpleText(char, "Metrostroi_7175P_Tickers", xpos + 18, 22, Color(80, 220, 50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end
    end

    function TRAIN_SYSTEM:Tickers(Train,dT)
        self.Text = self.Train:GetNW2String("TickerMessage","")
        self.Position = math.max(self.Position-dT*72,self.Train:GetNW2Int("TickerState",0))
        if self.Position-self.Train:GetNW2Int("TickerState",0) > 25 then self.Position = self.Train:GetNW2Int("TickerState",0) end
        if self.Text ~= "" then self:PrintText(math.floor(self.Position),self.Text) end
    end
end