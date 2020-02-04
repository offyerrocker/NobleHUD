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


Hooks:PostHook(ECMJammerBase,"set_active","khud_activate_ecm",function(self,active)
--[[
	if false and self._owner_id == 1 then
		jam_cameras = managers.player:has_category_upgrade("ecm_jammer", "affects_cameras")
		jam_pagers = managers.player:has_category_upgrade("ecm_jammer", "affects_pagers")
	elseif Network:is_server() then
		
		local jam_cameras = false
		local jam_pagers = false
		if self._owner_id == managers.network:session():local_peer():id() then 
			jams_cameras = managers.player:upgrade_value("ecm_jammer", "affects_cameras")
			jams_pagers = managers.player:upgrade_value("ecm_jammer", "affects_pagers")
		end
		
		local battery_life = self._battery_life
		local expire_t = battery_life + Application:time()
		managers.player:add_tracked_ecm(self._unit:key(),{
			unit = self._unit,
			key = self._unit:key(),
			owner_id = self._owner_id,
			jam_people = self._feedback_active,
			jam_cameras = jam_cameras,
			jam_pagers = jam_pagers,
			battery_life = battery_life,
			expire_t = expire_t
		})
	end	
	--]]
end)

Hooks:PostHook(ECMJammerBase,"sync_net_event","khud_sync_net_event_ecm",function(self,event_id)
--[[
	local ecm_upgrade_lvl = tonumber(self._ecm_upgrade_lvl or 1)
	if not Network:is_server() then
		local jams_cameras = not not ecm_upgrade_lvl --true and not not not false or not not true
		local jams_pagers = ecm_upgrade_lvl >= 3
		local battery_life = self._battery_life
		local expire_t = Application:time() + battery_life
		if event_id == self._NET_EVENTS.jammer_active then 
			managers.player:add_tracked_ecm(self._unit:key(),{
				unit = self._unit,
				key = self._unit:key(),
				owner_id = self._owner_id,
				jam_people = self._feedback_active,
				jam_cameras = jam_cameras,
				jam_pagers = jam_pagers,
				battery_life = battery_life,
				expire_t = expire_t
			})		
--			AhriUI:c_log(self._unit:key(),"ECMJammerBase:2 unit key")
		elseif event_id == self._NET_EVENTS.battery_empty then 
			managers.player:add_tracked_ecm(self._unit:key(),{
				unit = self._unit,
				key = self._unit:key(),
				owner_id = self._owner_id,
				jam_people = self._feedback_active,
				jam_cameras = jam_cameras,
				jam_pagers = jam_pagers,
				battery_life = battery_life,
				expire_t = expire_t
			})
--			AhriUI:c_log(self._unit:key(),"ECMJammerBase:3 unit key")
		end
	end
	--]]
end)