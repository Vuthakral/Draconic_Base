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
}

local function IconCheck()
end

hook.Add("PreRegisterSWEP", "DRC_SWEPPreRegister", function(swep, cl)
	if !string.find(cl, "drc_") then return end
	local ignore = {"drc_camera", "drc_cubemap" }
	if ignore[cl] then return end
	
	if swep.Category && !ignorecats[swep.Category] then DRC.Categories[swep.Category] = swep.Category end
	if DRC.Categories[swep.Category] then
		DRC:RegisterCategoryIcon(swep.Category, "icon16/draconic_base.png")
	end
	
--	if KMA then
--		local data = {
--			["PrintName"] = swep.PrintName,
--			["Primary.Damage"] = swep.Primary.Damage,
--		}
--		KMA.WeaponSpawner:AddTemplate(data, cl)
--	end
	
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