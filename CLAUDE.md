# metro

A Garry's Mod gamemode built on the Metrostroi addon, modelled on Stepford County Railways:
players start with a starter train and progress by earning money and XP to unlock better
trains, with balances and progression shown on the HUD and in menus.

The current milestone (**v1 skeleton**) deliberately contains **none** of that. It builds
only the foundation: a gamemode that loads, persists player records to MySQL, and displays
money, XP, level and playtime. No trains, no economy. See issue #9 for the direction.

## Absolute rules

- **No code comments. Ever.** If a line needs explaining, rename something or extract a function.
- This repository is **public**. Never commit credentials. `config/database.lua` is gitignored;
  `config/database.lua.example` is the committed template.
- Branch per issue, PR, squash-merge. Reference the issue the branch closes.

## Layout

```
metro.txt                     gamemode manifest
gamemode/shared.lua           DeriveGamemode("sandbox"), shared definitions
gamemode/init.lua             server entry
gamemode/cl_init.lua          client entry
config/database.lua.example   committed credential template
scripts/setup-mysqloo.sh      fetches the mysqloo binary module
```

Module includes go through an explicit ordered list in the entry files, never a directory
sweep, so load order stays readable and deterministic.

## Architecture

**Storage.** Everything goes through one storage adapter. Nothing else touches the database.
Two backends implement it: MySQL via mysqloo, and SQLite. The backend is chosen **once at
boot** and never changes. A mid-session MySQL failure reconnects and retries; it must never
divert writes to SQLite, because data split across two stores is worse than refusing to write.

**Money.** `BIGINT`, whole units, no decimals anywhere. Nothing divides money. All mutation
routes through a single function that also writes the audit row.

**Progression.** `xp` is authoritative. `level` is a denormalised cache recomputed from a
single shared pure curve function on every XP change. Nothing writes `level` on its own.

**Persistence.** Write-through: every mutation immediately fires an async save, with a final
write on disconnect and shutdown.

**Load race.** Players are held frozen and non-drawing with a loading overlay until their
record is in memory. This is structural, not a check to remember at each call site.

**Networking.** Player stats go to the owning client only, via a targeted `net` message on
load and on every mutation. Balances are never broadcast.

## Setup

1. `scripts/setup-mysqloo.sh`
2. `cp config/database.lua.example config/database.lua` and fill it in
3. Set `GAMEMODE="metro"` in the server's `server.env`
