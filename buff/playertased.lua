Hooks:PostHook(PlayerTased,"enter","noblehud_buff_tased",function(self,state_data,enter_data)
	local buff_name,duration
	if state_data.non_lethal_electrocution then 
		buff_name = "electrocuted"
		duration = tweak_data.player.damage.TASED_TIME * managers.player:upgrade_value("player", "electrocution_resistance_multiplier", 1)
	else
		buff_name = "tased"
		duration = managers.modifiers:modify_value("PlayerTased:TasedTime", tweak_data.player.damage.TASED_TIME)
	end
	--todo change color from managers.player:upgrade_value("player", "taser_malfunction"); .interval, .chance_to_trigger
	--or for managers.player:has_category_upgrade("player", "escape_taser"), priority
	NobleHUD:AddBuff(buff_name,{end_t = Application:time() + duration})
end)


Hooks:PreHook(PlayerTased,"exit","noblehud_buff_tased_remove",function(self,enter_data)
	if self._state_data.non_lethal_electrocution then 
		NobleHUD:RemoveBuff("electrocuted")
	else
		NobleHUD:RemoveBuff("tased")
	end
end)
