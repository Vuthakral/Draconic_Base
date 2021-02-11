ENT.Type            = "anim"
ENT.Spawnable		= false
ENT.PrintName		= "LFS extension script"
ENT.Category		= "Draconic"
AddCSLuaFile()

print("AAAAA")

--[[     I M P O R T A N T

Please, go to the GitHub wiki for this, and not just rip settings from the base as reference.
https://github.com/Vuthakral/Draconic_Base/wiki

It contains all of the settings, explanations on how to use them, tutorials, helpful links, etc.

--]]

ENT.EngineSound = ""

ENT.JetSprite = "effects/spark"

ENT.PrimarySpread = 0
ENT.PrimaryFireSound = "Weapon_SMG1.NPC_Single"

ENT.SecondarySpread = 0
ENT.SecondaryFireSound = "Weapon_SMG1.NPC_Single"

ENT.TertiarySpread = 0
ENT.TertiaryFireSound = "Weapon_SMG1.NPC_Single"

ENT.ProjSpawnPosPrimary 	= Vector(0, 0, 0)
ENT.ProjSpawnPosSecondary 	= Vector(0, 0, 0)
ENT.ProjSpawnPosTertiary 	= Vector(0, 0, 0)

ENT.ProjSpawnAngAddPrimary 		= Angle(0, 0, 0)
ENT.ProjSpawnAngAddSecondary 	= Angle(0, 0, 0)
ENT.ProjSpawnAngAddTertiary 	= Angle(0, 0, 0)

ENT.ImpactSoundDink = nil
ENT.ImpactSoundSoft = "MetalVehicle.ImpactSoft"
ENT.ImpactSoundHard = "Airboat_impact_hard"

ENT.ImpactSoftMinSpeed = 60
ENT.ImpactHardMinSpeed = 500

-- Do not touch anything beyond this point. Seriously. It will either do nothing or cause problems.
ENT.attackpos = Vector(0, 0, 0)
ENT.attackangadd = Angle(0, 0, 0)
ENT.DoorStatus = 0

function ENT:FireDRCProjectile(seat, mode, proj, vel, inheritvel)
	local proj = ents.Create(proj)
	if !proj:IsValid() then return false end

	if mode == "primary" then
		if self.WeaponPrimaryAttachments == nil then
			self.attackpos = self.ProjSpawnPosPrimary
			self.attackangadd = self.ProjSpawnAngAddPrimary
		else
			local tab = self.WeaponPrimaryAttachments
			local pickedatt = math.Round(math.Rand(1, #tab), 0)
			
			for k, v in pairs(tab) do
				if k == pickedatt then
					self.lpapa = v
				end
			end
			
			local att = self:LookupAttachment(self.lpapa)
			local attdata = self:GetAttachment(att)
			
			self.attackpos = attdata.Pos
			self.attackangadd = attdata.Ang
		end
	elseif mode == "secondary" then
		if self.WeaponSecondaryAttachments == nil then
			self.attackpos = self.ProjSpawnPosSecondary
			self.attackangadd = self.ProjSpawnAngAddSecondary
		else
			local tab = self.WeaponSecondaryAttachments
			local pickedatt = math.Round(math.Rand(1, #tab), 0)
			
			for k, v in pairs(tab) do
				if k == pickedatt then
					self.lpapa = v
				end
			end
			
			local att = self:LookupAttachment(self.lpapa)
			local attdata = self:GetAttachment(att)
			
			self.attackpos = attdata.Pos
			self.attackangadd = attdata.Ang
		end
	elseif mode == "tertiary" then
		if self.WeaponTertiaryAttachments == nil then
			self.attackpos = self.ProjSpawnPosTertiary
			self.attackangadd = self.ProjSpawnAngAddTertiary
		else
			local tab = self.WeaponTertiaryAttachments
			local pickedatt = math.Round(math.Rand(1, #tab), 0)
			
			for k, v in pairs(tab) do
				if k == pickedatt then
					self.lpapa = v
				end
			end
			
			local att = self:LookupAttachment(self.lpapa)
			local attdata = self:GetAttachment(att)
			
			self.attackpos = attdata.Pos
			self.attackangadd = attdata.Ang
		end
	end
	
	if seat == "driver" then
		local ply = self:GetDriver()
		self.aimang = ((ply:EyeAngles() + Angle(0, 90, 0)) - self:GetAngles()) + self.attackangadd
		proj:SetOwner(ply)
	elseif seat == "gunner" then
		local ply = self:GetGunner()
		self.aimang = ((ply:EyeAngles() + Angle(0, 90, 0)) - self:GetAngles()) + self.attackangadd
		proj:SetOwner(ply)
	end
	
	if mode == "primary" then
		if self.WeaponPrimaryAttachments != nil then
			proj:SetPos((self.attackpos))
			proj:SetAngles(self.attackangadd + self.ProjSpawnAngAddPrimary + Angle(math.Rand(-self.PrimarySpread, self.PrimarySpread), math.Rand(-self.PrimarySpread, self.PrimarySpread), 0))
		else
			proj:SetPos(self:LocalToWorld(self.attackpos))
			proj:SetAngles(self.aimang)
		end
		sound.Play( self.PrimaryFireSound, self.attackpos )
	elseif mode == "secondary" then
		if self.WeaponSecondaryAttachments != nil then
			proj:SetPos((self.attackpos))
			proj:SetAngles(self.attackangadd + self.ProjSpawnAngAddSecondary + Angle(math.Rand(-self.SecondarySpread, self.SecondarySpread), math.Rand(-self.SecondarySpread, self.SecondarySpread), 0))
		else
			proj:SetPos(self:LocalToWorld(self.attackpos))
			proj:SetAngles(self.aimang)
		end
		sound.Play( self.SecondaryFireSound, self.attackpos )
	elseif mode == "tertiary" then
		if self.WeaponTertiaryAttachments != nil then
			proj:SetPos((self.attackpos))
			proj:SetAngles(self.attackangadd + self.ProjSpawnAngAddTertiary + Angle(math.Rand(-self.TertiarySpread, self.TertiarySpread), math.Rand(-self.TertiarySpread, self.TertiarySpread), 0))
		else
			proj:SetPos(self:LocalToWorld(self.attackpos))
			proj:SetAngles(self.aimang)
		end
		sound.Play( self.TertiaryFireSound, self.attackpos )
	end

	proj:Spawn()
	constraint.NoCollide(self, proj, 0, 0)
	proj:Activate()
	
	local phys = proj:GetPhysicsObject()
	if !phys:IsValid() then return end
	if inheritvel == nil or inheritvel == false then
		phys:SetVelocity((phys:GetAngles():Forward() * vel))
	else
		phys:SetVelocity((phys:GetAngles():Forward() * vel) + self:GetVelocity())
	end
end

function ENT:DoCustomEngineStart()
end

function ENT:DoCustomEngineStop()
end

function ENT:DoCustomPhysicsCollide(data, phys)
end