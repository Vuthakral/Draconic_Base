AddCSLuaFile()

SWEP.ChargeValue = 0
function SWEP:GetCharge()
	return self:GetNWInt("Charge")
end

function SWEP:GetMaxCharge() return 100 end

function SWEP:SetCharge(val)
	self:SetNWInt("Charge", val)
end

function SWEP:AddCharge(val)
	self:SetNWFloat("Charge", math.Clamp(self:GetCharge() + val, 0, 100))
end

function SWEP:SubCharge(val)
	self:SetNWFloat("Charge", math.Clamp(self:GetCharge() - val, 0, 100))
end

SWEP.HeatValue = 0
function SWEP:GetHeat()
	return self:GetNWFloat("Heat")
end

function SWEP:GetMaxHeat() return 100 end

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

function SWEP:SetThirdpersonFreelookForced(b)
	if SERVER then 
		self:CallOnClient("SetThirdpersonFreelookForced", "fuckyou ".. tostring(b) .."")
		self:SetNW2Bool("ThirdpersonForceFreelook", b)
	end
	b = tobool(b)
	timer.Simple(0.1, function() if IsValid(self) then self.ThirdpersonForceFreelook = self:GetNW2Bool("ThirdpersonForceFreelook") end end)
end

function SWEP:CanCustomize(bypassinspect)
	if self.IsMelee == true then return false end
	if DRC.SV.drc_attachments_disallowmodification == 1 then return false end
	if self:GetNWBool("Inspecting", false) == false && bypassinspect != true then return false end
	
	local cando = true
	for k,v in pairs(self.AttachmentTable) do
		if k != "BaseClass" then
			if #v <= 1 then cando = false end
		end
	end
	return cando
end

SWEP.InspectionToggleCD = 0
function SWEP:ToggleInspectMode()
	if CurTime() < self.InspectionToggleCD then return end
	self.InspectionToggleCD = CurTime() + 0.1
	local ply = self:GetOwner()
	
	if DRC.SV.drc_inspections == 0 then return end
	
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
				self:SetClip1(self:GetLoadedAmmo())
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
		
		if self:GetLoadedAmmo() >= 0 then
			if self.Primary.UsesCharge == true then
				if m1d && self:CanPrimaryAttack() && (self:GetNWBool("Passive") == false && self.ManuallyReloading == false) && !ukd then self:SetCharge(math.Clamp( self:GetCharge() + self.ChargeRate, 0, 100))
				else self:SetCharge(math.Clamp( self:GetCharge() - self.ChargeRate * 10, 0, 100)) end
			else end
			
			if self.Secondary.UsesCharge == true then
				if m2d && self:CanSecondaryAttack() && (self:GetNWBool("Passive") == false && self.ManuallyReloading == false) && !ukd then self:SetCharge(math.Clamp( self:GetCharge() + self.ChargeRate, 0, 100))
				else self:SetCharge(math.Clamp( self:GetCharge() - self.ChargeRate * 10, 0, 100)) end
			else end
			
			if self:GetCharge() >= 101 then
				self.ChargeValue = 100
			end
			
			if self:GetCharge() > 99 then
				self:SetLoadedAmmo(self:GetLoadedAmmo() - self.ChargeHoldDrain)
				self:SetClip1( self:GetLoadedAmmo() )
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
	["swimidle"] = 0,
	["swimming"] = 0.1,
}
local bloom_maximums = {
	["standidle"] = 1,
	["crouchidle"] = 1,
	["running"] = 1.3,
	["crouchrunning"] = 1.3,
	["sprinting"] = 1.7,
	["crouchingsprinting"] = 1.7,
	["swimidle"] = 0.9,
	["swimming"] = 1.1,
}

function SWEP:UpdateBloom(mode)
	local ply = self:GetOwner()
	local oa, cv, bs, pbs, mul = self.OwnerActivity, ply:Crouching(), self:GetBS(), self:GetPBS(), 1
	if cv then mul = 0.5 end
	
	local kickmodes = { -- defined in here in case anyone codes custom kick modifiers; though don't rely on these as this'll need to be changed later for attachment base integration.
		["primary"] = self.Primary.Kick,
		["secondary"] = self.Secondary.Kick,
		["overcharge"] = self.OCKick
	}
	self.Kick = kickmodes[mode]
	
	self.PrevBS = math.Clamp(bs, 0, bloom_maximums[oa])
	self.BloomValue = math.Clamp((self.BloomValue + bloom_updates[oa] + self.Kick) * mul, 0, bloom_maximums[oa])
end

function SWEP:GetBS()
	return self.BloomValue
end

function SWEP:GetPBS()
	return self.PrevBS
end

--[[
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
		timer.Create( "".. tostring(self) .."_SwingImpact_".. i .."", math.Round((settings[mode]["delayinitial"] * 100) / 60 * i / 60, 3), 1, function()
			if !IsValid(self) then return end
			if !IsValid(self:GetOwner()) then return end
			self:MeleeImpact(settings[mode]["range"], Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), x1m, x2m), Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), y1m, y2m), i, mode)
		end)
	end
end
]]

function SWEP:DoMeleeSwing(swinginfo, preventanim)
	if !self:CanMelee() then return false end
	if !swinginfo or !istable(swinginfo) then return end
	local ply, dur = self:GetOwner(), nil
	local ct = CurTime()

	if !self.MeleeQueue then self.MeleeQueue = {} end
	self.IsDoingMelee = true
	if swinginfo.anim_fp_miss != nil then
	--	self.Loading = true
		--self:SendWeaponAnim(swinginfo.anim_fp_miss)
		self:PlayAnim(swinginfo.anim_fp_miss, false, true)
	--	local anim = self:SelectWeightedSequence(swinginfo.anim_fp_miss)
	--	local dur = self:SequenceDuration(anim)
	--	self.IdleTimer = CurTime() + dur
	end

	if swinginfo.anim_tp != nil && preventanim != true then
		DRC:CallGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, swinginfo.anim_tp, true)
	end
	
	local delay = swinginfo.delay
	if CLIENT or (SERVER && !game.IsDedicated()) && swinginfo.screenshake[1] == true then
		ply:ViewPunch(Angle(swinginfo.y[1], swinginfo.x[1], nil) * -0.1 * swinginfo.screenshake[2])
		ply:SetViewPunchVelocity(Angle(-swinginfo.x[1] * (1 + delay[1]) * swinginfo.screenshake[2], -swinginfo.y[1] * (5 + delay[1]) * swinginfo.screenshake[2], 0))
		timer.Simple(.1, function()
			if !IsValid(self) then return end
			if !IsValid(self:GetOwner()) then return end
			ply:ViewPunch(Angle(swinginfo.y[1], swinginfo.x[1], nil) * 0.1 * swinginfo.screenshake[2])
		end)
	end
	
	for i=1,(math.Round(1/ engine.TickInterval() - 1 , 0)) do
		if !IsValid(self) then return end
		if !IsValid(ply) then return end
		local thyme = ct + (swinginfo.delay[3] * 100) / 60 * i / 60
		self.MeleeQueue[i] = {thyme, swinginfo}	
	end

	if IsFirstTimePredicted() then self:EmitSound(swinginfo.sound or "") end
	self:SetNextPrimaryFire(ct + swinginfo.delay[2])
	self:SetNextSecondaryFire(ct + swinginfo.delay[2])
	
	if swinginfo.lunge && swinginfo.lunge[1] == true then
		local target = self:GetConeTarget()
		if target then
			if ply:GetPos():Distance(target:GetPos()) < self.Primary.LungeMaxDist then
				ply:SetLocalVelocity(ply:GetForward() * 8 * ply:GetPos():Distance(target:GetPos()))
			end
		end
	end
end

--[[
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
			damageinfo:SetDamageForce(Vector())
			
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
]]

function SWEP:ClearMeleeQueue()
	self.MeleeQueue = {}
	self.IsDoingMelee = false
--	self.Loading = false
end

function SWEP:ClearBurstQueue()
	self.BurstQueue = {}
	self.Bursting = false
end

SWEP.LastMeleeImpactTime = 0
function SWEP:MeleeImpactSound(drcsnd, sprop, pos)
--	if self.LastMeleeImpactTime + 0.2 > CurTime() then return end
	if CLIENT or game.SinglePlayer() then
		local snd, oversnd = drcsnd, nil
		if DRC.MaterialSounds[snd] then snd, oversnd = DRC:GetMaterialSound(snd, sprop) end
		sound.Play(snd, pos)
	--	EmitSound(snd, pos, self:EntIndex())
		if oversnd then sound.Play(oversnd, pos) end
	end
end

function SWEP:TriggerCustomImpact(att, tr)
	if att.trigger == 1 then att = "primary"
	elseif att.trigger == 2 then att = "secondary"
	elseif att.trigger == 3 then att = "lungeprimary" end
	self:DoCustomMeleeImpact(att, tr)
end

function SWEP:MeleeImpact(swinginfo, x, y, i)
	if !IsValid(self) then return end
	if table.IsEmpty(self.MeleeQueue) or #self.MeleeQueue == 0 then return end
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	local modinfo = table.Copy(swinginfo)
	local vm = nil
	local eyeang = ply:EyeAngles()
	local eyepos = ply:EyePos()
	local centerpos = ply:GetPos() + ply:OBBCenter()
	local aimpos = ply:GetPos() + Vector(ply:OBBCenter().x, ply:OBBCenter().y, ply:OBBCenter().z * 1.4)
	local velang, rangemul = DRC:GetVelocityAngle(ply, true, true), 1
	local ct = CurTime()
	
	if ply:IsPlayer() then
		vm = ply:GetViewModel()
		rangemul = math.Clamp((ply:GetWalkSpeed()/100 * (ply:GetWalkSpeed()/100)*0.5) * velang.y / 180, 1, 2.5)
	else
		rangemul = 2
	end
	
	local rhm = math.Round(1 / engine.TickInterval() - 1, 0)*0.5
	if i < rhm then
		modinfo.bulletrange = (swinginfo.range * ( i / 10)) * rangemul
		modinfo.range = eyepos + ( ply:GetAimVector() * swinginfo.range * ( i / 10) ) * rangemul
	elseif i == rhm then
		modinfo.bulletrange = (swinginfo.range * 3.4) * rangemul
		modinfo.range = eyepos + ( ply:GetAimVector() * swinginfo.range * 3.4 ) * rangemul
	elseif i > rhm then
		modinfo.bulletrange = (swinginfo.range / (i / 100)) * rangemul
		modinfo.range = eyepos + ( ply:GetAimVector() * swinginfo.range / (i / 100) ) * rangemul
	end
	local rangedlvl = swinginfo.range * rangemul
	
	local WhyDoesVJAimUpwards = Vector()
	if ply.IsVJBaseSNPC then WhyDoesVJAimUpwards = Vector(0 ,0, -40) end
	
	if ply:IsPlayer() then ply:LagCompensation(true) end
	local swingtrace = util.TraceLine({
		["start"] = aimpos,
		["endpos"] = modinfo.range + ((eyeang:Up()*y) + (eyeang:Right()*x) + WhyDoesVJAimUpwards),
		["filter"] = {self, ply},
		["mask"] = MASK_PLAYERSOLID
	})
	self:SetNextPrimaryFire( ct + swinginfo.delay[1] )
	self:SetNextSecondaryFire( ct + swinginfo.delay[1] )
	
	if swingtrace.Hit then 
		self:ClearMeleeQueue()
		if swinginfo.decals[1] then util.Decal(swinginfo.decals[1], swingtrace.HitPos + swingtrace.HitNormal, swingtrace.HitPos - swingtrace.HitNormal) end
		if swinginfo.decals[2] then util.Decal(swinginfo.decals[2], swingtrace.HitPos + swingtrace.HitNormal, swingtrace.HitPos - swingtrace.HitNormal) end
		
		self:MeleeImpactSound(swinginfo.hitsound, swingtrace.SurfaceProps, swingtrace.HitPos)
		
		self:TriggerCustomImpact(swinginfo, swingtrace)
	else
		self:SetNextPrimaryFire( ct + swinginfo.delay[2] )
		self:SetNextSecondaryFire( ct + swinginfo.delay[2] )
	end
	
	local btrace = {}
	btrace.Damage = swinginfo.damage[1]
	btrace.Spread = Vector()
	btrace.Force = 100
	btrace.HullSize = 10
	btrace.Num = 1
	btrace.IgnoreEntity = ply
	btrace.TracerName = nil
	btrace.Tracer = 0
	btrace.Dir = swingtrace.Normal
	btrace.Distance = modinfo.bulletrange
	btrace.Src = aimpos
	btrace.Callback = function(ent, tr, damageinfo)
		damageinfo:SetDamageCustom(2221208)
		damageinfo:SetAttacker(ply)
		damageinfo:SetDamageForce(Vector())
		self.LastMeleeDamage = damageinfo:GetDamage()
		if tr.Hit then
			tr.HitGroup = 0
			if !game.SinglePlayer() && SERVER then self:ClearMeleeQueue() end
			self.LastMeleeImpactTime = ct
			self:SetNextPrimaryFire( ct + swinginfo.delay[1] )
			self:SetNextSecondaryFire( ct + swinginfo.delay[1] )
			if swinginfo.anim_fp != nil then
				self:PlayAnim(swinginfo.anim_fp, false, true)
			end
			--self:MeleeImpactSound(swinginfo.hitsound, swingtrace.SurfaceProps, swingtrace.HitPos)
			
			self:TriggerCustomImpact(swinginfo, tr)
			
			local forcetrace = util.TraceLine({
				start = tr.HitPos,
				endpos = modinfo.range + ((eyeang:Up()*swinginfo.y[2]) + (eyeang:Right()*swinginfo.x[2]) + WhyDoesVJAimUpwards),
				filter = function(ent) return false end,
			})
			local forceangle = forcetrace.Normal
			local forceval = forceangle * swinginfo.damage[3] * 15
			if i < rhm then
				forceval = forceval * i
				--tr.Entity:GetPhysicsObject():ApplyForceOffset( forceangle * swinginfo.damage[3] * 15 * i, tr.HitPos )
			--elseif i == rhm then	
				--tr.Entity:GetPhysicsObject():ApplyForceOffset( forceangle * swinginfo.damage[3] * 15 * i, tr.HitPos )
			elseif i > rhm then
				forceval = forceval * (i*0.1)
				--tr.Entity:GetPhysicsObject():ApplyForceOffset( forceangle * swinginfo.damage[3] * 15 * ( i / 10 ), tr.HitPos )
			end
			
			if IsValid(tr.Entity) && DRC:IsCharacter(tr.Entity) then
			elseif tr.Entity:IsValid() and ( !tr.Entity:IsNPC() or !tr.Entity:IsPlayer() ) && !tr.Entity:IsNextBot() && IsValid(tr.Entity:GetPhysicsObject()) then
				tr.Entity:GetPhysicsObject():ApplyForceOffset( forceval, tr.HitPos )
				
				if SERVER && DRC:Health(tr.Entity) > 0 then tr.Entity:TakeDamage(swinginfo.damage[1], ply, ply:GetActiveWeapon()) end
	--		elseif tr.Entity:IsWorld() then		
			end
	
			DRC:RenderTrace(tr, Color(255, 0, 0, 255), 1)
		end
		return true
	end
	
	if !game.IsDedicated() && SERVER then -- In singleplayer we don't have to rely on lag compensation, plus it breaks impact effects.
		if swingtrace.Hit then self:FireBullets(btrace) end
	else
		self:FireBullets(btrace)
	end
	
	if ply:IsPlayer() then ply:LagCompensation(false) end
	if !swingtrace.Hit && ((game.SinglePlayer() && SERVER) or CLIENT) then
		DRC:RenderTrace(swingtrace, Color(255, 255, 255, 255), 1)
	end
end

function SWEP:TakePrimaryAmmo(num)
	if !SERVER then return end
	local ply = self:GetOwner()
	
	if DRC.SV.drc_infiniteammo == 2 then return end
	
	if self:Clip1() == 0 && ply:IsPlayer() then
		if self:Clip1() == 0 then return end
		ply:RemoveAmmo( num, self:GetPrimaryAmmoType() )
	return end
	self:SetClip1(self:GetLoadedAmmo())
end

function SWEP:TakeSecondaryAmmo( num )
	if !SERVER then return end
	local ply = self:GetOwner()
	
	if DRC.SV.drc_infiniteammo == 2 then return end

	if self:Clip2() <= 0 && ply:IsPlayer() then
		if self:Ammo2() <= 0 then return end
		ply:RemoveAmmo( num, self:GetSecondaryAmmoType() )
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
	
	force = force * self:GetAttachmentValue("Ammunition", "Force")
	
	if self.Primary.Tracer == nil then
		tracer = self:GetAttachmentValue("Ammunition", "Tracer")
	end
	
	if CLIENT then tracer = 0 end
	
	local bullet = {}
	bullet.Num = num
	bullet.Src = ply:GetShootPos()
	bullet.Dir = ply:GetAimVector()
	bullet.Tracer = tracer
	bullet.Force = force
	bullet.Damage = damage
	bullet.Spread = cone
	bullet.HullSize = self:GetAttachmentValue("Ammunition", "HullSize") or 1
	bullet.Callback = function(ent, tr, takedamageinfo) -- https://imgur.com/a/FCDZOEx
		if IsValid(self) then
			if !tr.Entity:IsWorld() then
				if SERVER then DRC:RenderTrace(tr, Color(255, 0, 0, 255), 1) end
			else
				if SERVER then DRC:RenderTrace(tr, Color(255, 255, 255, 255), 1) end
			end
		
			takedamageinfo:SetAttacker(self:GetOwner())
			takedamageinfo:SetInflictor(self)
			takedamageinfo:SetDamageType( self:GetAttachmentValue("Ammunition", "DamageType") )
			if tr.Contents == 1 && DRC:IsCharacter(tr.Entity) then takedamageinfo:SetDamage(takedamageinfo:GetDamage() * self:GetAttachmentValue("Ammunition", "HullDamage")) end
			
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
						dinfo:SetDamage( (bullet.Damage * self:GetAttachmentValue("Ammunition", "SplashDamageMul")) / ((v:GetPos() + v:OBBCenter()):DistToSqr(tr.HitPos) / 50) )
						if v:IsValid() then
							v:TakeDamageInfo(dinfo)
						end
						
						if self:GetAttachmentValue("Ammunition", "SplashDoBlast") == true then
							local tr2 = util.TraceLine({
								start = tr.HitPos,
								endpos = v:GetPos() + v:OBBCenter(),
								filter = function(ent) if ent != v then return false else return true end end
							})
							local dir, pos = tr2.Normal:Angle():Forward() * 500, tr2.HitPos
							
							if DRC:IsCharacter(v) then v:SetVelocity(dir*takedamageinfo:GetDamage()/(v:OBBCenter()):Distance(pos) * 50) end
							if v.GetPhysicsObject && IsValid(v:GetPhysicsObject()) then v:GetPhysicsObject():AddVelocity(dir*takedamageinfo:GetDamage()/(v:OBBCenter()):Distance(pos) * 50) end
						end
					end
				end
			end

			if self:GetAttachmentValue("Ammunition", "ImpactDecal") != nil && SERVER then
				util.Decal( self:GetAttachmentValue("Ammunition", "ImpactDecal"), tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal, {self, ply})
			end
			
			if self:GetAttachmentValue("Ammunition", "BurnDecal") != nil && SERVER then
				util.Decal( self:GetAttachmentValue("Ammunition", "BurnDecal"), tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal, {self, ply})
			end
			
			self:RunAttachmentFunction("Ammunition", "Callback", nil, {ent, tr, takedamageinfo})
			self:DoCustomBulletImpact(tr.HitPos, tr.Normal, takedamageinfo)
			
			if tr.Hit && !tr.Entity:IsPlayer() && self.Primary.Tracer == 0 then
				local tr2 = util.TraceHull({
					start = ply:GetShootPos(),
					endpos = ply:GetShootPos() + ( ply:GetAimVector() * 56756 ),
					filter = function(ent) if ent == ply then return false elseif ent:IsPlayer() then return true end end,
					mins = Vector( -20, -20, -20 ),
					maxs = Vector( 20, 20, 20 ),
					mask = MASK_SHOT
				})
				if tr2.Hit && tr2.Entity && tr2.Entity:IsPlayer() then
					local rng = tr2.Entity:EyeAngles():Right() * math.Rand(-15,15)
					DRC:EmitSound(tr2.HitPos + rng, self.Primary.SoundTable.NearMiss, nil, 100, nil, tr2.Entity)
				end
			end
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
	local calc = stats.PreCalcSpread * self.AttachmentStats.PreCalcSpread
	
	local x, y = calc * stats.SpreadX, calc * stats.SpreadY
	
	if isprojectile == false then
		if ply:IsPlayer() then
			return (Vector( x, y, 0 ) * self.BloomValue) * SpreadMod
		elseif ply:IsNPC() or ply:IsNextBot() then
			return (Vector(x, y, calc))
		end
	else
		return (Vector( x, y, 0 ) * self.BloomValue / 2) * SpreadMod -- This isn't perfectly accurate to the spread cone but what the fuck ever, it's close enough.
	end
end

function SWEP:SetLoadedAmmo(amount)
	if !IsValid(self) then return end
	if CLIENT then return end
	local inf = DRC.SV.drc_infiniteammo
	if inf > 1 then return end
	if inf > 0 && self.IsBatteryBased == true then return end
	self:SetNWFloat("LoadedAmmo", amount)
	self:SetClip1(amount)
end

function SWEP:GetLoadedAmmo()
	if !IsValid(self) then return end
	return self:GetNWFloat("LoadedAmmo", self:Clip1())
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
	local m2
	if mode == "primary" then
		if sd && ironseq != -1 then fireseq = ironseq end
		firetime = self:SequenceDuration(fireseq)
		m2 = "Primary"
	elseif mode == "secondary" then
		firetime = self:SequenceDuration(fireseq2)
		m2 = "Secondary"
	elseif mode == "overcharge" then
		firetime = self:SequenceDuration(fireseq3)
	end
	self.IdleTimer = CurTime() + firetime
	self.LastFireTime = CurTime()
	self.LastFireAnimTime = CurTime() + firetime
	
	local function GetProjectile()
		if AA.AmmunitionTypes.t.ClassName == IA.AmmunitionTypes[1] then return stats.Projectile
		else return AA.AmmunitionTypes.t.BulletTable.ProjectileOverride or stats.Projectile end
	end
	
	local function GetSpeed()
		if AA.AmmunitionTypes.t.ClassName == IA.AmmunitionTypes[1] then return stats.ProjSpeed
		else return AA.AmmunitionTypes.t.BulletTable.ProjectileSpeed or stats.ProjSpeed end
	end
	
	local projectile = GetProjectile()
	local speeeeed = GetSpeed()
	
	local shotnum = self:GetAttachmentValue("Ammunition", "NumShots")
	if mode == "primary" then
		if ply:IsPlayer() then
			self:UpdateBloom("primary")
		--	if game.SinglePlayer() then self:CallOnClient( "UpdateBloom", "primary") end
		end
		
		if self.Base == "draconic_gun_base" then
			if stats != self.OCStats then
				self:SetLoadedAmmo(math.Clamp((self:GetLoadedAmmo() - stats.APS), 0, (self.Primary.ClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))))
			else
				self:SetLoadedAmmo(math.Clamp((self:GetLoadedAmmo() - stats.OCAPS), 0, (self.Primary.ClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))))
			end
			self:TakePrimaryAmmo( stats.APS )
		elseif self.Base == "draconic_battery_base" then
			if stats != self.OCStats then
				self:SetLoadedAmmo(math.Clamp((self:GetLoadedAmmo() - batstats.BatteryConsumePerShot), 0, self.Primary.ClipSize))
			else
				self:SetLoadedAmmo(math.Clamp((self:GetLoadedAmmo() - stats.APS), 0, self.Primary.ClipSize))
			end
			self:TakePrimaryAmmo( batstats.BatteryConsumePerShot )
		end
	elseif mode == "secondary" then
		if ply:IsPlayer() then
			self:UpdateBloom("secondary")
		--	if game.SinglePlayer() then self:CallOnClient( "UpdateBloom", "secondary") end
		end
		
		self:TakeSecondaryAmmo( stats.APS )
	elseif mode == "overcharge" then
		if ply:IsPlayer() then
			self:UpdateBloom("overcharge")
		--	if game.SinglePlayer() then self:CallOnClient( "UpdateBloom", "overcharge") end
		end
		
		self.ChargeValue = 0
		shotnum = self:GetAttachmentValue("Ammunition", "NumShots_OC")
		
		if self.Base == "draconic_gun_base" then
			if stats != self.OCStats then
				self:SetLoadedAmmo(math.Clamp((self:GetLoadedAmmo() - stats.APS), 0, (self.Primary.ClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))))
			else
				self:SetLoadedAmmo(math.Clamp((self:GetLoadedAmmo() - stats.APS), 0, (self.Primary.ClipSize * self:GetAttachmentValue("Ammunition", "ClipSizeMul"))))
			end
			self:TakePrimaryAmmo( stats.APS )
		elseif self.Base == "draconic_battery_base" then
			if stats != self.OCStats then
				self:SetLoadedAmmo(math.Clamp((self:GetLoadedAmmo() - batstats.BatteryConsumePerShot), 0, self.Primary.ClipSize))
			else
				self:SetLoadedAmmo(math.Clamp((self:GetLoadedAmmo() - stats.APS), 0, self.Primary.ClipSize))
			end
			self:TakePrimaryAmmo( batstats.BatteryConsumePerShot )
		end
	end
	
	if stats.HealthPerShot != 0 && ply.SetHealth then
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
	
	if stats.ArmourPerShot != 0 && ply.SetArmor then
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
				if sd && ironseq != -1 then self:PlayAnim(ACT_VM_DEPLOYED_IRON_FIRE, true) else self:PlayAnim(ACT_VM_PRIMARYATTACK, true) end
			elseif mode == "secondary" then
				self:PlayAnim(ACT_VM_SECONDARYATTACK, true)
			elseif mode == "overcharge" then
				if fireseq3 == -1 then
					self:PlayAnim(ACT_VM_PRIMARYATTACK, true)
				else
					self:PlayAnim(ACT_SPECIAL_ATTACK1, true)
				end
			end
		end
		ply:SetAnimation( PLAYER_ATTACK1 )
	else end
	
	if ply.DraconicNPC && ply:DraconicNPC() == true then
		local holdtype = string.lower(self:GetHoldType())
		local act = DRC.HoldTypes[holdtype].attack
		DRC:CallGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, act, true)
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
		self:SetNextPrimaryFire( CurTime() + stats.PreCalcRPM )
	end
	
	if self.Primary.isvFire == true then
		self:ShootFire() 
	return end
	
	if projectile == nil then
		local spr = self:CalculateSpread(false)
		if self.PreventAllBullets == true then return end
		if ply:IsPlayer() then ply:LagCompensation(true) end
		if self.PreventAllBullets == false then self:ShootBullet(stats.Damage, shotnum, spr, stats.Ammo, stats.Force, stats.Tracer) end
		if ply:IsPlayer() then ply:LagCompensation(false) end
	elseif mode == "secondary" && self.Projectile == "scripted" then
		timer.Simple(self.Secondary.ProjectileSpawnDelay, function()
			self:DoScriptedSecondaryAttack()
			self:EmitSound(self.Secondary.Sound)
			ply:SetAnimation( PLAYER_ATTACK1 )
			self:PlayAnim( ACT_VM_SECONDARYATTACK, true )
		end)
	else
		if SERVER then
			local muzzleattachment = self:LookupAttachment("muzzle")
			local muzzle = self:GetAttachment(muzzleattachment)
			local Valve = DRC:ValveBipedCheck(ply)
			local ptu
			if Valve then ptu = ply:GetBonePosition(RightHand) else eyeheight = ply:EyePos().z - ply:GetPos().z ptu = ply:GetPos() + Vector(0, 0, eyeheight/1.1) + ply:EyeAngles():Forward() * 10 + ply:EyeAngles():Right() * 5 end
			
			for i=1,shotnum do
				local class = ""
				if istable(stats.Projectile) then class = stats.Projectile[math.Round(math.Rand(1, #stats.Projectile))] else class = projectile end
				if IsValid(class) && class != "" then return false end
				
				local SpreadCalc = self:CalculateSpread(true) * self.BloomValue
				local AmmoSpread = ((stats.Spread * self:GetAttachmentValue("Ammunition", "Spread")) / (stats.SpreadDiv * self:GetAttachmentValue("Ammunition", "SpreadDiv"))) * 1000 * self.BloomValue
				local FinalSpread = Angle(math.Rand(SpreadCalc.x, -SpreadCalc.x) * AmmoSpread, math.Rand(SpreadCalc.y, -SpreadCalc.y) * AmmoSpread, 0) * self.BloomValue + stats.MuzzleAngle
				local projang = FinalSpread
				local projpos = ptu
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
				end

				local dir = ply:GetAimVector():Angle()
				if ply:IsPlayer() then
					local tr2 = ply:GetEyeTrace()
					local tr3 = util.TraceLine({
						start = ptu,
						endpos = tr2.HitPos + ply:EyeAngles():Forward() * 100,
						filter = function(ent) if ent != tr2.Entity or tr2.Entity:GetClass() == class then return false else return true end end,
					})
					dir = tr3.Normal:Angle()
				end
				
				projang = projang + dir
				
				local function SpawnProj()
					local proj = DRC:CreateProjectile(class, projpos, projang, speeeeed, ply, stats.ProjInheritVelocity)
					self:PassToProjectile(proj)
					if !self.PTable then self.PTable = {} end
					if proj.Draconic == true then table.insert(self.PTable, proj) end
				end
				
				if m2 then
					local delay = self[m2].ProjSpawnDelay or 0
					timer.Simple(delay, function()
						if IsValid(self) then
							SpawnProj()
						end
					end)
				else
					SpawnProj()
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
	
--[[	if ply:IsNextBot() then -- Iv04 Nextbot handling
		if ply.IV04NextBot != true then return end
		if self.NPCBursting == true then return end
		
		local rpm = self.Primary.RPM
		local fm = self:GetNWString("FireMode")
	end ]]
end

function SWEP:DoEffects(mode, nosound, multishot)
	if !IsValid(self) then return end
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	local muzzleattachment = self:LookupAttachment("muzzle")
	local muzzle = self:GetAttachment(muzzleattachment)
	local fm = self:GetNWString("FireMode")
	
	local ttu = nil
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
			ttu = self.Primary.SoundTable.Burst or self.Primary.SoundTable.Semiauto
			self.Sound = ttu.Near
			self.DistSound = ttu.Far
			self.SoundDistance = ttu.FarDistance
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
	
	if self.ActiveAttachments.AmmunitionTypes.t.ClassName != self.AttachmentTable.AmmunitionTypes[1] then
		self.TracerEffect = self:GetAttachmentValue("Ammunition", "TracerOverride") or self.TracerEffect
	end
	
	local effectdata = EffectData()
	
	if SERVER && self.StatsToPull.Projectile == nil && self.vFire == false then
		if self.LastHitPos == nil then self.LastHitPos = Vector(0, 0, 0) end
		effectdata:SetOrigin( self.LastHitPos )
	else
		if self.LastHitPos then effectdata:SetOrigin( self.LastHitPos ) end
	end

	if self.SightsDown == false then
		effectdata:SetAttachment( muzzleattachment )
	elseif self.SightsDown == true && self.Secondary.Scoped == true then
		effectdata:SetStart( ply:EyePos() + Vector(0, 0, -2) )
		effectdata:SetAttachment( -1 )
	end
	
	effectdata:SetEntity(self)
	if self.TracerEffect != nil && effectdata != nil then
		if CLIENT then
			local effe = {
				["muzzle"] = {self.TracerEffect, 0},
			}
			self:EffectChain(effe, effectdata)
		elseif SERVER && self:GetOwner() != Entity(1) then -- fucking singleplayer
			util.Effect(self.TracerEffect, effectdata)
		end
	end
		
	if self.Primary.UsesCharge == true or self.Secondary.UsesCharge == true && self:CanOvercharge() then
		if self.OCTracerEffect != nil then util.Effect( self.OCTracerEffect, effectdata ) end
	end
	
	if !IsFirstTimePredicted() or nosound == true or self.BurstSound == true then return end
	if mode == "primary" && fm == "Burst" && ttu.Single == false then
		local thyme = self.PrimaryStats.PreCalcRPM*self.FireModes_BurstShots + 0.01
		self.BurstSound = true
		timer.Simple(CurTime() - self:GetNextPrimaryFire() + thyme, function() self.BurstSound = false end)
	end
	
	if self.Primary.SoundTable.Envs then
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
			ttu = self.Primary.SoundTable.Envs[RoomType].Burst or self.Primary.SoundTable.Envs[RoomType].Semiauto
			self.Sound = ttu.Near
			self.DistSound = ttu.Far
		end
	end
	end
	
	if CLIENT && !game.SinglePlayer() && self.Sound then
		self:EmitSound(self.Sound)
	end
	
	-- Distant sounds have to be networked because their origin doesn't actually exist on the client when outside the PVS
	if (game.SinglePlayer() or CLIENT) && GetConVar("cl_drc_debugmode"):GetFloat() > 0 then
		if GetConVar("cl_drc_debug_invertnearfar"):GetFloat() >= 1 then
			DRC:EmitSound(self, self.DistSound, self.DistSound, self.SoundDistance, SOUND_CONTEXT_GUNFIRE)
		else
			DRC:EmitSound(self, self.Sound, self.DistSound, self.SoundDistance, SOUND_CONTEXT_GUNFIRE)
		end
	else
		DRC:EmitSound(self, self.Sound, self.DistSound, self.SoundDistance, SOUND_CONTEXT_GUNFIRE)
	end
	local asndnear, asndfar = self:GetAttachmentValue("Ammunition", "AdditiveSoundNear"), self:GetAttachmentValue("Ammunition", "AdditiveSoundFar")
	if !asndnear then asndnear = "" end
	if !asndfar then asndfar = "" end
	
	if CLIENT && !game.SinglePlayer() && asndnear then
		self:EmitSound(asndnear)
	end
	
	DRC:EmitSound(self, asndnear, asndfar, self.SoundDistance, SOUND_CONTEXT_GUNFIRE)
end

function SWEP:DoRecoil(mode)
	if !game.SinglePlayer() && !IsFirstTimePredicted() then return end
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	if !ply:IsPlayer() then return end
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
	if !game.SinglePlayer() && SERVER then return end
	if self.PreventMuzzleFlash && self.PreventMuzzleFlash == true then return end
	local col = self:GetAttachmentValue("Ammunition", "MuzzleFlash", "Colour")
	local epileptic, mul = GetConVar("cl_drc_accessibility_photosensitivity_muzzle"):GetFloat(), 1
	if epileptic == 1 then mul = 0.25 end
		
	if self:GetAttachmentValue("Ammunition", "MuzzleFlash", "Dynamic") == true then
		DRC.CalcView.MuzzleLamp_Time = CurTime() + math.Rand(0.005, 0.01)
		local bright = (col.a/30) * (1 - math.Clamp(DRC.MapInfo.MapAmbientAvg, 0.15, 1)) * mul
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

function SWEP:CallShoot(mode, ignoreimpossibility, endburst)
	local ply = self:GetOwner()
	if ignoreimpossibility == nil then ignoreimpossibility = false end
	local forcesprint = DRC.SV.drc_force_sprint >= 1
	
	if endburst == true then self:ClearBurstQueue() end
	
	if mode == "primary" then
		if ply:IsPlayer() then
			if ignoreimpossibility != true && !self:CanPrimaryAttack() then return end
		end
		if ply:IsNPC() then
			if ignoreimpossibility != true && !self:CanPrimaryAttackNPC() then return end
		end
		
		if ignoreimpossibility && self:GetFireMode() == 3 then
			if ply:IsPlayer() && (self.DoesPassiveSprint == true or forcesprint) && (ply:KeyDown(IN_SPEED) && (ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK) or ply:KeyDown(IN_LEFT) or ply:KeyDown(IN_RIGHT))) then return end
			if self:GetLoadedAmmo() <= 0 then
				if CurTime() > self:GetNextPrimaryFire() then self:EmitSound (self.Primary.EmptySound) end
				self:SetNextPrimaryFire(CurTime() + self.PrimaryStats.PreCalcRPM * 2) return
			elseif self:GetNWBool("Passive") == true or self:GetNWBool("Inspecting") == true then
			return end
		end
		self.StatsToPull = self.PrimaryStats
		self:DoShoot("primary")
		self:DoEffects("primary")
		self:DoRecoil("primary")
		self:ShootEffects()
		
		if IsValid(self) && self:GetLoadedAmmo() > -0.01 then self:DoCustomPrimaryAttackEvents() end
	elseif mode == "secondary" then
		if ignoreimpossibility != true && !self:CanSecondaryAttack() then return end
		self.StatsToPull = self.SecondaryStats
		self:DoShoot("secondary")
		self:DoEffects("secondary")
		self:DoRecoil("secondary")
		
		if IsValid(self) && self:GetLoadedAmmo() > -1 then self:DoCustomSecondaryAttackEvents() end
	elseif mode == "overcharge" then
		if ply:IsPlayer() then
			if ignoreimpossibility != true && !self:CanPrimaryAttack() then return end
		else
			if ignoreimpossibility != true && !self:CanPrimaryAttackNPC() then return end
		end
		self.StatsToPull = self.OCStats
		self:DoShoot("overcharge")
		self:DoEffects("overcharge")
		self:DoRecoil("overcharge")
		
		if IsValid(self) && self:GetLoadedAmmo() > 0 then self:DoCustomOverchargeAttackEvents() end
	end
end

function SWEP:GetMovementValues()
	if DRC.SV.drc_movement == 0 then return end
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

local BaseABP = scripted_ents.GetStored("drc_abp_generic")
function SWEP:GetAttachmentValue(att, val, subval)
	if !BaseABP then BaseABP = scripted_ents.GetStored("drc_abp_generic") end
	local AA = self.ActiveAttachments
	if !AA then return nil end
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