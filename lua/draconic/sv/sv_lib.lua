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

local Rollermine = {
	["npc_rollermine"] = {"ambient/energy/powerdown2.wav", "draconic.Spark_Violent", "models/roller.mdl"},
}

function DRC:EMP(src, tgt, thyme, sound, effect)
	if !IsValid(tgt) then return end
	if tgt.ResistsEMP == true then return end -- shut the fuck up already
	local function Effects()
		if sound != nil then DRC:EmitSound(src, Sound(sound)) end
	end
	
	if tgt:GetNWBool("DRC_Shielded") == true then
		DRC:PopShield(tgt)
	end
	
	if tgt.LFS == true then
		if tgt:GetEngineActive() == true then
			Effects()
			tgt:StopEngine()
			timer.Simple(thyme, function() tgt:StartEngine() end)
		end
	elseif tgt:GetClass() == "gmod_sent_vehicle_fphysics_base" then 
		if tgt:GetActive() == true then
			Effects()
			tgt:StopEngine()
			tgt:SetActive( false )
			timer.Simple(thyme, function() tgt:StartEngine() tgt:SetActive( true ) end)
		end
	elseif tgt:GetClass() == "prop_vehicle_jeep" or tgt:GetClass() == "prop_vehicle_airboat" then
		if tgt:IsEngineStarted() == true then
			Effects()
			tgt:StartEngine(false)
			timer.Simple(thyme, function() tgt:StartEngine(true) end)
		end
	end
	
	if !IsValid(tgt) then return end
	
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
	
	if Rollermine[tgt:GetClass()] then
		local tbl = Rollermine[tgt:GetClass()]
		local rag = ents.Create("prop_physics")
		rag:SetModel("models/roller.mdl")
		rag:SetPos(tgt:GetPos())
		rag:SetAngles(tgt:GetAngles())
	--	rag:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
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

net.Receive("DRC_ApplyPlayermodel", function()
	local tbl = net.ReadTable()
	
	local ent = tbl.player
	local skin = tbl.skin
	local bgs = tbl.bodygroups
	local colours = tbl.colours
	local model = tbl.model
	local vs = tbl.voiceset
	local hands = tbl.hands
	
	if !util.IsValidModel(model) then return end
	local pname = player_manager.TranslateToPlayerModelName(model)
	
	
	ent:SetModel(model)
	ent:SetSkin(skin)
	ent:SetBodyGroups(bgs)
	ent:GetHands():SetModel(player_manager.TranslatePlayerHands(pname).model)
	DRC:RefreshColours(ent)
	ent:SetNWString("DRCVoiceSet", vs)
	
	net.Start("DRC_UpdatePlayermodel")
	net.WriteTable(tbl)
	net.Broadcast()
end)