AddCSLuaFile()

function SWEP:RegeneratingHealth(ply)
	local ply = self:GetOwner()
	if not ply:IsPlayer() then return end
	local hp, maxhp
	if self.HealthRegen == false or self.HealthRegen == nil then return end

	self.PassiveHealing = "HealthRegen_".. ply:Name()
	
	timer.Create(self.PassiveHealing , self.HealInterval, 0, function() 
		if !SERVER or !self:IsValid()  or !timer.Exists( self.PassiveHealing ) then return end
		
		hp = ply:Health()
		maxhp = (ply:GetMaxHealth())
		if maxhp < hp then return end
		ply:SetHealth(math.Clamp( hp + self.HealAmount, 0, maxhp ))
	end)
end

function SWEP:RegeneratingAmmo(self)
	local ply = self:GetOwner()
	if not ply:IsPlayer() then return end
	local ammo, maxammo
	if self.RegenAmmo == false or self.RegenAmmo == nil then return end

	self.AmmoRegen = "AmmoRegen_".. ply:Name()
	
		timer.Create(self.AmmoRegen, self.AmmoInterval, 0, function() 
			if !SERVER or !self:IsValid()  or !timer.Exists( self.AmmoRegen ) then return end
			
			ammo = self.Weapon:Clip1()
			maxammo = (self.Primary.ClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))
			if maxammo < ammo then return end
			if self.Loading == false then
				self.Weapon:SetNWInt("LoadedAmmo", math.Clamp( ammo + self.AmmoRegenAmount, 0, maxammo ))
				self.Weapon:SetClip1(self.Weapon:GetNWInt("LoadedAmmo"))
			end
		end)
end

function SWEP:DisperseHeat()
	local ply = self:GetOwner()
	if not ply:IsPlayer() then return end
	local CurHeat = self:GetNWInt("Heat")

	self.HeatDisperseTimer = "HeatDisperseTimer_".. ply:Name()
	
	if self.DisperseHeatPassively == true then
	timer.Create(self.HeatDisperseTimer, self.HeatLossInterval, 0, function() 
		if !SERVER or !self:IsValid()  or !timer.Exists( self.HeatDisperseTimer ) then return end
		if self:GetNWInt("Heat") == 0 then return end
		
		CurHeat = self:GetNWInt("Heat")
		if ply:GetAmmoCount( "ammo_drc_battery" ) >= 101 then
			self:SetNWInt("Heat", 100)
			ply:SetAmmo(self:GetNWInt("Heat"), "ammo_drc_battery")
		elseif ply:GetAmmoCount( "ammo_drc_battery" ) >= 0 then
			if self.Weapon:GetNWFloat("HeatDispersePower") == 0 then
			else
				self:SetNWInt("Heat", math.Clamp( (self:GetNWInt("Heat") - (self.HeatLossPerInterval * self.Weapon:GetNWFloat("HeatDispersePower"))), 0, 100), self.Primary.Ammo )
				ply:SetAmmo(self:GetNWInt("Heat"), "ammo_drc_battery" )
			end
		end
		
		if ply:GetAmmoCount( "ammo_drc_battery" ) >= 100 then
			if self.CanOverheat == true then
				self:Overheat()
			else end
		else end
		
		if ply:GetAmmoCount( "ammo_drc_battery" ) >= (100 - (100 * self.OverHeatFinishPercent)) then
		else
			self.IsOverheated = false
		end
		
		if self.IsOverheated == true && self.DoOverheatDamage == true then
			ply:TakeDamage( self.OverheatDamagePerInt )
		else end
	end)
	else
	end
end

function SWEP:BloomScore()
	if self.Base != "draconic_melee_base" then
		local ply = self:GetOwner()
		local cv = ply:Crouching()
		local sk = ply:KeyDown(IN_SPEED)
		local mk = (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK))
		local plidle = (!mk && !sk && !cv)
		local issprinting = sk && mk

		self.BloomScoreName = "BloomScore_".. ply:Name()
		
		timer.Create(self.BloomScoreName, (60 / self.Primary.RPM) * 3, 0, function() 
			if !self:IsValid() then return end
			if self.BloomValue == 0 then return end
			
			local bs = self.BloomValue
			local pbs = self.PrevBS
			if self.SightsDown == false then
				if plidle then
					self.PrevBS = math.Clamp( bs, 0, 1.7)
					self.BloomValue = math.Clamp( bs - (self.Primary.Kick * 1.5), 0, 1)
				elseif cv then
					self.PrevBS = math.Clamp( bs, 0, 1.7)
					self.BloomValue = math.Clamp( bs - (self.Primary.Kick * 1.75), 0, 1)
				elseif mk then
					self.PrevBS = math.Clamp( bs, 0, 1.7)
					self.BloomValue = math.Clamp( bs - self.Primary.Kick * 2 +0.1, 0, 1.3)
				elseif issprinting then
					self.PrevBS = math.Clamp( bs, 0, 1.7)
					self.BloomValue = math.Clamp( bs - self.Primary.Kick * 2 +0.3, 0, 1.7)
				end
			else
				if plidle then
					self.PrevBS = math.Clamp( bs, 0, 1.7)
					self.BloomValue = math.Clamp( bs - ((self.Primary.Kick * 2) / 1.5), 0, 1)
				elseif cv then
					self.PrevBS = math.Clamp( bs, 0, 1.7)
					self.BloomValue = math.Clamp( bs - ((self.Primary.Kick * 2) / 3), 0, 1)
				elseif mk then
					self.PrevBS = math.Clamp( bs, 0, 1.7)
					self.BloomValue = math.Clamp( bs - (self.Primary.Kick +0.1) /2, 0, 1)
				elseif issprinting then
					self.PrevBS = math.Clamp( bs, 0, 1.7)
					self.BloomValue = math.Clamp( bs - (self.Primary.Kick +0.3) /2, 0, 1)
				end
			end
		--	print(self.BloomValue)
		end)
		
	repeat until timer.Exists(self.BloomScoreName)
	end
end

function SWEP:DisperseCharge()
	local ply = self:GetOwner()
	local m1d = ply:KeyDown(IN_ATTACK)
	local m2d = ply:KeyDown(IN_ATTACK2)
	
	if !ply:IsPlayer() then return end
	
	self.ChargeDisperseTimer = "ChargeDisperseTimer_".. ply:Name()

	timer.Create(self.ChargeDisperseTimer, 0.1, 0, function() 
		if !SERVER or !self:IsValid()  or !timer.Exists( self.ChargeDisperseTimer ) then return end
		
		local m1d = ply:KeyDown(IN_ATTACK)
		local m2d = ply:KeyDown(IN_ATTACK2)
		local ukd = ply:KeyDown(IN_USE)
		
		if self.Weapon:GetNWInt("LoadedAmmo") >= 0 then
			if self.Primary.UsesCharge == true then
				if m1d && self:CanPrimaryAttack() && (self.Weapon:GetNWBool("Passive") == false && self.ManuallyReloading == false) && !ukd then self.Weapon:SetNWInt("Charge", math.Clamp( self.Weapon:GetNWInt("Charge") + self.ChargeRate, 0, 100))
				else self.Weapon:SetNWInt("Charge", math.Clamp( self.Weapon:GetNWInt("Charge") - self.ChargeRate * 10, 0, 100)) end
			else end
			
			if self.Secondary.UsesCharge == true then
				if m2d && self:CanSecondaryAttack() && (self.Weapon:GetNWBool("Passive") == false && self.ManuallyReloading == false) && !ukd then self.Weapon:SetNWInt("Charge", math.Clamp( self.Weapon:GetNWInt("Charge") + self.ChargeRate, 0, 100))
				else self.Weapon:SetNWInt("Charge", math.Clamp( self.Weapon:GetNWInt("Charge") - self.ChargeRate * 10, 0, 100)) end
			else end
			
			if self.Weapon:GetNWInt("Charge") >= 101 then
				self.Weapon:SetNWInt("Charge", 100)
			end
			
			if self.Weapon:GetNWInt("Charge") > 99 then
				self.Weapon:SetNWInt("LoadedAmmo", self.Weapon:GetNWInt("LoadedAmmo") - self.ChargeHoldDrain)
				self.Weapon:SetClip1( self.Weapon:GetNWInt("LoadedAmmo") )
			end
		else end
	end)
end

function SWEP:CanOvercharge()
	if self.Weapon:GetNWInt("Charge") > 99 then return true else return false end
end

function SWEP:UpdateBloom(mode)
	local ply = self:GetOwner()
	if !ply:IsPlayer() then return end
	local cv = ply:Crouching()
	local sk = ply:KeyDown(IN_SPEED)
	local mk = (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK))
	local plidle = (!mk && !sk && !cv)
	local issprinting = sk && mk
	
	if mode == "primary" then
		self.Kick = self.Primary.Kick
	elseif mode == "secondary" then
		self.Kick = self.Secondary.Kick
	elseif mode == "overcharge" then
		self.Kick = self.OCKick
	end
	
	local bs = self.BloomValue
	local pbs = self.PrevBS
	if bs == nil then bs = 0 end
	if pbs == nil then pbs = 0 end
	if self.SightsDown == false then
		if plidle or sk then
			self.PrevBS = math.Clamp( bs, 0, 1.7)
			self.BloomValue = math.Clamp( self.BloomValue + self.Kick, 0, 1)
		elseif cv then
			self.PrevBS = math.Clamp( bs, 0, 1.7)
			self.BloomValue = math.Clamp( self.BloomValue + self.Kick / 1.25, 0, 1)
		elseif mk then
			self.PrevBS = math.Clamp( bs, 0, 1.7)
			self.BloomValue = math.Clamp( self.BloomValue + self.Kick +0.1, 0, 1.3)
		elseif issprinting then
			self.PrevBS = math.Clamp( bs, 0, 1.7)
			self.BloomValue = math.Clamp( self.BloomValue + self.Kick +0.3, 0, 1.7)
		end
	else
		if plidle or sk then
			self.PrevBS = math.Clamp( bs, 0, 1.7)
			self.BloomValue = math.Clamp( self.BloomValue + self.Primary.Kick /2, 0, 1)
		elseif cv then
			self.PrevBS = math.Clamp( bs, 0, 1.7)
			self.BloomValue = math.Clamp( self.BloomValue + (self.Primary.Kick /1.25) /2, 0, 1)
		elseif mk then
			self.PrevBS = math.Clamp( bs, 0, 1.7)
			self.BloomValue = math.Clamp( self.BloomValue + (self.Primary.Kick +0.1) /2, 0, 1)
		elseif issprinting then
			self.PrevBS = math.Clamp( bs, 0, 1.7)
			self.BloomValue = math.Clamp( self.BloomValue + (self.Primary.Kick +0.3) /2, 0, 1)
		end
	end
	
	ply:SetNWInt("PrevBS", self.BloomValue * 10)
end

function SWEP:GetBS()
	return self.BloomValue
end

function SWEP:GetPBS()
	return self.PrevBS
end

function SWEP:MeleeImpact(range, x, y, i, att)
	if not SERVER then return end
	local ply = self:GetOwner()
	local vm = ply:GetViewModel()
	local eyeang = ply:EyeAngles()
	local eyepos = ply:EyePos()
	
	local rhm = math.Round(1 / engine.TickInterval() - 1, 0) / 2
	
	if not IsValid(self) or not IsValid(ply) then return end

	if i < rhm then
		self.dist = eyepos + ( ply:GetAimVector() * range * ( i / 10) )
	elseif i == rhm then
		self.dist = eyepos + ( ply:GetAimVector() * range * 3.4 )
	elseif i > rhm then
		self.dist = eyepos + ( ply:GetAimVector() * range / (i / 100) )
	end
	
	local tl = {}
		tl.start = self.Owner:GetShootPos()
		tl.endpos = ( self.dist ) + ( ( eyeang:Up() * y ) + ( eyeang:Right() * x ) )
		tl.filter = self.Owner
		tl.mask = MASK_SHOT
	if ply:IsPlayer() then ply:LagCompensation(true) end
	local swingtrace = util.TraceLine( tl )
	if ply:IsPlayer() then ply:LagCompensation(false) end
	
	if att == "primary" then 
		self.Force 	= self.Primary.Force
		self.Damage = self.Primary.Damage
		self.ID		= self.Primary.ImpactDecal
		self.BD		= self.Primary.BurnDecal
		self.DT		= self.Primary.DamageType
		self.DH		= self.Primary.DelayHit
		self.HA		= self.Primary.MeleeHitActivity
		self.HSF	= self.Primary.HitSoundFlesh
		self.HSE	= self.Primary.HitSoundEnt
		self.HSW	= self.Primary.HitSoundWorld
	elseif att == "secondary" then 
		self.Force = self.Secondary.Force
		self.Damage = self.Secondary.Damage
		self.ID		= self.Secondary.ImpactDecal
		self.BD		= self.Secondary.BurnDecal
		self.DT		= self.Secondary.DamageType
		self.DH		= self.Secondary.DelayHit
		self.HA		= self.Secondary.MeleeHitActivity
		self.HSF	= self.Secondary.HitSoundFlesh
		self.HSE	= self.Secondary.HitSoundEnt
		self.HSW	= self.Secondary.HitSoundWorld
	elseif att == "lungeprimary" then 
		self.Force = self.Primary.LungeForce
		self.Damage = self.Primary.LungeDamage
		self.ID		= self.Primary.LungeImpactDecal
		self.BD		= self.Primary.LungeBurnDecal
		self.DT		= self.Primary.LungeDamageType
		self.DH		= self.Primary.LungeDelayHit
		self.HA		= self.Primary.LungeHitAct
		self.HSF	= self.Primary.LungeHitSoundFlesh
		self.HSE	= self.Primary.LungeHitSoundEnt
		self.HSW	= self.Primary.LungeHitSoundWorld
	elseif att == "gunmelee" then
		self.Force 	= self.Primary.MeleeForce
		self.Damage = self.Primary.MeleeDamage
		self.ID		= self.Primary.MeleeImpactDecal
		self.BD		= self.Primary.MeleeBurnDecal
		self.DT		= self.Primary.MeleeDamageType
		self.DH		= self.Primary.MeleeDelayHit
		self.HA		= self.Primary.MeleeHitActivity
		self.HSF	= self.Primary.MeleeHitSoundFlesh
		self.HSE	= self.Primary.MeleeHitSoundEnt
		self.HSW	= self.Primary.MeleeHitSoundWorld
	end
	
	if ( swingtrace.Hit ) then
	self:SetNextPrimaryFire( CurTime() + self.DH )
	self:SetNextSecondaryFire( CurTime() + self.DH )
	
	if self.HA != nil then self.Weapon:SendWeaponAnim( self.HA ) end
	
	for i=-1, (math.Round(1/ engine.TickInterval() - 1 , 0)) do
		if timer.Exists("SwingImpact".. i .."") then timer.Destroy("SwingImpact".. i .."") end
	end
	if swingtrace.Entity:IsValid() and ( swingtrace.Entity:IsNextBot() or swingtrace.Entity:IsNPC() or swingtrace.Entity:IsPlayer() ) then
	local damageinfo = DamageInfo()
		damageinfo:SetAttacker( ply )
		damageinfo:SetInflictor( self )
		damageinfo:SetDamageType( self.DT )
		damageinfo:SetDamageForce((self.Owner:GetRight() * math.random(3568,4235)) + (self.Owner:GetForward() * math.random(6875,7523)))
		damageinfo:SetDamage( self.Damage )
	swingtrace.Entity:TakeDamageInfo( damageinfo )
	elseif swingtrace.Entity:IsValid() and ( !swingtrace.Entity:IsNPC() or !swingtrace.Entity:IsPlayer() ) && !swingtrace.Entity:IsNextBot() && IsValid(swingtrace.Entity:GetPhysicsObject()) then
		if i < rhm then
			swingtrace.Entity:GetPhysicsObject():ApplyForceOffset( self.Owner:GetForward() * self.Force * 50 * i, swingtrace.HitPos )
		elseif i == rhm then	
			swingtrace.Entity:GetPhysicsObject():ApplyForceOffset( self.Owner:GetForward() * self.Force * 50 * i, swingtrace.HitPos )
		elseif i > rhm then
			swingtrace.Entity:GetPhysicsObject():ApplyForceOffset( self.Owner:GetForward() * self.Force * 50 * ( i / 10 ), swingtrace.HitPos )
		end
		
		if swingtrace.Entity:Health() > 0 then
		swingtrace.Entity:TakeDamage( self.Damage, self.Owner, self.Owner:GetActiveWeapon() )
		end
	elseif swingtrace.Entity:IsWorld() then
		util.Decal(self.ID, swingtrace.HitPos + swingtrace.HitNormal, swingtrace.HitPos - swingtrace.HitNormal)  
		util.Decal(self.BD, swingtrace.HitPos + swingtrace.HitNormal, swingtrace.HitPos - swingtrace.HitNormal)  
	end
	end

	if ( swingtrace.Hit ) then
		self:DoCustomMeleeImpact(att, swingtrace)
			if swingtrace.Entity:IsPlayer() or string.find(swingtrace.Entity:GetClass(),"npc") or string.find(swingtrace.Entity:GetClass(),"prop_ragdoll") or string.find(swingtrace.Entity:GetClass(),"prop_physics") then
				if string.find(swingtrace.Entity:GetClass(),"prop_physics") then
			self:EmitSound(Sound(self.HSE))
			else
				self:EmitSound(Sound(self.HSF))
			end
			else
				self:EmitSound(Sound(self.HSW))
			end
	end
end

function SWEP:TakePrimaryAmmo( num )
	if not SERVER then return end
	if ( self.Weapon:Clip1() <= 0 ) && self.Owner:IsPlayer() then
		if ( self:Ammo1() <= 0 ) then return end
		self.Owner:RemoveAmmo( num, self.Weapon:GetPrimaryAmmoType() )
	return end
	self.Weapon:SetClip1(self.Weapon:GetNWInt("LoadedAmmo"))
end

function SWEP:TakeSecondaryAmmo( num )
	if ( self.Weapon:Clip2() <= 0 ) then
		if ( self:Ammo2() <= 0 ) then return end
		self.Owner:RemoveAmmo( num, self.Weapon:GetSecondaryAmmoType() )
	return end
	self.Weapon:SetClip2( self.Weapon:Clip2() - num )
end

function SWEP:DoCustomBulletImpact(pos, normal, dmg)
end

function SWEP:GetConeTarget()
	local ply = self:GetOwner()
	if !ply or !ply:IsPlayer() then return end
	local coneents = DRC:EyeCone(ply, 500, self.SpreadCone)
	local targets = {}
	for k,v in pairs(coneents) do
		if (v:IsPlayer() && v != ply) or v:IsNPC() or v:IsNextBot() then table.insert(targets, v) end
	end
	local closesttarget = nil
	for k,v in pairs(targets) do
		local dist = v:EyePos():DistToSqr(ply:EyePos())
		if k == 1 then
			closesttarget = {v, dist}
		else
			if dist < closesttarget[2] then closesttarget = {v, dist} end
		end
	end
	if !closesttarget then return nil end
	
	local target, dist = closesttarget[1], closesttarget[2]
	return target, dist
end

function SWEP:ShootBullet(damage, num, cone, ammo, force, tracer)
	local ply = self:GetOwner()
	local fm = self:GetNWString("FireMode")
	if fm == "Burst" && !IsFirstTimePredicted() then return end
	
	force = self.Primary.Force * self:GetAttachmentValue("Ammunition", "Force")
	
	if self.Primary.Tracer == nil then
		tracer = self:GetAttachmentValue("Ammunition", "Tracer")
	end
	
--	local tgt = self:GetConeTarget()
--	print(tgt)

	local bullet = {}
	bullet.Num = num
	bullet.Src = ply:GetShootPos()
	bullet.Dir = ply:GetAimVector()
	bullet.Tracer = tracer
	bullet.Force = force
	bullet.Damage = damage
	bullet.Spread = cone
	bullet.Callback = function(ent, tr, takedamageinfo) -- https://imgur.com/a/FCDZOEx
		if IsValid(self) then
			takedamageinfo:SetAttacker(self:GetOwner())
			takedamageinfo:SetInflictor(self)
			takedamageinfo:SetDamageType( self:GetAttachmentValue("Ammunition", "DamageType") )
			
			self.LastHitPos = tr.HitPos
			if self:GetAttachmentValue("Ammunition", "NumShots") > 1 then self:DoEffects(mode, true, true) end
			
			if self:GetAttachmentValue("Ammunition", "SplashRadius") != nil then
				local dinfo = DamageInfo()
				dinfo:SetInflictor(self)
				dinfo:SetAttacker(ply)
				dinfo:SetDamageType( self:GetAttachmentValue("Ammunition", "DamageType") )
				
				for k,v in pairs(ents.FindInSphere(tr.HitPos, self:GetAttachmentValue("Ammunition", "SplashRadius"))) do
					if (v:IsValid() or !v:IsWorld()) && SERVER then
						local dinfo = DamageInfo()
						dinfo:SetInflictor(self)
						dinfo:SetAttacker(ply)
						dinfo:SetDamage( (bullet.Damage * self:GetAttachmentValue("Ammunition", "SplashDamageMul")) / (v:EyePos():DistToSqr(tr.HitPos) / 50) )
						if v:IsValid() then
							v:TakeDamageInfo(dinfo)
						end
					end
				end
			end

			if self:GetAttachmentValue("Ammunition", "ImpactDecal") != nil then
				util.Decal( self:GetAttachmentValue("Ammunition", "ImpactDecal"), tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal, {self, ply})
			end
			
			if self:GetAttachmentValue("Ammunition", "BurnDecal") != nil then
				util.Decal( self:GetAttachmentValue("Ammunition", "BurnDecal"), tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal, {self, ply})
			end
			
			self:DoCustomBulletImpact(tr.HitPos, tr.Normal, takedamageinfo)
		end
	end
	
	self:FireBullets(bullet)
end

function SWEP:CalculateSpread(isprojectile)
	if !IsValid(self) then return end
	if isprojectile == nil then isprojectile = false end
	local ply = self:GetOwner()
	local stats = self.StatsToPull
	local calc = ((stats.Spread * self:GetAttachmentValue("Ammunition", "Spread")) / (stats.SpreadDiv * self:GetAttachmentValue("Ammunition", "SpreadDiv")))
	
	if isprojectile == false then
		if ply:IsPlayer() then
			if GetConVar("sv_drc_callofdutyspread"):GetString() == "1" then
				if self.SightsDown == false then
					return Vector( calc, calc, 0 ) * self.BloomValue
				else
					return Vector( calc, calc, 0) * self.BloomValue
				end
			else
				return Vector( calc, calc, 0 ) * self.BloomValue
			end
		elseif ply:IsNPC() or ply:IsNextBot() then
			return Vector(calc, calc, calc)
		end
	else
		return Vector( calc, calc, 0 ) * self.BloomValue / 2 -- This isn't perfectly accurate to the spread cone but what the fuck ever, it's close enough.
	end
end

function SWEP:DoShoot(mode)
	local stats = self.StatsToPull
	local batstats = self.BatteryStats
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	local eyeang = ply:EyeAngles()
	local tr = nil
	if ply:IsNPC() && ply.Draconic == true then
		tr = ply:GetEyeTrace()
	else
		tr = util.GetPlayerTrace(ply)
	end
	local trace = util.TraceLine( tr )
	local LeftHand = ply:LookupBone("ValveBiped.Bip01_L_Hand")
	local RightHand = ply:LookupBone("ValveBiped.Bip01_R_Hand")
	
	local pmag = self:Clip1()
	local nmag = self:Clip1() - stats.APS
	
	if nmag <= 0 then
		self.PistolSlide = 0
	end
	
	local firetime = 0
	local fireseq = self:SelectWeightedSequence(ACT_VM_PRIMARYATTACK)
	local fireseq2 = self:SelectWeightedSequence(ACT_VM_SECONDARYATTACK)
	local fireseq3 = self:SelectWeightedSequence(ACT_SPECIAL_ATTACK1)
	if mode == "primary" then
		firetime = self:SequenceDuration(fireseq)
	elseif mode == "secondary" then
		firetime = self:SequenceDuration(fireseq2)
	elseif mode == "overcharge" then
		firetime = self:SequenceDuration(fireseq3)
	end
	self.IdleTimer = CurTime() + firetime
	
	local shotnum = self:GetAttachmentValue("Ammunition", "NumShots")
	if mode == "primary" then
		if ply:IsPlayer() then
			self:UpdateBloom("primary")
			if game.SinglePlayer() then self:CallOnClient( "UpdateBloom", "primary") end
		end
		
		if self.Base == "draconic_gun_base" then
			if stats != self.OCStats then
				self.Weapon:SetNWInt("LoadedAmmo", math.Clamp((self.Weapon:GetNWInt("LoadedAmmo") - stats.APS), 0, (self.Primary.ClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))))
			else
				self.Weapon:SetNWInt("LoadedAmmo", math.Clamp((self.Weapon:GetNWInt("LoadedAmmo") - stats.OCAPS), 0, (self.Primary.ClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))))
			end
			self:TakePrimaryAmmo( stats.APS )
		elseif self.Base == "draconic_battery_base" then
			if stats != self.OCStats then
				self.Weapon:SetNWInt("LoadedAmmo", math.Clamp((self.Weapon:GetNWInt("LoadedAmmo") - batstats.BatteryConsumPerShot), 0, self.Primary.ClipSize))
			else
				self.Weapon:SetNWInt("LoadedAmmo", math.Clamp((self.Weapon:GetNWInt("LoadedAmmo") - stats.APS), 0, self.Primary.ClipSize))
			end
			self:TakePrimaryAmmo( batstats.BatteryConsumPerShot )
		end
	elseif mode == "secondary" then
		if ply:IsPlayer() then
			self:UpdateBloom("secondary")
			if game.SinglePlayer() then self:CallOnClient( "UpdateBloom", "secondary") end
		end
		
		self:TakeSecondaryAmmo( stats.APS )
	elseif mode == "overcharge" then
		if ply:IsPlayer() then
			self:UpdateBloom("overcharge")
			if game.SinglePlayer() then self:CallOnClient( "UpdateBloom", "overcharge") end
		end
		
		self:SetNWInt("Charge", 0)
		shotnum = self:GetAttachmentValue("Ammunition", "NumShots_OC")
		
		if self.Base == "draconic_gun_base" then
			if stats != self.OCStats then
				self.Weapon:SetNWInt("LoadedAmmo", math.Clamp((self.Weapon:GetNWInt("LoadedAmmo") - stats.APS), 0, (self.Primary.ClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))))
			else
				self.Weapon:SetNWInt("LoadedAmmo", math.Clamp((self.Weapon:GetNWInt("LoadedAmmo") - stats.APS), 0, (self.Primary.ClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))))
			end
			self:TakePrimaryAmmo( stats.APS )
		elseif self.Base == "draconic_battery_base" then
			if stats != self.OCStats then
				self.Weapon:SetNWInt("LoadedAmmo", math.Clamp((self.Weapon:GetNWInt("LoadedAmmo") - batstats.BatteryConsumPerShot), 0, self.Primary.ClipSize))
			else
				self.Weapon:SetNWInt("LoadedAmmo", math.Clamp((self.Weapon:GetNWInt("LoadedAmmo") - stats.APS), 0, self.Primary.ClipSize))
			end
			self:TakePrimaryAmmo( batstats.BatteryConsumPerShot )
		end
	end
	
	if stats.HealthPerShot != 0 then
		local amount = stats.HealthPerShot
		local hp = ply:Health()
		local maxhp = ply:GetMaxHealth()
		local nexthp = hp - amount
		if hp > amount then
			ply:SetHealth(math.Clamp(hp - amount, 0, maxhp))
		else
			ply:Kill()
		end
	end
	
	if stats.ArmourPerShot != 0 then
		local amount = stats.ArmourPerShot
		local armour = ply:Armor()
		local maxarmour = GetConVar("sv_drc_maxrmour"):GetString()
		local nextarmour = armour - amount
		if armour > 0 then
			ply:SetArmor(math.Clamp(armour - amount, 0, maxarmour))
		end
	end
	
	if self.Loading == false && self.ManuallyReloading == false && ply:IsPlayer() then
		if self.SightsDown == true && self.Secondary.SightsSuppressAnim == true then else
			local vm = ply:GetViewModel()
			if mode == "primary" then
				vm:SendViewModelMatchingSequence(fireseq)
				self:SetCycle(0)
				self:ResetSequence(fireseq)
			elseif mode == "secondary" then
				vm:SendViewModelMatchingSequence(fireseq2)
				self:ResetSequence(fireseq2)
			elseif mode == "overcharge" then
				if fireseq3 == -1 then
					vm:SendViewModelMatchingSequence(fireseq)
					self:ResetSequence(fireseq)
				else
					vm:SendViewModelMatchingSequence(fireseq3)
					self:ResetSequence(fireseq3)
				end
			end
		end
		ply:SetAnimation( PLAYER_ATTACK1 ) 
	else end
	
	if self.Base == "draconic_battery_base" then
		local heat = self:GetNWInt("Heat")
		if stats != self.OCStats then
			self:SetNWInt("Heat", (self:GetNWInt("Heat") + batstats.HPS))
		else
			self:SetNWInt("Heat", (self:GetNWInt("Heat") + batstats.OCHPS))
		end
		
		if self.LowerRPMWithHeat == true then
			if heat > batstats.AlterThesholdMax then
				self:SetNextPrimaryFire( CurTime() + 60 / batstats.HeatRPMmin)
			elseif heat > batstats.AlterTheshold then
				local meth = Lerp((heat - batstats.AlterTheshold) / heat, (60 / stats.RPM), (60 / batstats.HeatRPMmin))
				self:SetNextPrimaryFire( CurTime() + meth )
			elseif heat < batstats.AlterTheshold then
				self:SetNextPrimaryFire( CurTime() + 60 / stats.RPM)
			end
		else
			self:SetNextPrimaryFire ( CurTime() + (60 / stats.RPM) )
		end
	else
		self:SetNextPrimaryFire( CurTime() + (60 / stats.RPM) )
	end
	
	if self.Primary.isvFire == true then
		self:ShootFire() 
	return end
	
	if stats.Projectile == nil then
		if CLIENT then self:CalculateSpread() end
		if ply:IsNextBot() then self:CalculateSpread() end
		if self.PreventAllBullets == true then return end
		if ply:IsPlayer() then ply:LagCompensation(true) end
		if self.PreventAllBullets == false then self:ShootBullet(stats.Damage, shotnum, self:CalculateSpread(), stats.Ammo, stats.Force, stats.Tracer) end
		if ply:IsPlayer() then ply:LagCompensation(false) end
	elseif mode == "secondary" && self.Projectile == "scripted" then
		timer.Simple(self.Secondary.ProjectileSpawnDelay, function()
			self:DoScriptedSecondaryAttack()
			self.Weapon:EmitSound(self.Secondary.Sound)
			ply:SetAnimation( PLAYER_ATTACK1 )
			self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
		end)
	else
		if SERVER then
			local muzzleattachment = self:LookupAttachment("muzzle")
			local muzzle = self.Weapon:GetAttachment(muzzleattachment)
			
			for i=1,shotnum do
				local proj = ents.Create(stats.Projectile)
				if !proj:IsValid() then return false end
				local SpreadCalc = self:CalculateSpread(true) * self.BloomValue
				local AmmoSpread = ((stats.Spread * self:GetAttachmentValue("Ammunition", "Spread")) / (stats.SpreadDiv * self:GetAttachmentValue("Ammunition", "SpreadDiv"))) * 1000 * self.BloomValue
				local projang = ply:GetAimVector():Angle() + Angle(math.Rand(SpreadCalc.x, -SpreadCalc.x) * AmmoSpread, math.Rand(SpreadCalc.y, -SpreadCalc.y) * AmmoSpread, 0) * self.BloomValue
				proj:SetAngles(projang)
				if ply:IsPlayer() && (self:ValveBipedCheck() == false or self.SightsDown == true) then
					if self.SightsDown == true && self.Secondary.Scoped == true then
						proj:SetPos( ply:EyePos() )
					else
						proj:SetPos( ply:EyePos() - Vector(0, 0, 15) + ply:GetAimVector() * Vector(25, 25, 25) )
					end
				elseif ply:IsNPC() or ply:IsNextBot() then
					if muzzle != nil then
						proj:SetPos(muzzle.Pos)
					else
						proj:SetPos( ply:EyePos() - Vector(0, 0, 15) + ply:GetAimVector() * Vector(25, 25, 25) )
					end
				else
					proj:SetPos( ply:GetBonePosition(RightHand))
				end
				proj:SetOwner(self.Owner)
				proj:Spawn()
				proj.Owner = self.Owner
				proj:Activate()
				
				if !self.PTable then self.PTable = {} end
				if proj.Draconic == true then table.insert(self.PTable, proj) end
				
				local phys = proj:GetPhysicsObject()
				local sped = phys:GetAngles():Forward() * (stats.ProjSpeed)
				if stats.ProjInheritVelocity == true then
					phys:SetVelocity(sped + ply:GetVelocity())
				else
					phys:SetVelocity(sped)
				end
			end
		end
	end
	
	local mini, maxi, delay, length = self:GetNPCBurstSettings()
	if ply:IsNPC() or ply:IsNextBot() then -- NPC Looping Firing sounds
		if mode != "primary" then return end
		if self.NPCBursting == true then return end
		local burst = math.Round(math.Rand(mini, maxi))
		
--		print("Min: ".. mini .." | Max: ".. maxi .." | Delay: ".. delay .." | Burst: ".. burst .."")
		
		if self.Primary.LoopingFireSound != nil then
			self:EmitSound(self.Primary.LoopingFireSoundIn)
			self.LoopFireSound:Play()
		end
		
		timer.Simple(length, function()
			if self.LoopFireSound != nil then
				self.LoopFireSound:Stop()
				self:EmitSound(self.Primary.LoopingFireSoundOut)
			end
		end)
		
		self.NPCBursting = true
		timer.Simple( burst * delay + math.Rand(0.3,3), function() if !IsValid(ply) or !IsValid(self) then return end self.NPCBursting = false end)
		
		for i=1,length do
			timer.Simple( delay*i, function()
				if !IsValid(ply) or !IsValid(self) then return end
				local fm = self:GetNWString("FireMode")
					if fm != "Burst" && ply:IsNPC() then
						local enemy = ply:GetEnemy()
						
						if enemy == nil then return end
						if IsValid(enemy) && CTFK(self.ignorepcs, enemy:GetClass()) then ply:SetEnemy(nil, true) end
						if IsValid(enemy) && ply:GetEnemyLastTimeSeen(enemy) > CurTime() then return end
						
						if IsValid(enemy) && !ply:IsLineOfSightClear(enemy:GetPos()) then return end
						
						if IsValid(enemy) then
							self:PrimaryAttack()
						end
					end
				self:CallShoot("primary")
			end)
		end
	end
	
	if ply:IsNPC() then
		timer.Simple( 0.5, function() -- holy fUCK LET ME DETECT WHEN AN NPC RELOADS IN LUA NATIVELY PLEASE
			if !IsValid(self) or !IsValid(ply) then return end
			if ply:GetActivity() == ACT_RELOAD then
				self:DoCustomReloadStartEvents()
				self.Weapon:SetNWInt("LoadedAmmo", (self.Primary.ClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul")))
			end
		end)
	end
	
	if ply:IsNextBot() then -- Iv04 Nextbot handling
		if ply.IV04NextBot != true then return end
		if self.NPCBursting == true then return end
		
		local rpm = self.Primary.RPM
		local fm = self.Weapon:GetNWString("FireMode")
	end
end

function SWEP:DoEffects(mode, nosound, multishot)
	local ply = self:GetOwner()
	local muzzleattachment = self:LookupAttachment("muzzle")
	local muzzle = self.Weapon:GetAttachment(muzzleattachment)
	local fm = self:GetNWString("FireMode")
		
		if mode == "primary" then
			self.vFire = self.Primary.isvFire
			self.Projectile = self.Primary.Projectile
			self.TracerEffect = self.Primary.TracerEffect
			
			if fm == "Semi" or fm == "Auto" then
				self.Sound = self.Primary.SoundTable.Semiauto.Near
				self.DistSound = self.Primary.SoundTable.Semiauto.Far
				self.SoundDistance = self.Primary.SoundTable.Semiauto.FarDistance
			else
				self.Sound = self.Primary.SoundTable.Burst.Near
				self.DistSound = self.Primary.SoundTable.Burst.Far
				self.SoundDistance = self.Primary.SoundTable.Burst.FarDistance
			end
			
			self.LastHitPos = self.LastHitPos
		elseif mode == "secondary" then
			self.vFire = self.Secondary.isvFire
			self.Sound = self.Secondary.Sound
			self.DistSound = self.Secondary.DistSound
			self.Projectile = self.Secondary.Projectile
			self.TracerEffect = self.Secondary.TracerEffect
			
			self.LastHitPos = self.LastHitPos
		elseif mode == "overcharge" then
			self.vFire = self.Primary.isvFire
			self.Sound = self.OCSound
			self.DistSound = self.OCDistSound
			self.Projectile = self.Primary.OCProjectile
			self.TracerEffect = self.Primary.TracerEffect
			
			self.LastHitPos = self.LastHitPos
		end
		
	
	local effectdata = EffectData()
	local muzzle = self:LookupAttachment("muzzle")
	
	if self.StatsToPull.Projectile == nil && self.vFire == false then
		if self.LastHitPos == nil then self.LastHitPos = Vector(0, 0, 0) end
		effectdata:SetOrigin( self.LastHitPos )
	--	DRC_ParticleExplosion(self.LastHitPos, self.StatsToPull.Force * 75, 10)
	else
		effectdata:SetOrigin( self.Owner:GetShootPos() )
	end



	if self.SightsDown == false then
		effectdata:SetAttachment( muzzle )
	elseif self.SightsDown == true && self.Secondary.Scoped == true then
		effectdata:SetStart( self.Owner:EyePos() + Vector(0, 0, -2) )
		effectdata:SetAttachment( -1 )
	end
		
	effectdata:SetEntity( self )
	if self.TracerEffect != nil && effectdata != nil then
		util.Effect( self.TracerEffect, effectdata )
	end
		
	if self.Primary.UsesCharge == true or self.Secondary.UsesCharge == true && self:CanOvercharge() then
		if self.OCTracerEffect != nil then util.Effect( self.OCTracerEffect, effectdata ) end
	end
	
	if not IsFirstTimePredicted() or nosound == true or self.BurstSound == true then return end
	if mode == "primary" && fm == "Burst" && self.Primary.SoundTable.Burst.Single == false then
		self.BurstSound = true
		timer.Simple(CurTime() - self:GetNextPrimaryFire() + 0.2, function() self.BurstSound = false end)
	end
	
	local roomsize = DRC:RoomSize(ply)
	local RoomType = DRC:GetRoomSizeName(roomsize)
--	print("1", RoomType)
	
	if RoomType == "Valley" && !self.Primary.SoundTable.Envs["Valley"] then RoomType = "Outdoors" end
	if RoomType == "Outdoors" && !self.Primary.SoundTable.Envs["Outdoors"] then RoomType = "Large" end
	if RoomType == "Vent" && !self.Primary.SoundTable.Envs["Vent"] then RoomType = "Small" end
--	print("2", RoomType)
	
	if mode == "primary" && self.Primary.SoundTable.Envs[RoomType] then
		if fm == "Semi" or fm == "Auto" then
			self.Sound = self.Primary.SoundTable.Envs[RoomType].Semiauto.Near
			self.DistSound = self.Primary.SoundTable.Envs[RoomType].Semiauto.Far
		else
			self.Sound = self.Primary.SoundTable.Envs[RoomType].Burst.Near
			self.DistSound = self.Primary.SoundTable.Envs[RoomType].Burst.Far
		end
	end
	--print(self.Sound)
	
--	self:EmitSound(self.Sound)
	DRC:EmitSound(self, self.Sound, self.DistSound, self.SoundDistance, listener)
	
--	if GetConVar("cl_drc_debugmode"):GetFloat() > 0 then
--		if GetConVar("cl_drc_debug_invertnearfar"):GetFloat() < 1 then
end

function SWEP:DoMuzzleLight(mode)
	local ply = self:GetOwner()
	local muzzleattachment = self:LookupAttachment("muzzle")
	local muzzle = self.Weapon:GetAttachment(muzzleattachment)
		
		if mode == "primary" then
			self.FlareLightColor = self.Primary.LightColor
			self.FlareBrightness = self.Primary.LightBrightness
			self.FlareDecay = self.Primary.LightDecayTime
			self.FlareSize = self.Primary.LightSize
		elseif mode == "secondary" then
			self.FlareLightColor = self.Secondary.LightColor
			self.FlareBrightness = self.Secondary.LightBrightness
			self.FlareDecay = self.Secondary.LightDecayTime
			self.FlareSize = self.Secondary.LightSize
		elseif mode == "overcharge" then
			self.FlareLightColor = self.OCLightColor
			self.FlareBrightness = self.OCLightBrightness
			self.FlareDecay = self.OCLightDecayTime
			self.FlareSize = self.OCLightSize
		end
	
	if !SERVER then
		local dl = DynamicLight(self:EntIndex(), false)
		if (dl) then
			if muzzle == nil then
				dl.Pos = ply:GetShootPos()
			else
				dl.Pos = muzzle.Pos
			end
			dl.r = self.FlareLightColor.r
			dl.g = self.FlareLightColor.g
			dl.b = self.FlareLightColor.b
			dl.Brightness = self.FlareBrightness
			dl.Size = self.FlareSize
			dl.Decay = self.FlareDecay
			dl.DieTime = CurTime() + self.FlareDecay / 100
			dl.Style = 0
		end
		
		local el = DynamicLight(self:EntIndex(), true)
		if (el) then
			if muzzle == nil then
				el.Pos = ply:GetShootPos()
			else
				el.Pos = muzzle.Pos
			end
			el.r = self.FlareLightColor.r
			el.g = self.FlareLightColor.g
			el.b = self.FlareLightColor.b
			el.Brightness = self.FlareBrightness * 5
			el.Size = self.FlareSize
			el.Decay = self.FlareDecay
			el.DieTime = CurTime() + self.FlareDecay / 100
			el.Style = 0
		end
	end
end

function SWEP:DoRecoil(mode)
	if !game.SinglePlayer() && !IsFirstTimePredicted() then return end
	local ply = self:GetOwner()
	local eyeang = ply:EyeAngles()
	local cv = ply:Crouching()
	local sk = ply:KeyDown(IN_SPEED)
	local mk = (ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK))
	local plidle = (!mk && !sk && !cv)
	local issprinting = sk && mk

	if mode == "primary" then
		self.RecoilDown = (self.Primary.RecoilDown * self:GetAttachmentValue("Ammunition", "RecoilDown"))
		self.RecoilUp = (self.Primary.RecoilUp * self:GetAttachmentValue("Ammunition", "RecoilUp"))
		self.RecoilHoriz = (self.Primary.RecoilHoriz * self:GetAttachmentValue("Ammunition", "RecoilHoriz"))
		self.Kick = (self.Primary.Kick * self:GetAttachmentValue("Ammunition", "Kick"))
		self.KickHoriz = (self.Primary.KickHoriz * self:GetAttachmentValue("Ammunition", "KickHoriz"))
		self.IronRecoilMul = (self.Primary.IronRecoilMul * self:GetAttachmentValue("Ammunition", "IronRecoilMul"))
	elseif mode == "secondary" then
		self.RecoilDown = (self.Secondary.RecoilDown * self:GetAttachmentValue("Ammunition", "RecoilDown"))
		self.RecoilUp = (self.Secondary.RecoilUp * self:GetAttachmentValue("Ammunition", "RecoilUp"))
		self.RecoilHoriz = (self.Secondary.RecoilHoriz * self:GetAttachmentValue("Ammunition", "RecoilHoriz"))
		self.Kick = (self.Secondary.Kick * self:GetAttachmentValue("Ammunition", "Kick"))
		self.KickHoriz = (self.Secondary.KickHoriz * self:GetAttachmentValue("Ammunition", "KickHoriz"))
		self.IronRecoilMul = (self.Secondary.IronRecoilMul * self:GetAttachmentValue("Ammunition", "IronRecoilMul"))
	elseif mode == "overcharge" then
		self.RecoilDown = (self.OCRecoilDown * self:GetAttachmentValue("Ammunition", "RecoilDown"))
		self.RecoilUp = (self.OCRecoilUp * self:GetAttachmentValue("Ammunition", "RecoilUp"))
		self.RecoilHoriz = (self.OCRecoilHoriz * self:GetAttachmentValue("Ammunition", "RecoilHoriz"))
		self.Kick = (self.OCKick * self:GetAttachmentValue("Ammunition", "Kick"))
		self.KickHoriz = (self.OCKickHoriz * self:GetAttachmentValue("Ammunition", "KickHoriz"))
		self.IronRecoilMul = (self.OCIronRecoilMul * self:GetAttachmentValue("Ammunition", "IronRecoilMul"))
	end
		
	--if self.Weapon:GetNWBool("ironsights") == false && cv == false then
	if self.SightsDown == false && cv == false then
		if CLIENT then
			eyeang.pitch = eyeang.pitch - ((math.Rand(self.RecoilUp / 1.85, self.RecoilUp * 1.62)) - (math.Rand(self.RecoilDown / 1.85, self.RecoilDown * 1.85) * 0.01))
			eyeang.yaw = eyeang.yaw - (math.Rand( self.RecoilHoriz, (self.RecoilHoriz * -0.81) ) * 0.01)
		end
		self.Owner:ViewPunch(Angle( -self.Kick, math.Rand(-self.KickHoriz, self.KickHoriz), math.Rand(-self.KickHoriz, self.KickHoriz) / 200 ))
		--elseif self.Weapon:GetNWBool("ironsights") == true && cv == false then
		elseif self.SightsDown == true && cv == false then
		if CLIENT then
			eyeang.pitch = eyeang.pitch - (((math.Rand(self.RecoilUp / 1.5, self.RecoilUp * 1.5)) - (math.Rand(self.RecoilDown / 1.5, self.RecoilDown * 1.5) * 0.01)) * self.IronRecoilMul)
			eyeang.yaw = eyeang.yaw - (math.Rand( self.RecoilHoriz, (self.RecoilHoriz * -1) ) * 0.01)
		end
		self.Owner:ViewPunch(Angle( (-self.Kick * 0.69) * self.IronRecoilMul, math.Rand(-self.KickHoriz, self.KickHoriz) / 100, math.Rand(-self.KickHoriz, self.KickHoriz) / 250 ) * self.Secondary.SightsKickMul)
	--elseif self.Weapon:GetNWBool("ironsights") == false && cv == true then
	elseif self.SightsDown == false && cv == true then
		if CLIENT then
			eyeang.pitch = eyeang.pitch - ((math.Rand(self.RecoilUp / 1.5, self.RecoilUp * 1.5)) - (math.Rand(self.RecoilDown / 1.5, self.RecoilDown * 1.5) * 0.01))
			eyeang.yaw = eyeang.yaw - (math.Rand( self.RecoilHoriz, (self.RecoilHoriz * -1) ) * 0.01)
		end
		self.Owner:ViewPunch(Angle( -self.Kick * 0.75, math.Rand(-self.KickHoriz, self.KickHoriz) / 100, math.Rand(-self.KickHoriz, self.KickHoriz) / 250 ))
		--elseif self.Weapon:GetNWBool("ironsights") == true && cv == true then
		elseif self.SightsDown == true && cv == true then
		if CLIENT then
			eyeang.pitch = eyeang.pitch - (((math.Rand(self.RecoilUp / 1.5, self.RecoilUp * 0.9)) - (math.Rand(self.RecoilDown / 1.9, self.RecoilDown * 0.9) * 0.01)) * self.IronRecoilMul)
			eyeang.yaw = eyeang.yaw - (math.Rand( self.RecoilHoriz, (self.RecoilHoriz * -1) ) * 0.01)
		end
		self.Owner:ViewPunch(Angle( (-self.Kick * 0.42) * self.IronRecoilMul, math.Rand(-self.KickHoriz, self.KickHoriz) / 200, math.Rand(-self.KickHoriz, self.KickHoriz) / 500 ))
	end
	
	if CLIENT then ply:SetEyeAngles(Angle(0, 0, 0) + Angle(eyeang.pitch, eyeang.yaw, nil)) end
end

function SWEP:CallShoot(mode, ignoreimpossibility) -- This function acts more as a "sequence of triggers" to cause a myriad of functions / effects, but splits to multiple functions for SWEP authors to be able to call any of them independently.	
	local ply = self:GetOwner()
	if ignoreimpossibility == nil then ignoreimpossibility = false end
	
	if mode == "primary" then
		if ply:IsPlayer() then
			if ignoreimpossibility != true && !self:CanPrimaryAttack() then return end
		end
		if ply:IsNPC() then
			if ignoreimpossibility != true && !self:CanPrimaryAttackNPC() then return end
		end
		
		if ignoreimpossibility && self:GetNWString("FireMode") == "Burst" then
			if (self.DoesPassiveSprint == true or GetConVar("sv_drc_force_sprint"):GetString() == "1") && (ply:KeyDown(IN_SPEED) && (ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK) or ply:KeyDown(IN_LEFT) or ply:KeyDown(IN_RIGHT))) then return end
			if self:GetNWInt("LoadedAmmo") <= 0 then
				if CurTime() > self:GetNextPrimaryFire() then self:EmitSound (self.Primary.EmptySound) end
				self:SetNextPrimaryFire(CurTime() + (60/self.Primary.RPM * 2)) return
			elseif self:GetNWBool("Passive") == true or self:GetNWBool("Inspecting") == true then
			return end
		end
		
		self.StatsToPull = self.PrimaryStats
		self:DoShoot("primary")
		self:DoEffects("primary")
		self:ShootEffects()
		--self:CallOnClient("DoEffects", "primary")
		if ply:IsPlayer() then
			if game.SinglePlayer() then
				self:CallOnClient("DoRecoil", "primary")
				self:DoRecoil("primary")
			else
				self:DoRecoil("primary")
			end
		end
		
		if IsValid(self) && self:GetNWInt("LoadedAmmo") > 0 then self:DoCustomPrimaryAttackEvents() end
	elseif mode == "secondary" then
		if ignoreimpossibility != true && !self:CanSecondaryAttack() then return end
		self.StatsToPull = self.SecondaryStats
		self:DoShoot("secondary")
		self:DoEffects("secondary")
		
		if ply:IsPlayer() then self:DoRecoil("secondary") end
		
		if IsValid(self) && self:GetNWInt("LoadedAmmo") > 0 then self:DoCustomSecondaryAttackEvents() end
	elseif mode == "overcharge" then
		if ply:IsPlayer() then
			if ignoreimpossibility != true && !self:CanPrimaryAttack() then return end
		else
			if ignoreimpossibility != true && !self:CanPrimaryAttackNPC() then return end
		end
		self.StatsToPull = self.OCStats
		self:DoShoot("overcharge")
		self:DoEffects("overcharge")
		
		if ply:IsPlayer() then self:DoRecoil("overcharge") end
		if IsValid(self) && self:GetNWInt("LoadedAmmo") > 0 then self:DoCustomOverchargeAttackEvents() end
	end
end

function SWEP:GetMovementValues()
	if GetConVar("sv_drc_movement"):GetString() == "0" then return end
	local ply = self:GetOwner()
	local ogs = ply:GetRunSpeed()
	local ogw = ply:GetWalkSpeed()
	local ogj = ply:GetJumpPower()
	local ogc = ply:GetCrouchedWalkSpeed()
		
	if ogs == nil or ogs == 0 then return end
	if ogw == nil or ogw == 0 then return end
	if ogj == nil or ogj == 0 then return end
	if ogc == nil or ogc == 0 then return end
	
	ply:SetNWFloat( "PlayerOGSpeed", ply:GetRunSpeed() )
	ply:SetNWFloat( "PlayerOGWalk", ply:GetWalkSpeed() )
	ply:SetNWFloat( "PlayerOGJump", ply:GetJumpPower() )
	ply:SetNWFloat( "PlayerOGCrouch", ply:GetCrouchedWalkSpeed() )
end

function SWEP:ValveBipedCheck()
	local ply = self:GetOwner()
	local LeftHand = ply:LookupBone("ValveBiped.Bip01_L_Hand")
	local RightHand = ply:LookupBone("ValveBiped.Bip01_R_Hand")
	local Spine1 = ply:LookupBone("ValveBiped.Bip01_Spine1")
	local Spine2 = ply:LookupBone("ValveBiped.Bip01_Spine2")
	local Spine4 = ply:LookupBone("ValveBiped.Bip01_Spine4")
	local LeftClav = ply:LookupBone("ValveBiped.Bip01_L_Clavicle")
	local RightClav = ply:LookupBone("ValveBiped.Bip01_R_Clavicle")
	local LeftThigh = ply:LookupBone("ValveBiped.Bip01_L_Thigh")
	local RightThigh = ply:LookupBone("ValveBiped.Bip01_R_Thigh")
	
	if !LeftHand or !RightHand or !Spine1 or !Spine2 or !Spine4 or !LeftClav or !RightClav or !LeftThigh or !RightThigh then return false else return true end
end

function SWEP:DoCustomMeleeImpact(att, tr)
end

function SWEP:GetAttachmentValue(att, val)
	local AA = self.ActiveAttachments
	local base = scripted_ents.GetStored("drc_att_bprofile_generic")
	local BT = base.t.BulletTable
	local tab = nil
	
	if att == "Ammunition" then
		tab = AA.Ammunition.t.BulletTable
		
		local foundval = tab[val]
		if foundval == nil then
			foundval = base.t.BulletTable[val]
			if GetConVar("cl_drc_debugmode"):GetFloat() > 1 && foundval != nil then print("Failed to find value (".. tostring(att) .." - " .. tostring(val) .."), pulling base instead: ".. foundval .."") end
		else
			if GetConVar("cl_drc_debugmode"):GetFloat() > 1 then print("Found value (".. tostring(att) .." - " .. tostring(val) .."): ".. foundval .."") end
		end
		return foundval
	end
end

function SWEP:DoCustomOverchargeAttackEvents()
end