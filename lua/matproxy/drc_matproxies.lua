--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

local HDR = render.GetHDREnabled()
local LMCor = DRC.MapInfo.LMCorrection
DRC.WeathermodScalar = Vector(1,1,1)
local addict = achievements.GetCount(5) >= achievements.GetGoal(5)

if CLIENT then
	hook.Add("Think", "Draconic_Base_Matproxy_Clientside_Think_Please_Just_Trust_Me_It_Isnt_Laggy", function()
		if StormFox2 then
			DRC.WeathermodScalar = Lerp(RealFrameTime() * 2.5, GetSF2LightLevel(0.05), GetSF2LightLevel(0.05))
			DRC.WeathermodScalar = Vector(DRC.WeathermodScalar, DRC.WeathermodScalar, DRC.WeathermodScalar)
		elseif SW && DRC:GetSWLightMod() != nil then
			DRC.WeathermodScalar = Lerp(RealFrameTime() * 2.5, DRC:GetSWLightMod(), DRC:GetSWLightMod())
		end
		
		if !DRC.MapInfo.MapAmbient then DRC.MapInfo.MapAmbient = render.GetAmbientLightColor() end
		if !DRC.MapInfo.MapAmbientAvg then DRC.MapInfo.MapAmbientAvg = (DRC.MapInfo.MapAmbient.x + DRC.MapInfo.MapAmbient.y + DRC.MapInfo.MapAmbient.z) / 3 end
	end)
end

matproxy.Add( {
	name = "drc_EnvmapFallback",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.Envmap = mat:GetString("$envmapfallback")
		self.TintVector = mat:GetVector("$cubemaptintfallback")
		self.PowerFloat = mat:GetFloat("$cubemappowerfallback")
		self.MinFloat	= mat:GetFloat("$cubemapminfallback")
		self.MaxFloat	= mat:GetFloat("$cubemapmaxfallback")
		self.HDRCorrectionLevel	= mat:GetFloat("$cubemapHDRMulfallback")
		self.LDRCorrectionLevel	= mat:GetFloat("$cubemapLDRMulfallback")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		
		if self.TintVector == nil then self.TintVector = Vector(1, 1, 1) end
		if self.PowerFloat == nil then self.PowerFloat = 1 end
		if self.MinFloat == nil then self.MinFloat = 0 end
		if self.MaxFloat == nil then self.MaxFloat = 1 end
		if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
		if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		if self.Envmap == nil then self.Envmap = "env_cubemap" end
		
		if #drc_cubesamples == 0 then
			mat:SetTexture( "$envmap", self.Envmap )
			mat:SetVector( "$cubemaptint", self.TintVector )
			mat:SetFloat( "$cubemappower", self.PowerFloat )
			mat:SetFloat(  "$cubemapmin", self.MinFloat )
			mat:SetFloat(  "$cubemapmax", self.MaxFloat )
			mat:SetFloat(  "$cubemapHDRMul", self.HDRCorrectionLevel )
			mat:SetFloat(  "$cubemapLDRMul", self.LDRCorrectionLevel )
		end
	end
} )

local function GetPlayerColour(src, channel)
	if !IsValid(src) then return end
	local col = Vector(0.5, 0.5, 0.5)
	local translation = {
		["PlayerColour_DRC"] = "Player",
		["WeaponColour_DRC"] = "Weapon",
		["EyeTintVec"] = "Eye",
		["EnergyTintVec"] = "Energy",
		["ColourTintVec1"] = "Tint1",
		["ColourTintVec2"] = "Tint2",
		["Entity"] = "$color2",
		["None"] = Vector(1, 1, 1)
	}
	
	if channel == "Entity" then
		local vals = DRC:GetColours(src, true)
		local pull = translation[channel]
		if vals then col = vals[pull] end
	elseif channel && channel != "Entity" && channel != "None" then
		if (src.Preview == true or src.preview == true) or (src:EntIndex() == LocalPlayer():GetHands():EntIndex()) or (src:GetNWVector(channel, Vector(0,0,0)) == Vector(0,0,0)) then
			local vals = DRC:GetColours(LocalPlayer(), true)
			local pull = translation[channel]
			if vals then col = vals[pull] end
		else
			local vals = DRC:GetColours(src, true)
			local pull = translation[channel]
			if vals then col = vals[pull] end
		end
	elseif channel == "None" then
		return Vector(1,1,1)
	end
	return col/255
end

matproxy.Add( {
	name = "caramell",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.ResultTo2 = values.resultvar2
		self.ResultTo3 = values.resultvar3
	end,

	bind = function( self, mat, ent )
	--	if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		if mat:GetInt("$bpm") == nil then
			if mat:GetInt("$bpm") == nil then self.SpeedMul = 1 else self.SpeedMul = mat:GetInt("$bpm")/60 end
		else
			self.SpeedMul = mat:GetInt("$bpm")/60
		end
		if self.ResultTo == nil then self.ResultTo = "$color2" end
		if self.SpeedMul == nil then self.SpeedMul = 1 end
		local col = Vector(TimedSin(2.75 * self.SpeedMul, 0.5, 1, 0), TimedSin(1.83 * self.SpeedMul, 0.5, 1, 0), TimedSin(0.68 * self.SpeedMul, 0.5, 1, 0))
		mat:SetVector(self.ResultTo, col)
		if self.ResultTo2 then mat:SetVector(self.ResultTo2, col) end
		if self.ResultTo3 then mat:SetVector(self.ResultTo3, col) end
	end
} )

matproxy.Add( {
	name = "drc_PlayerColours",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.MulInt = mat:GetFloat("$colourmul")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		if self.ResultTo == nil then self.ResultTo = "$color2" end
		if self.MulInt == nil then self.MulInt = 1 end
		local col = GetPlayerColour(ent, "PlayerColour_DRC")
		mat:SetVector(self.ResultTo, col * self.MulInt)
	end
} )

matproxy.Add( {
	name = "drc_PlayerColours_ForPlayer", -- This exists solely for compatibility with old content made using this proxy.
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.MulInt = mat:GetFloat("$colourmul")
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		if !IsValid(LocalPlayer()) then return end
		if self.ResultTo == nil then self.ResultTo = "$color2" end
		if self.MulInt == nil then self.MulInt = 1 end
		local col = GetPlayerColour(ent, "PlayerColour_DRC")
		mat:SetVector(self.ResultTo, col * self.MulInt)
	end
} )

matproxy.Add( {
	name = "drc_PlayerWeaponColours",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.MulInt = mat:GetFloat("$colourmul")
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		if !IsValid(LocalPlayer()) then return end
		if self.ResultTo == nil then self.ResultTo = "$color2" end
		if self.MulInt == nil then self.MulInt = 1 end
		local col = GetPlayerColour(ent, "WeaponColour_DRC")
		mat:SetVector(self.ResultTo, col * self.MulInt)
	end
} )

matproxy.Add( {
	name = "drc_WeaponColours_ForPlayer",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.MulInt = mat:GetFloat("$colourmul")
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		if !IsValid(LocalPlayer()) then return end
		if self.ResultTo == nil then self.ResultTo = "$color2" end
		if self.MulInt == nil then self.MulInt = 1 end
		local col = GetPlayerColour(ent, "WeaponColour_DRC")
		mat:SetVector(self.ResultTo, col * self.MulInt)
	end
} )

matproxy.Add( {
	name = "drc_EyeColour",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.MulInt = mat:GetFloat("$colourmul")
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		if !IsValid(LocalPlayer()) then return end
		if self.ResultTo == nil then self.ResultTo = "$color2" end
		if self.MulInt == nil then self.MulInt = 1 end
	--	if addict then
	--		mat:SetVector(self.ResultTo, Vector(TimedSin(2.75, 0.5, 1, 0), TimedSin(1.83, 0.5, 1, 0), TimedSin(0.916, 0.5, 1, 0)))	
	--	return end
		local col = GetPlayerColour(ent, "EyeTintVec")
		mat:SetVector(self.ResultTo, col * self.MulInt)
		
--[[		local shader = string.lower(mat:GetShader())
		
		if shader == "eyes_dx9" then
		--	render.SetColorModulation(col.x, col.y, col.z)
		end ]]
	end
} )

matproxy.Add( {
	name = "drc_EnergyColour",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.PowerFloat = mat:GetFloat("$energy_Mul")
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		local col = nil
		
	--	if addict then
	--		mat:SetVector(self.ResultTo, Vector(TimedSin(2.75, 0.5, 1, 0), TimedSin(1.83, 0.5, 1, 0), TimedSin(0.916, 0.5, 1, 0)))	
	--	return end
		if !self.PowerFloat then self.PowerFloat = 1 end
		
		if ent:GetClass() == "drc_shieldmodel" then
			local col = ent:GetOwner():GetNWVector("EnergyTintVec")
			if col == Vector(0, 0, 0) then col = Vector(0.3, 0.7, 1) end
			mat:SetVector(self.ResultTo, col * self.PowerFloat)
		return end
		
		local flickerflicker = TimedSin(2, 0.6, 1, 0)
		local deathflicker = TimedSin(4, 0.7, flickerflicker, 0)
		if ent:Health() > 0.01 then deathflicker = 1 end
		
		if ent:EntIndex() == LocalPlayer():GetHands():EntIndex() or ent.preview == true then
			deathflicker = 1
		end
		
		local col = GetPlayerColour(ent, "EnergyTintVec")
		mat:SetVector( self.ResultTo, col * deathflicker )	
	end
} )

matproxy.Add( {
	name = "drc_PlayerColour1",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.MulInt = mat:GetFloat("$colourmul")
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end		
		local col = GetPlayerColour(ent, "ColourTintVec1")
		if self.MulInt == nil then self.MulInt = 1 end
		mat:SetVector(self.ResultTo, col * self.MulInt)
	end
} )

matproxy.Add( {
	name = "drc_PlayerColour2",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.MulInt = mat:GetFloat("$colourmul")
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		local col = GetPlayerColour(ent, "ColourTintVec2")
		if self.MulInt == nil then self.MulInt = 1 end
		mat:SetVector(self.ResultTo, col * self.MulInt)
	end
} )

matproxy.Add( {
	name = "drc_CurHeat",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.MinVec = mat:GetVector("$colourfrom")
		self.MaxVec = mat:GetVector("$colourto")
		self.MulInt = mat:GetFloat("$colourmul")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local wepn = owner:GetActiveWeapon()
		if ( !IsValid( wepn ) or !wepn:IsWeapon() ) then return end
		if wepn == nil then return end
		
		if self.MinVec == nil then self.MinVec = Vector(0, 0, 0) end
		if self.MaxVec == nil then self.MaxVec = Vector(0, 0, 0) end
		if self.MulInt == nil then self.MulInt = 1 end
		
		local heat = nil
		if wepn.Draconic != nil then
			heat = wepn.Weapon:GetNWInt("Heat")
		elseif wepn.ArcCW == true then
			heat = wepn:GetHeatLevel() * 100
		end
		
		if heat == nil then return end
		
		local blendvec = LerpVector(heat / 100, self.MinVec, self.MaxVec) * self.MulInt
		
		mat:SetVector( self.ResultTo, blendvec )
	end
} )

matproxy.Add( {
	name = "drc_CurCharge",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.MinVec = mat:GetVector("$colourfrom")
		self.MaxVec = mat:GetVector("$colourto")
		self.MulInt = mat:GetFloat("$colourmul")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local wepn = owner:GetActiveWeapon()
		if ( !IsValid( wepn ) or !wepn:IsWeapon() ) then return end
		if wepn == nil then return end
		if wepn.Weapon == nil then return end
		if wepn.Weapon:GetNWInt("Charge") == nil then return end
		local charge = wepn.Weapon:GetNWInt("Charge")
		
		if charge == nil then return end
		
		local blendvec = LerpVector(charge, self.MinVec, self.MaxVec) * self.MulInt / 500
		
		mat:SetVector( self.ResultTo, blendvec )
	end
} )

matproxy.Add( {
	name = "drc_CurBloom",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.MinVec = mat:GetVector("$colourfrom")
		self.MaxVec = mat:GetVector("$colourto")
		self.MulInt = mat:GetFloat("$colourmul")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local wepn = owner:GetActiveWeapon()
		if ( !IsValid( wepn ) or !wepn:IsWeapon() ) then return end
		if wepn == nil then return end
		if wepn.Weapon == nil then return end
		if wepn.Weapon:GetNWInt("Charge") == nil then return end
		local charge = wepn.Weapon.BloomValue
		charge = math.Clamp(charge, 0, 1)
		
		self.chargelerp = Lerp(RealFrameTime() * 2.5, self.chargelerp or charge, charge)
		
		if charge == nil then return end
		
		local blendvec = LerpVector(self.chargelerp, self.MinVec, self.MaxVec) * self.MulInt / 100
		
		mat:SetVector( self.ResultTo, blendvec )
	end
} )

matproxy.Add( {
	name = "drc_CurMag",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.MinVec = mat:GetVector("$colourfrom")
		self.MaxVec = mat:GetVector("$colourto")
		self.MulInt = mat:GetFloat("$colourmul")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local wpn = owner:GetActiveWeapon()
		if ( !IsValid( wpn ) or !wpn:IsWeapon() ) then return end
		if wpn == nil then return end
		
		if self.MinVec == nil then self.MinVec = Vector(0, 0, 0) end
		if self.MaxVec == nil then self.MaxVec = Vector(0, 0, 0) end
		if self.MulInt == nil then self.MulInt = 1 end
		
		local blendvec = LerpVector(wpn:Clip1() / wpn:GetMaxClip1(), self.MinVec, self.MaxVec) * self.MulInt
		
		mat:SetVector( self.ResultTo, blendvec )
	end
} )

matproxy.Add( {
	name = "drc_IsLoading",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.MinVec = mat:GetVector("$colourfrom")
		self.MaxVec = mat:GetVector("$colourto")
		self.MulInt = mat:GetFloat("$colourmul")
		self.LerpSpeed = mat:GetFloat("$colourls")
		self.CountInspect = mat:GetFloat("$colour_inspect")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local wepn = owner:GetActiveWeapon()
		if ( !IsValid( wepn ) or !wepn:IsWeapon() ) then return end
		if wepn == nil then return end
		
		if self.MinVec == nil then self.MinVec = Vector(1, 1, 1) end
		if self.MaxVec == nil then self.MinVec = Vector(0, 0, 0) end
		if self.MulInt == nil then self.MulInt = 1 end
		if self.LerpSpeed == nil then self.LerpSpeed = 10 end
		if self.CountInspect == nil then self.CountInspect = 0 end
		local val = true
		if wepn:GetNWBool("Readied") == true then val = false end
		if wepn:GetNWBool("Passive") == true then val = true end
		if wepn.Loading == true then val = true end
		if val == true then val = 1 else val = 0 end
		if self.CountInspect >= 1 then
			if val == 0 then
				if wepn:GetNWBool("PlayingInspectAnim") == true then val = 1 else val = 0 end
			end
		end
		
		self.loadinglerp = Lerp(RealFrameTime() * self.LerpSpeed, self.loadinglerp or val, val)
		
		local blendvec = LerpVector(self.loadinglerp, self.MinVec, self.MaxVec) * self.MulInt / 100
		
		mat:SetVector( self.ResultTo, blendvec )
	end
} )

matproxy.Add( {
	name = "drc_Compass",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.SnapDegree = mat:GetFloat("$compassSnap")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then
			local ang = LocalPlayer():EyeAngles()
			if self.SnapDegree == nil then self.SnapDegree = 0.01 end
			local antistupidity = math.Clamp(self.SnapDegree, 0.01, 360)
			
			local angmath = ang:SnapTo("y", antistupidity)

			mat:SetVector( self.ResultTo, Vector(-angmath.y, 0, 0) )
		return end
		if !IsValid(LocalPlayer()) then return end
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local ang = owner:EyeAngles()
		
		if self.SnapDegree == nil then self.SnapDegree = 0.01 end
		local antistupidity = math.Clamp(self.SnapDegree, 0.01, 360)
		
		local angmath = ang:SnapTo("y", antistupidity)

		mat:SetVector( self.ResultTo, Vector(-angmath.y, 0, 0) )
	end
} )

matproxy.Add( {
	name = "drc_Flashlight",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.MinVec = mat:GetVector("$colourfrom")
		self.MaxVec = mat:GetVector("$colourto")
		self.MulInt = mat:GetFloat("$colourmul")
		self.LerpSpeed = mat:GetFloat("$colourls")
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		if !IsValid(LocalPlayer()) then return end
		
		if self.MinVec == nil then self.MinVec = Vector(1, 1, 1) end
		if self.MaxVec == nil then self.MaxVec = Vector(0, 0, 0) end
		if self.MulInt == nil then self.MulInt = 1 end
		if self.LerpSpeed == nil then self.LerpSpeed = 10 end
		if !self.ResultTo then self.ResultTo = "$color2" end
		
		if ent.preview == true then mat:SetVector(self.ResultTo, Vector(1,1,1)) return end
		
		local ply
		
		if ent:IsWeapon() then ply = ent:GetOwner() end
		if ent:EntIndex() == LocalPlayer():GetHands():EntIndex() then ply = LocalPlayer() end
		if ent:EntIndex() == LocalPlayer():GetViewModel():EntIndex() then ply = LocalPlayer() end
		if ent:IsPlayer() then ply = ent end
		
		if !IsValid(ply) then return end
		if !ply:Alive() then return end
		
		local val = true
		if ply:FlashlightIsOn() == true then val = true else val = false end
		if val == true then val = 1 else val = 0 end
		
		ent.DRCFlashlightLerp = Lerp(RealFrameTime() * self.LerpSpeed, ent.DRCFlashlightLerp or val, val)
		ent.FlashlightBlendVec = LerpVector(ent.DRCFlashlightLerp, self.MaxVec, self.MinVec) * self.MulInt
		
		mat:SetVector( self.ResultTo, ent.FlashlightBlendVec )
	end
} )

matproxy.Add( {
	name = "drc_ScalingRimLight",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.PowerFloat = mat:GetFloat("$rimlightpower")
		self.LerpPower = mat:GetFloat("$rimlight_ls")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		local owner = ent
		if !IsValid( owner ) then return end
		
		if self.PowerFloat == nil then self.PowerFloat = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		if ent.Preview == true or ent.preview == true then
			mat:SetFloat("$rimlightboost", (self.PowerFloat * DRC.MapInfo.MapAmbientAvg) /10)
		else
			local lightlevel = render.GetLightColor(ent:GetPos())
			local median = (lightlevel.x + lightlevel.y + lightlevel.z) / 3
			
			ent.val = (self.PowerFloat * median) * DRC.MapInfo.MapAmbientAvg
			if HDR then ent.val = ent.val else ent.val = ent.val * 0.117 end
			
			ent.final = Lerp(RealFrameTime() * 2.5, mat:GetFloat("$rimlightboost"), ent.val) * ((DRC.WeathermodScalar.x + DRC.WeathermodScalar.y + DRC.WeathermodScalar.z) /3)
			mat:SetFloat( "$rimlightboost", ent.val )
		end
	end
} )

matproxy.Add( {
	name = "drc_LL",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.MinVec = mat:GetVector("$ll_colourfrom")
		self.MaxVec = mat:GetVector("$ll_colourto")
		self.LerpPower = mat:GetFloat("$ll_ls")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		local owner = ent
		if !IsValid( owner ) then return end
		if self.MinVec == nil then self.MinVec = Vector(0, 0, 0) end
		if self.MaxVec == nil then self.MaxVec = Vector(1, 1, 1) end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		local lightlevel = render.GetLightColor(owner:GetPos())
		local vec = Vector(lightlevel.x, lightlevel.y, lightlevel.z)
		local median = math.Clamp((vec.x + vec.y + vec.z) / 3, 0.1, 0.75) * 2
		local blendvec = LerpVector(median, self.MinVec, self.MaxVec)
		local val = blendvec
		
		self.drc_locallightlerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), self.drc_locallightlerp or val, val)
		local interp = self.drc_locallightlerp
		mat:SetVector( self.ResultTo, interp )
	end
} )

matproxy.Add( {
	name = "drc_LL_HitPos",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.MinVec = mat:GetVector("$ll_colourfrom")
		self.MaxVec = mat:GetVector("$ll_colourto")
		self.LerpPower = mat:GetFloat("$ll_ls")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		local owner = ent
		if !IsValid( owner ) then return end
		if self.MinVec == nil then self.MinVec = Vector(0, 0, 0) end
		if self.MaxVec == nil then self.MaxVec = Vector(1, 1, 1) end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		local lightlevel = render.GetLightColor(LocalPlayer():GetEyeTrace().HitPos)
		local vec = Vector(lightlevel.x, lightlevel.y, lightlevel.z)
		local median = math.Clamp((vec.x + vec.y + vec.z) / 3, 0.1, 0.75) * 2
		local blendvec = LerpVector(median, self.MinVec, self.MaxVec)
		local val = blendvec
		
		self.drc_locallightlerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), self.drc_locallightlerp or val, val)
		local interp = self.drc_locallightlerp
		mat:SetVector( self.ResultTo, interp )
	end
} )

local function GetCubemapStrength(mat, ent, channel, imat)
	if !IsValid(ent) then return Vector() end
--	if !channel then return Vector() end
	local lightlevel_hands, lightlevel_ragdoll, lightlevel = Vector(), Vector(), Vector()
	local col, val = Vector(), Vector()
	local function GetColour(e, c)
		local colnew = GetPlayerColour(e, c)
		if colnew then
			colnew.x = math.Clamp(colnew.x, mat.MinFloat, mat.MaxFloat)
			colnew.y = math.Clamp(colnew.y, mat.MinFloat, mat.MaxFloat)
			colnew.z = math.Clamp(colnew.z, mat.MinFloat, mat.MaxFloat)
			return colnew
		end
	end
	
	if #drc_cubesamples != 0 then
		mat.TintVector = imat:GetVector("$cubemaptint")
		mat.PowerFloat = imat:GetFloat("$cubemappower")
		mat.MinFloat	= imat:GetFloat("$cubemapmin")
		mat.MaxFloat	= imat:GetFloat("$cubemapmax")
		mat.HDRCorrectionLevel	= imat:GetFloat("$cubemapHDRMul")
		mat.LDRCorrectionLevel	= imat:GetFloat("$cubemapLDRMul")
		if mat.TintVector == nil then mat.TintVector = Vector(1,1,1) end
		if mat.PowerFloat == nil then mat.PowerFloat = 1 end
		if mat.MinFloat == nil then mat.MinFloat = 0 end
		if mat.MaxFloat == nil then mat.MaxFloat = 1 end
		if mat.HDRCorrectionLevel == nil then mat.HDRCorrectionLevel = 1 end
		if mat.LDRCorrectionLevel == nil then mat.LDRCorrectionLevel = 1 end
	else
		if imat:GetVector("cubemaptintfallback") == nil then
			if imat:GetVector("$cubemaptint") == nil then mat.TintVector = Vector(1,1,1) else mat.TintVector = imat:GetVector("$cubemaptint") end
		else
			mat.TintVector = imat:GetVector("$cubemaptintfallback")
		end
		if imat:GetFloat("cubemappowerfallback") == nil then
			if imat:GetFloat("$cubemappower") == nil then mat.PowerFloat = 1 else mat.PowerFloat = imat:GetFloat("$cubemappower") end
		else
			mat.PowerFloat = imat:GetFloat("$cubemappowerfallback")
		end
		if imat:GetFloat("cubemapminfallback") == nil then
			if imat:GetFloat("$cubemapmin") == nil then mat.MinFloat = 0 else mat.MinFloat = imat:GetFloat("$cubemapmin") end
		else
			mat.MinFloat = imat:GetFloat("$cubemapminfallback")
		end
		if imat:GetFloat("cubemapmaxfallback") == nil then
			if imat:GetFloat("$cubemapmax") == nil then mat.MaxFloat = 1 else mat.MaxFloat = imat:GetFloat("$cubemapmax") end
		else
			mat.MaxFloat = imat:GetFloat("$cubemapmaxfallback")
		end
		if imat:GetFloat("cubemapHDRMulfallback") == nil then
			if imat:GetFloat("$cubemapHDRMul") == nil then mat.HDRCorrectionLevel = 1 else mat.HDRCorrectionLevel = imat:GetFloat("$cubemapHDRMul") end
		else
			mat.HDRCorrectionLevel = imat:GetFloat("$cubemapHDRMulfallback")
		end
		if imat:GetFloat("cubemapLDRMulfallback") == nil then
			if imat:GetFloat("$cubemapLDRMul") == nil then mat.LDRCorrectionLevel = 1 else mat.LDRCorrectionLevel = imat:GetFloat("$cubemapLDRMul") end
		else
			mat.LDRCorrectionLevel = imat:GetFloat("$cubemapLDRMulfallback")
		end
	end
	if mat.LerpPower == nil then mat.LerpPower = 1 end
	if mat.TintVector == nil then mat.TintVector = Vector(1, 1, 1) end
	if mat.PowerFloat == nil then mat.PowerFloat = 1 end
	if mat.MinFloat == nil then mat.MinFloat = 0 end
	if mat.MaxFloat == nil then mat.MaxFloat = 1 end
	if mat.HDRCorrectionLevel == nil then mat.HDRCorrectionLevel = 1 end
	if mat.LDRCorrectionLevel == nil then mat.LDRCorrectionLevel = 1 end
	if mat.LerpPower == nil then mat.LerpPower = 1 end
	
	if !ent.DRCReflectionTints then ent.DRCReflectionTints = {} end	

	if ent.Preview == true or ent.preview == true then
		local mul = Vector(1, 1, 1)
		if HDR then mul = mat.HDRCorrectionLevel else mul = (10 * mat.LDRCorrectionLevel) end
		val = (mat.TintVector * mat.PowerFloat * GetColour(LocalPlayer(), channel) * mul) * DRC.MapInfo.MapAmbientAvg * DRC.WeathermodScalar
	return val end
	if ent:EntIndex() == LocalPlayer():GetHands():EntIndex() then
		col = GetColour(LocalPlayer(), channel)
		if !ent.DRCReflectionTints.hands then ent.DRCReflectionTints.hands = { [channel] = col } end
		lightlevel_hands = render.GetLightColor(ent:GetPos())
		
		if HDR then col = col * Vector(lightlevel_hands.r, lightlevel_hands.g, lightlevel_hands.b) * mat.HDRCorrectionLevel
		else col = col * Vector(lightlevel_hands.r, lightlevel_hands.g, lightlevel_hands.b) * (10 * mat.LDRCorrectionLevel) end
		
		ent.DRCReflectionTints.hands[channel] = Lerp(RealFrameTime() * (mat.LerpPower * 2.5), ent.DRCReflectionTints.hands[channel] or col, col)
		local interp = ent.DRCReflectionTints.hands[channel]
		local final = Vector(math.Clamp(interp.x, mat.MinFloat, mat.MaxFloat), math.Clamp(interp.y, mat.MinFloat, mat.MaxFloat), math.Clamp(interp.z, mat.MinFloat, mat.MaxFloat)) * LMCor * DRC.WeathermodScalar
		
		val = ((final * DRC.WeathermodScalar) * mat.TintVector) * mat.PowerFloat
	elseif ent:IsRagdoll() then
		col = GetColour(ent, channel)
		if !ent.DRCReflectionTints.ragdoll then ent.DRCReflectionTints.ragdoll = { [channel] = col } end
		lightlevel_ragdoll = render.GetLightColor(ent:GetPos())
		
		if HDR then col = col * Vector(lightlevel_ragdoll.r, lightlevel_ragdoll.g, lightlevel_ragdoll.b) * mat.HDRCorrectionLevel
		else col = col * Vector(lightlevel_ragdoll.r, lightlevel_ragdoll.g, lightlevel_ragdoll.b) * (10 * mat.LDRCorrectionLevel) end
			
		ent.DRCReflectionTints.ragdoll[channel] = Lerp(RealFrameTime() * (mat.LerpPower * 2.5), ent.DRCReflectionTints.ragdoll[channel] or col, col)
		local interp = ent.DRCReflectionTints.ragdoll[channel]
		local final = Vector(math.Clamp(interp.x, mat.MinFloat, mat.MaxFloat), math.Clamp(interp.y, mat.MinFloat, mat.MaxFloat), math.Clamp(interp.z, mat.MinFloat, mat.MaxFloat)) * LMCor * DRC.WeathermodScalar
		
		val = ((final * DRC.WeathermodScalar) * mat.TintVector) * mat.PowerFloat
	elseif ent:EntIndex() == LocalPlayer():GetViewModel():EntIndex() then
		local newent = LocalPlayer():GetActiveWeapon()
		if !IsValid(newent) then return Vector() end
		if !newent.DRCReflectionTints then newent.DRCReflectionTints = {} end
		col = GetColour(newent, channel)
		if !newent.DRCReflectionTints.weapon then newent.DRCReflectionTints.weapon = { [channel] = col } end
		lightlevel_wpn = render.GetLightColor(ent:GetPos())
		
		if HDR then col = col * Vector(lightlevel_wpn.r, lightlevel_wpn.g, lightlevel_wpn.b) * mat.HDRCorrectionLevel
		else col = col * Vector(lightlevel_wpn.r, lightlevel_wpn.g, lightlevel_wpn.b) * (10 * mat.LDRCorrectionLevel) end
			
		newent.DRCReflectionTints.weapon[channel] = Lerp(RealFrameTime() * (mat.LerpPower * 2.5), newent.DRCReflectionTints.weapon[channel] or col, col)
		local interp = newent.DRCReflectionTints.weapon[channel]
		local final = Vector(math.Clamp(interp.x, mat.MinFloat, mat.MaxFloat), math.Clamp(interp.y, mat.MinFloat, mat.MaxFloat), math.Clamp(interp.z, mat.MinFloat, mat.MaxFloat)) * LMCor * DRC.WeathermodScalar
		
		val = ((final * DRC.WeathermodScalar) * mat.TintVector) * mat.PowerFloat
	else
		col = GetColour(ent, channel)
		if !ent.DRCReflectionTints.render then ent.DRCReflectionTints.render = { [channel] = col } end
		lightlevel = render.GetLightColor(ent:GetPos())
		
		if HDR then col = col * Vector(lightlevel.r, lightlevel.g, lightlevel.b) * mat.HDRCorrectionLevel
		else col = col * Vector(lightlevel.r, lightlevel.g, lightlevel.b) * (10 * mat.LDRCorrectionLevel) end
			
		ent.DRCReflectionTints.render[channel] = Lerp(RealFrameTime() * (mat.LerpPower * 2.5), ent.DRCReflectionTints.render[channel] or col, col)
		local interp = ent.DRCReflectionTints.render[channel]
		local final = Vector(math.Clamp(interp.x, mat.MinFloat, mat.MaxFloat), math.Clamp(interp.y, mat.MinFloat, mat.MaxFloat), math.Clamp(interp.z, mat.MinFloat, mat.MaxFloat)) * LMCor * DRC.WeathermodScalar
		
		val = ((final * DRC.WeathermodScalar) * mat.TintVector) * mat.PowerFloat
	end
	return val
end

matproxy.Add( {
	name = "drc_ReflectionTint",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.TintVector = mat:GetVector("$cubemaptint")
		self.PowerFloat = mat:GetFloat("$cubemappower")
		self.MinFloat	= mat:GetFloat("$cubemapmin")
		self.MaxFloat	= mat:GetFloat("$cubemapmax")
		self.HDRCorrectionLevel	= mat:GetFloat("$cubemapHDRMul")
		self.LDRCorrectionLevel	= mat:GetFloat("$cubemapLDRMul")
		self.LerpPower	= mat:GetFloat("$cubemap_ls")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		local owner = ent
		if !IsValid( owner ) then return end
		
		if !self.ResultTo then self.ResultTo = "$envmaptint" end
		
		local val = GetCubemapStrength(self, ent, "None", mat)
		mat:SetVector(self.ResultTo, val)
	end
} )

matproxy.Add( {
	name = "drc_ReflectionTint_EntityColour",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.TintVector = mat:GetVector("$cubemaptint")
		self.PowerFloat = mat:GetFloat("$cubemappower")
		self.MinFloat	= mat:GetFloat("$cubemapmin")
		self.MaxFloat	= mat:GetFloat("$cubemapmax")
		self.HDRCorrectionLevel	= mat:GetFloat("$cubemapHDRMul")
		self.LDRCorrectionLevel	= mat:GetFloat("$cubemapLDRMul")
		self.LerpPower	= mat:GetFloat("$cubemap_ls")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		local owner = ent
		if !IsValid( owner ) then return end
		
		if !self.ResultTo then self.ResultTo = "$envmaptint" end
		
		local val = GetCubemapStrength(self, ent, "Entity", mat)
		mat:SetVector(self.ResultTo, val)
	end
} )

matproxy.Add( {
	name = "drc_ReflectionTint_PlayerColour",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.TintVector = mat:GetVector("$cubemaptint")
		self.PowerFloat = mat:GetFloat("$cubemappower")
		self.MinFloat	= mat:GetFloat("$cubemapmin")
		self.MaxFloat	= mat:GetFloat("$cubemapmax")
		self.HDRCorrectionLevel	= mat:GetFloat("$cubemapHDRMul")
		self.LDRCorrectionLevel	= mat:GetFloat("$cubemapLDRMul")
		self.LerpPower = mat:GetFloat("$cubemap_ls")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		
		if !self.ResultTo then self.ResultTo = "$envmaptint" end
		
		local val = GetCubemapStrength(self, ent, "PlayerColour_DRC", mat)
		mat:SetVector(self.ResultTo, val)
	end
} )

matproxy.Add( {
	name = "drc_ReflectionTint_EyeColour",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.TintVector = mat:GetVector("$cubemaptint")
		self.PowerFloat = mat:GetFloat("$cubemappower")
		self.MinFloat	= mat:GetFloat("$cubemapmin")
		self.MaxFloat	= mat:GetFloat("$cubemapmax")
		self.HDRCorrectionLevel	= mat:GetFloat("$cubemapHDRMul")
		self.LDRCorrectionLevel	= mat:GetFloat("$cubemapLDRMul")
		self.LerpPower = mat:GetFloat("$cubemap_ls")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		
		if !self.ResultTo then self.ResultTo = "$envmaptint" end
		
		local val = GetCubemapStrength(self, ent, "EyeTintVec", mat)
		mat:SetVector(self.ResultTo, val)
	end
} )

matproxy.Add( {
	name = "drc_ReflectionTint_PlayerTint1",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.TintVector = mat:GetVector("$cubemaptint")
		self.PowerFloat = mat:GetFloat("$cubemappower")
		self.MinFloat	= mat:GetFloat("$cubemapmin")
		self.MaxFloat	= mat:GetFloat("$cubemapmax")
		self.HDRCorrectionLevel	= mat:GetFloat("$cubemapHDRMul")
		self.LDRCorrectionLevel	= mat:GetFloat("$cubemapLDRMul")
		self.LerpPower = mat:GetFloat("$cubemap_ls")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		
		if !self.ResultTo then self.ResultTo = "$envmaptint" end
		
		local val = GetCubemapStrength(self, ent, "ColourTintVec1", mat)
		mat:SetVector(self.ResultTo, val)
	end
} )

matproxy.Add( {
	name = "drc_ReflectionTint_PlayerTint2",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.TintVector = mat:GetVector("$cubemaptint")
		self.PowerFloat = mat:GetFloat("$cubemappower")
		self.MinFloat	= mat:GetFloat("$cubemapmin")
		self.MaxFloat	= mat:GetFloat("$cubemapmax")
		self.HDRCorrectionLevel	= mat:GetFloat("$cubemapHDRMul")
		self.LDRCorrectionLevel	= mat:GetFloat("$cubemapLDRMul")
		self.LerpPower = mat:GetFloat("$cubemap_ls")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		
		if !self.ResultTo then self.ResultTo = "$envmaptint" end
		
		local val = GetCubemapStrength(self, ent, "ColourTintVec2", mat)
		mat:SetVector(self.ResultTo, val)
	end
} )

matproxy.Add( {
	name = "drc_ReflectionTint_WeaponColour",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.TintVector = mat:GetVector("$cubemaptint")
		self.PowerFloat = mat:GetFloat("$cubemappower")
		self.MinFloat	= mat:GetFloat("$cubemapmin")
		self.MaxFloat	= mat:GetFloat("$cubemapmax")
		self.HDRCorrectionLevel	= mat:GetFloat("$cubemapHDRMul")
		self.LDRCorrectionLevel	= mat:GetFloat("$cubemapLDRMul")
		self.PowerFloat = mat:GetFloat("$cubemap_ls")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		
		if !self.ResultTo then self.ResultTo = "$envmaptint" end
		
		local val = GetCubemapStrength(self, ent, "WeaponColour_DRC", mat)
		mat:SetVector(self.ResultTo, val)
	end
} )

matproxy.Add( {
	name = "drc_ScrollMag",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.FlipVar = mat:GetFloat("$flipscroll")
		self.VarMult = mat:GetFloat("$scrollmult")
		self.LerpPower = mat:GetFloat("$scroll_ls")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local wpn = owner:GetActiveWeapon()
		if !IsValid(wpn) then return end
		
		local mag = nil
		local maxmag = nil
		if wpn.Draconic != nil then
			mag = wpn:Clip1()
			maxmag = wpn.Primary.ClipSize
		elseif (wpn.ArcCW == true && wep.ArcCW_Halo_Battery == true) then
			mag = wpn:GetBatteryLevel() * 10
			maxmag = 100
		else
			mag = wpn:Clip1()
			maxmag = wpn.ClipSize
		end
		
		if mag == nil or maxmag == nil then return end

		
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		if self.FlipVar == 0 then
			local magmath = (mag / maxmag) / 2 * self.VarMult
			ent.drc_scrollmaglerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_scrollmaglerp or magmath, magmath)
			mat:SetVector( self.ResultTo, Vector(ent.drc_scrollmaglerp, 0, 0) )
		else
			local magmath = (mag / maxmag) / 2 * self.VarMult
			ent.drc_scrollmaglerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_scrollmaglerp or magmath, magmath)
			mat:SetVector( self.ResultTo, Vector(-ent.drc_scrollmaglerp, 0, 0) )
		end
	end
} )

matproxy.Add( {
	name = "drc_ScrollHeat",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.FlipVar = mat:GetFloat("$flipscroll")
		self.VarMult = mat:GetFloat("$scrollmult")
		self.LerpPower = mat:GetFloat("$scroll_ls")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local wpn = owner:GetActiveWeapon()
		if ( !IsValid( wpn ) ) then return end
		if !IsValid(wpn.Weapon) then return end
		
		if self.FlipVar == nil then self.FlipVar = 0 end
		if self.VarMult == nil then self.VarMult = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		local mag = nil
		local maxmag = nil
		if wpn.Draconic != nil then
			mag = wpn:GetNWInt("Heat")
			maxmag = 100
		elseif (wpn.ArcCW == true && wep.ArcCW_Halo_Battery == true) then
			mag = wepn:GetHeatLevel() * 100
			maxmag = 100
		else
			mag = wpn.Weapon:Clip1()
			maxmag = wpn.Primary.ClipSize
		end
		
		if mag == nil or maxmag == nil then return end

		
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		if self.FlipVar == 0 then
			local magmath = (mag / maxmag) / 2 * self.VarMult
			ent.drc_scrollheatlerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_scrollheatlerp or magmath, magmath)
			mat:SetVector( self.ResultTo, Vector(ent.drc_scrollheatlerp, 0, 0) )
		else
			local magmath = (mag / maxmag) / 2 * self.VarMult
			ent.drc_scrollheatlerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_scrollheatlerp or magmath, magmath)
			mat:SetVector( self.ResultTo, Vector(-ent.drc_scrollheatlerp, 0, 0) )
		end
	end
} )

matproxy.Add( {
	name = "drc_RotateMag",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.RadVar = mat:GetFloat("$radius")
		self.LerpPower = mat:GetFloat("$radius_ls")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local wpn = owner:GetActiveWeapon()
		if wpn == nil then return end
		if wpn.Weapon == nil then return end
		if wpn.Weapon:GetNWInt("LoadedAmmo") == nil then return end
		
		if self.RadVar == nil then self.RadVar = 360 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		local mag = nil
		local maxmag = nil
		if wpn.Draconic != nil then
			mag = wpn.Weapon:Clip1()
			maxmag = wpn.Primary.ClipSize
		elseif (wpn.ArcCW == true && wep.ArcCW_Halo_Battery == true) then
			mag = wpn:GetBatteryLevel() * 10
			maxmag = 100
		else
			mag = wpn.Weapon:Clip1()
			maxmag = wpn.Primary.ClipSize
		end
		
		local magmath = (mag / maxmag) * self.RadVar
		
		self.drc_rotatemaglerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), self.drc_rotatemaglerp or magmath, magmath)

		mat:SetVector( self.ResultTo, Vector(self.drc_rotatemaglerp, 0, 0) )
	end
} )

matproxy.Add( {
	name = "drc_HealthBlend",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.ResultTo2 = values.resultvar2
		self.ResultTo3 = values.resultvar3
		self.MinVec = mat:GetVector("$hp_colourfrom")
		self.MaxVec = mat:GetVector("$hp_colourto")
		self.LerpPower = mat:GetFloat("$hp_ls")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		local owner = ent
		if !IsValid( owner ) then return end
		if self.MinVec == nil then self.MinVec = Vector(0, 0, 0) end
		if self.MaxVec == nil then self.MaxVec = Vector(1, 1, 1) end
		if self.LerpPower == nil then self.LerpPower = 1 end
		if self.ResultTo2 == nil then self.ResulTo2 = "" end
		if self.ResultTo3 == nil then self.ResulTo3 = "" end

		if owner:IsWeapon() then
			local ply = owner:GetOwner()
			local hp, maxhp = DRC:Health(ply)
			
			local hpmath = (hp / maxhp)
			ply.drc_scrollhplerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ply.drc_scrollhplerp or hpmath, hpmath)
			local col = Lerp(ply.drc_scrollhplerp, self.MinVec, self.MaxVec)
			
			if self.ResultTo then mat:SetVector(self.ResultTo, col) end
			if self.ResultTo2 then mat:SetVector(self.ResultTo2, col) end
			if self.ResultTo3 then mat:SetVector(self.ResultTo3, col) end
		elseif owner:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			local ply = LocalPlayer()
			local hp, maxhp = DRC:Health(ply)
			
			local hpmath = (hp / maxhp)
			ply.drc_scrollhplerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ply.drc_scrollhplerp or hpmath, hpmath)
			local col = Lerp(ply.drc_scrollhplerp, self.MinVec, self.MaxVec)
			
			if self.ResultTo then mat:SetVector(self.ResultTo, col) end
			if self.ResultTo2 then mat:SetVector(self.ResultTo2, col) end
			if self.ResultTo3 then mat:SetVector(self.ResultTo3, col) end
		else
			local ply = owner
			local hp, maxhp = DRC:Health(ply)
			
			local hpmath = (hp / maxhp)
			ply.drc_scrollhplerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ply.drc_scrollhplerp or hpmath, hpmath)
			local col = Lerp(ply.drc_scrollhplerp, self.MinVec, self.MaxVec)
				
			if self.ResultTo then mat:SetVector(self.ResultTo, col) end
			if self.ResultTo2 then mat:SetVector(self.ResultTo2, col) end
			if self.ResultTo3 then mat:SetVector(self.ResultTo3, col) end
		end
	end
} )

matproxy.Add( {
	name = "drc_ScrollHP",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.FlipVar = mat:GetFloat("$hpflipscroll")
		self.VarMult = mat:GetFloat("$hpscrollmult")
		self.LerpPower = mat:GetFloat("$hpscroll_ls")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		
		if self.FlipVar == nil then self.FlipVar = 0 end
		if self.VarMult == nil then self.VarMult = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		if owner:IsPlayer() then
			local ply = owner
			local mag = hp
			local maxmag = ply:GetMaxHealth()
			
			if self.FlipVar == 0 then
				local magmath = (mag / maxmag) / 2 * self.VarMult
				ent.drc_scrollmaglerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_scrollmaglerp or magmath, magmath)
				mat:SetVector( self.ResultTo, Vector(ent.drc_scrollmaglerp, 0, 0) )
			else
				local magmath = (mag / maxmag) / 2 * self.VarMult
				ent.drc_scrollmaglerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_scrollmaglerp or magmath, magmath)
				mat:SetVector( self.ResultTo, Vector(-ent.drc_scrollmaglerp, 0, 0) )
			end
		elseif owner:IsWeapon() then
			local ply = owner:GetOwner()
			local mag = hp
			local maxmag = ply:GetMaxHealth()
			
			if self.FlipVar == 0 then
				local magmath = (mag / maxmag) / 2 * self.VarMult
				ent.drc_scrollmaglerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_scrollmaglerp or magmath, magmath)
				mat:SetVector( self.ResultTo, Vector(ent.drc_scrollmaglerp, 0, 0) )
			else
				local magmath = (mag / maxmag) / 2 * self.VarMult
				ent.drc_scrollmaglerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_scrollmaglerp or magmath, magmath)
				mat:SetVector( self.ResultTo, Vector(-ent.drc_scrollmaglerp, 0, 0) )
			end
		elseif owner:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			local ply = LocalPlayer()
			local mag = hp
			local maxmag = ply:GetMaxHealth()
			
			if self.FlipVar == 0 then
				local magmath = (mag / maxmag) / 2 * self.VarMult
				ent.drc_scrollmaglerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_scrollmaglerp or magmath, magmath)
				mat:SetVector( self.ResultTo, Vector(ent.drc_scrollmaglerp, 0, 0) )
			else
				local magmath = (mag / maxmag) / 2 * self.VarMult
				ent.drc_scrollmaglerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_scrollmaglerp or magmath, magmath)
				mat:SetVector( self.ResultTo, Vector(-ent.drc_scrollmaglerp, 0, 0) )
			end
		end
	end
} )

matproxy.Add( {
	name = "drc_RotateHealth",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.RadVar = mat:GetFloat("$hpradius")
		self.LerpPower = mat:GetFloat("$hpradius_ls")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local wpn = owner:GetActiveWeapon()
		if wpn == nil then return end
		if wpn.Weapon == nil then return end
		if wpn.Weapon:GetNWInt("LoadedAmmo") == nil then return end
		
		if self.RadVar == nil then self.RadVar = 360 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		if owner:IsPlayer() then
			local ply = owner
			local mag = ply:Health()
			local maxmag = ply:GetMaxHealth()
			local magmath = (mag / maxmag) * self.RadVar
			self.drc_rotatemaglerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), self.drc_rotatemaglerp or magmath, magmath)

			mat:SetVector( self.ResultTo, Vector(self.drc_rotatemaglerp, 0, 0) )
		elseif owner:IsWeapon() then
			local ply = owner:GetOwner()
			local mag = ply:Health()
			local maxmag = ply:GetMaxHealth()
			local magmath = (mag / maxmag) * self.RadVar
			self.drc_rotatemaglerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), self.drc_rotatemaglerp or magmath, magmath)

			mat:SetVector( self.ResultTo, Vector(self.drc_rotatemaglerp, 0, 0) )
		elseif owner:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			local ply = LocalPlayer()
			local mag = ply:Health()
			local maxmag = ply:GetMaxHealth()
			local magmath = (mag / maxmag) * self.RadVar
			self.drc_rotatemaglerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), self.drc_rotatemaglerp or magmath, magmath)

			mat:SetVector( self.ResultTo, Vector(self.drc_rotatemaglerp, 0, 0) )
		end
	end
} )

local spray_updatetime = 0
matproxy.Add( {
	name = "drc_PlayerSpray",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		if ent.spray_updatetime == nil then ent.spray_updatetime = 0 end
		
		local et = "unknown"
		if ent:IsNPC() then et = "npc" end
		if ent.Preview == tue then et = "previewmodel" end
		if ent:GetOwner():IsPlayer() then et = "scripted" end
		if ent:IsWeapon() then et = "weapon" end
		if ent:EntIndex() == LocalPlayer():GetViewModel():EntIndex() then et = "viewmodel" end
		if ent:GetParent():IsWeapon() then et = "SCKElement" end
		if ent:IsPlayer() then et = "ply" end
		
		local SID = nil
		ent.frames = 1
		local plyent = nil
		if et == "unknown" or et == "previewmodel" then
			plyent = LocalPlayer()
			ent.frames = plyent.DRCSprayFrames
			SID = plyent:SteamID64()
		elseif et == "npc" or et == "scripted" or et == "weapon" then
			plyent = ent:GetNWEntity("SpraySrc")
			if IsValid(plyent) then
				ent.frames = plyent.DRCSprayFrames
				SID = plyent:SteamID64()
			end
		elseif et == "ply" then
			plyent = ent
			ent.frames = ent.DRCSprayFrames
			SID = ent:SteamID64()
		elseif et == "viewmodel" then
			plyent = LocalPlayer():GetActiveWeapon():GetNWEntity("Spawner")
			if IsValid(plyent) then 
				ent.frames = plyent.DRCSprayFrames
				SID = plyent:SteamID64()
			end
		else
			plyent = LocalPlayer()
			ent.frames = plyent.DRCSprayFrames
			SID = plyent:SteamID64()
		end
		
		if !IsValid(plyent) then
			mat:SetTexture("$basetexture", "models/effects/vol_light001")
			mat:SetTexture("$bumpmap", "models/effects/vol_light001")
			mat:SetFloat("$translucent", 1)
			mat:SetFloat("$cloakpassenabled", 1)
			mat:SetFloat("$cloakfactor", 1)
		return end
		
		local display_generic = plyent:GetNWBool("ShowSpray_Ents")
		local display_weapons = plyent:GetNWBool("ShowSpray_Weapons")
		local display_vehicles = plyent:GetNWBool("ShowSpray_Vehicles")
		local display_player = plyent:GetNWBool("ShowSpray_Player")
		
		if ent.LFS == true then
			if !IsValid(ent:GetDriverSeat()) then return end
			if !IsValid(ent:GetDriverSeat():GetDriver()) then return end
			ent.frames = ent:GetDriverSeat():GetDriver().DRCSprayFrames
			if IsValid(ent:GetDriverSeat():GetDriver()) then
				ent.DRCSprayFrames = ent.frames
				SID = ent:GetDriverSeat():GetDriver():SteamID64()
			end
			ent.frames = ent.DRCSprayFrames
		end
		
		if ent:IsVehicle() then
			frames = ent:GetDriver().DRCSprayFrames
			if IsValid(ent:GetDriver()) then
				ent.DRCSprayFrames = ent.frames
				SID = ent:GetDriver():SteamID64()
			end
			ent.frames = ent.DRCSprayFrames
		end
		
		if !SID then
			mat:SetTexture("$basetexture", "models/effects/vol_light001")
		--	mat:SetTexture("$detail", "models/effects/vol_light001")
			mat:SetFloat("$translucent", 1)
			mat:SetFloat("$cloakpassenabled", 1)
			mat:SetFloat("$cloakfactor", 1)
		return end
		
		if !ent.frames then ent.frames = 1 end
		
		local c1 = false
		if et == "viewmodel" or et == "weapon" or et == "SCKElement" then
			if display_weapons == 0 then
				mat:SetTexture("$basetexture", "models/effects/vol_light001")
				ent.nodetail_spray = false
				if mat:GetTexture("$detail"):GetName() == "error" then ent.nodetail_spray = true end
				if ent.nodetail_spray == true then mat:SetTexture("$bumpmap", "models/effects/vol_light001") end
				mat:SetFloat("$translucent", 1)
				mat:SetFloat("$cloakpassenabled", 1)
				mat:SetFloat("$cloakfactor", 1)
			return end
		end
		if et == "npc" or et == "scripted" then
			if display_generic == 0 then
				mat:SetTexture("$basetexture", "models/effects/vol_light001")
				ent.nodetail_spray = false
				if mat:GetTexture("$detail"):GetName() == "error" then ent.nodetail_spray = true end
				if ent.nodetail_spray == true then mat:SetTexture("$bumpmap", "models/effects/vol_light001") end
				mat:SetFloat("$translucent", 1)
				mat:SetFloat("$cloakpassenabled", 1)
				mat:SetFloat("$cloakfactor", 1)
			return end
		end
		if et == "ply" or et == "previewmodel" then
			if display_player == 0 then
				mat:SetTexture("$basetexture", "models/effects/vol_light001")
				ent.nodetail_spray = false
				if mat:GetTexture("$detail"):GetName() == "error" then ent.nodetail_spray = true end
				if ent.nodetail_spray == true then mat:SetTexture("$bumpmap", "models/effects/vol_light001") end
				mat:SetFloat("$translucent", 1)
				mat:SetFloat("$cloakpassenabled", 1)
				mat:SetFloat("$cloakfactor", 1)
			return end
		end
		
		mat:SetFloat("$cloakpassenabled", 0)
		mat:SetFloat("$cloakfactor", 0)
		
		if game.SinglePlayer() == true or ent.Preview == true then
			mat:SetTexture("$basetexture", "vgui/logos/spray")
			local fps = 0.33
			if CurTime() > ent.spray_updatetime then
				local frame = mat:GetInt("$frame")
				if frame > ent.frames then frame = 0 end
				mat:SetInt("$frame", frame + 1)
				ent.spray_updatetime = CurTime() + fps
			end
		else
			mat:SetTexture("$basetexture", "../data/draconic/sprays/".. SID .."")
		end
		
		ent.nobump_spray = false
		if mat:GetTexture("$bumpmap"):GetName() == "error" then ent.nobump_spray = true else ent.nobump_spray = false end
		if mat:GetTexture("$bumpmap"):GetName() == "models/effects/vol_light001" then mat:SetTexture("$bumpmap", "dev/bump_normal") end
		if ent.nobump_spray == true then mat:SetTexture("$bumpmap", "dev/bump_normal") end
	end
} )

matproxy.Add( {
	name = "drc_Blink",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.FrameNum = mat:GetInt("$drcframes")
		self.Framerate = mat:GetInt("$drcfps")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		
		if ent:Health() <= 0 && ent.preview != true then mat:SetInt("$frame", self.FrameNum - 1) return end
		if !ent.DRCBlinkFrame then ent.DRCBlinkFrame = 0 end
		
		local num = self.FrameNum - 1
		if !self.Framerate then self.Framerate = 80 end
		if !ent.DRCBlinkStatus then ent.DRCBlinkStatus = false end
		if !ent.DRCBlinkTimed then ent.DRCBlinkTimed = false end
		if !ent.DRCBlinkFrame then ent.DRCBlinkFrame = 0 end
		if ent.DRCBlinkFrame < 0 or ent.DRCBlinkFrame > num then ent.DRCBlinkFrame = 0 end
		
		if ent.DRCBlinkStatus == false && ent.DRCBlinkTimed == false then
			ent.DRCBlinkStatus = true
			ent.DRCBlinkTimed = true
			ent.DRCBlinkFrame = 0
			timer.Simple(math.Rand(5, 24), function()
				ent.DRCBlinkStatus = false
				ent.DRCBlinkTimed = false
				
				for i=0,self.FrameNum do
					timer.Simple(i * self.FrameNum/self.Framerate, function()
				--		if !IsValid(ent) or !IsValid(self) then return end
						if !ent.DRCBlinkFrame then ent.DRCBlinkFrame = 0 end
						if ent.DRCBlinkFrame then ent.DRCBlinkFrame = ent.DRCBlinkFrame + 1 end
					end)
				end
			end)
		end
		
		mat:SetInt("$frame", ent.DRCBlinkFrame)
	end
} )

matproxy.Add( {
	name = "drc_Firemode",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		if !IsValid(LocalPlayer()) then return end
		local wpn = ent
		if (wpn:EntIndex() == LocalPlayer():GetViewModel(0):EntIndex()) or ent:GetClass() == "class C_BaseFlex" then
			if DRC:ThirdPersonEnabled(LocalPlayer()) then return end
			wpn = LocalPlayer():GetActiveWeapon()
		end
		if !IsValid(wpn) then return end
		local base = DRC:GetBaseName(wpn)
		local fm = "Semi"
		local safety = nil
		local frames = {
			["Safe"] = 0,
			["Semi"] = 1,
			["Burst"] = 2,
			["Auto"] = 3
		}
		if base == "drc" then
			fm = wpn:GetNWString("Firemode")
			safety = wpn:GetNWBool("Passive")
			
			fm = frames[fm]
			if safety == true then fm = frames["Safe"] end
		elseif base == "arccw" then
			local translation = {
				"Safe",
				"Semi",
				"Auto",
				"Burst",
			}
			-- safe 0, semi 1, auto 2, burst negative
			fm = wpn:GetCurrentFiremode().Mode
			
			if fm < 0 then fm = "Burst" 
			else fm = translation[fm+1] end
			fm = frames[fm]
		end
		if !isnumber(fm) then return end
		mat:SetInt("$frame", fm)
	end
} )

matproxy.Add( {
	name = "drc_ScollPitch",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.LerpPower = mat:GetFloat("$pitch_ls")
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then ent = LocalPlayer() end
		if ent:IsWeapon() && ent:GetOwner():EntIndex() != 0 then ent = ent:GetOwner() end
		
		if !self.LerpPower then self.LerpPower = 1 end
		
		local ea = ent:EyeAngles()
		local pitch = ea.x
		
		self.drc_scrollpitchlerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), self.drc_scrollpitchlerp or ea.x, ea.x)

		mat:SetVector( self.ResultTo, Vector(0, self.drc_scrollpitchlerp/3.33333333) )
	end
} )

matproxy.Add( {
	name = "drc_ShieldFade",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		if !IsValid(LocalPlayer()) then return end
		
		local ohp, mohp = nil, nil
		if ent:GetClass() == "drc_dummy" then ohp, mohp, ent = DRC:GetShield(LocalPlayer()) end
		
		local parent = ent:GetOwner()
		local hp, mhp, ent = DRC:GetShield(parent)
		local vis = parent:GetNWInt("DRC_ShieldVisibility")
		local glow = parent:GetNWInt("DRC_Shield_AlwaysGlow")
		if hp < 0.01 then vis = 0 end
		if glow == false && !DRC:GetOverShield(parent) then
			ent.DRCShieldVis = Lerp(RealFrameTime() * 10, ent.DRCShieldVis or vis, vis)
		elseif glow == true then
			if hp < 0.01 then ent.DRCShieldVis = 0 else ent.DRCShieldVis = 1 end
		elseif glow == false && DRC:GetOverShield(parent) != nil then
			ent.DRCShieldVis = math.Clamp(Lerp(RealFrameTime() * 10, ent.DRCShieldVis or vis, vis), 0.5, 1)
		end
		
		if DRC:GetShieldInvulnerability(parent) == true then ent.DRCShieldVis = 1 end
		
		if GetConVar("cl_drc_debugmode"):GetFloat() != 0 && GetConVar("cl_drc_debug_alwaysshowshields"):GetFloat() == 1 then ent.DRCShieldVis = 1 end
		
		ent.RenderOverride = function()
			render.SetBlend(0)
			mat:SetFloat("$emissiveBlendStrength", ent.DRCShieldVis)
			ent:DrawModel()
		end
	end
} )