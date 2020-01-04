
Hooks:PostHook(GroupAIStateBase,"convert_hostage_to_criminal","noblehud_groupaibase_convert_joker",function(self,unit,peer_unit)
	NobleHUD:check_radar_blip_color(unit)
--[[
	local peer_id = managers.criminals:character_peer_id_by_unit(peer_unit)
	local local_id = managers.network:session():local_peer():id()
	if (unit and alive(unit)) and (not peer_unit or (local_id == peer_id)) then 
--		local char_tweak = unit:base()._char_tweak
--		local access = char_tweak and char_tweak.access or "nil access"
		local category_name = unit:base()._tweak_table
	end
	--]]
end)