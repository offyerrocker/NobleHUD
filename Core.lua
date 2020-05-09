--[[

fire doesn't count as a kill. so every kill is "first strike."

Test grenade medal proc
Test first strike medal proc from teammates




***** TODO: *****
	* Damage popups do not currently trigger on enemy SWAT turrets
	
	* Reorganize popup animate code to allow damage popups to reuse damage animations
	* Add damage popups via other hooks? From CopDamage?
	* Cumulative damage 
		* For athena, use existing popup but reset text, and position/animation progress
	* Test new macro-ized code
	
	- Send medal data to other noblehud users? might be exploitable though, probably just check that player's kills locally 

	* medal collection
	* First strike killed by any

	Notes:
		
		* "Speaking" icon for teammates and self
		* Sync data:
			send assault phase
		
		* Teammate Vitals
			* Teammate divider for vitals;
			* change vitals text color
			* Teammate vitals icon fill/blink effect (for non-conditional) - use vitals_icon_bg?
			
		* Test sync data success
			* assault
			* team_name
			
		* Users cannot select an alternative crosshair for rocket launchers since they are technically grenade launchers
		
	%%% Buffs:
			
		* Track buffs even if disabled (by user pref), but do not show panel if not extant?
		
		* Background for buffs so that they're visible against a white background
		
		* Reorganize buffs tweak table
		* Add default setting for each buff
		* Add threshold procs for Resist/crit/dodge, and option to always show
		
			Singleplayer
			
		* Armor/Health tracker
		* Partners In Crime
		* Partners In Crime Aced
		* Stockholm Syndrome Aced Charge
		* Fully Loaded
		
		Captain Winters buff should flash red white and blue cause MURICA
		
			Perk Decks
			
		* Anarchist Lust for Life (active regen)
		
			Multiplayer
		* Second Wind (from teammate)
		
		* Downed (check playerbleedout.lua state)
		
		
		* revive_damage_reduction is created in playermanager:set_property but only name and value are passed, not timer
		
			
	&&& HIGH PRIORITY: &&&
		* underbarrel base does not trigger HUD change (ammo tick, crosshair)
		
		- BUG: Teammates panel and tabscreen are not correct for drop-ins
		- Bots have no icon
	
	
		* HUDTeammate:set_custom_radial() (swansong and what have you for teammates)
		
		* Add menu button to set teamname
		* Add menu button to set teamcolor (through beardlib)
		
		* HUD SHOULD BE CREATED OUTSIDE OF HUDMANAGER 

		* BAI sync data compatibility?

		%% BUGS:
			
			- Floating ammo panel has incorrect width after switching weapons
			- Shield noises (low/depleted) may persist during loading
			- Trip Mines have their text cut off (14 | 6 is way too long in eurostile_ext)
				* resize font size based on length? 
				* change label position? 
				* change font?
			- Assault phase localization when not host
			- Vanilla HUD is visible in drop-in spectate mode
			- Multiple concurrent Pocket ECM Jammer buffs may interfere with each other
			- Down Counter Standalone will fight NobleHUD for dominance when it comes to setting downs in the tabscreen
				* This is because I tried to add compatibility between the two via network syncing, but didn't save whether or not peers had DCS in NobleHUD

		%% FEATURES: %%
			* Tab screen
				--move scoreboard based on score or peerid?
			* Teammates panel
				- center vertically to subpanel
				- ammo?
			* Mod options
		
	&& LOW PRIORITY FEATURES: &&

		* Detect teammate dead through set condition mugshot_custody
			* Set nickname color to red
			* Set nickname text to "X"
		* Damage numbers popups
				
		* Weapontype-specific bloom decay
		* Blinky "No ammo" alert
		* Voice command radial
		
		* [ASSET] Created flamethrower reticle looks like shit, current one is extremely unoptimized
		* Show other things, such as equipment, on radar? check slotmask 
		* Adjust overshield color to be more green (check MCC screenshots)
		* Flash mission name at mission start? (See mission/submission name in MCC screenshots)
				
		* Joker panel
		* Mod options
			* Slider setting for popup_fadeout_time
			* Keybinds for Safety etc
			* Placement and Scaling
				* weapons? 
				* deployable scaling?
				* score panel?
		* HIGH SCORES
			- Convert scores to credits after each run; add "purchaseable" items for credits
			- Unusual effects? On-death SFX (grunt birthday party?)
		
		* Apply update opacity for all elements from menu
		* Organize color data
			- All HUD elements should be the same blue color
			- Ability circle needs a baked-blue asset
		* Auntie dot
			* Subtitles: Auntie dot voice lines with associated queues (requires vo assets/updated asset dump)
			* background non-lit grid should probably be invisible, or flicker to invisible after flickering off
			* should be layered over as the loading screen, and stretched to fit screen
			* during loading screen, should be under text but above blackscreen;
			* in-game, should be entirely below hud, layerwise
		* Animate function for text that randomly hides individual characters (similar to auntie dot's fadeout function)
			* Given list of integers representing non-space character positions, foreach hide animate(text:set_color_range(pos,pos,color:with_alpha(a))) after random(n) delay
			* Mainly for use in Objectives panel
		* Mod Options:
			* Grenade/deployable area swap
		* Suspicion panel?
		* Crosshair stuff
			* add crosshair data for everything lol
			* melee crosshair
			* manually selectable 
			* customizable alpha (master)
		* Assault timer? Nah Dom's got it covered in BAI
		* Killfeed
			* Integration with JoyScoreCounter
			* Record medals with score
			* Show weapon icon (PLAYERNAME [WEAPON_ICON] ENEMYNAME) ?
		* More Medals:
			* Seek and Destroy (for bosses?)
			* EMP Blast for stunned enemies?
			* Hero or assist for reviving teammates?
			* Protector? hard to implement but not impossible
			* Yoink?

		&& DECISIONS &&
			* Should graze kills give sniper medals? currently, they don't
			* Should ECM Jammers only show their radar decoys when a player is within range of the ECM jammer? 
				This would match Halo 3's Radar Jammer behaviour,
				where decoys would appear in the radius 
			
	&& BEAUTIFY EXISTING: &&
		* Increase height of teammate panels + Vitals panel, so that the text doesn't get in the way of the blinky icon 
		* Standardize HUD style data for any given panel eg. ponr font size; this will facilitate adding scaling and movement later on
		* Shield damage chunking
		* PONR label goes where "BONUS ROUND" was in reach
			* Flash as countdown enabled
		* Callsign generator
			* remove clantags
			* remove doubled letters
		* Carry indicator is kind of hard to see
		* Grenade/Ability
			* Ability circle color should be colored blue by default
			* Counter is unreadable- needs shadow or better placement
				* shadow is better, to show during flashbangs
		* Reticle/Weapon stuff
			* DMR should be scaled down ever so slightly
			* Streamline like the whole code process, it's unreadable
			* Adjust positioning of subpanels (new font?)
			* Firemode indicator
			* Underbarrel should change reticle
			* Grenade Launcher crosshair
				* Right arrow should do something
				* Left arrow rotates with distance?
				* Left arrow is not colored (frame, circle, and altimeter are already colored)
		* Radar	
			* Motion-based tracking
			* Radar pulse when update?
			* Different motion tracker icon or color for Team AI versus players
			* Lower blip should be darker/lower opacity, instead of halo 3 style
			* Unique vehicle blip asset texture so that they're not blurry?


		
	&& CREATE ASSETS: &&

		-- Firemode indicator
		-- Crosshair textures
			- Other vehicles?
				* Scorpion
				* Gauss hog gunner?
				* Falcon?
				* Banshee?
				* Ghost? [ref]
				* Revenant? 
				* Wraith? [ref]
		-- Ammo type tick variant textures
			- Weapon Overheat meter? (Reach)
			- DMR
			- AR
			- Pistol
			- Rocket
			- SMG
			- Car
			- Saw
			- Shotgun (rename)

--grenade/ability outline (baked blue color for vertex radial render template)
--score banner small
- bloom funcs should all have a reference to their own crosshair tweakdata
- bloom funcs should also have reference to their own weapon tweakdata
- crosshair data blacklist should be replaced by a manual override list for weapon ids, or from tweak data

CODE:

--settings
--score panel
--joyscore (modified)
	* update to recent joyscore points list
	* mutator multipliers

--ability/deployable/grenade
	* grenade vs deployable layout
		* grenade selection indicator
		* secondary grenade panel

--reticle bloom
	* standardize reticle subparts

--]]


local modpath = NobleHUD:GetPath()
NobleHUD._mod_path = modpath
NobleHUD._options_path = modpath .. "menu/"
NobleHUD._localization_path = modpath .. "localization/"
NobleHUD._cartographer_path = modpath .. "cartographer/"
NobleHUD._announcer_path = modpath .. "assets/snd/announcer/"

NobleHUD._buff_settings_path = SavePath .. "noblehud_buff_settings.txt"
NobleHUD._settings_path = SavePath .. "noblehud_settings.txt"
NobleHUD.num_killfeed_messages = 0

NobleHUD._killfeed_start_x = 100
NobleHUD._killfeed_start_y = 420
NobleHUD._killfeed_end_x = 100
NobleHUD._killfeed_end_y = 430

NobleHUD._popup_start_x = 800
NobleHUD._popup_start_y = 400
NobleHUD._popup_end_x = 800
NobleHUD._popup_end_y = 400

NobleHUD._medal_start_x = 64
NobleHUD._medal_start_y = 400
NobleHUD._medal_end_x = 64
NobleHUD._medal_end_y = 400

NobleHUD._medal_atlas = "guis/textures/medal_atlas"

NobleHUD._MIN_CALLSIGN_LEN = 3
NobleHUD._MAX_CALLSIGN_LEN = 4

NobleHUD.num_medals = 0

NobleHUD._VITALS_W = 512
NobleHUD._VITALS_H = 64
NobleHUD._VITALS_TICK_W = 24
NobleHUD._VITALS_TICK_H = 20
NobleHUD._VITALS_FONT_SIZE = 16
NobleHUD._VITALS_TICK_W_CENTER = 36
NobleHUD._VITALS_TICK_SCALE = 0.85
NobleHUD._VITALS_WARNING_Y = 12

NobleHUD._HUD_HEALTH_TICKS = 8
NobleHUD._RADAR_REFRESH_INTERVAL = 0.5
NobleHUD._radar_refresh_t = 0
NobleHUD._RADAR_GHOST_INTERVAL = 0.066
NobleHUD._RADAR_GHOST_FADEIN = 0.15
NobleHUD._RADAR_GHOST_FADEOUT = 0.45
NobleHUD._radar_ghost_t = 0

NobleHUD._RADAR_SIZE = 200
NobleHUD._RADAR_BG_SIZE = 196
NobleHUD._RADAR_TEXT_SIZE = 16

NobleHUD._buff_refresh_t = 0
NobleHUD._BUFF_REFRESH_INTERVAL = 0.25
NobleHUD._BUFF_ITEM_W = 175
NobleHUD._BUFF_ITEM_W_COMPACT = 72
NobleHUD._BUFF_ITEM_H = 32
NobleHUD._BUFF_ITEM_H_COMPACT = 32

NobleHUD._NAMEPLATE_W = 152
NobleHUD._NAMEPLATE_H = 64

NobleHUD._INTERACT_BAR_PANEL_W = 256
NobleHUD._INTERACT_BAR_PANEL_H = 40
NobleHUD._INTERACT_NAME_Y = 200
NobleHUD._INTERACT_BAR_Y = 100
NobleHUD._INTERACT_BAR_W = 128
NobleHUD._INTERACT_BAR_H = 16
NobleHUD._INTERACTION_FONT_SIZE = 16

NobleHUD._TEAMMATE_ITEM_W = 512
NobleHUD._TEAMMATE_ITEM_H = 48
NobleHUD._MAX_REVIVES = 3 --default init value; updated on load

NobleHUD._font_eurostile_kern = 2

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
	steelsight_hides_floating_ammo_enabled = true,
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
	damage_popups_fadeout = 0.5,
	damage_popups_show_raw = false
}

NobleHUD.buff_settings = {
	dodge_chance_threshold = 0,
	crit_chance_threshold = 0,
	dmg_resist_threshold = 0
}

--buff data priorities:
--ongoing: 1 (crit/dodge/resist,biker)
--ongoing, temporary: (grinder, expres, maniac) 2
--mid-term: 3 (inspire cooldown, overkill)
--short term: 5 (bullseye)
--super short term: 7
NobleHUD._buff_data = {
	["vip"] = {
		source = "manual",
		priority = 1,
		icon = "guis/textures/skull_phalanx",
		text_color = NobleHUD.color_data.hud_buff_negative,
		label = "noblehud_hud_assault_phase_phalanx",
		label_compact = "",
		value_type = "status",
		flash = true
	},
	["ecm_normal"] = { --not implemented
		source = "skill",
		priority = 0,
		icon = "ecm_2x",
		icon_rect = {3,4},
		label = "noblehud_buff_ecm_normal_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 20, -- tweak_data.upgrades.ecm_jammer_base_battery_life
		flash = false
	},
	["ecm_strong"] = { --not implemented
		source = "skill",
		priority = 0,
		icon = "ecm_booster",
		icon_rect = {6,3},
		label = "noblehud_buff_ecm_normal_label",
		value_type = "timer",
		label_compact = "$TIMER",
		duration = 30, --(tweak_data.upgrades.ecm_jammer_base_battery_life * 1.5)
		flash = false
	},
	["ecm_feedback"] = { --not implemented
		source = "skill",
		priority = 0,
		icon = "ecm_feedback",
		icon_rect = {1,2},
		label = "noblehud_buff_ecm_normal_label",
		value_type = "timer",
		label_compact = "$TIMER",
		duration = 15, --tweak_data.upgrades.ecm_feedback_min_duration 
		flash = false
	},
	["dmg_resist_total"] = { --aggregated
		source = "skill",
		priority = 1,
		icon = "juggernaut", --naut too sure about this icon. --drop_soap?
		label = "noblehud_buff_dmg_aggregated_label",
		value_type = "value",
		label_compact = "$VALUE%",
		flash = false
	},
	["crit_chance_total"] = { --aggregated
		source = "skill",
		priority = 1,
		icon = "backstab",
		label = "noblehud_buff_crit_aggregated_label",
		label_compact = "$VALUE%",
		value_type = "value",
		flash = false
	},
	["dodge_chance_total"] = { --aggregated
		source = "skill",
		priority = 1,
		icon = "jail_diet", --'dance_instructor' is pistol mag bonus
		label = "noblehud_buff_dodge_aggregated_label",
		label_compact = "$VALUE%",
		value_type = "value",
		flash = false
	},
	["hp_regen"] = { --aggregated, standard timed-healing from multiple sources (muscle, hostage taker, etc)
		source = "perk",
		priority = 1,
		icon = 17, --chico perk deck
		icon_tier = 3, --heart with hollow +  
		persistent_timer = true,
		label = "noblehud_buff_regen_aggregated_label",
		label_compact = "x$VALUE $TIMER",
		duration = 10,
		value_type = "timer",
		text_color = Color("FFD700"),
		flash = false
	},
	["long_dis_revive"] = {
		source = "skill",
		priority = 3,
		icon = "inspire",
		icon_rect = {4,9},
		label = "noblehud_buff_long_dis_revive_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 20,
		text_color = NobleHUD.color_data.hud_buff_negative,
		flash = true
	},
	["morale_boost"] = {
		source = "skill",
		priority = 3,
		icon = "inspire",
		icon_rect = {4,9},
		label = "noblehud_buff_morale_boost_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 4,
		flash = false
	},
	["fully_loaded"] = { --throwable pickup chance; not implemented
		disabled = true,
		priority = 2
	},
	["dire_need"] = { --todo
		source = "skill",
		priority = 1,
		icon = "drop_soap",
		label = "noblehud_buff_dire_need",
		label_compact = "$TIMER",
		duration = 10,
		value_type = "timer",
		flash = true
	},
	["hitman"] = {
		source = "perk",
		priority = 5,
		icon = 4, --hitman perk deck
		icon_tier = 7,
--		disabled = true, --guaranteed regen from Hitman 9 Tooth and Claw; not implemented
		label = "noblehud_buff_hitman_label",
		label_compact = "$TIMER",
		persistent_timer = true,
		duration = 1.5,
		value_type = "timer",
		text_color = NobleHUD.color_data.hud_buff_status,
		flash = false
	},
	["overdog"] = {
		source = "perk",
		priority = 4,
		icon = 9,
		icon_tier = 1,
		label = "noblehud_buff_overdog",
		label_compact = "x$VALUE $TIMER",
		value_type = "timer", --10x melee damage within 1s from infiltrator 1 or Sociopath 1, Overdog; not implemented
		duration = 1,
		text_color = NobleHUD.color_data.hud_buff_positive,
		flash = true
	},
	["tension"] = { 
		disabled = true,
		source = "perk",
		priority = 7,
		duration = 1,
		icon = 9,
		icon_tier = 3,
		label = "noblehud_buff_tension",
		label_compact = "$TIMER",
		value_type = "timer", --sociopath armorgate on kill cooldown; 3; also blending in so idk
		text_color = NobleHUD.color_data.hud_buff_negative,
		flash = true
	},
	["clean_hit"] = { 
		disabled = true,
		source = "perk",
		priority = 7,
		duration = 1,
		icon = 9,
		icon_tier = 3,
		label = "noblehud_buff_clean_hit",
		label_compact = "$TIMER",
		value_type = "timer", --sociopath health regen on melee kill cooldown; 5/9; also blending in so idk
		text_color = NobleHUD.color_data.hud_buff_negative,
		flash = true
	},
	["overdose"] = {
		disabled = true,
		source = "perk",
		priority = 7,
		duration = 1,
		icon = 9,
		icon_tier = 3,
		label = "noblehud_buff_overdose",
		label_compact = "$TIMER",
		value_type = "timer", --sociopath armorgate on medium range kill cooldown; 7/9; also blending in so idk
		text_color = NobleHUD.color_data.hud_buff_negative,
		flash = true
	},
	["melee_life_leech"] = {
		source = "perk",
		priority = 3,
		duration = 10,
		icon = 8,
		icon_tier = 9,
		label = "noblehud_buff_infiltrator_life_drain",
		label_compact = "$TIMER",
		text_color = NobleHUD.color_data.hud_buff_negative,
		value_type = "timer", --melee hit regens 20% hp, once per 10s from infiltrator 9/9 Life Drain; not implemented
		flash = false
	},
	["loose_ammo_restore_health"] = { --gambler medical supplies
		source = "perk",
		priority = 5,
		duration = 3,
		value_type = "timer", --n health on ammo pickup, once per 3s from Gambler 1/9 Medical Supplies
		icon = 10,
		icon_tier = 1,
		tier_floors = {1,7,9},
		label = "noblehud_buff_gambler_medical_supplies_label",
		label_compact = "$TIMER",
		text_color = NobleHUD.color_data.hud_buff_negative,
		value_type = "timer",
		source = "perk",
		flash = false
	},
	["loose_ammo_give_team"] = { --gambler ammo give out
		source = "perk",
		priority = 63,
		duration = 5,
		value_type = "timer", -- half normal ammo pickup to all team members once every 5 seconds from Gambler 3
		icon = 10,
		icon_tier = 3,
		icon_rect = {3,5},
		label = "noblehud_buff_gambler_ammo_give_out_label",
		label_compact = "$TIMER",
		text_color = NobleHUD.color_data.hud_buff_negative,
		value_type = "timer",
		flash = false
	},
	["grinder"] = {
		source = "perk",
		priority = 2,
		icon = 11,
		icon_tier = 1, --overridden by tier_floors
		tier_floors = {1,3,5,7,9},
		icon_rect = {6,1},
		label = "noblehud_buff_grinder_label",
		label_compact = "x$VALUE",
		value_type = "value",
		flash = false
	},
	["yakuza"] = {
		source = "perk",
		priority = 2,
		disabled = false,
		icon = 12,
		icon_tier = 3,
		label = "noblehud_buff_yakuza_label",
		label_compact = "x$VALUE",
		value_type = "value", --armor recovery rate, like berserker
		flash = false
	},
	["expresident"] = {
		source = "perk",
		priority = 2,
		disabled = false,
		icon = 13, --ex-president perk deck
		icon_tier = 1,
		text_color = NobleHUD.color_data.hud_buff_positive,
		label = "noblehud_buff_expresident_label",
		label_compact = "$VALUE%",
		value_type = "value", --stored health
		flash = true
	},
	["hysteria"] = {
		source = "perk",
		priority = 2,
		icon = 14,
		icon_rect = {1,7},
		tier_floors = {1,9},
		icon_tier = 1,
		label = "noblehud_buff_maniac_label",
		label_compact = "x$VALUE",
		value_type = "value",
		flash = true
	},
	["anarchist_armor_regen"] = {
		source = "perk",
		priority = 1,
		icon = 15,
		icon_tier = 1,
		label = "noblehud_buff_anarchist_label",
		label_compact = "$TIMER",
		persistent_timer = true,
		text_color = NobleHUD.color_data.hud_buff_status,
		value_type = "timer",
		flash = false
	},
	["anarchist_lust_for_life"] = {
		disabled = true,
		source = "perk",
		priority = 4,
		icon = 15,
		icon_tier = 9,
		duration = 1.5,
		label = "noblehud_buff_anarchist_lust_for_life_label",
		label_compact = "$TIMER",
		text_color = NobleHUD.color_data.hud_buff_negative,
		value_type = "timer",
		flash = true
	},
	["armor_break_invulnerable"] = {
		source = "perk",
		priority = 3,
		icon = 15,
		icon_tier = 1,
		label = "noblehud_buff_armor_break_invulnerable_active_label",
		label_compact = "$TIMER",
		text_color = NobleHUD.color_data.hud_buff_negative,--red for 15s cooldown; blue for 2s invuln period
		value_type = "timer",
		flash = false
	},
	["wild_kill_counter"] = {
		source = "perk",
		priority = 1,
		icon = 16,
		icon_tier = 1,
		label = "noblehud_buff_biker_label",
		label_compact = "$TIMER",
		value_type = "timer",
		text_color = NobleHUD.color_data.hud_buff_status,
		icon_color = NobleHUD.color_data.hud_buff_neutral,
		persistent_timer = true,
--		render_template = "VertexColorTexturedRadialFlex",
		flash = true
	},
	["chico_injector"] = {
		source = "perk",
		priority = 3,
		icon = 17,--"chico_injector",
		icon_tier = 1,
		label = "noblehud_buff_kingpin_label",
		label_compact = "$TIMER",
		icon_color = NobleHUD.color_data.hud_buff_status,
		value_type = "timer",
		flash = true
	},
	["sicario"] = {
		source = "perk",
		priority = 3,
		icon = 18,
		tier_floors = {1,9},
		icon_tier = 1,
		label = "noblehud_buff_sicario_label",
		label_compact = "",
		text_color = NobleHUD.color_data.hud_buff_status,
		value_type = "timer",
		flash = true
	},
	["delayed_damage"] = {
		source = "perk",
		priority = 3,
		icon = 19,
		tier_floors = {1,9},
		icon_tier = 1,
		label = "noblehud_buff_delayed_damage_label",
		label_compact = "x$VALUE $TIMER",
		value_type = "value",
		flash = true
		--health counter
	},
	["tag_team"] = {
		source = "perk",
		priority = 3,
		icon = 20,
		icon_tier = 1,
		label = "noblehud_buff_tag_team_label",
		label_compact = "$TIMER",
		value_type = "timer", --is being tagged; tag team duration
		priority = 3
	},
	["pocket_ecm_jammer"] = {
		source = "perk",
		priority = 5,
		icon = 21,--"pocket_ecm_jammer",
		icon_tier = 1,
		label = "noblehud_buff_hacker_ecm_label",
		label_compact = "$TIMER",
		icon_color = NobleHUD.color_data.hud_buff_status,
		value_type = "timer",
		flash = true
	},
	["pocket_ecm_jammer_feedback"] = {
		source = "perk",
		priority = 5,
		icon = 21,--"pocket_ecm_jammer",
		icon_tier = 1,
		label = "noblehud_buff_hacker_feedback_label",
		label_compact = "$TIMER",
		icon_color = NobleHUD.color_data.hud_buff_status,
		value_type = "timer",
		flash = true
	},
	["pocket_ecm_kill_dodge"] = {
		source = "perk",
		priority = 3,
		icon = 21,--"pocket_ecm_jammer",
		icon_tier = 7,
		label = "noblehud_buff_hacker_kluge_label",
		label_compact = "$TIMER",
		value_type = "timer",
		flash = false
	},
	["flashbang"] = {
		source = "icon", --where to get icon (not directly related to where ingame buff came from)
		priority = 7,
		icon = "concussion_grenade", --if no source is specified, use this icon tweak data
--		icon_rect = {1,7}, --if source is "manual" then use "icon" as path and "icon_rect" to find bitmap
		label = "noblehud_buff_flashbang_label", --display name
		label_compact = "$TIMER",
		text_color = Color.black:with_alpha(0.3),
		icon_color = NobleHUD.color_data.hud_buff_negative,
		value_type = "timer", --value calculation type
		flash = true --alpha sine flash if true
	},
	["downed"] = { --i think people will probably figure out that they've been downed, actually. unless they're flashbanged.
		source = "icon",
		priority = 3,
		disabled = true,
		icon = "mugshot_downed",
		icon_rect = {240,464,48,48},
		label = "downed",
		label_compact = "$TIMER",
		text_color = NobleHUD.color_data.hud_buff_negative,
		value_type = "timer",
		duration = 30,
		flash = false
	},
	["tased"] = {
		source = "icon",
		priority = 3,
		icon = "mugshot_electrified",--skill icon "insulation",
		label = "noblehud_buff_tased_label",
		label_compact = "$TIMER",
		icon_color = Color.white,
		text_color = NobleHUD.color_data.hud_buff_negative,
		value_type = "timer",
		flash = true
	},
	["electrocuted"] = {
		source = "icon",
		priority = 3,
		icon = "mugshot_electrified",
		label = "noblehud_buff_electrocuted_label",
		label_compact = "$TIMER",
		icon_color = Color.yellow,
		text_color = NobleHUD.color_data.hud_buff_negative,
		value_type = "timer",
		flash = true
	},
	["swan_song"] = {
		source = "skill",
		priority = 3,
		icon = "perseverance",
		duration = 3, --6 aced
		label = "noblehud_buff_swan_song_label",
		label_compact = "$TIMER",
		text_color = NobleHUD.color_data.strange,
		value_type = "timer",
		flash = true
	},
	["messiah_charge"] = {
		source = "skill",
		priority = 2,
		icon = "messiah",
		text_color = NobleHUD.color_data.hud_buff_status,
		label = "noblehud_buff_messiah_charge_label",
		label_compact = "x$VALUE",
		value_type = "value", --just in case multiple messiah charges is ever implemented, or modded in
		flash = false
	},
	["messiah_ready"] = {
		source = "skill",
		priority = 1,
		icon = "messiah",
		icon_color = NobleHUD.color_data.hud_buff_positive,
		text_color = NobleHUD.color_data.hud_buff_positive,
		label = "noblehud_buff_messiah_ready_label",
		label_compact = "RDY", --!
		value_type = "status",
		flash = true
	},
	["bullseye"] = { --DONE
		source = "skill",
		priority = 5,
		icon = "prison_wife",
		icon_rect = {6,11},
		label = "noblehud_buff_bullseye_label",
		label_compact = "$TIMER",
		value_type = "timer",
		text_color = NobleHUD.color_data.hud_buff_negative,
		duration = 2.5,
		flash = true
	},
	["uppers_aced_cooldown"] = {
		source = "skill",
		priority = 2,
		icon = "tea_cookies",
		label = "noblehud_buff_uppers_cooldown_label",
		label_compact = "$TIMER",
		text_color = NobleHUD.color_data.hud_buff_negative,
		value_type = "timer",
		flash = false
	},
	["uppers_ready"] = {
		source = "skill",
		priority = 2,
		icon = "tea_cookies",
		label = "noblehud_buff_uppers_ready_label",
		label_compact = "RDY", --!
		text_color = NobleHUD.color_data.hud_buff_status,
		value_type = "status",
		flash = false
	},
	["berserker_damage_multiplier"] = {
		source = "skill",
		priority = 2,
		icon = "wolverine",
		label = "noblehud_buff_berserker_aced_label",
		label_compact = "$VALUE%",
		value_type = "value",
		flash = true
	},
	["berserker_melee_damage_multiplier"] = {
		source = "skill",
		priority = 2,
		icon = "wolverine",
		label = "noblehud_buff_berserker_label",
		label_compact = "$VALUE%",
		value_type = "value",
		flash = true
	},
	["bullet_storm"] = {
		source = "skill",
		priority = 3,
		icon = "ammo_reservoir",
		icon_rect = {0,3},
		label = "noblehud_buff_bulletstorm_label",
		label_compact = "$TIMER",
		value_type = "timer",
		flash = false	
	},
	["unseen_strike"] = { --DONE
		source = "skill",
		priority = 3,
		icon = "unseen_strike",
		label = "noblehud_buff_unseen_strike_label",
		label_compact = "$TIMER",
		duration = 18, --debug purposes only; t is passed
		value_type = "timer",
		flash = false
	},
	["overkill_damage_multiplier"] = {
		source = "skill",
		priority = 3,
		icon = "overkill",
		label = "noblehud_buff_overkill_label",
		label_compact = "$TIMER",
		value_type = "timer",
		flash = false
	},
	["bloodthirst_melee"] = {
		source = "skill",
		priority = 3,
		disabled = false,
		icon = "bloodthirst", --assassin?
		label = "noblehud_buff_bloodthirst_melee_label",
		label_compact = "x$VALUE",
		value_type = "value", --not sure
		flash = false
	},
	["bloodthirst_reload_speed"] = {
		source = "skill",
		priority = 4,
		icon = "bloodthirst",
		icon_rect = {1,7},
		label = "noblehud_buff_bloodthirst_reload_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 10,
		flash = false	
	},
	["team_damage_speed_multiplier_received"] = {
		source = "skill",
		priority = 5,
		icon = "scavenger",
		icon_rect = {10,9},
		label = "noblehud_buff_second_wind_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 5,
		flash = false
	},
	["damage_speed_multiplier"] = {
		source = "skill",
		priority = 5,
		icon = "scavenger",
		icon_rect = {10,9},
		label = "noblehud_buff_second_wind_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 5,
		flash = false
	},
	["sixth_sense"] = {
		source = "skill",
		priority = 7,
		icon = "chameleon",
		label = "noblehud_buff_sixth_sense_label",
		label_compact = "$TIMER",
		value_type = "timer",
		persistent_timer = true,
--		timer_source = "player",
		flash = false
	},
	["revive_damage_reduction"] = { --combat medic
		source = "skill",
		priority = 5,
		icon = "combat_medic",
		icon_rect = {5,7},
		label = "noblehud_buff_combat_medic_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 5,
		flash = false
	},
	["trigger_happy"] = {
		source = "skill",
		priority = 3,
		icon = "trigger_happy",
		label = "noblehud_buff_trigger_happy_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 2, --4 aced
		flash = false
	},
	["desperado"] = {
		source = "skill",
		priority = 3,
		icon = "expert_handling",
		label = "noblehud_buff_desperado_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 10,
		flash = false
	},
	["partners_in_crime"] = {
		source = "skill",
		priority = 3,
		icon = "control_freak",
		label = "noblehud_buff_partners_in_crime_label",
		label_compact = "",
		value_type = "status", --move speed from hostage
		flash = false
	},
	["partners_in_crime_aced"] = {
		source = "skill",
		priority = 3,
		disabled = true, --same proc conditions as basic
		icon = "control_freak",
		label = "noblehud_buff_partners_in_crime_aced_label",
		label_compact = "",
		value_type = "status", --hp boost from hostage
		flash = false,
	},
	["single_shot_fast_reload"] = {
		source = "skill",
		priority = 5,
		icon = "speedy_reload",
		label = "noblehud_buff_aggressive_reload_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 4,
		flash = false
	},
	["shock_and_awe_reload_multiplier"] = {
		source = "skill",
		priority = 5,
		icon = "shock_and_awe",
		label = "noblehud_buff_lock_n_load_label",
		label_compact = "x$VALUE",
		value_type = "value", --auto multikills reload speed from skilltree "lock n load"
		flash = false
	},
	["dmg_multiplier_outnumbered"] = { --underdog dmg boost; DONE
		source = "skill",
		priority = 7,
		icon = "underdog",
		label = "noblehud_buff_underdog_label",
		label_compact = "$TIMER",
		value_type = "timer",
		flash = false
	},
	["dmg_dampener_outnumbered"] = { --underdog dmg resist; DONE
		source = "skill",
		priority = 7,
		disabled = true,
		icon = "underdog",
		label = "noblehud_buff_underdog_aced_label",
		label_compact = "$TIMER",
		value_type = "timer",
		flash = false
	},
	["dmg_dampener_close_contact"] = { --dmg resist; activates in conjuction with underdog but lasts 5 seconds??? ovk y u do dis
		source = "skill",
		priority = 7,
		disabled = true,
		icon = "underdog",
		label = "dmg_dampener_close_contact",
		label_compact = "$TIMER",
		value_type = "timer",
		flash = false
	},	
	["dmg_dampener_outnumbered_strong"] = { --same as above, but aced
		source = "skill",
		priority = 7,
		disabled = true,
		icon = "underdog",
		label = "dmg_dampener_outnumbered_strong",
		label_compact = "$TIMER",
		value_type = "timer",
		flash = false
	},
	["combat_medic_damage_multiplier"] = {
		priority = 5,
		disabled = true
	},
	["combat_medic_enter_steelsight_speed_multiplier"] = {
		priority = 5,
		disabled = true
	},
	["stockholm_ready"] = {
		disabled = true,
		priority = 2,
		value_type = "status"
	},
	["first_aid_damage_reduction"] = { --120s 10% damage reduction from using fak/docbag
		source = "skill",
		priority = 3,
		icon = "tea_time",
		icon_rect = {1,11},
		label = "noblehud_buff_quick_fix_label",
		value_type = "timer",
		label_compact = "$TIMER",
		flash = false
	},
	["reload_weapon_faster"] = { --running from death basic, part 1
		source = "skill",
		priority = 3,
		icon = "running_from_death", --or speedy_reload
		label = "noblehud_buff_running_from_death_reload_label",
		value_type = "timer", --reload + swap faster after revive
		label_compact = "$TIMER",
		duration = 10,
		flash = true	
	},
	["swap_weapon_faster"] = { --running from death basic, part 2; disabled due to identical proc conditions + duration
		disabled = true,
		source = "skill",
		priority = 3,
		icon = "speedy_reload",
		label = "noblehud_buff_running_from_death_swap_label",
		value_type = "timer",
		label_compact = "$TIMER",
		duration = 10,
		flash = true
	},
	["increased_movement_speed"] = { --running from death aced; disabled due to identical proc conditions + duration
		disabled = true,
		source = "skill",
		priority = 3,
		icon = "running_from_death",
		label = "noblehud_buff_running_from_death_aced_label",
		value_type = "timer",
		label_compact = "$TIMER",
		duration = 10,
		flash = true
	},
	["revived_damage_resist"] = { --up you go basic
		source = "skill",
		priority = 3,
		icon = "up_you_go",
		icon_rect = {11,4},
		label = "noblehud_buff_up_you_go_label",
		value_type = "timer",
		label_compact = "$TIMER",
		duration = 10,
		flash = true
	}
}

for buff_id,buff_data in pairs(NobleHUD._buff_data) do 
	if not buff_data.disabled then
		NobleHUD.buff_settings[buff_id] = true
	else
		NobleHUD.buff_settings[buff_id] = false
	end
end

NobleHUD.chat_notification_sounds = {
	"advance.ogg",
	"beep1.ogg",
	"beep2.ogg",
	"beep3.ogg",
	"beep4.ogg",
	"bumper5.ogg"
}

NobleHUD.special_chars = {
	skull = ""
}

NobleHUD._toxic_messages = {
	"I feel very, very small... please hold me...",
	"It's past my bedtime. Please don't tell my mommy.",
	"I'm wrestling with some insecurity issues in my life but thank you for playing with me.",
	"I'm trying to be a nicer person. It's hard, but I'm trying, guys.",
	"Ah shucks... you guys are the best!",
	"C'mon, Mom! One more game before you tuck me in. Oops mistell.",
	"For glory and honor! Huzzah comrades!",
	"Gee whiz! That was fun. Good playing!",
	"Good game! Best of luck to you all!",
	"Great game, everyone!",
	"I could really use a hug right now.",
	"It was an honor to play with you all. Thank you.",
	"It's past my bedtime. Please don't tell my mommy.",
	"Mommy says people my age shouldn't suck their thumbs.",
	"Well played. I salute you all.",
	"Wishing you all the best.",
	"Wort wort wort!",
	"I would have been your daddy, but... aw, nevermind."
}

NobleHUD.fonts = { --not currently used
	eurostile_ext = "fonts/font_eurostile_ext",
	eurostile_normal = "fonts/font_eurostile"
}

NobleHUD._assault_phases = {
	anticipation = "noblehud_hud_assault_phase_anticipation",
	build = "noblehud_hud_assault_phase_build",
	sustain = "noblehud_hud_assault_phase_sustain",
	fade = "noblehud_hud_assault_phase_fade",
	control = "noblehud_hud_assault_phase_control",
	phalanx = "noblehud_hud_assault_phase_phalanx",
	generic_on = "noblehud_hud_assault_phase_generic_on",
	generic_off = "noblehud_hud_assault_phase_generic_off"
}

NobleHUD._random_chars = {
	letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
	numbers = "1234567890",
	characters = "-=!@#%$^&*()_+{}:|<>?[];,/"
}

NobleHUD._killfeed_presets = {
	presenter_title = {
		duration = 0.25,
		lifetime = 6,
		font_size = 16,
		color_1 = NobleHUD.color_data.hud_killfeed_yellow,
		color_2 = NobleHUD.color_data.hud_killfeed_lightyellow
	},
	presenter_desc = {
		duration = 0.25,
		lifetime = 7,
		font_size = 16,
		color_1 = NobleHUD.color_data.hud_killfeed_yellow,
		color_2 = NobleHUD.color_data.hud_killfeed_lightyellow
	},
	hint = {
		duration = 0.25,
		lifetime = 5,
		font_size = 16,
		color_1 = NobleHUD.color_data.hud_hint_orange,
		color_2 = NobleHUD.color_data.hud_hint_lightorange
	},
	wave = {
		duration = 0.25,
		lifetime = 7,
		font_size = 18,
		color_1 = NobleHUD.color_data.hud_hint_orange,
		color_2 = NobleHUD.color_data.hud_hint_lightorange
	}
}

NobleHUD.score_unit_points = {
	civilian = -25, 
	civilian_female = -25,
	sniper = 3, --sniper
	shield = 5, --shield
	phalanx_minion = 5, --winters shield
	phalanx_vip = 100, --winters
	medic = 6, --medic
	taser = 7, --taser
	spooc = 10, --cloaker 
	shadow_spooc = 20, --cloaker 
	tank = 12, --dozer
	tank_hw = 12, --headless dozer
	tank_medic = 12,
	tank_mini = 12,
	swat_turret = 16,
	security_undominatable = -1000, --garrett
	mute_security_undominatable = -1000, --also garrett i guess
	security = 1,
	gensec = 1,
	cop = 1,
	cop_scared = 1,
	cop_female = 1,
	fbi = 1,
	swat = 1,
	heavy_swat = 1,
	heavy_swat_sniper = 1,
	fbi_swat = 1,
	fbi_heavy_swat = 1,
	city_swat = 1,
	gangster = 1,
	biker = 1,
	biker_escape = 1,
	mobster = 1,
	mobster_boss = 100, --commissar fucks again asshole
	biker_boss = 100, --the biker heist day 2 boss 
	chavez_boss = 100, --panic room man
	hector_boss = 100, 
	hector_boss_no_armor = 100,
	bolivian = 1,
	bolivian_indoors = 1,
	bolivian_indoors_mex = 1,
	drug_lord_boss = 100, --sosa
	drug_lord_boss_stealth = 100, --also sosa
	security_mex = 1,
	
	deathvox_guard = 1,
	deathvox_gman = 1,
	deathvox_lightar = 1,
	deathvox_lightshot = 1,
	deathvox_heavyar = 1,
	deathvox_heavyshot = 1,
	deathvox_shield = 5,
	deathvox_medic = 6,
	deathvox_taser = 7,
	deathvox_tank = 12,
	deathvox_cloaker = 10,
	deathvox_sniper = 3,
	deathvox_greendozer = 12,
	deathvox_blackdozer = 12,
	deathvox_lmgdozer = 12,
	deathvox_medicdozer = 12,
	deathvox_guarddozer = 12,
	deathvox_grenadier = 7,
	deathvox_cop_pistol = 1,
	deathvox_cop_smg = 1,
	deathvox_cop_revolver = 1, 
	deathvox_cop_shotgun = 1,
	deathvox_fbi_rookie = 1,
	deathvox_fbi_hrt = 1,
	deathvox_fbi_veteran = 1,
	
	--RESTORATION MOD VALUES
	tank_green = 12,
	tank_black = 12,
	tank_skull = 12,
	tank_biker = 12,
	boom = 6,
	boom_summers = 12,
	taser_summers = 12,
	medic_summers = 12,
	rboom = 12,
	heavy_swat_sniper = 3,
	weekend_dmr = 2,
	tank_titan = 24,
	tank_titan_assault = 24,
	spring = 50,
	summers = 50,
	omnia_lpf = 3,
	phalanx_minion_assault = 5,
	spooc_titan = 12,
	taser_titan = 12,
	autumn = 50
}

NobleHUD.score_multipliers = {
	difficulty = {
		easy = 1,
		normal = 2,
		overkill = 3.5,
		overkill_145 = 4,
		easy_wish = 5.5,
		overkill_290 = 6,
		sm_wish = 6.5
	},
	time_generic = {
		--[mission timer (seconds)] = multiplier
		--if timer < key then score = value
		[1] = {
			threshold = 10 * 60,
			multiplier = 2,
		},
		[2] = {
			threshold = 15 * 60,
			multiplier = 1.5,
		},
		[3] = {
			threshold = 20 * 60,
			multiplier = 1.2
		}
	}
}

NobleHUD._medal_data = {
	first = {
		name = "first",
		multiplier = 2.0,
		sfx = "first_strike",
		show_text = true,
		icon_xy = {1,0}
	},
	headshot = {
		name = "headshot",
		multiplier = 1.25,
		sfx = false,
		show_text = false,
		icon_xy = {1,1}
	},
	assist = {
		name = "assist",
		sfx = false,
		icon_xy = {3,0}
	},
	pummel = {
		name = "pummel",
		sfx = false,
		show_text = false,
		icon_xy = {1,2}
	},
	assassination = { --stealth
		name = "assassin",
		multiplier = 1.25,
		show_text = false,
		sfx = false,
		icon_xy = {1,3}
	},
	beatdown = { --from behind
		name = "beatdown",
		show_text = false,
		sfx = false,
		icon_xy = {1,4}
	},
	close_call = {
		name = "close_call",
		show_text = true,
		sfx = false,
		icon_xy = {1,5}
	},
	revenge = {
		name = "revenge",
		show_text = true,
		sfx = "revenge",
		icon_xy = {1,6}
	},
	avenger = { --not implemented
		name = "avenger",
		show_text = false,
		sfx = false,
		icon_xy = {1,7}
	},
	grave = {
		name = "grave",
		show_text = true,
		sfx = false,
		icon_xy = {1,8}
	},
	extermination = { --not implemented
		name = "extermination",
		show_text = true,
		disabled = true,
		sfx = "extermination",
		icon_xy = {0,9} --this is not the right icon
	},
	sniper = {
		name = "sniper", --headshot only
		sfx = false,
		show_text = false,
		icon_xy = {4,0}
	},
	firebird = {
		name = "firebird",
		sfx = false,
		show_text = true,
		icon_xy = {5,0}
	},
	bulltrue = {
		name = "bulltrue",
		sfx = false,
		show_text = true,
		icon_xy = {5,1}
	},
	headcase = {
		name = "headcase",
		sfx = false,
		show_text = false,
		icon_xy = {5,2}
	},
	reload_this = {
		name = "reload_this",
		sfx = false,
		show_text = true,
		icon_xy = {6,3}
	},
	moa = {
		name = "moa",
		sfx = false,
		show_text = false,
		icon_xy = {7,3}
	},
	pull = {
		name = "pull",
		sfx = false,
		show_text = true,
		icon_xy = {5,3}
	},
	hero = { --not implemented
		name = "hero",
		sfx = false,
		show_text = true,
		icon_xy = {5,4}
	},
	protector = { --not implemented; on res?
		name = "protector",
		sfx = false,
		show_text = true,
		icon_xy = {5,5}
	},
	showstopper = {
		name = "showstopper",
		sfx = false,
		show_text = false,
		icon_xy = {5,6}
	},
	skyjack = { --not implemented
		name = "skyjack",
		sfx = false,
		show_text = false,
		icon_xy = {5,5}
	},
	seek_and_destroy = { --not implemented
		name = "seek",
		sfx = false,
		show_text = false,
		icon_xy = {5,8}
	},
	splatter = {
		name = "splatter",
		multiplier = 1,
		sfx = false,
		show_text = false,
		icon_xy = {6,0}
	},
	wheelman = {
		name = "wheelman",
		show_text = false,
		sfx = false,
		icon_xy = {1,9},
		suffix = ""
	},
	last_man_standing = { --not implemented
		name = "last_man",
		sfx = "last_man_standing",
		show_text = false,
		icon_xy = {7,9}
	},
	betrayal = {
		name = "betrayal",
		sfx = "betrayal", --betrayal, suicide, and betrayed are only in the medals table so that its sound file will be loaded at the same time as all the others
		icon_xy = {-1,-1},
		show_text = false,
		suffix = ""
	},
	suicide = {
		name = "suicide",
		sfx = "suicide",
		icon_xy = {-1,-1},
		show_text = false
	},
	round_over = {
		name = "round_over",
		sfx = "round_over",
		icon_xy = {-1,-1},
		show_text = false
	},
	game_over = {
		name = "game_over",
		sfx = "game_over",
		icon_xy = {-1,-1},
		show_text = false
	},
	betrayed = {
		name = "betrayed",
		sfx = "betrayed",
		icon_xy = {-1,-1},
		show_text = false
	},
	multikill = {
		[2] = {
			name = "multi_2",
			multiplier = 1.2,
			sfx = "multikill_2",
			show_text = true,
			hold_sfx = true,
			icon_xy = {0,0}
		},
		[3] = {
			name = "multi_3",
			multiplier = 1.3,
			sfx = "multikill_3",
			show_text = true,
			hold_sfx = true,
			icon_xy = {0,1}
		},
		[4] = {
			name = "multi_4", --obligatory joke here
			multiplier = 1.4,
			sfx = "multikill_4",
			show_text = true,
			hold_sfx = true,
			icon_xy = {0,2}
		},
		[5] = {
			name = "multi_5",
			multiplier = 1.5,
			sfx = "multikill_5",
			show_text = true,
			hold_sfx = true,
			icon_xy = {0,3}
		},
		[6] = {
			name = "multi_6",
			multiplier = 1.6,
			sfx = "multikill_6",
			show_text = true,
			hold_sfx = true,
			icon_xy = {0,4}
		},
		[7] = {
			name = "multi_7",
			multiplier = 1.7,
			sfx = "multikill_7",
			show_text = true,
			hold_sfx = true,
			icon_xy = {0,5}
		},
		[8] = {
			name = "multi_8",
			multiplier = 1.8,
			sfx = "multikill_8",
			show_text = true,
			hold_sfx = true,
			icon_xy = {0,6}
		},
		[9] = {
			name = "multi_9",
			multiplier = 1.9,
			sfx = "multikill_9",
			show_text = true,
			hold_sfx = true,
			icon_xy = {0,7}
		},
		[10] = {	
			name = "multi_10",
			multiplier = 2.0,
			sfx = "multikill_10",
			show_text = true,
			hold_sfx = true,
			icon_xy = {0,8}
		}
	},
	spree_all = {		
		[10] = {
			name = "spree_all_1",
			sfx = "spree_all_1",
			show_text = true,
			hold_sfx = true,
			multiplier = 1.1,
			icon_xy = {2,0}
		},
		[20] = {
			name = "spree_all_2",
			sfx = "spree_all_2",
			show_text = true,
			hold_sfx = true,
			multiplier = 1.2,
			icon_xy = {2,1}
		},
		[30] = {
			name = "spree_all_3",
			sfx = "spree_all_3",
			show_text = true,
			hold_sfx = true,
			multiplier = 1.25,
			icon_xy = {2,2}
		},
		[40] = {
			name = "spree_all_4",
			sfx = "spree_all_4",
			show_text = true,
			hold_sfx = true,
			multiplier = 1.3,
			icon_xy = {2,3}
		},
		[50] = {
			name = "spree_all_5",
			sfx = "spree_all_5",
			show_text = true,
			hold_sfx = true,
			multiplier = 1.35,
			icon_xy = {2,4}
		},
		[100] = {
			name = "spree_all_6",
			sfx = "spree_all_6",
			show_text = true,
			hold_sfx = true,
			multiplier = 1.4,
			icon_xy = {2,5}
		},
		[500] = {
			name = "spree_all_7",
			sfx = "spree_all_7",
			show_text = true,
			hold_sfx = true,
			multiplier = 1.45,
			icon_xy = {2,6}
		},
		[1000] = {				
			name = "spree_all_8",
			sfx = "spree_all_8",
			show_text = true,
			hold_sfx = true,
			multiplier = 1.5,
			icon_xy = {2,7}
		}
	},
	spree_assist = { --not implemented
		[5] = {	
			name = "spre_assist_1",
			sfx = "spree_assist_1",
			show_text = true,
			hold_sfx = true,
			multiplier = 1.1,
			icon_xy = {3,1}
		},
		[10] = {
			name = "spre_assist_2",
			sfx = "spree_assist_2",
			show_text = true,
			hold_sfx = true,
			multiplier = 1.15,
			icon_xy = {3,2}
		},
		[15] = {
			name = "spre_assist_3",
			sfx = "spree_assist_3",
			show_text = true,
			hold_sfx = true,
			multiplier = 1.2,
			icon_xy = {3,3}
		}
	},
	spree_sword = { --on saw kill
		[5] = {
			name = "spree_sword_1",
			sfx = "spree_sword_1",
			hold_sfx = true,
			show_text = true,
			multiplier = 1.25,
			icon_xy = {3,4}
		},
		[10] = {
			name = "spree_sword_2",
			sfx = "spree_sword_2",
			hold_sfx = true,
			show_text = true,
			multiplier = 1.5,
			icon_xy = {3,5}
		},
		[15] = {
			name = "spree_sword_3",
			sfx = "spree_sword_3",
			hold_sfx = true,
			show_text = true,
			multiplier = 1.75,
			icon_xy = {3,6}
		}
	},
	spree_grenade = {
		[5] = {
			name = "spree_grenade_1",
			sfx = "spree_grenade_1",
			hold_sfx = true,
			icon_xy = {3,7}
		},
		[10] = {
			name = "spree_grenade_2",
			sfx = "spree_grenade_2",
			hold_sfx = true,
			icon_xy = {3,8}
		},
		[15] = {
			name = "spree_grenade_3",
			sfx = "spree_grenade_3",
			hold_sfx = true,
			icon_xy = {3,9}
		}
	},
	spree_sniper = {
		[5] = {
			name = "spree_sniper_1",
			sfx = "spree_sniper_1",
			hold_sfx = true,
			icon_xy = {4,1}
		},
		[10] = {
			name = "spree_sniper_2",
			sfx = "spree_sniper_2",
			hold_sfx = true,
			icon_xy = {4,2}
		},
		[15] = {
			name = "spree_sniper_3",
			sfx = "spree_sniper_3",
			hold_sfx = true,
			icon_xy = {4,3}
		}
	},
	spree_shotgun = {
		[5] = {
			name = "spree_shotgun_1",
			sfx = "spree_shotgun_1",
			hold_sfx = true,
			icon_xy = {4,4}
		},
		[10] = {
			name = "spree_shotgun_2",
			sfx = "spree_shotgun_2",
			hold_sfx = true,
			icon_xy = {4,5}
		},
		[15] = {
			name = "spree_shotgun_3",
			sfx = "spree_shotgun_3",
			hold_sfx = true,
			icon_xy = {4,6}
		}
	},
	spree_splatter = {
		[5] = {
			name = "spree_splatter_1",
			sfx = "spree_splatter_1",
			show_text = true,
			hold_sfx = true,
			icon_xy = {4,7}
		},
		[10] = {
			name = "spree_splatter_2",
			sfx = "spree_splatter_2",
			show_text = true,
			hold_sfx = true,
			icon_xy = {4,8}
		},
		[15] = {
			name = "spree_splatter_3",
			sfx = "spree_splatter_3",
			show_text = true,
			hold_sfx = true,
			icon_xy = {4,9}
		}
	},
	spree_wheelman = {
		[5] = { --couldn't find the icons for these, but i know they exist somewhere
			name = "spree_wheelman_1",
			show_text = true,
			hold_sfx = true,
			sfx = "spree_wheelman_1",
			icon_xy = {1,9}
		},
		[10] = {
			name = "spree_wheelman_2",
			show_text = true,
			hold_sfx = true,
			sfx = "spree_wheelman_2",
			icon_xy = {1,9}
		},
		[15] = {
			name = "spree_wheelman_3",
			show_text = true,
			hold_sfx = true,
			sfx = "spree_wheelman_3",
			icon_xy = {1,9}
		}
	},
	spree_spawn = {
		[5] = {
			name = "spree_spawn_1",
			sfx = "spree_spawn_1",
			hold_sfx = false,
			icon_xy = {6,4}
		},
		[10] = {
			name = "spree_spawn_2",
			sfx = "spree_spawn_2",
			hold_sfx = false,
			icon_xy = {6,5}
		},
		[15] = {
			name = "spree_spawn_3",
			sfx = "spree_spawn_3",
			hold_sfx = false,
			icon_xy = {6,6}
		}
	},
	spree_hammer = {
		[5] = {
			name = "spree_hammer_1",
			sfx = "spree_hammer_1",
			hold_sfx = true,
			icon_xy = {6,7}
		},
		[10] = {
			name = "spree_hammer_2",
			sfx = "spree_hammer_2",
			hold_sfx = true,
			icon_xy = {6,8}
		},
		[15] = {
			name = "spree_hammer_3",
			sfx = "spree_hammer_3",
			hold_sfx = true,
			icon_xy = {6,9}
		}
	}
}

NobleHUD._crosshair_override_data = {
	rpg7 = {single = "rocket", auto = "rocket", burst = "rocket"},
	ray = {single = "rocket", auto = "rocket", burst = "rocket"}
}

NobleHUD._crosshair_textures = { --organized by reach crosshairs
	assault_rifle = { --four circle subquadrants; four oblong aiming ticks
		bloom_func = function(index,bitmap,data)
			local bloom = data.bloom * 1.5
			local crosshair_data = data.crosshair_data and data.crosshair_data.parts[index] or {}
			local distance = (crosshair_data.distance or 10) * (1 + bloom)
			local angle = crosshair_data.angle or crosshair_data.rotation or 60
			local c_x = NobleHUD._crosshair_panel:w()/2
			local c_y = NobleHUD._crosshair_panel:h()/2
			if index == 1 then 
				--main
			else
				bitmap:set_center(c_x + (math.sin(angle) * distance),c_y - (math.cos(angle) * distance))
			end
		end,
		parts = {
			{
				is_center = true,
				texture = "guis/textures/ar_crosshair_1",
				w = 48,
				h = 48
			},
			{
				is_center = true,
				texture = "guis/textures/ar_crosshair_2",
				rotation = 0,
				distance = 10,
				w = 2,
				h = 8
			},
			{
				is_center = true,
				texture = "guis/textures/ar_crosshair_2",
				rotation = 90,
				distance = 10,
				w = 2,
				h = 8
			},
			{
				is_center = true,
				texture = "guis/textures/ar_crosshair_2",
				rotation = 180,
				distance = 10,
				w = 2,
				h = 8
			},
			{
				is_center = true,
				texture = "guis/textures/ar_crosshair_2",
				rotation = 270,
				distance = 10,
				w = 2,
				h = 8
			}
		}
	},
	dmr = { --circle; four circle subquadrants
		bloom_func = function(index,bitmap,data)
			local bloom = data.bloom
			local max_distance = 32
			if index == 1 then 
				bitmap:set_alpha(0.75 - bloom)
			elseif index == 2 then 
				bitmap:set_size(16 + (max_distance * bloom),16 + (max_distance * bloom))
				bitmap:set_rotation(bloom * 90)
			end
			bitmap:set_center(NobleHUD._crosshair_panel:w()/2,NobleHUD._crosshair_panel:h()/2)
		end,
		parts = {
			{
				is_center = true,
				texture = "guis/textures/dmr_crosshair_1",
				w = 32,
				h = 32
			},
			{
				is_center = true,
				texture = "guis/textures/dmr_crosshair_2",
				w = 16,
				h = 16
			}
		}
	},
	pistol = { --similar to dmr
		bloom_func = function(index,bitmap,data)
			local bloom = data.bloom * 2
			local crosshair_data = data.crosshair_data and data.crosshair_data.parts[index] or {}
			local distance = (crosshair_data.distance or 10) * (1 + bloom)
			local angle = crosshair_data.angle or crosshair_data.rotation or 60
			local c_x = NobleHUD._crosshair_panel:w()/2
			local c_y = NobleHUD._crosshair_panel:h()/2
			if index == 1 then 
				--main
			else
				bitmap:set_center(c_x + (math.sin(angle) * distance),c_y - (math.cos(angle) * distance))
			end
		end,
		parts = {
			{
				is_center = true,
				texture = "guis/textures/pis_crosshair_1",
				w = 28,
				h = 28
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 0,
				distance = 8,
				w = 2,
				h = 6
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 90,
				distance = 8,
				w = 2,
				h = 6
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 180,
				distance = 8,
				w = 2,
				h = 6
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 270,
				distance = 8,
				w = 2,
				h = 6
			}
		}
	},
	smg = {
		bloom_func = function(index,bitmap,data) 
		--not sure what to do for the bloom, since the SMG was not in reach, 
		--and other games do not feature reticle bloom.
		--this one's a bit of a placeholder.
		--in fact, i don't even like it that much. it's TOO bloom-y. no bloom for you.

			local bloom = data.bloom 
			local crosshair_data = data.crosshair_data and data.crosshair_data.parts[index] or {}
			local distance = (crosshair_data.distance or 16) * (1 + (bloom * 1.5))
			local angle = crosshair_data.angle or crosshair_data.rotation or 60
			local c_x = NobleHUD._crosshair_panel:w()/2
			local c_y = NobleHUD._crosshair_panel:h()/2
			bitmap:set_size((crosshair_data.w or 1) * (1 + bloom),(crosshair_data.h or 1) * (1 + bloom))
			bitmap:set_center(c_x + (math.sin(angle) * distance),c_y - (math.cos(angle) * distance))
			
		end,
		parts = {
			{
				texture = "guis/textures/smg_crosshair",
				w = 24,
				h = 8,
				distance = 16,
				rotation = 0
			},
			{
				texture = "guis/textures/smg_crosshair",
				w = 24,
				h = 8,
				distance = 16,
				rotation = 90
			},
			{
				texture = "guis/textures/smg_crosshair",
				w = 24,
				h = 8,
				distance = 16,
				rotation = 180
			},
			{
				texture = "guis/textures/smg_crosshair",
				w = 24,
				h = 8,
				distance = 16,
				rotation = 270
			}
		}
	},
	shotgun = { --big circle
		bloom_func = function(index,bitmap,data)
		--[[ by popular demand, shotgun bloom is disabled
			local bloom = data.bloom
			bitmap:set_size(32 + (32 * bloom),32 + (32 * bloom))
			bitmap:set_center(NobleHUD._crosshair_panel:w()/2,NobleHUD._crosshair_panel:h()/2)
		--]]
		end,
		parts = {
			{
				is_center = true,
				texture = "guis/textures/crosshair_circle_64",
				w = 64,
				h = 64
			}
		}
	},
	sniper = { --small dot
		bloom_func = function(index,bitmap,data)
			local bloom = data.bloom
			if index == 1 then 
				
			elseif index == 2 then
				bitmap:set_size(16 + (64 * bloom),16 + (64 * bloom))
				bitmap:set_center(NobleHUD._crosshair_panel:w()/2,NobleHUD._crosshair_panel:h()/2)
			end
		end,
		parts = {
			{
				is_center = true,
				texture = "guis/textures/ability_circle_outline",
				w = 8,
				h = 8
			},
			{
				is_center = true,
				texture = "guis/textures/dmr_crosshair_2",
				w = 16,
				h = 16
			}
		}
	},
	grenade_launcher = { -- circle with distance markers
		special_crosshair = "altimeter", --used for special altitude display for grenade launcher specifically
		parts = {
			{
				is_center = true,
				texture = "guis/textures/grenadelauncher_crosshair_1"
--				w = 20,
--				h = 40
			},
			{
				is_center = true,
				texture = "guis/textures/grenadelauncher_crosshair_2"
--				w = 20,
--				h = 80
			}
		}
	},
	rocket = { --circle with distance markers
		parts = {
			{
				is_center = true,
				texture = "guis/textures/rocket_crosshair",
				w = 48,
				h = 48
			}
		}
	},
	minigun = {
		parts = {
			{
				is_center = true,
				texture = "guis/textures/trt_crosshair",
				w = 48,
				h = 48
			}
		}
	},
	flamethrower = { --starburst ring of oblongs
		parts = {
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 0,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 2 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 3 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 4 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 5 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 6 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 7 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 8 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 9 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 10 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 11 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 12 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 13 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 14 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 15 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 16 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 17 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 18 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 19 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 20 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 21 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 22 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 23 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				rotation = 24 * 360/25,
				distance = 20,
				w = 2,
				h = 8
			}
		}
	},
	target_laser = { --four chevrons, offset by 45*, with pointy bit pointing outward, forming a diamond
		bloom_func = function(index,bitmap,data)
			local bloom = data.bloom
			local crosshair_data = data.crosshair_data and data.crosshair_data.parts[index] or {}
			local distance = (crosshair_data.distance or 10) * (1 + bloom)
			local angle = crosshair_data.angle or crosshair_data.rotation or 60
			local c_x = NobleHUD._crosshair_panel:w()/2
			local c_y = NobleHUD._crosshair_panel:h()/2
			bitmap:set_center(c_x + (math.sin(angle) * distance),c_y - (math.cos(angle) * distance))
		end,
		parts = {
			{
				texture = "guis/textures/targeting_crosshair",
				w = 16,
				h = 12,
				distance = 12,
				rotation = 0
			},
			{
				texture = "guis/textures/targeting_crosshair",
				w = 16,
				h = 12,
				distance = 12,
				rotation = 90
			},
			{
				texture = "guis/textures/targeting_crosshair",
				w = 16,
				h = 12,
				distance = 12,
				rotation = 180
			},
			{
				texture = "guis/textures/targeting_crosshair",
				w = 16,
				h = 12,
				distance = 12,
				rotation = 270
			}
		}
	},
	car = { --chevron
		parts = {
			{
				texture = "guis/textures/car_crosshair",
				w = 24,
				h = 8
			}
		}
	},
	plasma_pistol = { --tri arrow
		parts = {
			{
				texture = "guis/textures/plasma_crosshair_1",
				w = 6,
				h = 12,
				distance = 16,
				rotation = 0
			},
			{
				texture = "guis/textures/plasma_crosshair_1",
				w = 6,
				h = 12,
				distance = 16,
				rotation = 125 --120 for perfect third
			},
			{
				texture = "guis/textures/plasma_crosshair_1",
				w = 6,
				h = 12,
				distance = 16,
				rotation = 235 --240 for perfect third
			}
		}
	},
	plasma_rifle = { --quad arrow
		parts = {
			{
				texture = "guis/textures/plasma_crosshair_1",
				w = 6,
				h = 16,
				distance = 16,
				rotation = 45 + 180
			},
			{
				texture = "guis/textures/plasma_crosshair_1",
				w = 6,
				h = 16,
				distance = 16,
				rotation = 135 + 180
			},
			{
				texture = "guis/textures/plasma_crosshair_1",
				w = 6,
				h = 16,
				distance = 16,
				rotation = 225 + 180
			},
			{
				texture = "guis/textures/plasma_crosshair_1",
				w = 6,
				h = 16,
				distance = 16,
				rotation = 315 + 180
			}
		}
	},
	plasma_repeater = {
		bloom_func = function(index,bitmap,data)
			local bloom = data.bloom
			local crosshair_data = data.crosshair_data and data.crosshair_data.parts[index] or {}
			local distance = (crosshair_data.distance or 10) * (1 + bloom)
			local angle = crosshair_data.angle or crosshair_data.rotation or 60
			local c_x = NobleHUD._crosshair_panel:w()/2
			local c_y = NobleHUD._crosshair_panel:h()/2
			if index == 1 then 
				--main
			else
				bitmap:set_center(c_x + (math.sin(angle) * distance),c_y - (math.cos(angle) * distance))
			end
		end,
		parts = {
			{
				is_center = true,
				alpha = 0.6,
				texture = "guis/textures/plasma_crosshair_2",
				w = 36,
				h = 36
			},
			{
				texture = "guis/textures/plasma_crosshair_1",
				w = 4,
				h = 12,
				distance = 12,
				rotation = 45
			},
			{
				texture = "guis/textures/plasma_crosshair_1",
				w = 4,
				h = 12,
				distance = 12,
				rotation = 135
			},
			{
				texture = "guis/textures/plasma_crosshair_1",
				w = 4,
				h = 12,
				distance = 12,
				rotation = 225
			},
			{
				texture = "guis/textures/plasma_crosshair_1",
				w = 4,
				h = 12,
				distance = 12,
				rotation = 315
			}
		}
	},
	needler = {
		parts = {
			{
				texture = "guis/textures/needler_crosshair_1",
				x = -12,
				rotation = 0,
				w = 8,
				h = 16
			},
			{
				texture = "guis/textures/needler_crosshair_2",
				distance = 8,
				rotation = 90,
				w = 8,
				h = 4
			},
			{
				texture = "guis/textures/needler_crosshair_1",
				x = 12,
				rotation = 180,
				w = 8,
				h = 16
			},
			{
				texture = "guis/textures/needler_crosshair_2",
				distance = 8,
				rotation = 270,
				w = 8,
				h = 4
			}
		}
	},
	needle_rifle = {
		bloom_func = function(index,bitmap,data)
			local crosshair_data = data.crosshair_data and data.crosshair_data.parts[index] or {}
			local angle = crosshair_data.angle or crosshair_data.rotation or 45
			local c_x = NobleHUD._crosshair_panel:w()/2
			local c_y = NobleHUD._crosshair_panel:h()/2
			if index <= 4 then 
				local bloom = data.bloom * 2
				--bitmap:set_center(NobleHUD._crosshair_panel:w()/2,NobleHUD._crosshair_panel:h()/2)
				local distance = (crosshair_data.distance or 10) * (1 + bloom)
				bitmap:set_size((crosshair_data.w or 6) * (1 + bloom),(crosshair_data.h or 3) * (1 + bloom))
				bitmap:set_center(c_x + (math.sin(angle) * distance),c_y - (math.cos(angle) * distance))
			else
			end
		end,
		parts = {
			{ --center
				texture = "guis/textures/nrif_crosshair_2",
				w = 2,
				h = 1,
				distance = 4,
				rotation = 45
			},
			{ --center
				texture = "guis/textures/nrif_crosshair_2",
				w = 2,
				h = 1,
				distance = 4,
				rotation = 135
			},
			{ --center
				texture = "guis/textures/nrif_crosshair_2",
				w = 2,
				h = 1,
				distance = 4,
				rotation = 225
			},
			{ --center
				texture = "guis/textures/nrif_crosshair_2",
				w = 2,
				h = 1,
				distance = 4,
				rotation = 315
			},
			{
				texture = "guis/textures/nrif_crosshair_2",
				w = 12,
				h = 6,
				distance = 8,
				rotation = 0
			},
			{
				texture = "guis/textures/nrif_crosshair_2",
				w = 12,
				h = 6,
				distance = 8,
				rotation = 90
			},
			{
				texture = "guis/textures/nrif_crosshair_2",
				w = 12,
				h = 6,
				distance = 8,
				rotation = 180
			},
			{
				texture = "guis/textures/nrif_crosshair_2",
				w = 12,
				h = 6,
				distance = 8,
				rotation = 270
			}
		}
	},
	concussion_rifle = { --todo
		parts = {
			{
				texture = "guis/textures/concussion_crosshair",
				w = 32,
				h = 16,
				x = -18,
				y = -8
			},
			{
				texture = "guis/textures/concussion_crosshair",
				w = -32,
				h = 16,
				x = 18,
				y = -8
			},
			{
				texture = "guis/textures/concussion_crosshair",
				w = -32,
				h = -16,
				x = 18,
				y = 8
			},
			{
				texture = "guis/textures/concussion_crosshair",
				w = 32,
				h = -16,
				x = -18,
				y = 8
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				y = 24,
				w = 4,
				h = 16,
				rotation = 90,
				alpha = 0.6
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				y = 32,
				w = 4,
				h = 12,
				rotation = 90,
				alpha = 0.4
			},
			{
				texture = "guis/textures/ar_crosshair_2",
				y = 40,
				w = 4,
				h = 8,
				rotation = 90,
				alpha = 0.2
			}
		}
	},
	sword = { --crescent with arrow; used for melee
		parts = {
			{
				texture = "guis/textures/sword_crosshair",
				w = 48,
				h = 48
			}
		}
	},
	gravity_hammer = {
		parts = {
			{
				texture = "guis/textures/hammer_crosshair",
				w = 64,
				h = 64
			}
		}
	},
	plasma_launcher = { --four arrows
		bloom_func = function(index,bitmap,data)
			local bloom = data.bloom
			local crosshair_data = data.crosshair_data and data.crosshair_data.parts[index] or {}
			local distance = (crosshair_data.distance or 12) * (1 + bloom)
			local angle = crosshair_data.angle or crosshair_data.rotation or 0
			local c_x = NobleHUD._crosshair_panel:w()/2
			local c_y = NobleHUD._crosshair_panel:h()/2
			if index >= 5 then 
				bitmap:set_center(c_x + (math.sin(angle) * distance),c_y - (math.cos(angle) * distance))
			end
		end,
		parts = {
			{
				texture = "guis/textures/plasma_crosshair_1",
				w = 4,
				h = 8,
				distance = 16,
				rotation = 0
			},
			{
				texture = "guis/textures/plasma_crosshair_1",
				w = 4,
				h = 8,
				distance = 16,
				rotation = 180
			},
			{
				texture = "guis/textures/plasma_crosshair_1",
				w = 4,
				h = 8,
				distance = 16,
				rotation = 270
			},
			{
				texture = "guis/textures/plasma_crosshair_1",
				w = 4,
				h = 8,
				distance = 16,
				rotation = 90
			},
			{
				texture = "guis/textures/plasma_crosshair_1",
				w = 2,
				h = 4,
				alpha = 0.33,
				distance = 12,
				rotation = 45
			},
			{
				texture = "guis/textures/plasma_crosshair_1",
				w = 2,
				h = 4,
				alpha = 0.33,
				distance = 12,
				rotation = 135
			},
			{
				texture = "guis/textures/plasma_crosshair_1",
				w = 2,
				h = 4,
				alpha = 0.33,
				distance = 12,
				rotation = 225
			},
			{
				texture = "guis/textures/plasma_crosshair_1",
				w = 2,
				h = 4,
				alpha = 0.33,
				distance = 12,
				rotation = 315
			}
		}
	},
	focus_rifle = { --todo
		bloom_func = function(index,bitmap,data)
			local bloom = data.bloom * 2
			local crosshair_data = data.crosshair_data and data.crosshair_data.parts[index] or {}
			local distance = (crosshair_data.distance or 8) * (1 + bloom)
			local angle = crosshair_data.angle or crosshair_data.rotation or 0
			local c_x = NobleHUD._crosshair_panel:w()/2
			local c_y = NobleHUD._crosshair_panel:h()/2
			bitmap:set_center(c_x + (math.sin(angle) * distance),c_y - (math.cos(angle) * distance))
		end,
		parts = {
			{
				texture = "guis/textures/nrif_crosshair_2",
				w = 12,
				h = 6,
				distance = 6,
				rotation = 180
			},
			{
				texture = "guis/textures/nrif_crosshair_2",
				w = 12,
				h = 6,
				distance = 6,
				rotation = 60
			},
			{
				texture = "guis/textures/nrif_crosshair_2",
				w = 12,
				h = 6,
				distance = 6,
				rotation = 300
			}
		}
	},
	spiker = { --todo
		bloom_func = function(index,bitmap,data)
			local bloom = data.bloom
			local crosshair_data = data.crosshair_data and data.crosshair_data.parts[index] or {}
			local distance = (crosshair_data.distance or 12) * (1 + bloom)
			local angle = crosshair_data.angle or crosshair_data.rotation or 0
			local c_x = NobleHUD._crosshair_panel:w()/2
			local c_y = NobleHUD._crosshair_panel:h()/2
			if index >= 5 then 
				bitmap:set_center(c_x + (math.sin(angle) * distance),c_y - (math.cos(angle) * distance))
			end
		end,
		parts = {
			{
				texture = "guis/textures/spiker_crosshair_1",
				x = -14,
				y = -14,
				rotation = 0,
				w = 16,
				h = 16
			},
			{
				texture = "guis/textures/spiker_crosshair_2",
				x = 14,
				y = -14,
				rotation = 0,
				w = 16,
				h = 16
			},
			{
				texture = "guis/textures/spiker_crosshair_1",
				x = 14,
				y = 14,
				rotation = 180,
				w = 16,
				h = 16
			},
			{
				texture = "guis/textures/spiker_crosshair_2",
				x = -14,
				y = 14,
				rotation = 180,
				w = 16,
				h = 16
			},
			{
				texture = "guis/textures/ar_crosshair_2", --top 
				distance = 20,
				rotation = 0,
				h = 10,
				w = 2
			},
			{
				texture = "guis/textures/ar_crosshair_2", --right
				distance = 22,
				rotation = 90,
				h = 14,
				w = 2
			},
			{
				texture = "guis/textures/ar_crosshair_2", --bottom
				distance = 20,
				rotation = 180,
				h = 10,
				w = 2
			},
			{
				texture = "guis/textures/ar_crosshair_2", --left
				distance = 22,
				rotation = 270,
				h = 14,
				w = 2
			}
		}
	},
	fuel_rod = { --todo
		parts = {
			{ -- 1 big, bottom
				texture = "guis/textures/plasma_crosshair_1",
				w = 6,
				h = 16,
				distance = 20,
				rotation = 180
			},
			{ -- 2
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 24,
				rotation = 170
			},
			{ -- 3
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 24,
				rotation = 160
			},
			{ -- 4
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 24,
				rotation = 150
			},
			{ -- 5
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 24,
				rotation = 140
			},
			{ -- 6
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 24,
				rotation = 130
			},
			{ -- 7
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 24,
				rotation = 120
			},
			{ -- 8
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 24,
				rotation = 110
			},
			{ -- 9
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 24,
				rotation = 100
			},
			{ -- 10 big
				texture = "guis/textures/plasma_crosshair_1",
				w = 6,
				h = 16,
				distance = 20,
				rotation = 90
			},
			{ -- 11 big; left
				texture = "guis/textures/plasma_crosshair_1",
				w = 6,
				h = 16,
				distance = 20,
				rotation = 270
			},
			{ -- 12
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 24,
				rotation = 280
			},
			{ -- 13
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 24,
				rotation = 290
			},
			{ -- 14
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 24,
				rotation = 300
			},
			{ -- 15
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 24,
				rotation = 310
			},
			{ -- 16
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 24,
				rotation = 320
			},
			{ -- 17
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 24,
				rotation = 330
			},
			{ -- 18
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 24,
				rotation = 340
			},
			{ -- 19
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 24,
				rotation = 350
			},
			{ -- 20 big
				texture = "guis/textures/plasma_crosshair_1",
				w = 6,
				h = 16,
				distance = 20,
				rotation = 0
			}
		}
	},
	plasma_cannon = { --todo
		parts = {
			{ -- 1 top
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 16,
				rotation = 0,
				alpha = 0.5
			},
			{ -- 2
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 16,
				rotation = 22.5,
				alpha = 0.5
			},
			{ -- 3 big
				texture = "guis/textures/plasma_crosshair_1",
				w = 6,
				h = 12,
				distance = 20,
				rotation = 45
			},
			{ -- 4
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 16,
				rotation = 67.5,
				alpha = 0.5
			},
			{ -- 5 right
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 16,
				rotation = 90,
				alpha = 0.5
			},
			{ -- 6
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 16,
				rotation = 112.5,
				alpha = 0.5
			},
			{ -- 7 big
				texture = "guis/textures/plasma_crosshair_1",
				w = 6,
				h = 12,
				distance = 20,
				rotation = 135
			},
			{ -- 8
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 16,
				rotation = 157.5,
				alpha = 0.5
			},
			{ -- 9 bottom
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 16,
				rotation = 180,
				alpha = 0.5
			},
			{ -- 10
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 16,
				rotation = 202.5,
				alpha = 0.5
			},
			{ -- 11 big
				texture = "guis/textures/plasma_crosshair_1",
				w = 6,
				h = 12,
				distance = 20,
				rotation = 225
			},
			{ -- 12
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 16,
				rotation = 247.5,
				alpha = 0.5
			},
			{ -- 13 left
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 16,
				rotation = 270,
				alpha = 0.5
			},
			{ -- 14
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 16,
				rotation = 292.5,
				alpha = 0.5
			},
			{ -- 15 big
				texture = "guis/textures/plasma_crosshair_1",
				w = 6,
				h = 12,
				distance = 20,
				rotation = 315
			},
			{ -- 16
				texture = "guis/textures/plasma_crosshair_1",
				w = 3,
				h = 6,
				distance = 16,
				rotation = 337.5,
				alpha = 0.5
			}
		}
	}
}

NobleHUD._bullet_textures = {
	shotgun = {
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_sg",
		texture_rect = {
			0,0,8,16
		},
		icon_w = 2,
		icon_h = 8
	},
	assault_rifle = {
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_ar",
		texture_rect_DISABLED = {
			1,2,3,4
		},
		icon_w = 2,
		icon_h = 8
	},
	pistol = {
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_pis",
		texture_rect_DISABLED = {
			1,2,3,4
		},
		icon_w = 2,
		icon_h = 8
	},
	lmg = {
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_ar",
		texture_rect_DISABLED = {
			1,2,3,4
		},
		icon_w = 2,
		icon_h = 8
	},
	snp = {
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_ar",
		texture_rect_DISABLED = {
			1,2,3,4
		},
		icon_w = 2,
		icon_h = 8
	},
	smg = {
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_smg",
		texture_rect_DISABLED = {
			1,2,3,4
		},
		icon_w = 2,
		icon_h = 8
	},
	flamethrower = {
		use_bar = true,
		texture = "guis/textures/test_blur_df" or "guis/textures/ammo_flame",
		texture_rect_DISABLED = {
			1,2,3,4
		},
		icon_w = 100,
		icon_h = 8
	},
	saw = {
		use_radial = true,
		texture = "guis/textures/ability_circle_fill" or "guis/textures/ammo_saw",
		icon_w = 48,
		icon_h = 48
	},
	minigun = {
		use_bar = true,
		texture = "guis/textures/test_blur_df" or "guis/textures/bullet_tick" or "guis/textures/ammo_minigun",
		texture_rect_DISABLED = {
			1,2,3,4
		},
		icon_w = 100,
		icon_h = 8
	},
	crossbow = {
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_xbow",
		texture_rect_DISABLED = {
			1,2,3,4
		},
		icon_w = 2,
		icon_h = 8
	},
	bow = {
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_bow",
		texture_rect_DISABLED = {
			1,2,3,4
		},
		icon_w = 2,
		icon_h = 8
	},
	grenade_launcher = {
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_gl",
		texture_rect_DISABLED = {
			1,2,3,4
		},
		icon_w = 2,
		icon_h = 8
	},
	rocket_launcher = { --not technically a separate weapon category
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_rpg",
		texture_rect_DISABLED = {
			1,2,3,4
		},
		icon_w = 2,
		icon_h = 8
	},
	other = {
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_generic",
		texture_rect = {
			0,0,8,16
		},
		icon_w = 2,
		icon_h = 8
	}		
}

NobleHUD._reticle_types_by_index = {
	[1] = false, --default
	[2] = "assault_rifle",
	[3] = "dmr",
	[4] = "pistol",
	[5] = "smg",
	[6] = "shotgun",
	[7] = "sniper",
	[8] = "grenade_launcher",
	[9] = "rocket",
	[10] = "minigun",
	[11] = "flamethrower",
	[12] = "target_laser",
	[13] = "car",
	[14] = "plasma_pistol",
	[15] = "plasma_rifle",
	[16] = "plasma_repeater",
	[17] = "needler",
	[18] = "needle_rifle",
	[19] = "concussion_rifle",
	[20] = "sword",
	[21] = "gravity_hammer",
	[22] = "plasma_launcher",
	[23] = "focus_rifle",
	[24] = "spiker",
	[25] = "fuel_rod",
	[26] = "plasma_cannon"
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
		if #a > 0 then 
			return tbl[a[math.random(#a)]]
		end
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
	local a1 = one.alpha
	
--color 2
	local r2 = two.red
	local g2 = two.green
	local b2 = two.blue
	local a2 = two.alpha

--delta
	local r3 = r2 - r1
	local g3 = g2 - g1
	local b3 = b2 - b1
	local a3 = a2 - a1
	
	return Color(r1 + (r3 * percent),g1 + (g3 * percent), b1 + (b3 * percent)):with_alpha(a1 + (a3 * percent))
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
--i had to write this because get_specialization_icon_data() always picks the top tier,
--which is not always an appropriately representative icon of its effect. booooo
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

function NobleHUD:IsSafeMode()
	return self.settings.safe_mode
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


NobleHUD._current_helper_pattern = "dot"
NobleHUD._helper_patterns_even = { --should try to use non-even patterns
	dot = {
		[1] = {
			3,4
		},
		[2] = {
			2,3,4,5
		},
		[3] = {
			1,2,5,6
		},
		[4] = {
			0,1,3,4,6,7
		},
		[5] = {
			0,1,3,4,6,7
		},
		[6] = {
			1,2,5,6
		},
		[7] = {
			2,3,4,5
		},
		[8] = {
			3,4
		}
	},
	lotus = { --10x10 even
		[1] = {
			2,5
		},
		[2] = {
			2,3,4,5
		},
		[3] = {
			0,1,3,4,6,7
		},
		[4] = {
			1,2,3,4,5,6
		},
		[5] = {
			1,2,3,4,5,6
		},
		[6] = {
			0,1,3,4,6,7
		},
		[7] = {
			2,3,4,5
		},
		[8] = {
			2,5
		}
	},
	x = { --even 8x8
		[2] = {
			2,5
		},
		[3] = {
			1,3,4,6
		},
		[4] = {
			2,5
		},
		[5] = {
			2,5
		},
		[6] = {
			1,3,4,6
		},
		[7] = {
			2,5
		}
	}
}

NobleHUD._helper_patterns = {
	superintendent = {
	
	}
}

NobleHUD._helper_sequences = {
	{
		[2] = {
			3,6
		},
		[3] = {
			3,4,5,6
		},
		[4] = {
			1,2,4,5,7,8
		},
		[5] = {
			2,3,4,5,6,7
		},
		[6] = {
			2,3,4,5,6,7
		},
		[7] = {
			1,2,4,5,7,8
		},
		[8] = {
			3,4,5,6
		},
		[9] = {
			3,6
		}
		
	},
	{
		[1] = {
			3,4,5,6
		},
		[2] = {
			3,6
		},
		[3] = {
			3,4,5,6
		},
		[4] = {
			0,1,2,3,4,5,6,7,8,9
		},
		[5] = {
			0,2,3,4,5,6,7,9
		},
		[6] = {
			0,2,3,4,5,6,7,9
		},
		[7] = {
			0,1,2,3,4,5,6,7,8,9
		},
		[8] = {
			3,4,5,6
		},
		[9] = {
			3,6
		},
		[10] = {
			3,4,5,6
		}
	},
	{
		[1] = {
			3,4,5,6
		},
		[2] = {
			1,3,4,5,6,8
		},
		[3] = {
			3,4,5,6
		},
		[4] = {
			0,1,2,3,4,5,6,7,8,9
		},
		[5] = {
			0,1,2,3,6,7,8,9
		},
		[6] = {
			0,1,2,3,6,7,8,9
		},
		[7] = {
			0,1,2,3,4,5,6,7,8,9
		},
		[8] = {
			3,4,5,6
		},
		[9] = {
			1,3,4,5,6,8
		},
		[10] = {
			3,4,5,6	
		}
	},
	{
		[1] = {
			2,3,4,5,6,7
		},
		[2] = {
			1,3,4,5,6,8
		},
		[3] = {
			0,2,4,5,7,9
		},
		[4] = {
			0,1,3,4,5,6,8,9
		},
		[5] = {
			0,1,2,3,6,7,8,9
		},
		[6] = {
			0,1,2,3,6,7,8,9
		},
		[7] = {
			0,1,3,4,5,6,8,9
		},
		[8] = {
			0,2,4,5,7,9
		},
		[9] = {
			1,3,4,5,6,8
		},
		[10] = {
			2,3,4,5,6,7
		}
	},
	{
		[1] = {
			2,4,5,7
		},
		[2] = {
			1,4,5,8
		},
		[3] = {
			0,2,7,9
		},
		[4] = {
			3,4,5,6
		},
		[5] = {
			0,1,3,6,8,9
		},
		[6] = {
			0,1,3,6,8,9
		},
		[7] = {
			3,4,5,6
		},
		[8] = {
			0,2,7,9
		},
		[9] = {
			1,4,5,8
		},
		[10] = {
			2,4,5,7
		}
	},
	{
		[5] = {4,5},
		[6] = {4,5}
	},
	{
		[1] = {
			3,4,5,6
		},
		[2] = {
			3,6
		},
		[3] = {
			3,4,5,6
		},
		[4] = {
			0,1,2,3,4,5,6,7,8,9
		},
		[5] = {
			0,2,3,4,5,6,7,9
		},
		[6] = {
			0,2,3,4,5,6,7,9
		},
		[7] = {
			0,1,2,3,4,5,6,7,8,9
		},
		[8] = {
			3,4,5,6
		},
		[9] = {
			3,6
		},
		[10] = {
			3,4,5,6
		}
	}
}

NobleHUD:LoadSettings()