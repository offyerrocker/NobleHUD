Hooks:PreHook(UnitNetworkHandler, "sync_doctor_bag_taken", "noblehud_unitnetworkhandler_syncdoctorbagtaken", function(self, unit, amount, sender, ...)
	local peer = self._verify_sender(sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame) and peer) then
		return
	end
	NobleHUD:SetTeammateDowns(sender,0)
end)

Hooks:PreHook(UnitNetworkHandler, "sync_player_movement_state", "noblehud_unitnetworkhandler_syncplayermovementstate", function(self, unit, state, ...)
	if not unit then
		return
	end
	local peer_id = managers.criminals:character_peer_id_by_unit(unit)
--	NobleHUD:log("Teammate  " .. tostring(peer_id) .. " changed to state " .. tostring(state))
	if peer_id and state == "bleed_out" then 
		NobleHUD:SetTeammateDowns(peer_id,1,true,true)
	end
end)

Hooks:PostHook(UnitNetworkHandler,"on_sole_criminal_respawned","noblehud_unitnetworkhandler_onsolecriminalrespawned",function(self,peer_id, sender)
	NobleHUD:SetTeammateDowns(peer_id,0)
end)
