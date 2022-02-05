function EFFECT:Init( data )
	local Pos = data:GetOrigin()
	
	self.Position = data:GetStart()
	self.Magnitude = data:GetMagnitude()
	
	local sub = self.EndPos - self.StartPos
	self.Normal = sub:GetNormal()
	
	local emitter = ParticleEmitter( Pos )
	for i = 1,math.Rand(1,7) do
		local particle = emitter:Add( "effects/ar2ground2", Pos + Vector( math.random(-6,6),math.random(-6,6),math.random(0,0))) 
		if particle == nil then particle = emitter2:Add( "effects/ar2ground2", Pos + Vector(   math.random(-6,6),math.random(-6,6),math.random(0,0) ) ) end
		if (particle) then
			particle:SetVelocity((-self.Normal+VectorRand() * 1):GetNormal() * math.Rand(35, 225));
			particle:SetLifeTime(math.Rand(0.05, 0.5)) 
			particle:SetDieTime(math.Rand(1,3)) 
			particle:SetStartAlpha(200)
			particle:SetEndAlpha(0)
			particle:SetStartSize(2) 
			particle:SetEndSize(0)
			particle:SetStartLength(math.Rand(15,35))
			particle:SetEndLength(math.Rand(3,6))
			particle:SetAngleVelocity( Angle(4.2934407040912,14.149586106307,0.18606363772742) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(0, 180, 200)
			particle:SetGravity( Vector(0,0,math.Rand(-700,-900)) ) 
			particle:SetAirResistance(0)  
			particle:SetCollide(true)
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

