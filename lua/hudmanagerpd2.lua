local orig_show_hint = HUDManager.show_hint
function HUDManager:show_hint(data,...)
	if data.text then 
		NobleHUD:AddKillfeedMessage(data.text,NobleHUD._killfeed_presets.hint)
	else
		return orig_show_hint(self,data,...)
	end
end

if not NobleHUD:IsSafeMode() then 
	local orig_add_label = HUDManager._add_name_label
	function HUDManager:_add_name_label(data,...)
		
		local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
		local last_id = self._hud.name_labels[#self._hud.name_labels] and self._hud.name_labels[#self._hud.name_labels].id or 0
		local id = last_id + 1
		local character_name = data.name
	--	NobleHUD:log("Creating hud waypoint [" .. tostring(character_name) .. "] = " .. NobleHUD.table_concat(data," // "," : "))
		local rank = 0
		local peer_id = nil
		local is_husk_player = data.unit:base().is_husk_player

		
		if is_husk_player then
			peer_id = data.unit:network():peer():id()
			local level = data.unit:network():peer():level()
			rank = data.unit:network():peer():rank()

			if level then
				local experience = (rank > 0 and managers.experience:rank_string(rank) .. "-" or "") .. level
				data.name = data.name .. " (" .. experience .. ")"
			end
		end
	--	NobleHUD:log("Is husk player? " .. tostring(is_husk_player) .. " and peer_id is " .. tostring(peer_id) .. " and level is " .. tostring(level) .. " and rank is " .. tostring(rank))
		local panel = hud.panel:panel({name = "name_label" .. id})

	--
		local indicator_w = 16
		local indicator_h = 32
		local center_x = (panel:w() - indicator_w) / 2
		local debug_rect = panel:rect({
			name = "debug test",
			color = Color.red,
			visible = false,
			alpha = 0.1
		})
		local halo_waypoint = panel:panel({
			--get it? halo waypoint? cause it's above their head but it's also like, Halo, and like Halo Waypoint, the... the website... please clap
			--i guess i was over-REACHing
			--okay i'll stop now
			name = "halo_waypoint",
			w = indicator_w,
			h = indicator_h,
			x = panel:w() / 2,
			layer = 1	
		})
		local circle = halo_waypoint:bitmap({
			name = "circle",
			texture = "guis/textures/waypoint_circle",
			layer = 1,
			color = NobleHUD.color_data.hud_vitalsfill_blue,
			y = 0,
			w = indicator_w,
			h = indicator_w,
			alpha = 1,
			visible = not is_husk_player
		})
		
		local chevron = halo_waypoint:bitmap({
			name = "chevron",
			texture = "guis/textures/waypoint_chevron",
			layer = 1,
			color = NobleHUD.color_data.hud_vitalsfill_blue,
			y = indicator_w * 0.5,
			w = indicator_w,
			h = indicator_w,
			alpha = 1
		})
	--debug stuff pls ignore
	--	NobleHUD.derpaherp = NobleHUD.derpaherp or {}
	--	NobleHUD.derpaherp[id] = halo_waypoint 
	--

		local radius = 24
		local interact = CircleBitmapGuiObject:new(panel, {
			blend_mode = "add",
			use_bg = true,
			layer = 0,
			radius = radius,
			color = Color.white
		})

		interact:set_visible(false)

		local tabs_texture = "guis/textures/pd2/hud_tabs"
		local bag_rect = {
			2,
			34,
			20,
			17
		}
		local color_id = managers.criminals:character_color_id_by_unit(data.unit)
		local crim_color = tweak_data.chat_colors[color_id] or tweak_data.chat_colors[#tweak_data.chat_colors]
		local text = panel:text({
			name = "text",
			vertical = "top",
			h = 18,
			w = 256,
			align = "left", --is_husk_player and "left" or "center",
			layer = -1,
			text = NobleHUD:make_callsign_name(character_name,NobleHUD._MIN_CALLSIGN_LEN,NobleHUD._MAX_CALLSIGN_LEN,managers.criminals:character_name_by_unit(data.unit)) or data.name,
			font = tweak_data.hud.medium_font,
			font_size = 16, --tweak_data.hud.name_label_font_size,
			color = crim_color
		})
		local _,_,tw,_ = text:text_rect()
		text:set_x(halo_waypoint:x() - (tw / 2))
		local bag = panel:bitmap({
			name = "bag",
			layer = 0,
			visible = false,
			y = 1,
			x = 1,
			texture = tabs_texture,
			texture_rect = bag_rect,
			color = (crim_color * 1.1):with_alpha(1)
		})
		


		panel:text({
			w = 256,
			name = "cheater",
			h = 18,
			align = "center",
			visible = false,
			layer = -1,
			text = utf8.to_upper(managers.localization:text("menu_hud_cheater")),
			font = tweak_data.hud.medium_font,
			font_size = tweak_data.hud.name_label_font_size,
			color = tweak_data.screen_colors.pro_color
		})
		
		
		panel:text({
			vertical = "bottom",
			name = "action",
			h = 18,
			w = 256,
			align = "left",
			visible = false,
			rotation = 360,
			layer = -1,
			text = utf8.to_upper("Fixing"),
			font = tweak_data.hud.medium_font,
			font_size = tweak_data.hud.name_label_font_size,
			color = (crim_color * 1.1):with_alpha(1)
		})

		if rank > 0 then
			local infamy_icon = tweak_data.hud_icons:get_icon_data("infamy_icon")

			panel:bitmap({
				name = "infamy",
				h = 32,
				w = 16,
				layer = 0,
				texture = infamy_icon,
				color = crim_color,
				visible = false
			})
		end

		self:align_teammate_name_label(panel, interact)
		table.insert(self._hud.name_labels, {
			movement = data.unit:movement(),
			panel = panel,
			text = text,
			id = id,
			peer_id = peer_id,
			character_name = character_name,
			interact = interact,
			bag = bag
		})

		return id
	end

	local orig_align = HUDManager.align_teammate_name_label
	function HUDManager:align_teammate_name_label(panel, interact, ...)
		local halo = panel:child("halo_waypoint")
		if not alive(halo) then 
			return orig_align(self,panel,interact,...)
		end
		local double_radius = interact:radius() * 2
		local text = panel:child("text")
		local action = panel:child("action")
		local bag = panel:child("bag")
		local bag_number = panel:child("bag_number")
		local cheater = panel:child("cheater")
		local _, _, tw, th = text:text_rect()
		local _, _, aw, ah = action:text_rect()
		local _, _, cw, ch = cheater:text_rect()

	--
		halo:set_x(double_radius + 8) -- (halo:w() / 2) + 4)
	--	
		
		panel:set_size(math.max(tw, cw) + 4 + double_radius, math.max(th + ah + ch, double_radius))
		text:set_size(panel:w(), th)
		action:set_size(panel:w(), ah)
		cheater:set_size(tw, ch)
		if halo:child("circle"):visible() then 
			text:set_x(halo:right() + 4)
		else
			text:set_x(halo:x() + ((halo:w() - tw) / 2))
		end
		action:set_x(double_radius + 4)
		cheater:set_x(double_radius + 4)
		text:set_top(cheater:bottom())
		action:set_top(text:bottom())
		bag:set_top(text:top() + 4)
		interact:set_position(0, text:top())

	--[[
		local infamy = panel:child("infamy")
		if infamy then
			panel:set_w(panel:w() + infamy:w())
			text:set_size(panel:size())
			infamy:set_x(double_radius + 4)
			infamy:set_top(text:top())
			text:set_x(double_radius + 4 + infamy:w())
		end
		--]]
	--
		halo:set_y(text:y())
	--
		if bag_number then
			bag_number:set_bottom(text:bottom() - 1)
			panel:set_w(panel:w() + bag_number:w() + bag:w() + 8)
			bag:set_right(panel:w() - bag_number:w())
			bag_number:set_right(panel:w() + 2)
		else
			panel:set_w(panel:w() + bag:w() + 4)
			bag:set_right(panel:w())
		end
	end
end

Hooks:PostHook(HUDManager,"_setup_player_info_hud_pd2","noblehud_create_ws",function(self,hud)
	if _G.NobleHUD then 
		NobleHUD:CreateHUD(self)
	elseif Console then 
		Console:Log("HEY DIPSHIT YOU HAVE A SYNTAX ERROR IN menumanager.lua, GO FIX IT",{color = Color.red})
	else
		log("HEY DIPSHIT YOU HAVE A SYNTAX ERROR IN menumanager.lua AND YOU ALSO FORGOT TO SET UP YOUR DEBUG ENVIRONMENT",{color = Color.red})
	end
end)

function HUDManager:pd_start_progress(current, total, msg, icon_id,...)
--	NobleHUD:log("HUDManager:pd_start_progress(" .. NobleHUD.table_concat({current = current, total = total, msg = msg, icon_id = icon_id},",","=") .. ")")
	--do nothing
end

Hooks:PostHook(HUDManager,"set_disabled","noblehud_hidehud",function(self)
	NobleHUD._ws:panel():hide()
end)

Hooks:PostHook(HUDManager,"set_enabled","noblehud_showhud",function(self)
	NobleHUD._ws:panel():show()
end)

