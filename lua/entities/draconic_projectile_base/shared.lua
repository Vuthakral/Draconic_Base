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

ENT.Buoyancy			= 0.15
ENT.Drag				= nil
ENT.Mass				= nil

ENT.Damage 				= 25
ENT.DamageType			= DMG_GENERIC
ENT.Force				= 5
ENT.Gravity				= true
ENT.DoesRadialDamage 	= false
ENT.ProjectileType 		= "point"
ENT.ExplosionType		= "hl2"

ENT.SuperCombineRequirement		= 0
ENT.SuperDamage					= 100
ENT.SuperDamageType 			= DMG_GENERIC
ENT.SuperCombineType 			= "hl2"
ENT.SuperExplodePressure		= 100
ENT.SuperExplodeShakePower 		= 5
ENT.SuperExplodeShakeTime  		= 0.5	
ENT.SuperExplodeShakeDistance 	= 500

ENT.FuseTime	= 5
ENT.DetonateOnRelease = false
ENT.ReleaseArmTime = 1

ENT.ExplodeShakePower 		= 5
ENT.ExplodeShakeTime  		= 0.5	
ENT.ExplodeShakeDistance 	= 500

ENT.LoopingSound		= nil
ENT.ExplodeSoundNear	= nil
ENT.ExplodeSoundFar		= nil

ENT.ExplodePressure			= 5

ENT.AffectRadius	= 0.0001
ENT.SuperAffectRadius	= 0.0001

ENT.SpawnEffect			= nil
ENT.Effect				= nil
ENT.LuaExplEffect		= nil
ENT.SuperLuaExplEffect	= nil

ENT.ImpactEffect	= nil
ENT.ImpactSound		= nil

ENT.TracksNPCs		= false
ENT.TracksPlayers	= false
ENT.TrackRadius		= 15
ENT.TrackDist		= 250

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

ENT.TimerFrequency	= 1

ENT.GravitySpherePower	= 0

-- DO NOT TOUCH ZONE
ENT.ENear	= nil
ENT.EFar	= nil
ENT.Triggered = false
ENT.Draconic = true

function ENT:Think()
	local vel = self:GetVelocity()
	local phys = self:GetPhysicsObject()
	local pos = self:GetPos()
	local type = self.ProjectileType
	local owner = self:GetOwner()
	local st = self.SpawnTime
	local lt = st + 5
	self.LastPos = pos
	
	self.TimerName = "DPTimer_".. self:EntIndex() ..""
	
	if !timer.Exists(self.TimerName) && type != "sticky" && type != "playersticky" && type != "supercombine" && type != "magazine" then
		timer.Create(self.TimerName, self.TimerFrequency, 0, function()
			if not SERVER then return end
			for f, v in pairs(ents.FindInSphere(self.LastPos, self.AffectRadius)) do
				if !IsValid(v) then return end
				if v:EntIndex() == self:EntIndex() then return end
				if v:IsWorld() then return end

				local dmg69 = DamageInfo()
					dmg69:SetDamage(self.Damage / 25 / (v:GetPos()):Distance(self.LastPos) * 20)
					if IsValid(owner) then
						dmg69:SetAttacker(owner)
					else
						dmg69:SetAttacker(self)
					end
					dmg69:SetInflictor(self)
					dmg69:SetDamageForce(self:EyeAngles():Forward())
					dmg69:SetDamagePosition(self.LastPos)
					dmg69:SetDamageType(self.DamageType)
				
				if IsValid(v:GetPhysicsObject()) && !(v:IsPlayer() or v:IsNPC() or v:IsNextBot()) then
					if self.GravitySpherePower != 0 then v:GetPhysicsObject():SetVelocity((v:GetPos()-self.LastPos)*self.GravitySpherePower/(v:GetPos()):Distance(self.LastPos)) end
					if v:Health() != 0 && v:Health() != nil && self.DoesRadialDamage == true then v:TakeDamageInfo(dmg69) end
				elseif v:IsPlayer() or v:IsNPC() or v:IsNextBot() then
					if self.GravitySpherePower != 0 then v:SetVelocity((v:GetPos()-self.LastPos)*self.GravitySpherePower/(v:GetPos()):Distance(self.LastPos)) end
					if v:Health() != 0 && v:Health() != nil && self.DoesRadialDamage == true then v:TakeDamageInfo(dmg69) end
				else
					if self.GravitySpherePower != 0 then v:SetVelocity((v:GetPos()-self.LastPos)*self.GravitySpherePower/(v:GetPos()):Distance(self.LastPos)) end
				end
			end
		end)
	end
	
	if vel == vector_origin then return end
	local tr = util.TraceLine({start=self:GetPos(), endpos=self:GetPos() + vel:GetNormal() * 20, filter={self, self:GetOwner()}, mask=MASK_SHOT_HULL})
	
	if self.Effect != nil then
		if !phys:IsValid() then return end
		local ed = EffectData()
		ed:SetOrigin(phys:GetPos())
		ed:SetEntity(self)
		util.Effect(self.Effect, ed)
	end
	
--	if self.TracksNPCs == true or self.TracksPlayers == true then
--		local track = ents.FindInCone( self:GetPos(), self:GetForward(), self.TrackDist, math.cos(self.TrackRadius) )
--		PrintTable(track)
--	end

	self:DoCustomThink()
end

function ENT:DoCustomThink()
end

function ENT:PhysicsUpdate()
	local phys = self:GetPhysicsObject()
	local vel = phys:GetVelocity()
	local pos = phys:GetPos()
	local type = self.ProjectileType
	local owner = self:GetOwner()
	local st = self.SpawnTime
	local lt = st + 5
	self.LastPos = pos
	
	if type == "magazine" then return end
	if CurTime() > st + 0.5 && (vel.x > 50 or vel.y > 50 or vel.z > 50) then phys:SetAngles( vel:Angle() ) phys:SetVelocity(vel) end
end

function ENT:Initialize()
local type = self.ProjectileType

	self.SpawnTime = CurTime()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	
local phys = self:GetPhysicsObject()
	phys:SetBuoyancyRatio(self.Buoyancy)
	if self.Mass == 0 then self.Mass = 1 phys:SetMass(self.Mass) end
	if self.Mass != nil then phys:SetMass(self.Mass) end
	if self.Drag != nil then phys:SetDragCoefficient(self.Drag) end
	
	self.Vel = self:GetVelocity()
	self.Triggered = false
	self.FirstBounce = false
	self.SpawnTime = CurTime()
	self.SafeTime = CurTime() + self.ReleaseArmTime
--	timer.Simple(0.1, function() if self:GetOwner():KeyDown(IN_ATTACK) then self.Held = true else self.Held = false end end)

	
	if SERVER && self.TrailMat != nil then
		util.SpriteTrail( self, 0, self.TrailColor, self.TrailAdditive, self.TrailStartWidth, self.TrailEndWidth, self.TrailLifeTime,1 / ( self.TrailStartWidth + self.TrailEndWidth ) * 0.5, self.TrailMat )
	end
	
	if SERVER && self.TrailMat2 != nil then
		util.SpriteTrail( self, 0, self.TrailColor2, self.TrailAdditive2, self.TrailStartWidth2, self.TrailEndWidth2, self.TrailLifeTime2,1 / ( self.TrailStartWidth2 + self.TrailEndWidth2 ) * 0.5, self.TrailMat2 )
	end
	
	if self.HideModel == true then
		self:SetMaterial("models/vuthakral/nodraw")
		self:DrawShadow(false)
	end
	
	if SERVER && type == "magazine" then
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	
		timer.Simple(15, function() self:Remove() end)
	else end
	
	if SERVER && type == "fire" then
		timer.Simple(self.FuseTime, function() if self:IsValid() then self:Remove() end end)
	end
	
	if self.ExplodeSoundNear == nil then
		self.ENear	= "draconic.ExplosionSmallGeneric"
	else
		self.ENear	= self.ExplodeSoundNear 
	end
	if self.ExplodeSoundFar == nil then
		self.EFar	= "draconic.ExplosionDistGeneric"
	else
		self.EFar	= self.ExplodeSoundFar
	end
	
	if self.Gravity == false then
		phys:EnableGravity(false)
	else end

	if SERVER && type == "grenade" or type == "sticky" or type == "playersticky" or type == "supercombine" then
		timer.Simple(self.FuseTime, function() if self:IsValid() then self:TriggerExplosion() end end)
	else end
	
	if self.SpawnEffect != nil then
		local ed2 = EffectData()
		ed2:SetOrigin(phys:GetPos())
		ed2:SetEntity(self)
		util.Effect(self.SpawnEffect, ed2)
	end
	
	if self.LoopingSound != nil then
		if self:IsValid() then
			self:EmitSound(Sound(self.LoopingSound))
		end
	end
	
	self:DoCustomInitialize()
	if SERVER then
		timer.Simple(60, function() if self:IsValid() then self:Remove() end end)
	end
end

function ENT:DoCustomInitialize()
end

function ENT:Draw()
if CLIENT then
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

local cooldown = 0
function ENT:PhysicsCollide( data, phys )
local type = self.ProjectileType
local tgt = data.HitEntity
local cl = self:GetClass()
local SCC = "sc_".. self:GetClass() ..""

	if tgt:IsWorld() == false then
		local NI = tgt:GetNWInt(SCC)
		if type == "point" then
			local tr = util.TraceLine({start=self:GetPos(), endpos=tgt:LocalToWorld(tgt:OBBCenter()), filter={self, self:GetOwner()}, mask=MASK_SHOT_HULL})
			self:DamageTarget(tgt, tr)
			self:DoImpactEffect()
			if self.EMP == true then self:DoEMP(tgt) end
		elseif type == "explosive" then
			self:TriggerExplosion()
			self:DoImpactEffect()
			if self.EMP == true then self:DoEMP(tgt) end
		elseif type == "lua_explosive" then
			self.ExplosionType = "lua"
			self:TriggerExplosion()
			self:DoImpactEffect()
			if self.EMP == true then self:DoEMP(tgt) end
		elseif type == "playersticky" then 
			if tgt:IsNPC() or tgt:IsNextBot() or (tgt:IsPlayer() and tgt ~= self:GetOwner()) or (tgt == self:GetOwner() and tgt:IsVehicle()) then
				self:SetSolid(SOLID_NONE)
				self:SetMoveType(MOVETYPE_NONE)
				self:SetParent(tgt)
				self:DoImpactEffect()
				if self.EMP == true then self:DoEMP(tgt) end
			end
		elseif type == "sticky" then
			if tgt:IsNPC() or tgt:IsNextBot() or tgt:IsWorld() or (tgt:IsPlayer() and tgt ~= self:GetOwner()) or (tgt == self:GetOwner() and tgt:IsVehicle()) then
				self:SetSolid(SOLID_NONE)
				self:SetMoveType(MOVETYPE_NONE)
				self:SetParent(tgt)
				self:DoImpactEffect()
				if self.EMP == true then self:DoEMP(tgt) end
			end
		elseif type == "FuseAfterFirstBounce" then
			if self.FirstBounce == false then self.FirstBounce = true end
			if self.FirstBounce == true then timer.Simple(self.FuseTime, function() if self:IsValid() then self:TriggerExplosion() end end) end
		elseif type == "supercombine" then
			self:SetSolid(SOLID_NONE)
			self:SetMoveType(MOVETYPE_NONE)
			self:SetParent(tgt)
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
			--	print(NI)
				timer.Simple(self.FuseTime - 0.25, function()
					if self:IsValid() then
						local CNI = tgt:GetNWInt(SCC)
						tgt:SetNWInt(SCC, CNI - 1)
					--	print("Supercombine entity removed. | SC Score: ".. NI .."")
					end
				end)
			end
		end
	elseif tgt:IsWorld() == true then
		if type == "point" then
			timer.Simple(0.01, function() self:Remove() end)
			self:DoImpactEffect()
		elseif type == "explosive" then
			self:TriggerExplosion()
			self:DoImpactEffect()
		elseif type == "lua_explosive" then
			self.ExplosionType = "lua"
			self:TriggerExplosion()
			self:DoImpactEffect()
		elseif type == "sticky" or type == "supercombine" then
			self:SetSolid(SOLID_NONE)
			self:SetMoveType(MOVETYPE_NONE)
		--	self:SetParent(tgt)
			self:DoImpactEffect()
		elseif type == "FuseAfterFirstBounce" then
			if self.FirstBounce == false then self.FirstBounce = true end
			if self.FirstBounce == true then timer.Simple(self.FuseTime, function() if self:IsValid() then self:TriggerExplosion() end end) end
		elseif type == "fire" then
			
			if CurTime() > cooldown then
			--	print("attempting decal")
				local startpos = self:GetPos()
				local endpos = self:GetVelocity():Angle():Forward() * 25
				util.Decal("Scorch", startpos, endpos, {self})
				cooldown = CurTime() + 0.05
			end
		end
	end
end

function ENT:DamageTarget(tgt, tr)
	local owner = self:GetOwner()

	local dmg = DamageInfo()
	dmg:SetDamage(self.Damage)
	dmg:SetInflictor(self)
	if owner != nil then
		dmg:SetAttacker(owner)
	else
		dmg:SetAttacker(self)
	end
	dmg:SetDamageForce(self:EyeAngles():Forward())
	dmg:SetDamagePosition(self:GetPos())
	dmg:SetDamageType(self.DamageType)
	
	local ang = Angle(0,0,0) + tr.Normal:Angle()
	tgt:DispatchTraceAttack(dmg, self:GetPos() + ang:Forward() * 3, tgt:GetPos()) -- this code is taken from the TTT knife because I have no fucking clue how this works
	
	timer.Simple(0.01, function() if self:IsValid() then self:Remove() end end)
end

function ENT:DoImpactEffect()
	if self:IsValid() then
		if self.ImpactSound != nil && !game.IsDedicated() then self:EmitSound(Sound(self.ImpactSound)) end
		if self.ImpactEffect != nil then
			local ed69 = EffectData()
			ed69:SetOrigin(self:GetPos())
			ed69:SetEntity(self)
			util.Effect(self.ImpactEffect, ed69)
		end
	end
end

function ENT:DoEMP(target, hitpos)
	if self:IsValid() then
		local tgt = target
		local hitpos = self:GetPos()
		
		if GetConVar("cl_drc_debugmode"):GetString() == "0" then else print("EMP Triggered on ".. tgt:GetClass() .."") end
		
		if tgt.ResistsEMP != nil && tgt.ResistsEMP == true then
		elseif tgt.ResistsEMP != nil && tgt.ResistsEMP == false then
			if tgt.LFS != nil && tgt.LFS == true then
				if tgt:GetEngineActive() == true then 
					if GetConVar("cl_drc_debugmode"):GetString() == "0" then else print("EMP Done (LFS)") end
					if self.EMPSound != nil then self:EmitSound(Sound(self.EMPSound)) end
					tgt:StopEngine()
					timer.Simple(self.EMPTime, function() tgt:StartEngine() end)
				end 
			elseif tgt:GetClass() == "gmod_sent_vehicle_fphysics_base" then
				if tgt:GetActive() == true then
					if GetConVar("cl_drc_debugmode"):GetString() == "0" then else print("EMP Done (Simfphys)") end
					if self.EMPSound != nil then self:EmitSound(Sound(self.EMPSound)) end
					tgt:StopEngine()
					tgt:SetActive( false )
					timer.Simple(self.EMPTime, function() tgt:StartEngine() tgt:SetActive( true ) end)
				end
			end
		elseif tgt.ResistsEMP == nil then
			if GetConVar("cl_drc_debugmode"):GetString() == "0" then else print("EMP Found nil resistance") end
			if tgt:IsPlayer() && tgt:Armor() > 0 then
				if GetConVar("cl_drc_debugmode"):GetString() == "0" then else print("EMP Done (Player)") end
					tgt:SetArmor(0)
				if self.EMPSound != nil && !game.IsDedicated() then
					self:EmitSound(Sound(self.EMPSound))
				end 
			elseif tgt:IsPlayer() && tgt:Armor() < 1 then
				if GetConVar("cl_drc_debugmode"):GetString() == "0" then else print("EMP Done (Player); but target's armour was already 0.") end
			elseif tgt:IsNextBot() && tgt.Shield != nil then -- Iv04 Nextbot shield stripping
				tgt.Shield = -1
				self:EmitSound(Sound(self.EMPSound))
			end
			if tgt.LFS != nil && tgt.LFS == true then
				if tgt:GetEngineActive() == true then
					if GetConVar("cl_drc_debugmode"):GetString() == "0" then else print("EMP Done (LFS)") end
					if self.EMPSound != nil then self:EmitSound(Sound(self.EMPSound)) end
					tgt:StopEngine()
					timer.Simple(self.EMPTime, function() tgt:StartEngine() end)
				end
			elseif tgt:GetClass() == "gmod_sent_vehicle_fphysics_base" then 
				if tgt:GetActive() == true then
					if GetConVar("cl_drc_debugmode"):GetString() == "0" then else print("EMP Done (Simfphys)") end
					if self.EMPSound != nil then self:EmitSound(Sound(self.EMPSound)) end
					tgt:StopEngine()
					tgt:SetActive( false )
					timer.Simple(self.EMPTime, function() tgt:StartEngine() tgt:SetActive( true ) end)
				end
			elseif tgt:GetClass() == "prop_vehicle_jeep" or tgt:GetClass() == "prop_vehicle_airboat" then
				if tgt:IsEngineStarted() == true then
					if GetConVar("cl_drc_debugmode"):GetString() == "0" then else print("EMP Done (Base vehicle entity)") end
					if self.EMPSound != nil then self:EmitSound(Sound(self.EMPSound)) end
					tgt:StartEngine(false)
					timer.Simple(self.EMPTime, function() tgt:StartEngine(true) end)
				end
			end
		end
	end
end


function ENT:TriggerExplosion()	
	local type = self.ProjectileType

	if self.Triggered == false then
		if not SERVER then return end
		self.Triggered = true
		
		if type == "sticky" or type == "playersticky" or type == "supercombine" then
			DRCSound(self, self.ENear, self.EFar, 1750)
		else
			local soundent = ents.Create("drc_dummy")
			soundent:SetPos(self:GetPos())
			soundent:Spawn()
			timer.Simple( FrameTime(), function() DRCSound(soundent, self.ENear, self.EFar, 1750) end)
			timer.Simple( 5, function() soundent:Remove() end)
		end
	end
	
	if self.ExplosionType == "hl2" then
		if self:IsValid() then self:Explode("default") end
	elseif self.ExplosionType == "lua" then
		if self:IsValid() then self:LuaExplode("default") end
	elseif self.ExplosionType == "custom" then
		if self:IsValid() then self:DoCustomExplode() end
	end
end

function ENT:TriggerSC()	
	if self.Triggered == false then
		if not SERVER then return end
		self.Triggered = true
		local soundent = ents.Create("drc_dummy")
		soundent:SetPos(self:GetPos())
		soundent:Spawn()
		timer.Simple( FrameTime(), function() DRCSound(soundent, self.ENearSC, self.EFarSC, 1750) end)
		timer.Simple( 5, function() soundent:Remove() end)
	end
	
	if self.SuperCombineType == "hl2" then
		if self:IsValid() then self:Explode("super") end
	elseif self.SuperCombineType == "lua" then
		if self:IsValid() then self:LuaExplode("super") end
	elseif self.SuperCombineType == "custom" then
		if self:IsValid() then self:DoSuperCustomExplode() end
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
	elseif mode == "super" then
		self.MSDamage			= self.SuperDamage
		self.MSDamageType		= self.SuperDamageType
		self.MSPressure			= self.SuperExplodePressure
		self.MSRadius			= self.SuperAffectRadius
		self.MSExplShakePower	= self.SuperExplodeShakePower
		self.MSExplShakeDist	= self.SuperExplodeShakeDistance
		self.MSExplShakeTime	= self.SuperExplodeShakeTime
		self.MSLuaEffect		= self.SuperLuaExplEffect
	end
	
	for f, v in pairs(ents.FindInSphere(pos, self.MSRadius)) do
	
	local dmg2 = DamageInfo()
	dmg2:SetDamage(self.MSDamage / (v:GetPos() + Vector(0, 0, 10)):Distance(pos) * 20)
	dmg2:SetInflictor(self)
	dmg2:SetDamageForce(self:EyeAngles():Forward())
	dmg2:SetDamagePosition(self:GetPos())
	dmg2:SetDamageType(self.MSDamageType)
	if !IsValid(owner) then
		dmg2:SetAttacker(self)
	else
		dmg2:SetAttacker(owner)
	end
	
		if v:GetClass() == self:GetClass() then
			if self.Gravity == true then
				if v:IsValid() && v:GetPhysicsObject():IsValid() then v:GetPhysicsObject():SetVelocity( v:GetPhysicsObject():GetVelocity() + ((v:GetPos()-pos)*self.MSPressure/(v:GetPos()):Distance(pos) * 100) / v:GetPhysicsObject():GetMass()) end
			end
		else
			if IsValid(v:GetPhysicsObject()) and !(v:IsPlayer() or v:IsNPC() or v:IsNextBot()) then
				v:GetPhysicsObject():SetVelocity((v:GetPos()-pos)*self.MSPressure/(v:GetPos()):Distance(pos) * 100)
			elseif v:IsPlayer() or v:IsNPC() or v:IsNextBot() then
				v:SetVelocity((v:OBBCenter()-pos)*self.MSPressure/(v:OBBCenter()):Distance(pos) * 50)
			end
			v:TakeDamageInfo(dmg2)
			if self.EMP == true then self:DoEMP(v) end
		end
	end

	util.ScreenShake( Vector( self:GetPos() ), (self.MSExplShakePower / 2), self.MSExplShakePower, self.MSExplShakeTime, self.MSExplShakeDist )
		
	if self:IsValid() then
		if self.LuaExplEffect != nil then
			local ed3 = EffectData()
			ed3:SetOrigin(pos)
			ed3:SetEntity(self)
			util.Effect(self.MSLuaEffect, ed3)
		end
	end
		
	if self.LoopingSound != nil then
		if self:IsValid() then
			self:StopSound(self.LoopingSound)
		end
	end
		
	SafeRemoveEntity(self)
end

function ENT:Explode(mode)
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
			
	local explo = ents.Create("env_explosion")
		explo:SetOwner(self.explosion)
		explo:SetPos(self.Entity:GetPos())
		explo:SetKeyValue("iMagnitude", "25")
		explo:SetKeyValue("radius", self.AffectRadius)
		explo:Spawn()
		explo:Activate()
		explo:Fire("Explode", "", 0)
	util.BlastDamage(self, self.explosion, self:GetPos(), self.MSRadius, self.MSDamage)
	util.ScreenShake( Vector( self:GetPos() ), (self.MSExplShakePower / 2), self.MSExplShakePower, self.MSExplShakeTime, self.MSExplShakeDist )
	
	for f, v in pairs(ents.FindInSphere(pos, self.MSRadius)) do
		if IsValid(v:GetPhysicsObject()) and !(v:IsPlayer() or v:IsNPC() or v:IsNextBot()) then
			v:GetPhysicsObject():SetVelocity((v:GetPos()-pos)*self.MSPressure/(v:GetPos()):Distance(pos) * 50)
		else
			v:SetVelocity((v:GetPos()-pos)*self.MSPressure/(v:GetPos()):Distance(pos))
		end
	end
	
	if self.LoopingSound != nil then
		if self:IsValid() then
			self:StopSound(self.LoopingSound)
		end
	end
	
	timer.Simple(0.01, function() self:Remove() end)
end

function ENT:OnRemove()

	if self.TimerName != nil then
		if timer.Exists(self.TimerName) then
			timer.Remove(self.TimerName)
		end
	end

	if self.LoopingSound != nil then
		if self:IsValid() then
			self:StopSound(self.LoopingSound)
		end
	end
end