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

SWEP.PassivePos 		= Vector(0, -25, -25)
SWEP.PassiveAng 		= Vector(0, 0, 0)
SWEP.InspectPos			= Vector(0, 0, -2)
SWEP.InspectAng			= Vector(5, 5, 0)

SWEP.ViewModelFlip  = false
SWEP.ShowWorldModel = true

SWEP.Primary.SwingSound			= Sound( "" )
SWEP.Primary.HitSoundWorld 		= nil
SWEP.Primary.HitSoundFlesh 		= nil
SWEP.Primary.HitSoundEnt 		= nil
SWEP.Primary.HitSound			= "hl2meleehard"
SWEP.Primary.HoldType			= "melee"
SWEP.Primary.CrouchHoldType		= "melee"
SWEP.Primary.ImpactDecal 		= ""
SWEP.Primary.BurnDecal 			= ""
SWEP.Primary.Automatic			= false
SWEP.Primary.Damage				= 12
SWEP.Primary.DamageType			= DMG_SLASH
SWEP.Primary.Range				= 20
SWEP.Primary.Force				= 5
SWEP.Primary.DelayMiss			= 0.42
SWEP.Primary.DelayHit 			= 0.54
SWEP.Primary.CanAttackCrouched 	= true
SWEP.Primary.HitActivity		= nil
SWEP.Primary.CrouchHitActivity	= nil
SWEP.Primary.MissActivity		= ACT_VM_PRIMARYATTACK 
SWEP.Primary.MissActivity_TP	= nil
SWEP.Primary.CrouchMissActivity	= nil 
SWEP.Primary.HitDelay			= 0.07
SWEP.Primary.StartX				= 20
SWEP.Primary.StartY				= 10
SWEP.Primary.EndX				= -20
SWEP.Primary.EndY				= -10
SWEP.Primary.ShakeMul			= 1

SWEP.Primary.CanLunge				= false
SWEP.Primary.LungeAutomatic			= false
SWEP.Primary.LungeRequiresTarget	= true
SWEP.Primary.LungeVelocity			= 1000
SWEP.Primary.LungeMaxDist			= 250
SWEP.Primary.LungeSwingSound		= nil
SWEP.Primary.LungeHitSoundWorld 	= nil
SWEP.Primary.LungeHitSoundFlesh 	= nil
SWEP.Primary.LungeHitSoundEnt		= nil
SWEP.Primary.LungeHitSound			= "hl2meleehard"
SWEP.Primary.LungeImpactDecal 		= ""
SWEP.Primary.LungeBurnDecal 		= ""
SWEP.Primary.LungeHitAct			= nil
SWEP.Primary.LungeHitActCrouch		= nil
SWEP.Primary.LungeMissAct			= ACT_VM_PRIMARYATTACK
SWEP.Primary.LungeMissActivity_TP	= nil
SWEP.Primary.LungeMissActCrouch		= nil
SWEP.Primary.LungeDelayMiss			= 1.3
SWEP.Primary.LungeDelayHit			= 0.7
SWEP.Primary.LungeHitDelay			= 0.26
SWEP.Primary.LungeDamage			= 0
SWEP.Primary.LungeDamageType		= DMG_SLASH
SWEP.Primary.LungeRange				= 25
SWEP.Primary.LungeForce				= 20
SWEP.Primary.LungeStartX			= 7
SWEP.Primary.LungeStartY			= -3
SWEP.Primary.LungeEndX				= -7
SWEP.Primary.LungeEndY				= 3
SWEP.Primary.LungeShakeMul			= 1

SWEP.Secondary.SwingSound 	 		= Sound( "" )
SWEP.Secondary.HitSoundWorld 		= nil
SWEP.Secondary.HitSoundFlesh 		= nil
SWEP.Secondary.HitSoundEnt 	 		= nil
SWEP.Secondary.HitSound 	 		= "hl2meleehard"
SWEP.Secondary.HoldType		 		= "knife"
SWEP.Secondary.HoldTypeCrouch	 	= "melee2"
SWEP.Secondary.ImpactDecal 	 		= ""
SWEP.Secondary.BurnDecal 	 		= ""
SWEP.Secondary.Automatic 	 		= false
SWEP.Secondary.Damage 	  	 		= 0
SWEP.Secondary.DamageType	 		= DMG_SLASH
SWEP.Secondary.Range       	 		= 30
SWEP.Secondary.Force	   		 	= 15
SWEP.Secondary.DelayMiss   	 		= 1.5
SWEP.Secondary.DelayHit	   	 		= 0.78
SWEP.Secondary.CanAttackCrouched 	= true
SWEP.Secondary.HitActivity			= nil
SWEP.Secondary.CrouchHitActivity	= nil
SWEP.Secondary.MissActivity			= ACT_VM_MISSCENTER
SWEP.Secondary.MissActivity_TP		= nil
SWEP.Secondary.CrouchMissActivity	= nil
SWEP.Secondary.Velocity				= Vector(0, 0, 0)
SWEP.Secondary.HitDelay				= 0.07
SWEP.Secondary.StartX				= 20
SWEP.Secondary.StartY				= 0
SWEP.Secondary.EndX					= -20
SWEP.Secondary.EndY					= 0
SWEP.Secondary.ShakeMul				= 1

SWEP.AIAttack = "Primary"

-- DO NOT TOUCH
SWEP.Primary.Ammo = ""
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
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
	if game.SinglePlayer() then self:CallOnClient("PrimaryAttack") end
	if !IsValid(self) or !IsValid(self.Owner) then return end
	if !self:CanPrimaryAttack() then return end
	self:DoCustomPrimary()
	if self.Primary.Disabled == true then return end
	if self:GetNWBool("Inspecting") == true then return end
	local ply = self:GetOwner()
	if !ply:IsPlayer() then self:PrimaryAttackNPC() return end
	local cv = ply:Crouching()
	local CanCrouchAttack = self.Primary.CanAttackCrouched
	local et = ply:GetEyeTrace()
	local target = self:GetConeTarget(self.Primary.LungeMaxDist)
	
	local moving = (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_BACK) or ply:KeyDown(IN_FORWARD)) && sprintkey
	if (self.DoesPassiveSprint == true or GetConVar("sv_drc_force_sprint"):GetString() == "1") && moving then return end
	
	if self.Primary.CanLunge == true then
		if self.Primary.LungeAutomatic == true then
			if IsValid(target) && DRC:IsCharacter(target) then
				if(ply:GetPos():Distance(target:GetPos()) < self.Primary.LungeMaxDist) then
					if cv == false && self:GetNWBool("Passive") == false then
						self:DoPrimaryLunge()
						elseif cv == true && CanCrouchAttack == true then
						self:DoPrimaryLunge()
					elseif cv == true && CanCrouchAttack == false then
					end
				elseif(ply:GetPos():Distance(target:GetPos()) > self.Primary.LungeMaxDist) then
					if cv == false then
							if self.Primary.isvFire == false && self:GetNWBool("Passive") == false then
								self:DoPrimaryAttack()
							elseif self:GetNWBool("Passive") == false then
							self:ShootFire()
								if SERVER then
									if (self.Owner:KeyPressed(IN_ATTACK) || !self.LoopingFireSound) then
										self.LoopingFireSound = CreateSound(self.Owner, self.Secondary.SwingSound)
									end
								if (self.LoopingFireSound) then self.LoopingFireSound:Play() end
								end
							end
						elseif cv == true && CanCrouchAttack == true then
							if self.Primary.isvFire == false && self:GetNWBool("Passive") == false then
								self:DoPrimaryAttack()
							elseif self:GetNWBool("Passive") == false then
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
							if self.Primary.isvFire == false && self:GetNWBool("Passive") == false then
								self:DoPrimaryAttack()
							elseif self:GetNWBool("Passive") == false then
							self:ShootFire()
								if SERVER then
									if (self.Owner:KeyPressed(IN_ATTACK) || !self.LoopingFireSound) then
										self.LoopingFireSound = CreateSound(self.Owner, self.Secondary.SwingSound)
									end
								if (self.LoopingFireSound) then self.LoopingFireSound:Play() end
								end
							end
					elseif cv == true && CanCrouchAttack == true then
							if self.Primary.isvFire == false && self:GetNWBool("Passive") == false then
								self:DoPrimaryAttack()
							elseif self:GetNWBool("Passive") == false then
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
							if self.Primary.isvFire == false && self:GetNWBool("Passive") == false then
								self:DoPrimaryAttack()
							elseif self:GetNWBool("Passive") == false then
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
							if self.Primary.isvFire == false && self:GetNWBool("Passive") == false then
								self:DoPrimaryAttack()
							elseif self:GetNWBool("Passive") == false then
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
							if self.Primary.isvFire == false && self:GetNWBool("Passive") == false then
								self:DoPrimaryAttack()
							elseif self:GetNWBool("Passive") == false then
							self:ShootFire()
								if SERVER then
									if (self.Owner:KeyPressed(IN_ATTACK) || !self.LoopingFireSound) then
										self.LoopingFireSound = CreateSound(self.Owner, self.Secondary.SwingSound)
									end
								if (self.LoopingFireSound) then self.LoopingFireSound:Play() end
								end
							end
			else
				if self.Primary.isvFire == false && self:GetNWBool("Passive") == false then
					self:DoPrimaryAttack()
				elseif self:GetNWBool("Passive") == false then
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
							if self.Primary.isvFire == false && self:GetNWBool("Passive") == false then
								self:DoPrimaryAttack()
							elseif self:GetNWBool("Passive") == false then
							self:ShootFire()
								if SERVER then
									if (self.Owner:KeyPressed(IN_ATTACK) || !self.LoopingFireSound) then
										self.LoopingFireSound = CreateSound(self.Owner, self.Secondary.SwingSound)
									end
								if (self.LoopingFireSound) then self.LoopingFireSound:Play() end
								end
							end
			elseif cv == true && CanCrouchAttack == true then
							if self.Primary.isvFire == false && self:GetNWBool("Passive") == false then
								self:DoPrimaryAttack()
							elseif self:GetNWBool("Passive") == false then
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
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	local isply = ply:IsPlayer()
	self:DoCustomLunge()
	
	local miss_tp, hit_tp, miss_fp, miss_tpc
	local ht, htc = self.Primary.LungeHoldType, self.Primary.LungeHoldTypeCrouch
	local ma, mac, ha, hac = self.Primary.LungeMissAct, self.Primary.LungeMissActCrouch, self.Primary.LungeHitAct, self.Primary.LungeHitActCrouch
	local matp, matpc = self.Primary.LungeMissAct_TP, self.Primary.LungeMissActCrouch_TP
	if ht && !htc then htc = ht end
	if !mac then mac = ma end
	if !hac then hac = ha end
	
	if matp then miss_tp = matp else miss_tp = DRC:GetHoldTypeAnim(ht, "attack", !isply) end
	if matpc then miss_tpc = matpc else miss_tpc = DRC:GetHoldTypeAnim(ht, "attack", !isply) end
	
	miss_fp = ma
	hit_fp = ha or nil
	
	if isply then
		local cv = ply:Crouching()
		if cv then
			miss_fp = mac
			hit_fp = hac
		end
	end
	
	local swing = {
		["lunge"] = {true, self.Primary.LungeMaxDist, self.Primary.LungeVelocity},
		["range"] = self.Primary.LungeRange,
		["x"] = {self.Primary.LungeStartX, self.Primary.LungeEndX},
		["y"] = {self.Primary.LungeStartY, self.Primary.LungeEndY},
		["delay"] = { self.Primary.LungeDelayHit, self.Primary.LungeDelayMiss, self.Primary.LungeHitDelay }, -- hit, miss, tick
		["screenshake"] = { true, self.Primary.LungeShakeMul }, -- do shake, shake power
		["anim_tp_crouch"] = miss_tpc, --ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE,
		["anim_tp"] = miss_tp,
		["anim_fp_miss"] = miss_fp,
		["anim_fp"] = hit_fp,
		["damage"] = { self.Primary.LungeDamage, self.Primary.LungeDamageType, self.Primary.LungeForce },
		["decals"] = { self.Primary.LungeImpactDecal, self.Primary.LungeBurnDecal },
		["sound"] = self.Primary.LungeSwingSound,
		["hitsound"] = self.Primary.LungeHitSound,
		["trigger"] = 3,
	}
	self:DoMeleeSwing(swing)
end

function SWEP:DoPrimaryAttack()
	if !IsValid(self) then return end
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	local isply = ply:IsPlayer()
	self:DoCustomPrimaryAttack()
	
	local miss_tp, hit_tp, miss_fp, miss_tpc
	local ht, htc = self.Primary.HoldType, self.Primary.HoldTypeCrouch
	local ma, mac, ha, hac = self.Primary.MissActivity, self.Primary.CrouchMissActivity, self.Primary.HitActivity, self.Primary.CrouchHitActivity
	local matp, matpc = self.Primary.MissActivity_TP, self.Primary.MissActivityCrouch_TP
	if ht && !htc then htc = ht end
	if !mac then mac = ma end
	if !hac then hac = ha end
	
	if matp then miss_tp = matp else miss_tp = DRC:GetHoldTypeAnim(ht, "attack", !isply) end
	if matpc then miss_tpc = matpc else miss_tpc = DRC:GetHoldTypeAnim(ht, "attack", !isply) end
	
	miss_fp = ma
	hit_fp = ha or nil
	
	if isply then
		local cv = ply:Crouching()
		if cv then
			miss_fp = mac
			hit_fp = hac
		end
	end
	
	local swing = {
		["lunge"] = {false, nil, nil},
		["range"] = self.Primary.Range,
		["x"] = {self.Primary.StartX, self.Primary.EndX},
		["y"] = {self.Primary.StartY, self.Primary.EndY},
		["delay"] = { self.Primary.DelayHit, self.Primary.DelayMiss, self.Primary.HitDelay }, -- hit, miss, tick
		["screenshake"] = { true, self.Primary.ShakeMul }, -- do shake, shake power
		["anim_tp_crouch"] = miss_tpc, --ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE,
		["anim_tp"] = miss_tp,
		["anim_fp_miss"] = miss_fp,
		["anim_fp"] = hit_fp,
		["damage"] = { self.Primary.Damage, self.Primary.DamageType, self.Primary.Force },
		["decals"] = { self.Primary.ImpactDecal, self.Primary.BurnDecal },
		["sound"] = self.Primary.SwingSound,
		["hitsound"] = self.Primary.HitSound,
		["trigger"] = 1,
	}
	self:DoMeleeSwing(swing)

--[[
	if !IsValid(self) then return end
	if !IsValid(self:GetOwner()) then return end
	self:DoCustomPrimaryAttack()
	self:DoMeleeSwing("primary")
]]
end

function SWEP:SecondaryAttack()
	if game.SinglePlayer() then self:CallOnClient("SecondaryAttack") end
	if !IsValid(self) or !IsValid(self.Owner) then return end
	self:DoCustomSecondary()
	if self.Secondary.Disabled == true then return end
	if self:GetNWBool("Inspecting") == true then return end
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
				elseif self:GetNWBool("Passive") == false then
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
			if self.Secondary.isvFire == false && self:GetNWBool("Passive") == false then
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
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	local isply = ply:IsPlayer()
	self:DoCustomSecondaryAttack()
	
	local miss_tp, hit_tp, miss_fp, miss_tpc
	local ht, htc = self.Secondary.HoldType, self.Secondary.HoldTypeCrouch
	local ma, mac, ha, hac = self.Secondary.MissActivity, self.Secondary.CrouchMissActivity, self.Secondary.HitActivity, self.Secondary.CrouchHitActivity
	local matp, matpc = self.Secondary.MissActivity_TP, self.Secondary.MissActivityCrouch_TP
	if ht && !htc then htc = ht end
	if !mac then mac = ma end
	if !hac then hac = ha end
	
	if matp then miss_tp = matp else miss_tp = DRC:GetHoldTypeAnim(ht, "attack", !isply) end
	if matpc then miss_tpc = matpc else miss_tpc = DRC:GetHoldTypeAnim(ht, "attack", !isply) end
	
	miss_fp = ma
	hit_fp = ha or nil
	
	if isply then
		local cv = ply:Crouching()
		if cv then
			miss_fp = mac
			hit_fp = hac
		end
	end
	
	local swing = {
		["lunge"] = {false, nil, nil},
		["range"] = self.Secondary.Range,
		["x"] = {self.Secondary.StartX, self.Secondary.EndX},
		["y"] = {self.Secondary.StartY, self.Secondary.EndY},
		["delay"] = { self.Secondary.DelayHit, self.Secondary.DelayMiss, self.Secondary.HitDelay }, -- hit, miss, tick
		["screenshake"] = { true, self.Secondary.ShakeMul }, -- do shake, shake power
		["anim_tp_crouch"] = miss_tpc, --ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE,
		["anim_tp"] = miss_tp,
		["anim_fp_miss"] = miss_fp,
		["anim_fp"] = hit_fp,
		["damage"] = { self.Secondary.Damage, self.Secondary.DamageType, self.Secondary.Force },
		["decals"] = { self.Secondary.ImpactDecal, self.Secondary.BurnDecal },
		["sound"] = self.Secondary.SwingSound,
		["hitsound"] = self.Secondary.HitSound,
		["trigger"] = 2,
	}
	self:DoMeleeSwing(swing)

--[[
	if !IsValid(self) then return end
	if !IsValid(self:GetOwner()) then return end
	self:DoCustomSecondaryAttack()
	self:DoMeleeSwing("secondary")
]]
end

function SWEP:Reload()
	local ply = self:GetOwner()
	local usekey = ply:KeyDown(IN_USE)
	local reloadkey = ply:KeyDown(IN_RELOAD)
	local walkkey = ply:KeyDown(IN_WALK)
	local sprintkey = ply:KeyDown(IN_SPEED)
	local reloadkeypressed = ply:KeyPressed(IN_RELOAD)

	self:DoCustomReload()

	if usekey && reloadkeypressed then
		if sprintkey then
			self:ToggleInspectMode()
			if self.Inspecting == true then self:Inspect() end
		else
			if self.Inspecting == false then
			--	self.Idle = 0
			--	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
				self:Inspect()
			end
		end
	elseif reloadkey && self.IsTaunting == 0 then
		self:Taunt()
		elseif reloadkey && self.IsTaunting == 1 then
	end
end

function SWEP:DoCustomReload()
end

function SWEP:TogglePassive()
	local ply = self:GetOwner()
	
	if GetConVar("sv_drc_passives"):GetString() == "0" then return end
	
	if self.Passive == false then
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
	--if ply:CanDoCertainAttack("MeleeAttack") != true then return end -- removed silently, cool.
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