--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

SWEP.HoldType			= "default"
SWEP.CrouchHoldType		= nil
SWEP.Contact			= "Steam: Vuthakral \nDiscord: Vuthakral#9761 "
SWEP.Purpose			= ""
SWEP.Instructions		= ""
SWEP.WepSelectIcon 		= "vgui/entities/drc_default"

SWEP.Category			= "Draconic"
SWEP.PrintName			= "Draconic Base"
SWEP.Author				= "Vuthakral"
SWEP.InfoName			= nil
SWEP.Manufacturer		= nil
SWEP.InfoDescription	= nil
SWEP.HasSerial			= false

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.DeploySpeed		= 1
SWEP.Weight				= 1

SWEP.Slot				= 0
SWEP.SlotPos			= 0

SWEP.CrosshairColor		= Color(255, 255, 255, 255)
SWEP.CrosshairShadow	= false
SWEP.CrosshairStatic	= nil
SWEP.CrosshairDynamic	= nil
SWEP.CrosshairCorrectX	= 1
SWEP.CrosshairCorrectY	= 1
SWEP.CrosshairSizeMul	= 1
SWEP.CrosshairNoIronFade = false

SWEP.ViewModelFOV		= 54
SWEP.ViewModelFlip		= false
SWEP.DrawAmmo			= true

SWEP.WallHax	= false
SWEP.InfAmmo	= false

SWEP.UseHands			= true
SWEP.DoesPassiveSprint	= false
SWEP.ViewModel			= ""
SWEP.WorldModel			= ""
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPosCrouch = Vector(0, 0, 0)
SWEP.VMAngCrouch = Vector(0, 0, 0)
SWEP.LoweredVMPos = Vector(0, 0, 0)
SWEP.LoweredVMAng = Vector(0, 0, 0)
SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.PassivePos = Vector(5, 0, 3)
SWEP.PassiveAng = Vector(-15, 25, 0)
SWEP.InspectPos = Vector(3, 2, -2.5)
SWEP.InspectAng = Vector(15, 15, 0)
SWEP.SprintPos = Vector(5, 0, 3)
SWEP.SprintAng = Vector(-15, 25, 0)
SWEP.CurPos = Vector(0, 0, 0) -- overwrites itself, do not use
SWEP.CurAng = Vector(0, 0, 0) -- overwrites itself, do not use
SWEP.SS = 1
SWEP.BS = 1
SWEP.InspectDelay = 0.5

SWEP.Thirdperson = false

SWEP.IdleActivity = ACT_VM_IDLE
SWEP.CrouchIdleActivity = ACT_VM_IDLE

SWEP.FireModes_SwitchSound = Sound("Weapon_AR2.Empty")

-- CHARGE SETTINGS
SWEP.Primary.UsesCharge = false
SWEP.Secondary.UsesCharge = false

SWEP.ChargeRate		= 10
SWEP.ChargeHoldDrain = 0.25

SWEP.ChargeType = "dualheld"

SWEP.ChargeSound = Sound("draconic.ChargeGeneric")

SWEP.OCNumShots 		= 1
SWEP.OCSpread			= 0
SWEP.OCSpreadDiv		= 200
SWEP.OCKick				= 0.36
SWEP.OCRecoilUp			= 0.06
SWEP.OCRecoilDown		= 0.03
SWEP.OCRecoilHoriz		= 8
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
SWEP.OCProjectile = nil
SWEP.OCProjSpeed = 500

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

SWEP.Idle = 0
SWEP.IdleTimer = CurTime()
SWEP.IsTaunting = 0
SWEP.TauntCooldown = 1
SWEP.PassiveHealing			= ""
SWEP.BreathCycle			= ""
SWEP.AmmoRegen				= ""
SWEP.FallDamage				= true
SWEP.NoFallDamageCrouchOnly = true
SWEP.HealthRegen 			= false
SWEP.HealAmount				= 1
SWEP.HealInterval			= 1
SWEP.WeaponIdleLoopSound 	= ("")
SWEP.FireMode	= "none"
SWEP.OwnerActivity = "standidle"

SWEP.Primary.LightColor 		= Color(255, 255, 30)
SWEP.Primary.LightBrightness	= 1
SWEP.Primary.LightSize			= 50
SWEP.Primary.LightDecayTime		= 1000

SWEP.Secondary.LightColor 		= Color(255, 255, 30)
SWEP.Secondary.LightBrightness	= 1
SWEP.Secondary.LightSize		= 50
SWEP.Secondary.LightDecayTime	= 1000

SWEP.OCLightColor 		= Color(255, 255, 30)
SWEP.OCLightBrightness	= 1
SWEP.OCLightSize		= 50
SWEP.OCLightDecayTime	= 1000

SWEP.Glow			= false
SWEP.GlowColor		= Color(255, 255, 255)
SWEP.GlowBrightness	= 1
SWEP.GlowDecay		= 1000
SWEP.GlowSize		= 150
SWEP.GlowStyle		= 0

SWEP.Secondary.ScopeMat	= "overlays/draconic_scope"
SWEP.Secondary.Q2Mat	= nil
SWEP.Secondary.Q3Mat	= nil
SWEP.Secondary.Q4Mat	= nil
SWEP.Secondary.ScopeBlur = false
SWEP.Secondary.ScopeBGCol = Color(0, 0, 0, 255)
SWEP.Secondary.ScopeScale	= 1
SWEP.Secondary.ScopeWidth	= 1
SWEP.Secondary.ScopeHeight	= 1

SWEP.Secondary.Disabled = false

-- ADDON COMPATIBILITY

SWEP.CanTFALean = true

SWEP.DManip_AllowFL = true

SWEP.vFireLife = 2
SWEP.vFireVolatility = 0.15
SWEP.vFireSpeed = 1
SWEP.vFireSpawnDist = 30
SWEP.vFireStopSound = Sound("draconic.vFireStopGeneric")
SWEP.Primary.isvFire = false
SWEP.Secondary.isvFire = false

-- Everything past this is code for DSB. DO NOT TOUCH IN YOUR WEAPONS.

SWEP.Draconic = true
SWEP.IsOverheated = false
SWEP.SightsDown = false
SWEP.BloomValue = 0
SWEP.PrevBS = 0
SWEP.VariablePos = Vector(0, 0, 0)
SWEP.CRPo = Vector(0, 0, 0)
SWEP.PRPos = Vector(0, 0, 0)
SWEP.SPRPos = Vector(0, 0, 0)
SWEP.IRPos = Vector(0, 0, 0)
SWEP.VARPos = Vector(0, 0, 0)
SWEP.VariableAng = Vector(0, 0, 0)
SWEP.CRPo = Vector(0, 0, 0)
SWEP.PRAng = Vector(0, 0, 0)
SWEP.SPRAng = Vector(0, 0, 0)
SWEP.IRAng = Vector(0, 0, 0)
SWEP.VARAng = Vector(0, 0, 0)
SWEP.Sound = Sound("")
SWEP.DistSound = Sound("")
SWEP.Passive = false
SWEP.Inspecting = false
SWEP.Idle = 0
SWEP.Loading = false
SWEP.ManuallyReloading = false
SWEP.PistolSlide = 1
SWEP.NPCBursting = false
SWEP.NPCCharging = false

function SWEP:DoDrawCrosshair( x, y )
	return true
end

function SWEP:DrawWorldModelTranslucent()
	self:DrawModel()
end

function SWEP:InitialFireMode()
	if self.Primary.Automatic == false then
		self.Weapon:SetNWString("FireMode", "Semi")
	elseif self.Primary.Automatic == true && self.FireModes_CanAuto == true then
		self.Weapon:SetNWString("FireMode", "Auto")
	elseif self.Primary.Automatic == true && self.FireModes_CanBurst == true && self.FireModes_CanAuto == false then
		self.Weapon:SetNWString("FireMode", "Burst")
		self.Primary.Automatic = false
	elseif self.Primary.Automatic == true && self.FireModes_CanBurst == false && self.FireModes_CanAuto == false && self.FireModes_CanSemi == true then
		self.Weapon:SetNWString("FireMode", "Semi")
		self.Primary.Automatic = false
	else 
		self.Weapon:SetNWString("FireMode", "Semi")
	end
end

function SWEP:Initialize()
	local ply = self:GetOwner()
	if !game.SinglePlayer() then self:CallOnClient("Initialize") end
	
	self:SetHoldType(self.HoldType)
	self:SetNWBool("Passive", false)
	self:SetNWBool("Inspecting", false)
	
	if self.Primary.Ammo != nil && self:GetOwner():IsNPC() && !self.IsMelee then
		if self.Primary.Ammo != "CombineHeavyCannon" then
			self.NPCBurstShots = self.Primary.ClipSize * (60 / self.Primary.RPM)
		else
			self.NPCBurstShots = (100 / self.BatteryConsumPerShot) * (60 / self.Primary.RPM)
			print((100 / self.BatteryConsumPerShot) * (60 / self.Primary.RPM))
		end
	end
	
	-- Ivan's Nextbot compatiblity, DO NOT TOUCH OR USE.
	if self.Primary.Ammo != nil && self:GetOwner():IsNextBot() then
		self.Weapon.HoldType_Aim = self.HoldType
		self.Weapon.Primary.Delay = 60 / self.Primary.RPM
		if self.Primary.Ammo != "CombineHeavyCannon" then
			self.BurstLength = self.Primary.ClipSize * (60 / self.Primary.RPM)
			self.NPCBurstShots = self.Primary.ClipSize * (60 / self.Primary.RPM)
		else
			self.BurstLength = (100 / self.BatteryConsumPerShot) * (60 / self.Primary.RPM)
			self.NPCBurstShots = (100 / self.BatteryConsumPerShot) * (60 / self.Primary.RPM)
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
	
	self:DoCustomInitialize()
	self:InitialFireMode()
	
	if self.LoopFireSound == nil && self.Primary.LoopingFireSound != nil then
		self.LoopFireSound = CreateSound(self, self.Primary.LoopingFireSound)
	end
	
	if self.Primary.Ammo != nil then
		self.Weapon:SetNWInt("LoadedAmmo", self.Weapon:Clip1() )
		
	--	if game.SinglePlayer() && CLIENT && self.Primary.TracerEffect != nil then
	--		DRCNotify(self, "hint", "warning", "This weapon uses scripted effects. These do not work in singleplayer. \nPlay your game as a local server to avoid this error.", NOTIFY_ERROR, 10, "buttons/button16.wav")
	--		timer.Simple(10, function() DRCNotify(self, "hint", "notification", "Disable error hints at any time from ''Draconic Base'' in your context menu.", nil, 10) end)
	--	end
	else end
	
	-- SCK Stuff
	if CLIENT && ply then
	
		-- Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )
		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels
		
		if IsValid(ply) && ply:IsPlayer() then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
				-- Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					-- we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					-- ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					-- however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")			
				end
			end
		end
		
	end
end

function SWEP:DoCustomInitialize()
end

FireTime = CurTime()
function SWEP:Think()
	local ply = self:GetOwner()
	local cv = ply:Crouching()
	local vm = ply:GetViewModel()
	local hands = ply:GetHands()

	self:DoCustomThink()

	if self.Loading == false && self.ManuallyReloading == false && self.Inspecting == false && self.IsOverheated == false then
		self:ManageAnims()
	end

	if CLIENT then
		local wl = ply:WaterLevel()
		local oa = self.OwnerActivity
		
		if (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_BACK) or ply:KeyDown(IN_FORWARD)) && cv == false && wl <= 2 then
			if ply:KeyDown(IN_SPEED) then self.OwnerActivity = "sprinting"
			else self.OwnerActivity = "running" end
		elseif (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_BACK) or ply:KeyDown(IN_FORWARD)) && cv == true && wl <= 2 then
			if ply:KeyDown(IN_SPEED) then self.OwnerActivity = "crouchsprinting"
			else self.OwnerActivity = "crouchrunning" end
		elseif (!ply:KeyDown(IN_MOVELEFT) or !ply:KeyDown(IN_MOVERIGHT) or !ply:KeyDown(IN_BACK) or !ply:KeyDown(IN_FORWARD)) && cv == false && wl <= 2 then
			self.OwnerActivity = "standidle"
		elseif (!ply:KeyDown(IN_MOVELEFT) or !ply:KeyDown(IN_MOVERIGHT) or !ply:KeyDown(IN_BACK) or !ply:KeyDown(IN_FORWARD)) && cv == true && wl <= 2 then
			self.OwnerActivity = "crouchidle"
		elseif (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_BACK) or ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_JUMP)) && wl > 2 then
			if ply:KeyDown(IN_SPEED) then self.OwnerActivity = "fastswimming"
			else self.OwnerActivity = "swimming" end
		elseif (!ply:KeyDown(IN_MOVELEFT) or !ply:KeyDown(IN_MOVERIGHT) or !ply:KeyDown(IN_BACK) or !ply:KeyDown(IN_FORWARD)) && wl > 2 then
			self.OwnerActivity = "swimidle"
		end
	end
	
	if self:CanUseSights() && self.Secondary.Ironsights == true && self.IronCD == false && self.Secondary.Disabled == false then
		--if ply:KeyPressed(IN_ATTACK2) == true && self.Weapon:GetNWBool("ironsights") == false && self.Weapon:GetNWBool("Inspecting") == false && self.IronCD == false && self.Passive == false && !ply:KeyDown(IN_USE) then
		if ply:KeyPressed(IN_ATTACK2) == true && self.SightsDown == false && self.Weapon:GetNWBool("Inspecting") == false && self.IronCD == false && self.Passive == false && !ply:KeyDown(IN_USE) then
			self:SetIronsights(true, self.Owner)
			ply:SetFOV(ply:GetFOV() * (self.Secondary.IronFOV / 100), self.Secondary.ScopeZoomTime)
			self:AdjustMouseSensitivity()
			self:IronCoolDown()
			ply:EmitSound("draconic.IronInGeneric")
			if CLIENT && self.Secondary.IronInFP != nil then
				surface.PlaySound(Sound(self.Secondary.IronInFP))
			else end
		--elseif ply:KeyReleased(IN_ATTACK2) == true && self.Weapon:GetNWBool("ironsights") == true && self.IronCD == false && !ply:KeyDown(IN_USE) then
		elseif ply:KeyReleased(IN_ATTACK2) == true && self.SightsDown == true && self.IronCD == false && !ply:KeyDown(IN_USE) then
			self:SetIronsights(false, self.Owner)
			ply:SetFOV(0, self.Secondary.ScopeZoomTime)
			ply:EmitSound("draconic.IronOutGeneric")
			if CLIENT && self.Secondary.IronOutFP != nil then
				surface.PlaySound(Sound(self.Secondary.IronOutFP))
			else end
		end
	elseif self:CanUseSights() && self.Secondary.Ironsights == false or self.IronCD == true or self.Loading == true then
		self:SetIronsights(false, self.Owner)
	end
	
	if CLIENT && self.ScopeUp == false && self.Secondary.Scoped == true then
		self.ScopeUp = true
	elseif CLIENT && self.ScopeUp == true then
		self.ScopeUp = false
	end
	
--	if self.SightsDown == true && self.Secondary.Scoped == true then
--		vm:SetMaterial("models/vuthakral/nodraw")
--		hands:SetMaterial("models/vuthakral/nodraw")
--	else
--		vm:SetMaterial("")
--		hands:SetMaterial("")
--	end

	if self.Primary.UsesCharge == true then
		local m1p = ply:KeyPressed(IN_ATTACK)
		local m1d = ply:KeyDown(IN_ATTACK)
		local m1r = ply:KeyReleased(IN_ATTACK)
		local charge = self.Weapon:GetNWInt("Charge")
		local ukd = ply:KeyDown(IN_USE)
			
		if (SERVER or !game.IsDedicated()) && ply:IsPlayer() then
			if game.SinglePlayer() && !IsFirstTimePredicted() then return end
			if self.ChargeType == "dualheld" then
				if m1r && self:CanPrimaryAttack() == true && !self:CanOvercharge() && !ukd then -- I've learned to stop questioning why shit doesn't work when it should. Namely because when I ask others why I get brushed off or bereated.
					if FireTime < CurTime() then FireTime = CurTime() + 60 / self.Primary.RPM self:CallShoot("primary") end
				elseif m1r && self:CanOvercharge() && self:CanPrimaryAttack() then self:CallShoot("overcharge") end
			elseif self.ChargeType == "dualaction" then
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

	if self.Weapon:GetNWBool("Passive") == true then
		if self.LoopingFireSound != nil then
			self.LoopingFireSound:Stop()
		end
		if self.LoopingFireSoundSecondary != nil then
			self.LoopingFireSoundSecondary:Stop()
		end
	end
	
	if !game.IsDedicated() then
		local oh = self.Weapon:GetNWBool("Overheated")
	
		if self.Primary.UsesCharge == true then
			if ply:KeyPressed(IN_ATTACK) && self.Weapon:GetNWBool("Passive") == false && !ply:KeyDown(IN_USE) && self:CanPrimaryAttack() then
				self:EmitSound(self.ChargeSound)
			elseif !ply:KeyDown(IN_ATTACK) or oh == true then
				self:StopSound(self.ChargeSound)
			else end
		end
	
		if self.Primary.LoopingFireSound != nil then
			if ply:KeyPressed(IN_ATTACK) && self.Weapon:GetNWBool("Passive") == false && !ply:KeyDown(IN_USE) && oh == false && self.Weapon:Clip1() > 0 then
				self:EmitSound(self.Primary.LoopingFireSoundIn)
				-- self:EmitSound(self.Primary.LoopingFireSound)
				self.LoopFireSound:Play()
			else end
			
			if !ply:KeyDown(IN_ATTACK) or oh == true or ply:KeyPressed(IN_USE) then
				--self:StopSound(self.Primary.LoopingFireSound)
				self.LoopFireSound:Stop()
			end

			if self.Weapon:Clip1() > 0 then
			if (ply:KeyReleased(IN_ATTACK) && !ply:KeyDown(IN_USE) && oh == false) or (ply:KeyDown(IN_ATTACK) && oh == false && ply:KeyPressed(IN_USE)) then
				self:EmitSound(self.Primary.LoopingFireSoundOut)
			end end
		end
	end
	
	if self.LoopingFireSound != nil && (self.Primary.isvFire == true or self.Secondary.isvFire == true) then
		if (self.Owner:KeyReleased(IN_ATTACK) && self.Weapon:GetNWBool("Passive") == false || (!self.Owner:KeyDown(IN_ATTACK) && self.LoopingFireSound)) then
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
		if (self.Owner:KeyReleased(IN_ATTACK2) && self.Weapon:GetNWBool("Passive") == false || (!self.Owner:KeyDown(IN_ATTACK2) && self.LoopingFireSoundSecondary)) then
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
		
	if self:CanGunMelee() == true then
		local ht = self:GetHoldType()
		local usekey = ply:KeyDown(IN_USE)
		local attackkey = ply:KeyPressed(IN_ATTACK)

		if usekey && attackkey then
			if ht == "ar2" or ht == "smg" or ht == "crossbow" or ht == "shotgun" or ht == "rpg" or ht == "melee2" or ht == "physgun" then
				self.Owner:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND, true)
			elseif ht == "crowbar" or ht == "pistol" or ht == "revolver" or ht == "grenade" or ht == "slam" or ht == "normal" or ht == "fist" or ht == "knife" or ht == "passive" or ht == "duel" or ht == "magic" or ht == "camera" then
				self.Owner:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE, true)
			end
		end
	else end
	
	if self.Glow == true && CLIENT then
		local RightHand = ply:LookupBone("ValveBiped.Bip01_R_Hand")
		self.glowlight = DynamicLight(self, false)
		if self.glowlight then
			if ply then
				if RightHand != nil then
					self.glowlight.pos = ply:GetBonePosition(RightHand)
				else
					self.glowlight.pos = ply:LocalToWorld(ply:OBBCenter() + Vector(15, -15, 0))
				end
			else
				self.glowlight.pos = self:GetPos()
			end
			self.glowlight.r = self.GlowColor.r
			self.glowlight.g = self.GlowColor.g
			self.glowlight.b = self.GlowColor.b
			self.glowlight.Brightness = self.GlowBrightness
			self.glowlight.Decay = self.GlowDecay
			self.glowlight.Size = self.GlowSize
			self.glowlight.Style = self.GlowStyle
			self.glowlight.DieTime = CurTime()
		end
		
		self.entlight = DynamicLight(self, true)
		if self.entlight then
			if ply then
				if RightHand != nil then
					self.entlight.pos = ply:GetBonePosition(RightHand)
				else
					self.entlight.pos = ply:LocalToWorld(ply:OBBCenter() + Vector(15, -15, 0))
				end
			else
				self.entlight.pos = self:GetPos()
			end
			self.entlight.r = self.GlowColor.r
			self.entlight.g = self.GlowColor.g
			self.entlight.b = self.GlowColor.b
			self.entlight.Brightness = math.abs(self.GlowBrightness / (self.GlowBrightness / 2))
			self.entlight.Decay = self.GlowDecay
			self.entlight.Size = self.GlowSize / 16
			self.entlight.Style = self.GlowStyle
			self.entlight.DieTime = CurTime() + 0.1
		end
	end

	if !game.SinglePlayer() then return end -- I have to set viewmodel poseparameters in here because they're controlled by the server in isngleplayer for some reason, and PreDrawViewModel is client only. Epic.
	if CLIENT then return end
	
	local wep = self
	local slide = self.PistolSlide
	local ammo = wep:Clip1()
	local charge = self.Weapon:GetNWInt("Charge")
	local heat = self:GetNWInt("Heat")
	local health = ply:Health()

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
		
	if self.Primary.Ammo == "CombineHeavyCannon" && vm:GetPoseParameter("drc_heat") != nil then
		vm:SetPoseParameter("drc_heat", self.HeatCL / 100)
	end
		
	if self.Primary.Ammo == "CombineHeavyCannon" && vm:GetPoseParameter("drc_battery") != nil then
		vm:SetPoseParameter("drc_battery", self.AmmoCL / 100)
	end
	
	if vm:GetPoseParameter("drc_health") != nil then
		vm:SetPoseParameter("drc_health", (self.HealthCL / ply:GetMaxHealth()) / 100)
	end
	
	if vm:GetPoseParameter("drc_charge") != nil then			
		vm:SetPoseParameter("drc_charge", self.ChargeCL / 100)
	end
end

function SWEP:CanGunMelee()
	local ply = self:GetOwner()
	--local sights = self.Weapon:GetNWBool("ironsights")
	local sights = self.SightsDown
	local passive = self.Weapon:GetNWBool("Passive")
	
	if self.Primary.CanMelee == false then return false end
	
	if sights == false && passive == false then return true else return false end
end

function SWEP:ManageAnims()
	if !IsFirstTimePredicted() then return end
	local ply = self:GetOwner()
	local vm = ply:GetViewModel()
	local oa = self.OwnerActivity
	local cv = ply:Crouching()
	local slowvar = ply:Crouching() or ply:KeyDown(IN_WALK)
	local walking = (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK)) && !ply:KeyDown(IN_SPEED)
	local sprinting = (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK)) && ply:KeyDown(IN_SPEED)
	
		if self.ManuallyReloading == true or self.Loading == true or self.Idle == 0 then return end
	
		local idleanim = vm:SelectWeightedSequence( ACT_VM_IDLE )
		local walkanim = vm:SelectWeightedSequence( ACT_WALK )
		local sprintanim = vm:SelectWeightedSequence( ACT_RUN )
		local swimidleanim = vm:SelectWeightedSequence( ACT_SWIM_IDLE )
		local swimminganim = vm:SelectWeightedSequence( ACT_SWIM )
		
		local reloadanim = vm:SelectWeightedSequence( ACT_VM_RELOAD )
		local walkanim = vm:SelectWeightedSequence( ACT_WALK )
		
		local anim = vm:GetSequence()
		local animdata = vm:GetSequenceInfo(anim)
		
		if self.SightsDown then
			vm:SendViewModelMatchingSequence(idleanim)
		return end
		
		if slowvar then self.FPAnimMul = 0.5 else self.FPAnimMul = 1 end
		
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

SWEP.MulI = 0
SWEP.MulIns = 0
function SWEP:GetViewModelPosition( pos, ang )
	if SERVER then return end
	
	local ply = self:GetOwner()
	
	if ply:IsWorld() then return end
	
	local vm = ply:GetViewModel()
	local eyeangforward = ply:EyeAngles()
	local passive = self.Weapon:GetNWBool("Passive")
	--local sd = self.Weapon:GetNWBool("ironsights")
	local sd = self.SightsDown
	local cv = ply:Crouching()
	local oa = self.OwnerActivity
	local sk = ply:KeyDown(IN_SPEED)
	local mk = (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK))
	local issprinting = sk && mk
	local diff = Angle(0, 0, 0)
	local OGAng = vm:GetAngles()

	--local ironBool = self.Weapon:GetNWBool( "Ironsights" )
	local ironBool = self.SightsDown
	local passiveBool = self.Weapon:GetNWBool( "Passive" )
	local inspectBool = self.Weapon:GetNWBool( "Inspecting" )
	
	if ironBool == true or (ply:GetCanZoom() == true && ply:KeyDown(IN_ZOOM)) then
		self.LoweredCrossHairMod = Lerp(FrameTime() * 25, self.LoweredCrossHairMod or 1, 0)
	else
		self.LoweredCrossHairMod = Lerp(FrameTime() * 25, self.LoweredCrossHairMod or 0, 1)
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
	
		--[[ PERSPECTIVE OFFSETS ]]--
			--if self.Weapon:GetNWBool("ironsights") == false then
			if self.SightsDown == false then
				local POX = (eyeangforward.x /135)
				local POY = (eyeangforward.x /100 * 5)
				local POZ = (eyeangforward.x / -45)
				local AOX = (eyeangforward.x /30)
				
				self.VAPos = Vector(POX, POY, POZ)
				self.VAAng = Vector(AOX, 0, 0)

				self.VARPos = LerpVector(self.MulI, -self.VMPos + self.IronSightsPos / 255, self.VAPos )
				self.VARAng = LerpVector(self.MulI, Vector(0, 0, 0), self.VAAng )
			else
			
			end
			
			DynaPosLerp = Lerp(FrameTime() * 10, DynaPosLerp or self.VAPos, self.VAPos)
			DynaAngLerp = Lerp(FrameTime() * 10, DynaAngLerp or self.VAAng, self.VAAng)
	
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
				self.IPos = LerpVector( self.MulI, self.VMPos, self.IronSightsPos + self.VMPos)
				self.IRPos = LerpVector( self.MulI, self.VMPos, -self.IronSightsPos + self.VMPos)
			else
				self.IPos = LerpVector( self.MulI, -self.IronSightsPos + self.VMPos, self.VMPos)
				self.IRPos = LerpVector( self.MulI, -self.IronSightsPos - self.VMPos, self.VMPos )
			end
			
			self.IRPosLerp = LerpVector(self.MulI, self.IPos, self.IRPos)
		
			if sd == true then
				self.IAng = LerpVector( self.MulI, self.VMAng, self.IronSightsAng + self.VMAng)
				self.IRAng = LerpVector( self.MulI, self.VMAng, -self.IronSightsAng + self.VMAng)
			else
				self.IAng = LerpVector( self.MulI, -self.IronSightsAng + self.VMAng, self.VMAng)
				self.IRAng = LerpVector( self.MulI, -self.IronSightsAng - self.VMAng, self.VMAng )
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
			if passive == true then
				self:DoPassiveHoldtype()
			elseif inspectBool == true then
				self:DoInspectHoldtype()
				
			else
				if self.Weapon:GetNWBool("Overheated") == true then -- fucking glua wont let me just call either self.Overheated or self.IsOverheated within this function AAAAAAAA
					self:SetHoldType(self.OverheatHoldType)
				elseif self.Weapon:GetNWBool("Venting") == true then
					self:SetHoldType(self.VentingHoldType)
				else
					self:SetHoldType(self.HoldType)
				end
			end
		else
		end
	elseif (oa == "sprinting" or oa =="fastswimming") then
		if self.DoesPassiveSprint == true or GetConVar("sv_drc_force_sprint"):GetString() == "1" then
			self:DoPassiveHoldtype()
		end
	end
	
		self.IronPosLerp = Lerp(FrameTime() * 10, self.IronPosLerp or self.IRPosLerp, self.IRPosLerp)
		self.IronAngLerp = Lerp(FrameTime() * 10, self.IronAngLerp or self.IRAngLerp, self.IRAngLerp)
	
		self.PassivePosLerp = Lerp(FrameTime() * 10, self.PassivePosLerp or self.PRPosLerp, self.PRPosLerp)
		self.PassiveAngLerp = Lerp(FrameTime() * 10, self.PassiveAngLerp or self.PRAngLerp, self.PRAngLerp)
		
		self.InspectPosLerp = Lerp(FrameTime() * 10, self.InspectPosLerp or self.InsRPosLerp, self.InsRPosLerp)
		self.InspectAngLerp = Lerp(FrameTime() * 10, self.InspectAngLerp or self.InsRAngLerp, self.InsRAngLerp)
	
		self.CrouchPosLerp = Lerp(FrameTime() * 10, self.CrouchPosLerp or self.CRPos, self.CRPos)
		self.CrouchAngLerp = Lerp(FrameTime() * 10, self.CrouchAngLerp or self.CRAng, self.CRAng)
	
		self.SprintPosLerp = Lerp(FrameTime() * 10, self.SprintPosLerp or self.SRPosLerp, self.SRPosLerp)
		self.SprintAngLerp = Lerp(FrameTime() * 10, self.SprintAngLerp or self.SRAngLerp, self.SRAngLerp)
		
		local DrcGlobalVMOffset = Vector(GetConVar("cl_drc_vmoffset_x"):GetFloat(), GetConVar("cl_drc_vmoffset_y"):GetFloat(), GetConVar("cl_drc_vmoffset_z"):GetFloat())
	
	if (self.DoesPassiveSprint == true or GetConVar("sv_drc_force_sprint"):GetString() == "1") then
		self.VariablePos=( self.VMPos - (self.VMPos - self.CrouchPosLerp) + (self.VMPos - self.PassivePosLerp) + (self.VMPos - self.InspectPosLerp) + (self.VMPos - self.SprintPosLerp) + (self.VMPos - self.IronPosLerp) ) + self.VARPos + DrcGlobalVMOffset
		self.VariableAng=( self.VMAng - (self.VMAng - self.CrouchAngLerp) + (self.VMAng - self.PassiveAngLerp) + (self.VMAng - self.InspectAngLerp) + (self.VMAng - self.SprintAngLerp) + (self.VMAng - self.IronAngLerp) ) + self.VARAng
	else
		self.VariablePos=( self.VMPos - (self.VMPos - self.CrouchPosLerp) + (self.VMPos - self.PassivePosLerp) + (self.VMPos - self.InspectPosLerp) + (self.VMPos - self.IronPosLerp) ) + self.VARPos + DrcGlobalVMOffset
		self.VariableAng=( self.VMAng - (self.VMAng - self.CrouchAngLerp) + (self.VMAng - self.PassiveAngLerp) + (self.VMAng - self.InspectAngLerp) + (self.VMAng - self.IronAngLerp) ) + self.VARAng
	end
	
		VariablePosLerp = Lerp(FrameTime() * 10, VariablePosLerp or self.VariablePos, self.VariablePos)
		VariableAngLerp = Lerp(FrameTime() * 10, VariableAngLerp or self.VariableAng, self.VariableAng)

	--if self.Weapon:GetNWBool("Passive") == false && self.Weapon:GetNWBool("ironsights") == false then
	if self.Weapon:GetNWBool("Passive") == false && self.SightsDown == false then
		self.CurPos = self.VariablePos
		self.CurAng = self.VariableAng
		self.Action = "idle"

		pos = pos + (ang:Right() * self.CurPos.x)
		pos = pos + (ang:Forward() * self.CurPos.y)
		pos = pos + (ang:Up() * self.CurPos.z)
		ang:RotateAroundAxis(ang:Right(), self.CurAng.x)
		ang:RotateAroundAxis(ang:Up(), self.CurAng.y)
		ang:RotateAroundAxis(ang:Forward(), self.CurAng.z)

		self.SwayScale = self.SS
		self.BobScale = self.BS
	--elseif self.Weapon:GetNWBool("Passive") == true && self.Weapon:GetNWBool("ironsights") == false then
	elseif self.Weapon:GetNWBool("Passive") == true && self.SightsDown == false then
		self.CurPos = self.VariablePos
		self.CurAng = self.VariableAng
		self.Action = "passive"
	
		pos = pos + (ang:Right() * self.CurPos.x)
		pos = pos + (ang:Forward() * self.CurPos.y)
		pos = pos + (ang:Up() * self.CurPos.z)
		ang:RotateAroundAxis(ang:Right(), self.CurAng.x)
		ang:RotateAroundAxis(ang:Up(), self.CurAng.y)
		ang:RotateAroundAxis(ang:Forward(), self.CurAng.z)
		
		self.SwayScale = self.SS
		self.BobScale = self.BS
	--elseif self.Weapon:GetNWBool("ironsights") == true && self.Secondary.Scoped == false && self.Weapon:GetNWBool("Passive") == false then
	elseif self.SightsDown == true && self.Secondary.Scoped == false && self.Weapon:GetNWBool("Passive") == false then
		self.CurPos = LerpVector( self.MulI, self.VariablePos, self.IronSightsPos)
		self.CurAng = LerpVector( self.MulI, self.VariableAng, self.IronSightsAng)
		self.Action = "ironsight"

		ang:RotateAroundAxis(ang:Right(), self.CurAng.x)
		ang:RotateAroundAxis(ang:Up(), self.CurAng.y)
		ang:RotateAroundAxis(ang:Forward(), self.CurAng.z)
		pos = pos + (self.CurPos.x) * ang:Right()
		pos = pos + (self.CurPos.y) * ang:Forward()
		pos = pos + (self.CurPos.z) * ang:Up()
	
		self.SwayScale 	= 0.3
		self.BobScale 	= 0.1
	--elseif self.Weapon:GetNWBool("ironsights") == true && self.Secondary.Scoped == true && self.Weapon:GetNWBool("Passive") == false then
	elseif self.SightsDown == true && self.Secondary.Scoped == true && self.Weapon:GetNWBool("Passive") == false then
		self.CurPos = LerpVector( self.MulI, self.VariablePos, self.IronSightsPos)
		self.CurAng = LerpVector( self.MulI, self.VariableAng, self.IronSightsAng)
		self.Action = "ironsight"

		ang:RotateAroundAxis(ang:Right(), self.CurAng.x)
		ang:RotateAroundAxis(ang:Up(), self.CurAng.y)
		ang:RotateAroundAxis(ang:Forward(), self.CurAng.z)
		pos = pos + (self.CurPos.x) * ang:Right()
		pos = pos + (self.CurPos.y) * ang:Forward()
		pos = pos + (self.CurPos.z) * ang:Up()
	
		self.SwayScale 	= 0
		self.BobScale 	= 0
	end

	self.InfoLastPos = pos
	self.InfoLastAng = ang
	
	if GetConVar("cl_drc_lowered_crosshair"):GetFloat() == 1 then
		return (pos + Vector(0, 0, 0.5) * self.LoweredCrossHairMod) + self.LoweredVMPos, (ang + Angle(-5, 0, 0) * self.LoweredCrossHairMod) + Angle(self.LoweredVMAng.x, self.LoweredVMAng.y, self.LoweredVMAng.z)
	else
		return pos, ang
	end
end

function SWEP:Reload()
end

function SWEP:Deploy()
	local ply = self:GetOwner()
	local cv = ply:Crouching()
	local vm = ply:GetViewModel()
	local drawanim = vm:SelectWeightedSequence( ACT_VM_DRAW )
	local drawanimdur = vm:SequenceDuration(drawanim)
	vm:SetPlaybackRate( 1 )
	self:SetIronsights(false)
	self.SightsDown = false
	
	self.DManip_PlyID = "DRC_DManip_" ..ply:Name().. ""
	
	self.Idle = 0
	self.IsTaunting = 0
	self.Inspecting = false
	self.EmptyReload = 0
	self.ManuallyReloading 	= false
	self.Loading			= false
	
	timer.Simple(drawanimdur, function() self.Idle = 1 end)
	
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	ply:StartLoopingSound(self.WeaponIdleLoopSound)
	self.IdleTimer = CurTime() + drawanimdur

	if self.Passive == true then
		self:DoPassiveHoldtype()
	else
		self:SetHoldType( self.HoldType )
	end

--	self.Weapon:SetNWBool( "Ironsights", false )
	self.Weapon:SetNWInt( "Charge", 0 )
	
	if not IsValid(self) or not IsValid(ply) or not ply:Alive() then else
		self:GetMovementValues()
	end
	
	if self.Primary.Ammo != nil then
		self.Weapon:SetNWInt("LoadedAmmo", self.Weapon:Clip1() )
	else end

	self:SetNextPrimaryFire( CurTime() + drawanimdur)
	self:SetNextSecondaryFire( CurTime() + drawanimdur)
	
	if self.HealthRegen == true then self:RegeneratingHealth(ply) end
	if self.RegenAmmo == true then self:RegeneratingAmmo(self) end
	if self.SpecialScripted != true then
		self:BloomScore()
		if game.SinglePlayer() then self:CallOnClient( "BloomScore") end
	end

	if self.Primary.Ammo == "CombineHeavyCannon" then
		self.Weapon:SetNWFloat("HeatDispersePower", 1)
		self:DisperseHeat()
	else end
	
	if self.Primary.UsesCharge == true or self.Secondary.UsesCharge == true then
		self:DisperseCharge()
	else end

	self:DoCustomDeploy()
return true
end

function SWEP:DoCustomDeploy()
end

function SWEP:OnRemove()
	local ply = self:GetOwner()
	self.IdleTimer = CurTime()
	self.Owner.ShouldReduceFallDamage = false

	self:DoCustomRemove()

	if ( SERVER ) then
	if ply:IsPlayer() then
--		hook.Remove( "Move", self.Weapon.HookUID_1 )
--		hook.Remove( "Move", self.Weapon.HookUID_2 )
--		hook.Remove( "Move", self.Weapon.HookUID_3 )
--		hook.Remove( "Move", self.Weapon.HookUID_4 )
		hook.Remove( "DManipPlayerSwitchFlashlight","DManip_PlyID" )
		
		timer.Remove( self.PassiveHealing )
		timer.Remove( self.BreathCycle )
		timer.Remove( self.AmmoRegen )
		if self.BloomScoreName != nil then
			timer.Remove( self.BloomScoreName )
		else end
		if self.Primary.Ammo == "CombineHeavyCannon" then
			timer.Remove( self.HeatDisperseTimer )
		else end
		if self.Primary.UsesCharge == true or self.Secondary.UsesCharge == true then
			timer.Remove( self.ChargeDisperseTimer )
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
	
	if self.Primary.Ammo == "CombineHeavyCannon" then
		local ventingsound = self.VentingSound
		self.Weapon:StopSound(ventingsound)
	end
	
	-- SCK
	self:Holster()
end

function SWEP:DoCustomRemove()
end

function SWEP:Holster()
self.IdleTimer = CurTime()
self.Owner.ShouldReduceFallDamage = false

	self:DoCustomHolster()
	--self.Weapon:SetNWBool("Ironsights", false )
	self.SightsDown = false
	
	if ( SERVER ) then
	local ply = self:GetOwner()
	if ply:IsPlayer() then
		ply:StopLoopingSound( 0 )
--		hook.Remove( "Move", self.Weapon.HookUID_1 )
--		hook.Remove( "Move", self.Weapon.HookUID_2 )
--		hook.Remove( "Move", self.Weapon.HookUID_3 )
--		hook.Remove( "Move", self.Weapon.HookUID_4 )
		hook.Remove( "DManipPlayerSwitchFlashlight","DManip_PlyID" )
		
		timer.Remove( self.PassiveHealing )
		timer.Remove( self.BreathCycle )
		timer.Remove( self.AmmoRegen )
		if self.BloomScoreName != nil then
			timer.Remove( self.BloomScoreName )
		else end
		if self.Primary.Ammo == "CombineHeavyCannon" then
			timer.Remove( self.HeatDisperseTimer )
		else end
		if self.Primary.UsesCharge == true or self.Secondary.UsesCharge == true then
			timer.Remove( self.ChargeDisperseTimer )
		else end
		
		if self.ChargeSound != nil then self:StopSound(self.ChargeSound) end
		if self.Primary.LoopingFireSound != nil then self:StopSound(self.Primary.LoopingFireSound) end
		if self.LoopFireSound != nil then self.LoopFireSound:Stop() end
		
		self:RestoreMovement()
	else end
	end

	if self.Primary.Ammo == "CombineHeavyCannon" then
		local ventingsound = self.VentingSound
		self.Weapon:StopSound(ventingsound)
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

local function ReduceFallDamage(ent, dmginfo)
	if ent:IsPlayer() and ent.ShouldReduceFallDamage and dmginfo:IsFallDamage() then
		dmginfo:SetDamage(0)
	end
end

function SWEP:Inspect()
	self.Inspecting = true
	if game.SinglePlayer() && !IsFirstTimePredicted() then return end
	local inspectanim = self:SelectWeightedSequence(ACT_VM_FIDGET)
	local inspectdur = self:SequenceDuration(inspectanim)
	
	self.Weapon:SendWeaponAnim(ACT_VM_FIDGET)
	
	self.IdleTimer = CurTime() + inspectdur
	
	timer.Simple( inspectdur, function() self:EnableInspection() end)
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
	
	self:PrintWeaponInfo( x + wide, y, alpha )
end

function SWEP:PrintWeaponInfo( x, y, alpha )

	if ( self.DrawWeaponInfoBox == false ) then return end
	
	if (self.InfoMarkup == nil ) then
		local str
		local title_color = "<color=0,200,255,255>"
		local text_color = "<color=150,150,150,255>"
		
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
	--if self.Weapon:GetNWBool("ironsights") == true then
	if self.SightsDown == true then
		return self:GetOwner():GetFOV() / 100
	--elseif self.Weapon:GetNWBool("ironsights") == false then
	elseif self.SightsDown == false then
		return 1
	end
end

function SWEP:CanUseSights()
	local oh = self.Weapon:GetNWBool("Overheated")
	
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
--	self.Weapon:SetNWBool("Ironsights", b )
--	self.Weapon:SetNWBool("ironsights", b )
	self.SightsDown = b
	
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
end

function SWEP:DoPassiveHoldtype()
	if self.HoldType == "pistol" or self.HoldType == "revolver" or self.HoldType == "magic" or self.HoldType == "knife" or self.HoldType == "melee" or self.HoldType == "melee2" or self.HoldType == "slam" or self.HoldType == "fist" or self.HoldType == "grenade" or self.HoldType == "duel" then
		self:SetHoldType("normal")
	elseif self.HoldType == "smg" or self.HoldType == "ar2" or self.HoldType == "rpg" or self.HoldType == "crossbow" or self.HoldType == "shotgun" or self.HoldType == "physgun" then
		self:SetHoldType("passive")
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

function SWEP:SetupDataTables()
	self:SetNWInt("Heat", 0)
	self:SetNWInt("Charge", 0)
	self:SetNWBool("Passive", false)
	self:SetNWBool("Inspecting", false)
	
	self.PrimaryStats = {
		Damage = self.Primary.Damage,
		Projectile = self.Primary.Projectile,
		ProjSpeed = self.Primary.ProjSpeed,
		ProjInheritVelocity = self.Primary.ProjInheritVelocity,
		NumShots = self.Primary.NumShots,
		IronRecoilMul = self.Primary.IronRecoilMul,
		Spread = self.Primary.Spread,
		SpreadDiv = self.Primary.SpreadDiv,
		Kick = self.Primary.Kick,
		KickHoriz = self.Primary.KickHoriz,
		RecoilUp = self.Primary.RecoilUp,
		RecoilDown = self.Primary.RecoilDown,
		RecoilHoriz = self.Primary.RecoilHoriz,
		Force = self.Primary.Force,
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
		SoundDistance = self.Primary.SoundDistance
	}
	
	self.SecondaryStats = {
		Damage = self.Secondary.Damage,
		Projectile = self.Secondary.Projectile,
		ProjSpeed = self.Secondary.ProjSpeed,
		ProjInheritVelocity = self.Secondary.ProjInheritVelocity,
		NumShots = self.Secondary.NumShots,
		IronRecoilMul = self.Secondary.IronRecoilMul,
		Spread = self.Secondary.Spread,
		SpreadDiv = self.Secondary.SpreadDiv,
		Kick = self.Secondary.Kick,
		KickHoriz = self.Secondary.KickHoriz,
		RecoilUp = self.Secondary.RecoilUp,
		RecoilDown = self.Secondary.RecoilDown,
		RecoilHoriz = self.Secondary.RecoilHoriz,
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
		SoundDistance = self.Secondary.SoundDistance
	}
	
self.OCStats = {
		Damage = self.OCDamage,
		Projectile = self.OCProjectile,
		ProjSpeed = self.OCProjSpeed,
		ProjInheritVelocity = self.OCProjInheritVelocity,
		NumShots = self.OCNumShots,
		IronRecoilMul = self.OCIronRecoilMul,
		Spread = self.OCSpread,
		SpreadDiv = self.OCSpreadDiv,
		Kick = self.OCKick,
		KickHoriz = self.OCKickHoriz,
		RecoilUp = self.OCRecoilUp,
		RecoilDown = self.OCRecoilDown,
		RecoilHoriz = self.OCRecoilHoriz,
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
		BatteryConsumPerShot = self.BatteryConsumPerShot,
		OCBatteryConsumPerShot = self.OCBatteryConsumPerShot
	}
end

function SWEP:GetNPCBurstSettings()
	local ply = self:GetOwner()
	if self.IsMelee then return end
--	if ply.IsVJBaseSNPC != nil then return end
	if self.NPCBursting == true then return end
	
	if ply:IsPlayer() then return end
	
	local burst = self.NPCBurstShots
	local rpm = self.Primary.RPM
	local fm = self.Weapon:GetNWString("FireMode")
	
	if (ply:IsNPC() or ply:IsNextBot()) && self.FireModes_CanBurst == true then
		self.Weapon:SetNWString("FireMode", "Burst")
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
	
--	print("Min: ".. math.Round(mini) .." | Max: ".. math.Round(maxi) .." | Delay: ".. delay .." | RNG'd Burst Length: ".. burstlength .."")
	
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
	--if not self.Weapon:GetNWBool("ironsights") == true && self.Secondary.Scoped == true then return end
	if not self.SightsDown == true && self.Secondary.Scoped == true then return end
	self:DrawCustom2DScopeElements()
end

function SWEP:PreDrawViewModel(vm, wep, ply)
	if game.SinglePlayer() then return end -- Find the singleplayer compatible version inside of Think() because why.
	 -- Thank you Yurie holy fuck why are lerps so mean to me
	
	local ammo = wep:Clip1()
	local slide = self.PistolSlide
	local charge = self.Weapon:GetNWInt("Charge")
	local heat = self:GetNWInt("Heat")
	local health = ply:Health()
	
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
	
	if self.Primary.Ammo == "CombineHeavyCannon" && vm:GetPoseParameter("drc_heat") != nil then
		vm:SetPoseParameter("drc_heat", self.HeatCL / 100)
	end
	
	if self.Primary.Ammo == "CombineHeavyCannon" && vm:GetPoseParameter("drc_battery") != nil then
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

function SWEP:OnReloadad()
	self:SetHoldType(self.HoldType)
end

function SWEP:ShootEffects()
end

-- VJ Base Compatibility

function SWEP:SetupVJSupport()
	local ply = self:GetOwner()
	self.WorldModel_UseCustomPosition = true -- yeah no, I'll worry about this another time.
	self.IsVJBaseWeapon = true

	if self.IsMelee == true then
		self.IsMeleeWeapon = true
	else
		self.IsMeleeWeapon = false
	end

	-- NPC
	self.NPC_NextPrimaryFire = 0.1
	self.NPC_StandingOnly = false
	self.NPC_FiringDistanceScale = 1
	self.NPC_BeforeFireSound = {}
	self.NPC_BeforeFireSoundLevel = 70
	self.NPC_BeforeFireSoundPitch = VJ_Set(90, 100)
	
	hook.Add("Think", self, self.NPC_ServerNextFire)
end

-- SCK
if CLIENT then
	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		
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
		
		if ply:IsPlayer() or ply:IsNPC() && self.Owner == ply then
			if self.Owner != ply then return end
			local ammo = Entity(ent):Clip1()
			local slide = self.PistolSlide
			local charge = self:GetNWInt("Charge")
			local heat = Entity(ent):GetNWInt("Heat")
			local health = ply:Health()

			self.AmmoCL_TP = Lerp(FrameTime() * 5, self.AmmoCL_TP or ammo, ammo)
			self.ChargeCL_TP = Lerp(FrameTime() * 9, self.ChargeCL_TP or charge, charge)
			self.HeatCL_TP = Lerp(FrameTime() * 9, self.HeatCL_TP or heat, heat)
			self.HealthCL_TP = Lerp(FrameTime() * 9, self.HealthCL_TP or health, health)
			
			if slide <= 0 then
				self.EmptyMagCL_TP = Lerp(FrameTime() * 50, self.EmptyMagCL or slide, 0)
			else
				self.EmptyMagCL_TP = Lerp(FrameTime() * 50, self.EmptyMagCL or slide, 1)
			end
			
			if self.Primary.Ammo != nil && self:GetPoseParameter("drc_ammo") != nil then
				self:SetPoseParameter("drc_ammo", self.AmmoCL_TP / self.Primary.ClipSize)
			end
			
			if self.Primary.Ammo != nil && self:GetPoseParameter("drc_emptymag") != nil then
				self:SetPoseParameter("drc_emptymag", self.EmptyMagCL_TP)
			end
			
			if self.Primary.Ammo == "CombineHeavyCannon" && self:GetPoseParameter("drc_heat") != nil then
				self:SetPoseParameter("drc_heat", self.HeatCL_TP / 100)
			end
			
			if self.Primary.Ammo == "CombineHeavyCannon" && self:GetPoseParameter("drc_battery") != nil then
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

function SWEP:Precache()	
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