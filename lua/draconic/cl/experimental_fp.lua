
hook.Add( "CalcView", "Draconic_Experimental_First_Person_CV", function(ply, origin, ang, fov, zn, zf)
	if GetConVar("cl_drc_experimental_fp"):GetInt() == 0 then return end
	if !IsValid(ply) then return end
	if !ply:Alive() then return end
	local eyesatt = ply:LookupAttachment("eyes")
	local eyes = ply:GetAttachment(eyesatt)
	local pos = eyes.Pos
	
	local curswep = ply:GetActiveWeapon()
	if !IsValid(curswep) then return end
	local holdtype = curswep:GetHoldType()
	
	
	local bodybool = false
--	if holdtype == "normal" or holdtype == "melee" or holdtype == "melee2" or holdtype == "knife" or ply:InVehicle() then bodybool = true else bodybool = false end
	if holdtype == "normal" or ply:InVehicle() then bodybool = true else bodybool = false end
	
	if curswep.Draconic == true && curswep.SightsDown == true then
		pos = ply:EyePos()
	end
	
	if curswep.Draconic && GetConVar("cl_drc_lowered_crosshair"):GetFloat() == 1 then
		drc_lower_anglemod = Angle(-8, 0, 0)
	else
		drc_lower_anglemod = Angle(0, 0, 0)
	end
	
	if curswep.Draconic then
		local wpn = ply:GetActiveWeapon()
		if !wpn then return end
		if wpn.Draconic == nil then return end
		local vm = ply:GetViewModel()
		local sights = wpn.SightsDown
		
		local attachment = vm:LookupAttachment("muzzle")
		local pos = Vector(0, drc_vmapos.y, drc_vmapos.z)
		local oang = drc_vmaangle
		
		if sights == true or (ply:GetCanZoom() == true && ply:KeyDown(IN_ZOOM)) then
			drc_vm_sightpow = Lerp(FrameTime() * 25, drc_vm_sightpow or 1, 0)
		else
			drc_vm_sightpow = Lerp(FrameTime() * 25, drc_vm_sightpow or 0, 1)
		end
		
		if sights == true then
			drc_vm_sightpow_inv = Lerp(FrameTime() * 25, drc_vm_sightpow_inv or 0, 1)
		else
			drc_vm_sightpow_inv = Lerp(FrameTime() * 25, drc_vm_sightpow_inv or 1, 0)
		end
		
		drc_crosshair_pitchmod = Angle(wpn.Secondary.ScopePitch, 0, 0) * drc_vm_sightpow_inv
		
		if wpn.Loading == false && wpn.Inspecting == false then
			drc_vm_lerpang = Angle(oang.x, oang.y, Lerp(FrameTime() * drc_vm_angmedian, drc_vm_lerpang.z or 0, 0))
		else
			drc_vm_lerpang = LerpAngle(FrameTime(), oang or Angle(0, 0, 0), oang)
		end
		
		drc_vm_lerppos = Vector(Lerp(FrameTime() * 25, 0 or pos.x, 0), Lerp(FrameTime() * 25, 0 or pos.y, 0), Lerp(FrameTime() * 25, 0 or pos.z, 0))
		
		if wpn.Loading == true then
			drc_vm_lerpdivval = Lerp(FrameTime() * 5, drc_vm_lerpdivval or 30, 30)
		elseif wpn.Inspecting == true then
			drc_vm_lerpdivval = Lerp(FrameTime() * 5, drc_vm_lerpdivval or 16, 16)
		else
			drc_vm_lerpdivval = Lerp(FrameTime() * 5, drc_vm_lerpdivval or 50, 50)
		end
		
		if wpn.SightsDown == true or (wpn.Loading == false && wpn.Inspecting == false && wpn.Idle == 1) then
			local fr = math.Round(1 / FrameTime())
			
			if fr > 15 then
				if ply:KeyDown(IN_SPEED) or wpn.SightsDown == true then
					drc_vm_lerpang_final = Angle(0, 0, 0)
				else
					drc_vm_lerpang_final = LerpAngle(FrameTime() * drc_vm_angmedian, drc_vm_lerpang_final or Angle(0, 0, 0), drc_vm_lerpang)
				end
			else
				drc_vm_lerpang_final = Angle(0, 0, 0)
			end
		else
			drc_vm_lerpang_final = LerpAngle(FrameTime() * drc_vm_angmedian, drc_vm_lerpang_final or drc_vm_lerpang, drc_vm_lerpang)
		end
		
		drc_vm_lerpdiv = Lerp(FrameTime() * 5, drc_vm_lerpdivval or drc_vm_lerpdiv, drc_vm_lerpdivval)
		
		DRC.CalcView.Pos = drc_vm_lerppos / drc_vm_lerpdiv
		DRC.CalcView.Ang = drc_crosshair_pitchmod - drc_vm_lerpang_final / drc_vm_lerpdiv * drc_vm_sightpow
	end
	
	local walloffset, heft = {}
	local crouchAEMul = (math.Round(100 - math.abs(ply:EyeAngles().x)) / 100)
	local zn = 4 * crouchAEMul
	walloffset = {
		ply:EyeAngles():Forward() * -25,
	}
	local aids = ply:GetEyeTrace().HitPos
	local hiv = math.Round(ply:EyePos():Distance(aids))
	hiv = math.Clamp(hiv, 0, 50) / 50
	hiv = 1 - hiv
	ply.drcfp_walllerpval = Lerp(FrameTime() * 100, ply.drcfp_walllerpval or hiv, hiv)
	local wallpos = Lerp(ply.drcfp_walllerpval, Vector(), walloffset[1])
	if !IsValid(ply:GetVehicle()) then
		pos = pos + (wallpos * crouchAEMul)
	end
	
	local view = {
	origin = pos + DRC.CalcView.Pos,
	angles = ang + DRC.CalcView.Ang + drc_lower_anglemod,
	drawviewer = false,
	fov = fov * 1,
	znear = zn,
	zfar = nil,
	}
	
	local function CopyPoseParams(pEntityFrom, pEntityTo)
		if (SERVER) then
			for i = 0, pEntityFrom:GetNumPoseParameters() - 1 do
				local sPose = pEntityFrom:GetPoseParameterName(i)
				pEntityTo:SetPoseParameter(sPose, pEntityFrom:GetPoseParameter(sPose))
			end
		else
			for i = 0, pEntityFrom:GetNumPoseParameters() - 1 do
				local flMin, flMax = pEntityFrom:GetPoseParameterRange(i)
				local sPose = pEntityFrom:GetPoseParameterName(i)
				pEntityTo:SetPoseParameter(sPose, math.Remap(pEntityFrom:GetPoseParameter(sPose), 0, 1, flMin, flMax))
			end
		end
	end
	
	if GetConVar("cl_drawownshadow"):GetInt() != 1 then  RunConsoleCommand("cl_drawownshadow", 1) end
	
	local CSPos = Vector(ply:GetPos().x + wallpos.x, ply:GetPos().y + wallpos.y, ply:GetPos().z)
	
	if !IsValid(ply:GetVehicle()) then
		CSPos = Vector(ply:GetPos().x + wallpos.x, ply:GetPos().y + wallpos.y, ply:GetPos().z)
	else
		CSPos = Vector(ply:GetPos())
	end
	
	DRC.CSPlayerModel = ClientsideModel(ply:GetModel())
	if curswep.Draconic == true && curswep.SightsDown == true then DRC.CSPlayerModel:Remove() return end
	DRC.CSPlayerModel:SetPos(CSPos)
	DRC.CSPlayerModel:SetAngles(ply:GetRenderAngles())
	DRC.CSPlayerModel:SetSequence(ply:GetSequence())
--	DRC.CSPlayerModel:SetColor(Color(ply:GetPlayerColor().r, ply:GetPlayerColor().g, ply:GetPlayerColor().b))
	DRC.CSPlayerModel:SetCycle(ply:GetCycle())
	
	CopyPoseParams(ply, DRC.CSPlayerModel)
	
	local leftarm = ply:LookupBone(DRC.Skel.LeftArm.Name)
	local rightarm = ply:LookupBone(DRC.Skel.RightArm.Name)
	local neck = ply:LookupBone(DRC.Skel.Neck.Name)
	local spine0 = ply:LookupBone(DRC.Skel.Spine.Name)
	local spine1 = ply:LookupBone(DRC.Skel.Spine1.Name)
	local spine2 = ply:LookupBone(DRC.Skel.Spine2.Name)
	local spine4 = ply:LookupBone(DRC.Skel.Spine4.Name)

	DRC.CSPlayerModel:ManipulateBoneScale(spine0, DRC.Skel.Spine.Scale)
	DRC.CSPlayerModel:ManipulateBoneScale(spine1, DRC.Skel.Spine1.Scale)
	DRC.CSPlayerModel:ManipulateBoneScale(spine2, DRC.Skel.Spine2.Scale)
	DRC.CSPlayerModel:ManipulateBoneScale(spine4, DRC.Skel.Spine4.Scale)
	
	DRC.CSPlayerModel:ManipulateBonePosition(neck, DRC.Skel.Neck.Offset)
	
	if bodybool && IsValid(ply:GetVehicle()) == true then
		DRC.CSPlayerModel:ManipulateBonePosition(leftarm, Vector(0, 0, 0))
		DRC.CSPlayerModel:ManipulateBonePosition(rightarm, Vector(0, 0, 0))
	else
		DRC.CSPlayerModel:ManipulateBonePosition(leftarm, DRC.Skel.LeftArm.Offset)
		DRC.CSPlayerModel:ManipulateBonePosition(rightarm, DRC.Skel.RightArm.Offset)
	end
	
	for k,v in pairs(ply:GetBodyGroups()) do
		DRC.CSPlayerModel:SetBodygroup(v.id, ply:GetBodygroup(v.id))
	end
	
	DRC.CSPlayerModel:Remove()
	
	return view
end)

hook.Add( "CalcViewModelView", "Draconic_Experimental_First_Person_CVMV", function(wpn, vm, oldpos, oldang, eyepos, eyeang)
	if GetConVar("cl_drc_experimental_fp"):GetInt() == 0 then return end
	local ply = LocalPlayer()
	local eyesatt = ply:LookupAttachment("eyes")
	local eyes = ply:GetAttachment(eyesatt)
	local pos = eyes.Pos
	local diff = ply:EyePos() - pos
	local newpos = eyes.Pos

	local drcpos = nil
	if wpn.Draconic == true then
		drcpos = wpn:GetViewModelPosition(eyepos, eyeang)
		if drcpos == nil then return end
		pos = pos + (drcpos - ply:EyePos() )
	end
	
	if wpn.SightsDown == false then
		newpos = pos + Vector(diff.x * .1, diff.y * .1, diff.z * .1)
		local holdtype = wpn:GetHoldType()
		if holdtype == "melee" or holdtype == "melee2" or holdtype == "knife" then
			newpos = pos - Vector(diff.x * .1, diff.y * .1, diff.z * .1)
		end
	else
		newpos = drcpos
	end
	
	local walloffset, heft = {}
	walloffset = {
		ply:EyeAngles():Forward() * -25,
	}
	local aids = ply:GetEyeTrace().HitPos
	local hiv = math.Round(ply:EyePos():Distance(aids))
	hiv = math.Clamp(hiv, 0, 50) / 50
	hiv = 1 - hiv
	ply.drcfp_walllerpval = Lerp(FrameTime() * 100, ply.drcfp_walllerpval or hiv, hiv)
	local wallpos = Lerp(ply.drcfp_walllerpval, Vector(), walloffset[1])
	if wpn.Draconic == true then newpos = newpos + wallpos else pos = pos + wallpos end
	
	if !wpn:IsScripted() or wpn.Draconic == nil then newpos = pos - diff * .1 end
	
	DRC.EFP_Pos = newpos
	
	if wpn.Draconic == true && GetConVar("cl_drc_lowered_crosshair"):GetFloat() == 1 then
		DRC.CrosshairAngMod = Angle(-5, 0, 0)
	else
		DRC.CrosshairAngMod = Angle(0, 0, 0)
	end
	
	eyeang = eyeang + DRC.CrosshairAngMod
	
	return newpos, eyeang
end)