DRC.Convars_CL = {}
DRC.Convars_SV = {}

if GetConVar("sv_drc_movement") == nil then
	DRC.Convars_SV.Movement = CreateConVar("sv_drc_movement", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables the custom movement modifiers of ALL weapons made on the Draconic SWEP Base.", 0, 1)
end

if GetConVar("sv_drc_movesounds") == nil then
	DRC.Convars_SV.MoveSounds = CreateConVar("sv_drc_movesounds", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables the custom sprint/jump sounds of ALL weapons made on the Draconic SWEP Base.", 0, 1)
end

if GetConVar("sv_drc_callofdutyspread") == nil then
	DRC.Convars_SV.CoDSpread = CreateConVar("sv_drc_callofdutyspread", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Do you hate 'Call of Duty aim' where weapon spread is unrealistically reduced when aiming down the sights? Me too! Unfortunately for you, people begged me to add it to my base anyways. But fortunately for you, I tied it all to a serverside config to disable it entirely!", 0, 1)
end

if GetConVar("sv_drc_force_sprint") == nil then
	DRC.Convars_SV.SprintOverride = CreateConVar("sv_drc_force_sprint", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Forces all DSB weapons to use the passive-sprint system, regardless of SWEP author intention.", 0, 1)
end

if GetConVar("sv_drc_maxrmour") == nil then
	CreateConVar("sv_drc_maxrmour", 250, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_DEMO}, "Maximum armour a DSB weapon can reapply to.")
end

if GetConVar("sv_drc_disable_distgunfire") == nil then
	DRC.Convars_SV.DistGunfire = CreateConVar("sv_drc_disable_distgunfire", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "If true, disables distant gunfire for weapons. Alleviates network traffic on huge (100+ player) servers.", 0, 1)
end

if GetConVar("sv_drc_inspections") == nil then
	DRC.Convars_SV.Inspection = CreateConVar("sv_drc_inspections", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables the ability to access the inspection mode, which shows weapon stats & puts the viewmodel in an alternate view.", 0, 1)
end

if GetConVar("sv_drc_inspect_hideHUD") == nil then
	DRC.Convars_SV.Inspection_HideHUD = CreateConVar("sv_drc_inspect_hideHUD", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables the ability to see the inspection menu which shows weapon stats.", 0, 1)
end

if GetConVar("sv_drc_passives") == nil then
	DRC.Convars_SV.Passives = CreateConVar("sv_drc_passives", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables the ability to put weapons in a passive stance.", 0, 1)
end

if GetConVar("sv_drc_viewdrag") == nil then
	DRC.Convars_SV.ViewDrag = CreateConVar("sv_drc_viewdrag", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables first person camera drag effects with animations.", 0, 1)
end

if GetConVar("sv_drc_allowdebug") == nil then
	DRC.Convars_SV.AllowDebug = CreateConVar("sv_drc_allowdebug", 0, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_DEMO}, "Allows all players to access the debug menu of the Draconic Base.", 0, 1)
end

if GetConVar("sv_drc_disable_thirdperson") == nil then
	DRC.Convars_SV.DisableTP = CreateConVar("sv_drc_disable_thirdperson", 0, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_DEMO}, "Disables Draconic thirdperson when not using a weapon which requires it.", 0, 1)
end

if GetConVar("sv_drc_disable_crosshairs") == nil then
	DRC.Convars_SV.DisableCrosshairs = CreateConVar("sv_drc_disable_crosshairs", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enable/Disable SWEP base crosshairs for all clients. Clients can still disable them on their own, but this can prevent them from using them.", 0, 1)
end

if GetConVar("sv_drc_forcebasegameammo") == nil then
	DRC.Convars_SV.BaseGameAmmo = CreateConVar("sv_drc_forcebasegameammo", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Force Draconic weaapons to use standard base-game ammunition. (Requires weapon respawn on toggle)", 0, 1)
end

if GetConVar("cl_drc_disable_errorhints") == nil then
	DRC.Convars_SV.ErrorHitns = CreateConVar("cl_drc_disable_errorhints", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Disables error hints from displaying.", 0, 1)	
end

if GetConVar("sv_drc_disable_attachmentmodifying") == nil then
	DRC.Convars_SV.SWEPAttachments = CreateConVar("sv_drc_disable_attachmentmodifying", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Disallow players from modifying weapon attachments.", 0, 1)	
end

if GetConVar("sv_drc_playerrep_disallow") == nil then
	DRC.Convars_SV.SprintOverride = CreateConVar("sv_drc_playerrep_disallow", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Disables players from accessing playermodel customization from the Draconic Menu.", 0, 1)
end

if GetConVar("sv_drc_playerrep_tweakonly") == nil then
	DRC.Convars_SV.SprintOverride = CreateConVar("sv_drc_playerrep_tweakonly", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Limits players to only changing their colours/bodygroup/skin in the Draconic Menu.", 0, 1)
end

if CLIENT then
	if GetConVar("cl_drc_debugmode") == nil then
		DRC.Convars_CL.Debug = CreateConVar("cl_drc_debugmode", 0, {FCVAR_USERINFO}, "Enables / Disables debug mode of the Draconic Base. (Requires sv_drc_allowdebug.)", 0, 2)
	end

	if GetConVar("cl_drc_debug_invertnearfar") == nil then
		DRC.Convars_CL.Debug_InvertSounds = CreateConVar("cl_drc_debug_invertnearfar", 0, {FCVAR_USERINFO}, "Inverts the near/far sound effect code.", 0, 1)
	end

	if GetConVar("cl_drc_debug_vmattachments") == nil then
		DRC.Convars_CL.Debug_VMAttachments = CreateConVar("cl_drc_debug_vmattachments", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Show/hide the viewmodel attachment visualizations.", 0, 1)
	end

	if GetConVar("cl_drc_debug_legacyassistant") == nil then
		DRC.Convars_CL.Debug_Legacy = CreateConVar("cl_drc_debug_legacyassistant", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Show/hide the old legacy debug window 'DSB Debug Assisstant'.", 0, 1)
	end

	if GetConVar("cl_drc_debug_crosshairmode") == nil then
		DRC.Convars_CL.Debug_Crosshair = CreateConVar("cl_drc_debug_crosshairmode", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "0: No debug crosshair \n 1: Standard debug crosshair /n 2: Melee travel path only /n 3: Full debug crosshair", 0, 3)
	end

	if GetConVar("cl_drc_lowered_crosshair") == nil then
		DRC.Convars_CL.EnableLowCrosshair = CreateConVar("cl_drc_lowered_crosshair", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable Halo-styled lowered crosshair, providing more vertical viewing space.", 0, 1)	
	end

	if GetConVar("cl_drc_experimental_fp") == nil then
		DRC.Convars_CL.EnableEFP = CreateConVar("cl_drc_experimental_fp", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/Disable experimental first person. (Compatibility with other addons not guaranteed.)", 0, 1)	
	end
	
	if GetConVar("cl_drc_thirdperson") == nil then
		DRC.Convars_CL.EnableTP = CreateConVar("cl_drc_thirdperson", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/Disable Draconic Thirdperson.)", 0, 1)	
	end
	
	if GetConVar("cl_drc_thirdperson_flipside") == nil then
		DRC.Convars_CL.TP_FlipShoulder = CreateConVar("cl_drc_thirdperson_flipside", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Flip the thirdperson side the view is on.)", 0, 1)	
	end
	
	DRC.Convars_CL.ForceEFP = false

	if GetConVar("cl_drc_sway") == nil then
		DRC.Convars_CL.VMSway = CreateConVar("cl_drc_sway", 1, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/disable predictive-aim weapon swaying", 0, 1)
	end

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
	end

	if GetConVar("cl_drc_showspray") == nil then
		CreateConVar("cl_drc_showspray", 1, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/disable showing your spray on content that supports it.", 0, 1)	
	end

	if GetConVar("cl_drc_showspray_weapons") == nil then
		CreateConVar("cl_drc_showspray_weapons", 1, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/disable showing your spray on weapons that support it.", 0, 1)	
	end

	if GetConVar("cl_drc_showspray_vehicles") == nil then
		CreateConVar("cl_drc_showspray_vehicles", 1, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/disable showing your spray on vehicles that support it.", 0, 1)	
	end

	if GetConVar("cl_drc_showspray_player") == nil then
		CreateConVar("cl_drc_showspray_player", 1, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable/disable showing your spray on your player if the model support it.", 0, 1)	
	end
end