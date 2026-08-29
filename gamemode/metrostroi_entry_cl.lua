if Metrostroi then
    print("[metro] Metrostroi global already present, workshop scripts addon has loaded, skipping vendored copy")
    return
end

include("metrostroi_vendor_autorun/metrostroi.lua")
include("metrostroi_vendor_autorun/prop_button.lua")
include("metrostroi_vendor_autorun/prop_float_ex.lua")
