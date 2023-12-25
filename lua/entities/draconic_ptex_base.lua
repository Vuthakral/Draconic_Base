AddCSLuaFile()

--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

ENT.Type = "anim"

ENT.PrintName 	= "Base Projected Texture Entity"
ENT.Author 		= "Vuthakral"
ENT.Information = ""
ENT.Category 	= "Draconic"

-- Most everything about this entity is automatically handled upon creation. Making custom PTex
-- entities is solely a thing for people to be able to inject custom lua.
-- The "DO NOT TOUCH" zone.
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.Draconic 	= true
ENT.Model 		= "models/hunter/blocks/cube025x025x025.mdl"
ENT.IsLight		= true
ENT.Enabled		= true
ENT.Brightness	= 1
ENT.Texture 	= "effects/flashlight_gel"
ENT.FarZ 		= 1
ENT.NearZ		= 25
ENT.FOV			= 70
ENT.DrawShadows = false
ENT.Dummy		= true -- compatibility with other addons

function ENT:Initialize()
	self:DoCustomInitialize()

	self:SetModel(self.Model)
	self:SetNoDraw(true)
	
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysWake()
	else end
	
	if CLIENT then
		self.Light = ProjectedTexture()
		self.Light:SetTexture(self.Texture)
		self.Light:SetNearZ(self.NearZ)
		self.Light:SetFarZ(self.FarZ)
		self.Light:SetEnableShadows(self.DrawShadows)
		self.Light:SetPos(self:GetPos())
		self.Light:SetAngles(self:GetAngles())
		self.Light:Update()
	end
end

function ENT:Think()
	self:DoCustomThink()
	
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMaterial("models/vuthakral/nodraw")
	
	if !self.Light then self.Light = ProjectedTexture() end
	
	if CLIENT && self.Light then
		self.Light:SetTexture(self.Texture)
		self.Light:SetNearZ(self.NearZ)
		self.Light:SetFarZ(self.FarZ)
		self.Light:SetFOV(self.FOV)
		self.Light:SetEnableShadows(self.DrawShadows)
		self.Light:SetPos(self:GetPos())
		self.Light:SetAngles(self:GetAngles())
		if self.Enabled == false then
			self.Light:SetFarZ(0.01)
			self.Light:SetEnableShadows(false)
		else	
			self.Light:SetFarZ(self.FarZ)
			self.Light:SetEnableShadows(self.DrawShadows)
		end
		
		self.Light:Update()
	end
end

function ENT:Toggle(b)
	if b == nil then
		if self.Enabled == true then
			self.Enabled = false
		else
			self.Enabled = true
		end
	else
		self.Enabled = b
	end
end

function ENT:GetEnabled()
	return self.Enabled
end

function ENT:SetTexture(str)
	self.Texture = str
end

function ENT:SetEnableShadows(b)
	self.DrawShadows = b
end

function ENT:SetNearZ(val)
	self.NearZ = val
end

function ENT:SetFarZ(val)
	self.FarZ = val
end

function ENT:Use(_, ply)
	self:DoCustomUse(ply)
end

function ENT:OnRemove()
	if self.Light then self.Light:Remove() end
end

function ENT:DoCustomUse(ply)
end

function ENT:DoCustomInitialize()
end

function ENT:DoCustomThink()
end