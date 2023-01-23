DRC:RegisterPlayerExtension("zombie", "Extensions", "Claws", true)
DRC:RegisterPlayerExtension("zombiefast", "Extensions", "Claws", true)
DRC:RegisterPlayerExtension("zombine", "Extensions", "Claws", true)

if InfMap then
	DRC.InfMap = {}

	function DRC.InfMap:Underwater(ent)
		if !IsValid(ent) then return end
		local pos = ent
		if !isvector(ent) then pos = ent:GetPos() end
		if ent:IsPlayer() then pos = ent:EyePos() end
		pos = InfMap.unlocalize_vector(pos, ent.CHUNK_OFFSET)
		return pos.z < InfMap.water_height
	end

	PrintTable(DRC.InfMap)
end