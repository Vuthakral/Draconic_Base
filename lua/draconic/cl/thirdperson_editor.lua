local function GreyOut(element)
	element:SetEnabled(false)
	element.GreyOut = vgui.Create("DPanel", element)
	element.GreyOut:Dock(FILL)
	element.GreyOut:DockMargin(0, 0, 0, 0)
	element.GreyOut:SetBackgroundColor(Color(127,127,127,127))
end

if !DRC.ThirdPerson.EditorSettings then
	DRC.ThirdPerson.EditorSettings = {
		["Length"] = 100,
		["Height"] = 25,
		["UseBaseOffsets"] = true,
		["AllowFreeLook"] = true,
		["Offset"] = Vector(0, 0, 0),
		["LerpAngle"] = 0,
		["LerpPos"] = 0,
		["BaseFOV"] = 75,
		["FocalPoint"] = 0, -- 0 player view, 1 hitpos, 2 head angle
		["BasePoint"] = 0, -- 0 pelvis, 1 eyes, 2 origin
	}
end

local function CreateCheckbox(parent, pos, setting, label, tooltip)
	local cb = vgui.Create("DCheckBoxLabel", parent)
	
	cb:SetPos(pos.x, pos.y)
	cb:SetSize(300, 20)
	cb:SetText(label)
	cb:SetValue(setting)
	cb:SetToolTip(tooltip)
	function cb:OnChange(val)
		if val == true then DRC.ThirdPerson.EditorSettings[setting] = true else DRC.ThirdPerson.EditorSettings[setting] = false end
		
		if parent.SliderAxes != nil then
			for k,v in pairs(parent.SliderAxes) do
				if setting == "UseBaseOffsets" && val == false then v:SetEnabled(true) else v:SetEnabled(false) end
			end
		end
	end
	
	return cb
end

local function UpdateOffset(number, axis)
	local vector = DRC.ThirdPerson.EditorSettings.Offset
	
	if axis == "x" then DRC.ThirdPerson.EditorSettings.Offset = Vector(number, vector.y, vector.z)
	elseif axis == "y" then DRC.ThirdPerson.EditorSettings.Offset = Vector(vector.x, number, vector.z)
	elseif axis == "z" then DRC.ThirdPerson.EditorSettings.Offset = Vector(vector.x, vector.y, number)
	end
end

local function CreateSlider(parent, pos, axis, label, tooltip)
	local slider = vgui.Create("DNumSlider", parent)
	local text
	local maxi, mini = 100, -100
	local cur
	if axis == "x" then cur = DRC.ThirdPerson.EditorSettings.Offset.X
	elseif axis == "y" then cur = DRC.ThirdPerson.EditorSettings.Offset.Y
	elseif axis == "z" then cur = DRC.ThirdPerson.EditorSettings.Offset.Z
	elseif axis == "fov" then cur = DRC.ThirdPerson.EditorSettings.BaseFOV maxi = 120 mini = 20
	elseif axis == "LerpPos" then cur = DRC.ThirdPerson.EditorSettings.LerpPos maxi = 0.999 mini = 0
	elseif axis == "LerpAngle" then cur = DRC.ThirdPerson.EditorSettings.LerpAngle maxi = 0.999 mini = 0
	elseif axis == "Height" then cur = DRC.ThirdPerson.EditorSettings.Height maxi = 100 mini = -100
	elseif axis == "Length" then cur = DRC.ThirdPerson.EditorSettings.Length maxi = 200 mini = 0 end
	
	
	slider:SetPos(pos.x, pos.y)
	slider:SetSize(290, 50)
	slider:SetMax(maxi)
	slider:SetMin(mini)
	slider:SetDecimals(2)
	slider:SetValue(cur)
	slider:SetText(label)
	slider:SetToolTip(tooltip)
	slider.OnValueChanged = function(self, value)
		if axis == "x" then UpdateOffset(value, "x")
		elseif axis == "y" then UpdateOffset(-value, "y")
		elseif axis == "z" then UpdateOffset(value, "z")
		elseif axis == "fov" then DRC.ThirdPerson.EditorSettings.BaseFOV = value
		elseif axis == "LerpPos" then DRC.ThirdPerson.EditorSettings.LerpPos = value
		elseif axis == "LerpAngle" then DRC.ThirdPerson.EditorSettings.LerpAngle = value
		elseif axis == "Height" then DRC.ThirdPerson.EditorSettings.Height = value
		elseif axis == "Length" then DRC.ThirdPerson.EditorSettings.Length = value end
	end
	
	if axis == "x" or axis == "y" or axis == "z" then
		if !parent.SliderAxes then parent.SliderAxes = {} end
		local l2 = "Slider_".. axis
		parent["SliderAxes"][l2] = slider
	end
	
	return slider
end

local function CreateDropDown(parent, pos, setting, labels, tooltip)
	local dd = vgui.Create("DComboBox", parent)
	
	dd:SetPos(pos.x, pos.y)
	dd:SetSize(250, 20)
	dd:SetValue(labels[1])
	dd:SetToolTip(tooltip)
	for i=2,#labels do
		dd:AddChoice(labels[i])
	end
	dd.OnSelect = function(self, index, value)
		DRC.ThirdPerson.EditorSettings[setting] = index-1
	end
	
	return dd
end

local function CreateButton(parent, pos, size, text, onclick, tooltip)
	local b = vgui.Create("DButton", parent)
	
	b:SetPos(pos.x, pos.y)
	b:SetSize(size.x, size.y)
	b:SetText(text)
	b:SetToolTip(tooltip)
	b.DoClick = onclick
	
	return b
end

function DRC:OpenThirdpersonEditor(ply)
	DRC.CalcView.ThirdPerson.EditorOpen = true
	local width, height = ScrW(), ScrH()
	local s = DRC.ThirdPerson.EditorSettings
	
	local Derma = vgui.Create("DFrame")
	Derma:SetSize(300, 720)
	Derma:SetMinWidth(1200)
	Derma:SetMinHeight(720)
	Derma:SetSizable(false)
	Derma:SetTitle("Draconic Thirdperson Editor")
	Derma:SetIcon("icon16/draconic_base.png")
	Derma:MakePopup()
	Derma:SetDraggable(true)
	Derma:SetBackgroundBlur(false)
	Derma:SetScreenLock(false)
	Derma:ShowCloseButton(true)
	Derma:SetPos(width*0.2, height*0.33)
	Derma:SetVisible(true)
	Derma.Paint = function(self, w, h)
		draw.RoundedBoxEx(8, 0, 0, w, h, Color(0, 0, 0, 200), true, false, true, true)
	end
	
	Derma.btnClose.DoClick = function()
		DRC.CalcView.ThirdPerson.EditorOpen = false
		DRC.ThirdPerson.EditorMenu = nil
		Derma:Remove()
	end
	
	DRC.ThirdPerson.EditorMenu = Derma
	
	Derma.offsets = CreateCheckbox(Derma, Vector(15, 30), "UseBaseOffsets", "Use holdtype offsets", "When enabled, this prevents the offset settings from\nbeing used, as it uses Draconic's previously-default holdtype offset system.")
	Derma.freelook = CreateCheckbox(Derma, Vector(150, 30), "AllowFreeLook", "Enable idle freelook", "When enabled, after three seconds of no movement-related input, the camera\nenters a ''freelook'' state, where you can freely orbit your\ncamera around your player.\n\nThis also enables directional movement functionality on ''passive'' holdtypes.\nIf you are using the ''hit position'' camera focus it is recommended to turn this off.")
	
	Derma.cameraz = CreateSlider(Derma, Vector(15, 70), "Height", "Camera Height", "The height of the camera pole from the origin.")
	Derma.cameray = CreateSlider(Derma, Vector(15, 100), "Length", "Camera Distance", "The distance camera pole from the origin.")
	
	Derma.sliderx = CreateSlider(Derma, Vector(15, 160), "x", "Offset Forward/Back", "It's here if you need it, but you should really\nuse the camera distance for this one.")
	Derma.slidery = CreateSlider(Derma, Vector(15, 190), "y", "Offset Left/Right", "")
	Derma.sliderz = CreateSlider(Derma, Vector(15, 220), "z", "Offset Up/Down", "")
	
	Derma.sliderfov = CreateSlider(Derma, Vector(15, 250), "fov", "Base FOV", "NOT EXACT FOV. This is relative to your fov_desired, and should scale accordingly on its own.")
	
	Derma.sliderlerppos = CreateSlider(Derma, Vector(15, 280), "LerpPos", "Position interpolation", "(Recommended 0.1 minimum) The ''smoothing'' done to the camera's position.")
	Derma.sliderlerpang = CreateSlider(Derma, Vector(15, 310), "LerpAngle", "Angle interpolation", "The ''smoothing'' done to the camera's angles. High values recommended for hitpos focus.")
	
	Derma.ddorigin = CreateDropDown(Derma, Vector(25, 60), "BasePoint", {"Origin", "Pelvis", "Head", "Center"}, "The originating point for the camera.\n0: Pelvis\n1: Head\n2: Center (This is the center of your player's object space, and won't bob with animations.)")
	Derma.ddfocal = CreateDropDown(Derma, Vector(25, 140), "FocalPoint", {"Focus", "Player view", "Hit position", "Head angle (not implemented)"}, "The ''focal point'' of your camera.\n0: Player view (eye angles)\n1: Hit position\n2: Head Angle (not implemented yet)")
	
	CreateButton(Derma, Vector(25, 350), Vector(100, 20), "Reset to default", function()
		DRC:ThirdPersonResetToDefault()
	end, "Reset the editor to the default thirdperson settings.")
	
	CreateButton(Derma, Vector(125, 350), Vector(150, 20), "(Debug) Copy settings", function()
		SetClipboardText(util.TableToJSON(DRC.ThirdPerson.EditorSettings, true))
	end, "Copy the editor's settings to your clipboard.")
	
	CreateButton(Derma, Vector(25, 370), Vector(250, 20), "Save & apply NEW preset", function()
		DRC:SaveThirdPersonPrompt(true)
	end, "Saves a preset as a NEW FILE, or will overwrite an existing one if you enter a duplicate name.\nIf you want to directly overwrite a previous save, use the green button next to a preset's name.")
	
	local loader = vgui.Create("DPanel", Derma)
	loader:SetPos(0, 400)
	loader:SetSize(Derma:GetWide(), 320)
	loader.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	
	DRC:CreateThirdPersonPresetMenu(loader, true)
end