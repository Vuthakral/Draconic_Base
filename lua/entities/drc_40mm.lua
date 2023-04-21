AddCSLuaFile()

--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

ENT.Base	= "draconic_projectile_base"
ENT.Entity	= "drc_40mm"

ENT.PrintName		= "40mm"
ENT.Author			= "Vuthakral"

ENT.Model = "models/Items/AR2_Grenade.mdl"

ENT.Damage 	= 75
ENT.AffectRadius	= 200
ENT.Mass	= 1
ENT.Gravity = true
ENT.ProjectileType	= "explosive"
ENT.ExplodeShakePower = 25
ENT.ExplodeShakeTime  = 0.5	
ENT.ExplodeShakeDistance = 500
ENT.OverrideBProfile = "drc_abp_explosion"