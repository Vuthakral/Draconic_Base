if SERVER then return end

local function drc_Inspect()
	if GetConVar("cl_drawhud"):GetFloat() == 0 then return end
	
	local ply = LocalPlayer() 
	local curswep = ply:GetActiveWeapon()
	if curswep.Draconic == nil then return end
	if curswep.MulIns == nil then return end
	
	local bool = curswep:GetNWBool("Inspecting")
	
	
	local w = ScrW()
	local h = ScrH()
	local ratio = w/h
	local w2 = ScrW()/2
	local h2 = ScrH()/2
	
	if bool == true then
		alpha = Lerp(curswep.MulIns, 0, 255)
		YOffset = Lerp(curswep.MulIns, h/2, 0)
	else
		alpha = Lerp(curswep.MulIns, 255, 0)
		YOffset = Lerp(curswep.MulIns, 0, h )
	end
	
	if bool == false then
		alphalerp = Lerp(FrameTime() * 10, alphalerp or 0, 0)
		offsetlerp = Lerp(FrameTime() * 2.5, offsetlerp or h/h2/2, h/2)
	else
		alphalerp = Lerp(FrameTime() * 25, alphalerp or alpha or 0, alpha or 0)
		offsetlerp = Lerp(FrameTime() * 10, offsetlerp or YOffset, YOffset)
	end
	
	local WeapCol = ply:GetNWVector("WeaponColour_DRC")
	local TextCol = Color(200, 200, 200, alphalerp)
	local TitleCol = Color(255, 255, 255, alphalerp)
	
	inspecttextpos = offsetlerp + h - h2/2 - (h2/2)
	
	if curswep.Base != "draconic_melee_base" then
		local PrimRPM = curswep.PrimaryStats.RPM
		local PrimDmg = curswep.PrimaryStats.Damage
		local PrimKick = curswep.PrimaryStats.Kick
		local PrimSpread = curswep.PrimaryStats.Spread
		local PrimSpreadDiv = curswep.PrimaryStats.SpreadDiv
		local PrimRecoilU = curswep.PrimaryStats.RecoilUp
		local PrimRecoilD = curswep.PrimaryStats.RecoilDown
		local PrimRecoilLR = curswep.PrimaryStats.RecoilHoriz
		
		local rpm = (60 / PrimRPM)
		
		local spreadmin = math.Round((PrimSpread / PrimSpreadDiv), 2)
		local spreadmax = math.Round((PrimSpread / PrimSpreadDiv) * 130, 2)
		local stability = math.Round(math.Clamp(5 - PrimRecoilU * (5 -spreadmax * -0.1), 0, 5), 2)
		
		if PrimRecoilU == 0 && PrimRecoilD == 0 && PrimRecoilLR == 0 then stability = nil end
		
		surface.SetDrawColor( Color(0, 0, 0, alphalerp / 1.5) )
		surface.DrawRect( 0 + 4, offsetlerp + h - h2/2 - (h2/2), 10, h2 )
		
		surface.SetDrawColor( Color(WeapCol.x * 127, WeapCol.y * 127, WeapCol.z * 127, alphalerp / 1.2) )
		surface.DrawRect( 0 + 6, offsetlerp + h - h2/2 - (h2/2), 6, h2 )
		
		draw.DrawText("".. string.upper(curswep.Category) .."", "ApercuStatsTitle", 30, inspecttextpos + 10, TextCol)
		inspecttextpos = inspecttextpos + 10
		
		if curswep.InfoName != nil then
			draw.DrawText("> ".. curswep.InfoStats.Name .." ━ ''".. curswep.InfoName .."''", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			inspecttextpos = inspecttextpos + 30
		else
			draw.DrawText("> ".. curswep.InfoStats.Name .."", "ApercuStats", 40, inspecttextpos + 40, TextCol)
			inspecttextpos = inspecttextpos + 30
		end
		
		if curswep.Manufacturer != nil then
			draw.DrawText("> Manufacturer: ".. curswep.InfoStats.Manufacturer .."", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			inspecttextpos = inspecttextpos + 30
		end
		
		if curswep.InfoDescription != nil then
			draw.DrawText("> Description: ".. curswep.InfoStats.Description .."", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			inspecttextpos = inspecttextpos + 50
		end
		
		if spreadmin != nil then
			draw.DrawText("> Spread: ".. spreadmin .."° - ".. spreadmax .."°", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			inspecttextpos = inspecttextpos + 30
		end
		
		if stability != nil then
			draw.DrawText("> Stability Rating: ".. stability .."", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			inspecttextpos = inspecttextpos + 30
		end
		
		if curswep.PrimaryStats.Projectile != nil then
			draw.DrawText("> Velocity: ".. math.Round((curswep.PrimaryStats.ProjSpeed / 16 * 0.3048), 2) .."m/s", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			inspecttextpos = inspecttextpos + 30
		end
		
		if curswep.PrimaryStats.Projectile != nil then
		local projectile = scripted_ents.GetStored(curswep.PrimaryStats.Projectile)
			draw.DrawText("> Affect Radius: ".. math.Round((projectile.t.AffectRadius / 16 * 0.3048), 2) .."m", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			inspecttextpos = inspecttextpos + 30
		end
		
		if curswep.PrimaryStats.Damage != nil then
			if curswep.PrimaryStats.Projectile != nil then
				local projectile = scripted_ents.GetStored(curswep.PrimaryStats.Projectile)
				if projectile.t.ProjectileType == "supercombine" then
					draw.DrawText("> Damage: ".. projectile.t.Damage .." (base) - ".. projectile.t.SuperDamage .." (supercombine)", "ApercuStats", 40, inspecttextpos + 30, TextCol)
				else
					draw.DrawText("> Damage: ".. projectile.t.Damage .."", "ApercuStats", 40, inspecttextpos + 30, TextCol)
				end
			else
				draw.DrawText("> Damage: ".. curswep.PrimaryStats.Damage .."", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			end
			inspecttextpos = inspecttextpos + 30
		end
		
		if curswep.PrimaryStats.Ammo != nil then
			if curswep.Base == "draconic_gun_base" then
				draw.DrawText("> Ammo: ".. curswep:Clip1() .." / ".. curswep:GetMaxClip1() .." (".. curswep.PrimaryStats.Ammo ..")", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			else
				draw.DrawText("> Battery: ".. curswep:Clip1() .."%", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			end
			inspecttextpos = inspecttextpos + 30
		end
		
		if curswep.PrimaryStats.RPM != nil then
			if curswep.IsBatteryBased == true then 
				if curswep.BatteryStats.LowerRPMWithHeat == true then
					draw.DrawText("> RPM: ".. curswep.BatteryStats.HeatRPMmin .." - ".. curswep.PrimaryStats.RPM .."", "ApercuStats", 40, inspecttextpos + 30, TextCol)
				else
					draw.DrawText("> RPM: ".. curswep.PrimaryStats.RPM .."", "ApercuStats", 40, inspecttextpos + 30, TextCol)
				end
			else
				draw.DrawText("> RPM: ".. curswep.PrimaryStats.RPM .."", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			end
			inspecttextpos = inspecttextpos + 30
		end
	else
		surface.SetDrawColor( Color(0, 0, 0, alphalerp / 1.5) )
		surface.DrawRect( 0 + 4, offsetlerp + h - h2/2 - (h2/2), 10, h2 )
		
		surface.SetDrawColor( Color(WeapCol.x * 127, WeapCol.y * 127, WeapCol.z * 127, alphalerp / 1.2) )
		surface.DrawRect( 0 + 6, offsetlerp + h - h2/2 - (h2/2), 6, h2 )
		
		draw.DrawText("".. string.upper(curswep.Category) .."", "ApercuStatsTitle", 30, inspecttextpos + 10, TextCol)
		inspecttextpos = inspecttextpos + 10
		
		if curswep.InfoName != nil then
			draw.DrawText("> ".. curswep.InfoStats.Name .." ━ ''".. curswep.InfoName .."''", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			inspecttextpos = inspecttextpos + 30
		else
			draw.DrawText("> ".. curswep.InfoStats.Name .."", "ApercuStats", 40, inspecttextpos + 40, TextCol)
			inspecttextpos = inspecttextpos + 30
		end
		
		if curswep.Manufacturer != nil then
			draw.DrawText("> Manufacturer: ".. curswep.InfoStats.Manufacturer .."", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			inspecttextpos = inspecttextpos + 20
		end
		
		if curswep.InfoDescription != nil then
			draw.DrawText("> Description: ".. curswep.InfoStats.Description .."", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			inspecttextpos = inspecttextpos + 60
		end
		
		if curswep.Primary.Range != nil then
			draw.DrawText("> Primary Reach: ".. curswep.Primary.Range .."", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			inspecttextpos = inspecttextpos + 30
		end
		
		if curswep.Primary.Damage != nil then
			draw.DrawText("> Primary Damage: ".. curswep.Primary.Damage .."", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			inspecttextpos = inspecttextpos + 30
		end
		
		if curswep.Secondary.Range != nil then
			draw.DrawText("> Secondary Reach: ".. curswep.Secondary.Range .."", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			inspecttextpos = inspecttextpos + 30
		end
		
		if curswep.Secondary.Damage != nil then
			draw.DrawText("> Secondary Damage: ".. curswep.Secondary.Damage .."", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			inspecttextpos = inspecttextpos + 30
		end
		
		if curswep.Primary.LungeRange != nil then
			draw.DrawText("> Lunge Reach: ".. curswep.Primary.LungeRange .."", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			inspecttextpos = inspecttextpos + 30
		end
		
		if curswep.Primary.LungeDamage != nil then
			draw.DrawText("> Lunge Damage: ".. curswep.Primary.LungeDamage .."", "ApercuStats", 40, inspecttextpos + 30, TextCol)
			inspecttextpos = inspecttextpos + 30
		end
	end
end

hook.Add("HUDPaint", "drc_inspection_menu", drc_Inspect) 