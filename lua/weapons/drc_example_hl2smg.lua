SWEP.Base			= "draconic_gun_base"
SWEP.Gun			= "draconic_hl2smg"

SWEP.HoldType			= "smg"
SWEP.CrouchHoldType		= "smg"
SWEP.Category			= "Draconic Examples"
SWEP.PrintName			= "HL2 SMG"
SWEP.Auhtor				= "Vuthakral"
SWEP.Contact			= " https://discord.gg/6Y7WXrX // Steam: Vuthakral // Disc: Vuthakral#9761 "
SWEP.Purpose			= ""
SWEP.Instructions		= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Slot				= 2
SWEP.SlotPos			= 0

SWEP.ViewModelFOV		= 54
SWEP.ViewModelFlip		= false

SWEP.UseHands			= true
SWEP.ViewModel			= "models/weapons/c_smg1.mdl"
SWEP.WorldModel			= "models/weapons/w_smg1.mdl"
SWEP.VMPos 				= Vector(0, 0, 0)
SWEP.VMAng 				= Vector(0, 0, 0)
SWEP.IronSightsPos 		= Vector(-6.5, 15, 1.1)
SWEP.IronSightsAng 		= Vector(0, 0, 0)
SWEP.SS = 1
SWEP.BS = 1

SWEP.Primary.NumShots 		= 1
SWEP.Primary.Spread			= 12
SWEP.Primary.SpreadDiv		= 200
SWEP.Primary.Kick			= 0.36
SWEP.Primary.RecoilUp		= 0.3
SWEP.Primary.RecoilDown		= 0.3
SWEP.Primary.RecoilHoriz	= 25
SWEP.Primary.Force			= 0.2
SWEP.Primary.Damage			= 12
SWEP.Primary.Ammo			= "SMG1"
SWEP.Primary.Automatic		= true
SWEP.Primary.Delay			= 0.0735
SWEP.Primary.ClipSize		= 45
SWEP.Primary.DefaultClip	= 45
SWEP.Primary.APS			= 1
SWEP.Primary.Tracer			= 1 -- https://wiki.garrysmod.com/page/Enums/TRACER
SWEP.Primary.ReloadHoldType	= "smg"
SWEP.Primary.Sound = Sound("weapon_smg1.Single")
SWEP.Primary.NPCSound = Sound("Weapon_SMG1.NPC_Single")

SWEP.Primary.CanMelee		= true
SWEP.Primary.MeleeKeyInput	= IN_USE
SWEP.Primary.MeleeSwingSound	= Sound( "" )
SWEP.Primary.MeleeHitSoundWorld = Sound( "" )
SWEP.Primary.MeleeHitSoundFlesh = Sound( "" )
SWEP.Primary.MeleeHitSoundEnt 	= Sound( "" )
SWEP.Primary.MeleeImpactDecal 	= ""
SWEP.Primary.MeleeDamage		= 12
SWEP.Primary.MeleeDamageType	= DMG_SLASH
SWEP.Primary.MeleeRange			= 16.5
SWEP.Primary.MeleeForce			= 5
SWEP.Primary.MeleeDelayMiss		= 0.42
SWEP.Primary.MeleeDelayHit 		= 0.54
SWEP.Primary.CanAttackCrouched = false
SWEP.Primary.MeleeHitActivity	= ACT_VM_PRIMARYATTACK 
SWEP.Primary.MeleeMissActivity	= ACT_VM_PRIMARYATTACK 
SWEP.Primary.MeleeHitDelay		= 0.07

SWEP.Secondary.Ironsights	= false
SWEP.Secondary.Scoped		= false
SWEP.Secondary.ScopeMat		= "overlays/scope_lens"
SWEP.Secondary.IronFOV		= 60

SWEP.Secondary.NumShots 		= 0
SWEP.Secondary.Spread			= 3.5
SWEP.Secondary.SpreadDiv		= 100
SWEP.Secondary.Kick				= 0.5
SWEP.Secondary.RecoilUp			= 1
SWEP.Secondary.RecoilDown		= 1
SWEP.Secondary.RecoilHoriz		= 1
SWEP.Secondary.Force			= 0.2
SWEP.Secondary.Damage			= 12
SWEP.Secondary.Ammo				= "smg1_grenade"
SWEP.Secondary.Automatic		= false
SWEP.Secondary.RPM				= 444
SWEP.Secondary.ClipSize			= 1
SWEP.Secondary.DefaultClip		= 1
SWEP.Secondary.APS				= 1
SWEP.Secondary.ReloadAct		= ACT_VM_RELOAD
SWEP.Secondary.Tracer			= 0 -- https://wiki.garrysmod.com/page/Enums/TRACER
SWEP.Secondary.ReloadHoldType	= "pistol"
SWEP.Secondary.Sound = Sound("npc_combine.GrenadeLaunch")

SWEP.Secondary.Projectile			 = "drc_40mm"
SWEP.Secondary.ProjSpeed			 = 1250
SWEP.Secondary.ProjInheritVelocity = false

SWEP.NPCBurstShots = 3
SWEP.JackalSniper = false