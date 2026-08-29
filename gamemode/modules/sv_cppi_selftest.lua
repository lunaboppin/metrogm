local methods = {
	"CPPICanTool",
	"CPPICanPhysgun",
	"CPPICanPickup",
	"CPPICanPunt",
	"CPPICanUse",
	"CPPICanDamage",
	"CPPIDrive",
	"CPPICanDrive",
	"CPPICanProperty",
	"CPPICanEditVariable",
	"CPPICanNocollide",
}

local function check(failures, condition, message)
	if not condition then
		table.insert(failures, message)
	end
end

concommand.Add("metro_cppi_selftest", function(ply)
	if IsValid(ply) and not ply:IsSuperAdmin() then return end
	if type(CPPI.GetName) ~= "function" or CPPI:GetName() ~= "Metro CPPI fallback" then
		print("[metro] CPPI SELF-TEST SKIPPED: an external provider is active")
		return
	end

	local owner = player.GetAll()[1]
	if not IsValid(owner) then
		print("[metro] CPPI SELF-TEST SKIPPED: requires a connected player")
		return
	end

	local failures = {}
	local ent = ents.Create("prop_physics")
	if not IsValid(ent) then
		print("[metro] CPPI SELF-TEST FAILED: could not create a test entity")
		return
	end

	ent:SetModel("models/props_junk/PopCan01a.mdl")
	ent:Spawn()

	check(failures, CPPI:GetInterfaceVersion() == 1.3, "interface version mismatch")
	check(failures, ent:CPPIGetOwner() == nil, "new entity has an owner")
	check(failures, ent:CPPISetOwner("invalid") == false, "invalid owner was accepted")
	check(failures, ent:CPPISetOwner(owner), "player owner was rejected")

	local currentOwner, uid = ent:CPPIGetOwner()
	check(failures, currentOwner == owner, "owner attribution mismatch")
	check(failures, uid == tostring(owner:UniqueID()), "owner UID mismatch")
	check(failures, ent:CPPIGetOwnerName() == owner:GetName(), "owner name mismatch")

	for _, method in ipairs(methods) do
		local methodFunction = ent[method]
		check(failures, type(methodFunction) == "function", method .. " is missing")
		if type(methodFunction) == "function" then
			check(failures, methodFunction(ent, owner) == true, method .. " rejected the owner")
		end
	end

	check(failures, ent:CPPISetOwnerUID(uid), "owner UID assignment failed")
	check(failures, ent:CPPIGetOwner() == owner, "owner UID attribution mismatch")
	check(failures, ent:CPPISetOwner(nil), "owner clear failed")
	check(failures, ent:CPPIGetOwner() == nil, "cleared entity retained an owner")

	for _, method in ipairs(methods) do
		local expected = owner:IsAdmin()
		local methodFunction = ent[method]
		if type(methodFunction) == "function" then
			check(failures, methodFunction(ent, owner) == expected, method .. " admin semantics mismatch")
		end
	end

	ent:Remove()

	if #failures == 0 then
		print("[metro] CPPI SELF-TEST PASSED")
	else
		print("[metro] CPPI SELF-TEST FAILED: " .. table.concat(failures, "; "))
	end
end)
