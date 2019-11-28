Hooks:PostHook(HUDHeistTimer,"init","noblehud_heisttimer_init",function(self,hud, tweak_hud)
	self._timer_text:hide()
--[[
	if self._hud_panel:child("heist_timer_panel") then
		self._hud_panel:remove(self._hud_panel:child("heist_timer_panel"))
	end

	self._heist_timer_panel = self._hud_panel:panel({
		y = 0,
		name = "heist_timer_panel",
		h = 40,
		visible = true,
		layer = 0,
		valign = "top"
	})
	self._timer_text = self._heist_timer_panel:text({
		name = "timer_text",
		vertical = "top",
		word_wrap = false,
		wrap = false,
		font_size = 28,
		align = "center",
		text = "00:00",
		layer = 1,
		font = tweak_data.hud.medium_font_noshadow,
		color = Color.white
	})
	self._last_time = 0
	self._enabled = not tweak_hud.no_timer

	if not self._enabled then
		self._heist_timer_panel:hide()
	end
	--]]
end)
