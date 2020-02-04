
--local functions copypasted in entirety from vanilla 
local function get_as_digested(amount)
	local list = {}

	for i = 1, #amount, 1 do
		table.insert(list, Application:digest_value(amount[i], false))
	end

	return list
end

local function make_double_hud_string(a, b)
	return string.format("%01d|%01d", a, b)
end

local function add_hud_item(amount, icon)
	if #amount > 1 then
		managers.hud:add_item_from_string({
			amount_str = make_double_hud_string(amount[1], amount[2]),
			amount = amount,
			icon = icon
		})
	else
		managers.hud:add_item({
			amount = amount[1],
			icon = icon
		})
	end
end

local function set_hud_item_amount(index, amount)
	if #amount > 1 then
		managers.hud:set_item_amount_from_string(index, make_double_hud_string(amount[1], amount[2]), amount)
	else
		managers.hud:set_item_amount(index, amount[1])
	end
end

Hooks:PostHook(PlayerManager,"set_player_state","noblehud_on_player_state_changed",function(self,state)
	if NobleHUD then 
		NobleHUD:OnPlayerStateChanged(state)
	end
end)

--[[
Hooks:PreHook(PlayerManager,"_change_player_state","noblehud_on_game_state_changed",function(self)
	if not (NobleHUD and game_state_machine) then
		return 
	end
	local previous_state = game_state_machine:last_queued_state_name()
	local state = self._player_states[self._current_state]
	NobleHUD:OnGameStateChanged(previous_state,state)
end)
--]]
Hooks:PostHook(PlayerManager,"activate_temporary_upgrade","noblehud_activate_temporary_upgrade",function(self,category, upgrade)
	local t = self._temporary_upgrades[category] and self._temporary_upgrades[category][upgrade] and self._temporary_upgrades[category][upgrade].expire_time
	
	NobleHUD:AddBuff(upgrade,{end_t = t}) --i'd have to re-calculate stuff or overwrite the function to use duration instead of end_t. i'd rather risk having desynced end times
end)

Hooks:PostHook(PlayerManager,"activate_temporary_upgrade_by_level","noblehud_activate_temporary_upgrade_by_level",function(self,category, upgrade, level)
	local t = self._temporary_upgrades[category] and self._temporary_upgrades[category][upgrade] and self._temporary_upgrades[category][upgrade].expire_time
	NobleHUD:AddBuff(upgrade,{end_t = t}) --i'd have to re-calculate stuff or overwrite the function to use duration instead of end_t. i'd rather risk having desynced end times
end)

Hooks:PostHook(PlayerManager,"add_to_temporary_property","noblehud_add_temporary_property",function(self,name, time, value)
	NobleHUD:AddBuff(name,{duration = time}) --i'd have to re-calculate stuff or overwrite the function to use duration instead of end_t. i'd rather risk having desynced end times
end)

Hooks:PostHook(PlayerManager,"aquire_cooldown_upgrade","noblehud_aquire_cooldown_upgrade",function(self,upgrade)
--upgrade is a table. whoops.
	local name = upgrade.upgrade
	local upgrade_value = self:upgrade_value(upgrade.category,name)
	NobleHUD:log("PlayerManager:aquire_cooldown_upgrade(" .. NobleHUD.table_concat(upgrade,",","=") .. ")")
--	NobleHUD:AddBuff(name,{duration = time}) --i'd have to re-calculate stuff or overwrite the function to use duration instead of end_t. i'd rather risk having desynced end times
end)

Hooks:PostHook(PlayerManager,"disable_cooldown_upgrade","noblehud_disable_cooldown_upgrade",function(self,category,upgrade)
	local upgrade_value = self:upgrade_value(category, upgrade)

	if upgrade_value == 0 then
		return
	end

	local t = upgrade_value[2]

	NobleHUD:AddBuff(upgrade,{duration = t})
end)

Hooks:PostHook(PlayerManager,"on_headshot_dealt","noblehud_on_bullseye_event",function(self)
	if not self:player_unit() then return end

	if self:upgrade_value("player", "headshot_regen_armor_bonus", 0) > 0 then 
		if self._on_headshot_dealt_t then 
			NobleHUD:AddBuff("bullseye",{end_t = self._on_headshot_dealt_t})
		else --just in case
			NobleHUD:AddBuff("bullseye",{end_t = Application:time() + tweak_data.upgrades.on_headshot_dealt_cooldown})
		end
	end
end)

--switch_equipment() and select_next_item() overwritten to allow selecting empty equipment
function PlayerManager:switch_equipment()
	self:select_next_item()
	local equipment = self:selected_equipment() 
	if not (equipment or _G.IS_VR) then
		local td = tweak_data.equipments[managers.blackmarket:equipped_deployable(self._equipment.selected_index)]
		if not td then 
			--NobleHUD:log("ERROR: No second deployable; likely does not have JoAT. Index: " .. tostring(self._equipment.selected_index))
			return
		end
		local icon = td.icon
		add_hud_item({0},icon)
		--don't update to peers either
	elseif equipment and not _G.IS_VR then 
		local digested = get_as_digested(equipment.amount)
		add_hud_item(digested,equipment.icon)
		self:update_deployable_selection_to_peers()	
	end
end

function PlayerManager:select_next_item()
	if not self._equipment.selected_index then
		return
	end
	local prev = self._equipment.selected_index
	
	if managers.player._equipment and #managers.player._equipment.selections <= 1 then 
		self._equipment.selected_index = 1
		return
	end
	
	self._equipment.selected_index = (self._equipment.selected_index == 2 and 1) or 2
	if self._equipment.selected_index ~= prev then --don't do the switch-selected hud anim if you're not switching
	--do switch anim?
	end
--self:has_category_upgrade("player","second_deployable")
end
