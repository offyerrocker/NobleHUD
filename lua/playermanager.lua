if not NobleHUD then return end

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

--[[
Hooks:PostHook(PlayerManager,"_internal_load","noblehud_on_internal_load",function(self)
	if not NobleHUD then 
		log("NOBLEHUD: HEY DIPSHIT YOU STILL HAVEN'T FIXED SOME LOAD ISSUE")
		return
	end
	NobleHUD:OnLoaded()
end)
--]]


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
