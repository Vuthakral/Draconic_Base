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

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Slot				= 0
SWEP.SlotPos			= 0
SWEP.DrawAmmo			= false

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
SWEP.Primary.BurnDecal 	= ""
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
SWEP.Primary.LungeBurnDecal 	= ""
SWEP.Primary.LungeHitAct		= nil
SWEP.Primary.LungeMissAct		= ACT_VM_PRIMARYATTACK
SWEP.Primary.LungeHitActCrouch	= nil
SWEP.Primary.LungeMissActCrouch	= ACT_VM_PRIMARYATTACK
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

SWEP.Secondary.SwingSound 	 = Sound( "" )
SWEP.Secondary.HitSoundWorld = Sound( "" )
SWEP.Secondary.HitSoundFlesh = Sound( "" )
SWEP.Secondary.HitSoundEnt 	 = Sound( "" )
SWEP.Secondary.HoldType		 = "knife"
SWEP.Secondary.HoldTypeCrouch	 = "melee2"
SWEP.Secondary.ImpactDecal 	 = ""
SWEP.Secondary.BurnDecal 	 = ""
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

SWEP.AIAttack = "Primary"

-- DO NOT TOUCH
SWEP.Primary.Ammo = ""
SWEP.Secondary.Ammo = ""
SWEP.IsMelee = true

SWEP.NextMeleeAI = 0
function SWEP:CanPrimaryAttackNPC()
	if !IsValid(self) then return false end
	local ply = self:GetOwner()
	if !IsValid(ply) then return false end
	local enemy = ply:GetEnemy()
	if !IsValid(enemy) then return false end
	local dist = ply:GetPos():Distance(enemy:GetPos())
	
	if dist > self.Primary.Range * 10 then 
		ply.NextMeleeWeaponAttackT = 99999999999999999999
		ply:StopAttacks()
		ply:DoChaseAnimation()
		return false 
	else
		if CurTime() > self.NextMeleeAI then
			ply.NextMeleeWeaponAttackT = CurTime() - 1
		end
		return true
	end
end

function SWEP:PrimaryAttackNPC()
	if self:GetNextPrimaryFire() > CurTime() then return false end
	if self.AIAttack == "Primary" then
		self:DoPrimaryAttack()
	elseif self.AIAttack == "Secondary" then
		self:DoSecondaryAttack()
	elseif self.AIAttack == "Lunge" then
		self:DoPrimaryLunge()
	end
end

function SWEP:PrimaryAttack()
if not IsValid(self) or not IsValid(self.Owner) then return end
	if self.Weapon:GetNWBool("Inspecting") == true then return end
	local ply = self:GetOwner()
	if !ply:IsPlayer() then self:PrimaryAttackNPC() return end
	local cv = ply:Crouching()
	local CanCrouchAttack = self.Primary.CanAttackCrouched
	local et = ply:GetEyeTrace()
	local target = self:GetConeTarget()
	
	local moving = (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_BACK) or ply:KeyDown(IN_FORWARD)) && sprintkey
	if (self.DoesPassiveSprint == true or GetConVar("sv_drc_force_sprint"):GetString() == "1") && moving then return end
	
	if self.Primary.CanLunge == true then
		if self.Primary.LungeAutomatic == true then
			if IsValid(target) && (target:IsNPC() or target:IsPlayer() or target:IsNextBot()) then
				if(ply:GetPos():Distance(target:GetPos()) < self.Primary.LungeMaxDist) then
					if cv == false && self.Weapon:GetNWBool("Passive") == false then
						self:DoPrimaryLunge()
						elseif cv == true && CanCrouchAttack == true then
						self:DoPrimaryLunge()
					elseif cv == true && CanCrouchAttack == false then
					end
				elseif(ply:GetPos():Distance(target:GetPos()) > self.Primary.LungeMaxDist) then
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
			elseif !IsValid(target) then
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
			if self.Primary.LungeRequiresTarget == false then 
				if ply:KeyDown(IN_USE) then 
					self:DoPrimaryLunge()
				else
					self:DoPrimaryAttack()
				end
			return end
			if IsValid(target) && (target:IsNPC() or target:IsPlayer() or target:IsNextBot()) then
				if(ply:GetPos():Distance(target:GetPos()) < self.Primary.LungeMaxDist) then
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
				elseif(ply:GetPos():Distance(target:GetPos()) > self.Primary.LungeMaxDist) then
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
			elseif IsValid( target ) then
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
			else
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
	if !IsValid(self) then return end
	if !IsValid(self:GetOwner()) then return end
	self:DoCustomLunge()
	
	local ply = self:GetOwner()
	local plypos = ply:GetPos()
	local vm = nil
	local eyeang = ply:GetAimVector()
	local eyepos = ply:EyePos()
	local cv = false
	local target = self:GetConeTarget()
	
	if target then
		if plypos:Distance(target:GetPos()) < self.Primary.LungeMaxDist then
			ply:SetVelocity(ply:GetForward() * 8 * plypos:Distance(target:GetPos()))
		end
	end
	
	if ply:IsPlayer() then
		vm = ply:GetViewModel()
		eyeang = ply:EyeAngles()
		cv = ply:Crouching()
	else
		self.NextMeleeAI = CurTime() + self.Primary.LungeDelayMiss
	end
	
	if cv == false then
		if SERVER then
			DRCCallGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, self.Primary.LungeMeleeAct)
		end
	elseif cv == true then
		if SERVER then
			DRCCallGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, self.Primary.LungeMeleeActCrouch)
		end
	end
	
	local x1 = self.Primary.LungeStartX
	local x2 = self.Primary.LungeEndX
	local y1 = self.Primary.LungeStartY
	local y2 = self.Primary.LungeEndY
		
	local x1m = math.Rand(x1 * 0.9, x1 * 1.1)
	local x2m = math.Rand(x2 * 0.9, x2 * 1.1)
	local y1m = math.Rand(y1 * 0.9, y1 * 1.1)
	local y2m = math.Rand(y2 * 0.9, y2 * 1.1)
	
	if ply:IsPlayer() then
		ply:ViewPunch(Angle(y1m, x1m, nil) * -0.1 * self.Primary.ShakeMul)
		ply:SetViewPunchVelocity(Angle(-x1m * (1 + self.Primary.HitDelay) * self.Primary.ShakeMul, -y1m * (5 + self.Primary.HitDelay) * self.Primary.ShakeMul, 0))
		timer.Simple(self.Primary.HitDelay, function()
			if !IsValid(self:GetOwner()) then return end
			if !IsValid(self) then return end
			ply:ViewPunch(Angle(y1m, x1m, nil) * 0.1 * self.Primary.ShakeMul)
		end)

		local anim = self:SelectWeightedSequence( self.Primary.LungeMissAct )
		if cv == true then anim = self:SelectWeightedSequence( self.Primary.LungeMissActCrouch ) end
		local animdur = self:SequenceDuration( anim )
		self.IsDoingMelee = true
		timer.Simple(animdur, function() if !IsValid(self) then return end self.IsDoingMelee = false end)
		
		if SERVER && anim != -1 && self:HasViewModel() then self:SendWeaponAnim( self:GetSequenceActivity(anim) ) end
		self:SetNextPrimaryFire( CurTime() + self.Primary.LungeDelayMiss )
		self.IdleTimer = CurTime() + vm:SequenceDuration()
	else
		self:SetNextPrimaryFire( CurTime() + self.Primary.LungeDelayMiss )
		self.IsDoingMelee = true
		timer.Simple(1, function() if !IsValid(self) then return end self.IsDoingMelee = false end)
	end
	
	self:EmitSound(Sound(self.Primary.SwingSound))
	
	for i=1,(math.Round(1/ engine.TickInterval() - 1 , 0)) do
		if !IsValid(self:GetOwner()) then return end
		if !IsValid(self) then return end
		timer.Create( "".. tostring(self) .."SwingImpact".. i .."", math.Round((self.Primary.LungeHitDelay * 100) / 60 * i / 60, 3), 1, function()
			if !IsValid(self) then return end
			if !IsValid(self:GetOwner()) then return end
			self:MeleeImpact(self.Primary.Range, Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), x1m, x2m), Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), y1m, y2m), i, "lungeprimary")
		end)
	end
end

function SWEP:DoPrimaryAttack()
	if !IsValid(self) then return end
	if !IsValid(self:GetOwner()) then return end
	self:DoCustomPrimaryAttack()
	
	local ply = self:GetOwner()
	local vm = nil
	local eyeang = ply:GetAimVector()
	local eyepos = ply:EyePos()
	local cv = false
	
	if ply:IsPlayer() then
		vm = ply:GetViewModel()
		eyeang = ply:EyeAngles()
		cv = ply:Crouching()
	else
		self.NextMeleeAI = CurTime() + self.Primary.DelayMiss
	end
	
	if cv == false then
		if SERVER then
			DRCCallGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, self.Primary.MeleeAct)
		end
	elseif cv == true then
		if SERVER then
			DRCCallGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, self.Primary.MeleeActCrouch)
		end
	end
	
	local x1 = self.Primary.StartX
	local x2 = self.Primary.EndX
	local y1 = self.Primary.StartY
	local y2 = self.Primary.EndY
		
	local x1m = math.Rand(x1 * 0.9, x1 * 1.1)
	local x2m = math.Rand(x2 * 0.9, x2 * 1.1)
	local y1m = math.Rand(y1 * 0.9, y1 * 1.1)
	local y2m = math.Rand(y2 * 0.9, y2 * 1.1)
	
	if ply:IsPlayer() then
		ply:ViewPunch(Angle(y1m, x1m, nil) * -0.1 * self.Primary.ShakeMul)
		ply:SetViewPunchVelocity(Angle(-x1m * (1 + self.Primary.HitDelay) * self.Primary.ShakeMul, -y1m * (5 + self.Primary.HitDelay) * self.Primary.ShakeMul, 0))
		timer.Simple(self.Primary.HitDelay, function()
			if !IsValid(self:GetOwner()) then return end
			if !IsValid(self) then return end
			ply:ViewPunch(Angle(y1m, x1m, nil) * 0.1 * self.Primary.ShakeMul)
		end)

		local anim = self:SelectWeightedSequence( self.Primary.MissActivity )
		if cv == true then anim = self:SelectWeightedSequence( self.Primary.CrouchMissActivity ) end
		local animdur = self:SequenceDuration( anim )
		self.IsDoingMelee = true
		timer.Simple(animdur, function() if !IsValid(self) then return end self.IsDoingMelee = false end)
		
		if SERVER && anim != -1 && self:HasViewModel() then self:SendWeaponAnim( self:GetSequenceActivity(anim) ) end
		self:SetNextPrimaryFire( CurTime() + self.Primary.DelayMiss )
		self.IdleTimer = CurTime() + vm:SequenceDuration()
	else
		self:SetNextPrimaryFire( CurTime() + self.Primary.DelayMiss )
		self.IsDoingMelee = true
		timer.Simple(1, function() if !IsValid(self) then return end self.IsDoingMelee = false end)
	end
	
	self:EmitSound(Sound(self.Primary.SwingSound))
	
	for i=1,(math.Round(1/ engine.TickInterval() - 1 , 0)) do
		if !IsValid(self:GetOwner()) then return end
		if !IsValid(self) then return end
		timer.Create( "".. tostring(self) .."SwingImpact".. i .."", math.Round((self.Primary.HitDelay * 100) / 60 * i / 60, 3), 1, function()
			if !IsValid(self) then return end
			if !IsValid(self:GetOwner()) then return end
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
	if !IsValid(self) then return end
	if !IsValid(self:GetOwner()) then return end
	self:DoCustomSecondaryAttack()
	
	local ply = self:GetOwner()
	local vm = nil
	local eyeang = ply:GetAimVector()
	local eyepos = ply:EyePos()
	local cv = false
	
	if ply:IsPlayer() then
		vm = ply:GetViewModel()
		eyeang = ply:EyeAngles()
		cv = ply:Crouching()
	else
		self.NextMeleeAI = CurTime() + self.Secondary.DelayMiss
	end
	
	if cv == false then
		if SERVER then
			DRCCallGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, self.Secondary.MeleeAct)
		end
	elseif cv == true then
		if SERVER then
			DRCCallGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, self.Secondary.MeleeActCrouch)
		end
	end
	
	local x1 = self.Secondary.StartX
	local x2 = self.Secondary.EndX
	local y1 = self.Secondary.StartY
	local y2 = self.Secondary.EndY
		
	local x1m = math.Rand(x1 * 0.9, x1 * 1.1)
	local x2m = math.Rand(x2 * 0.9, x2 * 1.1)
	local y1m = math.Rand(y1 * 0.9, y1 * 1.1)
	local y2m = math.Rand(y2 * 0.9, y2 * 1.1)
	
	if ply:IsPlayer() then
		ply:ViewPunch(Angle(y1m, x1m, nil) * -0.1 * self.Secondary.ShakeMul)
		ply:SetViewPunchVelocity(Angle(-x1m * (1 + self.Secondary.HitDelay) * self.Secondary.ShakeMul, -y1m * (5 + self.Secondary.HitDelay) * self.Secondary.ShakeMul, 0))
		timer.Simple(self.Secondary.HitDelay, function()
			if !IsValid(self:GetOwner()) then return end
			if !IsValid(self) then return end
			ply:ViewPunch(Angle(y1m, x1m, nil) * 0.1 * self.Secondary.ShakeMul)
		end)

		local anim = self:SelectWeightedSequence( self.Secondary.MissActivity )
		if cv == true then anim = self:SelectWeightedSequence( self.Secondary.CrouchMissActivity ) end
		local animdur = self:SequenceDuration( anim )
		self.IsDoingMelee = true
		timer.Simple(animdur, function() if !IsValid(self) then return end self.IsDoingMelee = false end)
		
		if SERVER && anim != -1 && self:HasViewModel() then self:SendWeaponAnim( self:GetSequenceActivity(anim) ) end
		self:SetNextSecondaryFire( CurTime() + self.Secondary.DelayMiss )
		self.IdleTimer = CurTime() + vm:SequenceDuration()
	else
		self:SetNextPrimaryFire( CurTime() + self.Secondary.DelayMiss )
		self.IsDoingMelee = true
		timer.Simple(1, function() if !IsValid(self) then return end self.IsDoingMelee = false end)
	end
	
	self:EmitSound(Sound(self.Secondary.SwingSound))
	
	for i=1,(math.Round(1/ engine.TickInterval() - 1 , 0)) do
		if !IsValid(self:GetOwner()) then return end
		if !IsValid(self) then return end
		timer.Create( "".. tostring(self) .."SwingImpact".. i .."", math.Round((self.Secondary.HitDelay * 100) / 60 * i / 60, 3), 1, function()
			if !IsValid(self) then return end
			if !IsValid(self:GetOwner()) then return end
			self:MeleeImpact(self.Secondary.Range, Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), x1m, x2m), Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), y1m, y2m), i, "Secondary")
		end)
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
	--	self:SendWeaponAnim( ACT_VM_DRAW )
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

function SWEP:DoCustomPrimaryAttack()
end

function SWEP:DoCustomSecondaryAttack()
end

function SWEP:DoCustomLunge()
end

-- NPC Support section

function SWEP:AI_PrimaryAttack() -- Iv04
	if self:CanPrimaryAttackNPC() == false then return end
	self:PrimaryAttackNPC()
end

function SWEP:NPC_ServerNextFire() -- VJ
	local ply = self:GetOwner()
	if !ply.IsVJBaseSNPC then return end
	if CLIENT or (!IsValid(self) or !IsValid(ply) or !ply:IsNPC()) then return end
	if self.NPCBursting == true then return end
	if ply:GetActiveWeapon() != self then return end
	if ply:CanDoCertainAttack("MeleeAttack") != true then return end
	if self:CanPrimaryAttackNPC() == false then return end
	
	local enemy = ply:GetEnemy()
	
	if ply:GetActivity() == nil then return end
	
	if enemy == nil then return end
	if IsValid(enemy) && ply:GetEnemyLastTimeSeen(enemy) > CurTime() then return end
	
	if IsValid(enemy) && !ply:IsLineOfSightClear(enemy:GetPos()) then return end
	
	if IsValid(enemy) then
		self:PrimaryAttackNPC()
	end
end

function SWEP:NPCAbleToShoot() -- VJ...
	local ply = self:GetOwner()
	if ply:CanDoCertainAttack("MeleeAttack") != true then return end
	if self:CanPrimaryAttackNPC() != false then return true end
end