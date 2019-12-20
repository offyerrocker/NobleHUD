if NobleHUD then 
	local t = Application:time()
	local dt = t - NobleHUD._cache.t
	NobleHUD._cache.t = t
	local t_real = os.time()
	local dt_real = t_real - NobleHUD._cache.t_real
	--os.time() is an int value, unfortunately, so not that useful. todo look into C dll to extend lua time?
	--persist scripts don't run when paused, apparently. so realtime was actually useless to implement.
	NobleHUD._cache.t_real = t_real
	if NobleHUD.UpdateHUD then
		NobleHUD:UpdateHUD(t,dt,t_real,dt_real)
	end
end