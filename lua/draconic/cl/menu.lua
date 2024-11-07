local cmap = game.GetMap()

local function GreyOut(element)
	element:SetEnabled(false)
	element.GreyOut = vgui.Create("DPanel", element)
	element.GreyOut:Dock(FILL)
	element.GreyOut:DockMargin(0, 0, 0, 0)
	element.GreyOut:SetBackgroundColor(Color(127,127,127,127))
end

local ind = {
	[1]=32,
	[2]=48,
	[3]=64,
	[4]=72,
	[5]=94,
	[6]=128,
}
function DRCMenu( player )
	local ply = player
	local VSelection = ply:GetNWString("DRCVoiceSet")
	local FSelection = ply:GetNWString("DRCFootsteps")
	local Customization, TweakMode = true, 0
	Customization, TweakMode = DRC:GetCustomizationAllowed()
	
	local usekey = string.upper(ReturnKey("+use"))
	local m1key = string.upper(ReturnKey("+attack"))
	local m2key = string.upper(ReturnKey("+attack2"))
	local sprintkey = string.upper(ReturnKey("+speed"))
	local reloadkey = string.upper(ReturnKey("+reload"))
	local forwkey = string.upper(ReturnKey("+forward"))
	
	local TextCol = Color(220, 220, 220, 255)
	local SubtextCol = Color(170, 170, 170, 255)
	local NotifyCol = Color(255, 255, 255, 255)
	
	local function UpdateDraconicColours()		
		DRC:RefreshColours(LocalPlayer())
	end
	
	local function MakeHint(element, posx, posy, hint)
		local hintbox = vgui.Create("DButton", element)
		hintbox:SetText("?")
		hintbox:SetPos(posx, posy)
		hintbox:SetSize(16, 16)
		hintbox:SetTextColor(color_white)
		hintbox:SetContentAlignment(5)
		hintbox:SetTooltip(hint)
		function hintbox.Paint(w, h)
			draw.RoundedBox(5, 0, 0, 16, 16, Color(157,161,165))
		end
	end
	
	local Derma = vgui.Create("DFrame")
	Derma:SetSize(1200, 720)
	Derma:SetMinWidth(1200)
	Derma:SetMinHeight(720)
	Derma:SetSizable(false)
	Derma:SetTitle("Draconic Menu")
	Derma:SetIcon("icon16/draconic_base.png")
	Derma:MakePopup()
	Derma:SetDraggable(true)
	Derma:SetBackgroundBlur(true)
	Derma:SetScreenLock(false)
	Derma:ShowCloseButton(true)
	Derma:Center()
	Derma:SetVisible(true)
	Derma.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))
	end
	
	local windowwide = Derma:GetWide()
	local windowtall = Derma:GetTall()
	local windowwidehalf = windowwide * 0.5
	
	local function RefreshIcons(isfullscreen, exactoverride)
		local size = GetConVar("cl_drc_menu_iconsize"):GetInt()
		if isfullscreen then size = GetConVar("cl_drc_menu_iconsize_fullscreen"):GetInt() end
		if exactoverride then size = exactoverride end
		
		for k,v in pairs(Derma.PlayerModels:GetItems()) do
			v:SetSize(ind[size],ind[size])
		end
		for k,v in pairs(Derma.PlayerModels_Hands:GetItems()) do
			v:SetSize(ind[size],ind[size])
		end
		Derma.PlayerModels:InvalidateLayout()
		Derma.PlayerModels_Hands:InvalidateLayout()
	end
	
	timer.Simple(0.1, function()
		RefreshIcons()
	end)
	
	local maximized = false
	Derma.btnMaxim:SetEnabled( true )
	Derma.btnMaxim.DoClick = function()
		if maximized == false then
			Derma:SetSize(ScrW(), ScrH())
			Derma:Center()
			Derma:SetDraggable(false)
			maximized = true
			
			Derma.PlayerFrame1:SetWide(ScrW()*0.5)
			Derma.PlayerApplyButton:SetPos(Derma.PlayerFrame1:GetWide()*0.5 - 64,10)
			local spraymax = math.Clamp(windowwidehalf, windowwidehalf, 1024)
			Derma.SprayPreview:SetSize(spraymax, spraymax)
			Derma.SprayPreview:Dock(NODOCK)
			
			RefreshIcons(true)
		elseif maximized == true then
			Derma:SetSize(1200,720)
			Derma:Center()
			Derma:SetDraggable(true)
			maximized = false
			
			Derma.PlayerFrame1:SetWide(windowwide*0.5)
			Derma.PlayerApplyButton:SetPos(230,10)
			Derma.SprayPreview:SetSize(320, 320)
			Derma.SprayPreview:Dock(FILL)
			
			RefreshIcons(false)
		end
	end
	
	Derma.mainframe = vgui.Create("DPanel", Derma)
	local mainframe = Derma.mainframe
	mainframe:Dock(FILL)
	mainframe:DockMargin(0, 0, 0, 0)
	mainframe:DockPadding(0, 0, 0, 0)
	mainframe:SetPaintBackground(false)
	
	Derma.maintabs = vgui.Create( "DPropertySheet", mainframe )
	local maintabs = Derma.maintabs
	maintabs:Dock(FILL)
	maintabs:DockMargin(0, 0, 0, 0)
	maintabs:DockPadding(0, 0, 0, 0)
	maintabs:SetPadding(0)
	maintabs.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	
	mainframe.maintabs = vgui.Create( "DPanel", maintabs )
	local mt1 = mainframe.maintabs
	mt1:DockMargin(0, 0, 0, 0)
	mt1:DockPadding(0, 0, 0, 0)
	mt1:SetBackgroundColor(Color(255, 255, 255, 0))
	maintabs:AddSheet( "Player Representation", mt1, "icon16/user.png")
	
	Derma.PlayerFrame1 = vgui.Create("DPanel", mt1)
	local frame = Derma.PlayerFrame1
	frame:SetWide(windowwide*0.5)
	frame:Dock(LEFT)
	frame:DockPadding(0, 0, 0, 0)
--	frame:SetSize(512, topwide/1.5-24)
	frame:SetBackgroundColor(Color(255, 255, 255, 5))
	
	Derma.PlayerFrame2 = vgui.Create("DPanel", mt1)
	local frame2 = Derma.PlayerFrame2
	frame2:SetPos(windowwide*0.5, 0)
	frame2:SetWide(windowwide*0.5)
	frame2:Dock(FILL)
	frame2:DockPadding(0, 0, 0, 0)
--	frame2:SetSize(leftwide*1.25/2, topwide/1.5-54)
	frame2:SetBackgroundColor(Color(255, 255, 255, 15))
	
	local MapAmbient = render.GetAmbientLightColor() * 255
	MapAmbient.r = math.Clamp(MapAmbient.r, 35, 255)
	MapAmbient.g = math.Clamp(MapAmbient.g, 35, 255)
	MapAmbient.b = math.Clamp(MapAmbient.b, 35, 255)
	local LocalAmbient = render.GetLightColor(LocalPlayer():EyePos()) * 255
	local PreviewAmbient = Color((MapAmbient.r + LocalAmbient.r), (MapAmbient.g + LocalAmbient.g), (MapAmbient.b + LocalAmbient.b), 255)
	
	Derma.PlayerBG = vgui.Create("DImage", frame)
	local bg = Derma.PlayerBG
	bg:SetPos(0, 0)
	bg:Dock(FILL)
	bg:SetSize(589, 658)
--	bg:SetImage("vgui/drc_playerbg")
	bg:SetZPos(-10)
	
	Derma.PlayerLoading = vgui.Create("DImage", frame)
	local bgloading = Derma.PlayerLoading
	bgloading:SetPos(0, 0)
	bgloading:Dock(FILL)
	bgloading:SetSize(589, 658)
	bgloading:SetImage("vgui/drc_playerbg_loading1")
	bgloading:SetZPos(-10)
	bgloading:SetVisible(false)
	
	frame.tools = vgui.Create("DPanel", frame)
	Derma.PlayerTools = frame.tools
	frame.tools:SetSize(590,666)
	frame.tools:Dock(FILL)
	frame.tools:SetVisible(false)
	frame.tools:SetEnabled(true)
	frame.tools:SetBackgroundColor(Color(0,0,0,0))
	
	--local pmodel = LocalPlayer():GetInfo( "cl_playermodel" )
	--local pmodelname = player_manager.TranslatePlayerModel( pmodel )
	local pmodelname = LocalPlayer():GetModel()
	
	if Customization != true then pmodelname = LocalPlayer():GetModel() end
	
	MapAmbient.r = math.Clamp(MapAmbient.r, 127, 255)
	MapAmbient.g = math.Clamp(MapAmbient.g, 127, 255)
	MapAmbient.b = math.Clamp(MapAmbient.b, 127, 255)
	
	frame.previewfloor = vgui.Create("DAdjustableModelPanel", frame)
--	frame.previewfloor:SetSize(590,680)
	frame.previewfloor:Dock(FILL)
	frame.previewfloor:SetPos(0, 0)
	frame.previewfloor:SetFOV(47)
	frame.previewfloor:SetModel("models/props_phx/construct/glass/glass_angle360.mdl")
	frame.previewfloor:SetAnimated( true )
	frame.previewfloor:SetAnimationEnabled(true)
	frame.previewfloor:SetAmbientLight(MapAmbient)
	frame.previewfloor:SetDirectionalLight(BOX_TOP, MapAmbient*2)
	frame.previewfloor:SetDirectionalLight(BOX_FRONT, MapAmbient*1.5)
	frame.previewfloor:SetDirectionalLight(BOX_BOTTOM, Color(0, 0, 0))
	frame.previewfloor:SetDirectionalLight(BOX_BACK, MapAmbient/8)
	frame.previewfloor:SetDirectionalLight(BOX_LEFT, MapAmbient/3)
	frame.previewfloor:SetDirectionalLight(BOX_RIGHT, MapAmbient/3)
	frame.previewfloor:SetLookAng(Angle(10.278, 203.334, 0))
	frame.previewfloor:SetCamPos(Vector(80.69, 36.7, 52.02))
	
	frame.preview = vgui.Create("DAdjustableModelPanel", frame)
--	frame.preview:SetSize(589,666)
	frame.preview:SetPos(0, 0)
	frame.preview:Dock(FILL)
	frame.preview:SetFOV(47)
	frame.preview:SetModel(tostring(pmodelname))
	frame.preview:SetAnimated( true )
	frame.preview:SetAnimationEnabled(true)
	frame.preview:SetAmbientLight(MapAmbient)
	frame.preview:SetDirectionalLight(BOX_TOP, MapAmbient*2)
	frame.preview:SetDirectionalLight(BOX_FRONT, MapAmbient*1.5)
	frame.preview:SetDirectionalLight(BOX_BOTTOM, Color(0, 0, 0))
	frame.preview:SetDirectionalLight(BOX_BACK, MapAmbient/8)
	frame.preview:SetDirectionalLight(BOX_LEFT, MapAmbient/3)
	frame.preview:SetDirectionalLight(BOX_RIGHT, MapAmbient/3)
	frame.preview:SetLookAng(Angle(10.278, 203.334, 0))
	frame.preview:SetCamPos(Vector(80.69, 36.7, 52.02))
	
	local function SetupScene(mod2)
		local tab = DRC:GetPlayerModelInfo(mod2)
		if !tab.Background or tab.Background == "" then bg:SetImage("vgui/drc_playerbg") else bg:SetImage(tab.Background) end
		if !tab.Background or tab.Background == "" then bg:SetImage("vgui/drc_playerbg") else bg:SetImage(tab.Background) end
		if !tab.DefaultCam or tab.DefaultCam == "" then tab.DefaultCam = DRC:GetPlayerModelInfo("-drcdefault").DefaultCam end
		
		frame.previewfloor:SetModel(tab.Podium[1])
		frame.previewfloor.PodiumOffset = tab.Podium[2]
		frame.previewfloor:GetEntity():SetParent(frame.preview:GetEntity())
		frame.previewfloor:GetEntity():AddEffects(EF_BONEMERGE)
		
		if tab.DefaultCam then
			if tab.DefaultCam.Pos then
				frame.preview:SetCamPos(tab.DefaultCam.Pos)
				frame.previewfloor:SetCamPos(tab.DefaultCam.Pos)
			end
			if tab.DefaultCam.Ang then
				frame.preview:SetLookAng(tab.DefaultCam.Ang)
				frame.previewfloor:SetLookAng(tab.DefaultCam.Ang)
			end
		end
	end
	SetupScene(pmodelname)
	
	function frame.preview:LayoutEntity(ent)
		ent:SetLOD(0)
		ent.preview = true
		ent.Preview = true
		DRC.PlayermodelMenuEnt = ent
		frame.preview:SetFOV(math.Clamp(frame.preview:GetFOV(), 10, 100))
		if !ent.SelectedIdle then ent.SelectedIdle = ent:SelectWeightedSequence(ACT_HL2MP_IDLE) end
		if ent:LookupSequence("drc_menu") != -1 then
			ent:SetSequence("drc_menu")
		elseif ent:LookupSequence("drc_menu_xdr_default") != -1 then
			ent:SetSequence("drc_menu_xdr_default")
		else
			ent:SetSequence(ent.SelectedIdle)	
		end
		
		ent.BGNum = 0
		for k,v in pairs(ent:GetBodyGroups()) do
			ent.BGNum = ent.BGNum + v.num
		end
		local pos = frame.preview:GetCamPos()
		local ang = frame.preview:GetLookAng()
		
		if !ent.blonk then ent.blonk = 0 end
		if !ent.blinktime then ent.blinktime = 0 end
		local function Blink()
			local blinkparam = ent:GetFlexIDByName("blink") or ent:GetFlexIDByName("Blink")
			if blinkparam == nil then return end
			ent.blinkval = Lerp(FrameTime() * 10, ent.blinkval or ent.blonk, ent.blonk)
			ent:SetFlexWeight(blinkparam, ent.blinkval)
			if CurTime() < ent.blinktime then return end	
			ent.blinktime = CurTime() + math.Rand(5, 12)
			ent.blonk = 0
			timer.Simple(math.Rand(0.1, 0.5), function() 
				ent.blonk = 1.5
				timer.Simple(math.Rand(0.05, 0.25), function()
					ent.blonk = 0
				end)
			end)
		end
		Blink()
		
		ent:SetAngles( Angle(0, 0, 0) )
		ent:SetPos( Vector() )
		ent:SetEyeTarget(frame.preview:GetCamPos())
		frame.preview:RunAnimation()
		
		pos.x = math.Clamp(pos.x, -200, 200)
		pos.y = math.Clamp(pos.y, -200, 200)
		pos.z = math.Clamp(pos.z, 0, 100)
		frame.preview:SetCamPos(pos)
		
		frame.previewfloor:SetLookAng(ang)
		frame.previewfloor:SetCamPos(pos)
		frame.previewfloor:SetFOV(frame.preview:GetFOV())
		frame.previewfloor:GetEntity():SetParent(frame.preview:GetEntity())
		frame.previewfloor:GetEntity():AddEffects(EF_BONEMERGE)
	end
	
	function frame.previewfloor:LayoutEntity(ent)
		ent:SetLOD(0)
		ent.preview = true
		ent.Preview = true
		ent:SetPos(frame.previewfloor.PodiumOffset)
	end
	
	local bottompanel = vgui.Create("DPanel", frame.preview)
	bottompanel:SetPos(0,frame.preview:GetTall() - 50)
	bottompanel:SetSize(frame.preview:GetWide(), 50)
	bottompanel:SetBackgroundColor(Color(0, 0, 0, 50))
	bottompanel:Dock(BOTTOM)
	
	Derma.PlayerApplyButton = vgui.Create("DButton", bottompanel)
	local applybutton = Derma.PlayerApplyButton
	applybutton:SetText("Apply Changes")
	applybutton:SetPos(230,10)
	applybutton:SetSize(128, 32)
	applybutton:SetTextColor(color_white)
	applybutton:SetContentAlignment(5)
	applybutton:SetTooltip(false)
	function applybutton:Paint(w, h)
		if self:IsEnabled() == true then
			draw.RoundedBox(5, 0, 0, w, h, Color(0,160,0))
		else
			draw.RoundedBox(5, 0, 0, w, h, Color(0,30,0))
		end
	end
	
	local hint = vgui.Create("DButton", bottompanel)
	hint:SetText("Controls")
	hint:SetPos(frame.preview:GetWide() - 80,frame.preview:GetTall() - 42)
	hint:Dock(RIGHT)
	hint:DockMargin(6, 6, 6, 6)
	hint:SetSize(64, 32)
	hint:SetTextColor(color_white)
	hint:SetContentAlignment(5)
	hint:SetTooltip("Left click to pan.\nRight click for FPS controls.\n\nWASD/Arrow keys, Space, and Ctrl to move FPS camera.\nShift to increase camera speed.\nScroll wheel to zoom in/out.")
	function hint:Paint(w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(157,161,165, 127))
	end
	
	local toolsbutton = vgui.Create("DButton", bottompanel)
	toolsbutton:SetFont("DripIcons_Menu")
	toolsbutton:SetText("~")
	toolsbutton:SetPos(16,8)
	toolsbutton:SetSize(32, 32)
	toolsbutton:SetTextColor(color_white)
	toolsbutton:SetContentAlignment(5)
	toolsbutton:SetTooltip(false)
	function toolsbutton:Paint(w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(157,161,165,127))
	end
	function toolsbutton:DoClick()
		local tools = {
			bottompanel.copy,
			bottompanel.copy1,
			bottompanel.copy2,
			bottompanel.hidepodium,
			bottompanel.debugrender,
		}
		for k,v in pairs(tools) do
			v:SetVisible(true)
			v:SetEnabled(true)
		end
		toolsbutton:SetVisible(false)
		toolsbutton.faketoolsbutton = vgui.Create("DButton", bottompanel)
		toolsbutton.faketoolsbutton:SetFont("DripIcons_Menu")
		toolsbutton.faketoolsbutton:SetText("~")
		toolsbutton.faketoolsbutton:SetPos(16,8)
		toolsbutton.faketoolsbutton:SetSize(32, 32)
		toolsbutton.faketoolsbutton:SetTextColor(color_black)
		toolsbutton.faketoolsbutton:SetContentAlignment(5)
		toolsbutton.faketoolsbutton:SetTooltip(false)
		function toolsbutton.faketoolsbutton:Paint(w, h)
			draw.RoundedBox(5, 0, 0, w, h, Color(157,161,165,127))
		end
		function toolsbutton.faketoolsbutton:DoClick()
			local tools = {
				bottompanel.copy,
				bottompanel.copy1,
				bottompanel.copy2,
				bottompanel.hidepodium,
				bottompanel.debugrender,
			}
			for k,v in pairs(tools) do
				v:SetVisible(false)
				v:SetEnabled(false)
			end
			toolsbutton:SetVisible(true)
			toolsbutton.faketoolsbutton:Remove()
		end
		--[[
		local t1 = vgui.Create("DButton", toolsmenu)
		t1:SetSize(128,16)
		t1:SetPos(128,16)
		t1:SetText("Copy model path")
		t1:SetTooltip("Copies current model path to clipboard.")
		function t1:DoClick()
			t1:SetText("Copied!")
			SetClipboardText(frame.preview:GetModel())
			timer.Simple(1, function() t1:SetText("Copy model path") end)
		end
		]]
	end
	
	frame.tools.bgs = vgui.Create("DLabel", frame.tools)
	frame.tools.bgs:SetText("Bodygroups: 0")
	frame.tools.bgs:SetSize(256, 16)
	frame.tools.bgs:SetPos(16, 8)
	
	frame.tools.skins = vgui.Create("DLabel", frame.tools)
	frame.tools.skins:SetText("Skins: 0")
	frame.tools.skins:SetSize(256, 16)
	frame.tools.skins:SetPos(16, 22)
	
	frame.tools.mats = vgui.Create("DLabel", frame.tools)
	frame.tools.mats:SetText("Materials: 0")
	frame.tools.mats:SetSize(256, 16)
	frame.tools.mats:SetPos(16, 36)
	
	frame.tools.bones = vgui.Create("DLabel", frame.tools)
	frame.tools.bones:SetText("Bones: 0")
	frame.tools.bones:SetSize(256, 16)
	frame.tools.bones:SetPos(16, 50)
	
	frame.tools.pos = vgui.Create("DLabel", frame.tools)
	frame.tools.pos:SetText("Position: 0,0,0")
	frame.tools.pos:SetSize(256, 16)
	frame.tools.pos:SetPos(16, 64)
	
	frame.tools.ang = vgui.Create("DLabel", frame.tools)
	frame.tools.ang:SetText("Angle: 0,0,0")
	frame.tools.ang:SetSize(256, 16)
	frame.tools.ang:SetPos(16, 78)
	
	frame.tools.fov = vgui.Create("DLabel", frame.tools)
	frame.tools.fov:SetText("FOV: 0")
	frame.tools.fov:SetSize(256, 16)
	frame.tools.fov:SetPos(16, 92)
	
	bottompanel.copy = vgui.Create("DButton", bottompanel)
	bottompanel.copy:SetSize(64,16)
	bottompanel.copy:SetPos(375,bottompanel:GetTall() - 40)
	bottompanel.copy:SetText("Copy model")
	bottompanel.copy:SetTooltip("Copies current model's path to clipboard.")
	bottompanel.copy:SetEnabled(false)
	bottompanel.copy:SetVisible(false)
	
	bottompanel.copy1 = vgui.Create("DButton", bottompanel)
	bottompanel.copy1:SetSize(64,16)
	bottompanel.copy1:SetPos(375,bottompanel:GetTall() - 22)
	bottompanel.copy1:SetText("Copy voice")
	bottompanel.copy1:SetTooltip("Copies current model's Voice Set ID to the clipboard.")
	bottompanel.copy1:SetEnabled(false)
	bottompanel.copy1:SetVisible(false)
	
	bottompanel.copy2 = vgui.Create("DButton", bottompanel)
	bottompanel.copy2:SetSize(64,16)
	bottompanel.copy2:SetPos(440,bottompanel:GetTall() - 40)
	bottompanel.copy2:SetText("Copy hands")
	bottompanel.copy2:SetTooltip("Copies current model's c_arm path to the clipboard.")
	bottompanel.copy2:SetEnabled(false)
	bottompanel.copy2:SetVisible(false)
	
--[[	function bottompanel.copy:DoClick()
		bottompanel.copy:SetText("Copied!")
		local tbl = {
			["path"] = frame.preview:GetModel(),
			["name"] = player_manager.TranslateToPlayerModelName(frame.preview:GetModel()),
			["hands"] = player_manager.TranslatePlayerHands(player_manager.TranslateToPlayerModelName(frame.preview:GetModel())).model,
			["vs"] = "None",
		}
		if DRC.Playermodels[tbl.name] then if DRC.Playermodels[tbl.name].VoiceSet != "" then tbl.vs = DRC.Playermodels[tbl.name].VoiceSet end end
		tbl.path = "Model Path: ".. tbl.path ..""
		tbl.name = "Model Name: ".. tbl.name ..""
		tbl.hands = "c_arm Path: ".. tbl.hands ..""
		tbl.vs = "VoiceSet: ".. tbl.vs ..""
		local str = "".. tbl.name .."\n".. tbl.path .."\n".. tbl.hands .."\n".. tbl.vs ..""
		SetClipboardText(str)
		timer.Simple(1, function() bottompanel.copy:SetText("Copy model") end)
	end ]]
	
	function bottompanel.copy:DoClick()
		bottompanel.copy:SetText("Copied!")
		local path = frame.preview:GetModel()
		local name = player_manager.TranslateToPlayerModelName(frame.preview:GetModel())
		SetClipboardText(path)
		timer.Simple(1, function() bottompanel.copy:SetText("Copy model") end)
	end
	
	function bottompanel.copy1:DoClick()
		bottompanel.copy1:SetText("Copied!")
		local name = player_manager.TranslateToPlayerModelName(frame.preview:GetModel())
		local vs = "nil"
		if DRC.Playermodels[name] then if DRC.Playermodels[name].VoiceSet != "" then vs = DRC.Playermodels[name].VoiceSet end end
		SetClipboardText(vs)
		timer.Simple(1, function() bottompanel.copy1:SetText("Copy voice") end)
	end
	
	function bottompanel.copy2:DoClick()
		bottompanel.copy2:SetText("Copied!")
		local hands = player_manager.TranslatePlayerHands(player_manager.TranslateToPlayerModelName(frame.preview:GetModel())).model
		SetClipboardText(hands)
		timer.Simple(1, function() bottompanel.copy2:SetText("Copy hands") end)
	end
	
	bottompanel.hidepodium = vgui.Create("DButton", bottompanel)
	bottompanel.hidepodium:SetSize(128,16)
	bottompanel.hidepodium:SetPos(64,bottompanel:GetTall() - 22)
	bottompanel.hidepodium:SetText("Hide podium")
	bottompanel.hidepodium:SetTooltip("Toggles the podium model on/off in the preview window.")
	bottompanel.hidepodium:SetEnabled(false)
	bottompanel.hidepodium:SetVisible(false)
	local hidepodium = false
	
	function bottompanel.hidepodium:DoClick()
		if hidepodium == false then
		hidepodium = true
		frame.previewfloor.Entity:SetMaterial("models/vuthakral/nodraw")
		bottompanel.hidepodium:SetText("Show podium")
		else
		hidepodium = false
		frame.previewfloor.Entity:SetMaterial("")
		bottompanel.hidepodium:SetText("Hide podium")
		end
	--	bottompanel.hidepodium:SetText("Copied!")
	--	SetClipboardText(frame.preview:GetModel())
	--	timer.Simple(1, function() bottompanel.hidepodium:SetText("Copy model path") end)
	end
	
	bottompanel.debugrender = vgui.Create("DButton", bottompanel)
	bottompanel.debugrender:SetSize(128, 16)
	bottompanel.debugrender:SetPos(64, bottompanel:GetTall() -40)
	bottompanel.debugrender:SetText("Enable Debug")
	bottompanel.debugrender:SetTooltip("Toggles previewing bones, hitboxes, and attachments.")
	bottompanel.debugrender:SetEnabled(false)
	bottompanel.debugrender:SetVisible(false)
	local debugenabled = false
	
	function bottompanel.debugrender:DoClick()
		if debugenabled == false then
			debugenabled = true
			bottompanel.debugrender:SetText("Disable Debug")
		else
			debugenabled = false
			bottompanel.debugrender:SetText("Enable Debug")
		end
	end
	
	function frame.preview:PostDrawModel(ent)
		if debugenabled != true then return end
		local HitboxColours = {
			DRC.Cols.pulsewhite,
			Color(255, 0, 0, 255),
			Color(0, 255, 0, 255),
			Color(170, 170, 75, 255),
			Color(0, 0, 255, 255),
			Color(255, 100, 255, 255),
			Color(90, 175, 255, 255),
			Color(255, 255, 255, 255)
		}
		
		local function DoTheFunny(pos,ang, mins, maxs, col)
			render.SetColorMaterial()
			render.DrawWireframeBox( pos, ang, mins, maxs, col, true)
			render.DrawBox( pos, ang, mins, maxs, Color(col.r, col.g, col.b, 5), true)
		end
		
		if !IsValid(ent) then return end
		if ent:GetHitboxSetCount() == nil then return end
		for hitgroup=0, ent:GetHitboxSetCount() - 1 do
			 for box=0, ent:GetHitBoxCount( hitgroup ) - 1 do
				local pos, ang =  ent:GetBonePosition( ent:GetHitBoxBone(box, hitgroup) )
				local mins, maxs = ent:GetHitBoxBounds(box, hitgroup)
				local enum = ent:GetHitBoxHitGroup(box, hitgroup) + 1
				local col = HitboxColours[enum]
				if !col then col = Color(255, 255, 255, 255) end
				DoTheFunny( pos, ang, mins, maxs, col)
			end
		end
		
		local bones = DRC:GetBones(ent)
		
		local function DrawBone(pos, ang, name)
		if !pos or !ang then return end
		if pos == Vector() then return end
			render.SetColorMaterialIgnoreZ()
			render.DrawSphere( pos, 1, 16, 16, Color( 0, 200, 255, 100 ), true )
		end
		
		local function DrawSkeletal(pos1, pos2)
			if !pos1 or !pos2 then return end
			if pos1 == Vector() or pos2 == Vector() then return end
			render.SetColorMaterialIgnoreZ()
			render.DrawLine(pos1, pos2, Color(0, 200, 255, 100))
		end
		
		for k,v in pairs(bones) do
			DrawBone(v.Pos, v.Ang, k)
			
			local bone = ent:LookupBone(k)
			local pos1
			if bone then 
				pos1 = ent:GetBonePosition(bone)
				for k,v in pairs(ent:GetChildBones(bone)) do
					if v then
						pos2 = ent:GetBonePosition(v)
						DrawSkeletal(pos1, pos2)
					end
				end
			end
		end
		
		
		local function DrawAttachment(pos, ang)
			render.SetColorMaterialIgnoreZ()
			render.DrawSphere( pos, 0.75, 4, 4, Color(255, 255, 0, 100))
	
			render.DrawLine( pos, pos + ang:Forward() * 5, Color( 255, 0, 0, 100 ) )
			render.DrawSphere( pos + ang:Forward() * 5, 0.25, 16, 16, Color(255, 0, 0, 100))
			
			render.DrawLine( pos, pos + ang:Right() * -5, Color( 0, 255, 0, 100 ) )
			render.DrawSphere( pos + ang:Right() * -5, 0.25, 16, 16, Color(0, 255, 0, 100))
			
			render.DrawLine( pos, pos + ang:Up() * 5, Color( 0, 0, 255, 100 ) )
			render.DrawSphere( pos + ang:Up() * 5, 0.25, 16, 16, Color(0, 0, 255, 100))
		end
		
		for k,v in pairs(ent:GetAttachments()) do
			local att = ent:GetAttachment(v["id"])
			DrawAttachment(att.Pos, att.Ang)
		end
	end
	
	function frame.preview:PreDrawModel(ent)
		if debugenabled != true then frame.tools:SetVisible(false) return end
		frame.tools:SetVisible(true)
		local pos, ang = frame.preview:GetCamPos(), frame.preview:GetLookAng()
		if frame.tools.bgs then frame.tools.bgs:SetText("Bodygroups: ".. ent.BGNum .."") end
		if frame.tools.skins then frame.tools.skins:SetText("Skins: ".. ent:SkinCount() .."") end
		if frame.tools.mats then frame.tools.mats:SetText("Materials: ".. #ent:GetMaterials() .."") end
		if frame.tools.bones then frame.tools.bones:SetText("Bones: ".. ent:GetBoneCount() .."") end
		if frame.tools.pos then frame.tools.pos:SetText("Cam Position: "..math.Round(pos.x, 2)..", ".. math.Round(pos.y, 2)..", ".. math.Round(pos.z, 2) .."") end
		if frame.tools.ang then frame.tools.ang:SetText("Cam Angle: "..math.Round(ang.x, 2)..", ".. math.Round(ang.y, 2)..", ".. math.Round(ang.z, 2) .."") end
		if frame.tools.fov then frame.tools.fov:SetText("FOV: ".. math.Round(frame.preview:GetFOV(), 2) .."") end
	end
	
	local tabs = vgui.Create( "DPropertySheet", frame2 )
	tabs:Dock(FILL)
	tabs:SetPadding(0)
	tabs:DockPadding(0, 0, 0, 0)
	tabs.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	
	local tab1 = vgui.Create("DPropertySheet", tabs)
	tab1:SetPadding(0)
	tab1:DockPadding(0, 0, 0, 0)
	tab1.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	function tab1:OnActiveTabChanged(old, new)
		local mode = new:GetText()
	end
	
	if Customization == true then
		tabs:AddSheet( "Player", tab1, "icon16/user.png")
	else
		tab1:SetVisible(false)
	end
	
	local tab1PMs = vgui.Create( "DPanel", tab1 )
	tab1PMs:DockPadding(0, 0, 0, 0)
	tab1PMs:SetBackgroundColor( Color(245, 245, 245, 0) )
	if TweakMode < 1 && Customization == true then
		tab1:AddSheet( "Playermodels", tab1PMs, "icon16/folder_user.png")
	else
		tab1PMs:SetVisible(false)
	end
	
	tab1.tab1Hands = vgui.Create( "DPanel", tab1 )
	tab1.tab1Hands:DockPadding(0, 0, 0, 0)
	tab1.tab1Hands:SetBackgroundColor( Color(245, 245, 245, 0) )
	if TweakMode < 1 && Customization == true then
		tab1:AddSheet( "Hands", tab1.tab1Hands, "icon16/folder_page.png")
	else
		tab1.tab1Hands:SetVisible(false)
	end

	
	local tab2 = vgui.Create( "DPanel", tab1 )
	tab2:SetBackgroundColor( Color(255, 255, 255, 255) )
	if TweakMode != 3 && Customization == true then
		tab1:AddSheet( "Colours", tab2, "icon16/color_wheel.png" )
	else
		tab2:SetVisible(false)
	end
	
	
	local t3c = vgui.Create( "DPanel", tab1 )
	t3c:SetBackgroundColor( Color(0, 0, 0, 0) )
	t3c:SetPos(-200, 0)
	
	local tab3 = t3c:Add( "DPanelList" )
	tab3:DockPadding( 32, 8, 8, 8 )
	tab3:EnableVerticalScrollbar( true )
	tab3:Dock(FILL)
	if TweakMode != 2 && Customization == true then
		tab1:AddSheet( "#smwidget.bodygroups", tab3, "icon16/cog.png" )
	else
		tab3:SetVisible(false)
	end
	
	local modelListPnl = tab1PMs:Add( "DPanel" )
	modelListPnl:DockPadding( 8, 0, 8, 0 )
	modelListPnl:Dock(FILL)
	modelListPnl:SetBackgroundColor(Color(0, 0, 0, 0))
	
	local SearchBar = modelListPnl:Add( "DTextEntry" )
	SearchBar:Dock( TOP )
	SearchBar:DockMargin( 0, 0, 0, 0 )
	SearchBar:SetUpdateOnType( true )
	SearchBar:SetPlaceholderText( "#spawnmenu.quick_filter" )
	
	Derma.PlayerModels = modelListPnl:Add( "DPanelSelect" )
	local PanelSelect = Derma.PlayerModels
	PanelSelect:Dock(FILL)
	PanelSelect:SetBackgroundColor(Color(0, 0, 0, 0))
	PanelSelect.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	
	local arms = {
		["c_"] = "c_",
		["v_"] = "v_",
		["vm_"] = "vm_",  -- IT SHOULD BE C_ YOU IDIOTS, V IS VIEW, C IS CLIENT. THESE ARE NOT VIEWMODELS, THEY ARE "CLIENT ARMS". AAAAAAAAAAAAAAAA-
		["viewhands"] = "viewhands", -- I HATE YOU.
		["hand_"] = "hand_" -- AAAAAAAAAAAAAAAAAAAAAAAAAAAAA
	}
	
	PanelSelect.Models = {}
	if table.IsEmpty(DRC.CurrentRPModelOptions) then
		for name, model in SortedPairs( player_manager.AllValidModels() ) do
			local mdl, armbool = string.gsub(model, ".*/", ""), false
			for k,v in pairs(arms) do if string.StartWith(mdl, v) == true then armbool = true end end
			if !armbool then
				local icon = vgui.Create( "SpawnIcon" )
				icon:SetModel( model )
				icon:SetSize( 64, 64 )
				icon:SetTooltip( name )
				icon.playermodel = name
				icon.model_path = model
				
				icon.OpenMenu = function( icon )
					icon:RebuildSpawnIcon()
				end
				
				PanelSelect:AddPanel( icon, { cl_playermodel = name } )
				PanelSelect.Models[model] = model
			end
		end
	else
		for k,v in SortedPairs(DRC.CurrentRPModelOptions) do
			local name, model = player_manager.TranslateToPlayerModelName(v), v
			local icon = vgui.Create( "SpawnIcon" )
			icon:SetModel( model )
			icon:SetSize( 64, 64 )
			icon:SetTooltip( name )
			icon.playermodel = name
			icon.model_path = model
				
			PanelSelect:AddPanel( icon, { cl_playermodel = name } )
		end
	end
	
	if !table.IsEmpty(DRC.CurrentSpecialModelOptions) then
		for k,v in SortedPairs(DRC.CurrentSpecialModelOptions) do
			local model = v
			local icon = vgui.Create( "SpawnIcon" )
			icon:SetModel( model )
			icon:SetSize( 64, 64 )
			icon:SetTooltip( tostring(model) )
			icon.playermodel = tostring(model)
			icon.model_path = model
				
			PanelSelect:AddPanel( icon, { cl_playermodel = name } )
		end
	end
	
	SearchBar.OnValueChange = function( s, str )
	for id, pnl in pairs( PanelSelect:GetItems() ) do
		if ( !pnl.playermodel:find( str, 1, true ) && !pnl.model_path:find( str, 1, true ) ) then
			pnl:SetVisible( false )
		else
			pnl:SetVisible( true )
		end
	end
	PanelSelect:InvalidateLayout()
	end
	
	if table.IsEmpty(DRC.CurrentRPModelOptions) then
		local modelListPnl_Hands = tab1.tab1Hands:Add( "DPanel" )
		modelListPnl_Hands:DockPadding( 8, 0, 8, 0 )
		modelListPnl_Hands:Dock(FILL)
		modelListPnl_Hands:SetBackgroundColor(Color(0, 0, 0, 0))
		
		Derma.PlayerModels_Hands = modelListPnl_Hands:Add( "DPanelSelect" )
		local PanelSelect_Hands = Derma.PlayerModels_Hands
		PanelSelect_Hands:Dock(FILL)
		PanelSelect_Hands:SetBackgroundColor(Color(0, 0, 0, 0))
		PanelSelect_Hands.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
		end
		
		local RemoveButton = vgui.Create("DImageButton")
		RemoveButton:SetSize(64,64)
		RemoveButton:SetImage("gui/cross.png", "gui/cross.png")
		RemoveButton:SetColor(Color(255, 0, 0, 255))
		PanelSelect_Hands:AddPanel(RemoveButton)
		
		PanelSelect_Hands.Defaults = {
			["models/weapons/c_arms_chell.mdl"] = "models/player/p2_chell.mdl",
			["models/weapons/c_arms_citizen.mdl"] = "models/player/group01/male_07.mdl",
			["models/weapons/c_arms_combine.mdl"] = "models/player/combine_soldier.mdl",
			["models/weapons/c_arms_cstrike.mdl"] = "models/player/t_leet.mdl",
			["models/weapons/c_arms_dod.mdl"] = "models/player/dod_american.mdl",
			["models/weapons/c_arms_hev.mdl"] = "models/items/hevsuit.mdl",
			["models/weapons/c_arms_refugee.mdl"] = "models/player/group03/male_07.mdl",
		}
		
		for name, model in SortedPairs( player_manager.AllValidModels() ) do
			local mdl, armbool = string.gsub(model, ".*/", ""), false
			for k,v in pairs(arms) do if string.StartWith(mdl, v) == true then armbool = true end end
			if !PanelSelect.Models[model] then
				if armbool then
					local icon = vgui.Create( "SpawnIcon" )
					icon:SetModel( model )
					icon:SetSize( 64, 64 )
					icon:SetTooltip( name )
					icon.playerhands = name
					icon.model_path = model
					icon.tbl = {
						["model"] = model,
						["skin"] = 0,
						["bodygroups"] = "00000000",
					}
					
					PanelSelect_Hands:AddPanel( icon, { cl_playerhands = icon.tbl.model } )
				end
			end
		end
		
		for name, model in SortedPairs( PanelSelect_Hands.Defaults ) do
			local icon = vgui.Create( "SpawnIcon" )
			icon:SetModel( model )
			icon:SetSize( 64, 64 )
			icon:SetTooltip( name )
			icon.playerhands = name
			icon.model_path = model
			icon.tbl = {
				["model"] = name,
				["skin"] = 0,
				["bodygroups"] = "00000000",
			}
				
			PanelSelect_Hands:AddPanel( icon, { cl_playerhands = icon.tbl.model } )
		end
		
		function PanelSelect_Hands:OnActivePanelChanged( old, new )
			if ( old != new ) then -- Only reset if we changed the model
				if new.GetImage then
					RunConsoleCommand("cl_playerhands", "disabled")
					RunConsoleCommand("cl_playerhands_bodygroups", "0")
					RunConsoleCommand("cl_playerhands_skin", "0")
				else
					local hands = new.tbl
					RunConsoleCommand("cl_playerhands", tostring(hands.model))
					RunConsoleCommand("cl_playerhands_bodygroups", tostring(hands.body))
					RunConsoleCommand("cl_playerhands_skin", tostring(hands.skin))
				end
			end
		end
	end
	
	local ScrollPrim = vgui.Create("DPanel", tab2)
	ScrollPrim:SetPos(0, 0)
	ScrollPrim:Dock(FILL)
	ScrollPrim:DockMargin(0, 0, 4, 4)
	ScrollPrim:SetBackgroundColor(Color(255, 255, 255, 0))
	
	local row1 = vgui.Create("DPanel", ScrollPrim)
	row1:Dock(TOP)
	row1:DockMargin(4, 4, 0, 0)
	row1:SetSize(windowwide*0.5, windowtall/3.75 )
	row1:SetBackgroundColor(Color(255, 255, 255, 0))
	
	local row2 = vgui.Create("DPanel", ScrollPrim)
	row2:Dock(TOP)
	row2:DockMargin(4, 4, 0, 0)
	row2:SetSize(windowwide*0.5, windowtall/3.75 )
	row2:SetBackgroundColor(Color(255, 255, 255, 0))
	
	local row3 = vgui.Create("DPanel", ScrollPrim)
	row3:Dock(TOP)
	row3:DockMargin(4, 4, 0, 0)
	row3:SetSize(windowwide*0.5, windowtall/3.75 )
	row3:SetBackgroundColor(Color(255, 255, 255, 0))
	

	
--	local clabel = vgui.Create("DLabel", tab2)
--	clabel:SetPos(8, 600)
--	clabel:SetSize(600, 32)
--	clabel:SetTextColor(Color(0, 0, 0, 255))
--	clabel:SetText("These colours update for everyone when you respawn or press the 'Apply Changes' button on the left.")
	
	local playercol = Vector(GetConVarString("cl_playercolor")) * 255
	local weaponcol = Vector(GetConVarString("cl_weaponcolor")) * 255
	local eyecol = Vector(GetConVarNumber("cl_drc_eyecolour_r"), GetConVarNumber("cl_drc_eyecolour_g"), GetConVarNumber("cl_drc_eyecolour_b"))
	local energycol = Vector(GetConVarNumber("cl_drc_energycolour_r"), GetConVarNumber("cl_drc_energycolour_g"), GetConVarNumber("cl_drc_energycolour_b"))
	local accent1col = Vector(GetConVarNumber("cl_drc_tint1_r"), GetConVarNumber("cl_drc_tint1_g"), GetConVarNumber("cl_drc_tint1_b"))
	local accent2col = Vector(GetConVarNumber("cl_drc_tint2_r"), GetConVarNumber("cl_drc_tint2_g"), GetConVarNumber("cl_drc_tint2_b"))
	
	local playercolourpreview = vgui.Create("DPanel", row1)
	playercolourpreview:SetSize(20, 100)
	playercolourpreview:Dock( LEFT )
	playercolourpreview:DockMargin(0, 20, 2, 0)
	playercolourpreview:SetBackgroundColor(Color(playercol.x, playercol.y, playercol.z, 255))
	
	local playercolour = vgui.Create("DColorMixer", row1)
	playercolour:Dock( LEFT )
	playercolour:SetSize(259, 172) -- leftwide*1.25/4.65, topwide/6 + 12
	playercolour:SetLabel("Player Colour")
	playercolour:SetPalette(false)
	playercolour:SetAlphaBar(false)
	playercolour:SetVector( Vector( GetConVarString( "cl_playercolor" ) ) );
	
	local weaponcolour = vgui.Create("DColorMixer", row1)
	weaponcolour:Dock( RIGHT )
	weaponcolour:SetSize(259, 172)
	weaponcolour:SetLabel("Weapon Colour")
	weaponcolour:SetPalette(false)
	weaponcolour:SetAlphaBar(false)
	weaponcolour:SetVector( Vector( GetConVarString( "cl_weaponcolor" ) ) );
	
	local weaponcolourpreview = vgui.Create("DPanel", row1)
	weaponcolourpreview:SetSize(20, 100)
	weaponcolourpreview:Dock( RIGHT )
	weaponcolourpreview:DockMargin(0, 20, 2, 0)
	weaponcolourpreview:SetBackgroundColor(Color(weaponcol.x, weaponcol.y, weaponcol.z, 255))
	
	local eyecolourpreview = vgui.Create("DPanel", row2)
	eyecolourpreview:SetSize(20, 100)
	eyecolourpreview:Dock( LEFT )
	eyecolourpreview:DockMargin(0, 20, 2, 0)
	eyecolourpreview:SetBackgroundColor(Color(eyecol.x, eyecol.y, eyecol.z, 255))
	
	local eyecolour = vgui.Create("DColorMixer", row2)
	eyecolour:Dock( LEFT )
	eyecolour:SetSize(259, 172)
	eyecolour:SetLabel("Eye Colour")
	eyecolour:SetPalette(false)
	eyecolour:SetAlphaBar(false)
	eyecolour:SetColor(Color(eyecol.x, eyecol.y, eyecol.z))
	eyecolour:SetConVarR("cl_drc_eyecolour_r")
	eyecolour:SetConVarG("cl_drc_eyecolour_g")
	eyecolour:SetConVarB("cl_drc_eyecolour_b")
	
	local energyColour = vgui.Create("DColorMixer", row2)
	energyColour:Dock( RIGHT )
	energyColour:SetSize(259, 172)
	energyColour:SetLabel("Energy / Light Colour")
	energyColour:SetPalette(false)
	energyColour:SetAlphaBar(false)
	energyColour:SetColor(Color(energycol.x, energycol.y, energycol.z))
	energyColour:SetConVarR("cl_drc_energycolour_r")
	energyColour:SetConVarG("cl_drc_energycolour_g")
	energyColour:SetConVarB("cl_drc_energycolour_b")
	
	local energyColourpreview = vgui.Create("DPanel", row2)
	energyColourpreview:SetSize(20, 100)
	energyColourpreview:Dock( RIGHT )
	energyColourpreview:DockMargin(0, 20, 2, 0)
	energyColourpreview:SetBackgroundColor(Color(energycol.x, energycol.y, energycol.z, 255))
	
	local accentColour1preview = vgui.Create("DPanel", row3)
	accentColour1preview:SetSize(20, 100)
	accentColour1preview:Dock( LEFT )
	accentColour1preview:DockMargin(0, 20, 2, 0)
	accentColour1preview:SetBackgroundColor(Color(accent1col.x, accent1col.y, accent1col.z, 255))
	
	local accentColour1 = vgui.Create("DColorMixer", row3)
	accentColour1:Dock( LEFT )
	accentColour1:SetSize(259, 172)
	accentColour1:SetLabel("Accent Colour 1")
	accentColour1:SetPalette(false)
	accentColour1:SetAlphaBar(false)
	accentColour1:SetColor(Color(accent1col.x, accent1col.y, accent1col.z))
	accentColour1:SetConVarR("cl_drc_tint1_r")
	accentColour1:SetConVarG("cl_drc_tint1_g")
	accentColour1:SetConVarB("cl_drc_tint1_b")
	
	local accentColour2 = vgui.Create("DColorMixer", row3)
	accentColour2:Dock( RIGHT )
	accentColour2:SetSize(259, 172)
	accentColour2:SetLabel("Accent Colour 2")
	accentColour2:SetPalette(false)
	accentColour2:SetAlphaBar(false)
	accentColour2:SetColor(Color(accent2col.x, accent2col.y, accent2col.z))
	accentColour2:SetConVarR("cl_drc_tint2_r")
	accentColour2:SetConVarG("cl_drc_tint2_g")
	accentColour2:SetConVarB("cl_drc_tint2_b")
	
	local accentColour2preview = vgui.Create("DPanel", row3)
	accentColour2preview:SetSize(20, 100)
	accentColour2preview:Dock( RIGHT )
	accentColour2preview:DockMargin(0, 20, 2, 0)
	accentColour2preview:SetBackgroundColor(Color(accent2col.x, accent2col.y, accent2col.z, 255))
	
	ScrollPrim.slider = vgui.Create( "DNumSlider", ScrollPrim )
	ScrollPrim.slider:Dock( TOP )
	ScrollPrim.slider:SetText( "Wear & Tear" )
	ScrollPrim.slider:SetDark( true )
	ScrollPrim.slider:SetTall( 50 )
	ScrollPrim.slider:SetDecimals( 0 )
	ScrollPrim.slider:SetMax( 100 )
	ScrollPrim.slider:DockMargin(32, -6, 0, 0)
	ScrollPrim.slider:SetValue(GetConVarNumber("cl_drc_playergrunge"))
	ScrollPrim.slider:SetConVar("cl_drc_playergrunge")
	ScrollPrim.slider.ValueChanged = function()
		UpdateDraconicColours()
	end
	
	MakeHint(ScrollPrim, 14, 599, "Only works on playermodels with support for it.\n\nDraconic material proxy ''drc_PlayerGrunge'', which lets you choose how ''worn'' the material(s) will be.")
	
	function applybutton:DoClick()
	--[[	local str = ""
		for k,v in pairs(frame.preview:GetEntity():GetBodyGroups()) do
			local num = frame.preview:GetEntity():GetBodygroup(k-1)
			str = "".. str .."".. tostring(num) ..""
		end
	]]
		local bgs = DRC:GetBodyGroups(frame.preview:GetEntity())
		local handval = player_manager.TranslatePlayerModel(LocalPlayer():GetInfo("cl_playerhands"))
		local pmname = player_manager.TranslateToPlayerModelName(handval)
		if LocalPlayer():GetInfo("cl_playerhands") == "disabled" then 
			pmname = player_manager.TranslateToPlayerModelName(frame.preview:GetModel())
		end
		local handstable = player_manager.TranslatePlayerHands(pmname)
		if LocalPlayer():GetInfo("cl_playerhands") != "disabled" then 
			handstable.model = LocalPlayer():GetInfo("cl_playerhands")
			handval = handstable.model
		end
		
		local tbl = {}
		if Customization == false then -- Disallowed
			tbl = {
				["player"] = LocalPlayer(),
				["model"] = LocalPlayer():GetModel(),
				["colours"] = DRC:GetColours(LocalPlayer(), false),
				["bodygroups"] = bgs,
				["skin"] = frame.preview:GetEntity():GetSkin(),
				["voiceset"] = VSelection,
				["footsteps"] = FSelection,
				["hands"] = {
					["model"] = handval,
					["bodygroups"] = LocalPlayer():GetInfo("cl_playerhands_bodygroups"),
					["skin"] = LocalPlayer():GetInfo("cl_playerhands_skin"),
				}
			}
		elseif Customization == nil then -- Tweak-only
			tbl = {
				["player"] = LocalPlayer(),
				["model"] = LocalPlayer():GetModel(),
				["colours"] = {
					["Energy"] = Color(energyColour:GetColor().r, energyColour:GetColor().g, energyColour:GetColor().b),
					["Eye"] = Color(eyecolour:GetColor().r, eyecolour:GetColor().g, eyecolour:GetColor().b),
					["Player"] = Color(playercolour:GetColor().r, playercolour:GetColor().g, playercolour:GetColor().b),
					["Tint1"] = Color(accentColour1:GetColor().r, accentColour1:GetColor().g, accentColour1:GetColor().b),
					["Tint2"] = Color(accentColour2:GetColor().r, accentColour2:GetColor().g, accentColour2:GetColor().b),
					["Weapon"] = Color(weaponcolour:GetColor().r, weaponcolour:GetColor().g, weaponcolour:GetColor().b),
					["Grunge"] = LocalPlayer():GetInfo("drc_playergrunge"),
				},
				["bodygroups"] = bgs,
				["skin"] = frame.preview:GetEntity():GetSkin(),
				["voiceset"] = VSelection,
				["footsteps"] = FSelection,
				["hands"] = {
					["model"] = handval,
					["bodygroups"] = LocalPlayer():GetInfo("cl_playerhands_bodygroups"),
					["skin"] = LocalPlayer():GetInfo("cl_playerhands_skin"),
				}
			}
		elseif Customization == true then -- Allowed
			tbl = {
				["player"] = LocalPlayer(),
				["model"] = frame.preview:GetModel(),
				["colours"] = {
					["Energy"] = Color(energyColour:GetColor().r, energyColour:GetColor().g, energyColour:GetColor().b),
					["Eye"] = Color(eyecolour:GetColor().r, eyecolour:GetColor().g, eyecolour:GetColor().b),
					["Player"] = Color(playercolour:GetColor().r, playercolour:GetColor().g, playercolour:GetColor().b),
					["Tint1"] = Color(accentColour1:GetColor().r, accentColour1:GetColor().g, accentColour1:GetColor().b),
					["Tint2"] = Color(accentColour2:GetColor().r, accentColour2:GetColor().g, accentColour2:GetColor().b),
					["Weapon"] = Color(weaponcolour:GetColor().r, weaponcolour:GetColor().g, weaponcolour:GetColor().b),
					["Grunge"] = LocalPlayer():GetInfo("drc_playergrunge"),
				},
				["bodygroups"] = bgs,
				["skin"] = frame.preview:GetEntity():GetSkin(),
				["voiceset"] = VSelection,
				["footsteps"] = FSelection,
				["hands"] = {
					["model"] = handval,
					["bodygroups"] = LocalPlayer():GetInfo("cl_playerhands_bodygroups"),
					["skin"] = LocalPlayer():GetInfo("cl_playerhands_skin"),
				}
			}
		end
		handstable.skin = tbl.hands.skin
		handstable.bodygroups = tbl.hands.bodygroups
		
		net.Start("DRC_ApplyPlayermodel")
		net.WriteTable(tbl)
		net.SendToServer()
		
		DRC:ChangeCHandModel(handstable)
		
		applybutton:SetEnabled(false)
		applybutton:SetText("Wait 3...")
		timer.Simple(1, function() -- This will make someone die inside lmao
			if !IsValid(applybutton) then return end
			applybutton:SetText("Wait 2...")
			timer.Simple(1, function()
				if !IsValid(applybutton) then return end
				applybutton:SetText("Wait 1...")
				timer.Simple(1, function()
					if !IsValid(applybutton) then return end
					applybutton:SetText("Apply Changes")
					applybutton:SetEnabled(true)
				end)
			end)
		end)
	end
	
	local tab5 = vgui.Create( "DPropertySheet", tabs )
	tab5:DockPadding(0, 0, 0, 0)
	tab5.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(234, 234, 234, 255))
	end
	tabs:AddSheet( "Extra", tab5, "icon16/draconic_base.png" )
	
	tab5.SpraySettings = vgui.Create( "DPanel", tab1 )
	tab5.SpraySettings:DockPadding(0, 0, 0, 0)
	tab5.SpraySettings:SetBackgroundColor( Color(245, 245, 245, 0) )
	tab5:AddSheet( "Spray Settings", tab5.SpraySettings, "icon16/layers.png")
	
	tab5.VoiceSetSettings = vgui.Create( "DPanel", tab1 )
	tab5.VoiceSetSettings:DockPadding(0, 0, 0, 0)
	tab5.VoiceSetSettings:SetBackgroundColor( Color(245, 245, 245, 0) )
	tab5:AddSheet( "VoiceSet", tab5.VoiceSetSettings, "icon16/sound.png")
	
	tab5.FootstepSounds = vgui.Create( "DPanel", tab1 )
	tab5.FootstepSounds:DockPadding(0, 0, 0, 0)
	tab5:AddSheet( "Footsteps", tab5.FootstepSounds, "icon16/sound_add.png")
	tab5.FootstepSounds:SetBackgroundColor( Color(245, 245, 245, 0) )
	
	local tab4 = vgui.Create( "DPanel", tabs )
	tab4:SetBackgroundColor( Color(255, 255, 255, 255) )
--	tab4:Dock(FILL)
	tabs:AddSheet( "Saved Avatars", tab4, "icon16/award_star_gold_1.png" )
	
	local Sprays_General = vgui.Create( "DCheckBoxLabel", tab5.SpraySettings )
	Sprays_General:SetPos(8, 0)
	Sprays_General:SetSize(500, 20)
	Sprays_General:SetText( "Display spray on spawned props/entities" )
	Sprays_General:SetConVar( "cl_drc_showspray" )
	Sprays_General.Label:SetColor(Color(0, 0, 0, 255))
	Sprays_General:SetEnabled(true)
	Sprays_General:Dock(TOP)
	
	local Sprays_Vehicles = vgui.Create( "DCheckBoxLabel", tab5.SpraySettings )
	Sprays_Vehicles:SetPos(8, 18)
	Sprays_Vehicles:SetSize(500, 20)
	Sprays_Vehicles:SetText( "Display spray on vehicles" )
	Sprays_Vehicles:SetConVar( "cl_drc_showspray_vehicles" )
	Sprays_Vehicles.Label:SetColor(Color(0, 0, 0, 255))
	Sprays_Vehicles:SetEnabled(true)
	Sprays_Vehicles:Dock(TOP)
	
	local Sprays_Weapons = vgui.Create( "DCheckBoxLabel", tab5.SpraySettings )
	Sprays_Weapons:SetPos(8, 36)
	Sprays_Weapons:SetSize(500, 20)
	Sprays_Weapons:SetText( "Display spray on weapons" )
	Sprays_Weapons:SetConVar( "cl_drc_showspray_weapons" )
	Sprays_Weapons.Label:SetColor(Color(0, 0, 0, 255))
	Sprays_Weapons:SetEnabled(true)
	Sprays_Weapons:Dock(TOP)
	
	local Sprays_Player = vgui.Create( "DCheckBoxLabel", tab5.SpraySettings )
	Sprays_Player:SetPos(8, 54)
	Sprays_Player:SetSize(500, 20)
	Sprays_Player:SetText( "Display spray on yourself (playermodel)" )
	Sprays_Player:SetConVar( "cl_drc_showspray_player" )
	Sprays_Player.Label:SetColor(Color(0, 0, 0, 255))
	Sprays_Player:SetEnabled(true)
	Sprays_Player:Dock(TOP)
	
	local SpraypreviewText = vgui.Create("DLabel", tab5.SpraySettings)
	SpraypreviewText:SetPos(8, 78)
	SpraypreviewText:SetSize(500, 32)
	SpraypreviewText:SetTextColor(Color(0, 0, 0, 255))
	SpraypreviewText:SetText("Your spray:")
	SpraypreviewText:SetFont("DermaLarge")
	SpraypreviewText:Dock(TOP)
	
	local Spraypreview = vgui.Create("DImage", tab5.SpraySettings)
	Derma.SprayPreview = Spraypreview
	Spraypreview:SetPos(8, 115)
	Spraypreview:SetSize(320, 320)
	Spraypreview:SetImageColor(Color(255, 255, 255, 255))
	Spraypreview:SetMaterial("vgui/drc_spraypreview")
	Spraypreview:Dock(FILL)
	Spraypreview:DockPadding(0, 0, 0, 0)
	Spraypreview:DockMargin(70, 0, 70, 0)
	
	local SprayDisclaimer = vgui.Create("DLabel", tab5.SpraySettings)
	SprayDisclaimer:SetPos(16, 430)
	SprayDisclaimer:SetSize(400, 64)
	SprayDisclaimer:SetTextColor(Color(0, 0, 0, 255))
	SprayDisclaimer:Dock(BOTTOM)
	SprayDisclaimer:SetText("To set a spray, go to your options menu and check the ''Multiplayer'' tab.\nSprays only update on session initialization. \n\nYour spray will only appear on content with support for it.")
	
--[[	tab5.VoiceSetSettings.VoiceSelector = vgui.Create( "DComboBox", tab5.VoiceSetSettings )
	tab5.VoiceSetSettings.VoiceSelector:SetSortItems(true)
	tab5.VoiceSetSettings.VoiceSelector:SetPos(8, 32)
	tab5.VoiceSetSettings.VoiceSelector:SetSize(150, 20)
	tab5.VoiceSetSettings.VoiceSelector:SetConVar( "cl_drc_voiceset" )
	tab5.VoiceSetSettings.VoiceSelector:AddChoice("[!] None", "none")
	for k,v in pairs(DRC.VoiceSets) do
		local tbl = DRC.VoiceSets[k]
		tab5.VoiceSetSettings.VoiceSelector:AddChoice(tbl.Name, tbl.ID)
	end
	function tab5.VoiceSetSettings.VoiceSelector:OnSelect(index, value, data)
		
	end ]]
	
	local function RefreshVoiceSets()
		DRCMenu_VoiceSelector = vgui.Create("DScrollPanel", tab5.VoiceSetSettings)
		DRCMenu_VoiceSelector:SetSize(tab5:GetWide(), tab5:GetTall())
		DRCMenu_VoiceSelector:SetPos(0, 0)
		DRCMenu_VoiceSelector:Dock(FILL)
		DRCMenu_VoiceSelector:DockMargin(4, 4, 4, 4)
		DRCMenu_VoiceSelector:SetBackgroundColor(Color(32, 32, 32, 255))
		
		DRCMenu_VoiceSelector.DisableButton = vgui.Create("DButton", DRCMenu_VoiceSelector)
		DRCMenu_VoiceSelector.DisableButton:SetText("None (Disable)")
		DRCMenu_VoiceSelector.DisableButton:Dock(TOP)
		DRCMenu_VoiceSelector.DisableButton:DockMargin(0, 0, 0, 1)
		DRCMenu_VoiceSelector.DisableButton.DoClick = function()
			LocalPlayer():ConCommand("cl_drc_voiceset None")
			VSelection = "None"
			DRCMenu_VoiceSelector.DisableButton:SetEnabled(false)
			timer.Simple(0.1, function()
				LocalPlayer():ConCommand("cl_drc_voiceset None")
				DRCMenu_VoiceSelector:Remove()
				RefreshVoiceSets()
			end)
		end
		if LocalPlayer():GetInfo("cl_drc_voiceset") == "None" then DRCMenu_VoiceSelector.DisableButton:SetEnabled(false) end
	
		for k,v in SortedPairsByMemberValue(DRC.VoiceSets, "Name", false) do
		--[[	local container = vgui.Create("DPanel", DRCMenu_VoiceSelector)
			container:SetSize(DRCMenu_VoiceSelector:GetWide(), 20)
			container:SetPos(0, 0)
			container:Dock(TOP)
			container:DockMargin(0, 2, 0, 2)
			container:SetBackgroundColor(Color(0, 0, 0, 255)) ]]
			
			local label = vgui.Create("DButton", DRCMenu_VoiceSelector)
			label:SetText(v.Name)
			label:Dock(TOP)
			label:DockMargin(0, 0, 0, 1)
			if string.lower(LocalPlayer():GetInfo("cl_drc_voiceset")) != "none" && DRC.VoiceSets[LocalPlayer():GetInfo("cl_drc_voiceset")] then
				if v.Name == DRC.VoiceSets[LocalPlayer():GetInfo("cl_drc_voiceset")].Name then
					label:SetEnabled(false)
				end
			end
			label.DoClick = function()
				LocalPlayer():ConCommand("cl_drc_voiceset ".. v.ID .."")
				VSelection = v.ID
				label:SetEnabled(false)
				timer.Simple(0, function()
					LocalPlayer():ConCommand("cl_drc_voiceset ".. v.ID .."")
					DRCMenu_VoiceSelector:Remove()
					RefreshVoiceSets()
				end)
			end
		end
	end
	RefreshVoiceSets()
	
	tab5.VoiceSetSettings.Enforced = ""
	if LocalPlayer():GetNWInt("DRCVoiceSet_Enforced", "None") == "None" then
		tab5.VoiceSetSettings.Enforced = "\n\nYou are NOT currently being enforced to use a specific VS."
	else
		tab5.VoiceSetSettings.Enforced = "\n\nYou ARE currently being enforced to use a specific VS."
	end
	
	tab5.VoiceSetSettings.Binding = vgui.Create("DLabel", tab5.VoiceSetSettings)
	tab5.VoiceSetSettings.Binding:SetSize(300, tab5:GetTall())
	tab5.VoiceSetSettings.Binding:SetPos(300, 0)
	tab5.VoiceSetSettings.Binding:SetTextColor(Color(0, 0, 0, 255))
	tab5.VoiceSetSettings.Binding:Dock(RIGHT)
	tab5.VoiceSetSettings.Binding:DockMargin(4, 8, 4, 4)
	tab5.VoiceSetSettings.Binding:SetContentAlignment(7)
	tab5.VoiceSetSettings.Binding:SetText("''What is VoiceSets?''\nVoiceSets is a system whichs adds a CS/TF2-like voice panel to\nmake your character say certain things, among many other\nuseful tools for devs to add player dialogue to the game.\n\n''How do I use the menu?''\nYour menu will currently toggle with the ".. DRC:VoiceSetGetMenuKey() .. " key.\nYou can change this by binding the console command\n''draconic_voicesets_menu_toggle'' to a key.\n\n''How do I make a VoiceSet?''\nPlease refer to the Draconic Base Wiki, as there is a page\ndedicated to explaining this. It is very easy to do,\nand I'm confident that anyone is able to do it.\n\nIf a gamemode, server, or etc has enforced a specific VS on\nyou, you will not be able to change nor disable VoiceSets.".. tab5.VoiceSetSettings.Enforced .."")
	
	
	-- 
	
	tab5.VoiceSetSettings.AutoVS = vgui.Create("DCheckBoxLabel", tab5.VoiceSetSettings)
	tab5.VoiceSetSettings.AutoVS:SetPos(280, 295)
	tab5.VoiceSetSettings.AutoVS:SetSize(200, 20)
	tab5.VoiceSetSettings.AutoVS:SetText( "Use Playermodel VoiceSets" )
	tab5.VoiceSetSettings.AutoVS:SetConVar( "cl_drc_voiceset_automatic" )
	tab5.VoiceSetSettings.AutoVS.Label:SetColor(color_black)
	tab5.VoiceSetSettings.AutoVS:SetEnabled(true)
	
	MakeHint(tab5.VoiceSetSettings, 435, 295, "When enabled this will automatically utilize a VoiceSet tied to a playermodel, should it have one.")
	
	tab5.VoiceSetSettings.copy = vgui.Create("DButton", tab5.VoiceSetSettings)
	tab5.VoiceSetSettings.copy:SetSize(300,20)
	tab5.VoiceSetSettings.copy:SetPos(280,270)
	tab5.VoiceSetSettings.copy:SetText("Copy selected VoiceSet ID to clipboard")
	tab5.VoiceSetSettings.copy:SetTooltip("Copies select VoiceSet's ID to clipboard.")
	
	function tab5.VoiceSetSettings.copy:DoClick()
		tab5.VoiceSetSettings.copy:SetText("Copied!")
		SetClipboardText(VSelection)
		timer.Simple(1, function() tab5.VoiceSetSettings.copy:SetText("Copy selected VoiceSet ID to clipboard") end)
	end
	
	local function RefreshFootsteps()
		DRCMenu_VoiceSelector = vgui.Create("DScrollPanel", tab5.FootstepSounds)
		DRCMenu_VoiceSelector:SetSize(tab5:GetWide(), tab5:GetTall())
		DRCMenu_VoiceSelector:SetPos(0, 0)
		DRCMenu_VoiceSelector:Dock(FILL)
		DRCMenu_VoiceSelector:DockMargin(4, 4, 4, 4)
		DRCMenu_VoiceSelector:SetBackgroundColor(Color(32, 32, 32, 255))
		
		DRCMenu_VoiceSelector.DisableButton = vgui.Create("DButton", DRCMenu_VoiceSelector)
		DRCMenu_VoiceSelector.DisableButton:SetText("None (Disable)")
		DRCMenu_VoiceSelector.DisableButton:Dock(TOP)
		DRCMenu_VoiceSelector.DisableButton:DockMargin(0, 0, 0, 1)
		DRCMenu_VoiceSelector.DisableButton.DoClick = function()
			LocalPlayer():ConCommand("cl_drc_footstepset None")
			FSelection = "None"
			DRCMenu_VoiceSelector.DisableButton:SetEnabled(false)
			timer.Simple(0.1, function()
				LocalPlayer():ConCommand("cl_drc_footstepset None")
				DRCMenu_VoiceSelector:Remove()
				RefreshFootsteps()
			end)
		end
		if LocalPlayer():GetInfo("cl_drc_footstepset") == "None" then DRCMenu_VoiceSelector.DisableButton:SetEnabled(false) end
	
		for k,v in SortedPairsByMemberValue(DRC.FootSteps, "Name", false) do
		--[[	local container = vgui.Create("DPanel", DRCMenu_VoiceSelector)
			container:SetSize(DRCMenu_VoiceSelector:GetWide(), 20)
			container:SetPos(0, 0)
			container:Dock(TOP)
			container:DockMargin(0, 2, 0, 2)
			container:SetBackgroundColor(Color(0, 0, 0, 255)) ]]
			
			local label = vgui.Create("DButton", DRCMenu_VoiceSelector)
			label:SetText(v.Name)
			label:Dock(TOP)
			label:DockMargin(0, 0, 0, 1)
			if string.lower(LocalPlayer():GetInfo("cl_drc_footstepset")) != "none" && DRC.FootSteps[LocalPlayer():GetInfo("cl_drc_footstepset")] then
				if v.Name == DRC.FootSteps[LocalPlayer():GetInfo("cl_drc_footstepset")].Name then
					label:SetEnabled(false)
				end
			end
			label.DoClick = function()
				LocalPlayer():ConCommand("cl_drc_footstepset ".. v.ID .."")
				FSelection = v.ID
				label:SetEnabled(false)
				timer.Simple(0, function()
					LocalPlayer():ConCommand("cl_drc_footstepset ".. v.ID .."")
					DRCMenu_VoiceSelector:Remove()
					RefreshFootsteps()
				end)
			end
		end
	end
	RefreshFootsteps()
	
	tab5.FootstepSounds.Enforced = ""
	if LocalPlayer():GetNWInt("DRCVoiceSet_Enforced", "None") == "None" then
		tab5.FootstepSounds.Enforced = "\n\nYou are NOT currently being enforced to use a specific set."
	else
		tab5.FootstepSounds.Enforced = "\n\nYou ARE currently being enforced to use a specific set."
	end
	
	tab5.FootstepSounds.Binding = vgui.Create("DLabel", tab5.FootstepSounds)
	tab5.FootstepSounds.Binding:SetSize(300, tab5:GetTall())
	tab5.FootstepSounds.Binding:SetPos(300, 0)
	tab5.FootstepSounds.Binding:SetTextColor(Color(0, 0, 0, 255))
	tab5.FootstepSounds.Binding:Dock(RIGHT)
	tab5.FootstepSounds.Binding:DockMargin(4, 8, 4, 4)
	tab5.FootstepSounds.Binding:SetContentAlignment(7)
	tab5.FootstepSounds.Binding:SetText("''What is this page?''\nThis panel allows you to pick from any installed footstep\nsounds, or disable it entirely to allow compatibility with\nother addons or systems.\n\n''How can I add my own custom set?''\nPlease refer to the Draconic Base Wiki, as there is a page\ndedicated to explaining this. It is very easy to do,\nand I'm confident that anyone is able to do it.\n\nIf a gamemode, server, or etc has enforced a specific set on\nyou, you will not be able to change your footstep sounds.".. tab5.FootstepSounds.Enforced .."")
	
	
	-- 
	
	tab5.FootstepSounds.AutoVS = vgui.Create("DCheckBoxLabel", tab5.FootstepSounds)
	tab5.FootstepSounds.AutoVS:SetPos(280, 220)
	tab5.FootstepSounds.AutoVS:SetSize(200, 20)
	tab5.FootstepSounds.AutoVS:SetText( "Use Playermodel Footsteps" )
	tab5.FootstepSounds.AutoVS:SetConVar( "cl_drc_footstepset_automatic" )
	tab5.FootstepSounds.AutoVS.Label:SetColor(color_black)
	tab5.FootstepSounds.AutoVS:SetEnabled(true)
	
	MakeHint(tab5.FootstepSounds, 435, 220, "When enabled this will automatically utilize a set of footsteps tied to a playermodel, should it have one.")
	
	tab5.FootstepSounds.copy = vgui.Create("DButton", tab5.FootstepSounds)
	tab5.FootstepSounds.copy:SetSize(300,20)
	tab5.FootstepSounds.copy:SetPos(280,195)
	tab5.FootstepSounds.copy:SetText("Copy selected Footstep set's ID to clipboard")
	tab5.FootstepSounds.copy:SetTooltip("Copies selected Footstep set's ID to clipboard.")
	
	function tab5.FootstepSounds.copy:DoClick()
		tab5.FootstepSounds.copy:SetText("Copied!")
		SetClipboardText(FSelection)
		timer.Simple(1, function() tab5.FootstepSounds.copy:SetText("Copy selected Footstep set's ID to clipboard") end)
	end
	
	local function UpdateGmodColours()
		RunConsoleCommand( "cl_playercolor", tostring( playercolour:GetVector() ))
		RunConsoleCommand( "cl_weaponcolor", tostring( weaponcolour:GetVector() ))
	end
	
	playercolour.ValueChanged = function()
		UpdateGmodColours()
		UpdateDraconicColours()
		playercolourpreview:SetBackgroundColor(playercolour:GetColor())
	end
	
	weaponcolour.ValueChanged = function()
		UpdateGmodColours()
		UpdateDraconicColours()
		weaponcolourpreview:SetBackgroundColor(weaponcolour:GetColor())
	end
	
	eyecolour.ValueChanged = function()
		UpdateGmodColours()
		UpdateDraconicColours()
		eyecolourpreview:SetBackgroundColor(eyecolour:GetColor())
	end
	
	energyColour.ValueChanged = function()
		UpdateGmodColours()
		UpdateDraconicColours()
		energyColourpreview:SetBackgroundColor(energyColour:GetColor())
	end
	
	accentColour1.ValueChanged = function()
		UpdateGmodColours()
		UpdateDraconicColours()
		accentColour1preview:SetBackgroundColor(accentColour1:GetColor())
	end
	
	accentColour2.ValueChanged = function()
		UpdateGmodColours()
		UpdateDraconicColours()
		accentColour2preview:SetBackgroundColor(accentColour2:GetColor())
	end
	
		local function UpdateBodyGroups( pnl, val )
			if ( pnl.type == "bgroup" ) then

				frame.preview.Entity:SetBodygroup( pnl.typenum, math.Round( val ) )

				local str = string.Explode( " ", GetConVarString( "cl_playerbodygroups" ) )
				if ( #str < pnl.typenum + 1 ) then for i = 1, pnl.typenum + 1 do str[ i ] = str[ i ] or 0 end end
				str[ pnl.typenum + 1 ] = math.Round( val )
				RunConsoleCommand( "cl_playerbodygroups", table.concat( str, " " ) )

			elseif ( pnl.type == "skin" ) then

				frame.preview.Entity:SetSkin( math.Round( val ) )
				ply:SetSkin( math.Round( val ) )
				RunConsoleCommand( "cl_playerskin", math.Round( val ) )

			end
		end
	
		local function RebuildBodygroupTab()
			tab3:Clear()
			if !IsValid(tab3) then return end

		--	tab3.Tab:SetVisible( false )

			local nskins = frame.preview.Entity:SkinCount() - 1
			if ( nskins > 0 ) then
				local skins = vgui.Create( "DNumSlider", tab3 )
				skins:Dock( TOP )
				skins:SetText( "Skin" )
				skins:SetDark( true )
				skins:SetTall( 50 )
				skins:SetDecimals( 0 )
				skins:SetMax( nskins )
				skins:SetValue( GetConVarNumber( "cl_playerskin" ) )
				skins.type = "skin"
				skins.OnValueChanged = UpdateBodyGroups

				tab3:AddItem( skins )

				frame.preview.Entity:SetSkin( GetConVarNumber( "cl_playerskin" ) )

				if tab3.Tab then tab3.Tab:SetVisible( true ) end
			end

			local groups = string.Explode( " ", GetConVarString( "cl_playerbodygroups" ) )
			for k = 0, frame.preview.Entity:GetNumBodyGroups() - 1 do
				if ( frame.preview.Entity:GetBodygroupCount( k ) <= 1 ) then continue end

				local bgroup = vgui.Create( "DNumSlider" )
				bgroup:Dock( TOP )
				bgroup:SetText( frame.preview.Entity:GetBodygroupName( k ) )
				bgroup:SetDark( true )
				bgroup:SetTall( 50 )
				bgroup:SetDecimals( 0 )
				bgroup.type = "bgroup"
				bgroup.typenum = k
				bgroup:SetMax( frame.preview.Entity:GetBodygroupCount( k ) - 1 )
				bgroup:SetValue( groups[ k + 1 ] or 0 )
				bgroup.OnValueChanged = UpdateBodyGroups

				tab3:AddItem( bgroup )

				frame.preview.Entity:SetBodygroup( k, groups[ k + 1 ] or 0 )

				if tab3.Tab then tab3.Tab:SetVisible( true ) end
			end

			tabs.tabScroller:InvalidateLayout()
		end
		
		local function UpdateFromConvars()
			local model = LocalPlayer():GetInfo("cl_playermodel")
			modelname = player_manager.TranslatePlayerModel(model)
			if Customization == true then
				util.PrecacheModel(modelname)
				frame.preview:SetModel(modelname)
			end
			RebuildBodygroupTab()
			if frame.preview.Entity then frame.preview.Entity.GetPlayerColor = function() return Vector(GetConVarString("cl_playercolor")) end end
			playercolour:SetVector(Vector(GetConVarString("cl_playercolor")))
			weaponcolour:SetVector(Vector(GetConVarString("cl_weaponcolor")))
		end
		
		local function UpdateFromModel(model)
			if Customization == true then
				util.PrecacheModel(model)
				frame.preview:SetModel(model)
			end
			RebuildBodygroupTab()
			if frame.preview.Entity then frame.preview.Entity.GetPlayerColor = function() return Vector(GetConVarString("cl_playercolor")) end end
			playercolour:SetVector(Vector(GetConVarString("cl_playercolor")))
			weaponcolour:SetVector(Vector(GetConVarString("cl_weaponcolor")))
		end
	UpdateFromConvars()
	
	-- @@@@@@@@@@
	function PanelSelect:OnActivePanelChanged( old, new )
		local name = new:GetModelName()
		if old != new then
			bgloading:SetVisible(true)
			SetupScene(name)
			RunConsoleCommand( "cl_playerbodygroups", "0" )
			RunConsoleCommand( "cl_playerskin", "0" )
			frame.preview.Entity.SelectedIdle = nil
		end
		timer.Simple(0.1, function()
			if !table.IsEmpty(DRC.CurrentSpecialModelOptions) && table.HasValue(DRC.CurrentSpecialModelOptions, name) then
				UpdateFromModel(name)
			else
				UpdateFromConvars()
			end
			bgloading:SetVisible(false)
		end)
	end

	frame.preview.Entity.preview = true
	
	local SelectedAvatar = nil
	local drc_loadedavatarfile = nil
	local function LoadAvatar()
		local json = drc_loadedavatarfile
		local tbl = util.JSONToTable(json)
		
		local pc = Vector(tbl.Colours.Player)
		local wc = Vector(tbl.Colours.Weapon)
		local eyc = Vector(tbl.Colours.Eye)
		local enc = Vector(tbl.Colours.Energy)
		local t1c = Vector(tbl.Colours.Tint1)
		local t2c = Vector(tbl.Colours.Tint2)
		
		playercolour:SetColor(Color(pc.x, pc.y, pc.z, 255))
		weaponcolour:SetColor(Color(wc.x, wc.y, wc.z, 255))
		eyecolour:SetColor(Color(eyc.x, eyc.y, eyc.z, 255))
		energyColour:SetColor(Color(enc.x, enc.y, enc.z, 255))
		accentColour1:SetColor(Color(t1c.x, t1c.y, t1c.z, 255))
		accentColour2:SetColor(Color(t2c.x, t2c.y, t2c.z, 255))
		
		RunConsoleCommand( "cl_playermodel", player_manager.TranslateToPlayerModelName(tbl.Model) )
		RunConsoleCommand( "cl_playerbodygroups", tostring(tbl.Bodygroups) )
		RunConsoleCommand( "cl_playerskin", tostring(tbl.Skin) )
		
		frame.preview:SetModel(tbl.Model)
		frame.preview.Entity:SetModel(tbl.Model)
		frame.preview.Entity:SetBodyGroups(string.gsub(tbl.Bodygroups, "%s+", ""))
		frame.preview.Entity:SetSkin(GetConVarNumber("cl_playerskin"))
		
		playercolourpreview:SetBackgroundColor(playercolour:GetColor())
		weaponcolourpreview:SetBackgroundColor(weaponcolour:GetColor())
		eyecolourpreview:SetBackgroundColor(eyecolour:GetColor())
		energyColourpreview:SetBackgroundColor(energyColour:GetColor())
		accentColour1preview:SetBackgroundColor(accentColour1:GetColor())
		accentColour2preview:SetBackgroundColor(accentColour2:GetColor())
		
		DRC:RefreshColours(LocalPlayer())
		SetupScene(tbl.Model)
		timer.Simple(0.1, function() RebuildBodygroupTab() end)
		timer.Simple(0.5, function() DRC:RefreshColours(LocalPlayer()) end)
	end
	
	local SaveLoad = vgui.Create("DPanel", tab4)
	SaveLoad:SetSize(tab4:GetWide(), 20)
	SaveLoad:SetPos(0, 0)
	SaveLoad:Dock(TOP)
	SaveLoad:DockMargin(0, 0, 0, 0)
	SaveLoad:SetBackgroundColor(Color(0, 0, 0, 127))
	
	local SaveButton = vgui.Create("DButton", SaveLoad)
	SaveButton:SetSize(tab4:GetWide() / 2, 0)
	SaveButton:Dock(FILL)
	SaveButton:SetText("Save new avatar")

	local DeleteButton = vgui.Create("DButton", SaveLoad)
	DeleteButton:SetSize(tab4:GetWide() / 2, 0)
	DeleteButton:Dock(RIGHT)
	DeleteButton:SetText("[ X ]")
	DeleteButton:SetEnabled(false)
	
	local DeleteBlackout = vgui.Create("DPanel", DeleteButton)
	DeleteBlackout:Dock(FILL)
	DeleteBlackout:SetBackgroundColor(Color(0, 0, 0, 200))
	
	local LoadAvatarButton = vgui.Create("DButton", tab4)
	LoadAvatarButton:Dock(BOTTOM)
	LoadAvatarButton:SetText("Load selected avatar")
	LoadAvatarButton:SetEnabled(false)
	
	local LoadAvatarBlackout = vgui.Create("DPanel", LoadAvatarButton)
	LoadAvatarBlackout:Dock(FILL)
	LoadAvatarBlackout:SetBackgroundColor(Color(0, 0, 0, 200))
	
	LoadAvatarButton.DoClick = function()
		drc_loadedavatarfile = file.Read("Draconic/Avatars/".. SelectedAvatar ..".json", "DATA")
		LoadAvatar()
	end
	
	local function RefreshAvatars()
	
		if SelectedAvatar != nil && IsValid(LoadAvatarBlackout) then
			LoadAvatarBlackout:Remove()
			DeleteBlackout:Remove()
			LoadAvatarButton:SetEnabled(true)
			DeleteButton:SetEnabled(true)
		end
	
		drcMenu_ScrollAvatars = vgui.Create("DScrollPanel", tab4)
		drcMenu_ScrollAvatars:SetSize(tab4:GetWide(), tab4:GetTall())
		drcMenu_ScrollAvatars:SetPos(0, 0)
		drcMenu_ScrollAvatars:Dock(FILL)
		drcMenu_ScrollAvatars:DockMargin(4, 0, 4, 0)
		drcMenu_ScrollAvatars:SetBackgroundColor(Color(32, 32, 32, 255))
	
		local AvatarTable = file.Find("draconic/avatars/*.json", "DATA")
		if table.IsEmpty(AvatarTable) then
			file.CreateDir("Draconic/Avatars/")
			file.Write("Draconic/Avatars/dummyfile.json", "This file exists solely for the Draconic Base to register this directory.")
		end
	
		for k,v in pairs(AvatarTable) do
			if v != "dummyfile.json" then
				local container = vgui.Create("DPanel", drcMenu_ScrollAvatars)
				container:SetSize(drcMenu_ScrollAvatars:GetWide(), 24)
				container:SetPos(0, 0)
				container:Dock(TOP)
				container:DockMargin(0, 0, 0, 1)
				container:SetBackgroundColor(Color(0, 0, 0, 0))
				
				drc_loadedavatarfile = file.Read("Draconic/Avatars/".. v .."", "DATA")
				local tbl = util.JSONToTable(drc_loadedavatarfile)
				
				tbl.Colours = {
					tbl.Colours.Tint2,
					tbl.Colours.Tint1,
					tbl.Colours.Energy,
					tbl.Colours.Eye,
					tbl.Colours.Weapon,
					tbl.Colours.Player,
				}
				
			--[[	for k,v in pairs(tbl.Colours) do
					local collabel = vgui.Create("DPanel", container)
					local colvec = Vector(v)
					collabel:SetSize(40, 20)
					collabel:SetPos( 600 - k * 40, 0)
					collabel:SetBackgroundColor(Color(colvec.x, colvec.y, colvec.z, 255))
				end ]]
				
				local ModelPanel = vgui.Create("DPanel", container)
				ModelPanel:SetSize(230, 24)
				ModelPanel:SetPos(129, 1)
				ModelPanel:SetBackgroundColor(Color(255, 255, 255, 255))
				ModelPanel:Dock(FILL)
				
				local ModelLabel = vgui.Create("DLabel", ModelPanel)
				ModelLabel:SetSize(230, 24)
				ModelLabel:SetPos(0, 0)
				ModelLabel:SetText(tbl.Playermodel)
				ModelLabel:SetContentAlignment(6)
				ModelLabel:SetColor(Color(0, 0, 0, 255))
				ModelLabel:Dock(FILL)
				
				local label = vgui.Create("DButton", container)
				label:SetText(tbl.Name)
				label:SetSize(240, 24)
				if tbl.Name == SelectedAvatar then
					label:SetEnabled(false)
				end
				label.DoClick = function()
					SelectedAvatar = tbl.Name
					label:SetEnabled(false)
					drcMenu_ScrollAvatars:Remove()
					DeleteButton:SetEnabled(true)
					LoadAvatarButton:SetEnabled(true)
					RefreshAvatars()
				end
			end
		end
		AvatarTable = {}
	end
	
	local function DeletePopup()
		local Frame = vgui.Create("DFrame")
		Frame:SetPos(ScrW() / 2, ScrH() / 2)
		Frame:SetTitle("CONFIRMATION")
		Frame:SetSize(250, 80)
		Frame:MakePopup()
		
		local label = vgui.Create("DLabel", Frame)
		label:Dock(TOP)
		label:SetText("Are you sure you want to delete this avatar?")
		label:SetContentAlignment(5)
		
		local cont = vgui.Create("DPanel", Frame)
		cont:Dock(TOP)
		cont:SetBackgroundColor(Color(255, 255, 255, 0))
		
		local DELET = vgui.Create("DButton", cont)
		DELET:Dock(LEFT)
		DELET:SetText("Delete")
		DELET.DoClick = function()
			file.Delete("Draconic/Avatars/".. SelectedAvatar ..".json")
			Frame:Remove()
			SelectedAvatar = nil
			drcMenu_ScrollAvatars:Remove()
			DeleteButton:SetEnabled(false)
			LoadAvatarButton:SetEnabled(false)
			
			timer.Simple(0.1, function()
				RefreshAvatars()
			end)
		end
		
		local CancelCulture = vgui.Create("DButton", cont)
		CancelCulture:Dock(RIGHT)
		CancelCulture:SetText("Cancel")
		CancelCulture.DoClick = function()
			Frame:Remove()
		end
	end
	
	DeleteButton.DoClick = function()
		DeletePopup()
	end
	
	local function SaveAvatar(tbl, ret)
		local colours = tbl.Colours
		local bodygroups = tbl.Bodygroups
		local skin = tbl.Skin
		local name = tbl.Name
		
		if ret == true then return tbl end
		local json = util.TableToJSON(tbl, true)
		file.Write("Draconic/Avatars/".. name ..".json", json)
	end
	
	local function SavePopup()
		local Frame = vgui.Create("DFrame")
		Frame:SetPos(ScrW() / 2 - 300, ScrH() / 2 - 150)
		Frame:SetSize(300, 60)
		Frame:SetTitle("Enter a name for your save.")
		
		local colours = {
			["Player"] = Vector(LocalPlayer():GetInfo("cl_playercolor")) * 255,
			["Weapon"] = Vector(LocalPlayer():GetInfo("cl_weaponcolor")) * 255,
			["Eye"] = Vector(0, 0, 0),
			["Energy"] = Vector(0, 0, 0),
			["Tint1"] = Vector(0, 0, 0),
			["Tint2"] = Vector(0, 0, 0)
		}
		
		colours.Tint1.x = LocalPlayer():GetInfoNum("cl_drc_tint1_r", 127)
		colours.Tint1.y = LocalPlayer():GetInfoNum("cl_drc_tint1_g", 127)
		colours.Tint1.z = LocalPlayer():GetInfoNum("cl_drc_tint1_b", 127)
	
		colours.Tint2.x = LocalPlayer():GetInfoNum("cl_drc_tint2_r", 127)
		colours.Tint2.y = LocalPlayer():GetInfoNum("cl_drc_tint2_g", 127)
		colours.Tint2.z = LocalPlayer():GetInfoNum("cl_drc_tint2_b", 127)
	
		colours.Eye.x = LocalPlayer():GetInfoNum("cl_drc_eyecolour_r", 127)
		colours.Eye.y = LocalPlayer():GetInfoNum("cl_drc_eyecolour_g", 127)
		colours.Eye.z = LocalPlayer():GetInfoNum("cl_drc_eyecolour_b", 127)
		
		colours.Energy.x = LocalPlayer():GetInfoNum("cl_drc_energycolour_r", 127)
		colours.Energy.y = LocalPlayer():GetInfoNum("cl_drc_energycolour_g", 127)
		colours.Energy.z = LocalPlayer():GetInfoNum("cl_drc_energycolour_b", 127)
		
		local vals = {
			["Colours"] = colours,
			["Bodygroups"] = GetConVarString( "cl_playerbodygroups" ),
			["Skin"] = GetConVarString( "cl_playerskin" ),
			["Name"] = nil,
			["Playermodel"] = nil,
			["Model"] = nil
		}
		
		local SaveButton = vgui.Create("DButton", Frame)
		SaveButton:Dock(RIGHT)
		SaveButton:SetEnabled(false)
		SaveButton:SetText("[ Save ]")
		SaveButton.DoClick = function()
			vals.Model = frame.preview:GetModel()
			vals.Playermodel = player_manager.TranslateToPlayerModelName(vals.Model)
			SaveAvatar(vals, false)
			Frame:Remove()
			
			timer.Simple(0.1, function()
				RefreshAvatars()
			end)
		end
		
		local TextBox = vgui.Create("DTextEntry", Frame)
		TextBox:Dock(FILL)
		TextBox:SetTabbingDisabled(true)
		TextBox:SetUpdateOnType(true)
		TextBox.OnValueChange = function()
			local val = TextBox:GetValue()
			vals.Name = val
			
			if val == nil then
				SaveButton:SetEnabled(false)
			elseif file.Exists("Draconic/Avatars/".. val ..".json", "DATA") then
				SaveButton:SetEnabled(false)
				Frame:SetTitle("Save name already in use!")
			else
				SaveButton:SetEnabled(true)
				Frame:SetTitle("Enter a name for your save.")
			end
		end
		
		Frame:MakePopup()
	end
	
	SaveButton.DoClick = function()
		SavePopup()
	end
	
	local AvatarHeader = vgui.Create("DPanel", tab4)
	AvatarHeader:SetPos(0, 0)
	AvatarHeader:Dock(TOP)
	AvatarHeader:SetSize(tab4:GetWide(), 20)
	AvatarHeader:SetBackgroundColor(Color(0, 0, 0, 255))
	
	local AvatarTitleContainer = vgui.Create("DPanel", AvatarHeader)
	AvatarTitleContainer:Dock(FILL)
	AvatarTitleContainer:DockMargin(1, 1, 0, 1)
	AvatarTitleContainer:SetBackgroundColor(Color(255, 255, 255, 255))
	
	local AvatarTitle = vgui.Create("DLabel", AvatarTitleContainer)
	AvatarTitle:SetText("Save name")
	AvatarTitle:Dock(LEFT)
	AvatarTitle:DockMargin(8, 0, 0, 0)
	AvatarTitle:SetColor(Color(0, 0, 0, 255))
	
	local PCPanel = vgui.Create("DPanel", AvatarTitleContainer)
	PCPanel:SetSize(AvatarTitleContainer:GetWide(), 20)
	PCPanel:Dock(FILL)
	local PCLabel = vgui.Create("DLabel", PCPanel)
	PCLabel:SetText("Model name")
	PCLabel:SetSize(AvatarTitleContainer:GetWide(), 20)
	PCLabel:Dock(RIGHT)
	PCLabel:DockMargin(0, 0, 8, 0)
	PCLabel:SetContentAlignment(6)
	PCLabel:SetColor(Color(0, 0, 0, 255))
	
	if Customization == nil then
		for k,v in pairs(tabs:GetItems()) do
			if v.Name == "Saved Avatars" then tabs:CloseTab(v.Tab) end
		end
		tab4:Remove()
	--	GreyOut(tab5.VoiceSetSettings)
		
		if TweakMode == 1 then
		--	tab1PMs:Remove()
			for k,v in pairs(tab1:GetItems()) do
				if v.Name == "Playermodels" then tab1:CloseTab(v.Tab) end
			end
		elseif TweakMode == 2 then
			for k,v in pairs(tab1:GetItems()) do
				if v.Name == "#smwidget.bodygroups" then tab1:CloseTab(v.Tab) end
			end
		elseif TweakMode == 3 then
			for k,v in pairs(tab1:GetItems()) do
				if v.Name == "Colours" then tab1:CloseTab(v.Tab) end
			end
		end
		
		tab1:SetActiveTab(tab1:GetItems()[1].Tab)
	end
	
	RefreshAvatars()
	
	local mt2 = vgui.Create( "DPanel", maintabs )
	mt2:SetBackgroundColor(Color(255, 255, 255, 5))
	maintabs:AddSheet( "Settings & Tools", mt2, "icon16/wrench.png")
	
	local t2frame = vgui.Create("DPanel", mt2)
	t2frame:SetBackgroundColor(Color(255, 255, 255, 5))
	t2frame:Dock(FILL)
	
	local t2tabs = vgui.Create("DPropertySheet", t2frame)
	t2tabs:Dock(FILL)
	t2tabs:SetPadding(0)
	t2tabs.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	
	local controls = vgui.Create( "DPanel", t2tabs)
	controls:Dock(RIGHT)
	controls:SetSize(320)
	controls.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 127))
	end
		
	local CTitle = vgui.Create( "DPanel", controls )
	CTitle:Dock(TOP)
	CTitle:SetSize(320, 50)
	CTitle.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 127))
	end
	
	local controls1 = vgui.Create( "DPanel", controls )
	controls1:Dock(LEFT)
	controls1:SetSize(160)	
	controls1.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 127))
	end
	
	local controls2 = vgui.Create( "DPanel", controls )
	controls2:Dock(LEFT)
	controls2:SetSize(160)
	controls2.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 127))
	end
	
	local ControlsTitle = vgui.Create( "DLabel", CTitle)
	ControlsTitle:SetText("Controls List")
	ControlsTitle:SetSize(1, 50)
	ControlsTitle:Dock(TOP)
	ControlsTitle:SetColor(Color(255, 255, 255, 255))
	ControlsTitle:SetFont("DermaLarge")
	ControlsTitle:SetContentAlignment(4)
	
	local ControlsText = vgui.Create( "DLabel", controls1 )
	ControlsText:Dock(TOP)
	ControlsText:SetSize(1, 160)
	ControlsText:SetText("Primary attack: \nSecondary attack / ironsights: \nReload / Vent: \nReload secondary: \nToggle passive: \nSwitch firemode: \nInspect weapon: \nMelee (guns) / Lunge (melees):")
	ControlsText:SetColor(TextCol)
	ControlsText:SetContentAlignment(4)
	
	local ControlsValue = vgui.Create( "DLabel", controls2 )
	ControlsValue:Dock(TOP)
	ControlsValue:SetSize(1, 160)
	ControlsValue:SetText("".. m1key .."\n".. m2key .."\n".. reloadkey .."\n".. sprintkey .." + ".. reloadkey .."\n".. sprintkey .." + ".. usekey .." + ".. m2key .."\n".. usekey .." + ".. m2key .."\n".. usekey .. " + ".. reloadkey .."\n".. usekey .. " + ".. m1key .."")
	ControlsValue:SetColor(NotifyCol)
	ControlsValue:SetContentAlignment(6)
	
	local t2tab1 = vgui.Create( "DPanel" )
	t2tab1:Dock(FILL)
	t2tab1.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	t2tabs:AddSheet( "Client Settings", t2tab1, "icon16/wrench_orange.png")
	
	local AccessibilityTitle = vgui.Create( "DLabel", t2tab1)
	AccessibilityTitle:SetText("Accessibility")
	AccessibilityTitle:SetSize(200, 50)
	AccessibilityTitle:SetPos(500, -8)
	AccessibilityTitle:SetColor(Color(255, 255, 255, 255))
	AccessibilityTitle:SetFont("DermaLarge")
	AccessibilityTitle:SetContentAlignment(0)
	
	local DrcCrosshairs = vgui.Create( "DCheckBoxLabel", t2tab1 )
	DrcCrosshairs:SetPos(516, 100)
	DrcCrosshairs:SetSize(200, 20)
	DrcCrosshairs:SetText( "I am photosensitive" )
	DrcCrosshairs:SetConVar( "cl_drc_accessibility_photosensitivity_muzzle" )
	DrcCrosshairs.Label:SetColor(TextCol)
	DrcCrosshairs:SetEnabled(true)
	
	MakeHint(t2tab1, 495, 100, "- Dims muzzle flashes from Draconic SWEPs")
	
	local ColourBlindSetting = vgui.Create( "DLabel", t2tab1)
	ColourBlindSetting:SetPos(516, 35)
	ColourBlindSetting:SetSize(100, 20)
	ColourBlindSetting:SetText("Colour Blindness:")
	ColourBlindSetting:SetColor(TextCol)
				
	local ColourBlindCombo = vgui.Create( "DComboBox", t2tab1 )
	ColourBlindCombo:SetSortItems(false)
	ColourBlindCombo:SetPos(600, 35)
	ColourBlindCombo:SetSize(150, 20)
	ColourBlindCombo:SetConVar( "cl_drc_accessibility_colourblind" )
	ColourBlindCombo:AddChoice("None", 1)
	ColourBlindCombo:AddChoice("Protanopia", 2)
	ColourBlindCombo:AddChoice("Protanomaly", 3)
	ColourBlindCombo:AddChoice("Deuteranopia", 4)
	ColourBlindCombo:AddChoice("Deuteranomaly", 5)
	ColourBlindCombo:AddChoice("Tritanopia", 6)
	ColourBlindCombo:AddChoice("Tritanomaly", 7)
	ColourBlindCombo:AddChoice("Achromatopsia", 8)
	ColourBlindCombo:AddChoice("Achromatomaly", 9)
	function ColourBlindCombo:OnSelect(index, value, data)
		RunConsoleCommand("cl_drc_accessibility_colourblind", value)
	end
	
	MakeHint(t2tab1, 495, 35, "This is colour correction intended to make it easier for colourblind/colour-deficient individuals to spot objects/differences that would be plainly visible to others, but not for themselves.\nThis does not 'make everything look normal' for those who use it and should not be considered as such.\n\n** I am not an optician and this is guesswork at best.")
	
	local ColourBlindStrength = vgui.Create( "DNumSlider", t2tab1 )
	ColourBlindStrength:SetPos(516, 55)
	ColourBlindStrength:SetSize(300, 20)
	ColourBlindStrength:SetText( "Col. Blind Filter Strength" )
	ColourBlindStrength.Label:SetColor(TextCol)
	ColourBlindStrength:SetMin( 0 )
	ColourBlindStrength:SetMax( 100 )
	ColourBlindStrength:SetDecimals( 0 )
	ColourBlindStrength:SetConVar( "cl_drc_accessibility_colourblind_strength" )
	ColourBlindStrength:SetEnabled(true)
	
	t2tab1.AMDUser = vgui.Create( "DCheckBoxLabel", t2tab1 )
	t2tab1.AMDUser:SetPos(516, 80)
	t2tab1.AMDUser:SetSize(500, 20)
	t2tab1.AMDUser:SetText( "I am using an AMD Graphics Card" )
	t2tab1.AMDUser:SetConVar( "cl_drc_accessibility_amduser" )
	t2tab1.AMDUser.Label:SetColor(TextCol)
	t2tab1.AMDUser:SetEnabled(true)
	
	MakeHint(t2tab1, 495, 80, "Forces Draconic-Enabled materials to use a fallback cubemap, as AMD cards frequently have maps' envmaps become missing textures.\n\n[ WARNING ] Enabling this is a one-way ticket until you reload, due to limitations of the Source engine.\nAfter the envmap has been changed from a dynamic one, it cannot be changed back.\nIf you are not using an AMD GPU and just messing with settings, leave this OFF.")
	
	--[[
	local DRCSway = vgui.Create( "DCheckBoxLabel", t2tab1 )
	DRCSway:SetPos(516, 100)
	DRCSway:SetSize(500, 20)
	DRCSway:SetText( "I get motion sickness easily" )
	DRCSway:SetConVar( "cl_drc_sway" )
	DRCSway.Label:SetColor(TextCol)
	DRCSway:SetEnabled(true)
	
	MakeHint(t2tab1, 495, 100, "- Turns off scipted bob/sway on Draconic SWEPs") ]]
	
	local SettingsTitle_CL = vgui.Create( "DLabel", t2tab1)
	SettingsTitle_CL:SetText("Client Settings")
	SettingsTitle_CL:SetSize(200, 50)
	SettingsTitle_CL:SetPos(16, -8)
	SettingsTitle_CL:SetColor(Color(255, 255, 255, 255))
	SettingsTitle_CL:SetFont("DermaLarge")
	SettingsTitle_CL:SetContentAlignment(0)
	
	local SettingsSubTitle_CL = vgui.Create( "DLabel", t2tab1)
	SettingsSubTitle_CL:SetText("User Preferences")
	SettingsSubTitle_CL:SetSize(200, 50)
	SettingsSubTitle_CL:SetPos(16, 200)
	SettingsSubTitle_CL:SetColor(Color(255, 255, 255, 255))
	SettingsSubTitle_CL:SetFont("DermaLarge")
	SettingsSubTitle_CL:SetContentAlignment(0)
	
	local DisclaimerSettings = vgui.Create( "DLabel", t2tab1)
	DisclaimerSettings:SetPos(20, 600)
	DisclaimerSettings:SetSize(w2, 20)
	DisclaimerSettings:SetText("* Some settings & preferences can be overridden by server settings.")
	DisclaimerSettings:SetColor(TextCol)
	
	local DrcSoul = vgui.Create( "DCheckBoxLabel", t2tab1 )
	DrcSoul:SetPos(25, 35)
	DrcSoul:SetSize(500, 20)
	DrcSoul:SetText( "Sacrifice your soul to Vuthakral" )
	DrcSoul:SetConVar( "cl_drc_sell_soul" )
	DrcSoul.Label:SetColor(TextCol)
	DrcSoul:SetEnabled(false)
	
	local DrcCrosshairs = vgui.Create( "DCheckBoxLabel", t2tab1 )
	DrcCrosshairs:SetPos(25, 310)
	DrcCrosshairs:SetSize(500, 20)
	DrcCrosshairs:SetText( "Disable crosshairs*" )
	DrcCrosshairs:SetConVar( "cl_drc_disable_crosshairs" )
	DrcCrosshairs.Label:SetColor(TextCol)
	DrcCrosshairs:SetEnabled(true)
	
	local DrcErrorHints = vgui.Create( "DCheckBoxLabel", t2tab1 )
	DrcErrorHints:SetPos(25, 55)
	DrcErrorHints:SetSize(500, 20)
	DrcErrorHints:SetText( "Disable error hints" )
	DrcErrorHints:SetConVar( "cl_drc_disable_errorhints" )
	DrcErrorHints.Label:SetColor(TextCol)
	DrcErrorHints:SetEnabled(true)
	
	local DrcLoweredCrosshair = vgui.Create( "DCheckBoxLabel", t2tab1 )
	DrcLoweredCrosshair:SetPos(25, 330)
	DrcLoweredCrosshair:SetSize(500, 20)
	DrcLoweredCrosshair:SetText( "Enable lowered crosshair on Draconic SWEPs" )
	DrcLoweredCrosshair:SetConVar( "cl_drc_lowered_crosshair" )
	DrcLoweredCrosshair.Label:SetColor(TextCol)
	DrcLoweredCrosshair:SetEnabled(true)
	
	local ChestScale = vgui.Create( "DNumSlider", t2tab1 )
	ChestScale:SetPos(25, 355)
	ChestScale:SetSize(300, 20)
	ChestScale:SetText( "EFP Torso Depth Scale*" )
	ChestScale.Label:SetColor(TextCol)
	ChestScale:SetMin( 0 )
	ChestScale:SetMax( 1 )
	ChestScale:SetDecimals( 4 )
	ChestScale:SetConVar( "cl_drc_experimental_fp_chestscale" )
	ChestScale:SetEnabled(true)
	
	MakeHint(t2tab1, 4, 355, "(Default 1) Scales the torso depth down for Experimental First Person, for playermodels with large geoemtry which can get in the way of aiming.")
	
	local PlayermodelSpawnIconSize = vgui.Create( "DLabel", t2tab1)
	PlayermodelSpawnIconSize:SetPos(25, 400)
	PlayermodelSpawnIconSize:SetSize(200, 20)
	PlayermodelSpawnIconSize:SetText("Playermodel Selector Icon Size:")
	PlayermodelSpawnIconSize:SetColor(TextCol)
				
	local PlayermodelSpawnIconSizeCombo = vgui.Create( "DComboBox", t2tab1 )
	PlayermodelSpawnIconSizeCombo:SetSortItems(false)
	PlayermodelSpawnIconSizeCombo:SetPos(180, 400)
	PlayermodelSpawnIconSizeCombo:SetSize(150, 20)
	PlayermodelSpawnIconSizeCombo:SetConVar( "cl_drc_menu_iconsize" )
	PlayermodelSpawnIconSizeCombo:AddChoice("32x32", 1)
	PlayermodelSpawnIconSizeCombo:AddChoice("48x48", 2)
	PlayermodelSpawnIconSizeCombo:AddChoice("64x64 (default)", 3)
	PlayermodelSpawnIconSizeCombo:AddChoice("96x96", 4)
	PlayermodelSpawnIconSizeCombo:AddChoice("128x128", 5)
	function PlayermodelSpawnIconSizeCombo:OnSelect(index, value, data)
		index = math.Round(index)
		RunConsoleCommand("cl_drc_menu_iconsize", index)
		if !maximized then RefreshIcons(false, index) end
	end
	
	local PlayermodelSpawnIconSizeFullscreen = vgui.Create( "DLabel", t2tab1)
	PlayermodelSpawnIconSizeFullscreen:SetPos(25, 420)
	PlayermodelSpawnIconSizeFullscreen:SetSize(200, 20)
	PlayermodelSpawnIconSizeFullscreen:SetText("Selector Fullscreen Icon Size:")
	PlayermodelSpawnIconSizeFullscreen:SetColor(TextCol)
				
	local PlayermodelSpawnIconSizeComboFullscreen = vgui.Create( "DComboBox", t2tab1 )
	PlayermodelSpawnIconSizeComboFullscreen:SetSortItems(false)
	PlayermodelSpawnIconSizeComboFullscreen:SetPos(180, 420)
	PlayermodelSpawnIconSizeComboFullscreen:SetSize(150, 20)
	PlayermodelSpawnIconSizeComboFullscreen:SetConVar( "cl_drc_menu_iconsize_fullscreen" )
	PlayermodelSpawnIconSizeComboFullscreen:AddChoice("32x32", 1)
	PlayermodelSpawnIconSizeComboFullscreen:AddChoice("48x48", 2)
	PlayermodelSpawnIconSizeComboFullscreen:AddChoice("64x64 (default)", 3)
	PlayermodelSpawnIconSizeComboFullscreen:AddChoice("96x96", 4)
	PlayermodelSpawnIconSizeComboFullscreen:AddChoice("128x128", 5)
	function PlayermodelSpawnIconSizeComboFullscreen:OnSelect(index, value, data)
		index = math.Round(index)
		RunConsoleCommand("cl_drc_menu_iconsize_fullscreen", index)
		if maximized then RefreshIcons(true, index) end
	end
	
	local DrcExperimentalFP = vgui.Create( "DCheckBoxLabel", t2tab1 )
	DrcExperimentalFP:SetPos(25, 75)
	DrcExperimentalFP:SetSize(500, 20)
	DrcExperimentalFP:SetText( "Enable ''Experimental First Person'' mode" )
	DrcExperimentalFP:SetConVar( "cl_drc_experimental_fp" )
	DrcExperimentalFP.Label:SetColor(TextCol)
	DrcExperimentalFP:SetEnabled(true)
	
	MakeHint(t2tab1, 4, 75, "<< Work in Progress Feature >>\n\n''Experimental First Person'' is a true full-body first person camera system which still utilizes the player's viewmodel.\n\nEFP Does:\n> Show your body in first person, accurate to how it is seen in third-person.\n> Show your character's arms when in a vehicle\n> Add a small amount of viewbobbing based on your character's head\n> Still uses the player's viewmodel, allowing you to see your weapon properly as intended by its creators.\n\nEFP Does NOT:\n> Change the aiming angle to match the new camera position (yet)\n\nCurrent known issues:\n> Body desyncs when game is paused in singleplayer")
	
	local VMOX = vgui.Create( "DNumSlider", t2tab1 )
	VMOX:SetPos(25, 240)
	VMOX:SetSize(300, 20)
	VMOX:SetText( "Global viewmodel offset X" )
	VMOX.Label:SetColor(TextCol)
	VMOX:SetMin( -10 )
	VMOX:SetMax( 10 )
	VMOX:SetDecimals( 4 )
	VMOX:SetConVar( "cl_drc_vmoffset_x" )
	VMOX:SetEnabled(true)
	
	local VMOY = vgui.Create( "DNumSlider", t2tab1 )
	VMOY:SetPos(25, 260)
	VMOY:SetSize(300, 20)
	VMOY:SetText( "Global viewmodel offset Y" )
	VMOY.Label:SetColor(TextCol)
	VMOY:SetMin( -10 )
	VMOY:SetMax( 10 )
	VMOY:SetDecimals( 4 )
	VMOY:SetConVar( "cl_drc_vmoffset_y" )
	VMOY:SetEnabled(true)
	
	local VMOZ = vgui.Create( "DNumSlider", t2tab1 )
	VMOZ:SetPos(25, 280)
	VMOZ:SetSize(300, 20)
	VMOZ:SetText( "Global viewmodel offset Y" )
	VMOZ.Label:SetColor(TextCol)
	VMOZ:SetMin( -10 )
	VMOZ:SetMax( 10 )
	VMOZ:SetDecimals( 4 )
	VMOZ:SetConVar( "cl_drc_vmoffset_z" )
	VMOZ:SetEnabled(true)
	
	local t2tab2 = vgui.Create( "DPanel" )
	t2tab2:Dock(FILL)
	t2tab2.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	t2tabs:AddSheet( "Server Settings", t2tab2, "icon16/wrench.png")
	
	local DrcMovement = vgui.Create( "DCheckBoxLabel", t2tab2 )
	DrcMovement:SetPos(25, 15)
	DrcMovement:SetSize(20, 20)
	DrcMovement:SetText( "Draconic SWEP movement speed overrides" )
	DrcMovement:SetConVar( "sv_drc_movement" )
	DrcMovement.Label:SetColor(TextCol)
	
	local DrcMoveSounds = vgui.Create( "DCheckBoxLabel", t2tab2 )
	DrcMoveSounds:SetPos(25, 35)
	DrcMoveSounds:SetSize(20, 20)
	DrcMoveSounds:SetText( "Draconic SWEP movement sounds" )
	DrcMoveSounds:SetConVar( "sv_drc_movesounds" )
	DrcMoveSounds.Label:SetColor(TextCol)
	
	local DrcInspections = vgui.Create( "DCheckBoxLabel", t2tab2 )
	DrcInspections:SetPos(25, 55)
	DrcInspections:SetSize(20, 20)
	DrcInspections:SetText( "Draconic SWEP Inspection Menu" )
	DrcInspections:SetConVar( "sv_drc_inspections" )
	DrcInspections.Label:SetColor(TextCol)
	
	local DrcPassive = vgui.Create( "DCheckBoxLabel", t2tab2 )
	DrcPassive:SetPos(25, 75)
	DrcPassive:SetSize(20, 20)
	DrcPassive:SetText( "Draconic SWEP Passives" )
	DrcPassive:SetConVar( "sv_drc_passives" )
	DrcPassive.Label:SetColor(TextCol)
	
	local SvThirdperson = vgui.Create( "DCheckBoxLabel", t2tab2 )
	SvThirdperson:SetPos(25, 115)
	SvThirdperson:SetSize(20, 20)
	SvThirdperson:SetText( "Disable access to Draconic's thirdperson system" )
	SvThirdperson:SetConVar( "sv_drc_disable_thirdperson" )
	SvThirdperson.Label:SetColor(TextCol)
	
	MakeHint(t2tab2, 4, 115, "Draconic SWEPs which require thirdperson will still use Draconic thirdperson regardless of this setting.")
	
	local SvFreecam = vgui.Create( "DCheckBoxLabel", t2tab2 )
	SvFreecam:SetPos(25, 135)
	SvFreecam:SetSize(20, 20)
	SvFreecam:SetText( "Disable Draconic thirdperson's freecam system globally" )
	SvFreecam:SetConVar( "sv_drc_disable_thirdperson_freelook" )
	SvFreecam.Label:SetColor(TextCol)
	
	t2tab2.SoundStretch = vgui.Create( "DCheckBoxLabel", t2tab2 )
	t2tab2.SoundStretch:SetPos(25, 155)
	t2tab2.SoundStretch:SetSize(20, 20)
	t2tab2.SoundStretch:SetText( "Disable host_timescale sound alteration" )
	t2tab2.SoundStretch:SetConVar( "sv_drc_soundtime_disabled" )
	t2tab2.SoundStretch.Label:SetColor(TextCol)
	
	MakeHint(t2tab2, 4, 135, "Enabling this setting will make it so sounds do not slow down/speed up when host_timescale changes are in effect.")
	
	local DiffSetting = vgui.Create( "DLabel", t2tab2)
	DiffSetting:SetPos(400, 15)
	DiffSetting:SetSize(100, 20)
	DiffSetting:SetText("HL2 Difficulty:")
	DiffSetting:SetColor(TextCol)
	
	local HL2Diff = vgui.Create( "DComboBox", t2tab2 )
	HL2Diff:SetSortItems(false)
	HL2Diff:SetPos(500, 15)
	HL2Diff:SetSize(150, 20)
	HL2Diff:SetConVar( "skill" )
	HL2Diff:AddChoice("Easy", 1)
	HL2Diff:AddChoice("Medium", 2)
	HL2Diff:AddChoice("Hard", 3)
	function HL2Diff:OnSelect(index, value, data)
		LocalPlayer():ConCommand("skill ".. index .."")
	end
	
	local textE = "''Easy'': ".. GetConVarNumber("sk_dmg_inflict_scale1") * 100 .."% damage dealt, ".. GetConVarNumber("sk_dmg_take_scale1") * 100 .."% damage taken."
	local textM = "''Medium'': ".. GetConVarNumber("sk_dmg_inflict_scale2") * 100 .."% damage dealt, ".. GetConVarNumber("sk_dmg_take_scale2") * 100 .."% damage taken."
	local textH = "''Hard'': ".. GetConVarNumber("sk_dmg_inflict_scale3") * 100 .."% damage dealt, ".. GetConVarNumber("sk_dmg_take_scale3") * 100 .."% damage taken."
	
	MakeHint(t2tab2, 378, 17, "".. textE .."\n\n".. textM .."\n\n".. textH .."\n\n\nThis is the actual Half-Life 2 difficulty the game/server is currently set to.\nIt will also affect certain NPC's behaviours.\n\nDEFAULT AND RECOMMENDED IS MEDIUM.")
	
	t2tab2.AmmoSetting = vgui.Create( "DLabel", t2tab2)
	t2tab2.AmmoSetting:SetPos(400, 50)
	t2tab2.AmmoSetting:SetSize(100, 20)
	t2tab2.AmmoSetting:SetText("DRC Infinite Ammo:")
	t2tab2.AmmoSetting:SetColor(TextCol)
	
	t2tab2.InfiniteAmmo = vgui.Create( "DComboBox", t2tab2 )
	t2tab2.InfiniteAmmo:SetSortItems(false)
	t2tab2.InfiniteAmmo:SetPos(500, 50)
	t2tab2.InfiniteAmmo:SetSize(150, 20)
	t2tab2.InfiniteAmmo:SetConVar( "sv_drc_infiniteammo" )
	t2tab2.InfiniteAmmo:AddChoice("Disabled", 0)
	t2tab2.InfiniteAmmo:AddChoice("Enabled", 1)
	t2tab2.InfiniteAmmo:AddChoice("Bottomless Mag", 2)
	function t2tab2.InfiniteAmmo:OnSelect(index, value, data)
		LocalPlayer():ConCommand("sv_drc_infiniteammo ".. index - 1 .."")
	end
	
	MakeHint(t2tab2, 378, 52, "''Enabled'': Weapons need to be reloaded, weapons will overheat; but won't take ammo from your pool.\n\n''Bottomless Mag'': Ammo never depletes, weapons will never overheat.")
	
	t2tab2.SprintSetting = vgui.Create( "DLabel", t2tab2)
	t2tab2.SprintSetting:SetPos(400, 85)
	t2tab2.SprintSetting:SetSize(100, 20)
	t2tab2.SprintSetting:SetText("DRC SWEP Sprint:")
	t2tab2.SprintSetting:SetColor(TextCol)
	
	t2tab2.SprintDropdown = vgui.Create( "DComboBox", t2tab2 )
	t2tab2.SprintDropdown:SetSortItems(false)
	t2tab2.SprintDropdown:SetPos(500, 85)
	t2tab2.SprintDropdown:SetSize(150, 20)
	t2tab2.SprintDropdown:SetConVar( "sv_drc_force_sprint" )
	t2tab2.SprintDropdown:AddChoice("SWEP Default", 0)
	t2tab2.SprintDropdown:AddChoice("Force Passives", 1)
	t2tab2.SprintDropdown:AddChoice("Disable Passives", 2)
	function t2tab2.SprintDropdown:OnSelect(index, value, data)
		LocalPlayer():ConCommand("sv_drc_force_sprint ".. index - 1 .."")
	end
	
	MakeHint(t2tab2, 378, 87, "''SWEP Default'': Passive sprinting will be based on the weapon's settings.\n\n''Force Passives'': Passive sprinting will be forced on all DRC SWEPs.\n\n''Disable Passives'': Passive sprinting will be DISABLED on all DRC SWEPs.")

	local t2tab3 = vgui.Create( "DPanel" )
	t2tab3:Dock(FILL)
	t2tab3.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	t2tabs:AddSheet( "Thirdperson Settings", t2tab3, "icon16/camera.png")
	
	local DrcThirdperson = vgui.Create( "DCheckBoxLabel", t2tab3 )
	DrcThirdperson:SetPos(25, 35)
	DrcThirdperson:SetSize(500, 20)
	DrcThirdperson:SetText( "Enable Draconic Thirdperson*" )
	DrcThirdperson:SetConVar( "cl_drc_thirdperson" )
	DrcThirdperson.Label:SetColor(TextCol)
	DrcThirdperson:SetEnabled(true)
	
	t2tab3.ThirdPersonEditor = vgui.Create("DButton", t2tab3)
	t2tab3.ThirdPersonEditor:SetPos(20, 76)
	t2tab3.ThirdPersonEditor:SetSize(200, 24)
	t2tab3.ThirdPersonEditor:SetEnabled(true)
	t2tab3.ThirdPersonEditor:SetText("Open Thirdperson Editor")
	t2tab3.ThirdPersonEditor.DoClick = function()
		DRC:OpenThirdpersonEditor(ply)
		Derma:Remove()
	end
	
	t2tab3.TPReset = vgui.Create("DButton", t2tab3)
	t2tab3.TPReset:SetPos(20, 106)
	t2tab3.TPReset:SetSize(200, 24)
	t2tab3.TPReset:SetEnabled(true)
	t2tab3.TPReset:SetText("Reset Thirdperson to Default")
	t2tab3.TPReset.DoClick = function()
		DRC:ThirdPersonResetToDefault()
	end
	
	local ThirdpersonPresets = vgui.Create("DPanel", t2tab3)
	ThirdpersonPresets:SetSize(430, 630)
	ThirdpersonPresets:SetPos(440, 0)
	ThirdpersonPresets.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	
	DRC:CreateThirdPersonPresetMenu(ThirdpersonPresets, false)

	local mt3 = vgui.Create( "DPanel", maintabs )
	mt3:SetBackgroundColor(Color(255, 255, 255, 5))
	maintabs:AddSheet( "Credits", mt3, "icon16/text_indent.png")
	
	local infopage = vgui.Create("HTML", mt3)
	infopage:Dock(FILL)
	--infopage:OpenURL("https://www.google.com/")
	infopage:SetHTML( [[
	<html>
		<head>
			<style>
			h2{
				font-family: Verdana;
				color: lightgrey;
				width: auto;
				border-bottom: solid 0.1em rgba(100, 100, 100, 0.5);
				border-right: solid 1em rgba(0, 0, 0, 0);
				margin: 0;
				padding-left: 1em
			}
			
			h3{
				font-family: Verdana;
				margin-left: 1em;
				color: lightgrey;
				margin-bottom: 0;
			}
			h4{
				font-family: Verdana;
				
				color: lightgrey;
				margin: 0;
				margin-left: 2em;
				margin-bottom: 0.5em;
			}
			ul{
				font-family: "Lucida Console";
				color: lightgrey;
				margin-left: 3em;
				margin-top: 0.1em;
				margin-bottom: 0.5em;
			}
			li{
				font-size: 10pt;
				margin-top: 0.1em;
				margin-bottom: 0.1em;
				width: 90vw;
			}
			marquee{
				font-family: Verdana;
				color: lightgrey;
				width: 100vw;
				
				position: fixed;
				bottom: 0;
				margin-bottom: 0;
				margin-top: 10em;
			}
			body{
				width: 100vw;
				height: 100vh;
			}
			.ultitle{
				font-family: "Lucida Console";
				margin-left: 3em;
				margin-top: 0.1em;
				margin-bottom: 0.5em;
				
				color: white;
			}
			</style>
		</head>
		
		<body style="background-color: rgba(11,11,33, 0.7); position: absolute; margin: 0 auto; width: 100vw; height: auto; overflow-x: hidden;">
			<br>
			<h2>Draconic Base</h2>		
			<h3>Credits</h3>
			<h4>Programmming</h4>
				<ul>
					<li><b>Vuthakral</b> - Everything not listed below this credit</li>
					<li><b>Clavus</b> - SWEP Construction Kit code</li>
					<li><b>Kinyom</b> - BSP/Envmap reading function code.</li>
				</ul>
			<h4>Bug testing</h4>
				<ul>
					<li>Dopey, Snowy Snowtime, Valkyries733, Impulse</li>
				</ul>
			<h4>Sounds</h4>
				<ul>
					<li><b>Entropy Zero 2</b> - Ironsight foley sample source. (GO PLAY THIS GAME.)</li>
				</ul>
			<h4>Special Thanks</h4>
				<ul>
					<li>My girlfriend, who has always been there for me even when things are at their worst. If you're reading this, I love you very much.</li>
					<li>The various people of various Discord servers I have to ask for help in every so often.</li>
					<li>Clavus, creator of the "SWEP Construction Kit". Seriously dude, your addon & the standards for SWEPs it set has greatly contributed to the Garry's Mod 13 community & experience. Thank you.</li>
				</ul>
				
			<marquee>If this text is scrolling below 30FPS, you are on Awesomium. If it is scrolling at 60fps or more, you are on Chromium.</marquee>
		</body>
	</html>
	]] )
				
	local mt4 = vgui.Create( "DPanel", maintabs )
	mt4:SetBackgroundColor(Color(255, 255, 255, 10))
	maintabs:AddSheet( "Debug & Dev Tools", mt4, "icon16/folder_bug.png")
	
	local t4tabs = vgui.Create("DPropertySheet", mt4)
	t4tabs:Dock(FILL)
	t4tabs:SetPadding(0)
	t4tabs.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	
	local t4tab1 = vgui.Create( "DPanel" )
	t4tab1:Dock(FILL)
	t4tab1.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	t4tabs:AddSheet( "Debug Information", t4tab1, "icon16/information.png")
	
	local debug_gameinfo = vgui.Create( "DPanel", t4tab1)
	debug_gameinfo:Dock(RIGHT)
	debug_gameinfo:SetSize(320)
	debug_gameinfo.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 127))
	end
		
	local CTitle = vgui.Create( "DPanel", debug_gameinfo )
	CTitle:Dock(TOP)
	CTitle:SetSize(320, 50)
	CTitle.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 127))
	end
	
	local controls1 = vgui.Create( "DPanel", debug_gameinfo )
	controls1:Dock(LEFT)
	controls1:SetSize(160)	
	controls1.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 127))
	end
	
	local controls2 = vgui.Create( "DPanel", debug_gameinfo )
	controls2:Dock(LEFT)
	controls2:SetSize(160)
	controls2.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 127))
	end
	
	local ControlsTitle = vgui.Create( "DLabel", CTitle)
	ControlsTitle:SetText("Session Information")
	ControlsTitle:SetSize(1, 50)
	ControlsTitle:Dock(TOP)
	ControlsTitle:SetColor(Color(255, 255, 255, 255))
	ControlsTitle:SetFont("DermaLarge")
	ControlsTitle:SetContentAlignment(4)
	
	local DebugInfo = vgui.Create( "DLabel", debug_gameinfo)
	DebugInfo:SetPos(15, 37)
	DebugInfo:SetSize(200, 20)
	DebugInfo:SetText("Gamemode: ".. engine.ActiveGamemode() .."")
	DebugInfo:SetColor(TextCol)
	
	local DebugInfo = vgui.Create( "DLabel", debug_gameinfo)
	DebugInfo:SetPos(15, 50)
	DebugInfo:SetSize(200, 20)
	DebugInfo:SetText("Map: ".. game.GetMap() .."")
	DebugInfo:SetColor(TextCol)
	
	local DebugInfo = vgui.Create( "DLabel", debug_gameinfo)
	DebugInfo:SetPos(15, 63)
	DebugInfo:SetSize(200, 20)
		if game.SinglePlayer() then
			DebugInfo:SetText("Type: Singleplayer")
		elseif !game.SinglePlayer() && !game.IsDedicated() then
			DebugInfo:SetText("Type: Local or Multiplayer server")
		end
	DebugInfo:SetColor(TextCol)
	
	local DebugInfo = vgui.Create( "DLabel", debug_gameinfo)
	DebugInfo:SetPos(15, 76)
	DebugInfo:SetSize(200, 20)
	DebugInfo:SetText("Tickrate: ".. math.floor(1/engine.TickInterval()))
	DebugInfo:SetColor(TextCol)
	
	local DebugInfo = vgui.Create( "DLabel", debug_gameinfo)
	DebugInfo:SetPos(5, 110)
	DebugInfo:SetSize(200, 40)
	DebugInfo:SetText("Map Information")
	DebugInfo:SetFont("DermaLarge")
	DebugInfo:SetColor(Color(255, 255, 255, 255))
	
	DRC:CubemapCheck()
--[[	
	local text = "Unverified"
	if drc_badlightmaps[cmap] != nil or drc_singlecubemaps[cmap] != nil then
		text = "Fail"
	elseif drc_verifiedlightmaps[cmap] != nil then
		text = "Verified Pass"
	elseif drc_authorpassedlightmaps[cmap] != nil then
		text = "Author Passed"
	else
		text = "Unverified"
	end


	local DebugInfo = vgui.Create( "DLabel", debug_gameinfo)
	DebugInfo:SetPos(15, 140)
	DebugInfo:SetSize(200, 20)
	DebugInfo:SetText("Cubemaps / Lightmap: ")
	DebugInfo:SetColor(TextCol)
	
	local DebugInfo = vgui.Create( "DLabel", debug_gameinfo)
	DebugInfo:SetPos(130, 140)
	DebugInfo:SetSize(200, 20)
	DebugInfo:SetText(text)
	if text == "Fail" then
		DebugInfo:SetColor(Color(255,0,0,255))
	elseif text == "Verified Pass" or text == "Author Pass" then
		DebugInfo:SetColor(Color(0,255,0,255))
	else
		DebugInfo:SetColor(Color(200,200,200,255))
	end
	
	local DebugInfo = vgui.Create( "DLabel", debug_gameinfo)
	DebugInfo:SetPos(15, 160)
	DebugInfo:SetSize(300, 20)
	
	if drc_badlightmaps[cmap] != nil then
		DebugInfo:SetText("Fail Reason: Bad/Invalid lightmapping method(s).")
	elseif drc_singlecubemaps[cmap] != nil then
		DebugInfo:SetText("Fail Reason: Map has only one cubemap.")
	elseif drc_fullbrightcubemaps[cmap] != nil then
		DebugInfo:SetText("Fail Reason: Maps cubemap(s) are fullbright.")
	else
		DebugInfo:SetText("")
	end
	DebugInfo:SetColor(TextCol)
--]]
	
	local argb = Color(math.Round(DRC.MapInfo.MapAmbient.r*255), math.Round(DRC.MapInfo.MapAmbient.g*255), math.Round(DRC.MapInfo.MapAmbient.b*255), 0)
	local DebugInfo = vgui.Create( "DLabel", debug_gameinfo)
	DebugInfo:SetPos(15, 140)
	DebugInfo:SetSize(300, 20)
	DebugInfo:SetText("Ambient light: ".. argb.r ..", ".. argb.g ..", ".. argb.b .."")
	DebugInfo:SetColor(TextCol)
	
	local DebugInfo = vgui.Create( "DLabel", debug_gameinfo)
	DebugInfo:SetFont("Marlett")
	DebugInfo:SetPos(0, 140)
	DebugInfo:SetSize(50, 20)
	DebugInfo:SetText("g")
	DebugInfo:SetColor(Color(argb.r, argb.g, argb.b, 255))
	
	local versionname = tostring(DRC.MapInfo.Versions[DRC.MapInfo.Version]) or "Unknown"
	
	local DebugInfo = vgui.Create( "DLabel", debug_gameinfo)
	DebugInfo:SetPos(15, 145)
	DebugInfo:SetSize(300, 50)
	DebugInfo:SetText("Compiled for: ".. versionname .." (BSP V".. DRC.MapInfo.Version ..")\nNumber of Envmaps: ".. #drc_cubesamples .."")
	DebugInfo:SetColor(TextCol)
	
	local DebugInfo = vgui.Create( "DLabel", t4tab1)
	ControlsTitle:SetFont("DermaLarge")
	DebugInfo:SetPos(25, 10)
	DebugInfo:SetSize(400, 20)
	DebugInfo:SetText("HDR Support						| Hardware: ".. tostring(render.SupportsHDR()) .." / Map: ".. tostring(render.GetHDREnabled()) .."")
	DebugInfo:SetColor(TextCol)
	
	local gbranch = BRANCH
	if gbranch == "unknown" then gbranch = "Main" end
	local DebugInfo = vgui.Create( "DLabel", t4tab1)
	ControlsTitle:SetFont("DermaLarge")
	DebugInfo:SetPos(5, 620)
	DebugInfo:SetSize(400, 20)
	DebugInfo:SetText("Game branch: ".. gbranch .."")
	DebugInfo:SetColor(TextCol)
	
	local convars = {
		["mat_hdr_level"] = {					1, "HDR Mode", 2, false, "mat_hdr_level\n(Recommended: 2)\n\n0: LDR\n1: LDR + Bloom\n2: HDR"},
		["mat_dxlevel"] = {						2, "DirectX Level", 95, false, "mat_dxlevel\n(Recommended: 95)\nDirectX modes:\n- 80: DX8\n- 81: DX8.1\n- 90: DX9 (Shader Model 2)\n- 95: DX9 (Shader Model 3)\n- 98: DX9 (Xbox 360 comaptibility; DO NOT USE. Runs worse on PC)\n- 100: DX10 (Unknown level of stability)"},
		["r_radiosity"] = {						3, "Radiosity Mode", 3, 3, "r_radiosity\n(Recommended: 3)\nAmbient lighting mode.\n\n0: No ambient lighting\n1: Cheap ambient lighting\n2: Raycasted indirect ambient lighting on everything (accurate, but slow with a lot of lights.)\n3: Raycast on static props, cheap on everything else (slightly inaccurate, but runs well)\n4: Raycast on static props, faked lighting on everything else (highly inaccurate, overbright)."},
		["r_ambientmin"] = {					4, "Ambient Minimum", 0, 0, "r_ambientmin\n(Recommended: 0)\nDefaulted at 0.3, this value will make some dynamic entities inconsistently overbright in darker spaces.\n\nI suspect this is an oversight/bug with Garry's Mod's weird shaders."},
		["mat_picmip"] = {						5, "PicMip", nil, false, "mat_picmip\n-10 to 20\nControls texture resolution display & mipmap fade distance. -10 displays the highest resolution available at all times."},
		["r_lod"] = {							6, "LOD Models", nil, false, "r_lod\n\nControls how close models will drop off in visual quality, if they have LOD (Level of Detail) mesh support.\n\n-1: Automatic (Default)\n0: Highest detail at any distance\n1+: Decreases model quality"},
		["mat_antialias"] = {					7, "Anti-Aliasing", nil, false, "mat_antialias\n0 to 8\nControls the amount, but not type, of antialising employed. Type must be set in your game's settings menu.\nNewer/modern GPUs only support MSAA in Garry's Mod. You're better off setting a post-AA from your GPU's control panel.\n\nIf you are using ReShade or similar, they will not work if you have antialising enabled in Garry's Mod."},
		["mat_viewportscale"] = {				8, "Render Scale", 1, false, "mat_viewportscale\n0 to 1 (Set to 1)\nThis controls the percentage resolution your game will display at."},
		["r_shadows"] = {						9, "Simple Shadows", 1, false, "r_shadows\n0 or 1 (Set to 1)"},
		["r_flashlightdepthtexture"] = {		10, "Projected Shadows", 1, false, "r_flashlightdepthtexture\n0 or 1 (Recommended: 1)\nThe projected textured shadows, like the flashlight and lamp tool."},
		["r_flashlightdepthres"] = {			11, "Shadow Resolution", 2048, false, "r_flashlightdepthres\n0 to 16384 (Recommended: 2048 or higher, but not 16384. Must be in values of 2.)\nThe resolution of projected shadows."},
		["r_projectedtexture_filter"] = {		12, "Shadow Blur", 0.2, true, "r_projectedtexture_filter\n0 to ??? (Recommended: 0.1)\nHigher values will produce blobby, noisy shadows while extremely low values will produce blocky shadows."},
		["r_shadow_allowdynamic"] = {			13, "Dynamic Shadows", 1, false, "r_shadow_allowdynamic\n0 or 1 (Recommended: 1)\nAllows standard shadows to change direction based on the nearest/most relevant light source.\nOnly works on maps explicitly compiled with lights set up for this."},
		["r_shadow_allowbelow"] = {				14, "Dynamic Upward Shadows", 1, false, "r_shadow_allowbelow\n0 or 1 (Recommended: 1)\nAllows standard shadows to be projected above the player, if a light source is below them. (works alongside dynamic shadows)"},
		["mat_filtertextures"] = {				15, "Texture Filtering", 1, false, "mat_filtertextures\nWhy would you even have this turned off?"},
		["mat_forceaniso"] = {					16, "Anisotropic Filtering", 8, false, "mat_forceaniso\n4, 8, or 16.\n16 is recommended, but if your machine cannot handle this or you have a low-resolution monitor, then 8 is just fine."},
		["mat_filterlightmaps"] = {				17, "Lightmap Filtering", 1, false, "mat_filterlightmaps\nWhy would you even have this turned off?"},
		["mat_specular"] = {					18, "Cubemap Reflections", 1, false, "mat_specular\n(Recommended: 1)\nSetting this to 0 does not 'fix' anything, and in some cases can actually break some assets from rendering as intended."},
		["mat_motion_blur_enabled"] = {			19, "Motion Blur", 1, false, "mat_motion_blur_enabled\nSet this to 1.\nIf you want to turn off engine motion blur, set mat_motion_blur_strength to 0.\nTurning it off outright will break a lot of effects for both games & addons which utilize the 4 different types of blur for various effects."},
		["dsp_enhance_stereo"] = {				20, "Dynamic Sound Processing", 1, false, "dsp_enhance_stereo\nSet this to 1.\nEnables the game to perform digital sound processing effects based on 3d space instead of from a flat filter."},
		["snd_mix_async"] = {					21, "Asynchronous Sounds", 0, false, "snd_mix_async\nSet this to 0.\nBackport from newer engine branches, does not support DSP & breaks it, creating monotone audio output.\nShould not be used."},
--		["snd_mixahead"] = {					22, "Asynchronous Mix Time", 0.1, false, "snd_mixahead\nLeave this at its default of 0.1.\nAmount of time (0.1 = 100ms) to dedicate to mixing asynchronous audio.\nSet this too low and audio begins to break, set it too high and audio goes back to synchronous processing."},
		["gmod_mcore_test"] = {					22, "Gmod Multicore", 1, false, "gmod_mcore_test\n0 or 1 (Recommended: 1)\nEnable multicore processing, providing a significant performance increase most of the time."},
		["cl_threaded_bone_setup"] = {			23, "Threaded Bones", 1, false, "cl_threaded_bone_setup\n0 or 1 (Recommended: 1)\nEnable multithreaded processing of gmod-lua bone transformations."},
		["cl_threaded_client_leaf_system"] = {	24, "Threaded VisLeafs", 1, false, "cl_threaded_client_leaf_system\n0 or 1 (Recommended: 1)\nEnable multithreaded processing of visleaf-related computations."},
		["mat_queue_mode"] = {					25, "Threaded Materials", 1, false, "mat_queue_mode\n-1, 0, 1, or 2 (Recommended: 2)\nEnables the following:\n- Multithreaded processing of materials with engine-programming effects such as material proxies.\n- Enables materials being cached for the fist time to be done on multiple threads.\n\n-1: Automatic detection (unreliable)\n0: Synchronus single thread\n1: Single-threaded computation\n2: Multithreaded computation"},
		["r_threaded_particles"] = {			26, "Threaded Particles", 1, false, "r_threaded_particles\n-1, 0 or 1 (Recommended: 1)\nEnable multithreaded processing of particle computations."},
		["r_threaded_client_shadow_manager"] = {27, "Threaded Shadows", 1, false, "r_threaded_client_shadow_manager\n-1, 0 or 1 (Recommended: 1)\nNobody seems to know fully what this does, best guesses are that it's a leftover from old-engine,\nas it has nothing tied to it in SDK 2013+. Everyone turns it to 1 just to be safe with no adverse effect."},
		["r_threaded_renderables"] = {			28, "Threaded Renderables", 1, false, "r_threaded_renderables\n-1, 0 or 1 (Recommended: 1)\nFrom mastercomfig's TF2 configs: ''Asynchronously set up bones on animated entities''."},
		["r_queued_ropes"] = {					29, "Materialized Ropes", 1, false, "r_queued_ropes\n-1, 0 or 1 (Recommended: 1)\nWhen set to 1, this will make the engine treat ropes as materials, offloading their rendering operations to the GPU instead of the CPU."},
		["r_occludermincount"] = {				30, "Minimum Occluders", 1, false, "r_occludermincount\n0 to ??? (Recommended: 1)\nForces the game to always have at least one occlusion cull, preventing stuff from being drawn that otherwise shouldn't be when off-screen."},
	}
	
	for k,v in pairs(convars) do
		local function IsGud(input)
			if v[3] == nil then return nil end
			if input == nil then return nil end
			
			if v[4] != true && v[4] != false then
				if input != v[3] then return false else return true end
			end
			
			if v[4] == false then
				if input < v[3] then return false else return true end
			elseif v[4] then
				if input > v[3] then return false else return true end
			end
		end
	
		t4tab1[k] = vgui.Create("DLabel", t4tab1)
		t4tab1[k]:SetPos(25, 10 + (15*v[1]))
		t4tab1[k]:SetSize(300, 20)
		t4tab1[k]:SetText("".. v[2] .."")
		
		local col = Color(0, 255, 0)
		if !IsGud(GetConVar(k):GetFloat()) then col = Color(255, 0, 0) end
		if IsGud(GetConVar(k):GetFloat()) == nil then col = Color(255, 255, 255) end
		
		local str = "".. k .."_value"
		t4tab1[str] = vgui.Create("DLabel", t4tab1)
		t4tab1[str]:SetPos(160, 10 + (15*v[1]))
		t4tab1[str]:SetSize(300, 20)
		t4tab1[str]:SetText("| ".. math.Round(GetConVar(k):GetFloat(), 2) .."")
		t4tab1[str]:SetColor(col)
		
		MakeHint(t4tab1, 3, 10 + (15*v[1]), v[5])
	end
	
	t4tab1.copy = vgui.Create("DButton", t4tab1)
	t4tab1.copy:SetPos(16, 590)
	t4tab1.copy:SetSize(200, 20)
	t4tab1.copy:SetText("Copy optimal configs to clipboard")
	t4tab1.copy.DoClick = function()
		SetClipboardText("r_radiosity 3\nr_ambientmin 0\nr_shadows 1\nr_flashlightdepthres 8192\nr_flashlightdepthtexture 1\nr_projectedtexture_filter 0.1\nr_shadow_allowdynamic 1\nr_shadow_allowbelow 1\nmat_specular 1\nmat_motion_blur_enabled 1\nmat_motion_blur_strength 0\ndsp_enhance_stereo 1\nsnd_mix_async 0\ngmod_mcore_test 1\ncl_threaded_bone_setup 1\ncl_threaded_client_leaf_system 1\nmat_queue_mode 2\nr_threaded_particles 1\nr_threaded_client_shadow_manager 1\nr_threaded_renderables 1\nr_queued_ropes 1\nr_occludermincount 1")
	end

--[[	
	local col = render.GetLightColor(LocalPlayer():EyePos()) * 255
	local DebugInfo = vgui.Create( "DLabel", t4tab1)
	DebugInfo:SetPos(25, 40)
	DebugInfo:SetSize(300, 20)
	DebugInfo:SetText("Local light level >>	  ".. tostring(col) .."")
	DebugInfo:SetColor(TextCol)
	
	local DebugInfo = vgui.Create( "DLabel", t4tab1)
	DebugInfo:SetFont("Marlett")
	DebugInfo:SetPos(120, 40)
	DebugInfo:SetSize(50, 20)
	DebugInfo:SetText("g")
	DebugInfo:SetColor(Color(col.x, col.y, col.z, 255))
	]]
	
	local t4tab2 = vgui.Create( "DPanel" )
	t4tab2:Dock(FILL)
	t4tab2.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	t4tabs:AddSheet( "Development Tools", t4tab2, "icon16/bomb.png")
	
	local t4tab2panel_left = vgui.Create("DPanel", t4tab2)
	t4tab2panel_left:Dock(FILL)
	t4tab2panel_left.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	
	t4tab2panel_left.DRCTitle = vgui.Create( "DLabel", t4tab2panel_left)
	t4tab2panel_left.DRCTitle:SetText("DRC Debug Tools")
	t4tab2panel_left.DRCTitle:SetSize(300, 50)
	t4tab2panel_left.DRCTitle:SetPos(16, -8)
	t4tab2panel_left.DRCTitle:SetColor(Color(255, 255, 255, 255))
	t4tab2panel_left.DRCTitle:SetFont("DermaLarge")
	t4tab2panel_left.DRCTitle:SetContentAlignment(0)
	
	local DebugSetting = vgui.Create( "DCheckBoxLabel", t4tab2panel_left )
	DebugSetting:SetPos(25, 35)
	DebugSetting:SetSize(500, 20)
	DebugSetting:SetText( "Debug mode enabled (Requires sv_drc_allowdebug 1)" )
	DebugSetting:SetConVar( "cl_drc_debugmode" )
	DebugSetting.Label:SetColor(TextCol)
	DebugSetting:SetEnabled(true)
	
	local DebugSetting = vgui.Create( "DCheckBoxLabel", t4tab2panel_left )
	DebugSetting:SetPos(25, 55)
	DebugSetting:SetSize(500, 20)
	DebugSetting:SetText( "Legacy ''DSB Debug Assistant''" )
	DebugSetting:SetConVar( "cl_drc_debug_legacyassistant" )
	DebugSetting.Label:SetColor(TextCol)
	DebugSetting:SetEnabled(true)
	
	MakeHint(t4tab2panel_left, 200, 55, "The OG debugging UI to display debug info.\nI just don't have the heart to remove it.")
	
	local DebugSetting = vgui.Create( "DCheckBoxLabel", t4tab2panel_left )
	DebugSetting:SetPos(25, 75)
	DebugSetting:SetSize(500, 20)
	DebugSetting:SetText( "Invert near/far sound effects" )
	DebugSetting:SetConVar( "cl_drc_debug_invertnearfar" )
	DebugSetting.Label:SetColor(TextCol)
	DebugSetting:SetEnabled(true)
	
	local DebugSetting = vgui.Create( "DCheckBoxLabel", t4tab2panel_left )
	DebugSetting:SetPos(25, 95)
	DebugSetting:SetSize(500, 20)
	DebugSetting:SetText( "Show viewmodel attachments" )
	DebugSetting:SetConVar( "cl_drc_debug_vmattachments" )
	DebugSetting.Label:SetColor(TextCol)
	DebugSetting:SetEnabled(true)
	
	t4tab2panel_left.Hitboxes = vgui.Create( "DCheckBoxLabel", t4tab2panel_left )
	t4tab2panel_left.Hitboxes:SetPos(25, 115)
	t4tab2panel_left.Hitboxes:SetSize(500, 20)
	t4tab2panel_left.Hitboxes:SetText( "Hitbox Renderer" )
	t4tab2panel_left.Hitboxes:SetConVar( "cl_drc_debug_hitboxes" )
	t4tab2panel_left.Hitboxes.Label:SetColor(TextCol)
	t4tab2panel_left.Hitboxes:SetEnabled(true)
	
	MakeHint(t4tab2panel_left, 150, 115, "Continuously renders your own hitboxes while not in first person.\nAlso renders hitboxes of whatever you are looking at.")
	
	t4tab2panel_left.Tracelines = vgui.Create( "DCheckBoxLabel", t4tab2panel_left )
	t4tab2panel_left.Tracelines:SetPos(25, 135)
	t4tab2panel_left.Tracelines:SetSize(500, 20)
	t4tab2panel_left.Tracelines:SetText( "TraceLine Renderer" )
	t4tab2panel_left.Tracelines:SetConVar( "cl_drc_debug_tracelines" )
	t4tab2panel_left.Tracelines.Label:SetColor(TextCol)
	t4tab2panel_left.Tracelines:SetEnabled(true)
	
	MakeHint(t4tab2panel_left, 150, 135, "Renders TraceLines used by the Draconic Base.\nServer-sided traces will only render in singleplayer.\n\nWhite = Undefined/generic\nRed = Harmful hit connection\nYellow = DRC:TraceDir() trace.\nBlue = DRC:FloorDist() trace.")
	
	t4tab2panel_left.Lights = vgui.Create( "DCheckBoxLabel", t4tab2panel_left )
	t4tab2panel_left.Lights:SetPos(25, 155)
	t4tab2panel_left.Lights:SetSize(500, 20)
	t4tab2panel_left.Lights:SetText( "Light Visualizer" )
	t4tab2panel_left.Lights:SetConVar( "cl_drc_debug_lights" )
	t4tab2panel_left.Lights.Label:SetColor(TextCol)
	t4tab2panel_left.Lights:SetEnabled(true)
	
	MakeHint(t4tab2panel_left, 150, 155, "Visualizes lights created by the Draconic Base.\nThe outer circle shows the radius of the light.")
	
	t4tab2panel_left.CubemapRenderer = vgui.Create( "DCheckBoxLabel", t4tab2panel_left )
	t4tab2panel_left.CubemapRenderer:SetPos(25, 175)
	t4tab2panel_left.CubemapRenderer:SetSize(500, 20)
	t4tab2panel_left.CubemapRenderer:SetText( "Cubemap Renderer" )
	t4tab2panel_left.CubemapRenderer:SetConVar( "cl_drc_debug_cubemaps" )
	t4tab2panel_left.CubemapRenderer.Label:SetColor(TextCol)
	t4tab2panel_left.CubemapRenderer:SetEnabled(true)
	
	MakeHint(t4tab2panel_left, 150, 175, "Renders env_cubemap entities.")
	
	t4tab2panel_left.BoundingBoxes = vgui.Create( "DCheckBoxLabel", t4tab2panel_left )
	t4tab2panel_left.BoundingBoxes:SetPos(25, 195)
	t4tab2panel_left.BoundingBoxes:SetSize(500, 20)
	t4tab2panel_left.BoundingBoxes:SetText( "Bounds Renderer" )
	t4tab2panel_left.BoundingBoxes:SetConVar( "cl_drc_debug_bounds" )
	t4tab2panel_left.BoundingBoxes.Label:SetColor(TextCol)
	t4tab2panel_left.BoundingBoxes:SetEnabled(true)
	
	MakeHint(t4tab2panel_left, 150, 195, "Continuously renders your own collision (yellow) & render (purple) bounds while not in first person.\nAlso renders bounds of whatever you are looking at.")
	
	t4tab2panel_left.CubeFallback = vgui.Create( "DCheckBoxLabel", t4tab2panel_left )
	t4tab2panel_left.CubeFallback:SetPos(25, 215)
	t4tab2panel_left.CubeFallback:SetSize(500, 20)
	t4tab2panel_left.CubeFallback:SetText( "Cubemap fallbacks" )
	t4tab2panel_left.CubeFallback:SetConVar( "cl_drc_debug_cubefallbacks" )
	t4tab2panel_left.CubeFallback.Label:SetColor(TextCol)
	t4tab2panel_left.CubeFallback:SetEnabled(true)
	
	MakeHint(t4tab2panel_left, 150, 215, "Forces Draconic Base ''ReflectionTint'' proxies to act as if the current map has no envmaps, using their fallback settings.")
	
	t4tab2panel_left.HideShaderFixes = vgui.Create( "DCheckBoxLabel", t4tab2panel_left )
	t4tab2panel_left.HideShaderFixes:SetPos(25, 235)
	t4tab2panel_left.HideShaderFixes:SetSize(500, 20)
	t4tab2panel_left.HideShaderFixes:SetText( "Hide ''fixers''" )
	t4tab2panel_left.HideShaderFixes:SetConVar( "cl_drc_debug_hideshaderfixes" )
	t4tab2panel_left.HideShaderFixes.Label:SetColor(TextCol)
	t4tab2panel_left.HideShaderFixes:SetEnabled(true)
	
	MakeHint(t4tab2panel_left, 150, 235, "Hides the effects of all ReflectionTint and ScalingRimLight material proxies, showing what assets would look like without them.")
	
	t4tab2panel_left.SourceTitle = vgui.Create( "DLabel", t4tab2panel_left)
	t4tab2panel_left.SourceTitle:SetText("Source Debug Tools")
	t4tab2panel_left.SourceTitle:SetSize(300, 50)
	t4tab2panel_left.SourceTitle:SetPos(500, -8)
	t4tab2panel_left.SourceTitle:SetColor(Color(255, 255, 255, 255))
	t4tab2panel_left.SourceTitle:SetFont("DermaLarge")
	t4tab2panel_left.SourceTitle:SetContentAlignment(0)
	
	t4tab2panel_left.DrawPortals = vgui.Create( "DCheckBoxLabel", t4tab2panel_left )
	t4tab2panel_left.DrawPortals:SetPos(516, 35)
	t4tab2panel_left.DrawPortals:SetSize(500, 20)
	t4tab2panel_left.DrawPortals:SetText( "Draw Portals (r_DrawPortals)" )
	t4tab2panel_left.DrawPortals:SetConVar( "r_DrawPortals" )
	t4tab2panel_left.DrawPortals.Label:SetColor(TextCol)
	t4tab2panel_left.DrawPortals:SetEnabled(true)
	
	t4tab2panel_left.DrawBrushes = vgui.Create( "DCheckBoxLabel", t4tab2panel_left )
	t4tab2panel_left.DrawBrushes:SetPos(516, 55)
	t4tab2panel_left.DrawBrushes:SetSize(500, 20)
	t4tab2panel_left.DrawBrushes:SetText( "Draw Clips (r_drawclipbrushes)" )
	t4tab2panel_left.DrawBrushes:SetConVar( "r_drawclipbrushes" )
	t4tab2panel_left.DrawBrushes.Label:SetColor(TextCol)
	t4tab2panel_left.DrawBrushes:SetEnabled(true)
	
	t4tab2panel_left.DrawEntityMessages = vgui.Create( "DCheckBoxLabel", t4tab2panel_left )
	t4tab2panel_left.DrawEntityMessages:SetPos(516, 75)
	t4tab2panel_left.DrawEntityMessages:SetSize(500, 20)
	t4tab2panel_left.DrawEntityMessages:SetText( "Draw Entity Messages (ent_messages_draw)" )
	t4tab2panel_left.DrawEntityMessages:SetConVar( "ent_messages_draw" )
	t4tab2panel_left.DrawEntityMessages.Label:SetColor(TextCol)
	t4tab2panel_left.DrawEntityMessages:SetEnabled(true)
	
	t4tab2panel_left.DrawLightInfo = vgui.Create( "DCheckBoxLabel", t4tab2panel_left )
	t4tab2panel_left.DrawLightInfo:SetPos(516, 95)
	t4tab2panel_left.DrawLightInfo:SetSize(500, 20)
	t4tab2panel_left.DrawLightInfo:SetText( "Draw Light Info (r_drawlightinfo)" )
	t4tab2panel_left.DrawLightInfo:SetConVar( "r_drawlightinfo" )
	t4tab2panel_left.DrawLightInfo.Label:SetColor(TextCol)
	t4tab2panel_left.DrawLightInfo:SetEnabled(true)
	
	t4tab2panel_left.DrawLightInfo = vgui.Create( "DCheckBoxLabel", t4tab2panel_left )
	t4tab2panel_left.DrawLightInfo:SetPos(516, 115)
	t4tab2panel_left.DrawLightInfo:SetSize(500, 20)
	t4tab2panel_left.DrawLightInfo:SetText( "Draw Render Bounds (r_drawrenderboxes)" )
	t4tab2panel_left.DrawLightInfo:SetConVar( "r_drawrenderboxes" )
	t4tab2panel_left.DrawLightInfo.Label:SetColor(TextCol)
	t4tab2panel_left.DrawLightInfo:SetEnabled(true)
	
	t4tab2panel_left.DrawLightInfo = vgui.Create( "DCheckBoxLabel", t4tab2panel_left )
	t4tab2panel_left.DrawLightInfo:SetPos(516, 135)
	t4tab2panel_left.DrawLightInfo:SetSize(500, 20)
	t4tab2panel_left.DrawLightInfo:SetText( "Draw Soundscapes (soundscape_debug)" )
	t4tab2panel_left.DrawLightInfo:SetConVar( "soundscape_debug" )
	t4tab2panel_left.DrawLightInfo.Label:SetColor(TextCol)
	t4tab2panel_left.DrawLightInfo:SetEnabled(true)
	
	local DebugSetting = vgui.Create( "DLabel", t4tab2panel_left)
	ControlsTitle:SetFont("DermaLarge")
	DebugSetting:SetPos(20, 600)
	DebugSetting:SetSize(100, 20)
	DebugSetting:SetText("Debug Crosshair:")
	DebugSetting:SetColor(TextCol)
	
	local DebugCrosshair = vgui.Create( "DComboBox", t4tab2panel_left )
	DebugCrosshair:SetSortItems(false)
	DebugCrosshair:SetPos(120, 600)
	DebugCrosshair:SetSize(150, 20)
	DebugCrosshair:SetConVar( "cl_drc_debug_crosshairmode" )
	DebugCrosshair:AddChoice("Disabled", 0)
	DebugCrosshair:AddChoice("Standard", 1)
	DebugCrosshair:AddChoice("Melee travel only", 2)
	DebugCrosshair:AddChoice("Full", 3)
	function DebugCrosshair:OnSelect(index, value, data)
		RunConsoleCommand("cl_drc_debug_crosshairmode", index - 1)
	end
	
	if LocalPlayer():IsAdmin() then
		local t4tab2panel_right = vgui.Create("DPanel", t4tab2)
		t4tab2panel_right:Dock(RIGHT)
		t4tab2panel_right:SetSize(320)
		t4tab2panel_right.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, 400, h, Color(0, 0, 0, 255))
		end
		
		local DevTitle = vgui.Create( "DLabel", t4tab2panel_right)
		DevTitle:SetText("Dev Tools")
		DevTitle:SetSize(1, 50)
		DevTitle:Dock(TOP)
		DevTitle:SetColor(Color(255, 255, 255, 255))
		DevTitle:SetFont("DermaLarge")
		DevTitle:SetContentAlignment(4)
		
		local function FadeWhite()
			LocalPlayer():ScreenFade(SCREENFADE.IN, Color(255, 255, 255), 3, 0)
		end
		
		local function Yeet()
		--	surface.PlaySound("")
			net.Start("DRC_Nuke")
			net.WriteEntity(LocalPlayer())
			net.SendToServer()
		end
		
		local function SoftYeet()
		--	surface.PlaySound("draconic/NOW.ogg")
			net.Start("DRC_KYS")
			net.WriteEntity(LocalPlayer())
			net.SendToServer()
		end
		
		local nukemap = vgui.Create("DButton", t4tab2panel_right)
		nukemap:SetText("Nuke Map (Kills NPCs & breaks props)")
		nukemap:Dock(TOP)
		nukemap.DoClick = function()
			nukemap:SetEnabled(false)
			Yeet()
			Derma:Remove()
		end
		
		local lowtier = vgui.Create("DButton", t4tab2panel_right)
		lowtier:SetText("Kill & remove all NPCs & NextBots")
		lowtier:Dock(TOP)
		lowtier.DoClick = function()
			lowtier:SetEnabled(false)
			SoftYeet()
			Derma:Remove()
		end
		
		local function SpawnThatShit()
			LocalPlayer():ConCommand("drc_debug_spawnweaponmodel")
		end
		
		if game.SinglePlayer() then
			local spawnworldmodel = vgui.Create("DButton", t4tab2panel_right)
			spawnworldmodel:SetText("Spawn weapon worldmodel (drc_debug_spawnweaponmodel)")
			spawnworldmodel:Dock(TOP)
			spawnworldmodel.DoClick = function()
				SpawnThatShit()
			end
		end
	end
	
	local t4tab3 = vgui.Create( "DPanel" )
	t4tab2:Dock(FILL)
	t4tab2.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	t4tabs:AddSheet( "Draconic Wiki", t4tab3, "icon16/book_link.png")
	
	local wiki = vgui.Create("DHTML", t4tab3)
	wiki:Dock(FILL)
	wiki:SetAllowLua(false)
	wiki:SetScrollbars(true)
	
	
	function t4tabs:OnActiveTabChanged(old, new)
		local mode = new:GetText()
		if mode == "Draconic Wiki" then wiki:OpenURL("http://vuthakral.com/draconic") end
	end
	
end