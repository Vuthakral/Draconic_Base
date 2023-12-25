AddCSLuaFile()

function EFFECT:Init( data )
	local pos, ang, att = data:GetOrigin(), data:GetAngles(), data:GetAttachment()
	local ent = data:GetEntity()
	local col, width, length = data:GetStart(), data:GetRadius(), data:GetScale()
	data:SetStart(data:GetOrigin())
	
	ang = ent:GetAngles()

	local normal = data:GetNormal()
	
	local emitter = ParticleEmitter( pos )
	for i=1,length do
		local particle = emitter:Add( "sprites/glow04_noz", pos)
		if particle then
			local size = Lerp(math.ease.OutSine(i/length), 1, length) * width
			local fade = Lerp(math.ease.InSine(i/length), length, 1)
			particle:SetMaterial("sprites/glow04_noz")
			particle:SetLighting(false)
			particle:SetPos(pos + ang:Forward() * i)
			particle:SetVelocity(Vector(0, 0, 0))
			particle:SetLifeTime(0)
			particle:SetDieTime(1+RealFrameTime())
			particle:SetStartAlpha(fade)
			particle:SetEndAlpha(fade)
			particle:SetStartSize(size)
			particle:SetEndSize(size)
			particle:SetStartLength(0)
			particle:SetEndLength(0)
			particle:SetAngleVelocity(Angle(0, 0, 0)) 
			particle:SetRoll(0)
			particle:SetColor(col.x, col.y, col.z)
			particle:SetGravity( Vector(0,0,0) ) 
			particle:SetAirResistance(0)  
			particle:SetCollide(true)
			particle:SetBounce(0)
			
			particle:SetCollideCallback(function(part, hitpos, normal)
				part:Remove()
			end)
			
			particle:SetNextThink(CurTime())
			particle:SetThinkFunction(function(part)
				if !IsValid(ent) then return end
				pos = ent:GetAttachment(att).Pos
				ang = ent:GetAngles()
				part:SetPos(pos + ang:Forward() * i * 0.5)
				part:SetNextThink(CurTime() + RealFrameTime())
			end)
		end
	end

	emitter:Finish()
end

function EFFECT:Think()
end

function EFFECT:Render()
end