
Hooks:PostHook(HUDObjectives,"init","noblehud_objectiveinit",function(self,hud)
	local objectives_panel = self._hud_panel:child("objectives_panel")
	objectives_panel:hide()
end)



--overridden
function HUDObjectives:activate_objective(data)
	self._active_objective_id = data.id
	
--	NobleHUD:log("Activate objective: " .. NobleHUD.table_concat(data," | ","=",true),{color = Color.yellow})
	data.mode = "activate"
	NobleHUD:AddQueuedObjective(data)
	
end	

--overridden
function HUDObjectives:remind_objective(id)
--	NobleHUD:log("Remind objective: " .. id,{color = Color.yellow})
	NobleHUD:AddQueuedObjective({id = id,mode = "remind"})
	
end

--overridden
function HUDObjectives:complete_objective(data)
--	NobleHUD:log("Complete objective: " .. NobleHUD.table_concat(data," | ","=",true),{color = Color.yellow})

	data.mode = "complete"
	NobleHUD:AddQueuedObjective(data)

end

function HUDObjectives:update_amount_objective(data)
--	NobleHUD:log("Update amount objective: " .. NobleHUD.table_concat(data," | ","=",true),{color = Color.yellow})
	data.mode = "update_amount"
	NobleHUD:AddQueuedObjective(data)
end

