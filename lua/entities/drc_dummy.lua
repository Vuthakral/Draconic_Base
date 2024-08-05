AddCSLuaFile()

ENT.Type 			= "anim"
ENT.PrintName		= "Dummy Entity"
ENT.Author			= "Vuthakral"
ENT.Information		= "Blank, invisible, lifeless entity that is used for visual/audio effects."
ENT.Category		= "Draconic Projectiles"

ENT.Spawnable		= false
ENT.AdminSpawnable	= false

ENT.DrawMirror		= true

ENT.AutomaticFrameAdvance = true
ENT.Animating = false

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetMaterial("models/vuthakral/nodraw")
	self:SetAutomaticFrameAdvance(true)
	self:SetPlaybackRate(1)
end

function ENT:Think()
	if self.Animating == true then self:SetCycle(self:GetCycle() + RealFrameTime() * (1/RealFrameTime()*0.0033)) end
	self:NextThink(CurTime())
	return true
end

function ENT:Draw()
	self:Think() -- why is it not thinking natively wtf
	local rt = render.GetRenderTarget()
	if rt != nil && self.DrawMirror == false then
		if rt:GetName():lower() == "_rt_waterreflection" or rt:GetName():lower() == "_rt_shadowdummy" or rt:GetName():lower() == "_rt_camera" then return end
	end
	self:DrawModel()
end