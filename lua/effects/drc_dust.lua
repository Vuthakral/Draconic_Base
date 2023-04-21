function EFFECT:Init( data )
	local Pos = data:GetOrigin()
	
	self.Position = data:GetStart()
	self.Magnitude = data:GetMagnitude()
	self.Normal = data:GetNormal()
	
	local emitter = ParticleEmitter( Pos )
	for i = 0,math.Rand(5,math.Clamp(self.Magnitude, 5, 150)) do
		local particle = emitter:Add( "particle/smokesprites_0001", Pos)
		if particle == nil then particle = emitter2:Add( "particle/smokesprites_0001", Pos) end
		if (particle) then
			local chance = math.Round(math.Rand(1,3))
			if chance == 1 then
				particle:SetMaterial("particle/smokesprites_0001")
			elseif chance == 2 then
				particle:SetMaterial("particle/smokesprites_0003")
			elseif chance == 3 then
				particle:SetMaterial("particle/smokesprites_0014")
			end
			
			local LighCol = render.GetLightColor(Pos)
			local OGCol = render.GetSurfaceColor(self.Normal * 5, Pos)
			OGCol = OGCol * 255
			OGCol.x = math.Clamp(OGCol.x + (LighCol.r * 255), 0, 255)
			OGCol.y = math.Clamp(OGCol.y + (LighCol.g * 255), 0, 255)
			OGCol.z = math.Clamp(OGCol.z + (LighCol.b * 255), 0, 255)
			
			particle:SetLighting(true)
			particle:SetPos(Pos + Vector(math.Rand(-self.Magnitude*2, self.Magnitude*2), math.Rand(-self.Magnitude*2, self.Magnitude*2), 1))
			particle:SetVelocity((self.Normal * 0.5) * math.Rand(-2, 2) * self.Magnitude )
			particle:SetLifeTime(math.Rand(0.1, 0.15)) 
			particle:SetDieTime(math.Rand(0.3,7))
			particle:SetStartAlpha(100)
			particle:SetEndAlpha(0)
			particle:SetStartSize(0.001 * self.Magnitude)
			particle:SetEndSize(3 * self.Magnitude)
			particle:SetStartLength(0)
			particle:SetEndLength(0)
			particle:SetAngleVelocity( Angle(0,3,0) ) 
			particle:SetRoll(math.Rand( 0, 30 ))
			particle:SetColor(OGCol.x, OGCol.y, OGCol.z)
			particle:SetGravity( Vector(0,0,math.Rand(-200, 20)) ) 
			particle:SetAirResistance(200)
			particle:SetCollide(false)
			particle:SetBounce(math.Rand(0.1,0.5))
			
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

	emitter:Finish()
end

function EFFECT:Think()
end

function EFFECT:Render()
end

