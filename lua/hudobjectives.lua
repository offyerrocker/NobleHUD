
--[[
Hooks:PreHook(HUDObjectives,"remind_objective","noblehud_remindobjectives",function(self,id)

	if id == self._active_objective_id then
		local objective_panel = NobleHUD._objectives_panel:child("objectives_label")
		objective_panel:stop()
		
		objective_panel:animate(callback(self,self,"_animate_objective_flash"))
	end
end)
--]]
local orig_HUDBGBox_create = HUDBGBox_create
function HUDBGBox_create(...)
	local result = orig_HUDBGBox_create(...)
	result:hide()
	return result
end

--just... fuck aaaaaall yaaaall
function HUDBGBox_animate_open_right(panel, wait_t, target_w, done_cb)
end
function HUDBGBox_animate_close_right(panel, done_cb)
end
function HUDBGBox_animate_open_left(panel, wait_t, target_w, done_cb, config)
end
function HUDBGBox_animate_close_left(panel, done_cb)
end
function HUDBGBox_animate_open_center(panel, wait_t, target_w, done_cb, config)
end
function HUDBGBox_animate_close_center(panel, done_cb)
end
function HUDBGBox_animate_bg_attention(bg, config)
end
--[[
Hooks:PostHook(HUDObjectives,"init","noblehud_objectiveinit",function(self,hud)
	self._hud_panel:child("objectives_panel")
end)
function HUDObjectives:_animate_show_text(objective_text, amount_text)
end
function HUDObjectives:_animate_complete_objective(objectives_panel)
end
function HUDObjectives:_animate_activate_objective(objectives_panel)
end
function HUDObjectives:_animate_icon_objectivebox(icon_objectivebox)
end
function HUDObjectives:open_right_done(uses_amount)
end
--]]

--overridden
function HUDObjectives:activate_objective(data)
	self._active_objective_id = data.id
	if data.amount then
		self:update_amount_objective(data)
	end	
	
	local objectives_panel = NobleHUD._objectives_panel
	local objectives_label = objectives_panel:child("objectives_label")
	local objectives_label_shadow = objectives_panel:child("objectives_label_shadow")
	local objectives_title = objectives_panel:child("objectives_title")
	local objectives_title_shadow = objectives_panel:child("objectives_title_shadow")
--return NobleHUD._objectives_panel:child("objectives_label_shadow")
--	objectives_label:stop()
--	objectives_label:hide()
--	objectives_label_shadow:stop()
--	objectives_label_shadow:hide()

	NobleHUD:SetObjectiveLabel(utf8.to_upper(data.text))

--	objectives_label:set_text(utf8.to_upper(data.text))
--	objectives_label_shadow:set_text(utf8.to_upper(data.text))
	local _,_,label_w,_ = objectives_label:text_rect()
	
	local _,_,title_w,_ = objectives_title:text_rect()

	local blink_label = NobleHUD._objectives_panel:child("blink_label")
	local blink_title = NobleHUD._objectives_panel:child("blink_title")

--	objectives_title:set_kern(-2)
--	objectives_title:set_font_size(0)

	local kern = -2
	local label_font_size = 28
	local title_font_size = 24
	local duration = 0.2
	objectives_title:set_alpha(1)
	objectives_title_shadow:set_alpha(1)
	objectives_label:set_font_size(0)
	objectives_label:set_kern(kern)
	objectives_label:set_alpha(1)
	objectives_label_shadow:set_font_size(0)
	objectives_label_shadow:set_kern(kern)
	objectives_label_shadow:set_alpha(1)
	blink_label:set_w(label_w)
	blink_title:set_w(title_w)
	
--for i=0,10 do Log(math.bezier({0,1,0,1},i/10)) end
	--local blink_label = NobleHUD._objectives_panel:child("blink_label"); local mid_x = NobleHUD._objectives_panel:w() / 2; local objectives_label = NobleHUD._objectives_panel:child("objectives_label"); local _,_,label_w,_ = objectives_label:text_rect(); NobleHUD:animate(blink_label,"animate_objective_blink",function() NobleHUD:animate(objectives_label,"animate_objective_flash",nil,0.2,28,-2) end,0.25,label_w,mid_x)
	local function fadeout_title()
		NobleHUD:AddDelayedCallback(
			function()
				NobleHUD:animate(objectives_title,"animate_fadeout",nil,0.5)
				NobleHUD:animate(objectives_title_shadow,"animate_fadeout",nil,0.5)
			end,
			nil,
			5,
			"fadeout_objective_title"
		)
	end
	local function fadeout_label()
		NobleHUD:AddDelayedCallback(
			function()
				NobleHUD:animate(objectives_label,"animate_fadeout",nil,0.5)
				NobleHUD:animate(objectives_label_shadow,"animate_fadeout",nil,0.5)
			end,
			nil,
			4,
			"fadeout_objective_label"
		)
	end
	local function animate_objective_text_in()
		NobleHUD:animate(objectives_label,"animate_objective_flash",fadeout_label,duration,label_font_size,kern)
		NobleHUD:animate(objectives_label_shadow,"animate_objective_flash",nil,duration,label_font_size,kern)
	end
	local mid_x = objectives_panel:w() / 2
	NobleHUD:animate(blink_label,"animate_objective_blink",animate_objective_text_in,0.25,label_w,mid_x)
	NobleHUD:animate(blink_title,"animate_objective_blink",fadeout_title,0.25,title_w,mid_x)
end	

--overridden
--[[
function HUDObjectives:remind_objective(id)

	if id == self._active_objective_id then
		local objectives_panel = NobleHUD._objectives_panel
		local objectives_label = objectives_panel:child("objectives_label")
		local objectives_label_shadow = objectives_panel:child("objectives_label_shadow")
		local objectives_title = objectives_panel:child("objectives_title")
		local objectives_title_shadow = objectives_panel:child("objectives_title_shadow")
		NobleHUD:SetObjectiveLabel(utf8.to_upper(data.text))

		local _,_,label_w,_ = objectives_label:text_rect()
		
		local _,_,title_w,_ = objectives_title:text_rect()

		local blink_label = NobleHUD._objectives_panel:child("blink_label")
		local blink_title = NobleHUD._objectives_panel:child("blink_title")

		local kern = -2
		local label_font_size = 28
		local title_font_size = 24
		local duration = 0.2
		objectives_label:set_font_size(0)
		objectives_label:set_kern(kern)
		objectives_label_shadow:set_font_size(0)
		objectives_label_shadow:set_kern(kern)
		blink_label:set_w(label_w)
		blink_title:set_w(title_w)

		local function fadeout_title()
			NobleHUD:AddDelayedCallback(
				function()
					NobleHUD:animate(objectives_title,"animate_fadeout",nil,0.5)
					NobleHUD:animate(objectives_title_shadow,"animate_fadeout",nil,0.5)
				end,
				nil,
				5,
				"fadeout_objective_title"
			)
		end
		local function fadeout_label()
			NobleHUD:AddDelayedCallback(
				function()
					NobleHUD:animate(objectives_label,"animate_fadeout",nil,0.5)
					NobleHUD:animate(objectives_label_shadow,"animate_fadeout",nil,0.5)
				end,
				nil,
				4,
				"fadeout_objective_label"
			)
		end

		NobleHUD:animate(blink_label,"animate_objective_blink",function() NobleHUD:animate(objectives_label,"animate_objective_flash",fadeout_label,duration,label_font_size,kern); NobleHUD:animate(objectives_label_shadow,"animate_objective_flash",nil,duration,label_font_size,kern) end,0.25,label_w)
		NobleHUD:animate(blink_title,"animate_objective_blink",fadeout_title,0.25,title_w)
	end
end
--]]
--overridden
--[[
function HUDObjectives:update_amount_objective(data)

	local objectives_panel = NobleHUD._objectives_panel
	local objectives_label = objectives_panel:child("objectives_label")
	local objectives_label_shadow = objectives_panel:child("objectives_label_shadow")
	local objectives_title = objectives_panel:child("objectives_title")
	local objectives_title_shadow = objectives_panel:child("objectives_title_shadow")

	if data.id == self._active_objective_id then
		local current = data.current_amount or 0
		local amount = data.amount
		local objectives_panel = self._hud_panel:child("objectives_panel")
		local amount_text = objectives_panel:child("amount_text")

		if alive(amount_text) then
			amount_text:set_text(current .. "/" .. amount)
		end
	end
end
	--]]
--[[
Hooks:PreHook(HUDObjectives,"activate_objective","noblehud_activateobjective",function(self,data)
	local function animate_blink(o,w,done_cb)
		local duration = 0.25
		o:set_width(w)
		local elapsed = 0
		local go = true
		while go do 
			local dt = coroutine.yield()
			elapsed = elapsed + dt
			local scale = elapsed / duration
			if scale > 1 then 
				scale = 1
				go = false
			end
			o:set_width(w * (1 - scale))
			o:set_alpha(w * (1 - scale))
		end
		done_cb()
	end
	
	blink_title:stop()
	blink_label:stop()
	blink_label:animate(function()animate_blink(blink_title,title_w,function() objectives_label:animate(callback(self,self,"_animate_objective_flash"))end)end)
	blink_label:animate(function()animate_blink(blink_label,label_w,function() objectives_label_shadow:animate(callback(self,self,"_animate_objective_flash"))end)end)

end)
	--]]
--	
--	
	--todo tv blinkyflash intro these first, and then animate these in
	
--[[
function HUDTemp:_animate_hide_text(text)
	local TOTAL_T = 0.5
	local t = TOTAL_T

	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt
		local vis = math.round(math.abs(math.cos(t * 360 * 3)))

		text:set_alpha(vis)
	end

	text:set_alpha(1)
	text:set_visible(false)
end
--]]

--tv "blink on" effect,
--then text scales up from ~1% to full over 0.3 seconds

--objective lasts for 5 seconds, then disappears
--"current objective" stays for 7 seconds
function HUDObjectives:_animate_objective_flash(o)
--todo exponential scaling
--todo font size stored in noblehud

	local obj_size = 28
	o:set_font_size(0)
	local duration = 0.2 --seconds to complete animation
	local kern = -2
	o:set_kern(kern)
	local elapsed = 0
	
	local go = true
	while go do--o:font_size() < obj_size do 
		local dt = coroutine.yield()
		elapsed = elapsed + dt
		
		local scale = elapsed / duration
		if scale > 1 then 
			scale = 1
			go = false
		end
		o:set_font_size(obj_size * scale)
		o:set_kern((1 - scale) * kern)
	end
	
	
	--[[ idk why previous iterations failed so badly, but they sure did loop forever. oh boy did they. 
	--uh oh fuck i hope this isn't happening in my other hud animate functions
	
	
	repeat
		local dt = coroutine.yield()
		ab = ab + dt
		local scale = ab / duration
		if scale > 1 then 
			scale = 1
		end
		if not _G.assbutt then 
			Console:Log("doing animate: " .. ab .. "," .. dt .. ", ".. scale)
			Console:Log(ab / duration)
		end
		o:set_font_size(obj_size * scale)
--		o:set_font_size(math.min(obj_size,o:font_size() + (obj_size * scale)))
		o:set_kern((1 - (o:font_size() / obj_size)) * kern)
	until o:font_size() >= obj_size --end
	--]]
	
--[[

--return NobleHUD._objectives_panel:child("objectives_label"):font_size()
	local TOTAL_T = 0.5
	local t = TOTAL_T
	o:set_visible(true)

	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt
		local vis = math.round(math.abs(math.cos(t * 360 * 3)))

		o:set_alpha(vis)
	end

	o:set_alpha(1)
	o:set_visible(false)
--]]
--[[
	local flashes_per_second = 4 --how many seconds it takes to flash once
	local flash_percentage = 0.5 --percentage of a flash that the panel is visible
	local flash_duration = 1 --duration in seconds to flash for
	local linger_duration = 4 --duration in seconds to remain after flashing
	local t = flash_duration + linger_duration
	o:set_visible(true)
	
	while t > 0 do 
		local dt = coroutine.yield()
		Console:Log("doing animate: " .. t .. ", " .. dt)
		t = t - dt
		o:set_visible((t % (1 / flashes_per_second)) < flash_percentage)
		if t < linger_time then 
			
		end
	end
	o:set_visible(false)


--]]

end