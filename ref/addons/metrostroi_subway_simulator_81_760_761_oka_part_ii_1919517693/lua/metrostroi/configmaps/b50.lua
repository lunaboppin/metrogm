local Map = game.GetMap():lower() or ""

if Map:find("gm_metrostroi") and not Map:find("lite") then

else
    return
end
Metrostroi.AddPassSchemeTex("760","Line 1",{
    "metrostroi_skins/81-760_schemes/b52_line_1",
})
Metrostroi.AddPassSchemeTex("760","Line 3",{
    "metrostroi_skins/81-760_schemes/b52_line_3",
})
--[[
Metrostroi.AddPassSchemeTex("760","Line 2",{
    "metrostroi_skins/81-760_schemes/b52_line_2",
})]]

Metrostroi.AddCISConfig("ASNP Boiko + Pyaseckaya",{
    {
        LED = {2, 2, 2, 2, 2, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2},
        Name = "Индустриальная-Синеозёрная",
        Loop = false,		
        BlockDoors = true,

		Line = 1,--Номер отображаемой линии
		Color = Color( 82, 172,  98),--цвет на бнт
		English = false,--есть ли английский информ		
        {
            108,
            "Автозаводская",nil,true,"Автозаводская",3,nil,Color(58,150,250),
        },
        {
            109,
            "Индустриальная",nil,true,"Индустриальная",3,nil,Color(58,150,250),

        },
        {
            110,
            "Московская",nil,true,"Московская",3,nil,Color(58,150,250),
            right_doors=true,
        },
        {
            111,
            "Октябрьская",nil,true,"Октябрьская",3,nil,Color(58,150,250),

        },
        {
            112,
            "Площадь мира",nil,true,"Площадь мира",3,nil,Color(58,150,250),

        },
        {
            113,
            "Новоармейская",nil,true,"Новоармейская",3,nil,Color(58,150,250),

        },
        {
            115,
            "Комсомольская",nil,true,"Комсомольская",3,nil,Color(58,150,250),"Ленинская",2,nil,Color(255,0,0),
            right_doors=true,
        },
        {
            116,
            "Электросила",nil,true,"Электросила",3,nil,Color(58,150,250),

        },
        {
            117,
            "Театральная площадь",nil,true,"Театральная площадь",3,nil,Color(58,150,250),
        },
        {
            118,
            "Парк победы",nil,true,"Парк победы",3,nil,Color(58,150,250),
            right_doors=true,
        },
        {
            119,
            "Синеозёрная",nil,true,"Синеозёрная",3,nil,Color(58,150,250),

        },
        {
            121,
            "Минская",nil,true,"Минская",3,nil,Color(58,150,250),

        },
        {
            122,
            "Царские ворота",nil,true,"Царские ворота",3,nil,Color(58,150,250),
        },
        {
            123,
            "Междустройская",
            right_doors=true,
        }
    },
    {
        LED = {2, 2, 2, 2, 2, 3, 3,2, 2, 2, 2, 2, 2, 1, 1},
        Name = "Индустриальная-Автостанция Южная",
        Loop = false,
        BlockDoors = true,
		
		Line = 3,--Номер отображаемой линии
		Color = Color( 58, 150, 250),	
		English = false,--есть ли английский информ				
        {
            108,
            "Автозаводская",nil,true,"Автозаводская",1,nil, Color( 82, 172,  98),
        },
        {
            109,
            "Индустриальная",nil,true,"Индустриальная",1,nil, Color( 82, 172,  98),
        },
        {
            110,
            "Московская",nil,true,"Московская",1,nil, Color( 82, 172,  98),
            right_doors=true,
        },
        {
            111,
            "Октябрьская",nil,true,"Октябрьская",1,nil, Color( 82, 172,  98),
        },
        {
            112,
            "Площадь мира",nil,true,"Площадь мира",1,nil, Color( 82, 172,  98),
        },
        {
            113,
            "Новоармейская",nil,true,"Новоармейская",1,nil, Color( 82, 172,  98),
        },
        {
            115,
            "Комсомольская",nil,true,"Комсомольская",1,nil, Color( 82, 172,  98),"Ленинская",2,nil,Color(255,0,0),
            right_doors=true,
        },
        {
            116,
            "Электросила",nil,true,"Электросила",1,nil, Color( 82, 172,  98),
        },
        {
            117,
            "Театральная площадь",nil,true,"Театральная площадь",1,nil, Color( 82, 172,  98),
        },
        {
            118,
            "Парк победы",nil,true,"Парк победы",1,nil, Color( 82, 172,  98),
            right_doors=true,
        },
        {
            119,
            "Синеозёрная",nil,true,"Синеозёрная",1,nil, Color( 82, 172,  98),
        },
        {
            121,
            "Минская",nil,true,"Минская",1,nil, Color( 82, 172,  98),

        },
        {
            122,
            "Царские ворота",nil,true,"Царские ворота",1,nil, Color( 82, 172,  98),

        },
        {
            321,
            "Музей скульптур",

        },
        {
            322,
            "Автостанция южная",
        },
    },
})