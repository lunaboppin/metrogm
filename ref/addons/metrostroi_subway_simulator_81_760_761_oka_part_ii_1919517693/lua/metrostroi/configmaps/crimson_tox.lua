local Map = game.GetMap() or ""

if Map:find("gm_mus_crimson") and Map:find("tox") then
else
	return
end

Metrostroi.AddPassSchemeTex("760","Crimson tox",{
	"metrostroi_skins/81-760_schemes/crimson_tox",
})

Metrostroi.AddCISConfig("ASNP Boiko",{
		{
			LED = {5, 5, 5, 5, 5, 5},
			Name = "Линия 5 (Малиновая Линия)",
			Loop = false,

			Line = 5,
			Color = Color(255,81,158),
			English = false,
			{
				501,
				"Аэропорт",nil,true,"Аэропорт",4,nil,Color(255,109,63),
			},
			{
				502,
				"Пионерская",

			},
			{
				503,
				"Литиевая",nil,true,"Литиевая",4,nil,Color(255,109,63),

			},
			{
				504,
				"Метростроителей",
			},
			{
				505,
				"Мастерская",

			},
			{
				506,
				"Каховская",

			}
		}
	}
)