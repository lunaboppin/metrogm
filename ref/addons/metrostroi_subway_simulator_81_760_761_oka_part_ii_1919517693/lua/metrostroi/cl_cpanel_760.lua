CreateClientConVar( "760_optimization", 0, true)
CreateClientConVar( "760_optimization2",0, true)
--Helper function for common use
local function AddBox(panel,cmd,str)
    panel:AddControl("CheckBox",{Label=str, Command=cmd})
end
local function AddSlider(panel,cmd,str,min,max)
    panel:AddControl("Slider",{Label=str, Command=cmd,min=min,max=max})
end
local function ClientPanel(panel)
    panel:ClearControls()
    panel:SetPadding(0)
    panel:SetSpacing(0)
    panel:Dock( FILL )
    AddBox(panel,"760_optimization",Metrostroi.GetPhrase("Panel.760Optimization"))
    AddBox(panel,"760_optimization2",Metrostroi.GetPhrase("Panel.760Optimization2"))
end

hook.Add("PopulateToolMenu", "Metrostroi oka cpanel", function()
    spawnmenu.AddToolMenuOption("Utilities", "Metrostroi", "metrostroi_oka_panel", Metrostroi.GetPhrase("Panel.760Name"), "", "", ClientPanel)
end)