SWEP.Base				= "draconic_gun_base"

--[[     I M P O R T A N T

Please, go to the wiki for this, and not just rip settings from the base as reference.
http://vuthakral.com/draconic/

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

SWEP.EnableHeat = true

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
SWEP.Primary.EmptySound			= "draconic.BatteryDepleted"

SWEP.Secondary.Sound 			= ""

-- the DO NOT TOUCH zone
SWEP.Primary.Ammo 			= "ammo_drc_battery"
SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 100
SWEP.VentHeld 				= false
SWEP.IsOverheated			= false
SWEP.IsBatteryBased			= true
SWEP.IsMelee = false

function SWEP:CanPrimaryAttackNPC()
	if !SERVER then return end
	local npc = self:GetOwner()
	if self.Bursting == true then return false end
	if self.NPCLoading == true or self.ManuallyReloading == true then return end
	
	if self:Clip1() <= 0 then -- Prevent NPCs from running out of ammo
		self:SetNW2Int("LoadedAmmo", math.Round(math.Clamp(math.Rand(self.BatteryConsumePerShot, self.BatteryConsumePerShot * 10)/10, 0, 100)) * 10)
		self:SetClip1(self:GetNW2Int("LoadedAmmo"))
	end
	
	if self:Clip1() <= 0 or npc:GetActivity() == ACT_RELOAD or self:GetNW2Bool("NPCLoading") == true then
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
		self:SetNW2Int("LoadedAmmo", 100)
		self:SetClip1(self:GetNW2Int("LoadedAmmo"))
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
	elseif reloadkey && !sprintkey && self.ManuallyReloading == false && self.CanVent == true && ( self:Clip1() <= self.Primary.ClipSize ) then
			if self:Ammo1() > 0 then
				if self.DoVentingSound == true then
					local ventstart = self.VentingStartSound
					self:EmitSound(ventstart)
				else end
				self:SetHoldType(self.VentingHoldType)
				self:Vent()
				ply:SetFOV(0, 0.05)
				--self:SetNW2Bool( "Ironsights", false )
				self.SightsDown = false
				if self.DoVentingSound == true then
					self:EmitSound(ventingsound)
				else end
				return true
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
	self:SetNW2Float("HeatDispersePower", self.VentingStrength)
	self:SetNW2Bool("Venting", true)
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
	self:SetNW2Float("HeatDispersePower", 1)
	
	timer.Simple( looptime, function()
		if !IsValid(self) or !IsValid(ply) or ply:Health() < 0.01 then return end
		self.Idle = 1
		self.ManuallyReloading = false
		self.IsOverheated = false
		self.IronCD = false	
		self:SetNW2Bool("Overheated", false)
		self:SetNW2Bool("Venting", false)
		self:SetNW2Bool("NPCLoading", false)
	end)
	timer.Simple( looptime, function() if !IsValid(self) or !IsValid(ply) or ply:Health() < 0.01 then return end self:ManuallyLoadAfterReload() end)
	self.IdleTimer = CurTime() + looptime
end

function SWEP:Overheat(scripted, cooldown, animate)
	if self.OverheatScripted == true && scripted != true then return end
	if !IsValid(self) then return end
	if DRC.SV.drc_infiniteammo > 1 then return end
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
		self:SetNextPrimaryFire (( CurTime() + self.PrimaryStats.PreCalcRPM ) * (self:GetHeat() * 0.1))
		return false
	elseif self:Clip1() <= 0 && self.InfAmmo == true then
		self:SetNW2Float("HeatDispersePower", self.OverheatStrength)
		self:SetNW2Bool("Overheated", true)
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
		self:SetNW2Float("HeatDispersePower", self.OverheatStrength)
		self:SetNW2Bool("Overheated", true)
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
		self:SetNW2Bool("NPCLoading", true)
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
	self:SetNW2Float("HeatDispersePower", self.OverheatStrength)
	
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