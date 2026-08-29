METRO.Lang = METRO.Lang or {}
METRO.Lang.stored = METRO.Lang.stored or {}
METRO.Lang.names = METRO.Lang.names or {}

function METRO.Lang.LoadFromDir(directory)
	for _, fileName in ipairs(file.Find(METRO.GamemodeBase() .. directory .. "/sh_*.lua", "LUA")) do
		local niceName = fileName:sub(4, -5):lower()

		METRO.Include(directory .. "/" .. fileName, "shared")

		if LANGUAGE then
			if NAME then
				METRO.Lang.names[niceName] = NAME
				NAME = nil
			end

			METRO.Lang.AddTable(niceName, LANGUAGE)
			LANGUAGE = nil
		end
	end
end

function METRO.Lang.AddTable(language, data)
	language = tostring(language):lower()
	METRO.Lang.stored[language] = table.Merge(METRO.Lang.stored[language] or {}, data)
end

local function resolvePhrase(language, key)
	local info = METRO.Lang.stored[language] or METRO.Lang.stored.english
	local english = METRO.Lang.stored.english

	return (info and info[key]) or (english and english[key]) or key
end

local function resolvePhraseStrict(language, key)
	local info = METRO.Lang.stored[language] or METRO.Lang.stored.english

	return info and info[key]
end

if SERVER then
	util.AddNetworkString("MetroNotify")

	function METRO.Lang.GetPlayerLanguage(client)
		if not IsValid(client) then
			return "english"
		end

		local language = client:GetInfo("metro_language")

		return (language and language ~= "") and language or "english"
	end

	function L(key, client, ...)
		return string.format(resolvePhrase(METRO.Lang.GetPlayerLanguage(client), key), ...)
	end

	function L2(key, client, ...)
		local phrase = resolvePhraseStrict(METRO.Lang.GetPlayerLanguage(client), key)

		if not phrase then
			return nil
		end

		return string.format(phrase, ...)
	end

	local playerMeta = FindMetaTable("Player")

	function playerMeta:Notify(text)
		net.Start("MetroNotify")
		net.WriteString(text)
		net.Send(self)
	end

	function playerMeta:NotifyLocalized(key, ...)
		self:Notify(L(key, self, ...))
	end
else
	CreateClientConVar("metro_language", "english", true, true, "Metro language preference")

	function METRO.Lang.GetLanguage()
		return GetConVar("metro_language"):GetString()
	end

	function L(key, ...)
		return string.format(resolvePhrase(METRO.Lang.GetLanguage(), key), ...)
	end

	function L2(key, ...)
		local phrase = resolvePhraseStrict(METRO.Lang.GetLanguage(), key)

		if not phrase then
			return nil
		end

		return string.format(phrase, ...)
	end

	function METRO.Lang.ReceiveNotify(text)
		print("[metro] " .. text)
	end

	net.Receive("MetroNotify", function()
		METRO.Lang.ReceiveNotify(net.ReadString())
	end)
end
