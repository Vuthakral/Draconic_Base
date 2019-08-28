SWEP.Base				= "draconic_base"
SWEP.Gun				= "draconic_gun_base"

SWEP.HoldType			= "ar2" -- https://wiki.garrysmod.com/page/Hold_Types
SWEP.ReloadHoldType		= "ar2"
SWEP.Category			= "Draconic"
SWEP.PrintName			= "Draconic Gun Base"
SWEP.Auhtor				= "Vuthakral"
SWEP.Contact			= " https://discord.gg/6Y7WXrX // Steam: Vuthakral // Disc: Vuthakral#9761 "
SWEP.Purpose			= "SWEP Base"
SWEP.Instructions		= "why the fuck did you spawn this in this is a base and not a weapon you should actually use"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Slot				= 0
SWEP.SlotPos			= 0

SWEP.ViewModelFOV		= 54
SWEP.ViewModelFlip		= false
SWEP.EnableFOVKick		= false -- DO NOT USE. Need to make fully client side before this is doable. Will cause broken FOVs if used in its current state!
SWEP.FOVKickMult		= 1
SWEP.FOVKickTimeMult	= 1

SWEP.ViewModel = ""
SWEP.WorldModel = ""
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.IronSightPos = Vector(0, 0, 0)
SWEP.IronSightAng = Vector(0, 0, 0)
SWEP.SS = 0
SWEP.BS = 0

SWEP.LoadAfterShot 			= false
SWEP.LoadAfterReloadEmpty	= false
SWEP.ManualReload			= false
SWEP.Primary.NumShots 		= 1
SWEP.Primary.IronRecoilMul	= 0.5
SWEP.Primary.Spread			= 1
SWEP.Primary.SpreadDiv		= 90
SWEP.Primary.Force			= 0
SWEP.Primary.Damage			= 1
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Automatic		= true
SWEP.Primary.RPM			= 857
SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.DropMagReload	= false
SWEP.Primary.APS			= 1
SWEP.Primary.Tracer			= 4 -- https://wiki.garrysmod.com/page/Enums/TRACER
SWEP.Primary.Sound = Sound("weapon_smg1.Single")
SWEP.Primary.NPCSound = nil

SWEP.Primary.Projectile			 = nil
SWEP.Primary.ProjSpeed			 = 750
SWEP.Primary.ProjInheritVelocity = false

SWEP.Primary.CanMelee		= false
SWEP.Primary.MeleeKeyInput	= IN_USE
SWEP.Primary.MeleeSwingSound	= Sound( "" )
SWEP.Primary.MeleeHitSoundWorld = Sound( "" )
SWEP.Primary.MeleeHitSoundFlesh = Sound( "" )
SWEP.Primary.MeleeHitSoundEnt 	= Sound( "" )
SWEP.Primary.MeleeImpactDecal 	= ""
SWEP.Primary.MeleeDamage		= 12
SWEP.Primary.MeleeDamageType	= DMG_CLUB
SWEP.Primary.MeleeRange			= 16.5
SWEP.Primary.MeleeForce			= 5
SWEP.Primary.MeleeDelayMiss		= 0.42
SWEP.Primary.MeleeDelayHit 		= 0.54
SWEP.Primary.CanAttackCrouched = false
SWEP.Primary.MeleeHitActivity	= ACT_VM_PRIMARYATTACK 
SWEP.Primary.MeleeMissActivity	= ACT_VM_PRIMARYATTACK 
SWEP.Primary.MeleeHitDelay		= 0.07

SWEP.Secondary.Ironsights	= false
SWEP.Secondary.SightsSuppressAnim = false
SWEP.Secondary.Scoped		= false
SWEP.Secondary.ScopeMat		= "overlays/draconic_scope"
SWEP.Secondary.IronFOV		= 60
SWEP.Secondary.ScopeZoomTime = 0.15

SWEP.Secondary.NumShots 		= 0
SWEP.Secondary.Spread			= 3.5
SWEP.Secondary.SpreadDiv		= 100
SWEP.Secondary.Kick				= 0.5
SWEP.Secondary.RecoilUp			= 1
SWEP.Secondary.RecoilDown		= 1
SWEP.Secondary.RecoilHoriz		= 1
SWEP.Secondary.Force			= 0.2
SWEP.Secondary.Damage			= 12
SWEP.Secondary.Ammo				= "none"
SWEP.Secondary.Automatic		= false
SWEP.Secondary.RPM				= 444
SWEP.Secondary.ClipSize			= 18
SWEP.Secondary.DefaultClip		= 18
SWEP.Secondary.DropMagReload	= false
SWEP.Secondary.APS				= 1
SWEP.Secondary.Tracer			= 1 -- https://wiki.garrysmod.com/page/Enums/TRACER
SWEP.Secondary.Sound = Sound("weapon_pistol.Single")

-- Settings for NPCs
SWEP.NPCBurstShots = 0
SWEP.JackalSniper = false

-- "DO NOT TOUCH" Zone. Touching any of these settings in your SWEP WILL break something. So DON'T.
SWEP.Loading = false
SWEP.IronCD = false
SWEP.FireDelay = 0

function SWEP:CanPrimaryAttack()
local ply = self:GetOwner()
	if CLIENT or SERVER then
	local curFOV = ply:GetFOV()
	local IronFOV = self.Secondary.IronFOV

		if ( self.Weapon:Clip1() <= 0 ) && self.InfAmmo == false then
			self:EmitSound ( "Weapon_AR2.Empty" )
			self:SetNextPrimaryFire (( CurTime() + 0.3 ))
			return false
		elseif ( self.Weapon:Clip1() <= 0 ) && self.InfAmmo == true then
			return true
		end
		if self.Weapon:GetNWBool("ironsights") == false then
			if self.EnableFOVKick == true then
				ply:SetFOV(curFOV + 1 * self.FOVKickMult, 0.01 * self.FOVKickTimeMult)
				timer.Simple (0.01 * self.FOVKickTimeMult, function() self:unKick() end)
			elseif self.EnableFOVKick == false then
			end
		elseif self.Weapon:GetNWBool("ironsights") == true then
			if self.EnableFOVKick == true then
				ply:SetFOV(IronFOV + 1 * (self.FOVKickMult / 2), 0.01 * self.FOVKickTimeMult)
				timer.Simple (0.01 * self.FOVKickTimeMult, function() self:unKick() end)
			elseif self.EnableFOVKick == false then
			end
		end
		if self.Loading == true or self.ManuallyReloading == true then
			return false
		else
		return true
		end
	else end
end

function SWEP:CanPrimaryAttackNPC()
local npc = self:GetOwner()

	if self.Weapon:Clip1() <= 0 or npc:GetActivity() == ACT_RELOAD or self.Weapon:GetNWBool("NPCLoading") == true then
		self:LoadNextShot()
		return false
	end
	npc:SetSchedule(SCHED_RANGE_ATTACK1)
	return true
end

function SWEP:CanSecondaryAttack()
local ply = self:GetOwner()
local curFOV = ply:GetFOV()
local IronFOV = self.Secondary.IronFOV

	if ( self.Weapon:Clip2() <= 0 ) then
		self:EmitSound ( "Weapon_Pistol.Empty" )
		self:SetNextPrimaryFire (( CurTime() + 0.3 ))
		return false
	end
	if self.Loading == true or self.ManuallyReloading == true then
		return false
	else
		if self.EnableFOVKick == true then
			ply:SetFOV(curFOV + 1 * self.FOVKickMult, 0.01 * self.FOVKickTimeMult)
			timer.Simple (0.01 * self.FOVKickTimeMult, function() self:unKick() end)
		elseif self.EnableFOVKick == false then
			ply:SetFOV(curFOV * 0, 0)
		end
		return true
	end
end

function SWEP:unKick()
local ply = self:GetOwner()
local curFOV = ply:GetFOV()
	ply:SetFOV(curFOV - 1 * self.FOVKickMult, 0)
end

function SWEP:FireAnimationEvent( pos, ang, event, options )
	if ( event == 5001 or event == 5011 or event == 5021 or event == 5031 or event == 21 ) then

		local data = EffectData()
		data:SetFlags( 0 )
		data:SetEntity( self.Owner:GetViewModel() )
		data:SetAttachment( math.floor( ( event - 4991 ) / 10 ) )
		data:SetScale( 1 ) -- Change me

		if ( self.CSMuzzleX ) then
			util.Effect( "CS_MuzzleFlash_X", data )
		else
			util.Effect( "CS_MuzzleFlash", data )
		end

		return true
	end
end

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()
	local fireseq = self:SelectWeightedSequence( ACT_VM_PRIMARYATTACK )
	local firetime = self:SequenceDuration( fireseq )
	
if ply:IsPlayer() then
	if self.Primary.CanMelee == true then
		if ply:KeyDown(self.Primary.MeleeKeyInput) then
			self:DoMelee()
		else
			if self.Loading == false then
				self:DoPrimaryAttack()
					if self.LoadAfterShot == true && (self.Weapon:Clip1() > 0) then
						self.Loading = true
						timer.Simple( firetime, function() self:LoadNextShot() end)
					elseif self.LoadAfterShot == true && (self.Weapon:Clip1() <= 0) then
						self.Loading = false
					elseif self.Loading == false then
					end
			end
		end
	elseif self.Primary.CanMelee == false && self.Loading == false then
		self:DoPrimaryAttack()
		if self.LoadAfterShot == true && (self.Weapon:Clip1() > 0) then
			self.Loading = true
			timer.Simple( firetime, function() self:LoadNextShot() end)
		elseif self.LoadAfterShot == true && self.LoadAfterReloadEmpty == false && (self.Weapon:Clip1() <=0) then
			self.Loading = true
			timer.Simple( firetime, function() self:LoadNextShot() end)
		elseif self.LoadAfterShot == true && (self.Weapon:Clip1() <= 0) then
		self.Loading = false
		else end
	end
elseif !ply:IsPlayer() then
if SERVER then
	if (self.Weapon:Clip1() > 0) then
	if self.FireDelay > CurTime() then
		return
	end
		if self.Owner:IsNPC() and IsValid(self.Owner:GetEnemy()) then
			self.FireDelay = (CurTime() + (60 / self.Primary.RPM))
			for i=0, self.NPCBurstShots do
				timer.Simple(i + 0.1, function()
					if not IsValid(self) or not IsValid(self.Owner) then
						return
					end
					if not self.Owner:GetEnemy() or not self:CanPrimaryAttackNPC() then
						return
					end
					if self.Loading == false then
						self:DoPrimaryAttackNPC()
						if self.LoadAfterShot == true then
							self.Loading = true
							timer.Simple( 0.01, function() self.Weapon:SetNWBool("NPCLoading", true) end)
						else end
					end
				end)
			end
		end
	elseif (self.Weapon:Clip1() <= 0) then
	end
else end
end
end


function SWEP:LoadNextShot()
	local ply = self:GetOwner()
	local loadseq = self:SelectWeightedSequence( ACT_SHOTGUN_PUMP )
	local loadtime = self:SequenceDuration( loadseq )

	if CLIENT or SERVER then
		if ply:IsPlayer() then
			self.Weapon:SendWeaponAnim( ACT_SHOTGUN_PUMP )
			timer.Simple( loadtime + 0.025, function() self:FinishLoading() end)
		else end
	end
	
	if ply:IsNPC() then
		timer.Simple( 1, function() self.Weapon:SetNWBool("NPCLoading", false) ply:ClearSchedule() self.Loading = false end)
	else end
end

function SWEP:FinishLoading()
	self.Loading = false
end

function SWEP:DoMelee()
local ply = self:GetOwner()
local cv = ply:Crouching()
	if cv == false then
		self:SetHoldType( self.HoldType )
	elseif cv == true then
		self:SetHoldType( self.CrouchHoldType )
	end
self:EmitSound(Sound(self.Primary.MeleeSwingSound))

local tr = util.TraceLine( {
	start = self.Owner:GetShootPos(),
	endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.Primary.MeleeRange*4,
	filter = self.Owner,
	mask = MASK_SHOT_HULL,
} )
if !IsValid( tr.Entity ) then
	tr = util.TraceHull( {
	start = self.Owner:GetShootPos(),
	endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.Primary.MeleeRange*4,
	filter = self.Owner,
	mins = Vector( -16, -16, 0 ),
	maxs = Vector( 16, 16, 0 ),
	mask = MASK_SHOT_HULL,
} )
end

timer.Simple( self.Primary.MeleeHitDelay, function() self:DoMeleeImpact() end)

if !tr.Hit then
	self.Weapon:SendWeaponAnim( self.Primary.MeleeMissActivity )
	self:SetNextPrimaryFire( CurTime() + self.Primary.MeleeDelayMiss )
	self:SetNextPrimaryFire( CurTime() + self.Primary.MeleeDelayMiss )
end
if tr.Hit then
	self.Weapon:SendWeaponAnim( self.Primary.MeleeHitActivity )
	self:SetNextPrimaryFire( CurTime() + self.Primary.MeleeDelayHit )
	self:SetNextPrimaryFire( CurTime() + self.Primary.MeleeDelayHit )
end
	self.Idle = 0
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:DoMeleeImpact()
	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.Primary.MeleeRange*4,
		filter = self.Owner,
		mask = MASK_SHOT_HULL,
} )

if ( tr.Hit ) then
	util.Decal(self.Primary.MeleeImpactDecal, tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)  
end

local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Distance = self.Primary.Distance
	bullet.Spread = Vector( 0, 0, 0 )
	bullet.Tracer = 0
	bullet.Force = self.Primary.Force
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
			dmg:SetDamage( self.Primary.MeleeDamage )
			dmg:SetDamageForce( self.Owner:GetForward() * self.Primary.MeleeForce )
			dmg:SetDamageType( self.Primary.MeleeDamageType )
			tr.Entity:TakeDamageInfo( dmg )
end
end

	if ( tr.Hit ) then
		if tr.Entity:IsPlayer() or string.find(tr.Entity:GetClass(),"npc") or string.find(tr.Entity:GetClass(),"prop_ragdoll") or string.find(tr.Entity:GetClass(),"prop_physics") then
			if string.find(tr.Entity:GetClass(),"prop_physics") then
				self:EmitSound(Sound(self.Primary.MeleeHitSoundEnt))
			else
				self:EmitSound(Sound(self.Primary.MeleeHitSoundFlesh))
			end
				self.Owner:FireBullets(bullet)	
			else
				self:EmitSound(Sound(self.Primary.MeleeHitSoundWorld))
			end
	end
end

function SWEP:DoPrimaryAttack()
local ply = self:GetOwner()
local eyeang = ply:EyeAngles()
local cv = ply:Crouching()
	
	if ( self:CanPrimaryAttack() ) then
	
	if self.Weapon:GetNWBool("ironsights") == false && cv == false then
		if CLIENT then
		eyeang.pitch = eyeang.pitch - ((math.Rand(self.Primary.RecoilUp / 1.85, self.Primary.RecoilUp * 1.62)) - (math.Rand(self.Primary.RecoilDown / 1.85, self.Primary.RecoilDown * 1.85) * FrameTime()))
		eyeang.yaw = eyeang.yaw - (math.Rand( self.Primary.RecoilHoriz, (self.Primary.RecoilHoriz * -0.81) ) * FrameTime())
		else end
		self.Owner:ViewPunch(Angle( -self.Primary.Kick, 0, 0 ))
	elseif self.Weapon:GetNWBool("ironsights") == true && cv == false then
		eyeang.pitch = eyeang.pitch - (((math.Rand(self.Primary.RecoilUp / 1.5, self.Primary.RecoilUp * 1.5)) - (math.Rand(self.Primary.RecoilDown / 1.5, self.Primary.RecoilDown * 1.5) * FrameTime())) * self.Primary.IronRecoilMul)
		eyeang.yaw = eyeang.yaw - (math.Rand( self.Primary.RecoilHoriz, (self.Primary.RecoilHoriz * -1) ) * FrameTime())
		self.Owner:ViewPunch(Angle( (-self.Primary.Kick * 0.69) * self.Primary.IronRecoilMul, 0, 0 ))
	elseif self.Weapon:GetNWBool("ironsights") == false && cv == true then
		eyeang.pitch = eyeang.pitch - ((math.Rand(self.Primary.RecoilUp / 1.5, self.Primary.RecoilUp * 1.5)) - (math.Rand(self.Primary.RecoilDown / 1.5, self.Primary.RecoilDown * 1.5) * FrameTime()))
			eyeang.yaw = eyeang.yaw - (math.Rand( self.Primary.RecoilHoriz, (self.Primary.RecoilHoriz * -1) ) * FrameTime())
		self.Owner:ViewPunch(Angle( -self.Primary.Kick * 0.75, 0, 0 ))
	elseif self.Weapon:GetNWBool("ironsights") == true && cv == true then
		eyeang.pitch = eyeang.pitch - (((math.Rand(self.Primary.RecoilUp / 1.5, self.Primary.RecoilUp * 0.9)) - (math.Rand(self.Primary.RecoilDown / 1.9, self.Primary.RecoilDown * 0.9) * FrameTime())) * self.Primary.IronRecoilMul)
		eyeang.yaw = eyeang.yaw - (math.Rand( self.Primary.RecoilHoriz, (self.Primary.RecoilHoriz * -1) ) * FrameTime())
		self.Owner:ViewPunch(Angle( (-self.Primary.Kick * 0.42) * self.Primary.IronRecoilMul, 0, 0 ))
	end
		local bullet = {}
			bullet.Num = self.Primary.NumShots
			bullet.Src = self.Owner:GetShootPos()
			bullet.Dir = self.Owner:GetAimVector()
			bullet.Spread = Vector( self.Primary.Spread / self.Primary.SpreadDiv, self.Primary.Spread / self.Primary.SpreadDiv, 0 )
			bullet.Tracer = self.Primary.Tracer
			bullet.Force = self.Primary.Force
			bullet.Damage = self.Primary.Damage
			self.AmmoType = self.Primary.AmmoType
				
	if self.Primary.Projectile == nil then
		self.Owner:FireBullets ( bullet )
	else
	local aim = self.Owner:GetAimVector()
	local side = aim:Cross(Vector(0,0,0))
	local up = side:Cross(aim)
	local pos = self.Owner:GetShootPos() + side * 0 + up * 0
		if SERVER then
			local proj = ents.Create(self.Primary.Projectile)
			if !proj:IsValid() then return false end
			proj:SetAngles(self.Owner:EyeAngles())
			proj:SetPos(pos)
			proj:SetOwner(self.Owner)
			proj:Spawn()
			proj.Owner = self.Owner
			proj:Activate()
			eyes = self.Owner:EyeAngles()
			local phys = proj:GetPhysicsObject()
			if self.Primary.ProjInheritVelocity == true then
				phys:SetVelocity((self.Owner:GetAimVector() * self.Primary.ProjSpeed) + ply:GetVelocity())
			else
				phys:SetVelocity(self.Owner:GetAimVector() * self.Primary.ProjSpeed)
			end
		end
	end
	self.Owner:MuzzleFlash()
	ply:SetAnimation( PLAYER_ATTACK1 )
	if self.Secondary.SightsSuppressAnim == false && self.Weapon:GetNWBool("ironsights") == false then
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	elseif self.Secondary.SightsSuppressAnim == false && self.Weapon:GetNWBool("ironsights") == true then
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	elseif self.Secondary.SightsSuppressAnim == true && self.Weapon:GetNWBool("ironsights") == false then
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	elseif self.Secondary.SightsSuppressAnim == true && self.Weapon:GetNWBool("ironsights") == true then
	end
	self.Weapon:EmitSound(Sound(self.Primary.Sound))
	if CLIENT then
		ply:SetEyeAngles( eyeang )
	else end
		self:TakePrimaryAmmo( self.Primary.APS )
		self:SetNextPrimaryFire( CurTime() + (60 / self.Primary.RPM) )
		self:MuzzleFlash()
		self:ShootEffects()
	else return end
end

function SWEP:DoPrimaryAttackNPC()
local npc = self:GetOwner()
local eyeang = npc:EyeAngles()
local tgt = npc:GetEnemy()
local tgtclass = tgt:GetClass()
local ctrpos = tgt:WorldSpaceCenter()
local eyepos = tgt:EyePos()
local muzzle = self:LookupAttachment("muzzle")
local tgtpos = nil
local accuracy = Vector( self.Primary.Spread / self.Primary.SpreadDiv, self.Primary.Spread / self.Primary.SpreadDiv, 0 )
local AccuracyHorizmath = math.random((self.Primary.Kick * -self.Primary.RecoilHoriz), (self.Primary.Kick * self.Primary.RecoilHoriz))
local AccuracyVertmath = math.random((math.Rand((self.Primary.Kick * -self.Primary.RecoilUp), (self.Primary.Kick * self.Primary.RecoilUp))), (math.Rand((self.Primary.Kick * -self.Primary.RecoilDown), (self.Primary.Kick * self.Primary.RecoilDown))))

if self.JackalSniper == false then
	if tgt:IsPlayer() or tgtclass == "npc_citizen" or tgtclass == "npc_combine_s" or tgtclass == "npc_metropolice" or tgtclass == "npc_helicopter" or tgtclass == "npc_strider" or tgtclass == "npc_ministrider" or tgtclass == "npc_hunter" or tgtclass == "npc_barnacle" or tgtclass == "npc_zombie_torso" or tgtclass == "npc_fastzombie_torso" or tgtclass == "monster_alien_controller" or tgtclass == "monster_scientist" or tgtclass == "monster_barney" then
		tgtpos = (eyepos - Vector(AccuracyHorizmath, 0, (AccuracyVertmath + math.random(5, 15))))
	elseif tgtclass == "npc_zombie" or tgtclass == "npc_fastzombie" or tgtclass == "npc_poisonzombie" or tgtclass == "npc_zombine" or tgtclass == "monster_human_grunt" or tgtclass == "npc_stalker" or tgtclass == "monster_tentacle" or tgtclass == "monster_alien_grunt" or tgtclass == "monster_human_assassin" or tgtclass == "monster_alien_slave" or tgtclass == "monster_zombie" then
		tgtpos = (ctrpos + Vector(AccuracyHorizmath, 0, (AccuracyVertmath + math.Rand(10, 17))))
	elseif tgtclass == "npc_headcrab" or tgtclass == "npc_headcrab_black" or tgtclass == "npc_headcrab_fast" or tgtclass == "npc_manhack" or tgtclass == "npc_rollermine" or tgtclass == "npc_turret_floor" or tgtclass == "npc_cscanner" or tgtclass == "npc_clawscanner" or tgtclass == "npc_antlion_worker" or tgtclass == "npc_antlionguard" or tgtclass == "npc_antlionguardian" or tgtclass == "monster_sentry" or tgtclass == "monster_snark" or tgtclass == "monster_houndeye"  or tgtclass == "monster_babycrab" or tgtclass == "monster_bullchicken" or tgtclass == "monster_cockroach" or tgtclass == "monster_headcrab" or tgtclass == "monster_turret" or tgtclass == "monster_miniturret" or tgtclass == "npc_combinegunship" then
		tgtpos = ctrpos
	elseif tgtclass == "npc_antlion" then
		tgtpos = eyepos
	elseif tgtclass == "monster_gargantua" or tgtclass == "monster_nihilanth" or tgtclass == "monster_bigmomma" then
		tgtpos = (ctrpos + Vector(AccuracyHorizmath, 0, (AccuracyVertmath + math.random(6, 102))))
	else
		tgtpos = (ctrpos + Vector(AccuracyHorizmath, 0, (AccuracyVertmath + math.random(-5, 15))))
	end
elseif self.JackalSniper == true then
	tgtpos = eyepos - Vector(0, 0, 5)
end

if ( self:CanPrimaryAttackNPC() ) then
	local bullet = {}
		bullet.Num = self.Primary.NumShots
		bullet.Src = self.Owner:GetShootPos()
		if (npc:GetPos():Distance(tgt:GetPos()) > 150)  then -- if you're this close to a hostile NPC we cant properly do our artificial aiming and nothing will ever hit, so we resort to standard NPC accuracy.
			bullet.Dir = (tgtpos - self.Weapon:GetAttachment(muzzle).Pos):GetNormalized()
		else
			bullet.Dir = npc:GetAimVector()
		end
		if self.JackalSniper == false then
			bullet.Spread = Vector( (self.Primary.Spread / self.Primary.SpreadDiv), (self.Primary.Spread / self.Primary.SpreadDiv), 0 )
		elseif self.JackalSniper == true then
			bullet.Spread = Vector(0, 0, 0)
		end
		bullet.Tracer = self.Primary.Tracer
		bullet.Force = self.Primary.Force
		bullet.Damage = self.Primary.Damage
		
	self.AmmoType = self.Primary.AmmoType	
	if self.Primary.Projectile == nil then
		self.Owner:FireBullets ( bullet )
	else
	local aim = self.Owner:GetAimVector()
	local side = aim:Cross(Vector(0,0,0))
	local up = side:Cross(aim)
	local pos = self.Owner:GetShootPos() + side * 0 + up * 0
		if SERVER then
			local proj = ents.Create(self.Primary.Projectile)
			if !proj:IsValid() then return false end
			proj:SetAngles(self.Owner:EyeAngles())
			proj:SetPos(pos)
			proj:SetOwner(self.Owner)
			proj:Spawn()
			proj.Owner = self.Owner
			proj:Activate()
			eyes = self.Owner:EyeAngles()
			local phys = proj:GetPhysicsObject()
			if self.Primary.ProjInheritVelocity == true then
				phys:SetVelocity((self.Owner:GetAimVector() * self.Primary.ProjSpeed) + ply:GetVelocity())
			else
				phys:SetVelocity(self.Owner:GetAimVector() * self.Primary.ProjSpeed)
			end
		end
	end
	self.Owner:MuzzleFlash()
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	if self.Primary.NPCSound == nil then
		self.Weapon:EmitSound(Sound(self.Primary.Sound))
	else
		self.Weapon:EmitSound(Sound(self.Primary.NPCSound))
	end
	self:TakePrimaryAmmo( self.Primary.APS )
	self:MuzzleFlash()
	self:ShootEffects()
	self:SetNextPrimaryFire( CurTime() + (60 / self.Primary.RPM) )
	else return end
end

function SWEP:TakePrimaryAmmo( num )
	if ( self.Weapon:Clip1() <= 0 ) then
		if ( self:Ammo1() <= 0 ) then return end
		self.Owner:RemoveAmmo( num, self.Weapon:GetPrimaryAmmoType() )
	return end
	self.Weapon:SetClip1( self.Weapon:Clip1() - num )
end

function SWEP:SecondaryAttack()
local ply = self:GetOwner()
local cv = ply:Crouching()
local fireseq = self:SelectWeightedSequence( ACT_VM_PRIMARYATTACK )
local firetime = self:SequenceDuration( fireseq )
	
	if self.Secondary.Ironsights == true then
		if self.Weapon:GetNWBool("Ironsights") == true then
			self.Weapon:SetNetworkedBool( "Ironsights", true )
		else
			self.Weapon:SetNetworkedBool( "Ironsights", false )
		end
	elseif self.Secondary.Ironsights == false then
		self:DoSecondaryAttack()
	end
end

function SWEP:DoSecondaryAttack()
local ply = self:GetOwner()
local eyeang = ply:EyeAngles()
local cv = ply:Crouching()
local curFOV = ply:GetFOV()
local IronFOV = self.Secondary.IronFOV
	
	if ( self:CanSecondaryAttack() ) then

	if CLIENT then
	if cv == false then
		eyeang.pitch = eyeang.pitch - ((math.Rand(self.Secondary.RecoilUp / 1.85, self.Secondary.RecoilUp * 1.62)) - (math.Rand(self.Secondary.RecoilDown / 1.85, self.Secondary.RecoilDown * 1.85) * FrameTime()))
		eyeang.yaw = eyeang.yaw - (math.Rand( self.Secondary.RecoilHoriz, (self.Secondary.RecoilHoriz * -0.81) ) * FrameTime())
		self.Owner:ViewPunch(Angle( -self.Secondary.Kick, 0, 0 ))
	elseif cv == true then
		eyeang.pitch = eyeang.pitch - ((math.Rand(self.Secondary.RecoilUp / 1.5, self.Secondary.RecoilUp * 1.5)) - (math.Rand(self.Secondary.RecoilDown / 1.5, self.Secondary.RecoilDown * 1.5) * FrameTime()))
		eyeang.yaw = eyeang.yaw - (math.Rand( self.Secondary.RecoilHoriz, (self.Secondary.RecoilHoriz * -1) ) * FrameTime())
		self.Owner:ViewPunch(Angle( -self.Secondary.Kick * 0.75, 0, 0 ))
	end
	else end
		local bullet = {}
			bullet.Num = self.Secondary.NumShots
			bullet.Src = self.Owner:GetShootPos()
			bullet.Dir = self.Owner:GetAimVector()
			bullet.Spread = Vector( self.Secondary.Spread / self.Secondary.SpreadDiv, self.Secondary.Spread / self.Secondary.SpreadDiv, 0 )
			bullet.Tracer = self.Secondary.Tracer
			bullet.Force = self.Secondary.Force
			bullet.Damage = self.Secondary.Damage
			self.AmmoType = self.Secondary.AmmoType
			
	if self.Secondary.Projectile == nil then
		self.Owner:FireBullets ( bullet )
	else
	local aim = self.Owner:GetAimVector()
	local side = aim:Cross(Vector(0,0,0))
	local up = side:Cross(aim)
	local pos = self.Owner:GetShootPos() + side * 0 + up * 0
		if SERVER then
			local proj = ents.Create(self.Secondary.Projectile)
			if !proj:IsValid() then return false end
			proj:SetAngles(self.Owner:EyeAngles())
			proj:SetPos(pos)
			proj:SetOwner(self.Owner)
			proj:Spawn()
			proj.Owner = self.Owner
			proj:Activate()
			eyes = self.Owner:EyeAngles()
			local phys = proj:GetPhysicsObject()
			if self.Secondary.ProjInheritVelocity == true then
				phys:SetVelocity((self.Owner:GetAimVector() * self.Secondary.ProjSpeed) + ply:GetVelocity())
			else
				phys:SetVelocity(self.Owner:GetAimVector() * self.Secondary.ProjSpeed)
			end
		end
	end
	self.Owner:MuzzleFlash()
	ply:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	self.Weapon:EmitSound(Sound(self.Secondary.Sound))
	if CLIENT then
	ply:SetEyeAngles( eyeang )
	else end
	self:TakeSecondaryAmmo( self.Secondary.APS )
	self:SetNextSecondaryFire( CurTime() + (60 / self.Secondary.RPM) )
	self:MuzzleFlash()
	else return end
end

function SWEP:TakeSecondaryAmmo( num )
	if ( self.Weapon:Clip2() <= 0 ) then
		if ( self:Ammo2() <= 0 ) then return end
		self.Owner:RemoveAmmo( num, self.Weapon:GetSecondaryAmmoType() )
	return end
	self.Weapon:SetClip2( self.Weapon:Clip2() - num )
end

function SWEP:Reload()
local ply = self:GetOwner()
local usekey = ply:KeyDown(IN_USE)
local reloadkey = ply:KeyDown(IN_RELOAD)
local walkkey = ply:KeyDown(IN_WALK)
local sprintkey = ply:KeyDown(IN_SPEED)

if ply:IsPlayer() then
	if usekey && reloadkey then
		if self.Inspecting == 0 then
			self.Idle = 0
			self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
			self:Inspect()
		elseif self.Inspect == 1 then end
	elseif walkkey && reloadkey && self.IsTaunting == 0 then
		self:Taunt()
		elseif walkkey && reloadkey && self.IsTaunting == 1 then
		self:SetHoldType(self.ReloadHoldType)
	elseif reloadkey && !sprintkey && self.ManuallyReloading == false && self.Loading == false && self.ManualReload == true && ( self.Weapon:Clip1() < self.Primary.ClipSize ) then
		if ( ply:GetAmmoCount(self.Primary.Ammo) ) <= 0 then
		else
				self:SetHoldType(self.ReloadHoldType)
				self:StartManualReload()
				ply:SetFOV(0, 0.05)
				self.Weapon:SetNWBool( "Ironsights", false )
				hook.Remove( "HUDPaint", self.ScopeHookID )
				if self.Weapon:Clip1() <= 0 then
					self:SetNWBool("reloadedEmpty", true)
				else
					self:SetNWBool("reloadedEmpty", false)
				end
				return true
		end
	elseif reloadkey && !sprintkey && self.ManuallyReloading == false && self.Loading == false && self.ManualReload == false && ( self.Weapon:Clip1() < self.Primary.ClipSize ) then
			if ( self.Weapon:Clip1() < self.Primary.ClipSize ) && self.Weapon:Ammo1() > 0 then
				self:SetHoldType(self.Primary.ReloadHoldType)
				self:DoReload()
				ply:SetFOV(0, 0.05)
				self.Weapon:SetNWBool( "Ironsights", false )
				hook.Remove( "HUDPaint", self.ScopeHookID )
				if self.Weapon:Clip1() <= 0 then
					self:SetNWBool("reloadedEmpty", true)
				else
					self:SetNWBool("reloadedEmpty", false)
				end
				return true
			elseif ( self.Weapon:Clip1() < self.Primary.ClipSize ) && self.Weapon:Ammo1() > 1 then
			end
	elseif reloadkey && sprintkey && self.ManuallyReloading == false && self.Loading == false && ( self.Weapon:Clip2() < self.Secondary.ClipSize ) then
		if ( ply:GetAmmoCount(self.Secondary.Ammo) ) <= 0 then
		else
			self:SetHoldType(self.Secondary.ReloadHoldType)
			ply:SetFOV(0, 0.05)
			self:ReloadSecondary()
		end
	end
elseif !ply:IsPlayer() && ply:IsNPC() then
	if ply:IsCurrentSchedule(SCHED_HIDE_AND_RELOAD) or not ply:IsCurrentSchedule(SCHED_RELOAD) and not ply:GetActivity() == ACT_RELOAD then
		ply:SetSchedule(SCHED_RELOAD)
	end
end
end

function SWEP:ReloadSecondary()
	local ply = self:GetOwner()
	local reloadseq = self:SelectWeightedSequence( self.Secondary.ReloadAct )
	local reloadtime = self:SequenceDuration( reloadseq )
	
	if self:IsValid() && ply:IsValid() && ply:Alive() then
		ply:SetAnimation( PLAYER_RELOAD )
		self.Loading = true
		self:SetIronsights(false, self.Owner)
		
		self:SendWeaponAnim( self.Secondary.ReloadAct )
		timer.Simple( reloadtime, function() self:EndSecondaryReload() end)
	else end
end

function SWEP:EndSecondaryReload()
	local ply = self:GetOwner()
	self.Loading = false
	self.IronCD = false
	
	if self:IsValid() && ply:IsValid() && ply:Alive() then
		if self.Secondary.DropMagReload == false then
		ply:RemoveAmmo( (self.Secondary.ClipSize - self.Weapon:Clip2()), self.Secondary.Ammo)
		else
		ply:RemoveAmmo( self.Secondary.ClipSize, self.Secondary.Ammo)
		end
		self:SetClip2( self.Secondary.ClipSize )
		self:SetHoldType( self.HoldType )
	else end
end

function SWEP:DoReload()
	local ply = self:GetOwner()
	local reloadseq = self:SelectWeightedSequence( ACT_VM_RELOAD )
	local reloadtime = self:SequenceDuration( reloadseq )
	
	if self:IsValid() && ply:IsValid() && ply:Alive() then
		ply:SetAnimation( PLAYER_RELOAD )
		self.Loading = true
		self:SetIronsights(false, self.Owner)
		
		self:SendWeaponAnim(ACT_VM_RELOAD)
		timer.Simple( reloadtime, function() self:EndReload() end)
	else end
end

function SWEP:EndReload()
	local ply = self:GetOwner()
	self.Loading = false
	self.IronCD = false
	
	if self:IsValid() && ply:IsValid() && ply:Alive() then
		if self.Primary.DropMagReload == false then
		ply:RemoveAmmo( (self.Primary.ClipSize - self.Weapon:Clip1()), self.Primary.Ammo)
		else
		ply:RemoveAmmo( self.Primary.ClipSize, self.Primary.Ammo)
		end
		self:SetClip1( self.Primary.ClipSize )
		self:SetHoldType( self.HoldType )
		
		if self:GetNWBool("reloadedEmpty") == true && self.LoadAfterReloadEmpty == true then
			self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
		else end
	else end
end

function SWEP:StartManualReload()
	local ply = self:GetOwner()
	local wep = self
	local enterseq = self:SelectWeightedSequence( ACT_SHOTGUN_RELOAD_START )
	local entertime = self:SequenceDuration( enterseq )

	if self:IsValid() && ply:IsValid() && ply:Alive() then
		ply:SetAnimation( PLAYER_RELOAD )
		self.ManuallyReloading = true
		self:SetIronsights(false, self.Owner)
		wep:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
		timer.Simple( entertime, function() self:DoManualReload() end)
	else end
return true
end

function SWEP:DoManualReload()
	local ply = self:GetOwner()
	local loopseq = self:SelectWeightedSequence( ACT_VM_RELOAD )
	local looptime = self:SequenceDuration( loopseq )

	if self:IsValid() && ply:IsValid() && ply:Alive() then
		self.ManuallyReloading = true
		self:SetIronsights(false, self.Owner)
		self:GetOwner():RemoveAmmo( 1, self.Primary.Ammo, false )
		self:SetClip1(( self:Clip1() + self.Primary.APS ))

		if CLIENT or SERVER then
			self:SendWeaponAnim(ACT_VM_RELOAD)
		end
		timer.Simple( looptime, function() self:ManualReloadLoop() end)
	else end
end

function SWEP:ManualReloadLoop()
local ply = self:GetOwner()
	if self:IsValid() && ply:IsValid() && ply:Alive() then
		self:SendWeaponAnim(ACT_VM_RELOAD)
			if self:Clip1() <= self.Primary.ClipSize then
				if ply:KeyDown(IN_RELOAD) && self:Clip1() < self.Primary.ClipSize then
					if ( ply:GetAmmoCount(self.Primary.Ammo) ) > 0 then
						self:DoManualReload()
					else
						self:FinishManualReload()
					end
				else
					self:FinishManualReload()
				end
			end
	else end
end

function SWEP:FinishManualReload()
	local ply = self:GetOwner()
	local loopseq = self:SelectWeightedSequence( ACT_VM_RELOAD )
	local looptime = self:SequenceDuration( loopseq )
	if self:IsValid() && ply:IsValid() && ply:Alive() then
		self.ManuallyReloading = false
		self.IronCD = false
		self:SetHoldType( self.HoldType )
		self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
		
		timer.Simple( looptime, function() self:ManuallyLoadAfterReload() end)
	else end
end

function SWEP:ManuallyLoadAfterReload()
	local ply = self:GetOwner()
	if self:IsValid() && ply:IsValid() && ply:Alive() then
		if self:GetNWBool("reloadedEmpty") == true && self.LoadAfterReloadEmpty == true then
			self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
		else end
	else end
end

function SWEP:Taunt()
	local ply = self:GetOwner()
	local tauntsounds = self.TauntSounds
	
	if self.TauntSounds == nil then else
		self.IsTaunting = 1
		ply:EmitSound( table.Random( self.TauntSounds ) )
		timer.Simple( self.TauntCooldown, function() self:TauntReady() end)
	end
end

function SWEP:ShootEffects()
	if self.Loading == false && self.ManuallyReloading == false then
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	else end
end