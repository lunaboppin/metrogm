TOOL.Category = "Metro"
TOOL.Name = "#tool.metro_depot.name"
TOOL.ClientConVar["depot"] = "depot"
TOOL.ClientConVar["label"] = ""

if CLIENT then
	language.Add("tool.metro_depot.name", "Depot Placement")
	language.Add("tool.metro_depot.desc", "Save where each train model spawns at a depot.")
	language.Add("tool.metro_depot.0", "Left click a train to save its placement. Right click to set the depot default. Reload to clear this model.")
end

local function allowed(ply)
	return IsValid(ply) and ply:IsSuperAdmin()
end

local function apply(self, asDefault)
	local ply = self:GetOwner()
	if not allowed(ply) then
		return false
	end

	if CLIENT then
		return true
	end

	local success, message, className, label = METRO.Service.SavePlacement(
		ply,
		self:GetClientInfo("depot"),
		self:GetClientInfo("label"),
		asDefault
	)

	ply:NotifyLocalized(message, className or "", label or "")
	return success
end

function TOOL:LeftClick()
	return apply(self, false)
end

function TOOL:RightClick()
	return apply(self, true)
end

function TOOL:Reload()
	local ply = self:GetOwner()
	if not allowed(ply) then
		return false
	end

	if CLIENT then
		return true
	end

	local success, message, className, label = METRO.Service.ClearPlacement(ply, self:GetClientInfo("depot"))
	ply:NotifyLocalized(message, className or "", label or "")
	return success
end

function TOOL.BuildCPanel(panel)
	panel:AddControl("Header", { Description = "#tool.metro_depot.0" })
	panel:TextEntry("#tool.metro_depot.depot", "metro_depot_depot")
	panel:TextEntry("#tool.metro_depot.label", "metro_depot_label")

	local list = vgui.Create("DListView", panel)
	list:SetTall(200)
	list:AddColumn("#tool.metro_depot.depot")
	list:AddColumn("#tool.metro_depot.label")
	list:AddColumn("#tool.metro_depot.model")
	panel:AddItem(list)

	local function request()
		net.Start("MetroDepotListRequest")
		net.SendToServer()
	end

	local function manage(depotName, className)
		net.Start("MetroDepotManage")
		net.WriteString(depotName)
		net.WriteString(className or "")
		net.SendToServer()
		timer.Simple(0.6, request)
	end

	list.OnRowSelected = function(_, _, row)
		RunConsoleCommand("metro_depot_depot", row:GetColumnText(1))
		RunConsoleCommand("metro_depot_label", row:GetColumnText(2))
	end

	list.DoDoubleClick = function(_, _, row)
		RunConsoleCommand("metro_depot_depot", row:GetColumnText(1))
	end

	net.Receive("MetroDepotList", function()
		list:Clear()
		for _ = 1, net.ReadUInt(8) do
			local name = net.ReadString()
			local label = net.ReadString()
			local hasDefault = net.ReadBool()
			local count = net.ReadUInt(8)

			if hasDefault then
				local row = list:AddLine(name, label, "#tool.metro_depot.defaultRow")
				row.depotName = name
				row.className = ""
			end

			for _ = 1, count do
				local className = net.ReadString()
				local row = list:AddLine(name, label, className)
				row.depotName = name
				row.className = className
			end
		end
	end)

	local refresh = panel:Button("#tool.metro_depot.refresh")
	refresh.DoClick = request

	local removePlacement = panel:Button("#tool.metro_depot.removePlacement")
	removePlacement.DoClick = function()
		local row = list:GetSelectedLine() and list:GetLine(list:GetSelectedLine())
		if not row or not row.depotName or row.className == "" then return end
		manage(row.depotName, row.className)
	end

	local removeDepot = panel:Button("#tool.metro_depot.removeDepot")
	removeDepot.DoClick = function()
		local row = list:GetSelectedLine() and list:GetLine(list:GetSelectedLine())
		if not row or not row.depotName then return end
		Derma_Query(
			language.GetPhrase("tool.metro_depot.confirmRemove"),
			language.GetPhrase("tool.metro_depot.removeDepot"),
			language.GetPhrase("tool.metro_depot.confirmYes"), function() manage(row.depotName, nil) end,
			language.GetPhrase("tool.metro_depot.confirmNo"), function() end
		)
	end

	request()
end

if CLIENT then
	language.Add("tool.metro_depot.depot", "Depot name")
	language.Add("tool.metro_depot.label", "Display label")
	language.Add("tool.metro_depot.refresh", "Refresh list")
	language.Add("tool.metro_depot.model", "Train model")
	language.Add("tool.metro_depot.defaultRow", "(depot default)")
	language.Add("tool.metro_depot.removePlacement", "Remove selected placement")
	language.Add("tool.metro_depot.removeDepot", "Remove whole depot")
	language.Add("tool.metro_depot.confirmRemove", "Remove this depot and every placement saved in it?")
	language.Add("tool.metro_depot.confirmYes", "Remove")
	language.Add("tool.metro_depot.confirmNo", "Cancel")
end
