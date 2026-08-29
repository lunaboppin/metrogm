local Map = game.GetMap():lower() or ""
if Map:find("gm_metro_crossline_m") then

else
    return
end
Metrostroi.AddPassSchemeTex("760","Crossline",{
    "metrostroi_skins/81-760_schemes/crossline_m12",
})

--!!!Название информа должно совпадать с названием конфига!!!
Metrostroi.AddCISConfig("ASNP Boiko + Pyaseckaya",{
    { --МАРШРУТ
        LED = {5,4,4,4,5,4,4},
        Name = "Линия 1",
        Loop = false,
        BlockDoors = true,
		
		Line = 1,--Номер отображаемой линии
		Color = Color(161,  64,  71),	
		English = false,--есть ли английский информ		
        {
		--   ID  полное название  англ название   переход(false или true)    название станции перехода    линия перехода   станция перехода на английском       цвет линии перехода - Color(r,g,b),		
            909,"Международная",
        },
        {
            910,"Парк Культуры",
        },
        {
            911,"Политехническая",
        },
        {
            912,"Проспект Суворова",
        },
        {
            913,"Нахимовская",
        },
        {
            914,"Октябрьская",
        },
        {
            915,"Речная",
            right_doors = true,
        },
    },
})
