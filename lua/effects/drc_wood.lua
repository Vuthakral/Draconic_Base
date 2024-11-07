function EFFECT:Init( data )
	local Pos = data:GetOrigin()
	
	local dt = data:GetDamageType()
	local flags = data:GetFlags()
	local dosound = dt > 0
	local hideparticle = flags == 1
	local alphamul = 1
	if hideparticle == true then alphamul = 0 end 
	if dosound == true then sound.Play("draconic.particles_woodbreak", Pos) end
	
	self.Position = data:GetStart()
	self.Magnitude = data:GetMagnitude()
	self.Normal = data:GetNormal()
	
	local emitter = ParticleEmitter( Pos )
	for i = 0,math.Rand(5,math.Clamp(self.Magnitude, 5, 150)) do
		local offset = math.Rand(-5, 5)
		local particle = emitter:Add( "effects/fleck_cement2", Pos)
		if particle == nil then particle = emitter2:Add( "effects/fleck_cement2", Pos) end
		if (particle) then
			local chance = math.Round(math.Rand(1,2))
			if chance == 1 then
				particle:SetMaterial("effects/fleck_wood1")
			else
				particle:SetMaterial("effects/fleck_wood2")
			end
			
			local LighCol = render.GetLightColor(Pos)
			local OGCol = render.GetSurfaceColor(self.Normal * 5, Pos)
			OGCol = OGCol * 255
			OGCol.x = math.Clamp(OGCol.x + (LighCol.r * 255), 0, 255)
			OGCol.y = math.Clamp(OGCol.y + (LighCol.g * 255), 0, 255)
			OGCol.z = math.Clamp(OGCol.z + (LighCol.b * 255), 0, 255)
			
			particle:SetLighting(true)
			particle:SetPos(Pos + Vector(offset, offset, offset))
			particle:SetVelocity((self.Normal * 1.5) + VectorRand() * 5 * self.Magnitude )
			particle:SetLifeTime(math.Rand(0.65, 3)) 
			particle:SetDieTime(math.Rand(2,5) * (self.Magnitude / 50)) 
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(255)
			particle:SetStartSize(7) 
			particle:SetEndSize(0)
			particle:SetStartLength(0)
			particle:SetEndLength(0)
			particle:SetAngleVelocity( Angle(4.2934407040912,14.149586106307,0.18606363772742) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(OGCol.x, OGCol.y, OGCol.z)
			particle:SetGravity( Vector(0,0,math.Rand(-700,-900)) ) 
			particle:SetAirResistance(40)  
			particle:SetCollide(true)
			particle:SetBounce(math.Rand(0.1,0.5))
			
			particle:SetCollideCallback(function(part, hitpos, normal)
				local chance = math.Rand(1,100)
				if dosound == true && chance > 90 && DRC:DistFromLocalPlayer(hitpos) < 1250 then sound.Play("draconic.particles_wood", hitpos) end
			end)
		end
	end

	emitter:Finish()
end

function EFFECT:Think()
end

function EFFECT:Render()
end

