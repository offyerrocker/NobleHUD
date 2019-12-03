--at the moment, pretty much everything in this file is just about disabling the vanilla assault panel

Hooks:PostHook(HUDAssaultCorner,"init","noblehud_assaultcorner_init",function(self,hud,full_hud,tweak_hud)
	self._hud_panel:hide()
	self._hostages_bg_box:hide()
	self._hud_panel:child("hostages_panel"):set_y(-100)
	self._hud_panel:child("hostages_panel"):set_alpha(0)
end)

function HUDAssaultCorner:_show_hostages()
	if not self._point_of_no_return then
--		self._hud_panel:child("hostages_panel"):show()
	end
end

function HUDAssaultCorner:_hide_hostages()
	self._hud_panel:child("hostages_panel"):hide()
end

function HUDAssaultCorner:set_buff_enabled(buff_name, enabled) --winters dmg resist buff for cops; other captains in resmod
--	self:log("Buff enabled [" .. tostring(buff_name) .. "]: " .. tostring(enabled))
end

function HUDAssaultCorner:sync_set_assault_mode(mode) --from host
	--[[
	if self._assault_mode == mode then
		return
	end
	self:log("Changed to assault mode " .. tostring(mode))
	self._assault_mode = mode
	local color = self._assault_color

	if mode == "phalanx" then
		color = self._vip_assault_color
	end

	self:_update_assault_hud_color(color)
	self:_set_text_list(self:_get_assault_strings())

	local assault_panel = self._hud_panel:child("assault_panel")
	local icon_assaultbox = assault_panel:child("icon_assaultbox")
	local image = mode == "phalanx" and "guis/textures/pd2/hud_icon_padlockbox" or "guis/textures/pd2/hud_icon_assaultbox"

	icon_assaultbox:set_image(image)
--]]
end

function HUDAssaultCorner:set_assault_wave_number(assault_number)
	self._wave_number = assault_number
	--[[
	local panel = self._hud_panel:child("wave_panel")

	if alive(self._wave_bg_box) and panel then
		local wave_text = panel:child("num_waves")

		if wave_text then
			wave_text:set_text(self:get_completed_waves_string())
		end
	end
	
	--]]
end

function HUDAssaultCorner:_start_assault(text_list)
--[[
	text_list = text_list or {
		""
	}
	local assault_panel = self._hud_panel:child("assault_panel")
	local text_panel = assault_panel:child("text_panel")

	self:_set_text_list(text_list)

	local started_now = not self._assault
	self._assault = true

	if self._bg_box:child("text_panel") then
		self._bg_box:child("text_panel"):stop()
		self._bg_box:child("text_panel"):clear()
	else
		self._bg_box:panel({
			name = "text_panel"
		})
	end

	self._bg_box:child("bg"):stop()
	assault_panel:set_visible(true)

	local icon_assaultbox = assault_panel:child("icon_assaultbox")

	icon_assaultbox:stop()
	icon_assaultbox:animate(callback(self, self, "_show_icon_assaultbox"))

	local config = {
		attention_forever = true,
		attention_color = self._assault_color,
		attention_color_function = callback(self, self, "assault_attention_color_function")
	}

	self._bg_box:stop()
	self._bg_box:animate(callback(nil, _G, "HUDBGBox_animate_open_left"), 0.75, self._bg_box_size, function ()
	end, config)

	local box_text_panel = self._bg_box:child("text_panel")

	box_text_panel:stop()
	box_text_panel:animate(callback(self, self, "_animate_text"), nil, nil, callback(self, self, "assault_attention_color_function"))
	self:_set_feedback_color(self._assault_color)

	if alive(self._wave_bg_box) then
		self._wave_bg_box:stop()
		self._wave_bg_box:animate(callback(self, self, "_animate_wave_started"), self)
	end

	if managers.skirmish:is_skirmish() and started_now then
		self:_popup_wave_started()
	end
	--]]
end

