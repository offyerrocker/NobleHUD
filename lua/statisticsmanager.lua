Hooks:PostHook(StatisticsManager,"killed","noblehud_statistics_killed",function(self,data)
	NobleHUD:_on_enemy_killed(data)
end)