function EFFECT:Init( data )
	local Pos = data:GetOrigin()
	
	self.Position = data:GetStart()
	self.Magnitude = data:GetMagnitude()*0.6
	self.Normal = data:GetNormal()
	
	local emitter = ParticleEmitter( Pos )
	for i = 0,math.Rand(5,math.Clamp(self.Magnitude*4, 150, 350)) do
		local particle = emitter:Add( "particle/smokesprites_0001", Pos)
		if (particle) then
			local chance = math.Round(math.Rand(1,3))
			if chance == 1 then
				particle:SetMaterial("particle/smokesprites_0001")
			elseif chance == 2 then
				particle:SetMaterial("particle/snow")
			elseif chance == 3 then
				particle:SetMaterial("particle/smokesprites_0014")
			end
			
			local LighCol = render.GetLightColor(Pos)
			local OGCol = Vector(255, 255, 255)
			OGCol.x = math.Clamp(OGCol.x + (LighCol.r * 255), 0, 255)
			OGCol.y = math.Clamp(OGCol.y + (LighCol.g * 255), 0, 255)
			OGCol.z = math.Clamp(OGCol.z + (LighCol.b * 255), 0, 255)
			
			local dir = Vector(math.Rand(-self.Magnitude*2, self.Magnitude*2), math.Rand(-self.Magnitude*2, self.Magnitude*2), 1)
			
			particle:SetLighting(false)
			particle:SetPos(Pos + dir)
			particle:SetVelocity((self.Normal * 0.5) * math.Rand(-2, 2) * self.Magnitude + Vector(0, 0, (math.Rand(2, 39)*self.Magnitude)) + dir:Angle():Forward() * (math.Rand(2, 6)*self.Magnitude))
			particle:SetLifeTime(math.Rand(0.1, 0.15)) 
			particle:SetDieTime(math.Rand(0.3,7))
			particle:SetStartAlpha(math.Rand(100,255))
			particle:SetEndAlpha(0)
			particle:SetStartSize(0.004 * self.Magnitude)
			particle:SetEndSize(9 * self.Magnitude)
			particle:SetStartLength(0)
			particle:SetEndLength(0)
			particle:SetAngleVelocity( Angle(0,3,0) ) 
			particle:SetRoll(math.Rand( 0, 30 ))
			particle:SetColor(OGCol.x, OGCol.y, OGCol.z)
			particle:SetGravity( Vector(0,0,math.Rand(-200, -100)) ) 
			particle:SetAirResistance(200)
			particle:SetCollide(false)
			particle:SetBounce(math.Rand(0.1,0.2))
			
			if chance == 2 then
				particle:SetVelocity((self.Normal * 0.5) * math.Rand(-2, 2) * self.Magnitude + Vector(0, 0, (math.Rand(2, 29)*self.Magnitude)) + dir:Angle():Forward() * (math.Rand(2, 16)*self.Magnitude))
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(255)
				particle:SetDieTime(math.Rand(3,7))
				particle:SetStartSize(math.Rand(0.01, 0.05)*self.Magnitude)
				particle:SetEndSize(0)
				particle:SetAirResistance(0)
				particle:SetGravity(Vector(0, 0, -600))
				particle:SetCollide(true)
				particle:SetColor(255, 255, 255)
			end
			
			particle:SetNextThink(CurTime())
			particle:SetThinkFunction(function(part)
				local ll = render.GetLightColor(part:GetPos())
				local lla = ll.x + ll.y + ll.z / 3
				local mini = 1
				local smoketint = Vector(math.Clamp((200 * ll.x), mini, 255), math.Clamp((200 * ll.y), mini, 255), math.Clamp((200 * ll.z), mini, 255))
				local boost = 100
				smoketint.x = smoketint.x + (boost * lla)
				smoketint.y = smoketint.y + (boost * lla)
				smoketint.z = smoketint.z + (boost * lla)
				part:SetColor(smoketint.x,smoketint.y,smoketint.z)
				part:SetNextThink(CurTime() + math.Rand(0.2, 1))
			end)
		end
	end

	emitter:Finish()
end

function EFFECT:Think()
end

function EFFECT:Render()
end