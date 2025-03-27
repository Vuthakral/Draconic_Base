AddCSLuaFile()

--[[     I M P O R T A N T

Please, go to the wiki for this, and not just rip settings from the base as reference.
http://vuthakral.com/draconic/

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
ENT.Enabled		= false
ENT.Dummy		= true -- compatibility with other addons

local function getrng()
	local rng = math.Round(math.Rand(0, 999999999))
	if DRC.VolumeLights[rng] then rng = math.Round(math.Rand(0, 999999999)) end
	return rng
end

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
	
	self:Toggle(true)
	
	self.VolumeID = getrng()
end

ENT.ParticleMade = false
ENT.TargetEntity = nil
ENT.OffsetPosition = Vector(0,0,0)
function ENT:Think()
	if !self.Info then return end
	
	self:DoCustomThink(self.Info)
	
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMaterial("models/vuthakral/nodraw")
	local info = self.Info
	local ent = info.entity
	if !IsValid(ent) then self:Remove() return end
	if ent:GetClass() == "phys_bone_follower" then self:Remove() return end
	self.TargetEntity = ent
	local tgt = self.TargetEntity
	local attinfo
	if info.attachment then
		attinfo = ent:GetAttachment(ent:LookupAttachment(info.attachment))
	else
		attinfo = {["Pos"] = self:GetPos(), ["Ang"] = self:GetAngles()}
	end
	
	local ply = LocalPlayer()
	local tp = DRC:ThirdPersonEnabled(ply)
	
	local etu = self.TargetEntity
	if etu == ply && tp == false then return end
	if tgt:IsWeapon() && tgt == ply:GetActiveWeapon() && !tp then
		attinfo = ply:GetViewModel():GetAttachment(ply:GetViewModel():LookupAttachment(info.attachment))
		attinfo.Pos = ply:GetActiveWeapon():FormatViewModelAttachment(ply:GetActiveWeapon().ViewModelFOV, attinfo.Pos, false)
		etu = ply:GetViewModel()
	end
	
	if self:GetParent() != etu then
		self:SetParent(etu)
	end
	
	if info.eyeang == true && etu:IsPlayer() or etu:IsNPC() && info.attachment == "eyes" then
		attinfo.Ang = Angle(etu:EyeAngles().x*0.8, attinfo.Ang.y, attinfo.Ang.z)
	end
	
	self:SetPos(attinfo.Pos)
	self:SetAngles(attinfo.Ang)
	
	local lcol = render.GetLightColor(self:GetPos())
	local ambient = math.Clamp(1 - ((lcol.r + lcol.g + lcol.b) * 0.333)*2, 0 , 1)
	if self:WaterLevel() == 3 then ambient = ambient*2 end
	local newcol = Vector(info.colour.r, info.colour.g, info.colour.b)*info.colour.a*ambient
	self.col = LerpVector(FrameTime()*5, self.col or newcol, newcol)
	
	if self.ParticleMade == false && self:GetEnabled() == true then
		local ed = EffectData()
		ed:SetEntity(self.TargetEntity)
		if info.attachment then ed:SetAttachment(info.entity:LookupAttachment(info.attachment)) end
		ed:SetOrigin(info.position)
		ed:SetStart(Vector(info.colour.r, info.colour.g, info.colour.b))
		ed:SetAngles(attinfo.Ang)
		ed:SetRadius(info.width)
		ed:SetScale(info.length)
		ed:SetFlags(info.quality)
		
		util.Effect("drc_lightvolume", ed)
		self.ParticleMade = true
	end
	
	DRC.VolumeLights[self.VolumeID] = {self:GetPos(), attinfo.Ang, info.length, info.width, self.col, self.TargetEntity, self}
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

function ENT:Use(_, ply)
	self:DoCustomUse(ply)
end

function ENT:OnRemove()
	DRC.VolumeLights[self.VolumeID] = nil
end

function ENT:DoCustomUse(ply)
end

function ENT:DoCustomInitialize()
end

function ENT:DoCustomThink()
end