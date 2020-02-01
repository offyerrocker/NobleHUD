--not currently hooked

Hooks:PostHook(PlayerMovement,"on_morale_boost","noblehud_on_morale_boost",function(self,benefactor_unit)
--on receive inspire basic buff
--	managers.player:add_buff("morale_boost",{end_t = TimerManager:game():time() + tweak_data.upgrades.morale_boost_time})
end)
