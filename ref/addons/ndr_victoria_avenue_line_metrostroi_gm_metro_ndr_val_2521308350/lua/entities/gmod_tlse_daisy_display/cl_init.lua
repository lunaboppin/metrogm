include("shared.lua")

function ENT:Initialize()
	self.UpdateBlock = false
	self.AttachmentTable = {}
	local AttachmentNames = {"Departure01A", "Departure01B", "Departure01C", --1 2 3
							 "Destination01A", "Destination01B", "Destination01C", --4 5 6
							 "Line01A", "Line01B", "Line01C",} --7 8 9
	for i=1, #AttachmentNames do
		if !self:CheckAtt(AttachmentNames[i]) then return end
    att = self:GetAtt(AttachmentNames[i])
		if !att then return end
		self.AttachmentTable[i] = att
	end
  self:RefreshData()
end

function ENT:RefreshData()
	if !self.UpdateBlock then
	self.UpdateBlock = true
	timer.Simple(5, function() self.UpdateBlock = false end)
	return
	end

	local daisy_data, LineTable, DestinationTable, DepartureTable, MiscTable = {}, {}, {}, {}, {}
	local TextLine = self:GetNWString("TextLine", "")
	local TextDests = self:GetNWString("TextDests", "")
	local TextDeparts = self:GetNWString("TextDeparts", "")
	local TextMisc = self:GetNWString("TextMisc", "")
	local TimeClk = os.date("!*t",Metrostroi.GetSyncTime())
	local TimeString, TimeNames = "", {"hour", "min", "sec"}
	for i=1, 3 do
		TimeString = TimeString..string.sub("00"..TimeClk[TimeNames[i]], #tostring(TimeClk[TimeNames[i]]) == 2 and 3 or 2)
		if i > 2 then continue end
		TimeString = TimeString..":"
	end
	
	if #TextLine > 0 then
	LineTable = string.Explode( ",", TextLine)
	end
	if #TextDests > 0 then
	DestinationTable = string.Explode( ",", TextDests)
	end
	if #TextDeparts > 0 then
	DepartureTable = string.Explode( ",", TextDeparts)
	end
	if #TextMisc != 0 then
	MiscTable = string.Explode( ",", TextMisc) // [1] = Tracknumber, [2] = Departure bool
	end

	MiscTable[3] = 0.1 //[3] = LineSize
	if DestinationTable[1] == "Disabled" then
	MiscTable[3] = 0.085 //[3] = LineSize
	DestinationTable[1] = ""
	end

	for i=1, #DepartureTable do
	//if tonumber(DepartureTable[i]) < 1 then DepartureTable[i] = "0 min" continue end
	DepartureTable[i] = ""..DepartureTable[i].." min"
	end
	
	daisy_data = {LineTable, DestinationTable, DepartureTable, MiscTable, TimeString}
	return daisy_data
end

local blink, blink2 = false, false

function ENT:Think()
	if !blink and !blink2 or blink and !blink2 then
		blink = !blink
		blink2 = !blink2
		timer.Simple(1, function() blink2 = !blink2 end)
	end
end

function ENT:Draw()
  self:DrawModel()
	local daisy_data = self:RefreshData()
	if !daisy_data or table.IsEmpty(daisy_data) then return end
	
	-- Draw Time
	self:drawText(self.AttachmentTable[6].Pos, self.AttachmentTable[6].Ang,  0.06, "BerlinDaisy2_80", Color(255, 106, 0, 255), "    "..daisy_data[5].."") -- "      "..daisy_data[5]["hour"]..":"..daisy_data[5]["min"]..":"..daisy_data[5]["sec"]..""
	-- Draw Lines
	self:drawText(self.AttachmentTable[7].Pos, self.AttachmentTable[7].Ang, daisy_data[4][3], "BerlinDaisy2_64", Color(255, 106, 0, 255), daisy_data[1][1])
	self:drawText(self.AttachmentTable[8].Pos, self.AttachmentTable[8].Ang, daisy_data[4][3], "BerlinDaisy2_64", Color(255, 106, 0, 255), daisy_data[1][2])
	--self:drawText(self.AttachmentTable[9].Pos, self.AttachmentTable[9].Ang, daisy_data[4][3], "TlseDaisy", Color(255, 255, 255, 255), daisy_data[1][3])
	if daisy_data[4][3] == 0.085 then return end
	-- Draw Destinations
	self:drawText(self.AttachmentTable[4].Pos, self.AttachmentTable[4].Ang,  0.05, "BerlinDaisy2_80", Color(255, 106, 0, 255), daisy_data[2][1])
	self:drawText(self.AttachmentTable[5].Pos, self.AttachmentTable[5].Ang,  0.05, "BerlinDaisy2_80", Color(255, 106, 0, 255), daisy_data[2][2])
	--self:drawText(self.AttachmentTable[6].Pos, self.AttachmentTable[6].Ang,  0.05, "TlseDaisy", Color(255, 255, 255, 255), daisy_data[2][3])

	-- Draw Departure Time
	if blink and daisy_data[3][1] == "0 min" or daisy_data[3][1] != "0 min" then
		self:drawText(self.AttachmentTable[1].Pos, self.AttachmentTable[1].Ang,  0.05, "BerlinDaisy2_80", Color(255, 106, 0, 255), daisy_data[3][1])
	end
	self:drawText(self.AttachmentTable[2].Pos, self.AttachmentTable[2].Ang,  0.05, "BerlinDaisy2_80", Color(255, 106, 0, 255), daisy_data[3][2])
    --self:drawText(self.AttachmentTable[3].Pos, self.AttachmentTable[3].Ang,  0.0416, "TlseDaisy", Color(255, 255, 255, 255), daisy_data[3][3])

end