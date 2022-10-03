DRC.VoiceMenuState = false
DRC.VoiceMenuTimeout = 0

function DRC:VoiceMenuTrigger()
	DRC.VoiceMenuState = true
	DRC.VoiceMenuTimeout = CurTime() + 5
end

function DRC:VoiceMenuKill()
	DRC.VoiceMenuState = false
	DRC.VoiceMenuTimeout = CurTime()
end

function DRC:VoiceMenuToggle()
	if DRC.VoiceMenuState == false then
		DRC:VoiceMenuTrigger()
	else
		DRC:VoiceMenuKill()
	end
end

function DRC:SendVoiceCall(call)
	local t={LocalPlayer(), call}
	net.Start("DRCVoiceSet_CL")
	net.WriteTable(t)
	net.SendToServer()
	DRC:VoiceMenuKill()
end

function DRC:SendVoiceLineRequest(ply, call, subcall)
	timer.Simple(engine.TickInterval(), function()
		local t={ply, call, subcall}
		net.Start("DRCVoiceSet_CL")
		net.WriteTable(t)
		net.SendToServer()
		DRC:VoiceMenuKill()
	end)
end

hook.Add("Tick", "VoiceSets_MenuTimeout", function()
	if DRC.VoiceMenuState == true && CurTime() > DRC.VoiceMenuTimeout then DRC.VoiceMenuState = false end
end)

local slots = {
	["+use"] = "",
	["slot1"] = "move",
	["slot2"] = "move",
	["slot3"] = "",
	["slot4"] = "",
	["slot5"] = "",
	["slot6"] = "",
	["slot7"] = "",
	["slot8"] = "",
	["slot9"] = ""
}

hook.Add("PlayerBindPress", "VoiceSets_Menu", function(ply, bind, pressed, code)
	if !IsValid(ply) or !ply:Alive() then return end
	
	if input.LookupBinding("draconic_voicesets_menu_toggle", true) == nil then
		if bind == "+menu_context" then
			DRC:VoiceMenuToggle()
		end
	end
	
	if game.SinglePlayer() then
		if bind == "slot1" && DRC.VoiceMenuState == true then 
			net.Start("DRC_PlayerSquadHelp")
			net.WriteEntity(LocalPlayer())
			net.SendToServer()
		end
		if bind == "slot2" && DRC.VoiceMenuState == true then 
			net.Start("DRC_PlayerSquadMove")
			net.WriteEntity(LocalPlayer())
			net.SendToServer()
		end
	end
	if slots[bind] && DRC.VoiceMenuState == true then DRC:SendVoiceCall(bind) return true end
	
	if bind == "+reload" then
		local wpn = ply:GetActiveWeapon()
		if IsValid(wpn) then
			local clip = wpn:Clip1()
			local maxclip = wpn:GetMaxClip1()
			local ammo = wpn:GetPrimaryAmmoType()
			local reserve = ply:GetAmmoCount(ammo)
			if clip < maxclip && reserve > 0 then
				if game.GetAmmoName(ammo) != "ammo_drc_battery" then DRC:SendVoiceLineRequest(LocalPlayer(), "Actions", "Reload") end
			end
		end
	end
	
	if bind == "+attack" then
		local wpn = ply:GetActiveWeapon()
		if IsValid(wpn) then
			local function IsMeleeWeapon(wep)
				local hardcoded = {
					["weapon_crowbar"] = true,
					["weapon_crowbar_hl1"] = true,
					["weapon_stunstick"] = true
				}
				if !wep:IsScripted() && hardcoded[wep:GetClass()] then return true else return false end
				-- Other bases will need to add their own support, I draw the line of helping everyone out here.
				-- It would be insanity to check every base on this.
			end
			
			if IsMeleeWeapon(wpn) then DRC:SendVoiceLineRequest(LocalPlayer(), "Actions", "Melee") end
			
			local clip = wpn:Clip1()
			local maxclip = wpn:GetMaxClip1()
			
			if maxclip > 0 && clip <= 0 && !LocalPlayer():KeyDown(IN_USE) then DRC:SendVoiceLineRequest(LocalPlayer(), "Reactions", "NoAmmo") end
		end
	end
end)

hook.Add("HUDPaintBackground", "VoiceSets_HUD", function()
	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	if DRC:GetVoiceSet(LocalPlayer()) == nil then return end
	if !ply:Alive() then return end
	if DRC.VoiceMenuState != true then return end
	draw.RoundedBox(8, 16, ScrH() * 0.5, 148, 200, Color(127, 127, 127, 100))
	
	local tbl = {
		"Spot",
		"Help!",
		"Let's go!",
		"Compliment / Thanks!",
		"Insult / Taunt",
		"Greetings",
		"Question / What?",
		"Agree",
		"Disagree / Doubt",
		"Apologize",
		"Cancel",
	}
	
	for i=1,11 do
		local height = i*16
		local press = "E"
		local text = tbl[i]
		local def = -1+i
		local defname = "E"
		if i > 1 then press = i-1 end
		if isnumber(press) then press = ReturnKey("slot".. press .."") end
		
		if input.LookupBinding("draconic_voicesets_menu_toggle", true) == nil then
			if i == 11 then press = string.upper(ReturnKey("+menu_context")) end
		else
			if i == 11 then press = string.upper(ReturnKey("draconic_voicesets_menu_toggle")) end
		end
		
		defname = DRC.VoiceSetDefs["slot".. def ..""]
		local valid = DRC.VoiceSets[DRC:GetVoiceSet(LocalPlayer())][defname]
		if press == "E" then valid = DRC.VoiceSets[DRC:GetVoiceSet(LocalPlayer())]["Spotting"] end
		
		if valid or i == 11 then
			draw.SimpleTextOutlined("[".. press .."] ".. text .."", "DermaDefault", 32, 10 + ScrH() * 0.5 - 8 + height, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255))
		else
			draw.SimpleTextOutlined("[".. press .."] ".. text .."", "DermaDefault", 32, 10 + ScrH() * 0.5 - 8 + height, Color(127, 127, 127, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 127))
		end
	end
end)