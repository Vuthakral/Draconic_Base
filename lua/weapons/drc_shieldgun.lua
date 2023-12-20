SWEP.Base				= "draconic_gun_base"

SWEP.HoldType			= "pistol" -- https://wiki.garrysmod.com/page/Hold_Types
SWEP.CrouchHoldType		= "pistol"
SWEP.Category			= "Draconic"
SWEP.PrintName			= "Shield Tester"
SWEP.InfoName			= "Shield Tester"

SWEP.Purpose			= "Testing EMP effects."
SWEP.Instructions		= "Left click to give an entity shields, right click to remove."
 
SWEP.Spawnable      = false
SWEP.AdminSpawnable = false
SWEP.NPCSpawnable	= false
SWEP.DrawCrosshair  = false
SWEP.CanStore		= false

SWEP.Slot           = 1
SWEP.SlotPos        = 0

SWEP.UseHands		= true
SWEP.DoesPassiveSprint = false
SWEP.ViewModel 		= "models/weapons/c_pistol.mdl"
SWEP.WorldModel 	= "models/weapons/w_pistol.mdl"
SWEP.ViewModelFOV   = 54

SWEP.Primary.ClipSize 		= 0
SWEP.Primary.DefaultClip 	= 0
SWEP.Primary.Ammotype 		= nil
SWEP.Primary.Force			= 0

SWEP.Primary.Disabled	= true
SWEP.Secondary.Disabled	= true

local shieldtable = {
	["Regenerating"] = true,
	["RegenDelay"] = 5, 
	["RegenAmount"] = 33,
	["Health"] = 100,
	["Effects"] = {
		["BloodEnum"] = BLOOD_COLOR_RED,
		["Impact"] = "drc_shieldspark_sandbox",
		["Deplete"] = "drc_shieldpop_sandbox",
		["Recharge"] = "drc_shieldregen_sandbox",
	},
	["Sounds"] = {
		["Impact"] = "draconic.ShieldImpactGeneric",
		["Deplete"] = "draconic.ShieldDepleteGeneric",
		["Recharge"] = "draconic.ShieldRechargeGeneric",
	},
	["Material"] = "models/vuthakral/shield_example",
	["OverMaterial"] = "models/vuthakral/shield_over_example",
	["AlwaysVisible"] = false,
	["ScaleMax"] = 1.15,
	["ScaleMin"] = 1.05,
}

function SWEP:DoCustomPrimary()
	if !SERVER then return end
	local ply = self:GetOwner()
	local tr = util.TraceLine({
		start = ply:EyePos(),
		endpos = ply:EyeAngles():Forward() * 999999999,
		filter = function(ent) if ent != ply then return true else return false end end
	})
	
	local tgt = tr.Entity
	
	DRC:SetShieldInfo(tgt, true, shieldtable)
end

function SWEP:DoCustomSecondary()
	if !SERVER then return end
	local ply = self:GetOwner()
	local tr = util.TraceLine({
		start = ply:EyePos(),
		endpos = ply:EyeAngles():Forward() * 999999999,
		filter = function(ent) if ent != ply then return true else return false end end
	})
	
	local tgt = tr.Entity
	
	DRC:SetShieldInfo(tgt, false)
end