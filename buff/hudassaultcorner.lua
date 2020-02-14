function HUDAssaultCorner:set_buff_enabled(buff_name, enabled) --winters dmg resist buff for cops; other captains in resmod
--	NobleHUD:log("ASSAULTCORNER: Buff enabled [" .. tostring(buff_name) .. "]: " .. tostring(enabled))
	if enabled then 
		self:AddBuff(buff_name)
	else
		self:RemoveBuff(buff_name)
	end
end