if not NobleHUD then
	return
end

Hooks:PostHook(HUDTeammate,"init","noblehud_addteammate",function(self,i, teammates_panel, is_player, width)
	NobleHUD:_init_teammate(i,teammates_panel,is_player,width)
end)

Hooks:PostHook(HUDTeammate,"set_callsign","noblehud_setteammatecallsign",function(self,id)
	if HUDManager.PLAYER_PANEL ~= self._id then 
		NobleHUD:_set_teammate_color(self._id,id)
	end
end)

Hooks:PostHook(HUDTeammate,"set_name","noblehud_setteammatename",function(self,player_name)
	NobleHUD:_set_tabscreen_teammate_name(self._id or 5,player_name)
	local peer_id = self._peer_id
	if self._main_player then --HUDManager.PLAYER_PANEL == self._id then 
		NobleHUD:_set_main_player_indicator(self._id)
		NobleHUD:_set_scoreboard_character(self._id,peer_id or managers.network:session():local_peer():id())
--		NobleHUD:log("(set_name 1) NobleHUD:_set_scoreboard_character(" .. NobleHUD.table_concat({id=self._id,peer_id=managers.network:session():local_peer():id(),character_id="[nil]",player_name=player_name},"|","=",true) ..")")
		NobleHUD:_set_tabscreen_teammate_callsign(self._id,NobleHUD:GetCallsign())
	else
		local character_name  --managers.criminals:character_name_by_panel_id(self._id)
		for id, data in pairs(managers.criminals._characters or {}) do 
			if data.taken and ((self._id and data.data.panel_id == self._id) or (peer_id == data.peer_id)) then 
				character_name = data.name
				if peer_id and (peer_id == data.peer_id) then --is teammate player	
					NobleHUD:_set_scoreboard_character(self._id,peer_id,character_name)
--					NobleHUD:log("(set_name 2) NobleHUD:_set_scoreboard_character(" .. NobleHUD.table_concat({id=self._id or "nil",peer_id=peer_id or "[nil?]",character_id=character_name or "nil",player_name = player_name},"|","=",true) ..")")
				else
					NobleHUD:_set_scoreboard_character(self._id,nil,character_name) --is bot, most likely
--					NobleHUD:log("(set_name 3) NobleHUD:_set_scoreboard_character(" .. NobleHUD.table_concat({id=self._id or "nil",peer_id="nil",character_id=character_name or "nil",player_name = player_name},"|","=",true) ..")")
				end
				break
			end
		end
		
		local peer = managers.network:session():peer(peer_id)
		local id64 = peer and peer:user_id()
		local callsign = id64 and NobleHUD._cache.callsigns[id64] or NobleHUD:make_callsign_name(player_name,NobleHUD._MIN_CALLSIGN_LEN,NobleHUD._MAX_CALLSIGN_LEN,character_name)
		NobleHUD:_set_teammate_name(self._id,callsign)
		NobleHUD:_set_teammate_waypoint_name(peer_id,callsign)
	end
end)

Hooks:PostHook(HUDTeammate,"add_panel","noblehud_teammate_add_panel",function(self)
	local teammates_panel = NobleHUD._teammates_panel
	local id = self._id
	local player_box = NobleHUD._tabscreen:child("scoreboard"):child("player_box_" .. tostring(id))
	if alive(player_box) then 
--		player_box:child("downs_box"):child("downs_label"):set_text("LOAD")
--		player_box:child("name_box"):child("name_label"):set_text("LOAD")
--		player_box:child("callsign_box"):child("callsign_label"):set_text("LOAD")
--		player_box:child("score_box"):child("score_label"):set_text("LOAD")
--		player_box:child("ping_box"):child("ping_label"):set_text("LOAD")
--		player_box:child("ping_box"):child("ping_bitmap"):set_h(0)
	end
	local panel = NobleHUD:GetTeammatePanel(id)
	if alive(panel) then 
		panel:show()
	end
	NobleHUD:_sort_teammates()
end)

Hooks:PostHook(HUDTeammate,"remove_panel","noblehud_teammate_remove_panel",function(self,weapons_panel)
	local teammates_panel = NobleHUD._teammates_panel
	local id = self._id
	local player_box = NobleHUD._tabscreen:child("scoreboard"):child("player_box_" .. tostring(id))
	if alive(player_box) then 
		player_box:child("downs_box"):child("downs_label"):set_text("")
		player_box:child("name_box"):child("name_label"):set_text("")
		player_box:child("callsign_box"):child("callsign_label"):set_text("")
		player_box:child("score_box"):child("score_label"):set_text("")
		player_box:child("ping_box"):child("ping_label"):set_text("")
		player_box:child("ping_box"):child("ping_bitmap"):set_h(0)
	end
	local panel = NobleHUD:GetTeammatePanel(id)
	if alive(panel) then
		teammates_panel:remove(panel)
	end
	panel = NobleHUD:_create_teammate_panel(teammates_panel,id)
	panel:child("ties_subpanel"):hide()
	panel:child("vitals_subpanel"):hide()
	panel:child("grenade_subpanel"):hide()
	local callsign_box = panel:child("callsign_box")
	callsign_box:child("character_bitmap"):set_image("guis/textures/teammate_nameplate_vacant")
	callsign_box:child("player_name"):set_text("")
	NobleHUD:_sort_teammates()
--	panel:hide()
end)

Hooks:PostHook(HUDTeammate,"set_condition","noblehud_teammate_setcondition",function(self,icon_data, text)
	local panel = NobleHUD:GetTeammatePanel(self._id)
	local vitals_icon = panel:child("vitals_subpanel"):child("vitals_icon")
	if icon_data == "mugshot_normal" then
		vitals_icon:set_image("guis/textures/lives_icon")
	else
		local icon, texture_rect = tweak_data.hud_icons:get_icon_data(icon_data)

		vitals_icon:set_image(icon, texture_rect[1], texture_rect[2], texture_rect[3], texture_rect[4])
	end
end)

Hooks:PostHook(HUDTeammate,"set_cable_ties_amount","noblehud_setcabletiesamount",function(self,amount)
	if self._main_player then 
		NobleHUD:SetCableTies(amount)
	else
		local teammate_panel = NobleHUD:GetTeammatePanel(self._id)
		if teammate_panel then 
			local subpanel = teammate_panel:child("ties_subpanel")
			subpanel:show()
			local icon = subpanel:child("ties_icon")
			local label = subpanel:child("ties_label")
			local color = NobleHUD.color_data.hud_vitalsoutline_blue
						
			if amount == -1 then 
				label:set_text("--")
				color = Color(1,1,1) * 0.5 --grey
			else
				label:set_text(amount)
				if amount == 0 then
					color = NobleHUD.color_data.hud_blueoutline
				end
			end
			label:set_color(color)
			icon:set_color(color)
		end
	end
end)

Hooks:PostHook(HUDTeammate,"set_health","noblehud_set_health",function(self,data)
	local hp_r = tonumber(tostring(data.current / data.total))
	if self._main_player then 
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
	else
	NobleHUD:GetTeammatePanel(1)
		local teammate_panel = NobleHUD:GetTeammatePanel(self._id)
		local vitals_panel = teammate_panel:child("vitals_subpanel")
		vitals_panel:show()
		local label = vitals_panel:child("vitals_health_label")
		
		vitals_panel:child("vitals_icon"):set_color(NobleHUD.interp_colors(NobleHUD.color_data.hud_vitalsoutline_blue,NobleHUD.color_data.hud_vitalsoutline_red,1-hp_r))
		if true then --use ratio
			label:set_text(string.format("%d",hp_r * 100))
		else
			label:set_text(math.round(data.current * 10))
			if string.len(label:text()) > 3 then 
				label:set_font_size(12)
			else
				label:set_font_size(19)
			end
		end
	end
end)

Hooks:PostHook(HUDTeammate,"set_armor","noblehud_set_armor",function(self,data)
	local current = data.current
	local total = data.total
	local ratio = total ~= 0 and (current / total) or 0
	if self._main_player then 
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
	else
		local teammate_panel = NobleHUD:GetTeammatePanel(self._id)
		local vitals_panel = teammate_panel:child("vitals_subpanel")
		vitals_panel:show()
		local label = vitals_panel:child("vitals_armor_label")
		if true then --use ratio
			label:set_text(string.format("%d",ratio * 100))
		else
			label:set_text(math.round(current * 10))
			if string.len(label:text()) > 3 then 
				label:set_font_size(12)
			else
				label:set_font_size(19)
			end		
		end
		if total > 0 then
		end
			--todo set vitals icon or vitals icon bg color
	end
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
end)

Hooks:PostHook(HUDTeammate,"set_deployable_equipment","noblehud_set_deployable_equipment",function(self,data)
	if not self._main_player then 
		local teammate_panel = NobleHUD:GetTeammatePanel(self._id)
		if teammate_panel then 
			local subpanel = teammate_panel:child("deployable_subpanel")
			subpanel:show()
			local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
			subpanel:child("deployable_icon"):set_image(icon,unpack(texture_rect))
		end
	else
		NobleHUD:_set_deployable_equipment(data.index)
	end
end)

Hooks:PostHook(HUDTeammate,"set_deployable_equipment_amount","noblehud_set_deployable_equipment_amount",function(self,index,data)
	if not self._main_player then 
		local teammate_panel = NobleHUD:GetTeammatePanel(self._id)
		if teammate_panel then 
			local subpanel = teammate_panel:child("deployable_subpanel")
			local label = subpanel:child("deployable_label")
			local amount = data.amount
			if type(amount) == "table" then 
				self:set_deployable_equipment_amount_from_string(data.index,data)
			else
				local color = NobleHUD.color_data.hud_vitalsoutline_blue
				label:set_text(data.amount)
				if data.amount <= 0 then 
					color = NobleHUD.color_data.hud_vitalsfill_blue
				end
				label:set_color(color)
				subpanel:child("deployable_icon"):set_color(color)
			end
		end
	else
		NobleHUD:_set_deployable_amount(index)
	end
end)

Hooks:PostHook(HUDTeammate,"set_deployable_equipment_from_string","noblehud_set_deployable_from_string",function(self,data)
	if not self._main_player then 
		local teammate_panel = NobleHUD:GetTeammatePanel(self._id)
		if teammate_panel then 
			local subpanel = teammate_panel:child("deployable_subpanel")
			subpanel:show()
			local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
			subpanel:child("deployable_icon"):set_image(icon,unpack(texture_rect))
		end
	else
		NobleHUD:_set_deployable_equipment(data.index)
	end
end)

Hooks:PostHook(HUDTeammate,"set_deployable_equipment_amount_from_string","noblehud_set_deployable_amount_from_string",function(self,index,data)
	if not self._main_player then 
		local teammate_panel = NobleHUD:GetTeammatePanel(self._id)
		if teammate_panel then 

			local subpanel = teammate_panel:child("deployable_subpanel")
			subpanel:show()
			local amounts = ""
			local zero_ranges = {}
			local color = NobleHUD.color_data.hud_vitalsfill_blue
			
			for i, amount in ipairs(data.amount) do 
				local amount_str = string.format("%01d",amount)
				local divider = "|"
				
				if i > 1 then
					amounts = amounts .. divider
				end
				if amount == 0 then 
					local current_length = string.len(amounts)
					table.insert(zero_ranges, {
						current_length,
						current_length + string.len(amount_str)
					})
				end
				
				amounts = amounts .. amount_str
				if amount > 0 then 
					color = NobleHUD.color_data.hud_vitalsoutline_blue
				end
			end
			
			subpanel:child("deployable_icon"):set_color(color)
			
			local label = subpanel:child("deployable_label")
			
			label:set_text(amounts)
			label:set_color(color)
					
			for _, range in ipairs(zero_ranges) do
				label:set_range_color(range[1], range[2], NobleHUD.color_data.hud_vitalsfill_blue)
			end
			
		end
	else
		NobleHUD:_set_deployable_amount(index)
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





--burstfire mod support
--function HUDTeammate:set_weapon_firemode_burst(slot,firemode,burst_fire)
--	NobleHUD:_set_firemode(slot,firemode,burst_fire)
--end

Hooks:PostHook(HUDTeammate,"set_ammo_amount_by_type","noblehud_set_ammo",function(self,type,max_clip,current_clip,current_left,max,weapon_panel)
	if not self._main_player then 
		return
	end
	local slot = (type == "primary" and 2) or (type == "secondary" and 1)
	
	NobleHUD:_set_weapon_mag(slot,current_clip,max_clip)
	if NobleHUD:UseWeaponRealAmmoCounter() then 
		local total_left = math.max(0,current_left - current_clip)
--			if current_clip <= math.round(max_clip / 4) and current_clip ~= 0 then
		
		NobleHUD:_set_weapon_reserve(slot,total_left)
	else
		NobleHUD:_set_weapon_reserve(slot,math.max(current_left,0))
	end
	

--	NobleHUD:SetFloatingAmmo(current_clip,max_clip)

end)


--mission equipment stuff

function HUDTeammate:add_special_equipment(data,...)
	if self._main_player then 
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
	else
		NobleHUD:_add_teammate_equipment(self._id,data)
		NobleHUD:_layout_teammate_equipments(self._id)
	end
end

function HUDTeammate:remove_special_equipment(equipment)
	if self._main_player then 
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
	else
		NobleHUD:_remove_teammate_equipment(self._id,equipment)
		NobleHUD:_layout_teammate_equipments(self._id)
	end
end

function HUDTeammate:set_special_equipment_amount(equipment_id, amount)
	if self._main_player then 
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
	else
		NobleHUD:_set_teammate_equipment_amount(self._id,equipment_id,amount)
	end
end

Hooks:PostHook(HUDTeammate,"clear_special_equipment","noblehud_clearequipment",function(self)
	if self._main_player then
		local eq = NobleHUD._equipment_panel
		if alive(eq) then 
			eq:parent():remove(eq)
		end
		NobleHUD:_create_equipment_panel()
	else
		NobleHUD:_clear_teammate_equipments(self._id)
	end
end)



--grenades

Hooks:PostHook(HUDTeammate,"set_grenades","noblehud_set_grenades",function(self,data)
	if PlayerBase.USE_GRENADES then
		if self._main_player then
			NobleHUD:_set_grenades(data)
		else
			local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon, {
				0,
				0,
				32,
				32
			})
			
			local teammate_panel = NobleHUD:GetTeammatePanel(self._id)
			if teammate_panel then 
				local subpanel = teammate_panel:child("grenade_subpanel")
				subpanel:show()
					
				local grenade_icon = subpanel:child("grenade_icon")
				grenade_icon:set_image(icon,unpack(texture_rect))
				local grenade_label = subpanel:child("grenade_label")
				local color = NobleHUD.color_data.hud_vitalsoutline_blue
				if data.amount then
					grenade_label:set_text(data.amount)
					if data.amount == 0 then 
						color = NobleHUD.color_data.hud_vitalsfill_blue
					end
				end
				grenade_icon:set_color(color)
				grenade_label:set_color(color)
			end
		end
	end
end)

Hooks:PostHook(HUDTeammate,"set_grenades_amount","noblehud_set_grenades_amount",function(self,data)
	if self._main_player then 
		NobleHUD:_set_grenades_amount(data.amount)		
	else
		local teammate_panel = NobleHUD:GetTeammatePanel(self._id)
		local subpanel = teammate_panel and teammate_panel:child("grenade_subpanel")
		local grenade_label = subpanel and subpanel:child("grenade_label")
		if data.amount and alive(grenade_label) then 
			if data.amount <= 0 then 
				subpanel:child("grenade_icon"):set_color(NobleHUD.color_data.hud_vitalsfill_blue)
				grenade_label:set_color(NobleHUD.color_data.hud_vitalsfill_blue)
			else
				subpanel:child("grenade_icon"):set_color(NobleHUD.color_data.hud_vitalsoutline_blue)
				grenade_label:set_color(NobleHUD.color_data.hud_vitalsoutline_blue)
			end
			grenade_label:set_text(data.amount)
		end
	end
end)

Hooks:PostHook(HUDTeammate,"set_ability_radial","noblehud_set_ability_radial",function(self,data)
--used for abilities' cooldowns -kingpin, tag team, and hacker. NOT Stoic since that's immediate activation + effect, not duration
	if self._main_player then
		NobleHUD:_set_ability_radial(data.current,data.total)
	else
		--todo teammate grenade ability display
	end
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

end)

Hooks:PostHook(HUDTeammate,"set_grenade_cooldown","noblehud_set_grenade_cooldown",function(self,data)
--sicario uses this instead of activate_ability
--also, this is called once at the start on use for things like stoic, since stoic's ability is an instant use event and not an active duration 
	if not PlayerBase.USE_GRENADES then
		return
	end
	if self._main_player then
		NobleHUD:_set_grenade_cooldown(data)
	else	
		--todo teammates: pulse grenade icon w/ ghost when effect active
	end
end)



--caution! under construction! 
if true then return end 

--Hooks:PostHook(HUDTeammate,"set_ai","noblehud_set_teammate_ai",function(self,ai)
--end)

--[[
Hooks:PostHook(HUDTeammate,"set_custom_radial","noblehud_set_custom_radial",function(self,data)
		NobleHUD:log("set_custom_radial() [")
		logall(data)
		NobleHUD:log("]")
end)
--]]


Hooks:PostHook(HUDTeammate,"set_teammate_weapon_firemode","noblehud_set_teammate_firemode",function(self,slot,firemode)
--
end)
