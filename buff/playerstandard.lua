Hooks:PostHook(PlayerStandard,"_start_action_reload_enter","noblehud_buff_lock_n_load_remove",function(self,t)
	NobleHUD:RemoveBuff("lock_n_load")
end)