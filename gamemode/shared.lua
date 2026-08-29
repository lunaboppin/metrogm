GM.Name = "Metro"
GM.Author = "lunaboppin"
GM.Website = ""

DeriveGamemode("sandbox")

METRO = METRO or {}
METRO.Backends = METRO.Backends or {}

function METRO.GamemodeBase()
	return engine.ActiveGamemode() .. "/gamemode/"
end

local function inferRealm(path)
	if path:find("sv_") then
		return "server"
	elseif path:find("sh_") or path:find("shared%.lua$") then
		return "shared"
	elseif path:find("cl_") then
		return "client"
	end
end

function METRO.Include(path, realm)
	if not path then
		error("[metro] no path given to METRO.Include")
	end

	realm = realm or inferRealm(path)

	if realm == "server" then
		if SERVER then
			return include(path)
		end
		return
	elseif realm == "shared" then
		if SERVER then
			AddCSLuaFile(path)
		end
		return include(path)
	elseif realm == "client" then
		if SERVER then
			AddCSLuaFile(path)
		else
			return include(path)
		end
		return
	end

	error("[metro] could not infer realm for '" .. path .. "', pass realm explicitly")
end

function METRO.IncludeDir(dir, recursive, skip)
	local files, dirs = file.Find(METRO.GamemodeBase() .. dir .. "/*.lua", "LUA")

	table.sort(files)

	for _, fileName in ipairs(files) do
		local relative = dir .. "/" .. fileName

		if not (skip and skip[relative]) then
			METRO.Include(relative)
		end
	end

	if recursive then
		table.sort(dirs)

		for _, subDir in ipairs(dirs) do
			METRO.IncludeDir(dir .. "/" .. subDir, true, skip)
		end
	end
end

METRO.TrainConfig = METRO.TrainConfig or METRO.Include("config/trains.lua", "shared")
