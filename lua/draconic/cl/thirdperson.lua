DRC.CalcView.ThirdPerson.Ang = Angle()
DRC.CalcView.ThirdPerson.Ang_Stored = Angle()
DRC.CalcView.ThirdPerson.DirectionalAng = Angle()
DRC.CalcView.ThirdPerson.Live = false
DRC.CalcView.ThirdPerson.Directional = false
DRC.CalcView.ThirdPerson.PokeTime = CurTime()
DRC.CalcView.ThirdPerson.FreelookForced = false
if !DRC.CalcView.ThirdPerson.EditorOpen then DRC.CalcView.ThirdPerson.EditorOpen = false end
DRC.CalcView.ThirdPerson.LerpedZPos = 0
DRC.CalcView.ThirdPerson.LerpedFinalAng = Angle()
DRC.CalcView.ThirdPerson.LerpedFinalPos = Vector()
DRC.CalcView.ThirdPerson.LerpedHitPosCorrection = Angle()

DRC.ThirdPerson.EditorSettings = {
	["Length"] = 100,
	["Height"] = 25,
	["UseBaseOffsets"] = true,
	["AllowFreeLook"] = true,
	["Offset"] = Vector(0, 0, 0),
	["LerpAngle"] = 0,
	["LerpPos"] = 0.1,
	["LerpTransition"] = 1,
	["BaseFOV"] = 75,
	["FocalPoint"] = 0, -- 0 player view, 1 hitpos, 2 head angle
	["BasePoint"] = 0, -- 0 pelvis, 1 eyes, 2 origin
	["ForceFreelook"] = false,
	["FreecamDelay"] = 3,
	["ForceDirectional"] = false,
}

DRC.ThirdPerson.LoadedSettings = {
	["Length"] = 100,
	["Height"] = 25,
	["UseBaseOffsets"] = true,
	["AllowFreeLook"] = true,
	["Offset"] = Vector(25, 0, 0),
	["LerpAngle"] = 0,
	["LerpPos"] = 0.1,
	["LerpTransition"] = 1,
	["BaseFOV"] = 75,
	["FocalPoint"] = 0, -- 0 player view, 1 hitpos, 2 head angle
	["BasePoint"] = 0, -- 0 pelvis, 1 eyes, 2 origin
	["ForceFreelook"] = false,
	["FreecamDelay"] = 3,
	["ForceDirectional"] = false,
}
DRC.ThirdPerson.LerpedSettings = {
	["Length"] = 100,
	["Height"] = 25,
	["UseBaseOffsets"] = true,
	["AllowFreeLook"] = true,
	["Offset"] = Vector(25, 0, 0),
	["LerpAngle"] = 0,
	["LerpPos"] = 0.1,
	["LerpTransition"] = 1,
	["BaseFOV"] = 75,
	["FocalPoint"] = 0, -- 0 player view, 1 hitpos, 2 head angle
	["BasePoint"] = 0, -- 0 pelvis, 1 eyes, 2 origin
	["ForceFreelook"] = false,
	["FreecamDelay"] = 3,
	["ForceDirectional"] = false,
}

DRC.ThirdPerson.DefaultSettings = {
	["Length"] = 100,
	["Height"] = 25,
	["UseBaseOffsets"] = true,
	["AllowFreeLook"] = true,
	["Offset"] = Vector(25, 0, 0),
	["LerpAngle"] = 0,
	["LerpPos"] = 0.1,
	["LerpTransition"] = 1,
	["BaseFOV"] = 75,
	["FocalPoint"] = 0, -- 0 player view, 1 hitpos, 2 head angle
	["BasePoint"] = 0, -- 0 pelvis, 1 eyes, 2 origin
	["ForceFreelook"] = false,
	["FreecamDelay"] = 3,
	["ForceDirectional"] = false,
}

local lastload = GetConVar("cl_drc_thirdperson_preset"):GetString()
if lastload != "" && file.Find("draconic/thirdperson/".. lastload ..".json", "DATA") != nil then
	local initialpreset = file.Read("draconic/thirdperson/".. lastload ..".json", "DATA")
	local tbl = util.JSONToTable(initialpreset)
	table.CopyFromTo(tbl, DRC.ThirdPerson.LoadedSettings)
	table.CopyFromTo(tbl, DRC.ThirdPerson.EditorSettings)
	DRC:UpdateThirdPersonEditorMenu()
end

function DRC:ThirdPerson_PokeLiveAngle(ply)
	local wpn = ply:GetActiveWeapon()
	local settings = wpn.ThirdPersonProfileOverride or DRC.ThirdPerson.LoadedSettings
	if !DRC.CalcView.Thirdperson then DRC.CalcView.Thirdperson = {} end
	if !DRC.CalcView.Ang then DRC.CalcView.Ang = Angle() end
	if !DRC.CalcView.Ang_Stored then DRC.CalcView.Ang_Stored = Angle() end
	if !DRC.CalcView.DirectionalAng then DRC.CalcView.DirectionalAng = Angle() end
	if !DRC.CalcView.Live then DRC.CalcView.Live = false end
	if !DRC.CalcView.PokeTime then DRC.CalcView.PokeTime = CurTime() end
	if DRC.CalcView.ThirdPerson.PokeTime == nil then DRC.CalcView.ThirdPerson.PokeTime = CurTime() end
	if wpn.ThirdpersonForceFreelook == true or settings.ForceFreelook == true then
		DRC.CalcView.ThirdPerson.Live = false
		DRC.CalcView.ThirdPerson.FreelookForced = true
		DRC.CalcView.ThirdPerson.Poked = true
		DRC.CalcView.ThirdPerson.PokeTime = CurTime()
		return
	else DRC.CalcView.ThirdPerson.FreelookForced = false
	end
	if CurTime() < DRC.CalcView.ThirdPerson.PokeTime then return end
	DRC.CalcView.ThirdPerson.Live = true
	DRC.CalcView.ThirdPerson.Poked = true
	local delay = DRC.ThirdPerson.LerpedSettings.FreecamDelay or 0
	DRC.CalcView.ThirdPerson.PokeTime = CurTime() + delay
	
	timer.Simple(engine.TickInterval() + 0.01, function()
		if settings.AllowFreeLook == true then DRC.CalcView.ThirdPerson.Poked = false end
	end)
	timer.Simple(delay + 0.01, function()
		if CurTime() > DRC.CalcView.ThirdPerson.PokeTime then
			DRC.CalcView.ThirdPerson.Live = false
		end
	end)
end

local fullranges = { -- This is going to probably give someone an aneurysm
	["normal"] = "E",
	["passive"] = "E",
	["slam"] = "E"
}
local Directional = {
	[""] = Angle(0, 0, 0),
	["N"] = Angle(0, 0, 0),
	["W"] = Angle(0, 90, 0),
	["E"] = Angle(0, -90, 0),
	["S"] = Angle(0, 180, 0),
	["NW"] = Angle(0, 45, 0),
	["NE"] = Angle(0, -45, 0),
	["SW"] = Angle(0, 135, 0),
	["SE"] = Angle(0, -135, 0),
	["EW"] = Angle(0, 0, 0),
	["NS"] = Angle(0, 0, 0),
}
local MovementCorrection = {
	[""] = 0,
	["N"] = 1,
	["W"] = 1,
	["E"] = 1,
	["S"] = 1,
	["NW"] = 1,
	["NE"] = 1,
	["SW"] = 1,
	["SE"] = 1,
	["EW"] = 0,
	["NS"] = 0,
}

hook.Add("CreateMove", "!drc_cacheusercmd", function(cmd)
	DRC.MoveInfo = {
		["Mouse"] = { cmd:GetMouseX(), cmd:GetMouseY() },
		["Forward"] = cmd:GetForwardMove(),
		["Side"] = cmd:GetSideMove(),
	}
end)

hook.Add("CreateMove", "!drc_thirdpersoncontrol", function(cmd)
	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	local wpn = ply:GetActiveWeapon()
	if DRC:IsDraconicThirdPersonEnabled(ply) != true then return end
	local settings = wpn.ThirdPersonProfileOverride or DRC.ThirdPerson.LoadedSettings
	if !settings.LerpTransition then settings.LerpTransition = 1 end
	for k,v in pairs(settings) do -- used to interpolate profile changes for scripted systems that utilize profile overrides.
		if !isbool(v) && !isstring(v) then
			DRC.ThirdPerson.LerpedSettings[k] = Lerp(RealFrameTime()*(5*settings.LerpTransition), DRC.ThirdPerson.LerpedSettings[k] or v, v)
		else
			DRC.ThirdPerson.LerpedSettings[k] = v
		end
	end
	local n, s, e, w = ply:KeyDown(IN_FORWARD), ply:KeyDown(IN_BACK), ply:KeyDown(IN_MOVERIGHT), ply:KeyDown(IN_MOVELEFT)
	local moving = n or s or e or w
	settings = DRC.ThirdPerson.LerpedSettings
	if settings.AllowFreeLook == false or GetConVar("sv_drc_disable_thirdperson_freelook"):GetFloat() == 1 then
		DRC:ThirdPerson_PokeLiveAngle(ply)
	elseif IsValid(wpn) && (wpn.ThirdpersonNoFreelook == true) then
		DRC:ThirdPerson_PokeLiveAngle(ply)
	end
	
	local sens = ply:GetFOV() / 100
	
	DRC.MoveInfo.Mouse.X = (DRC.MoveInfo.Mouse[1] * 0.03) * sens
	DRC.MoveInfo.Mouse.Y = (DRC.MoveInfo.Mouse[2] * 0.03) * sens
	
	if !DRC.CalcView then DRC.CalcView = {} end
	if !DRC.CalcView.ThirdPerson then DRC.CalcView.ThirdPerson = {} end
	if !DRC.CalcView.ThirdPerson.Ang then DRC.CalcView.ThirdPerson.Ang = Angle() end
	
	DRC.CalcView.ThirdPerson.Ang = DRC.CalcView.ThirdPerson.Ang + Angle(DRC.MoveInfo.Mouse.Y, -DRC.MoveInfo.Mouse.X, 0)
	DRC.CalcView.ThirdPerson.Ang.X = math.Clamp(DRC.CalcView.ThirdPerson.Ang.X, -85, 90)
	
	local pokers = {
		ply:KeyDown(IN_ATTACK),
		ply:KeyDown(IN_ATTACK2),
		ply:KeyDown(IN_USE),
	}
	
	if settings.ForceDirectional != true then
		for k,v in pairs(pokers) do
			if v == true then DRC:ThirdPerson_PokeLiveAngle(ply) end
		end
	end

	if DRC.MoveInfo.Forward != 0 then DRC:ThirdPerson_PokeLiveAngle(ply) end
	if DRC.MoveInfo.Side != 0 then DRC:ThirdPerson_PokeLiveAngle(ply) end
	
	if IsValid(wpn) then
		local ht = wpn:GetHoldType()
		
		if fullranges[ht] && wpn.ThirdpersonNoFreelook != true && settings.AllowFreeLook == true then
			DRC.CalcView.ThirdPerson.Directional = true
			
			local Compass = {
				["N"] = ply:KeyDown(IN_FORWARD),
				["S"] = ply:KeyDown(IN_BACK),
				["E"] = ply:KeyDown(IN_MOVERIGHT),
				["W"] = ply:KeyDown(IN_MOVELEFT),
			}
			local input = ""
			local temptable = {}
			for k,v in pairs(Compass) do
				if v == true then table.insert(temptable, k) end
			end
			for k,v in pairs(temptable) do
				input = ""..input..""..v..""
			end
			input = string.reverse(input)
			if string.len(input) > 2 then input = "" end
			
			DRC.CalcView.ThirdPerson.DirectionalAng = LerpAngle(0.1, DRC.CalcView.ThirdPerson.DirectionalAng or Directional[input], Directional[input])
			local val = (math.abs(cmd:GetForwardMove()) + math.abs(cmd:GetSideMove()))
			cmd:SetForwardMove(val * MovementCorrection[input])
			cmd:SetSideMove(0)
			
			if moving then DRC.CalcView.ThirdPerson.DirectionalEyeAngles = ply:EyeAngles() end
		else
			DRC.CalcView.ThirdPerson.DirectionalAng = Angle()
			DRC.CalcView.ThirdPerson.DirectionalEyeAngles = ply:EyeAngles()
		end
	
		if DRC:SightsDown(wpn) then
			DRC.CalcView.ThirdPerson.Live = true
			DRC.CalcView.ThirdPerson.StoredAng = ply:EyeAngles()
		elseif !DRC:SightsDown(wpn) && DRC.CalcView.ThirdPerson.Live == false then
			DRC.CalcView.ThirdPerson.Live = false
		end
		
		if !DRC:SightsDown(wpn) then
			if wpn.ASTWTWO then ASTW2Anticlipping(LocalPlayer(), false, false) end
		end
	end
end)

hook.Add("PrePlayerDraw", "!drc_thirdpersonlook", function(ply)
	if !IsValid(ply) then return end
	if ply != LocalPlayer() then return end
	if GetConVar("cl_drc_thirdperson"):GetInt() == 1 && DRC.CalcView.ThirdPerson.Live == false then
		local angdiff = Angle(DRC.CalcView.ThirdPerson.Ang.x - ply:EyeAngles().x, DRC.CalcView.ThirdPerson.Ang.y - ply:EyeAngles().y, 0)
		angdiff:Normalize()
		if math.abs(angdiff.y) > 130 then angdiff.x = 0 angdiff.y = 0 end
			
		DRC.CalcView.ThirdPerson.HeadAngLerp = LerpAngle(FrameTime()*5, DRC.CalcView.ThirdPerson.HeadAngLerp or angdiff, angdiff)
		
		ply:SetPoseParameter("head_yaw", DRC.CalcView.ThirdPerson.HeadAngLerp.y)
		ply:SetPoseParameter("head_pitch", DRC.CalcView.ThirdPerson.HeadAngLerp.x*3)
	end
end)

hook.Add("CalcView", "!drc_thirdperson", function(ply, pos, angles, fov)
	if !IsValid(ply) then return end
	if !ply:Alive() then return end
	if ply:InVehicle() then return end
	local wpn = LocalPlayer():GetActiveWeapon()
	local sd, scoped = DRC:SightsDown(wpn)
	if !wpn.Draconic && sd then return
	elseif wpn.Draconic && scoped && sd then return end
	
	if DRC:ThirdPersonEnabled(ply) == true then
		if !DRC:ShouldDoDRCThirdPerson(ply) then return end
		local wpn = ply:GetActiveWeapon()
		if wpn.ASTWTWO && GetConVar("cl_drc_thirdperson"):GetFloat() == 0 then return end
		local PSMul = ply:GetModelScale()
		local root = LocalPlayer():LookupBone("ValveBiped.Bip01_Pelvis")
		local bpos
		if root != nil then bpos = LocalPlayer():GetBonePosition(root) end
		local av = ply:GetAimVector()
		local ea = DRC.CalcView.ThirdPerson.Ang
		local ep = ply:EyePos()
		local pos = ply:GetPos()
		
		local settings = DRC.ThirdPerson.LerpedSettings
		local basepoint = math.Round(settings.BasePoint)
		if DRC.CalcView.ThirdPerson.EditorOpen == true then settings = DRC.ThirdPerson.EditorSettings end
		local attcheck
		if basepoint == 1 then
			attcheck = ply:LookupAttachment("eyes")
			if attcheck != 0 then bpos = ply:GetAttachment(attcheck).Pos else bpos = ply:GetPos() + Vector(0,0,ply:GetCollisionBounds().Z - 10) end
		elseif basepoint == 2 then
			bpos = Vector(ply:GetPos() + ply:OBBCenter())
		end
		
		if !DRC:ValveBipedCheck(ply) && basepoint == 0 then
			local attcheck = ply:LookupAttachment("hips")
			if attcheck != 0 then
				local newpos = ply:GetAttachment(attcheck).Pos
				bpos = newpos
			else
				local attcheck = ply:LookupAttachment("pelvis")
				if attcheck != 0 then
					local newpos = ply:GetAttachment(attcheck).Pos
					bpos = newpos
				else
					bpos = LocalPlayer():GetPos() + LocalPlayer():OBBCenter()
				end
			end
		end
		
		if !DRC.ThirdPerson.CamLerp then DRC.ThirdPerson.CamLerp = Vector() end
		DRC.ThirdPerson.CamLerp.z = Lerp(0.2, DRC.ThirdPerson.CamLerp.z or bpos.z, bpos.z)
		bpos.z = DRC.ThirdPerson.CamLerp.z
		bpos.x = pos.x
		bpos.y = pos.y
		
	--	bpos = LocalPlayer():GetPos() + LocalPlayer():OBBCenter()
		
		local ht = "default"
		if IsValid(wpn) then ht = string.lower(wpn:GetHoldType()) end
		if !DRC.ThirdPerson.DefaultOffsets[ht] then ht = "duel" end
		
		local offset
		local flipshoulder = GetConVar("cl_drc_thirdperson_flipside"):GetFloat() == 1
		
		if settings.UseBaseOffsets == true then
			offset = (DRC.ThirdPerson.DefaultOffsets[ht] * PSMul) or (DRC.ThirdPerson.DefaultOffsets["duel"] * PSMul)
		
			if flipshoulder then
				offset = (Vector(DRC.ThirdPerson.DefaultOffsets[ht].x, -DRC.ThirdPerson.DefaultOffsets[ht].y, DRC.ThirdPerson.DefaultOffsets[ht].z) * PSMul) or (Vector(DRC.ThirdPerson.DefaultOffsets["duel"].x, -DRC.ThirdPerson.DefaultOffsets["duel"].y, DRC.ThirdPerson.DefaultOffsets["duel"].z) * PSMul)
			end
		else
			offset = settings.Offset * PSMul
			if flipshoulder then
				offset = Vector(offset.x, -offset.y, offset.z)
			end
		end
		
		if wpn.ThirdpersonOffset && (wpn:GetNWBool("Passive") != true) then offset = wpn.ThirdpersonOffset end
		
		offset_lerp = LerpVector(RealFrameTime() * 10, offset_lerp or offset, offset)
		
		local bonepos = bpos
		bpos = LocalToWorld(offset_lerp, ea, bpos, ea)
		
		local trZ = util.TraceLine({
			start = bonepos,
			endpos = bpos + ea:Up() * settings.Height * PSMul,
			filter = function(ent) if ent == ply then return false end end
		})
		
		local tr = util.TraceLine({
			start = trZ.HitPos,
			endpos = trZ.HitPos + ea:Forward() * -settings.Length * PSMul,
			filter = function(ent) if ent == ply then return false end end
		})
		
		if !DRC.CalcView.ThirdPerson.StoredAng then DRC.CalcView.ThirdPerson.StoredAng = ply:EyeAngles() end
		
		if DRC.CalcView.ThirdPerson.Live == true then
			if DRC.CalcView.ThirdPerson.Directional == true && DRC.CalcView.ThirdPerson.FreelookForced == false then
				ply:SetEyeAngles(ea + DRC.CalcView.ThirdPerson.DirectionalAng)
				DRC.CalcView.ThirdPerson.Ang_Stored = ea
			else
				if DRC.CalcView.ThirdPerson.Poked == true then
					ply:SetEyeAngles(DRC.CalcView.ThirdPerson.Ang)
				else
					if settings.FocalPoint == 0 then DRC.CalcView.ThirdPerson.Ang = ply:EyeAngles() end
				end
			end
			DRC.CalcView.ThirdPerson.StoredAng = DRC.CalcView.ThirdPerson.Ang
		elseif DRC.CalcView.ThirdPerson.FreelookForced == false then
			if settings.ForceDirectional == false then ply:SetEyeAngles(DRC.CalcView.ThirdPerson.StoredAng)
			else ply:SetEyeAngles(DRC.CalcView.ThirdPerson.DirectionalEyeAngles) end
		end
		
		local hitposaim = util.TraceLine({start = DRC.CalcView.ThirdPerson.LerpedFinalPos, endpos = ply:GetEyeTraceNoCursor().HitPos})
		hitposaim = hitposaim.Normal:Angle()
		
		local AAAA = math.Clamp(0.5/RealFrameTime(), 1, 100)
		local lpos, lang = (RealFrameTime() * AAAA) * settings.LerpPos, (RealFrameTime()*2 * AAAA) * settings.LerpAngle
		
		if !DRC.CalcView.ThirdPerson.LerpedFinalPos then DRC.CalcView.ThirdPerson.LerpedFinalPos = ply:EyePos() end
		DRC.CalcView.ThirdPerson.LerpedZPos = Lerp(lpos*10, DRC.CalcView.ThirdPerson.LerpedZPos or tr.HitPos.z, tr.HitPos.z)
		tr.HitPos.z = DRC.CalcView.ThirdPerson.LerpedZPos
		DRC.CalcView.ThirdPerson.LerpedFinalPos = LerpVector(lpos, tr.HitPos or DRC.CalcView.ThirdPerson.LerpedFinalPos, DRC.CalcView.ThirdPerson.LerpedFinalPos)
		
	--	if settings.FocalPoint == 2 then
	--		hitposaim = ply:GetAttachment(ply:LookupAttachment("eyes")).Ang
	--	end
		
		if !DRC.CalcView.ThirdPerson.LerpedFinalAng then DRC.CalcView.ThirdPerson.LerpedFinalAng = ply:EyeAngles() end
		DRC.CalcView.ThirdPerson.LerpedFinalAng = LerpAngle(lang, DRC.CalcView.ThirdPerson.Ang or DRC.CalcView.ThirdPerson.LerpedFinalAng, DRC.CalcView.ThirdPerson.LerpedFinalAng)
		if !DRC.CalcView.ThirdPerson.LerpedHitPosAng then DRC.CalcView.ThirdPerson.LerpedHitPosAng = ply:EyeAngles() end
		DRC.CalcView.ThirdPerson.LerpedHitPosAng = LerpAngle(lang, hitposaim or DRC.CalcView.ThirdPerson.LerpedHitPosAng, DRC.CalcView.ThirdPerson.LerpedHitPosAng)
		
		local ea2 = ply:EyeAngles()
		if !DRC.CalcView.ThirdPerson.LerpedHitPosCorrection then DRC.CalcView.ThirdPerson.LerpedHitPosCorrection = ea2 end
		DRC.CalcView.ThirdPerson.LerpedHitPosCorrection = LerpAngle(lang, (Angle(ea2.x,ea2.y*2,0)-Angle(hitposaim.x, hitposaim.y*2, 0)) or DRC.CalcView.ThirdPerson.LerpedHitPosCorrection, DRC.CalcView.ThirdPerson.LerpedHitPosCorrection)
		
		if DRC:ThirdPersonEnabled(ply) == true then
			view = {}
			
			if settings.FocalPoint == 1 then
				view.origin = DRC.CalcView.ThirdPerson.LerpedFinalPos
				view.angles = DRC.CalcView.ThirdPerson.LerpedFinalAng + (ea2 - DRC.CalcView.ThirdPerson.LerpedHitPosAng) - DRC.CalcView.ThirdPerson.LerpedHitPosCorrection
	--		elseif settings.FocalPoint == 2 then view.angles = DRC.CalcView.ThirdPerson.LerpedHitPosAng + Angle(-20, 0, 0)
			else
				view.origin = DRC.CalcView.ThirdPerson.LerpedFinalPos
				view.angles = DRC.CalcView.ThirdPerson.LerpedFinalAng
			end
			view.fov = settings.BaseFOV * (ply:GetFOV() / 100)
			view.drawviewer = true
			if tr.Hit then view.znear = 0.03 else view.znear = 1 end
		else
			view = {}
			view.origin = origin
			view.angles = ang3
			view.fov = fov
			view.drawviewer = false
			view.znear = 1
		end
		
		local shake, shakevert, shakeroll = DRC:GetCalcViewShake()
		view.origin = view.origin + (view.angles:Right() * shake)
		view.origin = view.origin + (view.angles:Up() * shakevert)
		view.angles.z = shakeroll
		
		return view
	end
end)