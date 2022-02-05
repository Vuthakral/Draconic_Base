surface.CreateFont("WpnDisplay", {
	font 	= "lcd",
	size	= 24,
	weight	= 300	
})

surface.CreateFont("ApercuStats", {
	font 	= "Verdana",
	size	= 22,
	weight	= 0,
	shadow	= true
})

surface.CreateFont("ApercuStatsTitle", {
	font 	= "Apercu Mono",
	size	= 24,
	weight	= 1000,	
	outline	= true
})

if GetConVar("cl_drc_sell_soul") == nil then
		CreateClientConVar("cl_drc_sell_soul", 1, {FCVAR_DEMO, FCVAR_USERINFO}, "Give unto the dragon.", 0, 1)
	end
	
	if GetConVar("cl_drc_disable_crosshairs") == nil then
		CreateClientConVar("cl_drc_disable_crosshairs", 0, true, true, "Hides all DSB related crosshairs (except for debug mode)", 0, 1)
	end

	if GetConVar("cl_drc_eyecolour_r") == nil then
		CreateConVar("cl_drc_eyecolour_r", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_eyecolour_g") == nil then
		CreateConVar("cl_drc_eyecolour_g", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_eyecolour_b") == nil then
		CreateConVar("cl_drc_eyecolour_b", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_energycolour_r") == nil then
		CreateConVar("cl_drc_energycolour_r", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_energycolour_g") == nil then
		CreateConVar("cl_drc_energycolour_g", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_energycolour_b") == nil then
		CreateConVar("cl_drc_energycolour_b", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_tint1_r") == nil then
		CreateConVar("cl_drc_tint1_r", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_tint1_g") == nil then
		CreateConVar("cl_drc_tint1_g", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_tint1_b") == nil then
		CreateConVar("cl_drc_tint1_b", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_tint2_r") == nil then
		CreateConVar("cl_drc_tint2_r", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_tint2_g") == nil then
		CreateConVar("cl_drc_tint2_g", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_tint2_b") == nil then
		CreateConVar("cl_drc_tint2_b", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end
	
	if GetConVar("cl_drc_vmoffset_x") == nil then
		CreateConVar("cl_drc_vmoffset_x", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end
	
	if GetConVar("cl_drc_vmoffset_y") == nil then
		CreateConVar("cl_drc_vmoffset_y", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end
	
	if GetConVar("cl_drc_vmoffset_z") == nil then
		CreateConVar("cl_drc_vmoffset_z", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end
	
net.Receive("DRCNetworkedAddText", function(length, ply)
	local msg = net.ReadTable()
	chat.AddText(unpack(msg))
end)

net.Receive("DRCNetworkGesture", function(len, ply)
	local tbl = net.ReadTable()
	
	local plyr = tbl.Player
	local slot = tbl.Slot
	local act = tbl.Activity
	local akill = tbl.Autokill

	DRCPlayGesture(plyr, slot, act, akill)
end)

net.Receive("DRCSound", function(len, ply)
	local nt = net.ReadTable()
	local ply = LocalPlayer()
	
	source = nt.Src or nil
	listener = nt.List or nil
	distance = nt.Dist or 1000
	
	if GetConVar("cl_drc_debugmode"):GetFloat() > 0 then
		if GetConVar("cl_drc_debug_invertnearfar"):GetFloat() > 0 then
			near = nt.Far or ""
			far = nt.Near or ""
		else
			near = nt.Near or ""
			far = nt.Far or ""
		end
	else
		near = nt.Near or ""
		far = nt.Far or ""
	end
		
	if !source:IsValid() then return end
	if source == nil then return end -- why
	local dist = math.Round((ply:GetPos() - source:GetPos()):Length(), 0)
	if dist < distance then
	--	source:EmitSound(near, nil, nil, nil, nil, nil, 1)
	else
	--	source:EmitSound(near, nil, nil, nil, nil, nil, 1)
		source:EmitSound(far, nil, nil, nil, nil, nil, 1)
	end
end)