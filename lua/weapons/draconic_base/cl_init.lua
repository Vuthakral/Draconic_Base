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
	if !self.VMA then 
		local attinfo = {}
		attinfo.Pos = Vector()
		attinfo.Ang = Angle()
		attinfo.ID = 0
		attinfo.ent = self
	return attinfo end
	local ply = self:GetOwner()
	local ent = self
	
	if ply:IsPlayer() then
		local tp = DRC:ThirdPersonEnabled(ply)
		if ply == LocalPlayer() && !tp then ent = ply:GetViewModel() end
	end
	local attinfo = ent:GetAttachment(ent:LookupAttachment(att))
	local newpos, newang = attinfo.Pos, attinfo.Ang
	if ply:IsPlayer() && ent == ply:GetViewModel() then
		newpos = self.VMA[att].pos
		newang = self.VMA[att].ang
	end
	
	attinfo.Pos = newpos
	attinfo.ID = ent:LookupAttachment(att)
	attinfo.ent = ent
	attinfo.Ang = newang
	
	if !self.IsMelee && att == self.Muzzles[self:GetCurrentMuzzle()][1] && DRC:SightsDown(self) && self.Secondary.Scoped == true then
		local ea = ply:EyeAngles()
		attinfo.Pos = ((ply:EyePos() - ea:Up() * 5) - ea:Forward() * 5)
	end
	
	return attinfo
end

function SWEP:EffectChain(tbl, ed)
	local ply = self:GetOwner()
	if !DRC:IsCharacter(ply) then return end
	if !tbl then return end
	for k,v in pairs(tbl) do
		local effect, thyme = v[1], v[2]
		local effectdata = EffectData()
		timer.Simple(thyme, function() if IsValid(self) then
			if ply:GetActiveWeapon() != self then return end
			local attinfo = self:GetWeaponAttachment(k)
			if !ed then
				effectdata:SetOrigin(attinfo.Pos)
				effectdata:SetStart(attinfo.Pos)
				effectdata:SetAngles(attinfo.Ang)
				effectdata:SetAttachment(attinfo.ID)
				effectdata:SetEntity(attinfo.ent)
			else
				effectdata:SetOrigin(ed:GetOrigin())
				effectdata:SetStart(ed:GetStart())
				effectdata:SetAngles(ed:GetAngles())
				effectdata:SetAttachment(ed:GetAttachment())
				effectdata:SetEntity(attinfo.ent)
			end
			
			util.Effect( effect, effectdata )
		end end)
	end
end