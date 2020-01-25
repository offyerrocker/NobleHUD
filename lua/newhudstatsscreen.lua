Hooks:PostHook(HUDStatsScreen,"init","noblehud_hudstats_init",function(self)
	--todo Lobby Player Info support
end)

Hooks:PostHook(HUDStatsScreen,"recreate_left","noblehud_hudstats_recreateleft",function(self)
	local mission_box = NobleHUD._tabscreen:child("mission_box")
	
	local job_data = managers.job:current_job_data()
	local stage_data = managers.job:current_stage_data()
	
	if job_data and managers.job:current_job_id() == "safehouse" and Global.mission_manager.saved_job_values.playedSafeHouseBefore then
		mission_box:set_visible(false)
		
		return
	end
	
	
	
	if stage_data then 
		local level_data = managers.job:current_level_data()
		local mission_title_1 = NobleHUD._tabscreen:child("scoreboard"):child("title_box"):child("title_label")
		local mission_title_2 = NobleHUD._tabscreen:child("scoreboard"):child("title_box"):child("title_label_2")
		if managers.crime_spree:is_active() then 
			local mission = managers.crime_spree:get_mission(managers.crime_spree:current_played_mission())
			mission_title_1:set_text(managers.localization:to_upper_text(tweak_data.levels[mission.level.level_id].name_id) or "")
			mission_title_2:set_text(managers.localization:text("menu_cs_level", {level = managers.experience:cash_string(managers.crime_spree:server_spree_level(), "")}))
		else
			local job_chain = managers.job:current_job_chain_data()
			local day = managers.job:current_stage()
			local days = job_chain and #job_chain or 0
			local day_title =managers.localization:to_upper_text("hud_days_title", {
				DAY = day,
				DAYS = days
			})
			
			if managers.job:is_level_ghostable(managers.job:current_level_id()) then 
				mission_box:child("mission_ghostable_icon"):show()
				if managers.groupai and managers.groupai:state():whisper_mode() then 
					mission_box:child("mission_ghostable_icon"):set_color(NobleHUD.color_data.vintage)
				else
					mission_box:child("mission_ghostable_icon"):set_color(NobleHUD.color_data.collector)
				end
			end
			
			if level_data then 
				--objectives here
				
			end
			if job_data then
				local job_stars = managers.job:current_job_stars()
				local difficulty_stars = managers.job:current_difficulty_stars()
				local difficulty = tweak_data.difficulties[difficulty_stars + 2] or 1
				local difficulty_string = managers.localization:to_upper_text(tweak_data.difficulty_name_ids[difficulty])
				
				if Global.game_settings.one_down then
					
--					mission_title_2:set_text(managers.localization:to_upper_text("menu_one_down"))
					
--					mission_title_2:set_text(difficulty_string .. " " .. one_down_string)
--					mission_title_2:set_range_color(#difficulty_string + 1, math.huge, tweak_data.screen_colors.one_down)
				end
			end
			
			local payout = managers.localization:text("hud_day_payout", {
				MONEY = managers.experience:cash_string(managers.money:get_potential_payout_from_current_stage())
			})
			mission_box:child("mission_payout_total"):set_text(payout)

			local mandatory_bags_data = managers.loot:get_mandatory_bags_data()
			local mandatory_amount = mandatory_bags_data and mandatory_bags_data.amount
			local secured_amount = managers.loot:get_secured_mandatory_bags_amount()
			local bonus_amount = managers.loot:get_secured_bonus_bags_amount()
			
			if mandatory_amount and mandatory_amount > 0 then
				mission_box:child("mission_bags_label"):set_text("MISSION BAGS: " .. tostring(bonus_amount > 0 and string.format("%d/%d+%d", secured_amount, mandatory_amount, bonus_amount) or string.format("%d/%d", secured_amount, mandatory_amount)))	
			else
				mission_box:child("mission_bags_label"):set_text("BAGS: " .. bonus_amount)
			end
			local secured_bags_money = managers.experience:cash_string(managers.money:get_secured_mandatory_bags_money() + managers.money:get_secured_bonus_bags_money())
			mission_box:child("mission_bags_money_label"):set_text("LOOT PAYOUT: " .. tostring(secured_bags_money))
			mission_box:child("mission_instant_cash_label"):set_text("INSTANT CASH: " .. tostring(managers.experience:cash_string(managers.loot:get_real_total_small_loot_value())))
			
			local body_texture, body_rect = tweak_data.hud_icons:get_icon_data("equipment_body_bag")
			mission_box:child("bodybags_label"):set_text(tostring(managers.player:get_body_bags_amount()))
			mission_box:child("bodybags_icon"):set_image(body_texture,unpack(body_rect))
			
			
			
		end
	end
	--local active_objectives = managers.objectives:get_active_objectives() --data.text, data.description
	
	
	
	
	
	---right side
	local tracked_achievements = managers.achievment:get_tracked_fill()
	if #tracked > 0 then 
		
	end
	
	
	
	
	--buffs/debuffs?	
end)

Hooks:PostHook(HUDStatsScreen,"recreate_right","noblehud_hudstats_recreateright",function(self)
	
end)

function HUDStatsScreen:show()
	NobleHUD:AnimateShowTabscreen()
--	NobleHUD:ShowTabscreen()
--[[
	self:recreate_left()
	self:recreate_right()

	local safe = managers.hud.STATS_SCREEN_SAFERECT
	local full = managers.hud.STATS_SCREEN_FULLSCREEN

	managers.hud:show(full)

	local left_panel = self._left
	local right_panel = self._right
	local bottom_panel = self._bottom

	left_panel:stop()

	local teammates_panel = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2).panel:child("teammates_panel")
	local objectives_panel = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2).panel:child("objectives_panel")
	local chat_panel = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2).panel:child("chat_panel")

	left_panel:animate(callback(self, self, "_animate_show_stats_left_panel"), right_panel, bottom_panel, teammates_panel, objectives_panel, chat_panel)
	--]]
end

function HUDStatsScreen:hide()
	NobleHUD:AnimateHideTabscreen()
--	NobleHUD:HideTabscreen()
	--[[
	local left_panel = self._left
	local right_panel = self._right
	local bottom_panel = self._bottom

	left_panel:stop()

	local teammates_panel = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2).panel:child("teammates_panel")
	local objectives_panel = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2).panel:child("objectives_panel")
	local chat_panel = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2).panel:child("chat_panel")

	left_panel:animate(callback(self, self, "_animate_hide_stats_left_panel"), right_panel, bottom_panel, teammates_panel, objectives_panel, chat_panel)
--]]
end