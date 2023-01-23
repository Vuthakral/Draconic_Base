local CLDir = "draconic/cl"
local SVDir = "draconic/sv"
local SHDir = "draconic/sh"
local DRCAddons = "draconic/addons"
local DRCPlayermodels = "draconic/addons/playermodels"

function DRC:Load()
	if SERVER then AddCSLuaFile("draconic/drc_lib.lua") end
	include("draconic/drc_lib.lua")
	MsgC(Color(0, 255, 0), "[Draconic Base] ", Color(255, 255, 255), "Loading Draconic library...\n")
end

function DRC:AddFile( File, directory )
	local prefix = string.lower( string.Left( File, 3 ) )

	if directory == "draconic/sh/" then
		if SERVER then AddCSLuaFile( directory .. File ) end
		include( directory .. File )
		MsgC(Color(0, 255, 0), "[Draconic Base] ", Color(255, 255, 255), "Registering & Loading shared script: ", Color(103, 169, 137), "".. tostring(File) .."\n")
	elseif SERVER and directory == "draconic/sv/" then
		include( directory .. File )
		MsgC(Color(0, 255, 0), "[Draconic Base] ", Color(255, 255, 255), "Loading server script: ", Color(3, 169, 244), "".. tostring(File) .."\n")
	elseif directory == "draconic/cl/" then
		if SERVER then
			AddCSLuaFile( directory .. File )
			MsgC(Color(0, 255, 0), "[Draconic Base] ", Color(255, 255, 255), "Registering clientside script: ", Color(222, 169, 9), "".. tostring(File) .."\n")
		elseif CLIENT then
			include( directory .. File )
			MsgC(Color(0, 255, 0), "[Draconic Base] ", Color(255, 255, 255), "Loading clientside script: ", Color(222, 169, 9), "".. tostring(File) .."\n")
		end
	end
end

function DRC:IncludeDir( directory )
	directory = directory .. "/"

	local files, directories = file.Find( directory .. "*", "LUA" )

	for _, v in ipairs( files ) do
		if string.EndsWith( v, ".lua" ) then
			DRC:AddFile( v, directory )
		end
	end

	for _, v in ipairs( directories ) do
	--	print( "[Draconic Base] Directory: " .. v )
		DRC:IncludeDir( directory .. v )
	end
end

if CLIENT then
	if !file.Exists("draconic", "DATA") then file.CreateDir("draconic") end
	if !file.Exists("draconic/sprays", "DATA") then file.CreateDir("draconic/sprays") end
	if !file.Exists("draconic/avatars", "DATA") then file.CreateDir("draconic/avatars") end
end

DRC:Load()
DRC:IncludeDir( CLDir )
DRC:IncludeDir( SVDir )
DRC:IncludeDir( SHDir )
DRC:IncludeDir( DRCAddons )
DRC:IncludeDir( DRCPlayermodels )

if SERVER then
	concommand.Add("drc_reload", function(ply, cmd, args)
		local terminate = false
		if IsValid(ply) then
			if !ply:IsAdmin() then terminate = true end
			if terminate == false then MsgC(Color(255, 0, 0), "<<DRACONIC BASE WARNING>> ".. ply:Name() .." (".. ply:SteamID64() ..") has reloaded the Draconic Base!\n") end
		else
			MsgC(Color(255, 0, 0), "<<DRACONIC BASE WARNING>> The server was told to reload the Draconic Base!\n")
		end
		if terminate == true then return end
		
		if CLIENT then
			DRC.CSPlayerModel:Remove()
		end
		
		DRC:Load()
		DRC:IncludeDir( CLDir )
		DRC:IncludeDir( SVDir )
		DRC:IncludeDir( SHDir )
		DRC:IncludeDir( DRCAddons )
		DRC:IncludeDir( DRCPlayermodels )
		
		if SERVER then
			net.Start("DRC_MapVersion")
			local info = { ply, game.GetMapVersion() }
			net.WriteTable(info)
			net.Send(ply)
		end
	end)
end

concommand.Add("drc_debug_dropweapon", function(ply)
	if IsValid(ply) && GetConVarNumber("sv_drc_allowdebug") == 1 then
		ply:DropWeapon()
	end
end)