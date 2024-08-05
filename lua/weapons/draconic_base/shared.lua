AddCSLuaFile()
--[[     I M P O R T A N T

Please go to the wiki for this, and don't just rip settings from the base.
http://vuthakral.com/draconic/

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

SWEP.HoldType			= "default"
SWEP.CrouchHoldType		= nil
SWEP.Contact			= "discord.gg/feThY5n8vH\nsteam.vuthakral.com"
SWEP.Purpose			= ""
SWEP.Instructions		= ""
SWEP.WepSelectIcon 		= "vgui/entities/drc_default"
SWEP.IgnoreVersioning	= false

-- SPAWNMENU
SWEP.Category			= "Draconic"
SWEP.Subcategory		= nil
SWEP.PrintName			= "Draconic Base"
SWEP.Author				= "Vuthakral"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
SWEP.NPCSpawnable		= true

-- INSPECT MENU
SWEP.InfoName			= nil
SWEP.Manufacturer		= nil
SWEP.InfoDescription	= nil

-- INVENTORY BEHAVIOUR
SWEP.Slot				= 0
SWEP.SlotPos			= 1

SWEP.CanBeSwapped = true
SWEP.PickupOnly = false
SWEP.DoNotDrop	= false

SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

-- VM/HUD STUFF
SWEP.CrosshairColor			= Color(255, 255, 255, 255)
SWEP.CrosshairShadow		= false
SWEP.CrosshairStatic		= nil
SWEP.CrosshairDynamic		= nil
SWEP.CrosshairCorrectX		= 1
SWEP.CrosshairCorrectY		= 1
SWEP.CrosshairSizeMul		= 1
SWEP.CrosshairNoIronFade 	= false
SWEP.CrosshairFOVPower		= 1
SWEP.Crosshair 				= nil

SWEP.ViewModelFOV		= 54
SWEP.ViewModelFlip		= false
SWEP.DrawAmmo			= true

SWEP.UseHands			= true
SWEP.DoesPassiveSprint	= false
SWEP.ViewModel			= ""
SWEP.WorldModel			= ""
SWEP.InspectDelay 		= 0.5

-- OFFSETS
SWEP.VMPos 				= Vector(0, 0, 0)
SWEP.VMAng 				= Vector(0, 0, 0)
SWEP.VMPosCrouch 		= nil
SWEP.VMAngCrouch 		= nil
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
--SWEP.SprintPos 			= Vector(5, 0, 3)
--SWEP.SprintAng 			= Vector(-15, 25, 0)

-- VIEWMODEL SWAY
SWEP.SS 				= 1
SWEP.BS 				= 1
SWEP.NearWallPower		= 1
SWEP.RollingPower		= 1
SWEP.PerspectivePower	= 1
SWEP.Sway_IsShouldered	= nil
SWEP.Sway_OffsetPowerPos= nil
SWEP.Sway_OffsetPowerAng= Vector(1,1,1)

-- CAMERA EFFECTS
SWEP.CameraStabilityIdle	= 1
SWEP.CameraStabilityMove	= 1
SWEP.CameraStabilityReload	= 0.5
SWEP.CameraStabilityInspect	= 0.25
SWEP.CameraStabilityMelee	= 0.5

SWEP.CameraAngleMulIdle		= Vector(0, 0, 0)
SWEP.CameraAngleMulMove		= Vector(0, 0, 0)
SWEP.CameraAngleMulReload	= Vector(1, 1, 1)
SWEP.CameraAngleMulInspect	= Vector(1, 1, 1)
SWEP.CameraAngleMulMelee	= Vector(1, 1, 1)
SWEP.CameraAngleMulFiring	= nil -- inherits from Idle unless overridden

SWEP.DoForwardBlur 		= false
SWEP.DoRotationalBlur 	= false
SWEP.ForwardGainMul		= 1
SWEP.ForwardDecayMul	= 1
SWEP.RotationalGainMul	= 1
SWEP.RotationalDecayMul	= 1

SWEP.Thirdperson = false
SWEP.ThirdpersonForceFreelook = false

SWEP.FireModes_SwitchSound = "Weapon_AR2.Empty"

-- AIM ASSIST (wip, only used for scripted projectiles currently)
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
SWEP.SpeedSprintStand = {
	nil, nil, nil,
	nil, nil, nil,
	nil, nil, nil
}

SWEP.SpeedSprintCrouch = {
	nil, nil, nil,
	nil, nil, nil,
	nil, nil, nil
}

SWEP.SpeedRunStand = {
	nil, nil, nil,
	nil, nil, nil,
	nil, nil, nil
}

SWEP.SpeedRunCrouch = {
	nil, nil, nil,
	nil, nil, nil,
	nil, nil, nil
}

SWEP.SpeedWalkStand = {
	nil, nil, nil,
	nil, nil, nil,
	nil, nil, nil
}

SWEP.SpeedWalkCrouch = {
	nil, nil, nil,
	nil, nil, nil,
	nil, nil, nil
}

SWEP.JumpHeightsStand = {
	nil, nil, nil,
	nil, nil, nil,
	nil, nil, nil
}

SWEP.JumpHeightsCrouch = {
	nil, nil, nil,
	nil, nil, nil,
	nil, nil, nil
}

SWEP.JumpHeightsStandSprint = {
	nil, nil, nil,
	nil, nil, nil,
	nil, nil, nil
}

SWEP.JumpHeightsCrouchSprint = {
	nil, nil, nil,
	nil, nil, nil,
	nil, nil, nil
}

-- MISC
SWEP.TauntCooldown 			= 1
SWEP.HealthRegen 			= false
SWEP.HealAmount				= 1
SWEP.HealInterval			= 1
SWEP.WeaponIdleLoopSound 	= nil
SWEP.IdleLoopSoundConstant 	= false

SWEP.IntegratedLight_Enabled 	= false
SWEP.IntegratedLight_FOV 		= 60
SWEP.IntegratedLight_MaxDist	= 800
SWEP.IntegratedLight_DistScale	= 0
SWEP.IntegratedLight_Texture 	= "effects/flashlight001"
SWEP.IntegratedLight_Colour 	= Color(255, 255, 255, 1)
SWEP.IntegratedLight_OnSound	= "Player.FlashlightOn"
SWEP.IntegratedLight_OffSound	= "Player.FlashlightOff"
SWEP.IntegratedLight_ToggleFrac	= 0.5
SWEP.IntegratedLight_UseHitPos	= false
SWEP.IntegratedLight_DoVolume	= false
SWEP.IntegratedLight_VolLength	= 60
SWEP.IntegratedLight_VolPower	= 0.333
SWEP.IntegratedLight_VolMaterial= "sprites/glow04_noz"

SWEP.KeepUpright		= false
SWEP.DeploySpeed		= 1
SWEP.Weight				= 1

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

SWEP.WeaponSkinDefaultMat 			= nil
SWEP.WeaponSkinSpecialMats 			= nil
SWEP.WeaponSkinDisallowUniversals 	= false

SWEP.VElements = {}
SWEP.WElements = {}

-- ADDON COMPATIBILITY
SWEP.CanStore	= true
SWEP.CanTFALean = true
SWEP.DManip_AllowFL = true
SWEP.vFireLife 			= 2
SWEP.vFireVolatility 	= 0.15
SWEP.vFireSpeed 		= 1
SWEP.vFireSpawnDist 	= 30
SWEP.vFireStopSound 	= Sound("draconic.vFireStopGeneric")
SWEP.Primary.isvFire 	= false
SWEP.Secondary.isvFire 	= false

-- TTT
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

-- nZombies
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
SWEP.Draconic 				= true
SWEP.LockoutTime			= CurTime()
SWEP.IdleTimer 				= CurTime()
SWEP.PreventIdleTimer 		= CurTime()
SWEP.IsTaunting 			= 0
SWEP.IsOverheated 			= false
SWEP.SightsDown 			= false
SWEP.BloomValue 			= 0
SWEP.PrevBS 				= 0
SWEP.RealTime 				= 0
SWEP.VariablePos 			= Vector(0, 0, 0)
SWEP.CRPo 					= Vector(0, 0, 0)
SWEP.PRPos 					= Vector(0, 0, 0)
SWEP.SPRPos 				= Vector(0, 0, 0)
SWEP.IRPos 					= Vector(0, 0, 0)
SWEP.VARPos 				= Vector(0, 0, 0)
SWEP.VariableAng 			= Vector(0, 0, 0)
SWEP.CRPo 					= Vector(0, 0, 0)
SWEP.PRAng 					= Vector(0, 0, 0)
SWEP.SPRAng 				= Vector(0, 0, 0)
SWEP.IRAng 					= Vector(0, 0, 0)
SWEP.VARAng 				= Vector(0, 0, 0)
SWEP.Sound 					= Sound("")
SWEP.DistSound 				= Sound("")
SWEP.Passive 				= false
SWEP.Inspecting 			= false
SWEP.Idle 					= 0
SWEP.PlayingLoadAnimation	= false
SWEP.PlayingShootAnimation	= false
SWEP.Loading 				= false
SWEP.ManuallyReloading 		= false
SWEP.PistolSlide 			= 1
SWEP.NPCBursting 			= false
SWEP.NPCBurstTime			= 0
SWEP.NPCCharging 			= false
SWEP.DualSettings 			= {}
SWEP.SightSwapCD 			= false
SWEP.SightsSwapCD 			= 0
SWEP.LastFireTime 			= 0
SWEP.LastFireAnimTime 		= 0
SWEP.PassiveHealing			= ""
SWEP.AmmoRegen				= ""
SWEP.CurPos					= Vector(0, 0, 0)
SWEP.CurAng					= Vector(0, 0, 0)
SWEP.FireMode				= "none"
SWEP.OwnerActivity 			= "standidle"
SWEP.IsDoingMelee 			= false
SWEP.BurstQueue = {}
SWEP.MeleeQueue = {}
SWEP.DynOffsetPos = Vector()
SWEP.DynOffsetAng = Vector()
SWEP.WeaponSkinSubMaterials = {}
SWEP.WeaponSkinProxyMaterials = {}

function SWEP:DoDrawCrosshair( x, y )
	return true
end

function SWEP:DrawWorldModelTranslucent()
	self:DrawModel()
end

function SWEP:InitialFireMode()
	if self.Primary.Automatic == false then
		self:SetNWString("FireMode", "Semi")
		self:SetNWInt("CurFireMode", 1)
	elseif self.Primary.Automatic == true && self.FireModes_CanAuto == true then
		self:SetNWString("FireMode", "Auto")
		self:SetNWInt("CurFireMode", 2)
	elseif self.Primary.Automatic == true && self.FireModes_CanBurst == true && self.FireModes_CanAuto == false then
		self:SetNWString("FireMode", "Burst")
		self:SetNWInt("CurFireMode", 3)
		self.Primary.Automatic = false
	elseif self.Primary.Automatic == true && self.FireModes_CanBurst == false && self.FireModes_CanAuto == false && self.FireModes_CanSemi == true then
		self:SetNWString("FireMode", "Semi")
		self:SetNWInt("CurFireMode", 1)
		self.Primary.Automatic = false
	else 
		self:SetNWString("FireMode", "Semi")
		self:SetNWInt("CurFireMode", 1)
	end
	
	if self.FireModes_CanBurst == true && self.FireModes_CanAuto == false && self.FireModes_CanSemi == false then
		self:SetNWString("FireMode", "Burst")
		self:SetNWInt("CurFireMode", 3)
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
	
	self.IdleTimer = CurTime() + 5
	
	self.Readied = false
	self:SetHoldType(self.HoldType)
	self:SetNWBool("Passive", false)
	self:SetNWBool("Inspecting", false)
	self:CreateIdleSound()
	self.VARSightPos = self.IronSightsPos
	self.VARSightAng = self.IronSightsAng
	self.LastMeleeImpactTime = 0
	
	if self.Sway_IsShouldered == nil then self.Sway_IsShouldered = DRC.HoldTypes[string.lower(self.HoldType)].shouldered end
	if self.Sway_OffsetPowerPos == nil then self.Sway_OffsetPowerPos = Vector(self.SS, 1, 1) end
	
	if self.KeepUpright == true then
		self:AddCallback( "PhysicsCollide", function( ent, newangle )
			local vel = ent:GetVelocity()
			ent:SetAngles(Angle())
		end )
	end
	
	self.DRCVersion = DRC:GetVersion()
	if self.Primary.NumShots or self.OCNumShots then self.DRCVersion = 1 end
	
	if !self.IsMelee then
		if self.MeleeHitSoundWorld != nil then
			self.DRCVersion = 1.01
		end
	else
		if self.Primary.HitSoundEnt != nil or self.Secondary.HitSoundEnt != nil or self.Primary.LungeHitSoundEnt != nil then
			self.DRCVersion = 1.01
		end
	end
	
	if self.IgnoreVersioning == false then
		if ply:IsPlayer() && CLIENT then
			if self.DRCVersion < DRC:GetVersion() then
				DRC:MismatchWarn(ply, self)
			end
		end
	end
	
	-- Legacy melee base -> melee base rewrite compatibility
	if self.LungeHoldType then self.Primary.LungeHoldType = self.LungeHoldType end
	if self.LungeHoldTypeCrouch then self.Primary.LungeHoldTypeCrouch = self.LungeHoldTypeCrouch end
	
	-- 1.0 -> 1.01 sound to soundtable compatibility
	if !self.IsMelee && !self.Primary.SoundTable then
		self.Primary.SoundTable = {
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
			["Envs"] = {},
			["NearMiss"] = "Bullets.DefaultNearmiss"
		}
	end
	
	if !self.Primary.EmptySound then
		self.Primary.EmptySound = DRC.HoldTypes[string.lower(self.HoldType)].drcsounds.dryfire
	end
	if !self.Secondary.EmptySound then
		self.Secondary.EmptySound = DRC.HoldTypes[string.lower(self.HoldType)].drcsounds.dryfire
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
	
	-- IV04 Nextbot compatiblity, DO NOT TOUCH OR USE.
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

	-- Fix playback rate if swapped-from weapon alters playback rate.
	if ply:IsPlayer() then
		local vm = ply:GetViewModel()
		if not vm:IsValid() then return end
		vm:SetPlaybackRate(1)
	end
	
	-- VJ NPC Compatibility
	if (ply.IsVJBaseSNPC == true or ply.IsVJBaseSNPC_Human == true) then
		if ply.IsVJBaseSNPC != nil then
			self:SetupVJSupport()
		end
	end
	
	-- Allow custom reload gestures while supporting the old system
	if self.Primary.ReloadAct == nil && !self.IsMelee then
		if self.Primary.ReloadHoldType == nil then
			self.Primary.ReloadAct = DRC:GetHoldTypeAnim(string.lower(self:GetHoldType()), "reload", false)
		else
			self.Primary.ReloadAct = DRC:GetHoldTypeAnim(string.lower(self.Primary.ReloadHoldType), "reload", false)
		end
	end
	
	-- Prime HUD compatibility
	if !self.LogBook && self.InfoDescription != nil then
		self.LogBook = {
			["Description"] = self.InfoDescription
		}
	end
	
	-- Fallback to set up thirdperson melee acts if one isn't defined by a weapon author
	if self.IsMelee == true then
		if self.Primary.MeleeAct == nil then
			local ht = self.Primary.HoldType
			self.Primary.MeleeAct = DRC:GetHoldTypeAnim(ht, "attack", false)
		end
		if self.Primary.MeleeActCrouch == nil then
			local ht = self.Primary.HoldTypeCrouch
			self.Primary.MeleeActCrouch = DRC:GetHoldTypeAnim(ht, "attack", false)
		end
		if self.Secondary.MeleeAct == nil then
			local ht = self.Secondary.HoldType
			self.Secondary.MeleeAct = DRC:GetHoldTypeAnim(ht, "attack", false)
		end
		if self.Secondary.MeleeActCrouch == nil then
			local ht = self.Secondary.HoldTypeCrouch
			self.Secondary.MeleeActCrouch = DRC:GetHoldTypeAnim(ht, "attack", false)
		end
		if self.Primary.LungeMeleeAct == nil then
			local ht = self.Primary.LungeHoldType
			self.Primary.LungeHoldType = DRC:GetHoldTypeAnim(ht, "attack", false)
		end
		if self.Primary.LungeMeleeActCrouch == nil then
			local ht = self.Primary.LungeHoldTypeCrouch
			self.Primary.LungeHoldTypeCrouch = DRC:GetHoldTypeAnim(ht, "attack", false)
		end
	else
		if self.Primary.MeleeActTP == nil then
			local ht = self.HoldType
			self.Primary.MeleeActTP = DRC:GetHoldTypeAnim(ht, "melee", false)
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
	
	if !self.IsMelee then self:InitialFireMode() end
	
	if self.WeaponSkinDefaultMat != nil then
		if !istable(self.WeaponSkinDefaultMat) then self.WeaponSkinDefaultMat = {self.WeaponSkinDefaultMat} end
		local mats = self:GetMaterials()
		
		for k,v in pairs(self.WeaponSkinDefaultMat) do
			local id = table.KeyFromValue(mats, v)
			self.WeaponSkinSubMaterials[id] = v
			self.WeaponSkinProxyMaterials[id] = Material(v)
		end
	end
	
	self:GetIdealSightFOV()
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

function SWEP:Think()
	if game.SinglePlayer() then self:CallOnClient("Think") end
	local ply = self:GetOwner()
	if !IsValid(ply) or DRC:Health(ply) < 0.01 then return end
	local ct = CurTime()
	
	self:DoCustomThink()
	self:ManageAnims(ply, ct)
	if self.EnableHeat == true then self:DisperseHeat() end
	
	if ct > self.LockoutTime then self.Idle = 1 else self.Idle = 0 end
	
	local primcharge = self.Primary.UsesCharge == true
	local seccharge = self.Secondary.UsesCharge == true
	local loaded = self:GetLoadedAmmo() > 0
	
	if CLIENT && ply:IsPlayer() then
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
	
	local overheated = self:GetNWBool("Overheated") == true
	local passive = self:GetNWBool("Passive") == true
	
	self:ManageSights(ply, ct)
	self:ManageCharge(ply, primcharge, seccharge, loaded, primcharge, seccharge)
	self:ManageLoopingSounds(ply, ct, passive, overheated, loaded, primcharge, seccharge)
	
	if CLIENT then
		if ply != LocalPlayer() then
			local b = self:GetNWBool("IntegratedLightState")
			if self.IntegratedLight_DoVolume == true && b == true then
				local att = self:LookupAttachment("muzzle")
				local attinfo = self:GetAttachment(att)
				local col = Color(self.IntegratedLight_Colour.r, self.IntegratedLight_Colour.g, self.IntegratedLight_Colour.b, self.IntegratedLight_Colour.a * 2)
				DRC:DLight(self, attinfo.Pos + attinfo.Ang:Forward() * self.IntegratedLight_VolLength*0.5, col, self.IntegratedLight_Colour.a * 50, 5, false, 1, 0)
				if !IsValid(self.FlashlightVolume) then
					local att = self:LookupAttachment("muzzle")
					local attinfo = self:GetAttachment(att)
					local p1, p2 = attinfo.Pos, DRC:TraceDir(attinfo.Pos, attinfo.Ang, self.IntegratedLight_MaxDist)
					local frac = Lerp(1-p2.Fraction * self.IntegratedLight_DistScale, 0, self.IntegratedLight_FOV)
					local volcol = Color(self.IntegratedLight_Colour.r, self.IntegratedLight_Colour.g, self.IntegratedLight_Colour.b, self.IntegratedLight_VolPower)
					self.FlashlightVolume = DRC:LightVolume(self, "muzzle", volcol, self.IntegratedLight_VolLength, frac*0.005, 25, nil, self.IntegratedLight_VolMaterial)
				end
			elseif self.IntegratedLight_DoVolume == true && b == false then
				if IsValid(self.FlashlightVolume) then self.FlashlightVolume:Remove() end
			end
		end
	end
	
	if self.MeleeQueue && IsFirstTimePredicted() then
		if #self.MeleeQueue <= 0 then self:ClearMeleeQueue() end -- apparently a table with 0 elements isn't empty?
		if !table.IsEmpty(self.MeleeQueue) then
			self.IsDoingMelee = true
			for i=1,#self.MeleeQueue do
				local info = self.MeleeQueue[i]
				if info && CurTime() >= info[1] then
					local swing = info[2]
					self:MeleeImpact(swing, Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), swing.x[1], swing.x[2]), Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), swing.y[1], swing.y[2]), i, "primary")
					self.MeleeQueue[i] = nil
				end
			end
		else
			self.IsDoingMelee = false
		end
	end
	
	if self.BurstQueue then
		if #self.BurstQueue <= 0 then self:ClearBurstQueue() end -- apparently a table with 0 elements isn't empty?
		if !table.IsEmpty(self.BurstQueue) then
			self.Bursting = true
			for i=1,#self.BurstQueue do
				local thyme = self.BurstQueue[i]
				if thyme && CurTime() >= thyme then
	--				PrintTable(self.BurstQueue)
					if !IsValid(self) or !IsValid(self:GetOwner()) then return end
					if self:GetLoadedAmmo() <= 0 then return end
					local kill = false
					if i >= self.FireModes_BurstShots && ply:IsPlayer() then kill = true end
	--				print(#self.BurstQueue, i, self.FireModes_BurstShots, kill)
					if kill == false then self.BurstQueue[i] = nil end
					if self.Loading == false then
						self:CallShoot("primary", true, kill)
					end
	--				print("---------------")
				end
			end
		else
			self.Bursting = false
		end
		if #self.BurstQueue <= 0 then self:ClearBurstQueue() end
	end
	
	if ply:IsPlayer() && self.RegenAmmo == true then self:RegeneratingAmmo(self, self.RegenAmmo_Delay, self.RegenAmmo_Amount) end
end

SWEP.desiredfov = 90
SWEP.fovchecktime = 0
function SWEP:ManageSights(ply, ct)
	if ply:IsPlayer() && ct > self.fovchecktime + 5 then
		self.fovchecktime = self.fovchecktime + 5
		self.desiredfov = ply:GetInfoNum("fov_desired", 90)
	end
	
	if ply:IsPlayer() then
		local fov = ply:GetFOV()
		local newfov = fov
		if !fov or !newfov then return end
		if !self.fovgrace then self.fovgrace = 0 end
		if self.SightsDown == true then newfov = self.IdealSightFOV
		elseif self.SightsDown == false && ply:KeyDown(IN_ZOOM) then newfov = 25 end
		if self:ShouldFixFOV() != false then newfov = self.desiredfov end
		
		local range = fov<=newfov+1 && fov>=newfov-1
		if !range && ct > self.fovgrace then
			self.fovgrace = ct + 0.4
			ply:SetFOV(newfov, 0.4)
		end
	end
	
	if self:CanUseSights() == false then
		self:SetIronsights(false, self.Owner)
	elseif self:CanUseSights() && self.Secondary.Ironsights == true && self.IronCD == false && self.Secondary.Disabled == false then
		if self.SightsDown != self:GetNWBool("SightsDown") then self.SightsDown = self:GetNWBool("SightsDown") end
		if ply:KeyPressed(IN_ATTACK2) == true && self.SightsDown == false && self:GetNWBool("Inspecting") == false && self.IronCD == false && self.Passive == false && !ply:KeyDown(IN_USE) then
			self:SetIronsights(true, self.Owner)
			
			self:AdjustMouseSensitivity()
			self:IronCoolDown()
			ply:EmitSound(DRCD.Weapons.ironsounds[string.lower(self:GetHoldType())][1])
			if CLIENT && self.Secondary.IronInFP != nil then
				surface.PlaySound(Sound(self.Secondary.IronInFP))
			end
		elseif ply:KeyReleased(IN_ATTACK2) == true && self.SightsDown == true && self.IronCD == false && !ply:KeyDown(IN_USE) then
			self:SetIronsights(false, self.Owner)
			
			self:IronCoolDown()
			ply:EmitSound(DRCD.Weapons.ironsounds[string.lower(self:GetHoldType())][2])
			if CLIENT && self.Secondary.IronOutFP != nil then
				surface.PlaySound(Sound(self.Secondary.IronOutFP))
			end
		end
	elseif self:CanUseSights() && self.Secondary.Ironsights == false or self.IronCD == true or self.Loading == true then
		self:SetIronsights(false, self.Owner)
	elseif self:CanUseSights() == nil then
		self:SetIronsights(false, self.Owner)
	end
	
	if ct > self.SightsSwapCD && self.IronSightsPosAlt != nil && ply:KeyDown(IN_WALK) && ply:KeyPressed(IN_RELOAD) then
		self.SightsSwapCD = ct + 0.25
		if self.AltSightBool == false or self.AltSightBool == nil then
			self.AltSightBool = true
			self.VARSightPos = self.IronSightsPosAlt
			self.VARSightAng = self.IronSightsAngAlt
			self.IdealSightFOV = self.desiredfov * (self.Secondary.IronFOVAlt / 90)
		else
			self.AltSightBool = false
			self.VARSightPos = self.IronSightsPos
			self.VARSightAng = self.IronSightsAng
			self.IdealSightFOV = self.desiredfov * (self.Secondary.IronFOV / 90)
		end
		if self.SightSwapCD == true then return end
	end
	
	if CLIENT && self.ScopeUp == false && self.Secondary.Scoped == true then
		self.ScopeUp = true
	elseif CLIENT && self.ScopeUp == true then
		self.ScopeUp = false
	end
end

function SWEP:ManageCharge(ply, primcharge, seccharge, loaded)
	local canoc = self:CanOvercharge()
	local charge = self.ChargeType
	local chargeresponses = DRCD.Weapons.chargeresponses
	
	if ply:IsPlayer() && primcharge && loaded && self:CanPrimaryAttack() then
		local m1d = ply:KeyDown(IN_ATTACK)
		local m1r = ply:KeyReleased(IN_ATTACK)
		
		if m1r && self:CanOvercharge() then
			if chargeresponses[charge][2] != nil then self:CallShoot("overcharge") end
		elseif m1r && !canoc then
			if chargeresponses[charge][1] != nil then self:CallShoot("primary") end
		end
		
		if m1d && canoc then
			if chargeresponses[charge][3] == false then self:CallShoot("overcharge") end
		end
	end
	
	if ply:IsPlayer() && seccharge && loaded && self:CanSecondaryAttack() then
		local m1p = ply:KeyPressed(IN_ATTACK2)
		local m1d = ply:KeyDown(IN_ATTACK2)
		local m1r = ply:KeyReleased(IN_ATTACK2)
		local ukd = ply:KeyDown(IN_USE)
			
		if m1r && self:CanOvercharge() then
			if chargeresponses[charge][2] != nil then self:CallShoot("overcharge") end
		elseif m1r && !canoc then
			if chargeresponses[charge][1] != nil then self:CallShoot("secondary") end
		end
		
		if m1d && canoc then
			if chargeresponses[charge][3] == false then self:CallShoot("overcharge") end
		end
	end
	
	if primcharge or seccharge then
		if !self.ChargingSound then self.ChargingSound = CreateSound(self, self.ChargeSound) end
	end
end

function SWEP:ManageLoopingSounds(ply, ct, passive, overheated, loaded, primcharge, seccharge)
	if passive then
		if self.LoopingFireSound != nil then
			self.LoopingFireSound:Stop()
		end
		if self.LoopingFireSoundSecondary != nil then
			self.LoopingFireSoundSecondary:Stop()
		end
	end
	
	if !game.IsDedicated() && ply:IsPlayer() then
		local m1p = ply:KeyPressed(IN_ATTACK)
		local m1d = ply:KeyDown(IN_ATTACK)
		local m1r = ply:KeyReleased(IN_ATTACK)
		
		local m2p = ply:KeyPressed(IN_ATTACK2)
		local m2d = ply:KeyDown(IN_ATTACK2)
		local m2r = ply:KeyReleased(IN_ATTACK2)
		
		local ekd = ply:KeyDown(IN_USE)
		local ekp = ply:KeyPressed(IN_USE)
		local skd = ply:KeyDown(IN_SPEED)
		
		if primcharge == true then
			if m1p && !passive && !ekd && self:CanPrimaryAttack() then
				self.ChargingSound:Play()
			elseif !m1d or overheated == true then
				self.ChargingSound:Stop()
			end
		elseif self.Secondary.UsesCharge == true then
			if m2p && !passive && !ekd then
				self.ChargingSound:Play()
			elseif !m2d or overheated == true then
				self.ChargingSound:Stop()
			end
		end
	
		if self.Primary.LoopingFireSound != nil && self.Readied == true then
			if m1p && self:CanPrimaryAttack() && !passive && !ekd && overheated == false && self:Clip1() > 0 then
				self:EmitSound(self.Primary.LoopingFireSoundIn)
				self.LoopFireSound:Play()
			else end
			
			if !m1d or overheated == true or ply:KeyPressed(IN_USE) then
				if self.LoopFireSound then self.LoopFireSound:Stop() end
			end

			if self:Clip1() > 0 then
				if (m1r && !ekd && overheated == false) or (m1d && overheated == false && ekp) then
					if (self.DoesPassiveSprint == true or DRC.SV.drc_force_sprint == 1) && !skd then
						self:EmitSound(self.Primary.LoopingFireSoundOut)
					elseif (self.DoesPassiveSprint != true && DRC.SV.drc_force_sprint != 1) && skd then
						self:EmitSound(self.Primary.LoopingFireSoundOut)
					elseif (DRC.SV.drc_force_sprint == 2) && skd then
						self:EmitSound(self.Primary.LoopingFireSoundOut)
					end
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
		if (self.Owner:KeyReleased(IN_ATTACK) && !passive or (!self.Owner:KeyDown(IN_ATTACK) && self.LoopingFireSound)) then
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
		if (self.Owner:KeyReleased(IN_ATTACK2) && !passive or (!self.Owner:KeyDown(IN_ATTACK2) && self.LoopingFireSoundSecondary)) then
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
end

function SWEP:CanMelee()
	if self.IsDoingMelee == true then return false else return true end
end

function SWEP:CanGunMelee()
	if !self:CanMelee() then return false end
	local ply = self:GetOwner()
	local sights = self.SightsDown
	local passive = self:GetNWBool("Passive")
	local inspection = self:GetNWBool("Inspecting")
	
	if self.Primary.CanMelee == false then return false end
	if inspection == true then return false end
	if sights == false && passive == false then return true else return false end
end

local LoadingAnims = {
	ACT_VM_DRAW,
	ACT_VM_DRAW_EMPTY,
	ACT_VM_RELOAD,
	ACT_VM_RELOAD_EMPTY,
	ACT_SHOTGUN_RELOAD_START,
	ACT_SHOTGUN_RELOAD_FINISH,
	ACT_SHOTGUN_PUMP,
}
local FiringAnims = {
	ACT_VM_PRIMARYATTACK,
	ACT_VM_SECONDARYATTACK,
	ACT_SPECIAL_ATTACK1,
	ACT_VM_DEPLOYED_IRON_FIRE,
}
function SWEP:ManageAnims(ply, ct)
	if !IsValid(self) then return end
	if !IsValid(ply) then return end
	if !ply:IsPlayer() then return end
	if !self:HasViewModel() then return end
	local vm = ply:GetViewModel(0)
	if !IsValid(vm) then return end
	if vm:GetModel() == "" or vm:GetModel() == nil then return end
	
	local cv, hands
	if ply:IsPlayer() then
		cv = ply:Crouching()
		hands = ply:GetHands()
		if CLIENT && game.SinglePlayer() && RealTime() > self.RealTime then
			self.RealTime = RealTime() + RealFrameTime() -- For some reason, calling :GetCycle() inside of Think() will be called three times per frame. The first one will always return 0. This prevents it from being called multiple times and creating glitchy-looking-behaviour.
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
	end
	
	if self.IdleTimer < CurTime() && self.IsDoingMelee == true then
		self.IsDoingMelee = false
		self.Loading = false
	end
	
	if CLIENT then
		local act = vm:GetSequenceActivity(vm:GetSequence())
		if table.HasValue(LoadingAnims, act) then self.PlayingLoadAnimation = true else self.PlayingLoadAnimation = false end
		if !self.IsMelee && table.HasValue(FiringAnims, act) then self.PlayingShootAnimation = true else self.PlayingShootAnimation = false end
	end
	
	if !self:IsIdle() then return end

	local oa = self.OwnerActivity
	local cv = ply:Crouching()
	local slowvar = ply:Crouching() or ply:KeyDown(IN_WALK)
	
	local n, s, e, w = ply:KeyDown(IN_FORWARD), ply:KeyDown(IN_BACK), ply:KeyDown(IN_MOVERIGHT), ply:KeyDown(IN_MOVELEFT)
	local walking = (n or s or e or w)
	local sprinting = walking && ply:KeyDown(IN_SPEED)
	if DRC.SV.drc_force_sprint == 2 then sprinting = false end
	
	if self.ManuallyReloading == true or self.Loading == true or self:GetNextPrimaryFire() > ct or self:GetNextSecondaryFire() > ct or self.PreventIdleTimer > ct then return end
	
	local idleanim = vm:SelectWeightedSequence(ACT_VM_IDLE)
	local ironanim = vm:SelectWeightedSequence(ACT_VM_DEPLOYED_IRON_IDLE)
	local walkanim = vm:SelectWeightedSequence(ACT_WALK)
	local sprintanim = vm:SelectWeightedSequence(ACT_RUN)
	local swimidleanim = vm:SelectWeightedSequence(ACT_SWIM_IDLE)
	local swimminganim = vm:SelectWeightedSequence(ACT_SWIM)
	local fireanim = vm:SelectWeightedSequence(ACT_VM_PRIMARYATTACK)
	local firedur = vm:SequenceDuration(fireanim)
	local jumpanim = vm:SelectWeightedSequence(ACT_JUMP)
	local jumpdur = vm:SequenceDuration(jumpanim)
	
	if !self.JumpWait then self.JumpWait = 0 end
	
	local reloadanim = vm:SelectWeightedSequence( ACT_VM_RELOAD )
	local walkanim = vm:SelectWeightedSequence( ACT_WALK )
	
	local anim = vm:GetSequence()
	local animdata = vm:GetSequenceInfo(anim)
	local animact = animdata.activity
	
	if self.SightsDown && ct > self.LastFireAnimTime then
		if ironanim != -1 then
			vm:SendViewModelMatchingSequence(ironanim)
		else
			vm:SendViewModelMatchingSequence(idleanim)
		end
	return end
	
	if jumpanim != -1 && ply:KeyPressed(IN_JUMP) && (ct >= self.JumpWait) then
		self:PlayAnim(ACT_JUMP)
		self.JumpWait = ct + jumpdur
	end
	
	if DRC:FloorDist(ply, 25) < 1 or ply:IsOnGround() then
		if self.JumpWait > ct then self.JumpWait = 0 end
		self.ShouldWalkBlend = true
	else
		self.ShouldWalkBlend = false
	end
	
	if !walking && !sprinting then
		self.AnimToPlay = ACT_VM_IDLE
	elseif walking && !sprinting then
		if walkanim == -1 then
			self.AnimToPlay = ACT_VM_IDLE
		else
			self.AnimToPlay = ACT_WALK
		end
	elseif sprinting && !cv then
		if sprintanim == -1 then
			self.AnimToPlay = ACT_VM_IDLE
		else
			self.AnimToPlay = ACT_RUN
		end
	end
	
	if animact != self.AnimToPlay && (ct >= self.JumpWait) then self.IdleTimer = ct end
		
	if self.IdleTimer <= ct then
		if idleanim == -1 then return end
		self:PlayAnim(self.AnimToPlay)
	end
end

function SWEP:DoCustomThink()
end

SWEP.MulIns = 0
if CLIENT then
	SWEP.InterpolateHolsterBoolVal = 1
	SWEP.VelInterp = 0
	
	function SWEP:GetViewModelPosition( pos, ang )
		local ply = self:GetOwner()
		if !IsValid(ply) then return end
		if !IsValid(self) then return end
		if ply:IsWorld() then return end
		
		local sk = ply:KeyDown(IN_SPEED)
		local mk = (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK))
		local sprint = sk && mk && (self.DoesPassiveSprint == true or DRC.SV.drc_force_sprint == 1)
		local passive = self:GetNWBool("Passive", false) && DRC.SV.drc_passives >= 1
		local inspect = self:GetNWBool("Inspecting") && DRC.SV.drc_inspections >= 1
		local eyeangforward = ply:EyeAngles()
		local sd = self.SightsDown
		if DRC.SV.drc_force_sprint == 2 then sprint = false end
		
		if passive or sprint then
			self:DoPassiveHoldtype()
		elseif inspect == true then
			self:DoInspectHoldtype()
		else
			if self:GetHoldType() != self.HoldType then self:SetHoldType(self.HoldType) end
		end
		
		local IronTime = self.IronTime or 0	
		local InspectTime = self.InspectTime or 0
		
		self.MulI = math.Clamp((CurTime() - IronTime) / 0.35, 0, 1)
		self.MulIns = math.Clamp((CurTime() - InspectTime) / 0.325, 0, 1)
		
		local vel = math.Clamp(ply:GetVelocity():LengthSqr()/36100, 0, 1)
		self.VelInterp = Lerp(0.1, self.VelInterp or vel, vel)
		
		if sd == true then
			self.BobScale = 0.1
			self.SwayScale = 0.25
		else
			self.BobScale = self.BS
			self.SwayScale = self.SS
		end
		
		local holsterbool = false
		if self.DoesPassiveSprint == true or DRC.SV.drc_force_sprint == 1 then
			if passive == true or sprint == true then self.InterpolateHolsterBoolVal = 1 holsterbool = true else self.InterpolateHolsterBoolVal = 0 end
			self.InterpolatedHolsterVal = Lerp(RealFrameTime() * 10, self.InterpolatedHolsterVal or self.InterpolateHolsterBoolVal, self.InterpolateHolsterBoolVal)
		
			local upperstrength = math.abs(eyeangforward.x/2) / 45
			ang = ang + Angle(math.Clamp(-eyeangforward.x/2, -30, 45), 0, 0) * self.InterpolatedHolsterVal * upperstrength
			local holsteroffset = (Vector(0, -7.5, -3) * self.InterpolatedHolsterVal) * (math.abs(eyeangforward.x/2) / 45)
			pos:Add(ang:Right() * holsteroffset.x)
			pos:Add(ang:Forward() * holsteroffset.y)
			pos:Add(ang:Up() * holsteroffset.z)
		end

		ang:RotateAroundAxis(ang:Right(), self.DynOffsetAng.x)
		ang:RotateAroundAxis(ang:Up(), self.DynOffsetAng.y)
		ang:RotateAroundAxis(ang:Forward(), self.DynOffsetAng.z)
		pos:Add(ang:Right() * self.DynOffsetPos.x)
		pos:Add(ang:Forward() * self.DynOffsetPos.y)
		pos:Add(ang:Up() * self.DynOffsetPos.z)
		
		if sd == true or (ply:GetCanZoom() == true && ply:KeyDown(IN_ZOOM)) then
			self.LoweredCrossHairMod = Lerp(RealFrameTime() * 10, self.LoweredCrossHairMod or 1, 0)
		else
			self.LoweredCrossHairMod = Lerp(RealFrameTime() * 10, self.LoweredCrossHairMod or 0, 1)
		end
		
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

function SWEP:GetIdealSightFOV()
	local ply = self:GetOwner()
	if !ply:IsPlayer() then return end
	if IsValid(ply) then self.IdealSightFOV = ply:GetInfoNum("fov_desired", 90) * ((self.Secondary.IronFOV or 90) / 90) end
end

function SWEP:Deploy()
	if game.SinglePlayer() then self:CallOnClient("Deploy") end
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	
	self:DoCustomDeploy()
--	self:CallOnClient("DoCustomDeploy")
	
	local cv, vm = false, self
	if ply:IsPlayer() then cv = ply:Crouching() vm = ply:GetViewModel() end
	local drawanim = vm:SelectWeightedSequence( ACT_VM_DRAW )
	local drawaniminitial = vm:SelectWeightedSequence( ACT_VM_DRAW_EMPTY )
	local drawanimdur = vm:SequenceDuration(drawanim)
	local drawaniminitialdur = vm:SequenceDuration(drawaniminitial)
	self.IdleTimer = CurTime() + drawaniminitialdur
	self:SetNextPrimaryFire( CurTime() + drawanimdur)
	self:SetNextSecondaryFire( CurTime() + drawanimdur)
	vm:SetPlaybackRate( 1 )
	self:SetIronsights(false)
	self.SightsDown = false
	if self:GetNWBool("Passive") == true then self:TogglePassive() end
	self.Idle = 1
	self.IsTaunting = 0
	self.Inspecting = false
	self:SetNWBool("Inspecting", false)
	self.EmptyReload = 0
	self.ManuallyReloading 	= false
	self.Loading			= false
	
	self:GetIdealSightFOV()
	
	if self.WeaponSkinApplied != nil then self:SetCamo(self.WeaponSkinApplied) end
	
	if self.Thirdperson == true && ply:IsPlayer() && CLIENT then DRC:ThirdPerson_PokeLiveAngle(ply) end
	
	if self.IdleLoopSoundConstant == false && selfIdleLoopSound then
		self.IdleSound:Play()
	end
	
	if ply:IsPlayer() then
		self.desiredfov = ply:GetInfoNum("fov_desired", 90)
		self.DManip_PlyID = "DRC_DManip_" ..ply:Name().. ""
		self.IdleTimer = CurTime() + drawanimdur
		if self.Readied == true or drawaniminitial == -1 then
			self:PlayAnim( ACT_VM_DRAW, true, true )
			timer.Simple(drawanimdur, function()
				self.Readied = true
			end)
		else
			self:PlayAnim( ACT_VM_DRAW_EMPTY )
			timer.Simple(drawaniminitialdur, function()
				self.Readied = true
			end)

		end
	end

	if self.Passive == true then
		self:DoPassiveHoldtype()
	else
		self:SetHoldType( self.HoldType )
	end
	
	self:SetCharge(0)
	
	if IsValid(self) && IsValid(ply) && ply:IsPlayer() && ply:Alive() then
		self:GetMovementValues()
	end
	
	if self.Primary.Ammo != nil then self:SetNWInt("LoadedAmmo", self:Clip1()) end
	
	if ply:IsPlayer() && self.HealthRegen == true then self:RegeneratingHealth(ply) end
	if self.SpecialScripted != true then
		if ply:IsPlayer() then
			self:BloomScore()
			timer.Simple(0.1, function() if !ply:Alive() or !IsValid(ply) or !IsValid(self) then return end self:CallOnClient( "BloomScore" ) end)
		end
	end

	self:SetNWFloat("HeatDispersePower", 1)
	
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
	self:ClearSubMaterials()

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

function SWEP:Holster(wpn)
	local ply = self:GetOwner()
	self.IdleTimer = CurTime()
	
	self:DoCustomHolster()
	--self:SetNWBool("Ironsights", false )
	self.SightsDown = false
	self:SetNWBool("Inspecting", false)
	
	self:ClearBurstQueue()
	self:ClearSubMaterials()
	
	self:SetNWBool("IntegratedLightState", false)
	
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
	if DRC.SV.drc_movement > 1 then return end
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
--	self:ClearSubMaterials()
	
	self:DoCustomDrop()
	net.Start("DRC_WeaponDropped")
	net.WriteEntity(self)
	net.Broadcast()
end

function SWEP:Inspect()
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	if !ply:IsPlayer() then return end
	

	
	self.Inspecting = true
	self:SetNWBool("InspectCamLerp", true)
	if !IsFirstTimePredicted() then return end
	self:DoCustomInspect()
	local inspectanim = self:SelectWeightedSequence(ACT_VM_FIDGET)
	local inspectdur = self:SequenceDuration(inspectanim)
	self:PlayAnim(ACT_VM_FIDGET)
	
	timer.Simple( inspectdur, function() if IsValid(self) then self:EnableInspection() end end)
end

function SWEP:DoCustomInspect()
end

function SWEP:EnableInspection()
	self.Inspecting = false
	self:SetNWBool("InspectCamLerp", false)
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

function SWEP:DoImpactEffect(tr, dt)
	if game.SinglePlayer() && CLIENT then return true end
	if !game.SinglePlayer() && SERVER then return true end
	if self.HideImpacts == true then return true end
	if CurTime() < self.LastMeleeImpactTime + 0.1 then return true end
	return false
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )

	if isnumber(self.WepSelectIcon) then
		surface.SetTexture(self.WepSelectIcon)
	elseif isstring(self.WepSelectIcon) then
		surface.SetTexture(surface.GetTextureID( self.WepSelectIcon ))
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
	if ply:InVehicle() then return nil end
	local oh = self:GetNWBool("Overheated")
	
	if self.IsDoingMelee == true then self:SetIronsights(false) return false end
	
	if IsValid(ply:GetVehicle()) then self:SetIronsights(false) return false end
	if self:GetNWBool("Passive") == true then return false end
	
	if self.Loading == true then self:SetIronsights(false) return false end
	
	if (oh or self.Loading == true or self.ManuallyReloading == true) && self.LoadAfterShot == false then 
		self.SightsDown = false
		self:SetIronsights(false)
	return false end
	
	return true
end

function SWEP:ShouldFixFOV()
	if self.SightsDown == true then return false end
	local ply = self:GetOwner()
	if !ply:IsPlayer() then return end
	if ply:InVehicle() then return false end
	if ply:KeyDown(IN_ZOOM) then return false end
	return true
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
		
		local basegameammo = DRC.SV.drc_forcebasegameammo == 0
	
		ammo = scripted_ents.GetStored(self.AttachmentTable.AmmunitionTypes[1])
		local ammotype = ammo.t.BulletTable.AmmoType
		local basegameammotype = ammo.t.BulletTable.FallbackBaseAmmoType
		if basegameammo then
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
		if basegameammo && !self.IsBatteryBased then
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
	
	self:PreCalcSpread()
end

function SWEP:PreCalcRPM()
	self.PrimaryStats.PreCalcRPM = 60/self.Primary.RPM
	self.SecondaryStats.PreCalcRPM = 60/self.Secondary.RPM
	if self.OCStats && self.Primary.OCRPM then self.OCStats.PreCalcRPM = 60/self.Primary.OCRPM end
end

function SWEP:PreCalcSpreadAttachments()
	if !IsValid(self) then return end
	if !self.AttachmentStats then self.AttachmentStats = {} end
	local spr, sprdiv = self:GetAttachmentValue("Ammunition", "Spread") or 1, self:GetAttachmentValue("Ammunition", "SpreadDiv") or 1
	
	self.AttachmentStats.PreCalcSpread = spr / sprdiv
end

function SWEP:PreCalcSpreadMain()
	if !IsValid(self) then return end
	if !self.PrimaryStats then self.PrimaryStats = {} end
	if !self.SecondaryStats then self.SecondaryStats = {} end
	if !self.OCStats then self.OCStats = {} end

	self.PrimaryStats.PreCalcSpread = self.Primary.Spread / self.Primary.SpreadDiv
	self.SecondaryStats.PreCalcSpread = self.Secondary.Spread / self.Secondary.SpreadDiv
	self.OCStats.PreCalcSpread = self.OCSpread / self.OCSpreadDiv
end

SWEP.RecoilStats = {
	["primary"] = {
		RecoilDown = SWEP.Primary.RecoilDown,
		RecoilUp = SWEP.Primary.RecoilUp,
		RecoilHoriz = SWEP.Primary.RecoilHoriz,
		Kick = SWEP.Primary.Kick,
		KickHoriz = SWEP.Primary.KickHoriz,
		IronRecoilMul = SWEP.Primary.IronRecoilMul
	},
	["secondary"] = {
		RecoilDown = SWEP.Secondary.RecoilDown,
		RecoilUp = SWEP.Secondary.RecoilUp,
		RecoilHoriz = SWEP.Secondary.RecoilHoriz,
		Kick = SWEP.Secondary.Kick,
		KickHoriz = SWEP.Secondary.KickHoriz,
		IronRecoilMul = SWEP.Secondary.IronRecoilMul
	},
	["overcharge"] = {
		RecoilDown = SWEP.OCRecoilDown,
		RecoilUp = SWEP.OCRecoilUp,
		RecoilHoriz = SWEP.OCRecoilHoriz,
		Kick = SWEP.OCKick,
		KickHoriz = SWEP.OCKickHoriz,
		IronRecoilMul = SWEP.OCIronRecoilMul
	}
}

function SWEP:PreCalcRecoil()
	local down = self:GetAttachmentValue("Ammunition", "RecoilDown")
	local up = self:GetAttachmentValue("Ammunition", "RecoilUp")
	local horiz = self:GetAttachmentValue("Ammunition", "RecoilHoriz")
	local kick = self:GetAttachmentValue("Ammunition", "Kick")
	local kickhoriz = self:GetAttachmentValue("Ammunition", "KickHoriz")
	local iron = self:GetAttachmentValue("Ammunition", "IronRecoilMul")

	self.RecoilStats.primary = {
		RecoilDown = self.Primary.RecoilDown * down,
		RecoilUp = self.Primary.RecoilUp * up,
		RecoilHoriz = self.Primary.RecoilHoriz * horiz,
		Kick = self.Primary.Kick * kick,
		KickHoriz = self.Primary.KickHoriz * kickhoriz,
		IronRecoilMul = self.Primary.IronRecoilMul * iron
	}
	self.RecoilStats.secondary = {
		RecoilDown = self.Secondary.RecoilDown * down,
		RecoilUp = self.Secondary.RecoilUp * up,
		RecoilHoriz = self.Secondary.RecoilHoriz * horiz,
		Kick = self.Secondary.Kick * kick,
		KickHoriz = self.Secondary.KickHoriz * kickhoriz,
		IronRecoilMul = self.Secondary.IronRecoilMul * iron
	}
	self.RecoilStats.overcharge = {
		RecoilDown = self.OCRecoilDown * down,
		RecoilUp = self.OCRecoilUp * up,
		RecoilHoriz = self.OCRecoilHoriz * horiz,
		Kick = self.OCKick * kick,
		KickHoriz = self.OCKickHoriz * kickhoriz,
		IronRecoilMul = self.OCIronRecoilMul * iron
	}
end

function SWEP:PreCalcSpread()
	self:PreCalcSpreadAttachments()
	self:PreCalcSpreadMain()
	self:PreCalcRecoil()
end



function SWEP:SetupDataTables()
	self:SetNWFloat("Charge", 0)
	self:SetNWBool("Passive", false)
	self:SetNWBool("Inspecting", false)
	self:SetNWBool("ThirdpersonForceFreelook", false)
	
	self.AttachmentStats = {}
	
	if self.IsMelee == false then
	self.PrimaryStats = {
		BloomMul = self.Primary.BloomMul,
		BloomMulCrouch = self.Primary.BloomMulCrouch,
		BloomMulADS = self.Primary.BloomMulADS,
		Damage = self.Primary.Damage,
		DamageNPC = self.Primary.DamageNPC,
		Projectile = self.Primary.Projectile,
		ProjSpeed = self.Primary.ProjSpeed,
		ProjInheritVelocity = self.Primary.ProjInheritVelocity,
		IronRecoilMul = self.Primary.IronRecoilMul,
		Spread = self.Primary.Spread,
		SpreadDiv = self.Primary.SpreadDiv,
		SpreadX = self.Primary.SpreadXMul,
		SpreadY = self.Primary.SpreadYMul,
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
		PreCalcRPM = 60/self.Primary.RPM,
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
		BloomMul = self.Secondary.BloomMul,
		BloomMulCrouch = self.Secondary.BloomMulCrouch,
		BloomMulADS = self.Secondary.BloomMulADS,
		Damage = self.Secondary.Damage,
		DamageNPC = self.Secondary.DamageNPC,
		Projectile = self.Secondary.Projectile,
		ProjSpeed = self.Secondary.ProjSpeed,
		ProjInheritVelocity = self.Secondary.ProjInheritVelocity,
		IronRecoilMul = self.Secondary.IronRecoilMul,
		Spread = self.Secondary.Spread,
		SpreadDiv = self.Secondary.SpreadDiv,
		SpreadX = self.Secondary.SpreadXMul,
		SpreadY = self.Secondary.SpreadYMul,
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
		PreCalcRPM = 60/self.Secondary.RPM,
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
		BloomMul = self.OCBloomMul,
		BloomMulCrouch = self.OCBloomMulCrouch,
		BloomMulADS = self.OCBloomMulADS,
		Damage = self.OCDamage,
		DamageNPC = self.OCDamageNPC,
		Projectile = self.OCProjectile,
		ProjSpeed = self.OCProjSpeed,
		ProjInheritVelocity = self.OCProjInheritVelocity,
		IronRecoilMul = self.OCIronRecoilMul,
		Spread = self.OCSpread,
		SpreadDiv = self.OCSpreadDiv,
		SpreadX = self.OCSpreadXMul,
		SpreadY = self.OCSpreadYMul,
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
		PreCalcRPM = 60/self.OCRPM,
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
	end
	
	self.InfoStats = {
		Name = self.PrintName,
		InfoName = self.InfoName,
		Manufacturer = self.Manufacturer,
		Description = self.InfoDescription
	}
	
--	if self.IsBatteryBased == nil or self.IsBatteryBased == false then return end
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

function SWEP:PlayAnim(act, preventstuff, important)
	if !game.IsDedicated() && !IsFirstTimePredicted() then return end
	local seq = self:SelectWeightedSequence(act)
	if seq == -1 then return end
	local ct = CurTime()
	local seqdur = self:SequenceDuration(seq)
	self:ResetSequence(seq)
	self:ResetSequenceInfo()
	self:SendWeaponAnim(act)
	self.IdleTimer = ct + seqdur
	
	if important && important == true then
		self.PreventIdleTimer = ct + seqdur
	end
	
	if preventstuff && preventstuff == true then
		self:SetNextPrimaryFire(ct + seqdur)
		self:SetNextSecondaryFire(ct + seqdur)
		self.LockoutTime = ct + seqdur
	end
end

function SWEP:ToggleIntegratedLight(b)
	local ply = self:GetOwner()
	local bool = self:GetNWBool("IntegratedLightState", false)
	if b == nil then b = bool else b = !b end
	
	local dur = self:SequenceDuration(self:SelectWeightedSequence(ACT_OBJ_STARTUP)) * self.IntegratedLight_ToggleFrac
	self:PlayAnim(ACT_OBJ_STARTUP, true)
	
	timer.Simple(dur, function()
		if !IsValid(self) then return end
		if b == false then
			self:SetNWBool("IntegratedLightState", true)
			self:EmitSound(self.IntegratedLight_OnSound)
		else
			self:SetNWBool("IntegratedLightState", false)
			self:EmitSound(self.IntegratedLight_OffSound)
		end
	end)
end

function SWEP:SetCamo(mat)
	local ply = self:GetOwner()
	if mat == "" then mat = nil end
	self.WeaponSkinApplied = mat
	
	if !ply:IsPlayer() then
		for k,v in pairs(self.WeaponSkinSubMaterials) do
			if mat != nil then
				if DRC.WeaponSkins[mat].proxy == true then
					self:SetSubMaterial(k-1, "models/vuthakral/weaponskin_".. k-1 .."")
				else
					self:SetSubMaterial(k-1, mat)
				end
			else
				self:SetSubMaterial(k-1, mat)
			end
		end
	else
		local vm = ply:GetViewModel()
		for k,v in pairs(self.WeaponSkinSubMaterials) do
			if mat != nil then
				if DRC.WeaponSkins[mat].proxy == true then
					self:SetSubMaterial(k-1, "models/vuthakral/weaponskin_".. k-1 .."")
					vm:SetSubMaterial(k-1, "models/vuthakral/weaponskin_".. k-1 .."")
				else
					vm:SetSubMaterial(k-1, mat)
					self:SetSubMaterial(k-1, mat)
				end
			else
				vm:SetSubMaterial(k-1, mat)
				self:SetSubMaterial(k-1, mat)
			end
		end
	end
end

function SWEP:ClearSubMaterials()
	local ply = self:GetOwner()
	local mats = self:GetMaterials()
	
	if !ply:IsPlayer() then
		for i=0,#mats do self:SetSubMaterial(i, nil) end
	else
		local vm = ply:GetViewModel()
		for i=0,#mats do
			if IsValid(vm) then vm:SetSubMaterial(i, nil) end
			self:SetSubMaterial(i, nil)
		end
	end
end

function SWEP:GetNPCBurstSettings()
	local ply = self:GetOwner()
	if self.IsMelee then return end
	if self.NPCBursting == true then return end
	
	if ply:IsPlayer() then return end
	
	local burst = self.NPCBurstShots or 1
	local rpm = self.Primary.RPM
	local fm = self:GetFireMode()
	if fm == "" then self:InitialFireMode() end -- Sometimes NPCs spawning with guns can break stuff like this. Don't ask me why, I don't know either.
	
	if (ply:IsNPC() or ply:IsNextBot()) && self.FireModes_CanBurst == true then
		self:SetNWString("FireMode", "Burst")
	end
	
	local mini, maxi, delay = nil, nil, nil

	if fm == 1 then
		mini = 1
		maxi = 1
		delay = (60 / rpm)
	elseif fm == 2 then
		mini = math.Rand(1, burst)
		maxi = burst * 3
		delay = (60 / rpm)
		if self.Primary.Ammo == "ammo_drc_battery" then
			mini = mini * self.BatteryConsumePerShot
			maxi = (maxi * self.BatteryConsumePerShot / 5)
		end
	elseif fm == 3 then
		mini = self.FireModes_BurstShots
		maxi = self.FireModes_BurstShots
		delay = (60 / rpm)
	end
	
	if self.LoadAfterShot == true then
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
	if game.SinglePlayer() then self:CallOnClient("PreDrawViewModel") end
	if ply:GetNWBool("Interacting") == true then return true end
	
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
	self.EmptyMagCL = Lerp(FrameTime() * 15, self.EmptyMagCL or slide, slide)
	
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

function SWEP:PostDrawViewModel(vm, wpn, ply)
	if !self.VMA then self.VMA = {} end
	for k,v in pairs(vm:GetAttachments()) do
		if !self.VMA[v.name] then self.VMA[v.name] = {} end
		local attinfo = vm:GetAttachment(v.id)
		
		self.VMA[v.name] = {
			["id"] = v.id,
			["pos"] = wpn:FormatViewModelAttachment(ply:GetFOV(), attinfo.Pos, false),
			["ang"] = attinfo.Ang,
		}
	end
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
			if DRC.SV.drc_forcebasegameammo == 0 then
				self.Primary.Ammo = self:GetAttachmentValue("Ammunition", "AmmoType")
			else
				self.Primary.Ammo = self:GetAttachmentValue("Ammunition", "BaseGameAmmoType")
			end
		end
	end
end

function SWEP:OnRestore()
	self.BurstQueue = {}
	self.MeleeQueue = {}
	self.AmmoCheck = 0
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
			self.EmptyMagCL_TP = Lerp(FrameTime() * 15, self.EmptyMagCL_TP or slide, slide)
			
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