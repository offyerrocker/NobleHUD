Hooks:PostHook(StatisticsManager,"killed","noblehud_statistics_killed",function(self,data)
	local stat, err = pcall(function ()
		NobleHUD:OnEnemyKilled(data)
	end)
	if err then 
		NobleHUD:log("Prevented StatisticsManager crash:" .. tostring(stat),{color = Color.red})
	end
end)