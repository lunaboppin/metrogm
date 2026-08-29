# Vendored code

## Metrostroi

`entities/entities/`, `entities/weapons/`, `gamemode/metrostroi/`, `gamemode/metrostroi_data/`,
`gamemode/metrostroi.lua`, `gamemode/prop_button.lua` and `gamemode/prop_float_ex.lua` are
vendored from the Metrostroi Subway Simulator scripts addon, upstream at
`https://github.com/metrostroi-repo/MetrostroiAddon`.

File contents are unchanged from upstream, including their original comments. Only
`gamemode/metrostroi_entry_sv.lua` and `gamemode/metrostroi_entry_cl.lua`, which load the
vendored files and guard against the separate scripts addon also being present, are code this
repository authored.

See `metrostroi.txt` for the upstream licence, verbatim.
