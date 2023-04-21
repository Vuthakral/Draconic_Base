AddCSLuaFile()
function EFFECT:Init(data)
	if !IsValid(data:GetEntity()) then return end
	self.Position = data:GetStart()
	self.Attachment = data:GetAttachment()
	
	local wpn = data:GetEntity()
	local att = wpn:GetAttachment(self.Attachment)
	if att == nil then
		att = { Ang = Angle(0, 0, 0), }
	end

	self.StartPos = self:GetTracerShootPos( self.Position, wpn, self.Attachment )
	self.EndPos = data:GetOrigin()
	self.Entity:SetRenderBoundsWS(self.StartPos, self.EndPos)
	
	local subt = self.EndPos - self.StartPos
	
	self.Normal = subt:GetNormal()

	if (IsValid(wpn) and (!wpn:IsWeapon() or !wpn:IsCarriedByLocalPlayer())) then
		local dist, pos, thyme = util.DistanceToLine(self.StartPos, self.EndPos, EyePos())
	end
	
	local ll = render.GetLightColor( self.StartPos ) * GetSF2LightLevel(0.05)
	local lla = ll.x + ll.y + ll.z / 3
	local mini = 200
	local smoketint = Vector(math.Clamp((200 * ll.x), mini, 200), math.Clamp((200 * ll.y), mini, 200), math.Clamp((200 * ll.z), mini, 200))
	
	local pos = Vector(0, 0, 0)
	local MuzzleSmoke = ParticleEmitter( self.StartPos )
	pos = self.StartPos
	for i = 0,90 do
		local particle = MuzzleSmoke:Add( "particle/particle_smokegrenade", pos + Vector( math.random(0,0),math.random(0,0),math.random(0,0))) 
		if particle == nil then particle = MuzzleSmoke:Add( "particle/particle_smokegrenade", pos + Vector(   math.random(0,0),math.random(0,0),math.random(0,0) ) ) end
		if (particle) then
			if i > 60 then
				particle:SetVelocity(att.Ang:Right() * math.Rand(0, 100)) -- left
			elseif i < 61 && i > 30 then
				particle:SetVelocity(att.Ang:Right() * -math.Rand(0, 100)) -- left
			else
				particle:SetVelocity(self.Normal * math.Rand(0, 250)) -- front
			end
			if i < 31 then
				particle:SetStartSize(math.Rand(4,7)) 
				particle:SetEndSize(math.Rand(5, 12))
			else
				particle:SetStartSize(math.Rand(1,3)) 
				particle:SetEndSize(math.Rand(2, 6))
			end
			particle:SetLifeTime(0) 
			particle:SetDieTime(math.Rand(0.02, 0.3)) 
			particle:SetStartAlpha(math.Rand(0,lla * 500))
			particle:SetEndAlpha(0)
			particle:SetLighting(false)
			particle:SetAngleVelocity( Angle(math.Rand(1,15)) ) 
			particle:SetRoll(math.Rand( 0, math.Rand(0.1,5) ))
			particle:SetColor(smoketint.x, smoketint.g, smoketint.z)
			particle:SetGravity( Vector(0,0,0) ) 
			particle:SetAirResistance(-68.167394537726 )  
			particle:SetCollide(true)
			particle:SetBounce(0.1419790559388)
		end
	end
	
	local TracerSmoke = ParticleEmitter( self.StartPos )
	pos = self.StartPos
	for i = 0,301 do
		local particle = TracerSmoke:Add( "particle/particle_smokegrenade", pos + Vector( math.random(0,0),math.random(0,0),math.random(0,0))) 
		if particle == nil then particle = TracerSmoke:Add( "particle/particle_smokegrenade", pos + Vector(   math.random(0,0),math.random(0,0),math.random(0,0) ) ) end
		if (particle) then
			particle:SetStartAlpha(math.Rand(0,lla * 500))
			particle:SetEndAlpha(0)
			particle:SetAirResistance( math.Rand(5,10) )  
			particle:SetStartSize(math.Rand(1,3)) 
			particle:SetEndSize(math.Rand(2, 6))
			if i > 300 then -- BE the BULLET.
				particle:SetVelocity(self.Normal * 20000) -- outer
				particle:SetStartLength(150)
				particle:SetEndLength(150)
				particle:SetBounce(50)
				particle:SetColor(255, 255, 0)
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(255)
				particle:SetAirResistance(-1)
				particle:SetDieTime(0.25)
				particle:SetStartSize(3) 
				particle:SetEndSize(3)
			elseif i < 300 && i > 200 then
				particle:SetVelocity(self.Normal * math.Rand(0, 10000)) -- outer
				particle:SetDieTime(math.Rand(2, 3)) 
			elseif i < 201 && i > 200 then
				particle:SetVelocity(self.Normal * math.Rand(0, 7500)) -- inner
				particle:SetDieTime(math.Rand(2, 3)) 
			else
				particle:SetVelocity(self.Normal * math.Rand(0, 5000)) -- center
				particle:SetDieTime(math.Rand(2, 3)) 
			end
			if i > 100 then
				particle:SetStartSize(math.Rand(2,7)) 
				particle:SetEndSize(math.Rand(5, 12))
				particle:SetBounce(0.0001)
			else
				particle:SetStartSize(math.Rand(1,3)) 
				particle:SetEndSize(math.Rand(2, 6))
				particle:SetStartLength(math.Rand(50,200))
				particle:SetEndLength(math.Rand(200,400))
				particle:SetBounce(50)
			end
			particle:SetLifeTime(0) 
			particle:SetLighting(false)
			particle:SetAngleVelocity( Angle(math.Rand(1,15)) ) 
			particle:SetRoll(math.Rand( 0, math.Rand(0.1,5) ))
			particle:SetGravity( Vector(0,0,0) ) 
			particle:SetCollide(true)
			
			particle:SetCollideCallback( function( part, hitpos, hitnormal )
				particle:SetDieTime(0)
			end )
			particle:SetNextThink(CurTime())
			particle:SetThinkFunction(function(part)
				local ll = render.GetLightColor(part:GetPos())
				local lla = ll.x + ll.y + ll.z / 3
				local mini = 1
				local smoketint = Vector(math.Clamp((200 * ll.x), mini, 255), math.Clamp((200 * ll.y), mini, 255), math.Clamp((200 * ll.z), mini, 255))
				local boost = 50
				smoketint.x = smoketint.x + (boost * lla)
				smoketint.y = smoketint.y + (boost * lla)
				smoketint.z = smoketint.z + (boost * lla)
				part:SetColor(smoketint.x,smoketint.y,smoketint.z)
				part:SetNextThink(CurTime())
			end)
		end
	end
	
	MuzzleSmoke:Finish()
	TracerSmoke:Finish()
end

function EFFECT:PhysicsCollide()
	self:Remove()
end

function EFFECT:Think()
end

function EFFECT:Render()
end