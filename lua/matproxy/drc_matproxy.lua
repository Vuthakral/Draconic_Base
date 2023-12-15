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
DRC.ReflectionModifier = 1

function DRC:CubemapCheck()
	if (DRC:DebugModeEnabled() && GetConVar("cl_drc_debug_cubefallbacks"):GetFloat() == 1) or (GetConVar("cl_drc_accessibility_amduser"):GetFloat() == 1) then return false end
	if #drc_cubesamples != 0 then return true else return false end
end

local addict = achievements.GetCount(5) >= achievements.GetGoal(5)

if CLIENT then
	hook.Add("Think", "Draconic_Base_Matproxy_Clientside_Think_Please_Just_Trust_Me_It_Isnt_Laggy", function()
		if !lply or !IsValid(lply) or lply != LocalPlayer() then lply = LocalPlayer() end
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
	if !IsValid(src) then src = LocalPlayer() end
	if !lply then lply = LocalPlayer() end
	if !lply or !IsValid(lply) then return Vector() end
	local col = Vector(0.5, 0.5, 0.5)
	local translation = {
		["PlayerColour_DRC"] = "Player",
		["WeaponColour_DRC"] = "Weapon",
		["EyeTintVec"] = "Eye",
		["EnergyTintVec"] = "Energy",
		["ColourTintVec1"] = "Tint1",
		["ColourTintVec2"] = "Tint2",
		["Entity"] = "$color2",
		["Grunge"] = "Grunge",
		["None"] = Vector(1, 1, 1)
	}
	if channel == "Entity" then
		local vals = DRC:GetColours(src, true)
		local pull = translation[channel]
		if vals then col = vals[pull] end
	elseif channel == "Grunge" then
		local vals, pull
		if (src.Preview == true or src.preview == true) or (src:EntIndex() == lply:GetHands():EntIndex()) then
			vals = DRC:GetColours(lply, true)
			pull = translation[channel]
			if vals then col = vals[pull] end
		else
			vals = DRC:GetColours(src, true)
			pull = translation[channel]
			if vals then col = vals[pull] end
		end
		return col
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

local function QueuePoll(ent)
	local fps = 1/RealFrameTime()
	local nexttick = RealTime() + (0.2 + (math.Rand(-0.1, 0.1)))
	if fps < 40 && fps > 21 then nexttick = RealTime() + (1 + (math.Rand(-0.5, 0.25))) end
	if fps < 20 then nexttick = RealTime() + (1 + (math.Rand(-1, 2))) end
	if ent.DRCLightPolling["Realtime"] == true then nexttick = RealTime() + 0.0333 end -- light polling @ 30tps; used for viewmodels & c_hands
	ent.DRCLightPolling["LightPollTime"] = nexttick
end
	
local function CalcPoll(ent)
	local pos
	if ent:EntIndex() == lply:GetHands():EntIndex() or ent:EntIndex() == lply:GetViewModel():EntIndex() then
		pos = lply:EyePos()
	else
		pos = ent:GetPos() + ent:OBBCenter()
		if game.SinglePlayer() && ent:IsWeapon() && !DRC:ThirdPersonEnabled(lply) && ent:GetOwner() == lply then pos = lply:EyePos() end
	end
	
	local lightlevel = render.GetLightColor(pos)
		local lla = (lightlevel.x + lightlevel.y + lightlevel.z) / 3
	ent.DRCLightPolling["LightTint"] = lightlevel
	return lightlevel, lla
end

local function LightPollEntity(ent, mat)
	if !mat then mat = "None" end
	if !ent.DRCLightPolling then ent.DRCLightPolling = {} end
	if !ent.DRCLightPolling["Realtime"] then ent.DRCLightPolling["Realtime"] = false end
	if !ent.DRCLightPolling["LightPollTime"] then ent.DRCLightPolling["LightPollTime"] = 0 end
	if !ent.DRCLightPolling["LightPollLastPos"] then ent.DRCLightPolling["LightPollLastPos"] = ent:GetPos() end
	if !ent.DRCLightPolling[mat] then ent.DRCLightPolling[mat] = "" end
	
	if ent.DRCInitialLightPoll == false then QueuePoll(ent) CalcPoll(ent) ent.DRCInitialLightPoll = true end
	if RealTime() < ent.DRCLightPolling["LightPollTime"] then return end
	if ent:GetPos() == ent.DRCLightPolling["LightPollLastPos"] then QueuePoll(ent) return
	else ent.DRCLightPolling["LightPollLastPos"] = ent:GetPos() end
	QueuePoll(ent)
	CalcPoll(ent)
	
	local ll, lla = CalcPoll(ent)
	return ll, lla
end

--[[
local adjustedmaps = {}
table.Inherit(adjustedmaps, drc_singlecubemaps)
table.Inherit(adjustedmaps, drc_badlightmaps)
table.Inherit(adjustedmaps, drc_fullbrightcubemaps)
local function GetAdjustedCubeStrength()
end ]]

local function GetCubemapStrength(mat, ent, channel, imat, realtime)
	if GetConVar("cl_drc_debugmode"):GetFloat() != 0 && GetConVar("cl_drc_debug_hideshaderfixes"):GetFloat() == 1 then return(Vector(1,1,1)) end
	if CurTime() < ent:GetCreationTime() + 0.03 then return Vector() end
	if !IsValid(ent) then return Vector() end
	local envmaps = DRC:CubemapCheck()
	
	local blacklist = {
		["drc_csshadowmodel"] = true,
	}
	if blacklist[ent:GetClass()] then return Vector() end
	if imat:GetFloat("$cubemaplightingsaturation") then mat.Saturation = imat:GetFloat("$cubemaplightingsaturation") mat.Saturation = 1 end
	if imat:GetFloat("$cmlightsat") then mat.Saturation = imat:GetFloat("$cmlightsat") else mat.Saturation = 1 end
	
	mat.TintVector 			= imat:GetVector("$cmtint") or imat:GetVector("$cubemaptint")
	mat.PowerFloat 			= imat:GetFloat("$cmpower") or imat:GetFloat("$cubemappower")
	mat.MinFloat			= imat:GetFloat("$cmmin") or imat:GetFloat("$cubemapmin")
	mat.MaxFloat			= imat:GetFloat("$cmmax") or imat:GetFloat("$cubemapmax")
	mat.HDRCorrectionLevel	= imat:GetFloat("$cmhdr") or imat:GetFloat("$cubemapHDRMul")
	mat.LDRCorrectionLevel	= imat:GetFloat("$cmldr") or imat:GetFloat("$cubemapLDRMul")
	if envmaps == false then
		mat.TintVector = imat:GetVector("$cmtint_fb") or imat:GetVector("$cubemaptintfallback") or mat.TintVector
		mat.PowerFloat = imat:GetFloat("$cmpower_fb") or imat:GetFloat("$cubemappowerfallback") or mat.PowerFloat
		mat.MinFloat = imat:GetFloat("$cmmin_fb") or imat:GetFloat("$cubemapminfallback") or mat.MinFloat
		mat.MaxFloat = imat:GetFloat("$cmmax_fb") or imat:GetFloat("$cubemapmaxfallback") or mat.MaxFloat
		mat.HDRCorrectionLevel = imat:GetFloat("$cmhdr_fb") or imat:GetFloat("$cubemapHDRMulfallback") or mat.HDRCorrectionLevel
		mat.LDRCorrectionLevel = imat:GetFloat("$cmldr_fb") or imat:GetFloat("$cubemapLDRMulfallback") or mat.LDRCorrectionLevel
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
	if !ent.DRCReflectionTints[name]["EnvmapUpdateTime"] then ent.DRCReflectionTints[name]["EnvmapUpdateTime"] = 0 end
	if !ent.DRCReflectionTints[name]["Envmap"] then ent.DRCReflectionTints[name]["Envmap"] = "" end
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
	
	local function ReturnEnvmap()
		if envmaps == false then
			ent.DRCReflectionTints[name]["Envmap"] = imat:GetString("$envmapstatic") or imat:GetString("$envmapfallback") or "models/vuthakral/defaultcubemap"
		else
			ent.DRCReflectionTints[name]["Envmap"] = imat:GetString("$envmapstatic") or imat:GetString("$envmapfallback") or "models/vuthakral/defaultcubemap"
		end
	end
	
	if (RealTime() > ent.DRCReflectionTints[name]["EnvmapUpdateTime"]) then
		local fps = 1/RealFrameTime()
		local nexttick = RealTime() + (0.5 + (math.Rand(-0.25, 0.5)))
		if fps < 40 && fps > 21 then nexttick = RealTime() + (1 + (math.Rand(-0.3, 0.5))) end
		if fps < 20 then nexttick = RealTime() + (2 + (math.Rand(0, 3))) end
		ent.DRCReflectionTints["EnvmapUpdateTime"] = nexttick
		if envmaps == false then ReturnEnvmap() end
	end
--	local cubemap = ent.DRCReflectionTints[name]["Envmap"] or ""
	
	if envmaps == false && imat:GetTexture("$envmap") != ent.DRCReflectionTints[name]["Envmap"] then imat:SetTexture("$envmap", ent.DRCReflectionTints[name]["Envmap"]) end
	local m2 = 1
	if ent.DRCReflectionTints[name]["Envmap"] == "models/vuthakral/defaultcubemap" then m2 = 0.05 end
	
	if ent.Preview == true or ent.preview == true then
		local mul = Vector(1, 1, 1)
		if !HDR then mul = (10 * mat.LDRCorrectionLevel) end
		col = (mat.TintVector * mat.PowerFloat * GetColour(lply, channel) * mul) * DRC.WeathermodScalar * DRC.MapInfo.MapAmbient
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
		elseif ent:EntIndex() == lply:GetViewModel():EntIndex() then
			local newent = lply:GetActiveWeapon()
			ent.DRCLightPolling["Realtime"] = true
			newent.DRCLightPolling["Realtime"] = true
			if !IsValid(newent) then return Vector() end
			if !newent.DRCReflectionTints then newent.DRCReflectionTints = {} end
			col = GetColour(newent, channel)
		else
			col = GetColour(ent, channel)
		end
		col = col * Vector(ll.r, ll.g, ll.b) * mat.HDRCorrectionLevel
		col = col * (Vector(DRC.MapInfo.MapAmbient.r + 1, DRC.MapInfo.MapAmbient.g + 1, DRC.MapInfo.MapAmbient.b +1))
		return col
	end
	
	if (RealTime() > ent.DRCReflectionTints[name]["UpdateTime"]) then
		local fps = 1/RealFrameTime()
		local nexttick = RealTime() + (0.2 + (math.Rand(-0.1, 0.1)))
		if fps < 40 && fps > 21 then nexttick = RealTime() + (1 + (math.Rand(-0.5, 0.25))) end
		if fps < 20 then nexttick = RealTime() + (2 + (math.Rand(-1, 2))) end
		ent.DRCReflectionTints.Stored[name][channel] = (ReturnValue() * LMCor * DRC.WeathermodScalar) * (DRC.WeathermodScalar * mat.TintVector) * mat.PowerFloat
		ent.DRCReflectionTints[name]["UpdateTime"] = nexttick
	end
	
	ent.DRCReflectionTints[name][channel] = Lerp(RealFrameTime() * (mat.LerpPower * 2.5), ent.DRCReflectionTints[name][channel] or ent.DRCReflectionTints.Stored[name][channel], ent.DRCReflectionTints.Stored[name][channel])
	local avg = (ent.DRCReflectionTints[name][channel].x + ent.DRCReflectionTints[name][channel].y + ent.DRCReflectionTints[name][channel].z) / 3
	avg = avg * m2
	local final = (LerpVector(mat.Saturation, Vector(avg, avg, avg), ent.DRCReflectionTints[name][channel]) * mat.TintVector)
	
	return final * DRC.ReflectionModifier * m2
end

matproxy.Add( {
	name = "drc_EnvmapFallback",
	init = function( self, mat, values )
		self.Envmap = mat:GetString("$envmapfallback")
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		if !IsValid(lply) then return end
		
	--	if self.OGEnvmap == nil then self.OGEnvmap = mat:GetTexture("$envmap") end
	--	if self.Envmap == nil then self.Envmap = "env_cubemap" end
		
	--	if DRC:CubemapCheck() == false then
	--		mat:SetTexture( "$envmap", self.Envmap )
	--	else
	--		mat:SetTexture( "$envmap", self.OGEnvmap )
	--	end
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
		if !IsValid(ent) then ent = LocalPlayer() end
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
		self.ResultTo2 = values.resultvar2
		self.ResultTo3 = values.resultvar3
		self.PowerFloat = mat:GetFloat("$energy_Mul")
		self.MinFloat = mat:GetVector("$energy_Min")
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		local col = nil
		
	--	if addict then
	--		mat:SetVector(self.ResultTo, Vector(TimedSin(2.75, 0.5, 1, 0), TimedSin(1.83, 0.5, 1, 0), TimedSin(0.916, 0.5, 1, 0)))	
	--	return end
		if !self.PowerFloat then self.PowerFloat = 1 end
		if !self.MinFloat then self.MinFloat = Vector(0,0,0) end
		if self.ResultTo == nil then self.ResultTo = "$color2" end
		
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
		col = Vector(math.Clamp(col.x, self.MinFloat.x, 1), math.Clamp(col.y, self.MinFloat.y, 1), math.Clamp(col.z, self.MinFloat.z, 1))
		mat:SetVector( self.ResultTo, col * deathflicker )	
		if self.ResultTo2 then mat:SetVector( self.ResultTo2, col * deathflicker ) end
		if self.ResultTo3 then mat:SetVector( self.ResultTo3, col * deathflicker ) end
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
		if self.ResultTo == nil then self.ResultTo = "$color2" end
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
		if self.ResultTo == nil then self.ResultTo = "$color2" end
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
		if (!IsValid(owner) or !DRC:IsCharacter(owner)) then return end
		local wpn = owner:GetActiveWeapon()
		if (!IsValid(wpn) or !wpn:IsWeapon()) then return end
		if !wpn:GetCharge() then return end
		local charge = wpn:GetCharge()
		
		if charge == nil then return end
		
		ent.blendvec = LerpVector(charge, self.MinVec, self.MaxVec) * self.MulInt / 500
		
		mat:SetVector( self.ResultTo, ent.blendvec )
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
		
		ent.chargelerp = Lerp(RealFrameTime() * 2.5, ent.chargelerp or charge, charge)
		
		if charge == nil then return end
		
		local blendvec = LerpVector(ent.chargelerp, self.MinVec, self.MaxVec) * self.MulInt / 100
		
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
		local val = false
		if wepn:GetNWBool("Readied") == true then val = false end
		if wepn:GetNWBool("Passive") == true then val = true end
		
		if wepn.Loading == true then val = true end
		if wepn.ManuallyReloading == true then val = false end
		
		local co = 0
		if val == true then co = 1 else co = 0 end
		
		if self.CountInspect >= 1 then
			if co == 0 then
				if wepn.Inspecting == true then co = 1 else co = 0 end
			end
		end
		
		self.loadinglerp = Lerp(RealFrameTime() * self.LerpSpeed, self.loadinglerp or co, co)
		
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
		self.TintBool = mat:GetFloat("$rimlightdotint")
		self.LerpPower = mat:GetFloat("$rimlight_ls")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(lply) then return end
		local owner = ent
		if !IsValid( owner ) then return end
		
		if self.PowerFloat == nil then self.PowerFloat = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		if self.TintBool == nil then self.TintBool = 0 end
		
		if ent.Preview == true or ent.preview == true then
			local col = mat:GetVector("$color2")
			local calc = (col.x + col.y + col.z) / 3
			mat:SetFloat("$rimlightboost", self.PowerFloat/10 * calc)
		else			
			local name = mat:GetName()
			if ent:EntIndex() == lply:GetViewModel():EntIndex() then ent = lply:GetActiveWeapon() end
			if !IsValid(ent) then return end 
			if !ent.DRCScalingRimLightParams then ent.DRCScalingRimLightParams = {} end
			if !ent.DRCScalingRimLightParams["Value"] then ent.DRCScalingRimLightParams["Value"] = 0 end
			if !ent.DRCScalingRimLightParams[name] then ent.DRCScalingRimLightParams[name] = {} end
			if !ent.DRCScalingRimLightParams[name]["Value"] then ent.DRCScalingRimLightParams[name]["Value"] = 0 end
			if !ent.DRCScalingRimLightParams[name]["UpdateTime"] then ent.DRCScalingRimLightParams[name]["UpdateTime"] = 0 end
			if !ent.DRCScalingRimLightParams[name]["RimTint"] then ent.DRCScalingRimLightParams[name]["RimTint"] = 1 end
			if !ent.DRCScalingRimLightParams.Stored then ent.DRCScalingRimLightParams.Stored = {} end
			if !ent.DRCScalingRimLightParams.Stored[name] then ent.DRCScalingRimLightParams.Stored[name] = {} end
			if !ent.DRCScalingRimLightParams.Stored[name]["Value"] then ent.DRCScalingRimLightParams.Stored[name]["Value"] = 0 end
			if !ent.DRCScalingRimLightParams.Stored[name]["UpdateTime"] then ent.DRCScalingRimLightParams.Stored[name]["UpdateTime"] = 0 end
			
			
			local weatheravg = ((DRC.WeathermodScalar.x + DRC.WeathermodScalar.y + DRC.WeathermodScalar.z)/3)
			
			LightPollEntity(ent)
			if !ent.DRCLightPolling then LightPollEntity(ent) return end
			if !ent.DRCLightPolling.LightTint then LightPollEntity(ent) return end
			
			local ll = ent.DRCLightPolling["LightTint"]
			local lla = (ll.r + ll.g + ll.b) /3
				
			if lla then
				ent.DRCScalingRimLightParams["Value"] = (lla * self.PowerFloat) * weatheravg
				if !HDR then ent.DRCScalingRimLightParams["Value"] = ent.DRCScalingRimLightParams["Value"] * 0.117 end
			end
			
			if !realtime && (RealTime() > ent.DRCScalingRimLightParams[name]["UpdateTime"]) then
				local fps = 1/RealFrameTime()
				local nexttick = RealTime() + (0.2 + (math.Rand(-0.1, 0.1)))
				if fps < 40 && fps > 21 then nexttick = RealTime() + (1 + (math.Rand(-0.5, 0.25))) end
				if fps < 20 then nexttick = RealTime() + (1 + (math.Rand(-1, 2))) end
				
				if self.TintBool == 1 then
					local col = mat:GetVector("$color2")
					local calc = (col.x + col.y + col.z) / 3
					ent.DRCScalingRimLightParams[name]["RimTint"] = calc
				else
					ent.DRCScalingRimLightParams[name]["RimTint"] = 1
				end
				
				ent.DRCScalingRimLightParams.Stored[name]["Value"] = ent.DRCScalingRimLightParams["Value"] * ent.DRCScalingRimLightParams[name]["RimTint"]
				ent.DRCScalingRimLightParams[name]["UpdateTime"] = nexttick
			end

			ent.DRCScalingRimLightParams[name]["Value"] = Lerp(RealFrameTime() * (self.LerpPower * 2.5), ent.DRCScalingRimLightParams[name]["Value"] or ent.DRCScalingRimLightParams.Stored[name]["Value"], ent.DRCScalingRimLightParams.Stored[name]["Value"])
			
			if GetConVar("cl_drc_debugmode"):GetFloat() != 0 && GetConVar("cl_drc_debug_hideshaderfixes"):GetFloat() == 1 then ent.DRCScalingRimLightParams[name]["Value"] = 1 end
			
			if HDR then
				mat:SetFloat( "$rimlightboost", ent.DRCScalingRimLightParams[name]["Value"] )
			else
				mat:SetFloat( "$rimlightboost", ent.DRCScalingRimLightParams[name]["Value"] )
			end
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
		self.ResultTo2 = values.resultvar2
		self.ResultTo3 = values.resultvar3
		self.TintVector = mat:GetVector("$cubemaptint")
		self.PowerFloat = mat:GetFloat("$cubemappower")
		self.MinFloat	= mat:GetFloat("$cubemapmin")
		self.MaxFloat	= mat:GetFloat("$cubemapmax")
		self.HDRCorrectionLevel	= mat:GetFloat("$cubemapHDRMul")
		self.LDRCorrectionLevel	= mat:GetFloat("$cubemapLDRMul")
		self.LerpPower	= mat:GetFloat("$cubemap_ls")
		self.Envmap = mat:GetString("$envmapfallback")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(lply) then return end
		local owner = ent
		if !IsValid( owner ) then return end
		if !self.ResultTo then self.ResultTo = "$envmaptint" end
		
		local val = GetCubemapStrength(self, ent, "None", mat)
		if val then 
			mat:SetVector(self.ResultTo, val)
			if self.ResultTo2 then mat:SetVector(self.ResultTo2, val) end
			if self.ResultTo3 then mat:SetVector(self.ResultTo3, val) end
		end
	end
} )

matproxy.Add( {
	name = "drc_ReflectionTint_EntityColour",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.ResultTo2 = values.resultvar2
		self.ResultTo3 = values.resultvar3
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
		if val then 
			mat:SetVector(self.ResultTo, val)
			if self.ResultTo2 then mat:SetVector(self.ResultTo2, val) end
			if self.ResultTo3 then mat:SetVector(self.ResultTo3, val) end
		end
	end
} )

matproxy.Add( {
	name = "drc_ReflectionTint_PlayerColour",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.ResultTo2 = values.resultvar2
		self.ResultTo3 = values.resultvar3
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
		if val then 
			mat:SetVector(self.ResultTo, val)
			if self.ResultTo2 then mat:SetVector(self.ResultTo2, val) end
			if self.ResultTo3 then mat:SetVector(self.ResultTo3, val) end
		end
	end
} )

matproxy.Add( {
	name = "drc_ReflectionTint_EyeColour",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.ResultTo2 = values.resultvar2
		self.ResultTo3 = values.resultvar3
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
		if val then 
			mat:SetVector(self.ResultTo, val)
			if self.ResultTo2 then mat:SetVector(self.ResultTo2, val) end
			if self.ResultTo3 then mat:SetVector(self.ResultTo3, val) end
		end
	end
} )

matproxy.Add( {
	name = "drc_ReflectionTint_PlayerTint1",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.ResultTo2 = values.resultvar2
		self.ResultTo3 = values.resultvar3
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
		if val then 
			mat:SetVector(self.ResultTo, val)
			if self.ResultTo2 then mat:SetVector(self.ResultTo2, val) end
			if self.ResultTo3 then mat:SetVector(self.ResultTo3, val) end
		end
	end
} )

matproxy.Add( {
	name = "drc_ReflectionTint_PlayerTint2",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.ResultTo2 = values.resultvar2
		self.ResultTo3 = values.resultvar3
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
		if val then 
			mat:SetVector(self.ResultTo, val)
			if self.ResultTo2 then mat:SetVector(self.ResultTo2, val) end
			if self.ResultTo3 then mat:SetVector(self.ResultTo3, val) end
		end
	end
} )

matproxy.Add( {
	name = "drc_ReflectionTint_WeaponColour",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.ResultTo2 = values.resultvar2
		self.ResultTo3 = values.resultvar3
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
		if val then 
			mat:SetVector(self.ResultTo, val)
			if self.ResultTo2 then mat:SetVector(self.ResultTo2, val) end
			if self.ResultTo3 then mat:SetVector(self.ResultTo3, val) end
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
		if !IsValid(lply) then return end
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local wpn = owner:GetActiveWeapon()
		if !IsValid(wpn) then return end
		
		if !self.FlipVar then self.FlipVar = 0 end
		if !self.VarMult then self.VarMult = 1 end
		if !self.LerpPower then self.LerpPower = 1 end
		
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
		if self.ResultTo2 == nil then self.ResultTo2 = "" end
		if self.ResultTo3 == nil then self.ResultTo3 = "" end

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
		if !ent.DRCShieldVis then ent.DRCShieldVis = 0 end
		
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
		self.Framerate = mat:GetFloat("$psx_fps")
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then ent = Entity(0) end
		if !IsValid(lply) then return end
		
		if !self.Power then self.Power = 1 end
		if !self.Speed then self.Speed = 1 end
		if !self.World then self.World = 0 end
		if !self.Framerate then self.Framerate = 24 end
		
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
		if !ent.PSXCycle then ent.PSXCycle = 0 end
		if !ent.PSXTick then ent.PSXTick = 0 end
		
		if CurTime() > ent.psxcd then
			local fps = 1/self.Framerate
			ent.psxcd = CurTime() + fps
			if ent.psxbool == 0 then ent.psxbool = 1 else ent.psxbool = 0 end
			
			local mspd, mul, amount
			if ent.preview == true or ent.Preview == true then
				amount = 0.0052
			elseif ent:IsPlayer() then
				mspd = ent:GetRunSpeed() - (ent:GetRunSpeed() * 0.25)
				if ent:KeyDown(IN_WALK) then mspd = ent:GetSlowWalkSpeed() * 3.75 end
				if ent:KeyDown(IN_DUCK) then mspd = mspd * 1.5 end
				mul = Lerp(localspeed/64000, 0, mspd) * 2.5
				amount = (fps * mul)
			else
				amount = fps
			end
			
			ent.PSXCycle = ent.PSXCycle + amount or 0 + amount
			ent.PSXTick = ent.PSXTick + amount or 0 + amount
		end
		
		if DRC:FloorDist(ent) < 10 or (ent.preview == true or ent.Preview == true) then ent:SetCycle(ent.PSXCycle) end
		
		if self.World < 1 then
			local str = ent.DesiredPower * self.Power
			mat:SetInt("$treesway", ent.psxbool)
			mat:SetFloat("$treeswayheight", 0)
			mat:SetFloat("$treeswaystartheight", 0)
			mat:SetFloat("$treeswayradius", 1)
			mat:SetFloat("$treeswaystartradius", 1)
			mat:SetFloat("$treeswayspeed", 1)
			mat:SetFloat("$treeswaystrength", 0)
			mat:SetFloat("$treeswayscrumblespeed", 10 * self.Speed)
			mat:SetFloat("$treeswayscrumblestrength", str)
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

-----------------------------------------------------------------------------------------------------------------------
-- Nothing below is on the wiki yet because it's very unfinished & unstable.

local matlerps = {
	["Linear"] = "L",
	["InBack"] = math.ease.InBack,
	["InBounce"] = math.ease.InBounce,
	["InCirc"] = math.ease.InCirc,
	["InCubic"] = math.ease.InCubic,
	["InElastic"] = math.ease.InElastic,
	["InExpo"] = math.ease.InExpo,
	["InQuad"] = math.ease.InQuad,
	["InQuart"] = math.ease.InQuart,
	["InQuint"] = math.ease.InQuint,
	["InSine"] = math.ease.InSine,
	["InOutBack"] = math.ease.InOutBack,
	["InOutBounce"] = math.ease.InOutBounce,
	["InOutCirc"] = math.ease.InOutCirc,
	["InOutCubic"] = math.ease.InOutCubic,
	["InOutElastic"] = math.ease.InOutElastic,
	["InOutExpo"] = math.ease.InOutExpo,
	["InOutQuad"] = math.ease.InOutQuad,
	["InOutQuart"] = math.ease.InOutQuart,
	["InOutQuint"] = math.ease.InOutQuint,
	["InOutSine"] = math.ease.InOutSine,
	["OutBack"] = math.ease.OutBack,
	["OutBounce"] = math.ease.OutBounce,
	["OutCirc"] = math.ease.OutCirc,
	["OutCubic"] = math.ease.OutCubic,
	["OutElastic"] = math.ease.OutElastic,
	["OutExpo"] = math.ease.OutExpo,
	["OutQuad"] = math.ease.OutQuad,
	["OutQuart"] = math.ease.OutQuart,
	["OutQuint"] = math.ease.OutQuint,
	["OutSine"] = math.ease.OutSine,
}

local function Read(mat, ent)
	local input, mini, mid, midpoint, maxi, mod, funcmax = mat.Input, Vector(mat.Min), Vector(mat.Mid), mat.MidPoint, Vector(mat.Max), mat.Mod, mat.FuncMax
	local val = Vector()
	if !mid then mid = LerpVector(0.5, mini, maxi) end
	
	local function calc(frac)
		local function Ease(fr, mi, ma)
			local func = matlerps[mat.FuncEase]
			return Lerp(func(fr), mi, ma)
		end
	
		local midfrac = math.Clamp(math.abs(0.5+frac), 0, 1) * frac
		local newmini = LerpVector(midfrac, mini, mid*5)
		local newval = LerpVector(frac, newmini, maxi)
		
		if mat.FuncEase != "Linear" then newval = Vector(Ease(frac, newmini.x, maxi.x), Ease(frac, newmini.y, maxi.y), Ease(frac, newmini.z, maxi.z)) end
		
		return newval
	end
	
	if ent:IsWeapon() then
		if input == "clip1" then val = calc(math.Clamp(ent:Clip1()/ent:GetMaxClip1(), 0, 1))
		elseif input == "heat" then val = calc(math.Clamp(ent:GetHeat()/ent:GetMaxHeat(), 0, 1))
		elseif input == "charge" then val = calc(math.Clamp(ent:GetCharge()/ent:GetMaxCharge(), 0, 1))
		elseif input == "velocity" then
			local own = ent:GetOwner()
			if !own then val = calc(math.Clamp(ent:GetVelocity():Length(), 1, 999999)/funcmax, 0, 1) -- weapon exists in the world
			else val = calc(math.Clamp(ent:GetOwner():GetVelocity():Length(), 1, 999999)/funcmax, 0, 1) -- weapon is held by an entity
			end
		end
		return val
	end
	
	if DRC:IsVehicle(ent) then
		if ent:GetOwner().LFS then 
			ent = ent:GetOwner()
			if input == "rpm" then
				val = calc(math.Clamp(math.abs(ent:GetRPM()/ent:GetMaxRPM()), 0, 1))
			end
		elseif ent:GetOwner():GetClass() == "gmod_sent_vehicle_fphysics_base" then
			if input == "rpm" then
				val = calc(math.Clamp(math.abs(ent:GetOwner():GetRPM()/funcmax), 0, 1))
			end
		end
	end
	
	if input == "colour" then val = GetPlayerColour(ent, mod)
	elseif input == "time" then
		local r,g,b
		r = TimedSin(1/mod, maxi.x, mini.x, 0)
		g = TimedSin(1/mod, maxi.y, mini.y, 0)
		b = TimedSin(1/mod, maxi.z, mini.z, 0)
		val = Vector(r,g,b)
	elseif input == "health" then local hp, mhp = DRC:Health(ent) val = calc(math.Clamp(hp/mhp, 0, 1))
	elseif input == "armour" then print(ent) local ap = ent:Armor() map = ent:GetMaxArmor() val = calc(math.Clamp(ap/map, 0, 1))
	elseif input == "shield" then local sp, msp = DRC:GetShield(ent) val = calc(math.Clamp(sp/msp, 0, 1))
	elseif input == "lightlevel" then val = LightPollEntity(ent)
	elseif input == "velocity" then
		if ent:IsNPC() or ent:IsNextBot() then -- bruh
			val = calc(math.Clamp(math.Clamp(ent:GetVelocity():Length(),1, 999999)/funcmax, 0, 1))
		elseif ent.GetVehicle && !IsValid(ent:GetVehicle()) or ent:IsVehicle() then -- regular entities or actual vehicles
			val = calc(math.Clamp(math.Clamp(ent:GetVelocity():Length(),1, 999999)/funcmax, 0, 1))
		elseif !ent.GetVehicle && (ent.LFS or ent.LVS) then -- contexts are weird don't ask me why
			val = calc(math.Clamp(math.Clamp(ent:GetVelocity():Length(),1, 999999)/funcmax, 0, 1))
		elseif ent.GetVehicle && !IsValid(ent:GetVehicle():GetOwner()) then -- entity in normal vehicle
			val = calc(math.Clamp(math.Clamp(ent:GetVehicle():GetVelocity():Length(),1, 999999)/funcmax, 0, 1))
		elseif ent.GetVehicle && ent:GetVehicle():GetOwner().LFS or ent:GetVehicle():GetOwner().LVS then -- entity in scripted vehicle seat
			val = calc(math.Clamp(math.Clamp(ent:GetVehicle():GetOwner():GetVelocity():Length(),1, 999999)/funcmax, 0, 1))
		end
	elseif input == "nwbool" then
		local b = ent:GetNWBool(mod)
		if b == true then val = Vector(1) else val = Vector(0) end
	elseif input == "nwvector" then val = ent:GetNWVector(mod)
	elseif input == "nwfloat" then val = ent:GetNWFloat(mod)
	elseif input == "nwint" then val = ent:GetNWInt(mod)
	elseif input == "nwangle" then val = ent:GetNWAngle(mod)
	elseif input == "nwstring" then val = ent:GetNWString(mod)
	end
	
	return val
end

local matfuncs = {
	["read"] = Read,
}

local matreturns = { -- 0 vector, 1 string, 2 bool, 3 number
	["$basetexture"] = 1,
	["$bumpmap"] = 1,
	["$normalmap"] = 1,
	["$color"] = 0,
	["$color2"] = 0,
	["$phong"] = 2,
	["$phongexponent"] = 3,
	["$phongboost"] = 3,
	["$phongtint"] = 0,
	["$phongfresnelranges"] = 0,
	["$phongexponenttexture"] = 1,
	["$phongexponentfactor"] = 3,
	["$phongdisablehalflambert"] = 2,
	["$phongalbedotint"] = 2,
	["$phongalbedoboost"] = 3,
	["$basemapalphaenvmapmask"] = 2,
	["$normalmapalphaenvmapmask"] = 2,
	["$envmap"] = 1,
	["$envmaptint"] = 0,
	["$rimlight"] = 2,
	["$rimlightexponent"] = 3,
	["$rimlightboost"] = 3,
	["$cloakpassenabled"] = 2,
	["$cloakfactor"] = 3,
	["$cloakcolortint"] = 0,
	["$refractamount"] = 3,
	-- These few below technically don't exist, but are the most common used for translations
	["$angle"] = 3,
	["$translate"] = 0,
	["$center"] = 0,
	["$offset"] = 3,
	-- Draconic parameters beyond this point
	["$cmpower"] = 0,
	["$cmtint"] = 0,
	["$rimlightpower"] = 3,
}

local function ReturnVal(info, val, mat)
	local numb = matreturns[info.ResultTo]
	if numb == 0 then mat:SetVector(info.ResultTo, Vector(val * info.Mul1))
	elseif numb == 1 then mat:SetString(info.ResultTo, val * info.Mul1)
	elseif numb == 2 or numb == 3 then mat:SetFloat(info.ResultTo, val.x * info.Mul1)
	end
	
	if matreturns[info.ResultTo2] then
		numb = matreturns[info.ResultTo2]
		if numb == 0 then mat:SetVector(info.ResultTo2, Vector(val * info.Mul2))
		elseif numb == 1 then mat:SetString(info.ResultTo2, val * info.Mul2)
		elseif numb == 2 or numb == 3 then mat:SetFloat(info.ResultTo2, val.x * info.Mul2)
		end
	end
	
	if matreturns[info.ResultTo3] then
		numb = matreturns[info.ResultTo3]
		if numb == 0 then mat:SetVector(info.ResultTo3, Vector(val * info.Mul3))
		elseif numb == 1 then mat:SetString(info.ResultTo3, val * info.Mul3)
		elseif numb == 2 or numb == 3 then mat:SetFloat(info.ResultTo3, val.x * info.Mul3)
		end
	end
end

local function DRCFunctionInit(self, mat, values)
	self.ResultTo = values.resultvar
	self.ResultTo2 = values.resultvar2
	self.ResultTo3 = values.resultvar3
	self.Target = values.target -- self, weapon (held), vehicle (the player is in)
	self.Input = values.input
	-- General inputs: health, shield, lightlevel, colour^, velocity*, time^, nwangle, nwbool^, nwfloat^, nwint^, nwstring^, nwvector^
	-- Player-only inputs: armour
	-- Vehicle-only inputs: rpm (LFS / SimfPhys*)
	-- Weapon-only inputs: clip1, heat, charge
	self.FuncMax = values.inputmax or 1 -- * number, used for defining the maximum value for certain inputs
	self.Func = "read"
	self.FuncEase = values.ease or "Linear" -- https://wiki.facepunch.com/gmod/math.ease
	self.Mod = values.mod -- ^ number or string identifier
	self.Min = values.min or Vector(0, 0, 0) -- number or vector
	self.Mid = values.mid -- number or vector
	self.MidPoint = 0.5 -- Decimal, not yet implemented
	self.Max = values.max or Vector(1, 1, 1) -- number or vector
	self.Mul1 = values.mul1 or 1 -- number
	self.Mul2 = values.mul2 or 1 -- number
	self.Mul3 = values.mul3 or 1 -- number
end

local function DRCFunctionBind(self, mat, ent)
	if !IsValid(ent) then return end
	local ent2
	if ent == lply:GetHands() or ent == lply:GetViewModel(0) then ent2 = lply else ent2 = ent end
	if !IsValid(ent2) then return end
	if self.Target == "weapon" && !ent2:IsWeapon() then ent2 = ent2:GetActiveWeapon() end
	if self.Target == "vehicle" && !DRC:IsVehicle(ent2) && !ent:IsRagdoll() then ent2 = ent2:GetVehicle() end
	if !IsValid(ent2) then return end
	
	local func = matfuncs[self.Func]
	local val = func(self, ent2)
	ReturnVal(self, val, mat)
end

matproxy.Add({
	name = "drc_FunctionA",
	init = function( self, mat, values )
		DRCFunctionInit(self, mat, values)
	end,

	bind = function( self, mat, ent )
		DRCFunctionBind(self, mat, ent)
	end
})

matproxy.Add({
	name = "drc_FunctionB",
	init = function( self, mat, values )
		DRCFunctionInit(self, mat, values)
	end,

	bind = function( self, mat, ent )
		DRCFunctionBind(self, mat, ent)
	end
})

matproxy.Add({
	name = "drc_FunctionC",
	init = function( self, mat, values )
		DRCFunctionInit(self, mat, values)
	end,

	bind = function( self, mat, ent )
		DRCFunctionBind(self, mat, ent)
	end
})

matproxy.Add({
	name = "drc_FunctionD",
	init = function( self, mat, values )
		DRCFunctionInit(self, mat, values)
	end,

	bind = function( self, mat, ent )
		DRCFunctionBind(self, mat, ent)
	end
})

matproxy.Add({
	name = "drc_MCSkin",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		local mat2 = DRC.minecraft.skins[ent:GetNWString("VMCUserName")]
		if mat2 then
			if mat:GetTexture("$basetexture") != mat2:GetTexture("$basetexture") then mat:SetTexture("$basetexture", mat2:GetTexture("$basetexture")) end
			if mat:GetTexture("$phongexponenttexture") != mat2:GetTexture("$basetexture") then mat:SetTexture("$phongexponenttexture", mat2:GetTexture("$basetexture")) end
		end
	end
})

matproxy.Add( {
	name = "drc_PlayerGrunge",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.ResultTo2 = values.resultvar2
		self.ResultTo3 = values.resultvar3
		self.Mul1 = values.max1
		self.Mul2 = values.max2
		self.Mul3 = values.max3
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(lply) then return end
		
		local val = GetPlayerColour(ent, "Grunge")
		val = val * 0.01
		
		if self.ResultTo then -- "Grunge" layer, intended for detail textures to be tied to detailblendfactor. Increase power from 0-1.
			if !self.Mul1 then self.Mul1 = 1 end
			mat:SetInt(self.ResultTo, val * self.Mul1)
		end
		
		if self.ResultTo2 then -- "Reflection" pass, intended to be tied to cmpower. Decreases power from 1-0.
			if !self.Mul2 then self.Mul2 = 1 end
			mat:SetInt(self.ResultTo2, self.Mul2 - (val * self.Mul2))
		end
		
		if self.ResultTo3 then -- "Specular" pass, intended to be tied to either phongboost or phongalbedoboost. Decreases power from 1-0.
			if !self.Mul3 then self.Mul3 = 1 end
			mat:SetInt(self.ResultTo3, self.Mul3 - (val * self.Mul3))
		end
	end
} )