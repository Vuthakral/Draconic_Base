DRC = {}
DRC.MapInfo = {}
DRC.VoiceSets = {}
DRC.FootSteps = {}
DRC.Categories = {}
DRC.Spotlights = {}
if SERVER then 
	resource.AddWorkshop("1847505933") -- Makes the base auto-download for clients joining your server.
	AddCSLuaFile("draconic/load.lua")
end
include("draconic/load.lua")

list.Set( "DesktopWindows", "Draconic Menu", {
	title = "Draconic Menu",
	icon = "icon64/draconic_base.png",
	init = function( icon, window )
		DRCMenu(LocalPlayer())
		RunConsoleCommand("-menu_context")
	end
} )

-- Defining useful globals for content developers
SNDLVL_TALKING = 80
SNDLVL_VEHICLE = 105
SNDLVL_ENERGYFIRESILENCED = 90
SNDLVL_ENERGYFIRE = 100
SNDLVL_GUNFIRESILENCED = 115
SNDLVL_GUNFIRE = 140

-- Any code beyond this point is considered legacy and should NOT be used as reference, or at all.
-- Anything below is likely to be removed in a future update.

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