if SERVER then
	AddCSLuaFile()
	return
end

if SERVER then
	resource.AddFile ( 'materials/overlays/draconic_scope.vmt' )
	resource.AddFile ( 'models/vuthakral/weapons/zombies/v_zombie_classic.mdl' )
else end

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