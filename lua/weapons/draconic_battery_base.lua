SWEP.Base				= "draconic_gun_base"

--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

SWEP.Category			= "Draconic"
SWEP.PrintName			= "Draconic Battery Base"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Slot				= 0
SWEP.SlotPos			= 0

SWEP.ViewModelFOV		= 54
SWEP.ViewModelFlip		= false

SWEP.ViewModel = ""
SWEP.WorldModel = ""
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.IronSightPos = Vector(0, 0, 0)
SWEP.IronSightAng = Vector(0, 0, 0)
SWEP.SS = 0
SWEP.BS = 0

SWEP.InfAmmo				= false

SWEP.HPS						= 6
SWEP.OverHeatFinishPercent		= 0.17
SWEP.DisperseHeatPassively 		= true
SWEP.HeatLossInterval			= 0.1
SWEP.HeatLossPerInterval		= 1
SWEP.DoOverheatDamage			= false
SWEP.OverheatDamagePerInt		= 0
SWEP.OverheatHoldType			= "knife"
SWEP.OverheatStrength			= 3
SWEP.VentingHoldType			= "slam"
SWEP.VentingStrength			= 4
SWEP.CanOverheat				= true
SWEP.CanVent					= false
SWEP.LowerRPMWithHeat			= true
SWEP.HeatRPMAlterThreshold		= 0
SWEP.HeatRPMAlterThresholdMax	= 100
SWEP.HeatRPMmin					= 120
SWEP.DoOverheatAnimation		= true
SWEP.DoVentingAnimation			= true
SWEP.DoOverheatSound			= true
SWEP.DoVentingSound				= true
SWEP.OverheatSound				= Sound("draconic.OverheatGeneric")
SWEP.VentingSound				= Sound("draconic.VentGeneric")
SWEP.VentingStartSound			= Sound("draconic.VentOpenGeneric")
SWEP.VentingStopSound			= Sound("draconic.VentCloseGeneric")
SWEP.BatteryConsumePerShot		= 0.5

SWEP.BatteryFromVec	= Vector(255, 255, 255)
SWEP.BatteryToVec		= Vector(255, 10, 0)

SWEP.LoadAfterShot 			= false
SWEP.LoadAfterReloadEmpty	= false
SWEP.ManualReload			= false

SWEP.Primary.IronRecoilMul	= 0.5
SWEP.Primary.Spread			= 1
SWEP.Primary.SpreadDiv		= 90
SWEP.Primary.Force			= 0
SWEP.Primary.Damage			= 1
SWEP.Primary.Automatic		= true
SWEP.Primary.RPM			= 857
SWEP.Primary.Tracer			= 1
SWEP.Primary.TracerEffect	= ""
SWEP.Primary.Sound			= Sound("draconic.PewPew")

SWEP.Secondary.Ironsights	= false
SWEP.Secondary.Scoped		= false
SWEP.Secondary.ScopeMat		= "overlays/draconic_scope"
SWEP.Secondary.IronFOV		= 60

SWEP.Secondary.NumShots 		= 1
SWEP.Secondary.Spread			= 3.5
SWEP.Secondary.SpreadDiv		= 100
SWEP.Secondary.Kick				= 0.5
SWEP.Secondary.RecoilUp			= 0
SWEP.Secondary.RecoilDown		= 0
SWEP.Secondary.RecoilHoriz		= 0
SWEP.Secondary.Force			= 0.2
SWEP.Secondary.Damage			= 12
SWEP.Secondary.Ammo				= "none"
SWEP.Secondary.Automatic		= false
SWEP.Secondary.RPM				= 444
SWEP.Secondary.ClipSize			= 18
SWEP.Secondary.DefaultClip		= 18
SWEP.Secondary.APS				= 1
SWEP.Secondary.Tracer			= "Tracer"
SWEP.Primary.EmptySound		= Sound("draconic.BatteryDepleted")
SWEP.Secondary.Sound = Sound("")

-- Settings for NPCs
SWEP.NPCBurstShots = 0
SWEP.JackalSniper = false

-- the DO NOT TOUCH zone
SWEP.Primary.Ammo 			= "ammo_drc_battery"
SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 100
SWEP.VentHeld 				= false
SWEP.IsOverheated			= false
SWEP.IsBatteryBased			= true
SWEP.IsMelee = false

function SWEP:CanPrimaryAttack()
	local ply = self:GetOwner()
	local sk, mk, issprinting = nil, nil
	if !ply:IsNextBot() then if ply:GetActiveWeapon() != self then return false end end
	if ply:IsPlayer() then
		sk = ply:KeyDown(IN_SPEED)
		mk = (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK))
		issprinting = sk && mk
	end
	local wl = ply:WaterLevel()
	
	if self.Secondary.UsesCharge == true && ply:KeyDown(IN_ATTACK2) then return end

	if self:GetNextPrimaryFire() > CurTime() then return false end
	if self.IsOverheated == true then return false end
	if self:GetNWBool("Overheated") == true then return false end

	if GetConVar("sv_drc_infiniteammo"):GetFloat() < 1 then
	if ply:IsPlayer() then
		if ply:GetAmmoCount(self.Primary.Ammo) >= 100 && self:GetNWInt("LoadedAmmo") >= 0.01 && self.CanOverheat == true && self.InfAmmo == false then
			self:Overheat(false, nil, true)
			ply:SetFOV(0, 0.05)
			return false
		elseif ply:GetAmmoCount(self.Primary.Ammo) >= 100 && self:GetNWInt("LoadedAmmo") >= 0.01 && self.CanOverheat == false && self.InfAmmo == false then
			ply:SetFOV(0, 0.05)
			return true
		elseif self:GetNWInt("LoadedAmmo") < 0.01 && self.InfAmmo == false then
			self:EmitSound ( self.Primary.EmptySound )
			self:SetNextPrimaryFire (( CurTime() + 0.3 ))
			return false
		elseif ply:GetAmmoCount(self.Primary.Ammo) >= 100 && eself:GetNWInt("LoadedAmmo") >= 0.01 && self.CanOverheat == true && self.InfAmmo == true then
			self:Overheat(false, nil, true)
			ply:SetFOV(0, 0.05)
			return false
		elseif ply:GetAmmoCount(self.Primary.Ammo) >= 100 && self:GetNWInt("LoadedAmmo") >= 0.01 && self.CanOverheat == false && self.InfAmmo == true then
			ply:SetFOV(0, 0.05)
			return true
		elseif self:GetNWInt("LoadedAmmo") <= 0.01 && self.InfAmmo == true && self.Loading == false && self.ManuallyReloading == false then
			self:SetNextPrimaryFire (( CurTime() + 0.3 ))
			return true
		end
	else
		local heat = self:GetHeat()
		if heat >= 100 then
			self:Overheat(false, nil, true)
			return false
		end
	end
	end
	
	if self:GetNWBool("Inspecting") == true then
		return false
	end
	
	if self:GetNWBool("Passive") == true then
		self:TogglePassive()
		self:SetNextPrimaryFire(CurTime() + 0.3)
		return false
	end
	
	if self.Loading == true or self.ManuallyReloading == true or self.SecondaryAttacking == true or self.Passive == true or self:GetNWBool("Passive") == true or self:GetNWBool("Inspecting") or ((self.DoesPassiveSprint == true or GetConVar("sv_drc_force_sprint"):GetString() == "1") && issprinting) or (self.Primary.CanFireUnderwater == false && wl >= 3) or (self.Overheated == true or self.IsOverheated == true) then
		return false
	else 
		return true
	end
end

function SWEP:CanPrimaryAttackNPC()
	if !SERVER then return end
	local npc = self:GetOwner()
	
	if self:Clip1() <= 0 then -- Prevent NPCs from running out of ammo
		self:SetNWInt("LoadedAmmo", math.Round(math.Clamp(math.Rand(self.BatteryConsumePerShot, self.BatteryConsumePerShot * 10)/10, 0, 100)) * 10)
		self:SetClip1(self:GetNWInt("LoadedAmmo"))
	end
	
	if self:Clip1() <= 0 or npc:GetActivity() == ACT_RELOAD or self:GetNWBool("NPCLoading") == true then
		self:LoadNextShot()
		return false
	end
	if !npc:IsNextBot() then npc:SetSchedule(SCHED_RANGE_ATTACK1) end
	return true
end

function SWEP:Reload()
	if !IsValid(self:GetOwner()) then return end
	local ply = self:GetOwner()
	if !ply:IsPlayer() then
		self:SetNWInt("LoadedAmmo", 100)
		self:SetClip1(self:GetNWInt("LoadedAmmo"))
	return end
	local usekey = ply:KeyDown(IN_USE)
	local reloadkey = ply:KeyDown(IN_RELOAD)
	local walkkey = ply:KeyDown(IN_WALK)
	local sprintkey = ply:KeyDown(IN_SPEED)
	local ventingsound = self.VentingSound

	local reloadkeypressed = ply:KeyPressed(IN_RELOAD)

	if not IsFirstTimePredicted() then return end

	if usekey && reloadkeypressed then
		if sprintkey then
			self:ToggleInspectMode()
		elseif self.Inspecting == false then
			self:Inspect()
		elseif self.Inspect == true then end
	elseif walkkey && reloadkey && self.IsTaunting == 0 then
		self:Taunt()
		elseif walkkey && reloadkey && self.IsTaunting == 1 then
		self:SetHoldType(self.VentingHoldType)
	elseif reloadkey && !sprintkey && self.ManuallyReloading == false && self.CanVent == true && ( self:Clip1() < self.Primary.ClipSize ) then
			if ( self:Clip1() < self.Primary.ClipSize ) && self:Ammo1() > 0 then
				if self.DoVentingSound == true then
					local ventstart = self.VentingStartSound
					self:EmitSound(ventstart)
				else end
				self:SetHoldType(self.VentingHoldType)
				self:Vent()
				ply:SetFOV(0, 0.05)
				--self:SetNWBool( "Ironsights", false )
				self.SightsDown = false
				if self.DoVentingSound == true then
					self:EmitSound(ventingsound)
				else end
				return true
			elseif ( self:Clip1() < self.Primary.ClipSize ) && self:Ammo1() > 1 then
			end
	elseif reloadkey && sprintkey && self.ManuallyReloading == false && self.Loading == false && ( self:Clip2() < self.Secondary.ClipSize ) && ply:GetAmmoCount(self.Secondary.Ammo) > 0 then
		if ( ply:GetAmmoCount(self.Secondary.Ammo) ) <= 0 then
		else
			self:SetHoldType(self.Secondary.ReloadHoldType)
			ply:SetFOV(0, 0.05)
			self:ReloadSecondary()
		end
	end
end

function SWEP:Vent()
	local ply = self:GetOwner()
	local loopseq = self:SelectWeightedSequence( ACT_SHOTGUN_RELOAD_START )
	local looptime = self:SequenceDuration( loopseq )
	local vm = ply:GetViewModel()
	
	vm:SetPlaybackRate( 1 )
	
	self.ManuallyReloading = true
	self:SetNWFloat("HeatDispersePower", self.VentingStrength)
	self:SetNWBool("Venting", true)
	self:SetIronsights(false, self.Owner)
	
	self:DoCustomVentEvents()

	if CLIENT or SERVER && self.DoVentingAnimation == true && self.VentHeld == false then
	self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
	else end
	
	self.BloomValue = 1
	timer.Simple( looptime, function() self:VentHold() end)
end

function SWEP:VentHold()
	self.VentHeld = true

	local ply = self:GetOwner()
	if self.DoVentingAnimation == true then self:SendWeaponAnim(ACT_VM_RELOAD) end
	if self:Clip1() <= self.Primary.ClipSize then
		if ply:KeyDown(IN_RELOAD) && ply:GetAmmoCount("ammo_drc_battery") > 0 then
			self:Vent()
			self:DoCustomVentHoldEvents()
		else
			self:FinishVent()
		end
	end
end

function SWEP:FinishVent()
	local ply = self:GetOwner()
	local loopseq = self:SelectWeightedSequence( ACT_SHOTGUN_RELOAD_FINISH )
	local looptime = self:SequenceDuration( loopseq )
	local ventingsound = self.VentingSound
	local ventingend = self.VentingStopSound
	
	if !ply:IsPlayer() then self:SetHeat(0) end
	if !IsValid(self) or !IsValid(ply) or ply:Health() < 0.01 then return end
	
	self:SetHoldType( self.HoldType )
	self:StopSound(ventingsound)
	self:EmitSound(ventingend)
	self.VentHeld = false
	self:DoCustomFinishVentEvents()
	
	if self.DoVentingAnimation == true && self.IsOverheated == false then
		self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
	elseif self.IsOverheated == true && self.DoOverheatAnimation == true then
		self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
	else end
	self.BloomValue = 0.25
	self:SetNWFloat("HeatDispersePower", 1)
	
	timer.Simple( looptime, function()
		if !IsValid(self) or !IsValid(ply) or ply:Health() < 0.01 then return end
		self.Idle = 1
		self.ManuallyReloading = false
		self.IsOverheated = false
		self.IronCD = false	
		self:SetNWBool("Overheated", false)
		self:SetNWBool("Venting", false)
		self:SetNWBool("NPCLoading", false)
	end)
	timer.Simple( looptime, function() if !IsValid(self) or !IsValid(ply) or ply:Health() < 0.01 then return end self:ManuallyLoadAfterReload() end)
	self.IdleTimer = CurTime() + looptime
end

function SWEP:Overheat(scripted, cooldown, animate)
	if self.OverheatScripted == true && scripted != true then return end
	if !IsValid(self) then return end
	if GetConVar("sv_drc_infiniteammo"):GetFloat() > 1 then return end
	local ply = self:GetOwner()
	local loopseq = self:SelectWeightedSequence( ACT_SHOTGUN_RELOAD_START )
	local looptime = self:SequenceDuration( loopseq )
	self.Idle = 0
	self.ManuallyReloading = true
	self.IsOverheated = true
	self:SetIronsights(false, self.Owner)
	
	
	local gesture = ply:SelectWeightedSequence(ACT_VM_IRECOIL2)
	if gesture != -1 then DRC:CallGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_VM_IRECOIL2, true) end
	self:SetHoldType(self.OverheatHoldType)
	
	if ply:IsPlayer() then ply:SetFOV(0, 0.05) end	
	if self:Clip1() <= 0 && self.InfAmmo == false then
		self:SetNextPrimaryFire (( CurTime() + (60 / self.Primary.RPM) ) * (self:GetHeat() * 0.1))
		return false
	elseif self:Clip1() <= 0 && self.InfAmmo == true then
		self:SetNWFloat("HeatDispersePower", self.OverheatStrength)
		self:SetNWBool("Overheated", true)
		if CLIENT or SERVER && self.DoOverheatAnimation == true then
			self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
		else end
		if self.DoOverheatSound == true then
			local overheatsound = self.OverheatSound
			self:EmitSound(overheatsound)
			
			if self.Primary.LoopingFireSound != nil then
				self:EmitSound(self.Primary.LoopingFireSoundOut)
			end
			
			if self.Secondary.LoopingFireSound != nil then
				self:EmitSound(self.Secondary.LoopingFireSoundOut)
			end
		else end
		if self.DoVentingSound == true then
			local ventingsound = self.VentingSound
			local ventstart = self.VentingStartSound
			self:EmitSound(ventingsound)
			self:EmitSound(ventstart)
		else end
		if self.DoOverheatAnimation == true then
			timer.Simple( looptime, function() self:AutoVent() end)
		else 
			timer.Simple( 0.3, function() self:AutoVent() end)
		end
	else
		self:SetNWFloat("HeatDispersePower", self.OverheatStrength)
		self:SetNWBool("Overheated", true)
		if CLIENT or SERVER && self.DoOverheatAnimation == true then
			self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
		else end
		if self.DoOverheatSound == true then
			local overheatsound = self.OverheatSound
			self:EmitSound(overheatsound)
			
			if self.Primary.LoopingFireSound != nil then
				self:EmitSound(self.Primary.LoopingFireSoundOut)
			end
			
			if self.Secondary.LoopingFireSound != nil then
				self:EmitSound(self.Secondary.LoopingFireSoundOut)
			end
		else end
		if self.DoVentingSound == true then
			local ventingsound = self.VentingSound
			local ventstart = self.VentingStartSound
			self:EmitSound(ventingsound)
			self:EmitSound(ventstart)
		else end
		if self.DoOverheatAnimation == true then
			timer.Simple( looptime, function() if IsValid(ply) then self:AutoVent() end end)
		else 
			timer.Simple( 0.3, function() if ply:IsValid() then self:AutoVent() end end)
		end
	end
	if SERVER then
		self:SetNWBool("NPCLoading", true)
	else end
	
	self:DoCustomOverheatEvents()
end

function SWEP:AutoVent()
	if !IsValid(self) then return end
	local ply = self:GetOwner()
	local heat = self:GetHeat()
	local valused = heat
	if ply:IsPlayer() then 
		valused = ply:GetAmmoCount("ammo_drc_battery") 
	else
		timer.Simple(1, function()
			if IsValid(self) then self:FinishVent() end
		end)
	end

	self.Idle = 0
	self:DoCustomVentEvents()
	if valused > 0 then
		if valused >= (100 - (100 * self.OverHeatFinishPercent)) then
			self:AutoVentLoop()
		else
			self:FinishVent()
		end
	else 
		timer.Simple(1, function() if IsValid(self) && !IsValid(ply) then
			self:FinishVent()
			end 
		end)
	end
end

function SWEP:AutoVentLoop()
	self.Idle = 0
	self:SetNWFloat("HeatDispersePower", self.OverheatStrength)
	
	local ply = self:GetOwner()
	if ply:IsPlayer() then
		local vm = ply:GetViewModel()
		local seqdur = vm:SequenceDuration(vm:SelectWeightedSequence(ACT_VM_RELOAD))
		if !self.VentLoopAnimTime or self.VentLoopAnimTime < CurTime() then
			self.VentLoopAnimTime = CurTime() + seqdur
			if self.DoVentingAnimation == true then self:SendWeaponAnim(ACT_VM_RELOAD) end
		end
	end
	
	timer.Simple(0.05, function() if !self:IsValid() then return end self:AutoVent() end)
end