local Map = game.GetMap():lower() or ""
if Map:find("gm_metro_crossline_c") then
    --Metrostroi.PlatformMap = "gm_metro_crossline"
    --Metrostroi.CurrentMap = "gm_metro_crossline"
else
    return
end
Metrostroi.AddPassSchemeTex("760","Crossline",{
    "metrostroi_skins/81-760_schemes/crossline_c4",
    --"metrostroi_skins/81-760_schemes/crossline_c4_r",
})

Metrostroi.AddCISConfig("ASNP Boiko + Pyaseckaya",{
    { --МАРШРУТ
        LED = {5,4,4,4,4,4,2,3},
        Name = "Линия 1",
        Loop = false,
        BlockDoors = true,
		
		Line = 1,--Номер отображаемой линии
		Color = Color(161,  64,  71),	
		English = false,--есть ли английский информ
        {
		--    1       2              3                     4                          5                           6                       7                                     8
		--   ID  полное название  англ название   переход(false или true)    название станции перехода    линия перехода   станция перехода на английском       цвет линии перехода - Color(r,g,b),
            110,"Международная",   nil,             false,                         nil,                     nil,                      nil,                             nil, 
        },
        {
            111,"Парк Культуры",
        },
        {
            112,"Политехническая",
        },
        {
            113,"Проспект Суворова",
        },
        {
            114,"Нахимовская",
        },
        {
            115,"Октябрьская",
        },
        {
            116,"Речная",
            right_doors = true,
        },
        {
            117,"Пролетарская",
        },
    },
})