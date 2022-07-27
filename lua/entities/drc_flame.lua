AddCSLuaFile()

--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

ENT.Base	= "draconic_projectile_base"

ENT.PrintName		= "Open flame"
ENT.Author			= "Vuthakral"

ENT.Model = "models/squad/sf_plates/sf_plate1x1.mdl"
ENT.HideModel	= true

ENT.Damage			 	= 45
ENT.DamageType			= DMG_BURN
ENT.Mass				= 5
ENT.Force				= 0
ENT.Gravity				= flame
ENT.DoesRadialDamage 	= true
ENT.ProjectileType		= "fire"

ENT.AffectRadius	= 100

ENT.FuseTime	= math.Rand(0.5,1)

ENT.Light			= true
ENT.LightColor		= Color(89, 35, 13)
ENT.LightBrightness	= 1
ENT.LightRange		= 500
ENT.LightType		= 6 -- https://developer.valvesoftware.com/wiki/Light_dynamic#Appearances

function ENT:DoCustomInitialize()
	ParticleEffectAttach("env_fire_small_smoke", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end