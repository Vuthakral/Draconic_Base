local function EFPChecks()
	if DRC:SightsDown(LocalPlayer():GetActiveWeapon()) then return true end
	if !DRC:ThirdPersonEnabled(LocalPlayer()) == true then return false else return true end
end

local bobang = Angle()
local offsetmul = 1
hook.Add( "CalcView", "!Draconic_Experimental_First_Person_CV", function(ply, origin, ang, fov, zn, zf)
--	if !IsValid(DRC.Convars_CL.EnableEFP) or !IsValid(DRC.Convars_CL.ForceEFP) then return end
	if EFPChecks() == true then return end
	if GetConVar("cl_drc_experimental_fp"):GetFloat() == 1 then
		if !IsValid(ply) then return end
		if !ply:Alive() then return end
		local eyesatt = ply:LookupAttachment("eyes")
		local eyes = ply:GetAttachment(eyesatt)
		local pos = eyes.Pos
		
		local curswep = ply:GetActiveWeapon()
		local holdtype = "default"
		if IsValid(curswep) then holdtype = curswep:GetHoldType() end
		
		if DRC:SightsDown(curswep) == true then
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
			
			if sights == true or (wpn.Loading == false && wpn.Inspecting == false && wpn.Idle == 1) then
				local fr = math.Round(1 / FrameTime())
				
				if fr > 15 then
					if ply:KeyDown(IN_SPEED) or sights == true then
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
		
		local wep = ply:GetActiveWeapon()
		local base = nil
		if IsValid(wep) then
			base = DRC:GetBaseName(wep)
			local ht = string.lower(wep:GetHoldType())
			local bobpower = {
				[""] = 0.025,
				["pistol"] = 0.03,
				["smg"] = 0.025,
				["grenade"] = 0.15,
				["ar2"] = 0.025,
				["shotgun"] = 0.03,
				["rpg"] = 0.05,
				["physgun"] = 0.03,
				["crossbow"] = 0.03,
				["melee"] = 0.05,
				["crowbar"] = 0.05, -- HL:S Crowbar???????
				["slam"] = 0.1,
				["normal"] = 0.1,
				["fist"] = 0.1,
				["melee2"] = 0.1,
				["passive"] = 0.1,
				["knife"] = 0.1,
				["duel"] = 0.03,
				["camera"] = 0,
				["magic"] = 0.05,
				["revolver"] = 0.03,
			}			
			DRC.CalcView.InheritStrength = Lerp(0.1, DRC.CalcView.InheritStrength or bobpower[ht], bobpower[ht])
		else
			DRC.CalcView.InheritStrength = 0.1
		end
		
		local newtr = util.TraceLine({
			start = pos + DRC.CalcView.Pos,
			endpos = LocalPlayer():GetEyeTrace().HitPos,
			filter = function(ent) if ent == LocalPlayer() then return false else return true end end
		})
		local angdiff = (ply:EyeAngles() - eyes.Ang)
		angdiff:Normalize()
		angdiff = angdiff * DRC.CalcView.InheritStrength
		
		local angadd = ang
		if !DRC:SightsDown(wep) then
		angadd:RotateAroundAxis(angadd:Right(), angdiff.x)
		angadd:RotateAroundAxis(angadd:Up(), angdiff.y)
		angadd:RotateAroundAxis(angadd:Forward(), angdiff.z)
		end
		
		if !DRC.CalcView.Ang then DRC.CalcView.Ang = ply:EyeAngles() end
		if !DRC.CrosshairAngMod then DRC.CrosshairAngMod = Angle() end
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
				zfar = zfar,
			}

			if base == "mwb" then
				wep:CalcView(ply, DRC.CalcView.WorldPos, DRC.CalcView.AimCorrectAngle, ply:GetFOV())
			end
			return view
		end
	end
end)

hook.Add( "CalcViewModelView", "!Draconic_Experimental_First_Person_CVMV", function(wpn, vm, oldpos, oldang, eyepos, eyeang)
	if GetConVar("cl_drc_experimental_fp"):GetFloat() == 1 then
	if EFPChecks() == true then return end
		local base = DRC:GetBaseName(wpn)
		local ply = LocalPlayer()
		local eyesatt = ply:LookupAttachment("eyes")
		local eyes = ply:GetAttachment(eyesatt)
		local pos = eyes.Pos
		local diff = ply:EyePos() - pos
		local newpos = eyes.Pos
		local hands = ply:GetHands()
		local et = DRC.CalcView.Trace

		newpos = pos + Vector(diff.x * .1, diff.y * .1, diff.z * .1)
		local holdtype = wpn:GetHoldType()
		if holdtype == "melee" or holdtype == "melee2" or holdtype == "knife" then
			newpos = pos - Vector(diff.x * .1, diff.y * .1, diff.z * .1)
		end

		local aids = et.HitPos
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
			if DRC:SightsDown(wpn) then 
				DRC.CalcView.LoweredAng = Angle(7, 0, 0)
			else
				DRC.CalcView.LoweredAng = Angle(7, 0, 0)
			end
		else
			DRC.CrosshairAngMod = Angle(0, 0, 0)
			DRC.CalcView.LoweredAng = Angle(0, 0, 0)
		end

		local calcvpos, calcvang = Vector(), Angle()
		
		if IsValid(wpn) then
			if base != nil && base != "mwb" then
				calcvpos, calcvang = wpn:GetViewModelPosition(eyepos, eyeang)
				eyeang = (DRC.CrosshairAngMod/1.5) + calcvang + DRC.CalcView.LoweredAng
				newpos = (newpos * DRC.CalcView.EFP_ISPow) + calcvpos - (ply:EyePos() * DRC.CalcView.EFP_ISPow)
			elseif base == "mwb" then
			--	wpn:CalcViewModel(wpn.m_ViewModel, newpos, eyeang)
		--	newpos, eyeang = newpos, ply:EyeAngles()
		--	wpn.m_ViewModel:SetPos(newpos)
			end
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
		DRC.CSPlayerModel.Skel = DRC:GetBones(LocalPlayer())
	else
		if DRC.CSPlayerModel:GetModel() != LocalPlayer():GetModel() then DRC.CSPlayerModel:Remove() end
	end
	
	if !IsValid(DRC.CSShadowModel) then
		DRC.CSShadowModel = ents.CreateClientside("drc_csshadowmodel")
		DRC.CSShadowModel:SetModel(LocalPlayer():GetModel())
		DRC.CSShadowModel:SetParent(LocalPlayer())
		DRC.CSShadowModel.Skel = DRC:GetBones(LocalPlayer())
	else
		if DRC.CSShadowModel:GetModel() != LocalPlayer():GetModel() then DRC.CSShadowModel:Remove() end
	end
	
	if !IsValid(DRC.CSWeaponShadow) then
		DRC.CSWeaponShadow = ents.CreateClientside("drc_csweaponshadow")
		DRC.CSWeaponShadow:SetModel(LocalPlayer():GetModel())
		DRC.CSWeaponShadow:SetParent(DRC.CSShadowModel)
		DRC.CSWeaponShadow:AddEffects(EF_BONEMERGE)
	end
	
	if DRC.CSPlayerModel:GetMaterial() != LocalPlayer():GetMaterial() then
		
	end
	DRC.CSPlayerModel:SetMaterial(LocalPlayer():GetMaterial())
	DRC.CSPlayerModel:SetColor(LocalPlayer():GetColor())
	if DRC.CSPlayerModel:GetSkin() != LocalPlayer():GetSkin() then DRC.CSPlayerModel:SetSkin(LocalPlayer():GetSkin()) end
	
	local parents = {DRC.CSPlayerModel, DRC.CSShadowModel}
	
	for k,ent in pairs(parents) do
	--	ent:SetMaterial("")
		ent:SetNoDraw(false)
		ent:SetModelScale(LocalPlayer():GetModelScale())
		ent:SetPos(CSPos)
		ent:SetAngles(ply:GetRenderAngles())
		ent:SetSequence(ply:GetSequence())
		DRC:CopyLayerSequenceInfo(0, LocalPlayer(), ent)
		DRC:CopyLayerSequenceInfo(1, LocalPlayer(), ent)
		DRC:CopyLayerSequenceInfo(2, LocalPlayer(), ent)
		DRC:CopyLayerSequenceInfo(3, LocalPlayer(), ent)
		DRC:CopyLayerSequenceInfo(4, LocalPlayer(), ent)
		DRC:CopyLayerSequenceInfo(5, LocalPlayer(), ent) -- WHY DOESNT THIS WORK AAAAAA
		ent:SetCycle(ply:GetCycle())
		
		for k,val in pairs(ply:GetBodyGroups()) do
			ent:SetBodygroup(val.id, ply:GetBodygroup(val.id))
		end
		
		DRC:CopyPoseParams(ply, ent)
	end
	
	
	local leftarm = ply:LookupBone(DRC.Skel.LeftArm.Name)
	local rightarm = ply:LookupBone(DRC.Skel.RightArm.Name)
	local neck = ply:LookupBone(DRC.Skel.Neck.Name)
	local spine0 = ply:LookupBone(DRC.Skel.Spine.Name)
	local spine1 = ply:LookupBone(DRC.Skel.Spine1.Name)
	local spine2 = ply:LookupBone(DRC.Skel.Spine2.Name)
	local spine4 = ply:LookupBone(DRC.Skel.Spine4.Name)

	if DRC:ValveBipedCheck(DRC.CSPlayerModel) then
	DRC.CSPlayerModel:ManipulateBoneScale(spine0, DRC.Skel.Spine.Scale)
	DRC.CSPlayerModel:ManipulateBoneScale(spine1, DRC.Skel.Spine1.Scale)
	if spine2 != nil then
		for k,v in pairs(ply:GetChildBones(spine2)) do
			DRC.CSPlayerModel:ManipulateBoneScale(v, DRC.Skel.Spine4.Scale)
		end
		DRC.CSPlayerModel:ManipulateBoneScale(spine2, DRC.Skel.Spine2.Scale)
	end
	if spine4 != nil then
		for k,v in pairs(ply:GetChildBones(spine4)) do
			DRC.CSPlayerModel:ManipulateBoneScale(v, DRC.Skel.Spine4.Scale)
		end
		DRC.CSPlayerModel:ManipulateBoneScale(spine4, DRC.Skel.Spine4.Scale)
	end
	
	if neck != nil then DRC.CSPlayerModel:ManipulateBonePosition(neck, DRC.Skel.Neck.Offset) end
	
		if IsValid(ply:GetVehicle()) == true or !IsValid(ply:GetActiveWeapon()) then
			DRC.CSPlayerModel:ManipulateBonePosition(leftarm, Vector(0, 0, 0))
			DRC.CSPlayerModel:ManipulateBonePosition(rightarm, Vector(0, 0, 0))
		else
			DRC.CSPlayerModel:ManipulateBonePosition(leftarm, DRC.Skel.LeftArm.Offset)
			DRC.CSPlayerModel:ManipulateBonePosition(rightarm, DRC.Skel.RightArm.Offset)
		end
	end
end)