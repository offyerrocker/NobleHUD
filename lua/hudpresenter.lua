--[[

Hooks:PostHook(HUDPresenter,"init","noblehud_presenterinit",function(self,hud)
	local present_panel = self._hud_panel:child("present_panel")
	present_panel:hide()
end)
--return managers.hud._hud_presenter._hud_panel:child("present_panel"):hide()

--]]

function HUDPresenter:present(params)
	Log("Presenting: title: " .. tostring(params.title) .. " | text: " .. tostring(params.text) .. " | sound: " .. tostring(params.event))
	if params.text then 
		NobleHUD:AddKillfeedMessage("> " .. tostring(params.text),NobleHUD._hudpresenter_params)
	end
	--todo alternate presentation
end