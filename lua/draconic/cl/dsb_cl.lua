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

--[[ hook.Add("PreDrawPlayerHands", "drc_FPShield", function(hands, vm, ply, wpn)
	if !IsValid(DRC.CSPlayerHandShield) then return end
	DRC.CSPlayerHandShield:SetAutomaticFrameAdvance(true)
	DRC.CSPlayerHandShield:SetModel(hands:GetModel())
	DRC.CSPlayerHandShield:SetAngles(hands:GetAngles())
	DRC.CSPlayerHandShield:SetPos(hands:GetPos())
--	DRC.CSPlayerHandShield:SetParent(hands)
	DRC.CSPlayerHandShield:SetMaterial("models/vuthakral/shield_example")
	
	for k,v in pairs(DRC:GetBones(hands)) do
		local id = hands:LookupBone(k)
		if id != nil then
			local matr = hands:GetBoneMatrix(id)
			if matr then
				local newmatr = Matrix()
				local shp, mshp, ent = DRC:GetShield(LocalPlayer())
				newmatr:SetTranslation(matr:GetTranslation())
				newmatr:SetAngles(matr:GetAngles())
				newmatr:SetScale(Vector(ent.ShieldScale, ent.ShieldScale, ent.ShieldScale))
				DRC.CSPlayerHandShield:SetBoneMatrix(id, newmatr)
			end
		end
	end
end) --]]

DRC.Cols = {}

local CSModelCheck = 0
local CSShieldModelCheck = 0
hook.Add("Think", "drc_CSThinkStuff", function()
	if !IsValid(LocalPlayer()) then return end
	local ply = LocalPlayer()
	local etr = util.TraceLine({
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + ply:EyeAngles():Forward() * 10000,
		filter = function(ent) if ent != ply then return true end end
	})
	
	DRC.CalcView.Trace = etr
	DRC.CalcView.HitPos = etr.HitPos
	DRC.CalcView.ToScreen = DRC.CalcView.HitPos:ToScreen()
	if DRC.CalcView.LightColour then DRC.CalcView.LightColour:SetString(tostring(render.GetLightColor(ply:EyePos()))) end
	
	DRC.Cols = {
		["error"] = Color(TimedSin(1, 127, 255, 0), 0, 0, 255),
		["pulsewhite"] = Color(TimedSin(1, 127, 255, 0), TimedSin(1, 127, 255, 0), TimedSin(1, 127, 255, 0), 255),
		["gamer"] = Color(TimedSin(2.75, 127, 255, 0), TimedSin(1.83, 127, 255, 0), TimedSin(0.916, 127, 255, 0), 255),
	}
	
	if CurTime() > CSModelCheck then
		CSModelCheck = CurTime() + 5
		for k,v in pairs(ents.FindByClass("drc_csplayermodel")) do
			if v:GetClass() == "drc_csplayermodel" && v != DRC.CSPlayerModel then v:Remove() end
		end
	end
	
	-- It was either do this or network something every time an entity takes damage. So yeah...
	if CurTime() > CSShieldModelCheck then
	--	if !IsValid(DRC.CSPlayerHandShield) then
	--		local hands = ply:GetHands()
	--		DRC.CSPlayerHandShield = ents.CreateClientside("drc_shieldmodel")
	--	end
		CSShieldModelCheck = CurTime() + 5
		for k,v in pairs(ents.GetAll()) do
			local shp, smhp, sent = DRC:GetShield(v)
			if smhp != 0 && !IsValid(sent) then
				local shield = ents.CreateClientside("drc_shieldmodel")
				shield.FollowEnt = v
				shield:Spawn()
			end
		end
	end
end)

hook.Add("RenderScreenspaceEffects", "DRC_Camera_Overlays", function()
	local ply = LocalPlayer()
	if !IsValid(ply) && !ply:Alive() then return end
	local wpn = ply:GetActiveWeapon()
	if IsValid(wpn) && wpn:GetClass() == "drc_camera" then
		DrawMaterialOverlay(DRC.CameraOverlay, DRC.CameraPower)
	end
end)

local GCT = CurTime()
local GNT = GCT + 1

local bool, alpha, alphalerp, SwapCD = true, 0, 0, 0
local function drc_IText()
	local ply = LocalPlayer()
	local center = { ScrW()/2, ScrH()/2 }
	local curswep = ply:GetActiveWeapon()
	
	
	if !IsValid(ply.ViableWeapons) then ply.ViableWeapons = {} end
	if !IsValid(ply.PickupWeapons) then ply.PickupWeapons = {} end
--	if !ViableWeaponCheck(ply) then return end
	
	ViableWeaponCheck(ply)

	if table.IsEmpty(ply.ViableWeapons) then b1 = false else b1 = true end
	if table.IsEmpty(ply.PickupWeapons) then b2 = false else b2 = true end
	
	if b1 or b2 == true then
		alpha = 255
	else
		alpha = 0
	end
	alphalerp = Lerp(FrameTime() * 25, alphalerp or alpha, alpha)
	
	local wpc = ply:GetNWVector("EnergyTintVec")
	wpc.r = math.Clamp(wpc.r, 0.1, 1)
	wpc.g = math.Clamp(wpc.g, 0.1, 1)
	wpc.b = math.Clamp(wpc.b, 0.1, 1)
	wpc = wpc * 255
	local TextCol = Color(wpc.r, wpc.g, wpc.b, alphalerp)
	
	surface.SetDrawColor(TextCol)
	
	local src, text = nil, nil
	if b2 then
		src = ply.PickupWeapons[1]
		text = "pick up"
	end
	if b1 then
		src = ply.ViableWeapons[1]
		text = "swap for"
	end
	if b1 && b2 then text = "swap for" end
	
	if b1 or b2 then
		if src.WepSelectIcon != nil then
			if isnumber(src.WepSelectIcon) then
				surface.SetTexture( src.WepSelectIcon )
			elseif isstring(src.WepSelectIcon) then
				surface.SetTexture( surface.GetTextureID( src.WepSelectIcon ) )
			end
			surface.DrawTexturedRect(center[1] * 1.1, center[2] * 1.4, ScrH() / 8, ScrH() / 8)
			draw.DrawText("Press ".. string.upper(ReturnKey("+use")) .." to ".. text .." ", "ApercuStatsTitle", center[1] * 0.81, center[2] * 1.5, TextCol)
		else
			draw.DrawText("Press ".. string.upper(ReturnKey("+use")) .." to ".. text .." ".. src.PrintName .."", "ApercuStatsTitle", center[1] * 0.81, center[2] * 1.5, TextCol)
		end
	end
end
hook.Add("HUDPaint", "drc_interactiontext", drc_IText)

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
					if curswep.SightsDown then
						sights = "True"
					else
						sights = "False"
					end
				elseif curswep.Base == "draconic_gun_base" then
					if curswep.SightsDown == true then
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
	
	render.DrawLine( FormatViewModelAttachment(wpn.ViewModelFOV, attdata.Pos, false), FormatViewModelAttachment(wpn.ViewModelFOV, attdata.Pos, false) + ang:Right() * -2.5, Color( 0, 255, 0, 100 ) )
	render.DrawSphere( FormatViewModelAttachment(wpn.ViewModelFOV, attdata.Pos, false) + ang:Right() * -2.5, 0.125, 16, 16, Color(0, 255, 0, 100))
	
	render.DrawLine( FormatViewModelAttachment(wpn.ViewModelFOV, attdata.Pos, false), FormatViewModelAttachment(wpn.ViewModelFOV, attdata.Pos, false) + ang:Up() * 2.5, Color( 0, 0, 255, 100 ) )
	render.DrawSphere( FormatViewModelAttachment(wpn.ViewModelFOV, attdata.Pos, false) + ang:Up() * 2.5, 0.125, 16, 16, Color(0, 0, 255, 100))
end

--[[
hook.Add( "PostDrawOpaqueRenderables", "DRC_VisualizeAimAssist", function()
	if !IsValid(LocalPlayer()) then return end
	local curswep = LocalPlayer():GetActiveWeapon()
	if !curswep.Draconic then return end
	local mat = Material( "models/shiny" )
	mat:SetFloat( "$alpha", 0.25 )
	
	local dir = LocalPlayer():GetAimVector()
	local angle = math.cos( curswep.SpreadCone ) -- 15 degrees
	local startPos = LocalPlayer():EyePos()

	local entities = DRC:EyeCone(LocalPlayer(), 1500, angle)

	-- draw the outer box
	local mins = Vector( -1500, -1500, -1500 )
	local maxs = Vector( 1500, 1500, 1500 )

	render.SetMaterial(mat)
	render.DrawWireframeBox( startPos, Angle( 0, 0, 0 ), mins, maxs, color_white, true )
	render.DrawBox( startPos, Angle( 0, 0, 0 ), -mins, -maxs, color_white )

	-- draw the lines
	for id, ent in ipairs( entities ) do
		render.DrawLine( ent:WorldSpaceCenter() + dir * ( ent:WorldSpaceCenter()-startPos ):Length(), ent:WorldSpaceCenter(), Color( 255, 0, 0 ) )
	end
end ) --]]

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

hook.Add("PreDrawViewModel", "drc_interact_hidevm", function(vm, ply, wep)
	if ply:GetActiveWeapon().Draconic == true && ply:GetActiveWeapon().Secondary.ScopeHideVM == true && ply:GetActiveWeapon().SightsDown == true then return true end
	if ply:GetNWBool("Interacting") == true then return true end
end)
hook.Add("PostDrawViewModel", "drc_interact_hidevm", function(vm, ply, wep)
	if ply:GetActiveWeapon().Draconic == true && ply:GetActiveWeapon().Secondary.ScopeHideVM == true && ply:GetActiveWeapon().SightsDown == true then return true end
	if ply:GetNWBool("Interacting") == true then return true end
end)
hook.Add("PostDrawViewHands", "drc_interact_hidevm", function(vm, ply, wep)
	if ply:GetActiveWeapon().Draconic == true && ply:GetActiveWeapon().SightsDown == true then return true end
	if ply:GetNWBool("Interacting") == true then return true end
end)

function ThirdPersonModEnabled(ply)
	local veh, drctpcheck5 = ply:GetVehicle(), false
	if IsValid(veh) then
		drctpcheck5 = veh:GetThirdPersonMode()
	end
	
	drctpcheck1 = false
	drctpcheck2 = false
	drctpcheck3 = false
	drctpcheck4 = false

	if GetConVar("simple_thirdperson_enabled") != nil then
		if GetConVar("simple_thirdperson_enabled"):GetFloat() == 1 then drctpcheck1 = true else drctpcheck1 = false end
	end
	
	if ply:GetNW2Bool("ThirtOTS") == true then drctpcheck2 = true else drctpcheck2 = false end
	
	if GetConVar("thirdperson_etp") != nil then
		if GetConVar("thirdperson_etp"):GetString() == "1" then drctpcheck3 = true else drctpcheck3 = false end
	end
	
	if GetConVar("cl_view_ext_tps") != nil then
		if GetConVar("cl_view_ext_tps"):GetString() != "0" then drctpcheck4 = true else drctpcheck4 = false end
	end
	
	if drctpcheck1 == true or drctpcheck2 == true or drctpcheck3 == true or drctpcheck4 == true or drctpcheck5 == true then return true else return false end
end

function DRC:ThirdPersonEnabled(ply)
	if ThirdPersonModEnabled(ply) == true then return true end
	if ply:GetViewEntity() != ply then return true end
	if DRC:IsDraconicThirdPersonEnabled(ply) == true then return true end
	local curswep = ply:GetActiveWeapon()
	if curswep.ASTWTWO == true then return true end
	if ply:GetNWString("Draconic_ThirdpersonForce") == "On" then return true end
	if ply:GetNWString("Draconic_ThirdpersonForce") == "Off" then return false end
	if GetConVar("sv_drc_disable_thirdperson"):GetFloat() == 1 then return false end
	if GetConVar("cl_drc_thirdperson"):GetFloat() == 1 then return true else return false end
end

function DRC:ShouldDoDRCThirdPerson(ply)
	if !IsValid(ply) then return end
	local curswep = ply:GetActiveWeapon()
	if curswep.Draconic && curswep.Thirdperson == true then return true end
	if GetConVar("cl_drc_thirdperson"):GetFloat() == 1 then return true end
	return false
end

function DRC:IsDraconicThirdPersonEnabled(ply)
	if !IsValid(ply) then return end
	local curswep = ply:GetActiveWeapon()
	if !IsValid(curswep) then
		if GetConVar("sv_drc_disable_thirdperson"):GetFloat() == 1 then return false end
		if GetConVar("cl_drc_thirdperson"):GetFloat() == 1 then return true end
	else
		if curswep.Draconic == true && curswep.Thirdperson == true then return true end
		if GetConVar("sv_drc_disable_thirdperson"):GetFloat() == 1 then return false end
		if GetConVar("cl_drc_thirdperson"):GetFloat() == 1 then return true end
	end
	return false
end

-- hypothetically, since lua runs linearly & reads alphabetically, having my hook name start with an exclamation mark should have it run before any others.
-- This should, again hypothetically, prevent the five million shitty """""viewbobbing""""" scripts from breaking this. It might also help shitty thirdperson mod that don't know how to overwrite CalcView hooks.
hook.Add("CalcView", "!DrcLerp", function(ply, origin, ang, fov, zn, zf)
	if !IsValid(ply) then return end
	if ThirdPersonModEnabled(ply) then return end
	if not !game.IsDedicated() then return end
	if GetConVar("sv_drc_viewdrag"):GetString() != "1" then return end
	if ply:GetViewEntity() ~= ply then return end
	if ply:InVehicle() then return end

	local wpn = ply:GetActiveWeapon()
	if !IsValid(wpn) then return end
	if wpn:GetClass() == "drc_camera" then return end
	if wpn.Draconic == nil then return end
	if wpn.IsMelee == true then return end
	local vm = ply:GetViewModel()
	local sights = wpn.SightsDown
	
	local attachment = vm:LookupAttachment("muzzle")
	local pos = Vector(0, drc_vmapos.y, drc_vmapos.z)
	local oang = drc_vmaangle
	
	if GetConVar("cl_drc_lowered_crosshair"):GetFloat() == 1 then
		DRC.CrosshairAngMod = Angle(-8, 0, 0)
	else
		DRC.CrosshairAngMod = Angle(0, 0, 0)
	end
	
	if sights == true or (ply:GetCanZoom() == true && ply:KeyDown(IN_ZOOM)) then
		drc_vm_sightpow = Lerp(FrameTime() * 25, drc_vm_sightpow or 1, 0)
	else
		drc_vm_sightpow = Lerp(FrameTime() * 25, drc_vm_sightpow or 0, 1)
	end
	
	if sights == true then
		drc_vm_sightpow_inv = Lerp(FrameTime() * 25, drc_vm_sightpow_inv or 0, 1)
	else
		drc_vm_sightpow_inv = Lerp(FrameTime() * 25, drc_vm_sightpow_inv or 1, 0)
	end
	
	drc_crosshair_pitchmod = Angle(wpn.Secondary.ScopePitch, 0, 0) * drc_vm_sightpow_inv
	
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
	
	if ply:GetNW2Int("TFALean", 1337) != 1337 then
		DRC.CalcView.Pos = drc_vm_lerppos / drc_vm_lerpdiv - ( origin - drc_calcview_tfapos)
		DRC.CalcView.Ang = drc_vm_lerpang_final / drc_vm_lerpdiv - ( ang - drc_calcview_tfaang) + DRC.CrosshairAngMod * drc_vm_sightpow
		if GetConVar("cl_drc_sway"):GetFloat() != 1 then DRC.CalcView.Ang = Angle() end
		local view = {
			origin = origin - drc_vm_lerppos / drc_vm_lerpdiv - ( origin - drc_calcview_tfapos),
			angles = ang - DRC.CalcView.Ang,
			fov = fov
		}
		return view
	else
		DRC.CalcView.Pos = drc_vm_lerppos / drc_vm_lerpdiv
		DRC.CalcView.Ang = drc_crosshair_pitchmod - drc_vm_lerpang_final / drc_vm_lerpdiv + DRC.CrosshairAngMod * drc_vm_sightpow
		if GetConVar("cl_drc_sway"):GetFloat() != 1 then DRC.CalcView.Ang = Angle() end
		local view = {
			origin = origin - drc_vm_lerppos / drc_vm_lerpdiv,	
			angles = ang + DRC.CalcView.Ang,
			fov = fov
		}
		return view
	end
end)