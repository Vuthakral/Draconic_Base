AddCSLuaFile()

ENT.Type 			= "anim"
ENT.PrintName		= "Dummy Entity"
ENT.Author			= "Vuthakral"
ENT.Category		= "Draconic"

ENT.Spawnable		= false
ENT.AdminSpawnable	= false

ENT.Model			= ""

function ENT:Initialize()
	self:DoCustomInitialize()

	if SERVER then
		self:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysWake()
	else end
	self:SetAutomaticFrameAdvance(true)
end

function ENT:Think()
	self:DoCustomThink()
end

function ENT:PhysicsCollide(col, phys)
	self:DoCustomPhysicsCollide(col, phys)
end

function ENT:DoCustomInitialize()
end

function ENT:DoCustomThink()
end

function ENT:DoCustomPhysicsCollide(col, phys)
end