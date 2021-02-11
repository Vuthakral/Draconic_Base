if CLIENT or SERVER then
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("shared.lua")

	include("shared.lua")
	include("sh_funcs.lua")
end

if SERVER then
	resource.AddFile("materials/overlays/draconic_scope.vmt")
	resource.AddFile("materials/overlays/draconic_scope.vtf")
	resource.AddFile("materials/overlays/draconic_scope_refract.vtf")
else end