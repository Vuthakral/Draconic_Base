SWEP.Base				= "draconic_melee_base"
SWEP.Gun				= "drc_example_zombie"

SWEP.HoldType			= "melee" -- https://wiki.garrysmod.com/page/Hold_Types
SWEP.CrouchHoldType		= "melee"
SWEP.IdleSequence		= "idle"
SWEP.WalkSequence		= "idle"
SWEP.Category			= "Draconic Examples"
SWEP.PrintName			= "Zombie"
SWEP.Auhtor				= "Vuthakral"
SWEP.Contact			= " https://discord.gg/6Y7WXrX // Steam: Vuthakral // Disc: Vuthakral#9761 "
SWEP.Purpose			= ""
SWEP.Instructions		= ""

SWEP.Spawnable      = true 
SWEP.AdminSpawnable = false

SWEP.DrawCrosshair  = true
SWEP.Slot           = 0
SWEP.SlotPos        = 1

SWEP.UseHands		= false
SWEP.ViewModel 		= "models/vuthakral/weapons/zombies/v_zombie_classic.mdl"
SWEP.WorldModel 	= ""
SWEP.ViewModelFOV   = 90
SWEP.VMPos 			= Vector(-2, -4, -4)
SWEP.VMAng 			= Vector(0, 0, 0)
SWEP.SS 			= 1
SWEP.BS 			= 2

SWEP.IdleActivity = ACT_VM_IDLE
SWEP.CrouchIdleActivity = ACT_VM_IDLE

SWEP.TauntCooldown = 1
SWEP.TauntSounds = {"Zombie.Idle"}

SWEP.ViewModelFlip  = false
SWEP.ShowWorldModel = false

SWEP.Primary.SwingSound		= Sound( "Zombie.Attack" )
SWEP.Primary.HitSoundWorld 	= Sound( "Flesh.ImpactHard" )
SWEP.Primary.HitSoundFlesh 	= Sound( "Zombie.AttackHit" )
SWEP.Primary.HitSoundEnt 	= Sound( "Flesh.ImpactHard" )
SWEP.Primary.HoldType		= "melee"
SWEP.Primary.HoldTypeCrouch	= "melee"
SWEP.Primary.ImpactDecal 	= ""
SWEP.Primary.Automatic		= true
SWEP.Primary.Damage			= 10
SWEP.Primary.DamageType		= DMG_CLUB
SWEP.Primary.Range			= 20
SWEP.Primary.Force			= 5
SWEP.Primary.DelayMiss		= 1.5
SWEP.Primary.DelayHit 		= 1.5
SWEP.Primary.CanAttackCrouched = true
SWEP.Primary.HitActivity	= ACT_VM_PRIMARYATTACK
SWEP.Primary.CrouchHitActivity	= ACT_VM_PRIMARYATTACK
SWEP.Primary.MissActivity	= ACT_VM_PRIMARYATTACK 
SWEP.Primary.CrouchMissActivity	= ACT_VM_PRIMARYATTACK 
SWEP.Primary.HitDelay		= 0.82

SWEP.Secondary.SwingSound 	 = Sound( "Zombie.Attack" )
SWEP.Secondary.HitSoundWorld = Sound( "Flesh.ImpactHard" )
SWEP.Secondary.HitSoundFlesh = Sound( "Zombie.AttackHit" )
SWEP.Secondary.HitSoundEnt 	 = Sound( "Flesh.ImpactHard" )
SWEP.Secondary.HoldType		 = "melee"
SWEP.Secondary.HoldTypeCrouch	 = "melee"
SWEP.Secondary.ImpactDecal 	 = ""
SWEP.Secondary.Automatic 	 = true
SWEP.Secondary.Damage 	  	 = 25
SWEP.Secondary.DamageType	 = DMG_SLASH
SWEP.Secondary.Range       	 = 20
SWEP.Secondary.Force	   	 = 7
SWEP.Secondary.DelayMiss   	 = 1.5
SWEP.Secondary.DelayHit	   	 = 1.5
SWEP.Secondary.CanAttackCrouched = true
SWEP.Secondary.HitActivity	= ACT_VM_HITCENTER
SWEP.Secondary.CrouchHitActivity	= ACT_VM_SECONDARYATTACK
SWEP.Secondary.MissActivity	= ACT_VM_HITCENTER
SWEP.Secondary.CrouchMissActivity	= ACT_VM_SECONDARYATTACK
SWEP.Secondary.HitDelay		= 0.82

SWEP.SpeedStandForward		= 125
SWEP.SpeedStandBack			= 125
SWEP.SpeedStandLeft			= 125
SWEP.SpeedStandRight		= 125

SWEP.SpeedSprintStandForward	= 170
SWEP.SpeedSprintStandBack		= 170
SWEP.SpeedSprintStandLeft		= 170
SWEP.SpeedSprintStandRight		= 170
