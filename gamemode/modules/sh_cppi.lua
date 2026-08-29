if CPPI then return end

local ENTITY = FindMetaTable("Entity")
local PLAYER = FindMetaTable("Player")

CPPI = {}
CPPI.CPPI_DEFER = 100100
CPPI.CPPI_NOTIMPLEMENTED = 7080

local function getPlayerUID(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return nil end

	if ply.UniqueID then
		return tostring(ply:UniqueID())
	end

	if ply.SteamID64 then
		return tostring(ply:SteamID64())
	end
end

local function isPlayer(value)
	return IsValid(value) and value:IsPlayer()
end

function CPPI:GetName()
	return "Metro CPPI fallback"
end

function CPPI:GetVersion()
	return "1.0.0"
end

function CPPI:GetInterfaceVersion()
	return 1.3
end

function CPPI:GetNameFromUID(uid)
	if uid == nil then return nil end

	uid = tostring(uid)
	for _, ply in ipairs(player.GetAll()) do
		if getPlayerUID(ply) == uid then
			return ply:GetName()
		end
	end
end

if PLAYER then
	function PLAYER:CPPIGetFriends()
		return CPPI.CPPI_NOTIMPLEMENTED
	end
end

function ENTITY:CPPIGetOwner()
	if SERVER then
		local owner = self.metroCPPIOwner
		local uid = self.metroCPPIOwnerUID

		if not isPlayer(owner) then
			owner = nil
		end

		return owner, uid
	end

	local owner = self:GetNW2Entity("MetroCPPIOwner")
	local uid = self:GetNW2String("MetroCPPIOwnerUID", "")

	if uid == "" then uid = nil end
	if not isPlayer(owner) then owner = nil end

	return owner, uid
end

function ENTITY:CPPIGetOwnerName()
	local owner, uid = self:CPPIGetOwner()
	if isPlayer(owner) then return owner:GetName() end
	return uid and CPPI:GetNameFromUID(uid) or nil
end

if CLIENT then return end

local function canInteract(ent, ply)
	if not isPlayer(ply) then return false end
	if ply:IsAdmin() then return true end
	return ent:CPPIGetOwner() == ply
end

function ENTITY:CPPISetOwner(ply)
	if ply ~= nil and not isPlayer(ply) then return false end

	local uid = getPlayerUID(ply)
	local result = hook.Run("CPPIAssignOwnership", ply, self, uid)
	if result == false then return false end
	if result ~= nil and result ~= true then
		if not isPlayer(result) then return false end
		ply = result
		uid = getPlayerUID(ply)
	end

	self.metroCPPIOwner = ply
	self.metroCPPIOwnerUID = uid
	self:SetNW2Entity("MetroCPPIOwner", ply or NULL)
	self:SetNW2String("MetroCPPIOwnerUID", uid or "")
	return true
end

function ENTITY:CPPISetOwnerUID(uid)
	if uid == nil then return self:CPPISetOwner(nil) end

	uid = tostring(uid)
	for _, ply in ipairs(player.GetAll()) do
		if getPlayerUID(ply) == uid then
			return self:CPPISetOwner(ply)
		end
	end

	return false
end

function ENTITY:CPPICanTool(ply)
	return canInteract(self, ply)
end

function ENTITY:CPPICanPhysgun(ply)
	return canInteract(self, ply)
end

function ENTITY:CPPICanPickup(ply)
	return canInteract(self, ply)
end

function ENTITY:CPPICanPunt(ply)
	return canInteract(self, ply)
end

function ENTITY:CPPICanUse(ply)
	return canInteract(self, ply)
end

function ENTITY:CPPICanDamage(ply)
	return canInteract(self, ply)
end

function ENTITY:CPPIDrive(ply)
	return canInteract(self, ply)
end

function ENTITY:CPPICanDrive(ply)
	return canInteract(self, ply)
end

function ENTITY:CPPICanProperty(ply)
	return canInteract(self, ply)
end

function ENTITY:CPPICanEditVariable(ply)
	return canInteract(self, ply)
end

function ENTITY:CPPICanNocollide(ply)
	return canInteract(self, ply)
end
