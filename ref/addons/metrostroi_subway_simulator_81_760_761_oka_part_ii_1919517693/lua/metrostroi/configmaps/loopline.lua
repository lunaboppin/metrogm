local Map = game.GetMap():lower() or ""

if Map:find("gm_mus_loop") then

else
    return
end

Metrostroi.AddPassSchemeTex("760","Loopline",{
    "metrostroi_skins/81-760_schemes/loopline",
})

Metrostroi.AddCISConfig("ASNP MakichOS", {
    {
        LED = {5,5,5,5,5,5},
        Name = "Линия 1",
        Loop = true,

		Line = 6,--Номер отображаемой линии
		Color = Color(0, 113, 188),	
		English = false,--есть ли английский информ		
        {
            651,"Первоапрельская",
        },
        {
		--    1        2               3                   4                             5                      6                   7                                      8
		--   ID  полное название  англ название   переход(false или true)    название станции перехода    линия перехода   станция перехода на английском       цвет линии перехода - Color(r,g,b),				
            652,"Парк",nil,true,"Парк",4,nil,Color(255,109,63),
        },
        {
            653,"Метростроителей",nil,true,"Метростроителей",5,nil,Color(255,  81, 158)
        },
        {
            654,"Морская",
        },
        {
            655,"Славная страна",nil,true,"Славная страна",4,nil,Color(255,109,63),
        },
        {
            656,"Пионерская",nil,true,"Пионерская",5,nil,Color(255,  81, 158),
        },
    },
})
Metrostroi.AddCISConfig("ASNP MakichOS + Concord En",{
    {
        LED = {5,5,5,5,5,5},
        Name = "Линия 1",
        Loop = true,

		Line = 6,--Номер отображаемой линии
		Color = Color(0, 113, 188),	
		English = true,--есть ли английский информ		
        {
            651,"Первоапрельская","First April",
        },
        {
            652,"Парк","Park",true,"Парк",4,"Park",Color(255,109,63),
        },
        {
            653,"Метростроителей","Metrobuilders",true,"Метростроителей",5,"Metrobuilders",Color(255,  81, 158),
        },
        {
            654,"Морская",
        },
        {
            655,"Славная страна","Glorious country",true,"Славная страна",4,"Glorious country",Color(255,109,63),
        },
        {
            656,"Пионерская","Pioneer",true,"Пионерская",5,"Pioneer",Color(255,  81, 158),
        },
    },
})
