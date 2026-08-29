# metro

A Garry's Mod gamemode built on the Metrostroi addon, modelled on Stepford County Railways:
players start with a starter train and progress by earning money and XP to unlock better
trains, with balances and progression shown on the HUD and in menus.

**v1 skeleton is complete.** It deliberately contains **none** of the train progression yet
— only the foundation: the gamemode loads, persists player records to MySQL, and shows money,
XP, level and playtime on a HUD and in an F4 profile panel, with superadmin money commands and
an audit ledger. No trains, no earning loop. See issue #9 for the direction, and #17 for the
write-ordering fix that should land before any earning loop is built.

## Start here: the reference document

**`docs/REFERENCE.md` is required reading before working on this gamemode.** It records what we
learned from studying `ref/` — the Helix framework, the Metrostroi addon ecosystem, and the NDR
Victoria Avenue Line map — and what each of those means for how we build.

It covers: our current API surface and schema; Helix's loader, library, UI, menu, language and
command conventions and which of them we are adopting; how Metrostroi spawns trains and the
`MetrostroiSpawnerRestrict` hook that unlock gating must use; the telemetry available for an
earning loop; the map's station list; and the open architectural decisions.

Read it before proposing changes, and update it when you learn something that would have saved you
time. `ref/` itself is **reference only** — never mounted by the server, never depended on at
runtime; the real addons arrive via workshop collection `3420307702`.

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

## Testing against a real server

There is no game client here, so anything client-rendered (the HUD, the F4 menu) can only be
verified by a human. Everything server-side is testable headlessly:

```bash
cd ~/gmod-server && nohup ./srcds_run -game garrysmod -console -norestart -port 27015 \
  -maxplayers 4 +sv_lan 1 +rcon_password <pw> +gamemode metro +map gm_metrostroi_b50 \
  < /dev/null > /tmp/boot.log 2>&1 &
```

Gotchas that cost real time, in the order they bite:

- **srcds block-buffers stdout** when redirected. A log that stops after the Steam API lines
  does not mean it hung — verify through RCON and the database instead.
- **RCON binds to `127.0.1.1`**, not `127.0.0.1`.
- **RCON only relays output from a command's synchronous portion.** Async callback prints never
  arrive, so read results from the database rather than trusting console silence.
- **`pgrep -f srcds_linux` matches the invoking shell's own command line.** Use `pgrep -x`, and
  when several servers run at once kill by PID from `ps -eo pid,cmd`, never by name.
- **`GM:ShutDown` only fires on a clean `quit`.** A raw process kill bypasses shutdown saves, so
  it is not a valid way to test persistence.
