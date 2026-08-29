Metrostroi.DefineSystem("81_760_ASNP_VV")
TRAIN_SYSTEM.DontAccelerateSimulation = false

function TRAIN_SYSTEM:Initialize()
    self.Power = 0
end

function TRAIN_SYSTEM:Outputs()
	return {"Power"}
end

function TRAIN_SYSTEM:Inputs()
	return {}
end