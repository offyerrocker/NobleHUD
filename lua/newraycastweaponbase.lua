
--call will pass harmlessly through this old posthook and continue on to its destination
--[[
Hooks:PostHook(NewRaycastWeaponBase,"toggle_firemode","noblehud_prefiremode",function(self)
	local firemode = self:fire_mode()
	local index = tweak_data.weapon[self._name_id].use_data.selection_index
	NobleHUD:_set_firemode(index,firemode,self._in_burst_mode)
end)
local orig_firemode = NewRaycastWeaponBase.toggle_firemode
function NewRaycastWeaponBase:toggle_firemode(...)
	local prev_firemode = self:fire_mode()
	local result = orig_firemode(self,...)
	local firemode = self:fire_mode()
	local index = tweak_data.weapon[self._name_id].use_data.selection_index
	NobleHUD:_set_firemode(index,firemode,prev_firemode,self._in_burst_mode)
	self:log("Set Firemode!" .. tostring(prev_firemode) .. "," .. tostring(firemode))
	return result
end

--]]