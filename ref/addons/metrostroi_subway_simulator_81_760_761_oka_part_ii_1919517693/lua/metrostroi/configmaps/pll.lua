local Map = game.GetMap() or ""

if Map:find("jar_pll") and not Map:find("redux") and not Map:find("remastered") then
	--Metrostroi.PlatformMap = "orange"
	--Metrostroi.CurrentMap = "PLL"
else
	return
end
Metrostroi.AddPassSchemeTex("760","pll",{
	"metrostroi_skins/81-760_schemes/pll",
})

Metrostroi.AddCISConfig("ASNP", {
    {
        LED = {10,10,10},
        Name = "Линия 1",
        Loop = false,
		BlockDoors = true,
		
		Line = 1,--Номер отображаемой линии
		Color = Color(203,216,75),	
		English = false,--есть ли английский информ				
        {
            903,
            "Ленинградская",
        },
		{
            904,
            "Селигерская",
        },
        {
            505,
            "Петрищево",
        },
    }
})