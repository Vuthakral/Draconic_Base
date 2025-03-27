--[[     I M P O R T A N T

Please, go to the wiki for this, and not just rip settings from the base as reference.
http://vuthakral.com/draconic

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

local cmap = game.GetMap()
local lply = LocalPlayer()
local HDR = render.GetHDREnabled()
DRC.WeathermodScalar = Vector(1,1,1)
DRC.MatProxy = {}
DRC.ReflectionModifier = 1

function DRC:CubemapCheck()
	if (DRC:DebugModeEnabled() && GetConVar("cl_drc_debug_cubefallbacks"):GetFloat() == 1) or (GetConVar("cl_drc_accessibility_amduser"):GetFloat() == 1) then return false end
	if #drc_cubesamples > 1 then return true else return false end
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
local function GetPlayerColour(src, channel)
	local ct = RealTime()
	if !IsValid(src) then src = LocalPlayer() end
	if src:GetClass() == "drc_csplayermodel" then src = LocalPlayer() end
	if !lply then lply = LocalPlayer() end
	if !lply or !IsValid(lply) then return Vector() end
	local col = Vector(0.5, 0.5, 0.5)
	if src == lply:GetViewModel() then src = lply:GetActiveWeapon() end
	
	src.CheckCDS = src.CheckCDS or {}
	src.CheckCDS[channel] = src.CheckCDS[channel] or {}
	
	local thyme = src.CheckCDS[channel][1] or 0
	if ct - thyme < 0.25 then 
		src.CheckCDS[channel][1] = ct
		return src.CheckCDS[channel][2]
	end
	
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
		src.CheckCDS[channel][2] = col
		return col
	elseif channel && channel != "Entity" && channel != "None" then
		if (src == lply or src.Preview == true or src.preview == true) or (src:EntIndex() == lply:GetHands():EntIndex()) or (src:GetNWVector(channel, Vector(0,0,0)) == Vector(0,0,0)) then
			local vals = DRC:GetColours(lply, true)
			local pull = translation[channel]
			if vals then col = vals[pull] end
		else
			local vals = DRC:GetColours(src, true)
			local pull = translation[channel]
			if vals then col = vals[pull] end
		--	print(src, channel, col, pull, vals.Energy)
		end
	--	print(src, channel, col)
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
	local lla = (lightlevel.x + lightlevel.y + lightlevel.z) * 0.333
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
	if RealTime() < ent.DRCLightPolling["LightPollTime"] then local v = ent.DRCLightPolling["LightTint"] return v, (v.x + v.y + v.z) * 0.333 end
	if ent:GetPos() == ent.DRCLightPolling["LightPollLastPos"] then QueuePoll(ent) v = ent.DRCLightPolling["LightTint"] return v, (v.x + v.y + v.z) * 0.333
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

local function GetColour(e, c, mat)
	local colnew = GetPlayerColour(e, c)
	if colnew then
		colnew.x = math.Clamp(colnew.x, mat.MinFloat, mat.MaxFloat)
		colnew.y = math.Clamp(colnew.y, mat.MinFloat, mat.MaxFloat)
		colnew.z = math.Clamp(colnew.z, mat.MinFloat, mat.MaxFloat)
		return colnew
	end
end

local function ReturnValue(ent, col, mat, channel)
	local ll, lla = LightPollEntity(ent)
	ll = ll or ent.DRCLightPolling["LightTint"]
	if !ll then return Vector() end
	ll.r = math.Clamp(ll.r, mat.MinFloat, mat.MaxFloat)
	ll.g = math.Clamp(ll.g, mat.MinFloat, mat.MaxFloat)
	ll.b = math.Clamp(ll.b, mat.MinFloat, mat.MaxFloat)
	if ent:EntIndex() == lply:GetHands():EntIndex() then
		ent.DRCLightPolling["Realtime"] = true
		col = GetColour(lply, channel, mat)
	else
		col = GetColour(ent, channel, mat)
	end
	col = col * Vector(ll.r, ll.g, ll.b)
	if HDR then col = col * mat.HDRCorrectionLevel else col = col * mat.LDRCorrectionLevel end
--	col = col * (Vector(DRC.MapInfo.MapAmbient.r + 1, DRC.MapInfo.MapAmbient.g + 1, DRC.MapInfo.MapAmbient.b +1))
	return col * 2
end

local function isenv(str)
	if str == "env_cubemap" then return true end
	if str == "env_cubemap.hdr" then return true end
	if str == "env_cuemap.hdr" then return true end -- ty valve
	return false
end

local blacklist = {
	["drc_csshadowmodel"] = true,
	["drc_shieldmodel"] = true,
}
local function GetCubemapStrength(mat, ent, channel, imat, realtime)
	if GetConVar("cl_drc_debugmode"):GetFloat() != 0 && GetConVar("cl_drc_debug_hideshaderfixes"):GetFloat() == 1 then return(Vector(1,1,1)) end
	if !IsValid(ent) then return Vector() end
	if CurTime() < ent:GetCreationTime() + 0.03 then return Vector() end
	local envmaps = DRC:CubemapCheck()
	
	if blacklist[ent:GetClass()] then return Vector() end
	if !mat.ResultTo then return end
	
	if envmaps == false then
		mat.TintVector = imat:GetVector("$cmtint_fb") or imat:GetVector("$cubemaptintfallback") or mat.TintVector
		mat.PowerFloat = imat:GetFloat("$cmpower_fb") or imat:GetFloat("$cubemappowerfallback") or mat.PowerFloat
		mat.MinFloat = imat:GetFloat("$cmmin_fb") or imat:GetFloat("$cubemapminfallback") or mat.MinFloat
		mat.MaxFloat = imat:GetFloat("$cmmax_fb") or imat:GetFloat("$cubemapmaxfallback") or mat.MaxFloat
		mat.HDRCorrectionLevel = imat:GetFloat("$cmhdr_fb") or imat:GetFloat("$cubemapHDRMulfallback") or mat.HDRCorrectionLevel
		mat.LDRCorrectionLevel = imat:GetFloat("$cmldr_fb") or imat:GetFloat("$cubemapLDRMulfallback") or mat.LDRCorrectionLevel
	end
	
	if !ent.DRCLightPolling then 
		ent.DRCLightPolling = {
			["LightPollTime"] = 0
		}
	end	
	if !ent.DRCLightPolling["LightPollTime"] then ent.DRCLightPolling["LightPollTime"] = 0 end	
	
	local name = imat:GetName()
	if ent:EntIndex() == lply:GetActiveWeapon() then ent = lply:GetViewModel():EntIndex() end
	if !IsValid(ent) then return end
	
	if !ent.DRCReflectionTints then
		ent.DRCReflectionTints = {
			["Stored"] = {
				[name] = {},
				[channel] = Vector()
			},
			[name] = {
				["UpdateTime"] = 0,
				["EnvmapUpdateTime"] = 0,
				["Envmap"] = imat:GetString("$envmap"),
				[channel] = Vector(),
			},
		}
	end
	if !ent.DRCReflectionTints[name] then
		ent.DRCReflectionTints[name] = {
			["UpdateTime"] = 0,
			["EnvmapUpdateTime"] = 0,
			["Envmap"] = imat:GetString("$envmap"),
			[channel] = Vector(),
		}
	end
	if !ent.DRCReflectionTints.Stored[name] then
		ent.DRCReflectionTints.Stored[name] = {
			[name] = {},
			[channel] = Vector(),
		}
	end
	
	if !ent.DRCReflectionTints[name][channel] then ent.DRCReflectionTints[name][channel] = Vector() end
	if !ent.DRCReflectionTints.Stored[name][channel] then ent.DRCReflectionTints.Stored[name][channel] = Vector() end
	
	local col, m2 = Vector(), 1
	if ent.Preview == true or ent.preview == true then
		local mul = Vector(1, 1, 1)
		if !HDR then mul = (10 * mat.LDRCorrectionLevel) end
		col = (mat.TintVector * mat.PowerFloat * (GetColour(lply, channel, mat)*mat.ShiftFloat) * mul) * DRC.WeathermodScalar * DRC.MapInfo.MapAmbient
	return col end
	
	local ienv = imat:GetString("$envmap")
	
	if (RealTime() > ent.DRCReflectionTints[name]["EnvmapUpdateTime"]) then
		local fps = 1/RealFrameTime()
		local nexttick = RealTime() + (0.5 + (math.Rand(-0.25, 0.5)))
		if fps < 40 && fps > 21 then nexttick = RealTime() + (1 + (math.Rand(-0.3, 0.5))) end
		if fps < 20 then nexttick = RealTime() + (2 + (math.Rand(0, 3))) end
		ent.DRCReflectionTints[name]["EnvmapUpdateTime"] = nexttick
		if envmaps == false then
			if isenv(ienv) then
				ent.DRCReflectionTints[name]["Envmap"] = imat:GetString("$envmapfallback") or "models/vuthakral/defaultcubemap"
			else
				ent.DRCReflectionTints[name]["Envmap"] = ienv or imat:GetString("$envmapfallback") or "models/vuthakral/defaultcubemap"
			end
		end
	end
	
	if envmaps == false && (ienv == "env_cubemap" && ienv != ent.DRCReflectionTints[name]["Envmap"]) then imat:SetTexture("$envmap", ent.DRCReflectionTints[name]["Envmap"]) end
	if ent.DRCReflectionTints[name]["Envmap"] == "models/vuthakral/defaultcubemap" then if !HDR then m2 = 0.05 else m2 = 0.5 end end
	
	if (RealTime() > ent.DRCReflectionTints[name]["UpdateTime"]) then
		local fps = 1/RealFrameTime()
		local nexttick = RealTime() + (0.2 + (math.Rand(-0.1, 0.1)))
		if fps < 40 && fps > 21 then nexttick = RealTime() + (1 + (math.Rand(-0.5, 0.25))) end
		if fps < 20 then nexttick = RealTime() + (2 + (math.Rand(-1, 2))) end
		for k,v in pairs(ent.DRCReflectionTints.Stored[name]) do
			if translation[k] then
				local col = ReturnValue(ent, col, mat, k)
				ent.DRCReflectionTints.Stored[name][k] = (col * DRC.WeathermodScalar) * (DRC.WeathermodScalar * mat.TintVector) * mat.PowerFloat
			end
		end
	--	ent.DRCReflectionTints.Stored[name][channel] = (ReturnValue(ent, col, mat, channel) * DRC.WeathermodScalar) * (DRC.WeathermodScalar * mat.TintVector) * mat.PowerFloat
		ent.DRCReflectionTints[name]["UpdateTime"] = nexttick
	end
	
	ent.DRCReflectionTints[name][channel] = Lerp(RealFrameTime() * (mat.LerpPower * 2.5), ent.DRCReflectionTints[name][channel] or ent.DRCReflectionTints.Stored[name][channel], ent.DRCReflectionTints.Stored[name][channel])
	local avg = (ent.DRCReflectionTints[name][channel].x + ent.DRCReflectionTints[name][channel].y + ent.DRCReflectionTints[name][channel].z) / 3
	avg = avg * m2
	local cccorrection = Lerp(avg, 0, mat.Saturation)
	avg = Vector(avg, avg, avg)
	local fuckme = LerpVector(mat.ShiftFloat, Vector(0,0,0), ent.DRCReflectionTints[name][channel])
	local final = LerpVector(cccorrection, avg, fuckme) * mat.TintVector
	
	return final * DRC.ReflectionModifier * m2
end

matproxy.Add( {
	name = "drc_EnvmapFallback",
	init = function( self, mat, values )
	end,
	bind = function( self, mat, ent ) return end
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

local function ClampVector(vec, mins, maxes)
	local newvec = Vector()
	
	newvec.x = math.Clamp(vec.x, mins.x, maxes.x)
	newvec.y = math.Clamp(vec.y, mins.y, maxes.y)
	newvec.z = math.Clamp(vec.z, mins.z, maxes.z)
	
	return newvec
end

local function InitColours(s,m,v)
	s.ResultTo = v.resultvar or "$color2"
	s.ResultTo2 = v.resultvar2
	s.ResultTo3 = v.resultvar3
	s.Mul = m:GetVector("$drc_colourmul") or v.mul or Vector(1, 1, 1)
	s.Mul2 = m:GetVector("$drc_colourmul2") or v.mul2 or Vector(1, 1, 1)
	s.Mul3 = m:GetVector("$drc_colourmul3") or v.mul3 or Vector(1, 1, 1)
	s.Min = m:GetVector("$drc_colourmin") or Vector(0, 0, 0)
	s.Min2 = m:GetVector("$drc_colourmin2") or Vector(0, 0, 0)
	s.Min3 = m:GetVector("$drc_colourmin3") or Vector(0, 0, 0)
	s.Max = m:GetVector("$drc_colourmax") or Vector(2, 2, 2)
	s.Max2 = m:GetVector("$drc_colourmax2") or Vector(2, 2, 2)
	s.Max3 = m:GetVector("$drc_colourmax3") or Vector(2, 2, 2)
end

matproxy.Add( {
	name = "drc_PlayerColours",
	init = function( self, mat, values )
		InitColours(self, mat, values)
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		local col = GetPlayerColour(ent, "PlayerColour_DRC")
		if self.ResultTo == nil then self.ResultTo = "$color2" end
		if self.Mul == nil then self.Mul = 1 end
		if self.Mul2 == nil then self.Mul2 = 1 end
		if self.Mul3 == nil then self.Mul3 = 1 end
		
		mat:SetVector(self.ResultTo, ClampVector(col*self.Mul, self.Min, self.Max))
		if self.ResultTo2 then mat:SetVector(self.ResultTo2, ClampVector(col*self.Mul2, self.Min2, self.Max2)) end
		if self.ResultTo3 then mat:SetVector(self.ResultTo3, ClampVector(col*self.Mul3, self.Min3, self.Max3)) end
	end
} )

matproxy.Add( {
	name = "drc_PlayerColours_ForPlayer", -- This exists solely for compatibility with old content made using this proxy. Just use drc_PlayerColours.
	init = function( self, mat, values )
		InitColours(self, mat, values)
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		local col = GetPlayerColour(ent, "PlayerColour_DRC")
		if self.ResultTo == nil then self.ResultTo = "$color2" end
		if self.Mul == nil then self.Mul = 1 end
		if self.Mul2 == nil then self.Mul2 = 1 end
		if self.Mul3 == nil then self.Mul3 = 1 end
		
		mat:SetVector(self.ResultTo, ClampVector(col*self.Mul, self.Min, self.Max))
		if self.ResultTo2 then mat:SetVector(self.ResultTo2, ClampVector(col*self.Mul2, self.Min2, self.Max2)) end
		if self.ResultTo3 then mat:SetVector(self.ResultTo3, ClampVector(col*self.Mul3, self.Min3, self.Max3)) end
	end
} )

matproxy.Add( {
	name = "drc_PlayerWeaponColours",
	init = function( self, mat, values )
		InitColours(self, mat, values)
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then ent = LocalPlayer() end
		local col = GetPlayerColour(ent, "WeaponColour_DRC")
		if self.ResultTo == nil then self.ResultTo = "$color2" end
		if self.Mul == nil then self.Mul = 1 end
		if self.Mul2 == nil then self.Mul2 = 1 end
		if self.Mul3 == nil then self.Mul3 = 1 end
		
		mat:SetVector(self.ResultTo, ClampVector(col*self.Mul, self.Min, self.Max))
		if self.ResultTo2 then mat:SetVector(self.ResultTo2, ClampVector(col*self.Mul2, self.Min2, self.Max2)) end
		if self.ResultTo3 then mat:SetVector(self.ResultTo3, ClampVector(col*self.Mul3, self.Min3, self.Max3)) end
	end
} )

matproxy.Add( {
	name = "drc_WeaponColours_ForPlayer", -- This exists solely for compatibility with old content made using this proxy. Just use drc_WeaponColours.
	init = function( self, mat, values )
		InitColours(self, mat, values)
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		local col = GetPlayerColour(ent, "WeaponColour_DRC")
		if self.ResultTo == nil then self.ResultTo = "$color2" end
		if self.Mul == nil then self.Mul = 1 end
		if self.Mul2 == nil then self.Mul2 = 1 end
		if self.Mul3 == nil then self.Mul3 = 1 end
		
		mat:SetVector(self.ResultTo, ClampVector(col*self.Mul, self.Min, self.Max))
		if self.ResultTo2 then mat:SetVector(self.ResultTo2, ClampVector(col*self.Mul2, self.Min2, self.Max2)) end
		if self.ResultTo3 then mat:SetVector(self.ResultTo3, ClampVector(col*self.Mul3, self.Min3, self.Max3)) end
	end
} )

matproxy.Add( {
	name = "drc_EyeColour",
	init = function( self, mat, values )
		InitColours(self, mat, values)
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		local col = GetPlayerColour(ent, "EyeTintVec")
		if self.ResultTo == nil then self.ResultTo = "$color2" end
		if self.Mul == nil then self.Mul = 1 end
		if self.Mul2 == nil then self.Mul2 = 1 end
		if self.Mul3 == nil then self.Mul3 = 1 end
		
		mat:SetVector(self.ResultTo, ClampVector(col*self.Mul, self.Min, self.Max))
		if self.ResultTo2 then mat:SetVector(self.ResultTo2, ClampVector(col*self.Mul2, self.Min2, self.Max2)) end
		if self.ResultTo3 then mat:SetVector(self.ResultTo3, ClampVector(col*self.Mul3, self.Min3, self.Max3)) end
	end
} )

matproxy.Add( {
	name = "drc_EnergyColour",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
		self.ResultTo2 = values.resultvar2
		self.ResultTo3 = values.resultvar3
		self.PowerFloat = mat:GetFloat("$energy_Mul") or 1
		self.MinFloat = mat:GetVector("$energy_Min") or Vector()
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		local col = nil
		
	--	if addict then
	--		mat:SetVector(self.ResultTo, Vector(TimedSin(2.75, 0.5, 1, 0), TimedSin(1.83, 0.5, 1, 0), TimedSin(0.916, 0.5, 1, 0)))	
	--	return end
		if self.ResultTo == nil then self.ResultTo = "$color2" end
		
		if ent:GetClass() == "drc_shieldmodel" then
			local col = ent:GetOwner():GetNWVector("EnergyTintVec")
			if col == Vector(0, 0, 0) then col = Vector(0.3, 0.7, 1) end
			mat:SetVector(self.ResultTo, col * self.PowerFloat)
		return end
		
		ent.flickerflicker = TimedSin(2, 0.6, 1, 0)
		ent.deathflicker = TimedSin(4, 0.7, ent.flickerflicker, 0)
		if DRC:Health(ent) > 0.01 then ent.deathflicker = 1 end
		
		if IsValid(lply) && ent:EntIndex() == lply:GetHands():EntIndex() or ent.preview == true then ent.deathflicker = 1 end
		
		local col = GetPlayerColour(ent, "EnergyTintVec")
		col = Vector(math.Clamp(col.x, self.MinFloat.x, 1), math.Clamp(col.y, self.MinFloat.y, 1), math.Clamp(col.z, self.MinFloat.z, 1))
		mat:SetVector( self.ResultTo, (col * self.PowerFloat) * ent.deathflicker )	
		if self.ResultTo2 then mat:SetVector( self.ResultTo2, (col * self.PowerFloat) * ent.deathflicker ) end
		if self.ResultTo3 then mat:SetVector( self.ResultTo3, (col * self.PowerFloat) * ent.deathflicker ) end
	end
} )

matproxy.Add( {
	name = "drc_PlayerColour1",
	init = function( self, mat, values )
		InitColours(self, mat, values)
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end		
		local col = GetPlayerColour(ent, "ColourTintVec1")
		if self.ResultTo == nil then self.ResultTo = "$color2" end
		if self.Mul == nil then self.Mul = 1 end
		if self.Mul2 == nil then self.Mul2 = 1 end
		if self.Mul3 == nil then self.Mul3 = 1 end
		
		mat:SetVector(self.ResultTo, ClampVector(col*self.Mul, self.Min, self.Max))
		if self.ResultTo2 then mat:SetVector(self.ResultTo2, ClampVector(col*self.Mul2, self.Min2, self.Max2)) end
		if self.ResultTo3 then mat:SetVector(self.ResultTo3, ClampVector(col*self.Mul3, self.Min3, self.Max3)) end
	end
} )

matproxy.Add( {
	name = "drc_PlayerColour2",
	init = function( self, mat, values )
		InitColours(self, mat, values)
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		local col = GetPlayerColour(ent, "ColourTintVec2")
		
		mat:SetVector(self.ResultTo, ClampVector(col*self.Mul, self.Min, self.Max))
		if self.ResultTo2 then mat:SetVector(self.ResultTo2, ClampVector(col*self.Mul2, self.Min2, self.Max2)) end
		if self.ResultTo3 then mat:SetVector(self.ResultTo3, ClampVector(col*self.Mul3, self.Min3, self.Max3)) end
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
		self.TweakFloat = mat:GetFloat("$rimlightmul")
		self.TintBool = mat:GetFloat("$rimlightdotint")
		self.LerpPower = mat:GetFloat("$rimlight_ls")
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		if !IsValid(lply) then return end
		local owner = ent
		if !IsValid( owner ) then return end
		
		if self.PowerFloat == nil then self.PowerFloat = 1 end
		if self.TweakFloat == nil then self.TweakFloat = 1 end
		if self.LerpPower == nil then self.LerpPower = 1 end
		if self.TintBool == nil then self.TintBool = 0 end
		
		if ent.Preview == true or ent.preview == true then
			local col = mat:GetVector("$color2")
			local calc = (col.x + col.y + col.z) / 3
			mat:SetFloat("$rimlightboost", ((self.PowerFloat*0.1) * self.TweakFloat) * calc)
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
				mat:SetFloat( "$rimlightboost", ent.DRCScalingRimLightParams[name]["Value"] * self.TweakFloat )
			else
				mat:SetFloat( "$rimlightboost", ent.DRCScalingRimLightParams[name]["Value"] * self.TweakFloat )
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

local function InitReflectionTint(self, mat, values)
	if !self or !mat or !values then return end
	self.ResultTo = values.resultvar or "$envmaptint"
	self.ResultTo2 = values.resultvar2
	self.ResultTo3 = values.resultvar3
	self.TintVector = mat:GetVector("$cmtint") or mat:GetVector("$cubemaptint") or Vector(1, 1, 1)
	self.PowerFloat = mat:GetFloat("$cmpower") or mat:GetFloat("$cubemappower") or 1
	self.ShiftFloat = values.shiftpower or 1
	self.MinFloat	= mat:GetFloat("$cmmin") or mat:GetFloat("$cubemapmin") or 0
	self.MaxFloat	= mat:GetFloat("$cmmax") or mat:GetFloat("$cubemapmax") or 1
	self.HDRCorrectionLevel	= mat:GetFloat("$cmhdr") or mat:GetFloat("$cubemapHDRMul") or 1
	self.LDRCorrectionLevel	= mat:GetFloat("$cmldr") or mat:GetFloat("$cubemapLDRMul") or 1
	self.LerpPower	= mat:GetFloat("$cubemap_ls") or 1
	self.Saturation = mat:GetFloat("$cmlightsat") or mat:GetFloat("$cubemaplightingsaturation") or 1
	self.Envmap = mat:GetString("$envmapfallback")
end

matproxy.Add( {
	name = "drc_ReflectionTint",
	init = function( self, mat, values )
		InitReflectionTint(self, mat, values)
	end,

	bind = function( self, mat, ent )
		if (!IsValid(ent)) then return end
		if !IsValid(lply) then return end
		
		local val = GetCubemapStrength(self, ent, "None", mat)
		if val then 
			mat:SetVector(self.ResultTo or "$envmaptint", val)
			if self.ResultTo2 then mat:SetVector(self.ResultTo2, val) end
			if self.ResultTo3 then mat:SetVector(self.ResultTo3, val) end
		end
	end
} )

matproxy.Add( {
	name = "drc_ReflectionTint_EntityColour",
	init = function( self, mat, values )
		InitReflectionTint(self, mat, values)
	end,

	bind = function( self, mat, ent )
		if (!IsValid(ent)) then return end
		if !IsValid(lply) then return end
		
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
		InitReflectionTint(self, mat, values)
	end,

	bind = function( self, mat, ent )
		if (!IsValid(ent)) then return end
		if !IsValid(lply) then return end
		
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
		InitReflectionTint(self, mat, values)
	end,

	bind = function( self, mat, ent )
		if (!IsValid(ent)) then return end
		if !IsValid(lply) then return end
		
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
		InitReflectionTint(self, mat, values)
	end,

	bind = function( self, mat, ent )
		if (!IsValid(ent)) then return end
		if !IsValid(lply) then return end
		
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
		InitReflectionTint(self, mat, values)
	end,

	bind = function( self, mat, ent )
		if (!IsValid(ent)) then return end
		if !IsValid(lply) then return end
		
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
		InitReflectionTint(self, mat, values)
	end,

	bind = function( self, mat, ent )
		if (!IsValid(ent)) then return end
		if !IsValid(lply) then return end
		
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
		self.DoExponent = values.exponent
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		if ent.spray_updatetime == nil then ent.spray_updatetime = 0 end
		
		if !lply then lply = LocalPlayer() end
		
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
			if self.DoExponent == 1 then mat:SetTexture("$phongexponenttexture", "models/effects/vol_light001") end
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
				if self.DoExponent == 1 then mat:SetTexture("$phongexponenttexture", "models/effects/vol_light001") end
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
				if self.DoExponent == 1 then mat:SetTexture("$phongexponenttexture", "models/effects/vol_light001") end
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
				if self.exponent then mat:SetTexture("$phongexponenttexture", "models/effects/vol_light001") end
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
			if self.DoExponent == 1 then mat:SetTexture("$phongexponenttexture", "vgui/logos/spray") end
			local fps = 0.33
			if RealTime() > ent.spray_updatetime then
				local frame = mat:GetInt("$frame")
				if frame > ent.frames then frame = 0 end
				mat:SetInt("$frame", frame + 1)
				ent.spray_updatetime = RealTime() + fps
			end
		else
			mat:SetTexture("$basetexture", "../data/draconic/sprays/".. SID .."")
			if self.DoExponent == 1 then mat:SetTexture("$phongexponenttexture", "../data/draconic/sprays/".. SID .."") end
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
			timer.Simple(math.Rand(3, 16), function()
				if !IsValid(ent) then return end
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
		self.World = mat:GetFloat("$psx_world") or 0
		self.Menu = mat:GetFloat("$psx_menu") or 0
		self.Framerate = mat:GetFloat("$psx_fps")
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then ent = Entity(0) end
		if !IsValid(ent) then return end
		if !IsValid(lply) then return end
		local cspm = ent:GetClass() == "drc_csplayermodel" or ent:GetClass() == "drc_csshadowmodel"
		if ent == lply && (GetConVar("cl_drc_experimental_fp"):GetFloat() > 0 && DRC:ThirdPersonEnabled(lply) == false) then return end
		
		if !self.Power then self.Power = 1 end
		if !self.Speed then self.Speed = 1 end
		if !self.World then self.World = 0 end
		
		local localvel = lply:GetVelocity()
		local localspeed = localvel:Length()
		local hands = ent == lply:GetHands()
		local vm = ent == lply:GetViewModel(0)
		
		if !self.Framerate then self.Framerate = 24 end
		ent.PSXFramerate = self.Framerate
		
		local c1, c2 = ent:GetPos() + ent:OBBCenter(), EyePos()
		local m1, m2 = (self.Power or 1)*0.1, 1
		
		ent.PSXDistance = (math.Distance(c1.x, c1.y, c2.x, c2.y) / 50)
		if !ent.PSXDistance then ent.PSXDistance = 0 end
		ent.DesiredPower = m1 * m2
		ent.DesiredPower = math.Clamp(ent.PSXDistance * ent.DesiredPower, 0.1, 25)
		
		local x,y = math.abs(DRC.MoveInfo.Mouse[1]) > 0, math.abs(DRC.MoveInfo.Mouse[2]) > 0
		
		if !DRC:IsCharacter(ent) && !ent.preview && ent.ForcePSX != true then
			if ent:GetVelocity() == Vector() && localvel == Vector() && !x && !y then ent.DesiredPower = 0 end
			if x or y then ent.DesiredPower = ent.DesiredPower * 1.25 end
		elseif ent.preview then ent.DesiredPower = 0.1
		end
		
		ent.Power = Lerp(0.01, ent.Power or ent.DesiredPower, ent.DesiredPower)
		
		if !ent.psxcd then ent.psxcd = 0 end
		if !ent.psxbool then ent.psxbool = 1 end
		if !ent.PSXCycle then ent.PSXCycle = 0 end
		if !ent.PSXMulRefresh then ent.PSXMulRefresh = 0 end
		local ms, mr, mw, mc, mm, si, sm, ss = mat:GetFloat("$psx_cyclemul_sprint"), mat:GetFloat("$psx_cyclemul_run"), mat:GetFloat("$psx_cyclemul_walk"), mat:GetFloat("$psx_cyclemul_crouch"), mat:GetFloat("$psx_cyclemul"), mat:GetFloat("$psx_cyclemul_swimidle"), mat:GetFloat("$psx_cyclemul_swimming"), mat:GetFloat("$psx_cyclemul_swimsprint")
		if ms then ent.psx_ms = ms end
		if mr then ent.psx_mr = mr end
		if mw then ent.psx_mw = mw end
		if mc then ent.psx_mc = mc end
		if mm then ent.psx_mm = mm end
		if si then ent.psx_si = si end
		if sm then ent.psx_sm = sm end
		if ss then ent.psx_ss = ss end
		local rt = RealTime()
		
		if rt > ent.PSXMulRefresh then -- no clean way to really refresh this since having multiple materials using the proxy will override it, so I just reset it for one frame every second. Unnoticeable.
			ent.psx_ms = 1
			ent.psx_mr = 1
			ent.psx_mw = 1
			ent.psx_mc = 1
			ent.psx_mm = 1
			ent.psx_si = 1
			ent.psx_sm = 1
			ent.psx_ss = 1
			ent.PSXMulRefresh = rt + 1
		end
		
		if rt > ent.psxcd then
			local fps = 1/ent.PSXFramerate
			ent.psxcd = rt + fps
			if ent.psxbool == 0 then ent.psxbool = 1 else ent.psxbool = 0 end
			
			
			local mspd, cmspd, diff, mul = 0, 0, 0, 1
			if !ent.psxspeedmul then ent.psxspeedmul = 0 end
			if !ent.psxamount then ent.psxamount = 0 end
			if ent.preview == true or ent.Preview == true then
				ent.psxamount = 0.0052
				ent.psxspeedmul = Lerp(1, 0, 0.0416) * 2
				ent.psxamount = (fps * ent.psxspeedmul)
			elseif ent:IsPlayer() or cspm then
				local etu = ent
				if cspm then etu = lply end
				local wl = etu:WaterLevel()
				local n, s, e, w = etu:KeyDown(IN_MOVERIGHT) or etu:KeyDown(IN_MOVELEFT) or etu:KeyDown(IN_FORWARD) or etu:KeyDown(IN_BACK)
				local jump, crouch, walk = etu:KeyDown(IN_JUMP), etu:KeyDown(IN_DUCK), (n or s or e or w) && etu:KeyDown(IN_WALK)
				local run = !crouch && !walk && (n or s or e or w)
				local sprint = run && etu:KeyDown(IN_SPEED)
				
				if wl != 3 then
					if crouch then mul = ent.psx_mc end
					if walk then mul = ent.psx_mw end
					if crouch then mul = ent.psx_mc end
					if run then mul = ent.psx_mr end
					if sprint then mul = ent.psx_ms end
				else
					if !run && !sprint then mul = ent.psx_si end
					if walk then mul = ent.psx_sm end
					if run then mul = ent.psx_sm end
					if sprint then mul = ent.psx_ss end
				end
				
				if jump then etu.PSXCycle = 0 end
				
				local rs, ws, cs = etu:GetRunSpeed(), etu:GetSlowWalkSpeed(), etu:GetCrouchedWalkSpeed()
				mspd = rs - (rs * 0.25)
				cmspd = mspd + ws * cs
				diff = mspd + ws
				if walk && wl != 3 then mspd = diff end
				if crouch then mspd = cmspd end
				if cspm then mspsd = mspd * 0.01 end
				if ent:GetVelocity() == Vector() then ent.psxspeedmul = Lerp(1, 0, 0.0416) * 3.333
				else ent.psxspeedmul = Lerp(localspeed/64000, 0, mspd) * 2.5 end
				
				ent.psxamount = (fps * ent.psxspeedmul)
			else
				ent.psxamount = fps
			end
			
			ent.PSXCycle = ent.PSXCycle + ((ent.psxamount or 0 + ent.psxamount) * mul) * GetConVar("host_timescale"):GetFloat()
		end
		
		if ent:WaterLevel() == 3 or DRC:FloorDist(ent) < 10 or (ent.preview == true or ent.Preview == true) then ent:SetCycle(ent.PSXCycle) end
		
		if self.World < 1 then
			local str = ent.DesiredPower * self.Power
			local height = 0
			if vm or hands && self.Menu < 1 then str = 0.05 height = 100 end
			if self.Menu > 0 then height = 100 end
			mat:SetInt("$treesway", ent.psxbool)
			mat:SetFloat("$treeswayheight", -height)
			mat:SetFloat("$treeswaystartheight", height)
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
	
	local function calc(frac, maxinvertmin)
		local function Ease(fr, mi, ma)
			local func = matlerps[mat.FuncEase]
			return Lerp(func(fr), mi, ma)
		end
		
		local midfrac = math.Clamp(math.abs(0.5+frac), 0, 1) * frac
		local newmini = LerpVector(midfrac, mini, mid*5)
		if maxinvertmin == true then newmini = -maxi end
		local newval = LerpVector(frac, newmini, maxi)
		
		if mat.FuncEase != "Linear" then newval = Vector(Ease(frac, newmini.x, maxi.x), Ease(frac, newmini.y, maxi.y), Ease(frac, newmini.z, maxi.z)) end
		
		return newval
	end
	
	if ent:IsWeapon() then
		if input == "clip1" then val = calc(math.Clamp(ent:Clip1()/ent:GetMaxClip1(), 0, 1))
		elseif input == "heat" && ent.GetMaxHeat then val = calc(math.Clamp(ent:GetHeat()/ent:GetMaxHeat(), 0, 1))
		elseif input == "charge" then val = calc(math.Clamp(ent:GetCharge()/ent:GetMaxCharge(), 0, 1))
		elseif input == "velocity" then
			local own = ent:GetOwner()
			if !own then val = calc(math.Clamp(ent:GetVelocity():Length(), 1, 999999)/funcmax, 0, 1) -- weapon exists in the world
			else val = calc(math.Clamp(ent:GetOwner():GetVelocity():Length(), 1, 999999)/funcmax, 0, 1) -- weapon is held by an entity
			end
		elseif input == "sway" && ent.proxydang then -- DRC
			val = Vector(ent.proxydang.x, ent.proxydang.y, 0)
			val.x = math.Clamp(calc(val.x).x, -maxi.x, maxi.x)
			val.y = math.Clamp(calc(val.y).x, -maxi.x, maxi.x)
		end
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
	elseif input == "armour" then
		local ap, map = 1, 100
		if ent.Armor != nil && ent.GetMaxArmor != nil then
			ap = ent:Armor()
			map = ent:GetMaxArmor()
		end
		val = calc(math.Clamp(ap/map, 0, 1))
	elseif input == "shield" then local sp, msp = DRC:GetShield(ent) val = calc(math.Clamp(sp/msp, 0, 1))
	elseif input == "lightlevelhitpos" then
		local tr, hit
		if ent:IsPlayer() then tr = ent:GetEyeTrace() hit = tr.HitPos
		else tr = util.QuickTrace(ent:EyePos(), ent:EyeAngles():Forward(), ent) hit = tr.HitPos end
		val = render.GetLightColor(hit)
	elseif input == "lightlevelhitposavg" then
		local tr, hit
		if ent:IsPlayer() then tr = ent:GetEyeTrace() hit = tr.HitPos
		else tr = util.QuickTrace(ent:EyePos(), ent:EyeAngles():Forward(), ent) hit = tr.HitPos end
		local col = render.GetLightColor(hit)
		val = calc((col.r + col.g + col.b) * 0.333)
	elseif input == "lightlevel" then val = LightPollEntity(ent)
	elseif input == "lightlevelavg" then local ll, lla = LightPollEntity(ent) val = calc(lla)
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
	elseif input == "nwfloat" then val = calc(ent:GetNWFloat(mod))
	elseif input == "nwint" then val = calc(ent:GetNWInt(mod))
	elseif input == "nwangle" then val = ent:GetNWAngle(mod)
	elseif input == "nwstring" then val = ent:GetNWString(mod)
	end
	
	return val
end

local matfuncs = {
	["read"] = Read,
}

local matreturns = { -- 0 vector, 1 string, 2 bool, 3 number, 4 texture, 5 matrix
	["$basetexture"] = 4,
	["$bumpmap"] = 4,
	["$normalmap"] = 4,
	["$lightwarptexture"] = 4,
	["$detail"] = 4,
	["$detailscale"] = 3,
	["$detailblendmode"] = 3,
	["$detailblendfactor"] = 3,
	["$color"] = 0,
	["$color2"] = 0,
	["$blendtintcoloroverbase"] = 3,
	["$phong"] = 2,
	["$phongexponent"] = 3,
	["$phongboost"] = 3,
	["$phongtint"] = 0,
	["$phongfresnelranges"] = 0,
	["$phongexponenttexture"] = 4,
	["$phongexponentfactor"] = 3,
	["$phongwarptexture"] = 4,
	["$phongdisablehalflambert"] = 2,
	["$phongalbedotint"] = 2,
	["$phongalbedoboost"] = 3,
	["$basemapalphaphongmask"] = 2,
	["$basemapalphaenvmapmask"] = 2,
	["$normalmapalphaenvmapmask"] = 2,
	["$envmap"] = 1,
	["$envmaptint"] = 0,
	["$selfillum"] = 2,
	["$selfillumtint"] = 0,
	["$emissiveblendenabled"] = 2,
	["$emissiveblendtexture"] = 4,
	["$emissiveblendbasetexture"] = 4,
	["$emissiveblendflowtexture"] = 4,
	["$emissiveblendtint"] = 0,
	["$emissiveblendstrength"] = 3,
	["$emissiveblendscrollvector"] = 0,
	["$rimlight"] = 2,
	["$rimlightexponent"] = 3,
	["$rimlightboost"] = 3,
	["$cloakpassenabled"] = 2,
	["$cloakfactor"] = 3,
	["$cloakcolortint"] = 0,
	["$refractamount"] = 3,
	["$refracttint"] = 0,
	["$basetexturetransform"] = 5, -- need to implement proper matrix support
	["$frame"] = 3,
	-- These few below technically don't exist, but are the most common used for translations
	["$angle"] = 3,
	["$translate"] = 0,
	["$center"] = 0,
	["$offset"] = 3,
	-- Draconic parameters beyond this point
	["$envmapfallback"] = 1,
	["$cmpower"] = 3,
	["$cmpower_fb"] = 3,
	["$cmtint"] = 0,
	["$cmtint_fb"] = 0,
	["$cmshiftpower"] = 3,
	["$cmshift"] = 0,
	["$rimlightpower"] = 3,
	-- Function matproxy workarounds
	["basetranslate"] = 99
}

local function ReturnVal(info, val, mat)
	local numb = matreturns[info.ResultTo]
	if numb == 0 then mat:SetVector(info.ResultTo, Vector(val * info.Mul1))
	elseif numb == 1 then mat:SetString(info.ResultTo, val * info.Mul1)
	elseif numb == 2 or numb == 3 then mat:SetFloat(info.ResultTo, val.x * info.Mul1)
	elseif numb == 4 then mat:SetTexture(info.ResultTo, val)
	elseif numb == 99 then
		val = val*info.Mul1
		local matr = Matrix({
			{1, 0, 0, val.y},
			{0, 1, 0, -val.x},
			{0, 0, 0, 0},
			{0, 0, 0, 0}
		})
		mat:SetMatrix("$basetexturetransform", matr)
	end
	
	if matreturns[info.ResultTo2] then
		numb = matreturns[info.ResultTo2]
		if numb == 0 then mat:SetVector(info.ResultTo2, Vector(val * info.Mul2))
		elseif numb == 1 then mat:SetString(info.ResultTo2, val * info.Mul2)
		elseif numb == 2 or numb == 3 then mat:SetFloat(info.ResultTo2, val.x * info.Mul2)
		elseif numb == 4 then mat:SetTexture(info.ResultTo, val)
		end
	end
	
	if matreturns[info.ResultTo3] then
		numb = matreturns[info.ResultTo3]
		if numb == 0 then mat:SetVector(info.ResultTo3, Vector(val * info.Mul3))
		elseif numb == 1 then mat:SetString(info.ResultTo3, val * info.Mul3)
		elseif numb == 2 or numb == 3 then mat:SetFloat(info.ResultTo3, val.x * info.Mul3)
		elseif numb == 4 then mat:SetTexture(info.ResultTo, val)
		end
	end
end

local function SetVal(key, val, mat)
--	print(key, val)
	local numb = matreturns[key]
	if numb == 0 then mat:SetVector(key, val)
	elseif numb == 1 then mat:SetString(key, val)
	elseif numb == 2 or numb == 3 then mat:SetFloat(key, val)
	elseif numb == 4 then mat:SetTexture(key, val)
	end
end

local function CopyBaseVals(mat, ent, tbl)
	local original
	local ply = ent:IsPlayer() == true or ent.Preview == true or ent:IsRagdoll() == true
	if ply then original = ent.CamoProxyMaterials[mat:GetFloat("$slotnum")]
	else original = ent.WeaponSkinProxyMaterials[mat:GetFloat("$slotnum")] end
	
	if original != nil then
		mat:SetTexture("$basetexture", original:GetTexture("$basetexture") or "")
		mat:SetTexture("$bumpmap", original:GetTexture("$bumpmap") or "")
		mat:SetTexture("$phongexponenttexture", original:GetTexture("$phongexponenttexture") or "")
		mat:SetTexture("$detail", original:GetTexture("$detail") or "")
		mat:SetVector("$color2", original:GetVector("$color2") or Vector(1,1,1))
		mat:SetVector("$phongtint", original:GetVector("$phongtint") or Vector(1,1,1))
		mat:SetVector("$phongfresnelranges", original:GetVector("$phongfresnelranges") or Vector(1,1,1))
		mat:SetVector("$cmtint", original:GetVector("$cmtint") or Vector(1,1,1))
		mat:SetFloat("$cmpower", original:GetFloat("$cmpower") or 1)
		mat:SetFloat("$rimlightpower", original:GetFloat("$rimlightpower") or 1)
		
		if original:GetString("$drc_camocolour") != nil then
			tbl.camocolour = original:GetString("$drc_camocolour")
		end
		if original:GetString("$drc_camoscale") != nil then
			tbl.camoscale = original:GetString("$drc_camoscale")
		end
		if original:GetString("$envmapfallback") != nil then
			local str = original:GetString("$envmapfallback")
			mat:SetTexture("$envmapfallback", str)
			local vec = original:GetVector("$cmtint_fb")
			if !vec then vec = original:GetVector("$cmtint") end
			if !vec then vec = Vector(1,1,1) end
			local power = original:GetFloat("$cmpower_fb")
			if !power then power = original:GetFloat("$cmpower") end
			if !power then power = 1 end
			mat:SetVector("$cmtint_fb", vec)
			mat:SetFloat("$cmpower_fb", power)
		end
	else
		ent:SetSubMaterial(mat:GetFloat("$slotnum"), nil)
	end
end

local coltranslate = {
	["player"] = "PlayerColour_DRC",
	["weapon"] = "WeaponColour_DRC",
	["tint1"] = "ColourTintVec1",
	["tint2"] = "ColourTintVec2",
	["eye"] = "EyeTintVec",
	["energy"] = "EnergyTintVec",
}

matproxy.Add({
	name = "drc_WeaponCamo",
	init = function( self, mat, values )
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		if !IsValid(lply) then return end
		if ent == lply:GetViewModel() then ent = lply:GetActiveWeapon() end
		local skin = ent.WeaponSkinApplied
	--	print(ent, self, skin)
		if skin != nil && DRC.WeaponSkins[skin] && DRC.WeaponSkins[skin].ProxyMat then
			CopyBaseVals(mat, ent, self)
			local colchannel = self.camocolour
			local camoscale = self.camoscale or 1
			for k,v in pairs(DRC.WeaponSkins[skin].ProxyMat) do
				if matreturns[k] then SetVal(k, v, mat) end
				
				if k == "$color2" && colchannel != nil then
					local col = GetPlayerColour(lply, coltranslate[colchannel])
					mat:SetVector("$color2", col)
				end
				
				if k == "$detailscale" then
					if ent:IsPlayer() or ent.Preview == true or ent:IsRagdoll() then
						for ke,va in pairs(ent.CamoProxyMaterials) do
						--	local camoscale = ent.CamoProxyMaterials[ke]:GetFloat("$drc_camoscale") or 1
							if mat:GetString("$detail") != "" then mat:SetFloat("$detailscale", v * camoscale) end
						end
					else
						for ke,va in pairs(ent.WeaponSkinProxyMaterials) do
						--	local camoscale = ent.WeaponSkinProxyMaterials[ke]:GetFloat("$drc_camoscale") or 1
							if mat:GetString("$detail") != "" then mat:SetFloat("$detailscale", v * camoscale) end
						end
					end
				end
			end
		end
	end
})

matproxy.Add( {
	name = "drc_PlayerColours",
	init = function( self, mat, values )
		InitColours(self, mat, values)
	end,

	bind = function( self, mat, ent )
		if !IsValid(ent) then return end
		local col = GetPlayerColour(ent, "PlayerColour_DRC")
		if self.ResultTo == nil then self.ResultTo = "$color2" end
		if self.Mul == nil then self.Mul = 1 end
		if self.Mul2 == nil then self.Mul2 = 1 end
		if self.Mul3 == nil then self.Mul3 = 1 end
		
		mat:SetVector(self.ResultTo, ClampVector(col*self.Mul, self.Min, self.Max))
		if self.ResultTo2 then mat:SetVector(self.ResultTo2, ClampVector(col*self.Mul2, self.Min2, self.Max2)) end
		if self.ResultTo3 then mat:SetVector(self.ResultTo3, ClampVector(col*self.Mul3, self.Min3, self.Max3)) end
	end
} )

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
	if !IsValid(lply) then return end
	local ent2
	if ent == lply:GetHands() or ent == lply:GetViewModel(0) then ent2 = lply else ent2 = ent end
	if !IsValid(ent2) then return end
	if self.Target == "weapon" && !ent2:IsWeapon() then if DRC:IsCharacter(ent2) then ent2 = ent2:GetActiveWeapon() else ent2 = ent end end
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
			mat:SetFloat(self.ResultTo, val * self.Mul1)
		end
		
		if self.ResultTo2 then -- "Reflection" pass, intended to be tied to cmpower. Decreases power from 1-0.
			if !self.Mul2 then self.Mul2 = 1 end
			mat:SetFloat(self.ResultTo2, self.Mul2 - (val * self.Mul2))
		end
		
		if self.ResultTo3 then -- "Specular" pass, intended to be tied to either phongboost or phongalbedoboost. Decreases power from 1-0.
			if !self.Mul3 then self.Mul3 = 1 end
			mat:SetFloat(self.ResultTo3, self.Mul3 - (val * self.Mul3))
		end
	end
} )