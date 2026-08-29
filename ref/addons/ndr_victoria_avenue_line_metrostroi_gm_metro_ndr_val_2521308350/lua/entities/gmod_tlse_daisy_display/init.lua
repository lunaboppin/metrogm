AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

DEFINE_BASECLASS("gmod_berlin_daisy_display_base")

function ENT:Initialize()
	local models = {"models/thecreepy31/ndrprop/limit/daisy_tlse_1.mdl", "models/thecreepy31/ndrprop/limit/daisy_tlse_1.mdl"}
	self:SetModel(models[tonumber(self.VMF.modelvariant)])
	BaseClass.Initialize(self)
	if tonumber(self.VMF.modelvariant) != 1 then return end
end
