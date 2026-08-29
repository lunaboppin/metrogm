local function restrictTrainSpawn(ply, settings)
	local className = type(settings) == "table" and settings.Train or nil
	local allowed = METRO.Trains.CanSpawn(ply, className)
	return not allowed
end

hook.Add("MetrostroiSpawnerRestrict", "MetroTrainsSpawnerRestrict", restrictTrainSpawn)

hook.Add("PlayerSpawnedSENT", "MetroTrainsRawSpawnBackstop", function(ply, entity)
	if not IsValid(entity) then
		return
	end

	local className = entity:GetClass()
	if not METRO.Trains.ResolveClass(className) then
		return
	end

	local allowed = METRO.Trains.CanSpawn(ply, className)
	if not allowed then
		entity:Remove()
	end
end)
