include("shared.lua")

function ENT:Initialize()
	self.UpdateBlock = false
	self.AttachmentTable = {}
	local AttachmentNames = {"Departure01A", "Departure01B", "Departure01C", "Departure01D",
							 "Departure02A", "Departure02B", "Departure02C", "Departure02D",
							 "Destination01A", "Destination01B", "Destination01C", "Destination01D",
							 "Destination02A", "Destination02B", "Destination02C", "Destination02D",
							 "Line01A", "Line01B", "Line01C", "Line01D",
							 "Line02A", "Line02B", "Line02C", "Line02D"}
	for i=1, #AttachmentNames do
		if !self:CheckAtt(AttachmentNames[i]) then return end
    att = self:GetAtt(AttachmentNames[i])
		if !att then continue end
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

	-- self:SetNWString("TextLineA", LineString or "")
	-- self:SetNWString("TextDestA", DestinationString or "")
	-- self:SetNWString("TextDepartA", DepartString or "")

	local daisy_data
	local LineString = self:GetNWString("LineString", 0)
	if TextLine == "DISABLE" then return end
	local DestinationString = self:GetNWString("DestinationString", 0)
	local DepartString = self:GetNWString("DepartString", 0)


	local LineTable = string.Explode( ",", LineString )
	//PrintTable(LineTable)
	local DestinationTable = string.Explode( ",", DestinationString )
	local DepartTable = string.Explode( ",", DepartString )

	-- if #DepartTable + #DestinationTable + #LineTable / #DepartTable != 1 then return false end
	-- if #DepartTable + #DestinationTable + #LineTable / #DestinationTable != 1 then return false end
	-- if #DepartTable + #DestinationTable + #LineTable / #LineTable != 1 then return false end
	-- print("Config good!")
	daisy_data = {Lines, Destinations, Departures}

	return daisy_data
end

function ENT:Draw()
	self:DrawModel()
	local daisy_data = self:RefreshData()
	if !daisy_data or table.IsEmpty(daisy_data) then return end
	
	-- self:drawText(self.AttachmentTable[17].Pos, self.AttachmentTable[17].Ang,  0.07, "TlseDaisy", Color(255, 255, 255, 255), " V")
	-- self:drawText(self.AttachmentTable[9].Pos, self.AttachmentTable[9].Ang,  0.0416, "TlseDaisy", Color(255, 255, 255, 255), "South-Port Junction")
	-- self:drawText(self.AttachmentTable[1].Pos, self.AttachmentTable[1].Ang,  0.05, "TlseDaisy", Color(255, 255, 255, 255), "5 min")
	-- self:drawText(self.AttachmentTable[20].Pos, self.AttachmentTable[20].Ang,  0.055, "TlseDaisy", Color(255, 132, 50, 255), "  17:30")

	-- Draw Lines
	self:drawText(self.AttachmentTable[17].Pos, self.AttachmentTable[17].Ang,  0.07, "TlseDaisy", Color(255, 255, 255, 255), daisy_data[1][1])
	self:drawText(self.AttachmentTable[18].Pos, self.AttachmentTable[18].Ang,  0.07, "TlseDaisy", Color(255, 255, 255, 255), daisy_data[1][2])
	self:drawText(self.AttachmentTable[19].Pos, self.AttachmentTable[19].Ang,  0.07, "TlseDaisy", Color(255, 255, 255, 255), daisy_data[1][3])
	self:drawText(self.AttachmentTable[20].Pos, self.AttachmentTable[20].Ang,  0.07, "TlseDaisy", Color(255, 255, 255, 255), daisy_data[1][4])
	
	
	
	
	-- Draw Departure Time
	-- if !daisy_data[9] then
		-- self:drawText(self.AttachmentTable[1].Pos, self.AttachmentTable[1].Ang,  0.0416, "BerlinDaisy2", Color(255, 216, 0, 255), daisy_data[6])
		-- self:drawText(self.AttachmentTable[2].Pos, self.AttachmentTable[2].Ang,  0.0416, "BerlinDaisy2", Color(255, 216, 0, 255), daisy_data[6])
	-- end
	-- self:drawText(self.AttachmentTable[3].Pos, self.AttachmentTable[3].Ang,  0.0416, "BerlinDaisy2", Color(255, 216, 0, 255), daisy_data[7])
	-- self:drawText(self.AttachmentTable[4].Pos, self.AttachmentTable[4].Ang,  0.0416, "BerlinDaisy2", Color(255, 216, 0, 255), daisy_data[7])
	-- Draw Destinations
	-- self:drawText(self.AttachmentTable[5].Pos, self.AttachmentTable[5].Ang,  0.05, "BerlinDaisy2", Color(255, 216, 0, 255), daisy_data[4])
	-- self:drawText(self.AttachmentTable[6].Pos, self.AttachmentTable[6].Ang,  0.05, "BerlinDaisy2", Color(255, 216, 0, 255), daisy_data[4])
	-- self:drawText(self.AttachmentTable[7].Pos, self.AttachmentTable[7].Ang,  self.SizeMultiplier*0.05, "BerlinDaisy2", Color(255, 216, 0, 255), daisy_data[5])
	-- self:drawText(self.AttachmentTable[8].Pos, self.AttachmentTable[8].Ang,  self.SizeMultiplier*0.05, "BerlinDaisy2", Color(255, 216, 0, 255), daisy_data[5])
	-- Draw Lines
	-- self:drawText(self.AttachmentTable[9].Pos, self.AttachmentTable[9].Ang,  daisy_data[8], "BerlinDaisy2", Color(255, 216, 0, 255), daisy_data[2])
	-- self:drawText(self.AttachmentTable[10].Pos, self.AttachmentTable[10].Ang, daisy_data[8], "BerlinDaisy2", Color(255, 216, 0, 255), daisy_data[2])
	-- self:drawText(self.AttachmentTable[11].Pos, self.AttachmentTable[11].Ang, self.daisy_data[8], "BerlinDaisy2", Color(255, 216, 0, 255), daisy_data[3])
	-- self:drawText(self.AttachmentTable[12].Pos, self.AttachmentTable[12].Ang, self.daisy_data[8], "BerlinDaisy2", Color(255, 216, 0, 255), daisy_data[3])
end