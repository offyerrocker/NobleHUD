if not NobleHUD then return end
--[[
Hooks:PostHook(PlayerStandard,"_start_action_interact","noblehud_playerstandard_startinteract",function(self,t, input, timer, interact_object)
	local final_timer = timer
	final_timer = managers.modifiers:modify_value("PlayerStandard:OnStartInteraction", final_timer, interact_object)
	self._interact_expire_t = final_timer
	
	local start_timer = 0
	self._interact_params = {
		object = interact_object,
		timer = final_timer,
		tweak_data = interact_object:interaction().tweak_data
	}

	self:_play_unequip_animation()
	managers.hud:show_interaction_bar(start_timer, final_timer)
	managers.network:session():send_to_peers_synched("sync_teammate_progress", 1, true, self._interact_params.tweak_data, final_timer, false)
	self._unit:network():send("sync_interaction_anim", true, self._interact_params.tweak_data)
end
--]]
local orig_check_fire = PlayerStandard._check_action_primary_attack
function PlayerStandard:_check_action_primary_attack(t,input,...)
	if self._equipped_unit and (input.btn_primary_attack_state or input.btn_primary_attack_release) then 
		local weapon_base = self._equipped_unit:base()
		local fire_mode = weapon_base:fire_mode()
		local selection_index = tweak_data.weapon[weapon_base._name_id].use_data.selection_index
		
		if NobleHUD.weapon_data[selection_index].safety then 
			if input.btn_primary_attack_press then
				managers.hud:show_hint({text = "Your safety is on!"})
				weapon_base:dryfire()
			end
			return
		else 
			local result = orig_check_fire(self,t,input,...)
			if result then 
--				OffyLib:c_log("Added weapon bloom! " .. Application:time())
--				NobleHUD:_add_weapon_bloom(0.5) --todo by type
			end
			return result
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
--		OffyLib:c_log("Burstfire toggle")
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
	
	
--[[
Hooks:PreHook(PlayerStandard,"_check_action_weapon_firemode","noblehud_hide_firemode",function(self,t,input)
	if input.btn_weapon_firemode_press then 
		local weapon = self._equipped_unit:base()
		local prev_firemode = weapon:fire_mode()
		local index = tweak_data.weapon[weapon._name_id].use_data.selection_index
		NobleHUD:_hide_firemode(index,prev_firemode)
		OffyLib:c_log("Hiding" .. tostring(prev_firemode))
	end
end)

Hooks:PostHook(PlayerStandard,"_check_action_weapon_firemode","noblehud_show_firemode",function(self,t,input)
	if input.btn_weapon_firemode_press then 
		local weapon = self._equipped_unit:base()
		local firemode = weapon:fire_mode()
		local index = tweak_data.weapon[weapon._name_id].use_data.selection_index
		NobleHUD:_set_firemode(index,firemode,weapon._in_burst_mode)
		OffyLib:c_log("Showing" .. tostring(firemode))
	end
end)
--]]
Hooks:PostHook(PlayerStandard,"_update_melee_timers","noblehud_update_melee",function(self,t,input)
	--crosshair_slot1:set_visible(not self._state_data.meleeing)
	--crosshair_slot2:set_visible(not self._state_data.meleeing)
	--crosshair_slot3:set_visible(self._state_data.meleeing)
end)
