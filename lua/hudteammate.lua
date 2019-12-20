if not NobleHUD then
	return
end

Hooks:PostHook(HUDTeammate,"init","noblehud_addteammate",function(self,i, teammates_panel, is_player, width)
	NobleHUD:_init_teammate(i,panel,is_player,width)
end)

Hooks:PostHook(HUDTeammate,"set_callsign","noblehud_setteammatecallsign",function(self,id)
	if HUDManager.PLAYER_PANEL ~= self._id then 
		NobleHUD:_set_teammate_callsign(self._id,id)
	end
end)

Hooks:PostHook(HUDTeammate,"set_name","noblehud_setteammatename",function(self,player_name)
	if HUDManager.PLAYER_PANEL ~= self._id then 
		NobleHUD:_set_teammate_name(self._id,player_name)
	end
end)

Hooks:PostHook(HUDTeammate,"set_cable_ties_amount","noblehud_setcabletiesamount",function(self,amount)
	NobleHUD:SetCableTies(amount)
end)

Hooks:PostHook(HUDTeammate,"set_health","noblehud_set_health",function(self,data)
	if not self._main_player then 
		return
	end
	local hp_r = tonumber(tostring(data.current / data.total))
	NobleHUD:SetRevives(data.revives)
	
	local num_ticks = NobleHUD._HUD_HEALTH_TICKS
	local YELLOW_THRESHOLD = 0.75
	local RED_THRESHOLD = 0.25
	
	local vitals_panel = NobleHUD._vitals_panel
		
	for i = num_ticks,1,-1 do 
		local outline_left = vitals_panel:child("health_tick_left_outline_" .. i)
		local outline_right = vitals_panel:child("health_tick_right_outline_" .. i)
		local tick_left = vitals_panel:child("health_tick_left_fill_" .. i) 
		local tick_right = vitals_panel:child("health_tick_right_fill_" .. i) 
		if outline_left and outline_right and tick_left and tick_right then 
			if hp_r < RED_THRESHOLD then 
				tick_left:set_color(NobleHUD.color_data.hud_vitalsfill_red)
				tick_right:set_color(NobleHUD.color_data.hud_vitalsfill_red)
				outline_left:set_color(NobleHUD.color_data.hud_vitalsoutline_red)
				outline_right:set_color(NobleHUD.color_data.hud_vitalsoutline_red)
			elseif hp_r < YELLOW_THRESHOLD then
				tick_left:set_color(NobleHUD.color_data.hud_vitalsfill_yellow)
				tick_right:set_color(NobleHUD.color_data.hud_vitalsfill_yellow)
				outline_left:set_color(NobleHUD.color_data.hud_vitalsoutline_yellow)
				outline_right:set_color(NobleHUD.color_data.hud_vitalsoutline_yellow)
			else
				tick_left:set_color(NobleHUD.color_data.hud_vitalsfill_blue)
				tick_right:set_color(NobleHUD.color_data.hud_vitalsfill_blue)
				outline_left:set_color(NobleHUD.color_data.hud_vitalsoutline_blue)
				outline_right:set_color(NobleHUD.color_data.hud_vitalsoutline_blue)
			end
			local shown = hp_r >= (i/num_ticks)
			tick_left:set_visible(shown)
			tick_right:set_visible(shown)
		end
	end
	local outline_center = vitals_panel:child("health_tick_center_outline")
	local tick_center = vitals_panel:child("health_tick_center_fill")
	tick_center:set_visible(hp_r > 0)
	if hp_r < RED_THRESHOLD then
		tick_center:set_color(NobleHUD.color_data.hud_vitalsfill_red)
		outline_center:set_color(NobleHUD.color_data.hud_vitalsoutline_red)
	elseif hp_r < YELLOW_THRESHOLD then
		tick_center:set_color(NobleHUD.color_data.hud_vitalsfill_yellow)
		outline_center:set_color(NobleHUD.color_data.hud_vitalsoutline_yellow)
	else
		tick_center:set_color(NobleHUD.color_data.hud_vitalsfill_blue)
		outline_center:set_color(NobleHUD.color_data.hud_vitalsoutline_blue)
	end
	--todo set hp/shield numbers
end)

Hooks:PostHook(HUDTeammate,"set_armor","noblehud_set_armor",function(self,data)
	if not self._main_player then 
		return
	end
	local current = data.current
	local total = data.total
	local ratio = current / total
	
	local vitals_panel = NobleHUD._vitals_panel
	if vitals_panel then 
		if (total == 0) then
			vitals_panel:child("shield_fill"):set_w(0)
		else
			
--			vitals_panel:child("shield_fill"):set_texture_rect(0,0,512 * ratio,64) --classic, one-way depletion


			vitals_panel:child("shield_fill"):set_texture_rect((1 - ratio) * 256,0,(ratio * 512),64)
			vitals_panel:child("shield_fill"):set_w(512 * ratio)
			vitals_panel:child("shield_fill"):set_x((1 - ratio) * 256)
			
			if current == 0 then 
				local freq = math.sin(300 * Application:time() * math.pi)
				local glow_a = 0.65 + (freq / 4) --alpha range 0.3 to 0.8
				local text_a = 0.8 + (freq / 5) --alpha range 0.6 to 1
				vitals_panel:child("shield_glow"):set_alpha(glow_a)
				vitals_panel:child("shield_warning"):set_alpha(text_a)
				vitals_panel:child("shield_outline"):set_alpha(0.2)
			else
				vitals_panel:child("shield_glow"):set_alpha(0)
				vitals_panel:child("shield_outline"):set_alpha(0.7)
				vitals_panel:child("shield_warning"):set_alpha(0)
			end
			--todo get image size, multiply by scale;
			
		end
		
	end
	--todo set arm/hp numbers numbers
end)

Hooks:PostHook(HUDTeammate,"update_delayed_damage","noblehud_update_stoic_bar",function(self)
	if self._main_player then 
		local damage = self._delayed_damage or 0
		
		local armor_max = self._armor_data.total
		local armor_current = self._armor_data.current
		
		local health_max = self._health_data.total
		local health_current = self._health_data.current

		local armor_damage = math.clamp(damage - armor_current,0,armor_current)
		local health_damage = math.clamp(damage - armor_damage,0,health_current)
		
		local vitals_panel = NobleHUD._vitals_panel
		
		if armor_max > 0 then 
			local delayed_damage_armor_ratio = armor_damage / armor_current
			local delayed_damage_shield = vitals_panel:child("delayed_damage_shield_fill")
			delayed_damage_shield:set_texture_rect((1 - delayed_damage_armor_ratio) * 256,0,(delayed_damage_armor_ratio * 512),64)
			delayed_damage_shield:set_w(512 * delayed_damage_armor_ratio)
			delayed_damage_shield:set_x((1 - delayed_damage_armor_ratio) * 256)	
		end
		if health_max > 0 then 
			local delayed_damage_health_ratio = health_damage / health_current
			local stoic_left = "guis/textures/health_left_fill"
			local stoic_right = "guis/textures/health_right_fill"
			local normal_left = "guis/textures/health_left_fill"
			local normal_right = "guis/textures/health_right_fill"
			local blink = math.sin(300 * Application:time() * math.pi) * 0.85
			for i = NobleHUD._HUD_HEALTH_TICKS,1,-1 do
				local shown = delayed_damage_health_ratio > (NobleHUD._HUD_HEALTH_TICKS - i) / NobleHUD._HUD_HEALTH_TICKS
				local left_tick = vitals_panel:child("health_tick_left_fill_" .. i)
				local right_tick = vitals_panel:child("health_tick_right_fill_" .. i)
				if shown then 
					left_tick:set_image(stoic_left)
					right_tick:set_image(stoic_right)
					left_tick:set_alpha(0.15 + blink)
					right_tick:set_alpha(0.15 + blink)
				else
					right_tick:set_alpha(0.5)
					left_tick:set_alpha(0.5)
					left_tick:set_image(normal_left)
					right_tick:set_image(normal_right)
				end
			end
			if delayed_damage_health_ratio > (NobleHUD._HUD_HEALTH_TICKS - 1) / NobleHUD._HUD_HEALTH_TICKS then 
				vitals_panel:child("health_tick_center_fill"):set_image("guis/textures/health_center_fill")
				vitals_panel:child("health_tick_center_fill"):set_image("guis/textures/health_center_fill")
				vitals_panel:child("health_tick_center_fill"):set_alpha(0.15 + blink)
			else
				vitals_panel:child("health_tick_center_fill"):set_alpha(0.5)
				vitals_panel:child("health_tick_center_fill"):set_image("guis/textures/health_center_fill")
			end
		end
	end
end)

Hooks:PostHook(HUDTeammate,"set_stored_health_max","noblehud_set_stored_health_max",function(self,stored_health_ratio)
	if self._main_player then 
		NobleHUD._cache._max_stored_hp = stored_health_ratio
	end
end)

Hooks:PostHook(HUDTeammate,"set_stored_health","noblehud_set_stored_health",function(self,stored_health_ratio)
	local vitals_panel = NobleHUD._vitals_panel
	local max_stored = NobleHUD._cache._max_stored_hp or 1
	local ratio = math.clamp(stored_health_ratio / max_stored,0,1)
	
	for i = NobleHUD._HUD_HEALTH_TICKS,1,-1 do
		local shown = ratio >= (i/NobleHUD._HUD_HEALTH_TICKS)
		local left_tick = vitals_panel:child("stored_health_tick_left_outline_" .. i)
		local right_tick = vitals_panel:child("stored_health_tick_right_outline_" .. i)
		left_tick:set_visible(shown)
		right_tick:set_visible(shown)
	end
	vitals_panel:child("stored_health_tick_center_outline"):set_visible(ratio > (1/NobleHUD._HUD_HEALTH_TICKS))
end)
--
Hooks:PostHook(HUDTeammate,"set_absorb_active","noblehud_set_absorb",function(self,absorb_amount)
	if not self._main_player then 
		return
	end

	local ratio = 100 * absorb_amount / tweak_data.upgrades.max_cocaine_stacks_per_tick
	local vitals_panel = NobleHUD._vitals_panel
	
	if vitals_panel then 
		local absorption_fill = vitals_panel:child("absorption_fill")
		absorption_fill:set_texture_rect((1 - ratio) * 256,0,(ratio * 512),64)
		absorption_fill:set_w(512 * ratio)
		absorption_fill:set_x((1 - ratio) * 256)
	end
--[[
		--add to buff instead?
	if absorb_amount > 0 then
		managers.player:add_buff("hysteria",{value = math.floor(absorb_amount * 100)})
	else 
		managers.player:remove_buff("hysteria")
	end
	--]]
end)

Hooks:PostHook(HUDTeammate,"set_grenades","noblehud_set_grenades",function(self,data)
	if PlayerBase.USE_GRENADES and self._main_player then
		local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon, {
			0,
			0,
			32,
			32
		})
		local grenades_panel = NobleHUD._grenades_panel:child("primary_grenade_panel")
		local grenades_icon = grenades_panel:child("grenade_icon")

		grenades_panel:set_visible(true)
		grenades_icon:set_image(icon, unpack(texture_rect))
	end
end)

Hooks:PostHook(HUDTeammate,"set_weapon_selected","noblehud_set_weapon_selected",function(self,id)
	if not self._main_player then
		return
	end
--todo animate
	local primary = NobleHUD._primary_weapon_panel:child("weapon_ammo_ticks")
	if primary then
		--primary:set_visible(id == 1)
	end
	local secondary = NobleHUD._secondary_weapon_panel:child("weapon_ammo_ticks")	
	if secondary then
	--	secondary:set_visible(id ~= 1)
	end
	NobleHUD:_switch_weapons(id)
end)

Hooks:PostHook(HUDTeammate,"set_teammate_weapon_firemode","noblehud_set_teammate_firemode",function(self,slot,firemode)
--
end)

--burstfire mod support
--function HUDTeammate:set_weapon_firemode_burst(slot,firemode,burst_fire)
--	NobleHUD:_set_firemode(slot,firemode,burst_fire)
--end

Hooks:PostHook(HUDTeammate,"set_ammo_amount_by_type","noblehud_set_ammo",function(self,type,max_clip,current_clip,current_left,max,weapon_panel)
	if not self._main_player then 
		return
	end
	local slot = (type == "primary" and 2) or (type == "secondary" and 1)
	NobleHUD:_set_weapon_reserve(slot,math.max(current_left - current_clip,current_left))
	NobleHUD:_set_weapon_mag(slot,current_clip,max_clip)
--	NobleHUD:SetFloatingAmmo(current_clip,max_clip)

end)

Hooks:PostHook(HUDTeammate,"set_deployable_equipment","noblehud_set_deployable_equipment",function(self,data)
	if not self._main_player then 
		return
	end
	NobleHUD:_set_deployable_equipment(data.index)
end)

Hooks:PostHook(HUDTeammate,"set_deployable_equipment_amount","noblehud_set_deployable_equipment_amount",function(self,index,data)
	if not self._main_player then 
		return
	end
	NobleHUD:_set_deployable_amount(index)
end)

Hooks:PostHook(HUDTeammate,"set_deployable_equipment_from_string","noblehud_set_deployable_from_string",function(self,data)
	if not self._main_player then 
		return
	end
	NobleHUD:log("set_deployable_equipment_from_string(" .. table.concat(data,",") .. ")")
	NobleHUD:_set_deployable_equipment(data.index)
end)

Hooks:PostHook(HUDTeammate,"set_deployable_equipment_amount_from_string","noblehud_set_deployable_amount_from_string",function(self,index,data)
	if not self._main_player then 
		return
	end
	NobleHUD:_set_deployable_amount(index)
end)

function HUDTeammate:add_special_equipment(data,...)
	local panel_size = 32
	local equipment_panel = NobleHUD._equipment_panel:panel({
		name = data.id,
		x = 0, --NobleHUD._equipment_panel:w() - ((#self._special_equipment + 2) * panel_size),
		y = 0,
		layer = 0,
		w = panel_size,
		h = panel_size
	})
	local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
	local amount,amount_bg
	local bitmap = equipment_panel:bitmap({
		name = "bitmap",
		texture = icon,
		texture_rect = texture_rect,
		rotation = 360,
		layer = 2,
--		alpha = 0.01
		color = Color.white
	})
	
	amount_bg = equipment_panel:child("amount_bg") or equipment_panel:bitmap({
		name = "amount_bg",
		texture = "guis/textures/pd2/equip_count",
		rotation = 360,
		layer = 2,
		visible = data.amount and true or false,
		color = Color.white
	})
	amount = equipment_panel:child("amount") or equipment_panel:text({
		name = "amount",
		vertical = "center",
		font_size = 12,
		align = "center",
		font = "fonts/font_small_noshadow_mf",
		rotation = 360,
		layer = 3,
		text = tostring(data.amount),
		color = Color.black,
		visible = data.amount and true or false,
		w = panel_size,
		h = panel_size
	})
	
	amount_bg:set_center(bitmap:center())
	amount_bg:move(7, 7)
	amount_bg:set_visible(data.amount and (data.amount > 1) or false)
	amount:set_center(amount_bg:center())
	amount:set_visible(data.amount and (data.amount > 1) or false)
	table.insert(self._special_equipment, equipment_panel)
	NobleHUD:layout_equipments(self._special_equipment,data.id)
end

function HUDTeammate:remove_special_equipment(equipment)
	local eq_panel = NobleHUD._equipment_panel
	for i,panel in pairs(self._special_equipment) do 
		if panel:name() == equipment then 
			local data = table.remove(self._special_equipment,i)
			panel:child("bitmap"):set_color(Color(0.5,0.5,0.5))
			NobleHUD:animate(panel,"animate_fadeout",function(o) eq_panel:remove(o) end,0.66)
			NobleHUD:layout_equipments(self._special_equipment)
			return
		end
	end
end

function HUDTeammate:set_special_equipment_amount(equipment_id, amount)
	local eq_panel = NobleHUD._equipment_panel
	local special_equipment = self._special_equipment

	for i, panel in ipairs(special_equipment) do
		if panel:name() == equipment_id then
			panel:child("amount"):set_text(tostring(amount))
			panel:child("amount"):set_visible(amount > 1)
			panel:child("amount_bg"):set_visible(amount > 1)
			return
		end
	end
end

Hooks:PostHook(HUDTeammate,"clear_special_equipment","noblehud_clearequipment",function(self)
	local eq = NobleHUD._equipment_panel
	if alive(eq) then 
		eq:parent():remove(eq)
	end
	NobleHUD:_create_equipment_panel()
end)

Hooks:PostHook(HUDTeammate,"set_grenades","noblehud_set_grenades",function(self,data)
	if not self._main_player then 
		return
	end
	NobleHUD:_set_grenades(data)
end)

Hooks:PostHook(HUDTeammate,"set_grenades_amount","noblehud_set_grenades_amount",function(self,data)
	if not self._main_player then 
		return
	end
	NobleHUD:_set_grenades_amount(data.amount)
end)

Hooks:PostHook(HUDTeammate,"activate_ability_radial","noblehud_activate_ability_radial",function(self,time_left,time_total)
	if not self._main_player then 
		return
	end


	if time_total then 
		NobleHUD:_activate_ability_radial(time_left or time_total,time_total)
	elseif time_left then 
		--set timer countdown
		NobleHUD:_activate_ability_radial(time_left,time_left)
	end
--[[
--on activation i guess
--todo some effect for this
	if self._main_player then
		local grenades_panel = self._khud_grenades_panel
		local grenades_recharge = grenades_panel:child("grenades_bg"):child("grenades_recharge")		
		local grenades_amount = grenades_panel:child("grenades_amount")	
		
		if time_total then 
			local progress = time_left / time_total

			local here = 1 - (math.sin((60 * Application:time()) % 60) * (1 - progress))
			
			grenades_recharge:set_gradient_points({
				0,
				Color.black,
				here,
				Color.red,
				progress + 0.01,
				Color.white,
				progress,
				Color.black,
				1,
				Color.black
			})	
		elseif time_left then
--			local ability = managers.player:get_specialization_ability()
			local ability = managers.blackmarket:equipped_grenade()
			if ability then 
				managers.player:add_buff(ability,{duration = time_left})
			end
		end
	end
	--]]
end)

Hooks:PostHook(HUDTeammate,"set_grenade_cooldown","noblehud_set_grenade_cooldown",function(self,data)
--sicario uses this instead of activate_ability
--also, this is called once at the start on use for things like stoic
	if self._main_player then
		if not PlayerBase.USE_GRENADES then
			return
		end
		
		NobleHUD:_set_grenade_cooldown(data)
	end
--[[

		local end_time = data and data.end_time
		local duration = data and data.duration	
		
		if not (end_time and duration) then 
			return
		end

		local complete_duration = 0.75
		local complete_time = end_time + complete_duration
		
		
		local grenades_panel = self._khud_grenades_panel:child("grenades_bg")
		local grenades_border = grenades_panel:child("panel_borders")
		local grenades_recharge = grenades_panel:child("grenades_recharge")
		grenades_recharge:set_visible(true)
				
		local max_w = grenades_panel:w()
		local max_h = grenades_panel:h()
		
		local function animate_recharge(o)
			repeat
				local now = managers.game_play_central:get_heist_timer()
				local time_left = end_time - now
				local progress = time_left / duration
				
	--			local streak = math.tan(now * -250)
	--			local streak_color = Color.red:with_alpha(streak > 1 and (0.5 * (1 - math.sin((now - 2) * -500))) or 1)
	--			local streak_color = Color.red:with_alpha(streak > 1 and (math.sin(now) + 0.5) or 0) 
	--			math.clamp(streak,0,1)
	--			local streak = math.clamp(math.tan(now * 100),0,1)
					
	--			local here = 1 + (progress - math.sin((100 * now) % 60))
				local here = 1 - (math.sin((60 * now) % 60) * (1 - progress))
							
				
				o:set_gradient_points({
					0,
					Color.black,
					here,
					Color.red,
					progress + 0.01,
					Color.white,
					progress,
					Color.black,
					1,
					Color.black
				})
				
	--			o:set_w(grenades_panel:w() * progress)
				
				coroutine.yield()
			until time_left <= 0
			grenades_recharge:set_visible(false)

			repeat
				local nao = managers.game_play_central:get_heist_timer()
				local thyme_left = complete_time - nao
				local pawgress = thyme_left / complete_duration

				panel_border(grenades_border,{
					thickness = 2,
					alpha = 0.7,
					layer = 3,
					margin = thyme_left * max_w
				})
			
				coroutine.yield()
			until thyme_left <= 0
		end
						
		panel_border(grenades_border,{
			thickness = 2,
			alpha = 0.7,
			layer = 3,
			margin = 0
		})
		grenades_recharge:stop()
		grenades_recharge:animate(animate_recharge)
		--]]
end)


--caution! under construction! 
if true then return end 


Hooks:PostHook(HUDTeammate,"set_ability_radial","khud_set_ability_radial",function(self,data)
--used for abilities' cooldowns (kingpin, stoic, tag team, hacker)
	if self._main_player then
		local current = data.current
		local total = data.total
		local progress = current / total	

	self:log("GRENADES DATA")
	self:log("grenades current: " .. current)
	self:log("grenades total: " .. total)
	self:log("grenades progress: " .. progress)
--[[		
		local grenades_panel = self._khud_grenades_panel
		local grenades_recharge = grenades_panel:child("grenades_bg"):child("grenades_recharge")		
		
		local here = 1 - (math.sin((60 * Application:time()) % 60) * (1 - progress))
		grenades_recharge:set_gradient_points({
			0,
			Color.black,
			here,
			Color.red,
			progress + 0.01,
			Color.white,
			progress,
			Color.black,
			1,
			Color.black
		})
--]]
--		grenades_recharge:set_h(grenades_panel:h() * progress)
--		grenades_recharge:set_alpha(progress)
	end
	--todo
end)

Hooks:PostHook(HUDTeammate,"set_name","noblehud_set_teammate_name",function(self,name)
	NobleHUD:_set_tabscreen_teammate_name(self._peer_id or self._id or 5,name)
end)

local orig_animate_absorb = HUDTeammate._animate_update_absorb
function HUDTeammate:_animate_update_absorb(o, radial_absorb_shield_name, radial_absorb_health_name, var_name, blink,...)
	if (self._main_player and not KineticHUD:HUD_Enabled_Player()) or not (self._main_player or KineticHUD:HUD_Enabled_Team()) then 
		return orig_animate_absorb(self,o, radial_absorb_shield_name, radial_absorb_health_name, var_name, blink,...)
	end
--todo clean this up a bit
	repeat
		coroutine.yield()
	until alive(self._panel) and self[var_name] and self._armor_data and self._health_data
	
	local absorb_panel = self._khud_health_panel:child("bar_absorb_panel")
	local absorb_active = absorb_panel:child("bar_absorb_active_rect")
	local absorb_stacks = absorb_panel:child("bar_absorb_rect")
	local absorb_label = absorb_panel:child("absorb_label")
	local ab1 = absorb_panel:child("ab1")
	local ab2 = absorb_panel:child("ab2")

	local teammate_panel = self._panel:child("player")
	local radial_health_panel = self._radial_health_panel
	local radial_shield = radial_health_panel:child("radial_shield")
	local radial_health = radial_health_panel:child("radial_health")
	local radial_absorb_shield = radial_health_panel:child(radial_absorb_shield_name)
	local radial_absorb_health = radial_health_panel:child(radial_absorb_health_name)
	local radial_shield_rot = radial_shield:color().r
	local radial_health_rot = radial_health:color().r

	radial_absorb_shield:set_rotation((1 - radial_shield_rot) * 360)
	radial_absorb_health:set_rotation((1 - radial_health_rot) * 360)

	local current_absorb = 0
	local current_shield, current_health = nil
	local step_speed = 1
	local lerp_speed = 1
	local dt, update_absorb = nil
	local t = 0

	while alive(teammate_panel) do
		dt = coroutine.yield()

		if self[var_name] and self._armor_data and self._health_data then
			update_absorb = false
			current_shield = self._armor_data.current
			current_health = self._health_data.current

			if radial_shield:color().r ~= radial_shield_rot or radial_health:color().r ~= radial_health_rot then
				radial_shield_rot = radial_shield:color().r
				radial_health_rot = radial_health:color().r

				radial_absorb_shield:set_rotation((1 - radial_shield_rot) * 360)
				radial_absorb_health:set_rotation((1 - radial_health_rot) * 360)

				update_absorb = true
			end

			if current_absorb ~= self[var_name] then
				current_absorb = math.lerp(current_absorb, self[var_name], lerp_speed * dt)
				current_absorb = math.step(current_absorb, self[var_name], step_speed * dt)
				update_absorb = true
			end

			if blink then
				t = (t + dt * 0.5) % 1

				radial_absorb_shield:set_alpha(math.abs(math.sin(t * 180)) * 0.25 + 0.75)
				radial_absorb_health:set_alpha(math.abs(math.sin(t * 180)) * 0.25 + 0.75)
			end

			if update_absorb and current_absorb > 0 then
				
				
				local shield_ratio = current_shield == 0 and 0 or math.min(current_absorb / current_shield, 1)
				local health_ratio = current_health == 0 and 0 or math.min((current_absorb - shield_ratio * current_shield) / current_health, 1)
				local shield = math.clamp(shield_ratio * radial_shield_rot, 0, 1)
				local health = math.clamp(health_ratio * radial_health_rot, 0, 1)

				radial_absorb_shield:set_color(Color(1, shield, 1, 1))
				radial_absorb_health:set_color(Color(1, health, 1, 1))
				radial_absorb_shield:set_visible(shield > 0)
				radial_absorb_health:set_visible(health > 0)
				
				--offy wuz hear
				absorb_active:set_w(shield * absorb_panel:w())
--				absorb_label:set_text("abs " .. tostring(math.floor(current_absorb*100)))
--				ab1:set_text("hp " .. health)--tostring(math.floor(health*100)))
--				ab2:set_text("arm " .. tostring(math.floor(shield*100)))
			end
		end
	end
end


function HUDTeammate:set_noblehud_deployable_equipment(data)
	local index = data.index or managers.player._equipment.selected_index or 1--added data.index
	local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
	local deployable_equipment_panel = self._khud_deployables_panel:child(index == 2 and "secondary_deployable" or "primary_deployable")	
	local equipment = deployable_equipment_panel:child("icon")
	local amount = deployable_equipment_panel:child("amount")


	local color = Color.white
	if data.amount then 
		if type(data.amount) == "table" then
			color = Color(0.5,1,1,1)
			for k,v in pairs(data.amount) do
				if v ~= 0 then 
					color = Color.white
					break
				end
			end
		elseif (data.amount == 0) then 
			color = Color(0.5,1,1,1) --redundant
		end
	end
	
	equipment:set_color(color)
	equipment:set_image(icon, unpack(texture_rect))
	deployable_equipment_panel:set_visible(true)
--		amount:set_visible(true)
	
--	self:set_deployable_equipment_amount(index, data)		
end
