if SERVER then
    AddCSLuaFile()
    return
end

matproxy.Add( {
	name = "drc_PlayerColours",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local col = owner:GetPlayerColor()
		if ( !isvector( col )) then return end

		local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
		mat:SetVector( self.ResultTo, col + col * mul )
	end
} )

matproxy.Add( {
	name = "drc_PlayerWeaponColours",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent )) then return end
		local owner = ent:GetOwner()
		if ( !IsValid( owner ) or !owner:IsPlayer() ) then return end
		local col = owner:GetWeaponColor()
		if ( !isvector( col )) then return end

		local mul = ( 1 + math.sin( CurTime() * 5 ) ) * 0
		mat:SetVector( self.ResultTo, col + col * mul )
	end
} )