local Map = game.GetMap() or ""

if Map:find("jar_pll_redux") then
	--Metrostroi.PlatformMap = "orange"
	--Metrostroi.CurrentMap = "gm_jar_pll_redux"
else
	return
end

Metrostroi.AddPassSchemeTex("760","pll redux",{
	"metrostroi_skins/81-760_schemes/pll_redux",
})

Metrostroi.AddCISConfig("ASNP",{
		{
			LED = {10,10,10},
			Name = "ПЛЛ",
			Loop = false,
			
			Line = 1,--Номер отображаемой линии
			Color = Color(96,172,147),	
			English = false,--есть ли английский информ				
			{
				505,"Селигерская",
			},
			{
				506,"Ленинградская",
			},
			{
				507,"Проспект Мира",
			}
		}
	}
)
