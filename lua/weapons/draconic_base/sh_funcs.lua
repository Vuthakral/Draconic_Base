AddCSLuaFile()

SWEP.ChargeValue = 0
function SWEP:GetCharge()
	return self.ChargeValue
end

function SWEP:SetCharge(val)
	self.ChargeValue = val
end

function SWEP:AddCharge(val)
	self.ChargeValue = math.Clamp(self:GetCharge() + val, 0, 100)
end

function SWEP:SubCharge(val)
	self.ChargeValue = math.Clamp(self:GetCharge() - val, 0, 100)
end

SWEP.HeatValue = 0
function SWEP:GetHeat()
	return self:GetNWFloat("Heat")
end

function SWEP:SetHeat(val)
	self.HeatValue = val
	if SERVER then self:SetNWFloat("Heat", val) end
	local ply = self:GetOwner()
	if IsValid(ply) then
		if ply:IsPlayer() then
			ply:SetAmmo(val, "ammo_drc_battery")
		end
	end
end

function SWEP:AddHeat(val)
	local meth = math.Clamp(self:GetHeat() + val, 0, 100)
	self.HeatValue = meth
	if SERVER then self:SetNWFloat("Heat", meth) end
	if IsValid(ply) then
		if ply:IsPlayer() then
			ply:SetAmmo(val, "ammo_drc_battery")
		end
	end
end

function SWEP:SubHeat(val)
	local meth = math.Clamp(self:GetHeat() - val, 0, 100)
	self.HeatValue = meth
	if SERVER then self:SetNWFloat("Heat", meth) end
	if IsValid(ply) then
		if ply:IsPlayer() then
			ply:SetAmmo(val, "ammo_drc_battery")
		end
	end
end




function SWEP:CanCustomize()
	if self.IsMelee == true then return false end
	if GetConVar("sv_drc_attachments_disallowmodification"):GetFloat() == 1 then return false end
	if self:GetNWBool("Inspecting", false) == false then return false end
	
	local cando = true
	for k,v in pairs(self.AttachmentTable) do
		if k != "BaseClass" then
			if #v <= 1 then cando = false end
		end
	end
	return cando
end

function SWEP:ToggleInspectMode()
	local ply = self:GetOwner()
	
	if GetConVar("sv_drc_inspections"):GetString() == "0" then return end
	
	if self:GetNWBool("Inspecting") == false then
		self.Inspecting = true
		self:DoPassiveHoldtype()
		self:SetNWBool("Inspecting", true)
		if self:GetNWBool("ironsights") == true then 
			ply:SetFOV(0, self.Secondary.ScopeZoomTime)
			self:SetNWBool("ironsights", false)
		else end
		ply:EmitSound("draconic.IronOutGeneric")
		if self:GetNWBool("Passive") == true then
			self:TogglePassive()
		end
	else
		self.Idle = 0
		self:SetHoldType(self.HoldType)
		self.Inspecting = false
		self:SetNWBool("Inspecting", false)
		ply:EmitSound("draconic.IronInGeneric")
		timer.Simple(0.42, function()
			self.Inspecting = false 
			self.Idle = 1
		end)
	end
end

function SWEP:IsIdle()
	if self.Loading != true && self.ManuallyReloading != true && self.Inspecting != true && self.IsOverheated == false && self.IsDoingMelee != true then return true else return false end
end

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

--[[
function SWEP:RegeneratingAmmo(self)
	local ply = self:GetOwner()
	if not ply:IsPlayer() then return end
	local ammo, maxammo
	if self.RegenAmmo == false or self.RegenAmmo == nil then return end

	self.AmmoRegen = "AmmoRegen_".. ply:Name()
	
		timer.Create(self.AmmoRegen, self.AmmoInterval, 0, function() 
			if !SERVER or !self:IsValid()  or !timer.Exists( self.AmmoRegen ) then return end
			
			ammo = self:Clip1()
			maxammo = (self.Primary.ClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))
			if maxammo < ammo then return end
			if self.Loading == false then
				self:SetLoadedAmmo(math.Clamp( ammo + self.AmmoRegenAmount, 0, maxammo ))
				self:SetClip1(self:GetNWInt("LoadedAmmo"))
			end
		end)
end ]]

function SWEP:RegeneratingAmmo(wpn, delay, amount)
	if !wpn.AmmoCheck then wpn.AmmoCheck = 0 end
	if CurTime() > wpn.AmmoCheck then
		wpn.AmmoCheck = CurTime() + self.RegenAmmo_Interval
		local ammo = wpn:GetLoadedAmmo()
		if ammo > wpn:GetMaxClip1()+1 then
			wpn:SetLoadedAmmo(ammo - 1)
		elseif ammo < wpn:GetMaxClip1() then
			if CurTime() > wpn:GetNextPrimaryFire() + delay then
				wpn:SetLoadedAmmo(math.Clamp(ammo + 1, 0, wpn:GetMaxClip1()))
			end
		end
	end
end

function SWEP:DisperseHeat()
	local ply = self:GetOwner()
	if not ply:IsPlayer() then return end
	local CurHeat = self:GetHeat()

	self.HeatDisperseTimer = "HeatDisperseTimer_".. ply:Name()
	
	if self.DisperseHeatPassively == true then
	timer.Create(self.HeatDisperseTimer, self.HeatLossInterval, 0, function() 
		if !SERVER or !self:IsValid()  or !timer.Exists( self.HeatDisperseTimer ) then return end
		if self:GetHeat() == 0 then return end
		
		CurHeat = self:GetHeat()
		if ply:GetAmmoCount( "ammo_drc_battery" ) >= 101 then
			self:SetHeat(100)
			ply:SetAmmo(self:GetHeat(), "ammo_drc_battery")
		elseif ply:GetAmmoCount( "ammo_drc_battery" ) >= 0 then
			if self:GetNWFloat("HeatDispersePower") == 0 then
			else
				self:SetHeat(math.Clamp( (self:GetHeat() - (self.HeatLossPerInterval * self:GetNWFloat("HeatDispersePower"))), 0, 100), self.Primary.Ammo )
				ply:SetAmmo(self:GetHeat(), "ammo_drc_battery" )
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
		if !IsValid(ply) then return end
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
		
		if self:GetNWInt("LoadedAmmo") >= 0 then
			if self.Primary.UsesCharge == true then
				if m1d && self:CanPrimaryAttack() && (self:GetNWBool("Passive") == false && self.ManuallyReloading == false) && !ukd then self.ChargeValue = math.Clamp( self:GetCharge() + self.ChargeRate, 0, 100)
				else self.ChargeValue = math.Clamp( self:GetCharge() - self.ChargeRate * 10, 0, 100) end
			else end
			
			if self.Secondary.UsesCharge == true then
				if m2d && self:CanSecondaryAttack() && (self:GetNWBool("Passive") == false && self.ManuallyReloading == false) && !ukd then self.ChargeValue = math.Clamp( self:GetCharge() + self.ChargeRate, 0, 100)
				else self.ChargeValue = math.Clamp( self:GetCharge() - self.ChargeRate * 10, 0, 100) end
			else end
			
			if self:GetCharge() >= 101 then
				self.ChargeValue = 100
			end
			
			if self:GetCharge() > 99 then
				self:SetLoadedAmmo(self:GetNWInt("LoadedAmmo") - self.ChargeHoldDrain)
				self:SetClip1( self:GetNWInt("LoadedAmmo") )
			end
		else end
	end)
end

function SWEP:CanOvercharge()
	if self:GetCharge() > 99 then return true else return false end
end

--[[
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
	
--	ply:SetNWInt("PrevBS", self.BloomValue * 10)
end ]]

local bloom_updates = {
	["standidle"] = 0,
	["crouchidle"] = 0,
	["running"] = 0.1,
	["crouchrunning"] = 0.1,
	["sprinting"] = 0.3,
	["crouchingsprinting"] = 0.3,
}
local bloom_maximums = {
	["standidle"] = 1,
	["crouchidle"] = 1,
	["running"] = 1.3,
	["crouchrunning"] = 1.3,
	["sprinting"] = 1.7,
	["crouchingsprinting"] = 1.7,
}

function SWEP:UpdateBloom(mode)
	local ply = self:GetOwner()
	local oa, cv, bs, pbs, mul = self.OwnerActivity, ply:Crouching(), self:GetBS(), self:GetPBS(), 1
	if cv then mul = 0.5 end
	
	local kickmodes = {
		["primary"] = self.Primary.Kick,
		["secondary"] = self.Secondary.Kick,
		["overcharge"] = self.OCKick
	}
	if !self.Kick then self.Kick = kickmodes[mode] end
	
	self.PrevBS = math.Clamp(bs, 0, bloom_maximums[oa])
	self.BloomValue = math.Clamp((self.BloomValue + bloom_updates[oa] + self.Kick) * mul, 0, bloom_maximums[oa])
end

function SWEP:GetBS()
	return self.BloomValue
end

function SWEP:GetPBS()
	return self.PrevBS
end

function SWEP:DoMeleeSwing(mode, flipx, flipy, preventanim)
	local ply = self:GetOwner()
	local settings = {}
	if self.IsMelee then
		settings = {
			["primary"] = {
				["range"] = self.Primary.Range,
				["x1m"] = math.Rand(self.Primary.StartX * 0.9, self.Primary.StartX * 1.1),
				["x2m"] = math.Rand(self.Primary.EndX * 0.9, self.Primary.EndX * 1.1),
				["y1m"] = math.Rand(self.Primary.StartY * 0.9, self.Primary.StartY * 1.1),
				["y2m"] = math.Rand(self.Primary.EndY * 0.9, self.Primary.EndY * 1.1),
				["delayhit"] = self.Primary.DelayHit,
				["delaymiss"] = self.Primary.DelayMiss,
				["delayinitial"] = self.Primary.HitDelay,
				["sound"] = self.Primary.SwingSound,
				["shake"] = self.Primary.ShakeMul,
				["anim"] = self.Primary.MeleeAct,
				["anim_crouch"] = self.Primary.MeleeActCrouch,
				["fp_hit"] = self.Primary.HitActivity,
				["fp_hit_crouch"] = self.Primary.CrouchHitActivity,
				["fp_miss"] = self.Primary.MissActivity,
				["fp_miss_crouch"] = self.Primary.CrouchMissActivity,
			},
			["secondary"] = {
				["range"] = self.Secondary.Range,
				["x1m"] = math.Rand(self.Secondary.StartX * 0.9, self.Secondary.StartX * 1.1),
				["x2m"] = math.Rand(self.Secondary.EndX * 0.9, self.Secondary.EndX * 1.1),
				["y1m"] = math.Rand(self.Secondary.StartY * 0.9, self.Secondary.StartY * 1.1),
				["y2m"] = math.Rand(self.Secondary.EndY * 0.9, self.Secondary.EndY * 1.1),
				["delayhit"] = self.Secondary.DelayHit,
				["delaymiss"] = self.Secondary.DelayMiss,
				["delayinitial"] = self.Secondary.HitDelay,
				["sound"] = self.Secondary.SwingSound,
				["shake"] = self.Secondary.ShakeMul,
				["anim"] = self.Secondary.MeleeAct,
				["anim_crouch"] = self.Secondary.MeleeActCrouch,
				["fp_hit"] = self.Secondary.HitActivity,
				["fp_hit_crouch"] = self.Secondary.CrouchHitActivity,
				["fp_miss"] = self.Secondary.MissActivity,
				["fp_miss_crouch"] = self.Secondary.CrouchMissActivity,
			},
			["lungeprimary"] = {
				["range"] = self.Primary.LungeRange,
				["x1m"] = math.Rand(self.Primary.LungeStartX * 0.9, self.Primary.LungeStartX * 1.1),
				["x2m"] = math.Rand(self.Primary.LungeEndX * 0.9, self.Primary.LungeEndX * 1.1),
				["y1m"] = math.Rand(self.Primary.LungeStartY * 0.9, self.Primary.LungeStartY * 1.1),
				["y2m"] = math.Rand(self.Primary.LungeEndY * 0.9, self.Primary.LungeEndY * 1.1),
				["delayhit"] = self.Primary.LungeDelayHit,
				["delaymiss"] = self.Primary.LungeDelayMiss,
				["delayinitial"] = self.Primary.LungeHitDelay,
				["sound"] = self.Primary.LungeSwingSound,
				["shake"] = self.Primary.LungeShakeMul,
				["anim"] = self.Primary.LungeMeleeAct,
				["anim_crouch"] = self.Primary.LungeMeleeActCrouch,
				["fp_hit"] = self.Primary.LungeHitAct,
				["fp_hit_crouch"] = self.Primary.LungeHitActCrouch,
				["fp_miss"] = self.Primary.LungeMissAct,
				["fp_miss_crouch"] = self.Primary.LungeMissActCrouch,
			},
		}
	else
		settings = {
			["gunmelee"] = {
				["range"] = self.Primary.MeleeRange,
				["x1m"] = math.Rand(self.Primary.MeleeStartX * 0.9, self.Primary.MeleeStartX * 1.1),
				["x2m"] = math.Rand(self.Primary.MeleeEndX * 0.9, self.Primary.MeleeEndX * 1.1),
				["y1m"] = math.Rand(self.Primary.MeleeStartY * 0.9, self.Primary.MeleeStartY * 1.1),
				["y2m"] = math.Rand(self.Primary.MeleeEndY * 0.9, self.Primary.MeleeEndY * 1.1),
				["delayhit"] = self.Primary.MeleeDelayHit,
				["delaymiss"] = self.Primary.MeleeDelayMiss,
				["delayinitial"] = self.Primary.MeleeHitDelay,
				["sound"] = self.Primary.SwingSound,
				["shake"] = self.Primary.MeleeShakeMul,
				["anim"] = nil,
				["anim_crouch"] = nil,
				["fp_hit"] = self.Primary.MeleeHitActivity,
				["fp_hit_crouch"] = self.Primary.MeleeHitActivity,
				["fp_miss"] = self.Primary.MeleeMissActivity,
				["fp_miss_crouch"] = self.Primary.MeleeMissActivity,
			},
		}
	end
	
	local x1m, x2m, y1m, y2m = settings[mode]["x1m"], settings[mode]["x2m"], settings[mode]["y1m"], settings[mode]["y2m"]
	if flipx == true then 
		x1m = -x1m
		x2m = -x2m
	end
	if flipy == true then
		y1m = -y1m
		y2m = -y2m
	end
	
	if mode == "gunmelee" then
		local ht = string.lower(self:GetHoldType())
		if ht == "ar2" or ht == "smg" or ht == "crossbow" or ht == "shotgun" or ht == "rpg" or ht == "melee2" or ht == "physgun" then
			settings.gunmelee.anim = ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND
			settings.gunmelee.anim_crouch = ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND
		elseif ht == "crowbar" or ht == "pistol" or ht == "revolver" or ht == "grenade" or ht == "slam" or ht == "normal" or ht == "fist" or ht == "knife" or ht == "passive" or ht == "duel" or ht == "magic" or ht == "camera" then
			settings.gunmelee.anim = ACT_GMOD_GESTURE_MELEE_SHOVE_1HAND
			settings.gunmelee.anim_crouch = ACT_GMOD_GESTURE_MELEE_SHOVE_1HAND
		end
	end
	
	if mode == "lungeprimary" then
	local target = self:GetConeTarget()
		if target then
			if ply:GetPos():Distance(target:GetPos()) < self.Primary.LungeMaxDist then
				ply:SetVelocity(ply:GetForward() * 8 * ply:GetPos():Distance(target:GetPos()))
			end
		end
	end

	DRC:SpeakSentence(ply, "Actions", "Melee")
	if settings[mode]["sound"] != nil then self:EmitSound(Sound(settings[mode]["sound"])) end
	
	if ply:IsPlayer() && preventanim != true then
		local cv = ply:Crouching()
		if cv == false then
			if SERVER then DRC:CallGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, settings[mode]["anim"]) end
		elseif cv == true then
			if SERVER then DRC:CallGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, settings[mode]["anim_crouch"]) end
		end
	end
	
	if ply:IsPlayer() then
		local vm = ply:GetViewModel()
		ply:ViewPunch(Angle(y1m, x1m, nil) * -0.1 * settings[mode]["shake"])
		ply:SetViewPunchVelocity(Angle(-x1m * (1 + settings[mode]["delayhit"]) * settings[mode]["shake"], -y1m * (5 + settings[mode]["delayhit"]) * settings[mode]["shake"], 0))
		timer.Simple(.1, function()
			if !IsValid(self) then return end
			if !IsValid(self:GetOwner()) then return end
			ply:ViewPunch(Angle(y1m, x1m, nil) * 0.1 * settings[mode]["shake"])
		end)

		local anim = self:SelectWeightedSequence( settings[mode]["fp_miss"] )
		if ply:IsPlayer() then	local cv = ply:Crouching() if cv == true then anim = self:SelectWeightedSequence( settings[mode]["fp_miss_crouch"] ) end end
		local animdur = self:SequenceDuration( anim )
		self.IsDoingMelee = true
		timer.Simple(animdur, function() if !IsValid(self) then return end self.IsDoingMelee = false end)
		if anim != -1 && self:HasViewModel() && preventanim != true then 
			self:SendWeaponAnim(settings[mode]["fp_miss"])
			self:SendViewModelMatchingSequence(anim)
		end
		self:SetNextPrimaryFire(CurTime() + settings[mode]["delayhit"] )
		self:SetNextSecondaryFire(CurTime() + settings[mode]["delayhit"] )
		self.IdleTimer = CurTime() + vm:SequenceDuration()
	else
		self:SetNextPrimaryFire(CurTime() + settings[mode]["delayhit"] )
		self:SetNextSecondaryFire(CurTime() + settings[mode]["delayhit"] )
		self.IsDoingMelee = true
		timer.Simple(1, function() if !IsValid(self) then return end self.IsDoingMelee = false end)
	end
	
	for i=1,(math.Round(1/ engine.TickInterval() - 1 , 0)) do
		if !IsValid(self) then return end
		if !IsValid(ply) then return end
		timer.Create( "".. tostring(self) .."_SwingImpact".. i .."", math.Round((settings[mode]["delayinitial"] * 100) / 60 * i / 60, 3), 1, function()
			if !IsValid(self) then return end
			if !IsValid(self:GetOwner()) then return end
			self:MeleeImpact(settings[mode]["range"], Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), x1m, x2m), Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), y1m, y2m), i, mode)
		end)
	end
end

function SWEP:MeleeImpact(range, x, y, i, att)
	if !SERVER then return end
	local ply = self:GetOwner()
	local vm = nil
	local eyeang = ply:EyeAngles()
	local eyepos = ply:EyePos()
	local centerpos = ply:GetPos() + ply:OBBCenter()
	local aimpos = ply:GetPos() + Vector(ply:OBBCenter().x, ply:OBBCenter().y, ply:OBBCenter().z * 1.4)
	local rangemul = 1
	local velang = DRC:GetVelocityAngle(ply, true, true)
	if ply:IsPlayer() then
		vm = ply:GetViewModel()
		rangemul = math.Clamp((ply:GetWalkSpeed()/100 * (ply:GetWalkSpeed()/100) / 2) * velang.y / 180, 1, 2.5)
	else
		rangemul = 2
	end
	
	local rhm = math.Round(1 / engine.TickInterval() - 1, 0) / 2
	
	if !IsValid(self) or !IsValid(ply) then return end

	if i < rhm then
		self.dist = eyepos + ( ply:GetAimVector() * range * ( i / 10) ) * rangemul
	elseif i == rhm then
		self.dist = eyepos + ( ply:GetAimVector() * range * 3.4 ) * rangemul
	elseif i > rhm then
		self.dist = eyepos + ( ply:GetAimVector() * range / (i / 100) ) * rangemul
	end
	
	local WhyDoesVJAimUpwards = Vector()
	if ply.IsVJBaseSNPC then WhyDoesVJAimUpwards = Vector(0 ,0, -40) end
	
	local tl = {
		["start"] = aimpos,
		["endpos"] =  ( self.dist ) + ((eyeang:Up()*y) + (eyeang:Right()*x) + WhyDoesVJAimUpwards),
		["filter"] = {self, ply},
		["mask"] = MASK_SHOT
	}
	if ply:IsPlayer() then ply:LagCompensation(true) end
	local swingtrace = util.TraceLine( tl )
	if ply:IsPlayer() then ply:LagCompensation(false) end
	
	att = string.lower(att)
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
	
	local damageinfo = DamageInfo()
	damageinfo:SetAttacker(ply)
	damageinfo:SetInflictor(self)
	damageinfo:SetDamageType(self.DT)
	damageinfo:SetDamageForce((self.Owner:GetRight() * math.random(3568,4235)) + (self.Owner:GetForward() * math.random(6875,7523)))
	damageinfo:SetDamage(self.Damage)
	damageinfo:SetBaseDamage(2221208)
	
	if ( swingtrace.Hit ) then
		self:SetNextPrimaryFire( CurTime() + self.DH )
		self:SetNextSecondaryFire( CurTime() + self.DH )
		
		if self.HA != nil then self:SendWeaponAnim( self.HA ) end
		
		for i=-1, (math.Round(1/ engine.TickInterval() - 1 , 0)) do
			if timer.Exists("".. tostring(self) .."_SwingImpact".. i .."") then timer.Destroy("".. tostring(self) .."_SwingImpact".. i .."") end
		end
		
		
		
		if IsValid(swingtrace.Entity) && DRC:IsCharacter(swingtrace.Entity) then
		elseif swingtrace.Entity:IsValid() and ( !swingtrace.Entity:IsNPC() or !swingtrace.Entity:IsPlayer() ) && !swingtrace.Entity:IsNextBot() && IsValid(swingtrace.Entity:GetPhysicsObject()) then
			if i < rhm then
				swingtrace.Entity:GetPhysicsObject():ApplyForceOffset( self.Owner:GetForward() * self.Force * 15 * i, swingtrace.HitPos )
			elseif i == rhm then	
				swingtrace.Entity:GetPhysicsObject():ApplyForceOffset( self.Owner:GetForward() * self.Force * 15 * i, swingtrace.HitPos )
			elseif i > rhm then
				swingtrace.Entity:GetPhysicsObject():ApplyForceOffset( self.Owner:GetForward() * self.Force * 15 * ( i / 10 ), swingtrace.HitPos )
			end
			
			if swingtrace.Entity:Health() > 0 then
			swingtrace.Entity:TakeDamage( self.Damage, self.Owner, self.Owner:GetActiveWeapon() )
			end
		elseif swingtrace.Entity:IsWorld() then
			util.Decal(self.ID, swingtrace.HitPos + swingtrace.HitNormal, swingtrace.HitPos - swingtrace.HitNormal)  
			util.Decal(self.BD, swingtrace.HitPos + swingtrace.HitNormal, swingtrace.HitPos - swingtrace.HitNormal)  
		end
	end
	if IsValid(swingtrace.Entity) then swingtrace.Entity:TakeDamageInfo( damageinfo ) end

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
	
	if swingtrace.Hit && !swingtrace.Entity:IsWorld() then
		DRC:RenderTrace(swingtrace, Color(255, 0, 0, 255), 1)
	elseif !swingtrace.Hit then
		DRC:RenderTrace(swingtrace, Color(255, 255, 255, 255), 1)
	end
	
end

function SWEP:TakePrimaryAmmo( num )
	if !SERVER then return end
	
	if GetConVar("sv_drc_infiniteammo"):GetFloat() == 2 then return end
	
	if ( self:Clip1() == 0 ) && self.Owner:IsPlayer() then
		if ( self:Clip1() == 0 ) then return end
		self.Owner:RemoveAmmo( num, self:GetPrimaryAmmoType() )
	return end
	self:SetClip1(self:GetNWInt("LoadedAmmo"))
end

function SWEP:TakeSecondaryAmmo( num )
	if ( self:Clip2() <= 0 ) then
		if ( self:Ammo2() <= 0 ) then return end
		self.Owner:RemoveAmmo( num, self:GetSecondaryAmmoType() )
	return end
	self:SetClip2( self:Clip2() - num )
end

function SWEP:GetConeTarget()
	local ply = self:GetOwner()
	if !ply or !ply:IsPlayer() then return end
	local coneents = DRC:EyeCone(ply, self.Primary.AimAssistDist, self.SpreadCone * self.Primary.AimAssist_Mul)
	local targets = {}
	for k,v in pairs(coneents) do
		if (v:IsPlayer() && v != ply) or v:IsNPC() or v:IsNextBot() or DRC:IsVehicle(v) then table.insert(targets, v) end
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

function SWEP:GetTraceTarget()
	if CLIENT then return end
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	
	local tr = util.TraceLine({
		start = ply:EyePos(),
		endpos = ply:EyePos() + ply:GetAimVector() * 1000,
		filter = function(ent) return (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) && ent:EntIndex() != 0 && (ent != self && ent != ply) end
	})
	
	return tr.Entity
end

function SWEP:ShootBullet(damage, num, cone, ammo, force, tracer)
	local ply = self:GetOwner()
	local stats = self.StatsToPull
	local fm = self:GetNWString("FireMode")
--	if !IsFirstTimePredicted() then return end
	
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
			if !tr.Entity:IsWorld() then
				DRC:RenderTrace(tr, Color(255, 0, 0, 255), 1)
			else
				DRC:RenderTrace(tr, Color(255, 255, 255, 255), 1)
			end
		
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
			
			self:RunAttachmentFunction("Ammunition", "Callback", nil, {ent, tr, takedamageinfo})
			self:DoCustomBulletImpact(tr.HitPos, tr.Normal, takedamageinfo)
		end
	end
	
	self:FireBullets(bullet)
end

function SWEP:CalculateSpread(isprojectile)
	if !IsValid(self) then return end
	if isprojectile == nil then isprojectile = false end
	local ply = self:GetOwner()
	local SpreadMod = ply:GetNWInt("DRC_GunSpreadMod", 1)
	local stats = self.StatsToPull
	local calc = ((stats.Spread * self:GetAttachmentValue("Ammunition", "Spread")) / (stats.SpreadDiv * self:GetAttachmentValue("Ammunition", "SpreadDiv")))
	
	if isprojectile == false then
		if ply:IsPlayer() then
			return (Vector( calc, calc, 0 ) * self.BloomValue) * SpreadMod
		elseif ply:IsNPC() or ply:IsNextBot() then
			return (Vector(calc, calc, calc))
		end
	else
		return (Vector( calc, calc, 0 ) * self.BloomValue / 2) * SpreadMod -- This isn't perfectly accurate to the spread cone but what the fuck ever, it's close enough.
	end
end

function SWEP:SetLoadedAmmo(amount)
	if !IsValid(self) then return end
	if GetConVar("sv_drc_infiniteammo"):GetFloat() > 1 then return end
	if GetConVar("sv_drc_infiniteammo"):GetFloat() > 0 && self.IsBatteryBased == true then return end
	self:SetNWInt("LoadedAmmo", amount)
	self:SetClip1(amount)
end

function SWEP:GetLoadedAmmo()
	if !IsValid(self) then return end
	return self:GetNWInt("LoadedAmmo", self:Clip1())
end

function SWEP:DoShoot(mode)
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	local AA = self.ActiveAttachments
	local IA = self.AttachmentTable
	local stats = self.StatsToPull
	local batstats = self.BatteryStats
	local eyeang = ply:EyeAngles()
	local sd = DRC:SightsDown(self)
	
	local tr
	if ply:IsNPC() && ply.Draconic == true then
		tr = ply:GetEyeTrace()
	else
		tr = util.GetPlayerTrace(ply)
	end
	local trace = util.TraceLine( tr )
	local LeftHand = ply:LookupBone(DRC.Skel.LeftHand.Name)
	local RightHand = ply:LookupBone(DRC.Skel.RightHand.Name)
	
	local pmag = self:Clip1()
	local nmag = self:Clip1() - stats.APS
	
	if nmag <= 0 then
		self.PistolSlide = 0
	end
	
	local firetime = 0
	local fireseq = self:SelectWeightedSequence(ACT_VM_PRIMARYATTACK)
	local fireseq2 = self:SelectWeightedSequence(ACT_VM_SECONDARYATTACK)
	local fireseq3 = self:SelectWeightedSequence(ACT_SPECIAL_ATTACK1)
	local ironseq = self:SelectWeightedSequence(ACT_VM_DEPLOYED_IRON_FIRE)
	if mode == "primary" then
		if sd && ironseq != -1 then fireseq = ironseq end
		firetime = self:SequenceDuration(fireseq)
	elseif mode == "secondary" then
		firetime = self:SequenceDuration(fireseq2)
	elseif mode == "overcharge" then
		firetime = self:SequenceDuration(fireseq3)
	end
	self.IdleTimer = CurTime() + firetime
	self.LastFireTime = CurTime()
	self.LastFireAnimTime = CurTime() + firetime
	
	local function GetProjectile()
		if AA.AmmunitionTypes == IA.AmmunitionTypes[1] then return stats.Projectile
		else return AA.AmmunitionTypes.t.BulletTable.ProjectileOverride or stats.Projectile end
	end
	
	local function GetSpeed()
		if AA.AmmunitionTypes == IA.AmmunitionTypes[1] then return stats.ProjSpeed
		else return AA.AmmunitionTypes.t.BulletTable.ProjectileSpeed or stats.ProjSpeed end
	end
	
	local projectile = GetProjectile()
	local speeeeed = GetSpeed()
	
	local shotnum = self:GetAttachmentValue("Ammunition", "NumShots")
	if mode == "primary" then
		if ply:IsPlayer() then
			self:UpdateBloom("primary")
			if game.SinglePlayer() then self:CallOnClient( "UpdateBloom", "primary") end
		end
		
		if self.Base == "draconic_gun_base" then
			if stats != self.OCStats then
				self:SetLoadedAmmo(math.Clamp((self:GetNWInt("LoadedAmmo") - stats.APS), 0, (self.Primary.ClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))))
			else
				self:SetLoadedAmmo(math.Clamp((self:GetNWInt("LoadedAmmo") - stats.OCAPS), 0, (self.Primary.ClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))))
			end
			self:TakePrimaryAmmo( stats.APS )
		elseif self.Base == "draconic_battery_base" then
			if stats != self.OCStats then
				self:SetLoadedAmmo(math.Clamp((self:GetNWInt("LoadedAmmo") - batstats.BatteryConsumePerShot), 0, self.Primary.ClipSize))
			else
				self:SetLoadedAmmo(math.Clamp((self:GetNWInt("LoadedAmmo") - stats.APS), 0, self.Primary.ClipSize))
			end
			self:TakePrimaryAmmo( batstats.BatteryConsumePerShot )
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
		
		self.ChargeValue = 0
		shotnum = self:GetAttachmentValue("Ammunition", "NumShots_OC")
		
		if self.Base == "draconic_gun_base" then
			if stats != self.OCStats then
				self:SetLoadedAmmo(math.Clamp((self:GetNWInt("LoadedAmmo") - stats.APS), 0, (self.Primary.ClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))))
			else
				self:SetLoadedAmmo(math.Clamp((self:GetNWInt("LoadedAmmo") - stats.APS), 0, (self.Primary.ClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))))
			end
			self:TakePrimaryAmmo( stats.APS )
		elseif self.Base == "draconic_battery_base" then
			if stats != self.OCStats then
				self:SetLoadedAmmo(math.Clamp((self:GetNWInt("LoadedAmmo") - batstats.BatteryConsumePerShot), 0, self.Primary.ClipSize))
			else
				self:SetLoadedAmmo(math.Clamp((self:GetNWInt("LoadedAmmo") - stats.APS), 0, self.Primary.ClipSize))
			end
			self:TakePrimaryAmmo( batstats.BatteryConsumePerShot )
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
		local maxarmour = ply:GetMaxArmor()
		local nextarmour = armour - amount
		ply:SetArmor(math.Clamp(armour - amount, 0, maxarmour))
	end
	
	if self.Loading == false && self.ManuallyReloading == false && ply:IsPlayer() then
		if self.SightsDown == true && self.Secondary.SightsSuppressAnim == true then else
			local vm = ply:GetViewModel()
			if mode == "primary" then
				if SERVER or game.SinglePlayer() then 
					vm:SendViewModelMatchingSequence(fireseq)
				end
				self:ResetSequence(fireseq)
				self:ResetSequenceInfo()
				self:SetCycle(0)
			elseif mode == "secondary" then
				vm:SendViewModelMatchingSequence(fireseq2)
				self:ResetSequence(fireseq2)
				self:ResetSequenceInfo()
			elseif mode == "overcharge" then
				if fireseq3 == -1 then
					vm:SendViewModelMatchingSequence(fireseq)
					self:ResetSequence(fireseq)
					self:ResetSequenceInfo()
				else
					vm:SendViewModelMatchingSequence(fireseq3)
					self:ResetSequence(fireseq3)
					self:ResetSequenceInfo()
				end
			end
		end
		ply:SetAnimation( PLAYER_ATTACK1 )
	else end
	
	if ply.DraconicNPC then
		if ply:DraconicNPC() == true then
			local holdtype = string.lower(self:GetHoldType())
			local act = DRC.HoldTypes[holdtype].attack
			DRC:CallGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, act, true)
		end
	end
	
	if self.Base == "draconic_battery_base" then
		local heat = self:GetHeat()
		if stats != self.OCStats then
			self:SetHeat((self:GetHeat() + batstats.HPS))
		else
			self:SetHeat((self:GetHeat() + batstats.OCHPS))
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
	
	if projectile == nil then
		if CLIENT then self:CalculateSpread() end
		if ply:IsNextBot() then self:CalculateSpread() end
		if self.PreventAllBullets == true then return end
		if ply:IsPlayer() then ply:LagCompensation(true) end
		if self.PreventAllBullets == false then self:ShootBullet(stats.Damage, shotnum, self:CalculateSpread(), stats.Ammo, stats.Force, stats.Tracer) end
		if ply:IsPlayer() then ply:LagCompensation(false) end
	elseif mode == "secondary" && self.Projectile == "scripted" then
		timer.Simple(self.Secondary.ProjectileSpawnDelay, function()
			self:DoScriptedSecondaryAttack()
			self:EmitSound(self.Secondary.Sound)
			ply:SetAnimation( PLAYER_ATTACK1 )
			self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
		end)
	else
		if SERVER then
			local muzzleattachment = self:LookupAttachment("muzzle")
			local muzzle = self:GetAttachment(muzzleattachment)
			
			for i=1,shotnum do
				local class = ""
				if istable(stats.Projectile) then class = stats.Projectile[math.Round(math.Rand(1, #stats.Projectile))] else class = projectile end
				if IsValid(class) && class != "" then return false end
				local SpreadCalc = self:CalculateSpread(true) * self.BloomValue
				local AmmoSpread = ((stats.Spread * self:GetAttachmentValue("Ammunition", "Spread")) / (stats.SpreadDiv * self:GetAttachmentValue("Ammunition", "SpreadDiv"))) * 1000 * self.BloomValue
				local FinalSpread = Angle(math.Rand(SpreadCalc.x, -SpreadCalc.x) * AmmoSpread, math.Rand(SpreadCalc.y, -SpreadCalc.y) * AmmoSpread, 0) * self.BloomValue + stats.MuzzleAngle
				local projang = ply:GetAimVector():Angle() + FinalSpread
				local projpos = Vector()
				if ply:IsPlayer() && self.SightsDown == true then
					if self.SightsDown == true && self.Secondary.Scoped == true then
						projpos = ply:EyePos()
					else
						projpos = ply:EyePos() - Vector(0, 0, 15) + ply:GetAimVector() * Vector(25, 25, 25)
					end
				elseif ply:IsNPC() or ply:IsNextBot() then
					if muzzle != nil then
						projpos = muzzle.Pos
					else
						projpos = ply:EyePos() - Vector(0, 0, 15) + ply:GetAimVector() * Vector(25, 25, 25)
					end
					if ply.IsVJBaseSNPC then
						projpos = ply:EyePos() - Vector(0, 0, 15) + ply:GetAimVector() * Vector(25, 25, 25)
						projang = projang - Angle(-10, 0 ,0) -- wtf
					end
				else
					if !DRC:ValveBipedCheck(ply) then -- Unfortunately, muzzle pos does not work in singleplayer unless the local player is being rendered.
						local eyeheight = ply:EyePos().z - ply:GetPos().z
						projpos = ply:GetPos() + Vector(0, 0, eyeheight/1.1) + ply:EyeAngles():Forward() * 10 + ply:EyeAngles():Right() * 5
					else
						projpos = ply:GetBonePosition(RightHand)
					end
				end
				
				local proj = DRC:CreateProjectile(class, projpos, projang, speeeeed, ply, stats.ProjInheritVelocity)
				self:PassToProjectile(proj)
				
				if !self.PTable then self.PTable = {} end
				if proj.Draconic == true then table.insert(self.PTable, proj) end
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
			if !IsValid(self) then return end
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
	
	if ply:IsNPC() or ply:IsNextBot() then
		timer.Simple( 0.5, function() -- holy fUCK LET ME DETECT WHEN AN NPC RELOADS IN LUA NATIVELY PLEASE
			if !IsValid(self) or !IsValid(ply) then return end
			if ply:GetActivity() == ACT_RELOAD then
				self:DoCustomReloadStartEvents()
				self:SetLoadedAmmo((self.Primary.ClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul")))
			end
		end)
	end
	
	if ply:IsNextBot() then -- Iv04 Nextbot handling
		if ply.IV04NextBot != true then return end
		if self.NPCBursting == true then return end
		
		local rpm = self.Primary.RPM
		local fm = self:GetNWString("FireMode")
	end
end

function SWEP:DoEffects(mode, nosound, multishot)
	if !IsValid(self) then return end
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	local muzzleattachment = self:LookupAttachment("muzzle")
	local muzzle = self:GetAttachment(muzzleattachment)
	local fm = self:GetNWString("FireMode")
		
	if mode == "primary" then
		self.vFire = self.Primary.isvFire
		self.Projectile = self.Primary.Projectile
		self.TracerEffect = self.Primary.TracerEffect
		
		self:CallOnClient("MuzzleFlash")
		
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
		if fm == "Semi" or fm == "Auto" then
			self.Sound = self.OCSound
			self.DistSound = self.OCDistSound
			self.SoundDistance = self.Primary.SoundTable.Semiauto.FarDistance
		else
			self.Sound = self.OCSound
			self.DistSound = self.OCDistSound
			self.SoundDistance = self.Primary.SoundTable.Burst.FarDistance
		end
		
		self.LastHitPos = self.LastHitPos
	end
	
	
	local effectdata = EffectData()
	
	if self.StatsToPull.Projectile == nil && self.vFire == false then
		if self.LastHitPos == nil then self.LastHitPos = Vector(0, 0, 0) end
		effectdata:SetOrigin( self.LastHitPos )
	else
		effectdata:SetOrigin( ply:GetShootPos() )
	end



	if self.SightsDown == false then
		effectdata:SetAttachment( muzzleattachment )
	elseif self.SightsDown == true && self.Secondary.Scoped == true then
		effectdata:SetStart( ply:EyePos() + Vector(0, 0, -2) )
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

	if RoomType == "Valley" && !self.Primary.SoundTable.Envs["Valley"] then RoomType = "Outdoors" end
	if RoomType == "Outdoors" && !self.Primary.SoundTable.Envs["Outdoors"] then RoomType = "Large" end
	if RoomType == "Vent" && !self.Primary.SoundTable.Envs["Vent"] then RoomType = "Small" end
	
	if mode == "primary" && self.Primary.SoundTable.Envs[RoomType] then
		if fm == "Semi" or fm == "Auto" then
			self.Sound = self.Primary.SoundTable.Envs[RoomType].Semiauto.Near
			self.DistSound = self.Primary.SoundTable.Envs[RoomType].Semiauto.Far
		else
			self.Sound = self.Primary.SoundTable.Envs[RoomType].Burst.Near
			self.DistSound = self.Primary.SoundTable.Envs[RoomType].Burst.Far
		end
	end
	
	if (game.SinglePlayer() or CLIENT) && GetConVar("cl_drc_debugmode"):GetFloat() > 0 then
		if GetConVar("cl_drc_debug_invertnearfar"):GetFloat() >= 1 then
			DRC:EmitSound(self, self.DistSound, self.DistSound, self.SoundDistance, SOUND_CONTEXT_GUNFIRE, listener)
		else
			DRC:EmitSound(self, self.Sound, self.DistSound, self.SoundDistance, SOUND_CONTEXT_GUNFIRE, listener)
		end
	else
		DRC:EmitSound(self, self.Sound, self.DistSound, self.SoundDistance, SOUND_CONTEXT_GUNFIRE, listener)
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
		
	--if self:GetNWBool("ironsights") == false && cv == false then
	if self.SightsDown == false && cv == false then
		if CLIENT then
			eyeang.pitch = eyeang.pitch - ((math.Rand(self.RecoilUp / 1.85, self.RecoilUp * 1.62)) - (math.Rand(self.RecoilDown / 1.85, self.RecoilDown * 1.85) * 0.01))
			eyeang.yaw = eyeang.yaw - (math.Rand( self.RecoilHoriz, (self.RecoilHoriz * -0.81) ) * 0.01)
		end
		self.Owner:ViewPunch(Angle( -self.Kick, math.Rand(-self.KickHoriz, self.KickHoriz), math.Rand(-self.KickHoriz, self.KickHoriz) / 200 ))
		--elseif self:GetNWBool("ironsights") == true && cv == false then
		elseif self.SightsDown == true && cv == false then
		if CLIENT then
			eyeang.pitch = eyeang.pitch - (((math.Rand(self.RecoilUp / 1.5, self.RecoilUp * 1.5)) - (math.Rand(self.RecoilDown / 1.5, self.RecoilDown * 1.5) * 0.01)) * self.IronRecoilMul)
			eyeang.yaw = eyeang.yaw - (math.Rand( self.RecoilHoriz, (self.RecoilHoriz * -1) ) * 0.01)
		end
		self.Owner:ViewPunch(Angle( (-self.Kick * 0.69) * self.IronRecoilMul, math.Rand(-self.KickHoriz, self.KickHoriz) / 100, math.Rand(-self.KickHoriz, self.KickHoriz) / 250 ) * self.Secondary.SightsKickMul)
	--elseif self:GetNWBool("ironsights") == false && cv == true then
	elseif self.SightsDown == false && cv == true then
		if CLIENT then
			eyeang.pitch = eyeang.pitch - ((math.Rand(self.RecoilUp / 1.5, self.RecoilUp * 1.5)) - (math.Rand(self.RecoilDown / 1.5, self.RecoilDown * 1.5) * 0.01))
			eyeang.yaw = eyeang.yaw - (math.Rand( self.RecoilHoriz, (self.RecoilHoriz * -1) ) * 0.01)
		end
		self.Owner:ViewPunch(Angle( -self.Kick * 0.75, math.Rand(-self.KickHoriz, self.KickHoriz) / 100, math.Rand(-self.KickHoriz, self.KickHoriz) / 250 ))
		--elseif self:GetNWBool("ironsights") == true && cv == true then
		elseif self.SightsDown == true && cv == true then
		if CLIENT then
			eyeang.pitch = eyeang.pitch - (((math.Rand(self.RecoilUp / 1.5, self.RecoilUp * 0.9)) - (math.Rand(self.RecoilDown / 1.9, self.RecoilDown * 0.9) * 0.01)) * self.IronRecoilMul)
			eyeang.yaw = eyeang.yaw - (math.Rand( self.RecoilHoriz, (self.RecoilHoriz * -1) ) * 0.01)
		end
		self.Owner:ViewPunch(Angle( (-self.Kick * 0.42) * self.IronRecoilMul, math.Rand(-self.KickHoriz, self.KickHoriz) / 200, math.Rand(-self.KickHoriz, self.KickHoriz) / 500 ))
	end
	
	if CLIENT then ply:SetEyeAngles(Angle(0, 0, 0) + Angle(eyeang.pitch, eyeang.yaw, nil)) end
end

function SWEP:MuzzleFlash()
	if SERVER then return end
	local col = self:GetAttachmentValue("Ammunition", "MuzzleFlash", "Colour")
	local epileptic, mul = GetConVar("cl_drc_accessibility_photosensitivity_muzzle"):GetFloat(), 1
	if epileptic == 1 then mul = 0.5 end
		
	if self:GetAttachmentValue("Ammunition", "MuzzleFlash", "Dynamic") == true then
		DRC.CalcView.MuzzleLamp_Time = CurTime() + math.Rand(0.005, 0.01)
		local bright = (col.a/3) * (math.Clamp(DRC.MapInfo.MapAmbientAvg, 0.15, 1)) * mul
		local ent = DRC.CalcView.MuzzleLamp
		ent.Texture = self:GetAttachmentValue("Ammunition", "MuzzleFlash", "Mask")
		ent.Light:SetColor(Color(col.r, col.g, col.b))
		ent.Light:SetBrightness(bright)
		ent.FOV = self:GetAttachmentValue("Ammunition", "MuzzleFlash", "FOV")
		ent.FarZ = self:GetAttachmentValue("Ammunition", "MuzzleFlash", "FarZ")
		ent.Enabled = true
	end
	
	if self:GetAttachmentValue("Ammunition", "MuzzleFlash", "Simple") == true then
		local finalcol = Color(col.r, col.g, col.b, col.a * mul)
		DRC:DLight(self, self:GetShootPos(), finalcol, self:GetAttachmentValue("Ammunition", "MuzzleFlash", "Size"), self:GetAttachmentValue("Ammunition", "MuzzleFlash", "LifeTime"))
	end
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
		
		if IsValid(self) && self:GetNWInt("LoadedAmmo") > -0.01 then self:DoCustomPrimaryAttackEvents() end
	elseif mode == "secondary" then
		if ignoreimpossibility != true && !self:CanSecondaryAttack() then return end
		self.StatsToPull = self.SecondaryStats
		self:DoShoot("secondary")
		self:DoEffects("secondary")
		
		if ply:IsPlayer() then self:DoRecoil("secondary") end
		
		if IsValid(self) && self:GetNWInt("LoadedAmmo") > -1 then self:DoCustomSecondaryAttackEvents() end
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

local BaseABP = scripted_ents.GetStored("drc_abp_generic")
function SWEP:GetAttachmentValue(att, val, subval)
	if !BaseABP then BaseABP = scripted_ents.GetStored("drc_abp_generic") end
	local AA = self.ActiveAttachments
	local BT = BaseABP.t.BulletTable
	local tab = nil
	
	if att == "Ammunition" then
		tab = AA.AmmunitionTypes.t.BulletTable
		
		local foundval = tab[val]
		local foundsubval = nil
		if foundval == nil then foundval = BaseABP.t.BulletTable[val] end
		if subval then
			if tab[val] then foundsubval = tab[val][subval] end
			if foundsubval == nil then foundsubval = BaseABP.t.BulletTable[val][subval] end
			return foundsubval
		end
		return foundval
	end
end

function SWEP:RunAttachmentFunction(att, val, subval, args)
	local AA = self.ActiveAttachments
	local BT = BaseABP.t.BulletTable
	local tab = nil
	
	if att == "Ammunition" then
		tab = AA.AmmunitionTypes.t.BulletTable
		
		local foundval = tab[val]
		local foundsubval = nil
		if foundval == nil then foundval = BaseABP.t.BulletTable[val] end
		if subval then
			if tab[val] then foundsubval = tab[val][subval] end
			if foundsubval == nil then foundsubval = BaseABP.t.BulletTable[val][subval] end
			foundsubval(args)
		end
		foundval(args)
	end
end

function SWEP:DoCustomMeleeImpact(att, tr)
end

function SWEP:DoCustomOverchargeAttackEvents()
end

function SWEP:PassToProjectile(ent)
end

function SWEP:DoCustomBulletImpact(pos, normal, dmg)
end