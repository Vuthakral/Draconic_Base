AddCSLuaFile()

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
	
	if DRC.ProjectedLights[self] == nil then self:Remove() end
	if CLIENT && DRC.ProjectedLights[self] == LocalPlayer():GetViewModel() && self != DRC.CalcView.MuzzleLamp then self:Remove() end
	
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	if self:GetMaterial() != "models/vuthakral/nodraw" then self:SetMaterial("models/vuthakral/nodraw") end
	
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