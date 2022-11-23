if CLIENT or SERVER then
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("shared.lua")

	include("shared.lua")
	include("sh_funcs.lua")
end