function HUDPresenter:present(params)
--	self:log("Presenting: title: " .. tostring(params.title) .. " | text: " .. tostring(params.text) .. " | sound: " .. tostring(params.event))
	if params.text then 
		NobleHUD:AddKillfeedMessage("> " .. tostring(params.text),NobleHUD._killfeed_presets.presenter_desc)
	end
	if params.title then
		NobleHUD:AddKillfeedMessage("  " .. tostring(params.title),NobleHUD._killfeed_presets.presenter_title)
	end
	--todo alternate presentation
end