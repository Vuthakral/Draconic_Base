AddCSLuaFile()

--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

ENT.Base	= "draconic_projectile_base"

ENT.PrintName		= "Open flame"
ENT.Author			= "Vuthakral"

ENT.Model = "models/noesis/donut.mdl"
ENT.HideModel	= true

ENT.Damage			 	= 45
ENT.DamageType			= DMG_BURN
ENT.Mass				= 5
ENT.Force				= 0
ENT.Gravity				= false
ENT.DoesRadialDamage 	= true
ENT.ProjectileType		= "fire"

ENT.AffectRadius	= 100
ENT.TimerFrequency = 0.1

ENT.FuseTime	= math.Rand(0.5,1)

ENT.Light			= true
ENT.LightColor		= Color(89, 35, 13)
ENT.LightBrightness	= 1
ENT.LightRange		= 500
ENT.LightType		= 6 -- https://developer.valvesoftware.com/wiki/Light_dynamic#Appearances

-- Specific to this entity below
ENT.DoParticle = true
ENT.IgniteChance = 35


function ENT:DoCustomInitialize()
	if self.DoParticle == true then
		ParticleEffectAttach("env_fire_small_smoke", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	end
end

ENT.TickerTime = 0
function ENT:DoCustomThink()
	if !IsValid(self) then return end
	if CurTime() < self.TickerTime then return end
	local chance = 100 - self.IgniteChance
	self.TickerTime = CurTime() + 0.2
	local ents = ents.FindInSphere(self:GetPos(), 100)
	for k,v in pairs(ents) do
		if DRC:IsCharacter(v) && v != self:GetOwner() then
			local rng = math.Rand(0, 100)
			if rng > chance then v:Ignite(math.Rand(3,10), 0) end
		end
	end
end