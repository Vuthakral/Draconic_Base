function EFFECT:Init( data )
	local Pos = data:GetOrigin()
	
	local dt = data:GetDamageType()
	local flags = data:GetFlags()
	local dosound = dt > 0
	local hideparticle = flags == 1
	local alphamul = 1
	if hideparticle == true then alphamul = 0 end 
	if dosound == true then sound.Play("draconic.particles_metalbend", Pos) end
end

function EFFECT:Think()
end

function EFFECT:Render()
end