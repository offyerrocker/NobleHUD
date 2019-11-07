
local orig_fire = RaycastWeaponBase.fire
function RaycastWeaponBase:fire(...)
	local result = {orig_fire(self,...)}
	if result and self._setup.user_unit == managers.player:player_unit() then 
		NobleHUD:_add_weapon_bloom(0.5)
	end
	return unpack(result)
end