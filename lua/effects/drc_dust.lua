function EFFECT:Init( data )
	local Pos = data:GetOrigin()
	
	self.Position = data:GetStart()
	self.Magnitude = data:GetMagnitude()
	self.Normal = data:GetNormal()
	
	
	
	local emitter = ParticleEmitter( Pos )
	for i = 0,math.Rand(5,math.Clamp(self.Magnitude, 5, 150)) do
		local offset = math.Rand(-5, 5)
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
			
			particle:SetLighting(false)
			particle:SetPos(Pos + Vector(offset, offset, offset))
			if i < 70 then
				particle:SetVelocity(VectorRand() * (0.1 * self.Magnitude ) * (self.Normal * 0.5) * math.Rand(-2, 2) * self.Magnitude )
			else
				particle:SetVelocity((self.Normal * 0.5) * math.Rand(-2, 2) * self.Magnitude )
			end
			particle:SetLifeTime(math.Rand(0.1, 0.15)) 
			particle:SetDieTime(math.Rand(0.3,2))
			particle:SetStartAlpha(100)
			particle:SetEndAlpha(0)
			particle:SetStartSize(0.0001 * self.Magnitude)
			particle:SetEndSize(0.9 * self.Magnitude)
			particle:SetStartLength(0)
			particle:SetEndLength(0)
			particle:SetAngleVelocity( Angle(4.2934407040912,14.149586106307,0.18606363772742) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(OGCol.x, OGCol.y, OGCol.z)
			particle:SetGravity( Vector(0,0,math.Rand(-50, 50)) ) 
			particle:SetAirResistance(200)
			particle:SetCollide(true)
			particle:SetBounce(math.Rand(0.1,0.5))
		end
	end

	emitter:Finish()
end

function EFFECT:Think()
end

function EFFECT:Render()
end

