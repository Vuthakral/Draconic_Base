AddCSLuaFile()

--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName 	= "Base Pickup Entity"
ENT.Author 		= "Vuthakral"
ENT.Information = ""
ENT.Category 	= "Draconic"

ENT.Spawnable = false
ENT.AdminOnly = false

ENT.Model = "models/items/ammocrate_smg1.mdl"

ENT.UseDelay = 0
ENT.ATR 	= 0
ENT.HidePopup = false
ENT.RemoveOnUse = false
ENT.PickupType 	= "ammostation"
ENT.UseType		= "simple"
ENT.UseSound = ""
ENT.DenySound = ""

ENT.Whitelist = nil
ENT.WhitelistIsBlack = false

ENT.RequiredEnt	= nil
ENT.RequiredEntRange = 50

ENT.Destroyable	= false
ENT.SpawnHealth	= 100
ENT.BreakEffect	= ""
ENT.BreakSound	= ""
ENT.DamageDelay	= 0
ENT.ExplodeLight = false
ENT.ExplodeLightColor = Color(255, 255, 255, 255)
ENT.ExplodeLightType = 0
ENT.ExplodeLightSize = 250
ENT.ExplodeLightDecay = 250
ENT.ExplodeLightBrightness = 0.1
ENT.ExplodeLightLifeTime = 3

ENT.ExplodeDamage 	= 0
ENT.ExplodePressure	= 0
ENT.DamageType		= DMG_GENERIC
ENT.AffectRadius	= 150

-- The "DO NOT TOUCH" zone.
ENT.CD 			= false
ENT.Draconic 	= true
ENT.Dead		= false
ENT.LastInflictor = nil
ENT.Powered		= true

function ENT:Initialize()
	self:DoCustomInitialize()

	if SERVER then
		self:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysWake()
	
		if self.UseType == "simple" then self:SetUseType(SIMPLE_USE)
		elseif self.UseType == "continuous" then self:SetUseType(CONTINUOUS_USE) end
	else end

	if self.Destroyable == true then
		self:SetHealth(self.SpawnHealth)
	end
end

function ENT:OnTakeDamage(dmginfo)
	if not SERVER then return end
	if dmginfo:GetAttacker():IsWorld() then return end
	self.DamageTaken = dmginfo:GetDamage()
	self.LastInflictor = dmginfo:GetAttacker()
	local dg = dmginfo
	timer.Simple(self.DamageDelay, function(dg)
		if not self:IsValid() then return end
		self:SetHealth(self:Health() - self.DamageTaken)
	--	self.LastInflictor:ChatPrint("".. dmginfo:GetDamage() .." - ".. self:Health() .." left")
	end)
end

ENT.PhysDamageCD = 0
function ENT:PhysicsCollide(data, col)
	
	if self.Destroyable == true then
		if CurTime() > self.PhysDamageCD then
		--	print("Speed: ", data.Speed)
			self.PhysDamageCD = CurTime() + 0.5
			
			local damage = data.Speed / 20
			damage = math.Round(math.pow(damage, data.Speed / 1000))
			if damage < 3 then damage = 0 end
		--	print("Damage:", damage)
		--	print("Health Remain:", self:Health())
			if damage > 25 or (self:Health() - damage <= 0) then
				self:EmitSound("MetalGrate.ImpactHard")
			elseif damage < 25 && damage > 2 then
				self:EmitSound("MetalGrate.ImpactSoft")
			end
			
			self:TakeDamage(damage, col:GetEntity(), col)
		end
	end
end

function ENT:DoCustomBreak()
end

function ENT:LuaExplode(effe, damage, dt, ep, radius, shake, shakedist, shaketime)
	if not self:IsValid() then return end

	local pos = self:GetPos()
	local phys = self:GetPhysicsObject()
	local owner = self:GetOwner()
	
	DRCSound(self, self.BreakSound, nil, 1500)
	
	if self.LastInflictor == nil then
		self.Killer = self
	else
		self.Killer = self.LastInflictor
	end

	for f, v in pairs(ents.FindInSphere(pos, radius)) do
		if not self:IsValid() then return end
		if pos == nil then return end
		if radius == nil then return end
	
		local dmg2 = DamageInfo()
		dmg2:SetDamage(damage / (v:GetPos()):Distance(pos) * 20)
		dmg2:SetInflictor(self)
		dmg2:SetDamageForce(self:EyeAngles():Forward())
		dmg2:SetDamagePosition(self:GetPos())
		dmg2:SetDamageType(dt)
		if !IsValid(self.Killer) then self.Killer = self end
		dmg2:SetAttacker(self.Killer)
	
		if v:GetClass() == self:GetClass() then
			if !IsValid(v:GetPhysicsObject()) then return end
			if v:EntIndex() != self:EntIndex() then v:GetPhysicsObject():SetVelocity((v:GetPos()-pos)*ep/(v:GetPos()):Distance(pos) * 100) end
			if SERVER then v:TakeDamageInfo(dmg2) end
		else
			if IsValid(v:GetPhysicsObject()) and !(v:IsPlayer() or v:IsNPC() or v:IsNextBot()) then
				v:GetPhysicsObject():SetVelocity((v:GetPos()-pos)*ep/(v:GetPos()):Distance(pos) * 100)
			elseif v:IsPlayer() or v:IsNPC() or v:IsNextBot() then
				v:SetVelocity((v:OBBCenter()-pos)*ep/(v:OBBCenter()):Distance(pos) * 50)
			end
			if SERVER then v:TakeDamageInfo(dmg2) end
		end
	end

--	util.ScreenShake( Vector( self:GetPos() ), (shake / 2), shake, shaketime, shakedist )
		
	if self:IsValid() then
		if effe != nil then
			local ed3 = EffectData()
			ed3:SetOrigin(pos)
			util.Effect(effe, ed3)
			DRC:ParticleExplosion(self, ep * 30, ep * 20)
		end
	end
		
	if self.LoopingSound != nil then
		if self:IsValid() then
			self:StopSound(self.LoopingSound)
		end
	end

	self:DoCustomBreak()
end

function ENT:Think()
	if self.Destroyable == true then
		if self.Dead == false && self:Health() <= 0 then
			self.Dead = true
			self:LuaExplode(self.BreakEffect, self.ExplodeDamage, self.DamageType, self.ExplodePressure, self.AffectRadius)
			
			if CLIENT && self.ExplodeLight != false then
				local dlight = DynamicLight(self:EntIndex())
				if (dlight) then
					dlight.Pos 			= self:GetPos()
					dlight.Size 		= self.ExplodeLightSize
					dlight.Brightness 	= self.ExplodeLightBrightness
					dlight.Style		= self.ExplodeLightType
					dlight.r 			= self.ExplodeLightColor.r
					dlight.g 			= self.ExplodeLightColor.g
					dlight.b 			= self.ExplodeLightColor.b
					dlight.Decay 		= self.ExplodeLightDecay
					dlight.DieTime 		= CurTime() + self.ExplodeLightLifeTime
				end
			end
		end
	end
end

function ENT:GetRequiredEnt()
	local EntsInRange = ents.FindByClass( self.RequiredEnt )
		if table.IsEmpty(EntsInRange) then return false end
	for k,v in ipairs(EntsInRange) do
		local pos = self:GetPos()
		local epos = v:GetPos()
		
		local dist =  pos:Distance(epos)
		
		if dist < self.RequiredEntRange then 
			self.RequiredEntInRange = true
		else
			self.RequiredEntInRange = false
		end
	end
	
	if self.RequiredEntInRange == true then return true else return false end
end

function ENT:Use(_, ply)
	local curswep = ply:GetActiveWeapon()
	if not IsValid(curswep) then return end
	
	self:DoCustomUse(ply, curswep)
		
	if self.RequiredEnt != nil && self.PickupType != "stationrequirement" then
	self.Powered = false
		if self:GetRequiredEnt() == true then
			self.Powered = true
		else
			self.Powered = false
		end
	end
		
	if self.Powered == false then
	return end
if self.CD == true then
	self:EmitSound(self.DenySound)
else
	if self.Whitelist != nil then
		if self.WhitelistIsBlack == false then
			if table.HasValue(self.Whitelist, curswep:GetClass()) then
				self:GiveAmmo(ply)
			else self:EmitSound(self.DenySound) end
		else
			if table.HasValue(self.Whitelist, curswep:GetClass()) then
				self:EmitSound(self.DenySound)
			else self:GiveAmmo(ply) end
		end
	else self:GiveAmmo(ply) end
end
end

function ENT:GiveAmmo(ply)
	local curswep = ply:GetActiveWeapon()
	if not IsValid(curswep) then return end

	if self.PickupType == "universalstation" then
		if curswep.Base == "draconic_gun_base" then
			self:EmitSound(self.UseSound)
			if self.ATR == 0 then
				ply:GiveAmmo(curswep:GetMaxClip1(), curswep:GetPrimaryAmmoType(), self.HidePopup)
				if self.UseDelay > 0 then
					self.CD = true
					timer.Simple(self.UseDelay, function() self.CD = false end)
				end
			else 
				ply:GiveAmmo(self.ATR, curswep:GetPrimaryAmmoType(), self.HidePopup)
				if self.UseDelay > 0 then
					self.CD = true
					timer.Simple(self.UseDelay, function() self.CD = false end)
				end
			end
			if self.RemoveOnUse == true then
				self:Remove()
			end
		elseif curswep.Base == "draconic_battery_base" then
			self:EmitSound(self.UseSound)
			curswep.Weapon:SetNWInt("LoadedAmmo", 100)
			curswep:SetClip1(100)
			if self.UseDelay > 0 then
				self.CD = true
				timer.Simple(self.UseDelay, function() self.CD = false end)
			end
			if self.RemoveOnUse == true then
				self:Remove()
			end
		elseif curswep.Base == "draconic_melee_base" then
			if curswep.InfoName == nil then
				ply:ChatPrint("I don't think my ".. curswep.PrintName .." uses bullets...")
			else
				ply:ChatPrint("I don't think my ".. curswep.InfoName .." uses bullets...")
			end
		else
			ply:ChatPrint("This ammo station only works with Draconic SWEPs!")
		end
	elseif self.PickupType == "ammostation" then
		if curswep.Base == "draconic_gun_base" then
			self:EmitSound(self.UseSound)
			if self.ATR == 0 then
				ply:GiveAmmo(curswep:GetMaxClip1(), curswep:GetPrimaryAmmoType(), self.HidePopup)
				if self.UseDelay > 0 then
					self.CD = true
					timer.Simple(self.UseDelay, function() self.CD = false end)
				end
			else 
				ply:GiveAmmo(self.ATR, curswep:GetPrimaryAmmoType(), self.HidePopup)
				if self.UseDelay > 0 then
					self.CD = true
					timer.Simple(self.UseDelay, function() self.CD = false end)
				end
			end
			if self.RemoveOnUse == true then
				self:Remove()
			end
		elseif curswep.Base == "draconic_battery_base" then
			self:EmitSound(self.DenySound)
		elseif curswep.Base == "draconic_melee_base" then
			if curswep.InfoName == nil then
				ply:ChatPrint("I don't think my ".. curswep.PrintName .." uses bullets...")
			else
				ply:ChatPrint("I don't think my ".. curswep.InfoName .." uses bullets...")
			end
		else
			ply:ChatPrint("This ammo station only works with Draconic SWEPs!")
		end
	elseif self.PickupType == "batterystation" then
		if curswep.Base == "draconic_gun_base" then
			self:EmitSound(self.DenySound)
		elseif curswep.Base == "draconic_battery_base" then
			if curswep.Weapon:GetNWInt("LoadedAmmo") < 100 then
				self:EmitSound(self.UseSound)
				curswep.Weapon:SetNWInt("LoadedAmmo", 100)
				curswep:SetClip1(100)
				if self.UseDelay > 0 then
					self.CD = true
					timer.Simple(self.UseDelay, function() self.CD = false end)
				end
				if self.RemoveOnUse == true then
					self:Remove()
				end
			else
				self:EmitSound(self.DenySound)
			end
		elseif curswep.Base == "draconic_melee_base" then
			if curswep.InfoName == nil then
				ply:ChatPrint("I don't think I should shove my ".. curswep.PrintName .." into this...")
			else
				ply:ChatPrint("I don't think I should shove my ".. curswep.InfoName .." into this...")
			end
		else
			ply:ChatPrint("This ammo station only works with Draconic SWEPs!")
		end
	elseif self.PickupType == "stationrequirement" then
	end
end

function ENT:DoCustomUse(ply, curswep)
end

function ENT:DoCustomInitialize()
end