
--[[
Hooks:PreHook(HUDObjectives,"remind_objective","noblehud_remindobjectives",function(self,id)

	if id == self._active_objective_id then
		local objective_panel = NobleHUD._objectives_panel:child("objectives_label")
		objective_panel:stop()
		
		objective_panel:animate(callback(self,self,"_animate_objective_flash"))
	end
end)
--]]
Hooks:PreHook(HUDObjectives,"activate_objective","noblehud_activateobjective",function(self,data)
	local objectives_panel = NobleHUD._objectives_panel
	local objectives_label = objectives_panel:child("objectives_label")
	local objectives_label_shadow = objectives_panel:child("objectives_label_shadow")
	local objectives_title = objectives_panel:child("objectives_title")

	objectives_label:stop()
	objectives_label:hide()
	objectives_label:set_text(utf8.to_upper(data.text))
	objectives_label_shadow:stop()
	objectives_label_shadow:hide()
	objectives_label_shadow:set_text(utf8.to_upper(data.text))
	local _,_,label_w,_ = objectives_label:text_rect()
	
	local _,_,title_w,_ = objectives_title:text_rect()




	
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

	local blink_label = NobleHUD._objectives_panel:child("blink_label")
	local blink_title = NobleHUD._objectives_panel:child("blink_title")
	blink_title:stop()
	blink_label:stop()
	blink_label:animate(function()animate_blink(blink_title,title_w,function()objectives_label:animate(callback(self,self,"_animate_objective_flash"))end)end)
	blink_label:animate(function()animate_blink(blink_label,label_w,function()objectives_label_shadow:animate(callback(self,self,"_animate_objective_flash"))end)end)

	
--	
--	
	--todo tv blinkyflash intro these first, and then animate these in
	
end)

function HUDObjectives:_animate_dot_flash(o)
	--not used
end

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