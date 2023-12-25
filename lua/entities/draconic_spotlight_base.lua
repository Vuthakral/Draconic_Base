AddCSLuaFile()

--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

ENT.Type = "anim"

ENT.PrintName 	= "Spotlight Entity"
ENT.Author 		= "Vuthakral"
ENT.Information = ""
ENT.Category 	= "Draconic"

-- Most everything about this entity is automatically handled upon creation. Making custom
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
end

ENT.ParticleTick = 0
function ENT:Think()
--	self:Remove()
	if !self.Info then return end
	
	self:DoCustomThink(self.Info)
	
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMaterial("models/vuthakral/nodraw")
	local info = self.Info
	local ent = info.entity
	if !IsValid(ent) then self:Remove() return end
	local attinfo = ent:GetAttachment(ent:LookupAttachment(info.attachment))
	
	if self:GetParent() != info.entity then
		self:SetParent(info.entity)
	end
	
	if self:GetPos() != attinfo.Pos then
		self:SetPos(attinfo.Pos)
	end
	
--	self:SetAngles(attinfo.Ang)
	
--	LocalPlayer():ChatPrint(tostring(attinfo.Ang))
	
	if self.ParticleTick < RealTime() then
		local ed = EffectData()
		ed:SetEntity(info.entity)
		ed:SetAttachment(info.entity:LookupAttachment(info.attachment))
		ed:SetOrigin(info.position)
		ed:SetStart(Vector(info.colour.r, info.colour.g, info.colour.b))
		ed:SetAngles(attinfo.Ang)
		ed:SetRadius(info.width)
		ed:SetScale(info.length)
		
		util.Effect("drc_lightvolume", ed)
		self.ParticleTick = RealTime() + 1
	end
end

function ENT:Toggle(b)
	if b == nil then
		if self.Enabled == true then
		else
			self.Enabled = true
		end
	else
		self.Enabled = true
	end
end

function ENT:GetEnabled()
	return self.Enabled
end

function ENT:Use(_, ply)
	self:DoCustomUse(ply)
end

function ENT:DoCustomUse(ply)
end

function ENT:DoCustomInitialize()
end

function ENT:DoCustomThink()
end