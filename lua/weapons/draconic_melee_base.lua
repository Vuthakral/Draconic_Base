SWEP.Base				= "draconic_base"
SWEP.Gun				= "draconic_melee_base"

SWEP.HoldType			= "melee" -- https://wiki.garrysmod.com/page/Hold_Types
SWEP.HoldTypeCrouch		= "melee" -- https://wiki.garrysmod.com/page/Hold_Types
SWEP.Category			= "Draconic"
SWEP.PrintName			= "Draconic Melee Base"
SWEP.Auhtor				= "Vuthakral"
SWEP.Contact			= " https://discord.gg/6Y7WXrX // Steam: Vuthakral // Disc: Vuthakral#9761 "
SWEP.Purpose			= "SWEP Base"
SWEP.Instructions		= "open rectum & insert"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Slot				= 0
SWEP.SlotPos			= 0
SWEP.DrawAmmo		= false

SWEP.IdleActivity = ACT_VM_IDLE
SWEP.CrouchIdleActivity = ACT_VM_IDLE_LOWERED

SWEP.ViewModelFlip  = false
SWEP.ShowWorldModel = false

SWEP.Primary.SwingSound		= Sound( "" )
SWEP.Primary.HitSoundWorld 	= Sound( "" )
SWEP.Primary.HitSoundFlesh 	= Sound( "" )
SWEP.Primary.HitSoundEnt 	= Sound( "" )
SWEP.Primary.HoldType		= "melee"
SWEP.Primary.CrouchHoldType	= "melee"
SWEP.Primary.ImpactDecal 	= ""
SWEP.Primary.Automatic		= false
SWEP.Primary.Damage			= 12
SWEP.Primary.DamageType		= DMG_SLASH
SWEP.Primary.Range			= 20
SWEP.Primary.Force			= 5
SWEP.Primary.DelayMiss		= 0.42
SWEP.Primary.DelayHit 		= 0.54
SWEP.Primary.CanAttackCrouched = false
SWEP.Primary.HitActivity	= ACT_VM_PRIMARYATTACK
SWEP.Primary.CrouchHitActivity	= ACT_VM_PRIMARYATTACK
SWEP.Primary.MissActivity	= ACT_VM_PRIMARYATTACK 
SWEP.Primary.CrouchMissActivity	= ACT_VM_PRIMARYATTACK 
SWEP.Primary.HitDelay		= 0.07

SWEP.Primary.CanLunge			= false
SWEP.Primary.LungeAutomatic		= false
SWEP.Primary.LungeKeyInput		= IN_USE
SWEP.Primary.LungeVelocity		= 1000
SWEP.Primary.LungeMaxDist		= 250
SWEP.Primary.LungeSwingSound	= Sound( "" )
SWEP.Primary.LungeHitSoundWorld = Sound( "" )
SWEP.Primary.LungeHitSoundFlesh = Sound( "" )
SWEP.Primary.LungeHitSoundEnt	= Sound( "" )
SWEP.LungeHoldType				= "melee"
SWEP.LungeHoldTypeCrouch		= "melee"
SWEP.Primary.LungeImpactDecal 	= ""
SWEP.Primary.LungeHitAct		= ACT_VM_PRIMARYATTACK
SWEP.Primary.LungeMissAct		= ACT_VM_PRIMARYATTACK
SWEP.Primary.LungeDelayMiss		= 1.3
SWEP.Primary.LungeDelayHit		= 0.7
SWEP.Primary.LungeHitDelay		= 0.26
SWEP.Primary.LungeDamage		= 72
SWEP.Primary.LungeDamageType	= DMG_ALWAYSGIB
SWEP.Primary.LungeRange			= 25
SWEP.Primary.LungeForce			= 20

SWEP.Primary.Ammo = nil
SWEP.Secondary.Ammo = nil

SWEP.Secondary.SwingSound 	 = Sound( "" )
SWEP.Secondary.HitSoundWorld = Sound( "" )
SWEP.Secondary.HitSoundFlesh = Sound( "" )
SWEP.Secondary.HitSoundEnt 	 = Sound( "" )
SWEP.Secondary.HoldType		 = "knife"
SWEP.Secondary.HoldTypeCrouch	 = "melee2"
SWEP.Secondary.ImpactDecal 	 = ""
SWEP.Secondary.Automatic 	 = false
SWEP.Secondary.Damage 	  	 = 47
SWEP.Secondary.DamageType	 = DMG_ALWAYSGIB
SWEP.Secondary.Range       	 = 30
SWEP.Secondary.Force	   	 = 15
SWEP.Secondary.DelayMiss   	 = 1.5
SWEP.Secondary.DelayHit	   	 = 0.78
SWEP.Secondary.CanAttackCrouched = true
SWEP.Secondary.HitActivity	= ACT_VM_HITCENTER
SWEP.Secondary.CrouchHitActivity	= ACT_VM_HITCENTER2
SWEP.Secondary.MissActivity	= ACT_VM_MISSCENTER
SWEP.Secondary.CrouchMissActivity	= ACT_VM_MISSCENTER2
SWEP.Secondary.HitDelay		= 0.23
SWEP.Secondary.Velocity		= Vector(0, 0, 0)

-- DO NOT TOUCH
SWEP.Primary.Ammo = ""
SWEP.Secondary.Ammo = ""
-- end DNT

function SWEP:PrimaryAttack()
if not IsValid(self) or not IsValid(self.Owner) then return end
	local ply = self:GetOwner()
	local cv = ply:Crouching()
	local CanCrouchAttack = self.Primary.CanAttackCrouched
	local et = ply:GetEyeTrace()
	local res = et.Entity
	
if ply:GetNWBool("IsBlocking") == false then
	if self.Primary.CanLunge == true then
		if self.Primary.LungeAutomatic == true then
			if (IsValid( res ) and res:IsNPC() or res:IsPlayer() ) then
				if(ply:GetPos():Distance(res:GetPos()) < self.Primary.LungeMaxDist) then
					if cv == false then
						ply:SetNWBool( "IsAttacking", true )
						self:DoPrimaryLunge()
						elseif cv == true && CanCrouchAttack == true then
						ply:SetNWBool( "IsAttacking", true )
						self:DoPrimaryLunge()
					elseif cv == true && CanCrouchAttack == false then
					end
				elseif(ply:GetPos():Distance(res:GetPos()) > self.Primary.LungeMaxDist) then
					if cv == false then
						ply:SetNWBool( "IsAttacking", true )
						self:SetHoldType( self.Primary.HoldType )
							if self.Primary.isvFire == false then
								self:DoPrimaryAttack()
							else 
							self:ShootFire()
								if SERVER then
									if (self.Owner:KeyPressed(IN_ATTACK) || !self.LoopingFireSound) then
										self.LoopingFireSound = CreateSound(self.Owner, self.Secondary.SwingSound)
									end
								if (self.LoopingFireSound) then self.LoopingFireSound:Play() end
								end
							end
						elseif cv == true && CanCrouchAttack == true then
						ply:SetNWBool( "IsAttacking", true )
						self:SetHoldType( self.Primary.CrouchHoldType )
							if self.Primary.isvFire == false then
								self:DoPrimaryAttack()
							else 
							self:ShootFire()
								if SERVER then
									if (self.Owner:KeyPressed(IN_ATTACK) || !self.LoopingFireSound) then
										self.LoopingFireSound = CreateSound(self.Owner, self.Secondary.SwingSound)
									end
								if (self.LoopingFireSound) then self.LoopingFireSound:Play() end
								end
							end
						elseif cv == true && CanCrouchAttack == false then
					end
				end
			elseif (IsValid( res ) and !res:IsNPC() or !res:IsPlayer() ) then
				if cv == false then
					ply:SetNWBool( "IsAttacking", true )
					self:SetHoldType( self.Primary.HoldType )
							if self.Primary.isvFire == false then
								self:DoPrimaryAttack()
							else 
							self:ShootFire()
								if SERVER then
									if (self.Owner:KeyPressed(IN_ATTACK) || !self.LoopingFireSound) then
										self.LoopingFireSound = CreateSound(self.Owner, self.Secondary.SwingSound)
									end
								if (self.LoopingFireSound) then self.LoopingFireSound:Play() end
								end
							end
					elseif cv == true && CanCrouchAttack == true then
					ply:SetNWBool( "IsAttacking", true )
					self:SetHoldType( self.Primary.CrouchHoldType )
							if self.Primary.isvFire == false then
								self:DoPrimaryAttack()
							else 
							self:ShootFire()
								if SERVER then
									if (self.Owner:KeyPressed(IN_ATTACK) || !self.LoopingFireSound) then
										self.LoopingFireSound = CreateSound(self.Owner, self.Secondary.SwingSound)
									end
								if (self.LoopingFireSound) then self.LoopingFireSound:Play() end
								end
							end
					elseif cv == true && CanCrouchAttack == false then
				end
			end
		elseif self.Primary.LungeAutomatic == false then
			if (IsValid( res ) and res:IsNPC() or res:IsPlayer() ) then
				if(ply:GetPos():Distance(res:GetPos()) < self.Primary.LungeMaxDist) then
					if ply:KeyDown(self.Primary.LungeKeyInput) then
						ply:SetNWBool( "IsAttacking", true )
						self:DoPrimaryLunge()
					elseif !ply:KeyDown(self.Primary.LungeKeyInput) then
						self:SetHoldType( self.Primary.HoldType )
						ply:SetNWBool( "IsAttacking", true )
							if self.Primary.isvFire == false then
								self:DoPrimaryAttack()
							else 
							self:ShootFire()
								if SERVER then
									if (self.Owner:KeyPressed(IN_ATTACK) || !self.LoopingFireSound) then
										self.LoopingFireSound = CreateSound(self.Owner, self.Secondary.SwingSound)
									end
								if (self.LoopingFireSound) then self.LoopingFireSound:Play() end
								end
							end
					end
				elseif(ply:GetPos():Distance(res:GetPos()) > self.Primary.LungeMaxDist) then
					ply:SetNWBool( "IsAttacking", true )
					self:SetHoldType( self.Primary.HoldType )
							if self.Primary.isvFire == false then
								self:DoPrimaryAttack()
							else 
							self:ShootFire()
								if SERVER then
									if (self.Owner:KeyPressed(IN_ATTACK) || !self.LoopingFireSound) then
										self.LoopingFireSound = CreateSound(self.Owner, self.Secondary.SwingSound)
									end
								if (self.LoopingFireSound) then self.LoopingFireSound:Play() end
								end
							end
				end
			elseif (IsValid( res ) and !res:IsNPC() or !res:IsPlayer() ) then
				ply:SetNWBool( "IsAttacking", true )
				self:SetHoldType( self.Primary.HoldType )
							if self.Primary.isvFire == false then
								self:DoPrimaryAttack()
							else 
							self:ShootFire()
								if SERVER then
									if (self.Owner:KeyPressed(IN_ATTACK) || !self.LoopingFireSound) then
										self.LoopingFireSound = CreateSound(self.Owner, self.Secondary.SwingSound)
									end
								if (self.LoopingFireSound) then self.LoopingFireSound:Play() end
								end
							end
			end
		end

	elseif self.Primary.CanLunge == false then
		if cv == false then
			self:SetHoldType( self.Primary.HoldType )
							if self.Primary.isvFire == false then
								self:DoPrimaryAttack()
							else 
							self:ShootFire()
								if SERVER then
									if (self.Owner:KeyPressed(IN_ATTACK) || !self.LoopingFireSound) then
										self.LoopingFireSound = CreateSound(self.Owner, self.Secondary.SwingSound)
									end
								if (self.LoopingFireSound) then self.LoopingFireSound:Play() end
								end
							end
			elseif cv == true && CanCrouchAttack == true then
			self:SetHoldType( self.Primary.CrouchHoldType )
							if self.Primary.isvFire == false then
								self:DoPrimaryAttack()
							else 
							self:ShootFire()
								if SERVER then
									if (self.Owner:KeyPressed(IN_ATTACK) || !self.LoopingFireSound) then
										self.LoopingFireSound = CreateSound(self.Owner, self.Secondary.SwingSound)
									end
								if (self.LoopingFireSound) then self.LoopingFireSound:Play() end
								end
							end
			elseif cv == true && CanCrouchAttack == false then
		end
	end
elseif ply:GetNWBool("IsBlocking") == true then
end
end

function SWEP:DoPrimaryLunge()
if not IsValid(self) or not IsValid(self.Owner) then return end
local ply = self:GetOwner()
local cv = ply:Crouching()
local et = ply:GetEyeTrace()
local res = et.Entity
local plypos = ply:GetPos()
local respos = res:GetPos()

	if cv == false then
		if CLIENT or SERVER then
		self:SetHoldType( self.LungeHoldType )
		end
	elseif cv == true then
		if CLIENT or SERVER then
		self:SetHoldType( self.LungeHoldTypeCrouch )
		end
	end
self:EmitSound(Sound(self.Primary.LungeSwingSound))
ply:SetVelocity(ply:GetForward() * 8 * plypos:Distance(respos) )

local tr = util.TraceLine( {
	start = self.Owner:GetShootPos(),
	endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.Primary.LungeRange*4,
	filter = self.Owner,
	mask = MASK_SHOT_HULL,
} )
if !IsValid( tr.Entity ) then
	tr = util.TraceHull( {
	start = self.Owner:GetShootPos(),
	endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.Primary.LungeRange*4,
	filter = self.Owner,
	mins = Vector( -16, -16, 0 ),
	maxs = Vector( 16, 16, 0 ),
	mask = MASK_SHOT_HULL,
} )
end

timer.Simple( self.Primary.LungeHitDelay, function() self:PrimaryLungeImpact() end)

if !tr.Hit then
	self.Weapon:SendWeaponAnim( self.Primary.LungeMissAct )
	self:SetNextPrimaryFire( CurTime() + self.Primary.LungeDelayMiss )
	timer.Simple( self.Primary.LungeDelayMiss, function() self:EndAttack() end)
end
if tr.Hit then
	self.Weapon:SendWeaponAnim( self.Primary.LungeHitAct )
	self:SetNextPrimaryFire( CurTime() + self.Primary.LungeDelayHit )
	timer.Simple( self.Primary.LungeDelayMiss, function() self:EndAttack() end)
end
	self.Idle = 0
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
	self:SendAttackAnim()
end

function SWEP:PrimaryLungeImpact()
if not IsValid(self) or not IsValid(self.Owner) then return end
	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.Primary.LungeRange*4,
		filter = self.Owner,
		mask = MASK_SHOT_HULL,
} )

if ( tr.Hit ) then
	util.Decal(self.Primary.LungeImpactDecal, tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)  
end

local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Distance = self.Primary.LungeDistance
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
			dmg:SetDamage( self.Primary.LungeDamage )
			dmg:SetDamageForce( self.Owner:GetForward() * self.Primary.LungeForce )
			dmg:SetDamageType( self.Primary.LungeDamageType )
			tr.Entity:TakeDamageInfo( dmg )
end
end

	if ( tr.Hit ) then
			if tr.Entity:IsPlayer() or string.find(tr.Entity:GetClass(),"npc") or string.find(tr.Entity:GetClass(),"prop_ragdoll") or string.find(tr.Entity:GetClass(),"prop_physics") then
				if string.find(tr.Entity:GetClass(),"prop_physics") then
			self:EmitSound(Sound(self.Primary.LungeHitSoundEnt))
			else
			self:EmitSound(Sound(self.Primary.LungeHitSoundFlesh))
			end
			self.Owner:FireBullets(bullet)	
			else
			self:EmitSound(Sound(self.Primary.LungeHitSoundWorld))
			end
	end
end

function SWEP:DoPrimaryAttack()
if not IsValid(self) or not IsValid(self.Owner) then return end
local ply = self:GetOwner()
local cv = ply:Crouching()

ply:SetNWBool( "IsAttacking", true )

self:EmitSound(Sound(self.Primary.SwingSound))

local tr = util.TraceLine( {
	start = self.Owner:GetShootPos(),
	endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.Primary.Range*4,
	filter = self.Owner,
	mask = MASK_SHOT_HULL,
} )
if !IsValid( tr.Entity ) then
	tr = util.TraceHull( {
	start = self.Owner:GetShootPos(),
	endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.Primary.Range*4,
	filter = self.Owner,
	mins = Vector( -16, -16, 0 ),
	maxs = Vector( 16, 16, 0 ),
	mask = MASK_SHOT_HULL,
} )
end

timer.Simple( self.Primary.HitDelay, function() self:PrimaryImpact() end)

if !tr.Hit then
	if cv == false then
		self.Weapon:SendWeaponAnim( self.Primary.MissActivity )
	elseif cv == true then
		self.Weapon:SendWeaponAnim( self.Primary.CrouchMissActivity )
	end
	self:SetNextPrimaryFire( CurTime() + self.Primary.DelayMiss )
	timer.Simple( self.Primary.DelayMiss, function() self:EndAttack() end)
end
if tr.Hit then
	if cv == false then
		self.Weapon:SendWeaponAnim( self.Primary.HitActivity )
	elseif cv == true then
		self.Weapon:SendWeaponAnim( self.Primary.CrouchHitActivity )
	end
	self:SetNextPrimaryFire( CurTime() + self.Primary.DelayHit )
	timer.Simple( self.Primary.DelayHit, function() self:EndAttack() end)
end
	self.Idle = 0
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
	self:SendAttackAnim()
end

function SWEP:PrimaryImpact()
if not IsValid(self) or not IsValid(self.Owner) then return end
	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.Primary.Range*4,
		filter = self.Owner,
		mask = MASK_SHOT_HULL,
} )

if ( tr.Hit ) then
	util.Decal(self.Primary.ImpactDecal, tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)  
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
			dmg:SetDamage( self.Primary.Damage )
			dmg:SetDamageForce( self.Owner:GetForward() * self.Primary.Force )
			dmg:SetDamageType( self.Primary.DamageType )
			tr.Entity:TakeDamageInfo( dmg )
end
end

	if ( tr.Hit ) then
			if tr.Entity:IsPlayer() or string.find(tr.Entity:GetClass(),"npc") or string.find(tr.Entity:GetClass(),"prop_ragdoll") or string.find(tr.Entity:GetClass(),"prop_physics") then
				if string.find(tr.Entity:GetClass(),"prop_physics") then
			self:EmitSound(Sound(self.Primary.HitSoundEnt))
			else
			self:EmitSound(Sound(self.Primary.HitSoundFlesh))
			end
			self.Owner:FireBullets(bullet)	
			else
			self:EmitSound(Sound(self.Primary.HitSoundWorld))
			end
	end
end


function SWEP:SecondaryAttack()
if not IsValid(self) or not IsValid(self.Owner) then return end
	local ply = self:GetOwner()
	local cv = ply:Crouching()
	local CanCrouchAttack = self.Secondary.CanAttackCrouched
	
	if self.Secondary.CanBlock == true then
		if ply:KeyDown(self.Secondary.BlockKeyInput) then
		elseif !ply:KeyDown(self.Secondary.BlockKeyInput) then
			if cv == false then
				self:DoSecondaryAttack()
				self:SetHoldType( self.Secondary.HoldType )
			elseif cv == true && CanCrouchAttack == true then
				self:DoSecondaryAttack()
				self:SetHoldType( self.Secondary.HoldTypeCrouch )
			elseif cv == true && CanCrouchAttack == false then
			end
		end
	elseif self.Secondary.CanBlock == false then
		if cv == false then
			self:SetHoldType( self.Secondary.HoldType )
			if self.Secondary.isvFire == false then
				self:DoSecondaryAttack()
			else 
			self:ShootFire() 
				if SERVER then
					if (self.Owner:KeyPressed(IN_ATTACK2) || !self.LoopingFireSoundSecondary) then
						self.LoopingFireSoundSecondary = CreateSound(self.Owner, self.Secondary.SwingSound)
					end end
				if (self.LoopingFireSoundSecondary) then self.LoopingFireSoundSecondary:Play() end
			end
		elseif cv == true && CanCrouchAttack == true then
			self:SetHoldType( self.Secondary.HoldTypeCrouch )
			if self.Secondary.isvFire == false then
				self:DoSecondaryAttack()
			else 
			self:ShootFire()
				if SERVER then
					if (self.Owner:KeyPressed(IN_ATTACK2) || !self.LoopingFireSoundSecondary) then
						self.LoopingFireSoundSecondary = CreateSound(self.Owner, self.Secondary.SwingSound)
					end
				if (self.LoopingFireSoundSecondary) then self.LoopingFireSoundSecondary:Play() end
				end
			end
		elseif cv == true && CanCrouchAttack == false then
		end
	end
end

function SWEP:DoSecondaryAttack()
if not IsValid(self) or not IsValid(self.Owner) then return end
local ply = self:GetOwner()
local cv = ply:Crouching()

ply:SetNWBool( "IsAttacking", true )
self:EmitSound(Sound(self.Secondary.SwingSound))

local tr = util.TraceLine( {
	start = self.Owner:GetShootPos(),
	endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.Secondary.Range*4,
	filter = self.Owner,
	mask = MASK_SHOT_HULL,
} )
if !IsValid( tr.Entity ) then
	tr = util.TraceHull( {
	start = self.Owner:GetShootPos(),
	endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.Secondary.Range*4,
	filter = self.Owner,
	mins = Vector( -16, -16, 0 ),
	maxs = Vector( 16, 16, 0 ),
	mask = MASK_SHOT_HULL,
} )
end

timer.Simple( self.Secondary.HitDelay, function() self:SecondaryImpact() end)

if !tr.Hit then
	if cv == false then
		self.Weapon:SendWeaponAnim( self.Secondary.MissActivity )
	elseif cv == true then
		self.Weapon:SendWeaponAnim( self.Secondary.CrouchMissActivity )
	end
	self:SetNextPrimaryFire( CurTime() + self.Secondary.DelayMiss )
	self:SetNextSecondaryFire( CurTime() + self.Secondary.DelayMiss )
	timer.Simple( self.Secondary.DelayMiss, function() self:EndAttack() end)
end
if tr.Hit then
	if cv == false then
		self.Weapon:SendWeaponAnim( self.Secondary.HitActivity )
	elseif cv == true then
		self.Weapon:SendWeaponAnim( self.Secondary.CrouchHitActivity )
	end
	self:SetNextPrimaryFire( CurTime() + self.Secondary.DelayHit )
	self:SetNextSecondaryFire( CurTime() + self.Secondary.DelayHit )
	timer.Simple( self.Secondary.DelayHit, function() self:EndAttack() end)
end
	self.Idle = 0
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
	self:SendAttackAnim()
end

function SWEP:SecondaryImpact()
if not IsValid(self) or not IsValid(self.Owner) then return end
local tr = util.TraceLine( {
	start = self.Owner:GetShootPos(),
	endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.Secondary.Range*4,
	filter = self.Owner,
	mask = MASK_SHOT_HULL,
} )

if ( tr.Hit ) then
	util.Decal(self.Secondary.ImpactDecal, tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)  
end

local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Distance = self.Secondary.Distance
	bullet.Spread = Vector( 0, 0, 0 )
	bullet.Tracer = 0
	bullet.Force = self.Secondary.Force
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
			dmg:SetDamage( self.Secondary.Damage )
			dmg:SetDamageForce( self.Owner:GetForward() * self.Secondary.Force )
			dmg:SetDamageType( self.Secondary.DamageType )
			tr.Entity:TakeDamageInfo( dmg )
	end
end

	if ( tr.Hit ) then
			if tr.Entity:IsPlayer() or string.find(tr.Entity:GetClass(),"npc") or string.find(tr.Entity:GetClass(),"prop_ragdoll") or string.find(tr.Entity:GetClass(),"prop_physics") then
				if string.find(tr.Entity:GetClass(),"prop_physics") then
			self:EmitSound(Sound(self.Primary.HitSoundEnt))
			else
			self:EmitSound(Sound(self.Secondary.HitSoundFlesh))
			end
			self.Owner:FireBullets(bullet)	
			else
			self:EmitSound(Sound(self.Secondary.HitSoundWorld))
			end
	end
end

function SWEP:Reload()
local ply = self:GetOwner()
local usekey = ply:KeyDown(IN_USE)
local reloadkey = ply:KeyDown(IN_RELOAD)
local walkkey = ply:KeyDown(IN_WALK)

	if usekey && reloadkey then
		if self.Inspecting == 0 then
			self.Idle = 0
			self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
			self:Inspect()
		elseif self.Inspect == 1 then end
	elseif reloadkey && self.IsTaunting == 0 then
		self:Taunt()
		elseif reloadkey && self.IsTaunting == 1 then
	end
	
end

function SWEP:SendAttackAnim()
if not IsValid(self) or not IsValid(self.Owner) then return end
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
end

function SWEP:EndAttack()
if not IsValid(self) or not IsValid(self.Owner) then return end
	local ply = self:GetOwner()
	ply:SetNWBool( "IsAttacking", false )
end