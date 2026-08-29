ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category        = "Metrostroi (trains)"
ENT.SkinsType = "81-717.5p"
ENT.Model = "models/metrostroi_train/81-5402/81-7175p_body.mdl"

ENT.Spawnable       = true
ENT.AdminSpawnable  = false
ENT.DontAccelerateSimulation = false

function ENT:PassengerCapacity()
    return 300
end

function ENT:GetStandingArea()
    return Vector(-450,-30,-48),Vector(380,30,-48)
end

local function GetDoorPosition(i,k)
    return Vector(359.0 - 35/2 - 229.5*i,-65*(1-2*k),7.5)
end
ENT.AnnouncerPositions = {
    {Vector(420,-49 ,61),80,0.2},
    {Vector(-3,-60, 62),200,0.2},
    {Vector(-3,60 ,62),200,0.2},
}
ENT.Cameras = {
    {Vector(407.5+25,-40,27),Angle(0,180,0),"Train.717.Breakers","AV_R"},
    {Vector(407.5+20,-40.5,4),Angle(0,180,0),"Train.717.VB","Battery_R"},
    {Vector(392.5+20,-14,33.0),Angle(0,180,0),"Train.717.SOSD","SOSD_R"},
    {Vector(415+13,-47,-10),Angle(0,270,0),"Train.Common.UAVA"},
    {Vector(420.5+5,-20,-20),Angle(40,-30,0),"Train.Common.PneumoPanels"},
    {Vector(407.5+35,40,10),Angle(0,90-17,0),"Train.Common.HelpersPanel"},
    {Vector(412.5+26,20,5),Angle(20,30,0),"Train.717.PUAV","PUAVN"},
    {Vector(412.5+26,20,5),Angle(20,30,0),"Train.717.PA","PAM"},
    {Vector(407.5+70,40,5)  ,Angle(20,180+9,0),"Train.Common.RouteNumber"},
	{Vector(377+70,45.2,2)  ,Angle(0,0,0),"Common.81-7175p.RouteNumberSelect"},
    {Vector(450+7,0,30),Angle(60,0,0),"Train.Common.CouplerCamera"},
}
function ENT:InitializeSounds()
    self.BaseClass.InitializeSounds(self)
    self.SoundNames["rolling_5"] = {loop=true,"subway_trains/common/junk/junk_background3.wav"}
    self.SoundNames["rolling_10"] = {loop=true,"subway_trains/717/rolling/10_rolling.wav"}
    self.SoundNames["rolling_40"] = {loop=true,"subway_trains/717/rolling/40_rolling.wav"}
    self.SoundNames["rolling_70"] = {loop=true,"subway_trains/717/rolling/70_rolling.wav"}
    self.SoundNames["rolling_80"] = {loop=true,"subway_trains/717/rolling/80_rolling.wav"}
    self.SoundPositions["rolling_5"] = {480,1e12,Vector(0,0,0),0.15}
    self.SoundPositions["rolling_10"] = {480,1e12,Vector(0,0,0),0.20}
    self.SoundPositions["rolling_40"] = {480,1e12,Vector(0,0,0),0.55}
    self.SoundPositions["rolling_70"] = {480,1e12,Vector(0,0,0),0.60}
    self.SoundPositions["rolling_80"] = {480,1e12,Vector(0,0,0),0.75}
    self.SoundNames["rolling_motors"] = {loop=true,"subway_trains/common/junk/wind_background1.wav"}
    self.SoundNames["rolling_motors2"] = {loop=true,"subway_trains/common/junk/wind_background1.wav"}
    self.SoundPositions["rolling_motors"] = {250,1e12,Vector(200,0,0),0.33}
    self.SoundPositions["rolling_motors2"] = {250,1e12,Vector(-250,0,0),0.33}
    self.SoundNames["rolling_low"] = {loop=true,"subway_trains/717/rolling/rolling_outside_low.wav"}
    self.SoundNames["rolling_medium1"] = {loop=true,"subway_trains/717/rolling/rolling_outside_medium1.wav"}
    self.SoundNames["rolling_medium2"] = {loop=true,"subway_trains/717/rolling/rolling_outside_medium2.wav"}
    self.SoundNames["rolling_high2"] = {loop=true,"subway_trains/717/rolling/rolling_outside_high2.wav"}
    self.SoundPositions["rolling_low"] = {480,1e12,Vector(0,0,0),0.6}
    self.SoundPositions["rolling_medium1"] = {480,1e12,Vector(0,0,0),0.90}
    self.SoundPositions["rolling_medium2"] = {480,1e12,Vector(0,0,0),0.90}
    self.SoundPositions["rolling_high2"] = {480,1e12,Vector(0,0,0),1.00}

    self.SoundNames["pneumo_disconnect2"] = "subway_trains/common/pneumatic/pneumo_close.mp3"
    self.SoundNames["pneumo_disconnect1"] = {
        "subway_trains/common/pneumatic/pneumo_open.mp3",
        "subway_trains/common/pneumatic/pneumo_open2.mp3",
    }
    self.SoundPositions["pneumo_disconnect2"] = {60,1e9,Vector(431.8,-24.1+1.5,-33.7),1}
    self.SoundPositions["pneumo_disconnect1"] = {60,1e9,Vector(431.8,-24.1+1.5,-33.7),1}
    self.SoundNames["epv_on"]           = "subway_trains/common/pneumatic/epv_on.mp3"
    self.SoundNames["epv_off"]          = "subway_trains/common/pneumatic/epv_off.mp3"
    self.SoundPositions["epv_on"] = {80,1e9,Vector(437.2,-53.1,-32.0),0.85}
    self.SoundPositions["epv_off"] = {80,1e9,Vector(437.2,-53.1,-32.0),0.85}
    self.SoundPositions["epv_off"] = {60,1e9,Vector(437.2,-53.1,-32.0),0.85}
    -- Релюшки
    --self.SoundNames["rpb_on"] = "subway_trains/717/relays/new/ro_off.mp3"
    --self.SoundNames["rpb_off"] = "subway_trains/717/relays/ro_on.mp3"
    self.SoundNames["rpb_on"] = "subway_trains/81-7175P/relays/KD_on_5P.mp3"
    self.SoundNames["rpb_off"] = "subway_trains/81-7175P/relays/KD_on_5P.mp3"
    self.SoundPositions["rpb_on"] =     {80,1e9,Vector(385,0,5.167),0.7}
    self.SoundPositions["rpb_off"] =    {80,1e9,Vector(385,0,5.167),0.7}
    --self.SoundNames["rvt_on"] = "subway_trains/717/relays/new/rvt_on1.mp3"
    --self.SoundNames["rvt_off"] = "subway_trains/717/relays/new/rvt_off.mp3"
    self.SoundNames["rvt_on"] = "subway_trains/81-7175P/relays/RVT_on_5P.mp3"
    self.SoundNames["rvt_off"] = "subway_trains/81-7175P/relays/RVT_on_5P.mp3"
    self.SoundPositions["rvt_on"] =     {80,1e9,Vector(385,0,5.167),0.7}
    self.SoundPositions["rvt_off"] =    {80,1e9,Vector(385,0,5.167),0.7}
    --self.SoundNames["k6_on"] = "subway_trains/717/relays/new/k6_on1.mp3"
    --self.SoundNames["k6_off"] = "subway_trains/717/relays/new/k6_off.mp3"
    --self.SoundNames["k6_on"] = "subway_trains/717/relays/tkpm121_on1.mp3"
    --self.SoundNames["k6_off"] = "subway_trains/717/relays/tkpm121_off1.mp3"
    self.SoundPositions["k6_on"] =      {80,1e9,Vector(385,0,5.167),1}
    self.SoundPositions["k6_off"] = {80,1e9,Vector(385,0,5.167),1}
    --self.SoundNames["r1_5_on"] = "subway_trains/81-7175P/relays/R1_5_on1_5P.mp3"
    --self.SoundNames["r1_5_off"] = "subway_trains/81-7175P/relays/R1_5_on1_5P.mp3"
    self.SoundNames["r1_5_on"] = "subway_trains/81-7175P/relays/R1_5_on_5P.mp3"
    self.SoundNames["r1_5_off"] = "subway_trains/81-7175P/relays/RVT_on_5P.mp3"
    self.SoundPositions["r1_5_on"] =    {80,1e9,Vector(385,0,5.167),0.8}
    self.SoundPositions["r1_5_off"] =   {80,1e9,Vector(385,0,5.167),0.8}

    self.SoundNames["rot_off"] = "subway_trains/717/relays/lsd_2.mp3"
    self.SoundNames["rot_on"] = "subway_trains/717/relays/relay_on.mp3"
    self.SoundPositions["rot_on"] = {80,1e9,Vector(380,-40,40),0.25}
    self.SoundPositions["rot_off"] = {80,1e9,Vector(380,-40,40),0.25}

    --self.SoundNames["k25_on"] = "subway_trains/717/relays/new/k25_on.mp3"
    --self.SoundNames["k25_off"] = "subway_trains/717/relays/new/k25_off.mp3"
    self.SoundNames["k25_on"] = self.SoundNames["r1_5_on"]
    self.SoundNames["k25_off"] = self.SoundNames["r1_5_off"]
    self.SoundPositions["k25_on"] =     {80,1e9,Vector(385,0,5.167),0.8}
    self.SoundPositions["k25_off"] =    {80,1e9,Vector(385,0,5.167),0.8}
    --self.SoundNames["rp8_off"] = "subway_trains/717/relays/lsd_2.mp3"
    --self.SoundNames["rp8_on"] = "subway_trains/717/relays/rp8_on.wav"
    self.SoundNames["rp8_off"] = "subway_trains/81-7175P/relays/RVT_on_5P.mp3"
    self.SoundNames["rp8_on"] = "subway_trains/81-7175P/relays/RVT_on_5P.mp3"
    self.SoundPositions["rp8_on"] =     {80,1e9,Vector(385,0,5.167),0.6}
    self.SoundPositions["rp8_off"] =    {80,1e9,Vector(385,0,5.167),0.8}
    --self.SoundNames["kd_off"] = "subway_trains/717/relays/lsd_2.mp3"
    --self.SoundNames["kd_on"] = "subway_trains/717/relays/new/kd_on.mp3"
    self.SoundNames["kd_off"] = "subway_trains/81-7175P/relays/silence.mp3"  --Пропадание КД
    self.SoundNames["kd_on"] = "subway_trains/81-7175P/relays/KD_on_5P.mp3"  --Появление КД
    self.SoundPositions["kd_on"] =      {80,1e9,Vector(385,0,5.167),0.4}
    self.SoundPositions["kd_off"] =     {80,1e9,Vector(385,0,5.167),0.7}
    --self.SoundNames["ro_on"] = "subway_trains/717/relays/ro_on.mp3"
    --self.SoundNames["ro_off"] = "subway_trains/717/relays/new/ro_off.mp3"
    self.SoundNames["ro_on"] = "subway_trains/81-7175P/relays/RVT_on_5P.mp3" --Появление ВЗ1
    self.SoundNames["ro_off"] = "subway_trains/81-7175P/relays/silence.mp3"
    self.SoundPositions["ro_on"] =      {80,1e9,Vector(385,0,5.167),1.3}
    self.SoundPositions["ro_off"] =     {80,1e9,Vector(385,0,5.167),0.7}
    self.SoundNames["kk_off"] = "subway_trains/81-7175P/relays/KD_on_5P.mp3"
    self.SoundNames["kk_on"] = "subway_trains/81-7175P/relays/RVT_on_5P.mp3"
    self.SoundPositions["kk_on"] =      {80,1e9,Vector(385,0,5.167),0.85}
    self.SoundPositions["kk_off"] =     {80,1e9,Vector(385,0,5.167),0.85}


    self.SoundNames["avu_off"] = "subway_trains/81-7175P/relays/RVT_on_5P.mp3"
    self.SoundNames["avu_on"] = "subway_trains/81-7175P/relays/RVT_on_5P.mp3"
    self.SoundPositions["avu_on"] = {60,1e9, Vector(385,0,5.167),1.2}
    self.SoundPositions["avu_off"] = self.SoundPositions["avu_on"]
    --self.SoundNames["r1_5_close"] = {"subway_trains/drive_on3.wav","subway_trains/drive_on4.wav"}
    --Подвагонка
    self.SoundNames["lk2_on"] = "subway_trains/717/pneumo/lk2_on.mp3"
    self.SoundNames["lk5_on"] = "subway_trains/717/pneumo/lk1_on.mp3"
    self.SoundNames["lk2_off"] = "subway_trains/717/pneumo/lk2_off.mp3"
    self.SoundNames["lk3_on"] = "subway_trains/717/pneumo/lk3_on.mp3"
    self.SoundNames["lk3_off"] = "subway_trains/717/pneumo/lk3_off.mp3"
    --self.SoundNames["ksh1_off"] = "subway_trains/717/pneumo/ksh1.mp3"
    self.SoundPositions["lk2_on"] = {440,1e9,Vector(-60,-40,-66),0.22}
    self.SoundPositions["lk5_on"] = {440,1e9,Vector(-60,-40,-66),0.30}
    self.SoundPositions["lk2_off"] = self.SoundPositions["lk2_on"]
    self.SoundPositions["lk3_on"] = self.SoundPositions["lk2_on"]
    self.SoundPositions["lk3_off"] = self.SoundPositions["lk2_on"]
    --self.SoundPositions["ksh1_off"] = self.SoundPositions["lk1_on"]

    self.SoundNames["compressor"] = {loop=2.0,"subway_trains/d/pneumatic/compressor/compessor_d_start.wav","subway_trains/d/pneumatic/compressor/compessor_d_loop.wav", "subway_trains/d/pneumatic/compressor/compessor_d_end.wav"}
    self.SoundNames["compressor2"] = {loop=1.79,"subway_trains/717/compressor/compressor_717_start2.wav","subway_trains/717/compressor/compressor_717_loop2.wav", "subway_trains/717/compressor/compressor_717_stop2.wav"}
    self.SoundPositions["compressor"] = {600,1e9,Vector(-118,-40,-66),0.15}
    self.SoundPositions["compressor2"] = {480,1e9,Vector(-118,-40,-66),0.55}
    self.SoundNames["rk"] = {loop=0.8,"subway_trains/717/rk/rk_start.wav","subway_trains/717/rk/rk_spin.wav","subway_trains/717/rk/rk_stop.mp3"}
    self.SoundPositions["rk"] = {70,1e3,Vector(110,-40,-75),0.2}

    self.SoundNames["revers_0-f"] = "subway_trains/81-7175P/reverser/reverser_0-f_5P.mp3"
    self.SoundNames["revers_f-0"] = "subway_trains/81-7175P/reverser/reverser_f-0_5P.mp3"
    self.SoundNames["revers_0-b"] = "subway_trains/81-7175P/reverser/reverser_0-b_5P.mp3"
    self.SoundNames["revers_b-0"] = "subway_trains/81-7175P/reverser/reverser_b-0_5P.mp3"
    self.SoundNames["revers_in"] = {"subway_trains/81-7175P/reverser/reverser_in2_5P.mp3"}
    self.SoundNames["revers_out"] = {"subway_trains/81-7175P/reverser/reverser_out1_5P.mp3","subway_trains/81-7175P/reverser/reverser_out2_5P.mp3"}
    self.SoundPositions["revers_0-f"] =     {80,1e9,Vector(438.9,23.6,-3.9),0.85}
    self.SoundPositions["revers_f-0"] =     {80,1e9,Vector(438.9,23.6,-3.9),0.85}
    self.SoundPositions["revers_0-b"] =     {80,1e9,Vector(438.9,23.6,-3.9),0.85}
    self.SoundPositions["revers_b-0"] =     {80,1e9,Vector(438.9,23.6,-3.9),0.85}
    self.SoundPositions["revers_in"] =      {80,1e9,Vector(438.9,23.6,-3.9),0.85}
    self.SoundPositions["revers_out"] =     {80,1e9,Vector(438.9,23.6,-3.9),0.85}

    self.SoundNames["kru_in"] = {
        "subway_trains/717/kru/kru_insert1.mp3",
        "subway_trains/717/kru/kru_insert2.mp3"
    }
    self.SoundPositions["kru_in"] = {80,1e9,Vector(452.3,-24.0,4.0)}
    self.SoundNames["kru_out"] = {
        "subway_trains/717/kru/kru_eject1.mp3",
        "subway_trains/717/kru/kru_eject2.mp3",
        "subway_trains/717/kru/kru_eject3.mp3",
    }
    self.SoundPositions["kru_out"] = {80,1e9,Vector(452.3,-24.0,4.0)}

    self.SoundNames["kru_0_1"] = {
        "subway_trains/717/kru/kru0-1_1.mp3",
        "subway_trains/717/kru/kru0-1_2.mp3",
        "subway_trains/717/kru/kru0-1_3.mp3",
        "subway_trains/717/kru/kru0-1_4.mp3",
    }
    self.SoundNames["kru_1_2"] = {
        "subway_trains/717/kru/kru1-2_1.mp3",
        "subway_trains/717/kru/kru1-2_2.mp3",
        "subway_trains/717/kru/kru1-2_3.mp3",
        "subway_trains/717/kru/kru1-2_4.mp3",
    }
    self.SoundNames["kru_2_1"] = {
        "subway_trains/717/kru/kru2-1_1.mp3",
        "subway_trains/717/kru/kru2-1_2.mp3",
        "subway_trains/717/kru/kru2-1_3.mp3",
        "subway_trains/717/kru/kru2-1_4.mp3",
    }
    self.SoundNames["kru_1_0"] = {
        "subway_trains/717/kru/kru1-0_1.mp3",
        "subway_trains/717/kru/kru1-0_2.mp3",
        "subway_trains/717/kru/kru1-0_3.mp3",
        "subway_trains/717/kru/kru1-0_4.mp3",
    }
    self.SoundNames["kru_2_3"] = {
        "subway_trains/717/kru/kru2-3_1.mp3",
        "subway_trains/717/kru/kru2-3_2.mp3",
        "subway_trains/717/kru/kru2-3_3.mp3",
        "subway_trains/717/kru/kru2-3_4.mp3",
    }
    self.SoundNames["kru_3_2"] = {
        "subway_trains/717/kru/kru3-2_1.mp3",
        "subway_trains/717/kru/kru3-2_2.mp3",
        "subway_trains/717/kru/kru3-2_3.mp3",
        "subway_trains/717/kru/kru3-2_4.mp3",
    }
    self.SoundPositions["kru_0_1"] = {80,1e9,Vector(441,-33,-6)}
    self.SoundPositions["kru_1_2"] = {80,1e9,Vector(441,-33,-6)}
    self.SoundPositions["kru_2_1"] = {80,1e9,Vector(441,-33,-6)}
    self.SoundPositions["kru_1_0"] = {80,1e9,Vector(441,-33,-6)}
    self.SoundPositions["kru_2_3"] = {80,1e9,Vector(441,-33,-6)}
    self.SoundPositions["kru_3_2"] = {80,1e9,Vector(441,-33,-6)}

    self.SoundNames["pvk2"] = "subway_trains/717/switches/vent1-2.mp3"
    self.SoundNames["pvk1"] = "subway_trains/717/switches/vent2-1.mp3"
    self.SoundNames["pvk0"] = "subway_trains/717/switches/vent1-0.mp3"
    self.SoundNames["vent_cabl"] = {loop=true,"subway_trains/717/vent/vent_cab_high.wav"}
    self.SoundPositions["vent_cabl"] = {140,1e9,Vector(415,-52,0),0.66}
    self.SoundNames["vent_cabh"] = {loop=true,"subway_trains/717/vent/vent_cab_high.wav"}
    self.SoundPositions["vent_cabh"] = self.SoundPositions["vent_cabl"]

    self.SoundNames["kr_open"] = {
        "subway_trains/717/cover/cover_open1.mp3",
        "subway_trains/717/cover/cover_open2.mp3",
        "subway_trains/717/cover/cover_open3.mp3",
    }
    self.SoundNames["kr_close"] = {
        "subway_trains/717/cover/cover_close1.mp3",
        "subway_trains/717/cover/cover_close2.mp3",
        "subway_trains/717/cover/cover_close3.mp3",
    }

    self.SoundNames["switch_off"] = {
        "subway_trains/717/switches/tumbler_slim_off1.mp3",
        "subway_trains/717/switches/tumbler_slim_off2.mp3",
        "subway_trains/717/switches/tumbler_slim_off3.mp3",
        "subway_trains/717/switches/tumbler_slim_off4.mp3",
    }
    self.SoundNames["switch_on"] = {
        "subway_trains/717/switches/tumbler_slim_on1.mp3",
        "subway_trains/717/switches/tumbler_slim_on2.mp3",
        "subway_trains/717/switches/tumbler_slim_on3.mp3",
        "subway_trains/717/switches/tumbler_slim_on4.mp3",
    }

    self.SoundNames["switchbl_off"] = {
        "subway_trains/717/switches/tumbler_fatb_off1.mp3",
        "subway_trains/717/switches/tumbler_fatb_off2.mp3",
        "subway_trains/717/switches/tumbler_fatb_off3.mp3",
    }
    self.SoundNames["switchbl_on"] = {
        "subway_trains/717/switches/tumbler_fatb_on1.mp3",
        "subway_trains/717/switches/tumbler_fatb_on2.mp3",
        "subway_trains/717/switches/tumbler_fatb_on3.mp3",
    }
	
	self.SoundNames["tumbler_5P_on"] = {
        "subway_trains/81-7175P/tumbler/tumbler_5P_on.mp3",
    }
	
	self.SoundNames["tumbler_5P_off"] = {
        "subway_trains/81-7175P/tumbler/tumbler_5P_off.mp3",
    }
	
	self.SoundNames["button_on"] = {"subway_trains/722/switches/button_press1.mp3","subway_trains/722/switches/button_press2.mp3","subway_trains/722/switches/button_press3.mp3"}
    self.SoundNames["button_off"] = {"subway_trains/722/switches/button_release1.mp3","subway_trains/722/switches/button_release2.mp3","subway_trains/722/switches/button_release3.mp3"}
    self.SoundNames["button_square_press"] = "subway_trains/720/switches/butts_press.mp3"
    self.SoundNames["button_square_release"] = "subway_trains/720/switches/butts_release.mp3"

    self.SoundNames["triple_down-0"] = {
        "subway_trains/717/switches/tumbler_triple_down-0_1.mp3",
        "subway_trains/717/switches/tumbler_triple_down-0_2.mp3",
    }
    self.SoundNames["triple_0-up"] = {
        "subway_trains/717/switches/tumbler_triple_0-up_1.mp3",
        "subway_trains/717/switches/tumbler_triple_0-up_2.mp3",
    }
    self.SoundNames["triple_up-0"] = {
        "subway_trains/717/switches/tumbler_triple_up-0_1.mp3",
        "subway_trains/717/switches/tumbler_triple_up-0_2.mp3",
    }
    self.SoundNames["triple_0-down"] = {
        "subway_trains/717/switches/tumbler_triple_0-down_1.mp3",
        "subway_trains/717/switches/tumbler_triple_0-down_2.mp3",
    }
    self.SoundNames["button1_off"] = {
        "subway_trains/717/switches/button1_off1.mp3",
        "subway_trains/717/switches/button1_off2.mp3",
        "subway_trains/717/switches/button1_off3.mp3",
    }
    self.SoundNames["button1_on"] = {
        "subway_trains/717/switches/button1_on1.mp3",
        "subway_trains/717/switches/button1_on2.mp3",
        "subway_trains/717/switches/button1_on3.mp3",
    }
    self.SoundNames["button2_off"] = {
        "subway_trains/717/switches/button2_off1.mp3",
        "subway_trains/717/switches/button2_off2.mp3",
    }
    self.SoundNames["button2_on"] = {
        "subway_trains/717/switches/button2_on1.mp3",
        "subway_trains/717/switches/button2_on2.mp3",
    }
    self.SoundNames["button3_off"] = {
        "subway_trains/717/switches/button3_off1.mp3",
        "subway_trains/717/switches/button3_off2.mp3",
    }
    self.SoundNames["button3_on"] = {
        "subway_trains/717/switches/button3_on1.mp3",
        "subway_trains/717/switches/button3_on2.mp3",
    }
    self.SoundNames["button4_off"] = {
        "subway_trains/717/switches/button4_off1.mp3",
        "subway_trains/717/switches/button4_off2.mp3",
    }
    self.SoundNames["button4_on"] = {
        "subway_trains/717/switches/button4_on1.mp3",
        "subway_trains/717/switches/button4_on2.mp3",
    }
    self.SoundNames["vu22_on"] = {"subway_trains/ezh3/vu/vu22_on1.mp3", "subway_trains/ezh3/vu/vu22_on2.mp3", "subway_trains/ezh3/vu/vu22_on3.mp3"}
    self.SoundNames["vu22_off"] = {"subway_trains/ezh3/vu/vu22_off1.mp3", "subway_trains/ezh3/vu/vu22_off2.mp3", "subway_trains/ezh3/vu/vu22_off3.mp3"}

    self.SoundNames["uava_reset"] = {
        "subway_trains/common/uava/uava_reset1.mp3",
        "subway_trains/common/uava/uava_reset2.mp3",
        "subway_trains/common/uava/uava_reset4.mp3",
    }
    self.SoundPositions["uava_reset"] = {80,1e9,Vector(429.6,-60.8,-15.9),0.95}
    self.SoundNames["gv_f"] = {"subway_trains/717/kv70/reverser_0-b_1.mp3","subway_trains/717/kv70/reverser_0-b_2.mp3"}
    self.SoundNames["gv_b"] = {"subway_trains/717/kv70/reverser_b-0_1.mp3","subway_trains/717/kv70/reverser_b-0_2.mp3"}

    self.SoundNames["disconnect_valve"] = "subway_trains/common/switches/pneumo_disconnect_switch.mp3"

    self.SoundNames["brake_f"] = {"subway_trains/common/pneumatic/vz_brake_on2.mp3","subway_trains/common/pneumatic/vz_brake_on3.mp3","subway_trains/common/pneumatic/vz_brake_on4.mp3"}
    self.SoundPositions["brake_f"] = {50,1e9,Vector(317-8,0,-82),0.13}
    self.SoundNames["brake_b"] = self.SoundNames["brake_f"]
    self.SoundPositions["brake_b"] = {50,1e9,Vector(-317+0,0,-82),0.13}
    self.SoundNames["release1"] = {loop=true,"subway_trains/common/pneumatic/release_0.wav"}
    self.SoundPositions["release1"] = {350,1e9,Vector(-183,0,-70),3}
    self.SoundNames["release2"] = {loop=true,"subway_trains/common/pneumatic/release_low.wav"}
    self.SoundPositions["release2"] = {350,1e9,Vector(-183,0,-70),1.5}

    self.SoundNames["parking_brake"] = {loop=true,"subway_trains/common/pneumatic/parking_brake.wav"}
    self.SoundNames["parking_brake_en"] = "subway_trains/common/pneumatic/parking_brake_stop.mp3"
    self.SoundNames["parking_brake_rel"] = "subway_trains/common/pneumatic/parking_brake_stop2.mp3"
    self.SoundPositions["parking_brake"] = {80,1e9,Vector(453.6,-0.25,-39.8),0.6}
    self.SoundPositions["parking_brake_en"] = self.SoundPositions["parking_brake"]
    self.SoundPositions["parking_brake_rel"] = self.SoundPositions["parking_brake"]
    self.SoundNames["front_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["front_isolation"] = {300,1e9,Vector(443, 0,-63),1}
    self.SoundNames["rear_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["rear_isolation"] = {300,1e9,Vector(-456, 0,-63),1}

    self.SoundNames["crane013_brake"] = {loop=true,"subway_trains/common/pneumatic/release_2.wav"}
    self.SoundPositions["crane013_brake"] = {80,1e9,Vector(431.5,-20.3,-12),0.86}
    self.SoundNames["crane013_brake2"] = {loop=true,"subway_trains/common/pneumatic/013_brake2.wav"}
    self.SoundPositions["crane013_brake2"] = {80,1e9,Vector(431.5,-20.3,-12),0.86}
    self.SoundNames["crane013_release"] = {loop=true,"subway_trains/common/pneumatic/013_release.wav"}
    self.SoundPositions["crane013_release"] = {80,1e9,Vector(431.5,-20.3,-12),0.4}
	
	self.SoundNames["br_013_5P_6-7"]		= "subway_trains/81-7175P/013_5P/013_5P_6-7.mp3"
	self.SoundNames["br_013_5P_2-1"]		= "subway_trains/81-7175P/013_5P/013_5P_2-1.mp3"
	
	self.SoundNames["br_013_5P"]		= {
		"subway_trains/81-7175P/013_5P/013_5P_3-4.mp3",
		"subway_trains/81-7175P/013_5P/013_5P_4-5.mp3",
		"subway_trains/81-7175P/013_5P/013_5P_5-6.mp3",
		"subway_trains/81-7175P/013_5P/013_5P_2-3.mp3",
	}

    self.SoundNames["epk_brake"] = {loop=true,"subway_trains/common/pneumatic/epv_loop.wav"}
    self.SoundPositions["epk_brake"] = {80,1e9,Vector(437.2,-53.1,-32.0),0.65}

    self.SoundNames["valve_brake"] = {loop=true,"subway_trains/common/pneumatic/epv_loop.wav"}
    self.SoundPositions["valve_brake"] = {80,1e9,Vector(408.45,62.15,11.5),1}

    self.SoundNames["emer_brake"] = {loop=true,"subway_trains/common/pneumatic/autostop_loop.wav"}
    self.SoundNames["emer_brake2"] = {loop=true,"subway_trains/common/pneumatic/autostop_loop_2.wav"}
    self.SoundPositions["emer_brake"] = {600,1e9,Vector(401,62,-84),0.95}
    self.SoundPositions["emer_brake2"] = {600,1e9,Vector(401,62,-84),1}
    self.SoundPositions["emer_brake2"] = self.SoundPositions["emer_brake"]

    self.SoundNames["pak_on"] = "subway_trains/717/switches/rc_on.mp3"
    self.SoundNames["pak_off"] = "subway_trains/717/switches/rc_off.mp3"

    self.SoundNames["kv70_fix_on"] = {"subway_trains/717/kv70/kv70_fix_on1.mp3","subway_trains/717/kv70/kv70_fix_on2.mp3"}
    self.SoundNames["kv70_fix_off"] = {"subway_trains/717/kv70/kv70_fix_off1.mp3","subway_trains/717/kv70/kv70_fix_off2.mp3"}
    --[[self.SoundNames["kv70_0_t1"] = "subway_trains/81-7175P/bkm/0_t1.mp3"
    self.SoundNames["kv70_t1_0_fix"]= "subway_trains/81-7175P/bkm/t1_0.mp3"
    self.SoundNames["kv70_t1_0"] = "subway_trains/81-7175P/bkm/t1_0.mp3"
    self.SoundNames["kv70_t1_t1a"] = "subway_trains/81-7175P/bkm/t1_t1a.mp3"
    self.SoundNames["kv70_t1a_t1"] = "subway_trains/81-7175P/bkm/t1a_t1.mp3"
    self.SoundNames["kv70_t1a_t2"] = "subway_trains/81-7175P/bkm/t1a_t2.mp3"
    self.SoundNames["kv70_t2_t1a"] = "subway_trains/81-7175P/bkm/t2_t1a.mp3"
    self.SoundNames["kv70_0_x1"] = "subway_trains/81-7175P/bkm/0_x1.mp3"
    self.SoundNames["kv70_x1_0"] = "subway_trains/81-7175P/bkm/x1_0.mp3"
    self.SoundNames["kv70_x1_x2"] = "subway_trains/81-7175P/bkm/x1_x2.mp3"
    self.SoundNames["kv70_x2_x1"] = "subway_trains/81-7175P/bkm/x2_x1.mp3"
    self.SoundNames["kv70_x2_x3"] = "subway_trains/81-7175P/bkm/x2_x3.mp3"
    self.SoundNames["kv70_x3_x2"] = "subway_trains/81-7175P/bkm/x3_x2.mp3"--]]
    self.SoundNames["kv70_0_t1"] = "subway_trains/81-7175P/bkm/0-t1.mp3"
    self.SoundNames["kv70_t1_0_fix"]= "subway_trains/81-7175P/bkm/t1-0.mp3"
    self.SoundNames["kv70_t1_0"] = "subway_trains/81-7175P/bkm/t1-0.mp3"
    self.SoundNames["kv70_t1_t1a"] = "subway_trains/81-7175P/bkm/t1-t1a.mp3"
    self.SoundNames["kv70_t1a_t1"] = "subway_trains/81-7175P/bkm/t1a-t1.mp3"
    self.SoundNames["kv70_t1a_t2"] = "subway_trains/81-7175P/bkm/t1a-t2.mp3"
    self.SoundNames["kv70_t2_t1a"] = "subway_trains/81-7175P/bkm/t2-t1a.mp3"
    self.SoundNames["kv70_0_x1"] = "subway_trains/81-7175P/bkm/0-x1.mp3"
    self.SoundNames["kv70_x1_0"] = "subway_trains/81-7175P/bkm/x1-0.mp3"
    self.SoundNames["kv70_x1_x2"] = "subway_trains/81-7175P/bkm/x1-x2.mp3"
    self.SoundNames["kv70_x2_x1"] = "subway_trains/81-7175P/bkm/x2-x1.mp3"
    self.SoundNames["kv70_x2_x3"] = "subway_trains/81-7175P/bkm/x2-x3.mp3"
    self.SoundNames["kv70_x3_x2"] = "subway_trains/81-7175P/bkm/x3-x2.mp3"
    self.SoundPositions["kv70_fix_on"] = {110,1e9,Vector(440,17.5,-5.25),0.4}
    self.SoundPositions["kv70_fix_off"] = self.SoundPositions["kv70_fix_on"]
    self.SoundPositions["kv70_0_t1"] = {110,1e9,Vector(440,17.5,-5.25),0.9}
    self.SoundPositions["kv70_t1_0_fix"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_t1_0"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_t1_t1a"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_t1a_t1"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_t1a_t2"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_t2_t1a"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_0_x1"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_x1_0"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_x1_x2"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_x2_x1"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_x2_x3"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_x3_x2"] = self.SoundPositions["kv70_0_t1"]

    self.SoundNames["kv70_0_t1_2"] = "subway_trains/81-7175P/bkm/0_t1.mp3"
    self.SoundNames["kv70_t1_0_2"] = "subway_trains/81-7175P/bkm/t1_0.mp3"
    self.SoundNames["kv70_t1_t1a_2"] = "subway_trains/81-7175P/bkm/t1_t1a.mp3"
    self.SoundNames["kv70_t1a_t1_2"] = "subway_trains/81-7175P/bkm/t1a_t1.mp3"
    self.SoundNames["kv70_t1a_t2_2"] = "subway_trains/81-7175P/bkm/t1a_t2.mp3"
    self.SoundNames["kv70_t2_t1a_2"] = "subway_trains/81-7175P/bkm/t2_t1a.mp3"
    self.SoundNames["kv70_0_x1_2"] = "subway_trains/81-7175P/bkm/0_x1.mp3"
    self.SoundNames["kv70_x1_0_2"] = "subway_trains/81-7175P/bkm/x1_0.mp3"
    self.SoundNames["kv70_x1_x2_2"] = "subway_trains/81-7175P/bkm/x1_x2.mp3"
    self.SoundNames["kv70_x2_x1_2"] = "subway_trains/81-7175P/bkm/x2_x1.mp3"
    self.SoundNames["kv70_x2_x3_2"] = "subway_trains/81-7175P/bkm/x2_x3.mp3"
    self.SoundNames["kv70_x3_x2_2"] = "subway_trains/81-7175P/bkm/x3_x2.mp3"
    self.SoundPositions["kv70_0_t1_2"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_t1_0_fix_2"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_t1_0_2"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_t1_t1a_2"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_t1a_t1_2"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_t1a_t2_2"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_t2_t1a_2"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_0_x1_2"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_x1_0_2"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_x1_x2_2"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_x2_x1_2"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_x2_x3_2"] = self.SoundPositions["kv70_0_t1"]
    self.SoundPositions["kv70_x3_x2_2"] = self.SoundPositions["kv70_0_t1"]

    self.SoundNames["ring"] = {loop=0.0,"subway_trains/81-7175P/ring/ring_loop_5P.wav"}
    self.SoundPositions["ring"] = {60,1e9,Vector(450,22,0),2}
    self.SoundNames["pu_ring"] = {loop=0.0,"subway_trains/81-7175P/ring/ring_loop_5P.wav"}
    self.SoundPositions["pu_ring"] = {60,1e9,Vector(450,22,0),2}
    self.SoundNames["ASPS_ring"] = {loop=0,"subway_trains/722/ring_start.mp3","subway_trains/722/ring_loop.wav","subway_trains/722/ring_end.mp3"}
    self.SoundPositions["ASPS_ring"] = {60,1e9,Vector(449,-56.5,14),0.2}
	
	self.SoundNames["ECRS"] = "subway_trains/81-7175P/ring/ECRS.wav"
    self.SoundPositions["ECRS"] = {60,1e9,Vector(452,-24,10),1}
    
    -- self.SoundNames["vpr"] = {loop=0.8,"subway_trains/common/other/radio/vpr_start.wav","subway_trains/common/other/radio/vpr_loop.wav","subway_trains/common/other/radio/vpr_off.wav"}
    -- self.SoundPositions["vpr"] = {60,1e9,Vector(420,-49 ,61),0.05}

    self.SoundNames["cab_door_open"] = "subway_trains/common/door/cab/door_open.mp3"
    self.SoundNames["cab_door_close"] = "subway_trains/common/door/cab/door_close.mp3"
    self.SoundNames["otsek_door_open"] = {"subway_trains/720/door/door_torec_open.mp3","subway_trains/720/door/door_torec_open2.mp3"}
    self.SoundNames["otsek_door_close"] = {"subway_trains/720/door/door_torec_close.mp3","subway_trains/720/door/door_torec_close2.mp3"}
	
	self.SoundNames["multiswitch_panel_max"] = "subway_trains/722/switches/multi_switch_panel_max.mp3"
    self.SoundNames["multiswitch_panel_mid"] = {"subway_trains/722/switches/multi_switch_panel_mid.mp3","subway_trains/722/switches/multi_switch_panel_mid2.mp3"}
    self.SoundNames["multiswitch_panel_min"] = "subway_trains/722/switches/multi_switch_panel_min.mp3"
	
	self.SoundNames["switch_kb_on"] = "subway_trains/722/switches/big_red_kb_on.mp3"
    self.SoundNames["switch_kb_off"] = "subway_trains/722/switches/big_red_kb_off.mp3"


    self.SoundNames["igla_on"]  = "subway_trains/common/other/igla/igla_on1.mp3"
    self.SoundNames["igla_off"] = "subway_trains/common/other/igla/igla_off2.mp3"
    self.SoundNames["igla_start1"]  = "subway_trains/common/other/igla/igla_start.mp3"
    self.SoundNames["igla_start2"]  = "subway_trains/common/other/igla/igla_start2.mp3"
    self.SoundNames["igla_alarm1"]  = "subway_trains/common/other/igla/igla_alarm1.mp3"
    self.SoundNames["igla_alarm2"]  = "subway_trains/common/other/igla/igla_alarm2.mp3"
    self.SoundNames["igla_alarm3"]  = "subway_trains/common/other/igla/igla_alarm3.mp3"
    self.SoundPositions["igla_on"] =        {50,1e9,Vector(458.50,-33,34),0.15}
    self.SoundPositions["igla_off"] =       {50,1e9,Vector(458.50,-33,34),0.15}
    self.SoundPositions["igla_start1"] =    {50,1e9,Vector(458.50,-33,34),0.33}
    self.SoundPositions["igla_start2"] =    {50,1e9,Vector(458.50,-33,34),0.15}
    self.SoundPositions["igla_alarm1"] =    {50,1e9,Vector(458.50,-33,34),0.33}
    self.SoundPositions["igla_alarm2"] =    {50,1e9,Vector(458.50,-33,34),0.33}
    self.SoundPositions["igla_alarm3"] =    {50,1e9,Vector(458.50,-33,34),0.33}

    self.SoundNames["pnm_on"]           = {"subway_trains/common/pnm/pnm_switch_on.mp3","subway_trains/common/pnm/pnm_switch_on2.mp3"}
    self.SoundNames["pnm_off"]          = {"subway_trains/common/pnm/pnm_switch_off.mp3","subway_trains/common/pnm/pnm_switch_off2.mp3"}
    self.SoundNames["pnm_button1_on"]           = {
        "subway_trains/common/pnm/pnm_button_push.mp3",
        "subway_trains/common/pnm/pnm_button_push2.mp3",
        "subway_trains/common/pnm/pnm_button_push3.mp3",
    }

    self.SoundNames["pnm_button2_on"]           = {
        "subway_trains/common/pnm/pnm_button_push4.mp3",
        "subway_trains/common/pnm/pnm_button_push5.mp3",
        "subway_trains/common/pnm/pnm_button_push6.mp3",
    }

    self.SoundNames["pnm_button1_off"]          = {
        "subway_trains/common/pnm/pnm_button_release.mp3",
        "subway_trains/common/pnm/pnm_button_release2.mp3",
        "subway_trains/common/pnm/pnm_button_release3.mp3",
    }

    self.SoundNames["pnm_button2_off"]          = {
        "subway_trains/common/pnm/pnm_button_release4.mp3",
        "subway_trains/common/pnm/pnm_button_release5.mp3",
        "subway_trains/common/pnm/pnm_button_release6.mp3",
    }

    self.SoundNames["horn"] = {loop=0.6,"subway_trains/81-7175P/horn/horn_start_5P.wav","subway_trains/81-7175P/horn/horn_loop_5P.wav", "subway_trains/81-7175P/horn/horn_end_5P.wav"}
    self.SoundPositions["horn"] = {1100,1e9,Vector(450,0,-55)}

    --DOORS
    self.SoundNames["vdol_on"] = {
        "subway_trains/common/pneumatic/door_valve/VDO_on.mp3",
        "subway_trains/common/pneumatic/door_valve/VDO2_on.mp3",
    }
    self.SoundNames["vdol_off"] = {
        "subway_trains/common/pneumatic/door_valve/VDO_off.mp3",
        "subway_trains/common/pneumatic/door_valve/VDO2_off.mp3",
    }
    self.SoundPositions["vdol_on"] = {60,1e9,Vector(-420,45,-30),0.86}
    self.SoundPositions["vdol_off"] = {60,1e9,Vector(-420,45,-30),0.4}
    self.SoundNames["vdor_on"] = self.SoundNames["vdol_on"]
    self.SoundNames["vdor_off"] = self.SoundNames["vdol_off"]
    self.SoundPositions["vdor_on"] = self.SoundPositions["vdol_on"]
    self.SoundPositions["vdor_off"] = self.SoundPositions["vdol_off"]
    self.SoundNames["vdz_on"] = {
        "subway_trains/common/pneumatic/door_valve/VDZ_on.mp3",
        "subway_trains/common/pneumatic/door_valve/VDZ2_on.mp3",
        "subway_trains/common/pneumatic/door_valve/VDZ3_on.mp3",
    }
    self.SoundNames["vdz_off"] = {
        "subway_trains/common/pneumatic/door_valve/VDZ_off.mp3",
        "subway_trains/common/pneumatic/door_valve/VDZ2_off.mp3",
        "subway_trains/common/pneumatic/door_valve/VDZ3_off.mp3",
    }
    self.SoundPositions["vdz_on"] = {60,1e9,Vector(-420,45,-30),1}
    self.SoundPositions["vdz_off"] = {60,1e9,Vector(-420,45,-30),0.4}

    self.SoundNames["RKR"] = "subway_trains/common/pneumatic/RKR2.mp3"
    self.SoundPositions["RKR"] = {330,1e9,Vector(-27,-40,-66),0.22}

    self.SoundNames["PN2end"] = {"subway_trains/common/pneumatic/vz2_end.mp3","subway_trains/common/pneumatic/vz2_end_2.mp3","subway_trains/common/pneumatic/vz2_end_3.mp3","subway_trains/common/pneumatic/vz2_end_4.mp3"}
    self.SoundPositions["PN2end"] = {350,1e9,Vector(-183,0,-70),0.3}

    for i=0,3 do
        for k=0,1 do
            self.SoundNames["door"..i.."x"..k.."r"] = {"subway_trains/81-7175P/doors/door_roll_5P.mp3",loop=true}
            self.SoundPositions["door"..i.."x"..k.."r"] = {150,1e9,GetDoorPosition(i,k),0.6}
            self.SoundNames["door"..i.."x"..k.."o"] = {"subway_trains/common/door/door_open_end5.mp3","subway_trains/common/door/door_open_end6.mp3","subway_trains/common/door/door_open_end7.mp3"}
            self.SoundPositions["door"..i.."x"..k.."o"] = {250,1e9,GetDoorPosition(i,k),1}
            self.SoundNames["door"..i.."x"..k.."c"] = {"subway_trains/81-7175P/doors/door_close_end_5P.mp3"}
            self.SoundPositions["door"..i.."x"..k.."c"] = {400,1e9,GetDoorPosition(i,k),0.45}
        end
    end
    for k,v in ipairs(self.AnnouncerPositions) do
        self.SoundNames["announcer_buzz1_"..k] = {loop=true,"subway_announcers/upo/noiseT.wav"}
        self.SoundPositions["announcer_buzz1_"..k] = {v[2] or 300,1e9,v[1],v[3]*0.0}
        self.SoundNames["announcer_buzz2_"..k] = {loop=true,"subway_announcers/upo/noiseT2.wav"}
        self.SoundPositions["announcer_buzz2_"..k] = {v[2] or 300,1e9,v[1],v[3]*0.0 }
        self.SoundNames["announcer_noise1_"..k] = {loop=true,"subway_announcers/upo/noiseS1.wav"}
        self.SoundPositions["announcer_noise1_"..k] = {v[2] or 300,1e9,v[1],v[3]*0.0}
        self.SoundNames["announcer_noise2_"..k] = {loop=true,"subway_announcers/upo/noiseS2.wav"}
        self.SoundPositions["announcer_noise2_"..k] = {v[2] or 300,1e9,v[1],v[3]*0.0}
        self.SoundNames["announcer_noise3_"..k] = {loop=true,"subway_announcers/upo/noiseS3.wav"}
        self.SoundPositions["announcer_noise3_"..k] = {v[2] or 300,1e9,v[1],v[3]*0.0}
        self.SoundNames["announcer_noiseW"..k] = {loop=true,"subway_announcers/upo/noiseW.wav"}
        self.SoundPositions["announcer_noiseW"..k] = {v[2] or 300,1e9,v[1],v[3]*0.0}
    end

    self.SoundNames["pa_m"] = "subway_trains/717/pa/key_m.mp3"
    self.SoundNames["pa_down"] = "subway_trains/717/pa/key_down.mp3"
    self.SoundNames["pa_f"] = "subway_trains/717/pa/key_f.mp3"
    self.SoundNames["pa_up"] = "subway_trains/717/pa/key_up.mp3"
    self.SoundNames["pa_right"] = "subway_trains/717/pa/key_right.mp3"
    self.SoundNames["pa_left"] = "subway_trains/717/pa/key_left.mp3"
    self.SoundNames["pa_p"] = "subway_trains/717/pa/key_p.mp3"

    self.SoundNames["pa_1"] = "subway_trains/717/pa/key_1.mp3"
    self.SoundNames["pa_2"] = "subway_trains/717/pa/key_2.mp3"
    self.SoundNames["pa_3"] = "subway_trains/717/pa/key_3.mp3"
    self.SoundNames["pa_4"] = "subway_trains/717/pa/key_4.mp3"
    self.SoundNames["pa_5"] = "subway_trains/717/pa/key_5.mp3"
    self.SoundNames["pa_6"] = "subway_trains/717/pa/key_6.mp3"
    self.SoundNames["pa_7"] = "subway_trains/717/pa/key_7.mp3"
    self.SoundNames["pa_8"] = "subway_trains/717/pa/key_8.mp3"
    self.SoundNames["pa_9"] = "subway_trains/717/pa/key_9.mp3"
    self.SoundNames["pa_esc"] = "subway_trains/717/pa/key_esc.mp3"
    self.SoundNames["pa_0"] = "subway_trains/717/pa/key_0.mp3"
    self.SoundNames["pa_enter"] = "subway_trains/717/pa/key_enter.mp3"
    self.SoundPositions["pa_m"] = {65,1e9,Vector(443.60,20.10,-4.30),0.3}
    self.SoundPositions["pa_down"] = self.SoundPositions["pa_m"]
    self.SoundPositions["pa_f"] = self.SoundPositions["pa_m"]
    self.SoundPositions["pa_up"] = self.SoundPositions["pa_m"]
    self.SoundPositions["pa_right"] = self.SoundPositions["pa_m"]
    self.SoundPositions["pa_left"] = self.SoundPositions["pa_m"]
    self.SoundPositions["pa_p"] = self.SoundPositions["pa_m"]
    self.SoundPositions["pa_1"] = self.SoundPositions["pa_m"]
    self.SoundPositions["pa_2"] = self.SoundPositions["pa_m"]
    self.SoundPositions["pa_3"] = self.SoundPositions["pa_m"]
    self.SoundPositions["pa_4"] = self.SoundPositions["pa_m"]
    self.SoundPositions["pa_5"] = self.SoundPositions["pa_m"]
    self.SoundPositions["pa_6"] = self.SoundPositions["pa_m"]
    self.SoundPositions["pa_7"] = self.SoundPositions["pa_m"]
    self.SoundPositions["pa_8"] = self.SoundPositions["pa_m"]
    self.SoundPositions["pa_9"] = self.SoundPositions["pa_m"]
    self.SoundPositions["pa_esc"] = self.SoundPositions["pa_m"]
    self.SoundPositions["pa_0"] = self.SoundPositions["pa_m"]
    self.SoundPositions["pa_enter"] = self.SoundPositions["pa_m"]
    self:SetRelays()
    --Vector(-420,45,-30)
end
ENT.PR14XRelaysOrder = {"r1_5_on","r1_5_off","rp8_on","rp8_off","ro_on","ro_off","rpb_on","rpb_off","k6_on","k6_off","rvt_on","rvt_off","kd_on","kd_off","k25_on","k25_off",}
ENT.PR14XRelays = {
    --orig 1
    r1_5_on = {
        {"kpd110e_on2", 1},
        --^ SPB ONLY ^
        {"kpd110e_on4", 0.8},
        {"kpd110e_on5", 0.8},
        {"kpd110e_on6", 0.8},
        --v MSK ONLY v
        --{"kpd110e_on1", 1},
        --{"kpd110e_on3", 0.7},
        --{"kpd110e_on7", 0.8},
    },
    --orig 0.7
    r1_5_off = {
        {"kpd110e_off1",0.9},
        {"kpd110e_off2",1},
        --^ SPB ONLY ^
        --v MSK ONLY v
        --{"kpd110e_off5", 0.9},
        --{"kpd110e_off6", 0.8},
    },
    --orig 1
    rvt_on = {
        {"rev811t_on2", 1},
        {"rev811t_on3", 1},
        {"rev811t_on4", 1},
        {"rev811t_on5", 0.6},
    },
    --orig 1
    rp8_on = {
        {"rev811t_on1", 1},
        {"rev811t_on2", 1},
        {"rev811t_on3", 1},
        {"rev811t_on4", 1},
        {"rev811t_on5", 0.6},
    },
    --orig 0.3
    rp8_off = {
        {"rev811t_off1",0.3},
        {"rev811t_off2",0.2},
        {"rev811t_off4",0.3},
    },
    ro_on = {
        --^ SPB ONLY ^
        {"kpd110e_on4",0.8},
        {"kpd110e_on5",0.8},
        {"kpd110e_on6",0.8},
        {"kpd110e_on1",1},
        {"kpd110e_on3",0.7},
        {"kpd110e_on7",0.8},
        --v MSK ONLY v
    },
    ro_off = {
        --^ SPB ONLY ^
        {"kpd110e_off1",0.9},
        {"kpd110e_off2",1},
        {"kpd110e_off5",0.9},
        {"kpd110e_off6",0.8},
        --v MSK ONLY v
    },
    --1
    rpb_on = {{"rev813t_on1",1},{"rev813t_on2",1}},
    --0.7
    rpb_off = {{"rev813t_off1",0.7}},
    --1
    k6_on = {{"tkpm121_on1",1},{"tkpm121_on2",1}},
    --1
    k6_off = {{"tkpm121_off1",1},{"tkpm121_off2",1}},
}
ENT.PR14XRelays.rvt_off = ENT.PR14XRelays.rp8_off
ENT.PR14XRelays.kd_on = ENT.PR14XRelays.rp8_on
ENT.PR14XRelays.kd_off = ENT.PR14XRelays.rp8_off
ENT.PR14XRelays.k25_on = ENT.PR14XRelays.ro_on
ENT.PR14XRelays.k25_off = ENT.PR14XRelays.ro_off
function ENT:SetRelays()
    local relayConf = self:GetNW2String("RelaysConfig")
    if #relayConf<#self.PR14XRelaysOrder then return end
    for i,k in ipairs(self.PR14XRelaysOrder) do
        local id = tonumber(relayConf[i])
        local v = self.PR14XRelays[k][id]
        --self.SoundNames[k] = Format("subway_trains/81-7175P/relays/%s.mp3",v[1])
        self.SoundPositions[k][4] = v[2] or 1
    end
end

function ENT:PostInitializeSystems()
    self.Electric:TriggerInput("NoRT2",1)
    self.Electric:TriggerInput("HaveRO",1)
    self.Electric:TriggerInput("GreenRPRKR",0)
    self.Electric:TriggerInput("Type",self.Electric.LVZ_2)
    self.Electric:TriggerInput("X2PS",1)
    self.KRU:TriggerInput("LockX3",1)
    if SERVER and (not Metrostroi.MapHasFullSupport or not Metrostroi.MapHasFullSupport("sbpp") and not Metrostroi.MapHasFullSupport("auto")) then
        self.PUAV:TriggerInput("CommandDoorsLeft",1)
        self.PUAV:TriggerInput("CommandDoorsRight",1)
    end
end
function ENT:InitializeSystems()
    -- Электросистема
    self:LoadSystem("Electric","81_717_5P_Electric")

    -- Бегущая строка .5П
	self:LoadSystem("Ticker","81_717_5P_Ticker")
	
	-- Номер маршрута .5П
	self:LoadSystem("RouteNumberSys","81-717_5P_RouteNumber")
	
	-- ЕЦРС .5П
	self:LoadSystem("ECRS","81_717_5P_ECRS")
	
	-- АСПС .5П от Вэна
	self:LoadSystem("ASPS","81_717_5P_ASPS")
	
	-- КТО-С .5П от Вэна
	self:LoadSystem("KTS_O","81_717_5P_KTS_O")

    -- Токоприёмник
    self:LoadSystem("TR","TR_3B")
    -- Электротяговые двигатели
    self:LoadSystem("Engines","DK_117DM")

    -- Резисторы для реостата/пусковых сопротивлений
    self:LoadSystem("KF_47A","KF_47A1")
    -- Резисторы для ослабления возбуждения
    self:LoadSystem("KF_50A")
    -- Ящик с предохранителями
    self:LoadSystem("YAP_57")

    -- Резисторы для цепей управления
    --self:LoadSystem("YAS_44V")
    self:LoadSystem("Reverser","PR_722D")
    -- Реостатный контроллер для управления пусковыми сопротивления
    self:LoadSystem("RheostatController","EKG_17B")
    -- Групповой переключатель положений
    self:LoadSystem("PositionSwitch","PKG_761")
    -- Кулачковый контроллер
    self:LoadSystem("KV","KV_70")
    -- Контроллер резервного управления
    self:LoadSystem("KRU")


    -- Ящики с реле и контакторами
    self:LoadSystem("BV","BV_630")
    self:LoadSystem("LK_755A")
    self:LoadSystem("YAR_13B","YAR_13B_5P")
    self:LoadSystem("YAR_27")
    self:LoadSystem("YAK_36")
    self:LoadSystem("YAK_37E")
    self:LoadSystem("YAS_44V")
    self:LoadSystem("YARD_2")
    self:LoadSystem("PR_14X_Panels")

    -- Пневмосистема 81-710
    self:LoadSystem("Pneumatic","81_717_5P_Pneumatic")
    -- Панель управления 81-710
    self:LoadSystem("Panel","81_717_5P_Panel")
    -- Everything else
    self:LoadSystem("Battery")
    self:LoadSystem("PowerSupply","BPSN")
    --self:LoadSystem("DURA")
    self:LoadSystem("ALS_ARS","81_717_BARS")

    self:LoadSystem("PUAV")
    if Metrostroi.MapHasFullSupport and Metrostroi.MapHasFullSupport("sbpp") then
        self:LoadSystem("SBPP")
        if SERVER then self:SetNW2Bool("SBPP",true) end
    else
        self:LoadSystem("IPAV")
    end
    self:LoadSystem("PAM")

    --self:LoadSystem("Radiostation","Motorola")
    self:LoadSystem("IGLA_PCBK")


    self:LoadSystem("RouteNumber","81_71_RouteNumber",3)

    self:LoadSystem("Horn")
    self:LoadSystem("Announcer","81_71_Announcer", "AnnouncementsUPO")
    self:LoadSystem("UPO","81_71_UPO")
    self:LoadSystem("ASNP_VV","81_71_ASNP_VV")
end

---------------------------------------------------
-- Defined train information
-- Types of wagon(for wagon limit system):
-- 0 = Head or intherim
-- 1 = Only head
-- 2 = Only intherim
---------------------------------------------------
ENT.SubwayTrain = {
    Type = "81",
    Name = "81-717.5П",
    Manufacturer = "LVZ",
    WagType = 1,
    ALS = {
        HaveAutostop = true,
        TwoToSix = false,
        RSAs325Hz = false,
        Aproove0As325Hz = true,
    },
    IPAV = {
        Systems = {"PUAV"}
    },
    EKKType = 717,
    NoFrontEKK=true,
}	
ENT.NumberRanges = {{1109,1156}}  --ПБЛ 1109-1112, 1116-1119, 1131-1156; МПЛ 1120-1130.
--ПБЛ 1109,1110,1111,1112,1116,1117,1118,1119,1131,1132,1133,1134,1135,1136,1137,1138,1139,1140,1141,1142,1143,1144,1145,1146,1147,1148,1149,1150,1151,1152,1153,1154,1155,1156,

ENT.Spawner = {
    model = {
        "models/metrostroi_train/81-5402/81-7175p_body.mdl",
        "models/metrostroi_train/81-5402/dev4you_interior_5p.mdl",
        "models/metrostroi_train/81-5402/dev4you_interior_5p_handrails.mdl",
        "models/metrostroi_train/81-5402/81-5402_cab.mdl",
        "models/metrostroi_train/81-5402/dev4you_pult5p.mdl",
        "models/metrostroi_train/81-5402/dev4you_pult5p.mdl",
        --"models/metrostroi_train/81-717/pult/puav_new.mdl",
        --"models/metrostroi_train/81-717/pult/ars_spb_yellow.mdl",
    },
    interim = "gmod_subway_81-7145p",
    func = function(train,i,max,LastRot)
        local typ = train:GetNW2Int("Type")
        if 1==i or i==max then
            train.NumberRangesID = typ==1 and math.ceil(math.random()+0.5) or typ+1
        else
            train.NumberRangesID = typ
        end
    end,
    wagfunc = function(ent,i,num)
    end,
    Metrostroi.Skins.GetTable("Texture","Spawner.Texture",false,"train"),
    Metrostroi.Skins.GetTable("PassTexture","Spawner.PassTexture",false,"pass"),
    --Metrostroi.Skins.GetTable("CabTexture","Spawner.CabTexture",false,"cab"),
    --{"Announcer","Spawner.717.Announcer","List",Announcer},
    --{"KVR","Spawner.717.KVR","Boolean"},
    --{"Blok","Spawner.717L.AutodrivePanel","List",{"Spawner.717L.AutodrivePanel.1"}},--,"Spawner.717L.AutodrivePanel.2","Spawner.717L.AutodrivePanel.3","Spawner.717L.AutodrivePanel.4"}},
    {"Type","Spawner.717.Type","List",{"Состав с МПЛ","Состав с ПБЛ"}},
    {"Scheme","Spawner.717.Schemes","List",function()
        local Schemes = {}
        for k,v in pairs(Metrostroi.Skins["717_new_schemes"] or {}) do Schemes[k] = v.name or k end
        return Schemes
    end},
    --{"Crane","Spawner.717.CraneType","List",{"334","013"}},
    --{"MaskType","Spawner.717.MaskType","List",{"2-2","2-2s","2-2-2"}},
    --{"BPSNType","Spawner.717.BPSNType","List",{"Spawner.717.BPSNType.1","Spawner.717.BPSNType.2","Spawner.717.BPSNType.3","Spawner.717.BPSNType.4","Spawner.717.BPSNType.5","Spawner.717.BPSNType.6","Spawner.717.BPSNType.7","Spawner.717.BPSNType.8","Spawner.717.BPSNType.9","Spawner.717.BPSNType.10","Spawner.717.BPSNType.11","Spawner.717.BPSNType.12","Spawner.717.BPSNType.13"}},
    {"SpawnMode","Spawner.717.SpawnMode","List",{"Запущен полностью","Тупик","Ночной отстой","Депо"}, nil,function(ent,val,rot,i,wagnum,rclk)
        if rclk then return end
        if ent._SpawnerStarted~=val then
            ent.VB:TriggerInput("Set",val<=2 and 1 or 0)
            ent.ParkingBrake:TriggerInput("Set",val==3 and 1 or 0)
            if ent.AR63  then
                local first = i==1 or _LastSpawner~=CurTime()
				--ent.BPSNon:TriggerInput("Set",val==1 and 1 or 0) --multi
                ent.A53:TriggerInput("Set",val<=3 and 1 or 0)
                ent.AR63:TriggerInput("Set",val<=2 and 1 or 0)
                ent.R_UNch:TriggerInput("Set",val==1 and 1 or 0)
                ent.R_UPO:TriggerInput("Set",val<=2 and 1 or 0)
                if ent.Plombs.RC1 and val<=2 then
                    ent.VPAOn:TriggerInput("Set",1)
                    timer.Simple(1,function()
                        if not IsValid(ent) or val > 2 then return end
                            ent.VPAOn:TriggerInput("Set",0)
                    end)
                else
                    ent.VPAOn:TriggerInput("Set",0)
                end
                ent.VAU:TriggerInput("Set",(ent.Plombs.RC2 and val<=2) and 1 or 0)
                ent.L_4:TriggerInput("Set",val==1 and 1 or 0)
                --ent.VMK:TriggerInput("Set",(val==1 and first) and 1 or 0)
                ent.ARS:TriggerInput("Set",(ent.Plombs.RC1 and val==1 and first) and 1 or 0)
                ent.ALS:TriggerInput("Set",(ent.Plombs.RC1 and val==1) and 1 or 0)
                ent.L_1:TriggerInput("Set",val==1 and 1 or 0)
                ent.L_3:TriggerInput("Set",val==1 and 1 or 0)
                ent.L_4:TriggerInput("Set",val==1 and 1 or 0)
                ent.EPK:TriggerInput("Set",(ent.Plombs.RC1 and val==1) and 1 or 0)
				ent.ECRS:TriggerInput("Enable", (val == 1 or val == 2) and 1 or 0)
                _LastSpawner=CurTime()
                ent.CabinDoor = val==4 and first
                ent.PassengerDoor = val==4
                ent.RearDoor = val==4
                timer.Simple(1,function()
					if not IsValid(ent) then return end
					if val > 2 then return end
					ent.ASPS.State = -1
					for k,v in pairs(ent.ASPS.ASPSLamps) do
						ent.ASPS.ASPSLamps[k] = false
					end
					ent.ASPS:Trigger("ASPS_View", (val == 1 or val == 2) and 1 or 0)
				end)
            else
                ent.FrontDoor = val==4
                ent.RearDoor = val==4
            end
            if val == 1 then ent.BV:TriggerInput("Enable",1) end
            ent.GV:TriggerInput("Set",val<4 and 1 or 0)
            ent._SpawnerStarted = val
        end
        ent.Pneumatic.TrainLinePressure = val==3 and math.random()*4 or val==2 and 4.5+math.random()*3 or 7.6+math.random()*0.6
        if val==4 then ent.Pneumatic.BrakeLinePressure = 5.2 end
    end},
	{"spb_reklama717","Реклама в салоне","Boolean"},
}