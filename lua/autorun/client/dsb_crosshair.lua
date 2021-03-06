local widthpos, heightpos = 0, 0
local function drc_Crosshair()
	if GetConVar("cl_drawhud"):GetFloat() == 0 then return end
	if GetConVar("cl_drc_disable_crosshairs"):GetFloat() == 1 then return end
	
	local ply = LocalPlayer()
	local curswep = ply:GetActiveWeapon()
	
	local centercrosshair = ply:GetEyeTrace()
	local pos = centercrosshair.HitPos:ToScreen()
	
	if curswep.SightsDown == false then
		widthpos = math.Round(pos.x)
		heightpos = math.Round(pos.y)
	elseif curswep.SightsDown == true then
		widthpos = ScrW()/2
		heightpos = ScrH()/2
	end

	local chmode = GetConVar("cl_drc_debug_crosshairmode"):GetFloat()
	
	if curswep.Draconic == nil then return end
	
	local bool1 = curswep.Weapon:GetNWBool("Inspecting")
	local bool2 = curswep.Weapon:GetNWBool("Passive")
	--local bool3 = curswep.Weapon:GetNWBool("Ironsights")
	local bool3 = curswep.SightsDown
	
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
	
		if curswep.Base == "draconic_melee_base" then
			local et = ply:GetEyeTrace()
			local hit = et.Entity
		
			if curswep.CrosshairStatic != nil then
				if curswep.CrosshairShadow == true then
					surface.SetDrawColor( curswep.CrosshairColor.r/2, curswep.CrosshairColor.g/2, curswep.CrosshairColor.b/2, alphalerpch*1.5 )
					surface.SetMaterial( Material(curswep.CrosshairStatic) )
					surface.DrawTexturedRect(widthpos, heightpos, artificial, artificial)
					surface.DrawTexturedRect(widthpos, heightpos, artificial, artificial)
				end
		
			if (hit:IsPlayer() or hit:IsNPC()) && (ply:GetPos():Distance(hit:GetPos()) < curswep.Primary.LungeMaxDist) then
				surface.SetDrawColor( Color(255, 0, 0, alphalerpch) )
			else
				surface.SetDrawColor( curswep.CrosshairColor.r, curswep.CrosshairColor.g, curswep.CrosshairColor.b, alphalerpch )
			end
			surface.SetMaterial( Material(curswep.CrosshairStatic) )
			surface.DrawTexturedRectRotated(widthpos * artificial, heightpos * artificial, ScrH()/8 * artificial, ScrH()/8 * artificial, 0)
			end
		end
	
	if curswep.Base == "draconic_melee_base" then return end
	if curswep.PrimaryStats == nil then return end
	
	local spread = curswep.PrimaryStats.Spread
	local spreaddiv = curswep.PrimaryStats.SpreadDiv
	local artificial = curswep.CrosshairSizeMul
	local cx = curswep.CrosshairCorrectX
	local cy = curswep.CrosshairCorrectY
	local smath = (spread/spreaddiv)
	local smathoffset = smath * 150
	
	local b = math.Clamp(curswep.BloomValue * 100 or 0, 0, 100) * smath * 10
	
	LerpC = Lerp(FrameTime() * 2, LerpC or b, b)
	
	if GetConVar("cl_drc_debugmode"):GetFloat() > 0 then
		if chmode == 1 or chmode == 3 then
			local heat = curswep.Weapon:GetNWInt("Heat")
			local hl = LerpVector(heat / 175, Vector(255, 255, 255), Vector(255, 0, 0))
			
			surface.SetDrawColor( hl.x, hl.y, hl.z, heat * 2.5 )
			surface.SetMaterial(Material("vgui/hud/xbox_reticle"))
			surface.DrawTexturedRect( (widthpos - (256 * 0.5) * (spread / spreaddiv) * 16), (heightpos - (256 * 0.5) * smath * 16), 256 * smath * 16, 256 * smath * 16 )
					
			surface.DrawCircle((widthpos), (heightpos), 64 * smath * 10, 255, 255, 255, 255)
			surface.DrawCircle((widthpos), (heightpos), 64 * smath * 13.37, 255, 0, 0, 255)
			surface.DrawCircle((widthpos), (heightpos), 64 * smath * 1, 0, 255, 0, 255)
			surface.DrawCircle((widthpos), (heightpos), 64 * smath * 3, 120, 255, 120, 50)
							
			surface.DrawCircle((widthpos), (heightpos), 64 * LerpC / 50.75, 0, 100, 255, 255)
			surface.DrawCircle((widthpos), (heightpos), 64 * LerpC / 52, 0, 175, 255, 255)
		end
	else end
	
	if curswep.CrosshairStatic != nil then
		if curswep.CrosshairShadow == true then
			if curswep.CrosshairNoIronFade == false then
				surface.SetDrawColor( curswep.CrosshairColor.r/2, curswep.CrosshairColor.g/2, curswep.CrosshairColor.b/2, alphalerpch * 1.5 )
			else
				surface.SetDrawColor( curswep.CrosshairColor.r/2, curswep.CrosshairColor.g/2, curswep.CrosshairColor.b/2, 150 )
			end
			surface.SetMaterial( Material(curswep.CrosshairStatic) )
			surface.DrawTexturedRect(widthpos - smathoffset * 3.3775 * artificial * cx, heightpos - smathoffset * 3.3775 * artificial * cy, smathoffset * 6.75 * artificial, smathoffset * 6.75 * artificial)
			surface.DrawTexturedRect(widthpos - smathoffset * 3.1275 * artificial * cx, heightpos - smathoffset * 3.1275 * artificial * cy, smathoffset * 6.25 * artificial, smathoffset * 6.25 * artificial)
		end
	
		if curswep.CrosshairNoIronFade == false then
			surface.SetDrawColor( curswep.CrosshairColor.r, curswep.CrosshairColor.g, curswep.CrosshairColor.b, alphalerpch )
		else
			surface.SetDrawColor( curswep.CrosshairColor.r, curswep.CrosshairColor.g, curswep.CrosshairColor.b, 255 )
		end
		surface.SetMaterial( Material(curswep.CrosshairStatic) )
		surface.DrawTexturedRect(widthpos - smathoffset * 3.25 * artificial * cx, heightpos - smathoffset * 3.25 * artificial * cy, smathoffset * 6.5 * artificial, smathoffset * 6.5 * artificial)
	end
	
	if curswep.CrosshairDynamic != nil then
		if curswep.CrosshairShadow == true then
			if curswep.CrosshairNoIronFade == false then
				surface.SetDrawColor( curswep.CrosshairColor.r/2, curswep.CrosshairColor.g/2, curswep.CrosshairColor.b/2, alphalerpch * 1.5 )
			else
				surface.SetDrawColor( curswep.CrosshairColor.r/2, curswep.CrosshairColor.g/2, curswep.CrosshairColor.b/2, 150 )
			end
			surface.SetMaterial( Material(curswep.CrosshairDynamic) )
			surface.DrawTexturedRect(widthpos - smathoffset * 3.1275 * artificial - LerpC / 2 * cx, heightpos - smathoffset * 3.1275 * artificial - LerpC / 2 * cy, smathoffset * 6.25 * artificial + LerpC, smathoffset * 6.25 * artificial + LerpC)
			surface.DrawTexturedRect(widthpos - smathoffset * 3.3775 * artificial - LerpC / 2 * cx, heightpos - smathoffset * 3.3775 * artificial - LerpC / 2 * cy, smathoffset * 6.75 * artificial + LerpC, smathoffset * 6.75 * artificial + LerpC)
		end
	
		if curswep.CrosshairNoIronFade == false then
			surface.SetDrawColor( curswep.CrosshairColor.r, curswep.CrosshairColor.g, curswep.CrosshairColor.b, alphalerpch )
		else
			surface.SetDrawColor( curswep.CrosshairColor.r, curswep.CrosshairColor.g, curswep.CrosshairColor.b, 255 )
		end
		surface.SetMaterial( Material(curswep.CrosshairDynamic) )
		surface.DrawTexturedRect(widthpos - smathoffset * 3.25 * artificial - LerpC / 2 * cx, heightpos - smathoffset * 3.25 * artificial - LerpC / 2 * cy, smathoffset * 6.5 * artificial + LerpC, smathoffset * 6.5 * artificial + LerpC)
	end
	
	if curswep.CrosshairStatic != nil or curswep.CrosshairDynamic != nil then return end
	
	draw.RoundedBox( 0, widthpos + LerpC + smath + smathoffset, heightpos -2, 22, 3, Color(0, 0, 0, 200))
	draw.RoundedBox( 0, widthpos + LerpC + 1 + smath + smathoffset, heightpos -1, 20, 1, color_white)
	
	draw.RoundedBox( 0, widthpos - LerpC - 20 - smath - smathoffset, heightpos -2, 22, 3, Color(0, 0, 0, 200))
	draw.RoundedBox( 0, widthpos - LerpC - 19 - smath - smathoffset, heightpos -1, 20, 1, color_white)
	
	draw.RoundedBox( 0, widthpos -1, heightpos + LerpC + smath + smathoffset -1, 3, 22, Color(0, 0, 0, 200))
	draw.RoundedBox( 0, widthpos, heightpos + LerpC + smath + smathoffset, 1, 20, color_white)
	
	surface.DrawCircle((widthpos), (heightpos), 64 * LerpC / 50, LerpC * 5, LerpC * 5, LerpC * 5, LerpC * 2.5)
	
	surface.DrawCircle((widthpos), (heightpos), 1, 255, 255, 255, 255)
	surface.DrawCircle((widthpos), (heightpos), 2, 0, 0, 0, 10)
end
hook.Add("HUDPaint", "drc_crosshair", drc_Crosshair)