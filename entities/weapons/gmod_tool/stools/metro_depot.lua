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

	local depot = panel:TextEntry("#tool.metro_depot.depot", "metro_depot_depot")
	depot:SetTooltip("#tool.metro_depot.depot")

	panel:TextEntry("#tool.metro_depot.label", "metro_depot_label")

	local list = vgui.Create("DListView", panel)
	list:SetTall(160)
	list:AddColumn("#tool.metro_depot.depot")
	list:AddColumn("#tool.metro_depot.label")
	list.OnRowSelected = function(_, _, row)
		RunConsoleCommand("metro_depot_depot", row:GetColumnText(1))
		RunConsoleCommand("metro_depot_label", row:GetColumnText(2))
	end
	panel:AddItem(list)

	local function refresh(names)
		list:Clear()
		for _, entry in ipairs(names or {}) do
			list:AddLine(entry.name, entry.label)
		end
	end

	net.Receive("MetroDepotList", function()
		local count = net.ReadUInt(8)
		local names = {}
		for _ = 1, count do
			table.insert(names, { name = net.ReadString(), label = net.ReadString() })
		end
		refresh(names)
	end)

	local button = panel:Button("#tool.metro_depot.refresh")
	button.DoClick = function()
		net.Start("MetroDepotListRequest")
		net.SendToServer()
	end
	button:DoClick()
end

if CLIENT then
	language.Add("tool.metro_depot.depot", "Depot name")
	language.Add("tool.metro_depot.label", "Display label")
	language.Add("tool.metro_depot.refresh", "Refresh depot list")
end
