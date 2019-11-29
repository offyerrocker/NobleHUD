function PlayerDamage:_update_armor_hud(t, dt) --overridden
	local real_armor = self:get_real_armor()
	local is_full = true
	local current_armor = math.lerp(self._current_armor_fill, real_armor, 10 * dt)
	if current_armor > self._current_armor_fill then
		is_full = false
	end
	self._current_armor_fill = current_armor
	if real_armor <= 0 then 
--	the positive and totally intentional side effect of my modification is that it skips the interpolation,
--	and thus the visual animation for armor damage, but only when your armor is fully depleted.
--	Calculated.
		managers.hud:set_player_armor({
			current = 0, 
			total = self:_max_armor()
		})
	elseif not is_full then --fills armor all the way, but only if regaining armor
		managers.hud:set_player_armor({
			current = current_armor,
			total = self:_max_armor()
		})
	elseif math.abs(self._current_armor_fill - real_armor) > 0.01 then
	-->:( ovk why would you pretend there's a little nugget of armor left, that's so annoying
	--there are better ways to help performance, like having a 64 bit game
		managers.hud:set_player_armor({
			current = current_armor,
			total = self:_max_armor()
		})
	else
	end
	if self._hurt_value then
		self._hurt_value = math.min(1, self._hurt_value + dt)
	end
end

local orig_dmg_m = PlayerDamage.damage_melee
function PlayerDamage:damage_melee(attack_data,...)
	local bleed_out = self._bleed_out
	local result = {orig_dmg_m(self,attack_data,...)}

	if not bleed_out and self._bleed_out then 
		if attack_data.attacker_unit then 
			NobleHUD:SetKiller(attack_data.attacker_unit)
		end
	end
	return unpack(result)
end

local orig_dmg_b = PlayerDamage.damage_bullet
function PlayerDamage:damage_bullet(attack_data,...)
	local bleed_out = self._bleed_out
	local result = {orig_dmg_b(self,attack_data,...)}
	if not bleed_out and self._bleed_out then 
		if attack_data.attacker_unit then 
			NobleHUD:SetKiller(attack_data.attacker_unit)
		end
	end
	return unpack(result)
end
--[[
Hooks:PostHook(PlayerDamage,"damage_melee","noblehud_damage_melee",function(self,attack_data,...)
end)

Hooks:PostHook(PlayerDamage,"damage_bullet","noblehud_damage_bullet",function(self,attack_data,...)
end)
Hooks:PostHook(PlayerDamage,"damage_simple","noblehud_damage_simple",function(self,attack_data,...)
end)
--]]