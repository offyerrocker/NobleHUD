--[[ changelog!

--changes from v0.7b:

- Added Buffs Tracker, with (many) assorted options, modified and reworked from KineticHUD
	- Internally, most buff-detection-related code has been moved to a separate folder for organization, to make it easier to later separate the buff tracker into a standalone mod
- Added animated Interaction Bar and reorganized code to be more consistent
- Added Motion Tracker panel scaling, alignment, and placement options
- Added Health/Shields panel scaling option
- Added Stamina panel placement options
- Added Deployables panel alignment/placement options
- Added Teammates panel alignment/placement options
- Revamped Teammates panel nameplate
	- Nameplate now takes up less extra space without being any harder to read
	- Fixed nameplate name text being vertically off-center by one entire pixel
	- Nameplate name text is now colored white to better match Halo Reach's style
	- Nameplate outline is now colored blue to better match Halo Reach's style
	- Nameplate now contains a translucent fill, which is colored according to the peer slot (green/blue/red/yellow) instead
- Added volume slider bars for shield sounds (shield SFX for recharge, empty, and low)
- Streamlined code for shield sounds, and fixed certain situations where sounds would not play
- Grunt Birthday Party now attempts to spawn confetti particles if they are loaded; if not, flying dollar/money bundle particles are used instead
- Added a hoxhud chat easter egg ;)
- Added a overwatch chat easter egg ;)
- Changed birthday chat easter egg to have better detection
- Fixed scoreboard occasionally having duplicate names or profile pictures. Blame OVK
- Fixed having multiple grenade launchers equipped potentially causing one grenade launcher crosshair to be invisible
- Fixed Motion Tracker blips being off-center, including the "out of range" blips
- Disabled Motion Tracker's radar range setting and locked it to 25 because why would you turn the range down anyway
- "Friendly" enemies, such as the gangsters guarding the trucks on Aftershock, are detected as friendlies, and will trigger the "betrayal" voiceline, as well as a points penalty.
- Minor text fixes

- Known issues:
	- Panel information for respective panels may be incorrect after changing scaling/placement/alignment, but will refresh eventually after proper events
	- Teammates' generated callsigns may not appear properly in waypoints (the ones above teammates' heads) when joining as a drop-in client, and will instead display the teammates' entire names. This is at the top of my priority list for next update.
	- Some buffs are not yet implemented; I am working on implementing the remaining buffs. 
	- Bots currently have no player icon in the scoreboard
	- Teammates' down counters still do not reset properly
	- Long text for deployable amounts, such as "14|6" for fully upgraded Trip Mines/Shaped Charges may be too large to fit in the Deployables panel
	- Misc. interaction circle (the one that appears when bots are reviving you) is currently disabled and does not display
	- Berserker Aced buff may sometimes appear when you are at low health, even if you do not have Berserker Aced.



***** TODO: *****
	Berkserker aced seems always active, particularly in swan song. that's bad. 
	
	* Reorganize popup animate code to allow damage popups to reuse damage animations
	* Add damage popups via other hooks? From CopDamage?
	* Cumulative damage 
		* For athena, use existing popup but reset text, and position/animation progress
	 * Medals should directly reference unit names; for example, "Your driving assisted $PLAYERNAME"
		* Requires a bit of a reorganization for medal code
	
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


--for reference; set later
NobleHUD._announcer_sound_source = nil
NobleHUD._shield_sound_source = nil

--[[
for cat,s in pairs() do 
	NobleHUD._random_chars[cat] = {}
	for i = 1,string.len(s) do 
		table.insert(NobleHUD._random_chars[cat],string.sub(s,i,i))
	end
end
--]]

NobleHUD._cartographer_data = {}
local kills_cache_empty = {
	multipliers = {
		spree_all = 1,
		multikill = 1,
		spree_assist = 1,
		spree_sword = 1
	},
	vehicle = 0,
	vehicle_assist = 0,
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
NobleHUD._cache = { --buffer type deal, holds IMPORTANT THINGS tm
	t = 0,
	num_buffs = 0,
	birthday = nil, --overrideable by user input, so set to nil
	callsigns = {
		--76561198025511599 = "B025" --example callsign storage
	},
	downs = {
		[1] = 0,
		[2] = 0,
		[3] = 0,
		[4] = 0
	},
	killer = {},
	score_timer_mult = 1,
	score_popups_count = 0,
	score_popups = {},
	enemy_damage = {},
	score_session = 0,
	game_state = "",
	newest_medal = false,
	newest_killfeed = false,
	chat_wanted = true,
	last_cartographer_t = 0,
	sounds = {},
	announcer_queue = {},
	objectives = {},
	kills = table.deep_map_copy(kills_cache_empty)
}
NobleHUD._delayed_callbacks = {}
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
NobleHUD._active_buffs = {}
NobleHUD._radar_blips = {}
NobleHUD._queued_objectives = {
--[[example:
	{
		id = "ovengrill_office_objective2",
		text = "Steal four bags of pepsi", 
		current_amount = 1, --optional
		amount = 4 --optional
	}
--]]
}
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

--Animate functions (not all of them, mostly just the universal/non-specific ones)

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

function NobleHUD:animate_fadeout_linear(o,t,dt,start_t,duration,start_alpha,exit_x,exit_y)
	start_alpha = start_alpha or 1
	duration = duration or 1
	local ratio = (t - start_t) / duration
	o:set_alpha(start_alpha * (1 - ratio))
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

function NobleHUD:animate_fadeout(o,t,dt,start_t,duration,from_alpha,exit_x,exit_y)
	duration = duration or 1
	from_alpha = from_alpha or 1
	local ratio = math.pow((t - start_t) / duration,2)
	
	if ratio >= 1 then 
		o:set_alpha(0)
		return true
	end
	o:set_alpha(from_alpha * (1 - ratio))
	if exit_y then 
		o:set_y(o:y() + (exit_y * dt / duration))
	end
	if exit_x then 
		o:set_x(o:x() + (exit_x * dt / duration))
	end
end

function NobleHUD:animate_fadein(o,t,dt,start_t,duration,end_alpha,start_x,end_x,start_y,end_y)
	duration = duration or 1
	end_alpha = end_alpha or 1
	local ratio = math.pow((t - start_t) / duration,2)
	
	if ratio >= 1 then 
		o:set_alpha(end_alpha)
		if end_x then 
			o:set_x(end_x)
		end 
		if end_y then 
			o:set_y(end_y)
		end
		return true
	end
	o:set_alpha(ratio * end_alpha)
	if start_x and end_x then 
		o:set_x(start_x + ((end_x - start_x) * ratio))
	end
	if start_y and end_y then 
		o:set_y(start_y + ((end_y - start_y) * ratio))
	end
end

function NobleHUD:animate_blip_ghost(o,t,dt,start_t,duration,end_alpha,start_w,start_h,end_w,end_h,center_x,center_y)
	--i'm cheating a bit here by calling two other animate functions from this one
	local fade_done = self:animate_fadein(o,t,dt,start_t,duration,end_alpha) 
	local scale_done = self:animate_scale(o,t,dt,start_t,duration,start_w,start_h,end_w,end_h,center_x,center_y)
	if fade_done and scale_done then
		return true
	end	
end

function NobleHUD:animate_scale(o,t,dt,start_t,duration,start_w,start_h,end_w,end_h,center_x,center_y)
	duration = duration or 1
	local ratio = math.pow((t - start_t) / duration,2)
	if ratio >= 1 then 
		if end_w then 
			o:set_w(end_w)
		end
		if end_h then 
			o:set_h(end_h)
		end
		if center_x and center_y then 
			o:set_center(center_x,center_y)
		end
		return true
	else
		if start_w and end_w then
			o:set_w(start_w + ((end_w - start_w) * ratio))
		end
		if start_h and end_h then 
			o:set_h(start_h + ((end_h - start_h) * ratio))
		end
		if center_x and center_y then 
			o:set_center(center_x,center_y)
		end
	end
end



--		SETTINGS

		--GET SETTINGS
		
function NobleHUD:GetHUDAlpha()
	return self.settings.master_hud_alpha
end
		
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
	return 25 or self.settings.radar_distance
end

function NobleHUD:GetRadarStyle()
	return self.settings.radar_style --1 is completely accurate, noblehud beta; 2 is halo:reach style 
end

function NobleHUD:GetRadarScale()
	return self.settings.radar_scale
end

function NobleHUD:GetRadarAlignVertical()
	local setting = self.settings.radar_align_vertical
	if setting == 1 then 
		return "top"
	elseif setting == 2 then
		return "center"
	elseif setting == 3 then 
		return "bottom"
	end
end

function NobleHUD:GetRadarAlignHorizontal()
	local setting = self.settings.radar_align_horizontal
	if setting == 1 then 
		return "left"
	elseif setting == 2 then
		return "center"
	elseif setting == 3 then 
		return "right"
	end
end

function NobleHUD:GetRadarPanelX()
	return self.settings.radar_x
end

function NobleHUD:GetRadarPanelY()
	return self.settings.radar_y
end

function NobleHUD:IsFloatingAmmoPanelEnabled()
	return self.settings.floating_ammo_enabled
end

function NobleHUD:get_blip_color_by_team(team_name)
	team_name = team_name or "nil"
	local cd = self.color_data --sorry crackdown team, cd is ColorData mod now
	local team_colors = {
		law1 = cd.hud_radar_cop,
		neutral1 = cd.hud_radar_civilian,
		mobster1 = cd.hud_radar_gangster,
		converted_enemy = cd.hud_radar_convert,
		hacked_turret = cd.hud_radar_turret,
		criminal1 = cd.hud_radar_criminal,
		empty_vehicle = cd.hud_radar_empty_vehicle
	}
	if not team_colors[team_name] then 
		self:log("No blip color found for " .. tostring(team_name))
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

function NobleHUD:IsAnnouncerFranticEnabled() 
	return self.settings.announcer_frantic_enabled
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

function NobleHUD:GetStaminaPanelX()
	return self.settings.stamina_x
end

function NobleHUD:GetStaminaPanelY()
	return self.settings.stamina_y
end

function NobleHUD:GetEmptyAmmoTickAlpha()
	return self.settings.weapon_ammo_tick_empty_alpha
end

function NobleHUD:GetFullAmmoTickAlpha()
	return self.settings.weapon_ammo_tick_full_alpha
end

function NobleHUD:GetChatAutohideTimer()
	return self.settings.chat_autohide_timer
end

function NobleHUD:GetChatPanelXY()
	return self.settings.chat_panel_x,self.settings.chat_panel_y
end

function NobleHUD:GetChatAutohideMode()
	return self.settings.chat_autohide_mode
end

function NobleHUD:GetChatTimestampMode()
	return self.settings.chat_timestamp_mode
end

function NobleHUD:GetLowShieldThreshold()
	return self.settings.shield_low_threshold
end	

function NobleHUD:GetChatNotificationSound()
	return self.settings.chat_notification_sfx
end

function NobleHUD:IsShieldLowSoundEnabled()
	return self.settings.shield_low_sound_enabled
end

function NobleHUD:IsShieldEmptySoundEnabled()
	return self.settings.shield_empty_sound_enabled
end

function NobleHUD:IsShieldChargeSoundEnabled() 
	return self.settings.shield_charge_sound_enabled
end

function NobleHUD:IsChatAutoshowEnabled() --related to automatic chat displays, not to automobile expos
	return self.settings.chat_autoshow_enabled
end

function NobleHUD:IsChatNotificationSoundEnabled()
	return self.settings.chat_notification_sound_enabled
end

function NobleHUD:IsChatNotificationIconEnabled()
	return self.settings.chat_notification_sound_enabled
end

function NobleHUD:GetScoreDisplayMode()
	return tonumber(self.settings.score_display_mode)
end

function NobleHUD:VerifyUnusual()
	local unusual = self.settings.unusual
	local valid = {}
	if not valid[unusual] then 
		self.settings.unusual = 0
		self:SaveSettings()
		return false
	end
	return unusual
end

function NobleHUD:GetCallsign(peer_id) --synced/saved, manually selected callsigns only
	if peer_id then 
		local peer = managers.network:session():peer(peer_id)
		if peer then 
			return self._cache.callsigns[peer:user_id()]
		end
	end
	return self.settings.callsign_string
end

function NobleHUD:IsSafeMode()
	return self.settings.safe_mode
end

function NobleHUD:GetSteelsightHidesReticle()
	return self.settings.steelsight_hides_reticle_enabled
end

function NobleHUD:GetTeamName()
	return self.settings.team_name
end

function NobleHUD:GetTeamColor()
	return Color(0.5,0.2,0.2)
end

function NobleHUD:IsSkullActive(id)
	if id == "birthday" then 
		--yaaaaaay
		if self._cache.birthday ~= nil then 
			return self._cache.birthday --overrideable by user input ("birthday stop" in chat)
		else
			return ((tonumber(os.date("%d")) == 1) and (tonumber(os.date("%m")) == 4))
		end
	end
end

function NobleHUD:GetMaxRadarDecoyRange()
	local m = self:GetRadarDistance() * 100
	--values are [0-1] as a percentage of radar range
	local x = 1
	local y = 1
	local z = 1
	return m * x,m * y,m * z
end

function NobleHUD:GetRadarDecoyIntervalMin() 
	return 0.15
end

function NobleHUD:GetRadarDecoyIntervalMax() 
	return 1
end

function NobleHUD:GetRadarDecoyLifetimeMin() 
	return 3
end

function NobleHUD:GetRadarDecoyLifetimeMax() 
	return 10
end

function NobleHUD:IsBuffTrackerEnabled()
	return self.settings.buffs_master_enabled
end

function NobleHUD:GetBuffPanelAlign()
	local setting = self.settings.buffs_panel_align
	if setting == 1 then 
		return "left"
	elseif setting == 2 then 
		return "right"
	end
	return "left"
end

function NobleHUD:GetBuffPanelVertical()
	local setting = self.settings.buffs_panel_vertical
	if setting == 1 then 
		return "top"
	elseif setting == 2 then 
		return "bottom"
	end
	return "top"
end

function NobleHUD:GetMaxBuffsPerRow()
	return math.floor(self.settings.buffs_per_row)
end

function NobleHUD:GetMaxBuffsPerColumn()
	return math.floor(self.settings.buffs_per_column)
end

function NobleHUD:GetBuffAlignCenter()
	return self.settings.buff_align_center
end

function NobleHUD:GetBuffVerticalCenter()
	return self.settings.buff_vertical_center
end

function NobleHUD:GetBuffXY()
	return self.settings.buffs_panel_x,self.settings.buffs_panel_y
end

function NobleHUD:GetBuffWH()
	return self.settings.buffs_panel_w,self.settings.buffs_panel_h
end

function NobleHUD:GetBuffItemSize()
	if self:IsBuffCompactMode() then 
		return self._BUFF_ITEM_W_COMPACT,self._BUFF_ITEM_H_COMPACT
	else
		return self._BUFF_ITEM_W,self._BUFF_ITEM_H
	end
end

function NobleHUD:IsBuffEnabled(id)
	--get setting for if buff display is disabled
	return self.buff_settings[id]
end

function NobleHUD:GetDodgeChanceBuffThreshold()
	return self.buff_settings.dodge_chance_threshold
end
function NobleHUD:GetCritChanceBuffThreshold()
	return self.buff_settings.crit_chance_threshold
end
function NobleHUD:GetDmgResistBuffThreshold()
	return self.buff_settings.dmg_resist_threshold
end

function NobleHUD:ShouldAlignAbilityToRadar()
	return self.settings.ability_align_to_radar
end

function NobleHUD:ShouldAlignTeammatesToRadar() 
	return self.settings.teammate_align_to_radar
end

function NobleHUD:IsBuffCompactMode()
	return self.settings.buffs_compact_mode_enabled
end

function NobleHUD:GetTeammatesPanelX()
	return self.settings.teammate_x
end

function NobleHUD:GetTeammatesPanelY()
	return self.settings.teammate_y
end

function NobleHUD:GetAbilityPanelX()
	return self.settings.ability_x
end

function NobleHUD:GetAbilityPanelY()
	return self.settings.ability_y
end

function NobleHUD:GetVitalsScale()
	return self.settings.vitals_scale
end

function NobleHUD:GetShieldChargeVolume()
	return self.settings.shield_charge_sound_volume
end

function NobleHUD:GetShieldEmptyVolume()
	return self.settings.shield_empty_sound_volume
end

function NobleHUD:GetShieldLowVolume()
	return self.settings.shield_low_sound_volume
end
		
function NobleHUD:IsDamagePopupsEnabled()
	return self.settings.damage_popups_enabled
end

function NobleHUD:GetDamagePopupsStyle()
	return self.settings.damage_popups_style
end

function NobleHUD:IsDamagePopupsCumulative()
	return self.settings.damage_popups_cumulative_enabled
end
function NobleHUD:GetDamagePopupsCumulativeRefreshTime()
	return self.settings.damage_popups_cumulative_refresh
end

function NobleHUD:IsDamagePopupsRepeat()
--whether or not multiple damage popups should be created for multiple damage instances on the same unit or not
	return self.settings.damage_popups_redundant
end

function NobleHUD:GetDamagePopupsLifetime()
	return self.settings.damage_popups_lifetime
end

function NobleHUD:GetDamagePopupsFadeoutTime()
	return self.settings.damage_popups_fadeout
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


--		MISC

function NobleHUD:ShowMenu_AboutCallsign()
	local function loc(s)
		return managers.localization:text(s) --Look, that's a lot of times to type managers.localization:text(whatever). See, you made me type it again!
	end
	
	local requirement_length = "* " .. loc("noblehud_menu_callsign_requirement_length")
	requirement_length = string.gsub(requirement_length,"$MIN_CALLSIGN_LENGTH",self._MIN_CALLSIGN_LEN)
	requirement_length = string.gsub(requirement_length,"$MAX_CALLSIGN_LENGTH",self._MAX_CALLSIGN_LEN)
	local requirement_character = "* " .. loc("noblehud_menu_callsign_requirement_character")
	
	QuickMenu:new(loc("noblehud_menu_callsign_about_title"),loc("noblehud_menu_callsign_about_desc") .. requirement_length .. "\n" .. requirement_character,{
		{
			text = loc("menu_ok"),
			is_cancel_button = true
		}
	},true)
end

function NobleHUD:EvaluateCallsignInput(callsign) -- from menu
	local function loc(s)
		return managers.localization:text(s)
	end
	callsign = utf8.to_upper(callsign)
	if callsign ~= string.gsub(callsign,"%W","") then
		local rejected_characters = string.gsub(callsign,"%w","")
		QuickMenu:new(loc("noblehud_menu_callsign_error_character_title"),string.gsub(loc("noblehud_menu_callsign_error_character_desc"),"$REJECTED_CHARACTERS",rejected_characters) .. "\n" .. loc("noblehud_menu_callsign_requirement_character") .. "\n\n" .. loc("noblehud_menu_callsign_error_please_retry"),{
			{
				text = loc("noblehud_menu_ok_sarcastic"),
				callback = callback(NobleHUD,NobleHUD,"ShowMenu_SetCallsign")
			},
			{
				text = loc("noblehud_menu_cancel"),
				is_cancel_button = true
			}
		},true)
		return
	elseif string.len(callsign) < self._MIN_CALLSIGN_LEN then 
		local requirement_length = loc("noblehud_menu_callsign_requirement_length")
		requirement_length = string.gsub(requirement_length,"$MIN_CALLSIGN_LENGTH",self._MIN_CALLSIGN_LEN)
		requirement_length = string.gsub(requirement_length,"$MAX_CALLSIGN_LENGTH",self._MAX_CALLSIGN_LEN)
		
		QuickMenu:new(loc("noblehud_menu_callsign_error_length_title"),requirement_length .. "\n\n" .. loc("noblehud_menu_callsign_error_please_retry"),{
			{
				text = loc("noblehud_menu_ok_sarcastic"),
				callback = callback(NobleHUD,NobleHUD,"ShowMenu_SetCallsign")
			},
			{
				text = loc("noblehud_menu_cancel"),
				is_cancel_button = true
			}
		},true)
		return
	end
	
	self.settings.callsign_string = callsign
	self:SaveSettings()
	if managers.network:session() then 
--		self:SyncCallsignToPeers()
	end
end

function NobleHUD:ShowMenu_SetCallsign()
	local function loc(s)
		return managers.localization:text(s)
	end
	if _G.QuickKeyboardInput then
		local callsign
		
		local function evaluate_callsign(callsign)
			self:EvaluateCallsignInput(callsign)
		end
		
		local requirement_length = loc("noblehud_menu_callsign_requirement_length")
		requirement_length = string.gsub(requirement_length,"$MIN_CALLSIGN_LENGTH",self._MIN_CALLSIGN_LEN)
		requirement_length = string.gsub(requirement_length,"$MAX_CALLSIGN_LENGTH",self._MAX_CALLSIGN_LEN)
		local requirement_character = loc("noblehud_menu_callsign_requirement_character")
		
		QuickKeyboardInput:new(loc("noblehud_menu_enter_callsign_title"), "* " .. requirement_character .. "\n* " .. requirement_length .. "\n" .. loc("noblehud_menu_prompt_callsign"), self:GetCallsign() or "S117", evaluate_callsign, self._MAX_CALLSIGN_LEN, true)
	else
		local function open_in_overlay()
			Steam:overlay_activate("url","https://modworkshop.net/mod/22564")
		end
		QuickMenu:new(loc("noblehud_menu_missing_dependency_title"),loc("noblehud_menu_missing_qki_desc") .. string.gsub(loc("noblehud_menu_current_callsign"),"$CALLSIGN",self:GetCallsign()),{
			{
				text = loc("noblehud_menu_goto_url"),
				callback = open_in_overlay
			},
			{
				text = loc("noblehud_menu_ok_sarcastic"),
				is_cancel_button = true
			}
		},true)
	end
end



--		HUD UPDATE STUFF / EVENT FUNCTIONS

Hooks:Add("BeardLibSetupInitFinalize","NobleHUD_AddUpdator",function()
	BeardLib:AddUpdater("NobleHUD_update",callback(NobleHUD,NobleHUD,"UpdateHUD"))
end)

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
--	self:_create_assault(hud)
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
	self:_create_waiting(hud)
	
	local chat_x,chat_y = self:GetChatPanelXY()
	managers.hud._hud_chat._panel:set_x(chat_x)
	managers.hud._hud_chat._panel:set_y(chat_y)
	
	
--	managers.hud:script("guis/mask_off_hud"):hide()
end
		
function NobleHUD:SetTeammateDowns(id,downs,panel_id,increment)
	if not id then
		self:log("ERROR: No id to SetTeammateDowns()",{color=Color.red})
		return
	end
	if downs then 
		if increment and self._cache.downs[id] then 
			self._cache.downs[id] = self._cache.downs[id] + downs
		else
			self._cache.downs[id] = downs
		end
	end
	downs = self._cache.downs[id]
	if panel_id == true then 
		panel_id = self:GetPanelIdFromPeerId(id)
	end
	if panel_id then 
		local player_box = self._tabscreen:child("scoreboard"):child("player_box_" .. tostring(panel_id))
		if alive(player_box) then 
			player_box:child("downs_box"):child("downs_label"):set_text(downs)
		end
	end
end

function NobleHUD:GetTeammateDowns(id)
	return self._cache.downs[id or ""]
end

function NobleHUD:OnLoaded()
	self:LoadXAudioSounds()
	self._cache.loaded = true
	
	CopDamage.register_listener("noblehud_on_cop_damage",{"on_damage"},callback(NobleHUD,NobleHUD,"CreateDamagePopup"))

--	managers.player:register_message(Message.OnWeaponFired,"noblehud_recoil_fire",callback(NobleHUD,NobleHUD,"_add_weapon_bloom",0.5))

	self:set_weapon_info()
	
	local player = managers.player:local_player()
	local dmg = player and player:character_damage()
	local revives = dmg and Application:digest_value(dmg._revives,false) 
	self:SetRevives(revives)
	self:_set_deployable_equipment(2,true)
	
	self:SetTotalScoreMultiplierDisplay()
	
	self:SetRadarEnabled(self:IsRadarEnabled())
	self._stamina_panel:set_visible(self:IsStaminaEnabled())
	
--	self:set_score_multiplier()
	managers.hud:add_updator("NobleHUD_update",callback(NobleHUD,NobleHUD,"UpdateHUD"))
	self:_switch_weapons(player:inventory():equipped_selection())
	if self:IsCrosshairEnabled() then 
		self._crosshair_panel:set_alpha(self:GetCrosshairAlpha())
		
		if not self:UseCrosshairDynamicColor() then 		
			self:_set_crosshair_color(self:GetCrosshairStaticColor()) 
			--todo switch crosshair to static color on weapon switch
		end
	else
		self._crosshair_panel:hide()
	end
	self:LayoutBuffPanel()
	self:LayoutRadar()
	self:LayoutStamina()
	self:LayoutVitals()

	local level_data = managers.job:current_level_data()
	local level_name = level_data and level_data.name_id
	self:set_mission_name(level_name and managers.localization:text(level_name) or "")
	self:LoadCartographerData(level_name)
			
	managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2).panel:child("teammates_panel"):hide()
	
--	local peer_id = managers.network:session():local_peer():id() or 1
--	self._score_panel:child("score_banner_small"):set_color(tweak_data.chat_colors[peer_id])
	
	self:SetRadarDistance(self:GetRadarDistance())
	self._floating_ammo_panel:set_visible(self:IsFloatingAmmoPanelEnabled())

	
	
	
--layout hud stuff
	self:_sort_teammates()
	if managers.hud:script("guis/mask_off_hud") then 
		if alive(managers.hud:script("guis/mask_off_hud").panel) and alive(managers.hud:script("guis/mask_off_hud").panel:child("mask_on_text")) then
			managers.hud:script("guis/mask_off_hud").panel:child("mask_on_text"):set_text("")
		end
	end
end

function NobleHUD:IsLoaded() 
	return self._cache.loaded
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
	
	if dt == 0 then 
		--don't run when paused
		return
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
		local player_damage = player:character_damage()
		local inventory = player:inventory()
		
		
		if Network:is_server() then
			local hudassault = managers.hud._hud_assault_corner
			if hudassault._assault_mode == "normal" then 
				--hud assault state 
				local assaultstate = managers.groupai:state()
				local assaulttasks = assaultstate and assaultstate._task_data
				local assaultdata = assaulttasks and assaulttasks.assault
				local phase = assaultdata and assaultdata.phase
				local phasename = self._assault_phases[phase]
				if phase and not (phasename or assaultstate:whisper_mode()) then 
					self:log("Did not find phasename for " .. tostring(phase),{color = Color.red})
				elseif phasename then
					self:SetAssaultPhase(managers.localization:text(phasename),true)
				end
			end
		end
		
		--close call medal stuff
		if self:KillsCache("close_call") and player_damage:armor_ratio() >= 1 then 
			self:KillsCache("close_call",false,true)
			self:AddMedal("close_call")
		end
	
	
		--animate function stuff
		for object_id,data in pairs(self._animate_targets) do 
			local result
			if type(data and data.func) == "string" then 
				if NobleHUD[data.func] then 					
					result = NobleHUD[data.func](NobleHUD,data.object,t,dt,data.start_t,unpack(data.args))
				else
					self:log("ERROR: Unknown animate function: NobleHUD:" .. tostring(data.func) .. "()")
					self._animate_targets[object_id] = nil
				end
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
		
		--ping (latency) update
		for _,data in pairs(managers.criminals._characters) do 
			if data.peer_id and managers.network:session() and managers.network:session():peer(data.peer_id) then
				self:SetTeammatePing(data.data and data.data.panel_id,managers.network:session():peer(data.peer_id):qos().ping)
			end
		end
			
		--shield sfx (loop)
		local player_armor_max = player_damage:_max_armor()
		if player_armor_max > 0 then 
			local player_armor = player_damage:get_real_armor()
			if player_armor == 0 then 
				self:PlayShieldSound("shield_low",false)
				self:PlayShieldSound("shield_empty")
			elseif (player_armor / player_armor_max) <= NobleHUD:GetLowShieldThreshold() then 
				self:PlayShieldSound("shield_empty",false)
				self:PlayShieldSound("shield_low")
			else
				self:PlayShieldSound("shield_low",false)
				self:PlayShieldSound("shield_empty",false)
			end
		--[[
		and self._shield_sound_source and not self._shield_sound_source:is_closed() then
			local shield_source = self._shield_sound_source
			if self:IsShieldEmptySoundEnabled() and (player_armor == 0) then
				if shield_source._buffer ~= self._cache.sounds.shield_empty then 
					shield_source:stop()
					shield_source:set_buffer(self._cache.sounds.shield_empty)
					shield_source:set_looping(true)
					shield_source:set_volume(self:GetShieldEmptyVolume())
				end
				if shield_source:get_state() ~= 1 then 
					shield_source:play()
				end
			elseif self:IsShieldLowSoundEnabled() and ((player_armor / player_armor_max) <= NobleHUD:GetLowShieldThreshold()) then
				if shield_source._buffer ~= self._cache.sounds.shield_low then 
					shield_source:stop()
					shield_source:set_buffer(self._cache.sounds.shield_low)
					shield_source:set_looping(true)
					shield_source:set_volume(self:GetShieldLowVolume())
				end
				if shield_source:get_state() ~= 1 then 
					shield_source:play()
				end
			else
				if shield_source:get_state() == 1 then 
					if (shield_source._buffer == self._cache.sounds.shield_low) or (shield_source._buffer == self._cache.sounds.shield_empty) then 
						shield_source:stop()
					end
				end
			end
			--]]
		end
		
		if self:GetScoreDisplayMode() == 2 then 
	--managers.localization:text("hud_day_payout", {				MONEY = managers.experience:cash_string(managers.money:get_potential_payout_from_current_stage())			})	
			self:SetScoreLabel(managers.experience:cash_string(managers.money:get_potential_payout_from_current_stage()))
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
					self:animate(item.bitmap,"animate_fadeout_linear",function (o) o:parent():remove(o) end,0.25,nil,-item.bitmap:w(),false)
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
		
		
		local player_pos = player:position()
		local state = player:movement():current_state()
		local player_state_name = player:movement():current_state_name()

			
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
		self:SetCompassDirection(player_aim)
		local cam_aim = viewport_cam:rotation():yaw()
--		local cam_rot_a = viewport_cam:rotation():y()

--		local compass_yaw = ((cam_aim) / 180) - 1 --should this perhaps use modulo
		--todo get range of cam_aim
	
--		self._compass_panel:child("compass_strip"):set_x(compass_yaw * self._compass_panel:w())
		
		--radar/crosshair stuff


-- ************** RADAR	**************
		if self:IsRadarEnabled() then --if radar enabled
			local RADAR_SIZE = self:GetRadarScale() * self._RADAR_BG_SIZE * 0.96 --todo scaleable panel from settings
			local RADAR_PANEL_W = self._radar_panel:w()
			local RADAR_PANEL_H = self._radar_panel:h()
			local RADAR_DISTANCE_MID = self:GetRadarDistance() * 100
			local RADAR_DISTANCE_MAX = RADAR_DISTANCE_MID * 1.2
			local RADAR_DISTANCE_MAX_SQ = RADAR_DISTANCE_MAX * RADAR_DISTANCE_MAX
			local V_DISTANCE_MID = 350 --at vertical distances over this threshold, the icon will change to reflect this difference
			local MAX_BLIP_DEVIATION = 25 --percentage
			local blip_deviation = 1 + (math.random(MAX_BLIP_DEVIATION) / 100)
			
			local refresh_radar_ghosts = false
			if (t - self._radar_ghost_t) > self._RADAR_GHOST_INTERVAL then 
				self._radar_ghost_t = t
				refresh_radar_ghosts = true
			end

			local far_blip_dist_mul = 1.075
			--refresh radar targets (add)
			if (t > NobleHUD._radar_refresh_t + NobleHUD._RADAR_REFRESH_INTERVAL) then
				NobleHUD._radar_refresh_t = t --reset radar refresh timer
				
				local all_persons = World:find_units_quick("sphere",player_pos,RADAR_DISTANCE_MAX,managers.slot:get_mask("persons"))
				for _,unit in pairs(all_persons) do 
					if unit and alive(unit) then --dead people are already filtered out of World:find_units_quick()
						if unit == player then 
							if state._moving or player_state_name == "driving" then 
--							if unit:movement():current_state():get_movement_state() ~= "crouching" then 
								self:create_radar_blip(unit)
							end
						else
							local dis = mvector3.distance_sq(player_pos, unit:position())
							if dis >= RADAR_DISTANCE_MAX_SQ then
								--out of range; remove 
								self:remove_radar_blip(unit)
							else
								self:create_radar_blip(unit,"person") --todo animate fadein
							end
						end
					else --no valid unit; this should never happen due to World:find_units_quick() filtering out invalid/dead units
						self:remove_radar_blip(unit)
					end
				end
				
				local all_vehicles = World:find_units_quick("sphere",player_pos,RADAR_DISTANCE_MAX,managers.slot:get_mask("vehicles"))
				for _,unit in pairs(all_vehicles) do 
					if unit and alive(unit) then
						if unit:vehicle_driving() then 
							if mvector3.distance_sq(player_pos,unit:position()) >= RADAR_DISTANCE_MAX_SQ then 
								self:remove_radar_blip(unit)
							else
								self:create_radar_blip(unit,"vehicle")
							end
						else 
							local anim_body = unit:get_object(Idstring("anim_body"))
							if alive(anim_body) then 
								if mvector3.distance_sq(player_pos,anim_body:position()) >= RADAR_DISTANCE_MAX_SQ then 
									self:remove_radar_blip(unit)
								else
									--if needed, get anim_body:oobb():center() ?
									self:create_radar_blip(unit,"fake_vehicle")
								end
							else
								if mvector3.distance_sq(player_pos,unit:position()) >= RADAR_DISTANCE_MAX_SQ then 
									self:remove_radar_blip(unit)
								else
									self:create_radar_blip(unit,"fake_vehicle")
								end
							end
						end
					else
						self:remove_radar_blip(unit)
					end
				end
				
				local all_sentries = World:find_units_quick("sphere",player_pos,RADAR_DISTANCE_MAX,managers.slot:get_mask("sentry_gun"))
				for _,unit in pairs(all_sentries) do 
					if unit and alive(unit) and not (unit:character_damage() and unit:character_damage():dead()) then 
						local dis = mvector3.distance_sq(player_pos,unit:position())
						if dis >= RADAR_DISTANCE_MAX_SQ then 
							self:remove_radar_blip(unit)
						else
							self:create_radar_blip(unit,"sentry")
						end
					else
						self:remove_radar_blip(unit)
					end
				end
			end
			

			--refresh currently existing radar blips
			--create new blip ghosts
			
			local radar = self._radar_panel
			
			for blip_key,data in pairs(self._radar_blips) do 
				
				local blip_x,blip_y,blip_image,blip_alpha,blip_angle
				local blip_team
				local blip_dead
				local blip_pos
				local blip_unit = data.unit
				local blip_w = RADAR_SIZE / 20
				local blip_h = RADAR_SIZE / 20
				local is_vehicle
				if data.variant == "ecm_decoy" then 
					
					if alive(blip_unit) and blip_unit:base() and blip_unit:base():battery_life() > 0 and (blip_unit:base():active() or blip_unit:base():feedback_active()) then 
--						blip_pos = data.position or (blip_unit and alive(blip_unit) and blip_unit:position())
					
						if (not data.expire_t) or data.expire_t <= t then 
							blip_dead = true
						elseif data.position and data.velocity then 
							local random_team = math.sin(t + (data.expire_t * 1000))
							if random_team > 0.8 then 
								blip_team = "neutral1" --20% chance
							elseif random_team > 0.75 then 
								blip_team = "mobster1" --5% chance
							elseif random_team > 0.6 then
								blip_team = "criminal1" --15% chance
							else 
								blip_team = "law1" --60% chance
							end

							local vel_x = data.velocity.x * dt
							local vel_y = data.velocity.y * dt
							local vel_z = data.velocity.z * dt
							is_vehicle = math.sin((t + data.expire_t) * 0.001) > 0
							if data.arc then 
								local arc = data.arc --math.rad(data.arc)
								local curvature = math.round(data.expire_t) % 50
								if NobleHUD.even(math.round(data.expire_t)) then 
									data.position = data.position + Vector3((math.cos((arc + t) * curvature)) * vel_x,(math.sin((arc + t) * curvature)) * vel_y,vel_z)
								else
									data.position = data.position + Vector3((math.sin((arc + t) * curvature)) * vel_x,(math.cos((arc + t) * curvature)) * vel_y,vel_z)
								end
							else
								data.position = data.position + Vector3(vel_x,vel_y,vel_z)
							end
							blip_pos = blip_unit:position() + data.position
						else
							blip_dead = true
						end
					else
						blip_dead = true
					end
				else
					if blip_unit and alive(blip_unit) then
						if ((data.variant == "person") or (data.variant == "sentry")) then
							blip_pos = blip_unit:position()
							if blip_unit == player then
								if player_state_name == "driving" then  
									--NOTHING' 
								elseif state:get_movement_state() == "moving_crouching" then
									if NobleHUD.even(math.floor(t)) or (math.random() > 0.5) then
										--NOTHIN'
									else
										self:remove_radar_blip(blip_unit)										
									end
								elseif not state._moving then 
									self:remove_radar_blip(blip_unit)
								end
							end
							if blip_unit:character_damage() and not blip_unit:character_damage():dead() then 
								if blip_unit:movement() and blip_unit:movement():team() then 
									blip_team = blip_unit:movement():team().id
								end
								if data.variant == "sentry" then
									if blip_team ~= "criminal1" then 
										is_vehicle = true
									end
								end
								if blip_team and blip_unit:brain() and blip_unit:brain().is_current_logic and blip_unit:brain():is_current_logic("intimidated") then 
									blip_team = "converted_enemy"
								elseif not blip_team then 
									blip_team = "law1"
								end
							else
								blip_dead = true
							end
						elseif data.variant == "vehicle" then 
--							blip_pos = blip_unit:oobb():center()
							is_vehicle = true
							local driving_state = blip_unit:vehicle_driving()
							blip_pos = blip_unit:position()
							if driving_state then 
								if driving_state:num_players_inside() > 0 then 
									blip_team = "criminal1"
								elseif driving_state:_number_in_the_vehicle() > 0 then 
									local driver_unit = driving_state._seats.driver and driving_state._seats.driver.occupant
									if driver_unit and alive(driver_unit) and driver_unit:brain() then 
										--is AI
										if driver_unit:movement() and driver_unit:movement():team() then 
											blip_team = driver_unit:movement():team().id or "empty_vehicle"
										end
									end
								end
							end
							blip_team = blip_team or "empty_vehicle"
						elseif data.variant == "fake_vehicle" then 
							blip_pos = blip_unit:position()
--							blip_pos = blip_unit:oobb():center()
							is_vehicle = true
							if blip_unit:base() and blip_unit:base()._modules then 
								blip_team = "law1"
							end
						
							local anim_body = blip_unit:get_object(Idstring("anim_body"))
							if anim_body then 
								blip_pos = anim_body:position()
								--if needed, get anim_body:oobb():center() ?
							end
							--things like cop cars or swat vans; not currently detected
							blip_team = blip_team or "empty_vehicle"
						else
							self:log("radar: not sure why, but finding " .. tostring(data.variant))
						end
					else	
						blip_dead = true
					end
				end
				if not blip_pos then
					blip_dead = true
				end
				if blip_dead then 
					self:remove_radar_blip(blip_unit,blip_key)
				else
					local angle_to_person = 90 + NobleHUD.angle_from(blip_pos,player_pos) - player_aim
					local distance_to_person = NobleHUD.vec2_distance(player_pos,blip_pos)
					local v_distance = player_pos.z - blip_pos.z
					
					local blip_color = self:get_blip_color_by_team(blip_team)
					if distance_to_person < RADAR_DISTANCE_MID then 
					
						blip_x = (math.sin(angle_to_person) * (distance_to_person / RADAR_DISTANCE_MID) * (RADAR_SIZE / 2))
						blip_y = (math.cos(angle_to_person) * (distance_to_person / RADAR_DISTANCE_MID) * (RADAR_SIZE / 2))
						if math.abs(v_distance) > V_DISTANCE_MID then 
							blip_alpha = 0.33
							blip_angle = 0
							blip_w = RADAR_SIZE / 24
							blip_h = RADAR_SIZE / 24
							if v_distance > 0 then
								--if lower than player by x, use radar_blip_near_lower
								blip_image = "guis/textures/radar_blip_low"
							else
								--if higher than player by x, use radar_blip_near_higher
								blip_image = "guis/textures/radar_blip_high"
							end
							
						else
							blip_angle = -angle_to_person
							blip_alpha = 0.7
							blip_image = "guis/textures/radar_blip_near" --mid

							blip_w = RADAR_SIZE / 20
							blip_h = RADAR_SIZE / 20
						end
					elseif distance_to_person > RADAR_DISTANCE_MAX then 
						--is out of range
						blip_x,blip_y = -1000,-1000
						blip_alpha = 0
						self:remove_radar_blip(blip_unit,blip_key)
					else 
						blip_angle = -angle_to_person
						
						--on outskirts of range
						blip_x = math.sin(angle_to_person) * far_blip_dist_mul * RADAR_SIZE / 2
						blip_y = math.cos(angle_to_person) * far_blip_dist_mul * RADAR_SIZE / 2
						blip_image = "guis/textures/radar_blip_far"
						blip_alpha = 0.5
						blip_w = 2 * RADAR_SIZE / 6
						blip_h = 2 * RADAR_SIZE / 6
					end
					if is_vehicle then 
						blip_w = blip_w * 2
						blip_h = blip_h * 2
					end
					if (NobleHUD:GetRadarStyle() == 2) then 
						if refresh_radar_ghosts then 
							self:create_radar_blip_ghost({
								alpha = 0,
								rotation = blip_angle,
								texture = blip_image,
								layer = 4,
								color = blip_color,
								end_alpha = blip_alpha,
	--							size_mult = 1,
								blip_w = blip_w * blip_deviation,
								blip_h = blip_h * blip_deviation,
								center_x = blip_x + (RADAR_PANEL_W / 2), --centered
								center_y = blip_y + (RADAR_PANEL_H / 2) --bottom;  + (RADAR_PANEL_H - RADAR_SIZE)
							})
						end
					elseif data.bitmap and alive(data.bitmap) then 
						local blip_bitmap = data.bitmap
						blip_bitmap:set_alpha(blip_alpha)
						blip_bitmap:set_rotation(blip_angle)
						blip_bitmap:set_image(blip_image)
						blip_bitmap:set_center(blip_x + (RADAR_PANEL_W / 2),blip_y + (RADAR_PANEL_H / 2)) -- + (RADAR_PANEL_H - RADAR_SIZE); (RADAR_PANEL_H / 2))
						blip_bitmap:set_color(blip_color)
						if blip_w then 
							blip_bitmap:set_w(blip_w)
						end
						if blip_h then 
							blip_bitmap:set_h(blip_h)
						end
					else
						self:remove_radar_blip(data.unit,blip_key)
					end
				end
			end
		end
		
-- ************** BUFFS ************** 
		if self:IsBuffTrackerEnabled() then	
			if FirstAidKitBase.GetFirstAidKit(player:position()) and (player_damage._uppers_elapsed + player_damage._UPPERS_COOLDOWN < t) then 
				self:AddBuff("uppers_ready")
			else
				self:RemoveBuff("uppers_ready")
			end
			if self:IsBuffEnabled("sicario") then 
				local is_in_smoke = false
				local smoke_timer
				for _, smoke_screen in ipairs(managers.player._smoke_screen_effects or {}) do
					if smoke_screen:is_in_smoke(player) then
						is_in_smoke = true
						smoke_timer = smoke_screen._timer
						break
					end				
				end
				if is_in_smoke then
					self:AddBuff("sicario",{duration = smoke_timer})
				else
					self:RemoveBuff("sicario")
				end
			end
			
			if self:IsBuffEnabled("dodge_chance_total") then 
				local dodge_chance_raw = managers.player:skill_dodge_chance(player:movement():running(),player:movement():crouching(),player:movement():zipline_unit(),false,managers.blackmarket:_get_concealment_from_local_player()) + managers.player:body_armor_value("dodge")
				if dodge_chance_raw >= self:GetDodgeChanceBuffThreshold() then 
					self:AddBuff("dodge_chance_total",{value = dodge_chance_raw})
				else
					self:RemoveBuff("dodge_chance_total")
				end
			end
			
			if self:IsBuffEnabled("crit_chance_total") then 
				local crit_chance_raw = managers.player:critical_hit_chance()
				if crit_chance_raw >= self:GetCritChanceBuffThreshold() then 
					self:AddBuff("crit_chance_total",{value = crit_chance_raw})
				else
					self:RemoveBuff("crit_chance_total")
				end	
			end
			
			if self:IsBuffEnabled("dmg_resist_total") then 
				local dmg_resist_raw = 1 - managers.player:damage_reduction_skill_multiplier("bullet")
				if dmg_resist_raw >= self:GetDmgResistBuffThreshold() then 
					self:AddBuff("dmg_resist_total",{value = dmg_resist_raw})
				else
					self:RemoveBuff("dmg_resist_total")
				end
			end
			
--[[			
			if self:IsBuffEnabled("wild_kill_counter") then 
				local wild_kill_counter = managers.player:get_wild_kill_counter()
				if tweak_data.upgrades.wild_max_triggers_per_time > #wild_kill_counter then
					self:AddBuff("wild_kill_counter",{value=#wild_kill_counter})
				end
			end
			--]]

--[[
			if self:IsBuffEnabled("anarchist_lust_for_life") then 
				local damage_to_armor = player_damage._damage_to_armor or {}
				Console:SetTrackerValue("trackera",tostring(damage_to_armor.target_tick))
				Console:SetTrackerValue("trackerb",tostring(damage_to_armor.elapsed))
				if damage_to_armor and damage_to_armor.elapsed then 
--					self:AddBuff("anarchist_lust_for_life",{duration = damage_to_armor.elapsed})
				else
					self:RemoveBuff("anarchist_lust_for_life")
				end
			end
--]]
			local buffs_panel_master = self._buffs_panel

			local buff_w,buff_h = self:GetBuffItemSize()
			
			local MAX_PER_ROW = math.max(math.floor(buffs_panel_master:w() / buff_w),1)
--			local MAX_PER_COLUMN = math.floor(buffs_panel_master:h() / buff_h)
			
			local num_buffs = 0
			for buff_index,buff_data in ipairs(self._active_buffs) do 
				local buff_id = tostring(buff_data.id)
				local removed_buff = false
				local _t = t
				local buff_tweak_data = self._buff_data[buff_id] 
				local buff_panel = buff_data.panel or buffs_panel_master:child(buff_id)
				local function remove_buff()
					self:RemoveBuff(buff_id,buff_index)
					removed_buff = true
--					buff_panel = nil
				end
				if not buff_tweak_data then 
					self:log("Removing: " .. buff_id .. ". Bad buff tweak data")
					remove_buff()
				elseif not alive(buff_panel) then 
					self:log("Removing: " .. buff_id .. ". Bad buff panel")
					remove_buff()
				else
					--buff is valid... SO FAR. [ominous violin music]
					local buff_type = buff_tweak_data.value_type
					local buff_text = managers.localization:text(buff_tweak_data.label)
					
					local buff_icon = buff_panel:child("icon")
					local buff_label = buff_panel:child("label")
					
					local buff_value
					local buff_time
					
					if self:IsBuffCompactMode() then 
						buff_text = buff_tweak_data.label_compact
						--[[
						local value_pos,_ = string.find(buff_text,"$VALUE")
						local timer_pos,_ = string.find(buff_text,"$TIMER")
						if value_pos and timer_pos then
							if value_pos > timer_pos then 
								buff_text = "$TIMER x$VALUE"
							else
								buff_text = "x$VALUE $TIMER"
							end
						elseif value_pos then 
							buff_text = "x$VALUE"
						elseif timer_pos then 
							buff_text = "$TIMER"
						end--]]
					end
					
					
					if buff_type == "timer" then 
						if not buff_data.end_t then 
							self:log("Buff data has no end_t! Removing...",{color=Color.red})
							remove_buff()
						else
							if buff_tweak_data.timer_source == "heist" then
								_t = managers.game_play_central:get_heist_timer()
							elseif buff_tweak_data.timer_source == "game" then
							--some buffs, such as grenade abilities, are calculated by a timer other than Application:time()
								_t = TimerManager:game():time()
							elseif buff_tweak_data.timer_source == "player" then 
								_t = managers.player:player_timer():time()
							end
							if (buff_data.end_t < _t) and not buff_tweak_data.persistent_timer then 
								self:log("Buff " .. buff_id .. " expired! Removing...",{color=Color.red})
								remove_buff()
							else
								local time_left = math.max(0,buff_data.end_t - _t)
								buff_time = self.format_seconds(0 + time_left)
								if buff_id == "armor_break_invulnerable" then
									local invuln_timer = player_damage._can_take_dmg_timer
									if invuln_timer and invuln_timer > 0 then 
										buff_label:set_text(string.gsub(buff_text,"$TIMER",self.format_seconds(math.ceil(invuln_timer))))
										buff_label:set_color(self.color_data.hud_buff_positive)
										buff_label:set_alpha(1 + (math.sin(_t * 800) * 0.5))
									else
										buff_label:set_text(string.gsub(managers.localization:text("noblehud_buff_armor_break_invulnerable_cooldown_label"),"$TIMER",buff_time))
										buff_label:set_color(buff_tweak_data.text_color)
										buff_icon:set_color(self.color_data.hud_buff_negative)
										buff_label:set_alpha(1)
									end
								elseif buff_id == "hp_regen" then 
									local hp_regained = (buff_data.value) and (" +" .. tostring(buff_data.value) .. "%   ") or ""
									buff_text = string.gsub(buff_text,"$VALUE",hp_regained)
									buff_text = string.gsub(buff_text,"$TIMER",buff_time)
									buff_label:set_text(buff_text)
								elseif buff_id == "anarchist_armor_regen" then 
									local armor_regen_amount = (buff_data.value) and (" +" .. tostring(buff_data.value) .. "%   ") or ""
									buff_text = string.gsub(buff_text,"$VALUE",armor_regen_amount)
									buff_text = string.gsub(buff_text,"$TIMER",buff_time)
									buff_label:set_text(buff_text)
								elseif buff_id == "wild_kill_counter" then
									local wild_kill_triggers = managers.player._wild_kill_triggers or {}
									local max_wild_t
									for trigger,trigger_time in ipairs(wild_kill_triggers) do 
										if trigger_time < _t then 
											table.remove(wild_kill_triggers,trigger)
										else
											max_wild_t = max_wild_t or trigger_time
										end
									end
									if max_wild_t then 
										buff_data.end_t = max_wild_t
									end
									buff_data.value = tweak_data.upgrades.wild_max_triggers_per_time - #wild_kill_triggers
									buff_text = string.gsub(buff_text,"$VALUE",buff_data.value)
									if buff_data.end_t - _t > 0 then
										buff_text = string.gsub(buff_text,"$TIMER",buff_time)
									else
										buff_text = string.gsub(buff_text,"$TIMER","")
									end
									if buff_data.value <= 0 then 
										buff_icon:set_color(self.color_data.hud_buff_negative)
										buff_label:set_color(self.color_data.hud_buff_negative)
									else	
										buff_icon:set_color(self.color_data.hud_buff_neutral)
										buff_label:set_color(self.color_data.hud_buff_neutral)
									end
									buff_label:set_text(buff_text)
								else
									buff_text = string.gsub(buff_text,"$VALUE",buff_data.value or "")
									buff_text = string.gsub(buff_text,"$TIMER",buff_time)
									buff_label:set_text(buff_text)
									if buff_tweak_data.flash then 
										local flash_time = 800
										if type(buff_tweak_data.flash) == "number" then 
											flash_time = buff_tweak_data.flash
										end
										buff_label:set_alpha(1 + (math.sin((buff_data.end_t + _t) * flash_time) * 0.5))
									elseif (buff_tweak_data.flash ~= false) and (time_left <= (buff_tweak_data.flash_threshold or 3)) then 
										buff_label:set_alpha(1 + (math.sin((buff_data.end_t + _t) * 800) * 0.5))
									else
										buff_label:set_alpha(1)
									end
								end
							end
						end
					elseif buff_type == "value" then 
						if buff_id == "berserker_melee_damage_multiplier" or buff_id == "berserker_damage_multiplier" or "buff_id" == "yakuza" then 
							local health_ratio = buff_data.value or 1
--							local health_ratio = managers.player:get_damage_health_ratio(player_damage:health_ratio(),"damage")
							buff_icon:set_color(Color(1,1 - health_ratio,1 - health_ratio))
							buff_label:set_text(string.gsub(buff_text,"$VALUE",string.format("%d",health_ratio * 100)))
							if buff_tweak_data.flash then
								if health_ratio < 0.33 then 
									buff_icon:set_alpha(1 + (math.sin(_t * 400 * (2 - health_ratio)) * 0.5)) --todo increasing flash severity
								else 
--									self:log("Player dead! Removing " .. tostring(buff_id),{color=Color.red})
--									remove_buff()
								end
							end
						elseif buff_id == "dmg_resist_total" then
							buff_label:set_text(string.gsub(buff_text,"$VALUE",string.format("%d",100 * (buff_data.value))))
						elseif buff_id == "dodge_chance_total" then
							buff_label:set_text(string.gsub(buff_text,"$VALUE",string.format("%d",100 * buff_data.value)))
						elseif buff_id == "crit_chance_total" then
							buff_label:set_text(string.gsub(buff_text,"$VALUE",string.format("%d",100 * buff_data.value)))
						elseif buff_id == "grinder" then 
							buff_label:set_text(string.gsub(buff_text,"$VALUE",tostring(buff_data.value or 0)))
							if buff_data.value <= 0 then 
--								self:log("Grinder stacks ended! Removing...",{color=Color.red})
								remove_buff()
							end
						elseif buff_id == "hysteria" then 
							local hysteria_stacks = (buff_data.value or 0) * 100
							buff_label:set_text(string.gsub(buff_text,"$VALUE",string.format("%d",hysteria_stacks)))

							if buff_tweak_data.flash and hysteria_stacks >= tweak_data.upgrades.max_cocaine_stacks_per_tick then --or tweak_data.upgrades.max_total_cocaine_stacks
								local min_alpha = 0.33 --desired minimum alpha; trough
								local b = 1 - (2 / min_alpha) --denominator
								local frequency = 10 --wavelength; lower is more often
								local label_alpha = (0.5 - (1 / b)) + ((math.cos(100 * frequency * _t) / math.pi) / b)
								buff_label:set_alpha(label_alpha) --todo increasing flash severity
							elseif buff_label:alpha() ~= 1 then 
								buff_label:set_alpha(1)
							end
						elseif buff_id == "expresident" then
							local stored_hp_ratio = buff_data.value / (NobleHUD._cache._max_stored_hp or 1)
							if buff_tweak_data.flash and stored_hp_ratio >= 0.9 then 
								local min_alpha = 0.6
								local b = 1 - (2 / min_alpha)
								local frequency = 10 
								local label_alpha = (0.5 - (1 / b)) + ((math.cos(100 * frequency * _t) / math.pi) / b)
								buff_label:set_alpha(label_alpha) 
							elseif buff_label:alpha() ~= 1 then 
								buff_label:set_alpha(1)
							end
							buff_label:set_text(string.gsub(buff_text,"$VALUE",string.format("%d",stored_hp_ratio * 100)))
						elseif buff_id == "delayed_damage" then 
							local current_hp = player_damage:get_real_health()
							if buff_tweak_data.flash and (buff_data.value > current_hp) then 
								local min_alpha = 0.6
								local b = 1 - (2 / min_alpha)
								local frequency = 10 
								local label_alpha = (0.5 - (1 / b)) + ((math.cos(100 * frequency * _t) / math.pi) / b)
								buff_label:set_alpha(label_alpha)
							end
							if current_hp > 0 then 
								buff_label:set_color(NobleHUD.interp_colors(Color.white,Color.red,math.min(buff_data.value / current_hp,1)))
							else
								buff_label:set_color(Color.white)
							end
							buff_label:set_text(string.gsub(buff_text,"$VALUE",string.format("%d",buff_data.value)))
						else
							buff_label:set_text(string.gsub(buff_text,"$VALUE",tostring(buff_data.value or 0)))
			--				self:log("Unknown status for buff " .. buff_id)
						end
					elseif buff_type == "status" then 
						--display text as long as status is present
						if buff_tweak_data.flash then 
							local flash_time = 800
							if type(buff_tweak_data.flash) == "number" then 
								flash_time = buff_tweak_data.flash
							end
							buff_label:set_alpha(1 + (math.sin(_t * flash_time) * 0.5))
						end
						buff_label:set_text(buff_text)
					else
						self:log("UpdateHUD(): Unknown buff value type " .. tostring(buff_type) .. " for id " .. tostring(buff_id),{color=Color.red})
					end
				end
				
				if not removed_buff then 
					num_buffs = num_buffs + 1
					local buff_column = (num_buffs - 1) % MAX_PER_ROW
					local buff_row = math.floor((num_buffs - 1) / MAX_PER_ROW)
					local in_this_line = self._cache.num_buffs - (buff_row * MAX_PER_ROW)
					if in_this_line > math.floor(self._cache.num_buffs / MAX_PER_ROW) then 
						in_this_line = MAX_PER_ROW
					else
						in_this_line = self._cache.num_buffs % MAX_PER_ROW
					end

--align left/right bs
--[[
					local buff_align = self:GetBuffPanelAlign()
					local buff_vertical = self:GetBuffPanelVertical()
					if buff_align == "left" then 
						buff_origin_x = 0
					elseif buff_align == "center" then 
						buff_origin_x = buffs_panel_master:w() / 2
					elseif buff_align == "right" then
						buff_origin_x = buffs_panel_master:w()
					end
					if buff_vertical == "top" then 
						buff_origin_y = 0
					elseif buff_vertical == "center" then 
						buff_origin_y = buffs_panel_master:h() / 2
					elseif buff_vertical == "bottom" then
						buff_origin_y = buffs_panel_master:h()
					end
--]]
					local buff_x = buff_w * buff_column
					local buff_y = buff_h * buff_row
					if self:GetBuffPanelVertical() == "bottom" then 
						buff_y = buffs_panel_master:h() - (buff_y + 64)
					end
					if self:GetBuffPanelAlign() == "right" then 
						buff_x = buffs_panel_master:w() - (buff_x + buff_w)
					end
					local d_x = buff_x - buff_panel:x()
					local d_y = buff_y - buff_panel:y()
					if math.abs(d_x) < 1 then 
						buff_panel:set_x(buff_x)
					else
						buff_panel:set_x(buff_panel:x() + (d_x / 3))
					end
					if math.abs(d_y) < 1 then 
						buff_panel:set_y(buff_y)
					else
						buff_panel:set_y(buff_panel:y() + (d_y / 3))
					end
				end
			end
			self._cache.num_buffs = num_buffs
		end
		
-- ************** CROSSHAIR ************** 
		if self:IsCrosshairEnabled() then --crosshair enabled
			local fwd_ray = player:movement():current_state()._fwd_ray	
			local focused_person = fwd_ray and fwd_ray.unit
--			local crosshair = self._crosshair_panel:child("crosshair_subparts"):child("crosshair_1") --todo function to handle crosshair modifications
			local crosshair_color = Color.white
			if alive(focused_person) then
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
			else
				self:_set_crosshair_color(Color.white)
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
				if state:_is_reloading() then 
					self.weapon_data.bloom = 1
					self:_set_crosshair_bloom(1)
				else
					local bloom_decay_mul = 1.5 -- 3
					if self.weapon_data.bloom > 0 then 
						self.weapon_data.bloom = math.max(self.weapon_data.bloom - (bloom_decay_mul * dt),0)
						local bloom = 0
						if false then --exponential decay
							bloom = 1 - math.pow(1 - self.weapon_data.bloom,2)
						else
							bloom = self.weapon_data.bloom
						end
						self:_set_crosshair_bloom(bloom)
					end
				end
				if true then --if special crosshairs enabled, like grenade launcher altimeter
					self:_set_crosshair_altimeter(viewport_cam:rotation():pitch())
				end
			end
		end
		
		
		--experimental mag count hud
		if self:IsFloatingAmmoPanelEnabled() then
			local floating_ammo_panel = self._floating_ammo_panel
			
			local floating_ammo_blacklisted_states = {
				mask_off = true,
				clean = true,
				civilian = true,
				jerry1 = true,
				jerry2 = true,
				arrested = true,
				incapacitated = true,
				driving = true
			}
			if floating_ammo_blacklisted_states[player_state_name] then
				floating_ammo_panel:set_position(-1000,-1000)
			else
				local wpn_unit = inventory:equipped_unit()
				local wpn_unit_pos = wpn_unit and wpn_unit:position()
				local wpn_unit_screen_pos = wpn_unit_pos and self._ws:world_to_screen(viewport_cam,wpn_unit_pos + ( player:camera():rotation():y() * 100)) --
				if wpn_unit_screen_pos then 
					floating_ammo_panel:set_position(wpn_unit_screen_pos.x,wpn_unit_screen_pos.y)
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
					if style == "animate_popup_queue" then 
						popup_queues = popup_queues + 1
						popup_animate_result = self[style](self,popup,t,dt,popup_start_t,popup_duration,self._popup_end_y + (popup_queues * popup_height),3)
						if popup_animate_result then
							fadeout_popup(popup,0.66,-1)
						end
					elseif style == "animate_popup_bluespider" then
						popup_animate_result = self[style](self,popup,t,dt,popup_start_t,popup_duration,popup_unit,0.15)
						if popup_animate_result then 
							popup:parent():remove(popup)
						end
					elseif style == "animate_popup_athena" then
						popup_animate_result = self[style](self,popup,t,dt,popup_start_t,popup_duration,popup_unit,-30,0.5)
						if popup_animate_result then 
							popup:parent():remove(popup)
						end
					end
					if popup_animate_result then
						--done animating
						table.remove(self._cache.score_popups,i)
					end
				else
					self:log("Popup " .. popup:name() .. " [ #" .. tostring(i) .. " ] " .. " has invalid style [" .. style .. "]; Removing...",{color = Color.red})
					table.remove(self._cache.score_popups,i)
					popup:parent():remove(popup)
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
	
end

function NobleHUD:OnPlayerStateChanged(state)
--	self:log("Changed player state to " .. tostring(state),{color = Color(0,1,1)})
	
	if state == "bleed_out" then 
		self:SetTeammateDowns(1,1,true,true)
	end
	if state == "fatal" or state == "bleed_out" or state == "arrested" or state == "incapacitated" then 
		self:ClearKillsCache()
	end
end

function NobleHUD:OnGameStateChanged(before_state,state)
--lib\utils\game_state_machine
	self:log("Changed game state from " .. tostring(before_state) .. " to " .. tostring(state),{color = Color.green})
	local hud = self._ws and self._ws:panel()
	if not (hud and alive(hud)) then 
		return
	end
	if managers.player and managers.player:local_player() and not self._cache.loaded then
--		self:log("Loaded HUD during state " .. state)
		self:OnLoaded()
	end
	
	if GameStateFilters.any_end_game[state] or GameStateFilters.player_slot[state] or GameStateFilters.lobby[state] or (state == "server_left") then
		if GameStateFilters.any_end_game[state] or (state == "server_left") then 
			--on game ended
			if self._shield_sound_source then 
				self:PlayShieldSound("stop")
				self._shield_sound_source:close()
				self._shield_sound_source = nil
			end
			self:PlayAnnouncerSound("game_over")
		end
		hud:hide()
	elseif GameStateFilters.waiting_for_players[state] or GameStateFilters.waiting_for_respawn[state] or GameStateFilters.waiting_for_spawn_allowed[state] then 
		hud:hide()
		self:PlayShieldSound("stop")
	elseif state == "ingame_access_camera" then 
		hud:hide()
	elseif GameStateFilters.any_ingame[state] then 
		hud:show()
	else
		self:PlayShieldSound("stop")
	end
end

function NobleHUD:OnPeerSynced(peer,peer_id)
	if managers.hud then 
		LuaNetworking:SendToPeer(peer_id,self.network_messages.sync_callsign,self:GetCallsign())
	end
	if Network:is_server() then 
		LuaNetworking:SendToPeer(peer_id,self.network_messages.sync_teamname,self:GetTeamName()) -- .. ":" .. LuaNetworking:ColorToString(self:GetTeamColor()))		
--		LuaNetworking:SendToPeer(peer_id,self.network_messages.sync_teamcolor,self:GetTeamColor())
--todo sync downs
	end
end

function NobleHUD:OnEnemyKilled(attack_data,headshot,unit,variant,player_weapon_id)
	local t = Application:time()
	local player = managers.player:local_player()
	
	local weapon_base
	if attack_data then
		if (not player) or (attack_data.attacker_unit ~= managers.player:local_player()) then
			return
		end
		local player_weapon = attack_data.weapon_unit
		weapon_base = alive(player_weapon) and player_weapon:base()
	end
	attack_data = attack_data or {}
	headshot = headshot or attack_data.head_shot
	
	
	local player_movement = player:movement()
	
	local player_weapon_categories,player_weapon_tweakdata
	if weapon_base then 
		player_weapon_id = player_weapon_id or weapon_base.get_name_id and weapon_base:get_name_id() or ""
		player_weapon_tweakdata = tweak_data.weapon[player_weapon_id]
		player_weapon_categories = weapon_base.categories and weapon_base:categories()
	else
		player_weapon_id = player_weapon_id or ""
		player_weapon_tweakdata = tweak_data.weapon[player_weapon_id] or {}
		player_weapon_categories = player_weapon_tweakdata.categories or {}
	end
	
	local player_state = managers.player:current_state()
	local variant = variant or attack_data.variant
	local base = unit and unit:base()
	local movement = unit and unit:movement()
	local unit_type = base._tweak_table
	local is_cop = CopDamage.is_cop(unit_type)
	local unit_anim = unit and unit.anim_data and unit:anim_data()
	local ext_anim = unit and unit:movement() and unit:movement()._ext_anim or {}
	
	local is_friendly_fire = false
	
	local brain = unit and unit:brain()
	
	local friendly_teams = {
		converted_enemy = true,
		neutral1 = true,
		criminal1 = true,
		hacked_turret = false -- meh, i don't care too much about friendly fire on hacked turrets lol
	}
	local unit_team = (brain and brain._logic_data and brain._logic_data.team and brain._logic_data.team.id) or ""
	if friendly_teams[unit_team] or (unit and (CopDamage.is_civilian(unit:base()._tweak_table) or managers.enemy:is_civilian(unit))) then 
--		self:log("Killed enemy with team " .. tostring(brain._logic_data.team.id),{color=Color.green})
		is_friendly_fire = true
	end
	
	local player_guns = player:inventory():available_selections()
	local primary_id = player_guns[1].unit:base():get_name_id()
	local secondary_id = player_guns[2].unit:base():get_name_id()

	local medal_multiplier = 1

	if is_friendly_fire then
		self:ClearKillsCache()
		self:PlayAnnouncerSound("betrayal")
		--no +1 kills for you, you murderer >:(
	else
		if self:IsSkullActive("birthday") and headshot and unit and alive(unit) and unit:base() then 
			local function spawn_headshot_confetti(effect_name)
				local result = World:effect_manager():spawn({
					effect = Idstring(effect_name or "effects/payday2/particles/impacts/money_impact_pd2"),
					position = movement and movement:m_head_pos() or unit:position() or Vector3()
				})
				if result ~= -1 then 
					return result
				else
					World:effect_manager():spawn({
						effect = Idstring("effects/payday2/particles/impacts/money_impact_pd2"),
						position = movement and movement:m_head_pos() or unit:position() or Vector3()
					})
				end
			end
			spawn_headshot_confetti("effects/payday2/particles/explosions/balloon_pop_red")
			spawn_headshot_confetti("effects/payday2/particles/explosions/balloon_pop_orange")
			spawn_headshot_confetti("effects/payday2/particles/explosions/balloon_pop_green")
			spawn_headshot_confetti("effects/payday2/particles/explosions/balloon_pop_blue")
			spawn_headshot_confetti("effects/payday2/particles/explosions/balloon_pop_purple")
			spawn_headshot_confetti("effects/payday2/particles/explosions/balloon_pop_white")
			
			XAudio.UnitSource:new(unit,XAudio.Buffer:new(NobleHUD._mod_path .. "assets/snd/fx/grunt_birthday.ogg"))
		end
		
		if managers.statistics._global.killed.total and managers.statistics._global.session.killed.total.count == 0 then 
			self:AddMedal("first")
		end
		
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
		
		if ext_anim.reload then 
			self:AddMedal("reload_this")
		end
		
		
		local ptd = tweak_data.blackmarket.projectiles[player_weapon_id]
		if ptd and ptd.is_a_grenade then
--			if variant == "explosion" then 
--			if weapon_base and weapon_base.thrower_unit then
			self:AddMedal("spree_grenade",self:KillsCache("grenade",1))
--			end
--			end
		elseif variant == "bullet" then 
			if headshot then
				if ext_anim.sprint then 
					self:AddMedal("headcase")
				else
					self:AddMedal("headshot")
				end
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
				if headshot then 
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
			local melee_count = self:KillsCache("melee",1)
			self:AddMedal("pummel")
			self:AddMedal("spree_hammer",melee_count)
				
			local mvec_1 = Vector3()
			local mvec_2 = Vector3()
			mvector3.set(mvec_1, unit:position())
			mvector3.subtract(mvec_1, player:position())
			mvector3.normalize(mvec_1)
			mvector3.set(mvec_2, unit:rotation():y())
			if mvector3.dot(mvec_1, mvec_2) >= 0 then
				self:AddMedal("beatdown")
			end
			if unit:movement():cool() then
				self:AddMedal("assassination")
				medal_multiplier = medal_multiplier * self:GetMedalMultiplier("assassination")
			end
			--[[
			if attack_data.cool then 
				self:AddMedal("assassination")
				medal_multiplier = medal_multiplier * self:GetMedalMultiplier("assassination")
			end
			if attack_data.from_behind then
				self:AddMedal("beatdown")
			end
			--]]
		elseif variant == "graze" then 
			--supercombine kill medal?
		elseif variant == "vehicle" then 
			self:AddMedal("splatter")
			self:AddMedal("spree_splatter",self:KillsCache("vehicle",1))
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
	self:TallyScore(attack_data.name or unit_type,unit,medal_multiplier,is_friendly_fire)
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
	NobleHUD._cache.kills = table.deep_map_copy(kills_cache_empty)
--[[
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
	--]]
end

function NobleHUD:OnTeammateKill(player_unit)

	--if player_unit is in your car, give wheelman medal
	local peer_id = alive(player_unit) and managers.criminals:character_peer_id_by_unit(player_unit)
	local vehicle = peer_id and managers.player:get_vehicle_for_peer(peer_id)
	local my_vehicle = managers.player:get_vehicle() or {}
	if my_vehicle and my_vehicle.vehicle_unit then --
		if vehicle and vehicle.vehicle_unit then 
			if alive(vehicle.vehicle_unit) and alive(my_vehicle.vehicle_unit) then 
				if vehicle.vehicle_unit == my_vehicle.vehicle_unit then
					if my_vehicle.seat == "driver" then 
						NobleHUD:AddMedal("wheelman")
						NobleHUD:AddMedal("spree_wheelman",NobleHUD:KillsCache("vehicle_assist",1))
					end
				end
			end
		end
	end
end

function NobleHUD:LoadXAudioSounds()
    if blt.xaudio then
        blt.xaudio.setup()
		
		local function loadsound(snd)
			local path = NobleHUD._announcer_path .. snd .. ".ogg"
			self._cache.sounds[snd] = XAudio.Buffer:new(path)
		end
		
		-- Announcer (Downes/Chief)
		self._announcer_sound_source = self._announcer_sound_source or XAudio.Source:new()
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
		self._cache.sounds.shield_low = XAudio.Buffer:new(NobleHUD._mod_path .. "assets/snd/fx/shield_low.ogg")
		self._cache.sounds.shield_empty = XAudio.Buffer:new(NobleHUD._mod_path .. "assets/snd/fx/shield_depleted.ogg")
		self._cache.sounds.shield_charge = XAudio.Buffer:new(NobleHUD._mod_path .. "assets/snd/fx/shield_charge_reach.ogg")
		
		if managers.player:local_player() and (managers.player:local_player():character_damage():_max_armor() > 0) then 
			self._shield_sound_source = XAudio.Source:new()
			self._shield_sound_source:set_looping(true)
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
--		XAudio.Source:new(XAudio.Buffer:new(snd))
		if self._announcer_sound_source then 
			self._cache.announcer_queue[#self._cache.announcer_queue + 1] = name
		end
	else
		self:log("PlayAnnouncerSound(): sound [" .. name .. "] not found",{color = Color.red})
	end
end

function NobleHUD:CheckShieldSoundVolume(event,value)
	local source = self._shield_sound_source
	if not (source and not source:is_closed()) then
--		self:log("ERROR! Sound source is nonexistent",{color=Color.red})
		return
	end
	if source._buffer == self._cache.sounds[tostring(event)] then 
		source:set_volume(value)
	end
end

function NobleHUD:PlayShieldSound(event,enabled)
	local source = self._shield_sound_source
	if not (source and not source:is_closed()) then
--		self:log("ERROR! Sound source is nonexistent",{color=Color.red})
		return
	end
	enabled = not (enabled == false)
	local should_loop
	local volume = 1
	if event == "stop" then 
		source:stop()
		return
	elseif enabled then 
		if event == "shield_empty" then 
			if not self:IsShieldEmptySoundEnabled() then	
--				source:stop()
				return
			end
			should_loop = true
			volume = self:GetShieldEmptyVolume()
		elseif event == "shield_low" then 
			if not self:IsShieldLowSoundEnabled() then 
--				source:stop()
				return
			end
			should_loop = true
			volume = self:GetShieldLowVolume()
		elseif event == "shield_charge" then 
			if not self:IsShieldChargeSoundEnabled() then 
--				source:stop()
				return
			end
			should_loop = false
			volume = self:GetShieldChargeVolume()
		end
	end	
	local buffer = self._cache.sounds[tostring(event)]
	if not buffer then 
--		self:log("ERROR! PlayShieldSound(" .. tostring(event) .. "): Specified audio buffer is invalid ",{color=Color.red})
		return
	end
	if source._buffer ~= buffer then 
		if enabled then 
			source:stop()
			source:set_buffer(buffer)
			source:set_volume(volume)
			source:set_looping(should_loop)
			source:play()
		end
	elseif not enabled then
		source:stop()
		return
	elseif source:get_state() ~= 1 then 
		source:play()
	end
end


--HIT INDICATOR
function NobleHUD:AddHitIndicator(damage_origin, damage_type, fixed_angle)
	damage_type = damage_type or HUDHitDirection.DAMAGE_TYPES.HEALTH
	
	local color = Color(1,1,1)
	
	if damage_type == HUDHitDirection.DAMAGE_TYPES.HEALTH then
		color = self.color_data.hud_hit_health
	elseif damage_type == HUDHitDirection.DAMAGE_TYPES.ARMOUR then
		color = self.color_data.hud_hit_armor
	elseif damage_type == HUDHitDirection.DAMAGE_TYPES.VEHICLE then
		color = self.color_data.hud_hit_vehicle
	end
	
	local name = "hit_" .. tostring(damage_origin) .. "_" .. tostring(damage_type) .. "_" .. tostring(fixed_angle)
	local hit = self._ws:panel():bitmap({
		name = name,
		texture = "guis/textures/damage_overlay_2",
		blend_mode = "add",
		alpha = 0,
		layer = -1000,
		rotation = 0,
		color = color
	})
	local hit_mirror = self._ws:panel():bitmap({
		name = name .. "_mirror",
		texture = "guis/textures/damage_overlay_2",
		blend_mode = "add",
		alpha = 0,
		layer = -1000,
		rotation = 0,
		color = color
	})

	local function remove_hit(o)
		o:parent():remove(o)
	end
--[[		
	
	local function fadeout(o)
		NobleHUD:animate(o,"animate_hit_out",remove_hit,0.3)
	end
--]]	
	
	local duration = 0.5
	self:animate(hit,"animate_hit_in",remove_hit,duration,damage_origin,fixed_angle)
	self:animate(hit_mirror,"animate_hit_in",remove_hit,duration,damage_origin,fixed_angle,true)
end

function NobleHUD:animate_hit_in(o,t,dt,start_t,duration,damage_origin,fixed_angle,mirrored)
	local ratio = (t - start_t) / duration
	local angle = 0
	local angle_alpha = 0
	local on_left_side
	if fixed_angle then 
		angle = fixed_angle
	else
		if alive(managers.player:local_player()) then 
			local ply_camera = managers.player:local_player():camera()
			if ply_camera then 
				local target_vec = ply_camera:position() - damage_origin
				angle = target_vec:to_polar_with_reference(ply_camera:forward(), math.UP).spin
				on_left_side = angle <= 0 
			end
		end
	end
	
	if angle == 0 then 
		angle_alpha = 1
	else
		angle_alpha = 22.5 / (math.abs(angle) - (180 - 45))
	end
	if mirrored then 
		on_left_side = not on_left_side
		angle_alpha = angle_alpha * 0.5
	end
	if on_left_side then 
		o:set_rotation(0)
		o:set_x(0)
	else 
		o:set_rotation(180)
		o:set_x(o:parent():w() - o:w())					
	end
	
	o:set_alpha(math.min(angle_alpha,0.33))
	
	if ratio >= 1 then 
		return true
	end
end

function NobleHUD:animate_hit_out(o,t,dt,start_t,duration,damage_origin,fixed_angle)
	
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
		y = 24,
		alpha = self:GetHUDAlpha()
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
			visible = false, --disabled unless bullet count exceeds available space
			text = "60",
--			align = "right",
--			vertical = "bottom",
			y = weapon_icon:y(),
--			x = weapon_icon:right() - 12,
			color = self.color_data.white,
			alpha = 0.66,
			font = self.fonts.eurostile_ext,
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
			font = self.fonts.eurostile_ext,
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

	local function create_ammo_radial()
		local ammo_radial = panel:bitmap({
			name = "ammo_radial",
			render_template = "VertexColorTexturedRadial",
			texture = texture,
			texture_rect = texture_rect,
			w = 32,--texture_data.icon_w,
			h = 32,--texture_data.icon_h,
			layer = 2,
			color = Color.white,
			alpha = 1
		})
	
--		if alive(weapon_panel:child("mag_label")) then 
--			weapon_panel:child("mag_label"):show()
--		end
	end
	local function create_ammo_bar(use_generic_bar)
		local _texture = texture
		local _rect = texture_rect
		local _w = texture_data.icon_w
		local _h = texture_data.icon_h
		if use_generic_bar then 
			_texture = "guis/textures/test_blur_df"
			_rect = nil
			_w = 100
			_h = 8
		end
		local ammo_bar = panel:bitmap({
			name = "ammo_bar",
			texture = _texture,
			texture_rect = _rect,
			w = _w,
			h = _h,
			layer = 2,
			color = self.color_data.hud_weapon_color,
			alpha = 1
		})
		local ammo_bg = panel:bitmap({
			name = "ammo_bar",
			texture = _texture,
			texture_rect = _rect,
			w = _w,
			h = _h,
			layer = 1,
			color = Color(0,0.3,0.7),
			alpha = 0.3
		})
		ammo_bar:set_y(panel:h() - ammo_bar:h())
		ammo_bg:set_y(panel:h() - ammo_bg:h())
		
		if alive(weapon_panel:child("mag_label")) then 
			weapon_panel:child("mag_label"):show()
		end
	end
	
	local function create_ammo_ticks()
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

	if texture_data.use_radial then 
		create_ammo_radial()
	elseif texture_data.use_bar then 
		create_ammo_bar()
	else
		

		local t_w = texture_data.icon_w
		local t_h = texture_data.icon_h
		
		local a_w = weapon_panel:w()
		local a_h = weapon_panel:h()
		
--		self:log("Creating default ammo panel... " .. NobleHUD.table_concat({clip_max = clip_max, t_w = t_w, t_h = t_h, a_w = a_w, a_h = a_h},",","=") .. "  |  " .. tostring(clip_max * (t_w * t_h + margin_w)) .. "  |  " .. tostring(a_w * a_h))
		if (clip_max * t_w * t_h) > (a_w * a_h) * 0.15 and (texture_data.use_bar ~= false) then --roughly, above this percentage, ammo ticks would obscure the ammo counter text
			create_ammo_bar(true)
		else
			create_ammo_ticks()
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
		
		
		
		local underbarrel_names = managers.weapon_factory:get_parts_from_weapon_by_type_or_perk("underbarrel", base._factory_id, base._blueprint)
		if underbarrel_names and underbarrel_names[1] then 
			local underbarrel = base._parts[underbarrel_names[1]]
			if underbarrel then 
				local underbarrel_base = underbarrel.unit:base()
				self.weapon_data[i].underbarrel.base = underbarrel_base
--				local underbarrel_tweak = tweak_data.weapon[underbarrel_base.name_id]
--				self:_create_ammo_ticks(base,"underbarrel")
				self:_create_custom_crosshairs(i,underbarrel_base,"underbarrel") --technically works but is ugly
--				create_crosshair(underbarrel_base,"underbarrel",underbarrel_tweak,underbarrel_tweak.name_id)
			end
		end

--[[		
	04:13:59 PM Lua: CONSOLE: > logall(NobleHUD.weapon_data[2].underbarrel.base._ammo)
04:13:59 PM Lua: CONSOLE: Index [_ammo_max_per_clip2] : [1]
04:13:59 PM Lua: CONSOLE: Index [_ammo_max2] : [3]
04:13:59 PM Lua: CONSOLE: Index [_ammo_remaining_in_clip] : [1]
04:13:59 PM Lua: CONSOLE: Index [_ammo_pickup] : [table: 0x293d5e30]
04:13:59 PM Lua: CONSOLE: Index [_name_id] : [contraband_m203]
04:13:59 PM Lua: CONSOLE: Index [_ammo_total] : [2]	
		

--]]		
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
	self:SetFloatingAmmo(slot,amount,max_amount)
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
		--ammo_bar:set_x(bar_w * (1  -ratio))
		--ammo_bar:set_w(bar_w * amount/max_amount)
	elseif alive(ammo_radial) then 
		ammo_radial:set_color(Color(ratio,max_amount,0))
	else
		for i = 1,max_amount do 
			local ammo_icon = weapon_panel:child("weapon_ammo_ticks"):child("ammo_icon_" .. i)
			--! todo if below certain ammo percent threshold, animate color flash on each remaining icon
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
			self:SetFloatingAmmo(i,base:get_ammo_remaining_in_clip(),base:get_ammo_max_per_clip())
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
	if self:IsFloatingAmmoPanelEnabled() then 
		self._floating_ammo_panel:child("primary"):set_visible(id == 1)
		self._floating_ammo_panel:child("secondary"):set_visible(id == 2)
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
	
function NobleHUD:UseWeaponRealAmmoCounter()
	return self.settings.weapon_ammo_real_counter
end	
	
--		FLOATING MAG INDICATOR

function NobleHUD:_create_floating_ammo(hud)
	local floating_ammo_panel = hud:panel({
		name = "floating_ammo_panel",
		h = 50,
		w = 100,
		alpha = self:GetHUDAlpha(),
		visible = false --set enabled on load
	})
	local margin = 4
	local bg = floating_ammo_panel:rect({
		name = "bg",
		color = Color.black,
		alpha = 0.3,
		layer = 1
	})
	local primary = floating_ammo_panel:text({
		name = "primary",
		text = "69/420",
--		vertical = "center",
--		align = "center",
		x = margin/2,
		y = margin/2,
		font = tweak_data.hud_players.ammo_font,
		font_size = 16,
		layer = 3,
		visible = true
	})
	local secondary = floating_ammo_panel:text({
		name = "secondary",
		text = "420/69",
		x = margin/2,
		y = margin/2,
		font = tweak_data.hud_players.ammo_font,
		font_size = 16,
		layer = 3,
		visible = false
	})
	self._floating_ammo_panel = floating_ammo_panel
end

function NobleHUD:SetFloatingAmmo(slot,current,total)
	local margin = 4
	local magazine = self._floating_ammo_panel:child("primary")
	if slot == 2 then 
		magazine = self._floating_ammo_panel:child("secondary")
	end
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

function NobleHUD:GetCrosshairChoiceByType(weapon_type,fire_mode,is_akimbo)
	fire_mode = tostring(fire_mode or "single")
	local index
	if weapon_type == "assault_rifle" then 
		if fire_mode == "auto" then 
			index = self.settings.crosshair_type_assaultrifle_auto
		else
			index = self.settings.crosshair_type_assaultrifle_single
		end
	elseif weapon_type == "pistol" then
		if fire_mode == "auto" then 
			index = self.settings.crosshair_type_pistol_auto
		else
			index = self.settings.crosshair_type_pistol_single
		end
	elseif weapon_type == "revolver" then
		if fire_mode == "auto" then 
			index = self.settings.crosshair_type_pistol_auto
		else
			index = self.settings.crosshair_type_pistol_single
		end
	elseif weapon_type == "smg" then
		if fire_mode == "auto" then 
			index = self.settings.crosshair_type_smg_auto
		else
			index = self.settings.crosshair_type_smg_single
		end
	elseif weapon_type == "shotgun" then
		if fire_mode == "auto" then 
			index = self.settings.crosshair_type_shotgun_auto
		else
			index = self.settings.crosshair_type_shotgun_single
		end
	elseif weapon_type == "lmg" then
		if fire_mode == "auto" then 
			index = self.settings.crosshair_type_lmg_auto
		else
			index = self.settings.crosshair_type_lmg_single
		end
	elseif weapon_type == "snp" then
		index = self.settings.crosshair_type_snp
	elseif weapon_type == "rocket" then
		index = self.settings.crosshair_type_rocket
	elseif weapon_type == "minigun" then
		index = self.settings.crosshair_type_minigun
	elseif weapon_type == "flamethrower" then
		index = self.settings.crosshair_type_flamethrower
	elseif weapon_type == "saw" then
		index = self.settings.crosshair_type_saw
	elseif weapon_type == "grenade_launcher" then
		index = self.settings.crosshair_type_grenade_launcher
	elseif weapon_type == "bow" then
		index = self.settings.crosshair_type_bow
	elseif weapon_type == "crossbow" then
		index = self.settings.crosshair_type_crossbow
	else
		if self.settings["crosshair_type_" .. weapon_type] then
			index = self.settings["crosshair_type_" .. weapon_type]
		elseif self.settings["crosshair_type_" .. weapon_type .. "_" .. fire_mode] then
			index = self.settings["crosshair_type_" .. weapon_type .. "_" .. fire_mode]
		end
	end
	
	return self._reticle_types_by_index[index or 1]
end

--todo user prefs
function NobleHUD:_get_crosshair_type_from_weapon_base(base,fire_mode,override_data,override_id)
	if not base then 
		self:log("ERROR: _get_crosshair_type_from_weapon_base(" .. NobleHUD.table_concat({base,slot},",") .. "): bad base/slot")
		return
	end	
	local function crosshair_from_category(cat,mode) --default settings for "auto" setting, or for nonexistent crosshair data
		if cat == "assault_rifle" then 
			if mode == "single" then
				return "dmr"
			else
				return "assault_rifle"
			end
		elseif cat == "smg" then 
			if mode == "single" then 
				return "needle_rifle"
			else
				return "smg"
			end
		elseif cat == "shotgun" then 
			return "shotgun"
		elseif cat == "lmg" then 
			return "plasma_repeater"
		elseif cat == "snp" then 
			return "sniper"
		elseif cat == "rocket" then
			return "rocket"
		elseif cat == "minigun" then
			return "minigun"
		elseif cat == "flamethrower" then 
			return "flamethrower"
		elseif cat == "saw" then 
			return "sword"
		elseif cat == "grenade_launcher" then 
			return "grenade_launcher"
		elseif cat == "pistol" then -- or cat == "revolver" then 
			return "pistol"
		elseif cat == "bow" then 
			return "plasma_pistol"
		elseif cat == "crossbow" then 
			return "pistol"
		end		
	end	
	local categories = override_data and override_data.categories
	local weapon_id = override_id or override_data and override_data.weapon_id
	
	if not categories then 
		if type(base.categories) == "table" then 
			categories = base.categories
		elseif type(base.categories) == "function" then 
			categories = base:categories()
		else
			categories = {}
		end
	end
	if not weapon_id then 
		weapon_id = base.get_name_id and base:get_name_id() or ""
	end
	
	if self._crosshair_override_data[weapon_id] then 
		if self._crosshair_override_data[weapon_id][fire_mode] then	
			return self._crosshair_override_data[weapon_id][fire_mode]
		end
	end
	local weapon_category,is_revolver,is_akimbo
		
		--category = base:get_override_gadget_base()
		--get weapon type from gadget
		
	for _,category in pairs(categories) do 
		if category == "revolver" then 
			is_revolver = true
		elseif category == "akimbo" then 
			is_akimbo = true
		else
			weapon_category = category
		end
	end	
	return self:GetCrosshairChoiceByType(weapon_category,fire_mode) or crosshair_from_category(weapon_category,fire_mode) or "plasma_rifle"
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

function NobleHUD:_create_custom_crosshairs(slot,base,override_firemode)
	if not slot then 
		self:log("ERROR: _create_custom_crosshairs(" .. NobleHUD.table_concat({slot,base}) .. "): bad slot")
		return
	end
	if not base then
		self:log("ERROR: _create_custom_crosshairs(" .. NobleHUD.table_concat({slot,base}) .. "): bad weapon base")
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
	
	local function create_crosshair (_base,_firemode,...)
--		local modepanel = self:_get_crosshair_by_info(slot,_firemode)
		local modepanel = slotpanel:child(_firemode)
		local crosshair_type = self:_get_crosshair_type_from_weapon_base(_base,_firemode,...)
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
	
	local firemode_current = override_firemode or base:fire_mode()
	

	--[[
	local gadgetbase = base:gadget_overrides_weapon_functions()
	if gadgetbase then
		create_crosshair(gadgetbase,"underbarrel")
	end
	--]]
	
	local override_tweak = override_firemode and base._tweak_data
	local override_id = override_firemode and base.name_id
	
	if base:can_toggle_firemode() and not base._locked_firemode then
		create_crosshair(base,"single",override_tweak,override_id)
		create_crosshair(base,"auto",override_tweak,override_id)
	else
		create_crosshair(base,firemode_current,override_tweak,override_id)
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
--		self._altimeter = altimeter_frame
	end
end

function NobleHUD:_set_crosshair_altimeter(angle)
--[[
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
		end
	end
	--]]
	
	local modepanel = self:get_current_crosshair()
	if modepanel and alive(modepanel) then 
		local frame = modepanel:child("altimeter_frame")
		if frame and alive(frame) then
			local altimeter = frame and frame:child("altimeter_slide")
			if alive(altimeter) then 
				altimeter:set_y(((angle / 90) * 160	)+ (-3 * (160 / 2) ))
			end
		end
	end
--[[
	--]]
end

function NobleHUD:is_weapon_crosshair_override_present(id) --not used
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

--some assembly required
function NobleHUD:_set_crosshair_color(color)
	local function a(index,bitmap,data)
		bitmap:set_color(data.color)
	end
	self:get_current_crosshair_parts(a,{color = color})
end

function NobleHUD:_get_crosshair_by_info(slot,mode)
	if not (slot and mode) then 
		self:log("ERROR: _get_crosshair_by_info(" .. NobleHUD.table_concat({slot,mode},",") .. "): bad slot/mode")
		return
	end
	local slotpanel = self._crosshair_panel:child("crosshair_slot" .. tostring(slot))
	if not slotpanel then 
		self:log("ERROR: _get_crosshair_by_info(" .. NobleHUD.table_concat({slot,mode},",") .. "): no slotpanel")
		return
	elseif not slotpanel:child(mode) then 
		self:log("ERROR: _get_crosshair_by_info(" .. NobleHUD.table_concat({slot,mode},",") .. "): no modepanel")
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
		h = 64,
		alpha = self:GetHUDAlpha()
	})
	
	self._grenades_panel = grenades_panel
	local primary_grenade_panel = grenades_panel:panel({
		name = "primary_grenade_panel"
	})
	
	local secondary_grenade_panel = grenades_panel:panel({ --this one can be used for deployables if the player so chooses (todo)
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
--			blend_mode = "add",
			alpha = 0.9,
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
			font = self.fonts.eurostile_ext,
			font_size = 24
		})
		local grenade_cooldown = panel:bitmap({ --used for cooldown
			name = "grenade_cooldown",
			texture = "guis/textures/pd2/hud_cooldown_timer",
			render_template = "VertexColorTexturedRadial",
			color = Color.white,
			visible = false, --set visible later
			w = icon_size,
			h = icon_size,
			alpha = 0.8,
			layer = -2
		})
		
		local grenade_outline = panel:bitmap({ --used for duration of active abilities
			name = "grenade_outline",
			texture = "guis/textures/ability_circle_outline",
			render_template = "VertexColorTexturedRadial",
			layer = 2,
			color = Color.black,
			w = panel:w(),
			h = panel:h(),
			alpha = 0.8,
			visible = true,
			x = 0,
			y = 0
		})
		local center_x,center_y = panel:center()
		grenade_outline:set_center(center_x,center_y)
		grenade_icon:set_center(center_x,center_y)
		grenade_cooldown:set_center(center_x,center_y)
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

--		NobleHUD:log("[set_grenade_cooldown () data: ")
--		logall(data)
--		NobleHUD:log("end data]")
		
	local grenades_panel = self._grenades_panel:child("primary_grenade_panel")
	local grenades_outline = grenades_panel:child("grenade_outline")
	local grenade_icon = grenades_panel:child("grenade_icon")
	local grenade_cooldown = grenades_panel:child("grenade_cooldown")
	if not grenade_cooldown:visible() then 
		grenade_cooldown:set_color(Color.white)
		grenade_cooldown:show()
	end
	local end_time = data and data.end_time
	local duration = data and data.duration
	
	local center_x,center_y = grenades_panel:center()
	local function animate_cooldown_over(o)
		o:hide()
		self:animate(grenade_icon,"animate_killfeed_icon_pulse",nil,0.66,o:w(),1.5,center_x,center_y)
		
	end
	
	
	
	local t = managers.game_play_central:get_heist_timer()
	local t_offset = Application:time() - t
	local animate_target = self._animate_targets[tostring(grenade_cooldown)]
	if (duration and duration > 0) then
		if (end_time and end_time > t) then 
			if animate_target then 
				local duration_remaining = end_time - t
				local elapsed = duration - duration_remaining
				animate_target.start_t = end_time - duration + t_offset
			else
				self:animate(grenade_cooldown,"animate_color_fadeto",animate_cooldown_over,duration,Color.white,Color.black) --operates as countdown timer, so full circle shrinking radially to empty circle
			end	
		else
			self:animate_stop(grenade_cooldown)
			animate_cooldown_over(grenade_cooldown)
		end

	else --if invalid data or over immediately
		--since cooldown is over immediately, flash the yellow "in use" color and immediately cooldown it
		local start_color = self.color_data.unique
		grenade_icon:set_color(start_color)
		self:animate(grenade_icon,"animate_killfeed_icon_pulse",function(o) 
			self:animate(o,"animate_color_fadeto",function() grenade_cooldown:hide() end,0.25,start_color,self.color_data.hud_blueoutline)
		end,0.66,grenade_icon:w(),1.5,center_x,center_y)
	end
end


function NobleHUD:animate_color_fadeto(o,t,dt,start_t,duration,color1,color2)
	if t > (start_t + duration) then 
		o:set_color(color2)
		return true
	end
	o:set_color(self.interp_colors(color1,color2,(t - start_t) / duration))
end

function NobleHUD:animate_wait(o,t,dt,start_t,duration)
	if (t - start_t) >= duration then
		return true
	end
	--that's it. that's the whole function. can i get my paycheck now
end

function NobleHUD:_activate_ability_radial(time_left,time_total)
--	self:log("activate_ability_radial(" .. NobleHUD.table_concat({time_left = time_left,time_total = time_total},",","=") .. ")")
end

function NobleHUD:_set_ability_radial(time_left,time_total)
	local grenades_panel = self._grenades_panel:child("primary_grenade_panel")
	local grenade_outline = grenades_panel:child("grenade_outline")
	local grenade_icon = grenades_panel:child("grenade_icon")
	if (time_total == 0) or (time_left <= 0) then 
		grenade_outline:set_color(Color.black)
		grenade_icon:set_color( self.color_data.hud_vitalsfill_blue )
	else
		local ratio = time_left / time_total
		local color1 = self.color_data.hud_vitalsfill_yellow
		local color2 = self.color_data.hud_vitalsfill_blue
		speed = 200
		if ratio < 0.5 then 
			color2 = self.color_data.hud_vitalsfill_red
			speed = 400
		end
		grenade_icon:set_color( self.interp_colors(color1,color2,math.sin(math.pi * speed * Application:time()) + 0.5))
		grenade_outline:set_color(Color(time_left/time_total,0,0))
	end
end


--		DEPLOYABLES

function NobleHUD:_create_ability(hud) --armor ability slot?
	local ability_master = hud:panel({
		name = "ability_panel", --master panel
		w = 72,
		h = 60,
		x = 8,
		y = hud:bottom() - 286,
		alpha = self:GetHUDAlpha()
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
			font = self.fonts.eurostile_ext,
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

function NobleHUD:LayoutAbility()
	if self._ability_panel then 
		if self:ShouldAlignAbilityToRadar() then 
			local radar_panel = self._radar_panel
			local diagonal = math.sqrt(math.pow(radar_panel:w(),2) + math.pow(radar_panel:h(),2))
			local radar_gap = (diagonal - radar_panel:h()) / 2
			self._ability_panel:set_x(radar_panel:x() + (radar_gap + self:GetAbilityPanelX()) - self._ability_panel:w())
			self._ability_panel:set_y(radar_panel:y() + (radar_gap + self:GetAbilityPanelY()) - self._ability_panel:h())
			
--			self._abilty_panel:set_position(self._radar_panel:x() - (radar_gap + self:GetAbilityPanelX() + self._ability_panel:w()),self._radar_panel:y() + (radar_gap + self:GetAbilityPanelY()) - self._ability_panel:h())
--			self._ability_panel:set_position(self._radar_panel:x() + self:GetAbilityPanelX() - self._ability_panel:w(),self._radar_panel:y() + self:GetAbilityPanelY() - self._ability_panel:h())
		else
			self._ability_panel:set_position(self:GetAbilityPanelX(),self:GetAbilityPanelY())
		end
	end
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
		x = 250,
		y = hud:h() - 78,--430
--		x = 170,
--		y = 430
	})
	
	local stamina_outline = stamina_panel:bitmap({
		name = "stamina_outline",
		texture = "guis/textures/ability_circle_outline",
		w = icon_size,
		h = icon_size,
		render_template = "VertexColorTexturedRadial",
		alpha = 0.5,
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
		elseif stamina_panel:alpha() < 1 then 
			stamina_panel:set_alpha(math.clamp(stamina_panel:alpha() * 1.3,0.001,self:GetHUDAlpha()))
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

function NobleHUD:LayoutStamina()
	local stamina_panel = self._stamina_panel
	stamina_panel:set_position(self:GetStaminaPanelX(),self:GetStaminaPanelY())
end


--		TEAMMATES

function NobleHUD:_create_teammates(hud)
	local num_teammates = 4

	local teammates_panel = hud:panel({
		name = "teammates_panel",
		w = 512,
		h = num_teammates * self._TEAMMATE_ITEM_H,
		x = 100,
		y = 0,
		alpha = self:GetHUDAlpha()
		-- hud:h() - 256
	})
	self._teammates_panel = teammates_panel

	local teammates_debug = teammates_panel:rect({
		name = "teammates_debug",
		w = 1280,
		h = 720,
		visible = false,
		color = Color.blue,
		alpha = 0.4
	})
	

	
	for i=1,num_teammates do 
		self:_create_teammate_panel(teammates_panel,i)
	end
	
	return teammates_panel
end

function NobleHUD:GetTeammatePanel(i)
	return self._teammates_panel:child("teammate_" .. tostring(i))
end

function NobleHUD:_create_teammate_panel(teammates_panel,i)
	local ammo_font = tweak_data.hud_players.ammo_font
--	local name_font = tweak_data.hud_players.name_font
	local teammate_w = self._TEAMMATE_ITEM_W
	local teammate_h = self._TEAMMATE_ITEM_H
	local subpanel_w = 24
	local subpanel_h = 36
	local icon_size = 16
	local divider_w = 2
	
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
		w = 56
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
	local c_ratio = callsign_box:w() / self._NAMEPLATE_W
	local character_bitmap_bg = callsign_box:bitmap({
		name = "character_bitmap_bg",
		layer = 0,
		rotation = 360,
		alpha = 0.25,
		texture = "guis/textures/teammate_nameplate_fill",
		color = self.color_data.hud_weapon_color,
		w = self._NAMEPLATE_W * c_ratio,
		h = self._NAMEPLATE_H * c_ratio,
		y = (teammate_h - (24)) * 0.5,
		visible = false
	})
	
	local player_name = callsign_box:text({
		name = "player_name",
		layer = 1,
		text = "",
		y = 1,
		align = "center",
		valign = "center",
		vertical = "center",
		color = Color.white,
		font_size = tweak_data.hud_players.name_size,
		font = ammo_font
	})

	local vitals_icon_size = 32
	local vitals_subpanel = panel:panel({
		name = "vitals_subpanel",
		x = callsign_box:right(),
		w = subpanel_w,
		h = 48,
		visible = false
	})
	
	local vitals_armor_label = vitals_subpanel:text({
		name = "vitals_armor_label",
		layer = 1,
		text = "100",
		vertical = "top",
		align = "center",
		color = Color.white,
		font_size = tweak_data.hud_players.name_size,
		font = ammo_font
	})
	
	local vitals_icon_x = (vitals_subpanel:w() - vitals_icon_size) / 2
	local vitals_icon_y = (vitals_subpanel:h() - vitals_icon_size) / 2
	local vitals_icon = vitals_subpanel:bitmap({
		name = "vitals_icon",
		layer = 0,
		rotation = 360,
		texture = "guis/textures/lives_icon",
		color = self.color_data.hud_blueoutline,
		x = vitals_icon_x,
		y = vitals_icon_y,
		w = vitals_icon_size,
		h = vitals_icon_size,
		alpha = 1
	})
	
	local vitals_icon_bg = vitals_subpanel:bitmap({
		name = "vitals_icon_bg",
		layer = -1,
		visible = false, --unused
		rotation = 360,
		texture = "guis/textures/lives_icon",
		color = self.color_data.hud_bluefill,
		x = vitals_icon_x,
		y = vitals_icon_y,
		w = vitals_icon_size,
		h = vitals_icon_size,
		alpha = 0.25
	})
	
	
	local vitals_health_label = vitals_subpanel:text({
		name = "vitals_health_label",
		layer = 1,
		text = "100",
		vertical = "bottom",
		align = "center",
		color = Color.white,
		font_size = tweak_data.hud_players.name_size,
		font = ammo_font
	})
	
	local deployable_subpanel = panel:panel({
		name = "deployable_subpanel",
		x = vitals_subpanel:right(),
		w = subpanel_w, --*2	
		h = subpanel_h,
		visible = false
	})
	local debug_subpanel1 = deployable_subpanel:rect({
		name = "debug_subpanel1",
		color = Color.red,
		alpha = 0.1,
		visible = false
	})
	
	local deployable_texture,deployable_rect = tweak_data.hud_icons:get_icon_data("equipment_ammo_bag")
	local deployable_icon = deployable_subpanel:bitmap({
		name = "deployable_icon",
		layer = 0,
		rotation = 360,
		texture = deployable_texture,
		texture_rect = deployable_rect,
		color = self.color_data.hud_bluefill,
		x = (deployable_subpanel:w() - icon_size) / 2,
		w = icon_size,
		h = icon_size
	})
	local deployable_label = deployable_subpanel:text({
		name = "deployable_label",
		layer = 1,
		text = "14|6",
		align = "center",
		vertical = "bottom",
		color = Color.white,
		font_size = tweak_data.hud_players.name_size,
		font = ammo_font
	})
	
	local deployable_divider = deployable_subpanel:rect({
		name = "deployable_divider",
		color = self.color_data.hud_blueoutline,
		w = divider_w,
		h = teammate_h,
		x = deployable_subpanel:w() - divider_w
	})
	
	
	local ties_subpanel = panel:panel({
		name = "ties_subpanel",
		x = deployable_subpanel:right(),
		w = subpanel_w,
		h = subpanel_h,
		visible = false
	})
	local debug_subpanel2 = ties_subpanel:rect({
		name = "debug_subpanel2",
		color = Color.red,
		alpha = 0.1,
		visible = false
	})
	
	
	local ties_texture,ties_rect = tweak_data.hud_icons:get_icon_data("equipment_cable_ties")
	local ties_icon = ties_subpanel:bitmap({
		name = "ties_icon",
		layer = 0,
		rotation = 360,
		texture = ties_texture,
		texture_rect = ties_rect,
		color = self.color_data.hud_blueoutline,
		x = (ties_subpanel:w() - icon_size) / 2,
		w = icon_size,
		h = icon_size	
	})
	local ties_label = ties_subpanel:text({
		name = "ties_label",
		layer = 1,
		text = "3",
		vertical = "bottom",
		align = "center",
		color = Color.white,
		font_size = tweak_data.hud_players.name_size,
		font = ammo_font
	})
	
	local ties_divider = ties_subpanel:rect({
		name = "ties_divider",
		color = self.color_data.hud_blueoutline,
		w = divider_w,
		h = teammate_h,
		x = ties_subpanel:w() - divider_w
	})
	
	
	local grenade_subpanel = panel:panel({
		name = "grenade_subpanel",
		x = ties_subpanel:right(),
		w = subpanel_w,
		h = subpanel_h,
		visible = false
	})
	local debug_subpanel3 = grenade_subpanel:rect({
		name = "debug_subpanel3",
		color = Color.red,
		alpha = 0.1,
		visible = false
	})
	
	
	local grenade_texture,grenade_rect = tweak_data.hud_icons:get_icon_data("frag_grenade")
	local grenade_icon = grenade_subpanel:bitmap({
		name = "grenade_icon",
		layer = 0,
		rotation = 360,
		texture = grenade_texture,
		texture_rect = grenade_rect,
		color = self.color_data.hud_blueoutline,
		x = (grenade_subpanel:w() - icon_size) / 2,
		w = icon_size,
		h = icon_size	
	})
	local grenade_label = grenade_subpanel:text({
		name = "grenade_label",
		layer = 1,
		text = "3",
		align = "center",
		vertical = "bottom",
		color = Color.white,
		font_size = tweak_data.hud_players.name_size,
		font = ammo_font
	})
	local equipment_subpanel = panel:panel({
		name = "equipment_subpanel",
		x = grenade_subpanel:right(),
		y = character_bitmap:y(),
		w = teammate_w,
		layer = 1,
		h = panel:h(),
		visible = true
	})

--	local debug_subpanel4 = equipment_subpanel:rect({
--		name = "debug_subpanel4",
--		color = Color(1,1,0),
--		visible = false,
--		alpha = 0.2
--	})

	local teammate_panel_debug = panel:rect({
		name = "teammate_panel_debug",
		visible = false,
		color = tweak_data.chat_colors[i],
		alpha = 0.2
	})
	return panel
end

function NobleHUD:_add_teammate() --i don't think this is even called...???
	self:log("NobleHUD:_add_teammate(): Huh, I guess I am using this somewhere.",{color=Color.red})
end

function NobleHUD:_sort_teammates(num)
--todo get tracked max teammate count, hide inactive teammates
	num = num or 4
	local teammates_panel = self._teammates_panel
	if not teammates_panel then return end
	if self:ShouldAlignTeammatesToRadar() then 
		local radar_panel = self._radar_panel

		local diagonal = math.sqrt(math.pow(radar_panel:w(),2) + math.pow(radar_panel:h(),2))
		local radar_gap = (diagonal - radar_panel:h()) / 2
		teammates_panel:set_h(math.max(radar_panel:h(),self._TEAMMATE_ITEM_H * num))
		teammates_panel:set_x((radar_panel:right() - radar_gap) + self:GetTeammatesPanelX()) 
		teammates_panel:set_y((radar_panel:y() + ((radar_panel:h() - teammates_panel:h()) / 2)) + self:GetTeammatesPanelY())
--		teammates_panel:set_x(radar_panel:right() - 16)
--		teammates_panel:set_y(radar_panel:y())
		for i=1,num do 
			local ratio = (i - 1) / (num - 1)
			local panel = teammates_panel:child("teammate_" .. i)
			if not alive(panel) then 
				panel = self:_create_teammate_panel(teammates_panel,i)
			end
	--		panel:set_x(192 * (0.5 + math.cos((i/4) * math.pi * 2))) --todo get radar size
	--		panel:set_x(192 * math.sin(math.deg(((i-1) / (num_teammates - 1))) / (math.pi))) --todo get radar size
			panel:set_x(((radar_panel:w() / 8) * math.sin(180 * ratio)) + (self:GetRadarScale() * 32)) --todo get radar size
			if self._TEAMMATE_ITEM_H * (num + 1) > radar_panel:h() then
				panel:set_y(self._TEAMMATE_ITEM_H * (i - 1))
			else
				--radar scale is larger
				panel:set_y((teammates_panel:h() * (i / (num + 1))) - (self._TEAMMATE_ITEM_H / 2))
--				panel:set_y(radar_panel:h() * ((i / (num + 1)) + 0.5))
			end
--			panel:set_y((radar_panel:h() * ((i-1)/num)) - (self._TEAMMATE_ITEM_H / 2))
--			panel:set_y(((i-1)/num))
		end
	else
		teammates_panel:set_x(self:GetTeammatesPanelX())
		teammates_panel:set_y(self:GetTeammatesPanelY())
		for i=1,num do 
			local panel = teammates_panel:child("teammate_" .. i)
			if not alive(panel) then 
				panel = self:_create_teammate_panel(teammates_panel,i)
			end
			panel:set_position(0,self._TEAMMATE_ITEM_H * (i - 1))
--			panel:set_position(0,64 * i)
		end
	end
end

function NobleHUD:_set_teammate_callsign(i,id)	
	self:log("_set_teammate_callsign() is deprecated! Please use _set_teammate_color() or _set_teammate_name!",{color=Color.red})
end

function NobleHUD:_set_teammate_color(i,id)	
	local panel = self._teammates_panel:child("teammate_" .. tostring(i))
	if (panel and alive(panel)) then
		local color = tweak_data.chat_colors[id or 5]
		local color_2 = (color * 0.8):with_alpha(1)
		local callsign_box = panel:child("callsign_box")
		local bitmap_bg = callsign_box:child("character_bitmap_bg")
		local bitmap = callsign_box:child("character_bitmap")
		bitmap:set_image("guis/textures/teammate_nameplate")
		local c_ratio = callsign_box:w() / self._NAMEPLATE_W
		bitmap:set_size(self._NAMEPLATE_W * c_ratio,self._NAMEPLATE_H * c_ratio)
		bitmap_bg:set_size(self._NAMEPLATE_W * c_ratio,self._NAMEPLATE_H * c_ratio)
		local bitmap_x = (callsign_box:w() - bitmap:w()) / 2
		local bitmap_y = (panel:h() - bitmap:h()) / 2		
		bitmap:set_x(bitmap_x)
		bitmap:set_y(bitmap_y)
		bitmap_bg:set_x(bitmap_x)
		bitmap_bg:set_y(bitmap_y)
		if color then 
			bitmap_bg:show()
			bitmap_bg:set_color(color)
--			callsign_box:child("player_name"):set_color(color)
--			bitmap:set_color(color) --optional
		end
		
		local player_box = NobleHUD._tabscreen:child("scoreboard"):child("player_box_" .. tostring(i))
		if alive(player_box) then 
			player_box:child("icon_box"):child("icon_bg"):set_color(color)
			player_box:child("callsign_box"):child("callsign_bg"):set_color(color)
			player_box:child("name_box"):child("name_bg"):set_color(color_2)
			player_box:child("ping_box"):child("ping_bg"):set_color(color_2)
		end
		
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
	if not self._cache.callsigns[i] then  --todo get by steamid64
		self:_set_tabscreen_teammate_callsign(i,player_name)
	end
end

function NobleHUD:_set_teammate_waypoint_name(peer_id,name)
	if managers.hud then 
		local name_labels = managers.hud._hud.name_labels
		for _,name_label in pairs(name_labels or {}) do 
			if peer_id and peer_id == name_label.peer_id then 
				local panel = name_label.panel
				if alive(panel) then 
					panel:child("text"):set_text(name)
				end
				return
			end			
		end
		--[[
		local label = peer_id and name_labels and name_labels[peer_id]
		if label then 
			local panel = label.panel
			if alive(panel) then 
				
			end
		end
		--]]
	end
--[[

	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
	local panel = hud and alive(hud.panel) and hud.panel:child("name_label" .. tostring(panel_id))
	if alive(panel) then 
		panel:child("text"):set_text(name)
	end
	--]]
end

function NobleHUD:_init_teammate(i,original_panel,is_player,width)
	if not self._teammates_panel then return end
	local panel = self._teammates_panel:child("teammate_" .. tostring(i))
	if (panel and alive(panel)) then 
		--self:log("Tried to _init_teammate")
	else
		self:log("ERROR: _init_teammate panel( " .. NobleHUD.table_concat({i,panel,is_player,width},",") .. " ): Panel does not exist")
		return
	end
end

function NobleHUD:_remove_teammate_equipment(i,equipment_name)
	local player_panel = self:GetTeammatePanel(i)
	if alive(player_panel) then 
		local equipment_subpanel = player_panel:child("equipment_subpanel")
		for _,equipment_box in pairs(equipment_subpanel:children()) do 
			if equipment_box:name() == equipment_name then 
				local function remove_box(o)
					o:parent():remove(o)
				end
				self:animate(equipment_box,"animate_fadeout",remove_box,0.25,equipment_box:alpha(),nil,-equipment_box:h())
				break
			end
		end
	end	
	
end

function NobleHUD:_clear_teammate_equipments(i)
	local player_panel = self:GetTeammatePanel(i)
	if alive(player_panel) then 
		local equipment_subpanel = player_panel:child("equipment_subpanel")
		for _,equipment_box in pairs(equipment_subpanel:children()) do 
			if alive(equipment_box) then 
				equipment_subpanel:remove(equipment_box)
			end
		end
	end
end

function NobleHUD:_set_teammate_equipment_amount(i,equipment_name,amount)
	local player_panel = self:GetTeammatePanel(i)
	if equipment_name and alive(player_panel) then 
		local equipment_subpanel = player_panel:child("equipment_subpanel")
		local equipment_box = equipment_subpanel:child(tostring(equipment_name))
		if alive(equipment_box) then 
			if amount == 1 then 
				amount = ""
			end
			equipment_box:child("amount"):set_text(amount)
		else
			self:log("ERROR: _set_teammate_equipment_amount(" .. NobleHUD.table_concat({i,equipment_name,amount},",") .. ")",{color=Color.red})
		end
	end
end

function NobleHUD:_add_teammate_equipment(i,data)
	local equipment_name = data.id and tostring(data.id)
	local equipment_icon,equipment_rect = tweak_data.hud_icons:get_icon_data(data.icon)
	local amount = data.amount
	local player_panel = self:GetTeammatePanel(i)
	if equipment_name and alive(player_panel) then 
		local equipment_subpanel = player_panel:child("equipment_subpanel")
		if alive(equipment_subpanel:child(equipment_name)) then 
			self:_set_teammate_equipment_amount(i,equipment_name,amount)
		else
			local eq_size = 24
			local new_equipment = equipment_subpanel:panel({
				name = equipment_name,
				w = eq_size,
				h = eq_size,
				alpha = 0 --due to animate
			})
			local icon = new_equipment:bitmap({
				name = "icon",
				texture = equipment_icon,
				texture_rect = equipment_rect,
				color = self.color_data.hud_blueoutline,
				w = eq_size,
				h = eq_size,
				layer = 2
			})
			icon:set_center(new_equipment:center())
		--[[
			new_equipment:bitmap({
				name = "amount_bg",
				texture = "guis/textures/pd2/equip_count",
				layer = 3,
				color = Color.white
			})
		--]]
			local rotation = 360
			if (amount == "infinite") or (amount == math.huge) then
				--this isn't actually a case that exists, i just wanted to try making it
				rotation = 90
				amount = "8" --hello yes this is the stanley parable demo
			elseif (amount == 1) or not amount then 
				amount = ""
			else
				amount = tostring(amount)
			end
			local label = new_equipment:text({
				name = "amount",
				layer = 4,
				font = "fonts/font_small_noshadow_mf",
				font_size = eq_size / 2,
				text = amount,
				x = eq_size / 4,
				color = self.color_data.hud_bluefill,
				rotation = rotation,
				align = "center",
				vertical = "bottom"
			})
			local function pulse(o)
				local center_x,center_y = o:center()
				self:animate(icon,"animate_killfeed_icon_pulse",animate_done,0.3,eq_size,1.5,center_x,center_y)
			end
			self:animate(new_equipment,"animate_fadein",pulse,0.5,1)
		end
	end
end

function NobleHUD:_layout_teammate_equipments(i)
	local player_panel = self:GetTeammatePanel(i)
	if alive(player_panel) then 
		local equipment_subpanel = player_panel:child("equipment_subpanel")
		local eq_w = 24
		for count,equipment_box in ipairs(equipment_subpanel:children()) do
			equipment_box:set_x((count - 1) * eq_w)
		end
	end
end

function NobleHUD:GetPeerIdFromPanelId(panel_id)
	if managers.criminals then
		for id, data in pairs(managers.criminals._characters or {}) do 
--			self:log("GetPeerIdFromPanelId() " .. tostring(data.taken) .. " " .. tostring(panel_id) .. " " .. tostring(data.data.panel_id))
			if data.taken and panel_id and data.data and (data.data.panel_id == panel_id) then 
				return data.peer_id
			end
		end
	end
end

function NobleHUD:GetPanelIdFromPeerId(peer_id)
	if not peer_id or peer_id == managers.network:session():local_peer():id() then
		return HUDManager.PLAYER_PANEL
	end
	if managers.criminals then
		for id, data in pairs(managers.criminals._characters or {}) do 
			if data.taken and (data.peer_id == peer_id) then 
			--todo if ai get panel anyway somehow
				return data.data and data.data.panel_id
			end
		end
	end
end


--		SCORE COUNTER

function NobleHUD:_create_score(hud)
	self._popups_panel = hud:panel({
		name = "popups_panel"
	})
	local margin_l = 24
	local margin_m = 8
	local margin_s = 4
	local panel_h = 128
	local panel_w = 300
	local score_panel = hud:panel({
		name = "score_panel",
		w = panel_w,
		h = panel_h,
		x = hud:w() - (panel_w + margin_l),
		y = hud:h() - (panel_h + margin_l + margin_m),
		alpha = self:GetHUDAlpha()
	})
	self._score_panel = score_panel

	local score_debug = score_panel:rect({
		name = "score_debug",
		visible = false,
		color = Color.yellow,
		alpha = 0.1
	})
	
	local banner_l_w = 256
	local banner_l_h = 24
	local font_size = 20
	local banner_l_x = panel_w - banner_l_w
	local score_banner_large = score_panel:bitmap({
		name = "score_banner_large",
		texture = "guis/textures/score_banner_large",
		layer = 1,
		color = self.color_data.hud_vitalsfill_blue,--tweak_data.chat_colors[2], --managers.network:session():local_peer():id()], --should be refreshed on load for accuracy
		x = banner_l_x, --right
		y = panel_h - banner_l_h, --bottom
		w = banner_l_w,
		h = banner_l_h,
		alpha = 1
	})
	
	local banner_s_size = 24
	local banner_s_x = banner_l_x - (banner_s_size + margin_s)
	local banner_s_y = panel_h - banner_s_size -- bottom

	local score_banner_small = score_panel:bitmap({
		name = "score_banner_small",
		texture = "guis/textures/test_blur_df",
		layer = 1,
		color = tweak_data.chat_colors[managers.network:session():local_peer():id() or 1],--Color(0.6,0.6,0.6), --light grey
		x = banner_s_x,
		y = banner_s_y,
		w = banner_s_size,
		h = banner_s_size,
		alpha = 1
	})
	
	local subpanel_w = 24
	local subpanel_h = subpanel_w + font_size + margin_s
	local subpanel_y = score_banner_small:y() - (subpanel_h + margin_s)
	
	local divider_w = 2
	
	local text_row_y_2 = panel_h - ((2 * font_size) + margin_s)

	local score_arrow_texture,score_arrow_rect = tweak_data.hud_icons:get_icon_data("icon_equipped")
	local score_icon = score_panel:bitmap({
		name = "score_banner_large",
		texture = score_arrow_texture,
		texture_rect = score_arrow_rect,
		layer = 3,
		color = Color.white,
		x = banner_l_x - (banner_s_size + margin_s),
		y = panel_h - banner_s_size,
		w = banner_s_size,
		h = banner_s_size,
		alpha = 0.5
	})
	score_icon:set_center(score_banner_small:x() + (banner_s_size / 2),score_banner_small:y() + (banner_s_size / 2))
	
	local score_label = score_panel:text({
		name = "score_label",
		text = "0",
		align = "left",
		color = Color.white,
		x = score_banner_large:x() + margin_s,
		y = score_banner_large:y() + margin_s,
		font = self.fonts.eurostile_ext,
		font_size = font_size,
		layer = 5
	})
	
	
	
	-- subpanels
	
	local revives_panel = score_panel:panel({
		name = "revives_panel",
		w = subpanel_w,
		h = subpanel_h,
		x = score_banner_large:x() - (banner_s_size + margin_s),
		y = subpanel_y
	})
	self._revives_panel = revives_panel
	local revives_debug = revives_panel:rect({
		name = "revives_debug",
		alpha = 0.5,
		visible = false,
		color = Color(1,0,1)
	})
	local revives_label = revives_panel:text({
		name = "revives_label",
		text = "3",
		align = "center",
		vertical = "bottom",
		y = margin_s,
		color = self.color_data.hud_vitalsoutline_blue,
		font = self.fonts.eurostile_ext,
		font_size = font_size,
		layer = 4
	})
--		texture = "guis/textures/pd2/skilltree/icons_atlas",
--		texture_rect = { --bandaid icon
--			5 * 64, --or 4,9 for inspire 
--			7 * 64,
--			64,
--			64
--		},

--	local revives_texture,revives_rect = tweak_data.hud_icons:get_icon_data("csb_lives")
	local revives_icon = revives_panel:bitmap({
		name = "revives_icon",
		texture = "guis/textures/lives_icon",-- revives_texture,
--		texture_rect = revives_rect,
		color = self.color_data.hud_vitalsoutline_blue,
		w = subpanel_w,
		h = subpanel_w,
		x = 0,
		y = 0
	})
	
	local divider_revives = score_panel:rect({
		name = "divider_revives",
		w = divider_w,
		h = subpanel_h,
		x = revives_panel:right(),
		y = subpanel_y,
		color = self.color_data.hud_vitalsoutline_blue
	})
	
	local ties_panel = score_panel:panel({
		name = "ties_panel",
		w = subpanel_w,
		h = subpanel_h,
		x = divider_revives:right(),
		y = subpanel_y
	})
	self._ties_panel = ties_panel
	local ties_texture,ties_rect = tweak_data.hud_icons:get_icon_data("equipment_cable_ties")
	local ties_icon = ties_panel:bitmap({
		name = "ties_icon",
		texture = ties_texture,
		texture_rect = ties_rect,
		color = self.color_data.hud_vitalsoutline_blue,
		w = subpanel_w,
		h = subpanel_w,
		x = 0,
		y = 0
	})
	local ties_label = ties_panel:text({
		name = "ties_label",
		text = "2",
		align = "center",
		vertical = "bottom",
		y = margin_s,
		color = self.color_data.hud_vitalsoutline_blue,
		font = self.fonts.eurostile_ext,
		font_size = font_size,
		layer = 4
	})
	
	local divider_ties = score_panel:rect({
		name = "divider_ties",
		w = divider_w,
		h = subpanel_h,
		x = ties_panel:right(),
		y = subpanel_y,
		color = self.color_data.hud_vitalsoutline_blue
	})
	
		
	local hostages_panel = score_panel:panel({
		name = "hostages_panel",
		w = subpanel_w,
		h = subpanel_h,
		x = ties_panel:x() + subpanel_w,
		y = subpanel_y
	})
	self._hostages_panel = hostages_panel
	
	local hostages_texture,hostages_rect = tweak_data.hud_icons:get_icon_data("wp_hostage")
	local hostages_icon = hostages_panel:bitmap({
		name = "hostages_icon",
		texture = "guis/textures/pd2/hud_icon_hostage",
		color = self.color_data.hud_vitalsoutline_blue,
		w = subpanel_w,
		h = subpanel_w,
		x = 0,
		y = 0
	})
	
	local hostages_label = hostages_panel:text({
		name = "hostages_label",
		text = "0",
		align = "center",
		vertical = "bottom",
		y = margin_s,
		color = self.color_data.hud_vitalsoutline_blue,
		font = self.fonts.eurostile_ext,
		font_size = font_size,
		layer = 4
	})
	
	local divider_hostages = score_panel:rect({
		name = "divider_hostages",
		w = divider_w,
		h = subpanel_h,
		x = hostages_panel:right(),
		y = subpanel_y,
		color = self.color_data.hud_vitalsoutline_blue
	})
	
	
	local score_multiplier_label = score_panel:text({
		name = "score_multiplier_label",
		text = "2.00x",
		align = "left",
		x = margin_m + hostages_panel:right(),
		y = text_row_y_2,
		color = self.color_data.hud_vitalsoutline_blue,
		font = self.fonts.eurostile_ext, --"fonts/font_eurostile_ext",
		font_size = font_size,
		layer = 4
	})
		
	local assault_phase_label = score_panel:text({
		name = "assault_phase_label",
		text = managers.localization:text("noblehud_hud_assault_phase_standby"),
		align = "left",
		x = margin_m + hostages_panel:right(),
		y = subpanel_y,
		color = self.color_data.hud_vitalsoutline_blue,
		font = self.fonts.eurostile_ext,
		font_size = font_size,
		layer = 4
	})
	
	local mission_timer = score_panel:text({
		name = "mission_timer",
		text = "04:20",
		align = "right",
		layer = 3,
		x = -margin_m,
		y = text_row_y_2, --  -(font_size + margin_s),
		color = self.color_data.hud_vitalsoutline_blue,
		font = self.fonts.eurostile_ext,
		font_size = font_size,
		alpha = 1
	})
	
	local wave_label = score_panel:text({
		name = "wave_label",
		text = "",
		align = "left",
		x = margin_m + hostages_panel:right(),
		y = subpanel_y + font_size - margin_s,
		color = self.color_data.hud_vitalsoutline_blue,
		font = self.fonts.eurostile_ext,
		font_size = font_size,
		visible = managers.hud._hud_assault_corner:should_display_waves()
	})
	
	local ponr_timer = score_panel:text({
		name = "ponr_label",
		text = utf8.to_upper(managers.localization:text("hud_assault_point_no_return_in")),
		align = "center",
		vertical = "top",
		layer = 2,
		color = Color.red,
		font_size = 16,
		font = tweak_data.hud.medium_font_noshadow,
		visible = false
	})
	local ponr_timer = score_panel:text({
		name = "ponr_timer",
		text = "04:20",
		align = "center",
		vertical = "top",
		y = ponr_timer:line_height(),
		layer = 2,
		color = Color.red,
		font_size = 36,
		font = tweak_data.hud.medium_font_noshadow,
		visible = false
	})
	
end

function NobleHUD:ShowPONR(state)
	if state ~= nil then 
		self._score_panel:child("ponr_timer"):set_visible(state)
		self._score_panel:child("ponr_label"):set_visible(state)
	else
		self._score_panel:child("ponr_timer"):show()
		self._score_panel:child("ponr_label"):show()
	end
end

function NobleHUD:SetPONR(t)
	local danger_threshold = 10
	t = math.floor(t)
	local minutes = math.floor(t / 60)
	local seconds = math.round(t - minutes * 60)
	local text = (minutes < 10 and "0" .. minutes or minutes) .. ":" .. (seconds < 10 and "0" .. seconds or seconds)
	self._score_panel:child("ponr_timer"):set_text(text)
	self:AnimatePONRFlash(t <= danger_threshold)
end

function NobleHUD:AnimatePONRFlash(beep)
	local ponr_text = self._score_panel:child("ponr_timer")
	self:animate_stop(ponr_text)
	ponr_text:set_font_size(24)
	ponr_text:set_color(Color.red)
	if beep then 
		self:animate(ponr_text,"animate_killfeed_text_in",nil,0.5,24,self.color_data.hud_hint_orange,self.color_data.hud_hint_lightorange)
	else
		self:animate(ponr_text,"animate_killfeed_text_in",nil,0.5,24,Color.red,Color.white)
	end
end

function NobleHUD:HidePONR()
	self._score_panel:child("ponr_timer"):show()
	self._score_panel:child("ponr_label"):show()
end

function NobleHUD:ShowWaveNumber(state) --unused
	if state ~= nil then 
		self._score_panel:child("wave_label"):set_visible(state)
	else
		self._score_panel:child("wave_label"):show()
	end
end

function NobleHUD:SetWaveNumber(current,total)
	local text = managers.localization:text("noblehud_hud_assault_wave_label")
	if current then 
		if total and total < math.huge and total ~= 0 then
			text = text .. " " .. tostring(current) .. "/" .. tostring(total)
		else
			text = text .. " " .. tostring(current) 
		end
		self._score_panel:child("wave_label"):set_text(text)
	else
		self:log("Bad current wave num to SetWaveNumber(" .. tostring(current) .. "," .. tostring(total) .. ")",{color=Color.red})
	end
end

function NobleHUD:SetHostages(text)
	if text then
		local label = self._hostages_panel:child("hostages_label")
		label:set_text(text)
		local length = string.len(text)
		if length > 2 then 
			label:set_font_size(12)
		elseif length > 1 then 
			label:set_font_size(16)
		else 
			label:set_font_size(20)
		end
	end
end

function NobleHUD:SetCableTies(text)
	if text then
		self._ties_panel:child("ties_label"):set_text(text)
	end
end

function NobleHUD:SetAssaultPhase(text,send_to_peers)
	local assault_phase_label = self._score_panel:child("assault_phase_label")
	if text ~= assault_phase_label:text() then 
		assault_phase_label:set_text(text)
		self:animate(assault_phase_label,"animate_killfeed_text_in",nil,0.3,20,self.color_data.hud_vitalsoutline_blue,self.color_data.hud_text_flash)
		if send_to_peers then
			LuaNetworking:SendToPeers(self.network_messages.sync_assault,text)
		end
	end
end

function NobleHUD:SetRevives(text)
	if text then
		self._revives_panel:child("revives_label"):set_text(tostring(text))
	end
end

function NobleHUD:TallyScore(name,unit,medal_multiplier,is_friendly_fire)
	name = tostring(name)
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
		if is_friendly_fire then 
			score = -math.abs(score)
		end
		if self:IsScorePopupsEnabled() then 
			self:CreateScorePopup(localized_unitname,score,unit)
		end
		self:AddScore(score)
		if self:GetScoreDisplayMode() == 1 then
			self:SetScoreLabel(NobleHUD.make_nice_number(self._cache.score_session))
		end
	else
		--unit is worth no score, or unit name is wrong
	end
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
	if score <= 0 then 
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
	--[[
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
	--]]
	
--	self:animate(popup,animate_style,nil)
	
end

function NobleHUD:ScorePopupShowsUnitName()
	return true
end

function NobleHUD:SetTrackedEnemyDamage(key,amount,additive)
	if self._cache.enemy_damage[key] and additive and amount then
		self._cache.enemy_damage[key] = self._cache.enemy_damage[key] + amount
	else 
		self._cache.enemy_damage[key] = amount
	end
	return self._cache.enemy_damage[key]
end

function NobleHUD:RemoveTrackedEnemyDamage(key)
	if self._cache.enemy_damage[key] then 
		self._cache.enemy_damage[key] = nil
	end
end

function NobleHUD:CreateDamagePopup(damage_info)
	if not (damage_info and self:IsDamagePopupsEnabled()) then
		return
	end
	
	local popup_style = self:GetDamagePopupsStyle()
	local animate_movement = true
	local cumulative = self:IsDamagePopupsCumulative()
	local should_repeat = self:IsDamagePopupsRepeat()
	local fadeout_duration = self:GetDamagePopupsFadeoutTime()
	local lifetime = self:GetDamagePopupsLifetime()
	
	local attacker_unit = damage_info and damage_info.attacker_unit

	if alive(attacker_unit) and attacker_unit:base() and attacker_unit:base().thrower_unit then
		attacker_unit = attacker_unit:base():thrower_unit()
	end
	if attacker_unit == managers.player:local_player() then 
		
		damage_info = damage_info or {}
		NobleHUD._patootie = damage_info
		local col_ray = damage_info.col_ray or {}
		local result = damage_info.result or {}
		local unit = col_ray.unit
		local key = unit and unit:key() and tostring(unit:key())
		local damage = damage_info.damage
		local name = damage_info.name
		local body = col_ray.body
		local distance = col_ray.distance
		local hit_position = col_ray.hit_position or damage_info.pos
		local headshot = damage_info.headshot
		local variant = damage_info.variant
		local killshot = result.type == "death"
		
		local screen_pos = {x = -1000,y = -1000}
		if not animate_movement then 
			screen_pos = NobleHUD._ws:world_to_screen(managers.viewport:get_current_camera(),(body and body:position()) or hit_position or (unit and unit:position()))
		end
		local color = Color.white --flash color
		local new_color = Color.white --end color
		local layer = 1
		local font_size = 24
		local from_fire = damage_info.is_fire_dot_damage or damage_info.fire_dot_data or (variant == "fire")
		
		
		--dot damage is when unit is on fire
		--fire_dot_data is when unit is in fire
		
		--different colors for different variants
		--color flashing
		--font size change animate
		--movement (borderlands type parabolic arc, or simple drift)
		
		if killshot then 
			color = self.color_data.hud_vitalsfill_red
			new_color = self.color_data.collector
			layer = 3
			font_size = 32
		elseif headshot then 
			color = self.color_data.unique
			new_color = Color.white
			layer = 2
			font_size = 28
		elseif from_fire then
			color = self.color_data.unique
			new_color = self.color_data.strange
			font_size = 28
			damage = damage or (damage_info.fire_dot_data and damage_info.fire_dot_data.dot_damage) or 1
		end
		
		local popup_name = (key or hit_position) and tostring(key or hit_position)
		--may not appear for things like countertase
		
		local damage_string = damage
		if cumulative and key then 
			damage_string = self:SetTrackedEnemyDamage(key,damage,true)
			
			--[[
				self._cache.enemy_damage[key] = self._cache.enemy_damage[key] + damage
				damage_string = (self._cache.enemy_damage[key] or damage_string)
			else
				self._cache.enemy_damage[key] = damage
			end
			self:AddDelayedCallback(callback(NobleHUD,NobleHUD,"SetTrackedEnemyDamage",key,nil,false),nil,self:GetDamagePopupsCumulativeRefreshTime(),"clear_enemy_damage_" .. key)
			self:AddDelayedCallback(callback(NobleHUD,NobleHUD,"RemoveTrackedEnemyDamage",key),nil,lifetime + fadeout_time)
			--]]
			self:AddDelayedCallback(callback(NobleHUD,NobleHUD,"RemoveTrackedEnemyDamage",key),nil,self:GetDamagePopupsCumulativeRefreshTime(),"clear_enemy_damage_" .. key)
		end
			
		local damage_popup = popup_name and NobleHUD._popups_panel:child(popup_name)
		if damage_popup and not should_repeat then 
			self:animate_stop(damage_popup)
			damage_popup:set_text(string.format("%d",damage_string))
			damage_popup:set_font_size(font_size)
			damage_popup:set_layer(layer)
			damage_popup:set_position(screen_pos.x,screen_pos.y)
			damage_popup:set_color(color)
			damage_popup:set_alpha(1)
		else
			damage_popup = NobleHUD._popups_panel:text({
				name = popup_name or ("damage_popup_" .. tostring(damage_info)),
				text = string.format("%d",damage_string),
				font = "fonts/font_medium_shadow_mf", --"fonts/font_large_mf" --fonts/font_futura --fonts/font_small_shadow_mf
				font_size = font_size,
				layer = layer,
				x = screen_pos.x,
				y = screen_pos.y,
				color = color,
				alpha = 1,
				visible = true
			})
		end
		
		local attached_unit = body or unit
		
		if popup_style == 1 then 
			NobleHUD:animate(damage_popup,"animate_popup_damage_body",function(o) o:parent():remove(o) end,lifetime,fadeout_duration,attached_unit,hit_position,new_color) --unit body part
		elseif popup_style == 2 then 
			NobleHUD:animate(damage_popup,"animate_popup_damage_body",function(o) o:parent():remove(o) end,lifetime,fadeout_duration,nil,hit_position,new_color) --hit position
		else
			NobleHUD:animate(damage_popup,"animate_popup_damage_vault",function(o) o:parent():remove(o) end,lifetime,fadeout_duration,nil,hit_position,font_size,new_color,math.random(360),math.clamp((damage - 60) / 20,0.5,3) + math.random(),20) --vault
		end
	end
end

function NobleHUD:_set_mission_timer(text) --hud only
	self._score_panel:child("mission_timer"):set_text(tostring(text))
end

function NobleHUD:set_mission_name(level_name)
	self:_set_mission_name(level_name)
	
	local player_box = self._tabscreen:child("scoreboard")
	local difficulty_index = managers.job:current_difficulty_stars()
	player_box:child("title_box"):child("title_label"):set_text(level_name .. " /// " .. string.rep(self.special_chars.skull .. " ",difficulty_index))
--	player_box:child("title_box"):child("title_label_2"):set_text(utf8.to_upper(Global.game_settings.difficulty))
end

function NobleHUD:set_mission_day(text)
	local player_box = self._tabscreen:child("scoreboard")	
	player_box:child("title_box"):child("title_label_2"):set_text(text)
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

function NobleHUD:animate_popup_bluespider(o,t,dt,start_t,duration,unit,fadeout_duration) 
	if alive(unit) then 
		if t - start_t > duration then 
			if t - start_t > duration + fadeout_duration then
				return true
			end
			local a_ratio = ((t - start_t) - duration) / fadeout_duration
			o:set_alpha(1 - a_ratio)
		else
			o:set_alpha(o:alpha() + (dt * duration * 2))
		end
		
		local viewport_cam = managers.viewport:get_current_camera()
		local head_pos = unit:movement() and unit:movement():m_head_pos()
		
		local unit_screen_pos = head_pos and NobleHUD._ws:world_to_screen(viewport_cam,head_pos)
		if unit_screen_pos then 
		
			local aim = viewport_cam:rotation():yaw()
			local my_pos = viewport_cam:position()	
			local angle_from = (180 + aim - NobleHUD.angle_from(head_pos.x,head_pos.y,my_pos.x,my_pos.y)) % 360
			
			if (math.abs(90 - angle_from) > 90) or o:parent():outside(unit_screen_pos.x,unit_screen_pos.y) then 
				o:set_x(-1000)
				o:set_y(-1000)			
			else
				o:set_x(unit_screen_pos.x)
				o:set_y(unit_screen_pos.y)
			end
		end
	else
		return true
	end
end
function NobleHUD:animate_popup_athena(o,t,dt,start_t,duration,unit,distance,fadeout_duration)
	if alive(unit) then 
		if t - start_t > duration then 
			if t - start_t > duration + fadeout_duration then 		
				return true
			end
			local a_ratio = ((t - start_t) - duration) / fadeout_duration
			o:set_alpha(1 - a_ratio)
		else
			o:set_alpha(o:alpha() + (dt * duration * 2))	
		end
		local viewport_cam = managers.viewport:get_current_camera()
		local head_pos = unit:movement() and unit:movement():m_head_pos()
		local unit_screen_pos = head_pos and NobleHUD._ws:world_to_screen(viewport_cam,head_pos)
		if unit_screen_pos then
	
			local aim = viewport_cam:rotation():yaw()
			local my_pos = viewport_cam:position()	
			local angle_from = (180 + aim - NobleHUD.angle_from(head_pos.x,head_pos.y,my_pos.x,my_pos.y)) % 360
			
			if (math.abs(90 - angle_from) > 90) or o:parent():outside(unit_screen_pos.x,unit_screen_pos.y) then 
				o:set_x(-1000)
				o:set_y(-1000)
			else
				o:set_x(unit_screen_pos.x)
				o:set_y(unit_screen_pos.y + (distance * (t - start_t)))
			end
			
		end
	else
		return true
	end
	
	
--	o:set_y(o:y() + (rate * dt)) --distance is per second
end
function NobleHUD:animate_popup_queue(o,t,dt,start_t,duration,dest_y,rate)
	local oy = o:y()
	o:set_alpha(o:alpha() + (dt * rate)) --will always become fully visible in 1/rate seconds
	if t - start_t > duration then 
		return math.sign(dest_y - oy)
	end
	o:set_y(oy + (10 * dt * (dest_y - oy) / rate))
end

function NobleHUD:animate_popup_damage_body(o,t,dt,start_t,duration,fadeout_duration,unit,position,new_color) 
	if alive(unit) then 
		position = unit:position()
	end
	if position then 
		if t - start_t > duration then 
			if t - start_t > duration + fadeout_duration then 		
				return true
			end
			local a_ratio = ((t - start_t) - duration) / fadeout_duration
			o:set_alpha(1 - a_ratio)
		else
			o:set_alpha(o:alpha() + (dt * duration * 2))	
		end
		if new_color then 
			o:set_color(NobleHUD.interp_colors(o:color(),new_color,dt / duration))
		end
		local viewport_cam = managers.viewport:get_current_camera()
		local screen_pos = position and NobleHUD._ws:world_to_screen(viewport_cam,position)
		if screen_pos then
	
			local aim = viewport_cam:rotation():yaw()
			local my_pos = viewport_cam:position()	
			local angle_from = (180 + aim - NobleHUD.angle_from(position.x,position.y,my_pos.x,my_pos.y)) % 360
			
			if (math.abs(90 - angle_from) > 90) or o:parent():outside(screen_pos.x,screen_pos.y) then 
				o:set_x(-1000)
				o:set_y(-1000)
			else
				o:set_x(screen_pos.x)
				o:set_y(screen_pos.y)
			end
			
		end
	else
		return true
	end
end

function NobleHUD:animate_popup_damage_vault(o,t,dt,start_t,duration,fadeout_duration,unit,position,font_size,new_color,direction,hor_velocity,ver_velocity)
	if alive(unit) then
		position = unit:position()
	end
	if position then
		local t_adjusted = 100 * (t - start_t)
		local t_offset = 2 * (math.sin(t_adjusted) + 0.5)
		if t - start_t > duration then 
			if t - start_t > duration + fadeout_duration then 
				return true
			end
			local a_ratio = ((t - start_t) - duration) / fadeout_duration
			o:set_alpha(1 - a_ratio)
		else
			o:set_alpha(o:alpha() + (dt * duration * 2))
		end
		
		local x_v = math.sin(direction) * hor_velocity * t_adjusted
		local y_v = math.cos(direction) * hor_velocity * t_adjusted
		
		local z_v = ((-1 / ver_velocity) * math.pow(t_adjusted,2)) + (t_offset * t_adjusted)


		position = position + Vector3(x_v,y_v,z_v)
		
		--[[
		local distance = mvector3.distance(viewport_cam:position(),position) 
		if distance > 0 then
			distance = math.clamp(1 / distance,font_size,font_size)
			o:set_font_size()
		else		
			o:set_font_size(font_size)
		end
		--]]
		
		if new_color then 
			o:set_color(NobleHUD.interp_colors(o:color(),new_color,dt / duration))
		end
		
		local viewport_cam = managers.viewport:get_current_camera()
		local screen_pos = position and NobleHUD._ws:world_to_screen(viewport_cam,position)
		if screen_pos then 
			local aim = viewport_cam:rotation():yaw()
			local my_pos = viewport_cam:position()
			local angle_from = (180 + aim - NobleHUD.angle_from(position.x,position.y,my_pos.x,my_pos.y)) % 360
			
			if (math.abs(90 - angle_from) > 90) or o:parent():outside(screen_pos.x,screen_pos.y) then 
				o:set_x(-1000)
				o:set_y(-1000)
			else
				o:set_x(screen_pos.x)
				o:set_y(screen_pos.y)
			end
		end
	else
		return true
	end
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
	self:log("ERROR: _tally_score(" .. NobleHUD.table_concat(data,",") .. ")")
end

function NobleHUD:_add_score(score)
	self.score_session = self.score_session + (tonumber(score or 0) or 0)
end

function NobleHUD:set_score_label()
--	if not JoyScoreCounter then 
		self._score_panel:child("score_label"):set_text(NobleHUD.make_nice_number(self.score_session))
--	end
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
		y = 128,
		alpha = self:GetHUDAlpha()
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
		color = self.color_data.hud_text,
		font_size = tweak_data.hud.active_objective_title_font_size,
		font = tweak_data.hud.medium_font_noshadow
	})
	local objectives_title = objectives_panel:text({ 
		name = "objectives_title",
		text = "CURRENT OBJECTIVE:",
		align = "center",
		layer = 2,
		color = self.color_data.hud_objective_title_text,
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
		color = self.color_data.hud_objective_shadow_text,
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
		color = self.color_data.hud_text,
		alpha = 0
	})
	local objectives_label = objectives_panel:text({
		name = "objectives_label",
		text = "SURVIVE",
		align = "center",
		vertical = "bottom",
		layer = 2,
		color = self.color_data.hud_objective_label_text,
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
		color = self.color_data.hud_objective_shadow_text,
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
		color = self.color_data.hud_text,
		alpha = 0
	})
	
	self._objectives_panel = objectives_panel
end

function NobleHUD:AnimateShowObjective(data) --not an animate() function, but calls animate() 

	if not self._queued_objectives[1] then
		self:log("NobleHUD:AnimateShowObjective() ERROR: Tried to animate nonexistent objective queue",{color=Color.red})
		return
	end
	self._queued_objectives[1].is_animating = true
	local objectives_panel = NobleHUD._objectives_panel
	local objectives_label = objectives_panel:child("objectives_label")
	local objectives_label_shadow = objectives_panel:child("objectives_label_shadow")
	local objectives_title = objectives_panel:child("objectives_title")
	local objectives_title_shadow = objectives_panel:child("objectives_title_shadow")
	local _,_,label_w,label_h = objectives_label:text_rect()
	
	local _,_,title_w,title_h = objectives_title:text_rect()

	local blink_label = NobleHUD._objectives_panel:child("blink_label")
	local blink_title = NobleHUD._objectives_panel:child("blink_title")

	local kern = -2
	local title_font_size = tweak_data.hud.active_objective_title_font_size
	local label_font_size = title_font_size * 1.15
	local in_duration = 0.2
	local mid_x = objectives_panel:w() / 2
	local blinkout_time = 0.25
	local blinkout_alpha = 0.9
	local blinkout_stretch_w_mul = 1.25
	local display_hold_time = 3
	
--prep
	blink_label:set_size(label_w,label_h)
--	blink_label:set_alpha(1)
	blink_title:set_size(title_w,title_h)
	blink_title:set_alpha(1)
	objectives_title:set_font_size(0)
	objectives_title:set_kern(kern)
	objectives_title:set_alpha(1)
	objectives_title_shadow:set_font_size(0)
	objectives_title_shadow:set_kern(kern)
	objectives_title_shadow:set_alpha(1)
	objectives_label:set_font_size(0)
	objectives_label:set_kern(kern)
	objectives_label:set_alpha(1)
	objectives_label:set_color(data.color or self.color_data.hud_objective_label_text)
	objectives_label_shadow:set_font_size(0)
	objectives_label_shadow:set_kern(kern)
	objectives_label_shadow:set_alpha(1)
	self:animate_stop(blink_label)
	self:animate_stop(blink_title)
	self:animate_stop(objectives_title)
	self:animate_stop(objectives_title_shadow)
	self:animate_stop(objectives_label)
	self:animate_stop(objectives_label_shadow)
	
	if (data.mode ~= "remind") or (data.id and data.id == managers.hud._hud_objectives._active_objective_id) then
		local label_text = utf8.to_upper(data.text)
		if data.amount and data.current_amount then
			label_text = label_text .. string.gsub(" [$CURRENT/$TOTAL]","$CURRENT",data.current_amount)
			label_text = string.gsub(label_text,"$TOTAL",data.amount)
		elseif data.amount or data.current_amount then 
		--i don't know under what circumstances this would trigger, probably just weirdly scripted custom heissts
			label_text = label_text .. " [" .. tostring(data.amount or data.current_amount) .. "]"
		end
		objectives_label:set_text(label_text)
		objectives_label_shadow:set_text(label_text)
	end
	
	
--build display cb sequence backwards

--forward order:

--animate white flash
	-- done_cb fadein title, fadein label
--fadein title
	--done cb: delayed cb to fadeout title after display duration
--fadein label
	--done cb: delayed cb to fadeout label after display duration
--return done
	
--basically, title and label are animated concurrently (after the initial flash)
--each with their own cb tree,
--but title is the one that calls the overall animate done callback for this objective 

--
	local function done () 
	--remove this objective from queue, 
	--	and display next queued objective, if one exists
		table.remove(self._queued_objectives,1)
		if self._queued_objectives[1] then 
			self:PerformObjectiveFromQueue()
		end
	end
	
	
	
	local function fadeout_title()
		self:AddDelayedCallback(function()
			self:animate(objectives_title,"animate_fadeout",function(o) o:set_font_size(title_font_size) done() end,0.5)
			self:animate(objectives_title_shadow,"animate_fadeout",function(o) o:set_font_size(title_font_size) end,0.5)		
		end,nil,display_hold_time,"objective_title_hide")
	end
	local function fadeout_label()
		self:AddDelayedCallback(function()
			self:animate(objectives_label,"animate_fadeout",nil,0.5)
			self:animate(objectives_label_shadow,"animate_fadeout",nil,0.5)
		end,nil,display_hold_time,"objective_label_hide")
	end
	
	local function animate_objective_label_in()		
		self:animate(objectives_label,"animate_objective_flash",fadeout_label,in_duration,label_font_size,kern)
		self:animate(objectives_label_shadow,"animate_objective_flash",nil,in_duration,label_font_size,kern)
	end
	local function animate_blink_blinkout()
		blink_label:set_alpha(1)
		self:animate(blink_label,"animate_objective_blinkout",animate_objective_label_in,blinkout_time,label_w,label_w * blinkout_stretch_w_mul,blinkout_alpha,mid_x)
	end
	
	local function animate_objective_title_in()
		self:animate(objectives_title,"animate_objective_flash",fadeout_title,in_duration,title_font_size,kern)
		self:animate(objectives_title_shadow,"animate_objective_flash",nil,in_duration,title_font_size,kern)
		animate_blink_blinkout()
	end

	self:animate(blink_title,"animate_objective_blinkout",animate_objective_title_in,blinkout_time,title_w,title_w * blinkout_stretch_w_mul,blinkout_alpha,mid_x)
end

function NobleHUD:SetObjectiveTitle(label)
	if alive(self._objectives_panel) then 
		self._objectives_panel:child("objectives_title"):set_text(label)
		self._objectives_panel:child("objectives_title_shadow"):set_text(label)
	end
end

function NobleHUD:AddQueuedObjective(data)
	if not data then
		self:log("NobleHUD:AddQueuedObjective(): Really bro? You're gonna try to queue an objective with no data? For shame.")
		return
	end
	if not data.id then 
		self:log("NobleHUD:AddQueuedObjective(): I don't believe this. You come into my home and try to add an objective without an id?" )
		return
	end	
	if data.mode == "remind" then 
		local c = self._cache.objectives[data.id] or {text = ""}
		data.current_amount = data.current_amount or c.current_amount
		data.amount = data.amount or c.amount
		data.text = data.text or c.text
	elseif data.text then 
		self._cache.objectives[data.id] = data
	end
	
	
	local added = false
	
	--search queued objectives for this objective, and replace it if it exists (and isn't already animating)
	for i,queued in ipairs(NobleHUD._queued_objectives) do 
		if queued.id == data.id and not queued.is_animating then 
			table.remove(NobleHUD._queued_objectives,i)
			table.insert(NobleHUD._queued_objectives,data)
			added = true
			break
		end
	end
	if not added then 		
		table.insert(NobleHUD._queued_objectives,data)
	end
	if NobleHUD._queued_objectives[1] and not NobleHUD._queued_objectives[1].is_animating then
		self:PerformObjectiveFromQueue()
	end
	
	--do start animation
end
	
function NobleHUD:PerformObjectiveFromQueue()
	local data = NobleHUD._queued_objectives[1]
	
	local mode = data.mode --can be activate, remind, or complete
	if mode == "activate" then 
		NobleHUD:SetObjectiveTitle(utf8.to_upper(managers.localization:text("noblehud_hud_objective_activate")))
	elseif mode == "remind" then 
		NobleHUD:SetObjectiveTitle(utf8.to_upper(managers.localization:text("noblehud_hud_objective_reminder")))
	elseif mode == "update_amount" then
		NobleHUD:SetObjectiveTitle(utf8.to_upper(managers.localization:text("noblehud_hud_objective_update")))
	elseif mode == "complete" then
		NobleHUD:SetObjectiveTitle(utf8.to_upper(managers.localization:text("noblehud_hud_objective_complete")))
	elseif mode == "wave" then
		NobleHUD:SetObjectiveTitle(utf8.to_upper(managers.localization:text("noblehud_hud_objective_wave")))
	else
		self:log("NobleHUD:AddQueuedObjective(): I don't believe this. You come into my home and try to add an objective without an objective_id? TWICE?")
		table.remove(NobleHUD._queued_objectives,1)
	end
	
	NobleHUD:AnimateShowObjective(data)
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

--blink by number of blinks
function NobleHUD:animate_blink_2(o,t,dt,start_t,blinks_per_second,visible_percentage,total_blinks)
	if (t - start_t) * blinks_per_second < total_blinks then
		return true
	end
	o:set_visible((1 - visible_percentage) + math.cos((t - start_t) * 100 * blinks_per_second) > visible_percentage)
end

--blink by timed duration
function NobleHUD:animate_blink_time(o,t,dt,start_t,blinks_per_second,visible_percentage,duration)
	if duration == -1 then 
		--animate infinitely, until manually stopped with animate_stop() or overridden
	elseif (t - start_t) > duration then
		return true
	end
	o:set_visible((1 - visible_percentage) + math.cos((t - start_t) * 100 * blinks_per_second) > visible_percentage)	
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


--		TABSCREEN

function NobleHUD:_create_tabscreen(hud)
	local tabscreen = hud:panel({
		name = "tabscreen",
		visible = true,
		alpha = 0
	})
	self._tabscreen = tabscreen
	local h_margin = 8
	
	local v_margin = 2
	
	--todo get settings
	local downs_w = 24
	local icon_w = 32
	local name_w = 256
	local callsign_w = 50
	local score_w = 50
	local ping_w = 64
	local ping_bitmap_w = 6
	
	local indicator_w = 3
	
	local brightness = 0.8
	
	local all_box_h = 32
	
	local player_box_x = 32
--	local player_box_y = 100
	local player_box_w = downs_w + callsign_w + icon_w + name_w + score_w + ping_w
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
	scoreboard:set_x(100 + ((hud:w() - scoreboard_w) / 2))
	scoreboard:set_y(all_box_h * 1.5) --margin from top of screen
--	scoreboard:set_center(hud:w()/2,hud:h()/2)
	
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
		text = "Bank Heist: Gold" .. " /// " .. string.rep(self.special_chars.skull .. " ",3),
		align = "left",
		vertical = "center",
		x = title_box:w() / 20,
		color = Color(1,0.75,0),
		font = tweak_data.hud_players.ammo_font,
		font_size = font_size,
		layer = 2
	})
	local _,_,_w,_ = title_label:text_rect()
	
	local job_chain = managers.job:current_job_chain_data()
	local day = managers.job:current_stage()
	local days = job_chain and #job_chain or 0
	local title_label_2 = title_box:text({
		name = "title_label_2",
		text = managers.localization:to_upper_text("hud_days_title", {
			DAY = day,
			DAYS = days
		}),
		align = "right",
		vertical = "center",
		x = -4,
--		x = title_label:x() + _w,
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
		w = callsign_w + icon_w + name_w + score_w
	})
	local teamname_bg = teamname_box:rect({
		name = "teamname_bg",
		color = self:GetTeamColor(),
		layer = 1
	})
	local teamname_label = teamname_box:text({
		name = "teamname_label",
		text = self:GetTeamName(),
		align = "left",
		x = teamname_box:w() / 20,
		vertical = "center",
		font = tweak_data.hud_players.ammo_font,
		font_size = font_size,
		layer = 3
	})
	
	local teamscore_box = header_box:panel({
		name = "teamname_box",
		x = player_box_x + downs_w + icon_w + name_w + callsign_w,
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
		text = "", --tabscreen team score label
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
	local function create_player_box (id)
		local peer_color = tweak_data.chat_colors[3] or Color.red --temp
		local peer_color_2 = (peer_color * brightness):with_alpha(1) or tweak_data.preplanning_peer_colors[3]
		--kills, icon, playername, character, kills/score, ping (visual)
		local player_box = scoreboard:panel({
			name = "player_box_" .. tostring(id),
			w = player_box_w,
			h = player_box_h,
			x = player_box_x,
			y = (header_box:bottom() + v_margin) + ((v_margin + player_box_h) * (id - 1)),
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
		
--		local downs_texture,downs_rect = tweak_data.hud_icons:get_icon_data("csb_lives")
		local downs_bitmap = downs_box:bitmap({
			name = "downs_bitmap",
			layer = 3,
			texture = "guis/textures/lives_icon",
--			texture = downs_texture, --"guis/textures/health_cross",
			texture_rect = downs_rect,
			y = (all_box_h - downs_w) / 2,
			w = downs_w,
			h = downs_w,
			color = Color(0.75,0.3,0.3)
		})
		local downs_label = downs_box:text({
			name = "downs_label",
			text = "0",
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
		
		--[[
		local peer = peer_id and managers.network:session():peer(peer_id)
		local pfp
		if peer then 
			Steam:friend_avatar(2, peer:user_id(), function (img) pfp = img end)
		end
		
		--]]
		
		local icon_texture,icon_rect = tweak_data.hud_icons:get_icon_data("pd2_question")
		local icon_bitmap = icon_box:bitmap({
			name = "icon_bitmap",
			layer = 3,
			texture = icon_texture,
			texture_rect = icon_rect,
			w = icon_w,
			h = icon_w
		})

		
--		local profile = Steam:user(peer:id64())
--local url = "http://steamcommunity.com/profiles/"..tostring(peer:id64()).."/pfp.png"
--Steam:userid()
--local pfp = dohttpreq(url)

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
			text = "Empty Slot",
			align = "left",
			vertical = "center",
			x = name_w / 20,
			font = tweak_data.hud_players.ammo_font,
			font_size = font_size,
			layer = 3
		})
		
		local callsign_box = player_box:panel({
			name = "callsign_box",
			layer = 2,
			w = callsign_w,
			x = name_box:right()
		})
		local callsign_bg = callsign_box:rect({
			name = "callsign_bg",
			layer = 2,
			color = peer_color
		})
		local callsign_label = callsign_box:text({
			name = "callsign_label",
			text = "-",
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
			x = callsign_box:right()
		})
		local score_bg = score_box:rect({
			name = "score_bg",
			color = Color(0.3,0.3,0.3),
			layer = 2
		})
		local score_label = score_box:text({
			name = "score_label",
			text = "", --tabscreen scoreboard 
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
			name = "ping_bitmap",
			layer = 3,
			texture = "guis/textures/test_blur_df",
			w = ping_bitmap_w,
			h = player_box_h,
			color = self.color_data.hud_latency_low
		})
		local ping_label = ping_box:text({
			name = "ping_label",
			text = "", --math.random(100) .. " ms",
			align = "left",
			vertical = "bottom",
			font = tweak_data.hud_players.ammo_font,
			font_size = font_size / 2,
			x = ping_bitmap_w + (ping_w / 20),
			layer = 4
		})
	end
	
	for i=1,4 do 
		create_player_box(i)
	end
	
	
	local music_box = tabscreen:panel({
		name = "music_box",
		y = 0,
		w = tabscreen:w(),
		h = 30,
		visible = false
	})
	local music_bg = music_box:gradient({
		name = "music_bg",
		valign = "grow",
		layer = -5,
--		blend_mode = "add",
		w = music_box:w(),
		h = music_box:h(),
		gradient_points = {
			0,
			Color(0,0,0):with_alpha(0), --argb
			0.33,
			self.color_data.strange,
			0.5,
			self.color_data.collector,
			0.66,
			self.color_data.strange,
			1,
			Color(0,0,0):with_alpha(0)
		}
	})
	
	local music_label = music_box:text({
		name = "music_label",
		text = "NOW PLAYING: Megalovania (Sans Undertale) (Revolver Ocelot)",
		align = "center",
		vertical = "center",
		x = 32,
		font = tweak_data.hud_players.ammo_font,
		font_size = 16,
		layer = 4
	})
	local music_texture,music_rect = tweak_data.hud_icons:get_icon_data("jukebox_playing_icon")
	local music_icon_left = music_box:bitmap({
		name = "music_icon_left",
		layer = 3,
		texture = music_texture,
		texture_rect = music_rect,
		y = (music_box:h() - 16) / 2,
		w = 16,
		h = 16
	})
	local music_icon_right = music_box:bitmap({
		name = "music_icon_right",
		layer = 3,
		texture = music_texture,
		texture_rect = music_rect,
		y = (music_box:h() - 16) / 2,
		w = 16,
		h = 16
	})
	local music_x,_,music_w,_ = music_label:text_rect()
	music_icon_left:set_x(((tabscreen:w() - music_w) / 2))
	music_icon_right:set_x(((tabscreen:w() + music_w) / 2))
	
	
	local mission_box = tabscreen:panel({
		name = "mission_box",
		x = 16,
		y = 16,
		w = 256,
		h = tabscreen:h(),
		visible = false
	})
	mission_box:set_h(tabscreen:h() - (mission_box:y() + 16))
	
	local mission_bg = mission_box:rect({
		name = "mission_bg",
		layer = -3,
		color = self.color_data.normal
	})
	local mission_title = mission_box:text({
		name = "mission_title",
		text = "MISSION STATUS",
		y = 0,
		align = "center",
		font = tweak_data.hud_players.ammo_font,
		font_size = 32,
		layer = 4
	})
	local mission_ghostable_icon = mission_box:bitmap({
		name = "mission_ghostable_icon",
		texture = "guis/textures/pd2/cn_minighost",
		h = 16,
		x = mission_title:right(),
		blend_mode = "add",
		visible = true,
		w = 16,
		layer = 5,
		color = self.color_data.haunted
	})
	local mission_bags_label = mission_box:text({
		name = "mission_bags_label",
		text = "10/10 (+1) bags",
		x = h_margin,
		y = 36,
		font = tweak_data.hud_players.ammo_font,
		font_size = 24,
		layer = 4
	})
	local mission_bags_money_label = mission_box:text({
		name = "mission_bags_money_label",
		text = "Looted value: $192,135,123",
		x = h_margin,
		y = 60,
		font = tweak_data.hud_players.ammo_font,
		font_size = 24,
		layer = 4
	})
	local mission_instant_cash_label = mission_box:text({
		name = "mission_instant_cash_label",
		text = "Instant Cash: $123,000",
		x = h_margin,
		y = 84,
		font = tweak_data.hud_players.ammo_font,
		font_size = 24,
		layer = 4
	})
	local mission_payout_total = mission_box:text({
		name = "mission_payout_total",
		text = "Heist Payout: $123,045",
		x = h_margin,
		y = 108,
		font = tweak_data.hud_players.ammo_font,
		font_size = 24,
		layer = 4
	})
	
	local bodybags_texture,bodybags_rect = tweak_data.hud_icons:get_icon_data("pd2_bodybag")
	local bodybags_icon = mission_box:bitmap({
		name = "bodybags_icon",
		texture = bodybags_texture,
		texture_rect = bodybags_rect,
		w = 24,
		h = 24,
		x = h_margin,
		y = 108 + 24,
		layer = 5,
		color = self.color_data.haunted
	})
	local bodybags_label = mission_box:text({
		name = "bodybags_label",
		text = "2",
		x = bodybags_icon:w() + 4,
		y = bodybags_icon:y(),
		font = tweak_data.hud_players.ammo_font,
		font_size = 24,
		layer = 4
	})
	
	
	local right_box_w = 300
	--can be achievements or mutators
	local right_box = tabscreen:panel({
		name = "right_box",
		w = right_box_w,
		h = tabscreen:h(),
		x = tabscreen:w() - right_box_w,
		y = 0,
		visible = false
	})
	local right_label = right_box:text({
		name = "right_label",
		text = "Tracked Achievements",
		y = 16,
		align = "center",
		font = tweak_data.hud_players.ammo_font,
		font_size = 32,
		layer = 4
	})
	local right_bg = right_box:rect({
		name = "right_bg",
		color = Color(0.4,0.4,0.4),
		alpha = 1
	})
end

function NobleHUD:_set_tabscreen_teammate_callsign(id,callsign)
	local player_box = self._tabscreen:child("scoreboard"):child("player_box_" .. id)
	if alive(player_box) then
		player_box:child("callsign_box"):child("callsign_label"):set_text(callsign)
	end
end

function NobleHUD:_set_tabscreen_teammate_name(id,name)
	local player_box = self._tabscreen:child("scoreboard"):child("player_box_" .. id)
	if alive(player_box) then
		player_box:child("name_box"):child("name_label"):set_text(name)
	end
end

function NobleHUD:_set_main_player_indicator(id)
	local scoreboard = self._tabscreen:child("scoreboard")
	local player_box = scoreboard:child("player_box_" .. tostring(id))
	if alive(player_box) then
		scoreboard:child("player_indicator"):set_y(player_box:y())
	end
end

function NobleHUD:_clear_tabscreen_teammate_info()
--todo grey out info until other player joins?
end

function NobleHUD:SetTeamName(name,color)
	local scoreboard = self._tabscreen:child("scoreboard")
	local header_box = scoreboard:child("header_box")
	local teamname_box = header_box:child("teamname_box")
	local teamname_label = teamname_box:child("teamname_label")
	if name then 
		teamname_label:set_text(tostring(name))
	else
--		self:log("NobleHUD:SetTeamName(" .. tostring(name) .. "," .. tostring(color) .. ": invalid name")
		return
	end
	if color then 
		teamname_box:child("teamname_bg"):set_color(color)
--		teamname_label:set_color(color)
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
		end
	end
end

function NobleHUD:_set_scoreboard_character(id,peer_id,character_id,player_name)
	local player_box = self._tabscreen:child("scoreboard"):child("player_box_" .. tostring(id))
--	self:log("NobleHUD:_set_scoreboard_character(" .. NobleHUD.table_concat({id=id,peer_id=peer_id,character_id=character_id},"|","=",true) ..")")
	
	
	if alive(player_box) then 
		local icon_box = player_box:child("icon_box")
		local mask_id,mask_icon
		
		if character_id then 
			mask_id = tweak_data.blackmarket.masks.character_locked[managers.criminals.convert_old_to_new_character_workname(character_id)]
			mask_icon = tweak_data.blackmarket:get_mask_icon(mask_id)
		end
		local color_1 = tweak_data.chat_colors[5]
		local color_2 = (color_1 * 0.8):with_alpha(1)
		
		if (peer_id and managers.network:session():peer(peer_id)) then
			color_1 = tweak_data.chat_colors[peer_id]
			color_2 = (color_1 * 0.8):with_alpha(1)
			
			local player_icon = icon_box:child("icon_bitmap")
			
			local peer = managers.network:session():peer(peer_id)
			if peer then 
				Steam:friend_avatar(2, peer:user_id(),
					function (img)
						if img then 
							player_icon:set_image(img)
						else
--							player_icon:set_image(mask_icon)
						end
					end
				)
			end
			
		else
			if mask_icon then 
				icon_box:child("icon_bitmap"):set_image(mask_icon)
			end
			if character_id then 
				player_box:child("name_box"):child("name_label"):set_text(managers.localization:text("menu_" .. character_id))
			elseif player_name then 
				player_box:child("name_box"):child("name_label"):set_text(player_name)				
			end
		end
		icon_box:child("icon_bg"):set_color(color_1)
		player_box:child("callsign_box"):child("callsign_bg"):set_color(color_1)
		player_box:child("name_box"):child("name_bg"):set_color(color_2)
	end
--	local character_icon = tweak_data.blackmarket:get_character_icon(character)
end

function NobleHUD:_set_scoreboard_kills(panel_id,num_kills)
	
	
	local player_box = self._tabscreen:child("scoreboard"):child("player_box_" .. tostring(panel_id))

	player_box:child("kills_box"):child("kills_label"):set_text(NobleHUD.special_chars.skull .. tostring(num_kills or 0))

end

function NobleHUD:AnimateShowTabscreen()
--	self._tabscreen:set_alpha(0)
	self:ShowTabscreen()

	self:animate(self._tabscreen,"animate_show_tabscreen",nil,0.25,self:GetHUDAlpha())
--	self:animate(self._tabscreen,"animate_fadein",nil,0.25,self:GetHUDAlpha())
--	self:animate(self._ws:panel(),"animate_fadeout",nil,0.25,self._ws:panel():alpha())
end

function NobleHUD:AnimateHideTabscreen()
	self:ShowTabscreen()
	self:animate(self._tabscreen,"animate_hide_tabscreen",callback(NobleHUD,NobleHUD,"HideTabscreen"),0.25,self._tabscreen:alpha())
--	self:animate(self._ws:panel(),"animate_fadein",nil,0.25,1)
--	self:animate(self._tabscreen,"animate_fadeout",callback(NobleHUD,NobleHUD,"HideTabscreen"),0.25,self._tabscreen:alpha())
end

function NobleHUD:SetTeammatePing(id,ping)
	ping = tonumber(ping)
	local player_box = id and self._tabscreen:child("scoreboard"):child("player_box_" .. id)
	if alive(player_box) then
		local ping_box = player_box:child("ping_box")
		ping_box:child("ping_label"):set_text((ping and string.format("%d ms",ping)) or "-")
		local ping_h_max = player_box:h()
		if ping then 
			local ping_h = ping_h_max
			local color = self.color_data.hud_latency_low
			local LATENCY_THRESHOLD_LOW = 200
			local LATENCY_THRESHOLD_MEDIUM = 500
			local LATENCY_THRESHOLD_HIGH = 1000
			
			if ping < LATENCY_THRESHOLD_LOW then 
				ping_h = ping_h_max * 0.25
				color = self.color_data.hud_latency_low
			elseif ping < LATENCY_THRESHOLD_MEDIUM then 
				ping_h = ping_h_max * 0.50
				color = self.color_data.hud_latency_medium
			elseif ping < LATENCY_THRESHOLD_HIGH then 
				ping_h = ping_h_max * 0.75
				color = self.color_data.hud_latency_high
			else
				ping_h = ping_h_max * 1
				color = self.color_data.hud_latency_unbearable
			end
			local ping_bitmap = ping_box:child("ping_bitmap")
			ping_bitmap:set_color(color)
			ping_bitmap:set_h(ping_h)
			ping_bitmap:set_y(ping_box:h() - ping_h)
		end
	end
end

function NobleHUD:animate_show_tabscreen(o,t,dt,start_t,duration,end_alpha,...)
	for _,child in pairs(self._ws:panel():children()) do 
		if child:name() == "crosshair_panel" then 
			self:animate_fadeout(child,t,dt,start_t,duration,self:GetCrosshairAlpha(),...)
		elseif child:name() == "stamina_panel" then 
			child:hide()
		elseif child:name() ~= "tabscreen" then 
			self:animate_fadeout(child,t,dt,start_t,duration,child:alpha(),...)
		end
	end
	if self:animate_fadein(o,t,dt,start_t,duration,end_alpha,...) then 
		return true
	end
end

function NobleHUD:animate_hide_tabscreen(o,t,dt,start_t,duration,from_alpha,...)
	for _,child in pairs(self._ws:panel():children()) do 
	
		if child:name() == "crosshair_panel" then 
			self:animate_fadein(child,t,dt,start_t,duration,self:GetCrosshairAlpha(),...)
		elseif child:name() == "stamina_panel" then 
			child:show()
		elseif child:name() ~= "tabscreen" then 
			self:animate_fadein(child,t,dt,start_t,duration,1,...)
		end
	end
	if self:animate_fadeout(o,t,dt,start_t,duration,from_alpha,...) then 
		return true
	end
end

function NobleHUD:ShowTabscreen(state)
	if state ~= nil then 
		self._tabscreen:set_visible(state)
	else
		self._tabscreen:show()
	end
end

function NobleHUD:HideTabscreen()
	self._tabscreen:hide()
end

--		RADAR

function NobleHUD:_create_radar(hud)
	local radar_panel = hud:panel({
		name = "radar_panel",
		w = self._RADAR_SIZE,
		h = self._RADAR_SIZE,
		x = 32,
		y = hud:bottom() - 224, --bottom left
		alpha = self:GetHUDAlpha()
	})
	
	local radar_size = self._RADAR_BG_SIZE * self:GetRadarScale()
	local radar_bg = radar_panel:bitmap({
		name = "radar_bg",
		texture = "guis/textures/radar_bg",
		layer = 2,
		x = (radar_panel:w() - radar_size) / 2,
		y = (radar_panel:h() - radar_size),
		w = radar_size,
		h = radar_size,
		color = self.color_data.hud_vitalsfill_blue,
		alpha = 0.8
	})
--	radar_bg:set_center(radar_panel:w()/2,radar_panel:h()/2)
--	radar_bg:set_x((radar_panel:w() - radar_bg:w()) / 2)
--	radar_bg:set_y(radar_panel:h() - radar_bg:h())
	local radar_range_label = radar_panel:text({
		name = "radar_range_label",
		text = "25m",
		color = self.color_data.hud_vitalsoutline_blue,
		layer = 2,
		font = self.fonts.eurostile_ext,
		font_size = self._RADAR_TEXT_SIZE,
		align = "left",
		valign = "bottom",
--		y = -16, --equal to font size
		vertical = "bottom",
		alpha = 0.9
	})
	
	self._radar_panel = radar_panel
	
	local debug_radar = radar_panel:rect({
		name = "debug_radar",
		w = 1280,
		h = 720,
		layer = -1,
		color = Color.yellow,
		visible = false,
		alpha = 0.1
	})
end

function NobleHUD:create_radar_blip(u,variant)
	variant = variant or "person"
		
	if ((variant == "person") or (variant == "sentry")) then
		if (not (alive(u) and u:movement() and u:movement():team())) or ((not u:character_damage()) or u:character_damage():dead()) then 
			self:log("Error: No unit for create_radar_blip(" .. tostring(u) .. "," .. tostring(variant) .. ")!",{color = Color.red})
			return
		end
	elseif variant == "vehicle" then 
		if not (alive(u) and u:vehicle_driving()) then 
			self:log("Error: No vehicle unit for create_radar_blip(" .. tostring(u) .. "," .. tostring(variant) .. ")!",{color = Color.red})
			return
		end
	end
	if variant == "ecm_decoy" then 
		if not (alive(u) and u:base() and u:base():get_name_id() == "ecm_jammer" and u:base():battery_life() > 0) then 
			self:log("Error: No ECM unit for create_radar_blip(" .. tostring(u) .. "," .. tostring(variant) .. ")!",{color = Color.red})
			return
		end
	elseif self._radar_blips[u:key()] then --blip data already exists, so return it
		return self._radar_blips[u:key()]
	end
	local u_key = u:key()
	local team,position
	local expire_t,arc,velocity --ecm_decoy only
	if variant == "vehicle" then 
		local driving_state = u:vehicle_driving()
		if driving_state then 
			if driving_state:num_players_inside() > 0 then 
				team = "criminal1"
			elseif driving_state:_number_in_the_vehicle() > 0 then 
				local driver_unit = driving_state._seats.driver and driving_state._seats.driver.occupant
				if driver_unit and alive(driver_unit) and driving_state._seats.driver.occupant:brain() then 
					self:log("Holy heck, an NPC is driving a vehicle?!",{color = Color.red}) 
					if driver_unit:movement() and driver_unit:movement():team() then 
						local driver_team = driver_unit:movement():team().id 
						if driver_team then 
							self:log("It's on team " .. tostring(driver_team),{color=Color.red})
							team = driver_team
						end
					end
				end
				team = team or "empty_vehicle"
			end
		end
		team = team or "empty_vehicle"
	elseif variant == "fake_vehicle" then 
		if u:base() and u:base()._modules then 
			team = "law1"
		end
		team = team or "empty_vehicle"
	--things like cop cars or swat vans; not currently detected
	elseif variant == "sentry" then
		team = u:movement():team().id
		if team == "criminal1" then 
		end
	elseif variant == "ecm_decoy" then 
		local decoy_max_x,decoy_max_y,decoy_max_z = self:GetMaxRadarDecoyRange()
		
		local lifetime_min = self:GetRadarDecoyLifetimeMin()
		local lifetime_max = self:GetRadarDecoyLifetimeMax()
		expire_t = Application:time() + (math.random() * (lifetime_max - lifetime_min)) + lifetime_min
		u_key = variant .. "_" .. tostring(Application:time())
		if math.random() > 0.5 then 
			arc = math.random(0,359)
		else
			
		end
		position = Vector3(math.random(decoy_max_x * 2) - decoy_max_x,math.random(decoy_max_y * 2) - decoy_max_y,math.random(2 * decoy_max_z) - decoy_max_z)
		velocity = Vector3(math.random(50,500),math.random(50,500),math.random(0,500))
		team = "law1"
	else
--		blip_texture = "guis/textures/radar_blip"
		team = u:movement():team().id
	end

	local blip_bitmap = self._radar_panel:bitmap({
		name = "blip_" .. tostring(u:key()),
		texture = "guis/textures/radar_blip",
		layer = 4,
		color = self:get_blip_color_by_team(team),
		blend_mode = "add",
		alpha = 0,
		x = 0,
		y = 0
	})
	
	
	local blip_data = {
		variant = variant,
		bitmap = blip_bitmap,
		unit = u,
		arc = arc,
		velocity = velocity,
		expire_t = expire_t, --for ecm_decoy only
		position = position --for ecm_decoy only; todo fake_vehicle should use this
	}
	
	self._radar_blips[u_key] = blip_data
	return blip_data
end

function NobleHUD:create_radar_blip_ghost(blip_data)
	if not blip_data then 
		self:log("Attempt to create radar blip ghost with invalid data!",{color=Color.red})
		return
	end
	local start_size = 0.25
	
	blip_data.name = blip_data.name or ("radar_ghost_" .. tostring(blip_data))
	
	local blip_bitmap = self._radar_panel:bitmap(blip_data)
	local blip_w = blip_data.blip_w or (blip_bitmap:w() * (blip_data.size_mult or 1))
	local blip_h = blip_data.blip_h or (blip_bitmap:h() * (blip_data.size_mult or 1))
	
	blip_bitmap:set_w(blip_w * start_size)
	blip_bitmap:set_h(blip_h * start_size)
	
	if blip_data.center_x and blip_data.center_y then 
		blip_bitmap:set_center(blip_data.center_x,blip_data.center_y)
	end
	
	local function fadeout_func(o)
		self:animate(o,"animate_fadeout",function(p) p:parent():remove(p) end,self._RADAR_GHOST_FADEOUT,o:alpha())
	end
	self:animate(blip_bitmap,"animate_blip_ghost",fadeout_func,self._RADAR_GHOST_FADEIN,blip_data.end_alpha,blip_bitmap:w(),blip_bitmap:h(),blip_w,blip_h,blip_data.center_x,blip_data.center_y)
end

function NobleHUD:check_radar_blip_color(u,key) --updates radar blip color based on team
--todo update color based on UNIT, for units that are not humans (eg. vehicles,cameras)
	key = key or (u and u:key())
	if not key then 
		self:log("Error: No key for check_radar_blip_color()!",{color = Color.red})
		return
	end
	local blip = self._radar_blips[key]
	
	if blip then 
		local unit = u or blip.unit
		local team = unit:movement() and unit:movement():team() and unit:movement():team().id or "law1"
		local color = self:get_blip_color_by_team(team)
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
	if blip and blip.bitmap and alive(blip.bitmap) then 
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

function NobleHUD:_set_radar_range(text)
	self._radar_panel:child("radar_range_label"):set_text(string.gsub(managers.localization:text("noblehud_hud_radar_distance_label"),"$DISTANCE",text))	
end

function NobleHUD:LayoutRadar(skip_sort_children)
	local panel = self._radar_panel
	if not panel then return end
	local parent_panel = panel:parent()
	local scale = self:GetRadarScale()
	local panel_size = scale * self._RADAR_SIZE
	local bg_size = scale * self._RADAR_BG_SIZE
	local bg = self._radar_panel:child("radar_bg")
	
	panel:set_size(panel_size,panel_size)
	
	local align_horizontal = self:GetRadarAlignHorizontal()
	local align_vertical = self:GetRadarAlignVertical()
	if align_horizontal == "left" then 
		panel:set_x(self:GetRadarPanelX())
	elseif align_horizontal == "center" then 
		panel:set_x(((parent_panel:w() - panel:w()) / 2) + self:GetRadarPanelX())
	elseif align_horizontal == "right" then
		panel:set_x(parent_panel:w() - (panel:w() + self:GetRadarPanelX()))
	end
	if align_vertical == "top" then 
		panel:set_y(self:GetRadarPanelY())
	elseif align_vertical == "center" then 
		panel:set_y(((parent_panel:h() - panel:h()) / 2) + self:GetRadarPanelY())
	elseif align_vertical == "bottom" then 
		panel:set_y(parent_panel:h() - (panel:h() + self:GetRadarPanelY() + 24))
	end
	panel:child("radar_range_label"):set_font_size(self._RADAR_TEXT_SIZE * scale)
--	panel:set_position(0,panel:parent():h() - (panel_size + 32))
		
	bg:set_size(bg_size,bg_size)
	
	bg:set_position((panel:w() - bg_size) / 2,(panel:h() - bg_size) / 2)
	if not skip_sort_children then 
		self:_sort_teammates()
		self:LayoutAbility()
	end
end


--		CARTOGRAPHER (location on map)

function NobleHUD:_create_cartographer(hud)
	local cartographer_h = 32
	local cartographer_panel = hud:panel({
		name = "cartographer_panel",
		w = hud:w(),
		h = cartographer_h,
		x = 200,
		y = hud:bottom() - (cartographer_h + 24),
		alpha = self:GetHUDAlpha()
	})
	local debug_cartographer = cartographer_panel:rect({
		name = "debug_cartographer",
		visible = false,
		color = Color.red,
		alpha = 0.3
	})
	local area_label = cartographer_panel:text({
		name = "area_label",
		text = "", --"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
		color = self.color_data.hud_vitalsoutline_blue,
		layer = 2,
		font = self.fonts.eurostile_ext or self.fonts.eurostile_normal,
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
		w = self._VITALS_W,
		h = self._VITALS_H,
		x = (hud:w() - self._VITALS_W)/ 2,
		y = 50,
		alpha = self:GetHUDAlpha()
	})
	local shield_outline = vitals_panel:bitmap({
		name = "shield_outline",
		texture = "guis/textures/shield_outline",
		layer = 4,
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
		alpha = 0.5,
		x = 0,
		y = 0
	})
	
	local delayed_damage_shield_fill = vitals_panel:bitmap({
		name = "delayed_damage_shield_fill",
		texture = "guis/textures/shield_fill",
		layer = 5,
		color = self.color_data.hud_delayeddamage_fill,
		alpha = 0.5,
		w = 0,
		x = 0,
		y = 0
	})
	
	local absorption_shield_fill = vitals_panel:bitmap({
		name = "absorption_fill",
		texture = "guis/textures/shield_fill",
		layer = 3,
		blend_mode = "add",
		color = self.color_data.hud_overshield_fill,
		alpha = 0.5,
		w = 0,
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
		text = managers.localization:text("noblehud_hud_shield_empty"),
		layer = 6,
		align = "center",
		halign = "center",
		y = self._VITALS_WARNING_Y,
		alpha = 0,
		color = Color.white,
		font = tweak_data.hud.medium_font,
		font_size = self._VITALS_FONT_SIZE
	})
	local TICK_SCALE = self._VITALS_TICK_SCALE
	local TICK_W = self._VITALS_TICK_W * TICK_SCALE
	local TICK_H = self._VITALS_TICK_H * TICK_SCALE
	local TICK_Y = vitals_panel:h() + -8 + - TICK_H 
	local CENTER_W = self._VITALS_TICK_W_CENTER * TICK_SCALE
	local FREE_SPACE = (self._VITALS_W / 3) - (CENTER_W / 2)
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
			alpha = 0.5,
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
			alpha = 0.5,
			x = right_x,
			y = TICK_Y
		})
		local tick_left_outline = vitals_panel:bitmap({
			name = "health_tick_left_outline_" .. i,
			texture = "guis/textures/health_left_outline",
			w = TICK_W,
			h = TICK_H,
			layer = 3,
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
			color = self.color_data.hud_vitalsoutline_blue,
			alpha = 0.5,
			x = right_x,
			y = TICK_Y
		})
	
	--ex pres

		local stored_tick_left_outline = vitals_panel:bitmap({
			name = "stored_health_tick_left_outline_" .. i,
			texture = "guis/textures/health_left_outline",
			w = TICK_W,
			h = TICK_H,
			layer = 4,
			blend_mode = "add",
			color = self.color_data.hud_storedhealth_fill,
			alpha = 0.7,
			visible = false,
			x = left_x,
			y = TICK_Y
		})
		local stored_tick_right_outline = vitals_panel:bitmap({
			name = "stored_health_tick_right_outline_" .. i,
			texture = "guis/textures/health_right_outline",
			w = TICK_W,
			h = TICK_H,
			layer = 4,
			blend_mode = "add",
			color = self.color_data.hud_storedhealth_fill,
			alpha = 0.7,
			visible = false,
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
		color = self.color_data.hud_vitalsoutline_blue,
		alpha = 0.5,
		x = (vitals_panel:w() - CENTER_W) / 2,
		y = TICK_Y
	})
	
	local stored_tick_center_outline = vitals_panel:bitmap({
		name = "stored_health_tick_center_outline",
		texture = "guis/textures/health_center_outline",
		w = CENTER_W,
		h = TICK_H,
		layer = 4,
		blend_mode = "add",
		color = self.color_data.hud_storedhealth_fill,
		alpha = 0.7,
		visible = false,
		x = (vitals_panel:w() - CENTER_W) / 2,
		y = TICK_Y
	})
		
	self._vitals_panel = vitals_panel
	
	local debug_vitals = vitals_panel:rect({
		visible = false,
		color = Color(1,0.5,0):with_alpha(0.1) --orange
	})
end

function NobleHUD:LayoutVitals()
	if false then return end

	local scale = self:GetVitalsScale()
	local vitals_panel = self._vitals_panel
	local VITALS_W = scale * self._VITALS_W
	local VITALS_H = scale * self._VITALS_H
	
	vitals_panel:set_size(VITALS_W,VITALS_H)
	vitals_panel:set_x((vitals_panel:parent():w() - VITALS_W) / 2)
	vitals_panel:child("shield_outline"):set_size(VITALS_W,VITALS_H)
	vitals_panel:child("shield_fill"):set_h(VITALS_H)
--	vitals_panel:child("shield_fill"):set_size(VITALS_W,VITALS_H)
	vitals_panel:child("delayed_damage_shield_fill"):set_h(VITALS_H)
--	vitals_panel:child("delayed_damage_shield_fill"):set_size(VITALS_W,VITALS_H)
	vitals_panel:child("absorption_fill"):set_h(VITALS_H)
--	vitals_panel:child("absorption_fill"):set_size(VITALS_W,VITALS_H)
	vitals_panel:child("shield_glow"):set_size(VITALS_W,VITALS_H)
	vitals_panel:child("shield_warning"):set_font_size(self._VITALS_FONT_SIZE * scale)
	vitals_panel:child("shield_warning"):set_y(self._VITALS_WARNING_Y * scale)
	
	local TICK_SCALE = self._VITALS_TICK_SCALE
	local TICK_W = self._VITALS_TICK_W * TICK_SCALE * scale
	local TICK_H = self._VITALS_TICK_H * TICK_SCALE * scale
	local TICK_Y = vitals_panel:h() + - TICK_H + - (VITALS_W / 64)
	local CENTER_W = self._VITALS_TICK_W_CENTER * scale
	local FREE_SPACE = (VITALS_W / 3) - (CENTER_W / 2)
	local MARGIN = FREE_SPACE / self._HUD_HEALTH_TICKS
	for i = 1, self._HUD_HEALTH_TICKS do 
		local left_x = ((vitals_panel:w() - CENTER_W)/ 2) + - (i * MARGIN)
		local right_x = ((vitals_panel:w() + CENTER_W)/ 2) + (i * MARGIN) - TICK_W
	
	
		local tick_left_fill = vitals_panel:child("health_tick_left_fill_" .. i)
		if alive(tick_left_fill) then 
			tick_left_fill:set_position(left_x,TICK_Y)
			tick_left_fill:set_size(TICK_W,TICK_H)
		end
		
		local tick_right_fill = vitals_panel:child("health_tick_right_fill_" .. i)
		if alive(tick_right_fill) then 
			tick_right_fill:set_position(right_x,TICK_Y)
			tick_right_fill:set_size(TICK_W,TICK_H)
		end
		
		local tick_left_outline = vitals_panel:child("health_tick_left_outline_" .. i)
		if alive(tick_left_outline) then 
			tick_left_outline:set_position(left_x,TICK_Y)
			tick_left_outline:set_size(TICK_W,TICK_H)
		end
		
		local tick_right_outline = vitals_panel:child("health_tick_right_outline_" .. i)
		if alive(tick_right_outline) then 
			tick_right_outline:set_position(right_x,TICK_Y)
			tick_right_outline:set_size(TICK_W,TICK_H)
		end
		
		local stored_tick_left_outline = vitals_panel:child("stored_health_tick_left_outline_" .. i)
		if alive(stored_tick_left_outline) then 
			stored_tick_left_outline:set_position(left_x,TICK_Y)
			stored_tick_left_outline:set_size(TICK_W,TICK_H)
		end
		
		local stored_tick_right_outline = vitals_panel:child("stored_health_tick_right_outline_" .. i)
		if alive(stored_tick_right_outline) then 
			stored_tick_right_outline:set_position(right_x,TICK_Y)
			stored_tick_right_outline:set_size(TICK_W,TICK_H)
		end
	end
	
	local tick_center_fill = vitals_panel:child("health_tick_center_fill")
	if alive(tick_center_fill) then 
		tick_center_fill:set_position((vitals_panel:w() - CENTER_W) / 2,TICK_Y)
		tick_center_fill:set_size(CENTER_W,TICK_H)
	end
	
	local tick_center_outline = vitals_panel:child("health_tick_center_outline")
	if alive(tick_center_outline) then 
		tick_center_outline:set_position((vitals_panel:w() - CENTER_W) / 2,TICK_Y)
		tick_center_outline:set_size(CENTER_W,TICK_H)
	end
	
	local stored_tick_center_outline = vitals_panel:child("stored_health_tick_center_outline")
	if alive(stored_tick_center_outline) then 
		stored_tick_center_outline:set_position((vitals_panel:w() - CENTER_W) / 2,TICK_Y)
		stored_tick_center_outline:set_size(CENTER_W,TICK_H)
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
		alpha = self:GetHUDAlpha(),
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
	local eq_h = 144
	local equipment_panel = hud:panel({
		name = "equipment_panel",
		layer = 1,
		w = hud:w(),
		h = eq_h,
		y = hud:h() + - eq_h,
		alpha = self:GetHUDAlpha()
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
				local center_x,center_y = o:center()
				NobleHUD:animate(o:child("bitmap"),"animate_killfeed_icon_pulse",nil,0.2,panel:w(),1.5) --center_x, center_y
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
		w = compass_w,
		alpha = self:GetHUDAlpha()
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

function NobleHUD:SetCompassDirection(angle)
	local compass_yaw = (angle / 180) - 1
	self._compass_panel:child("compass_strip"):set_x(compass_yaw * self._compass_panel:w())
end

--		INTERACTION

function NobleHUD:_create_interact(hud)
	local interact_panel = hud:panel({
		name = "interact_panel",
		w = hud:w(),
		h = hud:h(),
		alpha = self:GetHUDAlpha(),
		visible = true
	})
	self._interact_panel = interact_panel
	
	local margin_h = 50
	local margin_v = 4
	local INTERACT_NAME_Y = self._INTERACT_NAME_Y
	local interact_name = interact_panel:text({
		name = "interact_name",
		text = "Press [F] to Enter Warthog",
		align = "right",
		color = self.color_data.hud_vitalsoutline_blue,
		font = tweak_data.hud.medium_font_noshadow,
		font_size = self._INTERACTION_FONT_SIZE,
		x = -margin_h,
		y = INTERACT_NAME_Y,
		layer = 5,
		visible = false
	})
	
	local invalid_text = interact_panel:text({
		name = "invalid_text",
		text = "Invalid placement",
		align = "right",
		color = self.color_data.hud_vitalsfill_red,
		font = tweak_data.hud.medium_font_noshadow,
		font_size = self._INTERACTION_FONT_SIZE,
		x = -margin_h,
		y = INTERACT_NAME_Y + interact_name:line_height(),
		layer = 4,
		visible = false
	})
	
	
	local INTERACT_BAR_PANEL_W = self._INTERACT_BAR_PANEL_W
	local INTERACT_BAR_PANEL_H = self._INTERACT_BAR_PANEL_H
	local INTERACT_BAR_Y = self._INTERACT_BAR_Y --vertical offset from screen center
	local interact_bar_panel = interact_panel:panel({
		name = "interact_bar_panel",
		valign = "grow",
		halign = "grow",
		x = (interact_panel:w() - INTERACT_BAR_PANEL_W) / 2,
		y = INTERACT_BAR_Y + ((interact_panel:h() - INTERACT_BAR_PANEL_H) / 2),
		w = INTERACT_BAR_PANEL_W,
		h = INTERACT_BAR_PANEL_H,
		visible = false
	})

	local INTERACT_BAR_W = self._INTERACT_BAR_W
	local INTERACT_BAR_H = self._INTERACT_BAR_H
	local interact_bar = interact_bar_panel:gradient({
		name = "interact_bar",
		x = (margin_v + (interact_bar_panel:w() - INTERACT_BAR_W)) / 2,
		y = margin_v / 2,
		w = INTERACT_BAR_W,
		h = INTERACT_BAR_H,
		layer = 3,
		blend_mode = "add",
		gradient_points = {
			0,
			Color(1,1,0,0),
			0.5,
			Color(1,0,1,0),
			1,
			Color(1,0,0,1)
		},
		visible = true
	})
	
	local interact_empty = interact_bar_panel:rect({
		name = "interact_empty",
		color = Color("000d18"),
		x = interact_bar:x(),
		y = interact_bar:y(),
		w = INTERACT_BAR_W,
		h = INTERACT_BAR_H,
		layer = 2,
		visible = true
	})
	
	local interact_bg = interact_bar_panel:rect({
		name = "interact_bg",
		color = self.color_data.hud_bluefill,
		x = interact_bar:x() - (margin_v / 2),
		y = interact_bar:y() - (margin_v / 2),
		w = INTERACT_BAR_W + (margin_v),
		h = INTERACT_BAR_H + (margin_v),
		layer = 1,
		visible = true
	})
	
	
	--todo decimal precision option
	local interact_progress = interact_bar_panel:text({
		name = "interact_progress",
		text = "420s",
		align = "center",
		vertical = "bottom",
		color = self.color_data.hud_vitalsoutline_blue,
		font = tweak_data.hud.medium_font_noshadow,
		font_size = self._INTERACTION_FONT_SIZE,
		layer = 5
	})

end

function NobleHUD:ShowInteract(data)
	local interact_panel = self._interact_panel
	local interact_name = interact_panel:child("interact_name")
	self:animate_stop(interact_name)
	interact_name:set_font_size(self._INTERACTION_FONT_SIZE)
	if not interact_name:visible() then 
		self:animate(interact_name,"animate_killfeed_text_in",nil,0.15,self._INTERACTION_FONT_SIZE or interact_name:font_size(),self.color_data.hud_text_blue,self.color_data.hud_text_flash)
	end
	local text = data.text or "Press $INTERACT to interact"
	interact_name:set_text(text)
	interact_name:show()
end

function NobleHUD:HideInteract()
	self._interact_panel:child("interact_name"):hide()
	self._interact_panel:child("invalid_text"):hide()
end

function NobleHUD:ShowInteractBar(current,total)
	local interact_bar_panel = self._interact_panel:child("interact_bar_panel")
	self:animate_stop(interact_bar_panel)
	self.cb_animate_interact_done()
	self:SetInteractProgress(current,total)
	interact_bar_panel:show()
end

function NobleHUD:SetInteractProgress(current,total)
	self._interact_panel:child("interact_bar_panel"):child("interact_progress"):set_text(string.format("%0.01fs",math.abs(total - current) or -99.99))
	self:animate_interact_progress(self._interact_panel:child("interact_bar_panel"):child("interact_bar"),Application:time(),nil,Application:time() - (total - current),total)
end

function NobleHUD:HideInteractBar(complete)
	local anim_enabled = true
	local interact_bar_panel = self._interact_panel:child("interact_bar_panel")
	if complete and anim_enabled then 
		interact_bar_panel:child("interact_progress"):set_text(managers.localization:text("noblehud_hud_interaction_complete"))
		self:animate(interact_bar_panel,"animate_interact_done",self.cb_animate_interact_done,0.66,interact_bar_panel:child("interact_bg"):right() or self._INTERACT_BAR_PANEL_W)
	else
		interact_bar_panel:hide()
	end
	--todo animate on completed interaction
end

function NobleHUD:SetInteractValid(valid,text_id)
	local interact_panel = self._interact_panel
	local interact_name = interact_panel:child("interact_name")
	local invalid_text = interact_panel:child("invalid_text")
	invalid_text:set_visible(not valid)
	if text_id then 
		invalid_text:set_text(managers.localization:to_upper_text(tostring(text_id)))
	end
end

function NobleHUD.cb_animate_interact_done()
	local interact_panel = NobleHUD._interact_panel
	local interact_bar_panel = NobleHUD._interact_panel:child("interact_bar_panel")
	interact_bar_panel:hide()
	interact_bar_panel:set_size(NobleHUD._INTERACT_BAR_PANEL_W,NobleHUD._INTERACT_BAR_PANEL_H)	
	interact_bar_panel:set_position((interact_panel:w() - NobleHUD._INTERACT_BAR_PANEL_W) / 2,NobleHUD._INTERACT_BAR_Y + ((interact_panel:h() - NobleHUD._INTERACT_BAR_PANEL_H) / 2))
end

function NobleHUD:animate_interact_done(o,t,dt,start_t,duration,orig_w)
	if t >= start_t + duration then 
		return true
	end
	local ratio = math.clamp((t - start_t) / duration,0,1)
	local ratio_sq = 1 - math.pow(ratio,2)
--	Console:SetTrackerValue("trackera",ratio_sq)
	o:set_w(orig_w * ratio_sq)
--	o:set_x((o:parent():w() - o:w()) / 2)
	
--[[
--	local floating_panel = o:child("floating_panel")
	local ratio = (t - start_t) / duration
	if ratio >= 1 then 
		o:set_w(start_w)
		o:child("floating_panel"):child("interact_progress"):set_text("")
		return true
	end
	o:set_w(start_w * (1 - math.pow(ratio,2)))
	--]]
end

function NobleHUD:animate_interact_progress(o,t,dt,start_t,duration)
	local end_time = start_t + duration
	local time_left = end_time - t
	local progress = time_left / duration
	--y = sin(mod(4x,pi/2))
	local t_adjusted = t - start_t
	local color_bg = Color.black
	local color_tip = Color.white
	local color_progress_1 = Color("00315c")
	local color_progress_2 = self.color_data.hud_blueoutline
	
	local here = progress - 0.01
--[[
--todo pulse n times, where n is calculated from duration
	local time_speed = 1
	local phase_wax = 2.5
	local phase_wane = 1
	local phase_total = phase_wax + phase_wane
	
	local t_adjusted = ((t - start_t) * time_speed) % phase_total
	
	
	local here
	if t_adjusted <= phase_wax then 
		here = t_adjusted / duration
	else
		here = progress - 0.01
		color_progress_2 = self.interp_colors(color_progress_2,color_progress_1,math.max(1,(time_speed - phase_wane) / phase_wax))
	end
--]]	
	
	
	
--	local here = ((duration / time_left) * ((1 - (math.sin((t_adjusted * 180 / 10)) % 1)))) % progress
	


--	local here = (0.5 + (math.cos((t_adjusted * 180) % 180) / 2)) % progress
--	local here = math.cos(math.deg(t_adjusted % math.deg(math.pi))/2) * progress * rotations
	--local here = 1 - (math.sin((60 * now) % 60) * (1 - progress))
--	Console:SetTrackerValue("trackera",here)
--	Console:SetTrackerValue("trackerb",progress)
	o:set_gradient_points({
		0,
		color_progress_1,-- self.color_data.hud_bluefill,
		math.clamp(here,0,1),
		color_progress_2,
		progress,
		color_tip,
		progress + 0.01,
		color_bg,
		1,
		color_bg
	})
	
end



-- 		KILLFEED

function NobleHUD:_create_killfeed(hud)
	local killfeed_panel = hud:panel({
		name = "killfeed_panel",
		h = hud:w() / 2,
		alpha = self:GetHUDAlpha()
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

function NobleHUD:AddMedalFromData(data,category)
		--direct reference to table passed here
	local killfeed = self._killfeed_panel
	if not (data and data.icon_xy) then 
--		self:log("ERROR: bad data to AddMedalFromData(" .. tostring(data) .. ")")
		return
	elseif data.disabled then 
--		self:log("Did not add medal " .. tostring(category) .. " (disabled)")
		return
	end
		
	if data.sfx then 
		if data.hold_sfx and not self:IsAnnouncerFranticEnabled() then --for tiered medals, in order to not list every medal tier up to the current spree/multikill 
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
				local center_x,center_y = o:center()
				NobleHUD:animate(o,"animate_killfeed_icon_pulse",nil,0.3,icon_size,1.5,center_x,center_y)
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

function NobleHUD:animate_killfeed_icon_pulse(o,t,dt,start_t,duration,icon_size,pulse_multiplier,center_x,center_y,...)
	duration = duration or 0.25
	icon_size = icon_size or 24
	pulse_multiplier = (pulse_multiplier or 2) - 1
	
	local ratio = (t - start_t) * (1/duration)
	local sine = math.max(0,math.sin(math.deg(math.pi * ratio)))
	local size = icon_size * (1 + (pulse_multiplier * sine))
	if start_t + duration < t then 
		if center_x and center_y then 
			o:set_center(center_x,center_y)
		end
		o:set_size(icon_size,icon_size)
		return true
	else
		if center_x and center_y then 
			o:set_center(center_x,center_y)
		end
		o:set_size(size,size)
	end
end


--		CHAT

function NobleHUD:SetChatVisible(state)
	local hudchat = managers.hud._hud_chat
	local panel = hudchat._panel
	local bg = panel:child("noblehud_chat_bg")
	if state == nil then 
		state = self._cache.chat_wanted --or not panel:visible()
	end
	local duration = 0.5
	local output = panel:child("output_panel")
	self:animate_stop(bg)
	if state then
--		panel:show()
		output:stop()
		
		output:animate(callback(hudchat, hudchat, "_animate_show_component"), output:alpha())
--		panel:child("output_panel"):animate(callback(hudchat,hudchat,"_animate_fade_output"))
		bg:show()
		self:animate(bg,"animate_fadein",nil,duration,0.5)
		
--		self:animate(panel,"animate_fadein",nil,0.33)
	else
		output:stop()
		output:animate(callback(hudchat, hudchat, "_animate_fade_output_immediate"))
		self:animate(bg,"animate_fadeout",function(o)
				o:hide()
			end,
			duration,
			bg:alpha()
		)
--		self:animate(panel,"animate_fadeout",function(o) o:hide() end,0.33)
		--	panel:set_visible(state)
	end
end

function NobleHUD:DoChatNotification(state)
	local hudchat = managers.hud._hud_chat._panel
	local icon = hudchat:child("new_message_icon")
	local bg = hudchat:child("noblehud_chat_bg")
	if state then 
		icon:show()
		self:animate(icon,"animate_blink_time",function(o)
				o:hide()
				o:set_alpha(self:GetHUDAlpha())
			end,
			4,
			0.5,
			-1
		)
			
	else
		self:animate(icon,"animate_fadeout",function(o)
				o:hide()
				o:set_alpha(self:GetHUDAlpha())
			end,
			0.5
		)
	end
end

function NobleHUD:ClearChatNotification()
	self:DoChatNotification(false)
	self:RemoveDelayedCallback("autohide_chat")
end


--		WAITING

function NobleHUD:_create_waiting(hud)
	local waiting_panel = hud:panel({
		name = "waiting_panel",
		w = 256,
		h = 48,
		layer = 10,
		visible = false
	})
	
	local waiting_icon = waiting_panel:bitmap({
		name = "waiting_icon",
		texture = "guis/textures/pd2/hud_icon_objectivebox",
		x = 0,
		y = 0,
		w = 24,
		h = 24,
		layer = 0,
		blend_mode = "normal",
		halign = "left",
		valign = "top"
	})
	local waiting_text = waiting_panel:text({
		name = "waiting_text",
		text = "",
		x = 24 + 4,
		font_size = tweak_data.hud_players.name_size,
		font = tweak_data.hud_players.name_font
	})
	
	local waiting_blur = waiting_panel:bitmap({
		name = "waiting_blur",
		texture = "guis/textures/test_blur_df",
		layer = -1,
		render_template = "VertexColorTexturedBlur3D",
		valign = "grow"		
	})
	
	local waiting_bg = waiting_panel:rect({
		name = "waiting_bg",
		visible = false,
		layer = -2,
		color = Color(0.5,0.5,0.5),
		alpha = 0.8
	})
	
	NobleHUD._waiting_panel = waiting_panel
end


--		BUFFS

function NobleHUD:_create_buffs(hud) --buffs, cloned from khud (not implemented)
	local buffs_panel = hud:panel({
		name = "buffs_panel",
		alpha = self:GetHUDAlpha()
	})
	local debug_buffs = buffs_panel:rect({
		name = "debug_buffs",
		color = Color.green,
		visible = false,
		alpha = 0.1
	})
	self._buffs_panel = buffs_panel
end

function NobleHUD:LayoutBuffPanel()
	if self._buffs_panel and alive(self._buffs_panel) then 
		self._buffs_panel:set_position(self:GetBuffXY())
		self._buffs_panel:set_size(self:GetBuffWH())
	end
end

function NobleHUD:AddBuff(id,params)
	if not self:IsBuffTrackerEnabled() then 
		return
	end
	params = params or {}

	
	local buff_tweak_data = self._buff_data[id]
	if not buff_tweak_data then 
		self:log("AddBuff(" .. tostring(id) .. "): Bad buff!",{color=Color.red})
		return
	elseif buff_tweak_data.disabled then 
		self:log("AddBuff(" .. tostring(id) .. "): Buff is disabled!",{color=Color.red})
		return
	elseif not self:IsBuffEnabled(id) then 
		self:log("AddBuff(" .. tostring(id) .. "): Buff is disabled due to user pref!",{color=Color.red})
		return
	end
	if buff_tweak_data.value_type == "timer" then
		if not (params.end_t or params.duration) then 
			if buff_tweak_data.duration then 
				params.duration = buff_tweak_data.duration
			else
				self:log("AddBuff(" .. tostring(id) .. ") Buff data has no end_t or duration! Removing...",{color=Color.red})
				return
			end
		end
		local t = Application:time()
		local timer_source = buff_tweak_data.timer_source
		if timer_source then 
			if timer_source == "heist" then 
				t = managers.game_play_central:get_heist_timer()
			elseif timer_source == "game" then 
				t = TimerManager:game():time()
			elseif timer_source == "player" then 
				t = managers.player:player_timer():time()
			end
		end
		params.end_t = params.end_t or (t + params.duration)
	end
	
	local buffs_panel = self._buffs_panel
	if alive(buffs_panel) and alive(buffs_panel:child(id)) then
		--already exists
--		local buff,index,panel
--		buff,index = self:GetBuff(id)
		local _,index = self:GetBuff(id)
		if index and self._active_buffs[index] then 
--			self:log("Updating existing buff " .. tostring(id) .. ", index " .. tostring(index),{color=Color.red})
			for k,v in pairs(params) do 
				self._active_buffs[index][k] = v
			end
			return
		else
			self:log("ERROR: AddBuff(" .. tostring(id) .. ") index " .. tostring(index) .. ": no buff found, removing dead panel",{color=Color.red})
			buffs_panel:remove(buffs_panel:child(id))
		end
	end
	
	local panel = self:CreateBuff(id,params)
	if panel then 
		self:log("Adding Buff " .. tostring(id) .. ": " .. NobleHUD.table_concat(params,",","="))
		params.panel = panel
		params.id = id
		local index
		if #self._active_buffs > 0 then 
			local priority = buff_tweak_data.priority
			for i,v in ipairs(self._active_buffs) do 
				local buff_data = self._buff_data[tostring(v.id)] 
				if buff_data.priority and buff_data.priority <= priority then 
					index = i + 1
				else 
					break
				end
			end
		end
		if index then
			table.insert(self._active_buffs,math.clamp(index,1,#self._active_buffs + 1),params)
		else
			table.insert(self._active_buffs,#self._active_buffs + 1,params)
		end
	else
		self:log("AddBuff(" .. tostring(id) .. "): could not create panel. Aborting AddBuff()",{color=Color.red})
		return
	end
	--[[
	--check validity of buff id and data
	if self._active_buffs[id] then 
		--refresh
--		self:SetBuff(id,params)
		self._active_buffs[id] = params
	elseif panel then 
		self._active_buffs[id] = params
	else
		self:log("AddBuff(" .. tostring(id) .. "): could not create panel",{color=Color.red})
		return 
	end
	--]]
end

function NobleHUD:CreateBuff(id,params)
	local buffs_panel = self._buffs_panel
	if alive(buffs_panel:child(id)) then 
--		self:log("CreateBuff(" .. tostring(id) .. "," .. NobleHUD.table_concat(params,",","=") .. "): Buff element already exists!",{color=Color.red})
--		buffs_panel:remove(buffs_panel:child(id))
		return buffs_panel:child(id)
	end
	local buff_data = self._buff_data[id]
	if not buff_data then 
		self:log("Bad buff to CreateBuff(" .. tostring(id) .. "," .. NobleHUD.table_concat(params,",","=") .. ")",{color=Color.red})
		return
	end
	local buff_w,buff_h = self:GetBuffItemSize()
	
	local icon_size = buff_h
	local font_size = buff_h / 2
	local icon = buff_data.icon or "mugshot_normal"
	local source = buff_data.source
	local icon_tier = buff_data.icon_tier --for perk decks
	local tier_floors = buff_data.tier_floors --max_tier but with a whitelist/fallback
	
	local render_template = buff_data.render_template
	
	local text_color = params.text_color or buff_data.text_color or Color.white
	local icon_color = params.icon_color or buff_data.icon_color or Color.white
	local label = buff_data.label
	local blend_mode = buff_data.blend_mode or "add" --not specified for the vast majority of buffs
	
	local texture_rect = {0,0,64,64}
	local skill_atlas = "guis/textures/pd2/skilltree/icons_atlas"
	local skill_atlas_2 = "guis/textures/pd2/skilltree_2/icons_atlas_2"
	local perkdeck_atlas = "guis/textures/pd2/specialization/icons_atlas"	
	
	if source == "skill" then 
		texture = skill_atlas_2
		local icon_x,icon_y = unpack(tweak_data.skilltree.skills[icon].icon_xy)
		texture_rect = {icon_x * 80,icon_y * 80,80,80}
	elseif source == "perk" then 
		texture,texture_rect = self.get_specialization_icon_data_with_fallback(tonumber(icon),nil,icon_tier,tier_floors)
	elseif source == "icon" then 
		texture,texture_rect = tweak_data.hud_icons:get_icon_data(icon)
	elseif source == "manual" then
		texture = icon
		texture_rect = icon_rect
	else
		texture = "guis/textures/ability_circle_fill"
		texture_rect = nil
	end
	
	local buff_x = 0
	local buff_y = 0
	local buff_align = self:GetBuffPanelAlign()
	local buff_vertical = self:GetBuffPanelVertical() 
	if buff_align == "left" then 
		buff_x = 0
	elseif buff_align == "center" then
		buff_x = (buffs_panel:w() - buff_w) / 2
	elseif buff_align == "right" then 
		buff_x = buffs_panel:w() - buff_w
	end
	if buff_vertical == "top" then 
		buff_y = 0
	elseif buff_vertical == "center" then 
		buff_y = (buffs_panel:h() - buff_h) / 2
	elseif buff_vertical == "bottom" then 
		buff_y = buffs_panel:h() - buff_h
	end
	local buff_panel = buffs_panel:panel({
		name = tostring(id),
		x = buff_x,
		y = buff_y,
		w = buff_w,
		h = buff_h
	})
	
	local buff_icon = buff_panel:bitmap({
		name = "icon",
		w = icon_size,
		h = icon_size,
		texture = texture,
		texture_rect = texture_rect,
		render_template = render_template,
		blend_mode = blend_mode,
		color = icon_color
	})
	--NobleHUD:AddBuff("messiah_charge")
	local buff_timer_text = ""
	if params.duration then 
		buff_timer_text = self.format_seconds(params.duration)
	elseif params.end_t then 
		buff_timer_text = self.format_seconds(params.end_t - Application:time())
	elseif params.start_t then 
		buff_timer_text = self.format_seconds(Application:time() - params.start_t)
	end
	
	
	local buff_text = managers.localization:text(label)
	buff_text = string.gsub(buff_text,"$TIMER",buff_timer_text)
	buff_text = string.gsub(buff_text,"$VALUE",params.value or "")
	local buff_label = buff_panel:text({
		name = "label",
		layer = 3,
		font_size = font_size,
		font = tweak_data.hud_players.ammo_font,
		text = self:IsBuffCompactMode() and buff_timer_text or buff_text,
		x = buff_icon:right() + 4,
		align = "left",
		vertical = "center",
		color = text_color
	})
	local debug_buff = buff_panel:rect({
		name = "debug_buff",
		color = Color(math.random(),math.random(),math.random()),
		alpha = 0.25,
		visible = false
	})
	return buff_panel
end

function NobleHUD:RemoveBuff(id,index)
	local buff
	if index and self._active_buffs[index] then 
		buff = self._active_buffs[index]
	else
		for i,buff_data in pairs(self._active_buffs) do 
			if buff_data.id == id then 
				buff = buff_data
				index = i
				break
			end
		end
	end
	
	if buff then 
		id = tostring(buff.id)
		local panel = buff.panel or self._buffs_panel:child(id)
		if panel and alive(panel) then 
			panel:parent():remove(panel)
		end
		table.remove(self._active_buffs,index)
	end
end

function NobleHUD:UpdateBuffs() --not used
	local t = TimerManager:game():time()
end

function NobleHUD:ClearBuffs()
	for i,buff_data in pairs(self._active_buffs) do 
		local id = tostring(buff_data.id)
		local panel = self._buffs_panel and self._buffs_panel:child(id)
		if panel and alive(panel) then 
			self._buffs_panel:remove(panel)
		end
		table.remove(self._active_buffs,i)
		self:log("ClearBuffs(): Removing buff " .. tostring(id) .. "...")
	end
end

function NobleHUD:ToggleBuff(state,id,...) --really just a shortcut for menu callbacks
	if state then 
		self:AddBuff(id,...)
	else
		self:RemoveBuff(id,...)
	end
end

function NobleHUD:GetBuff(id,index)
	if index then 
		return self._active_buffs[index],index
	else
		for i,buff_data in pairs(self._active_buffs) do 
			if buff_data.id == id then 
				return buff_data,i
			end
		end
	end
end

function NobleHUD:CheckBuff(id) --again mostly used for menu callbacks
	if not self:IsBuffEnabled(id) then 
		self:RemoveBuff(id)
		return false
	end
end


--		HELPER (not implemented)

function NobleHUD:_create_helper(hud) --auntie dot avatar and subtitles
	local helper_panel = hud:panel({
		name = "helper_panel",
		layer = 1,
		w = 400,
		h = 400,
		x = hud:right() - 400,
		y = hud:bottom() - 400,
		alpha = self:GetHUDAlpha(),
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

--[[
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

function NobleHUD:_add_convert(params)
--todo
end
function HUDManager:_set_helper_pattern(pattern_name)
	local pattern = NobleHUD._helper_patterns_even[pattern_name or NobleHUD._current_helper_pattern or "dot"]
--	local pattern = NobleHUD._helper_patterns[pattern_name]
	if pattern then 
		local changed_tubes = {}
		local center_r = math.floor((NobleHUD._HELPER_ROWS - 8) / 2) + 1
		local center_c = math.floor((NobleHUD._HELPER_COLUMNS - 8) / 2) + 1
	--do row and column offsets based on grid size
		for row,c in pairs(pattern) do 
			for _,column in pairs(c) do 
				local tube_name = "tube_" .. (row + center_r) .. "_" .. (column + center_c)
				local tube = NobleHUD._helper_panel:child(tube_name)
				if tube then 
					changed_tubes[tube_name] = true
					tube:stop()
					tube:animate(callback(self,self,"_animate_helper_tube_on"))
				end
			end
		end
		
		for k,v in pairs(NobleHUD._helper_tubes) do 
			if v.tube then 
				if not changed_tubes[v.tube:name()]then 
					v.tube:stop()
					v.tube:animate(callback(self,self,"_animate_helper_tube_off"))
				end
			end
		end
	end
end

function HUDManager:_set_helper_sequence()
	NobleHUD._helper_last_sequence = math.max(1,(1 + NobleHUD._helper_last_sequence) % #NobleHUD._helper_sequences)
	local pattern_name = NobleHUD._helper_last_sequence

	local pattern = NobleHUD._helper_sequences[pattern_name or ""]
	if pattern then 
		local changed_tubes = {}
		local center_r = math.floor((NobleHUD._HELPER_ROWS - 10) / 2)
		local center_c = math.floor((NobleHUD._HELPER_COLUMNS - 10) / 2) + 1
	--do row and column offsets based on grid size
		for row,c in pairs(pattern) do 
			for _,column in pairs(c) do 
				local tube_name = "tube_" .. (row + center_r) .. "_" .. (column + center_c)
				local tube = NobleHUD._helper_panel:child(tube_name)
				if tube then 
					changed_tubes[tube_name] = true
					tube:stop()
					tube:animate(callback(self,self,"_animate_helper_tube_on_fast")) --non-flicker is broken. great
				end
			end
		end
		
		for k,v in pairs(NobleHUD._helper_tubes) do 
			if v.tube then 
				if not changed_tubes[v.tube:name()]then 
					v.tube:stop()
					v.tube:animate(callback(self,self,"_animate_helper_tube_off_fast"))
				end
			end
		end
	end
end


function HUDManager:_animate_dot_tube_off_broken(tube) --broken
	
	local MAX_ALPHA = 0.2

	local duration = 1
	local elapsed = 0
	local tube_color = tube:color()
	local desired_color = Color((0.1 * math.random()),0.25 + (math.random() * 0.15),0.9 + (0.1 * math.random()))
	local tube_alpha = tube:alpha()
	while elapsed < duration do 
		local dt = coroutine.yield()
		elapsed = elapsed + dt
		tube:set_alpha(tube_alpha + ((MAX_ALPHA - tube_alpha) * (elapsed / duration)))
		tube:set_color(NobleHUD.interp_colors(tube_color,desired_color,elapsed/duration))
	end
	tube:set_alpha(MAX_ALPHA)
	
end

function HUDManager:_animate_dot_tube_interp(tube) --why doesn't this work
	if (not NobleHUD._selected_tube) or (math.random() > 0.75) then
		NobleHUD._selected_tube = tube --todo reset tube at some point
	end
	local duration = 1
	local elapsed = 0
	local tube_alpha = tube:alpha()
	local tube_color = tube:color()
	local MIN_ALPHA = 0.95
	local desired_color = Color(math.random(155)/255,math.random(209)/255,math.random(255)/255)
	local rate = 1.4
	
	while elapsed < duration do 
--		Console:SetTrackerValue("trackera",elapsed)
		local dt = coroutine.yield()
--		Console:SetTrackerValue("trackerb",dt)
		elapsed = elapsed + dt
		tube:set_alpha(tube_alpha + ((MIN_ALPHA - tube_alpha) * (elapsed / duration)))
		tube:set_color(NobleHUD.interp_colors(tube_color,desired_color,elapsed/duration))
	end
	NobleHUD:log("elapsed: " .. tostring(elapsed) .. "," .. "duration: " .. tostring(duration))
	tube:set_alpha(1)
	
end

function HUDManager:_animate_dot_tube_on_broken(tube) --broken
	if (not NobleHUD._selected_tube) or (math.random() > 0.75) then
		NobleHUD._selected_tube = tube --todo reset tube at some point
	end
	local t = 1
	local tube_alpha = tube:alpha()
	local tube_color = tube:color()
	local MIN_ALPHA = 0.95
	local desired_color = Color(math.random(155)/255,math.random(209)/255,math.random(255)/255)
	local rate = 1.4
	
	while t > 0 do 
		local dt = coroutine.yield()
		t = t - dt
--		Console:SetTrackerValue("trackera",t)
--		Console:SetTrackerValue("trackerb",dt)
		tube:set_alpha(tube_alpha + ((MIN_ALPHA - tube_alpha) * t))
		tube:set_color(NobleHUD.interp_colors(tube_color,desired_color,t))
	end
	tube:set_alpha(1)
	
end

function HUDManager:_animate_helper_tube_on_fast(tube) --reduced delay; used for sequence
	if (not NobleHUD._selected_tube) or (math.random() > 0.75) then
		NobleHUD._selected_tube = tube --todo reset tube when
	end
	local MIN_ALPHA = 0.95
	local delay = 0 --math.random() / 10
	local tube_alpha = tube:alpha()
	local desired_color = Color(159/255,210/255,255/255)--Color(math.random(155)/255,math.random(209)/255,math.random(255)/255)
	local rate = 2
	
	while tube_alpha < MIN_ALPHA do --slight flicker when alpha jumps from MIN_ALPHA to 1
		local dt = coroutine.yield()
		if delay <= 0 then 
			tube_alpha = (tube_alpha + 0.15) * rate
			tube:set_alpha(tube_alpha)
--			NobleHUD:log(tube:name() .. "," .. dt)
			tube:set_color(NobleHUD.interp_colors(tube:color(),desired_color,0.5)) --gradually progress toward "lit" color; effectively a logarithmic function
--			tube:set_color(NobleHUD.interp_colors(tube:color(),desired_color,dt * 1.5)) --gradually progress toward "lit" color; effectively a logarithmic function
		else
			delay = delay - dt
		end
	end
	tube:set_alpha(1)
	
end

function HUDManager:_animate_helper_tube_off_fast(tube) --reduce delay; used for sequence
	
	local MAX_ALPHA = 0.2
	local delay = 0 -- math.random() / 10

	local current_color = tube:color()
	local desired_color = Color((0.1 * math.random()),0.25 + (math.random() * 0.15),0.9 + (0.1 * math.random()))
	local tube_alpha = tube:alpha()
	tube:set_color(desired_color)
	while tube_alpha > MAX_ALPHA do
		local dt = coroutine.yield()
		if delay <= 0 then 
			tube_alpha = tube_alpha * 0.5
			tube:set_alpha(tube_alpha)
		else
			delay = delay - dt
		end
	end
	tube:set_alpha(MAX_ALPHA)
	
end

function HUDManager:_animate_helper_tube_on(tube)
	if (not NobleHUD._selected_tube) or (math.random() > 0.75) then
		NobleHUD._selected_tube = tube --todo reset tube when
	end
	local MIN_ALPHA = 0.95
	local delay = math.random()
	local tube_alpha = tube:alpha()
	local desired_color = Color(math.random(155)/255,math.random(209)/255,math.random(255)/255)
	local rate = 1.2
	
	while tube_alpha < MIN_ALPHA do --slight flicker when alpha jumps from MIN_ALPHA to 1
		local dt = coroutine.yield()
		if delay <= 0 then 
			tube_alpha = tube_alpha * rate
			tube:set_alpha(tube_alpha)
			tube:set_color(NobleHUD.interp_colors(tube:color(),desired_color,dt * 1.5)) --gradually progress toward "lit" color; effectively a logarithmic function
		else
			delay = delay - dt
		end
	end
	tube:set_alpha(1)
	
end

function HUDManager:_animate_helper_tube_off_nice(tube)
	
	local MAX_ALPHA = 0.15
	local delay = (math.random() * 1.25) + 1
	
	local tube_alpha = tube:alpha()
	while tube_alpha > MAX_ALPHA do
		local dt = coroutine.yield()
		if delay <= 0 then 
			tube_alpha = tube_alpha * 0.9
			tube:set_alpha(tube_alpha)
		else
			delay = delay - dt
		end
	end
	tube:set_alpha(0.2) --normal max alpha
	
end

function HUDManager:_animate_helper_tube_off(tube)
	
	local MAX_ALPHA = 0.2
	local delay = math.random()

	local current_color = tube:color()
	local desired_color = Color((0.1 * math.random()),0.25 + (math.random() * 0.15),0.9 + (0.1 * math.random()))
	local tube_alpha = tube:alpha()
	while tube_alpha > MAX_ALPHA do
		local dt = coroutine.yield()
		if delay <= 0 then 
			tube_alpha = tube_alpha * 0.8
			tube:set_alpha(tube_alpha)
--			tube:set_color(
		else
			delay = delay - dt
		end
	end
	tube:set_alpha(MAX_ALPHA)
	
end

function HUDManager:_set_helper_all_off()
	for k,v in pairs(NobleHUD._helper_tubes) do 
		if v.tube then 
			v.tube:stop()
			v.tube:animate(callback(self,self,"_animate_helper_tube_off"))
		end
	end
end

function HUDManager:_set_helper_all_on()
	for k,v in pairs(NobleHUD._helper_tubes) do 
		if v.tube then 
			v.tube:stop()
			v.tube:animate(callback(self,self,"_animate_helper_tube_on"))
		end
	end
end

function HUDManager:_set_helper_off_nice() --todo randomly select highlighted tube when turn on, instead of random method
	--get one from somewhere in the middle four rows/columns
--	local row = math.random(4)
--	local column = math.random(4)
--	local selected = math.random(#Console._tubes)
	for k,v in pairs(NobleHUD._helper_tubes) do 
		if v.tube then 
			v.tube:stop()
			if NobleHUD._selected_tube and NobleHUD._selected_tube:name() == v.tube:name()  then 
				v.tube:animate(callback(self,self,"_animate_helper_tube_off_nice"))
			else
				v.tube:animate(callback(self,self,"_animate_helper_tube_off"))
			end
		end
	end
end
--]]




Hooks:Add("NetworkReceivedData", "noblehud_onreceiveluanetworkingmessage", function(sender, message, data)
	local panel_id = NobleHUD:GetPanelIdFromPeerId(sender)
	if (message == NobleHUD.network_messages.sync_assault) then
		if (sender == 1) and NobleHUD._assault_phases[data] then 
			NobleHUD:SetAssaultPhase(managers.localization:text(NobleHUD._assault_phases[data]),false)
		end
	elseif (message == NobleHUD.network_messages.down_counter) then
		--set downs here
		NobleHUD:SetTeammateDowns(sender,tonumber(data),panel_id,false)
	elseif (message == NobleHUD.network_messages.sync_callsign) then
		local peer = managers.network:session():peer(sender)
		if peer then 
			--incoming callsign validity check
			data = utf8.to_upper(string.gsub(data,"+W%",""))
			local callsign_len = string.len(data)
			if callsign_len < NobleHUD._MIN_CALLSIGN_LEN then 
				--callsign is invalid bc it's too short
				return
			end
			if callsign_len > NobleHUD._MAX_CALLSIGN_LEN then --callsign is too long
				data = string.sub(data,1,NobleHUD._MAX_CALLSIGN_LEN) -- snip snip motherfucker
			end
			
			
			
			local id64 = peer:user_id()
			if id64 then
				NobleHUD._cache.callsigns[id64] = data
			end
		end
		if managers.hud and panel_id then
			NobleHUD:_set_teammate_name(panel_id,data)
			NobleHUD:_set_teammate_waypoint_name(sender,data)
		end
		--stuff
	elseif (message == NobleHUD.network_messages.sync_teamname) then
		if sender == 1 then
			--parse color and data from this mess
			--[[
			local teamdata = string.split(data,":")
			local team_name,team_color
			if teamdata and #teamdata >= 1 then 
				team_name = teamdata[1]
				local r = tonumber(teamdata[2] or "")
				local g = tonumber(teamdata[3] or "")
				local b = tonumber(teamdata[4] or "")
				if r and g and b then 
					team_color = Color(r,g,b):with_alpha(1)
				end
			end
			--]]
			NobleHUD:SetTeamName(data)
		end
	end
end)

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

Hooks:Add("MenuManagerInitialize", "noblehud_initmenu", function(menu_manager)
		
--CHAT 

	--keybind
	MenuCallbackHandler.callback_noblehud_toggle_chat = function(self)
		if managers.hud and managers.hud._hud_chat and managers.hud._hud_chat._panel then
			NobleHUD._cache.chat_wanted = not NobleHUD._cache.chat_wanted
			NobleHUD:SetChatVisible(NobleHUD._cache.chat_wanted)
			NobleHUD:ClearChatNotification()
			if NobleHUD:GetChatAutohideMode() == 2 then 
				NobleHUD:AddDelayedCallback(function()
						NobleHUD._cache.chat_wanted = false
						NobleHUD:DoChatNotification(false)
						NobleHUD:SetChatVisible(false)
					end,nil,NobleHUD:GetChatAutohideTimer(),"autohide_chat"
				)
			end
		end
	end	
	MenuCallbackHandler.callback_noblehud_set_chat_notification_sfx = function(self,item)
		local value = tonumber(item:value())
		NobleHUD.settings.chat_notification_sfx = value
		local notif_sfx = NobleHUD.chat_notification_sounds[value]
		if notif_sfx then 
			NobleHUD:AddDelayedCallback(function()
				XAudio.Source:new(XAudio.Buffer:new(NobleHUD._mod_path .. "assets/snd/ui/" .. notif_sfx))
			end,nil,0.5,"test_chat_sfx",true)
		end
		NobleHUD:SaveSettings()
	end		
	MenuCallbackHandler.callback_noblehud_set_chat_timestamp_mode = function(self,item)
		local value = tonumber(item:value())
		NobleHUD.settings.chat_timestamp_mode = value
		NobleHUD:SaveSettings()
	end		
	MenuCallbackHandler.callback_noblehud_test_chat_notification_sfx = function(self)
		local notif_sfx = NobleHUD.chat_notification_sounds[NobleHUD:GetChatNotificationSound()]
		if notif_sfx then 
			NobleHUD:AddDelayedCallback(function()
				XAudio.Source:new(XAudio.Buffer:new(NobleHUD._mod_path .. "assets/snd/ui/" .. notif_sfx))
			end,nil,0.5,"test_chat_sfx",true)
		end
	end	
	MenuCallbackHandler.callback_noblehud_set_chat_notification_sound_enabled = function(self,item)
		NobleHUD.settings.chat_notification_sound_enabled = item:value() == "on"
		NobleHUD:SaveSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_chat_notification_icon_enabled = function(self,item)
		NobleHUD.settings.chat_notification_icon_enabled = item:value() == "on"
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_chat_notification_autoshow_enabled = function(self,item)
		NobleHUD.settings.chat_autoshow_enabled = item:value() == "on"
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_chat_autohide_mode = function(self,item)
		local value = tonumber(item:value())
		NobleHUD.settings.chat_autohide_mode = value
		--[[
		if value == 1 and (managers.hud and managers.hud._hud_chat and managers.hud._hud_chat._panel then 
			NobleHUD:AddDelayedCallback(function()		
			end,NobleHUD:GetChatAutohideTimer(),"autohide_chat")
		end
		--]]
		NobleHUD:SaveSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_chat_autohide_timer = function(self,item)
		NobleHUD.settings.chat_autohide_timer = tonumber(item:value())
		NobleHUD:SaveSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_chat_panel_x = function(self,item)
		local value = tonumber(item:value())
		NobleHUD.settings.chat_panel_x = value
		if managers.hud._hud_chat and managers.hud._hud_chat._panel then 
			managers.hud._hud_chat._panel:set_x(value)
		end
		NobleHUD:SaveSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_chat_panel_y = function(self,item)
		local value = tonumber(item:value())
		NobleHUD.settings.chat_panel_y = value
		if managers.hud._hud_chat and managers.hud._hud_chat._panel then 
			managers.hud._hud_chat._panel:set_y(value)
		end
		NobleHUD:SaveSettings()
	end	
	MenuCallbackHandler.noblehud_chat_options_close = function(self)
		--
	end



--SCORE
	MenuCallbackHandler.callback_noblehud_set_score_display_mode = function(self,item)
		NobleHUD.settings.score_display_mode = tonumber(item:value())
		NobleHUD:SaveSettings()
		
		if NobleHUD:IsLoaded() then 
			if NobleHUD:GetScoreDisplayMode() == 1 then
				NobleHUD:SetScoreLabel(NobleHUD.make_nice_number(NobleHUD._cache.score_session))
			elseif NobleHUD:GetScoreDisplayMode() == 2 then 
				NobleHUD:SetScoreLabel(managers.experience:cash_string(managers.money:get_potential_payout_from_current_stage()))
			end
		end
	end		
	MenuCallbackHandler.callback_noblehud_set_popups_enabled = function(self,item)
		NobleHUD.settings.popups_enabled = item:value() == "on"
		NobleHUD:SaveSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_announcer_enabled = function(self,item)
		NobleHUD.settings.announcer_enabled = item:value() == "on"
		NobleHUD:SaveSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_announcer_frantic_enabled = function(self,item)
		NobleHUD.settings.announcer_frantic_enabled = item:value() == "on"
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
	
	
--RADAR
	MenuCallbackHandler.callback_noblehud_set_radar_enabled = function(self,item)
		NobleHUD.settings.radar_enabled = item:value() == "on"
		NobleHUD:SetRadarEnabled(NobleHUD.settings.radar_enabled)
	end
	MenuCallbackHandler.callback_noblehud_set_radar_style = function(self,item)
		NobleHUD.settings.radar_style = tonumber(item:value())
		NobleHUD:LayoutRadar()
	end
	MenuCallbackHandler.callback_noblehud_set_radar_scale = function(self,item)
		NobleHUD.settings.radar_scale = tonumber(item:value())
--		set radar size here
		NobleHUD:LayoutRadar()
	end
	MenuCallbackHandler.callback_noblehud_set_radar_x = function(self,item)
		NobleHUD.settings.radar_x = tonumber(item:value())
		NobleHUD:LayoutRadar()
	end
	MenuCallbackHandler.callback_noblehud_set_radar_y = function(self,item)
		NobleHUD.settings.radar_y = tonumber(item:value())
		NobleHUD:LayoutRadar()
	end
	MenuCallbackHandler.callback_noblehud_set_radar_align_horizontal = function(self,item)
		NobleHUD.settings.radar_align_horizontal = tonumber(item:value())
		NobleHUD:LayoutRadar()
	end
	MenuCallbackHandler.callback_noblehud_set_radar_align_vertical = function(self,item)
		NobleHUD.settings.radar_align_vertical = tonumber(item:value())
		NobleHUD:LayoutRadar()
	end
	MenuCallbackHandler.callback_noblehud_set_radar_distance = function(self,item)
		NobleHUD.settings.radar_distance = tonumber(item:value())
		NobleHUD:SetRadarDistance(NobleHUD.settings.radar_distance)
	end
	MenuCallbackHandler.callback_noblehud_radar_options_close = function(self)
		NobleHUD:SaveSettings()
	end

--WEAPONS
	MenuCallbackHandler.callback_noblehud_set_floating_ammo_enabled = function(self,item)
		local value = item:value() == "on"
		NobleHUD.settings.floating_ammo_enabled = value
		if managers.hud and alive(NobleHUD._floating_ammo_panel) then 
			NobleHUD._floating_ammo_panel:set_visible(item:value() == "on")
		end
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_weapon_ammo_real_counter_enabled = function(self,item)
		NobleHUD.settings.weapon_ammo_real_counter = item:value() == "on"
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.noblehud_weapons_options_close = function(self)
		--NobleHUD:SaveSettings()
	end

	
--PLAYER
	MenuCallbackHandler.callback_noblehud_set_master_hud_alpha = function(self,item)
		NobleHUD.settings.master_hud_alpha = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_callsign_string = function(self,item)
		NobleHUD:ShowMenu_SetCallsign()		
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_about_callsign_string = function(self,item)
		NobleHUD:ShowMenu_AboutCallsign()
	end
	
	MenuCallbackHandler.callback_noblehud_set_vitals_panel_scale = function(self,item)
		local value = tonumber(item:value())
		NobleHUD.settings.vitals_scale = value
		NobleHUD:LayoutVitals()
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_stamina_enabled = function(self,item)
		local value = item:value() == "on"
		NobleHUD.settings.stamina_enabled = value
		if alive(NobleHUD._stamina_panel) then 
			NobleHUD._stamina_panel:set_visible(value)
		end
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_stamina_panel_x = function(self,item)
		NobleHUD.settings.stamina_x = tonumber(item:value())
		NobleHUD:LayoutStamina()
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_stamina_panel_y = function(self,item)
		NobleHUD.settings.stamina_y = tonumber(item:value())
		NobleHUD:LayoutStamina()
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_ability_panel_align_to_radar = function(self,item)
		NobleHUD.settings.ability_align_to_radar = item:value() == "on"
		NobleHUD:LayoutAbility()
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_ability_panel_x = function(self,item)
		NobleHUD.settings.ability_x = tonumber(item:value())
		NobleHUD:LayoutAbility()
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_ability_panel_y = function(self,item)
		NobleHUD.settings.ability_y = tonumber(item:value())
		NobleHUD:LayoutAbility()
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_shield_empty_sound_enabled = function(self,item)
		local value = item:value() == "on"
		NobleHUD.settings.shield_empty_sound_enabled = value
		if not value then 
			NobleHUD:PlayShieldSound("shield_empty",value)
		end
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_shield_empty_sound_volume = function(self,item)
		local value = tonumber(item:value())
		NobleHUD.settings.shield_empty_sound_volume = value
		NobleHUD:CheckShieldSoundVolume("shield_empty",value)
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_shield_charge_sound_enabled = function(self,item)
		local value = item:value() == "on"
		NobleHUD.settings.shield_charge_sound_enabled = value
		if not value then 
			NobleHUD:PlayShieldSound("shield_charge",value)
		end
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_shield_charge_sound_volume = function(self,item)
		local value = tonumber(item:value())
		NobleHUD.settings.shield_charge_sound_volume = value
		NobleHUD:CheckShieldSoundVolume("shield_charge",value)
		NobleHUD:SaveSettings()
	end
	
	MenuCallbackHandler.callback_noblehud_set_shield_low_sound_enabled = function(self,item)
		local value = item:value() == "on"
		if not value then 
			NobleHUD:PlayShieldSound("shield_low",value)
		end
		NobleHUD.settings.shield_low_sound_enabled = value
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_shield_low_sound_volume = function(self,item)
		local value = tonumber(item:value())
		NobleHUD.settings.shield_low_sound_volume = value
		NobleHUD:CheckShieldSoundVolume("shield_low",value)
		NobleHUD:SaveSettings()
		if NobleHUD._shield_sound_source and NobleHUD._shield_sound_source._buffer == NobleHUD._cache.sounds.shield_low then
			NobleHUD._shield_sound_source:set_volume(value)
		end
	end

	MenuCallbackHandler.callback_noblehud_set_shield_low_threshold = function(self,item)
		NobleHUD.settings.shield_low_threshold = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_master_hud_alpha = function(self,item)
		NobleHUD.settings.master_hud_alpha = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.noblehud_player_options_close = function(self)
		--NobleHUD:SaveSettings()
	end
	
--TEAM
	MenuCallbackHandler.callback_noblehud_set_teammate_align_to_radar_enabled = function(self,item)
		NobleHUD.settings.teammate_align_to_radar = item:value() == "on"
		NobleHUD:_sort_teammates()
		NobleHUD:SaveSettings()
	end
	
	MenuCallbackHandler.callback_noblehud_set_teammate_panel_x = function(self,item)
		NobleHUD.settings.teammate_x = tonumber(item:value())
		NobleHUD:_sort_teammates()
	end
	MenuCallbackHandler.callback_noblehud_set_teammate_panel_y = function(self,item)
		NobleHUD.settings.teammate_y = tonumber(item:value())
		NobleHUD:_sort_teammates()
	end
	MenuCallbackHandler.noblehud_team_options_close = function(self)
		--
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
	MenuCallbackHandler.callback_noblehud_set_steelsight_hides_reticle_enabled = function(self,item)
		NobleHUD.settings.steelsight_hides_reticle_enabled = item:value() == "on"
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
	
--CROSSHAIR CHOICE BY WEAPON CATEGORY
	MenuCallbackHandler.callback_noblehud_crosshair_type_assaultrifle_single = function(self,item)
		NobleHUD.settings.crosshair_type_assaultrifle_single = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_crosshair_type_assaultrifle_auto = function(self,item)
		NobleHUD.settings.crosshair_type_assaultrifle_auto = tonumber(item:value())
		NobleHUD:SaveSettings()
	end	
	MenuCallbackHandler.callback_noblehud_crosshair_type_pistol_single = function(self,item)
		NobleHUD.settings.crosshair_type_pistol_single = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_crosshair_type_pistol_auto = function(self,item)
		NobleHUD.settings.crosshair_type_pistol_auto = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_crosshair_type_revolver = function(self,item)
		NobleHUD.settings.crosshair_type_revolver = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_crosshair_type_smg_single = function(self,item)
		NobleHUD.settings.crosshair_type_smg_single = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_crosshair_type_smg_auto = function(self,item)
		NobleHUD.settings.crosshair_type_smg_auto = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_crosshair_type_shotgun_single = function(self,item)
		NobleHUD.settings.crosshair_type_shotgun_single = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_crosshair_type_shotgun_auto = function(self,item)
		NobleHUD.settings.crosshair_type_shotgun_auto = tonumber(item:value())
		NobleHUD:SaveSettings()
	end	
	MenuCallbackHandler.callback_noblehud_crosshair_type_lmg_single = function(self,item)
		NobleHUD.settings.crosshair_type_lmg_single = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_crosshair_type_lmg_auto = function(self,item)
		NobleHUD.settings.crosshair_type_lmg_auto = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_crosshair_type_snp = function(self,item)
		NobleHUD.settings.crosshair_type_snp = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_crosshair_type_rocket = function(self,item)
		NobleHUD.settings.crosshair_type_rocket = tonumber(item:value())
		NobleHUD:SaveSettings()
	end	
	MenuCallbackHandler.callback_noblehud_crosshair_type_minigun = function(self,item)
		NobleHUD.settings.crosshair_type_minigun = tonumber(item:value())
		NobleHUD:SaveSettings()
	end	
	MenuCallbackHandler.callback_noblehud_crosshair_type_flamethrower = function(self,item)
		NobleHUD.settings.crosshair_type_flamethrower = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_crosshair_type_saw = function(self,item)
		NobleHUD.settings.crosshair_type_saw = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_crosshair_type_grenade_launcher = function(self,item)
		NobleHUD.settings.crosshair_type_grenade_launcher = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_crosshair_type_bow = function(self,item)
		NobleHUD.settings.crosshair_type_bow = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_crosshair_type_crossbow = function(self,item)
		NobleHUD.settings.crosshair_type_crossbow = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_crosshair_alpha = function(self,item)
		NobleHUD.settings.crosshair_alpha = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.noblehud_crosshair_options_close = function(self)
		--NobleHUD:SaveSettings()
	end
	
	
--BUFFS

	--ALL
	MenuCallbackHandler.callback_noblehud_set_buffs_master_enabled = function(self,item)
		local state = item:value() == "on"
		NobleHUD.settings.buffs_master_enabled = state
		if not state then 
			NobleHUD:ClearBuffs()
		end
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_compact_mode_enabled = function(self,item)
		local state = item:value() == "on"
		NobleHUD.settings.buffs_compact_mode_enabled = state
		for i,buff in pairs(NobleHUD._active_buffs or {}) do 
			if buff.panel then 
				buff.panel:set_size(NobleHUD:GetBuffItemSize())
			end
		end
		--TODO update all buffs
	end
	MenuCallbackHandler.callback_noblehud_set_buff_align_center = function(self,item)
		NobleHUD.settings.buff_align_center = item:value() == "on"
	end
	MenuCallbackHandler.callback_noblehud_set_buff_vertical_center = function(self,item)
		NobleHUD.settings.buff_vertical_center = item:value() == "on"
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_panel_x = function(self,item)
		NobleHUD.settings.buffs_panel_x = tonumber(item:value())
		NobleHUD:LayoutBuffPanel()
		if NobleHUD._buffs_panel and alive(NobleHUD._buffs_panel) then 
			NobleHUD._buffs_panel:child("debug_buffs"):show()
		end
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_panel_y = function(self,item)
		NobleHUD.settings.buffs_panel_y = tonumber(item:value())
		NobleHUD:LayoutBuffPanel()
		if NobleHUD._buffs_panel and alive(NobleHUD._buffs_panel) then 
			NobleHUD._buffs_panel:child("debug_buffs"):show()
		end
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_panel_w = function(self,item)
		NobleHUD.settings.buffs_panel_w = tonumber(item:value())
		NobleHUD:LayoutBuffPanel()
		if NobleHUD._buffs_panel and alive(NobleHUD._buffs_panel) then 
			NobleHUD._buffs_panel:child("debug_buffs"):show()
		end
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_panel_h = function(self,item)
		NobleHUD.settings.buffs_panel_h = tonumber(item:value())
		NobleHUD:LayoutBuffPanel()
		if NobleHUD._buffs_panel and alive(NobleHUD._buffs_panel) then 
			NobleHUD._buffs_panel:child("debug_buffs"):show()
		end
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_panel_align = function(self,item)
		NobleHUD.settings.buffs_panel_align = tonumber(item:value())
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_panel_vertical = function(self,item)
		NobleHUD.settings.buffs_panel_vertical = tonumber(item:value())
	end
	MenuCallbackHandler.noblehud_buffs_all_options_close = function(self)
		if NobleHUD._buffs_panel and alive(NobleHUD._buffs_panel) then 
			NobleHUD._buffs_panel:child("debug_buffs"):hide()
		end
		NobleHUD:SaveSettings()
	end	
	

	--MISC
	MenuCallbackHandler.callback_noblehud_set_buffs_misc_dodge_chance_total_enabled = function(self,item)
		local state = item:value() == "on"
		NobleHUD.buff_settings.dodge_chance_total = state
		NobleHUD:ToggleBuff(state,"dodge_chance_total")
		NobleHUD:SaveBuffSettings()
	end	
	
	MenuCallbackHandler.callback_noblehud_set_buffs_misc_dodge_chance_total_threshold = function(self,item)
		local value = tonumber(item:value())
		NobleHUD.buff_settings.dodge_chance_threshold = value
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_misc_crit_chance_total_enabled = function(self,item)
		local state = item:value() == "on"
		NobleHUD.buff_settings.crit_chance_total = state
		NobleHUD:ToggleBuff(state,"crit_chance_total")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_misc_crit_chance_total_threshold = function(self,item)
		local value = tonumber(item:value())
		NobleHUD.buff_settings.crit_chance_threshold = value
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_misc_dmg_resist_total_enabled = function(self,item)
		local state = item:value() == "on"
		NobleHUD.buff_settings.dmg_resist_total = state
		NobleHUD:ToggleBuff(state,"dmg_resist_total")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_misc_dmg_resist_total_threshold = function(self,item)
		local value = tonumber(item:value())
		NobleHUD.buff_settings.dmg_resist_threshold = value
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_misc_phalanx_enabled = function(self,item)
		NobleHUD.buff_settings.vip = item:value() == "on"
		NobleHUD:CheckBuff("vip")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_misc_flashbang_enabled = function(self,item)
		NobleHUD.buff_settings.flashbang = item:value() == "on"
		NobleHUD:CheckBuff("flashbang")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_misc_downed_enabled = function(self,item)
		NobleHUD.buff_settings.downed = item:value() == "on"
		NobleHUD:CheckBuff("downed")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_misc_tased_enabled = function(self,item)
		NobleHUD.buff_settings.tased = item:value() == "on"
		NobleHUD:CheckBuff("tased")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_misc_electrocuted_enabled = function(self,item)
		NobleHUD.buff_settings.electrocuted = item:value() == "on"
		NobleHUD:CheckBuff("electrocuted")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.noblehud_buffs_misc_options_close = function(self)
	end
	

	--PERKDECKS
	MenuCallbackHandler.callback_noblehud_set_buffs_misc_armor_break_invulnerable_enabled = function(self,item)
		NobleHUD.buff_settings.armor_break_invulnerable = item:value() == "on"
		NobleHUD:CheckBuff("armor_break_invulnerable")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_specialization_hitman_enabled = function(self,item)
		NobleHUD.buff_settings.hitman = item:value() == "on"
		NobleHUD:CheckBuff("hitman")
		NobleHUD:SaveBuffSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_specialization_anarchist_lust_for_life_enabled = function(self,item)
		NobleHUD.buff_settings.anarchist_lust_for_life = item:value() == "on"
		NobleHUD:CheckBuff("anarchist_lust_for_life")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_specialization_infiltrator_overdog_enabled = function(self,item)
		NobleHUD.buff_settings.overdog = item:value() == "on"
		NobleHUD:CheckBuff("overdog")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_specialization_infiltrator_life_drain_enabled = function(self,item)
		NobleHUD.buff_settings.melee_life_leech = item:value() == "on"
		NobleHUD:CheckBuff("melee_life_leech")
		NobleHUD:SaveBuffSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_specialization_gambler_medical_supplies_enabled = function(self,item)
		NobleHUD.buff_settings.loose_ammo_restore_health = item:value() == "on"
		NobleHUD:CheckBuff("loose_ammo_restore_health")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_specialization_gambler_ammo_give_out_enabled = function(self,item)
		NobleHUD.buff_settings.loose_ammo_give_team = item:value() == "on"
		NobleHUD:CheckBuff("loose_ammo_give_team")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_specialization_maniac_hysteria_enabled = function(self,item)
		NobleHUD.buff_settings.hysteria = item:value() == "on"
		NobleHUD:CheckBuff("hysteria")
		NobleHUD:SaveBuffSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_specialization_expresident_enabled = function(self,item)
		NobleHUD.buff_settings.expresident = item:value() == "on"
		NobleHUD:CheckBuff("expresident")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_specialization_biker_enabled = function(self,item)
		NobleHUD.buff_settings.wild_kill_counter = item:value() == "on"
		NobleHUD:CheckBuff("wild_kill_counter")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_specialization_kingpin_enabled = function(self,item)
		NobleHUD.buff_settings.chico_injector = item:value() == "on"
		NobleHUD:CheckBuff("chico_injector")
		NobleHUD:SaveBuffSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_specialization_yakuza_enabled = function(self,item)
		NobleHUD.buff_settings.yakuza = item:value() == "on"
		NobleHUD:CheckBuff("yakuza")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_specialization_sicario_enabled = function(self,item)
		NobleHUD.buff_settings.sicario = item:value() == "on"
		NobleHUD:CheckBuff("sicario")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_specialization_delayed_damage_enabled = function(self,item)
		NobleHUD.buff_settings.delayed_damage = item:value() == "on"
		NobleHUD:CheckBuff("delayed_damage")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_specialization_tag_team_enabled = function(self,item)
		NobleHUD.buff_settings.tag_team = item:value() == "on"
		NobleHUD:CheckBuff("tag_team")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_specialization_hacker_ecm_enabled = function(self,item)
		NobleHUD.buff_settings.pocket_ecm_jammer = item:value() == "on"
		NobleHUD:CheckBuff("pocket_ecm_jammer")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_specialization_hacker_kluge_enabled = function(self,item)
		NobleHUD.buff_settings.pocket_ecm_kill_dodge = item:value() == "on"
		NobleHUD:CheckBuff("pocket_ecm_kill_dodge")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.noblehud_buffs_specialization_options_close = function(self)
	end
	
	--MASTERMIND
	MenuCallbackHandler.callback_noblehud_set_buffs_mastermind_combat_medic_enabled = function(self,item)
		NobleHUD.buff_settings.revive_damage_reduction = item:value() == "on"
		NobleHUD:CheckBuff("revive_damage_reduction")
		NobleHUD:SaveBuffSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_mastermind_inspire_basic_enabled = function(self,item)
		NobleHUD.buff_settings.morale_boost = item:value() == "on"
		NobleHUD:CheckBuff("morale_boost")
		NobleHUD:SaveBuffSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_mastermind_inspire_aced_enabled = function(self,item)
		NobleHUD.buff_settings.long_dis_revive = item:value() == "on"
		NobleHUD:CheckBuff("long_dis_revive")
		NobleHUD:SaveBuffSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_mastermind_uppers_cooldown_enabled = function(self,item)
		NobleHUD.buff_settings.uppers_aced_cooldown = item:value() == "on"
		NobleHUD:CheckBuff("uppers_aced_cooldown")
		NobleHUD:SaveBuffSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_mastermind_uppers_ready_enabled = function(self,item)
		NobleHUD.buff_settings.uppers_ready = item:value() == "on"
		NobleHUD:CheckBuff("uppers_ready")
		NobleHUD:SaveBuffSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_mastermind_quick_fix_enabled = function(self,item)
		NobleHUD.buff_settings.first_aid_damage_reduction = item:value() == "on"
		NobleHUD:CheckBuff("first_aid_damage_reduction")
		NobleHUD:SaveBuffSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_mastermind_stockholm_ready_enabled = function(self,item)
		NobleHUD.buff_settings.stockholm_ready = item:value() == "on"
		NobleHUD:CheckBuff("stockholm_ready")
		NobleHUD:SaveBuffSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_mastermind_partners_in_crime_enabled = function(self,item)
		NobleHUD.buff_settings.partners_in_crime = item:value() == "on"
		NobleHUD:CheckBuff("partners_in_crime")
		NobleHUD:SaveBuffSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_mastermind_regen_aggregated_enabled = function(self,item)
		NobleHUD.buff_settings.hp_regen = item:value() == "on"
		NobleHUD:CheckBuff("hp_regen")
		NobleHUD:SaveBuffSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_mastermind_aggressive_reload_enabled = function(self,item)
		NobleHUD.buff_settings.single_shot_fast_reload = item:value() == "on"
		NobleHUD:CheckBuff("single_shot_fast_reload")
		NobleHUD:SaveBuffSettings()
	end
	MenuCallbackHandler.noblehud_buffs_mastermind_options_close = function(self)
	end
	
	
	
	--ENFORCER

	MenuCallbackHandler.callback_noblehud_set_buffs_enforcer_underdog_enabled = function(self,item)
		NobleHUD.buff_settings.dmg_multiplier_outnumbered = item:value() == "on"
		NobleHUD:CheckBuff("dmg_multiplier_outnumbered")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_enforcer_overkill_enabled = function(self,item)
		NobleHUD.buff_settings.overkill_damage_multiplier = item:value() == "on"
		NobleHUD:CheckBuff("overkill_damage_multiplier")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_enforcer_bullseye_enabled = function(self,item)
		NobleHUD.buff_settings.bullseye = item:value() == "on"
		NobleHUD:CheckBuff("bullseye")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_enforcer_bulletstorm_enabled = function(self,item)
		NobleHUD.buff_settings.bulletstorm = item:value() == "on"
		NobleHUD:CheckBuff("bulletstorm")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_enforcer_fully_loaded_enabled = function(self,item)
		NobleHUD.buff_settings.fully_loaded = item:value() == "on"
		NobleHUD:CheckBuff("fully_loaded")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.noblehud_buffs_enforcer_options_close = function(self)
	end


	--TECHNICIAN
	MenuCallbackHandler.callback_noblehud_set_buffs_technician_lock_n_load_enabled = function(self,item)
		NobleHUD.buff_settings.shock_and_awe_reload_multiplier = item:value() == "on"
		NobleHUD:CheckBuff("shock_and_awe_reload_multiplier")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.noblehud_buffs_technician_options_close = function(self)
	end
	
	--GHOST	
	MenuCallbackHandler.callback_noblehud_set_buffs_ghost_sixth_sense_enabled = function(self,item)
		NobleHUD.buff_settings.sixth_sense = item:value() == "on"
		NobleHUD:CheckBuff("sixth_sense")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_ghost_dire_need_enabled = function(self,item)
		NobleHUD.buff_settings.dire_need = item:value() == "on"
		NobleHUD:CheckBuff("dire_need")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_ghost_second_wind_enabled = function(self,item)
		NobleHUD.buff_settings.second_wind = item:value() == "on"
		NobleHUD:CheckBuff("second_wind")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_ghost_unseen_strike_enabled = function(self,item)
		NobleHUD.buff_settings.unseen_strike = item:value() == "on"
		NobleHUD:CheckBuff("unseen_strike")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.noblehud_buffs_ghost_options_close = function(self)
	end
	
	--FUGITIVE	
	MenuCallbackHandler.callback_noblehud_set_buffs_fugitive_desperado_enabled = function(self,item)
		NobleHUD.buff_settings.desperado = item:value() == "on"
		NobleHUD:CheckBuff("desperado")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_fugitive_trigger_happy_enabled = function(self,item)
		NobleHUD.buff_settings.trigger_happy = item:value() == "on"
		NobleHUD:CheckBuff("trigger_happy")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_fugitive_running_from_death_enabled = function(self,item)
		NobleHUD.buff_settings.reload_weapon_faster = item:value() == "on"
		NobleHUD:CheckBuff("reload_weapon_faster")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_fugitive_up_you_go_enabled = function(self,item)
		NobleHUD.buff_settings.revived_damage_resist = item:value() == "on"
		NobleHUD:CheckBuff("revived_damage_resist")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_fugitive_swan_song_enabled = function(self,item)
		NobleHUD.buff_settings.swan_song = item:value() == "on"
		NobleHUD:CheckBuff("swan_song")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_fugitive_messiah_enabled = function(self,item)
		NobleHUD.buff_settings.messiah_charge = item:value() == "on"
		NobleHUD:CheckBuff("messiah_charge")
		NobleHUD:SaveBuffSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_fugitive_messiah_ready_enabled = function(self,item)
		NobleHUD.buff_settings.messiah_ready = item:value() == "on"
		NobleHUD:CheckBuff("messiah_ready")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_fugitive_bloodthirst_melee_enabled = function(self,item)
		NobleHUD.buff_settings.bloodthirst_melee = item:value() == "on"
		NobleHUD:CheckBuff("bloodthirst_melee")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_fugitive_bloodthirst_reload_enabled = function(self,item)
		NobleHUD.buff_settings.bloodthirst_reload = item:value() == "on"
		NobleHUD:CheckBuff("bloodthirst_reload_speed")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.callback_noblehud_set_buffs_fugitive_berserker_enabled = function(self,item)
		NobleHUD.buff_settings.berserker_melee_damage_multiplier = item:value() == "on"
		NobleHUD:CheckBuff("berserker_melee_damage_multiplier")
		NobleHUD:SaveBuffSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_buffs_fugitive_berserker_aced_enabled = function(self,item)
		NobleHUD.buff_settings.berserker_damage_multiplier = item:value() == "on"
		NobleHUD:CheckBuff("berserker_damage_multiplier")
		NobleHUD:SaveBuffSettings()
	end	
	MenuCallbackHandler.noblehud_buffs_fugitive_options_close = function(self)
	end
	
	MenuCallbackHandler.callback_noblehud_set_damage_popups_enabled = function(self,item)
		NobleHUD.settings.damage_popups_enabled = item:value() == "on"
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_damage_popups_style = function(self,item)
		NobleHUD.settings.damage_popups_style = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_damage_popups_lifetime = function(self,item)
		NobleHUD.settings.damage_popups_lifetime = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_damage_popups_fadeout = function(self,item)
		NobleHUD.settings.damage_popups_fadeout = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_damage_popups_cumulative_enabled = function(self,item)
		NobleHUD.settings.damage_popups_cumulative_enabled = item:value() == "on"
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_damage_popups_cumulative_refresh = function(self,item)
		NobleHUD.settings.damage_popups_cumulative_refresh = tonumber(item:value())
		NobleHUD:SaveSettings()
	end
	MenuCallbackHandler.callback_noblehud_set_damage_popups_redundant = function(self,item)
		NobleHUD.settings.damage_popups_redundant = item:value() == "on"
		NobleHUD:SaveSettings()
	end
	
	
	MenuCallbackHandler.callback_noblehud_close = function(self)
		--NobleHUD:SaveSettings()
	end
	
	MenuCallbackHandler.callback_noblehud_toggle_safety = function(self)
		--dummied out for now
	end
	
	NobleHUD:LoadSettings()
	NobleHUD:LoadBuffSettings()
	
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options.txt", NobleHUD, NobleHUD.settings)
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_player.txt", NobleHUD, NobleHUD.settings)
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_team.txt", NobleHUD, NobleHUD.settings)
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_chat.txt", NobleHUD, NobleHUD.settings)
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_weapons.txt", NobleHUD, NobleHUD.settings)
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_crosshair.txt", NobleHUD, NobleHUD.settings)
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_score.txt", NobleHUD, NobleHUD.settings)
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_radar.txt", NobleHUD, NobleHUD.settings)
	
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_buffs_all.txt", NobleHUD, NobleHUD.settings)
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_buffs_mastermind.txt", NobleHUD, NobleHUD.buff_settings)
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_buffs_enforcer.txt", NobleHUD, NobleHUD.buff_settings)
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_buffs_technician.txt", NobleHUD, NobleHUD.buff_settings)
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_buffs_ghost.txt", NobleHUD, NobleHUD.buff_settings)
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_buffs_fugitive.txt", NobleHUD, NobleHUD.buff_settings)
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_buffs_specialization.txt", NobleHUD, NobleHUD.buff_settings)
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_buffs_misc.txt", NobleHUD, NobleHUD.buff_settings)
	
	MenuHelper:LoadFromJsonFile(NobleHUD._options_path .. "options_damage_popups.txt", NobleHUD, NobleHUD.settings)
end)
