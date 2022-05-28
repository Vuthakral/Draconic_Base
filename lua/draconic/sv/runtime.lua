resource.AddFile ( 'materials/overlays/draconic_scope.vmt' )
util.AddNetworkString("DRCSound")
util.AddNetworkString("OtherPlayerWeaponSwitch")
util.AddNetworkString("DRCPlayerMelee")
util.AddNetworkString("DRCNetworkGesture")
util.AddNetworkString("DRCNetworkedAddText")
util.AddNetworkString("DRC_SyncSpray")
util.AddNetworkString("DRC_RequestSprayInfo")
util.AddNetworkString("DRC_Nuke") -- "Nuke Map" dev tool
util.AddNetworkString("DRC_MapVersion")
util.AddNetworkString("DRC_MakeShieldEnt")
util.AddNetworkString("DRC_WeaponDropped")
util.AddNetworkString("DRC_ApplyPlayermodel")
util.AddNetworkString("DRC_UpdatePlayermodel")
util.AddNetworkString("DRCSWEP_ClientHitReport")

hook.Add("EntityRemoved", "drc_KillShieldTimer", function(ent)
	if !ent.DRCShield_UID then return end
	
	if timer.Exists("DRCShield_".. ent.DRCShield_UID .."") then
		timer.Remove("DRCShield_".. ent.DRCShield_UID .."")
	end
end)

local fuckedupmodels = { "models/combine_dropship.mdl" }
hook.Add("EntityTakeDamage", "drc_materialdamagescale", function(tgt, dmg)
	if !IsValid(tgt) then return end
	local inflictor = dmg:GetInflictor()
	local attacker = dmg:GetAttacker()
	local vehicle = false
	
	if tgt:GetNWBool("DRC_Shielded") == true then
		if !tgt.DRCShield_UID then tgt.DRCShield_UID = "".. tgt:GetClass() .."_".. tostring(math.Rand(0, math.huge)) .."" end
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
				if tgt:GetNWBool("DRC_ShieldDown") == false && CurTime() > tgt:GetNWInt("DRC_Shield_DamageTime") && tgt:GetNWInt("DRC_ShieldHealth") != tgt:GetNWInt("DRC_ShieldMaxHealth") then
					DRC:AddShield(tgt, amount/10)
				end
			end)
		end
		
		DRC:SubtractShield(tgt, dmg:GetDamage())
		
		local shieldhp = tgt:GetNWInt("DRC_ShieldHealth")
		if shieldhp - dmg:GetDamage() < 0 then
			dmg:SetDamage(math.abs(shieldhp - dmg:GetDamage()))
			DRC:ShieldEffects(tgt, dmg)
		elseif shieldhp > 0 then
			DRC:ShieldEffects(tgt, dmg)
			return true
		end
	return end
	
	if DRC:IsVehicle(tgt) then vehicle = true end
	
	if inflictor.Draconic == nil then return end
	if inflictor.IsMelee == true then return end
	local mat = nil
	if CTFK(fuckedupmodels, tgt:GetModel()) then
		mat = "MAT_DEFAULT"
	else
		mat = DRC:SurfacePropToEnum(tgt:GetBoneSurfaceProp(0))
	end
	
	local damagevalue = dmg:GetDamage()
	
	local BaseProfile = scripted_ents.GetStored("drc_att_bprofile_generic")
	local BT, DT, BaseBT, BaseDT, scalar = nil, nil, nil, nil, 0
	
	local hl2diff_inflict, hl2diff_take = 1, 1
	if GetConVarNumber("skill") == 1 then
		hl2diff_take = GetConVarNumber("sk_dmg_take_scale1")
		hl2diff_inflict = GetConVarNumber("sk_dmg_inflict_scale1")
	elseif GetConVarNumber("skill") == 2 then
		hl2diff_take = GetConVarNumber("sk_dmg_take_scale2")
		hl2diff_inflict = GetConVarNumber("sk_dmg_inflict_scale2")
	elseif GetConVarNumber("skill") == 3 then
		hl2diff_take = GetConVarNumber("sk_dmg_take_scale3")
		hl2diff_inflict = GetConVarNumber("sk_dmg_inflict_scale3")
	end
	
	if inflictor:IsWeapon() then
		BT = inflictor.ActiveAttachments.Ammunition.t.BulletTable
		DT = inflictor.ActiveAttachments.Ammunition.t.BulletTable.MaterialDamageMuls
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
		elseif attacker:IsNPC() && tgt:IsNPC() then
			damagevalue = (damagevalue * scalar) * inflictor:GetAttachmentValue("Ammunition", "EvEDamageMul")
		else
			damagevalue = (damagevalue * scalar)
		end
		
		if inflictor:GetAttachmentValue("Ammunition", "EvPUseHL2Scale") == true && (!attacker:IsPlayer() && tgt:IsPlayer()) then
			damagevalue = (damagevalue * 0.3) * hl2diff_take
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
	elseif inflictor.BProfile == true then
		if !inflictor:GetCreator().ActiveAttachments then return end
		BT = inflictor:GetCreator().ActiveAttachments.Ammunition.t.BulletTable
		DT = inflictor:GetCreator().ActiveAttachments.Ammunition.t.BulletTable.MaterialDamageMuls
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
	
	if DRC:IsCharacter(tgt) && tgt:Health() - damagevalue <= 0 then dmg:SetDamageForce(dmg:GetDamageForce() * 25) end
	dmg:SetDamage(damagevalue)
end)

local updateentstime = 0
local drcgroundents = {}
hook.Add("PhysicsCollide", "DRC_WeaponGroundImpact", function(data, coll)
--	print(coll)
end)