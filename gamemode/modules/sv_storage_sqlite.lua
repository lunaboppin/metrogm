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

function backend.CreatePlayer(steamid64, name, cb)
	local now = os.date("%Y-%m-%d %H:%M:%S")
	local query = string.format(
		"INSERT INTO metro_players (steamid64, name, money, xp, level, playtime_seconds, first_seen, last_seen) " ..
		"VALUES (%s, %s, 0, 0, 1, 0, %s, %s)",
		sql.SQLStr(steamid64), sql.SQLStr(name), sql.SQLStr(now), sql.SQLStr(now)
	)
	exec(query, function(err)
		if err then
			cb(err)
			return
		end
		backend.LoadPlayer(steamid64, cb)
	end)
end

function backend.SavePlayer(record, cb)
	local query = string.format(
		"UPDATE metro_players SET name = %s, money = %d, xp = %d, level = %d, playtime_seconds = %d, last_seen = %s " ..
		"WHERE steamid64 = %s",
		sql.SQLStr(record.name), record.money, record.xp, record.level, record.playtime_seconds,
		sql.SQLStr(os.date("%Y-%m-%d %H:%M:%S")), sql.SQLStr(record.steamid64)
	)
	exec(query, function(err)
		cb(err)
	end)
end

function backend.LogTransaction(entry, cb)
	local actor = entry.actor_steamid64 and sql.SQLStr(entry.actor_steamid64) or "NULL"
	local query = string.format(
		"INSERT INTO metro_transactions (steamid64, actor_steamid64, delta, balance_after, reason, created_at) " ..
		"VALUES (%s, %s, %d, %d, %s, %s)",
		sql.SQLStr(entry.steamid64), actor, entry.delta, entry.balance_after, sql.SQLStr(entry.reason),
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
