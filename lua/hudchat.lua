
Hooks:PostHook(HUDChat,"init","noblehud_init_hudchat",function(self,ws, hud)
--	self._panel:set_x(hud.panel:w() - self._panel:w() + - 16)
	local bg = self._panel:rect({
		name = "noblehud_chat_bg",
		color = Color.black,
		alpha = 0,
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
		alpha = 1,
		visible = true
	})
	new_message_icon:set_y(self._panel:h() - new_message_icon:h())
end)


Hooks:PreHook(HUDChat,"_loose_focus","noblehud_onlosefocus_hudchat",function(self)
	if not self._focus then
		return
	end
	--[[
	local bg = self._panel:child("noblehud_chat_bg")
	NobleHUD:animate(bg,"animate_fadeout",function(o)
			o:hide()
		end,
		0.5,
		bg:alpha()
	)
	--]]
	
	local notif_mode = NobleHUD:GetChatNotificationMode()
	if (notif_mode == 1) or (notif_mode == 3) then
		if not (self._panel:visible() and self._panel:alpha() >= 1)  then
			NobleHUD:DoChatNotification(true)
		end
	end
	if (notif_mode == 2) or (notif_mode == 3) then 
		local notif_sfx = NobleHUD.chat_notification_sounds[NobleHUD:GetChatNotificationSound()]
		 XAudio.Source:new(XAudio.Buffer:new(NobleHUD._mod_path .. "assets/snd/ui/" .. notif_sfx))
	end
	local hide_mode = NobleHUD:GetChatAutohideMode()
	local bg = self._panel:child("noblehud_chat_bg")
	if hide_mode == 1 then
		NobleHUD:AddDelayedCallback(function()
				NobleHUD:DoChatNotification(false)
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
	NobleHUD:animate(bg,"animate_fadein",nil,0.5,0.5)
end)


function HUDChat:_animate_fade_output()
	local wait_t = NobleHUD:GetChatAutohideTimer()
	local fade_t = 1
	local t = 0
	
	if NobleHUD:GetChatAutohideMode() == 1 then 
		while t < wait_t do
			local dt = coroutine.yield()
			t = t + dt
		end

		local t = 0

		while t < fade_t do
			local dt = coroutine.yield()
			t = t + dt

			self:set_output_alpha(1 - t / fade_t)
		end
		self:set_output_alpha(0)
	end
end


Hooks:PostHook(HUDChat,"receive_message","noblehud_on_receive_chat",function(self,name,message,color,icon)
	local notif_mode = NobleHUD:GetChatNotificationMode()
	if (notif_mode == 1) or (notif_mode == 3) then
		if not (self._panel:visible() and self._panel:alpha() >= 1)  then
			NobleHUD:DoChatNotification(true)
		end
	end
	if (notif_mode == 2) or (notif_mode == 3) then 
		local notif_sfx = NobleHUD.chat_notification_sounds[NobleHUD:GetChatNotificationSound()]
		 XAudio.Source:new(XAudio.Buffer:new(NobleHUD._mod_path .. "assets/snd/ui/" .. notif_sfx))
	end
	local hide_mode = NobleHUD:GetChatAutohideMode()
	if hide_mode == 1 then 			
		NobleHUD:AddDelayedCallback(function()
				NobleHUD:DoChatNotification(false)
			end,nil,NobleHUD:GetChatAutohideTimer(),"autohide_chat"
		)
	end
end)

Hooks:PostHook(HUDChat,"_on_focus","noblehud_on_chatfocus",function(self)
	NobleHUD:ClearChatNotification()
end)


