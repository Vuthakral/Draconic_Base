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

function DRC:EMP(src, tgt, thyme, sound, effect)
	if !IsValid(tgt) then return end
	
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
end

net.Receive("DRC_ApplyPlayermodel", function()
	local tbl = net.ReadTable()
	
	local ent = tbl.player
	local skin = tbl.skin
	local bgs = tbl.bodygroups
	local colours = tbl.colours
	local model = tbl.model
	
	if !util.IsValidModel(model) then return end
	local pname = player_manager.TranslateToPlayerModelName(model)
	
	
	ent:SetModel(model)
	ent:SetSkin(skin)
	ent:SetBodyGroups(bgs)
	ent:GetHands():SetModel(player_manager.TranslatePlayerHands(pname).model)
	DRC:RefreshColours(ent)
	
	net.Start("DRC_UpdatePlayermodel")
	net.WriteTable(tbl)
	net.Broadcast()
end)