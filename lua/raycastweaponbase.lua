--this allows reticle bloom to activate
local orig_fire = RaycastWeaponBase.fire
function RaycastWeaponBase:fire(...)
	local result = {orig_fire(self,...)}
	if result and self._setup.user_unit == managers.player:player_unit() then 
		NobleHUD:_add_weapon_bloom(0.5)
--NobleHUD._patootie = result --!
		if result[1] and type(result[1]) == "table" then 
			if result[1].rays then 
				for i,ray in pairs(result[1].rays) do 
					local position = ray.position
					local body = ray.body
					local distance = ray.distance
					local unit = ray.unit
					
					local damage_result = ray.damage_result
					if damage_result then 
						if damage_result.attack_data then 
							local screen_pos = NobleHUD._ws:world_to_screen(managers.viewport:get_current_camera(),body and body:position() or position)
							local color = Color.white
							local layer = 1
							if damage_result.type == "death" then 
								color = Color.red
								layer = 3
							elseif damage_result.attack_data.headshot then 
								color = Color.yellow
							end
							local damage_popup = NobleHUD._popups_panel:text({
								name = "damage_popup_" .. tostring(ray),
								text = string.format("%.1f",damage_result.attack_data.damage),
								font = "fonts/font_large_mf",
								font_size = 12,
								layer = layer,
								x = screen_pos.x,
								y = screen_pos.y,
								color = color,
								visible = true
							})
							NobleHUD:animate(damage_popup,"animate_popup_damage_bluespider",function(o) o:parent():remove(o) end,nil,2,body,1)
						end
					end
					
				end
			end
		end
	end
	return unpack(result)
end