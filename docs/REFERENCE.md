# Metro — Reference

What we have learned from studying `ref/`, and what it means for how this gamemode gets built.

`ref/` is **reference material only**. It is never mounted by the server; the real addons reach
players through workshop collection `3420307702`. Read it, copy patterns from it, never depend
on paths inside it at runtime.

Sources studied: `ref/lua/helix` (the Helix roleplay framework), `ref/addons/*` (Metrostroi core,
train packs, tools, and the NDR map), and this repository's own `gamemode/`.

---

## 1. Where we are today

v1 is a **skeleton with no train gameplay at all**. What exists is the foundation the gameplay
will sit on.

| Module | Purpose |
|---|---|
| `sh_levels.lua` | Pure XP↔level curve, shared client and server |
| `sv_config.lua` | Loads and validates `config/database.lua` |
| `sv_migrations.lua` | Ordered, idempotent, dialect-aware migrations |
| `sv_storage.lua` | Facade; picks backend once at boot and delegates |
| `sv_storage_mysql.lua` / `sv_storage_sqlite.lua` | The two backends |
| `sv_network.lua` | Targeted `net` messages, owner only |
| `sv_players.lua` | Record cache, load gating, autosave |
| `sv_economy.lua` | All money and XP mutation, with audit rows |
| `sv_admin.lua` | Superadmin console commands |
| `sv_selftest.lua` | `metro_selftest`, exercises the whole stack |
| `sv_boot.lua` | `GM:Initialize` — connect, migrate, ready |
| `cl_stats.lua` / `cl_hud.lua` / `cl_menu.lua` | Client cache, HUD, F4 profile panel |

Public API, confirmed against source:

```lua
METRO.Levels.TotalXpForLevel(level) / LevelForXp(xp) / GetMaxLevel() / Progress(xp)
METRO.Storage.Connect / RunMigrations / LoadPlayer / CreatePlayer / SavePlayer
             / LogTransaction / GetBackendName
METRO.Players.Get(ply) / IsLoaded(ply) / Save(ply, cb)
METRO.Players.RegisterVar(name, data) / GetVar(target, name, default) / SetVar(target, name, value, ...)
METRO.Network.SyncVars(ply) / PushStats(ply) / PushLoadState(ply, state, message)
METRO.Economy.AddMoney / SetMoney / AddXp / SetXp   (ply, value, reason, actor, cb)
METRO.Boot.IsReady() / GetError() / WaitForReady(cb)
```

Schema: `metro_players`, `metro_transactions` (with a `kind` discriminator separating money from
XP history), `metro_schema_version`. Five migrations, currently at version 5. Registered player
variables provide the player-table column metadata and are reconciled by the migration runner.

**Open issues that matter:** [#17](https://github.com/lunaboppin/metrogm/issues/17) (concurrent
saves can race and overwrite newer values — **fix before any earning loop**),
[#22](https://github.com/lunaboppin/metrogm/issues/22) (no CPPI provider; see §5),
[#18](https://github.com/lunaboppin/metrogm/issues/18) (BIGINT precision above 2^53, low),
[#9](https://github.com/lunaboppin/metrogm/issues/9) (roadmap).

---

## 2. Helix — how it is put together

Helix is a **base gamemode** deriving from sandbox. A "schema" is not a separate thing: it is
loaded through the same `ix.plugin.Load` path as any plugin, with `uniqueID == "schema"` and its
global named `Schema` instead of `PLUGIN`. A custom gamemode built on Helix does
`DeriveGamemode("helix")` and supplies `schema/` and `plugins/` folders — Helix's own
`init.lua`/`shared.lua` remain the real bootstrap.

### Realm-prefix includes

`ix.util.Include(file, realm)` decides realm from the **filename prefix** — `sv_`, `sh_` (or
`shared.lua`), `cl_` — and handles `AddCSLuaFile`/`include` automatically. `ix.util.IncludeDir`
walks a folder doing the same.

This is the single cheapest, highest-value convention to adopt. We already name files this way;
we just do the include wiring by hand.

### Libraries

Every subsystem is a table hung off a global singleton, guarded `ix.<lib> = ix.<lib> or {}` so
re-inclusion is idempotent. We already use exactly this shape with `METRO.<lib>`.

Notable ones: `ix.config` (typed networked server config), `ix.plugin`, `ix.char` + `ix.player`
(persistence), `ix.currency`, `ix.command`, `ix.log`, `ix.db`, `ix.net`, `ix.lang`, `ix.option`,
`ix.flag`, `ix.bar`, `ix.hud`.

### The pattern most worth stealing: `RegisterVar`

`ix.char.RegisterVar(name, data)` — one declaration generates a **DB column**, a
**getter/setter**, and the **networking scope**:

```lua
ix.char.RegisterVar("money", {
    field = "money", fieldType = ix.type.number,
    default = 0, isLocal = true, bNoDisplay = true
})
```

`isLocal` sends to the owner only; default broadcasts; `bNoNetworking` never sends. Every setter
fires a `CharacterVarChanged` hook.

Adopting a `METRO.Players.RegisterVar` equivalent would remove the current four-step ritual of
"add field, add migration, add accessor, add push" every time a player gains a stat. This is a
pure ergonomics win layered on our storage adapter, not a replacement for it.

### Networking

`ix.net` is **state synchronisation**, not RPC: global vars, per-player local vars, and entity
netvars, each with a set/get pair and delta broadcast, plus `SyncVars()` to re-push everything on
join. One-off actions go through `ix.command` or per-feature `net.Receive` handlers.

---

## 3. Helix — UI, theming and language

### Panels

Custom panels live in `derma/` folders, registered with `vgui.Register("ixName", PANEL, base)`,
auto-included by the plugin loader. Useful building blocks: `ixLabel`, `ixCategoryPanel`,
`ixSegmentedProgress`, `ixMenuSelectionButton`/`ixMenuSelectionList`,
`ixSubpanel`/`ixSubpanelParent`, `ixTooltip`, `ixNotice`, `ixInfoBar`, `ixModelPanel`.

`ixBusiness` (`gamemode/core/derma/cl_business.lua`) is a working shop panel and the closest
existing analogue to a train shop.

### Menu tabs are hook-registered

`ixMenu` collects its tabs by running a hook — tabs are not hardcoded:

```lua
hook.Add("CreateMenuButtons", "metroTrains", function(tabs)
    tabs["trains"] = {
        Create = function(info, container) container:Add("ixTrains") end
    }
end)
```

Content is built lazily on first selection, which matters for a long train list.

**The tab key is a language key.** `ixMenu:SetupTab` labels the button with `L(name)`, so a tab
registered as `"trains"` is labelled by `LANGUAGE.trains`. Localisation is not decoration here —
it is how the UI gets its text.

### Theming

The accent colour is not baked into the skin; `cl_skin.lua` reads `ix.config.Get("color")` live.
Retheming is `ix.config.SetDefault("color", ...)`, not a skin fork. Fonts are all created in
`GM:LoadFonts(font, genericFont)`, re-run on config change and on `ScreenResolutionChanged`, with
sizes via `ScreenScale(n)` — that is the resolution-independence mechanism.

### HUD — note the gap

There is **no generic "register a HUD element" hook**. `ix.hud.DrawAll()` is direct function
composition, called from `GM:PostDrawHUD`. Hiding engine HUD elements is `GM:HUDShouldDraw` with a
`hidden[name] = true` lookup.

`ix.bar.Add(getValueFn, color, priority, id)` does give stacked, auto-fading bars — the natural fit
for a future speed or fuel readout.

### Language

`ix.lang`, in `gamemode/core/libs/sh_language.lua`. Files live at `languages/sh_<language>.lua` in
the schema or any plugin, each setting a `LANGUAGE` table of `key = "string"`. Lookup is `L(key, ...)`
client-side, `L(key, client, ...)` server-side, falling back English → raw key, and everything is
passed through `string.format`, so `%s`/`%d` are the formatting mechanism. There is no plural-rules
engine; write separate keys. `L2` returns nil instead of falling back.

For player-facing feedback, `client:NotifyLocalized(key, ...)` resolves per-recipient language
server-side. Prefer it over `Notify`.

**Rule for us: no literal English in panel or notification code, from the start.**

---

## 4. Helix — gameplay patterns

### The vendor plugin is the model for the shop

`ref/lua/helix/plugins/vendor/`. What to copy:

- **Everything server-authoritative.** The client requests a trade; it never computes a price or
  authorises a purchase. All mutation lives on the server and deltas are pushed back.
- **One validated purchase path.** A single `net.Receive` handler re-checks distance, access,
  affordability and stock *every time*, even though the UI already filtered. Nothing is trusted
  from the client except "which item" and "buy or sell".
- **Rate limiting** on the trade message to stop spam-clicking races.
- **Save immediately after every mutating action.**
- **Log every trade.** Directly analogous to our audit ledger.

### Money

`ix.currency.Get(amount)` is presentational formatting only. Mutation is
`character:GiveMoney/TakeMoney`, which take an unsigned amount and derive direction from the
function name — worth mirroring, since it makes call sites hard to misuse with a wrong sign.

Otherwise **ours is stricter and should be kept**: Helix has no ledger (`ix.log` is a
human-readable admin scrollback, not queryable history), `TakeMoney` is not atomic and does not
clamp at zero, and logging is opt-out via `bNoLog`. Our BIGINT storage, single audited mutation
path and non-optional audit rows are all better for our needs.

### Ownership — do not use the item system

Helix's item/inventory system is grid packing, stacking, equip slots and per-item `data` blobs,
backed by `ix_items`/`ix_inventories` rows. Train ownership is a **flat owned-set**: does player X
own class Y. `ix.flag` is the closer Helix analogue.

Proposed shape:

```sql
CREATE TABLE metro_owned_trains (
  steamid64   VARCHAR(20) NOT NULL,
  train_class VARCHAR(64) NOT NULL,
  acquired_at DATETIME,
  PRIMARY KEY (steamid64, train_class)
);
```

with an in-memory cache restored on player load — Helix's caching pattern, without its machinery.

### Commands

`ix.command.Add` gives typed argument declarations with automatic coercion and validation,
CAMI-based per-command privileges (auto-registered from `adminOnly`/`superAdminOnly`), uniform
`return "@langKey"` error feedback, a client-side cooldown, and automatic logging of every run.
Works from both chat and console with tab-completion.

Our admin commands are raw `concommand` with hand-rolled parsing. Migrating is worthwhile; at
minimum adopt typed argument checking, CAMI privileges, and unified notify-on-failure.

CAMI is also what buys interoperability with whatever admin mod the operator installs.

---

## 5. Metrostroi — what the gamemode must hook into

Most *code* lives in `metrostroi_subway_simulator_scripts_1095130789`; the large
`metrostroi_subway_simulator_261801217` is mostly models, materials and a second map.

### Train classes

Every train is a `scripted_ents` entity with `ENT.Base = "gmod_subway_base"` and a
`gmod_subway_` prefix, `Spawnable = true`, `Category = "Metrostroi (trains)"`.

| Class | Provided by |
|---|---|
| `81-501`, `81-502` | scripts |
| `81-702`, `81-702_int`, `81-703`, `81-703_int` | scripts |
| `81-714_mvm`, `81-714_lvz`, `81-717_mvm`, `81-717_lvz` | scripts |
| `81-718`, `81-719`, `81-720`, `81-721`, `81-722`, `81-723`, `81-724` | scripts |
| `em508t`, `ezh`, `ezh1`, `ezh3`, `tatra_t3` | scripts |
| `81-540_2k`, `81-541_2k` | 81-540 2K pack |
| `81-7145p`, `81-7175p` | Аквариум pack |
| `81-760`, `81-760a`, `81-761`, `81-761a`, `81-763a` | Oka Part II |

**Do not hardcode this list.** Metrostroi enumerates its own classes at startup; treat
`Metrostroi.TrainClasses` as ground truth and keep our unlock metadata (tier, price, level
requirement, display name) in our own config keyed by class name.

Caveats: `81-501` and `81-502` share an identical `PrintName`, probably an addon bug. `81-720`/`81-721`
are the only pair flagged `AdminSpawnable`. The helper addon contains a stale, aspirational class
list — do not use it as a catalogue.

### Spawn interception — the key hook

Trains are spawned through a custom STool (`weapons/gmod_tool/stools/train_spawner.lua`), not
plain spawnmenu drag-and-drop. Before spawning it runs:

```lua
hook.Run("MetrostroiSpawnerRestrict", owner, settings)  -- truthy return blocks the spawn
```

`settings.Train` is the class name, `settings.WagNum` the wagon count. **This is where unlock
gating goes.** It is proven: `metrostroi_advanced` already uses this hook to gate classes by ULX
group.

Two caveats:

- The hook fires only from the tool path. Raw spawnmenu creation of `gmod_subway_*` is
  **currently unguarded** — add a `PlayerSpawnedSENT` backstop.
- If `metrostroi_advanced` stays enabled, both handlers fire on the same hook. They compose only
  if each returns truthy to block.

### Ownership is broken out of the box

Metrostroi tracks ownership purely through **CPPI** (`CPPISetOwner`/`CPPIGetOwner`), an interface
supplied by prop-protection addons — never by base GMod. **No provider is installed**, verified by
grep: only consumers exist. So ownership attribution and `metrostroi_maxtrains_onplayer` silently
do nothing. See [#22](https://github.com/lunaboppin/metrogm/issues/22).

Also note: Metrostroi does **not persist** train ownership across map changes. Any durable
"you own this train" concept is entirely ours to model.

### Telemetry for an earning loop

- **Speed:** `train.Speed`, `train.Acceleration`, maintained by the physics driver.
- **Distance along track:** `Metrostroi.TrainPositions[train]` records expose `.x`, `.y`, `.z`,
  `.distance`, `.forward`, `.node`, `.path`. `.distance` is the natural odometer.
- **Station/platform detection:** `Metrostroi.Stations[stationID][platformID]` carries
  `.node_start.path`, `.x_start`, `.x_end`. Metrostroi's own `ENT:ReadCell` shows the algorithm for
  computing current/next/previous station by comparing train `pos.x` against platform ranges.
- **Session boundaries:** `PlayerEnteredVehicle` / `PlayerLeaveVehicle`, filtered by
  `veh:GetNW2Entity("TrainEntity")`. **Also check `train:GetDriver() == ply`** — those hooks fire
  for passengers in any wagon too.
- **Signals passed:** not solved out of the box. `gmod_track_signal` exists with lamp states, but
  there is no "signal passed" event; it would need proximity checks against train `.distance`.
- The built-in "Telemetry" system writes CSV to a hardcoded Windows path. Unusable; ignore it.

**Abuse vector to remember:** the base train entity exposes a large Wiremod I/O surface, so a
player may be able to drive without occupying the driver's seat.

---

## 6. The map — NDR Victoria Avenue Line

`gm_metro_ndr_val_v2r1`, from workshop item `2521308350`. One line, no branching, eight stops.

| ID | Station | Interchange |
|---|---|---|
| 200 | Garden Circus | — |
| 201 | Victoria - Burrow | — |
| 202 | Victoria Avenue | UR Metro M3 |
| 203 | North-Gate Bridge | — |
| 204 | Victoria Promenade | — |
| 205 | Central Street | UR Metro M3, NDR Downtown |
| 206 | Lakefield Street | UR Metro M1 |
| 207 | Fisherman's Hut | — |
| 208 | South-Port Junction | NDR Port-Town Line |

Line "VAL", `Line = 2`, colour `Color(123, 0, 0)`, non-looping, English announcer. The station table
appears identically in `lua/metrostroi/configmaps/victoria_line_760.lua` and
`lua/metrostroi/maps/victoria_line.lua`.

Also shipped: custom liveries for `81-720`, `81-722`, `81-760`; destination-sign textures for
`702`/`710`/`717`/`720`; two English announcer voice packs recorded for these station names; a
2,141-point track polyline; and generated signal/gradient data for the map.

The named interchanges (UR Metro M1/M3, NDR Downtown, Port-Town) have no playable content in this
addon set — they are flavour text for announcements.

Spawn points, platform entities and signal placement are compiled into the `.bsp` and are not
discoverable from Lua without decompiling. The station ID table above is the canonical route source.

**This is the backbone for routes, timetables and station-stop payouts.** Nine IDs, real names,
already voiced.

---

## 7. Settled: standalone, porting the good parts

**Decided 2026-08-29. metro stays a standalone gamemode and ports the Helix subsystems that
carry their weight.** It does not become a Helix schema.

**Why.** A schema means
`DeriveGamemode("helix")`, inheriting character creation, IC/OOC chat, grid inventories,
factions-as-teams, doors and vendor NPCs — much of which we would suppress rather than use. Helix
wants to own the whole gamemode lifecycle, which may fight Metrostroi's vehicle and seat code. And
two of our systems are genuinely better than the Helix equivalents: our ledger vs `ix.log`'s
scrollback, and our ordered migrations vs `ix.db`'s additive-only, column-existence-driven schema
evolution which cannot drop or retype columns.

**What that costs us.** A schema would have handed us the UI framework, language system,
command system, config system, plugin loader and permission integration as working code. Standalone
means porting each one deliberately — sections 3 and 4 are the map for doing that.

### What we port

| From Helix | Into metro | Why |
|---|---|---|
| `ix.util.Include` realm prefixes | A `METRO.Include`/`IncludeDir` helper | Removes the hand-maintained ordered module lists in `init.lua`/`cl_init.lua` |
| `ix.char.RegisterVar` | `METRO.Players.RegisterVar` | One declaration replaces the add-field/add-migration/add-accessor/add-push ritual |
| `ix.lang` | `METRO.Lang` + `languages/sh_english.lua` | Adopt **before** writing panels; retrofitting `L()` later costs more |
| `CreateMenuButtons` tab hook | Our own menu tab hook | Tabs register themselves; content builds lazily |
| `ix.command.Add` | Typed, CAMI-gated commands | Replaces hand-rolled `concommand` parsing and admin checks |
| `ix.currency.Get` | A single money formatter | One place that decides how money renders |
| Give/Take naming split | `METRO.Economy` call sites | Unsigned amount, direction from the function name, harder to misuse |

### What we keep, unchanged

The storage adapter, ordered migrations, gated player lifecycle, audited economy and level curve.
Nothing in Helix improves on these, and two of its equivalents are worse: `ix.log` is a
human-readable admin scrollback rather than a queryable ledger, and `ix.db` schema evolution is
additive-only and column-existence-driven, unable to drop or retype a column.

### What we deliberately do not take

`DeriveGamemode("helix")` and the schema model; the item/inventory grid system (train ownership is
a flat owned-set); characters as a layer above players (we have one record per SteamID and need no
more); factions-as-teams, IC/OOC chat, doors and vendor NPCs.

### Consequence for sequencing

The language system and the include helper are **foundational** — they change how every subsequent
file is written. Do those before the train catalogue, shop or earning loop, not alongside them.

---

## 8. Things to do before the gameplay work starts

1. **Fix [#17](https://github.com/lunaboppin/metrogm/issues/17) first.** Concurrent saves can race.
   Today that is rare because money only moves on an admin command. An earning loop firing frequent
   small payments turns it into routine silent money loss.
2. **Decide [#22](https://github.com/lunaboppin/metrogm/issues/22).** Train ownership cannot be
   built on an inert ownership mechanism. Ship a CPPI shim, add a provider to the collection, or
   track ownership ourselves and accept that Metrostroi's own limits stay broken.
3. **Port the language system and the include helper** (§7) before any new UI or gameplay files
   are written — both change how every later file is structured, and retrofitting `L()` across
   finished panels costs strictly more than starting with it.

## 9. Signal display

The client-only signal-name display in `gamemode/modules/cl_signal_display.lua` reads the
`Name` already delivered by Metrostroi for each `gmod_track_signal`; it adds no server hooks or
network messages. A timer refreshes the nearby candidate cache, applying distance, camera-facing,
signal-facing, and world-occlusion checks before `PostDrawTranslucentRenderables` draws a fading
3D2D label. Players can toggle it with `metro_toggle_signal_names`; the `metro_signal_names`
client convar is saved in their local configuration.

The reference route overlay in
`ref/addons/metrostroi_draw_signals_routes_commands_2219218214` sends route data from the server
and was not copied because signal identity is already available client-side. Route and command
visualisation, station readouts, and train occupancy tracking remain separate follow-up work.
The display requires visual verification with a real game client; headless checks can only cover
syntax and static invariants.
