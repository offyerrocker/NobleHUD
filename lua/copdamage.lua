local mvec_1 = Vector3()
local mvec_2 = Vector3()
local impact_bones_tmp = {
	"Hips",
	"Spine",
	"Spine1",
	"Spine2",
	"Neck",
	"Head",
	"LeftShoulder",
	"LeftArm",
	"LeftForeArm",
	"RightShoulder",
	"RightArm",
	"RightForeArm",
	"LeftUpLeg",
	"LeftLeg",
	"LeftFoot",
	"RightUpLeg",
	"RightLeg",
	"RightFoot"
}


Hooks:PreHook(CopDamage,"die","noblehud_copdamage_die",function(self,attack_data)

	if attack_data and attack_data.attacker_unit and alive(attack_data.attacker_unit) then 
		if attack_data.attacker_unit == managers.player:local_player() then
			NobleHUD:OnEnemyKilled(attack_data,nil,self._unit)
		elseif managers.groupai:state():all_criminals()[attack_data.attacker_unit:key()] then 
			NobleHUD:OnTeammateKill(attack_data)
		end
	end
end)


--[[
local orig_melee = CopDamage.damage_melee
function CopDamage:damage_melee(attack_data,...)
	local result = {orig_melee(self,attack_data,...)} --catch result
	if (not NobleHUD:IsSafeMode()) and attack_data and alive(attack_data.attacker_unit) and not self._invulnerable then 
		if attack_data.attacker_unit == managers.player:player_unit() then 
			local from_behind,cool
			if not managers.enemy:is_civilian(self._unit) then
				mvector3.set(mvec_1, self._unit:position())
				mvector3.subtract(mvec_1, attack_data.attacker_unit:position())
				mvector3.normalize(mvec_1)
				mvector3.set(mvec_2, self._unit:rotation():y())
				from_behind = mvector3.dot(mvec_1, mvec_2) >= 0
				cool = self._unit:movement():cool()
			end
			if type(result[1]) == "table" then 
			--read if result valid
				if result[1].type == "death" then 
					if cool then 
						attack_data.cool = true
					end
					if from_behind then
						attack_data.from_behind = true
					end
					NobleHUD:OnEnemyKilled(attack_data,false,self._unit)
				end
			end
		elseif managers.groupai:state():all_criminals()[attack_data.attacker_unit:key()] then
			if type(result[1]) == "table" then 
				if result[1].type == "death" then 
					NobleHUD:OnTeammateKill(attack_data)
				end
			end
		end
		--pass parameters to OnKilled stats  
	end
	return unpack(result) --return original result(s) to caller
end
--]]