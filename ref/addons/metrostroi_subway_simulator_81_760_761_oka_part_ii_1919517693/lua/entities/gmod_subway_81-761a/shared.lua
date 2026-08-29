ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.PrintName		= "81-761A MVM"
ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category		= "Metrostroi (trains)"
--ENT.SkinsType = "81-760A"
ENT.Model = "models/metrostroi_train/81-760/81_761a_body.mdl"

ENT.Spawnable       = true
ENT.AdminSpawnable  = false

function ENT:PassengerCapacity()
	return 300
end

function ENT:GetStandingArea()
	return Vector(-450,-30,-53),Vector(380,30,-53)
end
local function GetDoorPosition(i,k)
	return Vector(377.0 - 36.0 + 1*(k) - 230*i,-64*(1-2*k),-10)
end
function ENT:InitializeSounds()
	self.BaseClass.InitializeSounds(self)
	--[[
	self.SoundNames["tisu"]   = {"subway_trains/720/tisu.wav",loop = true}
	self.SoundPositions["tisu"] = {800,1e9,Vector(0,0,-40),0.3} --FIXME: Pos
	self.SoundNames["tisu2"]   = {"subway_trains/720/tisu2.wav",loop = true}
	self.SoundPositions["tisu2"] = {800,1e9,Vector(0,0,-40),0.5} --FIXME: Pos
	self.SoundNames["tisu3"]   = {"subway_trains/720/tisu3.wav",loop = true}
	self.SoundPositions["tisu3"] = {800,1e9,Vector(0,0,-40),0.5} --FIXME: Pos
	self.SoundNames["bbe"]   = {"subway_trains/720/bbe.wav",loop = true}
	self.SoundPositions["bbe"] = {800,1e9,Vector(0,0,-40),0.02} --FIXME: Pos
	]]
	--[[
	for i=1,2 do
		self.SoundNames["test_async1"..i]   = {"subway_trains/722/engines/inverter_start2.wav",loop = true}
		self.SoundPositions["test_async1"..i] = {600,1e9,Vector(0,-40+i*80,-40),0.2} --FIXME: Pos
		self.SoundNames["test_asyncp1"..i]   = {"subway_trains/722/engines/inverter_start2.wav",loop = true}
		self.SoundPositions["test_asyncp1"..i] = {600,1e9,Vector(0,-40+i*80,-40),0.2} --FIXME: Pos
		self.SoundNames["test_asyncp2"..i]   = {"subway_trains/722/engines/inverter_start2.wav",loop = true}
		self.SoundPositions["test_asyncp2"..i] = {600,1e9,Vector(0,-40+i*80,-40),0.2} --FIXME: Pos
	end]]
	self.SoundNames["async1"]   = {"subway_trains/760/engines/inverter.wav", loop = true}
    self.SoundPositions["async1"] = {400,1e9,Vector(0,0,0),0.5}
  
	for i=1,8 do
		self.SoundNames["vent"..i] = {loop=true,"subway_trains/720/vent_mix.wav"}
		self.SoundPositions["vent"..i] = {100,1e9,Vector(-413+(i-1)*117,0,30),0.5}
	end

	self.SoundNames["compressor"] = {loop=true,"subway_trains/760/new/compressor_loop.wav"}--{loop=true,"subway_trains/722/compressol_loop.wav"}
	self.SoundPositions["compressor"] = {800,1e9,Vector(-118,-40,-66)} --FIXME: Pos
	self.SoundNames["compressor_pn1"] = "subway_trains/760/new/compressor_dhm.wav"
	self.SoundPositions["compressor_pn1"] = {800,1e9,Vector(-118,-40,-66)} --FIXME: Pos
	self.SoundNames["compressor_pn2"] = "subway_trains/760/new/compressor_dhm_2.wav"
	self.SoundPositions["compressor_pn2"] = {800,1e9,Vector(-118,-40,-66)} --FIXME: Pos	
	
    self.SoundNames["release"] = {loop=true,"subway_trains/760/new/pneumo_release2.wav"}
    self.SoundPositions["release"] = {320,1e9,Vector(-183,0,-70),0.1} --FIXME: Pos
    self.SoundNames["parking_brake"] = {loop=true,"subway_trains/common/pneumatic/autostop_loop.wav"}
    self.SoundPositions["parking_brake"] = {400,1e9,Vector(-183,0,-70),0.95}

    self.SoundNames["front_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["front_isolation"] = {300,1e9,Vector(500, 0,-63),1}
    self.SoundNames["rear_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["rear_isolation"] = {300,1e9,Vector(-469, 0,-63),1}	
	
	self.SoundNames["gv_f"] = {"subway_trains/717/kv70/reverser_0-b_1.mp3","subway_trains/717/kv70/reverser_0-b_2.mp3"}
	self.SoundNames["gv_b"] = {"subway_trains/717/kv70/reverser_b-0_1.mp3","subway_trains/717/kv70/reverser_b-0_2.mp3"}
	self.SoundPositions["gv_f"] = {80,1e9,Vector(126.4,50,-60-23.5),0.8}
	self.SoundPositions["gv_b"] = {80,1e9,Vector(126.4,50,-60-23.5),0.8}

	self.SoundNames["door_cab_open"] = {"subway_trains/720/door/door_torec_open.mp3","subway_trains/720/door/door_torec_open2.mp3"}
	self.SoundNames["door_cab_close"] = {"subway_trains/720/door/door_torec_close.mp3","subway_trains/720/door/door_torec_close2.mp3"}
	self.SoundNames["door_cab_roll"] = {"subway_trains/720/door/cabdoor_roll1.mp3","subway_trains/720/door/cabdoor_roll2.mp3","subway_trains/720/door/cabdoor_roll3.mp3","subway_trains/720/door/cabdoor_roll4.mp3"}
	
    self.SoundNames["rolling_10"] = {loop=true,"subway_trains/722/rolling_10.wav"}
    self.SoundNames["rolling_45"] = {loop=true,"subway_trains/722/rolling_45.wav"}
    self.SoundNames["rolling_60"] = {loop=true,"subway_trains/722/rolling_60.wav"}
    self.SoundNames["rolling_70"] = {loop=true,"subway_trains/722/rolling_70.wav"}
    self.SoundPositions["rolling_10"] = {485,1e9,Vector(0,0,0),0.20}
    self.SoundPositions["rolling_45"] = {485,1e9,Vector(0,0,0),0.50}
    self.SoundPositions["rolling_60"] = {485,1e9,Vector(0,0,0),0.55}
    self.SoundPositions["rolling_70"] = {485,1e9,Vector(0,0,0),0.60}
    self.SoundNames["rolling_low"] = {loop=true,"subway_trains/717/rolling/rolling_outside_low.wav"}
    self.SoundNames["rolling_medium1"] = {loop=true,"subway_trains/717/rolling/rolling_outside_medium1.wav"}
    self.SoundNames["rolling_medium2"] = {loop=true,"subway_trains/717/rolling/rolling_outside_medium2.wav"}
    self.SoundNames["rolling_high2"] = {loop=true,"subway_trains/717/rolling/rolling_outside_high2.wav"}
    self.SoundPositions["rolling_low"] = {480,1e12,Vector(0,0,0),0.6*0.4}
    self.SoundPositions["rolling_medium1"] = {480,1e12,Vector(0,0,0),0.90*0.4}
    self.SoundPositions["rolling_medium2"] = {480,1e12,Vector(0,0,0),0.90*0.4}
    self.SoundPositions["rolling_high2"] = {480,1e12,Vector(0,0,0),1.00*0.4}
	
	local function GetDoorPosition(i,k,j)
		if j == 0
		then return Vector(381 - 36.0 + 1*(k) -0.85*(k == 1 and 1 or 0) - 230*i,-66*(1-2*k),-1)
		else return Vector(381 - 36.0 + 1*(k) -0.85*(k == 1 and 1 or 0) - 230*i,-66*(1-2*k),-1)
		end
	end

    for i=0,3 do
        for k=0,1 do
            self.SoundNames["door"..i.."x"..k.."r0"] = {loop=true,"subway_trains/760/doors/door_loop4.mp3"}
            self.SoundPositions["door"..i.."x"..k.."r0"] = {100,1e9,GetDoorPosition(i,k),1}
            self.SoundNames["door"..i.."x"..k.."r1"] = {loop=true,"subway_trains/760/doors/door_loop3.wav"}
            self.SoundPositions["door"..i.."x"..k.."r1"] = {100,1e9,GetDoorPosition(i,k),1}			
            self.SoundNames["door"..i.."x"..k.."o"] = {"subway_trains/760/doors/door_open_end4.mp3","subway_trains/760/doors/door_open_end3.mp3","subway_trains/760/doors/door_open_end2.wav"}
            self.SoundPositions["door"..i.."x"..k.."o"] = {150,1e9,GetDoorPosition(i,k),0.55}
            self.SoundNames["door"..i.."x"..k.."op0"] = {"subway_trains/760/doors/door_open_start2.mp3"}
            self.SoundPositions["door"..i.."x"..k.."op0"] = {150,1e9,GetDoorPosition(i,k),0.3}
            self.SoundNames["door"..i.."x"..k.."op1"] = {"subway_trains/760/doors/door_open_start1.wav"}
            self.SoundPositions["door"..i.."x"..k.."op1"] = {150,1e9,GetDoorPosition(i,k),0.3}			
            self.SoundNames["door"..i.."x"..k.."c"] = {"subway_trains/760/doors/door_close1.mp3","subway_trains/760/doors/door_close2.mp3"}--,"subway_trains/760/door/door_close2.mp3"}
            self.SoundPositions["door"..i.."x"..k.."c"] = {250,1e9,GetDoorPosition(i,k),0.55}
        end
    end
	
	self.SoundNames["sf_on"] = "subway_trains/722/switches/sf_on.mp3"
	self.SoundNames["sf_off"] = "subway_trains/722/switches/sf_off.mp3"	

	self.SoundNames["door_alarm"] = {"subway_trains/722/door_alarm.mp3"}
	self.SoundPositions["door_alarm"] = {800,1e9,Vector(0,0,0),0.5}	

	self.SoundNames["batt_on"] = "subway_trains/720/batt_on.mp3"
	self.SoundPositions["batt_on"] = {400,1e9,Vector(126.4,50,-60-23.5),0.3}

    self.SoundNames["disconnectvalve"] = "subway_trains/common/switches/pneumo_disconnect_switch.mp3"
    self.SoundNames["disconnect_valve"] = "subway_trains/common/switches/pneumo_disconnect_switch.mp3"
	
	self.SoundNames["button_press"] = {"subway_trains/720/switches/butt_press.mp3","subway_trains/720/switches/butt_press2.mp3","subway_trains/720/switches/butt_press3.mp3"}
	self.SoundNames["button_release"] = {"subway_trains/720/switches/butt_release.mp3","subway_trains/720/switches/butt_release2.mp3","subway_trains/720/switches/butt_release3.mp3"}

	self.SoundNames["button_square_press"] = "subway_trains/720/switches/butts_press.mp3"
	self.SoundNames["button_square_release"] = "subway_trains/720/switches/butts_release.mp3"

	self.SoundNames["button_square_on"] = {"subway_trains/720/switches/butts_on.mp3","subway_trains/720/switches/butts_on2.mp3"}
	self.SoundNames["button_square_off"] = {"subway_trains/720/switches/butts_off.mp3","subway_trains/720/switches/butts_off2.mp3"}	
	
    self.SoundNames["pak_on"] = "subway_trains/717/switches/rc_on.mp3"
    self.SoundNames["pak_off"] = "subway_trains/717/switches/rc_off.mp3"	

	
    for i = 1,10 do
        local id1 = Format("b1tunnel_%d",i)
        local id2 = Format("b2tunnel_%d",i)
        self.SoundPositions[id1.."a"] = {700*0.75,1e9,Vector( 317-5,0,-84),1*0.5}
        self.SoundPositions[id1.."b"] = self.SoundPositions[id1.."a"]
        self.SoundPositions[id2.."a"] = {700*0.75,1e9,Vector(-317+0,0,-84),1*0.5}
        self.SoundPositions[id2.."b"] = self.SoundPositions[id2.."a"]
    end
    for i = 1,14 do
        local id1 = Format("b1street_%d",i)
        local id2 = Format("b2street_%d",i)
        self.SoundPositions[id1.."a"] = {700,1e9,Vector( 317-5,0,-84),1.5*0.5}
        self.SoundPositions[id1.."b"] = self.SoundPositions[id1.."a"]
        self.SoundPositions[id2.."a"] = {700,1e9,Vector(-317+0,0,-84),1.5*0.5}
        self.SoundPositions[id2.."b"] = self.SoundPositions[id2.."a"]
    end
    for k,v in ipairs(self.AnnouncerPositions) do
        self.SoundNames["announcer_noise1_"..k] = {loop=true,"subway_announcers/upo/noiseS1.wav"}
        self.SoundPositions["announcer_noise1_"..k] = {v[2] or 300,1e9,v[1],v[3]*0.2}
        self.SoundNames["announcer_noise2_"..k] = {loop=true,"subway_announcers/upo/noiseS2.wav"}
        self.SoundPositions["announcer_noise2_"..k] = {v[2] or 300,1e9,v[1],v[3]*0.2}
        self.SoundNames["announcer_noise3_"..k] = {loop=true,"subway_announcers/upo/noiseS3.wav"}
        self.SoundPositions["announcer_noise3_"..k] = {v[2] or 300,1e9,v[1],v[3]*0.2}
        self.SoundNames["announcer_noiseW"..k] = {loop=true,"subway_announcers/upo/noiseW.wav"}
        self.SoundPositions["announcer_noiseW"..k] = {v[2] or 300,1e9,v[1],v[3]*0.2}
    end		
	
    self.SoundNames["bv_off"] = {"subway_trains/760/new/bv_off.wav"}
    self.SoundPositions["bv_off"] = {800,1e9,Vector(0,0,-45),0.5}		
end

function ENT:InitializeSystems()
	self:LoadSystem("TR","TR_3B")
	self:LoadSystem("Electric","81_760A_Electric")
	self:LoadSystem("AsyncInverter","81_760_AsyncInverter")

	self:LoadSystem("BUV","81_761A_BUV")	

	self:LoadSystem("Pneumatic","81_760_Pneumatic")

	self:LoadSystem("Panel","81_761A_Panel")

	self:LoadSystem("CIS","81_760_CIS")
	self:LoadSystem("BackTicker","81_760_Ticker")
	self:LoadSystem("BNT","81_760_BNT")--Монитор блока наддверного табло
	self:LoadSystem("IGLA_PCBK","81_760_IGLA_PCBK")
	
	--self:LoadSystem("MEZHWAG")
end

ENT.AnnouncerPositions = {}
for i=1,4 do
    table.insert(ENT.AnnouncerPositions,{Vector(323-(i-1)*230 --[[+37.5]],47 ,44),100,0.1})
    table.insert(ENT.AnnouncerPositions,{Vector(323-(i-1)*230,-47,44),100,0.1})
end
---------------------------------------------------
-- Defined train information
-- Types of wagon(for wagon limit system):
-- 0 = Head or intherim
-- 1 = Only head
-- 2 = Only intherim
---------------------------------------------------
ENT.SubwayTrain = {
	Type = "81-760",
	Name = "81-761A",
	WagType = 2,
	Manufacturer = "MVM",
    EKKType = 763,	
}
ENT.NumberRanges = {{30001,30993}}
