AddCSLuaFile()

-- UNFINISHED

--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName 	= "Draconic Attachment Base"
ENT.Author 		= "Vuthakral"
ENT.Information = ""
ENT.Category 	= "Draconic"

ENT.Spawnable = false
ENT.AdminOnly = false

ENT.Model 		= "models/weapons/w_package.mdl"
ENT.Buoyancy	= 0.15
ENT.Drag		= nil
ENT.Mass		= nil

ENT.InfoName = nil
ENT.InfoDescription = nil

ENT.Model = "models/Items/item_item_crate.mdl"

ENT.BulletTable = {
	Damage = 1,
	PvPDamageMul = 1,
	PvEDamageMul = 1,
	EvPDamageMul = 1,
	EvEDamageMul = 1,
	VehicleDamageMul = 1,
	DamageType = DMG_BULLET,
	MaterialDamageMuls = {
		MAT_ANTLION = 1,
		MAT_BLOODYFLESH = 1,
		MAT_ZOMBIEFLESH = 1,
		MAT_PAPER = 1,
		MAT_EGGSHELL = 1,
		MAT_FLESH = 1,
		MAT_WATERMELON = 1,
		MAT_ALIENFLESH = 1,
		MAT_CLIP = 1, -- Unused but defined to avoid errors
		MAT_PLASTIC = 1,
		MAT_PLASTIC_BARREL = 1,
		MAT_PAINTCAN = 1,
		MAT_POPCAN = 1,
		MAT_CANISTER = 1,
		MAT_VENT = 1,
		MAT_GRENADE = 1,
		MAT_WEAPON = 1,
		MAT_GUNSHIP = 1,
		MAT_METAL = 1,
		MAT_COMBINE_METAL = 1,
		MAT_SOLIDMETAL = 1,
		MAT_METALPANEL = 1,
		MAT_METAL_BARREL = 1,
		MAT_FLOATING_METAL_BARREL = 1,
		MAT_GRATE = 1,
		MAT_COMPUTER = 1,
		MAT_CONCRETE = 1,
		MAT_RUBBER = 1,
		MAT_DIRT = 1,
		MAT_ROCK = 1,
		MAT_SAND = 1,
		MAT_FOLIAGE = 1,
		MAT_SLOSH = 1,
		MAT_GRASS = 1,
		MAT_WOOD = 1,
		MAT_WOOD_CRATE = 1,
		MAT_WOOD_FURNITURE = 1,
		MAT_WOOD_SOLID = 1,
		MAT_DEFAULT = 1,
		MAT_CARDBOARD = 1,
		MAT_TILE = 1,
		MAT_SNOW = 1,
		MAT_PORCELAIN = 1,
		MAT_GLASS = 1,
		MAT_ICE = 1,
		MAT_WARPSHIELD = 1,
		MAT_ITEM = 1
	},
	SplashRadius = nil,
	SplashDamageMul = 1,
	AmmoType = "Pistol",
	FallbackHL2AmmoType = "Pistol",
	NumShots = 1,
	Force = 1,
	Kick = 1,
	KickHoriz = 1,
	Spread = 1,
	SpreadDiv = 1,
	IronRecoilMul = 1,
	RecoilUp = 1,
	RecoilDown = 1,
	RecoilHoriz = 1,
	ClipSizeMul = 1
}

ENT.AttachTable = {
	WeaponWhitelist = {},
}

function ENT:Initialize()
	self.SpawnTime = CurTime()
	self:SetModel(self.Model)
	
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:PhysWake()
		
		local phys = self:GetPhysicsObject()
		phys:SetBuoyancyRatio(self.Buoyancy)
		if self.Mass == 0 then self.Mass = 1 phys:SetMass(self.Mass) end
		if self.Mass != nil then phys:SetMass(self.Mass) end
		if self.Drag != nil then phys:SetDragCoefficient(self.Drag) end
		if self.Gravity == false then phys:EnableGravity(false) end
	end
end

function ENT:Use(ply, caller, typ)
	if CLIENT then return end
	if DRC:HasAttachment(ply, self:GetClass()) then ply:ChatPrint("I already have this.") return end
	
	DRC:GiveAttachment(ply, self:GetClass())
	ply:EmitSound("physics/metal/weapon_footstep1.wav")
	DRC:SpeakSentence(ply, "Actions", "pickup_".. self:GetClass() .."", false)
	self:Remove()
end