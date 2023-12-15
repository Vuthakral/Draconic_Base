if ( CLIENT ) then
	language.Add( "tool.drc_colour.name", "Draconic Base Colour" )
	language.Add( "tool.drc_colour.desc", "Set the extended Draconic colours of an entity." )		
	language.Add( "tool.drc_colour.reload", "Reset colour" )
	language.Add( "tool.drc_colour.left", "Apply colour" )
	language.Add( "tool.drc_colour.right", "Copy colour" )
end

TOOL.Category = "Render"
TOOL.Name = "#tool.drc_colour.name"

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
	{ name = "reload" }
}

TOOL.ClientConVar[ "r_player" ] = 255
TOOL.ClientConVar[ "g_player" ] = 255
TOOL.ClientConVar[ "b_player" ] = 255

TOOL.ClientConVar[ "r_weapon" ] = 255
TOOL.ClientConVar[ "g_weapon" ] = 255
TOOL.ClientConVar[ "b_weapon" ] = 255

TOOL.ClientConVar[ "r_eye" ] = 255
TOOL.ClientConVar[ "g_eye" ] = 255
TOOL.ClientConVar[ "b_eye" ] = 255

TOOL.ClientConVar[ "r_energy" ] = 255
TOOL.ClientConVar[ "g_energy" ] = 255
TOOL.ClientConVar[ "b_energy" ] = 255

TOOL.ClientConVar[ "r_acc1" ] = 255
TOOL.ClientConVar[ "g_acc1" ] = 255
TOOL.ClientConVar[ "b_acc1" ] = 255

TOOL.ClientConVar[ "r_acc2" ] = 255
TOOL.ClientConVar[ "g_acc2" ] = 255
TOOL.ClientConVar[ "b_acc2" ] = 255

TOOL.ClientConVar[ "grunge" ] = 0

local function SetColour( ply, ent, data )
	if data[2] == "player" then
		ent:SetNWVector("PlayerColour_DRC", Vector(data[1].x, data[1].y, data[1].z))
	--	if SERVER then duplicator.StoreEntityModifier( ent, "colour", data ) end
	end
	
	if data[2] == "weapon" then
		ent:SetNWVector("WeaponColour_DRC", Vector(data[1].x, data[1].y, data[1].z))
	end
	
	if data[2] == "eye" then
		ent:SetNWVector("EyeTintVec", Vector(data[1].x, data[1].y, data[1].z))
	end
	
	if data[2] == "energy" then
		ent:SetNWVector("EnergyTintVec", Vector(data[1].x, data[1].y, data[1].z))
	end
	
	if data[2] == "accent1" then
		ent:SetNWVector("ColourTintVec1", Vector(data[1].x, data[1].y, data[1].z))
	end
	
	if data[2] == "accent2" then
		ent:SetNWVector("ColourTintVec2", Vector(data[1].x, data[1].y, data[1].z))
	end
	
	if data[2] == "grunge" then
		ent:SetNWInt("Grunge_DRC", data[1])
	end
end
duplicator.RegisterEntityModifier( "drc_colour_player", SetColour )

function TOOL:LeftClick( trace )

	local ent = trace.Entity
	if ( IsValid( ent.AttachedEntity ) ) then ent = ent.AttachedEntity end
	if ( !IsValid( ent ) ) then return false end -- The entity is valid and isn't worldspawn
	if ( CLIENT ) then return true end
	
	
	local r = math.Clamp(self:GetClientNumber( "r_player", 127 ) / 255, 0.032, 255)
	local g = math.Clamp(self:GetClientNumber( "g_player", 127 ) / 255, 0.032, 255)
	local b = math.Clamp(self:GetClientNumber( "b_player", 127 ) / 255, 0.032, 255)
	local plycol = Vector(r,g,b)
	SetColour( self:GetOwner(), ent, {plycol, "player"})
	
	r = math.Clamp(self:GetClientNumber( "r_weapon", 127 ) / 255, 0.032, 255)
	g = math.Clamp(self:GetClientNumber( "g_weapon", 127 ) / 255, 0.032, 255)
	b = math.Clamp(self:GetClientNumber( "b_weapon", 127 ) / 255, 0.032, 255)
	local wpncol = Vector(r,g,b)
	SetColour( self:GetOwner(), ent, {wpncol, "weapon"})
	
	r = math.Clamp(self:GetClientNumber( "r_eye", 127 ), 0.032, 255)
	g = math.Clamp(self:GetClientNumber( "g_eye", 127 ), 0.032, 255)
	b = math.Clamp(self:GetClientNumber( "b_eye", 127 ), 0.032, 255)
	local eyecol = Vector(r,g,b)
	SetColour( self:GetOwner(), ent, {eyecol, "eye"})
	
	r = math.Clamp(self:GetClientNumber( "r_energy", 127 ), 0.032, 255)
	g = math.Clamp(self:GetClientNumber( "g_energy", 127 ), 0.032, 255)
	b = math.Clamp(self:GetClientNumber( "b_energy", 127 ), 0.032, 255)
	local engcol = Vector(r,g,b)
	SetColour( self:GetOwner(), ent, {engcol, "energy"})
	
	r = math.Clamp(self:GetClientNumber( "r_acc1", 127 ), 0.032, 255)
	g = math.Clamp(self:GetClientNumber( "g_acc1", 127 ), 0.032, 255)
	b = math.Clamp(self:GetClientNumber( "b_acc1", 127 ), 0.032, 255)
	local ac1col = Vector(r,g,b)
	SetColour( self:GetOwner(), ent, {ac1col, "accent1"})
	
	r = math.Clamp(self:GetClientNumber( "r_acc2", 127 ), 0.032, 255)
	g = math.Clamp(self:GetClientNumber( "g_acc2", 127 ), 0.032, 255)
	b = math.Clamp(self:GetClientNumber( "b_acc2", 127 ), 0.032, 255)
	local ac2col = Vector(r,g,b)
	SetColour( self:GetOwner(), ent, {ac2col, "accent2"})
	
	print(self:GetClientNumber("grunge"))
	
	SetColour( self:GetOwner(), ent, {math.Clamp(self:GetClientNumber( "grunge", 0 ), 0, 100), "grunge"})

	return true
end

function TOOL:RightClick( trace )
	local ent = trace.Entity
	if ( IsValid( ent.AttachedEntity ) ) then ent = ent.AttachedEntity end
	if ( !IsValid( ent ) ) then return false end -- The entity is valid and isn't worldspawn

	if ( CLIENT ) then return true end

	local plycol = Vector(127, 127, 127)
	local wpncol = Vector(127, 127, 127)
	local eyecol = Vector(127, 127, 127)
	local engcol = Vector(127, 127, 127)
	local ac1col = Vector(127, 127, 127)
	local ac2col = Vector(127, 127, 127)
	local grunge = 0
	if ent:GetNWVector("PlayerColour_DRC") != Vector(0, 0, 0) then plycol = ent:GetNWVector("PlayerColour_DRC") end
	if ent:GetNWVector("WeaponColour_DRC") != Vector(0, 0, 0) then wpncol = ent:GetNWVector("WeaponColour_DRC") end
	if ent:GetNWVector("EyeTintVec") != Vector(0, 0, 0) then eyecol = ent:GetNWVector("EyeTintVec") end
	if ent:GetNWVector("EnergyTintVec") != Vector(0, 0, 0) then engcol = ent:GetNWVector("EnergyTintVec") end
	if ent:GetNWVector("ColourTintVec1") != Vector(0, 0, 0) then ac1col = ent:GetNWVector("ColourTintVec1") end
	if ent:GetNWVector("ColourTintVec2") != Vector(0, 0, 0) then ac2col = ent:GetNWVector("ColourTintVec2") end
	if ent:GetNWInt("Grunge_DRC") != 0 then grunge = ent:GetNWInt("Grunge_DRC") end

	self:GetOwner():ConCommand( "drc_colour_r_player " .. plycol.x * 255 )
	self:GetOwner():ConCommand( "drc_colour_g_player " .. plycol.y * 255 )
	self:GetOwner():ConCommand( "drc_colour_b_player " .. plycol.z * 255 )
	
	self:GetOwner():ConCommand( "drc_colour_r_weapon " .. wpncol.x * 255 )
	self:GetOwner():ConCommand( "drc_colour_g_weapon " .. wpncol.y * 255 )
	self:GetOwner():ConCommand( "drc_colour_b_weapon " .. wpncol.z * 255 )
	
	self:GetOwner():ConCommand( "drc_colour_r_eye " .. eyecol.x )
	self:GetOwner():ConCommand( "drc_colour_g_eye " .. eyecol.y )
	self:GetOwner():ConCommand( "drc_colour_b_eye " .. eyecol.z )
	
	self:GetOwner():ConCommand( "drc_colour_r_energy " .. engcol.x )
	self:GetOwner():ConCommand( "drc_colour_g_energy " .. engcol.y )
	self:GetOwner():ConCommand( "drc_colour_b_energy " .. engcol.z )
	
	self:GetOwner():ConCommand( "drc_colour_r_acc1 " .. ac1col.x )
	self:GetOwner():ConCommand( "drc_colour_g_acc1 " .. ac1col.y )
	self:GetOwner():ConCommand( "drc_colour_b_acc1 " .. ac1col.z )
	
	self:GetOwner():ConCommand( "drc_colour_r_acc2 " .. ac2col.x )
	self:GetOwner():ConCommand( "drc_colour_g_acc2 " .. ac2col.y )
	self:GetOwner():ConCommand( "drc_colour_b_acc2 " .. ac2col.z )
	
	self:GetOwner():ConCommand( "drc_colour_grunge " .. grunge )

	return true
end

function TOOL:Reload( trace )

	local ent = trace.Entity
	if ( IsValid( ent.AttachedEntity ) ) then ent = ent.AttachedEntity end

	if ( !IsValid( ent ) ) then return false end -- The entity is valid and isn't worldspawn
	if ( CLIENT ) then return true end

	local col = Vector(127,127,127)
	SetColour( self:GetOwner(), ent, {col / 255, "player"})
	SetColour( self:GetOwner(), ent, {col / 255, "weapon"})
	SetColour( self:GetOwner(), ent, {col, "eye"})
	SetColour( self:GetOwner(), ent, {col, "energy"})
	SetColour( self:GetOwner(), ent, {col, "accent1"})
	SetColour( self:GetOwner(), ent, {col, "accent2"})
	SetColour( self:GetOwner(), ent, {0, "grunge"})
	return true
end

local ConVarsDefault = TOOL:BuildConVarList()

function TOOL.BuildCPanel( CPanel )
	CPanel:AddControl( "Header", { Description = "#tool.drc_colour.desc" } )
	CPanel:AddControl( "ComboBox", { MenuButton = 1, Folder = "colour", Options = { [ "#preset.default" ] = ConVarsDefault }, CVars = table.GetKeys( ConVarsDefault ) } )
	CPanel:AddControl( "Color", { Label = "Channel: PLAYER COLOUR", Red = "drc_colour_r_player", Green = "drc_colour_g_player", Blue = "drc_colour_b_player"} )
	CPanel:AddControl( "Color", { Label = "Channel: WEAPON COLOUR", Red = "drc_colour_r_weapon", Green = "drc_colour_g_weapon", Blue = "drc_colour_b_weapon"} )
	CPanel:AddControl( "Color", { Label = "Channel: EYE COLOUR", Red = "drc_colour_r_eye", Green = "drc_colour_g_eye", Blue = "drc_colour_b_eye"} )
	CPanel:AddControl( "Color", { Label = "Channel: ENERGY / LIGHT COLOUR", Red = "drc_colour_r_energy", Green = "drc_colour_g_energy", Blue = "drc_colour_b_energy"} )
	CPanel:AddControl( "Color", { Label = "Channel: ACCENT COLOUR 1", Red = "drc_colour_r_acc1", Green = "drc_colour_g_acc1", Blue = "drc_colour_b_acc1"} )
	CPanel:AddControl( "Color", { Label = "Channel: ACCENT COLOUR 2", Red = "drc_colour_r_acc2", Green = "drc_colour_g_acc2", Blue = "drc_colour_b_acc2"} )
	CPanel:AddControl( "Slider", { Label = "WEAR & TEAR", Command = "drc_colour_grunge", Type = "Int", Min = 0, Max = 100, Help = false} )
end
