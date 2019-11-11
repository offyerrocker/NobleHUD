Hooks:PostHook(StatisticsManager,"killed","noblehud_statistics_killed",function(self,data)
	local stat, err = pcall(function ()
--		KineticHUD:OnEnemyKilled(data,self)
		NobleHUD:_on_enemy_killed(data)
	end)
	if err then 
		NobleHUD:log("Prevented StatisticsManager crash:" .. tostring(stat),{color = Color.red})
	end
end)