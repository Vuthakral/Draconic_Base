DRC = {}
DRC.MapInfo = {}
DRC.VoiceSets = {}
if SERVER then 
	resource.AddWorkshop("1847505933") -- Makes the base auto-download for clients joining your server.
	AddCSLuaFile("draconic/load.lua")
end
include("draconic/load.lua")

function CTFK(tab, value)
	for i,v in ipairs(tab) do
		if v == value then return true end
	end
	return false
end

function CTFKV(tab, value)
	for i,v in ipairs(tab) do
		if i == value then return true end
	end
	return false
end

function ReturnKey( action )
	if input.LookupBinding( action, false ) != nil then
		local key = input.LookupBinding( action, true )
		local final = key
		return final
	else
		return "<NO KEY>"
	end
end

function GetSF2LightLevel(limiter)
	if StormFox2 then
		if limiter != nil then
			local SF2Scalar = math.Clamp((StormFox2.Map.GetLight() * 1.25) / 100, limiter, 1)
			return SF2Scalar
		else
			local SF2Scalar = math.Clamp((StormFox2.Map.GetLight() * 1.25) / 100, 0, 1)
			return SF2Scalar
		end
	else return 1 end
end

function GetDRCColours(ent)
	local tbl = {}
	tbl.Player = ent:GetNWVector("PlayerColour_DRC")
	tbl.Weapon = ent:GetNWVector("WeaponColour_DRC")
	tbl.Eye = ent:GetNWVector("EyeTintVec")
	tbl.Energy = ent:GetNWVector("EnergyTintVec")
	tbl.Tint1 = ent:GetNWVector("ColourTintVec1")
	tbl.Tint2 = ent:GetNWVector("ColourTintVec2")
	
	return tbl
end

function DRCNotify(source, type, severity, msg, enum, time, sound)
	DRC:Notify(source, type, severity, msg, enum, time, sound)
end

function DRC:Notify(source, type, severity, msg, enum, time, sound)
	if source != nil && (severity == "warning" or severity == "error" or severity == "critical") then
		MsgC( Color(255, 0, 0), "Error from ".. tostring(source) ..": " )
	end

	local var = GetConVar("cl_drc_disable_errorhints"):GetFloat()
	if var != 1 or severity == "critical" then
		if sound != nil then surface.PlaySound( sound ) end
		if type == "hint" && CLIENT then
			if enum == nil then enum = NOTIFY_HINT end
			if time == nil then time = 10 end
			notification.AddLegacy( msg, enum, time )
		else
		 -- Will implement a proper error logging system later
		end
	end
	
	if enum == NOTIFY_ERROR then
	if severity == "critical" then severity = "critical error" end
	if IsValid(source) then
		MsgC( Color(255, 0, 0), string.upper("[".. severity .."]"), Color(255, 255, 0), " ".. msg .." \n" )
	else
		MsgC( Color(255, 0, 0), string.upper("[DRC ".. severity .."]"), Color(255, 255, 0), " ".. msg .." \n" )
	end
	end
end

function DRCSound(source, near, far, distance, listener)
	if CLIENT then return end
	if !IsValid(source) then return end
	
	DRC:EmitSound(source, near, far, distance, listener)
end

function DRCPlayGesture(ply, slot, gesture, b)
	if ply:IsValid() && ply:IsPlayer() then timer.Simple(engine.TickInterval(), function() ply:AnimRestartGesture(slot, gesture, b) end) end
end

function DRCCallGesture(ply, slot, act, akill)
	if !SERVER then return end
	if !IsValid(ply) or ply == nil then return end
	if !slot or slot == "" or slot == nil then slot = GESTURE_SLOT_CUSTOM end
	if !act then return end
	if !akill or akill == "" or akill == nil then akill = true end
	
	local nt = {}
	nt.Player = ply
	nt.Slot = slot
	nt.Activity = act
	nt.Autokill = akill
	
	net.Start("DRCNetworkGesture")
	net.WriteTable(nt)
	net.Broadcast()
end

list.Set( "DesktopWindows", "Draconic Menu", {
	title = "Draconic Base",
	icon = "icon64/draconic_base.png",
	init = function( icon, window )
		DRCMenu(LocalPlayer())
	end
	
} )

--[[
hook.Add( "PopulateToolMenu", "DraconicSWEPSettings", function()
	spawnmenu.AddToolMenuOption( "Options", "Draconic", "SWEP Base", "SWEP Base", "", "", function( panel )
		panel:ClearControls()
		local button = panel:Button("Open Menu")
		function button:OnMousePressed()
			drc_settings()
		end
	--	panel:ControlHelp( "" )
	--	panel:ControlHelp( "Server / Admin-only Settings" )
	--	panel:CheckBox( "Enable Draconic Movement", "sv_drc_movement")
	--	panel:CheckBox( "Enable Draconic Movement Sounds", "sv_drc_movesounds")
	--	panel:CheckBox( "Allow Call of Duty Spread", "sv_drc_callofdutyspread")
	--	panel:NumSlider( "NPC Accuracy Handicap", "sv_drc_npc_accuracy", 0, 10, 1 )
	--	panel:Help( "0 = Seal Team Six" )
	--	panel:Help( "2 = HL2 Accuracy" )
	--	panel:Help( "10 = Can't hit shit." )
	--	panel:ControlHelp( "" )
	--	panel:ControlHelp( "Client Settings" )
	--	panel:NumSlider( "Viewmodel sway", "cl_drc_sway", 0, 2, 1 )
	--	panel:CheckBox( "Enable Debug HUD", "cl_drc_debugmode")
	--	panel:CheckBox( "Sell your soul to Vuthakral", "cl_drc_sell_soul")
	end )
	
	spawnmenu.AddToolMenuOption( "Options", "Draconic", "Playermodel Extensions", "Playermodel Extensions", "", "", function( panel )
	local button2 = panel:Button("Open Menu")
		function button2:OnMousePressed()
			PEXMenu( LocalPlayer() )
		end
	end )
end )
--]]

local plc = Vector()
local wpc = Vector()
local t1c = Vector()
local t2c = Vector()
local eyc = Vector()
local enc = Vector()

function drc_GetPlayerColours(ply)
	DRC:GetColours(ply)
end

--hook.Add("Tick", "drc_PlayerSpeak", function()
--	if !CLIENT then return end 	
--	for k,v in pairs(player.GetAll()) do
	--	local ply = v
	--	if v:GetPoseParameter("drc_speaking") == nil then return end
	--	local pose = ply:GetPoseParameter("drc_speaking")
	--	local vol = ply:VoiceVolume()
	--	print(ply, vol)
	--	ply.drc_voicelerp = Lerp(FrameTime() * 10, ply.drc_voicelerp or vol, vol)
	--	print(ply.drc_voicelerp)	
	--	ply:SetPoseParameter("drc_speaking", ply.drc_voicelerp)
--	end
--end)

sound.Add( {
	name = "draconic.silence",
	channel = CHAN_AUTO,
	volume = 0,
	level = 0,
	pitch = { 100, 100 },
	sound = { "draconic/silence.wav" }
} )

sound.Add( {
	name = "draconic.ProjectileSplash_Tiny",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = { 25, 105 },
	sound = { ")ambient/water/rain_drip1.wav",
	")ambient/water/rain_drip2.wav",
	")ambient/water/rain_drip3.wav",
	")ambient/water/rain_drip4.wav" }
} )

sound.Add( {
	name = "draconic.ProjectileSplash_Small",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = { 25, 105 },
	sound = { ")physics/surfaces/underwater_impact_bullet1.wav",
	")physics/surfaces/underwater_impact_bullet2.wav",
	")physics/surfaces/underwater_impact_bullet3.wav" }
} )

sound.Add( {
	name = "draconic.ShieldImpactGeneric",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = { 75, 90 },
	sound = { ")physics/surfaces/underwater_impact_bullet1.wav",
	")physics/surfaces/underwater_impact_bullet2.wav",
	")physics/surfaces/underwater_impact_bullet3.wav" }
} )

sound.Add( {
	name = "draconic.ShieldDepleteGeneric",
	channel = CHAN_AUTO,
	volume = 1,
	level = 90,
	pitch = { 85, 95 },
	sound = { ")weapons/stunstick/alyx_stunner1.wav" }
} )

sound.Add( {
	name = "draconic.ShieldRechargeGeneric",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = { 95, 105 },
	sound = { ")weapons/physcannon/physcannon_charge.wav" }
} )

sound.Add( {
	name = "draconic.IronInGeneric",
	channel = CHAN_AUTO,
	volume = 0.32,
	level = 80,
	pitch = { 95, 105 },
	sound = { "weapons/bat_draw.wav",
	"player/taunt_surgeons_squeezebox_draw_clothes.wav",
	"weapons/melee_inspect_movement3.wav",
	"weapons/melee_inspect_movement4.wav",
	"weapons/movement1.wav",
	"weapons/movement2.wav",
	"weapons/movement3.wav" }
} )

sound.Add( {
	name = "draconic.IronOutGeneric",
	channel = CHAN_AUTO,
	volume = 0.32,
	level = 80,
	pitch = { 95, 105 },
	sound = { "weapons/bat_draw_swoosh1.wav",
	"weapons/melee_inspect_movement2.wav",
	"weapons/melee_inspect_movement2.wav",
	"weapons/movement1.wav",
	"weapons/movement2.wav",
	"weapons/movement3.wav" }
} )

sound.Add( {
	name = "draconic.BladeSwingSmall",
	channel = CHAN_WEAPON,
	volume = 0.96,
	level = 60,
	pitch = { 95, 105 },
	sound = { "physics/flesh/fist_swing_01.wav",
	"physics/flesh/fist_swing_02.wav",
	"physics/flesh/fist_swing_03.wav",
	"physics/flesh/fist_swing_04.wav",
	"physics/flesh/fist_swing_05.wav",
	"physics/flesh/fist_swing_06.wav" }
} )

sound.Add( {
	name = "draconic.BladeStabSmall",
	channel = CHAN_WEAPON,
	volume = 0.92,
	level = 80,
	pitch = { 95, 105 },
	sound = { "weapons/boxing_gloves_swing1.wav",
	"weapons/melee_inspect_movement2.wav",
	"weapons/movement1.wav",
	"weapons/movement2.wav",
	"weapons/movement3.wav" }
} )

sound.Add( {
	name = "draconic.BladeSmallHitWorld",
	channel = CHAN_AUTO,
	volume = 0.62,
	level = 80,
	pitch = { 95, 105 },
	sound = { "weapons/knife/knife_hitwall1.wav",
	"weapons/knife/knife_hitwall4.wav",
	"weapons/knife/knife_hit_05.wav",
	"weapons/knife/knife_hit_02.wav",
	"weapons/knife/knife_hit_01.wav",
	"weapons/knife/knife_hit_03.wav",
	"weapons/knife/knife_hitwall2.wav",
	"weapons/knife/knife_hitwall3.wav",
	"weapons/knife/knife_hit_04.wav" }
} )

sound.Add( {
	name = "draconic.BladeSmallHitFlesh",
	channel = CHAN_AUTO,
	volume = 0.62,
	level = 80,
	pitch = { 95, 105 },
	sound = { "weapons/knife/knife_hit1.wav",
	"weapons/knife/knife_hit2.wav",
	"weapons/knife/knife_hit3.wav",
	"weapons/knife/knife_hit4.wav",
	"weapons/spy_assassin_knife_impact_02.wav",
	"weapons/spy_assassin_knife_impact_01.wav" }
} )

sound.Add( {
	name = "draconic.BladeSmallStabFlesh",
	channel = CHAN_AUTO,
	volume = 0.62,
	level = 80,
	pitch = { 95, 105 },
	sound = { "weapons/knife/knife_hit1.wav",
	"weapons/knife/knife_hit2.wav",
	"weapons/knife/knife_hit3.wav",
	"weapons/knife/knife_hit4.wav",
	"weapons/axe_hit_flesh1.wav" }
} )

sound.Add( {
	name = "draconic.BatteryDepleted",
	channel = CHAN_AUTO,
	volume = 0.47,
	level = 80,
	pitch = { 95, 105 },
	sound = { "weapons/sniper_railgun_dry_fire.wav",
	"weapons/widow_maker_dry_fire.wav" }
} )

sound.Add( {
	name = "draconic.PewPew",
	channel = CHAN_WEAPON,
	volume = 0.47,
	level = 80,
	pitch = { 95, 105 },
	sound = { "weapons/capper_shoot.wav" }
} )

sound.Add( {
	name = "draconic.ExplosionSmallGeneric",
	channel = CHAN_AUTO,
	volume = 0.62,
	level = 90,
	pitch = { 95, 105 },
	sound = { "weapons/explode4.wav",
	"weapons/explode3.wav",
	"weapons/hegrenade/explode5.wav" }
} )

sound.Add( {
	name = "draconic.ExplosionDistGeneric",
	channel = CHAN_AUTO,
	volume = 0.62,
	level = 140,
	pitch = { 95, 105 },
	sound = { "ambient/explosions/exp4.wav" }
} )

sound.Add( {
	name = "draconic.VentGeneric",
	channel = CHAN_AUTO,
	volume = 0.4,
	level = 60,
	pitch = { 125, 132 },
	sound = { "ambient/gas/steam2.wav" }
} )

sound.Add( {
	name = "draconic.VentOpenGeneric",
	channel = CHAN_AUTO,
	volume = 0.4,
	level = 60,
	pitch = { 95, 105 },
	sound = { "weapons/grenade_launcher_drum_open.wav",
		"weapons/revolver_reload_cylinder_open.wav", 
		"weapons/scatter_gun_double_shells_in.wav" }
} )

sound.Add( {
	name = "draconic.VentCloseGeneric",
	channel = CHAN_AUTO,
	volume = 0.4,
	level = 60,
	pitch = { 95, 105 },
	sound = { "weapons/grenade_launcher_drum_open.wav",
		"weapons/scatter_gun_double_tube_open.wav", 
		"weapons/revolver_reload_cylinder_close.wav" }
} )

sound.Add( {
	name = "draconic.OverheatGeneric",
	channel = CHAN_AUTO,
	volume = 0.69,
	level = 90,
	pitch = { 100, 105 },
	sound = { "weapons/barret_arm_zap.wav" }
} )

sound.Add( {
	name = "draconic.EmptyGeneric",
	channel = CHAN_AUTO,
	volume = 0.69,
	level = 90,
	pitch = { 99, 102 },
	sound = { "weapons/clipempty_pistol.wav",
		"weapons/clipempty_rifle.wav" }
} )

sound.Add( {
	name = "draconic.vFireStopGeneric",
	channel = CHAN_AUTO,
	volume = 0.69,
	level = 90,
	pitch = { 90, 110 },
	sound = { "weapons/flame_thrower_bb_end.wav" }
} )

sound.Add( {
	name = "draconic.MenuPosGeneric",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 90,
	pitch = { 110, 110 },
	sound = { "ui/buttonclick.wav" }
} )

sound.Add( {
	name = "draconic.MenuNegGeneric",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 90,
	pitch = { 90, 90 },
	sound = { "buttons/button16.wav" }
} )

sound.Add( {
	name = "draconic.ChargeGeneric",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 40,
	pitch = { 100, 100 },
	sound = { "ambient/energy/force_field_loop1.wav" }
} )

sound.Add( {
	name = "draconic.FistSwingFast",
	channel = CHAN_WEAPON,
	volume = 0.96,
	level = 60,
	pitch = { 95, 105 },
	sound = { "physics/flesh/fist_swing_01.wav",
	"physics/flesh/fist_swing_02.wav",
	"physics/flesh/fist_swing_03.wav",
	"physics/flesh/fist_swing_04.wav",
	"physics/flesh/fist_swing_05.wav",
	"physics/flesh/fist_swing_06.wav" }
} )

sound.Add( {
	name = "draconic.Spark_Light",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = { 95, 105 },
	sound = { "ambient/energy/newspark03.wav",
	"ambient/energy/newspark04.wav",
	"ambient/energy/newspark07.wav" }
} )

sound.Add( {
	name = "draconic.Spark_Medium",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = { 95, 105 },
	sound = { "ambient/energy/newspark02.wav",
	"ambient/energy/newspark05.wav",
	"ambient/energy/newspark09.wav",
	"ambient/energy/newspark06.wav" }
} )

sound.Add( {
	name = "draconic.Spark_Violent",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = { 95, 105 },
	sound = { "ambient/energy/newspark01.wav",
	"ambient/energy/newspark08.wav",
	"ambient/energy/newspark10.wav",
	"ambient/energy/newspark11.wav" }
} )

sound.Add( {
	name = "draconic.particles_rubble",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = { 95, 105 },
	sound = { "ambient/materials/rock1.wav",
	"ambient/materials/rock2.wav",
	"ambient/materials/rock3.wav",
	"ambient/materials/rock4.wav" }
} )

sound.Add( {
	name = "draconic.particles_dirt",
	channel = CHAN_AUTO,
	volume = 1,
	level = 90,
	pitch = { 95, 105 },
	sound = { "ambient/machines/thumper_dust.wav" }
} )

sound.Add( {
	name = "draconic.particles_wood",
	channel = CHAN_AUTO,
	volume = 0.4,
	level = 80,
	pitch = { 95, 105 },
	sound = { "physics/wood/wood_strain2.wav",
	"physics/wood/wood_strain4.wav" }
} )

sound.Add( {
	name = "draconic.particles_woodbreak",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = { 95, 105 },
	sound = { "physics/wood/wood_plank_impact_hard1.wav",
	"physics/wood/wood_plank_break1.wav",
	"physics/wood/wood_furniture_break1.wav" }
} )

sound.Add( {
	name = "draconic.particles_metalbend",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = { 95, 105 },
	sound = { "physics/metal/metal_solid_strain1.wav",
	"physics/metal/metal_solid_strain2.wav",
	"physics/metal/metal_solid_strain3.wav",
	"ambient/materials/metal_stress1.wav",
	"ambient/materials/metal_stress2.wav",
	"ambient/materials/metal_stress4.wav",
	"ambient/materials/metal_stress5.wav",
	"ambient/materials/metal_groan.wav" }
} )

sound.Add( {
	name = "draconic.particles_metalbend_hollow",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = { 95, 105 },
	sound = { "physics/metal/metal_box_strain1.wav",
	"physics/metal/metal_box_strain2.wav",
	"physics/metal/metal_box_strain3.wav",
	"physics/metal/metal_box_strain4.wav" }
} )

sound.Add( {
	name = "draconic.particles_glasscrack",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = { 95, 105 },
	sound = { "physics/glass/glass_pottery_break4.wav",
	"physics/glass/glass_sheet_break2.wav",
	"physics/glass/glass_sheet_break3.wav",
	"physics/glass/glass_largesheet_break1.wav" }
} )

sound.Add( {
	name = "draconic.particles_glassbounce",
	channel = CHAN_AUTO,
	volume = 0.5,
	level = 80,
	pitch = { 400, 600 },
	sound = { "physics/glass/glass_bottle_impact_hard1.wav",
	"physics/glass/glass_bottle_impact_hard2.wav",
	"physics/glass/glass_bottle_impact_hard3.wav" }
} )

sound.Add( {
	name = "draconic.dynamics_glassbump",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = { 95, 105 },
	sound = { "physics/glass/glass_sheet_impact_soft1.wav",
	"physics/glass/glass_sheet_impact_soft2.wav",
	"physics/glass/glass_sheet_impact_soft3.wav" }
} )