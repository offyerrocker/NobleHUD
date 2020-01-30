Hooks:PostHook(HUDWaitingLegend,"init","noblehud_playerwaiting_init",function(self,hud)
	
end)


Hooks:PreHook(HUDWaitingLegend,"turn_off","noblehud_playerwaiting_hidelegend",function(self)
--	local id = self._panel._id
--	local panel = NobleHUD:GetTeammatePanel(id)
--	panel:hide()
	--local id = teammate_hud._id
	--:hide()
	NobleHUD._waiting_panel:hide()
end)


Hooks:PostHook(HUDWaitingLegend,"show_on","noblehud_playerwaiting_showlegend",function(self,teammate_hud,peer)

	local panel_id = managers.hud:get_waiting_index(self._current_peer:id()) or NobleHUD:GetPanelIdFromPeerId(self._current_peer:id())

	local teammate_panel = NobleHUD:GetTeammatePanel(panel_id)
	local panel = NobleHUD._waiting_panel
	panel:show()
	if teammate_panel then 
		panel:set_x(NobleHUD._teammates_panel:x() + teammate_panel:x())
		panel:set_y(NobleHUD._teammates_panel:y())
	end
end)

function HUDWaitingLegend:update_buttons()
	local panel = NobleHUD._waiting_panel
	local waiting_text = panel:child("waiting_text")

	local str = ""

	for k, btn in pairs(self._all_buttons) do
		local button_text = managers.localization:btn_macro(btn.binding, true, true)

		if button_text then
			str = str .. (str == "" and "" or "  ") .. managers.localization:text(btn.text, {MY_BTN = button_text})
		end
	end

	if str == "" then
		str = managers.localization:text("hud_waiting_no_binding_text")
	end

	waiting_text:set_text("  " .. str .. "  ")
--	managers.hud:make_fine_text(self._btn_text)
--	panel:set_w(self._btn_text:w())
--	panel:set_h(self._btn_text:bottom() + PADDING)
--[[
	if self._box then
		self._btn_panel:remove(self._box)

		self._box = nil
	end

	self._box = HUDBGBox_create(self._btn_panel)

	if not self._panel:visible() then
		self:animate_open()
	end
	self._panel:set_visible(true)
--]]
	panel:show()
end