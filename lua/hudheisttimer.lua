Hooks:PostHook(HUDHeistTimer,"init","noblehud_heisttimer_init",function(self,hud, tweak_hud)
	self._timer_text:hide()
end)

local orig_set_time = HUDHeistTimer.set_time
function HUDHeistTimer:set_time(time,...)
	if NobleHUD:IsSaveMode() then 
		return orig_set_time(self,time,...)
	end
	local inverted = false

	if time < 0 then
		inverted = true
		time = math.abs(time)
	end

	if not self._enabled or not inverted and math.floor(time) < self._last_time then
		return
	end

	self._last_time = time
	time = math.floor(time)
	local hours = math.floor(time / 3600)
	time = time - hours * 3600
	local minutes = math.floor(time / 60)
	time = time - minutes * 60
	local seconds = math.round(time)
	local text = hours > 0 and (hours < 10 and "0" .. hours or hours) .. ":" or ""
	local text = text .. (minutes < 10 and "0" .. minutes or minutes) .. ":" .. (seconds < 10 and "0" .. seconds or seconds)

	NobleHUD:_set_mission_timer(text)
end
