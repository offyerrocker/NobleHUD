Hooks:PostHook(HUDTemp,"init","noblehud_bagpanel_init",function(self,hud)
	self._hud_panel:child("temp_panel"):hide()
end)


function HUDTemp:show_carry_bag(carry_id, value)
	NobleHUD:ShowCarry(carry_id,value)
end

function HUDTemp:hide_carry_bag()
	NobleHUD:HideCarry()
end

function HUDTemp:set_stamina_value(value)
	NobleHUD:SetStamina(value)
end
