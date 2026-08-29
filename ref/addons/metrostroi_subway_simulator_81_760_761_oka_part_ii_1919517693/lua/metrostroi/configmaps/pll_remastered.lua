local Map = game.GetMap() or ""

if Map:find("jar_pll_remastered") then
    --Metrostroi.PlatformMap = "orange"
    --Metrostroi.CurrentMap = "gm_jar_pll_remastered"
else
    return
end

Metrostroi.AddPassSchemeTex("760","PLL (Line 1)",{
	"metrostroi_skins/81-760_schemes/pll_remastered_line_1",
})
Metrostroi.AddPassSchemeTex("760","PRL (Line 2)",{
	"metrostroi_skins/81-760_schemes/pll_remastered_line_2",
})

Metrostroi.AddCISConfig("ASNP", {
	{
        LED = {4,4,5,4,5,4,4},
        Name = "Ленинградская линия",
        Loop = false,

		Line = 1,--Номер отображаемой линии
		Color = Color(197,213,75),	
		English = false,--есть ли английский информ				
        {
            150,"Лесопарковая",
        },
        {
            151,"Селигерская",
        },
        {
            152,"Двигатель Революции",
        },
        {
            153,"Строгино",
        },
        {
            154,"Черкасская Площадь",
        },
        {
            155,"Арсенальная",
        },
        {
            156,"Новомосковская",nil,true,"Динамо",2,nil,Color(64,109,173),
        }
    },
    {
        LED = {10,10,10},
        Name = "Пролетарская линия",
        Loop = false,

		Line = 2,--Номер отображаемой линии
		Color = Color(64,109,173),	
		English = false,--есть ли английский информ				
        {
            157,"Динамо",nil,true,"Новомосковская",1,nil,Color(197,213,75),
        },
        {
            158,"Пролетарская",
        },
        {
            159,"Октябрьская",
        }
    },
})
