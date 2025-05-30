--- ###Helpers
--- ###Crosshair
--- ###Scope
--- ###Inspection
--- ###Interaction
--- ###Attachments
--- ###Debug





--- ###Helpers
DRC.HUDAnchors = {
	["TL"] = {x=0, y=0}, ["T"] = {x=ScrW()/2, y=0}, ["TR"] = {x=ScrW(), y=0},
	["L"] = {x=0, y=ScrH()/2}, ["C"] = {x=ScrW()/2, y=ScrH()/2}, ["R"] = {x=ScrW(), y=ScrH()/2},
	["BL"] = {x=0, y=ScrH()}, ["B"] = {x=ScrW()/2, y=ScrH()}, ["BR"] = {x=ScrW(), y=ScrH()}
}





--- ###Crosshair
local basegameweapons = {
	["weapon_357"] = "E",
	["weapon_pistol"] = "E",
	["weapon_bugbait"] = "E",
	["weapon_crossbow"] = "E",
	["weapon_crowbar"] = "E",
	["weapon_frag"] = "E",
	["weapon_physcannon"] = "E",
	["weapon_ar2"] = "E",
	["weapon_slam"] = "E",
	["weapon_shotgun"] = "E",
	["weapon_smg1"] = "E",
	["weapon_stunstick"] = "E",
	["weapon_357_hl1"] = "E",
	["weapon_crossbow_hl1"] = "E",
	["weapon_crowbar_hl1"] = "E",
	["weapon_glock_hl1"] = "E",
	["weapon_egon"] = "E",
	["weapon_handgrenade"] = "E",
	["weapon_hornetgun"] = "E",
	["weapon_mp5_hl1"] = "E",
	["weapon_rpg_hl1"] = "E",
	["weapon_satchel"] = "E",
	["weapon_snark"] = "E",
	["weapon_shotgun_hl1"] = "E",
	["weapon_gauss"] = "E",
	["weapon_tripmine"] = "E",
	["weapon_physgun"] = "E",
	["gmod_tool"] = "E",
	["weapon_flechettegun"] = "E",
	["manhack_welder"] = "E",
	["weapon_medkit"] = "E",
}

local function ShouldDrawHLCrosshair()
	if DRC:ThirdPersonEnabled(LocalPlayer()) == true then return true end
	if GetConVar("cl_drc_experimental_fp"):GetInt() >= 1 then return true end
	return false
end

hook.Add("HUDShouldDraw", "DRC_HideBaseCrosshairThirdperson", function(str)
	local ply = LocalPlayer()
	if IsValid(ply) && ply:Alive() && IsValid(ply:GetActiveWeapon()) && !IsValid(ply:GetVehicle()) && ShouldDrawHLCrosshair() && str == "CHudCrosshair" then return false end
end)

local function CrosshairLerp(fraction, from, to)
	return Lerp(math.ease.OutQuart(fraction), from, to)
end

local function ShouldDrawCrosshair(ply)
	if GetConVar("cl_drawhud"):GetFloat() == 0 then return false end
	if GetConVar("crosshair"):GetFloat() == 0 then return false end
	if GetConVar("cl_drc_disable_crosshairs"):GetFloat() == 1 then return false end
	if DRC.SV.drc_disable_crosshairs == 1 then return false end
	
	local vehicle = ply:GetVehicle()
	if IsValid(vehicle) then return false end
	
	return true
end

local function drc_Crosshair()
	local ply = LocalPlayer()
	if !IsValid(ply) or !ply:Alive() then return end
	local curswep = ply:GetActiveWeapon()
	if !IsValid(curswep) then return end
	if !ShouldDrawCrosshair(ply) then return end
	local pos = DRC.CalcView.ToScreen
	
	if !curswep.Draconic then return end
	if curswep.DrawCrosshair == false then return end
	
	
	
	if curswep.SightsDown == false or curswep.Secondary.ScopePitch != 0 then
	elseif curswep.SightsDown && curswep.Secondary.Scoped == true then
		pos.x = ScrW()/2
		pos.y = ScrH()/2
		
		local Xalpha
		if ((pos.x > ScrW()/2 + 25) or (pos.x < ScrW()/2 - 25)) or ((pos.y > ScrH()/2 + 25) or (pos.y < ScrH()/2 - 25)) then
			Xalpha = 255
		else
			Xalpha = 0
		end
		
		surface.SetFont("DermaLarge")
		surface.SetTextColor(255, 0, 0, Xalpha)
		surface.SetTextPos(math.Round(pos.x), math.Round(pos.y))
		surface.DrawText("X", true)
	end

	local chmode = GetConVar("cl_drc_debug_crosshairmode"):GetFloat()
	
	local smode = curswep.AltSightBool
	local primscope = curswep.Secondary.Scoped
	local secscope = curswep.Secondary.ScopedAlt
	local ironcross = curswep.Secondary.IronsDrawCrosshair
	local sd = curswep.SightsDown
	
	local bool1 = curswep:GetNWBool("Inspecting")
	local bool2 = curswep:GetNWBool("Passive")
	local bool3 = false
	
	if sd then
		if smode then
			if secscope == false && ironcross == false then bool3 = true end
		else
			if primscope == false && ironcross == false then bool3 = true end
		end
	end
	
	local alph = 1
	if (bool1 == false) && (bool2 == false) && (bool3 == false) then
		alph = 1
	else
		alph = 0
	end
	alphach = Lerp(0.1, alphach or alph, alph)
	local alphargb = alphach*255
	
	local artificial = curswep.CrosshairSizeMul
	local static = curswep.CrosshairStaticSize
	local hx, hy = DRC:GetHUDScale()
	
	local modspread = nil
	local modspreaddiv = nil
	if !curswep.IsMelee then
		modspread = curswep:GetAttachmentValue("Ammunition", "Spread")
		modspreaddiv = curswep:GetAttachmentValue("Ammunition", "SpreadDiv")
	end
	
	local ccol = curswep.CrosshairColor
	
	if curswep.Base == "draconic_melee_base" then
		local target = curswep:GetConeTarget(curswep.Primary.LungeMaxDist)
		local dist = 696969
		if target then dist = ply:GetPos():Distance(target:GetPos()) end
	
			if curswep.CrosshairStatic != nil then
				if curswep.CrosshairShadow == true then
				surface.SetDrawColor( ccol.r/2, ccol.g/2, ccol.b/2, alphargb )
				surface.SetMaterial( Material(curswep.CrosshairStatic, "smooth") )
				surface.DrawTexturedRect(pos.x, pos.y, artificial, artificial)
				surface.DrawTexturedRect(pos.x, pos.y, artificial, artificial)
			end
	
		if target && (dist < curswep.Primary.LungeMaxDist) then
			surface.SetDrawColor( Color(255, 0, 0, alphargb) )
		else
			surface.SetDrawColor( curswep.CrosshairColor.r, curswep.CrosshairColor.g, curswep.CrosshairColor.b, alphargb )
		end
		surface.SetMaterial( Material(curswep.CrosshairStatic, "smooth") )
		surface.DrawTexturedRectRotated(pos.x * artificial, pos.y * artificial, ScrH()/8 * artificial, ScrH()/8 * artificial, 0)
		end
	end
	
	if curswep.Base == "draconic_melee_base" then return end
	if curswep.PrimaryStats == nil then return end
	
	
	
	local spread = (curswep.PrimaryStats.Spread * modspread)
	local spreaddiv = (curswep.PrimaryStats.SpreadDiv * modspreaddiv)
	local cx = curswep.CrosshairCorrectX
	local cy = curswep.CrosshairCorrectY
	local smath = Lerp(curswep.CrosshairFOVPower, ((spread/spreaddiv) * hx), ((spread/spreaddiv) * hx) * DRC:GetFOVScale())
	local smathoffset = smath * 150
	
	local b = math.Clamp(curswep.BloomValue * 100 or 0, 0, 100) * smath * 10
	b = math.Clamp(b, 0, 100)
	
	LerpC = CrosshairLerp(FrameTime() * 20, DRCCrosshairLerp or b, b)
	DRCCrosshairLerp = Lerp(FrameTime() * 10, DRCCrosshairLerp or LerpC, LerpC)
	DRCCrosshairLerp = math.Clamp(DRCCrosshairLerp, 0 , 512 * smath)
	
	if DRC:DebugModeEnabled() then
		if chmode == 1 or chmode == 3 then
			local heat = curswep.Weapon:GetHeat()
			local hl = LerpVector(heat / 175, Vector(255, 255, 255), Vector(255, 0, 0))
			
			surface.SetDrawColor( hl.x, hl.y, hl.z, heat * 2.5 )
			surface.SetMaterial(Material("vgui/hud/xbox_reticle"))
			surface.DrawTexturedRect( (pos.x - (256 * 0.5) * (spread / spreaddiv) * 16), (pos.y - (256 * 0.5) * smath * 16), 256 * smath * 16, 256 * smath * 16 )
					
			surface.DrawCircle((pos.x), (pos.y), 64 * smath * 10, 255, 255, 255, 255)
			surface.DrawCircle((pos.x), (pos.y), 64 * smath * 13.37, 255, 0, 0, 255)
			surface.DrawCircle((pos.x), (pos.y), 64 * smath, 0, 255, 0, 255)
			surface.DrawCircle((pos.x), (pos.y), 64 * smath * 3, 120, 255, 120, 50)
							
			surface.DrawCircle((pos.x), (pos.y), 64 * DRCCrosshairLerp / 50.75, 0, 100, 255, 255)
			surface.DrawCircle((pos.x), (pos.y), 64 * DRCCrosshairLerp / 52, 0, 175, 255, 255)
			
			if curswep.Primary.AimAssist == true then
				surface.DrawCircle((pos.x), (pos.y), 13 * curswep.SpreadCone * curswep.Primary.AimAssist_Mul * DRC:GetFOVScale(), 0, 255, 255, 255)
			end
		end
	end
	
	if DRC.CalcView.Trace then
		if DRC:IsCharacter(DRC.CalcView.Trace.Entity) && IsValid(DRC.CalcView.Trace.Entity) then
			local box = DRC.CalcView.Trace.HitBox
			local hitgroup = DRC.CalcView.Trace.Entity:GetHitBoxHitGroup(box, 0)
			if hitgroup == HITGROUP_HEAD then
				surface.SetDrawColor( ccol.r, ccol.g, ccol.b, alphargb )
				if !ShouldDrawCrosshair(ply) then surface.SetDrawColor(ccol.r, ccol.g, ccol.b, 0) end
				surface.SetMaterial( Material("vgui/circle") )
				surface.DrawTexturedRectRotated(pos.x, pos.y, 3, 3, 0)
			end
		end
	end
	
	if curswep.Crosshair != nil then
--[[		local values = curswep.Crosshair -- WIP AND BAD DO NOT USE
		local length, offset = values[10], values[11]
		local dirs = {
			["NW"] = {values[1], Vector(-offset, -offset, 0), 45},
			["N"] = {values[2], Vector(0, -offset, 0), 0},
			["NE"] = {values[3], Vector(offset, -offset, 0), -45},
			["W"] = {values[4], Vector(offset, 0, 0), -90},
			["C"] = {values[5], Vector(0, 0, 0), 0},
			["E"] = {values[6], Vector(-offset, 0, 0), 90},
			["SW"] = {values[7], Vector(-offset, offset, 0), 135},
			["S"] = {values[8], Vector(0, offset, 0), 180},
			["SE"] = {values[9], Vector(offset, offset, 0), -135}
		}
		if curswep.CrosshairNoIronFade == false then
			surface.SetDrawColor( ccol.r, ccol.g, ccol.b, alphalerpch )
		else
			surface.SetDrawColor( ccol.r, ccol.g, ccol.b, 255 )
		end
		
		for k,v in pairs(dirs) do
			local ang = v[3]
			local vpos = Vector(v[2].x * DRCCrosshairLerp, v[2].y * DRCCrosshairLerp, 0) * artificial
			local mode = v[1]
			local lengthx, lengthy = math.Clamp(math.abs(length * v[2].x), 1, 200), math.Clamp(math.abs(length * v[2].y), 1, 200)
			vpos = Vector(pos.x + vpos.x + v[2].x, pos.y + vpos.y + v[2].y, 0)
			
			if mode == nil then 
				surface.SetDrawColor(0, 0, 0, 0) 
			elseif mode == "line" then 
				if curswep.CrosshairNoIronFade == false then
					surface.SetDrawColor( ccol.r, ccol.g, ccol.b, alphalerpch )
				else
					surface.SetDrawColor( ccol.r, ccol.g, ccol.b, 255 )
				end
				draw.NoTexture()
			else
				if curswep.CrosshairNoIronFade == false then
					surface.SetDrawColor( ccol.r, ccol.g, ccol.b, alphalerpch )
				else
					surface.SetDrawColor( ccol.r, ccol.g, ccol.b, 255 )
				end
				local staticsize = smathoffset * 5 * artificial
				local staticsizeC = smathoffset * 10 * artificial
				surface.SetMaterial( Material(mode) )
				if k != "C" then
					surface.DrawTexturedRectRotated(vpos.x, vpos.y, staticsize, staticsize, ang)
				else
					surface.DrawTexturedRectRotated(vpos.x, vpos.y, staticsizeC, staticsizeC, ang)
				end
			end
			
			surface.DrawTexturedRectRotated(vpos.x, vpos.y, lengthx, lengthy, ang)
		end ]]
	else
		if !pos then return end
		if !pos.x then return end
		if !pos.y then return end
		if curswep.CrosshairStatic != nil then
			if curswep.CrosshairShadow == true then
				if curswep.CrosshairNoIronFade == false then
					surface.SetDrawColor( ccol.r/2, ccol.g/2, ccol.b/2, alphargb )
				else
					surface.SetDrawColor( ccol.r/2, ccol.g/2, ccol.b/2, 150 )
				end
				surface.SetMaterial( Material(curswep.CrosshairStatic, "smooth") )
				if curswep.CrosshairStaticSize != nil then
					surface.DrawTexturedRectRotated(pos.x-0.1 - static * cx, pos.y - static * cy, static*50, static*50, 0)
					surface.DrawTexturedRectRotated(pos.x+0.1 - static * cx, pos.y - static * cy, static*50, static*50, 0)
					surface.DrawTexturedRectRotated(pos.x - static * cx, pos.y-0.1 - static * cy, static*50, static*50, 0)
					surface.DrawTexturedRectRotated(pos.x - static * cx, pos.y+0.1 - static * cy, static*50, static*50, 0)
				else
					surface.DrawTexturedRect(pos.x - smathoffset * 3.3775 * artificial * cx, pos.y - smathoffset * 3.3775 * artificial * cy, smathoffset * 6.75 * artificial, smathoffset * 6.75 * artificial)
					surface.DrawTexturedRect(pos.x - smathoffset * 3.1275 * artificial * cx, pos.y - smathoffset * 3.1275 * artificial * cy, smathoffset * 6.25 * artificial, smathoffset * 6.25 * artificial)
				end
			end
		
			if curswep.CrosshairNoIronFade == false then
				surface.SetDrawColor( ccol.r, ccol.g, ccol.b, alphargb )
			else
				surface.SetDrawColor( ccol.r, ccol.g, ccol.b, 255 )
			end
			surface.SetMaterial( Material(curswep.CrosshairStatic, "smooth") )
			if curswep.CrosshairStaticSize != nil then
				surface.DrawTexturedRectRotated(pos.x - static * cx, pos.y - static * cy, static*50, static*50, 0)
			else
				surface.DrawTexturedRect(pos.x - smathoffset * 3.25 * artificial * cx, pos.y - smathoffset * 3.25 * artificial * cy, smathoffset * 6.5 * artificial, smathoffset * 6.5 * artificial)
			end
		end
		
		if curswep.CrosshairDynamic != nil then
			if curswep.CrosshairShadow == true then
				if curswep.CrosshairNoIronFade == false then
					surface.SetDrawColor( ccol.r/2, ccol.g/2, ccol.b/2, alphargb )
				else
					surface.SetDrawColor( ccol.r/2, ccol.g/2, ccol.b/2, 150 )
				end
				surface.SetMaterial( Material(curswep.CrosshairDynamic, "smooth") )
				surface.DrawTexturedRect(pos.x - smathoffset * 3.1275 * artificial - DRCCrosshairLerp / 2 * cx, pos.y - smathoffset * 3.1275 * artificial - DRCCrosshairLerp / 2 * cy, smathoffset * 6.25 * artificial + DRCCrosshairLerp, smathoffset * 6.25 * artificial + DRCCrosshairLerp)
				surface.DrawTexturedRect(pos.x - smathoffset * 3.3775 * artificial - DRCCrosshairLerp / 2 * cx, pos.y - smathoffset * 3.3775 * artificial - DRCCrosshairLerp / 2 * cy, smathoffset * 6.75 * artificial + DRCCrosshairLerp, smathoffset * 6.75 * artificial + DRCCrosshairLerp)
			end
		
			if curswep.CrosshairNoIronFade == false then
				surface.SetDrawColor( ccol.r, ccol.g, ccol.b, alphargb )
			else
				surface.SetDrawColor( ccol.r, ccol.g, ccol.b, 255 )
			end
			surface.SetMaterial( Material(curswep.CrosshairDynamic, "smooth") )
			surface.DrawTexturedRect(pos.x - smathoffset * 3.25 * artificial - DRCCrosshairLerp / 2 * cx, pos.y - smathoffset * 3.25 * artificial - DRCCrosshairLerp / 2 * cy, smathoffset * 6.5 * artificial + DRCCrosshairLerp, smathoffset * 6.5 * artificial + DRCCrosshairLerp)
		end
	end
	
	DRC.Crosshair = {}
	DRC.Crosshair.Size = smathoffset * 6.5 * artificial + DRCCrosshairLerp
	
	if curswep.CrosshairStatic != nil or curswep.CrosshairDynamic != nil then return end
	
	draw.RoundedBox( 0, pos.x + DRCCrosshairLerp + smath + smathoffset, pos.y -2, smathoffset, 3, Color(0, 0, 0, 200 * alphach))
	draw.RoundedBox( 0, pos.x + DRCCrosshairLerp + smath + smathoffset, pos.y -1, smathoffset, 1, Color(255, 255, 255, 255 * alphach))
	
	draw.RoundedBox( 0, pos.x - DRCCrosshairLerp - smath - (smathoffset*2), pos.y -2, smathoffset, 3, Color(0, 0, 0, 200 * alphach))
	draw.RoundedBox( 0, pos.x - DRCCrosshairLerp - smath - (smathoffset*2), pos.y -1, smathoffset, 1, Color(255, 255, 255, 255 * alphach))
	
	draw.RoundedBox( 0, pos.x -1, pos.y + DRCCrosshairLerp + smath + smathoffset -1, 3, smathoffset, Color(0, 0, 0, 200 * alphach))
	draw.RoundedBox( 0, pos.x, pos.y + DRCCrosshairLerp + smath + smathoffset, 1, smathoffset, Color(255, 255, 255, 255 * alphach))
	
	surface.DrawCircle((pos.x), (pos.y), 64 * DRCCrosshairLerp / 50, DRCCrosshairLerp * 5, DRCCrosshairLerp * 5, DRCCrosshairLerp * 5, DRCCrosshairLerp * 2.5)
	
	surface.DrawCircle((pos.x), (pos.y), 1, 255, 255, 255, 255 * alphach)
	surface.DrawCircle((pos.x), (pos.y), 2, 0, 0, 0, 10 * alphach)
end
hook.Add("HUDPaint", "drc_crosshair", drc_Crosshair)


--- ###Scope
local function drc_Scope()
	if GetConVar("cl_drawhud"):GetFloat() == 0 then return end
	local ply = LocalPlayer()
	
	if not ply:Alive() then return end
	local curswep = ply:GetActiveWeapon()
	if curswep.Draconic == nil then return end
	if curswep:CanUseSights() == false then forward = 0 return end
	local cursight = curswep.AltSightBool or false
	if cursight == false && curswep.Secondary.Scoped == false then return end
	if cursight == true && curswep.Secondary.ScopedAlt == false then return end
	--if curswep.Weapon:GetNWBool("ironsights") == false then return end
	if curswep.SightsDown == false then return end

	local w = ScrW()
	local h = ScrH()
	
	local ratio = w/h
	
	local ss = 4 * curswep.Secondary.ScopeScale
	local sw = curswep.Secondary.ScopeWidth
	local sh = curswep.Secondary.ScopeHeight
	
	local wi = w / 10 * ss
	local hi = h / 10 * ss
	
	local Q1Mat = curswep.Secondary.ScopeMat
	local Q2Mat = curswep.Secondary.Q2Mat
	local Q3Mat = curswep.Secondary.Q3Mat
	local Q4Mat = curswep.Secondary.Q4Mat
	
	local YOffset = -curswep.Secondary.ScopeYOffset
	
	surface.SetDrawColor( curswep.Secondary.ScopeBGCol )
	
	surface.DrawRect( 0, (h/2 - hi * sh) * YOffset, w/2 - hi / 2 * sw * 2, hi * 2 )
	surface.DrawRect( w/2 + hi * sw, (h/2 - hi * sh) * YOffset, w/2 + wi * sw, hi * 2 )
	surface.DrawRect( 0, 0, w * ss, h / 2 - hi * sh )
	surface.DrawRect( 0, (h/2 + hi * sh) * YOffset, w * ss, h / 1.99 - hi * sh )
	
	if curswep.Secondary.ScopeCol != nil then
		surface.SetDrawColor( curswep.Secondary.ScopeCol )
	else
		surface.SetDrawColor( Color(0, 0, 0, 255) )
	end
	
	if Q1Mat == nil then
		surface.SetMaterial(Material("sprites/scope_arc"))
	else 
		surface.SetMaterial(Material(Q1Mat))
	end
	surface.DrawTexturedRectUV( w/2 - hi / 2 * sw * 2, (h/2 - hi) * YOffset, hi * sw, hi * sh, 1, 1, 0, 0 )
	
	if Q2Mat == nil then
		if Q1Mat == nil then
			surface.SetMaterial(Material("sprites/scope_arc", "smooth"))
		else
			surface.SetMaterial(Material(Q1Mat, "smooth"))
		end
	else 
		surface.SetMaterial(Material(Q2Mat, "smooth"))
	end
	surface.DrawTexturedRectUV( w / 2, (h/2 - hi) * YOffset, hi * sw, hi * sh, 0, 1, 1, 0 )
	
	if Q3Mat == nil then
		if Q1Mat == nil then
			surface.SetMaterial(Material("sprites/scope_arc", "smooth"))
		else
			surface.SetMaterial(Material(Q1Mat, "smooth"))
		end
	else 
		surface.SetMaterial(Material(Q3Mat, "smooth"))
	end
	surface.DrawTexturedRectUV( w/2 - hi / 2 * sw * 2, h/2, hi * sw, hi * sh, 1, 0, 0, 1 )
	
	if Q4Mat == nil then
		if Q1Mat == nil then
			surface.SetMaterial(Material("sprites/scope_arc", "smooth"))
		else
			surface.SetMaterial(Material(Q1Mat, "smooth"))
		end
	else 
		surface.SetMaterial(Material(Q4Mat, "smooth"))
	end
	surface.DrawTexturedRectUV( w/2, h/2, hi * sw, hi * sh, 0, 0, 1, 1 )
	
end
hook.Add("HUDPaint", "drc_scope", drc_Scope)




--- ###Inspection
surface.CreateFont( "DRC_DermaMedium", {
	font = "Roboto",
	extended = true,
	size = 22,
	weight = 300,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "DRC_DermaDefault_Bold", {
	font = "Tahoma",
	extended = true,
	size = 13,
	weight = 700,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

DRC.Inspection = {}
DRC.Inspection.DefaultTheme = {
	["Fonts"] = {
		["Title"] = "DermaLarge",
		["Subtitle"] = "DRC_DermaDefault_Bold",
		["Header"]	= "DRC_DermaMedium",
		["Default"] = "DermaDefault",
	},
	["Colours"] = {
		["Div"] = Color(255, 255, 255, 127),
		["Title"] = Color(255, 255, 255, 255),
		["Text"] = Color(225, 225, 225, 255),
		["Text_Hover"] = Color(255, 255, 255, 255),
		["Text_Inactive"] = Color(255, 255, 255, 100),
		["Outline"] = Color(0, 0, 0, 127),
		["Background"] = Color(0, 0, 0, 127),
	},
	["Images"] = {
		["TitleBG"] = Material("vgui/draconic/titlebg.png"),
		["HeaderBG"] = Material("vgui/draconic/header.png"),
		["TabThin"] = Material("vgui/draconic/label.png"),
		["TabWide"] = Material("vgui/draconic/label_wide.png"),
		["TabWideLight"] = Material("vgui/draconic/label_wide_bright.png"),
		["Border_Top"] = Material(""),
		["Border_Side"] = Material(""),
		["Border_Bottom"] = Material(""),
		["Border_Corners"] = Material(""),
	},
	["Sounds"] = {
		["Enter"] = "garrysmod/ui_return.wav",
		["Exit"] = "garrysmod/ui_return.wav",
		["Select"] = "weapons/smg1/switch_single.wav",
		["Deny"] = "draconic/ui/deny0.wav",
		["Dropdown"] = "draconic/ui/click0.wav"
	}
}
DRC.Inspection.Theme = DRC.Inspection.DefaultTheme

local attachmenttranslations = {
	["AmmunitionTypes"] = "Ammunition",
}

local function DrawBox(posx, posy, width, height, col, bgimg)
	if bgimg then surface.SetDrawColor(Color(255, 255, 255, 255)) surface.SetMaterial(bgimg) else surface.SetDrawColor(col) draw.NoTexture() end
	surface.DrawTexturedRect( posx, posy, width, height )
end
	
local function DrawText(posx, posy, font, col, align, str)
	draw.DrawText(str, font, posx+1, posy-1, DRC.Inspection.ThemeColours.Outline, align)
	draw.DrawText(str, font, posx-1, posy+1, DRC.Inspection.ThemeColours.Outline, align)
	draw.DrawText(str, font, posx+1, posy+1, DRC.Inspection.ThemeColours.Outline, align)
	draw.DrawText(str, font, posx-1, posy-1, DRC.Inspection.ThemeColours.Outline, align)
	draw.DrawText(str, font, posx, posy+1, DRC.Inspection.ThemeColours.Outline, align)
	draw.DrawText(str, font, posx, posy-1, DRC.Inspection.ThemeColours.Outline, align)
	draw.DrawText(str, font, posx+1, posy, DRC.Inspection.ThemeColours.Outline, align)
	draw.DrawText(str, font, posx-1, posy, DRC.Inspection.ThemeColours.Outline, align)
	draw.DrawText(str, font, posx, posy, col, align)
	--draw.SimpleTextOutlined(str, font, posx, posy, col, align, TEXT_ALIGN_TOP, 1, DRC.Inspection.ThemeColours.Outline)
	-- POV: draw.DrawText is the only thing with newline support, but doesn't support outlines
end
	
local function DrawRule(posx, posy, width, height, col)
	surface.SetDrawColor(col)
	surface.DrawRect(posx, posy, width, height)
end

local attalpha, attalphalerp = 0
local function drc_Inspect()
	if GetConVar("cl_drawhud"):GetFloat() == 0 then return end
	if DRC.SV.drc_inspect_hideHUD == 1 then return end
	
	local ply = LocalPlayer() 
	local wpn = ply:GetActiveWeapon()
	if wpn.Draconic == nil then return end
	local bool = wpn:GetNWBool("Inspecting", false)
	
	local b2 = wpn.Customizing
	local w = ScrW()
	local h = ScrH()
	local ratio = w/h
	local w2 = ScrW()/2
	local h2 = ScrH()/2
	local theme = DRC.Inspection.Theme
	local themecolours = DRC.Inspection.Theme.Colours
	
	if b2 then
		attalpha = 255
		drc_ins_offsetlerp_x_att = Lerp(0.025 * 10, drc_ins_offsetlerp_x_att or w/2, 0)
		drc_ins_offsetlerp_y_att = Lerp(0.025 * 10, drc_ins_offsetlerp_y_att or h/2, 0)
	else
		attalpha = 0
		drc_ins_offsetlerp_x_att = Lerp(0.025 * 10, drc_ins_offsetlerp_x_att or 0, w)
		drc_ins_offsetlerp_y_att = Lerp(0.025 * 10, drc_ins_offsetlerp_y_att or 0, h)
	end
	attalphalerp = Lerp(0.25, attalphalerp or attalpha, attalpha)
	
	if bool == true then
		alpha = Lerp(1, 0, 1)
		YOffset = Lerp(1, h/2, 0)
		XOffset = Lerp(1, w/2, 0)
		
		drc_ins_offsetlerp_x = Lerp(0.025 * 10, drc_ins_offsetlerp_x or XOffset, XOffset)
		drc_ins_offsetlerp_y = Lerp(0.025 * 10, drc_ins_offsetlerp_y or YOffset, YOffset)
	else
		alpha = Lerp(0, 1, 0)
		YOffset = Lerp(1, 0, h )
		XOffset = Lerp(1, 0, w )
		
		drc_ins_offsetlerp_x = Lerp(0.025 * 2.5, drc_ins_offsetlerp_x or w/w2/2, w/2)
		drc_ins_offsetlerp_y = Lerp(0.025 * 2.5, drc_ins_offsetlerp_y or h/h2/2, h/2)
	end
	if bool == false then return end
	
	DRC.Inspection.ThemeColours = {}
	for k,v in pairs(themecolours) do
		DRC.Inspection.ThemeColours[k] = Color(v.r, v.g, v.b, v.a * alpha)
	end
	
	DRC.Inspection.ThemeColours_Attachments = {}
	for k,v in pairs(themecolours) do
		DRC.Inspection.ThemeColours_Attachments[k] = Color(v.r, v.g, v.b, v.a * (attalphalerp/255))
	end
	
	inspecttextpos_x = drc_ins_offsetlerp_x + w - w2/2 - (w2/2)
	inspecttextpos_y = drc_ins_offsetlerp_y + h - h2/2 - (h2/2)
	
	surface.SetDrawColor( DRC.Inspection.ThemeColours.Background )
--	DrawRule(w-500+drc_ins_offsetlerp_x, h*0.02 - 3, 500, 1, DRC.Inspection.ThemeColours.Div)
	DrawBox(w-500+drc_ins_offsetlerp_x, h*0.02, 500, 76, DRC.Inspection.ThemeColours.Background, theme.Images.TitleBG)
	DrawText(w-250+drc_ins_offsetlerp_x, h*0.02 + 22, theme.Fonts.Title, DRC.Inspection.ThemeColours.Title, TEXT_ALIGN_CENTER, "".. wpn.PrintName .."")
	if wpn.InfoName then DrawText(w-250+drc_ins_offsetlerp_x, h*0.02 + 54, theme.Fonts.Subtitle, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_CENTER, "''".. wpn.InfoName .."''") end
	
	DrawBox(w-200+drc_ins_offsetlerp_x, h*0.02 + 86, 200, 16, DRC.Inspection.ThemeColours.Background, theme.Images.TabWide)
	DrawText(w-16+drc_ins_offsetlerp_x, h*0.02 + 86, theme.Fonts.Subtitle, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_RIGHT, "".. wpn.Category .."")
	DrawBox(w-150+drc_ins_offsetlerp_x, h*0.02 + 104, 150, 16, DRC.Inspection.ThemeColours.Background, theme.Images.TabWide)
	DrawText(w-16+drc_ins_offsetlerp_x, h*0.02 + 104, theme.Fonts.Subtitle, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_RIGHT, "".. wpn.Author .."")
	
	local infoy = 136
	
	if wpn.Manufacturer or wpn.InfoDescription then
		DrawRule(w-500+drc_ins_offsetlerp_x, h*0.02 + infoy - 3, 500, 1, DRC.Inspection.ThemeColours.Div)
		DrawBox(w-500+drc_ins_offsetlerp_x, h*0.02 + infoy, 300, 34, DRC.Inspection.ThemeColours.Background, theme.Images.HeaderBG)
		DrawText(w-350+drc_ins_offsetlerp_x, h*0.02 + infoy+6, theme.Fonts.Header, DRC.Inspection.ThemeColours.Title, TEXT_ALIGN_CENTER, "Weapon Information")
		
		if wpn.Manufacturer then
			infoy = 175
			DrawBox(w-500+drc_ins_offsetlerp_x, h*0.02 + infoy, 100, 18, DRC.Inspection.ThemeColours.Background, theme.Images.TabWide)
			DrawText(w-405+drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Subtitle, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_RIGHT, "Manufacturer :")
			DrawBox(w-395+drc_ins_offsetlerp_x, h*0.02 + infoy, 380, 18, DRC.Inspection.ThemeColours.Background)
			DrawText(w-390+drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_LEFT, "".. wpn.Manufacturer .."")
		end
		
		if wpn.InfoDescription then
			if infoy != 136 then infoy = infoy + 20 else infoy = 175 end
			DrawBox(w-500+drc_ins_offsetlerp_x, h*0.02 + infoy, 100, 18, DRC.Inspection.ThemeColours.Background, theme.Images.TabWide)
			DrawText(w-405+drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Subtitle, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_RIGHT, "Information :")
			DrawBox(w-395+drc_ins_offsetlerp_x, h*0.02 + infoy, 380, 60, DRC.Inspection.ThemeColours.Background)
			DrawText(w-390+drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_LEFT, "".. wpn.InfoDescription .."")
		end
	end
	
	if infoy != 136 then infoy = infoy + 65 end
	DrawRule(w-500+drc_ins_offsetlerp_x, h*0.02 + infoy - 3, 500, 1, themecolours.Div)
	DrawBox(w-500+drc_ins_offsetlerp_x, h*0.02 + infoy, 300, 34, DRC.Inspection.ThemeColours.Background, theme.Images.HeaderBG)
	DrawText(w-350+drc_ins_offsetlerp_x, h*0.02 + infoy+6, theme.Fonts.Header, DRC.Inspection.ThemeColours.Title, TEXT_ALIGN_CENTER, "Handling Information")
	
	if wpn.Base != "draconic_melee_base" then
		infoy = infoy + 39
		DrawBox(w-500+drc_ins_offsetlerp_x, h*0.02 + infoy, 100, 18, DRC.Inspection.ThemeColours.Background, theme.Images.TabWide)
		DrawText(w-405+drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Subtitle, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_RIGHT, "Damage :")
		DrawBox(w-395+drc_ins_offsetlerp_x, h*0.02 + infoy, 380, 18, DRC.Inspection.ThemeColours.Background)
			
		if wpn.PrimaryStats.Projectile != nil then
			local projectile = {}
			if istable(wpn.PrimaryStats.Projectile) then projectile = scripted_ents.GetStored(wpn.PrimaryStats.Projectile[1]) else
		 projectile = scripted_ents.GetStored(wpn.PrimaryStats.Projectile) end
			if projectile.t.ProjectileType == "supercombine" then
				DrawText(w-390+drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_LEFT, "Base: ".. projectile.t.Damage .." | Supercombine: ".. projectile.t.SuperDamage .."")
			else
				local damagestring = "".. projectile.t.Damage ..""
				if wpn:GetAttachmentValue("Ammunition", "NumShots") != 1 then damagestring = "".. damagestring .."x".. wpn:GetAttachmentValue("Ammunition", "NumShots") .."" end
				DrawText(w-390+drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_LEFT, "".. damagestring .." per round, ".. math.Round((wpn.PrimaryStats.RPM/60 * projectile.t.Damage) * wpn:GetAttachmentValue("Ammunition", "NumShots"), 2) .." DPS")
			end
		else
			local damagestring = "".. wpn.PrimaryStats.Damage * wpn:GetAttachmentValue("Ammunition", "Damage") ..""
			
			if wpn:GetAttachmentValue("Ammunition", "NumShots") != 1 then damagestring = "".. damagestring .."x".. wpn:GetAttachmentValue("Ammunition", "NumShots") .."" end
			DrawText(w-390+drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_LEFT, "".. damagestring .." per round, ".. math.Round((wpn.PrimaryStats.Damage * wpn:GetAttachmentValue("Ammunition", "NumShots") * wpn:GetAttachmentValue("Ammunition", "Damage")) * wpn.PrimaryStats.RPM/60, 2) .." DPS")
		end
		
		infoy = infoy + 20
		DrawBox(w-500+drc_ins_offsetlerp_x, h*0.02 + infoy, 100, 18, DRC.Inspection.ThemeColours.Background, theme.Images.TabWide)
		DrawBox(w-395+drc_ins_offsetlerp_x, h*0.02 + infoy, 380, 18, DRC.Inspection.ThemeColours.Background)
		DrawText(w-405+drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Subtitle, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_RIGHT, "Ammo :")
		if wpn.Base == "draconic_gun_base" then
			DrawText(w-390+drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_LEFT, "".. wpn:Clip1() .."/".. (wpn:GetMaxClip1() * wpn:GetAttachmentValue("Ammunition", "ClipSizeMul")) .." | ".. wpn.ActiveAttachments.AmmunitionTypes.t.InfoName .." (".. (game.GetAmmoName(wpn:GetPrimaryAmmoType()) or "None") ..")")
		else
			DrawText(w-390+drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_LEFT, "".. math.Round(wpn:GetNWInt("LoadedAmmo"), 2) .."% (".. math.Round(100/wpn.BatteryConsumePerShot * (wpn:GetNWInt("LoadedAmmo")/100)) .." Shots remaining) | ".. wpn.ActiveAttachments.AmmunitionTypes.t.InfoName .."")
		end
		
		infoy = infoy + 20
		DrawBox(w-500+drc_ins_offsetlerp_x, h*0.02 + infoy, 100, 18, DRC.Inspection.ThemeColours.Background, theme.Images.TabWide)
		DrawBox(w-395+drc_ins_offsetlerp_x, h*0.02 + infoy, 380, 18, DRC.Inspection.ThemeColours.Background)
		DrawText(w-405+drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Subtitle, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_RIGHT, "Firerate :")
		if wpn.Base == "draconic_gun_base" then
			DrawText(w-390+drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_LEFT, "".. wpn.PrimaryStats.RPM .." Rounds per minute | ".. math.Round(wpn.PrimaryStats.RPM/60, 2) .." Rounds per second")
		else
			if wpn.LowerRPMWithHeat == true then
				DrawText(w-390+drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_LEFT, "".. wpn.PrimaryStats.RPM .." - ".. wpn.BatteryStats.HeatRPMmin .." RPM | ".. math.Round(wpn.PrimaryStats.RPM/60, 2) .." - ".. math.Round(wpn.BatteryStats.HeatRPMmin/60, 2) .." RPS")
			else
				DrawText(w-390+drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_LEFT, "".. wpn.PrimaryStats.RPM .." RPM | ".. math.Round(wpn.PrimaryStats.RPM/60, 2) .." RPS")
			end
		end
		
		local sp, spd, kick = wpn:GetAttachmentValue("Ammunition", "Spread"), wpn:GetAttachmentValue("Ammunition", "SpreadDiv"), wpn:GetAttachmentValue("Ammunition", "Kick")
		local spreadmin = math.Round(((wpn.PrimaryStats.Spread * sp) / ((wpn.PrimaryStats.SpreadDiv) * spd)), 2)
		local spreadmax = math.Round(((wpn.PrimaryStats.Spread * sp) / ((wpn.PrimaryStats.SpreadDiv) * spd)) * 130, 2)
		local kick1, kick2 = math.Clamp((wpn.Primary.Kick)*100, 0, 100) * kick, math.Clamp((wpn.Primary.Kick)*100, 0, 100) + 0.1 * kick
		local rec1, rec2 = math.Clamp(math.Round((wpn.Primary.Kick * 2+0.1*100) * kick), 0, 100), math.Clamp(math.Round((wpn.Primary.Kick * 1.5)*100 * kick), 0, 100)
		infoy = infoy + 20
		DrawBox(w-500+drc_ins_offsetlerp_x, h*0.02 + infoy, 100, 18, DRC.Inspection.ThemeColours.Background, theme.Images.TabWide)
		DrawBox(w-395+drc_ins_offsetlerp_x, h*0.02 + infoy, 380, 18, DRC.Inspection.ThemeColours.Background)
		DrawText(w-405+drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Subtitle, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_RIGHT, "Spread :")
		DrawText(w-390+drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_LEFT, "".. spreadmin .."° - ".. spreadmax .."° | ".. kick1 .." - " .. kick2 .."% per shot | ".. rec1 .." - ".. rec2 .."% Recovery / ".. math.Round((60 / wpn.Primary.RPM) * 3, 2) .." seconds")
	else
		infoy = infoy + 39
		DrawBox(w-500+drc_ins_offsetlerp_x, h*0.02 + infoy, 100, 18, DRC.Inspection.ThemeColours.Background)
		DrawText(w-405+drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Subtitle, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_RIGHT, "Damage :")
		DrawBox(w-395+drc_ins_offsetlerp_x, h*0.02 + infoy, 380, 18, DRC.Inspection.ThemeColours.Background)
		
		local secondary = wpn.Secondary.Damage
		if secondary != 0 then secondary = " | ".. secondary .." (Secondary)" else secondary = "" end
		local lunge = wpn.Primary.LungeDamage
		if lunge != 0 then lunge = " | ".. lunge .." (Lunge)" else lunge = "" end
		
		DrawText(w-390+drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_LEFT, "".. wpn.Primary.Damage .." (Primary)".. secondary .."".. lunge .."")
	end
	
	
	if wpn.AttachmentTitles then
		infoy = 0
		
		DrawBox(220-drc_ins_offsetlerp_x_att, h*0.02 + infoy, 300, 76, DRC.Inspection.ThemeColours_Attachments.Background, theme.Images.TitleBG)
		DrawText(368-drc_ins_offsetlerp_x_att, h*0.02 + infoy+20, theme.Fonts.Title, DRC.Inspection.ThemeColours_Attachments.Title, TEXT_ALIGN_CENTER, wpn.AttachmentTitles.Header)
		DrawRule(20-drc_ins_offsetlerp_x_att, h*0.02 + infoy + 85, 500, 1, DRC.Inspection.ThemeColours_Attachments.Div)
		
--[[		infoy = infoy + 70
		for k,v in pairs(wpn.AttachmentTable) do
			if k != "BaseClass" then
			infoy = infoy + 20
			
			DrawBox(220-drc_ins_offsetlerp_x, h*0.02 + infoy, 300, 34, themecolours.Background, theme.Images.HeaderBG)
			DrawText(375-drc_ins_offsetlerp_x, h*0.02 + infoy+6, theme.Fonts.Header, colours.Title, TEXT_ALIGN_CENTER, "".. attachmenttranslations[k] .."")
			
			infoy = infoy+20
			for k,v in pairs(v) do
				local mod = math.fmod(#wpn.AttachmentTable, 2)
				if scripted_ents.GetStored(v) then
					local name = scripted_ents.GetStored(v).t.InfoName
					infoy = infoy + 20
					DrawBox(20-drc_ins_offsetlerp_x, h*0.02 + infoy, 250, 18, themecolours.Background, theme.Images.TabWide)
					DrawText(250-drc_ins_offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Subtitle, colours.Text, TEXT_ALIGN_RIGHT, "".. name .."")
				end
			end
			
			end
		end --]]
	end
	
	--[[
	infoy = infoy + 20
	DrawBox(w-395+drc_ins_offsetlerp_x, h*0.02 + infoy, 380, 380)
	surface.DrawCircle(w-197.5+drc_ins_offsetlerp_x, infoy+190, spreadmax * 5, 200, 200, 200, 255)
	surface.DrawCircle(w-197.5+drc_ins_offsetlerp_x, infoy+190, spreadmax * 6.5, 255, 0, 0, 50)
	surface.DrawCircle(w-197.5+drc_ins_offsetlerp_x, infoy+190, math.Clamp(spreadmin, 0.4, 999) * 5, 0, 200, 0, 255)
	--]]
end


hook.Add("HUDPaint", "drc_inspection_menu", drc_Inspect)

hook.Add("PreDrawViewModel", "drc_inspection_dof", function(vm, ply, wpn)
	if wpn.Draconic == nil then return end
	if wpn.Initialized != true then return end
	local alpha = 0
	local bool = wpn:GetNWBool("Inspecting")
	if bool == true then
		alpha = Lerp(wpn.SightInt, 0, 5)
		DrawToyTown(1 * alpha, ScrH()/1.25)
	end
end)





-- ###Interaction
local bool, alpha, alphalerp, SwapCD = true, 0, 0, 0
local function drc_IText()
	if GetConVar("cl_drawhud"):GetFloat() == 0 then return end
	local ply = LocalPlayer()
	local center = { ScrW()/2, ScrH()/2 }
	local curswep = ply:GetActiveWeapon()
	
	
	if !IsValid(ply.ViableWeapons) then ply.ViableWeapons = {} end
	if !IsValid(ply.PickupWeapons) then ply.PickupWeapons = {} end
	
	ViableWeaponCheck(ply)
	
	local b1, b2, b3, b4
	if table.IsEmpty(ply.ViableWeapons) then b1 = false else b1 = true end
	if table.IsEmpty(ply.PickupWeapons) then b2 = false else b2 = true end
	if curswep.Draconic && curswep:CanCustomize() then b3 = true else b3 = false end
	b4 = curswep.Customizing
	
	
	if b1 or b2 or b3 then
		alpha = 255
	else
		alpha = 0
	end
	alphalerp = Lerp(0.25, alphalerp or alpha, alpha)
	
--	local wpc = ply:GetNWVector("EnergyTintVec")
--	wpc.r = math.Clamp(wpc.r, 0.1, 1)
--	wpc.g = math.Clamp(wpc.g, 0.1, 1)
--	wpc.b = math.Clamp(wpc.b, 0.1, 1)
--	wpc = wpc * 255
--	local TextCol = Color(wpc.r, wpc.g, wpc.b, alphalerp)
	local TextCol = Color(255, 255, 255, alphalerp)
	
	surface.SetDrawColor(TextCol)
	
	
	if b3 && !b4 then draw.DrawText("Press ".. string.upper(ReturnKey("+zoom")) .." to ".. curswep.ModifyText .."", "ApercuStatsTitle", center[1], center[2]*1.5+16, TextCol, TEXT_ALIGN_CENTER) end
	
	local src, text = nil, nil
	if b2 then
		src = ply.PickupWeapons[1]
		text = "pick up"
	end
	if b1 then
		src = ply.ViableWeapons[1]
		text = "swap for"
	end
	if b1 && b2 then text = "swap for" end
	
	if b1 or b2 then
		if src.WepSelectIcon != nil then
			if isnumber(src.WepSelectIcon) then
				surface.SetTexture( src.WepSelectIcon )
			elseif isstring(src.WepSelectIcon) then
				surface.SetTexture( surface.GetTextureID( src.WepSelectIcon ) )
			end
			surface.DrawTexturedRect(center[1]+86, center[2]*1.5-32, 128, 128)
			draw.DrawText("Press ".. string.upper(ReturnKey("+use")) .." to ".. text .." ", "ApercuStatsTitle", center[1]-64, center[2]*1.5+16, TextCol, TEXT_ALIGN_CENTER)
		else
			draw.DrawText("Press ".. string.upper(ReturnKey("+use")) .." to ".. text .." ".. src.PrintName .."", "ApercuStatsTitle", center[1]-64, center[2]*1.5+16, TextCol, TEXT_ALIGN_CENTER)
		end
	end
	
	
end
hook.Add("HUDPaint", "drc_interactiontext", drc_IText)

hook.Add("PreDrawViewModel", "drc_interact_hidevm", function(vm, ply, wep)
	local wpn = ply:GetActiveWeapon()
	if wpn.Draconic == true then
		if wpn.SightsDown == false then return end
		local hide = wpn.Secondary.ScopeHideVM == true
		if (hide && wpn.AltSightBool != true && wpn.Secondary.Scoped == true) then return true end
		if (hide && wpn.AltSightBool == true && wpn.Secondary.ScopedAlt == true) then return true end
	end
	if ply:GetNWBool("Interacting") == true then return true end
end)
hook.Add("PostDrawViewModel", "drc_interact_hidevm", function(vm, ply, wep)
	local wpn = ply:GetActiveWeapon()
	if wpn.Draconic == true then
		if wpn.SightsDown == false then return end
		local hide = wpn.Secondary.ScopeHideVM == true
		if (hide && wpn.AltSightBool != true && wpn.Secondary.Scoped == true) then return true end
		if (hide && wpn.AltSightBool == true && wpn.Secondary.ScopedAlt == true) then return true end
	end
	if ply:GetNWBool("Interacting") == true then return true end
end)
hook.Add("PostDrawViewHands", "drc_interact_hidevm", function(vm, ply, wep)
	if ply:GetActiveWeapon().Draconic == true && ply:GetActiveWeapon().SightsDown == true then return true end
	if ply:GetNWBool("Interacting") == true then return true end
end)





-- ###Attachments
local attachpos = {
	["Ammunition"] = Vector(10, 0, 0),
	["Clipazine"] = Vector(0, 0, 0),
	["Optic"] = Vector(0, 0, 0),
	["Foregrip"] = Vector(0, 0, 0),
	["Barrel"] = Vector(0, 0, 0),
	["Stock"] = Vector(0, 0, 0),
	["Internal"] = Vector(0, 0, 0),
	["Charm"] = Vector(0, 0, 0)
}

function DRC:ToggleAttachmentMenu(wpn, b)
	if !IsValid(wpn) then return end
	local ply = LocalPlayer()
	local theme = DRC.Inspection.Theme
	local themecolours = DRC.Inspection.Theme.Colours
	
	wpn.Customizing = b
	if !DRC.AttachMenu then DRC.AttachMenu = {} end
	local AT, AA = wpn.AttachmentTable, wpn.ActiveAttachments
	
	if b == true then
		if !DRC.Inspection then return end
		if !DRC.Inspection.ThemeColours then return end
		if !DRC.Inspection.ThemeColours_Attachments then return end
		surface.PlaySound(DRC.Inspection.Theme.Sounds.Enter)
		if DRC.AttachMenu.mpanel then DRC.AttachMenu.mpanel:Remove() end
		DRC.AttachMenu.mpanel = vgui.Create("DPanel")
		local m = DRC.AttachMenu.mpanel
		m:SetPos(20, 128)
		m:SetSize(500, 80)
		m:SetMouseInputEnabled(true)
		m:SetPaintBackground(true)
		m:MakePopup()
		function m:Paint(w,h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0,0,0,0))
		end
		m.Think = function()
			m:SetPos(20-drc_ins_offsetlerp_x_att, 128)
		end
		
		if DRC.AttachMenu.spanel then DRC.AttachMenu.spanel:Remove() end
		DRC.AttachMenu.spanel = vgui.Create("DScrollPanel")
		local s = DRC.AttachMenu.spanel
		s:SetPos(20, 128)
		s:SetSize(500, ScrH()*.75)
		s:SetMouseInputEnabled(true)
		s:SetPaintBackground(true)
		s:MakePopup()
		function s:Paint(w,h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0,0,0,0))
		end
		s.Think = function()
			s:SetPos(20-drc_ins_offsetlerp_x_att, 128 + m:GetTall() + 20)
		end
		
		m.Sections = {}
		s.Items = {}
		m.CamoButtons = {}
		
		local function MakeSelectionMenu(relevancy)
			m[relevancy].Section = vgui.Create("DScrollPanel", s)
			local section = m[relevancy].Section
			section.Panels = {}
			section:SetPos(0, 0)
			section:SetSize(s:GetWide(), ScrH()*.5)
			section:SetBackgroundColor(Color(0,0,0,0))
			section:Dock(TOP)
			section:SetVisible(false)
			section:SetContentAlignment(4)
			
			local scroll = section:GetVBar()
			function scroll:Paint(w, h)
				DrawBox(0, 0, w, h, DRC.Inspection.ThemeColours.Background, theme.Images.TabWide)
			end
			function scroll.btnUp:Paint(w, h)
				DrawBox(0, 0, w, h, DRC.Inspection.ThemeColours.Background, theme.Images.TabWide)
				DrawText(0, 0, theme.Fonts.Text, DRC.Inspection.ThemeColours.Title, TEXT_ALIGN_LEFT, "  ^")
			end
			function scroll.btnDown:Paint(w, h)
				DrawBox(0, 0, w, h, DRC.Inspection.ThemeColours.Background, theme.Images.TabWide)
				DrawText(0, 0, theme.Fonts.Text, DRC.Inspection.ThemeColours.Title, TEXT_ALIGN_LEFT, "  v")
			end
			function scroll.btnGrip:Paint(w, h)
				DrawBox(0, 0, w, h, DRC.Inspection.ThemeColours.Div, theme.Images.TabWideLight)
			end
			
			return section
		end
		
		local cbuttons = {}
		
		local function MakeSection(relevancy)
			if #wpn.AttachmentTable[relevancy] < 2 then return end
			m[relevancy] = vgui.Create("DPanel", m)
			m[relevancy]:SetBackgroundColor(DRC.Inspection.ThemeColours_Attachments.Background)
			m[relevancy]:Dock(TOP)
			
			table.insert(m.Sections, m[relevancy])
			
			local label = ""
			if wpn.ActiveAttachments[relevancy] then label = " | ".. wpn.ActiveAttachments[relevancy].t.InfoName ..""
			else label = " | Not Implemented Yet" end
			m[relevancy].Title = vgui.Create("DLabel", m[relevancy])
			local title = m[relevancy].Title
			title:SetSize(500, m[relevancy]:GetTall())
			title:SetText("          ".. wpn.AttachmentTitles[relevancy] .."")
			title:SetFont(DRC.Inspection.Theme.Fonts.Header)
			title:Dock(TOP)
			
			m[relevancy].Selected = vgui.Create("DLabel", m[relevancy])
			local selected = m[relevancy].Selected
			selected:SetSize(400, m[relevancy]:GetTall())
			selected:SetText(label)
			selected:SetFont(DRC.Inspection.Theme.Fonts.Header)
			selected:SetPos(125, 0)
			
			m[relevancy].Collapser = vgui.Create("DButton", m[relevancy])
			local cbutton = m[relevancy].Collapser
			cbutton:SetPos(0, 0)
			cbutton:SetSize(m[relevancy]:GetTall(), m[relevancy]:GetTall())
			cbutton:SetFont(DRC.Inspection.Theme.Fonts.Header)
			cbutton:SetTextColor(DRC.Inspection.ThemeColours_Attachments.Text)
			cbutton:SetText("+")
			function cbutton:Paint(w,h)
				draw.RoundedBox(0, 0, 0, w, h, DRC.Inspection.ThemeColours_Attachments.Background)
			end
			
			local selection = MakeSelectionMenu(relevancy)
			local bounds = selection:GetBounds()
			
			cbutton.DoClick = function()
				if selection:IsVisible() == true then
					selection:SetVisible(false)
					cbutton:SetText("+")
					for k,v in pairs(m.CamoButtons) do v:SetVisible(false) end
				else
					for k,v in pairs(cbuttons) do
						if v[1] != cbutton then
							v[1]:SetText("+")
							v[2]:SetVisible(false)
						end
					end
					selection:SetVisible(true)
					for k,v in pairs(m.CamoButtons) do v:SetVisible(false) end
					cbutton:SetText(">") end
				for k,v in pairs(m.Sections) do v:Dock(TOP) end
				surface.PlaySound(DRC.Inspection.Theme.Sounds.Dropdown)
			end
			
			cbuttons[relevancy] = {cbutton, selection}
			
			local function GetCanUseAttachment(class, rel)
				if class == wpn.AttachmentTable[rel][1] then return true end
				if DRC.SV.drc_attachments_autounlock != 0 then return true end
				if table.HasValue(ply.DRCAttachmentInventory, class) then return true end
				return false
			end
			
			local tab = {}
			if wpn.AttachmentTable[relevancy] then tab = wpn.AttachmentTable[relevancy] end
			for k,v in pairs(tab) do
				if !istable(v) then
					if scripted_ents.GetStored(v) then
						local selection = m[relevancy].Section
						local pnl = vgui.Create("DButton", selection)
						local info = scripted_ents.GetStored(v).t
						
						pnl:SetSize(s:GetWide(), 100)
						pnl:SetPos(0, 0)
						pnl:Dock(TOP)
						pnl:SetPaintBackground(true)
						pnl:SetText("")
						pnl.class = info.ClassName
						pnl.Paint = function(self, w,h)
							DrawBox(0, 0, w, h, DRC.Inspection.ThemeColours.Background, theme.Images.HeaderBG)
							DrawText(self:GetWide()-20, 10, theme.Fonts.Header, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_RIGHT, info.InfoName)
							if self:IsHovered() then 
								DrawText(self:GetWide()-20, 35, theme.Fonts.Default, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_RIGHT, info.InfoDescription)
							else
								if info.InfoDescription != nil && info.InfoDescription != "" then
								DrawText(self:GetWide()-20, 35, "DripIcons_Menu", DRC.Inspection.ThemeColours.Text_Inactive, TEXT_ALIGN_RIGHT, "b")
								end
							end
						end
						
						pnl.DoClick = function()
							if GetCanUseAttachment(info.ClassName, relevancy) then
								local infoname, att, slot = info.InfoName, info.ClassName, relevancy
								selected:SetText(" | ".. infoname .."")
								
								net.Start("DRC_WeaponAttachSwitch")
								net.WriteEntity(wpn)
								net.WriteEntity(LocalPlayer())
								net.WriteString(att)
								net.WriteString(slot)
								net.SendToServer()
							else
								surface.PlaySound(DRC.Inspection.Theme.Sounds.Deny)
							end
						end
						
						m[relevancy].Section[k] = vgui.Create("DModelPanel", pnl)
						local icon = m[relevancy].Section[k]
						icon:SetModel(info.Model or "models/Items/item_item_crate.mdl")
						icon:SetSize(pnl:GetTall(), pnl:GetTall())
						icon:SetAnimated(true)
						icon:RunAnimation()
						icon:SetFOV(info.PreviewFOV or 20)
						icon:SetLookAt(Vector())
						icon:GetEntity().Preview = true
						if !info.PreviewDistance then info.PreviewDistance = 145 end
						icon:SetCamPos(Vector(-info.PreviewDistance, 0, 45))
						function icon:LayoutEntity(ent)
							ent:SetPos(Vector(0,0, -15) + (info.PreviewOffset or Vector(0,0,0)))
							ent:SetAngles(Angle(0, RealTime()*30,  0))
						end
						
						if !GetCanUseAttachment(info.ClassName, relevancy) then
							icon:SetEnabled(false)
							
							local blocker = vgui.Create("DImageButton", icon)
							blocker:SetSize(icon:GetWide(), icon:GetTall())
							blocker:SetImage("gui/cross.png")
							blocker:SetColor(Color(255, 0, 0, 127))
							
							blocker.DoClick = function()
								surface.PlaySound(DRC.Inspection.Theme.Sounds.Deny)
							end
						end
						
						selection.Panels[v] = {icon, info.ClassName, info.InfoName}
						selection[icon] = {info.ClassName, info.InfoName, relevancy}
					end
				end
			end
		end
		
		for k,v in pairs(wpn.DummyAttachmentTable) do
			if k != "BaseClass" then MakeSection(k) end
		end
		
		local function MakeSkinSelection()
			local relevancy = "WeaponSkin"
			m[relevancy] = vgui.Create("DPanel", m)
			m[relevancy]:SetBackgroundColor(DRC.Inspection.ThemeColours_Attachments.Background)
			m[relevancy]:Dock(TOP)
			
			table.insert(m.Sections, m[relevancy])
			
			local label = " | None"
			if wpn.WeaponSkinAppliedName != nil then label = " | ".. wpn.WeaponSkinAppliedName end
			m[relevancy].Title = vgui.Create("DLabel", m[relevancy])
			local title = m[relevancy].Title
			title:SetSize(500, m[relevancy]:GetTall())
			title:SetText("          Camo")
			title:SetFont(DRC.Inspection.Theme.Fonts.Header)
			title:Dock(TOP)
			
			m[relevancy].Selected = vgui.Create("DLabel", m[relevancy])
			local selected = m[relevancy].Selected
			selected:SetSize(400, m[relevancy]:GetTall())
			selected:SetText(label)
			selected:SetFont(DRC.Inspection.Theme.Fonts.Header)
			selected:SetPos(125, 0)
			
			m[relevancy].Collapser = vgui.Create("DButton", m[relevancy])
			local cbutton = m[relevancy].Collapser
			cbutton:SetPos(0, 0)
			cbutton:SetSize(m[relevancy]:GetTall(), m[relevancy]:GetTall())
			cbutton:SetFont(DRC.Inspection.Theme.Fonts.Header)
			cbutton:SetTextColor(DRC.Inspection.ThemeColours_Attachments.Text)
			cbutton:SetText("+")
			function cbutton:Paint(w,h)
				draw.RoundedBox(0, 0, 0, w, h, DRC.Inspection.ThemeColours_Attachments.Background)
			end
			
			local selection = MakeSelectionMenu(relevancy)
			local bounds = selection:GetBounds()
			
			cbutton.DoClick = function()
				if selection:IsVisible() == true then
					selection:SetVisible(false)
					cbutton:SetText("+")
					for k,v in pairs(m.CamoButtons) do v:SetVisible(false) end
				else
					for k,v in pairs(cbuttons) do
						if v[1] != cbutton then
							v[1]:SetText("+")
							v[2]:SetVisible(false)
							for k,v in pairs(m.CamoButtons) do v:SetVisible(false) end
						end
					end
					selection:SetVisible(true)
					for k,v in pairs(m.CamoButtons) do v:SetVisible(true) end
					cbutton:SetText(">")
				end
				
				for k,v in pairs(m.Sections) do v:Dock(TOP) end
				surface.PlaySound(DRC.Inspection.Theme.Sounds.Dropdown)
			end
			
			cbuttons[relevancy] = {cbutton, selection}
			
			local function GetCanUseAttachment(class, rel)
				if class == wpn.AttachmentTable[rel][1] then return true end
				if DRC.SV.drc_attachments_autounlock != 0 then return true end
				if table.HasValue(ply.DRCAttachmentInventory, class) then return true end
				return false
			end
			
			local function ApplySkin(wpn, id, name)
				selected:SetText(" | ".. name .."")
				net.Start("DRC_WeaponCamoSwitch")
				net.WriteEntity(wpn)
				net.WriteEntity(LocalPlayer())
				net.WriteString(id)
				net.WriteString(name)
				net.SendToServer()
			end
			
			local rpnl = vgui.Create("DButton", selection)
			rpnl:SetSize(s:GetWide(), 48)
			rpnl:SetPos(0, 0)
			rpnl:Dock(TOP)
			rpnl:SetPaintBackground(true)
			rpnl:SetText("")
			rpnl.DoClick = function() ApplySkin(wpn, "", "None") end
			
			rpnl.Paint = function(self, w,h)
				DrawBox(0, 0, w, h, DRC.Inspection.ThemeColours.Background, theme.Images.HeaderBG)
				DrawText(self:GetWide()-20, 8, theme.Fonts.Header, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_RIGHT, "None")
				DrawText(self:GetWide()-20, 30, theme.Fonts.Default, DRC.Inspection.ThemeColours.Text_Inactive, TEXT_ALIGN_RIGHT, "No weapon camo.")
			end
			
			
			local rbutton = vgui.Create("DImageButton", rpnl)
			rbutton:SetSize(rpnl:GetTall()-2, rpnl:GetTall()-2)
			rbutton:SetPos(2,2)
			rbutton:SetImage("gui/cross.png")
			rbutton:SetColor(Color(255, 0, 0, 127))
			selection[rbutton] = {"None", "Remove applied weapon skin/camo.", ""}
			
			local tab = {}
			if !table.IsEmpty(wpn.WeaponSkinSpecialMats) then tab = wpn.WeaponSkinSpecialMats end
			for k,v in SortedPairs(tab) do
				if k != "BaseClass" then
				local name, desc, id = v.name or "", v.desc or "", k
				local selection = m[relevancy].Section
				local pnl = vgui.Create("DButton", selection)
				
				pnl:SetSize(s:GetWide(), 64)
				pnl:SetPos(0, 0)
				pnl:Dock(TOP)
				pnl:SetPaintBackground(true)
				pnl:SetText("")
				pnl.class = name
				pnl.Paint = function(self, w,h)
					DrawBox(0, 0, w, h, DRC.Inspection.ThemeColours.Background, theme.Images.HeaderBG)
					DrawText(self:GetWide()-20, 8, theme.Fonts.Header, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_RIGHT, name)
					if self:IsHovered() then 
						DrawText(self:GetWide()-20, 30, theme.Fonts.Default, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_RIGHT, desc)
					else
						if desc != nil && desc != "" then
						DrawText(self:GetWide()-20, 35, "DripIcons_Menu", DRC.Inspection.ThemeColours.Text_Inactive, TEXT_ALIGN_RIGHT, "b!")
						end
					end
				end
				
				pnl.DoClick = function() ApplySkin(wpn, k, name) end
					
				m[relevancy].Section[k] = vgui.Create("DImageButton", pnl)
				local icon = m[relevancy].Section[k]
				icon:SetImage(k)
				icon:SetSize(pnl:GetTall()-2, pnl:GetTall()-2)
				icon:SetPos(2,2)
				selection.Panels[k] = {icon, name, desc}
				selection[icon] = {name, desc, k}
				end
			end
			
			local function MakeSkinButton(parent, name, desc, id, icontex)
				local pnl = vgui.Create("DButton", parent)
				pnl:SetSize(s:GetWide(), 64)
				pnl:SetPos(0, 0)
				pnl:Dock(TOP)
				pnl:SetPaintBackground(true)
				pnl:SetText("")
				pnl.class = name
				pnl.Paint = function(self, w,h)
					DrawBox(0, 0, w, h, DRC.Inspection.ThemeColours.Background, theme.Images.HeaderBG)
					DrawText(self:GetWide()-20, 8, theme.Fonts.Header, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_RIGHT, name)
					if self:IsHovered() then 
						DrawText(self:GetWide()-20, 30, theme.Fonts.Default, DRC.Inspection.ThemeColours.Text, TEXT_ALIGN_RIGHT, desc)
					else
						if desc != nil && desc != "" then
						DrawText(self:GetWide()-20, 35, "DripIcons_Menu", DRC.Inspection.ThemeColours.Text_Inactive, TEXT_ALIGN_RIGHT, "b")
						end
					end
				end
				
				pnl.DoClick = function() ApplySkin(wpn, id, name) end
					
				m[relevancy].Section[id] = vgui.Create("DImageButton", pnl)
				local icon = m[relevancy].Section[id]
				icon:SetSize(pnl:GetTall()-2, pnl:GetTall()-2)
				icon:SetPos(2,2)
				if type(icontex) == "IMaterial" then icon:SetMaterial(icontex or id)
				else icon:SetImage(icontex or id) end
				selection.Panels[id] = {icon, name, desc}
				selection[icon] = {name, desc, id}
				
				return pnl
			end
			
			local cats = {}
			for k,v in SortedPairs(DRC.WeaponSkins) do
				local name, desc, id = v.name or "", v.desc or "", k
				local cat = v.type
				local skin = {name, desc, id}
				if !cats[cat] then cats[cat] = {} end
				cats[cat][id] = skin
				cats[cat].num = -1
			end
			
			catpanels = {}
			for k,v in pairs(cats) do
				for ke,va in pairs(cats[k]) do
					cats[k].num = cats[k].num + 1
				end
				local pnl = vgui.Create("DPanel", selection)
				
				pnl:SetPos(0, 0)
				pnl:Dock(TOP)
				pnl:SetSize(selection:GetWide(), 64*cats[k].num)
				pnl:SetVisible(false)
				pnl.Paint = function(self,w,h)
					DrawBox(0, 0, w, h, Color(0,0,0,0))
				end
				
				cats[k]["panel"] = pnl
				catpanels[k] = pnl
			end
			
			local icons = {
				["Draconic"] = {0, "icon64/draconic_base.png", "Draconic Camos", function() end },
				["ARC9"] = {1, "arc9/arc9_logo.png", "ARC9 Camos", function() end }
			}
			for k,v in pairs(catpanels) do
				local sec = s
				local btn = vgui.Create("DImageButton")
				btn:SetSize(32,32)
				btn:SetPos(sec:GetWide() + 8, 0)
				btn:SetImage(icons[k][2])
				btn:SetTooltip(icons[k][3])
				btn:SetVisible(false)
				m.CamoButtons[k] = btn
				btn.Think = function()
					if IsValid(sec) then
						local sx, sy = sec:GetBounds()
						btn:SetPos(sx + sec:GetWide() + 8, sy + 34*icons[k][1])
					end
					if !IsValid(sec) then btn:Remove() end
				end
				
				btn.DoClick = function()
					for ke,va in pairs(catpanels) do
						if ke == k then va:SetVisible(true) else va:SetVisible(false) end
						selection:InvalidateLayout()
					end
				end
			end
			
			for k,v in SortedPairs(DRC.WeaponSkins) do
				local name, desc, id = v.name or "", v.desc or "", k
				local selection = m[relevancy].Section
				
				local cat = v.type
				local pnl = catpanels[cat]
				
				MakeSkinButton(pnl, name, desc, id, v.icon)
			end
			
			if catpanels.Draconic then catpanels.Draconic:SetVisible(true) end
		end
		
		if wpn.WeaponSkinSubMaterials != nil && wpn.WeaponSkinDefaultMat != nil then MakeSkinSelection() end
		
		m.cb = vgui.Create("DButton", m)
		m.cb:SetText("Commit Changes")
		m.cb:SetPos(m:GetWide()/3.5, m:GetTall()-36)
		m.cb:SetSize(200, 32)
		m.cb:SetFont(DRC.Inspection.Theme.Fonts.Header)
		m.cb:SetTextColor(DRC.Inspection.ThemeColours_Attachments.Text)
		m.cb:Dock(TOP)
		function m.cb:Paint(w,h)
			draw.RoundedBox(0, 0, 0, w, h, DRC.Inspection.ThemeColours_Attachments.Background)
		end
		m.cb.DoClick = function() 
			DRC:ToggleAttachmentMenu(wpn, false)
			net.Start("DRC_WeaponAttachClose")
			net.WriteEntity(wpn)
			net.WriteEntity(LocalPlayer())
			net.SendToServer()
		end
		
	else
		if DRC.AttachMenu.mpanel then
			surface.PlaySound(DRC.Inspection.Theme.Sounds.Exit)
			DRC.AttachMenu.mpanel:Remove()
		end
		if DRC.AttachMenu.spanel then DRC.AttachMenu.spanel:Remove()
		end
	end
end






-- ###Debug
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

local GCT = CurTime()
local GNT = GCT + 1

local function GetLastSecondFramerate(ct)
	if CurTime() > GNT then
		GNT = CurTime() + 1
		ft = (1/FrameTime())
		return math.Round(ft, 0)
	else 
		return math.Round(ft, 0)
	end
end

local function drc_Debug()
	if DRC:DebugModeEnabled() == false then return end
	local debuglevel = GetConVar("cl_drc_debugmode"):GetString()
	
	local chmode = GetConVar("cl_drc_debug_crosshairmode"):GetFloat()
	local legacy = GetConVar("cl_drc_debug_legacyassistant"):GetFloat()

	local curswep = LocalPlayer():GetActiveWeapon()
	
		if debuglevel == "1" or debuglevel == "2" then
			local ply = LocalPlayer()
			local curswep = ply:GetActiveWeapon()
			local staticmat = Material("vgui/replay/replay_camera_crosshair")
			local dynmat	= Material("sprites/reticle")
			local width		= 1
			local height	= 1
		
			if curswep.Draconic == nil or curswep.Draconic == false then else
				if curswep.Base == "draconic_battery_base" or curswep.Base == "draconic_gun_base" then
					local spread = curswep.Primary.Spread
					local spreaddiv = curswep.Primary.SpreadDiv
				
					local heat = curswep.Weapon:GetHeat()
					local bs = curswep.BloomValue * (spread / spreaddiv) * 20
					local prevbs = curswep.PrevBS * (spread / spreaddiv) * 20
					local smoothbs = 1.5
					local dyn = Lerp(FrameTime() * 10, curswep.PrevBS, curswep.BloomValue)
					local hl = LerpVector(heat / 175, Vector(255, 255, 255), Vector(255, 0, 0))
					
					
					if curswep.Primary.CanMelee == true then
						if chmode > 1 then
							for i=1, (math.Round(1/ engine.TickInterval() - 1 , 0)) do
								local xm = Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), curswep.Primary.MeleeStartX, curswep.Primary.MeleeEndX) * 10
								local ym = Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), curswep.Primary.MeleeStartY, curswep.Primary.MeleeEndY) * 10
								
								if i == 1 then
									surface.SetDrawColor(255, 0, 0, 100)
									surface.DrawRect(ScrW() * 0.5 + xm + 4, ScrH() * 0.5 - ym - 4, 8, 8)
								end
								
								surface.SetDrawColor(255, 255, 255, 100)
								surface.DrawRect(ScrW() * 0.5 + xm, ScrH() * 0.5 - ym, 2, 2)
							end
						end
					end
				elseif curswep.Base == "draconic_melee_base" then
					if chmode > 0 then
						for i=1, (math.Round(1/ engine.TickInterval() - 1 , 0)) do
							local xm = Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), curswep.Primary.StartX, curswep.Primary.EndX) * 10
							local ym = Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), curswep.Primary.StartY, curswep.Primary.EndY) * 10
							
							if i == 1 then
								surface.SetDrawColor(255, 0, 0, 255)
								surface.DrawRect(ScrW() * 0.5 + xm + 4, ScrH() * 0.5 - ym - 4, 8, 8)
							end
							
							surface.SetDrawColor(255, 255, 255, 255)
							surface.DrawRect(ScrW() * 0.5 + xm, ScrH() * 0.5 - ym, 2, 2)
							
							surface.SetDrawColor(255, 255, 255, 255)
							surface.DrawRect(ScrW() * 0.5 + xm, ScrH() * 0.5 - ym, 2, 2)
						end
						
						for i=1, (math.Round(1/ engine.TickInterval() - 1 , 0)) do
							local xm = Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), curswep.Secondary.StartX, curswep.Secondary.EndX) * 10
							local ym = Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), curswep.Secondary.StartY, curswep.Secondary.EndY) * 10
							
							if i == 1 then
								surface.SetDrawColor(0, 255, 0, 255)
								surface.DrawRect(ScrW() * 0.5 + xm + 4, ScrH() * 0.5 - ym - 4, 8, 8)
							end
							
							surface.SetDrawColor(255, 255, 255, 255)
							surface.DrawRect(ScrW() * 0.5 + xm, ScrH() * 0.5 - ym, 2, 2)
							
							surface.SetDrawColor(255, 255, 255, 255)
							surface.DrawRect(ScrW() * 0.5 + xm, ScrH() * 0.5 - ym, 2, 2)
						end
						
						for i=1, (math.Round(1/ engine.TickInterval() - 1 , 0)) do
							if curswep.Primary.CanLunge == true then
								local xm = Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), curswep.Primary.LungeStartX, curswep.Primary.LungeEndX) * 10
								local ym = Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), curswep.Primary.LungeStartY, curswep.Primary.LungeEndY) * 10
								
								if i == 1 then
									surface.SetDrawColor(0, 0, 255, 255)
									surface.DrawRect(ScrW() * 0.5 + xm + 4, ScrH() * 0.5 - ym - 4, 8, 8)
								end
								
								surface.SetDrawColor(255, 255, 255, 255)
								surface.DrawRect(ScrW() * 0.5 + xm, ScrH() * 0.5 - ym, 2, 2)
								
								surface.SetDrawColor(255, 255, 255, 255)
								surface.DrawRect(ScrW() * 0.5 + xm, ScrH() * 0.5 - ym, 2, 2)
							end
						end
					end
				end
			end
		end
	
	if debuglevel == "0" then
	elseif debuglevel == "1" then
		if legacy == 1 then
			if curswep.Draconic != true then
			else
			local et = LocalPlayer():GetEyeTrace()
			local res = et.Entity
			
				local header = "DSB Debug Assistant | Current Weapon: ".. curswep.PrintName ..""
				local name = "".. curswep:GetClass() .." - ".. curswep.Base ..""

				if curswep.Base == "draconic_battery_base" then
					firemode = "".. curswep.Weapon:GetNWString("FireMode") .." | Bloom Score: ".. math.Round(curswep.BloomValue, 2) ..""
				elseif curswep.Base == "draconic_gun_base" then
					firemode = "".. curswep.Weapon:GetNWString("FireMode") .." | Bloom Score: ".. math.Round(curswep.BloomValue, 2) ..""
				else
					firemode = "Not a gun."
				end
				
				if curswep.Base == "draconic_battery_base" then
					ammoint = "".. curswep.Weapon:GetNWInt("LoadedAmmo") .."%"
				elseif curswep.Base == "draconic_gun_base" then
					ammoint = "".. curswep.Weapon:GetNWInt("LoadedAmmo") .." (int) / ".. curswep:Clip1() .." (clip) / ".. LocalPlayer():GetAmmoCount( curswep:GetPrimaryAmmoType() ) .." (reserve)"
				else
					ammoint = "Not a gun."
				end
				
				if curswep.Base == "draconic_battery_base" then
					heatint = "".. math.Round(curswep.Weapon:GetHeat(), 3) .."%"
				elseif curswep.Base == "draconic_gun_base" then
					heatint = "Not a Battery Base weapon."
				else
					heatint = "Not a gun."
				end
				
				if curswep.Base == "draconic_battery_base" then
					if curswep.LowerRPMWithHeat == true then
						if curswep.LoadAfterShot == false then
							rpm = "".. math.Round(math.Clamp((curswep.Primary.RPM / (curswep.Weapon:GetHeat() * 2.5 / 50)), (curswep.HeatRPMmin), (curswep.Primary.RPM))) ..""
						else
							rpm = "".. math.Round(math.Clamp((curswep.Primary.RPM / (curswep.Weapon:GetHeat() * 2.5 / 50)), (curswep.HeatRPMmin), (curswep.Primary.RPM))) .." - Manual load"
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
					if curswep.SightsDown then
						sights = "True"
					else
						sights = "False"
					end
				elseif curswep.Base == "draconic_gun_base" then
					if curswep.SightsDown == true then
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
				
				if curswep.Draconic == true then
					v2c = curswep.Weapon.OwnerActivity
					if v2c == "standidle" then activity = "Idle"
					elseif v2c == "running" then activity = "Moving"
					elseif v2c == "crouchidle" then activity = "Crouch Idle"
					elseif v2c == "crouchrunning" then activity = "Crouch Moving"
					elseif v2c == "swimidle" then activity = "Swim Idle"
					elseif v2c == "swimming" then activity = "Swimming"
					elseif v2c == "sprinting" then activity = "Sprinting"
					elseif v2c == "crouchsprinting" then activity = "Crouch Sprinting" end
				end
				
				if curswep.Base == "draconic_melee_base" then
					charge = "Not a gun."
				elseif curswep.Base == "draconic_gun_base" or curswep.Base == "draconic_battery_base" then
					if curswep.ChargeBase == false then
						charge = "".. curswep.PrintName .." does not charge."
					else
						charge = "".. curswep.Weapon:GetNWInt("Charge") .."%"
					end
				end
			
				if GetConVar("cl_drc_sell_soul"):GetString() == "1" then
					soul = "Yes."
				else
					soul = "No :'("
				end
			
				if GetLastSecondFramerate() == 69 then
					sixtynine = "Nice."
				else sixtynine = "" end
			
				draw.RoundedBox(4, 40, 515, 600, 260, Color(115, 115, 115, 100))
				
				drawBlur( 40, 515, 600, 260, 6, 4, 150 )

				draw.RoundedBox(4, 40, 515, 600, 30, Color(72, 72, 72, 255))
				draw.DrawText("Current SWEP ::", "HudSelectionText", 50, 550, Color(0, 0, 0, 255))
				draw.DrawText("Currnt Firemode ::", "HudSelectionText", 50, 575, Color(0, 0, 0, 255))
				draw.DrawText("Current Ammo ::", "HudSelectionText", 50, 590, Color(0, 0, 0, 255))
				draw.DrawText("Current Heat ::", "HudSelectionText", 50, 605, Color(0, 0, 0, 255))
				draw.DrawText("Current RPM :: ", "HudSelectionText", 50, 620, Color(0, 0, 0, 255))
				draw.DrawText("Current Charge :: ", "HudSelectionText", 50, 635, Color(0, 0, 0, 255))
				draw.DrawText("Currently in Passive ::", "HudSelectionText", 50, 660, Color(0, 0, 0, 255))
				draw.DrawText("Currently in Sights ::", "HudSelectionText", 50, 675, Color(0, 0, 0, 255))
				draw.DrawText("Lunge in range ::", "HudSelectionText", 50, 700, Color(0, 0, 0, 255))
				draw.DrawText("Melee in range ::", "HudSelectionText", 50, 715, Color(0, 0, 0, 255))
				draw.DrawText("Currently Detected Activity ::", "HudSelectionText", 50, 730, Color(0, 0, 0, 255))
				draw.DrawText("Soul Sacrificed to Vuthakral ::", "HudSelectionText", 50, 755, Color(0, 0, 0, 255))
				draw.DrawText("Frame Time ::", "HudSelectionText", 50, 775, Color(236, 236, 236, 255))
				draw.DrawText("FPS ::", "HudSelectionText", 50, 790, Color(236, 236, 236, 255))

				draw.DrawText(header, "HudSelectionText", 50, 520, Color(236, 236, 236, 236))
				
				draw.DrawText(name, "HudSelectionText", 180, 550, Color(236, 236, 236, 236))
				draw.DrawText(firemode, "HudSelectionText", 195, 575, Color(236, 236, 236, 236))
				draw.DrawText(ammoint, "HudSelectionText", 180, 590, Color(236, 236, 236, 236))
				draw.DrawText(heatint, "HudSelectionText", 170, 605, Color(236, 236, 236, 236))
				draw.DrawText(rpm, "HudSelectionText", 165, 620, Color(236, 236, 236, 236))
				draw.DrawText(charge, "HudSelectionText", 190, 635, Color(236, 236, 236, 236))
				draw.DrawText(passive, "HudSelectionText", 220, 660, Color(236, 236, 236, 236))
				draw.DrawText(sights, "HudSelectionText", 210, 675, Color(236, 236, 236, 236))
				draw.DrawText(lunge, "HudSelectionText", 180, 700, Color(236, 236, 236, 236))
				draw.DrawText(activity, "HudSelectionText", 270, 730, Color(236, 236, 236, 236))
				draw.DrawText(melee, "HudSelectionText", 180, 715, Color(236, 236, 236, 236))
				draw.DrawText(soul, "HudSelectionText", 270, 755, Color(236, 236, 236, 236))
				draw.DrawText(sixtynine, "HudSelectionText", 50, 805, Color(236, 236, 236, 10))
				draw.DrawText(math.Round(FrameTime(), 6), "HudSelectionText", 160, 775, Color(236, 236, 236, 236))
				draw.DrawText(GetLastSecondFramerate(), "HudSelectionText", 100, 790, Color(236, 236, 236, 236))
			end
		end
	end
end
hook.Add("HUDPaint", "drc_debug_hud", drc_Debug)

drc_vm_lerpang = Angle(0, 0, 0)
drc_vmaangle = Angle(0, 0, 0)
drc_vm_lerpdivval = 25
drc_vm_angdiff_median = 0
drc_vm_lerpdiv = 25
drc_vm_lerpang_final = Angle(0, 0, 0)
drc_vm_angmedian = 0
drc_vmapos = Vector(0, 0, 0)

local function DrawVMAttachments(att, ent)
	if DRC:DebugModeEnabled() == false then return end
	local debuglevel = GetConVar("cl_drc_debugmode"):GetString()
	
	if !att then return end
	if !IsValid(ent) then return end
	
	local wpn = LocalPlayer():GetActiveWeapon()
	if wpn.Draconic == nil then return end
	
	local att2 = ent:LookupAttachment(att)
	local attdata = ent:GetAttachment(att2)
	
	local pos = attdata.Pos
	local ang = attdata.Ang
	
	local qs = 3
	
	local trace = util.TraceLine({
		start = LocalPlayer():EyePos(),
		endpos = LocalPlayer():GetEyeTrace().HitPos,
		filter = LocalPlayer()
	})
	
	if att == "muzzle" then
		drc_debug_marker_attcol = Color(255, 0, 0, 100)
	--	render.SetMaterial(Material("sprites/reticle"))
	--	render.DrawQuadEasy(wpn:FormatViewModelAttachment(wpn.ViewModelFOV, attdata.Pos, false), (trace.Normal:Angle() + Angle(-90, 0, 0)):Up(), qs, qs, Color(255, 255, 255, 255), 0)
	elseif att == "1" or att == "eject" then
		drc_debug_marker_attcol = Color(0, 100, 255, 100)
		render.SetMaterial(Material("models/vuthakral/nodraw"))
	else
		drc_debug_marker_attcol = Color(255, 255, 0, 100)
		render.SetMaterial(Material("models/vuthakral/nodraw"))
	end
	
	render.SetColorMaterialIgnoreZ()
--	render.SetMaterial(Material("particle/Particle_Ring_Wave_Additive"))
--	render.SetMaterial(Material("color_ignorez"))
	
	local newpos = wpn:FormatViewModelAttachment(wpn.ViewModelFOV, attdata.Pos, false)
	
	if debuglevel != "1" then return end
	local vmattach = GetConVar("cl_drc_debug_vmattachments"):GetFloat()
	if vmattach != 1 then return end
	
	render.DrawSphere( newpos, 0.75, 4, 4, drc_debug_marker_attcol)
	
	render.DrawLine( newpos, newpos + ang:Forward() * 2.5, Color( 255, 0, 0, 100 ) )
	render.DrawSphere( newpos + ang:Forward() * 2.5, 0.125, 16, 16, Color(255, 0, 0, 100))
	
	render.DrawLine( newpos, newpos + ang:Right() * -2.5, Color( 0, 255, 0, 100 ) )
	render.DrawSphere( newpos + ang:Right() * -2.5, 0.125, 16, 16, Color(0, 255, 0, 100))
	
	render.DrawLine( newpos, newpos + ang:Up() * 2.5, Color( 0, 0, 255, 100 ) )
	render.DrawSphere( newpos + ang:Up() * 2.5, 0.125, 16, 16, Color(0, 0, 255, 100))
end

--[[
hook.Add( "PostDrawOpaqueRenderables", "DRC_VisualizeAimAssist", function()
	if !IsValid(LocalPlayer()) then return end
	local curswep = LocalPlayer():GetActiveWeapon()
	if !curswep.Draconic then return end
	local mat = Material( "models/shiny" )
	mat:SetFloat( "$alpha", 0.25 )
	
	local dir = LocalPlayer():GetAimVector()
	local angle = math.cos( curswep.SpreadCone ) -- 15 degrees
	local startPos = LocalPlayer():EyePos()

	local entities = DRC:EyeCone(LocalPlayer(), 1500, angle)

	-- draw the outer box
	local mins = Vector( -1500, -1500, -1500 )
	local maxs = Vector( 1500, 1500, 1500 )

	render.SetMaterial(mat)
	render.DrawWireframeBox( startPos, Angle( 0, 0, 0 ), mins, maxs, color_white, true )
	render.DrawBox( startPos, Angle( 0, 0, 0 ), -mins, -maxs, color_white )

	-- draw the lines
	for id, ent in ipairs( entities ) do
		render.DrawLine( ent:WorldSpaceCenter() + dir * ( ent:WorldSpaceCenter()-startPos ):Length(), ent:WorldSpaceCenter(), Color( 255, 0, 0 ) )
	end
end ) --]]

hook.Add("PreDrawViewModel", "DrcLerp_Debug", function( vm, ply, wpn )
	if !CLIENT then return end -- fucking singleplayer
	
	if wpn.Draconic == nil then return end
	for k, v in pairs(vm:GetAttachments()) do
		DrawVMAttachments(v.name, vm)
	end
	
	local attachment = vm:LookupAttachment("muzzle")
	local muz = vm:GetAttachment(attachment)
	if !muz then return end
	local pos = muz.Pos
	local ang = muz.Ang
	
	drc_vm_offangle = Angle(0, 0, 0) + ply:EyeAngles()
	
	local offs = pos - vm:GetPos()
	drc_vmapos = Lerp(RealFrameTime() * 25, drc_vmapos or offs, offs)
	
	local offsb = ang - vm:GetAngles()
	
--	ply:ChatPrint(tostring(offsb))
	
	drc_vmoffset_angle_x = math.ApproachAngle(offsb.x, drc_vm_offangle.x, 0.1 * drc_vm_angdiff_median)
	drc_vmoffset_angle_y = math.ApproachAngle(offsb.y, drc_vm_offangle.y, 0.1 * drc_vm_angdiff_median)
	drc_vmoffset_angle_z = math.ApproachAngle(offsb.z, drc_vm_offangle.z, 0.1 * drc_vm_angdiff_median)
	
	drc_vm_angdiff_x = math.AngleDifference(drc_vmoffset_angle_x, drc_vm_offangle.x)
	drc_vm_angdiff_y = math.AngleDifference(drc_vmoffset_angle_y, drc_vm_offangle.y)
	drc_vm_angdiff_z = math.AngleDifference(drc_vmoffset_angle_z, drc_vm_offangle.z)
	
	drc_vm_angdiff = Angle(drc_vm_angdiff_x, drc_vm_angdiff_y, drc_vm_angdiff_z)
	
	drc_vm_angdiff_median = math.Clamp(math.abs((drc_vm_angdiff_x + drc_vm_angdiff_y + drc_vm_angdiff_z) / 3), 16, 60)
	
	drc_vm_angmedian = Lerp(RealFrameTime() * 5, drc_vm_angdiff_median / (drc_vm_lerpdivval / 6) or 0, drc_vm_angdiff_median / (drc_vm_lerpdivval / 6))
	
--	drc_vmaangle = (drc_vm_offangle + drc_vm_angdiff)
--	drc_vmaangle = drc_vmaangle * drc_vm_angmul
	offsb.x = offsb.x * drc_vm_angmul.x
	offsb.y = offsb.y * drc_vm_angmul.y
	offsb.z = offsb.z * drc_vm_angmul.z
	drc_vmaangle = offsb
end)

hook.Add("Tick", "DRC_PreventBrokenHUD", function()
	if !IsValid(LocalPlayer()) then return end
	if !LocalPlayer():Alive() then if DRC.AttachMenu then if DRC.AttachMenu.mpanel then DRC.AttachMenu.mpanel:Remove() end end end
	if IsValid(LocalPlayer():GetActiveWeapon()) then
		local wpn = LocalPlayer():GetActiveWeapon()
		if wpn.Draconic then
			if DRC.AttachMenu then
				if DRC.AttachMenu.mpanel && wpn.Customizing != true then DRC.AttachMenu.mpanel:Remove() end
			end
		end
	end
end)