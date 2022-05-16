SWEP.Base				= "draconic_melee_base"

SWEP.HoldType			= "normal" -- https://wiki.garrysmod.com/page/Hold_Types
SWEP.CrouchHoldType		= "normal"
SWEP.Category			= "Draconic"
SWEP.PrintName			= "Cubemap Tester w/ Material Proxies"
SWEP.InfoName			= "Cubemap"

SWEP.Purpose			= "Checking cubemaps with Draconic material proxies."
SWEP.Instructions		= "Cry when you realize how many people don't know how to set up envmaps."
 
SWEP.Spawnable      = false
SWEP.AdminSpawnable = false
SWEP.DrawCrosshair  = false
SWEP.Slot           = 2
SWEP.SlotPos        = 0

SWEP.UseHands		= false
SWEP.DoesPassiveSprint = false
SWEP.ViewModel 		= "models/shadertest/envballs.mdl"
SWEP.WorldModel 	= "models/shadertest/envballs.mdl"
SWEP.ViewModelFOV   = 54
SWEP.VMPos 			= Vector(0, 0, 0)
SWEP.VMAng 			= Vector(0, 0, 0)
SWEP.VMPosCrouch 	= Vector(0, 0, 0)
SWEP.VMAngCrouch 	= Vector(0, 0, 0)
SWEP.SS 			= 0
SWEP.BS 			= 0

SWEP.Primary.SwingSound		= Sound( "draconic.BladeSwingSmall" )
SWEP.Primary.HitSoundWorld 	= Sound( "draconic.BladeSmallHitWorld" )
SWEP.Primary.HitSoundFlesh 	= Sound( "draconic.BladeSmallHitFlesh" )
SWEP.Primary.HitSoundEnt 	= Sound( "draconic.BladeSmallHitWorld" )
SWEP.Primary.HoldType		= "knife"
SWEP.Primary.HoldTypeCrouch	= "knife"
SWEP.Primary.ImpactDecal 	= "ManhackCut"
SWEP.Primary.Automatic		= true
SWEP.Primary.Damage			= 7
SWEP.Primary.DamageType		= DMG_SLASH
SWEP.Primary.Range			= 20
SWEP.Primary.Force			= 5
SWEP.Primary.DelayMiss		= 0.42
SWEP.Primary.DelayHit 		= 0.54
SWEP.Primary.CanAttackCrouched = true
SWEP.Primary.MissActivity	= ACT_VM_PRIMARYATTACK 
SWEP.Primary.CrouchMissActivity	= ACT_VM_PRIMARYATTACK 
SWEP.Primary.HitDelay		= 0.14
SWEP.Primary.StartX			= 20
SWEP.Primary.StartY			= 2.5
SWEP.Primary.EndX			= -20
SWEP.Primary.EndY			= -2.5

SWEP.Primary.CanLunge			= true
SWEP.Primary.LungeAutomatic		= false
SWEP.Primary.LungeVelocity		= 1000
SWEP.Primary.LungeMaxDist		= 150
SWEP.Primary.LungeSwingSound	= Sound( "draconic.BladeStabSmall" )
SWEP.Primary.LungeHitSoundWorld = Sound( "draconic.BladeSmallHitWorld" )
SWEP.Primary.LungeHitSoundFlesh = Sound( "draconic.BladeSmallStabFlesh" )
SWEP.Primary.LungeHitSoundEnt	= Sound( "draconic.BladeSmallHitWorld" )
SWEP.LungeHoldType				= "melee"
SWEP.LungeHoldTypeCrouch		= "melee"
SWEP.Primary.LungeImpactDecal 	= "ManhackCut"
SWEP.Primary.LungeMissAct		= ACT_VM_HITCENTER
SWEP.Primary.LungeDelayMiss		= 1.3
SWEP.Primary.LungeDelayHit		= 0.7
SWEP.Primary.LungeHitDelay		= 0.26
SWEP.Primary.LungeDamage		= 72
SWEP.Primary.LungeDamageType	= DMG_SLASH
SWEP.Primary.LungeRange			= 25
SWEP.Primary.LungeForce			= 20
SWEP.Primary.LungeStartX		= 30
SWEP.Primary.LungeEndX			= -30
SWEP.Primary.LungeStartY		= -2.5
SWEP.Primary.LungeEndY			= 2.5

SWEP.Secondary.SwingSound		= Sound( "draconic.BladeSwingSmall" )
SWEP.Secondary.HitSoundWorld 	= Sound( "draconic.BladeSmallHitWorld" )
SWEP.Secondary.HitSoundFlesh 	= Sound( "draconic.BladeSmallHitFlesh" )
SWEP.Secondary.HitSoundEnt 		= Sound( "draconic.BladeSmallHitWorld" )
SWEP.Secondary.HoldType			= "knife"
SWEP.Secondary.HoldTypeCrouch	= "knife"
SWEP.Secondary.ImpactDecal 		= "ManhackCut"
SWEP.Secondary.Automatic		= true
SWEP.Secondary.Damage			= 7
SWEP.Secondary.DamageType		= DMG_SLASH
SWEP.Secondary.Range			= 20
SWEP.Secondary.Force			= 5
SWEP.Secondary.DelayMiss		= 0.42
SWEP.Secondary.DelayHit 		= 0.54
SWEP.Secondary.CanAttackCrouched = true
SWEP.Secondary.MissActivity		= ACT_VM_SECONDARYATTACK 
SWEP.Secondary.CrouchMissActivity	= ACT_VM_SECONDARYATTACK 
SWEP.Secondary.HitDelay			= 0.14
SWEP.Secondary.StartX			= -20
SWEP.Secondary.StartY			= 2.5
SWEP.Secondary.EndX				= 20
SWEP.Secondary.EndY				= -2.5

function SWEP:DoCustomDeploy()
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	local vm = ply:GetViewModel()
	vm:SetSubMaterial(0, "models/vuthakral/shadertest/envball_6")
	vm:SetSubMaterial(1, "models/vuthakral/shadertest/envball_5")
	vm:SetSubMaterial(2, "models/vuthakral/shadertest/envball_1")
	vm:SetSubMaterial(3, "models/vuthakral/shadertest/envball_4")
	vm:SetSubMaterial(4, "models/vuthakral/shadertest/envball_2")
	vm:SetSubMaterial(5, "models/vuthakral/shadertest/envball_3")
end

function SWEP:DoCustomHolster()
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	local vm = ply:GetViewModel()
	vm:SetSubMaterial(0, nil)
	vm:SetSubMaterial(1, nil)
	vm:SetSubMaterial(2, nil)
	vm:SetSubMaterial(3, nil)
	vm:SetSubMaterial(4, nil)
	vm:SetSubMaterial(5, nil)
end

function SWEP:DoCustomRemove()
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	local vm = ply:GetViewModel()
	vm:SetSubMaterial(0, nil)
	vm:SetSubMaterial(1, nil)
	vm:SetSubMaterial(2, nil)
	vm:SetSubMaterial(3, nil)
	vm:SetSubMaterial(4, nil)
	vm:SetSubMaterial(5, nil)
end

function SWEP:DrawCustomCrosshairElements()
	draw.DrawText( "Standard Cubemap", "TargetID", ScrW() * 0.25, ScrH() * 0.37, color_white, TEXT_ALIGN_CENTER )
	draw.DrawText( "Basic Proxy Cubemap", "TargetID", ScrW() * 0.5, ScrH() * 0.37, color_white, TEXT_ALIGN_CENTER )
	draw.DrawText( "Proxy Cubemap w/ Animated Normal", "TargetID", ScrW() * 0.75, ScrH() * 0.37, color_white, TEXT_ALIGN_CENTER )
	
	draw.DrawText( "Basic Proxy Cubemap on Complex Model", "TargetID", ScrW() * 0.25, ScrH() * 0.6, color_white, TEXT_ALIGN_CENTER )
	draw.DrawText( "Colour-tinted Proxy Cubemap", "TargetID", ScrW() * 0.5, ScrH() * 0.6, color_white, TEXT_ALIGN_CENTER )
	draw.DrawText( "Normal mapped & Alpha Masked Proxy Cubemap", "TargetID", ScrW() * 0.75, ScrH() * 0.6, color_white, TEXT_ALIGN_CENTER )
end