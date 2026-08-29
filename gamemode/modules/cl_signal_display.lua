if not CLIENT then
	return
end

METRO.SignalDisplay = METRO.SignalDisplay or {}

local display = METRO.SignalDisplay
local signalNames = GetConVar("metro_signal_names") or CreateClientConVar(
	"metro_signal_names",
	"1",
	true,
	false,
	L("signalDisplayCvarHelp")
)

local signalClass = "gmod_track_signal"
local refreshTimer = "METRO_SignalNameDisplayRefresh"
local drawHook = "METRO_SignalNameDisplayDraw"
local maxDistance = 2400
local maxDistanceSqr = maxDistance * maxDistance
local fadeStart = 1400
local faceDot = 0.25
local viewDot = 0.15
local refreshInterval = 0.2
local displayScale = 0.25
local displayOffset = Vector(48, 0, 150)
local visibleSignals = {}
local textColor = Color(255, 255, 255, 255)
local outlineColor = Color(0, 0, 0, 255)

local function IsFacingSignal(signalAngle, signalPosition, eyePosition, viewDirection)
	local toSignal = signalPosition - eyePosition
	local distanceSqr = toSignal:LengthSqr()

	if distanceSqr > maxDistanceSqr or distanceSqr <= 0 then
		return false, 0
	end

	local distance = math.sqrt(distanceSqr)
	local direction = toSignal / distance

	if signalAngle:Forward():Dot(direction) < faceDot or viewDirection:Dot(direction) < viewDot then
		return false, distance
	end

	return true, distance
end

local function IsUnobstructed(signal, eyePosition, signalPosition)
	local trace = util.TraceLine({
		start = eyePosition,
		endpos = signalPosition,
		filter = LocalPlayer(),
		mask = MASK_VISIBLE,
	})

	return not trace.Hit or trace.Entity == signal
end

local function RefreshVisibleSignals()
	if not signalNames:GetBool() then
		visibleSignals = {}
		return
	end

	local client = LocalPlayer()
	if not IsValid(client) then
		visibleSignals = {}
		return
	end

	local eyePosition = EyePos()
	local viewDirection = EyeAngles():Forward()
	local refreshed = {}

	for _, signal in ipairs(ents.FindByClass(signalClass)) do
		if IsValid(signal) and not signal:IsDormant() and isstring(signal.Name) and signal.Name ~= "" then
			local signalPosition = signal:LocalToWorld(displayOffset)
			local signalAngle = signal:LocalToWorldAngles(Angle(0, 180, 90))
			local facing, distance = IsFacingSignal(signalAngle, signalPosition, eyePosition, viewDirection)

			if facing and IsUnobstructed(signal, eyePosition, signalPosition) then
				local fade = 1
				if distance > fadeStart then
					fade = 1 - math.Clamp((distance - fadeStart) / (maxDistance - fadeStart), 0, 1)
				end

				if fade > 0 then
					refreshed[#refreshed + 1] = {
						entity = signal,
						position = signalPosition,
						angle = signalAngle,
						text = L("signalDisplayName", signal.Name),
						alpha = fade,
					}
				end
			end
		end
	end

	visibleSignals = refreshed
end

local function DrawVisibleSignals()
	for _, entry in ipairs(visibleSignals) do
		if IsValid(entry.entity) then
			textColor.a = entry.alpha * 255
			outlineColor.a = entry.alpha * 255
			cam.Start3D2D(entry.position, entry.angle, displayScale)
			draw.SimpleTextOutlined(entry.text, "MetroLabelFont", 0, 0, textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, outlineColor)
			cam.End3D2D()
		end
	end
end

local function DisableDisplay()
	timer.Remove(refreshTimer)
	hook.Remove("PostDrawTranslucentRenderables", drawHook)
	visibleSignals = {}
	display.active = false
end

local function EnableDisplay()
	if display.active then
		return
	end

	display.active = true
	timer.Create(refreshTimer, refreshInterval, 0, RefreshVisibleSignals)
	hook.Add("PostDrawTranslucentRenderables", drawHook, function(depth, skybox)
		if depth or skybox then
			return
		end

		DrawVisibleSignals()
	end)
end

local function ApplyDisplayState()
	if signalNames:GetBool() then
		EnableDisplay()
	else
		DisableDisplay()
	end
end

function display.IsEnabled()
	return signalNames:GetBool()
end

function display.SetEnabled(enabled)
	signalNames:SetBool(enabled and 1 or 0)
	ApplyDisplayState()
end

concommand.Add("metro_toggle_signal_names", function()
	local enabled = not signalNames:GetBool()
	display.SetEnabled(enabled)
	chat.AddText(Color(80, 170, 255), L(enabled and "signalDisplayEnabled" or "signalDisplayDisabled"))
end)

cvars.AddChangeCallback("metro_signal_names", function()
	ApplyDisplayState()
end, "METRO_SignalNameDisplayState")

ApplyDisplayState()
