if CLIENT then
	include("shared.lua")
	include("sh_funcs.lua")
end

function SWEP:FormatViewModelAttachment(nFOV, vOrigin, bFrom --[[= false]])
	local vEyePos = EyePos()
	local aEyesRot = EyeAngles()
	local vOffset = vOrigin - vEyePos
	local vForward = aEyesRot:Forward()

	local nViewX = math.tan(nFOV * math.pi / 360)

	if (nViewX == 0) then
		vForward:Mul(vForward:Dot(vOffset))
		vEyePos:Add(vForward)
		
		return vEyePos
	end

	-- FIXME: LocalPlayer():GetFOV() should be replaced with EyeFOV() when it's binded
	local nWorldX = math.tan(LocalPlayer():GetFOV() * math.pi / 360)

	if (nWorldX == 0) then
		vForward:Mul(vForward:Dot(vOffset))
		vEyePos:Add(vForward)
		
		return vEyePos
	end

	local vRight = aEyesRot:Right()
	local vUp = aEyesRot:Up()

	if (bFrom) then
		local nFactor = nWorldX / nViewX
		vRight:Mul(vRight:Dot(vOffset) * nFactor)
		vUp:Mul(vUp:Dot(vOffset) * nFactor)
	else
		local nFactor = nViewX / nWorldX
		vRight:Mul(vRight:Dot(vOffset) * nFactor)
		vUp:Mul(vUp:Dot(vOffset) * nFactor)
	end

	vForward:Mul(vForward:Dot(vOffset))

	vEyePos:Add(vRight)
	vEyePos:Add(vUp)
	vEyePos:Add(vForward)

	return vEyePos
end

function SWEP:GetWeaponAttachment(att)
	local ply = self:GetOwner()
	local ent = self
	if ply == LocalPlayer() && !DRC:ThirdPersonEnabled(ply) then ent = ply:GetViewModel() end
	local attinfo = ent:GetAttachment(ent:LookupAttachment(att))
	if ply:IsPlayer() then 
		if ent == ply:GetViewModel() then
			attinfo.Pos = self:FormatViewModelAttachment(self.ViewModelFOV, attinfo.Pos, false)
		end
	end
	attinfo.ID = ent:LookupAttachment(att)
	attinfo.ent = ent
	
	return attinfo
end

function SWEP:EffectChain(tbl)
	local ply = self:GetOwner()
	if !DRC:IsCharacter(ply) then return end
	if !tbl then return end
	for k,v in pairs(tbl) do
		local effect, thyme = v[1], v[2]
		local effectdata = EffectData()
			timer.Simple(thyme, function() if IsValid(self) then
			if ply:GetActiveWeapon() != self then return end
			local attinfo = self:GetWeaponAttachment(k)
			effectdata:SetOrigin(attinfo.Pos)
			effectdata:SetAngles(attinfo.Ang)
			effectdata:SetAttachment(attinfo.ID)
			effectdata:SetEntity(attinfo.ent)
			util.Effect( effect, effectdata )
		end end)
	end
end