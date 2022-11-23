local function drc_Crosshair()
	if GetConVar("cl_drawhud"):GetFloat() == 0 then return end
	if GetConVar("cl_drc_disable_crosshairs"):GetFloat() == 1 then return end
	if GetConVar("sv_drc_disable_crosshairs"):GetFloat() == 1 then return end
	
	local ply = LocalPlayer()
	if !IsValid(ply) or !ply:Alive() then return end
	local curswep = ply:GetActiveWeapon()
	if !IsValid(curswep) then return end
	if !curswep.Draconic then return end
	
	if curswep.DrawCrosshair == false then return end
	
	local pos = DRC.CalcView.ToScreen
	
	if curswep.SightsDown == false or curswep.Secondary.ScopePitch != 0 then
	--	pos.x = ScrW()/2
	--	pos.y = ScrH()/2
	elseif curswep.SightsDown && curswep.Secondary.Scoped == true then
		pos.x = ScrW()/2
		pos.y = ScrH()/2
		
		local Xalpha = 0
		if ((pos.x > ScrW()/2 + 25) or (pos.x < ScrW()/2 - 25)) or ((pos.y > ScrH()/2 + 25) or (pos.y < ScrH()/2 - 25)) then
			Xalpha = 255
		else
			Xalpha = 0
		end
		
		surface.SetFont( "DermaLarge" )
		surface.SetTextColor(255, 0, 0, Xalpha)
		surface.SetTextPos(math.Round(pos.x), math.Round(pos.y))
		surface.DrawText("X", true)
	end

	local chmode = GetConVar("cl_drc_debug_crosshairmode"):GetFloat()
	
	if curswep.Draconic == nil then return end
	
	local bool1 = curswep.Weapon:GetNWBool("Inspecting")
	local bool2 = curswep:GetNWBool("Passive")
	--local bool3 = curswep.Weapon:GetNWBool("Ironsights")
	local bool3 = (curswep.SightsDown == true && !DRC:ThirdPersonEnabled(ply))
	
	if (bool1 == false) or (bool2 == false) or (bool3 == false) then
		alphach = Lerp(curswep.MulIns, 0, 255)
	else
		alphach = Lerp(curswep.MulIns, 255, 0)
	end
	
	if (bool1 == true) or (bool2 == true) or (bool3 == true && curswep.Secondary.Scoped == false) then
		alphalerpch = Lerp(FrameTime() * 25, alphalerpch or 0, 0)
	else
		alphalerpch = Lerp(FrameTime() * 25, alphalerpch or alphach or 0, alphach or 0)
	end

	
	local artificial = curswep.CrosshairSizeMul
	
	local modspread = nil
	local modspreaddiv = nil
	if !curswep.IsMelee then
		modspread = curswep:GetAttachmentValue("Ammunition", "Spread")
		modspreaddiv = curswep:GetAttachmentValue("Ammunition", "SpreadDiv")
	end
	
	local ccol = curswep.CrosshairColor
--	local target = curswep:GetConeTarget()
--	if target then ccol = Color(255, 0, 0) else ccol = curswep.CrosshairColor end
	
		if curswep.Base == "draconic_melee_base" then
			local target = curswep:GetConeTarget()
			local dist = 696969
			if target then dist = ply:GetPos():Distance(target:GetPos()) end
		
			if curswep.CrosshairStatic != nil then
				if curswep.CrosshairShadow == true then
					surface.SetDrawColor( ccol.r/2, ccol.g/2, ccol.b/2, alphalerpch*1.5 )
					surface.SetMaterial( Material(curswep.CrosshairStatic) )
					surface.DrawTexturedRect(pos.x, pos.y, artificial, artificial)
					surface.DrawTexturedRect(pos.x, pos.y, artificial, artificial)
				end
		
			if target && (dist < curswep.Primary.LungeMaxDist) then
				surface.SetDrawColor( Color(255, 0, 0, alphalerpch) )
			else
				surface.SetDrawColor( curswep.CrosshairColor.r, curswep.CrosshairColor.g, curswep.CrosshairColor.b, alphalerpch )
			end
			surface.SetMaterial( Material(curswep.CrosshairStatic) )
			surface.DrawTexturedRectRotated(pos.x * artificial, pos.y * artificial, ScrH()/8 * artificial, ScrH()/8 * artificial, 0)
			end
		end
	
	if curswep.Base == "draconic_melee_base" then return end
	if curswep.PrimaryStats == nil then return end
	
	local spread = (curswep.PrimaryStats.Spread * modspread)
	local spreaddiv = (curswep.PrimaryStats.SpreadDiv * modspreaddiv)
	local artificial = curswep.CrosshairSizeMul
	local cx = curswep.CrosshairCorrectX
	local cy = curswep.CrosshairCorrectY
	local smath = (spread/spreaddiv)
	local smathoffset = smath * 150
	
	local b = math.Clamp(curswep.BloomValue * 100 or 0, 0, 100) * smath * 10
	
	LerpC = Lerp(FrameTime() * 20, DRCCrosshairLerp or b, b)
	DRCCrosshairLerp = Lerp(FrameTime() * 10, DRCCrosshairLerp or LerpC, LerpC)
	
	if GetConVar("cl_drc_debugmode"):GetFloat() > 0 then
		if chmode == 1 or chmode == 3 then
			local heat = curswep.Weapon:GetNWInt("Heat")
			local hl = LerpVector(heat / 175, Vector(255, 255, 255), Vector(255, 0, 0))
			
			surface.SetDrawColor( hl.x, hl.y, hl.z, heat * 2.5 )
			surface.SetMaterial(Material("vgui/hud/xbox_reticle"))
			surface.DrawTexturedRect( (pos.x - (256 * 0.5) * (spread / spreaddiv) * 16), (pos.y - (256 * 0.5) * smath * 16), 256 * smath * 16, 256 * smath * 16 )
					
			surface.DrawCircle((pos.x), (pos.y), 64 * smath * 10, 255, 255, 255, 255)
			surface.DrawCircle((pos.x), (pos.y), 64 * smath * 13.37, 255, 0, 0, 255)
			surface.DrawCircle((pos.x), (pos.y), 64 * smath * 1, 0, 255, 0, 255)
			surface.DrawCircle((pos.x), (pos.y), 64 * smath * 3, 120, 255, 120, 50)
							
			surface.DrawCircle((pos.x), (pos.y), 64 * DRCCrosshairLerp / 50.75, 0, 100, 255, 255)
			surface.DrawCircle((pos.x), (pos.y), 64 * DRCCrosshairLerp / 52, 0, 175, 255, 255)
			
			if curswep.Primary.AimAssist == true then
				surface.DrawCircle((pos.x), (pos.y), 13 * curswep.SpreadCone * curswep.Primary.AimAssist_Mul, 0, 255, 255, 255)
			end
		end
	else end
	
	if DRC:IsCharacter(DRC.CalcView.Trace.Entity) && IsValid(DRC.CalcView.Trace.Entity) then
		local box = DRC.CalcView.Trace.HitBox
		local hitgroup = DRC.CalcView.Trace.Entity:GetHitBoxHitGroup(box, 0)
		if hitgroup == HITGROUP_HEAD then
			if curswep.CrosshairNoIronFade == false then
				surface.SetDrawColor( ccol.r, ccol.g, ccol.b, alphalerpch )
			else
				surface.SetDrawColor( ccol.r, ccol.g, ccol.b, 255 )
			end
			surface.SetMaterial( Material("vgui/circle") )
			surface.DrawTexturedRectRotated(pos.x, pos.y, 3, 3, 0)
		end
	end
	
	if curswep.CrosshairStatic != nil then
		if curswep.CrosshairShadow == true then
			if curswep.CrosshairNoIronFade == false then
				surface.SetDrawColor( ccol.r/2, ccol.g/2, ccol.b/2, alphalerpch * 1.5 )
			else
				surface.SetDrawColor( ccol.r/2, ccol.g/2, ccol.b/2, 150 )
			end
			surface.SetMaterial( Material(curswep.CrosshairStatic) )
			surface.DrawTexturedRect(pos.x - smathoffset * 3.3775 * artificial * cx, pos.y - smathoffset * 3.3775 * artificial * cy, smathoffset * 6.75 * artificial, smathoffset * 6.75 * artificial)
			surface.DrawTexturedRect(pos.x - smathoffset * 3.1275 * artificial * cx, pos.y - smathoffset * 3.1275 * artificial * cy, smathoffset * 6.25 * artificial, smathoffset * 6.25 * artificial)
		end
	
		if curswep.CrosshairNoIronFade == false then
			surface.SetDrawColor( ccol.r, ccol.g, ccol.b, alphalerpch )
		else
			surface.SetDrawColor( ccol.r, ccol.g, ccol.b, 255 )
		end
		surface.SetMaterial( Material(curswep.CrosshairStatic) )
		surface.DrawTexturedRect(pos.x - smathoffset * 3.25 * artificial * cx, pos.y - smathoffset * 3.25 * artificial * cy, smathoffset * 6.5 * artificial, smathoffset * 6.5 * artificial)
	end
	
	if curswep.CrosshairDynamic != nil then
		if curswep.CrosshairShadow == true then
			if curswep.CrosshairNoIronFade == false then
				surface.SetDrawColor( ccol.r/2, ccol.g/2, ccol.b/2, alphalerpch * 1.5 )
			else
				surface.SetDrawColor( ccol.r/2, ccol.g/2, ccol.b/2, 150 )
			end
			surface.SetMaterial( Material(curswep.CrosshairDynamic) )
			surface.DrawTexturedRect(pos.x - smathoffset * 3.1275 * artificial - DRCCrosshairLerp / 2 * cx, pos.y - smathoffset * 3.1275 * artificial - DRCCrosshairLerp / 2 * cy, smathoffset * 6.25 * artificial + DRCCrosshairLerp, smathoffset * 6.25 * artificial + DRCCrosshairLerp)
			surface.DrawTexturedRect(pos.x - smathoffset * 3.3775 * artificial - DRCCrosshairLerp / 2 * cx, pos.y - smathoffset * 3.3775 * artificial - DRCCrosshairLerp / 2 * cy, smathoffset * 6.75 * artificial + DRCCrosshairLerp, smathoffset * 6.75 * artificial + DRCCrosshairLerp)
		end
	
		if curswep.CrosshairNoIronFade == false then
			surface.SetDrawColor( ccol.r, ccol.g, ccol.b, alphalerpch )
		else
			surface.SetDrawColor( ccol.r, ccol.g, ccol.b, 255 )
		end
		surface.SetMaterial( Material(curswep.CrosshairDynamic) )
		surface.DrawTexturedRect(pos.x - smathoffset * 3.25 * artificial - DRCCrosshairLerp / 2 * cx, pos.y - smathoffset * 3.25 * artificial - DRCCrosshairLerp / 2 * cy, smathoffset * 6.5 * artificial + DRCCrosshairLerp, smathoffset * 6.5 * artificial + DRCCrosshairLerp)
	end
	
	DRC.Crosshair = {}
	DRC.Crosshair.Size = smathoffset * 6.5 * artificial + DRCCrosshairLerp
	
	if curswep.CrosshairStatic != nil or curswep.CrosshairDynamic != nil then return end
	
	draw.RoundedBox( 0, pos.x + DRCCrosshairLerp + smath + smathoffset, pos.y -2, smathoffset, 3, Color(0, 0, 0, 200 * alphalerpch))
	draw.RoundedBox( 0, pos.x + DRCCrosshairLerp + smath + smathoffset, pos.y -1, smathoffset, 1, Color(255, 255, 255, 255 * alphalerpch))
	
	draw.RoundedBox( 0, pos.x - DRCCrosshairLerp - smath - (smathoffset*2), pos.y -2, smathoffset, 3, Color(0, 0, 0, 200 * alphalerpch))
	draw.RoundedBox( 0, pos.x - DRCCrosshairLerp - smath - (smathoffset*2), pos.y -1, smathoffset, 1, Color(255, 255, 255, 255 * alphalerpch))
	
	draw.RoundedBox( 0, pos.x -1, pos.y + DRCCrosshairLerp + smath + smathoffset -1, 3, smathoffset, Color(0, 0, 0, 200 * alphalerpch))
	draw.RoundedBox( 0, pos.x, pos.y + DRCCrosshairLerp + smath + smathoffset, 1, smathoffset, Color(255, 255, 255, 255 * alphalerpch))
	
	surface.DrawCircle((pos.x), (pos.y), 64 * DRCCrosshairLerp / 50, DRCCrosshairLerp * 5, DRCCrosshairLerp * 5, DRCCrosshairLerp * 5, DRCCrosshairLerp * 2.5)
	
	surface.DrawCircle((pos.x), (pos.y), 1, 255, 255, 255, 255 * alphalerpch)
	surface.DrawCircle((pos.x), (pos.y), 2, 0, 0, 0, 10 * alphalerpch)
end
hook.Add("HUDPaint", "drc_crosshair", drc_Crosshair)