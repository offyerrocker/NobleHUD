Hooks:PostHook(ECMJammerBase,"update","noblehud_ecm_update_decoys",function(self,unit,t,dt)
	if (self:battery_life() > 0) and (self:active() or self:feedback_active()) then 
		local interval_min = NobleHUD:GetRadarDecoyIntervalMin()
		local interval_max = NobleHUD:GetRadarDecoyIntervalMax()			
		if not self._next_decoy_t then
			self._next_decoy_t = (interval_min * math.random()) + t
		elseif self._next_decoy_t < t then 
			self._next_decoy_t = (math.random() * (interval_max - interval_min)) + interval_min + t

			NobleHUD:create_radar_blip(unit,"ecm_decoy")
		end
	end
end)