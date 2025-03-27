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
	if !ply:Alive() then return end
	local vm = ply:GetViewModel()
	if !IsValid(vm) then return end
	local wpn = ply:GetActiveWeapon()
	if !IsValid(wpn) then return end
	if !wpn.Draconic then 
		if IsValid(DRC.CalcView.MuzzleLamp) then
			DRC.CalcView.MuzzleLamp.Enabled = false
			DRC.CalcView.MuzzleLamp:Remove()
		end
	return end
	if wpn:HasViewModel() != true then return end
	if wpn.IsMelee == true then return end
	
	if !IsValid(DRC.CalcView.MuzzleLamp) then
	--	DRC.CalcView.MuzzleLamp = ents.CreateClientside("draconic_ptex_base")
		local lighttable = {
			["Texture"] 	= "",
			["NearZ"] 		= 1,
			["FarZ"] 		= 300,
			["FOV"]			= 140,
			["DrawShadows"] = true
		}
		DRC.CalcView.MuzzleLamp = DRC:ProjectedTexture(vm, "muzzle", lighttable)
		DRC.CalcView.MuzzleLamp_Angle = Angle()
	else
		local thirdperson = DRC:ThirdPersonEnabled(ply)
		if thirdperson then
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
		if wpn.Draconic && wpn.IntegratedLight_Enabled == true && wpn:GetNWBool("IntegratedLightState") == true then
			local colmain = wpn.IntegratedLight_Colour
			local col = Color(colmain.r, colmain.g, colmain.b, 25 * colmain.a)
			local bright = (col.a/30) * (1 - math.Clamp(DRC.MapInfo.MapAmbientAvg, 0.15, 1))
			ent.Texture = wpn.IntegratedLight_Texture
			ent.Light:SetColor(Color(col.r, col.g, col.b))
			ent.Light:SetBrightness(bright)
			local p1, p2 = attinfo.Pos, DRC:TraceDir(attinfo.Pos, attinfo.Ang, wpn.IntegratedLight_MaxDist)
			if wpn.IntegratedLight_UseHitPos == true then
				local parent = DRC.CalcView.MuzzleLamp:GetParent() == ply
				local vm = ply:GetViewModel(0)
				local idle = wpn:GetSequenceActivity(wpn:GetSequence(ACT_VM_IDLE)) == ACT_VM_IDLE or wpn:GetSequenceActivity(wpn:GetSequence(ACT_WALK)) == ACT_WALK
				local ea = ply:EyeAngles()
				local ang1 = ea + (wpn.dang*2)
				local ang2 = attinfo.Ang
				local atu
				
				if !parent && !thirdperson then
					DRC.CalcView.MuzzleLamp:SetParent(ply)
				end
				if idle or thirdperson then atu = ang1 else atu = ang2 end
				
				DRC.CalcView.MuzzleLamp_Angle = LerpAngle(RealFrameTime() * 25, DRC.CalcView.MuzzleLamp_Angle or atu, atu)
				
				ent:SetPos(ply:EyePos() + ea:Forward() * 15)
				ent:SetAngles(DRC.CalcView.MuzzleLamp_Angle)
			end
			local frac = Lerp(1-p2.Fraction * wpn.IntegratedLight_DistScale, 0, wpn.IntegratedLight_FOV)
			ent.FOV = frac
			ent.FarZ = wpn.IntegratedLight_MaxDist
			ent.Enabled = true
			
			if wpn.IntegratedLight_DoVolume == true then
				local volcol = Color(wpn.IntegratedLight_Colour.r, wpn.IntegratedLight_Colour.g, wpn.IntegratedLight_Colour.b, wpn.IntegratedLight_VolPower)
				if !IsValid(wpn.FlashlightVolume) then wpn.FlashlightVolume = DRC:LightVolume(wpn, "muzzle", volcol, wpn.IntegratedLight_VolLength, frac*0.005, 50, nil, wpn.IntegratedLight_VolMaterial) end
			end
		end
		if wpn:GetNWBool("IntegratedLightState") == true then
			if DRC.CalcView.MuzzleLamp_Time then if DRC.CalcView.MuzzleLamp_Time < CurTime() && wpn:GetNWBool("IntegratedLightState") == false then ent.Enabled = false end end
		else
			if DRC.CalcView.MuzzleLamp_Time then if DRC.CalcView.MuzzleLamp_Time < CurTime() then ent.Enabled = false end end
			if wpn.IntegratedLight_DoVolume == true then
				if IsValid(wpn.FlashlightVolume) then wpn.FlashlightVolume:Remove() end
			end
		end
	end
end)

function DRC:LightVolume(ent, att, colour, length, width, quality, addang, mat, posoff, useeyeang)
	if !IsValid(ent) then return end
	if IsValid(ent.DRCVolumeLight) then return end
	if !quality then quality = 25 end
	if !mat then mat = "sprites/glow04_noz" end
	if useeyeang == nil then useeyeang = true end
	local attnum, attinfo
	if att then
		attnum = ent:LookupAttachment(att)
		attinfo = ent:GetAttachment(attnum)
	end
	local light = nil
	light = ents.CreateClientside("draconic_spotlight_base")
	light:Spawn()
	light:SetParent(ent, attnum)
	light.AddAng = addang or Angle()
	light.OffsetPos = posoff or Vector()
	light.LightMaterial = mat
	
	local pos, ang = ent:GetPos(), ent:GetAngles()
	if att && attinfo then pos, ang = attinfo.Pos, attinfo.Ang end
	
	light.Info = {
		["entity"] = ent,
		["attachment"] = att,
		["colour"] = colour,
		["length"] = length,
		["width"] = width,
		["quality"] = quality,
		["angles"] = ang,
		["position"] = pos,
		["eyeang"] = useeyeang,
	}
	ent.DRCVolumeLight = light
	
	return light
end

DRC.MapInfo.MapAmbient = render.GetAmbientLightColor()
DRC.MapInfo.MapAmbientAvg = (DRC.MapInfo.MapAmbient.x + DRC.MapInfo.MapAmbient.y + DRC.MapInfo.MapAmbient.z) / 3

hook.Add("InitPostEntity", "DRC_LightmapCheck", function()
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

hook.Add("HUDPaint", "DRC_ColourBlindness", function()
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
		DrawMaterialOverlay(DRC.CameraOverlay or "", DRC.CameraPower)
	end
end)

hook.Add("GetMotionBlurValues", "drc_modifiedmotionblur", function(horizontal, vertical, forward, rotational)
	local ply = LocalPlayer()
	local wpn = ply:GetActiveWeapon()
	
	if wpn.Draconic then
		if !ply.ForwardBlurAdditive then ply.ForwardBlurAdditive = 0 end
		if !ply.RotationalBlurAdditive then ply.RotationalBlurAdditive = 0 end
		
		local kick
		local melee = wpn.IsMelee
		if melee then kick = 1 else kick = wpn.Primary.Kick end
		
		kick = kick*0.001
		ply.ForwardBlurAdditive = Lerp(0.01 * wpn.ForwardDecayMul or 1, ply.ForwardBlurAdditive or ply.ForwardBlurAdditive-kick, 0)
		ply.RotationalBlurAdditive = Lerp(0.025 * wpn.RotationalDecayMul or 1, ply.RotationalBlurAdditive or ply.RotationalBlurAdditive-kick, 0)
	--	ply:ChatPrint(ply.RotationalBlurAdditive)
		
--		if wpn:CanUseSights() == false then forward = 0 return forward end
		
		local w = ScrW()
		local h = ScrH()
		
		local ratio = w/h
		
		local ss = 4 * wpn.Secondary.ScopeScale
		local sw = wpn.Secondary.ScopeWidth
		local sh = wpn.Secondary.ScopeHeight
		
		local wi = w / 10 * ss
		local hi = h / 10 * ss
		
		if ((wpn.Secondary.Scoped == true && wpn.Secondary.ScopeBlur == true) or (wpn.Secondary.Ironsights == true && wpn.Secondary.IronBlur == true)) && wpn.SightsDown == true then
			if sw != 1 then
				forward = forward + (ss * 0.015 / sw) * (wpn.Secondary.IronFOV * ratio * 0.05) * wpn.Secondary.SightsBlurMul
			else
				forward = forward + (ss * 0.0175) / (wpn.Secondary.IronFOV * ratio * 0.01) * wpn.Secondary.SightsBlurMul
			end
		  --  rotational = rotational + 0.05 * math.sin( CurTime() * 3 )
		end
		
		if wpn.SightsDown == false or wpn.IsOverheated == true then
			forward = 0
			if forward > 0 then forward = 0 end
		end
		return horizontal, vertical, forward + ply.ForwardBlurAdditive, rotational + ply.RotationalBlurAdditive
	end
end)