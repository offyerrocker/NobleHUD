--[[ 



***** TODO: *****
	
		
	Notes:
		
		fadeout bluespider and athena without disassociating it from unit
		slider setting for popup_fadeout_time
		menu item for weapon opacity
		check for mag count above max --> bar
		weapon overheat meter? 


	&&& HIGH PRIORITY: &&&
			
		* HUD SHOULD BE CREATED OUTSIDE OF HUDMANAGER
			* Objectives
	
		%% BUGS:
			- abnormal gametypes like Safe House Raid, holdout/skirmish (unconfirmed), and crimespree have different objective styles
			
			- hide radar when in camera
			- Rocket reticle will not proc???
			- CROSSHAIR DETECTION SHOULD BE FROM PLAYER, NOT CAMERA
			- Swapping while aiming at an enemy or aiming at invalid ray (eg. empty/too far distance on ray such as on Lab Rats) keeps the crosshair color
			- ADS should maintain mostly still reticle, unusable otherwise

		%% FEATURES: %%
			
			* Assault Banner
				- Hostages panel
			* Chat panel
			* Health variants (stoic health, ex-pres stored health, absorb overshields)
			
			* Teammates panel
				-circleplus/character name
					- center to subpanel
				-player name
					* player names are often too long. :(
				- equipment
				- health/shields?
					- Halo 1 passenger/gunner ui?
					- PDTH style outline/fill system?
					- Blink on shields depleted?
				- ammo?
				- downs?
			* Tab menu
			* Mod options
				* Placement and Scaling
				* Keybinds for Safety etc

			
	&& LOW PRIORITY FEATURES: &&
		* Organize color data
			- Ability circle needs a baked-blue asset
		* Queue objective activities rather than stopping current
		* Tab should refresh view_timer or call remind objective
		* Weapon swap interrupts sprees? at least, it should for weapon-specific ones
		* Auntie dot
			* Subtitles: Auntie dot voice lines with associated queues (requires vo assets/updated asset dump)
			* background non-lit grid should probably be invisible, or flicker to invisible after flickering off
			* should be layered over as the loading screen, and stretched to fit screen
			* during loading screen, should be under text but above blackscreen;
			* in-game, should be entirely below hud, layerwise
		* Joker panel
		* Animate function for text that randomly hides individual characters (similar to auntie dot's fadeout function)
			* Given list of integers representing non-space character positions, foreach hide animate(text:set_color_range(pos,pos,color:with_alpha(a))) after random(n) delay
			* Mainly for use in Objectives panel
		* Better player waypoints
		* Weapontype-specific bloom decay
		* Blinky "No ammo" alert
		* Voice command radial
		* Mod Options:
			* Crosshair selection
				* By weapon type
				* Static selection
			* Grenade/deployable area swap
		* Suspicion panel?
		* Crosshair stuff
			* add crosshair data for everything lol
			* melee crosshair
			* based on weapon type
			* manually selectable 
			* customizable based on type
			* customizable alpha (master)
			
		* Killfeed/JoyScore
			* Record medals with score
			* Show weapon icon (PLAYERNAME [WEAPON_ICON] ENEMYNAME) ?
			* Implement campaign-similar scoring system; medals should award score
		* More Medals:
			* Seek and Destroy (for bosses?)
			* EMP Blast for stunned enemies?
			* Hero or assist for reviving teammates?
			* Protector? hard to implement but not impossible
			* Yoink?
			* Headcase somehow?
			* Reloading?

		&& DECISIONS &&
			* Should graze kills give sniper medals? currently, they don't
			
	&& BEAUTIFY EXISTING: &&
		* Carry indicator is kind of hard to see
		* Grenade/Ability
			* Ability circle reduces with active ability time
			* Ability activation animation
			* Ability circle color should be colored blue by default
			* Counter is unreadable- needs shadow or better placement
				* shadow is better, to show during flashbangs
		* Visual ammo counter is out of control for large-mag weapons
			* Mag count is kind of hard to see, might want to have an option to make the big number the mag
			* Above x bullets should just be a bar tbh
			* Saw should use a radial meter
			* Realign bullet tick alignments
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
		* Downs counter
			* Find a better representation of downs
			* Actually count downs
		* Radar
			* Radar ghost effect
			* Motion-based tracking
			* Radar pulse when update?
			* Different motion tracker icon or color for Team AI versus players
			* Lower blip should be darker/lower opacity, instead of halo 3 style
				* higher/lower radar blips should use darker colors (eg color * 0.5) rather than reducing alpha
			* Make far blip more like reach's (size thing)


		
	&& CREATE ASSETS: &&

		-- Firemode indicator
		-- Crosshair textures
			- REMAKE ROCKET RETICLE
			- Minigun
			- Plasma Rifle/Repeater
				* Circle
				* Four arrows (single texture)
			- Plasma Pistol
			- Chevron
			- Needler
			- Rocket
			- Spiker
			- Flamethrower
			- Plasma Launcher
			- Beam Launcher
			- Target Designator

		-- Ammo type tick variant textures
			- DMR
			- AR
			- Pistol
			- Rocket
			- SMG
			- Car
			- Saw
			- Shotgun (rename)

		-- HUD waypoints
			- dotchevron (EG o> KAT) 
			
--grenade/ability outline (baked blue color for vertex radial render template)
		-- Replacement tube for auntie dot
--score banner
--score banner small
--score icon (play icon)

- bloom funcs should all have a reference to their own crosshair tweakdata
- bloom funcs should also have reference to their own weapon tweakdata
- crosshair data blacklist should be replaced by a manual override list for weapon ids

CODE:

--settings
--score panel
--joyscore (modified)
	* update to recent joyscore points list
	* mutator multipliers

--ability/deployable/grenade
	* animate grenade movement
	* animate grenade cooldown
	* animate grenade duration
	* grenade selection indicator
	* grenade vs deployable layout
	* secondary grenade panel

--reticle bloom
	* standardize reticle subparts
--weapon
	* weapon name popup (fadeout anim)
	* weapon killcount
* cached crosshair target (on change, apply color differences)
-- check dead/brain every frame

--]]

_G.NobleHUD = {}

NobleHUD.settings = {
	debug = false,
	crosshair_enabled = true,
	crosshair_bloom = true,
	crosshair_shake = true,
	crosshair_alpha = 0.5,
	crosshair_dynamic_color = true,
	crosshair_stability = 100,
	crosshair_static_color = {1,0,0},
	radar_enabled = true,
	medals_enabled = true,
	popup_style = 1,
	popups_enabled = true,
	popup_font_size = 16,
	radar_distance = 25,
	popup_duration = 3,
	show_all_medals = false,
	announcer_enabled = true,
	stamina_enabled = true,
	interact_style = 1,
	weapon_ammo_tick_full_alpha = 0.8,
	weapon_ammo_tick_empty_alpha = 0.15
}

NobleHUD._bgboxes = {}
NobleHUD.color_data = {
	hud_vitalsoutline_blue = Color(121/255,197/255,255/255), --vitals outline color
	hud_vitalsoutline_yellow = Color(255/255,211/255,129/255),
	hud_vitalsoutline_red = Color(135/255,0/255,0/255),
	hud_vitalsfill_blue = Color(58/255,138/255,199/255), --vitals fill color
	hud_vitalsfill_yellow = Color(255/255,195/255,74/255),
	hud_vitalsfill_red = Color(212/255,0/255,0/255),
	hud_vitalsglow_red = Color(255/255,115/255,115/255), --empty pink flash
	hud_weapon_color = Color(113/255,202/255,239/255), --"official" blue hud color
	hud_text_blue = Color(100/255,178/255,255/255),
	hud_text_flash = Color(254/255,239/255,239/255),
	hud_killfeed_lightyellow = Color(253/255,255/255,217/255),
	hud_killfeed_yellow = Color(255/255,231/255,0),
	hud_helper_bluefill = Color(218/255,238/255,255/255),
	hud_helper_blueglow = Color(0,0.3,0.9),
	hud_lightblue = Color("a1f0ff"), --powder blue; unused
	hud_bluefill = Color("66cfff"), --sky blue; unused
	hud_blueoutline = Color("3173bb"),
	hud_hint_orange = Color("FFB432"),
	hud_hint_lightorange = Color("FFE5B8"),
--	hud_blueoutline = Color(168/255,203/255,255/255), --shield/hp outline color; unused
	hud_text = Color.white,
	hud_compass = Color("2EA1FF")
}

NobleHUD.special_chars = {
	skull = ""
}

NobleHUD._mod_path = ModPath
NobleHUD._options_path = ModPath .. "menu/"
NobleHUD._settings_path = SavePath .. "noblehud_settings.txt"
NobleHUD._localization_path = ModPath .. "localization/"
NobleHUD._cartographer_path = ModPath .. "cartographer/"
NobleHUD._announcer_path = ModPath .. "assets/snd/announcer/"

NobleHUD._cartographer_data = {}

NobleHUD._presenter_title_params = {
	duration = 0.25,
	lifetime = 6,
	font_size = 16,
	color_1 = NobleHUD.color_data.hud_killfeed_yellow,
	color_2 = NobleHUD.color_data.hud_killfeed_lightyellow
}
NobleHUD._presenter_desc_params = {
	duration = 0.25,
	lifetime = 7,
	font_size = 16,
	color_1 = NobleHUD.color_data.hud_killfeed_yellow,
	color_2 = NobleHUD.color_data.hud_killfeed_lightyellow
}
NobleHUD._hint_params = {
	duration = 0.25,
	lifetime = 5,
	font_size = 16,
	color_1 = NobleHUD.color_data.hud_hint_orange,
	color_2 = NobleHUD.color_data.hud_hint_lightorange
}

NobleHUD._efficient_audio_mode = false --voice lines, if procced simultaneously, will overlap if true, rather than queue
NobleHUD._HUD_HEALTH_TICKS = 8
NobleHUD._RADAR_REFRESH_INTERVAL = 0.5
NobleHUD._radar_refresh_t = 0
NobleHUD._cache = {
	killer = {},
	score_timer_mult = 1,
	score_popups_count = 0,
	score_popups = {},
	score_session = 0,
	game_state = "",
	current_objective = "",
	objective_progress = nil,
	objective_total = nil,
	newest_medal = false,
	newest_killfeed = false,
	last_cartographer_t = 0,
	sounds = {},
	announcer_queue = {},
	kills = {
		multipliers = {
			spree_all = 1,
			multikill = 1,
			spree_assist = 1,
			spree_sword = 1
		},
		close_call = false,
		last_kill_t = 0,
		spree_count = 0,
		multi_count = 0,
		melee = 0,
		sniper = 0,
		shotgun = 0,
		saw = 0,
		grenade = 0
	},
	crosshair_enemy = false -- enemy currently in sights; for dynamic crosshair color efficiency (unused)
}

NobleHUD._delayed_callbacks = {}

NobleHUD._bullet_textures = {
	shotgun = {
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_sg",
		texture_rect = {
			0,0,8,16
		},
		icon_w = 4,
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
		texture = "guis/textures/ammo_flame",
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
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_minigun",
		texture_rect_DISABLED = {
			1,2,3,4
		},
		icon_w = 100,
		icon_h = 8
	},
	xbow = {
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

--NobleHUD._pd_to_hr_weapontypes = {}

NobleHUD.weapon_data = {
	bloom = 0,
	{
		single = {},
		auto = {},
		underbarrel = {}
	},
	{
		single = {},
		auto = {},
		underbarrel = {}
	}
}

NobleHUD._crosshair_override_data = {
--	m308 = {"dmr"},
	rpg7 = {"rocket"},
	ray = {"rocket"}
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
--				bitmap:set_x(c_x + (math.sin(angle) * distance))
--				bitmap:set_y(c_y - (math.cos(angle) * distance))
			end
			--[[
			local w = crosshair_data.w or 4
			local h = crosshair_data.h or 16
			if index == 2 then 
				bitmap:set_y(c_y - (distance * (1 + bloom)) + - (h / 2))
			elseif index == 3 then 
				bitmap:set_x(c_x + (distance * (1 + bloom)))
			elseif index == 4 then
				bitmap:set_y(c_y + (distance * (1 + bloom)))
			elseif index == 5 then 
				bitmap:set_x(c_x - (distance * (1 + bloom)) + - (w / 2))
			end
			--]]
--			bitmap:set_center(NobleHUD._crosshair_panel:w()/2,NobleHUD._crosshair_panel:h()/2)
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
				texture = "guis/textures/pis_crosshair_1",
				w = 28,
				h = 28
			},
			{
				is_center = true,
				texture = "guis/textures/ar_crosshair_2",
				rotation = 0,
				distance = 8,
				w = 2,
				h = 6
			},
			{
				is_center = true,
				texture = "guis/textures/ar_crosshair_2",
				rotation = 90,
				distance = 8,
				w = 2,
				h = 6
			},
			{
				is_center = true,
				texture = "guis/textures/ar_crosshair_2",
				rotation = 180,
				distance = 8,
				w = 2,
				h = 6
			},
			{
				is_center = true,
				texture = "guis/textures/ar_crosshair_2",
				rotation = 270,
				distance = 8,
				w = 2,
				h = 6
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
				w = 32,
				h = 32
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
				w = 8,
				h = 8
			}
		}
	},
	minigun = {
		parts = {
			{
				is_center = true,
				texture = "guis/textures/ability_circle_outline",
				w = 8,
				h = 8
			}
		}
	},
	flamethrower = { --starburst ring of oblongs
		parts = {
			{
				is_center = true,
				texture = "guis/textures/ability_circle_outline",
				w = 8,
				h = 8
			}
		}
	},
	plasma_pistol = { --tri arrow
		parts = {
			{
				texture = "guis/textures/bullet_tick",
				texture_rect = {0,0,4,8},
				w = 4,
				h = 8,
				distance = 10,
				rotation = 180 + 0
			},
			{
				texture = "guis/textures/bullet_tick",
				texture_rect = {0,0,4,8},
				w = 4,
				h = 8,
				distance = 10,
				rotation = 180 + 120
			},
			{
				texture = "guis/textures/bullet_tick",
				texture_rect = {0,0,4,8},
				w = 4,
				h = 8,
				distance = 10,
				rotation = 180 + 240
			}
		}
	},
	plasma_rifle = { --quad arrow
		parts = {
			{
				texture = "guis/textures/bullet_tick",
				texture_rect = {0,0,4,8},
				w = 4,
				h = 4,
				distance = 10,
				rotation = 45 + 180
			},
			{
				texture = "guis/textures/bullet_tick",
				texture_rect = {0,0,4,8},
				w = 4,
				h = 4,
				distance = 10,
				rotation = 135 + 180
			},
			{
				texture = "guis/textures/bullet_tick",
				texture_rect = {0,0,4,8},
				w = 4,
				h = 4,
				distance = 10,
				rotation = 225 + 180
			},
			{
				texture = "guis/textures/bullet_tick",
				texture_rect = {0,0,4,8},
				w = 4,
				h = 4,
				distance = 10,
				rotation = 315 + 180
			}
		}
	},
	plasma_repeater = {
		parts = {
			{
				is_center = true,
				texture = "guis/textures/ability_circle_outline",
				texture_rect = {0,0,4,8},
				w = 8,
				h = 8
			},
			{
				texture = "guis/textures/bullet_tick",
				texture_rect = {0,0,4,8},
				w = 4,
				h = 4,
				distance = 8,
				rotation = 45
			},
			{
				texture = "guis/textures/bullet_tick",
				texture_rect = {0,0,4,8},
				w = 4,
				h = 4,
				distance = 8,
				rotation = 135
			},
			{
				texture = "guis/textures/bullet_tick",
				texture_rect = {0,0,4,8},
				w = 4,
				h = 4,
				distance = 8,
				rotation = 225
			},
			{
				texture = "guis/textures/bullet_tick",
				texture_rect = {0,0,4,8},
				w = 4,
				h = 4,
				distance = 8,
				rotation = 315
			}
		}
	},
	needler = { --tri chevron
		blacklsited = {},
		parts = {
			{
				texture = "guis/textures/bullet_tick",
				texture_rect = {0,0,4,8},
				w = 4,
				h = 4
			}
		}
	},
	plasma_launcher = { --four arrows
		parts = {
			{
				texture = "guis/textures/bullet_tick",
				texture_rect = {0,0,4,8},
				w = 4,
				h = 4,
				distance = 10,
				rotation = 180
			},
			{
				texture = "guis/textures/bullet_tick",
				texture_rect = {0,0,4,8},
				w = 4,
				h = 4,
				distance = 10,
				rotation = 270
			},
			{
				texture = "guis/textures/bullet_tick",
				texture_rect = {0,0,4,8},
				w = 4,
				h = 4,
				distance = 10,
				rotation = 0
			},
			{
				texture = "guis/textures/bullet_tick",
				texture_rect = {0,0,4,8},
				w = 4,
				h = 4,
				distance = 10,
				rotation = 90
			}
		}
	},
	sword = { --crescent with arrow; used for melee
		{
			texture = "guis/textures/sword_crosshair",
			w = 32,
			h = 32
		}
	},
	car = { --chevron; will be used for pd2 vehicles
		
	},
	beam_rifle = { --two hemispheres
		
	}
}

NobleHUD._bloom_table = {
	--lol idk
}

NobleHUD._MAX_REVIVES = 3 --default init value; updated on load
NobleHUD._radar_blips = {}

NobleHUD._random_chars = {}

for cat,s in pairs({
	letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
	numbers = "1234567890",
	characters = "-=!@#%$^&*()_+{}:|<>?[];,/"
}) do 
	NobleHUD._random_chars[cat] = {}
	for i = 1,string.len(s) do 
		table.insert(NobleHUD._random_chars[cat],string.sub(s,i,i))
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
	drug_lord_boss = 100, --sosa
	drug_lord_boss_stealth = 100, --also sosa
	
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

NobleHUD.num_killfeed_messages = 0
local MAX_KILLFEED_ENTRIES = 10

NobleHUD.killfeed = { --queue format, similar to khud's active buffs panel or joyscore's score counter. both of which will also be in this mod
--[[ should always be presorted
	[1] = {
		start_t = [start_t],
		bitmap = [Bitmap],
	},
	[2] = {
		start_t = [start_t],
		text = [Text],
	}
--]]
}
NobleHUD.killfeed_icons = {} --same format but only for icons


--default hud starting values
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

NobleHUD._medal_data = {
	first = { --not implemented
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
		icon_xy = {0,9} --!
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
	headcase = { --not implemented
		name = "headcase",
		sfx = false,
		show_text = false,
		icon_xy = {5,2}
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
	protector = { --not implemented
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
	splatter = { --VERY not implemented (no sound or bitmap)
		name = "splatter",
		multiplier = 1.25,
		disabled = true,
		sfx = false,
		show_text = false,
		icon_xy = {-1,-1}
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
		show_text = false
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
	spree_sword = { --not implemented
		[5] = {
			name = "spree_sword_1",
			sfx = "spree_sword_1",
			hold_sfx = true,
			multiplier = 1.25,
			icon_xy = {3,4}
		},
		[10] = {
			name = "spree_sword_2",
			sfx = "spree_sword_2",
			hold_sfx = true,
			multiplier = 1.5,
			icon_xy = {3,5}
		},
		[15] = {
			name = "spree_sword_3",
			sfx = "spree_sword_3",
			hold_sfx = true,
			multiplier = 1.75,
			icon_xy = {3,6}
		}
	},
	spree_grenade = { --not implemented properly
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
	spree_splatter = { --not implemented
		[5] = {
			name = "spree_splatter_1",
			sfx = "spree_splatter_1",
			hold_sfx = true,
			icon_xy = {4,7}
		},
		[10] = {
			name = "spree_splatter_2",
			sfx = "spree_splatter_2",
			hold_sfx = true,
			icon_xy = {4,8}
		},
		[15] = {
			name = "spree_splatter_3",
			sfx = "spree_splatter_3",
			hold_sfx = true,
			icon_xy = {4,9}
		}
	},
	spree_wheelman = { --not implemented
		[1] = {
			name = "wheelman",
			disabled = true,
			show_text = false,
			hold_sfx = true,
			sfx = false,
			icon_xy = {1,9}
		},
		[5] = { --couldn't find the icons for these
			name = "spree_wheelman_1",
			show_text = false,
			disabled = true,
			hold_sfx = true,
			sfx = "spree_wheelman_1",
			icon_xy = {1,9}
		},
		[10] = {
			name = "spree_wheelman_2",
			disabled = true,
			show_text = false,
			hold_sfx = true,
			sfx = "spree_wheelman_2",
			icon_xy = {1,9}
		},
		[15] = {
			name = "spree_wheelman_3",
			disabled = true,
			show_text = false,
			hold_sfx = true,
			sfx = "spree_wheelman_3",
			icon_xy = {1,9}
		}
	}
}

NobleHUD.num_medals = 0

NobleHUD._animate_targets = {
--[[ example: (probably outdated)
	'[Panel: 0xd34db33f "objectives_panel"]' = {
		object = [Panel: 0xd34db33f "objectives_panel"],
		func = [function: 0xd34db330],
		done_cb = [function: 0xd34adb331],
		args = {...}
	}

--]]
}

--    UTILS
local also_blt_log = false
function NobleHUD:log(...)
	if not self.settings.debug then 
		return
	end
	if Console then 
		Console:Log(...)
	end
	if also_blt_log then 
		log(...)
	end
end

function NobleHUD.table_concat(tbl,div)
	div = (div and tostring(div)) or " "
	if type(tbl) == "table" then 
		local str 
		for k,v in pairs(tbl) do 
			if str then 
				str = str .. div .. tostring(v)
			else 
				str = tostring(v)
			end
		end
		return str or "ERROR2"
	end
	return "ERROR"
end
local function concat(tbl,div) --2lazy 2type
	return NobleHUD.table_concat(tbl,div)
end

function NobleHUD.angle_from(a,b,c,d) --mvector3.angle() is a big fat meanie zucchini
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
		NobleHUD:log("ERROR: angle_from(" .. concat({a,b,c,d},",") .. ") failed - bad/mismatched arg types")
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
		NobleHUD:log("ERROR: vec2_distance(" .. concat({a,b,c,d},",") .. ") failed - bad/mismatched arg types")
		return 0
	end
end

function NobleHUD.format_seconds(raw)
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
--i don't remember actually needing this, i guess i wrote it for fun. it's bad though
	if not (l or n or c) then 
		local tbl = NobleHUD.choose(NobleHUD._random_chars)
		return tbl[math.random(#tbl)]
	end

	local function b(a)
		return a and 1 or 0
	end
	
	l = b(l)
	n = b(n)
	c = b(c)
	
	local t = l + n + c
	
--		l = 0 + l
	n = l + n
	c = n + c
	
	local r = math.random()
	if r < (l/t) then 
		return NobleHUD._random_chars.letters[math.random(#NobleHUD._random_chars.letters)]
	elseif r < (n/t) then 
		return NobleHUD._random_chars.numbers[math.random(#NobleHUD._random_chars.numbers)]
	elseif r < (c/t) then 
		return NobleHUD._random_chars.characters[math.random(#NobleHUD._random_chars.characters)]
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

function NobleHUD:animate_remove_done_cb(object,new)
	local o = NobleHUD._animate_targets[tostring(object)]
	if o then 
		o.done_cb = new
		return true
	end
	return false
end

function NobleHUD:animate_stop(object)
	NobleHUD._animate_targets[tostring(object)] = nil
end

function NobleHUD:animate_fadeout_linear(o,t,dt,start_t,duration,exit_x,exit_y)
	duration = duration or 1
	local ratio = (t - start_t) / duration
	o:set_alpha(1 - ratio)
	if exit_y then 
		o:set_y(o:y() + (exit_y * dt / duration))
	end
	if exit_x then 
		o:set_x(o:x() + (exit_x * dt / duration))
	end
	if ratio >= 1 then 
		return true
	end
end

function NobleHUD:animate_fadeout(o,t,dt,start_t,duration,exit_x,exit_y)
	duration = duration or 1
	local ratio = math.pow((t - start_t) / duration,2)
	
	if ratio >= 1 then 
		o:set_alpha(0)
		return true
	end
	o:set_alpha(1 - ratio)
	if exit_y then 
		o:set_y(o:y() + (exit_y * dt / duration))
	end
	if exit_x then 
		o:set_x(o:x() + (exit_x * dt / duration))
	end
end

function NobleHUD:animate_fadein(o,t,dt,start_t,duration,start_x,end_x,start_y,end_y)
	duration = duration or 1
	local ratio = math.pow((t - start_t) / duration,2)
	
	if ratio >= 1 then 
		o:set_alpha(1)
		if end_x then 
			o:set_x(end_x)
		end 
		if end_y then 
			o:set_y(end_y)
		end
		return true
	end
	o:set_alpha(ratio)
	if start_x and end_x then 
		o:set_x(start_x + ((end_x - start_x) * ratio))
	end
	if start_y and end_y then 
		o:set_y(start_y + ((end_y - start_y) * ratio))
	end
end

--overkill made "PRIMARY" weapons in slot [2] and "SECONDARY" weapons in slot [1],
--probably recycled/holdover/legacy code from PD:TH
--no longer used
function NobleHUD.correct_weapon_selection(num,default)
	return ((num == 1) and 2) or (default or 1)
end

--		SETTINGS

		--GET SETTINGS
function NobleHUD:UseCrosshairDynamicColor()
	return self.settings.crosshair_dynamic_color
end

function NobleHUD:GetCrosshairStaticColor()
	local c = self.settings.crosshair_static_color
	return Color(c.r,c.g,c.b)
end

function NobleHUD:GetCrosshairAlpha()
	return self.settings.crosshair_alpha
end

function NobleHUD:UseCrosshairShake()
	return self.settings.crosshair_shake
end

function NobleHUD:IsCrosshairBloomEnabled()
	return self.settings.crosshair_bloom
end

function NobleHUD:GetCrosshairStability()
	return self.settings.crosshair_stability --multiplied by 10
end

function NobleHUD:IsCrosshairEnabled()
	return self.settings.crosshair_enabled
end

function NobleHUD:IsRadarEnabled()
	return self.settings.radar_enabled
end

function NobleHUD:GetRadarDistance()
	return self.settings.radar_distance
end

function NobleHUD:IsFloatingAmmoPanelEnabled()
	return false
end

function NobleHUD:get_blip_color_by_team(team_name)
	team_name = team_name or "nil"
	local cd = self.color_data --sorry crackdown team, cd is ColorData mod now
	local team_colors = {
		law1 = cd.hud_vitalsfill_red,
		neutral1 = Color.green,
		mobster1 = Color(1,0.5,0),
		converted_enemy = Color(0,1,1),
		hacked_turret = Color(0,1,1),
		criminal1 = cd.hud_vitalsfill_yellow
	}
	if not team_colors[team_name] then 
		self:log("No blip color found for " .. team_name)
	end
	return team_colors[team_name] or Color.white
end

function NobleHUD:get_crosshair_color_by_team(team_name)
	team_name = team_name or "nil"
	local cd = self.color_data
	local team_colors = {
		law1 = cd.hud_vitalsfill_red,
		neutral1 = Color.white,
		mobster1 = Color(1,0.5,0),
		converted_enemy = Color.cyan,
		hacked_turret = Color.cyan,
		criminal1 = Color.green
	}
	if not team_colors[team_name] then 
		self:log("No crosshair color found for " .. team_name)
	end

	return team_colors[team_name] or Color.white
end

function NobleHUD:GetMultikillTime()
	return 1.5
end

function NobleHUD:ShowAllMedalMessages()
	return self.settings.show_all_medals
end

function NobleHUD:IsAnnouncerEnabled() 
	return self.settings.announcer_enabled
end

function NobleHUD:IsScorePopupsEnabled()
	return self.settings.popups_enabled
end

function NobleHUD:GetPopupFontSize()
	return self.settings.popup_font_size
end

function NobleHUD:GetPopupDuration()
	return self.settings.popup_duration
end

function NobleHUD:GetPopupStyle()
	local setting = self.settings.popup_style
	local styles = {
		[1] = "animate_popup_queue",
		[2] = "animate_popup_athena",
		[3] = "animate_popup_bluespider"
--		[4] = "animate_popup_stack",
--		[5] = "animate_popup_nightfall"
	}
	return styles[setting] or "animate_popup_queue"
end

function NobleHUD:IsMedalsEnabled()
	return self.settings.medals_enabled
end

function NobleHUD:IsStaminaEnabled()
	return self.settings.stamina_enabled
end

function NobleHUD:GetEmptyAmmoTickAlpha()
	return self.settings.weapon_ammo_tick_empty_alpha
end

function NobleHUD:GetFullAmmoTickAlpha()
	return self.settings.weapon_ammo_tick_full_alpha
end

		--SET SETTINGS
function NobleHUD:SetCrosshairEnabled(enabled)
	self.crosshair_enabled = enabled
	if alive(self._crosshair_panel) then 
		self._crosshair_panel:set_visible(enabled)
	end
end

function NobleHUD:SetCrosshairAlpha(alpha)
	if alive(self._crosshair_panel) then
		self._crosshair_panel:set_alpha(alpha)
	end
	self.settings.crosshair_alpha = alpha
end

function NobleHUD:SetCrosshairDynamicColorEnabled(enabled)
	self.settings.crosshair_dynamic_color = enabled
end

function NobleHUD:SetCrosshairStaticColor(r,g,b)
	self.settings.crosshair_static_color = {r,g,b}
	if self:IsCrosshairEnabled() and not self:UseCrosshairDynamicColor() and alive(self._crosshair_panel) then 
		self:_set_crosshair_color(Color(r,g,b))
	end
end

function NobleHUD:SetCrosshairShakeEnabled(enabled)
	self.settings.crosshair_shake_enabled = enabled
	if alive(self._crosshair_panel) and not enabled then
		local hud = self._ws:panel()
		self._crosshair_panel:set_center(hud:w() / 2,hud:h() / 2)
	end
end

function NobleHUD:SetCrosshairStability(stability)
	self.settings.crosshair_stability = stability
end

function NobleHUD:SetRadarEnabled(enabled)
	if alive(self._radar_panel) then 
		self._radar_panel:set_visible(enabled or false)
	end
end

function NobleHUD:SetRadarDistance(distance)
	if alive(self._radar_panel) then 
		self:_set_radar_range(string.format("%i",distance))
	end
end

function NobleHUD:ClearKiller(peer_id)
	if peer_id then 
		self._cache.killer[peer_id] = nil
	end
end

function NobleHUD:SetKiller(unit,peer_id)
	if unit and alive(unit) and unit.character_damage and unit:character_damage() and not unit:character_damage():dead() then 
		peer_id = peer_id or managers.network:session():local_peer():id() or 1
		self._cache.killer[peer_id] = unit
	end
end


--		HUD UPDATE STUFF / EVENT FUNCTIONS

function NobleHUD:CreateHUD(orig)
	if not orig:alive(PlayerBase.PLAYER_INFO_HUD_PD2) then 
		return
	end	
	self._ws = managers.gui_data:create_fullscreen_workspace()
	local ws = self._ws
	
	local hud = ws:panel() --master panel
	hud:set_visible(false)
	--armor and shields share the same master panel
	self:_create_vitals(hud)
	self:_create_weapons(hud)
	self:_create_grenades(hud) --this refers to the element in the top left; either deployables or grenades may be displayed here
	self:_create_ability(hud) --this refers to the element in the bottom left (above radar); either deployables or grenades may be displayed here
	self:_create_objectives(hud) 
	self:_create_interact(hud)
	self:_create_crosshair(hud)
	self:_create_compass(hud)
	self:_create_radar(hud)
	self:_create_cartographer(hud)
	self:_create_buffs(hud)
--	self:_create_helper(hud)
	self:_create_carry(hud)
	self:_create_equipment(hud)
	self:_create_teammates(hud)
	self:_create_score(hud)
	self:_create_killfeed(hud)
	self:_create_stamina(hud)
	self:_create_tabscreen(hud)
	self:_create_floating_ammo(hud)
--	managers.hud:script("guis/mask_off_hud"):hide()
end
		
function NobleHUD:OnLoaded()
	self:LoadXAudioSounds()

	self:set_weapon_info()
	self:create_revives()
	self:_set_deployable_equipment(2,true)
	
	self:SetTotalScoreMultiplierDisplay()
	
	self:SetRadarEnabled(self:IsRadarEnabled())
	self._stamina_panel:set_visible(self:IsStaminaEnabled())
	
--	self:set_score_multiplier()
	managers.hud:add_updator("NobleHUD_update",callback(NobleHUD,NobleHUD,"UpdateHUD"))
	self:_switch_weapons(managers.player:local_player():inventory():equipped_selection())
	if self:IsCrosshairEnabled() then 
		self._crosshair_panel:set_alpha(self:GetCrosshairAlpha())
		
		if not self:UseCrosshairDynamicColor() then 		
			self:_set_crosshair_color(self:GetCrosshairStaticColor()) 
			--todo switch crosshair to static color on weapon switch
		end
	else
		self._crosshair_panel:hide()
	end
	
	local level_data = managers.job:current_level_data()
	local level_name = level_data and level_data.name_id
	self:set_mission_name(level_name and managers.localization:text(level_name) or "")
	self:LoadCartographerData(level_name)
			
	managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2).panel:child("teammates_panel"):hide()
	
	self:SetRadarDistance(self:GetRadarDistance())
	
	--[[
	for id,data in pairs(managers.criminals._characters) do 
		if data.taken then 
--			local peer_id = 
--			if data.data.ai then 
--				self:log(i .. " is bot",{Color = tweak_data.chat_colors[peer_id]})
--			end
			self:log("Found taken: " .. tostring(data.name) .. ",id = " .. tostring(id) .. ",peer_id = " .. tostring(data.peer_id) .. ",bot = " .. tostring(data.data and data.data.ai))
			local mask_name = tweak_data.blackmarket.masks.character_locked[data.name]

			local guis_catalog = "guis/"
			local character_table = tweak_data.blackmarket.characters[character] or tweak_data.blackmarket.characters.locked[character_name]
			local bundle_folder = character_table and character_table.texture_bundle_folder

			if bundle_folder then
				guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
			end

			character_texture = guis_catalog .. "textures/pd2/blackmarket/icons/characters/" .. tostring(character_name)
			character_string = managers.localization:text("menu_" .. character)
			
		else 
			self:log(tostring(id) .. " Nobody here!")
		end
	end--]]
	
	
	
	
--layout hud stuff
	self:_sort_teammates()
	if managers.hud:script("guis/mask_off_hud") then 
		managers.hud:script("guis/mask_off_hud").panel:hide()
	end
end

function NobleHUD:UpdateHUD(t,dt)

	if game_state_machine then 
		local game_state = game_state_machine:current_state_name()		
		if self._cache.game_state ~= game_state then 
			NobleHUD:OnGameStateChanged(self._cache.game_state,game_state)
			--Hooks:Call("OnGameStateChange",t,self._cache.game_state,game_state)
			self._cache.game_state = game_state
		end
	end	

	local announcer = self._announcer_sound_source
	if announcer and self._cache.announcer_queue[1] then 
		if announcer:get_state() ~= 1 then 
			announcer:set_buffer(self._cache.sounds[self._cache.announcer_queue[1]])
			announcer:play()
			table.remove(self._cache.announcer_queue,1)
		end
	end
	
	local player = managers.player:local_player()
	if player then 

	
		--medal stuff
		if self:KillsCache("close_call") and player:character_damage():armor_ratio() >= 1 then 
			self:KillsCache("close_call",false,true)
			self:AddMedal("close_call")
		end
	
	
		--animate function stuff
		for object_id,data in pairs(self._animate_targets) do 
			local result
			if type(data and data.func) == "string" then 
				result = NobleHUD[data.func](NobleHUD,data.object,t,dt,data.start_t,unpack(data.args))
			elseif type(data.func) == "function" then
				result = data.func(data.object,t,dt,data.start_t,unpack(data.args))
			else
				self._animate_targets[object_id] = nil --remove from animate targets table
				result = nil --don't do done_cb, that's illegal
			end
			if result then
				self._animate_targets[object_id] = nil
				if data.done_cb and type(data.done_cb) == "function" then 
					data.done_cb(data.object,result,unpack(data.args))
				end
			end
		end	
		
		
		--killfeed stuff
		local KILLFEED_LIFETIME = 5
		local killfeed_count = 0
		for i,item in pairs(self.killfeed) do
			killfeed_count = killfeed_count + 1
			if (t - item.start_t > (item.lifetime or KILLFEED_LIFETIME)) then
				if item.text and alive(item.text) then 
					self:animate(item.text,"animate_fadeout_linear",function (o) o:parent():remove(o) end,0.25)
--					item.text:parent():remove(item.text)
				end
				table.remove(self.killfeed,i)
--				self.killfeed[i] = nil
			else
				if item.text and alive(item.text) then 
					local ty1 = item.text:y()
					local ty2 = self._killfeed_end_y + (killfeed_count * item.text:line_height())
					local tx1 = item.text:x()
					local tx2 = self._killfeed_end_x
					item.text:set_x(tx1 + ((tx2 - tx1) / 4))
					item.text:set_y(ty1 + ((ty2 - ty1) / 4))
				end
			end
		end
		
		killfeed_count = 0
		for i,item in pairs(self.killfeed_icons) do 
			killfeed_count = killfeed_count + 1
			if (t - item.start_t > KILLFEED_LIFETIME) then 
				if item.bitmap and alive(item.bitmap) then 
					self:animate(item.bitmap,"animate_fadeout_linear",function (o) o:parent():remove(o) end,0.15,-item.bitmap:w(),false)
				end
				table.remove(self.killfeed_icons,i)
--				self.killfeed_icons[i] = nil
			else
				if item.bitmap and alive(item.bitmap) then 
					local bx1 = item.bitmap:x()
					local bx2 = self._medal_end_x + (killfeed_count * item.bitmap:h())
					local by1 = item.bitmap:y()
					local by2 = self._medal_end_y
					item.bitmap:set_x(bx1 + ((bx2 - bx1) / 4))
					item.bitmap:set_y(by1 + ((by2 - by1) / 4))
				end
			end
		end
		
		--[[
		NobleHUD.asdfdd = NobleHUD.asdfdd or t

		if NobleHUD.asdfdd < t + 2 then 
			NobleHUD.asdfdd = NobleHUD.asdfdd + 2
			for id,data in pairs(managers.criminals._characters) do 
				if data.taken and data.peer_id then 
					self:_set_scoreboard_character(data.peer_id,data.name)
				end
			end
		end
		--]]
		
		
		local player_pos = player:position()
		local state = player:movement():current_state()
		

			
	--cartographer stuff
		local check_interval = 0.5 --seconds between location checks
		if true then --use cartographer check
			if check_interval + NobleHUD._cache.last_cartographer_t <= t then
				NobleHUD._cache.last_cartographer_t = t
			
				local map_result = NobleHUD:ConsultCartographer(player_pos,NobleHUD._cartographer_data)
				
				if map_result then 
					NobleHUD:SetCartographerLabel(map_result)
				end
			end
		end			
			

		local viewport_cam = managers.viewport:get_current_camera()
		if not viewport_cam then 
			--doesn't typically happen, usually for only a brief moment when all four players go into custody
			return 
		end
		local player_aim = player:movement():m_head_rot():yaw()
		
		local cam_aim = viewport_cam:rotation():yaw()
		local cam_rot_a = viewport_cam:rotation():y()

		local compass_yaw = ((cam_aim) / 180) - 1 --should this perhaps use modulo
		--todo get range of cam_aim
	
		self._compass_panel:child("compass_strip"):set_x(compass_yaw * self._compass_panel:w())
		
--todo make radar update dotcolor for converted enemies
		--radar/crosshair stuff


-- ************** RADAR	**************
		if self:IsRadarEnabled() then --if radar enabled
			local RADAR_SIZE = 192 --todo scaleable panel from settings
			local RADAR_DISTANCE_MID = self:GetRadarDistance() * 100
			local RADAR_DISTANCE_MAX = RADAR_DISTANCE_MID * 1.2
			local RADAR_DISTANCE_MAX_SQ = RADAR_DISTANCE_MAX * RADAR_DISTANCE_MAX
			local V_DISTANCE_MID = 350 --at vertical distances over this threshold, the icon will change to reflect this difference
			
			
			--refresh radar targets (add)
			if (t > NobleHUD._radar_refresh_t + NobleHUD._RADAR_REFRESH_INTERVAL) then
				NobleHUD._radar_refresh_t = t --reset radar refresh timer
				
				local all_persons = World:find_units_quick("sphere",player_pos,RADAR_DISTANCE_MAX,managers.slot:get_mask("persons"))
				for _,unit in pairs(all_persons) do 
					if unit and alive(unit) then --dead people are already filtered out of World:find_units_quick()
						local dis = mvector3.distance_sq(player_pos, unit:position())
--						if unit == Console.tagged_unit then 
--							Console:SetTrackerValue("trackerd","dis " .. dis .. " vs max " .. RADAR_DISTANCE_MAX_SQ)
--						end
						if dis >= RADAR_DISTANCE_MAX_SQ then
							--out of range; remove 
							self:remove_radar_blip(unit)
						else
							self:create_radar_blip(unit) --todo animate fadein
						end
					
					else --no valid unit; this should never happen due to World:find_units_quick() filtering out invalid/dead units
						self:remove_radar_blip(unit)
					end
				end
			end
			

			--refresh currently existing radar blips
			
			local radar = self._radar_panel
			
			for blip_key,data in pairs(self._radar_blips) do 
				if data.unit and alive(data.unit) and (data.unit:character_damage()) and not data.unit:character_damage():dead() then 
--					if not data.unit:character_damage():dead() then
					local person_pos = data.unit:position()
					local angle_to_person = 90 + NobleHUD.angle_from(person_pos,player_pos) - player_aim
					local distance_to_person = NobleHUD.vec2_distance(player_pos,person_pos)
					local v_distance = player_pos.z - person_pos.z
--[[					
						if data.unit == Console.tagged_unit then 
							Console:SetTrackerValue("trackere",RADAR_DISTANCE_MID .. "," .. RADAR_DISTANCE_MAX .. "," .. RADAR_DISTANCE_MAX_SQ)
							local distance_to_person_2 = mvector3.distance(player_pos,person_pos) --actual
							Console:SetTrackerValue("trackera","Exact vertical distance: " .. v_distance)
							Console:SetTrackerValue("trackerb","N Horizontal distance " .. distance_to_person)
							Console:SetTrackerValue("trackerc","Mvector3 Total distance is " .. distance_to_person_2)
--							Console:SetTrackerValue("trackerd","N Vertical distance is " .. 1)						
						end
--]]						
					local blip_x,blip_y
					if distance_to_person < RADAR_DISTANCE_MID then 
					
--						blip_x = (1 + (math.sin(angle_to_person) * (distance_to_person / RADAR_DISTANCE_MID))) * (RADAR_SIZE / 2)
--						blip_y = (1 + (math.cos(angle_to_person) * (distance_to_person / RADAR_DISTANCE_MID))) * (RADAR_SIZE / 2)
						blip_x = (math.sin(angle_to_person) * (distance_to_person / RADAR_DISTANCE_MID) * (RADAR_SIZE / 2))
						blip_y = (math.cos(angle_to_person) * (distance_to_person / RADAR_DISTANCE_MID) * (RADAR_SIZE / 2))
						if math.abs(v_distance) > V_DISTANCE_MID then 
							data.bitmap:set_alpha(0.33)
							data.bitmap:set_rotation(0)
							if v_distance > 0 then 							
								--if lower than player by x, use radar_blip_near_lower
								
								data.bitmap:set_image("guis/textures/radar_blip_low")
							else
								--if higher than player by x, use radar_blip_near_higher
								
								data.bitmap:set_image("guis/textures/radar_blip_high")
							end
						else
--							if data.unit == Console.tagged_unit then 	
--								self:log(v_distance .. "<" .. V_DISTANCE_MID)
--							end
							data.bitmap:set_rotation(-angle_to_person)
							data.bitmap:set_alpha(0.7)
							data.bitmap:set_image("guis/textures/radar_blip_near") --mid
						end
					elseif distance_to_person > RADAR_DISTANCE_MAX then 
						--is out of range
						
						blip_x,blip_y = -1000,-1000
						self:remove_radar_blip(data.unit,blip_key)
					else 
						data.bitmap:set_rotation(-angle_to_person)
						
						--on outskirts of range
						blip_x = math.sin(angle_to_person) * RADAR_SIZE / 2
						blip_y = math.cos(angle_to_person) * RADAR_SIZE / 2
						
						data.bitmap:set_image("guis/textures/radar_blip_far")
					end
					data.bitmap:set_center(blip_x + (RADAR_SIZE/2),blip_y + (RADAR_SIZE/2))
					
						
				else 
					--is dead
					self:remove_radar_blip(data.unit,blip_key)
				end
			end
		end
-- ************** CROSSHAIR ************** 
		if self:IsCrosshairEnabled() then --crosshair enabled
			local fwd_ray = player:movement():current_state()._fwd_ray	
			local focused_person = fwd_ray and fwd_ray.unit
--			local crosshair = self._crosshair_panel:child("crosshair_subparts"):child("crosshair_1") --todo function to handle crosshair modifications
			local crosshair_color = Color.white
			if alive(focused_person) and (self._cache.crosshair_enemy ~= focused_person) then
				self._cache.crosshair_enemy = focused_person --only update crosshair colors if different selected unit than last 
				if focused_person:character_damage() then 
					if not focused_person:character_damage():dead() then 
						local f_m = focused_person:movement()
						local f_t = f_m and f_m:team() and f_m:team().id
						if f_t then 
							if focused_person:brain() and focused_person:brain().is_current_logic and focused_person:brain():is_current_logic("intimidated") then 
								f_t = "converted_enemy"
							end
							crosshair_color = self:get_blip_color_by_team(f_t)
						elseif not f_m then --old color determination method
--							self:log("NO CROSSHAIR UNIT TEAM")
--							if managers.enemy:is_enemy(focused_person) then 
--							elseif managers.enemy:is_civilian(focused_person) then
--							elseif managers.criminals:character_name_by_unit(focused_person) then
							--else, is probably a car.
						end
					end
				elseif focused_person:base() and focused_person:base().can_apply_tape_loop and focused_person:base():can_apply_tape_loop() then 	
					crosshair_color = self:get_blip_color_by_team("law1")
				end
				self:_set_crosshair_color(crosshair_color)
			end
			
			
			if self:UseCrosshairShake() then 
				--if settings.allow_crosshair_shake then 
				local crosshair_stability = self:GetCrosshairStability() * 10
				--theoretically, the raycast position (assuming perfect accuracy) at [crosshair_stability] meters;
				--practically, the higher the number, the less sway shake
				local weapon_direction = state:get_fire_weapon_direction()
				local weapon_position = state:get_fire_weapon_position()
--					if base_uses_sight_position then 
--do stuff here						
--					end
				
				local c_p = self._ws:world_to_screen(viewport_cam,weapon_position + (weapon_direction * crosshair_stability))
				local c_w = (c_p.x or 0)
				local c_h = (c_p.y or 0)
				self._crosshair_panel:set_center(c_w,c_h)	
			end
			
			--bloom
			if self:IsCrosshairBloomEnabled() then 
--					Console:SetTrackerValue("trackera",self.weapon_data.bloom)
				local bloom_decay_mul = 1.5 -- 3
				if self.weapon_data.bloom > 0 then 
					self.weapon_data.bloom = math.max(self.weapon_data.bloom - (bloom_decay_mul * dt),0)
					local bloom = 0
					if false then --exponential decay
						bloom = 1 - math.pow(1 - self.weapon_data.bloom,2)
					else
						bloom = self.weapon_data.bloom
					end
--						Console:SetTrackerValue("trackerb",bloom)
					self:_set_crosshair_bloom(bloom)
--						bloom = 1 - math.pow(bloom,2) -- 0 to 1, sq
					
--						bloom = ((1 - (bloom * bloom)) * bloom_duration) / bloom_duration
--[[
					if true then 
						
--							self.weapon_data.bloom = 1 - math.pow((dt + 1 - self.weapon_data.bloom) * 0.5,2)
					
--							local bloom_duration = 2
--							self.weapon_data.bloom = math.pow(math.clamp((self.weapon_data.bloom - dt),0,1) * bloom_duration,2)
						
					elseif false then --linear decay
						self.weapon_data.bloom = self.weapon_data.bloom * 0.97
						if self.weapon_data.bloom - 0.001 < 0 then
							self.weapon_data.bloom = 0
						end
					else --quadratic decay
						self.weapon_data.bloom = math.max(self.weapon_data.bloom - 0.01,0)
					end
					--]]
				end
				
				if true then --if special crosshairs enabled, like grenade launcher altimeter
					self:_set_crosshair_altimeter(viewport_cam:rotation():pitch())
				end
				
			end
		end
		
		
		local inventory = player:inventory()
		
		--experimental mag count hud
		if self:IsFloatingAmmoPanelEnabled() then
			local floating_ammo_panel = self._floating_ammo_panel	
			local wpn_unit = inventory:equipped_unit()
			NobleHUD.assbutt = wpn_unit
			local wpn_unit_pos = wpn_unit and wpn_unit:position()
			local wpn_unit_screen_pos = wpn_unit_pos and self._ws:world_to_screen(viewport_cam,wpn_unit_pos + ( player:camera():rotation():y() * 100)) --
			if wpn_unit_screen_pos then 
				floating_ammo_panel:set_x(wpn_unit_screen_pos.x)
				floating_ammo_panel:set_y(wpn_unit_screen_pos.y)
			end
		end
		
		
		
		--interact stuff
		
		--local state = managers.player:local_player():movement():current_state(); return tweak_data.interaction[state._interact_params.tweak_data].text_id
		local interact = state._interact_params
		local interact_panel = self._interact_panel
		if interact then 
			local interact_style = self.settings.interact_style
			
			
			local floating_panel = interact_panel:child("floating_panel")
--			local itd = tweak_data.interaction[interact.tweak_data or ""] or {text_id = "ERROR"}
--			local interact_text_id = managers.localization:text(itd.text_id)
--			floating_panel:child("interact_name"):set_text(utf8.to_upper(interact_text_id or "ERROR"))
--			floating_panel:child("interact_progress"):set_text(string.format("%0.01fs",(interact.timer and t - interact.timer) or -99.99))
			local interact_v = interact_panel:child("trace_vertical")
			local interact_h = interact_panel:child("trace_horizontal")
			local interacting_pos = interact.object and interact.object:position()
			if interacting_pos then 
				local interact_pos = self._ws:world_to_screen(viewport_cam,interacting_pos)
				local i_x_d
				local i_y_d
				if interact_style == 1 then
					--panel stays still, but lines trace between unit and panel onscreen
					i_x_d = floating_panel:x() - interact_pos.x
					i_y_d = floating_panel:y() - interact_pos.y
					interact_v:set_height(i_y_d)
					interact_v:set_x(interact_pos.x)
					interact_v:set_y(interact_pos.y)
				
					interact_h:set_width(i_x_d)
					interact_h:set_x(interact_pos.x)
					interact_h:set_y(interact_pos.y + interact_v:height())
				elseif interact_style == 2 then
					--panel moves to unit position onscreen, but lines trace between remaining unit and panel distance if offscreen
					floating_panel:set_x(math.clamp(interact_pos.x,0,interact_panel:w() - floating_panel:w()))		
					floating_panel:set_y(math.clamp(interact_pos.y,0,interact_panel:h() - floating_panel:h()))
					i_x_d = floating_panel:x() - interact_pos.x
					i_y_d = floating_panel:y() - interact_pos.y
					
					interact_v:set_height(i_y_d)
					interact_v:set_x(interact_pos.x)
					interact_v:set_y(interact_pos.y)
				
					interact_h:set_width(i_x_d)
					interact_h:set_x(interact_pos.x)
					interact_h:set_y(floating_panel:y() + interact_v:height())
					
				elseif interact_style == 3 then 
					--panel moves to unit position onscreen
					floating_panel:set_x(math.clamp(interact_pos.x,0,interact_panel:w() - floating_panel:w()))		
					floating_panel:set_y(math.clamp(interact_pos.y,0,interact_panel:h() - floating_panel:h()))
				end
			end
		end
		
		
		
			
	-- ************** SCORE ************** 
		self:UpdateScoreTimerMultiplier(t) --set multiplier based on heist timer
		self:SetTotalScoreMultiplierDisplay()
		local popup_queues = 0

		local function fadeout_popup(o,fadeout_time,popup_death_momentum)
			self:animate(o,"animate_fadeout",function (o) o:parent():remove(o) end,fadeout_time,nil,popup_death_momentum)
		end
		local popup_duration = self:GetPopupDuration()
		local popup_height = self:GetPopupFontSize() + 2
		for i,popup_data in ipairs(self._cache.score_popups) do 
			local popup = popup_data.popup
			local style = popup_data.style
			local popup_unit = popup_data.unit
			local popup_start_t = popup_data.start_t
			
			
			
			if not (popup_start_t and popup and style and alive(popup)) then 
				table.remove(self._cache.score_popups,i)
	--				self._cache.score_popups[i] = nil
				if popup and alive(popup) then 
					self:animate(popup,"animate_fadeout",function(o) o:parent():remove(o) end,1)
				end
			else
				if type(self[style]) == "function" then 
					local popup_animate_result
					local fadeout_time = 0.66
					if style == "animate_popup_queue" then 
						popup_queues = popup_queues + 1
						popup_animate_result = self[style](self,popup,t,dt,popup_start_t,nil,popup_duration,self._popup_end_y + (popup_queues * popup_height),3)
					elseif style == "animate_popup_bluespider" then
						fadeout_time = 0.15
						popup_animate_result = self[style](self,popup,t,dt,popup_start_t,nil,popup_duration,popup_unit)
					elseif style == "animate_popup_athena" then
						fadeout_time = 0.5
						popup_animate_result = self[style](self,popup,t,dt,popup_start_t,nil,popup_duration,-30)
					end
					if popup_animate_result then
						table.remove(self._cache.score_popups,i)
						fadeout_popup(popup,-1)
					else
						--not done animating, so continue
					end
				else
					self:log("Popup " .. popup:name() .. " [ #" .. tostring(i) .. " ] " .. " has invalid style [" .. style .. "]; Removing...",{color = Color.red})					
	--					self._cache.score_popups[i] = nil
					table.remove(self._cache.score_popups,i)
					fadeout_popup(popup)
	--					self:animate(popup,"animate_fadeout",function(o) o:parent():remove(o) end,1)				
				end
			end
		end	
			
		
--		self:_set_mission_timer(NobleHUD.format_seconds(managers.game_play_central:get_heist_timer()))

--		if t > self._helper_last_sequence_t then
	--			self._helper_last_sequence_t = t + 3
			--set new sequence
	--			self._current_helper_pattern = self.choose({"dot","lotus","x"})
	--			managers.hud:_set_helper_pattern()
--		end
		--[[
		if t > self._dot_last_t then
			self._dot_last_t = t + 3
			local function random_index (tbl) --i hate everything about this
				local length = 0
				for k,v in pairs(tbl) do 
					length = length + 1
				end
				local chosen = math.ceil(math.random(length))
				local n = 0
				for j,w in pairs(tbl) do 
					n = n + 1
					if n == chosen then 
						return j
					end
				end
			end
			local p = random_index(self._patterns)
			if p then 
				self:_set_helper_pattern(p)
			end
		end		
		--]]
	end

--simplified delayed callbacks implementation
	for i,data in pairs(NobleHUD._delayed_callbacks) do 
		if data.timer then 
			if data.timer <= t then 
				NobleHUD._delayed_callbacks[i] = nil
--				table.remove(NobleHUD._delayed_callbacks,i)
				if type(data.func) == "function" then 
					data.func(unpack(data.args))
				end
			end
		else
			NobleHUD._delayed_callbacks[i] = nil
		end
	end
	
end

function NobleHUD:OnEnemyKilled(attack_data,headshot,unit)
	local t = Application:time()
	local player = attack_data.attacker_unit
	if not alive(player) then
		return
	elseif player ~= managers.player:local_player() then
--		self:AddMedal("grave")
		return
	end
	local player_movement = player:movement()
	local player_weapon = attack_data.weapon_unit
	local weapon_base = alive(player_weapon) and player_weapon:base()
	local player_weapon_categories
	local player_weapon_id = weapon_base and weapon_base.get_name_id and weapon_base:get_name_id() or ""
	if weapon_base then 
		player_weapon_categories = weapon_base and weapon_base.categories and weapon_base:categories()
	end
	local player_state = managers.player:current_state()
	local variant = attack_data.variant
	local base = unit:base()
	local movement = unit:movement()
	local unit_type = base._tweak_table
	local is_cop = CopDamage.is_cop(unit_type)
	local unit_anim = unit.anim_data and unit:anim_data()

	local player_guns = player:inventory():available_selections()
	local primary_id = player_guns[1].unit:base():get_name_id()
	local secondary_id = player_guns[2].unit:base():get_name_id()

	
	


	local medal_multiplier = 1

	if CopDamage.is_civilian(unit:base()._tweak_table) or managers.enemy:is_civilian(unit) then
		self:ClearKillsCache()
		self:PlayAnnouncerSound("betrayal")
		--no +1 kills for you, you murderer >:(
	else
	
		if player_weapon_id == primary_id then
			self:_set_killcount(1,managers.statistics:session_killed_by_weapon(primary_id))
		elseif player_weapon_id == secondary_id then 
			self:_set_killcount(2,managers.statistics:session_killed_by_weapon(secondary_id))
		end
		
		if player:character_damage():_max_armor() > 0 and player:character_damage():health_ratio() <= 0.5 and player:character_damage():get_real_armor() <= 0 then 
			self:KillsCache("close_call",true,true)
		end
		
		if player:character_damage():incapacitated() or player:character_damage():bleed_out() then 
			self:AddMedal("grave")
		end
	
		if movement and movement:rope_unit() then 
			self:AddMedal("pull")
		end
		
		if player_movement and player_movement:zipline_unit() then 
			self:AddMedal("firebird")
		end
		
		local action = movement and movement._active_actions[1]
--		NobleHUD.buttass = movement and movement._active_actions --!
		
		local action_type = action and action:type()
		if unit_type == "spooc" then
			if action_type == "spooc" then
				if action:is_flying_strike() then
					self:AddMedal("bulltrue")
				elseif not action:has_striken() then
					self:AddMedal("showstopper")
				end
			end
		end
		
		if weapon_base and weapon_base.thrower_unit then
			if variant == "explosion" then 
				local ptd = tweak_data.blackmarket.projectiles[player_weapon_id]
				if ptd and ptd.is_a_grenade then
					self:AddMedal("spree_grenade",self:KillsCache("grenade",1))
				end
			--	return
			end
		elseif variant == "bullet" then 
		
			if head then
				self:AddMedal("headshot")
				medal_multiplier = medal_multiplier * self:GetMedalMultiplier("headshot")
			end
			local is_sniper,is_shotgun,is_saw		

			if type(player_weapon_categories) == "table" then 
				for _,cat in pairs(player_weapon_categories) do 
					if cat == "shotgun" then 
						is_shotgun = true
					elseif cat == "snp" then 
						is_sniper = true
					elseif cat == "saw" then 
						is_saw = true
					end
				end
			end
			
			if is_sniper then 
				if head then 
					self:AddMedal("sniper")
				end
				self:AddMedal("spree_sniper",self:KillsCache("sniper",1))
			end
			if is_shotgun then 
				self:AddMedal("spree_shotgun",self:KillsCache("shotgun",1))	
			end
			if is_saw then 
				local saw_count = self:KillsCache("saw",1)
				self:AddMedal("spree_sword",saw_count)
				medal_multiplier = medal_multiplier * self:GetMedalMultiplier("spree_sword",saw_count)
			end
			

		elseif variant == "melee" then 
			self:KillsCache("melee",1)
			self:AddMedal("pummel")
				
			if attack_data.cool then 
				self:AddMedal("assassination")
				medal_multiplier = medal_multiplier * self:GetMedalMultiplier("assassination")
			end
			if attack_data.from_behind then
				self:AddMedal("beatdown")
			end
		elseif variant == "graze" then 
			--nothing special
		end
--		self:log(tostring(action_type))
		
		if action_type == "reload" then  --this is not correct, idk how to measure is reloading state yet
			--self:AddMedal("reload_this") --haven't added assets for it yet lol
		end
		
		local multikill_count = 1
		if self:KillsCache("last_kill_t") + self:GetMultikillTime() >= t then 
			multikill_count = self:KillsCache("multi_count",1)
			self:AddMedal("multikill",multikill_count)
		else
			self:KillsCache("multi_count",multikill_count,true)
		end
		local spree_count = self:KillsCache("spree_count",1)
		
		medal_multiplier = medal_multiplier * self:GetMedalMultiplier("multikill",multikill_count)
		medal_multiplier = medal_multiplier * self:GetMedalMultiplier("spree_all",spree_count)
		self:AddMedal("spree_all",spree_count)
		self:KillsCache("last_kill_t",t,true)
	end
	attack_data.name = attack_data.name or unit_type
	self:TallyScore(attack_data,unit,medal_multiplier)
end

function NobleHUD:OnEnemyKilledOld(data)
	--migrating to new version
	if not data then 
		self:log("No kill data found!")
		return
	end
	local t = Application:time()
	local unit_name = data.name or ""
	local weapon_unit = data and data.weapon_unit
	local weapon_id = weapon_unit and weapon_unit.base and weapon_unit:base() and weapon_unit:base():get_name_id()
	
--	local equipped_primary = managers.blackmarket:equipped_primary()	
--	local equipped_secondary = managers.blackmarket:equipped_secondary()
--	local equipped_melee_weapon = managers.blackmarket:equipped_melee_weapon()
--managers.player:local_player():inventory():available_selections()[1].unit:base():categories()
	local player = managers.player:local_player() 
	local inventory = player:inventory()
	local weapons = inventory:available_selections()
	local primary = weapons[1].unit:base()
	local secondary = weapons[2].unit:base()
	local primary_id = primary:get_name_id()
	local secondary_id = secondary:get_name_id()
--	local melee = inventory._melee_weapon_unit
	self:log("Killed " .. tostring(data.type) .. " with " .. tostring(weapon_id) .. "/" .. tostring(data.variant))
	if data.type and data.type == "neutral" or data.type == "civilians" then 
		self:ClearKillsCache()
		self:PlayAnnouncerSound("Betrayal")
		--no +1 kills for you, you murderer >:(
	else
		local from_weapon
		if weapon_id == primary_id then 
			from_weapon = 1
			self:_set_killcount(1,managers.statistics:session_killed_by_weapon(weapon_id))
		elseif weapon_id == secondary_id then 
			from_weapon = 2
			self:_set_killcount(2,managers.statistics:session_killed_by_weapon(weapon_id))
		elseif data.variant == "melee" then --weapon_id == managers.blackmarket:equipped_melee_weapon().weapon_id then
			from_weapon = 3
			if self:KillsCache("last_kill_t") > t then 
				self:KillsCache("melee",1)
			end
			--triggers for beatdown and assassination are in copdamage since that information is not passed to here
			self:AddMedal("pummel")
		
			self:_set_killcount(3,managers.statistics:session_killed_by_weapon(weapon_id))
		elseif data.variant == "graze" then
			from_weapon = 3
			self:AddMedal("spree_sniper",self:KillsCache("sniper",1))
		elseif data.variant == "projectile" then 
			from_weapon = 3
		elseif data.variant == "explosion" then
			local ptd = tweak_data.blackmarket.projectiles
			if ptd[weapon_id] and ptd[weapon_id].is_a_grenade then
				from_weapon = 3
				self:AddMedal("spree_grenade",self:KillsCache("grenade",1))
			end
		else
--			self:log("Killed " .. tostring(unit_name) .. " with misc weapon " .. tostring(weapon_id or weapon_unit))
		end
		
		if from_weapon then 
			if not alive(player) or player:character_damage():incapacitated() or player:character_damage():bleed_out() then 
				self:AddMedal("grave")
			elseif alive(player) then 
				if player:character_damage():_max_armor() > 0 and player:character_damage():health_ratio() <= 0.5 and player:character_damage():get_real_armor() <= 0 then 
					self:KillsCache("close_call",true,true)
				end
			end
			
			
			local multi_count,sniper_count,shotgun_count
			local spree_count = self:KillsCache("spree_count",1)
			if from_weapon ~= 3 then 
				if data.head_shot then 
					self:AddMedal("headshot")
				end
				for _,category in pairs(weapon_unit:base():categories()) do 
					if category == "shotgun" then 
						shotgun_count = self:KillsCache("shotgun",1)
						self:AddMedal("spree_shotgun",shotgun_count)					
					end
					if category == "snp" then 
						sniper_count = self:KillsCache("sniper",1)
						if data.head_shot then 
							self:AddMedal("sniper")
						end
						if sniper_count > 1 then 
							self:AddMedal("spree_sniper",sniper_count)
						end
					end
				end
			end
			if self:KillsCache("last_kill_t") + self:GetMultikillTime() >= t then 
				multi_count = self:KillsCache("multi_count",1)
				self:AddMedal("multikill",multi_count)
			else
				multi_count = self:KillsCache("multi_count",1,true)
			end
			self:AddMedal("spree_all",spree_count)
			self:KillsCache("last_kill_t",t,true)
		end

	end
	self:TallyScore(data)
end

function NobleHUD:KillsCache(category,amount,set)
	if amount ~= nil then 
		if set then 
			self._cache.kills[category] = amount
		elseif type(self._cache.kills[category]) == "number" then 
			self._cache.kills[category] = self._cache.kills[category] + (tonumber(amount or 0) or 0)
		end
	elseif set ~= nil then
		self:log("Error: No killcount category found for " .. tostring(category),{color = Color.red})
	end
	
	return self._cache.kills[category]
end

function NobleHUD:GetMedalMultiplier(category,current_tier)
	local medal_data = self._medal_data and self._medal_data[category]
	if self:IsMedalsEnabled() then 
		if medal_data then 
			if medal_data.multiplier then 
				return medal_data.multiplier
			elseif not medal_data.name then 
				local multiplier = 1
	--			local current_tier = tier self._cache.kills[category]
				if not current_tier then 
					self:log("ERROR: Bad category to GetMedalMultiplier(" .. tostring(category) .. "," .. tostring(current_tier) .. ")")
					return
				end
				for tier,tiered_data in pairs(medal_data) do 
					if tier == current_tier then
						return tiered_data.multiplier and math.max(tiered_data.multiplier,multiplier) or multiplier
					elseif tier < current_tier then 
						multiplier = tiered_data.multiplier and math.max(tiered_data.multiplier,multiplier) or multiplier
					end
				end
				return multiplier
			end
		else
			self:log("ERROR: GetMedalMultiplier() Bad category!",{color = Color.red})
		end
	end
	return 1
end

function NobleHUD:ClearKillsCache()
	self._cache.kills = {
		spree_all_mul = 1,
		multi_mul = 1,
		spree_assist_mul = 1,
		spree_sword_mul = 1,
		close_call = false,
		last_kill_t = 0,
		spree_count = 0,
		multi_count = 0,
		melee = 0,
		sniper = 0,
		shotgun = 0,
		saw = 0,
		grenade = 0
	}
end

function NobleHUD:OnPlayerStateChanged(state)
	--[[ state can be:
		jerry1 = "ingame_freefall",
		carry = "ingame_standard",
		civilian = "ingame_civilian",
		jerry2 = "ingame_parachuting",
		driving = "ingame_driving",
		bleed_out = "ingame_bleed_out",
		incapacitated = "ingame_incapacitated",
		mask_off = "ingame_mask_off",
		arrested = "ingame_arrested",
		clean = "ingame_clean",
		fatal = "ingame_fatal",
		standard = "ingame_standard",
		bipod = "ingame_standard",
		tased = "ingame_electrified"
	--]]
	self:log("Changed player state to " .. tostring(state),{color = Color(0,1,1)})
	if state == "fatal" or state == "bleed_out" or state == "arrested" or state == "incapacitated" then 
		self:ClearKillsCache()
	end
	--todo: on enter custody, destroy NobleHUD hud, and create or show custody hud
end

function NobleHUD:OnGameStateChanged(before_state,state)
	self:log("Changed game state from " .. (before_state) .. " to " .. tostring(state),{color = Color.green})
	local hud = self._ws:panel()
--	if state == "ingame_waiting_for_respawn" or before_state == "ingame_waiting_for_players" then 
--		hud:set_visible(true)
	if state == "ingame_waiting_for_respawn" or state == "victoryscreen" or state == "gameoverscreen" or state == "server_left" then 
		hud:set_visible(false)
	elseif before_state == "ingame_waiting_for_respawn" or before_state == "ingame_waiting_for_players" then 
		hud:set_visible(true)
	else 
		--hud:set_visible(false)
	end
end

function NobleHUD:LoadXAudioSounds()
    if blt.xaudio then
        blt.xaudio.setup()
		
		local function loadsound(snd)
			local path = NobleHUD._announcer_path .. snd .. ".ogg"
			if self._efficient_audio_mode then 
--				self:log("Loading sound to _cache: " .. tostring(snd))
				self._cache.sounds[snd] = path
			else
--				self:log("Loading sound to buffer and _cache: [" .. tostring(snd)..".ogg]")
				self._cache.sounds[snd] = XAudio.Buffer:new(path)
			end
		end
		
		-- Announcer (Downes/Chief)
		if not self._efficient_audio_mode then 
			self._announcer_sound_source = self._announcer_sound_source or XAudio.Source:new()
		end
		for medal_name,medal in pairs(self._medal_data) do 
			if medal.sfx and medal.sfx ~= "" and not medal.disabled then 
				loadsound(medal.sfx)
			else
				for tier,tiered_medal in pairs(medal) do 
					if type(tier) == "number" then 
						if tiered_medal.sfx and tiered_medal.sfx ~= "" and not tiered_medal.disabled then 							
							loadsound(tiered_medal.sfx)
						end
					end
				end
			end
		end
		
		
		-- Auntie Dot
		--...IF I HAD ONE
		--self._helper_sound_source = self._helper_sound_source or XAudio.Source:new()
	end
end

function NobleHUD:PlayAnnouncerSound(name)
	if not self:IsAnnouncerEnabled() then 
		return
	end

	local snd = self._cache.sounds[name]
	if snd then 
		if self._efficient_audio_mode then 
			XAudio.Source:new(XAudio.Buffer:new(snd))
		else
			if self._announcer_sound_source then 
				self._cache.announcer_queue[#self._cache.announcer_queue + 1] = name
			end
		end
	else
		self:log("PlayAnnouncerSound(): sound [" .. name .. "] not found",{color = Color.red})
	end
end


--		WEAPONS

function NobleHUD:_create_weapons(hud)
	

	local master_w = 150
	local margin_w = 16
	local weapons_master = hud:panel({
		name = "weapons_panel",
		layer = 1,
		w = master_w,
		h = 128,
		x = hud:w() - (master_w + margin_w),
		y = 24
	})
	local debug_weapons_master = weapons_master:rect({
		visible = false,
		color = Color.green,
		alpha = 0.5
	})

	local weapon_name = weapons_master:text({ --weapon name (fades out)
		name = "weapon_label",
		text = "GEPGUN", --the most silent way to take down manderley
		vertical = "center",
		x = 0.1 * master_w,
		align = "left",
		alpha = 1, --set visible briefly on weapon switch
		font = tweak_data.hud_players.ammo_font, --eurostile?
		font_size = 12,
		layer = 5
	})	
	
	local primary_panel = weapons_master:panel({
		name = "primary_panel",
		layer = 2,
		w = 100,
		h = 54 --placement is done later		
	})

	local secondary_panel = weapons_master:panel({
		name = "secondary_panel",
		layer = 1,
		w = 100,
		h = 54
	})
	self._master_weapon_panel = weapons_master
	self._primary_weapon_panel = primary_panel
	self._secondary_weapon_panel = secondary_panel
	local function add_panel(panel)
		local weapon_icon = panel:bitmap({ --icon
			name = "weapon_icon",
			layer = 5,
	--		x = 100,
	--		y = 100,
			w = 100,
			h = 50,
--			blend_mode = "add",
			color = self.color_data.hud_weapon_color,
			texture = managers.blackmarket:get_weapon_icon_path("amcar"),
			texture_rect = nil
		})
		--
		local kills_label = panel:text({
			name = "kills_label",
			text = "0",
			visible = true,
			font = tweak_data.hud_players.ammo_font,
			y = 12,
			font_size = 12,
			layer = 5
		})
		--
		local mag_label = panel:text({ --mag count for current weapon
			name = "mag_label",
			visible = false, --! temp disabled! /!\
			text = "60",
--			align = "right",
--			vertical = "bottom",
			y = weapon_icon:y(),
--			x = weapon_icon:right() - 12,
			color = self.color_data.white,
			alpha = 0.66,
			font = "fonts/font_eurostile_ext",
			font_size = 16,
			layer = 6
		})
		local reserve_label = panel:text({ --total ammo count for current weapon
			name = "reserve_label",
			text = "120",
			align = "right",
			vertical = "top",
			color = self.color_data.white,
--			x = -24,
--			alpha = 0.5,
			font = "fonts/font_eurostile_ext",
			font_size = 24,
			layer = 6
		})
		local firemode_indicator = panel:bitmap({
			name = "firemode_indicator",
			layer = 5,
			w = 8,
			h = 4,
			visible = false, --! temp disabled! /!\
			color = self.color_data.hud_vitalsoutline_blue,
			texture = "guis/textures/bullet_tick"
		})
		local safety_indicator = panel:bitmap({ --lock?
			name = "safety_indicator",
			layer = 6,
			w = 8,
			h = 8,
			color = Color.red,
			visible = false,
			texture = "guis/textures/ability_circle_fill"
		})
		return weapon_icon,kills_label,mag_label,reserve_label,firemode_indicator,safety_indicator
	end

	local debug_1 = primary_panel:rect({
		name = "debug_ammo_1",
		color = Color.red,
		visible = false,
		alpha = 0.3
	})

	local debug_2 = secondary_panel:rect({
		name = "debug_ammo_2",
		color = Color.blue,
		visible = false,
		alpha = 0.3
	})	
	local weapon_icon_1,weapon_label_1,mag_label_1,reserve_label_1,firemode_1,safety_1 = add_panel(primary_panel)
	local weapon_icon_2,weapon_label_2,mag_label_2,reserve_label_2,firemode_2,safety_2 = add_panel(secondary_panel)
	
end

function NobleHUD:_create_ammo_ticks(weapon)
	if not weapon then 
		return 
	end
	
	local main_category = "other"
	local clip_max = weapon:get_ammo_max_per_clip()
	
	--[[ reach only uses generic ammo ticks, unlike H1,2,3, and ODST, which all use weapon-individualized ammo bitmaps. i'll do it later probably
	
	
	local texture = "guis/textures/bullet_tick" --"guis/textures/test_blur_df"
	local texture_rect = {0,0,8,16}
	local margin_w = 2
	local margin_h = 2
	--]]
	local categories = weapon:categories()
	for cat,v in pairs(self._bullet_textures) do 
		if weapon:is_category(cat) then 
			main_category = cat
			break
		end
	end
	local texture_data = self._bullet_textures[main_category] or self._bullet_textures["other"]
	local texture = texture_data.texture
	local texture_rect = texture_data.texture_rect
	local margin_w = texture_data.margin_w or 2
	local margin_h = texture_data.margin_h or 2
	
	local weapon_panel
	if weapon:selection_index() == 1 then 
		weapon_panel = self._primary_weapon_panel
	else
		weapon_panel = self._secondary_weapon_panel -- not implemented
	end
	
	if alive(weapon_panel:child("weapon_ammo_ticks")) then 
--		weapon_panel:remove(weapon_panel:child("weapon_ammo_ticks")) --uncommenting this causes errors so. i'm not gonna do that
		return
	end
	
	local panel = weapon_panel:panel({
		name = "weapon_ammo_ticks"
	})
	local debug_ammo = panel:rect({
		name = "debug_ammo_" .. weapon:selection_index(),
		color = Color.yellow,
		visible = false,
		alpha = 0.3
	})
	
	if texture_data.use_bar then 
		local ammo_bar = panel:bitmap({
			name = "ammo_bar",
			texture = texture,
			texture_rect = texture_rect,
			w = texture_data.icon_w,
			h = texture_data.icon_h,
			layer = 2,
			color = self.color_data.hud_weapon_color,
			alpha = 1
		})
		local ammo_bg = panel:bitmap({
			name = "ammo_bar",
			texture = texture,
			texture_rect = texture_rect,
			w = texture_data.icon_w,
			h = texture_data.icon_h,
			layer = 1,
			color = Color(0,0.3,0.7),
			alpha = 0.3
		})
		ammo_bar:set_y(panel:h() - ammo_bar:h())
		ammo_bg:set_y(panel:h() - ammo_bg:h())
	elseif texture_data.use_radial then 
		local ammo_radial = panel:bitmap({
			name = "ammo_radial",
			render_template = "VertexColorTexturedRadial",
			texture = texture,
			texture_rect = texture_rect,
			w = texture_data.icon_w,
			h = texture_data.icon_h,
			layer = 2,
			color = Color.white,
			alpha = 1
		})
	else
		local row = 1
		local column = 1
		for i = 1,clip_max do 
			local ammo_icon = panel:bitmap({ --todo align to bottom of main weapon panel
				name = "ammo_icon_" .. i,
				texture = texture,
				texture_rect = texture_rect,
				w = texture_data.icon_w,
				h = texture_data.icon_h,
				layer = 2,				
				color = self.color_data.hud_weapon_color, --start out loaded
				alpha = 0.7,
--				blend_mode = "add",
				x = 0,
				y = 0
			})
			local icon_w = ammo_icon:w()
			local icon_h = ammo_icon:h()
			if column * (margin_w + icon_w) > panel:w() then
				column = 1
				row = row + 1
			end
			ammo_icon:set_x(panel:w() - (column * (margin_w + icon_w)))
			ammo_icon:set_y(panel:h() - (row * (margin_h + icon_h))) --from bottom
			column = column + 1
		end
	end
		
	return panel
end

function NobleHUD:set_weapon_info()
	local player = managers.player:local_player() 
	local inventory = player:inventory()
	local weapons = inventory:available_selections()
	for i,weapon in pairs(weapons) do 
		local base = weapon.unit:base()
		self:_create_ammo_ticks(base)
		self:_create_custom_crosshairs(i,base)
		self:_set_weapon_label(i,base:get_name_id())
		self:_set_weapon_icon(i,base:get_name_id())
		self:_set_weapon_mag(i,base:get_ammo_remaining_in_clip())
		self:_set_weapon_reserve(i,base:get_ammo_total() - base:get_ammo_remaining_in_clip()) --todo original ammo counter
--for k,v in pairs(managers.player:local_player():inventory():available_selections()) do search_class(v.unit:base(),"custom") end
--		self.weapon_data[i].weapon_type = 
	end
	
	--crosshair stuff	
end

function NobleHUD:_set_weapon_reserve(slot,amount)
	local weapon_panel
	if slot == 1 then 
		weapon_panel = self._primary_weapon_panel
	else --secondary
		weapon_panel = self._secondary_weapon_panel
	end
	weapon_panel:child("reserve_label"):set_text(amount)
end

function NobleHUD:_set_weapon_mag(slot,amount,max_amount)
	self:SetFloatingAmmo(amount,max_amount)
	amount = amount or 0
	max_amount = max_amount or 1
	local weapon_panel
	if slot == 1 then 
		weapon_panel = self._primary_weapon_panel
	else --secondary
		weapon_panel = self._secondary_weapon_panel
	end
	weapon_panel:child("mag_label"):set_text(amount)
	if not alive(weapon_panel:child("weapon_ammo_ticks")) then 
		self:log("ERROR: _set_weapon_mag(" .. NobleHUD.table_concat({slot,amount,max_amount},",") .. "): No weapon panel present? Investigate load order issues")
		return
	end
	local ammo_bar = weapon_panel:child("weapon_ammo_ticks"):child("ammo_bar")
	local ammo_radial = weapon_panel:child("weapon_ammo_ticks"):child("ammo_radial")
	local ratio = 1
	if max_amount ~= 0 then 
		ratio = amount/max_amount
	end
	local empty_alpha = self:GetEmptyAmmoTickAlpha()
	local full_alpha = self:GetFullAmmoTickAlpha()
	if alive(ammo_bar) then 
		--if type minigun or flamethrower, which use bars instead of ammo ticks
		--because otherwise that's a lot of bullet icons to iterate through
		local bar_w = 100 --TODO save to global 
		local bar_h = 8
--depletes toward the left
		ammo_bar:set_texture_rect(0,0,bar_w * ratio,bar_h)
		ammo_bar:set_w(bar_w * ratio)
		--ammo_bar:set_x(bar_w * (1-ratio))
		--ammo_bar:set_w(bar_w * amount/max_amount)
	elseif alive(ammo_radial) then 
		ammo_radial:set_color(Color(ratio,max_amount,0))
	else
		for i = 1,max_amount do 
			local ammo_icon = weapon_panel:child("weapon_ammo_ticks"):child("ammo_icon_" .. i)
			if alive(ammo_icon) then 
				if i > amount then 
					ammo_icon:set_alpha(empty_alpha)
				else 
					ammo_icon:set_alpha(full_alpha)
				end
				
			end
		end
	end
end

function NobleHUD:_set_weapon_label(slot,id)
	local weapon_panel = self._master_weapon_panel
	local weapon_name = "The Gun That Can Kill The Past"
	if not id then return end
	local custom_name = true
	
	if custom_name then 
		if slot == 1 then 
			weapon_name = managers.blackmarket:equipped_secondary().custom_name
--		weapon_panel = self._primary_weapon_panel
		else --secondary
			weapon_name = managers.blackmarket:equipped_primary().custom_name
		end
--		weapon_panel = self._secondary_weapon_panel
	end
	if not (custom_name and weapon_name) then
		weapon_name = managers.weapon_factory:get_weapon_name_by_weapon_id(id)
	end
	--todo set color based on kills w/ tiers
	weapon_panel:child("weapon_label"):set_text(weapon_name)

end

function NobleHUD:_set_weapon_icon(slot,id)
	local weapon_panel = self._master_weapon_panel
	if slot == 1 then 
		weapon_panel = self._primary_weapon_panel
	else --secondary
		weapon_panel = self._secondary_weapon_panel
	end
	weapon_panel:child("weapon_icon"):set_image(managers.blackmarket:get_weapon_icon_path(id),{0,0,128,64})
end	
	
function NobleHUD:_switch_weapons(id)
	local player = managers.player:local_player() 
	if not player then return end 
	local inventory = player:inventory()
	local weapons = inventory:available_selections()
	
	self._primary_weapon_panel:stop()
	self._secondary_weapon_panel:stop()
	self._master_weapon_panel:stop()
	if id == 1 then
		self._primary_weapon_panel:animate(callback(self,self,"animate_switch_weapon_in"))
		self._secondary_weapon_panel:animate(callback(self,self,"animate_switch_weapon_out"))
	else
		self._secondary_weapon_panel:animate(callback(self,self,"animate_switch_weapon_in"))
		self._primary_weapon_panel:animate(callback(self,self,"animate_switch_weapon_out"))
	end
	for i,weapon in pairs(weapons) do 
		local base = weapon.unit:base()
		self:_create_ammo_ticks(base) --:set_visible(i == id)
		if id == i then 		
			self:_set_weapon_label(id,base:get_name_id()) --only one shared weapon label, used by master weapon panel
		else
			self:SetFloatingAmmo(base:get_ammo_remaining_in_clip(),base:get_ammo_max_per_clip())
		end
		self:_set_weapon_icon(i,base:get_name_id())
		self:_set_weapon_mag(i,base:get_ammo_remaining_in_clip())
		self:_set_weapon_reserve(i,base:get_ammo_total() - base:get_ammo_remaining_in_clip())
	end
	
	self:_set_crosshair_in_slot_visible(id)
	self._master_weapon_panel:animate(callback(self,self,"animate_flash_weapon_name"))
	if not self:UseCrosshairDynamicColor() then 
		self:_set_crosshair_color(self:GetCrosshairStaticColor())
	end
end

function NobleHUD:animate_flash_weapon_name(o)
	local a = 2 --duration in seconds
	local accel = 2
	local t = 0
	while t <= a do 
		t = t + coroutine.yield()
--				(- (a - (x * 2) ) ^2) )
--				/a
--	y = (a + 
		local alpha = math.min(a + ((-math.pow(a-(t * accel),2))/a),1)
		o:child("weapon_label"):set_alpha(alpha)
	end
end

function NobleHUD:animate_switch_weapon_out(o)
	local x1 = o:x()
	local y1 = o:y()
	
	--coordinates for hidden position
	local x2 = 50 --self._master_weapon_panel:w() - 100 --self._ws:panel():right() - 100
	local y2 = 0 --self._ws:panel():top() + 100
	local x3 = x2 - x1
	local y3 = y2 - y1
	local t = 0
	local duration = 0.25 --seconds to occur
	local x_r = 0.5
	local y_r = 2
	local x_p,y_p = 0,0
	while t <= duration do 
		t = t + coroutine.yield()
		x_p = math.min(math.pow(t/duration,x_r),1)
		y_p = math.min(math.pow(t/duration,y_r),1)
		o:set_x(x1 + (x3 * x_p))
		o:set_y(y1 + (y3 * y_p))
	end

end

function NobleHUD:animate_switch_weapon_in(o)
	local x1 = o:x()
	local y1 = o:y()
	
	--coordinates for main position
	local x2 = 0
	local y2 = 72
	local x3 = x2 - x1
	local y3 = y2 - y1
	local t = 0
	local duration = 0.25 --seconds to occur
	local x_r = 0.5
	local y_r = 2
	local x_p,y_p = 0,0
	while t <= duration do 
		t = t + coroutine.yield()
		x_p = math.min(math.pow(t/duration,x_r),1)
		y_p = math.min(math.pow(t/duration,y_r),1)
		o:set_x(x1 + (x3 * x_p))
		o:set_y(y1 + (y3 * y_p))
	end


end
	
	
--		FLOATING MAG INDICATOR

function NobleHUD:_create_floating_ammo(hud)
	local floating_ammo_panel = hud:panel({
		name = "floating_ammo_panel",
		h = 50,
		w = 100,
		visible = false --disabled for now
	})
	local margin = 4
	local bg = floating_ammo_panel:rect({
		name = "bg",
		color = Color.black,
		alpha = 0.3,
		layer = 1
	})
	local label = floating_ammo_panel:text({
		name = "magazine",
		text = "69/420",
--		vertical = "center",
--		align = "center",
		x = margin/2,
		y = margin/2,
		font = tweak_data.hud_players.ammo_font,
		font_size = 16,
		layer = 3
	})
	self._floating_ammo_panel = floating_ammo_panel
end

function NobleHUD:SetFloatingAmmo(current,total)
	local margin = 4
	local magazine = self._floating_ammo_panel:child("magazine")
	if not (current and total and self:IsFloatingAmmoPanelEnabled()) then 
		return
	end
	magazine:set_text(tostring(current) .. "/" .. tostring(total))
	if current == 0 then 
		magazine:set_color(self.color_data.hud_vitalsfill_red)
	elseif current < total / 3 then
		magazine:set_color(self.color_data.hud_vitalsfill_yellow)
	else
		magazine:set_color(Color.white)
	end
	local x,y,w,h = magazine:text_rect()
	self._floating_ammo_panel:set_w(w + margin)
	self._floating_ammo_panel:set_h(h + margin)
	
end


	-- FIREMODE

function NobleHUD:_hide_firemode(slot,firemode)
	self:_get_crosshair_by_info(slot,firemode):set_visible(false)
end

function NobleHUD:_show_firemode(slot,firemode)
	self:_get_crosshair_by_info(slot,firemode):set_visible(true)
end

function NobleHUD:_set_firemode(slot,firemode,in_burst_mode)
	self:_get_crosshair_by_info(slot,"single"):set_visible(false)
	self:_get_crosshair_by_info(slot,"auto"):set_visible(false)
	self:_get_crosshair_by_info(slot,"underbarrel"):set_visible(false)
	self:_get_crosshair_by_info(slot,firemode):set_visible(true)

	local panel = slot == 1 and self._primary_weapon_panel or self._secondary_weapon_panel
	if in_burst_mode then 
		panel:child("firemode_indicator"):set_visible(false)
	elseif firemode == "auto" then 
		panel:child("firemode_indicator"):set_visible(true)
	else --single
		panel:child("firemode_indicator"):set_visible(false)
	end
end


	-- SAFETY
	
function NobleHUD:is_safety_engaged(slot)
	return self.weapon_data[slot].safety
end

function NobleHUD:_set_weapon_safety(slot,safety_engaged)
	self.weapon_data[slot].safety = safety_engaged
end

function NobleHUD:set_weapon_safety(slot,safety_engaged)
	if safety_engaged == nil then 
		safety_engaged = not self.weapon_data[slot].safety
	end
	self:_set_weapon_safety(slot,safety_engaged)
	local panel
	if slot == 1 then 
		panel = self._secondary_weapon_panel
	else
		panel = self._primary_weapon_panel
	end
	panel:child("safety_indicator"):set_visible(safety_engaged)
end


--		CROSSHAIR

function NobleHUD:_create_crosshair(hud)
	if alive(hud:child("crosshair_panel")) then 
		hud:remove(hud:child("crosshair_panel"))
	end
	--master panel
	local crosshair_panel = hud:panel({
		name = "crosshair_panel",
		alpha = 1 --applies to all crosshairs; todo use setting
	})
	self._crosshair_panel = crosshair_panel
	crosshair_panel:set_center(hud:w()/2,hud:h()/2)
	
	local debug_crosshair = crosshair_panel:rect({
		color = Color.yellow,
		visible = false,
		alpha = 0.1
	})
	local crosshair_slot1 = crosshair_panel:panel({
		name = "crosshair_slot1"
	})
	local slot1_single = crosshair_slot1:panel({
		name = "single",
		visible = false

	})
	local slot1_auto = crosshair_slot1:panel({
		name = "auto",
		visible = false

	})
	local slot1_underbarrel = crosshair_slot1:panel({
		name = "underbarrel",
		visible = false

	})
	
	local crosshair_slot2 = crosshair_panel:panel({
		name = "crosshair_slot2"
	})
	local slot2_single = crosshair_slot2:panel({
		name = "single",
		visible = false

	})
	local slot2_auto = crosshair_slot2:panel({
		name = "auto",
		visible = false

	})
	local slot2_underbarrel = crosshair_slot2:panel({
		name = "underbarrel",
		visible = false

	})
	
	local crosshair_slot3 = crosshair_panel:panel({ --melee
		name = "crosshair_slot3",
		visible = false
	})
	local slot3_melee = crosshair_slot3:bitmap({
		name = "melee",
		layer = 1,
		w = 6,
		h = 6,
		color = Color.white,
		texture = "guis/textures/ability_circle_outline",
	})
	slot3_melee:set_center(crosshair_panel:w()/2,crosshair_panel:h()/2)
--		"guis/textures/crosshair_circle_128",
	--[[
	local crosshair_1 = crosshair_primary:bitmap({
		name = "crosshair_1",
		texture = "guis/textures/crosshair_circle_128",
		layer = 2,
		color = Color.white,
		w = 64,
		h = 64,
		visible = true,
--		blend_mode = "add",
		alpha = 0.5
	})
	
	--crosshair subparts for reticle bloom
	local crosshair_2 = crosshair_panel:bitmap({
		name = "crosshair_2",
		texture = "guis/textures/bullet_tick",
		layer = 2,
		rotation = 0,
		color = Color.white,
		w = 10,
		h = 10,
		visible = true,
		alpha = 0.5
	})
	local cross_circle_64 = crosshair_panel:bitmap({
		name = "crosshair_circle_64",
		texture = "guis/textures/crosshair_circle_64",
		layer = 2,
		color = Color.white,
		w = 64,
		h = 64,
		blend_mode = "add",
		alpha = 0.5
	})
	crosshair_1:set_center(crosshair_panel:w()/2,crosshair_panel:h()/2)
	--]]
	
	
	
end

function NobleHUD:_get_crosshair_data_by_type(type,use_fallback)
	return self._crosshair_textures[type or ""] or (use_fallback and (self._crosshair_textures[tostring(use_fallback)] or self._crosshair_textures["plasma_pistol"]))
end

--todo user prefs
function NobleHUD:_get_crosshair_type_from_weapon_base(base,fire_mode)
--	if true then return "dmr" end
--	local categories = weapon and weapon:base() and weapon:base():categories()
--		if weapon:is_category(cat) then 
	--todo determine whether to use AR type or DMR type
		--firemode?
		--rof? 
		--accuracy?
		--[[
	local player = managers.player:local_player() 
	local inventory = player:inventory()
	local weapons = inventory:available_selections()
	base = base or (weapons[slot] and weapons[slot].unit:base())
	--]]
	if not base then 
		self:log("ERROR: _get_crosshair_type_from_weapon_base(" .. concat({base,slot},",") .. "): bad base/slot")
		return
	end
	local tweakdata = base:weapon_tweak_data()
	
	local override = self._crosshair_override_data[weapon_id]
	local override_result = override and crosshair_from_category(override,fire_mode)
	if override_result then 
		return override_result
	end
	
	local categories = base:categories()
	local function crosshair_from_category(cat,mode)
		if cat == "assault_rifle" then 
			if (mode == "single") then
		
--				if ((base:fire_mode() == "single") and (base:can_toggle_firemode()) and not base._locked_firemode) or (tweakdata.stats.spread > 15) then
			
			--(tweakdata.single or tweakdata.auto or (tweakdata.fire_mode_data and tweakdata.fire_mode_data.fire_rate)) then 
				return "dmr"
			else
				return "assault_rifle"
			end
		elseif cat == "smg" then 
			return "assault_rifle"
		elseif cat == "shotgun" then 
			return "shotgun"
		elseif cat == "lmg" then 
			return "plasma_pistol"
		elseif cat == "snp" then 
			return "sniper"
		elseif cat == "rocket" then
			return "rocket"
		elseif cat == "minigun" then
			return "dmr"
		elseif cat == "flamethrower" then 
			return "flamethrower"
		elseif cat == "saw" then 
			return "needler"
		elseif cat == "grenade_launcher" then 
			return "grenade_launcher"
		elseif cat == "pistol" then -- or cat == "revolver" then 
			return "pistol"
		elseif cat == "bow" then 
			return "sniper"
		elseif cat == "xbow" then 
			return "plasma_launcher"
		end		
	end

	if base:gadget_overrides_weapon_functions() then 
		
		--get weapon type from gadget
	else
		--todo get user settings for weapon categories to crosshair types
		
		for _,category in pairs(categories) do 
			local crosshair_result = crosshair_from_category(category,fire_mode)
			if crosshair_result then 
				return crosshair_result
			end
		end
	end
	return "plasma_pistol"
end

function NobleHUD:create_modepanel(slot,slotpanel,mode) --not actually used
	if not slot then 
		self:log("ERROR: create_modepanel(" .. tostring(slot) .. "): bad slot")
	end
	slotpanel = slotpanel or self._crosshair_panel:child("crosshair_slot" .. slot)
	
	if alive(slotpanel:child(mode)) then 
		slotpanel:remove(slotpanel:child(mode))
	end
	local modepanel = slotpanel:panel({
		visible = false, --should be hidden by default; set visible again if mode matches current
		name = mode
	})
	modepanel:hide()
	return modepanel
end

function NobleHUD:_create_custom_crosshairs(slot,base)
	if not slot then 
		self:log("ERROR: _create_custom_crosshairs(" .. self.table_concat({slot,base}) .. "): bad slot")
		return
	end
	if not base then
		self:log("ERROR: _create_custom_crosshairs(" .. self.table_concat({slot,base}) .. "): bad weapon base")
		return
	end

	local crosshair_panel = self._crosshair_panel
	local slotpanel = crosshair_panel:child("crosshair_slot" .. slot)
	
--create individual crosshair subpart
	local function create_bitmap(index,panel,data)
		if not data then return end
		local x = data.x or 0
		local y = data.y or 0
		local angle = data.angle or data.rotation
		if data.distance and angle then 
			x = x + math.sin(angle) * data.distance
			y = y + -math.cos(angle) * data.distance
		end
		if alive(panel:child(tostring(index))) then 
			panel:remove(panel:child(tostring(index)))
		end
		local bitmap = panel:bitmap({
			name = tostring(index),
			texture = data.texture,
			texture_rect = data.rect,
			x = x,
			y = y,
			rotation = data.rotation,
			w = data.w,
			h = data.h,
			alpha = data.alpha,
			blend_mode = data.blend_mode,
			color = data.color,
			render_template = data.render_template
		})
		bitmap:set_center(bitmap:x() + (crosshair_panel:w()/2),bitmap:y() + (crosshair_panel:h()/2))
		return bitmap
	end
	
	local function create_crosshair (_base,_firemode)
--		local modepanel = self:_get_crosshair_by_info(slot,_firemode)
		local modepanel = slotpanel:child(_firemode)
		local crosshair_type = self:_get_crosshair_type_from_weapon_base(_base,_firemode)
		local crosshair_data = self:_get_crosshair_data_by_type(crosshair_type,true)
		if not crosshair_data then 
			self:log("ERROR: _create_custom_crosshairs(" .. tostring(slot) .. "," .. tostring(base) .. "): No crosshair data! (" .. crosshair_type .. "," .. _firemode)
		end
		crosshair_data = crosshair_data or self:_get_crosshair_data_by_type("plasma_rifle")
		self.weapon_data[slot][_firemode].weapon_type = crosshair_type
		for i,part_data in pairs(crosshair_data.parts) do 
			local _bitmap = create_bitmap(i,modepanel,part_data)
			if crosshair_data.special_crosshair then 
				self:create_special_crosshair(crosshair_data.special_crosshair,modepanel,_bitmap:w() or _bitmap:texture_width(),_bitmap:h() or _bitmap:texture_height())
			end
			self.weapon_data[slot][_firemode].num_parts = i
		end
	end
	
	local firemode_current = base:fire_mode()
	local gadgetbase = base:gadget_overrides_weapon_functions()
	if gadgetbase then
		create_crosshair(gadgetbase,"underbarrel")
	end
	
	if base:can_toggle_firemode() and not base._locked_firemode then
		create_crosshair(base,"single")
		create_crosshair(base,"auto")
	else
		create_crosshair(base,firemode_current)
	end	
	
	if alive(slotpanel:child(firemode_current)) then 
		slotpanel:child(firemode_current):set_visible(true)
	end
end

function NobleHUD:create_special_crosshair(type,panel,w,h)
	if type == "altimeter" then
		if alive(panel:child("altimeter_frame")) then 
			panel:remove(panel:child("altimeter_frame"))
		end
		local altimeter_frame = panel:panel({
			x = (self._crosshair_panel:w() - w) / 2,
			y = (self._crosshair_panel:h() - h) / 2,
			w = w,
			h = h,
			name = "altimeter_frame"
		})
		altimeter_frame:rect({
			color = Color.blue,
			alpha = 0.0
		})
		local window_size = 720
		local altimeter_h = h * 4
		local altimeter_slide = altimeter_frame:panel({
--			w = w, 
			h = altimeter_h, --todo get altimeter bitmap value * size setting 
			name = "altimeter_slide"
		})
		altimeter_slide:rect({
			color = Color.red,
			alpha = 0.0
		})
		local angle_span = 180 -- +90 up, -90 down --> 90 * 2 = 180
		local tick_interval_s = 1 --small line
		local tick_interval_m = 5 --large line
		local tick_interval_l = 15 --text label
		local tick_h = 1
		local tick_w_s = 4
		local tick_w_m = 6
		local tick_w_l = 12
		local font_size = 12
		for j = 0,angle_span * 2 do
			local i = (angle_span - j)
			local y = (j/(angle_span * 2)) * altimeter_h
			if j % tick_interval_l == 0 then 
				altimeter_slide:text({
					name = "interval_l_" .. tostring(i),
					text = tostring(i),
--					align = "right",
--					x = - 20,
					font = tweak_data.hud_players.ammo_font,
					font_size = font_size,
					x = tick_w_l + 2,
					y = y - (font_size / 2)
				})
				altimeter_slide:bitmap({
					name = "interval_l_" .. tostring(i),
					texture = "guis/textures/test_blur_df",
					w = tick_w_l,
					h = tick_h,
					alpha = 0.5,
					y = y
				})
			elseif j % tick_interval_m == 0 then 
				altimeter_slide:bitmap({
					name = "interval_m_" .. tostring(i),
					texture = "guis/textures/test_blur_df",
					w = tick_w_m,
					h = tick_h,
					alpha = 0.5,
					y = y
				})
			elseif j % tick_interval_s == 0 then
				altimeter_slide:bitmap({
					name = "interval_s_" .. tostring(i),
					texture = "guis/textures/test_blur_df",
					w = tick_w_s,
					h = tick_h,
					alpha = 0.5,
					y = y
				})
			end
		end
		self._altimeter = altimeter_frame
	end
end

function NobleHUD:_set_crosshair_altimeter(angle)
	local a = self._altimeter
	if alive(a) then 
		if alive(a:child("altimeter_slide")) then
			local b = (
			(angle / 90) * 160
			)
			+ (-3 * (160 / 2) )
--			(angle / 30) * self._ws:panel():h()
--			)
--			+ (- self._ws:panel():h() / 1)
			
--			(angle * self._ws:panel():h() / 90)
--			- (360 * 1.5)
			--((angle + 90)/90) * (self._ws:panel():h()/2) --((angle+90)/180) * (self._ws:panel():h()/2) --
			a:child("altimeter_slide"):set_y(b)
--			Console:SetTrackerValue("trackerb",tostring(b))
--			Console:SetTrackerValue("trackerc",tostring(angle))
		end
	end
if true then return end

	local modepanel = self:get_current_crosshair()
	if modepanel and alive(modepanel) then 
		local frame = modepanel:child("altimeter_frame")
		if frame and alive(frame) then
			local altimeter = frame and frame:child("altimeter_slide")
			if alive(altimeter) then 
				altimeter:set_y((angle + 90) * 360)  --todo get angle_span from settings
			end
		end
	end
end

function NobleHUD:is_weapon_crosshair_override_present(id)
	return self._crosshair_override_data[id]
end

function NobleHUD:_set_crosshair_in_slot_visible(slot,visible)
--if slot and visible is specified, crosshair in that slot only is set to value [visible]
--else, if only slot is specified, crosshair in that slot is set visible, and other crosshair is set invisible
	if visible ~= nil then 
		
		local crosshair = self._crosshair_panel:child("crosshair_slot" .. tostring(slot))
		if alive(crosshair) then 
			crosshair:set_visible(visible)
		else
			return
		end
	else
		for i,j in pairs(managers.player:local_player():inventory():available_selections()) do 
			local slotpanel = self._crosshair_panel:child("crosshair_slot" .. tostring(i))
			if alive(slotpanel) then 
				slotpanel:set_visible(i == slot)
			end
		end
	end
end

function NobleHUD:_set_crosshair_bloom(bloom)
	local slot,firemode = self:get_slot_and_firemode()
	slot = slot or 1
	firemode = firemode or ""
	local weapon_data = self.weapon_data[slot] and self.weapon_data[slot][firemode]
	local weapon_type = weapon_data and weapon_data.weapon_type
	local crosshair_data = self._crosshair_textures[weapon_type] or {}
	local data = {bloom = bloom,crosshair_data = crosshair_data}
	local a = crosshair_data.bloom_func
	
	self:get_current_crosshair_parts(a,data or {})
end

function NobleHUD:_add_weapon_bloom(amount)
	if self:IsCrosshairBloomEnabled() then 
		self.weapon_data.bloom = math.clamp(self.weapon_data.bloom + amount,0,1)
	end
end

function NobleHUD:_add_weapon_bloom_by_type(type)
	local bloom_mul = self._bloom_table[type] or 1
	self:_add_weapon_bloom(bloom_mul)
end

--some assembly required
function NobleHUD:_set_crosshair_color(color)
	local function a(index,bitmap,data)
		bitmap:set_color(data.color)
	end
	self:get_current_crosshair_parts(a,{color = color})
end

function NobleHUD:_get_crosshair_by_info(slot,mode)
	if not (slot and mode) then 
		self:log("ERROR: _get_crosshair_by_info(" .. self.table_concat({slot,mode},",") .. "): bad slot/mode")
		return
	end
	local slotpanel = self._crosshair_panel:child("crosshair_slot" .. tostring(slot))
	if not slotpanel then 
		self:log("ERROR: _get_crosshair_by_info(" .. self.table_concat({slot,mode},",") .. "): no slotpanel")
		return
	elseif not slotpanel:child(mode) then 
		self:log("ERROR: _get_crosshair_by_info(" .. self.table_concat({slot,mode},",") .. "): no modepanel")
		return
	end
	return slotpanel and slotpanel:child(mode)
end

function NobleHUD:get_slot_and_firemode()

	local player = managers.player:local_player()
	local inventory = player and player:inventory()
	if not inventory then 
		self:log("ERROR: get_slot_and_firemode(): no inventory")
		return
	end
	local slot = inventory:equipped_selection()
	local weapons = inventory:available_selections()
	local weapon = weapons[slot]
	local base = weapon and weapon.unit and weapon.unit:base()
	if not base then 
--		self:log("ERROR: get_slot_and_firemode(): no base")
		return
	end
	local firemode = base:fire_mode()
	if base:gadget_overrides_weapon_functions() then 
		firemode = "underbarrel"
	end
	
	return slot,firemode
end

function NobleHUD:get_current_crosshair() --returns panel; semiobsolete now
	local slot,firemode = self:get_slot_and_firemode()
	return self:_get_crosshair_by_info(slot,firemode) --todo don't return the ingredients too lol
end

--iterates through current bitmaps and runs func with args ([index],bitmap,...); returns table of bitmaps
function NobleHUD:get_current_crosshair_parts(func,...)
	local result = {}
	
	local slot,mode_name = self:get_slot_and_firemode()
	local modepanel = self:_get_crosshair_by_info(slot,mode_name)
	--	self:get_current_crosshair()

	if alive(modepanel) then 
		for i=1,(self.weapon_data[slot][mode_name].num_parts or 1) do 
			local bitmap = modepanel:child(tostring(i))
			if func and alive(bitmap) then 
				func(i,bitmap,...)
			end
			result[i] = bitmap
		end
		return result
	end
end


--		GRENADES

function NobleHUD:_create_grenades(hud)
	--grenades
	local grenades_panel = hud:panel({
		name = "grenades_panel",
		x = 30,
		y = 32,
		w = 64,
		h = 64
	})
	
	self._grenades_panel = grenades_panel
	local primary_grenade_panel = grenades_panel:panel({
		name = "primary_grenade_panel"
	})
	
	local secondary_grenade_panel = grenades_panel:panel({ --this one can be used for deployables if the player so chooses
		name = "secondary_grenade_panel",
		visible = false
	})
	local icon_size = 32
	local function add_grenade(panel)
		local grenade_icon = panel:bitmap({
			name = "grenade_icon",
			texture = "guis/textures/crosshair_circle",
			layer = 2,
			color = self.color_data.hud_bluefill,
			w = icon_size,
			h = icon_size,
			blend_mode = "add",
			alpha = 0.75,
			x = 0,
			y = 0
		})
		local grenade_label = panel:text({
			name = "grenade_label",
			text = "3", --used for count by default
			layer = 3,
			align = "right",
			color = Color.white,
--			visible = false,
			font = "fonts/font_eurostile_ext",
			font_size = 24
		})
		local grenade_outline = panel:bitmap({
			name = "grenade_outline",
			texture = "guis/textures/ability_circle_outline",
			render_template = "VertexColorTexturedRadial",
			layer = 2,
			color = Color.white,
			w = icon_size * 2,
			h = icon_size * 2,
			alpha = 0.8,
			visible = false, --! temporarily disabled /!\ 
			x = 0,
			y = 0
		})
		grenade_outline:set_center(panel:w() / 2, panel:h() / 2)
		grenade_icon:set_center(panel:w() / 2, panel:h() / 2)
		return grenade_icon,grenade_label,grenade_outline
	end
	
	local primary_grenade_icon,primary_grenade_label,primary_grenade_outline = add_grenade(primary_grenade_panel)
	local secondary_grenade_icon,secondary_grenade_label,secondary_grenade_outline = add_grenade(secondary_grenade_panel)
	
	
	local debug_grenades = grenades_panel:rect({
		color = Color.blue,
		visible = false,
		alpha = 0.1
	})
end

function NobleHUD:_set_grenades(data)
	if PlayerBase.USE_GRENADES then
		local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon, {
			0,
			0,
			32,
			32
		})
		local grenades_panel = self._grenades_panel:child("primary_grenade_panel")
		local grenade_icon = grenades_panel:child("grenade_icon")
		if data.amount then 
			local grenade_label = grenades_panel:child("grenade_label")
			grenade_label:set_text(tostring(data.amount))
		end

		grenade_icon:set_visible(true)
		grenade_icon:set_image(icon, unpack(texture_rect))
	end
end

function NobleHUD:_set_grenades_amount(amount)
	amount = amount or -1
	if PlayerBase.USE_GRENADES then 
		local grenades_panel = self._grenades_panel:child("primary_grenade_panel")
		if amount then 
			local grenade_label = grenades_panel:child("grenade_label")
			grenade_label:set_text(tostring(amount))
			if amount <= 0 then 
				grenade_label:set_color(Color(0.5,0.5,0.5))
			else
				grenade_label:set_color(Color.white)
			end
		end
	end
end

function NobleHUD:_set_grenade_cooldown(data)

	local grenades_panel = self._grenades_panel:child("primary_grenade_panel")
	local grenades_outline = grenades_panel:child("grenade_outline")

	local end_time = data and data.end_time
	local duration = data and data.duration
	
	if not end_time or not duration then
		grenades_outline:stop()
		grenades_outline:set_color(Color(0.5, 0, 1, 1))

		return
	end

	local function animate_radial(o)
		repeat
			local now = managers.game_play_central:get_heist_timer()
			local time_left = end_time - now
			local progress = 1 - time_left / duration

			o:set_color(Color(0.5, progress, 1, 1))
			coroutine.yield()
		until time_left <= 0

	end

	grenades_outline:stop()
	grenades_outline:animate(animate_radial)

end

function NobleHUD:_activate_ability_radial(time_left,time_total)
	local grenades_panel = self._grenades_panel:child("primary_grenade_panel")
	local grenades_outline = grenades_panel:child("grenade_outline")
	grenades_outline:set_visible(true)
	grenades_outline:set_color(Color(time_left/time_total,time_total,0))
end


--		DEPLOYABLES

function NobleHUD:_create_ability(hud) --armor ability slot?
	local ability_master = hud:panel({
		name = "ability_panel", --master panel
		w = 72,
		h = 60,
		x = 8,
		y = hud:bottom() - 286
	}) --formerly 96 x 96
	local panel_size = 48
	local icon_size = panel_size * 2/3
	local primary_ability_panel = ability_master:panel({
		name = "primary_ability_panel",
		visible = false,
		w = panel_size,
		h = panel_size,
		x = ability_master:w() - panel_size,
		y = panel_size * 0.25,
		layer = 2
	})
	local secondary_ability_panel = ability_master:panel({
		name = "secondary_ability_panel",
		visible = false,
		w = panel_size,
		h = panel_size,
		y = ability_master:h() - panel_size,
		layer = 1
	})
	
	local function create_ability(panel)
		local ability_outline = panel:bitmap({
			name = "ability_outline",
			texture = "guis/textures/ability_circle_outline",
			w = panel_size,
			h = panel_size,
			layer = 3,
--			alpha = 0.7,
			visible = true,
			color = self.color_data.hud_vitalsoutline_blue
		})
		local ability_fill = panel:bitmap({
			name = "ability_fill",
			texture = "guis/textures/ability_circle_fill",
			w = panel_size,
			h = panel_size,
			layer = 2,
			--		alpha = 0.5,
			color = self.color_data.hud_vitalsfill_blue
		})
		
		local ability_icon = panel:bitmap({
			name = "ability_icon",
			texture = "guis/textures/ability_icon",
			visible = true,
			w = icon_size,
			h = icon_size,
			layer = 4,
--			alpha = 0.8,
			color = self.color_data.hud_vitalsoutline_blue
		})
		local ability_label = panel:text({
			name = "ability_label",
			text = "3",
			visible = true,
			align = "right",
			vertical = "bottom",
			layer = 5,
			color = Color.white,
			font = "fonts/font_eurostile_ext",
			font_size = 24
		})
		return ability_outline,ability_fill,ability_icon,ability_label
	end
	
	local secondary_outline,secondary_fill,secondary_icon,secondary_label = create_ability(secondary_ability_panel)
	local primary_outline,primary_fill,primary_icon,primary_label = create_ability(primary_ability_panel)
	local c_x = panel_size / 2
	local c_y = panel_size / 2
	primary_icon:set_center(c_x,c_y)
	secondary_icon:set_center(c_x,c_y)
	
	self._ability_panel = ability_master
	local debug_ability = ability_master:rect({
		color = Color.red,
		visible = false,
		alpha = 0.1
	})
end

function NobleHUD:animate_switch_eq_out(o)
	--coordinates for hidden position
	local x2 = 0
	local y2 = self._ability_panel:h() - o:h() -- formerly -48
	
	local x1 = o:x()
	local y1 = o:y()
	local x3 = x2 - x1
	local y3 = y2 - y1
	local t = 0
	local duration = 0.25 --seconds to occur
	local x_r = 0.5
	local y_r = 2
	local x_p,y_p = 0,0
	while t <= duration do 
		t = t + coroutine.yield()
		x_p = math.min(math.pow(t/duration,x_r),1)
		y_p = math.min(math.pow(t/duration,y_r),1)
		o:set_alpha(1 - (0.6 * y_p))
		o:set_x(x1 + (x3 * x_p))
		o:set_y(y1 + (y3 * y_p))
	end

end

function NobleHUD:animate_switch_eq_in(o)
	--coordinates for main position
	local x2 = self._ability_panel:w() - o:w() --formerly 48
	local y2 = 0
	
	local x1 = o:x()
	local y1 = o:y()
	
	local x3 = x2 - x1
	local y3 = y2 - y1
	local t = 0
	local duration = 0.25 --seconds to occur
	local x_r = 0.5
	local y_r = 2
	local x_p,y_p = 0,0
	while t <= duration do 
		t = t + coroutine.yield()
		x_p = math.min(math.pow(t/duration,x_r),1)
		y_p = math.min(math.pow(t/duration,y_r),1)
		o:set_alpha(0.4 + (0.6 * x_p))
		o:set_x(x1 + (x3 * x_p))
		o:set_y(y1 + (y3 * y_p))
	end


end
	
function NobleHUD:_set_deployable_amount(index)
	index = index or managers.player._equipment.selected_index
	local eq = managers.player._equipment.selections[index]--managers.player:selected_equipment()
	if eq then
		--todo setting for ability vs grenade panel
		local ability_panel
		if index == 1 then
			ability_panel = self._ability_panel:child("primary_ability_panel")
		elseif index == 2 then 
			ability_panel = self._ability_panel:child("secondary_ability_panel")
		end
		if alive(ability_panel) then 
			local label = ability_panel:child("ability_label")
			if eq.amount then 
				local str = ""
				local amount_1,amount_2 = 9,9
				if eq.amount[1] then 
					amount_1 = Application:digest_value(eq.amount[1],false)
					str = amount_1
				end
				if eq.amount[2] then 
					amount_2 = Application:digest_value(eq.amount[2],false)
					str = str .. " | " .. amount_2
				end
				label:set_text(str)
				if math.max(amount_1,amount_2) > 0 then 
					label:set_color(Color.white)
				else
					label:set_color(Color(0.5,0.5,0.5))
				end
			end
		end
	end
end

function NobleHUD:_set_deployable_equipment(index,skip_anim)
	index = index or managers.player._equipment.selected_index
	local eq = managers.player._equipment.selections[index]--managers.player:selected_equipment()
	if eq then
		local icon,texture_rect = tweak_data.hud_icons:get_icon_data(eq.icon)
		--todo setting for ability vs grenade panel
		local ability_panel,ability_panel_2
		if index == 1 then
			ability_panel = self._ability_panel:child("primary_ability_panel")
			ability_panel_2 = self._ability_panel:child("secondary_ability_panel")
		elseif index == 2 then 
			ability_panel = self._ability_panel:child("secondary_ability_panel")
			ability_panel_2 = self._ability_panel:child("primary_ability_panel")
		end
		if alive(ability_panel) then 
			ability_panel:child("ability_icon"):set_image(icon,unpack(texture_rect))
			ability_panel:set_visible(true)
			if eq.amount then 
				local str = ""
				if eq.amount[1] then 
					str = Application:digest_value(eq.amount[1],false)
				end
				if eq.amount[2] then 
					str = str .. " | " .. Application:digest_value(eq.amount[2],false)
				end
--				local str = tostring((amount_1 and (amount_1 .. " | ") or "") .. tostring(amount_2 or ""))
				if not skip_anim then 
					ability_panel:stop()
					ability_panel:animate(callback(self,self,"animate_switch_eq_in"))
					ability_panel:child("ability_label"):set_text(str)
				end
--				ability_panel:set_alpha(1)
--				ability_panel:child("ability_outline"):set_alpha(0.7)
--				ability_panel:child("ability_icon"):set_alpha(0.8)
			end
		end
		if alive(ability_panel_2) then 
			if not skip_anim then 
				ability_panel_2:stop()
				ability_panel_2:animate(callback(self,self,"animate_switch_eq_out"))
			end
--			ability_panel_2:set_alpha(0.3)
--			ability_panel_2:child("ability_outline"):set_alpha(0.3)
--			ability_panel_2:child("ability_icon"):set_alpha(0.4)
		end
	end
end


--		STAMINA	
	
function NobleHUD:_create_stamina(hud)
	local icon_size = 48
	local stamina_panel = hud:panel({
		name = "stamina_panel",
		w = icon_size,
		h = icon_size,
		alpha = 0,
		x = 0,
		y = 330
--		x = 170,
--		y = 430
	})
	
	local stamina_outline = stamina_panel:bitmap({
		name = "stamina_outline",
		texture = "guis/textures/ability_circle_outline",
		w = icon_size,
		h = icon_size,
		render_template = "VertexColorTexturedRadial",
		layer = 4
--		color = self.color_data.hud_vitalsoutline_blue
	})
	
	local stamina_fill = stamina_panel:bitmap({
		name = "stamina_fill",
		texture = "guis/textures/ability_circle_fill",
		w = icon_size,
		h = icon_size,
		layer = 2,
		color = self.color_data.hud_vitalsoutline_blue 
	})
	
	local stamina_icon = stamina_panel:bitmap({
		name = "stamina_icon",
		texture = "guis/textures/pd2/skilltree/icons_atlas",
		texture_rect = {
			1 * 64, --or 7, 3
			8 * 64,
			64,
			64
		},
		w = 32,
		h = 32,
		layer = 3,
		color = self.color_data.hud_vitalsfill_blue
	})
	stamina_icon:set_center(icon_size/2,icon_size/2)
	
	self._stamina_panel = stamina_panel
	local debug_stamina = stamina_panel:rect({
		color = Color.red,
		visible = false,
		alpha = 0.1
	})
end

function NobleHUD:SetStamina(current,total)
	local player = managers.player:local_player()
	local stamina_panel = self._stamina_panel
	if not self:IsStaminaEnabled() then 
		return
	end
	if current and alive(player) then 
		local movement = player:movement()
		local total = total or movement:_max_stamina()
		local progress = current/total
		stamina_panel:child("stamina_outline"):set_color(Color(progress,1,1))
		if total - current <= 0.001 then 
			self:animate(stamina_panel,"animate_fadeout_linear",nil,0.75)
--			stamina_panel:set_alpha(math.max(stamina_panel:alpha() - managers.player:player_timer():delta_time(),0))
		elseif stamina_panel:alpha() < 1 then 
--			self:animate(stamina_panel,"animate_fadein",nil,0.75)
			stamina_panel:set_alpha(math.clamp(stamina_panel:alpha() * 1.3,0.001,1))
		end
		
		if movement:is_above_stamina_threshold() then 
			stamina_panel:child("stamina_icon"):set_color(self.color_data.hud_bluefill)
			stamina_panel:child("stamina_fill"):set_color(self.color_data.hud_blueoutline)
		else
			stamina_panel:child("stamina_fill"):set_color(Color(0.3,0.3,0.3))
			stamina_panel:child("stamina_icon"):set_color(Color(0.6,0.6,0.6))
		end
	end
end


--		TEAMMATES

function NobleHUD:_create_teammates(hud)
	local num_teammates = 4

	local teammates_panel = hud:panel({
		name = "teammates_panel",
		w = 256,
		h = 256, -- num_teammates * teammate_h,
		x = 100,
		y = 0-- hud:h() - 256
	})
	self._teammates_panel = teammates_panel

	local teammates_debug = teammates_panel:rect({
		name = "teammates_debug",
		visible = false,
		color = Color.blue,
		alpha = 0.4
	})
	

	
	for i=1,num_teammates do 
		self:_create_teammate_panel(teammates_panel,i)
	end
	
	return teammates_panel
end

function NobleHUD:_create_teammate_panel(teammates_panel,i)
	local teammate_w = 200
	local teammate_h = 32
	local panel = teammates_panel:panel({
		name = "teammate_" .. tostring(i),
		y = (i - 1) * teammate_h,
		w = teammate_w,
		h = teammate_h,
		layer = 2
	})
	local callsign_box = panel:panel({
		name = "callsign_box",
		layer = 2,
		w = 75
	})
	local character_bitmap = callsign_box:bitmap({
		name = "character_bitmap",
		layer = 0,
		rotation = 360,
		texture = "guis/textures/teammate_nameplate_vacant",
		color = self.color_data.hud_weapon_color,
		w = 24,
		h = 24,
		y = (teammate_h - (24)) * 0.5
	})
	local player_name = callsign_box:text({
		name = "player_name",
		layer = 1,
		text = "",
		align = "center",
		vertical = "center",
		color = Color.white,
		font_size = tweak_data.hud_players.name_size,
		font = tweak_data.hud_players.name_font
	})
	local a,b = tweak_data.hud_icons:get_icon_data("equipment_thermite")
	local deployable_icon = panel:bitmap({
		name = "deployable_icon",
		layer = 0,
		rotation = 360,
		texture = a,
		texture_rect = b,
		color = self.color_data.hud_blueoutline,
		x = callsign_box:right() + 4,
		w = 32,
		visible = false,
		h = 32
	})
	local deployable_count = panel:text({
		name = "deployable_count",
		layer = 1,
		text = "3",
		x = deployable_icon:right(),
		vertical = "center",
		color = Color.white,
		font_size = tweak_data.hud_players.name_size,
		visible = false,
		font = tweak_data.hud_players.name_font
	})
	
	
	
	local teammate_panel_debug = panel:rect({
		visible = false,
		color = tweak_data.chat_colors[i],
		alpha = 0.4
	})
	return panel
end

function NobleHUD:_add_teammate()

end


function NobleHUD:_sort_teammates(num)
--todo get tracked max teammate count, hide inactive teammates
	local radar = self._radar_panel
	local teammates_panel = self._teammates_panel
	num = num or 4
	teammates_panel:set_x(radar:right() - 16)
	teammates_panel:set_y(radar:y())
	teammates_panel:set_h(radar:h())
	for i=1,num do 
		local ratio = (i - 1) / (num - 1)
		local panel = teammates_panel:child("teammate_" .. i)
		if not alive(panel) then 
			panel = self:_create_teammate_panel(teammates_panel,i)
		end
--		panel:set_x(192 * (0.5 + math.cos((i/4) * math.pi * 2))) --todo get radar size
--		panel:set_x(192 * math.sin(math.deg(((i-1) / (num_teammates - 1))) / (math.pi))) --todo get radar size
		panel:set_x(32 * math.sin(180 * ratio)) --todo get radar size
		panel:set_y(radar:h() * ((i-1) / (num)))
	end
end

function NobleHUD:_set_teammate_callsign(i,id)	
	local panel = self._teammates_panel:child("teammate_" .. tostring(i))
	if (panel and alive(panel)) then
		local color = tweak_data.chat_colors[id or 5] or Color.red
		panel:child("callsign_box"):child("player_name"):set_color(color)
		local bitmap = panel:child("callsign_box"):child("character_bitmap")
		bitmap:set_image("guis/textures/teammate_nameplate")
		bitmap:set_size(100 * 0.75,32 * 0.75)
		bitmap:set_y((panel:h() - bitmap:h()) * 0.5)
		bitmap:set_color(color) --optional
	else
		self:log("ERROR: _add_teammate panel(" .. tostring(i) .. "): Panel does not exist")
		return
	end
end

function NobleHUD:_set_teammate_name(i,player_name)
	local panel = self._teammates_panel:child("teammate_" .. tostring(i))
	if (panel and alive(panel)) then
		panel:child("callsign_box"):child("player_name"):set_text(player_name)
	else
		self:log("ERROR: _add_teammate panel(" .. tostring(i) .. "): Panel does not exist")
		return
	end
end

function NobleHUD:_init_teammate(i,panel,is_player,width)
	if not self._teammates_panel then return end
	local panel = self._teammates_panel:child("teammate_" .. tostring(i))
	if (panel and alive(panel)) then 
		self:log("Tried to _init_teammate")
	else
		self:log("ERROR: _init_teammate panel(" .. tostring(i) .. "): Panel does not exist")
		return
	end
end

function NobleHUD:_add_convert(params)

end


--		SCORE COUNTER

function NobleHUD:_create_score(hud)
self._popups_panel = hud:panel({
	name = "popups_panel"
})

	local margin_w = 4
	local margin_h = 12
	local banner_h = 24
	
	local panel_h = 2 * (margin_h + banner_h)
	local panel_w = 300
	local score_panel = hud:panel({
		name = "score_panel",
		w = panel_w,
		h = panel_h,
		x = hud:w() - panel_w,
		y = hud:h() - panel_h
	})
	local score_debug = score_panel:rect({
		name = "score_debug",
		visible = false,
		color = Color.yellow,
		alpha = 0.1
	})

	
	local banner_w = score_panel:w() - (margin_w + banner_h)
	local score_banner_small = score_panel:bitmap({
		name = "score_banner_large",
		texture = "guis/textures/test_blur_df",
		layer = 1,
		color = Color(0.6,0.6,0.6), --light grey
		y = margin_h,
		w = banner_h,
		h = banner_h,
--		y = score_panel:h() - banner_h,
		alpha = 0.5
	})

	local score_banner_large = score_panel:bitmap({
		name = "score_banner_large",
		texture = "guis/textures/test_blur_df",
		layer = 1,
		color = self.color_data.hud_vitalsfill_blue,--tweak_data.chat_colors[2], --managers.network:session():local_peer():id()], --should be refreshed on load for accuracy
		x = banner_h + margin_w,
		y = margin_h,
		w = banner_w - (banner_h),
		h = banner_h,
--		y = score_panel:h() - banner_h,
		alpha = 0.5
	})
	
	local score_label = score_panel:text({
		name = "score_label",
		text = "0",
		align = "right",
		color = Color.white,
		x = -(banner_h + margin_w),
		y = score_banner_large:y(),
		font = "fonts/font_eurostile_ext",
		font_size = banner_h,
		layer = 5
	})
	local score_multiplier_label = score_panel:text({
		name = "score_multiplier_label",
		text = "2.00x",
		align = "right",
		x = -(margin_w + banner_h),
		color = self.color_data.hud_vitalsoutline_blue,
		font = "fonts/font_eurostile_ext",
		font_size = margin_h,
		layer = 4
	})
	
	local mission_timer = score_panel:text({
		name = "mission_timer",
		text = "04:20",
		align = "left",
		layer = 3,
		x = score_banner_large:x(),
		color = self.color_data.hud_vitalsoutline_blue,
		font = "fonts/font_eurostile_ext",
		font_size = margin_h,
		alpha = 0.9
	})		
	
	local score_icon = score_panel:bitmap({
		name = "score_banner_large",
		texture = "guis/textures/radar_blip_near",
		layer = 3,
		color = Color.white,
		w = banner_h,
		h = banner_h,
		alpha = 0.5
	})
	score_icon:set_center(score_banner_large:h()/2,score_banner_large:y() + margin_h)

	
	self._score_panel = score_panel
end

function NobleHUD:TallyScore(data,unit,medal_multiplier)
	local name = tostring(data.name)
	local score = self:GetRawScoreFromUnitName(name)
	local localized_unitname = managers.localization:text("noblehud_unitname_" .. name)
	local total_multiplier = self:GetTotalScoreMultiplier()
	
	--get global score mult here
	if score then 
--		score = score * global_score_mult
		if (score > 0) then 
			score = score * medal_multiplier
		end
		score = score * total_multiplier
		if self:IsScorePopupsEnabled() then 
			self:CreateScorePopup(localized_unitname,score,unit)
		end
		self:AddScore(score)
		self:SetScoreLabel(NobleHUD.make_nice_number(self._cache.score_session))
	else
		--unit is worth no score, or unit name is wrong
	end
end

function NobleHUD:PopupsEnabled()
	return true
end

function NobleHUD:UpdateScoreTimerMultiplier(t)
	t = t or managers.game_play_central:get_heist_timer()
	
	local mission_timer_mult = self._cartographer_data and self._cartographer_data.map_time_score or self.score_multipliers.time_generic
	--map-specific score timer multipliers aren't implemented so it will always use the default timer
	
	local score_timer_mult
	for _,timer_data in ipairs(mission_timer_mult) do
		if timer_data.threshold > t then 
			score_timer_mult = timer_data.multiplier
			break
		end
	end	
	self._cache.score_timer_mult = score_timer_mult
	return score_timer_mult
end

function NobleHUD:GetTotalScoreMultiplier(mult)
	mult = mult or 1
	
	local difficulty = Global.game_settings and Global.game_settings.difficulty
	local mult_data = self.score_multipliers
	local score_timer_mult = self._cache.score_timer_mult or 1
	
	--[[
	if not self._cache.timer_score_multiplier then 
		local timer = managers.game_play_central:get_heist_timer()
		local mission_timer_mult = self._cartographer_data and self._cartographer_data.map_time_score or mult_data.time_generic	
		for _,timer_data in ipairs(mission_timer_mult) do
			if timer < timer_data.threshold then 
				timer_mult = timer_data.multiplier
				break
			end
		end
		self._cache.timer_score_multiplier = timer_mult
	else
		timer_mult = self._cache.timer_score_multiplier
	end
	--]]
	mult = mult * score_timer_mult
	mult = mult * (mult_data.difficulty[difficulty or "easy"] or 1)
--	local mutators = managers.mutators:mutators()
	--mutator multipliers go here
	return mult
end

function NobleHUD:SetTotalScoreMultiplierDisplay()
	self._score_panel:child("score_multiplier_label"):set_text(string.format("%0.02fx",self:GetTotalScoreMultiplier()))
end

function NobleHUD:GetRawScoreFromUnitName(unit_name)
	return NobleHUD.score_unit_points[unit_name] or 0
end

function NobleHUD:SetScoreLabel(text)
	self._score_panel:child("score_label"):set_text(text)
end

function NobleHUD:AddScore(score)
	self._cache.score_session = self._cache.score_session + (tonumber(score) or 0)
end

function NobleHUD:CreateScorePopup(name,score,unit)
	local text
	local color 
	if score < 0 then 
		text = string.format("%i",score)
		color = Color.red
	else
		text = "+" .. string.format("%i",score)
		color = Color.white
	end
	if self:ScorePopupShowsUnitName() then 
		text = text .. " " .. name
	end
	
	local popups_panel = self._popups_panel
	local font_size = self:GetPopupFontSize()
	
	local popup = popups_panel:text({
		name = "popup_" .. tostring(self._cache.score_popups_count),
		layer = 1,
		text = text,
		x = self._popup_start_x,
		y = self._popup_start_y + ((font_size + 2) * (#self._cache.score_popups + 1)),
		font = "fonts/font_large_mf",
		font_size = font_size,
		alpha = 0,
		color = color
		
	})
	self._cache.score_popups_count = self._cache.score_popups_count + 1
	
	local style = self:GetPopupStyle()
	
	table.insert(self._cache.score_popups,{
		popup = popup,
		style = style,
		unit = unit,
		start_t = Application:time()
	})
	if style == "animate_popup_athena" or style == "animate_popup_bluespider" then 
--		popup:set_align("center")
		
		local unit_pos
		if unit and alive(unit) then 
			local movement = unit.movement and unit:movement()
			unit_pos = movement and movement:m_head_pos()
		
			local viewport_cam = managers.viewport:get_current_camera()
			if unit_pos then 
				local screen_pos = self._ws:world_to_screen(viewport_cam,unit_pos)
--				popup:set_center(screen_pos.x,screen_pos.y)
				popup:set_x(screen_pos.x)
				popup:set_y(screen_pos.y)
				
			end
		end
	end
	
--	self:animate(popup,animate_style,nil)
	
end

function NobleHUD:ScorePopupShowsUnitName()
	return true
end

function NobleHUD:_set_mission_timer(text) --hud only
	self._score_panel:child("mission_timer"):set_text(tostring(text))
end

function NobleHUD:set_mission_name(level_name)
	self:_set_mission_name(level_name)
	
	local player_box = self._tabscreen:child("scoreboard")
	local difficulty_index = managers.job:current_difficulty_stars()
	player_box:child("title_box"):child("title_label"):set_text(level_name .. " /// " .. string.rep(self.special_chars.skull .. " ",difficulty_index))
	player_box:child("title_box"):child("title_label_2"):set_text(utf8.to_upper(Global.game_settings.difficulty))
end

function NobleHUD:_set_mission_name(text)
	local objectives_panel = self._objectives_panel
	objectives_panel:child("mission_label"):set_text(text)
end

function NobleHUD:_set_killcount(slot,kills)
	kills = tostring(kills)
	if slot == 1 then --primary
		self._primary_weapon_panel:child("kills_label"):set_text(kills .. "")
	elseif slot == 2 then --secondary
		self._secondary_weapon_panel:child("kills_label"):set_text(kills .. "")
	elseif slot == 3 then --melee
--		self._melee_weapon_panel:child("kills_label"):set_text(kills .. "")
	end
end

function NobleHUD:animate_popup_bluespider(o,t,dt,start_t,cb,duration,unit) 
	o:set_alpha(o:alpha() + (dt * duration * 2))
	if alive(unit) then 
		if t - start_t > duration then 
			return true
		end
		local viewport_cam = managers.viewport:get_current_camera()
		local head_pos = unit:movement() and unit:movement():m_head_pos()
		local unit_pos = head_pos and NobleHUD._ws:world_to_screen(viewport_cam,head_pos)
		if unit_pos then 
			o:set_x(unit_pos.x)
			o:set_y(unit_pos.y)
--			o:set_center(unit_pos.x,unit_pos.y)
		end
	else
		return true
	end
end
function NobleHUD:animate_popup_athena(o,t,dt,start_t,cb,duration,rate)
	o:set_alpha(o:alpha() + (dt * duration * 2))
	if t - start_t > duration then 
		return true
	end
	o:set_y(o:y() + (rate * dt)) --distance is per second
end
function NobleHUD:animate_popup_queue(o,t,dt,start_t,cb,duration,dest_y,rate)
	local oy = o:y()
	o:set_alpha(o:alpha() + (dt * rate)) --will always become fully visible in 1/rate seconds
	if t - start_t > duration then 
		return math.sign(dest_y - oy)
	end
	o:set_y(oy + (10 * dt * (dest_y - oy) / rate))
end

--below this line, score functions are deprecated

function NobleHUD:set_score_multiplier() --hud + effect
	local multiplier = self:get_total_global_score_multiplier()
	
	self:_set_score_multiplier(string.format("%0.02fx",multiplier))
end

function NobleHUD:_set_score_multiplier(text) --hud only
	self._score_panel:child("score_multiplier_label"):set_text(text)
end

function NobleHUD:_get_score_from_unit(unit_name)
	return NobleHUD.score_unit_points[unit_name] or 0
end

function NobleHUD:get_total_global_score_multiplier(mult) --arg optional
	mult = mult or 1
	
	local difficulty = Global.game_settings and Global.game_settings.difficulty
	local mult_data = self.score_multipliers
	local timer_mult = 1
	--[[
	if not self._cache.timer_score_multiplier then 
		local timer = managers.game_play_central:get_heist_timer()
		local mission_timer_mult = self._cartographer_data and self._cartographer_data.map_time_score or mult_data.time_generic	
		for _,timer_data in ipairs(mission_timer_mult) do
			if timer < timer_data.threshold then 
				timer_mult = timer_data.multiplier
				break
			end
		end
		self._cache.timer_score_multiplier = timer_mult
	else
		timer_mult = self._cache.timer_score_multiplier
	end
	--]]
	mult = mult * timer_mult
	mult = mult * (mult_data.difficulty[difficulty or "easy"] or 1)
--	local mutators = managers.mutators:mutators()
	--mutator multipliers go here
	return mult
end

function NobleHUD:_tally_score(data)
	local unitname = data.name or ""
	local score = self:_get_score_from_unit(unitname)
	local localized_unitname = managers.localization:text("noblehud_unitname_" .. unitname)
	local diff_mul = self:get_total_global_score_multiplier()
	if score then 
		score = score * diff_mul
		if (score > 0) and data.head_shot then
			score = score * self.score_multipliers.headshot
		end
		if false then --if popups enabled		
			self:create_score_popup(score,data.unit,unitname)
		end
		self:_add_score(score)
		self:set_score_label()
		return
	end	
	self:log("ERROR: _tally_score(" .. concat(data,",") .. ")")
end

function NobleHUD:_add_score(score)
	self.score_session = self.score_session + (tonumber(score or 0) or 0)
end

function NobleHUD:set_score_label()
	if not JoyScoreCounter then 
		self._score_panel:child("score_label"):set_text(NobleHUD.make_nice_number(self.score_session))
	end
end

function NobleHUD:create_score_popup(score,unit,unitname)
	local text = "+"
	local color = Color.white
	if false then --random color (for non negative values)
		local speed = 3
		local t = Application:time() * speed
		--0.5 * (math.cos(2 * (x + n/3) * math.pi) + 1) --where n is [0-2]
		Color = Color((math.sin(t) + 1)/2,(math.cos(t)+1)/2,(math.sin(t + 3.926990816))/2) --blue value is 5pi/4 but whatever
	end
	if score < 0 then 
		text = "-"
		color = Color.red
	end
	text = text .. tostring(score) 
	if true then --if show unit name
		text = text .. " " .. unitname
	end
	
	local popups_panel = self._popups_panel
	local popup = popups_panel:text({
		name = "popup_" .. tostring(self.score_popups_count),
		layer = 1,
		text = text,
		font = "fonts/font_large_mf",
		font_size = 16,
		alpha = 0,
		color = color
	})
	
	self.score_popups[self.score_popups_count] = {
		element = popup,
		unit = unit
	}
	self.score_popups_count = self.score_popups_count + 1
	--position changed after creation using animate
	local animate_method = "animate_score_popup_stack"
	popup:animate(callback(self,self,animate_method))
end

function NobleHUD:animate_score_popup_stack(o)
	local duration = 2
	local t = 0
	--starting positions
	o:set_x(0)
	o:set_y(0)
	while t <= duration do 
		t = t + coroutine.yield()
		local progress = (t/duration)
		o:set_alpha(1 - progress)
		o:set_x(0)
		o:set_y(0)
	end
	--while blah do blah etc
	
	self._popups_panel:remove(o)
end

function NobleHUD:animate_score_popup_track(o) --unused; should be moved to hudmanager
	local unit 
	local viewport_cam = managers.viewport:get_current_camera()
	local pos = self._ws:world_to_screen(viewport_cam,unit:position())
	o:set_x(pos.x)
	o:set_y(pos.y)
end


--		OBJECTIVES

function NobleHUD:_create_objectives(hud)
	--objectives (survive) etc
	local objectives_panel = hud:panel({
		name = "objectives_panel",
--		w = 300,
		h = tweak_data.hud.active_objective_title_font_size * 2.5,
--		x = (hud:w()/2) - (300 * 0.5),
		y = 128
	})
	local shadow_offset = 1.5
	local function get_blink_center_x (w)
		return (objectives_panel:w() - w) * 0.5
	end
	
	local debug_objectives = objectives_panel:rect({
		color = Color.purple,
		visible = false,
		alpha = 0.1
	})
	local mission_label = objectives_panel:text({ --not used
		name = "mission_label",
		text = "MISSION NAME",
		vertical = "top",
		align = "left",
		visible = false,
		x = 0,
		layer = 2,
		color = Color.white,
		font_size = tweak_data.hud.active_objective_title_font_size,
		font = tweak_data.hud.medium_font_noshadow
	})
	local objectives_title = objectives_panel:text({ 
		name = "objectives_title",
		text = "CURRENT OBJECTIVE:",
		align = "center",
		layer = 2,
		color = Color(0.66,0.66,0.66),
		alpha = 0,
		font_size = tweak_data.hud.active_objective_title_font_size,
		font = tweak_data.hud.medium_font_noshadow,
	})
	local objectives_title_shadow = objectives_panel:text({
		name = "objectives_title_shadow",
		text = "CURRENT OBJECTIVE:",
		align = "center",
		layer = 1,
		x = objectives_title:x() + shadow_offset,
		y = objectives_title:y() + shadow_offset,
		color = Color(0,0,0),
		alpha = 0,
		font_size = tweak_data.hud.active_objective_title_font_size,
		font = tweak_data.hud.medium_font_noshadow,
	})
	local _,_,title_w,title_h = objectives_title:text_rect()
	title_w = title_w * 1.5
	local blink_title = objectives_panel:bitmap({
		name = "blink_title",
		texture = "guis/textures/radar_blip_near",
		w = title_w,
		h = title_h / 2,
		x = get_blink_center_x(title_w),
		y = (title_h / 2),
		layer = 0,
		blend_mode = "add",
		color = Color.white,
		alpha = 0
	})
	local objectives_label = objectives_panel:text({
		name = "objectives_label",
		text = "SURVIVE",
		align = "center",
		vertical = "bottom",
		layer = 2,
		color = Color.white,
		font_size = tweak_data.hud.active_objective_title_font_size * 1.15,
		font = tweak_data.hud.medium_font_noshadow,
		alpha = 0
	})
	local objectives_label_shadow = objectives_panel:text({
		name = "objectives_label_shadow",
		text = "SURVIVE",
		align = "center",
		vertical = "bottom",
		x = shadow_offset,
		y = shadow_offset,
		layer = 1,
		color = Color.black,
		font_size = tweak_data.hud.active_objective_title_font_size * 1.15,
		font = tweak_data.hud.medium_font_noshadow,
		alpha = 0
	})
	
	local _,_,label_w,label_h = objectives_label:text_rect()
	label_w = label_w * 1.5
	local blink_label = objectives_panel:bitmap({
		name = "blink_label",
		texture = "guis/textures/radar_blip_near",
		w = label_w,
		h = label_h / 2,
		x = get_blink_center_x(label_w),
		y = objectives_panel:h() - (objectives_label:line_height() / 2),
		layer = 0,
		blend_mode = "add",
		color = Color.white,
		alpha = 0
	})
	self._objectives_panel = objectives_panel
end

function NobleHUD:AnimateShowObjective() --not an animate() function, but calls animate() 
	local objectives_panel = NobleHUD._objectives_panel
	local objectives_label = objectives_panel:child("objectives_label")
	local objectives_label_shadow = objectives_panel:child("objectives_label_shadow")
	local objectives_title = objectives_panel:child("objectives_title")
	local objectives_title_shadow = objectives_panel:child("objectives_title_shadow")
--return NobleHUD._objectives_panel:child("blink_label")

	local _,_,label_w,label_h = objectives_label:text_rect()
	
	local _,_,title_w,title_h = objectives_title:text_rect()

	local blink_label = NobleHUD._objectives_panel:child("blink_label")
	local blink_title = NobleHUD._objectives_panel:child("blink_title")

	local kern = -2
	local title_font_size = tweak_data.hud.active_objective_title_font_size
	local label_font_size = title_font_size * 1.15
	local duration = 0.2
	blink_label:set_size(label_w,label_h)
	blink_title:set_size(title_w,title_h)
	objectives_title:set_font_size(0)
	objectives_title:set_kern(kern)
	objectives_title:set_alpha(1)
	objectives_title_shadow:set_font_size(0)
	objectives_title_shadow:set_kern(kern)
	objectives_title_shadow:set_alpha(1)
	objectives_label:set_font_size(0)
	objectives_label:set_kern(kern)
	objectives_label:set_alpha(1)
	objectives_label_shadow:set_font_size(0)
	objectives_label_shadow:set_kern(kern)
	objectives_label_shadow:set_alpha(1)
	self:animate_stop(blink_label)
	self:animate_stop(blink_title)
	self:animate_stop(objectives_title)
	self:animate_stop(objectives_title_shadow)
	self:animate_stop(objectives_label)
	self:animate_stop(objectives_label_shadow)
	local function fadeout_title()
		self:AddDelayedCallback(
			function()
				self:animate(objectives_title,"animate_fadeout",function(o) o:set_font_size(title_font_size) end,0.5)
				self:animate(objectives_title_shadow,"animate_fadeout",function(o) o:set_font_size(title_font_size) end,0.5)
			end,
			nil,
			5,
			"fadeout_objective_title"
		)
	end
	local function fadeout_label()
		self:AddDelayedCallback(
			function()
				self:animate(objectives_label,"animate_fadeout",nil,0.5)
				self:animate(objectives_label_shadow,"animate_fadeout",nil,0.5)
			end,
			nil,
			4,
			"fadeout_objective_label"
		)
	end
	local function animate_objective_title_in()

		self:animate(objectives_title,"animate_objective_flash",fadeout_title,duration,title_font_size,kern)
		self:animate(objectives_title_shadow,"animate_objective_flash",nil,duration,title_font_size,kern)
	end
	local function animate_objective_text_in()
		self:animate(objectives_label,"animate_objective_flash",fadeout_label,duration,label_font_size,kern)
		self:animate(objectives_label_shadow,"animate_objective_flash",nil,duration,label_font_size,kern)
	end
	local mid_x = objectives_panel:w() / 2
	local blinkout_time = 0.25
	local blinkout_alpha = 0.9
	local blinkout_stretch_w_mul = 1.25
	self:AddDelayedCallback(
		function()
			blink_label:set_alpha(1)
			self:animate(blink_label,"animate_objective_blinkout",animate_objective_text_in,blinkout_time,label_w,label_w * blinkout_stretch_w_mul,blinkout_alpha,mid_x)
		end,
		nil,
		0.5,
		"fadein_objective_title"
	)
--	blink_title:set_alpha(1)
	self:animate(blink_title,"animate_objective_blinkout",animate_objective_title_in,blinkout_time,title_w,title_w * blinkout_stretch_w_mul,blinkout_alpha,mid_x)
end

function NobleHUD:animate_objective_flash(o,t,dt,start_t,duration,font_size,kern)

--	font_size = font_size or 28
--	o:set_font_size(0)
--	duration = duration or 0.2 --seconds to complete animation
	--kern = kern or -2
--	o:set_kern(kern)
	local elapsed = t - start_t
	
	
	local scale = elapsed / duration
	if scale > 1 then 
		o:set_font_size(font_size)
		o:set_kern(0)
		return true
	end
	o:set_font_size(font_size * scale)
	o:set_kern((1 - scale) * kern)
end

function NobleHUD:animate_objective_blinkout(o,t,dt,start_t,duration,start_w,end_w,alpha,mid_x)
--	duration = duration or 0.25
	local elapsed = t - start_t
	
	local scale = elapsed / duration
	if scale > 1 then 
		o:set_h(0)
		o:set_alpha(0)
		o:set_x(mid_x - (o:w() / 2))
		return true
	end
	o:set_alpha(alpha * (1 - scale))
	o:set_h(o:h() * 0.8) 
	scale = math.pow(scale,2)
	o:set_w(start_w + ((end_w + start_w) * (1 - scale)))
	o:set_x(mid_x - (o:w() / 2))
end

function NobleHUD:SetObjectiveTitle(label)
	if alive(self._objectives_panel) then 
		self._objectives_panel:child("objectives_title"):set_text(label)
		self._objectives_panel:child("objectives_title_shadow"):set_text(label)
	end
end

function NobleHUD:SetObjectiveAmount(data)
	if alive(self._objectives_panel) then 
		local progress = ""
		if data.amount and data.current_amount then 
			progress = string.gsub(" [$CURRENT/$TOTAL]","$CURRENT",data.current_amount)
			progress = string.gsub(progress,"$TOTAL",data.amount)
		end
		local label = utf8.to_upper(self._cache.current_objective or "") .. progress
		self._objectives_panel:child("objectives_label"):set_text(label)
		self._objectives_panel:child("objectives_label_shadow"):set_text(label)
	end
end

function NobleHUD:SetObjectiveLabel(label)
	local progress = ""
	if NobleHUD._cache.objective_progress and NobleHUD._cache.objective_total then
		progress = string.gsub(" [$CURRENT/$TOTAL]","$CURRENT",data.current_amount,"$TOTAL",data.amount)
	end
	label = label .. progress
	if alive(self._objectives_panel) then 
		self._objectives_panel:child("objectives_label"):set_text(label)
		self._objectives_panel:child("objectives_label_shadow"):set_text(label)
	end
end


--		TABSCREEN

function NobleHUD:_create_tabscreen(hud)
	local tabscreen = hud:panel({
		name = "tabscreen",
		visible = false,
		alpha = 1
	})
	self._tabscreen = tabscreen
	
	local v_margin = 2
	
	--todo get settings
	local downs_w = 24
	local icon_w = 32
	local name_w = 256
	local kills_w = 50
	local score_w = 50
	local ping_w = 64
	local ping_bitmap_w = 6
	
	local indicator_w = 3
	
	local skull_char = "" 
	
	local brightness = 0.8
	
	local all_box_h = 32
	
	local player_box_x = 32
--	local player_box_y = 100
	local player_box_w = downs_w + kills_w + icon_w + name_w + score_w + ping_w
	local player_box_h = all_box_h
	local font_size = 24
	local scoreboard_w = 600
	local scoreboard_h = 300
	local scoreboard = tabscreen:panel({
		name = "scoreboard",
		w = scoreboard_w,
		h = scoreboard_h,
		layer = 69
	})
	local scoreboard_debug = scoreboard:rect({
		name = "scoreboard_debug",
		color = Color(1,0,1),
		visible = false,
		alpha = 0.2
	})
	scoreboard:set_center(hud:w()/2,hud:h()/2)
	
	local title_box = scoreboard:panel({
		name = "title_box",
		x = 0,
		y = 0,
		w = player_box_x + player_box_w - ping_w,
		h = all_box_h,
		layer = 1,
	})
	local title_bg = title_box:rect({
		name = "title_bg",
		color = Color(0.3,0.3,0.3),
		layer = 1
	})
	local title_label = title_box:text({
		name = "title_label",
		text = "Bank Heist: Gold" .. " /// " .. string.rep(skull_char .. " ",3),
		align = "left",
		vertical = "center",
		x = title_box:w() / 20,
		color = Color(1,0.75,0),
		font = tweak_data.hud_players.ammo_font,
		font_size = font_size,
		layer = 2
	})
	local _,_,_w,_ = title_label:text_rect()
	local title_label_2 = title_box:text({
		name = "title_label_2",
		text = "",
		align = "left",
		vertical = "center",
		x = title_label:x() + _w,
		color = Color(0.5,0.5,0.5),
		font = tweak_data.hud_players.ammo_font,
		font_size = font_size,
		layer = 2
	})
	
	
	local header_box = scoreboard:panel({
		name = "header_box",
		x = 0,
		y = title_box:bottom() + v_margin,
		w = player_box_w,
		h = all_box_h		
	})
	
	local teamnum_box = header_box:panel({
		name = "teamnum_box",
		x = 0,
		w = 32,
		layer = 2
	})
	local teamnum_bg = teamnum_box:rect({
		name = "teamnum_bg",
		color = Color(0.1,0.1,0.1),
		layer = 2
	})
	local teamnum_label = teamnum_box:text({
		name = "teamnum_label",
		text = "1",
		align = "center",
		vertical = "center",
		font = tweak_data.hud_players.ammo_font,
		font_size = font_size,
		layer = 3
	})
	
	local teamname_box = header_box:panel({
		name = "teamname_box",
		x = player_box_x,
		w = kills_w + icon_w + name_w + score_w
	})
	local teamname_bg = teamname_box:rect({
		name = "teamname_bg",
		color = Color(0.5,0.2,0.2),
		layer = 1
	})
	local teamname_label = teamname_box:text({
		name = "teamname_label",
		text = "RED TEAM",
		align = "left",
		x = teamname_box:w() / 20,
		vertical = "center",
		font = tweak_data.hud_players.ammo_font,
		font_size = font_size,
		layer = 3
	})
	
	local teamscore_box = header_box:panel({
		name = "teamname_box",
		x = player_box_x + downs_w + icon_w + name_w + kills_w,
		w = score_w,
		layer = 2
	})
	local teamscore_bg = teamscore_box:rect({
		name = "teamscore_bg",
		color = Color(0.1,0.1,0.1),
		layer = 2
	})
	local teamscore_label = teamscore_box:text({
		name = "teamscore_label",
		text = "4",-- .. skull_char,
		align = "center",
		vertical = "center",
		color = Color.white,
		font = tweak_data.hud_players.ammo_font,
		font_size = font_size,
		layer = 3
	})
	local player_indicator = scoreboard:rect({
		name = "player_indicator",
		color = Color.white,
		layer = 3,
		x = player_box_x - (indicator_w + v_margin),
		w = indicator_w,
		h = all_box_h
	})
	local function create_player_box (peer_id)
		local peer_color = tweak_data.chat_colors[peer_id] or Color.red
		local peer_color_2 = (peer_color * brightness):with_alpha(1) or tweak_data.preplanning_peer_colors[peer_id]
		--kills, icon, playername, character, kills/score, ping (visual)
		local player_box = scoreboard:panel({
			name = "player_box_" .. tostring(peer_id),
			w = player_box_w,
			h = player_box_h,
			x = player_box_x,
			y = (header_box:bottom() + v_margin) + ((v_margin + player_box_h) * (peer_id - 1)),
			layer = 1
		})
		local debug_playerbox = player_box:rect({
			name = "debug_playerbox",
			color = Color(1,1,0),
			visible = false,
			alpha = 0.3
		})
		
		local downs_box = player_box:panel({
			name = "downs_box",
			layer = 2,
			w = downs_w,
			x = 0
		})
		local downs_bg = downs_box:rect({
			name = "downs_bg",
			layer = 2,
			color = Color(0.3,0.3,0.3)
		})
		local downs_bitmap = downs_box:bitmap({
			name = "downs_bitmap",
			layer = 3,
			texture = "guis/textures/health_cross",
			y = (all_box_h - downs_w) / 2,
			w = downs_w,
			h = downs_w,
			color = Color(0.75,0.3,0.3)
		})
		local downs_label = downs_box:text({
			name = "downs_label",
			text = "3",
			align = "center",
			vertical = "center",
			font = tweak_data.hud_players.ammo_font,
			font_size = font_size,
			layer = 4
		})
		
		local icon_box = player_box:panel({
			name = "icon_box",
			layer = 2,
			w = icon_w,
			x = downs_box:right()
		})
		local icon_bg = icon_box:rect({
			name = "icon_bg",
			layer = 2,
			color = peer_color
		})
		local icon_bitmap = icon_box:bitmap({
			name = "icon_bitmap",
			layer = 3,
			texture = "guis/textures/sword_crosshair",
			w = icon_w,
			h = icon_w
		})
		
		local name_box = player_box:panel({
			name = "name_box",
			layer = 2,
			w = name_w,
			x = icon_box:right()
		})
		local name_bg = name_box:rect({
			name = "name_bg",
			color = peer_color_2,
			layer = 2
		})
		local name_label = name_box:text({
			name = "name_label",
			text = "Player " .. tostring(peer_id),
			align = "left",
			vertical = "center",
			x = name_w / 20,
			font = tweak_data.hud_players.ammo_font,
			font_size = font_size,
			layer = 3
		})
		
		local kills_box = player_box:panel({
			name = "kills_box",
			layer = 2,
			w = kills_w,
			x = name_box:right()
		})
		local kills_bg = kills_box:rect({
			name = "kills_bg",
			layer = 2,
			color = peer_color
		})
		local kills_label = kills_box:text({
			name = "kills_label",
			text = "0",
			align = "center",
			vertical = "center",
			font = tweak_data.hud_players.ammo_font,
			font_size = font_size,
			layer = 3
		})
		
		local score_box = player_box:panel({
			name = "score_box",
			layer = 2,
			w = score_w,
			x = kills_box:right()
		})
		local score_bg = score_box:rect({
			name = "score_bg",
			color = Color(0.3,0.3,0.3),
			layer = 2
		})
		local score_label = score_box:text({
			name = "score_label",
			text = "1",
			align = "center",
			vertical = "center",
			font = tweak_data.hud_players.ammo_font,
			font_size = font_size,
			layer = 3
		})
		
		local ping_box = player_box:panel({
			name = "ping_box",
			layer = 2,
			w = ping_w,
			x = score_box:right() + v_margin
		})
		local ping_bg = ping_box:rect({
			name = "ping_bg",
			color = peer_color_2,
			visible = false --debug only; should be hidden
		})
		local ping_bitmap = ping_box:bitmap({
			name = "icon_bitmap",
			layer = 3,
			texture = "guis/textures/test_blur_df",
			w = ping_bitmap_w,
			h = player_box_h,
			color = Color.green
		})
		local ping_label = ping_box:text({
			name = "ping_label",
			text = math.random(100) .. "ms",
			align = "left",
			vertical = "bottom",
			font = tweak_data.hud_players.ammo_font,
			font_size = font_size / 2,
			x = ping_bitmap_w + (ping_w / 20),
			layer = 4
		})
		if peer_id == managers.network:session():local_peer():id() then 
			player_indicator:set_y(player_box:y())
		end
	end
	
	for i=1,4 do 
		create_player_box(i)
	end
	
	
end

function NobleHUD:_set_tabscreen_teammate_name(id,name)
	local player_box = self._tabscreen:child("scoreboard"):child("player_box_" .. id)
	if alive(player_box) then
		player_box:child("name_box"):child("name_label"):set_text(name)
	end
end

function NobleHUD:update_characters()
	for k,v in pairs(managers.criminals._characters) do
		if v.taken then 
			local name = v.name
			local peer_id = 5
			if v.data.ai then 
				peer_id = v.data.ai_id
			elseif v.peer_id then 
				peer_id = v.peer_id
			end
			self:_set_scoreboard_character(peer_id,name)
		end
	end
end

function NobleHUD:_set_scoreboard_character(peer_id,character_id)
	local player_box = self._tabscreen:child("scoreboard"):child("player_box_" .. peer_id)
	local mask_id = tweak_data.blackmarket.masks.character_locked[managers.criminals.convert_old_to_new_character_workname(character_id)]
	local mask_icon = tweak_data.blackmarket:get_mask_icon(mask_id)
	if alive(player_box) then 
		player_box:child("icon_box"):child("icon_bitmap"):set_image(mask_icon)
		player_box:child("name_box"):child("name_label"):set_text(managers.localization:text("menu_" .. character_id))
	end
	
--	local character_icon = tweak_data.blackmarket:get_character_icon(character)
end

function NobleHUD:_reset_player_scoreboard(peer_id)
	--
end


--		RADAR

function NobleHUD:_create_radar(hud)
	local radar_panel = hud:panel({
		name = "radar_panel",
		w = 200,
		h = 200,
		x = 32,
		y = hud:bottom() - 224, --bottom left
	})
	--[[
	local radar_outline = radar_panel:bitmap({
		name = "radar_outline",
--		texture = "guis/textures/ability_circle_outline",
		layer = 3,
		color = self.color_data.hud_vitalsoutline_blue,
		alpha = 0.7
	})--]]
	
	local radar_bg = radar_panel:bitmap({
		name = "radar_bg",
		texture = "guis/textures/radar_bg",
		layer = 2,
		color = self.color_data.hud_vitalsfill_blue,
		alpha = 0.8
	})
	local radar_range_label = radar_panel:text({
		name = "radar_range_label",
		text = "25m",
		color = self.color_data.hud_vitalsoutline_blue,
		layer = 2,
		font = "fonts/font_eurostile_ext",
		font_size = 16,
		align = "left",
--		y = -16, --equal to font size
		vertical = "bottom",
		alpha = 0.9
	})
	
	self._radar_panel = radar_panel
	
	local debug_radar = radar_panel:rect({
		color = Color.yellow,
		visible = false,
		alpha = 0.1
	})
end

function NobleHUD:create_radar_blip(u)
	if (not (alive(u) and u:movement() and u:movement():team())) or u:character_damage():dead() then 
		self:log("Error: No unit for create_radar_blip()!",{color = Color.red})
		return
	end
	
	if self._radar_blips[u:key()] then --blip data already exists, so return it
		return self._radar_blips[u:key()]
	end
	
	local team = u:movement():team().id
	local blip_bitmap = self._radar_panel:bitmap({
		name = "blip_" .. tostring(u:key()),
		texture = "guis/textures/radar_blip",
		layer = 4,
		color = self:get_blip_color_by_team(team),
		blend_mode = "add",
		alpha = 0.7,
		x = 0,
		y = 0
	})
	
	local blip_data = {
		bitmap = blip_bitmap,
		unit = u
	}
	self._radar_blips[u:key()] = blip_data
	return blip_data
end

function NobleHUD:check_radar_blip_color(u,key) --todo change color if joker
	key = key or (u and u:key())
	if not key then 
		self:log("Error: No key for check_radar_blip_color()!",{color = Color.red})
		return
	end
	local blip = self._radar_blips[key]
	if blip then 
		local unit = u or blip.unit
		local color = self:get_blip_color_by_team(unit:movement():team().id)
		blip.bitmap:set_color(color)
	end
	
	
end

function NobleHUD:remove_radar_blip(u,key)
	key = key or (u and u:key())
	if not key then
		self:log("Error: No key for remove_radar_blip()!",{color = Color.red})
		return
	end

	local blip = self._radar_blips[key]
	if blip then 
		blip.bitmap:stop()
		blip.bitmap:animate(callback(self,self,"animate_blip_fadeout"))
		--self._radar_panel:remove(blip.bitmap) --done after fadeout complete
		self._radar_blips[key] = nil
	end
	
	
end

function NobleHUD:animate_blip_fadeout(o)
	local A_THRESHOLD = 0.01
	local RATE = 0.95
	local alpha = o:alpha()
	while alpha > A_THRESHOLD do 
		local dt = coroutine.yield()
		alpha = alpha * RATE
		o:set_alpha(alpha)
	end
	self._radar_panel:remove(o)
end

function NobleHUD:animate_blip_move(o,delay)
--unused
end

function NobleHUD:_set_radar_range(text)
	self._radar_panel:child("radar_range_label"):set_text(string.gsub(managers.localization:text("noblehud_radar_distance_label"),"$DISTANCE",text))	
end


--		CARTOGRAPHER (location on map)

function NobleHUD:_create_cartographer(hud)
	local cartographer_h = 32
	local cartographer_panel = hud:panel({
		name = "cartographer_panel",
		w = hud:w(),
		h = cartographer_h,
		x = 200,
		y = hud:bottom() - (cartographer_h + 24)
	})
	local debug_cartographer = cartographer_panel:rect({
		name = "debug_cartographer",
		visible = false,
		color = Color.red,
		alpha = 0.3
	})
	local area_label = cartographer_panel:text({
		name = "area_label",
		text = "Terrace",
		color = self.color_data.hud_vitalsoutline_blue,
		layer = 2,
		font = "fonts/font_eurostile_ext",
		font_size = 16,
		align = "left",
		vertical = "bottom",
		alpha = 0.9
	})
	
	self._cartographer_panel = cartographer_panel
end

function NobleHUD:LoadCartographerData(map_id)
	local path = self._cartographer_path 
	if map_id then 
		path = path .. tostring(map_id) .. ".txt"
	end
	if SystemFS:exists( Application:nice_path( path, true )) then
		
		local file = io.open(path,"r")	
		if file then 
			for k,v in pairs(json.decode(file:read("*all"))) do
				self._cartographer_data[k] = v
			end
		end
		return self._cartographer_data
	else
		self:log("No cartographer file for map [" .. map_id .. "] (" .. managers.localization:text(map_id or "nil") .. ")",{color = Color(1,0.5,0)})
	end
end

function NobleHUD:SetCartographerLabel(label)
	if label then 
		self._cartographer_panel:child("area_label"):set_text(label)
	end
end

function NobleHUD:ConsultCartographer(pos,map)
	if pos and map then 
		local pos_x = math.floor(pos.x)
		local pos_y = math.floor(pos.y)
		local pos_z = math.floor(pos.z)

		for k,v in pairs(map) do
			if (pos_x < v.x_upper) and (pos_x > v.x_lower) then
				if (pos_y < v.y_upper) and (pos_y > v.y_lower) then
					if (pos_z < v.z_upper) and (pos_z > v.z_lower) then
						return v.location
					end
				end
			end
		end
	end
end

--		VITALS

function NobleHUD:_create_vitals(hud)
	local vitals_panel = hud:panel({
		name = "vitals_panel",
		w = 512,
		h = 64,
		x = (hud:w() - 512)/ 2,
		y = 50
	})
	local shield_outline = vitals_panel:bitmap({
		name = "shield_outline",
		texture = "guis/textures/shield_outline",
		layer = 3,
		color = self.color_data.hud_vitalsoutline_blue,
--		blend_mode = "add",
		alpha = 0.7,
		x = 0,
		y = 0
	})
	
	local shield_fill = vitals_panel:bitmap({
		name = "shield_fill",
		texture = "guis/textures/shield_fill",
		layer = 2,
		color = self.color_data.hud_vitalsfill_blue,
		alpha = 0.3,
		x = 0,
		y = 0
	})
	
	local shield_glow = vitals_panel:bitmap({
		name = "shield_glow",
		texture = "guis/textures/shield_glow",
		layer = 1,
		color = self.color_data.hud_vitalsfill_red,
		alpha = 0,
		blend_mode = "add",
		x = 0,
		y = 0
	})
	
	local shield_warning = vitals_panel:text({
		name = "shield_warning",
		text = "WARNING",
		layer = 3,
		align = "center",
		y = 12,
		alpha = 0,
		color = Color.white,
		font = tweak_data.hud.medium_font,
		font_size = 16
	})
	local TICK_SCALE = 0.85
	local TICK_W = 24 * TICK_SCALE
	local TICK_H = 20 * TICK_SCALE
	local TICK_Y = vitals_panel:h() + -8 + - TICK_H 
	local CENTER_W = 36 * TICK_SCALE
	local FREE_SPACE = 170 - (CENTER_W / 2)
	local HEALTH_TICKS = NobleHUD._HUD_HEALTH_TICKS --does not include center tick
	local MARGIN = (FREE_SPACE / HEALTH_TICKS)
	for i = 1, HEALTH_TICKS do 
		local left_x = ((vitals_panel:w() - CENTER_W)/ 2) + - (i * MARGIN)
		local right_x = ((vitals_panel:w() + CENTER_W)/ 2) + (i * MARGIN) - TICK_W
		local tick_left_fill = vitals_panel:bitmap({
			name = "health_tick_left_fill_" .. i,
			texture = "guis/textures/health_left_fill",
			w = TICK_W,
			h = TICK_H,
			layer = 2,
			color = self.color_data.hud_vitalsfill_blue,
			alpha = 0.3,
			x = left_x,
			y = TICK_Y
		})
		local tick_right_fill = vitals_panel:bitmap({
			name = "health_tick_right_fill_" .. i,
			texture = "guis/textures/health_right_fill",
			w = TICK_W,
			h = TICK_H,
			layer = 2,
			color = self.color_data.hud_vitalsfill_blue,
			alpha = 0.3,
			x = right_x,
			y = TICK_Y
		})	
		local tick_left_outline = vitals_panel:bitmap({
			name = "health_tick_left_outline_" .. i,
			texture = "guis/textures/health_left_outline",
			w = TICK_W,
			h = TICK_H,
			layer = 3,
--			blend_mode = "add",
			color = self.color_data.hud_vitalsoutline_blue,
			alpha = 0.5,
			x = left_x,
			y = TICK_Y
		})
		local tick_right_outline = vitals_panel:bitmap({
			name = "health_tick_right_outline_" .. i,
			texture = "guis/textures/health_right_outline",
			w = TICK_W,
			h = TICK_H,
			layer = 3,
--			blend_mode = "add",
			color = self.color_data.hud_vitalsoutline_blue,
			alpha = 0.5,
			x = right_x,
			y = TICK_Y
		})		
	end
	local tick_center_fill = vitals_panel:bitmap({
		name = "health_tick_center_fill",
		texture = "guis/textures/health_center_fill",
		w = CENTER_W,
		h = TICK_H,
		layer = 2,
		color = self.color_data.hud_vitalsfill_blue,
		alpha = 0.3,
		x = (vitals_panel:w() - CENTER_W) / 2,
		y = TICK_Y
	})
	local tick_center_outline = vitals_panel:bitmap({
		name = "health_tick_center_outline",
		texture = "guis/textures/health_center_outline",
		w = CENTER_W,
		h = TICK_H,
		layer = 3,
--		blend_mode = "add",
		color = self.color_data.hud_vitalsoutline_blue,
		alpha = 0.5,
		x = (vitals_panel:w() - CENTER_W) / 2,
		y = TICK_Y
	})
		
	self._vitals_panel = vitals_panel
	
	local debug_vitals = vitals_panel:rect({
		visible = false,
		color = Color(1,0.5,0):with_alpha(0.1) --orange
	})
end

function NobleHUD:create_revives()
	local player = managers.player:local_player()
	local dmg = player and player:character_damage()
	local revives = dmg and Application:digest_value(dmg._revives,false)
	self:_create_revives(revives)
end

function NobleHUD:_create_revives(amount) --called on internal load
	amount = amount and tonumber(amount) or 3
	self._MAX_REVIVES = amount
	--todo dot size based on revives
	
	local vitals_panel = self._vitals_panel
	local margin = (vitals_panel:h() / amount) / 3
	for i = 1,amount do 
		local revive_dot = vitals_panel:bitmap({
			name = "revive_dot_" .. i,
			texture = "guis/textures/ability_circle_fill",
			w = 8,
			h = 8,
			layer = 2,
			color = self.color_data.hud_vitalsfill_blue,
			alpha = 0.5,
			x = vitals_panel:w() - 8,
			y = i * (margin + amount)
		})
	end
	
end


--		CARRY

function NobleHUD:_create_carry(hud)
	local margin_w = 4
	local carry_w = 400
	local carry_panel = hud:panel({
		name = "carry_panel",
		x = 32,
		y = 100,
		h = 50,
		visible = false --set visible on pickup bag
	})
	local debug_carry = carry_panel:rect({
		name = "debug_carry",
		color = Color.red,
		visible = false,
		alpha = 0.3
	})
	
	local bag_texture, bag_rect = tweak_data.hud_icons:get_icon_data("bag_icon")
	
	local bag_icon = carry_panel:bitmap({
		name = "bag_icon",
		texture = bag_texture,
		texture_rect = bag_rect,
		layer = 2,
		color = Color.white,
		alpha = 0.8
	})	
	
	local bag_label = carry_panel:text({
		name = "bag_label",
		text = "Kat's Prosthetic Arm",
		x = bag_rect[3] + margin_w,
		y = 0,
--		vertical = "bottom",
--		align = "center",
		font = "fonts/font_medium_mf",
		font_size = 24,
		layer = 1,
		color = Color.white
	})
	local bag_value = carry_panel:text({
		name = "bag_value",
		text = "10 Cr",
		y = bag_label:line_height(),
		font = "font_eurostile_ext",
		font_size = 16,
		layer = 1,
		color = Color.white
	})
	self._carry_panel = carry_panel
end

function NobleHUD:SetBagLabel(id,value) --not used
	local td = tweak_data.carry[tostring(id)]
	local carry_panel = self._carry_panel
	if td then 
		local name = td.name_id and managers.localization:text(td.name_id) or "Kat's Prosthetic Arm"
		carry_panel:child("bag_label"):set_text(name)
		if value then 
			carry_panel:child("bag_value"):set_text(managers.experience:cash_string(value))
		end
	else
		self:log("ERROR: SetBagLabel(" .. tostring(id) .. "): No carry tweak data found",{color = Color.red})
	end
end

function NobleHUD:ShowCarry(id,value)
	local carry_panel = self._carry_panel
	local bag_label = carry_panel:child("bag_label")
	local bag_icon = carry_panel:child("bag_icon")
	
	self:animate_stop(carry_panel)
	self:animate_stop(bag_label)
	self:animate_stop(bag_icon)
	
	local td = tweak_data.carry[tostring(id)]
	local visible = carry_panel:visible()
	carry_panel:set_alpha(1)
	carry_panel:show()
	if td then 
		local name = td.name_id and managers.localization:text(td.name_id) or "Kat's Prosthetic Arm"
		self:animate(bag_icon,"animate_blink",function(o) o:show() end,1.75,2)
		self:animate(bag_label,"animate_type_text",nil,0.5,name or bag_label:text(),"_",3)
--			bag_label:set_text(name)
		if value then 
			carry_panel:child("bag_value"):set_text(managers.experience:cash_string(value))
		else
			carry_panel:child("bag_value"):set_text("")
		end
	else
		self:log("ERROR: ShowCarry(" .. tostring(id) .. "," .. tostring(value) .. "): No carry tweak data found",{color = Color.red})
	end	
	
	
end

function NobleHUD:HideCarry()
	local carry_panel = self._carry_panel
	local bag_label = carry_panel:child("bag_label")
	local bag_icon = carry_panel:child("bag_icon")
	bag_icon:show()
	self:animate_stop(bag_label)
	self:animate_stop(bag_icon)
	carry_panel:set_alpha(0.5)
	self:animate(carry_panel,"animate_blink",function (o)
			o:hide()
			o:set_alpha(1)
			bag_label:set_text("")
		end,
		1.75,
		6
	)
	carry_panel:child("bag_value"):set_text("")
end

function NobleHUD:animate_blink(o,t,dt,start_t,duration,blink_speed)
--blink speed is approximately equal to blinks per second
	o:set_visible(math.abs(0.5 + math.sin((t - start_t) * (blink_speed or 1) * 360)) < 0.5)
	if t - start_t > duration then
		return true
	end
end

function NobleHUD:animate_type_text(o,t,dt,start_t,duration,text,type_char,post_duration,blink_speed)
	post_duration = post_duration or 0

	type_char = type_char or "_"
	if t - start_t > (duration + post_duration) then 
		o:set_text(text)
		return true
	elseif t - start_t < duration then
		local length = string.len(text)
		local ratio = (t - start_t) / duration
		o:set_text(string.sub(text,1,math.clamp(ratio * length,1,length)) .. type_char)
	elseif math.sin((t - start_t) * 360  * (blink_speed or 2)) > 0 then 
		o:set_text(text .. type_char)
	else
		o:set_text(text)
	end
end


--		EQUIPMENT
function NobleHUD:_create_equipment(hud)
	local eq_h = 128
	local equipment_panel = hud:panel({
		name = "equipment_panel",
		layer = 1,
		w = hud:w(),
		h = eq_h,
		y = hud:h() + - eq_h,
	})
	local debug_eq = equipment_panel:rect({
		name = "debug_equipment",
		color = Color.blue,
		alpha = 0.5,
		visible = false
	})
	self._equipment_panel = equipment_panel
end

function NobleHUD:layout_equipments(special_equipments,new)
	local margin = 16
--	local amount = #special_equipments
	for i,panel in pairs(special_equipments) do
		local x = self._equipment_panel:w() - (panel:w() * i) + -margin
		if panel:name() == new then 
			NobleHUD:animate(panel,"animate_add_equipment",function (o)
				NobleHUD:animate(o:child("bitmap"),"animate_killfeed_icon_pulse",nil,0.2,panel:w(),1.5,x,panel:y())
			end,0.1,x)
		else
			NobleHUD:animate(panel,"animate_add_equipment",nil,0.1,x)
		end
	end
end

function NobleHUD:animate_add_equipment(o,t,dt,start_t,rate,x,threshold)
	if math.abs(x - o:x()) < (threshold or 1) then
		o:set_x(x)
		o:set_alpha(1)
		return true
	end
--	local alpha = (x - o:x() / 1000)
--	o:set_alpha(o:alpha() * 1.1)
	o:set_x(o:x() + ((x - o:x()) * rate))
--	o:set_x(o:x() + (x * dt / duration))
end


--		COMPASS

function NobleHUD:_create_compass(hud)
	local compass_color = self.color_data.hud_compass
	local function get_cardinal(angle) 
		local cardinal = {
			["0"] = "W",
			["45"] = "NW",
			["90"] = "N",
			["135"] = "NE",
			["180"] = "E",
			["225"] = "SE",
			["270"] = "S",
			["315"] = "SW",
			["360"] = "W"
		}
		return cardinal[angle] or tostring(angle)
	end
	local hud_w = hud:w()
	local w_mul = 2
	local degrees = 360
	local compass_w = hud_w / 2 --visible width
	local compass_h = 16
	local font_size = compass_h
	local tick_h = compass_h * 0.5
	local dot_h = compass_h * 0.25
	local tick_interval_l = 45
	local tick_interval_m = 15
	local tick_interval_s = 5
	local compass_panel = hud:panel({
		name = "compass_panel",
		visible = true,
		layer = 0,
		x = (hud_w - compass_w) / 2,
		y = 16,
		w = compass_w
	})
	self._compass_panel = compass_panel
	local compass_strip = compass_panel:panel({
		name = "compass_strip",
		layer = 0,
		w = hud_w * 2,
		h = compass_h
	})
		
	--for perfect wraparound, create a looping panel with duplicate sections instead of exactly 360 ticks
	for i = 0,degrees * w_mul do 
		local x = (i / (degrees * w_mul)) * (hud_w * w_mul)
		if i % tick_interval_l == 0 then 
			compass_strip:text({
				name = "direction_" .. tostring(i),
				color = compass_color,
				layer = 2,
				font = tweak_data.hud_players.ammo_font,
				font_size = font_size,
				x = x - (font_size / 2),
				vertical = "center",
				text = get_cardinal(tostring(i % degrees))
			})
		elseif i % tick_interval_m == 0 then 
			compass_strip:bitmap({
				name = "direction_" .. tostring(i),
				texture = "guis/textures/ability_circle_fill",
				color = compass_color,
				x = x - (dot_h / 2),
				y = (compass_h - dot_h) / 2,
				w = dot_h,
				h = dot_h,
				layer = 1
			})
		elseif i % tick_interval_s == 0 then 
			compass_strip:text({
				name = "direction_" .. tostring(i),
				color = compass_color,
				layer = 2,
				font = tweak_data.hud_players.ammo_font,
				font_size = tick_h,
				x = x,
				vertical = "center",
				text = "|"
			})
		end
	end
	local debug_compass = compass_strip:rect({
		name = "debug_compass",
		color = Color.orange,
		alpha = 0.3,
		visible = false
	})
	
	return compass_panel
end


--		INTERACTION

function NobleHUD:_create_interact(hud)
	local interact_panel = hud:panel({
		name = "interact_panel",
		w = hud:w(),
		h = hud:h(),
		visible = false
	})
	
	local floating_w = 400
	local floating_h = 100
	
	local floating_panel = interact_panel:panel({
		name = "floating_panel",
		w = floating_w,
		h = floating_h,
		x = hud:w() - (floating_w + 50),
		y = 200
--		x = (hud:w() + floating_w) /2,
--		y = (hud:h() + floating_h) /2
	})

	local texture,texture_rect = tweak_data.hud_icons:get_icon_data("wp_target")
	local interact_bitmap = floating_panel:bitmap({
		name = "interact_bitmap",
		texture = texture,
		texture_rect = texture_rect,
		w = 32,
		h = 32,
		x = 50,
		y = 50,
		visible = false, --disabled
		layer = 1,
		alpha = 1,
		color = Color(0,0.3,0.9)
	})
	
	local trace_vertical = interact_panel:bitmap({
		name = "trace_vertical",
		visible = false, --temp disabled cause it's ugly
		texture = "guis/textures/ar_crosshair_2",
		blend_mode = "add",
		w = 2,
		h = 2,
		layer = 1,
		alpha = 1,
		rotation = 0,
		color = self.color_data.hud_bluefill
	})
	local trace_horizontal = interact_panel:bitmap({
		name = "trace_horizontal",
		visible = false, --temp disabled cause it's ugly
		texture = "guis/textures/ar_crosshair_2",
		w = 2,
		h = 2,
		layer = 1,
		alpha = 1,
		blend_mode = "add",
		rotation = 0,
		color = self.color_data.hud_bluefill
	})
	
	local interact_name = floating_panel:text({
		name = "interact_name",
		text = "Enter Warthog",
		align = "right",
		color = self.color_data.hud_vitalsoutline_blue,
		font = tweak_data.hud.medium_font_noshadow,
		font_size = 16,
		layer = 4
	})
	local interact_progress = floating_panel:text({
		name = "interact_progress",
		text = "1s",
		align = "right",
		color = self.color_data.hud_vitalsoutline_blue,
		font = tweak_data.hud.medium_font_noshadow,
		font_size = 12,
		y = interact_name:line_height(),
		layer = 5
	})
	
	local debug_interact = floating_panel:rect({
		name = "debug",
		visible = false,
		color = Color.red,
		alpha = 0.1
	})
	
	self._interact_panel = interact_panel
end

function NobleHUD:ShowInteract(data)
	local interact_panel = self._interact_panel
	local floating_panel = interact_panel:child("floating_panel")
	local interact_name = floating_panel:child("interact_name")
	self:animate_stop(interact_panel)
	interact_panel:set_w(1280)
	interact_name:set_font_size(16)
	
	if data then
		local text = data.text or "Press $INTERACT to interact"
		interact_name:set_text(text)
		
		if data.icon then 
			local texture,texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
			floating_panel:child("interact_bitmap"):set_image(texture)
			if texture_rect then 
				floating_panel:child("interact_bitmap"):set_texture_rect(texture_rect)
			end
		end
		
	end
	if not interact_panel:visible() then 
		self:animate(interact_name,"animate_killfeed_text_in",nil,0.15,interact_name:font_size(),self.color_data.hud_text_blue,self.color_data.hud_text_flash)
	end
--	local itd = tweak_data.interaction[interact.tweak_data or ""] or {text_id = "ERROR"}
--	local interact_text_id = managers.localization:text(itd.text_id)
	interact_panel:show()
end

function NobleHUD:HideInteract(cancelled)
	local interact_panel = self._interact_panel
	if not cancelled then 
		interact_panel:hide()
	end
	interact_panel:child("floating_panel"):child("interact_progress"):set_text("")
	interact_panel:child("trace_vertical"):set_h(0)
	interact_panel:child("trace_horizontal"):set_w(0)
end



function NobleHUD:SetInteractProgress(current,total)
	local interact_panel = self._interact_panel
	local floating_panel = interact_panel:child("floating_panel")
	local interact_progress = floating_panel:child("interact_progress")
	interact_progress:set_text(string.format("%0.01fs",math.abs(total - current) or -99.99))
--	local _,_,w,_ = interact_progress:text_rect()
--	floating_panel:set_w(w)
	
--	local itd = tweak_data.interaction[interact.tweak_data or ""] or {text_id = "ERROR"}
--	local interact_text_id = managers.localization:text(itd.text_id)
--	floating_panel:child("interact_name"):set_text(utf8.to_upper(interact_text_id or "ERROR"))

end

function NobleHUD:SetInteractValid(valid,id)
	local interact_panel = self._interact_panel
	local floating_panel = interact_panel:child("floating_panel")
	local interact_name = floating_panel:child("interact_name")
	if not valid then 
--		interact_name:hide()
		interact_name:set_color(self.color_data.hud_vitalsfill_red)
	else
--		interact_name:show()
		interact_name:set_color(self.color_data.hud_vitalsfill_blue)
	end
	
	if text_id then
		interact_name:set_text(managers.localization:to_upper_text(text_id))
--		local _,_,w,_ = interact_name:text_rect()
--		floating_panel:set_w(w)
	end
end

function NobleHUD:AnimateInteractDone()
	local interact_panel = self._interact_panel
	
	self:animate(interact_panel,"animate_interact_done",function()
		NobleHUD:HideInteract()
	end,0.75,interact_panel:w())
end

function NobleHUD:animate_interact_done(o,t,dt,start_t,duration,start_w)
--	local floating_panel = o:child("floating_panel")
	local ratio = (t - start_t) / duration
--	Console:SetTrackerValue("trackera",ratio)
	if ratio >= 1 then 
		o:set_w(start_w)
		o:child("floating_panel"):child("interact_progress"):set_text("")
		return true
	end
	o:set_w(start_w * (1 - math.pow(ratio,2)))
end


-- 		KILLFEED

function NobleHUD:_create_killfeed(hud)
	local killfeed_panel = hud:panel({
		name = "killfeed_panel",
		h = hud:w() / 2
--		w = 100,
--		h = 100,
	})
	
	local debug_medal = killfeed_panel:rect({
		name = "debug",
		visible = false,
		color = Color.red,
		alpha = 0.1
	})
	
	self._killfeed_panel = killfeed_panel
end


function NobleHUD:AddKillfeedMessage(text,params)
	params = params or {}
	local killfeed = self._killfeed_panel
	self.num_killfeed_messages = self.num_killfeed_messages + 1

	local function add_text_to_killfeed (text_panel)
		self._cache.newest_killfeed = nil
		table.insert(self.killfeed,1,{start_t = Application:time(),text = text_panel,lifetime = params.lifetime})
	end
	
	local label = killfeed:text({
		name = "label_" .. self.num_killfeed_messages,
		layer = 1,
		x = self._killfeed_start_x,
		y = self._killfeed_start_y,
		text = text,
		color = Color.white,
		align = "left",
		font = params.font or tweak_data.hud_players.ammo_font,
		font_size = 0, --set to nonzero once it starts
		alpha = 0.9
	})
	if self._cache.newest_killfeed and alive(self._cache.newest_killfeed) then 
		NobleHUD:animate_remove_done_cb(self._cache.newest_killfeed)
--			function(o)
--				self:animate(o,"animate_killfeed_text_in",nil,0.3,16,self.color_data.hud_text_blue,self.color_data.hud_text_flash)
--			end
--		)
		table.insert(self.killfeed,1,{start_t = Application:time(),text = self._cache.newest_killfeed})
	end
	self._cache.newest_killfeed = label
	
	self:animate(label,"animate_killfeed_text_in",add_text_to_killfeed,params.duration or 0.3,params.font_size,params.color_1 or self.color_data.hud_text_blue,params.color_2 or self.color_data.hud_text_flash)
	return label
end

function NobleHUD:AddMedal(category,rank) --from name
	local medal_data = self._medal_data[category]
--	self:log("Doing NobleHUD:AddMedal(" .. tostring(category) .. "," .. tostring(rank) .. ")",{color = Color.yellow})
	if rank and medal_data and medal_data[rank] then 
		return NobleHUD:AddMedalFromData(medal_data[rank],category)
	elseif medal_data and not rank then 
		return NobleHUD:AddMedalFromData(medal_data,category)
	elseif not (medal_data or rank) then
		self:log("ERROR: NobleHUD:AddMedal(" .. tostring(category) .. "," .. tostring(rank) .. ") (bad medal)",{color = Color.red})
	end
end

function NobleHUD:AddMedalFromData(data,category) --direct reference to table passed here
	local killfeed = self._killfeed_panel
	if not (data and data.icon_xy) then 
--		self:log("ERROR: bad data to AddMedalFromData(" .. tostring(data) .. ")")
		return
	elseif data.disabled then 
--		self:log("Did not add medal " .. tostring(category) .. " (disabled)")
		return
	end
		
	if data.sfx then 
		if data.hold_sfx then 
			self:AddDelayedCallback(function()
				self:PlayAnnouncerSound(data.sfx)
			end,
			nil,
			self:GetMultikillTime(),
			"medal_sfx_" .. tostring(category or "medalname")
			)
		else		
			self:PlayAnnouncerSound(data.sfx)
		end
	end
	
	if not self:IsMedalsEnabled() then 
		return
	end
	
	self.num_medals = self.num_medals + 1
	local texture,texture_rect = self:GetMedalIcon(unpack(data.icon_xy))
	local icon_size = 32
	local start_x = self._medal_start_x
	local start_y = self._medal_start_y

	local icon = killfeed:bitmap({
		name = "icon_" .. self.num_medals,
		texture = texture,
		texture_rect = texture_rect,
		w = icon_size,
		h = icon_size,
		halign = "grow",
		valign = "grow",
		rotation = 180, --upside down, spins half a rotation in its intro animation
		x = self._medal_start_x,
		y = self._medal_start_y,
		layer = 1,
		alpha = 1
	})
	
	local function add_bitmap_to_killfeed (bitmap)
		self._cache.newest_medal = nil
		table.insert(self.killfeed_icons,1,{start_t = Application:time(),bitmap = bitmap})
	end	
	
	if self._cache.newest_medal and alive(self._cache.newest_medal) then 
		NobleHUD:animate_remove_done_cb(self._cache.newest_medal,
			function(o)
				o:set_rotation(0)
				NobleHUD:animate(o,"animate_killfeed_icon_pulse",nil,0.3,icon_size,1.5)
			end
		)
		table.insert(self.killfeed_icons,1,{start_t = Application:time(),bitmap = self._cache.newest_medal})
	end
	self._cache.newest_medal = icon
	
	self:animate(icon,"animate_killfeed_icon_twirl",function(o) o:set_rotation(0); NobleHUD:animate(o,"animate_killfeed_icon_pulse",add_bitmap_to_killfeed,0.3,icon_size,1.5) end,0.25,180,start_x,start_y)
	
	local name = data.name and managers.localization:text("noblehud_medal_" .. data.name)
	
	if data.show_text or self:ShowAllMedalMessages() then 
		self:AddKillfeedMessage(name .. "!",{font_size = 16})
	end
	return icon
end


function NobleHUD:animate_killfeed_text_in(o,t,dt,start_t,duration,font_size,color_1,color_2,...)
	duration = duration or 3
	font_size = font_size or 12
	local ratio = (t - start_t) * (1/duration)
	local sine = math.max(0,math.sin(math.deg(math.pi * ratio)))
	o:set_font_size((1 + sine) * font_size)
	o:set_color(self.interp_colors(color_1,color_2,sine))
	if start_t + duration < t then
		return true
	end
end

function NobleHUD:animate_killfeed_icon_twirl(o,t,dt,start_t,duration,add_angle,x,y,...)
	duration = duration or 3
	add_angle = add_angle or 360
	local ratio = dt / duration
--	o:set_center(x,y)
	if start_t + duration < t then
		return true
	else	
		o:set_rotation(o:rotation() + (ratio * add_angle))
	end
end

function NobleHUD:animate_killfeed_icon_pulse(o,t,dt,start_t,duration,icon_size,pulse_multiplier,x,y,...)
	duration = duration or 0.25
	icon_size = icon_size or 24
	pulse_multiplier = (pulse_multiplier or 2) - 1
	
	local ratio = (t - start_t) * (1/duration)
	local sine = math.max(0,math.sin(math.deg(math.pi * ratio)))
	local size = icon_size * (1 + (pulse_multiplier * sine))
	if start_t + duration < t then 
		o:set_size(icon_size,icon_size)
		return true
	else
		o:set_size(size,size)
	end
end


--		BUFFS

function NobleHUD:_create_buffs(hud) --buffs, cloned from khud (not implemented)
	local buffs_panel = hud:panel({
		name = "buffs_panel",
		w = 300,
		h = 300,
		x = 600,
		y = 600
	})
	local debug_buffs = buffs_panel:rect({
		color = Color.green,
		visible = false,
		alpha = 0.1
	})
end

function NobleHUD:AddBuff(id,params)

end


--		HELPER

function NobleHUD:_create_helper(hud) --auntie dot avatar and subtitles
	local helper_panel = hud:panel({
		name = "helper_panel",
		layer = 1,
		w = 400,
		h = 400,
		x = hud:right() - 400,
		y = hud:bottom() - 400,
		visible = true --set visible on relevant event 
	})
	NobleHUD._helper_tubes = {}
	NobleHUD._helper_panel = helper_panel
	NobleHUD._helper_last_sequence = 1
	NobleHUD._helper_last_sequence_t = 0
	local helper_bg = helper_panel:rect({ --debug
		name = "helper_bg",
		color = Color.red,
		visible = false,
		alpha = 0.5
	})
	local ROWS = 16
	local COLUMNS = 16
	NobleHUD._HELPER_ROWS = ROWS
	NobleHUD._HELPER_COLUMNS = COLUMNS
	
	local subtitle = helper_panel:text({
		name = "subtitle",
		text = "This exceeds expectations.",
		font = "fonts/font_large_mf",
		font_size = 16,
		layer = 5,
		color = Color.white
	})

	local function create_tube(num)
		local angle = 45
	
		local row = 1 + (math.floor(num / COLUMNS))
		local column = 1 + (num % (COLUMNS))
		local even_c = NobleHUD.even(column)
		local even_r = NobleHUD.even(row)
		if not even_c then 
			angle = angle - 90
		end
		if even_r then 
			angle = angle + (90 * math.sign(angle))
		end
		
		local h_space = 20
		local w_space = 20
		
		local new_tube = helper_panel:bitmap({
			name = "tube_" .. row .. "_" .. column,
			texture = "guis/textures/helper_tube",
			w = 8,
			h = 17,
			x = w_space * column,
			y = h_space * row,
			layer = 2,
			alpha = 1,
			rotation = angle,
			color = self.color_data.hud_helper_bluefill
		})
		local new_tube_glow = helper_panel:bitmap({
			name = "tube_" .. row .. "_" .. column .. "_glow",
			texture = "guis/textures/helper_tube_glow",
			w = 8,
			h = 17,
			x = (w_space * column),
			y = h_space * row,
			layer = 1,
			alpha = 0.7,
			rotation = angle,
			blend_mode = "add",
			color = self.color_data.hud_helper_blueglow
		})
		local debug_tube = helper_panel:text({
			name = "debug_text_" .. num,
			text = tostring(num),
			font = tweak_data.hud.medium_font,
			font_size = 16,
			x = w_space * column,
			y = h_space * row,
			layer = 2,
			visible = false,
			alpha = 0.7,
			color = Color.white
		})
		return new_tube
	end
	
	for i = 0,(ROWS * COLUMNS) - 1 do 
		NobleHUD._helper_tubes[i] = {tube = create_tube(i)}
	end

end


--not implemented; see hudpresenter
function NobleHUD:animate_helper_subtitle_in(o,str)
	local text = o:text()
	local char_per_sec = 5
	local elapsed = Application:time() - NobleHUD._helper_current_event.start_t
	if text ~= str then
		o:set_text(string.sub(str,math.ceil(elapsed * char_per_sec)))
	end
end

function NobleHUD:helper_check_gameplay_event(event_id)
	--say something about the gameplay
	NobleHUD:_helper_comment(event_name)
end
function NobleHUD:helper_check_mission_event(event_id)
	--say something about the current mission objective
	NobleHUD:_helper_comment(event_name)
end
function NobleHUD:_helper_comment(event_name)
	local event_data = self.helper_data[event_name] --get subtitle/soundfile if extant 
	
	if event_data.sound then 
		--sound device: play sound
	end
	if event_data.subtitle then
		if not NobleHUD:helper_is_typing() then
			--set "currently speaking" to current event index to
		elseif event_data.can_queue_subtitle then 
			--queued?
		end
	end
	if event_data.patterns then 
		--queue patterns
	end
end
function NobleHUD:helper_is_typing()
	--return not self._helper_current_event
end

Hooks:Add("LocalizationManagerPostInit", "noblehud_addlocalization", function( loc )
	local path = NobleHUD._localization_path
	
	for _, filename in pairs(file.GetFiles(path)) do
		local str = filename:match('^(.*).txt$')
		if str and Idstring(str) and Idstring(str):key() == SystemInfo:language():key() then
			loc:load_localization_file(path .. filename)
			return
		end
	end
	loc:load_localization_file(path .. "english.txt")
end)

function NobleHUD:LoadSettings()
	local file = io.open(self._settings_path, "r")
	if (file) then
		for k, v in pairs(json.decode(file:read("*all"))) do
			self.settings[k] = v
		end
	else
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

Hooks:Add("MenuManagerInitialize", "noblehud_initmenu", function(menu_manager)
	
	
--SCORE
	
	MenuCallbackHandler.callback_noblehud_set_popups_enabled = function(self,item)
		NobleHUD.settings.popups_enabled = item:value() == "on"
		NobleHUD:SaveSettings()
	end
	
	MenuCallbackHandler.callback_noblehud_set_announcer_enabled = function(self,item)
		NobleHUD.settings.announcer_enabled = item:value() == "on"
		NobleHUD:SaveSettings()
	end

	MenuCallbackHandler.callback_noblehud_set_medals_enabled = function(self,item)
		NobleHUD.settings.medals_enabled = item:value() == "on"
		NobleHUD:SaveSettings()
	end
	
	MenuCallbackHandler.callback_noblehud_set_show_all_medals = function(self,item)
		NobleHUD.settings.show_all_medals = item:value() == "on"
		NobleHUD:SaveSettings()
	end

	MenuCallbackHandler.noblehud_score_options_close = function(self)
		--NobleHUD:SaveSettings()
	end
	
	MenuCallbackHandler.callback_noblehud_set_popup_style = function(self,item)
		NobleHUD.settings.popup_style = tonumber(item:value())
		NobleHUD:SaveSettings()
	end

	MenuCallbackHandler.callback_noblehud_set_popup_duration = function(self,item)
		NobleHUD.settings.popup_duration = tonumber(item:value())
		NobleHUD:SaveSettings()
	end

	MenuCallbackHandler.callback_noblehud_set_popup_font_size = function(self,item)
		NobleHUD.settings.popup_font_size = tonumber(item:value())
		NobleHUD:SaveSettings()
	end



	
--MISC	
	MenuCallbackHandler.callback_noblehud_set_stamina_enabled = function(self,item)
		NobleHUD.settings.stamina_enabled = item:value() == "on"
		NobleHUD:SaveSettings()
	end
	
	
--RADAR
	MenuCallbackHandler.callback_noblehud_set_radar_enabled = function(self,item)
		NobleHUD.settings.radar_enabled = item:value() == "on"
		NobleHUD:SetRadarEnabled(NobleHUD.settings.radar_enabled)
		NobleHUD:SaveSettings()
	end

	MenuCallbackHandler.callback_noblehud_set_radar_distance = function(self,item)
		NobleHUD.settings.radar_distance = tonumber(item:value())
		NobleHUD:SetRadarDistance(NobleHUD.settings.radar_distance)
		NobleHUD:SaveSettings()
	end	


--WEAPONS
	MenuCallbackHandler.callback_noblehud_set_floating_ammo_enabled = function(self,item)
		NobleHUD.settings.floating_ammo_enabled = item:value() == "on"
		NobleHUD:SaveSettings()
	end
	
	MenuCallbackHandler.noblehud_weapons_options_close = function(self)
		--NobleHUD:SaveSettings()
	end
	
--PLAYER
	MenuCallbackHandler.callback_noblehud_set_stamina_enabled = function(self,item)
		NobleHUD.settings.stamina_enabled = item:value() == "on"
		NobleHUD:SaveSettings()
	end
	
	MenuCallbackHandler.noblehud_player_options_close = function(self)
		--NobleHUD:SaveSettings()
	end
	

--CROSSHAIR	
	MenuCallbackHandler.callback_noblehud_set_crosshair_enabled = function(self,item)
		NobleHUD.settings.crosshair_enabled = item:value() == "on"
		if alive(NobleHUD._crosshair_panel) then 
			NobleHUD._crosshair_panel:set_visible(NobleHUD.settings.crosshair_enabled)
		end
		NobleHUD:SaveSettings()
	end

	MenuCallbackHandler.callback_noblehud_set_crosshair_bloom_enabled = function(self,item)
		NobleHUD.settings.crosshair_bloom = item:value() == "on"
		NobleHUD:SaveSettings()
	end
	
	MenuCallbackHandler.callback_noblehud_set_crosshair_shake_enabled = function(self,item)
		NobleHUD.settings.crosshair_shake = item:value() == "on"
		NobleHUD:SaveSettings()
	end

	MenuCallbackHandler.callback_noblehud_set_crosshair_stability = function(self,item)
		NobleHUD.settings.crosshair_stability = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	
	MenuCallbackHandler.callback_noblehud_set_crosshair_alpha = function(self,item)
		NobleHUD.settings.crosshair_alpha = tonumber(item:value())
		NobleHUD:SaveSettings()
	end

	MenuCallbackHandler.noblehud_crosshair_options_close = function(self)
		--NobleHUD:SaveSettings()
	end
	
	
	
	MenuCallbackHandler.callback_noblehud_close = function(self)
		--NobleHUD:SaveSettings()
	end
	
	MenuCallbackHandler.callback_noblehud_toggle_safety = function(self)		
	end
	
	NobleHUD:LoadSettings()
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options.txt", NobleHUD, NobleHUD.settings)
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_score.txt", NobleHUD, NobleHUD.settings)
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_crosshair.txt", NobleHUD, NobleHUD.settings)
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_radar.txt", NobleHUD, NobleHUD.settings)
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_weapons.txt", NobleHUD, NobleHUD.settings)
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_player.txt", NobleHUD, NobleHUD.settings)
end)
