Hooks:PostHook(PlayerDamage,"_on_enter_swansong_event","noblehud_buff_swansong",function(self)
	NobleHUD:AddBuff("swan_song",{end_t = managers.player:get_activate_temporary_expire_time("temporary", "berserker_damage_multiplier")})
	--value = managers.player:upgrade_value("temporary", "berserker_damage_multiplier")
	--duration = value[2]
end)

Hooks:PostHook(PlayerDamage,"_on_exit_swansong_event","noblehud_buff_swansong_remove",function(self)
	NobleHUD:RemoveBuff("swan_song")
end)

Hooks:PostHook(PlayerDamage,"_update_armor_grinding","noblehud_buff_anarchist",function(self,t,dt)
	if not (self._armor_grinding and self._armor_grinding.elapsed and self._armor_grinding.target_tick) then
		return
	end
	local next_regen = self._armor_grinding.target_tick - self._armor_grinding.elapsed
	local regen_amount = self._armor_grinding.armor_value
	NobleHUD:AddBuff("anarchist_armor_regen",{duration = next_regen,value = regen_amount})
end)

Hooks:PreHook(PlayerDamage,"_check_bleed_out","noblehud_buff_uppers_aced_cooldown",function(self,can_activate_berserker,ignore_movement_state,...)
	if self:get_real_health() == 0 and not self._check_berserker_done then

		if not self._block_medkit_auto_revive and self._uppers_elapsed + self._UPPERS_COOLDOWN < Application:time() then
			local auto_recovery_kit = FirstAidKitBase.GetFirstAidKit(self._unit:position())

			if auto_recovery_kit then
				NobleHUD:AddBuff("uppers_aced_cooldown",{duration = self._UPPERS_COOLDOWN})
			end
		end
	end
end)

Hooks:PostHook(PlayerDamage,"set_health","noblehud_buff_berserker",function(self,health) 
	if managers.player:has_category_upgrade("player", "damage_health_ratio_multiplier") then
		local ratio = managers.player:get_damage_health_ratio(self:health_ratio(), "melee")
		if ratio > 0 then 
			NobleHUD:AddBuff("berserker_damage_multiplier",{value=ratio})			
		end
	end
	if managers.player:has_category_upgrade("player", "melee_damage_health_ratio_multiplier") then
		local ratio = managers.player:get_damage_health_ratio(self:health_ratio(), "damage")
		if ratio > 0 then 
			NobleHUD:AddBuff("berserker_melee_damage_multiplier",{value=ratio})			
		end
	end
	if managers.player:has_category_upgrade("player", "movement_speed_damage_health_ratio_multiplier") then
		local ratio = managers.player:get_damage_health_ratio(self:health_ratio(), "movement_speed")
		if ratio > 0 then 
			NobleHUD:AddBuff("yakuza",{value=ratio})
		end
	end
end)

Hooks:PostHook(PlayerDamage,"_upd_health_regen","noblehud_buff_hp_regen",function(self,t,dt)
	if self._health_regen_update_timer then
		if math.floor(managers.player:health_regen() * 100) > 0 then 
			NobleHUD:AddBuff("hp_regen",{value=health_value,duration=self._health_regen_update_timer})
		else
			NobleHUD:RemoveBuff("hp_regen")
		end
	else
		NobleHUD:RemoveBuff("hp_regen")
	end
	

	local hot_stacks = self._damage_to_hot_stack
	local next_doh = hot_stacks and hot_stacks[1]
	if next_doh then 
		local ticks_count = 0
		for k,doh in pairs(hot_stacks) do 

			if doh.ticks_left then 
				ticks_count = ticks_count + doh.ticks_left
			end
		end
		NobleHUD:AddBuff("grinder",{value=ticks_count})
	else
		NobleHUD:RemoveBuff("grinder")
	end
end)