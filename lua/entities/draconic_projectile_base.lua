AddCSLuaFile()

--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

ENT.Type 			= "anim"
ENT.PrintName		= "Draconic Projectile Base"
ENT.Author			= "Vuthakral"
ENT.Information		= ""
ENT.Category		= "Draconic Projectiles"

ENT.Spawnable		= false
ENT.AdminSpawnable	= false

ENT.Model 		= "models/Items/AR2_Grenade.mdl"
ENT.HideModel	= false
ENT.HideShadow	= false

ENT.Buoyancy				= 0.15
ENT.Drag					= 0
ENT.Mass					= nil

ENT.InheritDamageFromCreatorPrimary = false
ENT.InheritDamageFromCreatorSecondary = false
ENT.Damage 					= 25
ENT.DamageType				= DMG_GENERIC
ENT.Force					= 5
ENT.Gravity					= true
ENT.GravityArtificial		= Vector()
ENT.DoesRadialDamage 		= false
ENT.RadialDamagesOwner		= true
ENT.ProjectileType 			= "point"
ENT.Explosive				= false
ENT.ExplosionType			= "hl2"
ENT.ExplosiveIgnoresCover	= false
ENT.RemoveInWater			= false
ENT.AffectedByWater			= true
ENT.DoNotAffectSimilar		= true

ENT.StickSound = nil

ENT.MaxBounces 				= 0
ENT.BounceChance 			= 100
ENT.BounceMaxAngle 			= 30
ENT.BouncePreservesSpeed 	= true
ENT.BounceCharacters 		= false
ENT.BounceVehicles 			= false
ENT.BounceDestructibles 	= false
ENT.BounceSound 			= nil
ENT.BounceSurfaces = {
	["cardboard"] = false,
	["computer"] = true,
	["bugshell"] = true,
	["dirt"] = false,
	["flesh"] = false,
	["glass"] = true,
	["metal"] = true,
	["metalhollow"] = true,
	["metaldrum"] = true,
	["metalvent"] = true,
	["mud"] = false,
	["plastic"] = true,
	["rubber"] = false,
	["rubble"] = true,
	["stone"] = true,
	["sand"] = false,
	["snow"] = false,
	["tile"] = true,
	["wood"] = true,
}

ENT.Tracking		= false
ENT.TrackType		= "Tracking"
ENT.TrackFraction 	= 0.5
ENT.TrackingSpeed	= nil

ENT.SuperCombineRequirement		= 0
ENT.SuperDamage					= 100
ENT.SuperDamageType 			= DMG_GENERIC
ENT.SuperCombineType 			= "hl2"
ENT.SuperExplodePressure		= 100
ENT.SuperExplodeShakePower 		= 5
ENT.SuperExplodeShakeTime  		= 0.5	
ENT.SuperExplodeShakeDistance 	= 500

ENT.FuseTime	= 5
ENT.LifeTime 	= 60

ENT.ExplodeShakePower 		= 5
ENT.ExplodeShakeTime  		= 0.5	
ENT.ExplodeShakeDistance 	= 500

ENT.ManualDetonation	= false
ENT.DetonateSoundNear	= nil
ENT.DetonateSoundFar	= nil
ENT.DetonationDelay		= 1

ENT.LoopingSound		= nil
ENT.ExplodeSoundNear	= nil
ENT.ExplodeSoundFar		= nil

ENT.ExplodePressure		= 5

ENT.AffectRadius		= 0.0001
ENT.SuperAffectRadius	= 0.0001

ENT.EffectTickRate		= 66
ENT.Effect				= nil
ENT.SpawnEffect			= nil
ENT.LuaExplEffect		= nil
ENT.SuperLuaExplEffect	= nil
ENT.RemoveEffect		= nil

ENT.PCFEffect				= nil
ENT.PCFSpawnEffect 			= nil
ENT.PCFLuaExplEffect 		= nil
ENT.PCFSuperLuaExplEffect 	= nil
ENT.PCFRemoveEffect			= nil

ENT.ImpactEffect	= nil
ENT.ImpactSound		= nil

ENT.DynamicParticles = true
ENT.DynamicSounds = true

ENT.TrailMat		= nil
ENT.TrailColor		= Color(255, 255, 255)
ENT.TrailAdditive	= false
ENT.TrailStartWidth	= 20
ENT.TrailEndWidth	= 0
ENT.TrailLifeTime	= 1

ENT.TrailMat2			= nil
ENT.TrailColor2			= Color(255, 255, 255)
ENT.TrailAdditive2		= false
ENT.TrailStartWidth2	= 20
ENT.TrailEndWidth2		= 0
ENT.TrailLifeTime2		= 1

ENT.Light			= false
ENT.LightColor		= Color(255, 255, 255)
ENT.LightBrightness	= 1
ENT.LightRange		= 100
ENT.LightType		= 0 -- https://developer.valvesoftware.com/wiki/Light_dynamic#Appearances

ENT.SpriteMat		= nil
ENT.SpriteWidthMin	= 10
ENT.SpriteWidthMax	= 10
ENT.SpriteHeightMin = 10
ENT.SpriteHeightMax = 10
ENT.SpriteColor		= Color(0, 255, 0)

ENT.SpriteMat2		 = nil
ENT.SpriteWidth2Min	 = 10
ENT.SpriteWidth2Max	 = 10
ENT.SpriteHeight2Min = 10
ENT.SpriteHeight2Max = 10
ENT.SpriteColor2	 = Color(255, 255, 255)

ENT.EMP			= false
ENT.EMPTime		= 5
ENT.EMPSound	= nil
ENT.EMPEffect	= nil

ENT.PreventFireDecals = false

ENT.TimerFrequency	= 1

ENT.GravitySpherePower	= 0

ENT.OverrideBProfile = nil

-- DO NOT TOUCH ZONE
ENT.ENear	= nil
ENT.EFar	= nil
ENT.Triggered = false
ENT.TriggeredSound = false
ENT.Draconic = true
ENT.DraconicProjectile = true
ENT.BProfile = false
ENT.TrackTarget = nil
ENT.ManualDetect = {
		"npc_combinegunship",
		"npc_strider",
		"npc_hunter",
		"npc_combinedropship"
}
ENT.BounceCount = 0
ENT.BounceDoolDown = 0

function ENT:GetCreator()
	return self.Creator
end

function ENT:SetCreator(ent)
	if IsValid(ent) then
		self.Creator = ent
	else
		self.Creator = Entity(0)
	end
end

function ENT:GetCreatorAttachmentValue(att, val)
	if !IsValid(self) or !IsValid(self:GetCreator()) then return end
	return self:GetCreator():GetAttachmentValue(att, val)
end

ENT.EffectTick = 0
ENT.ThinkTimer = 0
ENT.UpdateLastInfo = 0
function ENT:Think()
	if !IsValid(self) then return end
	local ct = CurTime()
	
	if CLIENT && (self.Effect != nil or self.PCFEffect != nil) && RealTime() > self.EffectTick then
		if self.Effect != nil then
			local ed = EffectData()
			ed:SetOrigin(self:GetPos())
			ed:SetEntity(self)
			util.Effect(self.Effect, ed)
		end
		if self.PCFEffect != nil then ParticleEffect(self.PCFEffect, self:GetPos(), self:GetAngles(), self) end
		self.EffectTick = (RealTime() + 1/self.EffectTickRate)
	end
	
	local phys = self:GetPhysicsObject()
	if !IsValid(phys) then return end
	local vel = self:GetVelocity()
	local pos = self:GetPos()
	local tipe = self.ProjectileType
	local owner = self:GetOwner()
	if self.SpawnTime == nil then return end
	local st = self.SpawnTime
	local lt = st + 5
	if !IsValid(self) then return end
	if self.RemoveInWater == true && SERVER then
		if self:WaterLevel() == 3 then self:Remove() end
	end
	if self:WaterLevel() == 3 && self.AffectedByWater == true then
		phys:EnableGravity(true)
		if IsValid(self) && self.LoopingSound != nil then self:StopSound(self.LoopingSound) end
	end
	
	if IsValid(self:GetCreator()) && self:GetCreator():IsWeapon() then
	--	if self:GetOwner():GetActiveWeapon() != self:GetCreator() then return end
		if self.Tracking == true then
			if self.TrackType == "Guided" then
				self.TrackTarget = self:GetOwner():GetEyeTrace().HitPos
			end
		end
	end
	
	if self.UpdateLastInfo < ct then
		self.UpdateLastInfo = ct + engine.TickInterval()
		self.LastPos = pos
		self.LastAng = phys:GetAngles()
	end
	
--	if !timer.Exists(self.TimerName) && tipe != "sticky" && tipe != "playersticky" && tipe != "supercombine" && tipe != "magazine" then
--		timer.Create(self.TimerName, self.TimerFrequency, 0, function()
	if ct > self.ThinkTimer then
		self.ThinkTimer = ct + self.TimerFrequency
		if !SERVER then return end
		for k, v in pairs(ents.FindInSphere(self.LastPos, self.AffectRadius)) do
			if IsValid(v) && v:EntIndex() != self:EntIndex() && !v:IsWorld() then
				local dmg69 = DamageInfo()
				dmg69:SetDamage((self.Damage*0.2) / (v:GetPos()):Distance(self.LastPos) * 20)
				if IsValid(owner) then
					dmg69:SetAttacker(owner)
				else
					dmg69:SetAttacker(self)
				end
				dmg69:SetInflictor(self)
				dmg69:SetDamageForce(self:EyeAngles():Forward())
				dmg69:SetDamagePosition(self.LastPos)
				dmg69:SetDamageType(self.DamageType)
				
				local hp = DRC:Health(v)
				
				if IsValid(v:GetPhysicsObject()) && !DRC:IsCharacter(v) then
					if self.GravitySpherePower != 0 then v:GetPhysicsObject():AddVelocity((v:GetPos()-self.LastPos)*self.GravitySpherePower/(v:GetPos()):Distance(self.LastPos) + v:GetVelocity()) end
					if v:Health() != 0 && v:Health() != nil && self.DoesRadialDamage == true then v:TakeDamageInfo(dmg69) end
				elseif DRC:IsCharacter(v) then
					if v == self:GetOwner() && self.RadialDamagesOwner == true then 
						if self.DoesRadialDamage == true then v:TakeDamageInfo(dmg69) end
					elseif v != self:GetOwner() then
						if self.DoesRadialDamage == true then v:TakeDamageInfo(dmg69) end
					end
					if self.GravitySpherePower != 0 then v:SetVelocity((v:GetPos()-self.LastPos)*self.GravitySpherePower/(v:GetPos()):Distance(self.LastPos) + v:GetVelocity()) end
				else
					if self.GravitySpherePower != 0 then v:AddVelocity((v:GetPos()-self.LastPos)*self.GravitySpherePower/(v:GetPos()):Distance(self.LastPos) + v:GetVelocity()) end
				end
			end
		end
	end

	self:DoCustomThink()

	
	if !IsValid(self) or !IsValid(self:GetPhysicsObject()) then return end
	self.FrontTrace = util.TraceLine({
		start = self:GetPos(), 
		endpos = self:GetPos() + vel:GetNormal() * 100, 
		filter = function(ent) if ent == self or ent == self:GetOwner() or ent == self:GetCreator() then return false else return true end end,
		mask = MASK_SHOT_HULL
	})
	local tr = self.FrontTrace
	self.LastHitNormal = tr.HitNormal
	if tr then DRC:RenderTrace(tr, Color(255, 255, 255, 255), FrameTime(), true) end
	
	if tr.Entity == nil then return end
	if self.Triggered == true then return end
	if IsValid(tr.Entity) && IsValid(self) && IsValid(self:GetCreator()) && self.Triggered == false && DRC:IsCharacter(tr.Entity) then
		if table.HasValue(self.ManualDetect, tr.Entity:GetClass()) or tr.Entity:IsNextBot() then
			self:Touch(tr.Entity)
		end
	end
	
end

function ENT:DoCustomThink()
end

function ENT:GetObjVelocity()
	if !IsValid(self) or !IsValid(self:GetPhysicsObject()) then return end
	if self.Gravity == true then
		return self:GetPhysicsObject():GetVelocity()
	else
		return self.SpawnVelocity
	end
end

function ENT:PhysicsUpdate()
	if !IsValid(self) then return end
	local phys = self:GetPhysicsObject()
	local vel = phys:GetVelocity()
	local pos = phys:GetPos()
	local typ = self.ProjectileType
	local owner = self:GetOwner()
	local st = self.SpawnTime
	local lt = st + 5
	self.LastPos = pos
	if self.LastRotVelSet == nil then self.LastRotVelSet = st end
		
	if self:WaterLevel() != 0 then return end
	
	if typ == "magazine" then return end
	if CurTime() > st + 0.5 && (vel.x > 50 or vel.y > 50 or vel.z > 50) then 
		if CurTime() > self.LastRotVelSet then
			phys:SetAngles(vel:Angle())
			self.LastRotVelSet = CurTime() + engine.TickInterval()
		end
		
		phys:SetVelocity(vel)
	end
	
	if self.GravityArtificial != Vector() then
		phys:SetVelocity(vel + (self.GravityArtificial * DRC:GetGravityScale()))
	end
	
	if self.Tracking == true then
		if !IsValid(self:GetOwner()) then return end
		if !IsValid(self:GetCreator()) then return end
		local tgt = self.TrackTarget
		if IsValid(tgt) && IsValid(Entity(tgt:EntIndex())) then
			local endp = tgt:GetPos() + tgt:OBBCenter()
			if DRC:IsVehicle(tgt) then
				if tgt:LookupAttachment("tracking_goal") != 0 then
					endp = tgt:GetAttachment(tgt:LookupAttachment("tracking_goal")).Pos
				else
					endp = tgt:GetPos() + Vector(0, 0, 2)
				end
			end
			local tr = util.TraceLine({
				start = phys:GetPos(),
				endpos = endp,
				filter = function(ent) if ent != tgt then return false end end
			})
			
			local ang = tr.Normal:Angle()
			
			local angx = math.ApproachAngle(self:GetAngles().x, ang.x, self.TrackFraction)
			local angy = math.ApproachAngle(self:GetAngles().y, ang.y, self.TrackFraction)
			local angz = math.ApproachAngle(self:GetAngles().z, ang.z, self.TrackFraction)
			
			ang = Angle(angx, angy, angz)
			
			phys:SetAngles(ang)
			if self.TrackingSpeed != nil then 
				phys:SetVelocity(phys:GetAngles():Forward() * self.TrackingSpeed)
			else
				phys:SetVelocity(phys:GetAngles():Forward() * self.InitialSpeed)
			end
		elseif isvector(tgt) then
			local tr = util.TraceLine({
				start = phys:GetPos(),
				endpos = tgt,
			})
			
			local ang = tr.Normal:Angle()
			
			local angx = math.ApproachAngle(self:GetAngles().x, ang.x, self.TrackFraction)
			local angy = math.ApproachAngle(self:GetAngles().y, ang.y, self.TrackFraction)
			local angz = math.ApproachAngle(self:GetAngles().z, ang.z, self.TrackFraction)
			
			ang = Angle(angx, angy, angz)
			
			phys:SetAngles(ang)
			phys:SetVelocity(phys:GetAngles():Forward() * self.InitialSpeed)
		end
	end
end

function ENT:Initialize()
	local typ = self.ProjectileType
	local ply = self:GetOwner()
	
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self:SetCustomCollisionCheck(true)
	self:SetEntity(0)
	
	if typ == "lua_explosive" or typ == "explosive" or typ == "custom_explosive" or typ == "grenade" or typ == "FuseAfterFirstBounce" then self.Explosive = true end
	
	if IsValid(ply) then
		if DRC:IsVehicle(ply) then
			self:SetCreator(ply)
		elseif DRC:IsCharacter(ply) then
			if ply:IsPlayer() then
				if ply:InVehicle() then
					self:SetCreator(ply:GetVehicle())
				else
					self:SetCreator(ply:GetActiveWeapon())
				end
			elseif ply:IsNextBot() then
				self:SetCreator(ply.Weapon)
			else
				self:SetCreator(ply:GetActiveWeapon())
			end
		end
	end
	
	local creator = self:GetCreator()
	
	if self.InheritDamageFromCreatorPrimary == true then self.Damage = creator.Primary.Damage end
	if self.InheritDamageFromCreatorSecondary == true then self.Damage = creator.Secondary.Damage end
	
	self:DoCustomInitialize()
	
	if IsValid(creator) && creator:IsWeapon() then
		self.BProfile = true
		
		if self.Tracking == true && creator.Draconic then
			if self.TrackType == "Tracking" then
				self.TrackTarget = creator:GetTraceTarget()
				if IsValid(creator:GetConeTarget()) then self.TrackTarget = creator:GetConeTarget() end
			end
		end
	end

	self.SpawnTime = CurTime()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	timer.Simple(0.0000000001, function() if self:IsValid() then self.SpawnVelocity = self:GetVelocity() end end)

	local phys = self:GetPhysicsObject()
	self.LastAng = phys:GetAngles()
	phys:SetBuoyancyRatio(self.Buoyancy)
	if self.Mass == 0 then self.Mass = 1 phys:SetMass(self.Mass) end
	if self.Mass != nil then phys:SetMass(self.Mass) end
	if self.Drag != nil then phys:SetDragCoefficient(self.Drag) phys:IsDragEnabled(true) end
	
	self.Vel = self:GetVelocity()
	self.Triggered = false
	self.FirstBounce = false
	self.SpawnTime = CurTime()
	
	if SERVER && self.TrailMat != nil then
		util.SpriteTrail( self, 0, self.TrailColor, self.TrailAdditive, self.TrailStartWidth, self.TrailEndWidth, self.TrailLifeTime, 1 / ( self.TrailStartWidth + self.TrailEndWidth ) * 0.5, self.TrailMat )
	end
	
	if SERVER && self.TrailMat2 != nil then
		util.SpriteTrail( self, 0, self.TrailColor2, self.TrailAdditive2, self.TrailStartWidth2, self.TrailEndWidth2, self.TrailLifeTime2, 1 / ( self.TrailStartWidth2 + self.TrailEndWidth2 ) * 0.5, self.TrailMat2 )
	end
	
	if self.HideModel == true then
		self:SetMaterial("models/vuthakral/nodraw")
		self:DrawShadow(false)
	end
	
	if self.HideShadow == true then
		self:DrawShadow(false)
	end
	
	if SERVER && typ == "magazine" then
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
		self.Explosive = false
	
		timer.Simple(15, function() if IsValid(self) then self:Remove() end end)
	else end
	
	if SERVER && typ == "fire" then
		timer.Simple(self.FuseTime, function() if self:IsValid() then self:Remove() end end)
	end
	
	if self.ExplodeSoundNear == nil then
		self.ENear	= "draconic.ExplosionSmallGeneric"
	else
		self.ENear	= self.ExplodeSoundNear 
	end
	if self.ExplodeSoundFar == nil then
	--	self.EFar	= "draconic.ExplosionDistGeneric"
	else
		self.EFar	= self.ExplodeSoundFar
	end
	
	if self.Gravity == false then
		phys:EnableGravity(false)
	else end

	if typ == "grenade" or typ == "sticky" or typ == "playersticky" or typ == "supercombine" then
		timer.Simple(self.FuseTime, function() if self:IsValid() then self:TriggerExplosion() end end)
	else end
	
	if self.SpawnEffect != nil or self.PCFSpawnEffect != nil then
		if self.SpawnEffect != nil then
			local ed2 = EffectData()
			ed2:SetOrigin(self:GetPos())
			ed2:SetEntity(self)
			util.Effect(self.SpawnEffect, ed2)
		end
		if self.PCFSpawnEffect != nil then ParticleEffect(self.PCFSpawnEffect, self:GetPos(), self:GetAngles(), self) end
	end
	
	if self.LoopingSound != nil then
		if self:IsValid() then
			self:EmitSound(Sound(self.LoopingSound))
		end
	end
	
	self:SetNWBool("Stuck", false)
	
	self.Initialized = true
	
	if SERVER then
		timer.Simple(self.LifeTime, function()
			if self:IsValid() then
				if self.Explosive == true then
					self:TriggerExplosion()
				else
					self:Remove()
				end
			end
		end)
	end
end

function ENT:DoCustomInitialize()
end

function ENT:Draw()
if CLIENT then
	if self.Initialized != true then return end
	self:DrawModel()

	if self.Light == true then
		local dlight = DynamicLight(self:EntIndex())
			if (dlight) then
				dlight.Pos 			= self:GetPos()
				dlight.Size 		= self.LightRange
				dlight.Brightness 	= self.LightBrightness
				dlight.Style		= self.LightType
				dlight.r 			= self.LightColor.r
				dlight.g 			= self.LightColor.g
				dlight.b 			= self.LightColor.b
				dlight.Decay 		= 1000
				dlight.DieTime 		= CurTime() + 0.1
			end
	end
	
	if self.SpriteMat != nil then
		cam.Start3D()
			render.SetMaterial( Material(self.SpriteMat) )
			render.DrawSprite( self:GetPos(), math.Rand(self.SpriteWidthMin, self.SpriteWidthMax), math.Rand(self.SpriteHeightMin, self.SpriteHeightMax), self.SpriteColor )
		cam.End3D()
	end
	
	if self.SpriteMat2 != nil then
		cam.Start3D()
			render.SetMaterial( Material(self.SpriteMat2) )
			render.DrawSprite( self:GetPos(), math.Rand(self.SpriteWidth2Min, self.SpriteWidth2Max), math.Rand(self.SpriteHeight2Min, self.SpriteHeight2Max), self.SpriteColor2 )
		cam.End3D()
	end
end
	
	self:DoCustomDraw()
end

function ENT:DoCustomDraw()
end

function ENT:Touch(ent)
	local ty = self.ProjectileType

	if ty == "point" or ty == "lua_explosive" or ty == "explosive" then
		local CollData = {
			["HitPos"] = self:GetPos(),
			["HitEntity"] = ent,
			["OurOldVelocity"] = self:GetVelocity(),
			["HitObject"] = ent:GetPhysicsObject(),
			["DeltaTime"] = nil,
			["TheirOldVelocity"] = ent:GetVelocity()
		}
	
		if DRC:IsCharacter(CollData.HitEntity) && CollData.HitEntity != self:GetOwner() then
			self:PhysicsCollide(CollData, self:GetPhysicsObject())
		end
	end
end

function ENT:DoCustomStick(data, ent)
end

function ENT:Stick(data, tgt)
	self:SetSolid(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	if !tgt:IsWorld() then self:SetParent(tgt) end
	self:DoImpactEffect()
	self:SetVelocity(Vector())
	self:SetPos(data.HitPos)
	if self.StickSound != nil then self:EmitSound(self.StickSound) end
	self:SetNWBool("Stuck", true)
	
	self:DoCustomStick(data, tgt)
end

function ENT:CheckBounceValidity(data)
	if self.BounceMaxAngle == 0 then return true end
	local ang1 = DRC:GetVelocityAngle(data.OurOldVelocity)
	local ang2 = DRC:GetVelocityAngle(data.OurNewVelocity)

	local dx, dy = math.AngleDifference(ang1.x, ang2.x), math.AngleDifference(ang1.y, ang2.y)
	dx, dy = math.abs(dx), math.abs(dy)
	
	local xg, yg = dx > self.BounceMaxAngle, dy > self.BounceMaxAngle
	
	if xg == true or yg == true then return false else return true end
	return true
end

function ENT:CheckBounceIgnorance(ent)
	if self.BounceCharacters == false && DRC:IsCharacter(ent) then return true end
	if self.BounceVehicles == false && DRC:IsVehicle(ent) then return true end
	if self.BounceDestructibles == false && ent.GetMaxHealth && ent:Health() > 0 then return true end
	return false
end

function ENT:CheckBounceMaterial(sprop)
	local matstring = DRC:SurfacePropToEnum(util.GetSurfacePropName(sprop))
	if DRC.SurfacePropsEngine[matstring] then return false end
	local str = DRC.SurfacePropDefinitions[matstring][1]
	local retr = self.BounceSurfaces[str]
	if retr == nil then retr = true end
	return retr
end

ENT.burncooldown = 0
ENT.bouncecooldown = 0
function ENT:PhysicsCollide( data, phys )
	if !IsValid(self) or !IsValid(self:GetPhysicsObject()) then return end
	local typ = self.ProjectileType
	local tgt = data.HitEntity
	local cl = self:GetClass()
	local SCC = "sc_".. self:GetClass() ..""
	local sprop = data.TheirSurfaceProps
	local ct = CurTime()
	
	if ct > self.bouncecooldown && self.MaxBounces > 0 && self.BounceCount < self.MaxBounces && (math.Rand(0, 100) <= self.BounceChance) && self:CheckBounceValidity(data) && self:CheckBounceIgnorance(tgt) == false && self:CheckBounceMaterial(sprop) then
		timer.Simple(0, function() if IsValid(self) then
			self.BounceCount = self.BounceCount + 1
		end end)
		self.BounceDoolDown = ct + 0.05
		if self.BouncePreservesSpeed == true then timer.Simple(0.1, function() if IsValid(self) then
			phys:SetAngleVelocity(Vector())
			phys:SetVelocity(DRC:GetVelocityAngle(self):Forward() * self.InitialSpeed)
		end end) end
		if self.BounceSound != nil then self:EmitSound(self.BounceSound) end
	return end
	
	if ct < self.BounceDoolDown then return end
	
	if self.Triggered == true then return end
	self.Triggered = true
	
	if ((self:GetCreator():IsWeapon() && self:GetCreator().Draconic == true) or self.OverrideBProfile != nil) && typ == "point" then
		if self.OverrideBProfile != nil then
			local tbl = scripted_ents.GetStored(self.OverrideBProfile).t.BulletTable
			local impact, burn = tbl.ImpactDecal, tbl.BurnDecal
			if impact != nil then util.Decal( impact, self:GetPos(), self:GetPos() + self:GetAngles():Forward() * 100, self) end
			if burn != nil then util.Decal( burn, self:GetPos(), self:GetPos() + self:GetAngles():Forward() * 100, self) end
		else
			if self:GetCreator():GetAttachmentValue("Ammunition", "ImpactDecal") != nil && !tgt:IsNPC() then
				util.Decal( self:GetCreator():GetAttachmentValue("Ammunition", "ImpactDecal"), self:GetPos(), self:GetPos() + self:GetAngles():Forward() * 100, self)
			end
				
			if self:GetCreator():GetAttachmentValue("Ammunition", "BurnDecal") != nil && !tgt:IsNPC() then
				util.Decal( self:GetCreator():GetAttachmentValue("Ammunition", "BurnDecal"), self:GetPos(), self:GetPos() + self:GetAngles():Forward() * 100, self)
			end
		end
	end
	
	timer.Simple(0, function()
		if !IsValid(self) then return end
		if tgt:IsWorld() == false then
			if !IsValid(tgt) then SafeRemoveEntity(self) return end
			local NI = tgt:GetNWInt(SCC)
			if typ == "point" then
				local tr = util.TraceLine({start=self:GetPos(), endpos=tgt:LocalToWorld(tgt:OBBCenter()), filter={self, self:GetOwner()}, mask=MASK_SHOT_HULL})
				self:SetPos(data.HitPos)
				self:DamageTarget(tgt, tr)
				self:DoImpactEffect()
				
				SafeRemoveEntity(self)
				if self.EMP == true then self:DoEMP(tgt) end
			elseif typ == "explosive" then
				self:TriggerExplosion()
				self:DoImpactEffect()
				if self.EMP == true then self:DoEMP(tgt) end
			elseif typ == "lua_explosive" then
				self.ExplosionType = "lua"
				self:TriggerExplosion()
				self:DoImpactEffect()
				if self.EMP == true then self:DoEMP(tgt) end
			elseif typ == "playersticky" then 
				if tgt:IsNPC() or tgt:IsNextBot() or (tgt:IsPlayer() and tgt ~= self:GetOwner()) or (tgt == self:GetOwner() and tgt:IsVehicle()) then
					self:Stick(data, tgt)
					self:DoImpactEffect()
					if self.Explosive == false then self:DamageTarget(tgt, tr) end
					if self.EMP == true then self:DoEMP(tgt) end
				end
			elseif typ == "sticky" then
				if tgt != self:GetOwner() then
					self:Stick(data, tgt)
					if self.Explosive == false then self:DamageTarget(tgt, tr) end
					timer.Simple(15, function() if self.Explosive == false && self:IsValid() then self:Remove() end end)
					if self.EMP == true then self:DoEMP(tgt) end
				end
			elseif typ == "FuseAfterFirstBounce" then
				if self.FirstBounce == false then self.FirstBounce = true end
				if self.FirstBounce == true then timer.Simple(self.FuseTime, function() if self:IsValid() then self:TriggerExplosion() end end) end
			elseif typ == "supercombine" then
				self:Stick(data, tgt)
				self:DoImpactEffect()
				if self.EMP == true then self:DoEMP(tgt) end
				if self:GetParent() != nil && self:GetParent():IsNPC() or self:GetParent():IsPlayer() or self:GetParent():IsNextBot() then
					if NI >= self.SuperCombineRequirement - 1 then
						for f, v in pairs(tgt:GetChildren()) do
							if v:GetClass() == self:GetClass() then
								v:Remove()
							end
						end
						self:TriggerSC()
						tgt:SetNWInt(SCC, 0)
					else
						tgt:SetNWInt(SCC, NI + 1)
					end
					timer.Simple(self.FuseTime, function()
						if IsValid(tgt) then
							local CNI = tgt:GetNWInt(SCC)
							tgt:SetNWInt(SCC, math.Clamp(CNI - 1, 0, 99))
							NI = math.Clamp(NI, 0, 99)
						end
					end)
				end
			end
		elseif tgt:IsWorld() == true then
			if typ == "point" then
				timer.Simple(0.01, function() if IsValid(self) then self:Remove() end end)
				self:SetPos(data.HitPos)
				self:DoImpactEffect()
			elseif typ == "explosive" then
				self:TriggerExplosion()
				self:DoImpactEffect()
			elseif typ == "lua_explosive" then
				self.ExplosionType = "lua"
				self:TriggerExplosion()
				self:DoImpactEffect()
			elseif typ == "sticky" or typ == "supercombine" then
				self:Stick(data, tgt)
				self:DoImpactEffect()
			elseif typ == "FuseAfterFirstBounce" then
				if self.FirstBounce == false then self.FirstBounce = true end
				if self.FirstBounce == true then timer.Simple(self.FuseTime, function() if self:IsValid() then self:TriggerExplosion() end end) end
			elseif typ == "fire" then
				if ct > self.burncooldown then
					local startpos = self:GetPos()
					local endpos = self:GetVelocity():Angle():Forward() * 25
					if self.PreventFireDecals != true then util.Decal("Scorch", startpos, endpos, {self}) end
					self.burncooldown = ct + 0.05
				end
			end
		end
		
		if self.ProjectileType == "custom_explosive" then
			self.ExplosionType = "custom"
			self:TriggerExplosion()
		end
	end)
	
	self:DoCustomPhysicsCollide(data, phys)
end

function ENT:DoCustomPhysicsCollide(data, phys)
end

function ENT:DamageTarget(tgt)
	local owner = self:GetOwner()

	local dmg = DamageInfo()
	dmg:SetDamage(self.Damage)
	dmg:SetInflictor(self)
	if owner != nil && IsValid(owner) then
		dmg:SetAttacker(owner)
	else
		dmg:SetAttacker(self)
	end
	dmg:SetDamageForce(self:EyeAngles():Forward())
	dmg:SetDamagePosition(self:GetPos())
	dmg:SetDamageType(self.DamageType)
	
	tgt:TakeDamageInfo(dmg)
	
	if self.Explosive == true then timer.Simple(0.01, function() if self:IsValid() then self:Remove() end end) end
end

function ENT:DoImpactEffect()
	if self:IsValid() then
		if self.ImpactSound != nil && !game.IsDedicated() then DRC:EmitSound(self, Sound(self.ImpactSound)) end
		if self.ImpactEffect != nil then
			local ed69 = EffectData()
			ed69:SetOrigin(self:GetPos())
			ed69:SetEntity(self)
			util.Effect(self.ImpactEffect, ed69)
		end
		
--[[	if CLIENT && self.ExplodeLight != false then
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
		end --]]
	end
end

function ENT:DoEMP(target, hitpos)
	if !IsValid(self) then return end
	if !IsValid(target) then return end
	
	DRC:EMP(self, target, self.EMPTime, self.EMPSound, self.EMPEffect)
end

function ENT:TriggerExplosion(nodecal)
	if !IsValid(self) then return end
	if nodecal == nil then nodecal = false end
	
	self.SpriteMat = nil
	self.SpriteMat2 = nil
	self.TrailMat = nil
	self.Light = false
	if self.Explosive == false then return end
	if self.ManualDetonation == true && self.Detonated != true then return end
	
	if self.TriggeredSound == false then
		self.TriggeredSound = true
		DRC:EmitSound(self, self.ENear, self.EFar, 1750, SOUND_CONTEXT_EXPLOSION)
	end
	
	if self.ExplosionType == "hl2" then
		if self:IsValid() then self:Explode("default") end
	elseif self.ExplosionType == "lua" then
		if self:IsValid() then self:LuaExplode("default") end
	elseif self.ExplosionType == "custom" then
		if self:IsValid() then self:DoCustomExplode() end
	end
	
	local pos = self:GetPos()
	local dist = self.ExplodePressure * 10 or self.SuperExplodePressure * 10
	
	local N = DRC:TraceDir(pos, Angle(0, 0, 0), dist)
	local S = DRC:TraceDir(pos, Angle(0, 180, 0), dist)
	local E = DRC:TraceDir(pos, Angle(0, -90, 0), dist)
	local W = DRC:TraceDir(pos, Angle(0, 90, 0), dist)
	local U = DRC:TraceDir(pos, Angle(-90, 0, 0), dist)
	local D = DRC:TraceDir(pos, Angle(90, 0, 0), dist)
	local TraceTable = {N, S, E, W, U, D}
	
	local impact, burn
	if (self:GetCreator():IsWeapon() && self:GetCreator().Draconic == true) or self.OverrideBProfile != nil && typ == "point" then
		if self.OverrideBProfile != nil then
			local tbl = scripted_ents.GetStored(self.OverrideBProfile).t.BulletTable
			impact, burn = tbl.ImpactDecal, tbl.BurnDecal
		else
			impact = self:GetCreator():GetAttachmentValue("Ammunition", "ImpactDecal")
			burn = self:GetCreator():GetAttachmentValue("Ammunition", "BurnDecal")
		end
	end

	for k,v in pairs(TraceTable) do
		if v.Hit then
			if v.HitSky then return end
			if impact != nil && !v.Entity:IsNPC() then
				util.Decal( impact, self:GetPos(), v.HitPos + v.Normal:Angle():Forward() * 100, self)
			end
				
			if burn != nil && !v.Entity:IsNPC() then
				util.Decal( burn, self:GetPos(), v.HitPos + v.Normal:Angle():Forward() * 100, self)
			end
		end
	end
end

function ENT:Detonate()
	if !IsValid(self) then return end
	if self.Explosive == false then return end
	
	self.Detonated = true
	DRC:EmitSound(self, self.DetonateSoundNear, self.DetonateSoundFar, 1750, SOUND_CONTEXT_EXPLOSION)
	timer.Simple(self.DetonationDelay, function() if IsValid(self) then self:TriggerExplosion() end end)
end

function ENT:TriggerSC()
	if IsValid(self) then DRC:EmitSound(self, self.ENearSC, self.EFarSC, 1750, SOUND_CONTEXT_EXPLOSION) end
	--[[
	if self.Triggered == false then
		if CLIENT then return end
		self.Triggered = true
		local soundent = ents.Create("drc_dummy")
		soundent:SetPos(self:GetPos())
		soundent:Spawn()
		timer.Simple( FrameTime(), function()
			if game.SinglePlayer() then
				self:EmitSound(self.ENearSC)
				self:EmitSound(self.EFarSC)
			else
				DRC:EmitSound(soundent, self.ENearSC, self.EFarSC, 1750, SOUND_CONTEXT_EXPLOSION)
			end
		end)
		timer.Simple( 5, function() soundent:Remove() end)
	end ]]
	
	if self.SuperCombineType == "hl2" then
		if self:IsValid() then self:Explode("super") end
	elseif self.SuperCombineType == "lua" then
		if self:IsValid() then self:LuaExplode("super") end
	elseif self.SuperCombineType == "custom" then
		if self:IsValid() then self:DoSuperCustomExplode() end
	end
end

function ENT:LuaExplodeCustom()
end

function ENT:ReleasePressure(pressure, radius)
	if !IsValid(self) then return end
	if pressure == 0 then return end
	local pos = self:GetPos()

	local entities = ents.FindInSphere(pos, self.MSRadius)
	for k,v in pairs(entities) do
		local class = v:GetClass()
		local phys = v:GetPhysicsObject()
		
		if class == self:GetClass() && self.DoNotAffectSimilar == false && self.Gravity == true then
			if IsValid(v) && IsValid(phys) then phys:SetVelocity(phys:GetVelocity() + ((v:GetPos()-pos)*self.MSPressure/(v:GetPos()):Distance(pos) * 100) / phys:GetMass()) end
		else
			if IsValid(phys) and !(v:IsPlayer() or v:IsNPC() or v:IsNextBot()) then
				phys:SetVelocity((v:GetPos()-pos)*self.MSPressure/(v:GetPos()):Distance(pos) * 100)
			elseif DRC:IsCharacter(v) then
				if class != "npc_strider" && class != "npc_combinegunship" then
					local tr = util.TraceLine({
						start = self:GetPos(),
						endpos = v:GetPos() + v:OBBCenter(),
						filter = function(ent) if ent != v then return false else return true end end
					})
					local dir = tr.Normal:Angle():Forward() * 500
					v:SetVelocity(dir*self.MSPressure/(v:OBBCenter()):Distance(pos) * 50)
				end
			end
		end
	end
end

function ENT:LuaExplode(mode)
	local pos = self:GetPos()
	local phys = self:GetPhysicsObject()
	local owner = self:GetOwner()
	
	if mode == "default" then
		self.MSDamage			= self.Damage
		self.MSDamageType		= self.DamageType
		self.MSPressure			= self.ExplodePressure
		self.MSRadius			= self.AffectRadius
		self.MSExplShakePower	= self.ExplodeShakePower
		self.MSExplShakeDist	= self.ExplodeShakeDistance
		self.MSExplShakeTime	= self.ExplodeShakeTime
		self.MSLuaEffect		= self.LuaExplEffect
		self.MSPCFExplode		= self.PCFLuaExplEffect
	elseif mode == "super" then
		self.MSDamage			= self.SuperDamage
		self.MSDamageType		= self.SuperDamageType
		self.MSPressure			= self.SuperExplodePressure
		self.MSRadius			= self.SuperAffectRadius
		self.MSExplShakePower	= self.SuperExplodeShakePower
		self.MSExplShakeDist	= self.SuperExplodeShakeDistance
		self.MSExplShakeTime	= self.SuperExplodeShakeTime
		self.MSLuaEffect		= self.SuperLuaExplEffect
		self.MSPCFExplode		= self.PCFSuperLuaExplEffect
	end
	
	DRC:RenderSphere(pos, self.MSRadius, Color(255, 0, 0, 100), 2)
	
	if self.MSPressure != 0 then DRC:DynamicParticle(self, self.MSPressure * 30, self.MSPressure * 20, "blast", self.DynamicSounds, !self.DynamicParticles) end
	
	self:ReleasePressure(self.MSPressure, self.MSRadius)
	
	local entities = ents.FindInSphere(pos, self.MSRadius)
	for k,v in pairs(entities) do
		local totaldamage = 0
		local d1 = (self.MSDamage / (v:GetPos() + Vector(v:OBBCenter().x, v:OBBCenter().y, (v:OBBMaxs().z - (v:OBBMaxs().z/10)))):Distance(pos) * 20)*0.5
		local d2 = (self.MSDamage / (v:GetPos() + v:OBBCenter()):Distance(pos) * 20)*0.5
		totaldamage = d1 + d2
		
		local dmg2 = DamageInfo()
		dmg2:SetDamage(totaldamage)
		dmg2:SetInflictor(self)
		dmg2:SetDamageForce(self:EyeAngles():Forward())
		dmg2:SetDamagePosition(self:GetPos())
		dmg2:SetDamageType(self.MSDamageType)
		if !IsValid(owner) then dmg2:SetAttacker(self) else dmg2:SetAttacker(owner) end
		
		if SERVER && !DRC.HelperEnts[class] then
			if self.ExplosiveIgnoresCover == true then v:TakeDamageInfo(dmg2)
			else if DRC:EnvelopTrace(self, v) == true then v:TakeDamageInfo(dmg2) end end
		end
		
		if self.EMP == true then self:DoEMP(v) end
	end
	self:LuaExplodeCustom(entities)

	util.ScreenShake( Vector( self:GetPos() ), (self.MSExplShakePower / 2), self.MSExplShakePower, self.MSExplShakeTime, self.MSExplShakeDist )
		
	if IsValid(self) then
		if self.LuaExplEffect != nil or self.MSPCFExplode != nil then
			if self.LuaExplEffect != nil then
				local ed3 = EffectData()
				ed3:SetOrigin(pos)
				ed3:SetEntity(self)
				util.Effect(self.MSLuaEffect, ed3)
			end
			if mode == "super" then
				if self.MSPCFExplode != nil then ParticleEffect(self.MSPCFExplode, self:GetPos(), Angle(), nil) end
			else
				if self.MSPCFExplode != nil then ParticleEffect(self.MSPCFExplode, self:GetPos(), (self:GetAngles():Forward() * -50):Angle(), nil) end
			end
		end
	end
		
	if self.LoopingSound != nil then
		if self:IsValid() then
			self:StopSound(self.LoopingSound)
		end
	end
		
	if SERVER then SafeRemoveEntity(self) end
end

function ENT:Explode(mode)
	if !IsValid(self) then return end
	local pos = self:GetPos()
	
	if mode == "default" then
		self.MSDamage			= self.Damage
		self.MSPressure			= self.ExplodePressure
		self.MSRadius			= self.AffectRadius
		self.MSExplShakePower	= self.ExplodeShakePower
		self.MSExplShakeDist	= self.ExplodeShakeDistance
		self.MSExplShakeTime	= self.ExplodeShakeTime
	elseif mode == "super" then
		self.MSDamage			= self.SuperDamage
		self.MSPressure			= self.SuperExplodePressure
		self.MSRadius			= self.SuperAffectRadius
		self.MSExplShakePower	= self.SuperExplodeShakePower
		self.MSExplShakeDist	= self.SuperExplodeShakeDistance
		self.MSExplShakeTime	= self.SuperExplodeShakeTime
	end

	if self:GetOwner() != nil then
		self.explosion = self:GetOwner()
	else
		self.explosion = self
	end
	
	self:ReleasePressure(self.MSPressure, self.MSRadius)
	
	if SERVER then
		local explo = ents.Create("env_explosion")
		explo:SetOwner(self.explosion)
		explo:SetPos(self:GetPos())
		explo:SetKeyValue("iMagnitude", "25")
		explo:SetKeyValue("DamageForce", "0")
		explo:SetKeyValue("radius", self.AffectRadius)
		explo:Spawn()
		explo:Activate()
		explo:Fire("Explode", "", 0)
	end
	util.BlastDamage(self, self.explosion, self:GetPos(), self.MSRadius, self.MSDamage)
	util.ScreenShake( Vector( self:GetPos() ), (self.MSExplShakePower / 2), self.MSExplShakePower, self.MSExplShakeTime, self.MSExplShakeDist )
	
	for k,v in pairs(ents.FindInSphere(pos, self.MSRadius)) do if self.EMP == true then self:DoEMP(v) end end
	
	if self.LoopingSound != nil then
		if self:IsValid() then
			self:StopSound(self.LoopingSound)
		end
	end
	SafeRemoveEntity(self)
end

function ENT:DoCustomRemove()
end

function ENT:OnRemove()
	self:DoCustomRemove()
	if self.LoopingSound != nil then
		if self:IsValid() then
			self:StopSound(self.LoopingSound)
		end
	end
	
	if CLIENT && (self.RemoveEffect != nil or self.PCFRemoveEffect != nil) then
		if self.Effect != nil then
			local ed = EffectData()
			ed:SetOrigin(self:GetPos())
			ed:SetEntity(self)
			util.Effect(self.RemoveEffect, ed)
		end
		if self.PCFRemoveEffect != nil then ParticleEffect(self.PCFRemoveEffect, self:GetPos(), self:GetAngles(), self) end
	end
	
	if !SERVER then return end
	local ct = self:GetCreator()
	if ct then
		if ct.Draconic then
			local tab = ct.PTable
			if tab then
				table.RemoveByValue(tab, self)
			end
		end
	end
end