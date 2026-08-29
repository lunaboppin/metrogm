local Map = game.GetMap() or ""

if Map:find("gm_mustox_neocrimson") then

else
	return
end

Metrostroi.AddPassSchemeTex("760","Crimson",{
	"metrostroi_skins/81-760_schemes/neocrimson",
})

Metrostroi.AddCISConfig("ASNP Boiko + Pyaseckaya", {
    {
        LED = {4, 4, 4, 4, 4, 4, 4},
        Name = "Братеево - Сталинская",
        Loop = false,
		BlockDoors = true,
		
		Line = 5,--Номер отображаемой линии
		Color = Color(255,81,158),	
		English = false,--есть ли английский информ				
        {
            551,
            "Братеево",
        },
		{
            552,
            "Пионерская",nil,true,"Пионерская",6,nil,Color(0, 113, 188),
			right_doors=true,
        },
        {
            553,
            "Литиевая",nil,true,"Литиевая",4,nil,Color(255,109,63),
        },
        {
            554,
            "Метростроителей",nil,true,"Метростроителей",6,nil,Color(0, 113, 188),	
        },
        {
            555,
            "Славутич",
			right_doors=true,
        },
        {
            556,
            "Фауна",
        },
		{
            557,
            "Сталинская",
        }
    }
})