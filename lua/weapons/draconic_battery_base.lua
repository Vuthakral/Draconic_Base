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
SWEP.BatteryConsumPerShot		= 0.5

SWEP.BatteryFromVec	= Vector(255, 255, 255)
SWEP.BatteryToVec		= Vector(255, 10, 0)

SWEP.LoadAfterShot 			= false
SWEP.LoadAfterReloadEmpty	= false
SWEP.ManualReload			= false
SWEP.Primary.NumShots 		= 1
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
SWEP.Secondary.RecoilUp			= 1
SWEP.Secondary.RecoilDown		= 1
SWEP.Secondary.RecoilHoriz		= 1
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
SWEP.Primary.Ammo 			= "CombineHeavyCannon"
SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 100
SWEP.VentHeld 				= false
SWEP.IsOverheated			= false
SWEP.IsBatteryBased			= true

function SWEP:CanPrimaryAttack()
local ply = self:GetOwner()
local curFOV = ply:GetFOV()
local IronFOV = self.Secondary.IronFOV
local sk = ply:KeyDown(IN_SPEED)
local mk = (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK))
local issprinting = sk && mk
local wl = ply:WaterLevel()

	if self:GetNextPrimaryFire() > CurTime() then return false end

	if self.IsOverheated == true then return false end
	
	if self.Weapon:GetNWBool("Overheated") == true then return false end

	if ply:GetAmmoCount(self.Primary.Ammo) >= 100 && self.Weapon:GetNWInt("LoadedAmmo") >= 0.01 && self.CanOverheat == true && self.InfAmmo == false then
		self:Overheat()
		ply:SetFOV(0, 0.05)
		return false
	elseif ply:GetAmmoCount(self.Primary.Ammo) >= 100 && self.Weapon:GetNWInt("LoadedAmmo") >= 0.01 && self.CanOverheat == false && self.InfAmmo == false then
		ply:SetFOV(0, 0.05)
		return true
	elseif self.Weapon:GetNWInt("LoadedAmmo") < 0.01 && self.InfAmmo == false then
		self:EmitSound ( self.Primary.EmptySound )
		self:SetNextPrimaryFire (( CurTime() + 0.3 ))
		return false
	elseif ply:GetAmmoCount(self.Primary.Ammo) >= 100 && eself.Weapon:GetNWInt("LoadedAmmo") >= 0.01 && self.CanOverheat == true && self.InfAmmo == true then
		self:Overheat()
		ply:SetFOV(0, 0.05)
		return false
	elseif ply:GetAmmoCount(self.Primary.Ammo) >= 100 && self.Weapon:GetNWInt("LoadedAmmo") >= 0.01 && self.CanOverheat == false && self.InfAmmo == true then
		ply:SetFOV(0, 0.05)
		return true
	elseif self.Weapon:GetNWInt("LoadedAmmo") <= 0.01 && self.InfAmmo == true && self.Loading == false && self.ManuallyReloading == false then
		self:SetNextPrimaryFire (( CurTime() + 0.3 ))
		return true
	end
	
	if self.Loading == true or self.ManuallyReloading == true or self.SecondaryAttacking == true or self.Passive == true or self.Weapon:GetNWBool("Passive") == true or self.Weapon:GetNWBool("Inspecting") or ((self.DoesPassiveSprint == true or GetConVar("sv_drc_force_sprint"):GetString() == "1") && issprinting) or (self.Primary.CanFireUnderwater == false && wl >= 3) or (self.Overheated == true or self.IsOverheated == true) then
		return false
	else 
		return true
	end
end

function SWEP:CanPrimaryAttackNPC()
local npc = self:GetOwner()

	if self.Weapon:Clip1() <= 0 or npc:GetActivity() == ACT_RELOAD or self.Weapon:GetNWBool("NPCLoading") == true then
		self:LoadNextShot()
		return false
	end
	if !npc:IsNextBot() then npc:SetSchedule(SCHED_RANGE_ATTACK1) end
	return true
end

function SWEP:Reload()
local ply = self:GetOwner()
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
	elseif reloadkey && !sprintkey && self.ManuallyReloading == false && self.CanVent == true && ( self.Weapon:Clip1() < self.Primary.ClipSize ) then
			if ( self.Weapon:Clip1() < self.Primary.ClipSize ) && self.Weapon:Ammo1() > 0 then
				if self.DoVentingSound == true then
					local ventstart = self.VentingStartSound
					self.Weapon:EmitSound(ventstart)
				else end
				self:SetHoldType(self.VentingHoldType)
				self:Vent()
				ply:SetFOV(0, 0.05)
				--self.Weapon:SetNWBool( "Ironsights", false )
				self.SightsDown = false
				if self.DoVentingSound == true then
					self.Weapon:EmitSound(ventingsound)
				else end
				return true
			elseif ( self.Weapon:Clip1() < self.Primary.ClipSize ) && self.Weapon:Ammo1() > 1 then
			end
	elseif reloadkey && sprintkey && self.ManuallyReloading == false && self.Loading == false && ( self.Weapon:Clip2() < self.Secondary.ClipSize ) && ply:GetAmmoCount(self.Secondary.Ammo) > 0 then
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
	self.Weapon:SetNWFloat("HeatDispersePower", self.VentingStrength)
	self.Weapon:SetNWBool("Venting", true)
	self:SetIronsights(false, self.Owner)
	
	self:DoCustomVentEvents()

	if CLIENT or SERVER && self.DoVentingAnimation == true &&self.VentHeld == false then
	self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
	else end
	
	self.BloomValue = 1
	timer.Simple( looptime, function() self:VentHold() end)
end

function SWEP:VentHold()
	self.VentHeld = true

local ply = self:GetOwner()
	if self.DoVentingAnimation == true then
		self:SendWeaponAnim(ACT_VM_RELOAD)
	else end
	if self:Clip1() <= self.Primary.ClipSize then
		if ply:KeyDown(IN_RELOAD) && ply:GetAmmoCount("CombineHeavyCannon") > 0 then
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
	
	self:SetHoldType( self.HoldType )
	self.Weapon:StopSound(ventingsound)
	self.Weapon:EmitSound(ventingend)
	self.VentHeld = false
	self:DoCustomFinishVentEvents()
	
	if self.DoVentingAnimation == true && self.IsOverheated == false then
		if CLIENT or SERVER then
			self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
		end
	elseif self.IsOverheated == true && self.DoOverheatAnimation == true then
		if CLIENT or SERVER then
			self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
		end
	else end
	self.BloomValue = 1
	self.Weapon:SetNWFloat("HeatDispersePower", 1)
	
	timer.Simple( looptime, function()
		self.Idle = 1
		self.ManuallyReloading = false
		self.IsOverheated = false
		self.IronCD = false	
		self.Weapon:SetNWBool("Overheated", false)
		self.Weapon:SetNWBool("Venting", false)
	end)
	timer.Simple( looptime, function() self:ManuallyLoadAfterReload() end)
	self.IdleTimer = CurTime() + looptime
end

function SWEP:Overheat()
	local ply = self:GetOwner()
	local loopseq = self:SelectWeightedSequence( ACT_SHOTGUN_RELOAD_START )
	local looptime = self:SequenceDuration( loopseq )
	self.Idle = 0
	self.ManuallyReloading = true
	self.IsOverheated = true
	self:SetIronsights(false, self.Owner)
	self:SetHoldType(self.OverheatHoldType)
	ply:SetFOV(0, 0.05)
	
	if self.Weapon:Clip1() <= 0 && self.InfAmmo == false then
	--	self:EmitSound ( "draconic.BatteryDepleted" )
		self:SetNextPrimaryFire (( CurTime() + (60 / self.Primary.RPM) ) * (self:GetNWInt("Heat") * 0.1))
		return false
	elseif self.Weapon:Clip1() <= 0 && self.InfAmmo == true then
		self.Weapon:SetNWFloat("HeatDispersePower", self.OverheatStrength)
		self.Weapon:SetNWBool("Overheated", true)
		if CLIENT or SERVER && self.DoOverheatAnimation == true then
			self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
		else end
		if self.DoOverheatSound == true then
			local overheatsound = self.OverheatSound
			self.Weapon:EmitSound(overheatsound)
			
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
			self.Weapon:EmitSound(ventingsound)
			self.Weapon:EmitSound(ventstart)
		else end
		if self.DoOverheatAnimation == true then
			timer.Simple( looptime, function() self:AutoVent() end)
		else 
			timer.Simple( 0.3, function() self:AutoVent() end)
		end
	else
		self.Weapon:SetNWFloat("HeatDispersePower", self.OverheatStrength)
		self.Weapon:SetNWBool("Overheated", true)
		if CLIENT or SERVER && self.DoOverheatAnimation == true then
			self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
		else end
		if self.DoOverheatSound == true then
			local overheatsound = self.OverheatSound
			self.Weapon:EmitSound(overheatsound)
			
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
			self.Weapon:EmitSound(ventingsound)
			self.Weapon:EmitSound(ventstart)
		else end
		if self.DoOverheatAnimation == true then
			timer.Simple( looptime, function() if ply:IsValid() && ply:Alive() then self:AutoVent() end end)
		else 
			timer.Simple( 0.3, function() if ply:IsValid() && ply:Alive() then self:AutoVent() end end)
		end
	end
	if SERVER then
		self.Weapon:SetNWBool("NPCLoading", true)
	else end
	
	self:DoCustomOverheatEvents()
end

function SWEP:AutoVent()
local ply = self:GetOwner()
local AmmoName = self.Primary.Ammo

	if self:IsValid() then  else return end

	self.Idle = 0
	self:DoCustomVentEvents()
	if ply:GetAmmoCount(AmmoName) > 0 then
		if ply:GetAmmoCount(AmmoName) >= (100 - (100 * self.OverHeatFinishPercent)) then
			self:AutoVentLoop()
		else
			self:FinishVent()
			if SERVER then self.Weapon:SetNWBool("NPCLoading", true) end
		end
	else 
		timer.Simple(1, function() self:FinishVent() end)
		if SERVER then self.Weapon:SetNWBool("NPCLoading", true) end
	end
end

function SWEP:AutoVentLoop()
	self.Idle = 0
	self.Weapon:SetNWFloat("HeatDispersePower", self.OverheatStrength)
	timer.Simple(0.05, function() if !self:IsValid() then return end self:AutoVent() end)
end