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
SWEP.Primary.MeleeMissActivity	= ACT_VM_HITCENTER
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
SWEP.Secondary.ScopeMat				= "overlays/draconic_scope.png"
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

SWEP.RegenAmmo			= false
SWEP.RegenAmmo_Delay	= 1
SWEP.RegenAmmo_Amount	= 1
SWEP.RegenAmmo_Interval	= 0.5

SWEP.AttachmentTable = {
	["AmmunitionTypes"] = {"drc_abp_generic"},
}

SWEP.AttachmentTitles = {
	["AmmunitionTypes"] = "Ammo",
	["Header"] = "Available Attachments"
}

-- "DO NOT TOUCH" Zone. Touching any of these settings in your SWEP WILL break something. So DON'T.
SWEP.DummyAttachmentTable = {
	["AmmunitionTypes"] = {},
}

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
	local charge = self:GetCharge()
	local sk = ply:KeyDown(IN_SPEED)
	local mk = (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK))
	local issprinting = sk && mk
	local wl = ply:WaterLevel()
	
	local curFOV = ply:GetFOV()
	local IronFOV = self.Secondary.IronFOV
	
	if CurTime() < self:GetNextPrimaryFire() then return end
		
	if ( self:Clip1() <= 0 ) then
		self:EmitSound ( self.Primary.EmptySound )
		self:SetNextPrimaryFire(CurTime() + 0.3)
		return false
	elseif ( self:Clip1() <= 0 ) && self.SecondaryAttacking == false then
		return true
	end
	
	if self:GetNWBool("Inspecting") == true then
		return false
	end
	
	if self:GetNWBool("Passive") == true then
		self:TogglePassive()
		self:SetNextPrimaryFire(CurTime() + 0.3)
		return false
	end

	if self.Loading == true or self.ManuallyReloading == true or self.SecondaryAttacking == true or self:GetNWBool("Passive") == true or self:GetNWBool("Inspecting") == true or ((self.DoesPassiveSprint == true or GetConVar("sv_drc_force_sprint"):GetString() == "1") && issprinting) or (self.Primary.CanFireUnderwater == false && wl >= 3) then
		if wl >= 3 then self:EmitSound ( "draconic.EmptyGeneric" ) end
		return false
	else 
		return true
	end
end

function SWEP:CanPrimaryAttackNPC()
	local npc = self:GetOwner()
	local BT = self.ActiveAttachments.AmmunitionTypes.t.BulletTable
	
	if self:Clip1() < 1 or self:GetNWInt("LoadedAmmo") < 1 then
	--	npc:SetSchedule(SCHED_RELOAD)
		self:LoadNextShot()	
		self:SetLoadedAmmo((self.DefaultPimaryClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul")))
--		self:SetClip1(self.DefaultPimaryClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))
		if (!npc:IsNextBot() && !npc.Draconic) && SERVER && !CLIENT then 
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

	if ( self:Clip2() <= 0 ) then
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
	
	self:DoCustomPrimary()
	
--	print(self, self.Primary.Projectile, self:GetClass(), self:GetOwner())
	
	local ply = self:GetOwner()
	
--	if !ply:IsPlayer() && !self:CanPrimaryAttackNPC() then return end
	
	local fireseq = self:SelectWeightedSequence( ACT_VM_PRIMARYATTACK )
	local firetime = self:SequenceDuration( fireseq )
	local scope = self:GetNWBool("ironsights")
	local passive = self:GetNWBool("Passive")
	local dc = self.Primary.UsesCharge
	local fm = self:GetNWString("FireMode")
	local charge = self:GetCharge()
	
	if (self.Primary.UsesCharge == true && ply:IsPlayer()) && ply:KeyDown(IN_USE) then self:DoMeleeSwing("gunmelee") else end
	if self.Loading == true or self.NPCLoading == true or self.ManuallyReloading == true then return end
	
	if ply:IsPlayer() && dc && self.ChargeType == "default" && charge < 99 then
	elseif ply:IsPlayer() && dc && (self.ChargeType == "dualaction" or self.ChargeType == "discharge") && charge >= 99 && self:CanOvercharge() && self:CanPrimaryAttack() then self:DoOvercharge()
	elseif ply:IsPlayer() && dc && self.ChargeType != "default" then
	else
		if ply:IsPlayer() then
			local vm = ply:GetViewModel()
			
			if self.Primary.CanMelee == true then
				if ply:KeyDown(IN_USE) && self:CanGunMelee() == true then
					self:DoMeleeSwing("gunmelee")
				else
				
				if fm == "Semi" or fm == "Auto" then
					self:CallShoot("primary")
				elseif fm == "Burst" && self.Bursting == false then
				self.Bursting = true
				timer.Simple(((60 / self.Primary.RPM) * self.FireModes_BurstShots * 2), function() self.Bursting = false end)
					for i=1, (self.FireModes_BurstShots) do
						timer.Simple(i * (60 / self.Primary.RPM) + 0.02, function()
							if !IsValid(self) or !IsValid(self.Owner) then return end
							if self:Clip1() <= 0 then return end
							if self.Loading == false then
								self:CallShoot("primary", true)
							end
						end)
					end
				else end
				
				if self.LoadAfterShot == true && (self:Clip1() > 0) then
					self.Loading = true
					timer.Simple( firetime, function() if ply:IsValid() && ply:Alive() then
						if !IsValid(ply) then return end
						if !IsValid(self) then return end
						if !ply:Alive() then return end
						ply:SetFOV(0, self.Secondary.ScopeZoomTime)
						self:LoadNextShot()
						end
					end)
				elseif self.LoadAfterShot == true && (self:Clip1() <= 0) then
					self.Loading = false
				elseif self.Loading == false then
				end
			end
			elseif self.Primary.CanMelee == false && self.Loading == false then
				if fm == "Semi" or fm == "Auto" then
					self:CallShoot("primary")
				elseif fm == "Burst" && self.Bursting == false then
				self.Bursting = true
				timer.Simple(((60 / self.Primary.RPM) * self.FireModes_BurstShots + 0.05), function() self.Bursting = false end)
					for i=0, (self.FireModes_BurstShots - 1) do
						timer.Simple(i * (60 / self.Primary.RPM), function()
							if !IsValid(self) or !IsValid(self.Owner) then return end
							if self.Loading == false then
								self:CallShoot("primary", true)
							end
						end)
					end
				else end
				if self.LoadAfterShot == true && (self:Clip1() > 0) then
					self.Loading = true
					ply:SetFOV(0, self.Secondary.ScopeZoomTime)
					timer.Simple( firetime, function()
						if !IsValid(self) then return end
						self:LoadNextShot()
					end)
				elseif self.LoadAfterShot == true && self.LoadAfterReloadEmpty == false && (self:Clip1() <=0) then
					self.Loading = true
					ply:SetFOV(0, self.Secondary.ScopeZoomTime)
					timer.Simple( firetime, function()
						self:LoadNextShot()
					end)
				elseif self.LoadAfterShot == true && (self:Clip1() <= 0) then
				self.Loading = false
				else end
			end
		elseif !ply:IsPlayer() or ply.IsVJBaseSNPC != nil then
		if self.NPCBursting == true then return false end
		if not self:CanPrimaryAttackNPC() then return end
			if SERVER then
				if (self:Clip1() > 0) then
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
					elseif (self:Clip1() <= 0) then end
				end
			end
		end
	end
end

function SWEP:NPCCharge()
	local ply = self:GetOwner()
	local amount = self.ChargeRate
	local charge = self:GetCharge()
	local chargetype = self.ChargeType
	local fraction = (100 / amount)
	
	if charge == nil then self:SetCharge(0) end
	if self.NPCCharging == nil then self.NPCCharging = false end
	
	if self.NPCCharging == false then
		--print("called & initiated charge")
		self.NPCCharging = true
		if self.ChargeSound != nil then self:EmitSound(self.ChargeSound) end
		for i=0,fraction do
			timer.Simple( i * 0.1, function()
				if !IsValid(self) then return end
				if !IsValid(ply) then return end
			--	print(self:GetCharge() + self.ChargeRate)
				self:SetCharge(self:GetCharge() + self.ChargeRate)
				
				
		--		print("Charging: ".. self:GetCharge() .."")
			end)
		end
	else
		if charge >= 100 then
			self:CallShoot("overcharge")
			self:SetCharge(0)
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
					self:SendWeaponAnim( ACT_SHOTGUN_PUMP )
					timer.Simple( loadtime + 0.025, function() if ply:IsValid() && ply:Alive() then self:FinishLoading() end end)
				else end
			end
		end
	else
		if ply:IsValid() && ply:Alive() then
			if CLIENT or SERVER then
				if ply:IsPlayer() then
					self:SendWeaponAnim( ACT_SHOTGUN_PUMP )
					timer.Simple( loadtime + 0.025, function() if ply:IsValid() && ply:Alive() then self:FinishLoading() end end)
				else end
			end
		end
	end
end

function SWEP:FinishLoading()
	self.Loading = false
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
	local dc = self.Secondary.UsesCharge
	
	self:DoCustomSecondary()
	if dc == true then return end
	
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
				if self:GetNWBool("Ironsights") == true then
					self:SetNetworkedBool( "Ironsights", true )
				else
					self:SetNetworkedBool( "Ironsights", false )
				end
			end
		elseif self.Secondary.Ironsights == false then
			if usekey && !sprintkey then
				self:SetFireMode()
			elseif sprintkey then
				self:TogglePassive()
			else
				self:CallShoot("secondary")
			end
		end
	end
end

function SWEP:TogglePassive()
	if !IsFirstTimePredicted() then return end
--	if SERVER then self:CallOnClient("TogglePassive") end
	local ply = self:GetOwner()
	self:EmitSound(self.FireModes_SwitchSound)
	
	if GetConVar("sv_drc_passives"):GetString() == "0" then return end
	
	if self:GetNWBool("Passive") == false then
		self.Passive = true
		self:DoPassiveHoldtype()
		self:SetNWBool("Passive", true)
		if self:GetNWBool("ironsights") == true then 
			ply:SetFOV(0, self.Secondary.ScopeZoomTime)
			self:SetNWBool("ironsights", false)
		else end
		ply:EmitSound("draconic.IronOutGeneric")
		if self:GetNWBool("Inspecting") == true then
			self:ToggleInspectMode()
		end
	else
		self.Loading = true
		self.Idle = 0
	--	self:SendWeaponAnim( ACT_VM_DRAW )
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

function SWEP:DoCustomFireMode(mode)
end

function SWEP:SetFireMode(mode, showhint)
	local ply = self:GetOwner()
	if !self:CanSwitchFireModes() then return end
	if self:GetNWString("FireMode") == nil then self:SetNWString("FireMode", "Semi") end
	
	if showhint == nil then showhint = true end
	if self.FireModes_CustomScripted == true then showhint = false end
	
	self:DoCustomFireMode(mode)
	
	if self.FireModes_CanAuto == true or self.FireModes_CanBurst == true or self.FireModes_CanSemi == true then
		if showhint == true then timer.Simple(0.05, function() self:DisplayFireMode() end) end
	end
	
	if self.FireModes_CustomScripted == true then
		if mode == "Semi" then
			self:SetNWString("FireMode", "Semi")
		elseif mode == "Auto" then
			self:SetNWString("FireMode", "Auto")
		elseif mode == "Burst" then
			self:SetNWString("FireMode", "Burst")
		end
	end
	
	if self.FireModes_CustomScripted == true then return end
	
	if mode == "Semi" then
		if self.FireModes_CanSemi == true then self:SetNWString("FireMode", "Semi") end
	elseif mode == "Auto" then
		if self.FireModes_CanAuto == true then self.Primary.Automatic = true self:SetNWString("FireMode", "Auto") end
	elseif mode == "Burst" then
		if self.FireModes_CanBurst == true then self:SetNWString("FireMode", "Burst") end
	elseif mode == nil then
		local fmode = self:GetNWString("FireMode")
		
		if fmode == "Semi" then
			if self.FireModes_CanAuto == true then
				self.Primary.Automatic = true
				self:SetNWString("FireMode", "Auto")
			elseif self.FireModes_CanBurst == true then
				self.Primary.Automatic = false
				self:SetNWString("FireMode", "Burst")
			end
		elseif fmode == "Auto" then
			if self.FireModes_CanBurst == true then
				self.Primary.Automatic = false
				self:SetNWString("FireMode", "Burst")
			elseif self.FireModes_CanSemi == true then
				self.Primary.Automatic = false
				self:SetNWString("FireMode", "Semi")
			end
		elseif fmode == "Burst" then
			if self.FireModes_CanSemi == true then
				self.Primary.Automatic = false
				self:SetNWString("FireMode", "Semi")
			elseif self.FireModes_CanAuto == true then
				self.Primary.Automatic = true
				self:SetNWString("FireMode", "Auto")
			end
		end
	end
end


function SWEP:DisplayFireMode()
local ply = self:GetOwner()
local string = self:GetNWString("FireMode")
	self:EmitSound(self.FireModes_SwitchSound)
	
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
	if !ply:IsPlayer() then self:DoReload() return end
	local usekey = ply:KeyDown(IN_USE)
	local reloadkey = ply:KeyDown(IN_RELOAD)
	local walkkey = ply:KeyDown(IN_WALK)
	local sprintkey = ply:KeyDown(IN_SPEED)
	local BT = self.ActiveAttachments.AmmunitionTypes.t.BulletTable
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
		elseif reloadkey && !sprintkey && self.ManuallyReloading == false && self.Loading == false && self.ManualReload == true && ( self:Clip1() < CM ) then
			if ( ply:GetAmmoCount(self.Primary.Ammo) ) <= 0 then
			else
					self:StartManualReload()
					ply:SetFOV(0, 0.05)
					self:SetNWBool( "Ironsights", false )
					if self:Clip1() <= 0 then
						self:SetNWBool("reloadedEmpty", true)
					else
						self:SetNWBool("reloadedEmpty", false)
					end
					return true
			end
		elseif reloadkey && !sprintkey && self.ManuallyReloading == false && self.Loading == false && self.ManualReload == false && ( self:Clip1() < CM ) then
				if ( self:Clip1() < CM ) && self:Ammo1() > 0 then
					self:DoReload()
					ply:SetFOV(0, 0.05)
					self:SetNWBool( "Ironsights", false )
					if self:Clip1() <= 0 then
						self:SetNWBool("reloadedEmpty", true)
					else
						self:SetNWBool("reloadedEmpty", false)
					end
					return true
				elseif ( self:Clip1() < CM ) && self:Ammo1() > 1 then
				end
		elseif reloadkey && sprintkey && self.ManuallyReloading == false && self.Loading == false && ( self:Clip2() < self.Secondary.ClipSize ) && ply:GetAmmoCount(self.Secondary.Ammo) > 0 then
			if ( ply:GetAmmoCount(self.Secondary.Ammo) ) <= 0 then
			else
				ply:SetFOV(0, 0.05)
				self:ReloadSecondary()
			end
		end
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
		ply:RemoveAmmo( (self.Secondary.ClipSize - self:Clip2()), self.Secondary.Ammo)
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
	local BT = self.ActiveAttachments.AmmunitionTypes.t.BulletTable
	local CM = math.Round(self.DefaultPimaryClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))
	local LeftHand = ply:LookupBone("ValveBiped.Bip01_L_Hand")
	local RightHand = ply:LookupBone("ValveBiped.Bip01_R_Hand")
	local vm = nil
	
	if ply:IsPlayer() then
		vm = ply:GetViewModel()
		vm:SetPlaybackRate( 1 )
	end
	
	if self:IsValid() && ply:IsValid() && ply:Health() > 0.001 then
		self.Loading = true
		self:SetNextPrimaryFire( CurTime() + reloadtime)
		self:SetNextSecondaryFire( CurTime() + reloadtime)
		
		self.BloomValue = 1
		self:DoCustomReloadStartEvents()
		
		if self.SightsDown == true && CLIENT && self.Secondary.IronOutFP != nil then
			surface.PlaySound(Sound(self.Secondary.IronOutFP))
		end
		
		self:SetIronsights(false)
		self.SightsDown = false
		
		if SERVER then DRC:CallGesture(ply, GESTURE_SLOT_CUSTOM, self.Primary.ReloadAct) end
		
		self:SetIronsights(false, self.Owner)
		
		if self:Clip1() <= 0 then
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

		if ply:IsPlayer() then
			if ply:GetAmmoCount(self.Primary.Ammo) < CM then
			self:SetNWInt("LoadedAmmo", math.Clamp(self:Clip1() + ply:GetAmmoCount(self.Primary.Ammo), 0, CM))
			else
			self:SetNWInt("LoadedAmmo", math.Clamp(CM, 0, CM))
			end
		else
			self:SetNWInt("LoadedAmmo", CM)
		end
		
		if self:Clip1() <= 0 then
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
	
	if !(self:IsValid() && ply:IsValid() && ply:Health() > 0.001) then return end
--	if SERVER then self:CallOnClient("EndReload") end
	local BT = self.ActiveAttachments.AmmunitionTypes.t.BulletTable
	local CM = math.Round(self.DefaultPimaryClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))
	
	self.IdleTimer = CurTime()
	self.Loading = false
	self.IronCD = false
	self.LoopOutEmptyPlayed = false
	
	self.BloomValue = 0.25
	
	if !ply:IsPlayer() then return end
	
	if GetConVar("sv_drc_infiniteammo"):GetFloat() < 1 then
		if self.Primary.DropMagReload == false then
			ply:RemoveAmmo( (CM - self:Clip1()), self.Primary.Ammo)
		else
			ply:RemoveAmmo( CM, self.Primary.Ammo)
		end
	end
		
	if self.Passive == true then
		self:DoPassiveHoldtype()
	else
		self:SetHoldType( self.HoldType )
	end
		
	if self:GetNWBool("reloadedEmpty") == true && self.LoadAfterReloadEmpty == true then
		self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
	else end
	
	self:SetClip1( math.Clamp(self:GetNWInt("LoadedAmmo"), 0, CM) )
	self:DoCustomReloadEndEvents()
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
		self:SetNWBool("LoadedAmmo", self:GetNWBool("LoadedAmmo") + self.Primary.APS)
		self:SetClip1(self:GetNWInt("LoadedAmmo"))
		
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
	local BT = self.ActiveAttachments.AmmunitionTypes.t.BulletTable
	local CM = math.Round(self.DefaultPimaryClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))
	
	if self:IsValid() && ply:IsValid() && ply:Alive() then
			if self:Clip1() <= CM then
				if ply:KeyDown(IN_RELOAD) && self:Clip1() < CM then
					if ( ply:GetAmmoCount(self.Primary.Ammo) ) > 0 then
						self:DoManualReload(true)
--						self:CallOnClient("PlayManualReloadAnimation")
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
	if self:IsValid() && ply:IsValid() && ply:Health() > 0.01 then
		if self:GetNWBool("reloadedEmpty") == true && self.LoadAfterReloadEmpty == true && self:IsValid() then
			if IsFirstTimePredicted() then 
				local loadseq = self:SelectWeightedSequence( ACT_SHOTGUN_PUMP )
				local loadtime = self:SequenceDuration( loadseq )
				self.Loading = true
				self:DoCustomManualLoadEvents()
				self:SetCycle(0)
				self:SetPlaybackRate(1)
				self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
				timer.Simple(loadtime, function()
					self.Loading = false
				end)
				self:SetNWBool("NPCLoading", false)
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
	if !game.SinglePlayer() && SERVER then return true end
	if self.HideImpacts == true then return true else return false end
end

function SWEP:GetShootPos()
	local attnum = self:LookupAttachment("muzzle")
	local attinfo = self:GetAttachment(attnum)
	
	if attinfo == nil then 
		MsgC(Color(255, 0, 0), "Draconic: ".. self:GetModel() .." / ".. self.ViewModel .." does not have a muzzle attachment!")
		attinfo = {
			["Pos"] = self:GetPos(),
			["Ang"] = Angle()
		}
	end
	
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
	["npc_bullseye"] = true, -- Yes I know blocking this is a bad idea. I'll deal with it later, as instances where this matters are close to none.
	["npc_enemyfinder"] = true,
	["cycler_actor"] = true,
	["generic_actor"] = true,
	["info_npc_spawn_destination"] = true,
	["npc_furniture"] = true,
	["npc_heli_avoidbox"] = true,
	["npc_heli_avoidsphere"] = true,
	["npc_heli_nobomb"] = true,
	["npc_launcher"] = true,
	["npc_maker"] = true,
	["npc_missiledefense"] = true,
	["npc_particlestorm"] = true,
	["npc_spotlight"] = true,
	["npc_template_maker"] = true,
	["npc_template_maker"] = true,
}

function SWEP:AI_PrimaryAttack() -- Iv04
	if !self:CanPrimaryAttackNPC() then return end
	self:PrimaryAttack()
end

function SWEP:NPC_ServerNextFire() -- VJ
	local ply = self:GetOwner()
--	if !ply.IsVJBaseSNPC then return end
--	if CLIENT or (!IsValid(self) or !IsValid(ply) or !ply:IsNPC()) then return end
--	if self.NPCBursting == true then return end
--	if ply:GetActiveWeapon() != self then return end
	
	local enemy
	if ply.GetEnemy then enemy = ply:GetEnemy() end
	
--	if ply:GetActivity() == nil then return end
	
--	if enemy == nil then return end
	if IsValid(enemy) && self.ignorepcs[enemy:GetClass()] then ply:SetEnemy(nil, true) end
--	if IsValid(enemy) && ply:GetEnemyLastTimeSeen(enemy) > CurTime() then return end
	
--	if IsValid(enemy) && !ply:IsLineOfSightClear(enemy:GetPos()) then return end
	
--	if IsValid(enemy) then
		self:PrimaryAttack()
--	end
end

function SWEP:NPCAbleToShoot() -- VJ...
--	if self:CanPrimaryAttackNPC() then return true end
	return true
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

function SWEP:CustomOnReload_Finish() -- Seriously, still VJ.
end