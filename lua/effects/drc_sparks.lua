function EFFECT:Init( data )
	local Pos = data:GetOrigin()
	
	self.Position = data:GetStart()
	self.Magnitude = data:GetMagnitude()
	self.Normal = data:GetNormal()
	
	local emitter = ParticleEmitter( Pos )
	for i = 0,math.Rand(5,math.Clamp(self.Magnitude, 40, 150)) do
		local particle = emitter:Add( "effects/spark", Pos + Vector( math.random(-6,6),math.random(-6,6),math.random(0,0))) 
		if particle == nil then particle = emitter2:Add( "effects/spark", Pos + Vector(   math.random(-6,6),math.random(-6,6),math.random(0,0) ) ) end
		if (particle) then
			particle:SetVelocity((self.Normal * 150) + VectorRand() * 5 * self.Magnitude )
			particle:SetLifeTime(math.Rand(0.05, 0.5)) 
			particle:SetDieTime(math.Rand(1,3) * (self.Magnitude / 25)) 
			particle:SetStartAlpha(200)
			particle:SetEndAlpha(0)
			particle:SetStartSize(1) 
			particle:SetEndSize(0)
			particle:SetStartLength(math.Rand(0.1,0.5) * self.Magnitude)
			particle:SetEndLength(0)
			particle:SetAngleVelocity( Angle(4.2934407040912,14.149586106307,0.18606363772742) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(255, 255, 255)
			particle:SetGravity( Vector(0,0,math.Rand(-700,-900)) ) 
			particle:SetAirResistance(0)  
			particle:SetCollide(true)
			particle:SetBounce(math.Rand(0.3, 0.5))
		end
	end

	emitter:Finish()
end

function EFFECT:Think()		
	return false
end

function EFFECT:Render()
end

