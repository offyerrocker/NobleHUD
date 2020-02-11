
Hooks:PostHook(HUDTeammate,"set_absorb_active","noblehud_buff_hysteria",function(self,absorb_amount)
	if self._main_player then 
		if absorb_amount > 0 then
			NobleHUD:AddBuff("hysteria",{value = absorb_amount})
		else 
			NobleHUD:RemoveBuff("hysteria")
		end
	end
end)
--[[
Hooks:PostHook(HUDTeammate,"activate_ability_radial","noblehud_buff_throwables",function(self,time_left,time_total)
	NobleHUD:log("doing buff activate_ability_radial(" .. tostring(time_left) .. "," .. tostring(time_total)..")")
	if self._main_player then 			
		if time_left then
			local ability,amount = managers.blackmarket:equipped_grenade()
			if ability then 
				NobleHUD:AddBuff(ability,{duration = time_left})
			else
				NobleHUD:log("activate_ability_radial(" .. tostring(time_left) .. "," .. tostring(time_total)..") No ability found!")
			end
		end
	end
end)
--]]