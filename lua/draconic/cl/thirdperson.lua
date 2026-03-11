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
	["LerpAngle"] = 0.5,
	["LerpPos"] = 1.33,
	["LerpPos_ADS"] = 0.5,
	["LerpTransition"] = 1,
	["BaseFOV"] = 75,
	["FocalPoint"] = 0, -- 0 player view, 1 hitpos, 2 head angle
	["BasePoint"] = 0, -- 0 pelvis, 1 eyes, 2 origin
	["ForceFreelook"] = false,
	["FreecamDelay"] = 3,
	["ForceDirectional"] = false,
	["LockPitch"] = false,
	["Entity"] = nil,
	["EntityAngles"] = false,
}

DRC.ThirdPerson.LoadedSettings = {
	["Length"] = 100,
	["Height"] = 25,
	["UseBaseOffsets"] = true,
	["AllowFreeLook"] = true,
	["Offset"] = Vector(25, 0, 0),
	["LerpAngle"] = 0.5,
	["LerpPos"] = 1.33,
	["LerpPos_ADS"] = 0.5,
	["LerpTransition"] = 1,
	["BaseFOV"] = 75,
	["FocalPoint"] = 0, -- 0 player view, 1 hitpos, 2 head angle
	["BasePoint"] = 0, -- 0 pelvis, 1 eyes, 2 origin
	["ForceFreelook"] = false,
	["FreecamDelay"] = 3,
	["ForceDirectional"] = false,
	["LockPitch"] = false,
	["Entity"] = nil,
	["EntityAngles"] = false,
}
DRC.ThirdPerson.LerpedSettings = {
	["Length"] = 100,
	["Height"] = 25,
	["UseBaseOffsets"] = true,
	["AllowFreeLook"] = true,
	["Offset"] = Vector(25, 0, 0),
	["LerpAngle"] = 0.5,
	["LerpPos"] = 1.33,
	["LerpPos_ADS"] = 0.5,
	["LerpTransition"] = 1,
	["BaseFOV"] = 75,
	["FocalPoint"] = 0, -- 0 player view, 1 hitpos, 2 head angle
	["BasePoint"] = 0, -- 0 pelvis, 1 eyes, 2 origin
	["ForceFreelook"] = false,
	["FreecamDelay"] = 3,
	["ForceDirectional"] = false,
	["LockPitch"] = false,
	["Entity"] = nil,
	["EntityAngles"] = false,
}

DRC.ThirdPerson.DefaultSettings = {
	["Length"] = 100,
	["Height"] = 25,
	["UseBaseOffsets"] = true,
	["AllowFreeLook"] = true,
	["Offset"] = Vector(25, 0, 0),
	["LerpAngle"] = 0.5,
	["LerpPos"] = 1.33,
	["LerpPos_ADS"] = 0.5,
	["LerpTransition"] = 1,
	["BaseFOV"] = 75,
	["FocalPoint"] = 0, -- 0 player view, 1 hitpos, 2 head angle
	["BasePoint"] = 0, -- 0 pelvis, 1 eyes, 2 origin
	["ForceFreelook"] = false,
	["FreecamDelay"] = 3,
	["ForceDirectional"] = false,
	["LockPitch"] = false,
	["Entity"] = nil,
	["EntityAngles"] = false,
}

DRC.ThirdPerson.ASTWInterpreter = {
	["Length"] = 100,
	["Height"] = 25,
	["UseBaseOffsets"] = false,
	["AllowFreeLook"] = false,
	["Offset"] = Vector(25, 0, 0),
	["LerpAngle"] = 0.5,
	["LerpPos"] = 1.33,
	["LerpPos_ADS"] = 0.5,
	["LerpTransition"] = 1,
	["BaseFOV"] = 75,
	["FocalPoint"] = 0,
	["BasePoint"] = 0,
	["ForceFreelook"] = false,
	["FreecamDelay"] = 3,
	["ForceDirectional"] = false,
	["LockPitch"] = false,
	["Entity"] = nil,
	["EntityAngles"] = false,
}
DRC.ThirdPerson.ASTWInterpreter_Aim = {
	["Length"] = 100,
	["Height"] = 25,
	["UseBaseOffsets"] = false,
	["AllowFreeLook"] = false,
	["Offset"] = Vector(25, 0, 0),
	["LerpAngle"] = 0.5,
	["LerpPos"] = 1.33,
	["LerpPos_ADS"] = 0.5,
	["LerpTransition"] = 1,
	["BaseFOV"] = 75,
	["FocalPoint"] = 0,
	["BasePoint"] = 0,
	["ForceFreelook"] = false,
	["FreecamDelay"] = 3,
	["ForceDirectional"] = false,
	["LockPitch"] = false,
	["Entity"] = nil,
	["EntityAngles"] = false,
}
DRC.ThirdPerson.ASTWInterpreter_Crouch = {
	["Length"] = 100,
	["Height"] = 25,
	["UseBaseOffsets"] = false,
	["AllowFreeLook"] = false,
	["Offset"] = Vector(25, 0, 0),
	["LerpAngle"] = 0.5,
	["LerpPos"] = 1.33,
	["LerpPos_ADS"] = 0.5,
	["LerpTransition"] = 1,
	["BaseFOV"] = 75,
	["FocalPoint"] = 0,
	["BasePoint"] = 0,
	["ForceFreelook"] = false,
	["FreecamDelay"] = 3,
	["ForceDirectional"] = false,
	["LockPitch"] = false,
	["Entity"] = nil,
	["EntityAngles"] = false,
}

local astwtodrcorigins = { -- 0 pelvis, 1 eyes, 2 origin
	[0] = 1,
	[1] = 2,
	[2] = 2,
	[3] = 0
}
function DRC:ReInterpretASTW()
	local enforced = GetConVar("astw2_force_camera"):GetBool()
	local length, height, baseoffest, lerpspeed, basefov
	local length_aim, height_aim, baseoffest_aim, lerpspeed_aim
	local length_cr, height_cr, baseoffest_cr, lerpspeed_cr
	local origin, origin_aim, origin_cr
	local alwaysaim = GetConVar("astw2_always_aim"):GetBool()
	
	-- Passive: ccp | Aim: cc | Sprint: ccs | Crouch: ccc
	if !enforced then
		length = -GetConVar("astw2_ccp_forward"):GetFloat()
		height = GetConVar("astw2_ccp_up"):GetFloat()
		baseoffest = Vector(0, -GetConVar("astw2_ccp_right"):GetFloat(), 0)
		lerpspeed = 1.8-GetConVar("astw2_ccp_lerp"):GetFloat()
		basefov = GetConVar("astw2_camera_fov"):GetFloat()
		origin = astwtodrcorigins[GetConVar("astw2_ccp_attachment"):GetInt()]
		
		length_aim = -GetConVar("astw2_cc_forward"):GetFloat()
		height_aim = GetConVar("astw2_cc_up"):GetFloat()
		baseoffest_aim = Vector(0, -GetConVar("astw2_cc_right"):GetFloat(), 0)
		lerpspeed_aim = 1.8-GetConVar("astw2_cc_lerp"):GetFloat()
		origin_aim = astwtodrcorigins[GetConVar("astw2_cc_attachment"):GetInt()]
		
		length_cr = -GetConVar("astw2_ccc_forward"):GetFloat()
		height_cr = GetConVar("astw2_ccc_up"):GetFloat()
		baseoffest_cr = Vector(0, -GetConVar("astw2_ccc_right"):GetFloat(), 0)
		lerpspeed_cr = 1.8-GetConVar("astw2_ccc_lerp"):GetFloat()
		origin_cr = astwtodrcorigins[GetConVar("astw2_ccc_attachment"):GetInt()]
	else
		length = -GetConVar("astw2_ccp_forward_f"):GetFloat()
		height = GetConVar("astw2_ccp_up_f"):GetFloat()
		baseoffest = Vector(0, -GetConVar("astw2_ccp_right_f"):GetFloat(), 0)
		lerpspeed = 1.8-GetConVar("astw2_ccp_lerp_f"):GetFloat()
		basefov = GetConVar("astw2_forced_fieldofview"):GetFloat()
		origin = astwtodrcorigins[GetConVar("astw2_cc_attachment"):GetInt()]
		
		length_aim = -GetConVar("astw2_cc_forward_f"):GetFloat()
		height_aim = GetConVar("astw2_cc_up_f"):GetFloat()
		baseoffest_aim = Vector(0, -GetConVar("astw2_cc_right_f"):GetFloat(), 0)
		lerpspeed_aim = 1.8-GetConVar("astw2_cc_lerp_f"):GetFloat()
		origin_aim = astwtodrcorigins[GetConVar("astw2_cc_attachment_f"):GetInt()]
		
		length_cr = -GetConVar("astw2_ccc_forward_f"):GetFloat()
		height_cr = GetConVar("astw2_ccc_up_f"):GetFloat()
		baseoffest_cr = Vector(0, -GetConVar("astw2_ccc_right_f"):GetFloat(), 0)
		lerpspeed_cr = 1.8-GetConVar("astw2_ccc_lerp_f"):GetFloat()
		origin_cr = astwtodrcorigins[GetConVar("astw2_ccc_attachment_f"):GetInt()]
	end
	
	DRC.ThirdPerson.ASTWInterpreter = {
		["Length"] = length,
		["Height"] = height,
		["UseBaseOffsets"] = false,
		["AllowFreeLook"] = alwaysaim,
		["Offset"] = baseoffest,
		["LerpAngle"] = 0.1,
		["LerpPos"] = lerpspeed,
		["LerpPos_ADS"] = lerpspeed,
		["LerpTransition"] = 1,
		["BaseFOV"] = basefov,
		["FocalPoint"] = 0,
		["BasePoint"] = origin,
		["ForceFreelook"] = false,
		["FreecamDelay"] = 3,
		["ForceDirectional"] = false,
	}
	
	DRC.ThirdPerson.ASTWInterpreter_Aim = {
		["Length"] = length_aim,
		["Height"] = height_aim,
		["UseBaseOffsets"] = false,
		["AllowFreeLook"] = alwaysaim,
		["Offset"] = baseoffest_aim,
		["LerpAngle"] = 0.1,
		["LerpPos"] = lerpspeed_aim,
		["LerpPos_ADS"] = lerpspeed_aim,
		["LerpTransition"] = 1,
		["BaseFOV"] = basefov,
		["FocalPoint"] = 0,
		["BasePoint"] = origin_aim,
		["ForceFreelook"] = false,
		["FreecamDelay"] = 3,
		["ForceDirectional"] = false,
	}
	
	DRC.ThirdPerson.ASTWInterpreter_Crouch = {
		["Length"] = length_cr,
		["Height"] = height_cr,
		["UseBaseOffsets"] = false,
		["AllowFreeLook"] = alwaysaim,
		["Offset"] = baseoffest_cr,
		["LerpAngle"] = 0.1,
		["LerpPos"] = lerpspeed_cr,
		["LerpPos_ADS"] = lerpspeed_cr,
		["LerpTransition"] = 1,
		["BaseFOV"] = basefov,
		["FocalPoint"] = 0,
		["BasePoint"] = origin_cr,
		["ForceFreelook"] = false,
		["FreecamDelay"] = 3,
		["ForceDirectional"] = false,
	}
end
if ASTW2_INSTALLED then DRC:ReInterpretASTW() end

local lastload = GetConVar("cl_drc_thirdperson_preset"):GetString()
if lastload && lastload != "" && file.Find("draconic/thirdperson/".. lastload ..".json", "DATA") != nil then
	local initialpreset = file.Read("draconic/thirdperson/".. lastload ..".json", "DATA")
	if initialpreset then
		local tbl = util.JSONToTable(initialpreset)
		table.CopyFromTo(tbl, DRC.ThirdPerson.LoadedSettings)
		table.CopyFromTo(tbl, DRC.ThirdPerson.EditorSettings)
		DRC:UpdateThirdPersonEditorMenu()
	end
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

local controlx, controly
hook.Add("CreateMove", "!drc_cacheusercmd", function(cmd)
	DRC.MoveInfo = {
		["Mouse"] = { controlx, controly },
		["Forward"] = cmd:GetForwardMove(),
		["Side"] = cmd:GetSideMove(),
	}
end)

hook.Add("InputMouseApply", "!drc_controllerthirdperson", function(cmd, x, y, ang)
	controlx = x
	controly = y
	if GetConVar("joystick"):GetBool() == true then
		if GetConVar("joy_inverty"):GetBool() == true then controly = -y end
		local xsens, ysens = GetConVar("joy_yawsensitivity"):GetFloat()*0.25, GetConVar("joy_pitchsensitivity"):GetFloat()*0.25
		controlx = controlx * -xsens
		controly = controly * ysens
	end
end)
-- why does the controller system that emulates the mouse not automatically feed into user commands for mouse???

hook.Add("CreateMove", "!drc_thirdpersoncontrol", function(cmd)
	local ply = DRC.LocalPlayer
	if !IsValid(ply) then return end
	
	local indrctp = DRC.ThirdPersonIO > 0.001
	
	
	--if settings.AllowFreeLook == true then DRC.CalcView.ThirdPerson.Poked = false end
	if CurTime() > DRC.CalcView.ThirdPerson.PokeTime then
		DRC.CalcView.ThirdPerson.Live = false
	end
	
	if ply:Alive() && indrctp then
		local wpn = ply:GetActiveWeapon()
		local settings = wpn.ThirdPersonProfileOverride or DRC.ThirdPerson.LoadedSettings
		if !settings.LerpTransition then settings.LerpTransition = 1 end
		for k,v in pairs(settings) do -- used to interpolate profile changes for scripted systems that utilize profile overrides.
			if !isbool(v) && !isstring(v) && !isentity(v) then
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
		
		local lockpitch = settings.LockPitch == true && ply:GetMoveType() == MOVETYPE_WALK
		
		local sens = ply:GetFOV() / 100
		
		DRC.MoveInfo.Mouse.X = (DRC.MoveInfo.Mouse[1] * GetConVar("m_yaw"):GetFloat()) * sens
		DRC.MoveInfo.Mouse.Y = (DRC.MoveInfo.Mouse[2] * GetConVar("m_pitch"):GetFloat()) * sens
		local mx, my = DRC.MoveInfo.Mouse.X, DRC.MoveInfo.Mouse.Y
		
		local pokers = {
			ply:KeyDown(IN_ATTACK),
			ply:KeyDown(IN_ATTACK2),
			ply:KeyDown(IN_USE),
			ply:KeyReleased(IN_ATTACK),
			ply:KeyReleased(IN_ATTACK2),
			ply:KeyReleased(IN_USE),
		}
		
		if settings.ForceDirectional != true then
			for k,v in pairs(pokers) do
				if v == true then DRC:ThirdPerson_PokeLiveAngle(ply) end
			end
		end

		if DRC.MoveInfo.Forward != 0 then DRC:ThirdPerson_PokeLiveAngle(ply) end
		if DRC.MoveInfo.Side != 0 then DRC:ThirdPerson_PokeLiveAngle(ply) end
		
		if !DRC.CalcView then DRC.CalcView = {} end
		if !DRC.CalcView.ThirdPerson then DRC.CalcView.ThirdPerson = {} end
		if !DRC.CalcView.ThirdPerson.Ang then DRC.CalcView.ThirdPerson.Ang = cmd:GetViewAngles() end
		
		DRC.CalcView.ThirdPerson.Ang = DRC.CalcView.ThirdPerson.Ang + Angle(my, -mx, 0)
		DRC.CalcView.ThirdPerson.Ang.X = math.Clamp(DRC.CalcView.ThirdPerson.Ang.X, -85, 89)
		
		local vy = ((DRC.CalcView.ThirdPerson.StoredAng.y+180)%360)-180
		DRC.CalcView.ThirdPerson.StoredAng = Angle(DRC.CalcView.ThirdPerson.StoredAng.x, vy, DRC.CalcView.ThirdPerson.StoredAng.z)
		
		if DRC.CalcView.ThirdPerson.Live == false && (settings.AllowFreeLook or DRC.CalcView.ThirdPerson.FreelookForced) then
			local atu = DRC.CalcView.ThirdPerson.StoredAng or cmd:GetViewAngles()
		--	cmd:SetViewAngles(atu)
			return
		end

		if DRC.CalcView.ThirdPerson.Directional && !DRC.CalcView.ThirdPerson.FreelookForced then
			local locked = (DRC.CalcView.ThirdPerson.StoredAng or cmd:GetViewAngles()) + DRC.CalcView.ThirdPerson.DirectionalAng
		--	cmd:SetViewAngles(locked)
			DRC.CalcView.ThirdPerson.Ang_Stored = locked
		elseif DRC.CalcView.ThirdPerson.Poked then
		--	cmd:SetViewAngles(DRC.CalcView.ThirdPerson.Ang)
		else
			DRC.CalcView.ThirdPerson.Ang = cmd:GetViewAngles()
			DRC.CalcView.ThirdPerson.StoredAng = DRC.CalcView.ThirdPerson.Ang
		end
		
		if IsValid(wpn) then
			local ht = wpn:GetHoldType()
			
			if (fullranges[ht] or settings.ForceDirectional == true) && wpn.ThirdpersonNoFreelook != true && settings.AllowFreeLook == true then
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
				if lockpitch == true && DRC.CalcView.ThirdPerson.DirectionalEyeAngles then
					DRC.CalcView.ThirdPerson.DirectionalAng.x = 0
					DRC.CalcView.ThirdPerson.DirectionalEyeAngles.x = 0
				end
			else
				DRC.CalcView.ThirdPerson.DirectionalAng = Angle()
				DRC.CalcView.ThirdPerson.DirectionalEyeAngles = ply:EyeAngles()
				if lockpitch == true && DRC.CalcView.ThirdPerson.DirectionalEyeAngles then
					DRC.CalcView.ThirdPerson.DirectionalAng.x = 0
					DRC.CalcView.ThirdPerson.DirectionalEyeAngles.x = 0
				end
			end
		
			if DRC:SightsDown(wpn) then
				DRC.CalcView.ThirdPerson.Live = true
				DRC.CalcView.ThirdPerson.StoredAng = ply:EyeAngles()
			elseif !DRC:SightsDown(wpn) && DRC.CalcView.ThirdPerson.Live == false then
				DRC.CalcView.ThirdPerson.Live = false
			end
			
			if !DRC:SightsDown(wpn) then
				if wpn.ASTWTWO then ASTW2Anticlipping(DRC.LocalPlayer, false, false) end
			end
		end
	end
end)

hook.Add("PrePlayerDraw", "!drc_thirdpersonlook", function(ply)
	if !IsValid(ply) then return end
	if ply != DRC.LocalPlayer then return end
	if GetConVar("cl_drc_thirdperson"):GetInt() == 1 && DRC.CalcView.ThirdPerson.Live == false then
		local angdiff = Angle(DRC.CalcView.ThirdPerson.Ang.x - ply:EyeAngles().x, DRC.CalcView.ThirdPerson.Ang.y - ply:EyeAngles().y, 0)
		angdiff:Normalize()
		if math.abs(angdiff.y) > 130 then angdiff.x = 0 angdiff.y = 0 end
			
		DRC.CalcView.ThirdPerson.HeadAngLerp = LerpAngle(FrameTime()*5, DRC.CalcView.ThirdPerson.HeadAngLerp or angdiff, angdiff)
		
		ply:SetPoseParameter("head_yaw", DRC.CalcView.ThirdPerson.HeadAngLerp.y)
		ply:SetPoseParameter("head_pitch", DRC.CalcView.ThirdPerson.HeadAngLerp.x*3)
	end
end)

DRC.ThirdPersonIO = 0
local transitiontick = 0
hook.Add("CalcView", "!drc_thirdperson", function(ply, pos, angles, fov)
	if !IsValid(DRC.LocalPlayer) then return end
	if !ply:Alive() then return end
	local wpn = DRC.LocalPlayer:GetActiveWeapon()
	local sd, scoped = DRC:SightsDown(wpn)
	if !wpn.Draconic && sd then return
	elseif wpn.Draconic && scoped && sd then return end
	
	local rft = RealFrameTime()
	local real = RealTime()
	local dodrctp = DRC:ShouldDoDRCThirdPerson(ply)
	local toadd = 0.033
	if !dodrctp then toadd = -toadd end
	
	if real > transitiontick then
		toadd = toadd*50*rft
		DRC.ThirdPersonIO = math.Clamp(DRC.ThirdPersonIO + toadd, 0, 1)
		transitiontick = real + 0.001
	end
	
	if DRC.ThirdPersonIO > 0.001 then
		DRC.CalcView.ThirdPerson.LerpedFinalPos = DRC.CalcView.ThirdPerson.LerpedFinalPos or ply:EyePos()
		DRC.CalcView.ThirdPerson.LerpedFinalAng = DRC.CalcView.ThirdPerson.LerpedFinalAng or ply:EyeAngles()
		DRC.CalcView.ThirdPerson.StoredAng = DRC.CalcView.ThirdPerson.StoredAng or ply:EyeAngles()
		local wpn = ply:GetActiveWeapon()
		local PSMul = ply:GetModelScale()
		local root = DRC.LocalPlayer:LookupBone("ValveBiped.Bip01_Pelvis")
		local bpos
		if root != nil then bpos = DRC.LocalPlayer:GetBonePosition(root) end
		local av = ply:GetAimVector()
		local ea = DRC.CalcView.ThirdPerson.Ang
		local ep = ply:EyePos()
		local pos = ply:GetPos()
		
		local settings = DRC.ThirdPerson.LerpedSettings
		local lockpitch = settings.LockPitch == true && ply:GetMoveType() == MOVETYPE_WALK
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
					bpos = DRC.LocalPlayer:GetPos() + DRC.LocalPlayer:OBBCenter()
				end
			end
		end
		
		local etu = ply
		local override = IsValid(settings.Entity)
		if override then
			etu = settings.Entity
			bpos = etu:GetPos()
			pos = etu:GetPos()
			ep = etu:EyePos()
		end
		
		if !DRC.ThirdPerson.CamLerp then DRC.ThirdPerson.CamLerp = Vector() end
		bpos.x = pos.x
		bpos.y = pos.y
		
		local ht = "default"
		if IsValid(wpn) then ht = string.lower(wpn:GetHoldType()) end
		if !DRC.ThirdPerson.DefaultOffsets[ht] then ht = "duel" end
		
		local offset
		local doffset = 0
		local flipshoulder = GetConVar("cl_drc_thirdperson_flipside"):GetFloat() == 1
		
		local function autoflip(theoff)
			local refpos = ep
			local refang = Angle(0, etu:EyeAngles().y, 0)
			local forward = refang:Forward()
			local right = refang:Right()
			
			local function SideClear(off)
				local trace = util.TraceHull({
					start = refpos,
					endpos = refpos + off,
					mins = Vector(-6, -6, -6),
					maxs = Vector(6, 6, 6),
					filter = etu
				})
				return trace
			end
			
			local sideoffset = math.abs(theoff.y)*3
			local RightCheck = SideClear(right * sideoffset+forward*15)
			local LeftCheck  = SideClear(-right * sideoffset+forward*15)
			local ForwardTrace = util.TraceLine({ start = refpos, endpos = refpos + forward * 400, filter = etu })
			local RightTrace = util.TraceLine({ start = refpos, endpos = refpos + right * 25, filter = etu })
			local CornerTrace = util.TraceLine({ start = refpos, endpos = refpos + right * 50 + forward * 100, filter = etu })
			
			if GetConVar("cl_drc_debugmode"):GetInt() != 0 then
				if LeftCheck then
					local l = ClientsideModel("models/hunter/blocks/cube025x025x025.mdl", RENDERGROUP_TRANSLUCENT)
					l:SetRenderMode(RENDERMODE_TRANSADD)
					l:SetMaterial("models/debug/debugwhite")
					if !LeftCheck.Hit then l:SetColor(Color(0,255,0,127)) else l:SetColor(Color(255,0,0,127)) end
					l:SetPos(LeftCheck.HitPos)
					l:SetAngles(refang)
					l:Spawn()
					l:Remove()
				end
				
				if RightCheck then
					local l = ClientsideModel("models/hunter/blocks/cube025x025x025.mdl")
					l:SetRenderMode(RENDERMODE_TRANSADD)
					l:SetMaterial("models/debug/debugwhite")
					if !RightCheck.Hit then l:SetColor(Color(0,255,0,127)) else l:SetColor(Color(255,0,0,127)) end
					l:SetPos(RightCheck.HitPos)
					l:SetAngles(refang)
					l:Spawn()
					l:Remove()
				end
			end
			
			local rtf = RightTrace.Fraction < 0.333
			local irtf = RightTrace.Fraction > 0.333
			
			if ForwardTrace.Hit or RightTrace.Hit or CornerTrace.Hit then
				if !RightCheck.Hit && LeftCheck.Hit then
					theoff = Vector(theoff.x, theoff.y, theoff.z)
				elseif !LeftCheck.Hit && RightCheck.Hit then
					theoff = Vector(theoff.x, -theoff.y, theoff.z)
				end
			end
			return theoff
		end
		
		local autoswitch = GetConVar("cl_drc_thirdperson_autoflip"):GetInt() == 1
		if settings.UseBaseOffsets == true then
			offset = (DRC.ThirdPerson.DefaultOffsets[ht] * PSMul) or (DRC.ThirdPerson.DefaultOffsets["duel"] * PSMul)
			
			if autoswitch then offset = autoflip(offset)
				else
				if flipshoulder then
					offset = (Vector(DRC.ThirdPerson.DefaultOffsets[ht].x, -DRC.ThirdPerson.DefaultOffsets[ht].y, DRC.ThirdPerson.DefaultOffsets[ht].z) * PSMul) or (Vector(DRC.ThirdPerson.DefaultOffsets["duel"].x, -DRC.ThirdPerson.DefaultOffsets["duel"].y, DRC.ThirdPerson.DefaultOffsets["duel"].z) * PSMul)
				end
			end
			doffset = offset.x
			offset.x = 0
		else
			offset = settings.Offset * PSMul
			
			if autoswitch then offset = autoflip(offset)
			else
				if flipshoulder then
					offset = Vector(offset.x, -offset.y, offset.z)
				end
			end
		end
		
		if wpn.ThirdpersonOffset && (wpn:GetNW2Bool("Passive") != true) then offset = wpn.ThirdpersonOffset end
		
		offset_lerp = LerpVector(rft * 10, offset_lerp or offset, offset)
		doffset_lerp = Lerp(rft * 10, doffset_lerp or doffset, doffset)
		
		local bonepos = bpos
		bpos = LocalToWorld(offset_lerp, ea, bpos, ea)
		
		local trZ = util.TraceLine({
			start = bonepos,
			endpos = bpos + ea:Up() * settings.Height * PSMul,
			mask = MASK_NPCSOLID_BRUSHONLY,
			filter = function(ent) if DRC:IsCharacter(ent) then return false end end
		})
		
		local tr = util.TraceLine({
			start = trZ.HitPos,
			endpos = trZ.HitPos + ea:Forward() * (doffset_lerp-settings.Length) * PSMul,
			mask = MASK_SHOT_PORTAL,
			filter = function(ent) if DRC:IsCharacter(ent) then return false end end
		})
		
		if tr then DRC:RenderTrace(tr, Color(255, 255, 255, 255), FrameTime(), true) end
		if trZ then DRC:RenderTrace(trZ, Color(255, 255, 255, 255), FrameTime(), true) end
		
		if !DRC.CalcView.ThirdPerson.StoredAng then DRC.CalcView.ThirdPerson.StoredAng = ply:EyeAngles() end
		
		if DRC.CalcView.ThirdPerson.Live == true then
			if DRC.CalcView.ThirdPerson.Directional == true && DRC.CalcView.ThirdPerson.FreelookForced == false then
				if lockpitch == true then
					ply:SetEyeAngles(Angle(0,ea.y,ea.z) + DRC.CalcView.ThirdPerson.DirectionalAng)
				else
					ply:SetEyeAngles(ea + DRC.CalcView.ThirdPerson.DirectionalAng)
				end
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
		
		local AAAA = math.Clamp(0.5/rft, 1, 100)
		local ltu = settings.LerpPos
		if sd then ltu = settings.LerpPos_ADS end
		local lpos, lang = (rft * AAAA) * ltu, (rft*2 * AAAA) * settings.LerpAngle
		
		local wallb = 0
		if tr.Hit then wallb = 1 end
		
		if !DRC.CalcView.ThirdPerson.WallBLerp then DRC.CalcView.ThirdPerson.WallBLerp = 0 end
		DRC.CalcView.ThirdPerson.WallBLerp = Lerp(0.95, wallb or DRC.CalcView.ThirdPerson.WallBLerp, DRC.CalcView.ThirdPerson.WallBLerp)
		
		local wallpos = tr.HitPos + tr.HitNormal:Angle():Forward() * 2
		DRC.CalcView.ThirdPerson.WallLerp = LerpVector(DRC.CalcView.ThirdPerson.WallBLerp, tr.HitPos, wallpos)
		
		DRC.CalcView.ThirdPerson.LerpedFinalPos = LerpVector(lpos, DRC.CalcView.ThirdPerson.WallLerp or DRC.CalcView.ThirdPerson.LerpedFinalPos, DRC.CalcView.ThirdPerson.LerpedFinalPos)
		
		if !DRC.CalcView.ThirdPerson.LerpedFinalAng then DRC.CalcView.ThirdPerson.LerpedFinalAng = ply:EyeAngles() end
		DRC.CalcView.ThirdPerson.LerpedFinalAng = LerpAngle(lang, DRC.CalcView.ThirdPerson.Ang or DRC.CalcView.ThirdPerson.LerpedFinalAng, DRC.CalcView.ThirdPerson.LerpedFinalAng)
		if !DRC.CalcView.ThirdPerson.LerpedHitPosAng then DRC.CalcView.ThirdPerson.LerpedHitPosAng = ply:EyeAngles() end
		DRC.CalcView.ThirdPerson.LerpedHitPosAng = LerpAngle(lang, hitposaim or DRC.CalcView.ThirdPerson.LerpedHitPosAng, DRC.CalcView.ThirdPerson.LerpedHitPosAng)
		
		local vp = ply:GetViewPunchAngles()
		local punch = (Angle(vp.x,vp.y,vp.z) * (1/DRC:GetFOVScale()))
		if !wpn.ASTWTWO then punch = punch*0.33 end -- viewpunch is almost 3x as strong when called in lua, don't ask me why
		
		DRC.CalcView.ThirdPerson.LerpedFinalAng:Add(punch)
		
		local view = {}
		if settings.FocalPoint == 1 then
			local ea2 = etu:EyeAngles()
			if !DRC.CalcView.ThirdPerson.LerpedHitPosCorrection then DRC.CalcView.ThirdPerson.LerpedHitPosCorrection = ea2 end
			DRC.CalcView.ThirdPerson.LerpedHitPosCorrection = LerpAngle(lang, (Angle(ea2.x,ea2.y*2,0)-Angle(hitposaim.x, hitposaim.y*2, 0)) or DRC.CalcView.ThirdPerson.LerpedHitPosCorrection, DRC.CalcView.ThirdPerson.LerpedHitPosCorrection)
			
			view.origin = DRC.CalcView.ThirdPerson.LerpedFinalPos
			view.angles = DRC.CalcView.ThirdPerson.LerpedFinalAng + (ea2 - DRC.CalcView.ThirdPerson.LerpedHitPosAng) - DRC.CalcView.ThirdPerson.LerpedHitPosCorrection
		else
			view.origin = DRC.CalcView.ThirdPerson.LerpedFinalPos
			view.angles = DRC.CalcView.ThirdPerson.LerpedFinalAng
		end
		view.fov = settings.BaseFOV * (ply:GetFOV() / 100)
		view.drawviewer = true
		
		local shake, shakevert, shakeroll = DRC:GetCalcViewShake()
		view.origin = view.origin + (view.angles:Right() * shake)
		view.origin = view.origin + (view.angles:Up() * shakevert)
		view.angles.z = shakeroll
		
		if override && settings.EntityAngles == true then
			DRC.CalcView.ThirdPerson.Ang = etu:GetAngles()
			view.angles = etu:GetAngles()
		end
		
		view.origin = LerpVector(DRC.ThirdPersonIO, ep, view.origin)
		view.fov = Lerp(DRC.ThirdPersonIO, ply:GetFOV(), view.fov)
		
		return view
	end
end)