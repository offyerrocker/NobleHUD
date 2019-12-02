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


--		local peer_id = managers.criminals:character_peer_id_by_unit(attacker_unit)

Hooks:PostHook(CopDamage,"_check_damage_achievements","noblehud_copdamage_damageachievements",function(self,attack_data,head)
	local stat, err = pcall(function ()
		NobleHUD:OnEnemyKilled(attack_data,head,self._unit)
	end)
	if err then 
		NobleHUD:log("Prevented CopDamage:_check_damage_achievements() crash:" .. tostring(stat),{color = Color.red})
	end
end)

Hooks:PostHook(CopDamage,"damage_melee","noblehud_copdamage_melee",function(self,attack_data)

	local stat, err = pcall(function () --none of that crashing thank you very much
	
		local from_behind,cool
		if self._dead then 
			if not (self._invulnerable or managers.enemy:is_civilian(self._unit)) then 
				mvector3.set(mvec_1, self._unit:position())
				mvector3.subtract(mvec_1, attack_data.attacker_unit:position())
				mvector3.normalize(mvec_1)
				mvector3.set(mvec_2, self._unit:rotation():y())
				from_behind = mvector3.dot(mvec_1, mvec_2) >= 0
				cool = self._unit:movement():cool()
				
				if attack_data.attacker_unit == managers.player:player_unit() then 
					if cool then 
		--					NobleHUD:AddMedal("assassination")
						attack_data.cool = true
					end
					if from_behind then
						attack_data.from_behind = true
		--					NobleHUD:AddMedal("beatdown")
					end
				end
			
			end
			NobleHUD:OnEnemyKilled(attack_data,false,self._unit)
		end
	end)
	if err then 
		NobleHUD:log("Prevented CopDamage:damage_melee() crash:" .. tostring(stat),{color = Color.red})
	end
	
end)
--[[
Hooks:PostHook(CopDamage,"damage_bullet","noblehud_copdamage_bullet",function(self,attack_data)
	if self:dead() then 
		local attacker_unit = attack_data and attack_data.attacker_unit
		if attacker_unit and attacker_unit == managers.player:local_player() then 
			for peer_id,unit in pairs(NobleHUD._cache.killer) do 
				if unit == self._unit then 
					if peer_id == managers.network:session():local_peer():id() then
						NobleHUD:AddMedal("revenge")
					else
						NobleHUD:AddMedal("avenger")
					end
					NobleHUD:ClearKiller(peer_id)
				end
			end
		end	
	end
end)
Hooks:PostHook(CopDamage,"damage_fire","noblehud_copdamage_fire",function(self,attack_data)
	if self:dead() then 
		local attacker_unit = attack_data and attack_data.attacker_unit
		if attacker_unit and attacker_unit == managers.player:local_player() then 
			for peer_id,unit in pairs(NobleHUD._cache.killer) do 
				if unit == self._unit then 
					if peer_id == managers.network:session():local_peer():id() then
						NobleHUD:AddMedal("revenge")
					else
						NobleHUD:AddMedal("avenger")
					end
					NobleHUD:ClearKiller(peer_id)
				end
			end
		end		
	end
end)
Hooks:PostHook(CopDamage,"damage_dot","noblehud_copdamage_dot",function(self,attack_data)
	if self:dead() then 
		local attacker_unit = attack_data and attack_data.attacker_unit
		if attacker_unit and attacker_unit == managers.player:local_player() then 
			for peer_id,unit in pairs(NobleHUD._cache.killer) do 
				if unit == self._unit then 
					if peer_id == managers.network:session():local_peer():id() then
						NobleHUD:AddMedal("revenge")
					else
						NobleHUD:AddMedal("avenger")
					end
					NobleHUD:ClearKiller(peer_id)
				end
			end
		end		
	end
end)
Hooks:PostHook(CopDamage,"damage_explosion","noblehud_copdamage_explosion",function(self,attack_data)
	if self:dead() then 
		local attacker_unit = attack_data and attack_data.attacker_unit
		if attacker_unit and attacker_unit == managers.player:local_player() then 
			for peer_id,unit in pairs(NobleHUD._cache.killer) do 
				if unit == self._unit then 
					if peer_id == managers.network:session():local_peer():id() then
						NobleHUD:AddMedal("revenge")
					else
						NobleHUD:AddMedal("avenger")
					end
					NobleHUD:ClearKiller(peer_id)
				end
			end
		end		
	end
end)
Hooks:PostHook(CopDamage,"damage_simple","noblehud_copdamage_simple",function(self,attack_data)
	if self:dead() then 
		local attacker_unit = attack_data and attack_data.attacker_unit
		if attacker_unit and attacker_unit == managers.player:local_player() then 
			for peer_id,unit in pairs(NobleHUD._cache.killer) do 
				if unit == self._unit then 
					if peer_id == managers.network:session():local_peer():id() then
						NobleHUD:AddMedal("revenge")
					else
						NobleHUD:AddMedal("avenger")
					end
					NobleHUD:ClearKiller(peer_id)
				end
			end
		end		
	end
end)
Hooks:PostHook(CopDamage,"damage_tase","noblehud_copdamage_tase",function(self,attack_data)
	if self:dead() then 
		local attacker_unit = attack_data and attack_data.attacker_unit
		if attacker_unit and attacker_unit == managers.player:local_player() then 
			for peer_id,unit in pairs(NobleHUD._cache.killer) do 
				if unit == self._unit then 
					if peer_id == managers.network:session():local_peer():id() then
						NobleHUD:AddMedal("revenge")
					else
						NobleHUD:AddMedal("avenger")
					end
					NobleHUD:ClearKiller(peer_id)
				end
			end
		end		
	end
end)

Hooks:PostHook(CopDamage,"damage_mission","noblehud_copdamage_mission",function(self,attack_data)
	if self:dead() then 
		local attacker_unit = attack_data and attack_data.attacker_unit
		if attacker_unit and attacker_unit == managers.player:local_player() then 
			for peer_id,unit in pairs(NobleHUD._cache.killer) do 
				if unit == self._unit then 
					if peer_id == managers.network:session():local_peer():id() then
						NobleHUD:AddMedal("revenge")
					else
						NobleHUD:AddMedal("avenger")
					end
					NobleHUD:ClearKiller(peer_id)
				end
			end
		end		
	end
end)
--]]

--[[
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
	local is_civilian = managers.enemy:is_civilian(self._unit)
	local result = {orig_melee(self,attack_data,...)}
	if type(result[1]) == "table" and attack_data.attacker_unit == managers.player:player_unit() then 
		for peer_id,unit in pairs(NobleHUD._cache.killer) do 
			if unit == self._unit then 
				if peer_id == managers.network:session():local_peer():id() then
					NobleHUD:AddMedal("revenge")
				else
					NobleHUD:AddMedal("avenger")
				end
				NobleHUD:ClearKiller(peer_id)
			end
		end
		if result[1].type == "death" then 
			if not is_civilian then 
				
				if cool then 
--					NobleHUD:AddMedal("assassination")
					attack_data.cool = true
				end
				if from_behind then
					attack_data.from_behind = true
--					NobleHUD:AddMedal("beatdown")
				end
			end
		end
	end
	
	local stat, err = pcall(function ()
		NobleHUD:OnEnemyKilled(attack_data,head,self._unit)
	end)
	if err then 
		NobleHUD:log("Prevented CopDamage:_check_damage_achievements() crash:" .. tostring(stat),{color = Color.red})
	end
	
	return unpack(result)
end
--]]
--[[
	if self:dead() then 
		local attacker_unit = attack_data and attack_data.attacker_unit
		if attacker_unit and attacker_unit == managers.player:local_player() then 
			for peer_id,unit in pairs(NobleHUD._cache.killer) do 
				if unit == self._unit then 
					if peer_id == managers.network:session():local_peer():id() then
						NobleHUD:AddMedal("revenge")
					else
						NobleHUD:AddMedal("avenger")
					end
					NobleHUD:ClearKiller(peer_id)
				end
			end
		end		
	end
end)
--]]
--[[
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
	local is_civilian = managers.enemy:is_civilian(self._unit)
	local result = {orig_melee(self,attack_data,...)}
	if type(result[1]) == "table" and attack_data.attacker_unit == managers.player:player_unit() then 
		if result[1].type == "death" then 
			if not is_civilian then 
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


local orig_dmg_m = CopDamage.damage_melee
function CopDamage:damage_melee(attack_data,...)
	local dead = self:dead()
	local result = {orig_dmg_m(self,attack_data,...)}
	if not dead and self:dead() then 
		local attacker_unit = attack_data.attacker_unit
		if attacker_unit and attacker_unit == managers.player:local_player() then 
			for peer_id,unit in pairs(NobleHUD._cache.killer) do 
				if unit == self._unit then 
					if peer_id == managers.network:session():local_peer():id() then
						NobleHUD:AddMedal("revenge")
					else
						NobleHUD:AddMedal("avenger")
					end
					NobleHUD:SetKiller(nil,peer_id)
				end
			end
		end		
	end
	return unpack(result)
end
--]]
--[[
local orig_dmg_p = CopDamage.damage_dot
function CopDamage:damage_dot(attack_data,...)
	local dead = self:dead()
	local result = {orig_dmg_p(self,attack_data,...)}
	if not dead and self:dead() then 
		local attacker_unit = attack_data.attacker_unit
		if attacker_unit and attacker_unit == managers.player:local_player() then 
			for peer_id,unit in pairs(NobleHUD._cache.killer) do 
				if unit == self._unit then 
					if peer_id == managers.network:session():local_peer():id() then
						NobleHUD:AddMedal("revenge")
					else
						NobleHUD:AddMedal("avenger")
					end
					NobleHUD:SetKiller(nil,peer_id)
				end
			end
		end		
	end
	return unpack(result)
end

local orig_dmg_f = CopDamage.damage_fire
function CopDamage:damage_fire(attack_data,...)
	local dead = self:dead()
	local result = {orig_dmg_f(self,attack_data,...)}
	if not dead and self:dead() then 
		local attacker_unit = attack_data.attacker_unit
		if attacker_unit and attacker_unit == managers.player:local_player() then 
			for peer_id,unit in pairs(NobleHUD._cache.killer) do 
				if unit == self._unit then 
					if peer_id == managers.network:session():local_peer():id() then
						NobleHUD:AddMedal("revenge")
					else
						NobleHUD:AddMedal("avenger")
					end
					NobleHUD:SetKiller(nil,peer_id)
				end
			end
		end		
	end
	return unpack(result)
end

local orig_dmg_e = CopDamage.damage_explosion
function CopDamage:damage_explosion(attack_data,...)
	local dead = self:dead()
	local result = {orig_dmg_e(self,attack_data,...)}
	if not dead and self:dead() then 
		local attacker_unit = attack_data.attacker_unit
		if attacker_unit and attacker_unit == managers.player:local_player() then 
			for peer_id,unit in pairs(NobleHUD._cache.killer) do 
				if unit == self._unit then 
					if peer_id == managers.network:session():local_peer():id() then
						NobleHUD:AddMedal("revenge")
					else
						NobleHUD:AddMedal("avenger")
					end
					NobleHUD:SetKiller(nil,peer_id)
				end
			end
		end		
	end
	return unpack(result)
end

local orig_dmg_s = CopDamage.damage_simple
function CopDamage:damage_simple(attack_data,...)
	local dead = self:dead()
	local result = {orig_dmg_s(self,attack_data,...)}
	if not dead and self:dead() then 
		local attacker_unit = attack_data.attacker_unit
		if attacker_unit and attacker_unit == managers.player:local_player() then 
			for peer_id,unit in pairs(NobleHUD._cache.killer) do 
				if unit == self._unit then 
					if peer_id == managers.network:session():local_peer():id() then
						NobleHUD:AddMedal("revenge")
					else
						NobleHUD:AddMedal("avenger")
					end
					NobleHUD:SetKiller(nil,peer_id)
				end
			end
		end		
	end
	return unpack(result)
end
--]]