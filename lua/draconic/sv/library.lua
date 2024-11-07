-- ###Library
-- ###Runtime
-- ###Debug





-- ###Library
if game.SinglePlayer() then
	function DRC:MakeWeaponProp(ply)
		local swep = ply:GetActiveWeapon()
		local model = swep:GetModel()
		
		local pos = ply:GetPos() + ply:OBBCenter() + ply:GetAngles():Forward() * 50
		
		local ent = ents.Create("prop_physics")
		ent:SetModel(model)
		ent:SetPos(pos)
		ent:Spawn()
		
		undo.Create("prop")
			undo.AddEntity(ent)
			undo.SetPlayer(ply)
		undo.Finish()
	end
	
	concommand.Add("drc_debug_spawnweaponmodel", function(ply, cmd, args)
		DRC:MakeWeaponProp(ply)
	end)
end

function DRC:CheaterWarning(ply, str)
	local ID64 = ply:SteamID64()
	MsgC(Color(255, 0, 0), "\n[DRACONIC BASE - CHEATER WARNING]\n", Color(255,255,255), "> ", Color(255, 255, 0), "Player: ", Color(255, 255, 255), "".. ply:Name() .."\n> ", Color(255, 255, 0), "ID64: ", Color(255, 255, 255), "".. ID64 .."\n\n> ".. str .."\n\n")
end

function DRC:CreateComBall(ball)
	local spawner = ents.Create("point_combine_ball_launcher")
	spawner:SetPos(ball.pos)
	spawner:SetAngles(ball.ang)
	
	spawner:SetKeyValue("minspeed", ball.minspeed or 1250)
	spawner:SetKeyValue("maxspeed", ball.maxspeed or 1250)
	spawner:SetKeyValue("ballradius", ball.ballradius or 30)
	spawner:SetKeyValue("ballcount", ball.ballcount or 1)
	spawner:SetKeyValue("balltype", ball.balltype or 1)
	spawner:SetKeyValue("maxballbounces", ball.maxballbounces or 15)
	spawner:SetKeyValue("launchconenoise", ball.maxballbounces or 0)

	spawner:Spawn()
	spawner:Activate()
	
	local count = ball.ballcount or 1
	for i=1,count do
		spawner:Fire("LaunchBall")
	end
	spawner:Fire("kill","",0)
end

local DisableEnts = {
	["npc_turret_floor"] = {"ambient/energy/power_off1.wav", "draconic.Spark_Medium"},
	["npc_turret_ceiling"] = {"ambient/energy/powerdown2.wav", "draconic.Spark_Medium"},
	["npc_turret_ground"] = {"ambient/energy/power_off1.wav", "draconic.Spark_Medium"},
	["npc_combine_camera"] = {"ambient/energy/powerdown2.wav", "draconic.Spark_Medium"},
	["gmod_lamp"] = {"ambient/energy/power_off1.wav", nil},
	["gmod_light"] = {"ambient/energy/power_off1.wav", nil},
	["prop_thumper"] = {"ambient/energy/powerdown2.wav", "draconic.Spark_Violent"},
	["hl2_thumper_large"] = {"ambient/energy/powerdown2.wav", "draconic.Spark_Violent"},
}

local RagdollEnts = {
	["npc_cscanner"] = {"ambient/energy/power_off1.wav", "draconic.Spark_Light"},
	["npc_manhack"] = {"ambient/energy/power_off1.wav", "draconic.Spark_Light"},
	["npc_clawscanner"] = {"ambient/energy/power_off1.wav", "draconic.Spark_Light"},
	["monster_sentry"] = {"turret/tu_die3.wav", "draconic.Spark_Light"},
	["monster_miniturret"] = {"turret/tu_die2.wav", "draconic.Spark_Light"},
}

local Inert = {
	["npc_rollermine"] = {"ambient/energy/powerdown2.wav", "draconic.Spark_Violent", "models/roller.mdl"},
	["combine_mine"] = {"npc/roller/code2.wav", "draconic.Spark_Light", "models/props_combine/combine_mine01.mdl"},
}

function DRC:EMP(src, tgt, thyme, sound, effect)
	if !IsValid(tgt) then return end
	if tgt.ResistsEMP == true then return end
	local function Effects()
		if sound != nil then DRC:EmitSound(src, Sound(sound)) end
	end
	
	if tgt:GetNWBool("DRC_Shielded") == true then
		DRC:PopShield(tgt)
	end
	
	tgt:SetNWBool("EMPed", true)
	
	if tgt.LFS == true or tgt.LVS == true then
		if tgt:GetEngineActive() == true then
			Effects()
			tgt:StopEngine()
			timer.Simple(thyme, function() if IsValid(tgt) then tgt:StartEngine() tgt:SetNWBool("EMPed", false) end end)
		end
	elseif tgt:GetClass() == "gmod_sent_vehicle_fphysics_base" then
		if tgt:GetActive() == true then
			Effects()
			tgt:StopEngine()
			tgt:SetActive( false )
			timer.Simple(thyme, function() if IsValid(tgt) then tgt:StartEngine() tgt:SetActive(true) tgt:SetNWBool("EMPed", false) end end)
		end
	elseif tgt.Draconic && tgt.IsVehicle == true then
		if tgt:EngineStatus() == 1 then
			Effects()
			timer.Simple(thyme, function() if IsValid(tgt) then tgt:SetNWBool("EMPed", false) end end)
		end
	elseif tgt:GetClass() == "prop_vehicle_jeep" or tgt:GetClass() == "prop_vehicle_airboat" then
		if tgt:IsEngineStarted() == true then
			Effects()
			tgt:StartEngine(false)
			timer.Simple(thyme, function() if IsValid(tgt) then tgt:StartEngine(true) tgt:SetNWBool("EMPed", false) end end)
		end
	end
	
	if DisableEnts[tgt:GetClass()] then
		local tbl = DisableEnts[tgt:GetClass()]
		tgt:Fire("Disable", nil, 0, src, src)
		if tbl[1] != nil then tgt:EmitSound(tbl[1]) end
		if tbl[2] != nil then
			for i=0,math.Rand(0, 17) do
				timer.Simple(i*0.3, function()
					if !IsValid(tgt) then return end
					tgt:EmitSound(tbl[2]) 
					local ed = EffectData()
					ed:SetOrigin(tgt:GetPos() + tgt:OBBCenter())
					util.Effect("cball_explode", ed)
				end)
			end
		end
	end
	
	if Inert[tgt:GetClass()] then
		local tbl = Inert[tgt:GetClass()]
		local rag = ents.Create("prop_physics")
		rag:SetModel(tbl[3])
		rag:SetPos(tgt:GetPos())
		rag:SetAngles(tgt:GetAngles())
		rag:Spawn()
		rag:SetVelocity(tgt:GetVelocity())
		tgt:Remove()
		if tbl[1] != nil then tgt:EmitSound(tbl[1]) end
		if tbl[2] != nil then
			for i=0,math.Rand(0, 17) do
				timer.Simple(i*0.3, function()
					if !IsValid(rag) then return end
					rag:EmitSound(tbl[2]) 
					local ed = EffectData()
					ed:SetOrigin(rag:GetPos() + rag:OBBCenter())
					util.Effect("cball_explode", ed)
				end)
			end
		end
	end
	
	if RagdollEnts[tgt:GetClass()] then
		local tbl = RagdollEnts[tgt:GetClass()]
		local rag = ents.Create("prop_ragdoll")
		rag:SetModel(tgt:GetModel())
		rag:SetPos(tgt:GetPos())
		rag:SetAngles(tgt:GetAngles())
		rag:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
		rag:Spawn()
		if tbl[1] != nil then tgt:EmitSound(tbl[1]) end
		if tbl[2] != nil then
			for i=0,math.Rand(0, 17) do
				timer.Simple(i*0.3, function()
					if !IsValid(rag) then return end
					rag:EmitSound(tbl[2]) 
					local ed = EffectData()
					ed:SetOrigin(rag:GetPos() + rag:OBBCenter())
					util.Effect("cball_explode", ed)
				end)
			end
		end
		tgt:Remove()
	end
end

function DRC:SetRoleplayPlayermodels(ply, tab)
	if !tab or tab == nil then tab = {} end
	net.Start("DRC_SetRPModels")
	net.WriteTable(tab)
	net.Send(ply)
end

function DRC:ClearRoleplayPlayermodels(ply)
	local tab = {}
	net.Start("DRC_SetRPModels")
	net.WriteTable(tab)
	net.Send(ply)
end

function DRC:SetSpecialModels(ply, tab)
	if !tab or tab == nil then tab = {} end
	net.Start("DRC_SetSpecialModels")
	net.WriteTable(tab)
	net.Send(ply)
end

net.Receive("DRC_ApplyPlayermodel", function(len, ply)
	local tbl = net.ReadTable()
	
	local ent = tbl.player
	if !IsValid(ent) or !IsValid(ply) then return end
	if ply != ent then
		DRC:CheaterWarning(ply, "This client attempted to call the 'DRC_ApplyPlayermodel' net message with a target other than their own player, this is normally completely impossible & only achievable through using an exploited client and/or injected scripts.")
	return end
	local skin = tbl.skin
	local bgs = tbl.bodygroups
	local colours = tbl.colours
	local model = tbl.model
	local vs = tbl.voiceset
	local fs = tbl.footsteps
	local hands = tbl.hands
	
	if !util.IsValidModel(model) then return end
	local pname = player_manager.TranslateToPlayerModelName(model)
	
	ent:SetModel(model)
	ent:SetSkin(skin)
	for k,v in pairs(bgs) do
		ent:SetBodygroup(k-1, v)
	end
	if ent:GetInfo("cl_playerhands") == "disabled" then ent:GetHands():SetModel(player_manager.TranslatePlayerHands(pname).model) end
	DRC:RefreshColours(ent)
	ent:SetNWString("DRCVoiceSet", vs)
	ent:SetNWString("DRCFootsteps", fs)
	ent:SetNWString("DRC_SpawnModel", model)
	
	net.Start("DRC_UpdatePlayermodel")
	net.WriteTable(tbl)
	net.Broadcast()
end)





-- ###Runtime
resource.AddFile ( 'materials/overlays/draconic_scope.png' )
util.AddNetworkString("DRCSound")
util.AddNetworkString("OtherPlayerWeaponSwitch")
util.AddNetworkString("DRCNetworkGesture")
util.AddNetworkString("DRCNetworkedAddText")
util.AddNetworkString("DRC_SyncSpray")
util.AddNetworkString("DRC_RequestSprayInfo")
util.AddNetworkString("DRC_Nuke") -- "Nuke Map" dev tool
util.AddNetworkString("DRC_KYS")
util.AddNetworkString("DRC_MapVersion")
util.AddNetworkString("DRC_MakeShieldEnt")
util.AddNetworkString("DRC_WeaponDropped")
util.AddNetworkString("DRC_ApplyPlayermodel")
util.AddNetworkString("DRC_UpdatePlayermodel")
util.AddNetworkString("DRCSWEP_ClientHitReport")
util.AddNetworkString("DRCVoiceSet_CL")
util.AddNetworkString("DRC_UpdatePlayerHands")
util.AddNetworkString("DRC_RequestLightColour")
util.AddNetworkString("DRC_ReceiveLightColour")
util.AddNetworkString("DRC_SetRPModels")
util.AddNetworkString("DRC_SetSpecialModels")
util.AddNetworkString("DRC_PlayerSquadHelp")
util.AddNetworkString("DRC_PlayerSquadMove")
util.AddNetworkString("DRC_NetworkScreenShake")
util.AddNetworkString("DRC_WeaponAttachSwitch")
util.AddNetworkString("DRC_WeaponAttachSwitch_Sync")
util.AddNetworkString("DRC_WeaponCamoSwitch")
util.AddNetworkString("DRC_WeaponCamoSwitch_Sync")
util.AddNetworkString("DRC_WeaponAttachClose")
util.AddNetworkString("DRC_WeaponAttachForceOpen")
util.AddNetworkString("DRC_WeaponAttachSyncInventory")
util.AddNetworkString("DRC_ReflectionModifier")
util.AddNetworkString("DRC_SyncServerVar")

hook.Add("EntityRemoved", "drc_KillShieldTimer", function(ent)
	if !ent.DRCShield_UID then return end
	
	if timer.Exists("DRCShield_".. ent.DRCShield_UID .."") then
		timer.Remove("DRCShield_".. ent.DRCShield_UID .."")
	end
end)

local function IsMeleeDamage(d)
	if d:GetDamageCustom() == 2221208 then return true else return false end
end

local fuckedupmodels = { 
	["models/combine_dropship.mdl"] = "NoMat",
}
hook.Add("EntityTakeDamage", "DRC_EntityTakeDamageHook", function(tgt, dmg)
	if !IsValid(tgt) then return end
	local inflictor = dmg:GetInflictor()
	local attacker = dmg:GetAttacker()
	local vehicle = false
	
	if !IsMeleeDamage(dmg) && inflictor.Draconic && DRC:IsCharacter(attacker) then
		dmg:ScaleDamage(attacker:GetNWInt("DRC_GunDamageMod", 1))
	elseif IsMeleeDamage(dmg) && inflictor.Draconic && DRC:IsCharacter(attacker) then
		dmg:SetDamage(inflictor.LastMeleeDamage)
		dmg:ScaleDamage(attacker:GetNWInt("DRC_MeleeDamageMod", 1))
	end
	
	if tgt:GetNWBool("DRC_Shielded") == true then
		if !tgt.DRCShield_UID then tgt.DRCShield_UID = "".. tgt:GetClass() .."_".. tostring(math.floor(math.Rand(0, 999999999))) .."_".. tgt:EntIndex() .."" end
		dmg:ScaleDamage(1)
		dmg:SetDamageBonus(0)
		dmg:SetDamageCustom(0)
		
		local hp, maxhp = DRC:GetShield(tgt)
		local missing = maxhp - hp
		local amount = tgt:GetNWInt("DRC_ShieldRechargeAmount")
		
		if DRC:IsCharacter(tgt) && !tgt:IsNextBot() then
			if hp > 0 then tgt:SetBloodColor(DONT_BLEED) else tgt:SetBloodColor(tgt.BloodEnum) end
		end
		if !timer.Exists("DRCShield_".. tgt.DRCShield_UID .."") then
			timer.Create("DRCShield_".. tgt.DRCShield_UID .."", 0.1, 0, function()
				local hp, maxhp = DRC:GetShield(tgt)
				if hp >= maxhp && tgt:GetNWBool("DRC_ShieldDown") == true then tgt:SetNWBool("DRC_ShieldDown", false) end
				if tgt:GetNWBool("DRC_ShieldDown") == false && CurTime() > tgt:GetNWInt("DRC_Shield_DamageTime") && tgt:GetNWInt("DRC_ShieldHealth") != tgt:GetNWInt("DRC_ShieldMaxHealth") && tgt:GetNWInt("DRC_Shield_Recharges") == true then
					DRC:AddShield(tgt, amount/10)
				end
			end)
		end
		
		local function getshieldhp() return tgt:GetNWInt("DRC_ShieldHealth") + tgt:GetNWInt("DRC_ShieldHealth_Extra") end
		local shieldhp = getshieldhp()
		if shieldhp - dmg:GetDamage() < 0 then
			dmg:SetDamage(math.abs(shieldhp - dmg:GetDamage()))
			DRC:ShieldEffects(tgt, dmg)
		end
		
		if tgt:GetNWBool("DRC_ShieldInvulnerable") != true then
			DRC:SubtractShield(tgt, dmg:GetDamage())
		else
			dmg:SetDamage(0)
			dmg:SetDamageBonus(0)
			dmg:ScaleDamage(0)
			dmg:SetDamageCustom(0)
		end
		
		shieldhp = getshieldhp()
		
		if shieldhp > 0 then 
			DRC:ShieldEffects(tgt, dmg)
			return true
		else
			DRC:PopShield(tgt)
			DRC:ShieldEffects(tgt, dmg)
		end
	end
	
	if DRC:IsVehicle(tgt) then vehicle = true end
	
	if inflictor.Draconic == nil then return end
	if inflictor.IsMelee == true then return end
	local mat = nil
	if fuckedupmodels[tgt:GetModel()] then
		mat = "MAT_DEFAULT"
	else
		mat = DRC:SurfacePropToEnum(tgt:GetBoneSurfaceProp(0))
	end
	
	local damagevalue = dmg:GetDamage()
	
	local BaseProfile = scripted_ents.GetStored("drc_abp_generic")
	local BT, DT, BaseBT, BaseDT, scalar = nil, nil, nil, nil, 0
	
	local hl2diff_inflict, hl2diff_take, skilllevel = 1, 1, GetConVarNumber("skill")
	if skilllevel == 1 then
		hl2diff_take = GetConVarNumber("sk_dmg_take_scale1")
		hl2diff_inflict = GetConVarNumber("sk_dmg_inflict_scale1")
	elseif skilllevel == 2 then
		hl2diff_take = GetConVarNumber("sk_dmg_take_scale2")
		hl2diff_inflict = GetConVarNumber("sk_dmg_inflict_scale2")
	elseif skilllevel == 3 then
		hl2diff_take = GetConVarNumber("sk_dmg_take_scale3")
		hl2diff_inflict = GetConVarNumber("sk_dmg_inflict_scale3")
	end
	
	if inflictor:IsWeapon() && !IsMeleeDamage(dmg) then
		BT = inflictor.ActiveAttachments.AmmunitionTypes.t.BulletTable
		DT = inflictor.ActiveAttachments.AmmunitionTypes.t.BulletTable.MaterialDamageMuls
		BaseBT = BaseProfile.t.BulletTable
		BaseDT = BaseBT.MaterialDamageMuls
		
		if DT == nil or DT[mat] == nil then
			if BaseDT[mat] == nil && mat != "MAT_" then
				print("You've found an undefined material type in the Draconic Base, pretty please report this to me so I can remove this annoying console message! The material is: ".. mat .."")
				mat = "MAT_DEFAULT"
				scalar = BaseDT[mat]
			elseif mat == "MAT_" then
				mat = "MAT_DEFAULT"
				scalar = BaseDT[mat]
			else
				scalar = BaseDT[mat]
			end
		else
			scalar = DT[mat]
		end
		
		if attacker:IsPlayer() && tgt:IsNPC() then
			damagevalue = (damagevalue * scalar) * inflictor:GetAttachmentValue("Ammunition", "PvEDamageMul")
		elseif attacker:IsPlayer() && tgt:IsPlayer() then
			damagevalue = (damagevalue * scalar) * inflictor:GetAttachmentValue("Ammunition", "PvPDamageMul")
		elseif attacker:IsNPC() && tgt:IsPlayer() then
			damagevalue = (damagevalue * scalar) * inflictor:GetAttachmentValue("Ammunition", "EvPDamageMul")
			if inflictor:IsWeapon() && inflictor.Draconic && inflictor:GetAttachmentValue("Ammunition", "NumShots") > 1 then
				local mul = inflictor:GetAttachmentValue("Ammunition", "NumShots") / 2
				damagevalue = damagevalue * mul
			end -- Shotguns require bonus damage from NPCs to be accurate, as default Half-Life 2 behaviour has NPCs dealing 2.6x damage than the player with the shotgun (3 player, 8 npc). I suspect this is because shotgun spread is too RNG for NPCs to properly engage with.
		elseif attacker:IsNPC() && tgt:IsNPC() then
			damagevalue = (damagevalue * scalar) * inflictor:GetAttachmentValue("Ammunition", "EvEDamageMul")
			if inflictor:IsWeapon() && inflictor.Draconic && inflictor:GetAttachmentValue("Ammunition", "NumShots") > 1 then
				local mul = inflictor:GetAttachmentValue("Ammunition", "NumShots") / 4
				damagevalue = damagevalue * mul
			end
		else
			damagevalue = (damagevalue * scalar)
		end
		
		if inflictor:GetAttachmentValue("Ammunition", "EvPUseHL2Scale") == true && (!attacker:IsPlayer() && tgt:IsPlayer()) then
			damagevalue = damagevalue * hl2diff_take
		end
		if inflictor:GetAttachmentValue("Ammunition", "PvEUseHL2Scale") == true && (attacker:IsPlayer() && (tgt:IsNPC() or tgt:IsNextBot())) then			
			damagevalue = damagevalue * hl2diff_inflict
		end
		
		if BT == nil then
			damagevalue = damagevalue
		else
			if BT.Damage == nil then
				damagevalue = damagevalue * BaseBT.Damage
			else
				damagevalue = damagevalue * BT.Damage
			end
		end
		
		if vehicle == true then damagevalue = damagevalue * inflictor:GetAttachmentValue("Ammunition", "VehicleDamageMul") end
		elseif (inflictor.BProfile == true or inflictor.OverrideBProfile != nil) && !IsMeleeDamage(dmg) then
		if !inflictor:GetCreator().ActiveAttachments then return end
		BT = inflictor:GetCreator().ActiveAttachments.AmmunitionTypes.t.BulletTable
		DT = inflictor:GetCreator().ActiveAttachments.AmmunitionTypes.t.BulletTable.MaterialDamageMuls
		BaseBT = BaseProfile.t.BulletTable
		BaseDT = BaseBT.MaterialDamageMuls
		
		if inflictor.OverrideBProfile != nil then
			BT = scripted_ents.GetStored(inflictor.OverrideBProfile).t.BulletTable
			DT = scripted_ents.GetStored(inflictor.OverrideBProfile).t.BulletTable.MaterialDamageMuls
		end
		
		if DT == nil or DT[mat] == nil then
			if BaseDT[mat] == nil && mat != "MAT_" then
				print("You've found an undefined material type in the Draconic Base, pretty please report this to me so I can remove this annoying console message! The material is: ".. mat .."")
				mat = "MAT_DEFAULT"
				scalar = BaseDT[mat]
			elseif mat == "MAT_" then
				mat = "MAT_DEFAULT"
				scalar = BaseDT[mat]
			else
				scalar = BaseDT[mat]
			end
		else
			scalar = DT[mat]
		end
		
		if attacker:IsPlayer() && tgt:IsNPC() then
			damagevalue = (damagevalue * scalar) * inflictor:GetCreatorAttachmentValue("Ammunition", "PvEDamageMul")
		elseif attacker:IsPlayer() && tgt:IsPlayer() then
			damagevalue = (damagevalue * scalar) * inflictor:GetCreatorAttachmentValue("Ammunition", "PvPDamageMul")
		elseif attacker:IsNPC() && tgt:IsPlayer() then
			damagevalue = (damagevalue * scalar) * inflictor:GetCreatorAttachmentValue("Ammunition", "EvPDamageMul")
		elseif attacker:IsNPC() && tgt:IsNPC() then
			damagevalue = (damagevalue * scalar) * inflictor:GetCreatorAttachmentValue("Ammunition", "EvEDamageMul")
		else
			damagevalue = (damagevalue * scalar)
		end
		
		if inflictor:GetCreatorAttachmentValue("Ammunition", "EvPUseHL2Scale") == true && (!attacker:IsPlayer() && tgt:IsPlayer()) then
			damagevalue = (damagevalue * 0.3) * hl2diff_take
		end
		
		if inflictor:GetCreatorAttachmentValue("Ammunition", "PvEUseHL2Scale") == true && (attacker:IsPlayer() && (tgt:IsNPC() or tgt:IsNextBot())) then
			damagevalue = damagevalue * hl2diff_inflict
		end
		
		if BT == nil then
			damagevalue = damagevalue
		else
			if BT.Damage == nil then
				damagevalue = damagevalue * BaseBT.Damage
			else
				damagevalue = damagevalue * BT.Damage
			end
		end
		
		if vehicle == true then damagevalue = damagevalue * inflictor:GetCreatorAttachmentValue("Ammunition" ,"VehicleDamageMul") end
	end
	
--	if DRC:IsCharacter(tgt) && tgt:Health() - damagevalue <= 0 then dmg:SetDamageForce(dmg:GetDamageForce() * 25) end
	dmg:SetDamage(damagevalue)
end)

local updateentstime = 0
local drcgroundents = {}

hook.Add("DoPlayerDeath", "VoiceSets_Death", function(vic, att, dmg)
	local velocity = vic:GetVelocity():Length()
	local damage = dmg:GetDamage()
	local enum = dmg:GetDamageType()
	local att = dmg:GetAttacker()
	local infl = dmg:GetInflictor()
	
	local maxhp = vic:GetMaxHealth()
	local halflife = maxhp/2
	local quarterlife = maxhp/5
	local microlife = maxhp/10
	
	if enum == DMG_FALL then
		if !DRC:IsVSentenceValid(DRC:GetVoiceSet(vic), "Pain", "Death_FallDamage") then
			DRC:SpeakSentence(vic, "Pain", "Death")
		else
			DRC:SpeakSentence(vic, "Pain", "Death_FallDamage")
		end
	return end
	
	if IsValid(infl) then
		local veh = DRC:IsVehicle(infl)
		if veh or att:GetClass() == "npc_antlionguard" or infl:GetClass() == "npc_antlionguard" then
			if !DRC:IsVSentenceValid(DRC:GetVoiceSet(vic), "Pain", "Death_Splatter") then
				DRC:SpeakSentence(vic, "Pain", "Death")
			else
				DRC:SpeakSentence(vic, "Pain", "Death_Splatter")
			end
		return end
	end
	
	if velocity > 650 && (att:IsWorld() or att == vic) then
		if !DRC:IsVSentenceValid(DRC:GetVoiceSet(vic), "Pain", "Death_Falling") then
			DRC:SpeakSentence(vic, "Pain", "Death")
		else
			DRC:SpeakSentence(vic, "Pain", "Death_Falling")
		end
	return end
	
	if damage < microlife then
		if !DRC:IsVSentenceValid(DRC:GetVoiceSet(vic), "Pain", "Death_Light") then
			DRC:SpeakSentence(vic, "Pain", "Death")
		else
			DRC:SpeakSentence(vic, "Pain", "Death_Light")
		end
	elseif damage > microlife && damage < quarterlife then
		if !DRC:IsVSentenceValid(DRC:GetVoiceSet(vic), "Pain", "Death_Medium") then
			DRC:SpeakSentence(vic, "Pain", "Death")
		else
			DRC:SpeakSentence(vic, "Pain", "Death_Medium")
		end
	elseif damage >= quarterlife then
		if !DRC:IsVSentenceValid(DRC:GetVoiceSet(vic), "Pain", "Death_Major") then
			DRC:SpeakSentence(vic, "Pain", "Death")
		else
			DRC:SpeakSentence(vic, "Pain", "Death_Major")
		end
	return end
	
	DRC:SpeakSentence(vic, "Pain", "Death")
end)

hook.Add("PlayerDeath", "Draconic_FunnyPlayerCorpses", function(ply, infl, att)
	if GetConVar("sv_drc_funnyplayercorpses"):GetInt() == 1 then
		DRC:CreateCorpse(ply, 30)
	end
end)

hook.Add("PlayerSpawn", "VoiceSets_Spawn", function(vic, trans)
	local vs = DRC:GetVoiceSet(vic)
	if vs == nil then return end
	DRC:SpeakSentence(vic, "Respawn")
end)


hook.Add("PostEntityTakeDamage", "VoiceSets_Damage", function(ent, dmg, took)	
	if took == true && DRC:GetVoiceSet(ent) != nil then
		DRC:DamageSentence(ent, dmg:GetDamage(), dmg)
	end
	
	if ent:IsPlayer() && dmg:GetDamageType() == DMG_BLAST then
		DRC:CallGesture(ent, GESTURE_SLOT_CUSTOM, ACT_GESTURE_FLINCH_BLAST, true)
	end
end)

hook.Add("PlayerStartTaunt", "VoiceSets_Taunts", function(ply, act, length)
	if act == ACT_GMOD_TAUNT_CHEER then DRC:SpeakSentence(ply, "Taunts", "Cheer") end
	if act == ACT_GMOD_TAUNT_LAUGH then DRC:SpeakSentence(ply, "Taunts", "Laugh") end
	if act == ACT_GMOD_TAUNT_SALUTE then DRC:SpeakSentence(ply, "Taunts", "Salute") end
	if act == ACT_GMOD_GESTURE_TAUNT_ZOMBIE then DRC:SpeakSentence(ply, "Taunts", "Zombie") end
	if act == ACT_GMOD_TAUNT_PERSISTENCE then DRC:SpeakSentence(ply, "Taunts", "Pers") end
	if act == ACT_GMOD_TAUNT_MUSCLE then DRC:SpeakSentence(ply, "Taunts", "Muscle") end
	if act == ACT_GMOD_TAUNT_DANCE then DRC:SpeakSentence(ply, "Taunts", "Dance") end
	if act == ACT_GMOD_TAUNT_ROBOT then DRC:SpeakSentence(ply, "Taunts", "Robot") end
end)

hook.Add("EntityEmitSound", "VoiceSets_Responses", function(tab)
	local sname = tab.SoundName
	sname = string.Replace(sname, "*", "") -- For when dialogue is called by a scripted sequence; they're prefixed with *
	if DRC.VoiceSetResponses[sname] then
		local class = tab.Entity:GetClass()
		local ent = tab.Entity
		
		local entcheck = ents.FindInSphere(ent:GetPos(), 500)
		for k,v in pairs(entcheck) do
			if DRC:IsCharacter(v) then
				local delay = SoundDuration(sname)
				DRC:ResponseSentence(v, class, sname, delay)
			end
		end
	end
end)

hook.Add("EntityTakeDamage", "VoiceSets_VehicleChecks", function(tgt, dmg)
	local att, infl = dmg:GetAttacker(), dmg:GetInflictor()
	if att:IsPlayer() then
		if DRC:IsVehicle(att) then att = att:GetDriver() end
		if att.GetVehicle && att:GetVehicle() == infl && tgt:Health() - dmg:GetDamage() <= 0 then
			if DRC:IsVSentenceValid(DRC:GetVoiceSet(att), "Reactions", "Splatter") then
				DRC:SpeakSentence(att, "Reactions", "Splatter")
			end
		end
	end
end)

local function VoiceSetVehicleLine(ply, veh, inout)
	if inout == true then 
		if DRC:IsVSentenceValid(DRC:GetVoiceSet(ply), "Actions", "Vehicle_Enter") then
			DRC:SpeakSentence(ply, "Actions", "Vehicle_Enter")
		end
	else
		if DRC:IsVSentenceValid(DRC:GetVoiceSet(ply), "Actions", "Vehicle_Exit") then
			DRC:SpeakSentence(ply, "Actions", "Vehicle_Exit")
		end
	end
end

hook.Add("PlayerEnteredVehicle", "VoiceSets_EnterVehicle", function(ply, vehicle, role)
	VoiceSetVehicleLine(ply, vehicle, true)
end)

hook.Add("PlayerLeaveVehicle", "VoiceSets_ExitVehicle", function(ply, vehicle, role)
	VoiceSetVehicleLine(ply, vehicle, false)
end)

hook.Add("PostEntityTakeDamage", "VoiceSets_PostKill", function(tgt, dmg, b)
	if DRC:IsCharacter(tgt) && DRC:IsCharacter(dmg:GetAttacker()) then
		local class = tgt:GetClass()
		local str = "kill_".. class ..""
		local hp = DRC:Health(tgt)
		if hp <= 0 then
			local att = dmg:GetAttacker()
			local vs = DRC:GetVoiceSet(dmg:GetAttacker())
			if !DRC:IsVSentenceValid(vs, "Reactions", str) then
				timer.Simple(math.Rand(0.5,1), function() DRC:SpeakSentence(att, "Reactions", "kill_postgeneric") end)
			else
				timer.Simple(math.Rand(0.5,1), function() DRC:SpeakSentence(att, "Reactions", str) end)
			end
			
			if class == "npc_barnacle" then
				local tr = util.TraceLine({
					start = tgt:GetPos(),
					endpos = tgt:GetPos() - Vector(0, 0, 2000),
					filter = function(ent) if ent == tgt then return false else return true end end
				})
				if DRC:IsCharacter(tr.Entity) then
					DRC:SpeakSentence(tr.Entity, "Reactions", "Puke", true)
					if tr.Entity:IsPlayer() then DRC:CallGesture(tr.Entity, GESTURE_SLOT_CUSTOM, ACT_GESTURE_BARNACLE_STRANGLE, true) end
				end
			end
		end
	end
end)

hook.Add("PlayerTick", "DRC_BarnacleGrabDetection", function(ply, cmd)
	local b = ply:GetNWBool("BarnacleHeld")
	if b != ply:IsEFlagSet(EFL_IS_BEING_LIFTED_BY_BARNACLE) then
		ply:SetNWBool("BarnacleHeld", ply:IsEFlagSet(EFL_IS_BEING_LIFTED_BY_BARNACLE))
	end -- This engine flag always returns false on client, so I make it usable for client players here.
end)

hook.Add("PlayerTick", "DRC_VoiceSetsBreathing", function(ply)
	if DRC:GetVoiceSet(ply) != nil && DRC.VoiceSets[DRC:GetVoiceSet(ply)].Breathing != nil then
		local ct = CurTime()
		if !ply.NextVSBreathTime then ply.NextVSBreathTime = 0 end
		if !ply.NextVSBreath then ply.NextVSBreath = 0 end -- 0 in 1 out
		if ct > ply.NextVSBreathTime then
			local n,s,e,w,cv,ju,sprinting = ply:KeyDown(IN_FORWARD), ply:KeyDown(IN_BACK), ply:KeyDown(IN_MOVERIGHT), ply:KeyDown(IN_MOVELEFT), ply:Crouching(), ply:KeyDown(IN_JUMP), ply:KeyDown(IN_SPEED)
			local swimming = ply:WaterLevel() == 3
			local settings = DRC.VoiceSets[DRC:GetVoiceSet(ply)].Breathing
			local moving = n or s or e or w
			
			local delay
			if !moving && !swimming && !sprinting && !cv then
				delay = settings.Delay_Idle or 1
				if ply.NextVSBreath == 0 && DRC:IsVSentenceValid(DRC:GetVoiceSet(ply), "Breathing", "In_Idle") then
					ply.NextVSBreathTime = ct + delay ply.NextVSBreath = 1 DRC:SpeakSentence(ply, "Breathing", "In_Idle")
				elseif ply.NextVSBreath == 1 && DRC:IsVSentenceValid(DRC:GetVoiceSet(ply), "Breathing", "Out_Idle") then
					ply.NextVSBreathTime = ct + delay ply.NextVSBreath = 0 DRC:SpeakSentence(ply, "Breathing", "Out_Idle")
				end
			elseif !moving && !swimming && !sprinting && cv then
				delay = settings.Delay_Crouch or delay
				if ply.NextVSBreath == 0 && DRC:IsVSentenceValid(DRC:GetVoiceSet(ply), "Breathing", "In_Crouch") then
					ply.NextVSBreathTime = ct + delay ply.NextVSBreath = 1 DRC:SpeakSentence(ply, "Breathing", "In_Crouch")
				elseif ply.NextVSBreath == 1 && DRC:IsVSentenceValid(DRC:GetVoiceSet(ply), "Breathing", "Out_Crouch") then
					ply.NextVSBreathTime = ct + delay ply.NextVSBreath = 0 DRC:SpeakSentence(ply, "Breathing", "Out_Crouch")
				end
			elseif moving && !swimming && !sprinting then
				delay = settings.Delay_Run or delay
				if ply.NextVSBreath == 0 && DRC:IsVSentenceValid(DRC:GetVoiceSet(ply), "Breathing", "In_Run") then
					ply.NextVSBreathTime = ct + delay ply.NextVSBreath = 1 DRC:SpeakSentence(ply, "Breathing", "In_Run")
				elseif ply.NextVSBreath == 1 && DRC:IsVSentenceValid(DRC:GetVoiceSet(ply), "Breathing", "Out_Run") then
					ply.NextVSBreathTime = ct + delay ply.NextVSBreath = 0 DRC:SpeakSentence(ply, "Breathing", "Out_Run")
				end
			elseif moving && !swimming && sprinting then
				delay = settings.Delay_Sprint or delay
				if ply.NextVSBreath == 0 && DRC:IsVSentenceValid(DRC:GetVoiceSet(ply), "Breathing", "In_Sprint") then
					ply.NextVSBreathTime = ct + delay ply.NextVSBreath = 1 DRC:SpeakSentence(ply, "Breathing", "In_Sprint")
				elseif ply.NextVSBreath == 1 && DRC:IsVSentenceValid(DRC:GetVoiceSet(ply), "Breathing", "Out_Sprint") then
					ply.NextVSBreathTime = ct + delay ply.NextVSBreath = 0 DRC:SpeakSentence(ply, "Breathing", "Out_Sprint")
				end
			end
		end
	end
end)

hook.Add("PlayerTick", "DRC_VoiceSetsIdling", function(ply)
	if DRC:GetVoiceSet(ply) != nil && DRC.VoiceSets[DRC:GetVoiceSet(ply)].Idle != nil then
		local ct = CurTime()
		if !ply.NextVSIdleTime then ply.NextVSIdleTime = 0 end
		if ct > ply.NextVSIdleTime then
			local swimming = ply:WaterLevel() == 3
			local settings = DRC.VoiceSets[DRC:GetVoiceSet(ply)].Idle
			local delay = math.random(settings.Delay_Min or 30, settings.Delay_Max or 120)
			if !swimming then
				local hp, mhp = DRC:Health(ply)
				local chp = hp/mhp
				if chp < (settings.InjureThreshold or 0.75) && settings.Injured != nil then
					if DRC:IsVSentenceValid(DRC:GetVoiceSet(ply), "Idle", "Generic") then
						DRC:SpeakSentence(ply, "Idle", "Injured", false, delay)
					end
				else
					if DRC:IsVSentenceValid(DRC:GetVoiceSet(ply), "Idle", "Generic") then
						DRC:SpeakSentence(ply, "Idle", "Generic", false, delay)
					end
				end
			else
				DRC:VoiceSetDelayIdle(ply, delay)
			end
		end
	end
end)

hook.Add("PlayerSwitchFlashlight", "drc_IntegratedLights", function(ply, b)
	if !IsValid(ply) then return end
	if IsValid(ply:GetActiveWeapon()) && ply:KeyDown(IN_USE) then
		local wpn = ply:GetActiveWeapon()
		if wpn.Draconic && wpn.IntegratedLight_Enabled == true then
			if wpn:GetActivity() == ACT_VM_IDLE or wpn:GetActivity() == ACT_WALK then
				wpn:ToggleIntegratedLight()
				return false
			else return false end
		end
	end
end)

net.Receive("DRCVoiceSet_CL", function(len, ply)
	local tbl = net.ReadTable()
	local value = tbl[2]
	local ent = tbl[1]
	
	if ply != ent then return end
	
	if tbl[3] then
		local ply, call, subcall = tbl[1], tbl[2], tbl[3]
		DRC:SpeakSentence(ply, call, subcall)
	end
	
	if value == "+use" then
		DRC:VoiceSpot(ent)
	else
		DRC:SpeakSentence(ent, tostring(DRC.VoiceSetDefs[value]), nil, false)
	end
end)

net.Receive("DRC_PlayerSquadHelp", function()
	local ply = net.ReadEntity()
	if GetConVar("sv_drc_voicesets_noanimations"):GetFloat() == 0 then DRC:CallGesture(ply, GESTURE_SLOT_CUSTOM, ACT_SIGNAL_GROUP, true) end
	for k,v in pairs(ents.GetAll()) do
		if v:IsNPC() then
			if v:GetSquad() == "player_squad" then
				v:MoveOrder(ply:GetPos())
				v:AlertSound()
			end
		end
	end
end)
net.Receive("DRC_PlayerSquadMove", function()
	local ply = net.ReadEntity()
	if GetConVar("sv_drc_voicesets_noanimations"):GetFloat() == 0 then DRC:CallGesture(ply, GESTURE_SLOT_CUSTOM, ACT_SIGNAL_FORWARD, true) end
	ply:ConCommand("impulse 50")
end)

function DRC:GetBestPlayerConnection()
	local players = player.GetAll()
	for k,v in pairs(players) do
		v:SetNWInt("Ping", v:Ping())
	end
	
	table.sort( players, function(a, b) return a:GetNWInt("Ping") < b:GetNWInt("Ping") end )
	return players[1], players[1]:GetNWInt("Ping")
end

DRC.EntLightingInfo = {}

net.Receive("DRC_ReceiveLightColour", function()
	local tbl = net.ReadTable()
	local ent, vec = tbl[1], tbl[2]
	DRC.EntLightingInfo[ent] = vec
end)

function DRC:RequestLightColour(ent)
	if ent:IsPlayer() then return Vector(ent:GetInfo("drc_lightcolour")) end
	local ply, ping = DRC:GetBestPlayerConnection()
	local tbl = {true, ent}
	net.Start("DRC_RequestLightColour")
	net.WriteEntity(ent)
	net.Send(ply)
	
	if DRC.EntLightingInfo[ent] then
		return DRC.EntLightingInfo[ent]
	else
		timer.Simple(ping/750, function()
			DRC:RequestLightColour(ent)
		end)
	end
end

local bandaid1 = {
	["drc_att_bprofile_generic"] = "drc_abp_generic",
	["drc_att_bprofile_buckshot"] = "drc_abp_buckshot",
	["drc_att_bprofile_explosive"] = "drc_abp_explosive",
}

function DRC:ForceAttachmentMenu(ply, wpn)
	if wpn:CanCustomize(true) == true then
		wpn:ToggleInspectMode(true)
		net.Start("DRC_WeaponAttachForceOpen")
		net.WriteEntity(ply)
		net.WriteEntity(wpn)
		net.Send(ply)
	end
end

net.Receive("DRC_WeaponAttachSwitch", function(l,ply)
	local wpn = net:ReadEntity()
	local lply = net:ReadEntity()
	local req = net:ReadString()
	local slot = net:ReadString()
	
	if ply != lply then
		DRC:CheaterWarning(ply, "This player's client attempted to change the weapon attachment of another player.")
	else
		if !table.HasValue(wpn.AttachmentTable[slot], req) then
			DRC:CheaterWarning(ply, "This player's client attempted to apply an attachment to their weapon which it is not allowed to use.")
		else
			local att = scripted_ents.GetStored(req)
			if slot == "AmmunitionTypes" then wpn:SetupAttachments(req, slot, true, false) else wpn:SetupAttachments(req, slot, false, false) end
			net.Start("DRC_WeaponAttachSwitch_Sync")
			net.WriteEntity(wpn)
			net.WriteString(req)
			net.WriteString(slot)
			net.Broadcast()
		end
	return end
end)

net.Receive("DRC_WeaponCamoSwitch", function(l,ply)
	local wpn = net:ReadEntity()
	local lply = net:ReadEntity()
	local mat = net:ReadString()
	local name = net:ReadString()
	
	if ply != lply then
		DRC:CheaterWarning(ply, "This player's client attempted to change the weapon camo of another player.")
	else
		wpn:SetCamo(mat)
		net.Start("DRC_WeaponCamoSwitch_Sync")
		net.WriteEntity(wpn)
		net.WriteString(mat)
		net.WriteString(name)
		net.Broadcast()
	return end
end)

net.Receive("DRC_WeaponAttachClose", function(l,ply)
	local wpn = net:ReadEntity()
	local lply = net:ReadEntity()
	
	if ply != lply then
		DRC:CheaterWarning(ply, "This player's client attempted to close the attachment menu of another player")
	else
		wpn:ToggleInspectMode()
	return end
end)



-- ###Debug
util.AddNetworkString("DRC_RenderTrace")
util.AddNetworkString("DRC_RenderSphere")

function DRC:RenderTrace(tr, colour, thyme)
	if !game.SinglePlayer() then return end
	
	local tbl = {tr, colour, thyme}
	net.Start("DRC_RenderTrace")
	net.WriteTable(tbl)
	net.Broadcast()
end

function DRC:RenderSphere(origin, radius, colour, thyme)
	if !game.SinglePlayer() then return end
	
	local tbl = {origin, radius, colour, thyme}
	net.Start("DRC_RenderSphere")
	net.WriteTable(tbl)
	net.Broadcast()
end