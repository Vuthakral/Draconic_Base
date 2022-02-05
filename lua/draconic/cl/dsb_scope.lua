if SERVER then return end
local function drc_Scope()
	if GetConVar("cl_drawhud"):GetFloat() == 0 then return end
	local ply = LocalPlayer()
	
	if not ply:Alive() then return end
	local curswep = ply:GetActiveWeapon()
	if curswep.Draconic == nil then return end
	if curswep:CanUseSights() == false then forward = 0 return end
	if curswep.Secondary.Scoped == false then return end
	--if curswep.Weapon:GetNWBool("ironsights") == false then return end
	if curswep.SightsDown == false then return end

	local w = ScrW()
	local h = ScrH()
	
	local ratio = w/h
	
	local ss = 4 * curswep.Secondary.ScopeScale
	local sw = curswep.Secondary.ScopeWidth
	local sh = curswep.Secondary.ScopeHeight
	
	local wi = w / 10 * ss
	local hi = h / 10 * ss
	
	local Q1Mat = curswep.Secondary.ScopeMat
	local Q2Mat = curswep.Secondary.Q2Mat
	local Q3Mat = curswep.Secondary.Q3Mat
	local Q4Mat = curswep.Secondary.Q4Mat
	
	local YOffset = -curswep.Secondary.ScopeYOffset
	
	surface.SetDrawColor( curswep.Secondary.ScopeBGCol )
	
	surface.DrawRect( 0, (h/2 - hi * sh) * YOffset, w/2 - hi / 2 * sw * 2, hi * 2 )
	surface.DrawRect( w/2 + hi * sw, (h/2 - hi * sh) * YOffset, w/2 + wi * sw, hi * 2 )
	surface.DrawRect( 0, 0, w * ss, h / 2 - hi * sh )
	surface.DrawRect( 0, (h/2 + hi * sh) * YOffset, w * ss, h / 1.99 - hi * sh )
	
	if curswep.Secondary.ScopeCol != nil then
		surface.SetDrawColor( curswep.Secondary.ScopeCol )
	else
		surface.SetDrawColor( Color(0, 0, 0, 255) )
	end
	
	if Q1Mat == nil then
		surface.SetMaterial(Material("sprites/scope_arc"))
	else 
		surface.SetMaterial(Material(Q1Mat))
	end
	surface.DrawTexturedRectUV( w/2 - hi / 2 * sw * 2, (h/2 - hi) * YOffset, hi * sw, hi * sh, 1, 1, 0, 0 )
	
	if Q2Mat == nil then
		if Q1Mat == nil then
			surface.SetMaterial(Material("sprites/scope_arc"))
		else
			surface.SetMaterial(Material(Q1Mat))
		end
	else 
		surface.SetMaterial(Material(Q2Mat))
	end
	surface.DrawTexturedRectUV( w / 2, (h/2 - hi) * YOffset, hi * sw, hi * sh, 0, 1, 1, 0 )
	
	if Q3Mat == nil then
		if Q1Mat == nil then
			surface.SetMaterial(Material("sprites/scope_arc"))
		else
			surface.SetMaterial(Material(Q1Mat))
		end
	else 
		surface.SetMaterial(Material(Q3Mat))
	end
	surface.DrawTexturedRectUV( w/2 - hi / 2 * sw * 2, h/2, hi * sw, hi * sh, 1, 0, 0, 1 )
	
	if Q4Mat == nil then
		if Q1Mat == nil then
			surface.SetMaterial(Material("sprites/scope_arc"))
		else
			surface.SetMaterial(Material(Q1Mat))
		end
	else 
		surface.SetMaterial(Material(Q4Mat))
	end
	surface.DrawTexturedRectUV( w/2, h/2, hi * sw, hi * sh, 0, 0, 1, 1 )
	
end
hook.Add("HUDPaint", "drc_scope", drc_Scope)

hook.Add( "GetMotionBlurValues", "drc_scopeblur", function( horizontal, vertical, forward, rotational )
	local ply = LocalPlayer()
	local wpn = ply:GetActiveWeapon()
	if wpn.Draconic == nil then return end
	
	if wpn:CanUseSights() == false then forward = 0 return forward end
	
	local w = ScrW()
	local h = ScrH()
	
	local ratio = w/h
	
	local ss = 4 * wpn.Secondary.ScopeScale
	local sw = wpn.Secondary.ScopeWidth
	local sh = wpn.Secondary.ScopeHeight
	
	local wi = w / 10 * ss
	local hi = h / 10 * ss
	
	if wpn.Secondary.Scoped == true && wpn.Secondary.ScopeBlur == true && wpn.SightsDown == true then
		if sw != 1 then
			forward = forward + (ss * 0.015 / sw) * (wpn.Secondary.IronFOV * ratio * 0.05)
		else
			forward = forward + (ss * 0.0175) / (wpn.Secondary.IronFOV * ratio * 0.01)
		end
	  --  rotational = rotational + 0.05 * math.sin( CurTime() * 3 )
	end
	
	if wpn.SightsDown == false or wpn.IsOverheated == true then
		forward = 0
		if forward > 0 then forward = 0 end
	end
    return horizontal, vertical, forward, rotational
end )