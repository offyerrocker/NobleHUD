Hooks:PostHook(BaseNetworkSession,"on_peer_sync_complete","noblehudon_peer_synced",function(self,peer,peer_id)
	if not self._local_peer then
		return
	end
	if not peer:ip_verified() then
		return
	end
	
	NobleHUD:log("[HOST] SYNCED WITH PEER: " .. peer_id)
	NobleHUD:OnPeerSynced(peer,peer_id)
end)
--[[
 set condition:mugshot_electrified,Electrified
02:30:04 AM Lua: CONSOLE: set condition:mugshot_normal,
nit units/payday2/characters/ene_spook_1/ene_spook_1
02:31:52 AM Lua: CONSOLE: Done
02:31:55 AM Lua: CONSOLE: set condition:mugshot_swansong,Downed
02:31:55 AM Lua: CONSOLE: set condition:mugshot_downed,Downed
on destroy, don't hide panel; hide individual elements
02:35:56 AM Lua: CONSOLE: set condition:mugshot_in_custody,In custody.
--]]