DRC = {}
DRC.MapInfo = {}
DRC.VoiceSets = {}
if SERVER then 
	resource.AddWorkshop("1847505933") -- Makes the base auto-download for clients joining your server.
	AddCSLuaFile("draconic/load.lua")
end
include("draconic/load.lua")

hook.Add("PreRegisterSWEP", "DRC_NPCWeaponList", function(swep, cl)
	if !string.find(cl, "drc_") then return end
	local ignore = {"drc_camera", "drc_cubemap" }
	local bases = {"draconic_melee_base", "draconic_gun_base", "draconic_battery_base"}
	if ignore[cl] then return end
	
	if swep.NPCSpawnable == false then return end
	
	list.Add("NPCUsableWeapons", {class = cl, title = "[DRC] ".. swep.PrintName .."", category = Category})
end)

list.Set( "DesktopWindows", "Draconic Menu", {
	title = "Draconic Base",
	icon = "icon64/draconic_base.png",
	init = function( icon, window )
		DRCMenu(LocalPlayer())
	end
} )

-- Any code beyond this point is considered legacy and should NOT be used as reference.

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

function DRCSound(source, near, far, distance, listener)
	if CLIENT then return end
	if !IsValid(source) then return end
	
	DRC:EmitSound(source, near, far, distance, listener)
end

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