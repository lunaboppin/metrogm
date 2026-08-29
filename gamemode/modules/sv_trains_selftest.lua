local function check(failures, condition, message)
	if not condition then
		table.insert(failures, message)
	end
end

concommand.Add("metro_trains_selftest", function(ply)
	if IsValid(ply) and not ply:IsSuperAdmin() then
		return
	end

	METRO.Trains.Refresh()
	local failures = {}
	local starter = "gmod_subway_81-717_mvm"
	local canonical = METRO.Trains.ResolveClass(starter)
	check(failures, canonical == starter, "starter did not resolve to itself")

	local custom = "gmod_subway_81-717_mvm_custom"
	local customDefinition = scripted_ents.Get(custom)
	if customDefinition then
		check(failures, METRO.Trains.ResolveClass(custom) == starter, "custom helper did not resolve to starter")
	end

	local catalogue = METRO.Trains.GetCatalogue()
	check(failures, #catalogue == 1, "expected exactly one configured catalogue entry")
	check(failures, catalogue[1] and catalogue[1].canonicalClass == starter, "starter was not the catalogue entry")
	check(failures, METRO.Trains.ResolveClass("gmod_subway_base") == nil, "base entity was exposed")

	local players = player.GetAll()
	if #players > 0 then
		local owner = players[1]
		local canSpawn, reason = METRO.Trains.CanSpawn(owner, starter)
		check(failures, canSpawn == METRO.Players.IsLoaded(owner), "starter eligibility did not follow load state")
		if not canSpawn then
			check(failures, reason == "trainProfileLoading", "unloaded starter returned the wrong reason")
		end
	end

	if #failures == 0 then
		print("[metro] TRAINS SELF-TEST PASSED")
	else
		print("[metro] TRAINS SELF-TEST FAILED: " .. table.concat(failures, "; "))
	end
end)
