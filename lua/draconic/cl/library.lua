--- ###Library
--- ###Runtime
--- ###Thirdperson
--- ###SWEPs
--- ###Commands
--- ###Debug





-- ###Library
DRC.Menu = {}
DRC.CurrentRPModelOptions = {}
DRC.CurrentSpecialModelOptions = {}

if game.SinglePlayer() then
	if GetConVar("cl_drc_debug_alwaysshowshields") == nil then
		DRC.Convars_SV.ViewDrag = CreateConVar("cl_drc_debug_alwaysshowshields", 0, {FCVAR_ARCHIVE, FCVAR_DEMO}, "Always show shield effect (singleplayer only).", 0, 1)
	end
end

function DRC:PlayGesture(ply, slot, gesture, b)
	if ply:IsValid() && ply:IsPlayer() then 
		timer.Simple(engine.TickInterval(), function() 
			if IsValid(ply) then ply:AnimRestartGesture(slot, gesture, b) end
		end)
	end
end

function DRC:MakeShield(ent)
	if !IsValid(ent.ShieldEntity) then
		local shield = ents.CreateClientside("drc_shieldmodel")
		shield.FollowEnt = ent
		shield:Spawn()
	else return end
	
	timer.Simple(0.3, function()
		if !IsValid(ent.ShieldEntity) then
			local shield = ents.CreateClientside("drc_shieldmodel")
			shield.FollowEnt = ent
			shield:Spawn()
		end
	end)
end

net.Receive("DRC_MakeShieldEnt", function(l, ply)
	local ent = net.ReadEntity()
	
	DRC:MakeShield(ent)
end)

function DRC:GetCustomizationAllowed()
	local gamemode = tostring(engine.ActiveGamemode())
	local svtoggle = DRC.SV.drc_playerrep_disallow
	local svtweaktoggle = DRC.SV.drc_playerrep_tweakonly
		
	if !table.IsEmpty(DRC.CurrentRPModelOptions) then return true end
		
	if svtoggle == 1 then return false end
	if svtweaktoggle >= 1 then return nil, svtweaktoggle end
		
--[[	local allowedGMs = {
		["sandbox"] = "E",
	}
	local tweakGMs = {
		["darkrp"] = "E",
		["helix"] = "E",
		["cwrp"] = "E",
	}
	
	if allowedGMs[gamemode] then return true, svtweaktoggle end
	if tweakGMs[gamemode] then return nil, svtweaktoggle end
	if !allowedGMs[gamemode] && !tweakGMs[gamemode] then return true end ]]
	return true
end

function DRC:DistFromLocalPlayer(pos, sqr)
	if !pos or !IsValid(LocalPlayer()) then return nil end
	if IsEntity(pos) then pos = pos:GetPos() + pos:OBBCenter() end
	
	local ply = LocalPlayer()
	local plypos = ply:GetPos() + ply:OBBCenter()
	if !sqr then
		return pos:Distance(plypos)
	else
		return pos:DistToSqr(plypos)
	end
end

-- To scale something relative to 1920x1080 to make its size accurate on all resolutions.
function DRC:GetHUDScale()
	return ScrW()/1920, ScrH()/1080
end

function DRC:GetFOVScale()
	return 90/LocalPlayer():GetFOV()
end

function DRC:DrawCroppedRect(mat, pos, scale, uv, col)
	surface.SetMaterial(mat)
	surface.SetDrawColor(col)
	surface.DrawTexturedRectUV(pos.x, pos.y, scale.x, scale.y, uv[1], uv[2], uv[3], uv[4])
end

net.Receive("DRC_UpdatePlayerHands", function()
	if !IsValid(LocalPlayer()) then return end
	local ply = LocalPlayer()
	local handval = player_manager.TranslatePlayerModel(ply:GetInfo("cl_playerhands"))
	local pmname = player_manager.TranslateToPlayerModelName(handval)
	if ply:GetInfo("cl_playerhands") == "disabled" or ply:GetInfo("cl_playerhands") == "" then
		pmname = player_manager.TranslateToPlayerModelName(ply:GetModel())
	else
		local handstable = player_manager.TranslatePlayerHands(pmname)
		handstable.skin = ply:GetInfo("cl_playerhands_skin")
		handstable.bodygroups = ply:GetInfo("cl_playerhands_bodygroups")
		DRC:ChangeCHandModel(handstable)
	end
end)

net.Receive("DRC_UpdatePlayermodel", function()
	local tbl = net.ReadTable()
	
	local ent = tbl.player
	local skin = tbl.skin
	local bgs = tbl.bodygroups
	local colours = tbl.colours
	local model = tbl.model
	
	if !IsValid(ent) then return end
	ent:SetModel(model)
	ent:SetSkin(skin)
	for k,v in pairs(bgs) do
		ent:SetBodygroup(k-1, v)
	end
--	ent:SetBodyGroups(bgs)
	ent:SetPlayerColor(Vector(colours.Player.r/255, colours.Player.g/255, colours.Player.b/255))
	ent:SetWeaponColor(Vector(colours.Weapon.r/255, colours.Weapon.g/255, colours.Weapon.b/255))
	DRC:RefreshColours(ent)
end)

DRC.Cols = {}

--[[ hook.Add("PreDrawPlayerHands", "drc_FPShield", function(hands, vm, ply, wpn)
	if !IsValid(DRC.CSPlayerHandShield) then return end
	DRC.CSPlayerHandShield:SetAutomaticFrameAdvance(true)
	DRC.CSPlayerHandShield:SetModel(hands:GetModel())
	DRC.CSPlayerHandShield:SetAngles(hands:GetAngles())
	DRC.CSPlayerHandShield:SetPos(hands:GetPos())
--	DRC.CSPlayerHandShield:SetParent(hands)
	DRC.CSPlayerHandShield:SetMaterial("models/vuthakral/shield_example")
	
	for k,v in pairs(DRC:GetBones(hands)) do
		local id = hands:LookupBone(k)
		if id != nil then
			local matr = hands:GetBoneMatrix(id)
			if matr then
				local newmatr = Matrix()
				local shp, mshp, ent = DRC:GetShield(LocalPlayer())
				newmatr:SetTranslation(matr:GetTranslation())
				newmatr:SetAngles(matr:GetAngles())
				newmatr:SetScale(Vector(ent.ShieldScale, ent.ShieldScale, ent.ShieldScale))
				DRC.CSPlayerHandShield:SetBoneMatrix(id, newmatr)
			end
		end
	end
end) --]]

local CSModelCheck = 0
local CSShieldModelCheck = 0
local MBlurCheck = 0
hook.Add("Think", "drc_CSThinkStuff", function()
	if !IsValid(LocalPlayer()) then return end
	local ply = LocalPlayer()
	local etr = util.TraceLine({
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + ply:EyeAngles():Forward() * 10000,
		filter = function(ent) if ent != ply then return true end end
	})
	
	DRC.CalcView.Trace = etr
	DRC.CalcView.HitPos = etr.HitPos
	DRC.CalcView.ToScreen = DRC.CalcView.HitPos:ToScreen()
	if DRC.CalcView.LightColour then DRC.CalcView.LightColour:SetString(tostring(render.GetLightColor(ply:EyePos()))) end
	
	DRC.Cols = {
		["error"] = Color(TimedSin(1, 127, 255, 0), 0, 0, 255),
		["pulsewhite"] = Color(TimedSin(1, 127, 255, 0), TimedSin(1, 127, 255, 0), TimedSin(1, 127, 255, 0), 255),
		["gamer"] = Color(TimedSin(2.75, 127, 255, 0), TimedSin(1.83, 127, 255, 0), TimedSin(0.916, 127, 255, 0), 255),
	}
	
	if CurTime() > CSModelCheck then
		CSModelCheck = CurTime() + 5
		for k,v in pairs(ents.FindByClass("drc_csplayermodel")) do
			if v:GetClass() == "drc_csplayermodel" && v != DRC.CSPlayerModel then v:Remove() end
		end
	end
	
	-- It was either do this or network something every time an entity takes damage. So yeah...
	if CurTime() > CSShieldModelCheck then
	--	if !IsValid(DRC.CSPlayerHandShield) then
	--		local hands = ply:GetHands()
	--		DRC.CSPlayerHandShield = ents.CreateClientside("drc_shieldmodel")
	--	end
		CSShieldModelCheck = CurTime() + 5
		for k,v in pairs(ents.GetAll()) do
			local shp, smhp, sent = DRC:GetShield(v)
			if smhp != 0 && !IsValid(sent) then
				local shield = ents.CreateClientside("drc_shieldmodel")
				shield.FollowEnt = v
				shield:Spawn()
			end
		end
	end
	
	if CurTime() > MBlurCheck then -- https://github.com/Facepunch/garrysmod-requests/issues/2110
		MBlurCheck = MBlurCheck + 1
		if GetConVar("mat_motion_blur_enabled"):GetInt() < 1 then
			print("Disabling motion blur will break addons' effects. Setting mat_motion_blur_strength to 0 instead...")
			LocalPlayer():ConCommand("mat_motion_blur_enabled 1")
			LocalPlayer():ConCommand("mat_motion_blur_strength 0")
		end
	end
end)





-- ###Runtime
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

surface.CreateFont("DripIcons_Menu", {
	font 	= "dripicons-v2",
	size	= 16,
	weight	= 300,	
})
	
net.Receive("DRCNetworkedAddText", function(length, ply)
	local msg = net.ReadTable()
	chat.AddText(unpack(msg))
end)

net.Receive("DRCNetworkGesture", function(len, ply)
	local plyr = net.ReadEntity()
	local slot = net.ReadFloat()
	local act = net.ReadFloat()
	local akill = net.ReadBool()

	DRC:PlayGesture(plyr, slot, act, akill)
end)

net.Receive("DRCSound", function(len, ply)
--	local nt = net.ReadTable()
	local source = net.ReadEntity()
	local distance = net.ReadFloat()
	local sounds = {net.ReadString(), net.ReadString()}
	local ply = LocalPlayer()
	
	if GetConVar("cl_drc_debugmode"):GetFloat() > 0 then
		if GetConVar("cl_drc_debug_invertnearfar"):GetFloat() > 0 then
			near = sounds[1] or ""
			far = sounds[2] or ""
		else
			near = sounds[1] or ""
			far = sounds[2] or ""
		end
	else
		near = sounds[1] or ""
		far = sounds[2] or ""
	end
		
	if !IsValid(source) then return end
	local dist = math.Round((ply:GetPos() - source:GetPos()):Length(), 0)
	if dist > distance then
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
end)

net.Receive("DRC_SetSpecialModels", function(length, ply)
	local models = net.ReadTable()
	DRC.CurrentSpecialModelOptions = models
end)

net.Receive("DRC_ReflectionModifier", function(length, ply)
	DRC.ReflectionModifier = net.ReadFloat()
end)

net.Receive("DRC_WeaponAttachForceOpen", function(length, ply)
	DRC:ToggleAttachmentMenu(LocalPlayer():GetActiveWeapon(), true, true)
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

hook.Add("PlayerTick", "DRC_SpeakingPoseParam", function(ply)
	if game.SinglePlayer() then return end
	local vol = math.Clamp(ply:VoiceVolume(), 0.05, 1)
	if ply.DesiredVoiceVal != nil then
		ply.LerpedVoiceSmoother = Lerp(0.9, ply.LerpedVoiceSmoother or vol, vol)
		ply.LerpedVoiceVal = Lerp(1 * ply.LerpedVoiceSmoother, ply.LerpedVoiceVal or ply.DesiredVoiceVal, ply.DesiredVoiceVal)
	end
	if ply.IsUsingVoice == true then
		ply.DesiredVoiceVal = Lerp(0.5, ply.DesiredVoiceVal or vol * 3, vol * 3)
	else
		ply.DesiredVoiceVal = -0.05
	end
	if ply.LerpedVoiceVal then 
		if ply:LookupPoseParameter("drc_speaking") != -1 then ply:SetPoseParameter("drc_speaking", ply.LerpedVoiceVal) end
	end
end)

hook.Add("PlayerStartVoice", "DRC_SpeakingPoseParam_MarkTrue", function(ply) if game.SinglePlayer() then return end ply.IsUsingVoice = true end)
hook.Add("PlayerEndVoice", "DRC_SpeakingPoseParam_MarkFalse", function(ply) if game.SinglePlayer() then return end ply.IsUsingVoice = false end)





-- ###Thirdperson
DRC.ThirdPerson = {}
DRC.ThirdPerson.Offset = Vector()
DRC.ThirdPerson.DefaultOffsets = {
	[""] = Vector(45, -25, 0),
	["default"] = Vector(25, 0, 0),
	["pistol"] = Vector(45, -25, 0),
	["smg"] = Vector(45, -25, 0),
	["grenade"] = Vector(5, 0, 20),
	["ar2"] = Vector(45, -25, 0),
	["shotgun"] = Vector(55, -25, 0),
	["rpg"] = Vector(25, -15, 10),
	["physgun"] = Vector(25, -15, 0),
	["crossbow"] = Vector(45, -20, 0),
	["melee"] = Vector(55, -17.5, 0),
	["crowbar"] = Vector(55, -17.5, 0), -- HL:S Crowbar??????
	["melee2"] = Vector(55, -22.5, 0),
	["slam"] = Vector(55, -25, 0),
	["normal"] = Vector(35, 0, 10),
	["fist"] = Vector(45, -15, 5),
	["passive"] = Vector(35, 0, 10),
	["knife"] = Vector(45, -15, 0),
	["duel"] = Vector(35, 0, 15),
	["camera"] = Vector(50, 0, 15),
	["magic"] = Vector(45, 0, 15),
	["revolver"] = Vector(50, -25, 0),
}

function ThirdPersonModEnabled(ply)
	local veh, drctpcheck5 = ply:GetVehicle(), false
	if IsValid(veh) then
		drctpcheck5 = veh:GetThirdPersonMode()
	end
	
	drctpcheck1 = false
	drctpcheck2 = false
	drctpcheck3 = false
	drctpcheck4 = false

	if GetConVar("simple_thirdperson_enabled") != nil then
		if GetConVar("simple_thirdperson_enabled"):GetFloat() == 1 then drctpcheck1 = true else drctpcheck1 = false end
	end
	
	if ply:GetNW2Bool("ThirtOTS") == true then drctpcheck2 = true else drctpcheck2 = false end
	
	if GetConVar("thirdperson_etp") != nil then
		if GetConVar("thirdperson_etp"):GetString() == "1" then drctpcheck3 = true else drctpcheck3 = false end
	end
	
	if GetConVar("cl_view_ext_tps") != nil then
		if GetConVar("cl_view_ext_tps"):GetString() != "0" then drctpcheck4 = true else drctpcheck4 = false end
	end
	
	if drctpcheck1 == true or drctpcheck2 == true or drctpcheck3 == true or drctpcheck4 == true or drctpcheck5 == true then return true else return false end
end

function DRC:ThirdPersonEnabled(ply)
	if ThirdPersonModEnabled(ply) == true then return true end
	if ply:GetViewEntity() != ply then return true end
	if DRC:IsDraconicThirdPersonEnabled(ply) == true then return true end
	if pac then if pace.IsActive() == true then return true end end
	local curswep = ply:GetActiveWeapon()
	if curswep.ASTWTWO == true then return true end
	if ply:GetNWString("Draconic_ThirdpersonForce") == "On" then return true end
	if ply:GetNWString("Draconic_ThirdpersonForce") == "Off" then return false end
	if DRC.SV.drc_disable_thirdperson == 1 then return false end
	if GetConVar("cl_drc_thirdperson"):GetFloat() == 1 then return true else return false end
	return false
end

function DRC:ShouldDoDRCThirdPerson(ply)
	if !IsValid(ply) then return end
	if pac then if pace.IsActive() == true then return false end end
	local curswep = ply:GetActiveWeapon()
	if curswep.Draconic && curswep.Thirdperson == true then return true end
	if GetConVar("cl_drc_thirdperson"):GetFloat() == 1 then return true end
	return false
end

function DRC:IsDraconicThirdPersonEnabled(ply)
	if !IsValid(ply) then return end
	local curswep = ply:GetActiveWeapon()
	if !IsValid(curswep) then
		if DRC.SV.drc_disable_thirdperson == 1 then return false end
		if GetConVar("cl_drc_thirdperson"):GetFloat() == 1 then return true end
	else
		if curswep.Draconic == true && curswep.Thirdperson == true then return true end
		if DRC.SV.drc_disable_thirdperson == 1 then return false end
		if GetConVar("cl_drc_thirdperson"):GetFloat() == 1 then return true end
	end
	return false
end

net.Receive("DRC_NetworkScreenShake", function()
	local pos, amp, freq, dur, radi = net.ReadVector(), net.ReadFloat(), net.ReadFloat(), net.ReadFloat(), net.ReadFloat()
	
	
	for k,v in pairs(ents.FindInSphere(pos, radi)) do
		if v == LocalPlayer() then
			local dist = pos:Distance(LocalPlayer():GetPos() + LocalPlayer():OBBCenter())
			local frac = dist/radi
			local power = amp * (1-frac)/10
			v.CalcViewTPShakePower = math.Clamp(power, 0, 1)
			v.CalcViewTPShakeLastDur = dur
		end
	end
end)

local NegateTick = 0
hook.Add("Think", "DRC_CalcViewShakeNegation", function()
	if CurTime() < NegateTick then return end
	if !LocalPlayer().CalcViewTPShakePower then LocalPlayer().CalcViewTPShakePower = 0 end
	if !LocalPlayer().CalcViewTPShakeLastDur then LocalPlayer().CalcViewTPShakeLastDur = 0 end
	local durval = LocalPlayer().CalcViewTPShakeLastDur
	if durval >= 1 then durval = math.Clamp(LocalPlayer().CalcViewTPShakeLastDur/5, 0.01, 1) else durval = (1 - LocalPlayer().CalcViewTPShakeLastDur)/2.5 end
	NegateTick = CurTime() + 0.1
	LocalPlayer().CalcViewTPShakePower = math.Clamp(LocalPlayer().CalcViewTPShakePower - durval, 0.01, 1)
end)

function DRC:GetCalcViewShake()
	if !LocalPlayer().CalcViewTPShakePower then LocalPlayer().CalcViewTPShakePower = 0 end
	local shake = TimedSin(LocalPlayer().CalcViewTPShakePower * 50, 0, LocalPlayer().CalcViewTPShakePower * 15, 0) * LocalPlayer().CalcViewTPShakePower
	local shakevert = TimedSin(LocalPlayer().CalcViewTPShakePower * 25, 0, LocalPlayer().CalcViewTPShakePower * 40, 0) * LocalPlayer().CalcViewTPShakePower
	return shake, shakevert/10, shake/7.5
end

net.Receive("DRC_WeaponAttachSwitch_Sync", function()
	local wpn = net.ReadEntity()
	local req = net:ReadString()
	local slot = net:ReadString()
	
	wpn:SetupAttachments(req, slot, false, false)
	
	local snd = scripted_ents.GetStored(req).t.AttachSound
	if snd then surface.PlaySound(snd) else surface.PlaySound(DRC.Inspection.Theme.Sounds.Select) end
end)

net.Receive("DRC_WeaponAttachSyncInventory", function()
	LocalPlayer().DRCAttachmentInventory = net.ReadTable()
end)




-- ###SWEPs
hook.Add("PlayerBindPress", "DRC_ClientsideHotkeys", function(ply, bind, pressed, code)
	if !IsValid(ply) or !ply:Alive() then return end
	local wpn = ply:GetActiveWeapon()
	
	if bind == "+zoom" && wpn.Draconic && wpn:GetNWBool("Inspecting") == true then
		if wpn:CanCustomize() then DRC:ToggleAttachmentMenu(wpn, true, false) end
	return true end
end)

hook.Add("CalcView", "!DrcLerp", function(ply, origin, ang, fov, zn, zf)
	if !IsValid(ply) then return end
	if ThirdPersonModEnabled(ply) then return end
	if not !game.IsDedicated() then return end
	if DRC.SV.drc_viewdrag != 1 then return end
	if ply:GetViewEntity() ~= ply then return end
	if ply:InVehicle() then return end

	local wpn = ply:GetActiveWeapon()
	if !IsValid(wpn) then return end
	if wpn:GetClass() == "drc_camera" then return end
	if wpn.Draconic == nil then return end
	if wpn.IsMelee == true then return end
	local vm = ply:GetViewModel()
	local sights = wpn.SightsDown
	
	local attachment = vm:LookupAttachment("muzzle")
	local pos = Vector(0, drc_vmapos.y, drc_vmapos.z)
	local oang = drc_vmaangle
	
	if GetConVar("cl_drc_lowered_crosshair"):GetFloat() == 1 then
		DRC.CrosshairAngMod = Angle(-8, 0, 0)
	else
		DRC.CrosshairAngMod = Angle(0, 0, 0)
	end
	
	if sights == true or (ply:GetCanZoom() == true && ply:KeyDown(IN_ZOOM)) then
		drc_vm_sightpow = Lerp(FrameTime() * 25, drc_vm_sightpow or 1, 0)
	else
		drc_vm_sightpow = Lerp(FrameTime() * 25, drc_vm_sightpow or 0, 1)
	end
	
	if sights == true then
		drc_vm_sightpow_inv = Lerp(FrameTime() * 25, drc_vm_sightpow_inv or 0, 1)
	else
		drc_vm_sightpow_inv = Lerp(FrameTime() * 25, drc_vm_sightpow_inv or 1, 0)
	end
	
	drc_crosshair_pitchmod = Angle(wpn.Secondary.ScopePitch, 0, 0) * drc_vm_sightpow_inv
	
	if wpn.Loading == false && wpn.Inspecting == false then
		drc_vm_lerpang = Angle(oang.x, oang.y, Lerp(FrameTime() * drc_vm_angmedian, drc_vm_lerpang.z or 0, 0))
	else
		drc_vm_lerpang = LerpAngle(FrameTime(), oang or Angle(0, 0, 0), oang)
	end
	
	drc_vm_lerppos = Vector(Lerp(FrameTime() * 25, 0 or pos.x, 0), Lerp(FrameTime() * 25, 0 or pos.y, 0), Lerp(FrameTime() * 25, 0 or pos.z, 0))
	if wpn:GetNWBool("Loading") == true then
		drc_vm_lerpdivval = Lerp(FrameTime() * 5, drc_vm_lerpdivval or 30, 30)
	elseif wpn:GetNWBool("InspectCamLerp") == true then
		drc_vm_lerpdivval = Lerp(FrameTime() * 5, drc_vm_lerpdivval or 16, 16)
	else
		drc_vm_lerpdivval = Lerp(FrameTime() * 5, drc_vm_lerpdivval or 50, 50)
	end
	
	if wpn.SightsDown == true or (wpn.Loading == false && wpn.Inspecting == false && wpn.Idle == 1) then
		local fr = math.Round(1 / FrameTime())
		
		if fr > 15 then
			if ply:KeyDown(IN_SPEED) or wpn.SightsDown == true then
				drc_vm_lerpang_final = Angle(0, 0, 0)
			else
				drc_vm_lerpang_final = LerpAngle(FrameTime() * drc_vm_angmedian, drc_vm_lerpang_final or Angle(0, 0, 0), drc_vm_lerpang)
			end
		else
			drc_vm_lerpang_final = Angle(0, 0, 0)
		end
	else
		drc_vm_lerpang_final = LerpAngle(FrameTime() * drc_vm_angmedian, drc_vm_lerpang_final or drc_vm_lerpang, drc_vm_lerpang)
	end
	
	drc_vm_lerpdiv = Lerp(FrameTime() * 5, drc_vm_lerpdivval or drc_vm_lerpdiv, drc_vm_lerpdivval)
	
	if wpn.IsMelee == false && !attachment then return end

	if ply:GetNW2Int("TFALean", 1337) != 1337 then
	local tfaleanang = LeanCalcView(ply, origin, ang, fov)
		for k, v in pairs(tfaleanang) do
			if k == "origin" then 
				drc_calcview_tfapos = v
			elseif k == "angles" then
				drc_calcview_tfaang = v
			end
		end
	else
		drc_calcview_tfapos = ply:EyePos()
		drc_calcview_tfaang = ply:EyeAngles()
	end
	
	if ply:GetNW2Int("TFALean", 1337) != 1337 then
		DRC.CalcView.Pos = drc_vm_lerppos / drc_vm_lerpdiv - ( origin - drc_calcview_tfapos)
		DRC.CalcView.Ang = drc_vm_lerpang_final / drc_vm_lerpdiv - ( ang - drc_calcview_tfaang) + DRC.CrosshairAngMod * drc_vm_sightpow
	--	if GetConVar("cl_drc_sway"):GetFloat() != 1 then DRC.CalcView.Ang = Angle() end
		local view = {
			origin = origin - drc_vm_lerppos / drc_vm_lerpdiv - ( origin - drc_calcview_tfapos),
			angles = ang - DRC.CalcView.Ang,
			fov = fov
		}
		return view
	else
		DRC.CalcView.Pos = drc_vm_lerppos / drc_vm_lerpdiv
		DRC.CalcView.Ang = drc_crosshair_pitchmod - drc_vm_lerpang_final / drc_vm_lerpdiv + DRC.CrosshairAngMod * drc_vm_sightpow
	--	if GetConVar("cl_drc_sway"):GetFloat() != 1 then DRC.CalcView.Ang = Angle() end
		local view = {
			origin = origin - drc_vm_lerppos / drc_vm_lerpdiv,	
			angles = ang + DRC.CalcView.Ang,
			fov = fov
		}
		return view
	end
end)


function DRCSwepSway(wpn, vm, ogpos, ogang, pos, ang)
	if wpn.Draconic then
		local ply = wpn:GetOwner()
		if IsValid(ply) then
			if ply:Alive() then
				local calcpos, calcang = wpn:GetViewModelPosition(ogpos, ogang)
				local newpos, newang = calcpos, calcang
				if calcpos && calcang && newpos && newang then
					local velinput = math.Clamp(ply:GetVelocity():Length()/100, 0, 3)
					local wl = ply:WaterLevel()
					local sd = wpn.SightsDown
					local sightkill = 0
					if sd == true then sightkill = 0 else sightkill = 1 end
					if !wpn.dang then wpn.dang = Angle() end
					if !wpn.oang then wpn.oang = Angle() end
					if !wpn.LLTime then wpn.LLTime = 0 end
					
					local rollmul = 1
					if ply:KeyDown(IN_SPEED) then
						rollmul = 2.65
					elseif ply:KeyDown(IN_WALK) then
						rollmul = 0.45
					elseif ply:Crouching() then
						rollmul = 0.75
					else
						rollmul = 1
					end
					
					rollmul = (rollmul * wpn.VelInterp) * wpn.RollingPower
					
					local rollval, xval, yval
					if ply:KeyDown(IN_MOVELEFT) then
						rollval = -3.35 * rollmul
						xval = -1
					elseif ply:KeyDown(IN_MOVERIGHT) then
						rollval = 3.35 * rollmul
						xval = 1
					else
						rollval = 0
						xval = 0
					end
					
					if ply:KeyDown(IN_FORWARD) then
						yval = 1
					elseif ply:KeyDown(IN_BACK) then
						yval = -1
					else
						yval = 0
					end
					
					if vm:SelectWeightedSequence(ACT_RUN) == -1 then
						if ply:KeyDown(IN_SPEED) then
							rollval = rollval/2
						end
					end
					
					rollval_lerp = Lerp(0.06, rollval_lerp or rollval, rollval)
					drc_xval_lerp = Lerp(0.1, drc_xval_lerp or xval, xval)
					drc_yval_lerp = Lerp(0.1, drc_yval_lerp or yval, yval)
					rollval_lerp = rollval_lerp * sightkill
					local vel = math.Clamp(ply:GetVelocity():LengthSqr()*0.00005, 0, 4)
					drc_vel_lerp = Lerp(0.1, drc_vel_lerp or vel, vel)
					
					if wpn.ShouldWalkBlend == false then
						drc_xval_lerp = Lerp(0.5, drc_xval_lerp or 0, 0)
						drc_yval_lerp = Lerp(0.5, drc_yval_lerp or 0, 0)
						drc_vel_lerp = Lerp(0.5, drc_vel_lerp or 0, 0)
					end
					local velmul
					if ply:Crouching() then velmul = 3 else velmul = 0.5 end
					
					vm:SetPoseParameter("drc_movement", drc_vel_lerp*velmul)
					vm:SetPoseParameter("drc_move_x", drc_xval_lerp)
					vm:SetPoseParameter("drc_move_y", drc_yval_lerp)
					
					local holdang = LocalPlayer():EyeAngles()
					wpn.dang = LerpAngle((wpn.SS/15), wpn.dang, holdang - wpn.oang)
					if RealTime() > wpn.LLTime + (RealFrameTime() * 0.001) then
						wpn.LLTime = RealTime()
						wpn.oang = LocalPlayer():EyeAngles()
						wpn.dang = wpn.dang * sightkill
					end
					
					if sd then wpn.dang = wpn.dang * 0.85 end
				--	if GetConVar("cl_drc_sway"):GetInt() < 1 then wpn.dang = Angle(0, 0, 0) end
					
					local dynang = Angle(wpn.dang.x * -wpn.SS/1.25, wpn.dang.y * wpn.SS/2, wpn.dang.z + rollval_lerp)*2
					
					newang:RotateAroundAxis(ang:Right(), dynang.x)
					newang:RotateAroundAxis(ang:Up(), dynang.y)
					newang:RotateAroundAxis(ang:Forward(), dynang.z)
					newpos:Add(ang:Right() * dynang.y*wpn.SS/6)
				--	newpos:Add(ang:Forward() * dynang.y)
					newpos:Add(ang:Up() * -dynang.x*wpn.SS/6)
					
					wpn.dynmove = {["Ang"] = dynang, ["Pos"] = newpos, ["Roll"] = rollval_lerp}
				end
			end
		end
	end
end

hook.Add("CalcViewModelView", "DRC_SWEP_Effects", function(wpn, vm, ogpos, ogang, pos, ang)
	DRCSwepSway(wpn, vm, ogpos, ogang, pos, ang)
				
		--[[		if LocalPlayer():GetInfoNum("cl_drc_testvar_0", 0) == 1 then
					local function Ease(fr, f, t)
						return Lerp(math.ease.InOutQuad(fr), f, t)
					end
					local function EaseVector(fr, f, t)
						return Vector(Lerp(math.ease.InOutQuad(fr), f.x, t.x), Lerp(math.ease.InOutQuad(fr), f.y, t.y), Lerp(math.ease.InOutQuad(fr), f.z, t.z))
						end
					
					if !wpn.BobInfo then wpn.BobInfo = {} end
					local vel = wpn.BobInfo["velocity_input"]
					local vel_vert = wpn.BobInfo["velocity_input_z"]
					local sway = wpn.BobInfo["Sway"]
					local bob = wpn.BobInfo["Bob"]
					local step = wpn.BobInfo["Step"]
					local jump = wpn.BobInfo["Air"]
					local jump_ang = wpn.BobInfo["Air_ang"]
					local jump_val = wpn.BobInfo["Air_val"]
					local swim = wpn.BobInfo["Submerge"]
					local swim_ang = wpn.BobInfo["Submerge_ang"]
					
					if wl > 2 then end
					
					vel = Ease(0.25, vel or velinput, velinput)
					vel_vert = -Ease(0.25, vel_vert or math.Clamp(ply:GetVelocity().z/500, -1, 1), math.Clamp(ply:GetVelocity().z/500, -1, 1))
					sway = Vector(TimedSin(1, 0, wpn.SS, 0), TimedSin(1, 0, wpn.SS, 0), TimedSin(1, 0, wpn.SS, wpn.SS/1.5))
					bob = Vector(TimedSin(1, 0, wpn.BS/4*vel, 0), TimedSin(1, 0, wpn.BS, 0), TimedSin(1, 0, -wpn.BS/4, -wpn.BS/1.5))
					step = TimedSin(2.5, 0, wpn.BS/8 * vel, 0)
					
					jump = Vector(TimedSin(1, 0, wpn.BS, 0), TimedSin(1, wpn.BS, wpn.BS, 0), TimedSin(1, wpn.BS/4, -wpn.BS/4, -wpn.BS/1.5)) * vel_vert
					jump_ang = Vector(TimedSin(1, 0, -wpn.SS, 0), TimedSin(1, wpn.SS, wpn.SS, 0), TimedSin(1, -5, wpn.SS*2*vel, wpn.SS/1.5)) * vel_vert
					
					newang:RotateAroundAxis(ang:Right(), jump_ang.x)
					newang:RotateAroundAxis(ang:Up(), jump_ang.y)
					newang:RotateAroundAxis(ang:Forward(), jump_ang.z)
					newpos:Add(ang:Right() * jump.x)
					newpos:Add(ang:Forward() * jump.y)
					newpos:Add(ang:Up() * jump.z)
					
					bob.z = bob.z + step
					sway.x = sway.x + step
					sway, bob = sway*vel, bob*vel
					if wpn.IsMelee == false then
						local spread = (wpn.Primary.Spread / wpn.Primary.SpreadDiv) * 10
						local kick = wpn.Primary.Kick * spread
						local rpm = wpn.Primary.RPM/100
						
						
						if wpn.Primary.RPM > 101 then
							if !wpn.KickVal then wpn.KickVal = 0 end
							if !wpn.KickVal_Lerp then wpn.KickVal_Lerp = 0 end
							if !wpn.PushVal then wpn.PushVal = 0 end
							
							wpn.KickVal = Ease(wpn.BloomValue, 0, 1)
							wpn.KickVal_Lerp = math.Clamp(Lerp(math.Clamp(0.8 + (kick/10), 0.75, 0.9), wpn.KickVal*(3*kick*2) or wpn.KickVal_Lerp, wpn.KickVal_Lerp), 0, 2)
							wpn.PushVal = Ease(math.Clamp(0.8 + (kick/10), 0.75, 0.9), -wpn.KickVal_Lerp or wpn.PushVal, wpn.PushVal)
							
							wpn.KickAngles = Angle(TimedSin(2-kick + (rpm/10), 0, wpn.KickVal_Lerp/4*(1+(wpn.KickVal_Lerp/4*5)), 0), TimedSin(2-kick + (rpm/10), 0, wpn.KickVal_Lerp/4*(1+(wpn.KickVal_Lerp/4*5)), TimedSin(1-kick + (rpm/10), 0, 2+wpn.KickVal_Lerp/4, 0)), 0)
							wpn.KickAngles = (wpn.KickAngles * wpn.KickVal_Lerp/2) * spread
							wpn.KickAngles = Angle(math.Clamp(wpn.KickAngles.x, -10, 10), math.Clamp(wpn.KickAngles.y, -10, 10), math.Clamp(wpn.KickAngles.z, -10, 10))
							newang = newang + wpn.KickAngles
						--	ply:ChatPrint(tostring((math.abs(1-math.abs(vel_vert)))))
						--	ply:ChatPrint(tostring(1-math.abs(vel_vert)))
							newpos:Sub((ang:Forward() * wpn.PushVal) * wpn.PushVal)				
						end
					end
					sway = sway * (1-math.abs(vel_vert))
					bob = bob * (1-math.abs(vel_vert))
						
					bob.x = -bob.x * vel_vert*2
					bob.y = bob.y * vel_vert*2
					
					newang:RotateAroundAxis(ang:Right(), sway.x)
					newang:RotateAroundAxis(ang:Up(), sway.y)
					newang:RotateAroundAxis(ang:Forward(), sway.z)
					newpos:Add(ang:Right() * bob.x)
					newpos:Add(ang:Up() * bob.z)
				end --]]
		--	return newpos, newang

end)





-- ###Commands
concommand.Add("draconic_menu", function()
	DRCMenu(LocalPlayer())
end)

concommand.Add("draconic_thirdperson_toggle", function()
	DRC.CalcView.ThirdPerson.Ang = LocalPlayer():EyeAngles()
	DRC.CalcView.ThirdPerson.Ang_Stored = LocalPlayer():EyeAngles()
	DRC.CalcView.ThirdPerson.DirectionalAng = LocalPlayer():EyeAngles()
	DRC:ThirdPerson_PokeLiveAngle(LocalPlayer())
	
	if GetConVar("cl_drc_thirdperson"):GetFloat() == 0 then
		RunConsoleCommand("cl_drc_thirdperson", 1)
	else
		RunConsoleCommand("cl_drc_thirdperson", 0)
	end
end)

concommand.Add("draconic_thirdperson_swapshoulder", function()
	if GetConVar("cl_drc_thirdperson_flipside"):GetFloat() == 0 then
		RunConsoleCommand("cl_drc_thirdperson_flipside", 1)
	else
		RunConsoleCommand("cl_drc_thirdperson_flipside", 0)
	end
end)

concommand.Add("draconic_firstperson_toggle", function()
	if GetConVar("cl_drc_experimental_fp"):GetFloat() == 0 then
		RunConsoleCommand("cl_drc_experimental_fp", 1)
	else
		RunConsoleCommand("cl_drc_experimental_fp", 0)
	end
end)

concommand.Add("draconic_voicesets_menu_toggle", function()
	DRC:VoiceMenuToggle()
end)

concommand.Add("drc_refreshcsents", function()
	if IsValid(DRC.CSPlayerModel) then DRC.CSPlayerModel:Remove() end
	if IsValid(DRC.CSShadowModel) then DRC.CSShadowModel:Remove() end
	if IsValid(DRC.CSWeaponShadow) then DRC.CSWeaponShadow:Remove() end
	if IsValid(DRC.CSPlayerHandShield) then DRC.CSPlayerHandShield:Remove() end
	if IsValid(DRC.CalcView.MuzzleLamp) then DRC.CalcView.MuzzleLamp:Remove() end
	if DRC.AttachMenu && DRC.AttachMenu.mpanel then DRC.AttachMenu.mpanel:Remove() end
	
	for k,v in pairs(ents.GetAll()) do
		if v.DRCReflectionTints then v.DRCReflectionTints = nil end
	end
end)





-- ###Debug
DRC.Debug = {}

local drc_frame = 0
local drc_framesavg = 0
local function drc_DebugUI()
	if !LocalPlayer():Alive() then return end
	if DRC.SV.drc_allowdebug == 0 then return end
	if GetConVar("cl_drawhud"):GetFloat() == 0 then return end
	if GetConVar("cl_drc_debugmode"):GetFloat() == 0 then return end
	if CurTime() > drc_frame then
		drc_frame = CurTime() + engine.TickInterval() * 30
		drc_framesavg = math.Round(1/RealFrameTime())
	end

	local hp, maxhp, ent = DRC:GetShield(LocalPlayer())
	
	local tps = 694201337
	if game.SinglePlayer() then
		tps = math.Clamp(math.Round(1/FrameTime()), 0, 1/engine.TickInterval())
	else
		tps = math.Round(1/FrameTime())
	end
	
	tps = math.floor(tps)
	
	drcshieldinterp = Lerp(RealFrameTime() * 25, drcshieldinterp or hp, hp)
	draw.DrawText( "Shield: ".. tostring(math.Round(drcshieldinterp)) .."/".. maxhp .."", "TargetID", ScrW() * 0.02, ScrH() * 0.875, color_white, TEXT_ALIGN_LEFT )
	draw.DrawText( "FPS: ".. drc_framesavg .." | ".. math.Round(1/RealFrameTime()) .."", "TargetID", ScrW() * 0.02, ScrH() * 0.855, color_white, TEXT_ALIGN_LEFT )
	draw.DrawText( "TPS: ".. tps .." | ".. math.floor(1/engine.TickInterval()) .."", "TargetID", ScrW() * 0.02, ScrH() * 0.835, color_white, TEXT_ALIGN_LEFT )

	if IsValid(LocalPlayer():GetActiveWeapon()) then
		local curswep = LocalPlayer():GetActiveWeapon()
		
		local ammo, maxammo = curswep:Clip1(), curswep:GetMaxClip1()
		
		if curswep.Draconic == true then
			draw.DrawText( "".. ammo .."(".. math.Round(curswep:GetNWInt("LoadedAmmo"), 4) ..")/".. maxammo .." | Ammo", "TargetID", ScrW() * 0.975, ScrH() * 0.855, color_white, TEXT_ALIGN_RIGHT )
			draw.DrawText( "".. math.Round(curswep:GetHeat(), 4) .."% | Heat", "TargetID", ScrW() * 0.975, ScrH() * 0.855+24, color_white, TEXT_ALIGN_RIGHT )
			draw.DrawText( "".. curswep.Category .." - ".. curswep:GetPrintName() .."", "TargetID", ScrW() * 0.975, ScrH() * 0.855-24, color_white, TEXT_ALIGN_RIGHT )
			draw.DrawText( "".. curswep.OwnerActivity .."", "TargetID", ScrW() * 0.5, ScrH() * 0.8 + 24, color_white, TEXT_ALIGN_CENTER )
			
			local col1 = Color(255, 255, 255, 175)
			local col2 = Color(255, 255, 255, 75)
			local posx, posy = ScrW() * 0.94, ScrH() * 0.73
			surface.SetDrawColor( col1 )
			
			surface.DrawCircle(posx, posy, 100, col1.r, col1.g, col1.b, col1.a)
			surface.DrawRect(posx, posy, 2, 2)
			draw.DrawText("Camera Drag Interpreter", "HudSelectionText", ScrW() * 0.975, ScrH() * 0.6, Color(236, 236, 236, 175), TEXT_ALIGN_RIGHT)
			draw.DrawText(drc_vm_lerpang_final, "HudSelectionText", ScrW() * 0.975, ScrH() * 0.615, Color(236, 236, 236, 175), TEXT_ALIGN_RIGHT)
			
			surface.SetDrawColor( col2 )
			surface.DrawLine(posx, posy, posx + (drc_vm_lerpang_final.y), posy - (drc_vm_lerpang_final.x))
			surface.SetDrawColor( col1 )
			surface.DrawRect(posx - 2 + (drc_vm_lerpang_final.y), posy - 2 - (drc_vm_lerpang_final.x), 5, 5)
		--	draw.DrawText( "".. math.Round(curswep.IdleTimer, 4) .." |", "TargetID", ScrW() * 0.5 -50, ScrH() * 0.8 + 25, color_white, TEXT_ALIGN_CENTER )
		--	draw.DrawText( "".. math.Round(CurTime(), 4) .."", "TargetID", ScrW() * 0.5 +20, ScrH() * 0.8 + 25, color_white, TEXT_ALIGN_LEFT )
		else
			draw.DrawText( "".. ammo .."/".. maxammo .."", "TargetID", ScrW() * 0.975, ScrH() * 0.875, color_white, TEXT_ALIGN_RIGHT )
			draw.DrawText( curswep:GetPrintName(), "TargetID", ScrW() * 0.975, ScrH() * 0.855, color_white, TEXT_ALIGN_RIGHT )
		end
	end
	
	local label = DRC:GetPower()
	if label != "Desktop" then label = "Mobile: ".. DRC:GetPower() .."%" end
	
	draw.DrawText( "Draconic Base ".. Draconic.Version .."", "TargetID", ScrW() * 0.5, ScrH() * 0.92, color_white, TEXT_ALIGN_CENTER )
	draw.DrawText( "".. LocalPlayer():Name() .." (".. LocalPlayer():SteamID64() ..")", "TargetID", ScrW() * 0.5, ScrH() * 0.94, color_white, TEXT_ALIGN_CENTER )
	draw.DrawText( "".. DRC:GetOS() .." (".. DRC:GetPower() ..") - ".. os.date() .."", "TargetID", ScrW() * 0.5, ScrH() * 0.96, color_white, TEXT_ALIGN_CENTER )
	if game.SinglePlayer() then
		draw.DrawText( "".. DRC:GetServerMode() .." - ".. engine.ActiveGamemode() .."", "TargetID", ScrW() * 0.5, ScrH() * 0.98, color_white, TEXT_ALIGN_CENTER )
	else
		draw.DrawText( "".. DRC:GetServerMode() .." - ".. GetHostName() .." - ".. engine.ActiveGamemode() .."", "TargetID", ScrW() * 0.5, ScrH() * 0.98, color_white, TEXT_ALIGN_CENTER )
	end
	
	local lifetime = CurTime()
	local days = math.floor(lifetime/86400)
	local hours = math.floor(math.fmod(lifetime, 86400)/3600)
	local minutes = math.floor(math.fmod(lifetime,3600)/60)
	local seconds = math.floor(math.fmod(lifetime,60))
	local timestr = "".. days .." days, ".. hours .." hours, ".. minutes .." minutes, and ".. seconds .." seconds"
	draw.DrawText( "Uptime: ".. timestr .."", "TargetID", 32, 32, color_white, TEXT_ALIGN_LEFT )
	
	local eyepos = LocalPlayer():EyePos()
	local roomsize = DRC:RoomSize(LocalPlayer())
	local roomname = DRC:GetRoomSizeName(roomsize)
	local ll = render.GetLightColor(eyepos)
	local llhp = render.GetLightColor(LocalPlayer():GetEyeTrace().HitPos)
	
	draw.DrawText( "Thirdperson detection: ".. tostring(DRC:ThirdPersonEnabled(LocalPlayer())) .."", "TargetID", 32, 56, color_white, TEXT_ALIGN_LEFT )
	draw.DrawText( "Room size: ".. roomname .."", "TargetID", 32, 78, color_white, TEXT_ALIGN_LEFT )
	draw.DrawText( "Weather mod: ", "TargetID", 32, 102, color_white, TEXT_ALIGN_LEFT )
	draw.RoundedBox(0, 180, 102, 24, 24, Color(DRC.WeathermodScalar.x * 255, DRC.WeathermodScalar.y * 255, DRC.WeathermodScalar.z * 255))
	draw.DrawText( "Light level: ", "TargetID", 32, 126, color_white, TEXT_ALIGN_LEFT )
	draw.RoundedBox(0, 147, 126, 24, 24, Color(ll.r * 255, ll.g * 255, ll.b * 255))
	draw.DrawText( "LL Hitpos: ", "TargetID", 32, 150, color_white, TEXT_ALIGN_LEFT )
	draw.RoundedBox(0, 147, 150, 24, 24, Color(llhp.r * 255, llhp.g * 255, llhp.b * 255))
	
	draw.DrawText( "".. game.GetMap() .." @ Vector(".. tostring(LocalPlayer():GetPos()) ..")", "TargetID", ScrW() * 0.02, ScrH() * 0.978, color_white, TEXT_ALIGN_LEFT )
	
	local vm = LocalPlayer():GetViewModel()
	if !IsValid(vm) then return end
	
	local seq = vm:GetSequence()
	local act = vm:GetSequenceActivityName(seq)
	local cycle = vm:GetCycle()
	
	draw.DrawText( "".. act .." | ".. math.Round(cycle * 100) .."%", "TargetID", ScrW() * 0.5, ScrH() * 0.8, color_white, TEXT_ALIGN_CENTER )
end
hook.Add("HUDPaint", "drc_DebugUI", drc_DebugUI)

local function drc_TraceInfo()
	if DRC.SV.drc_allowdebug == 0 then return end
	if GetConVar("cl_drawhud"):GetFloat() == 0 then return end
	if GetConVar("cl_drc_debugmode"):GetFloat() == 0 then return end
	local pos = DRC.CalcView.ToScreen
	local data = DRC.CalcView.Trace
	local ent = data.Entity
--	if !IsValid(ent) then return end
	local hp = 0
--	if !ent:IsWorld() then hp = ent:Health() end
	
	local col = Color(255, 255, 255)
	
	surface.SetFont("DermaDefault")
	surface.SetTextColor(col)
	surface.SetTextPos(pos.x - pos.x/2, pos.y)
	surface.DrawText(tostring(ent))
	
	if hp && IsValid(ent) then 
		local base = DRC:GetBaseName(ent)
		local hp, maxhp = DRC:Health(ent)
		if hp == nil then hp = 0 end
		if maxhp == nil then maxhp = 0 end
		
		surface.SetTextPos(pos.x - pos.x/2, pos.y + 32)
		surface.SetTextColor(0, 255, 100)
		surface.DrawText(tostring("".. hp .." / ".. maxhp ..""))
		
		local shp, smhp, sent = DRC:GetShield(ent)
		if IsValid(sent) then
			surface.SetTextPos(pos.x - pos.x/2.6, pos.y + 32)
			surface.SetTextColor(0, 200, 255)
			surface.DrawText(tostring("".. math.Round(shp) .." / ".. smhp ..""))
		end
	end
	
	local BaseProfile = scripted_ents.GetStored("drc_abp_generic")
	local BaseBT = BaseProfile.t.BulletTable
	local BaseDT = BaseBT.MaterialDamageMuls
	local enum = nil
	
	if ent:IsWorld() then
		enum = LocalPlayer():GetEyeTrace().SurfaceProps
		if enum != -1 then enum = tostring("MAT_".. string.upper(tostring(util.GetSurfaceData(enum)["name"])) .."") end
	else
		if !IsValid(ent) then return end
		enum = DRC:SurfacePropToEnum(ent:GetBoneSurfaceProp(0))
	end
	local e2
	if enum && DRC.SurfacePropDefinitions[enum] then e2 = DRC.SurfacePropDefinitions[enum][1] or "UNDEFINED, PLEASE REPORT" else e2 = "UNDEFINED, PLEASE REPORT" end
	if enum == "MAT_DEFAULT_SILENT" then e2 = "Invalid" end
	if enum == "MAT_" or enum == -1 then enum = "Unreadable" e2 = "Invalid" end
	enum = "".. enum .." | DRC: ''".. e2 .."''" 
	
	if BaseDT[enum] && enum != "MAT_" == nil then
		col = Color(255, 0, 0)
	end
	surface.SetTextColor(col)
	surface.SetTextPos(pos.x - pos.x/2, pos.y + 16)
	if enum != "MAT_" then surface.DrawText(tostring(enum)) end
	
--	if ent:IsWorld() then return end
	surface.SetFont("DermaDefault")
	surface.SetTextColor(255, 255, 255)
	surface.SetTextPos(pos.x - pos.x/2, pos.y + 48)
	surface.DrawText(tostring(ent:GetPos()) or "")
	
	surface.SetTextPos(pos.x - pos.x/2, pos.y + 64)
	local str2
	if ent:IsWorld() then str2 = data.HitTexture else str2 = tostring(ent:GetModel()) end
	surface.DrawText(str2)
	
	surface.SetTextPos(pos.x - pos.x/2, pos.y + 80)
	surface.DrawText("Owner: ".. tostring(ent:GetOwner()) .."" or "")
end
hook.Add("HUDPaint", "drc_TraceInfo", drc_TraceInfo)

DRC.Debug.TraceLines = {}
DRC.Debug.Lights = {}
DRC.Debug.Sounds = {}

hook.Add("PostDrawTranslucentRenderables", "drc_DebugMenuPM", function()
	local tgtent = DRC.PlayermodelMenuEnt
	
end)

hook.Add("PostDrawTranslucentRenderables", "drc_DebugStuff", function()
	if DRC.SV.drc_allowdebug == 0 then return end
	if GetConVar("cl_drc_debugmode"):GetFloat() == 0 then return end
	
	if GetConVar("cl_drc_debug_tracelines"):GetFloat() != 0 then
		for k,v in pairs(DRC.Debug.TraceLines) do
			if v != nil then
				local p1, p2, col = v[1], v[2], v[3]
				render.DrawLine(p1, p2, col, true)
			end
		end
	end
	
	if GetConVar("cl_drc_debug_lights"):GetFloat() != 0 then
		for k,v in pairs(DRC.Debug.Lights) do
			if v != nil then
				local pos, col, size, colmul = v[1], v[2], v[3], v[4]
				col = Color(col.r * colmul, col.g * colmul, col.b * colmul, 255)
				cam.Start3D()
					render.SetMaterial(Material("icon64/light.png"))
					render.DrawSprite(pos, 16, 16, col)
				cam.End3D()
				render.SetColorMaterial()
				render.DrawWireframeSphere( pos, size, 16, 16, Color( col.r, col.g, col.b ), true )
			end
		end
	end
	
	if GetConVar("cl_drc_debug_sounds"):GetFloat() != 0 then
		for k,v in pairs(DRC.Debug.Sounds) do
			if v != nil then
				local pos = v[1]
				if pos then
				local col = Color(160, 160, 160, 255)
				cam.Start3D()
					render.SetMaterial(Material("icon64/ambient_generic.png"))
					render.DrawSprite(pos, 16, 16, col)
				cam.End3D()
				end
			end
		end
	end
	
	if GetConVar("cl_drc_debug_cubemaps"):GetFloat() != 0 then
		for k,v in pairs(drc_cubesamples) do
			if v != nil then
				local pos = v
				local col = Color(160, 160, 160, 255)
				cam.Start3D()
					render.SetMaterial(Material("icon64/env_cubemap.png"))
					render.DrawSprite(pos, 16, 16, col)
				cam.End3D()
			--	render.SetColorMaterial()
			--	render.DrawWireframeSphere( pos, size, 16, 16, Color( col.r, col.g, col.b ), true )
			end
		end
	end
	
	if GetConVar("cl_drc_debug_hitboxes"):GetFloat() == 1 then
		local ply = LocalPlayer()
		local tgtent = DRC.CalcView.Trace.Entity
		local HitboxColours = {
			DRC.Cols.pulsewhite,
			Color(255, 0, 0, 255),
			Color(0, 255, 0, 255),
			Color(170, 170, 75, 255),
			Color(0, 0, 255, 255),
			Color(255, 100, 255, 255),
			Color(90, 175, 255, 255),
			Color(255, 255, 255, 255)
		}
		
		local function DoTheFunny(pos,ang, mins, maxs, col)
			render.SetColorMaterial()
			render.DrawWireframeBox( pos, ang, mins, maxs, col, true)
			render.DrawBox( pos, ang, mins, maxs, Color(col.r, col.g, col.b, 5), true)
		end
		
		if DRC:ThirdPersonEnabled(ply) then
		for hitgroup=0, ply:GetHitboxSetCount() - 1 do
			 for box=0, ply:GetHitBoxCount(hitgroup) - 1 do
				local pos, ang =  ply:GetBonePosition( ply:GetHitBoxBone(box, hitgroup) )
				local mins, maxs = ply:GetHitBoxBounds(box, hitgroup)
				local enum = ply:GetHitBoxHitGroup(box, hitgroup) + 1
				local col = HitboxColours[enum]
				if !col then col = Color(255, 255, 255, 255) end
				DoTheFunny( pos, ang, mins, maxs, col)
			end
		end
		end
		
		if !IsValid(tgtent) then return end
		if tgtent:GetHitboxSetCount() == nil then return end
		for hitgroup=0, tgtent:GetHitboxSetCount() - 1 do
			 for box=0, tgtent:GetHitBoxCount( hitgroup ) - 1 do
				local pos, ang =  tgtent:GetBonePosition( tgtent:GetHitBoxBone(box, hitgroup) )
				local mins, maxs = tgtent:GetHitBoxBounds(box, hitgroup)
				local enum = tgtent:GetHitBoxHitGroup(box, hitgroup) + 1
				local col = HitboxColours[enum]
				if !col then col = Color(255, 255, 255, 255) end
				DoTheFunny( pos, ang, mins, maxs, col)
			end
		end
	end
	
	if GetConVar("cl_drc_debug_bounds"):GetFloat() == 1 then
		local ply = LocalPlayer()
		local tgtent = DRC.CalcView.Trace.Entity
		local HitboxColours = {
			DRC.Cols.pulsewhite,
			Color(255, 0, 0, 255),
			Color(0, 255, 0, 255),
			Color(170, 170, 75, 255),
			Color(0, 0, 255, 255),
			Color(255, 100, 255, 255),
			Color(90, 175, 255, 255),
			Color(255, 255, 255, 255)
		}
		
		local function DoTheFunny(pos,ang, mins, maxs, col)
			render.SetColorMaterial()
			render.DrawWireframeBox( pos, ang, mins, maxs, col, true)
			render.DrawBox( pos, ang, mins, maxs, Color(col.r, col.g, col.b, 3), true)
		end
		
		if DRC:ThirdPersonEnabled(ply) then
			local pos, ang =  ply:GetPos(), ply:GetRenderAngles()
			local mins, maxs = ply:GetCollisionBounds()
			local mins2, maxs2 = ply:GetRenderBounds()
			local col = Color(255, 255, 0, 255)
			local col2 = Color(150, 50, 200, 255)
			if pos && ang then DoTheFunny( pos, ang, mins, maxs, col) end
			if pos && ang then DoTheFunny( pos, ang, mins2, maxs2, col2) end
		end
		
		if IsValid(tgtent) then
			local pos, ang =  tgtent:GetPos(), tgtent:GetAngles()
			local mins, maxs = tgtent:GetCollisionBounds()
			local mins2, maxs2 = tgtent:GetRenderBounds()
			local col = Color(255, 255, 0, 255)
			local col2 = Color(150, 50, 200, 255)
			if pos && ang then DoTheFunny( pos, ang, mins, maxs, col) end
			if pos && ang then DoTheFunny( pos, ang, mins2, maxs2, col2) end
		end
	end
end)

net.Receive("DRC_RenderTrace", function()
	local tbl = net.ReadTable()
	if !tbl then return end
	local tr, colour, thyme = tbl[1], tbl[2], tbl[3]
	if isstring(colour) then colour = DRC.Cols[colour] end
	
	DRC:RenderTrace(tr, colour, thyme)
end)

function DRC:RenderTrace(tr, colour, thyme)
	if GetConVar("cl_drc_debug_tracelines"):GetFloat() != 1 then return end
	if !tr then return end
	local id = math.Round(math.Rand(1, 999999999))
	local p1, p2 = tr.StartPos, tr.HitPos
	
	DRC.Debug.TraceLines[id] = {p1, p2, colour}
	timer.Simple(thyme, function() DRC.Debug.TraceLines[id] = nil end)
end

function DRC:IDLight(pos, colour, size, colmul, thyme)
	if GetConVar("cl_drc_debug_lights"):GetFloat() != 1 then return end
	local id = math.Round(math.Rand(1, 999999999))
	colmul = colmul * 2
	DRC.Debug.Lights[id] = {pos, colour, size, colmul}
	timer.Simple(thyme, function() DRC.Debug.Lights[id] = nil end)
end