--this hook is temporarily disabled
Hooks:PostHook(HUDHitDirection,"_add_hit_indicator","noblehud_add_hit_indicator",function(self,...)
	NobleHUD:AddHitIndicator(...)
end)