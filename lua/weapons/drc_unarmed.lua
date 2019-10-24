SWEP.Base				= "draconic_melee_base"
SWEP.Gun				= "drc_unarmed"

SWEP.HoldType			= "fist" -- https://wiki.garrysmod.com/page/Hold_Types
SWEP.CrouchHoldType		= "fist"
SWEP.IdleSequence		= "fists_idle_01"
SWEP.WalkSequence		= "fists_idle_01"
SWEP.Category			= "Draconic"
SWEP.PrintName			= "Hands"
SWEP.Auhtor				= "Vuthakral"
SWEP.Contact			= " https://discord.gg/6Y7WXrX // Steam: Vuthakral // Disc: Vuthakral#9761 "
SWEP.Purpose			= ""
SWEP.Instructions		= "Hold left click to grab objects, right click to punch."
 
SWEP.Spawnable      = false
SWEP.AdminSpawnable = false
SWEP.DrawCrosshair  = false
SWEP.Slot           = 0
SWEP.SlotPos        = 1

SWEP.UseHands		= true
SWEP.ViewModel 		= "models/vuthakral/weapons/c_arms_redef.mdl"
SWEP.WorldModel 	= ""
SWEP.ViewModelFOV   = 70
SWEP.VMPos 			= Vector(0, 0, 0)
SWEP.VMAng 			= Vector(0, 0, 0)
SWEP.SS 			= 1
SWEP.BS 			= 2

SWEP.IdleActivity = ACT_VM_IDLE
SWEP.CrouchIdleActivity = ACT_VM_IDLE

SWEP.ViewModelFlip  = false

SWEP.Secondary.SwingSound 	 = Sound( "draconic.BladeStabSmall" )
SWEP.Secondary.HitSoundWorld = Sound( "Flesh.ImpactHard" )
SWEP.Secondary.HitSoundFlesh = Sound( "Flesh.ImpactHard" )
SWEP.Secondary.HitSoundEnt 	 = Sound( "Flesh.ImpactHard" )
SWEP.Secondary.HoldType		 = "fist"
SWEP.Secondary.HoldTypeCrouch	 = "fist"
SWEP.Secondary.ImpactDecal 	 = ""
SWEP.Secondary.Automatic 	 = true
SWEP.Secondary.Damage 	  	 = 15
SWEP.Secondary.DamageType	 = DMG_SLASH
SWEP.Secondary.Range       	 = 15
SWEP.Secondary.Force	   	 = 2
SWEP.Secondary.DelayMiss   	 = 1.5
SWEP.Secondary.DelayHit	   	 = 0.78
SWEP.Secondary.CanAttackCrouched = true
SWEP.Secondary.HitActivity	= ACT_VM_PRIMARYATTACK
SWEP.Secondary.CrouchHitActivity	= ACT_VM_PRIMARYATTACK
SWEP.Secondary.MissActivity	= ACT_VM_PRIMARYATTACK
SWEP.Secondary.CrouchMissActivity	= ACT_VM_PRIMARYATTACK
SWEP.Secondary.HitDelay		= 0.19

SWEP.Time = 0
SWEP.Range = 50
SWEP.Drag = nil

function SWEP:DoCustomThink()
	local ply = self:GetOwner()
	if ply:KeyDown(IN_ATTACK) then
		self:PrimaryAttack()
	elseif !ply:KeyDown(IN_ATTACK) then
		self.Drag = nil
	else end
end

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()
	local Pos = self.Owner:GetShootPos()
	local Aim = self.Owner:GetAimVector()

	local Tr = util.TraceLine{
		start = Pos,
		endpos = Pos +Aim *self.Range,
		filter = player.GetAll(),
	}

	local HitEnt = Tr.Entity
	if self.Drag then
		HitEnt = self.Drag.Entity
	else
		if not IsValid( HitEnt ) or HitEnt:GetMoveType() ~= MOVETYPE_VPHYSICS or
			HitEnt:IsVehicle() or HitEnt:GetNWBool( "NoDrag", false ) or
			HitEnt.BlockDrag or
			IsValid( HitEnt:GetParent() ) then
			return
		end

		if not self.Drag then
			self.Drag = {
				OffPos = HitEnt:WorldToLocal(Tr.HitPos),
				Entity = HitEnt,
				Fraction = Tr.Fraction,
			}
		end
	end

	if CLIENT or not IsValid( HitEnt ) then return end

	local Phys = HitEnt:GetPhysicsObject()

	if IsValid( Phys ) then
		local Pos2 = Pos +Aim *self.Range *self.Drag.Fraction
		local OffPos = HitEnt:LocalToWorld( self.Drag.OffPos )
		local Dif = Pos2 -OffPos
		local Nom = (Dif:GetNormal() *math.min(1, Dif:Length() /100) *500 -Phys:GetVelocity()) *Phys:GetMass()

		Phys:ApplyForceOffset( Nom, OffPos )
		Phys:AddAngleVelocity( -Phys:GetAngleVelocity() /4 )
	end
end

if CLIENT then
	surface.CreateFont("Notif", {
		font 	= "heydings controls",
		size	= 36,
		weight	= 300	
	})

	local w2 = ScrW()/2 
	local leftwide = w2 - 300 
	local leftwidehalf = leftwide / 2

	local x, y = ScrW() /2, ScrH() /2
	local MainCol = Color( 255, 255, 255, 255 )
	local Col = Color( 255, 255, 255, 255 )

	function SWEP:DrawHUD()
		if IsValid( self.Owner:GetVehicle() ) then return end
		local Pos = self.Owner:GetShootPos()
		local Aim = self.Owner:GetAimVector()

		local Tr = util.TraceLine{
			start = Pos,
			endpos = Pos +Aim *self.Range,
			filter = player.GetAll(),
		}

		local HitEnt = Tr.Entity
		if IsValid( HitEnt ) and HitEnt:GetMoveType() == MOVETYPE_VPHYSICS and
			not self.rDag and
			not HitEnt:IsVehicle() and
			not IsValid( HitEnt:GetParent() ) and
			not HitEnt:GetNWBool( "NoDrag", false ) then

			self.Time = math.min( 1, self.Time +2 *FrameTime() )
		else
			self.Time = math.max( 0, self.Time -2 *FrameTime() )
		end

		if self.Time > 0 then
			Col.a = MainCol.a *self.Time

			draw.SimpleText(
				"G",
				"Notif",
				x,
				y,
				Col,
				TEXT_ALIGN_LEFT
			)
		end
	end
else end