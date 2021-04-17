AddCSLuaFile()

--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

ENT.Type = "anim"
ENT.Base = "draconic_attachment_base"

ENT.PrintName 	= "Standard"
ENT.Author 		= "Vuthakral"
ENT.Information = ""
ENT.Category 	= "Draconic"

ENT.Spawnable = false
ENT.AdminOnly = false

ENT.InfoName = "Standard ammunition"
ENT.InfoDescription = "Standard ammunition for this weapon."

ENT.AttachType = "ammo"

ENT.BulletTable = {
	Damage = 1,
	PvPDamageMul = 1,
	PvEDamageMul = 1,
	EvPDamageMul = 1,
	EvEDamageMul = 1,
	PvEUseHL2Scale = true,
	EvPUseHL2Scale = true,
	DamageType = DMG_BULLET,
	MaterialDamageMuls = {
		MAT_DEFAULT = 1,
		MAT_ANTLION = 1,
		MAT_BLOODYFLESH = 1,
		MAT_ZOMBIEFLESH = 1,
		MAT_STRIDER = 1,
		MAT_HUNTER = 1,
		MAT_PAPER = 1,
		MAT_EGGSHELL = 1,
		MAT_FLESH = 1,
		MAT_WATERMELON = 1,
		MAT_ALIENFLESH = 1,
		MAT_CLIP = 1, -- Unused but defined to avoid potential errors
		MAT_PLASTIC = 1,
		MAT_PLASTIC_BARREL = 1,
		MAT_PAINTCAN = 1,
		MAT_POPCAN = 1,
		MAT_CANISTER = 1,
		MAT_VENT = 1,
		MAT_GRENADE = 1,
		MAT_WEAPON = 1,
		MAT_METAL = 1,
		MAT_METALVEHICLE = 1,
		MAT_COMBINE_METAL = 1,
		MAT_ROLLER = 1,
		MAT_SOLIDMETAL = 1,
		MAT_SLIPPERYMETAL = 1,
		MAT_METALPANEL = 1,
		MAT_METAL_BARREL = 1,
		MAT_FLOATING_METAL_BARREL = 1,
		MAT_METAL_BOX = 1,
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
		MAT_CARDBOARD = 1,
		MAT_TILE = 1,
		MAT_POTTERY = 1,
		MAT_SNOW = 1,
		MAT_PORCELAIN = 1,
		MAT_GLASS = 1,
		MAT_GLASSBOTTLE = 1,
		MAT_ICE = 1,
		MAT_WARPSHIELD = 1,
		MAT_ITEM = 1,
		MAT_JALOPY = 1,
	},
	SplashRadius = nil,
	SplashDamageMul = 1,
	AmmoType = "Pistol",
	FallbackBaseAmmoType = "Pistol",
	Force = 1,
	Kick = 1,
	KickHoriz = 1,
	Spread = 1,
	SpreadDiv = 1,
	IronRecoilMul = 1,
	RecoilUp = 1,
	RecoilDown = 1,
	RecoilHoriz = 1,
	ClipSizeMul = 1,
	ImpactDecal = nil
}