--thanks to Dom for bravely diving into this mod's code and fixing stuff in Better Assault Indicators mod

Hooks:PostHook(HUDAssaultCorner,"init","noblehud_assaultcorner_init",function(self,hud,full_hud,tweak_hud)
	self._hud_panel:hide()
	self._hostages_bg_box:hide()
	self._hud_panel:child("hostages_panel"):set_y(-100)
	self._hud_panel:child("hostages_panel"):set_alpha(0)
	if alive(self._hud_panel:child("wave_panel")) then 
		self._hud_panel:child("wave_panel"):hide()
	end
--	NobleHUD:ShowWaveNumber(self:should_display_waves())
--yeah turns out hudassault is created before noblehud
end)

function HUDAssaultCorner:set_control_info(data)
	NobleHUD:SetHostages(data.nr_hostages)
end


function HUDAssaultCorner:show_casing(mode)

	NobleHUD:log("Casing mode: " .. tostring(mode),{color=Color.yellow})
	if mode == "civilian" then 
		NobleHUD:SetAssaultPhase(managers.localization:text("noblehud_hud_civilian_mode"),false)
	else
		NobleHUD:SetAssaultPhase(managers.localization:text("noblehud_hud_casing_mode"))
	end
	self:_end_assault()
	self._casing = true
end

function HUDAssaultCorner:_start_assault(text_list)

	local started_now = not self._assault
	self._assault = true

	if managers.skirmish:is_skirmish() and started_now then
		self:_popup_wave_started()
	end
	--assault panel: show wave info
end

function HUDAssaultCorner:_end_assault()
	if not self._assault then
		return
	end

	self:_set_feedback_color(nil) --i wish my keyboard supported assault colors lol

	self._assault = false

	if self:should_display_waves() then
		self:_update_assault_hud_color(self._assault_survived_color)
		self:_set_text_list(self:_get_survived_assault_strings())
		local wave_max
		local wave_current
		if self._max_waves < math.huge then 
			wave_current = managers.network:session():is_host() and managers.groupai:state():get_assault_number() or self._wave_number
			wave_max = self._max_waves
		end
		NobleHUD:SetWaveNumber(wave_current,wave_max)
		
		if managers.skirmish:is_skirmish() then
			self:_popup_wave_finished()
		else
			NobleHUD:AddQueuedObjective({
				mode = "wave",
				id = "noblehud_assault_wave",
				color = self._current_assault_color,
				amount = wave_max,
				current_amount = wave_current,
				text = self:wave_popup_string_end()
			})
		end
	end
end

function HUDAssaultCorner:feed_point_of_no_return_timer(time, is_inside)
	NobleHUD:SetPONR(time) --time formatting is done inside SetPONR()
end

function HUDAssaultCorner:show_point_of_no_return_timer()
	NobleHUD:ShowPONR()

	self:_set_feedback_color(self._noreturn_color)

	self._point_of_no_return = true
end

function HUDAssaultCorner:hide_point_of_no_return_timer()
	NobleHUD:HidePONR()
	
	self._point_of_no_return = false
	self:_set_feedback_color(nil)
end

function HUDAssaultCorner:flash_point_of_no_return_timer(beep)
--	NobleHUD:AnimatePONRFlash(beep)
end


function HUDAssaultCorner:_popup_wave(text, color)
	NobleHUD:AddQueuedObjective({
		mode = "wave",
		id = "noblehud_assault_wave",
		color = color,
--		amount = total_wave,
--		current_amount = current_wave,
		text = text
	})
	
	--[[
--	NobleHUD:AddQueuedObjective({ mode = "wave", id = "noblehud_assault_wave", color = color, text = "butts!"})	
	local preset = NobleHUD._killfeed_presets.wave
	--i don't care about preserving the preset color
	color = color or Color.green
	local flash_color = Color(color.red + 0.5,color.green + 0.5,color.blue + 0.5):with_alpha(1)
	preset.color_1 = color:with_alpha(1)
	preset.color_2 = flash_color
	NobleHUD:AddKillfeedMessage(text,preset)
	--]]
end

function HUDAssaultCorner:_show_hostages()
end

function HUDAssaultCorner:_hide_hostages()
	self._hud_panel:child("hostages_panel"):hide()
end

function HUDAssaultCorner:set_buff_enabled(buff_name, enabled) --winters dmg resist buff for cops; other captains in resmod
	NobleHUD:log("ASSAULTCORNER: Buff enabled [" .. tostring(buff_name) .. "]: " .. tostring(enabled))
--	self:AddBuff("phalanx") --todo; this will display an icon 
end

function HUDAssaultCorner:sync_set_assault_mode(mode) --from host
	if self._assault_mode == mode then 
		return 
	end
	NobleHUD:log("HUDAssaultCorner:sync_set_assault_mode(" .. tostring(mode) .. ")",{color=Color.yellow})
	self._assault_mode = mode
	if mode == "phalanx" then 
		color = self._vip_assault_color
		NobleHUD:SetAssaultPhase(managers.localization:text(NobleHUD._assault_phases.phalanx))
	end
	
	self:_update_assault_hud_color(color)
	
end

function HUDAssaultCorner:set_assault_wave_number(assault_number)
	self._wave_number = assault_number
	NobleHUD:SetWaveNumber(assault_number,self._max_waves)
end
