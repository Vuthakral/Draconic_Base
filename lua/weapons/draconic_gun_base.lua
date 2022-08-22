SWEP.Base				= "draconic_base"

--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

SWEP.HoldType			= "ar2" -- https://wiki.garrysmod.com/page/Hold_Types
SWEP.Category			= "Draconic"
SWEP.PrintName			= "Draconic Gun Base"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Slot				= 0
SWEP.SlotPos			= 0

SWEP.ViewModelFOV		= 54
SWEP.ViewModelFlip		= false

SWEP.PreventAllBullets	= false
SWEP.HideImpacts		= false

SWEP.LoadAfterShot 			= false
SWEP.LoadAfterReloadEmpty	= false
SWEP.ManualReload			= false
SWEP.MagazineEntity			= nil

SWEP.FireModes_CustomScripted = false
SWEP.FireModes_CanAuto	= true
SWEP.FireModes_CanBurst = false
SWEP.FireModes_CanSemi	= true
SWEP.FireModes_BurstShots = 3

SWEP.Primary.IronRecoilMul	= 0.5
SWEP.Primary.Spread			= 1
SWEP.Primary.SpreadDiv		= 90
SWEP.Primary.Kick			= 0.76
SWEP.Primary.KickHoriz		= 0.26
SWEP.Primary.RecoilUp		= 0
SWEP.Primary.RecoilDown		= 0
SWEP.Primary.RecoilHoriz	= 0
SWEP.Primary.MuzzleAngle	= Angle(0, 0, 0)
SWEP.Primary.Force			= 0
SWEP.Primary.Damage			= 1
SWEP.Primary.Ammo			= "replaceme"
SWEP.Primary.ReloadHoldType	= "ar2"
SWEP.Primary.Automatic		= true
SWEP.Primary.CanFireUnderwater	= true
SWEP.Primary.RPM			= 857
SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.DropMagReload	= false
SWEP.Primary.ReloadTime		= nil
SWEP.Primary.ReloadTimeEmpty= nil
SWEP.Primary.APS			= 1
SWEP.Primary.HealthPerShot	= 0
SWEP.Primary.ArmourPerShot	= 0
SWEP.Primary.Tracer			= 1 -- https://wiki.garrysmod.com/page/Effects
SWEP.Primary.TracerEffect	= nil -- https://wiki.garrysmod.com/page/Effects
SWEP.Primary.EmptySound		= Sound("draconic.EmptyGeneric")
SWEP.Primary.SoundIsLooped	= false
SWEP.Primary.Sound 			= Sound("")
SWEP.Primary.DistSound 		= nil
SWEP.Primary.SoundTable 	= nil
SWEP.Primary.SoundDistance 	= 3500
SWEP.Primary.StartSound = Sound("")
SWEP.Primary.EndSound = Sound("")
SWEP.Primary.NPCSound = nil

SWEP.Primary.Projectile			 = nil
SWEP.Primary.ProjSpeed			 = 750
SWEP.Primary.ProjInheritVelocity = false

SWEP.Primary.CanMelee		= false
SWEP.Primary.MeleeSwingSound	= Sound( "" )
SWEP.Primary.MeleeHitSoundWorld = Sound( "" )
SWEP.Primary.MeleeHitSoundFlesh = Sound( "" )
SWEP.Primary.MeleeHitSoundEnt 	= Sound( "" )
SWEP.Primary.MeleeImpactDecal 	= ""
SWEP.Primary.MeleeBurnDecal 	= ""
SWEP.Primary.MeleeDamage		= 12
SWEP.Primary.MeleeDamageType	= DMG_CLUB
SWEP.Primary.MeleeRange			= 16.5
SWEP.Primary.MeleeForce			= 5
SWEP.Primary.MeleeDelayMiss		= 0.42
SWEP.Primary.MeleeDelayHit 		= 0.54
SWEP.Primary.CanAttackCrouched = false
SWEP.Primary.MeleeHitActivity	= nil 
SWEP.Primary.MeleeMissActivity	= ACT_VM_PRIMARYATTACK 
SWEP.Primary.MeleeHitDelay		= 0.1
SWEP.Primary.MeleeStartX		= 25
SWEP.Primary.MeleeEndX			= -25
SWEP.Primary.MeleeStartY		= -5
SWEP.Primary.MeleeEndY			= 5
SWEP.Primary.MeleeShakeMul		= 1

SWEP.Secondary.Ironsights			= false
SWEP.Secondary.SightsSuppressAnim 	= false
SWEP.Secondary.Scoped				= false
SWEP.Secondary.ScopeHideVM			= false
SWEP.Secondary.IronFOV				= 60
SWEP.Secondary.IronFOVAlt			= 60
SWEP.Secondary.IronInFP				= nil
SWEP.Secondary.IronOutFP			= nil
SWEP.Secondary.ScopeZoomTime 		= 0.25
SWEP.Secondary.SpreadRecoilMul 		= 1.0
SWEP.Secondary.SightsKickMul 		= 1.0
SWEP.Secondary.ScopePitch 			= 0
SWEP.Secondary.ScopeYOffset 		= -1

SWEP.Secondary.NumShots 		= 0
SWEP.Secondary.IronRecoilMul	= 0.5
SWEP.Secondary.Spread			= 3.5
SWEP.Secondary.SpreadDiv		= 100
SWEP.Secondary.Kick				= 0.5
SWEP.Secondary.KickHoriz		= 0.26
SWEP.Secondary.RecoilUp			= 1
SWEP.Secondary.RecoilDown		= 1
SWEP.Secondary.RecoilHoriz		= 1
SWEP.Secondary.MuzzleAngle		= Angle(0, 0, 0)
SWEP.Secondary.Force			= 0.2
SWEP.Secondary.Damage			= 12
SWEP.Secondary.Ammo				= "none"
SWEP.Secondary.ReloadHoldType	= "ar2"
SWEP.Secondary.Automatic		= false
SWEP.Secondary.AutoReload		= true
SWEP.Secondary.DoReloadAnimation = true
SWEP.Secondary.RPM				= 444
SWEP.Secondary.ClipSize			= 18
SWEP.Secondary.DefaultClip		= 18
SWEP.Secondary.DropMagReload	= false
SWEP.Secondary.CanFireUnderwater = true
SWEP.Secondary.APS				= 1
SWEP.Secondary.HealthPerShot	= 0
SWEP.Secondary.ArmourPerShot	= 0
SWEP.Secondary.Tracer			= "Tracer"
SWEP.Secondary.Sound 			= Sound("")

SWEP.Secondary.Projectile			 = nil
SWEP.Secondary.ProjSpeed			 = 750
SWEP.Secondary.ProjInheritVelocity = true
SWEP.Secondary.ProjectileSpawnDelay = 0

SWEP.OCSpread			= 0
SWEP.OCSpreadDiv		= 200
SWEP.OCKick				= 0.87
SWEP.OCKickHoriz		= 0.26
SWEP.OCRecoilUp			= 0.06
SWEP.OCRecoilDown		= 0.03
SWEP.OCRecoilHoriz		= 8
SWEP.OCMuzzleAngle		= Angle(0, 0, 0)
SWEP.OCIronRecoilMul	= 1
SWEP.OCForce			= 9
SWEP.OCDamage			= 12
SWEP.OCAPS				= 20
SWEP.OCHPS				= 999
SWEP.OCRPM				= 120
SWEP.OCTracer			= "4"
SWEP.OCTracerEffect		= nil
SWEP.OCSound 			= ""
SWEP.OCSoundDist 		= nil
SWEP.OCNPCSound 		= nil
SWEP.OCProjectile 		= nil
SWEP.OCProjSpeed = 500

SWEP.AttachmentTable = {
	AmmunitionTypes = {"drc_att_bprofile_generic"},
	Optics = nil,
	Foregrips = nil,
	Barrels = nil,
	Stocks = nil,
	Internals = nil,
	Charm = nil
}

-- "DO NOT TOUCH" Zone. Touching any of these settings in your SWEP WILL break something. So DON'T.
SWEP.Loading = false
SWEP.IronCD = false
SWEP.FireDelay = 0
SWEP.ManuallyReloading = false
SWEP.SecondaryAttacking = false
SWEP.Bursting = false
SWEP.IsBatteryBased = false
SWEP.IsMelee = false

function SWEP:CanSwitchFireModes()
	if self.FireModes_CustomScripted == true then return true end
	if self.FireModes_CanAuto == true && (self.FireModes_CanBurst == true or self.FireModes_CanSemi == true) then return true
	elseif self.FireModes_CanBurst == true && (self.FireModes_CanAuto == true or self.FireModes_CanSemi == true) then return true
	elseif self.FireModes_CanSemi == true && (self.FireModes_CanAuto == true or self.FireModes_CanBurst == true) then return true
	else return false end
end

function SWEP:CanPrimaryAttack()
	if self.Primary.Disabled == true then return end
	
	local ply = self:GetOwner()
	local charge = self:GetNWInt("Charge")
	local sk = ply:KeyDown(IN_SPEED)
	local mk = (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK))
	local issprinting = sk && mk
	local wl = ply:WaterLevel()
	
	local curFOV = ply:GetFOV()
	local IronFOV = self.Secondary.IronFOV
	
	if CurTime() < self:GetNextPrimaryFire() then return end
		
	if ( self.Weapon:Clip1() <= 0 ) && self.InfAmmo == false then
		self:EmitSound ( self.Primary.EmptySound )
		self:SetNextPrimaryFire(CurTime() + 0.3)
		return false
	elseif ( self.Weapon:Clip1() <= 0 ) && self.SecondaryAttacking == false && self.InfAmmo == true then
		return true
	end
	
	if self.Weapon:GetNWBool("Inspecting") == true then
		return false
	end
	
	if self.Weapon:GetNWBool("Passive") == true then
		self:TogglePassive()
		self:SetNextPrimaryFire(CurTime() + 0.3)
		return false
	end

	if self.Loading == true or self.ManuallyReloading == true or self.SecondaryAttacking == true or self.Weapon:GetNWBool("Passive") == true or self.Weapon:GetNWBool("Inspecting") == true or ((self.DoesPassiveSprint == true or GetConVar("sv_drc_force_sprint"):GetString() == "1") && issprinting) or (self.Primary.CanFireUnderwater == false && wl >= 3) then
		if wl >= 3 then self:EmitSound ( "draconic.EmptyGeneric" ) end
		return false
	else 
		return true
	end
end

function SWEP:CanPrimaryAttackNPC()
	local npc = self:GetOwner()
	local BT = self.ActiveAttachments.Ammunition.t.BulletTable
	
	if self.Weapon:Clip1() < 1 or self.Weapon:GetNWInt("LoadedAmmo") < 1 then
	--	npc:SetSchedule(SCHED_RELOAD)
		self:LoadNextShot()	
		self.Weapon:SetNWInt("LoadedAmmo", (self.DefaultPimaryClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul")))
		self:SetClip1(self.DefaultPimaryClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))
		if !npc:IsNextBot() && !npc.Draconic then 
			npc:ClearSchedule()
			npc:SetSchedule(SCHED_PATROL_WALK)
		end
		return false
	end
	return true
end

function SWEP:CanSecondaryAttack()
local ply = self:GetOwner()
local curFOV = ply:GetFOV()
local IronFOV = self.Secondary.IronFOV

	if self.Secondary.Disabled == true then return end

	if ( self.Weapon:Clip2() <= 0 ) then
		self:EmitSound ( "draconic.EmptyGeneric" )
		self:SetNextPrimaryFire (( CurTime() + 0.3 ))
		return false
	end
	if self.Loading == true or self.ManuallyReloading == true or self.Passive == true or (self.DoesPassiveSprint == true && issprinting) or (self.Secondary.CanFireUnderwater == false && wl >= 3) then
		return false
	else
		return true
	end
end

function SWEP:PrimaryAttack()
	if !IsValid(self) then return end
	if self:GetNWInt("LoadedAmmo") > 0 then self:DoCustomPrimaryAttackEvents() end
	
	self:DoCustomPrimary()
	
	local ply = self:GetOwner()
	local fireseq = self:SelectWeightedSequence( ACT_VM_PRIMARYATTACK )
	local firetime = self:SequenceDuration( fireseq )
	local scope = self.Weapon:GetNWBool("ironsights")
	local passive = self.Weapon:GetNWBool("Passive")
	local dc = self.Primary.UsesCharge
	local fm = self.Weapon:GetNWString("FireMode")
	local charge = self.Weapon:GetNWInt("Charge")
	
	if (self.Primary.UsesCharge == true && ply:IsPlayer()) && ply:KeyDown(IN_USE) then self:DoMelee() else end
	if self.Loading == true or self.NPCLoading == true or self.ManuallyReloading == true then return end
	
	if ply:IsPlayer() && dc && self.ChargeType == "default" && charge < 99 then
	elseif ply:IsPlayer() && dc && (self.ChargeType == "dualaction" or self.ChargeType == "discharge") && charge >= 99 && self:CanOvercharge() && self:CanPrimaryAttack() then self:DoOvercharge()
	elseif ply:IsPlayer() && dc && self.ChargeType != "default" then
	else
		if ply:IsPlayer() then
			local vm = ply:GetViewModel()
			
			if self.Primary.CanMelee == true then
				if ply:KeyDown(IN_USE) && self:CanGunMelee() == true then
					self:DoMelee()
				else
				
				if self.Weapon:GetNWString("FireMode") == "Semi" or self.Weapon:GetNWString("FireMode") == "Auto" then
					self:CallShoot("primary")
				elseif self.Weapon:GetNWString("FireMode") == "Burst" && self.Bursting == false then
				self.Bursting = true
				timer.Simple(((60 / self.Primary.RPM) * self.FireModes_BurstShots * 2), function() self.Bursting = false end)
					for i=1, (self.FireModes_BurstShots) do
						timer.Simple(i * (60 / self.Primary.RPM) + 0.02, function()
							if not IsValid(self) or not IsValid(self.Owner) then return end
							if self:Clip1() <= 0 then return end
							if self.Loading == false then
								self:CallShoot("primary", true)
							end
						end)
					end
				else end
				
				if self.LoadAfterShot == true && (self.Weapon:Clip1() > 0) then
					self.Loading = true
					timer.Simple( firetime, function() if ply:IsValid() && ply:Alive() then
						if !IsValid(ply) then return end
						if !IsValid(self) then return end
						if !ply:Alive() then return end
						ply:SetFOV(0, self.Secondary.ScopeZoomTime)
						self:LoadNextShot()
						end
					end)
				elseif self.LoadAfterShot == true && (self.Weapon:Clip1() <= 0) then
					self.Loading = false
				elseif self.Loading == false then
				end
			end
			elseif self.Primary.CanMelee == false && self.Loading == false then
				if self.Weapon:GetNWString("FireMode") == "Semi" or self.Weapon:GetNWString("FireMode") == "Auto" then
					self:CallShoot("primary")
				elseif self.Weapon:GetNWString("FireMode") == "Burst" && self.Bursting == false then
				self.Bursting = true
				timer.Simple(((60 / self.Primary.RPM) * self.FireModes_BurstShots + 0.05), function() self.Bursting = false end)
					for i=0, (self.FireModes_BurstShots - 1) do
						timer.Simple(i * (60 / self.Primary.RPM), function()
							if not IsValid(self) or not IsValid(self.Owner) then return end
							if self.Loading == false then
								self:CallShoot("primary", true)
							end
						end)
					end
				else end
				if self.LoadAfterShot == true && (self.Weapon:Clip1() > 0) then
					self.Loading = true
					ply:SetFOV(0, self.Secondary.ScopeZoomTime)
					timer.Simple( firetime, function()
						if !IsValid(self) then return end
						self:LoadNextShot()
					end)
				elseif self.LoadAfterShot == true && self.LoadAfterReloadEmpty == false && (self.Weapon:Clip1() <=0) then
					self.Loading = true
					ply:SetFOV(0, self.Secondary.ScopeZoomTime)
					timer.Simple( firetime, function()
						self:LoadNextShot()
					end)
				elseif self.LoadAfterShot == true && (self.Weapon:Clip1() <= 0) then
				self.Loading = false
				else end
			end
		elseif !ply:IsPlayer() or ply.IsVJBaseSNPC != nil then
		if self.NPCBursting == true then return false end
		if not self:CanPrimaryAttackNPC() then return end
			if SERVER then
				if (self.Weapon:Clip1() > 0) then
					if self.FireDelay > CurTime() then
						return
					end
					
					if self.Owner:IsNPC() or self.Owner:IsNextBot() then
						self.FireDelay = (CurTime() + (60 / self.Primary.RPM))
						if not IsValid(self) or not IsValid(self.Owner) then return end
						if not self.Owner:GetEnemy() or not self:CanPrimaryAttackNPC() then return end
						if self.Loading == false then
							if dc == true then
								if self.ChargeType == "dualheld" or self.ChargeType == "dualaction" then
									local rng = math.Rand(1,100)
									
									if rng < 5 then
										self:NPCCharge()
									elseif self.NPCCharging == true && charge >= 100 then
										self:NPCCharge()
									elseif self.NPCCharging == false then
										self:CallShoot("primary")
									end
								elseif self.ChargeType == "discharge" then
									self:NPCCharge()
								else
									self:CallShoot("primary")
								end
							else
								self:CallShoot("primary")
							end
						end
					elseif (self.Weapon:Clip1() <= 0) then end
				end
			end
		end
	end
end

function SWEP:NPCCharge()
	local ply = self:GetOwner()
	local amount = self.ChargeRate
	local charge = self:GetNWInt("Charge")
	local chargetype = self.ChargeType
	local fraction = (100 / amount)
	
	if charge == nil then self:SetNWInt("Charge", 0) end
	if self.NPCCharging == nil then self.NPCCharging = false end
	
	if self.NPCCharging == false then
		--print("called & initiated charge")
		self.NPCCharging = true
		if self.ChargeSound != nil then self:EmitSound(self.ChargeSound) end
		for i=0,fraction do
			timer.Simple( i * 0.1, function()
				if !IsValid(self) then return end
				if !IsValid(ply) then return end
			--	print(self:GetNWInt("Charge") + self.ChargeRate)
				self:SetNWInt("Charge", self:GetNWInt("Charge") + self.ChargeRate)
				
				
		--		print("Charging: ".. self:GetNWInt("Charge") .."")
			end)
		end
	else
		if charge >= 100 then
			self:CallShoot("overcharge")
			self:SetNWInt("Charge", 0)
			self:StopSound(self.ChargeSound)
			self.NPCCharging = false
		end
	end
end

function SWEP:LoadNextShot()
	local ply = self:GetOwner()
	local loadseq = self:SelectWeightedSequence( ACT_SHOTGUN_PUMP )
	local loadtime = self:SequenceDuration( loadseq )
	
	if IsFirstTimePredicted() then self:DoCustomManualLoadEvents() end
	
	if ply:IsNPC() or ply:IsNextBot() then
		if ply:IsValid() then
			if CLIENT or SERVER then
				if ply:IsPlayer() then
					self.Weapon:SendWeaponAnim( ACT_SHOTGUN_PUMP )
					timer.Simple( loadtime + 0.025, function() if ply:IsValid() && ply:Alive() then self:FinishLoading() end end)
				else end
			end
		end
	else
		if ply:IsValid() && ply:Alive() then
			if CLIENT or SERVER then
				if ply:IsPlayer() then
					self.Weapon:SendWeaponAnim( ACT_SHOTGUN_PUMP )
					timer.Simple( loadtime + 0.025, function() if ply:IsValid() && ply:Alive() then self:FinishLoading() end end)
				else end
			end
		end
	end
end

function SWEP:FinishLoading()
	self.Loading = false
end

function SWEP:DoMelee()
if not IsValid(self) or not IsValid(self.Owner) then return end
	local ply = self:GetOwner()
	local vm = ply:GetViewModel()
	local eyeang = ply:EyeAngles()
	local eyepos = ply:EyePos()
	local cv = ply:Crouching()
	
	local x1 = self.Primary.MeleeStartX
	local x2 = self.Primary.MeleeEndX
	local y1 = self.Primary.MeleeStartY
	local y2 = self.Primary.MeleeEndY
	
	local x1m = math.Rand(x1 * 0.9, x1 * 1.1)
	local x2m = math.Rand(x2 * 0.9, x2 * 1.1)
	local y1m = math.Rand(y1 * 0.9, y1 * 1.1)
	local y2m = math.Rand(y2 * 0.9, y2 * 1.1)
	
	ply:ViewPunch(Angle(y1m, x1m, nil) * -0.1 * self.Primary.MeleeShakeMul)
	ply:SetViewPunchVelocity(Angle(-x1m * (1 + self.Primary.MeleeHitDelay) * self.Primary.MeleeShakeMul, -y1m * (5 + self.Primary.MeleeHitDelay) * self.Primary.MeleeShakeMul, 0))
	timer.Simple(self.Primary.MeleeHitDelay, function()
		if !IsValid(self) then return end
		if !IsValid(self:GetOwner()) then return end
		ply:ViewPunch(Angle(y1m, x1m, nil) * 0.1 * self.Primary.MeleeShakeMul)
	end)

	self.IsDoingMelee = true
	timer.Simple(self.Primary.MeleeDelayMiss, function() self.IsDoingMelee = false end)
	self.BloomValue = 1

	self:EmitSound(Sound(self.Primary.MeleeSwingSound))
	self.Weapon:SendWeaponAnim( self.Primary.MeleeMissActivity )
	self:SetNextPrimaryFire( CurTime() + self.Primary.MeleeDelayMiss )
	self.IdleTimer = CurTime() + vm:SequenceDuration()
	
	if SERVER then 
		net.Start("DRCPlayerMelee")
		net.WriteEntity(self:GetOwner())
		net.Broadcast()
	end

	for i=1, (math.Round(1/ engine.TickInterval() - 1 , 0)) do
		timer.Create( "SwingImpact".. i .."", math.Round((self.Primary.MeleeHitDelay * 100) / 60 * i / 60, 3), 1, function()
			if !IsValid(self) then return end
			self:MeleeImpact(self.Primary.MeleeRange, Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), x1m, x2m), Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), y1m, y2m), i, "gunmelee")
		end)
	end
end

function SWEP:SecondaryAttack()
local ply = self:GetOwner()
local cv = ply:Crouching()
local usekey = ply:KeyDown(IN_USE)
local reloadkey = ply:KeyDown(IN_RELOAD)
local sprintkey = ply:KeyDown(IN_SPEED)
local fireseq = self:SelectWeightedSequence( ACT_VM_PRIMARYATTACK )
local firetime = self:SequenceDuration( fireseq )
local vm = ply:GetViewModel()
	
	self:DoCustomSecondary()
	
if dc && self.ChargeType == "default" && charge < 99 then
elseif dc && (self.ChargeType == "dualaction" or self.ChargeType == "discharge") && charge >= 99 then self:DoOvercharge()
elseif dc && self.ChargeType != "default" then
	else
		if self.Secondary.Ironsights == true then
			if usekey && !sprintkey then
				self:SetFireMode()
			elseif sprintkey && usekey then
				self:TogglePassive()
			elseif self.Passive == false then
				if self.Weapon:GetNWBool("Ironsights") == true then
					self.Weapon:SetNetworkedBool( "Ironsights", true )
				else
					self.Weapon:SetNetworkedBool( "Ironsights", false )
				end
			end
		elseif self.Secondary.Ironsights == false then
			if usekey && !sprintkey then
				self:SetFireMode()
			elseif sprintkey then
				self:TogglePassive()
			else
				self:CallShoot("secondary")
				self:DoCustomSecondaryAttackEvents()
			end
		end
	end
end

function SWEP:TogglePassive()
	if !IsFirstTimePredicted() then return end
	if SERVER then self:CallOnClient("TogglePassive") end
	local ply = self:GetOwner()
	self.Weapon:EmitSound(self.FireModes_SwitchSound)
	
	if GetConVar("sv_drc_passives"):GetString() == "0" then return end
	
	if self:GetNWBool("Passive") == false then
		self.Passive = true
		self:DoPassiveHoldtype()
		self:SetNWBool("Passive", true)
		if self.Weapon:GetNWBool("ironsights") == true then 
			ply:SetFOV(0, self.Secondary.ScopeZoomTime)
			self.Weapon:SetNWBool("ironsights", false)
		else end
		ply:EmitSound("draconic.IronOutGeneric")
		if self.Weapon:GetNWBool("Inspecting") == true then
			self:ToggleInspectMode()
		end
	else
		self.Loading = true
		self.Idle = 0
	--	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
		self:SetHoldType(self.HoldType)
		self.Passive = false
		self:SetNWBool("Passive", false)
		ply:EmitSound("draconic.IronInGeneric")
		timer.Simple(0.42, function()
			self.Loading = false 
			self.Idle = 1
		end)
	end
end

function SWEP:ToggleInspectMode()
	local ply = self:GetOwner()
	
	if GetConVar("sv_drc_inspections"):GetString() == "0" then return end
	
	if self.Weapon:GetNWBool("Inspecting") == false then
		self.Inspecting = true
		self:DoPassiveHoldtype()
		self.Weapon:SetNWBool("Inspecting", true)
		if self.Weapon:GetNWBool("ironsights") == true then 
			ply:SetFOV(0, self.Secondary.ScopeZoomTime)
			self.Weapon:SetNWBool("ironsights", false)
		else end
		ply:EmitSound("draconic.IronOutGeneric")
		if self.Weapon:GetNWBool("Passive") == true then
			self:TogglePassive()
		end
	else
		self.Idle = 0
		self:SetHoldType(self.HoldType)
		self.Inspecting = false
		self.Weapon:SetNWBool("Inspecting", false)
		ply:EmitSound("draconic.IronInGeneric")
		timer.Simple(0.42, function()
			self.Inspecting = false 
			self.Idle = 1
		end)
	end
end

function SWEP:DoCustomFireMode(mode)
end

function SWEP:SetFireMode(mode, showhint)
	local ply = self:GetOwner()
	if !self:CanSwitchFireModes() then return end
	if self.Weapon:GetNWString("FireMode") == nil then self.Weapon:SetNWString("FireMode", "Semi") end
	
	if showhint == nil then showhint = true end
	if self.FireModes_CustomScripted == true then showhint = false end
	
	self:DoCustomFireMode(mode)
	
	if self.FireModes_CanAuto == true or self.FireModes_CanBurst == true or self.FireModes_CanSemi == true then
		if showhint == true then timer.Simple(0.05, function() self:DisplayFireMode() end) end
	end
	
	if self.FireModes_CustomScripted == true then
		if mode == "Semi" then
			self.Weapon:SetNWString("FireMode", "Semi")
		elseif mode == "Auto" then
			self.Weapon:SetNWString("FireMode", "Auto")
		elseif mode == "Burst" then
			self.Weapon:SetNWString("FireMode", "Burst")
		end
	end
	
	if self.FireModes_CustomScripted == true then return end
	
	if mode == "Semi" then
		if self.FireModes_CanSemi == true then self.Weapon:SetNWString("FireMode", "Semi") end
	elseif mode == "Auto" then
		if self.FireModes_CanAuto == true then self.Primary.Automatic = true self.Weapon:SetNWString("FireMode", "Auto") end
	elseif mode == "Burst" then
		if self.FireModes_CanBurst == true then self.Weapon:SetNWString("FireMode", "Burst") end
	elseif mode == nil then
		local fmode = self.Weapon:GetNWString("FireMode")
		
		if fmode == "Semi" then
			if self.FireModes_CanAuto == true then
				self.Primary.Automatic = true
				self.Weapon:SetNWString("FireMode", "Auto")
			elseif self.FireModes_CanBurst == true then
				self.Primary.Automatic = false
				self.Weapon:SetNWString("FireMode", "Burst")
			end
		elseif fmode == "Auto" then
			if self.FireModes_CanBurst == true then
				self.Primary.Automatic = false
				self.Weapon:SetNWString("FireMode", "Burst")
			elseif self.FireModes_CanSemi == true then
				self.Primary.Automatic = false
				self.Weapon:SetNWString("FireMode", "Semi")
			end
		elseif fmode == "Burst" then
			if self.FireModes_CanSemi == true then
				self.Primary.Automatic = false
				self.Weapon:SetNWString("FireMode", "Semi")
			elseif self.FireModes_CanAuto == true then
				self.Primary.Automatic = true
				self.Weapon:SetNWString("FireMode", "Auto")
			end
		end
	end
end


function SWEP:DisplayFireMode()
local ply = self:GetOwner()
local string = self.Weapon:GetNWString("FireMode")
	self.Weapon:EmitSound(self.FireModes_SwitchSound)
	
	if SERVER then
		if self.InfoName == nil then
			ply:PrintMessage( HUD_PRINTCENTER, "Switched to "..string..".")
		else
			ply:PrintMessage( HUD_PRINTCENTER, ""..self.InfoStats.InfoName.." switched to "..string..".")
		end
	else end
end


function SWEP:Reload()
	self:DoCustomReload()
	if game.SinglePlayer() then self:CallOnClient("Reload") end -- why
	local ply = self:GetOwner()
	local usekey = ply:KeyDown(IN_USE)
	local reloadkey = ply:KeyDown(IN_RELOAD)
	local walkkey = ply:KeyDown(IN_WALK)
	local sprintkey = ply:KeyDown(IN_SPEED)
	local BT = self.ActiveAttachments.Ammunition.t.BulletTable
	local CM = math.Round(self.DefaultPimaryClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))
	local reloadkeypressed = ply:KeyPressed(IN_RELOAD)

	if ply:IsPlayer() then
		if usekey && reloadkeypressed then
			if sprintkey then
				self:ToggleInspectMode()
			elseif self.Inspecting == false then
				self:Inspect()
			elseif self.Inspect == true then end
		elseif walkkey && reloadkey && self.IsTaunting == 0 then
			self:Taunt()
			elseif walkkey && reloadkey && self.IsTaunting == 1 then
		elseif reloadkey && !sprintkey && self.ManuallyReloading == false && self.Loading == false && self.ManualReload == true && ( self.Weapon:Clip1() < CM ) then
			if ( ply:GetAmmoCount(self.Primary.Ammo) ) <= 0 then
			else
					self:StartManualReload()
					ply:SetFOV(0, 0.05)
					self.Weapon:SetNWBool( "Ironsights", false )
					if self.Weapon:Clip1() <= 0 then
						self:SetNWBool("reloadedEmpty", true)
					else
						self:SetNWBool("reloadedEmpty", false)
					end
					return true
			end
		elseif reloadkey && !sprintkey && self.ManuallyReloading == false && self.Loading == false && self.ManualReload == false && ( self.Weapon:Clip1() < CM ) then
				if ( self.Weapon:Clip1() < CM ) && self.Weapon:Ammo1() > 0 then
					self:DoReload()
					ply:SetFOV(0, 0.05)
					self.Weapon:SetNWBool( "Ironsights", false )
					if self.Weapon:Clip1() <= 0 then
						self:SetNWBool("reloadedEmpty", true)
					else
						self:SetNWBool("reloadedEmpty", false)
					end
					return true
				elseif ( self.Weapon:Clip1() < CM ) && self.Weapon:Ammo1() > 1 then
				end
		elseif reloadkey && sprintkey && self.ManuallyReloading == false && self.Loading == false && ( self.Weapon:Clip2() < self.Secondary.ClipSize ) && ply:GetAmmoCount(self.Secondary.Ammo) > 0 then
			if ( ply:GetAmmoCount(self.Secondary.Ammo) ) <= 0 then
			else
				ply:SetFOV(0, 0.05)
				self:ReloadSecondary()
			end
		end
	elseif !ply:IsPlayer() then
		self:DoReload()
	end
end

function SWEP:ReloadSecondary()
	local ply = self:GetOwner()
	local vm = ply:GetViewModel()
	
	if self:IsValid() && ply:IsValid() && ply:Alive() then
		if self.Secondary.DoReloadAnimation == true then
			ply:SetAnimation( PLAYER_RELOAD )
		else end
		self.Loading = true
		self:SetIronsights(false, self.Owner)
		
		if self.Secondary.ReloadAct != nil then
			local reloadseq = self:SelectWeightedSequence( self.Secondary.ReloadAct )
			local reloadtime = self:SequenceDuration( reloadseq )
			vm:SendViewModelMatchingSequence(reloadseq)
			timer.Simple( reloadtime, function() self:EndSecondaryReload() end)
		else
			self:EndSecondaryReload()
		end
	end
end

function SWEP:EndSecondaryReload()
	local ply = self:GetOwner()
	self.Loading = false
	self.IronCD = false
	
	if self:IsValid() && ply:IsValid() && ply:Alive() then
		if self.Secondary.DropMagReload == false then
		ply:RemoveAmmo( (self.Secondary.ClipSize - self.Weapon:Clip2()), self.Secondary.Ammo)
		else
		ply:RemoveAmmo( self.Secondary.ClipSize, self.Secondary.Ammo)
		end
		self:SetClip2( self.Secondary.ClipSize )
		self:SetHoldType( self.HoldType )
	else end
end

function SWEP:DoReload()
	local ply = self:GetOwner()
	local reloadseq = self:SelectWeightedSequence( ACT_VM_RELOAD )
	local reloadtime = self:SequenceDuration( reloadseq )
	local emptyreloadseq = self:SelectWeightedSequence( ACT_VM_RELOAD_EMPTY )
	local emptyreloadtime = self:SequenceDuration( emptyreloadseq )
	local BT = self.ActiveAttachments.Ammunition.t.BulletTable
	local CM = math.Round(self.DefaultPimaryClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))
	local LeftHand = ply:LookupBone("ValveBiped.Bip01_L_Hand")
	local RightHand = ply:LookupBone("ValveBiped.Bip01_R_Hand")
	local vm = ply:GetViewModel()
	
	vm:SetPlaybackRate( 1 )
	
	if self:IsValid() && ply:IsValid() && ply:Alive() then
		self.Loading = true
		self:SetNextPrimaryFire( CurTime() + reloadtime)
		self:SetNextSecondaryFire( CurTime() + reloadtime)
		
		if self.SightsDown == true && CLIENT && self.Secondary.IronOutFP != nil then
			surface.PlaySound(Sound(self.Secondary.IronOutFP))
		end
		
		self:SetIronsights(false)
		self.SightsDown = false
		
	--	ply:SetAnimation( PLAYER_RELOAD )
		if SERVER then DRCCallGesture(ply, GESTURE_SLOT_CUSTOM, self.Primary.ReloadAct) end
		
		self:SetIronsights(false, self.Owner)
		
		if self.Weapon:Clip1() <= 0 then
			if emptyreloadseq == -1 then
				if IsFirstTimePredicted() then self:SendWeaponAnim(ACT_VM_RELOAD) end
			else
				if IsFirstTimePredicted() then self:SendWeaponAnim(ACT_VM_RELOAD_EMPTY) end
			end
		else
			if IsFirstTimePredicted() then self:SendWeaponAnim(ACT_VM_RELOAD) end
		end
		
		if SERVER && self.MagazineEntity != nil then
			local mag = ents.Create(self.MagazineEntity)
				mag:SetPos( ply:GetBonePosition(LeftHand) )
				mag:SetAngles( ply:EyeAngles() )
				mag:SetOwner(ply)
				mag:Spawn()
				mag:Activate()
				local phys = mag:GetPhysicsObject()
				phys:SetVelocity(self.Owner:GetAimVector() + ply:GetVelocity())
		else end

		if ply:GetAmmoCount(self.Primary.Ammo) < CM then
		self.Weapon:SetNWInt("LoadedAmmo", math.Clamp(self.Weapon:Clip1() + ply:GetAmmoCount(self.Primary.Ammo), 0, CM))
		else
		self.Weapon:SetNWInt("LoadedAmmo", math.Clamp(CM, 0, CM))
		end		

		self.BloomValue = 1
		self:DoCustomReloadStartEvents()
		
		if self.Weapon:Clip1() <= 0 then
			if emptyreloadseq == -1 then
				if self.Primary.ReloadTime != nil then
					timer.Simple( self.Primary.ReloadTime, function() if self:IsValid() then self.PistolSlide = 1 end end)
				else
					timer.Simple( reloadtime, function() if self:IsValid() then self.PistolSlide = 1 end end)
				end
				timer.Simple( reloadtime, function() if self:IsValid() then self:EndReload() end end)
			else
				if self.Primary.ReloadTimeEmpty != nil then
					timer.Simple( self.Primary.ReloadTimeEmpty, function() if self:IsValid() then self.PistolSlide = 1 end end)
				else
					timer.Simple( emptyreloadtime, function() if self:IsValid() then self.PistolSlide = 1 end end)
				end
				timer.Simple( emptyreloadtime, function() if self:IsValid() then self:EndReload() end end)
			end
		else
			if self.Primary.ReloadTime != nil then
				timer.Simple( self.Primary.ReloadTime, function() if self:IsValid() then self.PistolSlide = 1 end end)
			end
			timer.Simple( reloadtime, function() if ply:IsValid() && ply:Alive() && self:IsValid() then self:EndReload() end end)
		end
	else end
end

function SWEP:EndReload()
	local ply = self:GetOwner()
	
	if  not (self:IsValid() && ply:IsValid() && ply:Alive()) then return end
	if SERVER then self:CallOnClient("EndReload") end
	local BT = self.ActiveAttachments.Ammunition.t.BulletTable
	local CM = math.Round(self.DefaultPimaryClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))
	
	self.IdleTimer = CurTime()
	self.Loading = false
	self.IronCD = false
	self.LoopOutEmptyPlayed = false
	
	self.BloomValue = 0.25
	self:DoCustomReloadEndEvents()
		if self.Primary.DropMagReload == false then
		ply:RemoveAmmo( (CM - self.Weapon:Clip1()), self.Primary.Ammo)
		else
		ply:RemoveAmmo( CM, self.Primary.Ammo)
		end
		
		self:SetClip1( math.Clamp(self.Weapon:GetNWInt("LoadedAmmo"), 0, CM) )
		if self.Passive == true then
			self:DoPassiveHoldtype()
		else
			self:SetHoldType( self.HoldType )
		end
		
		if self:GetNWBool("reloadedEmpty") == true && self.LoadAfterReloadEmpty == true then
			self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
		else end
end

function SWEP:StartManualReload()
	local ply = self:GetOwner()
	local wep = self
	local vm = ply:GetViewModel()
	local enterseq = self:SelectWeightedSequence( ACT_SHOTGUN_RELOAD_START )
	local entertime = self:SequenceDuration( enterseq )

	if self:IsValid() && ply:IsValid() && ply:Alive() then
		self:SetNextPrimaryFire( CurTime() + 9001)
		self:SetNextSecondaryFire( CurTime() + 9001)
		ply:SetAnimation( PLAYER_RELOAD )
		self.ManuallyReloading = true
		self:SetIronsights(false, self.Owner)
		wep:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
		timer.Simple( entertime, function() if ply:IsValid() && ply:Alive() then self:DoManualReload() end end)
	else end
return true
end

function SWEP:PlayManualReloadAnimation()
	local ply = self:GetOwner()
	local vm = ply:GetViewModel()
	local loopseq = self:SelectWeightedSequence( ACT_VM_RELOAD )
	local looptime = self:SequenceDuration( loopseq )
	
	if IsFirstTimePredicted() then
		timer.Simple(0.01, function() vm:SendViewModelMatchingSequence(loopseq) end)
	end
end

function SWEP:DoManualReload(looped)
	if looped == nil then looped = false end
	local ply = self:GetOwner()
	local vm = ply:GetViewModel()
	local loopseq = self:SelectWeightedSequence( ACT_VM_RELOAD )
	local looptime = self:SequenceDuration( loopseq )

	if self:IsValid() && ply:IsValid() && ply:Alive() then
		self.ManuallyReloading = true
		self:SetIronsights(false, self.Owner)
		
		if IsFirstTimePredicted() then self:DoCustomReloadLoopEvents() end
		
		self:GetOwner():RemoveAmmo( 1, self.Primary.Ammo, false )
		self.Weapon:SetNWBool("LoadedAmmo", self.Weapon:GetNWBool("LoadedAmmo") + self.Primary.APS)
		self:SetClip1(self.Weapon:GetNWInt("LoadedAmmo"))
		
		if looped == true then
			self:PlayManualReloadAnimation()
		else
			self:PlayManualReloadAnimation()
		end -- for reasons I cannot comprehend, this doesn't work if done any other way.
		
		timer.Simple( looptime, function() if ply:IsValid() && ply:Alive() then self:ManualReloadLoop() end end)
	else end
end

function SWEP:ManualReloadLoop()
	local ply = self:GetOwner()
	local BT = self.ActiveAttachments.Ammunition.t.BulletTable
	local CM = math.Round(self.DefaultPimaryClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))
	
	if self:IsValid() && ply:IsValid() && ply:Alive() then
			if self:Clip1() <= CM then
				if ply:KeyDown(IN_RELOAD) && self:Clip1() < CM then
					if ( ply:GetAmmoCount(self.Primary.Ammo) ) > 0 then
						self:DoManualReload(true)
						self:CallOnClient("PlayManualReloadAnimation")
					else
						self:FinishManualReload()
					end
				else
					self:FinishManualReload()
				end
			end
	else end
end

function SWEP:FinishManualReload()
	local ply = self:GetOwner()
	local loopseq = self:SelectWeightedSequence( ACT_SHOTGUN_RELOAD_FINISH )
	local looptime = self:SequenceDuration( loopseq )
	if self:IsValid() && ply:IsValid() && ply:Alive() then
		self:SetHoldType( self.HoldType )
		if IsFirstTimePredicted() then self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH) end
		
		self:SetNextPrimaryFire( CurTime() + looptime)
		self:SetNextSecondaryFire( CurTime() + looptime)
		
		timer.Simple( looptime, function() 
			self.ManuallyReloading = false
			self.IronCD = false
			self:ManuallyLoadAfterReload() 
		end)
	else end
end

function SWEP:ManuallyLoadAfterReload()
	local ply = self:GetOwner()
	if self:IsValid() && ply:IsValid() && ply:Alive() then
		if self:GetNWBool("reloadedEmpty") == true && self.LoadAfterReloadEmpty == true && self:IsValid() then
			if IsFirstTimePredicted() then 
				local loadseq = self:SelectWeightedSequence( ACT_SHOTGUN_PUMP )
				local loadtime = self:SequenceDuration( loadseq )
				self.Loading = true
				self:DoCustomManualLoadEvents()
				self:SetCycle(0)
				self:SetPlaybackRate(1)
				self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
				timer.Simple(loadtime, function() self.Loading = false end)
			end
		else end
	else end
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

function SWEP:DoImpactEffect(tr, dt)
	if self.HideImpacts == true then return true else return false end
end

function SWEP:GetShootPos()
	local attnum = self:LookupAttachment("muzzle")
	local attinfo = self:GetAttachment(attnum)
	
	if attinfo == nil then MsgC(Color(255, 0, 0), "Draconic: ".. self:GetModel() .." / ".. self.ViewModel .." does not have a muzzle attachment!") end
	
	return attinfo.Pos
end

function SWEP:GetShootAng()
	local attnum = self:LookupAttachment("muzzle")
	local attinfo = self:GetAttachment(attnum)
	
	return attinfo.Ang
end

function SWEP:DoCustomPrimaryAttackEvents()
end

function SWEP:DoCustomSecondaryAttackEvents()
end

function SWEP:DoCustomPrimary() -- called regardless of whether or not CanPrimaryAttack passes.
end

function SWEP:DoCustomSecondary() -- called regardless of whether or not CanSecondaryAttack passes, even if secondary is disabled.
end

function SWEP:DoScriptedSecondaryAttack()
end

function SWEP:DoCustomVentEvents()
end

function SWEP:DoCustomVentHoldEvents()
end

function SWEP:DoCustomFinishVentEvents()
end

function SWEP:DoCustomOverheatEvents()
end

function SWEP:DoCustomReloadEndEvents()
end

function SWEP:DoCustomReloadLoopEvents()
end

function SWEP:DoCustomReloadStartEvents()
end

function SWEP:DoCustomReload()
end

function SWEP:DoCustomManualLoadEvents()
end

-- ADDON COMPATIBILITY. DO NOT USE ANYTHING BELOW THIS LINE!
SWEP.ignorepcs = { -- NPCS to avoid targeting
	"npc_bullseye", -- Yes I know blocking this is a bad idea. I'll deal with it later, as instances where this matters are close to none.
	"npc_enemyfinder",
	"cycler_actor",
	"generic_actor",
	"info_npc_spawn_destination",
	"npc_furniture",
	"npc_heli_avoidbox",
	"npc_heli_avoidsphere",
	"npc_heli_nobomb",
	"npc_launcher",
	"npc_maker",
	"npc_missiledefense",
	"npc_particlestorm",
	"npc_spotlight",
	"npc_template_maker",
	"npc_template_maker",
}

function SWEP:AI_PrimaryAttack() -- Iv04
	if !self:CanPrimaryAttackNPC() then return end
	self:PrimaryAttack()
end

function SWEP:NPC_ServerNextFire() -- VJ
	local ply = self:GetOwner()
	if !ply.IsVJBaseSNPC then return end
	if CLIENT or (!IsValid(self) or !IsValid(ply) or !ply:IsNPC()) then return end
	if self.NPCBursting == true then return end
	if ply:GetActiveWeapon() != self then return end
	
	local enemy = ply:GetEnemy()
	
	if ply:GetActivity() == nil then return end
	
	if enemy == nil then return end
	if IsValid(enemy) && CTFK(self.ignorepcs, enemy:GetClass()) then ply:SetEnemy(nil, true) end
	if IsValid(enemy) && ply:GetEnemyLastTimeSeen(enemy) > CurTime() then return end
	
	if IsValid(enemy) && !ply:IsLineOfSightClear(enemy:GetPos()) then return end
	
	if IsValid(enemy) then
		self:PrimaryAttack()
	end
end

function SWEP:NPCAbleToShoot() -- VJ...
	if self:CanPrimaryAttackNPC() then return true end
end

function SWEP:NPC_Reload() -- Still VJ.
	local ply = self:GetOwner()
	local ht = self:GetHoldType()
	self:DoCustomReloadStartEvents()
	ply.NextThrowGrenadeT = ply.NextThrowGrenadeT + 2
	
	if VJ_AnimationExists(ply, ply:TranslateToWeaponAnim(VJ_PICK(ply.AnimTbl_WeaponReload))) == true then
		ply:VJ_ACT_PLAYACTIVITY(seq, true, 1, ply.WeaponReloadAnimationFaceEnemy, ply.WeaponReloadAnimationDelay, {SequenceDuration=dur, PlayBackRateCalculated=true})
	end
end