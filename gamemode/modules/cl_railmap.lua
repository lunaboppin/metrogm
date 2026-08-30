METRO.Railmap = METRO.Railmap or {}

local LENS_COLORS = {
	r = Color(235, 70, 70),
	y = Color(240, 190, 70),
	g = Color(90, 210, 110),
	b = Color(90, 150, 240),
	w = Color(235, 235, 235),
}

local UNKNOWN_COLOR = Color(130, 130, 130)
local TRACK_COLOR = Color(110, 118, 130)
local PLATFORM_COLOR = Color(80, 90, 105)
local SWITCH_MAIN = Color(150, 160, 175)
local SWITCH_ALT = Color(225, 160, 90)
local TRAIN_COLOR = Color(120, 200, 255)

local LABEL_ZOOM = 0.055
local ENTITY_REFRESH = 1

local entityCache = { signals = {}, switches = {}, platforms = {}, at = 0 }

function METRO.Railmap.AspectOf(entity)
	local sig = entity:GetNW2String("Signal", "")
	local lenses = entity.LensesTBL

	if sig == "" or type(lenses) ~= "table" then
		return UNKNOWN_COLOR, false
	end

	for index = 1, #sig do
		local state = string.sub(sig, index, index)
		if state == "1" or state == "2" then
			local letter = string.lower(tostring(lenses[index] or ""))
			return LENS_COLORS[letter] or UNKNOWN_COLOR, state == "2"
		end
	end

	return UNKNOWN_COLOR, false
end

function METRO.Railmap.RefreshEntities()
	entityCache.signals = ents.FindByClass("gmod_track_signal")
	entityCache.switches = ents.FindByClass("gmod_track_switch")
	entityCache.platforms = ents.FindByClass("gmod_track_platform")
	entityCache.at = CurTime()
end

function METRO.Railmap.Entities()
	if CurTime() - entityCache.at > ENTITY_REFRESH then
		METRO.Railmap.RefreshEntities()
	end
	return entityCache
end

function METRO.Railmap.OwnTrain()
	local ply = LocalPlayer()
	if not IsValid(ply) then
		return nil
	end

	local vehicle = ply:GetVehicle()
	if IsValid(vehicle) then
		local train = vehicle:GetNW2Entity("TrainEntity")
		if IsValid(train) then
			return train
		end
	end

	return nil
end

local PANEL = {}

function PANEL:Init()
	self.zoom = 0.02
	self.panX = 0
	self.panY = 0
	self.fitted = false
	self.data = METRO.RailmapData.Load()
	METRO.Railmap.RefreshEntities()

	hook.Add("MetroRailmapTrackLoaded", self, function()
		self.data = METRO.RailmapData.Load()
		self.fitted = false
	end)
end

function PANEL:FitToBounds()
	local bounds = self.data.bounds
	if not bounds then
		return
	end

	local w, h = self:GetSize()
	local spanX = math.max(bounds.maxX - bounds.minX, 1)
	local spanY = math.max(bounds.maxY - bounds.minY, 1)

	self.zoom = math.min(w / spanX, h / spanY) * 0.9
	self.panX = (bounds.minX + bounds.maxX) * 0.5
	self.panY = (bounds.minY + bounds.maxY) * 0.5
	self.fitted = true
end

function PANEL:WorldToScreen(x, y)
	local w, h = self:GetSize()
	return w * 0.5 + (x - self.panX) * self.zoom, h * 0.5 - (y - self.panY) * self.zoom
end

function PANEL:ScreenToWorld(sx, sy)
	local w, h = self:GetSize()
	return self.panX + (sx - w * 0.5) / self.zoom, self.panY - (sy - h * 0.5) / self.zoom
end

function PANEL:OnMouseWheeled(delta)
	local factor = delta > 0 and 1.15 or 1 / 1.15
	self.zoom = math.Clamp(self.zoom * factor, 0.002, 0.5)
	return true
end

function PANEL:OnMousePressed(code)
	if code == MOUSE_LEFT then
		local signal = self:SignalUnderCursor()
		if signal then
			METRO.Railmap.ClickSignal(signal)
			return
		end

		self.dragging = true
		self.dragX, self.dragY = gui.MousePos()
	end
end

function PANEL:OnMouseReleased()
	self.dragging = false
end

function PANEL:Think()
	if not self.dragging then
		return
	end

	local mx, my = gui.MousePos()
	self.panX = self.panX - (mx - self.dragX) / self.zoom
	self.panY = self.panY + (my - self.dragY) / self.zoom
	self.dragX, self.dragY = mx, my
end

function PANEL:SignalUnderCursor()
	local mx, my = self:CursorPos()
	local best, bestDistance

	for _, signal in ipairs(METRO.Railmap.Entities().signals) do
		if IsValid(signal) then
			local pos = signal:GetPos()
			local sx, sy = self:WorldToScreen(pos.x, pos.y)
			local distance = math.sqrt((sx - mx) ^ 2 + (sy - my) ^ 2)
			if distance < 10 and (not bestDistance or distance < bestDistance) then
				best, bestDistance = signal, distance
			end
		end
	end

	return best
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(22, 24, 28)
	surface.DrawRect(0, 0, w, h)

	if not self.data.available then
		draw.SimpleText(L("railmapNoData"), "MetroDashboardTitle", w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		return
	end

	if not self.fitted then
		self:FitToBounds()
	end

	surface.SetDrawColor(TRACK_COLOR)
	for _, path in ipairs(self.data.paths) do
		local px, py = self:WorldToScreen(path[1].x, path[1].y)
		for index = 2, #path do
			local nx, ny = self:WorldToScreen(path[index].x, path[index].y)
			surface.DrawLine(px, py, nx, ny)
			px, py = nx, ny
		end
	end

	local cache = METRO.Railmap.Entities()
	local showLabels = self.zoom > LABEL_ZOOM

	for _, platform in ipairs(cache.platforms) do
		if IsValid(platform) then
			local pos = platform:GetPos()
			local sx, sy = self:WorldToScreen(pos.x, pos.y)
			surface.SetDrawColor(PLATFORM_COLOR)
			surface.DrawRect(sx - 4, sy - 4, 8, 8)
		end
	end

	for _, switch in ipairs(cache.switches) do
		if IsValid(switch) then
			local pos = switch:GetPos()
			local sx, sy = self:WorldToScreen(pos.x, pos.y)
			local alt = switch.GetSignal and switch:GetSignal() ~= 0
			surface.SetDrawColor(alt and SWITCH_ALT or SWITCH_MAIN)
			surface.DrawRect(sx - 3, sy - 3, 6, 6)

			if showLabels then
				local id = switch:GetNW2String("ID", "")
				if id ~= "" then
					draw.SimpleText(id, "MetroDashboardBody", sx + 6, sy, SWITCH_MAIN, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
			end
		end
	end

	for _, signal in ipairs(cache.signals) do
		if IsValid(signal) then
			local pos = signal:GetPos()
			local sx, sy = self:WorldToScreen(pos.x, pos.y)
			local color, blinking = METRO.Railmap.AspectOf(signal)

			if not blinking or math.sin(CurTime() * 6) > 0 then
				surface.SetDrawColor(color)
				surface.DrawRect(sx - 3, sy - 3, 7, 7)
			end

			if showLabels and signal.Name and signal.Name ~= "" then
				draw.SimpleText(signal.Name, "MetroDashboardBody", sx + 7, sy, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
		end
	end

	local train = METRO.Railmap.OwnTrain()
	if IsValid(train) then
		local pos = train:GetPos()
		local sx, sy = self:WorldToScreen(pos.x, pos.y)
		local yaw = math.rad(train:GetAngles().y)
		surface.SetDrawColor(TRAIN_COLOR)
		surface.DrawLine(sx, sy, sx + math.cos(yaw) * 14, sy - math.sin(yaw) * 14)
		surface.DrawRect(sx - 4, sy - 4, 9, 9)
	end
end

vgui.Register("metroRailmap", PANEL, "EditablePanel")

local pendingSignal

function METRO.Railmap.ClickSignal(signal)
	local ply = LocalPlayer()
	if not IsValid(ply) or not ply:IsAdmin() then
		return
	end

	pendingSignal = signal
	net.Start("MetroRailmapRoutes")
	net.WriteUInt(signal:EntIndex(), 16)
	net.SendToServer()
end

local function sendOpen(signal, routeName)
	net.Start("MetroRailmapOpen")
	net.WriteUInt(signal:EntIndex(), 16)
	net.WriteString(routeName or "")
	net.SendToServer()
end

local function sendClose(signal, routeName)
	net.Start("MetroRailmapClose")
	net.WriteUInt(signal:EntIndex(), 16)
	net.WriteString(routeName or "")
	net.SendToServer()
end

net.Receive("MetroRailmapRoutes", function()
	local signal = pendingSignal
	pendingSignal = nil

	if not IsValid(signal) then
		return
	end

	local index = net.ReadUInt(16)
	if not net.ReadBool() then
		return
	end

	if signal:EntIndex() ~= index then
		signal = Entity(index)
		if not IsValid(signal) then
			return
		end
	end

	local routes = {}
	for _ = 1, net.ReadUInt(8) do
		routes[#routes + 1] = {
			index = net.ReadUInt(8),
			name = net.ReadString(),
			destination = net.ReadString(),
		}
	end

	local color = METRO.Railmap.AspectOf(signal)
	local isOpen = color ~= UNKNOWN_COLOR and color ~= LENS_COLORS.r

	if #routes <= 1 then
		if isOpen then
			sendClose(signal)
		else
			sendOpen(signal, routes[1] and routes[1].name or nil)
		end
		return
	end

	local menu = DermaMenu()
	menu:AddOption(L("railmapCloseSignal"), function() sendClose(signal) end)
	menu:AddSpacer()

	for _, route in ipairs(routes) do
		local label = route.destination ~= "" and route.destination or route.name
		menu:AddOption(L("railmapOpenRoute", label), function() sendOpen(signal, route.name) end)
	end

	menu:Open()
end)
