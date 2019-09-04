--[[

	GITHUB :: https://github.com/Vuthakral/Draconic_SWEP_Base
	Report issues you find THERE ^ and not on the Garry's Mod workshop, please and thank you.

	// CREDITS //
		Vuthakral: http://steamcommunity.com/profiles/76561198050250649
	- SWEP Base, everything except for:
	
		Wingblast: http://steamcommunity.com/profiles/76561198065151971
	- Dynamic movement of viewmodels based on eye angles (the up/down adjust)
	
		Death: http://steamcommunity.com/profiles/76561197978925248
	- Helping me troubleshoot a fair amount of problems I ran into while working on the block system & hooks
	
		Gluk SWEP melee pack ( shoutout: https://steamcommunity.com/sharedfiles/filedetails/?id=1630549918&searchtext=Gluk )
	- Nothing was directly taken from this addon, but I did use it to see how they did melee code so I could make my own, since facepunch is ded
	
		Clavus: http://steamcommunity.com/profiles/76561197970953315
	- Creation of the immensely handy SWEP construction kit, which is of course supported by this base.
	
--]]

SWEP.Gun				= "draconic_base"

SWEP.HoldType			= "default"
SWEP.CrouchHoldType		= "default"
SWEP.IdleSequence		= "idle"
SWEP.WalkSequence		= "idle"
SWEP.Category			= "Draconic"
SWEP.PrintName			= "Draconic Base"
SWEP.Auhtor				= "Vuthakral"
SWEP.Contact			= " https://discord.gg/6Y7WXrX // Steam: Vuthakral // Disc: Vuthakral#9761 "
SWEP.Purpose			= "SWEP Base"
SWEP.Instructions		= "open rectum & insert"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.DeploySpeed		= 1
SWEP.Weight				= 1

SWEP.Slot				= 0
SWEP.SlotPos			= 0

SWEP.ViewModelFOV		= 54
SWEP.ViewModelFlip		= false
SWEP.DrawAmmo			= true

SWEP.WallHax	= false
SWEP.InfAmmo	= false

SWEP.UseHands			= true
SWEP.ViewModel			= ""
SWEP.WorldModel			= ""
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.SS = 0
SWEP.BS = 1
SWEP.InspectDelay = 0.5

SWEP.IdleActivity = ACT_VM_IDLE
SWEP.CrouchIdleActivity = ACT_VM_IDLE

SWEP.Secondary.CanBlock				= false
SWEP.Secondary.CanBlockCrouched		= false
SWEP.Secondary.BlockKeyInput		= IN_USE
SWEP.Secondary.BlockHoldType		= "melee2"
SWEP.Secondary.BlockHoldTypeCrouch	= "melee2"
SWEP.Secondary.BlockActivity		= ACT_VM_IDLE_EMPTY_LEFT
SWEP.Secondary.DamageBlockMult		= 0.5
SWEP.Secondary.BlockBreakDelay		= 0.72
SWEP.Secondary.BlockingWalkSpeed	= 170
SWEP.Secondary.BlockingSprintSpeed	= 170

-- Recognized block types: 1: passthrough (none), 2: reduce (SWEP.Secondary.DamageBlockMult), 3: block (negates all damage), 4: breakblock (forces player out of block)
SWEP.BlockType_DMG_GENERIC		= 3
SWEP.BlockType_DMG_CRUSH		= 2
SWEP.BlockType_DMG_BULLET		= 1
SWEP.BlockType_DMG_SLASH		= 2
SWEP.BlockType_DMG_BURN			= 1
SWEP.BlockType_DMG_VEHICLE		= 4
SWEP.BlockType_DMG_FALL			= 4
SWEP.BlockType_DMG_BLAST		= 4
SWEP.BlockType_DMG_CLUB			= 2
SWEP.BlockType_DMG_SHOCK		= 1
SWEP.BlockType_DMG_SONIC		= 1
SWEP.BlockType_DMG_ENERGYBEAM	= 1
SWEP.BlockType_DMG_PREVENT_PHYSICS_FORCE = 2
SWEP.BlockType_DMG_NEVERGIB		= 2
SWEP.BlockType_DMG_ALWAYSGIB	= 4
SWEP.BlockType_DMG_DROWN		= 1
SWEP.BlockType_DMG_PARALYZE		= 1
SWEP.BlockType_DMG_NERVEGAS		= 1
SWEP.BlockType_DMG_POISON		= 1
SWEP.BlockType_DMG_RADIATION	= 1
SWEP.BlockType_DMG_DROWNRECOVER	= 1
SWEP.BlockType_DMG_ACID			= 1
SWEP.BlockType_DMG_SLOWBURN		= 1
SWEP.BlockType_DMG_REMOVENORAGDOLL = 4
SWEP.BlockType_DMG_PHYSGUN 		= 4
SWEP.BlockType_DMG_PLASMA 		= 1
SWEP.BlockType_DMG_AIRBOAT 		= 4
SWEP.BlockType_DMG_DISSOLVE 	= 4
SWEP.BlockType_DMG_BLAST_SURFACE = 4
SWEP.BlockType_DMG_BLAST_DIRECT = 1
SWEP.BlockType_DMG_BUCKSHOT 	= 4
SWEP.BlockType_DMG_SNIPER 		= 1
SWEP.BlockType_DMG_MISSILEDEFENSE = 4

SWEP.SprintSoundStand		= Sound( "" )
SWEP.DoSSStandFwd			= false
SWEP.DoSSStandBack			= false
SWEP.DoSSStandLeft			= false
SWEP.DoSSStandRight			= false

SWEP.SprintSoundCrouch		= Sound( "" )
SWEP.DoSSCrouchFwd			= false
SWEP.DoSSCrouchBack			= false
SWEP.DoSSCrouchLeft			= false
SWEP.DoSSCrouchRight		= false

SWEP.SJumpCrouchSound		= Sound( "" )
SWEP.DoSJCrouchSFwd			= false
SWEP.DoSJCrouchSBack		= false
SWEP.DoSJCrouchLeft			= false
SWEP.DoSJCrouchhRight		= false

SWEP.SpeedStandForward		= 0
SWEP.SpeedStandBack			= 0
SWEP.SpeedStandLeft			= 0
SWEP.SpeedStandRight		= 0

SWEP.SpeedCrouchForward		= 0
SWEP.SpeedCrouchBack		= 0
SWEP.SpeedCrouchLeft		= 0
SWEP.SpeedCrouchRight		= 0

SWEP.SpeedSprintStandForward	= 0
SWEP.SpeedSprintStandBack		= 0
SWEP.SpeedSprintStandLeft		= 0
SWEP.SpeedSprintStandRight		= 0

SWEP.SpeedSprintCrouchForward	= 0
SWEP.SpeedSprintCrouchBack		= 0
SWEP.SpeedSprintCrouchLeft		= 0
SWEP.SpeedSprintCrouchRight		= 0

SWEP.StandingJumpHeightFront			= 0
SWEP.StandingJumpHeightBack				= 0
SWEP.StandingJumpHeightLeft				= 0
SWEP.StandingJumpHeightRight			= 0

SWEP.CrouchingJumpHeightFront			= 0
SWEP.CrouchingJumpHeightBack			= 0
SWEP.CrouchingJumpHeightLeft			= 0
SWEP.CrouchingJumpHeightRight			= 0

SWEP.StandingSprintJumpHeightFront		= 0
SWEP.StandingSprintJumpHeightBack		= 0
SWEP.StandingSprintJumpHeightLeft		= 0
SWEP.StandingSprintJumpHeightRight		= 0

SWEP.CrouchingSprintJumpHeightFront		= 0
SWEP.CrouchingSprintJumpHeightBack		= 0
SWEP.CrouchingSprintJumpHeightLeft		= 0
SWEP.CrouchingSprintJumpHeightRight		= 0

SWEP.Idle = 0
SWEP.IdleTimer = CurTime()
SWEP.IsTaunting = 0
SWEP.TauntCooldown = 1
SWEP.PassiveHealing			= ""
SWEP.FallDamage				= true
SWEP.NoFallDamageCrouchOnly = true
SWEP.HealthRegen 			= false
SWEP.HealAmount				= 1
SWEP.HealInterval			= 1
SWEP.WeaponIdleLoopSound 	= ("")
SWEP.FireMode	= "none"

SWEP.BlockType_DMG_GENERIC		= 3
SWEP.BlockType_DMG_CRUSH		= 2
SWEP.BlockType_DMG_BULLET		= 1
SWEP.BlockType_DMG_SLASH		= 2
SWEP.BlockType_DMG_BURN			= 1
SWEP.BlockType_DMG_VEHICLE		= 4
SWEP.BlockType_DMG_FALL			= 4
SWEP.BlockType_DMG_BLAST		= 4
SWEP.BlockType_DMG_CLUB			= 2
SWEP.BlockType_DMG_SHOCK		= 1
SWEP.BlockType_DMG_SONIC		= 1
SWEP.BlockType_DMG_ENERGYBEAM	= 1
SWEP.BlockType_DMG_PREVENT_PHYSICS_FORCE = 2
SWEP.BlockType_DMG_NEVERGIB		= 2
SWEP.BlockType_DMG_ALWAYSGIB	= 4
SWEP.BlockType_DMG_DROWN		= 1
SWEP.BlockType_DMG_PARALYZE		= 1
SWEP.BlockType_DMG_NERVEGAS		= 1
SWEP.BlockType_DMG_POISON		= 1
SWEP.BlockType_DMG_RADIATION	= 1
SWEP.BlockType_DMG_DROWNRECOVER	= 1
SWEP.BlockType_DMG_ACID			= 1
SWEP.BlockType_DMG_SLOWBURN		= 1
SWEP.BlockType_DMG_REMOVENORAGDOLL = 4
SWEP.BlockType_DMG_PHYSGUN 		= 4
SWEP.BlockType_DMG_PLASMA 		= 1
SWEP.BlockType_DMG_AIRBOAT 		= 4
SWEP.BlockType_DMG_DISSOLVE 	= 4
SWEP.BlockType_DMG_BLAST_SURFACE = 4
SWEP.BlockType_DMG_BLAST_DIRECT = 1
SWEP.BlockType_DMG_BUCKSHOT 	= 4
SWEP.BlockType_DMG_SNIPER 		= 1
SWEP.BlockType_DMG_MISSILEDEFENSE = 4

function SWEP:DoDrawCrosshair( x, y )
	surface.SetDrawColor( 0, 0, 0, 0 )
--	surface.DrawOutlinedRect( x -32, y -32, 64, 64 )
	return true
end

function SWEP:Initialize()
local ply = self:GetOwner()
	if ply:EntIndex() == 0 then
		self:SetHoldType(self.HoldType)
	elseif ply:IsPlayer() then
		self:SetHoldType(self.HoldType)
	elseif ply:IsNPC() then
		self:SetHoldType(self.HoldType)
	else
	end
	self:DoCustomInitialize()
	self:SetNWInt("Heat", 0)
	self.Passive = false
	
	
	if self.Primary.Automatic == false then
		self.Weapon:SetNWString("FireMode", "Semi")
	elseif self.Primary.Automatic == true then
		self.Weapon:SetNWString("FireMode", "Auto")
	elseif self.Primary.Automatic == true or false && self.FireModes_CanBurst == true && self.FireModes_CanAuto == false then
		self.Weapon:SetNWString("FireMode", "Burst")
	else end
	
	if self.Primary.Ammo != nil then
		self.Weapon:SetNWInt("LoadedAmmo", self.Primary.DefaultClip)
	else end
	
	-- SCK Stuff
	if CLIENT && self:GetOwner():IsPlayer() then
	
		// Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )
		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels
		
		// init view model bone build function
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
				// Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					// we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					// ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					// however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")			
				end
			end
		end
		
	end
end

function SWEP:DoCustomInitialize()
end

function SWEP:Think()
local ply = self:GetOwner()
local cv = ply:Crouching()
local vm = ply:GetViewModel()

self:DoCustomThink()

self.ScopeHookID = "DRC_Scope_" .. ply:Name() .. ""

if CLIENT or SERVER then
	if ply:IsNPC() then
		self:SetHoldType( self.HoldType )
	else end
else end
	
if CLIENT or SERVER then
	if self.Secondary.Ironsights == true && self.IronCD == false && !ply:KeyDown(self.Secondary.BlockKeyInput) then
		if ply:KeyPressed(IN_ATTACK2) == true && self.Weapon:GetNWBool("ironsights") == false && self.IronCD == false && self.Passive == false then
			self:SetIronsights(true, self.Owner)
			ply:SetFOV(self.Secondary.IronFOV, self.Secondary.ScopeZoomTime)
			self:AdjustMouseSensitivity()
			self.Weapon:SetNWBool("ironsights", true )
			self:IronCoolDown()
			ply:EmitSound("draconic.IronInGeneric")
		elseif ply:KeyReleased(IN_ATTACK2) == true && self.Weapon:GetNWBool("ironsights") == true && self.IronCD == false then
			self.Weapon:SetNWBool("ironsights", false )
			self:SetIronsights(false, self.Owner)
			ply:SetFOV(0, self.Secondary.ScopeZoomTime)
			ply:EmitSound("draconic.IronOutGeneric")
		end
	elseif self.Secondary.Ironsights == false or self.IronCD == true then
		self:SetIronsights(false, self.Owner)
	end
	
	if CLIENT && self.Weapon:GetNWBool("ironsights") == false then
		hook.Remove("HUDPaint", self.ScopeHookID)
	else end
	
if CLIENT && self.Weapon:GetNWBool("ironsights") == true && self.Secondary.Scoped == true then
	self.ScopeUp = true
	hook.Add("HUDPaint", self.ScopeHookID, function()
	local scrH = surface.ScreenHeight()
	local scrW = surface.ScreenWidth()
	local scopeWidth = ( 4 / 3 ) * scrH
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetTexture( surface.GetTextureID(self.Secondary.ScopeMat))
	surface.DrawTexturedRect( 0, 0, scrW, scrH  )
	end )
elseif CLIENT && self.Weapon:GetNWBool("ironsights") == false then
	hook.Remove("HUDPaint", self.ScopeHookID)
	self.ScopeUp = false
end
end
	
		if ply:GetVelocity():Length() > 0 && ply:OnGround() then
		self.Idle = 0
		elseif ply:GetVelocity():Length() < 1 or !ply:OnGround() then
		self.Idle = 1
		end
		
	if self.IdleTimer <= CurTime() && self.Loading == false && self.ManuallyReloading == false && self.Inspecting == 0 then
		
			local curSeq = vm:GetSequence()
			local seqInfo = vm:GetSequenceInfo(curSeq)
			local walkSeq = vm:LookupSequence(self.WalkSequence)
			local idleSeq = vm:LookupSequence(self.IdleSequence)
			local walkSeqDur = vm:SequenceDuration(walkSeq)
			local idleSeqDur = vm:SequenceDuration(idleSeq)
		
		if seqInfo.label == idle01 && ply:GetVelocity():Length() > 0 && ply:OnGround() then
			vm:SendViewModelMatchingSequence(walkSeq)
		elseif seqInfo.label == walk && ply:GetVelocity():Length() < 1 && ply:OnGround() then
			vm:SendViewModelMatchingSequence(idleSeq)
		elseif seqInfo.label == walk && ply:GetVelocity():Length() >= 1 && ply:OnGround() then
		end
			
		if ply:GetVelocity():Length() < 1 && ply:OnGround() then
			self.IdleTimer = CurTime() + idleSeqDur
			vm:SendViewModelMatchingSequence(idleSeq)
		elseif ply:GetVelocity():Length() > 0 && ply:OnGround() then
			self.IdleTimer = CurTime() + walkSeqDur
			vm:SendViewModelMatchingSequence(walkSeq)
		end
	end 
	
	if self.IsBlocking == 1 && ply:GetNWBool("IsAttacking") == false then
			if cv == false then
				if CLIENT or SERVER then
	--			self:SetHoldType( self.Secondary.BlockHoldType )
				self.Weapon:SendWeaponAnim( self.Secondary.BlockActivity )
				end
			elseif cv == true then
				if CLIENT or SERVER then
				self:SetHoldType( self.Secondary.BlockHoldTypeCrouch )
				self.Weapon:SendWeaponAnim( self.Secondary.BlockActivity )
				end
			end
		ply:SetNWBool( "IsBlocking", true )
	elseif self.IsBlocking == 0 && ply:GetNWBool("IsAttacking") == false then
			if cv == false then
				if CLIENT or SERVER then
	--			self:SetHoldType( self.HoldType )
				end
			elseif cv == true then
				if CLIENT or SERVER then
	--			self:SetHoldType( self.CrouchHoldType )
				end
			end
		ply:SetNWBool( "IsBlocking", false )
	elseif self.IsBlocking == 0 && !ply:GetNWBool("IsAttacking") == false then
	end
	
	--					if ply:GetNWBool("IsBlocking") == true then
	--						ply:ChatPrint("Blocking")
	--					elseif ply:GetNWBool("IsBlocking") == false then
	--						ply:ChatPrint("Not Blocking")
	--					end
	
	if CLIENT then
		if self.WallHax == true then
		self:PlayerHalos()
		elseif self.WallHax == false then
		end
	end
	
	if CLIENT or SERVER then
	local ply = self:GetOwner()
		if ply:Health() < 1 then
			hook.Remove( "Move",self.HookUID_1 )
			hook.Remove( "Move",self.HookUID_2 )
			hook.Remove( "Move",self.HookUID_3 )
			hook.Remove( "Move",self.HookUID_4 )
--			hook.Remove( "Think",self.HookUID_5 )
			hook.Remove( "EntityTakeDamage",self.HookUID_6 )
		else
		end
	end
	
		if self.Secondary.CanBlock == true then
			if ply:KeyReleased(self.Secondary.BlockKeyInput) then
				self.IsBlocking = 0
				ply:SetNWBool("IsBlocking", false)
			elseif ply:KeyDown(self.Secondary.BlockKeyInput) && ply:KeyDown(IN_ATTACK2) && cv == false then
				if CLIENT or SERVER then
				self.Weapon:SendWeaponAnim( self.Secondary.BlockActivity )
				self:SetHoldType( self.Secondary.HoldType )
				end
				self:DoBlock()
			elseif ply:KeyDown(self.Secondary.BlockKeyInput) && ply:KeyDown(IN_ATTACK2) && cv == true && self.Secondary.CanBlockCrouched == false then
				self.IsBlocking = 0
				ply:SetNWBool("IsBlocking", false)
			elseif ply:KeyDown(self.Secondary.BlockKeyInput) && ply:KeyDown(IN_ATTACK2) && cv == true && self.Secondary.CanBlockCrouched == true then
				if CLIENT or SERVER then
				self.Weapon:SendWeaponAnim( self.Secondary.BlockActivity )
				self:SetHoldType( self.Secondary.HoldType )
				end
				self:DoBlock()
			end
		elseif self.Secondary.CanBlock == false then
		end
end

function SWEP:DoCustomThink()
end

function SWEP:Reload()

end

function SWEP:Deploy()
local ply = self:GetOwner()
local cv = ply:Crouching()
	if ply:EntIndex() == 0 then else
		if self.Passive == true then
		self:DoPassiveHoldtype()
		else
		self:SetHoldType( self.HoldType )
		end

	if CLIENT then
	hook.Remove( "HUDPaint", self.ScopeHookID )
	else end

	self.Weapon:SetNWBool( "Ironsights", false )
	
	self.IsBlocking = 0
	self.IsTaunting = 0
	
	ply:SetNWBool( "IsAttacking", false )
	ply:SetNWBool( "IsBlocking", false )
	
	ply:SetNWFloat( "PlayerOGSpeed", ply:GetRunSpeed() )
	ply:SetNWFloat( "PlayerOGWalk", ply:GetWalkSpeed() )
	ply:SetNWFloat( "PlayerOGJump", ply:GetJumpPower() )
	ply:SetNWFloat( "PlayerOGCrouch", ply:GetCrouchedWalkSpeed() )
	
	ply:SetNWFloat( "block_dmg_generic", self.BlockType_DMG_GENERIC )
	ply:SetNWFloat( "block_dmg_crush", self.BlockType_DMG_CRUSH )

	ply:StartLoopingSound(self.WeaponIdleLoopSound)
	
	if self.Passive == true then else
		self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	end
self.Idle = 0
self.IsBlocking = 0
self.Inspecting = 0
self.EmptyReload = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
self.ManuallyReloading 	= false
self.Loading			= false

	local vm = self.Owner:GetViewModel()
	if self.Passive == true then else
		vm:SendViewModelMatchingSequence( vm:SelectWeightedSequence( ACT_VM_DRAW ) )
	end
	vm:SetPlaybackRate( 1 )

	self:SetNextPrimaryFire( CurTime() + vm:SequenceDuration())
	self:SetNextSecondaryFire( CurTime() + vm:SequenceDuration())
	
self:RegeneratingHealth(ply)

	if self.Primary.Ammo == "CombineHeavyCannon" then
	self.Weapon:SetNWFloat("HeatDispersePower", 1)
		self:DisperseHeat()
	else end
	
	if self.Primary.Ammo != nil then
		
	else end

	self.HookUID_1 = "Draconic_HOOK_UID_"..ply:Name().."_Movement"
--	print(self.HookUID_1)
	
	self.HookUID_2 = "Draconic_HOOK_UID_"..ply:Name().."_CrouchSprint"
--	print(self.HookUID_2)
	
	self.HookUID_3 = "Draconic_HOOK_UID_"..ply:Name().."_SprintJumpCrouch"
--	print(self.HookUID_3)
	
	self.HookUID_4 = "Draconic_HOOK_UID_"..ply:Name().."_FallDamage"
--	print(self.HookUID_4)
	
--	self.HookUID_5 = "Draconic_HOOK_UID_"..math.random(69, 999999999).."_"..ply:Name().."_Blocking"
--	print(self.HookUID_5)

	self.HookUID_6 = "Draconic_HOOK_UID_"..ply:Name().."_BlockingTakeDamage"
--	print(self.HookUID_6)
	
	if ( SERVER ) && ply:IsPlayer() then
	local ply = self:GetOwner()
			
		hook.Add("Move", self.HookUID_1, function(ply,mv)
		local cv = ply:Crouching()
		local forwkey = ply:KeyDown(IN_FORWARD)
		local backkey = ply:KeyDown(IN_BACK)
		local leftkey = ply:KeyDown(IN_MOVELEFT)
		local rightkey = ply:KeyDown(IN_MOVERIGHT)
		local sprintkey = ply:KeyDown(IN_SPEED)
		local swimming = ply:WaterLevel() > 1
		local dry = ply:WaterLevel() < 1
		
			if cv == true then
				if swimming then
				
				elseif dry then
					if forwkey && !sprintkey then
						if self.SpeedCrouchForward > 0 then
							ply:SetWalkSpeed( self.SpeedCrouchForward )
							ply:SetRunSpeed( self.SpeedCrouchForward )
								if self.CrouchingJumpHeightFront > 0 then
									ply:SetJumpPower( self.CrouchingJumpHeightFront )
								elseif self.CrouchingJumpHeightFront == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed ( 1 )
						elseif self.SpeedCrouchForward == 0 then
							ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
							ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
								if self.CrouchingJumpHeightFront > 0 then
									ply:SetJumpPower( self.CrouchingJumpHeightFront )
								elseif self.CrouchingJumpHeightFront == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
						end
					elseif backkey && !sprintkey then
						if self.SpeedCrouchBack > 0 then
							ply:SetWalkSpeed( self.SpeedCrouchBack )
							ply:SetRunSpeed( self.SpeedCrouchBack )
								if self.CrouchingJumpHeightBack > 0 then
									ply:SetJumpPower( self.CrouchingJumpHeightBack )
								elseif self.CrouchingJumpHeightBack == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed ( 1 )
						elseif self.SpeedCrouchBack == 0 then
							ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
							ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
								if self.CrouchingJumpHeightBack > 0 then
									ply:SetJumpPower( self.CrouchingJumpHeightBack )
								elseif self.CrouchingJumpHeightBack == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
						end
					elseif leftkey && !sprintkey then
						if self.SpeedCrouchLeft > 0 then
							ply:SetWalkSpeed( self.SpeedCrouchLeft )
							ply:SetRunSpeed( self.SpeedCrouchLeft )
								if self.CrouchingJumpHeightLeft > 0 then
									ply:SetJumpPower( self.CrouchingJumpHeightLeft )
								elseif self.CrouchingJumpHeightLeft == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed ( 1 )
						elseif self.SpeedCrouchLeft == 0 then
							ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
							ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
								if self.CrouchingJumpHeightLeft > 0 then
									ply:SetJumpPower( self.CrouchingJumpHeightLeft )
								elseif self.CrouchingJumpHeightLeft == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
						end
					elseif rightkey && !sprintkey then
						if self.SpeedCrouchRight > 0 then
							ply:SetWalkSpeed( self.SpeedCrouchRight )
							ply:SetRunSpeed( self.SpeedCrouchRight )
								if self.CrouchingJumpHeightRight > 0 then
									ply:SetJumpPower( self.CrouchingJumpHeightRight )
								elseif self.CrouchingJumpHeightRight == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed ( 1 )
						elseif self.SpeedCrouchRight == 0 then
							ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
							ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
								if self.CrouchingJumpHeightRight > 0 then
									ply:SetJumpPower( self.CrouchingJumpHeightRight )
								elseif self.CrouchingJumpHeightRight == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
						end
					elseif forwkey && sprintkey then
						if self.SpeedSprintCrouchForward > 0 then
							ply:SetWalkSpeed( self.SpeedSprintCrouchForward )
							ply:SetRunSpeed( self.SpeedSprintCrouchForward )
								if self.StandingSprintJumpHeightFront > 0 then
									ply:SetJumpPower( self.CrouchingSprintJumpHeightFront )
								elseif self.StandingSprintJumpHeightFront == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed ( 1 )
						elseif self.SpeedCrouchForward == 0 then
							ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
							ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
							ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								if self.StandingSprintJumpHeightFront > 0 then
									ply:SetJumpPower( self.StandingSprintJumpHeightFront )
								elseif self.StandingSprintJumpHeightFront == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
						end
					elseif backkey && sprintkey then
						if self.SpeedSprintCrouchBack > 0 then
							ply:SetWalkSpeed( self.SpeedSprintCrouchBack )
							ply:SetRunSpeed( self.SpeedSprintCrouchBack )
								if self.CrouchingSprintJumpHeightBack > 0 then
									ply:SetJumpPower( self.CrouchingSprintJumpHeightBack )
								elseif self.CrouchingSprintJumpHeightBack == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed ( 1 )
						elseif self.SpeedCrouchBack == 0 then
							ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
							ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
								if self.CrouchingSprintJumpHeightBack > 0 then
									ply:SetJumpPower( self.CrouchingSprintJumpHeightBack )
								elseif self.CrouchingSprintJumpHeightBack == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
						end
					elseif leftkey && sprintkey then
						if self.SpeedSprintCrouchLeft > 0 then
							ply:SetWalkSpeed( self.SpeedSprintCrouchLeft )
							ply:SetRunSpeed( self.SpeedSprintCrouchLeft )
								if self.CrouchingSprintJumpHeightLeft > 0 then
									ply:SetJumpPower( self.CrouchingSprintJumpHeightLeft )
								elseif self.CrouchingSprintJumpHeightLeft == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed ( 1 )
						elseif self.SpeedCrouchLeft == 0 then
							ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
							ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
								if self.CrouchingSprintJumpHeightLeft > 0 then
									ply:SetJumpPower( self.CrouchingSprintJumpHeightLeft )
								elseif self.CrouchingSprintJumpHeightLeft == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
						end
					elseif rightkey && sprintkey then
						if self.SpeedSprintCrouchRight > 0 then
							ply:SetWalkSpeed( self.SpeedSprintCrouchRight )
							ply:SetRunSpeed( self.SpeedSprintCrouchRight )
								if self.CrouchingSprintJumpHeightRight > 0 then
									ply:SetJumpPower( self.CrouchingSprintJumpHeightRight )
								elseif self.CrouchingSprintJumpHeightRight == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed ( 1 )
						elseif self.SpeedCrouchRight == 0 then
							ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
							ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
								if self.CrouchingSprintJumpHeightRight > 0 then
									ply:SetJumpPower( self.CrouchingSprintJumpHeightRight )
								elseif self.CrouchingSprintJumpHeightRight == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
						end
					end
				end
			elseif cv == false then
				if swimming then
				
				elseif dry then
					if forwkey && !sprintkey then
						if self.SpeedStandForward > 0 then
							ply:SetWalkSpeed( self.SpeedStandForward )
							ply:SetRunSpeed( self.SpeedStandForward )
								if self.StandingJumpHeightFront > 0 then
									ply:SetJumpPower( self.StandingJumpHeightFront )
								elseif self.StandingJumpHeightFront == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed ( 1 )
						elseif self.SpeedStandForward == 0 then
							ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
							ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
								if self.StandingJumpHeightFront > 0 then
									ply:SetJumpPower( self.StandingJumpHeightFront )
								elseif self.StandingJumpHeightFront == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
						end
					elseif backkey && !sprintkey then
						if self.SpeedStandBack > 0 then
							ply:SetWalkSpeed( self.SpeedStandBack )
							ply:SetRunSpeed( self.SpeedStandBack )
								if self.StandingJumpHeightBack > 0 then
									ply:SetJumpPower( self.StandingJumpHeightBack )
								elseif self.StandingJumpHeightBack == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed ( 1 )
						elseif self.SpeedStandBack == 0 then
							ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
							ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
								if self.StandingJumpHeightBack > 0 then
									ply:SetJumpPower( self.StandingJumpHeightBack )
								elseif self.StandingJumpHeightBack == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
						end
					elseif leftkey && !sprintkey then
						if self.SpeedStandLeft > 0 then
							ply:SetWalkSpeed( self.SpeedStandLeft )
							ply:SetRunSpeed( self.SpeedStandLeft )
								if self.StandingJumpHeightLeft > 0 then
									ply:SetJumpPower( self.StandingJumpHeightLeft )
								elseif self.StandingJumpHeightLeft == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed ( 1 )
						elseif self.SpeedStandLeft == 0 then
							ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
							ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
								if self.StandingJumpHeightLeft > 0 then
									ply:SetJumpPower( self.StandingJumpHeightLeft )
								elseif self.StandingJumpHeightLeft == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
						end
					elseif rightkey && !sprintkey then
						if self.SpeedStandRight > 0 then
							ply:SetWalkSpeed( self.SpeedStandRight )
							ply:SetRunSpeed( self.SpeedStandRight )
								if self.StandingJumpHeightRight > 0 then
									ply:SetJumpPower( self.StandingJumpHeightRight )
								elseif self.StandingJumpHeightRight == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed ( 1 )
						elseif self.SpeedStandRight == 0 then
							ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
							ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
								if self.StandingJumpHeightRight > 0 then
									ply:SetJumpPower( self.StandingJumpHeightRight )
								elseif self.StandingJumpHeightRight == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
						end
					elseif forwkey && sprintkey then
						if self.SpeedSprintStandForward > 0 then
							ply:SetWalkSpeed( self.SpeedStandForward )
							ply:SetRunSpeed( self.SpeedSprintStandForward )
								if self.StandingSprintJumpHeightFront > 0 then
									ply:SetJumpPower( self.StandingSprintJumpHeightFront )
								elseif self.StandingSprintJumpHeightFront == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed ( 1 )
						elseif self.SpeedSprintStandForward == 0 then
							ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
							ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
								if self.StandingSprintJumpHeightFront > 0 then
									ply:SetJumpPower( self.StandingSprintJumpHeightFront )
								elseif self.StandingSprintJumpHeightFront == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
						end
					elseif backkey && sprintkey then
						if self.SpeedSprintStandBack > 0 then
							ply:SetWalkSpeed( self.SpeedStandBack )
							ply:SetRunSpeed( self.SpeedSprintStandBack )
								if self.StandingSprintJumpHeightBack > 0 then
									ply:SetJumpPower( self.StandingSprintJumpHeightBack )
								elseif self.StandingSprintJumpHeightBack == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed ( 1 )
						elseif self.SpeedSprintStandBack == 0 then
							ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
							ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
								if self.StandingSprintJumpHeightBack > 0 then
									ply:SetJumpPower( self.StandingSprintJumpHeightBack )
								elseif self.StandingSprintJumpHeightBack == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
						end
					elseif leftkey && sprintkey then
						if self.SpeedSprintStandLeft > 0 then
							ply:SetWalkSpeed( self.SpeedStandLeft )
							ply:SetRunSpeed( self.SpeedSprintStandLeft )
								if self.StandingSprintJumpHeightLeft > 0 then
									ply:SetJumpPower( self.StandingSprintJumpHeightLeft )
								elseif self.StandingSprintJumpHeightLeft == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed ( 1 )
						elseif self.SpeedSprintStandLeft == 0 then
							ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
							ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
								if self.StandingSprintJumpHeightLeft > 0 then
									ply:SetJumpPower( self.StandingSprintJumpHeightLeft )
								elseif self.StandingSprintJumpHeightLeft == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
						end
					elseif rightkey && sprintkey then
						if self.SpeedSprintStandRight > 0 then
							ply:SetWalkSpeed( self.SpeedStandRight )
							ply:SetRunSpeed( self.SpeedSprintStandRight )
								if self.StandingSprintJumpHeightRight > 0 then
									ply:SetJumpPower( self.StandingSprintJumpHeightRight )
								elseif self.StandingSprintJumpHeightRight == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed ( 1 )
						elseif self.SpeedSprintStandRight == 0 then
							ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
							ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
								if self.StandingSprintJumpHeightRight > 0 then
									ply:SetJumpPower( self.StandingSprintJumpHeightRight )
								elseif self.StandingSprintJumpHeightRight == 0 then
									ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
								end
							ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
						end
					end
				end
			end
		end)
		
		hook.Add("Move", self.HookUID_2, function(ply,mv)
		local cv = ply:Crouching()
			if ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_FORWARD) && ply:KeyPressed(IN_SPEED) && self.DoSSCrouchFwd == true then
			-- crouch sprint sound forward
				ply:EmitSound( self.SprintSoundCrouch )
			elseif ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_BACK) && ply:KeyPressed(IN_SPEED) && self.DoSSCrouchBack == true then
			-- crouch sprint sound back
				ply:EmitSound( self.SprintSoundCrouch )
			elseif ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_MOVELEFT) && ply:KeyPressed(IN_SPEED) && self.DoSSCrouchLeft == true then
			-- crouch sprint sound left
				ply:EmitSound( self.SprintSoundCrouch )
			elseif ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_MOVERIGHT) && ply:KeyPressed(IN_SPEED) && self.DoSSCrouchRight == true then
			-- crouch sprint sound right
				ply:EmitSound( self.SprintSoundCrouch )
			end
		end)
		
		hook.Add("Move", self.HookUID_3, function(ply,mv)
		local cv = ply:Crouching()
			if ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_FORWARD) && ply:KeyPressed(IN_JUMP) && ply:KeyDown(IN_SPEED) && self.DoSJCrouchSFwd == true then
			-- Crouch Sprint Jump Sound Front
				ply:EmitSound( self.SJumpCrouchSound )
			elseif ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_BACK) && ply:KeyPressed(IN_JUMP) && ply:KeyDown(IN_SPEED) && self.DoSJCrouchSBack == true then
			-- Crouch Sprint Jump Sound Front
				ply:EmitSound( self.SJumpCrouchSound )
			elseif ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_MOVELEFT) && ply:KeyPressed(IN_JUMP) && ply:KeyDown(IN_SPEED) && self.DoSJCrouchLeft == true then
			-- Crouch Sprint Jump Sound Front
				ply:EmitSound( self.SJumpCrouchSound )
			elseif ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_MOVERIGHT) && ply:KeyPressed(IN_JUMP) && ply:KeyDown(IN_SPEED) && self.DoSJCrouchRight == true then
			-- Crouch Sprint Jump Sound Front
				ply:EmitSound( self.SJumpCrouchSound )
				end
		end)
		
		hook.Add("Move", self.HookUID_4, function(ply,mv)
		local cv = ply:Crouching()
			if self.FallDamage == false && self.NoFallDamageCrouchOnly == true then
				if cv == true then
					self.Owner.ShouldReduceFallDamage = true
				elseif  cv == false then
					self.Owner.ShouldReduceFallDamage = false
				end
			elseif self.FallDamage == false && self.NoFallDamageCrouchOnly == false then
				self.Owner.ShouldReduceFallDamage = true
			elseif self.FallDamage == true then
				self.Owner.ShouldReduceFallDamage = false
			end
		end)

		hook.Add("EntityTakeDamage", self.HookUID_6, ReduceFallDamage)
	else end

	self:DoCustomDeploy()
return true
end
end

function SWEP:DoCustomDeploy()
end

function SWEP:OnRemove()
self.Idle = 0
self.IdleTimer = CurTime()
self.Owner.ShouldReduceFallDamage = false
	if ( SERVER ) then
	local ply = self:GetOwner()
	if ply:IsPlayer() then
		hook.Remove( "Move", self.HookUID_1 )
		hook.Remove( "Move", self.HookUID_2 )
		hook.Remove( "Move", self.HookUID_3 )
		hook.Remove( "Move", self.HookUID_4 )
		hook.Remove( "EntityTakeDamage","BlockingTakeDamage" )
		hook.Remove( "HUDPaint", self.ScopeHookID )
		
		timer.Remove( self.PassiveHealing )
		if self.Primary.Ammo == "CombineHeavyCannon" then
		timer.Remove( self.HeatDisperseTimer )
		else end
		
		ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
		ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
		ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
		ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
	else end
	elseif CLIENT && self:IsValid() && self.ScopeUp == true then
		hook.Remove( "HUDPaint", self.ScopeHookID )
	end
	
	if self.Primary.Ammo == "CombineHeavyCannon" then
		local ventingsound = self.VentingSound
		self.Weapon:StopSound(ventingsound)
	end
	
	-- SCK
	self:Holster()
end

function SWEP:Holster()
self.Idle = 0
self.IdleTimer = CurTime()
self.Owner.ShouldReduceFallDamage = false

	if ( SERVER ) then
	local ply = self:GetOwner()
	if ply:IsPlayer() then
		ply:StopLoopingSound( 0 )
		hook.Remove( "Move", self.HookUID_1 )
		hook.Remove( "Move", self.HookUID_2 )
		hook.Remove( "Move", self.HookUID_3 )
		hook.Remove( "Move", self.HookUID_4 )
		hook.Remove( "EntityTakeDamage","BlockingTakeDamage" )
		
		timer.Remove( self.PassiveHealing )
		if self.Primary.Ammo == "CombineHeavyCannon" then
		timer.Remove( self.HeatDisperseTimer )
		else end
		
			
		ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
		ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
		ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
		ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
	elseif CLIENT && self:IsValid() && self.ScopeUp == true then
		hook.Remove( "HUDPaint", self.ScopeHookID )
	else end
	end
	
	if self.Primary.Ammo == "CombineHeavyCannon" then
		local ventingsound = self.VentingSound
		self.Weapon:StopSound(ventingsound)
	else end
	
	-- SCK
	if CLIENT and IsValid(self.Owner) && self:GetOwner():IsPlayer() then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	
return true
end

function SWEP:DoBlock()
	self.IsBlocking = 1
end

function SWEP:BreakBlock()
local ply = self:GetOwner()
	self.IsBlocking = 0
	ply:SetNWBool( "IsBlocking", false )
	self.Secondary.CanBlock = false
	timer.Simple( self.Secondary.BlockBreakDelay, function() self:BlockResurrect() end)
end


local function ReduceFallDamage(ent, dmginfo)
	if ent:IsPlayer() and ent.ShouldReduceFallDamage and dmginfo:IsFallDamage() then
		dmginfo:SetDamage(0)
	end
end

local IRONSIGHT_TIME = 0.25

function SWEP:GetViewModelPosition ( pos, ang )
local ply = self:GetOwner()
	local eyeangforward = ply:EyeAngles()
	local cv = ply:Crouching()
	

	local ironBool = self.Weapon:GetNetworkedBool( "Ironsights" )
	
	if (ironBool != self.lastIron) then
		self.lastIron = ironBool 
		self.fIronTime = CurTime()
	end
	
	local fIronTime = self.fIronTime or 0
	
	local Mul = 1
	
	if (fIronTime > CurTime() - IRONSIGHT_TIME) then
		Mul = math.Clamp((CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1)

		if (!ironBool) then Mul = 1 - Mul end
	end

	if self.Weapon:GetNWBool("Passive") == false then
		Mul = math.Clamp((CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1)
		pos = pos + (ang:Right() * self.VMPos.x + ang:Right() * (eyeangforward.x /135 * Mul))
		pos = pos + (ang:Forward() * self.VMPos.y + ang:Forward() * (eyeangforward.x /100 * 5 * Mul))
		pos = pos + (ang:Up() * self.VMPos.z + ang:Up() * (eyeangforward.x / -45 * Mul))
		ang:RotateAroundAxis(ang:Right() * (eyeangforward.x /30), self.VMAng.x * Mul)
		ang:RotateAroundAxis(ang:Up(), self.VMAng.y * Mul)
		ang:RotateAroundAxis(ang:Forward(), self.VMAng.z * Mul)
		
		self.SwayScale = self.SS
		self.BobScale = self.BS
	elseif self.Weapon:GetNWBool("Passive") == true then
		Mul = math.Clamp((CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1)
		pos = pos + (ang:Right() * self.PassivePos.x + ang:Right() * (eyeangforward.x /90 * Mul))
		pos = pos + (ang:Forward() * self.PassivePos.y + ang:Forward() * (eyeangforward.x /100 * 5 * Mul))
		pos = pos + (ang:Up() * (self.PassivePos.z - 6) + ang:Up() * (eyeangforward.x / 45 * Mul))
		ang:RotateAroundAxis(ang:Right() * (eyeangforward.x /125), self.PassiveAng.x * Mul)
		ang:RotateAroundAxis(ang:Up(), self.PassiveAng.y * Mul)
		ang:RotateAroundAxis(ang:Forward(), self.PassiveAng.z * Mul)
		
		self.SwayScale = self.SS
		self.BobScale = self.BS
	elseif self.Weapon:GetNWBool("ironsights") == true && self.Secondary.Scoped == false then
		Mul = math.Clamp((CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1)
		ang:RotateAroundAxis(ang:Right(), 	self.IronSightsAng.x * Mul)
		ang:RotateAroundAxis(ang:Up(), 	self.IronSightsAng.y * Mul)
		ang:RotateAroundAxis(ang:Forward(), self.IronSightsAng.z * Mul)
		pos = pos + (self.IronSightsPos.x) * ang:Right() * Mul
		pos = pos + (self.IronSightsPos.y) * ang:Forward() * Mul
		pos = pos + (self.IronSightsPos.z) * ang:Up() * Mul
	
		self.SwayScale 	= 0.3
		self.BobScale 	= 0.1
	elseif self.Weapon:GetNWBool("ironsights") == true && self.Secondary.Scoped == true then
		Mul = math.Clamp((CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1)
		ang:RotateAroundAxis(ang:Right(), 	self.IronSightsAng.x * Mul)
		ang:RotateAroundAxis(ang:Up(), 	self.IronSightsAng.y * Mul)
		ang:RotateAroundAxis(ang:Forward(), self.IronSightsAng.z * Mul)
		pos = pos + self.IronSightsPos.x * ang:Right() * Mul
		pos = pos + (self.IronSightsPos.y - 255) * ang:Forward() * Mul
		pos = pos + self.IronSightsPos.z * ang:Up() * Mul
	
		self.SwayScale 	= 0
		self.BobScale 	= 0
	end

	return pos, ang
end

function SWEP:PlayerHalos()
	if CLIENT then
		local ply = self:GetOwner()
		local players = player.GetAll()
		local entities = ents.FindInSphere( ply:GetPos(), 500 )
		if self.WallHax == true then 
		halo.Add(ents.FindByClass( "npc*" ), Color(70, 0, 0 ), 5, 5, 0, true, true )
		halo.Add(players, Color(30, 0, 0 ), 5, 5, 0, true, true )
		end
	end
end

function IsBlocking( target, dmginfo )
	if (  target:IsPlayer() and target:GetNWBool("IsBlocking") == true and target:Alive()  ) then
	local wpn = target:GetActiveWeapon()
		if ( dmginfo:GetDamageType() == DMG_GENERIC ) then
		ply:ChatPrint("Generic")
			if wpn.BlockType_DMG_GENERIC == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_GENERIC != 1 && wpn.BlockType_DMG_GENERIC == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_GENERIC == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_GENERIC == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_CRUSH ) then
		ply:ChatPrint("Crushed")
			if wpn.BlockType_DMG_CRUSH == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_CRUSH != 1 && wpn.BlockType_DMG_CRUSH == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_CRUSH == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_CRUSH == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_BULLET ) then
		ply:ChatPrint("Shot")
			if wpn.BlockType_DMG_BULLET == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_BULLET != 1 && wpn.BlockType_DMG_BULLET == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_BULLET == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_BULLET == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_SLASH ) then
			if wpn.BlockType_DMG_SLASH == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_SLASH != 1 && wpn.BlockType_DMG_SLASH == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_SLASH == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_SLASH == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_BURN ) then
			if wpn.BlockType_DMG_BURN == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_BURN != 1 && wpn.BlockType_DMG_BURN == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_BURN == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_BURN == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_VEHICLE ) then
			if wpn.BlockType_DMG_VEHICLE == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_VEHICLE != 1 && wpn.BlockType_DMG_VEHICLE == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_VEHICLE == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_VEHICLE == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_FALL ) then
			if wpn.BlockType_DMG_FALL == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_FALL != 1 && wpn.BlockType_DMG_FALL == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_FALL == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_FALL == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_BLAST ) then
			if wpn.BlockType_DMG_BLAST == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_BLAST != 1 && wpn.BlockType_DMG_BLAST == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_BLAST == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_BLAST == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_CLUB ) then
			if wpn.BlockType_DMG_CLUB == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_CLUB != 1 && wpn.BlockType_DMG_CLUB == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_CLUB == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_CLUB == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_SHOCK ) then
			if wpn.BlockType_DMG_SHOCK == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_SHOCK != 1 && wpn.BlockType_DMG_SHOCK == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_SHOCK == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_SHOCK == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_SONIC ) then
			if wpn.BlockType_DMG_SONIC == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_SONIC != 1 && wpn.BlockType_DMG_SONIC == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_SONIC == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_SONIC == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_ENERGYBEAM ) then
			if wpn.BlockType_DMG_ENERGYBEAM == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_ENERGYBEAM != 1 && wpn.BlockType_DMG_ENERGYBEAM == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_ENERGYBEAM == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_ENERGYBEAM == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_PREVENT_PHYSICS_FORCE ) then
			if wpn.BlockType_DMG_PREVENT_PHYSICS_FORCE == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_PREVENT_PHYSICS_FORCE != 1 && wpn.BlockType_DMG_PREVENT_PHYSICS_FORCE == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_PREVENT_PHYSICS_FORCE == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_PREVENT_PHYSICS_FORCE == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_NEVERGIB ) then
			if wpn.BlockType_DMG_NEVERGIB == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_NEVERGIB != 1 && wpn.BlockType_DMG_NEVERGIB == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_NEVERGIB == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_NEVERGIB == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_ALWAYSGIB ) then
			if wpn.BlockType_DMG_ALWAYSGIB == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_ALWAYSGIB != 1 && wpn.BlockType_DMG_ALWAYSGIB == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_ALWAYSGIB == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_ALWAYSGIB == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_DROWN ) then
			if wpn.BlockType_DMG_DROWN == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_DROWN != 1 && wpn.BlockType_DMG_DROWN == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_DROWN == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_DROWN == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_PARALYZE ) then
			if wpn.BlockType_DMG_PARALYZE == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_PARALYZE != 1 && wpn.BlockType_DMG_PARALYZE == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_PARALYZE == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_PARALYZE == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_NERVEGAS ) then
			if wpn.BlockType_DMG_NERVEGAS == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_NERVEGAS != 1 && wpn.BlockType_DMG_NERVEGAS == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_NERVEGAS == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_NERVEGAS == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_POISON ) then
			if wpn.BlockType_DMG_POISON == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_POISON != 1 && wpn.BlockType_DMG_POISON == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_POISON == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_POISON == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_RADIATION ) then
			if wpn.BlockType_DMG_RADIATION == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_RADIATION != 1 && wpn.BlockType_DMG_RADIATION == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_RADIATION == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_RADIATION == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_DROWNRECOVER ) then
			if wpn.BlockType_DMG_DROWNRECOVER == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_DROWNRECOVER != 1 && wpn.BlockType_DMG_DROWNRECOVER == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_DROWNRECOVER == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_DROWNRECOVER == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_ACID ) then
			if wpn.BlockType_DMG_ACID == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_ACID != 1 && wpn.BlockType_DMG_ACID == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_ACID == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_ACID == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_SLOWBURN ) then
			if wpn.BlockType_DMG_SLOWBURN == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_SLOWBURN != 1 && wpn.BlockType_DMG_SLOWBURN == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_SLOWBURN == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_SLOWBURN == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_REMOVENORAGDOLL ) then
			if wpn.BlockType_DMG_REMOVENORAGDOLL == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_REMOVENORAGDOLL != 1 && wpn.BlockType_DMG_REMOVENORAGDOLL == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_REMOVENORAGDOLL == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_REMOVENORAGDOLL == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_PHYSGUN ) then
			if wpn.BlockType_DMG_PHYSGUN == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_PHYSGUN != 1 && wpn.BlockType_DMG_PHYSGUN == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_PHYSGUN == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_PHYSGUN == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_PLASMA ) then
			if wpn.BlockType_DMG_PLASMA == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_PLASMA != 1 && wpn.BlockType_DMG_PLASMA == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_PLASMA == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_PLASMA == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_AIRBOAT ) then
			if wpn.BlockType_DMG_AIRBOAT == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_AIRBOAT != 1 && wpn.BlockType_DMG_AIRBOAT == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_AIRBOAT == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_AIRBOAT == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_DISSOLVE ) then
			if wpn.BlockType_DMG_DISSOLVE == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_DISSOLVE != 1 && wpn.BlockType_DMG_DISSOLVE == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_DISSOLVE == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_DISSOLVE == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_BLAST_SURFACE ) then
			if wpn.BlockType_DMG_BLAST_SURFACE == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_BLAST_SURFACE != 1 && wpn.BlockType_DMG_BLAST_SURFACE == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_BLAST_SURFACE == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_BLAST_SURFACE == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_BLAST_DIRECT ) then
			if wpn.BlockType_DMG_BLAST_DIRECT == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_BLAST_DIRECT != 1 && wpn.BlockType_DMG_BLAST_DIRECT == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_BLAST_DIRECT == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_BLAST_DIRECT == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_BUCKSHOT ) then
			if wpn.BlockType_DMG_BUCKSHOT == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_BUCKSHOT != 1 && wpn.BlockType_DMG_BUCKSHOT == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_BUCKSHOT == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_BUCKSHOT == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_SNIPER ) then
			if wpn.BlockType_DMG_SNIPER == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_SNIPER != 1 && wpn.BlockType_DMG_SNIPER == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_SNIPER == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_SNIPER == 4 then
				wpn:BreakBlock()
			end
		elseif ( dmginfo:GetDamageType() == DMG_MISSILEDEFENSE ) then
			if wpn.BlockType_DMG_MISSILEDEFENSE == 1 then
				dmginfo:ScaleDamage(1)
			elseif wpn.BlockType_DMG_MISSILEDEFENSE != 1 && wpn.BlockType_DMG_MISSILEDEFENSE == 3 then
				dmginfo:ScaleDamage(0)
			elseif wpn.BlockType_DMG_MISSILEDEFENSE == 2 then
				dmginfo:ScaleDamage(wpn.Secondary.DamageBlockMult)
			elseif wpn.BlockType_DMG_MISSILEDEFENSE == 4 then
				wpn:BreakBlock()
			end
		end
	end
end
hook.Add("EntityTakeDamage", "BlockingTakeDamage",  IsBlocking )

function SWEP:BlockResurrect()
	self.IsBlocking = 0
	self.Secondary.CanBlock = true
end

function SWEP:Inspect()
	self.Inspecting = 1
	self.Weapon:SendWeaponAnim( ACT_VM_FIDGET )
	
timer.Simple( self.InspectDelay, function() self:EnableInspection() end)
end

function SWEP:EnableInspection()
	self.Inspecting = 0
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

function SWEP:TauntReady()
	self.IsTaunting = 0
end

function SWEP:RegeneratingHealth(ply)
	local ply = self:GetOwner()
	local hp, maxhp

	self.PassiveHealing = "HealthRegen_".. ply:Name()
	
	if self.HealthRegen == true then
	timer.Create(self.PassiveHealing , self.HealInterval, 0, function() 
		if !SERVER or !self:IsValid()  or !timer.Exists( self.PassiveHealing ) then return end
		
		hp = ply:Health()
		maxhp = (ply:GetMaxHealth())
		if maxhp < hp then return end
		ply:SetHealth(math.Clamp( hp + self.HealAmount, 0, maxhp ))
	end)
	else
	end
end

function SWEP:DisperseHeat()
	local ply = self:GetOwner()
	local CurHeat
	local AmmoName = self.Primary.Ammo

	self.HeatDisperseTimer = "HeatDisperseTimer_".. ply:Name()
	
	if self.DisperseHeatPassively == true then
	timer.Create(self.HeatDisperseTimer , self.HeatLossInterval, 0, function() 
		if !SERVER or !self:IsValid()  or !timer.Exists( self.HeatDisperseTimer ) then return end
		
		CurHeat = self:GetNWInt("Heat")
		if ply:GetAmmoCount( AmmoName ) >= 101 then
			self:SetNWInt("Heat", 100)
			ply:SetAmmo(self:GetNWInt("Heat"), AmmoName)
	--	ply:ChatPrint(self:GetNWInt("Heat"))
	--	ply:ChatPrint(self.Weapon:GetNWFloat("HeatDispersePower"))
		elseif ply:GetAmmoCount( AmmoName ) >= 0 then
			if self.Weapon:GetNWFloat("HeatDispersePower") == 0 then
			else
				self:SetNWInt("Heat", math.Clamp( (self:GetNWInt("Heat") - (self.HeatLossPerInterval * self.Weapon:GetNWFloat("HeatDispersePower"))), 0, 100), self.Primary.Ammo )
				ply:SetAmmo(self:GetNWInt("Heat"), AmmoName )
			end
	--	ply:ChatPrint(self:GetNWInt("Heat"))
	--	ply:ChatPrint(self.Weapon:GetNWFloat("HeatDispersePower"))
		end
		
		if ply:GetAmmoCount( AmmoName ) >= 100 then
			if self.CanOverheat == true then
				self:Overheat()
			else end
		else end
		
		if ply:GetAmmoCount( AmmoName ) >= (100 - (100 * self.OverHeatFinishPercent)) then
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

function SWEP:AdjustMouseSensitivity()
	if self.Weapon:GetNWBool("ironsights") == true then
		return self:GetOwner():GetFOV() / 100
	elseif self.Weapon:GetNWBool("ironsights") == false then
		return 1
	end
end

function SWEP:IronCoolDown()
	self.IronCD = true
	timer.Simple( 0.5, function() self.IronCD = false end)
end

function SWEP:SetIronsights(b)
if self.IronCD == false then
	self.Weapon:SetNWBool("Ironsights", b)
		if self.Weapon:GetNWBool( "Ironsights") then
			self.IronSightsPos = self.IronSightsPos
			self.IronSightsAng = self.IronSightsAng
		else end
else end
end

-- SCK
if CLIENT then
	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)
		if (!self.vRenderOrder) then
			
			// we build a render order because sprites need to be drawn after models
			self.vRenderOrder = {}
			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end
		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then
				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()
			end
			
		end
		
	end
	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then
			self.wRenderOrder = {}
			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end
		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			// when the weapon is dropped
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then
				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()
			end
			
		end
		
	end
	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			// Technically, if there exists an element with the same name as a bone
			// you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)
			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r // Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end
	function SWEP:CreateModels( tab )
		if (!tab) then return end
		// Create the clientside models here because Garry says we can't do it in the render hook
		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				// make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			// !! WORKAROUND !! //
			// We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			// !! ----------- !! //
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				// !! ----------- !! //
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end

	/**************************
		Global utility code
	**************************/

	// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
	// Does not copy entities of course, only copies their reference.
	// WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
	function table.FullCopy( tab )
		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end

function SWEP:Precache()	
end