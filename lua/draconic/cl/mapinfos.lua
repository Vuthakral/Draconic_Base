drc_badlightmaps = { 
	["gm_blackmesa_sigma"] = 0.1,
	["gm_bigcity_improved"] = 0.25,
	["gm_bigcity_improved_lite"] = 0.25,
	["gm_emp_chain"] = 0.15,
}
-- The only maps that get added to this list are old maps which will not see an update/fix from their authors.
-- This is not meant as a mark of shame, it is used in the Draconic menu to inform developers
-- the map they are using has incorrectly compiled lighting, and as a result their 
-- content made using the Draconic base's material proxies might be scuffed.
-- Values at the end are "post fixes" which scale cubemaps up/down to 

drc_singlecubemaps = {
	["mu_volcano"] = 0.25,
	["gm_cultist_outpost"] = 0.25,
	["gm_reactionsew"] = 0.1,
}
-- Maps with no cubemaps baked into them, falling back on the engine default.

drc_fullbrightcubemaps = {
}
-- Alright, THIS is a mark of shame. Whoever told you to turn on fullbright when compiling cubemaps is an idiot.

drc_verifiedlightmaps = {
	"gm_construct",
	"gm_flatgrass",
	"gm_bigcity",
	"gm_emp_streetsoffire",
	"gm_vault",
}
-- Impressive. Very nice.

drc_authorpassedlightmaps = {}

DRC.BadLightmapList = {}
table.Merge(DRC.BadLightmapList, drc_badlightmaps)
table.Merge(DRC.BadLightmapList, drc_singlecubemaps)

DRC.MapInfo.LMCorrection = DRC.BadLightmapList[DRC.MapInfo.Name]
if DRC.MapInfo.LMCorrection == nil then DRC.MapInfo.LMCorrection = 1 end
DRC.MapInfo.MapAmbient = render.GetAmbientLightColor()
DRC.MapInfo.MapAmbientAvg = (DRC.MapInfo.MapAmbient.x + DRC.MapInfo.MapAmbient.y + DRC.MapInfo.MapAmbient.z) / 3

hook.Add("InitPostEntity", "DRC_LightmapCheck", function()
	DRC.MapInfo.LMCorrection = DRC.BadLightmapList[DRC.MapInfo.Name]
	if DRC.MapInfo.LMCorrection == nil then DRC.MapInfo.LMCorrection = 1 end
	DRC.MapInfo.MapAmbient = render.GetAmbientLightColor()
	DRC.MapInfo.MapAmbientAvg = (DRC.MapInfo.MapAmbient.x + DRC.MapInfo.MapAmbient.y + DRC.MapInfo.MapAmbient.z) / 3
end)