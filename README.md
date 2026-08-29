# metro

A Garry's Mod gamemode built on the Metrostroi addon, modelled on Stepford County
Railways. Players start with a starter train and progress by earning money and XP to
unlock better trains, with balances and progression shown on the HUD and in menus.

This milestone (v1 skeleton) contains none of that gameplay yet. It builds the
foundation: a gamemode that loads, persists player records to a database, and provides
the storage adapter that later phases build on. See issue #9 in the issue tracker for
the overall direction.

## Install

1. Copy or symlink this repository to `garrysmod/gamemodes/metro` on your server.
2. Run `scripts/setup-mysqloo.sh` from the repository root to fetch the mysqloo binary
   module. It reads `SRCDS_ARCH` from the server's `server.env` to pick the 32-bit or
   64-bit build, defaulting to 32-bit, and installs to `garrysmod/lua/bin/`.
3. Configure the database (see below).
4. Set `GAMEMODE="metro"` in the server's `server.env`.
5. Start the server. The chosen storage backend is logged loudly on boot.

## Configuring the database

Copy the committed template and fill in real credentials:

```
cp config/database.lua.example config/database.lua
```

`config/database.lua` is gitignored and must never be committed. If it is missing, the
gamemode refuses to start and prints the exact path to create along with the example to
copy from.

Fields:

- `backend` — `"auto"`, `"mysql"`, or `"sqlite"`.
  - `"auto"` uses MySQL if the mysqloo module is installed and connects successfully,
    otherwise falls back to SQLite for that session.
  - `"mysql"` forces MySQL; if it cannot connect, the gamemode refuses to start rather
    than silently using SQLite.
  - `"sqlite"` forces SQLite.
- `host`, `port`, `username`, `password`, `database` — MySQL connection details. Ignored
  when the resolved backend is SQLite.

The backend is chosen once at boot and never changes for the rest of the session. If
MySQL is lost mid-session, the gamemode reconnects with backoff and refuses money/XP
mutations while down — it never diverts writes to SQLite.

## Running the self-tests

With the server running metro, from the server console (or as a superadmin in-game):

```
metro_selftest
```

This exercises the active storage backend end to end — create, save, reload, and log a
transaction — and prints `SELF-TEST PASSED` or the specific failure.

## Layout

```
metro.txt                          gamemode manifest
gamemode/shared.lua                DeriveGamemode("sandbox"), shared definitions
gamemode/init.lua                  server entry, explicit module include list
gamemode/cl_init.lua               client entry, explicit module include list
gamemode/modules/sv_config.lua     loads and validates config/database.lua
gamemode/modules/sv_migrations.lua shared, ordered, idempotent schema migrations
gamemode/modules/sv_storage.lua    storage facade: backend selection, frozen at boot
gamemode/modules/sv_storage_mysql.lua   mysqloo backend, reconnect/backoff on loss
gamemode/modules/sv_storage_sqlite.lua  built-in sqlite backend
gamemode/modules/sv_selftest.lua   metro_selftest console command
gamemode/modules/sv_boot.lua       GM:Initialize — connect, migrate, log
config/database.lua.example        committed credential template
scripts/setup-mysqloo.sh           fetches the mysqloo binary module
```

Module includes go through the explicit ordered lists in `gamemode/init.lua` and
`gamemode/cl_init.lua`, never a directory sweep, so load order stays readable and
deterministic.
