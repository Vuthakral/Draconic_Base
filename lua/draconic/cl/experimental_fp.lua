local function EFPChecks()
	if !DRC:ThirdPersonEnabled(LocalPlayer()) == true then return false else return true end
end

local bobang = Angle()
local offsetmul = 1
hook.Add( "CalcView", "!Draconic_Experimental_First_Person_CV", function(ply, origin, ang, fov, zn, zf)
--	if !IsValid(DRC.Convars_CL.EnableEFP) or !IsValid(DRC.Convars_CL.ForceEFP) then return end
	if EFPChecks() then return end
	if GetConVar("cl_drc_experimental_fp"):GetFloat() == 1 then
		if !IsValid(ply) then return end
		if !ply:Alive() then return end
		local eyesatt = ply:LookupAttachment("eyes")
		local eyes = ply:GetAttachment(eyesatt)
		local pos = eyes.Pos
		
		local curswep = ply:GetActiveWeapon()
		local holdtype = "default"
		if IsValid(curswep) then holdtype = curswep:GetHoldType() end
		
		if curswep.Draconic == true && curswep.SightsDown == true then
			pos = ply:EyePos()
			offsetmul = 0
		else
			pos = eyes.Pos
			offsetmul = 1
		end
		
		DRC.CalcView.EFP_ISPow = Lerp(RealFrameTime() * 10, DRC.CalcView.EFP_ISPow or offsetmul, offsetmul)
		
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
				drc_vm_sightpow = Lerp(RealFrameTime() * 25, drc_vm_sightpow or 1, 0)
			else
				drc_vm_sightpow = Lerp(RealFrameTime() * 25, drc_vm_sightpow or 0, 1)
			end
			
			if sights == true then
				drc_vm_sightpow_inv = Lerp(RealFrameTime() * 25, drc_vm_sightpow_inv or 0, 1)
			else
				drc_vm_sightpow_inv = Lerp(RealFrameTime() * 25, drc_vm_sightpow_inv or 1, 0)
			end
			
			drc_crosshair_pitchmod = Angle(wpn.Secondary.ScopePitch, 0, 0) * drc_vm_sightpow_inv
			
			if wpn.Loading == false && wpn.Inspecting == false then
				drc_vm_lerpang = Angle(oang.x, oang.y, Lerp(RealFrameTime() * drc_vm_angmedian, drc_vm_lerpang.z or 0, 0))
			else
				drc_vm_lerpang = LerpAngle(FrameTime(), oang or Angle(0, 0, 0), oang)
			end
			
			drc_vm_lerppos = Vector(Lerp(RealFrameTime() * 25, 0 or pos.x, 0), Lerp(RealFrameTime() * 25, 0 or pos.y, 0), Lerp(RealFrameTime() * 25, 0 or pos.z, 0))
			
			if wpn.Loading == true then
				drc_vm_lerpdivval = Lerp(RealFrameTime() * 5, drc_vm_lerpdivval or 30, 30)
			elseif wpn.Inspecting == true then
				drc_vm_lerpdivval = Lerp(RealFrameTime() * 5, drc_vm_lerpdivval or 16, 16)
			else
				drc_vm_lerpdivval = Lerp(RealFrameTime() * 5, drc_vm_lerpdivval or 50, 50)
			end
			
			if wpn.SightsDown == true or (wpn.Loading == false && wpn.Inspecting == false && wpn.Idle == 1) then
				local fr = math.Round(1 / FrameTime())
				
				if fr > 15 then
					if ply:KeyDown(IN_SPEED) or wpn.SightsDown == true then
						drc_vm_lerpang_final = Angle(0, 0, 0)
					else
						drc_vm_lerpang_final = LerpAngle(RealFrameTime() * drc_vm_angmedian, drc_vm_lerpang_final or Angle(0, 0, 0), drc_vm_lerpang)
					end
				else
					drc_vm_lerpang_final = Angle(0, 0, 0)
				end
			else
				drc_vm_lerpang_final = LerpAngle(RealFrameTime() * drc_vm_angmedian, drc_vm_lerpang_final or drc_vm_lerpang, drc_vm_lerpang)
			end
			
			drc_vm_lerpdiv = Lerp(RealFrameTime() * 5, drc_vm_lerpdivval or drc_vm_lerpdiv, drc_vm_lerpdivval)
			
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
		ply.drcfp_walllerpval = Lerp(RealFrameTime() * 100, ply.drcfp_walllerpval or hiv, hiv)
		DRC.CalcView.wallpos = Lerp(ply.drcfp_walllerpval, Vector(), walloffset[1])
		if !IsValid(ply:GetVehicle()) then
			pos = pos + (DRC.CalcView.wallpos * crouchAEMul)
		end
		
	--	local newtr = util.TraceLine({
	--		start = pos + DRC.CalcView.Pos,
	--		endpos = LocalPlayer():GetEyeTrace().HitPos,
	--		filter = function(ent) if ent == LocalPlayer() then return false else return true end end
	--	})
	--	local trang = newtr.Normal:Angle()
	--	local bobpower = 1
	--	local angdiff = (ply:EyeAngles() - eyes.Ang) * 0.025
	
		local angadd = ang -- angdiff
		
		if DRC.CalcView.Ang && DRC.CrosshairAngMod then
			DRC.CalcView.AimCorrectAngle = angadd + (DRC.CalcView.Ang + DRC.CrosshairAngMod * DRC.CalcView.EFP_ISPow)
			DRC.CalcView.WorldPos = pos + (DRC.CalcView.Pos * DRC.CalcView.EFP_ISPow)
			
			local view = {
			origin = DRC.CalcView.WorldPos,
			--angles = ang + DRC.CalcView.Ang,
			angles = DRC.CalcView.AimCorrectAngle,
			drawviewer = false,
			fov = fov * 1,
			znear = zn,
			zfar = nil,
			}
			
			if GetConVar("cl_drawownshadow"):GetInt() != 1 then  RunConsoleCommand("cl_drawownshadow", 1) end
			return view
		end
	else
		if GetConVar("cl_drawownshadow"):GetInt() != 0 then  RunConsoleCommand("cl_drawownshadow", 0) end
	end
end)

hook.Add( "CalcViewModelView", "Draconic_Experimental_First_Person_CVMV", function(wpn, vm, oldpos, oldang, eyepos, eyeang)
	if GetConVar("cl_drc_experimental_fp"):GetFloat() == 1 then
	if EFPChecks() then return end
		local ply = LocalPlayer()
		local eyesatt = ply:LookupAttachment("eyes")
		local eyes = ply:GetAttachment(eyesatt)
		local pos = eyes.Pos
		local diff = ply:EyePos() - pos
		local newpos = eyes.Pos
		local hands = ply:GetHands()

		newpos = pos + Vector(diff.x * .1, diff.y * .1, diff.z * .1)
		local holdtype = wpn:GetHoldType()
		if holdtype == "melee" or holdtype == "melee2" or holdtype == "knife" then
			newpos = pos - Vector(diff.x * .1, diff.y * .1, diff.z * .1)
		end

		local aids = ply:GetEyeTrace().HitPos
		local hiv = math.Round(ply:EyePos():Distance(aids))
		hiv = math.Clamp(hiv, 0, 50) / 50
		hiv = 1 - hiv
		ply.drcfp_walllerpval = Lerp(RealFrameTime() * 100, ply.drcfp_walllerpval or hiv, hiv)
		
		local fuck = diff * ply:GetModelScale()
		diff = diff - fuck / 3
		
		if wpn.Draconic == true then newpos = newpos - (diff/6) + DRC.CalcView.wallpos else pos = pos + DRC.CalcView.wallpos end
		if !wpn:IsScripted() or wpn.Draconic == nil then newpos = pos - diff * .1 end
		
		if wpn.Draconic == true && GetConVar("cl_drc_lowered_crosshair"):GetFloat() == 1 then
			DRC.CrosshairAngMod = Angle(-10, 0, 0)
		else
			DRC.CrosshairAngMod = Angle(0, 0, 0)
		end

		local calcvpos, calcvang = Vector(), Angle()
		
		if wpn.Draconic then
			calcvpos, calcvang = wpn:GetViewModelPosition(eyepos, eyeang)
			eyeang = calcvang + (DRC.CrosshairAngMod/1.5)
			newpos = (newpos * DRC.CalcView.EFP_ISPow) + calcvpos - (ply:EyePos() * DRC.CalcView.EFP_ISPow)
		end
		
		return newpos, eyeang
	end
end)

hook.Add("Think", "DRC_ExpFP_Body", function()
	if GetConVar("cl_drc_experimental_fp"):GetFloat() == 0 then return end
	if EFPChecks() == true then return end
	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	if !ply:Alive() then return end
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

	local CSPos = ply:GetPos()
	if !IsValid(ply:GetVehicle()) then
		CSPos = Vector(ply:GetPos().x + DRC.CalcView.wallpos.x, ply:GetPos().y + DRC.CalcView.wallpos.y, ply:GetPos().z)
	else
		CSPos = Vector(ply:GetPos())
	end
	
	local curswep = ply:GetActiveWeapon()
	if curswep.Draconic && curswep.SightsDown == true then
		CSPos = Vector(0,0,0)
	end
	
	if !IsValid(DRC.CSPlayerModel) then
		DRC.CSPlayerModel = ents.CreateClientside("drc_csplayermodel")
		DRC.CSPlayerModel:SetModel(LocalPlayer():GetModel())
		DRC.CSPlayerModel:SetParent(LocalPlayer())
		
		
		DRC.CSPlayerModel.Skel = DRC:GetBones(DRC.CSPlayerModel)
	end

	DRC.CSPlayerModel:SetMaterial("")
	DRC.CSPlayerModel:SetNoDraw(false)
	DRC.CSPlayerModel:SetModelScale(LocalPlayer():GetModelScale())
	DRC.CSPlayerModel:SetPos(CSPos)
	DRC.CSPlayerModel:SetAngles(ply:GetRenderAngles())
	if DRC.CSPlayerModel.Turning != true then DRC.CSPlayerModel:SetSequence(ply:GetSequence()) end
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
	
	if IsValid(ply:GetVehicle()) == true then
		DRC.CSPlayerModel:ManipulateBonePosition(leftarm, Vector(0, 0, 0))
		DRC.CSPlayerModel:ManipulateBonePosition(rightarm, Vector(0, 0, 0))
	else
		DRC.CSPlayerModel:ManipulateBonePosition(leftarm, DRC.Skel.LeftArm.Offset)
		DRC.CSPlayerModel:ManipulateBonePosition(rightarm, DRC.Skel.RightArm.Offset)
	end
	
	for k,v in pairs(ply:GetBodyGroups()) do
		DRC.CSPlayerModel:SetBodygroup(v.id, ply:GetBodygroup(v.id))
	end
end)