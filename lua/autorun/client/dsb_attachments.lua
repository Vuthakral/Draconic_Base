if SERVER then return end

local attachpos = {
	data = {
		Ammunition = Vector(0, 0, 0),
		Clipazine = Vector(0, 0, 0),
		Optic = Vector(0, 0, 0),
		Foregrip = Vector(0, 0, 0),
		Barrel = Vector(0, 0, 0),
		Stock = Vector(0, 0, 0),
		Internal = Vector(0, 0, 0),
		Charm = Vector(0, 0, 0)
	},
}

local function drc_AttachMenu()
	if GetConVar("cl_drawhud"):GetFloat() == 0 then return end
	if GetConVar("sv_drc_disable_attachmentmodifying"):GetFloat() == 1 then return end
	
	local ply = LocalPlayer() 
	local curswep = ply:GetActiveWeapon()
	if curswep.Draconic == nil then return end
	if curswep.MulIns == nil then return end
	local currentattachments = curswep.ActiveAttachments
	if currentattachments == nil then return end
	
	local bool = curswep:GetNWBool("Inspecting")
	
	local w = ScrW()
	local h = ScrH()
	local ratio = w/h
	local w2 = ScrW()/2
	local h2 = ScrH()/2
	
	if bool == true then
		alpha = Lerp(curswep.MulIns, 0, 255)
		YOffset = Lerp(curswep.MulIns, h/2, 0)
	else
		alpha = Lerp(curswep.MulIns, 255, 0)
		YOffset = Lerp(curswep.MulIns, 0, h )
	end
	
	if bool == false then
		alphalerp = Lerp(FrameTime() * 10, alphalerp or 0, 0)
		offsetlerp = Lerp(FrameTime() * 2.5, offsetlerp or h/h2/2, h/2)
	else
		alphalerp = Lerp(FrameTime() * 25, alphalerp or alpha or 0, alpha or 0)
		offsetlerp = Lerp(FrameTime() * 10, offsetlerp or YOffset, YOffset)
	end
	
	local WeapCol = ply:GetNWVector("WeaponColour_DRC")
	local TextCol = Color(200, 200, 200, alphalerp)
	local TitleCol = Color(255, 255, 255, alphalerp)
	
	for k,v in pairs(attachpos.data) do
		local pos = v:ToScreen()
		local InfoName = nil
		if k != nil && v != nil then
			if k == "Barrel" && currentattachments.Barrel != nil && #curswep.AttachmentTable.Barrels > 1 then -- this was too much of a table-in-table nightmare for my intermediate-ass to streamline
				InfoName = currentattachments.Barrel.t.InfoName
			elseif k == "Optic" && currentattachments.Optic != nil && #curswep.AttachmentTable.Optics > 1 then
				InfoName = currentattachments.Optic.t.InfoName
			elseif k == "Ammunition" && currentattachments.Ammunition != nil && #curswep.AttachmentTable.AmmunitionTypes > 1 then
				InfoName = currentattachments.Ammunition.t.InfoName
			end
			if InfoName != nil then
				draw.DrawText("".. InfoName .."", "ApercuStats", pos.x + 40, pos.y + 4, TextCol)
				surface.SetDrawColor( 255, 255, 255, alphalerp )
				surface.SetMaterial( Material("vgui/hud/autoaim") )
				surface.DrawTexturedRect(pos.x, pos.y, 32, 32)
			end
		end
	end
end
hook.Add("HUDPaint", "drc_hud_attachments", drc_AttachMenu)

local function DrawVMAttachments(att, ent)
	if !att then return end
	if !IsValid(ent) then return end
	
	local ply = LocalPlayer()
	local vm = ply:GetViewModel()
	if vm:LookupAttachment("muzzle") == 0 then return end
	
	local WeapCol = ply:GetNWVector("WeaponColour_DRC")
	local TextCol = Color(200, 200, 200, alphalerp)
	local TitleCol = Color(255, 255, 255, alphalerp)
	
	local wpn = ply:GetActiveWeapon()
	if wpn.Draconic == nil then return end
	
	local trace = util.TraceLine({
		start = ply:EyePos(),
		endpos = ply:GetEyeTrace().HitPos,
		filter = ply
	})
	
	local drc_debug_marker_attcol = Color(WeapCol.x*255, WeapCol.y*255, WeapCol.z*255, 100)
	
	local attach = nil
	if att == "Barrel" then
		local attachment = vm:LookupAttachment("muzzle")
		attach = vm:GetAttachment(attachment)
	elseif att == "Ammunition" then
		local attachment = vm:LookupAttachment("att_ammunition")
		if attachment != 0 then attach = vm:GetAttachment(attachment)
		elseif attachment == 0 then
			local attachment = vm:LookupAttachment("muzzle")
			attach = vm:GetAttachment(attachment)
			local badautoplacement = math.Clamp(vm:GetPos():DistToSqr(attach.Pos), 0, 1000)
			attach.Pos = attach.Pos - attach.Ang:Forward() * ((badautoplacement / 2) * (100 / wpn.ViewModelFOV)) / 32
		end
	elseif att == "Clipazine" then
		local attachment = vm:LookupAttachment("att_mag")
		if attachment != 0 then attach = vm:GetAttachment(attachment) end
	elseif att == "Optic" then
		local attachment = vm:LookupAttachment("att_optic")
		if attachment != 0 then attach = vm:GetAttachment(attachment) end
	elseif att == "Foregrip" then
		local attachment = vm:LookupAttachment("att_foregrip")
		if attachment != 0 then attach = vm:GetAttachment(attachment) end
	elseif att == "Barrel" then
		local attachment = vm:LookupAttachment("att_barrel")
		if attachment != 0 then attach = vm:GetAttachment(attachment) end
	elseif att == "Stock" then
		local attachment = vm:LookupAttachment("att_stock")
		if attachment != 0 then attach = vm:GetAttachment(attachment) end
	elseif att == "Internal" then
		local attachment = vm:LookupAttachment("att_internal")
		if attachment != 0 then attach = vm:GetAttachment(attachment) end
	elseif att == "Charm" then
		local attachment = vm:LookupAttachment("att_charm")
		if attachment != 0 then attach = vm:GetAttachment(attachment) end
	end
	
	if attach != nil then 
		attachpos.data[att] = attach.Pos
	else
		attachpos.data[att] = nil
	end
end

hook.Add("PreDrawViewModel", "drc_Attachment_Menu", function( vm, ply, wpn )
	if not CLIENT then return end -- fuck singleplayer
	if wpn.Draconic == nil then return end
	for k, v in pairs(attachpos.data) do
		DrawVMAttachments(k, vm)
	end
end)