DRC.Accessibility = {}
DRC.Accessibility.ColorBlindness = {
	["None"] = Vector(1, 1, 1),
	["Protanopia"] = Vector(0.56667, 0.4467, 0.75883),
	["Protanomaly"] = Vector(0.81667, 0.66667, 0.875),
	["Deuteranopia"] = Vector(0.625, 0.3, 0.7),
	["Deuteranomaly"] = Vector(0.8, 0.25833, 0.85833),
	["Tritanopia"] = Vector(0.95, 0.43333, 0.525),
	["Tritanomaly"] = Vector(0.96667, 0.73333, 0.81667),
	["Achromatopsia"] = Vector(0.299, 0.587, 0.114),
	["Achromatomaly"] = Vector(0.618, 0.775, 0.516)
} -- https://web.archive.org/web/20081014161121/http://www.colorjack.com/labs/colormatrix/
DRC.Accessibility.ColorBlindness_Mul = 0

hook.Add("DrawOverlay", "DRC_ColourBlindness", function()
	local con = GetConVar("cl_drc_accessibility_colourblind"):GetString()
	if con == "None" then return end
	local con2 = GetConVar("cl_drc_accessibility_colourblind_strength"):GetFloat()
	if !DRC.Accessibility.ColorBlindness[con] then
		RunConsoleCommand("cl_drc_accessibility_colourblind", "None")
		con = GetConVar("cl_drc_accessibility_colourblind"):GetString()
	end
	
	if con == "None" then
		DRC.Accessibility.ColorBlindness_Mul = 0
	else
		DRC.Accessibility.ColorBlindness_Mul = con2/100
	end
	
	local vec = DRC.Accessibility.ColorBlindness[con]
	vec = vec * DRC.Accessibility.ColorBlindness_Mul
	local r, g, b = 1 - vec.r, 1 - vec.g, 1 - vec.b
	local ar = -vec.r * (DRC.Accessibility.ColorBlindness_Mul * 0.1)
	local ag = -vec.g * (DRC.Accessibility.ColorBlindness_Mul * 0.1)
	local ab = -vec.b * (DRC.Accessibility.ColorBlindness_Mul * 0.1)
	local v1 = Vector(r,g,b) * (con2/100) * DRC.Accessibility.ColorBlindness_Mul
	local v2 = Vector(ar,ag,ab) * (con2/100)
	
	local cc = {
		["$pp_colour_addr"] = v2.x,
		["$pp_colour_addg"] = v2.y,
		["$pp_colour_addb"] = v2.z,
		["$pp_colour_brightness"] = 0,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 1,
		["$pp_colour_mulr"] = v1.x,
		["$pp_colour_mulg"] = v1.y,
		["$pp_colour_mulb"] = v1.z
	}
	
	DrawColorModify(cc)
end)