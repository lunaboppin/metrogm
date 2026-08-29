--James May TTS announcer was made possible by vocodes.com
local Map = game.GetMap() or ""

if Map:find("metro_ndr") then
    Metrostroi.PlatformMap = "victoria"
    Metrostroi.CurrentMap = "gm_metro_ndr_val"
else
    return
end

hook.Add( "Initialize", "RonBerlinLibInitCheck", function()
  RonBerlinLib.SignalEnable = true --Enables Berlin signalling system.
  RonBerlinLib.SignalHelp = {}
  RonBerlinLib.SignalHelp[1] = {
                                  true,
                                  "ndrhelp",
                                  "https://drive.google.com/drive/folders/1GOnsNmKFyhK7hVr8_6jcvTHtKJw3UpNa?usp=sharing",
                                  480
                                }
  RonBerlinLib.SignalHelp[2] = {
                                  "Need help with the Dispatching Panel and Signalling system ?",
								  "Just type !"..RonBerlinLib.SignalHelp[1][2].." to open the ressource folder !",
                                }
  --Enables a message in the chat in a set time interval. Its configured in this order:
  --Enabled / Disabled (true / false), command (what to type into the chat to open the link to the manual, ! prefix will get added on its own), link to the manual, time interval in seconds
  --Insert all the text that should get printed each time the command is exectuted, use this to add your own langeuage!
  --Yes i know it might look weird at first glance but i dont know of any other way to automatically add the prefix into the messages without it written like this!
  RonBerlinLib.ReplaceDestSigns = true --Enables to replace the russian dest signs with german / custom ones.
  RonBerlinLib.DaisyText[1] = {0, "Do not board", "/", "Special Service"} --{0, "Nicht einsteigen", "", "Sonderfahrt"}
  --Text the Daisy displays if a Trains announcer isnt set! Its returned in this order: Last Station Index, Destination Text, Line Text, Special Destination
  --If train has an unsupported announcer it displays only the Special Destination and returns these values! Translation of the default string: "Special Service"
  RonBerlinLib.DaisyText[2] = {"   Out of Service", ""}
  --Text the Diasy displays if there is no Train in its departing list.

  /*RonBerlinLib.AddSignalEntity({{ ["class"] = "gmod_berlin_signal_dummy",
                                  ["lights"] = "[ABC]",
                                  ["lighttooltip"] = "yauza is mega gay lol",
                                  ["showdepart"] = false,
                                  ["showroute"] = true}}) //Adds a custom signal entity. It'll be saved and loaded with the berlin_save, berlin_load commands.*/
  RonBerlinLib.NewDestSigns = {[-4]="NDR",[-3]="Out of Service",[-2]="Depot",[-1]="Special",[0]=""}
  RonBerlinLib.AddSignMaterial({{["name"] = "Name", ["material"] =  "ron/gm_berlin/tools/daisy_marker"}})
  RonBerlinLib.AddSignMaterial({{["name"] = "Name2", ["material"] =  "ron/gm_berlin/station/default/clock"}})
  RonBerlinLib.InitSignalSystem() --Initializes Signal System, if SignalEnable is turned off this function will quit itself internally!
  	if SERVER then
	local ENT = scripted_ents.GetStored("gmod_track_platform").t
		if ENT.TriTone then
			ENT.TriTone = ""
		end
	end
end )
//To be put into Map lua!//

Metrostroi.AddLastStationTex("702",197,"metrostroi_dest_signs/destination_table_black/label_outndr_d")
Metrostroi.AddLastStationTex("710",197,"metrostroi_dest_signs/destination_table_white/label_outndr_e")
Metrostroi.AddLastStationTex("717",197,"metrostroi_dest_signs/destination_table_white/label_outndr_717")
Metrostroi.AddLastStationTex("720",197,"metrostroi_dest_signs/destination_table_white/label_outndr")

Metrostroi.AddLastStationTex("702",198,"metrostroi_dest_signs/destination_table_black/label_depndr_d")
Metrostroi.AddLastStationTex("710",198,"metrostroi_dest_signs/destination_table_white/label_depndr_e")
Metrostroi.AddLastStationTex("717",198,"metrostroi_dest_signs/destination_table_white/label_depndr_717")
Metrostroi.AddLastStationTex("720",198,"metrostroi_dest_signs/destination_table_white/label_depndr")

Metrostroi.AddLastStationTex("702",199,"metrostroi_dest_signs/destination_table_black/label_spendr_d")
Metrostroi.AddLastStationTex("710",199,"metrostroi_dest_signs/destination_table_white/label_spendr_e")
Metrostroi.AddLastStationTex("717",199,"metrostroi_dest_signs/destination_table_white/label_spendr_717")
Metrostroi.AddLastStationTex("720",199,"metrostroi_dest_signs/destination_table_white/label_spendr")

Metrostroi.AddLastStationTex("702",200,"metrostroi_dest_signs/destination_table_black/label_garden_d")
Metrostroi.AddLastStationTex("710",200,"metrostroi_dest_signs/destination_table_white/label_garden_e")
Metrostroi.AddLastStationTex("717",200,"metrostroi_dest_signs/destination_table_white/label_garden_717")
Metrostroi.AddLastStationTex("720",200,"metrostroi_dest_signs/destination_table_white/label_garden")

Metrostroi.AddLastStationTex("702",203,"metrostroi_dest_signs/destination_table_black/label_gate_d")
Metrostroi.AddLastStationTex("710",203,"metrostroi_dest_signs/destination_table_white/label_gate_e")
Metrostroi.AddLastStationTex("717",203,"metrostroi_dest_signs/destination_table_white/label_gate_717")
Metrostroi.AddLastStationTex("720",203,"metrostroi_dest_signs/destination_table_white/label_gate")

Metrostroi.AddLastStationTex("702",204,"metrostroi_dest_signs/destination_table_black/label_promenade_d")
Metrostroi.AddLastStationTex("710",204,"metrostroi_dest_signs/destination_table_white/label_promenade_e")
Metrostroi.AddLastStationTex("717",204,"metrostroi_dest_signs/destination_table_white/label_promenade_717")
Metrostroi.AddLastStationTex("720",204,"metrostroi_dest_signs/destination_table_white/label_promenade")

Metrostroi.AddLastStationTex("702",205,"metrostroi_dest_signs/destination_table_black/label_central_d")
Metrostroi.AddLastStationTex("710",205,"metrostroi_dest_signs/destination_table_white/label_central_e")
Metrostroi.AddLastStationTex("717",205,"metrostroi_dest_signs/destination_table_white/label_central_717")
Metrostroi.AddLastStationTex("720",205,"metrostroi_dest_signs/destination_table_white/label_central")

Metrostroi.AddLastStationTex("702",208,"metrostroi_dest_signs/destination_table_black/label_port_d")
Metrostroi.AddLastStationTex("710",208,"metrostroi_dest_signs/destination_table_white/label_port_e")
Metrostroi.AddLastStationTex("717",208,"metrostroi_dest_signs/destination_table_white/label_port_717")
Metrostroi.AddLastStationTex("720",208,"metrostroi_dest_signs/destination_table_white/label_port")

timer.Simple(0, function()
  for k, tbl in pairs(Metrostroi.Skins) do
    if k:find("_routes") then
      local toRemove = {}

      for destID in pairs(tbl) do --Find default signs in array with id>=1000
        if (type(destID) ~= "number" or destID < 1000) and destID ~= "obkatka" then continue end
        if type(destID) == "number" and destID >= 197 and destID <= 208 then continue end
        table.insert(toRemove, destID)
      end

      table.sort (toRemove,function(a,b) return tbl[a] > tbl[b] end) --We need sorted table for right removing
      local removed = 0
      for _, destID in pairs(toRemove) do --Removing all default sings
        table.remove(tbl, tbl[destID])
        tbl[destID] = nil
        removed = removed + 1
      end
      for stID, destID in pairs(tbl) do --Normalising destIDs
        if type(destID) == "number" then tbl[stID] = destID-removed end
      end
    end
  end

  --Replace Default Dest Sign because it russian bylat Xd

  Metrostroi.Skins["702_routes"][0] = "metrostroi_dest_signs/destination_table_black/label_empty_d"
  Metrostroi.Skins["710_routes"][0] = "metrostroi_dest_signs/destination_table_white/label_empty"
  Metrostroi.Skins["717_routes"][0] = "metrostroi_dest_signs/destination_table_white/label_empty"
  Metrostroi.Skins["720_routes"][0] = "metrostroi_dest_signs/destination_table_white/label_empty"

  --topkek hax

  Metrostroi.Skins["702_routes"][-1] = Metrostroi.Skins["702_routes"][0]
  Metrostroi.Skins["710_routes"][-1] = Metrostroi.Skins["710_routes"][0]
  Metrostroi.Skins["717_routes"][-1] = Metrostroi.Skins["717_routes"][0]
  Metrostroi.Skins["720_routes"][-1] = Metrostroi.Skins["720_routes"][0]
end)

Metrostroi.Skins["720_schemes"] = {
    {
        name = "NDR Victoria Avenue Line",
        "metrostroi_skins/81-720_schemes/victoria",
        "metrostroi_skins/81-720_schemes/victoriar",
    }
}
Metrostroi.Skins["722_schemes"] = {
    {
        name = "NDR Victoria Avenue Line",
        "metrostroi_skins/81-722_schemes/victoria",
        "metrostroi_skins/81-722_schemes/victoriar",
    }
}
Metrostroi.AddPassSchemeTex("717_new","victoria",{
	name = "NDR Victoria Avenue Line",	
    "metrostroi_skins/victoria",
})
Metrostroi.TickerAdverts = {
    "Victoria Avenue Line   ",
    "Garden Circus - South-Port Junction   ",
    "You can change for UR metro line M3 at Victoria Avenue Station and Central Street Station.   ",
	"You can change for UR metro line M1 at Lakefield Street Station.   ",
    "You can change for NDR Downtown Line and Northern-Downtown Line at Central Street Station.   ",
    "You can change for NDR Port-Town Line at South-Port Junction.   ",
}

Metrostroi.AddANSPAnnouncer("ANSP [EN] null_space",{
	asnp = true,
        click1 = {"subway_announcers/asnp/click.mp3", 0.3},
        click2 = {"subway_announcers/asnp/click2.mp3", 0.1},
		click_start = {"subway_announcers/click3.mp3", 0.456},
		click_end = {"subway_announcers/click4.mp3", 0.360},
		
        garden = {"subway_announcers/ndr_cz/garden.wav", 1.4},
		vburrow = {"subway_announcers/ndr_cz/vburrow.wav", 1.4},
		vavenue = {"subway_announcers/ndr_cz/vavenue.wav", 1.4},
		ngate = {"subway_announcers/ndr_cz/ngate.wav", 1.6},
		vpromenade = {"subway_announcers/ndr_cz/vpromenade.wav", 1.6},
		central = {"subway_announcers/ndr_cz/central.wav", 1.2},
		lakefieldst = {"subway_announcers/ndr_cz/lakefieldst.wav", 1.2},
		fischer = {"subway_announcers/ndr_cz/fischer.wav", 1.2},
		port = {"subway_announcers/ndr_cz/port.wav", 1.6},

		chime = {"subway_announcers/ndr/chime.wav", 3},
		chime_rg = {"subway_announcers/ndr/chime_rg.wav", 2.6},
		cls = {"subway_announcers/ndr_cz/cls.wav", 2.5},
		nexts = {"subway_announcers/ndr_cz/next.wav", 2.1},
		this_is = {"subway_announcers/ndr_cz/this is.wav", 1},
		--eastbound = {"subway_announcers/ndr_cz/eastbound.wav", 2.1},
		--special_e = {"subway_announcers/ndr_cz/special_e.wav", 2.6},
		--westbound = {"subway_announcers/ndr_cz/westbound.wav", 2.3},
		--special_w = {"subway_announcers/ndr_cz/special_w.wav", 2.5},
		m1 =  {"subway_announcers/ndr_cz/m1.wav", 2.2},
		m3 =  {"subway_announcers/ndr_cz/m3.wav", 2},
		d = {"subway_announcers/ndr_cz/d.wav", 2},
		n = {"subway_announcers/ndr_cz/n.wav", 2.5},
		p = {"subway_announcers/ndr_cz/p.wav", 2},
		last = {"subway_announcers/ndr_cz/last.wav", 7},
		transfer = {"subway_announcers/ndr_cz/transfer.wav", 1.2},
		left_p = {"subway_announcers/ndr_cz/left_p.wav", 2.3},
		right_p = {"subway_announcers/ndr_cz/right_p.wav", 2.2},
		
		lmao = {"subway_announcers/ndr/lmao.mp3",22},
		announcer_ready = {"subway_announcers/ndr/announcer_ready_ndr.wav",2.3},
	},
	{
		{	
 LED = {4,3,3,3,3,4,3,3,4},
            Name = "VAL",
			Loop = false,
			BlockDoors = false,
			Daisy_Line = "V",
			spec_last = {"last"},
			spec_wait = {"lmao"},
            {
                200,"Garden Circus",
                arrlast = {nil,{"chime_rg","this_is","garden",1,"last",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","vburrow",1,"right_p",1},nil},
            },
            {
                201,"Victoria - Burrow",
                arr = {{"chime_rg","this_is","vburrow",1},{"chime_rg","this_is","vburrow",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","vavenue",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","garden",1,"left_p",1}},
            },
            {
                202,"Victoria Ave.",
                arr = {{"chime_rg","this_is","vavenue",1,"transfer","m3",1},{"chime_rg","this_is","vavenue",1,"transfer","m3",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","ngate",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","vburrow",1,"right_p",1}},
				have_inrerchange = true
            },
            {
                203,"North-Gate Bdg.",
				arr = {{"chime_rg","this_is","ngate",1},{"chime_rg","this_is","ngate",1}},
                arrlast = {{"chime_rg","this_is","ngate",1,"last",1},nil},
                dep = {{"cls",0.5,"chime",1,"nexts","vpromenade",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","vavenue",1,"right_p",1}},
            },
            {
                204,"Victoria Prom.",
				arr = {{"chime_rg","this_is","vpromenade",1},{"chime_rg","this_is","vpromenade",1}},
                arrlast = {nil,{"chime_rg","this_is","vpromenade",1,"last",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","central",1,"left_p",1},{"cls",0.5,"chime",1,"nexts","ngate",1,"right_p",1}},
            },
            {
                205,"Central St.",
				arr = {{"chime_rg","this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1},{"chime_rg","this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1}},
                arrlast = {{"chime_rg","this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1,"last",1},nil},
                dep = {{"cls",0.5,"chime",1,"nexts","lakefieldst",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","vpromenade",1,"right_p",1}},
				have_inrerchange = true
            },
            {
                206,"Lakefield St.",
                arr = {{"chime_rg","this_is","lakefieldst",1,"transfer","m1",},{"chime_rg","this_is","lakefieldst",1,"transfer","m1",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","fischer",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","central",1,"left_p",1}},
				have_inrerchange = true
            },
            {
                207,"Fisherman's Hut",
                arr = {{"chime_rg","this_is","fischer",1},{"chime_rg","this_is","fischer",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","port",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","lakefieldst",1,"right_p",1}},
            },
            {
                208,"South-Port Jct.",
                arrlast = {{"chime_rg","this_is","port","transfer","p",1,"last",1},nil},
                dep = {nil,{"cls",0.5,"chime",1,"nexts","fischer",1,"right_p",1}},
				have_inrerchange = true
            },
		}
	}
)
Metrostroi.AddANSPAnnouncer("RIU [EN] null_space",{
	riu = true,
		click1 = {"subway_announcers/riu/boiko_new/click1.mp3",0.5},
		click2 = {"subway_announcers/riu/boiko_new/click2.mp3",0.3},
		click3 = {"subway_announcers/riu/boiko_new/click3.mp3",0.3},
		click_start = {"subway_announcers/riu/boiko_new/click1.mp3",0.5},
		click_end = {"subway_announcers/riu/boiko_new/click3.mp3",0.3},
		
        garden = {"subway_announcers/ndr_cz/garden.wav", 1.4},
		vburrow = {"subway_announcers/ndr_cz/vburrow.wav", 1.4},
		vavenue = {"subway_announcers/ndr_cz/vavenue.wav", 1.4},
		ngate = {"subway_announcers/ndr_cz/ngate.wav", 1.6},
		vpromenade = {"subway_announcers/ndr_cz/vpromenade.wav", 1.6},
		central = {"subway_announcers/ndr_cz/central.wav", 1.2},
		lakefieldst = {"subway_announcers/ndr_cz/lakefieldst.wav", 1.2},
		fischer = {"subway_announcers/ndr_cz/fischer.wav", 1.2},
		port = {"subway_announcers/ndr_cz/port.wav", 1.6},

		chime = {"subway_announcers/ndr/chime.wav", 3},
		chime_rg = {"subway_announcers/ndr/chime_rg.wav", 2.6},
		cls = {"subway_announcers/ndr_cz/cls.wav", 2.5},
		nexts = {"subway_announcers/ndr_cz/next.wav", 2.1},
		this_is = {"subway_announcers/ndr_cz/this is.wav", 1},
		--eastbound = {"subway_announcers/ndr_cz/eastbound.wav", 2.1},
		--special_e = {"subway_announcers/ndr_cz/special_e.wav", 2.6},
		--westbound = {"subway_announcers/ndr_cz/westbound.wav", 2.3},
		--special_w = {"subway_announcers/ndr_cz/special_w.wav", 2.5},
		m1 =  {"subway_announcers/ndr_cz/m1.wav", 2.2},
		m3 =  {"subway_announcers/ndr_cz/m3.wav", 2},
		d = {"subway_announcers/ndr_cz/d.wav", 2},
		n = {"subway_announcers/ndr_cz/n.wav", 2.5},
		p = {"subway_announcers/ndr_cz/p.wav", 2},
		last = {"subway_announcers/ndr_cz/last.wav", 7},
		transfer = {"subway_announcers/ndr_cz/transfer.wav", 1.2},
		left_p = {"subway_announcers/ndr_cz/left_p.wav", 2.3},
		right_p = {"subway_announcers/ndr_cz/right_p.wav", 2.2},
		
		lmao = {"subway_announcers/ndr/lmao.mp3",22},
		announcer_ready = {"subway_announcers/ndr/announcer_ready_ndr.wav",2.3},
	},
	{
		{	
 LED = {4,3,3,3,3,4,3,3,4},
            Name = "VAL",
			Loop = false,
			BlockDoors = false,
			Daisy_Line = "V",
			spec_last = {"last"},
			spec_wait = {"lmao"},
            {
                200,"Garden Circus",
                arrlast = {nil,{"chime_rg","this_is","garden",1,"last",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","vburrow",1,"right_p",1},nil},
            },
            {
                201,"Victoria - Burrow",
                arr = {{"chime_rg","this_is","vburrow",1},{"chime_rg","this_is","vburrow",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","vavenue",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","garden",1,"left_p",1}},
            },
            {
                202,"Victoria Ave.",
                arr = {{"chime_rg","this_is","vavenue",1,"transfer","m3",1},{"chime_rg","this_is","vavenue",1,"transfer","m3",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","ngate",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","vburrow",1,"right_p",1}},
				have_inrerchange = true
            },
            {
                203,"North-Gate Bdg.",
				arr = {{"chime_rg","this_is","ngate",1},{"chime_rg","this_is","ngate",1}},
                arrlast = {{"chime_rg","this_is","ngate",1,"last",1},nil},
                dep = {{"cls",0.5,"chime",1,"nexts","vpromenade",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","vavenue",1,"right_p",1}},
            },
            {
                204,"Victoria Prom.",
				arr = {{"chime_rg","this_is","vpromenade",1},{"chime_rg","this_is","vpromenade",1}},
                arrlast = {nil,{"chime_rg","this_is","vpromenade",1,"last",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","central",1,"left_p",1},{"cls",0.5,"chime",1,"nexts","ngate",1,"right_p",1}},
            },
            {
                205,"Central St.",
				arr = {{"chime_rg","this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1},{"chime_rg","this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1}},
                arrlast = {{"chime_rg","this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1,"last",1},nil},
                dep = {{"cls",0.5,"chime",1,"nexts","lakefieldst",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","vpromenade",1,"right_p",1}},
				have_inrerchange = true
            },
            {
                206,"Lakefield St.",
                arr = {{"chime_rg","this_is","lakefieldst",1,"transfer","m1",},{"chime_rg","this_is","lakefieldst",1,"transfer","m1",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","fischer",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","central",1,"left_p",1}},
				have_inrerchange = true
            },
            {
                207,"Fisherman's Hut",
                arr = {{"chime_rg","this_is","fischer",1},{"chime_rg","this_is","fischer",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","port",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","lakefieldst",1,"right_p",1}},
            },
            {
                208,"South-Port Jct.",
                arrlast = {{"chime_rg","this_is","port","transfer","p",1,"last",1},nil},
                dep = {nil,{"cls",0.5,"chime",1,"nexts","fischer",1,"right_p",1}},
				have_inrerchange = true
            },
		}
	}
)
Metrostroi.AddANSPAnnouncer("ANSP [EN] James May (TTS)",{
	asnp = true,
        click1 = {"subway_announcers/asnp/click.mp3", 0.3},
        click2 = {"subway_announcers/asnp/click2.mp3", 0.1},
		click_start = {"subway_announcers/click3.mp3", 0.456},
		click_end = {"subway_announcers/click4.mp3", 0.360},
		
        garden = {"subway_announcers/ndr/garden.wav", 1.2},
		vburrow = {"subway_announcers/ndr/vburrow.wav", 1.5},
		vavenue = {"subway_announcers/ndr/vavenue.wav", 1.3},
		ngate = {"subway_announcers/ndr/ngate.wav", 1.2},
		vpromenade = {"subway_announcers/ndr/vpromenade.wav", 1.5},
		central = {"subway_announcers/ndr/central.wav", 1.1},
		lakefieldst = {"subway_announcers/ndr/lakefieldst.wav", 1.1},
		fischer = {"subway_announcers/ndr/fischer.wav", 1},
		port = {"subway_announcers/ndr/port.wav", 1.4},

		chime = {"subway_announcers/ndr/chime.wav", 3},
		chime_rg = {"subway_announcers/ndr/chime_rg.wav", 2.6},
		cls = {"subway_announcers/ndr/cls.wav", 2.5},
		nexts = {"subway_announcers/ndr/next.wav", 1.4},
		this_is = {"subway_announcers/ndr/this is.wav", 0.8},
		--eastbound = {"subway_announcers/ndr/eastbound.wav", 1.7},
		--special_e = {"subway_announcers/ndr/special_e.wav", 2},
		--westbound = {"subway_announcers/ndr/westbound.wav", 1.8},
		--special_w = {"subway_announcers/ndr/special_w.wav", 2.1},
		m1 =  {"subway_announcers/ndr/m1.wav", 2.2},
		m3 =  {"subway_announcers/ndr/m3.wav", 2.3},
		d = {"subway_announcers/ndr/d.wav", 2},
		n = {"subway_announcers/ndr/n.wav", 2.9},
		p = {"subway_announcers/ndr/p.wav", 1.7},
		last = {"subway_announcers/ndr/last.wav", 6.5},
		transfer = {"subway_announcers/ndr/transfer.wav", 1.3},
		left_p = {"subway_announcers/ndr/left_p.wav", 2.1},
		right_p = {"subway_announcers/ndr/right_p.wav", 1.8},
		
		lmao = {"subway_announcers/ndr/lmao.mp3",22},
		announcer_ready = {"subway_announcers/ndr/announcer_ready_ndr.wav",2.3},
	},
	{
		{	
 LED = {4,3,3,3,3,4,3,3,4},
            Name = "VAL",
			Loop = false,
			BlockDoors = false,
			Daisy_Line = "V",
			spec_last = {"last"},
			spec_wait = {"lmao"},
            {
                200,"Garden Circus",
                arrlast = {nil,{"chime_rg","this_is","garden",1,"last",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","vburrow",1,"right_p",1},nil},
            },
            {
                201,"Victoria - Burrow",
                arr = {{"chime_rg","this_is","vburrow",1},{"chime_rg","this_is","vburrow",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","vavenue",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","garden",1,"left_p",1}},
            },
            {
                202,"Victoria Ave.",
                arr = {{"chime_rg","this_is","vavenue",1,"transfer","m3",1},{"chime_rg","this_is","vavenue",1,"transfer","m3",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","ngate",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","vburrow",1,"right_p",1}},
				have_inrerchange = true
            },
            {
                203,"North-Gate Bdg.",
				arr = {{"chime_rg","this_is","ngate",1},{"chime_rg","this_is","ngate",1}},
                arrlast = {{"chime_rg","this_is","ngate",1,"last",1},nil},
                dep = {{"cls",0.5,"chime",1,"nexts","vpromenade",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","vavenue",1,"right_p",1}},
            },
            {
                204,"Victoria Prom.",
				arr = {{"chime_rg","this_is","vpromenade",1},{"chime_rg","this_is","vpromenade",1}},
                arrlast = {nil,{"chime_rg","this_is","vpromenade",1,"last",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","central",1,"left_p",1},{"cls",0.5,"chime",1,"nexts","ngate",1,"right_p",1}},
            },
            {
                205,"Central St.",
				arr = {{"chime_rg","this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1},{"chime_rg","this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1}},
                arrlast = {{"chime_rg","this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1,"last",1},nil},
                dep = {{"cls",0.5,"chime",1,"nexts","lakefieldst",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","vpromenade",1,"right_p",1}},
				have_inrerchange = true
            },
            {
                206,"Lakefield St.",
                arr = {{"chime_rg","this_is","lakefieldst",1,"transfer","m1",},{"chime_rg","this_is","lakefieldst",1,"transfer","m1",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","fischer",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","central",1,"left_p",1}},
				have_inrerchange = true
            },
            {
                207,"Fisherman's Hut",
                arr = {{"chime_rg","this_is","fischer",1},{"chime_rg","this_is","fischer",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","port",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","lakefieldst",1,"right_p",1}},
            },
            {
                208,"South-Port Jct.",
                arrlast = {{"chime_rg","this_is","port","transfer","p",1,"last",1},nil},
                dep = {nil,{"cls",0.5,"chime",1,"nexts","fischer",1,"right_p",1}},
				have_inrerchange = true
            },
		}
	}
)
Metrostroi.AddANSPAnnouncer("RIU [EN] James May (TTS)",{
	riu = true,
		click1 = {"subway_announcers/riu/boiko_new/click1.mp3",0.5},
		click2 = {"subway_announcers/riu/boiko_new/click2.mp3",0.3},
		click3 = {"subway_announcers/riu/boiko_new/click3.mp3",0.3},
		click_start = {"subway_announcers/riu/boiko_new/click1.mp3",0.5},
		click_end = {"subway_announcers/riu/boiko_new/click3.mp3",0.3},
		
        garden = {"subway_announcers/ndr/garden.wav", 1.2},
		vburrow = {"subway_announcers/ndr/vburrow.wav", 1.5},
		vavenue = {"subway_announcers/ndr/vavenue.wav", 1.3},
		ngate = {"subway_announcers/ndr/ngate.wav", 1.2},
		vpromenade = {"subway_announcers/ndr/vpromenade.wav", 1.5},
		central = {"subway_announcers/ndr/central.wav", 1.1},
		lakefieldst = {"subway_announcers/ndr/lakefieldst.wav", 1.1},
		fischer = {"subway_announcers/ndr/fischer.wav", 1},
		port = {"subway_announcers/ndr/port.wav", 1.4},

		chime = {"subway_announcers/ndr/chime.wav", 3},
		chime_rg = {"subway_announcers/ndr/chime_rg.wav", 2.6},
		cls = {"subway_announcers/ndr/cls.wav", 2.5},
		nexts = {"subway_announcers/ndr/next.wav", 1.4},
		this_is = {"subway_announcers/ndr/this is.wav", 0.8},
		--eastbound = {"subway_announcers/ndr/eastbound.wav", 1.7},
		--special_e = {"subway_announcers/ndr/special_e.wav", 2},
		--westbound = {"subway_announcers/ndr/westbound.wav", 1.8},
		--special_w = {"subway_announcers/ndr/special_w.wav", 2.1},
		m1 =  {"subway_announcers/ndr/m1.wav", 2.2},
		m3 =  {"subway_announcers/ndr/m3.wav", 2.3},
		d = {"subway_announcers/ndr/d.wav", 2},
		n = {"subway_announcers/ndr/n.wav", 2.9},
		p = {"subway_announcers/ndr/p.wav", 1.7},
		last = {"subway_announcers/ndr/last.wav", 6.5},
		transfer = {"subway_announcers/ndr/transfer.wav", 1.3},
		left_p = {"subway_announcers/ndr/left_p.wav", 2.1},
		right_p = {"subway_announcers/ndr/right_p.wav", 1.8},
		
		lmao = {"subway_announcers/ndr/lmao.mp3",22},
		announcer_ready = {"subway_announcers/ndr/announcer_ready_ndr.wav",2.3},
	},
	{
		{	
            Name = "VAL",
			Loop = false,
			BlockDoors = false,
			Daisy_Line = "V",
			spec_last = {"last"},
			spec_wait = {"lmao"},
            {
                200,"Garden Circus",
                arrlast = {nil,{"chime_rg","this_is","garden",1,"last",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","vburrow",1,"right_p",1},nil},
            },
            {
                201,"Victoria - Burrow",
                arr = {{"chime_rg","this_is","vburrow",1},{"chime_rg","this_is","vburrow",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","vavenue",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","garden",1,"left_p",1}},
            },
            {
                202,"Victoria Ave.",
                arr = {{"chime_rg","this_is","vavenue",1,"transfer","m3",1},{"chime_rg","this_is","vavenue",1,"transfer","m3",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","ngate",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","vburrow",1,"right_p",1}},
				have_inrerchange = true
            },
            {
                203,"North-Gate Bdg.",
				arr = {{"chime_rg","this_is","ngate",1},{"chime_rg","this_is","ngate",1}},
                arrlast = {{"chime_rg","this_is","ngate",1,"last",1},nil},
                dep = {{"cls",0.5,"chime",1,"nexts","vpromenade",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","vavenue",1,"right_p",1}},
            },
            {
                204,"Victoria Prom.",
				arr = {{"chime_rg","this_is","vpromenade",1},{"chime_rg","this_is","vpromenade",1}},
                arrlast = {nil,{"chime_rg","this_is","vpromenade",1,"last",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","central",1,"left_p",1},{"cls",0.5,"chime",1,"nexts","ngate",1,"right_p",1}},
            },
            {
                205,"Central St.",
				arr = {{"chime_rg","this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1},{"chime_rg","this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1}},
                arrlast = {{"chime_rg","this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1,"last",1},nil},
                dep = {{"cls",0.5,"chime",1,"nexts","lakefieldst",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","vpromenade",1,"right_p",1}},
				have_inrerchange = true
            },
            {
                206,"Lakefield St.",
                arr = {{"chime_rg","this_is","lakefieldst",1,"transfer","m1",},{"chime_rg","this_is","lakefieldst",1,"transfer","m1",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","fischer",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","central",1,"left_p",1}},
				have_inrerchange = true
            },
            {
                207,"Fisherman's Hut",
                arr = {{"chime_rg","this_is","fischer",1},{"chime_rg","this_is","fischer",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","port",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","lakefieldst",1,"right_p",1}},
            },
            {
                208,"South-Port Jct.",
                arrlast = {{"chime_rg","this_is","port","transfer","p",1,"last",1},nil},
                dep = {nil,{"cls",0.5,"chime",1,"nexts","fischer",1,"right_p",1}},
				have_inrerchange = true
            },
		}
	}
)
Metrostroi.SetRRIAnnouncer({
        click_end = {"subway_announcers/rri/boiko/spec/click_end.mp3",0.281451},
		click_start = {"subway_announcers/rri/boiko/spec/click_start.mp3",0.438118},
		
        garden = {"subway_announcers/ndr_cz/garden.wav", 1.4},
		vburrow = {"subway_announcers/ndr_cz/vburrow.wav", 1.4},
		vavenue = {"subway_announcers/ndr_cz/vavenue.wav", 1.4},
		ngate = {"subway_announcers/ndr_cz/ngate.wav", 1.6},
		vpromenade = {"subway_announcers/ndr_cz/vpromenade.wav", 1.6},
		central = {"subway_announcers/ndr_cz/central.wav", 1.2},
		lakefieldst = {"subway_announcers/ndr_cz/lakefieldst.wav", 1.2},
		fischer = {"subway_announcers/ndr_cz/fischer.wav", 1.2},
		port = {"subway_announcers/ndr_cz/port.wav", 1.6},
		garden_j = {"subway_announcers/ndr/garden.wav", 1.2},
		vburrow_j = {"subway_announcers/ndr/vburrow.wav", 1.5},
		vavenue_j = {"subway_announcers/ndr/vavenue.wav", 1.3},
		ngate_j = {"subway_announcers/ndr/ngate.wav", 1.2},
		vpromenade_j = {"subway_announcers/ndr/vpromenade.wav", 1.5},
		central_j = {"subway_announcers/ndr/central.wav", 1.1},
		lakefieldst_j = {"subway_announcers/ndr/lakefieldst.wav", 1.1},
		fischer_j = {"subway_announcers/ndr/fischer.wav", 1},
		port_j = {"subway_announcers/ndr/port.wav", 1.4},


			chime = {"subway_announcers/ndr/chime.wav", 3},
			chime_rg = {"subway_announcers/ndr/chime_rg.wav", 2.6},
		cls = {"subway_announcers/ndr_cz/cls.wav", 2.5},
		nexts = {"subway_announcers/ndr_cz/next.wav", 2.1},
		this_is = {"subway_announcers/ndr_cz/this is.wav", 1},
		--eastbound = {"subway_announcers/ndr_cz/eastbound.wav", 2.1},
		--special_e = {"subway_announcers/ndr_cz/special_e.wav", 2.6},
		--westbound = {"subway_announcers/ndr_cz/westbound.wav", 2.3},
		--special_w = {"subway_announcers/ndr_cz/special_w.wav", 2.5},
		m1 =  {"subway_announcers/ndr_cz/m1.wav", 2.2},
		m3 =  {"subway_announcers/ndr_cz/m3.wav", 2},
		d = {"subway_announcers/ndr_cz/d.wav", 2},
		n = {"subway_announcers/ndr_cz/n.wav", 2.5},
		p = {"subway_announcers/ndr_cz/p.wav", 2},
		last = {"subway_announcers/ndr_cz/last.wav", 7},
		transfer = {"subway_announcers/ndr_cz/transfer.wav", 1.2},
		left_p = {"subway_announcers/ndr_cz/left_p.wav", 2.3},
		right_p = {"subway_announcers/ndr_cz/right_p.wav", 2.2},
		cls_j = {"subway_announcers/ndr/cls.wav", 2.5},
		nexts_j = {"subway_announcers/ndr/next.wav", 1.4},
		this_is_j = {"subway_announcers/ndr/this is.wav", 0.8},
		--eastbound_j = {"subway_announcers/ndr/eastbound.wav", 1.7},
		--special_e_j = {"subway_announcers/ndr/special_e.wav", 2},
		--westbound_j = {"subway_announcers/ndr/westbound.wav", 1.8},
		--special_w_j = {"subway_announcers/ndr/special_w.wav", 2.1},
		m1_j =  {"subway_announcers/ndr/m1.wav", 2.2},
		m3_j =  {"subway_announcers/ndr/m3.wav", 2.3},
		d_j = {"subway_announcers/ndr/d.wav", 2},
		n_j = {"subway_announcers/ndr/n.wav", 2.9},
		p_j = {"subway_announcers/ndr/p.wav", 1.7},
		last_j = {"subway_announcers/ndr/last.wav", 6.5},
		transfer_j = {"subway_announcers/ndr/transfer.wav", 1.3},
		left_p_j = {"subway_announcers/ndr/left_p.wav", 2.1},
		right_p_j = {"subway_announcers/ndr/right_p.wav", 1.8},
		
		lmao = {"subway_announcers/ndr/lmao.mp3",22},
		announcer_ready = {"subway_announcers/ndr/announcer_ready_ndr.wav",2.3},
		
		},{
    {
		Name = "[EN] null_space",
		Daisy_Line = "V",
		spec_wait = {"lmao"},
            {
                200,"Garden Circus",
                arrlast = {nil,{"chime_rg","this_is","garden",1,"last",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","vburrow",1,"right_p",1},nil},
            },
            {
                201,"Victoria - Burrow",
                arr = {{"chime_rg","this_is","vburrow",1},{"chime_rg","this_is","vburrow",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","vavenue",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","garden",1,"left_p",1}},
            },
            {
                202,"Victoria Ave.",
                arr = {{"chime_rg","this_is","vavenue",1,"transfer","m3",1},{"chime_rg","this_is","vavenue",1,"transfer","m3",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","ngate",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","vburrow",1,"right_p",1}},
				have_inrerchange = true
            },
            {
                203,"North-Gate Bdg.",
				arr = {{"chime_rg","this_is","ngate",1},{"chime_rg","this_is","ngate",1}},
                arrlast = {{"chime_rg","this_is","ngate",1,"last",1},nil},
                dep = {{"cls",0.5,"chime",1,"nexts","vpromenade",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","vavenue",1,"right_p",1}},
            },
            {
                204,"Victoria Prom.",
				arr = {{"chime_rg","this_is","vpromenade",1},{"chime_rg","this_is","vpromenade",1}},
                arrlast = {nil,{"chime_rg","this_is","vpromenade",1,"last",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","central",1,"left_p",1},{"cls",0.5,"chime",1,"nexts","ngate",1,"right_p",1}},
            },
            {
                205,"Central St.",
				arr = {{"chime_rg","this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1},{"chime_rg","this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1}},
                arrlast = {{"chime_rg","this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1,"last",1},nil},
                dep = {{"cls",0.5,"chime",1,"nexts","lakefieldst",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","vpromenade",1,"right_p",1}},
				have_inrerchange = true
            },
            {
                206,"Lakefield St.",
                arr = {{"chime_rg","this_is","lakefieldst",1,"transfer","m1",},{"chime_rg","this_is","lakefieldst",1,"transfer","m1",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","fischer",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","central",1,"left_p",1}},
				have_inrerchange = true
            },
            {
                207,"Fisherman's Hut",
                arr = {{"chime_rg","this_is","fischer",1},{"chime_rg","this_is","fischer",1}},
                dep = {{"cls",0.5,"chime",1,"nexts","port",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","lakefieldst",1,"right_p",1}},
            },
            {
                208,"South-Port Jct.",
                arrlast = {{"chime_rg","this_is","port","transfer","p",1,"last",1},nil},
                dep = {nil,{"cls",0.5,"chime",1,"nexts","fischer",1,"right_p",1}},
				have_inrerchange = true
            },
        },
    {
		Name = "[EN] James May (TTS)",
		Daisy_Line = "V",
		spec_wait = {"lmao"},
            {
                200,"Garden Circus",
                arrlast = {nil,{"chime_rg","this_is_j","garden_j",1,"last_j",1}},
                dep = {{"cls_j",0.5,"chime",1,"nexts_j","vburrow_j",1,"right_p_j",1},nil},
            },
            {
                201,"Victoria - Burrow",
                arr = {{"chime_rg","this_is_j","vburrow_j",1},{"chime_rg","this_is_j","vburrow_j",1}},
                dep = {{"cls_j",0.5,"chime",1,"nexts_j","vavenue_j",1,"right_p_j",1},{"cls_j",0.5,"chime",1,"nexts_j","garden_j",1,"left_p_j",1}},
            },
            {
                202,"Victoria Ave.",
                arr = {{"chime_rg","this_is_j","vavenue_j",1,"transfer_j","m3_j",1},{"chime_rg","this_is_j","vavenue_j",1,"transfer_j","m3_j",1}},
                dep = {{"cls_j",0.5,"chime",1,"nexts_j","ngate_j",1,"right_p_j",1},{"cls_j",0.5,"chime",1,"nexts_j","vburrow_j",1,"right_p_j",1}},
				have_inrerchange = true
            },
            {
                203,"North-Gate Bdg.",
				arr = {{"chime_rg","this_is_j","ngate_j",1},{"chime_rg","this_is_j","ngate_j",1}},
                arrlast = {{"chime_rg","this_is_j","ngate_j",1,"last_j",1},nil},
                dep = {{"cls_j",0.5,"chime",1,"nexts_j","vpromenade_j",1,"right_p_j",1},{"cls_j",0.5,"chime",1,"nexts_j","vavenue_j",1,"right_p_j",1}},
            },
            {
                204,"Victoria Prom.",
				arr = {{"chime_rg","this_is_j","vpromenade_j",1},{"chime_rg","this_is_j","vpromenade_j",1}},
                arrlast = {nil,{"chime_rg","this_is_j","vpromenade_j",1,"last_j",1}},
                dep = {{"cls_j",0.5,"chime",1,"nexts_j","central_j",1,"left_p_j",1},{"cls_j",0.5,"chime",1,"nexts_j","ngate_j",1,"right_p_j",1}},
            },
            {
                205,"Central St.",
				arr = {{"chime_rg","this_is_j","central_j",1,"transfer_j","m3_j",0.5,"d_j",0.5,"n_j",1},{"chime_rg","this_is_j","central_j",1,"transfer_j","m3_j",0.5,"d_j",0.5,"n_j",1}},
                arrlast = {{"chime_rg","this_is_j","central_j",1,"transfer_j","m3_j",0.5,"d_j",0.5,"n_j",1,"last_j",1},nil},
                dep = {{"cls_j",0.5,"chime",1,"nexts_j","lakefieldst_j",1,"right_p_j",1},{"cls_j",0.5,"chime",1,"nexts_j","vpromenade_j",1,"right_p_j",1}},
				have_inrerchange = true
            },
            {
                206,"Lakefield St.",
                arr = {{"chime_rg","this_is_j","lakefieldst_j",1,"transfer_j","m1_j",},{"chime_rg_j","this_is_j","lakefieldst_j",1,"transfer_j","m1_j",1}},
                dep = {{"cls_j",0.5,"chime",1,"nexts_j","fischer_j",1,"right_p_j",1},{"cls_j",0.5,"chime",1,"nexts_j","central_j",1,"left_p_j",1}},
				have_inrerchange = true
            },
            {
                207,"Fisherman's Hut",
                arr = {{"chime_rg","this_is_j","fischer_j",1},{"chime_rg","this_is_j","fischer_j",1}},
                dep = {{"cls_j",0.5,"chime",1,"nexts_j","port_j",1,"right_p_j",1},{"cls_j",0.5,"chime",1,"nexts_j","lakefieldst_j",1,"right_p_j",1}},
            },
            {
                208,"South-Port Jct.",
                arrlast = {{"chime_rg","this_is_j","port_j","transfer_j","p_j",1,"last_j",1},nil},
                dep = {nil,{"cls_j",0.5,"chime",1,"nexts_j","fischer_j",1,"right_p_j",1}},
				have_inrerchange = true
            },
        },
})
-- Metrostroi.SetUPOAnnouncer({
    	-- name = "UPO [EN] null_space",
		-- tone = {"subway_announcers/chime_rg.wav", 3},
		-- click1 = {"subway_announcers/upo/click1.mp3", 0.3},
		-- click2 = {"subway_announcers/upo/click2.mp3", 0.1},
 
        -- garden = {"subway_announcers/ndr_cz/garden.wav", 1.4},
		-- vburrow = {"subway_announcers/ndr_cz/vburrow.wav", 1.4},
		-- vavenue = {"subway_announcers/ndr_cz/vavenue.wav", 1.4},
		-- ngate = {"subway_announcers/ndr_cz/ngate.wav", 1.6},
		-- vpromenade = {"subway_announcers/ndr_cz/vpromenade.wav", 1.6},
		-- central = {"subway_announcers/ndr_cz/central.wav", 1.2},
		-- lakefieldst = {"subway_announcers/ndr_cz/lakefieldst.wav", 1.2},
		-- fischer = {"subway_announcers/ndr_cz/fischer.wav", 1.2},
		-- port = {"subway_announcers/ndr_cz/port.wav", 1.6},

		-- chime = {"subway_announcers/ndr/chime.wav", 3},
		-- chime_rg = {"subway_announcers/ndr/chime_rg.wav", 2.6},
		-- cls = {"subway_announcers/ndr_cz/cls.wav", 2.5},
		-- nexts = {"subway_announcers/ndr_cz/next.wav", 2.1},
		-- this_is = {"subway_announcers/ndr_cz/this is.wav", 1},
		-- --eastbound = {"subway_announcers/ndr_cz/eastbound.wav", 2.1},
		-- --special_e = {"subway_announcers/ndr_cz/special_e.wav", 2.6},
		-- --westbound = {"subway_announcers/ndr_cz/westbound.wav", 2.3},
		-- --special_w = {"subway_announcers/ndr_cz/special_w.wav", 2.5},
		-- m1 =  {"subway_announcers/ndr_cz/m1.wav", 2.2},
		-- m3 =  {"subway_announcers/ndr_cz/m3.wav", 2},
		-- d = {"subway_announcers/ndr_cz/d.wav", 2},
		-- n = {"subway_announcers/ndr_cz/n.wav", 2.5},
		-- p = {"subway_announcers/ndr_cz/p.wav", 2},
		-- last = {"subway_announcers/ndr_cz/last.wav", 7},
		-- transfer = {"subway_announcers/ndr_cz/transfer.wav", 1.2},
		-- left_p = {"subway_announcers/ndr_cz/left_p.wav", 2.3},
		-- right_p = {"subway_announcers/ndr_cz/right_p.wav", 2.2},
		
		-- lmao = {"subway_announcers/ndr/lmao.mp3",22},
		-- announcer_ready = {"subway_announcers/ndr/announcer_ready_ndr.wav",2.3},
-- },{
             -- {
                -- 200,"Garden Circus",
                -- arrlast = {nil,{"this_is","garden",1,"last",1}},
                -- dep = {{"cls",0.5,"chime",1,"nexts","vburrow",1,"right_p",1},nil},
				-- noises = {2,1},noiserandom = 0.2,
            -- },
            -- {
                -- 201,"Victoria - Burrow",
                -- arr = {{"this_is","vburrow",1},{"this_is","vburrow",1}},
                -- dep = {{"cls",0.5,"chime",1,"nexts","vavenue",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","garden",1,"left_p",1}},
				-- noises = {2,1},noiserandom = 0.2,
            -- },
            -- {
                -- 202,"Victoria Avenue",
                -- arr = {{"this_is","vavenue",1,"transfer","m3",1},{"this_is","vavenue",1,"transfer","m3",1}},
                -- dep = {{"cls",0.5,"chime",1,"nexts","ngate",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","vburrow",1,"right_p",1}},
				-- noises = {2,1},noiserandom = 0.2,
				-- have_inrerchange = true
            -- },
            -- {
                -- 203,"North-Gate Bridge",
				-- arr = {{"this_is","ngate",1},{"this_is","ngate",1}},
                -- arrlast = {{"this_is","ngate",1,"last",1},nil},
                -- dep = {{"cls",0.5,"chime",1,"nexts","vpromenade",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","vavenue",1,"right_p",1}},
				-- noises = {2,1},noiserandom = 0.2,
            -- },
            -- {
                -- 204,"Victoria Promenade",
				-- arr = {{"this_is","vpromenade",1},{"this_is","vpromenade",1}},
                -- arrlast = {nil,{"this_is","vpromenade",1,"last",1}},
                -- dep = {{"cls",0.5,"chime",1,"nexts","central",1,"left_p",1},{"cls",0.5,"chime",1,"nexts","ngate",1,"right_p",1}},
				-- noises = {2,1},noiserandom = 0.2,
            -- },
            -- {
                -- 205,"Central Street",
				-- arr = {{"this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1},{"this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1}},
                -- arrlast = {{"this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1,"last",1},nil},
                -- dep = {{"cls",0.5,"chime",1,"nexts","lakefieldst",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","vpromenade",1,"right_p",1}},
				-- noises = {2,1},noiserandom = 0.2,
				-- have_inrerchange = true
            -- },
            -- {
                -- 206,"Lakefield Street",
                -- arr = {{"this_is","lakefieldst",1,"transfer","m1",},{"this_is","lakefieldst",1,"transfer","m1",1}},
                -- dep = {{"cls",0.5,"chime",1,"nexts","fischer",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","central",1,"left_p",1}},
				-- noises = {2,1},noiserandom = 0.2,
				-- have_inrerchange = true
            -- },
            -- {
                -- 207,"Fisherman's Hut",
                -- arr = {{"this_is","fischer",1},{"this_is","fischer",1}},
                -- dep = {{"cls",0.5,"chime",1,"nexts","port",1,"right_p",1},{"cls",0.5,"chime",1,"nexts","lakefieldst",1,"right_p",1}},
				-- noises = {2,1},noiserandom = 0.2,
            -- },
            -- {
                -- 208,"South-Port Junction",
                -- arrlast = {{"this_is","port","transfer","p",1,"last",1},nil},
                -- dep = {nil,{"cls",0.5,"chime",1,"nexts","fischer",1,"right_p",1}},
				-- noises = {2,1},noiserandom = 0.2,
				-- have_inrerchange = true
            -- },
-- })
Metrostroi.AddSarmatUPOAnnouncer("SARMAT UPO[EN] null_space",{
        tone = {"subway_announcers/chime_rg.wav", 3},
		
        garden = {"subway_announcers/ndr_cz/garden.wav", 1.4},
		vburrow = {"subway_announcers/ndr_cz/vburrow.wav", 1.4},
		vavenue = {"subway_announcers/ndr_cz/vavenue.wav", 1.4},
		ngate = {"subway_announcers/ndr_cz/ngate.wav", 1.6},
		vpromenade = {"subway_announcers/ndr_cz/vpromenade.wav", 1.6},
		central = {"subway_announcers/ndr_cz/central.wav", 1.2},
		lakefieldst = {"subway_announcers/ndr_cz/lakefieldst.wav", 1.2},
		fischer = {"subway_announcers/ndr_cz/fischer.wav", 1.2},
		port = {"subway_announcers/ndr_cz/port.wav", 1.6},

		cls = {"subway_announcers/ndr_cz/cls.wav", 2.5},
		nexts = {"subway_announcers/ndr_cz/next.wav", 2.1},
		this_is = {"subway_announcers/ndr_cz/this is.wav", 1},
		--eastbound = {"subway_announcers/ndr_cz/eastbound.wav", 2.1},
		--special_e = {"subway_announcers/ndr_cz/special_e.wav", 2.6},
		--westbound = {"subway_announcers/ndr_cz/westbound.wav", 2.3},
		--special_w = {"subway_announcers/ndr_cz/special_w.wav", 2.5},
		m1 =  {"subway_announcers/ndr_cz/m1.wav", 2.2},
		m3 =  {"subway_announcers/ndr_cz/m3.wav", 2},
		d = {"subway_announcers/ndr_cz/d.wav", 2},
		n = {"subway_announcers/ndr_cz/n.wav", 2.5},
		p = {"subway_announcers/ndr_cz/p.wav", 2},
		last = {"subway_announcers/ndr_cz/last.wav", 7},
		transfer = {"subway_announcers/ndr_cz/transfer.wav", 1.2},
		left_p = {"subway_announcers/ndr_cz/left_p.wav", 2.3},
		right_p = {"subway_announcers/ndr_cz/right_p.wav", 2.2},
		
		spec_wait = {"subway_announcers/ndr/lmao.mp3",22},
		
}, {
		{
            LED = {4,3,3,3,3,3,3,4,4},
			Daisy_Line = "V",
            {
                200,"Garden Circus",
                arrlast = {nil,{"this_is","garden",1,"last",1}},
                dep = {{2,"nexts","vburrow",1,"right_p",1},nil},
				odz = "cls",
            },
            {
                201,"Victoria - Burrow",
                arr = {{"this_is","vburrow",1},{"this_is","vburrow",1}},
                dep = {{2,"nexts","vavenue",1,"right_p",1},{2,"nexts","garden",1,"left_p",1}},
				odz = "cls",
            },
            {
                202,"Victoria Ave.",
                arr = {{"this_is","vavenue",1,"transfer","m3",1},{"this_is","vavenue",1,"transfer","m3",1}},
                dep = {{2,"nexts","ngate",1,"right_p",1},{2,"nexts","vburrow",1,"right_p",1}},
				have_inrerchange = true,
				odz = "cls",
            },
            {
                203,"North-Gate Bdg.",
				arr = {{"this_is","ngate",1},{"this_is","ngate",1}},
                arrlast = {{"this_is","ngate",1,"last",1},nil},
                dep = {{2,"nexts","vpromenade",1,"right_p",1},{2,"nexts","vavenue",1,"right_p",1}},
				odz = "cls",
            },
            {
                204,"Victoria Prom.",
				arr = {{"this_is","vpromenade",1},{"this_is","vpromenade",1}},
                arrlast = {nil,{"this_is","vpromenade",1,"last",1}},
                dep = {{2,"nexts","central",1,"left_p",1},{2,"nexts","ngate",1,"right_p",1}},
				odz = "cls",
            },
            {
                205,"Central St.",
				arr = {{"this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1},{"this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1}},
                arrlast = {{"this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1,"last",1},nil},
                dep = {{2,"nexts","lakefieldst",1,"right_p",1},{2,"nexts","vpromenade",1,"right_p",1}},
				have_inrerchange = true,
				odz = "cls",
            },
            {
                206,"Lakefield St.",
                arr = {{"this_is","lakefieldst",1,"transfer","m1",},{"this_is","lakefieldst",1,"transfer","m1",1}},
                dep = {{2,"nexts","fischer",1,"right_p",1},{2,"nexts","central",1,"left_p",1}},
				have_inrerchange = true,
				odz = "cls",
            },
            {
                207,"Fisherman's Hut",
                arr = {{"this_is","fischer",1},{"this_is","fischer",1}},
                dep = {{2,"nexts","port",1,"right_p",1},{2,"nexts","lakefieldst",1,"right_p",1}},
				odz = "cls",
            },
            {
                208,"South-Port Jct.",
                arrlast = {{"this_is","port","transfer","p",1,"last",1},nil},
                dep = {nil,{2,"nexts","fischer",1,"right_p",1}},
				have_inrerchange = true,
				odz = "cls",
            },
		},
})
Metrostroi.AddSarmatUPOAnnouncer("SARMAT UPO[EN] James May (TTS)",{
        tone = {"subway_announcers/chime_rg.wav", 3},
		
        garden = {"subway_announcers/ndr/garden.wav", 1.2},
		vburrow = {"subway_announcers/ndr/vburrow.wav", 1.5},
		vavenue = {"subway_announcers/ndr/vavenue.wav", 1.3},
		ngate = {"subway_announcers/ndr/ngate.wav", 1.2},
		vpromenade = {"subway_announcers/ndr/vpromenade.wav", 1.5},
		central = {"subway_announcers/ndr/central.wav", 1.1},
		lakefieldst = {"subway_announcers/ndr/lakefieldst.wav", 1.1},
		fischer = {"subway_announcers/ndr/fischer.wav", 1},
		port = {"subway_announcers/ndr/port.wav", 1.4},

		cls = {"subway_announcers/ndr/cls.wav", 2.5},
		nexts = {"subway_announcers/ndr/next.wav", 1.4},
		this_is = {"subway_announcers/ndr/this is.wav", 0.8},
		--eastbound = {"subway_announcers/ndr/eastbound.wav", 1.7},
		--special_e = {"subway_announcers/ndr/special_e.wav", 2},
		--westbound = {"subway_announcers/ndr/westbound.wav", 1.8},
		--special_w = {"subway_announcers/ndr/special_w.wav", 2.1},
		m1 =  {"subway_announcers/ndr/m1.wav", 2.2},
		m3 =  {"subway_announcers/ndr/m3.wav", 2.3},
		d = {"subway_announcers/ndr/d.wav", 2},
		n = {"subway_announcers/ndr/n.wav", 2.9},
		p = {"subway_announcers/ndr/p.wav", 1.7},
		last = {"subway_announcers/ndr/last.wav", 6.5},
		transfer = {"subway_announcers/ndr/transfer.wav", 1.3},
		left_p = {"subway_announcers/ndr/left_p.wav", 2.1},
		right_p = {"subway_announcers/ndr/right_p.wav", 1.8},
		
		spec_wait = {"subway_announcers/ndr/lmao.mp3",22},
		
}, {
		{
            LED = {4,3,3,3,3,3,3,4,4},
			Daisy_Line = "V",
            {
                200,"Garden Circus",
                arrlast = {nil,{"this_is","garden",1,"last",1}},
                dep = {{2,"nexts","vburrow",1,"right_p",1},nil},
				odz = "cls",
            },
            {
                201,"Victoria - Burrow",
                arr = {{"this_is","vburrow",1},{"this_is","vburrow",1}},
                dep = {{2,"nexts","vavenue",1,"right_p",1},{2,"nexts","garden",1,"left_p",1}},
				odz = "cls",
            },
            {
                202,"Victoria Ave.",
                arr = {{"this_is","vavenue",1,"transfer","m3",1},{"this_is","vavenue",1,"transfer","m3",1}},
                dep = {{2,"nexts","ngate",1,"right_p",1},{2,"nexts","vburrow",1,"right_p",1}},
				have_inrerchange = true,
				odz = "cls",
            },
            {
                203,"North-Gate Bdg.",
				arr = {{"this_is","ngate",1},{"this_is","ngate",1}},
                arrlast = {{"this_is","ngate",1,"last",1},nil},
                dep = {{2,"nexts","vpromenade",1,"right_p",1},{2,"nexts","vavenue",1,"right_p",1}},
				odz = "cls",
            },
            {
                204,"Victoria Prom.",
				arr = {{"this_is","vpromenade",1},{"this_is","vpromenade",1}},
                arrlast = {nil,{"this_is","vpromenade",1,"last",1}},
                dep = {{2,"nexts","central",1,"left_p",1},{2,"nexts","ngate",1,"right_p",1}},
				odz = "cls",
            },
            {
                205,"Central St.",
				arr = {{"this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1},{"this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1}},
                arrlast = {{"this_is","central",1,"transfer","m3",0.5,"d",0.5,"n",1,"last",1},nil},
                dep = {{2,"nexts","lakefieldst",1,"right_p",1},{2,"nexts","vpromenade",1,"right_p",1}},
				have_inrerchange = true,
				odz = "cls",
            },
            {
                206,"Lakefield St.",
                arr = {{"this_is","lakefieldst",1,"transfer","m1",},{"this_is","lakefieldst",1,"transfer","m1",1}},
                dep = {{2,"nexts","fischer",1,"right_p",1},{2,"nexts","central",1,"left_p",1}},
				have_inrerchange = true,
				odz = "cls",
            },
            {
                207,"Fisherman's Hut",
                arr = {{"this_is","fischer",1},{"this_is","fischer",1}},
                dep = {{2,"nexts","port",1,"right_p",1},{2,"nexts","lakefieldst",1,"right_p",1}},
				odz = "cls",
            },
            {
                208,"South-Port Jct.",
                arrlast = {{"this_is","port","transfer","p",1,"last",1},nil},
                dep = {nil,{2,"nexts","fischer",1,"right_p",1}},
				have_inrerchange = true,
				odz = "cls",
            },
		},
})
Metrostroi.StationConfigurations = {
    [200] = {
        names = {"Garden Circus"},
        positions = {
            {Vector(1067,-15232,132),Angle(0,0,0)},
			{Vector(3938,-15232,132),Angle(0,-180,0)},
        }
    },
    ["DISPGC"] = {
        names = {"Dispatch room GC"},
        positions = {
            {Vector(239,-15257,280),Angle(0,0,0)},
        }
    },
    [201] = {
        names = {"Victoria - Burrow"},
        positions = {
            {Vector(-15180,-8450,-509),Angle(0,0,0)},
			{Vector(-14013,-8450,-509),Angle(0,-180,0)},
        }
    },
    [202] = {
        names = {"Victoria Avenue"},
        positions = {
            {Vector(8965,-7445,-764),Angle(0,90,0)},
            {Vector(8965,-6918,-764),Angle(0,-90,0)},
        }
    },
    [203] = {
        names = {"North-Gate Bdg."},
        positions = {
            {Vector(3001,5099,-253),Angle(0,-90,0)},
			{Vector(3001,4124,-253),Angle(0,90,0)},
        }
    },
    ["DISPNB"] = {
        names = {"Dispatch room NB"},
        positions = {
            {Vector(4368,4928,-300),Angle(0,0,0)},
        }
    },
    [204] = {
        names = {"Victoria Prom."},
        positions = {
            {Vector(1973,15081,-253),Angle(0,-90,0)},
			{Vector(1973,14100,-253),Angle(0,90,0)},
        }
    },
	["DISPVP"] = {
        names = {"Dispatch room VP"},
        positions = {
            {Vector(3356,14916,-300),Angle(0,0,0)},
        }
    },
    [205] = {
        names = {"Central Street"},
        positions = {
            {Vector(5376,3239,-765),Angle(0,-90,0)},
			{Vector(5376,336,-765),Angle(0,90,0)},
        }
    },
    ["DISPCS"] = {
        names = {"Dispatch room CS"},
        positions = {
            {Vector(5376,5484,-800),Angle(0,-90,0)},
        }
    },
    [206] = {
        names = {"Lakefield Street"},
        positions = {
            {Vector(13653,2935,-1300),Angle(0,0,0)},
			{Vector(14761,2935,-1300),Angle(0,-180,0)},
        }
    },
    [207] = {
        names = {"Fisherman's Hut"},
        positions = {
            {Vector(5503,-15284,-1580),Angle(0,-90,0)},
			{Vector(5503,-16212,-1580),Angle(0,90,0)},
        }
    },
    [208] = {
        names = {"South-Port Jct."},
        positions = {
            {Vector(-2268,15123,-766),Angle(0,150,0)},
        }
    },
	["DISPSJ"] = {
        names = {"Dispatch room SJ"},
        positions = {
            {Vector(-6406,15872,-800),Angle(0,180,0)},
        }
    },
    ["DEP"] = {
        names = {"Depot"},
        positions = {
            {Vector(-4493,-6912,76),Angle(0,180,0)},
        }
    },
    ["DISPDP"] = {
        names = {"Dispatch room DP"},
        positions = {
            {Vector(-5796,-5911,200),Angle(0,90,0)},
        }
    },
    }