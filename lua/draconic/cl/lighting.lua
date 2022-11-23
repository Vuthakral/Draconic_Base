DRC.CalcView.MuzzleLamp_Time = 0


hook.Add("Think", "DRC_Lighting", function()
	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	
	for k,v in pairs(DRC.ActiveWeapons) do
		ply = v:GetParent()
		if IsValid(v) then
			if v.Glow == true then
				if !IsValid(ply) then
					DRC:DLight(v, v:GetPos(), v.GlowColor, v.GlowSize, 0.1, false, 1, v.GlowStyle)
				else
					if v:GetParent():GetActiveWeapon() == v then
						if v.Glow == true && CLIENT then
							local RightHand = ply:LookupAttachment("anim_attachment_RH")
							local pos = Vector()
							if RightHand != 0 then
								pos = ply:GetAttachment(RightHand).Pos
							else
								pos = ply:LocalToWorld(ply:OBBCenter() + Vector(15, -15, 0))
							end
							
							DRC:DLight(v, pos, v.GlowColor, v.GlowSize, 0.1, false, 1, v.GlowStyle)
						end
					end
				end
			end
		end
	end
	
	ply = LocalPlayer()
	local vm = ply:GetViewModel()
	if !IsValid(vm) then return end
	local wpn = ply:GetActiveWeapon()
	if !IsValid(wpn) then return end
	if !wpn.Draconic then 
		if DRC.CalcView.MuzzleLamp then
			DRC.CalcView.MuzzleLamp.Enabled = false
		end
	return end
	if wpn:HasViewModel() != true then return end
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
		local att = parent:LookupAttachment("muzzle")
		local attinfo = parent:GetAttachment(att)
		if attinfo == nil then return end
		ent:SetPos(attinfo.Pos)
		ent:SetAngles(attinfo.Ang)
		ent.Light:SetColor( Color(255, 150, 25) )
		if DRC.CalcView.MuzzleLamp_Time < CurTime() then ent.Enabled = false end
	end
end)