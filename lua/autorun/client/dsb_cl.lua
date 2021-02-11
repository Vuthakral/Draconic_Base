AddCSLuaFile()

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

local GCT = CurTime()
local GNT = GCT + 1
local function GetLastSecondFramerate(ct)
	if CurTime() > GNT then
		GNT = CurTime() + 1
		ft = (1/FrameTime())
		return math.Round(ft, 0)
	else 
		return math.Round(ft, 0)
	end
end

local function drc_Debug()
	if GetConVar("sv_drc_allowdebug"):GetFloat() == 0 then return end
	if GetConVar("cl_drc_debugmode"):GetFloat() == 0 then return end
	
	local chmode = GetConVar("cl_drc_debug_crosshairmode"):GetFloat()
	local legacy = GetConVar("cl_drc_debug_legacyassistant"):GetFloat()

	local curswep = LocalPlayer():GetActiveWeapon()
	
		if GetConVar("cl_drc_debugmode"):GetString() == "1" or GetConVar("cl_drc_debugmode"):GetString() == "2" then
			local ply = LocalPlayer()
			local curswep = ply:GetActiveWeapon()
			local staticmat = Material("vgui/replay/replay_camera_crosshair")
			local dynmat	= Material("sprites/reticle")
			local width		= 1
			local height	= 1
		
			if curswep.Draconic == nil or curswep.Draconic == false then else
				if curswep.Base == "draconic_battery_base" or curswep.Base == "draconic_gun_base" then
					local spread = curswep.Primary.Spread
					local spreaddiv = curswep.Primary.SpreadDiv
				
					local heat = curswep.Weapon:GetNWInt("Heat")
					local bs = curswep.BloomValue * (spread / spreaddiv) * 20
					local prevbs = curswep.PrevBS * (spread / spreaddiv) * 20
					local smoothbs = 1.5
					local dyn = Lerp(FrameTime() * 10, curswep.PrevBS, curswep.BloomValue)
				--	ply:ChatPrint("bs: ".. bs .." | pbs: ".. prevbs .." | dyn: ".. dyn .."")
					local hl = LerpVector(heat / 175, Vector(255, 255, 255), Vector(255, 0, 0))
					
					
					if curswep.Primary.CanMelee == true then
						if chmode > 1 then
							for i=1, (math.Round(1/ engine.TickInterval() - 1 , 0)) do
								local xm = Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), curswep.Primary.MeleeStartX, curswep.Primary.MeleeEndX) * 10
								local ym = Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), curswep.Primary.MeleeStartY, curswep.Primary.MeleeEndY) * 10
								
								if i == 1 then
									surface.SetDrawColor(255, 0, 0, 100)
									surface.DrawRect(ScrW() * 0.5 + xm + 4, ScrH() * 0.5 - ym - 4, 8, 8)
								end
								
								surface.SetDrawColor(255, 255, 255, 100)
								surface.DrawRect(ScrW() * 0.5 + xm, ScrH() * 0.5 - ym, 2, 2)
							end
						end
					end
				elseif curswep.Base == "draconic_melee_base" then
					if chmode > 0 then
						for i=1, (math.Round(1/ engine.TickInterval() - 1 , 0)) do
							local xm = Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), curswep.Primary.StartX, curswep.Primary.EndX) * 10
							local ym = Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), curswep.Primary.StartY, curswep.Primary.EndY) * 10
							
							if i == 1 then
								surface.SetDrawColor(255, 0, 0, 255)
								surface.DrawRect(ScrW() * 0.5 + xm + 4, ScrH() * 0.5 - ym - 4, 8, 8)
							end
							
							surface.SetDrawColor(255, 255, 255, 255)
							surface.DrawRect(ScrW() * 0.5 + xm, ScrH() * 0.5 - ym, 2, 2)
							
							surface.SetDrawColor(255, 255, 255, 255)
							surface.DrawRect(ScrW() * 0.5 + xm, ScrH() * 0.5 - ym, 2, 2)
						end
						
						for i=1, (math.Round(1/ engine.TickInterval() - 1 , 0)) do
							local xm = Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), curswep.Secondary.StartX, curswep.Secondary.EndX) * 10
							local ym = Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), curswep.Secondary.StartY, curswep.Secondary.EndY) * 10
							
							if i == 1 then
								surface.SetDrawColor(0, 255, 0, 255)
								surface.DrawRect(ScrW() * 0.5 + xm + 4, ScrH() * 0.5 - ym - 4, 8, 8)
							end
							
							surface.SetDrawColor(255, 255, 255, 255)
							surface.DrawRect(ScrW() * 0.5 + xm, ScrH() * 0.5 - ym, 2, 2)
							
							surface.SetDrawColor(255, 255, 255, 255)
							surface.DrawRect(ScrW() * 0.5 + xm, ScrH() * 0.5 - ym, 2, 2)
						end
						
						for i=1, (math.Round(1/ engine.TickInterval() - 1 , 0)) do
							if curswep.Primary.CanLunge == true then
								local xm = Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), curswep.Primary.LungeStartX, curswep.Primary.LungeEndX) * 10
								local ym = Lerp(math.Round(i / (1 / engine.TickInterval() - 1), 3), curswep.Primary.LungeStartY, curswep.Primary.LungeEndY) * 10
								
								if i == 1 then
									surface.SetDrawColor(0, 0, 255, 255)
									surface.DrawRect(ScrW() * 0.5 + xm + 4, ScrH() * 0.5 - ym - 4, 8, 8)
								end
								
								surface.SetDrawColor(255, 255, 255, 255)
								surface.DrawRect(ScrW() * 0.5 + xm, ScrH() * 0.5 - ym, 2, 2)
								
								surface.SetDrawColor(255, 255, 255, 255)
								surface.DrawRect(ScrW() * 0.5 + xm, ScrH() * 0.5 - ym, 2, 2)
							end
						end
					end
				end
			end
		end
	
	if GetConVar("cl_drc_debugmode"):GetString() == "0" then
	elseif GetConVar("cl_drc_debugmode"):GetString() == "1" then
		if legacy == 1 then
			if curswep.Draconic != true then
			else
			local et = LocalPlayer():GetEyeTrace()
			local res = et.Entity
			
				local header = "DSB Debug Assistant | Current Weapon: ".. curswep.PrintName ..""
				local name = "".. curswep:GetClass() .." - ".. curswep.Base ..""

				if curswep.Base == "draconic_battery_base" then
					firemode = "".. curswep.Weapon:GetNWString("FireMode") .." | Bloom Score: ".. math.Round(curswep.BloomValue, 2) ..""
				elseif curswep.Base == "draconic_gun_base" then
					firemode = "".. curswep.Weapon:GetNWString("FireMode") .." | Bloom Score: ".. math.Round(curswep.BloomValue, 2) ..""
				else
					firemode = "Not a gun."
				end
				
				if curswep.Base == "draconic_battery_base" then
					ammoint = "".. curswep.Weapon:GetNWInt("LoadedAmmo") .."%"
				elseif curswep.Base == "draconic_gun_base" then
					ammoint = "".. curswep.Weapon:GetNWInt("LoadedAmmo") .." (int) / ".. curswep:Clip1() .." (clip) / ".. LocalPlayer():GetAmmoCount( curswep:GetPrimaryAmmoType() ) .." (reserve)"
				else
					ammoint = "Not a gun."
				end
				
				if curswep.Base == "draconic_battery_base" then
					heatint = "".. math.Round(curswep.Weapon:GetNWInt("Heat"), 3) .."%"
				elseif curswep.Base == "draconic_gun_base" then
					heatint = "Not a Battery Base weapon."
				else
					heatint = "Not a gun."
				end
				
				if curswep.Base == "draconic_battery_base" then
					if curswep.LowerRPMWithHeat == true then
						if curswep.LoadAfterShot == false then
							rpm = "".. math.Round(math.Clamp((curswep.Primary.RPM / (curswep.Weapon:GetNWInt("Heat") * 2.5 / 50)), (curswep.HeatRPMmin), (curswep.Primary.RPM))) ..""
						else
							rpm = "".. math.Round(math.Clamp((curswep.Primary.RPM / (curswep.Weapon:GetNWInt("Heat") * 2.5 / 50)), (curswep.HeatRPMmin), (curswep.Primary.RPM))) .." - Manual load"
						end
					else
						if curswep.LoadAfterShot == false then
							rpm = "".. curswep.Primary.RPM ..""
						else
							rpm = "".. curswep.Primary.RPM .." - Manual load"
						end
					end
				elseif curswep.Base == "draconic_gun_base" then
						if curswep.LoadAfterShot == false then
							rpm = "".. curswep.Primary.RPM ..""
						else
							rpm = "".. curswep.Primary.RPM .." - Manual load"
						end
				else
					rpm = "Not a gun."
				end
				
				if curswep.Weapon:GetNWBool("Passive") == true then
					passive = "True"
				else
					passive = "False"
				end
				
				if curswep.Base == "draconic_battery_base" then
					if curswep.Weapon:GetNWBool("ironsights") == true then
						sights = "True"
					else
						sights = "False"
					end
				elseif curswep.Base == "draconic_gun_base" then
					if curswep.Weapon:GetNWBool("ironsights") == true then
						sights = "True"
					else
						sights = "False"
					end
				else
					sights = "Not a gun."
				end	
				
				if curswep.Base == "draconic_melee_base" then
					if (LocalPlayer():GetPos():Distance(res:GetPos()) < curswep.Primary.Range * 4.1) then
						prim = "True"
					else
						prim = "False"
					end
					if (LocalPlayer():GetPos():Distance(res:GetPos()) < curswep.Secondary.Range * 4.1) then
						sec = "True"
					else
						sec = "False"
					end
				elseif curswep.Base == "draconic_gun_base" or curswep.Base == "draconic_battery_base" then
					if curswep.Primary.CanMelee == true then
						if (LocalPlayer():GetPos():Distance(res:GetPos()) < curswep.Primary.MeleeRange * 4.1) then
							prim = "True"
						else
							prim = "False"
						end
						
						melee = prim
					else
					melee = "".. curswep.PrintName .." does not support melee."
					end
				end
				
				if curswep.Base == "draconic_melee_base" then
					if curswep.Primary.CanLunge == false then
						lunge = "Weapon cannot lunge."
					else
						if (LocalPlayer():GetPos():Distance(res:GetPos()) < curswep.Primary.LungeMaxDist) then
							lunge = "True"
						else
							lunge = "False"
						end
					end
					melee = "Primary: ".. prim .." - Secondary: ".. sec ..""
				else
					lunge = "Not a Melee Base weapon."
				end
				
				if curswep.Draconic == true then
					v2c = curswep.Weapon.OwnerActivity
					if v2c == "standidle" then activity = "Idle"
					elseif v2c == "running" then activity = "Moving"
					elseif v2c == "crouchidle" then activity = "Crouch Idle"
					elseif v2c == "crouchrunning" then activity = "Crouch Moving"
					elseif v2c == "swimidle" then activity = "Swim Idle"
					elseif v2c == "swimming" then activity = "Swimming"
					elseif v2c == "sprinting" then activity = "Sprinting"
					elseif v2c == "crouchsprinting" then activity = "Crouch Sprinting" end
				end
				
				if curswep.Base == "draconic_melee_base" then
					charge = "Not a gun."
				elseif curswep.Base == "draconic_gun_base" or curswep.Base == "draconic_battery_base" then
					if curswep.ChargeBase == false then
						charge = "".. curswep.PrintName .." does not charge."
					else
						charge = "".. curswep.Weapon:GetNWInt("Charge") .."%"
					end
				end
			
				if GetConVar("cl_drc_sell_soul"):GetString() == "1" then
					soul = "Yes."
				else
					soul = "No :'("
				end
			
				if GetLastSecondFramerate() == 69 then
					sixtynine = "Nice."
				else sixtynine = "" end
			
				draw.RoundedBox(4, 40, 515, 600, 260, Color(115, 115, 115, 100))
				
				drawBlur( 40, 515, 600, 260, 6, 4, 150 )

				draw.RoundedBox(4, 40, 515, 600, 30, Color(72, 72, 72, 255))
				draw.DrawText("Current SWEP ::", "HudSelectionText", 50, 550, Color(0, 0, 0, 255))
				draw.DrawText("Currnt Firemode ::", "HudSelectionText", 50, 575, Color(0, 0, 0, 255))
				draw.DrawText("Current Ammo ::", "HudSelectionText", 50, 590, Color(0, 0, 0, 255))
				draw.DrawText("Current Heat ::", "HudSelectionText", 50, 605, Color(0, 0, 0, 255))
				draw.DrawText("Current RPM :: ", "HudSelectionText", 50, 620, Color(0, 0, 0, 255))
				draw.DrawText("Current Charge :: ", "HudSelectionText", 50, 635, Color(0, 0, 0, 255))
				draw.DrawText("Currently in Passive ::", "HudSelectionText", 50, 660, Color(0, 0, 0, 255))
				draw.DrawText("Currently in Sights ::", "HudSelectionText", 50, 675, Color(0, 0, 0, 255))
				draw.DrawText("Lunge in range ::", "HudSelectionText", 50, 700, Color(0, 0, 0, 255))
				draw.DrawText("Melee in range ::", "HudSelectionText", 50, 715, Color(0, 0, 0, 255))
				draw.DrawText("Currently Detected Activity ::", "HudSelectionText", 50, 730, Color(0, 0, 0, 255))
				draw.DrawText("Soul Sacrificed to Vuthakral ::", "HudSelectionText", 50, 755, Color(0, 0, 0, 255))
				draw.DrawText("Frame Time ::", "HudSelectionText", 50, 775, Color(236, 236, 236, 255))
				draw.DrawText("FPS ::", "HudSelectionText", 50, 790, Color(236, 236, 236, 255))

				draw.DrawText(header, "HudSelectionText", 50, 520, Color(236, 236, 236, 236))
				
				draw.DrawText(name, "HudSelectionText", 180, 550, Color(236, 236, 236, 236))
				draw.DrawText(firemode, "HudSelectionText", 195, 575, Color(236, 236, 236, 236))
				draw.DrawText(ammoint, "HudSelectionText", 180, 590, Color(236, 236, 236, 236))
				draw.DrawText(heatint, "HudSelectionText", 170, 605, Color(236, 236, 236, 236))
				draw.DrawText(rpm, "HudSelectionText", 165, 620, Color(236, 236, 236, 236))
				draw.DrawText(charge, "HudSelectionText", 190, 635, Color(236, 236, 236, 236))
				draw.DrawText(passive, "HudSelectionText", 220, 660, Color(236, 236, 236, 236))
				draw.DrawText(sights, "HudSelectionText", 210, 675, Color(236, 236, 236, 236))
				draw.DrawText(lunge, "HudSelectionText", 180, 700, Color(236, 236, 236, 236))
				draw.DrawText(activity, "HudSelectionText", 270, 730, Color(236, 236, 236, 236))
				draw.DrawText(melee, "HudSelectionText", 180, 715, Color(236, 236, 236, 236))
				draw.DrawText(soul, "HudSelectionText", 270, 755, Color(236, 236, 236, 236))
				draw.DrawText(sixtynine, "HudSelectionText", 50, 805, Color(236, 236, 236, 10))
				draw.DrawText(math.Round(FrameTime(), 6), "HudSelectionText", 160, 775, Color(236, 236, 236, 236))
				draw.DrawText(GetLastSecondFramerate(), "HudSelectionText", 100, 790, Color(236, 236, 236, 236))
			end
		end
	end
end
hook.Add("HUDPaint", "drc_debug_hud", drc_Debug)

drc_vm_lerpang = Angle(0, 0, 0)
drc_vmaangle = Angle(0, 0, 0)
drc_vm_lerpdivval = 25
drc_vm_angdiff_median = 0
drc_vm_lerpdiv = 25
drc_vm_lerpang_final = Angle(0, 0, 0)
drc_vm_angmedian = 0
drc_vmapos = Vector(0, 0, 0)

local function FormatViewModelAttachment(nFOV, vOrigin, bFrom --[[= false]])
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

local function DrawVMAttachments(att, ent)
	if GetConVar("sv_drc_allowdebug"):GetFloat() == 0 then return end
	if GetConVar("cl_drc_debugmode"):GetString() != "1" then return end
	
	local vmattach = GetConVar("cl_drc_debug_vmattachments"):GetFloat()
	
	if vmattach != 1 then return end
	if !att then return end
	if !IsValid(ent) then return end
	
	local wpn = LocalPlayer():GetActiveWeapon()
	if wpn.Draconic == nil then return end
	
	local att2 = ent:LookupAttachment(att)
	local attdata = ent:GetAttachment(att2)
	
	local pos = attdata.Pos
	local ang = attdata.Ang
	
	local qs = 3
	
	local trace = util.TraceLine({
		start = LocalPlayer():EyePos(),
		endpos = LocalPlayer():GetEyeTrace().HitPos,
		filter = LocalPlayer()
	})
	
	if att == "muzzle" then
		drc_debug_marker_attcol = Color(255, 0, 0, 100)
	--	render.SetMaterial(Material("sprites/reticle"))
	--	render.DrawQuadEasy(FormatViewModelAttachment(wpn.ViewModelFOV, attdata.Pos, false), (trace.Normal:Angle() + Angle(-90, 0, 0)):Up(), qs, qs, Color(255, 255, 255, 255), 0)
	elseif att == "1" or att == "eject" then
		drc_debug_marker_attcol = Color(0, 100, 255, 100)
		render.SetMaterial(Material("models/vuthakral/nodraw"))
	else
		drc_debug_marker_attcol = Color(255, 255, 0, 100)
		render.SetMaterial(Material("models/vuthakral/nodraw"))
	end
	
	render.SetColorMaterialIgnoreZ()
--	render.SetMaterial(Material("particle/Particle_Ring_Wave_Additive"))
--	render.SetMaterial(Material("color_ignorez"))
	
	render.DrawSphere( FormatViewModelAttachment(wpn.ViewModelFOV, attdata.Pos, false), 0.75, 4, 4, drc_debug_marker_attcol)
	
	render.DrawLine( FormatViewModelAttachment(wpn.ViewModelFOV, attdata.Pos, false), FormatViewModelAttachment(wpn.ViewModelFOV, attdata.Pos, false) + ang:Forward() * 2.5, Color( 255, 0, 0, 100 ) )
	render.DrawSphere( FormatViewModelAttachment(wpn.ViewModelFOV, attdata.Pos, false) + ang:Forward() * 2.5, 0.125, 16, 16, Color(255, 0, 0, 100))
	
	render.DrawLine( FormatViewModelAttachment(wpn.ViewModelFOV, attdata.Pos, false), FormatViewModelAttachment(wpn.ViewModelFOV, attdata.Pos, false) + ang:Right() * 2.5, Color( 0, 255, 0, 100 ) )
	render.DrawSphere( FormatViewModelAttachment(wpn.ViewModelFOV, attdata.Pos, false) + ang:Right() * 2.5, 0.125, 16, 16, Color(0, 255, 0, 100))
	
	render.DrawLine( FormatViewModelAttachment(wpn.ViewModelFOV, attdata.Pos, false), FormatViewModelAttachment(wpn.ViewModelFOV, attdata.Pos, false) + ang:Up() * 2.5, Color( 0, 0, 255, 100 ) )
	render.DrawSphere( FormatViewModelAttachment(wpn.ViewModelFOV, attdata.Pos, false) + ang:Up() * 2.5, 0.125, 16, 16, Color(0, 0, 255, 100))
end

hook.Add("PreDrawViewModel", "DrcLerp_Debug", function( vm, ply, wpn )
	if not CLIENT then return end -- fuck singleplayer
	if GetConVar("sv_drc_allowdebug"):GetFloat() == 0 then return end
	if wpn.Draconic == nil then return end
	local attachment = vm:LookupAttachment("muzzle")
	local muz = vm:GetAttachment(attachment)
	if !muz then return end
	local pos = muz.Pos
	local ang = muz.Ang
	
	drc_vm_offangle = Angle(0, 0, 0) + ply:EyeAngles()
	
	local offs = pos - vm:GetPos()
	drc_vmapos = Lerp(FrameTime() * 25, drc_vmapos or offs, offs)
	
	local offsb = ang - vm:GetAngles()
	
	drc_vmoffset_angle_x = math.ApproachAngle(offsb.x, drc_vm_offangle.x, FrameTime() * drc_vm_angdiff_median)
	drc_vmoffset_angle_y = math.ApproachAngle(offsb.y, drc_vm_offangle.y, FrameTime() * drc_vm_angdiff_median)
	drc_vmoffset_angle_z = math.ApproachAngle(offsb.z, drc_vm_offangle.z, FrameTime() * drc_vm_angdiff_median)
	
	drc_vm_angdiff_x = math.AngleDifference(drc_vmoffset_angle_x, drc_vm_offangle.x)
	drc_vm_angdiff_y = math.AngleDifference(drc_vmoffset_angle_y, drc_vm_offangle.y)
	drc_vm_angdiff_z = math.AngleDifference(drc_vmoffset_angle_z, drc_vm_offangle.z)
	
	drc_vm_angdiff = Angle(drc_vm_angdiff_x, drc_vm_angdiff_y, drc_vm_angdiff_z)
	
	drc_vm_angdiff_median = math.Clamp(math.abs((drc_vm_angdiff_x + drc_vm_angdiff_y + drc_vm_angdiff_z) / 3), 16, 60)
	
	drc_vm_angmedian = Lerp(FrameTime() * 5, drc_vm_angdiff_median / (drc_vm_lerpdivval / 6) or 0, drc_vm_angdiff_median / (drc_vm_lerpdivval / 6))
	
	drc_vmaangle = (drc_vm_offangle + drc_vm_angdiff)
	
	if !attachment then return end
	
	if GetConVar("cl_drc_debugmode"):GetString() != "1" then return end
	for k, v in pairs(vm:GetAttachments()) do
		DrawVMAttachments(v.name, vm)
	end
end)

hook.Add("HUDPaint", "DrcLerp_Debug_Visualizer2D", function()
	if GetConVar("sv_drc_allowdebug"):GetFloat() == 0 then return end
	if GetConVar("cl_drc_debugmode"):GetString() != "1" then return end
	local cdi = GetConVar("cl_drc_debug_cameradrag"):GetFloat()
	
	if cdi != 1 then return end
	
	local ply = LocalPlayer()
	local wpn = ply:GetActiveWeapon()
	if !wpn then return end
	if wpn.Draconic == nil then return end
	
	col1 = Color(255, 255, 255, 175)
	col2 = Color(255, 255, 255, 75)
	surface.SetDrawColor( col1 )
	
	surface.DrawCircle(ScrW() / 12, ScrH() / 1.125, 100, col1.r, col1.g, col1.b, col1.a)
	surface.DrawRect(ScrW() / 12, ScrH() / 1.125, 2, 2)
	draw.DrawText("Camera Drag Interpreter", "HudSelectionText", 50, ScrH() / 1.32, Color(236, 236, 236, 175))
	draw.DrawText(drc_vm_lerpang_final, "HudSelectionText", 50, ScrH() / 1.29, Color(236, 236, 236, 175))
	
	surface.SetDrawColor( col2 )
	surface.DrawLine(ScrW() / 12, ScrH() / 1.125, ScrW() / 12  + (drc_vm_lerpang_final.y), ScrH() / 1.125 - (drc_vm_lerpang_final.x))
	surface.SetDrawColor( col1 )
	surface.DrawRect(ScrW() / 12 - 2 + (drc_vm_lerpang_final.y), ScrH() / 1.125 - 2 - (drc_vm_lerpang_final.x), 5, 5)
end)

function ThirdPersonModEnabled(ply)
	drctpcheck1 = false
	drctpcheck2 = false
	drctpcheck3 = false

	if GetConVar("simple_thirdperson_enabled") != nil then
		if GetConVar("simple_thirdperson_enabled"):GetBool() == true then drctpcheck1 = true else drctpcheck1 = false end
	end
	
	if ply:GetNW2Bool("ThirtOTS") == true then drctpcheck2 = true else drctpcheck2 = false end
	
	if GetConVar("thirdperson_etp") != nil then
		if GetConVar("thirdperson_etp"):GetString() == "1" then drctpcheck3 = true else drctpcheck3 = false end
	end
	
	if drctpcheck1 == true or drctpcheck2 == true or drctpcheck3 == true then return true else return false end
end

hook.Add("CalcView", "DrcLerp", function(ply, origin, ang, fov, zn, zf)
	if not !game.IsDedicated() then return end
	if GetConVar("sv_drc_viewdrag"):GetString() != "1" then return end
	if ply:GetViewEntity() ~= ply then return end
	if ply:InVehicle() then return end

	local wpn = ply:GetActiveWeapon()
	if !wpn then return end
	if wpn.Draconic == nil then return end
	local vm = ply:GetViewModel()
	local sights = wpn.SightsDown
	
	local attachment = vm:LookupAttachment("muzzle")
	local pos = Vector(0, drc_vmapos.y, drc_vmapos.z)
	local oang = drc_vmaangle
	
	if GetConVar("cl_drc_lowered_crosshair"):GetFloat() == 1 then
		drc_lower_anglemod = Angle(-8, 0, 0)
	else
		drc_lower_anglemod = Angle(0, 0, 0)
	end
	
	if sights == true or (ply:GetCanZoom() == true && ply:KeyDown(IN_ZOOM)) then
		drc_vm_sightpow = Lerp(FrameTime() * 25, drc_vm_sightpow or 1, 0)
	else
		drc_vm_sightpow = Lerp(FrameTime() * 25, drc_vm_sightpow or 0, 1)
	end
	
	if wpn.Loading == false && wpn.Inspecting == false then
		drc_vm_lerpang = Angle(oang.x, oang.y, Lerp(FrameTime() * drc_vm_angmedian, drc_vm_lerpang.z or 0, 0))
	else
		drc_vm_lerpang = LerpAngle(FrameTime(), oang or Angle(0, 0, 0), oang)
	end
	
	drc_vm_lerppos = Vector(Lerp(FrameTime() * 25, 0 or pos.x, 0), Lerp(FrameTime() * 25, 0 or pos.y, 0), Lerp(FrameTime() * 25, 0 or pos.z, 0))
	
	if wpn.Loading == true then
		drc_vm_lerpdivval = Lerp(FrameTime() * 5, drc_vm_lerpdivval or 30, 30)
	elseif wpn.Inspecting == true then
		drc_vm_lerpdivval = Lerp(FrameTime() * 5, drc_vm_lerpdivval or 16, 16)
	else
		drc_vm_lerpdivval = Lerp(FrameTime() * 5, drc_vm_lerpdivval or 50, 50)
	end
	
	if wpn.SightsDown == true or (wpn.Loading == false && wpn.Inspecting == false && wpn.Idle == 1) then
		local fr = math.Round(1 / FrameTime())
		
		if fr > 15 then
			if ply:KeyDown(IN_SPEED) or wpn.SightsDown == true then
				drc_vm_lerpang_final = Angle(0, 0, 0)
			else
				drc_vm_lerpang_final = LerpAngle(FrameTime() * drc_vm_angmedian, drc_vm_lerpang_final or Angle(0, 0, 0), drc_vm_lerpang)
			end
		else
			drc_vm_lerpang_final = Angle(0, 0, 0)
		end
	else
		drc_vm_lerpang_final = LerpAngle(FrameTime() * drc_vm_angmedian, drc_vm_lerpang_final or drc_vm_lerpang, drc_vm_lerpang)
	end
	
	drc_vm_lerpdiv = Lerp(FrameTime() * 5, drc_vm_lerpdivval or drc_vm_lerpdiv, drc_vm_lerpdivval)
	
	if wpn.IsMelee == false && !attachment then return end

	if ply:GetNW2Int("TFALean", 1337) != 1337 then
	local tfaleanang = LeanCalcView(ply, origin, ang, fov)
		for k, v in pairs(tfaleanang) do
			if k == "origin" then 
				drc_calcview_tfapos = v
			elseif k == "angles" then
				drc_calcview_tfaang = v
			end
		end
	else
		drc_calcview_tfapos = ply:EyePos()
		drc_calcview_tfaang = ply:EyeAngles()
	end
	
	
	if ThirdPersonModEnabled(ply) then return end
	
	if ply:GetNW2Int("TFALean", 1337) != 1337 then
		local view = {
			origin = origin - drc_vm_lerppos / drc_vm_lerpdiv - ( origin - drc_calcview_tfapos),
			angles = ang - drc_vm_lerpang_final / drc_vm_lerpdiv - ( ang - drc_calcview_tfaang) + drc_lower_anglemod * drc_vm_sightpow,
			fov = fov
		}
		return view
	else
		local view = {
			origin = origin - drc_vm_lerppos / drc_vm_lerpdiv,	
			angles = ang - drc_vm_lerpang_final / drc_vm_lerpdiv + drc_lower_anglemod * drc_vm_sightpow,
			fov = fov
		}
		return view
	end
end)