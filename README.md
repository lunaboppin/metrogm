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
gamemode/shared.lua                DeriveGamemode("sandbox"), METRO.Include/IncludeDir
gamemode/init.lua                  server entry: ordered includes, then a module sweep
gamemode/cl_init.lua               client entry: sh_language.lua first, then a module sweep
gamemode/languages/sh_english.lua  LANGUAGE table consumed by METRO.Lang
gamemode/modules/sh_language.lua   METRO.Lang, L()/L2(), NotifyLocalized
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

## Module loading

`METRO.Include(path, realm)` and `METRO.IncludeDir(dir, recursive, skip)`, defined in
`gamemode/shared.lua`, are a port of Helix's `ix.util.Include`/`IncludeDir`
(`ref/lua/helix/gamemode/core/sh_util.lua`). Realm is inferred from the filename prefix
(`sv_` server, `sh_`/`shared.lua` shared with automatic `AddCSLuaFile`, `cl_` client) and
can be overridden with the second argument.

`gamemode/init.lua` and `gamemode/cl_init.lua` no longer hand-maintain an ordered file
list for most modules — they call `METRO.IncludeDir("modules", false, skip)` to sweep
`gamemode/modules/*.lua` in sorted order. Three files are still included explicitly, in
this fixed order, before the sweep runs (and excluded from it via `skip`):

1. `modules/sh_language.lua` — defines `L`/`L2` before anything else in `modules/` could
   call them, and is loaded before `METRO.Lang.LoadFromDir("languages")` runs.
2. `modules/sv_storage_sqlite.lua`, then `modules/sv_storage_mysql.lua`, then
   `modules/sv_storage.lua` — the two backends must register into `METRO.Backends` before
   the storage facade runs. Alphabetical sort would put `sv_storage.lua` ahead of
   `sv_storage_mysql.lua`/`sv_storage_sqlite.lua` (`.` sorts before `_`), which is the
   wrong order, so it is pinned explicitly rather than left to the sweep.
3. `modules/sv_boot.lua` — included last, explicitly, after the sweep, since it fires
   `GM:Initialize` and must run after every other module has registered.

Everything else in `gamemode/modules/` (currently `sh_levels.lua`, `sv_admin.lua`,
`sv_config.lua`, `sv_economy.lua`, `sv_migrations.lua`, `sv_network.lua`,
`sv_players.lua`, `sv_selftest.lua`, and the client-only `cl_*.lua` files) has no
load-order dependency on any other module at include time — they only reference each
other from inside functions that run later, once boot has finished — so a sorted sweep
is safe for them.

## Language system

`METRO.Lang` (`gamemode/modules/sh_language.lua`) is a port of Helix's `ix.lang`
(`ref/lua/helix/gamemode/core/libs/sh_language.lua`). Language files live at
`gamemode/languages/sh_<language>.lua`, each setting a `LANGUAGE` table of
`key = "string"` pairs and an optional `NAME`. `METRO.Lang.LoadFromDir(dir)` loads every
`sh_*.lua` file in a directory this way; `METRO.Lang.AddTable(language, tbl)` adds
phrases from code instead.

`L(key, ...)` on the client and `L(key, client, ...)` on the server resolve the given (or
recipient's) language, falling back English → raw key, and pass the result through
`string.format`. `L2(key, ...)` / `L2(key, client, ...)` do the same lookup but return
`nil` instead of falling back. The recipient's language is `client:GetInfo("metro_language")`,
a replicated client `ConVar` defaulting to `"english"`.

`ply:Notify(text)` and `ply:NotifyLocalized(key, ...)` (server only) send a targeted `net`
message (`MetroNotify`) to that player; the client prints it via
`METRO.Lang.ReceiveNotify(text)`, a single one-line function meant to be replaced once a
real notification UI exists.

No literal English strings remain in `sv_admin.lua`, `cl_hud.lua`, or `cl_menu.lua` — see
`gamemode/languages/sh_english.lua` for the keys.

`METRO.Lang.ReceiveNotify` no longer just prints — `gamemode/modules/cl_notify.lua` shows a
stacked, auto-fading `metroNotice` toast for every `ply:Notify`/`NotifyLocalized` call.

## UI: skin, panels, menu, HUD

`gamemode/modules/cl_skin.lua` defines the `"metro"` Derma skin and `GM:LoadFonts`, both
ported from Helix's `core/cl_skin.lua` and `core/hooks/cl_hooks.lua`. The accent colour
(`METRO.UI.GetAccentColor()`) is read **at paint time** inside every skin paint function,
never baked in, so `METRO.UI.SetAccentColor(color)` (or the `metro_accentcolor r g b`
client console command) rethemes every panel that uses the skin immediately. Fonts are
created in one place, sized with `ScreenScale`, and re-created on `ScreenResolutionChanged`.

The skin is applied only to panels we build ourselves (`self:SetSkin("metro")` in each
panel's `Init`) rather than via `GM:ForceDermaSkin`, so stock spawnmenu/scoreboard/engine
Derma panels are unaffected — a deliberate scope limit, since the "metro" skin only
implements the paint routines our own panels call.

`gamemode/modules/cl_panel_*.lua` port the subset of Helix's `core/derma/cl_generic.lua`
and `cl_menubutton.lua` that the HUD and menu actually use, renamed with a `metro` prefix:
`metroLabel`, `metroCategory`, `metroSegmentedProgress`, and `metroMenuButton`/
`metroMenuSelectionButton`. The collapsible sub-section list
(`ixMenuSelectionList`/`ixMenuButton:AddSection`) was not ported — nothing in this
gamemode nests tabs yet.

`gamemode/modules/cl_menu.lua` rebuilds the F4 menu as a `metroMenu` panel. Tabs are
collected by running the `CreateMenuButtons` hook (Helix's `cl_menu.lua` pattern) into a
`key -> {Create = function(container) ... end}` table; the tab's key is itself a language
key, so a button's label is `L(key)`, and its content is only built the first time it is
selected. Adding a new tab elsewhere is:

```lua
hook.Add("CreateMenuButtons", "metroTrains", function(tabs)
	tabs.menuTrainsTab = {Create = function(container) return vgui.Create("metroTrains", container) end}
end)
```

The existing Profile panel is registered this way as the `menuProfileTab` tab, rebuilt on
`metroCategory`/`metroSegmentedProgress`/`metroLabel` instead of raw `DLabel`/`DProgress`.
The menu opens/closes via `PlayerBindPress` on `gm_showspare2` (F4's default bind) instead
of polling `input.IsKeyDown` in `Think` — see "Fixed: F4 keybind" below.

`gamemode/modules/cl_hud.lua` adds the hook Helix deliberately lacks:
`METRO.Hud.Add(id, drawFunction)` / `METRO.Hud.Remove(id)` register a HUD element to be
called every `HUDPaint`, so later features add a HUD element without editing this file.
`METRO.Hud.SetHidden(name, bool)` backs `GM:HUDShouldDraw`, for suppressing engine HUD
elements by name; nothing is hidden by default. `gamemode/modules/cl_hud_bar.lua` ports
Helix's `ix.bar.Add`-style stacked, auto-fading bars (`core/derma/cl_bar.lua`) as
`METRO.Bar.Add(getValueFn, color, priority, id)` / `metroInfoBarManager` — the intended
home for a speed readout once driving telemetry lands; nothing calls it yet.

Pure helpers with no VGUI dependency (money/playtime/first-seen formatting, fraction
clamping, an `Approach` easing step, colour darkening, sorted-keys) live in
`gamemode/modules/cl_format.lua` so they can be unit-tested outside GMod.

### Fixed: F4 keybind (closes #13)

The old `cl_menu.lua` polled `input.IsKeyDown(KEY_F4)` in `hook.Add("Think", ...)`, so it
fired while the player was typing and ignored key rebinding. The rebuilt menu binds via
`hook.Add("PlayerBindPress", ...)` matching `gm_showspare2` (F4's default bind), guarded by
`ply:IsTyping()`. Note: a prior commit (`b0b632d`) already made this same fix before this
PR existed; this PR's rewrite keeps it.

## Third-party code

Portions of `gamemode/shared.lua` (`METRO.Include`/`IncludeDir`),
`gamemode/modules/sh_language.lua` (`METRO.Lang`, `L`, `L2`, `NotifyLocalized`), and the UI
layer (`gamemode/modules/cl_skin.lua`, `cl_panel_*.lua`, `cl_menu.lua`, `cl_hud.lua`,
`cl_hud_bar.lua`, `cl_notify.lua`) are ported from
[Helix](https://github.com/NebulousCloud/helix), MIT licensed. See
`LICENSES/helix-MIT.txt`.
