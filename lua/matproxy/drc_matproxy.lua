--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

local cmap = game.GetMap()
local lply = LocalPlayer()
local HDR = render.GetHDREnabled()
local LMCor = DRC.MapInfo.LMCorrection
DRC.WeathermodScalar = Vector(1,1,1)
DRC.MatProxy = {}

function DRC:CubemapCheck()
	if (DRC:DebugModeEnabled() && GetConVar("cl_drc_debug_cubefallbacks"):GetFloat() == 1) or (GetConVar("cl_drc_accessibility_amduser"):GetFloat() == 1)  then return false end
	if #drc_cubesamples != 0 then return true else return false end
end

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

hook.Add("InitPostEntity", "DRC_MatProxy_InitPost", function()
	if lply != LocalPlayer() then lply = LocalPlayer() end
end)

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
		if (src.Preview == true or src.preview == true) or (src:EntIndex() == lply:GetHands():EntIndex()) or (src:GetNWVector(channel, Vector(0,0,0)) == Vector(0,0,0)) then
			local vals = DRC:GetColours(lply, true)
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

local function LightPollEntity(ent, mat)
	if !mat then mat = "None" end
	if !ent.DRCLightPolling then ent.DRCLightPolling = {} end
	if !ent.DRCLightPolling["Realtime"] then ent.DRCLightPolling["Realtime"] = false end
	if !ent.DRCLightPolling["LightPollTime"] then ent.DRCLightPolling["LightPollTime"] = 0 end
	if !ent.DRCLightPolling["LightPollLastPos"] then ent.DRCLightPolling["LightPollLastPos"] = ent:GetPos() end
	if !ent.DRCLightPolling[mat] then ent.DRCLightPolling[mat] = "" end
	
	local function QueuePoll()
		local fps = 1/RealFrameTime()
		local nexttick = RealTime() + (0.2 + (math.Rand(-0.1, 0.1)))
		if fps < 40 && fps > 21 then nexttick = RealTime() + (1 + (math.Rand(-0.5, 0.25))) end
		if fps < 20 then nexttick = RealTime() + (1 + (math.Rand(-1, 2))) end
		if ent.DRCLightPolling["Realtime"] == true then nexttick = RealTime() + 0.0333 end -- light polling @ 30tps; used for viewmodels & c_hands
		ent.DRCLightPolling["LightPollTime"] = nexttick
	end
	
	if RealTime() < ent.DRCLightPolling["LightPollTime"] then return end
	if ent:GetPos() == ent.DRCLightPolling["LightPollLastPos"] then QueuePoll() return
	else ent.DRCLightPolling["LightPollLastPos"] = ent:GetPos() end
	QueuePoll()
	
	local pos
	if ent:EntIndex() == lply:GetHands():EntIndex() or ent:EntIndex() == lply:GetViewModel():EntIndex() then
		pos = lply:EyePos()
	--	print("A", ent, lply:GetViewModel())
	else
	--	print("B", ent, lply:GetViewModel())
		pos = ent:GetPos() + ent:OBBCenter()
		if game.SinglePlayer() && ent:IsWeapon() && !DRC:ThirdPersonEnabled(lply) && ent:GetOwner() == lply then pos = lply:EyePos() end
	end
	
	local lightlevel = render.GetLightColor(pos)
	local lla = (lightlevel.x + lightlevel.y + lightlevel.z) / 3
--	print(lply:ChatPrint(tostring(lightlevel)))
	ent.DRCLightPolling["LightTint"] = lightlevel
	return lightlevel, lla
end

--[[
local adjustedmaps = {}
table.Inherit(adjustedmaps, drc_singlecubemaps)
table.Inherit(adjustedmaps, drc_badlightmaps)
table.Inherit(adjustedmaps, drc_fullbrightcubemaps)
local function GetAdjustedCubeStrength()
end ]]

local function GetCubemapStrength(mat, ent, channel, imat, realtime)
	if CurTime() < ent:GetCreationTime() + 0.03 then return Vector() end
	if !IsValid(ent) then return Vector() end
	
	local blacklist = {
		["drc_csshadowmodel"] = true,
	}
	if blacklist[ent:GetClass()] then return Vector() end

	mat.TintVector = imat:GetVector("$cubemaptint") or imat:GetVector("$cmtint")
	mat.PowerFloat = imat:GetFloat("$cubemappower") or imat:GetFloat("$cmpower")
	mat.MinFloat	= imat:GetFloat("$cubemapmin") or imat:GetFloat("$cmmin")
	mat.MaxFloat	= imat:GetFloat("$cubemapmax") or imat:GetFloat("$cmmax")
	mat.HDRCorrectionLevel	= imat:GetFloat("$cubemapHDRMul") or imat:GetFloat("$cmhdr")
	mat.LDRCorrectionLevel	= imat:GetFloat("$cubemapLDRMul") or imat:GetFloat("$cmldr")
	if imat:GetFloat("$cubemaplightingsaturation") then mat.Saturation = imat:GetFloat("$cubemaplightingsaturation") mat.Saturation = 1 end
	if imat:GetFloat("$cmlightsat") then mat.Saturation = imat:GetFloat("$cmlightsat") else mat.Saturation = 1 end
	if DRC:CubemapCheck() == false then
		if imat:GetVector("$cubemaptintfallback") then mat.TintVector = imat:GetVector("$cubemaptintfallback") end
		if imat:GetVector("$cmtint_fb") then mat.TintVector = imat:GetVector("$cmtint_fb") end
		if imat:GetFloat("$cubemappowerfallback") then mat.PowerFloat = imat:GetFloat("$cubemappowerfallback") end
		if imat:GetFloat("$cmpower_fb") then mat.PowerFloat = imat:GetFloat("$cmpower_fb") end
		if imat:GetFloat("$cubemapminfallback") then mat.MinFloat = imat:GetFloat("$cubemapminfallback") end
		if imat:GetFloat("$cmmin_fb") then mat.MinFloat = imat:GetFloat("$cmmin_fb") end
		if imat:GetFloat("$cubemapmaxfallback") then mat.MaxFloat = imat:GetFloat("$cubemapmaxfallback") end
		if imat:GetFloat("$cmmax_fb") then mat.MaxFloat = imat:GetFloat("$cmmax_fb") end
		if imat:GetFloat("$cubemapHDRMulfallback") then mat.MaxFloat = imat:GetFloat("$cubemapHDRMulfallback") end
		if imat:GetFloat("$cmhdr_fb") then mat.MaxFloat = imat:GetFloat("$cmhdr_fb") end
		if imat:GetFloat("$cubemapLDRMulfallback") then mat.MaxFloat = imat:GetFloat("$cubemapLDRMulfallback") end
		if imat:GetFloat("$cmldr_fb") then mat.MaxFloat = imat:GetFloat("$cmldr_fb") end
	end
	if mat.LerpPower == nil then mat.LerpPower = 1 end
	if mat.TintVector == nil then mat.TintVector = Vector(1,1,1) end
	if mat.PowerFloat == nil then mat.PowerFloat = 1 end
	if mat.MinFloat == nil then mat.MinFloat = 0 end
	if mat.MaxFloat == nil then mat.MaxFloat = 1 end
	if mat.HDRCorrectionLevel == nil then mat.HDRCorrectionLevel = 1 end
	if mat.LDRCorrectionLevel == nil then mat.LDRCorrectionLevel = 1 end
	if mat.Saturation == nil then mat.Saturation = 1 end
	if mat.LerpPower == nil then mat.LerpPower = 1 end
	if !ent.DRCLightPolling then ent.DRCLightPolling = {} end	
	if !ent.DRCLightPolling["LightPollTime"] then ent.DRCLightPolling["LightPollTime"] = 0 end	
	if !ent.DRCReflectionTints then ent.DRCReflectionTints = {} end	
	if !ent.DRCReflectionTints.Stored then ent.DRCReflectionTints.Stored = {} end
	
	local name = imat:GetName()
	if ent:EntIndex() == lply:GetViewModel():EntIndex() then ent = lply:GetActiveWeapon() end
	if !IsValid(ent) then return end 
	if !ent.DRCReflectionTints then ent.DRCReflectionTints = {} end
	if !ent.DRCReflectionTints[name] then ent.DRCReflectionTints[name] = {} end
	if !ent.DRCReflectionTints[name]["UpdateTime"] then ent.DRCReflectionTints[name]["UpdateTime"] = 0 end
	if !ent.DRCReflectionTints[name][channel] then ent.DRCReflectionTints[name][channel] = Vector() end
	if !ent.DRCReflectionTints.Stored then ent.DRCReflectionTints.Stored = {} end
	if !ent.DRCReflectionTints.Stored[name] then ent.DRCReflectionTints.Stored[name] = {} end
	if !ent.DRCReflectionTints.Stored[name][channel] then ent.DRCReflectionTints.Stored[name][channel] = Vector() end
	
	local col = Vector()
	local function GetColour(e, c)
		local colnew = GetPlayerColour(e, c)
		if colnew then
			colnew.x = math.Clamp(colnew.x, mat.MinFloat, mat.MaxFloat)
			colnew.y = math.Clamp(colnew.y, mat.MinFloat, mat.MaxFloat)
			colnew.z = math.Clamp(colnew.z, mat.MinFloat, mat.MaxFloat)
			return colnew
		end
	end
		
	if ent.Preview == true or ent.preview == true then
		local mul = Vector(1, 1, 1)
		if HDR then mul = mat.HDRCorrectionLevel else mul = (10 * mat.LDRCorrectionLevel) end
		col = (mat.TintVector * mat.PowerFloat * GetColour(lply, channel) * mul) * DRC.MapInfo.MapAmbientAvg * DRC.WeathermodScalar
	return col end
	
	local function ReturnValue()
		local ll, lla = LightPollEntity(ent)
		ll = ll or ent.DRCLightPolling["LightTint"]
		if !ll then return Vector() end
		ll.r = math.Clamp(ll.r, mat.MinFloat, mat.MaxFloat)
		ll.g = math.Clamp(ll.g, mat.MinFloat, mat.MaxFloat)
		ll.b = math.Clamp(ll.b, mat.MinFloat, mat.MaxFloat)
		if ent:EntIndex() == lply:GetHands():EntIndex() then
			ent.DRCLightPolling["Realtime"] = true
			col = GetColour(lply, channel)
			
			if HDR then col = col * Vector(ll.r, ll.g, ll.b) * mat.HDRCorrectionLevel
			else col = col * Vector(ll.r, ll.g, ll.b) * (10 * mat.LDRCorrectionLevel) end
		elseif ent:EntIndex() == lply:GetViewModel():EntIndex() then
			local newent = lply:GetActiveWeapon()
			ent.DRCLightPolling["Realtime"] = true
			newent.DRCLightPolling["Realtime"] = true
			if !IsValid(newent) then return Vector() end
			if !newent.DRCReflectionTints then newent.DRCReflectionTints = {} end
			col = GetColour(newent, channel)
			
			if HDR then col = col * Vector(ll.r, ll.g, ll.b) * mat.HDRCorrectionLevel
			else col = col * Vector(ll.r, ll.g, ll.b) * (10 * mat.LDRCorrectionLevel) end
		elseif ent:IsRagdoll() then
			col = GetColour(ent, channel)
			
			if HDR then col = col * Vector(ll.r, ll.g, ll.b) * mat.HDRCorrectionLevel
			else col = col * Vector(ll.r, ll.g, ll.b) * (10 * mat.LDRCorrectionLevel) end
		else
			col = GetColour(ent, channel)
			
			if HDR then col = col * Vector(ll.r, ll.g, ll.b) * mat.HDRCorrectionLevel
			else col = col * Vector(ll.r, ll.g, ll.b) * (10 * mat.LDRCorrectionLevel) end
		end
		return col
	end
	
	--if (RealTime() > ent.DRCReflectionTints[name]["UpdateTime"]) then
		local fps = 1/RealFrameTime()
		local nexttick = RealTime() + (0.2 + (math.Rand(-0.1, 0.1)))
		if fps < 40 && fps > 21 then nexttick = RealTime() + (1 + (math.Rand(-0.5, 0.25))) end
		if fps < 20 then nexttick = RealTime() + (1 + (math.Rand(-1, 2))) end
		ent.DRCReflectionTints.Stored[name][channel] = (ReturnValue() * LMCor * DRC.WeathermodScalar) * (DRC.WeathermodScalar * mat.TintVector) * mat.PowerFloat
		ent.DRCReflectionTints[name]["UpdateTime"] = nexttick
	--	PrintTable(ent.DRCReflectionTints)
--	end

	ent.DRCReflectionTints[name][channel] = Lerp(RealFrameTime() * (mat.LerpPower * 2.5), ent.DRCReflectionTints[name][channel] or ent.DRCReflectionTints.Stored[name][channel], ent.DRCReflectionTints.Stored[name][channel])
	local avg = (ent.DRCReflectionTints[name][channel].x + ent.DRCReflectionTints[name][channel].y + ent.DRCReflectionTints[name][channel].z) / 3
	local final = (LerpVector(mat.Saturation, Vector(avg, avg, avg), ent.DRCReflectionTints[name][channel]) * mat.TintVector)
	return final
end

matproxy.Add( {
	name = "drc_EnvmapFallback",
	init = function( self, mat, values )
		self.Envmap = mat:GetString("$envmapfallback")
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		if !IsValid(lply) then return end
		
		if self.OGEnvmap == nil then self.OGEnvmap = mat:GetTexture("$envmap") end
		if self.Envmap == nil then self.Envmap = "env_cubemap" end
		
		if DRC:CubemapCheck() == false then
			mat:SetTexture( "$envmap", self.Envmap )
		else
			mat:SetTexture( "$envmap", self.OGEnvmap )
		end
	end
} )

matproxy.Add( {
	name = "caramell",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.ResultTo2 = values.resultvar2
		self.ResultTo3 = values.resultvar3
	end,

	bind = function( self, mat, ent )
	--	if ( !IsValid( ent )) then return end
		if !IsValid(lply) then return end
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
		if !IsValid(lply) then return end
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
		if !IsValid(lply) then return end
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
		if !IsValid(lply) then return end
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
		if !IsValid(lply) then return end
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
		if !IsValid(lply) then return end
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
		
		if ent:EntIndex() == lply:GetHands():EntIndex() or ent.preview == true then
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
		if !IsValid(lply) then return end
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
			heat = wepn:GetHeat()
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
		if !IsValid(lply) then return end
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local wepn = owner:GetActiveWeapon()
		if ( !IsValid( wepn ) or !wepn:IsWeapon() ) then return end
		if wepn == nil then return end
		if wepn == nil then return end
		if wepn:GetNWInt("Charge") == nil then return end
		local charge = wepn:GetNWInt("Charge")
		
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
		if !IsValid(lply) then return end
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local wepn = owner:GetActiveWeapon()
		if ( !IsValid( wepn ) or !wepn:IsWeapon() ) then return end
		if wepn == nil then return end
		if wepn == nil then return end
		if wepn:GetNWInt("Charge") == nil then return end
		local charge = wepn.BloomValue
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
		if !IsValid(lply) then return end
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
		if !IsValid(lply) then return end
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
			local ang = lply:EyeAngles()
			if self.SnapDegree == nil then self.SnapDegree = 0.01 end
			local antistupidity = math.Clamp(self.SnapDegree, 0.01, 360)
			
			local angmath = ang:SnapTo("y", antistupidity)

			mat:SetVector( self.ResultTo, Vector(-angmath.y, 0, 0) )
		return end
		if !IsValid(lply) then return end
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
		if !IsValid(lply) then return end
		
		if self.MinVec == nil then self.MinVec = Vector(1, 1, 1) end
		if self.MaxVec == nil then self.MaxVec = Vector(0, 0, 0) end
		if self.MulInt == nil then self.MulInt = 1 end
		if self.LerpSpeed == nil then self.LerpSpeed = 10 end
		if !self.ResultTo then self.ResultTo = "$color2" end
		
		if ent.preview == true then mat:SetVector(self.ResultTo, Vector(1,1,1)) return end
		
		local ply
		
		if ent:IsWeapon() then ply = ent:GetOwner() end
		if ent:EntIndex() == lply:GetHands():EntIndex() then ply = lply end
		if ent:EntIndex() == lply:GetViewModel():EntIndex() then ply = lply end
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
		if !IsValid(lply) then return end
		local owner = ent
		if !IsValid( owner ) then return end
		
		if self.PowerFloat == nil then self.PowerFloat = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		if ent.Preview == true or ent.preview == true then
			mat:SetFloat("$rimlightboost", (self.PowerFloat * DRC.MapInfo.MapAmbientAvg) /10)
		else			
			local name = mat:GetName()
			if ent:EntIndex() == lply:GetViewModel():EntIndex() then ent = lply:GetActiveWeapon() end
			if !IsValid(ent) then return end 
			if !ent.DRCScalingRimLightParams then ent.DRCScalingRimLightParams = {} end
			if !ent.DRCScalingRimLightParams["Value"] then ent.DRCScalingRimLightParams["Value"] = 0 end
			if !ent.DRCScalingRimLightParams[name] then ent.DRCScalingRimLightParams[name] = {} end
			if !ent.DRCScalingRimLightParams[name]["Value"] then ent.DRCScalingRimLightParams[name]["Value"] = 0 end
			if !ent.DRCScalingRimLightParams[name]["UpdateTime"] then ent.DRCScalingRimLightParams[name]["UpdateTime"] = 0 end
			if !ent.DRCScalingRimLightParams.Stored then ent.DRCScalingRimLightParams.Stored = {} end
			if !ent.DRCScalingRimLightParams.Stored[name] then ent.DRCScalingRimLightParams.Stored[name] = {} end
			if !ent.DRCScalingRimLightParams.Stored[name]["Value"] then ent.DRCScalingRimLightParams.Stored[name]["Value"] = 0 end
			if !ent.DRCScalingRimLightParams.Stored[name]["UpdateTime"] then ent.DRCScalingRimLightParams.Stored[name]["UpdateTime"] = 0 end
			
			
			local weatheravg = ((DRC.WeathermodScalar.x + DRC.WeathermodScalar.y + DRC.WeathermodScalar.z)/3)
			local ll, lla = LightPollEntity(ent)
				
			if lla then
				ent.DRCScalingRimLightParams["Value"] = (lla * self.PowerFloat) * weatheravg
				if !HDR then ent.DRCScalingRimLightParams["Value"] = ent.DRCScalingRimLightParams["Value"] * 0.117 end
			end
			
			if !realtime && (RealTime() > ent.DRCScalingRimLightParams[name]["UpdateTime"]) then
				local fps = 1/RealFrameTime()
				local nexttick = RealTime() + (0.2 + (math.Rand(-0.1, 0.1)))
				if fps < 40 && fps > 21 then nexttick = RealTime() + (1 + (math.Rand(-0.5, 0.25))) end
				if fps < 20 then nexttick = RealTime() + (1 + (math.Rand(-1, 2))) end
				ent.DRCScalingRimLightParams.Stored[name]["Value"] = ent.DRCScalingRimLightParams["Value"]
				ent.DRCScalingRimLightParams[name]["UpdateTime"] = nexttick
			end

			ent.DRCScalingRimLightParams[name]["Value"] = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.DRCScalingRimLightParams[name]["Value"] or ent.DRCScalingRimLightParams.Stored[name]["Value"], ent.DRCScalingRimLightParams.Stored[name]["Value"])
		--	PrintTable(ent.DRCScalingRimLightParams)
			mat:SetFloat( "$rimlightboost", ent.DRCScalingRimLightParams[name]["Value"] )
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
		if !IsValid(lply) then return end
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
		if !IsValid(lply) then return end
		local owner = ent
		if !IsValid( owner ) then return end
		if self.MinVec == nil then self.MinVec = Vector(0, 0, 0) end
		if self.MaxVec == nil then self.MaxVec = Vector(1, 1, 1) end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		local lightlevel = render.GetLightColor(lply:GetEyeTrace().HitPos)
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
		if !IsValid(lply) then return end
		local owner = ent
		if !IsValid( owner ) then return end
		
		if !self.ResultTo then self.ResultTo = "$envmaptint" end
		
		local val = GetCubemapStrength(self, ent, "None", mat)
		if val then mat:SetVector(self.ResultTo, val) end
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
		if !IsValid(lply) then return end
		local owner = ent
		if !IsValid( owner ) then return end
		
		if !self.ResultTo then self.ResultTo = "$envmaptint" end
		
		local val = GetCubemapStrength(self, ent, "Entity", mat)
		if val then mat:SetVector(self.ResultTo, val) end
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
		if !IsValid(lply) then return end
		
		if !self.ResultTo then self.ResultTo = "$envmaptint" end
		
		local val = GetCubemapStrength(self, ent, "PlayerColour_DRC", mat)
		if val then mat:SetVector(self.ResultTo, val) end
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
		if !IsValid(lply) then return end
		
		if !self.ResultTo then self.ResultTo = "$envmaptint" end
		
		local val = GetCubemapStrength(self, ent, "EyeTintVec", mat)
		if val then mat:SetVector(self.ResultTo, val) end
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
		if !IsValid(lply) then return end
		
		if !self.ResultTo then self.ResultTo = "$envmaptint" end
		
		local val = GetCubemapStrength(self, ent, "ColourTintVec1", mat)
		if val then mat:SetVector(self.ResultTo, val) end
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
		if !IsValid(lply) then return end
		
		if !self.ResultTo then self.ResultTo = "$envmaptint" end
		
		local val = GetCubemapStrength(self, ent, "ColourTintVec2", mat)
		if val then mat:SetVector(self.ResultTo, val) end
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
		if !IsValid(lply) then return end
		
		if !self.ResultTo then self.ResultTo = "$envmaptint" end
		
		local val = GetCubemapStrength(self, ent, "WeaponColour_DRC", mat)
		if val then mat:SetVector(self.ResultTo, val) end
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
		if !IsValid(lply) then return end
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
		if !IsValid(lply) then return end
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
			mag = wpn:GetHeat()
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
		if !IsValid(lply) then return end
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
		if !IsValid(lply) then return end
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
		elseif owner:EntIndex() == lply:GetHands():EntIndex() then
			local ply = lply
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
		if !IsValid(lply) then return end
		
		if self.FlipVar == nil then self.FlipVar = 0 end
		if self.VarMult == nil then self.VarMult = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		
		if ent:IsPlayer() then
			local ply = ent
			local hp, maxhp = DRC:Health(ply)
			local mag = hp
			local maxmag = maxhp
			
			if self.FlipVar == 0 then
				local magmath = (mag / maxmag) / 2 * self.VarMult
				ent.drc_scrollmaglerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_scrollmaglerp or magmath, magmath)
				mat:SetVector( self.ResultTo, Vector(ent.drc_scrollmaglerp, 0, 0) )
			else
				local magmath = (mag / maxmag) / 2 * self.VarMult
				ent.drc_scrollmaglerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_scrollmaglerp or magmath, magmath)
				mat:SetVector( self.ResultTo, Vector(-ent.drc_scrollmaglerp, 0, 0) )
			end
		elseif ent:IsWeapon() then
			local ply = ent:GetOwner()
			local hp, maxhp = DRC:Health(ply)
			local mag = hp
			local maxmag = maxhp
			
			if self.FlipVar == 0 then
				local magmath = (mag / maxmag) / 2 * self.VarMult
				ent.drc_scrollmaglerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_scrollmaglerp or magmath, magmath)
				mat:SetVector( self.ResultTo, Vector(ent.drc_scrollmaglerp, 0, 0) )
			else
				local magmath = (mag / maxmag) / 2 * self.VarMult
				ent.drc_scrollmaglerp = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.drc_scrollmaglerp or magmath, magmath)
				mat:SetVector( self.ResultTo, Vector(-ent.drc_scrollmaglerp, 0, 0) )
			end
		elseif ent:EntIndex() == lply:GetHands():EntIndex() or ent:EntIndex() == lply:GetViewModel(0):EntIndex() then
			local ply = lply
			local hp, maxhp = DRC:Health(ply)
			local mag = hp
			local maxmag = maxhp
			
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
		if !IsValid(lply) then return end
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
		elseif owner:EntIndex() == lply:GetHands():EntIndex() then
			local ply = lply
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
		if ent:EntIndex() == lply:GetViewModel():EntIndex() then et = "viewmodel" end
		if ent:GetParent():IsWeapon() then et = "SCKElement" end
		if ent:IsPlayer() then et = "ply" end
		
		local SID = nil
		ent.frames = 1
		local plyent = nil
		if et == "unknown" or et == "previewmodel" then
			plyent = lply
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
			plyent = lply:GetActiveWeapon():GetNWEntity("Spawner")
			if IsValid(plyent) then 
				ent.frames = plyent.DRCSprayFrames
				SID = plyent:SteamID64()
			end
		else
			plyent = lply
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
			if RealTime() > ent.spray_updatetime then
				local frame = mat:GetInt("$frame")
				if frame > ent.frames then frame = 0 end
				mat:SetInt("$frame", frame + 1)
				ent.spray_updatetime = RealTime() + fps
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
		if !IsValid(lply) then return end
		
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
		if !IsValid(lply) then return end
		local wpn = ent
		if (wpn:EntIndex() == lply:GetViewModel(0):EntIndex()) or ent:GetClass() == "class C_BaseFlex" then
			if DRC:ThirdPersonEnabled(lply) then return end
			wpn = lply:GetActiveWeapon()
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
		if !IsValid(ent) then ent = lply end
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
		if !IsValid(lply) then return end
		
		local ohp, mohp = nil, nil
		if ent:GetClass() == "drc_dummy" then ohp, mohp, ent = DRC:GetShield(lply) end
		
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

matproxy.Add( {
	name = "drc_FakePSX",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.Power = mat:GetFloat("$psx_mul")
		self.Speed = mat:GetFloat("$psx_speed")
		self.World = mat:GetFloat("$psx_world")
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then ent = Entity(0) end
		if !IsValid(lply) then return end
		
		if !self.Power then self.Power = 1 end
		if !self.Speed then self.Speed = 1 end
		if !self.World then self.World = 0 end
		
		local localvel = lply:GetVelocity()
		local localspeed = localvel:Length()
		
		local c1, c2 = ent:GetPos() + ent:OBBCenter(), lply:EyePos()
		local m1, m2 = (self.Power or 1)/10, 1
		
		ent.Distance = (math.Distance(c1.x, c1.y, c2.x, c2.y) / 50)
		
		ent.DesiredPower = m1 * m2
		
		ent.DesiredPower = math.Clamp(ent.Distance * ent.DesiredPower, 0.1, 25)
		
		if !DRC:IsCharacter(ent) && !ent.preview then
			if ent:GetVelocity() == Vector() && localvel == Vector() then ent.DesiredPower = 0 end
		elseif ent.preview then ent.DesiredPower = 0.1
		end
		
		ent.Power = Lerp(0.01, ent.Power or ent.DesiredPower, ent.DesiredPower)
		
		if !ent.psxcd then ent.psxcd = 0 end
		if !ent.psxbool then ent.psxbool = 1 end

		if CurTime() > ent.psxcd then
		--	lply:ChatPrint(ent.psxbool)
			ent.psxcd = CurTime() + 0.04
			if ent.psxbool == 0 then ent.psxbool = 1 else ent.psxbool = 0 end
		end
		
		
		if self.World < 1 then
			mat:SetInt("$treesway", ent.psxbool)
			mat:SetFloat("$treeswayheight", 0)
			mat:SetFloat("$treeswaystartheight", 0)
			mat:SetFloat("$treeswayradius", 1)
			mat:SetFloat("$treeswaystartradius", 1)
			mat:SetFloat("$treeswayspeed", 1)
			mat:SetFloat("$treeswaystrength", 0)
			mat:SetFloat("$treeswayscrumblespeed", 150 * self.Speed)
			mat:SetFloat("$treeswayscrumblestrength", ent.DesiredPower)
			mat:SetFloat("$treeswayscrumblefrequency", 20000000)
			mat:SetFloat("$treeswayfalloffexp", 2.5)
			mat:SetFloat("$treeswaystatic", 1)
		else
			local worldstrength = (self.Power * (localspeed/200))
			local worldspeed = ((self.Speed * localspeed) / 10) * self.Power
			mat:SetInt("$treesway", ent.psxbool)
			mat:SetFloat("$treeswayheight", 0)
			mat:SetFloat("$treeswaystartheight", 0)
			mat:SetFloat("$treeswayradius", 1)
			mat:SetFloat("$treeswaystartradius", 1)
			mat:SetFloat("$treeswayspeed", 1)
			mat:SetFloat("$treeswaystrength", 0)
			mat:SetFloat("$treeswayscrumblespeed", worldspeed)
			mat:SetFloat("$treeswayscrumblestrength", worldstrength)
			mat:SetFloat("$treeswayscrumblefrequency", 200000000)
			mat:SetFloat("$treeswayfalloffexp", 0)
			mat:SetFloat("$treeswaystatic", 1)

		end
	end
} )