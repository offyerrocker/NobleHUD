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

--[[
Hooks:PreHook(PlayerDamage,"restore_armor","noblehud_playerdamage_restore_armor",function(self,armor_restored)
	if self._dead or self._bleed_out or self._check_berserker_done then
		return
	end

	if self:get_real_armor() + armor_restored > self:_max_armor() then 
		if NobleHUD:IsShieldChargeSoundEnabled() then
			local shield_source = NobleHUD._shield_sound_source
			if shield_source and shield_source:is_active() then 
				shield_source:stop()
				if shield_source._buffer ~= NobleHUD._cache.sounds.shield_charge then 
					shield_source:set_looping(false)
					shield_source:set_buffer(NobleHUD._cache.sounds.shield_charge)
				end
				if shield_source:get_state() ~= 1 then 
					shield_source:play()
					OffyLib:c_log("Playing shield regen 2")
				end
			end
		end
	end
end)
--]]
Hooks:PreHook(PlayerDamage,"band_aid_health","noblehud_playerdamage_band_aid_health",function(self)
	XAudio.Source:new(XAudio.Buffer:new(NobleHUD._mod_path .. "assets/snd/fx/health_pack.ogg"))
end)

Hooks:PreHook(PlayerDamage,"recover_health","noblehud_playerdamage_recover_health",function(self)
	XAudio.Source:new(XAudio.Buffer:new(NobleHUD._mod_path .. "assets/snd/fx/health_pack.ogg"))
end)
--[[

function PlayerDamage:restore_health(health_restored, is_static, chk_health_ratio)
	if chk_health_ratio and managers.player:is_damage_health_ratio_active(self:health_ratio()) then
		return false
	end

	if is_static then
		return self:change_health(health_restored * self._healing_reduction)
	else
		local max_health = self:_max_health()

		return self:change_health(max_health * health_restored * self._healing_reduction)
	end
end
--]]

Hooks:PostHook(PlayerDamage,"_on_damage_event","noblehud_on_player_damage_event",function(self)
	local max_armor = self:_max_armor()
	if (self:get_real_armor() < max_armor) and (max_armor > 0) then 
		NobleHUD:PlayShieldSound("shield_charge",false)
	--[[
		local shield_source = NobleHUD._shield_sound_source
		if shield_source and shield_source:is_active() and (shield_source._buffer == NobleHUD._cache.sounds.shield_charge) then		
			shield_source:stop()
		end
		--]]
		--interrupt shield charging sound if hit
	end
	
	
	--[[
	if self:_max_armor() > 0 then 
		local armor = self:get_real_armor()
		if armor <= 0 then 
			OffyLib:c_log("Armor broken!")
			local player_armor_max = player_damage:_max_armor()
			if player_armor_max > 0 and self._shield_sound_source and self._shield_sound_source:is_active() then
				local player_armor = player_damage:get_real_armor()
				local shield_source = self._shield_sound_source
				if self:IsShieldEmptySoundEnabled() and (player_armor == 0) then
					if shield_source._buffer ~= self._cache.sounds.shield_empty then 
						shield_source:stop()
						shield_source:set_buffer(self._cache.sounds.shield_empty)
						shield_source:set_looping(true)
					end
					if shield_source:get_state() ~= 1 then 
						shield_source:play()
					end
				elseif self:IsShieldLowSoundEnabled() and ((player_armor / player_armor_max) <= NobleHUD:GetLowShieldThreshold()) then
					if shield_source._buffer ~= self._cache.sounds.shield_low then 
						shield_source:stop()
						shield_source:set_buffer(self._cache.sounds.shield_low)
						shield_source:set_looping(true)
					end
					if shield_source:get_state() ~= 1 then 
						shield_source:play()
					end
				else
					if shield_source:get_state() == 1 then 
						shield_source:stop()
					end
				end
			end
			
		elseif armor <= NobleHUD:GetLowShieldThreshold() then 
			OffyLib:c_log("Armor low!")
		end
	end	
--]]
end)

Hooks:PreHook(PlayerDamage,"_regenerate_armor","noblehud_player_regen_armor",function(self,no_sound)
	local max_armor = self:_max_armor()
	if (self:get_real_armor() < max_armor) and (max_armor > 0) then 
		
		if not no_sound then 
			if NobleHUD:IsShieldChargeSoundEnabled() then
				NobleHUD:PlayShieldSound("shield_charge")
				--[[
				local shield_source = NobleHUD._shield_sound_source
				
				if shield_source and not shield_source:is_closed() then 
					shield_source:stop()
					if shield_source._buffer ~= NobleHUD._cache.sounds.shield_charge then 
						shield_source:set_looping(false)
						shield_source:set_buffer(NobleHUD._cache.sounds.shield_charge)
						shield_source:set_volume(NobleHUD:GetShieldChargeVolume())
					end
					if shield_source:get_state() ~= 1 then 
						shield_source:play()
					end
				end
				--]]
			end
		end
	end
end)
--[[
function PlayerDamage:_regenerate_armor(no_sound)

	if not no_sound then 
		if NobleHUD:IsShieldChargeSoundEnabled() then
			local shield_source = NobleHUD._shield_sound_source
			if shield_source and shield_source:is_active() then 
				shield_source:stop()
				if shield_source._buffer ~= NobleHUD._cache.sounds.shield_charge then 
					shield_source:set_looping(false)
					shield_source:set_buffer(NobleHUD._cache.sounds.shield_charge)
				end
				if shield_source:get_state() ~= 1 then 
					shield_source:play()
					OffyLib:c_log("Playing shield regen")
				end
			end
		else
			if self._unit:sound() then
				self._unit:sound():play("shield_full_indicator")
			end
		end
	end

	self._regenerate_speed = nil

	self:set_armor(self:_max_armor())
	self:_send_set_armor()

	self._current_state = nil
end
--]]

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