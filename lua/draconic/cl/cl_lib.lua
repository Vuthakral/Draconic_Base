DRC.Menu = {}

DRC.ThirdPerson = {}
DRC.ThirdPerson.DefaultOffsets = {
	[""] = Vector(45, -25, 0),
	["default"] = Vector(25, 0, 0),
	["pistol"] = Vector(45, -25, 0),
	["smg"] = Vector(45, -25, 0),
	["grenade"] = Vector(5, 0, 20),
	["ar2"] = Vector(45, -25, 0),
	["shotgun"] = Vector(55, -25, 0),
	["rpg"] = Vector(25, -15, 10),
	["physgun"] = Vector(25, -15, 0),
	["crossbow"] = Vector(45, -20, 0),
	["melee"] = Vector(55, -17.5, 0),
	["melee2"] = Vector(55, -22.5, 0),
	["slam"] = Vector(55, -25, 0),
	["normal"] = Vector(35, 0, 10),
	["fist"] = Vector(45, -15, 5),
	["passive"] = Vector(35, 0, 10),
	["knife"] = Vector(45, -15, 0),
	["duel"] = Vector(35, 0, 15),
	["camera"] = Vector(50, 0, 15),
	["magic"] = Vector(45, 0, 15),
	["revolver"] = Vector(50, -25, 0),
}
DRC.ThirdPerson.Offset = Vector()

if game.SinglePlayer() then
	if GetConVar("cl_drc_debug_alwaysshowshields") == nil then
		DRC.Convars_SV.ViewDrag = CreateConVar("cl_drc_debug_alwaysshowshields", 0, {FCVAR_ARCHIVE, FCVAR_DEMO}, "Always show shield effect (singleplayer only).", 0, 1)
	end
end

function DRC:MakeShield(ent)
	if !IsValid(ent.ShieldEntity) then
		local shield = ents.CreateClientside("drc_shieldmodel")
		shield.FollowEnt = ent
		shield:Spawn()
	else return end
	
	timer.Simple(0.3, function()
		if !IsValid(ent.ShieldEntity) then
			local shield = ents.CreateClientside("drc_shieldmodel")
			shield.FollowEnt = ent
			shield:Spawn()
		end
	end)
end

net.Receive("DRC_MakeShieldEnt", function(l, ply)
	local ent = net.ReadEntity()
	
	DRC:MakeShield(ent)
end)

function DRC:GetCustomizationAllowed()
	local gamemode = tostring(engine.ActiveGamemode())
	local svtoggle = GetConVar("sv_drc_playerrep_disallow"):GetFloat()
	local svtweaktoggle = GetConVar("sv_drc_playerrep_tweakonly"):GetFloat()
	
	if svtoggle == 1 then return false end
	if svtweaktoggle == 1 then return nil end
	
	local allowedGMs = {
		["sandbox"] = "E",
	}
	local tweakGMs = {
		["darkrp"] = "E",
		["helix"] = "E",
		["cwrp"] = "E",
	}
	
	if allowedGMs[gamemode] then return true end
	if tweakGMs[gamemode] then return nil end
end

net.Receive("DRC_UpdatePlayermodel", function()
	local tbl = net.ReadTable()
	
	local ent = tbl.player
	local skin = tbl.skin
	local bgs = tbl.bodygroups
	local colours = tbl.colours
	local model = tbl.model
	
	ent:SetModel(model)
	ent:SetSkin(skin)
	ent:SetBodyGroups(bgs)
	DRC:RefreshColours(ent)
end)