include("shared.lua")
ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.AutoAnims = {}
ENT.ClientSounds = {}
-- Маршрутное табло
ENT.ClientProps["tablo_2k"] = {
    model = "models/metrostroi_train/81-5402/2k_routeindicator.mdl",
    pos = Vector(450,38,0),
    ang = Angle(0,0,0),
    scale = 0.8,
    nohide=true,
}
ENT.ClientProps["2k_otsav_rem"] = {
    model = "models/metrostroi_train/81-5402/2k_otsav_rem.mdl",
    pos = Vector(392.5,-42.4,-29.9),
    ang = Angle(-90,0,0),
    scale = 6.1,
    nohide=true,
}
-- Interior 
ENT.ClientProps["interiornakls"] = {
    model = "models/2k_int/2k_int_rem.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,-90,0),
    scale = 1,
    nohide=true,
}
-- Мониторы
ENT.ClientProps["screen_2k"] = {
    model = "models/2k_int/lamp_type2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,-90,0),
    scale = 1,
    nohide=true,
}
-- Бочок 
ENT.ClientProps["bochok"] = {
    model = "models/2k_int/2k_bochok.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,90,0),
    scale = 1,
    nohide=true,
}
-- Дворник
ENT.ClientProps["Wiper"] = {
    model = "models/metrostroi_train/81-5402/wiper2k.mdl",
    pos = Vector(0,-0.5,-1),
    ang = Angle(0,0,0),
    -- scale = 1,
    nohide=true,
}
-- Контроллер вентиляции
ENT.ButtonMap["SmodeScreen"] = {
    pos = Vector(395.8,-0.66,34.5),
    ang = Angle(0,90,90),
    width = 512,
    height = 149,
    scale = 0.00725,
    hideseat=0.2,
    hide=true,
}
ENT.ButtonMap["Smode"] = {
    pos = Vector(395.99,-2,32.6),
    ang = Angle(0,90,90),
    width = 120,
    height = 100,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "SMODE_UpSet",x=80, y=62, radius = 4.5, tooltip="Вверх", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_Up",speed=12,
        }},
        {ID = "SMODE_EnterSet",x=102, y=57, radius = 4.5, tooltip="Enter", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_Enter",speed=12,
        }},
        {ID = "SMODE_EscapeSet",x=102, y=42, radius = 4.5, tooltip="Escape", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_Escape",speed=12,
        }},
        {ID = "SMODE_DownSet",x=80, y=85, radius = 4.5, tooltip="Вниз", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_Down",speed=12,
        }},
        {ID = "SMODE_PrevSet",x=69, y=73, radius = 4.5, tooltip="Назад", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_Prev",speed=12,
        }},
        {ID = "SMODE_NextSet",x=90, y=73, radius = 4.5, tooltip="Вперед", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_Next",speed=12,
        }},
        {ID = "SMODE_1Set",x=11, y=42, radius = 4.5, tooltip="1", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_1",speed=12,
        }},
        {ID = "SMODE_2Set",x=28, y=42, radius = 4.5, tooltip="2", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_2",speed=12,
        }},
        {ID = "SMODE_3Set",x=43, y=42, radius = 4.5, tooltip="3", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_3",speed=12,
        }},
        {ID = "SMODE_4Set",x=58, y=42, radius = 4.5, tooltip="4", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_4",speed=12,
        }},
        {ID = "SMODE_5Set",x=11, y=58, radius = 4.5, tooltip="5", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_5",speed=12,
        }},
        {ID = "SMODE_6Set",x=28, y=58, radius = 4.5, tooltip="6", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_6",speed=12,
        }},
        {ID = "SMODE_7Set",x=43, y=58, radius = 4.5, tooltip="7", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_7",speed=12,
        }},
        {ID = "SMODE_8Set",x=58, y=58, radius = 4.5, tooltip="8", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_8",speed=12,
        }},
        {ID = "SMODE_9Set",x=11, y=73, radius = 4.5, tooltip="9", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_9",speed=12,
        }},
        {ID = "SMODE_0Set",x=28, y=73, radius = 4.5, tooltip="0", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_0",speed=12,
        }},
        {ID = "SMODE_F1Set",x=5, y=22, radius = 4.5, tooltip="F1", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_F1",speed=12,
        }},
        {ID = "SMODE_F2Set",x=22, y=22, radius = 4.5, tooltip="F2", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_F2",speed=12,
        }},
        {ID = "SMODE_F3Set",x=41, y=22, radius = 4.5, tooltip="F3", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_F3",speed=12,
        }},
        {ID = "SMODE_F4Set",x=60, y=22, radius = 4.5, tooltip="F4", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_F4",speed=12,
        }},
        {ID = "SMODE_F5Set",x=79, y=22, radius = 4.5, tooltip="F5", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_F5",speed=12,
        }},
        {ID = "SMODE_F6Set",x=98, y=22, radius = 4.5, tooltip="F6", model = {
			z=1,ang=Angle(-90,0,0),
			var = "SMODE_F6",speed=12,
        }},
    }
}
-- Стояночный
ENT.ClientProps["pipen"] = {
    model = "models/2k_int/2k_pipen.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
    scale=1,
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
        {ID = "AirDistributorDisconnectToggle",x=0,y=0,w= 170,h = 80,tooltip="ТЦ ОТЦ"},
    }
}
ENT.ButtonMap["AirDistributor2"] = {
    pos = Vector(-185,68,-50),
    ang = Angle(0,180,90),
    width = 170,
    height = 80,
    scale = 0.1,
    hideseat=0.1,
    hide=true,
    screenHide = true,

    buttons = {
        {ID = "3:AirDistributorDisconnectToggle",x=0,y=0,w= 170,h = 80,tooltip="ТЦ ОТЦ"},
    }
}
ENT.ButtonMap["AirDistributorSalon"] = {
    pos = Vector(-210,50,-30),
    ang = Angle(0,0,0),
    width = 170,
    height = 80,
    scale = 0.1,
    hideseat=0.1,
    hide=true,
    screenHide = true,

    buttons = {
        {ID = "2:AirDistributorDisconnectToggle",x=0,y=0,w= 170,h = 80,tooltip="ВРН"},
    }
}

ENT.ButtonMap["InfoTable"] = { 
    pos = Vector(458.2,-32.5,3.8),
    ang = Angle(0,90,90),
    width = 646,
    height = 100,
    scale = 0.1,
    hide = 2,
}
-- Маршрутник
ENT.ButtonMap["RouteNumber_2k"] = {
    pos = Vector(449.5,39,4.5),
    ang = Angle(0,-89,90),
    width = 30,
    height = 10,
    scale = 0.085,
    buttons = {
    {ID = "RouteNumber1Set",x=13,y=0,w=10,h=10, tooltip="-"},
    {ID = "RouteNumber2Set",x=20,y=0,w=10,h=10, tooltip="+"},
    {ID = "OkButtonSet",x=5,y=0,w=10,h=10, tooltip="Кнопка согласия смены номера маршрута"}, 
    }
}
-- Цифры для маршрутника( в кабине )
ENT.ClientProps["route_1_2k"] = { 
        model = "models/metrostroi_train/81-722/digits/digit.mdl",
        pos = Vector(449.6,37.7,5.4),
        ang = Angle(90,183,0),
        color=Color(175,250,20),
        hideseat=2, 
}
ENT.ClientProps["route_2_2k"] = { 
    model = "models/metrostroi_train/81-722/digits/digit.mdl",
    pos = Vector(449.6,36.9,5.4),
    ang = Angle(90,183,0),
    color=Color(175,250,20),
    hideseat=2, 
}
ENT.ButtonMap["RouteNumber1_2k"] = {
    pos = Vector(453.3,37.2,6.5),
    ang = Angle(0,90+3,90),
    width = 160,
    height = 90,
    scale = 0.05,
}
-- Фары
ENT.ClientProps["FariGroup1"] = {
    model = "models/metrostroi_train/81-5402/headlightled_2k_group1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["FariGroup2"] = {
    model = "models/metrostroi_train/81-5402/headlightled_2k_group2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
-- Салон
ENT.ClientProps["salon"] = {
    model = "models/2k_int/2k.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}

-- Поручни
ENT.ClientProps["handrails_new"] = {
    model = "models/2k_int/2k_handrail.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,90,0),
    hide=1.5,
    scale=1,
}
-- Красные фары
ENT.ClientProps["RedLights_l"] = {
    model = "models/metrostroi_train/81-5402/2k_lf_redlights.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["RedLights_r"] = {
    model = "models/metrostroi_train/81-5402/2k_rh_redlights.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["door_otsek1"] = {
    model = "models/2k_int/2k_door_otsek.mdl",
    pos = Vector(375.59,4.0336,4.7342),
    ang = Angle(0,-90,0),
    hideseat=1.7,
    scale=1,
}
-- Отсеки
ENT.ClientProps["door_otsek2"] = {
    model = "models/2k_int/2k_door_otsek2.mdl",
    pos = Vector(375.59,-39.01,1.5756), 
    ang = Angle(0,-90,0),
    hideseat=1.7,
}
ENT.ClientProps["cap_l"] = {
    model = "models/metrostroi_train/81-717/couch_cap_r.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=0.8,
}
ENT.ClientProps["door1"] = {
    model = "models/2k_int/2k_door_torec.mdl",
    pos = Vector(-473.7,18.8,-2.7),
    ang = Angle(0,-90,0),
    hide=2,
}
ENT.ClientProps["door2"] = {
    model = "models/2k_int/2k_cab_door.mdl",
    pos = Vector(0,-0.7,0),
    ang = Angle(0,0,0),
    scale=1,
    hide=2,
}
ENT.ClientProps["door3"] = {
    model = "models/metrostroi_train/81-5402/door_cabine_2k.mdl",
    pos = Vector(444.2,66.2,8.9),
    ang = Angle(0,180,0),
    hide=2,
}
ENT.ClientProps["cabine_2k"] = {
    model = "models/2k_int/cabine/2k_cab.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,90,0),
    hide=2,
    scale=1,
}
ENT.ClientProps["Controller"] = {
    model = "models/metrostroi_train/81-5402/kv_2k.mdl",
    pos = Vector(435.848+0.08,16.1,-19.779+4.75-0.01),
    ang = Angle(0,-90,-32),
    hideseat=0.2,   
}
ENT.ClientProps["Controller_otl"] = {
    model = "models/metrostroi_train/81-717/kv_wood.mdl",
    pos = Vector(435.848+0.08,16.1,-19.779+4.75-0.01),
    ang = Angle(0,-90,-32),
    hideseat=0.2,   
}
ENT.ClientProps["body_pult_2k"] = {
    model = "models/metrostroi_train/81-5402/pult/body_white.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(255,255,255),
    hide=2.5,
}
ENT.ButtonMap["BZOS_C"] = {
    pos = Vector(451.2,-35.15,-5.5),
    ang = Angle(90,180,0),
    width = 16,
    height = 100,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "SAB1ToggleSwitch",x=12, y=56.2, radius=8, tooltip="Включение охранной сигнализации кабины", model = {
            model = "models/2k_int/signalka_tumbler.mdl",ang = Angle(0,-90,0),z=-5,
            getfunc = function(ent) return ent:GetPackedRatio("SAB1ToggleSwitch") end, var="SAB1ToggleSwitch",
            speed=16,min=1,max=0.5,
            sndvol = 0.5,snd = function(val) return val and "pnm_on" or "pnm_off" end,
            sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID="SAB1ToggleSwitch+",x=0, y=40.2, w=16,h=10, tooltip="Охранная сигнализация: +"},
		{ID="SAB1ToggleSwitch-",x=0, y=60.2, w=16,h=10, tooltip="Охранная сигнализация: -"},
        {ID = "!VH1",x=12.5, y=22.5, radius=4, tooltip="Охранная сигнализация: работа", model = {
            lamp = {speed=16,model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",z=-3,var="VH1",color=Color(175,250,20)}},
        },
        {ID = "!VH2",x=12.5, y=40, radius=4, tooltip="Охранная сигнализация: сработка", model = {
            lamp = {speed=16,model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",z=-3,var="VH2",color=Color(255,56,30)}},
        },
    }
}
-- Пульт
ENT.ClientProps["pult_2k"] = {
    model = "models/metrostroi_train/81-5402/pult/pult_5402_main.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(255,255,255),
    hideseat=0.8,
}
-- АЛС
ENT.ClientProps["alspanel_2k"] = {
     model =  "models/metrostroi_train/81-5402/pult/2k_flars_luds.mdl",
    pos = Vector(0.1,0,0.05),
    ang = Angle(0,0,0),
    hideseat=0.8,
}
-- Информатор
ENT.ClientProps["radioinformator_2k"] = {
    model = "models/metrostroi_train/81-717/pult/asnp_flars2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(255,255,255),
    hideseat=0.8,
}
-- Блики
ENT.ButtonMap["Block5_6b_2k"] = {
    pos = Vector(455.0-6,12.3,2.5-10.5+5.35),--446 -- 14 -- -0,5
    ang = Angle(0,-90,44), 
    width = 480,
    height = 225,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
     
        {ID = "GreenRPLightB",x=107,y=95,radius=20,tooltip="",model = {
            lamp = {model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",var="GRP",scale=1.35,x=0,z=-1,color=Color(50,255,160)},
        }},
       
        {ID = "LKVPLightB",x=440,y=35,radius=20,tooltip="ЛКВП: Лампа контроля включения преобразователя",model = {
            lamp = {model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",var="LKVP",scale=1.35,x=0,z=-1,color=Color(0, 255, 0)},
        }},
        {ID = "AVULight3b",x=378,y=35,radius=20,tooltip="АВУ: Лампа сработки АВУ",model = {
            lamp = {model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",var="AVU",scale=1.35,z=-1,color=Color(255,25,40)}
        }},
        {ID = "LZBPLightb",x=409,y=35,radius=20,tooltip="ЛЗБП: Лампа защиты блока питания",model = {
            lamp = {model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",scale=1.35,z=-1,var= "LZBP",color=Color(255,25,40)}
        }},

        {ID = "KDLLightB",x=65,y=135,radius=20,tooltip="",model = {
            lamp = {model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",scale=1,z=-1,var="DR1",color=Color(255,255,255)}
        }},
        {ID = "KDLRLightB",x=155,y=135,radius=20,tooltip="",model = {
            lamp = {model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",scale=1,z=-1,var="DR1",color=Color(255,255,255)}
        }},
    }
}
-- 5 и 6 блок
ENT.ButtonMap["Block5_6_2k"] = {
    pos = Vector(455.0-6,12.3,2.5-10.5+5.35),--446 -- 14 -- -0,5
    ang = Angle(0,-90,44), 
    width = 480,
    height = 225,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {   ID = "R_ASNPOnToggle",x=107+17*1,y=34,radius=20,tooltip="Радиоинформатор: Питание",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-6,
            var="R_ASNPOn",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_on" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {   ID = "R_UNchToggle",x=65+42*0,y=34,radius=20,tooltip="Радиоинформатор: Динамик салона",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-6,
            var="R_UNch",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {   ID = "R_VPRToggle",x=65+28*1,y=34,radius=20,tooltip="Экстренная связь",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-6,
            var="R_VPR",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=135,x=-13.9,y=-18,z=2,var="R_ZSPl",ID="R_ZSPl",},
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "R_Program1Set",x=155,y=34,radius=20,tooltip="Радиоинформатор: Пуск записи",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3, 
            var="R_Program1",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button2_off" end,
            sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "!GreenRPLight",x=107,y=95,radius=20,tooltip="Зеленая лампа РП",model = {
            model = "models/metrostroi_train/81-717/lamps/ad1622_white.mdl",ignorepanel = true,scale=1.3,z=-5,color=Color(30,160,100),
            lamp = {model = "models/metrostroi_train/81-717/lamps/ad1622_white_emissive.mdl",var="GRP",scale=1.35,z=1,color=Color(50,255,160)},
        }},
       
        {ID = "!LKVPLight",x=440,y=35,radius=20,tooltip="ЛКВП: Лампа контроля включения преобразователя",model = {
            model = "models/metrostroi_train/81-717/lamps/ad1622_white.mdl",ignorepanel = true,scale=1.3,z=-5,color=Color(30,160,100),
            lamp = {model = "models/metrostroi_train/81-717/lamps/ad1622_white_emissive.mdl",var="LKVP",z=1,scale=1.35,color=Color(0, 255, 0)}
        }},
     
        {ID = "VozvratRPSet",x=107,y=134,radius=20,tooltip="Кнопка возврата РП, включение БВ",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="VozvratRP",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button1_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "KRZDSet",x=153,y=85,radius=20,tooltip="КРЗД: Кнопка резервного закрытия дверей",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="KRZD",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "ARSToggle",x=330,y=78,radius=20,tooltip="АРС: Автоматическое регулирование скорости",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",ang = 180,z=0,
            var="ARS",speed=16,scale=1,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {   ID = "V13Toggle",x=280,y=78,radius=20,tooltip="Включение аварийной вентиляции",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",ang = 180,z=-3,
            var="V13",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "ALSToggleSwitch",x=379,y=78,radius=0,tooltip="АЛС: Автоматическая локомотивная сигнализация",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_b_a.mdl",scale=1,z=1.6,ang=0,
			getfunc = function(ent) return ent:GetPackedRatio("ALSToggleSwitch") end, var="ALSToggleSwitch",
			speed=16,min=1,max=0.1,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(0,180,0),
        }},
        {ID="ALSToggleSwitch+",x=370, y=60, w=20,h=30, tooltip="АЛС: +"},
		{ID="ALSToggleSwitch-",x=370, y=80, w=20,h=30, tooltip="АЛС: -"},
        {ID = "ARSRToggle",x=422,y=78,radius=20,tooltip="АРС-Р: Резервный комплект АРС",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",ang = 180,z=0,
            var="ARSR",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "!LZBPLight",x=409,y=35,radius=20,tooltip="ЛЗБП: Лампа защиты блока питания",model = {
            model = "models/metrostroi_train/81-717/lamps/ad1622_white.mdl",ignorepanel = true,scale=1.3,z=-5,color=Color(165,15,25),
            lamp = {model = "models/metrostroi_train/81-717/lamps/ad1622_white_emissive.mdl",scale=1.35,z=1,var= "LZBP",color=Color(255,25,40)}
        }},
        {ID = "!AVULight3",x=378,y=35,radius=20,tooltip="АВУ: Лампа сработки АВУ",model = {
            model = "models/metrostroi_train/81-717/lamps/ad1622_white.mdl",ignorepanel = true,scale=1.3,z=-5,color=Color(165,15,25),
            lamp = {model = "models/metrostroi_train/81-717/lamps/ad1622_white_emissive.mdl",var="AVU",scale=1.35,z=1,color=Color(255,25,40)}
        }},
     
        {   ID = "KVTSet",x=263-(263-234)/2,y=36,radius=20,tooltip="Кнопка бдительности",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",z = -3,
            var="KVT",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button1_off" end,
            sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {   ID = "KVTRSet",x=290,y=36,radius=20,tooltip="Кнопка бдительности от АРС-Р",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",z = -3,
            var="KVTR",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button1_off" end,
            sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "VUD1Toggle",x=65,y=89,radius=20,tooltip="ВУД: Выключатель управления дверьми",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-6,ang=0,
            var="VUD1",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "!KDLLight",x=65,y=135,radius=20,tooltip="Лампа разблокировки левых дверей",model = {
            model = "models/metrostroi_train/81-717/lamps/ad1622_white.mdl",ignorepanel = true,scale=1.3,z=-5,color=Color(185,195,210),
            lamp = {model = "models/metrostroi_train/81-717/lamps/ad1622_white_emissive.mdl",scale=1.35,z=1,var="DR1",color=Color(255,255,255)}
        }},
        {ID = "!KDLRLight",x=155,y=135,radius=20,tooltip="Лампа разблокирвоки левых дверей",model = {
            model = "models/metrostroi_train/81-717/lamps/ad1622_white.mdl",ignorepanel = true,scale=1.3,z=-5,color=Color(185,195,210),
            lamp = {model = "models/metrostroi_train/81-717/lamps/ad1622_white_emissive.mdl",scale=1.35,z=1,var="DR1",color=Color(255,255,255)}
        }},
       
        {ID = "KDLSet",x=65,y=173,radius=20,tooltip="Кнопка открытия левых дверей",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",
            var="KDL",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "KDLRSet",x=155,y=173,radius=20,tooltip="Кнопка открытия левых дверей",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",
            var="KDLR",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "KDLRKToggle",x=135,y=183,w=40,h=20,tooltip="Крышка кнопки открытия левых дверей",model = {
            model = "models/metrostroi_train/81/krishka.mdl",ang = 0,z = -3,
            var="KDLRK",speed=8,min=0.32,max=0.68,disable="KDLRSet",
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "KDLKToggle",x=45,y=183,w=40,h=20,tooltip="Крышка кнопки открытия левых дверей",model = {
            var="KDLK",speed=8,min=0.32,max=0.68,disable="KDLSet",
            model = "models/metrostroi_train/81/krishka.mdl",ang = 0,z = -3,
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "L_1Toggle",x=354,y=181,radius=20,tooltip="Освещение салона",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-8,ang=180,
            var="L_1",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "L_2Toggle",x=392,y=181,radius=20,tooltip="Освещение кабины",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-8,ang=180,
            var="L_2",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "L_3Toggle",x=430,y=181,radius=20,tooltip="Подсветка приборов",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-8,ang=180,
            var="L_3",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "VZ1Set",x=328,y=36,radius=20,tooltip="ВЗ1: Кнопка включения вентиля замещения 1",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="VZ1",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button2_off" end,
            sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "OtklBVSet",x=292,y=120,radius=20,tooltip="Кнопка отключения БВ",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="OtklBV",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button1_off" end,
            sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "OtklBVKToggle",x=272,y=130,w=40,h=20,tooltip="Крышка кнопки отключения БВ",model = {
            model = "models/metrostroi_train/81/krishka.mdl",ang = 0,z = -1,
            var="OtklBVK",speed=8,min=0.378,max=0.685,disable="OtklBVSet",
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=135,x=-17,y=-45,z=-0,var="OtklBVPl",ID="OtklBVPl",},
            getfunc = function(ent) return ent:GetPackedBool("OtklBVK") and 1 or ent.Anims.ARSRToggle and math.max(0,(ent.Anims.ARSRToggle.val-0.5)*2 or 0)^0.2*0.08 or 0 end,
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "OVTToggle",x=240,y=120,radius=10,tooltip="ОВТ: Отключение вентильных тормозов ",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-5,ang=180,
            var="OVT",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=24,z=2,var="OVTPl",ID="OVTPl",},
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "OtklAVUToggle",x=279,y=181,radius=20,tooltip="ОАВУ: Отключение АВУ",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-8,ang=180,
            var="OtklAVU",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=24,z=3,var="OtklAVUPl",ID="OtklAVUPl",},
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "VNToggle",x=240,y=181,radius=20,tooltip="ВН: Выключатель направления",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",z=-8,ang=180,
            var="VN",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=24,z=3,var="VNPl",ID="VNPl",},
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "ConverterProtectionSet",x=339,y=120,radius=20,tooltip="Защита блока питания",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z=-3,
            var="ConverterProtection",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "KSNSet",x=385,y=120,radius=20,tooltip="КСН: Кнопка сигнализации неисправности",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z=-3,
            var="KSN",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button1_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "RingSet",x=429,y=120,radius=20,tooltip="Перадача управления (Звонок)",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z=-3,
            var="Ring",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "DoorSelectToggle",x=107.5,y=183.5,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-8,
            var="DoorSelect",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }}, 
        {ID = "ALSFreqToggle",x=316,y=181,radius=20,tooltip="Дешифратор",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-8,
            var="ALSFreq",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
} 
ENT.ButtonMap["Block7_b"] = {
    pos = Vector(446.22,-17.6,-5.48+5.35),
    ang = Angle(0,-90,58),
    width = 178,
    height = 222,
    scale = 0.0625,
    hideseat=0.2,
    buttons = {
    
        {ID = "DoorsrB",x=61,y=130,radius=20,tooltip="Лампа разблокировки правых дверей",model = {
            lamp = {model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",ang=81,x=0,y=0,z=1,scale=1.35,var="DR2",color=Color(255, 255, 255)},
        }},
        {ID = "PNWB",x=135,y=130,radius=20,tooltip="Тормоз состава",model = {
            lamp = {model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",ang=81,x=0,y=0,z=0,scale=1.35,z=1,var="PN",color=Color(255, 255, 0)},
        }},
    }
}
ENT.ButtonMap["Block7"] = {
    pos = Vector(446.22,-17.6,-5.48+5.35),
    ang = Angle(0,-90,58),
    width = 178,
    height = 222,
    scale = 0.0625,
    hideseat=0.2,
    buttons = {
        {ID = "L_4Toggle",x=43,y=181,radius=20,tooltip="Ближний свет",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-4,
            var="L_4",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "VUSToggle",x=75.9,y=181,radius=20,tooltip="Дальний свет",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-4,
            var="VUS",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "VADToggle",x=108.9,y=181,radius=20,tooltip="ВАД: Выключатель аварийных дверей",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-4,
            var="VAD",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=25,z=4,var="VADPl",ID="VADPl",},
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "VAHToggle",x=141.9,y=181,radius=20,tooltip="ВАХ: Выключатель аварийного хода",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-4,
            var="VAH",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "KRPSet",x=43,y=30,radius=20,tooltip="КРП: Кнопка резервного пуска",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -2,
            var="KRP",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button1_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "KAHSet",x=43,y=88,radius=20,tooltip="КАХ: Кнопка аварийного хода",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -2,
            var="KAH",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "KAHKToggle",x=23,y=98,w=40,h=20,tooltip="Крышка кнопки КАХ",model = {
            model = "models/metrostroi_train/81-5402/krishka_kah.mdl",ang = 0,z = -1,scale=1,
            var="KAHK",speed=8,min=0.46,max=0.685,disable="KAHSet",
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=135,x=-17,y=-45.9,z=1,var="KAHPl",ID="KAHPl",},
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "KDPSet",x=92,y=130,radius=20,tooltip="Кнопка открытия правых дверей",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",
            var="KDP",speed=16,min=1,max=0,z=2,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},       
        {ID = "!Doorsr",x=61,y=133,radius=20,tooltip="Лампа разблокировки правых дверей",model = {
            model = "models/metrostroi_train/81-717/lamps/ad1622_white.mdl",color=Color(255, 255, 255),skin = 4,z = -1,scale=1.3,
            lamp = {model = "models/metrostroi_train/81-717/lamps/ad1622_white_emissive.mdl",ang=81,x=0,y=0,z=1,scale=1.35,var="DR2",color=Color(255, 255, 255)},
        }},

        {ID = "KDPKToggle",x=72,y=140,w=40,h=20,tooltip="Крышка кнопки открытия правых дверей",model = {
            model = "models/metrostroi_train/81-5402/2k_locker_doorsrh.mdl",ang = 90,z = -0,
            var="KDPK",speed=8,min=0.8,max=0.08,disable="KDPSet",
            sndvol = 1,snd = function(val,realval) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "!PNW",x=135,y=130,radius=20,tooltip="Тормоз состава",model = {
            model = "models/metrostroi_train/81-717/lamps/ad1622_white.mdl",scale=1.3,color=Color(255, 215, 0),skin = 4,z = -1,
            lamp = {model = "models/metrostroi_train/81-717/lamps/ad1622_white_emissive.mdl",ang=81,x=0,y=0,z=0,scale=1.35,z=1,var="PN",color=Color(255, 255, 0)},
        }},
    
    }
}
ENT.ButtonMap["Block1_1"] = {
    pos = Vector(450.4,10.2,1.3+6.30),
    ang = Angle(0,90,36),
    width = 290,
    height = 110,
    scale = 0.0625,
    hideseat=1,
    buttons = {
        {ID = "Last_NextSet",x=145,y=80,radius=20,tooltip="Электронный маршрутный указатель: + ",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -2,scale=0.5,
            var="Last_Next",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "Last_PrevSet",x=180,y=80,radius=20,tooltip="Электронный маршрутный указатель: - ",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -2,scale=0.5,
            var="Last_Prev",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "WiperToggle",x=223,y=81,radius=40,tooltip="Стеклоочиститель",model = {
            model = "models/metrostroi_train/81-5402/buttons/breaker_dvornik.mdl",z=12,ang=0,
            var="Wiper",speed=0.5,vmin=1,vmax=0.87,scale=0.8,
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["Block1"] = {
    pos = Vector(450.4,28.2,1.3+5.35),
    ang = Angle(0,-90,58),
    width = 290,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,
    buttons = {
        {ID = "VMKToggle",x=37.5,y=38.5,radius=20,tooltip="Мотор-компрессор",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-3,
            var="VMK",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "BPSNonToggle",x=79,y=38.5,radius=20,tooltip="Блок питания",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-3,
            var="BPSNon",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "RezBPSNonToggle",x=120,y=38.5,radius=20,tooltip="Резервный блок питания",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-3,
            var="RezBPSNon",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=-90,x=0,y=23,z=2,var="RezBPSNonPl",ID="RezBPSNonPl",},
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "RezMKSet",x=148,y=82,radius=20,tooltip="Резервный МК",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -2,
            var="RezMK",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID="VVToggleSwitch+",x=95, y=80, w=20,h=30, tooltip="Яркость: +"},
        {ID = "VVToggleSwitch",x=95,y=90,radius=0,tooltip="",model = {
            model = "models/2k_int/krutilka_yar.mdl",scale=1,z=10,ang=0,
			getfunc = function(ent) return ent:GetPackedRatio("VVToggleSwitch") end, var="VVToggleSwitch",
			speed=16,min=1,max=0.1,
        }},
        {ID="VVToggleSwitch-",x=75, y=80, w=20,h=30, tooltip="Яркость: -"},
        {ID="VV1ToggleSwitch+",x=50, y=80, w=20,h=30, tooltip="Яркость: +"},
        {ID = "VV1ToggleSwitch",x=50,y=90,radius=0,tooltip="",model = {
            model = "models/2k_int/krutilka_yar.mdl",scale=1,z=10,ang=0,
			getfunc = function(ent) return ent:GetPackedRatio("VV1ToggleSwitch") end, var="VV1ToggleSwitch",
			speed=16,min=1,max=0.1,
        }},
		{ID="VV1ToggleSwitch-",x=25, y=80, w=20,h=30, tooltip="Яркость: -"},
        {ID = "!BatteryVoltage", x=220,y=55,radius=60,tooltip=""},
    }
}
ENT.ButtonMap["PredPanel"] = {
    pos = Vector(396,16.9,5),
    ang = Angle(-90,180,0),
    width = 450,
    height = 100,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "Pred2",x=350 ,y=25,w=100,h=50,tooltip="П-1 (аккумуляторная батарея)",model = {
            var="Pred1",disable="Pred2BToggle", 
        }},
        {ID = "Pred2BToggle",x=250 ,y=25,w=100,h=50,tooltip="П-1 (аккумуляторная батарея)",model = {
            var="Pred2B", 
        }},
        {ID = "Pred1",x=80,y=25,w=100,h=50,tooltip="П-11 (резервное управление)",model = {
            var="Pred2",disable="Pred1BToggle",
        }},  
        {ID = "Pred1BToggle",x=0 ,y=25,w=100,h=50,tooltip="П-11 (резервное управление)",model = {
            var="Pred2B", 
        }},    
    }
}

ENT.ClientProps["pred2"] = {
	model = "models/metrostroi_train/81-5402/BP15.mdl",
	pos = Vector(393,20.5,28),
    ang = Angle(-90,180,0),
    hide=1.5,
}

ENT.ClientProps["pred1"] = {
    model = "models/metrostroi_train/81-5402/BP15.mdl",
    pos = Vector(393,20.5,10),
    ang = Angle(-90,180,0),
	hide = 1.5,
} 
ENT.ClientProps["pred2b"] = {
    model = "models/metrostroi_train/81-5402/BP15_sg.mdl",
    pos = Vector(395,20.5,28),
    ang = Angle(-90,180,0),
	hide = 1.5,
}
ENT.ClientProps["pred1b"] = {
    model = "models/metrostroi_train/81-5402/BP15_sg.mdl",
    pos = Vector(395,20.5,10),
    ang = Angle(-90,180,0),
	hide = 1.5,
}
ENT.ButtonMap["Block3"] = {
    pos = Vector(450.4,-10,1.3+5.35),
    ang = Angle(0,-90,58),
    width = 290,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "!BLTLPressure", x=62, y=55, radius=55, tooltip="Давление в тормозной и напорной магистрали"},
        {ID = "!BCPressure", x=182, y=55, radius=55, tooltip="Давление в тормозном цилиндре"},
    }
}


ENT.ButtonMap["InfButtons"] = {
    pos = Vector(445,24.75,-2),
    ang = Angle(0,-90,58.2),
    width = 100,
    height = 150,
    scale = 0.068,
    hideseat=0.2,

    buttons = {
        {ID = "INF_Lamp1",x=45,y=61+16*0+4.5,radius=0,tooltip="L1",model = {
			lamp = {speed=16,model = "models/metrostroi_train/81-717/pult/asnp_flars_lamp.mdl", var="InfLamp1", ang=0,color=Color(255,255,255),x=0,y=-15,z=0},
		}},	
        {ID = "INF_Lamp2",x=64,y=61+16*0+4.5,radius=0,tooltip="L2",model = {
			lamp = {speed=16,model = "models/metrostroi_train/81-717/pult/asnp_flars_lamp.mdl", var="InfLamp2", ang=0,color=Color(255,255,255),x=0,y=-15,z=0},
		}},	
        {ID = "INF_Lamp3",x=82.5,y=61+16*0+4.5,radius=0,tooltip="L3",model = {
			lamp = {speed=16,model = "models/metrostroi_train/81-717/pult/asnp_flars_lamp.mdl", var="InfLamp3", ang=0,color=Color(255,255,255),x=0,y=-15,z=0},
		}},	
		
        {ID = "INF_1Set",x=45,y=61.5+16*0,radius=6,tooltip="1"},
        {ID = "INF_2Set",x=64,y=61.5+16*0,radius=6,tooltip="2"},
        {ID = "INF_3Set",x=82.6,y=61.5+16*0,radius=6,tooltip="3"},
        {ID = "INF_4Set",x=45,y=61.5+16*1-1,radius=6,tooltip="4"},
        {ID = "INF_5Set",x=45,y=61.5+16*2-2,radius=6,tooltip="5"},
        {ID = "INF_6Set",x=45,y=61.5+16*3-3.5,radius=6,tooltip="6"},
        {ID = "INF_7Set",x=82.6,y=61.5+16*1-1,radius=6,tooltip="7"},
        {ID = "INF_8Set",x=82.6,y=61.5+16*2-2,radius=6,tooltip="8"},
        {ID = "INF_9Set",x=82.6,y=61.5+16*3-3,radius=6,tooltip="9"},    		
        {ID = "INF_PrevSet",x=45,y=61+16*4-4,radius=6,tooltip="◀"},  		
        {ID = "INF_StopSet",x=64,y=61+16*4-4,radius=6,tooltip="■"},		
        {ID = "INF_NextSet",x=82.6,y=61+16*4-4,radius=6,tooltip="▶"},
        {ID = "INF_PlaySet",x=64.2,y=61+16*5-4.7,radius=6,tooltip="⯈"},  		
    }
}
for k,buttbl in ipairs(ENT.ButtonMap["InfButtons"].buttons) do
	local id = buttbl.ID:Replace("Set","")
	if not buttbl.model then
		buttbl.model = {
			var = id,speed=9,z=-0.5,
			sndvol = 0.07,snd = function(val) return val and "informbutton_press" or "iformbutton_release" end,
			sndmin = 60,sndmax = 1e3,sndang = Angle(-90,0,0),			
		}
		local num = id:Replace("INF_","")
		if num == "Play" then
			buttbl.model.model = "models/metrostroi_train/81-540.3k/pult/buttons/asnp_flars_button_red.mdl"			
        elseif num == "Prev" then 
            buttbl.model.model = "models/metrostroi_train/81-540.3k/pult/buttons/asnp_flars_button_prev.mdl"	
        elseif num == "Stop" then 
            buttbl.model.model = "models/metrostroi_train/81-540.3k/pult/buttons/asnp_flars_button_stop.mdl"
        elseif num == "Next" then 
            buttbl.model.model = "models/metrostroi_train/81-540.3k/pult/buttons/asnp_flars_button_next.mdl" 	
        else 
			buttbl.model.model = "models/metrostroi_train/81-540.3k/pult/buttons/asnp_flars_button"..num..".mdl"
		end
	end
end

ENT.ButtonMap["InfScreen"] = {
    pos = Vector(444.25,21.968,-7.4+4),
    ang = Angle(0,-90,58.0),
    width = 512,
    height = 149,
    scale = 0.00725,
    hideseat=0.2,
    hide=true,
}
ENT.ButtonMap["Block2_2k"] = {
    pos = Vector(450.4+0.35+0.1,10.0,1.3+5.35+0.05),
    ang = Angle(0,-90,58),
    width = 300,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "!Speedometer1",x=137.5,y=31,w=17,h=25,tooltip="",model = {
            name="SSpeed2",model = "models/metrostroi_train/81-717/segments/segment_spb.mdl",color=Color(175,250,20),skin=0,z=-1,ang=Angle(0,0,-90),
        }},
        {ID = "!Speedometer2",x=156.5,y=31,w=17,h=25,tooltip="",model = {
            name="SSpeed1",model = "models/metrostroi_train/81-717/segments/segment_spb.mdl",color=Color(175,250,20),skin=0,z=-1,ang=Angle(0,0,-90),
        }},
        {ID = "!ARSOch",x=103.7,y=36,w=10,h=10,tooltip="",model = {
            name="SAOCh",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ra.mdl",z=-0.7,var="AR04"},
        }},
        {ID = "!ARS0",x=92,y=35+9.9*0,w=10,h=10,tooltip="",model = {
            name="SA0",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ra.mdl",z=-0.7,var="AR0"},
        }},
        {ID = "!ARS40",x=92,y=35+10.9*1,w=10,h=10,tooltip="",model = {
            name="SA40",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-0.7,var="AR40"},
        }},
        {ID = "!ARS60",x=92,y=33+11.9*2,w=10,h=10,tooltip="",model = {
            name="SA60",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-0.7,color=Color(175,250,20),var="AR60"},
        }},
        {ID = "!ARS70",x=92,y=33+11.9*3,w=10,h=10,tooltip="",model = {
            name="SA70",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-0.7,color=Color(175,250,20),var="AR70"},
        }},
        {ID = "!ARS80",x=92,y=35+10.9*4,w=10,h=10,tooltip="",model = {
            name="SA80",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-0.7,color=Color(175,250,20),var="AR80"},
        }},
        {ID = "!LampLSD1",x=189,y=35.5,w=10,h=4,tooltip="",model = {
            name="SSD1",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-0.7,color=Color(175,250,20),var="SD"},
        }},
        {ID = "!LampLSD2",x=199,y=35.5,w=10,h=4,tooltip="",model = {
            name="SSD2",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-0.7,ang=90,color=Color(175,250,20),var="SD"},
        }},
        {ID = "!LampLVD",x=190.3,y=45.9+8.8*0,w=10,h=4,tooltip="",model = {
            name="SVD",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",var="A04",z=-0.7,color=Color(175,250,20),var="VD"},
        }},
        {ID = "!LampLHRK",x=190.3,y=45.9+8.8*1.1,w=10,h=4,tooltip="",model = {
            name="SRK",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-0.7,var="HRK"},
        }},
        {ID = "!LampLST",x=190.3,y=45.9+8.9*2.1,w=10,h=4,tooltip="",model = {
            name="SST",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-0.7,var="ST"},
        }},
        {ID = "!LampLRD",x=191.3,y=43.8+8.8*3,w=10,h=4,tooltip="",model = {
            name="SRD",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-0.2,color=Color(175,250,20),var="LRD"},
        }},
        {ID = "!LampRP",x=205.5,y=45.9+8.8*0,w=10,h=4,tooltip="",model = {
            name="SRP",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_rb.mdl",z=-0.7,var="RP"},
        }},
        {ID = "!LampLSN",x=215.5,y=45.9+8.8*0,w=10,h=4,tooltip="",model = {
            name="SSN",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_rb.mdl",z=-0.7,ang=-90,var="SN"},
        }},
        {ID = "!LampLKVD",x=215,y=47+8.8*1,w=10,h=4,tooltip="",model = {
            name="SKVD",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-0.7,var="KVD"},
        }},
        {ID = "!LampLKT",x=215,y=47+8.8*2,w=10,h=4,tooltip="",model = {
            name="SKT",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-0.7,var="KT"}, 
        }},
        {ID = "!LampDV",x=215,y=47.5+8.8*3,w=10,h=4,tooltip="ДВ",model = {
            name="SDV",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-0.7,color=Color(175,250,20),var="DV"},
        }},
        {ID = "!LampLKVC",x=190.3,y=45+9.8*4,w=10,h=4,tooltip="Лампа ЛКВЦ",model = {
            name="SKVC",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",ang=Angle(0,0,90),z=-0.7 ,var="KVC", getfunc=function(ent) return ent:GetPackedBool("KVC") and (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end},
        }},
        {ID = "!LampLN",x=190.3,y=45+9.8*3,w=10,h=4,tooltip="Лампа ЛН",model = {
            name="LN",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",ang=Angle(0,0,90),color=Color(175,250,20),z=-0.7,var="LN",getfunc=function(ent) return ent:GetPackedBool("LN") and (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end},
        }},
        {ID = "!Lamp14",x=215,y=45+9.8*4,w=10,h=4,tooltip="Лампа 1Ч",model = {
            name="14",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",ang=Angle(0,0,90),color=Color(175,250,20),z=-0.7,var="RS",getfunc=function(ent) return ent:GetPackedBool("RS") and (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end},
        }},
      
    }
}

for i=0,4 do
    ENT.ClientProps["TrainNumberL"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(41+16+i*6.6-5*6.6/2,67.4,-17.8),
        ang = Angle(0,180,0),
        skin=i,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
    ENT.ClientProps["TrainNumberR"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(64+16-i*6.6-5*6.6/2,-67.4,-17.8),
        ang = Angle(0,0,0),
        skin=i,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end
ENT.ButtonMap["AV_R"] = {
    pos = Vector(398.5+11,-52.9+0.6,37.1),
    ang = Angle(0,90,90),
    width = 398,
    height = 358,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "A11Toggle",x=29.7*0,y=155*0,w=25,h=45,tooltip=""},
        {ID = "A17Toggle",x=29.7*1,y=155*0,w=25,h=45,tooltip=""},
        {ID = "A44Toggle",x=29.7*2,y=155*0,w=25,h=45,tooltip=""},
        {ID = "A26Toggle",x=29.7*3,y=155*0,w=25,h=45,tooltip=""},
        {ID = "AR63Toggle",x=29.7*4,y=155*0,w=25,h=45,tooltip=""},
        {ID = "AS1Toggle",x=29.7*5,y=155*0,w=25,h=45,tooltip=""},
        {ID = "A21Toggle",x=29.7*6,y=155*0,w=25,h=45,tooltip=""},
        {ID = "AV1Toggle",x=29.7*7,y=155*0,w=25,h=45,tooltip="А 49"},
        {ID = "A27Toggle",x=29.7*8,y=155*0,w=25,h=45,tooltip=""},
        {ID = "A10Toggle",x=29.7*9,y=155*0,w=25,h=45,tooltip=""},
        {ID = "A53Toggle",x=29.7*10,y=155*0,w=25,h=45,tooltip=""},
        {ID = "A54Toggle",x=29.7*11,y=155*0,w=25,h=45,tooltip=""},
        {ID = "A84Toggle",x=29.7*12,y=155*0,w=25,h=45,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "A49Toggle",x=29.7*0,y=155*1,w=25,h=45,tooltip="АУ0"},
        {ID = "A76Toggle",x=29.7*1,y=155*1,w=25,h=45,tooltip="А 68"},
        {ID = "A48Toggle",x=29.7*2,y=155*1,w=25,h=45,tooltip=""},
        {ID = "A29Toggle",x=29.7*3,y=155*1,w=25,h=45,tooltip=""},
        {ID = "A46Toggle",x=29.7*4,y=155*1,w=25,h=45,tooltip=""},
        {ID = "A47Toggle",x=29.7*5,y=155*1,w=25,h=45,tooltip=""},
        {ID = "A79Toggle",x=29.7*6,y=155*1,w=25,h=45,tooltip=""},
        {ID = "A42Toggle",x=29.7*7,y=155*1,w=25,h=45,tooltip=""},
        {ID = "A74Toggle",x=29.7*8,y=155*1,w=25,h=45,tooltip=""},
        {ID = "A73Toggle",x=29.7*9,y=155*1,w=25,h=45,tooltip=""},
        {ID = "A71Toggle",x=29.7*10,y=155*1,w=25,h=45,tooltip=""},
        {ID = "A41Toggle",x=29.7*11,y=155*1,w=25,h=45,tooltip=""},
        {ID = "A45Toggle",x=29.7*12,y=155*1,w=25,h=45,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "A75Toggle",x=29.7*0,y=155*2,w=25,h=45,tooltip="АВ-К"},
        {ID = "A59Toggle",x=29.7*1,y=155*2,w=25,h=45,tooltip="A 77"},
        {ID = "A58Toggle",x=29.7*2,y=155*2,w=25,h=45,tooltip="А 78"},
        {ID = "A43Toggle",x=29.7*3,y=155*2,w=25,h=45,tooltip=""},
        {ID = "A31Toggle",x=29.7*4,y=155*2,w=25,h=45,tooltip=""},
        {ID = "A32Toggle",x=29.7*5,y=155*2,w=25,h=45,tooltip=""},
        {ID = "A13Toggle",x=29.7*6,y=155*2,w=25,h=45,tooltip=""},
        {ID = "A1Toggle",x=29.7*7,y=155*2,w=25,h=45,tooltip=""},
        {ID = "A20Toggle",x=29.7*8,y=155*2,w=25,h=45,tooltip=""},
        {ID = "A25Toggle",x=29.7*9,y=155*2,w=25,h=45,tooltip=""},
        {ID = "A30Toggle",x=29.7*10,y=155*2,w=25,h=45,tooltip=""},
        {ID = "A56Toggle",x=29.7*11,y=155*2,w=25,h=45,tooltip=""},
        {ID = "A65Toggle",x=29.7*12,y=155*2,w=25,h=45,tooltip=""},
    }
}
for i,button in pairs(ENT.ButtonMap.AV_R.buttons) do
    button.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",z=-25,
        var=button.ID:Replace("Toggle",""),speed=8,
        sndvol = 0.8,snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
    }
    button.ID = "2:"..button.ID
end
ENT.ButtonMap["AV_S"] = {
    pos = Vector(392,-33,-20),
    ang = Angle(0,270,90),
    width = 300,
    height = 220,
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
		{ID = "A8Toggle",x=25*11,y=60*0,w=25,h=45,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "A12Toggle",x=25*0,y=90*1,w=25,h=45,tooltip=""},
        {ID = "A16Toggle",x=25*1,y=90*1,w=25,h=45,tooltip=""},
        {ID = "A37Toggle",x=25*2,y=90*1,w=25,h=45,tooltip=""},
        {ID = "A51Toggle",x=25*3,y=90*1,w=25,h=45,tooltip=""},
        {ID = "A24Toggle",x=25*4,y=90*1,w=25,h=45,tooltip=""},
        {ID = "A19Toggle",x=25*5,y=90*1,w=25,h=45,tooltip=""},
        {ID = "A66Toggle",x=25*6,y=90*1,w=25,h=45,tooltip=""},
        {ID = "A18Toggle",x=25*7,y=90*1,w=25,h=45,tooltip=""},
        {ID = "A40Toggle",x=25*8,y=90*1,w=25,h=45,tooltip=""},
        {ID = "A80Toggle",x=25*9,y=90*1,w=25,h=45,tooltip=""},
		{ID = "A50Toggle",x=25*10,y=90*1,w=25,h=45,tooltip=""},
        {ID = "A52Toggle",x=25*11,y=90*1,w=25,h=45,tooltip=""},
		------------------------------------------------------------------------
        {ID = "AV3Toggle",x=25*1,y=88.5*2,w=25,h=45,tooltip=""},
		{ID = "AISToggle",x=0,y=88.5*2,w=25,h=45,tooltip=""},
        {ID = "A82Toggle",x=25*4,y=88.5*2,w=25,h=45,tooltip="Не используется"},
        {ID = "A83Toggle",x=25*3,y=88.5*2,w=25,h=45,tooltip="Не используется"},
        {ID = "A15Toggle",x=25*5,y=88.5*2,w=25,h=45,tooltip=""},
        {ID = "AV6Toggle",x=25*2,y=88.5*2,w=25,h=45,tooltip=""},
        {ID = "A57Toggle",x=25*6,y=88.5*2,w=25,h=45,tooltip=""},
        {ID = "A81Toggle",x=25*7,y=88.5*2,w=25,h=45,tooltip=""},
        {ID = "A7Toggle",x=25*8,y=88.5*2,w=25,h=45,tooltip=""},
        {ID = "A9Toggle",x=25*9,y=88.5*2,w=25,h=45,tooltip=""},
        {ID = "A68Toggle",x=25*10,y=88.5*2,w=25,h=45,tooltip=""},
        {ID = "A72Toggle",x=25*11,y=88.5*2,w=25,h=45,tooltip=""},
        {ID = "VISToggle",x=25*-1,y=88.5*2,w=25,h=45,tooltip="БЖ ВИС"},
    }
}
for i,button in pairs(ENT.ButtonMap.AV_S.buttons) do
    button.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",z=-25,
        var=button.ID:Replace("Toggle",""),speed=8,
        sndvol = 0.8,snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
    }
end
ENT.ButtonMap["Battery_R"] = {
    pos = Vector(410.0,-55.25,9),
    ang = Angle(0,90,90),
    width = 440,
    height = 157,
    scale = 0.0625,
    hide=0.8,
    buttons = {
        {ID = "2:RC1Toggle",x=150,y=60,radius=40,tooltip="",model = {
            model = "models/metrostroi_train/81-5402/buttons/breaker_rc1.mdl",z=17,ang=180,
            var="RC1",speed=0.5,vmin=1,vmax=0.87,
            plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=230,x=-28,y=28,var="RC1Pl",ID="RC1Pl",z=-15,},
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:VBToggle",x=260,y=60,radius=40,tooltip="",model = {
            model = "models/metrostroi_train/81-5402/buttons/breaker_vb.mdl",z=17,ang=180,
            var="VB",speed=0.5,vmin=1,vmax=0.87,
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "2:UOSToggle",x=350,y=60,radius=40,tooltip="",model = {
            model = "models/metrostroi_train/81-5402/buttons/breaker_rcuos.mdl",z=17,ang=180,
            var="UOS",speed=0.5,vmin=1,vmax=0.87,
            -- plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=0,x=25,y=28,var="UOSPl",ID="UOSPl",z=-15,},
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "OHStekloToggle",x=419,y=30,radius=40,tooltip="Обогреватель стекла",model = {
            model = "models/metrostroi_train/81-5402/buttons/breaker_obost.mdl",z=17,ang=180,
            var="OHSteklo",speed=0.5,vmin=1,vmax=0.87,
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "OHMirrorToggle",x=419,y=30*3.3,radius=40,tooltip="Обогреватель зеркал",model = {
            model = "models/metrostroi_train/81-5402/buttons/breaker_obomirr.mdl",z=17,ang=180,
            var="OHMirror",speed=0.5,vmin=1,vmax=0.87,
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ClientProps["reverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = Vector(438,-29.9,-14.9),
    ang = Angle(-90-22,180,90),
    hideseat=0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
ENT.ClientProps["krureverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
   	pos = Vector(443.56,-24.487,-2.8713),
	ang = Angle(-240,-0.98,-180),

    hideseat=0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}

-- UAVA
ENT.ButtonMap["UAVAPanel"] = {
    pos = Vector(432,-57,-25.0),
    ang = Angle(0,180,90),
    width = 180,
    height = 200,
    scale = 0.0625,

    buttons = {
        {ID = "UAVAToggle",x=0, y=0, w=60, h=200, tooltip="", model = {
            plomb = {var="UAVAPl", ID="UAVAPl",},
            var="UAVA",
            sndid="UAVALever",sndvol = 1, snd = function(val) return val and "uava_on" or "uava_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ClientProps["UAVALever"] = {
    model = "models/metrostroi_train/81-703/cabin_uava.mdl",
    pos = Vector(430.7,-56.4,-31.6),
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
            {ID = "EmergencyBrakeValveToggle",x=0,y=0,w=200,h=1300,tooltip=""},
    }
}
ENT.ClientProps["stopkran"] = {
    model = "models/metrostroi_train/81-717/stop_spb.mdl",
    pos = Vector(408.50,62.15,11.2),
    ang = Angle(0,0,0),
    hideseat=0.2,
    color=Color(255, 255, 255),
}
ENT.ClientSounds["EmergencyBrakeValve"] = {{"stopkran",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ButtonMap["DriverValveBLDisconnect"] = {
    pos = Vector(426.1,-27.3,-20),
    ang = Angle(90,-150,90),
    width = 200,
    height = 100,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveBLDisconnectToggle", x=0, y=0, w=200, h=100, tooltip="", model = {
            var="DriverValveBLDisconnect",sndid="brake_disconnect",
            sndvol = 1, snd = function(val) return "disconnect_valve" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["DriverValveTLDisconnect"] = {
    pos = Vector(429.3,-23,-15),
    ang = Angle(90,-150,90),
    width = 200,
    height = 90,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveTLDisconnectToggle", x=0, y=0, w=200, h=90, tooltip="", model = {
            var="DriverValveTLDisconnect",sndid="train_disconnect",
            sndvol = 1, snd = function(val) return val and "pneumo_TL_open" or "pneumo_TL_disconnect" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["EPVDisconnect"] = {
    pos = Vector(435,-40,-35),
    ang = Angle(0,-90-45,45),
    width = 200,
    height = 120,
    scale = 0.0625,

    buttons = {
        {ID = "EPKToggle",x=0,y=0,w=200,h=120,tooltip="",model = {
            var="EPK"--,sndid="EPK_disconnect",
            --sndvol = 1,snd = function(val) return "disconnect_valve" end,
            --sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["ParkingBrake"] = {
    pos = Vector(443,-20,-40.5),
    ang = Angle(0,-90,0),
    width = 200,
    height = 120,
    scale = 0.0625,

    buttons = {
        {ID = "ParkingBrakeToggle",x=0,y=0,w=200,h=120,tooltip="",model = {
            var="ParkingBrake",sndid="parking_brake",
            sndvol = 1,snd = function(val) return "disconnect_valve" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ClientProps["parking_brake"] = {
    model = "models/2k_int/2k_cranewhite.mdl",
    pos = Vector(438.22,-26.7,-40.498),
    ang = Angle(0,-90,0),
    scale=1,
}
ENT.ClientProps["brake_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran3.mdl",
    pos = Vector(427.3,-28.9,-32.5),
    ang = Angle(90,-60,90),
    hideseat=0.2,
}
ENT.ClientSounds["EPK"] = {
    {"EPK_disconnect",function() return "disconnect_valve" end,1,1,90,1e3,Angle(-90,0,0)},
    {"EPV_disconnect",function() return "disconnect_valve" end,1,1,90,1e3,Angle(-90,0,0)},
}

ENT.ClientProps["EPV_disconnect"] = {
    model = "models/2k_int/2k_cranered.mdl",
    pos = Vector(0,0,0),--Vector(428.5,-42.9,-39.5),
    ang = Angle(0,0,0),
    scale=1,
}

ENT.ButtonMap["DriverValveDisconnect"] = {
    pos = Vector(425,-23,-27),
    ang = Angle(90,-150,90),
    width = 200,
    height = 90,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveDisconnectToggle",x=0,y=0,w=200,h=90,tooltip="",model = {
            var="DriverValveDisconnect",sndid="valve_disconnect",
            sndvol = 1,snd = function(val) return "disconnect_valve" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ClientProps["valve_disconnect"] = {
    model = "models/2k_int/2k_craneblue.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
}
ENT.ButtonMap["FrontPneumatic"] = {
    pos = Vector(470-9,-45.0,-58.0+5),
    ang = Angle(0,90,90),
    width = 900,
    height = 100,
    scale = 0.1,
    hideseat=0.2,
    hide=true,
    screenHide = true,

    buttons = {
        {ID = "FrontBrakeLineIsolationToggle",x=000, y=0, w=400, h=100, tooltip=""},
        {ID = "FrontTrainLineIsolationToggle",x=500, y=0, w=400, h=100, tooltip=""},
    }
}
ENT.ClientProps["FrontBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(449+12, -26, -62),
    ang = Angle(-15,-90,0),
    hide = 2,
}
ENT.ClientProps["FrontTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(449+12, 26, -62),
    ang = Angle( 15,-90,0),
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
ENT.ButtonMap["OtsekDoor1"] = {
    pos = Vector(394.5,28,12.6),
    ang = Angle(0,180,90),
    width = 310,
    height = 130,
    scale = 0.1/2,
    buttons = {
        {ID = "OtsekDoor1",x=0,y=0,w=310,h=130,tooltip="",model = {
            var="door_otsek1",sndid="door_otsek1",
            sndvol = 1,snd = function(val) return "otsek_door_close" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["OtsekDoor2"] = {
    pos = Vector(394.5,28,-15.5),
    ang = Angle(0,180,90),
    width = 310,
    height = 130,
    scale = 0.1/2,
    buttons = {
        {ID = "OtsekDoor2",x=0,y=0,w=310,h=130,tooltip="",model = {
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
        {ID = "PassengerDoor",x=0,y=0,w=642,h=2000,tooltip="",model = {
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
    pos = Vector(411,64,50),
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
ENT.ButtonMap["RearDoor"] = {
    pos = Vector(-470-3,-16,48.4-2),
    ang = Angle(0,90,90),
    width = 642,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=642,h=1900,tooltip="",model = {
            var="door1",sndid="door1",
            sndvol = 1,snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false
--2k_pult_vspom_vud2.mdl
ENT.ClientProps["brake013"] = {
    model = "models/metrostroi_train/81-717/cran13.mdl",
    pos = Vector(431.5,-20.3,-10.2),
    ang = Angle(0,180,0),
    hideseat = 0.2, 
    scale=1,
}

ENT.ClientProps["vspom"] = {
    model = "models/metrostroi_train/81-5402/2k_pult_vspom_vud2.mdl",
    pos = Vector(448.5,61.3,11),
    ang = Angle(0,0,0),
    hideseat = 0.2,
    scale=1,
}

ENT.ButtonMap["HelperPanel_C"] = {
    pos = Vector(446.1,62.6,19),
    ang = Angle(0,0,90),
    width = 76,
    height = 305,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "VUD2Toggle",x=0,y=140,w=76,h=86,tooltip="",model = {
            model = "models/metrostroi_train/switches/vudwhite.mdl",z=10,
            var="VUD2",speed=6,
            sndvol = 1,snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "VDLSet",x=0,y=3,w=76,h=86,tooltip="",model = {
            model = "models/metrostroi_train/switches/vudwhite.mdl",z=10,
            var="VDL",speed=6,
            sndvol = 1,snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},

    }
}
ENT.ButtonMap["BlockTorec"] = {
    pos = Vector(391.7,26.5,27),
    ang = Angle(0,180,90),
    width = 190,
    height = 280,
    scale = 0.1/2,
    buttons = { 
        {ID = "UNBDKToggle",x=75,y=145,w=40,h=20,tooltip="Крышка кнопки блокировки торцевых дверей",model = {
            model = "models/metrostroi_train/81-5402/torc_krish.mdl",ang = 180,z = -3,
            plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=180,x=-35,y=28,var="UNBDKPl",ID="UNBDKPl",z=3,},
            var="UNBDK",speed=8,min=0.39,max=0.68,disable="UnBlockDoorToggle",
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "UnBlockDoorToggle",x=95,y=180,radius=20,tooltip="Кнопка блокировки торцевых дверей",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z=-1,
            var="UnBlockDoor",speed=16,vmin=1,vmax=0.6,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button2_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
    }
} 
ENT.ClientProps["vbamper"] = {
	model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
	pos = Vector(387.62,26.8,22.5),
	ang = Angle(-90,-90,0),
}


if not ENT.ClientSounds["br_013"] then ENT.ClientSounds["br_013"] = {} end
table.insert(ENT.ClientSounds["br_013"],{"brake013",function(ent,_,var) return "br_013" end,0.7,1,50,1e3,Angle(-90,0,0)})
ENT.ClientProps["PB"] = {
    model = "models/metrostroi_train/81-720/720_pb.mdl",
    pos = Vector(450, 15, -37),
    ang = Angle(0,-90,8),
    hideseat = 0.2,
}
if not ENT.ClientSounds["PB"] then ENT.ClientSounds["PB"] = {} end
table.insert(ENT.ClientSounds["PB"],{"PB",function(ent,var) return var > 0 and "pb_on" or "pb_off" end,1,1,50,1e3,Angle(-90,0,0)})
ENT.ClientProps["train_line_2k"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(450.665070,-15.255391,-3.192689+5.35),
    ang = Angle(-62.299999,-33.400002,0.000000),
    hideseat = 0.2,
}
ENT.ClientProps["brake_line_2k"] = {
    model = "models/metrostroi_train/Equipment/arrow_tm.mdl",
    pos = Vector(450.684143,-15.267894,-3.204609+5.35),
    ang = Angle(-62.299999,-33.400002,0.000000),
    hideseat = 0.2,
}
ENT.ClientProps["brake_cylinder_2k"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(450.435736,-22.815704,-3.113149+5.35),
    ang = Angle(-62.299999,-33.400002,0.000000),
    hideseat = 0.2,
}
ENT.ClientProps["ampermeter"] = {
	model = "models/metrostroi/81-717/volt_arrow.mdl",
	pos = Vector(449.1,-58.760001,24.799999),
    ang = Angle(85.5,0.000000,61.000000),
    hideseat=0.2,
    
}

ENT.ClientProps["voltmeter"] = {
	model = "models/metrostroi/81-717/volt_arrow.mdl",
	pos = Vector(449.5,-58.950,20.200001),
    ang = Angle(85.5,0,61),
    hideseat=0.2,
}


ENT.ClientProps["volt_lights"] = {
    model = "models/2k_int/amper_em.mdl",
    pos = Vector(0,0.06,0),
    ang = Angle(0,90,0),
    nohide=true,
    scale=1,
}
ENT.ButtonMap["HVMeters"] = {
    pos = Vector(453.2,-58.6,35),
    ang = Angle(0,-90-40,90),
    width = 68,
    height = 138,
    scale = 0.0625,

    buttons = {
        {ID = "!EnginesCurrent", x=0, y=0, w=68, h=64, tooltip=""},
        {ID = "!HighVoltage", x=0, y=74, w=68, h=64, tooltip=""},
    }
}
ENT.ClientProps["volt1_2k"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(449.501740,15.141174,0.812889),
    ang = Angle(-58.299999,0.000000,27.968136),
    bscale = Vector(1,1,1.47),
    hideseat = 0.2,
}
ENT.ClientProps["bortlamps1"] = {
    model = "models/metrostroi_train/81-717/5402_olights.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0), 
    nohide = true,
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
ENT.ClientProps["bortlamps3"] = {
        model = "models/metrostroi_train/81-717/540_olights.mdl",
        pos = Vector(-13,0,0),
        ang = Angle(0,0,0),
        nohide = true,
}
ENT.ClientProps["bortlamp3_w"] = {
        model = "models/metrostroi_train/81-717/540_light_w.mdl",
        pos = Vector(-13,0,0),
        ang = Angle(0,0,0),
        nohide = true,
}
ENT.ClientProps["bortlamp3_g"] = {
        model = "models/metrostroi_train/81-717/540_light_g.mdl",
        pos = Vector(-13,0,0),
        ang = Angle(0,0,0),
        nohide = true,
}
ENT.ClientProps["bortlamp3_y"] = {
        model = "models/metrostroi_train/81-717/540_light_o.mdl",
        pos = Vector(-13,0,0),
        ang = Angle(0,0,0),
        nohide = true,
}

ENT.ClientProps["door0x1"] = {
    model = "models/2k_int/2k_doors.mdl",
    pos = Vector(337.55+1.2,65.164,0.807),
    ang = Angle(0,0,0),
    hide = 2.0,
    scale=1,
}
ENT.ClientProps["door1x1"] = {
    model = "models/2k_int/2k_doors.mdl",
    pos = Vector(109.524+1.2-2.2,65.164,0.807),
    ang = Angle(0,0,0),
    hide = 2.0, 
    scale=1,
}
ENT.ClientProps["door2x1"] = {
    model = "models/2k_int/2k_doors.mdl",
    pos = Vector(-123.182+1.6,65.164,0.807),
    ang = Angle(0,0,0),
    hide = 2.0,
}
ENT.ClientProps["door3x1"] = {
    model = "models/2k_int/2k_doors.mdl",
    pos = Vector(-350.3+0.8-2.2,65.164,0.6),
    ang = Angle(0,0,0),
    hide = 2.0,
    scale=1,
}
ENT.ClientProps["door0x0"] = {
    model = "models/2k_int/2k_doors.mdl",
    pos = Vector(337.2+1.2,-65.164,0.6),
    ang = Angle(0,180,0),
    hide = 2.0,
}
ENT.ClientProps["door1x0"] = {
    model = "models/2k_int/2k_doors.mdl",
    pos = Vector(109.524+1.2-2.2,-65.164,0.6),
    ang = Angle(0,180,0),
    hide = 2.0,
}
ENT.ClientProps["door2x0"] = {
    model = "models/2k_int/2k_doors.mdl",
    pos = Vector(-123.182+1.6,-65.164,0.6),
    ang = Angle(0,180,0),
    hide = 2.0,
}
ENT.ClientProps["door3x0"] = {
    model = "models/2k_int/2k_doors.mdl",
    pos = Vector(-350.3+0.8-2.2,-65.164,0.6),
    ang = Angle(0,180,0),
    hide = 2.0,
} 

ENT.ClientProps["Lamps2_cab1"] = {
    model = "models/metrostroi_train/81-5402/lamp_cab1.mdl",
    pos = Vector(0.5,0,0),
    ang = Angle(0,0,0),
    hideseat = 0.9,
}
ENT.ClientProps["Lamps2_cab2"] = {
    model = "models/metrostroi_train/81-5402/lamp_cab2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat = 0.9,
}
ENT.ClientProps["lamp1_1"] = {
    model = "models/2k_int/2k_emissive.mdl",
    pos = Vector(333.949 - 33.5,0,69.7),
    ang = Angle(0,0,0),
    color = Color(255,255,255),
    scale=1,
    hideseat = 1.1,
}
ENT.ClientProps["lamp1_2"] = {
    model = "models/2k_int/2k_emissive.mdl",
    pos = Vector(333.949 - 33.5*2-35.6,0,69.7),
    ang = Angle(0,-0,0),
    --color = Color(255,235+g,235+b),
    color = Color(255,255,255),
    scale=1,
    hideseat = 1.1,
}
ENT.ClientProps["lamp1_3"] = {
    model = "models/2k_int/2k_emissive.mdl",
    pos = Vector(333.949 - 33.5*3-35.6*2,0,69.7),
    ang = Angle(0,-0,0),
    --color = Color(255,235+g,235+b),
    color = Color(255,255,255),
    scale=1,
    hideseat = 1.1,
}
ENT.ClientProps["lamp1_4"] = {
    model = "models/2k_int/2k_emissive.mdl",
    pos = Vector(333.949 - 33.5*4-35.6*3,0,69.7),
    ang = Angle(0,-0,0),
    --color = Color(255,235+g,235+b),
    color = Color(255,255,255),
    scale=1,
    hideseat = 1.1,
}
ENT.ClientProps["lamp1_5"] = {
    model = "models/2k_int/2k_emissive.mdl",
    pos = Vector(333.949 - 33.5*5-35.6*4,0,69.7),
    ang = Angle(0,-0,0),
    --color = Color(255,235+g,235+b),
    color = Color(255,255,255),
    scale=1,
    hideseat = 1.1,
}
ENT.ClientProps["lamp1_6"] = {
    model = "models/2k_int/2k_emissive.mdl",
    pos = Vector(333.949 - 33.5*6-35.6*5,0,69.7),
    ang = Angle(0,-0,0),
    --color = Color(255,235+g,235+b),
    color = Color(255,255,255),
    scale=1,
    hideseat = 1.1,
}
ENT.ClientProps["lamp1_7"] = {
    model = "models/2k_int/2k_emissive.mdl",
    pos = Vector(333.949 - 33.5*7-35.6*6,0,69.7),
    ang = Angle(0,-0,0),
    --color = Color(255,235+g,235+b),
    color = Color(255,255,255),
    scale=1,
    hideseat = 1.1,
}
ENT.ClientProps["lamp1_8"] = {
    model = "models/2k_int/2k_emissive.mdl",
    pos = Vector(333.949 - 33.5*8-35.6*7,0,69.7),
    ang = Angle(0,-0,0),
    --color = Color(255,235+g,235+b),
    color = Color(255,255,255),
    scale=1,
    hideseat = 1.1,
}
ENT.ClientProps["lamp1_9"] = {
    model = "models/2k_int/2k_emissive.mdl",
    pos = Vector(333.949 - 33.5*9-35.6*8,0,69.7),
    ang = Angle(0,-0,0),
    --color = Color(255,235+g,235+b),
    color = Color(255,255,255),
    scale=1,
    hideseat = 1.1,
}
ENT.ClientProps["lamp1_10"] = {
    model = "models/2k_int/2k_emissive.mdl",
    pos = Vector(333.949 - 33.5*10-35.6*9,0,69.7),
    ang = Angle(0,-0,0),
    --color = Color(255,235+g,235+b),
    color = Color(255,255,255),
    scale=1,
    hideseat = 1.1,
}
ENT.ClientProps["lamp1_11"] = {
    model = "models/2k_int/2k_emissive.mdl",
    pos = Vector(333.949 - 33.5*11-35.6*10,0,69.7),
    ang = Angle(0,-0,0),
    color = Color(255,255,255),
    scale=1,
    hideseat = 1.1,
}



ENT.Lights = {
    [1] = { "headlight",Vector(460,0,-40),Angle(0,0,0),Color(255,255,255),farz=5250,brightness = 4, fov=100, texture = "models/metrostroi_train/equipment/headlight",shadows = 1,headlight=true},
    [2] = { "headlight",        Vector(460,0,50), Angle(-20,0,0), Color(255,0,0), fov=160 ,brightness = 0.3, farz=450,texture = "models/metrostroi_train/equipment/headlight2",shadows = 0,backlight=true},
    [40] = { "headlight",Vector(451,-13.5,-2+7),Angle(52.571899-15-5,-129.269775+25+15,49.853062) ,Color(255,125,25),farz = 8,nearz = 2,shadows = 1,brightness = 1,fov = 145 },
    [41] = { "headlight",Vector(451.4,-21,-2+7),Angle(52.571899-15-5,-129.269775+25+15,49.853062),Color(255,125,25),farz = 8,nearz = 2,shadows = 1,brightness = 1,fov = 140 },
    [42] = { "headlight",Vector(450,13.1,-4.4+5.35),Angle(-136.613632-33,-95.636734-28,137.434570),Color(255,125,25),farz = 8,nearz = 1,shadows = 0,brightness = 1.5,fov = 120 },
    [43] = { "headlight",Vector(451.9-3,3.6+1,3.35+0.5),Angle(0,-90,0),Color(255,125,25),farz = 8,nearz = 2,shadows = 0,brightness = 1.5,fov = 80 },
    [44] = { "headlight",Vector(451.9,-13.5,-2+5.35),Angle(52.571899-15-5,-129.269775+25+15,49.853062) ,Color(255/5,125/5,25/5),farz = 8,nearz = 2,shadows = 1,brightness = 1,fov = 145 },
    [45] = { "headlight",Vector(451.8,-21,-2+5.35),Angle(52.571899-15-5,-129.269775+25+15,49.853062),Color(255/5,125/5,25/5),farz = 8,nearz = 2,shadows = 1,brightness = 1,fov = 140 },
    [46] = { "headlight",Vector(450.3,13.1,-4.4+5.35),Angle(-136.613632-33,-95.636734-28,137.434570),Color(255/5,125/5,25/5),farz = 8,nearz = 2,shadows = 0,brightness = 1.5,fov = 120 },
    [47] = { "headlight",Vector(451.9-3,3.6+1,3.35+0.5),Angle(0,-90,0),Color(255,125,25),farz = 8,nearz = 2,shadows = 0,brightness = 1.5,fov = 80 },
}

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.InfScreen = self:CreateRT("717InfScreen",512,128)
    self.SmodeScreen = self:CreateRT("540SmodeScreen",512,128)
    self.LeftMirror = self:CreateRT("LeftMirror",128,256)
    self.RightMirror = self:CreateRT("RightMirror",128,256)
    self.RouteNumber = self:CreateRT("5402RouteNumber",256,128)
    self.CraneRamp = 0
    self.CraneLRamp = 0
    self.CraneRRamp = 0
    self.ReleasedPdT = 0
    self.EmergencyValveRamp = 0
    self.EmergencyValveEPKRamp = 0
    self.EmergencyBrakeValveRamp = 0
    self.FrontLeak = 0
    self.RearLeak = 0
    self.VentCab = 0
    self.VentG1 = 0
    self.WiperValue = 0
    self.WiperReturn = 0
    self.VentG2 = 0
end
local C_ScreenshotMode      = GetConVar("metrostroi_screenshotmode")
local C_MinimizedShow       = GetConVar("metrostroi_minimizedshow")
local C_PrishelezOpt = GetConVar( "prishelez_hidewagons" )
local function gt(s,b)local j=(s.InMetrostroiTrain==b)return j end 
function ENT:ShouldRenderClientEnts()
    local b = not self:IsDormant() and math.abs(LocalPlayer():GetPos().z - self:GetPos().z) < 500 and (system.HasFocus() or C_MinimizedShow:GetBool()) and (not Metrostroi or not Metrostroi.ReloadClientside) 
    if C_PrishelezOpt:GetBool() then
       if not gt( LocalPlayer(), self ) then b = false end  
    end  
    return b
end
function ENT:UpdateWagonNumber()
    local count = math.max(4,math.ceil(math.log10(self.WagonNumber+1)))
    for i=0,4 do
        self:ShowHide("TrainNumberL"..i,i<count)
        self:ShowHide("TrainNumberR"..i,i<count)
        if i< count and self.WagonNumber then
            local leftNum,rightNum = self.ClientEnts["TrainNumberL"..i],self.ClientEnts["TrainNumberR"..i]
            local num = math.floor(self.WagonNumber%(10^(i+1))/10^i)
            if IsValid(leftNum) then
                leftNum:SetPos(self:LocalToWorld(Vector(41+16+i*6.6-count*6.6/2,67.4,-17.8)))
                leftNum:SetSkin(num)
            end
            if IsValid(rightNum) then
                rightNum:SetPos(self:LocalToWorld(Vector(64+16-i*6.6-count*6.6/2,-67.4,-17.8)))
                rightNum:SetSkin(num)
            end
        end
    end
end
local Cpos = {
    0,0.2,0.4,0.5,0.6,0.8,1
}
--------------------------------------------------------------------------------

function ENT:Think()
    self.BaseClass.Think(self)
    if not self.RenderClientEnts or self.CreatingCSEnts then
        self.RKTimer = nil
        self.OldBPSNType = nil

        self.RingType = nil
        return
    end

    --[[
        for i=1, 99 do print("ZUBAKA"..i) end 
    ]] 
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

    local Blick_Show = GetConVar( "prishelez_bliki" ) 
    self:HidePanel("Block5_6b_2k",Blick_Show:GetBool())
    self:HidePanel("Block7_b",Blick_Show:GetBool())

    self:SetLightPower(40,self:GetPackedBool("PanelLights"),self:GetNW2Int("VVToggleSwitch2"))
    self:SetLightPower(41,self:GetPackedBool("PanelLights"),self:GetNW2Int("VVToggleSwitch2"))
    self:SetLightPower(42,self:GetPackedBool("PanelLights"),self:GetNW2Int("VV1ToggleSwitch2"))
    self:SetLightPower(45,self:GetPackedBool("PanelLights"))
    self:SetLightPower(46,self:GetPackedBool("PanelLights"))


    self:ShowHide("volt_lights",self:GetPackedBool("PanelLights"))
    local HL1 = self:Animate("Headlights1",self:GetPackedBool("Headlights1") and 1 or 0,0,1,9,false)
    local HL2 = self:Animate("Headlights2",self:GetPackedBool("Headlights2") and 1 or 0,0,1,9,false)
    local RL_l = self:Animate("RedLights_a",self:GetPackedBool("RedLights_l") and 1 or 0,0,1,6,false)
    local RL_r = self:Animate("RedLights_a2",self:GetPackedBool("RedLights_r") and 1 or 0,0,1,6,false)
    self:ShowHideSmooth("RedLights_l",RL_l) 
    self:ShowHideSmooth("RedLights_r",RL_r) 

    if self:GetPackedBool("VB") then 
    if self:GetPackedBool("Wiper") then
        self.WiperValue = self.WiperValue + 2*self.DeltaTime
    else  
        self.WiperValue = self.WiperValue - self.WiperValue*self.DeltaTime
    end
    end  
	if self.WiperValue > math.pi*2 then self.WiperValue = 0 end 
	self:Animate("Wiper",(math.sin(self.WiperValue-math.pi/2)+2)/2 - 0.5,0, 1,  300,30)
    for i=1,2 do 
        self:Animate("pred"..i, self:GetPackedBool("Pred"..i) and 1 or 0,0,1, 3, false)
    end 
    for i=1,2 do 
        self:ShowHide("pred"..i.."b", self:GetPackedBool("Pred"..i.."B")) 
        self:ShowHide("Pred"..i.."B",self:GetPackedBool("Pred"..i)) 
    end 
    self:ShowHide("bochok",self:GetNW2Bool("Bochok"))
    local rnwork = self:GetNW2Bool("RouteNumberWork")
    local rn = self:GetNW2Int("RouteNumberSet")
    local rnsel = self:GetNW2Bool("RouteNumberSelected",true) 
    local rntimer = CurTime()%1>0.4
      
    for i=1,2 do
    if rnsel then
        self:ShowHide("route_"..i.."_2k",rnwork and rnsel and rntimer) 
    else
        self:ShowHide("route_"..i.."_2k",rnwork)
    end
        if rnwork and IsValid(self.ClientEnts["route_"..i.."_2k"]) then
            local number = math.floor(rn/10^(2-i)) % 10
            self.ClientEnts["route_"..i.."_2k"]:SetSkin(number)
        end
    end

   

    local headlight = HL1*0.6+HL2*0.4
    self:SetLightPower(1,headlight>0,headlight)
    self:SetLightPower(2,self:GetPackedBool("RedLights"),RL)


    local newBortlamps = self:GetNW2Bool("NewBortlamps")
    local Bortlamp_w = self:Animate("Bortlamp_w",self:GetPackedBool("DoorsW") and 1 or 0,0,1,16,false)
    local Bortlamp_g = self:Animate("Bortlamp_g",self:GetPackedBool("GRP") and 1 or 0,0,1,16,false)
    local Bortlamp_y = self:Animate("Bortlamp_y",self:GetPackedBool("BrW") and 1 or 0,0,1,16,false)

    local c13 = self:GetNW2Int("Crane",1)==2 

    if newBortlamps then
        self:ShowHide("bortlamps1",true)
        self:ShowHide("bortlamps2",true)
        self:ShowHide("bortlamps3",false)
        self:ShowHide("bortlamps4",false)
        self:ShowHideSmooth("bortlamp1_w",Bortlamp_w)
        self:ShowHideSmooth("bortlamp1_g",Bortlamp_g)
        self:ShowHideSmooth("bortlamp1_y",Bortlamp_y)
        self:ShowHideSmooth("bortlamp2_w",Bortlamp_w)
        self:ShowHideSmooth("bortlamp2_g",Bortlamp_g)
        self:ShowHideSmooth("bortlamp2_y",Bortlamp_y)
        self:ShowHideSmooth("bortlamp3_w",0)
        self:ShowHideSmooth("bortlamp3_g",0)
        self:ShowHideSmooth("bortlamp3_y",0)
        self:ShowHideSmooth("bortlamp4_w",0)
        self:ShowHideSmooth("bortlamp4_g",0)
        self:ShowHideSmooth("bortlamp4_y",0)
    else
        self:ShowHide("bortlamps1",false)
        self:ShowHide("bortlamps2",false)
        self:ShowHide("bortlamps3",true)
        self:ShowHide("bortlamps4",true)
        self:ShowHideSmooth("bortlamp1_w",0)
        self:ShowHideSmooth("bortlamp1_g",0)
        self:ShowHideSmooth("bortlamp1_y",0)
        self:ShowHideSmooth("bortlamp2_w",0)
        self:ShowHideSmooth("bortlamp2_g",0)
        self:ShowHideSmooth("bortlamp2_y",0)
        self:ShowHideSmooth("bortlamp3_w",Bortlamp_w)
        self:ShowHideSmooth("bortlamp3_g",Bortlamp_g)
        self:ShowHideSmooth("bortlamp3_y",Bortlamp_y)
        self:ShowHideSmooth("bortlamp4_w",Bortlamp_w)
        self:ShowHideSmooth("bortlamp4_g",Bortlamp_g)
        self:ShowHideSmooth("bortlamp4_y",Bortlamp_y)
    end

    self:Animate("Controller",self:GetPackedRatio("ControllerPosition"),0.3,0.02,2,false)
    self:Animate("Controller_otl",self:GetPackedRatio("ControllerPosition"),0.3,0.02,2,false)
    self:Animate("reverser",self:GetNW2Int("ReverserPosition")/2,0,0.27,4,false)
    self:Animate("krureverser",self:GetNW2Int("KRUPosition")/2,0.53,0.95,4,false)
    self:ShowHide("reverser",self:GetNW2Int("WrenchMode",0)==1)
    self:ShowHide("krureverser",self:GetNW2Int("WrenchMode",0)==2)
    self:ShowHide("Controller",self:GetNW2Int("TypeLine",1)==2)
    self:ShowHide("Controller_otl",self:GetNW2Int("TypeLine",1)==1)

  -- self:ShowHide("brake013",) 
  
    self:HidePanel("DriverValveDisconnect",not self:GetPackedBool("Crane013"))


    self:ShowHide("brake_disconnect",not self:GetPackedBool("Crane013"))
    self:ShowHide("train_disconnect",not self:GetPackedBool("Crane013"))
    self:HidePanel("DriverValveBLDisconnect",self:GetPackedBool("Crane013"))
    self:HidePanel("DriverValveTLDisconnect",self:GetPackedBool("Crane013"))

    self:Animate("brake013",        Cpos[self:GetPackedRatio("CranePosition")] or 0, 0.03, 0.458,  256,24)

    self:Animate("speed",self:GetPackedRatio("Speed"),0.881+0.004,0.609-0.008,nil,nil,256,2,0.01)

    local ARSType = self:GetNW2Int("ARSType",1)
    if self.ARSType ~= ARSType then
        self:RemoveCSEnt("ars_mvm")
        self.ARSType = ARSType
    end
    if self.KVType ~= self:GetNW2Int("KVType",1) then
        self:RemoveCSEnt("Controller")
        self.KVType = self:GetNW2Int("KVType",1)
    end
    local LineType = self:GetNW2Int("TypeLine", 1) 
    self:ShowHide("screen_2k", LineType==2)
    self:ShowHide("salon", LineType==1)
    self:ShowHide("ALSFreqToggle", LineType==2)
    self:ShowHide("SSpeed1",self:GetPackedBool("LUDS"))
    self:ShowHide("SSpeed2",self:GetPackedBool("LUDS"))
    self:ShowHide("RSpeed1",self:GetPackedBool("LUDS"))
    self:ShowHide("RSpeed2",self:GetPackedBool("LUDS"))
    local speed = self:GetNW2Int("ALSSpeed")
    if self:GetPackedBool("LUDS") then
     if IsValid(self.ClientEnts["SSpeed1"])then self.ClientEnts["SSpeed1"]:SetSkin(math.floor(speed)%10)  end
      if IsValid(self.ClientEnts["SSpeed2"])then self.ClientEnts["SSpeed2"]:SetSkin(math.floor(speed/10)) end 
    end

    local handrails = self:GetNW2Bool("HandRails")
    local dot5 = self:GetNW2Bool("Dot5")
    local lvz = self:GetNW2Bool("LVZ")
    local newSeats = self:GetNW2Bool("NewSeats")
    local mask = self:GetNW2Bool("Mask")
    local mask22 = self:GetNW2Bool("Mask22")


    local lamps_cab2 = self:Animate("lamps_cab2",self:GetPackedBool("EqLights") and 1 or 0,0,1,5,false)
    local lamps_cab1 = self:Animate("lamps_cab1",self:GetPackedBool("CabLights") and 1 or 0,0,1,5,false)
    self:ShowHideSmooth("Lamps2_cab2",lamps_cab2 or 0)
    self:ShowHideSmooth("Lamps2_cab1",lamps_cab1 or 0)

  
    self:ShowHideSmooth("FariGroup1",HL2 or 0)
    self:ShowHideSmooth("FariGroup2",HL1 or 0)


     


    self:Animate("PB",self:GetPackedBool("PB") and 1 or 0,0,0.2,  12,false)
    self:Animate("UAVALever",   self:GetPackedBool("UAVA") and 1 or 0,     0,0.6, 128,  3,false)
    self:Animate("parking_brake",   self:GetPackedBool("ParkingBrake") and 0.6 or 0,1,0,  4,false)
    -- self:Animate("EPK_disconnect",   self:GetPackedBool("EPK") and 0 or 1,1,0,  4,false)
    self:Animate("EPV_disconnect",   self:GetPackedBool("EPK") and 0 or 1,1,0,  4,false)
    self:Animate("brake_disconnect",self:GetPackedBool("DriverValveBLDisconnect") and 1 or 0,0.25,0,  4,false)
    self:Animate("train_disconnect",self:GetPackedBool("DriverValveTLDisconnect") and 1 or 0,0.25,0,  4,false)
    self:Animate("valve_disconnect",self:GetPackedBool("DriverValveDisconnect") and 0 or 1,1,0,  4,false)
    self:Animate("stopkran",   self:GetPackedBool("EmergencyBrakeValve") and 0 or 1,     0.25,0, 128,  3,false)
     
    local c013 = self:GetNW2Int("Crane",1)==2
    self:ShowHide("brake_disconnect",not c013)
    self:ShowHide("train_disconnect",not c013)
    self:HidePanel("DriverValveBLDisconnect",c013)
    self:HidePanel("DriverValveTLDisconnect",c013)
    -- self:HidePanel("EPKDisconnect",c013)
    -- self:ShowHide("EPK_disconnect.",not c013)
    self:HidePanel("EPVDisconnect",not c013)
    self:HidePanel("DriverValveDisconnect",not c013)

    self:Animate("brake_line_2k",self:GetPackedRatio("BLPressure"),0.143,0.88,256,2)--,0.01)
    self:Animate("train_line_2k",self:GetPackedRatio("TLPressure"),0.143,0.88,256,0)--,0.01)
    self:Animate("brake_cylinder_2k",self:GetPackedRatio("BCPressure"),0.134,0.874,256,0)--,0.03)

    self:Animate("voltmeter",self:GetPackedRatio("EnginesVoltage"),0.385,0.658,256,0.2,false)
    self:Animate("volt1_2k",self:GetPackedRatio("BatteryVoltage"),0.625,0.376,256,0.2,false)
    self:Animate("vbamper", self:GetPackedRatio("BatteryVoltageA"),0.620,0.45,256,0.2,false)
    self:Animate("ampermeter",self:GetPackedRatio("EnginesCurrent"),0.39,0.655,256,0.2,false)

    local otsek1 = self:Animate("door_otsek1",self:GetPackedBool("OtsekDoor1") and 1 or 0,0,1,4,0.5)
    local otsek2 = self:Animate("door_otsek2",self:GetPackedBool("OtsekDoor2") and 1 or 0,0,1,4,0.5)
    self:HidePanel("AV_S",otsek2<=0)
    self:ShowHide("2k_otsav_rem",otsek2==1)
    local door1 = self:Animate("door1",self:GetPackedBool("RearDoor") and 1 or 0,0,0.25,4,0.5)
    local door2 = self:Animate("door2",self:GetPackedBool("PassengerDoor") and 1 or 0,0,1,4,0.5)
    local door3 = self:Animate("door3",self:GetPackedBool("CabinDoor") and 1 or 0,1,0,4,0.5)

 

    if self.Door1 ~= (door1 > 0) then
        self.Door1 = door1 > 0
        self:PlayOnce("door1","bass",self.Door1 and 1 or 0)
    end
    if self.Door2 ~= (door2 > 0) then
        self.Door2 = door2 > 0
        self:PlayOnce("door3","bass",self.Door2 and 1 or 0)
    end
    if self.Door3 ~= (door3 < 1) then
        self.Door3 = door3 < 1
        self:PlayOnce("door3","bass",self.Door3 and 1 or 0)
    end
    if self.Otsek1 ~= (otsek1 > 0) then
        self.Otsek1 = otsek1 > 0
        if not self.Otsek1 then
            self:PlayOnce("door_otsek1","bass",1)
        end
    end
    if self.Otsek2 ~= (otsek2 > 0) then
        self.Otsek2 = otsek2 > 0
        if not self.Otsek2 then
            self:PlayOnce("door_otsek2","bass",1)
        end
    end



        for i = 1,12 do
            local colV = self:GetNW2Vector("lamp"..i)
            local col = Color(colV.x,colV.y,colV.z)
            if LineType == 2 then 
            self:ShowHideSmooth("lamp1_2",0) 
            self:ShowHideSmooth("lamp1_10",0) 
            end 
            self:ShowHideSmooth("lamp1_"..i,self:Animate("Lamp1_"..i,self:GetPackedBool("lightsActive"..i) and 1 or 0,0,1,6,false),col)
        end
  

    self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 0.6,0,1, 3, false)
    self:Animate("FrontTrain",  self:GetNW2Bool("FtI") and 1 or 0.6,0,1, 3, false)
    self:Animate("RearBrake",   self:GetNW2Bool("RbI") and 0 or 1,0,1, 3, false)
    self:Animate("RearTrain",   self:GetNW2Bool("RtI") and 1 or 0,0,1, 3, false)

    -- Main switch
    if self.LastGVValue ~= self:GetPackedBool("GV") then
        self.ResetTime = CurTime()+1.5
        self.LastGVValue = self:GetPackedBool("GV")
    end
    self:Animate("gv_wrench",self.LastGVValue and 1 or 0,0.5,0.9,128,1,false)
    self:ShowHideSmooth("gv_wrench",    CurTime() < self.ResetTime and 1 or 0.1)

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
    local rollingi = math.min(1,self.TunnelCoeff+math.Clamp((self.StreetCoeff-0.82)/0.3,0,1))
    local rollings = math.max(self.TunnelCoeff*0.6,self.StreetCoeff)
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
    if c013 then
        if ramp > 0 then
            self.CraneRamp = self.CraneRamp + ((0.2*ramp)-self.CraneRamp)*dT
        else
            self.CraneRamp = self.CraneRamp + ((0.9*ramp)-self.CraneRamp)*dT
        end
        self.CraneRRamp = math.Clamp(self.CraneRRamp + 1.0*((1*ramp)-self.CraneRRamp)*dT,0,1)
        self:SetSoundState("crane013_release",self.CraneRRamp^1.5,1.0)
        self:SetSoundState("crane013_brake",math.Clamp(-self.CraneRamp*1.5-0.1,0,1)^1.3,1.0)
        local loudV = self:GetNW2Float("Crane013Loud",0)
        if loudV>0 then
            if ramp>0 then
                self.CraneLRamp = self.CraneLRamp + (math.min(ramp,0)-self.CraneLRamp)*dT*0.5
            else
                self.CraneLRamp = self.CraneLRamp + (math.min(ramp,0)-self.CraneLRamp)*dT*1
            end
            self:SetSoundState("crane013_brake_l",(math.Clamp(-self.CraneRamp*2.5-0.1,0,1)^1.3)*(1-math.Clamp((-self.CraneLRamp-loudV)*3,0,1)),1.12-math.Clamp((-self.CraneLRamp-0.15)*2,0,1)*0.12)
        else
            self:SetSoundState("crane013_brake_l",0,1)
        end
        self:SetSoundState("crane013_brake2",math.Clamp(-self.CraneRamp*1.5-0.95,0,1.5)^2,1.0)
    else
        self:SetSoundState("crane013_brake",0,1.0)
        self:SetSoundState("crane013_release",0,1.0)
        --self:SetSoundState("crane013_brake2",0,1.0)

        self.CraneRamp = math.Clamp(self.CraneRamp + 8.0*((1*self:GetPackedRatio("Crane_dPdT",0))-self.CraneRamp)*dT,-1,1)

        self:SetSoundState("crane334_brake_low",math.Clamp((-self.CraneRamp)*2,0,1)^2,1)
        local high = math.Clamp(((-self.CraneRamp)-0.5)/0.5,0,1)^1
        self:SetSoundState("crane334_brake_high",high,1.0)
        self:SetSoundState("crane013_brake2",high*2,1.0)
        self:SetSoundState("crane334_brake_eq_high",--[[ math.Clamp(-self.CraneRamp*0,0,1)---]] math.Clamp(-self:GetPackedRatio("ReservoirPressure_dPdT")-0.2,0,1)^0.8*1,1)
        self:SetSoundState("crane334_brake_eq_low",--[[ math.Clamp(-self.CraneRamp*0,0,1)---]] math.Clamp(-self:GetPackedRatio("ReservoirPressure_dPdT")-0.4,0,1)^0.8*1.3,1)

        self:SetSoundState("crane334_release",math.Clamp(self.CraneRamp,0,1)^2,1.0)
    end
    local emergencyValveEPK = self:GetPackedRatio("EmergencyValveEPK_dPdT",0)
    self.EmergencyValveEPKRamp = math.Clamp(self.EmergencyValveEPKRamp + 1.0*((0.5*emergencyValveEPK)-self.EmergencyValveEPKRamp)*dT,0,1)
    if self.EmergencyValveEPKRamp < 0.01 then self.EmergencyValveEPKRamp = 0 end
    self:SetSoundState("epk_brake",self.EmergencyValveEPKRamp,1.0)


    local emergencyBrakeValve = self:GetPackedRatio("EmergencyBrakeValve_dPdT", 0)
    self.EmergencyBrakeValveRamp = math.Clamp(self.EmergencyBrakeValveRamp + (emergencyBrakeValve-self.EmergencyBrakeValveRamp)*dT*8,0,1)
    self:SetSoundState("valve_brake",self.EmergencyBrakeValveRamp,0.8+math.min(0.4,self.EmergencyBrakeValveRamp*0.8))

    local emergencyValve = self:GetPackedRatio("EmergencyValve_dPdT", 0)^0.4*1.2
    self.EmergencyValveRamp = math.Clamp(self.EmergencyValveRamp + (emergencyValve-self.EmergencyValveRamp)*dT*16,0,1)
    local emer_brake = math.Clamp((self.EmergencyValveRamp-0.9)/0.05,0,1)
    local emer_brake2 = math.Clamp((self.EmergencyValveRamp-0.2)/0.4,0,1)*(1-math.Clamp((self.EmergencyValveRamp-0.9)/0.1,0,1))
    self:SetSoundState("emer_brake",emer_brake,1)
    self:SetSoundState("emer_brake2",emer_brake2,math.min(1,0.8+0.2*emer_brake2))
    --self:SetSoundState("emer_brake",self.EmergencyValveRamp*0.8,1)
    --self:SetSoundState("emer_brake",self.EmergencyValveRamp*0.8,1)
    -- Compressor
    self:SetSoundState("compressor",self:GetPackedBool("Compressor") and 0.6 or 0,1)
    self:SetSoundState("compressor2",self:GetPackedBool("Compressor") and 0.8 or 0,1)



    local v1state = self:GetPackedBool("M1_3") and 1 or 0
    local v2state = self:GetPackedBool("M4_7") and 1 or 0
    local vCstate = self:GetPackedRatio("M8")/2
    if self.VentCab < vCstate then
        self.VentCab = math.min(1,self.VentCab + dT/2.7)
    elseif self.VentCab > vCstate then
        self.VentCab = math.max(0,self.VentCab - dT/2.7)
    end
    self.VentG1 = math.Clamp(self.VentG1 + dT/2.7*(v1state*2-1),0,1)
    self.VentG2 = math.Clamp(self.VentG2 + dT/2.7*(v2state*2-1),0,1)
    self:SetSoundState("vent_cabl",math.Clamp(self.VentCab*2,0,1) ,1)
    self:SetSoundState("vent_cabh",math.Clamp((self.VentCab-0.5)*2,0,1),1)

    for i=1,7 do
        if i<4 then
            self:SetSoundState("vent"..i,self.VentG1,1)
        else
            self:SetSoundState("vent"..i,self.VentG2,1)
        end
    end
    if self.RingType ~= self:GetNW2Int("RingType",1) then
        self.RingType = self:GetNW2Int("RingType",1)
        self:SetSoundState(self.RingName,0,0)

        self.RingPitch = 1
        self.RingVolume = 1
        if self.RingType == 1 then
            self.RingName = "ring2"
        elseif self.RingType == 2 then
            self.RingName = "ring3"
            self.RingVolume = 1.4
            self.RingPitch = 0.6
        elseif self.RingType == 3 then
            self.RingName = "ring3"
            self.RingVolume = 1.2
            self.RingPitch = 0.8
        elseif self.RingType == 4 then
            self.RingName = "ring3"
            self.RingPitch = 0.95
        elseif self.RingType == 5 then
            self.RingName = "ring"
            self.RingPitch = 0.8
        elseif self.RingType == 6 then
            self.RingName = "ring"
        elseif self.RingType == 7 then
            self.RingName = "ring4"
        elseif self.RingType == 8 then
            self.RingName = "ring5"
        elseif self.RingType == 9 then
            self.RingName = "ring6"
        end
        self.RingFade = 0
    end
    -- ARS/ringer alert
    local bzos = self.RingName=="ring" or self.RingName=="ring6" or self.RingName=="ring3" and RealTime()%0.8<0.35 or self.RingName~="ring3" and RealTime()%0.5>0.25
    local ringstate = (self:GetPackedBool("Buzzer") or self:GetPackedBool("BuzzerBZOS") and bzos) and 1 or 0
    if 6< self.RingType and self.RingType < 9 then
        self.RingFade = math.Clamp(self.RingFade+(ringstate-self.RingFade)*dT*(self:GetPackedBool("BuzzerBZOS") and 50 or 25),0,1)
        self:SetSoundState(self.RingName,self.RingFade*self.RingVolume,self.RingPitch)
    else
        self:SetSoundState(self.RingName,ringstate*self.RingVolume,self.RingPitch)
    end   
    if self:GetPackedBool("RK") then self.RKTimer = CurTime() end
    self:SetSoundState("rk",(self.RKTimer and (CurTime() - self.RKTimer) < 0.2) and 0.7 or 0,1)

    -- BPSN sound
    self.BPSNType = self:GetNW2Int("BPSNType",13)
    if not self.OldBPSNType then self.OldBPSNType = self.BPSNType end
    if self.BPSNType ~= self.OldBPSNType then
        for i=1,12 do
            self:SetSoundState("bpsn"..i,0,1.0)
        end
    end
    self.OldBPSNType = self.BPSNType
    if self.BPSNType<13 then
        self:SetSoundState("bpsn"..self.BPSNType,self:GetPackedBool("BPSN") and 1 or 0,1) --FIXME громкость по другому
    end

    local cabspeaker = self:GetPackedBool("AnnCab")
    local work = self:GetPackedBool("AnnPlay")
    local buzz = self:GetPackedBool("AnnBuzz") and self:GetNW2Bool("AnnouncerBuzz")
    for k in ipairs(self.AnnouncerPositions) do
        self:SetSoundState("announcer_buzz"..k,(buzz and (k ~= 1 and work or k==1 and cabspeaker)) and 1 or 0,1)
    end
    for k,v in ipairs(self.AnnouncerPositions) do
        if self.Sounds["announcer"..k] and IsValid(self.Sounds["announcer"..k]) then
            self.Sounds["announcer"..k]:SetVolume((k ~= 1 and work or k==1 and cabspeaker) and (v[3] or 1)  or 0)
        end
    end
end

function ENT:Draw()
    self.BaseClass.Draw(self)

end

function ENT:DrawPost(special)
    --local dc = render.GetLightColor(self:LocalToWorld(Vector(460.0,0.0,5.0)))

    local distance = self:GetPos():Distance(LocalPlayer():GetPos())
    self.RTMaterial:SetTexture("$basetexture", self.RouteNumber)
    self:DrawOnPanel("RouteNumber1_2k",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(128,64,256,128,0)
    end)

    self:DrawOnPanel("InfoTable",function()
        local j = self:GetNW2String("Inf:Tablo1")
	        draw.Text(
	        {
	            text = j,
	            font = "Metrostroi_Route540",
	            pos = { 324, 50 },
	            xalign = TEXT_ALIGN_CENTER,
	            yalign = TEXT_ALIGN_CENTER,
	            color = Color(255,255,255)
	        })
    end) 
    if distance > 1024 or special then return end
    self.RTMaterial:SetTexture("$basetexture",self.InfScreen)
    self:DrawOnPanel("InfScreen",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(256,73,512,149,0)
    end)  

    self.RTMaterial:SetTexture("$basetexture",self.SmodeScreen)
    self:DrawOnPanel("SmodeScreen",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(256,73,610,259,0)
    end)  
  
 
   
    
    self:DrawOnPanel("AirDistributor",function()
        draw.DrawText(self:GetNW2Bool("AD") and "Air Distributor ON" or "Air Distributor OFF","Trebuchet24",0,0,Color(0,0,0,255))
    end)
end

function ENT:OnButtonPressed(button)
    if button == "PrevSign" then
        self.InfoTableTimeout = CurTime() + 2.0
    end
    if button == "NextSign" then
        self.InfoTableTimeout = CurTime() + 2.0
    end

    if button and button:sub(1,3) == "Num" then
        self.InfoTableTimeout = CurTime() + 2.0
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
    if location == "bass" then
        if soundid == "VDOL" then
            return range > 0 and "vdol_on" or "vdol_off",location,1,pitch
        end
        if soundid == "VDOP" then
            return range > 0 and "vdor_on" or "vdor_off",location,1,pitch
        end
        if soundid == "VDZ" then
            return range > 0 and "vdz_on" or "vdz_off",location,1,pitch
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
            return range > 0 and "kk_on" or "kk_off",location,1,pitch--0.8
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
        if soundid == "ROT1" then
            return range > 0 and "rot_on" or "rot_off",location,1,pitch
        end
        if soundid == "ROT2" then
            return range > 0 and "rot_on" or "rot_off",location,1,pitch
        end
        if soundid == "AVU" then
            return range > 0 and "avu_on" or "avu_off",location,1,0.9
        end
    elseif soundid:sub(1,4)=="kv70" and self:GetNW2Bool("SecondKV") then return soundid.."_2",location,range,pitch end
    return soundid,location,range,pitch
end
Metrostroi.GenerateClientProps()
