function EFFECT:Init( data )
	local Pos = data:GetOrigin()
	sound.Play("draconic.particles_metalbend", Pos)
end

function EFFECT:Think()
end

function EFFECT:Render()
end