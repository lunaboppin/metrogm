METRO.Migrations = {
	{
		version = 1,
		name = "create_metro_players",
		mysql = {
			[[CREATE TABLE IF NOT EXISTS metro_players (
				steamid64 VARCHAR(20) NOT NULL PRIMARY KEY,
				name VARCHAR(64) NOT NULL,
				money BIGINT NOT NULL DEFAULT 0,
				xp BIGINT NOT NULL DEFAULT 0,
				level INT NOT NULL DEFAULT 1,
				playtime_seconds BIGINT NOT NULL DEFAULT 0,
				first_seen DATETIME NOT NULL,
				last_seen DATETIME NOT NULL
			) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4]],
		},
		sqlite = {
			[[CREATE TABLE IF NOT EXISTS metro_players (
				steamid64 VARCHAR(20) NOT NULL PRIMARY KEY,
				name VARCHAR(64) NOT NULL,
				money INTEGER NOT NULL DEFAULT 0,
				xp INTEGER NOT NULL DEFAULT 0,
				level INTEGER NOT NULL DEFAULT 1,
				playtime_seconds INTEGER NOT NULL DEFAULT 0,
				first_seen DATETIME NOT NULL,
				last_seen DATETIME NOT NULL
			)]],
		},
	},
	{
		version = 2,
		name = "create_metro_transactions",
		mysql = {
			[[CREATE TABLE IF NOT EXISTS metro_transactions (
				id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
				steamid64 VARCHAR(20) NOT NULL,
				actor_steamid64 VARCHAR(20) NULL,
				delta BIGINT NOT NULL,
				balance_after BIGINT NOT NULL,
				reason VARCHAR(128) NOT NULL,
				created_at DATETIME NOT NULL,
				INDEX metro_transactions_steamid64 (steamid64)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4]],
		},
		sqlite = {
			[[CREATE TABLE IF NOT EXISTS metro_transactions (
				id INTEGER PRIMARY KEY AUTOINCREMENT,
				steamid64 VARCHAR(20) NOT NULL,
				actor_steamid64 VARCHAR(20) NULL,
				delta INTEGER NOT NULL,
				balance_after INTEGER NOT NULL,
				reason VARCHAR(128) NOT NULL,
				created_at DATETIME NOT NULL
			)]],
			[[CREATE INDEX IF NOT EXISTS metro_transactions_steamid64 ON metro_transactions (steamid64)]],
		},
	},
	{
		version = 3,
		name = "create_metro_schema_version",
		mysql = {
			[[CREATE TABLE IF NOT EXISTS metro_schema_version (
				id TINYINT NOT NULL PRIMARY KEY,
				version INT NOT NULL
			) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4]],
			[[INSERT INTO metro_schema_version (id, version) VALUES (1, 0)
				ON DUPLICATE KEY UPDATE id = id]],
		},
		sqlite = {
			[[CREATE TABLE IF NOT EXISTS metro_schema_version (
				id INTEGER NOT NULL PRIMARY KEY,
				version INTEGER NOT NULL
			)]],
			[[INSERT OR IGNORE INTO metro_schema_version (id, version) VALUES (1, 0)]],
		},
	},
	{
		version = 4,
		name = "add_metro_transactions_kind",
		mysql = {
			[[ALTER TABLE metro_transactions ADD COLUMN kind VARCHAR(16) NOT NULL DEFAULT 'money']],
			[[ALTER TABLE metro_transactions ADD INDEX metro_transactions_steamid64_kind (steamid64, kind)]],
		},
		sqlite = {
			[[ALTER TABLE metro_transactions ADD COLUMN kind VARCHAR(16) NOT NULL DEFAULT 'money']],
			[[CREATE INDEX IF NOT EXISTS metro_transactions_steamid64_kind ON metro_transactions (steamid64, kind)]],
		},
	},
}

function METRO.RunMigrationsAgainst(dialect, execFn, cb)
	local function getCurrentVersion(next)
		execFn("SELECT version FROM metro_schema_version WHERE id = 1", function(err, rows)
			if err or not rows or not rows[1] then
				next(0)
				return
			end
			next(tonumber(rows[1].version) or 0)
		end)
	end

	getCurrentVersion(function(currentVersion)
		local pending = {}
		for _, migration in ipairs(METRO.Migrations) do
			if migration.version > currentVersion then
				table.insert(pending, migration)
			end
		end

		if #pending == 0 then
			cb(nil, { applied = {}, version = currentVersion })
			return
		end

		local appliedNames = {}
		local migrationIndex = 1

		local function runNextMigration()
			local migration = pending[migrationIndex]

			if not migration then
				local finalVersion = pending[#pending].version
				execFn("UPDATE metro_schema_version SET version = " .. finalVersion .. " WHERE id = 1", function(updateErr)
					if updateErr then
						cb(updateErr)
						return
					end
					cb(nil, { applied = appliedNames, version = finalVersion })
				end)
				return
			end

			local statements = migration[dialect]
			local statementIndex = 1

			local function runNextStatement()
				local statement = statements[statementIndex]

				if not statement then
					table.insert(appliedNames, migration.name)
					migrationIndex = migrationIndex + 1
					runNextMigration()
					return
				end

				execFn(statement, function(err)
					if err then
						cb(err)
						return
					end
					statementIndex = statementIndex + 1
					runNextStatement()
				end)
			end

			runNextStatement()
		end

		runNextMigration()
	end)
end
