Hooks:PostHook(HUDStatsScreen,"init","noblehud_hudstats_init",function(self)
	--todo Lobby Player Info support
end)

Hooks:PostHook(HUDStatsScreen,"recreate_left","noblehud_hudstats_recreateleft",function(self)
	
end)

Hooks:PostHook(HUDStatsScreen,"recreate_right","noblehud_hudstats_recreateright",function(self)
	
end)

function HUDStatsScreen:show()
	NobleHUD:AnimateShowTabscreen()
--	NobleHUD:ShowTabscreen()
--[[
	self:recreate_left()
	self:recreate_right()

	local safe = managers.hud.STATS_SCREEN_SAFERECT
	local full = managers.hud.STATS_SCREEN_FULLSCREEN

	managers.hud:show(full)

	local left_panel = self._left
	local right_panel = self._right
	local bottom_panel = self._bottom

	left_panel:stop()

	local teammates_panel = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2).panel:child("teammates_panel")
	local objectives_panel = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2).panel:child("objectives_panel")
	local chat_panel = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2).panel:child("chat_panel")

	left_panel:animate(callback(self, self, "_animate_show_stats_left_panel"), right_panel, bottom_panel, teammates_panel, objectives_panel, chat_panel)
	--]]
end

function HUDStatsScreen:hide()
	NobleHUD:AnimateHideTabscreen()
--	NobleHUD:HideTabscreen()
	--[[
	local left_panel = self._left
	local right_panel = self._right
	local bottom_panel = self._bottom

	left_panel:stop()

	local teammates_panel = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2).panel:child("teammates_panel")
	local objectives_panel = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2).panel:child("objectives_panel")
	local chat_panel = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2).panel:child("chat_panel")

	left_panel:animate(callback(self, self, "_animate_hide_stats_left_panel"), right_panel, bottom_panel, teammates_panel, objectives_panel, chat_panel)
--]]
end