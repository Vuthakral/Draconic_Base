timer.Simple(5, function() -- gotta wait for everything else to load
DRC:RegisterPlayerExtension("zombie", "Extensions", "Claws", true)
DRC:RegisterPlayerExtension("zombiefast", "Extensions", "Claws", true)
DRC:RegisterPlayerExtension("zombine", "Extensions", "Claws", true)

-- Infinite Map Extensions
if InfMap then
	DRC.InfMap = {}

	function DRC.InfMap:Underwater(ent)
		if !IsValid(ent) then return end
		local pos = ent
		if !isvector(ent) then pos = ent:GetPos() end
		if ent:IsPlayer() then pos = ent:EyePos() end
		pos = InfMap.unlocalize_vector(pos, ent.CHUNK_OFFSET)
		if !IsValid(pos) then return end
		return pos.z < InfMap.water_height
	end
end


-- ARC9 Camo reading
if ARC9 then
	for k,v in pairs(ARC9.Attachments) do
		local tbl = v
		if tbl.MenuCategory == "ARC9 - Camos" then
			
			local name = tbl.ShortName
			if string.sub(name, -4) == ".vtf" then name = string.sub(tbl.ShortName, 0, #tbl.ShortName-4) end
			name = string.Replace(name, "_", " ")
			local icon = tbl.Icon or "arc9/arc9_logo.png"
			
			local tex = tbl.CustomCamoTexture
			if tex then
			if string.sub(tex, -4) == ".vtf" then tex = string.sub(tbl.CustomCamoTexture, 0, #tbl.CustomCamoTexture-4) end
			
			local Proxy = {
				["UniqueName"] = name,
				["$color2"] = Vector(1,1,1),
				["$detail"] = tex,
				["$detailscale"] = 4,
				["$detailblendfactor"] = 1,
				["$cmtint"] = Vector(1,1,1),
				["$cmtint_fb"] = Vector(1,1,1),
				["$cmpower"] = 1,
				["$cmpower_fb"] = 1,
			}
			
			DRC:RegisterWeaponSkin(name, tbl.Description, Proxy, icon, true, "ARC9")
			end
		end
	end
end

-- FETCH ME THEIR SOULS
-- pretty please don't get mad at me for this I just couldn't resist the joke since I already had the "sell your soul" convar for years.
if Rise then
	hook.Remove("CreateClientsideRagdoll", "SoulExitTicket")
	hook.Add("CreateClientsideRagdoll", "SoulExitTicket_Draconic", function(entity, ragdoll)
		local ragPosBackup = ragdoll:GetPos()
		if GetConVar("rip_soul_playersonly"):GetBool() then
			if not entity:IsPlayer() then return end
		end

		ragdoll:StopSound("rip_soul/valve.mp3") --prevents overlapping sounds per player
		ragdoll:StopSound("rip_soul/hell.mp3")
		if GetConVar("rip_soul_enabled"):GetBool() then
			local ghost = ClientsideRagdoll(ragdoll:GetModel())
			
			ghost:SetNoDraw( false )
			ghost:DrawShadow( false )
			ghost:SetMaterial("models/debug/debugwhite")
			ghost:SetColor(Color(255,255,255,0)) --makes the soul invisible to begin with
			ghost:SetRenderMode( RENDERMODE_TRANSCOLOR )
			
			--idk if this part is actualy neccessary but i kept it here just incase
			local phys = ghost:GetPhysicsObject()
			phys:SetPos(ragdoll:GetPos())
			phys:SetAngles(ragdoll:GetAngles())

			function ghost:IsValid()
			   return true
			end

			function entity:IsValid()
				return true
			end

			local bones = ghost:GetPhysicsObjectCount()
			for i=0, bones-1 do --everything in this loop is what actually moves the soul to the player.

				local gBone = ghost:GetPhysicsObjectNum(i)
				if IsValid( gBone ) then
					local pos, ang = ragdoll:GetBonePosition(ghost:TranslatePhysBoneToBone(i))
					gBone:SetPos(pos)
					gBone:SetAngles(ang)
					gBone:SetVelocity(Vector(0,0,0))
					gBone:EnableCollisions(false)
				end
			end

			timer.Simple(1, function() --change the time here if you want the players soul to leave earlier or later  
				if ragdoll ~= NULL then
					local bones = ghost:GetPhysicsObjectCount()
					for i=0, bones-1 do --everything in this loop is what actually moves the soul to the player.
			
						local gBone = ghost:GetPhysicsObjectNum( i )
			
						if IsValid( gBone ) then
							local pos, ang = ragdoll:GetBonePosition(ghost:TranslatePhysBoneToBone(i))
							gBone:SetPos(pos)
							gBone:SetAngles(ang)
							gBone:SetVelocity(Vector(0,0,0))
							gBone:EnableCollisions(false)
						end
					end
					
					if entity:IsPlayer() or entity:GetNWBool("HaveISinned") then
						ragdoll:EmitSound("rip_soul/hell.mp3", 75, 100, 1, CHAN_VOICE)--read below
					else
						ragdoll:EmitSound("rip_soul/valve.mp3", 75, 100, 1, CHAN_VOICE)--this is the sound that plays when you dies. 
					--if you want to change it, just replace 'valve.mp3' with the sound you want (make sure name it 'valve.mp3'),
					end
				else
					local sInfo = {}
					if entity:IsPlayer() or entity:GetNWBool("HaveISinned") then
						sInfo.sound = "rip_soul/hell.mp3"
					else
						sInfo.sound = "rip_soul/valve.mp3"
					end
					sInfo.name = "soulSound"
					sInfo.channel = CHAN_VOICE
					sInfo.level = 75
					sInfo.pitch = 100
					sound.Add(sInfo)
					sound.Play("soulSound", ragPosBackup)--same as above
				end

				timer.Simple(5, function() ghost:SetSaveValue("m_bFadingOut", true) end) --change the first number here to change how long the soul will exist for before dissapearing

				local ease = 0
				local start= phys:GetAngles()

				function ghost:Rise() --this makes the soul rise to the heavens when it leaves your body
					local phys = ghost:GetPhysicsObject()
					phys:EnableMotion(false)

					phys:SetPos(phys:GetPos()+ Vector(0,0,FrameTime()*40)) --change this last number to make it rise faster
	 
					if ease < 1 then 
						if ease > 1 then
							ease = 1
						end
						local fadeIn = Lerp(math.ease.OutSine(ease), 0, 100) --if you want the soul to be more transparent, change the last number
						ghost:SetColor(Color(255,255,255,fadeIn)) --if you want the soul to be a different colour, change these numbers

						--the 3 lines below make the soul always be belly up when its rising. if you dont want that just comment this out
						local nextAng = LerpAngle( math.ease.InOutSine(ease), start, Angle(0, start.y, 0) )
						ease = ease + (FrameTime()/1.5)
						phys:SetAngles(nextAng)
					end
				end

				function Fall(ghost) --this makes the soul rise to the heavens when it leaves your body
					local phys = ghost:GetPhysicsObject()
					phys:EnableMotion(false)
					local loopTime = 0
					timer.Create("raiseSoulForABit", 0, 0, function()
						loopTime = loopTime + FrameTime()
						if phys:IsValid() then
							phys:SetPos(phys:GetPos()+ Vector(0,0,FrameTime()*40)) --probably shouldnt change this one
						end

						if ease < 1 then 
							if ease > 1 then
								ease = 1
							end
							local fadeIn = Lerp(math.ease.OutSine(ease), 0, 100) --if you want the soul to be more transparent, change the last number
							ghost:SetColor(Color(255,255,255,fadeIn)) --if you want the soul to be a different colour, change these numbers

							--the 3 lines below make the soul always be belly up when its rising. if you dont want that just comment this out
							local nextAng = LerpAngle( math.ease.InOutSine(ease), start, Angle(0, start.y, 0) )
							ease = ease + (FrameTime()/1.5)
							phys:SetAngles(nextAng)
						end
						local waitStart = RealTime()
						if loopTime >= 3 or not phys:IsValid() then
							timer.Remove("raiseSoulForABit")
							loopTime = 0
							timer.Create("dragSoulToHell", 0, 0, function() 
								loopTime = loopTime + FrameTime()
								if phys:IsValid() then
									phys:SetPos(phys:GetPos()+ Vector(0,0,FrameTime()*(40-((loopTime*30)^2))))
								end
								local goRed = Lerp(loopTime, 255, 0)
								ghost:SetColor(Color(255,goRed,goRed,100))
								if loopTime >= 1.5 or not phys:IsValid() then
									timer.Remove("dragSoulToHell")
								end
							end)
						end
					end)
				end
				
				function ClaimSoul(ghost)
					local phys = ghost:GetPhysicsObject()
					phys:EnableMotion(false)
					local loopTime = 0
					timer.Create("raiseSoulForABit", 0, 0, function()
						loopTime = loopTime + FrameTime()
						if phys:IsValid() then
							phys:SetPos(phys:GetPos()+ Vector(0,0,FrameTime()*40))
						end

						if ease < 1 then 
							if ease > 1 then
								ease = 1
							end
							local fadeIn = Lerp(math.ease.OutSine(ease), 0, 100)
							ghost:SetColor(Color(255,255,255,fadeIn))

							local nextAng = LerpAngle( math.ease.InOutSine(ease), start, Angle(0, start.y, 0) )
							ease = ease + (FrameTime()/1.5)
							phys:SetAngles(nextAng)
						end
						local waitStart = RealTime()
						if loopTime >= 3 or not phys:IsValid() then
							timer.Remove("raiseSoulForABit")
							loopTime = 0
							timer.Simple(1, function() EmitSound("npc/ministrider/hunter_angry1.wav", LocalPlayer():GetPos(), LocalPlayer():EntIndex(), CHAN_AUTO, 1, 135, 0, 110, 29) end)
							timer.Simple(3, function() EmitSound("npc/ichthyosaur/water_growl5.wav", LocalPlayer():GetPos(), LocalPlayer():EntIndex(), CHAN_AUTO, 1, 135, 0, 70, 29) end)
							timer.Simple(3, function() EmitSound("npc/ichthyosaur/attack_growl1.wav", LocalPlayer():GetPos(), LocalPlayer():EntIndex(), CHAN_VOICE, 1, 135, 0, 70, 29) end)
							timer.Simple(2.5, function() EmitSound("npc/fast_zombie/claw_miss2.wav", LocalPlayer():GetPos(), LocalPlayer():EntIndex(), CHAN_AUTO, 1, 135, 0, 50, 29) end)
							timer.Create("dragSoulToHell", 0, 0, function()
								local obmin, obmax = ghost:OBBMins(), ghost:OBBMaxs()
								local ed = EffectData()
								ed:SetOrigin(ghost:GetPos())
								util.Effect("drc_shockwave", ed)
								loopTime = loopTime + FrameTime()
								local goRed = Lerp(loopTime, 255, 0)
								ghost:SetColor(Color(goRed,100,140,100))
								if loopTime >= 1.5 or not phys:IsValid() then
									timer.Remove("dragSoulToHell")
								end
							end)
						end
					end)
				end

				if entity:IsPlayer() then
					ClaimSoul(ghost)
				elseif entity:GetNWBool("HaveISinned") then
					Fall(ghost)
				else
					hook.Add("Think", ghost, ghost.Rise)
				end
			end)
		end
	end)
end

end)