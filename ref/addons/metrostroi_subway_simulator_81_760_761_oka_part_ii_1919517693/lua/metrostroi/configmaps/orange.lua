local Map = game.GetMap():lower() or ""

if Map:find("gm_mus") and Map:find("neoorange") then

else
    return
end

Metrostroi.AddPassSchemeTex("760","Neoorange",{
    "metrostroi_skins/81-760_schemes/neoorange",
})
Metrostroi.AddCISConfig("ASNP MakichOS", {
    {
        LED = {2, 1, 2, 3, 3, 3, 3, 3, 3, 3, 4},
        Name = "Линия 1",
        Loop = false,

		Line = 4,--Номер отображаемой линии
		Color = Color(255,109,63),	
		English = false,--есть ли английский информ		
        {
            462,
            "Икарус",
        },
        {
            461,
            "СМРК",
        },
        {
            460,
            "Флора",
        },
        {
            458,
            "Аэропорт",
        },
        {
            457,
            "Славная страна",nil,true,"Славная страна",6,nil,Color(0, 113, 188),	
        },
        {
            456,
            "Литиевая",nil,true,"Литиевая",5,nil,Color(255,81,158),
        },
        {
            455,
            "Арсенал",
        },
        {
            454,
            "Парк",nil,true,"Парк",6,nil,Color(0, 113, 188),	
        },
        {
            453,
            "GCFScape",
        },
        {
            452,
            "VHE",
        },
        {
            451,
            "Уоллеса Брина",
        }
    }
})

Metrostroi.AddCISConfig("ASNP MakichOS + Concord En", {
    {
        LED = {2, 1, 2, 3, 3, 3, 3, 3, 3, 3, 4},
        Name = "Линия 1",
        Loop = false,
		
		Line = 4,--Номер отображаемой линии
		Color = Color(255,109,63),	
		English = true,--есть ли английский информ
        {
            462,
            "Икарус","Ikarus",
        },
        {
            461,
            "СМРК","SMRC",
        },
        {
            460,
            "Флора","Flora",
        },
        {
            458,
            "Аэропорт","Airport",
        },
        {
            457,
            "Славная страна","Glorious country",true,"Славная страна",6,"Glorious country",Color(0, 113, 188),	
        },
        {
            456,
            "Литиевая","Lithium",true,"Литиевая",5,"Lithium",Color(255,81,158),
        },
        {
            455,
            "Арсенал","Arsenal",
        },
        {
            454,
            "Парк","Park",true,"Парк",6,"Park",Color(0, 113, 188),	
        },
        {
            453,
            "GCFScape","GCFScape",
        },
        {
            452,
            "VHE","VHE",
        },
        {
            451,
            "Уоллеса Брина","Wallace Breen",
        }
    }
})