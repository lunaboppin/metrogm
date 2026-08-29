local ANIMATION_TIME = 0.35
local NOTICE_DURATION = 6
local NOTICE_WIDTH = 280
local NOTICE_HEIGHT = 36
local NOTICE_PADDING = 6

local PANEL = {}

function PANEL:Init()
	self:SetSkin("metro")
	self:SetSize(ScrW() * 0.3, ScrH())
	self:SetPos(ScrW() - ScrW() * 0.3, 0)
	self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)
	self:ParentToHUD()

	self.notices = {}
end

function PANEL:AddNotice(text)
	local notice = self:Add("metroNotice")
	notice:SetText(text)
	notice:SetSize(NOTICE_WIDTH, NOTICE_HEIGHT)
	notice:SetAlpha(0)
	notice:CreateAnimation(ANIMATION_TIME, {
		target = {alpha = 255},
	})

	table.insert(self.notices, 1, notice)
	self:Organize()

	timer.Simple(NOTICE_DURATION, function()
		self:RemoveNotice(notice)
	end)

	return notice
end

function PANEL:RemoveNotice(notice)
	if not IsValid(notice) then
		return
	end

	notice:CreateAnimation(ANIMATION_TIME, {
		target = {alpha = 0},
		OnComplete = function()
			local index

			for i, other in ipairs(self.notices) do
				if other == notice then
					index = i
				end
			end

			if index then
				table.remove(self.notices, index)
			end

			notice:Remove()
			self:Organize()
		end,
	})
end

function PANEL:Organize()
	local currentY = NOTICE_PADDING

	for _, notice in ipairs(self.notices) do
		notice:SetPos(self:GetWide() - notice:GetWide() - NOTICE_PADDING, currentY)
		currentY = currentY + notice:GetTall() + NOTICE_PADDING
	end
end

vgui.Register("metroNoticeManager", PANEL, "Panel")

PANEL = {}

AccessorFunc(PANEL, "text", "Text", FORCE_STRING)

function PANEL:Init()
	self:SetSkin("metro")

	self.text = ""
end

function PANEL:Paint(width, height)
	surface.SetDrawColor(20, 20, 20, self:GetAlpha())
	surface.DrawRect(0, 0, width, height)

	surface.SetDrawColor(METRO.UI.GetAccentColor().r, METRO.UI.GetAccentColor().g, METRO.UI.GetAccentColor().b, self:GetAlpha())
	surface.DrawOutlinedRect(0, 0, width, height)

	surface.SetFont("MetroNoticeFont")
	surface.SetTextColor(255, 255, 255, self:GetAlpha())
	surface.SetTextPos(8, height * 0.5 - select(2, surface.GetTextSize(self.text)) * 0.5)
	surface.DrawText(self.text)
end

vgui.Register("metroNotice", PANEL, "Panel")

local manager

hook.Add("InitPostEntity", "METRO_CreateNoticeManager", function()
	if IsValid(manager) then
		manager:Remove()
	end

	manager = vgui.Create("metroNoticeManager")
end)

function METRO.Lang.ReceiveNotify(text)
	if IsValid(manager) then
		manager:AddNotice(text)
		return
	end

	print("[metro] " .. text)
end
