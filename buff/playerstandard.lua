Hooks:PostHook(PlayerStandard,"_start_action_reload_enter","noblehud_buff_lock_n_load_remove",function(self,t)
	NobleHUD:RemoveBuff("lock_n_load")
end)

Hooks:PostHook(PlayerStandard,"_update_omniscience","noblehud_buff_sixth_sense",function(self,t,dt)
	if managers.player:has_category_upgrade("player", "standstill_omniscience") then 
		if self._state_data.omniscience_t then 
			NobleHUD:AddBuff("sixth_sense",{end_t = self._state_data.omniscience_t})
		else
			NobleHUD:RemoveBuff("sixth_sense")		
		end
--		if managers.player:current_state() == "civilian" or self:_interacting() or self._ext_movement:has_carry_restriction() or self:is_deploying() or self:_changing_weapon() or self:_is_throwing_projectile() or self:_is_meleeing() or self:_on_zipline() or self._moving or self:running() or self:_is_reloading() or self:in_air() or self:in_steelsight() or self:is_equipping() or self:shooting() or not managers.groupai:state():whisper_mode() or not tweak_data.player.omniscience then
--			NobleHUD:RemoveBuff("sixth_sense")
--		elseif self._state_data.omniscience_t then
--			NobleHUD:AddBuff("sixth_sense",{end_t = 1,persistent_timer = true})
--		end
	end
end)