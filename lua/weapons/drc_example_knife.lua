SWEP.Base				= "draconic_melee_base"
SWEP.Gun				= "drc_example_knife"

SWEP.HoldType			= "knife" -- https://wiki.garrysmod.com/page/Hold_Types
SWEP.CrouchHoldType		= "knife"
SWEP.IdleSequence		= "idle"
SWEP.WalkSequence		= "idle"
SWEP.Category			= "Draconic"
SWEP.PrintName			= "Knife"
SWEP.Auhtor				= "Vuthakral"
SWEP.Contact			= " https://discord.gg/6Y7WXrX // Steam: Vuthakral // Disc: Vuthakral#9761 "
SWEP.Purpose			= ""
SWEP.Instructions		= ""
 
SWEP.Spawnable      = true
SWEP.AdminSpawnable = false
SWEP.DrawCrosshair  = true
SWEP.Slot           = 0
SWEP.SlotPos        = 1

SWEP.UseHands		= true
SWEP.ViewModel 		= "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel 	= "models/weapons/w_spade.mdl"
SWEP.ViewModelFOV   = 70
SWEP.VMPos 			= Vector(0, 0, 0)
SWEP.VMAng 			= Vector(0, 0, 0)
SWEP.SS 			= 1
SWEP.BS 			= 2

SWEP.IdleActivity = ACT_VM_IDLE
SWEP.CrouchIdleActivity = ACT_VM_IDLE

SWEP.ViewModelFlip  = false

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
SWEP.Primary.HitActivity	= ACT_VM_PRIMARYATTACK
SWEP.Primary.CrouchHitActivity	= ACT_VM_PRIMARYATTACK
SWEP.Primary.MissActivity	= ACT_VM_PRIMARYATTACK 
SWEP.Primary.CrouchMissActivity	= ACT_VM_PRIMARYATTACK 
SWEP.Primary.HitDelay		= 0.14

SWEP.Secondary.SwingSound 	 = Sound( "draconic.BladeStabSmall" )
SWEP.Secondary.HitSoundWorld = Sound( "draconic.BladeSmallHitWorld" )
SWEP.Secondary.HitSoundFlesh = Sound( "draconic.BladeSmallStabFlesh" )
SWEP.Secondary.HitSoundEnt 	 = Sound( "draconic.BladeSmallHitWorld" )
SWEP.Secondary.HoldType		 = "knife"
SWEP.Secondary.HoldTypeCrouch	 = "knife"
SWEP.Secondary.ImpactDecal 	 = "ManhackCut"
SWEP.Secondary.Automatic 	 = true
SWEP.Secondary.Damage 	  	 = 65
SWEP.Secondary.DamageType	 = DMG_SLASH
SWEP.Secondary.Range       	 = 30
SWEP.Secondary.Force	   	 = 7
SWEP.Secondary.DelayMiss   	 = 1.5
SWEP.Secondary.DelayHit	   	 = 0.78
SWEP.Secondary.CanAttackCrouched = true
SWEP.Secondary.HitActivity	= ACT_VM_MISSCENTER
SWEP.Secondary.CrouchHitActivity	= ACT_VM_MISSCENTER
SWEP.Secondary.MissActivity	= ACT_VM_MISSCENTER
SWEP.Secondary.CrouchMissActivity	= ACT_VM_MISSCENTER
SWEP.Secondary.HitDelay		= 0.19