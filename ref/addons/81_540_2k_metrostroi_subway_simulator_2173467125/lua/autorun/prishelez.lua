Prishelez = Prishelez or {}
if CLIENT then 
CreateClientConVar( "prishelez_bliki", 0, true ) 
CreateClientConVar( "prishelez_hidewagons", 0, true ) 

local function AddBox( panel, cmd, str )
    panel:AddControl( "CheckBox", {Label = str, Command = cmd } )
end

local function clpanel( panel ) 
    AddBox(panel, "prishelez_bliki", "Отключить блики от ламп" )
    AddBox(panel, "prishelez_hidewagons", "Скрывать все вагоны кроме текущего" ) 
end
hook.Add( "PopulateToolMenu", "PrishelezClPanel", function()
     spawnmenu.AddToolMenuOption( "Utilities", "Metrostroi", "MetrostroiPrishelez", "540.2К", "", "", clpanel )
end) 
RunConsoleCommand("spawnmenu_reload") 
end 

hook.Add("OnEntityCreated", "ALSFreqby2k", function( ent )
        if !IsValid( ent ) or not ent:GetClass():find("540_2k") then return end 
        timer.Simple(3, function()
             for _, signal in pairs( ents.FindByClass( "gmod_track_signal" ) or {} ) do 
                   if !IsValid( signal ) then break end  
                   if !signal.TwoToSix then break end 
                   if ent.ALSFreq and ent:GetNW2Int("TypeLine",1) == 1 then ent.ALSFreq:TriggerInput("Set",1) end 
              end  
        end ) 
end )  

function Prishelez.AddLast( name )
       if not Prishelez.Lasts then Prishelez.Lasts = { } end 
       table.insert( Prishelez.Lasts, name )
end  
    
local b = game.GetMap()
Prishelez.AddLast( "обкатка" )
Prishelez.AddLast( "перегонка" )
if b == "gm_metro_crossline_c4" then 
   Prishelez.AddLast( "международная" )
   Prishelez.AddLast( "пролетарская" )
   Prishelez.AddLast( "октябрьская" )
   Prishelez.AddLast( "речная" )
   Prishelez.AddLast( "нахимовская" )
end 
if b == "gm_metro_crossline_r197c" or b == "gm_metro_crossline_r198" or b == "gm_metro_crossline_r199d" or b == "gm_metro_crossline_r199h" then
   Prishelez.AddLast( "международная" )
   Prishelez.AddLast( "пролетарская" )
   Prishelez.AddLast( "октябрьская" )
   Prishelez.AddLast( "речная" )
   Prishelez.AddLast( "молодежная" )
   Prishelez.AddLast( "нахимовская" )
   Prishelez.AddLast( "политехническая" )
end
if b == "gm_metro_mosldl_v1" then  
   Prishelez.AddLast( "дубровка" )
   Prishelez.AddLast( "люблино" ) 
   Prishelez.AddLast( "печатники" )
   Prishelez.AddLast( "волжская" )
end  
if b == "gm_metro_surfacemetro_w" then            
   Prishelez.AddLast( "советская" ) 
   Prishelez.AddLast( "куровская" )
   Prishelez.AddLast( "ул. айзека кляйнера" )
   Prishelez.AddLast( "антиколлаборанистическая" )
   Prishelez.AddLast( "куровская" )
end
if b == "gm_metro_nekrasovskaya_line_v5" then
   Prishelez.AddLast( "некрасовка" )
   Prishelez.AddLast( "косино" )
   Prishelez.AddLast( "окская" )
   Prishelez.AddLast( "нижегородская" )
   Prishelez.AddLast( "лухмановская" )
end       
if b == "gm_metro_jar_imagine_line_v4" then
   Prishelez.AddLast( "касторская" )
   Prishelez.AddLast( "пр.метростроит." )
   Prishelez.AddLast( "северная" )
   Prishelez.AddLast( "пр.энергетиков" ) 
   Prishelez.AddLast( "восход" )
end
if b == "gm_jar_pll_remastered_v9" or b == "gm_jar_pll_remastered_v12" then
   Prishelez.AddLast( "лесопарковая" )
   Prishelez.AddLast( "черкасская пл." )
   Prishelez.AddLast( "новомосковская" )
   Prishelez.AddLast( "селигерская" )
   Prishelez.AddLast( "октябрьская" )
   Prishelez.AddLast( "динамо" )
end
if b == "gm_metro_pink_line" then
   Prishelez.AddLast( "первомайская" )
   Prishelez.AddLast( "партизанская" ) 
   Prishelez.AddLast( "гидропарк" )
end
if b == "gm_metrostroi_b50" then
   Prishelez.AddLast( "автостан.южная" )
   Prishelez.AddLast( "междустройская" )
   Prishelez.AddLast( "царские ворота" )
   Prishelez.AddLast( "минская" )
   Prishelez.AddLast( "вокзальная" )
   Prishelez.AddLast( "октябрьская" )
   Prishelez.AddLast( "московская" )
   Prishelez.AddLast( "автозаводская" )
end
if b == "gm_mus_loopline_e" then
   Prishelez.AddLast( "пионерская" )
   Prishelez.AddLast( "первоапрельская" )
   Prishelez.AddLast( "морская" )
   Prishelez.AddLast( "славная страна" )
   Prishelez.AddLast( "парк" )
end
if b == "gm_mustox_neocrimson_line_a" then
   Prishelez.AddLast( "братеево" )
   Prishelez.AddLast( "пионерская" )
   Prishelez.AddLast( "метростроителей" )
   Prishelez.AddLast( "славутич" )
   Prishelez.AddLast( "фауна")
   Prishelez.AddLast( "сталинская")
end
if b == "gm_mus_neoorange_d" then
   Prishelez.AddLast( "икарус" )
   Prishelez.AddLast( "им.уоллеса брина" )
   Prishelez.AddLast( "аэропорт" )
   Prishelez.AddLast( "парк" )
   Prishelez.AddLast( "славная страна" )
end
if b == "gm_smr_1987" then
   Prishelez.AddLast( "кировская" )
   Prishelez.AddLast( "победа" )
end
if b == "gm_smr_first_line_v3" then
   Prishelez.AddLast( "юнгородок" )
   Prishelez.AddLast( "алабинская" )
   Prishelez.AddLast( "кировская" )
   Prishelez.AddLast( "гагаринская" )
   Prishelez.AddLast( "российская" )
end
if b == "gm_mus_crimson_line_tox_v9_21" then
   Prishelez.AddLast( "аэропорт" )
   Prishelez.AddLast( "метростроителей" )
   Prishelez.AddLast( "каховская" )
   Prishelez.AddLast( "гагаринская" )
   Prishelez.AddLast( "российская" )
end
