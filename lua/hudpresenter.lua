function HUDPresenter:present(params)
--	self:log("Presenting: title: " .. tostring(params.title) .. " | text: " .. tostring(params.text) .. " | sound: " .. tostring(params.event))
	if params.text then 
		NobleHUD:AddKillfeedMessage("> " .. tostring(params.text),NobleHUD._presenter_desc_params)
	end
	if params.title then
		NobleHUD:AddKillfeedMessage("  " .. tostring(params.title),NobleHUD._presenter_title_params)
	end
	--todo alternate presentation
end