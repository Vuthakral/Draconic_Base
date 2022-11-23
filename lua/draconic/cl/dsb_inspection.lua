if SERVER then return end

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
		["Outline"] = Color(0, 0, 0, 127),
		["Background"] = Color(0, 0, 0, 127),
	},
	["Images"] = {
		["TitleBG"] = Material("vgui/draconic/titlebg.png"),
		["HeaderBG"] = Material("vgui/draconic/header.png"),
		["TabThin"] = Material("vgui/draconic/label.png"),
		["TabWide"] = Material("vgui/draconic/label_wide.png"),
		["Border_Top"] = Material(""),
		["Border_Side"] = Material(""),
		["Border_Bottom"] = Material(""),
		["Border_Corners"] = Material(""),
	},
}
DRC.Inspection.Theme = DRC.Inspection.DefaultTheme

local function drc_Inspect()
	if GetConVar("cl_drawhud"):GetFloat() == 0 then return end
	if GetConVar("sv_drc_inspect_hideHUD"):GetFloat() == 1 then return end
	
	local ply = LocalPlayer() 
	local wpn = ply:GetActiveWeapon()
	if wpn.Draconic == nil then return end
	if wpn.MulIns == nil then return end
	local bool = wpn:GetNWBool("Inspecting", false)
	local w = ScrW()
	local h = ScrH()
	local ratio = w/h
	local w2 = ScrW()/2
	local h2 = ScrH()/2
	local theme = DRC.Inspection.Theme
	local themecolours = DRC.Inspection.Theme.Colours
	
	if bool == true then
		alpha = Lerp(wpn.MulIns, 0, 1)
		YOffset = Lerp(wpn.MulIns, h/2, 0)
		XOffset = Lerp(wpn.MulIns, w/2, 0)
		
		offsetlerp_x = Lerp(FrameTime() * 10, offsetlerp_x or XOffset, XOffset)
		offsetlerp_y = Lerp(FrameTime() * 10, offsetlerp_y or YOffset, YOffset)
	else
		alpha = Lerp(wpn.MulIns, 1, 0)
		YOffset = Lerp(wpn.MulIns, 0, h )
		XOffset = Lerp(wpn.MulIns, 0, w )
		
		offsetlerp_x = Lerp(FrameTime() * 2.5, offsetlerp_x or w/w2/2, w/2)
		offsetlerp_y = Lerp(FrameTime() * 2.5, offsetlerp_y or h/h2/2, h/2)
	end
	
	local colours = {}
	for k,v in pairs(themecolours) do
		colours[k] = Color(v.r, v.g, v.b, v.a * alpha)
	end
	
	inspecttextpos_x = offsetlerp_x + w - w2/2 - (w2/2)
	inspecttextpos_y = offsetlerp_y + h - h2/2 - (h2/2)

	local function DrawBox(posx, posy, width, height, col, bgimg)
		if bgimg then surface.SetDrawColor(Color(255, 255, 255, 255)) surface.SetMaterial(bgimg) else surface.SetDrawColor(col) draw.NoTexture() end
		surface.DrawTexturedRect( posx, posy, width, height )
	end
	
	local function DrawText(posx, posy, font, col, align, str)
		draw.DrawText(str, font, posx+1, posy-1, colours.Outline, align)
		draw.DrawText(str, font, posx-1, posy+1, colours.Outline, align)
		draw.DrawText(str, font, posx+1, posy+1, colours.Outline, align)
		draw.DrawText(str, font, posx-1, posy-1, colours.Outline, align)
		draw.DrawText(str, font, posx, posy+1, colours.Outline, align)
		draw.DrawText(str, font, posx, posy-1, colours.Outline, align)
		draw.DrawText(str, font, posx+1, posy, colours.Outline, align)
		draw.DrawText(str, font, posx-1, posy, colours.Outline, align)
		draw.DrawText(str, font, posx, posy, col, align)
		--draw.SimpleTextOutlined(str, font, posx, posy, col, align, TEXT_ALIGN_TOP, 1, themecolours.Outline)
		-- POV: draw.DrawText is the only thing with newline support, but doesn't support outlines
	end
	
	local function DrawRule(posx, posy, width, height, col)
		surface.SetDrawColor(col)
		surface.DrawRect(posx, posy, width, height)
	end
	
	surface.SetDrawColor( colours.Background )
--	DrawRule(w-500+offsetlerp_x, h*0.02 - 3, 500, 1, themecolours.Div)
	DrawBox(w-500+offsetlerp_x, h*0.02, 500, 76, themecolours.Background, theme.Images.TitleBG)
	DrawText(w-250+offsetlerp_x, h*0.04, theme.Fonts.Title, colours.Title, TEXT_ALIGN_CENTER, "".. wpn.PrintName .."")
	if wpn.InfoName then DrawText(w-250+offsetlerp_x, h*0.04 + 36, theme.Fonts.Subtitle, colours.Text, TEXT_ALIGN_CENTER, "''".. wpn.InfoName .."''") end
	
	DrawBox(w-200+offsetlerp_x, h*0.02 + 86, 200, 16, themecolours.Background, theme.Images.TabWide)
	DrawText(w-16+offsetlerp_x, h*0.02 + 86, theme.Fonts.Subtitle, colours.Text, TEXT_ALIGN_RIGHT, "".. wpn.Category .."")
	DrawBox(w-150+offsetlerp_x, h*0.02 + 104, 150, 16, themecolours.Background, theme.Images.TabWide)
	DrawText(w-16+offsetlerp_x, h*0.02 + 104, theme.Fonts.Subtitle, colours.Text, TEXT_ALIGN_RIGHT, "".. wpn.Author .."")
	
	local infoy = 136
	
	if wpn.Manufacturer or wpn.InfoDescription then
		DrawRule(w-500+offsetlerp_x, h*0.02 + infoy - 3, 500, 1, themecolours.Div)
		DrawBox(w-500+offsetlerp_x, h*0.02 + infoy, 300, 34, themecolours.Background, theme.Images.HeaderBG)
		DrawText(w-350+offsetlerp_x, h*0.02 + infoy+6, theme.Fonts.Header, colours.Title, TEXT_ALIGN_CENTER, "Weapon Information")
		
		if wpn.Manufacturer then
			infoy = 175
			DrawBox(w-500+offsetlerp_x, h*0.02 + infoy, 100, 18, themecolours.Background, theme.Images.TabWide)
			DrawText(w-405+offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Subtitle, colours.Text, TEXT_ALIGN_RIGHT, "Manufacturer :")
			DrawBox(w-395+offsetlerp_x, h*0.02 + infoy, 380, 18, themecolours.Background)
			DrawText(w-390+offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, colours.Text, TEXT_ALIGN_LEFT, "".. wpn.Manufacturer .."")
		end
		
		if wpn.InfoDescription then
			if infoy != 136 then infoy = infoy + 20 else infoy = 175 end
			DrawBox(w-500+offsetlerp_x, h*0.02 + infoy, 100, 18, themecolours.Background, theme.Images.TabWide)
			DrawText(w-405+offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Subtitle, colours.Text, TEXT_ALIGN_RIGHT, "Information :")
			DrawBox(w-395+offsetlerp_x, h*0.02 + infoy, 380, 60, themecolours.Background)
			DrawText(w-390+offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, colours.Text, TEXT_ALIGN_LEFT, "".. wpn.InfoDescription .."")
		end
	end
	
	if infoy != 136 then infoy = infoy + 65 end
	DrawRule(w-500+offsetlerp_x, h*0.02 + infoy - 3, 500, 1, themecolours.Div)
	DrawBox(w-500+offsetlerp_x, h*0.02 + infoy, 300, 34, themecolours.Background, theme.Images.HeaderBG)
	DrawText(w-350+offsetlerp_x, h*0.02 + infoy+6, theme.Fonts.Header, colours.Title, TEXT_ALIGN_CENTER, "Handling Information")
	
	if wpn.Base != "draconic_melee_base" then
		infoy = infoy + 39
		DrawBox(w-500+offsetlerp_x, h*0.02 + infoy, 100, 18, themecolours.Background, theme.Images.TabWide)
		DrawText(w-405+offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Subtitle, colours.Text, TEXT_ALIGN_RIGHT, "Damage :")
		DrawBox(w-395+offsetlerp_x, h*0.02 + infoy, 380, 18, themecolours.Background)
			
		if wpn.PrimaryStats.Projectile != nil then
			local projectile = {}
			if istable(wpn.PrimaryStats.Projectile) then projectile = scripted_ents.GetStored(wpn.PrimaryStats.Projectile[1]) else
		 projectile = scripted_ents.GetStored(wpn.PrimaryStats.Projectile) end
			if projectile.t.ProjectileType == "supercombine" then
				DrawText(w-390+offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, colours.Text, TEXT_ALIGN_LEFT, "Base: ".. projectile.t.Damage .." | Supercombine: ".. projectile.t.SuperDamage .."")
			else
				local damagestring = "".. projectile.t.Damage ..""
				if wpn:GetAttachmentValue("Ammunition", "NumShots") != 1 then damagestring = "".. damagestring .."x".. wpn:GetAttachmentValue("Ammunition", "NumShots") .."" end
				DrawText(w-390+offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, colours.Text, TEXT_ALIGN_LEFT, "".. damagestring .." per round, ".. math.Round((wpn.PrimaryStats.RPM/60 * projectile.t.Damage) * wpn:GetAttachmentValue("Ammunition", "NumShots"), 2) .." DPS")
			end
		else
			local damagestring = "".. wpn.PrimaryStats.Damage ..""
				if wpn:GetAttachmentValue("Ammunition", "NumShots") != 1 then damagestring = "".. damagestring .."x".. wpn:GetAttachmentValue("Ammunition", "NumShots") .."" end
			DrawText(w-390+offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, colours.Text, TEXT_ALIGN_LEFT, "".. damagestring .." per round, ".. math.Round((wpn.PrimaryStats.Damage * wpn:GetAttachmentValue("Ammunition", "NumShots")) * wpn.PrimaryStats.RPM/60, 2) .." DPS")
		end
		
		infoy = infoy + 20
		DrawBox(w-500+offsetlerp_x, h*0.02 + infoy, 100, 18, themecolours.Background, theme.Images.TabWide)
		DrawBox(w-395+offsetlerp_x, h*0.02 + infoy, 380, 18, themecolours.Background)
		DrawText(w-405+offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Subtitle, colours.Text, TEXT_ALIGN_RIGHT, "Ammo :")
		if wpn.Base == "draconic_gun_base" then
			DrawText(w-390+offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, colours.Text, TEXT_ALIGN_LEFT, "".. wpn:Clip1() .."/".. (wpn:GetMaxClip1() * wpn:GetAttachmentValue("Ammunition", "ClipSizeMul")) .." | ".. wpn.ActiveAttachments.Ammunition.t.InfoName .." (".. game.GetAmmoName(wpn:GetPrimaryAmmoType()) ..")")
		else
			DrawText(w-390+offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, colours.Text, TEXT_ALIGN_LEFT, "".. math.Round(wpn:GetNWInt("LoadedAmmo"), 2) .."% (".. math.Round(100/wpn.BatteryConsumPerShot * (wpn:GetNWInt("LoadedAmmo")/100)) .." Shots remaining) | ".. wpn.ActiveAttachments.Ammunition.t.InfoName .."")
		end
		
		infoy = infoy + 20
		DrawBox(w-500+offsetlerp_x, h*0.02 + infoy, 100, 18, themecolours.Background, theme.Images.TabWide)
		DrawBox(w-395+offsetlerp_x, h*0.02 + infoy, 380, 18, themecolours.Background)
		DrawText(w-405+offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Subtitle, colours.Text, TEXT_ALIGN_RIGHT, "Firerate :")
		if wpn.Base == "draconic_gun_base" then
			DrawText(w-390+offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, colours.Text, TEXT_ALIGN_LEFT, "".. wpn.PrimaryStats.RPM .." Rounds per minute | ".. math.Round(wpn.PrimaryStats.RPM/60, 2) .." Rounds per second")
		else
			if wpn.LowerRPMWithHeat == true then
				DrawText(w-390+offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, colours.Text, TEXT_ALIGN_LEFT, "".. wpn.PrimaryStats.RPM .." - ".. wpn.BatteryStats.HeatRPMmin .." RPM | ".. math.Round(wpn.PrimaryStats.RPM/60, 2) .." - ".. math.Round(wpn.BatteryStats.HeatRPMmin/60, 2) .." RPS")
			else
				DrawText(w-390+offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, colours.Text, TEXT_ALIGN_LEFT, "".. wpn.PrimaryStats.RPM .." RPM | ".. math.Round(wpn.PrimaryStats.RPM/60, 2) .." RPS")
			end
		end
		
		local spreadmin = math.Round((wpn.PrimaryStats.Spread / wpn.PrimaryStats.SpreadDiv), 2)
		local spreadmax = math.Round((wpn.PrimaryStats.Spread / wpn.PrimaryStats.SpreadDiv) * 130, 2)
		infoy = infoy + 20
		DrawBox(w-500+offsetlerp_x, h*0.02 + infoy, 100, 18, themecolours.Background, theme.Images.TabWide)
		DrawBox(w-395+offsetlerp_x, h*0.02 + infoy, 380, 18, themecolours.Background)
		DrawText(w-405+offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Subtitle, colours.Text, TEXT_ALIGN_RIGHT, "Spread :")
		DrawText(w-390+offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, colours.Text, TEXT_ALIGN_LEFT, "".. spreadmin .."° - ".. spreadmax .."° | ".. math.Clamp((wpn.Primary.Kick)*100, 0, 100) .." - " .. math.Clamp((wpn.Primary.Kick +0.1)*100, 0, 100) .."% per round | ".. math.Clamp(math.Round(wpn.Primary.Kick * 2+0.1, 2)*100, 0, 100) .." - ".. math.Clamp(math.Round(wpn.Primary.Kick * 1.5, 2)*100, 0, 100) .."% Recovery per ".. math.Round((60 / wpn.Primary.RPM) * 3, 2) .." seconds")
	else
		infoy = infoy + 39
		DrawBox(w-500+offsetlerp_x, h*0.02 + infoy, 100, 18, themecolours.Background)
		DrawText(w-405+offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Subtitle, colours.Text, TEXT_ALIGN_RIGHT, "Damage :")
		DrawBox(w-395+offsetlerp_x, h*0.02 + infoy, 380, 18, themecolours.Background)
		
		local secondary = wpn.Secondary.Damage
		if secondary != 0 then secondary = " | ".. secondary .." (Secondary)" else secondary = "" end
		local lunge = wpn.Primary.LungeDamage
		if lunge != 0 then lunge = " | ".. lunge .." (Lunge)" else lunge = "" end
		
		DrawText(w-390+offsetlerp_x, h*0.02 + infoy+1, theme.Fonts.Default, colours.Text, TEXT_ALIGN_LEFT, "".. wpn.Primary.Damage .." (Primary)".. secondary .."".. lunge .."")
	end
	
	--[[
	infoy = infoy + 20
	DrawBox(w-395+offsetlerp_x, h*0.02 + infoy, 380, 380)
	surface.DrawCircle(w-197.5+offsetlerp_x, infoy+190, spreadmax * 5, 200, 200, 200, 255)
	surface.DrawCircle(w-197.5+offsetlerp_x, infoy+190, spreadmax * 6.5, 255, 0, 0, 50)
	surface.DrawCircle(w-197.5+offsetlerp_x, infoy+190, math.Clamp(spreadmin, 0.4, 999) * 5, 0, 200, 0, 255)
	--]]
end

hook.Add("HUDPaint", "drc_inspection_menu", drc_Inspect)

hook.Add("PreDrawViewModel", "drc_inspection_dof", function(vm, ply, wpn)
	if wpn.Draconic == nil then return end
	if wpn.Initialized != true then return end
	local alpha = 0
	local bool = wpn:GetNWBool("Inspecting")
	if bool == true then
		alpha = Lerp(wpn.MulIns, 0, 5)
		DrawToyTown(1 * alpha, ScrH()/1.25)
	end
end)