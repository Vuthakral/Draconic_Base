AddCSLuaFile()

--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

local HDR = render.GetHDREnabled()
local curmap = game.GetMap()
local LMCorrection = 1
local MapAmbient = render.GetAmbientLightColor()

local drc_badlightmaps = { -- The only maps that get added to this list are old maps which will not see an update/fix from their authors. This is not meant as a mark of shame. It is used in the Draconic menu to inform developers the map they are using has incorrectly compiled lighting, and as a result their content using the Draconic base visually might be slightly off.
	"gm_blackmesa_sigma",
	"gm_bigcity_improved",
	"gm_bigcity_improved_lite"
}

local drc_verifiedlightmaps = { -- (most) Base game maps & ones I know for sure are done correctly.
	"gm_construct",
	"gm_flatgrass",
	"gm_bigcity",
	"gm_emp_streetsoffire"
}

drc_authorpassedlightmaps = { -- Use " table.insert(drc_authorpassedlightmaps, "your_map_name") " in an autorun script as part of your map to tell the base your map should be labelled as "Author Pass".
}

if CTFK(drc_badlightmaps, curmap) then
	drc_mapfailed_lightamsp = true
	if curmap == "gm_blackmesa_sigma" then
		LMCorrection = 0.1
	elseif curmap == "gm_bigcity_improved" or curmap == "gm_bigcity_improved_lite" then
		LMCorrection = 0.25
	end
else
	drc_mapfailed_lightamsp = false
	LMCorrection = 1
end

if CTFK(drc_verifiedlightmaps, curmap) then
	drc_mappassed_lightmap = true
else
	drc_mappassed_lightmap = false
end

if CTFK(drc_authorpassedlightmaps, curmap) then
	drc_authorpassedlightmap = true
else
	drc_authorpassedlightmap = false
end

matproxy.Add( {
	name = "drc_PlayerColours",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local col = owner:GetPlayerColor()
		if ( !isvector( col )) then return end

		local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
		mat:SetVector( self.ResultTo, col + col * mul )
	end
} )

matproxy.Add( {
	name = "drc_PlayerColours_ForPlayer",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		local owner = ent
		
		if owner:IsPlayer() then
			local col = ent:GetNWVector("PlayerColour_DRC")
			if ( !isvector( col )) then return end

			local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
			mat:SetVector( self.ResultTo, col + col * mul )
		return end
		
		if owner:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			local col = LocalPlayer():GetPlayerColor()
			if ( !isvector( col )) then return end

			local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
			mat:SetVector( self.ResultTo, col + col * mul )
		return end
		
		if !owner:IsPlayer() then
			if CLIENT then return end
			if !owner:IsValid() then return end
			local col = ent:GetPlayerColor()
			if ( !isvector( col )) then return end

			local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
			mat:SetVector( self.ResultTo, col + col * mul )
		return end
	end
} )

matproxy.Add( {
	name = "drc_PlayerWeaponColours",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		local owner = ent:GetOwner()
		if not (owner:IsPlayer() or owner:IsWorld()) then return end
		if ent:IsPlayer() then
			local col = ent:GetNWVector("WeaponColour_DRC") / 255
			if ( !isvector( col )) then return end
			local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
			mat:SetVector( self.ResultTo, col + col * mul )
		else
			local col = ent:GetOwner():GetWeaponColor()
			if ( !isvector( col )) then return end
			local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
			mat:SetVector( self.ResultTo, col + col * mul )
		end
	end
} )

matproxy.Add( {
	name = "drc_WeaponColours_ForPlayer",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		local owner = ent
		
		if owner:IsPlayer() then
			local col = ent:GetNWVector("WeaponColour_DRC")
			if ( !isvector( col )) then return end

			local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
			mat:SetVector( self.ResultTo, col + col * mul )
		return end
		
		if owner:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			local col = LocalPlayer():GetPlayerColor()
			if ( !isvector( col )) then return end

			local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
			mat:SetVector( self.ResultTo, col + col * mul )
		return end
		
		if !owner:IsPlayer() then
			if CLIENT then return end
			if !owner:IsValid() then return end
			local col = ent:GetPlayerColor()
			if ( !isvector( col )) then return end

			local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
			mat:SetVector( self.ResultTo, col + col * mul )
		return end
	end
} )

matproxy.Add( {
	name = "drc_EyeColour",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if ent:IsPlayer() then
			local col = ent:GetNWVector("EyeTintVec") / 255
			if ( !isvector( col )) then return end
			local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
			mat:SetVector( self.ResultTo, col + col * mul )
		elseif !ent:IsPlayer() then
			local colr = LocalPlayer():GetInfoNum("cl_drc_eyecolour_r", 127)
			local colg = LocalPlayer():GetInfoNum("cl_drc_eyecolour_g", 127)
			local colb = LocalPlayer():GetInfoNum("cl_drc_eyecolour_b", 127)
			
			local col = Vector(colr, colg, colb) / 255
			if ( !isvector( col )) then return end

			local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
			mat:SetVector( self.ResultTo, col + col * mul )
		end
	end
} )

matproxy.Add( {
	name = "drc_EnergyColour",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if ent:IsPlayer() then
			local col = ent:GetNWVector("EnergyTintVec") / 255
			if ( !isvector( col )) then return end
			local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
			mat:SetVector( self.ResultTo, col + col * mul )
		elseif !ent:IsPlayer() then
			local pcr = math.Clamp(LocalPlayer():GetInfoNum("cl_drc_energycolour_r", 127), 200, 255)
			local pcg = math.Clamp(LocalPlayer():GetInfoNum("cl_drc_energycolour_g", 127), 200, 255)
			local pcb = math.Clamp(LocalPlayer():GetInfoNum("cl_drc_energycolour_b", 127), 200, 255)
		
			local pcmath = Vector(pcr, pcg, pcb)
			
			local col = pcmath / 255
			if ( !isvector( col )) then return end

			local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
			mat:SetVector( self.ResultTo, col + col * mul )
		end
	end
} )

matproxy.Add( {
	name = "drc_PlayerColour1",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if ent:IsPlayer() then
			local col = ent:GetNWVector("ColourTintVec1") / 255
			if ( !isvector( col )) then return end
			local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
			mat:SetVector( self.ResultTo, col + col * mul )
		elseif !ent:IsPlayer() then
			local colr = LocalPlayer():GetInfoNum("cl_drc_tint1_r", 127)
			local colg = LocalPlayer():GetInfoNum("cl_drc_tint1_g", 127)
			local colb = LocalPlayer():GetInfoNum("cl_drc_tint1_b", 127)
			
			local col = Vector(colr, colg, colb) / 255
			if ( !isvector( col )) then return end

			local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
			mat:SetVector( self.ResultTo, col + col * mul )
		end
	end
} )

matproxy.Add( {
	name = "drc_PlayerColour2",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if ent:IsPlayer() then
			local col = ent:GetNWVector("ColourTintVec2") / 255
			if ( !isvector( col )) then return end
			local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
			mat:SetVector( self.ResultTo, col + col * mul )
		elseif !ent:IsPlayer() then
			local colr = LocalPlayer():GetInfoNum("cl_drc_tint2_r", 127)
			local colg = LocalPlayer():GetInfoNum("cl_drc_tint2_g", 127)
			local colb = LocalPlayer():GetInfoNum("cl_drc_tint2_b", 127)
			
			local col = Vector(colr, colg, colb) / 255
			if ( !isvector( col )) then return end

			local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
			mat:SetVector( self.ResultTo, col + col * mul )
		end
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
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local wepn = owner:GetActiveWeapon()
		if ( !IsValid( wepn ) or !wepn:IsWeapon() ) then return end
		if wepn == nil then return end
		if wepn.Weapon == nil then return end
		if wepn.Weapon:GetNWInt("Heat") == nil then return end
		local heat = wepn.Weapon:GetNWInt("Heat")
		
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
	name = "drc_Compass",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local world = game.GetWorld
		local ang = owner:EyeAngles()
		local angmath = ang

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
		local owner = ent
		if !IsValid( owner ) then return end
		local lightlevel = render.GetLightColor(owner:GetPos())
		local median = (lightlevel.x + lightlevel.y + lightlevel.z) / 3
		
		if self.PowerFloat == nil then self.PowerFloat = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		local val = self.PowerFloat * median
		
		local final = Lerp(FrameTime() * 2.5, mat:GetFloat(self.ResultTo), val)
		mat:SetFloat( self.ResultTo, final )
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
		
		self.drc_locallightlerp = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_locallightlerp or val, val)
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
		
		self.drc_locallightlerp = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_locallightlerp or val, val)
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
		local owner = ent
		if !IsValid( owner ) then return end
		
		local lightlevel = render.GetLightColor(owner:GetPos())
		
		if self.PowerFloat == nil then self.PowerFloat = 1 end
		if self.MinFloat == nil then self.MinFloat = 0 end
		if self.MaxFloat == nil then self.MaxFloat = 1 end
		if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
		if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		if self.TintVector == nil then self.TintVector = Vector(1, 1, 1) end
		
		local lightr = math.Clamp(lightlevel.x, self.MinFloat, self.MaxFloat)
		local lightg = math.Clamp(lightlevel.y, self.MinFloat, self.MaxFloat)
		local lightb = math.Clamp(lightlevel.z, self.MinFloat, self.MaxFloat)
		
		if HDR then
			col = Vector(lightr, lightg, lightb) * self.HDRCorrectionLevel
		else
			col = Vector(lightr, lightg, lightb) * (10 * self.LDRCorrectionLevel)
		end
		
		if ( !isvector( col )) then return end
		
		self.drc_reflectiontintlerp = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_reflectiontintlerp or col, col)
		local interp = self.drc_reflectiontintlerp

		local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
		local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
		local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
		local final = Vector(finalx, finaly, finalz) * LMCorrection
		
		mat:SetVector( self.ResultTo, ( final * self.PowerFloat ) * ( self.TintVector * self.PowerFloat) )
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
		local owner = ent
		if !IsValid( owner ) then return end
		
		local lightlevel = render.GetLightColor(owner:GetPos())
		
		if self.PowerFloat == nil then self.PowerFloat = 1 end
		if self.MinFloat == nil then self.MinFloat = 0 end
		if self.MaxFloat == nil then self.MaxFloat = 1 end
		if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
		if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		if self.TintVector == nil then self.TintVector = Vector(1, 1, 1) end
		
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
		
		self.drc_reflectiontintlerp_ent = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_reflectiontintlerp_ent or col, col)
		local interp = roundedvec * self.drc_reflectiontintlerp_ent

		local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
		local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
		local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
		local final = Vector(finalx, finaly, finalz) * LMCorrection
		
		print(final)

		mat:SetVector( self.ResultTo, ( final * self.PowerFloat ) * ( self.TintVector * self.PowerFloat) )
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
		local owner = ent
		if !IsValid( owner ) then return end
		
		if self.TintVector == nil then self.TintVector = Vector(1, 1, 1) end
		if self.PowerFloat == nil then self.PowerFloat = 1 end
		if self.MinFloat == nil then self.MinFloat = 0 end
		if self.MaxFloat == nil then self.MaxFloat = 1 end
		if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
		if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		if self.TintVector == nil then self.TintVector = Vector(1, 1, 1) end
		
		if owner:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			local lightlevel = render.GetLightColor(owner:GetPos())
			
			local pcr = math.Clamp(LocalPlayer():GetNWVector("PlayerColour_DRC").x, self.MinFloat, self.MaxFloat)
			local pcg = math.Clamp(LocalPlayer():GetNWVector("PlayerColour_DRC").y, self.MinFloat, self.MaxFloat)
			local pcb = math.Clamp(LocalPlayer():GetNWVector("PlayerColour_DRC").z, self.MinFloat, self.MaxFloat)
		
			local pcmath = Vector(pcr, pcg, pcb)
				
			local lightr = lightlevel.x
			local lightg = lightlevel.y
			local lightb = lightlevel.z
				
			if HDR then
				col = pcmath * Vector(lightr, lightg, lightb) * self.HDRCorrectionLevel
			else
				col = pcmath * Vector(lightr, lightg, lightb) * (10 * self.LDRCorrectionLevel)
			end
				
			if ( !isvector( col )) then return end
			
			self.drc_reflectiontintlerp_pc = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_reflectiontintlerp_pc or col, col)
			local interp = self.drc_reflectiontintlerp_pc
			
			local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
			local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
			local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
			local final = Vector(finalx, finaly, finalz) * LMCorrection
			
			mat:SetVector( self.ResultTo, (final * self.PowerFloat) + (self.TintVector * self.PowerFloat) * final )
		return end
		
		if !owner:IsPlayer() then return end
		local lightlevel = render.GetLightColor(owner:GetPos())
		
		local pcr = math.Clamp(owner:GetNWVector("PlayerColour_DRC").x, self.MinFloat, self.MaxFloat)
		local pcg = math.Clamp(owner:GetNWVector("PlayerColour_DRC").y, self.MinFloat, self.MaxFloat)
		local pcb = math.Clamp(owner:GetNWVector("PlayerColour_DRC").z, self.MinFloat, self.MaxFloat)
	
		local pcmath = Vector(pcr, pcg, pcb)
			
		local lightr = lightlevel.x
		local lightg = lightlevel.y
		local lightb = lightlevel.z
			
		if HDR then
			col = pcmath * Vector(lightr, lightg, lightb) * self.HDRCorrectionLevel
		else
			col = pcmath * Vector(lightr, lightg, lightb) * (10 * self.LDRCorrectionLevel)
		end
			
		if ( !isvector( col )) then return end
		
		self.drc_reflectiontintlerp_pc = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_reflectiontintlerp_pc or col, col)
		local interp = self.drc_reflectiontintlerp_pc
		
		local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
		local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
		local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
		local final = Vector(finalx, finaly, finalz) * LMCorrection
		
		mat:SetVector( self.ResultTo, (final * self.PowerFloat) + (self.TintVector * self.PowerFloat) * final )
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
		local owner = ent
		if !IsValid( owner ) then return end
		if !owner:IsPlayer() then return end
		local lightlevel = render.GetLightColor(owner:GetPos())
		
		if self.TintVector == nil then self.TintVector = Vector(1, 1, 1) end
		if self.PowerFloat == nil then self.PowerFloat = 1 end
		if self.MinFloat == nil then self.MinFloat = 0 end
		if self.MaxFloat == nil then self.MaxFloat = 1 end
		if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
		if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		if self.TintVector == nil then self.TintVector = Vector(1, 1, 1) end
		
		local pcr = math.Clamp(owner:GetNWVector("EyeTintVec").x / 255, self.MinFloat, self.MaxFloat)
		local pcg = math.Clamp(owner:GetNWVector("EyeTintVec").y / 255, self.MinFloat, self.MaxFloat)
		local pcb = math.Clamp(owner:GetNWVector("EyeTintVec").z / 255, self.MinFloat, self.MaxFloat)
	
		local pcmath = Vector(pcr, pcg, pcb)
			
		local lightr = lightlevel.x
		local lightg = lightlevel.y
		local lightb = lightlevel.z
			
		if HDR then
			col = pcmath * Vector(lightr, lightg, lightb) * self.HDRCorrectionLevel
		else
			col = pcmath * Vector(lightr, lightg, lightb) * (10 * self.LDRCorrectionLevel)
		end
			
		if ( !isvector( col )) then return end
			
		self.drc_reflectiontintlerp_eyec = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_reflectiontintlerp_eyec or col, col)
		local interp = self.drc_reflectiontintlerp_eyec
		
		local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
		local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
		local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
		local final = Vector(finalx, finaly, finalz) * LMCorrection
		
		mat:SetVector( self.ResultTo, (final * self.PowerFloat) + (self.TintVector * self.PowerFloat) * final )
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
		local owner = ent
		if !IsValid( owner ) then return end
		if !owner:IsPlayer() then return end
		local lightlevel = render.GetLightColor(owner:GetPos())
		
		if self.TintVector == nil then self.TintVector = Vector(1, 1, 1) end
		if self.PowerFloat == nil then self.PowerFloat = 1 end
		if self.MinFloat == nil then self.MinFloat = 0 end
		if self.MaxFloat == nil then self.MaxFloat = 1 end
		if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
		if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		if self.TintVector == nil then self.TintVector = Vector(1, 1, 1) end
		
		local pcr = math.Clamp(owner:GetNWVector("ColourTintVec1").x / 255, self.MinFloat, self.MaxFloat)
		local pcg = math.Clamp(owner:GetNWVector("ColourTintVec1").y / 255, self.MinFloat, self.MaxFloat)
		local pcb = math.Clamp(owner:GetNWVector("ColourTintVec1").z / 255, self.MinFloat, self.MaxFloat)
	
		local pcmath = Vector(pcr, pcg, pcb)
			
		local lightr = lightlevel.x
		local lightg = lightlevel.y
		local lightb = lightlevel.z
			
		if HDR then
			col = pcmath * Vector(lightr, lightg, lightb) * self.HDRCorrectionLevel
		else
			col = pcmath * Vector(lightr, lightg, lightb) * (10 * self.LDRCorrectionLevel)
		end
			
		if ( !isvector( col )) then return end
			
		self.drc_reflectiontintlerp_pt1 = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_reflectiontintlerp_pt1 or col, col)
		local interp = self.drc_reflectiontintlerp_pt1
		
		local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
		local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
		local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
		local final = Vector(finalx, finaly, finalz) * LMCorrection
		
		mat:SetVector( self.ResultTo, (final * self.PowerFloat) + (self.TintVector * self.PowerFloat) * final )
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
		local owner = ent
		if !IsValid( owner ) then return end
		if !owner:IsPlayer() then return end
		local lightlevel = render.GetLightColor(owner:GetPos())
		
		if self.TintVector == nil then self.TintVector = Vector(1, 1, 1) end
		if self.PowerFloat == nil then self.PowerFloat = 1 end
		if self.MinFloat == nil then self.MinFloat = 0 end
		if self.MaxFloat == nil then self.MaxFloat = 1 end
		if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
		if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		if self.TintVector == nil then self.TintVector = Vector(1, 1, 1) end
		
		local pcr = math.Clamp(owner:GetNWVector("ColourTintVec2").x / 255, self.MinFloat, self.MaxFloat)
		local pcg = math.Clamp(owner:GetNWVector("ColourTintVec2").y / 255, self.MinFloat, self.MaxFloat)
		local pcb = math.Clamp(owner:GetNWVector("ColourTintVec2").z / 255, self.MinFloat, self.MaxFloat)
	
		local pcmath = Vector(pcr, pcg, pcb)
			
		local lightr = lightlevel.x
		local lightg = lightlevel.y
		local lightb = lightlevel.z
			
		if HDR then
			col = pcmath * Vector(lightr, lightg, lightb) * self.HDRCorrectionLevel
		else
			col = pcmath * Vector(lightr, lightg, lightb) * (10 * self.LDRCorrectionLevel)
		end
			
		if ( !isvector( col )) then return end
			
		self.drc_reflectiontintlerp_pt2 = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_reflectiontintlerp_pt2 or col, col)
		local interp = self.drc_reflectiontintlerp_pt2
		
		local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
		local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
		local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
		local final = Vector(finalx, finaly, finalz) * LMCorrection
		
		mat:SetVector( self.ResultTo, (final * self.PowerFloat) + (self.TintVector * self.PowerFloat) * final )
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
		local owner = ent:GetOwner()
		if !IsValid( owner ) then return end
		if !owner:IsPlayer() then return end
		local lightlevel = render.GetLightColor(owner:GetPos())
		
		if self.TintVector == nil then self.TintVector = Vector(1, 1, 1) end
		if self.PowerFloat == nil then self.PowerFloat = 1 end
		if self.MinFloat == nil then self.MinFloat = 0 end
		if self.MaxFloat == nil then self.MaxFloat = 1 end
		if self.HDRCorrectionLevel == nil then self.HDRCorrectionLevel = 1 end
		if self.LDRCorrectionLevel == nil then self.LDRCorrectionLevel = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		if self.TintVector == nil then self.TintVector = Vector(1, 1, 1) end
		
		local pcr = math.Clamp(owner:GetNWVector("WeaponColour_DRC").x, self.MinFloat, self.MaxFloat)
		local pcg = math.Clamp(owner:GetNWVector("WeaponColour_DRC").y, self.MinFloat, self.MaxFloat)
		local pcb = math.Clamp(owner:GetNWVector("WeaponColour_DRC").z, self.MinFloat, self.MaxFloat)
	
		local pcmath = Vector(pcr, pcg, pcb)
			
		local lightr = lightlevel.x
		local lightg = lightlevel.y
		local lightb = lightlevel.z
			
		if HDR then
			col = pcmath * Vector(lightr, lightg, lightb) * self.HDRCorrectionLevel
		else
			col = pcmath * Vector(lightr, lightg, lightb) * (10 * self.LDRCorrectionLevel)
		end
			
		if ( !isvector( col )) then return end
			
		self.drc_reflectiontintlerp_wc = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_reflectiontintlerp_wc or col, col)
		local interp = self.drc_reflectiontintlerp_wc
		
		local finalx = math.Clamp(interp.x, self.MinFloat, self.MaxFloat)
		local finaly = math.Clamp(interp.y, self.MinFloat, self.MaxFloat)
		local finalz = math.Clamp(interp.z, self.MinFloat, self.MaxFloat)
		local final = Vector(finalx, finaly, finalz) * LMCorrection
		
		mat:SetVector( self.ResultTo, (final * self.PowerFloat) + (self.TintVector * self.PowerFloat) * final )
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
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local wpn = owner:GetActiveWeapon()
		local mag = wpn.Weapon:Clip1()
		local maxmag = wpn.Primary.ClipSize
		
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		if self.FlipVar == 0 then
			local magmath = (mag / maxmag) / 2 * self.VarMult
			self.drc_scrollmaglerp = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_scrollmaglerp or magmath, magmath)
			mat:SetVector( self.ResultTo, Vector(self.drc_scrollmaglerp, 0, 0) )
		else
			local magmath = (mag / maxmag) / 2 * self.VarMult
			self.drc_scrollmaglerp = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_scrollmaglerp or magmath, magmath)
			mat:SetVector( self.ResultTo, Vector(-self.drc_scrollmaglerp, 0, 0) )
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
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local wpn = owner:GetActiveWeapon()
		if wpn == nil then return end
		if wpn.Weapon == nil then return end
		if wpn.Weapon:GetNWInt("LoadedAmmo") == nil then return end
		
		if self.RadVar == nil then self.RadVar = 360 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		local mag = wpn.Weapon:Clip1()
		local maxmag = wpn.Primary.ClipSize
		local magmath = (mag / maxmag) * self.RadVar
		self.drc_rotatemaglerp = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_rotatemaglerp or magmath, magmath)

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
			self.drc_scrollhplerp = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_scrollhplerp or hpmath, hpmath)
			local col = Lerp(self.drc_scrollhplerp, self.MinVec, self.MaxVec)
			
			local interp = self.drc_scrollhplerp
			mat:SetVector( self.ResultTo, col )
		elseif owner:IsWeapon() then
			local ply = owner:GetOwner()
			local hp = ply:Health()
			local maxhp = ply:GetMaxHealth()
			
			local hpmath = (hp / maxhp)
			self.drc_scrollhplerp = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_scrollhplerp or hpmath, hpmath)
			local col = Lerp(self.drc_scrollhplerp, self.MinVec, self.MaxVec)
			
			local interp = self.drc_scrollhplerp
			mat:SetVector( self.ResultTo, col )
		elseif owner:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			local ply = LocalPlayer()
			local hp = ply:Health()
			local maxhp = ply:GetMaxHealth()
			
			local hpmath = (hp / maxhp)
			self.drc_scrollhplerp = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_scrollhplerp or hpmath, hpmath)
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
				self.drc_scrollmaglerp = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_scrollmaglerp or magmath, magmath)
				mat:SetVector( self.ResultTo, Vector(self.drc_scrollmaglerp, 0, 0) )
			else
				local magmath = (mag / maxmag) / 2 * self.VarMult
				self.drc_scrollmaglerp = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_scrollmaglerp or magmath, magmath)
				mat:SetVector( self.ResultTo, Vector(-self.drc_scrollmaglerp, 0, 0) )
			end
		elseif owner:IsWeapon() then
			local ply = owner:GetOwner()
			local mag = hp
			local maxmag = ply:GetMaxHealth()
			
			if self.FlipVar == 0 then
				local magmath = (mag / maxmag) / 2 * self.VarMult
				self.drc_scrollmaglerp = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_scrollmaglerp or magmath, magmath)
				mat:SetVector( self.ResultTo, Vector(self.drc_scrollmaglerp, 0, 0) )
			else
				local magmath = (mag / maxmag) / 2 * self.VarMult
				self.drc_scrollmaglerp = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_scrollmaglerp or magmath, magmath)
				mat:SetVector( self.ResultTo, Vector(-self.drc_scrollmaglerp, 0, 0) )
			end
		elseif owner:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			local ply = LocalPlayer()
			local mag = hp
			local maxmag = ply:GetMaxHealth()
			
			if self.FlipVar == 0 then
				local magmath = (mag / maxmag) / 2 * self.VarMult
				self.drc_scrollmaglerp = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_scrollmaglerp or magmath, magmath)
				mat:SetVector( self.ResultTo, Vector(self.drc_scrollmaglerp, 0, 0) )
			else
				local magmath = (mag / maxmag) / 2 * self.VarMult
				self.drc_scrollmaglerp = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_scrollmaglerp or magmath, magmath)
				mat:SetVector( self.ResultTo, Vector(-self.drc_scrollmaglerp, 0, 0) )
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
			self.drc_rotatemaglerp = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_rotatemaglerp or magmath, magmath)

			mat:SetVector( self.ResultTo, Vector(self.drc_rotatemaglerp, 0, 0) )
		elseif owner:IsWeapon() then
			local ply = owner:GetOwner()
			local mag = ply:Health()
			local maxmag = ply:GetMaxHealth()
			local magmath = (mag / maxmag) * self.RadVar
			self.drc_rotatemaglerp = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_rotatemaglerp or magmath, magmath)

			mat:SetVector( self.ResultTo, Vector(self.drc_rotatemaglerp, 0, 0) )
		elseif owner:EntIndex() == LocalPlayer():GetHands():EntIndex() then
			local ply = LocalPlayer()
			local mag = ply:Health()
			local maxmag = ply:GetMaxHealth()
			local magmath = (mag / maxmag) * self.RadVar
			self.drc_rotatemaglerp = Lerp(FrameTime() * (self.LerpPower * 2.5), self.drc_rotatemaglerp or magmath, magmath)

			mat:SetVector( self.ResultTo, Vector(self.drc_rotatemaglerp, 0, 0) )
		end
	end
} )