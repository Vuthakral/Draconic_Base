SWEP.Base = "draconic_melee_base"

SWEP.Category			= "Other"
SWEP.PrintName			= "Unarmed"
SWEP.Author				= "Vuthakral"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.NPCSpawnable		= false
SWEP.AutoSwitchTo		= true
SWEP.AutoSwitchFrom		= true

SWEP.Slot				= 0
SWEP.SlotPos			= 0

SWEP.ViewModel			= "models/vuthakral/drc_unarmed.mdl"
SWEP.ViewModelFOV		= 90
SWEP.VMPos				= Vector(0, 0, 0)
SWEP.VMAng				= Vector(0, 0, 0)
SWEP.SprintPos			= Vector(0, 0, 0)
SWEP.SprintAng			= Vector(0, 0, 0)
SWEP.PassivePos			= Vector(0, 0, 0)
SWEP.PassiveAng			= Vector(0, 0, 0)
SWEP.UseHands			= true

SWEP.HoldType	= "normal"

SWEP.Primary.SwingSound			= Sound( "draconic.FistSwingFast" )
SWEP.Primary.HitSoundWorld 		= Sound( "" )
SWEP.Primary.HitSoundFlesh 		= Sound( "" )
SWEP.Primary.HitSoundEnt 		= Sound( "" )
SWEP.Primary.HoldType			= "fist"
SWEP.Primary.CrouchHoldType		= "melee"
SWEP.Primary.ImpactDecal 		= ""
SWEP.Primary.BurnDecal 			= ""
SWEP.Primary.Automatic			= false
SWEP.Primary.Damage				= 25
SWEP.Primary.DamageType			= DMG_CLUB
SWEP.Primary.Range				= 25
SWEP.Primary.Force				= 2
SWEP.Primary.DelayMiss			= 0.65
SWEP.Primary.DelayHit 			= 0.65
SWEP.Primary.CanAttackCrouched = true
SWEP.Primary.HitActivity		= ACT_VM_IDLE
SWEP.Primary.CrouchHitActivity	= nil
SWEP.Primary.MissActivity		= ACT_VM_PRIMARYATTACK 
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
SWEP.Primary.LungeSwingSound	= Sound( "draconic.FistSwingFast" )
SWEP.Primary.LungeHitSoundWorld = Sound( "" )
SWEP.Primary.LungeHitSoundFlesh = Sound( "" )
SWEP.Primary.LungeHitSoundEnt	= Sound( "" )
SWEP.LungeHoldType				= "fist"
SWEP.LungeHoldTypeCrouch		= "melee"
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

SWEP.Secondary.SwingSound			= Sound( "draconic.FistSwingFast" )
SWEP.Secondary.HitSoundWorld 		= Sound( "" )
SWEP.Secondary.HitSoundFlesh 		= Sound( "" )
SWEP.Secondary.HitSoundEnt 			= Sound( "" )
SWEP.Secondary.HoldType				= "fist"
SWEP.Secondary.CrouchHoldType		= "melee"
SWEP.Secondary.ImpactDecal 			= ""
SWEP.Secondary.BurnDecal 			= ""
SWEP.Secondary.Automatic			= false
SWEP.Secondary.Damage				= 25
SWEP.Secondary.DamageType			= DMG_CLUB
SWEP.Secondary.Range				= 25
SWEP.Secondary.Force				= 2
SWEP.Secondary.DelayMiss			= 0.65
SWEP.Secondary.DelayHit 			= 0.65
SWEP.Secondary.CanAttackCrouched 	= true
SWEP.Secondary.HitActivity			= ACT_VM_IDLE
SWEP.Secondary.CrouchHitActivity	= nil
SWEP.Secondary.MissActivity			= ACT_VM_SECONDARYATTACK
SWEP.Secondary.CrouchMissActivity	= ACT_VM_HITRIGHT
SWEP.Secondary.HitDelay				= 0.07
SWEP.Secondary.StartX				= 50
SWEP.Secondary.StartY				= 3
SWEP.Secondary.EndX					= -40
SWEP.Secondary.EndY					= -10
SWEP.Secondary.ShakeMul				= 1

function SWEP:DoCustomThink()
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	if !ply:IsPlayer() then return end
	local vm = ply:GetViewModel()
	if !IsValid(vm) then return end
	
	local cv = ply:Crouching()
	local kickanim = vm:LookupSequence("kick0")
	local kneeanim = vm:LookupSequence("kick1")
	
	if cv then
		self.Primary.StartX		= -45
		self.Primary.StartY		= -20
		self.Primary.EndX		= 45
		self.Primary.EndY		= 20
		self.Primary.Range		= 15
		
		self.Secondary.StartX	= 45
		self.Secondary.StartY	= -20
		self.Secondary.EndX		= -45
		self.Secondary.EndY		= 20
		self.Secondary.Range	= 15
	else
		self.Primary.StartX		= -50
		self.Primary.StartY		= 3
		self.Primary.EndX		= 50
		self.Primary.EndY		= -10
		self.Primary.Range		= 25
		
		self.Secondary.StartX	= 50
		self.Secondary.StartY	= 3
		self.Secondary.EndX		= -50
		self.Secondary.EndY		= -10
		self.Secondary.Range	= 25
	end
	
	if !DRC:ValveBipedCheck(ply) then self.Primary.CanLunge = false end

	if CLIENT then
		if ply != LocalPlayer() then return end
		if !IsValid(self.CSPlayerModel) then
			self.CSPlayerModel = ents.CreateClientside("drc_dummy")
			self.CSPlayerModel:SetModel(LocalPlayer():GetModel())
			self.CSPlayerModel:SetSkin(LocalPlayer():GetSkin())
			
			for k,v in pairs(ply:GetBodyGroups()) do
				self.CSPlayerModel:SetBodygroup(v.id, ply:GetBodygroup(v.id))
			end
			
			self.CSLegModel = ents.CreateClientside("drc_dummy")
			self.CSLegModel:SetModel(self.ViewModel)
			
			self.CSLegModel:SetPos(vm:EyePos())
			self.CSLegModel:SetAngles(vm:EyeAngles())
			self.CSLegModel:SetParent(vm)
		else
			if vm:GetSequence() == kickanim or vm:GetSequence() == kneeanim then
				self.CSPlayerModel:SetNoDraw(false)
				self.CSLegModel:SetSequence(self.VMSequence)
				self.CSLegModel:SetCycle(self.VMCycle)
			else
				self.CSPlayerModel:SetNoDraw(true)
			end
		
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

function SWEP:DoCustomHolster()
	self:FuckOff()
end

function SWEP:DoCustomRemove()
	self:FuckOff()
end