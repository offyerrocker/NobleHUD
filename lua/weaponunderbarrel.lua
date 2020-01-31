--not hooked atm
Hooks:PostHook(WeaponUnderbarrel,"check_state","noblehud_check_underbarrel_gadget",function(self)
	if self._is_npc then
		return
	end
	if self._deployed and self._setup.user_unit == managers.player:player_unit() then
		--todo
	end
end)