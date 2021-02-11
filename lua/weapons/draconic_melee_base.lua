SWEP.Base				= "draconic_base"

--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

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

SWEP.PassivePos = Vector(0, -25, -25)
SWEP.PassiveAng = Vector(0, 0, 0)

SWEP.ViewModelFlip  = false
SWEP.ShowWorldModel = true

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
SWEP.Primary.HitActivity	= nil
SWEP.Primary.CrouchHitActivity	= nil
SWEP.Primary.MissActivity	= ACT_VM_PRIMARYATTACK 
SWEP.Primary.CrouchMissActivity	= ACT_VM_PRIMARYATTACK 
SWEP.Primary.HitDelay		= 0.07
SWEP.Primary.StartX			= 20
SWEP.Primary.StartY			= 10
SWEP.Primary.EndX			= -20
SWEP.Primary.EndY			= -10
SWEP.Primary.ShakeMul		= 1

SWEP.Primary.CanLunge			= false
SWEP.Primary.LungeAutomatic		= false
SWEP.Primary.LungeRequiresTarget= true
SWEP.Primary.LungeVelocity		= 1000
SWEP.Primary.LungeMaxDist		= 250
SWEP.Primary.LungeSwingSound	= Sound( "" )
SWEP.Primary.LungeHitSoundWorld = Sound( "" )
SWEP.Primary.LungeHitSoundFlesh = Sound( "" )
SWEP.Primary.LungeHitSoundEnt	= Sound( "" )
SWEP.LungeHoldType				= "melee"
SWEP.LungeHoldTypeCrouch		= "melee"
SWEP.Primary.LungeImpactDecal 	= ""
SWEP.Primary.LungeHitAct		= nil
SWEP.Primary.LungeMissAct		= ACT_VM_PRIMARYATTACK
SWEP.Primary.LungeDelayMiss		= 1.3
SWEP.Primary.LungeDelayHit		= 0.7
SWEP.Primary.LungeHitDelay		= 0.26
SWEP.Primary.LungeDamage		= 72
SWEP.Primary.LungeDamageType	= DMG_ALWAYSGIB
SWEP.Primary.LungeRange			= 25
SWEP.Primary.LungeForce			= 20
SWEP.Primary.LungeStartX			= 7
SWEP.Primary.LungeStartY			= -3
SWEP.Primary.LungeEndX			= -7
SWEP.Primary.LungeEndY			= 3
SWEP.Primary.LungeShakeMul		= 1

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
SWEP.Secondary.HitDelay		= 0.07
SWEP.Secondary.StartX			= 20
SWEP.Secondary.StartY			= 0
SWEP.Secondary.EndX			= -20
SWEP.Secondary.EndY			= 0
SWEP.Secondary.ShakeMul		= 1

SWEP.FireModes_SwitchSound = Sound("draconic.IronOutGeneric")

-- DO NOT TOUCH
SWEP.Primary.Ammo = ""
SWEP.Secondary.Ammo = ""
SWEP.IsMelee = true
-- end DNT

function SWEP:PrimaryAttack()
if not IsValid(self) or not IsValid(self.Owner) then return end
	if self.Weapon:GetNWBool("Inspecting") == true then return end
	local ply = self:GetOwner()
	local cv = ply:Crouching()
	local CanCrouchAttack = self.Primary.CanAttackCrouched
	local et = ply:GetEyeTrace()
	local res = et.Entity
	
	local moving = (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_BACK) or ply:KeyDown(IN_FORWARD)) && sprintkey
	if (self.DoesPassiveSprint == true or GetConVar("sv_drc_force_sprint"):GetString() == "1") && moving then return end
	
	if self.Primary.CanLunge == true then
		if self.Primary.LungeAutomatic == true then
			if (IsValid( res ) and res:IsNPC() or res:IsPlayer() ) then
				if(ply:GetPos():Distance(res:GetPos()) < self.Primary.LungeMaxDist) then
					if cv == false && self.Weapon:GetNWBool("Passive") == false then
						self:DoPrimaryLunge()
						elseif cv == true && CanCrouchAttack == true then
						self:DoPrimaryLunge()
					elseif cv == true && CanCrouchAttack == false then
					end
				elseif(ply:GetPos():Distance(res:GetPos()) > self.Primary.LungeMaxDist) then
					if cv == false then
							if self.Primary.isvFire == false && self.Weapon:GetNWBool("Passive") == false then
								self:DoPrimaryAttack()
							elseif self.Weapon:GetNWBool("Passive") == false then
							self:ShootFire()
								if SERVER then
									if (self.Owner:KeyPressed(IN_ATTACK) || !self.LoopingFireSound) then
										self.LoopingFireSound = CreateSound(self.Owner, self.Secondary.SwingSound)
									end
								if (self.LoopingFireSound) then self.LoopingFireSound:Play() end
								end
							end
						elseif cv == true && CanCrouchAttack == true then
							if self.Primary.isvFire == false && self.Weapon:GetNWBool("Passive") == false then
								self:DoPrimaryAttack()
							elseif self.Weapon:GetNWBool("Passive") == false then
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
							if self.Primary.isvFire == false && self.Weapon:GetNWBool("Passive") == false then
								self:DoPrimaryAttack()
							elseif self.Weapon:GetNWBool("Passive") == false then
							self:ShootFire()
								if SERVER then
									if (self.Owner:KeyPressed(IN_ATTACK) || !self.LoopingFireSound) then
										self.LoopingFireSound = CreateSound(self.Owner, self.Secondary.SwingSound)
									end
								if (self.LoopingFireSound) then self.LoopingFireSound:Play() end
								end
							end
					elseif cv == true && CanCrouchAttack == true then
							if self.Primary.isvFire == false && self.Weapon:GetNWBool("Passive") == false then
								self:DoPrimaryAttack()
							elseif self.Weapon:GetNWBool("Passive") == false then
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
			if self.Primary.LungeRequiresTarget == false && ply:KeyDown(IN_USE) then self:DoPrimaryLunge() return end
			if (IsValid( res ) and res:IsNPC() or res:IsPlayer() ) then
				if(ply:GetPos():Distance(res:GetPos()) < self.Primary.LungeMaxDist) then
					if ply:KeyDown(IN_USE) then
						self:DoPrimaryLunge()
					elseif !ply:KeyDown(IN_USE) then
							if self.Primary.isvFire == false && self.Weapon:GetNWBool("Passive") == false then
								self:DoPrimaryAttack()
							elseif self.Weapon:GetNWBool("Passive") == false then
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
							if self.Primary.isvFire == false && self.Weapon:GetNWBool("Passive") == false then
								self:DoPrimaryAttack()
							elseif self.Weapon:GetNWBool("Passive") == false then
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
							if self.Primary.isvFire == false && self.Weapon:GetNWBool("Passive") == false then
								self:DoPrimaryAttack()
							elseif self.Weapon:GetNWBool("Passive") == false then
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
							if self.Primary.isvFire == false && self.Weapon:GetNWBool("Passive") == false then
								self:DoPrimaryAttack()
							elseif self.Weapon:GetNWBool("Passive") == false then
							self:ShootFire()
								if SERVER then
									if (self.Owner:KeyPressed(IN_ATTACK) || !self.LoopingFireSound) then
										self.LoopingFireSound = CreateSound(self.Owner, self.Secondary.SwingSound)
									end
								if (self.LoopingFireSound) then self.LoopingFireSound:Play() end
								end
							end
			elseif cv == true && CanCrouchAttack == true then
							if self.Primary.isvFire == false && self.Weapon:GetNWBool("Passive") == false then
								self:DoPrimaryAttack()
							elseif self.Weapon:GetNWBool("Passive") == false then
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
	if IsValid(res) then ply:SetVelocity(ply:GetForward() * 8 * plypos:Distance(respos) ) end

	local ply = self:GetOwner()
	local vm = ply:GetViewModel()
	local eyeang = ply:EyeAngles()
	local eyepos = ply:EyePos()
	local cv = ply:Crouching()
	
	local x1 = self.Primary.LungeStartX
	local x2 = self.Primary.LungeEndX
	local y1 = self.Primary.LungeStartY
	local y2 = self.Primary.LungeEndY
	
	local x1m = math.Rand(x1 * 0.9, x1 * 1.1)
	local x2m = math.Rand(x2 * 0.9, x2 * 1.1)
	local y1m = math.Rand(y1 * 0.9, y1 * 1.1)
	local y2m = math.Rand(y2 * 0.9, y2 * 1.1)
	
	ply:ViewPunch(Angle(y1m, x1m, nil) * -0.1 * self.Primary.ShakeMul)
	timer.Simple(self.Primary.LungeHitDelay, function()
		ply:ViewPunch(Angle(y1m, x1m, nil) * 0.1 * self.Primary.ShakeMul)
	end)

	if cv == false then
		if CLIENT or SERVER then
		self:SetHoldType( self.Primary.HoldType )
		end
	elseif cv == true then
		if CLIENT or SERVER then
		self:SetHoldType( self.Primary.HoldTypeCrouch )
		end
	end

	self:EmitSound(Sound(self.Primary.LungeSwingSound))
	self.Weapon:SendWeaponAnim( self.Primary.LungeMissAct )
	self:SetNextPrimaryFire( CurTime() + self.Primary.LungeDelayMiss )
	self.IdleTimer = CurTime() + vm:SequenceDuration()
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	for i=1, (math.Round(1/ engine.TickInterval() - 1 , 0)) do
		timer.Create( "SwingImpact".. i .."", math.Round((self.Primary.LungeHitDelay * 100) / 60 * i / 60, 3), 1, function()
			self:MeleeImpact(self.Primary.LungeRange, Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), x1m, x2m), Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), y1m, y2m), i, "lungeprimary")
		end)
	end
end

function SWEP:DoPrimaryAttack()
	if not IsValid(self) or not IsValid(self.Owner) then return end
	local ply = self:GetOwner()
	local vm = ply:GetViewModel()
	local eyeang = ply:EyeAngles()
	local eyepos = ply:EyePos()
	local cv = ply:Crouching()
	
	local x1 = self.Primary.StartX
	local x2 = self.Primary.EndX
	local y1 = self.Primary.StartY
	local y2 = self.Primary.EndY
	
	local x1m = math.Rand(x1 * 0.9, x1 * 1.1)
	local x2m = math.Rand(x2 * 0.9, x2 * 1.1)
	local y1m = math.Rand(y1 * 0.9, y1 * 1.1)
	local y2m = math.Rand(y2 * 0.9, y2 * 1.1)
	
	ply:ViewPunch(Angle(y1m, x1m, nil) * -0.1 * self.Primary.ShakeMul)
	timer.Simple(self.Primary.HitDelay, function()
		if not self:GetOwner():IsValid() then return end
		if not self:IsValid() then return end
		ply:ViewPunch(Angle(y1m, x1m, nil) * 0.1 * self.Primary.ShakeMul)
	end)
	
--	ply:ChatPrint("".. x1m .." | ".. x2m .." | " .. y1m .. " | ".. y2m .. "")

	if cv == false then
		if CLIENT or SERVER then
		self:SetHoldType( self.Primary.HoldType )
		end
	elseif cv == true then
		if CLIENT or SERVER then
		self:SetHoldType( self.Primary.HoldTypeCrouch )
		end
	end

	self:EmitSound(Sound(self.Primary.SwingSound))
	self.Weapon:SendWeaponAnim( self.Primary.MissActivity )
	self:SetNextPrimaryFire( CurTime() + self.Primary.DelayMiss )
	self.IdleTimer = CurTime() + vm:SequenceDuration()

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	for i=1, (math.Round(1/ engine.TickInterval() - 1 , 0)) do
		if not self:GetOwner():IsValid() then return end
		if not self:IsValid() then return end
		timer.Create( "SwingImpact".. i .."", math.Round((self.Primary.HitDelay * 100) / 60 * i / 60, 3), 1, function()
			if not self:GetOwner():IsValid() then return end
			if not self:IsValid() then return end
			self:MeleeImpact(self.Primary.Range, Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), x1m, x2m), Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), y1m, y2m), i, "primary")
		end)
	end
end

function SWEP:SecondaryAttack()
if not IsValid(self) or not IsValid(self.Owner) then return end
	if self.Weapon:GetNWBool("Inspecting") == true then return end
	local ply = self:GetOwner()
	local cv = ply:Crouching()
	local usekey = ply:KeyDown(IN_USE)
	local reloadkey = ply:KeyDown(IN_RELOAD)
	local sprintkey = ply:KeyDown(IN_SPEED)
	local attackkey = ply:KeyPressed(IN_ATTACK2)
	local CanCrouchAttack = self.Secondary.CanAttackCrouched
	
	local moving = (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_BACK) or ply:KeyDown(IN_FORWARD)) && sprintkey
	if (self.DoesPassiveSprint == true or GetConVar("sv_drc_force_sprint"):GetString() == "1") && moving then return end
	
		if cv == false then
			if self.Secondary.isvFire == false then
				if sprintkey && usekey && attackkey then
					self:TogglePassive()
				elseif sprintkey && usekey then
				elseif self.Weapon:GetNWBool("Passive") == false then
					self:DoSecondaryAttack()
				end
			else 
			self:ShootFire() 
				if SERVER then
					if (self.Owner:KeyPressed(IN_ATTACK2) || !self.LoopingFireSoundSecondary) then
						self.LoopingFireSoundSecondary = CreateSound(self.Owner, self.Secondary.SwingSound)
					end end
				if (self.LoopingFireSoundSecondary) then self.LoopingFireSoundSecondary:Play() end
			end
		elseif cv == true && CanCrouchAttack == true then
			if self.Secondary.isvFire == false && self.Weapon:GetNWBool("Passive") == false then
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

function SWEP:DoSecondaryAttack()
	if not IsValid(self) or not IsValid(self.Owner) then return end
	local ply = self:GetOwner()
	local vm = ply:GetViewModel()
	local eyeang = ply:EyeAngles()
	local eyepos = ply:EyePos()
	local cv = ply:Crouching()
	
	local x1 = self.Secondary.StartX
	local x2 = self.Secondary.EndX
	local y1 = self.Secondary.StartY
	local y2 = self.Secondary.EndY
	
	local x1m = math.Rand(x1 * 0.9, x1 * 1.1)
	local x2m = math.Rand(x2 * 0.9, x2 * 1.1)
	local y1m = math.Rand(y1 * 0.9, y1 * 1.1)
	local y2m = math.Rand(y2 * 0.9, y2 * 1.1)
	
	ply:ViewPunch(Angle(y1m, x1m, nil) * -0.1 * self.Primary.ShakeMul)
	timer.Simple(self.Secondary.HitDelay, function()
		ply:ViewPunch(Angle(y1m, x1m, nil) * 0.1 * self.Primary.ShakeMul)
	end)
	
--	ply:ChatPrint("".. x1m .." | ".. x2m .." | " .. y1m .. " | ".. y2m .. "")

	if cv == false then
		if CLIENT or SERVER then
		self:SetHoldType( self.Secondary.HoldType )
		end
	elseif cv == true then
		if CLIENT or SERVER then
		self:SetHoldType( self.Secondary.HoldTypeCrouch )
		end
	end

	self:EmitSound(Sound(self.Secondary.SwingSound))
	self.Weapon:SendWeaponAnim( self.Secondary.MissActivity )
	self:SetNextSecondaryFire( CurTime() + self.Secondary.DelayMiss )
	self.IdleTimer = CurTime() + vm:SequenceDuration()

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	for i=1, (math.Round(1/ engine.TickInterval() - 1 , 0)) do
		timer.Create( "SwingImpact".. i .."", math.Round((self.Secondary.HitDelay * 100) / 60 * i / 60, 3), 1, function()
			self:MeleeImpact(self.Secondary.Range, Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), x1m, x2m), Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), y1m, y2m), i, "secondary")
		end)
	end
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
local sprintkey = ply:KeyDown(IN_SPEED)

local reloadkeypressed = ply:KeyPressed(IN_RELOAD)

	if usekey && reloadkeypressed then
		if sprintkey then
			self:ToggleInspectMode()
		else
		if self.Inspecting == false then
			self.Idle = 0
			self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
			self:Inspect()
		elseif self.Inspect == true then end
		end
	elseif reloadkey && self.IsTaunting == 0 then
		self:Taunt()
		elseif reloadkey && self.IsTaunting == 1 then
	end
	
end

function SWEP:SendAttackAnim()
if not IsValid(self) or not IsValid(self.Owner) then return end
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
end

function SWEP:TogglePassive()
	local ply = self:GetOwner()
	self.Weapon:EmitSound(self.FireModes_SwitchSound)
	
	if GetConVar("sv_drc_passives"):GetString() == "0" then return end
	
	if self.Passive == false then
		self.Passive = true
		self:DoPassiveHoldtype()
		self.Weapon:SetNWBool("Passive", true)
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
		self.Weapon:SetNWBool("Passive", false)
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