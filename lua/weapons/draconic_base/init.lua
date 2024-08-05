AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("sh_funcs.lua")

function SWEP:SoundChain(tbl)
	local ply = self:GetOwner()
	if !tbl then return end
	for k,v in pairs(tbl) do
		local sound, thyme = v[1], v[2]
		timer.Simple(thyme, function() if IsValid(self) then
			if ply:GetActiveWeapon() != self then return end
			self:EmitSound(sound)
		end end)
	end
end