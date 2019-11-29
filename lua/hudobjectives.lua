
Hooks:PostHook(HUDObjectives,"init","noblehud_objectiveinit",function(self,hud)
	local objectives_panel = self._hud_panel:child("objectives_panel")
	objectives_panel:hide()
end)

--[[
function HUDObjectives:_animate_show_text(objective_text, amount_text)
end
function HUDObjectives:_animate_complete_objective(objectives_panel)
end
function HUDObjectives:_animate_activate_objective(objectives_panel)
end
function HUDObjectives:_animate_icon_objectivebox(icon_objectivebox)
end
function HUDObjectives:open_right_done(uses_amount)
end
--]]

--overridden
function HUDObjectives:activate_objective(data)
	self._active_objective_id = data.id
	if data.amount then
		self:update_amount_objective(data)
	end	
	
	NobleHUD._cache.current_objective = data.text
	NobleHUD:SetObjectiveTitle(utf8.to_upper("CURRENT OBJECTIVE:"))
	NobleHUD:SetObjectiveLabel(utf8.to_upper(data.text))
	NobleHUD:AnimateShowObjective()
end	

--overridden
function HUDObjectives:remind_objective(id)

	if id == self._active_objective_id then
		NobleHUD:SetObjectiveTitle(utf8.to_upper("OBJECTIVE REMINDER:"))
		NobleHUD:AnimateShowObjective()
	end
end

--overridden
function HUDObjectives:complete_objective(data)
	if data.id == self._active_objective_id then
		NobleHUD:SetObjectiveTitle(utf8.to_upper("OBJECTIVE COMPLETE:"))
		NobleHUD:AnimateShowObjective()
		NobleHUD._cache.current_objective = nil
		NobleHUD._cache.objective_progress = nil
		NobleHUD._cache.objective_total = nil
	end
end

function HUDObjectives:update_amount_objective(data)
	if data.id == self._active_objective_id then
		NobleHUD._cache.objective_progress = data.current_amount
		NobleHUD._cache.objective_total = data.current
		NobleHUD:SetObjectiveAmount(data)
	end
end
