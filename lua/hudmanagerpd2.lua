
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
