AddCSLuaFile()

ENT.Type 			= "anim"
ENT.PrintName		= "Dummy Entity"
ENT.Author			= "Vuthakral"
ENT.Information		= ""
ENT.Category		= "Draconic"

ENT.Spawnable		= false
ENT.AdminSpawnable	= false

function ENT:Initialize()
	self:SetAutomaticFrameAdvance(true)
	self:SetMoveType(MOVETYPE_NONE)
end

function ENT:Think()
end

function ENT:Draw()
	local ply = LocalPlayer()
	self:SetMaterial("models/vuthakral/nodraw")
	if !IsValid(ply) or !ply:Alive() then return end
	if DRC:ThirdPersonEnabled(ply) == true then return end
	if DRC:SightsDown(ply:GetActiveWeapon()) then return end
	if GetConVar("cl_drc_experimental_fp"):GetFloat() == 0 then return end
	
	if self:GetModel() != ply:GetModel() then self:SetModel(ply:GetModel()) end
	self:DrawShadow(true)
	self:SetRenderMode(RENDERMODE_NORMAL)
	
	local rt = render.GetRenderTarget() -- Thank you to "jorjic" on github for this workaround, https://github.com/Facepunch/garrysmod-requests/issues/1943#issuecomment-1039511256
	if rt != nil then
		if rt:GetName():lower() == "_rt_waterreflection" then return end
	end
	self:DrawModel()
end