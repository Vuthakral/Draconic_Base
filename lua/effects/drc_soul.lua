function EFFECT:Init( data )
	local Pos = data:GetOrigin()
	
	self.Position = data:GetStart()
	self.Magnitude = data:GetMagnitude()
	self.Normal = data:GetNormal()
	
	local emitter = ParticleEmitter( Pos )
	for i = 1,math.Rand(1,7) do
		local particle = emitter:Add( "sprites/heatwave", Pos + Vector( math.random(-6,6),math.random(-6,6),math.random(0,0))) 
		if (particle) then
			particle:SetVelocity((-self.Normal+VectorRand() * 1):GetNormal() * math.Rand(5, 25));
			particle:SetLifeTime(math.Rand(0.05, 0.5)) 
			particle:SetDieTime(math.Rand(1,3)) 
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(0)
			particle:SetEndSize(15)
			particle:SetStartLength(0)
			particle:SetEndLength(0)
			particle:SetAngleVelocity( Angle(4.2934407040912,14.149586106307,0.18606363772742) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(0, 180, 200)
			particle:SetGravity( Vector(0,0,math.Rand(-20,20)) ) 
			particle:SetAirResistance(0)  
			particle:SetCollide(false)
			particle:SetBounce(0.5)
		end
	end

	emitter:Finish()
		
end

function EFFECT:Think()		
	return false
end

function EFFECT:Render()
end

