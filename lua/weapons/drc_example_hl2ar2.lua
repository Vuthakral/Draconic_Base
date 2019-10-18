SWEP.Base			= "draconic_gun_base"
SWEP.Gun			= "draconic_hl2smg"

SWEP.HoldType			= "ar2"
SWEP.CrouchHoldType		= "ar2"
SWEP.Category			= "Draconic"
SWEP.PrintName			= "Pulse Rifle"
SWEP.InfoName			= "OSIPR"
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
SWEP.ViewModel			= "models/weapons/c_irifle.mdl"
SWEP.WorldModel			= "models/weapons/w_irifle.mdl"
SWEP.VMPos 				= Vector(0, 0, 0)
SWEP.VMAng 				= Vector(0, 0, 0)
SWEP.IronSightsPos 		= Vector(-6.5, 15, 1.1)
SWEP.IronSightsAng 		= Vector(0, 0, 0)
SWEP.SS = 1
SWEP.BS = 1

SWEP.FireModes_CanAuto	= true
SWEP.FireModes_CanBurst = false
SWEP.FireModes_CanSemi	= false
SWEP.FireModes_BurstShots = 3
SWEP.FireModes_SwitchSound = Sound("Weapon_AR2.Empty")

SWEP.MagazineEntity = "drc_mag_ar2"

SWEP.Primary.NumShots 		= 1
SWEP.Primary.Spread			= 12
SWEP.Primary.SpreadDiv		= 200
SWEP.Primary.Kick			= 0.36
SWEP.Primary.RecoilUp		= 0.06
SWEP.Primary.RecoilDown		= 0.03
SWEP.Primary.RecoilHoriz	= 8
SWEP.Primary.Force			= 9
SWEP.Primary.Damage			= 12
SWEP.Primary.Ammo			= "AR2"
SWEP.Primary.Automatic		= true
SWEP.Primary.RPM			= 652
SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.APS			= 1
SWEP.Primary.Tracer			= 1 -- https://wiki.garrysmod.com/page/Enums/TRACER
SWEP.Primary.ReloadHoldType	= "ar2"
SWEP.Primary.Sound = Sound("weapon_ar2.Single")
SWEP.Primary.NPCSound = Sound("weapon_ar2.NPC_Single")

SWEP.Secondary.NumShots 		= 0
SWEP.Secondary.Spread			= 0
SWEP.Secondary.SpreadDiv		= 0
SWEP.Secondary.Kick				= 4
SWEP.Secondary.RecoilUp			= 0
SWEP.Secondary.RecoilDown		= 0
SWEP.Secondary.RecoilHoriz		= 0
SWEP.Secondary.Force			= 0.2
SWEP.Secondary.Damage			= 12
SWEP.Secondary.Ammo				= "AR2AltFire"
SWEP.Secondary.Automatic		= false
SWEP.Secondary.AutoReload		= true
SWEP.Secondary.DoReloadAnimation = false
SWEP.Secondary.RPM				= 40
SWEP.Secondary.ClipSize			= 1
SWEP.Secondary.DefaultClip		= 0
SWEP.Secondary.APS				= 1
SWEP.Secondary.ReloadAct		= ACT_VM_RELOAD
SWEP.Secondary.Tracer			= 0 -- https://wiki.garrysmod.com/page/Enums/TRACER
SWEP.Secondary.ReloadHoldType	= "pistol"
SWEP.Secondary.Sound			= Sound("Weapon_IRifle.Single")
SWEP.Secondary.ChargeSound 		= Sound("Weapon_CombineGuard.Special1")

SWEP.Secondary.Projectile			 = "scripted"
SWEP.Secondary.ProjSpeed			 = 0
SWEP.Secondary.ProjInheritVelocity = false
SWEP.Secondary.ProjectileSpawnDelay = 0.48

SWEP.NPCBurstShots = 3
SWEP.JackalSniper = false

function SWEP:DoScriptedSecondaryAttack()
if SERVER or game.SinglePlayer() then
	local cballspawner = ents.Create( "point_combine_ball_launcher" )
	cballspawner:SetAngles( self.Owner:EyeAngles())
	cballspawner:SetPos( self.Owner:GetShootPos() + self.Owner:GetAimVector())
	cballspawner:SetKeyValue( "minspeed",1250 )
	cballspawner:SetKeyValue( "maxspeed", 1250 )
	cballspawner:SetKeyValue( "ballradius", "30" )
	cballspawner:SetKeyValue( "ballcount", "1" )
	cballspawner:SetKeyValue( "balltype", "3" )
	cballspawner:SetKeyValue( "maxballbounces", "25" )
	cballspawner:SetKeyValue( "launchconenoise", 0 )

	cballspawner:Spawn()
	cballspawner:Activate()
	cballspawner:Fire( "LaunchBall" )
	cballspawner:Fire("kill","",0)
else end
end