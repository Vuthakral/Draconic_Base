Draconic = {
	["Version"] = 1.01,
	["Help"] = "https://github.com/Vuthakral/Draconic_Base/wiki",
	["Author"] = "Vuthakral",
}

if SERVER then AddCSLuaFile("sh/convars.lua") end
include("sh/convars.lua")

DRC.MapInfo.Name = game.GetMap()
DRC.MapInfo.Versions = {
	"Unknown", -- V1 no known use
	"Unknown", -- V2 no known use
	"Unknown", -- V3 no known use
	"Unknown", -- V4 no known use
	"Unknown", -- V5 Counter Strike Online 2?????
	"Unknown", -- V6 no known use
	"Unknown", -- V7 no known use
	"Unknown", -- V8 no known use
	"Unknown", -- V9 no known use
	"Unknown", -- V10 no known use
	"Unknown", -- V11 no known use
	"Unknown", -- V12 no known use
	"Unknown", -- V13 no known use
	"Unknown", -- V14 no known use
	"Unknown", -- V15 no known use
	"Unknown", -- V16 no known use
	"HL2 Beta SDK", -- V17: Vempire The Masquerade, HL2 Beta
	"HL2 Beta SDK", -- V18: HL2 Beta
	"SDK 2004-2006", -- V19: HL2, HL2DM, CSS, DODS, Jabroni Brawl EP3
	"SDK 2007-2009", -- V20: HL2, HL2DM, CSS, DODS, EP1, EP2, LC, Gmod, TF2, Portal, L4D1, Zeno Clash, DMMM, Vindictus, The Ship, BGT, Black Mesa, Fairy Tale Busters, Jabroni Brawl EP3
	"SDK 2013", -- V21: L4D2, Alien Swarm, Portal 2, CSGO, Dear Esther, Insurgency, Stanley Parable, Jabroni Brawl EP3
	"SDK 2013", -- V22: INFRA, DOTA 2
	"SDK 2013-DOTA", -- V23: DOTA 2
	"Unknown", -- V24: Not documented
	"SDK 2013-CSGO", -- V25: CSGO, Portal 2 Community Edition
	"Unknown", -- V26: Not documented
	"SDK 2009? (Contagion)", -- V27: Contagion
	"How the fuck did you load a Titanfall map?", -- V29: Titanfall 1
}

if SERVER then
	DRC.MapInfo.NavMesh = navmesh.GetAllNavAreas()
	
	hook.Add( "InitPostEntity", "DRC_GetNavMeshInfo", function()
		timer.Simple(10, function() DRC.MapInfo.NavMesh = navmesh.GetAllNavAreas() end)
	end)
	
	concommand.Add("drc_reflectionamount", function(ply, cmd, args)
		if !args or !args[1] or !isnumber(tonumber(args[1])) then print("Please supply a number value.") return end
		if !file.Exists("draconic", "DATA") then file.CreateDir("draconic") end
		local ftu = file.Read("draconic/reflectionmodifiers.json", "DATA")
		if !ftu then
			local tbl = {}
			tbl[string.lower(game.GetMap())] = tonumber(args[1])
			local json = util.TableToJSON(tbl)
			file.Write("draconic/reflectionmodifiers.json", json)
		else
			local tbl = util.JSONToTable(ftu)
			tbl[string.lower(game.GetMap())] = args[1]
			local json = util.TableToJSON(tbl)
			file.Write("draconic/reflectionmodifiers.json", json)
		end
		
		net.Start("DRC_ReflectionModifier")
		net.WriteFloat(tonumber(args[1]))
		net.Broadcast()
	end)
end

if CLIENT then
	DRC.CalcView = {
		["Pos"] = Vector(),
		["Ang"] = Angle(),
		["HitPos"] = Vector(),
		["ToScreen"] = {},
		["wallpos"] = Vector(),
	}

	DRC.CalcView.ThirdPerson = {}
end

DRC.PlayerInfo = {}
DRC.PlayerInfo.ViewOffsets = {}
DRC.PlayerInfo.ViewOffsets.Defaults = { ["Standing"] = Vector(0, 0, 64), ["Crouched"] = Vector(0, 0, 28)}

DRC.Skel = {
	["Spine"] = { ["Name"] = "ValveBiped.Bip01_Spine", ["Scale"] = Vector(1,0.65,1) },
	["Spine1"] = { ["Name"] = "ValveBiped.Bip01_Spine1", ["Scale"] = Vector(1,0.65,1) },
	["Spine2"] = { ["Name"] = "ValveBiped.Bip01_Spine2", ["Scale"] = Vector(1,0.5,1) },
	["Spine4"] = { ["Name"] = "ValveBiped.Bip01_Spine4", ["Scale"] = Vector(1,0.5,1) },
	["Neck"] = { ["Name"] = "ValveBiped.Bip01_Neck1", ["Offset"] = Vector(0,0,0), ["Scale"] = Vector(0, 0, 0) },
	["Head"] = { ["Name"] = "ValveBiped.Bip01_Head1", ["Offset"] = Vector(0,0,0), ["Scale"] = Vector(0, 0, 0) },
	["LeftArm"] = { ["Name"] = "ValveBiped.Bip01_L_Clavicle", ["Offset"] = Vector(0, -25, 0) },
	["RightArm"] = { ["Name"] = "ValveBiped.Bip01_R_Clavicle", ["Offset"] = Vector(0, -25, 0) },
	["LeftHand"] = { ["Name"] = "ValveBiped.Bip01_L_Hand", ["Offset"] = Vector(0, 0, 0) },
	["RightHand"] = { ["Name"] = "ValveBiped.Bip01_R_Hand", ["Offset"] = Vector(0, 0, 0) },
}

if !DRC.Playermodels then
	DRC.Playermodels = {
		["-drcdefault"] = {
			["Model"] = "",
			["Hands"] = "",
			["Background"] = "vgui/drc_playerbg",
			["Podium"] = {"models/props_phx/construct/glass/glass_angle360.mdl", Vector(0, 0, -2)},
			["DefaultCam"] = {
				["Pos"] = Vector(80.69, 36.7, 52.02),
				["Ang"] = Angle(10.278, 203.334, 0),
			},
		}
	}
end

function DRC:GetPlayerModelInfo(model)
	local tab = nil
	if model == nil then return DRC.Playermodels["-drcdefault"] end
	if model != nil then tab = DRC.Playermodels[player_manager.TranslateToPlayerModelName(model)] end
	if tab then return tab else return DRC.Playermodels["-drcdefault"] end
end

if CLIENT then DRC.HDREnabled = render.GetHDREnabled() end
DRC.WeathermodScalar = Vector(1, 1, 1)
DRC.SWModVal = Vector(1, 1, 1)

DRC.RoomDefinitions = {
	["Vent"] = 50,
	["Small"] = 300,
	["Regular"] = 500,
	["Large"] = 700,
	["Outdoors"] = 900,
}

DRC.MaterialCategories = {}

DRC.MaterialCategories.Metal = {
}
DRC.MaterialCategories.Dust = {
}

-- First entry in table is used for sound references, anything else is for particle systems.
-- Sound references: cardboard, dirt, flesh, glass, metal, metalhollow/metaldrum, metalvent, mud, rubber, rubble, sand/dust, shards, snow, synth/bugshell, tile, wood, stone
-- All existing references: cardboard, bugshell, dirt, dust, flesh, gas, glass, liquid, metal, metaldrum, metalhollow, paint, plastic, rubble, sand, shards, snow, synth, tile, wood, stone
DRC.SurfacePropDefinitions = { -- Todo for dynamic particles: flesh, tile, synth, plastic, gas, liquid, computer, cardboard
	["MAT_DEFAULT"] = {"stone", "dust"},
	["MAT_CLIP"] = {"stone", "dust"},
	["MAT_NO_DECAL"] = {"stone", "dust"},
	["MAT_ANTLION"] = {"flesh"},
	["MAT_FLESH"] = {"flesh"},
	["MAT_ARMORFLESH"] = {"flesh"},
	["MAT_BLOODYFLESH"] = {"flesh"},
	["MAT_ZOMBIEFLESH"] = {"flesh"},
	["MAT_ALIENFLESH"] = {"flesh"},
	["MAT_WATERMELON"] = {"flesh"},
	["MAT_STRIDER"] = {"metal", "synth"},
	["MAT_HUNTER"] = {"bugshell", "synth"},
	["MAT_PAPER"] = {"dirt", "dust"},
	["MAT_EGGSHELL"] = {"dirt"},
	["MAT_ANTLION_EGGSHELL"] = {"bugshell"},
	["MAT_PLASTIC"] = {"plastic", "dust"},
	["MAT_PLASTIC_BARREL"] = {"plastic", "dust"},
	["MAT_PLASTIC_BOX"] = {"plastic", "dust"},
	["MAT_PAINTCAN"] = {"metal", "paint"},
	["MAT_POPCAN"] = {"metal", "liquid"},
	["MAT_CANISTER"] = {"metaldrum", "gas"},
	["MAT_VENT"] = {"metal"},
	["MAT_GRENADE"] = {"metal"},
	["MAT_WEAPON"] = {"plastic", "metal"},
	["MAT_ITEM"] = {"metal"},
	["MAT_CROWBAR"] = {"metal"},
	["MAT_METAL"] = {"metal"},
	["MAT_GRATE"] = {"metal"},
	["MAT_METALGRATE"] = {"metal"},
	["MAT_METALVEHICLE"] = {"metal", "metalhollow"},
	["MAT_METALVENT"] = {"metalvent", "metal"},
	["MAT_CHAINLINK"] = {"chainlink"},
	["MAT_WARPSHIELD"] = {"metal"},
	["MAT_COMBINE_METAL"] = {"metal", "metalhollow"},
	["MAT_COMBINE_GLASS"] = {"glass", "shards"},
	["MAT_GUNSHIP"] = {"synth", "metalhollow"},
	["MAT_ROLLER"] = {"metalhollow", "computer"},
	["MAT_SOLIDMETAL"] = {"metal"},
	["MAT_SLIPPERYMETAL"] = {"metal"},
	["MAT_METALPANEL"] = {"metal"},
	["MAT_METAL_BARREL"] = {"metaldrum"},
	["MAT_FLOATING_METAL_BARREL"] = {"metaldrum"},
	["MAT_METAL_BOX"] = {"metal"},
	["MAT_COMPUTER"] = {"computer"},
	["MAT_JALOPY"] = {"metal", "metalhollow"},
	["MAT_AIRBOAT"] = {"metal", "metalhollow"},
	["MAT_CONCRETE"] = {"stone", "rubble"},
	["MAT_BRICK"] = {"stone", "rubble"},
	["MAT_PLASTER"] = {"plaster", "dust"},
	["MAT_CEILING_TILE"] = {"plaster", "dust"},
	["MAT_DIRT"] = {"dirt", "dust"},
	["MAT_MUD"] = {"mud", "liquid"},
	["MAT_SLOSH"] = {"water", "liquid"},
	["MAT_WADE"] = {"water", "liquid"},
	["MAT_WATER"] = {"water", "liquid"},
	["MAT_FOLIAGE"] = {"wood", "dirt"},
	["MAT_WOOD"] = {"wood", "dirt"},
	["MAT_WOOD_FURNITURE"] = {"wood"},
	["MAT_WOOD_SOLID"] = {"wood"},
	["MAT_WOOD_CRATE"] = {"wood"},
	["MAT_WOOD_PLANK"] = {"wood"},
	["MAT_WOOD_PANEL"] = {"wood"},
	["MAT_BOULDER"] = {"stone", "rubble", "dirt"},
	["MAT_ROCK"] = {"stone", "rubble", "dirt"},
	["MAT_STONE"] = {"stone", "rubble", "dirt"},
	["MAT_GRAVEL"] = {"rubble", "dirt"},
	["MAT_GRASS"] = {"grass", "dirt", "dust"},
	["MAT_SAND"] = {"sand", "dust"},
	["MAT_ANTLIONSAND"] = {"sand", "stone"},
	["MAT_SNOW"] = {"snow", "dust"},
	["MAT_ICE"] = {"stone", "shards"},
	["MAT_POTTERY"] = {"tile"},
	["MAT_PORCELAIN"] = {"tile"},
	["MAT_TILE"] = {"tile"},
	["MAT_GLASS"] = {"glass", "shards"},
	["MAT_GLASSBOTTLE"] = {"shards"},
	["MAT_GLASS_BOTTLE"] = {"shards"},
	["MAT_RUBBER"] = {"rubber", "plastic"},
	["MAT_RUBBERTIRE"] = {"rubber", "plastic"},
	["MAT_CARDBOARD"] = {"cardboard", "dust"},
	["MAT_CARPET"] = {"fabric"},
	["MAT_FABRIC"] = {"fabric"},
	["MAT_CLOTH"] = {"fabric"},
}

function DRC:GetDRCMaterial(ent, optbone)
	if !optbone then optbone = 0 end
	return DRC.SurfacePropDefinitions[DRC:SurfacePropToEnum(ent:GetBoneSurfaceProp(optbone))]
end

DRC.HelperEnts = {
	["ai_ally_manager"] = "ally_manager",
	["ai_battle_line"] = "battle_line",
	["ai_changehintgroup"] = "changehintgroup",
	["ai_changetarget"] = "changetarget",
	["ai_goal_actbusy"] = "actbusy",
	["ai_goal_assault"] = "assault",
	["ai_goal_follow"] = "follow",
	["ai_goal_lead"] = "lead",
	["ai_goal_operator"] = "operator",
	["ai_goal_police"] = "police",
	["ai_goal_standoff"] = "standoff",
	["ai_network"] = "ai",
	["env_alyxemp"] = "empeffect",
	["env_gunfire"] = "gunfire",
	["env_muzzleflash"] = "muzzleflash",
	["env_ar2explosion"] = "comballexplode",
	["env_spritetrail"] = "spritetrail",
	["env_dusttrail"] = "dusttrail",
	["env_effectscript"] = "dusttrail",
	["env_movieexplosion"] = "movieexplosion",
	["env_particle_trail"] = "particletrail",
	["env_particlefire"] = "particlefire",
	["env_particlesmokegrenade"] = "smokegrenade",
	["env_physwire"] = "physwire",
	["env_quadraticbeam"] = "beam2005",
	["env_rockettrail"] = "rockettrail",
	["env_steamjet"] = "steamjet",
	["gib"] = "gib",
	["rope_anchor"] = "ropepoint",
	["entityflame"] = "igniter2006",
	["env_entity_igniter"] = "igniter",
	["trigger_waterydeath"] = "suffocate",
	["env_soundscape"] = "soundscape",
	["ambient_generic"] = "ambient",
	["point_spotlight"] = "sdk2006lightomgwhy",
	["spotlight_end"] = "lightmarker",
	["light"] = "staticlight",
	["func_brush"] = "brush",
	["info_ladder_dismount"] = "ladder_exit",
	["func_ladder"] = "ladder",
	["beam"] = "beam",
	["move_rope"] = "ropephysics",
	["scene_manager"] = "cinematic",
	["bodyque"] = "followpoint",
	["soundent"] = "soundemitter2005",
	["path_track"] = "pathtr",
	["path_corner"] = "pathcor",
	["gmod_gamerules"] = "objectrelativecodinglmao",
	["class CLuaEffect"] = "emitter",
	["lua_run"] = "garry",
	["predicted_viewmodel"] = "viewmodel",
	["viewmodel"] = "viewmodel",
	["target_cdaudio"] = "cdaudio", -- HOLY SHIT THIS IS STILL IN THE ENGINE?????
	["drc_ptex_base"] = "drc_ptex_base",
	["drc_csshadowmodel"] = "drc_csshadowmodel",
	["drc_csweaponshadow"] = "drc_csweaponshadow",
	["drc_csplayermodel"] = "drc_csplayermodel",
	["drc_shieldmodel"] = "drc_shieldmodel",
}

DRC.HoldTypes = {
	["fallback"] = {
		["deploy"] = ACT_RESET,
		["reload"] = ACT_RESET,
		["attack"] = ACT_RESET,
		["run"] = ACT_RESET,
		["walk"] = ACT_RESET,
		["cwalk"] = ACT_RESET,
		["idle"] = ACT_RESET,
		["cidle"] = ACT_RESET,
		["jump"] = ACT_RESET,
		["npc"] = {
			["attack"] = ACT_RESET,
			["reload"] = ACT_RESET,
		}
	},
	["pistol"] = {
		["deploy"] = ACT_VM_DEPLOY_1,
		["reload"] = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL,
		["run"] = ACT_HL2MP_RUN_PISTOL,
		["walk"] = ACT_HL2MP_WALK_PISTOL,
		["cwalk"] = ACT_HL2MP_WALK_CROUCH_PISTOL,
		["idle"] = ACT_HL2MP_IDLE_PISTOL,
		["cidle"] = ACT_HL2MP_IDLE_CROUCH_PISTOL,
		["jump"] = ACT_HL2MP_JUMP_PISTOL,
		["npc"] = {
			["attack"] = ACT_RANGE_ATTACK_PISTOL,
			["reload"] = ACT_RELOAD_PISTOL,
		}
	},
	["revolver"] = {
		["deploy"] = ACT_VM_DEPLOY_1,
		["reload"] = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
		["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER,
		["run"] = ACT_HL2MP_RUN_REVOLVER,
		["walk"] = ACT_HL2MP_WALK_REVOLVER,
		["cwalk"] = ACT_HL2MP_WALK_CROUCH_REVOLVER,
		["idle"] = ACT_HL2MP_IDLE_REVOLVER,
		["cidle"] = ACT_HL2MP_IDLE_CROUCH_REVOLVER,
		["jump"] = ACT_HL2MP_JUMP_REVOLVER,
		["npc"] = {
			["attack"] = ACT_RESET,
			["reload"] = ACT_RESET,
		}
	},
	["smg"] = {
		["deploy"] = ACT_VM_DEPLOY_2,
		["reload"] = ACT_HL2MP_GESTURE_RELOAD_SMG1,
		["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1,
		["run"] = ACT_HL2MP_RUN_SMG1,
		["walk"] = ACT_HL2MP_WALK_SMG1,
		["cwalk"] = ACT_HL2MP_WALK_CROUCH_SMG1,
		["idle"] = ACT_HL2MP_IDLE_SMG1,
		["cidle"] = ACT_HL2MP_IDLE_CROUCH_SMG1,
		["jump"] = ACT_HL2MP_JUMP_SMG1,
		["npc"] = {
			["attack"] = ACT_RANGE_ATTACK_SMG1,
			["reload"] = ACT_RELOAD_SMG1,
		}
	},
	["ar2"] = {
		["deploy"] = ACT_VM_DEPLOY_2,
		["reload"] = ACT_HL2MP_GESTURE_RELOAD_AR2,
		["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2,
		["run"] = ACT_HL2MP_RUN_AR2,
		["walk"] = ACT_HL2MP_WALK_AR2,
		["cwalk"] = ACT_HL2MP_WALK_CROUCH_AR2,
		["idle"] = ACT_HL2MP_IDLE_AR2,
		["cidle"] = ACT_HL2MP_IDLE_CROUCH_AR2,
		["jump"] = ACT_HL2MP_JUMP_AR2,
		["npc"] = {
			["attack"] = ACT_RANGE_ATTACK_AR2,
			["reload"] = ACT_GESTURE_RELOAD,
		}
	},
	["passive"] = {
		["deploy"] = ACT_VM_DEPLOY_2,
		["reload"] = ACT_HL2MP_GESTURE_RELOAD_AR2,
		["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2,
		["run"] = ACT_HL2MP_RUN_PASSIVE,
		["walk"] = ACT_HL2MP_WALK_PASSIVE,
		["cwalk"] = ACT_HL2MP_WALK_CROUCH_PASSIVE,
		["idle"] = ACT_HL2MP_IDLE_PASSIVE,
		["cidle"] = ACT_HL2MP_IDLE_CROUCH_PASSIVE,
		["jump"] = ACT_HL2MP_JUMP_PASSIVE,
		["npc"] = {
			["attack"] = ACT_RESET,
			["reload"] = ACT_RESET,
		}
	},
	["shotgun"] = {
		["deploy"] = ACT_VM_DEPLOY_2,
		["reload"] = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
		["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
		["run"] = ACT_HL2MP_RUN_SHOTGUN,
		["walk"] = ACT_HL2MP_WALK_SHOTGUN,
		["cwalk"] = ACT_HL2MP_WALK_CROUCH_SHOTGUN,
		["idle"] = ACT_HL2MP_IDLE_SHOTGUN,
		["cidle"] = ACT_HL2MP_IDLE_CROUCH_SHOTGUN,
		["jump"] = ACT_HL2MP_JUMP_SHOTGUN,
		["npc"] = {
			["attack"] = ACT_RANGE_ATTACK_SHOTGUN,
			["reload"] = ACT_RELOAD_SHOTGUN,
		}
	},
	["crossbow"] = {
		["deploy"] = ACT_VM_DEPLOY_2,
		["reload"] = ACT_HL2MP_GESTURE_RELOAD_CROSSBOW,
		["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW,
		["run"] = ACT_HL2MP_RUN_CROSSBOW,
		["walk"] = ACT_HL2MP_WALK_CROSSBOW,
		["cwalk"] = ACT_HL2MP_WALK_CROUCH_CROSSBOW,
		["idle"] = ACT_HL2MP_IDLE_CROSSBOW,
		["cidle"] = ACT_HL2MP_IDLE_CROUCH_CROSSBOW,
		["jump"] = ACT_HL2MP_JUMP_CROSSBOW,
		["npc"] = {
			["attack"] = ACT_RANGE_ATTACK_SHOTGUN,
			["reload"] = ACT_GESTURE_RELOAD,
		}
	},
	["duel"] = {
		["deploy"] = ACT_VM_DEPLOY_7,
		["reload"] = ACT_HL2MP_GESTURE_RELOAD_DUEL,
		["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_DUEL,
		["run"] = ACT_HL2MP_RUN_DUEL,
		["walk"] = ACT_HL2MP_WALK_DUEL,
		["cwalk"] = ACT_HL2MP_WALK_CROUCH_DUEL,
		["jump"] = ACT_HL2MP_JUMP_DUEL,
		["npc"] = {
			["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_DUEL,
			["reload"] = ACT_HL2MP_GESTURE_RELOAD_DUEL,
		}
	},
	["physgun"] = {
		["deploy"] = ACT_VM_DEPLOY_4,
		["reload"] = ACT_HL2MP_GESTURE_RELOAD_PHYSGUN,
		["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_PHYSGUN,
		["run"] = ACT_HL2MP_RUN_PHYSGUN,
		["walk"] = ACT_HL2MP_WALK_PHYSGUN,
		["cwalk"] = ACT_HL2MP_WALK_CROUCH_PHYSGUN,
		["idle"] = ACT_HL2MP_IDLE_PHYSGUN,
		["cidle"] = ACT_HL2MP_IDLE_CROUCH_PHYSGUN,
		["jump"] = ACT_HL2MP_JUMP_PHYSGUN,
		["npc"] = {
			["attack"] = ACT_RANGE_ATTACK_SHOTGUN,
			["reload"] = ACT_GESTURE_RELOAD,
		}
	},
	["fist"] = {
		["deploy"] = ACT_VM_DEPLOY_7,
		["reload"] = ACT_HL2MP_GESTURE_RELOAD_FIST,
		["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST,
		["run"] = ACT_HL2MP_RUN_FIST,
		["walk"] = ACT_HL2MP_WALK_FIST,
		["cwalk"] = ACT_HL2MP_WALK_CROUCH_FIST,
		["idle"] = ACT_HL2MP_IDLE_FIST,
		["cidle"] = ACT_HL2MP_IDLE_CROUCH_FIST,
		["jump"] = ACT_HL2MP_JUMP_FIST,
		["npc"] = {
			["attack"] = ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND,
			["reload"] = ACT_RESET,
		}
	},
	["normal"] = {
		["deploy"] = ACT_RESET,
		["reload"] = ACT_RESET,
		["attack"] = ACT_RESET,
		["run"] = ACT_HL2MP_RUN,
		["walk"] = ACT_HL2MP_WALK,
		["cwalk"] = ACT_HL2MP_CROUCH_WALK,
		["idle"] = ACT_HL2MP_IDLE,
		["cidle"] = ACT_HL2MP_IDLE_CROUCH,
		["jump"] = ACT_HL2MP_JUMP_SLAM,
		["npc"] = {
			["attack"] = ACT_GMOD_GESTURE_MELEE_SHOVE_1HAND,
			["reload"] = ACT_RESET,
		}
	},
	["rpg"] = {
		["deploy"] = ACT_VM_DEPLOY_3,
		["reload"] = ACT_HL2MP_GESTURE_RELOAD_RPG,
		["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG,
		["run"] = ACT_HL2MP_RUN_RPG,
		["walk"] = ACT_HL2MP_WALK_RPG,
		["cwalk"] = ACT_HL2MP_WALK_CROUCH_RPG,
		["idle"] = ACT_HL2MP_IDLE_RPG,
		["cidle"] = ACT_HL2MP_IDLE_CROUCH_RPG,
		["jump"] = ACT_HL2MP_JUMP_RPG,
		["npc"] = {
			["attack"] = ACT_RANGE_ATTACK_RPG,
			["reload"] = ACT_RESET,
		}
	},
	["melee"] = {
		["deploy"] = ACT_VM_DEPLOY_5,
		["reload"] = ACT_HL2MP_GESTURE_RELOAD_MELEE,
		["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE,
		["run"] = ACT_HL2MP_RUN_MELEE,
		["walk"] = ACT_HL2MP_WALK_MELEE,
		["cwalk"] = ACT_HL2MP_WALK_CROUCH_MELEE,
		["idle"] = ACT_HL2MP_IDLE_MELEE,
		["cidle"] = ACT_HL2MP_IDLE_CROUCH_MELEE,
		["jump"] = ACT_HL2MP_JUMP_MELEE,
		["npc"] = {
			["attack"] = ACT_MELEE_ATTACK_SWING,
			["reload"] = ACT_RESET,
		}
	},
	["knife"] = {
		["deploy"] = ACT_VM_DEPLOY_5,
		["reload"] = ACT_HL2MP_GESTURE_RELOAD_KNIFE,
		["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE,
		["run"] = ACT_HL2MP_RUN_KNIFE,
		["walk"] = ACT_HL2MP_WALK_KNIFE,
		["cwalk"] = ACT_HL2MP_WALK_CROUCH_KNIFE,
		["idle"] = ACT_HL2MP_IDLE_KNIFE,
		["cidle"] = ACT_HL2MP_IDLE_CROUCH_KNIFE,
		["jump"] = ACT_HL2MP_JUMP_CIDLE,
		["npc"] = {
			["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE,
			["reload"] = ACT_RESET,
		}
	},
	["grenade"] = {
		["deploy"] = ACT_VM_DEPLOY_5,
		["reload"] = ACT_HL2MP_GESTURE_RELOAD_GRENADE,
		["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE,
		["run"] = ACT_HL2MP_RUN_GRENADE,
		["walk"] = ACT_HL2MP_WALK_GRENADE,
		["cwalk"] = ACT_HL2MP_WALK_CROUCH_GRENADE,
		["idle"] = ACT_HL2MP_IDLE_GRENADE,
		["cidle"] = ACT_HL2MP_IDLE_CROUCH_GRENADE,
		["jump"] = ACT_HL2MP_JUMP_GRENADE,
		["npc"] = {
			["attack"] = ACT_COMBINE_THROW_GRENADE,
			["reload"] = ACT_RESET,
		}
	},
	["slam"] = {
		["deploy"] = ACT_VM_DEPLOY_5,
		["reload"] = ACT_HL2MP_GESTURE_RELOAD_SLAM,
		["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM,
		["run"] = ACT_HL2MP_RUN_SLAM,
		["walk"] = ACT_HL2MP_WALK_SLAM,
		["cwalk"] = ACT_HL2MP_WALK_CROUCH_SLAM,
		["idle"] = ACT_HL2MP_IDLE_SLAM,
		["cidle"] = ACT_HL2MP_IDLE_CROUCH_SLAM,
		["jump"] = ACT_HL2MP_JUMP_SLAM,
		["npc"] = {
			["attack"] = ACT_RANGE_ATTACK_SLAM,
			["reload"] = ACT_RESET,
		}
	},
	["magic"] = {
		["deploy"] = ACT_VM_DEPLOY_5,
		["reload"] = ACT_HL2MP_GESTURE_RELOAD_MAGIC,
		["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_MAGIC,
		["run"] = ACT_HL2MP_RUN_MAGIC,
		["walk"] = ACT_HL2MP_WALK_MAGIC,
		["cwalk"] = ACT_HL2MP_WALK_CROUCH_MAGIC,
		["idle"] = ACT_HL2MP_IDLE_MAGIC,
		["cidle"] = ACT_HL2MP_IDLE_CROUCH_MAGIC,
		["jump"] = ACT_HL2MP_JUMP_MAGIC,
		["npc"] = {
			["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_MAGIC,
			["reload"] = ACT_RESET,
		}
	},
	["camera"] = {
		["deploy"] = ACT_VM_DEPLOY_5,
		["reload"] = ACT_HL2MP_GESTURE_RELOAD_CAMERA,
		["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_CAMERA,
		["run"] = ACT_HL2MP_RUN_CAMERA,
		["walk"] = ACT_HL2MP_WALK_CAMERA,
		["cwalk"] = ACT_HL2MP_WALK_CROUCH_CAMERA,
		["idle"] = ACT_HL2MP_IDLE_CAMERA,
		["cidle"] = ACT_HL2MP_IDLE_CROUCH_CAMERA,
		["jump"] = ACT_HL2MP_JUMP_CAMERA,
		["npc"] = {
			["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_CAMERA,
			["reload"] = ACT_RESET,
		}
	},
	["melee2"] = {
		["deploy"] = ACT_VM_DEPLOY_6,
		["reload"] = ACT_HL2MP_GESTURE_RELOAD_MELEE2,
		["attack"] = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2,
		["run"] = ACT_HL2MP_RUN_MELEE2,
		["walk"] = ACT_HL2MP_WALK_MELEE2,
		["cwalk"] = ACT_HL2MP_WALK_CROUCH_MELEE2,
		["idle"] = ACT_HL2MP_IDLE_MELEE2,
		["cidle"] = ACT_HL2MP_IDLE_CROUCH_MELEE2,
		["jump"] = ACT_HL2MP_JUMP_MELEE2,
		["npc"] = {
			["attack"] = ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND,
			["reload"] = ACT_RESET,
		}
	},
}

DRC.HoldTypes.HardcodedWeapons = {
	["weapon_pistol"] = "pistol",
	["weapon_glock_hl1"] = "pistol",
	["weapon_357"] = "revolver",
	["weapon_357_hl1"] = "revolver",
	["weapon_snark"] = "slam",
	["weapon_alyxgun"] = "normal",
	["weapon_crossbow"] = "crossbow",
	["weapon_ar2"] = "ar2",
	["weapon_shotgun"] = "shotgun",
	["weapon_smg1"] = "smg",
	["weapon_crossbow_hl1"] = "crossbow",
	["weapon_mp5_hl1"] = "ar2",
	["weapon_shotgun_hl1"] = "shotgun",
	["weapon_gauss"] = "crossbow",
	["weapon_annabelle"] = "normal",
	["weapon_cubemap"] = "normal",
	["weapon_physcannon"] = "physgun",
	["weapon_physgun"] = "physgun",
	["weapon_egon"] = "physgun",
	["weapon_hornetgun"] = "crossbow",
	["weapon_rpg"] = "rpg",
	["weapon_rpg_hl1"] = "rpg",
	["weapon_crowbar"] = "melee",
	["weapon_crowbar_hl1"] = "melee", -- It's actually "crowbar", for some reason. Uses the exact same animations though.
	["weapon_stunstick"] = "melee",
	["weapon_slam"] = "slam",
	["weapon_tripmine"] = "slam",
	["weapon_frag"] = "grenade",
	["weapon_handgrenade"] = "grenade",
	["weapon_bugbait"] = "normal",
	["weapon_satchel"] = "slam",
	["gmod_camera"] = "camera",
}

function DRC:GetHoldTypeAnim(ht, anim, npc)
	if !ht or !anim then return end
	if !DRC.HoldTypes[ht] then ht = "fallback" end
	
	if npc == false then 
		return DRC.HoldTypes[ht][anim]
	else
		return DRC.HoldTypes[ht].npc[anim]
	end
end

function DRC:GetVersion()
	return Draconic.Version
end

function DRC:GetOS()
	if system.IsWindows() then return "Windows" end
	if system.IsLinux() then return "Linux" end
	if system.IsOSX() then return "OSX" end
end

function DRC:GetPower()
	if system.BatteryPower() != 255 then return system.BatteryPower() else return "Desktop" end
end

function DRC:GetServerMode()
	if game.IsDedicated() then return "Dedicated Server"
	elseif !game.IsDedicated() then
		if game.SinglePlayer() then return "Singleplayer"
		else return "Listen Server"
		end
	end
end

function DRC:Notify(source, typ, severity, msg, enum, thyme, sound)
	if source != nil && (severity == "warning" or severity == "error" or severity == "critical") then
		MsgC( Color(255, 0, 0), "Error from ".. tostring(source) ..": " )
	end

	local var = GetConVar("cl_drc_disable_errorhints"):GetFloat()
	if var != 1 or severity == "critical" then
		if sound != nil then surface.PlaySound( sound ) end
		if typ == "hint" && CLIENT then
			if enum == nil then enum = NOTIFY_HINT end
			if thyme == nil then thyme = 10 end
			notification.AddLegacy( msg, enum, thyme )
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

function DRC:MismatchWarn(ply, ent)
	if !ply or !ent then return end
	
	local diff, str, veriswhole = (DRC:GetVersion() - ent.DRCVersion) * 100, "version", false
	if ent.DRCVersion == math.floor(ent.DRCVersion) then
		veriswhole = ".00"
	end
	if math.floor(diff) != 1 then str = "versions" end
	
	local str2 = nil
	if game.SinglePlayer() then
		str2 = "Contact ".. ent.Author .." and please ask them nicely to update it."
	else str2 = "Contact the server operator and please ask them nicely to check for updates." end
	
	local msg = {Color(200, 200, 200), "".. ent.PrintName .." is ", Color(255, 0, 0), "outdated ", Color(200, 200, 200), "by ".. diff .." ".. str .."! (".. ent.DRCVersion .."".. veriswhole .." vs ".. DRC:GetVersion() ..") ".. str2 ..""}
	
	if game.SinglePlayer() && CLIENT then
		chat.AddText(Color(200, 200, 200), "".. ent.PrintName .." is ", Color(255, 0, 0), "outdated ", Color(200, 200, 200), "by ".. diff .." ".. str .."! (".. ent.DRCVersion .."".. veriswhole .." vs ".. DRC:GetVersion() ..") ".. str2 .."")
	else
		DRC:AddText(ply, msg)
	end
end

function DRC:ValveBipedCheck(ent)
	if !ent:LookupBone("ValveBiped.Bip01_R_Hand") then return false end
	if !ent:LookupBone("ValveBiped.Bip01_L_Hand") then return false end
	if !ent:LookupBone("ValveBiped.Bip01_Spine1") then return false end
	if !ent:LookupBone("ValveBiped.Bip01_Spine2") then return false end
	if !ent:LookupBone("ValveBiped.Bip01_Spine4") then return false end
	if !ent:LookupBone("ValveBiped.Bip01_L_Clavicle") then return false end
	if !ent:LookupBone("ValveBiped.Bip01_R_Clavicle") then return false end
	if !ent:LookupBone("ValveBiped.Bip01_L_Thigh") then return false end
	if !ent:LookupBone("ValveBiped.Bip01_R_Thigh") then return false end
	if ent:GetBoneParent(ent:LookupBone("ValveBiped.Bip01_Spine1")) != ent:LookupBone("ValveBiped.Bip01_Spine") then return false end
	return true
end

function DRC:SightsDown(ent, irons)
	if !IsValid(ent) then return end
	if irons == nil then irons = false end
	local base = DRC:GetBaseName(ent)
	
	if !irons then
		if base == "drc" then
			return ent.SightsDown
		elseif base == "tfa" then
			return ent:GetIronSights()
		elseif base == "astw2" then
			if ent.TrueScope == true && ent:GetNWBool("insights") == true then return true else return false end
		elseif base == "arccw" then
			if ent.Sighted == true then return true else return false end
		elseif base == "arc9" then
			if ent:IsScoping() == true then return true else return false end
		elseif base == "mwb" then
			if ent:GetIsAiming() == true then return true else return false end
		end
	else
		if ent.Draconic then
			if ent.Secondary.Scoped == true then return ent.SightsDown else return false end
		end
	end
end

local ConversionRates = {
	-- "Convert to" formats
	["km"] = 0.0000254,
	["m"] = 0.0254,
	["cm"] = 2.54,
	["mm"] = 25.4,
	
	["in"] = 1,
	["ft"] = 0.08333,
	["yd"] = 0.02777,
	["mile"] = 1 / 63360,
	
	-- "Convert from" formats
	["halo"] = 160/1, -- Halo Units to Hammer Units
}

local cfrom = {
	["halo"] = true,
}

function DRC:ConvertUnit(input, output)
	if !ConversionRates[tostring(output)] then print("Draconic Base: Requested unit conversion ''".. tostring(output) .."'' is not valid!") end
	local inches = input * 0.75
	if cfrom[output] then inches = input end
	return inches * ConversionRates[output]
end

function DRC:GetVelocityAngle(ent, absolute, flipy, islocal)
	local ang = Angle()
	if isvector(ent) then 
		ang = ent:Angle()
	else
		ang = ent:GetVelocity():Angle()
	end
	if absolute == true then
		ang.x = math.abs(ang.x)
		ang.y = math.abs(ang.y)
	end
	if flipy == true then ang.y = -ang.y end
	
	return ang
-- stupid code I wrote without testing or realizing the simple solution for
--[[	if !IsValid(ent) then return end
	if !absolute then absolute = false end
	if !flipy then flipy = false end
	local vel = ent:GetVelocity()
	if vel == Vector() then return Angle() end
	local length = vel:Length()
	local forwardang = ent:GetForward():Angle()
	local velangxy = ent:WorldToLocalAngles(vel:Angle())
	if flipy == true then velangxy:RotateAroundAxis(velangxy:Up(), 180) end
	if absolute == true then velangxy.y = math.abs(velangxy.y) end
	velangxy.x = -velangxy.x
	return velangxy ]]
end

function DRC:LerpColor(fraction, mini, maxi)
	local col = Color(255, 255, 255, 255)
	col.r = Lerp(fraction, mini.r, maxi.r)
	col.g = Lerp(fraction, mini.g, maxi.g)
	col.b = Lerp(fraction, mini.b, maxi.b)
	col.a = Lerp(fraction, mini.a, maxi.a)
	return col
end

function DRC:GetColours(ent, rgb)
	if !IsValid(ent) then return end
	local coltab = {}
	if ent:IsPlayer() then
		if !ent:Alive() then return end
		coltab = {
			["Player"] 	= ent:GetNWVector("PlayerColour_DRC"),
			["Weapon"] 	= ent:GetNWVector("WeaponColour_DRC"),
			["Tint1"] 	= ent:GetNWVector("ColourTintVec1") / 255,
			["Tint2"] 	= ent:GetNWVector("ColourTintVec2") / 255,
			["Eye"] 	= ent:GetNWVector("EyeTintVec") / 255,
			["Energy"] 	= ent:GetNWVector("EnergyTintVec"),
			["$color2"] = Vector(ent:GetColor().r, ent:GetColor().g, ent:GetColor().b)/255,
		}
	else
		coltab = {
			["Player"] 	= ent:GetNWVector("PlayerColour_DRC"),
			["Weapon"] 	= ent:GetNWVector("WeaponColour_DRC"),
			["Tint1"] 	= ent:GetNWVector("ColourTintVec1") / 255,
			["Tint2"] 	= ent:GetNWVector("ColourTintVec2") / 255,
			["Eye"] 	= ent:GetNWVector("EyeTintVec") / 255,
			["Energy"] 	= ent:GetNWVector("EnergyTintVec"),
			["$color2"] = Vector(ent:GetColor().r, ent:GetColor().g, ent:GetColor().b)/255,
		}
	end
	
	if table.IsEmpty(coltab) then return end
	if rgb == true then
		coltab.Player 	= coltab.Player * 255
		coltab.Weapon 	= coltab.Weapon * 255
		coltab.Tint1 	= coltab.Tint1 * 255
		coltab.Tint2 	= coltab.Tint2 * 255
		coltab.Eye 		= coltab.Eye * 255
		coltab.Energy 	= coltab.Energy * 255
		coltab["$color2"] 	= coltab["$color2"] * 255
	end

	return coltab
end


function DRC:UpdatePlayerColours(ply)
	if not IsValid(ply) then return end
	if ply != ply then return end
	
	local t1c = Vector(127, 127, 127)
	local t2c = Vector(127, 127, 127)
	local eyc = Vector(127, 127, 127)
	local enc = Vector(127, 127, 127)
	local plc = Vector(127, 127, 127)
	local wpc = Vector(127, 127, 127)
	
	playcol = ply:GetInfo("cl_playercolor")
	plc = Vector(playcol)
	
	weapcol = ply:GetInfo("cl_weaponcolor")
	wpc = Vector(weapcol)
	
	--wpc = Vector(math.Round(weapcol.x, 0), math.Round(weapcol.y, 0), math.Round(weapcol.z, 0))
	
	t1c.x = math.Clamp(ply:GetInfoNum("cl_drc_tint1_r", 127), 8, 255)
	t1c.y = math.Clamp(ply:GetInfoNum("cl_drc_tint1_g", 127), 8, 255)
	t1c.z = math.Clamp(ply:GetInfoNum("cl_drc_tint1_b", 127), 8, 255)
	
	t2c.x = math.Clamp(ply:GetInfoNum("cl_drc_tint2_r", 127), 8, 255)
	t2c.y = math.Clamp(ply:GetInfoNum("cl_drc_tint2_g", 127), 8, 255)
	t2c.z = math.Clamp(ply:GetInfoNum("cl_drc_tint2_b", 127), 8, 255)
	
	eyc.x = math.Clamp(ply:GetInfoNum("cl_drc_eyecolour_r", 127), 8, 255)
	eyc.y = math.Clamp(ply:GetInfoNum("cl_drc_eyecolour_g", 127), 8, 255)
	eyc.z = math.Clamp(ply:GetInfoNum("cl_drc_eyecolour_b", 127), 8, 255)
	
	enc.x = math.Clamp(ply:GetInfoNum("cl_drc_energycolour_r", 127), 8, 255)
	enc.y = math.Clamp(ply:GetInfoNum("cl_drc_energycolour_g", 127), 8, 255)
	enc.z = math.Clamp(ply:GetInfoNum("cl_drc_energycolour_b", 127), 8, 255)

	plc.x = math.Clamp(plc.x, 0.032, 1)
	plc.y = math.Clamp(plc.y, 0.032, 1)
	plc.z = math.Clamp(plc.z, 0.032, 1)
	
	wpc.x = math.Clamp(wpc.x, 0.032, 1)
	wpc.y = math.Clamp(wpc.y, 0.032, 1)
	wpc.z = math.Clamp(wpc.z, 0.032, 1)
	
	ply:SetNWVector( "PlayerColour_DRC", plc)
	ply:SetNWVector( "WeaponColour_DRC", wpc)
	ply:SetNWVector( "ColourTintVec1", t1c)
	ply:SetNWVector( "ColourTintVec2", t2c)
	ply:SetNWVector( "EyeTintVec", eyc)
	ply:SetNWVector( "EnergyTintVec", enc / 255)
	
	ply:SetPlayerColor(plc)
	ply:SetWeaponColor(wpc)
	
	local hands = ply:GetHands()
	if !IsValid(hands) then return end
	
	hands:SetNWVector( "PlayerColour_DRC", plc)
	hands:SetNWVector( "WeaponColour_DRC", wpc)
	hands:SetNWVector( "ColourTintVec1", t1c)
	hands:SetNWVector( "ColourTintVec2", t2c)
	hands:SetNWVector( "EyeTintVec", eyc)
	hands:SetNWVector( "EnergyTintVec", enc)
	
	local vm = ply:GetViewModel()
	if !IsValid(vm) then return end
	vm:SetNWVector( "PlayerColour_DRC", plc)
	vm:SetNWVector( "WeaponColour_DRC", wpc)
	vm:SetNWVector( "ColourTintVec1", t1c)
	vm:SetNWVector( "ColourTintVec2", t2c)
	vm:SetNWVector( "EyeTintVec", eyc)
	vm:SetNWVector( "EnergyTintVec", enc)
	
	plc = Vector()
	wpc = Vector()
	t1c = Vector()
	t2c = Vector()
	eyc = Vector()
	enc = Vector()
	
	return
end
concommand.Add("drc_refreshcolours", DRC:UpdatePlayerColours())

function DRC:RefreshColours(ply)
	DRC:UpdatePlayerColours(ply)
end

function DRC:AddText(ply, varargs)
	net.Start("DRCNetworkedAddText")
	net.WriteTable(varargs)
	net.Send(ply)
end

function DRC:EmitSound(source, near, far, distance, hint, listener)
	if !source then return end
	if near == nil && far == nil then return end
	if near == "" && far == "" then return end
--	if far == nil && near != nil then source:EmitSound(near) return end
	
	if isvector(source) && near then
		sound.Play(near, source)
	else
		if IsValid(source) && near && (SERVER && IsFirstTimePredicted()) then source:EmitSound(near, nil, nil, nil, nil, nil, nil) end
	end

	if CLIENT then return end
	net.Start("DRCSound")
	net.WriteEntity(source)
	if distance then net.WriteFloat(distance) end
	if near then net.WriteString(near) end
	if far then net.WriteString(far) end
	if listener then net.Send(listener) else net.Broadcast() end
	
	if distance && hint then sound.EmitHint(hint, source:GetPos(), math.Rand(distance/5, distance), 0.25, source) end
end

function DRC:TraceAngle(start, nd)
	return (nd - start):Angle()
end

function DRC:Interact(ply, ent, movement, mouse)
	if !IsValid(ply) then return end
	if !ply:Alive() then return end
	
	if IsValid(ent) then ply:SetNWEnt("Interacted_Entity", ent) end
	if movement == nil then movement = false end
	if mouse == nil then mouse = false end
	ply:SetNWBool("Interacting", true)
	ply:SetNWBool("Interacting_StopMovement", movement)
	ply:SetNWBool("Interacting_StopMouse", mouse)
	ply:SetNWAngle("Interacting_EyeAngle", ply:EyeAngles())
end

function DRC:BreakInteraction(ply, ent)
	if IsValid(ent) then ply:SetNWEnt("Interacted_Entity", nil) end
	ply:SetNWBool("Interacting", false)
	ply:SetNWBool("Interacting_StopMovement", false)
	ply:SetNWBool("Interacting_StopMouse", false)
end

function DRC:ProjectedTexture(ent, att, tbl)
	if !IsValid(ent) or att == nil then return end
	local attnum = ent:LookupAttachment(att)
	if attnum == -1 then return end
	local attinfo = ent:GetAttachment(attnum)
	local light = nil
	if tbl.Ent == nil then tbl.Ent = "draconic_ptex_base" end
	if SERVER then
		light = ents.Create(tbl.Ent)
	else
		light = ents.CreateClientside(tbl.Ent)
	end
	light:Spawn()
	light:SetParent(ent, attnum)
	
	light.Texture 		= tbl.Texture
	light.NearZ 		= tbl.NearZ
	light.FarZ 			= tbl.FarZ
	light.FOV			= tbl.FOV
	light.DrawShadows 	= tbl.DrawShadows
	
	return light
end

function DRC:RemoveAttachedLights(ent)
	for k,v in pairs(ent:GetChildren()) do
		if IsValid(v) then
			if v.Draconic && v.IsLight then v:Remove() end
		end
	end
end

function DRC:GiveAttachment(ply, att)
	if CLIENT then return end
	if !ply then return end
	if !att then return end
	if !ply.DRCAttachmentInventory then ply.DRCAttachmentInventory = {} end
	
	if istable(att) then 
		table.Inherit(ply.DRCAttachmentInventory, att)
	else
		if !table.HasValue(ply.DRCAttachmentInventory, att) then table.insert(ply.DRCAttachmentInventory, att) end
	end
	
	net.Start("DRC_WeaponAttachSyncInventory")
	net.WriteTable(ply.DRCAttachmentInventory)
	net.Send(ply)
end

function DRC:HasAttachment(ply, att)
	if table.HasValue(ply.DRCAttachmentInventory, att) then return true else return false end
end

function DRC:FormatViewModelAttachment(nFOV, vOrigin, bFrom --[[= false]])
	local vEyePos = EyePos()
	local aEyesRot = EyeAngles()
	local vOffset = vOrigin - vEyePos
	local vForward = aEyesRot:Forward()

	local nViewX = math.tan(nFOV * math.pi / 360)

	if (nViewX == 0) then
		vForward:Mul(vForward:Dot(vOffset))
		vEyePos:Add(vForward)
		
		return vEyePos
	end

	-- FIXME: LocalPlayer():GetFOV() should be replaced with EyeFOV() when it's binded
	local nWorldX = math.tan(LocalPlayer():GetFOV() * math.pi / 360)

	if (nWorldX == 0) then
		vForward:Mul(vForward:Dot(vOffset))
		vEyePos:Add(vForward)
		
		return vEyePos
	end

	local vRight = aEyesRot:Right()
	local vUp = aEyesRot:Up()

	if (bFrom) then
		local nFactor = nWorldX / nViewX
		vRight:Mul(vRight:Dot(vOffset) * nFactor)
		vUp:Mul(vUp:Dot(vOffset) * nFactor)
	else
		local nFactor = nViewX / nWorldX
		vRight:Mul(vRight:Dot(vOffset) * nFactor)
		vUp:Mul(vUp:Dot(vOffset) * nFactor)
	end

	vForward:Mul(vForward:Dot(vOffset))

	vEyePos:Add(vRight)
	vEyePos:Add(vUp)
	vEyePos:Add(vForward)

	return vEyePos
end

function DRC:GetSWLightMod()
	if !SW then return nil end
	
	local thyme = SW.Time
	if !thyme then return nil end
	
	local mulval = DRC.SWModVal
	if thyme < 4.5 && thyme > 0 then mulval = Vector(0.05, 0.1, 0.2)
	elseif thyme < 5 && thyme > 4.5 then mulval = Vector(0.4, 0.4, 0.2)
	elseif thyme < 7 && thyme > 5 then mulval = Vector(0.4, 0.4, 0.4)
	elseif thyme < 9 && thyme > 7 then mulval = Vector(0.8, 0.8, 0.8)
	elseif thyme < 11.8 && thyme > 9 then mulval = Vector(0.7, 0.7, 0.7)
	elseif thyme < 13.35 && thyme > 11.8 then mulval = Vector(0.7, 0.7, 1)
	elseif thyme < 16 && thyme > 13.35 then mulval = Vector(0.6, 0.6, 0.6)
	elseif thyme < 18.75 && thyme > 16 then mulval = Vector(0.4, 0.4, 0.4)
	elseif thyme < 20 && thyme > 18.75 then mulval = Vector(0.4, 0.4, 0.3)
	elseif thyme < 22 && thyme > 20 then mulval = Vector(0.4, 0.4, 0.3)
	elseif thyme < 24 && thyme > 22 then mulval = Vector(0.05, 0.15, 0.34) end
	
	DRC.SWModVal = LerpVector(FrameTime() * 0.25, DRC.SWModVal or mulval, mulval)
	return DRC.SWModVal
end

function DRC:EyeCone(ply, dist, degree)
	if !ply then return end
	if !dist then dist = 1000 end
	degree = math.cos(math.rad(degree))
	
	local cone = ents.FindInCone( ply:EyePos(), ply:GetAimVector(), dist, degree )
	return cone
end

function DRC:GetRoomSizeDSP(size) -- an experiment
	local tab = DRC.RoomDefinitions
	if size <= tab.Vent then return 106
	elseif size > tab.Vent && size <= tab.Small then return 104
	elseif size > tab.Small && size <= tab.Regular then return 105
	elseif size > tab.Regular && size <= tab.Large then return 125
	elseif size > tab.Large && size <= tab.Outdoors then return 113
	elseif size > tab.Outdoors then return 129 end
end

function DRC:GetRoomSizeName(size)
	local tab = DRC.RoomDefinitions
	if !tab then return end
	if !size then return end
	if size <= tab.Vent then return "Vent"
	elseif size > tab.Vent && size <= tab.Small then return "Small"
	elseif size > tab.Small && size <= tab.Regular then return "Regular"
	elseif size > tab.Regular && size <= tab.Large then return "Large"
	elseif size > tab.Large && size <= tab.Outdoors then return "Outdoors"
	elseif size > tab.Outdoors then return "Valley" end
end

function DRC:RoomSize(pos)
	if !IsValid(pos) then return end
	if IsEntity(pos) then
		if DRC:IsCharacter(pos) then
			pos = pos:EyePos()
		else
			pos = pos:GetPos()
		end
	end
	
	local score = 0
	
	for i=0,4 do
		local angy = 90*i
		local angx = 0
		if i == 0 then angx = -90 end
		
		local trace = util.TraceLine({
			start = pos,
			endpos = Angle(angx, angy, 0):Forward() * 10000,
			filter = function(ent) if IsEntity(pos) then
				if ent == pos then return false else return true end
			end end
		})
		
		local dist = math.Round(trace.StartPos:Distance(trace.HitPos))
		
		score = score + dist
		if i == 4 then
			score = score / 5
			return score
		end
	end
end

-- Credit: Kinyom -- https://github.com/Kinyom -- https://github.com/Facepunch/garrysmod-requests/issues/1779
-- anything I slapped "drc" onto is just to ensure it remains unique and doesn't risk being incompatible with anything you may have written or used this in.
if CLIENT then
	local drc_LUMP_CUBEMAPS = 42 -- THIS is the juicy stuff
	 
	drc_cubeLookup = {}
	DRC.MapInfo.Cubemaps = {}
	 
	function DRC_CollectCubemaps( filename )
		local bsp = file.Open( "maps/" .. filename .. ".bsp", "rb", "GAME" )
		
		local ident = bsp:ReadLong()
		if (ident ~= 1347633750) then
			bsp:Close()
			return
		end
		local version = bsp:ReadLong()
		
		local lumpinfo = {}
		for i=0, drc_LUMP_CUBEMAPS do
			lumpinfo[i] = {}
			lumpinfo[i].fileofs = bsp:ReadLong()
			lumpinfo[i].filelen = bsp:ReadLong()
			lumpinfo[i].version = bsp:ReadLong()
			lumpinfo[i].uncompressedSize = bsp:ReadLong()
		end
		
		bsp:Seek( lumpinfo[42].fileofs)
		
		drc_cubesamples = {}
		local sizeof_drc_cubesamples = 16
		
		for i=0, lumpinfo[42].filelen/sizeof_drc_cubesamples - 1 do
			local sampleOrigin = Vector( bsp:ReadLong(), bsp:ReadLong(), bsp:ReadLong() )
			
			local size = bsp:ReadLong()
			table.insert( drc_cubesamples, sampleOrigin )
		end
		
		bsp:Close()
		
		for i=1, lumpinfo[42].filelen/sizeof_drc_cubesamples do
			local pos = drc_cubesamples[i]
			local str = string.format( "maps/%s/c%i_%i_%i", filename, pos.x, pos.y, pos.z )
			drc_cubeLookup[str] = { pos, render.GetLightColor( pos ) }
			drc_cubeLookup[str .. ".hdr"] = drc_cubeLookup[str]
			DRC.MapInfo.Cubemaps[i] = {["mat"] = "".. str ..".hdr" or str, ["pos"] = pos}
		end
	end

	hook.Add( "InitPostEntity", "DRC_GetCubemapInfo", function()
		DRC_CollectCubemaps(game.GetMap())
	end )
end
-- end cubemap collection code

function DRC:GetEnvmap(src)
	if !DRC.MapInfo.Cubemaps[1] then DRC_CollectCubemaps(game.GetMap()) end
--	if #drc_cubeLookup == 0 or #drc_cubeLookup > 1000 then return nil end
	local pos
	if IsEntity(src) then pos = src:GetPos() + src:OBBCenter() else pos = src end
	local d = function(st) return pos:DistToSqr(st) end --math.abs(st.x - pos.x) + math.abs(st.y - pos.y) end
	table.sort(DRC.MapInfo.Cubemaps, function(a,b) return d(a.pos) < d(b.pos) end)
	return DRC.MapInfo.Cubemaps[1].mat
end

function DRC:DLight(ent, pos, col, size, lifetime, emissive, debugcolourmultiplier, style)
	local HDR = render.GetHDREnabled()

	if emissive == nil then emissive = false end
	if !debugcolourmultiplier then debugcolourmultiplier = 1 end
	if IsEntity(ent) then ent = ent:EntIndex() end
	local dl = DynamicLight(ent, emissive)
	dl.pos = pos
	dl.r = col.r
	dl.g = col.g
	dl.b = col.b
	dl.brightness = col.a
	dl.Decay = (1000 / lifetime)
	dl.size = size
	dl.Style = style
	dl.DieTime = CurTime() + lifetime
	
	if HDR == false && emissive == false then
		local el = DynamicLight(ent, true)
		el.pos = pos
		el.r = col.r
		el.g = col.g
		el.b = col.b
		el.brightness = col.a
		el.Decay = (1000 / lifetime)
		el.size = size
		el.Style = style
		el.DieTime = CurTime() + lifetime
	end
	
	if CLIENT && GetConVarNumber("cl_drc_debugmode") >= 1 && debugcolourmultiplier then
		DRC:IDLight(pos, col, size, debugcolourmultiplier, FrameTime() * 3)
	end
end

function DRC:GetSpray(ply, dowrite)
--	if !IsValid(ply) then return end
	if SERVER then print("DRC:GetSpray() is a CLIENT ONLY function.") return end

	if dowrite == true then
		local sprayfile = ply:GetPlayerInfo().customfiles[1]
		local userdata, userdatafolders = file.Find("user_custom/*", "DOWNLOAD")
		local spray, folder = nil, nil
		for k,v in pairs(userdatafolders) do
			if spray != nil then return end
			local spraytable = file.Find("user_custom/".. v .."/".. sprayfile ..".dat", "DOWNLOAD")
			if !table.IsEmpty(spraytable) then spray = spraytable[1] end
			if spray != nil then 
				if !file.Exists("draconic", "DATA") then file.CreateDir("draconic") end
				if !file.Exists("draconic/sprays", "DATA") then file.CreateDir("draconic/sprays") end
				spray = ("download/user_custom/".. v .."/".. spraytable[1] .."")
				
				sprayvtf = file.Read(spray, "GAME")
				file.Write("draconic/sprays/".. ply:SteamID64() ..".vtf", sprayvtf)
			end
		end
	end
	
	local vtf = "draconic/sprays/".. ply:SteamID64() ..""
	return vtf
end

function DRC:GetSubMaterials(ent)
	local mats = {}
	for i=0,#ent:GetMaterials() do
		mats[i] = ent:GetSubMaterial(i)
	end
	return mats
end

net.Receive("DRC_RequestSprayInfo", function()
	for k,v in pairs(player.GetAll()) do
		if v.SprayIndexed == true then return end
	--	if v.SprayIndexed != true then
			local spray = DRC:GetSpray(v, true)
			local tbl = {v, spray}
			
		--	timer.Simple(1, function()
				local sprayfile = nil
				
				if !file.Exists("draconic", "DATA") then file.CreateDir("draconic") end
				if !file.Exists("draconic/sprays", "DATA") then file.CreateDir("draconic/sprays") end
				if !file.Exists("draconic/sprays/".. v:SteamID64() ..".vtf", "DATA") then DRC:GetSpray(v, true) end
				
				if game.SinglePlayer() then
					sprayfile = ("materials/vgui/logos/spray.vtf")
				else
					sprayfile = ("draconic/sprays/".. v:SteamID64() ..".vtf")
				end
				if !file.Exists("draconic/sprays/".. v:SteamID64() ..".vtf", "DATA") then return end
				local vtf = file.Open(sprayfile, "rb", "DATA")
				if !IsValid(vtf) or !vtf or vtf == nil then
					if !file.Exists("draconic", "DATA") then file.CreateDir("draconic") end
					if !file.Exists("draconic/sprays", "DATA") then file.CreateDir("draconic/sprays") end
					DRC:GetSpray(v, true)
					vtf = file.Open(sprayfile, "rb", "DATA")
				end
				if !IsValid(vtf) or !vtf then return end
				vtf:Skip(24)
				local frames = vtf:ReadUShort()
				v.DRCSprayFrames = frames
				v.SprayIndexed = true
		--	end)
	--	end
	end
end)

hook.Add("PlayerInitialSpawn", "drc_InitialSpawnHook", function(ply)
	ply.SprayIndexed = false
	ply.DRCSprayFrames = 1
	net.Start("DRC_RequestSprayInfo")
	net.Broadcast()
	
	net.Start("DRC_MapVersion")
	
	local bsp = file.Open( "maps/" .. game.GetMap() .. ".bsp", "rb", "GAME" )
	bsp:Seek(4)
	local ver = bsp:ReadByte()
	bsp:Close()
	-- game.GetMapVersion() seems to be broken at the time of writing this
	
	local info = { ply, ver }
	net.WriteTable(info)
	net.Send(ply)
	
	timer.Simple(0, function()
		if !file.Exists("draconic", "DATA") then file.CreateDir("draconic") end
		local ftu = file.Read("draconic/reflectionmodifiers.json", "DATA")
		if ftu then
			local tbl = util.JSONToTable(ftu)
			
			net.Start("DRC_ReflectionModifier")
			net.WriteFloat(tbl[string.lower(game.GetMap())] or 1)
			net.Send(ply)
		end
	end)
end)

hook.Add("PlayerSpawn", "drc_DoPlayerSettings", function(ply)
	DRC:RefreshColours(ply)
	ply.DRCAttachmentInventory = {}
	ply:SetNWBool("Interacting", false)
	ply:SetNWString("Draconic_ThirdpersonForce", nil)
	ply:SetNWBool("ShowSpray_Ents", ply:GetInfoNum("cl_drc_showspray", 0))
	ply:SetNWBool("ShowSpray_Weapons", ply:GetInfoNum("cl_drc_showspray_weapons", 0))
	ply:SetNWBool("ShowSpray_Vehicles", ply:GetInfoNum("cl_drc_showspray_vehicles", 0))
	ply:SetNWBool("ShowSpray_Player", ply:GetInfoNum("cl_drc_showspray_player", 0))
	ply:SetNWInt("DRC_GunSpreadMod", 1)
	ply:SetNWInt("DRC_GunDamageMod", 1)
	ply:SetNWInt("DRC_MeleeDamageMod", 1)
	ply:SetNWInt("DRC_ShieldHealth_Extra", 0)
	ply:SetNWBool("DRC_ShieldInvulnerable", false)
	ply:SetNWFloat("DRC_VoiceSetDSP", 0)
	ply:SetNWInt("DRCVoiceSet_Enforced", "None")
	ply:SetNWInt("DRCFootsteps_Enforced", "None")
	
	DRC:SetVoiceSet(ply, ply:GetInfo("cl_drc_voiceset"), false)
	DRC:SetFootsteps(ply, ply:GetInfo("cl_drc_footstepset"), false)
	
	net.Start("DRC_RequestSprayInfo")
	net.Broadcast()
	
	timer.Simple(engine.TickInterval(), function()
		if IsValid(ply) then
			ply:SetNWString("DRC_SpawnModel", ply:GetModel())
			net.Start("DRC_UpdatePlayerHands")
			net.Send(ply)
			
			net.Start("DRC_WeaponAttachSyncInventory")
			net.WriteTable(ply.DRCAttachmentInventory)
			net.Send(ply)
		end
	end)
	
--[[	local hands = ply:GetHands()
	if !hands then return end
	local hbg = hands:GetBodyGroups()
	
	local convar = GetConVar("cl_playerbodygroups")
	hands:SetBodyGroups(convar) --]]
end)

hook.Add("StartCommand", "drc_InteractionBlocks", function(ply, cmd)
	local bool1 = ply:GetNWBool("Interacting")
	local bool2 = ply:GetNWBool("Interacting_StopMovement")
	local bool3 = ply:GetNWBool("Interacting_StopMouse")
	local ent = ply:GetNWEntity("Interacted_Entity", ply)
	
	if bool1 then
		if cmd:KeyDown(IN_ATTACK) then
			if IsValid(ent) && IsValid(ent.PrimaryAttack) then ent:PrimaryAttack() end
			cmd:RemoveKey(IN_ATTACK)
		end
		if cmd:KeyDown(IN_ATTACK2) then cmd:RemoveKey(IN_ATTACK2) end
		if cmd:KeyDown(IN_RELOAD) then cmd:RemoveKey(IN_RELOAD) end
		if cmd:KeyDown(IN_WEAPON1) then cmd:RemoveKey(IN_WEAPON1) end
		if cmd:KeyDown(IN_WEAPON2) then cmd:RemoveKey(IN_WEAPON2) end
		if cmd:KeyDown(IN_GRENADE1) then cmd:RemoveKey(IN_GRENADE1) end
		if cmd:KeyDown(IN_GRENADE2) then cmd:RemoveKey(IN_GRENADE2) end
	end
	if bool2 then
		cmd:SetForwardMove(0)
		cmd:SetSideMove(0)
		cmd:SetUpMove(0)
		if cmd:KeyDown(IN_MOVELEFT) then cmd:RemoveKey(IN_MOVELEFT) end
		if cmd:KeyDown(IN_MOVERIGHT) then cmd:RemoveKey(IN_MOVERIGHT) end
		if cmd:KeyDown(IN_FORWARD) then cmd:RemoveKey(IN_FORWARD) end
		if cmd:KeyDown(IN_BACK) then cmd:RemoveKey(IN_BACK) end
	end
	if bool3 then
		ply:SetEyeAngles(ply:GetNWAngle("Interacting_EyeAngle"))
	end
end)

hook.Add("PlayerDroppedWeapon", "drc_Unreadyweapon", function(ply, wpn)
	if !IsValid(ply) or !IsValid(wpn) then return end
	
	if wpn.Draconic != nil then
		wpn.Readied = false
		wpn:SetNWBool("Readied", false)
	end
end)

-- ayylmao a high enough ping can make some stuff in :Holster() and :OnRemove() not work because Source loves controlling stuff server-side
-- also :Holster() and :OnRemove() logically don't apply when an NPC dies lol
hook.Add("DoPlayerDeath", "drc_PlayerDeathEvents", function(ply, attacker, dmg)
	if !IsValid(ply) then return end
	
	timer.Simple(0.1, function()
		DRC:RefreshColours(ply)
	end)
	
	local wpn = ply:GetActiveWeapon()
	if !IsValid(wpn) then return end
	if wpn.Draconic == nil then return end
	
	if wpn.PickupOnly == true && wpn.DoNotDrop != true then ply:DropWeapon(wpn) end
	
	if wpn.ChargeSound == nil then return end
	if wpn.Primary.LoopingFireSound == nil then return end
	if wpn.LoopFireSound == nil then return end
	
	wpn:StopSound(wpn.ChargeSound)
	wpn:StopSound(wpn.Primary.LoopingFireSound)
	wpn.LoopFireSound:Stop()
end)

hook.Add("PlayerSwitchWeapon", "drc_stfu2", function(ply, ow, nw)
	if !IsValid(ply) then return end
	
	local wpn = ow
	if !IsValid(wpn) then return end
	if wpn.Draconic == nil then return end
	if wpn.IsMelee == true then return end
	if wpn.ChargeSound == nil then return end
	if wpn.Primary.LoopingFireSound == nil then return end
	if wpn.LoopFireSound == nil then return end
	
	wpn:StopSound(wpn.ChargeSound)
	wpn:StopSound(wpn.Primary.LoopingFireSound)
	wpn.LoopFireSound:Stop()
end)

hook.Add("OnNPCKilled", "drc_stfu3", function(npc) -- why does this trigger for nextbots?
	if !IsValid(npc) then return end
	
	local wpn = nil
	if npc:IsNPC() then
		wpn = npc:GetActiveWeapon()
	elseif npc:IsNextBot() then
		wpn = npc.Weapon
	end
	
	if isnumber(wpn) then return end
	if !IsValid(wpn) then return end
	if !IsEntity(wpn) then return end
	if wpn.Draconic == nil then return end
	if wpn.IsMelee == true then return end
	if wpn.ChargeSound == nil then return end
	if wpn.Primary.LoopingFireSound == nil then return end
	if wpn.LoopFireSound == nil then return end
	
	wpn:StopSound(wpn.ChargeSound)
	wpn:StopSound(wpn.Primary.LoopingFireSound)
	wpn.LoopFireSound:Stop()
end)

hook.Add("CreateClientsideRagdoll", "drc_playerragdollcolours", function(ply, rag)
	if !IsValid(ply) then return end
	
	local colours = GetDRCColours(ply)
	rag:SetNWVector("PlayerColour_DRC", colours.Player)
	rag:SetNWVector("WeaponColour_DRC", colours.Weapon)
	rag:SetNWVector("EyeTintVec", colours.Eye)
	rag:SetNWVector("EnergyTintVec", colours.Energy)
	rag:SetNWVector("ColourTintVec1", colours.Tint1)
	rag:SetNWVector("ColourTintVec2", colours.Tint2)
end)

hook.Add("CreateEntityRagdoll", "drc_playerragdollcolours", function(ply, rag)
	if !IsValid(ply) then return end
	
	local colours = GetDRCColours(ply)
	rag:SetNWVector("PlayerColour_DRC", colours.Player)
	rag:SetNWVector("WeaponColour_DRC", colours.Weapon)
	rag:SetNWVector("EyeTintVec", colours.Eye)
	rag:SetNWVector("EnergyTintVec", colours.Energy)
	rag:SetNWVector("ColourTintVec1", colours.Tint1)
	rag:SetNWVector("ColourTintVec2", colours.Tint2)
end)

hook.Add("PlayerTick", "drc_movementhook", function(ply) -- holy fuck I need to rewrite this someday
	if DRC.SV.drc_movement == 0 then return end
	local wpn = ply:GetActiveWeapon()
	local cv = ply:Crouching()
	local forwkey = ply:KeyDown(IN_FORWARD)
	local backkey = ply:KeyDown(IN_BACK)
	local leftkey = ply:KeyDown(IN_MOVELEFT)
	local rightkey = ply:KeyDown(IN_MOVERIGHT)
	local sprintkey = ply:KeyDown(IN_SPEED)
	local swimming = ply:WaterLevel() >= 3
	local dry = ply:WaterLevel() <=2
		
		local ogs = ply:GetNWFloat("PlayerOGSpeed")
		local ogw = ply:GetNWFloat("PlayerOGWalk")
		local ogj = ply:GetNWFloat("PlayerOGJump")
		local ogc = ply:GetNWFloat("PlayerOGCrouch")
		
		if ogs == nil or ogs == 0 then return end
		if ogw == nil or ogw == 0 then return end
		if ogj == nil or ogj == 0 then return end
		if ogc == nil or ogc == 0 then return end
		
		if wpn.Draconic == nil then return end
		if not IsValid(ply) or not ply:Alive() then return end
	
		if cv == true then
		if swimming then
		
		elseif dry then
			if forwkey && !sprintkey then
			if wpn.SpeedCrouchForward != nil then
				ply:SetWalkSpeed( wpn.SpeedCrouchForward )
				ply:SetRunSpeed( wpn.SpeedCrouchForward )
				if wpn.CrouchingJumpHeightFront != nil then
					ply:SetJumpPower( wpn.CrouchingJumpHeightFront )
				elseif wpn.CrouchingJumpHeightFront != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedCrouchForward != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.CrouchingJumpHeightFront != nil then
					ply:SetJumpPower( wpn.CrouchingJumpHeightFront )
				elseif wpn.CrouchingJumpHeightFront != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif backkey && !sprintkey then
			if wpn.SpeedCrouchBack != nil then
				ply:SetWalkSpeed( wpn.SpeedCrouchBack )
				ply:SetRunSpeed( wpn.SpeedCrouchBack )
				if wpn.CrouchingJumpHeightBack != nil then
					ply:SetJumpPower( wpn.CrouchingJumpHeightBack )
				elseif wpn.CrouchingJumpHeightBack != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedCrouchBack != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.CrouchingJumpHeightBack != nil then
					ply:SetJumpPower( wpn.CrouchingJumpHeightBack )
				elseif wpn.CrouchingJumpHeightBack != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif leftkey && !sprintkey then
			if wpn.SpeedCrouchLeft != nil then
				ply:SetWalkSpeed( wpn.SpeedCrouchLeft )
				ply:SetRunSpeed( wpn.SpeedCrouchLeft )
				if wpn.CrouchingJumpHeightLeft != nil then
					ply:SetJumpPower( wpn.CrouchingJumpHeightLeft )
				elseif wpn.CrouchingJumpHeightLeft != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedCrouchLeft != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.CrouchingJumpHeightLeft != nil then
					ply:SetJumpPower( wpn.CrouchingJumpHeightLeft )
				elseif wpn.CrouchingJumpHeightLeft != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif rightkey && !sprintkey then
			if wpn.SpeedCrouchRight != nil then
				ply:SetWalkSpeed( wpn.SpeedCrouchRight )
				ply:SetRunSpeed( wpn.SpeedCrouchRight )
				if wpn.CrouchingJumpHeightRight != nil then
					ply:SetJumpPower( wpn.CrouchingJumpHeightRight )
				elseif wpn.CrouchingJumpHeightRight != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedCrouchRight != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.CrouchingJumpHeightRight != nil then
					ply:SetJumpPower( wpn.CrouchingJumpHeightRight )
				elseif wpn.CrouchingJumpHeightRight != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif forwkey && sprintkey then
			if wpn.SpeedSprintCrouchForward != nil then
				ply:SetWalkSpeed( wpn.SpeedSprintCrouchForward )
				ply:SetRunSpeed( wpn.SpeedSprintCrouchForward )
				if wpn.StandingSprintJumpHeightFront != nil then
					ply:SetJumpPower( wpn.CrouchingSprintJumpHeightFront )
				elseif wpn.StandingSprintJumpHeightFront != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedCrouchForward != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				if wpn.StandingSprintJumpHeightFront != nil then
					ply:SetJumpPower( wpn.StandingSprintJumpHeightFront )
				elseif wpn.StandingSprintJumpHeightFront != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
			end
			elseif backkey && sprintkey then
			if wpn.SpeedSprintCrouchBack != nil then
				ply:SetWalkSpeed( wpn.SpeedSprintCrouchBack )
				ply:SetRunSpeed( wpn.SpeedSprintCrouchBack )
				if wpn.CrouchingSprintJumpHeightBack != nil then
					ply:SetJumpPower( wpn.CrouchingSprintJumpHeightBack )
				elseif wpn.CrouchingSprintJumpHeightBack != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedCrouchBack != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.CrouchingSprintJumpHeightBack != nil then
					ply:SetJumpPower( wpn.CrouchingSprintJumpHeightBack )
				elseif wpn.CrouchingSprintJumpHeightBack != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif leftkey && sprintkey then
			if wpn.SpeedSprintCrouchLeft != nil then
				ply:SetWalkSpeed( wpn.SpeedSprintCrouchLeft )
				ply:SetRunSpeed( wpn.SpeedSprintCrouchLeft )
				if wpn.CrouchingSprintJumpHeightLeft != nil then
					ply:SetJumpPower( wpn.CrouchingSprintJumpHeightLeft )
				elseif wpn.CrouchingSprintJumpHeightLeft != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedCrouchLeft != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.CrouchingSprintJumpHeightLeft != nil then
					ply:SetJumpPower( wpn.CrouchingSprintJumpHeightLeft )
				elseif wpn.CrouchingSprintJumpHeightLeft != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif rightkey && sprintkey then
			if wpn.SpeedSprintCrouchRight != nil then
				ply:SetWalkSpeed( wpn.SpeedSprintCrouchRight )
				ply:SetRunSpeed( wpn.SpeedSprintCrouchRight )
				if wpn.CrouchingSprintJumpHeightRight != nil then
					ply:SetJumpPower( wpn.CrouchingSprintJumpHeightRight )
				elseif wpn.CrouchingSprintJumpHeightRight != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedCrouchRight != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.CrouchingSprintJumpHeightRight != nil then
					ply:SetJumpPower( wpn.CrouchingSprintJumpHeightRight )
				elseif wpn.CrouchingSprintJumpHeightRight != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			end
		end
		elseif cv == false then
		if swimming then
		
		elseif dry then
			if forwkey && !sprintkey then
			if wpn.SpeedStandForward != nil then
				ply:SetWalkSpeed( wpn.SpeedStandForward )
				ply:SetRunSpeed( wpn.SpeedStandForward )
				if wpn.StandingJumpHeightFront != nil then
					ply:SetJumpPower( wpn.StandingJumpHeightFront )
				elseif wpn.StandingJumpHeightFront != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedStandForward != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.StandingJumpHeightFront != nil then
					ply:SetJumpPower( wpn.StandingJumpHeightFront )
				elseif wpn.StandingJumpHeightFront != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif backkey && !sprintkey then
			if wpn.SpeedStandBack != nil then
				ply:SetWalkSpeed( wpn.SpeedStandBack )
				ply:SetRunSpeed( wpn.SpeedStandBack )
				if wpn.StandingJumpHeightBack != nil then
					ply:SetJumpPower( wpn.StandingJumpHeightBack )
				elseif wpn.StandingJumpHeightBack != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedStandBack != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.StandingJumpHeightBack != nil then
					ply:SetJumpPower( wpn.StandingJumpHeightBack )
				elseif wpn.StandingJumpHeightBack != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif leftkey && !sprintkey then
			if wpn.SpeedStandLeft != nil then
				ply:SetWalkSpeed( wpn.SpeedStandLeft )
				ply:SetRunSpeed( wpn.SpeedStandLeft )
				if wpn.StandingJumpHeightLeft != nil then
					ply:SetJumpPower( wpn.StandingJumpHeightLeft )
				elseif wpn.StandingJumpHeightLeft != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedStandLeft != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.StandingJumpHeightLeft != nil then
					ply:SetJumpPower( wpn.StandingJumpHeightLeft )
				elseif wpn.StandingJumpHeightLeft != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif rightkey && !sprintkey then
			if wpn.SpeedStandRight != nil then
				ply:SetWalkSpeed( wpn.SpeedStandRight )
				ply:SetRunSpeed( wpn.SpeedStandRight )
				if wpn.StandingJumpHeightRight != nil then
					ply:SetJumpPower( wpn.StandingJumpHeightRight )
				elseif wpn.StandingJumpHeightRight != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedStandRight != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.StandingJumpHeightRight != nil then
					ply:SetJumpPower( wpn.StandingJumpHeightRight )
				elseif wpn.StandingJumpHeightRight != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif forwkey && sprintkey then
			if wpn.SpeedSprintStandForward != nil then
				ply:SetWalkSpeed( wpn.SpeedStandForward )
				ply:SetRunSpeed( wpn.SpeedSprintStandForward )
				if wpn.StandingSprintJumpHeightFront != nil then
					ply:SetJumpPower( wpn.StandingSprintJumpHeightFront )
				elseif wpn.StandingSprintJumpHeightFront != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedSprintStandForward != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.StandingSprintJumpHeightFront != nil then
					ply:SetJumpPower( wpn.StandingSprintJumpHeightFront )
				elseif wpn.StandingSprintJumpHeightFront != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif backkey && sprintkey then
			if wpn.SpeedSprintStandBack != nil then
				ply:SetWalkSpeed( wpn.SpeedStandBack )
				ply:SetRunSpeed( wpn.SpeedSprintStandBack )
				if wpn.StandingSprintJumpHeightBack != nil then
					ply:SetJumpPower( wpn.StandingSprintJumpHeightBack )
				elseif wpn.StandingSprintJumpHeightBack != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedSprintStandBack != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.StandingSprintJumpHeightBack != nil then
					ply:SetJumpPower( wpn.StandingSprintJumpHeightBack )
				elseif wpn.StandingSprintJumpHeightBack != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif leftkey && sprintkey then
			if wpn.SpeedSprintStandLeft != nil then
				ply:SetWalkSpeed( wpn.SpeedStandLeft )
				ply:SetRunSpeed( wpn.SpeedSprintStandLeft )
				if wpn.StandingSprintJumpHeightLeft != nil then
					ply:SetJumpPower( wpn.StandingSprintJumpHeightLeft )
				elseif wpn.StandingSprintJumpHeightLeft != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedSprintStandLeft != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.StandingSprintJumpHeightLeft != nil then
					ply:SetJumpPower( wpn.StandingSprintJumpHeightLeft )
				elseif wpn.StandingSprintJumpHeightLeft != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif rightkey && sprintkey then
			if wpn.SpeedSprintStandRight != nil then
				ply:SetWalkSpeed( wpn.SpeedStandRight )
				ply:SetRunSpeed( wpn.SpeedSprintStandRight )
				if wpn.StandingSprintJumpHeightRight != nil then
					ply:SetJumpPower( wpn.StandingSprintJumpHeightRight )
				elseif wpn.StandingSprintJumpHeightRight != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedSprintStandRight != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.StandingSprintJumpHeightRight != nil then
					ply:SetJumpPower( wpn.StandingSprintJumpHeightRight )
				elseif wpn.StandingSprintJumpHeightRight != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			end
		end
		end
		
	if DRC.SV.drc_movesounds == 1 then
	if ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_FORWARD) && ply:KeyPressed(IN_SPEED) && wpn.DoSSCrouchFwd == true then
	-- crouch sprint sound forward
		ply:EmitSound( wpn.SprintSoundCrouch )
	elseif ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_BACK) && ply:KeyPressed(IN_SPEED) && wpn.DoSSCrouchBack == true then
	-- crouch sprint sound back
		ply:EmitSound( wpn.SprintSoundCrouch )
	elseif ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_MOVELEFT) && ply:KeyPressed(IN_SPEED) && wpn.DoSSCrouchLeft == true then
	-- crouch sprint sound left
		ply:EmitSound( wpn.SprintSoundCrouch )
	elseif ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_MOVERIGHT) && ply:KeyPressed(IN_SPEED) && wpn.DoSSCrouchRight == true then
	-- crouch sprint sound right
		ply:EmitSound( wpn.SprintSoundCrouch )
	end
		
	if ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_FORWARD) && ply:KeyPressed(IN_JUMP) && ply:KeyDown(IN_SPEED) && wpn.DoSJCrouchSFwd == true then
	-- Crouch Sprint Jump Sound Front
		ply:EmitSound( wpn.SJumpCrouchSound )
	elseif ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_BACK) && ply:KeyPressed(IN_JUMP) && ply:KeyDown(IN_SPEED) && wpn.DoSJCrouchSBack == true then
	-- Crouch Sprint Jump Sound Front
		ply:EmitSound( wpn.SJumpCrouchSound )
	elseif ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_MOVELEFT) && ply:KeyPressed(IN_JUMP) && ply:KeyDown(IN_SPEED) && wpn.DoSJCrouchLeft == true then
	-- Crouch Sprint Jump Sound Front
		ply:EmitSound( wpn.SJumpCrouchSound )
	elseif ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_MOVERIGHT) && ply:KeyPressed(IN_JUMP) && ply:KeyDown(IN_SPEED) && wpn.DoSJCrouchRight == true then
	-- Crouch Sprint Jump Sound Front
		ply:EmitSound( wpn.SJumpCrouchSound )
	end
	else end	
		if wpn.FallDamage == false && wpn.NoFallDamageCrouchOnly == true then
		if cv == true then
			wpn.Owner.ShouldReduceFallDamage = true
		elseif  cv == false then
			wpn.Owner.ShouldReduceFallDamage = false
		end
		elseif wpn.FallDamage == false && wpn.NoFallDamageCrouchOnly == false then
		wpn.Owner.ShouldReduceFallDamage = true
		elseif wpn.FallDamage == true then
		wpn.Owner.ShouldReduceFallDamage = false
		end
end)

function DRC:CallGesture(ply, slot, act, akill)
	if !SERVER then return end
	if !IsValid(ply) then return end
	if !slot or slot == "" or slot == nil then slot = GESTURE_SLOT_CUSTOM end
	if !act then return end
	if !akill or akill == "" or akill == nil then akill = true end
	
--	local nt = {}
--	nt.Player = ply
--	nt.Slot = slot
--	nt.Activity = act
--	nt.Autokill = akill
	
	if !ply:IsPlayer() then
		timer.Simple(engine.TickInterval(), function()
			if ply.RestartGesture then ply:RestartGesture(act, true, akill) end
		end)
	end
	
	net.Start("DRCNetworkGesture")
	net.WriteEntity(ply)
	net.WriteFloat(slot)
	net.WriteFloat(act)
	net.WriteBool(akill)
	net.SendPVS(ply:EyePos())
end

function DRC:CopyLayerSequenceInfo(layer, ent1, ent2)
	ent2:SetLayerSequence(layer, ent1:GetLayerSequence(layer))
	ent2:SetLayerDuration(layer, ent1:GetLayerDuration(layer))
	ent2:SetLayerPlaybackRate(layer, ent1:GetLayerPlaybackRate(layer))
	ent2:SetLayerWeight(layer, ent1:GetLayerWeight(layer))
	ent2:SetLayerCycle(layer, ent1:GetLayerCycle(layer))
end

function DRC:CopyPoseParams(ent1, ent2)
		if SERVER then
			for i=0,ent1:GetNumPoseParameters()-1 do
				local poseparam = ent1:GetPoseParameterName(i)
				ent2:SetPoseParameter(poseparam, ent1:GetPoseParameter(poseparam))
			end
		else
			for i=0,ent1:GetNumPoseParameters()-1 do
				local mini, maxi = ent1:GetPoseParameterRange(i)
				local poseparam = ent1:GetPoseParameterName(i)
				ent2:SetPoseParameter(poseparam, math.Remap(ent1:GetPoseParameter(poseparam), 0, 1, mini, maxi))
			end
		end
	end

local function PlayReadyAnim(ply, anim)
	if !IsValid(ply) then 
		DRC:Notify(nil, nil, "critical", "Player entity is null?! Something might be seriously wrong with your gamemode, that's all I know!", ENUM_ERROR, 10)
	return end
	
	local seq = ply:SelectWeightedSequence(anim)
	local dur = ply:SequenceDuration(seq)
	
	local wpn = ply:GetActiveWeapon()
	
	--if ply.DrcLastWeaponSwitch == nil then ply.DrcLastWeaponSwitch = CurTime() end
	
	if IsValid(ply) then
		DRC:CallGesture(ply, GESTURE_SLOT_CUSTOM, anim, true)
	--	ply.DrcLastWeaponSwitch = CurTime() + dur
		
	--	if SERVER then
	--		net.Start("OtherPlayerWeaponSwitch")
	--		net.WriteEntity(ply)
	--		net.WriteString(anim)
	--		net.Broadcast()
	--	end
	end
end

hook.Add( "PlayerSwitchWeapon", "drc_weaponswitchanim", function(ply, ow, nw)
	if !SERVER then return end
	local neww = nw:GetClass()
	
	if ow.PickupOnly == true then
		ply:DropWeapon(ow)
		if ow.LoopFireSound != nil then ow.LoopFireSound:Stop() end
		local notif = true
		if nw:IsScripted() then
			ply:DropWeapon(nw)
			ply:PickupWeapon(nw)
			ply:SelectWeapon(nw)
		end
		if ow:IsScripted() then
			if ow.PickupOnly == true then
				if ow.LoopFireSound != nil then ow.LoopFireSound:Stop() end
				ply:DropWeapon(ow)
			else
				if ow.LoopFireSound != nil then ow.LoopFireSound:Stop() end
				ply:DropWeapon(ow)
				ply:PickupWeapon(ow)
			end
		end -- holy shit why can there not just be a select weapon function that is predicted/shared?
	end
	
	if nw.NoReadyAnimation != true then
		if neww == "gmod_camera" or neww == "gmod_tool" then -- bruh
			if nw:GetClass() == "gmod_camera" then PlayReadyAnim(ply, DRC.HoldTypes.melee.deploy) else PlayReadyAnim(ply, DRC.HoldTypes.pistol.deploy) end
		elseif nw:IsScripted() then
			local newstats = weapons.GetStored(neww)
			local newht = string.lower(tostring(newstats.HoldType))
			
			if nw.ASTWTWO == true then
				if nw.Melee == true then newht = newstats.HoldType_Lowered end
				if nw.Melee != true then newht = newstats.HoldType_Hipfire end
			end
			
			if DRC.HoldTypes[newht] then PlayReadyAnim(ply, DRC:GetHoldTypeAnim(newht, "deploy", false)) end
		else
			if DRC.HoldTypes.HardcodedWeapons[neww] then PlayReadyAnim(ply, DRC:GetHoldTypeAnim(DRC.HoldTypes.HardcodedWeapons[neww], "deploy", false)) end
		end
	end
end)

net.Receive("OtherPlayerWeaponSwitch", function(len, ply)
	local ply = net.ReadEntity()
	local anim = net.ReadString()
	
	PlayReadyAnim(ply, anim)
end)

net.Receive("DRC_Nuke", function(len, ply)
	local ent = net.ReadEntity()
	if !IsValid(ent) then return end
	if !ent:IsAdmin() then
		if SERVER then DRC:CheaterWarning(ply, "This player's client attempted to call the 'DRC_Nuke' net message but they aren't an admin! This is a known (and now patched) exploit which has been reported implemented into a few scripts.") end
	return end
	if ply:IsAdmin() then 
		for k,v in pairs(ents.GetAll()) do
			if v:IsNPC() or v:IsNextBot() or v:GetClass() == "prop_physics" or v:GetClass() == "prop_physics_multiplayer" then v:TakeDamage(999999999, ent) v:Remove()
			elseif v:IsPlayer() then v:ScreenFade(SCREENFADE.IN, Color(255, 255, 255), 3, 0)
			end
		end
	end
end)

net.Receive("DRC_MapVersion", function(len, ply)
	local tab = net.ReadTable()
	local ver = tab[2]
	
	DRC.MapInfo.Version = ver
end)


local CubeCheckTime = 0
hook.Add("Tick", "drc_CubeMapAntiFail", function()
	if !CLIENT then return end
	if drc_cubesamples then hook.Remove("Tick", "drc_CubeMapAntiFail") return end
	if CurTime() < CubeCheckTime then return end
	
	if !drc_cubesamples then
		CubeCheckTime = CurTime() + 5
		DRC_CollectCubemaps( game.GetMap() )
	end
end)

DraconicAmmoTypes = {}
function DRC:AddAmmoType(tbl)
	table.insert(DraconicAmmoTypes, tbl)
end

local batteryammo = {
	Name = "ammo_drc_battery",
	Text = "Don't give yourself this ammo. It will only break your weapons.",
	DMG = DMG_BULLET,
	DamagePlayer = 0,
	DamageNPC = 0,
	Tracer = TRACER_LINE_AND_WHIZ,
	Force = 500,
	SplashMin = 5,
	SplashMax = 10,
	MaxCarry = 100,
}
DRC:AddAmmoType(batteryammo)

function DRC:RefreshAmmoTypes()
	for k,v in pairs(DraconicAmmoTypes) do
		if !istable(v) then DRC:Notify(nil, nil, "critical", "Someone put a non-table into the Draconic ammo registry, aborting.", ENUM_ERROR, 10) return end
		if !v.Name then DRC:Notify(nil, nil, "critical", "Ammo Registry - Name not defined for ammo type, aborting.", ENUM_ERROR, 10) return end
		if !v.Text then DRC:Notify(nil, nil, "critical", "Ammo Registry - Text not set for ".. v.Name ..", Assigning stupid text for you to realize your mistake.", ENUM_ERROR, 10) v.Name = "YOU DIDN'T GIVE ME A NAME" end
		if !v.DMG then v.DMG = DMG_BULLET end
		if !v.Tracer then v.DMG = TRACER_LINE_AND_WHIZ end
		if !v.DamagePlayer then v.DamagePlayer = 0 end
		if !v.DamageNPC then v.DamageNPC = 0 end
		if !v.Force then v.Force = 500 end
		if !v.SplashMin then v.SplashMin = 5 end
		if !v.SplashMax then v.SplashMax = 10 end
		if !v.MaxCarry then DRC:Notify(nil, nil, "critical", "Ammo Registry - MaxCarry not defined for ".. v.Name ..", Setting to 9999.", ENUM_ERROR, 10) v.MaxCarry = 9999 end
	
		if CLIENT then
			language.Add("" ..v.Name .."_ammo", v.Text)
		end

		game.AddAmmoType({
			name = v.Name,
			dmgtype = v.DMG,
			tracer = v.Tracer,
			plydmg = v.DamagePlayer,
			npcdmg = v.DamageNPC,
			force = v.Force,
			minsplash = v.SplashMin,
			maxsplash = v.SplashMax,
			maxcarry = v.MaxCarry
		})
	end
end

hook.Add("Initialize", "drc_SetupAmmoTypes", function()
	DRC:RefreshAmmoTypes()
end)

function DRC:SurfacePropToEnum(str)
	local prefix = "MAT_"
	local newstring = "".. prefix .."".. string.upper(str) ..""
	return newstring
end

function DRC:GetHGMul(ent, hg, dinfo)
	local infl = dinfo:GetInflictor()
	if infl.DraconicProjectile == true then infl = infl:GetCreator() end
	local BaseProfile = scripted_ents.GetStored("drc_abp_generic")
	local BT = infl.ActiveAttachments.AmmunitionTypes.t.BulletTable
	local DT = infl.ActiveAttachments.AmmunitionTypes.t.BulletTable.HitboxDamageMuls
	local BBT = BaseProfile.t.BulletTable
	local BDT = BBT.HitboxDamageMuls
	
	local mul, enum = 1, HITGROUP_GENERIC
	local TTP = DT
	
	if hg == HITGROUP_HEAD then enum = "HITGROUP_HEAD"
	elseif hg == HITGROUP_CHEST then enum = "HITGROUP_CHEST"
	elseif hg == HITGROUP_STOMACH then enum = "HITGROUP_STOMACH"
	elseif hg == HITGROUP_LEFTARM then enum = "HITGROUP_LEFTARM"
	elseif hg == HITGROUP_RIGHTARM then enum = "HITGROUP_RIGHTARM"
	elseif hg == HITGROUP_LEFTLEG then enum = "HITGROUP_LEFTLEG"
	elseif hg == HITGROUP_RIGHTLEG then enum = "HITGROUP_RIGHTLEG"
	elseif hg == HITGROUP_GEAR then enum = "HITGROUP_GEAR" end
	
	if DT == nil or DT[enum] == nil then
		TTP = BDT
	end
	
	mul = TTP[enum]
	return mul
end

hook.Add("ScalePlayerDamage", "drc_locationalscale_ply", function(ent, hg, dinfo)
	local infl = dinfo:GetInflictor()
	if !infl.Draconic then return end
	local mul = DRC:GetHGMul(ent, hg, dinfo)
	
	if mul == nil then mul = 1 end
	
	dinfo:ScaleDamage(mul)
end)
hook.Add("ScaleNPCDamage", "drc_locationalscale_npc", function(ent, hg, dinfo)
	local infl = dinfo:GetInflictor()
	if !infl.Draconic then return end
	local mul = DRC:GetHGMul(ent, hg, dinfo)
	
	if mul == nil then mul = 1 end
	
	dinfo:ScaleDamage(mul)
end)
	-- Half-Life 2 scaling still applies to these, hard-coded.
	-- Some hl2 NPCs have custom scripted damage muls, e.g. rebels & Alyx headshot damage
	-- Head: 3x
	-- Chest:1x
	-- Stomach: 0.8x
	-- Arms & legs: 0.2x
	-- Gear: 0.01x

function DRC:DynamicParticle(source, magnitude, distance, special, target)
	if !special then return end
	local pos = source
	if IsEntity(pos) then pos = pos:GetPos() + pos:OBBCenter() end
	
	local function GetEffect(name)
		local str = DRC:SurfacePropToEnum(util.GetSurfacePropName(name))
		local effe = DRC.SurfacePropDefinitions[str]
		if !effe then return end
		return effe
	end
	
	local function DoEffect(tab, data)
		if !tab then return end
		for k,v in pairs(tab) do
			local part = "drc_".. v ..""
			util.Effect(part, data)
		end
	end
	
	local ed = EffectData()
	ed:SetMagnitude(magnitude)
	
	if special == "blast" then
		local N = DRC:TraceDir(source, Angle(0, 0, 0), distance)
		local S = DRC:TraceDir(source, Angle(0, 180, 0), distance)
		local E = DRC:TraceDir(source, Angle(0, -90, 0), distance)
		local W = DRC:TraceDir(source, Angle(0, 90, 0), distance)
		local U = DRC:TraceDir(source, Angle(-90, 0, 0), distance)
		local D = DRC:TraceDir(source, Angle(90, 0, 0), distance)
		local TraceTable = {N, S, E, W, U, D}
		
		for k,v in pairs(TraceTable) do
			if v.Hit then
				if v.HitSky then return end
				ed:SetOrigin(v.HitPos)
				ed:SetNormal(v.HitNormal)
				ed:SetMagnitude(ed:GetMagnitude()/4 * (1 - v.Fraction))
				DoEffect(GetEffect(v.SurfaceProps), ed)
			end
		end
	end
end

function DRC:EnvelopTrace(ent1, ent2, expensive)
	if !IsValid(ent1) or !IsValid(ent2) then return end
	if ent1 == ent2 then return end
	if ent2:GetParent() == ent1 then return end
	if ent1:IsWeapon() or ent2:IsWeapon() then return end
	if expensive == nil then expensive = false end
	
	if expensive == false then
		local tr = util.TraceLine({
			start = ent1:GetPos() + ent1:OBBCenter(),
			endpos = ent2:GetPos() + ent2:OBBCenter(),
			filter = function(ent) if ent == ent1 then return false else return true end end
		})
		
		local ang = tr.Normal:Angle()
		
		local tr2 = util.TraceLine({
			start = ent1:GetPos() + ang:Forward() * 10,
			endpos = ent2:GetPos() + ent2:OBBCenter() + ang:Forward() * 250,
			filter = function(ent) if ent == ent1 then return false else return true end end
		})
		
		local tr3
		if ent1:LookupAttachment("eyes") > 0 then
			local start = ent1:GetAttachment(ent1:LookupAttachment("eyes")).Pos
			tr3 = util.TraceLine({
				start = start + ang:Forward() * 10,
				endpos = ent2:GetPos() + ent2:OBBCenter() + ang:Forward() * 250,
				filter = function(ent) if ent == ent1 then return false else return true end end
			})
		end
		
		if tr then DRC:RenderTrace(tr, Color(255, 255, 255, 255), FrameTime()) end
		if tr2 then DRC:RenderTrace(tr2, Color(255, 255, 255, 255), FrameTime()) end
		if tr3 then DRC:RenderTrace(tr3, Color(255, 255, 255, 255), FrameTime()) end
		
		if (tr2.Hit && tr2.Entity == ent2) or (tr.Hit && tr.Entity == ent2) or (tr3 && tr3.Hit && tr3.Entity == ent2) then return true else return false end
	else
	end
end

function DRC:TraceDir(origin, dir, dist, entitytolookfor)
	if origin == nil then print("TraceDir origin is null!") return end
	local entity = nil
	if !isvector(origin) && DRC:IsCharacter(origin) then
		entity = origin
		origin = origin:EyePos()
	elseif IsEntity(origin) then
		entity = origin
		origin = origin:GetPos()
	end
	
	if !entitytolookfor then entitytolookfor = Entity(0) end
	
	if dir == nil then dir = Angle(0, 0, 0) end
	if dist == nil then dist = 6942069 end
	
	local tr = util.TraceLine({
		start = origin,
		endpos = origin + dir:Forward() * dist,
		filter = function( ent )
			if ent == entitytolookfor then return true end
			if ent:IsPlayer() or ent == entity then return false end
			if ( !ent:IsPlayer() && ent:GetPhysicsObject() != nil or ent:IsWorld() ) then return true end
		end
	})
	
	if tr.Hit && !SERVER && GetConVarNumber("cl_drc_debugmode") >= 1 && GetConVarNumber("cl_drc_debug_tracelines") >= 1 then
		if !gui.IsGameUIVisible() then
		local csent1 = ClientsideModel("models/editor/axis_helper.mdl")
		local csent2 = ClientsideModel("models/editor/axis_helper.mdl")
		csent1:SetMaterial("models/wireframe")
		csent2:SetMaterial("models/wireframe")
		csent1:SetPos(tr.HitPos)
		csent2:SetPos(tr.StartPos)
		csent1:SetColor(Color(255, 0, 0, 255))
		csent2:SetColor(Color(0, 255, 0, 255))
		csent1:Spawn()
		csent2:Spawn()
		timer.Simple(FrameTime(), function() csent1:Remove() csent2:Remove() end)
		DRC:RenderTrace(tr, Color(255, 255, 0, 255), FrameTime())
		end
	end
	
	return tr
end

function DRC:GetBones(ent)
	local bt = {}
	local count = ent:GetBoneCount()
				
	for i=0,count do
		local name = tostring(ent:GetBoneName(i))
		bt[name] = {}
		bt[name].Pos = ent:GetBonePosition(i)
		bt[name].Ang = ent:GetBonePosition(i)
	end
	return bt
end

function DRC:GetBodyGroups(ent)
	local tbl = {}
	for k,v in pairs(ent:GetBodyGroups()) do
		tbl[k] = ent:GetBodygroup(v.id)
	end
	return tbl
end

function DRC:IsVehicle(ent)
	if !IsValid(ent) then return false end
	if ent:IsVehicle() or ent:GetClass() == "gmod_sent_vehicle_fphysics_base" or ent:GetClass() == "npc_helicopter" or ent:GetClass() == "npc_combinegunship" or ent.LFS or ent.LVS or ent.Base == "haloveh_base" or ent.Base == "ma2_mech" or ent.Base == "ma2_battlesuit" then return true else return false end
end

function DRC:IsCharacter(ent)
	if ent:IsPlayer() == true then return true end
	if ent:IsNPC() == true then return true end
	if ent:IsNextBot() == true then return true end
	return false
end

if SERVER then
	function DRC:SetShieldInfo(ent, bool, tbl)
		if !IsValid(ent) then return end
		if bool == nil then bool = false end
		
		if bool == true then
			ent.BloodEnum = tbl.Effects.BloodEnum
			ent:SetNWInt("DRC_ShieldHealth", tbl.Health)
			ent:SetNWInt("DRC_ShieldMaxHealth", tbl.Health)
			ent:SetNWInt("DRC_ShieldRechargeDelay", tbl.RegenDelay)
			ent:SetNWInt("DRC_ShieldRechargeAmount", tbl.RegenAmount)
			ent:SetNWBool("DRC_Shielded", true)
			ent:SetNWBool("DRC_Shield_AlwaysGlow", tbl.AlwaysVisible)
			ent:SetNWBool("DRC_Shield_Recharges", tbl.Regenerating)
			ent:SetNWBool("DRC_RechargeShield", false)
			ent:SetNWBool("DRC_ShieldDown", false)
			ent:SetNWString("DRC_Shield_ImpactSound", tbl.Sounds.Impact)
			ent:SetNWString("DRC_Shield_DepleteSound", tbl.Sounds.Deplete)
			ent:SetNWString("DRC_Shield_RechargeSound", tbl.Sounds.Recharge)
			ent:SetNWString("DRC_Shield_ImpactEffect", tbl.Effects.Impact)
			ent:SetNWString("DRC_Shield_DepleteEffect", tbl.Effects.Deplete)
			ent:SetNWString("DRC_Shield_RechargeEffect", tbl.Effects.Recharge)
			ent:SetNWString("DRC_Shield_Material", tbl.Material)
			ent:SetNWInt("DRC_Shield_PingScale", tbl.ScaleMin)
			ent:SetNWInt("DRC_Shield_PingScale_Min", tbl.ScaleMin)
			ent:SetNWInt("DRC_Shield_PingScale_Max", tbl.ScaleMax)
			
			-- These options were added post-conception and need a validity check
			if !tbl.OverMaterial then tbl.OverMaterial = "models/vuthakral/shield_over_example" end
			ent:SetNWString("DRC_Shield_OverMaterial", tbl.OverMaterial)
			if !tbl.ArmourRequirement then tbl.ArmourRequirement = false end
			ent:SetNWBool("DRC_Shield_RechargeRequiresArmour", tbl.ArmourRequirement) -- not implemented yet
			
			timer.Simple(engine.TickInterval(), function()
				net.Start("DRC_MakeShieldEnt")
				net.WriteEntity(ent)
				net.Broadcast()
			end)
		else
			ent:SetNWBool("DRC_Shielded", false)
			ent:SetNWInt("DRC_ShieldHealth", 0)
			ent:SetNWInt("DRC_ShieldMaxHealth", 0)
		end
	end
	
	function DRC:ShieldEffects(ent, dinfo)
		local hp, maxhp = DRC:GetShield(ent)
			
		if hp > 0 then
			DRC:EmitSound(ent, ent:GetNWString("DRC_Shield_ImpactSound"), nil, 1500)
			local ed = EffectData()
			ed:SetOrigin(dinfo:GetDamagePosition())
			ed:SetStart(dinfo:GetDamagePosition())
			ed:SetEntity(ent)
			util.Effect(ent:GetNWString("DRC_Shield_ImpactEffect"), ed)
		elseif hp <= 0 && ent:GetNWBool("DRC_ShieldDown") == false then
			DRC:EmitSound(ent, ent:GetNWString("DRC_Shield_DepleteSound"), nil, 1500)
			local ed = EffectData()
			ed:SetOrigin(ent:GetPos() + ent:OBBCenter())
			ed:SetStart(ent:GetPos() + ent:OBBCenter())
			ed:SetEntity(ent)
			util.Effect(ent:GetNWString("DRC_Shield_DepleteEffect"), ed)
		end
	end
	
	function DRC:PingShield(ent, scale)
		ent:SetNWInt("DRC_ShieldVisibility", 1)
		timer.Simple(1, function()
			for i=0,9 do
				timer.Simple(i*0.1, function() ent:SetNWInt("DRC_ShieldVisibility", ent:GetNWInt("DRC_ShieldVisibility") - 0.1) end)
			end
		end)
		
		if scale == true then
			ent:SetNWInt("DRC_Shield_PingScale", ent:GetNWInt("DRC_Shield_PingScale_Max"))
			timer.Simple(0.5, function() ent:SetNWInt("DRC_Shield_PingScale", ent:GetNWInt("DRC_Shield_PingScale_Min")) end)
		end
	end
	
	function DRC:AddShield(ent, amount)
		if !IsValid(ent) then return end
		ent:SetNWInt("DRC_ShieldHealth", math.Clamp(ent:GetNWInt("DRC_ShieldHealth") + amount, 0, ent:GetNWInt("DRC_ShieldMaxHealth")))
		DRC:PingShield(ent, false)
	end
	
	function DRC:SubtractShield(ent, amount)
		if !IsValid(ent) then return end
		local shieldhp = ent:GetNWInt("DRC_ShieldHealth")
		local overshieldhp = ent:GetNWInt("DRC_ShieldHealth_Extra")
		if shieldhp <= 0 then ent:SetNWBool("DRC_ShieldDown", true) end
		if ent.DoCustomShieldHit then tgt:DoCustomShieldHit(dmg) end
		
		if overshieldhp <= 0 then
			ent:SetNWInt("DRC_ShieldHealth", math.Clamp(ent:GetNWInt("DRC_ShieldHealth") - amount, 0, ent:GetNWInt("DRC_ShieldMaxHealth")))
			ent:SetNWInt("DRC_Shield_DamageTime", CurTime() + ent:GetNWInt("DRC_ShieldRechargeDelay") - engine.TickInterval())
			timer.Simple(ent:GetNWInt("DRC_ShieldRechargeDelay"), function()
				if CurTime() > ent:GetNWInt("DRC_Shield_DamageTime") then
					ent:SetNWBool("DRC_ShieldDown", false)
					DRC:EmitSound(ent, ent:GetNWString("DRC_Shield_RechargeSound"), nil, 1500)
					local ed = EffectData()
					if !IsValid(ent) then return end
					ed:SetOrigin(ent:GetPos() + ent:OBBCenter())
					ed:SetStart(ent:GetPos() + ent:OBBCenter())
					ed:SetEntity(ent)
					util.Effect(ent:GetNWString("DRC_Shield_RechargeEffect"), ed)
				end
			end)
		else
			ent:SetNWInt("DRC_ShieldHealth_Extra", math.Clamp(ent:GetNWInt("DRC_ShieldHealth_Extra") - amount, 0, math.huge))
		end
		
		DRC:PingShield(ent, true)
	end
	
	function DRC:AddOverShield(ent, amount)
		if !IsValid(ent) then return end
		ent:SetNWInt("DRC_ShieldHealth_Extra", amount)
	end
	
	function DRC:AddOverShield_Mul(ent, times, cap)
		if !IsValid(ent) then return end
		if cap == nil then cap = 999999999 end
		ent:SetNWInt("DRC_ShieldHealth_Extra", math.Clamp(ent:GetNWInt("DRC_ShieldMaxHealth") * times, 0, cap))
	end
	
	function DRC:SetShieldInvulnerable(ent, thyme, mat)
		if !IsValid(ent) then return end
		if !ent:GetNWString("DRC_Shielded") then return end
		if mat == nil then mat = "models/vuthakral/shield_invuln_example" end
		
		ent:SetNWBool("DRC_ShieldInvulnerable", true)
		ent:SetNWString("DRC_Shield_InvulnMaterial", mat)
		timer.Simple(thyme, function() if IsValid(ent) then ent:SetNWBool("DRC_ShieldInvulnerable", false) end end)
	end
end

function DRC:PopShield(ent)
	if ent.DoCustomShieldBreak then tgt:DoCustomShieldBreak(dmg) end
	ent:SetNWInt("DRC_ShieldHealth", 0)
	ent:SetNWInt("DRC_ShieldHealth_Extra", 0)
--	ent:TakeDamage(0)
end

function DRC:GetShield(ent)
	if CLIENT then
		local val, maxi, ent = ent:GetNWInt("DRC_ShieldHealth"), ent:GetNWInt("DRC_ShieldMaxHealth"), ent.ShieldEntity
		return val, maxi, ent
	else
		local val, maxi = ent:GetNWInt("DRC_ShieldHealth"), ent:GetNWInt("DRC_ShieldMaxHealth")
		return val, maxi
	end
end

function DRC:GetOverShield(ent)
	local ovs = ent:GetNWInt("DRC_ShieldHealth_Extra")
	
	local shieldmax = ent:GetNWInt("DRC_ShieldMaxHealth")
	local meth, curmeth = 0, 0
	if ovs > 0 then
		meth = ovs/shieldmax
		curmeth = math.abs(math.floor(meth) - meth)
		if curmeth == 0 then curmeth = 1 end
	end
	
	if ovs <= 0 then return nil, 0, 0 else return ovs, math.ceil(meth), curmeth end
end

function DRC:GetShieldInvulnerability(ent)
	if ent:GetNWBool("DRC_ShieldInvulnerable") == true then return true else return false end
end

function DRC:RegisterFootSteps(fs)
	if !fs then return end
	local name = fs.ID

	DRC.FootSteps[name] = fs
end

--[[
local testfootsteps = {
	["ID"] = "testfootsteps",
	["Name"] = "Test set",
	["crouch"] = {
		["overlay"] = "",
	--	["default"] = "",
	},
	["walk"] = {
		["overlay"] = "",
	--	["default"] = "",
	},
	["run"] = {
		["overlay"] = "",
		["default"] = "player/footsteps/concrete1.wav",
	--	["stone"] = "",
	},
	["sprint"] = {
		["overlay"] = "",
	--	["default"] = "",
	},
	["shuffle"] = {
		["overlay"] = "",
		["default"] = "player/footsteps/concrete4.wav",
	},
}
DRC:RegisterFootSteps(testfootsteps)
]]

function DRC:GetFloorMat(ply)
	local pos2 = ply:GetPos()
	local ftrace = util.TraceLine({ start = pos2, endpos = pos2 - Vector(0,0,15), filter = function(ent) if ent == ply then return false else return true end end })
	local fmat
	
	if ftrace.Hit then fmat = ftrace.SurfaceProps end
	if !fmat then fmat = ply:GetTouchTrace().SurfaceProps end
	fmat = DRC:SurfacePropToEnum(util.GetSurfacePropName(fmat))
	return fmat
end

local fsmodes = {
	"run",
	"walk",
	"crouch",
	"sprint"
}

local fsvols = {
	0.45,
	0.4,
	0.35,
	0.75
}

local function ProcessInput(ply, shuffle, key)
	if !IsFirstTimePredicted() then return end
	local n,s,e,w = IN_FORWARD, IN_BACK, IN_MOVERIGHT, IN_MOVELEFT
	local inp = ply:KeyDown(n) or ply:KeyDown(s) or ply:KeyDown(e) or ply:KeyDown(w)
	
	if shuffle == true then
		if !inp then
			local set = DRC.FootSteps[DRC:GetFootsteps(ply)]
			ply:EmitSound(testfootsteps.shuffle.default)
		return 0 end
	end
	
	local walk, crouch, run = ply:KeyDown(IN_WALK), ply:Crouching(), ply:KeyDown(IN_SPEED)
	
	if inp && !crouch && !run && !walk then return 1 end -- standing movement
	if inp && walk && !run && !crouch then return 2 end -- standing walking
	if inp && crouch then return 3 end -- crouching movement
	if inp && run then return 4 end -- sprinting
end

local function SelectFootstep(ply, shuffle, fs, jump, wade, landing, overlay)
	if !fs or string.lower(fs) == "none" then return "" end
	local input = ProcessInput(ply)
	local fmat = DRC:GetFloorMat(ply)
	local sel, smat, subset, sel2, vol, om
	local set = DRC.FootSteps[fs]
	vol = fsvols[input] or 0.5
	local volm = fsmodes[input]
	if set.Volumes then volm = set.Volumes[volm] or 1 else volm = 1 end
	vol = vol * volm
	
	if wade then fmat = "MAT_WADE" end
	if !shuffle then subset = fsmodes[input]
	else subset = "shuffle" end
	if fmat == "MAT_DEFAULT_SILENT" then
		fmat = nil
		sel = ""
		sel2 = ""
	end
	
	if fmat then
		om = set.OverrideMode
		local ogsubset = subset
		if set[subset] == nil then subset = "run" end
		if set[subset][fmat] then sel = set[subset][fmat] end
		
		if !sel && om != 0 then
			smat = DRC.SurfacePropDefinitions[fmat][1]
			sel = smat or "default"
			smat = smat or "default"
			if !set[subset][sel] then sel = "default" end
			
			if shuffle then
				shuffle = "".. sel .."_shuffle"
				if landing && set[subset]["".. sel .."_land"] then shuffle = "".. sel .."_land" end
				if set[subset][shuffle] then sel = shuffle end
			end
			if jump then
				jump = "".. sel .."_jump"
				if set[subset][jump] then sel = jump else sel = "default_jump" end
			end
			if overlay then
				overlay = "".. sel .."_overlay"
				if set[subset][overlay] then sel2 = overlay else sel2 = "overlay" end
			end
			
			sel = set[subset][sel] or set[subset].default
			if !sel then sel = set[subset][sel] or set[subset].default end
			if !sel then sel = set.run[smat] or set.run.default end
			
			
		elseif sel then -- MAT_ override
			sel = fmat
			smat = DRC.SurfacePropDefinitions[fmat][1]
			smat = smat or "default"
			if shuffle then
				shuffle = "".. fmat .."_shuffle"
				if landing && set[subset]["".. fmat .."_land"] then shuffle = "".. fmat .."_land" end
				if set[subset][shuffle] then sel = shuffle end
			end
			if jump then
				jump = "".. fmat .."_jump"
				if set[subset][jump] then sel = jump else sel = "default_jump" end
			end
			if overlay then
				overlay = "".. fmat .."_overlay"
				if set[subset][overlay] then sel2 = overlay else sel2 = "overlay" end
			end
			
			sel = set[subset][sel] or set[subset].default
			if !sel then sel = set[subset][sel] or set[subset].default end
			if !sel then sel = set.run[smat] or set.run.default end
			
			sel = sel[math.Round(math.Rand(0.5, #sel))]
		end
		
		if !istable(sel2) then sel2 = set[subset][sel2] or set[subset].overlay end
		if istable(sel) then sel = sel[math.Round(math.Rand(0.5, #sel))] end
		if istable(sel2) then sel2 = sel2[math.Round(math.Rand(0.5, #sel2))] end
		
		if om == 0 then sel = "" end
		
		local finalvol
		if smat then finalvol = "".. smat .."_volume" else finalvol = 1 end
		if set[subset][finalvol] then vol = vol * set[subset][finalvol] end
	end
--	print(sel2)
	return sel, sel2, vol, om
end

hook.Add( "KeyRelease", "DRC_FootStepShuffle", function(ply, key)
	if SERVER then
	if key == IN_FORWARD or key == IN_BACK or key == IN_MOVERIGHT or key == IN_MOVELEFT then
		local n,s,e,w = IN_FORWARD, IN_BACK, IN_MOVERIGHT, IN_MOVELEFT
		local inp = ply:KeyDown(n) or ply:KeyDown(s) or ply:KeyDown(e) or ply:KeyDown(w)
		local fs = DRC:GetFootsteps(ply)
		if fs && !inp then
			local ss, so, vol, om = SelectFootstep(ply, true, fs, false, false, false, false)
			if !ply.fsshuffletime then ply.fsshuffletime = CurTime() end
			if ply.fsshuffletime + 0.2 < CurTime() && ply:OnGround() then
				ply.fsshuffletime = CurTime()
				timer.Simple(0.1, function()
					if IsValid(ply) then
						ply:EmitSound(ss)
						if ply:WaterLevel() >= 1 then
							ss, so, vol, om = SelectFootstep(ply, true, fs, ply:KeyPressed(IN_JUMP), true)
							ply:EmitSound(ss, vol)
						end
					end
				end)
			end
		end
	end
	end
end )

local wades = {
	["player/footsteps/wade1.wav"] = 0,
	["player/footsteps/wade2.wav"] = 0,
	["player/footsteps/wade3.wav"] = 0,
	["player/footsteps/wade4.wav"] = 0,
	["player/footsteps/wade5.wav"] = 0,
	["player/footsteps/wade6.wav"] = 0,
	["player/footsteps/wade7.wav"] = 0,
	["player/footsteps/wade8.wav"] = 0,
}
local wades2 = {
	"player/footsteps/wade1.wav",
	"player/footsteps/wade2.wav",
	"player/footsteps/wade3.wav",
	"player/footsteps/wade4.wav",
	"player/footsteps/wade5.wav",
	"player/footsteps/wade6.wav",
	"player/footsteps/wade7.wav",
	"player/footsteps/wade8.wav",
}

hook.Add("PlayerFootstep", "DRC_FootStepSets", function(ply, pos, foot, snd, vol, filt)
	if CLIENT or game.SinglePlayer() then
		local fs = DRC:GetFootsteps(ply)
		if fs then
			local ss, so, vol, om = SelectFootstep(ply, false, fs, ply:KeyPressed(IN_JUMP), false, false, true)
			local n,s,e,w = IN_FORWARD, IN_BACK, IN_MOVERIGHT, IN_MOVELEFT
			local inp = ply:KeyDown(n) or ply:KeyDown(s) or ply:KeyDown(e) or ply:KeyDown(w)
			vol = 100 * vol
			if ss then ply:EmitSound(ss, vol) end
			if so then ply:EmitSound(so, vol) end
			if ply:WaterLevel() >= 1 then
				local water = DRC.FootSteps[fs].run.water
				ss = SelectFootstep(ply, false, fs, ply:KeyPressed(IN_JUMP), true)
				if !water then ss = wades2[math.Round(math.Rand(0.5, #wades2))] end
				ply:EmitSound(ss, vol)
			end
			if om == 1 then return true end
		end
	end
end)

hook.Add("EntityEmitSound", "DRC_Footsteps_Wade", function(tbl)
	if tbl.Entity && tbl.Entity:IsPlayer() then
		local ply = tbl.Entity
		if !ply.fsshuffletime then ply.fsshuffletime = 0 end
		local fs = DRC:GetFootsteps(ply)
		if fs && DRC.FootSteps[fs].run.water then
			if wades[tbl.SoundName] then
				local ss = SelectFootstep(ply, true, fs, false, true)
				if ss then
					ply:EmitSound(ss)
				return false end
			end
		end
	end
end)

hook.Add("OnPlayerHitGround", "DRC_Footsteps_Landing", function(ply, water, floater, speed)
	if CLIENT or game.SinglePlayer() then
	local fs = DRC:GetFootsteps(ply)
	if fs then
		local n,s,e,w = IN_FORWARD, IN_BACK, IN_MOVERIGHT, IN_MOVELEFT
		local inp = ply:KeyDown(n) or ply:KeyDown(s) or ply:KeyDown(e) or ply:KeyDown(w)
		if !inp then 
			ply:StopSound("player/pl_fallpain1.wav")
			ply:StopSound("player/pl_fallpain3.wav")
			ss = SelectFootstep(ply, true, fs, false, false, true)
			if ss then ply:EmitSound(ss, vol) end
		end
	end
	end
end)

DRC.VoiceSetDefs = {
	["slot1"] = "RequestHelp",
	["slot2"] = "MoveIt",
	["slot3"] = "Compliment",
	["slot4"] = "Insult",
	["slot5"] = "Hello",
	["slot6"] = "Question",
	["slot7"] = "Agree",
	["slot8"] = "Disagree",
	["slot9"] = "Apologize",
	["+reload"] = "Reload",
	["spot"] = "Spotting",
}

DRC.VoiceSetResponses = {}
function DRC:RegisterVoiceSet(vs)
	if !vs then return end
	local name = vs.ID
	local responses = vs.Responses
	
	if responses then
		for k,v in pairs(responses) do
			for k,v in pairs(v) do -- omg please don't kill me
				DRC.VoiceSetResponses[tostring(k)] = true
			end
		end
	end
	
	DRC.VoiceSets[name] = vs
end

function DRC:RegisterVoiceSetDSPCopy(vs, dsp, subtitle)
	if !vs or !dsp then return end
	local newtab = table.Copy(vs)
	local name = newtab.ID
	newtab.DSP = dsp
	newtab.ID = "".. newtab.ID .."_".. dsp ..""
	name = newtab.ID
	newtab.Name = "".. newtab.Name .." (".. subtitle ..")"
	
	DRC.VoiceSets[name] = newtab
end

function DRC:VoiceSpot(ply)
	if !IsValid(ply) then return end
	local voice = DRC.VoiceSets[DRC:GetVoiceSet(ply)]
	local coneents = DRC:EyeCone(ply, 5000, 5)
	local targets = {}
	for k,v in pairs(coneents) do
		if (v:IsPlayer() && v != ply) or v:IsNPC() or v:IsNextBot() or DRC:IsVehicle(v) or v:IsRagdoll() then table.insert(targets, v) end
	end
	local closesttarget = nil
	for k,v in pairs(targets) do
		local dist = v:EyePos():DistToSqr(ply:EyePos())
		if k == 1 then
			closesttarget = {v, dist}
		else
			if dist < closesttarget[2] then closesttarget = {v, dist} end
		end
	end
	if !closesttarget then return nil end
	
	local target = closesttarget[1]:GetClass()
	if closesttarget[1]:IsRagdoll() then
		DRC:SpeakSentence(ply, "Spotting", "DeadBody", true)
	elseif closesttarget[1]:IsNPC() then
		local disp  = closesttarget[1]:Disposition(ply)
		if !DRC:IsVSentenceValid(DRC:GetVoiceSet(ply), "Spotting", target) then
			if disp < 3 then
				DRC:SpeakSentence(ply, "Spotting", "Generic_Enemy", true)
			else
				DRC:SpeakSentence(ply, "Spotting", "Generic_Friendly", true)
			end
		else
			DRC:SpeakSentence(ply, "Spotting", target, true)
		end
	elseif closesttarget[1]:IsNextBot() then
		if !voice["Spotting"][target] then
			DRC:SpeakSentence(ply, "Spotting", "Generic", true)
		end
	elseif closesttarget[1]:IsPlayer() then DRC:SpeakSentence(ply, "Spotting", "Generic", true)
	end
end

function DRC:GetVoiceSet(ent)
	local vs = ent:GetNWString("DRCVoiceSet")
	local enforced = ent:GetNWString("DRCVoiceSet_Enforced", "None")
	local tab = DRC.VoiceSets
	
	if enforced != "None" then vs = enforced end
	
	if ent:IsPlayer() then
		if ent:GetInfoNum("cl_drc_voiceset_automatic", 0) == 1 then
			local mdl = player_manager.TranslateToPlayerModelName(ent:GetModel())
			local val = DRC:GetPlayerModelValue(mdl, "VoiceSet")
			if IsValid(val) then vs = val end
		end
	end
	
	if vs == "none" or vs == nil or vs == "" then return nil end
	if !tab[vs] then return nil end
	return vs
end

function DRC:SetVoiceSet(ent, id, enforced)
	if !DRC.VoiceSets[id] then ent:SetNWString("DRCVoiceSet", "None") return end
	if !enforced then ent:SetNWString("DRCVoiceSet", id) end
	if enforced then timer.Simple(0, function() ent:SetNWString("DRCVoiceSet_Enforced", id) end) end
end

function DRC:IsVSentenceValid(vs, call, subcall, response)
	if !vs or vs == nil then return end
	local voice = DRC.VoiceSets[vs]
	if !subcall or subcall == nil then
		if voice[call] != nil then return true end
	elseif subcall then
		if voice[call] then
			if voice[call][subcall] then return true end
		end
	elseif response then
		if voice[call] then
			if voice[call][subcall] then 
				if voice[call][subcall][response] then return true end
			end
		end
	else return false
	end
end

function DRC:SpeakSentence(ent, call, subcall, important)
	if important == true or !important && !isstring(subcall) then ent.DRCSpeaking = false end
	if ent.DRCSpeaking == true then return end
	local num, rng, sel = nil, nil, nil
	local vs = DRC:GetVoiceSet(ent)
	if !vs then return end
	local voice = DRC.VoiceSets[DRC:GetVoiceSet(ent)]
	local dsp = voice.DSP
	local start, stop = voice.StartSound, voice.StopSound
	if subcall && isstring(subcall) then
		if !DRC:IsVSentenceValid(vs, call, subcall) then return end
		num = #voice[call][subcall]
		rng = math.Round(math.Rand(1, num))
		sel = voice[call][subcall][rng]
	else
		if !DRC:IsVSentenceValid(vs, call) then return end
		num = #voice[call]
		rng = math.Round(math.Rand(1, num))
		sel = voice[call][rng]
	end
	
	if sel then
		if ent:GetNWFloat("DRC_VoiceSetDSP", 0) != 0 then dsp = ent:GetNWFloat("DRC_VoiceSetDSP") end
		local dur, durstart, durend = SoundDuration(sel), 0, 0
		if start then
		--	durstart = SoundDuration(start)
		--	dur = dur + durstart
		--	ent:EmitSound(start)
		end
		ent.DRCSpeaking = true
		timer.Simple(durstart, function() if ent:IsValid() then ent:EmitSound(sel, nil, 100, 1, nil, SND_NOFLAGS, dsp) end end)
		timer.Simple(dur, function() 
			if ent:IsValid() then
				if stop then
				--	ent:EmitSound(stop)
				end
				ent.DRCSpeaking = false
			end
		end)
	end
end

function DRC:ResponseSentence(ent, trigger, response, delay)
	ent.DRCSpeaking = false
	local num, rng, sel = nil, nil, nil
	local vs = DRC:GetVoiceSet(ent)
	if !vs then return end
	local voice = DRC.VoiceSets[DRC:GetVoiceSet(ent)]
	local dsp = voice.DSP
	if !DRC:IsVSentenceValid(vs, "Responses", trigger, response) then return end
	num = #voice["Responses"][trigger][response]
	rng = math.Round(math.Rand(1, num))
	sel = voice["Responses"][trigger][response][rng]
	if sel then
		if ent:GetNWFloat("DRC_VoiceSetDSP", 0) != 0 then dsp = ent:GetNWFloat("DRC_VoiceSetDSP") end
		local dur = SoundDuration(sel), 0, 0
		ent.DRCSpeaking = true
		timer.Simple(delay, function() if ent:IsValid() then ent:EmitSound(sel, nil, 100, 1, nil, SND_NOFLAGS, dsp) end end)
		timer.Simple(dur, function() if ent:IsValid() then ent.DRCSpeaking = false end end)
	end
end

function DRC:IsDamageFriendly(dmg)
	if !IsValid(dmg) then return end
	local att, infl, vic = dmg:GetAttacker(), dmg:GetAttacker(), dmg:GetVictim()
	
	if att:IsPlayer() && vic:IsPlayer() then
		if att:Team() == vic:Team() then return true else return false end
	end
	
	if att:IsNPC() && vic:IsPlayer() then
		if att:Disposition(vic) >= 3 then return true else return false end
	end
end

function DRC:DamageSentence(ent, damage, dmg)
	if !IsValid(ent) then return end
	local hp, mhp = ent:Health(), ent:GetMaxHealth()
	local percentage, newhp = damage/mhp, hp - damage
	local attacker = dmg:GetAttacker()
	
	local function PostComplaint(dam, condition, attackerisnpc)
		local str, thyme = "Minor_Post", math.Rand(1, 3)
		
		local function GetString()
			if dam >= 0.2 then str = "Major_Post"
			elseif dam < 0.2 && dam >= 0.1 then str = "Medium_Post"
			elseif dam < 0.1 then str = "Minor_Post"
			end
			return str
		end
		str = GetString()
		local important = false
		if condition == "fall" then
			str = "Fall_".. str ..""
			thyme = math.Rand(0.1, 0.2)
			important = true
		elseif condition == "shock" then
			str = "Shock_".. str ..""
			thyme = 0
			important = true
		elseif condition == "fire" then
			str = "Fire_".. str ..""
			thyme = math.Rand(0.1, 0.2)
			important = true
		elseif condition == "acid" then
			str = "Acid_".. str ..""
		elseif condition == "radiation" then
			str = "Rad_".. str ..""
		elseif condition == "plasma" then
			str = "Plasma_".. str ..""
		elseif attackerisnpc == true && DRC:IsVSentenceValid(DRC:GetVoiceSet(ent), "Pain", attacker:GetClass()) then
			str = attacker:GetClass()
		end
		
		if DRC:IsDamageFriendly(dmg) then
			timer.Simple(thyme, function()
				if IsValid(ent) && ent:Health() > 0.01 then
					DRC:SpeakSentence(ent, "Reactions", "FriendlyFire", important)
				end
			end)
		else
			if DRC:IsVSentenceValid(DRC:GetVoiceSet(ent), "Pain", str) then 
				timer.Simple(thyme, function()
					if IsValid(ent) && ent:Health() > 0.01 then
						DRC:SpeakSentence(ent, "Pain", str, important)
					end
				end)
			else
				str = GetString()
				thyme = math.Rand(1, 3)
				timer.Simple(thyme, function()
					if IsValid(ent) && ent:Health() > 0.01 then
						DRC:SpeakSentence(ent, "Pain", str)
					end
				end)
			end
		end
	end
	
	local enum, conditionstring, npc = dmg:GetDamageType(), false, false
	if enum == DMG_FALL then conditionstring = "fall" end
	if enum == DMG_SHOCK then conditionstring = "shock" end
	if enum == DMG_SLOWBURN then conditionstring = "fire" end
	if enum == DMG_BURN then conditionstring = "fire" end
	if enum == DMG_DIRECT then conditionstring = "fire" end
	if enum == DMG_ACID then conditionstring = "acid" end
	if enum == DMG_RADIATION then conditionstring = "radiation" end
	if enum == DMG_PLASMA then conditionstring = "plasma" end
	if attacker then npc = true end
	
	if conditionstring == "fall" && DRC:IsVSentenceValid(DRC:GetVoiceSet(ent), "Pain", "Fall") && newhp > 0.0001 then
		if IsValid(ent) && ent:Health() > 0.01 then
			DRC:SpeakSentence(ent, "Pain", "Fall", true)
			PostComplaint(percentage, conditionstring)
		end
	return end

	if percentage >= 0.2 then
		DRC:SpeakSentence(ent, "Pain", "Major", true)
		PostComplaint(percentage, conditionstring, npc)
	elseif percentage < 0.2 && percentage >= 0.1 then
		DRC:SpeakSentence(ent, "Pain", "Medium", true)
		PostComplaint(percentage, conditionstring, npc)
	elseif percentage < 0.1 then
		DRC:SpeakSentence(ent, "Pain", "Minor", true)
		PostComplaint(percentage, conditionstring, npc)
	end
end

function DRC:DeathSentence(vic, att, dmg)
	if !IsValid(vic) or !IsValid(att) or !IsValid(dmg) then return end
	local velocity = vic:GetVelocity():Length()
	local damage = dmg:GetDamage()
	local enum = dmg:GetDamageType()
	local att = dmg:GetAttacker()
	local infl = dmg:GetInflictor()
	
	local hp, newhp, maxhp = vic:Health(), vic:Health() - damage, vic:GetMaxHealth()
	local halflife = maxhp/2
	local quarterlife = maxhp/4
	local microlife = maxhp/10
	
	if enum == DMG_FALL && newhp > 0.0001 then
		if !DRC:IsVSentenceValid(DRC:GetVoiceSet(vic), "Pain", "Death_FallDamage") then
			DRC:SpeakSentence(vic, "Pain", "Death")
		else
			DRC:SpeakSentence(vic, "Pain", "Death_FallDamage")
		end
	return end
	
	if DRC:IsVehicle(infl) then
		if !DRC:IsVSentenceValid(DRC:GetVoiceSet(vic), "Pain", "Death_Splatter") then
			DRC:SpeakSentence(vic, "Pain", "Death")
		else
			DRC:SpeakSentence(vic, "Pain", "Death_Splatter")
		end
	return end
	
	if velocity > 650 && (att:IsWorld() or att == vic) then
		if !DRC:IsVSentenceValid(DRC:GetVoiceSet(vic), "Pain", "Death_Falling") then
			DRC:SpeakSentence(vic, "Pain", "Death")
		else
			DRC:SpeakSentence(vic, "Pain", "Death_Falling")
		end
	return end
	
	if damage < microlife then
		if !DRC:IsVSentenceValid(DRC:GetVoiceSet(vic), "Pain", "Death_Light") then
			DRC:SpeakSentence(vic, "Pain", "Death")
		else
			DRC:SpeakSentence(vic, "Pain", "Death_Light")
		end
	elseif damage > microlife && damage < quarterlife then
		if !DRC:IsVSentenceValid(DRC:GetVoiceSet(vic), "Pain", "Death_Medium") then
			DRC:SpeakSentence(vic, "Pain", "Death")
		else
			DRC:SpeakSentence(vic, "Pain", "Death_Medium")
		end
	elseif damage >= quarterlife then
		if !DRC:IsVSentenceValid(DRC:GetVoiceSet(vic), "Pain", "Death_Major") then
			DRC:SpeakSentence(vic, "Pain", "Death")
		else
			DRC:SpeakSentence(vic, "Pain", "Death_Major")
		end
	return end
	
	DRC:SpeakSentence(vic, "Pain", "Death")
end

function DRC:GetFootsteps(ent)
	local vs = ent:GetNWString("DRCFootsteps")
	local enforced = ent:GetNWString("DRCFootsteps_Enforced", "None")
	local tab = DRC.FootSteps
	
	if enforced != "None" then vs = enforced end
	
	if ent:IsPlayer() then
		if ent:GetInfoNum("cl_drc_footstepset_automatic", 0) == 1 then
			local mdl = player_manager.TranslateToPlayerModelName(ent:GetModel())
			local val = DRC:GetPlayerModelValue(mdl, "Footsteps")
			if val then vs = val end
		end
	end
	
	if vs == "none" or vs == nil or vs == "" then return nil end
	if !tab[vs] then return nil end
	return vs
end

function DRC:SetFootsteps(ent, id, enforced)
	if !DRC.FootSteps[id] then ent:SetNWString("DRCFootsteps", "None") return end
	if !enforced then ent:SetNWString("DRCFootsteps", id) end
	if enforced then timer.Simple(0, function() ent:SetNWString("DRCFootsteps_Enforced", id) end) end
end

local function floorgetdist(ent, sqr, tr)
	if sqr != true then
		local sp = ent:GetPos()
		local dist = sp:Distance(tr.HitPos)
		return dist
	else
		local sp = ent:GetPos()
		local dist = sp:DistToSqr(tr.HitPos)
		return dist
	end
end

local tr = { collisiongroup = COLLISION_GROUP_WORLD, output = {} }

function IsInWorld( pos ) -- yoinked from example on https://wiki.facepunch.com/gmod/util.IsInWorld
	tr.start = pos
	tr.endpos = pos

	return not util.TraceLine( tr ).HitWorld
end

function DRC:FloorDist(e, sqr, edgecheck)
	local tr = util.TraceLine({
		start = e:GetPos(),
		endpos = e:GetPos() - Vector(0, 0, 100000000),
		filter = function(ent) if ent != e then return true end end
	})
	
	local tr2, tr3, tr4, tr5
	local edge = false
	if edgecheck == true then
		local mi,ma = e:GetCollisionBounds()
		
		local s1 = e:GetPos() + e:GetAngles():Forward() * mi.y + e:GetAngles():Right() * mi.x
		local s2 = e:GetPos() + e:GetAngles():Forward() * -mi.y + e:GetAngles():Right() * -mi.x
		local s3 = e:GetPos() + e:GetAngles():Forward() * mi.x + e:GetAngles():Right() * -mi.y
		local s4 = e:GetPos() + e:GetAngles():Forward() * -mi.x + e:GetAngles():Right() * mi.y
		
		if IsInWorld(s1) then tr2 = util.TraceLine({ start = s1, endpos = s1 - Vector(0, 0, 5), filter = function(ent) if ent != e then return true end end }) end
		if IsInWorld(s2) then tr3 = util.TraceLine({ start = s2, endpos = s2 - Vector(0, 0, 5), filter = function(ent) if ent != e then return true end end }) end
		if IsInWorld(s3) then tr4 = util.TraceLine({ start = s3, endpos = s3 - Vector(0, 0, 5), filter = function(ent) if ent != e then return true end end }) end
		if IsInWorld(s4) then tr5 = util.TraceLine({ start = s4, endpos = s4 - Vector(0, 0, 5), filter = function(ent) if ent != e then return true end end }) end
		
		if tr2 then DRC:RenderTrace(tr2, Color(0, 0, 255, 255), FrameTime(), true) end
		if tr3 then DRC:RenderTrace(tr3, Color(0, 0, 255, 255), FrameTime(), true) end
		if tr4 then DRC:RenderTrace(tr4, Color(0, 0, 255, 255), FrameTime(), true) end
		if tr5 then DRC:RenderTrace(tr5, Color(0, 0, 255, 255), FrameTime(), true) end
		
		if tr2 && tr2.Hit then edge = true end
		if tr3 && tr3.Hit then edge = true end
		if tr4 && tr4.Hit then edge = true end
		if tr5 && tr5.Hit then edge = true end
	end
	
	if tr then DRC:RenderTrace(tr, Color(0, 0, 255, 255), FrameTime(), true) end
	
	local dist = floorgetdist(e, sqr, tr)
	return dist, edge
end

function DRC:ChangeCHandModel(tbl)
	if !tbl then return end
	if !tbl.model or tbl.model == "" then return end
	if !tbl.skin or tbl.skin == "" then return end
	if !tbl.bodygroups or tbl.bodygroups == "" then return end
	if SERVER then return end
	if DRC:GetCustomizationAllowed() != true then return end
	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	local handsent = ply:GetHands()
	if !IsValid(handsent) then return end
	handsent:SetModel(tbl.model)
	handsent:SetSkin(tbl.skin)
	handsent:SetBodyGroups(tbl.bodygroups)
end

function DRC:GetBaseName(ent)
	if !IsValid(ent) then return end
	if !ent:IsScripted() then return nil end
	if ent.Draconic == true then return "drc" end
	if ent.LFS then return "lfs" end
	if ent.LVS then return "lvs" end
	if ent.IsTFAWeapon then return "tfa" end
	if ent.ArcCW then return "arccw" end
	if ent.ASTWTWO then return "astw2" end
	if ent.ARC9 then return "arc9" end
	if ent.mg_IsPlayerReverbOutside && ent.SprintBehaviourModule then return "mwb" end
	if ent.IsSimfphyscar or IsValid(ent:GetOwner()) && ent:GetOwner():GetClass() == "gmod_sent_vehicle_fphysics_base" then return "sphys" end
	if ent.States && ent.WeaponTypes then return "ma2" end
	if ent:GetClass() == "decal" then return "decal" end
	return nil
end

local hardcoded = {
	["npc_seagull"] = "Seagull",
	["npc_crow"] = "Crow",
	["npc_pigeon"] = "Pigeon",
	["npc_combine_s"] = "Combine Soldier",
	["npc_hunter"] = "Hunter",
	["npc_manhack"] = "Manhack",
	["npc_helicopter"] = "Hunter-Chopper",
	["npc_combine_camera"] = "Camera",
	["npc_turret_ceiling"] = "Ceiling Turrret",
	["npc_cscanner"] = "City Scanner",
	["npc_combinedropship"] = "Combine Dropship",
	["npc_combinegunship"] = "Combine Gunship",
	["npc_metropolice"] = "Civil Protection",
	["npc_rollermine"] = "Rollermine",
	["npc_clawscanner"] = "Shield Scanner",
	["npc_stalker"] = "Stalker",
	["npc_strider"] = "Strider",
	["npc_turret_floor"] = "Turret",
	["npc_citizen"] = "Refugee",
	["npc_alyx"] = "Alyx",
	["npc_barney"] = "Barney",
	["npc_dog"] = "D0G",
	["npc_magnusson"] = "Magnusson",
	["npc_monk"] = "Grigori",
	["npc_kleiner"] = "Kleiner",
	["npc_mossman"] = "Mossman",
	["npc_eli"] = "Eli",
	["npc_gman"] = "G-Man",
	["npc_odessa"] = "Odessa",
	["npc_vortigaunt"] = "Vortigaunt",
	["npc_breen"] = "Breen",
	["npc_antlion"] = "Antlion",
	["npc_antlion_grub"] = "Antlion Grub",
	["npc_antlionguard"] = "Antlion Guardian",
	["npc_antlion_worker"] = "Antlion Worker",
	["npc_barnacle"] = "Barnacle",
	["npc_headcrab_fast"] = "Headcrab (Fast)",
	["npc_fastzombie"] = "Fast Zombie",
	["npc_fastzombie_torso"] = "Fast Zombie Torso",
	["npc_headcrab"] = "Headcrab",
	["npc_headcrab_black"] = "Headcrab (Poison)",
	["npc_poisonzombie"] = "Poison Zombie",
	["npc_zombie"] = "Zombie",
	["npc_zombie_torso"] = "Zombie Torso",
	["npc_zombine"] = "Zombine",
	["monster_alien_grunt"] = "Alien Grunt",
	["monster_alien_slave"] = "Vortigaunt (Slave)",
	["monster_human_assassin"] = "Assassin",
	["monster_babycrab"] = "Baby Headcrab",
	["monster_bullchicken"] = "Bullsquid",
	["monster_cockroach"] = "Cockroach",
	["monster_alien_controller"] = "Alien Controller",
	["monster_gargantua"] = "Gargantua",
	["monster_bigmomma"] = "Gonarch",
	["monster_human_grunt"] = "Grunt",
	["monster_headcrab"] = "Headcrab",
	["monster_turret"] = "Ceiling Turret",
	["monster_houndeye"] = "Houndeye",
	["monster_miniturret"] = "Ceiling Turret",
	["monster_nihilanth"] = "Nihilanth",
	["monster_scientist"] = "Scientist",
	["monster_barney"] = "Guard",
	["monster_sentry"] = "Sentry",
	["monster_snark"] = "Snark",
	["monster_tentacle"] = "Tentacle",
	["monster_zombie"] = "Zombie",
	["prop_vehicle_airboat"] = "Airboat",
	["prop_vehicle_jeep"] = "Junker",
	["prop_vehicle_prisoner_pod"] = "", -- too many use cases to give a proper name
	["weapon_357"] = "357",
	["weapon_pistol"] = "Pistol",
	["weapon_bugbait"] = "Bug Bait",
	["weapon_crossbow"] = "Crossbow",
	["weapon_crowbar"] = "Crowbar",
	["weapon_frag"] = "Grenade",
	["weapon_physcannon"] = "Gravity Gun",
	["weapon_ar2"] = "Pulse Rifle",
	["weapon_rpg"] = "RPG",
	["weapon_slam"] = "S.L.A.M.",
	["weapon_shotgun"] = "Shotgun",
	["weapon_smg1"] = "SMG",
	["weapon_stunstick"] = "Stunstick",
	["weapon_357_hl1"] = "357",
	["weapon_crossbow_hl1"] = "Crossbow",
	["weapon_crossbow_hl1"] = "Crossbow",
	["weapon_glock_hl1"] = "Glock",
	["weapon_egon"] = "Gluon Gun",
	["weapon_handgrenade"] = "Hand Grenade",
	["weapon_hornetgun"] = "Hive Hand",
	["weapon_mp5_hl1"] = "MP5",
	["weapon_rpg_hl1"] = "RPG",
	["weapon_satchel"] = "Satchel",
	["weapon_snark"] = "Snarks",
	["weapon_shotgun_hl1"] = "SPAS-12",
	["weapon_gauss"] = "Tau Cannon",
	["weapon_tripmine"] = "Tripmine",
	["item_ammo_357"] = "357 Ammo",
	["item_ammo_357_large"] = "357 Ammo",
	["item_ammo_ar2"] = "Pulse Rifle Ammo",
	["item_ammo_ar2_large"] = "Pulse Rifle Ammo",
	["item_ammo_ar2_altfire"] = "Combine's Balls",
	["combine_mine"] = "Combine Mine",
	["item_ammo_crossbow"] = "Crossbow Bolts",
	["item_healthcharger"] = "Health Charger",
	["item_healthkit"] = "Healthkit",
	["item_healthvial"] = "Health Vial",
	["grenade_helicopter"] = "Chopper Grenade",
	["item_suit"] = "H.E.V. Suit",
	["weapon_striderbuster"] = "Magnusson Device",
	["item_ammo_pistol"] = "Pistol Ammo",
	["item_ammo_pistol_large"] = "Pistol Ammo",
	["item_rpg_round"] = "RPG Rocket",
	["item_box_buckshot"] = "Shotgun Ammo",
	["item_ammo_smg1"] = "SMG Ammo",
	["item_ammo_smg1_large"] = "SMG Ammo",
	["item_ammo_smg1_grenade"] = "SMG Grenade",
	["item_battery"] = "Suit Battery",
	["item_suitcharger"] = "Suit Charger",
	["prop_thumper"] = "Combine Thumper",
	["npc_grenade_frag"] = "Armed Grenade",
}

function DRC:GetName(ent, fallback) -- Used to get the accurate name for entities and other bases' entities
	if !IsValid(ent) then return end
	local str = "Null"
	local ent2 = nil
	if ent:IsPlayer() then str = ent:Nick() return str end
	if ent.GetOwner then
		if IsValid(ent:GetOwner()) then
			ent2 = ent:GetOwner()
			local base = DRC:GetBaseName(ent2)
			if base == "sphys" then
			elseif base == "lfs" or base == "lvs" then str = ent2.PrintName end
		--	if base == "sphys" then str = list.Get("simfphys_vehicles")[] end
			if ent2.PrintName then str = ent2.PrintName return str end
		else
			str = ent.PrintName
		end
	end
	if hardcoded[ent:GetClass()] then str = hardcoded[ent:GetClass()] end
	if fallback && str == "Null" then str = fallback end
	return str, ent2
end

function DRC:Health(ent) -- This is what happens when people try to reinvent the wheel.
	if !IsValid(ent) then return end
	local base = DRC:GetBaseName(ent)
	
	local function gethp(entity)
		base = DRC:GetBaseName(entity)
		if base == nil or base == "drc" then return entity:Health(), entity:GetMaxHealth()
		elseif base == "lfs" or base == "lvs" then return entity:GetHP(), entity:GetMaxHP()
		elseif base == "sphys" then return entity:GetCurHealth(), entity:GetMaxHealth()
		elseif base == "ma2" then return entity:GetMechHealth(), entity.MaxHealth
		end
	end
	
	if ent.GetOwner then
		if IsValid(ent:GetOwner()) then
			local ent2 = ent:GetOwner()
			return gethp(ent2)
		end
	end
	
	return gethp(ent)
end

function DRC:SetHealth(ent, amount, maxamount)
	if !IsValid(ent) then return end
	local base = DRC:GetBaseName(ent)
	if base == nil or base == "drc" then ent:SetHealth(amount)
	elseif base == "lfs" then ent:SetHP(amount)
	elseif base == "sphys" then ent:SetCurHealth(amount)
	end
	
	if maxamount then
		if base == nil or base == "drc" then ent:SetMaxHealth(maxamount)
		elseif base == "lfs" then ent:SetMaxHP(maxamount)
		elseif base == "sphys" then ent:SetMaxHealth(maxamount)
		end
	end
end

function DRC:CreateProjectile(class, pos, ang, force, owner, inherit)
	if !SERVER then return end
	local proj = ents.Create(class)
	if owner then proj:SetOwner(owner) end
	proj:SetPos(pos)
	proj:SetAngles(ang)
	proj:Spawn()
	proj:Activate()
	
	local speed = ang:Forward() * force
	if owner && inherit == true then speed = ((ang:Forward() * force) + owner:GetVelocity()) end
	local phys = proj:GetPhysicsObject()
	phys:SetVelocity(speed)

	return proj
end


--[[ Table format example:
local NewPlayermodel = {
	["Name"] = "Barney", -- SOMETHING UNIQUE
	["Model"] = "models/player/barney.mdl",
	["Hands"] = "models/weapons/c_arms_combine.mdl",
	["Background"] = "vgui/chapters/chapter14",
	["Podium"] = "path/to/model.mdl",
	["VoiceSet"] = "VoiceSetID", -- Defaulted VS to use if a player/server has this setting enabled.
}
DRC:RegisterPlayerModel(NewPlayermodel)
]]
function DRC:RegisterPlayerModel(tbl)
	if !istable(tbl) then return end
	
	if tbl.RequiredModel then
		if !file.Exists(tbl.RequiredModel, "GAME") then return end
	end
	
	list.Set( "PlayerOptionsModel", tbl.Name, tbl.Model)
	player_manager.AddValidModel(tbl.Name, tbl.Model)
	player_manager.AddValidHands(tbl.Name, tbl.Hands, 0, "0")
	
	if !tbl.DefaultCam then tbl.DefaultCam = {["Pos"] = Vector(80.69, 36.7, 52.02), ["Ang"] = Angle(10.278, 203.334, 0), 47} end
	
	DRC.Playermodels[tbl.Name] = {
		["Model"] = tbl.Model,
		["Hands"] = tbl.Hands,
		["Background"] = tbl.Background or "",
		["Podium"] = tbl.Podium or {"models/props_phx/construct/glass/glass_angle360.mdl", Vector(0, 0, -2)},
		["DefaultCam"] = tbl.DefaultCam,
		["VoiceSet"] = tbl.VoiceSet or "",
		["Extensions"] = tbl.Extensions or { 
			["Claws"] = false,
		},
		["RequiredModel"] = tbl.RequiredModel or "",
	}
end

function DRC:GetPlayerModelValue(name, val, subval)
	if !name then return end
	if !val then return end
	if !DRC.Playermodels[name] then return false end
	if !subval then
		if DRC.Playermodels[name][val] then
			return DRC.Playermodels[name][val]
		else
			return false
		end
	else
		if DRC.Playermodels[name][val][subval] then
			return DRC.Playermodels[name][val][subval]
		else
			return false
		end
	end
end

function DRC:RegisterPlayerExtension(model, val1, val2, val3)
	local blacklist = { "Model", "Hands" }
	if blacklist[val1] then return end
	
	if !DRC.Playermodels[model] then
		DRC.Playermodels[model] = {
			["Model"] = player_manager.TranslatePlayerModel(model),
			["Hands"] = player_manager.TranslatePlayerHands(model),
			["Background"] = "vgui/drc_playerbg",
			["Podium"] = {"models/props_phx/construct/glass/glass_angle360.mdl", Vector(0, 0, -2)},
			["DefaultCam"] = {
				["Pos"] = Vector(80.69, 36.7, 52.02),
				["Ang"] = Angle(10.278, 203.334, 0),
			},
			["VoiceSet"] = "",
			["Footsteps"] = "",
			["Extensions"] = { 
				["Claws"] = false,
			},
		}
	end
	
	if !val3 then
		DRC.Playermodels[model][val1] = val2
	else
		DRC.Playermodels[model][val1][val2] = val3
	end
end

hook.Add( "PlayerCanPickupWeapon", "drc_PreventBatteryAmmoPickup", function( ply, weapon )
	if !IsValid(ply) or !IsValid(weapon) then return end
	if weapon.IsBatteryBased == true then
		if weapon.PickupOnly == true then
			if ply.CanPickupDRC == true then
				if ( ply:HasWeapon( weapon:GetClass() ) ) then
					return false
				end
			elseif !ply.CanPickupDRC then return false
			end
		end
		if ( ply:HasWeapon( weapon:GetClass() ) ) then
			return false
		end
	elseif weapon.PickupOnly == true then
		return false
	end
end )

DRC.GamemodeCompat = {
	["terrortown"] = true,
}

hook.Add( "AllowPlayerPickup", "drc_PreventAnnoyance", function( ply, ent )
	if !IsValid(ply) or !IsValid(ent) or !ply:Alive() then return end
	local curswep = ply:GetActiveWeapon()
	if !IsValid(curswep) then return end
	
	if curswep.Draconic != nil then
		local gm = engine.ActiveGamemode()
		if DRC.GamemodeCompat[gm] then return end
		timer.Simple(0.75, function()
			if !IsValid(ent) then return end
			local po = ent:GetPhysicsObject()
			if po:GetMass() > 249 then return end
			local dist = ply:GetPos():DistToSqr(ent:GetPos()) / 10
			if ply:KeyDown(IN_USE) && dist < 1000 then ply:PickupObject(ent) end
		end)
		return false
	end
end )

function ViableWeaponCheck(ply)
if (!IsValid(ply) or !ply:Alive()) && !ply:InVehicle() then return end
	local curswep = ply:GetActiveWeapon()
	if !IsValid(curswep) then return end
	
	ply.ViableWeapons = {}
	ply.PickupWeapons = {}
	local entsearch = ents.FindInSphere(ply:GetPos(), 50)
	for k,v in pairs(entsearch) do
		if v:IsWeapon() then 
			if v:GetOwner():IsWorld() or v:GetOwner() == nil or !IsValid(v:GetOwner()) then
				if v.Draconic != nil then
					if v.CanBeSwapped == true then
						if v:GetClass() == curswep:GetClass() then
							if v:GetNWInt("LoadedAmmo") > curswep:GetNWInt("LoadedAmmo") then
								table.insert(ply.ViableWeapons, v)
							end
						end
					end
					if v.PickupOnly == true then
						table.insert(ply.PickupWeapons, v)
					end
				end
			end
		elseif !v:IsWeapon() then table.RemoveByValue(entsearch, v)
		end
	end
end

local SwapCD = 0
local ViableCheckCD = 0
hook.Add( "PlayerTick", "drc_PlayerTickEvents", function(ply, cmd)
	if (!IsValid(ply) or !ply:Alive()) && !ply:InVehicle() then return end
	local curswep = ply:GetActiveWeapon()
	
	if CurTime() > ViableCheckCD then
		ViableWeaponCheck(ply)
		ViableCheckCD = CurTime() + 0.066
	end
	
	if !ply.TurnCD then ply.TurnCD = 0 end
	if !ply.SwapCD then ply.SwapCD = 0 end
	
	if CurTime() > ply.TurnCD then
		local rang, pang, inv = ply:GetRenderAngles(), ply:EyeAngles(), false
		
		if pang.y < 0 then inv = false else inv = true end
		
		rang = math.abs(math.Round(rang.y))
		pang = math.abs(math.Round(pang.y))
		local meth = rang - pang
		local w, a, s, d = ply:KeyDown(IN_FORWARD), ply:KeyDown(IN_MOVELEFT), ply:KeyDown(IN_BACK), ply:KeyDown(IN_MOVERIGHT)
		
		if (!w && !a && !s && !d) && (math.abs(meth) >= 45) then
			local lt, rt = ACT_GESTURE_TURN_LEFT45, ACT_GESTURE_TURN_RIGHT45
			if ply:Crouching() then lt, rt = ACT_GESTURE_TURN_LEFT45_FLAT, ACT_GESTURE_TURN_RIGHT45_FLAT end
			
			local anim = lt
			if inv then
				if meth > 0 then anim = rt else anim = lt end
			else
				if meth < 0 then anim = rt else anim = lt end
			end
			
			DRC:CallGesture(ply, GESTURE_SLOT_JUMP, anim, true)
			ply.TurnCD = CurTime() + 0.5	
		end
		
	end
	
	if CurTime() < ply.SwapCD then return end
	if !ply.PickupWeapons then ply.PickupWeapons = {} end
	if !ply.ViableWeapons then ply.ViableWeapons = {} end
	if !table.IsEmpty(ply.PickupWeapons) then
		if ply:KeyDown(IN_USE) && SERVER then
			if curswep.LoopFireSound != nil then curswep.LoopFireSound:Stop() end
			if curswep.PickupOnly == true then ply:DropWeapon(curswep) end
			ply:PickupWeapon(ply.PickupWeapons[1])
			ply:SelectWeapon(ply.PickupWeapons[1])
			ply.PickupWeapons[1]:SetOwner(ply)
			ply.SwapCD = CurTime() + 0.25
		end
	elseif !table.IsEmpty(ply.ViableWeapons) then
		if ply:KeyDown(IN_USE) && SERVER then
			if curswep.LoopFireSound != nil then curswep.LoopFireSound:Stop() end
			if curswep.PickupOnly == true then ply:DropWeapon(curswep) end
			ply:DropWeapon(curswep)
			ply:PickupWeapon(ply.ViableWeapons[1])
			ply:SelectWeapon(ply.ViableWeapons[1])
			ply.ViableWeapons[1]:SetOwner(ply)
			ply.SwapCD = CurTime() + 0.25
		end
	end
end )

hook.Add("PlayerGiveSWEP", "drc_GivePickupOnlyWeapon", function(ply, wpn, swep)
	local wep = weapons.GetStored(wpn)
	if !wep then return end
	if wep.PickupOnly == true then
		if wep.AdminSpawnable == true then
			if ply:IsAdmin() then
				local weapon = ents.Create(wpn)
				weapon:SetPos(ply:GetPos())
				weapon:Spawn()
				ply:PickupWeapon(weapon)
			else return false end
		end
	end
end)

hook.Add("WeaponEquip", "VoiceSets_WeaponEquip", function(wpn, ply)
	local vs = DRC:GetVoiceSet(ply)
	if DRC:IsVSentenceValid(vs, "Actions", "pickup_".. wpn:GetClass() .."") then
		DRC:SpeakSentence(ply, "Actions", "pickup_".. wpn:GetClass() .."")
	elseif DRC:IsVSentenceValid(vs, "Actions", "pickup_generic") then
		DRC:SpeakSentence(ply, "Actions", "pickup_generic")
	end
end)

hook.Add("PlayerSpawnedNPC", "drc_NPCWeaponOverride", function(ply, ent)
	if !IsValid(ply) or !IsValid(ent) then return end
	if !ent.DraconicNPC then return end
	if ent:DraconicNPC() == true then
		ent:SetOwner(ply)
	end
end)

hook.Add("OnEntityCreated", "drc_OnEntityCreated", function(ent)
	if !IsValid(ent) then return end
	
	if CLIENT then ent.DRCInitialLightPoll = false end
	
	if ent:IsNPC() or ent:IsNextBot() then
		ent:SetNWInt("DRC_GunSpreadMod", 1)
		ent:SetNWInt("DRC_GunDamageMod", 1)
	end
	
	if !ent:IsWeapon() then return end
	if ent:IsWeapon() && ent.Draconic != true then return end
	
	timer.Simple(0, function()
		if !IsValid(ent) then return end
		if !IsValid(ent:GetOwner()) then return end
		local ply = ent:GetOwner()
		
		if ply:IsPlayer() then
			ent:SetNWEntity("SpraySrc", ply)
			local colours = DRC:GetColours(ply, false)
			ent:SetNWVector("PlayerColour_DRC", colours.Player)
			ent:SetNWVector("WeaponColour_DRC", colours.Weapon)
			ent:SetNWVector("ColourTintVec1", colours.Tint1)
			ent:SetNWVector("ColourTintVec2", colours.Tint2)
			ent:SetNWVector("EyeTintVec", colours.Eye)
			ent:SetNWVector("EnergyTintVec", colours.Energy)
			
			ent:SetNWEntity("Spawner", ply)
		elseif ent.LFS then
		
		else
			local colours = {
				["Player"] = Vector(127, 127, 127),
				["Weapon"] = Vector(127, 127, 127),
				["Tint1"] = Vector(127, 127, 127),
				["Tint2"] = Vector(127, 127, 127),
				["Eye"] = Vector(127, 127, 127),
				["Energy"] = Vector(127, 127, 127),
			}
			ent:SetNWVector("PlayerColour_DRC", colours.Player * 255)
			ent:SetNWVector("WeaponColour_DRC", colours.Weapon)
			ent:SetNWVector("ColourTintVec1", colours.Tint1 * 255)
			ent:SetNWVector("ColourTintVec2", colours.Tint2 * 255)
			ent:SetNWVector("EyeTintVec", colours.Eye)
			ent:SetNWVector("EnergyTintVec", colours.Energy)
		end
	end)
end)

hook.Add("PlayerAmmoChanged", "drc_StopImpulse101FromBreakingBatteries", function(ply, id, old, new)
	local batteryammo = game.GetAmmoID("ammo_drc_battery")
	if id == batteryammo && new > 110 then
--		if CLIENT then DRC:Notify(nil, "hint", "critical", "Don't give yourself this ammo type! You'll only break your battery-based weapon!", NOTIFY_HINT, 5) end
		ply:SetAmmo(old, batteryammo)
		timer.Simple(0.2, function() ply:SetAmmo(old, batteryammo) end)
	end
end)

hook.Add("OnEntityWaterLevelChanged", "drc_projectile_submerged", function(ent, old, new)
	if !IsValid(ent) then return end
	if !IsValid(ent:GetPhysicsObject()) then return end
	if ent.DraconicProjectile != true then return end
	if ent.AlreadySubmergedOnce == true then return end
	local phys = ent:GetPhysicsObject()
	
	if new == 3 then
		local mass = phys:GetMass()
		local vel = ent:GetObjVelocity()
		if vel == nil then return end
		local velavg = math.Round((math.abs(vel.x) + math.abs(vel.y) + math.abs(vel.z)) / 3, 2)
		local pitch = velavg / 10	
		local dummy = ents.Create("drc_dummy")
		dummy:SetPos(ent:GetPos() + Vector(0, 0, 10))
		local SplashSoundTiny = CreateSound(dummy, "draconic.ProjectileSplash_Tiny")
		local SplashSoundSmall = CreateSound(dummy, "draconic.ProjectileSplash_Small")
	
		ent.AlreadySubmergedOnce = true
	
		local pitchmod = 1
		if mass < 5 then
			local pitchmod = 5
			SplashSoundTiny:Play()
			SplashSoundTiny:ChangePitch(125)
			SplashSoundTiny:ChangeVolume(0.5)
			
			SplashSoundSmall:Play()
			SplashSoundSmall:ChangePitch(80)
			SplashSoundSmall:ChangeVolume(0.2)
		elseif mass > 5 && mass < 49 then
			SplashSoundSmall:Play()
			SplashSoundSmall:ChangePitch((pitch / 100) * pitchmod)
			SplashSoundSmall:ChangeVolume(pitch)
		else
			SplashSoundSmall:Play()
			SplashSoundSmall:ChangePitch((pitch / 100) * pitchmod)
			SplashSoundSmall:ChangeVolume(pitch)
		end
		
		local effectdata = EffectData()
		effectdata:SetOrigin(dummy:GetPos())
		util.Effect("waterripple", effectdata)
		timer.Simple(1, function () dummy:Remove() end)
	end
end)

hook.Add( "EntityEmitSound", "drc_timewarpsnd", function( t )
	local cheats = GetConVar( "sv_cheats" )
	local bool = DRC.SV.drc_soundtime_disabled
	if bool != 0 then return end
	local timeScale = GetConVar( "host_timescale" )
	local p = t.Pitch
	
	if ( game.GetTimeScale() ~= 1 ) then
		p = p * game.GetTimeScale()
	end
	
	if ( timeScale:GetInt() != 1 && cheats:GetInt() >= 1 ) then
		p = p * timeScale:GetFloat()
	end
	
	if ( p ~= t.Pitch ) then
		t.Pitch = math.Clamp( p, 0, 255 )
		return true
	end
	
	if ( CLIENT && engine.GetDemoPlaybackTimeScale() ~= 1 ) then
		t.Pitch = math.Clamp( t.Pitch * engine.GetDemoPlaybackTimeScale(), 0, 255 )
		return true
	end
end )

DRC.ActiveWeapons = {}
hook.Add("OnEntityCreated", "DRC_WeaponTracker", function(ent)
	if ent:IsWeapon() then
		if weapons.IsBasedOn(ent:GetClass(), "draconic_base") then
			DRC.ActiveWeapons[tostring(ent)] = ent
		end
	return end
end)

hook.Add("EntityRemoved", "DRC_WeaponTracker_Remove", function(ent)
	if DRC.ActiveWeapons[tostring(ent)] then DRC.ActiveWeapons[tostring(ent)] = nil end
end)

hook.Add("CalcMainActivity", "DRC_BarnacleGrab", function(ply, vel)
	if !IsValid(ply) then return end
	if ply:GetNWBool("BarnacleHeld", false) == true then
--	if ply:IsEFlagSet(EFL_IS_BEING_LIFTED_BY_BARNACLE) == true then -- doesn't return true on client
		local wpn = ply:GetActiveWeapon()
		if !IsValid(wpn) then
			local seq = ply:LookupSequence("barnacle_unarmed")
			if seq != 0 then return ACT_GMOD_NOCLIP_LAYER, seq end
		else
			if wpn:GetHoldType() != "normal" then
				local seq = ply:LookupSequence("barnacle_armed")
				if seq != 0 then return ACT_GMOD_NOCLIP_LAYER, seq end
			else
				local seq = ply:LookupSequence("barnacle_unarmed")
				if seq != 0 then return ACT_GMOD_NOCLIP_LAYER, seq end
			end
		end
	end
end)

hook.Add("Tick", "DRC_I_Wrote_This_When_I_Ran_Out_Of_Options", function()
	for k,v in pairs(DRC.ActiveWeapons) do
		if !v.Muzzle then v.Muzzle = v:GetAttachment(v:LookupAttachment("muzzle")) end
	end
end)


-- DETOURS
if SERVER then
	function DRC:NetworkScreenShake(ply, tab)
		if !ply then return end
		if !tab then return end
		if !ply.LastShakeNW then ply.LastShakeNW = 0 end
		if ply.LastShakeNW < CurTime() + 1 then
			ply.LastShakeNW = CurTime()
			net.Start("DRC_NetworkScreenShake")
			net.WriteVector(tab[1])
			net.WriteFloat(tab[2])
			net.WriteFloat(tab[3])
			net.WriteFloat(tab[4])
			net.WriteFloat(tab[5])
			net.Send(ply)
		end
	end
end

local OldScreenshake = util.ScreenShake -- Intercepting screenshake so that it can be emulated in custom CalcView hooks.
function util.ScreenShake(pos, amp, freq, dur, radi)
	if SERVER then
		for k,v in pairs(ents.FindInSphere(pos, radi)) do
			if v:IsPlayer() then
				local tab = {pos, amp, freq, dur, radi}
			--	local str = "".. tostring(pos) .."(-)".. amp .."(-)".. freq .."(-)".. dur .."(-)".. radi ..""
				if tab then DRC:NetworkScreenShake(v, tab) end
			end
		end
	end
	
	return OldScreenshake(pos, amp, freq, dur, radi)
end