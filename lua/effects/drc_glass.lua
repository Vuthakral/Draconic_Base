function EFFECT:Init( data )
	local Pos = data:GetOrigin()
	sound.Play("draconic.particles_glasscrack", Pos)
end

function EFFECT:Think()
end

function EFFECT:Render()
end