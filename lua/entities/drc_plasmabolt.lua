AddCSLuaFile()

ENT.Base	= "draconic_projectile_base"
ENT.Entity	= "drc_plasmabolt"

ENT.PrintName		= "plasma_bolt"
ENT.Author			= "Vuthakral"

ENT.Model = "models/Items/AR2_Grenade.mdl"

ENT.Damage 	= 8
ENT.Mass	= 0
ENT.Force	= 5
ENT.Gravity = false
ENT.ProjectileType	= "point"
ENT.ExplodeShakePower = 25
ENT.ExplodeShakeTime  = 0.5	
ENT.ExplodeShakeDistance = 500

-- DO NOT USE THIS THING YET IM STILL FIGURING OUT SPAWNED ENTITY PROJECTILES

function ENT:DoCustomInitialize()
end