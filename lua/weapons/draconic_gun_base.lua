SWEP.Base				= "draconic_base"
SWEP.Gun				= "draconic_gun_base"

SWEP.HoldType			= "ar2" -- https://wiki.garrysmod.com/page/Hold_Types
SWEP.ReloadHoldType		= "ar2"
SWEP.Category			= "Draconic"
SWEP.PrintName			= "Draconic Gun Base"
SWEP.InfoName			= ""
SWEP.Auhtor				= "Vuthakral"
SWEP.Contact			= " https://discord.gg/6Y7WXrX // Steam: Vuthakral // Disc: Vuthakral#9761 "
SWEP.Purpose			= "SWEP Base"
SWEP.Instructions		= "why the fuck did you spawn this in this is a base and not a weapon you should actually use"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Slot				= 0
SWEP.SlotPos			= 0

SWEP.ViewModelFOV		= 54
SWEP.ViewModelFlip		= false
SWEP.EnableFOVKick		= false -- DO NOT USE. Need to make fully client side before this is doable. Will cause broken FOVs if used in its current state!
SWEP.FOVKickMult		= 1
SWEP.FOVKickTimeMult	= 1

SWEP.LoadAfterShot 			= false
SWEP.LoadAfterReloadEmpty	= false
SWEP.ManualReload			= false
SWEP.MagazineEntity			= nil

SWEP.FireModes_CanAuto	= true
SWEP.FireModes_CanBurst = false
SWEP.FireModes_CanSemi	= true
SWEP.FireModes_BurstShots = 3
SWEP.FireModes_SwitchSound = Sound("Weapon_AR2.Empty")

SWEP.Primary.NumShots 		= 1
SWEP.Primary.IronRecoilMul	= 0.5
SWEP.Primary.Spread			= 1
SWEP.Primary.SpreadDiv		= 90
SWEP.Primary.Force			= 0
SWEP.Primary.Damage			= 1
SWEP.Primary.Ammo			= "none"
SWEP.Primary.FireMode		= "auto"
SWEP.Primary.Automatic		= true
SWEP.Primary.RPM			= 857
SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.DropMagReload	= false
SWEP.Primary.APS			= 1
SWEP.Primary.Tracer			= "Tracer" -- https://wiki.garrysmod.com/page/Effects
SWEP.Primary.ImpactEffect	= nil
SWEP.Primary.SoundIsLooped	= false
SWEP.Primary.Sound = Sound("weapon_smg1.Single")
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
SWEP.Primary.MeleeDamage		= 12
SWEP.Primary.MeleeDamageType	= DMG_CLUB
SWEP.Primary.MeleeRange			= 16.5
SWEP.Primary.MeleeForce			= 5
SWEP.Primary.MeleeDelayMiss		= 0.42
SWEP.Primary.MeleeDelayHit 		= 0.54
SWEP.Primary.CanAttackCrouched = false
SWEP.Primary.MeleeHitActivity	= ACT_VM_PRIMARYATTACK 
SWEP.Primary.MeleeMissActivity	= ACT_VM_PRIMARYATTACK 
SWEP.Primary.MeleeHitDelay		= 0.07

SWEP.Secondary.Ironsights	= false
SWEP.Secondary.SightsSuppressAnim = false
SWEP.Secondary.Scoped		= false
SWEP.Secondary.ScopeMat		= "overlays/draconic_scope"
SWEP.Secondary.IronFOV		= 60
SWEP.Secondary.ScopeZoomTime = 0.15

SWEP.Secondary.NumShots 		= 0
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
SWEP.Secondary.AutoReload		= true
SWEP.Secondary.DoReloadAnimation = true
SWEP.Secondary.RPM				= 444
SWEP.Secondary.ClipSize			= 18
SWEP.Secondary.DefaultClip		= 18
SWEP.Secondary.DropMagReload	= false
SWEP.Secondary.APS				= 1
SWEP.Secondary.Tracer			= 1 -- https://wiki.garrysmod.com/page/Enums/TRACER
SWEP.Secondary.Sound 			= Sound("")
SWEP.Secondary.ChargeSound 		= Sound("")

SWEP.Secondary.Projectile			 = "" -- rj_plasmanade
SWEP.Secondary.ProjSpeed			 = 750
SWEP.Secondary.ProjInheritVelocity = true
SWEP.Secondary.ProjectileSpawnDelay = 0

-- Settings for NPCs
SWEP.NPCBurstShots = 0
SWEP.JackalSniper = false

-- "DO NOT TOUCH" Zone. Touching any of these settings in your SWEP WILL break something. So DON'T.
SWEP.Loading = false
SWEP.IronCD = false
SWEP.FireDelay = 0
SWEP.ManuallyReloading = false
SWEP.SecondaryAttacking = false
SWEP.Bursting = false

function SWEP:CanPrimaryAttack()
local ply = self:GetOwner()
	if CLIENT or SERVER then
	local curFOV = ply:GetFOV()
	local IronFOV = self.Secondary.IronFOV
	
		if ( self.Weapon:Clip1() <= 0 ) && self.InfAmmo == false then
			self:EmitSound ( "draconic.EmptyGeneric" )
			self:SetNextPrimaryFire (( CurTime() + 0.3 ))
			return false
		elseif ( self.Weapon:Clip1() <= 0 ) && self.SecondaryAttacking == false && self.InfAmmo == true then
			return true
		end
		if self.Weapon:GetNWBool("ironsights") == false then
			if self.EnableFOVKick == true then
				ply:SetFOV(curFOV + 1 * self.FOVKickMult, 0.01 * self.FOVKickTimeMult)
				timer.Simple (0.01 * self.FOVKickTimeMult, function() self:unKick() end)
			elseif self.EnableFOVKick == false then
			end
		elseif self.Weapon:GetNWBool("ironsights") == true then
			if self.EnableFOVKick == true then
				ply:SetFOV(IronFOV + 1 * (self.FOVKickMult / 2), 0.01 * self.FOVKickTimeMult)
				timer.Simple (0.01 * self.FOVKickTimeMult, function() self:unKick() end)
			elseif self.EnableFOVKick == false then
			end
		end
		if self.Loading == true or self.ManuallyReloading == true or self.SecondaryAttacking == true or self.Weapon:GetNWBool("Passive") == true then
			return false
		else 
			return true
		end
	else end
end

function SWEP:CanPrimaryAttackNPC()
local npc = self:GetOwner()

	if self.Weapon:Clip1() <= 0 or npc:GetActivity() == ACT_RELOAD or self.Weapon:GetNWBool("NPCLoading") == true then
		self:LoadNextShot()
		return false
	end
	return true
end

function SWEP:CanSecondaryAttack()
local ply = self:GetOwner()
local curFOV = ply:GetFOV()
local IronFOV = self.Secondary.IronFOV

	if ( self.Weapon:Clip2() <= 0 ) then
		self:EmitSound ( "draconic.EmptyGeneric" )
		self:SetNextPrimaryFire (( CurTime() + 0.3 ))
		return false
	end
	if self.Loading == true or self.ManuallyReloading == true or self.Passive == true then
		return false
	else
		if self.EnableFOVKick == true then
			ply:SetFOV(curFOV + 1 * self.FOVKickMult, 0.01 * self.FOVKickTimeMult)
			timer.Simple (0.01 * self.FOVKickTimeMult, function() self:unKick() end)
		elseif self.EnableFOVKick == false then
			ply:SetFOV(curFOV * 0, 0)
		end
		return true
	end
end

function SWEP:unKick()
local ply = self:GetOwner()
local curFOV = ply:GetFOV()
	ply:SetFOV(curFOV - 1 * self.FOVKickMult, 0)
end


function SWEP:PrimaryAttack()
	local ply = self:GetOwner()
	local fireseq = self:SelectWeightedSequence( ACT_VM_PRIMARYATTACK )
	local firetime = self:SequenceDuration( fireseq )
	
if ply:IsPlayer() then
	if self.Primary.CanMelee == true then
		if ply:KeyDown(IN_USE) then
			self:DoMelee()
		else
			if self.Loading == false then
				if self.Weapon:GetNWString("FireMode") == "Semi" or self.Weapon:GetNWString("FireMode") == "Auto" then
				self:DoPrimaryAttack()
				elseif self.Weapon:GetNWString("FireMode") == "Burst" && self.Bursting == false then
				self.Bursting = true
				timer.Simple(((60 / self.Primary.RPM) * self.FireModes_BurstShots + 0.05), function() self.Bursting = false end)
					for i=0, (self.FireModes_BurstShots - 1) do
						timer.Simple(i * (60 / self.Primary.RPM), function()
							if not IsValid(self) or not IsValid(self.Owner) then
								return
								end
							if not self:CanPrimaryAttack() then
								return
							end
							if self.Loading == false then
								if SERVER or game.SinglePlayer() then
								self:DoPrimaryAttack()
								else end
							end
						end)
					end
				else end
					if self.LoadAfterShot == true && (self.Weapon:Clip1() > 0) then
						self.Loading = true
						timer.Simple( firetime, function() self:LoadNextShot() end)
					elseif self.LoadAfterShot == true && (self.Weapon:Clip1() <= 0) then
						self.Loading = false
					elseif self.Loading == false then
					end
			end
		end
	elseif self.Primary.CanMelee == false && self.Loading == false then
		if self.Weapon:GetNWString("FireMode") == "Semi" or self.Weapon:GetNWString("FireMode") == "Auto" then
		self:DoPrimaryAttack()
		elseif self.Weapon:GetNWString("FireMode") == "Burst" && self.Bursting == false then
		self.Bursting = true
		timer.Simple(((60 / self.Primary.RPM) * self.FireModes_BurstShots + 0.05), function() self.Bursting = false end)
			for i=0, (self.FireModes_BurstShots - 1) do
				timer.Simple(i * (60 / self.Primary.RPM), function()
					if not IsValid(self) or not IsValid(self.Owner) then
						return
						end
					if not self:CanPrimaryAttack() then
						return
					end
					if self.Loading == false then
						self:DoPrimaryAttack()
					end
				end)
			end
		else end
		if self.LoadAfterShot == true && (self.Weapon:Clip1() > 0) then
			self.Loading = true
			timer.Simple( firetime, function() self:LoadNextShot() end)
		elseif self.LoadAfterShot == true && self.LoadAfterReloadEmpty == false && (self.Weapon:Clip1() <=0) then
			self.Loading = true
			timer.Simple( firetime, function() self:LoadNextShot() end)
		elseif self.LoadAfterShot == true && (self.Weapon:Clip1() <= 0) then
		self.Loading = false
		else end
	end
elseif !ply:IsPlayer() then
if SERVER then
	if (self.Weapon:Clip1() > 0) then
	if self.FireDelay > CurTime() then
		return
	end
		if self.Owner:IsNPC() and IsValid(self.Owner:GetEnemy()) then
			self.FireDelay = (CurTime() + (60 / self.Primary.RPM))
			for i=0, self.NPCBurstShots do
				timer.Simple(i + 0.1, function()
					if not IsValid(self) or not IsValid(self.Owner) then
						return
					end
					if not self.Owner:GetEnemy() or not self:CanPrimaryAttackNPC() then
						return
					end
					if self.Loading == false then
						self:DoPrimaryAttackNPC()
						if self.LoadAfterShot == true then
							self.Loading = true
							timer.Simple( 0.01, function() self.Weapon:SetNWBool("NPCLoading", true) end)
						else end
					end
				end)
			end
		end
	elseif (self.Weapon:Clip1() <= 0) then
	end
else end
end
end


function SWEP:LoadNextShot()
	local ply = self:GetOwner()
	local loadseq = self:SelectWeightedSequence( ACT_SHOTGUN_PUMP )
	local loadtime = self:SequenceDuration( loadseq )

	if CLIENT or SERVER then
		if ply:IsPlayer() then
			self.Weapon:SendWeaponAnim( ACT_SHOTGUN_PUMP )
			timer.Simple( loadtime + 0.025, function() self:FinishLoading() end)
		else end
	end
	
	if ply:IsNPC() then
		timer.Simple( 1, function() self.Weapon:SetNWBool("NPCLoading", false) self.Loading = false end)
	else end
end

function SWEP:FinishLoading()
	self.Loading = false
end

function SWEP:DoMelee()
local ply = self:GetOwner()
local cv = ply:Crouching()
	if cv == false then
		self:SetHoldType( self.HoldType )
	elseif cv == true then
		self:SetHoldType( self.CrouchHoldType )
	end
self:EmitSound(Sound(self.Primary.MeleeSwingSound))

local tr = util.TraceLine( {
	start = self.Owner:GetShootPos(),
	endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.Primary.MeleeRange*4,
	filter = self.Owner,
	mask = MASK_SHOT_HULL,
} )
if !IsValid( tr.Entity ) then
	tr = util.TraceHull( {
	start = self.Owner:GetShootPos(),
	endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.Primary.MeleeRange*4,
	filter = self.Owner,
	mins = Vector( -16, -16, 0 ),
	maxs = Vector( 16, 16, 0 ),
	mask = MASK_SHOT_HULL,
} )
end

timer.Simple( self.Primary.MeleeHitDelay, function() self:DoMeleeImpact() end)

if !tr.Hit then
	self.Weapon:SendWeaponAnim( self.Primary.MeleeMissActivity )
	self:SetNextPrimaryFire( CurTime() + self.Primary.MeleeDelayMiss )
	self:SetNextPrimaryFire( CurTime() + self.Primary.MeleeDelayMiss )
end
if tr.Hit then
	self.Weapon:SendWeaponAnim( self.Primary.MeleeHitActivity )
	self:SetNextPrimaryFire( CurTime() + self.Primary.MeleeDelayHit )
	self:SetNextPrimaryFire( CurTime() + self.Primary.MeleeDelayHit )
end
	self.Idle = 0
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:DoMeleeImpact()
	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.Primary.MeleeRange*4,
		filter = self.Owner,
		mask = MASK_SHOT_HULL,
} )

if ( tr.Hit ) then
	util.Decal(self.Primary.MeleeImpactDecal, tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)  
end

local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Distance = self.Primary.Distance
	bullet.Spread = Vector( 0, 0, 0 )
	bullet.Tracer = 0
	bullet.Force = self.Primary.Force
	bullet.Damage = 0
	bullet.AmmoType = "none"

if SERVER then
	if IsValid( tr.Entity ) then
		local dmg = DamageInfo()
		local attacker = self.Owner
		if !IsValid( attacker ) then
			attacker = self
		end
			dmg:SetAttacker( attacker )
			dmg:SetInflictor( self )
			dmg:SetDamage( self.Primary.MeleeDamage )
			dmg:SetDamageForce( self.Owner:GetForward() * self.Primary.MeleeForce )
			dmg:SetDamageType( self.Primary.MeleeDamageType )
			tr.Entity:TakeDamageInfo( dmg )
end
end

	if ( tr.Hit ) then
		if tr.Entity:IsPlayer() or string.find(tr.Entity:GetClass(),"npc") or string.find(tr.Entity:GetClass(),"prop_ragdoll") or string.find(tr.Entity:GetClass(),"prop_physics") then
			if string.find(tr.Entity:GetClass(),"prop_physics") then
				self:EmitSound(Sound(self.Primary.MeleeHitSoundEnt))
			else
				self:EmitSound(Sound(self.Primary.MeleeHitSoundFlesh))
			end
				self.Owner:FireBullets(bullet)	
			else
				self:EmitSound(Sound(self.Primary.MeleeHitSoundWorld))
			end
	end
end

function SWEP:DoPrimaryAttack()
local ply = self:GetOwner()
local eyeang = ply:EyeAngles()
local cv = ply:Crouching()
local loopseq = self:SelectWeightedSequence( ACT_VM_PRIMARYATTACK )
local looptime = self:SequenceDuration( loopseq )
local LeftHand = ply:LookupBone("ValveBiped.Bip01_L_Hand")
local RightHand = ply:LookupBone("ValveBiped.Bip01_R_Hand")

local tr = util.GetPlayerTrace(ply)
local trace = util.TraceLine( tr )


	if ( self:CanPrimaryAttack() ) then
	
	self.Idle = 0
	self:DoCustomPrimaryAttackEvents()
	
	if self.Primary.isvFire == false then
		if self.Weapon:GetNWBool("ironsights") == false && cv == false then
			if CLIENT then
				eyeang.pitch = eyeang.pitch - ((math.Rand(self.Primary.RecoilUp / 1.85, self.Primary.RecoilUp * 1.62)) - (math.Rand(self.Primary.RecoilDown / 1.85, self.Primary.RecoilDown * 1.85) * FrameTime()))
				eyeang.yaw = eyeang.yaw - (math.Rand( self.Primary.RecoilHoriz, (self.Primary.RecoilHoriz * -0.81) ) * FrameTime())
			else end
			self.Owner:ViewPunch(Angle( -self.Primary.Kick, 0, 0 ))
		elseif self.Weapon:GetNWBool("ironsights") == true && cv == false then
			if CLIENT then
				eyeang.pitch = eyeang.pitch - (((math.Rand(self.Primary.RecoilUp / 1.5, self.Primary.RecoilUp * 1.5)) - (math.Rand(self.Primary.RecoilDown / 1.5, self.Primary.RecoilDown * 1.5) * FrameTime())) * self.Primary.IronRecoilMul)
				eyeang.yaw = eyeang.yaw - (math.Rand( self.Primary.RecoilHoriz, (self.Primary.RecoilHoriz * -1) ) * FrameTime())
			end
			self.Owner:ViewPunch(Angle( (-self.Primary.Kick * 0.69) * self.Primary.IronRecoilMul, 0, 0 ))
		elseif self.Weapon:GetNWBool("ironsights") == false && cv == true then
			if CLIENT then
				eyeang.pitch = eyeang.pitch - ((math.Rand(self.Primary.RecoilUp / 1.5, self.Primary.RecoilUp * 1.5)) - (math.Rand(self.Primary.RecoilDown / 1.5, self.Primary.RecoilDown * 1.5) * FrameTime()))
				eyeang.yaw = eyeang.yaw - (math.Rand( self.Primary.RecoilHoriz, (self.Primary.RecoilHoriz * -1) ) * FrameTime())
			end
			self.Owner:ViewPunch(Angle( -self.Primary.Kick * 0.75, 0, 0 ))
		elseif self.Weapon:GetNWBool("ironsights") == true && cv == true then
			if CLIENT then
				eyeang.pitch = eyeang.pitch - (((math.Rand(self.Primary.RecoilUp / 1.5, self.Primary.RecoilUp * 0.9)) - (math.Rand(self.Primary.RecoilDown / 1.9, self.Primary.RecoilDown * 0.9) * FrameTime())) * self.Primary.IronRecoilMul)
				eyeang.yaw = eyeang.yaw - (math.Rand( self.Primary.RecoilHoriz, (self.Primary.RecoilHoriz * -1) ) * FrameTime())
			end
			self.Owner:ViewPunch(Angle( (-self.Primary.Kick * 0.42) * self.Primary.IronRecoilMul, 0, 0 ))
	end
		local bullet = {}
			bullet.Num = self.Primary.NumShots
			bullet.Src = self.Owner:GetShootPos()
			bullet.Dir = self.Owner:GetAimVector()
			if self.Weapon:GetNWString("FireMode") != "Burst" then
				bullet.Spread = Vector( self.Primary.Spread / self.Primary.SpreadDiv, self.Primary.Spread / self.Primary.SpreadDiv, 0 )
			else
				bullet.Spread = math.Rand(-Vector( math.Rand(self.Primary.Spread / self.Primary.SpreadDiv, -self.Primary.Spread / self.Primary.SpreadDiv), math.Rand(-self.Primary.Spread / self.Primary.SpreadDiv, self.Primary.Spread / self.Primary.SpreadDiv), 0 ), Vector( math.Rand(self.Primary.Spread / self.Primary.SpreadDiv, -self.Primary.Spread / self.Primary.SpreadDiv), math.Rand(-self.Primary.Spread / self.Primary.SpreadDiv, self.Primary.Spread / self.Primary.SpreadDiv), 0 ))
			end
			bullet.Tracer = self.Primary.Tracer
			bullet.Force = self.Primary.Force
			bullet.Damage = self.Primary.Damage
			self.AmmoType = self.Primary.AmmoType
				
	if self.Primary.Projectile == nil then
		if self.Weapon:GetNWString("FireMode") == "Burst" && SERVER then
			self.Owner:FireBullets ( bullet )
		elseif CLIENT && self.Weapon:GetNWString("FireMode") != "Burst" && CLIENT or SERVER then
			self.Owner:FireBullets ( bullet )
		else end
	else
	local aim = self.Owner:GetAimVector()
	local side = aim:Cross(Vector(0,0,0))
	local up = side:Cross(aim)
	local pos = self.Owner:GetShootPos() + side * 0 + up * 0
		if SERVER then
			local proj = ents.Create(self.Primary.Projectile)
			if !proj:IsValid() then return false end
			proj:SetAngles(self.Owner:EyeAngles())
			proj:SetPos(pos)
			proj:SetOwner(self.Owner)
			proj:Spawn()
			proj.Owner = self.Owner
			proj:Activate()
			eyes = self.Owner:EyeAngles()
			local phys = proj:GetPhysicsObject()
			if self.Primary.ProjInheritVelocity == true then
				phys:SetVelocity((self.Owner:GetAimVector() * self.Primary.ProjSpeed) + ply:GetVelocity())
			else
				phys:SetVelocity(self.Owner:GetAimVector() * self.Primary.ProjSpeed)
			end
		end
	end
	self.Weapon:EmitSound(Sound(self.Primary.Sound))
	elseif self.Primary.isvFire == true then
	self:ShootFire() 
		if SERVER then
			if (self.Owner:KeyPressed(IN_ATTACK) || !self.LoopingFireSound) then
				self.LoopingFireSound = CreateSound(self.Owner, self.Primary.Sound)
			end
		if (self.LoopingFireSound) then self.LoopingFireSound:Play() end
		end
	end
	self.Owner:MuzzleFlash()
	ply:SetAnimation( PLAYER_ATTACK1 )
	if self.Secondary.SightsSuppressAnim == false && self.Weapon:GetNWBool("ironsights") == false then
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	elseif self.Secondary.SightsSuppressAnim == false && self.Weapon:GetNWBool("ironsights") == true then
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	elseif self.Secondary.SightsSuppressAnim == true && self.Weapon:GetNWBool("ironsights") == false then
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	elseif self.Secondary.SightsSuppressAnim == true && self.Weapon:GetNWBool("ironsights") == true then
	end
	if CLIENT then
		ply:SetEyeAngles( eyeang )
	else end
		self.Weapon:SetNWInt("LoadedAmmo", math.Clamp((self.Weapon:GetNWInt("LoadedAmmo") - self.Primary.APS), 0, self.Primary.ClipSize))
		self:TakePrimaryAmmo( self.Primary.APS )
		self:SetNextPrimaryFire( CurTime() + (60 / self.Primary.RPM) )
		self:MuzzleFlash()
		self:ShootEffects( trace.HitPos, trace.HitNormal, trace.Entity, trace.PhysicsBone )
	timer.Simple(looptime, function() self.Idle = 1 end)
	else return end
end

function SWEP:DoPrimaryAttackNPC()
local npc = self:GetOwner()
local eyeang = npc:EyeAngles()
local tgt = npc:GetEnemy()
local tgtclass = tgt:GetClass()
local ctrpos = tgt:WorldSpaceCenter()
local eyepos = tgt:EyePos()
local muzzle = self:LookupAttachment("muzzle")
local tgtpos = nil
local accuracy = Vector( self.Primary.Spread / self.Primary.SpreadDiv, self.Primary.Spread / self.Primary.SpreadDiv, 0 )
local AccuracyHorizmath = math.random((self.Primary.Kick * -self.Primary.RecoilHoriz), (self.Primary.Kick * self.Primary.RecoilHoriz))
local AccuracyVertmath = math.random((math.Rand((self.Primary.Kick * -self.Primary.RecoilUp), (self.Primary.Kick * self.Primary.RecoilUp))), (math.Rand((self.Primary.Kick * -self.Primary.RecoilDown), (self.Primary.Kick * self.Primary.RecoilDown))))

local tr = util.GetPlayerTrace(npc)
local trace = util.TraceLine( tr )

if self.JackalSniper == false then
	if tgt:IsPlayer() or tgtclass == "npc_citizen" or tgtclass == "npc_combine_s" or tgtclass == "npc_metropolice" or tgtclass == "npc_helicopter" or tgtclass == "npc_strider" or tgtclass == "npc_ministrider" or tgtclass == "npc_hunter" or tgtclass == "npc_barnacle" or tgtclass == "npc_zombie_torso" or tgtclass == "npc_fastzombie_torso" or tgtclass == "monster_alien_controller" or tgtclass == "monster_scientist" or tgtclass == "monster_barney" then
		tgtpos = (eyepos - Vector(AccuracyHorizmath, 0, (AccuracyVertmath + math.random(5, 15))))
	elseif tgtclass == "npc_zombie" or tgtclass == "npc_fastzombie" or tgtclass == "npc_poisonzombie" or tgtclass == "npc_zombine" or tgtclass == "monster_human_grunt" or tgtclass == "npc_stalker" or tgtclass == "monster_tentacle" or tgtclass == "monster_alien_grunt" or tgtclass == "monster_human_assassin" or tgtclass == "monster_alien_slave" or tgtclass == "monster_zombie" then
		tgtpos = (ctrpos + Vector(AccuracyHorizmath, 0, (AccuracyVertmath + math.Rand(10, 17))))
	elseif tgtclass == "npc_headcrab" or tgtclass == "npc_headcrab_black" or tgtclass == "npc_headcrab_fast" or tgtclass == "npc_manhack" or tgtclass == "npc_rollermine" or tgtclass == "npc_turret_floor" or tgtclass == "npc_cscanner" or tgtclass == "npc_clawscanner" or tgtclass == "npc_antlion_worker" or tgtclass == "npc_antlionguard" or tgtclass == "npc_antlionguardian" or tgtclass == "monster_sentry" or tgtclass == "monster_snark" or tgtclass == "monster_houndeye"  or tgtclass == "monster_babycrab" or tgtclass == "monster_bullchicken" or tgtclass == "monster_cockroach" or tgtclass == "monster_headcrab" or tgtclass == "monster_turret" or tgtclass == "monster_miniturret" or tgtclass == "npc_combinegunship" then
		tgtpos = ctrpos
	elseif tgtclass == "npc_antlion" then
		tgtpos = eyepos
	elseif tgtclass == "monster_gargantua" or tgtclass == "monster_nihilanth" or tgtclass == "monster_bigmomma" then
		tgtpos = (ctrpos + Vector(AccuracyHorizmath, 0, (AccuracyVertmath + math.random(6, 102))))
	else
		tgtpos = (ctrpos + Vector(AccuracyHorizmath, 0, (AccuracyVertmath + math.random(-5, 15))))
	end
elseif self.JackalSniper == true then
	tgtpos = eyepos - Vector(0, 0, 5)
end

if ( self:CanPrimaryAttackNPC() ) then
	local bullet = {}
		bullet.Num = self.Primary.NumShots
		bullet.Src = self.Owner:GetShootPos()
		if (npc:GetPos():Distance(tgt:GetPos()) > 150)  then -- if you're this close to a hostile NPC we cant properly do our artificial aiming and nothing will ever hit, so we resort to standard NPC accuracy.
			bullet.Dir = (tgtpos - self.Weapon:GetAttachment(muzzle).Pos):GetNormalized()
		else
			bullet.Dir = npc:GetAimVector()
		end
		if self.JackalSniper == false then
			bullet.Spread = Vector( (self.Primary.Spread / self.Primary.SpreadDiv), (self.Primary.Spread / self.Primary.SpreadDiv), 0 )
		elseif self.JackalSniper == true then
			bullet.Spread = Vector(0, 0, 0)
		end
		bullet.Tracer = self.Primary.Tracer
		bullet.Force = self.Primary.Force
		bullet.Damage = self.Primary.Damage
		
	self.AmmoType = self.Primary.AmmoType	
	if self.Primary.Projectile == nil then
		self.Owner:FireBullets ( bullet )
	else
	local aim = self.Owner:GetAimVector()
	local side = aim:Cross(Vector(0,0,0))
	local up = side:Cross(aim)
	local pos = self.Owner:GetShootPos() + side * 0 + up * 0
		if SERVER then
			local proj = ents.Create(self.Primary.Projectile)
			if !proj:IsValid() then return false end
			proj:SetAngles(self.Owner:EyeAngles())
			proj:SetPos(pos)
			proj:SetOwner(self.Owner)
			proj:Spawn()
			proj.Owner = self.Owner
			proj:Activate()
			eyes = self.Owner:EyeAngles()
			local phys = proj:GetPhysicsObject()
			if self.Primary.ProjInheritVelocity == true then
				phys:SetVelocity((self.Owner:GetAimVector() * self.Primary.ProjSpeed) + ply:GetVelocity())
			else
				phys:SetVelocity(self.Owner:GetAimVector() * self.Primary.ProjSpeed)
			end
		end
	end
	self.Owner:MuzzleFlash()
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	if self.Primary.NPCSound == nil then
		self.Weapon:EmitSound(Sound(self.Primary.Sound))
	else
		self.Weapon:EmitSound(Sound(self.Primary.NPCSound))
	end
	self.Weapon:SetNWInt("LoadedAmmo", (self.Weapon:GetNWInt("LoadedAmmo") - self.Primary.APS))
	self:TakePrimaryAmmo( self.Primary.APS )
	self:MuzzleFlash()
	self:ShootEffects( trace.HitPos, trace.HitNormal, trace.Entity, trace.PhysicsBone )
	self:SetNextPrimaryFire( CurTime() + (60 / self.Primary.RPM) )
	else return end
end

function SWEP:TakePrimaryAmmo( num )
	if ( self.Weapon:Clip1() <= 0 ) then
		if ( self:Ammo1() <= 0 ) then return end
		self.Owner:RemoveAmmo( num, self.Weapon:GetPrimaryAmmoType() )
	return end
	self.Weapon:SetClip1( self.Weapon:GetNWInt("LoadedAmmo"))
end

function SWEP:SecondaryAttack()
local ply = self:GetOwner()
local cv = ply:Crouching()
local usekey = ply:KeyDown(IN_USE)
local reloadkey = ply:KeyDown(IN_RELOAD)
local sprintkey = ply:KeyDown(IN_SPEED)
local fireseq = self:SelectWeightedSequence( ACT_VM_PRIMARYATTACK )
local firetime = self:SequenceDuration( fireseq )
	
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
			self:DoSecondaryAttack()
		end
	end
end

function SWEP:TogglePassive()
	local ply = self:GetOwner()
	local loopseq = self:SelectWeightedSequence( ACT_VM_DRAW )
	local looptime = self:SequenceDuration( loopseq )
	self.Weapon:EmitSound(self.FireModes_SwitchSound)
	
	if self.Passive == false then
		self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
		self.Passive = true
		self:DoPassiveHoldtype()
		self.Weapon:SetNWBool("Passive", true)
		if self.Weapon:GetNWBool("ironsights") == true then 
			ply:SetFOV(0, self.Secondary.ScopeZoomTime)
			self.Weapon:SetNWBool("ironsights", false)
		else end
		ply:EmitSound("draconic.IronOutGeneric")
	else
		self.Loading = true
		self.Idle = 0
		self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
		self:SetHoldType(self.HoldType)
		self.Passive = false
		self.Weapon:SetNWBool("Passive", false)
		ply:EmitSound("draconic.IronInGeneric")
		timer.Simple(looptime, function()
			self.Loading = false 
			self.Idle = 1
		end)
	end
end

function SWEP:DoPassiveHoldtype()
	if self.HoldType == "pistol" or self.HoldType == "revolver" or self.HoldType == "magic" or self.HoldType == "knife" or self.HoldType == "melee" or self.HoldType == "melee2" or self.HoldType == "slam" or self.HoldType == "fist" or self.HoldType == "grenade" or self.HoldType == "duel" then
		self:SetHoldType("normal")
	elseif self.HoldType == "smg" or self.HoldType == "ar2" or self.HoldType == "rpg" or self.HoldType == "crossbow" or self.HoldType == "shotgun" or self.HoldType == "physgun" then
		self:SetHoldType("passive")
	end
end

function SWEP:SetFireMode()
local ply = self:GetOwner()
local string = self.Weapon:GetNWString("FireMode")

	if self.FireModes_CanAuto == true or self.FireModes_CanBurst == true or self.FireModes_CanSemi == true then
	timer.Simple(0.05, function() self:DisplayFireMode() end)
	end

	if string == "Semi" then
		if self.FireModes_CanAuto == true then
			timer.Simple(0.01, function()
				self.Weapon:SetNWString("FireMode", "Auto")
				self.Primary.Automatic = true end)
			if CLIENT or game.SinglePlayer() then  else end
		elseif self.FireModes_CanBurst == true && self.FireModes_CanAuto == false then
			timer.Simple(0.01, function()
				self.Weapon:SetNWString("FireMode", "Burst")
				self.Primary.Automatic = false end)
			if CLIENT or game.SinglePlayer() then  else end
		else end
	elseif string == "Burst" then
		if self.FireModes_CanSemi == true then
			timer.Simple(0.01, function()
				self.Weapon:SetNWString("FireMode", "Semi")
				self.Primary.Automatic = false end)
			if CLIENT or game.SinglePlayer() then  else end
		elseif self.FireModes_CanAuto == true && self.FireModes_CanSemi == false then
			timer.Simple(0.01, function()
				self.Weapon:SetNWString("FireMode", "Auto")
				self.Primary.Automatic = true end)
			if CLIENT or game.SinglePlayer() then  else end
		else end
	elseif string == "Auto" then
		if self.FireModes_CanBurst == true then
			timer.Simple(0.01, function()
				self.Weapon:SetNWString("FireMode", "Burst")
				self.Primary.Automatic = false end)
			if CLIENT or game.SinglePlayer() then  else end
		elseif self.FireModes_CanSemi == true && self.FireModes_CanBurst == false then
			timer.Simple(0.01, function()
				self.Weapon:SetNWString("FireMode", "Semi")
				self.Primary.Automatic = false end)
			if CLIENT or game.SinglePlayer() then  else end
		else end
	else end
end

function SWEP:DisplayFireMode()
local ply = self:GetOwner()
local string = self.Weapon:GetNWString("FireMode")
	self.Weapon:EmitSound(self.FireModes_SwitchSound)
	
	if CLIENT or game.SinglePlayer() then
		if self.InfoName == "" then
			ply:PrintMessage( HUD_PRINTCENTER, "Switched to "..string..".")
		else
			ply:PrintMessage( HUD_PRINTCENTER, ""..self.InfoName.." switched to "..string..".")
		end
	else end
end

function SWEP:DoSecondaryAttack()
local ply = self:GetOwner()
local eyeang = ply:EyeAngles()
local cv = ply:Crouching()
local curFOV = ply:GetFOV()
local IronFOV = self.Secondary.IronFOV
local loopseq = self:SelectWeightedSequence( ACT_VM_SECONDARYATTACK )
local looptime = self:SequenceDuration( loopseq )
	
	if ( self:CanSecondaryAttack() ) then
	
	self:DoCustomSecondaryAttackEvents()

	if self.Primary.isvFire == false then
	timer.Simple(self.Secondary.ProjectileSpawnDelay, function()
		if cv == false then
			eyeang.pitch = eyeang.pitch - ((math.Rand(self.Secondary.RecoilUp / 1.85, self.Secondary.RecoilUp * 1.62)) - (math.Rand(self.Secondary.RecoilDown / 1.85, self.Secondary.RecoilDown * 1.85) * FrameTime()))
			eyeang.yaw = eyeang.yaw - (math.Rand( self.Secondary.RecoilHoriz, (self.Secondary.RecoilHoriz * -0.81) ) * FrameTime())
			self.Owner:ViewPunch(Angle( -self.Secondary.Kick, 0, 0 ))
		elseif cv == true then
			eyeang.pitch = eyeang.pitch - ((math.Rand(self.Secondary.RecoilUp / 1.5, self.Secondary.RecoilUp * 1.5)) - (math.Rand(self.Secondary.RecoilDown / 1.5, self.Secondary.RecoilDown * 1.5) * FrameTime()))
			eyeang.yaw = eyeang.yaw - (math.Rand( self.Secondary.RecoilHoriz, (self.Secondary.RecoilHoriz * -1) ) * FrameTime())
			self.Owner:ViewPunch(Angle( -self.Secondary.Kick * 0.75, 0, 0 ))
		end
	end)
	
	self.SecondaryAttacking = true
		local bullet = {}
			bullet.Num = self.Secondary.NumShots
			bullet.Src = self.Owner:GetShootPos()
			bullet.Dir = self.Owner:GetAimVector()
			bullet.Spread = Vector( self.Secondary.Spread / self.Secondary.SpreadDiv, self.Secondary.Spread / self.Secondary.SpreadDiv, 0 )
			bullet.Tracer = self.Secondary.Tracer
			bullet.Force = self.Secondary.Force
			bullet.Damage = self.Secondary.Damage
			self.AmmoType = self.Secondary.AmmoType
			
	if self.Secondary.Projectile == nil then
		self.Owner:FireBullets ( bullet )
	elseif self.Secondary.Projectile == "scripted" then
		timer.Simple(self.Secondary.ProjectileSpawnDelay, function()
			self:DoScriptedSecondaryAttack()
			self.Weapon:EmitSound(self.Secondary.Sound)
			ply:SetAnimation( PLAYER_ATTACK1 )
			self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
		end)
	else
	local aim = self.Owner:GetAimVector()
	local side = aim:Cross(Vector(0,0,0))
	local up = side:Cross(aim)
	local pos = self.Owner:GetShootPos() + side * 0 + up * 0
		if SERVER then
			local proj = ents.Create(self.Secondary.Projectile)
			if !proj:IsValid() then return false end
			proj:SetAngles(self.Owner:EyeAngles())
			proj:SetPos(pos)
			proj:SetOwner(self.Owner)
			timer.Simple(self.Secondary.ProjectileSpawnDelay, function()
				self.Weapon:EmitSound(self.Secondary.Sound)
				ply:SetAnimation( PLAYER_ATTACK1 )
				self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
				proj:Spawn()
				proj.Owner = self.Owner
				proj:Activate()
				eyes = self.Owner:EyeAngles()
				local phys = proj:GetPhysicsObject()
				if self.Secondary.ProjInheritVelocity == true then
					phys:SetVelocity((self.Owner:GetAimVector() * self.Secondary.ProjSpeed) + ply:GetVelocity())
				else
					phys:SetVelocity(self.Owner:GetAimVector() * self.Secondary.ProjSpeed)
				end
			end)
		end
	end
	self.Weapon:EmitSound(Sound(self.Primary.Sound))
	elseif self.Primary.isvFire == true then
	self:ShootFire() 
		if SERVER then
			if self.Weapon:GetNWBool("Passive") == true then else
			if (self.Owner:KeyPressed(IN_ATTACK2) || !self.LoopingFireSoundSecondary) then
				self.LoopingFireSoundSecondary = CreateSound(self.Owner, self.Primary.Sound)
			end end
		if (self.LoopingFireSoundSecondary) then self.LoopingFireSoundSecondary:Play() end
		end
	end
	self.Owner:MuzzleFlash()
	self.Weapon:EmitSound(Sound(self.Secondary.ChargeSound))
	if CLIENT then
	ply:SetEyeAngles( eyeang )
	else end
	self:TakeSecondaryAmmo( self.Secondary.APS )
	self:SetNextSecondaryFire( CurTime() + (60 / self.Secondary.RPM) )
	self:MuzzleFlash()
	
	if self.Secondary.AutoReload == true && self:Clip2() <= 0 && ply:GetAmmoCount(self.Secondary.Ammo) >= 1 then
	timer.Simple((looptime - 0.2), function() self:ReloadSecondary() end)
	end
	
	timer.Simple(0.05, function() self:SetHoldType(self.HoldType) end)
	timer.Simple(looptime, function() self.SecondaryAttacking = false end)
	else return end
end

function SWEP:TakeSecondaryAmmo( num )
	if ( self.Weapon:Clip2() <= 0 ) then
		if ( self:Ammo2() <= 0 ) then return end
		self.Owner:RemoveAmmo( num, self.Weapon:GetSecondaryAmmoType() )
	return end
	self.Weapon:SetClip2( self.Weapon:Clip2() - num )
end

function SWEP:Reload()
local ply = self:GetOwner()
local usekey = ply:KeyDown(IN_USE)
local reloadkey = ply:KeyDown(IN_RELOAD)
local walkkey = ply:KeyDown(IN_WALK)
local sprintkey = ply:KeyDown(IN_SPEED)

if ply:IsPlayer() then
	if usekey && reloadkey then
		if self.Inspecting == 0 then
			self.Idle = 0
			self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
			self:Inspect()
		elseif self.Inspect == 1 then end
	elseif walkkey && reloadkey && self.IsTaunting == 0 then
		self:Taunt()
		elseif walkkey && reloadkey && self.IsTaunting == 1 then
		self:SetHoldType(self.ReloadHoldType)
	elseif reloadkey && !sprintkey && self.ManuallyReloading == false && self.Loading == false && self.ManualReload == true && ( self.Weapon:Clip1() < self.Primary.ClipSize ) then
		if ( ply:GetAmmoCount(self.Primary.Ammo) ) <= 0 then
		else
				self:SetHoldType(self.ReloadHoldType)
				self:StartManualReload()
				ply:SetFOV(0, 0.05)
				self.Weapon:SetNWBool( "Ironsights", false )
				hook.Remove( "HUDPaint", self.ScopeHookID )
				if self.Weapon:Clip1() <= 0 then
					self:SetNWBool("reloadedEmpty", true)
				else
					self:SetNWBool("reloadedEmpty", false)
				end
				return true
		end
	elseif reloadkey && !sprintkey && self.ManuallyReloading == false && self.Loading == false && self.ManualReload == false && ( self.Weapon:Clip1() < self.Primary.ClipSize ) then
			if ( self.Weapon:Clip1() < self.Primary.ClipSize ) && self.Weapon:Ammo1() > 0 then
				self:SetHoldType(self.Primary.ReloadHoldType)
				self:DoReload()
				ply:SetFOV(0, 0.05)
				self.Weapon:SetNWBool( "Ironsights", false )
				hook.Remove( "HUDPaint", self.ScopeHookID )
				if self.Weapon:Clip1() <= 0 then
					self:SetNWBool("reloadedEmpty", true)
				else
					self:SetNWBool("reloadedEmpty", false)
				end
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
	elseif reloadkey && sprintkey && self.ManuallyReloading == false && self.Loading == false && ( self.Weapon:Clip2() < self.Secondary.ClipSize ) && ply:GetAmmoCount(self.Secondary.Ammo) > 0 then
		if ( ply:GetAmmoCount(self.Secondary.Ammo) ) <= 0 then
		else
			self:SetHoldType(self.Secondary.ReloadHoldType)
			ply:SetFOV(0, 0.05)
			self:ReloadSecondary()
		end
	end
end

function SWEP:ReloadSecondary()
	local ply = self:GetOwner()
	local reloadseq = self:SelectWeightedSequence( self.Secondary.ReloadAct )
	local reloadtime = self:SequenceDuration( reloadseq )
	
	if self:IsValid() && ply:IsValid() && ply:Alive() then
		if self.Secondary.DoReloadAnimation == true then
			ply:SetAnimation( PLAYER_RELOAD )
		else end
		self.Loading = true
		self:SetIronsights(false, self.Owner)
		
		if self.Secondary.DoReloadAnimation == true then
			self:SendWeaponAnim( self.Secondary.ReloadAct )
			timer.Simple( reloadtime, function() self:EndSecondaryReload() end)
		else
			self:EndSecondaryReload()
		end
	else end
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
	local LeftHand = ply:LookupBone("ValveBiped.Bip01_L_Hand")
	local RightHand = ply:LookupBone("ValveBiped.Bip01_R_Hand")
	
	if self:IsValid() && ply:IsValid() && ply:Alive() then
		ply:SetAnimation( PLAYER_RELOAD )
		self.Loading = true
		self:SetIronsights(false, self.Owner)
		
		self:SendWeaponAnim(ACT_VM_RELOAD)
		
		if SERVER && self.MagazineEntity != nil then
			local mag = ents.Create(self.MagazineEntity)
				mag:SetPos( ply:GetBonePosition(LeftHand) )
				mag:SetAngles( ply:EyeAngles() )
				mag:Spawn()
				mag:Activate()
				local phys = mag:GetPhysicsObject()
				phys:SetVelocity((self.Owner:GetAimVector() * self.Secondary.ProjSpeed) + ply:GetVelocity())
		else end

		if ply:GetAmmoCount(self.Primary.Ammo) < self.Primary.ClipSize then
		self.Weapon:SetNWInt("LoadedAmmo", math.Clamp(self.Weapon:Clip1() + ply:GetAmmoCount(self.Primary.Ammo), 0, self.Primary.ClipSize))
		else
		self.Weapon:SetNWInt("LoadedAmmo", math.Clamp(self.Primary.ClipSize, 0, self.Primary.ClipSize))
		end		

		self:DoCustomReloadStartEvents()
		timer.Simple( reloadtime, function() self:EndReload() end)
	else end
end

function SWEP:EndReload()
	local ply = self:GetOwner()
	self.Loading = false
	self.IronCD = false
	
	if self:IsValid() && ply:IsValid() && ply:Alive() then
	self:DoCustomReloadEndEvents()
		if self.Primary.DropMagReload == false then
		ply:RemoveAmmo( (self.Primary.ClipSize - self.Weapon:Clip1()), self.Primary.Ammo)
		else
		ply:RemoveAmmo( self.Primary.ClipSize, self.Primary.Ammo)
		end
		
		self:SetClip1( math.Clamp(self.Weapon:GetNWInt("LoadedAmmo"), 0, self.Primary.ClipSize) )
		if self.Passive == true then
			self:DoPassiveHoldtype()
		else
			self:SetHoldType( self.HoldType )
		end
		
		if self:GetNWBool("reloadedEmpty") == true && self.LoadAfterReloadEmpty == true then
			self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
		else end
	else end
end

function SWEP:StartManualReload()
	local ply = self:GetOwner()
	local wep = self
	local enterseq = self:SelectWeightedSequence( ACT_SHOTGUN_RELOAD_START )
	local entertime = self:SequenceDuration( enterseq )

	if self:IsValid() && ply:IsValid() && ply:Alive() then
		ply:SetAnimation( PLAYER_RELOAD )
		self.ManuallyReloading = true
		self:SetIronsights(false, self.Owner)
		wep:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
		timer.Simple( entertime, function() self:DoManualReload() end)
	else end
return true
end

function SWEP:DoManualReload()
	local ply = self:GetOwner()
	local loopseq = self:SelectWeightedSequence( ACT_VM_RELOAD )
	local looptime = self:SequenceDuration( loopseq )

	if self:IsValid() && ply:IsValid() && ply:Alive() then
		self.ManuallyReloading = true
		self:SetIronsights(false, self.Owner)
		self:GetOwner():RemoveAmmo( 1, self.Primary.Ammo, false )
		self.Weapon:SetNWBool("LoadedAmmo", self.Weapon:GetNWBool("LoadedAmmo") + self.Primary.APS)
		self:SetClip1(self.Weapon:GetNWInt("LoadedAmmo"))

		self:SendWeaponAnim(ACT_VM_RELOAD)
		timer.Simple( looptime, function() self:ManualReloadLoop() end)
	else end
end

function SWEP:ManualReloadLoop()
local ply = self:GetOwner()
	if self:IsValid() && ply:IsValid() && ply:Alive() then
			if self:Clip1() <= self.Primary.ClipSize then
				if ply:KeyDown(IN_RELOAD) && self:Clip1() < self.Primary.ClipSize then
					if ( ply:GetAmmoCount(self.Primary.Ammo) ) > 0 then
						self:DoManualReload()
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
		self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
		
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
		if self:GetNWBool("reloadedEmpty") == true && self.LoadAfterReloadEmpty == true then
			self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
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

function SWEP:ShootEffects( hitpos, hitnormal, entity, physbone, bFirstTimePredicted )
	if self.Loading == false && self.ManuallyReloading == false then
	self.Owner:SetAnimation( PLAYER_ATTACK1 ) 
	else end
end

function SWEP:DoImpactEffect(tr, nDamageType)
	if ( tr.HitSky ) then return end

	local effectdata = EffectData()
	effectdata:SetOrigin( tr.HitPos )
	effectdata:SetStart( self.Owner:GetShootPos() )
	effectdata:SetAttachment( 1 )
	effectdata:SetEntity( self )
	util.Effect( self.Primary.Tracer, effectdata )
	
	if self.Primary.ImpactEffect == nil then else
		local effectdata = EffectData()
		effectdata:SetOrigin( tr.HitPos + tr.HitNormal )
		effectdata:SetNormal( tr.HitNormal )
		util.Effect( self.Primary.ImpactEffect, effectdata )
	end
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

function SWEP:DoCustomReloadStartEvents()
end