AddCSLuaFile()

-- UNFINISHED

--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName 	= "Base Emplacement Entity"
ENT.Author 		= "Vuthakral"
ENT.Information = ""
ENT.Category 	= "Draconic"

ENT.Spawnable = false
ENT.AdminOnly = false

ENT.Model = "models/items/ammocrate_smg1.mdl"
ENT.UseSound = ""
ENT.DenySound = ""

ENT.UserAnim = 0

ENT.RequiredEnt	= nil
ENT.RequiredEntRange = 50

ENT.Destroyable	= false
ENT.SpawnHealth	= 100
ENT.BreakEffect	= ""
ENT.BreakSound	= nil

ENT.ExplodeDamage 	= 0
ENT.ExplodePressure	= 0
ENT.DamageType		= DMG_GENERIC
ENT.AffectRadius	= 150

-- The "DO NOT TOUCH" zone.
ENT.CD 			= false
ENT.Draconic 	= true
ENT.Dead		= false
ENT.LastInflictor = nil
ENT.Powered		= true
ENT.Active		= false

function ENT:Initialize()
	self:DoCustomInitialize()

	if SERVER then
		self:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysWake()
	else end

	if self.Destroyable == true then
		self:SetHealth(self.SpawnHealth)
	end
end

function ENT:OnTakeDamage(dmginfo)
	if not SERVER then return end
	if dmginfo:GetAttacker():IsWorld() then return end
	self.DamageTaken = dmginfo:GetDamage()
	self.LastInflictor = dmginfo:GetAttacker()
	local dg = dmginfo
	if not self:IsValid() then return end
	self:SetHealth(self:Health() - self.DamageTaken)
end

function ENT:DoCustomBreak()
end

function ENT:LuaExplode(effe, damage, dt, ep, radius, shake, shakedist, shaketime)
	if not self:IsValid() then return end

	local pos = self:GetPos()
	local phys = self:GetPhysicsObject()
	local owner = self:GetOwner()
	
	DRCSound(self, self.BreakSound, nil, 1500)
	
	if self.LastInflictor == nil then
		self.Killer = self
	else
		self.Killer = self.LastInflictor
	end

	for f, v in pairs(ents.FindInSphere(pos, radius)) do
		if not self:IsValid() then return end
		if pos == nil then return end
		if radius == nil then return end
	
		local dmg2 = DamageInfo()
		dmg2:SetDamage(damage / (v:GetPos()):Distance(pos) * 20)
		dmg2:SetInflictor(self)
		dmg2:SetDamageForce(self:EyeAngles():Forward())
		dmg2:SetDamagePosition(self:GetPos())
		dmg2:SetDamageType(dt)
		dmg2:SetAttacker(self.Killer)
	
		if v:GetClass() == self:GetClass() then
			if !IsValid(v:GetPhysicsObject()) then return end
			v:GetPhysicsObject():SetVelocity((v:GetPos()-pos)*ep/(v:GetPos()):Distance(pos) * 100)
			if SERVER then v:TakeDamageInfo(dmg2) end
		else
			if IsValid(v:GetPhysicsObject()) and !(v:IsPlayer() or v:IsNPC()) then
				v:GetPhysicsObject():SetVelocity((v:GetPos()-pos)*ep/(v:GetPos()):Distance(pos) * 100)
			elseif v:IsPlayer() or v:IsNPC() then
				v:SetVelocity((v:OBBCenter()-pos)*ep/(v:OBBCenter()):Distance(pos) * 50)
			end
			if SERVER then v:TakeDamageInfo(dmg2) end
		end
	end

--	util.ScreenShake( Vector( self:GetPos() ), (shake / 2), shake, shaketime, shakedist )
		
	if self:IsValid() then
		if effe != nil then
			local ed3 = EffectData()
			ed3:SetOrigin(pos)
			util.Effect(effe, ed3)
		end
	end
		
	if self.LoopingSound != nil then
		if self:IsValid() then
			self:StopSound(self.LoopingSound)
		end
	end

	self:DoCustomBreak()
end

function ENT:Think()
	if self.Destroyable == true then
		if self.Dead == false && self:Health() <= 0 then
			self.Dead = true
			self:LuaExplode(self.BreakEffect, self.ExplodeDamage, self.DamageType, self.ExplodePressure, self.AffectRadius)
		end
	end
end

function ENT:GetRequiredEnt()
	local EntsInRange = ents.FindByClass( self.RequiredEnt )
		
	for k,v in ipairs(EntsInRange) do
		local pos = self:GetPos()
		local epos = v:GetPos()
		
		local dist =  pos:Distance(epos)
		
		if dist < self.RequiredEntRange then 
			return true
		else
			return false
		end
	end
end

function ENT:Use(_, ply)
	local curswep = ply:GetActiveWeapon()
	if not IsValid(curswep) then return end
	
	self:DoCustomUse(ply, curswep)
		
	if self.RequiredEnt != nil && self.PickupType != "stationrequirement" then
	self.Powered = false
		if self:GetRequiredEnt() == true then
			self.Powered = true
		else
			self.Powered = false
		end
	end
		
	if self.Powered == false then
	return end
end

function ENT:DoCustomUse(ply, curswep)
end

function ENT:DoCustomInitialize()
end