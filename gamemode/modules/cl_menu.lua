METRO.Menu = METRO.Menu or {}

local FRAME_WIDTH = 720
local FRAME_HEIGHT = 420
local TAB_WIDTH = 160

local menu

local function CreateField(parent, labelKey)
	local row = vgui.Create("metroLabel", parent)
	row:SetFont("MetroLabelFont")
	row:SetText(L(labelKey))
	row:Dock(TOP)
	row:DockMargin(0, 0, 0, 4)
	row:SizeToContents()

	return row
end

local function BuildProfilePanel(container)
	local panel = vgui.Create("EditablePanel", container)
	panel:Dock(FILL)
	panel:DockPadding(12, 12, 12, 12)

	local details = vgui.Create("metroCategory", panel)
	details:SetText(L("menuDetailsCategory"))
	details:Dock(TOP)
	details:DockMargin(0, 0, 0, 12)

	local nameLabel = CreateField(details, "menuNameUnknown")
	local moneyLabel = CreateField(details, "menuMoneyUnknown")
	local levelLabel = CreateField(details, "menuLevelUnknown")
	local playtimeLabel = CreateField(details, "menuPlaytimeUnknown")
	local firstSeenLabel = CreateField(details, "menuFirstSeenUnknown")

	details:SizeToContents()

	local progress = vgui.Create("metroCategory", panel)
	progress:SetText(L("menuProgressCategory"))
	progress:Dock(TOP)

	local xpBar = vgui.Create("metroSegmentedProgress", progress)
	xpBar:Dock(TOP)
	xpBar:SetTall(24)

	local xpLabel = CreateField(progress, "menuXpUnknown")

	progress:SizeToContents()

	panel.Refresh = function()
		local stats = METRO.Stats

		if not stats then
			nameLabel:SetText(L("menuNameUnknown"))
			moneyLabel:SetText(L("menuMoneyUnknown"))
			levelLabel:SetText(L("menuLevelUnknown"))
			xpBar:SetFraction(0)
			xpLabel:SetText(L("menuXpUnknown"))
			playtimeLabel:SetText(L("menuPlaytimeUnknown"))
			firstSeenLabel:SetText(L("menuFirstSeenUnknown"))
			return
		end

		nameLabel:SetText(L("menuNameFormat", tostring(stats.name or "-")))
		moneyLabel:SetText(L("menuMoneyFormat", METRO.Format.Money(stats.money)))
		levelLabel:SetText(L("menuLevelFormat", tostring(stats.level or "-")))

		local maxLevel = METRO.Levels.GetMaxLevel()
		local level, into, span, fraction = METRO.Levels.Progress(stats.xp or 0)
		xpBar:SetFraction(fraction)

		if level >= maxLevel then
			xpLabel:SetText(L("menuXpMaxLevel"))
		else
			xpLabel:SetText(L("menuXpFormat", into, span))
		end

		playtimeLabel:SetText(L("menuPlaytimeFormat", METRO.Format.Playtime(stats.playtime_seconds)))
		firstSeenLabel:SetText(L("menuFirstSeenFormat", METRO.Format.FirstSeen(stats.first_seen, L("menuFirstSeenUnknownValue"))))
	end

	panel.Refresh()

	return panel
end

hook.Add("CreateMenuButtons", "METRO_ProfileTab", function(tabs)
	tabs.menuProfileTab = {
		Create = BuildProfilePanel,
	}
end)

local PANEL = {}

function PANEL:Init()
	self:SetSkin("metro")
	self:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
	self:Center()
	self:MakePopup()
	self:SetKeyboardInputEnabled(true)

	self.builtPanels = {}

	self.tabs = self:Add("Panel")
	self.tabs:SetWide(TAB_WIDTH)
	self.tabs:Dock(LEFT)
	self.tabs:DockMargin(1, 1, 1, 1)
	self.tabs.buttons = {}

	self.content = self:Add("Panel")
	self.content:Dock(FILL)
	self.content:DockMargin(1, 1, 1, 1)
	self.content.Paint = function() end

	self:PopulateTabs()
end

function PANEL:AddTabButton(key)
	local button = self.tabs:Add("metroMenuSelectionButton")
	button:SetText(string.upper(L(key)))
	button:Dock(TOP)
	button:SizeToContents()
	button:SetButtonList(self.tabs.buttons)
	button.key = key
	button.OnSelected = function()
		self:SelectTab(key)
	end

	return button
end

function PANEL:SelectTab(key)
	local info = self.tabInfo[key]

	if not info then
		return
	end

	if not self.builtPanels[key] then
		local built = info.Create(self.content)
		built:SetParent(self.content)
		built:Dock(FILL)

		self.builtPanels[key] = built
	end

	for otherKey, panel in pairs(self.builtPanels) do
		if IsValid(panel) then
			panel:SetVisible(otherKey == key)
		end
	end
end

function PANEL:PopulateTabs()
	self.tabInfo = {}

	hook.Run("CreateMenuButtons", self.tabInfo)

	local keys = METRO.Format.SortedKeys(self.tabInfo)

	local firstButton

	for _, key in ipairs(keys) do
		local button = self:AddTabButton(key)
		firstButton = firstButton or button
	end

	if IsValid(firstButton) then
		firstButton:SetSelected(true)
	end
end

function PANEL:Paint(width, height)
	derma.SkinFunc("PaintMenuBackground", self, width, height)
end

function PANEL:OnKeyCodePressed(key)
	if key == KEY_ESCAPE then
		self:Remove()
	end
end

function PANEL:OnRemove()
	if menu == self then
		menu = nil
	end
end

vgui.Register("metroMenu", PANEL, "EditablePanel")

local function ToggleMenu()
	if IsValid(menu) then
		menu:Remove()
		return
	end

	menu = vgui.Create("metroMenu")
end

METRO.Menu.Toggle = ToggleMenu

hook.Add("PlayerBindPress", "METRO_MenuKeybind", function(ply, bind, pressed)
	if not pressed or bind ~= "gm_showspare2" or ply:IsTyping() then
		return
	end

	ToggleMenu()
	return true
end)

hook.Add("MetroStatsUpdated", "METRO_MenuRefresh", function()
	if not IsValid(menu) then
		return
	end

	for _, panel in pairs(menu.builtPanels) do
		if IsValid(panel) and panel.Refresh then
			panel.Refresh()
		end
	end
end)
