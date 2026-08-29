include("shared.lua")

local CLIENT_MODULES = {
}

for _, path in ipairs(CLIENT_MODULES) do
	include(path)
end
