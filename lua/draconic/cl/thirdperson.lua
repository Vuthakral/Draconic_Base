hook.Add("CalcView", "!drc_thirdperson", function(ply, pos, angles, fov)
	if !IsValid(ply) then return end
	if !ply:Alive() then return end
	if ply:InVehicle() then return end
	if DRC:SightsDown(LocalPlayer():GetActiveWeapon()) then return end
	
	if DRC:ThirdPersonEnabled(ply) == true then
		if !DRC:ShouldDoDRCThirdPerson(ply) then return end
		local curswep = ply:GetActiveWeapon()
		if curswep.ASTWTWO && GetConVar("cl_drc_thirdperson"):GetFloat() == 0 then return end
		local PSMul = ply:GetModelScale()
--		if !IsValid(curswep) then return end
		local root = LocalPlayer():LookupBone("ValveBiped.Bip01_Pelvis")
		local bpos = nil
		if root != nil then bpos = LocalPlayer():GetBonePosition(root) end
		local av = ply:GetAimVector()
		local ea = ply:EyeAngles()
		local ep = ply:EyePos()
		local pos = ply:GetPos()
		
		if !DRC:ValveBipedCheck(ply) then
			local attcheck = ply:LookupAttachment("pelvis")
			if attcheck != 0 then
				local newpos = ply:GetAttachment(attcheck).Pos
				bpos = newpos
			else
				bpos = LocalPlayer():GetPos() + LocalPlayer():OBBCenter()
			end
		end
		
		local ht = "default"
		if IsValid(curswep) then ht = curswep:GetHoldType() end
		
		local offset = DRC.ThirdPerson.DefaultOffsets[ht] * PSMul
		
		if GetConVar("cl_drc_thirdperson_flipside"):GetFloat() == 1 then offset.y = -offset.y end
		
		if curswep.ThirdpersonOffset && (curswep:GetNWBool("Passive") != true) then offset = curswep.ThirdpersonOffset end
		
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
		
		if DRC:ThirdPersonEnabled(ply) == true then
			view = {}
			view.origin = tr.HitPos
			view.angles = view.angles
			view.fov = 75 * (ply:GetFOV() / 100)
			view.drawviewer = true
			if tr.Hit then view.znear = 0.03 else view.znear = 1 end
		else
			view = {}
			view.origin = origin
			view.angles = angles
			view.fov = fov
			view.drawviewer = false
			view.znear = 1
		end
		
		return view
	end
end)