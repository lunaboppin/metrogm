local backend = {}
backend.dialect = "sqlite"
backend.name = "sqlite"

local function exec(sqlText, cb)
	local result = sql.Query(sqlText)
	if result == false then
		cb(sql.LastError())
		return
	end
	cb(nil, result or {})
end

function backend.Connect(cb)
	cb(nil)
end

function backend.RunMigrations(cb)
	METRO.RunMigrationsAgainst("sqlite", exec, cb)
end

function backend.LoadPlayer(steamid64, cb)
	exec("SELECT * FROM metro_players WHERE steamid64 = " .. sql.SQLStr(steamid64), function(err, rows)
		if err then
			cb(err)
			return
		end
		cb(nil, rows[1])
	end)
end

local function valueFor(variable, record)
	local value = record[variable.field]
	if value == nil then
		value = METRO.Players.GetVarDefault(variable.name)
	end

	if variable.storageType == "integer" then
		return tostring(math.floor(tonumber(value) or 0))
	elseif variable.storageType == "number" then
		return tostring(tonumber(value) or 0)
	elseif variable.storageType == "boolean" then
		return value and "1" or "0"
	elseif variable.storageType == "datetime" then
		if isnumber(value) then
			return sql.SQLStr(os.date("%Y-%m-%d %H:%M:%S", value))
		end
		return sql.SQLStr(tostring(value))
	elseif istable(value) then
		return sql.SQLStr(util.TableToJSON(value) or "{}")
	end

	return sql.SQLStr(tostring(value or ""))
end

local function createRecord(steamid64, name)
	local record = METRO.Players.DefaultRecord()
	record.steamid64 = steamid64
	record.name = name
	record.first_seen = os.time()
	record.last_seen = record.first_seen
	return record
end

function backend.CreatePlayer(steamid64, name, cb)
	local record = createRecord(steamid64, name)
	local columns = { "steamid64" }
	local values = { sql.SQLStr(steamid64) }
	for _, variable in ipairs(METRO.Players.GetStorageVars()) do
		table.insert(columns, variable.field)
		table.insert(values, valueFor(variable, record))
	end
	local query = "INSERT INTO metro_players (" .. table.concat(columns, ", ") .. ") VALUES (" .. table.concat(values, ", ") .. ")"
	exec(query, function(err)
		if err then
			cb(err)
			return
		end
		backend.LoadPlayer(steamid64, cb)
	end)
end

function backend.SavePlayer(record, cb)
	local assignments = {}
	for _, variable in ipairs(METRO.Players.GetStorageVars()) do
		if variable.field ~= "first_seen" then
			table.insert(assignments, variable.field .. " = " .. valueFor(variable, record))
		end
	end
	local query = "UPDATE metro_players SET " .. table.concat(assignments, ", ") ..
		" WHERE steamid64 = " .. sql.SQLStr(record.steamid64)
	exec(query, function(err)
		cb(err)
	end)
end

function backend.LogTransaction(entry, cb)
	local actor = entry.actor_steamid64 and sql.SQLStr(entry.actor_steamid64) or "NULL"
	local kind = entry.kind or "money"
	local query = string.format(
		"INSERT INTO metro_transactions (steamid64, actor_steamid64, delta, balance_after, reason, kind, created_at) " ..
		"VALUES (%s, %s, %d, %d, %s, %s, %s)",
		sql.SQLStr(entry.steamid64), actor, entry.delta, entry.balance_after, sql.SQLStr(entry.reason), sql.SQLStr(kind),
		sql.SQLStr(os.date("%Y-%m-%d %H:%M:%S"))
	)
	exec(query, function(err)
		if err then
			cb(err)
			return
		end
		cb(nil, sql.QueryValue("SELECT last_insert_rowid()"))
	end)
end

METRO.Backends.sqlite = backend
