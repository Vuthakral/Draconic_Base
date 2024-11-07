SWEP.Base				= "draconic_gun_base"

SWEP.HoldType			= "pistol" -- https://wiki.garrysmod.com/page/Hold_Types
SWEP.CrouchHoldType		= "pistol"
SWEP.Category			= "Draconic Base Tools"
SWEP.PrintName			= "EMP Tester"
SWEP.InfoName			= "EMP Tester"

SWEP.Purpose			= "Testing EMP effects."
SWEP.Instructions		= "Point & Click."
 
SWEP.Spawnable      = true
SWEP.AdminSpawnable = true
SWEP.AdminOnly		= true
SWEP.NPCSpawnable	= false
SWEP.DrawCrosshair  = false
SWEP.CanStore		= false

SWEP.Slot           = 2
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

function SWEP:DoCustomPrimary()
	if !SERVER then return end
	local ply = self:GetOwner()
	local tr = util.TraceLine({
		start = ply:EyePos(),
		endpos = ply:EyeAngles():Forward() * 999999999,
		filter = function(ent) if ent != ply then return true else return false end end
	})
	
	local tgt = tr.Entity
	
	DRC:EMP(self, tgt, 5)
end

function SWEP:DrawCustomCrosshairElements()
--	draw.DrawText( "Standard Cubemap", "TargetID", ScrW() * 0.25, ScrH() * 0.37, color_white, TEXT_ALIGN_CENTER )
--	draw.DrawText( "Basic Proxy Cubemap", "TargetID", ScrW() * 0.5, ScrH() * 0.37, color_white, TEXT_ALIGN_CENTER )
--	draw.DrawText( "Proxy Cubemap w/ Animated Normal", "TargetID", ScrW() * 0.75, ScrH() * 0.37, color_white, TEXT_ALIGN_CENTER )
	
--	draw.DrawText( "Basic Proxy Cubemap on Complex Model", "TargetID", ScrW() * 0.25, ScrH() * 0.6, color_white, TEXT_ALIGN_CENTER )
--	draw.DrawText( "Colour-tinted Proxy Cubemap", "TargetID", ScrW() * 0.5, ScrH() * 0.6, color_white, TEXT_ALIGN_CENTER )
--	draw.DrawText( "Normal mapped & Alpha Masked Proxy Cubemap", "TargetID", ScrW() * 0.75, ScrH() * 0.6, color_white, TEXT_ALIGN_CENTER )
end