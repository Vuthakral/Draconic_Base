hook.Add("Think", "DRC_Lighting", function()
	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	local vm = ply:GetViewModel()
	if !IsValid(vm) then return end
	local wpn = ply:GetActiveWeapon()
	if !IsValid(wpn) then return end
	if !wpn.Draconic then 
		if DRC.CalcView.MuzzleLamp then
			DRC.CalcView.MuzzleLamp.Enabled = false
		end
	return end
	if wpn.IsMelee == true then return end
	
	if !IsValid(DRC.CalcView.MuzzleLamp) then
		DRC.CalcView.MuzzleLamp = ents.CreateClientside("draconic_ptex_base")
		local lighttable = {
			["Texture"] 	= "",
			["NearZ"] 		= 1,
			["FarZ"] 		= 300,
			["FOV"]			= 140,
			["DrawShadows"] = true
		}
		DRC.CalcView.MuzzleLamp = DRC:ProjectedTexture(vm, "muzzle", lighttable)
	else
		if DRC:ThirdPersonEnabled(ply) then
			if DRC.CalcView.MuzzleLamp:GetParent() != wpn then DRC.CalcView.MuzzleLamp:SetParent(wpn) end
		else
			if DRC.CalcView.MuzzleLamp:GetParent() != vm then DRC.CalcView.MuzzleLamp:SetParent(vm) end
		end
	
		local ent = DRC.CalcView.MuzzleLamp
		local parent = ent:GetParent()
		if !IsValid(parent) then
			ent:SetParent(wpn) parent = ent:GetParent()
		end
	--	print(parent, DRC.CalcView.MuzzleLamp:GetParent())
		local att = parent:LookupAttachment("muzzle")
		local attinfo = parent:GetAttachment(att)
		if attinfo == nil then return end
		ent:SetPos(attinfo.Pos)
		ent:SetAngles(attinfo.Ang)
		ent.Enabled = false
		ent.Light:SetColor( Color(255, 150, 25) )
	--	print(parent)
	end
end)