SWEP.Base = "draconic_melee_base"

SWEP.Category			= "Draconic Base Tools"
SWEP.PrintName			= "Unarmed"
SWEP.Author				= "Vuthakral"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.NPCSpawnable		= false
SWEP.CanStore			= false
SWEP.AutoSwitchTo		= true
SWEP.AutoSwitchFrom		= true

SWEP.Slot				= 0
SWEP.SlotPos			= 0

SWEP.ViewModel			= "models/vuthakral/drc_unarmed.mdl"
SWEP.ViewModelFOV		= 90
SWEP.VMPos				= Vector(0, 0, -5)
SWEP.VMAng				= Vector(5, 0, 0)
SWEP.SprintPos			= Vector(0, 0, 0)
SWEP.SprintAng			= Vector(0, 0, 0)
SWEP.PassivePos			= Vector(0, 0, 0)
SWEP.PassiveAng			= Vector(0, 0, 0)
SWEP.InspectPos			= Vector(0, 0, 0)
SWEP.InspectAng			= Vector(0, 0, 0)
SWEP.UseHands			= true

SWEP.InfoDescription = "When your rounds are spent, blades dull, and patience diminished;\nall you have left is your own two hands.\n\nRip and tear, until it is done."

SWEP.HoldType	= "normal"

SWEP.Primary.SwingSound			= Sound( "draconic.PunchFoley" )
SWEP.Primary.HitSound 			= "meleesoft"
SWEP.Primary.HoldType			= "fist"
SWEP.Primary.CrouchHoldType		= "melee"
SWEP.Primary.ImpactDecal 		= ""
SWEP.Primary.BurnDecal 			= ""
SWEP.Primary.Automatic			= false
SWEP.Primary.Damage				= 25
SWEP.Primary.DamageType			= DMG_CLUB
SWEP.Primary.Range				= 25
SWEP.Primary.Force				= 10
SWEP.Primary.DelayMiss			= 0.65
SWEP.Primary.DelayHit 			= 0.65
SWEP.Primary.CanAttackCrouched = true
SWEP.Primary.HitActivity		= nil
SWEP.Primary.CrouchHitActivity	= nil
SWEP.Primary.MissActivity		= ACT_VM_SECONDARYATTACK
SWEP.Primary.CrouchMissActivity	= ACT_VM_HITLEFT
SWEP.Primary.HitDelay			= 0.07
SWEP.Primary.StartX				= -50
SWEP.Primary.StartY				= 3
SWEP.Primary.EndX				= 50
SWEP.Primary.EndY				= -10
SWEP.Primary.ShakeMul			= 1

SWEP.Primary.CanLunge			= true
SWEP.Primary.LungeAutomatic		= false
SWEP.Primary.LungeRequiresTarget= false
SWEP.Primary.LungeVelocity		= 1000
SWEP.Primary.LungeMaxDist		= 100
SWEP.Primary.LungeSwingSound	= Sound( "draconic.PunchFoley" )
SWEP.Primary.LungeHitSound		= "meleehard"
SWEP.Primary.LungeHoldType		= "fist"
SWEP.Primary.LungeHoldTypeCrouch= "melee"
SWEP.Primary.LungeImpactDecal 	= ""
SWEP.Primary.LungeBurnDecal 	= ""
SWEP.Primary.LungeHitAct		= nil
SWEP.Primary.LungeMissAct		= ACT_VM_HITCENTER
SWEP.Primary.LungeMissActCrouch	= ACT_VM_HITCENTER2
SWEP.Primary.LungeDelayMiss		= 1.3
SWEP.Primary.LungeDelayHit		= 0.7
SWEP.Primary.LungeHitDelay		= 0.26
SWEP.Primary.LungeDamage		= 80
SWEP.Primary.LungeDamageType	= DMG_CLUB
SWEP.Primary.LungeRange			= 25
SWEP.Primary.LungeForce			= 5
SWEP.Primary.LungeStartX		= 7
SWEP.Primary.LungeStartY		= -20
SWEP.Primary.LungeEndX			= -5
SWEP.Primary.LungeEndY			= 3
SWEP.Primary.LungeShakeMul		= 1

SWEP.Secondary.SwingSound			= Sound( "draconic.PunchFoley" )
SWEP.Secondary.HitSound 			= "meleesoft"
SWEP.Secondary.HoldType				= "fist"
SWEP.Secondary.CrouchHoldType		= "melee"
SWEP.Secondary.ImpactDecal 			= ""
SWEP.Secondary.BurnDecal 			= ""
SWEP.Secondary.Automatic			= false
SWEP.Secondary.Damage				= 25
SWEP.Secondary.DamageType			= DMG_CLUB
SWEP.Secondary.Range				= 25
SWEP.Secondary.Force				= 10
SWEP.Secondary.DelayMiss			= 0.65
SWEP.Secondary.DelayHit 			= 0.65
SWEP.Secondary.CanAttackCrouched 	= true
SWEP.Secondary.HitActivity			= nil
SWEP.Secondary.CrouchHitActivity	= nil
SWEP.Secondary.MissActivity			= ACT_VM_PRIMARYATTACK
SWEP.Secondary.CrouchMissActivity	= ACT_VM_HITRIGHT
SWEP.Secondary.HitDelay				= 0.07
SWEP.Secondary.StartX				= 50
SWEP.Secondary.StartY				= 3
SWEP.Secondary.EndX					= -40
SWEP.Secondary.EndY					= -10
SWEP.Secondary.ShakeMul				= 1

-------------------------- Custom lua

function SWEP:DoCustomThink()
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	if !ply:IsPlayer() then return end
	local vm = ply:GetViewModel(0)
	if !IsValid(vm) then return end
	
	local cv = ply:Crouching()
	local ea = ply:EyeAngles()
	
	if ea.x > 55 then
		self.Primary.LungeMissAct = ACT_VM_HITCENTER2
		self.Primary.LungeStartX = 10
		self.Primary.LungeEndX = 5
		self.Primary.LungeStartY = 20
		self.Primary.LungeEndY = -20
		self.Primary.LungeForce = 10
		self.Primary.LungeDamage = 125
		self.Primary.LungeRange = 30
	else
		self.Primary.LungeMissAct = ACT_VM_HITCENTER
		self.Primary.LungeStartX = 7
		self.Primary.LungeEndX = -5
		self.Primary.LungeStartY = -20
		self.Primary.LungeEndY = 3
		self.Primary.LungeForce = 20
		self.Primary.LungeDamage = 80
		self.Primary.LungeRange = 25
	end
	
	if cv then
		self.Primary.StartX		= 45
		self.Primary.StartY		= 20
		self.Primary.EndX		= -45
		self.Primary.EndY		= -20
		self.Primary.Range		= 15
		
		self.Secondary.StartX	= -45
		self.Secondary.StartY	= 20
		self.Secondary.EndX		= 45
		self.Secondary.EndY		= -20
		self.Secondary.Range	= 15
	else
		self.Primary.StartX		= 50
		self.Primary.StartY		= 3
		self.Primary.EndX		= -50
		self.Primary.EndY		= -10
		self.Primary.Range		= 25
		
		self.Secondary.StartX	= -50
		self.Secondary.StartY	= 3
		self.Secondary.EndX		= 50
		self.Secondary.EndY		= -10
		self.Secondary.Range	= 25
	end
	
	if CLIENT then
		local kickanim = vm:LookupSequence("kick0")
		local kneeanim = vm:LookupSequence("curbstomp0")
		local seq = vm:GetSequence()
		if ply != LocalPlayer() then return end
		if !IsValid(self.CSPlayerModel) then
			self.CSPlayerModel = ents.CreateClientside("drc_dummy")
			self.CSPlayerModel:SetModel(LocalPlayer():GetModel())
			self.CSPlayerModel:SetSkin(LocalPlayer():GetSkin())
			self.CSPlayerModel.DrawMirror = false
			
			for k,v in pairs(ply:GetBodyGroups()) do
				self.CSPlayerModel:SetBodygroup(v.id, ply:GetBodygroup(v.id))
			end
			
			self.CSLegModel = ents.CreateClientside("drc_dummy")
			self.CSLegModel:SetModel(self.ViewModel)
			
			self.CSLegModel:SetPos(vm:EyePos())
			self.CSLegModel:SetAngles(vm:EyeAngles())
			self.CSLegModel:SetParent(vm)
			self.CSLegModel.DrawMirror = false
		else
			if seq == kickanim or seq == kneeanim then
				self.CSPlayerModel:SetNoDraw(false)
				self.CSPlayerModel:SetSequence(self.VMSequence)
				self.CSLegModel:SetSequence(self.VMSequence)
				self.CSPlayerModel:SetCycle(self.VMCycle)
				self.CSLegModel:SetCycle(self.VMCycle)
			else
				self.CSPlayerModel:SetNoDraw(true)
			end
			if DRC:ThirdPersonEnabled(ply) == true then self.CSPlayerModel:SetNoDraw(true) return end
		
			self.CSPlayerModel:SetPos(self.CSLegModel:GetPos())
			self.CSPlayerModel:SetAngles(self.CSLegModel:GetAngles())
			
			if !self.CSPlayerModel:IsEffectActive(EF_BONEMERGE) then
				self.CSPlayerModel:SetParent(self.CSLegModel)
				self.CSPlayerModel:AddEffects(EF_BONEMERGE)
			end
		end
	end
end

function SWEP:FuckOff()
	if IsValid(self.CSPlayerModel) then
		self.CSPlayerModel:Remove()
		self.CSLegModel:Remove()
	end
end

function SWEP:DoCustomDeploy()
	local ply = self:GetOwner()
	local mdl = player_manager.TranslateToPlayerModelName(ply:GetModel())
	if DRC:GetPlayerModelValue(mdl, "Extensions", "Claws") == true then
		self.Primary.MissActivity = ACT_VM_HITRIGHT2
		self.Primary.CrouchMissActivity = ACT_VM_HITRIGHT2
		self.Secondary.MissActivity = ACT_VM_HITLEFT2
		self.Secondary.CrouchMissActivity = ACT_VM_HITLEFT2
		self.Primary.SwingSound					= Sound( "draconic.ClawFoley" )
		self.Primary.LungeSwingSound			= Sound( "draconic.PunchFoley" )
		self.Secondary.SwingSound				= Sound( "draconic.ClawFoley" )
	--	self.Secondary.HitSoundFlesh 			= Sound( "draconic.ClawImpact" )
	else
		self.Primary.MissActivity = ACT_VM_SECONDARYATTACK
		self.Primary.CrouchMissActivity = ACT_VM_SECONDARYATTACK
		self.Secondary.MissActivity = ACT_VM_PRIMARYATTACK
		self.Secondary.CrouchMissActivity = ACT_VM_PRIMARYATTACK
		self.Primary.SwingSound					= Sound( "draconic.PunchFoley" )
		self.Primary.LungeSwingSound			= Sound( "draconic.PunchFoley" )
		self.Secondary.SwingSound				= Sound( "draconic.PunchFoley" )
	end
end

function SWEP:DoCustomLunge()
	local ply = self:GetOwner()
	if game.SinglePlayer() then ply = player.GetAll()[1] end
	local ea = ply:EyeAngles()
	if DRC:FloorDist(ply) < 10 then
		timer.Simple(0, function() 
			if ea.x > 55 then
				DRC:CallGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_MP_ATTACK_STAND_MELEE_SECONDARY, true)
				for i=0,66 do
					timer.Simple(0.015*i, function()
						ply:SetLocalVelocity(Vector())
					end)
				end
				timer.Simple(0.3, function()
					if IsValid(ply) then util.ScreenShake( ply:GetPos(), 5, 0.2, 0.3, 50 ) end
				end)
			else
				DRC:CallGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_MP_STAND_MELEE)
			end
		end)
	else
		timer.Simple(0, function() DRC:CallGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_MP_JUMP_MELEE) end)
	end
end

function SWEP:DoCustomPrimaryAttack()
	local ply = self:GetOwner()
	local mdl = player_manager.TranslateToPlayerModelName(ply:GetModel())
	local val = DRC:GetPlayerModelValue(mdl, "Extensions", "Claws")
	if val == true then timer.Simple(0, function() DRC:CallGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GESTURE_MELEE_ATTACK1, true) end) end
end

function SWEP:DoCustomSecondaryAttack()
	local ply = self:GetOwner()
	local mdl = player_manager.TranslateToPlayerModelName(ply:GetModel())
	local val = DRC:GetPlayerModelValue(mdl, "Extensions", "Claws")
	if val == true then timer.Simple(0, function() DRC:CallGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GESTURE_MELEE_ATTACK2, true) end) end
end

local swingy = {
	["prop_door_rotating"] = true,
	["func_door_rotating"] = true,
}

function SWEP:DoCustomMeleeImpact(att, tr)
	if att == "lungeprimary" && !CLIENT then
		local snd1, snd2
		local ent = tr.Entity
		
		if IsValid(ent) then
			local surfacemat = DRC:GetDRCMaterial(ent, 0)
			if !surfacemat then return end
			if table.HasValue(surfacemat, "wood") then
				snd1 = "draconic.DoorSlamHit_Wood"
				snd2 = "draconic.DoorSlamStop_Wood"
				DRC:EmitSound(self, snd1)
			elseif table.HasValue(surfacemat, "metal") then
				snd1 = "draconic.DoorSlamHit_Metal"
				snd2 = "draconic.DoorSlamStop_Metal"
				DRC:EmitSound(self, snd1)
			end
			
			
			if swingy[ent:GetClass()] then	
				local oldspeed = ent:GetInternalVariable("m_flSpeed")
				
				if ent:GetInternalVariable("m_bLocked") != true then
					
					ent:Fire("SetSpeed", 600)
					ent:Fire("Open")
					timer.Simple(0.25, function()
						if IsValid(ent) then
							ent:Fire("SetSpeed", oldspeed)
							DRC:EmitSound(ent, snd2)
						end
					end)
				end
			end
		end
	end
end

function SWEP:DoCustomHolster()
	self:FuckOff()
end

function SWEP:DoCustomRemove()
	self:FuckOff()
end