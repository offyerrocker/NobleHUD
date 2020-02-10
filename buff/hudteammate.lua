
Hooks:PostHook(HUDTeammate,"set_absorb_active","noblehud_buff_hysteria",function(self,absorb_amount)
	if self._main_player then 
		local ratio = 100 * absorb_amount / tweak_data.upgrades.max_cocaine_stacks_per_tick
		if absorb_amount > 0 then
			NobleHUD:AddBuff("hysteria",{value = absorb_amount})
		else 
			NobleHUD:RemoveBuff("hysteria")
		end
	end
end)
