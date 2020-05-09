Hooks:PostHook(PlayerStandard,"_start_action_steelsight","noblehud_start_steelsight",function(self)
	if NobleHUD:GetSteelsightHidesReticle() and self:in_steelsight() then
		local slot = self._unit:inventory():equipped_selection()
		NobleHUD:_set_crosshair_in_slot_visible(slot,false)
	end
	if NobleHUD:GetSteelsightHidesFloatingAmmo() then 
		NobleHUD:SetFloatingAmmoVisible(false,true)
	end
end)

Hooks:PostHook(PlayerStandard,"_end_action_steelsight","noblehud_end_steelsight",function(self)
	if not self:in_steelsight() then
		local slot = self._unit:inventory():equipped_selection()
		NobleHUD:_set_crosshair_in_slot_visible(slot,true)
	end
	if NobleHUD:GetSteelsightHidesFloatingAmmo() then 
		NobleHUD:SetFloatingAmmoVisible(true,true)
	end
end)

Hooks:PostHook(PlayerStandard,"_check_action_deploy_underbarrel","noblehud_check_action_underbarrel",function(self,t,input)
	if input.btn_deploy_bipod then 
		local weapon = self._equipped_unit:base()
		local index = tweak_data.weapon[weapon._name_id].use_data.selection_index
		local slot,firemode = NobleHUD:get_slot_and_firemode()
		local underbarrel = NobleHUD.weapon_data[slot].underbarrel.base
		
		if underbarrel and underbarrel._on then 
			firemode = "underbarrel"
		end
		NobleHUD:_set_firemode(slot,firemode)
	end
end)

Hooks:PostHook(PlayerStandard,"_check_action_weapon_firemode","noblehud_check_action_firemode",function(self,t,input)
	if input.btn_weapon_firemode_press then 
		local weapon = self._equipped_unit:base()
		local index = tweak_data.weapon[weapon._name_id].use_data.selection_index
		local slot,firemode = NobleHUD:get_slot_and_firemode()
		local underbarrel = NobleHUD.weapon_data[slot].underbarrel.base
		
		if underbarrel and underbarrel._on then 
--			firemode = "underbarrel"
			return
		end
		NobleHUD:_set_firemode(slot,firemode)
	end
end)
--[[
local orig_check_firemode = PlayerStandard._check_action_weapon_firemode
function PlayerStandard:_check_action_weapon_firemode(t,input,...)
	if input.btn_weapon_firemode_press then 
		local weapon = self._equipped_unit:base()
		local index = tweak_data.weapon[weapon._name_id].use_data.selection_index
		NobleHUD:_hide_firemode(index,weapon:fire_mode())
		local result = {orig_check_firemode(self,t,input,...)}
		NobleHUD:_show_firemode(index,weapon:fire_mode())
		return unpack(result)
	end
	return orig_check_firemode(self,t,input,...)
end
--]]
--[[
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
	--]]
--Hooks:PostHook(PlayerStandard,"_update_melee_timers","noblehud_update_melee",function(self,t,input)
--todo melee crosshair

	--crosshair_slot1:set_visible(not self._state_data.meleeing)
	--crosshair_slot2:set_visible(not self._state_data.meleeing)
	--crosshair_slot3:set_visible(self._state_data.meleeing)
--end)
