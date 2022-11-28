--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

local HDR = render.GetHDREnabled()
local LMCor = DRC.MapInfo.LMCorrection
DRC.WeathermodScalar = Vector(1,1,1)
-- local addict = achievements.GetCount(5) >= achievements.GetGoal(5)

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

local function GetPlayerColour(src)
	if !IsValid(src) then return end
	local col = Vector(0.5, 0.5, 0.5)
	if src.Preview == true then col = Vector(LocalPlayer():GetInfo("cl_playercolor")) end
	if src:GetNWVector("PlayerColour_DRC", Vector(0,0,0)) != Vector(0,0,0) then col = src:GetNWVector("PlayerColour_DRC") end
	if src:EntIndex() == LocalPlayer():GetHands():EntIndex() then col = LocalPlayer():GetNWVector("PlayerColour_DRC") end
	if src:GetNWVector("PlayerColour_DRC", Vector(0,0,0)) == Vector(0,0,0) then col = LocalPlayer():GetNWVector("PlayerColour_DRC") end
	return col
end

matproxy.Add( {
	name = "drc_PlayerColours",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		if self.ResultTo == nil then self.ResultTo = "$color2" end
		local col = GetPlayerColour(ent)
		mat:SetVector( self.ResultTo, col )
	end
} )

matproxy.Add( {
	name = "drc_PlayerColours_ForPlayer",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(LocalPlayer()) then return end
		if self.ResultTo == nil then self.ResultTo = "$color2" end
		local col = GetPlayerColour(ent)
		mat:SetVector( self.ResultTo, col )
	end
} )

local function FuckMeIWasDumb_PlayerColours(self, mat, ent)
	if ( !IsValid( ent )) then return end
	if !IsValid(LocalPlayer()) then return end
		local owner = ent:GetOwner()
		
		if ent:EntIndex() == LocalPlayer():GetViewModel():EntIndex() then
			if !IsValid(ent:GetOwner():GetActiveWeapon()) then return end
			local col = DRC:GetColours(ent:GetOwner():GetActiveWeapon()).Weapon / 255
			return col
		end
		
		if ent:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			if !ent:IsValid() then return end
			local col = LocalPlayer():GetNWVector("WeaponColour_DRC") / 255
			if ( !isvector( col )) then return end
			return col
		else
			if !ent:IsValid() then return end
			local col = DRC:GetColours(ent).Weapon / 255
			if ( !isvector( col )) then return end
			return col
		end
end

matproxy.Add( {
	name = "drc_PlayerWeaponColours",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		local col = FuckMeIWasDumb_PlayerColours(self, mat, ent)
		if !col then return end
		mat:SetVector( self.ResultTo, col )
	end
} )

matproxy.Add( {
	name = "drc_WeaponColours_ForPlayer",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		local col = nil
		
		if ent.Preview == true then
			col = Vector(LocalPlayer():GetInfo("cl_weaponcolor"))
		elseif ent:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			col = LocalPlayer():GetNWVector("WeaponColour_DRC")
		else
			col = ent:GetNWVector("WeaponColour_DRC")
			if col == Vector(0, 0, 0) then col = Vector(LocalPlayer():GetInfo("cl_weaponcolor")) end
		end
		mat:SetVector( self.ResultTo, col )	
	end
} )

matproxy.Add( {
	name = "drc_EyeColour",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		local col, mul = nil
	--	if addict then
	--		mat:SetVector(self.ResultTo, Vector(TimedSin(2.75, 0.5, 1, 0), TimedSin(1.83, 0.5, 1, 0), TimedSin(0.916, 0.5, 1, 0)))	
	--	return end
		if ent:EntIndex() == LocalPlayer():GetViewModel():EntIndex() then
			local col = LocalPlayer():GetActiveWeapon():GetNWVector("EyeTintVec") / 255
			mat:SetVector( self.ResultTo, col )
		return end
		
		if ent.Preview == true then
			col = LocalPlayer():GetNWVector("EyeTintVec") / 255
		elseif ent:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			col = LocalPlayer():GetNWVector("EyeTintVec") / 255
		else
			col = ent:GetNWVector("EyeTintVec") / 255
			if col == Vector(0, 0, 0) then col = Vector(LocalPlayer():GetInfo("cl_drc_eyecolour_r"), LocalPlayer():GetInfo("cl_drc_eyecolour_g"), LocalPlayer():GetInfo("cl_drc_eyecolour_b")) end
		end
		mat:SetVector( self.ResultTo, col )	
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
		local col, mul = nil
		
	--	if addict then
	--		mat:SetVector(self.ResultTo, Vector(TimedSin(2.75, 0.5, 1, 0), TimedSin(1.83, 0.5, 1, 0), TimedSin(0.916, 0.5, 1, 0)))	
	--	return end
		if !self.PowerFloat then self.PowerFloat = 1 end
		
		if ent:GetClass() == "drc_shieldmodel" then
			local col = ent:GetOwner():GetNWVector("EnergyTintVec")
			if col == Vector(0, 0, 0) then col = Vector(0.3, 0.7, 1) end
			mat:SetVector(self.ResultTo, col * self.PowerFloat)
		return end
		
		if ent:EntIndex() == LocalPlayer():GetViewModel():EntIndex() then
			local col = LocalPlayer():GetActiveWeapon():GetNWVector("EnergyTintVec") / 255
			mat:SetVector( self.ResultTo, col )
		return end
		
		if ent.Preview == true then
			local col = LocalPlayer():GetNWVector("EnergyTintVec")
			if col == Vector(0, 0, 0) then col = Vector(0.3, 0.7, 1) end
			mat:SetVector(self.ResultTo, col * self.PowerFloat)
		return end
		
		local flickerflicker = TimedSin(2, 0.6, 1, 0)
		local deathflicker = TimedSin(4, 0.7, flickerflicker, 0)
		if ent:Health() > 0.01 then deathflicker = 1 end
		
		if ent:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			col = LocalPlayer():GetNWVector("EnergyTintVec")
			deathflicker = 1
		else
			col = ent:GetNWVector("EnergyTintVec")
			if col == Vector(0, 0, 0) then 
				col = Vector(LocalPlayer():GetInfo("cl_drc_energycolour_r")/255, LocalPlayer():GetInfo("cl_drc_energycolour_g")/255, LocalPlayer():GetInfo("cl_drc_energycolour_b")/255)
			end
		end
		
		
		
		mat:SetVector( self.ResultTo, (col) * deathflicker )	
	end
} )

matproxy.Add( {
	name = "drc_PlayerColour1",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		local col, mul = nil
		
		if ent:EntIndex() == LocalPlayer():GetViewModel():EntIndex() then
			local col = LocalPlayer():GetActiveWeapon():GetNWVector("ColourTintVec1") / 255
			local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
			mat:SetVector( self.ResultTo, col + col * mul )
		return end
		
		if ent.Preview == true then
			col = LocalPlayer():GetNWVector("ColourTintVec1") / 255
			mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0	
		elseif ent:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			col = LocalPlayer():GetNWVector("ColourTintVec1") / 255
			mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0	
		else
			col = ent:GetNWVector("ColourTintVec1") / 255
			if col == Vector(0, 0, 0) then col = Vector(LocalPlayer():GetInfo("cl_drc_tint1_r"), LocalPlayer():GetInfo("cl_drc_tint1_g"), LocalPlayer():GetInfo("cl_drc_tint1_b")) / 255 end
			mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0	
		end
		mat:SetVector( self.ResultTo, col + col * mul )	
	end
} )

matproxy.Add( {
	name = "drc_PlayerColour2",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		local col, mul = nil
		
		if ent:EntIndex() == LocalPlayer():GetViewModel():EntIndex() then
			local col = LocalPlayer():GetActiveWeapon():GetNWVector("ColourTintVec2") / 255
			local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
			mat:SetVector( self.ResultTo, col + col * mul )
		return end
		
		if ent.Preview == true then
			col = LocalPlayer():GetNWVector("ColourTintVec2") / 255
			mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0	
		elseif ent:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			col = LocalPlayer():GetNWVector("ColourTintVec2") / 255
			mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0	
		else
			col = ent:GetNWVector("ColourTintVec2") / 255
			if col == Vector(0, 0, 0) then col = Vector(LocalPlayer():GetInfo("cl_drc_tint2_r"), LocalPlayer():GetInfo("cl_drc_tint2_g"), LocalPlayer():GetInfo("cl_drc_tint2_b")) / 255 end
			mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0	
		end
		mat:SetVector( self.ResultTo, col + col * mul )	
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
		
		if ent.Preview == true then
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
		
		if #drc_cubesamples != 0 then
			self.TintVector = mat:GetVector("$cubemaptint")
			self.PowerFloat = mat:GetFloat("$cubemappower")
			self.MinFloat	= mat:GetFloat("$cubemapmin")
			self.MaxFloat	= mat:GetFloat("$cubemapmax")
			self.HDRCorrectionLevel	= mat:GetFloat("$cubemapHDRMul")
			self.LDRCorrectionLevel	= mat:GetFloat("$cubemapLDRMul")
			
			if self.TintVector == nil then self.TintVector = Vector(1,1,1) end
			if self.PowerFloat == nil then self.PowerFloat = 1 end
			if self.MinFloat == nil then self.MinFloat = 0 end
			if self.MaxFloat == nil then self.MaxFloat = 1 end
			if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
			if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		else
			if mat:GetVector("cubemaptintfallback") == nil then
				if mat:GetVector("$cubemaptint") == nil then self.TintVector = Vector(1,1,1) else self.TintVector = mat:GetVector("$cubemaptint") end
			else
				self.TintVector = mat:GetVector("$cubemaptintfallback")
			end
			if mat:GetFloat("cubemappowerfallback") == nil then
				if mat:GetFloat("$cubemappower") == nil then self.PowerFloat = 1 else self.PowerFloat = mat:GetFloat("$cubemappower") end
			else
				self.PowerFloat = mat:GetFloat("$cubemappowerfallback")
			end
			if mat:GetFloat("cubemapminfallback") == nil then
				if mat:GetFloat("$cubemapmin") == nil then self.MinFloat = 0 else self.MinFloat = mat:GetFloat("$cubemapmin") end
			else
				self.MinFloat = mat:GetFloat("$cubemapminfallback")
			end
			if mat:GetFloat("cubemapmaxfallback") == nil then
				if mat:GetFloat("$cubemapmax") == nil then self.MaxFloat = 1 else self.MaxFloat = mat:GetFloat("$cubemapmax") end
			else
				self.MaxFloat = mat:GetFloat("$cubemapmaxfallback")
			end
			if mat:GetFloat("cubemapHDRMulfallback") == nil then
				if mat:GetFloat("$cubemapHDRMul") == nil then self.HDRCorrectionLevel = 1 else self.HDRCorrectionLevel = mat:GetFloat("$cubemapHDRMul") end
			else
				self.HDRCorrectionLevel = mat:GetFloat("$cubemapHDRMulfallback")
			end
			if mat:GetFloat("cubemapLDRMulfallback") == nil then
				if mat:GetFloat("$cubemapLDRMul") == nil then self.LDRCorrectionLevel = 1 else self.LDRCorrectionLevel = mat:GetFloat("$cubemapLDRMul") end
			else
				self.LDRCorrectionLevel = mat:GetFloat("$cubemapLDRMulfallback")
			end
		end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		if self.TintVector == nil then self.TintVector = Vector(1, 1, 1) end
		if self.PowerFloat == nil then self.PowerFloat = 1 end
		if self.MinFloat == nil then self.MinFloat = 0 end
		if self.MaxFloat == nil then self.MaxFloat = 1 end
		if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
		if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		if ent.Preview == true then
			local mul = Vector(1, 1, 1)
			if HDR then mul = self.HDRCorrectionLevel else mul = (10 * self.LDRCorrectionLevel) end
			mat:SetVector( self.ResultTo, (self.TintVector * self.PowerFloat * mul) * DRC.MapInfo.MapAmbientAvg * DRC.WeathermodScalar )
		end
		
		local pcr_hands, pcg_hands, pcb_hands, lightlevel_hands = 0, 0, 0, Vector(0, 0, 0)
		local pcr_ragdoll, pcg_ragdoll, pcb_ragdoll, lightlevel_ragdoll = 0, 0, 0, Vector(0, 0, 0)
		local pcr, pcg, pcb, lightlevel = 0, 0, 0, Vector(0, 0, 0)
		if ent:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			lightlevel_hands = render.GetLightColor(ent:GetPos())
			local col = Vector(0, 0, 0)
			if HDR then col = Vector(lightlevel_hands.r, lightlevel_hands.g, lightlevel_hands.b) * self.HDRCorrectionLevel
			else col = Vector(lightlevel_hands.r, lightlevel_hands.g, lightlevel_hands.b) * (10 * self.LDRCorrectionLevel) end
			if ( !isvector( col )) then return end
				
			self.drc_reflectiontintlerp_hands = Lerp(RealFrameTime() * (self.LerpPower * 2.5), self.drc_reflectiontintlerp_hands or col, col)
			local interp = self.drc_reflectiontintlerp_hands
			
			local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = (final * DRC.WeathermodScalar * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		elseif ent:IsRagdoll() then
			lightlevel_ragdoll = render.GetLightColor(ent:GetPos())
			local col = Vector(lightlevel_ragdoll.r, lightlevel_ragdoll.g, lightlevel_ragdoll.b)
			if ( !isvector( col )) then return end
				
			ent.drc_reflectiontintlerp_ragdoll = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_ragdoll or col, col)
			local interp = ent.drc_reflectiontintlerp_ragdoll
			
			local mul = Vector(1, 1, 1)
			if HDR then mul = interp * self.HDRCorrectionLevel else mul = interp * (10 * self.LDRCorrectionLevel) end
			
			local finalx = math.Clamp(mul.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(mul.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(mul.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = (final * DRC.WeathermodScalar * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		else
			lightlevel = render.GetLightColor(ent:GetPos())
			local col = Vector(lightlevel.r, lightlevel.g, lightlevel.b)
			if ( !isvector( col )) then return end
				
			ent.drc_reflectiontintlerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp or col, col)
			local interp = ent.drc_reflectiontintlerp
			
			local mul = Vector(1, 1, 1)
			if HDR then mul = interp * self.HDRCorrectionLevel else mul = interp * (10 * self.LDRCorrectionLevel) end
			
			local finalx = math.Clamp(mul.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(mul.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(mul.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = (final * DRC.WeathermodScalar * self.TintVector) * self.PowerFloat
		--	val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		end
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
		
		if #drc_cubesamples != 0 then
			self.TintVector = mat:GetVector("$cubemaptint")
			self.PowerFloat = mat:GetFloat("$cubemappower")
			self.MinFloat	= mat:GetFloat("$cubemapmin")
			self.MaxFloat	= mat:GetFloat("$cubemapmax")
			self.HDRCorrectionLevel	= mat:GetFloat("$cubemapHDRMul")
			self.LDRCorrectionLevel	= mat:GetFloat("$cubemapLDRMul")
			
			if self.TintVector == nil then self.TintVector = Vector(1,1,1) end
			if self.PowerFloat == nil then self.PowerFloat = 1 end
			if self.MinFloat == nil then self.MinFloat = 0 end
			if self.MaxFloat == nil then self.MaxFloat = 1 end
			if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
			if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		else
			if mat:GetVector("cubemaptintfallback") == nil then
				if mat:GetVector("$cubemaptint") == nil then self.TintVector = Vector(1,1,1) else self.TintVector = mat:GetVector("$cubemaptint") end
			else
				self.TintVector = mat:GetVector("$cubemaptintfallback")
			end
			if mat:GetFloat("cubemappowerfallback") == nil then
				if mat:GetFloat("$cubemappower") == nil then self.PowerFloat = 1 else self.PowerFloat = mat:GetFloat("$cubemappower") end
			else
				self.PowerFloat = mat:GetFloat("$cubemappowerfallback")
			end
			if mat:GetFloat("cubemapminfallback") == nil then
				if mat:GetFloat("$cubemapmin") == nil then self.MinFloat = 0 else self.MinFloat = mat:GetFloat("$cubemapmin") end
			else
				self.MinFloat = mat:GetFloat("$cubemapminfallback")
			end
			if mat:GetFloat("cubemapmaxfallback") == nil then
				if mat:GetFloat("$cubemapmax") == nil then self.MaxFloat = 1 else self.MaxFloat = mat:GetFloat("$cubemapmax") end
			else
				self.MaxFloat = mat:GetFloat("$cubemapmaxfallback")
			end
			if mat:GetFloat("cubemapHDRMulfallback") == nil then
				if mat:GetFloat("$cubemapHDRMul") == nil then self.HDRCorrectionLevel = 1 else self.HDRCorrectionLevel = mat:GetFloat("$cubemapHDRMul") end
			else
				self.HDRCorrectionLevel = mat:GetFloat("$cubemapHDRMulfallback")
			end
			if mat:GetFloat("cubemapLDRMulfallback") == nil then
				if mat:GetFloat("$cubemapLDRMul") == nil then self.LDRCorrectionLevel = 1 else self.LDRCorrectionLevel = mat:GetFloat("$cubemapLDRMul") end
			else
				self.LDRCorrectionLevel = mat:GetFloat("$cubemapLDRMulfallback")
			end
		end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		if self.TintVector == nil then self.TintVector = Vector(1, 1, 1) end
		if self.PowerFloat == nil then self.PowerFloat = 1 end
		if self.MinFloat == nil then self.MinFloat = 0 end
		if self.MaxFloat == nil then self.MaxFloat = 1 end
		if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
		if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		local lightlevel = render.GetLightColor(owner:GetPos())
		
		local lightr = math.Clamp(lightlevel.x, self.MinFloat, self.MaxFloat)
		local lightg = math.Clamp(lightlevel.y, self.MinFloat, self.MaxFloat)
		local lightb = math.Clamp(lightlevel.z, self.MinFloat, self.MaxFloat)
		
		if HDR then
			col = Vector(lightr, lightg, lightb) * self.HDRCorrectionLevel
		else
			col = Vector(lightr, lightg, lightb) * (10 * self.LDRCorrectionLevel)
		end
		
		local ecol = owner:GetColor()
		local ecoli = Vector(ecol.r, ecol.g, ecol.b)
		if ( !isvector( col )) then return end
		if ( !isvector( ecoli )) then return end
		
		local roundedx = math.Round(ecoli.r, 0) / 255
		local roundedy = math.Round(ecoli.g, 0) / 255
		local roundedz = math.Round(ecoli.b, 0) / 255
		
		local roundedvec = Vector(roundedx, roundedy, roundedz)
		
		ent.drc_reflectiontintlerp_ent = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_ent or col, col)
		local interp = roundedvec * ent.drc_reflectiontintlerp_ent

		local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
		local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
		local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
		local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
		
		local correction = nil
		if HDR then correction = self.HDRCorrectionLevel else correction = (((lightlevel.r + lightlevel.g + lightlevel.b) / 3) * self.LDRCorrectionLevel) end
				
		mat:SetVector( self.ResultTo, (final * self.PowerFloat) * (self.TintVector * self.PowerFloat) * final )
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
		
		if #drc_cubesamples != 0 then
			self.TintVector = mat:GetVector("$cubemaptint")
			self.PowerFloat = mat:GetFloat("$cubemappower")
			self.MinFloat	= mat:GetFloat("$cubemapmin")
			self.MaxFloat	= mat:GetFloat("$cubemapmax")
			self.HDRCorrectionLevel	= mat:GetFloat("$cubemapHDRMul")
			self.LDRCorrectionLevel	= mat:GetFloat("$cubemapLDRMul")
			
			if self.TintVector == nil then self.TintVector = Vector(1,1,1) end
			if self.PowerFloat == nil then self.PowerFloat = 1 end
			if self.MinFloat == nil then self.MinFloat = 0 end
			if self.MaxFloat == nil then self.MaxFloat = 1 end
			if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
			if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		else
			if mat:GetVector("cubemaptintfallback") == nil then
				if mat:GetVector("$cubemaptint") == nil then self.TintVector = Vector(1,1,1) else self.TintVector = mat:GetVector("$cubemaptint") end
			else
				self.TintVector = mat:GetVector("$cubemaptintfallback")
			end
			if mat:GetFloat("cubemappowerfallback") == nil then
				if mat:GetFloat("$cubemappower") == nil then self.PowerFloat = 1 else self.PowerFloat = mat:GetFloat("$cubemappower") end
			else
				self.PowerFloat = mat:GetFloat("$cubemappowerfallback")
			end
			if mat:GetFloat("cubemapminfallback") == nil then
				if mat:GetFloat("$cubemapmin") == nil then self.MinFloat = 0 else self.MinFloat = mat:GetFloat("$cubemapmin") end
			else
				self.MinFloat = mat:GetFloat("$cubemapminfallback")
			end
			if mat:GetFloat("cubemapmaxfallback") == nil then
				if mat:GetFloat("$cubemapmax") == nil then self.MaxFloat = 1 else self.MaxFloat = mat:GetFloat("$cubemapmax") end
			else
				self.MaxFloat = mat:GetFloat("$cubemapmaxfallback")
			end
			if mat:GetFloat("cubemapHDRMulfallback") == nil then
				if mat:GetFloat("$cubemapHDRMul") == nil then self.HDRCorrectionLevel = 1 else self.HDRCorrectionLevel = mat:GetFloat("$cubemapHDRMul") end
			else
				self.HDRCorrectionLevel = mat:GetFloat("$cubemapHDRMulfallback")
			end
			if mat:GetFloat("cubemapLDRMulfallback") == nil then
				if mat:GetFloat("$cubemapLDRMul") == nil then self.LDRCorrectionLevel = 1 else self.LDRCorrectionLevel = mat:GetFloat("$cubemapLDRMul") end
			else
				self.LDRCorrectionLevel = mat:GetFloat("$cubemapLDRMulfallback")
			end
		end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		if ent.Preview == true then
			local mul = Vector(1, 1, 1)
			if HDR then mul = self.HDRCorrectionLevel else mul = (10 * self.LDRCorrectionLevel) end
			mat:SetVector( self.ResultTo, (self.TintVector * self.PowerFloat * (LocalPlayer():GetNWVector("PlayerColour_DRC")) * mul) * DRC.MapInfo.MapAmbientAvg * DRC.WeathermodScalar )
		return end
		
		local pcr_hands, pcg_hands, pcb_hands, lightlevel_hands = 0, 0, 0, Vector(0, 0, 0)
		local pcr_ragdoll, pcg_ragdoll, pcb_ragdoll, lightlevel_ragdoll = 0, 0, 0, Vector(0, 0, 0)
		local pcr, pcg, pcb, lightlevel = 0, 0, 0, Vector(0, 0, 0)
		if ent:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			pcr_hands = math.Clamp(LocalPlayer():GetNWVector("PlayerColour_DRC").x, self.MinFloat, self.MaxFloat)
			pcg_hands = math.Clamp(LocalPlayer():GetNWVector("PlayerColour_DRC").y, self.MinFloat, self.MaxFloat)
			pcb_hands = math.Clamp(LocalPlayer():GetNWVector("PlayerColour_DRC").z, self.MinFloat, self.MaxFloat)
			
			lightlevel_hands = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr_hands, pcg_hands, pcb_hands)
			local col = Vector(0, 0, 0)
			if HDR then col = pcmath * Vector(lightlevel_hands.r, lightlevel_hands.g, lightlevel_hands.b) * self.HDRCorrectionLevel
			else col = pcmath * Vector(lightlevel_hands.r, lightlevel_hands.g, lightlevel_hands.b) * (10 * self.LDRCorrectionLevel) end
			if ( !isvector( col )) then return end
				
			self.drc_reflectiontintlerp_pc_hands = Lerp(RealFrameTime() * (self.LerpPower * 2.5), self.drc_reflectiontintlerp_pc_hands or col, col)
			local interp = self.drc_reflectiontintlerp_pc_hands
			
			local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		elseif ent:IsRagdoll() then
			pcr_ragdoll = math.Clamp(ent:GetNWVector("PlayerColour_DRC").x, self.MinFloat, self.MaxFloat)
			pcg_ragdoll = math.Clamp(ent:GetNWVector("PlayerColour_DRC").y, self.MinFloat, self.MaxFloat)
			pcb_ragdoll = math.Clamp(ent:GetNWVector("PlayerColour_DRC").z, self.MinFloat, self.MaxFloat)
			
			lightlevel_ragdoll = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr_ragdoll, pcg_ragdoll, pcb_ragdoll)
			local col = Vector(0, 0, 0)
			if HDR then col = pcmath * Vector(lightlevel_ragdoll.r, lightlevel_ragdoll.g, lightlevel_ragdoll.b) * self.HDRCorrectionLevel
			else col = pcmath * Vector(lightlevel_ragdoll.r, lightlevel_ragdoll.g, lightlevel_ragdoll.b) * (10 * self.LDRCorrectionLevel) end
			if ( !isvector( col )) then return end
				
			ent.drc_reflectiontintlerp_pc_ragdoll = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_pc_ragdoll or col, col)
			local interp = ent.drc_reflectiontintlerp_pc_ragdoll
			
			local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		elseif ent:EntIndex() == LocalPlayer():GetViewModel():EntIndex() then
			ent = LocalPlayer():GetActiveWeapon()
			pcr = math.Clamp(ent:GetNWVector("PlayerColour_DRC").x, self.MinFloat, self.MaxFloat)
			pcg = math.Clamp(ent:GetNWVector("PlayerColour_DRC").y, self.MinFloat, self.MaxFloat)
			pcb = math.Clamp(ent:GetNWVector("PlayerColour_DRC").z, self.MinFloat, self.MaxFloat)
			
			lightlevel = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr, pcg, pcb)
			local col = Vector(lightlevel.r, lightlevel.g, lightlevel.b)
			if ( !isvector( col )) then return end
			col = col * pcmath
			
			ent.drc_reflectiontintlerp_wpn = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_wpn or col, col)
			local interp = ent.drc_reflectiontintlerp_wpn
			
			local mul = Vector(1, 1, 1)
			if HDR then mul = interp * self.HDRCorrectionLevel else mul = interp * (10 * self.LDRCorrectionLevel) end
			
			local finalx = math.Clamp(mul.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(mul.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(mul.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		else
			pcr = math.Clamp(ent:GetNWVector("PlayerColour_DRC").x, self.MinFloat, self.MaxFloat)
			pcg = math.Clamp(ent:GetNWVector("PlayerColour_DRC").y, self.MinFloat, self.MaxFloat)
			pcb = math.Clamp(ent:GetNWVector("PlayerColour_DRC").z, self.MinFloat, self.MaxFloat)
			
			if ent:GetNWVector("PlayerColour_DRC") == Vector(0, 0, 0) then
				local vec = Vector(LocalPlayer():GetInfo("cl_playercolor"))
				pcr = vec.x
				pcg = vec.y
				pcb = vec.z
			end
			
			lightlevel = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr, pcg, pcb)			
			local col = Vector(lightlevel.r, lightlevel.g, lightlevel.b)
			if ( !isvector( col )) then return end
			col = col * pcmath
				
			ent.drc_reflectiontintlerp_pc = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_pc or col, col)
			local interp = ent.drc_reflectiontintlerp_pc
			
			local mul = Vector(1, 1, 1)
			if HDR then mul = interp * self.HDRCorrectionLevel else mul = interp * (10 * self.LDRCorrectionLevel) end
			
			local finalx = math.Clamp(mul.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(mul.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(mul.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor
			
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		end
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
		
		if #drc_cubesamples != 0 then
			self.TintVector = mat:GetVector("$cubemaptint")
			self.PowerFloat = mat:GetFloat("$cubemappower")
			self.MinFloat	= mat:GetFloat("$cubemapmin")
			self.MaxFloat	= mat:GetFloat("$cubemapmax")
			self.HDRCorrectionLevel	= mat:GetFloat("$cubemapHDRMul")
			self.LDRCorrectionLevel	= mat:GetFloat("$cubemapLDRMul")
			
			if self.TintVector == nil then self.TintVector = Vector(1,1,1) end
			if self.PowerFloat == nil then self.PowerFloat = 1 end
			if self.MinFloat == nil then self.MinFloat = 0 end
			if self.MaxFloat == nil then self.MaxFloat = 1 end
			if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
			if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		else
			if mat:GetVector("cubemaptintfallback") == nil then
				if mat:GetVector("$cubemaptint") == nil then self.TintVector = Vector(1,1,1) else self.TintVector = mat:GetVector("$cubemaptint") end
			else
				self.TintVector = mat:GetVector("$cubemaptintfallback")
			end
			if mat:GetFloat("cubemappowerfallback") == nil then
				if mat:GetFloat("$cubemappower") == nil then self.PowerFloat = 1 else self.PowerFloat = mat:GetFloat("$cubemappower") end
			else
				self.PowerFloat = mat:GetFloat("$cubemappowerfallback")
			end
			if mat:GetFloat("cubemapminfallback") == nil then
				if mat:GetFloat("$cubemapmin") == nil then self.MinFloat = 0 else self.MinFloat = mat:GetFloat("$cubemapmin") end
			else
				self.MinFloat = mat:GetFloat("$cubemapminfallback")
			end
			if mat:GetFloat("cubemapmaxfallback") == nil then
				if mat:GetFloat("$cubemapmax") == nil then self.MaxFloat = 1 else self.MaxFloat = mat:GetFloat("$cubemapmax") end
			else
				self.MaxFloat = mat:GetFloat("$cubemapmaxfallback")
			end
			if mat:GetFloat("cubemapHDRMulfallback") == nil then
				if mat:GetFloat("$cubemapHDRMul") == nil then self.HDRCorrectionLevel = 1 else self.HDRCorrectionLevel = mat:GetFloat("$cubemapHDRMul") end
			else
				self.HDRCorrectionLevel = mat:GetFloat("$cubemapHDRMulfallback")
			end
			if mat:GetFloat("cubemapLDRMulfallback") == nil then
				if mat:GetFloat("$cubemapLDRMul") == nil then self.LDRCorrectionLevel = 1 else self.LDRCorrectionLevel = mat:GetFloat("$cubemapLDRMul") end
			else
				self.LDRCorrectionLevel = mat:GetFloat("$cubemapLDRMulfallback")
			end
		end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		if ent.Preview == true then
			local mul = Vector(1, 1, 1)
			if HDR then mul = self.HDRCorrectionLevel else mul = (10 * self.LDRCorrectionLevel) end
			mat:SetVector( self.ResultTo, (self.TintVector * self.PowerFloat * (LocalPlayer():GetNWVector("EyeTintVec") / 255) * mul) * DRC.MapInfo.MapAmbientAvg * DRC.WeathermodScalar )
		return end
		
		if self.TintVector == nil then self.TintVector = Vector(1, 1, 1) end
		if self.PowerFloat == nil then self.PowerFloat = 1 end
		if self.MinFloat == nil then self.MinFloat = 0 end
		if self.MaxFloat == nil then self.MaxFloat = 1 end
		if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
		if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		local pcr_hands, pcg_hands, pcb_hands, lightlevel_hands = 0, 0, 0, Vector(0, 0, 0)
		local pcr_ragdoll, pcg_ragdoll, pcb_ragdoll, lightlevel_ragdoll = 0, 0, 0, Vector(0, 0, 0)
		local pcr, pcg, pcb, lightlevel = 0, 0, 0, Vector(0, 0, 0)
		if ent:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			pcr_hands = math.Clamp(math.Clamp(ent:GetNWVector("EyeTintVec").x, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			pcg_hands = math.Clamp(math.Clamp(ent:GetNWVector("EyeTintVec").y, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			pcb_hands = math.Clamp(math.Clamp(ent:GetNWVector("EyeTintVec").z, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			
			lightlevel_hands = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr_hands, pcg_hands, pcb_hands)
			local col = Vector(0, 0, 0)
			if HDR then col = pcmath * Vector(lightlevel_hands.r, lightlevel_hands.g, lightlevel_hands.b) * self.HDRCorrectionLevel
			else col = pcmath * Vector(lightlevel_hands.r, lightlevel_hands.g, lightlevel_hands.b) * (10 * self.LDRCorrectionLevel) end
			if ( !isvector( col )) then return end
				
			ent.drc_reflectiontintlerp_eye_hands = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_eye_hands or col, col)
			local interp = ent.drc_reflectiontintlerp_eye_hands
			
			local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		elseif ent:IsRagdoll() then
			pcr_ragdoll = math.Clamp(math.Clamp(ent:GetNWVector("EyeTintVec").x, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			pcg_ragdoll = math.Clamp(math.Clamp(ent:GetNWVector("EyeTintVec").y, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			pcb_ragdoll = math.Clamp(math.Clamp(ent:GetNWVector("EyeTintVec").z, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			
			lightlevel_ragdoll = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr_ragdoll, pcg_ragdoll, pcb_ragdoll)
			local col = Vector(0, 0, 0)
			if HDR then col = pcmath * Vector(lightlevel_ragdoll.r, lightlevel_ragdoll.g, lightlevel_ragdoll.b) * self.HDRCorrectionLevel
			else col = pcmath * Vector(lightlevel_ragdoll.r, lightlevel_ragdoll.g, lightlevel_ragdoll.b) * (10 * self.LDRCorrectionLevel) end
			if ( !isvector( col )) then return end
				
			ent.drc_reflectiontintlerp_eye_ragdoll = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_eye_ragdoll or col, col)
			local interp = ent.drc_reflectiontintlerp_eye_ragdoll
			
			local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		elseif ent:EntIndex() == LocalPlayer():GetViewModel():EntIndex() then
			ent = LocalPlayer():GetActiveWeapon()
			pcr = math.Clamp(ent:GetNWVector("EyeTintVec").x / 255, self.MinFloat, self.MaxFloat)
			pcg = math.Clamp(ent:GetNWVector("EyeTintVec").y / 255, self.MinFloat, self.MaxFloat)
			pcb = math.Clamp(ent:GetNWVector("EyeTintVec").z / 255, self.MinFloat, self.MaxFloat)
			
			lightlevel = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr, pcg, pcb)
			local col = Vector(lightlevel.r, lightlevel.g, lightlevel.b)
			if ( !isvector( col )) then return end
			col = col * pcmath
			
			ent.drc_reflectiontintlerp_wpn = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_wpn or col, col)
			local interp = ent.drc_reflectiontintlerp_wpn
			
			local mul = Vector(1, 1, 1)
			if HDR then mul = interp * self.HDRCorrectionLevel else mul = interp * (10 * self.LDRCorrectionLevel) end
			
			local finalx = math.Clamp(mul.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(mul.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(mul.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		else
			pcr = math.Clamp(math.Clamp(ent:GetNWVector("EyeTintVec").x, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			pcg = math.Clamp(math.Clamp(ent:GetNWVector("EyeTintVec").y, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			pcb = math.Clamp(math.Clamp(ent:GetNWVector("EyeTintVec").z, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			
			lightlevel = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr, pcg, pcb)
			local col = Vector(lightlevel.r, lightlevel.g, lightlevel.b)
			if ( !isvector( col )) then return end
			col = col * pcmath
				
			ent.drc_reflectiontintlerp_eye = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_eye or col, col)
			local interp = ent.drc_reflectiontintlerp_eye
			
			local mul = Vector(1, 1, 1)
			if HDR then mul = interp * self.HDRCorrectionLevel else mul = interp * (10 * self.LDRCorrectionLevel) end
			
			local finalx = math.Clamp(mul.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(mul.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(mul.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		end
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
		
		if #drc_cubesamples != 0 then
			self.TintVector = mat:GetVector("$cubemaptint")
			self.PowerFloat = mat:GetFloat("$cubemappower")
			self.MinFloat	= mat:GetFloat("$cubemapmin")
			self.MaxFloat	= mat:GetFloat("$cubemapmax")
			self.HDRCorrectionLevel	= mat:GetFloat("$cubemapHDRMul")
			self.LDRCorrectionLevel	= mat:GetFloat("$cubemapLDRMul")
			
			if self.TintVector == nil then self.TintVector = Vector(1,1,1) end
			if self.PowerFloat == nil then self.PowerFloat = 1 end
			if self.MinFloat == nil then self.MinFloat = 0 end
			if self.MaxFloat == nil then self.MaxFloat = 1 end
			if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
			if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		else
			if mat:GetVector("cubemaptintfallback") == nil then
				if mat:GetVector("$cubemaptint") == nil then self.TintVector = Vector(1,1,1) else self.TintVector = mat:GetVector("$cubemaptint") end
			else
				self.TintVector = mat:GetVector("$cubemaptintfallback")
			end
			if mat:GetFloat("cubemappowerfallback") == nil then
				if mat:GetFloat("$cubemappower") == nil then self.PowerFloat = 1 else self.PowerFloat = mat:GetFloat("$cubemappower") end
			else
				self.PowerFloat = mat:GetFloat("$cubemappowerfallback")
			end
			if mat:GetFloat("cubemapminfallback") == nil then
				if mat:GetFloat("$cubemapmin") == nil then self.MinFloat = 0 else self.MinFloat = mat:GetFloat("$cubemapmin") end
			else
				self.MinFloat = mat:GetFloat("$cubemapminfallback")
			end
			if mat:GetFloat("cubemapmaxfallback") == nil then
				if mat:GetFloat("$cubemapmax") == nil then self.MaxFloat = 1 else self.MaxFloat = mat:GetFloat("$cubemapmax") end
			else
				self.MaxFloat = mat:GetFloat("$cubemapmaxfallback")
			end
			if mat:GetFloat("cubemapHDRMulfallback") == nil then
				if mat:GetFloat("$cubemapHDRMul") == nil then self.HDRCorrectionLevel = 1 else self.HDRCorrectionLevel = mat:GetFloat("$cubemapHDRMul") end
			else
				self.HDRCorrectionLevel = mat:GetFloat("$cubemapHDRMulfallback")
			end
			if mat:GetFloat("cubemapLDRMulfallback") == nil then
				if mat:GetFloat("$cubemapLDRMul") == nil then self.LDRCorrectionLevel = 1 else self.LDRCorrectionLevel = mat:GetFloat("$cubemapLDRMul") end
			else
				self.LDRCorrectionLevel = mat:GetFloat("$cubemapLDRMulfallback")
			end
		end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		if ent.Preview == true then
			local mul = Vector(1, 1, 1)
			if HDR then mul = self.HDRCorrectionLevel else mul = (10 * self.LDRCorrectionLevel) end
			mat:SetVector( self.ResultTo, (self.TintVector * self.PowerFloat * (LocalPlayer():GetNWVector("ColourTintVec1") / 255) * mul) * DRC.MapInfo.MapAmbientAvg * DRC.WeathermodScalar )
		return end
		
		if self.TintVector == nil then self.TintVector = Vector(1, 1, 1) end
		if self.PowerFloat == nil then self.PowerFloat = 1 end
		if self.MinFloat == nil then self.MinFloat = 0 end
		if self.MaxFloat == nil then self.MaxFloat = 1 end
		if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
		if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		local pcr_hands, pcg_hands, pcb_hands, lightlevel_hands = 0, 0, 0, Vector(0, 0, 0)
		local pcr_ragdoll, pcg_ragdoll, pcb_ragdoll, lightlevel_ragdoll = 0, 0, 0, Vector(0, 0, 0)
		local pcr, pcg, pcb, lightlevel = 0, 0, 0, Vector(0, 0, 0)
		if ent:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			pcr_hands = math.Clamp(math.Clamp(ent:GetNWVector("ColourTintVec1").x, 1, 255), self.MinFloat, self.MaxFloat)
			pcg_hands = math.Clamp(math.Clamp(ent:GetNWVector("ColourTintVec1").y, 1, 255), self.MinFloat, self.MaxFloat)
			pcb_hands = math.Clamp(math.Clamp(ent:GetNWVector("ColourTintVec1").z, 1, 255), self.MinFloat, self.MaxFloat)
			
			lightlevel_hands = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr_hands, pcg_hands, pcb_hands)
			local col = Vector(0, 0, 0)
			if HDR then col = pcmath * Vector(lightlevel_hands.r, lightlevel_hands.g, lightlevel_hands.b) * self.HDRCorrectionLevel
			else col = pcmath * Vector(lightlevel_hands.r, lightlevel_hands.g, lightlevel_hands.b) * (10 * self.LDRCorrectionLevel) end
			if ( !isvector( col )) then return end
				
			ent.drc_reflectiontintlerp_tint1_hands = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_tint1_hands or col, col)
			local interp = ent.drc_reflectiontintlerp_tint1_hands
			
			local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		elseif ent:IsRagdoll() then
			pcr_ragdoll = math.Clamp(math.Clamp(ent:GetNWVector("ColourTintVec1").x, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			pcg_ragdoll = math.Clamp(math.Clamp(ent:GetNWVector("ColourTintVec1").y, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			pcb_ragdoll = math.Clamp(math.Clamp(ent:GetNWVector("ColourTintVec1").z, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			
			lightlevel_ragdoll = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr_ragdoll, pcg_ragdoll, pcb_ragdoll)
			local col = Vector(0, 0, 0)
			if HDR then col = pcmath * Vector(lightlevel_ragdoll.r, lightlevel_ragdoll.g, lightlevel_ragdoll.b) * self.HDRCorrectionLevel
			else col = pcmath * Vector(lightlevel_ragdoll.r, lightlevel_ragdoll.g, lightlevel_ragdoll.b) * (10 * self.LDRCorrectionLevel) end
			if ( !isvector( col )) then return end
				
			ent.drc_reflectiontintlerp_tint1_ragdoll = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_tint1_ragdoll or col, col)
			local interp = ent.drc_reflectiontintlerp_tint1_ragdoll
			
			local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		elseif ent:EntIndex() == LocalPlayer():GetViewModel():EntIndex() then
			ent = LocalPlayer():GetActiveWeapon()
			pcr = math.Clamp(ent:GetNWVector("ColourTintVec1").x / 255, self.MinFloat, self.MaxFloat)
			pcg = math.Clamp(ent:GetNWVector("ColourTintVec1").y / 255, self.MinFloat, self.MaxFloat)
			pcb = math.Clamp(ent:GetNWVector("ColourTintVec1").z / 255, self.MinFloat, self.MaxFloat)
			
			lightlevel = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr, pcg, pcb)
			local col = Vector(lightlevel.r, lightlevel.g, lightlevel.b)
			if ( !isvector( col )) then return end
			col = col * pcmath
			
			ent.drc_reflectiontintlerp_wpn = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_wpn or col, col)
			local interp = ent.drc_reflectiontintlerp_wpn
			
			local mul = Vector(1, 1, 1)
			if HDR then mul = interp * self.HDRCorrectionLevel else mul = interp * (10 * self.LDRCorrectionLevel) end
			
			local finalx = math.Clamp(mul.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(mul.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(mul.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		else
			pcr = math.Clamp(math.Clamp(ent:GetNWVector("ColourTintVec1").x, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			pcg = math.Clamp(math.Clamp(ent:GetNWVector("ColourTintVec1").y, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			pcb = math.Clamp(math.Clamp(ent:GetNWVector("ColourTintVec1").z, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			
			lightlevel = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr, pcg, pcb)			
			local col = Vector(lightlevel.r, lightlevel.g, lightlevel.b)
			if ( !isvector( col )) then return end
			col = col * pcmath
				
			ent.drc_reflectiontintlerp_tint1 = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_tint1 or col, col)
			local interp = ent.drc_reflectiontintlerp_tint1
			
			local mul = Vector(1, 1, 1)
			if HDR then mul = interp * self.HDRCorrectionLevel else mul = interp * (10 * self.LDRCorrectionLevel) end
			
			local finalx = math.Clamp(mul.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(mul.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(mul.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		end
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
		
		if #drc_cubesamples != 0 then
			self.TintVector = mat:GetVector("$cubemaptint")
			self.PowerFloat = mat:GetFloat("$cubemappower")
			self.MinFloat	= mat:GetFloat("$cubemapmin")
			self.MaxFloat	= mat:GetFloat("$cubemapmax")
			self.HDRCorrectionLevel	= mat:GetFloat("$cubemapHDRMul")
			self.LDRCorrectionLevel	= mat:GetFloat("$cubemapLDRMul")
			
			if self.TintVector == nil then self.TintVector = Vector(1,1,1) end
			if self.PowerFloat == nil then self.PowerFloat = 1 end
			if self.MinFloat == nil then self.MinFloat = 0 end
			if self.MaxFloat == nil then self.MaxFloat = 1 end
			if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
			if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		else
			if mat:GetVector("cubemaptintfallback") == nil then
				if mat:GetVector("$cubemaptint") == nil then self.TintVector = Vector(1,1,1) else self.TintVector = mat:GetVector("$cubemaptint") end
			else
				self.TintVector = mat:GetVector("$cubemaptintfallback")
			end
			if mat:GetFloat("cubemappowerfallback") == nil then
				if mat:GetFloat("$cubemappower") == nil then self.PowerFloat = 1 else self.PowerFloat = mat:GetFloat("$cubemappower") end
			else
				self.PowerFloat = mat:GetFloat("$cubemappowerfallback")
			end
			if mat:GetFloat("cubemapminfallback") == nil then
				if mat:GetFloat("$cubemapmin") == nil then self.MinFloat = 0 else self.MinFloat = mat:GetFloat("$cubemapmin") end
			else
				self.MinFloat = mat:GetFloat("$cubemapminfallback")
			end
			if mat:GetFloat("cubemapmaxfallback") == nil then
				if mat:GetFloat("$cubemapmax") == nil then self.MaxFloat = 1 else self.MaxFloat = mat:GetFloat("$cubemapmax") end
			else
				self.MaxFloat = mat:GetFloat("$cubemapmaxfallback")
			end
			if mat:GetFloat("cubemapHDRMulfallback") == nil then
				if mat:GetFloat("$cubemapHDRMul") == nil then self.HDRCorrectionLevel = 1 else self.HDRCorrectionLevel = mat:GetFloat("$cubemapHDRMul") end
			else
				self.HDRCorrectionLevel = mat:GetFloat("$cubemapHDRMulfallback")
			end
			if mat:GetFloat("cubemapLDRMulfallback") == nil then
				if mat:GetFloat("$cubemapLDRMul") == nil then self.LDRCorrectionLevel = 1 else self.LDRCorrectionLevel = mat:GetFloat("$cubemapLDRMul") end
			else
				self.LDRCorrectionLevel = mat:GetFloat("$cubemapLDRMulfallback")
			end
		end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		if ent.Preview == true then
			local mul = Vector(1, 1, 1)
			if HDR then mul = self.HDRCorrectionLevel else mul = (10 * self.LDRCorrectionLevel) end
			mat:SetVector( self.ResultTo, (self.TintVector * self.PowerFloat * (LocalPlayer():GetNWVector("ColourTintVec2") / 255) * mul) * DRC.MapInfo.MapAmbientAvg * DRC.WeathermodScalar )
		return end
		
		if self.TintVector == nil then self.TintVector = Vector(1, 1, 1) end
		if self.PowerFloat == nil then self.PowerFloat = 1 end
		if self.MinFloat == nil then self.MinFloat = 0 end
		if self.MaxFloat == nil then self.MaxFloat = 1 end
		if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
		if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		local pcr_hands, pcg_hands, pcb_hands, lightlevel_hands = 0, 0, 0, Vector(0, 0, 0)
		local pcr_ragdoll, pcg_ragdoll, pcb_ragdoll, lightlevel_ragdoll = 0, 0, 0, Vector(0, 0, 0)
		local pcr, pcg, pcb, lightlevel = 0, 0, 0, Vector(0, 0, 0)
		if ent:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			pcr_hands = math.Clamp(math.Clamp(ent:GetNWVector("ColourTintVec2").x, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			pcb_hands = math.Clamp(math.Clamp(ent:GetNWVector("ColourTintVec2").z, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			pcg_hands = math.Clamp(math.Clamp(ent:GetNWVector("ColourTintVec2").y, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			
			lightlevel_hands = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr_hands, pcg_hands, pcb_hands)
			local col = Vector(0, 0, 0)
			if HDR then col = pcmath * Vector(lightlevel_hands.r, lightlevel_hands.g, lightlevel_hands.b) * self.HDRCorrectionLevel
			else col = pcmath * Vector(lightlevel_hands.r, lightlevel_hands.g, lightlevel_hands.b) * (10 * self.LDRCorrectionLevel) end
			if ( !isvector( col )) then return end
				
			ent.drc_reflectiontintlerp_tint2_hands = Lerp(RealFrameTime() + (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_tint2_hands or col, col)
			local interp = ent.drc_reflectiontintlerp_tint2_hands
			
			local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		elseif ent:IsRagdoll() then
			pcr_ragdoll = math.Clamp(math.Clamp(ent:GetNWVector("ColourTintVec2").x, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			pcg_ragdoll = math.Clamp(math.Clamp(ent:GetNWVector("ColourTintVec2").y, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			pcb_ragdoll = math.Clamp(math.Clamp(ent:GetNWVector("ColourTintVec2").z, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			
			lightlevel_ragdoll = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr_ragdoll, pcg_ragdoll, pcb_ragdoll)
			local col = Vector(0, 0, 0)
			if HDR then col = pcmath * Vector(lightlevel_ragdoll.r, lightlevel_ragdoll.g, lightlevel_ragdoll.b) * self.HDRCorrectionLevel
			else col = pcmath * Vector(lightlevel_ragdoll.r, lightlevel_ragdoll.g, lightlevel_ragdoll.b) * (10 * self.LDRCorrectionLevel) end
			if ( !isvector( col )) then return end
				
			ent.drc_reflectiontintlerp_tint2_ragdoll = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_tint2_ragdoll or col, col)
			local interp = ent.drc_reflectiontintlerp_tint2_ragdoll
			
			local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		elseif ent:EntIndex() == LocalPlayer():GetViewModel():EntIndex() then
			ent = LocalPlayer():GetActiveWeapon()
			pcr = math.Clamp(ent:GetNWVector("ColourTintVec2").x / 255, self.MinFloat, self.MaxFloat)
			pcg = math.Clamp(ent:GetNWVector("ColourTintVec2").y / 255, self.MinFloat, self.MaxFloat)
			pcb = math.Clamp(ent:GetNWVector("ColourTintVec2").z / 255, self.MinFloat, self.MaxFloat)
			
			lightlevel = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr, pcg, pcb)
			local col = Vector(lightlevel.r, lightlevel.g, lightlevel.b)
			if ( !isvector( col )) then return end
			col = col * pcmath
			
			ent.drc_reflectiontintlerp_wpn = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_wpn or col, col)
			local interp = ent.drc_reflectiontintlerp_wpn
			
			local mul = Vector(1, 1, 1)
			if HDR then mul = interp * self.HDRCorrectionLevel else mul = interp * (10 * self.LDRCorrectionLevel) end
			
			local finalx = math.Clamp(mul.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(mul.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(mul.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		else
			pcr = math.Clamp(math.Clamp(ent:GetNWVector("ColourTintVec2").x, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			pcg = math.Clamp(math.Clamp(ent:GetNWVector("ColourTintVec2").y, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			pcb = math.Clamp(math.Clamp(ent:GetNWVector("ColourTintVec2").z, 1, 255) / 255, self.MinFloat, self.MaxFloat)
			
			lightlevel = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr, pcg, pcb)
			
			local col = Vector(lightlevel.r, lightlevel.g, lightlevel.b)
			if ( !isvector( col )) then return end
			col = col * pcmath
				
			ent.drc_reflectiontintlerp_tint2 = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_tint2 or col, col)
			local interp = ent.drc_reflectiontintlerp_tint2
			
			local mul = Vector(1, 1, 1)
			if HDR then mul = interp * self.HDRCorrectionLevel else mul = interp * (10 * self.LDRCorrectionLevel) end
			
			local finalx = math.Clamp(mul.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(mul.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(mul.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		end
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
		
		if #drc_cubesamples != 0 then
			self.TintVector = mat:GetVector("$cubemaptint")
			self.PowerFloat = mat:GetFloat("$cubemappower")
			self.MinFloat	= mat:GetFloat("$cubemapmin")
			self.MaxFloat	= mat:GetFloat("$cubemapmax")
			self.HDRCorrectionLevel	= mat:GetFloat("$cubemapHDRMul")
			self.LDRCorrectionLevel	= mat:GetFloat("$cubemapLDRMul")
			
			if self.TintVector == nil then self.TintVector = Vector(1,1,1) end
			if self.PowerFloat == nil then self.PowerFloat = 1 end
			if self.MinFloat == nil then self.MinFloat = 0 end
			if self.MaxFloat == nil then self.MaxFloat = 1 end
			if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
			if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		else
			if mat:GetVector("cubemaptintfallback") == nil then
				if mat:GetVector("$cubemaptint") == nil then self.TintVector = Vector(1,1,1) else self.TintVector = mat:GetVector("$cubemaptint") end
			else
				self.TintVector = mat:GetVector("$cubemaptintfallback")
			end
			if mat:GetFloat("cubemappowerfallback") == nil then
				if mat:GetFloat("$cubemappower") == nil then self.PowerFloat = 1 else self.PowerFloat = mat:GetFloat("$cubemappower") end
			else
				self.PowerFloat = mat:GetFloat("$cubemappowerfallback")
			end
			if mat:GetFloat("cubemapminfallback") == nil then
				if mat:GetFloat("$cubemapmin") == nil then self.MinFloat = 0 else self.MinFloat = mat:GetFloat("$cubemapmin") end
			else
				self.MinFloat = mat:GetFloat("$cubemapminfallback")
			end
			if mat:GetFloat("cubemapmaxfallback") == nil then
				if mat:GetFloat("$cubemapmax") == nil then self.MaxFloat = 1 else self.MaxFloat = mat:GetFloat("$cubemapmax") end
			else
				self.MaxFloat = mat:GetFloat("$cubemapmaxfallback")
			end
			if mat:GetFloat("cubemapHDRMulfallback") == nil then
				if mat:GetFloat("$cubemapHDRMul") == nil then self.HDRCorrectionLevel = 1 else self.HDRCorrectionLevel = mat:GetFloat("$cubemapHDRMul") end
			else
				self.HDRCorrectionLevel = mat:GetFloat("$cubemapHDRMulfallback")
			end
			if mat:GetFloat("cubemapLDRMulfallback") == nil then
				if mat:GetFloat("$cubemapLDRMul") == nil then self.LDRCorrectionLevel = 1 else self.LDRCorrectionLevel = mat:GetFloat("$cubemapLDRMul") end
			else
				self.LDRCorrectionLevel = mat:GetFloat("$cubemapLDRMulfallback")
			end
		end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		if self.TintVector == nil then self.TintVector = Vector(1, 1, 1) end
		if self.PowerFloat == nil then self.PowerFloat = 1 end
		if self.MinFloat == nil then self.MinFloat = 0 end
		if self.MaxFloat == nil then self.MaxFloat = 1 end
		if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
		if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		local pcr_hands, pcg_hands, pcb_hands, lightlevel_hands = 0, 0, 0, Vector(0, 0, 0)
		local pcr_ragdoll, pcg_ragdoll, pcb_ragdoll, lightlevel_ragdoll = 0, 0, 0, Vector(0, 0, 0)
		local pcr, pcg, pcb, lightlevel = 0, 0, 0, Vector(0, 0, 0)
		if ent:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			pcr_hands = math.Clamp(LocalPlayer():GetNWVector("WeaponColour_DRC").x, self.MinFloat, self.MaxFloat)
			pcg_hands = math.Clamp(LocalPlayer():GetNWVector("WeaponColour_DRC").y, self.MinFloat, self.MaxFloat)
			pcb_hands = math.Clamp(LocalPlayer():GetNWVector("WeaponColour_DRC").z, self.MinFloat, self.MaxFloat)
			
			lightlevel_hands = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr_hands, pcg_hands, pcb_hands)
			local col = Vector(0, 0, 0)
			if HDR then col = pcmath * Vector(lightlevel_hands.r, lightlevel_hands.g, lightlevel_hands.b) * self.HDRCorrectionLevel
			else col = pcmath * Vector(lightlevel_hands.r, lightlevel_hands.g, lightlevel_hands.b) * (10 * self.LDRCorrectionLevel) end
			if ( !isvector( col )) then return end
				
			ent.drc_reflectiontintlerp_wpn_hands = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_wpn_hands or col, col)
			local interp = ent.drc_reflectiontintlerp_wpn_hands
			
			local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
				
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		elseif ent:IsRagdoll() then
			pcr_ragdoll = math.Clamp(ent:GetNWVector("WeaponColour_DRC").x / 255, self.MinFloat, self.MaxFloat)
			pcg_ragdoll = math.Clamp(ent:GetNWVector("WeaponColour_DRC").y / 255, self.MinFloat, self.MaxFloat)
			pcb_ragdoll = math.Clamp(ent:GetNWVector("WeaponColour_DRC").z / 255, self.MinFloat, self.MaxFloat)
			
			lightlevel_ragdoll = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr_ragdoll, pcg_ragdoll, pcb_ragdoll)
			local col = Vector(0, 0, 0)
			if HDR then col = pcmath * Vector(lightlevel_ragdoll.r, lightlevel_ragdoll.g, lightlevel_ragdoll.b) * self.HDRCorrectionLevel
			else col = pcmath * Vector(lightlevel_ragdoll.r, lightlevel_ragdoll.g, lightlevel_ragdoll.b) * (10 * self.LDRCorrectionLevel) end
			if ( !isvector( col )) then return end
				
			ent.drc_reflectiontintlerp_wpn_ragdoll = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_wpn_ragdoll or col, col)
			local interp = ent.drc_reflectiontintlerp_wpn_ragdoll
			
			local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
				
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		elseif ent:EntIndex() == LocalPlayer():GetViewModel():EntIndex() then
			ent = LocalPlayer():GetActiveWeapon()
			pcr = math.Clamp(DRC:GetColours(ent).Weapon.x, self.MinFloat, self.MaxFloat)
			pcg = math.Clamp(DRC:GetColours(ent).Weapon.y, self.MinFloat, self.MaxFloat)
			pcb = math.Clamp(DRC:GetColours(ent).Weapon.z, self.MinFloat, self.MaxFloat)
--			pcr = math.Clamp(ent:GetNWVector("WeaponColour_DRC").x, self.MinFloat, self.MaxFloat)
--			pcg = math.Clamp(ent:GetNWVector("WeaponColour_DRC").y, self.MinFloat, self.MaxFloat)
--			pcb = math.Clamp(ent:GetNWVector("WeaponColour_DRC").z, self.MinFloat, self.MaxFloat)
			
			lightlevel = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr, pcg, pcb)
			local col = Vector(lightlevel.r, lightlevel.g, lightlevel.b)
			if ( !isvector( col )) then return end
			col = col * pcmath
			
			ent.drc_reflectiontintlerp_wpn = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_wpn or col, col)
			local interp = ent.drc_reflectiontintlerp_wpn
			
			local mul = Vector(1, 1, 1)
			if HDR then mul = interp * self.HDRCorrectionLevel else mul = interp * (10 * self.LDRCorrectionLevel) end
			
			local finalx = math.Clamp(mul.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(mul.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(mul.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		else
			pcr = math.Clamp(ent:GetNWVector("WeaponColour_DRC").x, self.MinFloat, self.MaxFloat)
			pcg = math.Clamp(ent:GetNWVector("WeaponColour_DRC").y, self.MinFloat, self.MaxFloat)
			pcb = math.Clamp(ent:GetNWVector("WeaponColour_DRC").z, self.MinFloat, self.MaxFloat)
			
			lightlevel = render.GetLightColor(ent:GetPos())
			
			local pcmath = Vector(pcr, pcg, pcb)			
			local col = Vector(lightlevel.r, lightlevel.g, lightlevel.b)
			if ( !isvector( col )) then return end
			col = col * pcmath
			
			ent.drc_reflectiontintlerp_wpn = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_reflectiontintlerp_wpn or col, col)
			local interp = ent.drc_reflectiontintlerp_wpn
			
			local mul = Vector(1, 1, 1)
			if HDR then mul = interp * self.HDRCorrectionLevel else mul = interp * (10 * self.LDRCorrectionLevel) end
			
			local finalx = math.Clamp(mul.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(mul.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(mul.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCor * DRC.WeathermodScalar
			
			local val = ((final * DRC.WeathermodScalar) * self.TintVector) * self.PowerFloat
			mat:SetVector( self.ResultTo, val )
		end
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
		
		if owner:IsPlayer() then
			local ply = owner
			local hp = ply:Health()
			local maxhp = ply:GetMaxHealth()
			
			local hpmath = (hp / maxhp)
			self.drc_scrollhplerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), self.drc_scrollhplerp or hpmath, hpmath)
			local col = Lerp(self.drc_scrollhplerp, self.MinVec, self.MaxVec)
			
			local interp = self.drc_scrollhplerp
			mat:SetVector( self.ResultTo, col )
		elseif owner:IsWeapon() then
			local ply = owner:GetOwner()
			local hp = ply:Health()
			local maxhp = ply:GetMaxHealth()
			
			local hpmath = (hp / maxhp)
			self.drc_scrollhplerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), self.drc_scrollhplerp or hpmath, hpmath)
			local col = Lerp(self.drc_scrollhplerp, self.MinVec, self.MaxVec)
			
			local interp = self.drc_scrollhplerp
			mat:SetVector( self.ResultTo, col )
		elseif owner:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			local ply = LocalPlayer()
			local hp = ply:Health()
			local maxhp = ply:GetMaxHealth()
			
			local hpmath = (hp / maxhp)
			self.drc_scrollhplerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), self.drc_scrollhplerp or hpmath, hpmath)
			local col = Lerp(self.drc_scrollhplerp, self.MinVec, self.MaxVec)
			
			local interp = self.drc_scrollhplerp
			mat:SetVector( self.ResultTo, col )
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
		
		if ent:Health() <= 0 then mat:SetInt("$frame", self.FrameNum - 1) return end
		
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
						ent.DRCBlinkFrame = ent.DRCBlinkFrame + 1
					end)
				end
			end)
		end
		
		mat:SetInt("$frame", ent.DRCBlinkFrame)
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