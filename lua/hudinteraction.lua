function HUDInteraction:show_interact(...)
	NobleHUD:ShowInteract(...)
end

function HUDInteraction:remove_interact(...)
	NobleHUD:HideInteract(...)
end

function HUDInteraction:show_interaction_bar(...)
	NobleHUD:ShowInteractBar(...)
end

function HUDInteraction:set_interaction_bar_width(...)
	NobleHUD:SetInteractProgress(...)
end

function HUDInteraction:hide_interaction_bar(...)
	NobleHUD:HideInteractBar(...)
end

function HUDInteraction:set_bar_valid(...)
	NobleHUD:SetInteractValid(...)
end


--[[

function HUDInteraction:show_interact(data)
	NobleHUD:ShowInteract(data)
end

function HUDInteraction:remove_interact()
	NobleHUD:HideInteract()
end

function HUDInteraction:show_interaction_bar(current, total)
	NobleHUD:SetInteractProgress(current,total)
	NobleHUD:ShowInteract()
end

function HUDInteraction:set_interaction_bar_width(current, total)
	NobleHUD:SetInteractProgress(current,total)
end

function HUDInteraction:hide_interaction_bar(complete)
	if complete then
		NobleHUD:AnimateInteractDone()
		--animate done
	else
		NobleHUD:HideInteract(true)
	end
end

function HUDInteraction:set_bar_valid(valid,id)
	NobleHUD:SetInteractValid(valid,id)
end

--]]