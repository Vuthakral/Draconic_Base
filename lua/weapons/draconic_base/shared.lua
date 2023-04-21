AddCSLuaFile()
--[[     I M P O R T A N T

Please go to the GitHub wiki for this, and don't just rip settings from the base.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

SWEP.HoldType			= "default"
SWEP.CrouchHoldType		= nil
SWEP.Contact			= "discord.gg/feThY5n8vH\nsteam.vuthakral.com"
SWEP.Purpose			= ""
SWEP.Instructions		= ""
SWEP.WepSelectIcon 		= "vgui/entities/drc_default"
SWEP.IgnoreVersioning	= false

SWEP.Category			= "Draconic"
SWEP.PrintName			= "Draconic Base"
SWEP.Author				= "Vuthakral"
SWEP.InfoName			= nil
SWEP.Manufacturer		= nil
SWEP.InfoDescription	= nil

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
SWEP.NPCSpawnable		= true
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.KeepUpright		= false
SWEP.DeploySpeed		= 1
SWEP.Weight				= 1

SWEP.Slot				= 0
SWEP.SlotPos			= 0

SWEP.CrosshairColor			= Color(255, 255, 255, 255)
SWEP.CrosshairShadow		= false
SWEP.CrosshairStatic		= nil
SWEP.CrosshairDynamic		= nil
SWEP.CrosshairCorrectX		= 1
SWEP.CrosshairCorrectY		= 1
SWEP.CrosshairSizeMul		= 1
SWEP.CrosshairNoIronFade 	= false
SWEP.Crosshair 				= nil

SWEP.ViewModelFOV		= 54
SWEP.ViewModelFlip		= true
SWEP.DrawAmmo			= true

SWEP.UseHands			= true
SWEP.DoesPassiveSprint	= false
SWEP.ViewModel			= ""
SWEP.WorldModel			= ""
SWEP.VMPos 				= Vector(0, 0, 0)
SWEP.VMAng 				= Vector(0, 0, 0)
SWEP.VMPosCrouch 		= Vector(0, 0, 0)
SWEP.VMAngCrouch 		= Vector(0, 0, 0)
SWEP.LoweredVMPos		= Vector(0, 0, 0)
SWEP.LoweredVMAng		= Vector(0, 0, 0)
SWEP.IronSightsPos 		= Vector(0, 0, 0)
SWEP.IronSightsAng 		= Vector(0, 0, 0)
SWEP.IronSightsPosAlt 	= nil
SWEP.IronSightsAngAlt 	= nil
SWEP.PassivePos 		= Vector(5, 0, 3)
SWEP.PassiveAng 		= Vector(-15, 25, 0)
SWEP.InspectPos 		= Vector(3, 2, -2.5)
SWEP.InspectAng 		= Vector(15, 15, 0)
SWEP.SprintPos 			= Vector(5, 0, 3)
SWEP.SprintAng 			= Vector(-15, 25, 0)
SWEP.SS 				= 1
SWEP.BS 				= 1
SWEP.NearWallPower		= 1
SWEP.RollingPower		= 1
SWEP.PerspectivePower	= 1
SWEP.InspectDelay 		= 0.5

SWEP.Thirdperson = false

SWEP.CanBeSwapped = true
SWEP.PickupOnly = false
SWEP.DoNotDrop	= false

SWEP.IdleActivity = ACT_VM_IDLE
SWEP.CrouchIdleActivity = ACT_VM_IDLE

SWEP.FireModes_SwitchSound = Sound("Weapon_AR2.Empty")

SWEP.Primary.AimAssist		= true
SWEP.Primary.AimAssistDist	= 1000
SWEP.Primary.AimAssist_Mul	= 1

SWEP.Secondary.AimAssist		= true
SWEP.Secondary.AimAssistDist	= 1000
SWEP.Secondary.AimAssist_Mul	= 1

-- CHARGE SETTINGS
SWEP.Primary.UsesCharge = false
SWEP.Secondary.UsesCharge = false
SWEP.ChargeRate		= 10
SWEP.ChargeHoldDrain = 0.25
SWEP.ChargeType = "dualheld"
SWEP.ChargeSound = Sound("draconic.ChargeGeneric")

SWEP.OCSpread			= 0
SWEP.OCSpreadDiv		= 200
SWEP.OCKick				= 0.36
SWEP.OCRecoilUp			= 0
SWEP.OCRecoilDown		= 0
SWEP.OCRecoilHoriz		= 0
SWEP.OCIronRecoilMul	= 1
SWEP.OCForce			= 9
SWEP.OCDamage			= 12
SWEP.OCAPS				= 1
SWEP.OCHPS				= 100
SWEP.OCHealthPerShot	= 0
SWEP.OCArmourPerShot	= 0
SWEP.OCTracer			= "4"
SWEP.OCSound 			= Sound("")
SWEP.OCDistSound 		= Sound("")
SWEP.OCSoundDist 		= 3500
SWEP.OCNPCSound 		= nil
SWEP.OCProjectile 		= nil
SWEP.OCProjSpeed 		= 500

-- MOVEMENT MODIFIERS
SWEP.SprintSoundStand		= Sound( "" )
SWEP.DoSSStandFwd			= false
SWEP.DoSSStandBack			= false
SWEP.DoSSStandLeft			= false
SWEP.DoSSStandRight			= false

SWEP.SprintSoundCrouch		= Sound( "" )
SWEP.DoSSCrouchFwd			= false
SWEP.DoSSCrouchBack			= false
SWEP.DoSSCrouchLeft			= false
SWEP.DoSSCrouchRight		= false

SWEP.SJumpCrouchSound		= Sound( "" )
SWEP.DoSJCrouchSFwd			= false
SWEP.DoSJCrouchSBack		= false
SWEP.DoSJCrouchLeft			= false
SWEP.DoSJCrouchhRight		= false

SWEP.SpeedStandForward		= nil
SWEP.SpeedStandBack			= nil
SWEP.SpeedStandLeft			= nil
SWEP.SpeedStandRight		= nil

SWEP.SpeedCrouchForward		= nil
SWEP.SpeedCrouchBack		= nil
SWEP.SpeedCrouchLeft		= nil
SWEP.SpeedCrouchRight		= nil

SWEP.SpeedSprintStandForward	= nil
SWEP.SpeedSprintStandBack		= nil
SWEP.SpeedSprintStandLeft		= nil
SWEP.SpeedSprintStandRight		= nil

SWEP.SpeedSprintCrouchForward	= nil
SWEP.SpeedSprintCrouchBack		= nil
SWEP.SpeedSprintCrouchLeft		= nil
SWEP.SpeedSprintCrouchRight		= nil

SWEP.StandingJumpHeightFront			= nil
SWEP.StandingJumpHeightBack				= nil
SWEP.StandingJumpHeightLeft				= nil
SWEP.StandingJumpHeightRight			= nil

SWEP.CrouchingJumpHeightFront			= nil
SWEP.CrouchingJumpHeightBack			= nil
SWEP.CrouchingJumpHeightLeft			= nil
SWEP.CrouchingJumpHeightRight			= nil

SWEP.StandingSprintJumpHeightFront		= nil
SWEP.StandingSprintJumpHeightBack		= nil
SWEP.StandingSprintJumpHeightLeft		= nil
SWEP.StandingSprintJumpHeightRight		= nil

SWEP.CrouchingSprintJumpHeightFront		= nil
SWEP.CrouchingSprintJumpHeightBack		= nil
SWEP.CrouchingSprintJumpHeightLeft		= nil
SWEP.CrouchingSprintJumpHeightRight		= nil

-- MISC
SWEP.TauntCooldown 			= 1
SWEP.HealthRegen 			= false
SWEP.HealAmount				= 1
SWEP.HealInterval			= 1
SWEP.WeaponIdleLoopSound 	= nil
SWEP.IdleLoopSoundConstant 	= false

SWEP.Glow			= false
SWEP.GlowColor		= Color(255, 255, 255)
SWEP.GlowBrightness	= 1
SWEP.GlowDecay		= 1000
SWEP.GlowSize		= 150
SWEP.GlowStyle		= 0

SWEP.Secondary.ScopeMat		= "overlays/draconic_scope"
SWEP.Secondary.Q2Mat		= nil
SWEP.Secondary.Q3Mat		= nil
SWEP.Secondary.Q4Mat		= nil
SWEP.Secondary.ScopeBlur 	= false
SWEP.Secondary.ScopeCol 	= nil
SWEP.Secondary.ScopeBGCol 	= Color(0, 0, 0, 255)
SWEP.Secondary.ScopeScale	= 1
SWEP.Secondary.ScopeWidth	= 1
SWEP.Secondary.ScopeHeight	= 1

SWEP.Secondary.Disabled = false

SWEP.VElements = {}
SWEP.WElements = {}

-- ADDON COMPATIBILITY
SWEP.Kind 			= WEAPON_NONE
SWEP.CanBuy 		= {}
SWEP.Icon 			= SWEP.WepSelectIcon
SWEP.AutoSpawnable	= false
SWEP.AllowDrop		= true
SWEP.IsSilent		= false
SWEP.IsEquipment	= false
SWEP.AmmoEnt 		= "item_ammo_pistol_ttt"
--  SWEP.InLoadoutFor = { ROLE_TRAITOR, ROLE_DETECTIVE, ROLE_INNOCENT }
SWEP.EquipMenuData = {
	type = "item_weapon",
	name = SWEP.PrintName,
	desc = "Description undefined. Please set a string value for SWEP.EquipMenuData.desc",
}
function SWEP:IsEquipment()
	return self.IsEquipment
end

SWEP.CanTFALean = true

SWEP.DManip_AllowFL = true

SWEP.vFireLife 			= 2
SWEP.vFireVolatility 	= 0.15
SWEP.vFireSpeed 		= 1
SWEP.vFireSpawnDist 	= 30
SWEP.vFireStopSound 	= Sound("draconic.vFireStopGeneric")
SWEP.Primary.isvFire 	= false
SWEP.Secondary.isvFire 	= false

SWEP.NZWonderWeapon        	= false    -- Is this a Wonder-Weapon? If true, only one player can have it at a time. Cheats aren't stopped, though.
-- SWEP.NZRePaPText        	= "your text here"    -- When RePaPing, what should be shown? Example: Press E to your text here for 2000 points.
--SWEP.NZPaPReplacement     = ""    -- If Pack-a-Punched, replace this gun with the entity class shown here.
SWEP.NZPreventBox        	= false    -- If true, this gun won't be placed in random boxes GENERATED. Users can still place it in manually.
SWEP.NZTotalBlackList    	= false    -- if true, this gun can't be placed in the box, even manually, and can't be bought off a wall, even if placed manually. Only code can give this gun.
SWEP.Primary.MaxAmmo 		= 600 -- nZombis max ammo

-- nZombies Pack-a-Punch stats. Multiplier values. So 1 = 100% of weapon value. Utilizes Draconic's bullet profiles for advanced config.
SWEP.nZPAP = {
	["Name"] = "AAAAAAAA",
	["BProfile"] = "drc_abp_generic",
	["MaxAmmo"] = 1,
	["EmptyMag"] = false,
	["ViewModel"] = nil,
	["WorldModel"] = nil,
	["ViewModelFOV"] = nil,
}

-- Everything past this is internal code for the SWEP base. DO NOT TOUCH OR USE IN YOUR WEAPONS. THESE VALUES ARE OVERWRITTEN FREQUENTLY.
SWEP.Draconic 			= true
SWEP.Idle 				= 0
SWEP.IdleTimer 			= CurTime()
SWEP.IsTaunting 		= 0
SWEP.IsOverheated 		= false
SWEP.SightsDown 		= false
SWEP.BloomValue 		= 0
SWEP.PrevBS 			= 0
SWEP.VariablePos 		= Vector(0, 0, 0)
SWEP.CRPo 				= Vector(0, 0, 0)
SWEP.PRPos 				= Vector(0, 0, 0)
SWEP.SPRPos 			= Vector(0, 0, 0)
SWEP.IRPos 				= Vector(0, 0, 0)
SWEP.VARPos 			= Vector(0, 0, 0)
SWEP.VariableAng 		= Vector(0, 0, 0)
SWEP.CRPo 				= Vector(0, 0, 0)
SWEP.PRAng 				= Vector(0, 0, 0)
SWEP.SPRAng 			= Vector(0, 0, 0)
SWEP.IRAng 				= Vector(0, 0, 0)
SWEP.VARAng 			= Vector(0, 0, 0)
SWEP.Sound 				= Sound("")
SWEP.DistSound 			= Sound("")
SWEP.Passive 			= false
SWEP.Inspecting 		= false
SWEP.Idle 				= 0
SWEP.Loading 			= false
SWEP.ManuallyReloading 	= false
SWEP.PistolSlide 		= 1
SWEP.NPCBursting 		= false
SWEP.NPCCharging 		= false
SWEP.DualSettings 		= {}
SWEP.SightSwapCD 		= false
SWEP.SightsSwapCD 		= 0
SWEP.LastFireTime 		= 0
SWEP.LastFireAnimTime 	= 0
SWEP.PassiveHealing		= ""
SWEP.AmmoRegen			= ""
SWEP.CurPos				= Vector(0, 0, 0)
SWEP.CurAng				= Vector(0, 0, 0)
SWEP.FireMode			= "none"
SWEP.OwnerActivity 		= "standidle"

function SWEP:DoDrawCrosshair( x, y )
	return true
end

function SWEP:DrawWorldModelTranslucent()
	self:DrawModel()
end

function SWEP:InitialFireMode()
	if self.Primary.Automatic == false then
		self:SetNWString("FireMode", "Semi")
	elseif self.Primary.Automatic == true && self.FireModes_CanAuto == true then
		self:SetNWString("FireMode", "Auto")
	elseif self.Primary.Automatic == true && self.FireModes_CanBurst == true && self.FireModes_CanAuto == false then
		self:SetNWString("FireMode", "Burst")
		self.Primary.Automatic = false
	elseif self.Primary.Automatic == true && self.FireModes_CanBurst == false && self.FireModes_CanAuto == false && self.FireModes_CanSemi == true then
		self:SetNWString("FireMode", "Semi")
		self.Primary.Automatic = false
	else 
		self:SetNWString("FireMode", "Semi")
	end
	
	if self.FireModes_CanBurst == true && self.FireModes_CanAuto == false && self.FireModes_CanSemi == false then
		self:SetNWString("FireMode", "Burst")
	end
end

function SWEP:CreateIdleSound()
	if selfIdleLoopSound then
		self.IdleSound = CreateSound(self, selfIdleLoopSound)
		
		if self.IdleLoopSoundConstant == true then
			self.IdleSound:Play()
		end
	end
end

function SWEP:Initialize()
	local ply = self:GetOwner()
	if !game.SinglePlayer() then self:CallOnClient("Initialize") end
	
	if self.Auhtor then -- jesus christ you people are fucking blind
		self.Author = self.Auhtor
	end
	
	self.Readied = false
	self:SetHoldType(self.HoldType)
	self:SetNWBool("Passive", false)
	self:SetNWBool("Inspecting", false)
	self:CreateIdleSound()
	self.VARSightPos = self.IronSightsPos
	self.VARSightAng = self.IronSightsAng
	
	if self.KeepUpright == true then
		self:AddCallback( "PhysicsCollide", function( ent, newangle )
			local vel = ent:GetVelocity()
			ent:SetAngles(Angle())
		end )
	end
	
	self.DRCVersion = nil
	if self.Primary.NumShots or self.OCNumShots then
		self.DRCVersion = 1
	else
		self.DRCVersion = DRC:GetVersion()
	end
	
	if self.IgnoreVersioning == false then
		if (SERVER) or (CLIENT && game.SinglePlayer()) && ply:IsPlayer() then
			if self.DRCVersion < DRC:GetVersion() then
				DRC:MismatchWarn(ply, self)
			end
		end
	end
	
	-- 1.0 -> 1.01 sound to soundtable compatibility
	if !self.IsMelee && !self.Primary.SoundTable then
		self.Primary.SoundTable 	= {
			["Semiauto"] = {
				["Near"] = self.Primary.Sound,
				["Far"] = self.Primary.DistSound,
				["FarDistance"] = self.Primary.SoundDistance,
			},
			["Burst"] = {
				["Near"] = self.Primary.Sound,
				["Far"] = self.Primary.DistSound,
				["FarDistance"] = self.Primary.SoundDistance,
				["Single"] = true,
			},
			["Envs"] = {}
		}
	end
	
	if !self.IsMelee then
		self.DefaultPimaryClipSize = self.Primary.ClipSize
		self:SetupAttachments("drc_abp_generic", "AmmunitionTypes", false, true)
		self.SpreadCone = ((self.Primary.Spread * self:GetAttachmentValue("Ammunition", "Spread")))
	else
		self.SpreadCone = math.abs(15)
	end
	
	if self.Primary.Ammo != nil && (self:GetOwner():IsNPC() or self:GetOwner():IsNextBot()) && !self.IsMelee then
		if self.Primary.Ammo != "ammo_drc_battery" then
			self.NPCBurstShots = self.Primary.ClipSize * (60 / self.Primary.RPM)
		else
			self.NPCBurstShots = (25 / self.BatteryConsumePerShot) * (60 / self.Primary.RPM)
		end
	end
	
	if self.IsBatteryBased == true && self.BatteryConsumPerShot then self.BatteryConsumePerShot = self.BatteryConsumPerShot end -- Fixing my own mistake of an old typo, keeps peoples' weapons compatible without needing to account for my own mistake.
	
	-- Ivan's Nextbot compatiblity, DO NOT TOUCH OR USE.
	self.HoldType_Aim = self.HoldType
	if self.Primary.Ammo != nil && self:GetOwner():IsNextBot() then
		if self.IsMelee == false then
			self.Primary.Delay = 60 / self.Primary.RPM
			if self.Primary.Ammo != "ammo_drc_battery" then
				self.BurstLength = self.Primary.ClipSize * (60 / self.Primary.RPM)
				self.NPCBurstShots = self.Primary.ClipSize * (60 / self.Primary.RPM)
			else
				self.BurstLength = (100 / self.BatteryConsumePerShot) * (60 / self.Primary.RPM)
				self.NPCBurstShots = (100 / self.BatteryConsumePerShot) * (60 / self.Primary.RPM)
			end
		end
	end
	-- end

	if ply:IsPlayer() then
		local vm = ply:GetViewModel()
		if not vm:IsValid() then return end
		vm:SetPlaybackRate( 1 )
	end
	
	-- VJ NPC Compatibility
	if (ply.IsVJBaseSNPC == true or ply.IsVJBaseSNPC_Human == true) then
		if ply.IsVJBaseSNPC != nil then
			self:SetupVJSupport()
		end
	end
	
	-- Stupidity protection
	if self.Primary.ReloadAct == nil && !self.IsMelee then
		if self.Primary.ReloadHoldType == nil then
			local ht = self:GetHoldType()
			if ht == "pistol" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_PISTOL
			elseif ht == "smg" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_SMG1
			elseif ht == "grenade" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_RELOAD
			elseif ht == "ar2" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_AR2
			elseif ht == "shotgun" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN
			elseif ht == "rpg" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_RPG
			elseif ht == "physgun" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_PHYSGUN
			elseif ht == "crossbow" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_CROSSBOW
			elseif ht == "melee" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_MELEE
			elseif ht == "slam" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_SLAM
			elseif ht == "normal" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD
			elseif ht == "fist" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_FIST
			elseif ht == "melee2" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_MELEE2
			elseif ht == "passive" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD
			elseif ht == "knife" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_KNIFE
			elseif ht == "duel" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_DUEL
			elseif ht == "camera" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_CAMERA
			elseif ht == "magic" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_MAGIC
			elseif ht == "revolver" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_REVOLVER
			end
		else
			local ht = self.Primary.ReloadHoldType
			if ht == "pistol" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_PISTOL
			elseif ht == "smg" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_SMG1
			elseif ht == "grenade" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_RELOAD
			elseif ht == "ar2" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_AR2
			elseif ht == "shotgun" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN
			elseif ht == "rpg" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_RPG
			elseif ht == "physgun" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_PHYSGUN
			elseif ht == "crossbow" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_CROSSBOW
			elseif ht == "melee" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_MELEE
			elseif ht == "slam" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_SLAM
			elseif ht == "normal" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD
			elseif ht == "fist" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_FIST
			elseif ht == "melee2" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_MELEE2
			elseif ht == "passive" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD
			elseif ht == "knife" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_KNIFE
			elseif ht == "duel" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_DUEL
			elseif ht == "camera" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_CAMERA
			elseif ht == "magic" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_MAGIC
			elseif ht == "revolver" then self.Primary.ReloadAct = ACT_HL2MP_GESTURE_RELOAD_REVOLVER
			end
		end
	end
	
	if self.IsMelee == true then
		if self.Primary.MeleeAct == nil then
			local ht = self.Primary.HoldType
			if ht == "pistol" then self.Primary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
			elseif ht == "smg" then self.Primary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1
			elseif ht == "grenade" then self.Primary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_RELOAD
			elseif ht == "ar2" then self.Primary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
			elseif ht == "shotgun" then self.Primary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN
			elseif ht == "rpg" then self.Primary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG
			elseif ht == "physgun" then self.Primary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_PHYSGUN
			elseif ht == "crossbow" then self.Primary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
			elseif ht == "melee" then self.Primary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
			elseif ht == "slam" then self.Primary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM
			elseif ht == "normal" then self.Primary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK
			elseif ht == "fist" then self.Primary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST
			elseif ht == "melee2" then self.Primary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2
			elseif ht == "passive" then self.Primary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK
			elseif ht == "knife" then self.Primary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
			elseif ht == "duel" then self.Primary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_DUEL
			elseif ht == "camera" then self.Primary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_CAMERA
			elseif ht == "magic" then self.Primary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_MAGIC
			elseif ht == "revolver" then self.Primary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER
			end
		end
		if self.Primary.MeleeActCrouch == nil then
			local ht = self.Primary.HoldTypeCrouch
			if ht == "pistol" then self.Primary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
			elseif ht == "smg" then self.Primary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1
			elseif ht == "grenade" then self.Primary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_RELOAD
			elseif ht == "ar2" then self.Primary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
			elseif ht == "shotgun" then self.Primary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN
			elseif ht == "rpg" then self.Primary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG
			elseif ht == "physgun" then self.Primary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_PHYSGUN
			elseif ht == "crossbow" then self.Primary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
			elseif ht == "melee" then self.Primary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
			elseif ht == "slam" then self.Primary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM
			elseif ht == "normal" then self.Primary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK
			elseif ht == "fist" then self.Primary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST
			elseif ht == "melee2" then self.Primary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2
			elseif ht == "passive" then self.Primary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK
			elseif ht == "knife" then self.Primary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
			elseif ht == "duel" then self.Primary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_DUEL
			elseif ht == "camera" then self.Primary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_CAMERA
			elseif ht == "magic" then self.Primary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_MAGIC
			elseif ht == "revolver" then self.Primary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER
			end
		end
		if self.Secondary.MeleeAct == nil then
			local ht = self.Secondary.HoldType
			if ht == "pistol" then self.Secondary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
			elseif ht == "smg" then self.Secondary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1
			elseif ht == "grenade" then self.Secondary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_RELOAD
			elseif ht == "ar2" then self.Secondary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
			elseif ht == "shotgun" then self.Secondary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN
			elseif ht == "rpg" then self.Secondary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG
			elseif ht == "physgun" then self.Secondary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_PHYSGUN
			elseif ht == "crossbow" then self.Secondary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
			elseif ht == "melee" then self.Secondary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
			elseif ht == "slam" then self.Secondary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM
			elseif ht == "normal" then self.Secondary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK
			elseif ht == "fist" then self.Secondary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST
			elseif ht == "melee2" then self.Secondary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2
			elseif ht == "passive" then self.Secondary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK
			elseif ht == "knife" then self.Secondary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
			elseif ht == "duel" then self.Secondary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_DUEL
			elseif ht == "camera" then self.Secondary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_CAMERA
			elseif ht == "magic" then self.Secondary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_MAGIC
			elseif ht == "revolver" then self.Secondary.MeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER
			end
		end
		if self.Secondary.MeleeActCrouch == nil then
			local ht = self.Secondary.HoldTypeCrouch
			if ht == "pistol" then self.Secondary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
			elseif ht == "smg" then self.Secondary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1
			elseif ht == "grenade" then self.Secondary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_RELOAD
			elseif ht == "ar2" then self.Secondary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
			elseif ht == "shotgun" then self.Secondary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN
			elseif ht == "rpg" then self.Secondary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG
			elseif ht == "physgun" then self.Secondary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_PHYSGUN
			elseif ht == "crossbow" then self.Secondary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
			elseif ht == "melee" then self.Secondary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
			elseif ht == "slam" then self.Secondary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM
			elseif ht == "normal" then self.Secondary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK
			elseif ht == "fist" then self.Secondary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST
			elseif ht == "melee2" then self.Secondary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2
			elseif ht == "passive" then self.Secondary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK
			elseif ht == "knife" then self.Secondary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
			elseif ht == "duel" then self.Secondary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_DUEL
			elseif ht == "camera" then self.Secondary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_CAMERA
			elseif ht == "magic" then self.Secondary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_MAGIC
			elseif ht == "revolver" then self.Secondary.MeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER
			end
		end
		if self.Primary.LungeMeleeAct == nil then
			local ht = self.LungeHoldType
			if ht == "pistol" then self.Primary.LungeMeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
			elseif ht == "smg" then self.Primary.LungeMeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1
			elseif ht == "grenade" then self.Primary.LungeMeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_RELOAD
			elseif ht == "ar2" then self.Primary.LungeMeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
			elseif ht == "shotgun" then self.Primary.LungeMeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN
			elseif ht == "rpg" then self.Primary.LungeMeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG
			elseif ht == "physgun" then self.Primary.LungeMeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_PHYSGUN
			elseif ht == "crossbow" then self.Primary.LungeMeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
			elseif ht == "melee" then self.Primary.LungeMeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
			elseif ht == "slam" then self.Primary.LungeMeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM
			elseif ht == "normal" then self.Primary.LungeMeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK
			elseif ht == "fist" then self.Primary.LungeMeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST
			elseif ht == "melee2" then self.Primary.LungeMeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2
			elseif ht == "passive" then self.Primary.LungeMeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK
			elseif ht == "knife" then self.Primary.LungeMeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
			elseif ht == "duel" then self.Primary.LungeMeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_DUEL
			elseif ht == "camera" then self.Primary.LungeMeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_CAMERA
			elseif ht == "magic" then self.Primary.LungeMeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_MAGIC
			elseif ht == "revolver" then self.Primary.LungeMeleeAct = ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER
			end
		end
		if self.Primary.LungeMeleeActCrouch == nil then
			local ht = self.LungeHoldTypeCrouch
			if ht == "pistol" then self.Primary.LungeMeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
			elseif ht == "smg" then self.Primary.LungeMeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1
			elseif ht == "grenade" then self.Primary.LungeMeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_RELOAD
			elseif ht == "ar2" then self.Primary.LungeMeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
			elseif ht == "shotgun" then self.Primary.LungeMeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN
			elseif ht == "rpg" then self.Primary.LungeMeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG
			elseif ht == "physgun" then self.Primary.LungeMeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_PHYSGUN
			elseif ht == "crossbow" then self.Primary.LungeMeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
			elseif ht == "melee" then self.Primary.LungeMeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
			elseif ht == "slam" then self.Primary.LungeMeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM
			elseif ht == "normal" then self.Primary.LungeMeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK
			elseif ht == "fist" then self.Primary.LungeMeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST
			elseif ht == "melee2" then self.Primary.LungeMeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2
			elseif ht == "passive" then self.Primary.LungeMeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK
			elseif ht == "knife" then self.Primary.LungeMeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
			elseif ht == "duel" then self.Primary.LungeMeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_DUEL
			elseif ht == "camera" then self.Primary.LungeMeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_CAMERA
			elseif ht == "magic" then self.Primary.LungeMeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_MAGIC
			elseif ht == "revolver" then self.Primary.LungeMeleeActCrouch = ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER
			end
		end
	end
	
	if self.LoopFireSound == nil && self.Primary.LoopingFireSound != nil then
		self.LoopFireSound = CreateSound(self, self.Primary.LoopingFireSound)
	end
	
	if self.Primary.Ammo != nil then
		self:SetNWInt("LoadedAmmo", self:Clip1() )
	end
	
	timer.Simple(0, function()
		if !self.ModifyText then self.ModifyText = "modify ".. (self.InfoName or self.PrintName or "null") .."" end
	end)
	
	self:InitialFireMode()
	self:DoCustomInitialize()
	
	-- SCK Stuff
	if CLIENT then
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )
		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels
		
		if IsValid(ply) && ply:IsPlayer() then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					vm:SetColor(Color(255,255,255,1))
					vm:SetMaterial("Debug/hsv")			
				end
			end
		end
	end
	
	--[[
	if !self.IsMelee then
		timer.Simple(engine.TickInterval() * 5, function()
			if !IsValid(self) then return end
			if !self:HasViewModel() then return end
			local ply = self:GetOwner()
			if !ply:IsPlayer() then return end
			local vm = ply:GetViewModel()
			local att = vm:LookupAttachment("muzzle")
			local attinfo = vm:GetAttachment(att)
			if !attinfo then DRC:Notify(self, "hint", "critical", "".. self.PrintName .." does not have a muzzle attachment, expect problems!", ENUM_ERROR, 10) end
		end)
	end ]]
	
	self.Initialized = true
end

function SWEP:DoCustomInitialize()
end

FireTime = CurTime()
SWEP.RealTime = 0
local ironsounds = {
	["ar2"] = {"draconic.IronInRifle", "draconic.IronOutRifle"},
	["smg"] = {"draconic.IronInSMG", "draconic.IronOutSMG"},
	["duel"] = {"draconic.IronInSMG", "draconic.IronOutSMG"},
	["pistol"] = {"draconic.IronInPistol", "draconic.IronOutPistol"},
	["revolver"] = {"draconic.IronInPistol", "draconic.IronOutPistol"},
	["shotgun"] = {"draconic.IronInShotgun", "draconic.IronOutShotgun"},
	["crossbow"] = {"draconic.IronInShotgun", "draconic.IronOutShotgun"},
	["rpg"] = {"draconic.IronInShotgun", "draconic.IronOutShotgun"},
	["physgun"] = {"draconic.IronInShotgun", "draconic.IronOutShotgun"},
	["grenade"] = {"draconic.IronInGeneric", "draconic.IronOutGeneric"},
	["slam"] = {"draconic.IronInGeneric", "draconic.IronOutGeneric"},
	["melee"] = {"draconic.IronInGeneric", "draconic.IronOutGeneric"},
	["melee2"] = {"draconic.IronInGeneric", "draconic.IronOutGeneric"},
	["passive"] = {"draconic.IronInGeneric", "draconic.IronOutGeneric"},
	["normal"] = {"draconic.IronInGeneric", "draconic.IronOutGeneric"},
	["knife"] = {"draconic.IronInGeneric", "draconic.IronOutGeneric"},
	["camera"] = {"draconic.IronInGeneric", "draconic.IronOutGeneric"},
	["magic"] = {"draconic.IronInGeneric", "draconic.IronOutGeneric"},
}

function SWEP:Think()
	local ply = self:GetOwner()
	if !IsValid(ply) or !ply:Alive() then return end
	local health = DRC:Health(ply)
	local charge, heat = self:GetCharge(), self:GetHeat()
	local cv = ply:Crouching()
	local vm = ply:GetViewModel(0)
	local hands = ply:GetHands()
	
	self:DoCustomThink()
	self:ManageAnims()
	
	if CLIENT && game.SinglePlayer() && RealTime() > self.RealTime then
		self.RealTime = RealTime() + RealFrameTime() -- For some reason, calling :GetCycle() inside of Think() will be called three times per frame. The first one will always return 0. This prevents it from being called multiple times and prevents glitchy-looking-behaviour.
		local seq, cycle = ply:GetViewModel(0):GetSequence(), ply:GetViewModel(0):GetCycle()
		self.VMSequence = seq
		self.VMCycle = cycle
	elseif !game.SinglePlayer() then
		local seq, cycle = ply:GetViewModel(0):GetSequence(), ply:GetViewModel(0):GetCycle()
		self.VMSequence = seq
		self.VMCycle = cycle
	end
	
	if !self.IsMelee then -- For some other reason, this breaks animations on the melee base.
		if self:HasViewModel() && string.lower(vm:GetModel()) != string.lower(self.ViewModel) then vm:SetModel(self.ViewModel) end
		if self.ShowWorldModel == true && (self.WorldModel != nil or self.WorldModel != "") then self:SetModel(self.WorldModel) end
	end
	
	if CLIENT then
		local wl = ply:WaterLevel()
		local oa = self.OwnerActivity
		local l, r, f, b = ply:KeyDown(IN_MOVELEFT), ply:KeyDown(IN_MOVERIGHT), ply:KeyDown(IN_FORWARD), ply:KeyDown(IN_BACK)
		
		if (l or r or b or f) && cv == false && wl <= 2 then
			if ply:KeyDown(IN_SPEED) then self.OwnerActivity = "sprinting"
			else self.OwnerActivity = "running" end
		elseif (l or r or b or f) && cv == true && wl <= 2 then
			if ply:KeyDown(IN_SPEED) then self.OwnerActivity = "crouchsprinting"
			else self.OwnerActivity = "crouchrunning" end
		elseif (!l or !r or !b or !f) && cv == false && wl <= 2 then
			self.OwnerActivity = "standidle"
		elseif (!l or !r or !b or !f) && cv == true && wl <= 2 then
			self.OwnerActivity = "crouchidle"
		elseif (l or r or b or f or ply:KeyDown(IN_JUMP)) && wl > 2 then
			if ply:KeyDown(IN_SPEED) then self.OwnerActivity = "fastswimming"
			else self.OwnerActivity = "swimming" end
		elseif (!l or !r or !b or !f) && wl > 2 then
			self.OwnerActivity = "swimidle"
		end
	end
	
	if self:CanUseSights() && self.Secondary.Ironsights == true && self.IronCD == false && self.Secondary.Disabled == false then
		if self.SightsDown != self:GetNWBool("SightsDown") then self.SightsDown = self:GetNWBool("SightsDown") end
		--if ply:KeyPressed(IN_ATTACK2) == true && self:GetNWBool("ironsights") == false && self:GetNWBool("Inspecting") == false && self.IronCD == false && self.Passive == false && !ply:KeyDown(IN_USE) then
		if ply:KeyPressed(IN_ATTACK2) == true && self.SightsDown == false && self:GetNWBool("Inspecting") == false && self.IronCD == false && self.Passive == false && !ply:KeyDown(IN_USE) then
			self:SetIronsights(true, self.Owner)
			ply:SetFOV(ply:GetFOV() * (self.Secondary.IronFOV / 90), 0.35)
			self:AdjustMouseSensitivity()
			self:IronCoolDown()
			ply:EmitSound(ironsounds[string.lower(self:GetHoldType())][1])
			if CLIENT && self.Secondary.IronInFP != nil then
				surface.PlaySound(Sound(self.Secondary.IronInFP))
			end
		--elseif ply:KeyReleased(IN_ATTACK2) == true && self:GetNWBool("ironsights") == true && self.IronCD == false && !ply:KeyDown(IN_USE) then
		elseif ply:KeyReleased(IN_ATTACK2) == true && self.SightsDown == true && self.IronCD == false && !ply:KeyDown(IN_USE) then
			self:SetIronsights(false, self.Owner)
			ply:SetFOV(0, 0.35)
			self:IronCoolDown()
			ply:EmitSound(ironsounds[string.lower(self:GetHoldType())][2])
			if CLIENT && self.Secondary.IronOutFP != nil then
				surface.PlaySound(Sound(self.Secondary.IronOutFP))
			end
		end
	elseif self:CanUseSights() && self.Secondary.Ironsights == false or self.IronCD == true or self.Loading == true then
		self:SetIronsights(false, self.Owner)
	elseif !self:CanUseSights() then
		self:SetIronsights(false, self.Owner)
		ply:SetFOV(0, 0)
	end
	
	if CurTime() > self.SightsSwapCD && self.IronSightsPosAlt != nil && ply:KeyDown(IN_WALK) && ply:KeyPressed(IN_RELOAD) then
		self.SightsSwapCD = CurTime() + 0.25
		if self.AltSightBool == false or self.AltSightBool == nil then
			self.AltSightBool = true
			self.VARSightPos = self.IronSightsPosAlt
			self.VARSightAng = self.IronSightsAngAlt
		else
			self.AltSightBool = false
			self.VARSightPos = self.IronSightsPos
			self.VARSightAng = self.IronSightsAng
		end
		if self.SightSwapCD == true then return end
	end
	
	if CLIENT && self.ScopeUp == false && self.Secondary.Scoped == true then
		self.ScopeUp = true
	elseif CLIENT && self.ScopeUp == true then
		self.ScopeUp = false
	end

	if self.Primary.UsesCharge == true then
		local m1p = ply:KeyPressed(IN_ATTACK)
		local m1d = ply:KeyDown(IN_ATTACK)
		local m1r = ply:KeyReleased(IN_ATTACK)
		local ukd = ply:KeyDown(IN_USE)
			
		if (SERVER or !game.IsDedicated()) && ply:IsPlayer() then
			if game.SinglePlayer() && !IsFirstTimePredicted() then return end
			if self.ChargeType == "dualheld" then
				if m1r && self:CanPrimaryAttack() == true && !self:CanOvercharge() && !ukd then
					if FireTime < CurTime() then FireTime = CurTime() + 60 / self.Primary.RPM self:CallShoot("primary") end
				elseif m1r && self:CanOvercharge() && self:CanPrimaryAttack() then self:CallShoot("overcharge") end
			elseif self.ChargeType == "dualaction" then
				if m1d && self:CanPrimaryAttack() && self:CanOvercharge() then self:CallShoot("overcharge") end
				if m1r && self:CanPrimaryAttack() == true && !self:CanOvercharge() && !ukd then self:CallShoot("primary") end
			elseif self.ChargeType == "discharge" then
				if m1d && self:CanPrimaryAttack() == true && self:CanOvercharge() && !ukd then
					self:CallShoot("overcharge")
				end
			elseif self.ChargeType == "held" then
				if m1r && self:CanOvercharge() then self:CallShoot("overcharge") end
			elseif self.ChargeType == "default" then
			end
		end
	end
	
	if self.Secondary.UsesCharge == true then
		local m1p = ply:KeyPressed(IN_ATTACK2)
		local m1d = ply:KeyDown(IN_ATTACK2)
		local m1r = ply:KeyReleased(IN_ATTACK2)
		local ukd = ply:KeyDown(IN_USE)
			
		if (SERVER or !game.IsDedicated()) && ply:IsPlayer() then
			if game.SinglePlayer() && !IsFirstTimePredicted() then return end
			if self.ChargeType == "dualheld" then
				if m1r && self:CanPrimaryAttack() == true && !self:CanOvercharge() && !ukd then
					if FireTime < CurTime() then FireTime = CurTime() + 60 / self.Primary.RPM self:CallShoot("primary") end
				elseif m1r && self:CanOvercharge() && self:CanPrimaryAttack() then self:CallShoot("overcharge") end
			elseif self.ChargeType == "dualaction" then
				if m1d && self:CanPrimaryAttack() && self:CanOvercharge() then self:CallShoot("overcharge") end
				if m1r && self:CanPrimaryAttack() == true && !self:CanOvercharge() && !ukd then self:CallShoot("primary") end
			elseif self.ChargeType == "discharge" then
				if m1d && self:CanPrimaryAttack() == true && self:CanOvercharge() && !ukd then
					self:CallShoot("overcharge")
				end
			elseif self.ChargeType == "held" then
				if m1r && self:CanOvercharge() then self:CallShoot("overcharge") end
			elseif self.ChargeType == "default" then
			end
		end
	end

	if self:GetNWBool("Passive") == true then
		if self.LoopingFireSound != nil then
			self.LoopingFireSound:Stop()
		end
		if self.LoopingFireSoundSecondary != nil then
			self.LoopingFireSoundSecondary:Stop()
		end
	end
	
	if self.Primary.UsesCharge == true or self.Secondary.UsesCharge == true then
		if !self.ChargingSound then self.ChargingSound = CreateSound(self, self.ChargeSound) end
	end
	
	if !game.IsDedicated() then
		local oh = self:GetNWBool("Overheated")
		
		if self.Primary.UsesCharge == true then
			if ply:KeyPressed(IN_ATTACK) && self:GetNWBool("Passive") == false && !ply:KeyDown(IN_USE) && self:CanPrimaryAttack() then
				self.ChargingSound:Play()
			elseif !ply:KeyDown(IN_ATTACK) or oh == true then
				self.ChargingSound:Stop()
			end
		elseif self.Secondary.UsesCharge == true then
			if ply:KeyPressed(IN_ATTACK2) && self:GetNWBool("Passive") == false && !ply:KeyDown(IN_USE) then
				self.ChargingSound:Play()
			elseif !ply:KeyDown(IN_ATTACK2) or oh == true then
				self.ChargingSound:Stop()
			end
		end
	
		if self.Primary.LoopingFireSound != nil && self.Readied == true then
			if ply:KeyPressed(IN_ATTACK) && self:CanPrimaryAttack() && self:GetNWBool("Passive") == false && !ply:KeyDown(IN_USE) && oh == false && self:Clip1() > 0 then
				self:EmitSound(self.Primary.LoopingFireSoundIn)
				-- self:EmitSound(self.Primary.LoopingFireSound)
				self.LoopFireSound:Play()
			else end
			
			if !ply:KeyDown(IN_ATTACK) or oh == true or ply:KeyPressed(IN_USE) then
				--self:StopSound(self.Primary.LoopingFireSound)
				if self.LoopFireSound then self.LoopFireSound:Stop() end
			end

			if self:Clip1() > 0 then
				if (ply:KeyReleased(IN_ATTACK) && !ply:KeyDown(IN_USE) && oh == false) or (ply:KeyDown(IN_ATTACK) && oh == false && ply:KeyPressed(IN_USE)) then
					if !ply:KeyDown(IN_SPEED) then self:EmitSound(self.Primary.LoopingFireSoundOut) end
				end
			end
			
			if self:Clip1() <= 0 && self.LoopOutEmptyPlayed == false then
				self.LoopFireSound:Stop()
				self:EmitSound(self.Primary.LoopingFireSoundOut)
				self.LoopOutEmptyPlayed = true
			end
		end
	end
	
	if self.LoopingFireSound != nil && (self.Primary.isvFire == true or self.Secondary.isvFire == true) then
		if (self.Owner:KeyReleased(IN_ATTACK) && self:GetNWBool("Passive") == false || (!self.Owner:KeyDown(IN_ATTACK) && self.LoopingFireSound)) then
			if self:CanPrimaryAttack() == true then
				if (self.LoopingFireSound) then
					self.LoopFireSound:Stop()
					self.LoopingFireSound = nil
					self:PlayCloseSound()
					if (!game.SinglePlayer()) then self:CallOnClient("PlayCloseSound", "") end
				end
			else self.LoopingFireSound:Stop() end
		end
	end
	
	if self.LoopingFireSoundSecondary != nil then
		if (self.Owner:KeyReleased(IN_ATTACK2) && self:GetNWBool("Passive") == false || (!self.Owner:KeyDown(IN_ATTACK2) && self.LoopingFireSoundSecondary)) then
			if self:CanPrimaryAttack() == true then
				if (self.LoopingFireSoundSecondary) then
					self.LoopingFireSoundSecondary:Stop()
					self.LoopingFireSoundSecondary = nil
					self:PlayCloseSound()
					if (!game.SinglePlayer()) then self:CallOnClient("PlayCloseSound", "") end
				end
			else self.LoopingFireSoundSecondary:Stop() end
		end
	end
	
	if ply:IsPlayer() && self.RegenAmmo == true then self:RegeneratingAmmo(self, self.RegenAmmo_Delay, self.RegenAmmo_Amount) end
	
	if !game.SinglePlayer() then return end -- I have to set viewmodel poseparameters in here because they're controlled by the server in singleplayer for some reason, and PreDrawViewModel is client only. Epic.
	if CLIENT then return end

	self.AmmoCL = Lerp(0.25, self.AmmoCL or self:Clip1(), self:Clip1())
	self.ChargeCL = Lerp(0.25, self.ChargeCL or charge, charge)
	self.HeatCL = Lerp(0.25, self.HeatCL or heat, heat)
	self.HealthCL = Lerp(0.25, self.HealthCL or health, health)
		
	if self.PistolSlide <= 0 then
		self.EmptyMagCL = Lerp(FrameTime() * 50, self.EmptyMagCL or self.PistolSlide, 0)
	else
		self.EmptyMagCL = Lerp(FrameTime() * 50, self.EmptyMagCL or self.PistolSlide, 1)
	end
	
	if self.Primary.Ammo != nil && vm:GetPoseParameter("drc_ammo") != nil then vm:SetPoseParameter("drc_ammo", self.AmmoCL / self.Primary.ClipSize) end
	if self.Primary.Ammo != nil && vm:GetPoseParameter("drc_emptymag") != nil then vm:SetPoseParameter("drc_emptymag", self.EmptyMagCL) end
	if self.Primary.Ammo == "ammo_drc_battery" && vm:GetPoseParameter("drc_heat") != nil then vm:SetPoseParameter("drc_heat", self.HeatCL / 100) end
	if self.Primary.Ammo == "ammo_drc_battery" && vm:GetPoseParameter("drc_battery") != nil then vm:SetPoseParameter("drc_battery", self.AmmoCL / 100) end
	if vm:GetPoseParameter("drc_health") != nil then vm:SetPoseParameter("drc_health", (self.HealthCL / ply:GetMaxHealth()) / 100) end
	if vm:GetPoseParameter("drc_charge") != nil then vm:SetPoseParameter("drc_charge", self.ChargeCL / 100) end
end

function SWEP:CanGunMelee()
	local ply = self:GetOwner()
	--local sights = self:GetNWBool("ironsights")
	local sights = self.SightsDown
	local passive = self:GetNWBool("Passive")
	local inspection = self:GetNWBool("Inspecting")
	
	if self.Primary.CanMelee == false then return false end
	if inspection == true then return false end
	if sights == false && passive == false then return true else return false end
end

function SWEP:ManageAnims()
	if !IsValid(self) then return end
	if !self:IsIdle() then return end
	if !IsFirstTimePredicted() then return end
	local ply = self:GetOwner()
	
	if !IsValid(ply) then return end
	if !self:HasViewModel() then return end
	local vm = ply:GetViewModel()
	if !IsValid(vm) then return end
	if vm:GetModel() == "" or vm:GetModel() == nil then return end
	local oa = self.OwnerActivity
	local cv = ply:Crouching()
	local slowvar = ply:Crouching() or ply:KeyDown(IN_WALK)
	local walking = (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK)) && !ply:KeyDown(IN_SPEED)
	local sprinting = (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK)) && ply:KeyDown(IN_SPEED)
	
		if self.ManuallyReloading == true or self.Loading == true or self.Idle == 0 then return end
	
		local idleanim = vm:SelectWeightedSequence(ACT_VM_IDLE)
		local walkanim = vm:SelectWeightedSequence(ACT_WALK)
		local sprintanim = vm:SelectWeightedSequence(ACT_RUN)
		local swimidleanim = vm:SelectWeightedSequence(ACT_SWIM_IDLE)
		local swimminganim = vm:SelectWeightedSequence(ACT_SWIM)
		local fireanim = vm:SelectWeightedSequence(ACT_VM_PRIMARYATTACK)
		local firedur = vm:SequenceDuration(fireanim)
		
		local reloadanim = vm:SelectWeightedSequence( ACT_VM_RELOAD )
		local walkanim = vm:SelectWeightedSequence( ACT_WALK )
		
		local anim = vm:GetSequence()
		local animdata = vm:GetSequenceInfo(anim)
		
		if self.SightsDown && CurTime() > self.LastFireAnimTime then
			vm:SendViewModelMatchingSequence(idleanim)
		return end
		
		if self.IsDoingMelee == true then 
			self.FPAnimMul = 1
		else
			if slowvar && CurTime() > self.LastFireAnimTime then
				self.FPAnimMul = 0.5
			else
				self.FPAnimMul = 1
			end
		end
		
		if !walking && !sprinting then
			self.AnimToPlay = idleanim
		elseif walking then
			vm:SetPlaybackRate(self.FPAnimMul)
			if walkanim == -1 then
				self.AnimToPlay = idleanim
			else
				self.AnimToPlay = walkanim
			end
		elseif sprinting && !cv then
			if sprintanim == -1 then
				self.AnimToPlay = idleanim
			else
				self.AnimToPlay = sprintanim
			end
		end
		
		if walking then
			if animdata.activityname == "ACT_VM_IDLE" or animdata.activityname == "ACT_RUN" then self.IdleTimer = CurTime() end
		elseif sprinting then
			if animdata.activityname == "ACT_WALK" or animdata.activityname == "ACT_VM_IDLE" then self.IdleTimer = CurTime() end
		elseif !walking or !sprinting then
			if animdata.activityname == "ACT_WALK" or animdata.activityname == "ACT_RUN" then self.IdleTimer = CurTime() end
		end
		
		if self.IdleTimer <= CurTime() then
			if idleanim == -1 then return end
			vm:SendViewModelMatchingSequence(self.AnimToPlay)
			if self.AnimToPlay == walkanim then
				if slowvar then
					self.IdleTimer = CurTime() + (vm:SequenceDuration(self.AnimToPlay) * 2)
				else
					self.IdleTimer = CurTime() + vm:SequenceDuration(self.AnimToPlay)
				end
			else
				self.IdleTimer = CurTime() + vm:SequenceDuration(self.AnimToPlay)
			end
		end

	if self.IdleTimer <= CurTime() then
		vm:ResetSequence(idleanim)
		vm:ResetSequence(reloadanim)
		vm:ResetSequence(walkanim)
	end
end

function SWEP:DoCustomThink()
end

SWEP.MulIns = 0
if CLIENT then
local dang = Angle(0, 0, 0)
local oang = Angle(0, 0, 0)
local LLTime = 0

SWEP.InterpolateHolsterBoolVal = 1
SWEP.VelInterp = 0
SWEP.KickOffset = Vector()
SWEP.KickVal = 0
function SWEP:GetViewModelPosition( pos, ang )

	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	if !IsValid(self) then return end
	if ply:IsWorld() then return end
	
	local vel = math.Clamp(ply:GetVelocity():LengthSqr()/36100, 0, 1)
	self.VelInterp = Lerp(0.1, self.VelInterp or vel, vel)
	
	local vm = ply:GetViewModel()
	local eyeangforward = ply:EyeAngles()
	local sd = self.SightsDown
	local cv = ply:Crouching()
	local oa = self.OwnerActivity
	local sk = ply:KeyDown(IN_SPEED)
	local mk = (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK))
	local issprinting = sk && mk

	local ironBool = self.SightsDown
	local passiveBool = self:GetNWBool( "Passive" )
	local inspectBool = self:GetNWBool( "Inspecting" )
	
	local holsterbool = false
	if passiveBool == true or issprinting == true then self.InterpolateHolsterBoolVal = 1 holsterbool = true else self.InterpolateHolsterBoolVal = 0 end
	self.InterpolatedHolsterVal = Lerp(RealFrameTime() * 10, self.InterpolatedHolsterVal or self.InterpolateHolsterBoolVal, self.InterpolateHolsterBoolVal)
	
	if self.DoesPassiveSprint == true or GetConVar("sv_drc_force_sprint"):GetFloat() == 1 then
		local upperstrength = math.abs(eyeangforward.x/2) / 45
		ang = ang + Angle(math.Clamp(-eyeangforward.x/2, -30, 45), 0, 0) * self.InterpolatedHolsterVal * upperstrength
		local holsteroffset = (Vector(0, -7.5, -3) * self.InterpolatedHolsterVal) * (math.abs(eyeangforward.x/2) / 45)
		pos:Add(ang:Right() * holsteroffset.x)
		pos:Add(ang:Forward() * holsteroffset.y)
		pos:Add(ang:Up() * holsteroffset.z)
	end
	
	if ironBool == true or (ply:GetCanZoom() == true && ply:KeyDown(IN_ZOOM)) then
		self.LoweredCrossHairMod = Lerp(RealFrameTime() * 10, self.LoweredCrossHairMod or 1, 0)
	else
		self.LoweredCrossHairMod = Lerp(RealFrameTime() * 10, self.LoweredCrossHairMod or 0, 1)
	end
	
	if (ironBool != self.lastIron) then
		self.lastIron = ironBool 
		self.fIronTime = CurTime()
	end
	
	if (passiveBool != self.lastPassive) then
		self.lastPassive = passiveBool 
		self.fPassiveTime = CurTime()
	end
	
	if (inspectBool != self.LastInspect) then
		self.LastInspect = inspectBool 
		self.fInspectTime = CurTime()
	end
	
	if (cv != self.lastCV) then
		self.lastCV = cv
		self.fCrouchOffSTime = CurTime()
	end
	
	if (issprinting != self.lastSK) then
		self.lastSK = issprinting
		self.SprintOffSTime = CurTime()
	end
	
	local fIronTime = self.fIronTime or 0	
	local fPassiveTime = self.fPassiveTime or 0
	local fInspectTime = self.fInspectTime or 0
	local fCrouchOffSTime = self.fCrouchOffSTime or 0
	local SprintOffSTime = self.SprintOffSTime or 0
	
	self.MulI = math.Clamp((CurTime() - fIronTime) / 0.35, 0, 1)
	local MulP = math.Clamp((CurTime() - fPassiveTime) / 0.325, 0, 1)
	self.MulIns = math.Clamp((CurTime() - fInspectTime) / 0.325, 0, 1)
	local MulC = math.Clamp((CurTime() - fCrouchOffSTime) / 0.265, 0, 1)
	local MulS = math.Clamp((CurTime() - SprintOffSTime) / 0.23, 0, 1)
	local MulSFade = math.Clamp((CurTime() - SprintOffSTime) / 0.5, 0, 1)
	
	local MulCx = math.Clamp((CurTime() - fCrouchOffSTime) / 0.3, 0, 1)
	local MulCy = math.Clamp((CurTime() - fCrouchOffSTime) / 0.32, 0, 1)
	local MulCz = math.Clamp((CurTime() - fCrouchOffSTime) / 0.265, 0, 1)
	
	self.VARSightPos_Lerped = Lerp(RealFrameTime() * 10, self.VARSightPos_Lerped or self.VARSightPos, self.VARSightPos)
	self.VARSightAng_Lerped = Lerp(RealFrameTime() * 10, self.VARSightAng_Lerped or self.VARSightAng, self.VARSightAng)
	
		--[[ PERSPECTIVE OFFSETS ]]--
			--if self:GetNWBool("ironsights") == false then
			if self.SightsDown == false then
				local POX = (eyeangforward.x / 135)
				local POY = (eyeangforward.x / 100 * 5)
				local POZ = (eyeangforward.x / -45)
				local AOX = (eyeangforward.x / 30)
				
				self.VAPos = Vector(POX, POY, POZ)
				self.VAAng = Vector(AOX, 0, 0)

				self.VARPos = LerpVector(self.MulI, -self.VMPos + self.VARSightPos_Lerped / 255, self.VAPos ) * math.Clamp(self.PerspectivePower, 0, 1)
				self.VARAng = LerpVector(self.MulI, Vector(0, 0, 0), self.VAAng ) * math.Clamp(self.PerspectivePower, 0, 1)
				
				self.DownCorrectionPos = Vector()
				self.DownCorrectionAng = Vector()
				self.DownCorrectionAng.z = self.DownCorrectionAng.z - (eyeangforward.x / 10) * math.Clamp(self.PerspectivePower, 0, 1)
				self.DownCorrectionAng.z = math.Clamp(self.DownCorrectionAng.z, -10, 2) * math.Clamp(self.PerspectivePower, 0, 1)
				self.DownCorrectionAng.y = self.DownCorrectionAng.y + math.abs(eyeangforward.x / 90) * math.Clamp(self.PerspectivePower, 0, 1)
				
				local eyepos = ply:EyePos()
			
				local onehand = { "pistol", "slam", "magic" }
				local twohand = { "smg", "ar2", "shotgun", "crossbow", "camera", "revolver" }
				local dualtypes = { "duel" }
				local lowtypes = { "physgun" }
				local hightypes = { "rpg" }
				local meleetypes = { "melee", "knife", "grenade", "slam" }
				local meleetwohand = { "melee2" }
				local handguns = { "pistol", "revolver" }
				
				local walloffset, heft = {}, 10
				if CTFK(handguns, self:GetHoldType()) then
					heft = 10
					walloffset = {
						Vector(-2, -5, 1),
						Vector(0, 0, 0),
					}
				elseif CTFK(meleetwohand, self:GetHoldType()) then
					heft = 3
					walloffset = {
						Vector(2, -5, -3),
						Vector(25, -7.5, -15),
					}
				else
					heft = 5
					walloffset = {
						Vector(2, -5, -1),
						Vector(5, 6, 0),
					}
				end
				
				local aids = ply:GetEyeTrace().HitPos
				local hiv = math.Round(ply:EyePos():Distance(aids))
				hiv = math.Clamp(hiv, 0, 50) / 50
				hiv = 1 - hiv
				self.walllerpval = Lerp((0.008) * heft, self.walllerpval or hiv, hiv) * math.Clamp(self.NearWallPower, 0, 1)
				local wallpos = Lerp(self.walllerpval, Vector(), walloffset[1])
				local wallang = Lerp(self.walllerpval, Vector(), walloffset[2])
				
				self.VARPos = self.VARPos + self.DownCorrectionPos + wallpos
				self.VARAng = self.VARAng + self.DownCorrectionAng + wallang
			else
			
			end
			DynaPosLerp = Lerp(0.008, DynaPosLerp or self.VAPos, self.VAPos)
			DynaAngLerp = Lerp(0.008, DynaAngLerp or self.VAAng, self.VAAng)
	
		--[[ CROUCH OFFSETS ]]--
			if cv == true then
				local x = Lerp( MulCx, self.VMPos.x, self.VMPosCrouch.x + self.VMPos.x)
				local y = Lerp( MulCy, self.VMPos.y, self.VMPosCrouch.y + self.VMPos.y)
				local z = Lerp( MulCz, self.VMPos.z, self.VMPosCrouch.z + self.VMPos.z)
				
				self.CPos  = Vector(x,y,z)
				self.CRPos = LerpVector( MulC, self.VMPos, self.CPos)
			else
				local x = Lerp( MulCx, self.VMPosCrouch.x + self.VMPos.x, self.VMPos.x)
				local y = Lerp( MulCy, self.VMPosCrouch.y + self.VMPos.y, self.VMPos.y)
				local z = Lerp( MulCz, self.VMPosCrouch.z + self.VMPos.z, self.VMPos.z)
				
				self.CPos  = Vector(x,y,z)
				self.CRPos = LerpVector( MulC, self.CPos, self.VMPos)
			end
			
			self.CPosLerp = LerpVector(MulC, self.CRPos, self.CPos)
		
			if cv == true then
				local x = Lerp( MulCx, self.VMAng.x, self.VMAngCrouch.x + self.VMAng.x)
				local y = Lerp( MulCy, self.VMAng.y, self.VMAngCrouch.y + self.VMAng.y)
				local z = Lerp( MulCz, self.VMAng.z, self.VMAngCrouch.z + self.VMAng.z)
				
				self.CAng = Vector(x,y,z)
				self.CRAng = LerpVector( MulC, self.VMAng, self.CAng)
			else
				local x = Lerp( MulCx, self.VMAngCrouch.x + self.VMAng.x, self.VMAng.x)
				local y = Lerp( MulCy, self.VMAngCrouch.y + self.VMAng.y, self.VMAng.y)
				local z = Lerp( MulCz, self.VMAngCrouch.z + self.VMAng.z, self.VMAng.z)
				
				self.CAng = Vector(x,y,z)
				self.CRAng = LerpVector( MulC, self.CAng, self.VMAng)
			end
			
			self.CAngLerp = LerpVector(MulC, self.CRAng, self.CAng)
			
		--[[ PASSIVE OFFSETS ]]--
		--if self.PPosOG == nil then self.PPosOG = self.PassivePos end
		--	if self.PAngOG == nil then self.PAngOG = self.PassiveAng end
		--	self.PassivePos.x = self.PPosOG.x + ply:GetAngles().x / 2
		--	self.PassiveAng.y = self.PAngOG.y - eyeangforward.x / 10
		--	self.PassiveAng.z = self.PAngOG.z - math.abs(eyeangforward.x / 50)
		
			if passiveBool == true then
				self.PPos = LerpVector( MulP, self.VMPos, self.PassivePos + self.VMPos)
				self.PRPos = LerpVector( MulP, self.VMPos, -self.PassivePos + self.VMPos)
			else
				self.PPos = LerpVector( MulP, -self.PassivePos + self.VMPos, self.VMPos)
				self.PRPos = LerpVector( MulP, -self.PassivePos + self.VMPos, self.VMPos)
			end
			
			self.PRPosLerp = LerpVector( MulP, self.PPos, self.PRPos)
		
			if passiveBool == true then
				self.PAng = LerpVector( MulP, self.VMAng, self.PassiveAng + self.VMAng)
				self.PRAng = LerpVector( MulP, self.VMAng, -self.PassiveAng + self.VMAng)
			else
				self.PAng = LerpVector( MulP, -self.PassiveAng + self.VMAng, self.VMAng)
				self.PRAng = LerpVector( MulP, -self.PassiveAng - self.VMAng, self.VMAng )
			end
			
			self.PRAngLerp = LerpVector(MulP, self.PAng, self.PRAng)
			
			--[[ INSPECT OFFSETS ]]--
			if inspectBool == true then
				self.InsPos = LerpVector( self.MulIns, self.VMPos, self.InspectPos + self.VMPos)
				self.InsRPos = LerpVector( self.MulIns, self.VMPos, -self.InspectPos + self.VMPos)
			else
				self.InsPos = LerpVector( self.MulIns, -self.InspectPos + self.VMPos, self.VMPos)
				self.InsRPos = LerpVector( self.MulIns, -self.InspectPos + self.VMPos, self.VMPos)
			end
			
			self.InsRPosLerp = LerpVector( self.MulIns, self.InsPos, self.InsRPos)
		
			if inspectBool == true then
				self.InsAng = LerpVector( self.MulIns, self.VMAng, self.InspectAng + self.VMAng)
				self.InsRAng = LerpVector( self.MulIns, self.VMAng, -self.InspectAng + self.VMAng)
			else
				self.InsAng = LerpVector( self.MulIns, -self.InspectAng + self.VMAng, self.VMAng)
				self.InsRAng = LerpVector( self.MulIns, -self.InspectAng - self.VMAng, self.VMAng )
			end
			
			self.InsRAngLerp = LerpVector(self.MulIns, self.InsAng, self.InsRAng)
			
		--[[ SIGHT OFFSETS ]]--
			if sd == true then
				self.IPos = LerpVector( self.MulI, self.VMPos, self.VARSightPos_Lerped + self.VMPos)
				self.IRPos = LerpVector( self.MulI, self.VMPos, -self.VARSightPos_Lerped + self.VMPos)
			else
				self.IPos = LerpVector( self.MulI, -self.VARSightPos_Lerped + self.VMPos, self.VMPos)
				self.IRPos = LerpVector( self.MulI, -self.VARSightPos_Lerped - self.VMPos, self.VMPos )
			end
			
			self.IRPosLerp = LerpVector(self.MulI, self.IPos, self.IRPos)
		
			if sd == true then
				self.IAng = LerpVector( self.MulI, self.VMAng, self.VARSightAng_Lerped + self.VMAng)
				self.IRAng = LerpVector( self.MulI, self.VMAng, -self.VARSightAng_Lerped + self.VMAng)
			else
				self.IAng = LerpVector( self.MulI, -self.VARSightAng_Lerped + self.VMAng, self.VMAng)
				self.IRAng = LerpVector( self.MulI, -self.VARSightAng_Lerped - self.VMAng, self.VMAng )
			end
			
			self.IRAngLerp = LerpVector(self.MulI, self.IAng, self.IRAng)
			
			--[[ SPRINT OFFSETS ]]--
			if issprinting == true then
				self.SPos = LerpVector( MulS, self.VMPos, self.SprintPos + self.VMPos )
				self.SRPos = LerpVector( MulS, self.VMPos, -self.SprintPos + self.VMPos )
			else
				self.SPos = LerpVector( MulS, -self.SprintPos + self.VMPos, self.VMPos )
				self.SRPos = LerpVector( MulS, -self.SprintPos - self.VMPos, self.VMPos )
			end
			
			self.SRPosLerp = LerpVector( MulS, self.SPos, self.SRPos )
		
			if issprinting == true then
				self.Sang = LerpVector( MulS, -self.VMAng, self.SprintAng + self.VMAng )
				self.SRAng = LerpVector( MulS, -self.VMAng, - self.SprintAng + self.VMAng )
			else
				self.Sang = LerpVector( MulS, -self.SprintAng + self.VMAng, self.VMAng )
				self.SRAng = LerpVector( MulS, -self.SprintAng - self.VMAng, self.VMAng )
			end
			
			self.SRAngLerp = LerpVector( MulS, self.Sang, self.SRAng)
	
	if oa == "standidle" or oa == "running" or oa == "swimidle" or oa == "swimming" then -- STANDING | Controls final interp mixes
		if self.DoesPassiveSprint == true or GetConVar("sv_drc_force_sprint"):GetString() == "1" then
			if passiveBool == true then
				self:DoPassiveHoldtype()
			elseif inspectBool == true then
				self:DoInspectHoldtype()
			else
				if self:GetNWBool("Overheated") == true then -- fucking glua wont let me just call either self.Overheated or self.IsOverheated within this function AAAAAAAA
					if self:GetHoldType() != self.OverheatHoldType then self:SetHoldType(self.OverheatHoldType) end
				elseif self:GetNWBool("Venting") == true then
					if self:GetHoldType() != self.VentingHoldType then self:SetHoldType(self.VentingHoldType) end
				else
					if self:GetHoldType() != self.HoldType then self:SetHoldType(self.HoldType) end
				end
			end
		else
			if passiveBool == true then
				self:DoPassiveHoldtype()
			elseif inspectBool == true then
				self:DoInspectHoldtype()
			end
		end
	elseif (oa == "sprinting" or oa =="fastswimming") then
		if self.DoesPassiveSprint == true or GetConVar("sv_drc_force_sprint"):GetString() == "1" then
			self:DoPassiveHoldtype()
		end
	end
	
		local sightkill = 1
		local rollval = 0
		if sd == true then
			sightkill = 1
			self.BobScale = 0.1
			self.SwayScale = 0.25
		else
			sightkill = 1
			self.BobScale = self.BS
			self.SwayScale = self.SS
		end
	
		self.IronPosLerp = Lerp(RealFrameTime() * 10, self.IronPosLerp or self.IRPosLerp, self.IRPosLerp)
		self.IronAngLerp = Lerp(RealFrameTime() * 10, self.IronAngLerp or self.IRAngLerp, self.IRAngLerp)
	
		if issprinting == false then 
			self.PassivePosLerp = Lerp(RealFrameTime() * 10, self.PassivePosLerp or self.PRPosLerp, self.PRPosLerp)
			self.PassiveAngLerp = Lerp(RealFrameTime() * 10, self.PassiveAngLerp or self.PRAngLerp, self.PRAngLerp)
		else
			self.PassivePosLerp = Lerp(RealFrameTime() * 10, self.PassivePosLerp or Vector(), Vector())
			self.PassiveAngLerp = Lerp(RealFrameTime() * 10, self.PassiveAngLerp or Vector(), Vector())
		end

		self.InspectPosLerp = Lerp(RealFrameTime() * 10, self.InspectPosLerp or self.InsRPosLerp, self.InsRPosLerp)
		self.InspectAngLerp = Lerp(RealFrameTime() * 10, self.InspectAngLerp or self.InsRAngLerp, self.InsRAngLerp)
	
		self.CrouchPosLerp = Lerp(RealFrameTime() * 10, self.CrouchPosLerp or self.CRPos, self.CRPos)
		self.CrouchAngLerp = Lerp(RealFrameTime() * 10, self.CrouchAngLerp or self.CRAng, self.CRAng)
	
		self.SprintPosLerp = Lerp(RealFrameTime() * 10, self.SprintPosLerp or self.SRPosLerp, self.SRPosLerp)
		self.SprintAngLerp = Lerp(RealFrameTime() * 10, self.SprintAngLerp or self.SRAngLerp, self.SRAngLerp)
		
		local DrcGlobalVMOffset = Vector(GetConVar("cl_drc_vmoffset_x"):GetFloat(), GetConVar("cl_drc_vmoffset_y"):GetFloat(), GetConVar("cl_drc_vmoffset_z"):GetFloat())
	
	if !self.dynmove then self.dynmove = {["Pos"] = Vector(), ["Ang"] = Vector(), ["Roll"] = 0} end
	local dyn = self.dynmove
	dyn.Ang = Vector(dyn.Ang.x, dyn.Ang.y, dyn.Ang.z)
	if (self.DoesPassiveSprint == true or GetConVar("sv_drc_force_sprint"):GetString() == "1") then
		self.VariablePos=( self.VMPos -(self.VMPos - self.CrouchPosLerp) + (self.VMPos - self.PassivePosLerp) + (self.VMPos - self.InspectPosLerp) + (self.VMPos - self.SprintPosLerp) + (self.VMPos - self.IronPosLerp) ) + DrcGlobalVMOffset
		self.VariableAng=( self.VMAng -(self.VMAng - self.CrouchAngLerp) + (self.VMAng - self.PassiveAngLerp) + (self.VMAng - self.InspectAngLerp) + (self.VMAng - self.SprintAngLerp) + (self.VMAng - self.IronAngLerp) )
		self.VariableAng = self.VariableAng + dyn.Ang
		self.VariablePos = self.VariablePos + Vector(dyn.Ang.y/8, 0, -dyn.Ang.x/8)
		
	else
		self.VariablePos=( self.VMPos -(self.VMPos - self.CrouchPosLerp) + (self.VMPos - self.PassivePosLerp) + (self.VMPos - self.InspectPosLerp) + (self.VMPos - self.IronPosLerp) ) + DrcGlobalVMOffset
		self.VariableAng=( self.VMAng -(self.VMAng - self.CrouchAngLerp) + (self.VMAng - self.PassiveAngLerp) + (self.VMAng - self.InspectAngLerp) + (self.VMAng - self.IronAngLerp) )
		self.VariableAng = self.VariableAng + dyn.Ang
		self.VariablePos = self.VariablePos + Vector(dyn.Ang.y/8, 0, -dyn.Ang.x/8)
	end

	if ironBool == true then
		self.VariablePos = self.VariablePos + Vector(-5, 0, -1)
		self.VariableAng = self.VariableAng + Vector(0, -5, -15)
	end
	
	if sd == false then
		self.OffsetsCalc = LerpVector( self.MulI, self.VARSightPos_Lerped, self.VariablePos + self.VARPos)
		self.AngleCalc = LerpVector( self.MulI, self.VARSightAng_Lerped, self.VariableAng + self.VARAng)
	else
		self.OffsetsCalc = LerpVector( self.MulI, self.VariablePos, self.VARSightPos_Lerped)
		self.AngleCalc = LerpVector( self.MulI, self.VariableAng, self.VARSightAng_Lerped + Vector(0, 0, rollval_lerp))
	end

	VariablePosLerp = Lerp(self.MulI, VariablePosLerp or self.OffsetsCalc, self.OffsetsCalc)
	VariableAngLerp = Lerp(self.MulI, VariableAngLerp or self.AngleCalc, self.AngleCalc)
	
--	PrintTable(self.dynmove)
	
	ang:RotateAroundAxis(ang:Right(), VariableAngLerp.x)
	ang:RotateAroundAxis(ang:Up(), VariableAngLerp.y)
	ang:RotateAroundAxis(ang:Forward(), VariableAngLerp.z)
	pos:Add(ang:Right() * VariablePosLerp.x)
	pos:Add(ang:Forward() * VariablePosLerp.y)
	pos:Add(ang:Up() * VariablePosLerp.z)
	
	if GetTimeoutInfo() == true then return end
	if GetConVar("cl_drc_lowered_crosshair"):GetFloat() == 1 then
		return (pos + Vector(0, 0, 0.5) * self.LoweredCrossHairMod) + self.LoweredVMPos, (ang + Angle(-5, 0, 0) * self.LoweredCrossHairMod) + Angle(self.LoweredVMAng.x, self.LoweredVMAng.y, self.LoweredVMAng.z)
	else
		return pos, ang
	end
end
end

function SWEP:Reload()
end

function SWEP:Deploy()
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	
	self:DoCustomDeploy()
	self:CallOnClient("DoCustomDeploy")
	
	local cv = ply:Crouching()
	local vm = ply:GetViewModel()
	local drawanim = vm:SelectWeightedSequence( ACT_VM_DRAW )
	local drawaniminitial = vm:SelectWeightedSequence( ACT_VM_DRAW_EMPTY )
	local drawanimdur = vm:SequenceDuration(drawanim)
	local drawaniminitialdur = vm:SequenceDuration(drawaniminitial)
	vm:SetPlaybackRate( 1 )
	self:SetIronsights(false)
	self.SightsDown = false
	if self:GetNWBool("Passive") == true then self:TogglePassive() end
	self.Idle = 1
	self.IsTaunting = 0
	self.Inspecting = false
	self.EmptyReload = 0
	self.ManuallyReloading 	= false
	self.Loading			= false
	
	if self.Thirdperson == true && ply:IsPlayer() && CLIENT then DRC:ThirdPerson_PokeLiveAngle(ply) end
	
	if self.IdleLoopSoundConstant == false && selfIdleLoopSound then
		self.IdleSound:Play()
	end
	
	if ply:IsPlayer() then
		self.DManip_PlyID = "DRC_DManip_" ..ply:Name().. ""
		self.Idle = 0
		if self.Readied == true or drawaniminitial == -1 then
			self:SendWeaponAnim( ACT_VM_DRAW )
			timer.Simple(drawanimdur, function()
				self.Readied = true
				self.Idle = 1
			end)
			self.IdleTimer = CurTime() + drawanimdur
		else
			self:SendWeaponAnim( ACT_VM_DRAW_EMPTY )
			self.IdleTimer = CurTime() + drawaniminitialdur
			timer.Simple(drawaniminitialdur, function()
				self.Readied = true
				self:SetNWBool("Readied", true)
				self.Idle = 1
			end)

		end
	end

	if self.Passive == true then
		self:DoPassiveHoldtype()
	else
		self:SetHoldType( self.HoldType )
	end
	
	self:SetCharge(0)
	
	if not IsValid(self) or not IsValid(ply) or not ply:Alive() then else
		self:GetMovementValues()
	end
	
	if self.Primary.Ammo != nil then
		self:SetNWInt("LoadedAmmo", self:Clip1() )
	else end

	self:SetNextPrimaryFire( CurTime() + drawanimdur)
	self:SetNextSecondaryFire( CurTime() + drawanimdur)
	
	if ply:IsPlayer() && self.HealthRegen == true then self:RegeneratingHealth(ply) end
	if self.SpecialScripted != true then
		if ply:IsPlayer() then
			self:BloomScore()
			timer.Simple(0.1, function() if !ply:Alive() or !IsValid(ply) or !IsValid(self) then return end self:CallOnClient( "BloomScore" ) end)
		end
	end

	if self.Primary.Ammo == "ammo_drc_battery" then
		self:SetNWFloat("HeatDispersePower", 1)
		self:DisperseHeat()
	end
	
	if self.Primary.UsesCharge == true or self.Secondary.UsesCharge == true then
		self:DisperseCharge()
	end
return true
end

function SWEP:DoCustomDeploy()
end

function SWEP:OnRemove()
	local ply = self:GetOwner()
	self.IdleTimer = CurTime()

	self:DoCustomRemove()

	if ( SERVER ) then
	if ply:IsPlayer() then
--		hook.Remove( "Move", self.HookUID_1 )
--		hook.Remove( "Move", self.HookUID_2 )
--		hook.Remove( "Move", self.HookUID_3 )
--		hook.Remove( "Move", self.HookUID_4 )
		hook.Remove( "DManipPlayerSwitchFlashlight","DManip_PlyID" )
		
		timer.Remove( self.PassiveHealing )
		if self.BloomScoreName != nil then
			timer.Remove( self.BloomScoreName )
		else end
		if self.Primary.Ammo == "ammo_drc_battery" then
			if IsValid(self) && IsValid(self.HeatDisperseTimer) then
				if timer.Exists(self.HeatDisperseTimer) then timer.Remove( self.HeatDisperseTimer ) end
			end
		else end
		if self.Primary.UsesCharge == true or self.Secondary.UsesCharge == true then
			if IsValid(self) && IsValid(self.ChargeDisperseTimer) then
				if timer.Exists(self.ChargeDisperseTimer) then timer.Remove( self.ChargeDisperseTimer ) end
			end
		else end
		
		if self.ChargeSound != nil then self:StopSound(self.ChargeSound) end
		if self.Primary.LoopingFireSound != nil then self:StopSound(self.Primary.LoopingFireSound) end
		if self.LoopFireSound != nil then self.LoopFireSound:Stop() end
		
		self:RestoreMovement()
	else end
	end
	
	if ply.IsVJBaseSNPC then
		hook.Remove("Think", self)
	end
	
	if self.Primary.Ammo == "ammo_drc_battery" then
		local ventingsound = self.VentingSound
		self:StopSound(ventingsound)
	end
	
	-- SCK
	self:Holster()
end

function SWEP:DoCustomRemove()
end

function SWEP:Holster()
	local ply = self:GetOwner()
	self.IdleTimer = CurTime()

	self:DoCustomHolster()
	--self:SetNWBool("Ironsights", false )
	self.SightsDown = false
	self:SetNWBool("Inspecting", false)
	
	if self.ChargeSound then self:StopSound(self.ChargeSound) end
	if self.Primary.LoopingFireSound then self:StopSound(self.Primary.LoopingFireSound) end
	if self.Primary.LoopingFireSoundIn then self:StopSound(self.Primary.LoopingFireSoundIn) end
	if self.Primary.LoopingFireSoundOut then self:StopSound(self.Primary.LoopingFireSoundOut) end
	if self.LoopFireSound then self.LoopFireSound:Stop() end
	
	if selfIdleLoopSound then
		if self.IdleLoopSoundConstant == false then
			self.IdleSound:Stop()
		end
	end
	
	if ( SERVER ) then
	local ply = self:GetOwner()
	if ply:IsPlayer() then
		ply:StopLoopingSound( 0 )
--		hook.Remove( "Move", self.HookUID_1 )
--		hook.Remove( "Move", self.HookUID_2 )
--		hook.Remove( "Move", self.HookUID_3 )
--		hook.Remove( "Move", self.HookUID_4 )
		hook.Remove( "DManipPlayerSwitchFlashlight","DManip_PlyID" )
		
		timer.Remove( self.PassiveHealing )
		if self.BloomScoreName != nil then
			timer.Remove( self.BloomScoreName )
		else end
		if self.Primary.Ammo == "ammo_drc_battery" && IsValid(self.HeatDisperseTimer) then
			timer.Remove( self.HeatDisperseTimer )
		else end
		if (self.Primary.UsesCharge == true or self.Secondary.UsesCharge == true) && IsValid(self.ChargeDisperseTimer) then
			timer.Remove( self.ChargeDisperseTimer )
		else end
		
		if self.ChargeSound != nil then self:StopSound(self.ChargeSound) end
		if self.Primary.LoopingFireSound != nil then self:StopSound(self.Primary.LoopingFireSound) end
		if self.LoopFireSound != nil then self.LoopFireSound:Stop() end
		
		self:RestoreMovement()
	else end
	end

	if self.Primary.Ammo == "ammo_drc_battery" then
		local ventingsound = self.VentingSound
		self:StopSound(ventingsound)
	else end
	
	-- SCK
	if CLIENT and IsValid(self.Owner) && self:GetOwner():IsPlayer() then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	
return true
end

function SWEP:RestoreMovement()
	if GetConVar("sv_drc_movement"):GetString() == "0" then return end
	local ply = self:GetOwner()

		local ogs = ply:GetNWFloat("PlayerOGSpeed")
		local ogw = ply:GetNWFloat("PlayerOGWalk")
		local ogj = ply:GetNWFloat("PlayerOGJump")
		local ogc = ply:GetNWFloat("PlayerOGCrouch")
		
		if ogs == nil or ogs == 0 then return end
		if ogw == nil or ogw == 0 then return end
		if ogj == nil or ogj == 0 then return end
		if ogc == nil or ogc == 0 then return end
		
		ply:SetWalkSpeed( ogw )
		ply:SetRunSpeed( ogs )
		ply:SetJumpPower( ogj )
		ply:SetCrouchedWalkSpeed( ogc )
end

function SWEP:DoCustomHolster()
end

function SWEP:DoCustomDrop()
end

function SWEP:OnDrop()
	if !IsValid(self) then return end
	
	self:SetOwner(nil)
	
	self:DoCustomDrop()
	net.Start("DRC_WeaponDropped")
	net.WriteEntity(self)
	net.Broadcast()
end

function SWEP:Inspect()
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	if !ply:IsPlayer() then return end
	local vm = ply:GetViewModel()
	
	self.Inspecting = true
	if game.SinglePlayer() && !IsFirstTimePredicted() then return end
	local inspectanim = self:SelectWeightedSequence(ACT_VM_FIDGET)
	local inspectdur = self:SequenceDuration(inspectanim)
	
--	self:SendWeaponAnim(ACT_VM_FIDGET)
	vm:SendViewModelMatchingSequence(inspectanim)
	
	self.IdleTimer = CurTime() + inspectdur
	
	timer.Simple( inspectdur, function() if IsValid(self) then self:EnableInspection() end end)
end

function SWEP:EnableInspection()
	self.Inspecting = false
end

function SWEP:Taunt()
	local ply = self:GetOwner()
	local tauntsounds = self.TauntSounds
	
	if self.TauntSounds == nil then else
		self.IsTaunting = 1
		ply:EmitSound( table.Random( self.TauntSounds ) )
		timer.Simple( self.TauntCooldown, function() self:TauntReady() end)
	end
end

function SWEP:TauntReady()
	self.IsTaunting = 0
end

function SWEP:IdleCheck()
	local ply = self:GetOwner()
	
	if self.Loading == true then return false
	elseif self.ManuallyReloading == true then return false
	elseif ply:GetVelocity():Length() > 0 then return false else return true end
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )

	if isnumber(self.WepSelectIcon) then
		surface.SetTexture( self.WepSelectIcon )
	elseif isstring(self.WepSelectIcon) then
		surface.SetTexture( surface.GetTextureID( self.WepSelectIcon ) )
	end
	surface.SetDrawColor( 255, 255, 255, alpha )


	alpha = 150
	surface.DrawTexturedRect( x + (wide/4), y + (tall / 16),  (wide*0.5) , ( wide / 2 ) )
	
	self:PrintWeaponInfo( x + wide, y + tall/2, alpha )
end

function SWEP:PrintWeaponInfo( x, y, alpha )

	if ( self.DrawWeaponInfoBox == false ) then return end
	
	if (self.InfoMarkup == nil ) then
		local str
		local title_color = "<color=0,200,255,255>"
		local text_color = "<color=200,200,200,255>"
		
		str = "<font=HudSelectionText>"
		if ( self.Author != "" ) then str = str .. title_color .. "Author:</color>\t\n"..text_color..self.Author.."</color>\n" end
		if ( self.Contact != "" ) then str = str .. title_color .. "Contact:</color>\t\n"..text_color..self.Contact.."</color>\n\n" end
		if ( self.Purpose != "" ) then str = str .. title_color .. "Purpose:</color>\t\n"..text_color..self.Purpose.."</color>\n\n" end
		if ( self.Instructions != "" ) then str = str .. title_color .. "Instructions:</color>\t\n"..text_color..self.Instructions.."</color>\n" end
		str = str .. "</font>"
		
		self.InfoMarkup = markup.Parse( str, 250 )
	end
	
--	y = y - self.InfoMarkup:GetHeight()
	
	surface.SetDrawColor( 60, 60, 60, alpha )
	surface.SetTexture( self.SpeechBubbleLid )
	
--	surface.DrawTexturedRect( x, y - 64, 128, 64 ) 

	draw.RoundedBox( 8, x, y, 250, self.InfoMarkup:GetHeight(), Color( 0, 0, 0, 50 ) )
	draw.RoundedBox( 0, x - 2, y, 2, self.InfoMarkup:GetHeight(), Color( 0, 200, 255, 255 ) )
	
	self.InfoMarkup:Draw( x+5, y, nil, nil, alpha )
	
end

function SWEP:AdjustMouseSensitivity()
	--if self:GetNWBool("ironsights") == true then
	if self:GetNWBool("SightsDown") == true then
		return self:GetOwner():GetFOV() / 100
	--elseif self:GetNWBool("ironsights") == false then
	else
		return 1
	end
end

function SWEP:CanUseSights()
	local ply = self:GetOwner()
	if !ply:IsPlayer() then return end
	local oh = self:GetNWBool("Overheated")
	
	if IsValid(ply:GetVehicle()) then self:SetIronsights(false) return false end
	if self:GetNWBool("Passive") == true then return false end
	
	if self.Loading == true then self:SetIronsights(false) return end
	
	if (oh or self.Loading == true or self.ManuallyReloading == true) && self.LoadAfterShot == false then 
		self.SightsDown = false
		self:SetIronsights(false)
		return false
	else return true end
end

function SWEP:IronCoolDown()
	self.IronCD = true
	timer.Simple( 0.5, function() self.IronCD = false end)
end

function SWEP:SetIronsights(b)
	local ply = self:GetOwner()
	if self.IronCD == false then
		self.SightsDown = b
		self:SetNWBool("SightsDown", b)
		if self.SightsDown then
			self.IronSightsPos = self.IronSightsPos
			self.IronSightsAng = self.IronSightsAng
		else end
	else end

	if b == true then
		ply:ViewPunch(Angle(0.15, 0, 0))
		self.SightsDown = b
	else
	end
	
	if game.SinglePlayer() then return end
	
	if CLIENT then
		self.ClientSightsDown = b
	elseif SERVER then
		self.ServerSightsDown = b
	end
	
	if CLIENT && self.ClientSightsDown != self.ServerSightsDown then
	--	self.SightsDown = self.ServerSightsDown
	end
end

function SWEP:DoPassiveHoldtype()
	if self.HoldType == "pistol" or self.HoldType == "revolver" or self.HoldType == "knife" or self.HoldType == "melee" or self.HoldType == "slam" or self.HoldType == "fist" or self.HoldType == "grenade" or self.HoldType == "duel" then
		self:SetHoldType("normal")
	elseif self.HoldType == "smg" or self.HoldType == "ar2" or self.HoldType == "rpg" or self.HoldType == "crossbow" or self.HoldType == "shotgun" or self.HoldType == "physgun" then
		self:SetHoldType("passive")
	elseif self.HoldType == "magic" or self.HoldType == "melee2" then
		self:SetHoldType("knife")
	end
end

function SWEP:DoInspectHoldtype()
	self:SetHoldType("slam")
end

function SWEP:PlayCloseSound()
	if self.Primary.isvFire == true or self.Secondary.isvFire == true then
		self:EmitSound(self.vFireStopSound, 80, math.random(90, 110))
	else
		self:EmitSound(self.LoopFireStopSound)
	end
end

function SWEP:GetShootPosition()
	local pos
	local ang

	if CLIENT then -- We're drawing the view model
		if LocalPlayer() == self:GetOwner() and GetViewEntity() == LocalPlayer() then

			local vm = LocalPlayer():GetViewModel()
			pos, ang = vm:GetBonePosition(0)
			pos = pos
				+ ang:Forward() * -5 -- Left
				+ ang:Right() * 1.5 -- Down
				+ ang:Up() * 20 -- Forward

		else -- We're drawing the world model

			local ply = self:GetOwner()
			
			if !self.flameThrowerHand then
				self.flameThrowerHand = ply:LookupAttachment("anim_attachment_rh")
			end

			local handData = ply:GetAttachment(self.flameThrowerHand)

			ang = handData.Ang
			pos = handData.Pos
				+ ang:Forward() * 28
				+ ang:Right() * 0.3
				+ ang:Up() * 4.5

		end
	end

	if SERVER then -- Mainly used for positioning our fire balls

		pos = self:GetOwner():GetShootPos()
		ang = self:GetOwner():EyeAngles()
		pos = pos
			+ ang:Forward() * -50
			+ ang:Right() * 0
			+ ang:Up() * -20

	end

	return pos
end

function SWEP:ShootFire()
	if SERVER then
		local life = math.Rand(2, 4) * self.vFireLife
		local owner = self:GetOwner()

		if owner:IsNPC() then
			local npc = self:GetOwner()
			local tgt = npc:GetEnemy()
			local ctrpos = tgt:WorldSpaceCenter()
			
			npc:SetEyeTarget(ctrpos)
			local forward = self:GetOwner():EyeAngles():Forward()
			local pos = self:GetShootPosition() + forward * self.vFireSpawnDist
			local vel = forward * math.Rand(900, 1000) * self.vFireSpeed
			local feedCarry = math.Rand(3, 8) * self.vFireVolatility
			CreateVFireBall(life, feedCarry, pos, vel, owner)
		elseif owner:IsPlayer() then
			local forward = self:GetOwner():EyeAngles():Forward()
			local pos = self:GetShootPosition() + forward * self.vFireSpawnDist
			local vel = forward * math.Rand(900, 1000) * self.vFireSpeed
			local feedCarry = math.Rand(3, 8) * self.vFireVolatility
			CreateVFireBall(life, feedCarry, pos, vel, owner)
		end
	end
end

local BaseGameAmmoTypes = {
	"AR2",
	"AR2AltFire",
	"Pistol",
	"SMG1",
	"357",
	"XBowBolt",
	"Buckshot",
	"RPG_Round",
	"SMG1_Grenade",
	"Grenade",
	"slam",
	"AlyxGun",
	"SniperRound",
	"SniperPenetrateRound",
	"Thumper",
	"Gravity",
	"Battery",
	"GaussEnergy",
	"CombineCannon",
	"AirboatGun",
	"StriderMinigun",
	"HelicopterGun",
	"9mmRound",
	"MP5_Grenade",
	"Hornet",
	"StriderMinigunDirect",
	"CombineHeavyCannon",
}

function SWEP:SetupAttachments(att, slot, emptymag, initializing)
	if att == nil then initializing = true end
	local ammo = nil
	
	if emptymag == true && !self.IsBatteryBased then
		local atr = self:Clip1()
		local at = self.Primary.Ammo
		self:GetOwner():GiveAmmo(atr, at, false)
		self:SetLoadedAmmo(0)
	end
	
	if initializing == true && slot == "AmmunitionTypes" then
		local bandaid1 = {
			["drc_att_bprofile_generic"] = "drc_abp_generic",
			["drc_att_bprofile_buckshot"] = "drc_abp_buckshot",
			["drc_att_bprofile_explosive"] = "drc_abp_explosive",
		}
		for k,v in pairs(self.AttachmentTable.AmmunitionTypes) do
			if k != "BaseClass" then
				if bandaid1[v] then self.AttachmentTable.AmmunitionTypes[k] = bandaid1[v] end
			end
		end
	
		ammo = scripted_ents.GetStored(self.AttachmentTable.AmmunitionTypes[1])
		local ammotype = ammo.t.BulletTable.AmmoType
		local basegameammotype = ammo.t.BulletTable.FallbackBaseAmmoType
		if GetConVarNumber("sv_drc_forcebasegameammo") == 0 then
			if self.Primary.Ammo == "replaceme" then self.Primary.Ammo = ammotype end
			if self.PrimaryStats.OriginalAmmo == "replaceme" then self.PrimaryStats.OriginalAmmo = ammotype end
		else
			if !CTFK(BaseGameAmmoTypes, basegameammotype) then
				if self.Primary.Ammo == "replaceme" then self.Primary.Ammo = "Pistol" end
				if self.PrimaryStats.OriginalAmmo == "replaceme" then self.PrimaryStats.OriginalAmmo = "Pistol" end
			else
				if self.Primary.Ammo == "replaceme" then self.Primary.Ammo = basegameammotype end
				if self.PrimaryStats.OriginalAmmo == "replaceme" then self.PrimaryStats.OriginalAmmo = basegameammotype end
			end
		end
	elseif !initializing && slot == "AmmunitionTypes" then
		ammo = scripted_ents.GetStored(att)
		local ammotype = ammo.t.BulletTable.AmmoType
		local basegameammotype = ammo.t.BulletTable.FallbackBaseAmmoType
		if GetConVarNumber("sv_drc_forcebasegameammo") == 0 && !self.IsBatteryBased then
			self.Primary.Ammo = ammotype
		else
			if !CTFK(BaseGameAmmoTypes, basegameammotype) && !self.IsBatteryBased then
				self.Primary.Ammo = "Pistol"
			else
				self.Primary.Ammo = basegameammotype
			end
		end
		if !ammotype && !self.IsBatteryBased then self.Primary.Ammo = self.PrimaryStats.OriginalAmmo end
	end
	
		
	self.ActiveAttachments = {
		AmmunitionTypes = ammo,
	}
end

function SWEP:SetupDataTables()
--	self:SetNWInt("Heat", 0)
--	self.ChargeValue = 0)
	self:SetNWBool("Passive", false)
	self:SetNWBool("Inspecting", false)
	
	self.PrimaryStats = {
		Damage = self.Primary.Damage,
		Projectile = self.Primary.Projectile,
		ProjSpeed = self.Primary.ProjSpeed,
		ProjInheritVelocity = self.Primary.ProjInheritVelocity,
		IronRecoilMul = self.Primary.IronRecoilMul,
		Spread = self.Primary.Spread,
		SpreadDiv = self.Primary.SpreadDiv,
		Kick = self.Primary.Kick,
		KickHoriz = self.Primary.KickHoriz,
		RecoilUp = self.Primary.RecoilUp,
		RecoilDown = self.Primary.RecoilDown,
		RecoilHoriz = self.Primary.RecoilHoriz,
		MuzzleAngle = self.Primary.MuzzleAngle,
		Force = self.Primary.Force,
		OriginalAmmo = self.Primary.Ammo,
		Ammo = self.Primary.Ammo,
		Automatic = self.Primary.Automatic,
		CanFireUnderwater = self.Primary.CanFireUnderwater,
		RPM = self.Primary.RPM,
		ClipSize = self.Primary.ClipSize,
		DefaultClip = self.Primary.DefaultClip,
		DropMagReload = self.Primary.DropMagReload,
		APS = self.Primary.APS,
		HealthPerShot = self.Primary.HealthPerShot,
		ArmourPerShot = self.Primary.ArmourPerShot,
		Tracer = self.Primary.Tracer,
		TracerEffect = self.Primary.TracerEffect,
		EmptySound = self.Primary.EmptySound,
		SoundIsLooped = self.Primary.SoundIsLooped,
		Sound = self.Primary.Sound,
		StartSound = self.Primary.StartSound,
		EndSound = self.Primary.EndSound,
		NPCSound = self.Primary.NPCSound,
		DistSound = self.Primary.DistSound,
		SoundDistance = self.Primary.SoundDistance,
	}
	
	self.SecondaryStats = {
		Damage = self.Secondary.Damage,
		Projectile = self.Secondary.Projectile,
		ProjSpeed = self.Secondary.ProjSpeed,
		ProjInheritVelocity = self.Secondary.ProjInheritVelocity,
		IronRecoilMul = self.Secondary.IronRecoilMul,
		Spread = self.Secondary.Spread,
		SpreadDiv = self.Secondary.SpreadDiv,
		Kick = self.Secondary.Kick,
		KickHoriz = self.Secondary.KickHoriz,
		RecoilUp = self.Secondary.RecoilUp,
		RecoilDown = self.Secondary.RecoilDown,
		RecoilHoriz = self.Secondary.RecoilHoriz,
		MuzzleAngle = self.Secondary.MuzzleAngle,
		Force = self.Secondary.Force,
		Ammo = self.Secondary.Ammo,
		Automatic = self.Secondary.Automatic,
		CanFireUnderwater = self.Secondary.CanFireUnderwater,
		RPM = self.Secondary.RPM,
		ClipSize = self.Secondary.ClipSize,
		DefaultClip = self.Secondary.DefaultClip,
		DropMagReload = self.Secondary.DropMagReload,
		APS = self.Secondary.APS,
		HealthPerShot = self.Secondary.HealthPerShot,
		ArmourPerShot = self.Secondary.ArmourPerShot,
		Tracer = self.Secondary.Tracer,
		TracerEffect = self.Secondary.TracerEffect,
		EmptySound = self.Secondary.EmptySound,
		SoundIsLooped = self.Secondary.SoundIsLooped,
		Sound = self.Secondary.Sound,
		StartSound = self.Secondary.StartSound,
		EndSound = self.Secondary.EndSound,
		NPCSound = self.Secondary.NPCSound,
		DistSound = self.Secondary.DistSound,
		SoundDistance = self.Secondary.SoundDistance,
	}
	
	self.OCStats = {
		Damage = self.OCDamage,
		Projectile = self.OCProjectile,
		ProjSpeed = self.OCProjSpeed,
		ProjInheritVelocity = self.OCProjInheritVelocity,
		IronRecoilMul = self.OCIronRecoilMul,
		Spread = self.OCSpread,
		SpreadDiv = self.OCSpreadDiv,
		Kick = self.OCKick,
		KickHoriz = self.OCKickHoriz,
		RecoilUp = self.OCRecoilUp,
		RecoilDown = self.OCRecoilDown,
		RecoilHoriz = self.OCRecoilHoriz,
		MuzzleAngle = self.OCMuzzleAngle,
		Force = self.OCForce,
		Ammo = self.OCAmmo,
		Automatic = self.OCAutomatic,
		CanFireUnderwater = self.OCCanFireUnderwater,
		RPM = self.OCRPM,
		ClipSize = self.OCClipSize,
		DefaultClip = self.OCDefaultClip,
		DropMagReload = self.OCDropMagReload,
		APS = self.OCAPS,
		HealthPerShot = self.OCHealthPerShot,
		ArmourPerShot = self.OCArmourPerShot,
		Tracer = self.OCTracer,
		TracerEffect = self.OCTracerEffect,
		EmptySound = self.OCEmptySound,
		SoundIsLooped = self.OCSoundIsLooped,
		Sound = self.OCSound,
		StartSound = self.OCStartSound,
		EndSound = self.OCEndSound,
		NPCSound = self.OCNPCSound,
		DistSound = self.OCDistSound,
		SoundDistance = self.OCSoundDistance
	}
	
	self.InfoStats = {
		Name = self.PrintName,
		InfoName = self.InfoName,
		Manufacturer = self.Manufacturer,
		Description = self.InfoDescription
	}
	
	if self.IsBatteryBased == nil or self.IsBatteryBased == false then return end
	self.BatteryStats = {
		HPS = self.HPS,
		OCHPS = self.OCHPS,
		OverHeatFinishPercent = self.OverHeatFinishPercent,
		DisperseHeatPassively = self.DisperseHeatPassively,
		HeatLossInterval = self.HeatLossInterval,
		HeatLossPerInterval = self.HeatLossPerInterval,
		DoOverheatDamage = self.DoOverheatDamage,
		OverheatDamagePerInt = self.OverheatDamagePerInt,
		OverheatHoldType = self.OverheatHoldType,
		OverheatStrength = self.OverheatStrength,
		VentingHoldType = self.VentingHoldType,
		VentingStrength = self.VentingStrength,
		CanOverheat = self.CanOverheat,
		CanVent = self.CanVent,
		LowerRPMWithHeat = self.LowerRPMWithHeat,
		HeatRPMmin = self.HeatRPMmin,
		AlterTheshold = self.HeatRPMAlterThreshold,
		AlterThesholdMax = self.HeatRPMAlterThresholdMax,
		DoOverheatAnimation = self.DoOverheatAnimation,
		DoVentingAnimation = self.DoVentingAnimation,
		DoOverheatSound = self.DoOverheatSound,
		DoVentingSound = self.DoVentingSound,
		OverheatSound = self.OverheatSound,
		VentingSound = self.VentingSound,
		VentingStartSound = self.VentingStartSound,
		VentingStopSound = self.VentingStopSound,
		BatteryConsumePerShot = self.BatteryConsumePerShot,
		OCBatteryConsumePerShot = self.OCBatteryConsumePerShot
	}
	
	if self.BatteryConsumPerShot then self.BatteryStats.BatteryConsumePerShot = self.BatteryConsumPerShot end
end

function SWEP:GetNPCBurstSettings()
	local ply = self:GetOwner()
	if self.IsMelee then return end
	if self.NPCBursting == true then return end
	
	if ply:IsPlayer() then return end
	
	local burst = self.NPCBurstShots or 1
	local rpm = self.Primary.RPM
	local fm = self:GetNWString("FireMode")
	if fm == "" then self:InitialFireMode() end -- Sometimes NPCs spawning with guns can break stuff like this. Don't ask me why, I don't know either.
	
	if (ply:IsNPC() or ply:IsNextBot()) && self.FireModes_CanBurst == true then
		self:SetNWString("FireMode", "Burst")
	end
	
	local mini, maxi, delay = nil, nil, nil

	if fm == "Semi" then
		mini = 1
		maxi = 1
		delay = (60 / rpm)
	elseif fm == "Auto" then
		mini = math.Rand(1, burst)
		maxi = burst * 3
		delay = (60 / rpm)
		if self.Primary.Ammo == "ammo_drc_battery" then
			mini = mini * self.BatteryConsumePerShot
			maxi = (maxi * self.BatteryConsumePerShot / 5)
		end
	elseif fm == "Burst" then
		mini = self.FireModes_BurstShots
		maxi = self.FireModes_BurstShots
		delay = (60 / rpm)
	elseif self.LoadAfterShot == true then
		mini = 1
		maxi = 1
		delay = (self.Primary.Spread / self.Primary.SpreadDiv) * self.Primary.Kick
	end
	
	local burstlength = (math.Rand(mini, maxi))
	if ply.DraconicNPC then
		if ply:DraconicNPC() == true then
			local div = 1
			if self.Primary.Ammo != "ammo_drc_battery" then div = 25 end
			local mul = 0.25 * GetConVar("skill"):GetFloat()
			mini = mini * 15 * mul / div
			maxi = maxi * 50 * mul / div
			burstlength = burstlength * 100 * mul / div
		end
	end
	return mini, maxi, delay, burstlength
end

function SWEP:GetNPCBulletSpread()
	return math.Rand(0, 3)
end

function SWEP:GetIronSights()
	if self.SightsDown == true && self.CanTFALean == true then return true else return false end
end

function SWEP:DrawCustom2DScopeElements()
end

function SWEP:DrawCustomCrosshairElements()
end

function SWEP:DrawHUD()
	if not CLIENT then return end
	if GetConVar("cl_drawhud"):GetFloat() == 0 then return end
	self:DrawCustomCrosshairElements()
	--if not self:GetNWBool("ironsights") == true && self.Secondary.Scoped == true then return end
	if not self.SightsDown == true && self.Secondary.Scoped == true then return end
	self:DrawCustom2DScopeElements()
end

function SWEP:PreDrawViewModel(vm, wep, ply)
	if ply:GetNWBool("Interacting") == true then return true end
--	self:DoCustomVMDraw(vm, wep, ply)
	if game.SinglePlayer() then return end -- Find the singleplayer compatible version inside of Think() because why.
	
	local ammo = wep:Clip1()
	local slide = self.PistolSlide
	local charge = self:GetCharge()
	local heat = self:GetHeat()
	local health = ply:Health()
	
	local seq, cycle = vm:GetSequence(), vm:GetCycle()
	
	if ply != LocalPlayer() then return end

	self.AmmoCL = Lerp(FrameTime() * 25, self.AmmoCL or ammo, ammo)
	self.ChargeCL = Lerp(FrameTime() * 9, self.ChargeCL or charge, charge)
	self.HeatCL = Lerp(FrameTime() * 9, self.HeatCL or heat, heat)
	self.HealthCL = Lerp(FrameTime() * 9, self.HealthCL or health, health)
	
	if slide <= 0 then
		self.EmptyMagCL = Lerp(FrameTime() * 50, self.EmptyMagCL or slide, 0)
	else
		self.EmptyMagCL = Lerp(FrameTime() * 50, self.EmptyMagCL or slide, 1)
	end
	
	if self.Primary.Ammo != nil && vm:GetPoseParameter("drc_ammo") != nil then
		vm:SetPoseParameter("drc_ammo", self.AmmoCL / self.Primary.ClipSize)
	end
	
	if self.Primary.Ammo != nil && vm:GetPoseParameter("drc_emptymag") != nil then
		vm:SetPoseParameter("drc_emptymag", self.EmptyMagCL)
	end
	
	if self.Primary.Ammo == "ammo_drc_battery" && vm:GetPoseParameter("drc_heat") != nil then
		vm:SetPoseParameter("drc_heat", self.HeatCL / 100)
	end
	
	if self.Primary.Ammo == "ammo_drc_battery" && vm:GetPoseParameter("drc_battery") != nil then
		vm:SetPoseParameter("drc_battery", self.AmmoCL / 100)
	end
	
	if vm:GetPoseParameter("drc_health") != nil then
		vm:SetPoseParameter("drc_health", (self.HealthCL / ply:GetMaxHealth()) / 100)
	end
	
	if vm:GetPoseParameter("drc_charge") != nil then			
		vm:SetPoseParameter("drc_charge", self.ChargeCL / 100)
	end

	return false
end

function SWEP:OnReloaded()
	if SERVER then self:CallOnClient("OnReloaded") end
	local ply = self:GetOwner()
	local class = self:GetClass()
	local ammostat = weapons.GetStored(class).Primary.Ammo

	self.VARSightPos = self.IronSightsPos
	self.VARSightAng = self.IronSightsAng
	
	self:DoPassiveHoldtype()
	if self.IsBatteryBased == true then
		self.Primary.Ammo = "ammo_drc_battery"
	elseif !self.IsBatteryBased && !self.IsMelee then
		if ammostat == nil then
			if GetConVarNumber("sv_drc_forcebasegameammo") == 0 then
				self.Primary.Ammo = self:GetAttachmentValue("Ammunition", "AmmoType")
			else
				self.Primary.Ammo = self:GetAttachmentValue("Ammunition", "BaseGameAmmoType")
			end
		end
	end
end

function SWEP:OnRestore()
	self:Initialize()
	timer.Simple(0.1, function() self:Deploy() end)
end

function SWEP:ShootEffects()
end

-- VJ Base Compatibility
function SWEP:SetupVJSupport()
	local ply = self:GetOwner()
	self.WorldModel_UseCustomPosition = true -- yeah no, I'll worry about this another time.
	self.IsVJBaseWeapon = true -- This is just to shut up the error which says it "needs" a VJ base weapon to work properly.

	if self.IsMelee == true then
		self.IsMeleeWeapon = true
		self.MeleeWeaponDistance = self.Primary.Range * 1
	--	if self:GetHoldType() == "knife" then self:SetHoldType("melee") end
	else
		self.IsMeleeWeapon = false
	end

	self.NPC_NextPrimaryFire = 0.1
	self.NPC_StandingOnly = false
	self.NPC_FiringDistanceScale = 1
	self.NPC_BeforeFireSound = {}
	self.NPC_BeforeFireSoundLevel = 70
	self.NPC_BeforeFireSoundPitch = VJ_Set(90, 100)
	
	hook.Add("Think", self, self.NPC_ServerNextFire)
end

-- SCK
if CLIENT or game.SinglePlayer() then
	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		if !IsValid(self:GetOwner()) then return end

		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)
		if (!self.vRenderOrder) then
			
			// we build a render order because sprites need to be drawn after models
			self.vRenderOrder = {}
			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end
		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then
				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()
			end
			
		end
		
	end
	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		
		local ply = self:GetOwner()
		local ent = self:EntIndex()
		
		if self:EntIndex() != ent then return end
		
		if ply:IsPlayer() or ply:IsNPC() or ply:IsNextBot() then
			local ammo = self:Clip1()
			local slide = self:Clip1()
			local charge = self:GetCharge()
			local heat = self:GetHeat()
			local health = ply:Health()

			self.AmmoCL_TP = Lerp(0.25, self.AmmoCL_TP or ammo, ammo)
			self.ChargeCL_TP = Lerp(0.25, self.ChargeCL_TP or charge, charge)
			self.HeatCL_TP = Lerp(0.25, self.HeatCL_TP or heat, heat)
			self.HealthCL_TP = Lerp(0.25, self.HealthCL_TP or health, health)
			
			if slide <= 0 then
				self.EmptyMagCL_TP = Lerp(FrameTime() * 50, self.EmptyMagCL_TP or slide, 0)
			else
				self.EmptyMagCL_TP = Lerp(FrameTime() * 50, self.EmptyMagCL_TP or slide, 1)
			end
			
			if self.Primary.Ammo != nil && self:GetPoseParameter("drc_ammo") != nil then
				self:SetPoseParameter("drc_ammo", self.AmmoCL_TP / self.Primary.ClipSize)
			end
			
			if self.Primary.Ammo != nil && self:GetPoseParameter("drc_emptymag") != nil then
				self:SetPoseParameter("drc_emptymag", self.EmptyMagCL_TP)
			end
			
			if self.Primary.Ammo == "ammo_drc_battery" && self:GetPoseParameter("drc_heat") != nil then
				self:SetPoseParameter("drc_heat", self.HeatCL_TP / 100)
			end
			
			if self.Primary.Ammo == "ammo_drc_battery" && self:GetPoseParameter("drc_battery") != nil then
				self:SetPoseParameter("drc_battery", self.AmmoCL_TP / 100)
			end
			
			if self:GetPoseParameter("drc_health") != nil then
				self:SetPoseParameter("drc_health", (self.HealthCL_TP / ply:GetMaxHealth()) / 100)
			end
			
			if self:GetPoseParameter("drc_charge") != nil then			
				self:SetPoseParameter("drc_charge", self.ChargeCL_TP / 100)
			end
		end
			
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then
			self.wRenderOrder = {}
			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end
		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			// when the weapon is dropped
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then
				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()
			end
			
		end
		
	end
	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			// Technically, if there exists an element with the same name as a bone
			// you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)
			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r // Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end
	function SWEP:CreateModels( tab )
		if (!tab) then return end
		// Create the clientside models here because Garry says we can't do it in the render hook
		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				// make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			// !! WORKAROUND !! //
			// We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			// !! ----------- !! //
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				// !! ----------- !! //
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end

	/**************************
		Global utility code
	**************************/

	// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
	// Does not copy entities of course, only copies their reference.
	// WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
	function table.FullCopy( tab )
		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end

function SWEP:HasViewModel()
	if !IsValid(self) then return end
	if self.ViewModel == "" or self.ViewModel == nil then return false else return true end
end

function SWEP:Precache()	
end

function SWEP:DoCustomPrimary() -- called regardless of whether or not CanPrimaryAttack passes.
end

function SWEP:DoCustomSecondary() -- called regardless of whether or not CanSecondaryAttack passes, even if secondary is disabled.
end

function SWEP:DoCustomVMDraw(vm, wpn, ply) -- Custom draw hook for coded model stuff
end

-- ADDON COMPATIBILITY ZONE
-- You really should never call any of these functions from within a SWEP, as they exist merely to make the weapon base compatible with othr addons!

function SWEP:ClearSchedule()
	self:GetOwner():ClearSchedule()
end

function SWEP:ShootBullets() -- Iv04 Nextbot "taunt enemy corpse with weapon" compat
	self:DoShoot("Primary")
end

function SWEP:FiringEffects() -- Iv04 Nextbot "taunt enemy corpse with weapon" compat
	self:DoEffects("Primary")
end

function SWEP:NZMaxAmmo() -- nZombies Ammo
    local ammo_type = self:GetPrimaryAmmoType() or self.Primary.Ammo

    if SERVER then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
    end
end

function SWEP:OnPaP() -- nZombies Pack-a-Punch
	local PAP = self.nZPAP
	local AA = self.ActiveAttachments	
	local BT = AA.Ammunition.t.BulletTable

	self.Ispackapunched = 1
	
	if PAP[4] == false then
		self:SetupAttachments(PAP[2], "AmmunitionTypes", false, false)
	else
		self:SetupAttachments(PAP[2], "AmmunitionTypes", false, false)
	end
	
	self.PrintName = PAP[1]
	if PAP[4] != nil then self.Primary.MaxAmmo = self.Primary.MaxAmmo * PAP[4] end
	
	if PAP[5] != nil then self.ViewModel = PAP[5] end
	if PAP[6] != nil then self.WorldModel = PAP[6] end
	if PAP[7] != nil then self.WorldModel = PAP[7] end
	return true
end