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
local orig_melee = CopDamage.damage_melee
function CopDamage:damage_melee(attack_data,...)
	local from_behind,cool
	if not (self._invulnerable or self._dead) then 
		mvector3.set(mvec_1, self._unit:position())
		mvector3.subtract(mvec_1, attack_data.attacker_unit:position())
		mvector3.normalize(mvec_1)
		mvector3.set(mvec_2, self._unit:rotation():y())
		from_behind = mvector3.dot(mvec_1, mvec_2) >= 0
		cool = self._unit:movement():cool()
	end

	local result = {orig_melee(self,attack_data,...)}
	if type(result[1]) == "table" and attack_data.attacker_unit == managers.player:player_unit() then 
		if result[1].type == "death" then 
			if not managers.enemy:is_civilian(self._unit) then 
				if cool then 
					NobleHUD:AddMedal("assassination")
				end
				if from_behind then
					NobleHUD:AddMedal("beatdown")
				end
			end
		end
	end
	return unpack(result)
end
