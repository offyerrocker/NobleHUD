local orig_show_hint = HUDManager.show_hint
function HUDManager:show_hint(data,...)
	if data.text then 
		NobleHUD:AddKillfeedMessage(data.text,NobleHUD._killfeed_presets.hint)
	else
		return orig_show_hint(self,data,...)
	end
end


--[[
function HUDManager:_add_name_label(data)
	
	
	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
	local last_id = self._hud.name_labels[#self._hud.name_labels] and self._hud.name_labels[#self._hud.name_labels].id or 0
	local id = last_id + 1
	local character_name = data.name
	log("Creating hud waypoint [" .. tostring(character_name) .. "] = " .. NobleHUD.table_concat(data," // "," : "))
	local rank = 0
	local peer_id = nil
	local is_husk_player = data.unit:base().is_husk_player

	if is_husk_player then
		peer_id = data.unit:network():peer():id()
		local level = data.unit:network():peer():level()
		rank = data.unit:network():peer():rank()

		if level then
			local experience = (rank > 0 and managers.experience:rank_string(rank) .. "-" or "") .. level
			data.name = data.name .. " (" .. experience .. ")"
		end
	end

	local panel = hud.panel:panel({name = "name_label" .. id})
	local radius = 24
	local interact = CircleBitmapGuiObject:new(panel, {
		blend_mode = "add",
		use_bg = true,
		layer = 0,
		radius = radius,
		color = Color.white
	})

	interact:set_visible(false)

	local tabs_texture = "guis/textures/pd2/hud_tabs"
	local bag_rect = {
		2,
		34,
		20,
		17
	}
	local color_id = managers.criminals:character_color_id_by_unit(data.unit)
	local crim_color = tweak_data.chat_colors[color_id] or tweak_data.chat_colors[#tweak_data.chat_colors]
	local text = panel:text({
		name = "text",
		vertical = "top",
		h = 18,
		w = 256,
		align = "left",
		layer = -1,
		text = data.name,
		font = tweak_data.hud.medium_font,
		font_size = tweak_data.hud.name_label_font_size,
		color = crim_color
	})
	local bag = panel:bitmap({
		name = "bag",
		layer = 0,
		visible = false,
		y = 1,
		x = 1,
		texture = tabs_texture,
		texture_rect = bag_rect,
		color = (crim_color * 1.1):with_alpha(1)
	})
	
--
	local indicator_w = 32
	local indicator_h = 64
	local debug_rect = panel:rect({
		name = "debug test",
		color = Color.red,
		alpha = 0.1
	})
	local halo_waypoint = panel:panel({
		--get it? halo waypoint? cause it's above their head but it's also like, Halo, and like Halo Waypoint, the... the website... please clap
		--i guess i was over-REACHing
		--okay i'll stop now
		name = "halo_waypoint",
		w = indicator_w,
		h = indicator_h,
		x = panel:w() / 2,
		layer = 1	
	})
	local circle = halo_waypoint:bitmap({
		name = "circle",
		texture = "guis/textures/ability_circle_fill",
		layer = 1,
		color = NobleHUD.color_data.hud_vitalsfill_blue,
		x = 0,
		y = 0,
		w = indicator_w,
		h = indicator_w,
		alpha = 1
	})
	
	local chevron_texture,chevron_rect = tweak_data.hud_icons:get_icon_data("scrollbar_arrow")
	local chevron = halo_waypoint:bitmap({
		name = "chevron",
		texture = chevron_texture,
		texture_rect = chevron_rect,
		layer = 1,
		rotation = 180,
		color = NobleHUD.color_data.hud_vitalsfill_blue,
		x = 0,
		y = indicator_w,
		w = indicator_w,
		h = indicator_w,
		alpha = 1
	})
	_G.derpaherp = _G.derpaherp or {}
	_G.derpaherp[id] = halo_waypoint 

	
--


	panel:text({
		w = 256,
		name = "cheater",
		h = 18,
		align = "center",
		visible = false,
		layer = -1,
		text = utf8.to_upper(managers.localization:text("menu_hud_cheater")),
		font = tweak_data.hud.medium_font,
		font_size = tweak_data.hud.name_label_font_size,
		color = tweak_data.screen_colors.pro_color
	})
	
	
	panel:text({
		vertical = "bottom",
		name = "action",
		h = 18,
		w = 256,
		align = "left",
		visible = false,
		rotation = 360,
		layer = -1,
		text = utf8.to_upper("Fixing"),
		font = tweak_data.hud.medium_font,
		font_size = tweak_data.hud.name_label_font_size,
		color = (crim_color * 1.1):with_alpha(1)
	})

	if rank > 0 then
		local infamy_icon = tweak_data.hud_icons:get_icon_data("infamy_icon")

		panel:bitmap({
			name = "infamy",
			h = 32,
			w = 16,
			layer = 0,
			texture = infamy_icon,
			color = crim_color
		})
	end

	self:align_teammate_name_label(panel, interact)
	table.insert(self._hud.name_labels, {
		movement = data.unit:movement(),
		panel = panel,
		text = text,
		id = id,
		peer_id = peer_id,
		character_name = character_name,
		interact = interact,
		bag = bag
	})

	return id
end

function HUDManager:align_teammate_name_label(panel, interact)
	local double_radius = interact:radius() * 2
	local text = panel:child("text")
	local action = panel:child("action")
	local bag = panel:child("bag")
	local bag_number = panel:child("bag_number")
	local cheater = panel:child("cheater")
	local _, _, tw, th = text:text_rect()
	local _, _, aw, ah = action:text_rect()
	local _, _, cw, ch = cheater:text_rect()

	panel:set_size(math.max(tw, cw) + 4 + double_radius, math.max(th + ah + ch, double_radius))
	text:set_size(panel:w(), th)
	action:set_size(panel:w(), ah)
	cheater:set_size(tw, ch)
	text:set_x(double_radius + 4)
	action:set_x(double_radius + 4)
	cheater:set_x(double_radius + 4)
	text:set_top(cheater:bottom())
	action:set_top(text:bottom())
	bag:set_top(text:top() + 4)
	interact:set_position(0, text:top())

	local infamy = panel:child("infamy")

	if infamy then
		panel:set_w(panel:w() + infamy:w())
		text:set_size(panel:size())
		infamy:set_x(double_radius + 4)
		infamy:set_top(text:top())
		text:set_x(double_radius + 4 + infamy:w())
	end
	
	local halo = panel:child("halo_waypoint")
	halo:set_x((panel:w() + halo:w()) / 2)
	if bag_number then
		bag_number:set_bottom(text:bottom() - 1)
		panel:set_w(panel:w() + bag_number:w() + bag:w() + 8)
		bag:set_right(panel:w() - bag_number:w())
		bag_number:set_right(panel:w() + 2)
	else
		panel:set_w(panel:w() + bag:w() + 4)
		bag:set_right(panel:w())
	end
end
--]]
Hooks:PostHook(HUDManager,"_setup_player_info_hud_pd2","noblehud_create_ws",function(self,hud)
	if _G.NobleHUD then 
		NobleHUD:CreateHUD(self)
	elseif Console then 
		Console:Log("HEY DIPSHIT YOU HAVE A SYNTAX ERROR IN menumanager.lua, GO FIX IT",{color = Color.red})
	else
		log("HEY DIPSHIT YOU HAVE A SYNTAX ERROR IN menumanager.lua AND YOU ALSO FORGOT TO SET UP YOUR DEBUG ENVIRONMENT",{color = Color.red})
	end
end)

function HUDManager:pd_start_progress(current, total, msg, icon_id)
	--do nothing
end

--pretty much everything below is for Auntie Dot

function HUDManager:_set_helper_pattern(pattern_name)
	local pattern = NobleHUD._helper_patterns_even[pattern_name or NobleHUD._current_helper_pattern or "dot"]
--	local pattern = NobleHUD._helper_patterns[pattern_name]
	if pattern then 
		local changed_tubes = {}
		local center_r = math.floor((NobleHUD._HELPER_ROWS - 8) / 2) + 1
		local center_c = math.floor((NobleHUD._HELPER_COLUMNS - 8) / 2) + 1
	--do row and column offsets based on grid size
		for row,c in pairs(pattern) do 
			for _,column in pairs(c) do 
				local tube_name = "tube_" .. (row + center_r) .. "_" .. (column + center_c)
				local tube = NobleHUD._helper_panel:child(tube_name)
				if tube then 
					changed_tubes[tube_name] = true
					tube:stop()
					tube:animate(callback(self,self,"_animate_helper_tube_on"))
				end
			end
		end
		
		for k,v in pairs(NobleHUD._helper_tubes) do 
			if v.tube then 
				if not changed_tubes[v.tube:name()]then 
					v.tube:stop()
					v.tube:animate(callback(self,self,"_animate_helper_tube_off"))
				end
			end
		end
	end
end

Hooks:PostHook(HUDManager,"set_disabled","noblehud_hidehud",function(self)
	NobleHUD._ws:panel():hide()
end)

Hooks:PostHook(HUDManager,"set_enabled","noblehud_showhud",function(self)
	NobleHUD._ws:panel():show()
end)


function HUDManager:_set_helper_sequence()
	NobleHUD._helper_last_sequence = math.max(1,(1 + NobleHUD._helper_last_sequence) % #NobleHUD._helper_sequences)
	local pattern_name = NobleHUD._helper_last_sequence

	local pattern = NobleHUD._helper_sequences[pattern_name or ""]
	if pattern then 
		local changed_tubes = {}
		local center_r = math.floor((NobleHUD._HELPER_ROWS - 10) / 2)
		local center_c = math.floor((NobleHUD._HELPER_COLUMNS - 10) / 2) + 1
	--do row and column offsets based on grid size
		for row,c in pairs(pattern) do 
			for _,column in pairs(c) do 
				local tube_name = "tube_" .. (row + center_r) .. "_" .. (column + center_c)
				local tube = NobleHUD._helper_panel:child(tube_name)
				if tube then 
					changed_tubes[tube_name] = true
					tube:stop()
					tube:animate(callback(self,self,"_animate_helper_tube_on_fast")) --non-flicker is broken. great
				end
			end
		end
		
		for k,v in pairs(NobleHUD._helper_tubes) do 
			if v.tube then 
				if not changed_tubes[v.tube:name()]then 
					v.tube:stop()
					v.tube:animate(callback(self,self,"_animate_helper_tube_off_fast"))
				end
			end
		end
	end
end


function HUDManager:_animate_dot_tube_off_broken(tube) --broken
	
	local MAX_ALPHA = 0.2

	local duration = 1
	local elapsed = 0
	local tube_color = tube:color()
	local desired_color = Color((0.1 * math.random()),0.25 + (math.random() * 0.15),0.9 + (0.1 * math.random()))
	local tube_alpha = tube:alpha()
	while elapsed < duration do 
		local dt = coroutine.yield()
		elapsed = elapsed + dt
		tube:set_alpha(tube_alpha + ((MAX_ALPHA - tube_alpha) * (elapsed / duration)))
		tube:set_color(NobleHUD.interp_colors(tube_color,desired_color,elapsed/duration))
	end
	tube:set_alpha(MAX_ALPHA)
	
end

function HUDManager:_animate_dot_tube_interp(tube) --why doesn't this work
	if (not NobleHUD._selected_tube) or (math.random() > 0.75) then
		NobleHUD._selected_tube = tube --todo reset tube at some point
	end
	local duration = 1
	local elapsed = 0
	local tube_alpha = tube:alpha()
	local tube_color = tube:color()
	local MIN_ALPHA = 0.95
	local desired_color = Color(math.random(155)/255,math.random(209)/255,math.random(255)/255)
	local rate = 1.4
	
	while elapsed < duration do 
--		Console:SetTrackerValue("trackera",elapsed)
		local dt = coroutine.yield()
--		Console:SetTrackerValue("trackerb",dt)
		elapsed = elapsed + dt
		tube:set_alpha(tube_alpha + ((MIN_ALPHA - tube_alpha) * (elapsed / duration)))
		tube:set_color(NobleHUD.interp_colors(tube_color,desired_color,elapsed/duration))
	end
	Log("elapsed: " .. tostring(elapsed) .. "," .. "duration: " .. tostring(duration))
	tube:set_alpha(1)
	
end

function HUDManager:_animate_dot_tube_on_broken(tube) --broken
	if (not NobleHUD._selected_tube) or (math.random() > 0.75) then
		NobleHUD._selected_tube = tube --todo reset tube at some point
	end
	local t = 1
	local tube_alpha = tube:alpha()
	local tube_color = tube:color()
	local MIN_ALPHA = 0.95
	local desired_color = Color(math.random(155)/255,math.random(209)/255,math.random(255)/255)
	local rate = 1.4
	
	while t > 0 do 
		local dt = coroutine.yield()
		t = t - dt
--		Console:SetTrackerValue("trackera",t)
--		Console:SetTrackerValue("trackerb",dt)
		tube:set_alpha(tube_alpha + ((MIN_ALPHA - tube_alpha) * t))
		tube:set_color(NobleHUD.interp_colors(tube_color,desired_color,t))
	end
	tube:set_alpha(1)
	
end

function HUDManager:_animate_helper_tube_on_fast(tube) --reduced delay; used for sequence
	if (not NobleHUD._selected_tube) or (math.random() > 0.75) then
		NobleHUD._selected_tube = tube --todo reset tube when
	end
	local MIN_ALPHA = 0.95
	local delay = 0 --math.random() / 10
	local tube_alpha = tube:alpha()
	local desired_color = Color(159/255,210/255,255/255)--Color(math.random(155)/255,math.random(209)/255,math.random(255)/255)
	local rate = 2
	
	while tube_alpha < MIN_ALPHA do --slight flicker when alpha jumps from MIN_ALPHA to 1
		local dt = coroutine.yield()
		if delay <= 0 then 
			tube_alpha = (tube_alpha + 0.15) * rate
			tube:set_alpha(tube_alpha)
--			Log(tube:name() .. "," .. dt)
			tube:set_color(NobleHUD.interp_colors(tube:color(),desired_color,0.5)) --gradually progress toward "lit" color; effectively a logarithmic function
--			tube:set_color(interp_col(tube:color(),desired_color,dt * 1.5)) --gradually progress toward "lit" color; effectively a logarithmic function
		else
			delay = delay - dt
		end
	end
	tube:set_alpha(1)
	
end

function HUDManager:_animate_helper_tube_off_fast(tube) --reduce delay; used for sequence
	
	local MAX_ALPHA = 0.2
	local delay = 0 -- math.random() / 10

	local current_color = tube:color()
	local desired_color = Color((0.1 * math.random()),0.25 + (math.random() * 0.15),0.9 + (0.1 * math.random()))
	local tube_alpha = tube:alpha()
	tube:set_color(desired_color)
	while tube_alpha > MAX_ALPHA do
		local dt = coroutine.yield()
		if delay <= 0 then 
			tube_alpha = tube_alpha * 0.5
			tube:set_alpha(tube_alpha)
		else
			delay = delay - dt
		end
	end
	tube:set_alpha(MAX_ALPHA)
	
end

function HUDManager:_animate_helper_tube_on(tube)
	if (not NobleHUD._selected_tube) or (math.random() > 0.75) then
		NobleHUD._selected_tube = tube --todo reset tube when
	end
	local MIN_ALPHA = 0.95
	local delay = math.random()
	local tube_alpha = tube:alpha()
	local desired_color = Color(math.random(155)/255,math.random(209)/255,math.random(255)/255)
	local rate = 1.2
	
	while tube_alpha < MIN_ALPHA do --slight flicker when alpha jumps from MIN_ALPHA to 1
		local dt = coroutine.yield()
		if delay <= 0 then 
			tube_alpha = tube_alpha * rate
			tube:set_alpha(tube_alpha)
			tube:set_color(NobleHUD.interp_colors(tube:color(),desired_color,dt * 1.5)) --gradually progress toward "lit" color; effectively a logarithmic function
		else
			delay = delay - dt
		end
	end
	tube:set_alpha(1)
	
end

function HUDManager:_animate_helper_tube_off_nice(tube)
	
	local MAX_ALPHA = 0.15
	local delay = (math.random() * 1.25) + 1
	
	local tube_alpha = tube:alpha()
	while tube_alpha > MAX_ALPHA do
		local dt = coroutine.yield()
		if delay <= 0 then 
			tube_alpha = tube_alpha * 0.9
			tube:set_alpha(tube_alpha)
		else
			delay = delay - dt
		end
	end
	tube:set_alpha(0.2) --normal max alpha
	
end

function HUDManager:_animate_helper_tube_off(tube)
	
	local MAX_ALPHA = 0.2
	local delay = math.random()

	local current_color = tube:color()
	local desired_color = Color((0.1 * math.random()),0.25 + (math.random() * 0.15),0.9 + (0.1 * math.random()))
	local tube_alpha = tube:alpha()
	while tube_alpha > MAX_ALPHA do
		local dt = coroutine.yield()
		if delay <= 0 then 
			tube_alpha = tube_alpha * 0.8
			tube:set_alpha(tube_alpha)
--			tube:set_color(
		else
			delay = delay - dt
		end
	end
	tube:set_alpha(MAX_ALPHA)
	
end

function HUDManager:_set_helper_all_off()
	for k,v in pairs(NobleHUD._helper_tubes) do 
		if v.tube then 
			v.tube:stop()
			v.tube:animate(callback(self,self,"_animate_helper_tube_off"))
		end
	end
end

function HUDManager:_set_helper_all_on()
	for k,v in pairs(NobleHUD._helper_tubes) do 
		if v.tube then 
			v.tube:stop()
			v.tube:animate(callback(self,self,"_animate_helper_tube_on"))
		end
	end
end

function HUDManager:_set_helper_off_nice() --todo randomly select highlighted tube when turn on, instead of random method
	--get one from somewhere in the middle four rows/columns
--	local row = math.random(4)
--	local column = math.random(4)
--	local selected = math.random(#Console._tubes)
	for k,v in pairs(NobleHUD._helper_tubes) do 
		if v.tube then 
			v.tube:stop()
			if NobleHUD._selected_tube and NobleHUD._selected_tube:name() == v.tube:name()  then 
				v.tube:animate(callback(self,self,"_animate_helper_tube_off_nice"))
			else
				v.tube:animate(callback(self,self,"_animate_helper_tube_off"))
			end
		end
	end
	
end
