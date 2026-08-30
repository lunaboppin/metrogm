Metrostroi.SARMATLangs = Metrostroi.SARMATLangs or {}

if not Metrostroi.AddSARMATLang then
	function Metrostroi.AddSARMATLang(lang, mslang, tbl)
		if not tbl then return end

		for k, v in pairs(Metrostroi.SARMATLangs) do
			if v.lang == lang then
				Metrostroi.SARMATLangs[k] = tbl
				Metrostroi.SARMATLangs[k].lang = lang
				Metrostroi.SARMATLangs[k].mslang = mslang
				return
			end
		end

		local id = table.insert(Metrostroi.SARMATLangs, tbl)
		Metrostroi.SARMATLangs[id].lang = lang
		Metrostroi.SARMATLangs[id].mslang = mslang
	end
end

Metrostroi.CISConfig = Metrostroi.CISConfig or {}

if CLIENT and not vgui.MetrostroiDrawCutText then
	local WRAP_WIDTH = 390

	local function drawLine(panel, text, color, font)
		local label = vgui.Create("DLabel", panel)
		label:Dock(TOP)
		label:SetFont(font or "DermaDefault")
		label:SetTextColor(color or Color(0, 0, 0))
		label:SetText(text or "N\\A")
		label:DockMargin(0, -4, 0, -4)
		label:DockPadding(0, -4, 0, -4)
	end

	function vgui.MetrostroiDrawCutText(panel, text, color, font)
		if text:find("\n") then
			for _, line in pairs(string.Explode("\n", text)) do
				vgui.MetrostroiDrawCutText(panel, line, color, font)
			end
			return
		end

		surface.SetFont(font or "DermaDefault")

		local doneText, width = "", 0
		for _, word in pairs(string.Explode(" ", text)) do
			local wordWidth = surface.GetTextSize(word)
			if width + wordWidth < WRAP_WIDTH then
				doneText = doneText .. " " .. word
				width = width + wordWidth
			elseif width ~= 0 then
				drawLine(panel, doneText, color, font)
				doneText = word
				width = wordWidth
			else
				doneText = word
				width = wordWidth
				break
			end
		end

		if #doneText > 0 and width > WRAP_WIDTH then
			local from = 1
			for to = 1, #doneText do
				if surface.GetTextSize(doneText:sub(from, to)) > WRAP_WIDTH then
					drawLine(panel, doneText:sub(from, to - 1), color, font)
					doneText = doneText:sub(to, -1)
				end
			end
		end

		if #doneText > 0 then
			drawLine(panel, doneText, color, font)
		end
	end
end
