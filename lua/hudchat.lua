
Hooks:PostHook(HUDChat,"init","noblehud_init_hudchat",function(self,ws, hud)
--	self._output_width = 200
	self._panel:set_x(hud.panel:w() - self._panel:w() + - 16)
	--[[
	self._panel:child("output_panel"):child("output_bg"):set_gradient_points({
		0,
		Color.white:with_alpha(0),
		mid,
		Color.white:with_alpha(0.25),
		1,
		Color.white:with_alpha(0)
	})
	--]]
	
end)
