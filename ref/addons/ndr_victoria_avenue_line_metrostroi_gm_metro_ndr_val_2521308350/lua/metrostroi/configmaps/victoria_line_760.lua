local Map = game.GetMap() or ""
if !Map:find("gm_metro_ndr_val") then return end

  Metrostroi.AddPassSchemeTex("760","VAL",{
      "metrostroi_skins/81-760_schemes/val",
  })

  Metrostroi.AddCISConfig("VAL",{
   {
    LED = {3, 4, 3, 3, 4, 3, 3, 4, 3},
    Name = "VAL",
    Loop = false,
  	Line = 2,
  	Color = Color(123, 0, 0),
  	English = false,
    {
      200,
      "Garden Circus",
    },
    {
      201,
      "Victoria - Burrow",2,true,
    },
    {
      202,
      "Victoria Avenue",nil,true,"UR Metro M3",3,nil,Color(255,183,2),
    },
    {
      203,
      "North-Gate Bridge",
    },
    {
      204,
      "Victoria Promenade",
    },
    {
      205,
      "Central Street",nil,true,"Downtown & N.-Downtown Line",1,nil,Color(0,148,255),"UR Metro M3",3,nil,Color(255,183,2),
    },
    {
      206,
      "Lakefield Street",nil,true,"UR Metro M1",1,nil,Color(255,183,2),
    },
    {
      207,
      "Fisherman's Hut",
    },
    {
      208,
      "South-Port Junction",nil,true,"Port-Town Line",2,nil,Color(0,173,20),
    },
   }
  })