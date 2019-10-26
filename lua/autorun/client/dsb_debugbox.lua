local blur = Material( "pp/blurscreen" )
local function drawBlur( x, y, w, h, layers, density, alpha )
	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( blur )

	for i = 1, layers do
		blur:SetFloat( "$blur", ( i / layers ) * density )
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		render.SetScissorRect( x, y, x + w, y + h, true )
			surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		render.SetScissorRect( 0, 0, 0, 0, false )
	end
end


local function drc_Debug()
	local curswep = LocalPlayer():GetActiveWeapon()
	
	if GetConVar("cl_drc_debugmode"):GetString() == "0" then
	else
		if curswep.Draconic != true then
		else
			local name = "".. curswep:GetClass() .." - ".. curswep.PrintName ..""
			local ammoint = "".. curswep.Weapon:GetNWInt("LoadedAmmo") ..""
			local heatint = "".. curswep.Weapon:GetNWInt("Heat") ..""
			local firemode = "".. curswep.Weapon:GetNWString("FireMode") ..""
			
			if curswep.Weapon:GetNWBool("Passive") == true then
				passive = "True"
			else
				passive = "False"
			end
			
			if curswep.Weapon:GetNWBool("ironsights") == true then
				sights = "True"
			else
				sights = "False"
			end
--			local muzzle = curswep:LookupAttachment("muzzle")		
--			if muzzle == "muzzle" then
--				local muzzletext = "hl2 ✔"
--				if muzzle == "0" then
--					local muzzle = curswep:LookupAttachment("muzzle_flash")
--					if muzzle == "muzzle_flash" then
--						local muzzletext = "CS:S ✗"
--					elseif muzzle == "0" then
--						local muzzletext = "INCOMPATIBLE"
--					end
--				else end
--			else end
		
			if GetConVar("cl_drc_sell_soul"):GetString() == "1" then
				soul = "Yes."
			else
				soul = "No :'("
			end
		
			draw.RoundedBox(4, 40, 515, 600, 260, Color(115, 115, 115, 180))

			draw.RoundedBox(4, 40, 515, 600, 30, Color(72, 72, 72, 236))
			draw.DrawText("Current SWEP ::", "Arial24", 50, 555, Color(0, 0, 0, 255))
			draw.DrawText("Currnt Firemode ::", "Arial24", 50, 585, Color(0, 0, 0, 255))
			draw.DrawText("Current Ammo Int ::", "Arial24", 50, 615, Color(0, 0, 0, 255))
			draw.DrawText("Current Heat Int ::", "Arial24", 50, 645, Color(0, 0, 0, 255))
			draw.DrawText("Currently in Passive :: ", "Arial24", 50, 675, Color(0, 0, 0, 255))
			draw.DrawText("Currently in Sights ::", "Arial24", 50, 705, Color(0, 0, 0, 255))
			draw.DrawText("Soul Sacrificed to Vuthakral ::", "Arial24", 50, 735, Color(0, 0, 0, 255))

			draw.DrawText("Draconic SWEP Base - Debug Assistant", "Arial24", 50, 520, Color(236, 236, 236, 236))
			
			draw.DrawText(name, "Arial24", 220, 555, Color(236, 236, 236, 236))
			draw.DrawText(firemode, "Arial24", 235, 585, Color(236, 236, 236, 236))
			draw.DrawText(ammoint, "Arial24", 240, 615, Color(236, 236, 236, 236))
			draw.DrawText(heatint, "Arial24", 230, 645, Color(236, 236, 236, 236))
			draw.DrawText(sights, "Arial24", 250, 705, Color(236, 236, 236, 236))
			draw.DrawText(passive, "Arial24", 265, 675, Color(236, 236, 236, 236))
			draw.DrawText(soul, "Arial24", 340, 735, Color(236, 236, 236, 236))
		end
	end
end
hook.Add("HUDPaint", "CoreHudPaint", drc_Debug)