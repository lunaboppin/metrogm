include("shared.lua")
--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.AutoAnims = {}
ENT.ClientSounds = {}


ENT.ClientProps["salon"] = {
    model = "models/metrostroi_train/81-5402/dev4you_interior_5p.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}

ENT.ClientProps["begstroka_tabloR"] = {
    model = "models/metrostroi_train/81-5402/dev4you_begstroka.mdl",
	pos = Vector(-448.65,0,59),
	ang = Angle(180,0,0),
	scale=1,
	hide=1.5,
}
ENT.ButtonMap["begstrokaR"] = {
    pos = ENT.ClientProps["begstroka_tabloR"].pos+Vector(0.85,-25.7,1.65),
    ang = Angle(0,90,90),
    width = 694,
    height = 45,
    scale = 0.074,
    hideseat=1.5,
}
ENT.ClientProps["begstroka_tabloF"] = {
    model = "models/metrostroi_train/81-5402/dev4you_begstroka.mdl",
	pos = Vector(374.7,0,63),
	ang = Angle(0,0,0),
	scale=1,
	hide=1.5,
}
ENT.ButtonMap["begstrokaF"] = {
    pos = ENT.ClientProps["begstroka_tabloF"].pos+Vector(-0.85,25.7,1.65),
    ang = Angle(0,-90,90),
    width = 694,
    height = 45,
    scale = 0.074,
    hideseat=1.5,
}
ENT.ClientProps["konus"] = {
    model = "models/metrostroi_train/81-5402/ext_prs_5p.mdl",
    pos = Vector(438,-55,68.5),
    ang = Angle(0,0,13),
    nohide=true,
}
ENT.ClientProps["tch3"] = {
    model = "models/metrostroi_train/81-5402/5p_num_3.mdl",
    pos = Vector(462.75,-43,-53.65),
    ang = Angle(3,-9,0),
    nohide=true,
}
ENT.ClientProps["tch6"] = {
    model = "models/metrostroi_train/81-5402/5p_num_6.mdl",
    pos = Vector(462.75,-43,-53.65),
    ang = Angle(3,-9,0),
    nohide=true,
}
ENT.ClientProps["svetolenta"] = {
    model = "models/metrostroi_train/81-5402/svetolenta_5p.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=0.8,
}
ENT.ClientProps["kts"] = {
    model = "models/metrostroi_train/81-5402/kts_5p.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
	scale=1,
    hide=1,
}
ENT.ClientProps["asps"] = {
    model = "models/asps/asps.mdl",
    pos = Vector(450.1,-55.5,16.2),
    ang = Angle(0,135,0),
	scale=1.25,
    hide=1,
}
ENT.ClientProps["label_wifi_1"] = {
    model = "models/metrostroi_train/81-717/labels/label_wifi.mdl",
    pos = Vector(188,66,30),
    ang = Angle(180,0,-90),
	scale=0.35,
    hide=0.8,
}
ENT.ClientProps["label_wifi_2"] = {
    model = "models/metrostroi_train/81-717/labels/label_wifi.mdl",
    pos = Vector(-42,66,30),
    ang = Angle(180,0,-90),
	scale=0.35,
    hide=0.8,
}
ENT.ClientProps["label_wifi_3"] = {
    model = "models/metrostroi_train/81-717/labels/label_wifi.mdl",
    pos = Vector(-272,66,30),
    ang = Angle(180,0,-90),
	scale=0.35,
    hide=0.8,
}
ENT.ClientProps["label_wifi_4"] = {
    model = "models/metrostroi_train/81-717/labels/label_wifi.mdl",
    pos = Vector(259,-66,30),
    ang = Angle(180,0,-90),
	scale=0.35,
    hide=0.8,
}
ENT.ClientProps["label_wifi_5"] = {
    model = "models/metrostroi_train/81-717/labels/label_wifi.mdl",
    pos = Vector(29,-66,30),
    ang = Angle(180,0,-90),
	scale=0.35,
    hide=0.8,
}
ENT.ClientProps["label_wifi_6"] = {
    model = "models/metrostroi_train/81-717/labels/label_wifi.mdl",
    pos = Vector(-201,-66,30),
    ang = Angle(180,0,-90),
	scale=0.35,
    hide=0.8,
}
ENT.ClientProps["trafaret"] = {
    model = "models/metrostroi_train/81-5402/traf_spb.mdl",
    pos = Vector(406.3,41.2,63),
    ang = Angle(23,0,0),
    scale=1.15,
    hideseat=0.5,
}
ENT.ClientProps["chair_torec_1_cp"] = {
    model = "models/metrostroi_train/81-5402/seat1.mdl",
    pos = Vector(-408.58,-50.8,-28),
    ang = Angle(0,90,0),
	hide=1.5,
}
ENT.ClientProps["chair_torec_2_cp"] = {
    model = "models/metrostroi_train/81-5402/seat1.mdl",
    pos = Vector(-448.0,-50.8,-28),
    ang = Angle(0,90,0),
	hide=1.5,
}
ENT.ButtonMap["chair_torec_bm"] = {
    pos = Vector(-398,-56,-3),
    ang = Angle(0,180,60),
    width = 1010,
    height = 500,
    scale = 0.06,
    buttons = {
        {ID = "chair_torec_1_bm",x=0,y=0,w=370,h=500, tooltip="Откидное сиденье"},
        {ID = "chair_torec_2_bm",x=640,y=0,w=370,h=500, tooltip="Откидное сиденье"},
	}	
}
ENT.ClientProps["otsek_torec_1_cp"] = {
    model = "models/metrostroi_train/81-5402/otsek1.mdl",
	pos = Vector(-462.5,-51.55,-12.7),
	ang = Angle(0,0,0),
	hide=1.5,
}
ENT.ClientProps["otsek_torec_2_cp"] = {
    model = "models/metrostroi_train/81-5402/otsek2.mdl",
	pos = Vector(-462.5,51.55,-12.7),
	ang = Angle(0,0,0),
	hide=1.5,
}
ENT.ButtonMap["otsek_torec_1_bm"] = {
    pos = Vector(-461,-51,-1),
    ang = Angle(0,98,90),
    width = 1100,
    height = 880,
    scale = 0.1/3.8	,

    buttons = {
        {ID = "otsek_torec_1_bm",x=0,y=0,w=1100,h=880, tooltip="Крышка отсека"},
    }
}
ENT.ButtonMap["otsek_torec_2_bm"] = {
    pos = Vector(-465,22,-1),
    ang = Angle(0,82,90),
    width = 1100,
    height = 880,
    scale = 0.1/3.8	,

    buttons = {
        {ID = "otsek_torec_2_bm",x=0,y=0,w=1100,h=880, tooltip="Крышка отсека"},
    }
}
ENT.ClientProps["dooroffvalve1"] = {
    model = "models/metrostroi_train/81-5402/ezh3_stopkran.mdl",
    pos = Vector(281.2,62.65,20.2),
    ang = Angle(0,180,0),
    color=Color(155,155,155),
    hideseat=0.5,
}
ENT.ClientProps["dooroffvalve2"] = {
    model = "models/metrostroi_train/81-5402/ezh3_stopkran.mdl",
    pos = Vector(281.2,-62.65,20.2),
    ang = Angle(0,0,0),
    color=Color(155,155,155),
    hideseat=0.5,
}
ENT.ClientProps["dooroffvalve3"] = {
    model = "models/metrostroi_train/81-5402/ezh3_stopkran.mdl",
    pos = Vector(-293.55,62.65,20.2),
    ang = Angle(0,180,0),
    color=Color(155,155,155),
    hideseat=0.5,
}
ENT.ClientProps["dooroffvalve4"] = {
    model = "models/metrostroi_train/81-5402/ezh3_stopkran.mdl",
    pos = Vector(-293.55,-62.65,20.2),
    ang = Angle(0,0,0),
    color=Color(155,155,155),
    hideseat=0.5,
}
local lAng,rAng = 0,0
for i=0,10 do
    lAng = math.random()>0.7 and math.random(30,60) or 0
    ENT.ClientProps["salon_vent_l"..i] = {
        model = "models/metrostroi_train/81-5402/ventilation.mdl",
        pos = Vector(-411+i*74.4,32.3,70),
        ang = Angle(0,0,-lAng),
        bscale = Vector(1,1.012,1),
        hideseat = 1.5,
    }
    rAng = math.random()>0.7 and math.random(30,60) or 0
    ENT.ClientProps["salon_vent_r"..i] = {
        model = "models/metrostroi_train/81-5402/ventilation.mdl",
        pos = Vector(-411+i*74.4,-32.3,70),
        ang = Angle(0,180,-rAng),
        bscale = Vector(1,1.012,1),
        hideseat = 1.5,
    }
end

ENT.ClientProps["schemes"] = {
    model = "models/metrostroi_train/81-5402/5p_schemes.mdl",
	scale=1,
    pos = Vector(0,0,0),
    ang = Angle(0,90,0),
    hide=2,
    callback = function(ent)
        ent.PassSchemesDone = false
    end,
}
ENT.ClientProps["sosd_lamp"] = {
    model = "models/metrostroi_train/81-717/sosd_lamp.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["handrails_new"] = {
    model = "models/metrostroi_train/81-5402/dev4you_interior_5p_handrails.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=1.5,
}

ENT.ClientProps["Headlights_1"] = {
    model = "models/metrostroi_train/81-5402/group2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["Headlights_2"] = {
    model = "models/metrostroi_train/81-5402/group1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["RedLights"] = {
    model = "models/metrostroi_train/81-5402/redlights.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["door_otsek1"] = {
    model = "models/metrostroi_train/81-5402/otsek3.mdl",
    pos = Vector(375.35,-16.8,5.9),
    ang = Angle(0,0,0),
    hideseat=1.5,
}
ENT.ClientProps["door_otsek2"] = {
    model = "models/metrostroi_train/81-5402/otsek4.mdl",
    pos = Vector(375.35,-59.5,5.9),
    ang = Angle(0,0,0),
    hideseat=1.5,
}
ENT.ClientProps["door1"] = {
    model = "models/metrostroi_train/81-5402/door_torec.mdl",
    pos = Vector(-472.7,18.8,-2.7),
    ang = Angle(0,-90,0),
    hide=2,
}
ENT.ClientProps["door2"] = {
    model = "models/metrostroi_train/81-5402/cab_door_5p.mdl",
    pos = Vector(377.322,28.267,-1.599),
    ang = Angle(0,-89,0),
    hide=2,
}
ENT.ClientProps["door3"] = {
    model = "models/metrostroi_train/81-5402/door_cabine_5p.mdl",
    pos = Vector(444.2,66.2,8.9),
    ang = Angle(0,180,0),
    hide=2,
}
ENT.ClientProps["cabine_new"] = {
    model = "models/metrostroi_train/81-5402/cab5p.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["Controller_body"] = {
    model = "models/metrostroi_train/81-5402/dev4you_pult5p.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=1.5,
}
ENT.ClientProps["Controller_puav"] = {
    model = "models/metrostroi_train/81-5402/puav_5p.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=0.8,
}
ENT.ClientProps["Controller"] = {
    model = "models/metrostroi_train/81-5402/bkm.mdl",
    pos = Vector(439.97,17.5,-5.25),
    ang = Angle(-115,8,0),
    hideseat=0.2,
}

ENT.ButtonMap["Block4"] = {
    pos = Vector(442.8,27.4,-4.2),
    ang = Angle(0,-82,0),
    width = 230,
    height = 130,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
		{ID = "!PTK", x=170.2, y=109.8, radius=10, tooltip="Лампа питания контроллера", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",scale=0.5,ang = Angle(0,0,0),z=-4.7,color = Color(45,255,45), var="PTK"}
        }},
    }
}

ENT.ButtonMap["Block5"] = {
    pos = Vector(443,10.1,-4.63),
    ang = Angle(0,-90,22),
    width = 320,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
		{ID = "2:KRPSet",x=34,y=23,radius=20,tooltip="Пуск резервный",model = {
            model = "models/addon_buttons/yellow_button.mdl",scale=1,z=1.2,
            var="KRP",speed=12,vmin=0,vmax=0.8,
			lamp = {model = "models/addon_buttons/lamp_yellow.mdl",var="KRUL",z=2, anim=true, },
            sndvol = 0.2,snd = function(val) return val and "button_on" or "button_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:KVTSet",x=34+55,y=23,radius=20,tooltip="Бдительность",model = {
            model = "models/metrostroi_train/81-5402/redbutton_5p.mdl",scale=1,ang = 180,z=1.5,
            var="KVT",speed=16,vmin=1,vmax=0.4,
            sndvol = 0.4,snd = function(val) return val and "switch_kb_on" or "switch_kb_off" end,
            sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:VozvratRPSet",x=34+51*2,y=23,radius=20,tooltip="Возврат РП",model = {
            model = "models/addon_buttons/green_button.mdl",scale=1,z=1.2,
            var="VozvratRP",speed=12,vmin=0,vmax=0.8,
			lamp = {model = "models/addon_buttons/lamp_green.mdl",var="GRP",z=2, anim=true, },
            sndvol = 0.2,snd = function(val) return val and "button_on" or "button_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:KSNSet",x=30+51.4*3,y=23,radius=20,tooltip="Сигнализация неисправности",model = {
            model = "models/addon_buttons/black_button.mdl",scale=1,z=1.2,
			var="KSN",speed=12,vmin=0,vmax=0.8,
            sndvol = 0.2,snd = function(val) return val and "button_on" or "button_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:RingSet",x=30+50.7*4,y=23,radius=20,tooltip="Звонок",model = {
            model = "models/addon_buttons/black_button.mdl",scale=1,z=1.2,
            var="Ring",speed=12,vmin=0,vmax=0.8,
            sndvol = 0.2,snd = function(val) return val and "button_on" or "button_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:KRZDSet",x=30+51.7*5,y=23,radius=20,tooltip="Резервное закрытие дверей",model = {
            model = "models/addon_buttons/black_button.mdl",scale=1,z=1.2,
            var="KRZD",speed=12,vmin=0,vmax=0.8,
            sndvol = 0.2,snd = function(val) return val and "button_on" or "button_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:KDLSet",x=34,y=70,radius=15,tooltip="Открытие левых дверей",model = {
            model = "models/addon_buttons/white_button.mdl",scale=1,z=1.2,
            var="KDL",speed=12,vmin=0,vmax=0.7,
			lamp = {model = "models/addon_buttons/lamp_white.mdl",var="DoorsLeftL",z=2, anim=true, },
            sndvol = 0.2,snd = function(val) return val and "button_on" or "button_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:KDLK_mplToggle",x=14,y=54.6,w=40,h=10,tooltip="Крышка кнопки открытия левых дверей",model = {
            var="KDLK_mpl",speed=4,min=0.34,max=0.685,disable="2:KDLSet",
            model = "models/metrostroi_train/81-5402/krishka.mdl",scale=1.05,ang = 180,z=4,
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:KDLK_pblToggle",x=6.5,y=57.5,w=40,h=10,tooltip="Крышка кнопки открытия левых дверей",model = {
            var="KDLK_pbl",speed=4,min=0.34,max=0.685,disable="2:KDLSet",
            model = "models/metrostroi_train/81-5402/krishka.mdl",scale=1.05,ang = 225,z=4,
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
		{   ID = "2:DoorSelectToggle",x=34.4+55,y=71,radius=20,tooltip="Выбор стороны открытия дверей",model = {
            model = "models/metrostroi_train/81-5402/tumbler_5p.mdl",scale=1,ang=90,z=2.1,
            var="DoorSelect",speed=7, min=0.13,max=0.38,
            sndvol = 1,snd = function(val) return val and "multiswitch_panel_mid" or "multiswitch_panel_mid" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:KSZDSet",x=30+53*2,y=70,radius=20,tooltip = "КСЗД: Кнопка согласия закрытия дверей",model = {
            model = "models/addon_buttons/black_button.mdl",scale=1,z=1.2,
            var="KSZD",speed=12, min=0,max=0.8,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
            sndmin = 90, sndmax = 1e3,
        }},
        {ID = "2:VZPToggle",x=31+51.2*3,y=71,radius=20,tooltip="ВЗП: Выключатель задержки поезда",model = {
            model = "models/metrostroi_train/81-5402/tumbler_5p.mdl",scale=1,z=2.1,ang=90,
            var="VZP",speed=7, min=0.13,max=0.38,
            sndvol = 1,snd = function(val) return val and "multiswitch_panel_mid" or "multiswitch_panel_mid" end,
        }},
		{ID = "2:KDPSet",x=30+50.8*4,y=70,radius=15,tooltip="Открытие правых дверей",model = {
            model = "models/addon_buttons/white_button.mdl",scale=1,z=1.2,
            var="KDP",speed=12,vmin=0,vmax=0.6,
			lamp = {model = "models/addon_buttons/lamp_white.mdl",var="DoorsRightL",z=2, anim=true, },
            sndvol = 0.2,snd = function(val) return val and "button_on" or "button_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:KDPK_mplToggle",x=213.2,y=54.6,w=40,h=10,tooltip="Крышка кнопки открытия правых дверей",model = {
            var="KDPK_mpl",speed=4,min=0.34,max=0.685,disable="2:KDPSet",
            model = "models/metrostroi_train/81-5402/krishka.mdl",scale=1.05,ang = 180,z = 4,
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:KDPK_pblToggle",x=221.1,y=57.4,w=40,h=10,tooltip="Крышка кнопки открытия правых дверей",model = {
            var="KDPK_pbl",speed=4,min=0.34,max=0.685,disable="2:KDPSet",
            model = "models/metrostroi_train/81-5402/krishka.mdl",scale=1.05,ang = 135,z = 4,
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:VUD1Toggle",x=30+51.7*5,y=71,radius=20,tooltip="Выключатель закрытия дверей",model = {
            model = "models/metrostroi_train/81-5402/tumbler_5p.mdl",scale=1,z=2.1,ang=90,
            var="VUD1",speed=7, min=0.13,max=0.38,
            sndvol = 1,snd = function(val) return val and "multiswitch_panel_mid" or "multiswitch_panel_mid" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["Block6"] = {
    pos = Vector(450.2,-14,-0.2),
    ang = Angle(0.2,-119,30),
    width = 300,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
		{ID = "VMKSwitchToggle",x=47,y=31.5,radius=0,tooltip="Мотор-комрпессор",model = {
            model = "models/metrostroi_train/81-5402/tumbler_5p.mdl",scale=1,z=1.4,ang=90,
			getfunc = function(ent) return ent:GetPackedRatio("VMKSwitch") end, var="VMKSwitch",
			speed=4,min=0.14,max=0.39,
			lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",scale=0.5,x=15.5,y=-17.7,z=-3,color = Color(0,255,0),var="LMK"},
            sndvol = 1,snd = function(val) return val and "multiswitch_panel_mid" or "multiswitch_panel_mid" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
		{ID="VMKSwitch+",x=47, y=20.5, w=20,h=30, tooltip="Мотор-комрпессор: +"},
		{ID="VMKSwitch-",x=27, y=20.5, w=20,h=30, tooltip="Мотор-комрпессор: -"},
		{ID = "!LMKR", x=47-15.5, y=30.5-17.5, radius=0, tooltip="", model = {
			lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",scale=0.5,ang = Angle(0,0,0),z=-1.8,color = Color(255,0,0),var="LMKR"}
        }},
		{   ID = "2:L_1Toggle",x=47+43,y=30.5,radius=20,tooltip="Освещение салона",model = {
            model = "models/metrostroi_train/81-5402/tumbler_5p.mdl",scale=1,z=1.4,ang=90,
            var="L_1",speed=7, min=0.13,max=0.38,
            sndvol = 1,snd = function(val) return val and "multiswitch_panel_mid" or "multiswitch_panel_mid" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:OhrSigToggle",x=47+43.7*2,y=30,radius=20,tooltip="Охранная сигнализация",model = {
            model = "models/metrostroi_train/81-5402/tumbler_5p.mdl",scale=1,z=1.4,ang=90,
            var="OhrSig",speed=7, min=0.13,max=0.38,
            sndvol = 1,snd = function(val) return val and "multiswitch_panel_mid" or "multiswitch_panel_mid" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
		{   ID = "2:R_UPOToggle",x=47+43*3,y=29.5,radius=20,tooltip="УПО",model = {
            model = "models/metrostroi_train/81-5402/tumbler_5p.mdl",scale=1,z=1.4,ang=90,
            var="R_UPO",speed=7, min=0.13,max=0.38,
            sndvol = 1,snd = function(val) return val and "multiswitch_panel_mid" or "multiswitch_panel_mid" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:L_2Toggle",x=47+43.3*4,y=29.5,radius=20,tooltip="Освещение кабины",model = {
            model = "models/metrostroi_train/81-5402/tumbler_5p.mdl",scale=1,z=1.4,ang=90,
            var="L_2",speed=7, min=0.13,max=0.38,
            sndvol = 1,snd = function(val) return val and "multiswitch_panel_mid" or "multiswitch_panel_mid" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
		{ID = "HeadLightsSwitchToggle",x=47+43*5,y=29.5,radius=0,tooltip="Фары",model = {
            model = "models/metrostroi_train/81-5402/tumbler_5p.mdl",scale=1,z=1.6,ang=90,
			getfunc = function(ent) return ent:GetPackedRatio("HeadLightsSwitch") end, var="HeadLightsSwitch",
			speed=4,min=0.14,max=0.39,
            sndvol = 1,snd = function(val) return val and "multiswitch_panel_mid" or "multiswitch_panel_mid" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
		{ID="HeadLightsSwitch+",x=262, y=19.5, w=20,h=30, tooltip="Фары: +"},
		{ID="HeadLightsSwitch-",x=242, y=19.5, w=20,h=30, tooltip="Фары: -"},
		{ID = "2:VZ1Set",x=47,y=78,radius=20,tooltip="Вентиль замещения 1",model = {
            model = "models/addon_buttons/black_button.mdl",scale=1,z=0,
            var="VZ1",speed=12,vmin=0,vmax=0.8,
            sndvol = 0.2,snd = function(val) return val and "button_on" or "button_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
		{   ID = "WiperToggle",x=44.6*2,y=78,radius=20,tooltip="Стеклоочиститель",model = {
            model = "models/metrostroi_train/81-5402/tumbler_5p.mdl",scale=1,z=0.8,ang=90,
            var="Wiper",speed=7, min=0.13,max=0.38,
            sndvol = 1,snd = function(val) return val and "multiswitch_panel_mid" or "multiswitch_panel_mid" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
		{   ID = "2:R_GToggle",x=44.6*3,y=78,radius=20,tooltip="Контроль громкоговорителя",model = {
             model = "models/metrostroi_train/81-5402/tumbler_5p.mdl",scale=1,z=1,ang=90,
            var="R_G",speed=7, min=0.13,max=0.38,
            sndvol = 1,snd = function(val) return val and "multiswitch_panel_mid" or "multiswitch_panel_mid" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:BKCU3Protection",x=47+43*3,y=78,radius=20,tooltip="",model = {
            model = "models/addon_buttons/red_button.mdl",scale=1,z=0.3,
            var="BKCU3",speed=12,vmin=0,vmax=0.6,
			lamp = {model = "models/addon_buttons/lamp_red.mdl",var="",z=2, anim=true, },
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:BKCU3KToggle",x=156,y=84,w=40,h=10,tooltip="Крышка кнопки БКЦУ 3",model = {
            var="BKCU3K",speed=4,min=0.33,max=0.72,disable="2:BKCU3Protection",
            model = "models/metrostroi_train/81-5402/krishka.mdl",scale=1.05,ang=180,z=5.8,
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:BKCU1Protection",x=47+43.3*4,y=78,radius=20,tooltip="",model = {
            model = "models/addon_buttons/red_button.mdl",scale=1,z=0.5,
            var="BKCU1",speed=12,vmin=0,vmax=0.6,
			lamp = {model = "models/addon_buttons/lamp_red.mdl",var="",z=2, anim=true, },
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:BKCU1KToggle",x=200.2,y=84,w=40,h=10,tooltip="Крышка кнопки БКЦУ 1",model = {
            var="BKCU1K",speed=4,min=0.33,max=0.72,disable="2:BKCU1Protection",
            model = "models/metrostroi_train/81-5402/krishka.mdl",scale=1.05,ang=180,z=6.1,
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:BKCU2Protection",x=47+43*5,y=78,radius=20,tooltip="",model = {
            model = "models/addon_buttons/red_button.mdl",scale=1,z=0.8,
            var="BKCU2",speed=12,vmin=0,vmax=0.6,
			lamp = {model = "models/addon_buttons/lamp_red.mdl",var="",z=2, anim=true, },
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:BKCU2KToggle",x=242,y=84,w=40,h=10,tooltip="Крышка кнопки БКЦУ 2",model = {
            var="BKCU2K",speed=4,min=0.33,max=0.72,disable="2:BKCU2Protection",
            model = "models/metrostroi_train/81-5402/krishka.mdl",scale=1.05,ang=180,z=6.4,
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["ECRSScreen"] = {
    pos = Vector(453.01,-22.55,11.1),
    ang = Angle(0,-112.8,90),
    width = 57,
    height = 44,
    scale = 0.014,
    hideseat=0.2,
}
ENT.ButtonMap["Motorolla"] = {
    pos = Vector(453.8,-20.2,11.6),
    ang = Angle(0,-112.8,90),
    width = 180,
    height = 60,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
		{ID = "!LPM", x=174.2, y=30.3, radius=5, tooltip="Лампа питания Мотороллы", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",scale=1,ang = Angle(0,0,0),z=-4.1,color = Color(45,255,45), var="MTGreen"}
        }},
        {ID = "!LPM2", x=174.2, y=30.3, radius=5, tooltip="Лампа питания Мотороллы", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",scale=1,ang = Angle(0,0,0),z=-4.1,color = Color(255,20,20), var="MTRed"}
        }},
		{ID = "MotorollaPodsvetka", x=89.5, y=31, radius=0, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-5402/light_ecrs_5p.mdl",scale=1.008,ang = Angle(90,293,180),z=0,var="MTLight"}
        }},
        {ID = "PRSPodsvetka", x=107.2, y=-48.5, radius=0, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-5402/rvclight_5p.mdl",scale=1.263,ang = Angle(90,180.2,180),z=5.8,var="RVSLight"}
        }},
		{ID = "ECRS_CancelSet",x=125, y=15, radius = 8, tooltip="Отмена/Вкл./Выкл.", model = {
			z=1,ang=Angle(-90,0,0),
			var = "ECRS_Cancel",speed=12,
		}},				
		{ID = "ECRS_BRTSet",x=165, y=50, radius = 4.5, tooltip="Яркость", model = {
			z=1,ang=Angle(-90,0,0),
			var = "ECRS_BRT",speed=12,
		}},
        --[[{ID = "ECRS_MuteSet",x=165-12, y=50, radius = 4.5, tooltip="Микр-н выкл.", model = {
            z=1,ang=Angle(-90,0,0),
            var = "ECRS_Mute",speed=12,
        }},
        {ID = "ECRS_upSet",x=117.2+11/2, y=25, radius = 3.5, tooltip="Вверх", model = {
            z=1,ang=Angle(-90,0,0),
            var = "ECRS_up",speed=12,
        }},]]
        {ID = "ECRS_F1Set",x=112, y=18.5, radius = 4.5, tooltip="Отмена", model = {
            z=1,ang=Angle(-90,0,0),
            var = "ECRS_F1",speed=12,
        }}, 
        {ID = "ECRS_F2Set",x=112, y=18.5+25, radius = 4,5, tooltip="Выбор", model = {
            z=1,ang=Angle(-90,0,0),
            var = "ECRS_F2",speed=12,
        }}, 
        --[[{ID = "ECRS_downSet",x=117.2+11/2, y=30.5+5.5, radius = 3.5, tooltip="Вниз", model = {
            z=1,ang=Angle(-90,0,0),
            var = "ECRS_down",speed=12,
        }}, ]]
        {ID = "ECRS_leftSet",x=117.2, y=30.5, radius = 3.5, tooltip="Влево", model = {
            z=1,ang=Angle(-90,0,0),
            var = "ECRS_left",speed=12,
        }}, 
        --[[{ID = "ECRS_MenuSet",x=117.2-7, y=30.5, radius = 3.5, tooltip="Меню", model = {
            z=1,ang=Angle(-90,0,0),
            var = "ECRS_Menu",speed=12,
        }}, ]]
        {ID = "ECRS_rightSet",x=117.2+11, y=30.5, radius = 3.5, tooltip="Вправо", model = {
            z=1,ang=Angle(-90,0,0),
            var = "ECRS_right",speed=12,
        }}, 
        --[[{ID = "ECRS_1Set",x=143+10*0, y=12, radius = 4, tooltip="1", model = {
            z=1,ang=Angle(-90,0,0),
            var = "ECRS_1",speed=12,
        }}, 
		{ID = "ECRS_2Set",x=143+10*1, y=12, radius = 4, tooltip="2", model = {
			z=1,ang=Angle(-90,0,0),
			var = "ECRS_2",speed=12,
		}},	
		{ID = "ECRS_3Set",x=143+10*2, y=12,radius = 4, tooltip="3", model = {
			z=1,ang=Angle(-90,0,0),
			var = "ECRS_3",speed=12,
		}},	
		{ID = "ECRS_4Set",x=143+10*0, y=12+9*1, radius = 4, tooltip="4", model = {
			z=1,ang=Angle(-90,0,0),
			var = "ECRS_4",speed=12,
		}},	
		{ID = "ECRS_5Set",x=143+10*1, y=12+9*1, radius = 4, tooltip="5", model = {
			z=1,ang=Angle(-90,0,0),
			var = "ECRS_5",speed=12,
		}},	
		{ID = "ECRS_6Set",x=143+10*2, y=12+9*1, radius = 4, tooltip="6", model = {
			z=1,ang=Angle(-90,0,0),
			var = "ECRS_6",speed=12,
		}},	
		{ID = "ECRS_7Set",x=143+10*0, y=12+9*2, radius = 4, tooltip="7", model = {
			z=1,ang=Angle(-90,0,0),
			var = "ECRS_7",speed=12,
		}},	
		{ID = "ECRS_8Set",x=143+10*1, y=12+9*2, radius = 4, tooltip="8", model = {
			z=1,ang=Angle(-90,0,0),
			var = "ECRS_8",speed=12,
		}},	
		{ID = "ECRS_9Set",x=143+10*2, y=12+9*2, radius = 4, tooltip="9", model = {
			z=1,ang=Angle(-90,0,0),
			var = "ECRS_9",speed=12,
		}},		
		{ID = "ECRS_0Set",x=143+10*1, y=12+9*3, radius = 4, tooltip="0", model = {
			z=1,ang=Angle(-90,0,0),
			var = "ECRS_0",speed=12,
		}},
        {ID = "ECRS_StarSet",x=143+10*0, y=12+9*3, radius = 4, tooltip="*", model = {
            z=1,ang=Angle(-90,0,0),
            var = "ECRS_Star",speed=12,
        }},
        {ID = "ECRS_SharpSet",x=143+10*2, y=12+9*3, radius = 4, tooltip="#", model = {
            z=1,ang=Angle(-90,0,0),
            var = "ECRS_Sharp",speed=12,
        }},]]
    }
}

ENT.ButtonMap["Block3"] = {
    pos = Vector(453.3,-14.4,6.5),
    ang = Angle(0,-118,66),
    width = 320,
    height = 120,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "!BLTLPressure", x=59, y=68, radius=40, tooltip="Давление в напорной(белая стрелка) и тормозной(красная стрелка) магистралях"},
        {ID = "!BCPressure", x=148, y=68, radius=40, tooltip="Давление в тормозных цилиндрах"},
		{ID = "2:VADToggle",x=285,y=30,radius=20,tooltip="ВАД: Выключатель аварийных дверей",model = {
            model = "models/metrostroi_train/81-5402/tumbler_5p.mdl",scale=1,z=1.3,ang=90,
            var="VAD",speed=5, min=0.13,max=0.38,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",scale=0.8,ang=70,x=21.5,y=-3.4,z=-2,var="VADPl",ID="VADPl",},
            sndvol = 1,snd = function(val) return val and "multiswitch_panel_mid" or "multiswitch_panel_mid" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},		
		{ID = "2:VAHToggle",x=285,y=80.5,radius=20,tooltip="ВАХ: Выключатель аварийного хода",model = {
            model = "models/metrostroi_train/81-5402/tumbler_5p.mdl",scale=1,z=2.1,ang=90,
            var="VAH",speed=5, min=0.13,max=0.38,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",scale=0.8,ang=70,x=21.5,y=-3.4,z=-2,var="VAHPl",ID="VAHPl",},
            sndvol = 1,snd = function(val) return val and "multiswitch_panel_mid" or "multiswitch_panel_mid" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:OVTToggle",x=235,y=30,radius=20,tooltip="ОВТ: Отключение вентильных тормозов",model = {
            model = "models/metrostroi_train/81-5402/tumbler_5p.mdl",scale=1,z=1.5,ang=90,
            var="OVT",speed=5, min=0.38,max=0.13,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",scale=0.8,ang=140,x=-27,y=1,z=-2,var="OVTPl",ID="OVTPl",},
            sndvol = 1,snd = function(val) return val and "multiswitch_panel_mid" or "multiswitch_panel_mid" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:OtklAVUToggle",x=236,y=79,radius=20,tooltip="ОАВУ: Тумблер отключения АВУ",model = {
            model = "models/metrostroi_train/81-5402/tumbler_5p.mdl",scale=1,z=1.5,ang=90,
            var="OtklAVU",speed=5, min=0.38,max=0.13,
			lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",scale=0.55,x=-18.6,y=-16.3,z=-3,color = Color(255,45,45),var="AVU"},
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",scale=0.8,ang=140,x=-27,y=1,z=-2,var="OtklAVUPl",ID="OtklAVUPl",},
            sndvol = 1,snd = function(val) return val and "multiswitch_panel_mid" or "multiswitch_panel_mid" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}

-- Front panel
ENT.ButtonMap["PUAVN"] = {
    pos = Vector(445.5,30,7),
    ang = Angle(0,-64.5,73.1),
    width = 260,
    height = 185,
    scale = 0.056,
    hideseat=0.2,

    buttons = {
        {ID = "!PU",x=68.6 ,y=99.8,w=3,h=3,model = {
            name="BURPower",lamp = {speed=24,model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",scale=0.45,color=Color(175,250,20),z=23.2,var="BURPower"},
        }},
		{ID = "LIB",x=68.7 ,y=87.7,w=3,h=3,model = {
            name="LIB",lamp = {speed=24,model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",scale=0.45,color=Color(175,250,20),z=23.2,var="VB"},
        }},
		{ID = "!K16",x=25.76,y=35.8,w=10,h=10,tooltip="",model = {
            name="PUKI",lamp = {speed=10,model = "models/metrostroi_train/81-5402/light5p.mdl",scale=0.495,ang = Angle(90,-90,0),z=4.2,var="PUK16"}, --PUK16
        }},
        {ID = "!OS",x=25.76,y=35.7+16.4*1,w=10,h=10,tooltip="",model = {
            name="PUOS",lamp = {speed=10,model = "models/metrostroi_train/81-5402/light5p.mdl",skin=1,scale=0.49,ang = Angle(90,-90,0),z=4.2,var="PUOS"}, --PUOS
        }},
        {ID = "!AVT",x=25.76,y=35.7+16.15*2,w=10,h=10,tooltip="",model = {
            name="PUAVT",lamp = {speed=10,model = "models/metrostroi_train/81-5402/light5p.mdl",skin=2,scale=0.495,ang = Angle(90,-90,0),z=4.2,var="PUAVT"}, --PUAVT
        }},
        {ID = "!LRS",x=25.76,y=35.7+16.1*3,w=10,h=10,tooltip="",model = {
            name="PULRS",lamp = {speed=10,model = "models/metrostroi_train/81-5402/light5p.mdl",skin=2,scale=0.495,ang = Angle(90,-90,0),color=Color(50,180,50),z=4.2,var="PULRS"}, --PULRS
        }},
        {ID = "!KI1",x=25.76,y=35.7+16.3*4,w=10,h=10,tooltip="",model = {
            name="PUKI1",lamp = {speed=10,model = "models/metrostroi_train/81-5402/light5p.mdl",skin=1,scale=0.495,ang = Angle(90,-90,0),z=4.2,var="PUKI1"}, --PUKI1
        }},
        {ID = "!KI2",x=25.76,y=35.7+16.35*5,w=10,h=10,tooltip="",model = {
            name="PUKI2",lamp = {speed=10,model = "models/metrostroi_train/81-5402/light5p.mdl",skin=1,scale=0.495,ang = Angle(90,-90,0),z=4.2,var="PUKI2"}, --PUKI2
        }},		
        {ID = "KHSet",x=83.5,y=153,radius=20,tooltip="КХ3: Кнопка включения режима Ход 3 от системы автоведения",model = {
            model = "models/addon_buttons/black_button.mdl",z=1,
            var="KH",speed=16,vmin=0,vmax=0.35,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button1_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "VAVToggle",x=147.5,y=153,radius=20,tooltip="ВАВ: Выключатель автоведения",model = {
            model = "models/metrostroi_train/81-5402/tumbler_5p.mdl",scale=1,z=2.1,ang=90,
            var="VAV",speed=8.2, min=0.13,max=0.38,
            sndvol = 1,snd = function(val) return val and "multiswitch_panel_mid" or "multiswitch_panel_mid" end,
            labels={{model="models/metrostroi_train/81-717/labels/label_717_plane.mdl",skin=18,ang=Angle(-90,90,0),z=0,x=-137,y=-5,scale=1.5}}
        }},
    }
}
ENT.ButtonMap["PUAVN_RL"] = {
    pos = Vector(449.75,20.3,5.3),
    ang = Angle(0.4,-64.3,70.4),
    width = 25,
    height = 110,
    scale = 0.056,
    hideseat=0.2,

    buttons = {
        {ID = "!ARSOch",x=7.9,y=5,w=10,h=10,tooltip="",model = {
            name="PUOCh",lamp = {speed=10,model = "models/metrostroi_train/81-5402/light5p.mdl",skin=1,scale=0.495,ang = Angle(90,-90,0),z=4.2,var="PU04"}, --PU04
        }},
        {ID = "!ARS0",x=7.9,y=5+16.4*1,w=10,h=10,tooltip="",model = {
            name="PU0",lamp = {speed=10,model = "models/metrostroi_train/81-5402/light5p.mdl",skin=1,scale=0.495,ang = Angle(90,-90,0),z=4.2,var="PU0"}, --PU0
        }},
        {ID = "!ARS40",x=7.9,y=5.2+16.15*2,w=10,h=10,tooltip="",model = {
            name="PU40",lamp = {speed=10,model = "models/metrostroi_train/81-5402/light5p.mdl",scale=0.495,ang = Angle(90,-90,0),z=4.2,var="PU40"}, --PU40
        }},
        {ID = "!ARS60",x=7.9,y=5.4+16.1*3,w=10,h=10,tooltip="",model = {
            name="PU60",lamp = {speed=10,model = "models/metrostroi_train/81-5402/light5p.mdl",skin=2,scale=0.495,ang = Angle(90,-90,0),color=Color(50,180,50),z=4.2,var="PU60"}, --PU60
        }},
        {ID = "!ARS70",x=7.9,y=5.1+16.3*4,w=10,h=10,tooltip="",model = {
            name="PU70",lamp = {speed=10,model = "models/metrostroi_train/81-5402/light5p.mdl",skin=2,scale=0.495,ang = Angle(90,-90,0),color=Color(50,180,50),z=4.2,var="PU70"}, --PU70
        }},
        {ID = "!ARS80",x=7.9,y=4.7+16.35*5,w=10,h=10,tooltip="",model = {
            name="PU80",lamp = {speed=10,model = "models/metrostroi_train/81-5402/light5p.mdl",skin=2,scale=0.495,ang = Angle(90,-90,0),color=Color(50,180,50),z=4.2,var="PU80"}, --PU80
        }},
    }
}
ENT.ButtonMap["PUAVNScreen"] = {
    pos = Vector(445.24,25.93,4.93),
    ang = Angle(0,-65.7,72.2),
    width = 512,
    height = 128,
    scale = 0.0115,
    hideseat=0.2,
    hide=true,
}
ENT.ButtonMap["pultlight"] = {
    pos = Vector(448.8,13,5.9),
    ang = Angle(0,-125,80),
    width = 60,
    height = 60,
    scale = 0.0625,
	
	buttons = {{ID = "L_3Toggle",x=35,y=15,radius=25,tooltip="Подсветка пульта"}}
}	
ENT.ButtonMap["Block2"] = {
    pos = Vector(447,9.5,6.5),
    ang = Angle(0,-90,72),
    width = 310,
    height = 175,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "!Speedometer1",x=132.2,y=26,w=17,h=25,tooltip="",model = {
            name="SSpeed2",model = "models/metrostroi_train/81-717/segments/segment_spb.mdl",scale=0.85,color=Color(175,250,20),skin=6,z=-0.4,ang=Angle(0,0,-90),
        }},
        {ID = "!Speedometer2",x=147.6,y=26,w=17,h=25,tooltip="",model = {
            name="SSpeed1",model = "models/metrostroi_train/81-717/segments/segment_spb.mdl",scale=0.85,color=Color(175,250,20),skin=1,z=-0.4,ang=Angle(0,0,-90),
        }},

        {ID = "!ARSOch",x=97,y=30,w=10,h=10,tooltip="",model = {
            name="SAOCh",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ra.mdl",scale=0.9,z=-1,var="AR04"},
        }},
        {ID = "!ARS0",x=87,y=30+10*0,w=10,h=10,tooltip="",model = {
            name="SA0",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ra.mdl",scale=0.9,z=-1,var="AR0"},
        }},
        {ID = "!ARS40",x=87,y=30+10*1,w=10,h=10,tooltip="",model = {
            name="SA40",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",scale=0.9,z=-1,var="AR40"},
        }},
        {ID = "!ARS60",x=87,y=30+10*2,w=10,h=10,tooltip="",model = {
            name="SA60",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",scale=0.9,z=-1,color=Color(175,250,20),var="AR60"},
        }},
        {ID = "!ARS70",x=87,y=30+9.8*3,w=10,h=10,tooltip="",model = {
            name="SA70",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",scale=0.9,z=-1,color=Color(175,250,20),var="AR70"},
        }},
        {ID = "!ARS80",x=87,y=30+9.8*4,w=10,h=10,tooltip="",model = {
            name="SA80",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",scale=0.9,z=-1,color=Color(175,250,20),var="AR80"},
        }},

        {ID = "!LampLSD1",x=180.0,y=31.5,w=10,h=4,tooltip="",model = {
            name="SSD1",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",scale=0.9,z=-0.5,color=Color(175,250,20),var="SD"},
        }},
        {ID = "!LampLSD2",x=188,0,y=31.5,w=10,h=4,tooltip="",model = {
            name="SSD2",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",scale=0.9,z=-0.5,ang=90,color=Color(175,250,20),var="SD"},
        }},

        {ID = "!LampLVD",x=179.7,y=40.2+8*0,w=10,h=4,tooltip="",model = {
            name="SVD",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",scale=0.9,z=-1,var="A04",color=Color(175,250,20),var="VD"},
        }},
        {ID = "!LampLHRK",x=179.7,y=40.2+8*1,w=10,h=4,tooltip="",model = {
            name="SRK",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",scale=0.9,z=-1,var="HRK"},
        }},
        {ID = "!LampLST",x=179.7,y=40.2+8*2,w=10,h=4,tooltip="",model = {
            name="SST",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",scale=0.9,z=-1,var="ST"},
        }},
        {ID = "!LampLRD",x=179.7,y=40.2+8*3,w=10,h=4,tooltip="",model = {
            name="SRD",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",scale=0.9,z=-1,color=Color(175,250,20),var="LRD"},
        }},


        {ID = "!LampRP",x=196.8,y=40.3+8*0,w=10,h=4,tooltip="",model = {
            name="SRP",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_rb.mdl",scale=0.9,z=-1,var="RP"},
        }},
        {ID = "!LampLSN",x=204.8,y=40.3+8*0,w=10,h=4,tooltip="",model = {
            name="SSN",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_rb.mdl",scale=0.9,z=-1,ang=-90,var="SN"},
        }},

        {ID = "!LampLKVD",x=204.8,y=40.3+8*1,w=10,h=4,tooltip="",model = {
            name="SKVD",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",scale=0.9,z=-1,var="KVD"},
        }},
        {ID = "!LampLKT",x=204.8,y=40.3+8*2,w=10,h=4,tooltip="",model = {
            name="SKT",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",scale=0.9,z=-1,var="KT"},
        }},
        {ID = "!LampDV",x=204.8,y=40.3+8*3,w=10,h=4,tooltip="",model = {
            name="SDV",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",scale=0.9,z=-1,color=Color(175,250,20),var="DV"},
        }},
		{ID = "!UAVATriggered", x=280.7, y=17, radius=10, tooltip="Размыкание контактов УАВА", model = {
            lamp = {model = "models/metrostroi_train/81-5402/light5p.mdl",skin=1,scale=0.5,ang = Angle(90,-90,0),z=5.75,color = Color(255,255,255), var="UAVATriggered"}
        }},
		{ID = "!PNT", x=280.7, y=18.5+13*1, radius=10, tooltip="Лампа пневмотормоза в составе", model = {
            lamp = {model = "models/metrostroi_train/81-5402/light5p.mdl",scale=0.5,ang = Angle(90,-90,0),z=5.75,color = Color(255,255,255), var="PN"}
        }},
		{ID = "!NMPressureLow", x=280.7, y=18.5+14*2, radius=10, tooltip="Низкое давление в НМ", model = {
            lamp = {model = "models/metrostroi_train/81-5402/light5p.mdl",skin=1,scale=0.5,ang = Angle(90,-90,0),z=5.75,color = Color(255,255,255), var="NMLow"}
        }},
		{ID = "!OhSigLampP", x=280.7, y=18.5+14*3, radius=10, tooltip="Охранная сигнализация", model = {
            lamp = {model = "models/metrostroi_train/81-5402/light5p.mdl",skin=2,scale=0.5,ang = Angle(90,-90,0),z=5.75,color = Color(255,255,255), var="OhSigLamp"}
        }},
		{ID = "!ABVoltageLow", x=280.7, y=18.5+14*4, radius=10, tooltip="Низкое напряжение АБ", model = {
            lamp = {model = "models/metrostroi_train/81-5402/light5p.mdl",skin=1,scale=0.5,ang = Angle(90,-90,0),z=5.75,color = Color(255,255,255), var="ABLow"}
        }},
		{ID = "!VZ1L", x=280.7, y=18.5+14.25*5, radius=10, tooltip="Вентиль замещения 1", model = {
            lamp = {model = "models/metrostroi_train/81-5402/light5p.mdl",scale=0.5,ang = Angle(90,-90,0),z=5.75,color = Color(255,255,255), var="VZ1L"}
        }},
		{ID = "!VZ2L", x=280.7, y=18.5+14.35*6, radius=10, tooltip="Вентиль замещения 2", model = {
            lamp = {model = "models/metrostroi_train/81-5402/light5p.mdl",scale=0.5,ang = Angle(90,-90,0),z=5.75,color = Color(255,255,255), var="VZ2L"}
        }},
		{ID = "BPSNSwitchToggle",x=122.8,y=139.5,radius=0,tooltip="Блок питания",model = {
            model = "models/metrostroi_train/81-5402/tumbler_5p.mdl",scale=1,z=5,ang=90,
			getfunc = function(ent) return ent:GetPackedRatio("BPSNSwitch") end, var="BPSNSwitch",
			speed=4,min=0.14,max=0.39,
			lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",scale=0.5,x=15.6,y=-18.7,z=-6.4,color = Color(0,255,0),var="LKVP"},
            sndvol = 1,snd = function(val) return val and "multiswitch_panel_mid" or "multiswitch_panel_mid" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
		{ID="BPSNSwitch+",x=122.8, y=130, w=20,h=30, tooltip="Блок питания: +"},
		{ID="BPSNSwitch-",x=102.8, y=130, w=20,h=30, tooltip="Блок питания: -"},
		{ID = "!LKVPR", x=122.8-15.6, y=140-19.4, radius=0, tooltip="", model = {
			lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_big_502.mdl",scale=0.55,ang = Angle(0,0,0),z=-1.8,color = Color(255,0,0),var="LKVPR"}
        }},
		{ID = "2:ConverterProtectionSet",x=170,y=139.5,radius=20,tooltip="Кнопка возврата защиты преобразователя",model = {
            model = "models/addon_buttons/red_button.mdl",scale=1,z=1,
            var="ConverterProtection",speed=12,vmin=0,vmax=0.6,
			lamp = {model = "models/addon_buttons/lamp_red.mdl",var="RZP",z=2, anim=true, },
            sndvol = 0.2,snd = function(val) return val and "button_on" or "button_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
		{ID = "2:ARSToggle",x=220,y=138,radius=20,tooltip="АРС: Выключатель системы АРС",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=0,
            var="ARS",speed=16,
            sndvol = 1,snd = function(val) return val and "tumbler_5P_on" or "tumbler_5P_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:ALSToggle",x=270,y=138,radius=20,tooltip="АЛС: Выключатель АЛС",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=0,
            var="ALS",speed=16,
            sndvol = 1,snd = function(val) return val and "tumbler_5P_on" or "tumbler_5P_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},	
		{ID = "!EnginesCurrent",x=35,y=143,tooltip="Ток на тяговом двигателе (А)",radius=20},
        {ID = "!EnginesVoltage",x=77,y=143,tooltip="Напряжение на контактном рельсе (В)",radius=20},

    }
}
ENT.ClientProps["Pakost"] = {
    model = "models/metrostroi_train/81-5402/pam_5p.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ButtonMap["PAM1"] = {
    pos = Vector(443.85,29.24,6.28),
    ang = Angle(0,-63,73),
    width = 40,
    height = 135,
    scale = 0.075,
    hideseat=0.2,

    buttons = {

        {ID = "PAMPSet",x=6.5+13.45*1.82,y=19.6,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_p.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_p.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAMP",speed=16,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
        }},

        {ID = "PAMFSet",x=3.6+13.45*0,y=42+14*0,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_f.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_f.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAMF",speed=16,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
        }},
        {ID = "PAMUpSet",x=3.6+13.45*1,y=42+14*0,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_up.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_up.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAMUp",speed=16,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
        }},
        {ID = "PAMMSet",x=4+13.45*2,y=42+14*0,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_m.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_m.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAMM",speed=16,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
        }},
        {ID = "PAMLeftSet",x=3.5+13.45*0,y=40+13*1,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_left.mdl",ang = 0,z=2.65,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_left.mdl",z=-0.2-2.3,anim=true,var="PAPower" },
            var="PAMLeft",speed=16,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
        }},
        {ID = "PAMDownSet",x=3.5+13.45*1,y=40+13*1,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_down.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_down.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAMDown",speed=16,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
        }},
        {ID = "PAMRightSet",x=4+13.45*2,y=40+13*1,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_right.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_right.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAMRight",speed=16,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
        }},


        {ID = "PAM1Set",x=3.5+13.45*0,y=73+12.9*0,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_1.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_1.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM1",speed=16,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
        }},
        {ID = "PAM2Set",x=3.6+13.45*1,y=73+12.9*0,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_2.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_2.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM2",speed=16,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
        }},
        {ID = "PAM3Set",x=4+13.45*2,y=73+12.9*0,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_3.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_3.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM3",speed=16,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
        }},
        {ID = "PAM4Set",x=3.5+13.45*0,y=71+12.9*1,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_4.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_4.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM4",speed=16,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
        }},
        {ID = "PAM5Set",x=3.6+13.45*1,y=71+12.9*1,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_5.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_5.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM5",speed=16,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
        }},
        {ID = "PAM6Set",x=4+13.45*2,y=71+12.8*1,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_6.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_6.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM6",speed=16,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
        }},
        {ID = "PAM7Set",x=3.5+13.45*0,y=68.6+12.9*2,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_7.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_7.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM7",speed=16,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
        }},
        {ID = "PAM8Set",x=3.6+13.4*1,y=68.6+12.9*2,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_8.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_8.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM8",speed=16,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
        }},
        {ID = "PAM9Set",x=4+13.45*2,y=68.6+12.9*2,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_9.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_9.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM9",speed=16,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
        }},
        {ID = "PAMEscSet",x=3.6+13.45*0,y=66.5+12.9*3,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_esc.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_esc.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAMEsc",speed=16,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
        }},
        {ID = "PAM0Set",x=4+13*1,y=66.6+12.9*3,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_0.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_0.mdl",z=-0.2,anim=true,var="PAPower" },
            var="PAM0",speed=16,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
        }},
        {ID = "PAMEnterSet",x=4+13.45*2,y=66.5+12.9*3,radius=8,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons_pam/pam_enter.mdl",ang = 0,z=0,
            lamp = {speed=12,model = "models/metrostroi_train/81-717/buttons_pam/pamlamp_enter.mdl",z=2.4,anim=true,var="PAPower" },
            var="PAMEnter",speed=16,
            sndvol = 0.2, snd = function(val) return val and "button_on" or "button_off" end,
        }},
    }
}
ENT.ButtonMap["PAMScreen"] = {
    pos = Vector(447.07,25.15,4.86),
    ang = Angle(-1,-65,73),
    width = 640,
    height = 480,
    scale = 0.025/1.87,
    sensor = true,
    system = "PAM",

    hideseat=0.2,
    hide=true,
}
local plombed = {A41Toggle=true,AISToggle=true}

ENT.ButtonMap["AV_R"] = {
    pos = Vector(398.5+11,-52.9+0.75,37.1),
    ang = Angle(0,90,90),
    width = 398,
    height = 358,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "A11Toggle",x=29.3*0,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A17Toggle",x=29.3*1,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A44Toggle",x=29.3*2,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A58Toggle",x=29.3*3,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A59Toggle",x=29.3*4,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A61Toggle",x=29.3*5,y=154*0,w=25,h=45,tooltip=""},
        {ID = "P:A58Toggle",x=29.3*3,y=154*0,w=25,h=45,tooltip=""},
        {ID = "P:A59Toggle",x=29.3*4,y=154*0,w=25,h=45,tooltip=""},
        {ID = "P:A61Toggle",x=29.3*5,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A21Toggle",x=29.3*6,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A49Toggle",x=29.3*7,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A27Toggle",x=29.3*8,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A10Toggle",x=29.3*9,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A53Toggle",x=29.3*10,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A54Toggle",x=29.3*11,y=154*0,w=25,h=45,tooltip=""},
        {ID = "A84Toggle",x=29.3*12,y=154*0,w=25,h=45,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "A76Toggle",x=29.3*0,y=154*1,w=25,h=45,tooltip="А76: Пожарная сигнализация"},
        {ID = "A48Toggle",x=29.3*1,y=154*1,w=25,h=45,tooltip=""},
        {ID = "ABKToggle",x=29.3*2,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A29Toggle",x=29.3*3,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A46Toggle",x=29.3*4,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A47Toggle",x=29.3*5,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A43Toggle",x=29.3*6,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A42Toggle",x=29.3*7,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A74Toggle",x=29.3*8,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A73Toggle",x=29.3*9,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A71Toggle",x=29.3*10,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A41Toggle",x=29.3*11,y=154*1,w=25,h=45,tooltip=""},
        {ID = "A45Toggle",x=29.3*12,y=154*1,w=25,h=45,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "A75Toggle",x=29.3*0,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A8Toggle",x=29.3*1,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A52Toggle",x=29.3*2,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A72Toggle",x=29.3*3,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A31Toggle",x=29.3*4,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A32Toggle",x=29.3*5,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A13Toggle",x=29.3*6,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A1Toggle",x=29.3*7,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A20Toggle",x=29.3*8,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A25Toggle",x=29.3*9,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A30Toggle",x=29.3*10,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A56Toggle",x=29.3*11,y=154*2,w=25,h=45,tooltip=""},
        {ID = "A65Toggle",x=29.3*12,y=154*2,w=25,h=45,tooltip=""},
    }
}
for i,button in pairs(ENT.ButtonMap.AV_R.buttons) do
    button.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",z=-25,
        var=button.ID:gsub("Toggle",""):gsub("[^:]+:",""),speed=8,
        sndvol = 0.8,snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
    }
    if plombed[button.ID] then
        button.model.plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=Angle(0,25,45),x=19,y=-30,z=24,var=button.ID:Replace("Toggle","Pl"), ID=button.ID:Replace("Toggle","Pl"),}
    end
end
ENT.ButtonMap["AV_S"] = {
    pos = Vector(390.4,15,-25),
    ang = Angle(0,270,90),
    width = 275,
    height = 165,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "A2Toggle",x=25*0,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A3Toggle",x=25*1,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A4Toggle",x=25*2,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A5Toggle",x=25*3,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A6Toggle",x=25*4,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A70Toggle",x=25*5,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A14Toggle",x=25*6,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A39Toggle",x=25*7,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A28Toggle",x=25*8,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A38Toggle",x=25*9,y=60*0,w=25,h=45,tooltip=""},
        {ID = "A22Toggle",x=25*10,y=60*0,w=25,h=45,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "A12Toggle",x=25*0,y=60*1,w=25,h=45,tooltip=""},
        {ID = "A16Toggle",x=25*1,y=60*1,w=25,h=45,tooltip=""},
        {ID = "A37Toggle",x=25*2,y=60*1,w=25,h=45,tooltip=""},
        {ID = "A51Toggle",x=25*3,y=60*1,w=25,h=45,tooltip=""},
        {ID = "A24Toggle",x=25*4,y=60*1,w=25,h=45,tooltip=""},
        {ID = "A19Toggle",x=25*5,y=60*1,w=25,h=45,tooltip=""},
        {ID = "A18Toggle",x=25*7,y=60*1,w=25,h=45,tooltip=""},
        {ID = "A40Toggle",x=25*8,y=60*1,w=25,h=45,tooltip=""},
        {ID = "A15Toggle",x=25*9,y=60*1,w=25,h=45,tooltip=""},
        {ID = "A50Toggle",x=25*10,y=60*1,w=25,h=45,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "AISToggle",x=25*2,y=60*2,w=25,h=45,tooltip=""},
        {ID = "AV3Toggle",x=25*3,y=60*2,w=25,h=45,tooltip=""},
        {ID = "AV1Toggle",x=25*4,y=60*2,w=25,h=45,tooltip=""},
        {ID = "A55Toggle",x=25*5,y=60*2,w=25,h=45,tooltip=""},
        {ID = "A57Toggle",x=25*6,y=60*2,w=25,h=45,tooltip=""},
        {ID = "A60Toggle",x=25*7,y=60*2,w=25,h=45,tooltip=""},
        {ID = "A7Toggle",x=25*8,y=60*2,w=25,h=45,tooltip=""},
        {ID = "A9Toggle",x=25*9,y=60*2,w=25,h=45,tooltip=""},
    }
}
for i,button in pairs(ENT.ButtonMap.AV_S.buttons) do
    button.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",z=-25,
        var=button.ID:Replace("Toggle",""),speed=8,
        sndvol = 0.8,snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
    }
    if plombed[button.ID] then
        button.model.plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=Angle(0,45,90),x=0,y=-37,z=32,var=button.ID:Replace("Toggle","Pl"), ID=button.ID:Replace("Toggle","Pl"),}
    end
end
ENT.ButtonMap["Battery_R"] = {
    pos = Vector(410.0,-54.25,9),
    ang = Angle(0,90,90),
    width = 440,
    height = 157,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "2:RC1Toggle",x=142,y=80,radius=40,tooltip="РЦ-1: Разъединитель цепей АРС",model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_rc1.mdl",z=17,ang=180,
			labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=11,scale=2,ang=90,z=-18,x=1,y=-52.5},},
            var="RC1",speed=0.5,vmin=1,vmax=0.87,
            plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=230,x=-28,y=28,var="RC1Pl",ID="RC1Pl",z=-15,},
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:VBToggle",x=376,y=45,radius=40,tooltip="ВБ: Выключатель батарей",model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_vb.mdl",z=17,ang=180,
			labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=3,scale=2,ang=90,z=-18,x=1,y=52.5},},
            var="VB",speed=0.5,vmin=1,vmax=0.87,
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:RC2Toggle",x=220,y=45,radius=40,tooltip="РЦ-2: Разъединитель цепей системы автоведения",model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_rc2.mdl",z=17,ang=180,
			labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=13,scale=2,ang=90,z=-18,x=1,y=52.5},},
            var="RC2",speed=0.5,vmin=1,vmax=0.87,
            plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=230,x=-28,y=28,var="RC2Pl",ID="RC2Pl",z=-15,},
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:VAUToggle",x=298,y=80,radius=40,tooltip="ВАУ: Выключатель системы автоведения",model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_rcvay.mdl",z=17,ang=180,
			labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=15,scale=2,ang=90,z=-18,x=1,y=-52.5},},
            var="VAU",speed=0.5,vmin=1,vmax=0.87,
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:VRDToggle",x=64,y=45,radius=25,tooltip="ВРД: Выключатель разрешающий движение под запрещающую частоту",model = {
            model = "models/metrostroi_train/81-5402/breaker_vrd.mdl",z=17,ang=270,
			labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=2,scale=2,ang=90,z=-18,x=1,y=52.5},},
            var="VRD",speed=0.8,vmin=1,vmax=0.79,
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["SOSD_R"] = {
    pos = Vector(395,-18.5,40),
    ang = Angle(0,90,90),
    width = 100,
    height = 136,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "2:VSOSDToggle",x=0, y=0, w=100, h=136,tooltip="",model = {
            model = "models/metrostroi_train/equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=14,ang=90,z=20.9,x=0,y=-12.5}},
            var="VSOSD",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["Kondey"] = {
    pos = Vector(395.85,-9,38.6),
    ang = Angle(0,90,90),
    width = 110,
    height = 70,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "KondeyNumber1", x=41, y=12.8, radius=0, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-722/digits/digit.mdl",skin=2,scale=1.5,ang = Angle(0,0,90),z=0,color = Color(255,5,5), var="KNL"}
        }},
		{ID = "KondeyNumber2", x=52, y=12.8, radius=0, tooltip="", model = {
            lamp = {model = "models/metrostroi_train/81-722/digits/digit.mdl",scale=1.5,ang = Angle(0,0,90),z=0,color = Color(255,5,5), var="KNL"}
        }},
		{ID = "PVKToggle",x=95,y=45,radius=20,tooltip="Включение кондиционера",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",scale=0.1,z=0,ang=-180,
            var="PVK",speed=8,
            sndvol = 0.6,snd = function(val) return val and "tumbler_5P_on" or "tumbler_5P_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}

-- Train driver helpers panel
ENT.ButtonMap["HelperPanel_C"] = {
    pos = Vector(445.85,62.6,18.7),
    ang = Angle(0,0,90),
    width = 76,
    height = 242,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
	    {ID = "VUD2Toggle",x=1,y=0,w=76,h=86,tooltip="ВУД2: Закрытие дверей со стороны помощника",model = {
            model = "models/metrostroi_train/switches/vudwhite.mdl",z=3,
            var="VUD2",speed=6,
            sndvol = 1,snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "VDLSet",x=1,y=90,w=76,h=86,tooltip="КДЛ: Открытие левых дверей",model = {
            model = "models/metrostroi_train/switches/vudwhite.mdl",z=3,
            var="VDL",speed=6,  min=0,max=0.50,
            sndvol = 1,snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "VOPDSet",x=38,y=210,radius=20,tooltip="Открытие правых дверей хвостового вагона",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = 17.5,
            var="VOPD",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button2_off" end,
            sndmin = 60,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["ParkingBrake"] = {
    pos = Vector(435,-25,-24.3),
    ang = Angle(0,30,-45),
    width = 200,
    height = 120,
    scale = 0.0625,

    buttons = {
        {ID = "ParkingBrakeToggle",x=0,y=0,w=200,h=120,tooltip="Стояночный тормоз",model = {
            var="ParkingBrake",sndid="parking_brake",
            sndvol = 1,snd = function(val) return "disconnect_valve" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ClientProps["reverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",scale=1,
    pos = Vector(438.9,23.6,-3.9),
    ang = Angle(0,220,0),
    hideseat=0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
ENT.ClientProps["krureverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = Vector(441,-32.2,-6.1),
    ang = Angle(0,-29,90),
    hideseat=0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}

-- UAVA
ENT.ButtonMap["UAVAPanel"] = {
    pos = Vector(432,-58,-10),
    ang = Angle(0,180,90),
    width = 180,
    height = 200,
    scale = 0.0625,

    buttons = {
        {ID = "UAVAToggle",x=0, y=0, w=60, h=200, tooltip="УАВА: Включение автоматического выключателя автостопа", model = {
            plomb = {var="UAVAPl", ID="UAVAPl",},
            var="UAVA",
            sndid="UAVALever",sndvol = 1, snd = function(val) return val and "uava_on" or "uava_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "UAVAContactSet",x=60, y=0, w=120, h=200, tooltip="Восстановление контактов УАВА"},
    }
}
ENT.ClientProps["UAVALever"] = {
    model = "models/metrostroi_train/81-703/cabin_uava.mdl",
    pos = Vector(431.0,-59.45,-18.4),
    ang = Angle(3,-180,0),
    hideseat=0.2,
}

ENT.ButtonMap["Stopkran"] = {
    pos = Vector(401,62,17),
    ang = Angle(0,0,90),
    width = 200,
    height = 1300,
    scale = 0.1/2,
    buttons = {
        {ID = "EmergencyBrakeValveToggle",x=0,y=0,w=200,h=1300,tooltip="Стоп-кран"},
    }
}
ENT.ClientProps["stopkran"] = {
    model = "models/metrostroi_train/81-5402/ezh3_stopkran.mdl",
    pos = Vector(408.6,62.15,11.6),
    ang = Angle(0,180,0),
    color=Color(255,30,30),
    hideseat=0.2,
}
ENT.ClientSounds["EmergencyBrakeValve"] = {{"stopkran",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ButtonMap["EPVDisconnect"] = {
    pos = Vector(430,-31,-28),
    ang = Angle(90,-150,90),
    width = 100,
    height = 100,
    scale = 0.0625,

    buttons = {
        {ID = "EPKToggle",x=0,y=0,w=200,h=120,tooltip="ЭПК: Электропневматический клапан АРС",model = {
            var="EPK"--,sndid="EPK_disconnect",
            --sndvol = 1,snd = function(val) return "disconnect_valve" end,
            --sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ClientProps["epv_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",scale=0.9,
    pos = ENT.ButtonMap["EPVDisconnect"].pos+Vector(1.8,-3.0,-8.4),
    ang = Angle(90,270,90),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
ENT.ClientSounds["EPK"] = {
    {"EPV_disconnect",function() return "disconnect_valve" end,1,1,90,1e3,Angle(-90,0,0)},
}
ENT.ClientProps["EPV_disconnect"] = {
    model = "models/metrostroi_train/81-5402/crane_epv_5p.mdl",
    pos = Vector(433.0,-34,-36.4),
    ang = Angle(120,90,0),
    hideseat=0.2,
}

ENT.ButtonMap["DriverValveDisconnect"] = {
    pos = Vector(432,-30,-20),
    ang = Angle(90,-150,90),
    width = 100,
    height = 90,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveDisconnectToggle",x=0,y=0,w=200,h=90,tooltip="Разобщительный кран крана машиниста",model = {
            var="DriverValveDisconnect",sndid="valve_disconnect",
            sndvol = 1,snd = function(val) return "disconnect_valve" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ClientProps["valve_disconnect"] = {
    model = "models/metrostroi_train/81-5402/crane_cab_5p.mdl",
    pos = Vector(433.6,-30.25,-29),
    ang = Angle(300,270,0),
    hideseat=0.2,
}
ENT.ButtonMap["CabPneumaticEndTM"] = {
    pos = Vector(410,-20,-8),
    ang = Angle(0,140,80),
    width = 100,
    height = 150,
    scale = 0.0625,
	
	buttons = {
	    {ID = "FrontBrakeLineIsolationToggle",x=000, y=0, w=100, h=150, tooltip="Концевой кран тормозной магистрали"},
	}
}
ENT.ButtonMap["CabPneumaticEndNM"] = {
    pos = Vector(398,19,-8),
    ang = Angle(0,90,90),
    width = 150,
    height = 150,
    scale = 0.0625,
	
	buttons = {
	    {ID = "FrontTrainLineIsolationToggle",x=000, y=0, w=150, h=150, tooltip="Концевой кран напорной магистрали"},
	}
}		
ENT.ClientProps["FrontBrake"] = {
    model = "models/metrostroi_train/81-710/ezh3_stopkran.mdl",color=Color(255,35,35),
    pos = Vector(406.75,-19.1,-16.6),
    ang = Angle(0,0,0),
    hide = 2,
}
ENT.ClientProps["FrontTrain"] = {--
    model = "models/metrostroi_train/81-5402/ezh3_stopkran.mdl",scale=1,color=Color(50,50,200),
    pos = Vector(396.5,25.2,-16.6),
    ang = Angle(0,180,0),
    hide = 2,
}
ENT.ClientSounds["FrontBrakeLineIsolation"] = {{"FrontBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["FrontTrainLineIsolation"] = {{"FrontTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}

ENT.ButtonMap["RearPneumatic"] = {
    pos = Vector(-473-1,45.0,-58.0+5),
    ang = Angle(0,270,90),
    width = 900,
    height = 100,
    scale = 0.1,
    hideseat=0.2,
    hide=true,
    screenHide = true,
    buttons = {
        {ID = "RearTrainLineIsolationToggle",x=500, y=0, w=400, h=100, tooltip=""},
        {ID = "RearBrakeLineIsolationToggle",x=000, y=0, w=400, h=100, tooltip=""},
    }
}
ENT.ClientProps["RearTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(-450-22, -34, -62),
    ang = Angle(-15,90,0),
    hide = 2,
}
ENT.ClientProps["RearBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(-450-22, 34, -62),
    ang = Angle( 15,90,0),
    hide = 2,
}
ENT.ClientSounds["RearBrakeLineIsolation"] = {{"RearBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["RearTrainLineIsolation"] = {{"RearTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}


ENT.ButtonMap["GV"] = {
    pos = Vector(170-3-9.5,50+20,-60+2),
    ang = Angle(0,225-15,90),
    width = 260,
    height = 260,
    scale = 0.1,
    buttons = {
        {ID = "GVToggle",x=0, y=0, w= 260,h = 260, tooltip="", model = {
            var="GV",sndid = "gv",
            sndvol = 0.8,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            snd = function(val) return val and "gv_f" or "gv_b" end,
        }},
    }
}
ENT.ClientProps["gv"] = {
    model = "models/metrostroi/81-717/gv.mdl",
    pos = Vector(153.5-3-9.5,36+20,-78+2),
    ang = Angle(-90,90,-90),
    color = Color(150,255,255),
    hide = 0.5,
}
ENT.ClientProps["gv_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["gv"].pos,
    ang = Angle(-90,0,0),
    hide = 0.5,
}


ENT.ClientProps["parking_brake"] = {
    model = "models/metrostroi_train/81-5402/crane_cab_5p.mdl",
    pos = Vector(445,-27.4,-24.3),
    ang = Angle(30,180,0),
	min=0,max=1,
    hideseat=0.2,
}


ENT.ButtonMap["AirDistributor"] = {
    pos = Vector(-185,-68,-50),
    ang = Angle(0,0,90),
    width = 170,
    height = 80,
    scale = 0.1,
    hideseat=0.1,
    hide=true,
    screenHide = true,

    buttons = {
        {ID = "AirDistributorDisconnectToggle",x=0,y=0,w= 170,h = 80,tooltip=""},
    }
}

for i=0,3 do
    ENT.ClientProps["TrainNumberL"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(43+i*6.4,67.2,-12),
        ang = Angle(0,180,0),
        skin=i,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
    ENT.ClientProps["TrainNumberR"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(64-i*6.4,-67.2,-12),
        ang = Angle(0,0,0),
        skin=i,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
	ENT.ClientProps["TrainNumberF"..i] = {
        model = "models/metrostroi_train/81-5402/5p_num_1.mdl",scale=1.05,
        pos = Vector(0,0,0),
        ang = Angle(6,9,0),
        --skin=i,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end

for i=1,3 do
    ENT.ClientProps["route_number"..i] = {
        model = "models/metrostroi_train/81-722/digits/digit.mdl",
        pos = Vector(456.3,46.15-(i-1)*0.5,0.2),
        ang = Angle(90,180,0),
        color=Color(255,5,5),
        hideseat=0.2,
    }
end
ENT.ButtonMap["RouteNumberSet"] = {
    pos = Vector(456.3,47,-0.5),
    ang = Angle(0,-90,90),
    width = 30,
    height = 10,
    scale = 0.085,
    buttons = {
        {ID = "RouteNumber1Set",x=0,y=0,w=10,h=10, tooltip="Первая цифра"},
        {ID = "RouteNumber2Set",x=10,y=0,w=10,h=10, tooltip="Вторая цифра"},
        {ID = "RouteNumber3Set",x=20,y=0,w=10,h=10, tooltip="Третья цифра"},
    }
}
ENT.ButtonMap["RouteNumber"] = {
    pos = Vector(459.5,33.8,3.3),
    ang = Angle(0,90,90),
    width = (7*8)*3+1*8*2,
    height = 14*8,
    scale = 0.23/4/(14/16),
	
	hide=2,
}

ENT.ButtonMap["CabinDoor"] = {
    pos = Vector(408,64,50),
    ang = Angle(0,0,90),
    width = 665,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoor",x=0,y=0,w=665,h=2000,tooltip="",model = {
            var="door2",sndid="door2",
            sndvol = 1,snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["Block7_AB"] = {
    pos = Vector(391.7,27.5,24),
    ang = Angle(0,180,90),
    width = 190,
    height = 280,
    scale = 0.1/2,
    hideseat=0.2,
    buttons = {
        {ID = "KRTDSet",x=100,y=200,radius=20,tooltip="Разблокировка торцевых дверей",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z=-10,
            var="KRTD",speed=16,vmin=1,vmax=0.6,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button2_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
		{ID = "KRTDKToggle",x=78,y=165,w=40,h=20,tooltip="Крышка кнопки разблокировки торцевых дверей",model = {
		    model = "models/metrostroi_train/81/krishka.mdl",ang=180,z=-12,
            var="KRTDK",speed=8,min=0.43,max=0.66,disable="KRTDSet",
			plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=-20,x=38,y=45,z=9,var="KRTDPl",ID="KRTDPl",},
            getfunc = function(ent) return ent:GetPackedBool("KRTDK") and 1 or ent.Anims.ARSRToggle and math.max(0,(ent.Anims.ARSRToggle.val-0.5)*2 or 0)^0.2*0.08 or 0 end,
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
		{ID = "!BatteryVoltage",x=140,y=60,tooltip="Напряжение на аккумуляторной батарее (В)",radius=45},
        {ID = "!BatteryCurrent",x=55,y=60,tooltip="Ток подзаряда на аккумуляторной батарее (А)",radius=45},
    }
}

ENT.ButtonMap["ASPSScreen"] = {
    pos = Vector(452.82,-53.882,17.257),
    ang = Angle(0,-135,90),
    width = 440,
    height = 106,
    scale = 0.01,
    hideseat=0.2,
}

ENT.ButtonMap["ASPSButtons"] = {
    pos = Vector(453.63,-53,20.5),
    ang = Angle(0,-135,90),
    width = 140,
    height = 136,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
		{ID = "!AO_Ready", x=60, y=21.75, radius=5, tooltip="Лампа готовности пожаротушения\nаппаратного отсека", model = { --Color(175,250,20)
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",scale=0.8,ang = Angle(0,0,0),z=-0.3,color = Color(45,255,45), var="AO_ReadyLamp"}
        }},
		{ID = "!AO_Fire", x=75.5, y=21.75, radius=5, tooltip="Лампа готовности пожаротушения\nаппаратного отсека", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",scale=0.8,ang = Angle(0,0,0),z=-0.3,color = Color(255,45,50), var="AO_FireLamp"}
        }},
		{ID = "!Ready", x=23.7, y=38.2, radius=5, tooltip="Лампа готовности пожаротушения\nаппаратного отсека", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",scale=0.8,ang = Angle(0,0,0),z=-0.3,color = Color(175,250,20), var="ReadyLamp"}
        }},
		{ID = "!Error", x=39.35, y=38.2, radius=5, tooltip="Лампа готовности пожаротушения\nаппаратного отсека", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",scale=0.8,ang = Angle(0,0,0),z=-0.3,color = Color(250,250,20), var="ErrorLamp"}
        }},
		{ID = "!PI", x=23.8, y=99.2, radius=5, tooltip="Лампа готовности пожаротушения\nаппаратного отсека", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",scale=1.35,ang = Angle(0,0,0),z=-1.2,color = Color(250,0,40), var="PILamp"}
        }},
		{ID = "!OSP", x=54.2, y=99.2, radius=5, tooltip="Лампа готовности пожаротушения\nаппаратного отсека", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",scale=1.35,ang = Angle(0,0,0),z=-1.2,color = Color(250,30,40), var="OSPLamp"}
        }},
		{ID = "!HV_Off", x=84.9, y=99.2, radius=5, tooltip="Лампа готовности пожаротушения\nаппаратного отсека", model = {
            lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",scale=1.35,ang = Angle(0,0,0),z=-1.2,color = Color(240,20,40), var="HV_OffLamp"}
        }},
		{ID = "ASPS_RestartSet",x=108, y=40, w=12, h=12, tooltip="АСПС: Перезапуск", model = {
			model = "models/asps/square_button.mdl",scale=1.35,z=2,ang=Angle(0,90,0),
			var = "ASPS_Restart",speed=16,
            sndvol = 0.1, snd = function(val) return val and "button_square_press" or "button_square_release" end,
            sndmin = 90, sndmax = 1e3,
		}},
		{ID = "ASPS_RestartSetKToggle",x=108, y=30, w=12, h=12,tooltip="Крышка кнопки перезапуска АСПС",model = {
            var="ASPS_RestartSetK",speed=4,min=1,max=0.1,disable="ASPS_RestartSet",
            model = "models/asps/cap_button.mdl",scale=1,ang=Angle(180,102,90),z=5,
        }},
		{ID = "ASPS_ViewSet",x=105.3, y=69, w=12, h=12, tooltip="АСПС: Просмотр", model = {
		    model = "models/asps/square_button.mdl",scale=1.35,z=2,ang=Angle(0,90,0),
			var = "ASPS_View",speed=16,
            sndvol = 0.1, snd = function(val) return val and "button_square_press" or "button_square_release" end,
            sndmin = 90, sndmax = 1e3,
		}},
		{ID = "ASPS_EscSet",x=105.3, y=92, w=12, h=12, tooltip="АСПС: Отмена", model = {
			model = "models/asps/square_button.mdl",scale=1.35,z=2,ang=Angle(0,90,0),
			var = "ASPS_Esc",speed=16,
            sndvol = 0.1, snd = function(val) return val and "button_square_press" or "button_square_release" end,
            sndmin = 90, sndmax = 1e3,
		}},
    }
}

ENT.ButtonMap["KTSOScreen"] = {
    pos = Vector(449.96,-53.485,7.495),
    ang = Angle(0,-135,90),
    width = 320,
    height = 240,
    scale = 0.01765,
    hideseat=0.2,
}

ENT.ButtonMap["KTSOButtons"] = {
    pos = Vector(449.93,-53.455,3.24),
    ang = Angle(0,-135,90),
    width = 90,
    height = 20,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
		{ID = "KTSO_MenuSet",x=13, y=6, w=8, h=8, tooltip="КТС-О: Меню", model = {
			z=1,ang=Angle(-90,0,0),
			var = "KTSO_Menu",
		}},
		{ID = "KTSO_UpSet",x=33, y=6, w=8, h=8, tooltip="КТС-О: Вверх", model = {
			z=1,ang=Angle(-90,0,0),
			var = "KTSO_Up",
		}},
		{ID = "KTSO_DownSet",x=53, y=6, w=8, h=8, tooltip="КТС-О: Вниз", model = {
			z=1,ang=Angle(-90,0,0),
			var = "KTSO_Down",
		}},
		{ID = "KTSO_EnterSet",x=73, y=6, w=8, h=8, tooltip="КТС-О: Выбор", model = {
			z=1,ang=Angle(-90,0,0),
			var = "KTSO_Enter",
		}},
    }
}

ENT.ClientProps["volt1"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",scale=1,
    pos = Vector(384.73,27.6,19.55),
    ang = Angle(-90,-90,0),
    bscale = Vector(1,1,1.15),
    hideseat = 0.2,
}
ENT.ClientProps["ampermeter3"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",scale=1,
    pos = Vector(389,27.6,19.55),
    ang = Angle(-90,-90,0),
    bscale = Vector(1,1,1.15),
    hideseat = 0.2,
}

ENT.ButtonMap["OtsekDoor1"] = {
    pos = Vector(374.0,24,59),
    ang = Angle(0,270,90),
    width = 830,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "OtsekDoor1",x=0,y=0,w=830,h=2000,tooltip="Первый аппаратный отсек",model = {
            var="door_otsek1",sndid="door_otsek1",
            sndvol = 1,snd = function(val) return "otsek_door_close" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["OtsekDoor1O"] = {
    pos = Vector(374.0,-17.5,59),
    ang = Angle(0,180,90),
    width = 830,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "OtsekDoor1O",x=0,y=0,w=830,h=2000,tooltip="Первый аппаратный отсек",model = {var="door_otsek1"}},
    }
}
ENT.ButtonMap["OtsekDoor2"] = {
    pos = Vector(374.0,-17.5,59),
    ang = Angle(0,270,90),
    width = 830,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "OtsekDoor2",x=0,y=0,w=830,h=2000,tooltip="Открытие второго аппаратного отсека",model = {
            var="door_otsek2",sndid="door_otsek2",
            sndvol = 1,snd = function(val) return "otsek_door_close" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["PassengerDoor"] = {
    pos = Vector(390-12.2,29,50.6),--28
    ang = Angle(0,90,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=642,h=2000,tooltip="Дверь в салон",model = {
            var="door3",sndid="door3",
            sndvol = 1,snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["PassengerDoor1"] = {
    pos = Vector(390-12.2,29+32,50.6),--28
    ang = Angle(0,-90,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=642,h=2000,tooltip=""},
    }
}
ENT.ButtonMap["CabinDoor"] = {
    pos = Vector(414.5,64,56.7),
    ang = Angle(0,0,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoor",x=0,y=0,w=642,h=2000,tooltip="Дверь в кабину",model = {
            var="door2",sndid="door2",
            sndvol = 1,snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["RearDoor"] = {
    pos = Vector(-470-3,-16,48.4-2),
    ang = Angle(0,90,90),
    width = 642,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=642,h=1900,tooltip="Задняя торцевая дверь",model = {
            var="door1",sndid="door1",
            sndvol = 1,snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false
ENT.ClientProps["brake013"] = {
    model = "models/metrostroi_train/81-5402/km5p.mdl",
    pos = Vector(437.5,-14.45,-5),
    ang = Angle(38,0,90),
    hideseat = 0.2,
}
if not ENT.ClientSounds["br_013_5P"] then ENT.ClientSounds["br_013_5P"] = {} end
table.insert(ENT.ClientSounds["br_013_5P"],{"brake013",function(ent,_,var) return "br_013_5P" end,1.4,1,50,1e3,Angle(-90,0,0)})
if not ENT.ClientSounds["br_013_5P_6-7"] then ENT.ClientSounds["br_013_5P_6-7"] = {} end
table.insert(ENT.ClientSounds["br_013_5P_6-7"],{"brake013",function(ent,_,var) return "br_013_5P_6-7" end,1.2,1,50,1e3,Angle(-90,0,0)}) --6-7
if not ENT.ClientSounds["br_013_5P_2-1"] then ENT.ClientSounds["br_013_5P_2-1"] = {} end
table.insert(ENT.ClientSounds["br_013_5P_2-1"],{"brake013",function(ent,_,var) return "br_013_5P_2-1" end,2.3,1,50,1e3,Angle(-90,0,0)}) --2-1
--------------------------------------------------------------------------------

ENT.ClientProps["PB"] = {
    model = "models/metrostroi_train/81-720/720_pb.mdl",
    pos = Vector(450, 14.5, -37),
    ang = Angle(0,-90,8),
    hideseat = 0.2,
}
if not ENT.ClientSounds["PB"] then ENT.ClientSounds["PB"] = {} end
table.insert(ENT.ClientSounds["PB"],{"PB",function(ent,var) return var > 0 and "pb_on" or "pb_off" end,1,1,50,1e3,Angle(-90,0,0)})

ENT.ClientProps["train_line"] = {
    model = "models/metrostroi_train/81-5402/arrow_white.mdl",
    pos = Vector(450.25,-17.025,3.05),
    ang = Angle(-66,-30,0.000000),scale=1.1,
    hideseat = 0.2,
}
ENT.ClientProps["brake_line"] = {
    model = "models/metrostroi_train/81-5402/arrow_red.mdl",scale=1.1,color=Color(255,0,0),
    pos = Vector(450.2,-17.003,3.077),
    ang = Angle(-65,-30,0.000000),
    hideseat = 0.2,
}
ENT.ClientProps["brake_cylinder"] = {
    model = "models/metrostroi_train/81-5402/arrow_white.mdl",scale=1.1,
    pos = Vector(447.6,-21.93,3.05),
    ang = Angle(-66,-30,0.000000),
    hideseat = 0.2,
}
ENT.ClientProps["voltmeter2"] = {
    model = "models/metrostroi_train/81-5402/napryazh.mdl",
    pos = Vector(444.05,4.65,-1.8),
    ang = Angle(0.000000,-90.000000,0.000000),
    hideseat = 0.2,
}
ENT.ClientProps["ampermeter2"] = {
    model = "models/metrostroi_train/81-5402/napryazh.mdl",
    pos = Vector(444.05,7.41,-1.8),
    ang = Angle(0.000000,-90.000000,0.000000),
    hideseat = 0.2,
}

ENT.ClientProps["bortlamps1"] = {
    model = "models/metrostroi_train/81-717/5402_olights.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0), 
    hide = 2,
}
ENT.ClientProps["bortlamp1_w"] = {
    model = "models/metrostroi_train/81-717/5402_lamp_w.mdl",
    pos = ENT.ClientProps.bortlamps1.pos+Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamp1_g"] = {
    model = "models/metrostroi_train/81-717/5402_lamp_g.mdl",
    pos = ENT.ClientProps.bortlamps1.pos+Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamp1_y"] = {
    model = "models/metrostroi_train/81-717/5402_lamp_o.mdl",
    pos = ENT.ClientProps.bortlamps1.pos+Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide = true,
}
--------------------------------------------------------------------------------
-- Add doors
ENT.ClientProps["door0x1"] = {
    model = "models/metrostroi_train/81-5402/doors_5p.mdl",
    pos = Vector(339.245+1.2-2.2,65.164,0.807),
    ang = Angle(0,0,0),
    hide = 2.0,
}
ENT.ClientProps["door1x1"] = {
    model = "models/metrostroi_train/81-5402/doors_5p.mdl",
    pos = Vector(109.324+1.2-2.2,65.164,0.807),
    ang = Angle(0,0,0),
    hide = 2.0,
}
ENT.ClientProps["door2x1"] = {
    model = "models/metrostroi_train/81-5402/doors_5p.mdl",
    pos = Vector(-121.182+1.6-2.2,65.164,0.807),
    ang = Angle(0,0,0),
    hide = 2.0,
}
ENT.ClientProps["door3x1"] = {
    model = "models/metrostroi_train/81-5402/doors_5p.mdl",
    pos = Vector(-350.9+0.8-2.2,65.164,0.807),
    ang = Angle(0,0,0),
    hide = 2.0,
}
ENT.ClientProps["door0x0"] = {
    model = "models/metrostroi_train/81-5402/doors_5p.mdl",
    pos = Vector(338.8,-65.164,0.807),
    ang = Angle(0,180,0),
    hide = 2.0,
}
ENT.ClientProps["door1x0"] = {
    model = "models/metrostroi_train/81-5402/doors_5p.mdl",
    pos = Vector(108.6,-65.164,0.807),
    ang = Angle(0,180,0),
    hide = 2.0,
}
ENT.ClientProps["door2x0"] = {
    model = "models/metrostroi_train/81-5402/doors_5p.mdl",
    pos = Vector(-121.4,-65.164,0.807),
    ang = Angle(0,180,0),
    hide = 2.0,
}
ENT.ClientProps["door3x0"] = {
    model = "models/metrostroi_train/81-5402/doors_5p.mdl",
    pos = Vector(-351.7,-65.164,0.807),
    ang = Angle(0,180,0),
    hide = 2.0,
}
ENT.ClientProps["Lamps_cab1"] = {
    model = "models/metrostroi_train/81-5402/lamp_cab1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat = 0.9,
}
ENT.ClientProps["Lamps_cab2"] = {
    model = "models/metrostroi_train/81-5402/lamp_cab2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat = 0.9,
}
for i = 0,11 do
    ENT.ClientProps["lamp1_"..i+1] = {
        model = "models/metrostroi_train/81-5402/lamp_interior.mdl",
        pos = Vector(333.949 - 67.006*i,0,70.8),
        ang = Angle(0,0,0),
		bscale = Vector(2,2.097,1),
        color = Color(255,255,255),
        hideseat = 1.1,
    }
end
ENT.Lights = {
    [1] = { "headlight",Vector(460,0,-40),Angle(0,0,0),Color(216,161,92),farz=5144,brightness = 4, fov=100, texture = "models/metrostroi_train/equipment/headlight",shadows = 1,headlight=true},
    [2] = { "headlight",        Vector(460,0,50), Angle(-20,0,0), Color(255,0,0), fov=160 ,brightness = 0.3, farz=450,texture = "models/metrostroi_train/equipment/headlight2",shadows = 0,backlight=true},

    [3] = { "headlight",        Vector(365,-9,50), Angle(50,40,-0), Color(206,135,80), hfov=80, vfov=80,farz=100,brightness = 6,shadows=1},
    [4] = { "headlight",        Vector(365,-51,50), Angle(50,40,-0), Color(206,135,80), hfov=80, vfov=80,farz=100,brightness = 6,shadows=1},

    -- Manometers
    [50] = { "headlight",Vector(445,-27,7),Angle(90,0,0),Color(200,200,255),farz = 6.9,nearz = 1,shadows = 0,brightness = 0.2,fov = 179 }, --Блок 3
    [51] = { "headlight",Vector(449,-18.9,7),Angle(90,0,0),Color(200,200,255),farz = 6.9,nearz = 1,shadows = 0,brightness = 0.2,fov = 179 }, --Блок 3
    [52] = { "headlight",Vector(448,22,7),Angle(90,0,0),Color(200,200,255),farz = 10,nearz = 1,shadows = 0,brightness = 0.3,fov = 179 }, --Планшет
    
    -- Voltmeter
    [56] = { "headlight",Vector(445,-4,7),Angle(90,0,0),Color(200,200,255),farz = 10,nearz = 1,shadows = 0,brightness = 0.15,fov = 179 }, --Блок 2
    [57] = { "headlight",Vector(445,6,7),Angle(90,0,0),Color(200,200,255),farz = 10,nearz = 1,shadows = 0,brightness = 0.15,fov = 179 }, --Блок 2

    [70] = { "headlight",Vector( 425,-56,-70),Angle(0,-90,0),Color(255,220,180),brightness = 0.3,distance = 300 ,fov=120,shadows = 1, texture="effects/flashlight/soft" },
}

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.PUAV = self:CreateRT("7175PUAV",512,128)
    self.PAM = self:CreateRT("7175PAM",1024,512)
	self.RouteNumber = self:CreateRT("7175RouteNumber",256,128)
	self.ECRSScr = self:CreateRT("7175PECRS",256,256)
	self.Tickers = self:CreateRT("7175Ticker",1024,64)
	self.ASPSScr = self:CreateRT("7175PASPS",512,128)
	self.KTSOScr = self:CreateRT("7175PKTSO",320,240)

    self.CraneRamp = 0
    self.CraneRRamp = 0
    self.ReleasedPdT = 0
    self.EmergencyValveRamp = 0
    self.EmergencyValveEPKRamp = 0
    self.EmergencyBrakeValveRamp = 0
    self.FrontLeak = 0
    self.RearLeak = 0

    self.VentCab = 0

    self.BPSNBuzzVolume = 0
end

function ENT:UpdateWagonNumber()
    local WagNum = self.WagonNumber or 0
    local count = math.max(3,math.ceil(math.log10(WagNum+1)))
    for i=0,3 do
        self:ShowHide("TrainNumberL"..i,i<count)
        self:ShowHide("TrainNumberR"..i,i<count)
		self:ShowHide("TrainNumberF"..i,i<count)
        if i < count and WagNum then
            local leftNum,rightNum,frontNum = self.ClientEnts["TrainNumberL"..i],self.ClientEnts["TrainNumberR"..i],self.ClientEnts["TrainNumberF"..i]
            local num = math.floor(WagNum%(10^(i+1))/10^i)
            if IsValid(leftNum) then
                leftNum:SetPos(self:LocalToWorld(Vector(41+16+i*6.6-count*6.6/2,67.4,-17.8)))
                leftNum:SetSkin(num)
            end
            if IsValid(rightNum) then
                rightNum:SetPos(self:LocalToWorld(Vector(64+16-i*6.6-count*6.6/2,-67.4,-17.8)))
                rightNum:SetSkin(num)
            end
			if IsValid(frontNum) then
			    if num==1 then
                    frontNum:SetPos(self:LocalToWorld(Vector(445.9+16+i*0.6-count*0.6/2,64.5-i*4.0-count*4.0/2,-55)))
				else	
                    frontNum:SetPos(self:LocalToWorld(Vector(445.9+16+i*0.6-count*0.6/2,64.5-i*4.0-count*4.0/2,-55)))
				end
                frontNum:SetModel("models/metrostroi_train/81-5402/5p_num_"..num..".mdl") 
            end
        end
    end
	self.Number = self:GetWagonNumber()
end
local Cpos = {
    0,0.2,0.4,0.5,0.6,0.8,1
}
function ENT:IsNumberError()
	local err = false
	for i=0,3 do
        if IsValid(self.ClientEnts["TrainNumberF"..i]) and (self.ClientEnts["TrainNumberF"..i]:GetPos()==self:GetPos()) then
			err = true
			break
        end
		if IsValid(self.ClientEnts["TrainNumberL"..i]) and (self.ClientEnts["TrainNumberL"..i]:GetPos()==self:GetPos()) then
			err = true
			break
		end
		if IsValid(self.ClientEnts["TrainNumberR"..i]) and (self.ClientEnts["TrainNumberR"..i]:GetPos()==self:GetPos()) then
			err = true
			break
		end
	end
	return err
end
--------------------------------------------------------------------------------
function ENT:Think()
    self.BaseClass.Think(self)
    if not self.RenderClientEnts or self.CreatingCSEnts then
        self.RKTimer = nil
        self.OldBPSNType = nil

        self.RingType = nil
        self.LastStation = false
        return
    end
    
    if self:IsNumberError() then self:UpdateWagonNumber() end
    
    self:SetSoundState("ASPS_ring",self:GetPackedBool("ASPS:Ring") and 0.1 or 0,1)
	
    if self.Scheme ~= self:GetNW2Int("Scheme",1) then
        self.PassSchemesDone = false
        self.Scheme = self:GetNW2Int("Scheme",1)
    end
    if self.RelaysConfig ~= self:GetNW2String("RelaysConfig") then
        self.RelaysConfig = self:GetNW2String("RelaysConfig")
        self:SetRelays()
    end
    if not self.PassSchemesDone and IsValid(self.ClientEnts.schemes) then
        local scheme = Metrostroi.Skins["717_new_schemes"] and Metrostroi.Skins["717_new_schemes"][self.Scheme]
        self.ClientEnts.schemes:SetSubMaterial(1,scheme and scheme[1])
        self.PassSchemesDone = true
    end
    
    local pLights = self:GetPackedBool("PanelLights")
    self:SetLightPower(50,pLights)
    self:SetLightPower(51,pLights)
    self:SetLightPower(52,pLights)
    self:ShowHide("svetolenta",pLights)

    local sosd = self:Animate("SOSD",self:GetPackedBool("SOSDL") and 1 or 0,0,1,6,false)
    self:ShowHideSmooth("sosd_lamp",sosd)
    self:SetLightPower(70,sosd>0,sosd)

    local HL1 = self:Animate("Headlights1",self:GetPackedBool("Headlights1") and 1 or 0,0,1,6,false)
    local HL2 = self:Animate("Headlights2",self:GetPackedBool("Headlights2") and 1 or 0,0,1,6,false)
    local RL = self:Animate("RedLights_a",self:GetPackedBool("RedLights") and 1 or 0,0,1,6,false)
    self:ShowHideSmooth("Headlights_1",HL1)
    self:ShowHideSmooth("Headlights_2",HL2)
    self:ShowHideSmooth("RedLights",RL)

    local headlight = HL1*0.6+HL2*0.4
    self:SetLightPower(1,headlight>0,headlight)
    self:SetLightPower(2,self:GetPackedBool("RedLights"),RL)


    if IsValid(self.GlowingLights[1]) then
        if not self:GetPackedBool("Headlights1") and self.GlowingLights[1]:GetFarZ() ~= 3144 then
            self.GlowingLights[1]:SetFarZ(3144)
        end
        if self:GetPackedBool("Headlights1") and self.GlowingLights[1]:GetFarZ() ~= 5144 then
            self.GlowingLights[1]:SetFarZ(5144)
        end
    end
	
    self:ShowHide("Route",true)
    self:ShowHide("route1",true)
    self:ShowHide("route2",true)
    self:ShowHide("route3",true)

    local Bortlamp_w = self:Animate("Bortlamp_w",self:GetPackedBool("DoorsW") and 1 or 0,0,1,16,false)
    local Bortlamp_g = self:Animate("Bortlamp_g",self:GetPackedBool("GRP") and 1 or 0,0,1,16,false)
    local Bortlamp_y = self:Animate("Bortlamp_y",self:GetPackedBool("BrW") and 1 or 0,0,1,16,false)
    self:ShowHideSmooth("bortlamp1_w",Bortlamp_w)
    self:ShowHideSmooth("bortlamp1_g",Bortlamp_g)
    self:ShowHideSmooth("bortlamp1_y",Bortlamp_y)
    self:ShowHideSmooth("bortlamp2_w",Bortlamp_w)
    self:ShowHideSmooth("bortlamp2_g",Bortlamp_g)
    self:ShowHideSmooth("bortlamp2_y",Bortlamp_y)

    self:Animate("Controller",self:GetPackedRatio("ControllerPosition"),0.3,0.02,2,false)

    self:Animate("reverser",self:GetNW2Int("ReverserPosition")/2,0,0.27,4,false)
    self:Animate("krureverser",self:GetNW2Int("KRUPosition")/2,0.53,0.95,4,false)
    self:ShowHide("reverser",self:GetNW2Int("WrenchMode",0)==1)
    self:ShowHide("krureverser",self:GetNW2Int("WrenchMode",0)==2)
	
    local adverts = self:GetNW2Bool("spb_reklama717")
	self:ShowHide("label_wifi_1",adverts)
	self:ShowHide("label_wifi_2",adverts)
	self:ShowHide("label_wifi_3",adverts)
	self:ShowHide("label_wifi_4",adverts)
	self:ShowHide("label_wifi_5",adverts)
	self:ShowHide("label_wifi_6",adverts)
	
	self:ShowHide("tch3",self.Type==2)
    self:ShowHide("tch6",self.Type~=2)

    self:Animate("PB",self:GetPackedBool("PB") and 1 or 0,0,0.2,  12,false)
    self:Animate("parking_brake",   self:GetPackedBool("ParkingBrake") and 0 or 1,0.4,0,  4,false)
    self:Animate("EPV_disconnect",   self:GetPackedBool("EPK") and 0 or 1,0.4,0,  4,false)
    self:Animate("valve_disconnect",self:GetPackedBool("DriverValveDisconnect") and 1 or 0,0.4,0,  4,false)
    self:Animate("stopkran",   self:GetPackedBool("EmergencyBrakeValve") and 0.5 or 0,0,1, 3, false)
    self:Animate("brake013",        Cpos[self:GetPackedRatio("CranePosition")] or 0, 0.03, 0.458,  256,24)
    self:Animate("UAVALever",   self:GetPackedBool("UAVA") and 1 or 0,     0,0.6, 128,  3,false)
    self:Animate("brake_line",self:GetPackedRatio("BLPressure"),0.143,0.86,256,2)--,0.01)
    self:Animate("train_line",self:GetPackedRatio("TLPressure"),0.143,0.86,256,0)--,0.01)
    self:Animate("brake_cylinder",self:GetPackedRatio("BCPressure"),0.134,0.865,256,2)--,0.03)
    self:Animate("voltmeter2",self:GetPackedRatio("EnginesVoltage"),0.850,0.150,48,nil)--,256,2,0.01)
    self:Animate("ampermeter2",self:GetPackedRatio("EnginesCurrent"),0.802,0.248,nil,nil,256,2,0.01)
    self:Animate("volt1",self:GetPackedRatio("BatteryVoltage"),0.625,0.36,256,0.2,false) --67 84
	self:Animate("ampermeter3",self:GetPackedRatio("BatteryVoltage"),0.620,0.45,256,0.2,false)

    self:ShowHide("SSpeed1",self:GetPackedBool("LUDS"))
    self:ShowHide("SSpeed2",self:GetPackedBool("LUDS"))
    if self:GetPackedBool("LUDS") then
        local speed = self:GetNW2Int("ALSSpeed")
        if IsValid(self.ClientEnts["SSpeed1"])then self.ClientEnts["SSpeed1"]:SetSkin(math.floor(speed)%10) end
        if IsValid(self.ClientEnts["SSpeed2"])then self.ClientEnts["SSpeed2"]:SetSkin(math.floor(speed/10)) end
    end
	
	local rnwork = self:GetNW2Bool("RouteNumberWork")
    local rn =  self:GetNW2Int("RouteNumberSet")
    for i=1,3 do
        self:ShowHide("route_number"..i,rnwork)
        if rnwork and IsValid(self.ClientEnts["route_number"..i]) then
            local number = math.floor(rn/10^(3-i)) % 10
            self.ClientEnts["route_number"..i]:SetSkin(number)
        end
    end

    local otsek1 = self:Animate("door_otsek1",self:GetPackedBool("OtsekDoor1") and 1 or 0,0,1,4,0.5)
    local otsek2 = self:Animate("door_otsek2",self:GetPackedBool("OtsekDoor2") and 1 or 0,0,1,4,0.5)
	local chair_torec_1_cp = self:Animate("chair_torec_1_cp",self:GetPackedBool("chair_torec_1_cp") and 0 or 1,0.68,0.99,8,0.5)
    local chair_torec_2_cp = self:Animate("chair_torec_2_cp",self:GetPackedBool("chair_torec_2_cp") and 0 or 1,0.68,0.99,8,0.5)
	local otsek_torec_1_cp = self:Animate("otsek_torec_1_cp",self:GetPackedBool("otsek_torec_1_cp") and 0 or 1,1,0,8,0.5)
	local otsek_torec_2_cp = self:Animate("otsek_torec_2_cp",self:GetPackedBool("otsek_torec_2_cp") and 0 or 1,1,0,8,0.5)
    local door1 = self:Animate("door1",self:GetPackedBool("RearDoor") and 1 or 0,0,0.25,4,0.5)
    local door2 = self:Animate("door2",self:GetPackedBool("PassengerDoor") and 1 or 0,1,0.8,4,0.5)
    local door3 = self:Animate("door3",self:GetPackedBool("CabinDoor") and 1 or 0,1,0,4,0.5)
    if self.Door1 ~= (door1 > 0) then
        self.Door1 = door1 > 0
        self:PlayOnce("door1","bass",self.Door1 and 1 or 0)
    end
    if self.Door2 ~= (door2 < 1) then
        self.Door2 = door2 < 1
        self:PlayOnce("door2","bass",self.Door2 and 1 or 0)
    end
    if self.Door3 ~= (door3 < 1) then
        self.Door3 = door3 < 1
        self:PlayOnce("door3","bass",self.Door3 and 1 or 0)
    end
    if self.Otsek1 ~= (otsek1 > 0) then
        self.Otsek1 = otsek1 > 0
        if not self.Otsek1 then self:PlayOnce("door_otsek1","bass",1) end
    end
    if self.Otsek2 ~= (otsek2 > 0) then
        self.Otsek2 = otsek2 > 0
        if not self.Otsek2 then self:PlayOnce("door_otsek2","bass",1) end
    end
    self:SetLightPower(3,self.Otsek1 and self:GetPackedBool("EqLights"))
    self:SetLightPower(4,self.Otsek2 and self:GetPackedBool("EqLights"))
    self:HidePanel("OtsekDoor1",self.Otsek1)
    self:HidePanel("OtsekDoor1O",not self.Otsek1)
    self:HidePanel("AV_S",not self.Otsek1)

    for i = 1,12 do
        self:ShowHideSmooth("lamp1_"..i,self:Animate("Lamp1_"..i,(self:GetPackedBool("lightsActive"..i)) and 1 or 0,0,1,12,false))
    end

    if self.Type ~= self:GetNW2Int("AVType",1) then
        self.Type = self:GetNW2Int("AVType",1)
        self.RingTypePA = nil
		self.RingTypeOhr = nil
        self.RingType = nil
        -- ПУАВ
        self:ShowHide("Controller_puav",self.Type==2)
        self:ShowHide("A58Toggle",self.Type==2)
        self:ShowHide("A59Toggle",self.Type==2)
        self:ShowHide("A61Toggle",self.Type==2)
        self:HidePanel("PUAVN",self.Type~=2)
		self:HidePanel("PUAVN_RL",self.Type~=2)
        self:HidePanel("PUAVNScreen",self.Type~=2)
        self:ShowHide("2:KDLK_pblToggle",self.Type==2)
        self:ShowHide("2:KDPK_pblToggle",self.Type==2)
        self:ShowHide("VAVToggle_label1",self.Type == 2 and self:GetNW2Bool("SBPP"))
        
        -- ПАкость
        self:HidePanel("PAMScreen",self.Type==2)
        self:HidePanel("PAM1",self.Type==2)
		self:ShowHide("Pakost",self.Type~=2)
        self:ShowHide("P:A58Toggle",self.Type~=2)
        self:ShowHide("P:A59Toggle",self.Type~=2)
        self:ShowHide("P:A61Toggle",self.Type~=2)
        self:ShowHide("2:KDLK_mplToggle",self.Type~=2)
        self:ShowHide("2:KDPK_mplToggle",self.Type~=2)
        
        self:ShowHideSmooth("Lamps_cab2",0)
        self:ShowHideSmooth("Lamps_cab1",0)
        self:SetLightPower(56,false)
        self:SetLightPower(57,false)
    end

    local lamps_cab2 = self:Animate("lamps_cab2",self:GetPackedBool("EqLights") and 1 or 0,0,1,5,false)
    local lamps_cab1 = self:Animate("lamps_cab1",self:GetPackedBool("CabLights") and 1 or 0,0,1,5,false)
    -- local lamps_rtm = self:Animate("lamps_rtm",self:GetPackedBool("VPR") and 1 or 0,0,1,8,false)
    self:ShowHideSmooth("Lamps_cab2",lamps_cab2)
    self:ShowHideSmooth("Lamps_cab1",lamps_cab1)
    self:SetLightPower(56,pLights)
    self:SetLightPower(57,pLights)
    -- self:SetSoundState("vpr",lamps_rtm>0 and 1 or 0,1)

    self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0.8 or 0.25,0,1, 3, false)
    self:Animate("FrontTrain",  self:GetNW2Bool("FtI") and 0.5 or 1,0,1, 3, false)
    self:Animate("RearBrake",   self:GetNW2Bool("RbI") and 0 or 1,0,1, 3, false)
    self:Animate("RearTrain",   self:GetNW2Bool("RtI") and 1 or 0,0,1, 3, false)

    -- Main switch
    if self.LastGVValue ~= self:GetPackedBool("GV") then
        self.ResetTime = CurTime()+1.5
        self.LastGVValue = self:GetPackedBool("GV")
    end
    self:Animate("gv_wrench",self.LastGVValue and 1 or 0,0.5,0.9,128,1,false)
    self:ShowHideSmooth("gv_wrench",    CurTime() < self.ResetTime and 1 or 0.1)
	
	if self.LastEPKValue ~= self:GetPackedBool("EPK") then
        self.ResetTime = CurTime()+1.5
        self.LastEPKValue = self:GetPackedBool("EPK")
    end
    self:Animate("epv_wrench",self.LastEPKValue and 0 or 1,0.5,0,4,false)
    self:ShowHideSmooth("epv_wrench",    CurTime() < self.ResetTime and 1 or 0.1) --1 or 0.1
    --self:InitializeSounds()
    if not self.DoorStates then self.DoorStates = {} end
    if not self.DoorLoopStates then self.DoorLoopStates = {} end
    for i=0,3 do
        for k=0,1 do
            local st = k==1 and "DoorL" or "DoorR"
            local doorstate = self:GetPackedBool(st)
            local id,sid = st..(i+1),"door"..i.."x"..k
            local state = self:GetPackedRatio(id)
            --print(state,self.DoorStates[state])
            if (state ~= 1 and state ~= 0) ~= self.DoorStates[id] then
                if doorstate and state < 1 or not doorstate and state > 0 then
                else
                    if state > 0 then
                        self:PlayOnce(sid.."o","",1,math.Rand(0.8,1.2))
                    else
                        self:PlayOnce(sid.."c","",1,math.Rand(0.8,1.2))
                    end
                end
                self.DoorStates[id] = (state ~= 1 and state ~= 0)
            end
            if (state ~= 1 and state ~= 0) then
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) + 2*self.DeltaTime,0,1)
            else
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) - 6*self.DeltaTime,0,1)
            end
            self:SetSoundState(sid.."r",self.DoorLoopStates[id],0.8+self.DoorLoopStates[id]*0.2)
            local n_l = "door"..i.."x"..k--.."a"
            --local n_r = "door"..i.."x"..k.."b"
            local dlo = 1
            if self.Anims[n_l] then
                dlo = math.abs(state-(self.Anims[n_l] and self.Anims[n_l].oldival or 0))
                if dlo <= 0 and self.Anims[n_l].oldspeed then dlo = self.Anims[n_l].oldspeed/14 end
            end
            self:Animate(n_l,state,0,0.95,dlo*14,false)--0.8 + (-0.2+0.4*math.random()),0)
            --self:Animate(n_r,state,0,1,dlo*14,false)--0.8 + (-0.2+0.4*math.random()),0)
        end
    end

    local dT = self.DeltaTime
    --self.TunnelCoeff = 0.8
    --self.StreetCoeff = 0
    local rollingi = math.min(1,self.TunnelCoeff+math.Clamp((self.StreetCoeff-0.82)/0.3,0,1))
    local rollings = math.max(self.TunnelCoeff*0.6,self.StreetCoeff)
    --if self:EntIndex() == 3239 then LocalPlayer():ChatPrint(Format("T: %.2f, S: %.2f",rollingi,rollings)) end
    -- Brake-related sounds
    local dT = self.DeltaTime
    local speed = self:GetPackedRatio("Speed")*100.0
    local rol5 = math.Clamp(speed/1,0,1)*(1-math.Clamp((speed-3)/8,0,1))
    local rol10 = math.Clamp(speed/12,0,1)*(1-math.Clamp((speed-25)/8,0,1))
    local rol40p = Lerp((speed-25)/12,0.6,1)
    local rol40 = math.Clamp((speed-23)/8,0,1)*(1-math.Clamp((speed-55)/8,0,1))
    local rol40p = Lerp((speed-23)/50,0.6,1)
    local rol70 = math.Clamp((speed-50)/8,0,1)*(1-math.Clamp((speed-72)/5,0,1))
    local rol70p = Lerp(0.8+(speed-65)/25*0.2,0.8,1.2)
    local rol80 = math.Clamp((speed-70)/5,0,1)
    local rol80p = Lerp(0.8+(speed-72)/15*0.2,0.8,1.2)
    self:SetSoundState("rolling_5",math.min(1,rollingi*(1-rollings)+rollings*0.8)*rol5,1)
    self:SetSoundState("rolling_10",rollingi*rol10,1)
    self:SetSoundState("rolling_40",rollingi*rol40,rol40p)
    self:SetSoundState("rolling_70",rollingi*rol70,rol70p)
    self:SetSoundState("rolling_80",rollingi*rol80,rol80p)

    local rol10 = math.Clamp(speed/15,0,1)*(1-math.Clamp((speed-18)/35,0,1))
    local rol10p = Lerp((speed-15)/14,0.6,0.78)
    local rol40 = math.Clamp((speed-18)/35,0,1)*(1-math.Clamp((speed-55)/40,0,1))
    local rol40p = Lerp((speed-15)/66,0.6,1.3)
    local rol70 = math.Clamp((speed-55)/20,0,1)--*(1-math.Clamp((speed-72)/5,0,1))
    local rol70p = Lerp((speed-55)/27,0.78,1.15)
    --local rol80 = math.Clamp((speed-70)/5,0,1)
    --local rol80p = Lerp(0.8+(speed-72)/15*0.2,0.8,1.2)
    self:SetSoundState("rolling_low"    ,rol10*rollings,rol10p) --15
    self:SetSoundState("rolling_medium2",rol40*rollings,rol40p) --57
    --self:SetSoundState("rolling_medium1",0 or rol40*rollings,rol40p) --57
    self:SetSoundState("rolling_high2"  ,rol70*rollings,rol70p) --70

    self.ReleasedPdT = math.Clamp(self.ReleasedPdT + 2*(-self:GetPackedRatio("BrakeCylinderPressure_dPdT",0)-self.ReleasedPdT)*dT,0,1)
    local release1 = math.Clamp((self.ReleasedPdT-0.1)/0.8,0,1)^2
    self:SetSoundState("release1",release1,1)
    self:SetSoundState("release2",(math.Clamp(0.3-release1,0,0.3)/0.3)*(release1/0.3),1.0)
    local parking_brake = self:GetPackedRatio("ParkingBrakePressure_dPdT",0)
    local parking_brake_abs = math.Clamp(math.abs(parking_brake)-0.3,0,1)
    if self.ParkingBrake1 ~= (parking_brake<1) then
        self.ParkingBrake1 = (parking_brake<1)
        if self.ParkingBrake1 then self:PlayOnce("parking_brake_en","bass",1,1) end
    end
    if self.ParkingBrake2 ~= (parking_brake>-0.8) then
        self.ParkingBrake2 = (parking_brake>-0.8)
        if self.ParkingBrake2 then self:PlayOnce("parking_brake_rel","bass",0.6,1) end
    end
    self:SetSoundState("parking_brake",parking_brake_abs,1)
    self.FrontLeak = math.Clamp(self.FrontLeak + 10*(-self:GetPackedRatio("FrontLeak")-self.FrontLeak)*dT,0,1)
    self.RearLeak = math.Clamp(self.RearLeak + 10*(-self:GetPackedRatio("RearLeak")-self.RearLeak)*dT,0,1)
    self:SetSoundState("front_isolation",self.FrontLeak,0.9+0.2*self.FrontLeak)
    self:SetSoundState("rear_isolation",self.RearLeak,0.9+0.2*self.RearLeak)

    local ramp = self:GetPackedRatio("Crane_dPdT",0)
    if ramp > 0 then
        self.CraneRamp = self.CraneRamp + ((0.2*ramp)-self.CraneRamp)*dT
    else
        self.CraneRamp = self.CraneRamp + ((0.9*ramp)-self.CraneRamp)*dT
    end
    self.CraneRRamp = math.Clamp(self.CraneRRamp + 1.0*((1*ramp)-self.CraneRRamp)*dT,0,1)
    self:SetSoundState("crane013_release",self.CraneRRamp^1.5,1.0)
    self:SetSoundState("crane013_brake",math.Clamp(-self.CraneRamp*1.5,0,1)^1.3,1.0)
    self:SetSoundState("crane013_brake2",math.Clamp(-self.CraneRamp*1.5-0.95,0,1.5)^2,1.0)
    local emergencyValveEPK = self:GetPackedRatio("EmergencyValveEPK_dPdT",0)
    self.EmergencyValveEPKRamp = math.Clamp(self.EmergencyValveEPKRamp + 1.0*((0.5*emergencyValveEPK)-self.EmergencyValveEPKRamp)*dT,0,1)
    self:SetSoundState("epk_brake",self.EmergencyValveEPKRamp,1.0)
    if emergencyValveEPK <= 0 and self.EmergencyValveEPKStart then
        self.EmergencyValveEPKStart = false
    end

    local emergencyBrakeValve = self:GetPackedRatio("EmergencyBrakeValve_dPdT", 0)
    self.EmergencyBrakeValveRamp = math.Clamp(self.EmergencyBrakeValveRamp + (emergencyBrakeValve-self.EmergencyBrakeValveRamp)*dT*8,0,1)
    self:SetSoundState("valve_brake",self.EmergencyBrakeValveRamp,0.8+math.min(0.4,self.EmergencyBrakeValveRamp*0.8))

    local emergencyValve = self:GetPackedRatio("EmergencyValve_dPdT", 0)^0.4*1.2
    self.EmergencyValveRamp = math.Clamp(self.EmergencyValveRamp + (emergencyValve-self.EmergencyValveRamp)*dT*16,0,1)
    local emer_brake = math.Clamp((self.EmergencyValveRamp-0.9)/0.05,0,1)
    local emer_brake2 = math.Clamp((self.EmergencyValveRamp-0.2)/0.4,0,1)*(1-math.Clamp((self.EmergencyValveRamp-0.9)/0.1,0,1))
    self:SetSoundState("emer_brake",emer_brake,1)
    self:SetSoundState("emer_brake2",emer_brake2,math.min(1,0.8+0.2*emer_brake2))
    -- Compressor
    self:SetSoundState("compressor",self:GetPackedBool("Compressor") and 0.6 or 0,1)
    self:SetSoundState("compressor2",self:GetPackedBool("Compressor") and 0.8 or 0,1)

    local vCstate = self:GetPackedRatio("M8")/2
    if self.VentCab < vCstate then
        self.VentCab = math.min(1,self.VentCab + dT/2.7)
    elseif self.VentCab > vCstate then
        self.VentCab = math.max(0,self.VentCab - dT/2.7)
    end
    self:SetSoundState("vent_cabl",math.Clamp(self.VentCab*2,0,1) ,1)
    self:SetSoundState("vent_cabh",math.Clamp((self.VentCab-0.5)*2,0,1),1)

    -- ARS/ringer alert
    self:SetSoundState("ring",self:GetPackedBool("Buzzer") and 0.6 or 0,1)
    if self:GetPackedBool("PURingZ") and not self.PUZeroTimer  then self.PUZeroTimer = RealTime() end
    if not self:GetPackedBool("PURingZ") and self.PUZeroTimer  then self.PUZeroTimer = nil end
    local pTime = self.PUZeroTimer and RealTime()-self.PUZeroTimer
    self:SetSoundState("pu_ring",(self.Type~=2 and self:GetPackedBool("PURing") or self.Type==2 and (self:GetPackedBool("PURing") or pTime and (pTime < 3 or pTime%1 > 0.5) and pTime<=7))  and 0.6 or 0,1)--0.79

    if self:GetPackedBool("RK") then self.RKTimer = CurTime() end
    self:SetSoundState("rk",(self.RKTimer and (CurTime() - self.RKTimer) < 0.2) and 0.7 or 0,1)

    local cabspeaker = self:GetPackedBool("AnnCab")
    local work = self:GetPackedBool("AnnPlay")
    local buzz = self:GetPackedBool("AnnBuzz") and self:GetNW2Int("AnnouncerBuzz")
    local noise = self:GetNW2Int("AnnouncerNoise", -1)
    local volume = self:GetNW2Float("UPOVolume",1)
    local noisevolume = self:GetNW2Float("UPONoiseVolume",1)

    local buzzvolume = volume
    if self.Sounds["announcer2"] and IsValid(self.Sounds["announcer2"]) then buzzvolume = (1-(self.Sounds["announcer2"]:GetLevel())*math.Rand(0.9,3))*buzzvolume end
    if self.BPSNBuzzVolume > buzzvolume then
        self.BPSNBuzzVolume = math.Clamp(self.BPSNBuzzVolume + 8*(buzzvolume-self.BPSNBuzzVolume)*dT,0.1,1)
    else
        self.BPSNBuzzVolume = math.Clamp(self.BPSNBuzzVolume + 0.4*(buzzvolume-self.BPSNBuzzVolume)*dT,0.1,1)
    end

    for k,v in ipairs(self.AnnouncerPositions) do
        local play = k==1 and cabspeaker or k~=1 and work
        self:SetSoundState("announcer_noiseW"..k,play and noisevolume*volume or 0,1)
        for i=1,3 do
            self:SetSoundState(Format("announcer_noise%d_%d",i,k),(play and i==noise) and volume*self.BPSNBuzzVolume*self:GetNW2Float("UPOBuzzVolume",1) or 0,1)
        end
        for i=1,2 do
            self:SetSoundState(Format("announcer_buzz%d_%d",i,k),(play and i==buzz) and volume*self.BPSNBuzzVolume*self:GetNW2Float("UPOBuzzVolume",1) or 0,1)
        end
        if self.Sounds["announcer"..k] and IsValid(self.Sounds["announcer"..k]) then self.Sounds["announcer"..k]:SetVolume((k ~= 1 and work or k==1 and cabspeaker) and  v[3]*volume or 0) end
    end
end

function ENT:Draw()
    self.BaseClass.Draw(self)
end
function ENT:DrawPost(special)
    self.RTMaterial:SetTexture("$basetexture", self.RouteNumber)
    self:DrawOnPanel("RouteNumber",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(128,64,256,128,0)
    end)
    local distance = self:GetPos():Distance(LocalPlayer():GetPos())
    if distance > 1024 or special then return end
	self.RTMaterial:SetTexture("$basetexture", self.ECRSScr)
    self:DrawOnPanel("ECRSScreen",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(128,178,256,340,0)
    end)
    self.RTMaterial:SetTexture("$basetexture",self.PUAV)
	    self:DrawOnPanel("PUAVNScreen",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(256,64,512,128,0)
    end)
    self.RTMaterial:SetTexture("$basetexture",self.PAM)
    self:DrawOnPanel("PAMScreen",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,256,1024,512,0)
    end)
	self.RTMaterial:SetTexture("$basetexture", self.Tickers)
    self:DrawOnPanel("begstrokaF",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,32,1024,64,0)
    end)
	self.RTMaterial:SetTexture("$basetexture", self.Tickers)
    self:DrawOnPanel("begstrokaR",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,32,1024,64,0)
    end)
	self.RTMaterial:SetTexture("$basetexture", self.ASPSScr)
    self:DrawOnPanel("ASPSScreen",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(256,64,512,128,0)
    end)
	self.RTMaterial:SetTexture("$basetexture", self.KTSOScr)
    self:DrawOnPanel("KTSOScreen",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(160,120,320,240,0)
    end)
    self:DrawOnPanel("AirDistributor",function()
        draw.DrawText(self:GetNW2Bool("AD") and "Air Distributor ON" or "Air Distributor OFF","Trebuchet24",0,0,Color(0,0,0,255))
    end)
end

function ENT:OnButtonPressed(button)
    if button == "ShowHelp" then
        RunConsoleCommand("metrostroi_train_manual")
    end
end

function ENT:OnPlay(soundid,location,range,pitch)
    if location == "stop" then
        if IsValid(self.Sounds[soundid]) then
            self.Sounds[soundid]:Pause()
            self.Sounds[soundid]:SetTime(0)
        end
        return
    end
    if soundid == "pkg" then return end
    if location == "bass" then
        if soundid:sub(1,4) == "IGLA" then
            return range > 0 and "igla_on" or "igla_off",location,1,pitch
        end
        if soundid == "LK2" then
            local speed = self:GetPackedRatio("Speed")
            local id = range > 0 and "lk2_on" or "lk2_off"
            self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
            return id,location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "LK3" then
            local speed = self:GetPackedRatio("Speed")
            local id = range > 0 and "lk3_on" or "lk3_off"
            self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
            return id,location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "LK5" and range > 0 then
            local speed = self:GetPackedRatio("Speed")
            self.SoundPositions["lk5_on"][1] = 350-Lerp(speed/0.1,0,250)
            return "lk5_on",location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "brake" then
            self:PlayOnce("brake_f",location,range,pitch)
            self:PlayOnce("brake_b",location,range,pitch)
            return
        end
        if soundid == "RVT" then
            return range > 0 and "rvt_on" or "rvt_off",location,1,pitch
        end
        if soundid == "K6" then
            return range > 0 and "k6_on" or  "k6_off",location,1,pitch
        end
        if soundid == "R1_5" then
            return range > 0 and "r1_5_on" or "r1_5_off",location,1,pitch
        end
        if soundid == "RPB" then
            return range > 0 and "rpb_on" or "rpb_off",location,1,pitch
        end
        if soundid == "KD" then
            return range > 0 and "kd_on" or "kd_off",location,1,pitch
        end
        if soundid == "KK" then
            return range > 0 and "kk_on" or "kk_on",location,1,0.6+range*0.1
        end
        if soundid == "K25" then
            return range > 0 and "k25_on" or "k25_off",location,1,pitch
        end
        if soundid == "RO" then
            return range > 0 and "ro_on" or "ro_off",location,1,pitch
        end
        if soundid == "Rp8" then
            return range > 0 and "rp8_on" or "rp8_off",location,1,pitch
        end
        if soundid == "ROT" then
            return range > 0 and "rot_on" or "rot_off",location,1,pitch
        end
        if soundid == "AVU" then
            return range > 0 and "avu_on" or "avu_off",location,1,0.9
        end
    end
    return soundid,location,range,pitch
end
Metrostroi.GenerateClientProps()