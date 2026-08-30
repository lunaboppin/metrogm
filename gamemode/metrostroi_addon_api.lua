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
