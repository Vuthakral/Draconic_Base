Draconic = {
	["Version"] = 1.01,
	["Help"] = "https://github.com/Vuthakral/Draconic_Base/wiki",
	["Author"] = "Vuthakral",
}

if SERVER then AddCSLuaFile("sh/convars.lua") end
include("sh/convars.lua")

DRC.MapInfo = {}

if SERVER then
	DRC.MapInfo.NavMesh = navmesh.GetAllNavAreas()
	
	hook.Add( "InitPostEntity", "DRC_GetNavMeshInfo", function()
		timer.Simple(10, function() DRC.MapInfo.NavMesh = navmesh.GetAllNavAreas() end)
	end)
end

DRC.CalcView = {
	["Pos"] = Vector(),
	["Ang"] = Angle(),
	["HitPos"] = Vector(),
	["ToScreen"] = {},
	["wallpos"] = Vector(),
}

DRC.PlayerInfo = {}
DRC.PlayerInfo.ViewOffsets = {}
DRC.PlayerInfo.ViewOffsets.Defaults = { ["Standing"] = Vector(0, 0, 64), ["Crouched"] = Vector(0, 0, 28)}

DRC.Skel = {
	["Spine"] = { ["Name"] = "ValveBiped.Bip01_Spine", ["Scale"] = Vector(1,0.65,1) },
	["Spine1"] = { ["Name"] = "ValveBiped.Bip01_Spine1", ["Scale"] = Vector(1,0.65,1) },
	["Spine2"] = { ["Name"] = "ValveBiped.Bip01_Spine2", ["Scale"] = Vector(1,0.5,1) },
	["Spine4"] = { ["Name"] = "ValveBiped.Bip01_Spine4", ["Scale"] = Vector(1,0.5,1) },
	["Neck"] = { ["Name"] = "ValveBiped.Bip01_Neck1", ["Offset"] = Vector(-100,-25,0) },
	["LeftArm"] = { ["Name"] = "ValveBiped.Bip01_L_Clavicle", ["Offset"] = Vector(0, -200, 0) },
	["RightArm"] = { ["Name"] = "ValveBiped.Bip01_R_Clavicle", ["Offset"] = Vector(0, -200, 0) },
	["LeftHand"] = { ["Name"] = "ValveBiped.Bip01_L_Hand", ["Offset"] = Vector(0, 0, 0) },
	["RightHand"] = { ["Name"] = "ValveBiped.Bip01_R_Hand", ["Offset"] = Vector(0, 0, 0) },
}

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
DRC.MaterialCategories.Stone = {
	"MAT_CONCRETE",
	"MAT_BRICK",
	"MAT_PLASTER",
	"MAT_DIRT",
	"MAT_ROCK",
	"MAT_GRASS",
}

DRC.MaterialCategories.Metal = {
	"MAT_STRIDER",
	"MAT_HUNTER",
	"MAT_PAINTCAN",
	"MAT_POPCAN",
	"MAT_CANISTER",
	"MAT_VENT",
	"MAT_GRENADE",
	"MAT_WEAPON",
	"MAT_METAL",
	"MAT_METALVEHICLE",
	"MAT_COMBINE_METAL",
	"MAT_GUNSHIP",
	"MAT_ROLLER",
	"MAT_SOLIDMETAL",
	"MAT_SLIPPERYMETAL",
	"MAT_METALPANEL",
	"MAT_METAL_BARREL",
	"MAT_FLOATING_METAL_BARREL",
	"MAT_METAL_BOX",
	"MAT_GRATE",
	"MAT_COMPUTER",
	"MAT_ITEM",
	"MAT_JALOPY",
	"MAT_AIRBOAT",
}

DRC.MaterialCategories.Dust = {
	"MAT_DEFAULT",
	"MAT_PLASTIC",
	"MAT_PLASTIC_BARREL",
	"MAT_VENT",
	"MAT_CONCRETE",
	"MAT_BRICK",
	"MAT_PLASTER",
	"MAT_DIRT",
	"MAT_ROCK",
	"MAT_SAND",
	"MAT_GRASS",
	"MAT_CARDBOARD",
	"MAT_POTTERY",
	"MAT_SNOW",
}

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
	local LeftHand = ent:LookupBone("ValveBiped.Bip01_L_Hand")
	local RightHand = ent:LookupBone("ValveBiped.Bip01_R_Hand")
	local Spine = ent:LookupBone("ValveBiped.Bip01_Spine")
	local Spine1 = ent:LookupBone("ValveBiped.Bip01_Spine1")
	local Spine2 = ent:LookupBone("ValveBiped.Bip01_Spine2")
	local Spine4 = ent:LookupBone("ValveBiped.Bip01_Spine4")
	local LeftClav = ent:LookupBone("ValveBiped.Bip01_L_Clavicle")
	local RightClav = ent:LookupBone("ValveBiped.Bip01_R_Clavicle")
	local LeftThigh = ent:LookupBone("ValveBiped.Bip01_L_Thigh")
	local RightThigh = ent:LookupBone("ValveBiped.Bip01_R_Thigh")
	
	if !LeftHand or !RightHand or !Spine1 or !Spine2 or !Spine4 or !LeftClav or !RightClav or !LeftThigh or !RightThigh then return false
	elseif ent:GetBoneParent(Spine1) != Spine then return false
	else return true end
end

function DRC:SightsDown(ent, irons)
	if !IsValid(ent) then return end
	if irons == nil then irons = false end
	
	if ent.UniqueFiremode then -- ASTW2's unique camera stuff
		if ent:GetNWBool("insights") == true then return true else return false end
	end
	
	if !irons then
		if ent.Draconic then
			if ent.Secondary.Scoped == true then return ent.SightsDown else return false end
		elseif ent.IsTFAWeapon then
			return ent:GetIronSights()
		elseif ent.ASTWTWO then
			if ent.TrueScope == true && ent:GetNWBool("insights") == true then return true else return false end
		end
	else
		if ent.Draconic then
			if ent.Secondary.Scoped == true then return ent.SightsDown else return false end
		end
	end
end

local ConversionRates = {
	["km"] = 0.0000254,
	["m"] = 0.0254,
	["cm"] = 2.54,
	["mm"] = 25.4,
	
	["in"] = 1,
	["ft"] = 0.08333,
	["yd"] = 0.02777,
	["mile"] = 1 / 63360,
}

function DRC:ConvertUnit(input, output)
	if !ConversionRates[tostring(output)] then print("Draconic Base: Requested unit conversion ''".. tostring(output) .."'' is not valid!") end
	local inches = input * 0.75
	return inches * ConversionRates[output]
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
			["Eye"] 	= ent:GetNWVector("ColourTintVec1") / 255,
			["Energy"] 	= ent:GetNWVector("EnergyTintVec"),
		}
	else
		coltab = {
			["Player"] 	= ent:GetNWVector("PlayerColour_DRC"),
			["Weapon"] 	= ent:GetNWVector("WeaponColour_DRC"),
			["Tint1"] 	= ent:GetNWVector("ColourTintVec1") / 255,
			["Tint2"] 	= ent:GetNWVector("ColourTintVec2") / 255,
			["Eye"] 	= ent:GetNWVector("ColourTintVec1") / 255,
			["Energy"] 	= ent:GetNWVector("EnergyTintVec"),
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
	if !IsValid(source) then return end
	if near == nil && far == nil then return end
	if far == nil && near != nil then source:EmitSound(near) return end
	
	source:EmitSound(near)

	if CLIENT then return end
	local nt = {}
	nt.Src = source
	nt.Near = near
	nt.Far = far
	nt.Dist = distance
	nt.List = listener

	net.Start("DRCSound")
	net.WriteTable(nt)
	net.Broadcast()
	
	if distance && hint then sound.EmitHint(hint, source:GetPos(), math.Rand(distance/5, distance), 0.25, source) end
end

function DRC:TraceAngle(start, nd)
	return (nd - start):Angle()
end

function DRC:Interact(ply, movement, ent)
	if !IsValid(ply) then return end
	if !ply:Alive() then return end
	
	if IsValid(ent) then ply:SetNWEnt("Interacted_Entity", ent) end
	if movement == nil then movement = false end
	ply:SetNWBool("Interacting", true)
	ply:SetNWBool("Interacting_StopMovement", movement)
end

function DRC:BreakInteraction(ply, ent)
	if IsValid(ent) then ply:SetNWEnt("Interacted_Entity", nil) end
	ply:SetNWBool("Interacting", false)
	ply:SetNWBool("Interacting_StopMovement", false)
end

function DRC:ProjectedTexture(ent, att, tbl)
--	print(ent, att)
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
		if pos:IsPlayer() or pos:IsNPC() or pos:IsNextBot() then
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
--		print(i, Angle(angx, angy, 0), dist)
		
		score = score + dist
		if i == 4 then
			score = score / 5
			return score
		end
	end
end

--- Credit: Kinyom -- https://github.com/Kinyom -- https://github.com/Facepunch/garrysmod-requests/issues/1779
-- anything I slapped "drc" onto is just to ensure it remains unique and doesn't risk being incompatible with anything.
if CLIENT then
local drc_LUMP_CUBEMAPS = 42 -- THIS is the juicy stuff
 
drc_cubeLookup = {}
 
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
    end
end

hook.Add( "InitPostEntity", "DRC_GetCubemapInfo", function()
    DRC_CollectCubemaps( game.GetMap() )
end )
end
-- End cubemap collection code

function DRC:DLight(ent, pos, col, size, lifetime, emissive)
	local HDR = render.GetHDREnabled()

	if emissive == nil then emissive = false end
	if IsEntity(ent) then ent = ent:EntIndex() end
	local dl = DynamicLight(ent, emissive)
	dl.pos = pos
	dl.r = col.r
	dl.g = col.g
	dl.b = col.b
	dl.brightness = col.a
	dl.Decay = (1000 / lifetime)
	dl.size = size
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
		el.DieTime = CurTime() + lifetime
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
	local info = { ply, game.GetMapVersion() }
	net.WriteTable(info)
	net.Send(ply)
end)

hook.Add("PlayerSpawn", "drc_DoPlayerSettings", function(ply)
	DRC:RefreshColours(ply)
	ply:SetNWBool("Interacting", false)
	ply:SetNWString("Draconic_ThirdpersonForce", nil)
	ply:SetNWBool("ShowSpray_Ents", ply:GetInfoNum("cl_drc_showspray", 0))
	ply:SetNWBool("ShowSpray_Weapons", ply:GetInfoNum("cl_drc_showspray_weapons", 0))
	ply:SetNWBool("ShowSpray_Vehicles", ply:GetInfoNum("cl_drc_showspray_vehicles", 0))
	ply:SetNWBool("ShowSpray_Player", ply:GetInfoNum("cl_drc_showspray_player", 0))
	
	net.Start("DRC_RequestSprayInfo")
	net.Broadcast()
	
--[[	local hands = ply:GetHands()
	if !hands then return end
	local hbg = hands:GetBodyGroups()
	
	local convar = GetConVar("cl_playerbodygroups")
	hands:SetBodyGroups(convar) --]]
end)

hook.Add("StartCommand", "drc_InteractionBlocks", function(ply, cmd)
	local bool1 = ply:GetNWBool("Interacting")
	local bool2 = ply:GetNWBool("Interacting_StopMovement")
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

hook.Add("PlayerTick", "drc_movementhook", function(ply)
	if GetConVar("sv_drc_movement"):GetString() == "0" then return end
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
		
	if GetConVar("sv_drc_movesounds"):GetString() == "1" then
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

local function PlayReadyAnim(ply, anim)
	if !IsValid(ply) then 
		DRCNotify(nil, nil, "critical", "Player entity is null?! Something might be seriously wrong with your gamemode, that's all I know!", ENUM_ERROR, 10)
	return end
	
	if wOS then return end -- temp
	
	local seq = ply:SelectWeightedSequence(anim)
	local dur = ply:SequenceDuration(seq)
	
	local wpn = ply:GetActiveWeapon()
	
	if ply.DrcLastWeaponSwitch == nil then ply.DrcLastWeaponSwitch = CurTime() end
	
	if IsValid(ply) then
		DRCCallGesture(ply, GESTURE_SLOT_CUSTOM, anim, true)
		ply.DrcLastWeaponSwitch = CurTime() + dur
		
		if SERVER then
			net.Start("OtherPlayerWeaponSwitch")
			net.WriteEntity(ply)
			net.WriteString(anim)
			net.Broadcast()
		end
	end
end

hook.Add( "PlayerSwitchWeapon", "drc_weaponswitchanim", function(ply, ow, nw)
	local neww = nw:GetClass()
	if !SERVER then return end
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
	
	local generic 	= ACT_DEPLOY
	local low 		= ACT_DOD_DEPLOY_MG
	local high 		= ACT_DOD_DEPLOY_TOMMY
	local rifle 	= ACT_RUN_AIM_RIFLE
	local dual		= ACT_VM_DEPLOY_1
	local pistol 	= ACT_RUN_AIM_PISTOL
	local melee 	= ACT_DOD_STAND_AIM_KNIFE
	local melee2 	= ACT_MP_STAND_MELEE
	local reset 	= ACT_RESET
	
	local geseq = ply:SelectWeightedSequence(generic)
	local gedur = ply:SequenceDuration(geseq)
	local loseq = ply:SelectWeightedSequence(low)
	local lodur = ply:SequenceDuration(loseq)
	local hiseq = ply:SelectWeightedSequence(high)
	local hidur = ply:SequenceDuration(hiseq)
	local riseq = ply:SelectWeightedSequence(rifle)
	local ridur = ply:SequenceDuration(riseq)
	local piseq = ply:SelectWeightedSequence(pistol)
	local pidur = ply:SequenceDuration(piseq)
	local meseq = ply:SelectWeightedSequence(melee)
	local medur = ply:SequenceDuration(meseq)
	local m2seq = ply:SelectWeightedSequence(melee2)
	local m2dur = ply:SequenceDuration(m2seq)
	
	if nw:IsScripted() then
		local newstats = weapons.GetStored(neww)
		local newht = newstats.HoldType
		
		if nw.ASTWTWO == true then
			if nw.Melee == true then newht = newstats.HoldType_Lowered end
			if nw.Melee != true then newht = newstats.HoldType_Hipfire end
		end
		
		local onehand = { "pistol", "slam", "magic" }
		local twohand = { "smg", "ar2", "shotgun", "crossbow", "camera", "revolver" }
		local dualtypes = { "duel" }
		local lowtypes = { "physgun" }
		local hightypes = { "rpg" }
		local meleetypes = { "melee", "knife", "grenade", "slam" }
		local meleetwohand = {"melee2"}
		
		if CTFK(onehand, newht) then PlayReadyAnim(ply, pistol)
		elseif CTFK(twohand, newht) then PlayReadyAnim(ply, rifle)
		elseif CTFK(dualtypes, newht) then PlayReadyAnim(ply, dual)
		elseif CTFK(lowtypes, newht) then PlayReadyAnim(ply, low)
		elseif CTFK(hightypes, newht) then PlayReadyAnim(ply, high)
		elseif CTFK(meleetypes, newht) then PlayReadyAnim(ply, melee)
		elseif CTFK(meleetwohand, newht) then PlayReadyAnim(ply, melee2)
		end
	else
		local onehand = { "weapon_pistol", "weapon_glock_hl1", "weapon_snark", "weapon_tripmine" }
		local twohand = { "weapon_357", "weapon_crossbow", "weapon_ar2", "weapon_shotgun", "weapon_smg1", "weapon_357_hl1", "weapon_crossbow_hl1", "weapon_mp5_hl1", "weapon_shotgun_hl1", "weapon_gauss", "gmod_camera", "weapon_annabelle" }
		local dualtypes = { "weapon_cubemap" }
		local lowtypes = { "weapon_physcannon", "weapon_egon", "weapon_hornetgun", "weapon_physgun" }
		local hightypes = { "weapon_rpg", "weapon_rpg_hl1", "" }
		local meleetypes = { "weapon_bugbait", "weapon_crowbar", "weapon_frag", "weapon_slam", "weapon_stunstick", "weapon_crowbar_hl1", "weapon_handgrenade", "weapon_satchel" }

		if CTFK(onehand, neww) then PlayReadyAnim(ply, pistol)
		elseif CTFK(twohand, neww) then PlayReadyAnim(ply, rifle)
		elseif CTFK(dualtypes, neww) then PlayReadyAnim(ply, dual)
		elseif CTFK(lowtypes, neww) then PlayReadyAnim(ply, low)
		elseif CTFK(hightypes, neww) then PlayReadyAnim(ply, high)
		elseif CTFK(meleetypes, neww) then PlayReadyAnim(ply, melee)
		elseif CTFK(meleetwohand, neww) then PlayReadyAnim(ply, melee2)
		end
	end
end)

net.Receive("OtherPlayerWeaponSwitch", function(len, ply)
	local ply = net.ReadEntity()
	local anim = net.ReadString()
	
	PlayReadyAnim(ply, anim)
end)

net.Receive("DRCPlayerMelee", function(len, ply)
	local ply = net.ReadEntity()
	local wpn = ply:GetActiveWeapon()
	local ht = wpn:GetHoldType()
	
	if !wpn.Draconic then return end
	if !wpn:CanGunMelee() then return end
	
	if ht == "ar2" or ht == "smg" or ht == "crossbow" or ht == "shotgun" or ht == "rpg" or ht == "melee2" or ht == "physgun" then
		ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND, true)
	elseif ht == "crowbar" or ht == "pistol" or ht == "revolver" or ht == "grenade" or ht == "slam" or ht == "normal" or ht == "fist" or ht == "knife" or ht == "passive" or ht == "duel" or ht == "magic" or ht == "camera" then
		ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE, true)
	end
end)

net.Receive("DRC_Nuke", function(len, ply)
	local ent = net.ReadEntity()
	if !IsValid(ent) then return end
	if !ent:IsAdmin() then
		ent:Kill()
		print("".. ent:Nick() .." (".. ent:SteamID64() ..") is likely using exploits and tried to run the DRC Nuke dev tool!")
	return end
	for k,v in pairs(ents.GetAll()) do
		if v:IsNPC() or v:IsNextBot() or v:GetClass() == "prop_physics" or v:GetClass() == "prop_physics_multiplayer" then v:TakeDamage(999999999, ent) v:Remove()
		elseif v:IsPlayer() then v:ScreenFade(SCREENFADE.IN, Color(255, 255, 255), 3, 0)
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
	table.Add(DraconicAmmoTypes, tbl)
end

local batteryammo = {{
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
}}
DRC:AddAmmoType(batteryammo)

hook.Add( "Initialize", "drc_SetupAmmoTypes", function()
	for k,v in pairs(DraconicAmmoTypes) do
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
end )

function DRC:SurfacePropToEnum(str)
	local prefix = "MAT_"
	local newstring = "".. prefix .."".. string.upper(str) ..""
	return newstring
end

function DRC:GetHGMul(ent, hg, dinfo)
	local infl = dinfo:GetInflictor()
	if infl.DraconicProjectile == true then infl = infl:GetCreator() end
	local BaseProfile = scripted_ents.GetStored("drc_att_bprofile_generic")
	local BT = infl.ActiveAttachments.Ammunition.t.BulletTable
	local DT = infl.ActiveAttachments.Ammunition.t.BulletTable.HitboxDamageMuls
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


function DRC_ParticleExplosion(pos, magnitude, dist)
	if SERVER && pos == nil then return end
	if pos == nil then pos = LocalPlayer():EyePos() end
	if magnitude == nil then magnitude = 5 end
	if dist == nil then dist = 500 end
	
	local partdata = EffectData()
	partdata:SetMagnitude(magnitude)
	
	local N = DRC_TraceDir(pos, Angle(0, 0, 0), dist)
	local S = DRC_TraceDir(pos, Angle(0, 180, 0), dist)
	local E = DRC_TraceDir(pos, Angle(0, -90, 0), dist)
	local W = DRC_TraceDir(pos, Angle(0, 90, 0), dist)
	local U = DRC_TraceDir(pos, Angle(-90, 0, 0), dist)
	local D = DRC_TraceDir(pos, Angle(90, 0, 0), dist)
	local TraceTable = {N, S, E, W, U, D}

	for k,v in pairs(TraceTable) do
		if v.Hit then
			if v.HitSky then return end
	--		print(v.HitTexture)
	--		local tex = Material(v.HitTexture):GetTexture("$basetexture")
	--		local col = tex:GetColor(tex:Width()/2, tex:Height()/2)
	--		col = Vector(tonumber(col[2]), tonumber(col[3]), tonumber(col[4]))
	--		col = Color(col.x, col.y, col.z, 255)
	--		partdata:SetColor(col.r, col.g, col.b)
			partdata:SetOrigin(v.HitPos)
			partdata:SetNormal(v.HitNormal)
			partdata:SetMagnitude( partdata:GetMagnitude() * (1 - v.Fraction) )
			local surface = DRC:SurfacePropToEnum(util.GetSurfacePropName(v.SurfaceProps))
			if CTFK(DRC.MaterialCategories.Stone, surface) then util.Effect("drc_rubble", partdata) end
			if CTFK(DRC.MaterialCategories.Metal, surface) then util.Effect("drc_sparks", partdata) end
			if CTFK(DRC.MaterialCategories.Dust, surface) then util.Effect("drc_dust", partdata) end
		end
	end
end

function DRC:TraceDir(origin, dir, dist)
	DRC_TraceDir(origin, dir, dist)
end

function DRC:ParticleExplosion(pos, magnitude, dist)
	DRC_ParticleExplosion(pos, magnitude, dist)
end

function DRC:CallGesture(ply, slot, act, akill)
	DRCCallGesture(ply, slot, act, akill)
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

function DRC:IsVehicle(ent)
	if ent:IsVehicle() or ent:GetClass() == "gmod_sent_vehicle_fphysics_base" or ent:GetClass() == "npc_helicopter" or ent:GetClass() == "npc_combinegunship" or ent.LFS or ent.Base == "haloveh_base" or ent.Base == "ma2_mech" or ent.Base == "ma2_battlesuit" then return true else return false end
end

function DRC:IsCharacter(ent)
	if ent:IsPlayer() == true or ent:IsNPC() == true or ent:IsNextBot() == true then return true else return false end
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
		elseif hp < 1 && ent:GetNWBool("DRC_ShieldDown") == false then
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
		if shieldhp <= 0 then ent:SetNWBool("DRC_ShieldDown", true) end
		
		ent:SetNWInt("DRC_ShieldHealth", math.Clamp(ent:GetNWInt("DRC_ShieldHealth") - amount, 0, ent:GetNWInt("DRC_ShieldMaxHealth")))
		ent:SetNWInt("DRC_Shield_DamageTime", CurTime() + ent:GetNWInt("DRC_ShieldRechargeDelay") - engine.TickInterval())
		DRC:PingShield(ent, true)
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
	end
end

function DRC:PopShield(ent)
	ent:SetNWInt("DRC_ShieldHealth", 0)
	ent:TakeDamage(0)
end

function DRC:GetShield(ent)
	if CLIENT then
	--	if IsValid(ent.ShieldEntity) && ent.ShieldEntity != nil then
			local val, maxi, ent = ent:GetNWInt("DRC_ShieldHealth"), ent:GetNWInt("DRC_ShieldMaxHealth"), ent.ShieldEntity
			return val, maxi, ent
	--	else return nil end
	else
		local val, maxi = ent:GetNWInt("DRC_ShieldHealth"), ent:GetNWInt("DRC_ShieldMaxHealth")
		return val, maxi
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
	"terrortown",
}

hook.Add( "AllowPlayerPickup", "drc_PreventAnnoyance", function( ply, ent )
	if !IsValid(ply) or !IsValid(ent) or !ply:Alive() then return end
	local curswep = ply:GetActiveWeapon()
	if !IsValid(curswep) then return end
	
	if curswep.Draconic != nil then
		local gm = engine.ActiveGamemode()
		if CTFK(DRC.GamemodeCompat, gm) then return end
		timer.Simple(0.75, function()
			if !IsValid(ent) then return end
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
hook.Add( "PlayerTick", "drc_PlayerTickEvents", function(ply, cmd)
	if (!IsValid(ply) or !ply:Alive()) && !ply:InVehicle() then return end
	local curswep = ply:GetActiveWeapon()
	
	if !ply.TurnCD then ply.TurnCD = 0 end
	if !ply.SwapCD then ply.SwapCD = 0 end
	
	ViableWeaponCheck(ply)
	
	if CurTime() > ply.TurnCD then
		local rang = ply:GetRenderAngles()
		local pang = ply:EyeAngles()
		local inv = false
		
		if pang.y < 0 then inv = false else inv = true end
--		ply:ChatPrint(tostring(inv))
		
		rang = math.abs(math.Round(rang.y))
		pang = math.abs(math.Round(pang.y))
		local meth, dur = (rang - pang), 0
		
--		ply:ChatPrint("".. tostring(rang) .." ".. tostring(pang) .." ".. meth .."")
		
		local w = ply:KeyDown(IN_FORWARD)
		local a = ply:KeyDown(IN_MOVELEFT)
		local s = ply:KeyDown(IN_BACK)
		local d = ply:KeyDown(IN_MOVERIGHT)
			
		if !w && !a && !s && !d then
			if meth >= 45 then 
				
				if ply:Crouching() then
					if inv == false then 
						DRC:CallGesture(ply, GESTURE_SLOT_JUMP, ACT_GESTURE_TURN_LEFT45_FLAT, true)
					else
						DRC:CallGesture(ply, GESTURE_SLOT_JUMP, ACT_GESTURE_TURN_RIGHT45_FLAT, true)
					end
				else
					if inv == false then
						DRC:CallGesture(ply, GESTURE_SLOT_JUMP, ACT_GESTURE_TURN_LEFT45, true)
					else
						DRC:CallGesture(ply, GESTURE_SLOT_JUMP, ACT_GESTURE_TURN_RIGHT45, true)
					end
				end
				dur = 0.5
			elseif meth <= -45 then
				if ply:Crouching() then
					if inv == false then
						DRC:CallGesture(ply, GESTURE_SLOT_JUMP, ACT_GESTURE_TURN_RIGHT45_FLAT, true)
					else
						DRC:CallGesture(ply, GESTURE_SLOT_JUMP, ACT_GESTURE_TURN_LEFT45_FLAT, true)
					end
				else
					if inv == false then
						DRC:CallGesture(ply, GESTURE_SLOT_JUMP, ACT_GESTURE_TURN_RIGHT45, true)
					else
						DRC:CallGesture(ply, GESTURE_SLOT_JUMP, ACT_GESTURE_TURN_LEFT45, true)
					end
				end
				dur = 0.5
			end
		end
		ply.TurnCD = CurTime() + dur
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
		--	curswep:SetOwner(nil)
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
		--	curswep:SetOwner(nil)
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

hook.Add("OnEntityCreated", "drc_SetupWeaponColours", function(ent)
	if !IsValid(ent) then return end
	if !ent:IsWeapon() then return end
	if ent:IsWeapon() && ent.Draconic != true then return end
	
	timer.Simple(0, function()
		if !IsValid(ent) then return end
		if !IsValid(ent:GetOwner()) then return end
		local ply = ent:GetOwner()
		
		if ply:IsPlayer() then
			ent:SetNWEntity("SpraySrc", ply)
			local colours = DRC:GetColours(ply, true)
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
		if CLIENT then DRCNotify(nil, "hint", "critical", "Don't give yourself this ammo type! You'll only break your battery-based weapon!", NOTIFY_HINT, 5) end
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