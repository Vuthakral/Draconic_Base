AddCSLuaFile()

if SERVER then
	resource.AddFile ( 'materials/overlays/draconic_scope.vmt' )
	resource.AddFile ( 'models/vuthakral/weapons/zombies/v_zombie_classic.mdl' )
else end

if GetConVar("sv_drc_movement") == nil then
	CreateConVar("sv_drc_movement", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables the custom movement modifiers of ALL weapons made on the Draconic SWEP Base.")
end

if GetConVar("sv_drc_movesounds") == nil then
	CreateConVar("sv_drc_movesounds", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables the custom sprint/jump sounds of ALL weapons made on the Draconic SWEP Base.")
end

if GetConVar("sv_drc_callofdutyspread") == nil then
	CreateConVar("sv_drc_callofdutyspread", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Do you hate 'Call of Duty aim' where weapon spread is unrealistically reduced when aiming down the sights? Me too! Unfortunately for you, people begged me to add it to my base anyways. But fortunately for you, I tied it all to a serverside config to disable it entirely!")
end

if GetConVar("sv_drc_npc_accuracy") == nil then
	CreateConVar("sv_drc_npc_accuracy", 2, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_DEMO}, "NPC accuracy on a scale of 0-10. 0 = Seal Team Six, 2 = hl2 default, 10 = Can't hit shit.")
end

if GetConVar("cl_drc_sell_soul") == nil then
	CreateConVar("cl_drc_sell_soul", 1, {FCVAR_DEMO}, "Give unto the dragon.")
end

if CLIENT then
	surface.CreateFont("WpnDisplay", {
		font 	= "lcd",
		size	= 24,
		weight	= 300	
	})
end

hook.Add( "PopulateToolMenu", "DraconicSWEPSettings", function()
	spawnmenu.AddToolMenuOption( "Options", "Draconic", "SWEP Settings", "SWEP Settings", "", "", function( panel )
		panel:ClearControls()
		panel:ControlHelp( "" )
		panel:ControlHelp( "Server / Admin-only Settings" )
		panel:CheckBox( "Enable Draconic Movement", "sv_drc_movement")
		panel:CheckBox( "Enable Draconic Movement Sounds", "sv_drc_movesounds")
		panel:CheckBox( "Allow Call of Duty Spread", "sv_drc_callofdutyspread")
		panel:NumSlider( "NPC Accuracy Handicap", "sv_drc_npc_accuracy", 0, 10, 1 )
		panel:Help( "0 = Seal Team Six" )
		panel:Help( "2 = HL2 Accuracy" )
		panel:Help( "10 = Can't hit shit." )
		panel:ControlHelp( "" )
		panel:ControlHelp( "Client Settings" )
		panel:Help( "None! ...yet." )
	--	panel:CheckBox( "Sell your soul to Vuthakral", "cl_drc_sell_soul")
	end )
end )

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
	level = 140,
	pitch = { 95, 105 },
	sound = { "weapons/explode4.wav",
	"weapons/explode3.wav",
	"weapons/hegrenade/explode5.wav" }
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