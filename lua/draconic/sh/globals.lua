-- ### Definitions
DRCD = {}
DRCD.Weapons = {
	["chargeresponses"] = { -- fallback, overcharge, holds
		["dualheld"] = {"primary", "overcharge", true},
		["dualaction"] = {"primary", "overcharge", false},
		["discharge"] = {nil, "overcharge", false},
		["held"] = {nil, "overcharge", true}
	},
	["ironsounds"] = {
		["ar2"] = {"draconic.IronInRifle", "draconic.IronOutRifle"},
		["smg"] = {"draconic.IronInSMG", "draconic.IronOutSMG"},
		["duel"] = {"draconic.IronInSMG", "draconic.IronOutSMG"},
		["pistol"] = {"draconic.IronInPistol", "draconic.IronOutPistol"},
		["revolver"] = {"draconic.IronInPistol", "draconic.IronOutPistol"},
		["shotgun"] = {"draconic.IronInShotgun", "draconic.IronOutShotgun"},
		["crossbow"] = {"draconic.IronInShotgun", "draconic.IronOutShotgun"},
		["rpg"] = {"draconic.IronInShotgun", "draconic.IronOutShotgun"},
		["physgun"] = {"draconic.IronInShotgun", "draconic.IronOutShotgun"},
		["grenade"] = {"draconic.IronInGeneric", "draconic.IronOutGeneric"},
		["slam"] = {"draconic.IronInGeneric", "draconic.IronOutGeneric"},
		["melee"] = {"draconic.IronInGeneric", "draconic.IronOutGeneric"},
		["melee2"] = {"draconic.IronInGeneric", "draconic.IronOutGeneric"},
		["passive"] = {"draconic.IronInGeneric", "draconic.IronOutGeneric"},
		["normal"] = {"draconic.IronInGeneric", "draconic.IronOutGeneric"},
		["knife"] = {"draconic.IronInGeneric", "draconic.IronOutGeneric"},
		["camera"] = {"draconic.IronInGeneric", "draconic.IronOutGeneric"},
		["magic"] = {"draconic.IronInGeneric", "draconic.IronOutGeneric"},
	},
	["bloom_updates"] = {
		["standidle"] = 0,
		["crouchidle"] = 0,
		["running"] = 0.1,
		["crouchrunning"] = 0.1,
		["sprinting"] = 0.3,
		["crouchingsprinting"] = 0.3,
		["swimidle"] = 0,
		["swimming"] = 0.1,
	},
	["bloom_maximums"] = {
		["standidle"] = 1,
		["crouchidle"] = 1,
		["running"] = 1.3,
		["crouchrunning"] = 1.3,
		["sprinting"] = 1.7,
		["crouchingsprinting"] = 1.7,
		["swimidle"] = 0.9,
		["swimming"] = 1.1,
	}
}



-- ### Convars
DRC.Convars_CL = {}
DRC.Convars_SV = {}

function DRC:DebugModeAllowed()
	if DRC.SV.drc_allowdebug != 0 then return true else return false end
end

DRC.SV = {}
function DRC:ServerVar(name, desc, default, mini, maxi, flagoverride)
	if !name then return end
	if !desc then return end
	if !default then default = 1 end
	if !mini then mini = 0 end
	if !maxi then maxi = 1 end
	if !flagoverride then flagoverride = {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_DEMO} end
	local str2 = "sv_".. name ..""
	
	CreateConVar(str2, default, flagoverride, desc, mini, maxi)
	DRC.SV[name] = GetConVar(str2):GetFloat()
	cvars.RemoveChangeCallback(str2, "remove")
	cvars.AddChangeCallback(str2, function(vname, old, new)
		DRC.SV[name] = tonumber(new)
		if SERVER then
			net.Start("DRC_SyncServerVar")
			net.WriteString(name)
			net.WriteFloat(new)
			net.Broadcast()
		end
	end, "remove")
end

DRC:ServerVar("drc_allowdebug", "Allows all players to access the debug menu of the Draconic Base.", 0, 0, 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO})
DRC:ServerVar("drc_soundtime_disabled", "Pitch of audio changing with host_timescale", 0, 0, 1)

DRC:ServerVar("drc_disable_thirdperson", "Disables Draconic thirdperson access server-wide. (Unless a weapon relies on it)", 0, 0, 1)
DRC:ServerVar("drc_disable_thirdperson_freelook", "Disables Draconic thirdperson's freelook functionality.", 0, 0, 1)

DRC:ServerVar("drc_playerrep_disallow", "Disables players from accessing playermodel customization from the Draconic Menu.", 0, 0, 1)
DRC:ServerVar("drc_playerrep_tweakonly", "Limits players to only changing their colours/bodygroup/skin in the Draconic Menu. Set to 2 to limit it to colours only, or 3 for bodygroups & skin only.", 0, 0, 3)
DRC:ServerVar("drc_voicesets_noanimations", "Whether or not to disable animations from playing for the 'Help!' and 'Let's go!' voicesets.", 0, 0, 1)

DRC:ServerVar("drc_movement", "Enables or disables the custom movement modifiers of ALL weapons made on the Draconic SWEP Base.", 1, 0, 1)
DRC:ServerVar("drc_movesounds", "Enables or disables the custom sprint/jump sounds of ALL weapons made on the Draconic SWEP Base.", 1, 0, 1)
DRC:ServerVar("drc_force_sprint", "0: off | 1: Forces all Draconic weapons to use a passive-sprint, 2: Forces all Draconic weapons to NOT use a passive-sprint.", 0, 0, 2)
DRC:ServerVar("drc_passives", "Enables or disables the ability to put weapons in a passive stance.", 1, 0, 1)
DRC:ServerVar("drc_attachments_disallowmodification", "Disallow players from modifying weapon attachments.", 0, 0, 1)
DRC:ServerVar("drc_attachments_autounlock", "When enabled, weapons will spawn with all attachments unlocked. When disabled, only the default (first) attachment in each slot will be unlocked and others will need to be manually picked up or granted to the player by the server.", 1, 0, 1)
DRC:ServerVar("drc_inspections", "Enables or disables the ability to access the inspection mode, which shows weapon stats & allows weapon customization.", 1, 0, 1)
DRC:ServerVar("drc_inspect_hideHUD", "Enables or disables the ability to see the inspection menu.", 0, 0, 1)
DRC:ServerVar("drc_forcebasegameammo", "Force Draconic weaapons to use standard base-game ammunition. (Requires weapon respawn on toggle)", 0, 0, 1)
DRC:ServerVar("drc_infiniteammo", "0 Off | 1 Infinite | 2 Bottomless Mag", 0, 0, 2)
DRC:ServerVar("drc_disable_crosshairs", "Enable/Disable SWEP base crosshairs for all clients. Clients can still disable them on their own, but this can prevent them from using them.", 0, 0, 1)
DRC:ServerVar("drc_viewdrag", "Enables or disables first person camera drag effects with animations.", 1, 0, 1)

DRC:ServerVar("drc_funnyplayercorpses", "I added this just to force players to spawn drc_corpse on death as a means of testing.", 0, 0, 1)

DRC:ServerVar("drc_npc_uses_integratedlights", "When set to 1 it forces all NPCs using Draconic weapons with integrated lights to turn them on.", 0, 0, 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_DEMO})

--if GetConVar("sv_drc_movement") == nil then DRC.Convars_SV.Movement = CreateConVar("sv_drc_movement", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables the custom movement modifiers of ALL weapons made on the Draconic SWEP Base.", 0, 1) end
--if GetConVar("sv_drc_movesounds") == nil then DRC.Convars_SV.MoveSounds = CreateConVar("sv_drc_movesounds", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables the custom sprint/jump sounds of ALL weapons made on the Draconic SWEP Base.", 0, 1) end
--if GetConVar("sv_drc_force_sprint") == nil then DRC.Convars_SV.SprintOverride = CreateConVar("sv_drc_force_sprint", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Forces all DSB weapons to use the passive-sprint system, regardless of SWEP author intention.", 0, 1) end
--if GetConVar("sv_drc_maxrmour") == nil then CreateConVar("sv_drc_maxrmour", 250, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_DEMO}, "Maximum armour a DSB weapon can reapply to.") end
if GetConVar("sv_drc_disable_distgunfire") == nil then DRC.Convars_SV.DistGunfire = CreateConVar("sv_drc_disable_distgunfire", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_DEMO}, "If true, disables distant gunfire for weapons. Alleviates network traffic on huge (100+ player) servers.", 0, 1) end
--if GetConVar("sv_drc_inspections") == nil then DRC.Convars_SV.Inspection = CreateConVar("sv_drc_inspections", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables the ability to access the inspection mode, which shows weapon stats & puts the viewmodel in an alternate view.", 0, 1) end
--if GetConVar("sv_drc_inspect_hideHUD") == nil then DRC.Convars_SV.Inspection_HideHUD = CreateConVar("sv_drc_inspect_hideHUD", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables the ability to see the inspection menu which shows weapon stats.", 0, 1) end
--if GetConVar("sv_drc_passives") == nil then DRC.Convars_SV.Passives = CreateConVar("sv_drc_passives", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables the ability to put weapons in a passive stance.", 0, 1) end
--if GetConVar("sv_drc_viewdrag") == nil then DRC.Convars_SV.ViewDrag = CreateConVar("sv_drc_viewdrag", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables first person camera drag effects with animations.", 0, 1) end
--if GetConVar("sv_drc_allowdebug") == nil then DRC.Convars_SV.AllowDebug = CreateConVar("sv_drc_allowdebug", 0, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_DEMO}, "Allows all players to access the debug menu of the Draconic Base.", 0, 1) end
--if GetConVar("sv_drc_disable_thirdperson") == nil then DRC.Convars_SV.DisableTP = CreateConVar("sv_drc_disable_thirdperson", 0, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_DEMO}, "Disables Draconic thirdperson when not using a weapon which requires it.", 0, 1) end
--if GetConVar("sv_drc_disable_thirdperson_freelook") == nil then DRC.Convars_SV.DisableTP_Freelook = CreateConVar("sv_drc_disable_thirdperson_freelook", 0, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_DEMO}, "Disables Draconic thirdperson's freelook functionality.", 0, 1) end
--if GetConVar("sv_drc_disable_crosshairs") == nil then DRC.Convars_SV.DisableCrosshairs = CreateConVar("sv_drc_disable_crosshairs", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enable/Disable SWEP base crosshairs for all clients. Clients can still disable them on their own, but this can prevent them from using them.", 0, 1) end
--if GetConVar("sv_drc_forcebasegameammo") == nil then DRC.Convars_SV.BaseGameAmmo = CreateConVar("sv_drc_forcebasegameammo", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Force Draconic weaapons to use standard base-game ammunition. (Requires weapon respawn on toggle)", 0, 1) end
--if GetConVar("sv_drc_infiniteammo") == nil then DRC.Convars_SV.InfiniteAmmo = CreateConVar("sv_drc_infiniteammo", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "0 off | 1 Infinite | 2 Bottomless Mag", 0, 2) end
if GetConVar("cl_drc_disable_errorhints") == nil then DRC.Convars_SV.ErrorHitns = CreateConVar("cl_drc_disable_errorhints", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Disables error hints from displaying.", 0, 1) end
--if GetConVar("sv_drc_playerrep_disallow") == nil then DRC.Convars_SV.SprintOverride = CreateConVar("sv_drc_playerrep_disallow", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Disables players from accessing playermodel customization from the Draconic Menu.", 0, 1) end
--if GetConVar("sv_drc_playerrep_tweakonly") == nil then DRC.Convars_SV.SprintOverride = CreateConVar("sv_drc_playerrep_tweakonly", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Limits players to only changing their colours/bodygroup/skin in the Draconic Menu. Set to 2 to limit it to colours only, or 3 for bodygroups only.", 0, 3) end
--if GetConVar("sv_drc_soundtime_disabled") == nil then DRC.Convars_SV.DisableTP = CreateConVar("sv_drc_soundtime_disabled", 0, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_DEMO}, "Pitch of audio changing with host_timescale", 0, 1) end
--if GetConVar("sv_drc_voicesets_noanimations") == nil then CreateConVar("sv_drc_voicesets_noanimations", 0, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_DEMO}, "Whether or not to disable animations from playing for the 'Help!' and 'Let's go!' voicesets.", 0, 1) end
--if GetConVar("sv_drc_attachments_disallowmodification") == nil then DRC.Convars_SV.SWEPAttachments = CreateConVar("sv_drc_attachments_disallowmodification", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Disallow players from modifying weapon attachments.", 0, 1) end
--if GetConVar("sv_drc_attachments_autounlock") == nil then DRC.Convars_SV.SWEPAttachments = CreateConVar("sv_drc_attachments_autounlock", 1, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "When enabled, weapons will spawn with all attachments unlocked. When disabled, only the default (first) attachment in each slot will be unlocked and others will need to be manually picked up or granted to the player by the server.", 0, 1) end

local CheeseGrater = {} -- this isn't a perfect solution by a longshot but it will stop most skids at least.

if CLIENT then
	net.Receive("DRC_SyncServerVar", function()
		local str, flt = net.ReadString(), net.ReadFloat()
		CheeseGrater[str] = flt
		DRC.SV[str] = flt
	end)
	
	local hn = "CheeseGrater".. tostring(math.Rand(0, 999999999)) ..""
	hook.Add("Think", hn, function()
		for k,v in pairs(CheeseGrater) do
			if DRC.SV[k] != CheeseGrater[k] then DRC.SV[k] = CheeseGrater[k] end
		end
	end)

	function DRC:DebugModeEnabled()
		if DRC:DebugModeAllowed() == true && GetConVar("cl_drc_debugmode"):GetFloat() != 0 then return true else return false end
	end

	if GetConVar("cl_playerhands") == nil then CreateConVar("cl_playerhands", "", {FCVAR_USERINFO, FCVAR_ARCHIVE, FCVAR_DEMO}, "c_arms for the player to use, if the server allows for customization of this.") end
	if GetConVar("cl_playerhands_bodygroups") == nil then CreateConVar("cl_playerhands_bodygroups", "", {FCVAR_USERINFO, FCVAR_ARCHIVE, FCVAR_DEMO}, "c_arms for the player to use, if the server allows for customization of this.") end
	if GetConVar("cl_playerhands_skin") == nil then CreateConVar("cl_playerhands_skin", "", {FCVAR_USERINFO, FCVAR_ARCHIVE, FCVAR_DEMO}, "c_arms for the player to use, if the server allows for customization of this.") end
	if GetConVar("cl_playercamo") == nil then CreateConVar("cl_playercamo", "nil", {FCVAR_USERINFO, FCVAR_ARCHIVE, FCVAR_DEMO}, "Camo to use on playermodel.") end
	if GetConVar("cl_drc_debugmode") == nil then CreateConVar("cl_drc_debugmode", 0, {FCVAR_USERINFO}, "Enables / Disables debug mode of the Draconic Base. (Requires sv_drc_allowdebug.)", 0, 2) end
	if GetConVar("cl_drc_debug_invertnearfar") == nil then CreateConVar("cl_drc_debug_invertnearfar", 0, {FCVAR_USERINFO}, "Inverts the near/far sound effect code.", 0, 1) end
	if GetConVar("cl_drc_debug_vmattachments") == nil then CreateConVar("cl_drc_debug_vmattachments", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Show/hide the viewmodel attachment visualizations.", 0, 1) end
	if GetConVar("cl_drc_debug_legacyassistant") == nil then CreateConVar("cl_drc_debug_legacyassistant", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Show/hide the old legacy debug window 'DSB Debug Assisstant'.", 0, 1) end
	if GetConVar("cl_drc_debug_crosshairmode") == nil then DRC.Convars_CL.Debug_Crosshair = CreateConVar("cl_drc_debug_crosshairmode", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "0: No debug crosshair \n 1: Standard debug crosshair /n 2: Melee travel path only /n 3: Full debug crosshair", 0, 3) end
	if GetConVar("cl_drc_debug_hitboxes") == nil then DRC.Convars_CL.Debug_Hitboxes = CreateConVar("cl_drc_debug_hitboxes", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/Disable hitbox rendering. Continuously draws the local player's hitboxes, and draws the hitboxes of whatever you are looking at.", 0, 1) end
	if GetConVar("cl_drc_debug_bounds") == nil then DRC.Convars_CL.Debug_Hitboxes = CreateConVar("cl_drc_debug_bounds", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/Disable collision bounds rendering. Continuously draws the local player's bounds, and draws the bounds of whatever you are looking at.", 0, 1) end
	if GetConVar("cl_drc_debug_tracelines") == nil then DRC.Convars_CL.Debug_Tracelines = CreateConVar("cl_drc_debug_tracelines", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/Disable rendering traces used by the Draconic Base. Detailed information about what each colour means can be found on the wiki.", 0, 1) end
	if GetConVar("cl_drc_debug_lights") == nil then DRC.Convars_CL.Debug_Lights = CreateConVar("cl_drc_debug_lights", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/Disable visualizing lights created by the Draconic Base.", 0, 1) end
	if GetConVar("cl_drc_debug_sounds") == nil then DRC.Convars_CL.Debug_Sounds = CreateConVar("cl_drc_debug_sounds", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/Disable visualizing lights created by the Draconic Base.", 0, 1) end
	if GetConVar("cl_drc_debug_cubemaps") == nil then DRC.Convars_CL.Debug_Cubemaps = CreateConVar("cl_drc_debug_cubemaps", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/Disable rendering the locations of env_cubemap entities.", 0, 1) end
	if GetConVar("cl_drc_debug_cubefallbacks") == nil then DRC.Convars_CL.Debug_Cubemaps = CreateConVar("cl_drc_debug_cubefallbacks", 0, {FCVAR_USERINFO}, "Enable/Disable forcing the Draconic Base to think that the current map does not have any envmaps.", 0, 1) end
	if GetConVar("cl_drc_debug_alwaysshowshields") == nil then DRC.Convars_CL.Debug_Shields = CreateConVar("cl_drc_debug_alwaysshowshields", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "When set to 1 all DRC shields will constantly render.", 0, 1) end
	if GetConVar("cl_drc_debug_hideshaderfixes") == nil then DRC.Convars_CL.Debug_ShaderFixes = CreateConVar("cl_drc_debug_hideshaderfixes", 0, {FCVAR_USERINFO}, "Hides ReflectionTint & ScalingRimLight proxy effects for the sake of showing with vs without.", 0, 1) end
	if GetConVar("cl_drc_lowered_crosshair") == nil then CreateConVar("cl_drc_lowered_crosshair", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable Halo-styled lowered crosshair, providing more vertical viewing space.", 0, 1)	end
	if GetConVar("cl_drc_experimental_fp") == nil then CreateConVar("cl_drc_experimental_fp", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/Disable experimental first person. (Compatibility with other addons not guaranteed.)", 0, 1) end
	if GetConVar("cl_drc_experimental_fp_chestscale") == nil then CreateConVar("cl_drc_experimental_fp_chestscale", 1, {FCVAR_USERINFO, FCVAR_ARCHIVE, FCVAR_DEMO}, "Scale inward your playermodel's chest region in first person if your playermodel is blocking your view.", 0, 1) end
	if GetConVar("cl_drc_testvar_0") == nil then CreateConVar("cl_drc_testvar_0", 0, {FCVAR_USERINFO}, "This variable is used to toggle experimental features, please use the menu to change these settings.", 0, 1) end
	if GetConVar("cl_drc_testvar_1") == nil then CreateConVar("cl_drc_testvar_1", 0, {FCVAR_USERINFO}, "This variable is used to toggle experimental features, please use the menu to change these settings.", 0, 1) end
	if GetConVar("cl_drc_testvar_2") == nil then CreateConVar("cl_drc_testvar_2", 0, {FCVAR_USERINFO}, "This variable is used to toggle experimental features, please use the menu to change these settings.", 0, 1) end
	if GetConVar("cl_drc_testvar_3") == nil then CreateConVar("cl_drc_testvar_3", 0, {FCVAR_USERINFO}, "This variable is used to toggle experimental features, please use the menu to change these settings.", 0, 1) end
	if GetConVar("cl_drc_testvar_4") == nil then CreateConVar("cl_drc_testvar_4", 0, {FCVAR_USERINFO}, "This variable is used to toggle experimental features, please use the menu to change these settings.", 0, 1) end
	if GetConVar("cl_drc_testvar_5") == nil then CreateConVar("cl_drc_testvar_5", 0, {FCVAR_USERINFO}, "This variable is used to toggle experimental features, please use the menu to change these settings.", 0, 1) end
	if GetConVar("cl_drc_testvar_6") == nil then CreateConVar("cl_drc_testvar_6", 0, {FCVAR_USERINFO}, "This variable is used to toggle experimental features, please use the menu to change these settings.", 0, 1) end
	if GetConVar("cl_drc_testvar_7") == nil then CreateConVar("cl_drc_testvar_7", 0, {FCVAR_USERINFO}, "This variable is used to toggle experimental features, please use the menu to change these settings.", 0, 1) end
	if GetConVar("cl_drc_testvar_8") == nil then CreateConVar("cl_drc_testvar_8", 0, {FCVAR_USERINFO}, "This variable is used to toggle experimental features, please use the menu to change these settings.", 0, 1) end
	if GetConVar("cl_drc_testvar_9") == nil then CreateConVar("cl_drc_testvar_9", 0, {FCVAR_USERINFO}, "This variable is used to toggle experimental features, please use the menu to change these settings.", 0, 1) end
	if GetConVar("cl_drc_thirdperson") == nil then CreateConVar("cl_drc_thirdperson", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/Disable Draconic Thirdperson.", 0, 1) end
	if GetConVar("cl_drc_thirdperson_flipside") == nil then CreateConVar("cl_drc_thirdperson_flipside", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Flip the thirdperson side the view is on.", 0, 1)	end
	if GetConVar("cl_drc_thirdperson_disable_freelook") == nil then CreateConVar("cl_drc_thirdperson_disable_freelook", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Disable freelook movement in third person.", 0, 1)	end
	if GetConVar("cl_drc_thirdperson_preset") == nil then CreateConVar("cl_drc_thirdperson_preset", "", {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Last loaded preset. Used to automatically select this at session start.") end
	DRC.Convars_CL.ForceEFP = false

--	if GetConVar("cl_drc_sway") == nil then CreateConVar("cl_drc_sway", 1, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/disable predictive-aim weapon swaying", 0, 1)end
	if GetConVar("cl_drc_voiceset") == nil then CreateConVar("cl_drc_voiceset", "None", {FCVAR_USERINFO, FCVAR_ARCHIVE}, "VoiceSet to use. (Can be overriden by servers.)") end
	if GetConVar("cl_drc_voiceset_automatic") == nil then CreateConVar("cl_drc_voiceset_automatic", 1, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Automatatically update your VoiceSet to what playermodel authors assign.", 0, 1) end
	
	if GetConVar("cl_drc_footstepset") == nil then CreateConVar("cl_drc_footstepset", "None", {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Footstep set to use. (Can be overriden by servers.)") end
	if GetConVar("cl_drc_footstepset_automatic") == nil then CreateConVar("cl_drc_footstepset_automatic", 1, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Automatatically update your footstep sounds to what playermodel authors assign.", 0, 1) end
	
	if GetConVar("drc_colour_r_player") == nil then
		CreateConVar("drc_colour_r_player", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
		CreateConVar("drc_colour_g_player", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
		CreateConVar("drc_colour_b_player", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
		CreateConVar("drc_colour_r_weapon", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
		CreateConVar("drc_colour_g_weapon", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
		CreateConVar("drc_colour_b_weapon", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
		CreateConVar("drc_colour_r_eye", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
		CreateConVar("drc_colour_g_eye", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
		CreateConVar("drc_colour_b_eye", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
		CreateConVar("drc_colour_r_energy", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
		CreateConVar("drc_colour_g_energy", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
		CreateConVar("drc_colour_b_energy", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
		CreateConVar("drc_colour_r_acc1", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
		CreateConVar("drc_colour_g_acc1", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
		CreateConVar("drc_colour_b_acc1", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
		CreateConVar("drc_colour_r_acc2", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
		CreateConVar("drc_colour_g_acc2", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
		CreateConVar("drc_colour_b_acc2", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
		CreateConVar("drc_colour_grunge", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end
	
	if GetConVar("cl_drc_sell_soul") == nil then CreateClientConVar("cl_drc_sell_soul", "1", true, false, "Give unto the dragon.", 0, 1) end
	if GetConVar("cl_drc_disable_crosshairs") == nil then CreateClientConVar("cl_drc_disable_crosshairs", "0", true, true, "Hides all DRC related crosshairs (except for debug mode)", 0, 1) end
	if GetConVar("cl_drc_eyecolour_r") == nil then CreateConVar("cl_drc_eyecolour_r", "127", {FCVAR_USERINFO, FCVAR_ARCHIVE}) end
	if GetConVar("cl_drc_eyecolour_g") == nil then CreateConVar("cl_drc_eyecolour_g", "127", {FCVAR_USERINFO, FCVAR_ARCHIVE}) end
	if GetConVar("cl_drc_eyecolour_b") == nil then CreateConVar("cl_drc_eyecolour_b", "127", {FCVAR_USERINFO, FCVAR_ARCHIVE}) end
	if GetConVar("cl_drc_energycolour_r") == nil then CreateConVar("cl_drc_energycolour_r", "127", {FCVAR_USERINFO, FCVAR_ARCHIVE}) end
	if GetConVar("cl_drc_energycolour_g") == nil then CreateConVar("cl_drc_energycolour_g", "127", {FCVAR_USERINFO, FCVAR_ARCHIVE}) end
	if GetConVar("cl_drc_energycolour_b") == nil then CreateConVar("cl_drc_energycolour_b", "127", {FCVAR_USERINFO, FCVAR_ARCHIVE}) end
	if GetConVar("cl_drc_tint1_r") == nil then CreateConVar("cl_drc_tint1_r", "127", {FCVAR_USERINFO, FCVAR_ARCHIVE}) end
	if GetConVar("cl_drc_tint1_g") == nil then CreateConVar("cl_drc_tint1_g", "127", {FCVAR_USERINFO, FCVAR_ARCHIVE}) end
	if GetConVar("cl_drc_tint1_b") == nil then CreateConVar("cl_drc_tint1_b", "127", {FCVAR_USERINFO, FCVAR_ARCHIVE}) end
	if GetConVar("cl_drc_tint2_r") == nil then CreateConVar("cl_drc_tint2_r", "127", {FCVAR_USERINFO, FCVAR_ARCHIVE}) end
	if GetConVar("cl_drc_tint2_g") == nil then CreateConVar("cl_drc_tint2_g", "127", {FCVAR_USERINFO, FCVAR_ARCHIVE}) end
	if GetConVar("cl_drc_tint2_b") == nil then CreateConVar("cl_drc_tint2_b", "127", {FCVAR_USERINFO, FCVAR_ARCHIVE}) end
	if GetConVar("cl_drc_vmoffset_x") == nil then CreateConVar("cl_drc_vmoffset_x", "0", {FCVAR_USERINFO, FCVAR_ARCHIVE}) end
	if GetConVar("cl_drc_vmoffset_y") == nil then CreateConVar("cl_drc_vmoffset_y", "0", {FCVAR_USERINFO, FCVAR_ARCHIVE}) end
	if GetConVar("cl_drc_vmoffset_z") == nil then CreateConVar("cl_drc_vmoffset_z", "0", {FCVAR_USERINFO, FCVAR_ARCHIVE}) end
	if GetConVar("cl_drc_playergrunge") == nil then CreateConVar("cl_drc_playergrunge", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}) end
	
	if GetConVar("cl_drc_menu_iconsize") == nil then CreateConVar("cl_drc_menu_iconsize", 3, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "") end
	if GetConVar("cl_drc_menu_iconsize_fullscreen") == nil then CreateConVar("cl_drc_menu_iconsize_fullscreen", 3, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "") end

	if GetConVar("cl_drc_showspray") == nil then CreateConVar("cl_drc_showspray", 1, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/disable showing your spray on content that supports it.", 0, 1) end
	if GetConVar("cl_drc_showspray_weapons") == nil then CreateConVar("cl_drc_showspray_weapons", 1, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/disable showing your spray on weapons that support it.", 0, 1) end
	if GetConVar("cl_drc_showspray_vehicles") == nil then CreateConVar("cl_drc_showspray_vehicles", 1, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/disable showing your spray on vehicles that support it.", 0, 1)	end
	if GetConVar("cl_drc_showspray_player") == nil then CreateConVar("cl_drc_showspray_player", 1, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/disable showing your spray on your player if the model support it.", 0, 1) end

	if GetConVar("cl_drc_accessibility_photosensitivity_muzzle") == nil then CreateConVar("cl_drc_accessibility_photosensitivity_muzzle", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE, FCVAR_DEMO}, "Dim the effects of the dynamic-light muzzle flashes on Draconic weapons", 0, 1) end
	if GetConVar("cl_drc_accessibility_colourblind") == nil then CreateConVar("cl_drc_accessibility_colourblind", "None", {FCVAR_USERINFO, FCVAR_ARCHIVE, FCVAR_DEMO}, "Probably a bad attempt at making game-wide colour correction for those who need it.") end
	if GetConVar("cl_drc_accessibility_colourblind_strength") == nil then CreateConVar("cl_drc_accessibility_colourblind_strength", 50, {FCVAR_USERINFO, FCVAR_ARCHIVE, FCVAR_DEMO}, "Colour blindness strength amount.", 0, 100) end
	if GetConVar("cl_drc_accessibility_amduser") == nil then CreateConVar("cl_drc_accessibility_amduser", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE, FCVAR_DEMO}, "Changes how certain stuff in the Draconic Base renders to be AMD compatible.", 0, 1) end
	
	if GetConVar("drc_lightcolour") == nil then CreateConVar("drc_lightcolour", 50, {FCVAR_USERINFO, FCVAR_ARCHIVE, FCVAR_DEMO}, "Convar used to easily pull your light level for serverside use.", 0, 100) end
	
	if GetConVar("r_fogcolour") == nil then CreateConVar("r_fogcolour", "127 127 127", {FCVAR_USERINFO, FCVAR_ARCHIVE, FCVAR_DEMO}, "Convar added by the Draconic Base for serverside to be able to get fog information about the current map.") end
	if GetConVar("r_fogstart") == nil then CreateConVar("r_fogstart", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE, FCVAR_DEMO}, "Convar added by the Draconic Base for serverside to be able to get fog information about the current map.") end
	if GetConVar("r_fogend") == nil then CreateConVar("r_fogend", 10000, {FCVAR_USERINFO, FCVAR_ARCHIVE, FCVAR_DEMO}, "Convar added by the Draconic Base for serverside to be able to get fog information about the current map.") end
	if GetConVar("r_fogdensity") == nil then CreateConVar("r_fogdensity", 0.9, {FCVAR_USERINFO, FCVAR_ARCHIVE, FCVAR_DEMO}, "Convar added by the Draconic Base for serverside to be able to get fog information about the current map.") end
end