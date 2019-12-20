if not NobleHUD then return end

local orig_check_fire = PlayerStandard._check_action_primary_attack
function PlayerStandard:_check_action_primary_attack(t,input,...)
	if self._equipped_unit and (input.btn_primary_attack_state or input.btn_primary_attack_release) then 
		local weapon_base = self._equipped_unit:base()
		local fire_mode = weapon_base:fire_mode()
		local selection_index = tweak_data.weapon[weapon_base._name_id].use_data.selection_index
		
		if NobleHUD.weapon_data[selection_index].safety then 
			if input.btn_primary_attack_press then
				managers.hud:show_hint({text = managers.localization:text("noblehud_hud_safety_check")})
				weapon_base:dryfire()
			end
			return
		else 
			return orig_check_fire(self,t,input,...)
		end
	end
	return orig_check_fire(self,t,input,...)
end

if true then 

	local orig_check_firemode = PlayerStandard._check_action_weapon_firemode
	function PlayerStandard:_check_action_weapon_firemode(t,input,...)
		if input.btn_weapon_firemode_press then 
			local weapon = self._equipped_unit:base()
			local index = tweak_data.weapon[weapon._name_id].use_data.selection_index
			NobleHUD:_hide_firemode(index,weapon:fire_mode())
			local result = orig_check_firemode(self,t,input,...)
			NobleHUD:_show_firemode(index,weapon:fire_mode())
			return result
		end
		return orig_check_firemode(self,t,input,...)
	end

elseif NewRaycastWeaponBase.can_use_burst_mode then
	--burstfire mod present

	local orig_check_firemode = PlayerStandard._check_action_weapon_firemode
	function PlayerStandard:_check_action_weapon_firemode(t,input,...)
		--toggle to burstfire
		if input.btn_weapon_firemode_press then 
			local weapon = self._equipped_unit:base()
			local index = tweak_data.weapon[weapon._name_id].use_data.selection_index
			NobleHUD:_hide_firemode(index,weapon:fire_mode())
			NobleHUD:_set_firemode(index,weapon:fire_mode())

--override burstfire's override
			if weapon.toggle_firemode then
				self:_check_stop_shooting()
				if weapon:toggle_firemode() then
					if weapon:in_burst_mode() then
						managers.hud:set_teammate_weapon_firemode_burst(self._unit:inventory():equipped_selection())
					else
						managers.hud:set_teammate_weapon_firemode(HUDManager.PLAYER_PANEL, self._unit:inventory():equipped_selection(), weapon:fire_mode())
					end
				end
				return
			end
		end
		return orig_check_firemode(self,t,input,...)
	end
	
end	
	
Hooks:PostHook(PlayerStandard,"_update_melee_timers","noblehud_update_melee",function(self,t,input)
--todo melee crosshair

	--crosshair_slot1:set_visible(not self._state_data.meleeing)
	--crosshair_slot2:set_visible(not self._state_data.meleeing)
	--crosshair_slot3:set_visible(self._state_data.meleeing)
end)
