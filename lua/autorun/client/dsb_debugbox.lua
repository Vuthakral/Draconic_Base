local blur = Material( "pp/blurscreen" )
local function drawBlur( x, y, w, h, layers, density, alpha )
	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( blur )

	for i = 1, layers do
		blur:SetFloat( "$blur", ( i / layers ) * density )
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		render.SetScissorRect( x, y, x + w, y + h, true )
			surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		render.SetScissorRect( 0, 0, 0, 0, false )
	end
end


local function drc_Debug()
	local curswep = LocalPlayer():GetActiveWeapon()
	
	if GetConVar("cl_drc_debugmode"):GetString() == "0" then
	else
		if curswep.Draconic != true then
		else
		local et = LocalPlayer():GetEyeTrace()
		local res = et.Entity
		
			local header = "DSB Debug Assistant | Current Weapon: ".. curswep.PrintName ..""
			local name = "".. curswep:GetClass() .." - ".. curswep.Base ..""

			if curswep.Base == "draconic_battery_base" then
				firemode = "".. curswep.Weapon:GetNWString("FireMode") ..""
			elseif curswep.Base == "draconic_gun_base" then
				firemode = "".. curswep.Weapon:GetNWString("FireMode") ..""
			else
				firemode = "Not a gun."
			end
			
			if curswep.Base == "draconic_battery_base" then
				ammoint = "".. curswep.Weapon:GetNWInt("LoadedAmmo") .." (int) / ".. curswep:Clip1() .." (clip)"
			elseif curswep.Base == "draconic_gun_base" then
				ammoint = "".. curswep.Weapon:GetNWInt("LoadedAmmo") .." (int) / ".. curswep:Clip1() .." (clip)"
			else
				ammoint = "Not a gun."
			end
			
			if curswep.Base == "draconic_battery_base" then
				heatint = "".. math.Round(curswep.Weapon:GetNWInt("Heat"), 3) .."%"
			elseif curswep.Base == "draconic_gun_base" then
				heatint = "Not a Battery Base weapon."
			else
				heatint = "Not a gun."
			end
			
			if curswep.Base == "draconic_battery_base" then
				if curswep.LowerRPMWithHeat == true then
					if curswep.LoadAfterShot == false then
						rpm = "".. math.Round(math.Clamp((curswep.Primary.RPM / (curswep.Weapon:GetNWInt("Heat") * 2.5 / 50)), (curswep.HeatRPMmin), (curswep.Primary.RPM))) ..""
					else
						rpm = "".. math.Round(math.Clamp((curswep.Primary.RPM / (curswep.Weapon:GetNWInt("Heat") * 2.5 / 50)), (curswep.HeatRPMmin), (curswep.Primary.RPM))) .." - Manual load"
					end
				else
					if curswep.LoadAfterShot == false then
						rpm = "".. curswep.Primary.RPM ..""
					else
						rpm = "".. curswep.Primary.RPM .." - Manual load"
					end
				end
			elseif curswep.Base == "draconic_gun_base" then
					if curswep.LoadAfterShot == false then
						rpm = "".. curswep.Primary.RPM ..""
					else
						rpm = "".. curswep.Primary.RPM .." - Manual load"
					end
			else
				rpm = "Not a gun."
			end
			
			if curswep.Weapon:GetNWBool("Passive") == true then
				passive = "True"
			else
				passive = "False"
			end
			
			if curswep.Base == "draconic_battery_base" then
				if curswep.Weapon:GetNWBool("ironsights") == true then
					sights = "True"
				else
					sights = "False"
				end
			elseif curswep.Base == "draconic_gun_base" then
				if curswep.Weapon:GetNWBool("ironsights") == true then
					sights = "True"
				else
					sights = "False"
				end
			else
				sights = "Not a gun."
			end	
			
			if curswep.Base == "draconic_melee_base" then
				if (LocalPlayer():GetPos():Distance(res:GetPos()) < curswep.Primary.Range * 4.1) then
					prim = "True"
				else
					prim = "False"
				end
				if (LocalPlayer():GetPos():Distance(res:GetPos()) < curswep.Secondary.Range * 4.1) then
					sec = "True"
				else
					sec = "False"
				end
			elseif curswep.Base == "draconic_gun_base" or curswep.Base == "draconic_battery_base" then
				if curswep.Primary.CanMelee == true then
					if (LocalPlayer():GetPos():Distance(res:GetPos()) < curswep.Primary.MeleeRange * 4.1) then
						prim = "True"
					else
						prim = "False"
					end
					
					melee = prim
				else
				melee = "".. curswep.PrintName .." does not support melee."
				end
			end
			
			if curswep.Base == "draconic_melee_base" then
				if curswep.Primary.CanLunge == false then
					lunge = "Weapon cannot lunge."
				else
					if (LocalPlayer():GetPos():Distance(res:GetPos()) < curswep.Primary.LungeMaxDist) then
						lunge = "True"
					else
						lunge = "False"
					end
				end
				melee = "Primary: ".. prim .." - Secondary: ".. sec ..""
			else
				lunge = "Not a Melee Base weapon."
			end
			
--			local muzzle = curswep:LookupAttachment("muzzle")		
--			if muzzle == "muzzle" then
--				local muzzletext = "hl2 ✔"
--				if muzzle == "0" then
--					local muzzle = curswep:LookupAttachment("muzzle_flash")
--					if muzzle == "muzzle_flash" then
--						local muzzletext = "CS:S ✗"
--					elseif muzzle == "0" then
--						local muzzletext = "INCOMPATIBLE"
--					end
--				else end
--			else end
		
			if GetConVar("cl_drc_sell_soul"):GetString() == "1" then
				soul = "Yes."
			else
				soul = "No :'("
			end
		
			draw.RoundedBox(4, 40, 515, 600, 260, Color(115, 115, 115, 100))
			
			drawBlur( 40, 515, 600, 260, 6, 4, 150 )

			draw.RoundedBox(4, 40, 515, 600, 30, Color(72, 72, 72, 255))
			draw.DrawText("Current SWEP ::", "HudSelectionText", 50, 555, Color(0, 0, 0, 255))
			draw.DrawText("Currnt Firemode ::", "HudSelectionText", 50, 575, Color(0, 0, 0, 255))
			draw.DrawText("Current Ammo ::", "HudSelectionText", 50, 595, Color(0, 0, 0, 255))
			draw.DrawText("Current Heat ::", "HudSelectionText", 50, 615, Color(0, 0, 0, 255))
			draw.DrawText("Current RPM :: ", "HudSelectionText", 50, 635, Color(0, 0, 0, 255))
			draw.DrawText("Currently in Passive ::", "HudSelectionText", 50, 655, Color(0, 0, 0, 255))
			draw.DrawText("Currently in Sights ::", "HudSelectionText", 50, 675, Color(0, 0, 0, 255))
			draw.DrawText("Lunge in range ::", "HudSelectionText", 50, 695, Color(0, 0, 0, 255))
			draw.DrawText("Melee in range ::", "HudSelectionText", 50, 715, Color(0, 0, 0, 255))
			draw.DrawText("Soul Sacrificed to Vuthakral ::", "HudSelectionText", 50, 745, Color(0, 0, 0, 255))

			draw.DrawText(header, "HudSelectionText", 50, 520, Color(236, 236, 236, 236))
			
			draw.DrawText(name, "HudSelectionText", 180, 555, Color(236, 236, 236, 236))
			draw.DrawText(firemode, "HudSelectionText", 195, 575, Color(236, 236, 236, 236))
			draw.DrawText(ammoint, "HudSelectionText", 180, 595, Color(236, 236, 236, 236))
			draw.DrawText(heatint, "HudSelectionText", 170, 615, Color(236, 236, 236, 236))
			draw.DrawText(rpm, "HudSelectionText", 165, 635, Color(236, 236, 236, 236))
			draw.DrawText(passive, "HudSelectionText", 220, 655, Color(236, 236, 236, 236))
			draw.DrawText(sights, "HudSelectionText", 210, 675, Color(236, 236, 236, 236))
			draw.DrawText(lunge, "HudSelectionText", 180, 695, Color(236, 236, 236, 236))
			draw.DrawText(melee, "HudSelectionText", 180, 715, Color(236, 236, 236, 236))
			draw.DrawText(soul, "HudSelectionText", 270, 745, Color(236, 236, 236, 236))
		end
	end
end
hook.Add("HUDPaint", "drc_debug_hud", drc_Debug)