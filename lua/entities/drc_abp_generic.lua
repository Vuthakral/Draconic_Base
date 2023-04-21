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

ENT.Model = "models/Items/BoxSRounds.mdl"

ENT.BulletTable = {
	Damage = 1,
	PvPDamageMul = 1,
	PvEDamageMul = 1,
	EvPDamageMul = 1,
	EvEDamageMul = 1,
	VehicleDamageMul = 1,
	PvEUseHL2Scale = true,
	EvPUseHL2Scale = true,
	DamageType = DMG_BULLET,
	HitboxDamageMuls = {
		["HITGROUP_GENERIC"] = 1,
		["HITGROUP_HEAD"] = 1,
		["HITGROUP_CHEST"] = 1,
		["HITGROUP_STOMACH"] = 1,
		["HITGROUP_LEFTARM"] = 1,
		["HITGROUP_RIGHTARM"] = 1,
		["HITGROUP_LEFTLEG"] = 1,
		["HITGROUP_RIGHTLEG"] = 1,
		["HITGROUP_GEAR"] = 1,
	},
	MaterialDamageMuls = {
		MAT_DEFAULT = 1,
		MAT_DEFAULT_SILENT = 1,
		MAT_ANTLION = 1,
		MAT_ARMORFLESH = 1,
		MAT_BLOODYFLESH = 1,
		MAT_ZOMBIEFLESH = 1,
		MAT_STRIDER = 1,
		MAT_HUNTER = 1,
		MAT_PAPER = 1,
		MAT_EGGSHELL = 1,
		MAT_ANTLION_EGGSHELL = 1,
		MAT_FLESH = 1,
		MAT_WATERMELON = 1,
		MAT_ALIENFLESH = 1,
		MAT_CLIP = 1, -- Unused but defined to avoid potential errors
		MAT_NO_DECAL = 1, -- Only used by stuff that shouldn't be taking damage to begin with.
		MAT_PLASTIC = 1,
		MAT_PLASTIC_BARREL = 1,
		MAT_PLASTIC_BOX = 1,
		MAT_PAINTCAN = 1,
		MAT_POPCAN = 1,
		MAT_CANISTER = 1,
		MAT_VENT = 1,
		MAT_GRENADE = 1,
		MAT_WEAPON = 1,
		MAT_CROWBAR = 1,
		MAT_METAL = 1,
		MAT_METALVEHICLE = 1,
		MAT_COMBINE_METAL = 1,
		MAT_COMBINE_GLASS = 1,
		MAT_GUNSHIP = 1,
		MAT_ROLLER = 1,
		MAT_SOLIDMETAL = 1,
		MAT_SLIPPERYMETAL = 1,
		MAT_METALPANEL = 1,
		MAT_METALVENT = 1,
		MAT_METAL_BARREL = 1,
		MAT_FLOATING_METAL_BARREL = 1,
		MAT_METAL_BOX = 1,
		MAT_GRATE = 1,
		MAT_CHAINLINK = 1,
		MAT_COMPUTER = 1,
		MAT_CONCRETE = 1,
		MAT_RUBBER = 1,
		MAT_RUBBERTIRE = 1,
		MAT_MUD = 1,
		MAT_DIRT = 1,
		MAT_STONE = 1,
		MAT_ROCK = 1,
		MAT_BOULDER = 1,
		MAT_SAND = 1,
		MAT_ANTLIONSAND = 1,
		MAT_FOLIAGE = 1,
		MAT_SLOSH = 1,
		MAT_GRASS = 1,
		MAT_CARPET = 1,
		MAT_FABRIC = 1,
		MAT_CLOTH = 1,
		MAT_WOOD = 1,
		MAT_WOOD_CRATE = 1,
		MAT_WOOD_FURNITURE = 1,
		MAT_WOOD_SOLID = 1,
		MAT_WOOD_PLANK = 1,
		MAT_WOOD_PANEL = 1,
		MAT_CARDBOARD = 1,
		MAT_TILE = 1,
		MAT_POTTERY = 1,
		MAT_SNOW = 1,
		MAT_PORCELAIN = 1,
		MAT_PLASTER = 1,
		MAT_GLASS = 1,
		MAT_GLASSBOTTLE = 1,
		MAT_ICE = 1,
		MAT_WARPSHIELD = 1,
		MAT_ITEM = 1,
		MAT_JALOPY = 1,
		MAT_AIRBOAT = 1,
		MAT_SLIME = 1,
		MAT_WADE = 1,
	},
	SplashRadius = nil,
	SplashDamageMul = 1,
	AmmoType = "Pistol",
	FallbackBaseAmmoType = "Pistol",
	NumShots = 1,
	NumShots_OC = 1,
	ProjectileOverride = nil,
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
	ImpactDecal = nil,
	BurnDecal = nil,
	Effect = nil,
	AllowsTracers = true,
	MuzzleFlash = {
		Dynamic = true,
		Mask = "effects/flashlight001",
		FarZ = 500,
		FOV = 140,
		Simple = true,
		Colour = Color(255, 180, 85, 3),
		Size = 150,
		LifeTime = 0.5,
	},
	Callback = function(info)
	end,
}