Hooks:PostHook(ClientNetworkSession,"on_peer_sync_complete","noblehudon_peer_synced_client",function(self,peer,peer_id)
	if not self._local_peer then
		return
	end
	if not peer:ip_verified() then
		return
	end
	
	NobleHUD:log("[CLIENT] SYNCED WITH PEER: " .. peer_id)
	NobleHUD:OnPeerSynced(peer,peer_id)
end)