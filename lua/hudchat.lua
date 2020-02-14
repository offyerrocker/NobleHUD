
Hooks:PostHook(HUDChat,"init","noblehud_init_hudchat",function(self,ws, hud)
--	self._panel:set_x(hud.panel:w() - self._panel:w() + - 16)
--[[
	local bg = self._panel:rect({
		name = "noblehud_chat_bg",
		color = Color.black,
		alpha = 0,
		layer = -1 --below everything else
	})
--]]
	local bg = self._panel:bitmap({
		name = "noblehud_chat_bg",
		texture = "guis/textures/pd2/hud_tabs",
		texture_rect = {
			84,0,44,32
		},
		w = self._panel:w(),
		h = self._panel:h(),
		alpha = 0,
		visible = false, --frankly, that shit's obnoxious. not sure why i made the damned thing
		layer = -1 --below everything else
	})
	
	local icon_texture,icon_rect = tweak_data.hud_icons:get_icon_data("pd2_talk")
	--wp_talk
	--pd2_talk
	
	local new_message_icon = self._panel:bitmap({
		name = "new_message_icon",
		layer = 5,
		texture = icon_texture,
		texture_rect = icon_rect,
--		w = 100,
--		h = 100,
		color = NobleHUD.color_data.hud_weapon_color,
		alpha = 0,
		visible = true
	})
	new_message_icon:set_y(self._panel:h() - new_message_icon:h())
end)



local orig_receive_message = HUDChat.receive_message
function HUDChat:receive_message(name,message,color,icon,...)
	if NobleHUD:IsSafeMode() then 
		return orig_receive_message(self,name,message,color,icon,...)
	end

	if NobleHUD:IsChatNotificationSoundEnabled() then
		local notif_sfx = NobleHUD.chat_notification_sounds[NobleHUD:GetChatNotificationSound()]
		if NobleHUD._cache.loaded then
			XAudio.Source:new(XAudio.Buffer:new(NobleHUD._mod_path .. "assets/snd/ui/" .. notif_sfx))
		end
	end	
	if NobleHUD:IsChatAutoshowEnabled() or (NobleHUD:GetChatTimestampMode() < 3) then	
		local output_panel = self._panel:child("output_panel")
		local x = 0
		local icon_bitmap = nil

		if icon then
			local icon_texture, icon_texture_rect = tweak_data.hud_icons:get_icon_data(icon)
			icon_bitmap = output_panel:bitmap({
				y = 1,
				texture = icon_texture,
				texture_rect = icon_texture_rect,
				color = color
			})
			x = icon_bitmap:right()
		end

		local text = name .. ": "
		local name_len = utf8.len(text)
		local timestamp_text = ""
		local timestamp_mode = NobleHUD:GetChatTimestampMode()
		if timestamp_mode == 1 then --ingame timer
			timestamp_text = "[" .. os.date("%X",managers.game_play_central:get_heist_timer() + (3600 * 8)) .. "] "
			text = timestamp_text .. text
		elseif timestamp_mode == 2 then --realtime timer
			timestamp_text = "[" .. os.date("%X") .. "] "
			text = timestamp_text .. text
		end
		local timestamp_len = utf8.len(timestamp_text)
		
		text = text .. message
		local line = output_panel:text({
			halign = "left",
			vertical = "top",
			hvertical = "top",
			wrap = true,
			align = "left",
			blend_mode = "normal",
			word_wrap = true,
			y = 0,
			layer = 0,
			text = text,
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = x,
			color = color
		})
		local total_len = utf8.len(line:text())

		if timestamp_mode < 3 then 
			
			line:set_range_color(0, timestamp_len, NobleHUD.color_data.hud_text_blue)
			line:set_range_color(timestamp_len,name_len, color)
			line:set_range_color(timestamp_len + name_len,total_len, NobleHUD.color_data.hud_text)
		else
			line:set_range_color(0, name_len, color)
			line:set_range_color(name_len,total_len, NobleHUD.color_data.hud_text)
		end


		local _, _, w, h = line:text_rect()

		line:set_h(h)
		table.insert(self._lines, {
			line,
			icon_bitmap
		})
		line:set_kern(line:kern())
		self:_layout_output_panel()
		if NobleHUD:IsChatAutoshowEnabled() then
			NobleHUD:SetChatVisible(true)
			if NobleHUD:GetChatAutohideMode() < 3 then
				NobleHUD:AddDelayedCallback(function()
					NobleHUD:SetChatVisible(false)
					end,nil,NobleHUD:GetChatAutohideTimer(),"autohide_chat"
				)
			end
		else
			if NobleHUD:IsChatNotificationIconEnabled() and not (self._focus or NobleHUD._cache.chat_wanted) then
				NobleHUD:DoChatNotification(true)
			end	
		end
	else	
		return orig_receive_message(self,name,message,color,icon,...)
	end

end

Hooks:PreHook(HUDChat,"_loose_focus","noblehud_onlosefocus_hudchat",function(self)
	if not self._focus then
		return
	end

	NobleHUD:DoChatNotification(false)
			
	local hide_mode = NobleHUD:GetChatAutohideMode()
	local bg = self._panel:child("noblehud_chat_bg")
	if hide_mode < 3 then
		NobleHUD:AddDelayedCallback(function()
				NobleHUD:DoChatNotification(false)
				NobleHUD._cache.chat_wanted = false
				NobleHUD:animate(bg,"animate_fadeout",function(o)
						o:hide()
					end,
					0.5,
					bg:alpha()
				)
			end,nil,NobleHUD:GetChatAutohideTimer(),"autohide_chat"
		)
	end
end)


Hooks:PreHook(HUDChat,"_on_focus","noblehud_onfocus_hudchat",function(self)
	if self._focus then
		return
	end
	NobleHUD._cache.chat_wanted = true
	local bg = self._panel:child("noblehud_chat_bg")
	bg:show()
	NobleHUD:RemoveDelayedCallback("autohide_chat")
	NobleHUD:animate(bg,"animate_fadein",nil,0.5,0.5)
end)

function HUDChat:_animate_fade_output_immediate()
	local fade_t = 1
	local t = 0
	while t < fade_t do
		local dt = coroutine.yield()
		t = t + dt

		self:set_output_alpha(1 - t / fade_t)
	end
	self:set_output_alpha(0)
end

function HUDChat:_animate_fade_output()
	local wait_t = NobleHUD:GetChatAutohideTimer()
	local fade_t = 1
	local t = 0
	
	if NobleHUD:GetChatAutohideMode() < 3 then 
		while t < wait_t do
			local dt = coroutine.yield()
			t = t + dt
		end

		local t = 0

		while t < fade_t do
--			NobleHUD._cache.chat_wanted = false
			local dt = coroutine.yield()
			t = t + dt

			self:set_output_alpha(1 - t / fade_t)
		end
		self:set_output_alpha(0)
	end
end


Hooks:PostHook(HUDChat,"_on_focus","noblehud_on_chatfocus",function(self)
	NobleHUD:ClearChatNotification()
end)


