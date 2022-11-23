DRC.Debug = {}

local drc_frame = 0
local drc_framesavg = 0
local function drc_DebugUI()
	if !LocalPlayer():Alive() then return end
	if GetConVar("sv_drc_allowdebug"):GetFloat() == 0 then return end
	if GetConVar("cl_drc_debugmode"):GetFloat() == 0 then return end
	if CurTime() > drc_frame then
		drc_frame = CurTime() + engine.TickInterval() * 30
		drc_framesavg = math.Round(1/RealFrameTime())
	end

	local hp, maxhp, ent = DRC:GetShield(LocalPlayer())
	
	local tps = 694201337
	if game.SinglePlayer() then
		tps = math.Clamp(math.Round(1/FrameTime()), 0, 1/engine.TickInterval())
	else
		tps = math.Round(1/FrameTime())
	end
	
	tps = math.floor(tps)
	
	drcshieldinterp = Lerp(RealFrameTime() * 25, drcshieldinterp or hp, hp)
	draw.DrawText( "Shield: ".. tostring(math.Round(drcshieldinterp)) .."/".. maxhp .."", "TargetID", ScrW() * 0.02, ScrH() * 0.875, color_white, TEXT_ALIGN_LEFT )
	draw.DrawText( "FPS: ".. drc_framesavg .." | ".. math.Round(1/RealFrameTime()) .."", "TargetID", ScrW() * 0.02, ScrH() * 0.855, color_white, TEXT_ALIGN_LEFT )
	draw.DrawText( "TPS: ".. tps .." | ".. math.floor(1/engine.TickInterval()) .."", "TargetID", ScrW() * 0.02, ScrH() * 0.835, color_white, TEXT_ALIGN_LEFT )

	if IsValid(LocalPlayer():GetActiveWeapon()) then
		local curswep = LocalPlayer():GetActiveWeapon()
		
		local ammo, maxammo = curswep:Clip1(), curswep:GetMaxClip1()
		
		if curswep.Draconic == true then
			draw.DrawText( "".. ammo .."(".. math.Round(curswep:GetNWInt("LoadedAmmo"), 4) ..")/".. maxammo .."", "TargetID", ScrW() * 0.975, ScrH() * 0.855, color_white, TEXT_ALIGN_RIGHT )
			draw.DrawText( "".. math.Round(curswep:GetNWInt("Heat"), 4) .."%", "TargetID", ScrW() * 0.975, ScrH() * 0.875, color_white, TEXT_ALIGN_RIGHT )
			draw.DrawText( "".. curswep.Category .." - ".. curswep:GetPrintName() .."", "TargetID", ScrW() * 0.975, ScrH() * 0.835, color_white, TEXT_ALIGN_RIGHT )
			draw.DrawText( "".. curswep.OwnerActivity .."", "TargetID", ScrW() * 0.5, ScrH() * 0.82, color_white, TEXT_ALIGN_CENTER )
			
			local col1 = Color(255, 255, 255, 175)
			local col2 = Color(255, 255, 255, 75)
			local posx, posy = ScrW() * 0.94, ScrH() * 0.73
			surface.SetDrawColor( col1 )
			
			surface.DrawCircle(posx, posy, 100, col1.r, col1.g, col1.b, col1.a)
			surface.DrawRect(posx, posy, 2, 2)
			draw.DrawText("Camera Drag Interpreter", "HudSelectionText", ScrW() * 0.975, ScrH() * 0.6, Color(236, 236, 236, 175), TEXT_ALIGN_RIGHT)
			draw.DrawText(drc_vm_lerpang_final, "HudSelectionText", ScrW() * 0.975, ScrH() * 0.615, Color(236, 236, 236, 175), TEXT_ALIGN_RIGHT)
			
			surface.SetDrawColor( col2 )
			surface.DrawLine(posx, posy, posx + (drc_vm_lerpang_final.y), posy - (drc_vm_lerpang_final.x))
			surface.SetDrawColor( col1 )
			surface.DrawRect(posx - 2 + (drc_vm_lerpang_final.y), posy - 2 - (drc_vm_lerpang_final.x), 5, 5)
		else
			draw.DrawText( "".. ammo .."/".. maxammo .."", "TargetID", ScrW() * 0.975, ScrH() * 0.875, color_white, TEXT_ALIGN_RIGHT )
			draw.DrawText( curswep:GetPrintName(), "TargetID", ScrW() * 0.975, ScrH() * 0.855, color_white, TEXT_ALIGN_RIGHT )
		end
	end
	
	local label = DRC:GetPower()
	if label != "Desktop" then label = "Mobile: ".. DRC:GetPower() .."%" end
	
	draw.DrawText( "Draconic Base version ".. Draconic.Version .."", "TargetID", ScrW() * 0.5, ScrH() * 0.92, color_white, TEXT_ALIGN_CENTER )
	draw.DrawText( "".. LocalPlayer():Name() .." (".. LocalPlayer():SteamID64() ..")", "TargetID", ScrW() * 0.5, ScrH() * 0.94, color_white, TEXT_ALIGN_CENTER )
	draw.DrawText( "".. DRC:GetOS() .." (".. DRC:GetPower() ..") - ".. os.date() .."", "TargetID", ScrW() * 0.5, ScrH() * 0.96, color_white, TEXT_ALIGN_CENTER )
	if game.SinglePlayer() then
		draw.DrawText( "".. DRC:GetServerMode() .." - ".. engine.ActiveGamemode() .."", "TargetID", ScrW() * 0.5, ScrH() * 0.98, color_white, TEXT_ALIGN_CENTER )
	else
		draw.DrawText( "".. DRC:GetServerMode() .." - ".. GetHostName() .." - ".. engine.ActiveGamemode() .."", "TargetID", ScrW() * 0.5, ScrH() * 0.98, color_white, TEXT_ALIGN_CENTER )
	end
	
	local eyepos = LocalPlayer():EyePos()
	local roomsize = DRC:RoomSize(LocalPlayer())
	local roomname = DRC:GetRoomSizeName(roomsize)
	local ll = render.GetLightColor(eyepos)
	local llhp = render.GetLightColor(LocalPlayer():GetEyeTrace().HitPos)
	
	draw.DrawText( "Thirdperson detection: ".. tostring(DRC:ThirdPersonEnabled(LocalPlayer())) .."", "TargetID", ScrW() * 0.02, ScrH() * 0.022, color_white, TEXT_ALIGN_LEFT )
	draw.DrawText( "Room size: ".. roomname .."", "TargetID", ScrW() * 0.02, ScrH() * 0.04, color_white, TEXT_ALIGN_LEFT )
	draw.DrawText( "Weather mod: ", "TargetID", ScrW() * 0.02, ScrH() * 0.06, color_white, TEXT_ALIGN_LEFT )
	draw.RoundedBox(0, ScrW() * 0.02 + 115, ScrH() * 0.0575, 24, 24, Color(DRC.WeathermodScalar.x * 255, DRC.WeathermodScalar.y * 255, DRC.WeathermodScalar.z * 255))
	draw.DrawText( "Light level: ", "TargetID", ScrW() * 0.02, ScrH() * 0.08, color_white, TEXT_ALIGN_LEFT )
	draw.RoundedBox(0, ScrW() * 0.02 + 115, ScrH() * 0.08, 24, 24, Color(ll.r * 255, ll.g * 255, ll.b * 255))
	draw.DrawText( "( ^ Hitpos): ", "TargetID", ScrW() * 0.02, ScrH() * 0.1, color_white, TEXT_ALIGN_LEFT )
	draw.RoundedBox(0, ScrW() * 0.02 + 115, ScrH() * 0.1, 24, 24, Color(llhp.r * 255, llhp.g * 255, llhp.b * 255))
	
	draw.DrawText( "".. game.GetMap() .." @ Vector(".. tostring(LocalPlayer():GetPos()) ..")", "TargetID", ScrW() * 0.02, ScrH() * 0.978, color_white, TEXT_ALIGN_LEFT )
	
	local vm = LocalPlayer():GetViewModel()
	if !IsValid(vm) then return end
	
	local seq = vm:GetSequence()
	local act = vm:GetSequenceActivityName(seq)
	local cycle = vm:GetCycle()
	
	draw.DrawText( "".. act .." | ".. math.Round(cycle * 100) .."%", "TargetID", ScrW() * 0.5, ScrH() * 0.8, color_white, TEXT_ALIGN_CENTER )
end
hook.Add("HUDPaint", "drc_DebugUI", drc_DebugUI)

local function drc_TraceInfo()
	if GetConVar("sv_drc_allowdebug"):GetFloat() == 0 then return end
	if GetConVar("cl_drc_debugmode"):GetFloat() == 0 then return end
	local pos = DRC.CalcView.ToScreen
	local data = DRC.CalcView.Trace
	local ent = data.Entity
--	if !IsValid(ent) then return end
	local hp = 0
--	if !ent:IsWorld() then hp = ent:Health() end
	
	local col = Color(255, 255, 255)
	
	surface.SetFont("DermaDefault")
	surface.SetTextColor(col)
	surface.SetTextPos(pos.x - pos.x/2, pos.y)
	surface.DrawText(tostring(ent))
	
	if hp && IsValid(ent) then 
		local base = DRC:GetBaseName(ent)
		local hp, maxhp = DRC:Health(ent)
		if hp == nil then hp = 0 end
		if maxhp == nil then maxhp = 0 end
		
		surface.SetTextPos(pos.x - pos.x/2, pos.y + 32)
		surface.SetTextColor(0, 255, 100)
		surface.DrawText(tostring("".. hp .." / ".. maxhp ..""))
		
		local shp, smhp, sent = DRC:GetShield(ent)
		if IsValid(sent) then
			surface.SetTextPos(pos.x - pos.x/2.6, pos.y + 32)
			surface.SetTextColor(0, 200, 255)
			surface.DrawText(tostring("".. math.Round(shp) .." / ".. smhp ..""))
		end
	end
	
	local BaseProfile = scripted_ents.GetStored("drc_att_bprofile_generic")
	local BaseBT = BaseProfile.t.BulletTable
	local BaseDT = BaseBT.MaterialDamageMuls
	local enum = nil
	
	if ent:IsWorld() then
		enum = LocalPlayer():GetEyeTrace().SurfaceProps
		if enum != -1 then enum = tostring("MAT_".. string.upper(tostring(util.GetSurfaceData(enum)["name"])) .."") end
	else
		if !IsValid(ent) then return end
		enum = DRC:SurfacePropToEnum(ent:GetBoneSurfaceProp(0))
	end
	
	if BaseDT[enum] && enum != "MAT_" == nil then
		col = Color(255, 0, 0)
	end
	surface.SetTextColor(col)
	surface.SetTextPos(pos.x - pos.x/2, pos.y + 16)
	if enum != "MAT_" then surface.DrawText(tostring(enum)) end
	
	if ent:IsWorld() then return end
	surface.SetFont("DermaDefault")
	surface.SetTextColor(255, 255, 255)
	surface.SetTextPos(pos.x - pos.x/2, pos.y + 48)
	surface.DrawText(tostring(ent:GetPos()))
	
	surface.SetTextPos(pos.x - pos.x/2, pos.y + 64)
	surface.DrawText(tostring(ent:GetModel()))
	
	surface.SetTextPos(pos.x - pos.x/2, pos.y + 80)
	surface.DrawText("Owner: ".. tostring(ent:GetOwner()) .."")
end
hook.Add("HUDPaint", "drc_TraceInfo", drc_TraceInfo)

DRC.Debug.TraceLines = {}
DRC.Debug.Lights = {}
DRC.Debug.Sounds = {}

hook.Add("PostDrawTranslucentRenderables", "drc_DebugStuff", function()
	if GetConVar("sv_drc_allowdebug"):GetFloat() == 0 then return end
	if GetConVar("cl_drc_debugmode"):GetFloat() == 0 then return end
	
	if GetConVar("cl_drc_debug_tracelines"):GetFloat() != 0 then
		for k,v in pairs(DRC.Debug.TraceLines) do
			if v != nil then
				local p1, p2, col = v[1], v[2], v[3]
				render.DrawLine(p1, p2, col, true)
			end
		end
	end
	
	if GetConVar("cl_drc_debug_lights"):GetFloat() != 0 then
		for k,v in pairs(DRC.Debug.Lights) do
			if v != nil then
				local pos, col, size, colmul = v[1], v[2], v[3], v[4]
				col = Color(col.r * colmul, col.g * colmul, col.b * colmul, 255)
				cam.Start3D()
					render.SetMaterial(Material("icon64/light.png"))
					render.DrawSprite(pos, 16, 16, col)
				cam.End3D()
				render.SetColorMaterial()
				render.DrawWireframeSphere( pos, size, 16, 16, Color( col.r, col.g, col.b ), true )
			end
		end
	end
	
	if GetConVar("cl_drc_debug_sounds"):GetFloat() != 0 then
		for k,v in pairs(DRC.Debug.Sounds) do
			if v != nil then
				local pos = v[1]
				if pos then
				local col = Color(160, 160, 160, 255)
				cam.Start3D()
					render.SetMaterial(Material("icon64/ambient_generic.png"))
					render.DrawSprite(pos, 16, 16, col)
				cam.End3D()
				end
			end
		end
	end
	
	if GetConVar("cl_drc_debug_cubemaps"):GetFloat() != 0 then
		for k,v in pairs(drc_cubesamples) do
			if v != nil then
				local pos = v
				local col = Color(160, 160, 160, 255)
				cam.Start3D()
					render.SetMaterial(Material("icon64/env_cubemap.png"))
					render.DrawSprite(pos, 16, 16, col)
				cam.End3D()
			--	render.SetColorMaterial()
			--	render.DrawWireframeSphere( pos, size, 16, 16, Color( col.r, col.g, col.b ), true )
			end
		end
	end
	
	if GetConVar("cl_drc_debug_hitboxes"):GetFloat() == 0 then return end
	
	local ply = LocalPlayer()
	local tgtent = DRC.CalcView.Trace.Entity
	local HitboxColours = {
		DRC.Cols.pulsewhite,
		Color(255, 0, 0, 255),
		Color(0, 255, 0, 255),
		Color(170, 170, 75, 255),
		Color(0, 0, 255, 255),
		Color(255, 100, 255, 255),
		Color(90, 175, 255, 255),
		Color(255, 255, 255, 255)
	}
	
	local function DoTheFunny(pos,ang, mins, maxs, col)
		render.SetColorMaterial()
		render.DrawWireframeBox( pos, ang, mins, maxs, col, true)
		render.DrawBox( pos, ang, mins, maxs, Color(col.r, col.g, col.b, 5), true)
	end
	
	if DRC:ThirdPersonEnabled(ply) then
	for hitgroup=0, ply:GetHitboxSetCount() - 1 do
		 for box=0, ply:GetHitBoxCount(hitgroup) - 1 do
		 	local pos, ang =  ply:GetBonePosition( ply:GetHitBoxBone(box, hitgroup) )
		 	local mins, maxs = ply:GetHitBoxBounds(box, hitgroup)
			local enum = ply:GetHitBoxHitGroup(box, hitgroup) + 1
			local col = HitboxColours[enum]
			if !col then col = Color(255, 255, 255, 255) end
			DoTheFunny( pos, ang, mins, maxs, col)
		end
	end
	end
	
	if !IsValid(tgtent) then return end
	if tgtent:GetHitboxSetCount() == nil then return end
	for hitgroup=0, tgtent:GetHitboxSetCount() - 1 do
		 for box=0, tgtent:GetHitBoxCount( hitgroup ) - 1 do
		 	local pos, ang =  tgtent:GetBonePosition( tgtent:GetHitBoxBone(box, hitgroup) )
		 	local mins, maxs = tgtent:GetHitBoxBounds(box, hitgroup)
			local enum = tgtent:GetHitBoxHitGroup(box, hitgroup) + 1
			local col = HitboxColours[enum]
			if !col then col = Color(255, 255, 255, 255) end
			DoTheFunny( pos, ang, mins, maxs, col)
		end
	end
end)

net.Receive("DRC_RenderTrace", function()
	local tbl = net.ReadTable()
	if !tbl then return end
	local tr, colour, thyme = tbl[1], tbl[2], tbl[3]
	if isstring(colour) then colour = DRC.Cols[colour] end
	
	DRC:RenderTrace(tr, colour, thyme)
end)

function DRC:RenderTrace(tr, colour, thyme)
	if GetConVar("cl_drc_debug_tracelines"):GetFloat() != 1 then return end
	local id = math.Round(math.Rand(1, 999999999))
	local p1, p2 = tr.StartPos, tr.HitPos
	
	DRC.Debug.TraceLines[id] = {p1, p2, colour}
	timer.Simple(thyme, function() DRC.Debug.TraceLines[id] = nil end)
end

function DRC:IDLight(pos, colour, size, colmul, thyme)
	if GetConVar("cl_drc_debug_lights"):GetFloat() != 1 then return end
	local id = math.Round(math.Rand(1, 999999999))
	colmul = colmul * 2
	DRC.Debug.Lights[id] = {pos, colour, size, colmul}
	timer.Simple(thyme, function() DRC.Debug.Lights[id] = nil end)
end