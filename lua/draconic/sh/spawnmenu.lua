function DRC:RegisterCategoryIcon(name, path, override)
	local cheek1 = assert(name, "No category name supplied.")
	local cheek2 = assert(path, "No category icon path supplied.")
	if !name or !path then return end
	if !override then override = true end
	
	local lst = "ContentCategoryIcons"
	if list.HasEntry(lst, name) && override == true then
		list.Set(lst, name, path)
	elseif !list.HasEntry(lst, name) then
		list.Set(lst, name, path)
	end
end

local ignorecats = {
	["Half-Life 2"] = true,
	["Half-Life: Source"] = true,
	["Other"] = true,
	["Fun + Games"] = true,
	["Editors"] = true,
	["Animals"] = true,
	["Combine"] = true,
	["Humans + Resistance"] = true,
	["Nextbot"] = true,
	["Portal"] = true,
	["Zombies + Enemy Aliens"] = true,
	["VJ Base"] = true,
	["Default"] = true,
	["Tools"] = true,
	["Entities"] = true,
	["LVS"] = true,
	["[LVS]"] = true,
	["LFS"] = true,
	["[LFS]"] = true,
	["TFA"] = true,
	["Modern Warfare"] = true,
}

local ignoresweps = {"drc_camera", "drc_cubemap"}

function DRC:AddCategoryIgnore(cat)
	ignorecats[cat] = true
end

hook.Add("PreRegisterSWEP", "DRC_SWEPPreRegister", function(swep, cl)
	if !string.find(cl, "drc_") then return end
	if ignoresweps[cl] then return end
	
	if swep.Category && !ignorecats[swep.Category] then DRC.Categories[swep.Category] = swep.Category end
	if DRC.Categories[swep.Category] then
		DRC:RegisterCategoryIcon(swep.Category, "icon16/draconic_base.png")
	end
	
	if swep.CanStore != false then
		if RE2_INV && swep.WorldModel && swep.WorldModel != "" then -- Support for "Resident Evil 2 Inventory" addon.
			RE2_INV.AddItem({
				["name"] = swep.PrintName,
				["classname"] = cl,
				["model"] = swep.WorldModel,
				["type"] = "weapon",
			}) 
		end
	end
	
	if swep.NPCSpawnable == false then return end
	
	if !swep.PrintName then swep.PrintName = cl end
	list.Add("NPCUsableWeapons", {class = cl, title = "[DRC] ".. swep.PrintName .."", category = Category})
end)

-- based on garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenttypes/weapons.lua
-- because I know someone is gonna wanna copy this, compare with that file to understand how this works.
-- lol just fucking kidding I can't get it to work properly and broke this trying to fix a minor issue
--[[
drcwpnslist = {}
hook.Add("PopulateWeapons", "DraconicSWEPSpawnmenuCustom", function(pnl, tree, node)
	timer.Simple(0, function() -- I blame garry
		for k,v in pairs(list.Get("Weapon")) do
			if weapons.IsBasedOn(v.ClassName, "draconic_base") && v.Spawnable == true then
				local subcat = weapons.GetStored(v.ClassName).Subcategory or "NONE111"
				if subcat != "NONE111" && (drcwpnslist[v.Category] == nil) then
					drcwpnslist[v.Category] = {}
					table.insert(drcwpnslist[v.Category], v)
				end
			end
		end
		
		for k,v in pairs(tree:Root():GetChildNodes()) do
			if (drcwpnslist[v:GetText()] != nil) then
				local cats = { ["Uncategorized"] = {} }
				
				for kay, vee in pairs(drcwpnslist[v:GetText()]) do
					local fuckme = weapons.Get(vee.ClassName)
					
					if (fuckme.Subcategory == nil) then table.insert(cats.Uncategorized, vee)
					else
						if cats[fuckme.Subcategory] == nil then cats[fuckme.Subcategory] = {} end
						table.insert(cats[fuckme.Subcategory], vee)
					end
				end
				
				v.DoPopulate = function(self)
				--	if (self.PropPanel) then return end
					
					self.PropPanel = vgui.Create("ContentContainer", pnl)
					self.PropPanel:SetVisible(false)
					self.PropPanel:SetTriggerSpawnlistChange(false)
					
					for catname,weps in SortedPairs(cats) do
						if (#weps <= 0) then continue end
						
						local cattext = vgui.Create("ContentHeader", container)
						cattext:SetText(catname)
						cattext:SetFont("DraconicSpawnMenuCategory")
						cattext:SetTextColor(Color(255, 255, 255))
						
						self.PropPanel:Add(cattext)
						
						for kay,vee in SortedPairsByMemberValue(weps, "PrintName") do
							local spawnicon = spawnmenu.CreateContentIcon(vee.ScriptedEntityType or "weapon", self.PropPanel, {
								nicename = vee.PrintName,
								spawnname = vee.ClassName,
								material = "entities/" .. vee.ClassName .. ".png",
								admin = vee.AdminOnly,
							})
						end -- holy
					end -- shit
				end -- look
			end -- at
		end -- this
	end) -- fucking
end) -- waterfall
]]