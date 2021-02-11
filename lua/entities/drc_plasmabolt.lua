AddCSLuaFile()

--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

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

function ENT:DoCustomInitialize()
end