local CLDir = "draconic/cl"
local SVDir = "draconic/sv"
local DRCAddons = "draconic/addons"
local DRCPlayermodels = "draconic/addons/playermodels"

if SERVER then AddCSLuaFile("draconic/lib.lua") end
include("draconic/lib.lua")

function DRC:AddFile( File, directory )
	local prefix = string.lower( string.Left( File, 3 ) )

	if SERVER and directory == "draconic/sv/" then
		include( directory .. File )
		print( "[Draconic Base] Loading server script: " .. File )
	elseif directory == "draconic/cl/" then
		if SERVER then
			AddCSLuaFile( directory .. File )
			print( "[Draconic Base] Registering clientside script: " .. File )
		elseif CLIENT then
			include( directory .. File )
			print( "[Draconic Base] Loading clientside script: " .. File )
		end
	elseif directory == "draconic/addons/" then
		if SERVER then
			AddCSLuaFile( directory .. File )
			print( "[Draconic Base] Registering addon's script: " .. File )
		elseif CLIENT then
			include( directory .. File )
			print( "[Draconic Base] Loading addon's script: " .. File )
		end
	elseif directory == "draconic/addons/playermodels/" then
		if SERVER then
			AddCSLuaFile( directory .. File )
			print( "[Draconic Base] Registering playermodel script: " .. File )
		elseif CLIENT then
			include( directory .. File )
			print( "[Draconic Base] Loading playermodel script: " .. File )
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

DRC:IncludeDir( CLDir )
DRC:IncludeDir( SVDir )
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
		
		DRC:IncludeDir( CLDir )
		DRC:IncludeDir( SVDir )
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