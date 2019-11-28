--[[ 

FIX OBJECTIVE HUD REMIND UPDATE


***** TODO: *****
Notes:
		
	tab should refresh view_timer or call remind objective

	medals should not always necessarily show a killfeed message
		mod option? (currently save setting)

	&&& BEFORE RELEASE: &&&
		* HUD SHOULD BE CREATED OUTSIDE OF HUDMANAGER
	
	
		%% BUGS:
			- hide radar when in camera?
			- Rocket reticle will not proc???
			- CROSSHAIR DETECTION SHOULD BE FROM PLAYER, NOT CAMERA
			- Swapping while aiming at an enemy keeps the crosshair color
			- grenade kills don't proc sticky medal


		%% FEATURES: %%
			* Hostages panel
			* Interaction in top right (under weapons)
			* Carry panel
			* Chat panel
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
			* Fix custody/hud creation system
			* Score panel
				* Use basic; if JoyScore present, use this instead
					* Update JoyScore to hooks system to allow better compatibility
			* Tab menu
			* Stamina panel
			* Health variants (stoic health, ex-pres stored health, absorb overshields)
			* Mod options
				* Crosshair/reticle stuff
				* Placement and Scaling
				* Keybinds for Safety etc
			* Killfeed
				* Record medals with score
				* Show weapon icon (PLAYERNAME [WEAPON_ICON] ENEMYNAME) ?

			
	&& LOW PRIORITY FEATURES: &&
		* Weapon swap interrupts sprees? at least, it should for weapon-specific ones
		* Should graze kills give sniper medals? currently, they don't
		* Auntie dot
			* Subtitles: Auntie dot voice lines with associated queues
			* background non-lit grid should probably be invisible, or flicker to invisible after flickering off
			* should be layered over as the loading screen, and stretched to fit screen
			* during loading screen, should be under text but above blackscreen;
			* in-game, should be entirely below hud
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
		* Suspicion?
		* More Medals:
			* Seek and Destroy (for bosses?)
			* Bulltrue for Cloakers
			* EMP Blast for stunned enemies?
			* Hero or assist for reviving teammates?
			* Firebird for midair (jumping/falling) kills
			* Protector? hard to implement but not impossible
			* Yoink?
			* Pull for rappelling enemies?
			* Headcase somehow?
			* Reloading?

--current crosshair selection
			
	* on firemode change, switch crosshair visible
	* add crosshair data for everything lol
	* melee crosshair
	* based on weapon type
	* manually selectable 
	* customizable based on type
	* customizable alpha (master)
	
	&& BEAUTIFY EXISTING: &&
		* Grenade/Ability
			* Ability circle reduces with active ability time
			* Ability activation animation
			* Ability circle color should be colored blue by default
			* Counter is unreadable- needs shadow or better placement
				* shadow is better, to show during flashbangs
		* Visual ammo counter is out of control for large-mag weapons
			* Above x should just be a bar tbh
			* Saw should use a radial meter
			* Realign bullet tick alignments
		* Reticle/Weapon stuff
			* Streamline like the whole process, it's unreadable
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
			
--grenade outline
		-- Replacement tube for auntie dot
--score banner
--score banner small
--score icon (play icon)

- bloom funcs should all have a reference to their own crosshair tweakdata
- bloom funcs should also have reference to their own weapon tweakdata
- crosshair data blacklist should be replaced by a manual override list for weapon ids

-- add other medals?

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
	crosshair_enabled = true,
	crosshair_alpha = 0.5,
	crosshair_shake_enabled = true,
	crosshair_dynamic_color = true,
	crosshair_stability = 100,
	crosshair_static_color = {1,0,0},
	radar_enabled = true,
	radar_distance = 25,
	show_all_medals = true
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
	hud_lightblue = Color("a1f0ff"), --powder blue; unused
	hud_bluefill = Color("66cfff"), --sky blue; unused
	hud_blueoutline = Color("3173bb"),
--	hud_blueoutline = Color(168/255,203/255,255/255), --shield/hp outline color; unused
	hud_text = Color.white,
	hud_compass = Color("2EA1FF")
}

NobleHUD._mod_path = ModPath
NobleHUD._settings_path = ModPath .. "noblehud_settings.txt"
NobleHUD._localization_path = ModPath .. "localization/"
NobleHUD._cartographer_path = ModPath .. "cartographer/"

NobleHUD._cartographer_data = {}

NobleHUD._presenter_title_params = {
	duration = 0.25,
	lifetime = 7,
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

NobleHUD._HUD_HEALTH_TICKS = 8
NobleHUD._RADAR_REFRESH_INTERVAL = 0.5
NobleHUD._radar_refresh_t = 0
NobleHUD._cache = {
	game_state = "",
	current_objective = "",
	objective_progress = nil,
	objective_total = nil,
	newest_medal = false,
	newest_killfeed = false,
	last_cartographer_t = 0,
	kills = {
		close_call = false,
		last_kill_t = 0,
		spree_count = 0,
		multi_count = 0,
		melee = 0,
		sniper = 0,
		shotgun = 0,
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
		texture_rect = {
			1,2,3,4
		},
		icon_w = 2,
		icon_h = 8
	},
	pistol = {
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_pis",
		texture_rect = {
			1,2,3,4
		},
		icon_w = 2,
		icon_h = 8
	},
	lmg = {
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_ar",
		texture_rect = {
			1,2,3,4
		},
		icon_w = 2,
		icon_h = 8
	},
	snp = {
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_ar",
		texture_rect = {
			1,2,3,4
		},
		icon_w = 2,
		icon_h = 8
	},
	smg = {
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_smg",
		texture_rect = {
			1,2,3,4
		},
		icon_w = 2,
		icon_h = 8
	},
	flamethrower = {
		use_bar = true,
		texture = "guis/textures/ammo_flame",
		texture_rect = {
			1,2,3,4
		},
		icon_w = 100,
		icon_h = 8
	},
	saw = {
		use_bar = true,
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_saw",
		texture_rect = {
			1,2,3,4
		},
		icon_w = 100,
		icon_h = 8
	},
	minigun = {
		use_bar = true,
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_minigun",
		texture_rect = {
			1,2,3,4
		},
		icon_w = 100,
		icon_h = 8
	},
	xbow = {
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_xbow",
		texture_rect = {
			1,2,3,4
		},
		icon_w = 2,
		icon_h = 8
	},
	bow = {
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_bow",
		texture_rect = {
			1,2,3,4
		},
		icon_w = 2,
		icon_h = 8
	},
	grenade_launcher = {
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_gl",
		texture_rect = {
			1,2,3,4
		},
		icon_w = 2,
		icon_h = 8
	},
	rocket_launcher = { --not technically a separate weapon category
		texture = "guis/textures/bullet_tick" or "guis/textures/ammo_rpg",
		texture_rect = {
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
	m308 = {"dmr"},
	rpg7 = {"rocket"},
	ray = {"rocket"}
}

NobleHUD._crosshair_textures = { --organized by reach crosshairs
	assault_rifle = { --four circle subquadrants; four oblong aiming ticks
		blacklisted = {
			m308 = true,
			cavity = true
		},
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
		blacklisted = {},
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
--			Log("Performing bloom for index " .. tostring(index) .. ":" .. tostring(bitmap) .. tostring(bitmap:visible()))
--			Console:SetTrackerValue("trackerb",bloom)
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
		blacklisted = {},
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
		blacklisted = {},
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
		blacklisted = {},
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
		blacklisted = {},
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
		blacklisted = {},
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
		blacklisted = {},
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
		blacklisted = {},
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
		blacklisted = {
		},
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
		blacklisted = {},
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
	cop = false, --false means disabled
	cop_female = false,
	city_swat = false,
	security = false,
	bolivian = false,
	bolivian_indoors = false,
	civilian = -50,
	civilian_female = -50,
	sniper = 3, --sniper
	shield = 5, --shield
	phalanx_minion = 5, --winters shield
	medic = 6, --medic
	taser = 7, --taser
	spooc = 10, --cloaker 
	tank = 12 --dozer (all variants)
}

NobleHUD.score_multipliers = {
	headshot = 2,
	difficulty = {
		easy = 1,
		normal = 2,
		overkill = 3.5,
		overkill_145 = 4,
		easy_wish = 5.5,
		overkill_290 = 6,
		sm_wish = 6.5
	}
}

NobleHUD.score_popups = {}
NobleHUD.score_session = 0
NobleHUD.score_popups_count = 0
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

NobleHUD._killfeed_start_x = 100
NobleHUD._killfeed_start_y = 420
NobleHUD._killfeed_end_x = 100
NobleHUD._killfeed_end_y = 430

NobleHUD._medal_start_x = 64
NobleHUD._medal_start_y = 400
NobleHUD._medal_end_x = 64
NobleHUD._medal_end_y = 400

NobleHUD._medal_atlas = "guis/textures/medal_atlas"

NobleHUD._medal_data = {
	first = { --not implemented
		name = "First Strike",
		sfx = "first_strike",
		icon_xy = {1,0}
	},
	headshot = {
		name = "Headshot",
		sfx = "",
		icon_xy = {1,1}
	},
	pummel = {
		name = "Pummel",
		sfx = "",
		icon_xy = {1,2}
	},
	assassination = {
		name = "Assassin",
		sfx = "",
		icon_xy = {1,3}
	},
	beatdown = {
		name = "Beat Down",
		sfx = "",
		icon_xy = {1,4}
	},
	close_call = {
		name = "Close Call",
		sfx = "",
		icon_xy = {1,5}
	},
	revenge = { --not implemented
		name = "Revenge",
		sfx = "",
		icon_xy = {1,6}
	},
	avenger = { --not implemented
		name = "Avenger",
		sfx = "",
		icon_xy = {1,7}
	},
	grave = {
		name = "Kill from the Grave!",
		sfx = "",
		icon_xy = {1,8}
	},
	multikill = {
		[2] = {
			name = "Double Kill",
			sfx = "",
			icon_xy = {0,0}
		},
		[3] = {
			name = "Triple Kill",
			sfx = "",
			icon_xy = {0,1}
		},
		[4] = {
			name = "Overkill", --obligatory joke here
			sfx = "",
			icon_xy = {0,2}
		},
		[5] = {
			name = "Killtacular",
			sfx = "",
			icon_xy = {0,3}
		},
		[6] = {
			name = "Killtrocity",
			sfx = "",
			icon_xy = {0,4}
		},
		[7] = {
			name = "Killimanjaro",
			sfx = "",
			icon_xy = {0,5}
		},
		[8] = {
			name = "Killtastrophe",
			sfx = "",
			icon_xy = {0,6}
		},
		[9] = {
			name = "Killpocalypse",
			sfx = "",
			icon_xy = {0,7}
		},
		[10] = {	
			name = "Killionaire",
			sfx = "",
			icon_xy = {0,8}
		}
	},
	spree_standard = {		
		[10] = {
			name = "Killing Spree",
			sfx = "",
			icon_xy = {2,0}
		},
		[20] = {
			name = "Killing Frenzy",
			sfx = "",
			icon_xy = {2,1}
		},
		[30] = {
			name = "Running Riot",
			sfx = "",
			icon_xy = {2,2}
		},
		[40] = {
			name = "Rampage",
			sfx = "",
			icon_xy = {2,3}
		},
		[50] = {
			name = "Untouchable",
			sfx = "",
			icon_xy = {2,4}
		},
		[100] = {
			name = "Invincible",
			sfx = "",
			icon_xy = {2,5}
		},
		[500] = {
			name = "Inconceivable",
			sfx = "",
			icon_xy = {2,6}
		},
		[1000] = {				
			name = "Unfrigginbelievable",
			sfx = "",
			icon_xy = {2,7}
		}
	},
	spree_assist = { --not implemented
		[1] = {
			name = "Assist",
			sfx = "",
			icon_xy = {3,0}
		},
		[5] = {		
			name = "Assist Spree",
			sfx = "",
			icon_xy = {3,1}
		},
		[10] = {
			name = "Sidekick",
			sfx = "",
			icon_xy = {3,2}
		},
		[15] = {
			name = "Second Gunman",
			sfx = "",
			icon_xy = {3,3}
		}
	},
	spree_sword = { --not implemented
		[5] = {
			name = "Sword Spree",
			name = "",
			sfx = "",
			icon_xy = {3,4}
		},
		[10] = {
			name = "Slice 'n Dice",
			sfx = "",
			icon_xy = {3,5}
		},
		[15] = {
			name = "Cutting Crew",
			sfx = "",
			icon_xy = {3,6}
		}
	},
	spree_grenade = { --not implemented properly
		[5] = {
			name = "Stick Spree",
			sfx = "",
			icon_xy = {3,7}
		},
		[10] = {
			name = "Sticky Fingers",
			sfx = "",
			icon_xy = {3,8}
		},
		[15] = {
			name = "Corrected",
			sfx = "",
			icon_xy = {3,9}
		}
	},
	spree_sniper = {
		[1] = {
			name = "Sniper Kill", --headshot only
			sfx = "",
			icon_xy = {4,0}
		},
		[5] = {
			name = "Sniper Spree",
			sfx = "",
			icon_xy = {4,1}
		},
		[10] = {
			name = "Sniper Spree",
			sfx = "",
			icon_xy = {4,2}
		},
		[15] = {
			name = "Be the Bullet",
			sfx = "",
			icon_xy = {4,3}
		}
	},
	spree_shotgun = {
		[5] = {
			name = "Shotgun Spree",
			sfx = "",
			icon_xy = {4,4}
		},
		[10] = {
			name = "Open Season",
			sfx = "",
			icon_xy = {4,5}
		},
		[15] = {
			name = "Buck Wild",
			sfx = "",
			icon_xy = {4,6}
		}
	},
	spree_splatter = { --not implemented
		[5] = {
			name = "Splatter Spree",
			sfx = "",
			icon_xy = {4,7}
		},
		[10] = {
			name = "Vehicular Manslaughter",
			sfx = "",
			icon_xy = {4,8}
		},
		[15] = {
			name = "Sunday Driver",
			sfx = "",
			icon_xy = {4,9}
		}
	},
	spree_wheelman = { --not implemented
		[1] = {
			name = "Wheelman",
			sfx = "",
			icon_xy = {1,9}
		},
		[5] = { --couldn't find the icons for these
			name = "Wheelman Spree",
			sfx = "",
			icon_xy = {1,9}
		},
		[10] = {
			name = "Road Hog",
			sfx = "",
			icon_xy = {1,9}
		},
		[15] = {
			name = "Road Rage",
			sfx = "",
			icon_xy = {1,9}
		}
	}
}

NobleHUD.num_medals = 0

NobleHUD._animate_targets = {
--[[ example:
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
	if NobleHUD._animate_targets[tostring(object)] then 
--		Log("Replaced existing animate target " .. tostring(object))
	else
--		Log("Added new animate target " .. tostring(object))
	end
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
	
	o:set_alpha(1 - ratio)
	if exit_y then 
		o:set_y(o:y() + (exit_y * dt / duration))
	end
	if exit_x then 
		o:set_x(o:x() + (exit_x * dt / duration))
	end
	if ratio >= 1 then 
		o:set_alpha(0)
		return true
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
	return self.settings.crosshair_shake_enabled
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
	return 2
end

function NobleHUD:ShowAllMedalMessages()
	return self.settings.show_all_medals
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
	self.settings.radar_enabled = enabled
end

function NobleHUD:SetRadarDistance(distance)
	if alive(self._radar_panel) then 
		self:_set_radar_range(distance)
	end
	self.settings.distance = distance
end


--		HUD UPDATE STUFF / EVENT FUNCTIONS

function NobleHUD:CreateHUD(orig)
	if not orig:alive(PlayerBase.PLAYER_INFO_HUD_PD2) then 
		return
	end	
	self._ws = managers.gui_data:create_fullscreen_workspace()
	local ws = self._ws
	
	local hud = ws:panel() --master panel
--	hud:set_visible(false)
	--armor and shields share the same master panel
	self:_create_vitals(hud)
	self:_create_weapons(hud)
	self:_create_grenades(hud) --this refers to the element in the top left; either deployables or grenades may be displayed here
	self:_create_ability(hud) --this refers to the element in the bottom left (above radar); either deployables or grenades may be displayed here
	self:_create_objectives(hud) 
	self:_create_crosshair(hud)
	self:_create_compass(hud)
	self:_create_radar(hud)
	self:_create_cartographer(hud)
	self:_create_buffs(hud)
	self:_create_helper(hud)
	self:_create_carry(hud)
	self:_create_equipment(hud)
	self:_create_teammates(hud)
	self:_create_score(hud)
	self:_create_killfeed(hud)
	self:_create_tabscreen(hud)
--	managers.hud:script("guis/mask_off_hud"):hide()
end
			
function NobleHUD:OnLoaded()
	self:set_weapon_info()
	self:create_revives()
	self:_set_deployable_equipment(2,true)
	self:set_score_multiplier()
	managers.hud:add_updator("NobleHUD_update",callback(NobleHUD,NobleHUD,"UpdateHUD"))
	self:_switch_weapons(managers.player:local_player():inventory():equipped_selection())
	if self:IsCrosshairEnabled() then 
		self._crosshair_panel:set_alpha(self:GetCrosshairAlpha())
		
		if not self:UseCrosshairDynamicColor() then 		
			self:_set_crosshair_color(self:GetCrosshairStaticColor()) 
			--todo switch crosshair to static color on weapon switch
		end	
	end
	
	local level_data = managers.job:current_level_data()
	local level_name = level_data and level_data.name_id
	self:set_mission_name(level_name and managers.localization:text(level_name) or "")
	self:LoadCartographerData(level_name)
			
	managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2).panel:child("teammates_panel"):hide()
	
	self:_set_radar_range(self:GetRadarDistance())
	
	--[[
	for id,data in pairs(managers.criminals._characters) do 
		if data.taken then 
--			local peer_id = 
--			if data.data.ai then 
--				Log(i .. " is bot",{Color = tweak_data.chat_colors[peer_id]})
--			end
			Log("Found taken: " .. tostring(data.name) .. ",id = " .. tostring(id) .. ",peer_id = " .. tostring(data.peer_id) .. ",bot = " .. tostring(data.data and data.data.ai))
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
			Log(tostring(id) .. " Nobody here!")
		end
	end--]]
	
	
	
	
--layout hud stuff
	self:_sort_teammates()
	if managers.hud:script("guis/mask_off_hud") then 
		managers.hud:script("guis/mask_off_hud").panel:hide()
	end
end

function NobleHUD:UpdateHUD(t,dt)
--[[
	if game_state_machine then 
		local game_state = game_state_machine:current_state_name()		
		if self._cache.game_state ~= game_state then 
			Hooks:Call("OnGameStateChange",t,self._cache.game_state,game_state)
			self._cache.game_state = game_state
		end
	end

	
	--]]
	local player = managers.player:local_player()
	if player then 
			

		--medal stuff
		if self:KillsCache("close_call") and player:character_damage():armor_ratio() >= 1 then 
			self:KillsCache("close_call",false,true)
			self:AddMedal("close_call")
		end
	
	
	
--		Console:SetTrackerValue("trackera",self:KillsCache("last_kill_t"))
--		Console:SetTrackerValue("trackerb",t)
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
			
		
		
		--self:get_fire_weapon_position(), self:get_fire_weapon_direction()
	--return managers.player:local_player():movement():current_state():get_fire_weapon_direction()
	--:rotation():yaw()
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
		
--		Console:SetTrackerValue("trackera",cam_aim)
--		Console:SetTrackerValue("trackerb",self._compass_panel:child("compass_strip"):x())
--		Console:SetTrackerValue("trackerc",compass_yaw)
		
--		Console:SetTrackerValue("trackerd",compass_yaw)
		
		--(0.5 + (math.rad(cam_aim * 0.5) / math.pi)) - 1
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
			
-- ************** CROSSHAIR ************** 
			if true then --crosshair enabled
				local fwd_ray = player:movement():current_state()._fwd_ray	
				local focused_person = fwd_ray and fwd_ray.unit
	--			local crosshair = self._crosshair_panel::child("crosshair_subparts"):child("crosshair_1") --todo function to handle crosshair modifications
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
					local c_w = (c_p.x or 0) -- + (self._crosshair_panel:w() / 2)
					local c_h = (c_p.y or 0) -- + (self._crosshair_panel:h() / 2)
		--			Console:SetTrackerValue("trackerc",tostring(c_w))
		--			Console:SetTrackerValue("trackerd",tostring(c_h))
					self._crosshair_panel:set_center(c_w,c_h)	
				end
				
				--bloom
				if true then 
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
					
					if true then --special crosshairs like grenade launcher altimeter
						self:_set_crosshair_altimeter(viewport_cam:rotation():pitch())
					end
					
				end
			end
		end
		

-- ************** SCORE ************** 
		if false then 
		--starting positions for score popups
			for i,popup_data in pairs(score_popups) do 
				local popup_start_x = popup_data.x
				local popup_start_y = popup_data.y
				local popup_unit = popup_data.unit
				if popup_data.expire_t < t then 
					popup_data.element:remove()
				else
					if style == "nightfall" then --the classic emerge casually from center, rise upward
					
					elseif style == "bob" then --the classic spawn downward, float upward
					
					elseif style == "bluespider" then --stick to killed units' heads
					
					elseif style == "athena" then --spawn at killed units' heads
					
					end
				end
			end
		end
		
		
		self:_set_mission_timer(NobleHUD.format_seconds(managers.game_play_central:get_heist_timer()))
				
--		local brush_1 = Draw:brush(Color.green)
--		local brush_2 = Draw:brush(Color.red)
		
--		brush_1:line(state:get_fire_weapon_position(),state:get_fire_weapon_position() + (state:get_fire_weapon_direction() * 5000))
--		brush_2:line(viewport_cam:position(),viewport_cam:position() + (cam_rot_a * 5000))
		
--		Console:SetTrackerValue("trackera",tostring(managers.player:local_player():movement():current_state():get_fire_weapon_direction()))
--		Console:SetTrackerValue("trackerb",tostring(cam_rot_a))
		
		

		if t > self._helper_last_sequence_t then
--			self._helper_last_sequence_t = t + 3
			--set new sequence
--			self._current_helper_pattern = self.choose({"dot","lotus","x"})
--			managers.hud:_set_helper_pattern()
		end
		--[[
		if t > Console._dot_last_t then
			Console._dot_last_t = t + 3
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
			local p = random_index(Console._patterns)
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
--			table.remove(NobleHUD._delayed_callbacks,i)
		end
	end
	--[[
	for k,v in pairs(NobleHUD._bgboxes) do
		if v:parent() and v:parent():name() == "objectives_panel" then	
			Console:SetTrackerValue("trackerb",tostring(v:visible()))
			Console:SetTrackerValue("trackerc",tostring(v:parent():visible()))
			Console:SetTrackerValue("trackerd",tostring(v:parent():parent():visible()))
		end
	end
	--]]
	--Console:SetTrackerValue("trackerb",tostring(managers.hud._hud_objectives._bg_box:visible()))
	--Console:SetTrackerValue("trackerb",tostring(managers.hud._hud_temp._bg_box:visible()))
	
end

function NobleHUD:OnEnemyKilled(data)
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
	Log("Killed " .. tostring(data.type) .. " with " .. tostring(weapon_id) .. "/" .. tostring(data.variant))
	if data.type and data.type == "neutral" or data.type == "civilians" then 
		self:ClearKillsCache()
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
			if data.cool then --trigger implemented in copdamage
				self:AddMedal("beatdown")
			end
			if data.from_behind then --trigger implemented in copdamage
				self:AddMedal("assassination")			
			end
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
				self:AddMedal("spree_sticky",self:KillsCache("grenade",1))
			end
		else
			self:log("Killed " .. tostring(unit_name) .. " with misc weapon " .. tostring(weapon_id or weapon_unit))
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
							self:AddMedal("spree_sniper",1)
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
			self:AddMedal("spree_standard",spree_count)
			self:KillsCache("last_kill_t",t,true)
		end

	end
--	self:log(data.type or "nope") --team
	self:_tally_score(data)
end

function NobleHUD:KillsCache(category,amount,set)
	if amount ~= nil then 
		if set then 
			self._cache.kills[category] = amount
		elseif type(self._cache.kills[category]) == "number" then 
			self._cache.kills[category] = self._cache.kills[category] + (tonumber(amount or 0) or 0)
		end
		return self._cache.kills[category]
	elseif set ~= nil then
		--self:log("Error: No killcount category found for " .. tostring(category),{color = Color.red})
	end
	return self._cache.kills[category]
end

function NobleHUD:ClearKillsCache()
	self._cache.kills = {
		last_kill_t = 0,
		spree_count = 0,
		multi_count = 0,
		melee = 0,
		sniper = 0,
		shotgun = 0,
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
	if state == "fatal" or state == "bleed_out" or state == "arrested" or state == "incapacitated" then 
		self:ClearKillsCache()
	end
	--todo: on enter custody, destroy NobleHUD hud, and create or show custody hud
end

function NobleHUD:OnGameStateChanged(before_state,state)
	if before_state == "ingame_waiting_for_players" then 
		--show player hud
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
			text = "60",
--			align = "right",
--			vertical = "bottom",
			y = weapon_icon:y(),
--			x = weapon_icon:right() - 12,
			color = self.color_data.white,
			alpha = 0.66,
			font = "fonts/font_eurostile_ext",
			font_size = 12,
			layer = 6
		})
		local reserve_label = panel:text({ --total ammo count for current weapon
			name = "reserve_label",
			text = "120",
			align = "right",
			vertical = "top",
			color = self.color_data.white,
			x = -24,
--			alpha = 0.5,
			font = "fonts/font_eurostile_ext",
			font_size = 12,
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
					ammo_icon:set_alpha(0.3)
				else 
					ammo_icon:set_alpha(0.8)
				end
				
			end
		end
	end
end

function NobleHUD:_set_weapon_label(slot,id)
	local weapon_panel = self._master_weapon_panel
	local weapon_name = "The Gun That Can Kill The Past"
	id = id or 
	self:log(tostring(slot) .. ":" .. tostring(id))
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
		end
		self:_set_weapon_icon(i,base:get_name_id())
		self:_set_weapon_mag(i,base:get_ammo_remaining_in_clip())
		self:_set_weapon_reserve(i,base:get_ammo_total() - base:get_ammo_remaining_in_clip())
	end
	
--	self:_set_weapon_label(id,weapons[id].unit:base():get_name_id()) --only one shared weapon label, used by master weapon panel
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
--		self:log(tostring(progress) .. "/" .. tostring(t))
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
--		self:log(tostring(progress) .. "/" .. tostring(t))
	end


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
	OffyLib:c_log("Toggled firemode" .. tostring(slot) .. tostring(firemode))
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
	local categories = self._crosshair_override_data[weapon_id] or base:categories()

	if base:gadget_overrides_weapon_functions() then 
		
		--get weapon type from gadget
	else

		--todo get user settings for weapon categories to crosshair types
		
		for _,cat in pairs(categories) do 
			if cat == "assault_rifle" then 
				if (fire_mode == "single") then
			
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
--		self:log("modepanel for " .. firemode_current .. " is alive, pretended to set visible(true) [is currently " .. tostring(slotpanel:child(firemode_current):visible()) .. "]")
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
--!			self:log("Setting crosshair in slot " .. tostring(slot) .. " to " .. (visisble and "visible" or "hidden"))
		else
--!			self:log("ERROR: _set_crosshair_in_slot_visible(" .. concat({slot,visible},",") .. "): Bad slot")
			return
		end
	else
		for i,j in pairs(managers.player:local_player():inventory():available_selections()) do 
			local slotpanel = self._crosshair_panel:child("crosshair_slot" .. tostring(i))
			if alive(slotpanel) then 
--				self:log("Setting crosshair in slot " .. tostring(slot) .. " to i: " .. tostring(i) .. "," .. tostring(i == slot))
--!				self:log("Setting crosshair in slot " .. tostring(slot) .. " to " .. (i == slot and "visible" or "hidden"))
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
	local a = crosshair_data.bloom_func -- or function(index,bitmap,data) end
--	Log(tostring(a) .. tostring(Application:time() .. tostring(bloom)))
	self:get_current_crosshair_parts(a,data or {})
end

function NobleHUD:_add_weapon_bloom(amount)
	self.weapon_data.bloom = math.clamp(self.weapon_data.bloom + amount,0,1)
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

--	Console:SetTrackerValue("trackerc","")
--	Console:SetTrackerValue("trackerd","")
	
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
--	Log(tostring(slot) .. tostring(firemode))
--	Console:SetTrackerValue("trackerc",slot)
--	Console:SetTrackerValue("trackerd",firemode)
	
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
	
--	NobleHUD:log("GRENADES DATA")
--	NobleHUD:log("grenades end_time: " .. end_time)
--	NobleHUD:log("grenades duration: " .. duration)
	
	if not end_time or not duration then
		grenades_outline:stop()
		grenades_outline:set_color(Color(0.5, 0, 1, 1))

		return
	end

--	NobleHUD:log("GRENADES DATA END")
	local function animate_radial(o)
		repeat
			local now = managers.game_play_central:get_heist_timer()
			local time_left = end_time - now
			local progress = 1 - time_left / duration

			o:set_color(Color(0.5, progress, 1, 1))
			coroutine.yield()
		until time_left <= 0

--		o:set_color(Color(0.5, 0, 1, 1))
	end

	grenades_outline:stop()
	grenades_outline:animate(animate_radial)

	--[[

	local current = data.current
	local total = data.total
	local ratio = current / total
	self:log("GRENADES DATA")
	self:log("grenades current: " .. current)
	self:log("grenades total: " .. total)
	self:log("grenades ratio: " .. ratio)

	grenades_outline:set_visible(current ~= total)
	grenades_outline:set_color(ratio,total,0)
--]]
end

function NobleHUD:_activate_ability_radial(time_left,time_total)

	self:log("grenades time_left: " .. time_left)
	self:log("grenades time_total: " .. time_total)

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
--		self:log(tostring(progress) .. "/" .. tostring(t))
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
--		self:log(tostring(progress) .. "/" .. tostring(t))
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
		color = self.color_data.hud_bluefill,
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

function NobleHUD:set_score_multiplier() --hud only
	local multiplier = self:get_total_global_score_multiplier()
	self:_set_score_multiplier(string.format("%0.02fx",multiplier))
end

function NobleHUD:_set_score_multiplier(text) --hud only
	self._score_panel:child("score_multiplier_label"):set_text(text)
end

function NobleHUD:_set_mission_timer(text) --hud only
	self._score_panel:child("mission_timer"):set_text(tostring(text))
end

function NobleHUD:set_mission_name(level_name)
	self:_set_mission_name(level_name)
	
	local player_box = self._tabscreen:child("scoreboard")
	local skull_char = "" 
	local difficulty_index = managers.job:current_difficulty_stars()
	player_box:child("title_box"):child("title_label"):set_text(level_name .. " /// " .. string.rep(skull_char .. " ",difficulty_index))
	player_box:child("title_box"):child("title_label_2"):set_text(utf8.to_upper(Global.game_settings.difficulty))
end

function NobleHUD:_set_mission_name(text)
	local objectives_panel = self._objectives_panel
	objectives_panel:child("mission_label"):set_text(text)
end

function NobleHUD:_get_score_from_unit(unit_name)
	return NobleHUD.score_unit_points[unit_name] or 10
end

function NobleHUD:get_total_global_score_multiplier(mult) --arg optional
	local difficulty = Global.game_settings and Global.game_settings.difficulty
	mult = mult or 1
	mult = mult * (self.score_multipliers.difficulty[difficulty or "easy"] or 1)
	
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

function NobleHUD:set_score_label()
	if not JoyScoreCounter then 
		self._score_panel:child("score_label"):set_text(NobleHUD.make_nice_number(self.score_session))
	end
end

function NobleHUD:_add_score(score)
	self.score_session = self.score_session + (tonumber(score or 0) or 0)
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

Hooks:Add("JoyScoreCounter_SetScore","noblehud_joyscore_integration",function(total,new)
	NobleHUD._score_panel:child("score_label"):set_text(NobleHUD.make_nice_number(total))
end)

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
--	Log(title_w,{color=Color.red})
--	Log(label_w,{color=Color.blue})
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
		NobleHUD:log("No file for map [" .. map_id .. "]",{color = Color(1,0.5,0)})
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
					else
--						KineticHUD:c_log("Z",k)
--						KineticHUD:c_log(v.z_upper,v.z_lower)
					end
				else
--					KineticHUD:c_log("Y",k)
--					KineticHUD:c_log(v.y_lower,v.y_upper)
				end
			else
--				KineticHUD:c_log("X",k)
--				KineticHUD:c_log(v.x_lower,v.x_upper)
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

function NobleHUD:_create_carry(hud)
	local carry_panel = hud:panel({
		name = "carry_panel",
		h = 50,
		w = 400,
		x = 500,
		y = 500,
		visible = false
	})
	local debug_carry = carry_panel:rect({
		name = "debug_carry",
		color = Color.red,
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
		x = 0,
		y = 0,
		vertical = "bottom",
		align = "center",
		font = "fonts/font_medium_mf",
		font_size = 24,
		layer = 1,
		color = Color.white
	})
	
	
	
	
	
end

function NobleHUD:animate_show_bag(o,t,dt,start_t)

end

function NobleHUD:animate_hide_bag(o,t,dt,start_t)

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
--		Log(panel:name() .. "," .. tostring(new))
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

function NobleHUD:AddMedal(name,rank) --from name
	local medal_data = self._medal_data[name]
	self:log("Doing NobleHUD:AddMedal(" .. tostring(name) .. "," .. tostring(rank) .. ")",{color = Color.yellow})
	if rank and medal_data and medal_data[rank] then 
		return NobleHUD:AddMedalFromData(medal_data[rank])
	elseif medal_data and not rank then 
		return NobleHUD:AddMedalFromData(medal_data)
	else
--		self:log("ERROR: NobleHUD:AddMedal(" .. tostring(name) .. "," .. tostring(rank) .. ") (bad medal)",{color = Color.red})
	end
end

function NobleHUD:AddMedalFromData(data) --direct reference to table passed here
	local killfeed = self._killfeed_panel
	if not (data and data.icon_xy) then 
		self:log("ERROR: bad data to AddMedalFromData(" .. tostring(data) .. ")")
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
	
	if data.sfx then 
		--play sound sfx here
	end
	if data.show_message or self:ShowAllMedalMessages() then 
		self:AddKillfeedMessage(data.name,{font_size = 16})
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
--		Log("Completed animation 1 ".. tostring(start_t+duration) .. " < " .. tostring(t))
		return true
	else
--		Log(math.floor(ratio * 100) .. ": " .. sine,{color = Color(0,1,1)})
--		Log(math.max(0,math.sin(math.pi * (t - start_t) * (1/duration))) * font_size)
--		Log((t - start_t )/duration,{color = Color.blue})
--		Log(math.sin(math.pi * (t - start_t) * (1/duration)),{color = Color.green})
--		Log(tostring(start_t+duration) .. " < " .. tostring(t))
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
		visible = false --set visible on relevant event 
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
		if even_c then 
			if even_r then 
				angle = -135
			else
				angle = 135
			end
		else
			if even_r then 
				angle = -45
			else
				angle = 45
			end			
		end
		
		local texture = false and tweak_data.hud_icons.wp_arrow.texture or "guis/textures/test_blur_df"
		local texture_rect = tweak_data.hud_icons.wp_arrow.texture_rect
		
		local h_space = 20
		local w_space = 20
		
		local new_tube = helper_panel:bitmap({
			name = "tube_" .. row .. "_" .. column,
			texture = texture,
--			texture_rect = texture_rect,
			w = 16,
			h = 4,
			x = w_space * column,
			y = h_space * row,
			layer = 1,
			alpha = 1,
			rotation = angle,
			blend_mode = "add",
			color = Color(0,0.3,0.9)
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

function NobleHUD:_layout_vanilla() --todo determine which vanilla hud elements to hide
	
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
--[[

Hooks:Add("MenuManagerInitialize", "commandprompt_initmenu", function(menu_manager)
	MenuCallbackHandler.commandprompt_tagunit = function(self)
		local unit = Console:GetFwdRay("unit")
		Console:SetFwdRayUnit(unit)
	end
	MenuCallbackHandler.commandprompt_tagposition_aim = function(self)
		Console:TagPosition("aim")
	end
	MenuCallbackHandler.commandprompt_resetsettings = function(self) --button
		Console:ResetSettings() --todo confirm prompt
	end

	MenuCallbackHandler.commandprompt_keybind_debughud = function(self)
		Console.show_debug_hud = not Console.show_debug_hud
	end
	
	MenuCallbackHandler.commandprompt_setescbehavior = function(self,item) --multiplechoice
		Console.settings.esc_behavior = item:value()
	end
	MenuCallbackHandler.commandprompt_toggle_1 = function(self,item) --slider
		--save?
	end
	MenuCallbackHandler.commandprompt_setfontsize = function(self,item) --slider
		Console.settings.font_size = tonumber(item:value())
		--save?
	end
	
	MenuCallbackHandler.commandprompt_setkeyboardregion = function(self,item)
		Console.settings.keyboard_region = tonumber(item:value())
		Console._console_charlist = nil --to require regenerating the charlist again next input
	end
	
	MenuCallbackHandler.commandprompt_setprintbehavior = function(self,item)
		Console.settings.print_behavior = tonumber(item:value())
	end
	
	MenuCallbackHandler.commandprompt_setprintbehavior = function(self,item)
		Console.settings.print_behavior = tonumber(item:value())
	end
	
	MenuCallbackHandler.commandprompt_toggle = function(self) --keybind
		if (Input and Input:keyboard() and not Console:_shift()) then 
			Console:ToggleConsoleFocus()
		end
	end	
	MenuCallbackHandler.callback_dcc_close = function(self)
		Console:Save()
	end

--	Console:Load()
	Console:LoadKeybinds()
	MenuHelper:LoadFromJsonFile(Console.options_path, Console, Console.settings) --no settings, just the two keybinds
end)





--]]





