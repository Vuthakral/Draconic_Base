function DRCMenu( player )
    local ply = player
	local VSelection = ply:GetNWString("DRCVoiceSet")
    
	local usekey = string.upper(ReturnKey("+use"))
	local m1key = string.upper(ReturnKey("+attack"))
	local m2key = string.upper(ReturnKey("+attack2"))
	local m3key = string.upper(ReturnKey("+attack3"))
	local sprintkey = string.upper(ReturnKey("+speed"))
	local duckkey = string.upper(ReturnKey("+duck"))
	local jumpkey = string.upper(ReturnKey("+jump"))
	local reloadkey = string.upper(ReturnKey("+reload"))
	local forwkey = string.upper(ReturnKey("+forward"))
	local alt1key = string.upper(ReturnKey("+alt1"))
	local alt2key = string.upper(ReturnKey("+alt2"))
	
    local w2 = ScrW()/2 
    local leftwide = w2
    local leftwidehalf = leftwide / 2
 	      	      	         
    local h2 = ScrH()
    local topwide = h2
    local topwidehalf = topwide / 2
	
	local TextCol = Color(220, 220, 220, 255)
	local SubtextCol = Color(170, 170, 170, 255)
	local NotifyCol = Color(255, 255, 255, 255)
	
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
    Derma:SetPos( leftwidehalf/1.25, topwidehalf/4 )
    Derma:SetSize( 1200, 720)
    Derma:SetTitle("Draconic Menu")
	Derma:SetIcon("icon16/draconic_base.png")
	Derma:MakePopup()
	Derma:SetBackgroundBlur(true)
	Derma:SetScreenLock(false)
    Derma.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))
    end
	
	local windowwide = Derma:GetWide()
	local windowtall = Derma:GetTall()
	
	local mainframe = vgui.Create("DPanel", Derma)
	mainframe:Dock(FILL)
	mainframe:DockMargin(0, 0, 0, 0)
	mainframe:DockPadding(0, 0, 0, 0)
	mainframe:SetPaintBackground(false)
	
	local maintabs = vgui.Create( "DPropertySheet", mainframe )
	maintabs:Dock(FILL)
	maintabs:DockMargin(0, 0, 0, 0)
	maintabs:DockPadding(0, 0, 0, 0)
	maintabs:SetPadding(0)
	maintabs.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
	
	local mt1 = vgui.Create( "DPanel", maintabs )
	mt1:DockMargin(0, 0, 0, 0)
	mt1:DockPadding(0, 0, 0, 0)
	mt1:SetBackgroundColor(Color(255, 255, 255, 0))
	maintabs:AddSheet( "Player Representation", mt1, "icon16/user.png")
    
    local frame = vgui.Create("DPanel", mt1)
	frame:SetSize(590, 658)
	frame:Dock(LEFT)
	frame:DockPadding(0, 0, 0, 0)
--    frame:SetSize(512, topwide/1.5-24)
    frame:SetBackgroundColor(Color(255, 255, 255, 5))
	
	local frame2 = vgui.Create("DPanel", mt1)
	frame2:SetPos(windowwide/2, 0)
	frame2:SetWide(windowwide/2)
	frame2:Dock(RIGHT)
	frame2:DockPadding(0, 0, 0, 0)
--	frame2:SetSize(leftwide*1.25/2, topwide/1.5-54)
	frame2:SetBackgroundColor(Color(255, 255, 255, 15))
    
	local MapAmbient = render.GetAmbientLightColor() * 255
	MapAmbient.r = math.Clamp(MapAmbient.r, 35, 255)
	MapAmbient.g = math.Clamp(MapAmbient.g, 35, 255)
	MapAmbient.b = math.Clamp(MapAmbient.b, 35, 255)
	local LocalAmbient = render.GetLightColor(LocalPlayer():EyePos()) * 255
	local PreviewAmbient = Color((MapAmbient.r + LocalAmbient.r), (MapAmbient.g + LocalAmbient.g), (MapAmbient.b + LocalAmbient.b), 255)
	
	local bg = vgui.Create("DImage", frame)
	bg:SetPos(0, 0)
	bg:Dock(FILL)
	bg:SetSize(589, 658)
	bg:SetImage("vgui/drc_playerbg")
	bg:SetZPos(-10)
	
	frame.tools = vgui.Create("DPanel", frame)
	frame.tools:SetSize(589,658)
	frame.tools:Dock(FILL)
	frame.tools:SetVisible(false)
	frame.tools:SetEnabled(false)
	frame.tools:SetBackgroundColor(Color(0,0,0,0))
	
	--local pmodel = LocalPlayer():GetInfo( "cl_playermodel" )
	--local pmodelname = player_manager.TranslatePlayerModel( pmodel )
	local pmodelname = LocalPlayer():GetModel()
	
	if DRC:GetCustomizationAllowed() != true then pmodelname = LocalPlayer():GetModel() end
	
    frame.preview = vgui.Create("DAdjustableModelPanel", frame)
	frame.preview:SetSize(589,658)
    frame.preview:SetPos(0, 0)
    frame.preview:SetFOV(47)
	frame.preview:SetModel(tostring(pmodelname))
	frame.preview:SetAnimated( true )
    frame.preview:SetAnimationEnabled(true)
	frame.preview:SetAmbientLight(Color(MapAmbient.r, MapAmbient.g, MapAmbient.b))
	frame.preview:SetDirectionalLight(BOX_TOP, Color(MapAmbient.r, MapAmbient.g, MapAmbient.b))
	frame.preview:SetLookAng(Angle(10.278, 203.334, 0))
	frame.preview:SetCamPos(Vector(80.69, 36.7, 52.02))
	
	function frame.preview:LayoutEntity( ent )
		ent:SetLOD(0)
		frame.preview:SetFOV(math.Clamp(frame.preview:GetFOV(), 10, 100))
		local idle = ent:SelectWeightedSequence(ACT_HL2MP_IDLE)
		if ent:LookupSequence("drc_menu") != -1 then
			ent:SetSequence("drc_menu")
		elseif ent:LookupSequence("drc_menu_xdr_default") != -1 then
			ent:SetSequence("drc_menu_xdr_default")
		else
			ent:SetSequence(idle)	
		end
		
		ent.BGNum = 0
		for k,v in pairs(ent:GetBodyGroups()) do
			ent.BGNum = ent.BGNum + v.num
		end
		local pos = frame.preview:GetCamPos()
		local ang = frame.preview:GetLookAng()
		if frame.tools.bgs then frame.tools.bgs:SetText("Bodygroups: ".. ent.BGNum .."") end
		if frame.tools.skins then frame.tools.skins:SetText("Skins: ".. ent:SkinCount() .."") end
		if frame.tools.mats then frame.tools.mats:SetText("Materials: ".. #ent:GetMaterials() .."") end
		if frame.tools.bones then frame.tools.bones:SetText("Bones: ".. ent:GetBoneCount() .."") end
		if frame.tools.pos then frame.tools.pos:SetText("Cam Position: "..math.Round(pos.x, 2)..", ".. math.Round(pos.y, 2)..", ".. math.Round(pos.z, 2) .."") end
		if frame.tools.ang then frame.tools.ang:SetText("Cam Angle: "..math.Round(ang.x, 2)..", ".. math.Round(ang.y, 2)..", ".. math.Round(ang.z, 2) .."") end
		if frame.tools.fov then frame.tools.fov:SetText("FOV: ".. math.Round(frame.preview:GetFOV(), 2) .."") end
		
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
    end
	
	local bottompanel = vgui.Create("DPanel", frame.preview)
	bottompanel:SetPos(0,frame.preview:GetTall() - 50)
	bottompanel:SetSize(frame.preview:GetWide(), 50)
	bottompanel:SetBackgroundColor(Color(0, 0, 0, 50))
	
	local applybutton = vgui.Create("DButton", bottompanel)
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
	
	local hint = vgui.Create("DButton", frame)
	hint:SetText("Controls")
	hint:SetPos(frame.preview:GetWide() - 80,frame.preview:GetTall() - 42)
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
			frame.tools,
			bottompanel.copy,
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
				frame.tools,
				bottompanel.copy,
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
	bottompanel.copy:SetSize(128,16)
	bottompanel.copy:SetPos(64,bottompanel:GetTall() - 40)
	bottompanel.copy:SetText("Copy model path")
	bottompanel.copy:SetTooltip("Copies current model path to clipboard.")
	bottompanel.copy:SetEnabled(false)
	bottompanel.copy:SetVisible(false)
	
	function bottompanel.copy:DoClick()
		bottompanel.copy:SetText("Copied!")
		SetClipboardText(frame.preview:GetModel())
		timer.Simple(1, function() bottompanel.copy:SetText("Copy model path") end)
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
	tabs:AddSheet( "Player", tab1, "icon16/user.png")
	tab1.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
	function tab1:OnActiveTabChanged(old, new)
		local mode = new:GetText()
	end
	
	local tab1PMs = vgui.Create( "DPanel", tab1 )
	tab1PMs:DockPadding(0, 0, 0, 0)
	tab1PMs:SetBackgroundColor( Color(245, 245, 245, 0) )
	tab1:AddSheet( "Playermodels", tab1PMs, "icon16/folder_user.png")
	
	tab1.tab1Hands = vgui.Create( "DPanel", tab1 )
	tab1.tab1Hands:DockPadding(0, 0, 0, 0)
	tab1.tab1Hands:SetBackgroundColor( Color(245, 245, 245, 0) )
	tab1:AddSheet( "Hands", tab1.tab1Hands, "icon16/folder_page.png")
				
	local tab2 = vgui.Create( "DPanel", tabs )
	tab2:SetBackgroundColor( Color(255, 255, 255, 255) )
	tabs:AddSheet( "Colours", tab2, "icon16/color_wheel.png" )
	
	local t3c = vgui.Create( "DPanel", tabs )
	t3c:SetBackgroundColor( Color(0, 0, 0, 0) )
	t3c:SetPos(-200, 0)
	
	local t3p = t3c:Add( "DPanelList" )
	t3p:DockPadding( 64, 8, 8, 8 )
	t3p:EnableVerticalScrollbar( true )
	t3p:Dock(FILL)
	
	local tab3 = tabs:AddSheet( "#smwidget.bodygroups", t3p, "icon16/cog.png" )
	
	local modelListPnl = tab1PMs:Add( "DPanel" )
	modelListPnl:DockPadding( 8, 0, 8, 0 )
	modelListPnl:Dock(FILL)
	modelListPnl:SetBackgroundColor(Color(0, 0, 0, 0))
	
	local SearchBar = modelListPnl:Add( "DTextEntry" )
	SearchBar:Dock( TOP )
	SearchBar:DockMargin( 0, 0, 0, 0 )
	SearchBar:SetUpdateOnType( true )
	SearchBar:SetPlaceholderText( "#spawnmenu.quick_filter" )
	
	local PanelSelect = modelListPnl:Add( "DPanelSelect" )
	PanelSelect:Dock(FILL)
	PanelSelect:SetBackgroundColor(Color(0, 0, 0, 0))
	PanelSelect.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
	
	local arms = {
		["c_"] = "c_",
		["v_"] = "v_",  -- IT SHOULD BE C_ YOU IDIOTS, V IS VIEW, C IS CLIENT. THESE ARE NOT VIEWMODELS, THEY ARE "CLIENT ARMS". AAAAAAAAAAAAAAAA-
		["viewhands"] = "viewhands" -- I HATE YOU.
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
		
		local PanelSelect_Hands = modelListPnl_Hands:Add( "DPanelSelect" )
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
	
    local ScrollPrim = vgui.Create("DScrollPanel", tab2)
	ScrollPrim:SetPos(0, 0)
	ScrollPrim:Dock(FILL)
	ScrollPrim:DockMargin(0, 0, 16, 16)
	ScrollPrim:SetBackgroundColor(Color(255, 255, 255, 0))
	
	local row1 = vgui.Create("DPanel", ScrollPrim)
	row1:Dock(TOP)
	row1:DockMargin(8, 8, 0, 0)
	row1:SetSize(windowwide/2, windowtall/3.75 )
	row1:SetBackgroundColor(Color(255, 255, 255, 0))
	
	local row2 = vgui.Create("DPanel", ScrollPrim)
	row2:Dock(TOP)
	row2:DockMargin(8, 8, 0, 0)
	row2:SetSize(windowwide/2, windowtall/3.75 )
	row2:SetBackgroundColor(Color(255, 255, 255, 0))
	
	local row3 = vgui.Create("DPanel", ScrollPrim)
	row3:Dock(TOP)
	row3:DockMargin(8, 8, 0, 0)
	row3:SetSize(windowwide/2, windowtall/3.75 )
	row3:SetBackgroundColor(Color(255, 255, 255, 0))
	
	local clabel = vgui.Create("DLabel", tab2)
	clabel:SetPos(16, 600)
	clabel:SetSize(600, 32)
	clabel:SetTextColor(Color(0, 0, 0, 255))
	clabel:SetText("**These colours update for everyone when you respawn or press the 'Apply Changes' button on the left.")
	
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
	
	function applybutton:DoClick()
		local str = ""
		for k,v in pairs(frame.preview:GetEntity():GetBodyGroups()) do
			local num = frame.preview:GetEntity():GetBodygroup(k-1)
			str = "".. str .."".. tostring(num) ..""
		end
	
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
		if DRC:GetCustomizationAllowed() != true then
			tbl = {
				["player"] = LocalPlayer(),
				["model"] = frame.preview:GetModel(),
				["bodygroups"] = str,
				["skin"] = frame.preview:GetEntity():GetSkin(),
				["voiceset"] = VSelection,
				["hands"] = {
					["model"] = handval,
					["bodygroups"] = LocalPlayer():GetInfo("cl_playerhands_bodygroups"),
					["skin"] = LocalPlayer():GetInfo("cl_playerhands_skin"),
				}
			}
		else
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
				},
				["bodygroups"] = str,
				["skin"] = frame.preview:GetEntity():GetSkin(),
				["voiceset"] = VSelection,
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
	
	local tab5 = vgui.Create( "DPanel", tabs )
	tab5:SetBackgroundColor( Color(255, 255, 255, 255) )
--	tab5:Dock(FILL)
	tabs:AddSheet( "Extra", tab5, "icon16/draconic_base.png" )
	
	local tab4 = vgui.Create( "DPanel", tabs )
	tab4:SetBackgroundColor( Color(255, 255, 255, 255) )
--	tab4:Dock(FILL)
	tabs:AddSheet( "Saved Avatars", tab4, "icon16/award_star_gold_1.png" )
	
	local SprayLabel = vgui.Create("DLabel", tab5)
	SprayLabel:SetPos(16,12)
	SprayLabel:SetSize(500,20)
	SprayLabel:SetText("Spray settings:")
	SprayLabel:SetColor(Color(0, 0, 0, 255))
	
	local Sprays_General = vgui.Create( "DCheckBoxLabel", tab5 )
	Sprays_General:SetPos(16, 32)
	Sprays_General:SetSize(500, 20)
	Sprays_General:SetText( "Show spray on spawned props/entities" )
	Sprays_General:SetConVar( "cl_drc_showspray" )
	Sprays_General.Label:SetColor(Color(0, 0, 0, 255))
	Sprays_General:SetEnabled(true)
	
	local Sprays_Vehicles = vgui.Create( "DCheckBoxLabel", tab5 )
	Sprays_Vehicles:SetPos(16, 50)
	Sprays_Vehicles:SetSize(500, 20)
	Sprays_Vehicles:SetText( "Show spray on vehicles" )
	Sprays_Vehicles:SetConVar( "cl_drc_showspray_vehicles" )
	Sprays_Vehicles.Label:SetColor(Color(0, 0, 0, 255))
	Sprays_Vehicles:SetEnabled(true)
	
	local Sprays_Weapons = vgui.Create( "DCheckBoxLabel", tab5 )
	Sprays_Weapons:SetPos(16, 68)
	Sprays_Weapons:SetSize(500, 20)
	Sprays_Weapons:SetText( "Show spray on weapons" )
	Sprays_Weapons:SetConVar( "cl_drc_showspray_weapons" )
	Sprays_Weapons.Label:SetColor(Color(0, 0, 0, 255))
	Sprays_Weapons:SetEnabled(true)
	
	local Sprays_Player = vgui.Create( "DCheckBoxLabel", tab5 )
	Sprays_Player:SetPos(16, 86)
	Sprays_Player:SetSize(500, 20)
	Sprays_Player:SetText( "Show spray on yourself" )
	Sprays_Player:SetConVar( "cl_drc_showspray_player" )
	Sprays_Player.Label:SetColor(Color(0, 0, 0, 255))
	Sprays_Player:SetEnabled(true)
	
	local SpraypreviewText = vgui.Create("DLabel", tab5)
	SpraypreviewText:SetPos(16, 105)
	SpraypreviewText:SetTextColor(Color(0, 0, 0, 255))
	SpraypreviewText:SetText("Your spray:")
	
	local Spraypreview = vgui.Create("DImage", tab5)
	Spraypreview:SetPos(16, 115)
	Spraypreview:SetSize(320, 320)
	Spraypreview:SetImageColor(Color(255, 255, 255, 255))
	Spraypreview:SetMaterial("vgui/drc_spraypreview")
	
	local SprayDisclaimer = vgui.Create("DLabel", tab5)
	SprayDisclaimer:SetPos(16, 430)
	SprayDisclaimer:SetSize(400, 32)
	SprayDisclaimer:SetTextColor(Color(0, 0, 0, 255))
	SprayDisclaimer:SetText("**sprays only appear on content that support it")
	
	local VoiceLabel = vgui.Create("DLabel", tab5)
	VoiceLabel:SetPos(300,12)
	VoiceLabel:SetSize(500,20)
	VoiceLabel:SetText("Voiceset settings:")
	VoiceLabel:SetColor(Color(0, 0, 0, 255))
	
	local CVLabel = vgui.Create("DLabel", tab5)
	CVLabel:SetPos(300,30)
	CVLabel:SetSize(500,20)
	if DRC.VoiceSets[LocalPlayer():GetNWString("DRCVoiceSet")] == nil then
		CVLabel:SetText("> Current VS: None")
	else
		CVLabel:SetText("> Current VS: ".. DRC.VoiceSets[LocalPlayer():GetNWString("DRCVoiceSet")].Name .."")
	end
	CVLabel:SetColor(Color(0, 0, 0, 255))
	
	local VoiceSelector = vgui.Create( "DComboBox", tab5 )
	VoiceSelector:SetSortItems(true)
	VoiceSelector:SetPos(306, 50)
	VoiceSelector:SetSize(150, 20)
	VoiceSelector:SetConVar( "cl_drc_voiceset" )
	VoiceSelector:AddChoice("[!] None", "none")
	for k,v in pairs(DRC.VoiceSets) do
		local tbl = DRC.VoiceSets[k]
		VoiceSelector:AddChoice(tbl.Name, tbl.ID)
	end
	function VoiceSelector:OnSelect(index, value, data)
		LocalPlayer():ConCommand("cl_drc_voiceset ".. data .."")
		VSelection = data
	end
	
--[[	local VoicePitch = vgui.Create("DNumSlider", tab5)
	VoicePitch:SetPos(306,80)
	VoicePitch:SetSize(200,20)
	VoicePitch:SetConVar("cl_drc_voicepitch")
	VoicePitch:SetValue(ply:GetInfoNum("cl_drc_voicepitch", 1))
	VoicePitch:SetMin(0.9)
	VoicePitch:SetMax(1.1)
	VoicePitch:SetDecimals(2)
	VoicePitch:SetText("Voice Pitch")
	VoicePitch.Label:SetTextColor(Color(0, 0, 0, 255)) --]]
	
	
--	local weaponlabel = vgui.Create("DLabel", tab6)
--	weaponlabel:SetText("frame.preview Weapon Model:")
--	weaponlabel:SetSize(128, 16)
	
--	local weapon = vgui.Create("DTextEntry", tab6)
--	weapon:SetPos(128, 0)
--	weapon:SetSize(256, 16)
	
	local function UpdateGmodColours()
		RunConsoleCommand( "cl_playercolor", tostring( playercolour:GetVector() ))
		RunConsoleCommand( "cl_weaponcolor", tostring( weaponcolour:GetVector() ))
	end
	
	local function UpdateDraconicColours()		
		DRC:RefreshColours(LocalPlayer())
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
			t3p:Clear()

			tab3.Tab:SetVisible( false )

			local nskins = frame.preview.Entity:SkinCount() - 1
			if ( nskins > 0 ) then
				local skins = vgui.Create( "DNumSlider", t3p )
				skins:Dock( TOP )
				skins:SetText( "Skin" )
				skins:SetDark( true )
				skins:SetTall( 50 )
				skins:SetDecimals( 0 )
				skins:SetMax( nskins )
				skins:SetValue( GetConVarNumber( "cl_playerskin" ) )
				skins.type = "skin"
				skins.OnValueChanged = UpdateBodyGroups

				t3p:AddItem( skins )

				frame.preview.Entity:SetSkin( GetConVarNumber( "cl_playerskin" ) )

				tab3.Tab:SetVisible( true )
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

				t3p:AddItem( bgroup )

				frame.preview.Entity:SetBodygroup( k, groups[ k + 1 ] or 0 )

				tab3.Tab:SetVisible( true )
			end

			tabs.tabScroller:InvalidateLayout()
		end
		
		local function UpdateFromConvars()
			local model = LocalPlayer():GetInfo( "cl_playermodel" )
			modelname = player_manager.TranslatePlayerModel( model )
			if DRC:GetCustomizationAllowed() == true then
				util.PrecacheModel( modelname )
				frame.preview:SetModel( modelname )
			end
			RebuildBodygroupTab()
			if frame.preview.Entity then frame.preview.Entity.GetPlayerColor = function() return Vector( GetConVarString( "cl_playercolor" ) ) end end
			playercolour:SetVector( Vector( GetConVarString( "cl_playercolor" ) ) )
			weaponcolour:SetVector( Vector( GetConVarString( "cl_weaponcolor" ) ) )
		--	Playframe.previewAnimation( frame.preview, model )
		end
	UpdateFromConvars(false)
	
	function PanelSelect:OnActivePanelChanged( old, new )
		if ( old != new ) then -- Only reset if we changed the model
			RunConsoleCommand( "cl_playerbodygroups", "0" )
			RunConsoleCommand( "cl_playerskin", "0" )
		end
		timer.Simple( 0.1, function() UpdateFromConvars(false) end )
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
		
		playercolourframe.preview:SetBackgroundColor(playercolour:GetColor())
		weaponcolourframe.preview:SetBackgroundColor(weaponcolour:GetColor())
		eyecolourframe.preview:SetBackgroundColor(eyecolour:GetColor())
		energyColourframe.preview:SetBackgroundColor(energyColour:GetColor())
		accentColour1frame.preview:SetBackgroundColor(accentColour1:GetColor())
		accentColour2frame.preview:SetBackgroundColor(accentColour2:GetColor())
		
		DRC:RefreshColours(LocalPlayer())
		timer.Simple(0.1, function() RebuildBodygroupTab() end)
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
				container:SetSize(drcMenu_ScrollAvatars:GetWide(), 32)
				container:SetPos(0, 0)
				container:Dock(TOP)
				container:DockMargin(0, 2, 0, 2)
				container:SetBackgroundColor(Color(0, 0, 0, 255))
				
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
				
				for k,v in pairs(tbl.Colours) do
					local collabel = vgui.Create("DPanel", container)
					local colvec = Vector(v)
					collabel:SetSize(40, 32)
					collabel:SetPos( 600 - k * 40, 0)
					collabel:SetBackgroundColor(Color(colvec.x, colvec.y, colvec.z, 255))
				end
				
				local ModelPanel = vgui.Create("DPanel", container)
				ModelPanel:SetSize(230, 30)
				ModelPanel:SetPos(129, 1)
				ModelPanel:SetBackgroundColor(Color(255, 255, 255, 255))
				
				local ModelLabel = vgui.Create("DLabel", ModelPanel)
				ModelLabel:SetSize(230, 30)
				ModelLabel:SetPos(0, 0)
				ModelLabel:SetText(tbl.Playermodel)
				ModelLabel:SetContentAlignment(5)
				ModelLabel:SetColor(Color(0, 0, 0, 255))
				
				local label = vgui.Create("DButton", container)
				label:SetText(tbl.Name)
				label:SetSize(128, 32)
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
	AvatarTitle:DockMargin(6, 1, 1, 0)
	AvatarTitle:SetColor(Color(0, 0, 0, 255))
	
	local PCPanel = vgui.Create("DPanel", AvatarTitleContainer)
	PCPanel:SetSize(AvatarTitleContainer:GetWide(), 20)
	PCPanel:Dock(FILL)
	local PCLabel = vgui.Create("DLabel", PCPanel)
	PCLabel:SetText("Model name, Player, Weapon, Eye, Energy, Tint1, Tint2 colours.   ")
	PCLabel:SetSize(AvatarTitleContainer:GetWide(), 20)
	PCLabel:Dock(FILL)
	PCLabel:SetContentAlignment(6)
	PCLabel:SetColor(Color(0, 0, 0, 255))
	
	if DRC:GetCustomizationAllowed() == nil then
		for k,v in pairs(tabs:GetItems()) do
			if v.Name == "Player" then
				tabs:CloseTab(v.Tab)
			elseif v.Name == "Saved Avatars" then
				tabs:CloseTab(v.Tab)
			end
		end
		tab1:Remove()
		tab4:Remove()
		VoiceSelector:SetEnabled(false)
		
		tabs:SetActiveTab(tabs:GetItems()[1].Tab)
	elseif DRC:GetCustomizationAllowed() == false then
		for k,v in pairs(tabs:GetItems()) do
			if v.Name == "Player" then
				tabs:CloseTab(v.Tab)
			elseif v.Name == "Saved Avatars" then
				tabs:CloseTab(v.Tab)
			elseif v.Name == "Colours" then
				tabs:CloseTab(v.Tab)
			elseif v.Name == "#smwidget.bodygroups" then
				tabs:CloseTab(v.Tab)
			end
		end
		tab1:Remove()
		tab2:Remove()
		tab4:Remove()
		VoiceSelector:SetEnabled(false)
	end
	
	RefreshAvatars()
	
	local mt2 = vgui.Create( "DPanel", maintabs )
	mt2:SetBackgroundColor(Color(255, 255, 255, 5))
	maintabs:AddSheet( "Settings", mt2, "icon16/wrench.png")
	
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
	DrcCrosshairs:SetPos(516, 35)
	DrcCrosshairs:SetSize(200, 20)
	DrcCrosshairs:SetText( "Dim muzzle flashes (Photosensitivity)" )
	DrcCrosshairs:SetConVar( "cl_drc_accessibility_photosensitivity_muzzle" )
	DrcCrosshairs.Label:SetColor(TextCol)
	DrcCrosshairs:SetEnabled(true)
	
	local ColourBlindSetting = vgui.Create( "DLabel", t2tab1)
	ColourBlindSetting:SetPos(516, 60)
	ColourBlindSetting:SetSize(100, 20)
	ColourBlindSetting:SetText("Colour Blindness:")
	ColourBlindSetting:SetColor(TextCol)
				
	local ColourBlindCombo = vgui.Create( "DComboBox", t2tab1 )
	ColourBlindCombo:SetSortItems(false)
	ColourBlindCombo:SetPos(600, 60)
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
	
	MakeHint(t2tab1, 750, 60, "This is colour correction intended to make it easier for colourblind/colour-deficient individuals to spot objects/differences that would be plainly visible to others, but not for themselves.\nThis does not 'make everything look normal' for those who use it and should not be considered as such.")
	
	local ColourBlindStrength = vgui.Create( "DNumSlider", t2tab1 )
	ColourBlindStrength:SetPos(516, 85)
	ColourBlindStrength:SetSize(300, 20)
	ColourBlindStrength:SetText( "Col. Blind Filter Strength" )
	ColourBlindStrength.Label:SetColor(TextCol)
	ColourBlindStrength:SetMin( 0 )
	ColourBlindStrength:SetMax( 100 )
	ColourBlindStrength:SetDecimals( 0 )
	ColourBlindStrength:SetConVar( "cl_drc_accessibility_colourblind_strength" )
	ColourBlindStrength:SetEnabled(true)
	
	t2tab1.ColourBlindDisclaimer = vgui.Create( "DLabel", t2tab1)
	t2tab1.ColourBlindDisclaimer:SetText("** I am not an optician and this is guesswork at best.")
	t2tab1.ColourBlindDisclaimer:SetSize(300, 50)
	t2tab1.ColourBlindDisclaimer:SetPos(516, 90)
	t2tab1.ColourBlindDisclaimer:SetColor(SubtextCol)
	
	local DRCSway = vgui.Create( "DCheckBoxLabel", t2tab1 )
	DRCSway:SetPos(516, 130)
	DRCSway:SetSize(500, 20)
	DRCSway:SetText( "Enable scripted weapon swaying (Motion sickness)" )
	DRCSway:SetConVar( "cl_drc_sway" )
	DRCSway.Label:SetColor(TextCol)
	DRCSway:SetEnabled(true)
	
	local SettingsTitle_CL = vgui.Create( "DLabel", t2tab1)
	SettingsTitle_CL:SetText("Client Settings")
	SettingsTitle_CL:SetSize(200, 50)
	SettingsTitle_CL:SetPos(16, -8)
	SettingsTitle_CL:SetColor(Color(255, 255, 255, 255))
	SettingsTitle_CL:SetFont("DermaLarge")
	SettingsTitle_CL:SetContentAlignment(0)
	
	local DrcSoul = vgui.Create( "DCheckBoxLabel", t2tab1 )
	DrcSoul:SetPos(25, 35)
	DrcSoul:SetSize(500, 20)
	DrcSoul:SetText( "Sacrifice your soul to Vuthakral" )
	DrcSoul:SetConVar( "cl_drc_sell_soul" )
	DrcSoul.Label:SetColor(TextCol)
	DrcSoul:SetEnabled(false)
	
	local DrcCrosshairs = vgui.Create( "DCheckBoxLabel", t2tab1 )
	DrcCrosshairs:SetPos(25, 60)
	DrcCrosshairs:SetSize(500, 20)
	DrcCrosshairs:SetText( "Disable crosshairs" )
	DrcCrosshairs:SetConVar( "cl_drc_disable_crosshairs" )
	DrcCrosshairs.Label:SetColor(TextCol)
	DrcCrosshairs:SetEnabled(true)
	
	local DrcErrorHints = vgui.Create( "DCheckBoxLabel", t2tab1 )
	DrcErrorHints:SetPos(25, 85)
	DrcErrorHints:SetSize(500, 20)
	DrcErrorHints:SetText( "Disable error hints" )
	DrcErrorHints:SetConVar( "cl_drc_disable_errorhints" )
	DrcErrorHints.Label:SetColor(TextCol)
	DrcErrorHints:SetEnabled(true)
	
	local DrcLoweredCrosshair = vgui.Create( "DCheckBoxLabel", t2tab1 )
	DrcLoweredCrosshair:SetPos(25, 110)
	DrcLoweredCrosshair:SetSize(500, 20)
	DrcLoweredCrosshair:SetText( "Enable lowered crosshair" )
	DrcLoweredCrosshair:SetConVar( "cl_drc_lowered_crosshair" )
	DrcLoweredCrosshair.Label:SetColor(TextCol)
	DrcLoweredCrosshair:SetEnabled(true)
	
	local DrcExperimentalFP = vgui.Create( "DCheckBoxLabel", t2tab1 )
	DrcExperimentalFP:SetPos(25, 135)
	DrcExperimentalFP:SetSize(500, 20)
	DrcExperimentalFP:SetText( "Enable ''Experimental First Person Camera'' mode" )
	DrcExperimentalFP:SetConVar( "cl_drc_experimental_fp" )
	DrcExperimentalFP.Label:SetColor(TextCol)
	DrcExperimentalFP:SetEnabled(true)
	
	MakeHint(t2tab1, 285, 135, "This makes your camera function like a true full-body first person system while still using your viewmodel.")
	
	local DrcThirdperson = vgui.Create( "DCheckBoxLabel", t2tab1 )
	DrcThirdperson:SetPos(25, 160)
	DrcThirdperson:SetSize(500, 20)
	DrcThirdperson:SetText( "Enable Draconic Thirdperson" )
	DrcThirdperson:SetConVar( "cl_drc_thirdperson" )
	DrcThirdperson.Label:SetColor(TextCol)
	DrcThirdperson:SetEnabled(true)
	
	local DrcThirdperson_Dyn = vgui.Create( "DCheckBoxLabel", t2tab1 )
	DrcThirdperson_Dyn:SetPos(25, 185)
	DrcThirdperson_Dyn:SetSize(500, 20)
	DrcThirdperson_Dyn:SetText( "Disable Thirdperson Free-look" )
	DrcThirdperson_Dyn:SetConVar( "cl_drc_thirdperson_disable_freelook" )
	DrcThirdperson_Dyn.Label:SetColor(TextCol)
	DrcThirdperson_Dyn:SetEnabled(true)
	
	local VMOX = vgui.Create( "DNumSlider", t2tab1 )
	VMOX:SetPos(25, 235)
	VMOX:SetSize(300, 20)
	VMOX:SetText( "Global viewmodel offset X" )
	VMOX.Label:SetColor(TextCol)
	VMOX:SetMin( -10 )
	VMOX:SetMax( 10 )
	VMOX:SetDecimals( 4 )
	VMOX:SetConVar( "cl_drc_vmoffset_x" )
	VMOX:SetEnabled(true)
	
	local VMOY = vgui.Create( "DNumSlider", t2tab1 )
	VMOY:SetPos(25, 255)
	VMOY:SetSize(300, 20)
	VMOY:SetText( "Global viewmodel offset Y" )
	VMOY.Label:SetColor(TextCol)
	VMOY:SetMin( -10 )
	VMOY:SetMax( 10 )
	VMOY:SetDecimals( 4 )
	VMOY:SetConVar( "cl_drc_vmoffset_y" )
	VMOY:SetEnabled(true)
	
	local VMOZ = vgui.Create( "DNumSlider", t2tab1 )
	VMOZ:SetPos(25, 275)
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
				
				local DrcSprintOverride = vgui.Create( "DCheckBoxLabel", t2tab2 )
				DrcSprintOverride:SetPos(25, 95)
				DrcSprintOverride:SetSize(20, 20)
				DrcSprintOverride:SetText( "All Draconic weapons use passive sprint" )
				DrcSprintOverride:SetConVar( "sv_drc_force_sprint" )
				DrcSprintOverride.Label:SetColor(TextCol)
				
				local SvThirdperson = vgui.Create( "DCheckBoxLabel", t2tab2 )
				SvThirdperson:SetPos(25, 115)
				SvThirdperson:SetSize(20, 20)
				SvThirdperson:SetText( "Disable access to Draconic's thirdperson system" )
				SvThirdperson:SetConVar( "sv_drc_disable_thirdperson" )
				SvThirdperson.Label:SetColor(TextCol)
				
				MakeHint(t2tab2, 300, 115, "Draconic SWEPs which require thirdperson will still use Draconic thirdperson regardless of this setting.")
				
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
				
				MakeHint(t2tab2.SoundStretch, 300, 0, "Enabling this setting will make it so sounds do not slow down/speed up when host_timescale changes are in effect.")
				
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
				
				local DiffDescE = vgui.Create( "DLabel", t2tab2)
				DiffDescE:SetPos(400, 35)
				DiffDescE:SetSize(w2, 20)
				DiffDescE:SetText("Easy: ".. GetConVarNumber("sk_dmg_inflict_scale1") * 100 .."% damage dealt, ".. GetConVarNumber("sk_dmg_take_scale1") * 100 .."% damage taken.")
				DiffDescE:SetColor(SubtextCol)
				
				local DiffDescM = vgui.Create( "DLabel", t2tab2)
				DiffDescM:SetPos(400, 55)
				DiffDescM:SetSize(w2, 20)
				DiffDescM:SetText("Medium: ".. GetConVarNumber("sk_dmg_inflict_scale2") * 100 .."% damage dealt, ".. GetConVarNumber("sk_dmg_take_scale2") * 100 .."% damage taken.")
				DiffDescM:SetColor(SubtextCol)
				
				local DiffDescH = vgui.Create( "DLabel", t2tab2)
				DiffDescH:SetPos(400, 75)
				DiffDescH:SetSize(w2, 20)
				DiffDescH:SetText("Hard: ".. GetConVarNumber("sk_dmg_inflict_scale3") * 100 .."% damage dealt, ".. GetConVarNumber("sk_dmg_take_scale3") * 100 .."% damage taken.")
				DiffDescH:SetColor(SubtextCol)
				
				t2tab2.AmmoSetting = vgui.Create( "DLabel", t2tab2)
				t2tab2.AmmoSetting:SetPos(400, 110)
				t2tab2.AmmoSetting:SetSize(100, 20)
				t2tab2.AmmoSetting:SetText("DRC Infinite Ammo:")
				t2tab2.AmmoSetting:SetColor(TextCol)
				
				t2tab2.InfiniteAmmo = vgui.Create( "DComboBox", t2tab2 )
				t2tab2.InfiniteAmmo:SetSortItems(false)
				t2tab2.InfiniteAmmo:SetPos(500, 110)
				t2tab2.InfiniteAmmo:SetSize(150, 20)
				t2tab2.InfiniteAmmo:SetConVar( "sv_drc_infiniteammo" )
				t2tab2.InfiniteAmmo:AddChoice("Disabled", 0)
				t2tab2.InfiniteAmmo:AddChoice("Enabled", 1)
				t2tab2.InfiniteAmmo:AddChoice("Bottomless Mag", 2)
				function t2tab2.InfiniteAmmo:OnSelect(index, value, data)
					LocalPlayer():ConCommand("sv_drc_infiniteammo ".. index - 1 .."")
				end
				
--[[			local DrcDistGunfire = vgui.Create( "DCheckBoxLabel", t2tab2 )
				DrcDistGunfire:SetPos(25, 145)
				DrcDistGunfire:SetSize(20, 20)
				DrcDistGunfire:SetText( "Disable distant gunfire sounds (can alleviate network usage on larger servers)" )
				DrcDistGunfire:SetConVar( "sv_drc_disable_distgunfire" )
				DrcDistGunfire.Label:SetColor(TextCol)
				
				
				local WeaponSway = vgui.Create( "DNumSlider", t2tab2 )
				WeaponSway:SetPos(25, 115)
				WeaponSway:SetSize(300, 20)
				WeaponSway:SetText( "AI accuracy handicap" )
				WeaponSway.Label:SetColor(TextCol)
				WeaponSway:SetMin( 0 )
				WeaponSway:SetMax( 10 )
				WeaponSway:SetDecimals( 2 )
				WeaponSway:SetConVar( "sv_drc_npc_accuracy" )
				
				local LGTitle = vgui.Create( "DLabel", t2tab2)
				LGTitle:SetPos(25, 135)
				LGTitle:SetSize(w2, 60)
				LGTitle:SetText("Handicap of how much an NPCs accuracy should be with Draconic guns. \n 0 = Seal Team 6 accuracy (perfect) \n 2 - Half-Life 2 AI Accuracy \n 10 = Can't hit shit.")
				LGTitle:SetColor(TextCol) --]]
				
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
				.ultitle{
					font-family: "Lucida Console";
					margin-left: 3em;
					margin-top: 0.1em;
					margin-bottom: 0.1em;
					
					color: white;
				}
				</style>
			</head>
					
			<body style="background-color: rgba(11,11,33, 0.7); position: absolute; margin: 0 auto; width: 100vw; height: auto; overflow-x: hidden;">
				<br>
				<h2>Draconic Base</h2>		
				<h3>Credits</h3>
				<h4>Programmming</h4>
					<p class="ultitle">Vuthakral</p>
					<ul>
						<li>Everything not listed below this credit</li>
					</ul>
					<p class="ultitle">Clavus</p>
					<ul>
						<li>SWEP Construction Kit code</li>
					</ul>
					<p class="ultitle">Kinyom</p>
					<ul>
						<li>BSP-Envmap reading function code.</lI>
					</ul>
				<h4>Bug testing</h4>
					<p class="ultitle">Dopey, Snowy Snowtime, Valkyries733</p>
					<ul>
						<li>Very helpful individuals who often help me test out features of the base as I work on them.</li>
					</ul>
				<h4>Animations</h4>
					<p class="ultitle">Twilight Sparkle</p>
					<ul>
						<li>"Unarmed" SWEP Animations.</li>
					</ul>
				<h4>Sounds</h4>
					<p class="ultitle">Entropy Zero 2</p>
					<ul>
						<li>Weapon foley sample source</li>
					</ul>
				<h4>Special Thanks</h4>
					<p class="ultitle">All of the people who have supported me through working on all of my projects.</p>
					<ul>
						<li>My girlfriend, who has always been there for me even when things are at their worst. If you're reading this, I love you very much.</li>
						<li>My father, who has always been there for me with doing what I do, and putting up with my ramblings about all of it even if he doesn't understand them.</li>
						<li>And of course, my <b>Patreon supporters</b> who have helped me for years now in being able to do what I do: 5oClock, Chillstice, and one Patron who wishes to remain anonymous.</li>
					</ul>
					<p class="ultitle">The people in TFA's Discord (RIP)</p>
					<ul>
						<li>Tons of help when I ran into walls with code I was trying to do. Very helpful people.</li>
					</ul>
					<p class="ultitle">Wingblast</p>
					<ul>
						<li>Showed me how to originally implement the perspective change for weapons when looking up/down.</li>
					</ul>
					<p class="ultitle">Clavus</p>
					<ul>
						<li>Creator of the "SWEP Construction Kit" -- Seriously dude, your addon has greatly contributed to the Garry's Mod 13 community & experience. Thank you.</li>
					</ul>
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
	DebugInfo:SetPos(15, 47)
	DebugInfo:SetSize(200, 20)
	DebugInfo:SetText("Gamemode: ".. engine.ActiveGamemode() .."")
	DebugInfo:SetColor(TextCol)
	
	local DebugInfo = vgui.Create( "DLabel", debug_gameinfo)
	DebugInfo:SetPos(15, 60)
	DebugInfo:SetSize(200, 20)
	DebugInfo:SetText("Map: ".. game.GetMap() .."")
	DebugInfo:SetColor(TextCol)
	
	local DebugInfo = vgui.Create( "DLabel", debug_gameinfo)
	DebugInfo:SetPos(15, 73)
	DebugInfo:SetSize(200, 20)
		if game.SinglePlayer() then
			DebugInfo:SetText("Type: Singleplayer")
		elseif !game.SinglePlayer() && !game.IsDedicated() then
			DebugInfo:SetText("Type: Local or Multiplayer server")
		end
	DebugInfo:SetColor(TextCol)
	
	local DebugInfo = vgui.Create( "DLabel", debug_gameinfo)
	DebugInfo:SetPos(5, 100)
	DebugInfo:SetSize(200, 40)
	DebugInfo:SetText("Map Information")
	DebugInfo:SetFont("DermaLarge")
	DebugInfo:SetColor(Color(255, 255, 255, 255))
	
	local text = "Unverified"
	if drc_mapfailed_lightamsp == true then
		text = "Fail"
	elseif drc_mappassed_lightmap == true then
		text = "Verified Pass"
	elseif drc_authorpassedlightmap == true then
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
		DebugInfo:SetColor(Color(255,255,0,255))
	end
	
	local DebugInfo = vgui.Create( "DLabel", debug_gameinfo)
	DebugInfo:SetPos(15, 160)
	DebugInfo:SetSize(300, 20)
	if CTFK(drc_badlightmaps, game.GetMap()) then
		DebugInfo:SetText("Fail Reason: Bad/Invalid lightmapping method(s).")
	elseif CTFK(drc_singlecubemaps, game.GetMap()) then
		DebugInfo:SetText("Fail Reason: Map has only one cubemap.")
	elseif CTFK(drc_fullbrightcubemaps, game.GetMap()) then
		DebugInfo:SetText("Fail Reason: Maps cubemap(s) are fullbright.")
	else
		DebugInfo:SetText("")
	end
	DebugInfo:SetColor(TextCol)
	
	local DebugInfo = vgui.Create( "DLabel", debug_gameinfo)
	DebugInfo:SetPos(15, 180)
	DebugInfo:SetSize(300, 20)
	DebugInfo:SetText("Ambient light: ".. tostring(DRC.MapInfo.MapAmbient) .."")
	DebugInfo:SetColor(TextCol)
	
	local DebugInfo = vgui.Create( "DLabel", debug_gameinfo)
	DebugInfo:SetFont("Marlett")
	DebugInfo:SetPos(235, 180)
	DebugInfo:SetSize(50, 20)
	DebugInfo:SetText("g")
	DebugInfo:SetColor(Color(render.GetAmbientLightColor().x * 255, render.GetAmbientLightColor().y * 255, render.GetAmbientLightColor().z * 255, 255))
	
	local versionname = tostring(DRC.MapInfo.Versions[DRC.MapInfo.Version]) or "Unknown"
	
	local DebugInfo = vgui.Create( "DLabel", debug_gameinfo)
	DebugInfo:SetPos(15, 200)
	DebugInfo:SetSize(300, 20)
	DebugInfo:SetText("Compiled for: ".. versionname .." (BSP V".. DRC.MapInfo.Version ..")")
	DebugInfo:SetColor(TextCol)
	
	local DebugInfo = vgui.Create( "DLabel", t4tab1)
	ControlsTitle:SetFont("DermaLarge")
	DebugInfo:SetPos(25, 10)
	DebugInfo:SetSize(400, 20)
	DebugInfo:SetText("HDR Support >> Hardware: ".. tostring(render.SupportsHDR()) .." | Map: ".. tostring(render.GetHDREnabled()) .."")
	DebugInfo:SetColor(TextCol)
	
	local DebugInfo = vgui.Create( "DLabel", t4tab1)
	ControlsTitle:SetFont("DermaLarge")
	DebugInfo:SetPos(25, 25)
	DebugInfo:SetSize(400, 20)
	DebugInfo:SetText("DirectX Level >> ".. render.GetDXLevel() .."")
	DebugInfo:SetColor(TextCol)
	
	local col = render.GetLightColor(LocalPlayer():EyePos()) * 255
	local DebugInfo = vgui.Create( "DLabel", t4tab1)
	DebugInfo:SetPos(25, 40)
	DebugInfo:SetSize(300, 20)
	DebugInfo:SetText("Local light level >>      ".. tostring(col) .."")
	DebugInfo:SetColor(TextCol)
	
	local DebugInfo = vgui.Create( "DLabel", t4tab1)
	DebugInfo:SetFont("Marlett")
	DebugInfo:SetPos(120, 40)
	DebugInfo:SetSize(50, 20)
	DebugInfo:SetText("g")
	DebugInfo:SetColor(Color(col.x, col.y, col.z, 255))
	
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
	
	MakeHint(t4tab2panel_left, 150, 135, "Renders TraceLines used by the Draconic Base.\nServer-sided traces will only render in singleplayer.\n\nWhite = Undefined/generic\nRed = Harmful hit connection\nYellow = DRC:TraceDir() trace.")
	
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
			surface.PlaySound("draconic/oof.ogg")
			net.Start("DRC_Nuke")
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
	wiki:OpenURL("https://github.com/Vuthakral/Draconic_Base/wiki")
	
end