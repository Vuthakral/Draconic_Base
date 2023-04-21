DRC.CalcView.ThirdPerson.Ang = Angle()
DRC.CalcView.ThirdPerson.Ang_Stored = Angle()
DRC.CalcView.ThirdPerson.DirectionalAng = Angle()
DRC.CalcView.ThirdPerson.Live = false
DRC.CalcView.ThirdPerson.PokeTime = CurTime()

function DRC:ThirdPerson_PokeLiveAngle(ply)
	if !DRC.CalcView.Thirdperson then DRC.CalcView.Thirdperson = {} end
	if !DRC.CalcView.Ang then DRC.CalcView.Ang = Angle() end
	if !DRC.CalcView.Ang_Stored then DRC.CalcView.Ang_Stored = Angle() end
	if !DRC.CalcView.DirectionalAng then DRC.CalcView.DirectionalAng = Angle() end
	if !DRC.CalcView.Live then DRC.CalcView.Live = false end
	if !DRC.CalcView.PokeTime then DRC.CalcView.PokeTime = CurTime() end
	if DRC.CalcView.ThirdPerson.PokeTime == nil then DRC.CalcView.ThirdPerson.PokeTime = CurTime() end
	if CurTime() < DRC.CalcView.ThirdPerson.PokeTime then return end
	DRC.CalcView.ThirdPerson.Live = true
	DRC.CalcView.ThirdPerson.Poked = true
	DRC.CalcView.ThirdPerson.PokeTime = CurTime() + 3
	
	timer.Simple(engine.TickInterval() + 0.01, function()
		DRC.CalcView.ThirdPerson.Poked = false
	end)
	timer.Simple(3.01, function()
		if CurTime() > DRC.CalcView.ThirdPerson.PokeTime then
		DRC.CalcView.ThirdPerson.Live = false
		end
	end)
end

hook.Add("CreateMove", "!drc_thirdpersoncontrol", function(cmd)
	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	local wpn = ply:GetActiveWeapon()
	if DRC:IsDraconicThirdPersonEnabled(ply) != true then return end
	if GetConVar("sv_drc_disable_thirdperson_freelook"):GetFloat() == 1 or GetConVar("cl_drc_thirdperson_disable_freelook"):GetFloat() == 1 then
		DRC:ThirdPerson_PokeLiveAngle(ply)
	elseif IsValid(wpn) && wpn.ThirdpersonNoFreelook == true then
		DRC:ThirdPerson_PokeLiveAngle(ply)
	end
	DRC.MoveInfo = {
		["Mouse"] = { cmd:GetMouseX(), cmd:GetMouseY() },
		["Forward"] = cmd:GetForwardMove(),
		["Side"] = cmd:GetSideMove(),
	}
	
	local sens = ply:GetFOV() / 100

	DRC.MoveInfo.Mouse.X = (DRC.MoveInfo.Mouse[1] * 0.03) * sens
	DRC.MoveInfo.Mouse.Y = (DRC.MoveInfo.Mouse[2] * 0.03) * sens
	
	DRC.CalcView.ThirdPerson.Ang = DRC.CalcView.ThirdPerson.Ang + Angle(DRC.MoveInfo.Mouse.Y, -DRC.MoveInfo.Mouse.X, 0)
	DRC.CalcView.ThirdPerson.Ang.X = math.Clamp(DRC.CalcView.ThirdPerson.Ang.X, -85, 90)
	
	local pokers = {
		ply:KeyDown(IN_ATTACK),
		ply:KeyDown(IN_ATTACK2),
		ply:KeyDown(IN_USE),
	}
	
	for k,v in pairs(pokers) do
		if v == true then DRC:ThirdPerson_PokeLiveAngle(ply) end
	end

	if DRC.MoveInfo.Forward != 0 then DRC:ThirdPerson_PokeLiveAngle(ply) end
	if DRC.MoveInfo.Side != 0 then DRC:ThirdPerson_PokeLiveAngle(ply) end
	
	local wpn = ply:GetActiveWeapon()
	if IsValid(wpn) then
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
		local ht = wpn:GetHoldType()
		
		if fullranges[ht] && wpn.ThirdpersonNoFreelook != true then
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
		else
			DRC.CalcView.ThirdPerson.Directional = false
			DRC.CalcView.ThirdPerson.DirectionalAng = Angle()
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
	if GetConVar("cl_drc_thirdperson"):GetFloat() != 1 then return end	
	
	local angdiff = Angle(DRC.CalcView.ThirdPerson.Ang.x - ply:EyeAngles().x, DRC.CalcView.ThirdPerson.Ang.y - ply:EyeAngles().y, 0)
	angdiff:Normalize()
	if math.abs(angdiff.y) > 130 then angdiff.x = 0 angdiff.y = 0 end
		
	DRC.CalcView.ThirdPerson.HeadAngLerp = LerpAngle(0.1, DRC.CalcView.ThirdPerson.HeadAngLerp or angdiff, angdiff)
		
	ply:SetPoseParameter("head_yaw", DRC.CalcView.ThirdPerson.HeadAngLerp.y)
	ply:SetPoseParameter("head_pitch", DRC.CalcView.ThirdPerson.HeadAngLerp.x*3)
end)

hook.Add("CalcView", "!drc_thirdperson", function(ply, pos, angles, fov)
	if !IsValid(ply) then return end
	if !ply:Alive() then return end
	if ply:InVehicle() then return end
	if DRC:SightsDown(LocalPlayer():GetActiveWeapon()) then return end
	
	if DRC:ThirdPersonEnabled(ply) == true then
		if !DRC:ShouldDoDRCThirdPerson(ply) then return end
		local wpn = ply:GetActiveWeapon()
		if wpn.ASTWTWO && GetConVar("cl_drc_thirdperson"):GetFloat() == 0 then return end
		local PSMul = ply:GetModelScale()
		local root = LocalPlayer():LookupBone("ValveBiped.Bip01_Pelvis")
		local bpos = nil
		if root != nil then bpos = LocalPlayer():GetBonePosition(root) end
		local av = ply:GetAimVector()
		local ea = DRC.CalcView.ThirdPerson.Ang
		local ep = ply:EyePos()
		local pos = ply:GetPos()
		
		if !DRC:ValveBipedCheck(ply) then
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
		
	--	bpos = LocalPlayer():GetPos() + LocalPlayer():OBBCenter()
		
		local ht = "default"
		if IsValid(wpn) then ht = string.lower(wpn:GetHoldType()) end
		if !DRC.ThirdPerson.DefaultOffsets[ht] then ht = "duel" end
		
		local offset = (DRC.ThirdPerson.DefaultOffsets[ht] * PSMul) or (DRC.ThirdPerson.DefaultOffsets["duel"] * PSMul)
		
		if GetConVar("cl_drc_thirdperson_flipside"):GetFloat() == 1 then
			offset = (Vector(DRC.ThirdPerson.DefaultOffsets[ht].x, -DRC.ThirdPerson.DefaultOffsets[ht].y, DRC.ThirdPerson.DefaultOffsets[ht].z) * PSMul) or (Vector(DRC.ThirdPerson.DefaultOffsets["duel"].x, -DRC.ThirdPerson.DefaultOffsets["duel"].y, DRC.ThirdPerson.DefaultOffsets["duel"].z) * PSMul)
		end
		
		if wpn.ThirdpersonOffset && (wpn:GetNWBool("Passive") != true) then offset = wpn.ThirdpersonOffset end
		
		offset_lerp = LerpVector(RealFrameTime() * 10, offset_lerp or offset, offset)
		
		local bonepos = bpos
		bpos = LocalToWorld(offset_lerp, ea, bpos, ea)
		
		local trZ = util.TraceLine({
			start = bonepos,
			endpos = bpos + ea:Up() * 25 * PSMul,
			filter = function(ent) if ent == ply then return false end end
		})
		
		local tr = util.TraceLine({
			start = trZ.HitPos,
			endpos = trZ.HitPos + ea:Forward() * -100 * PSMul,
			filter = function(ent) if ent == ply then return false end end
		})
		
		if !DRC.CalcView.ThirdPerson.StoredAng then DRC.CalcView.ThirdPerson.StoredAng = ply:EyeAngles() end
		
		if DRC.CalcView.ThirdPerson.Live == true then
			if DRC.CalcView.ThirdPerson.Directional == true then
				ply:SetEyeAngles(ea + DRC.CalcView.ThirdPerson.DirectionalAng)
				DRC.CalcView.ThirdPerson.Ang_Stored = ea
			else
				if DRC.CalcView.ThirdPerson.Poked == true then
					ply:SetEyeAngles(DRC.CalcView.ThirdPerson.Ang)
				else
					DRC.CalcView.ThirdPerson.Ang = ply:EyeAngles()
				end
			end
			DRC.CalcView.ThirdPerson.StoredAng = DRC.CalcView.ThirdPerson.Ang
		else
			ply:SetEyeAngles(DRC.CalcView.ThirdPerson.StoredAng)
		end
		
		if DRC:ThirdPersonEnabled(ply) == true then
			view = {}
			view.origin = tr.HitPos
			view.angles = DRC.CalcView.ThirdPerson.Ang
			view.fov = 75 * (ply:GetFOV() / 100)
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