-- ###Lighting
-- ###MapInfos
-- ###Accessibility
-- ###Misc





-- ###Lighting
DRC.CalcView.MuzzleLamp_Time = 0

hook.Add("Think", "DRC_Lighting", function()
	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	
	for k,v in pairs(DRC.ActiveWeapons) do
		ply = v:GetParent()
		if IsValid(v) then
			if v.Glow == true then
				if !IsValid(ply) then
					DRC:DLight(v, v:GetPos(), v.GlowColor, v.GlowSize, 0.1, false, 1, v.GlowStyle)
				else
					if IsValid(v) && v.GetParent then
						if IsValid(v:GetParent()) && v:GetParent():GetActiveWeapon() == v then
							if v.Glow == true && CLIENT then
								local RightHand = ply:LookupAttachment("anim_attachment_RH")
								local pos = Vector()
								if RightHand != 0 then
									pos = ply:GetAttachment(RightHand).Pos
								else
									pos = ply:LocalToWorld(ply:OBBCenter() + Vector(15, -15, 0))
								end
								
								DRC:DLight(v, pos, v.GlowColor, v.GlowSize, 0.1, false, 1, v.GlowStyle)
							end
						end
					end
				end
			end
		end
	end
	
	ply = LocalPlayer()
	local vm = ply:GetViewModel()
	if !IsValid(vm) then return end
	local wpn = ply:GetActiveWeapon()
	if !IsValid(wpn) then return end
	if !wpn.Draconic then 
		if DRC.CalcView.MuzzleLamp then
			DRC.CalcView.MuzzleLamp.Enabled = false
		end
	return end
	if wpn:HasViewModel() != true then return end
	if wpn.IsMelee == true then return end
	
	if !IsValid(DRC.CalcView.MuzzleLamp) then
		DRC.CalcView.MuzzleLamp = ents.CreateClientside("draconic_ptex_base")
		local lighttable = {
			["Texture"] 	= "",
			["NearZ"] 		= 1,
			["FarZ"] 		= 300,
			["FOV"]			= 140,
			["DrawShadows"] = true
		}
		DRC.CalcView.MuzzleLamp = DRC:ProjectedTexture(vm, "muzzle", lighttable)
	else
		if DRC:ThirdPersonEnabled(ply) then
			if DRC.CalcView.MuzzleLamp:GetParent() != wpn then DRC.CalcView.MuzzleLamp:SetParent(wpn) end
		else
			if DRC.CalcView.MuzzleLamp:GetParent() != vm then DRC.CalcView.MuzzleLamp:SetParent(vm) end
		end
	
		local ent = DRC.CalcView.MuzzleLamp
		local parent = ent:GetParent()
		if !IsValid(parent) then
			ent:SetParent(wpn) parent = ent:GetParent()
		end
		local att = parent:LookupAttachment("muzzle")
		local attinfo = parent:GetAttachment(att)
		if attinfo == nil then return end
		ent:SetPos(attinfo.Pos)
		ent:SetAngles(attinfo.Ang)
	--	ent.Light:SetColor( Color(255, 150, 25) )
		if DRC.CalcView.MuzzleLamp_Time then if DRC.CalcView.MuzzleLamp_Time < CurTime() then ent.Enabled = false end end
	end
end)





--- ###MapInfos
drc_badlightmaps = { 
	["gm_blackmesa_sigma"] = 0.1,
	["gm_bigcity_improved"] = 0.25,
	["gm_bigcity_improved_lite"] = 0.25,
	["gm_emp_chain"] = 0.15,
}
-- The only maps that get added to this list are old maps which will not see an update/fix from their authors.
-- This is not meant as a mark of shame, it is used in the Draconic menu to inform developers that the map they
-- are on has incorrectly compiled lighting, and as a result their content might look a bit scuffed. Values at the
-- end are "post fixes" which scales the Draconic Base's Reflection Tint proxies.

drc_singlecubemaps = {
	["mu_volcano"] = 0.25,
	["gm_cultist_outpost"] = 0.25,
	["gm_reactionsew"] = 0.1,
}
-- Maps with no either cubemaps baked into them falling back on the engine default, or only one single cubemap, preventing proper lighting checks from working.

drc_fullbrightcubemaps = {
}
-- Alright, THIS is a mark of shame. Whoever told you to turn on fullbright when compiling cubemaps is an idiot.

drc_verifiedlightmaps = {
	["gm_construct"] = true,
	["gm_flatgrass"] = true,
	["gm_bigcity"] = true,
	["gm_emp_streetsoffire"] = true,
	["gm_vault"] = true,
}
-- Impressive. Very nice.

drc_authorpassedlightmaps = {}

DRC.BadLightmapList = {}
table.Merge(DRC.BadLightmapList, drc_badlightmaps)
table.Merge(DRC.BadLightmapList, drc_singlecubemaps)

DRC.MapInfo.LMCorrection = DRC.BadLightmapList[DRC.MapInfo.Name]
if DRC.MapInfo.LMCorrection == nil then DRC.MapInfo.LMCorrection = 1 end
DRC.MapInfo.MapAmbient = render.GetAmbientLightColor()
DRC.MapInfo.MapAmbientAvg = (DRC.MapInfo.MapAmbient.x + DRC.MapInfo.MapAmbient.y + DRC.MapInfo.MapAmbient.z) / 3

hook.Add("InitPostEntity", "DRC_LightmapCheck", function()
	DRC.MapInfo.LMCorrection = DRC.BadLightmapList[DRC.MapInfo.Name]
	if DRC.MapInfo.LMCorrection == nil then DRC.MapInfo.LMCorrection = 1 end
	DRC.MapInfo.MapAmbient = render.GetAmbientLightColor()
	DRC.MapInfo.MapAmbientAvg = (DRC.MapInfo.MapAmbient.x + DRC.MapInfo.MapAmbient.y + DRC.MapInfo.MapAmbient.z) / 3
end)





-- ###Accessibility
DRC.Accessibility = {}
DRC.Accessibility.ColorBlindness = {
	["None"] = Vector(1, 1, 1),
	["Protanopia"] = Vector(0.56667, 0.4467, 0.75883),
	["Protanomaly"] = Vector(0.81667, 0.66667, 0.875),
	["Deuteranopia"] = Vector(0.625, 0.3, 0.7),
	["Deuteranomaly"] = Vector(0.8, 0.25833, 0.85833),
	["Tritanopia"] = Vector(0.95, 0.43333, 0.525),
	["Tritanomaly"] = Vector(0.96667, 0.73333, 0.81667),
	["Achromatopsia"] = Vector(0.299, 0.587, 0.114),
	["Achromatomaly"] = Vector(0.618, 0.775, 0.516)
} -- https://web.archive.org/web/20081014161121/http://www.colorjack.com/labs/colormatrix/
DRC.Accessibility.ColorBlindness_Mul = 0

hook.Add("DrawOverlay", "DRC_ColourBlindness", function()
	local con = GetConVar("cl_drc_accessibility_colourblind"):GetString()
	if con == "None" then return end
	local con2 = GetConVar("cl_drc_accessibility_colourblind_strength"):GetFloat()
	if !DRC.Accessibility.ColorBlindness[con] then
		RunConsoleCommand("cl_drc_accessibility_colourblind", "None")
		con = GetConVar("cl_drc_accessibility_colourblind"):GetString()
	end
	
	if con == "None" then
		DRC.Accessibility.ColorBlindness_Mul = 0
	else
		DRC.Accessibility.ColorBlindness_Mul = con2/100
	end
	
	local vec = DRC.Accessibility.ColorBlindness[con]
	vec = vec * DRC.Accessibility.ColorBlindness_Mul
	local r, g, b = 1 - vec.r, 1 - vec.g, 1 - vec.b
	local ar = -vec.r * (DRC.Accessibility.ColorBlindness_Mul * 0.1)
	local ag = -vec.g * (DRC.Accessibility.ColorBlindness_Mul * 0.1)
	local ab = -vec.b * (DRC.Accessibility.ColorBlindness_Mul * 0.1)
	local v1 = Vector(r,g,b) * (con2/100) * DRC.Accessibility.ColorBlindness_Mul
	local v2 = Vector(ar,ag,ab) * (con2/100)
	
	local cc = {
		["$pp_colour_addr"] = v2.x,
		["$pp_colour_addg"] = v2.y,
		["$pp_colour_addb"] = v2.z,
		["$pp_colour_brightness"] = 0,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 1,
		["$pp_colour_mulr"] = v1.x,
		["$pp_colour_mulg"] = v1.y,
		["$pp_colour_mulb"] = v1.z
	}
	
	DrawColorModify(cc)
end)





-- ###Misc
hook.Add("RenderScreenspaceEffects", "DRC_Camera_Overlays", function()
	local ply = LocalPlayer()
	if !IsValid(ply) && !ply:Alive() then return end
	local wpn = ply:GetActiveWeapon()
	if IsValid(wpn) && wpn:GetClass() == "drc_camera" then
		DrawMaterialOverlay(DRC.CameraOverlay, DRC.CameraPower)
	end
end)