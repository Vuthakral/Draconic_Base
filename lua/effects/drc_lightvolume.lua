AddCSLuaFile()

function EFFECT:Init( data )
	local pos, ang, att = data:GetOrigin(), data:GetAngles(), data:GetAttachment()
	local ent = data:GetEntity()
	local col, width, length = data:GetStart(), data:GetRadius(), data:GetScale()
	
	data:SetStart(data:GetOrigin())
	ang = ent:GetAngles()
	
	local mat = ent.DRCVolumeLight.LightMaterial
	local normal = data:GetNormal()
	local emitter = ParticleEmitter(pos)
	
	local quality = data:GetFlags()*0.01
	local totalnum = length * quality
	local noskip = {}
	for i=1,totalnum do
		local calc = i*(quality/totalnum)
		local lerp = Lerp(calc, 0, length)/totalnum
		local skip = Lerp(lerp, 0, length)
		noskip[skip] = true
	end
	
	for i=1,length do
		if noskip[i] then
			local particle = emitter:Add(mat, pos)
			if particle then
				local size = Lerp(math.ease.OutSine(i/length), 1, length) * width
				local fade = Lerp(math.ease.InSine(i/length), length, 1)
				local spacing = quality + i*length*0.033
				particle:SetMaterial(mat)
				particle:SetLighting(false)
				particle:SetPos(pos + ang:Forward() * spacing)
				particle:SetVelocity(Vector(0, 0, 0))
				particle:SetLifeTime(0)
				particle:SetDieTime(math.huge)
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
					local newent = ent
					local ply = LocalPlayer()
					local thirdperson = DRC:ThirdPersonEnabled(ply)
					local light = ent.DRCVolumeLight
					if IsValid(ply) then
						local vm = ent == LocalPlayer():GetActiveWeapon() && thirdperson == false
						if vm then newent = ply:GetViewModel() end
						if !IsValid(ent) then part:SetDieTime(0) return end
						if !IsValid(newent) then part:SetDieTime(0) return end
						if !IsValid(light) then part:SetDieTime(0) return end
						if newent:IsWeapon() && newent:GetNWBool("IntegratedLightState") == false then part:SetDieTime(0) end
						if newent:LookupAttachment("flashlight") != 0 then att = newent:LookupAttachment("flashlight") end
						local atta = newent:GetAttachment(att)
						pos = atta.Pos
						ang = light:GetAngles()
						if light.AddAng then ang = ang + light.AddAng end
						if light.OffsetPos then
							pos:Add(ang:Right() * light.OffsetPos.x)
							pos:Add(ang:Forward() * light.OffsetPos.y)
							pos:Add(ang:Up() * light.OffsetPos.z)
						end
						part:SetPos(pos + ang:Forward() * spacing * 0.5)
						if ent.Alive && ent:Alive() == false then part:SetPos(Vector()) end
						
						if light.IsDynamic != false then
							local ncol = light.col
							if newent == ply && !thirdperson then ncol = Color(0, 0, 0, 0) end
							if ent:IsWeapon() && ent.Draconic && ent.IntegratedLight_DoVolume == false then ncol = Color(0, 0, 0, 0) end
							part:SetColor(ncol.r, ncol.g, ncol.b)
						end
						part:SetNextThink(CurTime() + 0)
					end
				end)
			end
		end
	end

	emitter:Finish()
end

function EFFECT:Think()
end

function EFFECT:Render()
end