return [[
#81-760

[en]

Entities.gmod_subway_81-760.Name = 81-760 (Oka head)
Entities.gmod_subway_81-761.Name = 81-761 (Oka intermediate)
Entities.gmod_subway_81-760a.Name = 81-760A (Oka head)
Entities.gmod_subway_81-761a.Name = 81-761A (Oka intermediate motor)
Entities.gmod_subway_81-763a.Name = 81-763A (Oka intermediate trailer)

Spawner.760.Version = Version
Spawner.760.Version.STL = STL
Spawner.760.Version.BKL = BKL
Spawner.760.CISConfig = CIS map config

#Cameras:
Train.760.CameraPPZ  = PPZ Autobreakers(Train)
Train.760.CameraASNPIGLA = ASNP and IGLA
Train.760.CameraCams = Video
Train.760.CameraBMCIS = BMCIS-01
Train.760.CameraVityaz = MFDU (Vityaz-M)
Train.760.CameraKRMH = K29 and RVTB
Train.760.CameraPVZ = PVZ Autobreakers(Wagon)

#Autobreakers
Common.760.SF1                          = SF1: Train power line
Common.760.SF2                          = SF2: Main control
Common.760.SF3                          = SF3: Emergency control
Common.760.SF4                          = SF4: BKPU-1
Common.760.SF5                          = SF5: BKPU-2
Common.760.SF6                          = SF6: UPI,RPDP,Monitor
Common.760.SF7                          = SF7: brake lever main power
Common.760.SF8                          = SF8: brake lever emergency power
Common.760.SF9                          = SF9: Orientation
Common.760.SF11                         = SF11: Doors opening
Common.760.SF12                         = SF12: CIS-1
Common.760.SF13                         = SF13: CIS-2
Common.760.SF14                         = SF14: Air conditioner (pass)

Common.760.SF15                         = SF15: Cabin lighting
Common.760.SF16                         = SF16: 1st headlights group
Common.760.SF17                         = SF17: 2nd headlights group
Common.760.SF18                         = SF18: ASNP
Common.760.SF19                         = SF19: Video 
Common.760.SF20                         = SF20: Fire alarm
Common.760.SF21                         = SF21: Radiostation
Common.760.SF23                         = SF23: Flange lubrication,windshield wiper,windshield washer
Common.760.SF24                         = SF24: Air conditioner control
Common.760.SF26                         = SF26: Glass heating
Common.760.SF28                    		= SF28: Night Deadlock

Common.760A.SF27                        = SF27: Train power line
Common.760A.SF29                        = SF29: Emergency power intermediate trailer
Common.760A.SF34                        = SF34: Emergency power
Common.760A.SF35                        = SF35: Train power line
Common.760A.PowerOn                     = Train power line on
Common.760A.PowerOff                    = Train power line off
Common.760A.PowerReserve                = Emergency power radiostation and cabin lighting
Common.760A.SA15           			    = SA15: Emergency power intermediate trailer

Common.760.SF31                         = SF31: Control circuits power
Common.760.SF32                         = SF32: Train power wire(Wagon)
Common.760.SF33                         = SF33: Train power wire(Train)
Common.760.SF34                         = SF34: Compressed air dryer
Common.760.SF36                         = SF36: Fire alarm
Common.760.SF37                         = SF37: Left side CIS
Common.760.SF38                         = SF38: Right side CIS
Common.760.SF39                         = SF39: Doors closing
Common.760.SF40                         = SF40: Left doors opening
Common.760.SF41                         = SF41: Right doors opening
Common.760.SF42                         = SF42: End doors
Common.760.SF43                         = SF43: Interior lighting power
Common.760.SF44                         = SF44: Emergency interior lighting
Common.760.SF45                         = SF45: PSN (power supply)
Common.760.SF46                         = SF46: Wagon control unit
Common.760.SF47                         = SF47: ADUDV
Common.760.SF48                         = SF48: ADUVO
Common.760.SF49                         = SF49: BODV
Common.760.SF50                         = SF50: Main control
Common.760.SF51                         = SF51: Emergency control
Common.760.SF52                         = SF52: Inverter
Common.760.SF53                         = SF53: Current collectors
Common.760.SF54                         = SF54: Video
Common.760.SF55                         = SF55: BUFT (friction brake control unit)
Common.760.SF56                         = SF56: Air conditioner power
Common.760.SF57                         = SF57: Air conditioner
Common.760.SF58                         = SF58: Train power line

Common.760.SA17             = SA17: Release 2nd current collectors group
Common.760.SA16             = SA16: Release 1st current collectors group
Common.760.SA15             = SA15: End doors
Common.760.SA14             = SA14: ALS decoder switch (up - 2/6)
Common.760.SA13             = SA13: Headlights emergency
Common.760.SA12             = SA12: Unlock cabin doors
Common.760.SA10             = SA10: Emergency power radiostation
Common.760.SA9              = SA9: Air conditioner on
Common.760.SA8              = SA8: Wagon equipment lighting
Common.760.SA7              = SA7: Cabin lighting brightness
Common.760.SA6              = SA6: Cabin lighting
Common.760.SA5              = SA5: Pass light
Common.760.SA4              = SA4: Emergency PSN
Common.760.SA3              = SA3: PSN(Power supply)
Common.760.SA2              = SA2: Compressor
Common.760.SA1              = SA1: Parking brake

Common.760.HVoltage         = High voltage

Common.760.SD               = SD
Common.760.BTB              = BTB
Common.760.Pr               = Brake shoes heating
Common.760.OtklR            = Off recuperation
Common.760.R_ToBack         = Set to start
Common.760.R_ChangeRoute    = Change Path
Common.760.R_Micro          = Microphone
Common.760.GlassHeating     = Glass heating
Common.760.CISRestart       = Restart BMCIS

Common.760.VityazF5         = Vityaz: Reset
Common.760.VityazF6         = Vityaz: Up
Common.760.VityazF7         = Vityaz: Down
Common.760.VityazF8         = Vityaz: Enter
Common.760.VityazF9         = Vityaz: Select

Common.760.Cover            = button cover
Common.760.Cabinet          = Cabinet
Common.760.Seat             = Seat
Common.760.Cap              = cap

Panel.760Optimization       = Hide all 760 trains except where you seat
Panel.760Optimization2      = Hide all 760 except your
Panel.760Name               = 760

#Spawner:

Entities.gmod_subway_81-760.Spawner.Texture.Name            = @[Common.Spawner.Texture]
Entities.gmod_subway_81-760.Spawner.PassTexture.Name        = @[Common.Spawner.PassTexture]
Entities.gmod_subway_81-760.Spawner.CabTexture.Name         = @[Common.Spawner.CabTexture]
Entities.gmod_subway_81-760.Spawner.Announcer.Name          = @[Common.Spawner.Announcer]
Entities.gmod_subway_81-760.Spawner.Scheme.Name             = @[Common.Spawner.Scheme]
Entities.gmod_subway_81-760.Spawner.PassSchemesInvert.Name  = @[Common.Spawner.SchemeInvert]
Entities.gmod_subway_81-760.Spawner.SpawnMode.Name          = @[Common.Spawner.SpawnMode]
Entities.gmod_subway_81-760.Spawner.SpawnMode.1             = @[Common.Spawner.SpawnMode.Full]
Entities.gmod_subway_81-760.Spawner.SpawnMode.2             = @[Common.Spawner.SpawnMode.Deadlock]
Entities.gmod_subway_81-760.Spawner.SpawnMode.3             = @[Common.Spawner.SpawnMode.NightDeadlock]
Entities.gmod_subway_81-760.Spawner.SpawnMode.4             = @[Common.Spawner.SpawnMode.Depot]

Entities.gmod_subway_81-760a.Spawner.Texture.Name            = @[Common.Spawner.Texture]
Entities.gmod_subway_81-760a.Spawner.PassTexture.Name        = @[Common.Spawner.PassTexture]
Entities.gmod_subway_81-760a.Spawner.CabTexture.Name         = @[Common.Spawner.CabTexture]
Entities.gmod_subway_81-760a.Spawner.Announcer.Name          = @[Common.Spawner.Announcer]
Entities.gmod_subway_81-760a.Spawner.Scheme.Name             = @[Common.Spawner.Scheme]
Entities.gmod_subway_81-760a.Spawner.PassSchemesInvert.Name  = @[Common.Spawner.SchemeInvert]
Entities.gmod_subway_81-760a.Spawner.SpawnMode.Name          = @[Common.Spawner.SpawnMode]
Entities.gmod_subway_81-760a.Spawner.SpawnMode.1             = @[Common.Spawner.SpawnMode.Full]
Entities.gmod_subway_81-760a.Spawner.SpawnMode.2             = @[Common.Spawner.SpawnMode.Deadlock]
Entities.gmod_subway_81-760a.Spawner.SpawnMode.3             = @[Common.Spawner.SpawnMode.NightDeadlock]
Entities.gmod_subway_81-760a.Spawner.SpawnMode.4             = @[Common.Spawner.SpawnMode.Depot]
Entities.gmod_subway_81-760a.Spawner.CISConfig.Name             = @[Spawner.760.CISConfig]

Entities.gmod_subway_81-760.Spawner.Version.Name             = @[Spawner.760.Version]
Entities.gmod_subway_81-760.Spawner.Version.1             = @[Spawner.760.Version.STL]
Entities.gmod_subway_81-760.Spawner.Version.2             = @[Spawner.760.Version.BKL]
Entities.gmod_subway_81-760.Spawner.CISConfig.Name             = @[Spawner.760.CISConfig]

Entities.gmod_subway_81-760.Buttons.BackPPZ.SF1Toggle       = @[Common.760.SF1]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF2Toggle       = @[Common.760.SF2]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF3Toggle       = @[Common.760.SF3]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF4Toggle       = @[Common.760.SF4]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF5Toggle       = @[Common.760.SF5]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF6Toggle       = @[Common.760.SF6]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF7Toggle       = @[Common.760.SF7]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF8Toggle       = @[Common.760.SF8]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF9Toggle       = @[Common.760.SF9]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF11Toggle      = @[Common.760.SF11]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF12Toggle      = @[Common.760.SF12]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF13Toggle      = @[Common.760.SF13]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF14Toggle      = @[Common.760.SF14]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF15Toggle      = @[Common.760.SF15]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF16Toggle      = @[Common.760.SF16]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF17Toggle      = @[Common.760.SF17]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF18Toggle      = @[Common.760.SF18]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF19Toggle      = @[Common.760.SF19]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF20Toggle      = @[Common.760.SF20]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF21Toggle      = @[Common.760.SF21]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF22Toggle      = @[Common.ALL.Unsused1]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF23Toggle      = @[Common.760.SF23]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF24Toggle      = @[Common.760.SF24]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF26Toggle      = @[Common.760.SF26]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF27Toggle      = @[Common.ALL.Unsused1]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SF28Toggle      = @[Common.760.SF28]

Entities.gmod_subway_81-760.Buttons.PVZ.SF31Toggle          = @[Common.760.SF31]
Entities.gmod_subway_81-760.Buttons.PVZ.SF32Toggle          = @[Common.760.SF32]
Entities.gmod_subway_81-760.Buttons.PVZ.SF33Toggle          = @[Common.760.SF33]
Entities.gmod_subway_81-760.Buttons.PVZ.SF34Toggle          = @[Common.760.SF34]
Entities.gmod_subway_81-760.Buttons.PVZ.SF36Toggle          = @[Common.760.SF36]
Entities.gmod_subway_81-760.Buttons.PVZ.SF37Toggle          = @[Common.760.SF37]
Entities.gmod_subway_81-760.Buttons.PVZ.SF38Toggle          = @[Common.760.SF38]
Entities.gmod_subway_81-760.Buttons.PVZ.SF39Toggle          = @[Common.760.SF39]
Entities.gmod_subway_81-760.Buttons.PVZ.SF40Toggle          = @[Common.760.SF40]
Entities.gmod_subway_81-760.Buttons.PVZ.SF41Toggle          = @[Common.760.SF41]
Entities.gmod_subway_81-760.Buttons.PVZ.SF42Toggle          = @[Common.760.SF42]
Entities.gmod_subway_81-760.Buttons.PVZ.SF43Toggle          = @[Common.760.SF43]
Entities.gmod_subway_81-760.Buttons.PVZ.SF44Toggle          = @[Common.760.SF44]
Entities.gmod_subway_81-760.Buttons.PVZ.SF45Toggle          = @[Common.760.SF45]
Entities.gmod_subway_81-760.Buttons.PVZ.SF46Toggle          = @[Common.760.SF46]
Entities.gmod_subway_81-760.Buttons.PVZ.SF47Toggle          = @[Common.760.SF47]
Entities.gmod_subway_81-760.Buttons.PVZ.SF48Toggle          = @[Common.760.SF48]
Entities.gmod_subway_81-760.Buttons.PVZ.SF49Toggle          = @[Common.760.SF49]
Entities.gmod_subway_81-760.Buttons.PVZ.SF50Toggle          = @[Common.760.SF50]
Entities.gmod_subway_81-760.Buttons.PVZ.SF51Toggle          = @[Common.760.SF51]
Entities.gmod_subway_81-760.Buttons.PVZ.SF52Toggle          = @[Common.760.SF52]
Entities.gmod_subway_81-760.Buttons.PVZ.SF53Toggle          = @[Common.760.SF53]
Entities.gmod_subway_81-760.Buttons.PVZ.SF54Toggle          = @[Common.760.SF54]
Entities.gmod_subway_81-760.Buttons.PVZ.SF55Toggle          = @[Common.760.SF55]
Entities.gmod_subway_81-760.Buttons.PVZ.SF56Toggle          = @[Common.760.SF56]
Entities.gmod_subway_81-760.Buttons.PVZ.SF57Toggle          = @[Common.760.SF57]

Entities.gmod_subway_81-760.Buttons.BackPPZ.SA1kToggle         = @[Common.760.SA1] @[Common.760.Cover]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SA10kToggle        = @[Common.760.SA10] @[Common.760.Cover]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SA14kToggle        = @[Common.760.SA14] @[Common.760.Cover]

Entities.gmod_subway_81-760.Buttons.BackPPZ.SA1Toggle          = @[Common.760.SA1]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SA2Toggle          = @[Common.760.SA2]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SA3Toggle          = @[Common.760.SA3]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SA4Toggle          = @[Common.760.SA4]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SA5Toggle          = @[Common.760.SA5]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SA6Toggle          = @[Common.760.SA6]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SA7Toggle          = @[Common.760.SA7]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SA8Toggle          = @[Common.760.SA8]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SA9Toggle          = @[Common.760.SA9]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SA10Toggle         = @[Common.760.SA10]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SA11Toggle         = @[Common.ALL.Unsused1]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SA12Toggle         = @[Common.760.SA12]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SA13Toggle         = @[Common.760.SA13]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SA14Toggle         = @[Common.760.SA14]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SA15Toggle         = @[Common.760.SA15]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SA16Toggle         = @[Common.760.SA16]
Entities.gmod_subway_81-760.Buttons.BackPPZ.SA17Toggle         = @[Common.760.SA17]

Entities.gmod_subway_81-760.Buttons.BackPPZ.BARSBlock -        = @[Common.720.BARSBlock] @[Common.ALL.CCW]
Entities.gmod_subway_81-760.Buttons.BackPPZ.BARSBlock +        = @[Common.720.BARSBlock] @[Common.ALL.CW]
Entities.gmod_subway_81-760.Buttons.BackPPZ.BatteryToggle      = @[Common.ALL.VB]

Entities.gmod_subway_81-760.Buttons.RearDoor.RearDoor               = @[Common.ALL.RearDoor]
Entities.gmod_subway_81-760.Buttons.RearDoor1.RearDoor              = @[Common.ALL.RearDoor]
Entities.gmod_subway_81-760.Buttons.CabinDoorR.CabinDoorRight       = @[Common.ALL.CabinDoor]
Entities.gmod_subway_81-760.Buttons.CabinDoorR1.CabinDoorRight      = @[Common.ALL.CabinDoor]
Entities.gmod_subway_81-760.Buttons.CabinDoorL.CabinDoorLeft        = @[Common.ALL.CabinDoor]
Entities.gmod_subway_81-760.Buttons.CabinDoorL1.CabinDoorLeft       = @[Common.ALL.CabinDoor]
Entities.gmod_subway_81-760.Buttons.PassengerDoor.PassengerDoor     = @[Common.ALL.PassDoor]
Entities.gmod_subway_81-760.Buttons.PassengerDoor2.PassengerDoor    = @[Common.ALL.PassDoor]

Entities.gmod_subway_81-760.Buttons.FrontPneumatic.FrontBrakeLineIsolationToggle    = @[Common.ALL.FrontBrakeLineIsolationToggle]
Entities.gmod_subway_81-760.Buttons.FrontPneumatic.FrontTrainLineIsolationToggle    = @[Common.ALL.FrontTrainLineIsolationToggle]
Entities.gmod_subway_81-760.Buttons.RearPneumatic.RearTrainLineIsolationToggle      = @[Common.ALL.RearTrainLineIsolationToggle]
Entities.gmod_subway_81-760.Buttons.RearPneumatic.RearBrakeLineIsolationToggle      = @[Common.ALL.RearBrakeLineIsolationToggle]
Entities.gmod_subway_81-760.Buttons.GV.GVToggle                                     = @[Common.720.BRU]
Entities.gmod_subway_81-760.Buttons.BTO.K29Toggle                                   = K29 (@[Common.ALL.KRMH])
Entities.gmod_subway_81-760.Buttons.BTO.K9Toggle                                    = K9 (@[Common.ALL.RVTB])

Entities.gmod_subway_81-760.Buttons.ASNP.R_ASNPMenuSet      = @[Common.ASNP.ASNPMenu]
Entities.gmod_subway_81-760.Buttons.ASNP.R_ASNPUpSet        = @[Common.ASNP.ASNPUp]
Entities.gmod_subway_81-760.Buttons.ASNP.R_ASNPDownSet      = @[Common.ASNP.ASNPDown]
Entities.gmod_subway_81-760.Buttons.ASNP.R_ASNPOnToggle     = @[Common.ASNP.ASNPOn]

Entities.gmod_subway_81-760.Buttons.IGLAButtons.IGLA1Set          = @[Common.IGLA.Button1]
Entities.gmod_subway_81-760.Buttons.IGLAButtons.IGLA2Set          = @[Common.IGLA.Button2]
Entities.gmod_subway_81-760.Buttons.IGLAButtons.IGLA23            = @[Common.IGLA.Button23]
Entities.gmod_subway_81-760.Buttons.IGLAButtons.IGLA3Set          = @[Common.IGLA.Button3]
Entities.gmod_subway_81-760.Buttons.IGLAButtons.IGLA4Set          = @[Common.IGLA.Button4]

Entities.gmod_subway_81-760.Buttons.RV.EmerX1Set                = @[Common.720.EmerX1]
Entities.gmod_subway_81-760.Buttons.RV.EmerX2Set                = @[Common.720.EmerX2]
Entities.gmod_subway_81-760.Buttons.RV.EmerCloseDoorsSet        = @[Common.720.EmerCloseDoors]
Entities.gmod_subway_81-760.Buttons.RV.EmergencyDoorsToggle     = @[Common.720.EmergencyDoors]
Entities.gmod_subway_81-760.Buttons.RV.EmergencyCompressorSet   = @[Common.720.EmergencyCompressor]
Entities.gmod_subway_81-760.Buttons.RV.EmergencyControlsToggle  = @[Common.720.EmergencyControls]
Entities.gmod_subway_81-760.Buttons.RV.EmergencyControlsKToggle = @[Common.720.EmergencyControls] @[Common.760.Cover]

Entities.gmod_subway_81-760.Buttons.PUR.DoorSelectLToggle           = @[Common.720.DoorSelectL]
Entities.gmod_subway_81-760.Buttons.PUR.DoorSelectRToggle           = @[Common.720.DoorSelectR]
Entities.gmod_subway_81-760.Buttons.PUR.DoorLeftSet                 = @[Common.720.KDL]
Entities.gmod_subway_81-760.Buttons.PUR.R_MicroSet                  = @[Common.760.R_Micro]
Entities.gmod_subway_81-760.Buttons.PUR.HeadlightsSwitch+           = @[Common.ALL.VF] @[Common.ALL.Up]
Entities.gmod_subway_81-760.Buttons.PUR.HeadlightsSwitch-           = @[Common.ALL.VF] @[Common.ALL.Down]
Entities.gmod_subway_81-760.Buttons.PUR.DoorCloseToggle             = @[Common.720.DoorClose]
Entities.gmod_subway_81-760.Buttons.PUR.AttentionMessageSet         = @[Common.720.AttentionMessage]
Entities.gmod_subway_81-760.Buttons.PUR.AttentionSet                = @[Common.ARS.KB]
Entities.gmod_subway_81-760.Buttons.PUR.AttentionBrakeSet           = @[Common.ARS.KVT]
Entities.gmod_subway_81-760.Buttons.PUR.HornBSet                    = @[Common.ALL.Horn]
Entities.gmod_subway_81-760.Buttons.PUR.DoorRightSet                = @[Common.720.KDP]
Entities.gmod_subway_81-760.Buttons.PUR.R_Program1Set               = @[Common.720.R_Program1]
Entities.gmod_subway_81-760.Buttons.PUR.CISRestartSet               = @[Common.760.CISRestart]
Entities.gmod_subway_81-760.Buttons.PUR.CISRestartKToggle           = @[Common.760.CISRestart] @[Common.760.Cover]

Entities.gmod_subway_81-760.Buttons.PUR2.EmerBrakeAddSet             = @[Common.720.EBrakeAdd]
Entities.gmod_subway_81-760.Buttons.PUR2.EmerBrakeReleaseSet         = @[Common.720.EBrakeRelease]
Entities.gmod_subway_81-760.Buttons.PUR2.EmerBrakeToggle             = @[Common.720.EBrakeToggle]
Entities.gmod_subway_81-760.Buttons.PUR2.EmergencyBrakeToggle        = @[Common.720.EmergencyBrake]
Entities.gmod_subway_81-760.Buttons.PUR2.R_Program11Set              = @[Common.720.R_Program1]
Entities.gmod_subway_81-760.Buttons.PUR2.SDkToggle                   = @[Common.760.SD] @[Common.760.Cover]
Entities.gmod_subway_81-760.Buttons.PUR2.SDToggle                    = @[Common.760.SD]
Entities.gmod_subway_81-760.Buttons.PUR2.BTBkToggle                  = @[Common.760.BTB] @[Common.760.Cover]
Entities.gmod_subway_81-760.Buttons.PUR2.BTBToggle                   = @[Common.760.BTB]
Entities.gmod_subway_81-760.Buttons.PUR2.MicroToggle                 = @[Common.760.R_Micro]

Entities.gmod_subway_81-760.Buttons.PUU.DoorBlockToggle             = @[Common.720.DoorBlock]
Entities.gmod_subway_81-760.Buttons.PUU.!HVoltage                   = @[Common.760.HVoltage]
Entities.gmod_subway_81-760.Buttons.PUU.!DoorsClosed                = @[Common.ALL.LSD]
Entities.gmod_subway_81-760.Buttons.PUU.R_LineToggle                = @[Common.720.R_Line]
Entities.gmod_subway_81-760.Buttons.PUU.AccelRateSet                = @[Common.720.AccelRate]
Entities.gmod_subway_81-760.Buttons.PUU.EnableBVSet                 = @[Common.720.EnableBV]
Entities.gmod_subway_81-760.Buttons.PUU.DisableBVSet                = @[Common.720.DisableBV]
Entities.gmod_subway_81-760.Buttons.PUU.RingSet                     = @[Common.720.Ring]
Entities.gmod_subway_81-760.Buttons.PUU.KAHToggle                   = @[Common.720.KAH]
Entities.gmod_subway_81-760.Buttons.PUU.ALSToggle                   = @[Common.720.ALS]
Entities.gmod_subway_81-760.Buttons.PUU.ALSkToggle                  = @[Common.720.ALSK]
Entities.gmod_subway_81-760.Buttons.PUU.WiperToggle                 = @[Common.720.Wiper]
Entities.gmod_subway_81-760.Buttons.PUU.WasherSet                   = @[Common.722.GlassWasher]
Entities.gmod_subway_81-760.Buttons.PUU.GlassHeatingToggle          = @[Common.760.GlassHeating]
Entities.gmod_subway_81-760.Buttons.PUU.PrToggle                    = @[Common.760.Pr]
Entities.gmod_subway_81-760.Buttons.PUU.SCToggle                    = @[Common.ALL.Unsused1]
Entities.gmod_subway_81-760.Buttons.PUU.AutoDriveToggle             = @[Common.ALL.Unsused1]
Entities.gmod_subway_81-760.Buttons.PUU.OtklRToggle                 = @[Common.760.OtklR]
Entities.gmod_subway_81-760.Buttons.PUU.R_ToBackSet                 = @[Common.760.R_ToBack]
Entities.gmod_subway_81-760.Buttons.PUU.R_ChangeRouteToggle         = @[Common.760.R_ChangeRoute]

Entities.gmod_subway_81-760.Buttons.VityazButtons.Vityaz1Set        = @[Common.Vityaz.1]
Entities.gmod_subway_81-760.Buttons.VityazButtons.Vityaz2Set        = @[Common.Vityaz.2]
Entities.gmod_subway_81-760.Buttons.VityazButtons.Vityaz3Set        = @[Common.Vityaz.3]
Entities.gmod_subway_81-760.Buttons.VityazButtons.Vityaz4Set        = @[Common.Vityaz.4]
Entities.gmod_subway_81-760.Buttons.VityazButtons.Vityaz5Set        = @[Common.Vityaz.5]
Entities.gmod_subway_81-760.Buttons.VityazButtons.Vityaz6Set        = @[Common.Vityaz.6]
Entities.gmod_subway_81-760.Buttons.VityazButtons.Vityaz7Set        = @[Common.Vityaz.7]
Entities.gmod_subway_81-760.Buttons.VityazButtons.Vityaz8Set        = @[Common.Vityaz.8]
Entities.gmod_subway_81-760.Buttons.VityazButtons.Vityaz9Set        = @[Common.Vityaz.9]
Entities.gmod_subway_81-760.Buttons.VityazButtons.Vityaz0Set        = @[Common.Vityaz.0]
Entities.gmod_subway_81-760.Buttons.VityazButtons.VityazF5Set       = @[Common.760.VityazF5]
Entities.gmod_subway_81-760.Buttons.VityazButtons.VityazF6Set       = @[Common.760.VityazF6]
Entities.gmod_subway_81-760.Buttons.VityazButtons.VityazF7Set       = @[Common.760.VityazF7]
Entities.gmod_subway_81-760.Buttons.VityazButtons.VityazF8Set       = @[Common.760.VityazF8]
Entities.gmod_subway_81-760.Buttons.VityazButtons.VityazF9Set       = @[Common.760.VityazF9]

Entities.gmod_subway_81-760.Buttons.K35.UAVAToggle                  = K35 (@[Common.ALL.UAVA2])
Entities.gmod_subway_81-760.Buttons.Chair.Chair                     = @[Common.760.Seat]

Entities.gmod_subway_81-760.Buttons.VoltHelper1.!Battery            = @[Common.ALL.BatteryVoltage]
Entities.gmod_subway_81-760.Buttons.VoltHelper1.!HV                 = @[Common.ALL.HighVoltage]

Entities.gmod_subway_81-760.Buttons.Door_add_1.Door_add_1           = @[Common.760.Cabinet]
Entities.gmod_subway_81-760.Buttons.Door_add_1o.Door_add_1          = @[Common.760.Cabinet]
Entities.gmod_subway_81-760.Buttons.Door_add_2.Door_add_2           = @[Common.760.Cabinet]
Entities.gmod_subway_81-760.Buttons.Door_add_2o.Door_add_2          = @[Common.760.Cabinet]
Entities.gmod_subway_81-760.Buttons.Door_pvz.Door_pvz               = @[Common.760.Cabinet]
Entities.gmod_subway_81-760.Buttons.Door_pvzo.Door_pvz              = @[Common.760.Cabinet]
Entities.gmod_subway_81-760.Buttons.K31Cap.K31Cap                   = K31 @[Common.760.Cap]
Entities.gmod_subway_81-760.Buttons.StopcraneCap.StopcraneCap       = @[Common.ALL.EmergencyBrakeValve] @[Common.760.Cap]
Entities.gmod_subway_81-760.Buttons.stopkran2.stopkranToggle        = @[Common.ALL.EmergencyBrakeValve]

Entities.gmod_subway_81-760.Buttons.StopKran.EmergencyBrakeValveToggle          = @[Common.ALL.EmergencyBrakeValve]
Entities.gmod_subway_81-760.Buttons.AB.ABSet                                    = @[Common.ARS.ABButton]

#760A
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF1Toggle       = @[Common.760.SF1]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF2Toggle       = @[Common.760.SF2]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF3Toggle       = @[Common.760.SF3]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF4Toggle       = @[Common.760.SF4]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF5Toggle       = @[Common.760.SF5]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF6Toggle       = @[Common.760.SF6]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF7Toggle       = @[Common.760.SF7]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF8Toggle       = @[Common.760.SF8]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF9Toggle       = @[Common.760.SF9]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF11Toggle      = @[Common.760.SF11]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF12Toggle      = @[Common.760.SF12]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF13Toggle      = @[Common.760.SF13]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF14Toggle      = @[Common.760.SF14]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF15Toggle      = @[Common.760.SF15]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF16Toggle      = @[Common.760.SF16]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF17Toggle      = @[Common.760.SF17]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF18Toggle      = @[Common.760.SF18]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF19Toggle      = @[Common.760.SF19]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF20Toggle      = @[Common.760.SF20]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF21Toggle      = @[Common.760.SF21]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF22Toggle      = @[Common.ALL.Unsused1]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF23Toggle      = @[Common.760.SF23]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF24Toggle      = @[Common.760.SF24]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF26Toggle      = @[Common.760.SF26]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF27Toggle      = @[Common.760A.SF27]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF28Toggle      = @[Common.760.SF28]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SF29Toggle      = @[Common.760A.SF29]

Entities.gmod_subway_81-760a.Buttons.PVZ.SF31Toggle          = @[Common.760.SF31]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF32Toggle          = @[Common.760.SF32]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF33Toggle          = @[Common.760.SF33]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF34Toggle          = @[Common.760.SF34]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF36Toggle          = @[Common.760.SF36]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF37Toggle          = @[Common.760.SF37]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF38Toggle          = @[Common.760.SF38]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF39Toggle          = @[Common.760.SF39]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF40Toggle          = @[Common.760.SF40]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF41Toggle          = @[Common.760.SF41]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF42Toggle          = @[Common.ALL.Unsused1]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF43Toggle          = @[Common.760.SF43]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF44Toggle          = @[Common.760.SF44]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF45Toggle          = @[Common.760.SF45]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF46Toggle          = @[Common.760.SF46]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF47Toggle          = @[Common.760.SF47]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF48Toggle          = @[Common.760.SF48]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF49Toggle          = @[Common.760.SF49]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF50Toggle          = @[Common.760.SF50]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF51Toggle          = @[Common.760.SF51]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF52Toggle          = @[Common.760.SF52]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF53Toggle          = @[Common.760.SF53]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF54Toggle          = @[Common.760.SF54]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF55Toggle          = @[Common.760.SF55]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF56Toggle          = @[Common.760.SF56]
Entities.gmod_subway_81-760a.Buttons.PVZ.SF57Toggle          = @[Common.760.SF57]

Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA1kToggle         = @[Common.760.SA1] @[Common.760.Cover]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA10kToggle        = @[Common.760.SA10] @[Common.760.Cover]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA14kToggle        = @[Common.760.SA14] @[Common.760.Cover]

Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA1Toggle          = @[Common.760.SA1]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA2Toggle          = @[Common.760.SA2]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA3Toggle          = @[Common.760.SA3]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA4Toggle          = @[Common.760.SA4]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA5Toggle          = @[Common.760.SA5]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA6Toggle          = @[Common.760.SA6]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA7Toggle          = @[Common.760.SA7]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA8Toggle          = @[Common.760.SA8]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA9Toggle          = @[Common.760.SA9]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA10Toggle         = @[Common.760.SA10]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA11Toggle         = @[Common.ALL.Unsused1]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA12Toggle         = @[Common.760.SA12]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA13Toggle         = @[Common.760.SA13]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA14Toggle         = @[Common.760.SA14]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA15Toggle         = @[Common.760A.SA15]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA16Toggle         = @[Common.760.SA16]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.SA17Toggle         = @[Common.760.SA17]

Entities.gmod_subway_81-760a.Buttons.BackPPZ.BARSBlock -        = @[Common.720.BARSBlock] @[Common.ALL.CCW]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.BARSBlock +        = @[Common.720.BARSBlock] @[Common.ALL.CW]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.PowerReserve -     = @[Common.760A.PowerReserve] @[Common.ALL.CCW]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.PowerReserve +     = @[Common.760A.PowerReserve] @[Common.ALL.CW]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.PowerOnSet         = @[Common.760A.PowerOn]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.PowerOffSet        = @[Common.760A.PowerOff]
Entities.gmod_subway_81-760a.Buttons.BackPPZ.BatteryToggle      = @[Common.ALL.VB]

Entities.gmod_subway_81-760a.Buttons.CabinDoorR.CabinDoorRight       = @[Common.ALL.CabinDoor]
Entities.gmod_subway_81-760a.Buttons.CabinDoorR1.CabinDoorRight      = @[Common.ALL.CabinDoor]
Entities.gmod_subway_81-760a.Buttons.CabinDoorL.CabinDoorLeft        = @[Common.ALL.CabinDoor]
Entities.gmod_subway_81-760a.Buttons.CabinDoorL1.CabinDoorLeft       = @[Common.ALL.CabinDoor]
Entities.gmod_subway_81-760a.Buttons.PassengerDoor.PassengerDoor     = @[Common.ALL.PassDoor]
Entities.gmod_subway_81-760a.Buttons.PassengerDoor2.PassengerDoor    = @[Common.ALL.PassDoor]

Entities.gmod_subway_81-760a.Buttons.FrontPneumatic.FrontBrakeLineIsolationToggle    = @[Common.ALL.FrontBrakeLineIsolationToggle]
Entities.gmod_subway_81-760a.Buttons.FrontPneumatic.FrontTrainLineIsolationToggle    = @[Common.ALL.FrontTrainLineIsolationToggle]
Entities.gmod_subway_81-760a.Buttons.RearPneumatic.RearTrainLineIsolationToggle      = @[Common.ALL.RearTrainLineIsolationToggle]
Entities.gmod_subway_81-760a.Buttons.RearPneumatic.RearBrakeLineIsolationToggle      = @[Common.ALL.RearBrakeLineIsolationToggle]
Entities.gmod_subway_81-760a.Buttons.GV.GVToggle                                     = @[Common.720.BRU]
Entities.gmod_subway_81-760a.Buttons.BTO.K29Toggle                                   = K29 (@[Common.ALL.KRMH])
Entities.gmod_subway_81-760a.Buttons.BTO.K9Toggle                                    = K9 (@[Common.ALL.RVTB])

Entities.gmod_subway_81-760a.Buttons.ASNP.R_ASNPMenuSet      = @[Common.ASNP.ASNPMenu]
Entities.gmod_subway_81-760a.Buttons.ASNP.R_ASNPUpSet        = @[Common.ASNP.ASNPUp]
Entities.gmod_subway_81-760a.Buttons.ASNP.R_ASNPDownSet      = @[Common.ASNP.ASNPDown]
Entities.gmod_subway_81-760a.Buttons.ASNP.R_ASNPOnToggle     = @[Common.ASNP.ASNPOn]

Entities.gmod_subway_81-760a.Buttons.IGLAButtons.IGLA1Set          = @[Common.IGLA.Button1]
Entities.gmod_subway_81-760a.Buttons.IGLAButtons.IGLA2Set          = @[Common.IGLA.Button2]
Entities.gmod_subway_81-760a.Buttons.IGLAButtons.IGLA23            = @[Common.IGLA.Button23]
Entities.gmod_subway_81-760a.Buttons.IGLAButtons.IGLA3Set          = @[Common.IGLA.Button3]
Entities.gmod_subway_81-760a.Buttons.IGLAButtons.IGLA4Set          = @[Common.IGLA.Button4]

Entities.gmod_subway_81-760a.Buttons.RV.EmerX1Set                = @[Common.720.EmerX1]
Entities.gmod_subway_81-760a.Buttons.RV.EmerX2Set                = @[Common.720.EmerX2]
Entities.gmod_subway_81-760a.Buttons.RV.EmerCloseDoorsSet        = @[Common.720.EmerCloseDoors]
Entities.gmod_subway_81-760a.Buttons.RV.EmergencyDoorsToggle     = @[Common.720.EmergencyDoors]
Entities.gmod_subway_81-760a.Buttons.RV.EmergencyCompressorSet   = @[Common.720.EmergencyCompressor]
Entities.gmod_subway_81-760a.Buttons.RV.EmergencyControlsToggle  = @[Common.720.EmergencyControls]
Entities.gmod_subway_81-760a.Buttons.RV.EmergencyControlsKToggle = @[Common.720.EmergencyControls] @[Common.760.Cover]

Entities.gmod_subway_81-760a.Buttons.PUR.DoorSelectLToggle           = @[Common.720.DoorSelectL]
Entities.gmod_subway_81-760a.Buttons.PUR.DoorSelectRToggle           = @[Common.720.DoorSelectR]
Entities.gmod_subway_81-760a.Buttons.PUR.DoorLeftSet                 = @[Common.720.KDL]
Entities.gmod_subway_81-760a.Buttons.PUR.R_MicroSet                  = @[Common.760.R_Micro]
Entities.gmod_subway_81-760a.Buttons.PUR.HeadlightsSwitch+           = @[Common.ALL.VF] @[Common.ALL.Up]
Entities.gmod_subway_81-760a.Buttons.PUR.HeadlightsSwitch-           = @[Common.ALL.VF] @[Common.ALL.Down]
Entities.gmod_subway_81-760a.Buttons.PUR.DoorCloseToggle             = @[Common.720.DoorClose]
Entities.gmod_subway_81-760a.Buttons.PUR.AttentionMessageSet         = @[Common.720.AttentionMessage]
Entities.gmod_subway_81-760a.Buttons.PUR.AttentionSet                = @[Common.ARS.KB]
Entities.gmod_subway_81-760a.Buttons.PUR.AttentionBrakeSet           = @[Common.ARS.KVT]
Entities.gmod_subway_81-760a.Buttons.PUR.HornBSet                    = @[Common.ALL.Horn]
Entities.gmod_subway_81-760a.Buttons.PUR.DoorRightSet                = @[Common.720.KDP]
Entities.gmod_subway_81-760a.Buttons.PUR.R_Program1Set               = @[Common.720.R_Program1]

Entities.gmod_subway_81-760a.Buttons.PUR2.EmerBrakeAddSet             = @[Common.720.EBrakeAdd]
Entities.gmod_subway_81-760a.Buttons.PUR2.EmerBrakeReleaseSet         = @[Common.720.EBrakeRelease]
Entities.gmod_subway_81-760a.Buttons.PUR2.EmerBrakeToggle             = @[Common.720.EBrakeToggle]
Entities.gmod_subway_81-760a.Buttons.PUR2.EmergencyBrakeToggle        = @[Common.720.EmergencyBrake]
Entities.gmod_subway_81-760a.Buttons.PUR2.R_Program11Set              = @[Common.720.R_Program1]
Entities.gmod_subway_81-760a.Buttons.PUR2.SDkToggle                   = @[Common.760.SD] @[Common.760.Cover]
Entities.gmod_subway_81-760a.Buttons.PUR2.SDToggle                    = @[Common.760.SD]
Entities.gmod_subway_81-760a.Buttons.PUR2.BTBkToggle                  = @[Common.760.BTB] @[Common.760.Cover]
Entities.gmod_subway_81-760a.Buttons.PUR2.BTBToggle                   = @[Common.760.BTB]
Entities.gmod_subway_81-760a.Buttons.PUR2.MicroToggle                 = @[Common.760.R_Micro]

Entities.gmod_subway_81-760a.Buttons.PUU.DoorBlockToggle             = @[Common.720.DoorBlock]
Entities.gmod_subway_81-760a.Buttons.PUU.!HVoltage                   = @[Common.760.HVoltage]
Entities.gmod_subway_81-760a.Buttons.PUU.!DoorsClosed                = @[Common.ALL.LSD]
Entities.gmod_subway_81-760a.Buttons.PUU.R_LineToggle                = @[Common.720.R_Line]
Entities.gmod_subway_81-760a.Buttons.PUU.AccelRateSet                = @[Common.720.AccelRate]
Entities.gmod_subway_81-760a.Buttons.PUU.EnableBVSet                 = @[Common.720.EnableBV]
Entities.gmod_subway_81-760a.Buttons.PUU.DisableBVSet                = @[Common.720.DisableBV]
Entities.gmod_subway_81-760a.Buttons.PUU.RingSet                     = @[Common.720.Ring]
Entities.gmod_subway_81-760a.Buttons.PUU.KAHToggle                   = @[Common.720.KAH]
Entities.gmod_subway_81-760a.Buttons.PUU.ALSToggle                   = @[Common.720.ALS]
Entities.gmod_subway_81-760a.Buttons.PUU.ALSkToggle                  = @[Common.720.ALSK]
Entities.gmod_subway_81-760a.Buttons.PUU.WiperToggle                 = @[Common.720.Wiper]
Entities.gmod_subway_81-760a.Buttons.PUU.WasherSet                   = @[Common.722.GlassWasher]
Entities.gmod_subway_81-760a.Buttons.PUU.GlassHeatingToggle          = @[Common.760.GlassHeating]
Entities.gmod_subway_81-760a.Buttons.PUU.PrToggle                    = @[Common.760.Pr]
Entities.gmod_subway_81-760a.Buttons.PUU.SCToggle                    = @[Common.ALL.Unsused1]
Entities.gmod_subway_81-760a.Buttons.PUU.AutoDriveToggle             = @[Common.ALL.Unsused1]
Entities.gmod_subway_81-760a.Buttons.PUU.OtklRToggle                 = @[Common.760.OtklR]
Entities.gmod_subway_81-760a.Buttons.PUU.R_ToBackSet                 = @[Common.760.R_ToBack]
Entities.gmod_subway_81-760a.Buttons.PUU.R_ChangeRouteToggle         = @[Common.760.R_ChangeRoute]

Entities.gmod_subway_81-760a.Buttons.VityazButtons.Vityaz1Set        = @[Common.Vityaz.1]
Entities.gmod_subway_81-760a.Buttons.VityazButtons.Vityaz2Set        = @[Common.Vityaz.2]
Entities.gmod_subway_81-760a.Buttons.VityazButtons.Vityaz3Set        = @[Common.Vityaz.3]
Entities.gmod_subway_81-760a.Buttons.VityazButtons.Vityaz4Set        = @[Common.Vityaz.4]
Entities.gmod_subway_81-760a.Buttons.VityazButtons.Vityaz5Set        = @[Common.Vityaz.5]
Entities.gmod_subway_81-760a.Buttons.VityazButtons.Vityaz6Set        = @[Common.Vityaz.6]
Entities.gmod_subway_81-760a.Buttons.VityazButtons.Vityaz7Set        = @[Common.Vityaz.7]
Entities.gmod_subway_81-760a.Buttons.VityazButtons.Vityaz8Set        = @[Common.Vityaz.8]
Entities.gmod_subway_81-760a.Buttons.VityazButtons.Vityaz9Set        = @[Common.Vityaz.9]
Entities.gmod_subway_81-760a.Buttons.VityazButtons.Vityaz0Set        = @[Common.Vityaz.0]
Entities.gmod_subway_81-760a.Buttons.VityazButtons.VityazF5Set       = @[Common.760.VityazF5]
Entities.gmod_subway_81-760a.Buttons.VityazButtons.VityazF6Set       = @[Common.760.VityazF6]
Entities.gmod_subway_81-760a.Buttons.VityazButtons.VityazF7Set       = @[Common.760.VityazF7]
Entities.gmod_subway_81-760a.Buttons.VityazButtons.VityazF8Set       = @[Common.760.VityazF8]
Entities.gmod_subway_81-760a.Buttons.VityazButtons.VityazF9Set       = @[Common.760.VityazF9]

Entities.gmod_subway_81-760a.Buttons.K35.UAVAToggle                  = K35 (@[Common.ALL.UAVA2])
Entities.gmod_subway_81-760a.Buttons.Chair.Chair                     = @[Common.760.Seat]

Entities.gmod_subway_81-760a.Buttons.VoltHelper1.!Battery            = @[Common.ALL.BatteryVoltage]
Entities.gmod_subway_81-760a.Buttons.VoltHelper1.!HV                 = @[Common.ALL.HighVoltage]

Entities.gmod_subway_81-760a.Buttons.Door_add_1.Door_add_1           = @[Common.760.Cabinet]
Entities.gmod_subway_81-760a.Buttons.Door_add_1o.Door_add_1          = @[Common.760.Cabinet]
Entities.gmod_subway_81-760a.Buttons.Door_add_2.Door_add_2           = @[Common.760.Cabinet]
Entities.gmod_subway_81-760a.Buttons.Door_add_2o.Door_add_2          = @[Common.760.Cabinet]
Entities.gmod_subway_81-760a.Buttons.Door_pvz.Door_pvz               = @[Common.760.Cabinet]
Entities.gmod_subway_81-760a.Buttons.Door_pvzo.Door_pvz              = @[Common.760.Cabinet]
Entities.gmod_subway_81-760a.Buttons.K31Cap.K31Cap                   = K31 @[Common.760.Cap]

Entities.gmod_subway_81-760a.Buttons.StopKran.EmergencyBrakeValveToggle          = @[Common.ALL.EmergencyBrakeValve]

Entities.gmod_subway_81-761.Buttons.RearDoor.RearDoor               = @[Common.ALL.RearDoor]
Entities.gmod_subway_81-761.Buttons.RearDoor1.RearDoor              = @[Common.ALL.RearDoor]
Entities.gmod_subway_81-761.Buttons.FrontDoor.FrontDoor             = @[Common.ALL.FrontDoor]
Entities.gmod_subway_81-761.Buttons.FrontDoor1.FrontDoor            = @[Common.ALL.FrontDoor]
Entities.gmod_subway_81-761.Buttons.couch_capL.CouchCapL            = @[Common.760.Cabinet]
Entities.gmod_subway_81-761.Buttons.couch_capL_o.CouchCapL          = @[Common.760.Cabinet]
Entities.gmod_subway_81-761.Buttons.couch_capR.CouchCapR            = @[Common.760.Cabinet]
Entities.gmod_subway_81-761.Buttons.couch_capR_o.CouchCapR          = @[Common.760.Cabinet]

Entities.gmod_subway_81-761.Buttons.PVZ.SF31Toggle          = @[Common.760.SF31]
Entities.gmod_subway_81-761.Buttons.PVZ.SF32Toggle          = @[Common.760.SF32]
Entities.gmod_subway_81-761.Buttons.PVZ.SF33Toggle          = @[Common.760.SF33]
Entities.gmod_subway_81-761.Buttons.PVZ.SF34Toggle          = @[Common.760.SF34]
Entities.gmod_subway_81-761.Buttons.PVZ.SF36Toggle          = @[Common.760.SF36]
Entities.gmod_subway_81-761.Buttons.PVZ.SF37Toggle          = @[Common.760.SF37]
Entities.gmod_subway_81-761.Buttons.PVZ.SF38Toggle          = @[Common.760.SF38]
Entities.gmod_subway_81-761.Buttons.PVZ.SF39Toggle          = @[Common.760.SF39]
Entities.gmod_subway_81-761.Buttons.PVZ.SF40Toggle          = @[Common.760.SF40]
Entities.gmod_subway_81-761.Buttons.PVZ.SF41Toggle          = @[Common.760.SF41]
Entities.gmod_subway_81-761.Buttons.PVZ.SF42Toggle          = @[Common.760.SF42]
Entities.gmod_subway_81-761.Buttons.PVZ.SF43Toggle          = @[Common.760.SF43]
Entities.gmod_subway_81-761.Buttons.PVZ.SF44Toggle          = @[Common.760.SF44]
Entities.gmod_subway_81-761.Buttons.PVZ.SF45Toggle          = @[Common.760.SF45]
Entities.gmod_subway_81-761.Buttons.PVZ.SF46Toggle          = @[Common.760.SF46]
Entities.gmod_subway_81-761.Buttons.PVZ.SF47Toggle          = @[Common.760.SF47]
Entities.gmod_subway_81-761.Buttons.PVZ.SF48Toggle          = @[Common.760.SF48]
Entities.gmod_subway_81-761.Buttons.PVZ.SF49Toggle          = @[Common.760.SF49]
Entities.gmod_subway_81-761.Buttons.PVZ.SF50Toggle          = @[Common.760.SF50]
Entities.gmod_subway_81-761.Buttons.PVZ.SF51Toggle          = @[Common.760.SF51]
Entities.gmod_subway_81-761.Buttons.PVZ.SF52Toggle          = @[Common.760.SF52]
Entities.gmod_subway_81-761.Buttons.PVZ.SF53Toggle          = @[Common.760.SF53]
Entities.gmod_subway_81-761.Buttons.PVZ.SF54Toggle          = @[Common.760.SF54]
Entities.gmod_subway_81-761.Buttons.PVZ.SF55Toggle          = @[Common.760.SF55]
Entities.gmod_subway_81-761.Buttons.PVZ.SF56Toggle          = @[Common.760.SF56]
Entities.gmod_subway_81-761.Buttons.PVZ.SF57Toggle          = @[Common.760.SF57]

Entities.gmod_subway_81-761.Buttons.Battery.BatteryToggle   = @[Common.ALL.VB]

Entities.gmod_subway_81-761.Buttons.boxR.EmergencyBrakeValveToggle      = @[Common.ALL.EmergencyBrakeValve]
Entities.gmod_subway_81-761.Buttons.boxR.DriverValveTLDisconnectToggle  = @[Common.ALL.DriverValveTLDisconnect]
Entities.gmod_subway_81-761.Buttons.boxR.DriverValveBLDisconnectToggle  = @[Common.ALL.DriverValveBLDisconnect]

Entities.gmod_subway_81-761.Buttons.StopcraneCap.StopcraneCap       = @[Common.ALL.EmergencyBrakeValve] @[Common.760.Cap]
Entities.gmod_subway_81-761.Buttons.stopkran2.stopkranToggle        = @[Common.ALL.EmergencyBrakeValve]

Entities.gmod_subway_81-761.Buttons.FrontPneumatic.FrontBrakeLineIsolationToggle    = @[Common.ALL.FrontBrakeLineIsolationToggle]
Entities.gmod_subway_81-761.Buttons.FrontPneumatic.FrontTrainLineIsolationToggle    = @[Common.ALL.FrontTrainLineIsolationToggle]
Entities.gmod_subway_81-761.Buttons.RearPneumatic.RearTrainLineIsolationToggle      = @[Common.ALL.RearTrainLineIsolationToggle]
Entities.gmod_subway_81-761.Buttons.RearPneumatic.RearBrakeLineIsolationToggle      = @[Common.ALL.RearBrakeLineIsolationToggle]

#761A
Entities.gmod_subway_81-761a.Buttons.Battery.BatteryToggle   = @[Common.ALL.VB]

Entities.gmod_subway_81-761a.Buttons.boxR.EmergencyBrakeValveToggle      = @[Common.ALL.EmergencyBrakeValve]
Entities.gmod_subway_81-761a.Buttons.Power.PowerOnSet        = @[Common.760A.PowerOn]

Entities.gmod_subway_81-761a.Buttons.PVZ.SF31Toggle          = @[Common.760.SF31]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF32Toggle          = @[Common.760.SF32]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF33Toggle          = @[Common.760.SF33]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF34Toggle          = @[Common.760.SF34]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF36Toggle          = @[Common.760.SF36]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF37Toggle          = @[Common.760.SF37]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF38Toggle          = @[Common.760.SF38]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF39Toggle          = @[Common.760.SF39]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF40Toggle          = @[Common.760.SF40]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF41Toggle          = @[Common.760.SF41]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF42Toggle          = @[Common.ALL.Unsused1]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF43Toggle          = @[Common.760.SF43]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF44Toggle          = @[Common.760.SF44]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF45Toggle          = @[Common.760.SF45]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF46Toggle          = @[Common.760.SF46]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF47Toggle          = @[Common.760.SF47]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF48Toggle          = @[Common.760.SF48]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF49Toggle          = @[Common.760.SF49]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF50Toggle          = @[Common.760.SF50]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF51Toggle          = @[Common.760.SF51]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF52Toggle          = @[Common.760.SF52]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF53Toggle          = @[Common.760.SF53]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF54Toggle          = @[Common.760.SF54]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF55Toggle          = @[Common.760.SF55]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF56Toggle          = @[Common.760.SF56]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF57Toggle          = @[Common.760.SF57]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF58Toggle          = @[Common.760.SF58]
Entities.gmod_subway_81-761a.Buttons.PVZ.SF59Toggle          = @[Common.ALL.Unsused1]

Entities.gmod_subway_81-761a.Buttons.couch_capL.CouchCapL          = @[Common.760.Cabinet]
Entities.gmod_subway_81-761a.Buttons.couch_capL_o.CouchCapL        = @[Common.760.Cabinet]
Entities.gmod_subway_81-761a.Buttons.couch_capR.CouchCapR          = @[Common.760.Cabinet]
Entities.gmod_subway_81-761a.Buttons.couch_capR_o.CouchCapR        = @[Common.760.Cabinet]

#763A
Entities.gmod_subway_81-763a.Buttons.Battery.BatteryToggle   = @[Common.ALL.VB]

Entities.gmod_subway_81-763a.Buttons.boxR.EmergencyBrakeValveToggle      = @[Common.ALL.EmergencyBrakeValve]
Entities.gmod_subway_81-763a.Buttons.Power.PowerOnSet        = @[Common.760A.PowerOn]

Entities.gmod_subway_81-763a.Buttons.PVZ.SF34Toggle          = @[Common.760A.SF34]
Entities.gmod_subway_81-763a.Buttons.PVZ.SF35Toggle          = @[Common.760A.SF35]
Entities.gmod_subway_81-763a.Buttons.PVZ.SF36Toggle          = @[Common.760.SF36]
Entities.gmod_subway_81-763a.Buttons.PVZ.SF37Toggle          = @[Common.760.SF37]
Entities.gmod_subway_81-763a.Buttons.PVZ.SF38Toggle          = @[Common.760.SF38]
Entities.gmod_subway_81-763a.Buttons.PVZ.SF39Toggle          = @[Common.760.SF39]
Entities.gmod_subway_81-763a.Buttons.PVZ.SF40Toggle          = @[Common.760.SF40]
Entities.gmod_subway_81-763a.Buttons.PVZ.SF41Toggle          = @[Common.760.SF41]
Entities.gmod_subway_81-763a.Buttons.PVZ.SF42Toggle          = @[Common.ALL.Unsused1]
Entities.gmod_subway_81-763a.Buttons.PVZ.SF43Toggle          = @[Common.760.SF43]
Entities.gmod_subway_81-763a.Buttons.PVZ.SF44Toggle          = @[Common.760.SF44]
Entities.gmod_subway_81-763a.Buttons.PVZ.SF46Toggle          = @[Common.760.SF46]
Entities.gmod_subway_81-763a.Buttons.PVZ.SF47Toggle          = @[Common.760.SF47]
Entities.gmod_subway_81-763a.Buttons.PVZ.SF48Toggle          = @[Common.760.SF48]
Entities.gmod_subway_81-763a.Buttons.PVZ.SF49Toggle          = @[Common.760.SF49]
Entities.gmod_subway_81-763a.Buttons.PVZ.SF53Toggle          = @[Common.760.SF53]
Entities.gmod_subway_81-763a.Buttons.PVZ.SF54Toggle          = @[Common.760.SF54]
Entities.gmod_subway_81-763a.Buttons.PVZ.SF55Toggle          = @[Common.760.SF55]
Entities.gmod_subway_81-763a.Buttons.PVZ.SF56Toggle          = @[Common.760.SF56]
Entities.gmod_subway_81-763a.Buttons.PVZ.SF57Toggle          = @[Common.760.SF57]

Entities.gmod_subway_81-763a.Buttons.couch_capL.CouchCapL          = @[Common.760.Cabinet]
Entities.gmod_subway_81-763a.Buttons.couch_capL_o.CouchCapL        = @[Common.760.Cabinet]
Entities.gmod_subway_81-763a.Buttons.couch_capR.CouchCapR          = @[Common.760.Cabinet]
Entities.gmod_subway_81-763a.Buttons.couch_capR_o.CouchCapR        = @[Common.760.Cabinet]
]]
