--NobleHUD = NobleHUD or {}

NobleHUD._mod_path = ModPath
NobleHUD._options_path = ModPath .. "menu/"
NobleHUD._buff_settings_path = SavePath .. "noblehud_buff_settings.txt"
NobleHUD._settings_path = SavePath .. "noblehud_settings.txt"
NobleHUD._localization_path = ModPath .. "localization/"
NobleHUD._cartographer_path = ModPath .. "cartographer/"
NobleHUD._announcer_path = ModPath .. "assets/snd/announcer/"

NobleHUD.settings = {
	debug = false,
	safe_mode = false,
	crosshair_enabled = true,
	crosshair_bloom = true,
	crosshair_shake = true,
	crosshair_alpha = 0.5,
	crosshair_dynamic_color = true,
	crosshair_stability = 100,
	crosshair_static_color = {1,0,0},
	radar_enabled = true,
	score_display_mode = 1,
	medals_enabled = true,
	vitals_scale = 1,
	popup_style = 1,
	popups_enabled = true,
	popup_font_size = 16,
	radar_distance = 25,
	radar_x = 32,
	radar_y = 32,
	radar_align_horizontal = 1,
	radar_align_vertical = 3,
	radar_style = 2,
	radar_scale = 0.8,
	popup_duration = 3,
	show_all_medals = false,
	announcer_enabled = true,
	announcer_frantic_enabled = false,
	stamina_enabled = true,
	stamina_x = 250,
	stamina_y = 630,
	ability_x = 0,
	ability_y = 0,
	ability_align_to_radar = true,
	interact_style = 1,
	weapon_ammo_tick_full_alpha = 0.8,
	weapon_ammo_tick_empty_alpha = 0.15,
	weapon_ammo_real_counter = false,
	steelsight_hides_reticle_enabled = true,
	master_hud_alpha = 0.9,
	chat_autohide_timer = 3,
	chat_autohide_mode = 1,
	chat_autoshow_enabled = true,
	chat_notification_icon_enabled = true,
	chat_notification_sound_enabled = true,
	chat_notification_sfx = 1,
	chat_timestamp_mode = 3,
	chat_panel_x = 0,
	chat_panel_y = 0,
	shield_low_threshold = 0.3,
	shield_charge_sound_enabled = true,
	shield_charge_sound_volume = 1,
	shield_low_sound_enabled = true,
	shield_low_sound_volume = 1,
	shield_empty_sound_enabled = true,
	shield_empty_sound_volume = 1,
	--callsign_string = "S117", --automatically randomly generated
	team_name = "Red Team",
--	team_color = Color(0.5,0.2,0.2),
	unusual = 1, --more like unused-ual
	crosshair_type_assaultrifle_single = 1,
	crosshair_type_assaultrifle_auto = 1,
	crosshair_type_pistol_single = 1,
	crosshair_type_pistol_auto = 1,
	crosshair_type_revolver = 1,
	crosshair_type_smg_single = 1,
	crosshair_type_smg_auto = 1,
	crosshair_type_shotgun_single = 1,
	crosshair_type_shotgun_auto = 1,
	crosshair_type_lmg_single = 1,
	crosshair_type_lmg_auto = 1,
	crosshair_type_snp = 1,
	crosshair_type_rocket = 1,
	crosshair_type_minigun = 1,
	crosshair_type_flamethrower = 1,
	crosshair_type_saw = 1,
	crosshair_type_grenade_launcher = 1,
	crosshair_type_bow = 1,
	crosshair_type_crossbow = 1,
	buffs_master_enabled = true,
	buffs_panel_x = 440,
	buffs_panel_y = 22,
	buffs_panel_w = 1280,
	buffs_panel_h = 720,
	buffs_panel_align = 1,
	buffs_panel_vertical = 2,
	buff_align_center = true, --not used
	buff_align_vertical = false, --not used
	teammate_align_to_radar = true,
	teammate_x = 16,
	teammate_y = 392,
	buffs_compact_mode_enabled = false,
	damage_popups_enabled = true,
	damage_popups_style = 1,
	damage_popups_cumulative_enabled = true,
	damage_popups_cumulative_refresh = 2,
	damage_popups_redundant = true,
	damage_popups_lifetime = 0.66,
	damage_popups_fadeout = 0.5
}

--    UTILS
local also_blt_log = false
function NobleHUD:log(...)
	if not self.settings.debug then 
		return
	end
	if Console then 
		Console:Log(...)
	elseif also_blt_log then 
		log(...)
	end
end

function NobleHUD.table_concat(tbl,div,key_div,include_subtables,current_level)
	if type(include_subtables) ~= "number" then 
		include_subtables = 1 --default
	end
	current_level = (type(current_level) == "number") and current_level or 1
	local function a(b)
		if include_subtables and (type(b) == "table") and current_level <= include_subtables then 
			return ("{" .. NobleHUD.table_concat(v,div,key_div,include_subtables) .. "}")
		else
			return tostring(b)
		end
	end	
	div = (div and tostring(div)) or " "
	if type(tbl) == "table" then 
		local str 
		if key_div then
			if key_div == true then 
				key_div = " : "
			else
				key_div = tostring(key_div)
			end
			for k,v in pairs(tbl) do 
				if str then
					str = str .. div .. tostring(k) .. key_div.. a(v)
				else
					str = tostring(k) .. key_div .. a(v)
				end
			end
		else
			for k,v in pairs(tbl) do 
				if str then 
					str = str .. div .. a(v) 
				else 
					str = a(v)
				end
			end
		end
		return str or "ERROR2"
	end
	return "ERROR"
end

function NobleHUD.angle_from(a,b,c,d) -- converts to angle with ranges (-180 , 180); for result range 0-360, do +180 to result
--mvector3.angle() is a big fat meanie zucchini;
	a = a or "nil"
	b = b or "nil"
	c = c or "nil"
	d = d or "nil"
	local function do_angle(x1,y1,x2,y2)
		local angle = 0
		local x = x2 - x1 --x diff
		local y = y2 - y1 --y diff
		if x ~= 0 then 
			angle = math.atan(y / x) % 180
			if y == 0 then 
				if x > 0 then 
					angle = 180 --right
				else
					angle = 0 --left 
				end
			elseif y > 0 then 
				angle = angle - 180
			end
		else
			if y > 0 then
				angle = 270 --up
			else
				angle = 90 --down
			end
		end
		
		return angle
	end
	local vectype = type(Vector3())
	if (type(a) == vectype) and (type(b) == vectype) then  --vector pos diff
		return do_angle(a.x,a.y,b.x,b.y)
	elseif (type(a) == "number") and (type(b) == "number") and (type(c) == "number") and (type(d) == "number") then --manual x/y pos diff
		return do_angle(a,b,c,d)
	else
		NobleHUD:log("ERROR: angle_from(" .. NobleHUD.table_concat({a,b,c,d},",") .. ") failed - bad/mismatched arg types")
		return
	end
end

function NobleHUD.vec2_distance(a,b,c,d)
	local function do_dis(x1,y1,x2,y2)
		return math.sqrt(math.pow(x2 - x1,2) + math.pow(y2 - y1,2))
	end
	
	local vectype = type(Vector3())
	if (type(a) == vectype) and (type(b) == vectype) then  --vector pos diff
		return do_dis(a.x,a.y,b.x,b.y)
	elseif (type(a) == "number") and (type(b) == "number") and (type(c) == "number") and (type(d) == "number") then --manual x/y pos diff
		return do_dis(a,b,c,d)
	else
		NobleHUD:log("ERROR: vec2_distance(" .. NobleHUD.table_concat({a,b,c,d},",") .. ") failed - bad/mismatched arg types")
		return 0
	end
end

function NobleHUD.format_seconds(raw)
--[[
	local e = os.time()
	local seconds = os.date("%S")
	local minutes = os.date("%M")
	local hours = os.date("%H")
	local days = os.date("%d")
	local fulltime = os.date("%X")
	return os.date(e)
	os.clock()
--]]
	return string.format("%02i:%02i",math.floor(raw / 60),math.floor(raw % 60))
end

function NobleHUD.even(n)
	return (n % 2) == 0
end

function NobleHUD.make_nice_number(num,include_decimal)
	local is_negative
	if num < 0 then 
		is_negative = true
		num = math.abs(num)
	end
	local raw = tostring(num)
	local int = string.format("%i",num)
	local length = string.len(int)
	local str = ""
	local i = 1
	for j = length,1,-1 do 
		str = string.sub(int,j,j) .. str
		if ((i % 3) == 0) and (j > 1) then
			str = "," .. str
		end
		i = i + 1
	end
	if include_decimal then 
		local decimal_pos = string.find(raw,"%.")
		if decimal_pos then 
			str = str .. string.sub(raw,(decimal_pos))
		end
	end
	if is_negative then 
		str = "-" .. str
	end
	return str
end

function NobleHUD.make_compact_number(num,scale,places)
	local str
	if (not scale) or type(scale) ~= "number" then 
		scale = 1
	end
	places = places or 1
	
	local function e(power) --yeah i'm that lazy
		return math.pow(10,power)
	end
	
	local powers = {
		k = 3,
		m = 6,
		b = 9,
		t = 12,
		q = 15,
		p = 18
	}
	
	local function formatter(p)
		if places == 0 then 
			return "%i"
		else
			return "%0." .. (p) .. "f"
		end
	end
	
	local suffix = "k"
	if scale == -1 then 
		for abbr,v in pairs(powers) do 
			if num/e(v) > 1 then 
				suffix = abbr
			end
		end
	else
		for abbr,v in pairs(powers) do 
			if (scale >= v) and (powers[suffix] <= v) then 
				suffix = abbr
			end
		end
	end
	local power = powers[suffix]
	
	local rem =(num % e(power))
	str = string.format(formatter(places) .. suffix,num / e(powers[suffix]))
	
	return str or string.format("%." .. scale .. "f",num)
end

function NobleHUD:make_callsign_name(raw_name,min_len,max_len,fallback_character_name)
	fallback_character_name = fallback_character_name and tostring(fallback_character_name) or ""
	local blacklisted_prefixes = {
		["the"] = true,
		["a"] = true,
		["an"] = true --sorry if "an" is just your first name
	}
	local function validity_check(s,skip_length_check) 
		return s and ((string.len(tostring(s)) >= min_len) or skip_length_check)
	end
	local function without_vowels(s)
		return string.gsub(s,"[AEIOUaeiou]","")
	end


	local best_word = ""
	local condensed = ""
	local result = ""
	local anid = "" --alphanumeric id
	local word_number = 1
	local first_word
	local prev_word_number = 1
	local prev_word
	local missing_characters = 0
	for raw_word in string.gmatch(raw_name,"%w+") do 
		local word = string.gsub(raw_word,"%W","")
		local word_len = string.len(word) 
		if word_len <= 0 then 
			--YOU GET NOTHING
		else
			if not best_word then 
				best_word = word
			else
				local best_len = string.len(best_word)
				
				if string.find(string.sub(word,1,1),"%a") then 
					if best_len >= max_len then 
					else
					end
					best_word = best_word or word
				elseif (string.match(word,"%a+") == word) then
					
				end
			end
			if missing_characters > 0 then 
				local ramen_len = math.min(math.max(1,missing_characters),word_len)
				missing_characters = missing_characters - ramen_len
				anid = anid .. string.sub(word,1,ramen_len)
			end
			if word_number == 1 then 
				first_word = word
			end
			if word_number == 1 and blacklisted_prefixes[string.lower(word)] then

			else
				condensed = condensed .. word
				if string.match(word,"%d+") then --found digit to use as callsign
					local anid_s,anid_e = string.find(word,"%d+")
					local anid_word = string.sub(word,anid_s,anid_e)
					local anid_len = string.len(anid_word)
					if anid_len and anid_len > 0 then --should be a given
						if anid_len >= max_len then
							anid = string.sub(anid_word,1,max_len)
						elseif anid_len <= min_len then --too short; add to anid if possible
							local max_missing = max_len - anid_len
							local min_missing = max_len - anid_len
							
							if anid_s == 1 then 
								local donor
								local wn
								if first_word and string.len(first_word) >= 1 then --pull from first word
									wn = 1
									donor = first_word
								elseif prev_word and string.len(prev_word) >= 1 then --pull from previous word
									donor = prev_word
									wn = prev_word_number
								end
								if donor then
									local s_offset = 0
									if wn == word_number then 
										s_offset = anid_e
										anid = anid_word .. string.sub(donor,1 + s_offset,max_missing + s_offset)
									else
										anid = string.sub(donor,1,max_missing) .. anid_word
									end
								else
									--guess i'll die
								end
							else
								--if anid_e == word_len 
								anid = string.sub(word,1,math.min(max_missing,anid_s - 1)) .. anid_word
							
							end
						end
					end
				end
			end
		end
		prev_word = word
		prev_word_number = word_number
		word_number = word_number + 1
	end
	if string.len(condensed) < min_len then 
		result = string.gsub(raw_name,"%W","")
	else
		result = condensed
	end
		
	if validity_check(anid) and string.len(anid) <= max_len then 
		result = anid
		--anid always takes priority
	else
		--if no anid, then check current result
		local result_len = string.len(result)
		if result_len <= max_len and result_len > min_len then 
			--current result is usable
		else
			--result isn't currently usable, see if it can be modified to usability
			--check vowel-less first
			local result_vowelless = without_vowels(result)
			local result_vowelless_len = string.len(result_vowelless)
			if result_vowelless_len <= max_len and result_vowelless_len > min_len then
				result = result_vowelless --use vowel-less as callsign
			else --vowel-less does not work, so take first four letters
				
				result = string.sub(result,1,max_len)
				result_len = string.len(result)
				if result_len <= max_len and result_len > min_len then 
					--use this result
				else --result is unsuitable, try fallback
					local fallback_len = string.len(fallback_character_name)
					if fallback_len <= max_len and fallback_len > min_len then 
						--fallback_character_name is the right size
						result = fallback_character_name
					else--fallback_character_name is not the right size
						--attempt removing vowels
						result_vowelless = without_vowels(fallback_character_name)
						result_vowelless_len = string.len(result_vowelless)
						if result_vowelless_len <= max_len and result_vowelless_len > min_len then 
							--without vowels, fallback_character_name is usable
							result = result_vowelless
						else
							--last resort is simply cropping the raw name to max_len
							result = string.sub(raw_name,1,max_len)
						end
					end
				end
			end
		end
	end
	
	result = string.upper(result)
	self:log("Made nickname: [" .. tostring(raw_name) .. "] --> [" .. tostring(result) .. "]") --!
	return result
end

function NobleHUD.to_camelcase(s)
	if s == nil then 
		return s
	end
	if string.len(s) <= 1 then 
		return s
	else
		s = tostring(s)
		return utf8.to_upper(string.sub(s,1,1)) .. string.sub(s,2)
	end
end

function NobleHUD:GetToxicMessage()
	return self._toxic_messages[math.random(#self._toxic_messages)] or ""
end

function NobleHUD.choose(tbl)
	if type(tbl) == "table" and #tbl > 0 then 
		return tbl[math.random(#tbl)]
	else
		local a = {}
		for i,v in pairs(tbl) do 
			table.insert(a,i)
		end
		return tbl[a[math.random(#a)]]
	end
end

function NobleHUD.random_character(l,n,c)
--
	if not (l or n or c) then 
		l = 1
		n = 1
		c = 1
--		local tbl = NobleHUD.choose(NobleHUD._random_chars)
--		return tbl[math.random(#tbl)]
	else
		local function b(a)
			return a and 1 or 0
		end
		
		l = b(l)
		n = b(n)
		c = b(c)
	end
	
	local t = l + n + c
	
--		l = 0 + l
	n = l + n
	c = n + c
	
	local r = math.random()
	if r < (l/t) then 
		local i = math.random(1,string.len(NobleHUD._random_chars.letters))
		return string.sub(NobleHUD._random_chars.letters,i,i)
		--NobleHUD._random_chars.letters[math.random(#NobleHUD._random_chars.letters)]
	elseif r < (n/t) then 
		local i = math.random(1,string.len(NobleHUD._random_chars.numbers))
		return string.sub(NobleHUD._random_chars.numbers,i,i)
		--NobleHUD._random_chars.numbers[math.random(#NobleHUD._random_chars.numbers)]
	elseif r < (c/t) then
		local i = math.random(1,string.len(NobleHUD._random_chars.characters))
		return string.sub(NobleHUD._random_chars.characters,i,i)
		--NobleHUD._random_chars.characters[math.random(#NobleHUD._random_chars.characters)]
	end

end

function NobleHUD.interp_colors(one,two,percent) --interpolates colors based on a percentage
--percent is [0,1]
	percent = math.clamp(percent,0,1)
	
--color 1
	local r1 = one.red
	local g1 = one.green
	local b1 = one.blue
	
--color 2
	local r2 = two.red
	local g2 = two.green
	local b2 = two.blue

--delta
	local r3 = r2 - r1
	local g3 = g2 - g1
	local b3 = b2 - b1
	
	return Color(r1 + (r3 * percent),g1 + (g3 * percent), b1 + (b3 * percent))	
end

function NobleHUD:GetMedalIcon(x,y)
	return self._medal_atlas,{
		x * 90,y * 90,90,90 --sure hope i got this right
	}
end

function NobleHUD:AddDelayedCallback(func,args,timer,id)
	if timer then 
		timer = timer + Application:time()
	end
	id = id or (#NobleHUD._delayed_callbacks + 1)
	NobleHUD._delayed_callbacks[id] = {func = func,args = args or {},timer = timer}
end

function NobleHUD:RemoveDelayedCallback(id)
	NobleHUD._delayed_callbacks[tostring(id)] = nil
end

function NobleHUD:animate(object,func,done_cb,...) --i'll make my own animate function, with blackjack, and hookers
	NobleHUD._animate_targets[tostring(object)] = {
		object = object,
		start_t = Application:time(),
		func = func,
		done_cb = done_cb,
		args = {...}
	}
end
--format: result = data.func(data.object,t,dt,data.start_t,unpack(data.args))
--done callback: done_cb(data.object,result,unpack(data.args))

--overkill made "PRIMARY" weapons in slot [2] and "SECONDARY" weapons in slot [1],
--probably recycled/holdover/legacy code from PD:TH
--no longer used
function NobleHUD.correct_weapon_selection(num,default)
	return ((num == 1) and 2 or 1) or (default or 1)
end

function NobleHUD.get_specialization_icon_data_with_fallback(spec, no_fallback, tier, tier_floors)
--i had to write this because get_specialization_icon_data() always picks the top tier. booooo
	spec = spec or managers.skilltree:get_specialization_value("current_specialization")

	local data = tweak_data.skilltree.specializations[spec]
	local max_tier = managers.skilltree:get_specialization_value(spec, "tiers", "max_tier")
	
	if tier_floors and type(tier_floors) == "table" then
	--this code-nugget takes optional input "tier_floors" (table) which is a whitelist for icon tiers to use.
	--it takes the highest possible unlocked tier from this whitelist, and uses that. 
	--this is helpful for if you want to get the highest tier icon but do not want to use the "generic" perks (eg 2,4,6,8), for instance. 
		tier = max_tier
		local result
		for _,max_eligible in pairs(tier_floors) do 
			if max_eligible <= tier then 
				result = max_eligible
			end
		end
		tier = result
	end
	
	local tier_data = data and data[tier or max_tier] --this, the arg tier, and the tier_floors option are the only things i changed. :|

	if not tier_data then
		if no_fallback then
			return
		else
			return tweak_data.hud_icons:get_icon_data("fallback")
		end
	end

	local guis_catalog = "guis/" .. (tier_data.texture_bundle_folder and "dlcs/" .. tostring(tier_data.texture_bundle_folder) .. "/" or "")
	local x = tier_data.icon_xy and tier_data.icon_xy[1] or 0
	local y = tier_data.icon_xy and tier_data.icon_xy[2] or 0

	return guis_catalog .. "textures/pd2/specialization/icons_atlas", {
		x * 64,
		y * 64,
		64,
		64
	}
end


function NobleHUD:LoadSettings()
	local file = io.open(self._settings_path, "r")
	if (file) then
		for k, v in pairs(json.decode(file:read("*all"))) do
			self.settings[k] = v
		end
	else
		self:SaveSettings()
	end

	if not self.settings.callsign_string then 
		self.settings.callsign_string = string.upper(self.random_character(true,false,false)) .. string.format("%03d",math.random(1000) - 1)
		self:SaveSettings()
	end
end

function NobleHUD:SaveSettings()
	local file = io.open(self._settings_path,"w+")
	if file then
		file:write(json.encode(self.settings))
		file:close()
	end
end


function NobleHUD:SaveBuffSettings()
	local file = io.open(self._buff_settings_path,"w+")
	if file then
		file:write(json.encode(self.buff_settings))
		file:close()
	end
end

function NobleHUD:LoadBuffSettings()
	local file = io.open(self._buff_settings_path, "r")
	if (file) then
		for k, v in pairs(json.decode(file:read("*all"))) do
			self.buff_settings[k] = v
		end
	else
		self:SaveBuffSettings()
	end
end


NobleHUD.network_messages = {
	down_counter = "DownCounterStandalone",
	sync_assault = "SyncAssaultPhase",
	sync_teamname = "SyncNobleHUDTeamName",
	sync_callsign = "SyncNobleHUDCallsign",
	sync_teamcolor = "SyncNobleHUDTeamColor"
}

NobleHUD.color_data = {
	hud_vitalsoutline_blue = Color(121/255,197/255,255/255), --vitals outline color
	hud_vitalsoutline_yellow = Color(255/255,211/255,129/255),
	hud_vitalsoutline_red = Color(135/255,0/255,0/255),
	hud_vitalsfill_blue = Color(58/255,138/255,199/255), --vitals fill color
	hud_vitalsfill_yellow = Color(255/255,195/255,74/255),
	hud_vitalsfill_red = Color(212/255,0/255,0/255),
	hud_vitalsglow_red = Color(255/255,115/255,115/255), --empty pink flash
	hud_hit_health = Color("ff3d10"), --orange
	hud_hit_armor = Color("32a0ff"), --blue
	hud_hit_vehicle = Color("2141ff"), --blue-purple
	hud_weapon_color = Color(113/255,202/255,239/255), --"official" blue hud color
	hud_text_blue = Color(100/255,178/255,255/255),
	hud_text_flash = Color(254/255,239/255,239/255),
	hud_killfeed_lightyellow = Color(253/255,255/255,217/255),
	hud_killfeed_yellow = Color(255/255,231/255,0),
	hud_helper_bluefill = Color(218/255,238/255,255/255),
	hud_helper_blueglow = Color(0,0.3,0.9),
	hud_overshield_fill = Color("00ffd3"), --teal; for maniac
	hud_storedhealth_fill = Color("ff00c7"), --magenta-red; for ex-presidents
	hud_delayeddamage_fill = Color("ff9e00"), --orange; for stoic 
	hud_lightblue = Color("a1f0ff"), --powder blue; unused
	hud_bluefill = Color("66cfff"), --sky blue; unused
	hud_blueoutline = Color("3173bb"),
	hud_hint_orange = Color("FFB432"),
	hud_hint_lightorange = Color("FFE5B8"),
--	hud_blueoutline = Color(168/255,203/255,255/255), --shield/hp outline color; unused
	hud_text = Color.white,
	hud_radar_cop = Color(212/255,0/255,0/255), --red
	hud_radar_criminal = Color("F1E667"), --yellow
	hud_radar_civilian = Color("18D400"), --green
	hud_radar_gangster = Color("D46800"), --orange
	hud_radar_convert = Color("67EFF1"), --cyan
	hud_radar_turret = Color("B600D4"), --purple
	hud_radar_empty_vehicle = Color(0.7,0.7,0.7),
	hud_radar_friendly_vehicle = Color("F1E667"),
	hud_radar_hostile_vehicle = Color(212/255,0/255,0/255),
	hud_compass = Color("2EA1FF"),
	hud_objective_title_text = Color(0.66,0.66,0.66),
	hud_objective_label_text = Color.white,
	hud_objective_shadow_text = Color(0,0,0),
	hud_wave_start = Color("FFD700"), -- yellow
	hud_wave_end = Color("29da23"), -- green
	hud_buff_status = Color("FFD700"), -- yellow
	hud_buff_negative = Color("FF2E2E"),
	hud_buff_neutral = Color.white,
	hud_buff_positive = Color("2B8EFF"), --blue, i hope
	hud_latency_low = Color(0,1,0),
	hud_latency_medium = Color(1,1,0),
	hud_latency_high = Color(1,0,0),
	hud_latency_unbearable = Color(1,0.5,0.5),
	normal = Color("B2B2B2"), --grey
	unique = Color("FFD700"), --yellow 
	vintage = Color("476291"), --desat navy ish
	genuine = Color("4D6455"), --desat forest green ish
	strange = Color("CF6A32"), --desat orangey
	unusual = Color("8650AC"), --purple
	haunted = Color("38F3AB"), --turquoise
	collector = Color("AA0000"), --collector's, but i hate dealing with escape + quotes in strings. dark red
	decorated = Color("FAFAFA"), --lighter grey?
	community = Color("70B04A"), --also self-made; magenta
	valve = Color("A50F79"), --burgundy?
	void = Color("544071"), --purple; more sat than unusual
	solar = Color("E1834F"), --orange
	arc = Color("6F8EA2"), --powder blue
	common = Color("43734B"), --moderately green
	rare = Color("5076a3"), --blue; lighter than vintage
	legendary = Color("522F65"), --purple; lighter than unusual
	exotic = Color("CEAE33"), --(bright lemony yellow)
	seraph = Color("FF7EE9") --not actually the exact bl2 hex color so i'll replace it if i ever find it
}
