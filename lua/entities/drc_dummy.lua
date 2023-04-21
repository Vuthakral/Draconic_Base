AddCSLuaFile()

ENT.Type 			= "anim"
ENT.PrintName		= "Dummy Entity"
ENT.Author			= "Vuthakral"
ENT.Information		= "Blank, invisible, lifeless entity that is used for visual/audio effects."
ENT.Category		= "Draconic Projectiles"

ENT.Spawnable		= false
ENT.AdminSpawnable	= false

ENT.DrawMirror		= true

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetMaterial("models/vuthakral/nodraw")
	self:SetAutomaticFrameAdvance(true)
end

function ENT:Draw()
	local rt = render.GetRenderTarget()
	if rt != nil && self.DrawMirror == false then
		if rt:GetName():lower() == "_rt_waterreflection" or rt:GetName():lower() == "_rt_shadowdummy" or rt:GetName():lower() == "_rt_camera" then return end
	end
	self:DrawModel()
end