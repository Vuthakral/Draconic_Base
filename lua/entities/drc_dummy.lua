AddCSLuaFile()

ENT.Type 			= "anim"
ENT.PrintName		= "Dummy Entity"
ENT.Author			= "Vuthakral"
ENT.Information		= "Blank, invisible, lifeless entity that is used for visual/audio effects."
ENT.Category		= "Draconic Projectiles"

ENT.Spawnable		= false
ENT.AdminSpawnable	= false

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetMaterial("models/vuthakral/nodraw")
end