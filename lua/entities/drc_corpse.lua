AddCSLuaFile()

ENT.Type 			= "anim"
ENT.PrintName		= "Corpse"
ENT.Author			= "Vuthakral"
ENT.Information		= "Halo-esque dead body that plays funny animations when blown away."
ENT.Category		= "Draconic"
ENT.Draconic		= true

ENT.Spawnable		= false
ENT.AdminSpawnable	= false

ENT.DrawMirror		= true
ENT.AutomaticFrameAdvance = true

ENT.Lifetime = 30
ENT.Mass = 200

ENT.animations = {
	["idle"] = ACT_HL2MP_ZOMBIE_SLUMP_IDLE,
	["fall"] = ACT_ZOMBIE_LEAPING,
	["death"] = ACT_GMOD_DEATH,
}

ENT.DeathAnimPlayed = false
ENT.HasBeenMoved = false
ENT.LaunchVelocity = Vector()

function ENT:Initialize()
	self.CreationTime = CurTime()
	self:SetHealth(0)
	self:SetAutomaticFrameAdvance(true)
	self:SetPlaybackRate(1)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:PhysicsInitBox(Vector(-16, -16, 0), Vector(16, 16, 8))
	self:PhysWake()
	
	self:SetNWInt("anim_idle", self.animations.idle)
	self:SetNWInt("anim_fall", self.animations.fall)
	self:SetNWInt("anim_death", self.animations.death)
	
	if SERVER then
		constraint.Keepupright(self, self:GetAngles(), 0, 180)
		self:GetPhysicsObject():SetMass(self.Mass)
		if self.MaterialType then self:GetPhysicsObject():SetMaterial(self.MaterialType) end
		
		timer.Simple(0.1, function() if IsValid(self) then
			local ent = self:GetNWEntity("Originator")
			local vel = ent:GetVelocity()
			self:SetVelocity(vel)
			self:GetPhysicsObject():ApplyForceCenter(vel*self.Mass)
		end end)
	end
	
	if self.Lifetime != 0 then
		timer.Simple(self.Lifetime, function()
			if SERVER && IsValid(self) then self:Remove() end
		end)
	end
end

function ENT:Think()
	local ground = DRC:FloorDist(self) < 15
	local vel = self:GetVelocity()
	local speed = vel.x + vel.y + vel.z * 0.333
	
	local idle = self:GetNWInt("anim_idle")
	local fall = self:GetNWInt("anim_fall")
	local death = self:GetNWInt("anim_death")
	
	if self.DeathAnimPlayed == false then idle = death end
	
	if self.animations.idle != idle then self.animations.idle = idle end
	if self.animations.fall != fall then self.animations.fall = fall end
	
	if ground then
		if speed > 5 then
			local seq = self:GetSequenceName(self:SelectWeightedSequence(self.animations.idle))
			self:SetSequence(seq)
			self:SetCycle(0)
		--	self:ResetSequence(seq)
			if self.HasBeenMoved == false then self.DeathAnimPlayed = true end
		else
			if CurTime() > self.CreationTime + 5 then self.HasBeenMoved = true end
		end
	else
		local seq = self:GetSequenceName(self:SelectWeightedSequence(self.animations.fall))
		self:SetSequence(seq)
		self:SetCycle(self:GetCycle() + FrameTime() * (1/FrameTime()*0.0033))
		if self:GetCycle() > 1 then self:SetCycle(0) end
	--	self:ResetSequence(seq)
	end
	
	self:NextThink(CurTime())
	return true
end

function ENT:Draw()
	local rt = render.GetRenderTarget()
	if rt != nil && self.DrawMirror == false then
		if rt:GetName():lower() == "_rt_waterreflection" or rt:GetName():lower() == "_rt_shadowdummy" or rt:GetName():lower() == "_rt_camera" then return end
	end
	self:DrawModel()
end