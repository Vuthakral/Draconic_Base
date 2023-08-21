AddCSLuaFile()

ENT.Type 			= "anim"
ENT.PrintName		= "Attachment Modification Station"
ENT.Author			= "Vuthakral"
ENT.Category		= "Draconic"

ENT.Spawnable		= false
ENT.AdminSpawnable	= false

ENT.Model			= "models/props_wasteland/prison_metalbed001a.mdl"

function ENT:Initialize()
	self:DoCustomInitialize()
	
	if SERVER then
		self:SetUseType(SIMPLE_USE)
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

function ENT:Use(_, ply)
	local wpn = ply:GetActiveWeapon()
	if !IsValid(wpn) then return end
	if !wpn.Draconic then return end
	if wpn.IsMelee == true then return end
	
	DRC:ForceAttachmentMenu(ply, wpn)
end