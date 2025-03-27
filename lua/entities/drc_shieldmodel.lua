AddCSLuaFile()

ENT.Type 			= "anim"
ENT.PrintName		= "Dummy Entity"
ENT.Author			= "Vuthakral"
ENT.Information		= ""
ENT.Category		= "Draconic"

ENT.Spawnable		= false
ENT.AdminSpawnable	= false

ENT.FollowEnt = nil
ENT.ShieldScale = 1.05
ENT.ShieldSubTime = 0

function ENT:SetShieldEnt(ent)
	self.FollowEnt = ent
	ent.ShieldEntity = self
end

function ENT:GetShieldEnt()
	return self.FollowEnt
end

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetAutomaticFrameAdvance(true)

	self:SetOwner(self.FollowEnt)	
	self:SetShieldEnt(self:GetOwner())
	if self:GetShieldEnt() != self:GetOwner() or !IsValid(LocalPlayer()) then self:Remove() return end
	if IsValid(self:GetOwner()) then self:SetPos(self:GetOwner():GetPos()) end
end

function ENT:Think()
	if !IsValid(self:GetOwner()) then self:Remove() return end
	local parent = self:GetOwner()
	if parent:GetNWBool("DRC_Shielded") == false then self:Remove() end
	
	
	if parent:IsPlayer() &&!parent:Alive() then return end
	if parent:IsPlayer() then
		self:SetAngles(parent:GetRenderAngles())
	else
		self:SetAngles(parent:GetAngles())
	end
	self.Bones = DRC:GetBones(self)
	self:SetModelScale(parent:GetModelScale())
	self:SetPos(self:GetOwner():GetPos())
	self:DrawShadow(false)
	self:DestroyShadow()
end

function ENT:Draw()
	if !IsValid(self.FollowEnt) then return end
	local parent = self:GetOwner()
	if parent:IsPlayer() && !parent:Alive() then return end
	if parent == LocalPlayer() && !DRC:ThirdPersonEnabled(parent) then return end
	
	local rt = render.GetRenderTarget()
	if rt != nil && rt:GetName():lower() == "_rt_shadowdummy" then return end
	
	self:SetNoDraw(false)
	self:SetupBones()
	local hp, maxhp, ent = DRC:GetShield(parent)
	
	if DRC:Health(parent) < 0.01 && !DRC:IsVehicle(parent) && (parent:GetClass() != "prop_physics") then self:SetMaterial("models/vuthakral/nodraw") return end

	self:SetPos(self:GetOwner():GetPos())
	
	local scale = parent:GetNWInt("DRC_Shield_PingScale") * self:GetModelScale()
	if hp < 0.01 then scale = scale * 2 end
	self.ShieldScale = Lerp(RealFrameTime() * 10, self.ShieldScale or scale, scale)
	
	local model = parent:GetNWString("DRC_Shield_Model")
	if self:GetModel() != model && model != "nil" then
		self:SetModel(model)
		self.Bones = DRC:GetBones(self)
	elseif model == "nil" then
		if self:GetModel() != model then
			self.Bones = DRC:GetBones(self)
			self:SetModel(parent:GetModel())
		end
	end
	self:DrawShadow(false)
	self:DestroyShadow()
	self:SetLOD(0)
	
	local customscale = parent:GetNWVector("DRC_Shield_BaseScale")
	customscale = Vector(self.ShieldScale * customscale.x, self.ShieldScale * customscale.y, self.ShieldScale * customscale.z)
	if model == "nil" or model == parent:GetModel() then
		for k,v in pairs(self.Bones) do
			local id = self:LookupBone(k)
			if id != nil then
				local matr = parent:GetBoneMatrix(id)
				if matr then
					local newmatr = Matrix()
					newmatr:SetTranslation(matr:GetTranslation())
					newmatr:SetAngles(matr:GetAngles())
					newmatr:SetScale(customscale)
					self:SetBoneMatrix(id, newmatr)
				end
			end
		end
	else
		local matr = self:GetBoneMatrix(0)
		if matr then
			local newmatr = Matrix()
			local ang = parent:GetRenderAngles() or parent:GetAngles()
			local offset = parent:GetNWVector("DRC_Shield_BaseOffset")
			local off = Vector()
			
			
			off = ang:Right() * offset.x
			off = ang:Forward() * offset.y
			off = ang:Up() * offset.z
			
			newmatr:SetTranslation(parent:WorldSpaceCenter() + off)
			newmatr:SetAngles(ang)
			newmatr:SetScale(customscale)
			self:SetBoneMatrix(0, newmatr)
		end
	end
	
	local function CopyPoseParams(pEntityFrom, pEntityTo)
		for i = 0, pEntityFrom:GetNumPoseParameters() - 1 do
			local flMin, flMax = pEntityFrom:GetPoseParameterRange(i)
			local sPose = pEntityFrom:GetPoseParameterName(i)
			pEntityTo:SetPoseParameter(sPose, math.Remap(pEntityFrom:GetPoseParameter(sPose), 0, 1, flMin, flMax))
		end
	end
	
	if !DRC:IsCharacter(parent) then
		self:SetSequence(parent:GetSequence())
		self:SetCycle(parent:GetCycle())
		CopyPoseParams(parent, self)
	end
	
	self.mat_to_use = parent:GetNWString("DRC_Shield_Material")
	if DRC:GetOverShield(parent) then
		self.mat_to_use = parent:GetNWString("DRC_Shield_OverMaterial")
	end
	
	if DRC:GetShieldInvulnerability(parent) == true then
		if parent:GetNWString("DRC_Shield_InvulnMaterial") != "" then
		self.mat_to_use = parent:GetNWString("DRC_Shield_InvulnMaterial")
		end
	end
	
	if parent == LocalPlayer() then
		if DRC:ThirdPersonEnabled(parent) == true then
			self:SetMaterial(self.mat_to_use)
		else
			if GetConVar("cl_drc_experimental_fp"):GetFloat() == 1 then
				if !DRC.CSPlayerModel then return end
				self:SetMaterial(self.mat_to_use)
				self:SetParent(DRC.CSPlayerModel)
				for k,v in pairs(self.Bones) do
					local id = self:LookupBone(k)
					if id != nil then
						local matr = DRC.CSPlayerModel:GetBoneMatrix(id)
						if matr then
						local newmatr = Matrix()
							newmatr:SetTranslation(matr:GetTranslation())
							newmatr:SetAngles(matr:GetAngles())
							newmatr:SetScale(Vector(self.ShieldScale, self.ShieldScale, self.ShieldScale))
							self:SetBoneMatrix(id, newmatr)
						end
					end
				end
			else
				self:SetMaterial("models/vuthakral/nodraw")
			end
		end
	else
		self:SetMaterial(self.mat_to_use)
	end
	
	for k,v in pairs(parent:GetBodyGroups()) do
		self:SetBodygroup(v.id, parent:GetBodygroup(v.id))
	end
	
	self:DrawModel()
end

function ENT:RenderOverride()
	self:Draw()
end