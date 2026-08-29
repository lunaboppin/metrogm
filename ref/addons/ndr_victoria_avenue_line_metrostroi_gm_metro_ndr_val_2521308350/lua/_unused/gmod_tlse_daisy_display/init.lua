AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

DEFINE_BASECLASS("gmod_berlin_daisy_display")

function ENT:Initialize()
	BaseClass.Initialize(self)
	local models = {"models/thecreepy31/ndrprop/limit/daisy_tlse_2.mdl", "models/thecreepy31/ndrprop/limit/daisy_tlse_1.mdl"}
	self:SetModel(models[tonumber(self.VMF.modelvariant)])
end

function ENT:UpdateDisplay()
	local DepartTable = {}
	local DestinationTable = {}
	local LineTable = {}
	if !RonBerlinLib.DaisyEnable then
		LineTable[1] = "DISABLE"
	elseif !Metrostroi then
		LineTable[1] = "Metrostroi not installed!"
		LineTable[2] = "Please check Addons!"
	elseif !IsValid(self.StationEnt) then
		LineTable[1] = "No trackdata or"
		LineTable[2] = "trigger isnt present!"
		DestinationA = "Fucking dead"
	elseif #self.StationEnt.RonConfig.TrainTable > 0 then
0		for i=1, #self.StationEnt.RonConfig.TrainTable do
			local train = self.StationEnt.RonConfig.TrainTable[i][1]
			if !IsValid(train) then continue end
			_,DestinationTable[i],LineTable[i] = self:GetTrainDestinationAnnouncer(train)
			//DepartTable[i] = math.Round(self.StationEnt.RonConfig.TrainTable[i][2]/60, 0)
		end
	else
		LineTable[1] = "Hier kein Zugverkehr!"
		LineTable[2] = "Out of Service!"
	end

	-- if #DepartTable + #DestinationTable + #LineTable / #DepartTable != 1 then return false end
	-- if #DepartTable + #DestinationTable + #LineTable / #DestinationTable != 1 then return false end
	-- if #DepartTable + #DestinationTable + #LineTable / #LineTable != 1 then return false end
	
	LineString = table.concat( LineTable, "," )
	DestinationString = table.concat( DestinationTable, "," )
	DepartString = table.concat( DepartTable, "," )

	self:SetNWString("LineString", LineString or "")
	self:SetNWString("DestinationString", DestinationString or "")
	self:SetNWString("DepartString", DepartString or "")
end