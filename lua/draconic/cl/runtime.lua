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
		CreateClientConVar("cl_drc_disable_crosshairs", 0, true, true, "Hides all DRC related crosshairs (except for debug mode)", 0, 1)
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

	DRC:PlayGesture(plyr, slot, act, akill)
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

net.Receive("DRC_WeaponDropped", function()
	local weapon = net.ReadEntity()
	if IsValid(weapon) && weapon.DoCustomDrop then
		weapon:DoCustomDrop()
	end
end)

net.Receive("DRC_RequestLightColour", function()
	local ent = net.ReadEntity()
	if !IsValid(ent) then return end
	local light = render.GetLightColor(ent:GetPos() + ent:OBBCenter())
	
	local tab = {ent, light}
	net.Start("DRC_ReceiveLightColour")
	net.WriteTable(tab)
	net.SendToServer()
end)

net.Receive("DRC_SetRPModels", function(length, ply)
	local models = net.ReadTable()
	DRC.CurrentRPModelOptions = models
	PrintTable(DRC.CurrentRPModelOptions)
end)

local HideHUDElements = {
	["CHudAmmo"] = "E",
	["CHudBattery"] = "E",
	["CHudChat"] = "E",
	["CHudCrosshair"] = "E",
	["CHudCloseCaption"] = "E",
	["CHudDamageIndicator"] = "E",
	["CHudDeathNotice"] = "E",
	["CHudGeiger"] = "E",
	["CHudHealth"] = "E",
	["CHudHintDisplay"] = "E",
	["CHudMenu"] = "E",
	["CHudMessage"] = "E",
	["CHudPoisonDamageIndicator"] = "E",
	["CHudSecondaryAmmo"] = "E",
	["CHudSquadStatus"] = "E",
	["CHudTrain"] = "E",
	["CHudVehicle"] = "E",
	["CHudWeapon"] = "E",
	["CHudZoom"] = "E",
	["NetGraph"] = "E",
	["CHUDQuickInfo"] = "E",
	["CHudSuitPower"] = "E",
	["CHudGMod"] = "E",
}
hook.Add("HUDShouldDraw", "DRC_Camera", function(n)
	if !IsValid(LocalPlayer()) or !IsValid(LocalPlayer():GetActiveWeapon()) then return end
	if LocalPlayer():GetActiveWeapon():GetClass() != "drc_camera" then return end
	if HideHUDElements[n] then return false end
end)

local fogr, fogg, fogb = render.GetFogColor()
local fogcol = "".. fogr .." ".. fogg .." ".. fogb ..""
local fogstart, fogend = render.GetFogDistances()

RunConsoleCommand("r_fogcolour", fogcol)
RunConsoleCommand("r_fogstart", fogstart)
RunConsoleCommand("r_fogend", fogend)

--[[
hook.Add("Think", "drc_testhook", function()
	local ply = LocalPlayer()
	local size = DRC:RoomSize(ply)
	local dsp = DRC:GetRoomSizeDSP(size)
	local speakers, stereo, vol = GetConVar("snd_surround_speakers"):GetFloat(), 0, 1
	if speakers < 5 then
		stereo = 1
	else
		vol = 0.1
	end
	
	local muls = {
		
	}
	
	ply:ChatPrint(tostring(size))

	local cmds = {
--		["dsp_automatic"] = 38,
		["dsp_room"] = dsp,
		["dsp_db_mixdrop"] = 1,
		["dsp_mix_min"] = (size/200),
		["dsp_mix_max"] = size/100,
		["dsp_enhance_stereo"] = stereo,
		["dsp_volume"] = vol,
	}
	
	for k,v in pairs(cmds) do
		RunConsoleCommand(k, v)
	end
end)
--]]

hook.Add("PlayerTick", "DRC_SpeakingPoseParam", function(ply)
	ply:SetPoseParameter("drc_speaking", TimedSin(1, 0, 1, 0))
	if IsValid(ply.IsUsingVoice) then
		local vol = ply:VoiceVolume()
		local curpp = ply:GetPoseParameter("drc_speaking")
		
		ply:SetPoseParameter("drc_speaking", TimedSin(1, 0, 1, 0))
	end
end)

hook.Add("PlayerStartVoice", "DRC_SpeakingPoseParam_MarkTrue", function(ply) ply.IsUsingVoice = true end)
hook.Add("PlayerEndVoice", "DRC_SpeakingPoseParam_MarkFalse", function(ply) ply.IsUsingVoice = false end)