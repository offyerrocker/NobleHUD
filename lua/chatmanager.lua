
local orig_send = ChatManager.send_message
function ChatManager:send_message(channel_id, sender, message,...)
	local msg = message and utf8.to_lower(message)
	local check_secret = string.gsub(msg,"%W","")
	if msg and (channel_id == ChatManager.GAME) then 
		if msg == "ggez" then 
			message = NobleHUD:GetToxicMessage()
		elseif msg == "hoxtalicious!!!" then
			local cool_dev_who_makes_good_mods = Steam:user("76561198025511599"):name()
			self:_receive_message(channel_id,cool_dev_who_makes_good_mods,"We don't do that here.",NobleHUD.color_data.unique) --don't localize it. translating memes? we don't do that here.
			return
		elseif string.find(check_secret,"birthday") or string.find(check_secret,"bday") then 
			if string.find(check_secret,"stop") or string.find(check_secret,"off") then 
				NobleHUD._cache.birthday = false
			else
				NobleHUD._cache.birthday = true
			end
		end
	end
	return orig_send(self,channel_id,sender,message,...)
end

Hooks:PostHook(ChatManager,"receive_message_by_peer","noblehud_easteregg_birthday",function(self,channel_id,peer,message)
	if self:is_peer_muted(peer) then
		return
	end
	
	local is_self = peer:id() == managers.network:session():local_peer():id()
	local check_secret = utf8.to_lower(string.gsub(message,"%W",""))
	if (NobleHUD._cache.birthday == nil) or (is_self) then 
		if string.find(check_secret,"birthday") or string.find(check_secret,"bday") then 		
			if is_self and (string.find(check_secret,"off") or string.find(check_secret,"stop")) then 
				NobleHUD._cache.birthday = false
			else
				NobleHUD._cache.birthday = true
			end
		end
	end	
end)