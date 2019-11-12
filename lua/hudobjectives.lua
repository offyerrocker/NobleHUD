--[[
Hooks:PostHook(HUDObjectives,"remind_objective","noblehud_remindobjectives",function(self,id)
	if id == self._active_objective_id then
		local objective_panel = NobleHUD._objectives_panel:child("objectives_label")
		objective_panel:stop()
		objective_panel:animate(callback(NobleHUD,NobleHUD,"_animate_activate_objective"))
	end
end)
--]]