AddCSLuaFile()

if SERVER then
	resource.AddFile ( 'materials/overlays/draconic_scope.vmt' )
	util.AddNetworkString("DRCSound")
	util.AddNetworkString("OtherPlayerWeaponSwitch")
	util.AddNetworkString("DRCPlayerMelee")
	util.AddNetworkString("DRCNetworkGesture")
else end

net.Receive("DRCSound", function(len, ply)
	local nt = net.ReadTable()
	local ply = LocalPlayer()
	
	source = nt.Src or nil
	listener = nt.List or nil
	distance = nt.Dist or 1000
	
	if GetConVar("cl_drc_debugmode"):GetFloat() > 0 then
		if GetConVar("cl_drc_debug_invertnearfar"):GetFloat() > 0 then
			near = nt.Far or ""
			far = nt.Near or ""
		else
			near = nt.Near or ""
			far = nt.Far or ""
		end
	else
		near = nt.Near or ""
		far = nt.Far or ""
	end
		
	if !source:IsValid() then return end
	if source == nil then return end -- why
	local dist = math.Round((ply:GetPos() - source:GetPos()):Length(), 0)
	if dist < distance then
		source:EmitSound(near)
	else
		source:EmitSound(near)
		source:EmitSound(far)
	end
		
end)

function CTFK(tab, value)
	for i,v in ipairs(tab) do
		if v == value then return true end
	end
	return false
end

function CTFKV(tab, value)
	for i,v in ipairs(tab) do
		if i == value then return true end
	end
	return false
end

function ReturnKey( action )
	if input.LookupBinding( action, false ) != nil then
		local key = input.LookupBinding( action, true )
		local final = key
		return final
	else
		return "<NO KEY>"
	end
end

function DRCNotify(source, type, severity, msg, enum, time, sound)
	if source != nil && (severity == "warning" or severity == "error" or severity == "critical") then
		MsgC( Color(255, 0, 0), "Error from ".. tostring(source:GetClass()) ..": \n" )
	end

	local var = GetConVar("cl_drc_disable_errorhints"):GetFloat()
	if var != 1 or severity == "critical" then
		if sound != nil then surface.PlaySound( sound ) end
		if type == "hint" then
			if enum == nil then enum = NOTIFY_HINT end
			if time == nil then time = 10 end
			notification.AddLegacy( msg, enum, time )
		else
		 -- Will implement a proper error logging system later
		end
	end
	
	if enum == NOTIFY_ERROR then
	if severity == "critical" then severity = "critical error" end
	MsgC( Color(255, 0, 0), string.upper("[DRC ".. severity .."]"), Color(255, 255, 0), " ".. msg .." \n" )
	end
end

function DRCSound(source, near, far, distance, listener)
	if CLIENT then return end
	local nt = {}
	nt.Src = source
	nt.Near = near
	nt.Far = far
	nt.Dist = distance
	nt.List = listener

	net.Start("DRCSound")
	net.WriteTable(nt)
	net.Broadcast()
end

function DRCPlayGesture(ply, slot, gesture, b)
	if ply:IsValid() then ply:AnimRestartGesture(slot, gesture, b) end
end

net.Receive("DRCNetworkGesture", function(len, ply)
	local tbl = net.ReadTable()
	
	local plyr = tbl.Player
	local slot = tbl.Slot
	local act = tbl.Activity
	local akill = tbl.Autokill

	DRCPlayGesture(plyr, slot, act, akill)
end)

function DRCCallGesture(ply, slot, act, akill)
	if !SERVER then return end
	if !IsValid(ply) or ply == nil then return end
	if !slot or slot == "" or slot == nil then slot = GESTURE_SLOT_CUSTOM end
	if !act then return end
	if !akill or akill == "" or akill == nil then akill = true end
	
	local nt = {}
	nt.Player = ply
	nt.Slot = slot
	nt.Activity = act
	nt.Autokill = akill
	
	net.Start("DRCNetworkGesture")
	net.WriteTable(nt)
	net.Broadcast()
end

list.Set( "DesktopWindows", "Draconic Menu", {
	title = "Draconic Base",
	icon = "icon64/draconic_base.png",
	init = function( icon, window )
		DRCMenu(LocalPlayer())
	end
	
} )

concommand.Add("drc_menu", function()
	if not CLIENT then return end
	DRCMenu(LocalPlayer())
end)

if GetConVar("sv_drc_movement") == nil then
	CreateConVar("sv_drc_movement", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables the custom movement modifiers of ALL weapons made on the Draconic SWEP Base.", 0, 1)
end

if GetConVar("sv_drc_movesounds") == nil then
	CreateConVar("sv_drc_movesounds", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables the custom sprint/jump sounds of ALL weapons made on the Draconic SWEP Base.", 0, 1)
end

if GetConVar("sv_drc_callofdutyspread") == nil then
	CreateConVar("sv_drc_callofdutyspread", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Do you hate 'Call of Duty aim' where weapon spread is unrealistically reduced when aiming down the sights? Me too! Unfortunately for you, people begged me to add it to my base anyways. But fortunately for you, I tied it all to a serverside config to disable it entirely!", 0, 1)
end

if GetConVar("sv_drc_force_sprint") == nil then
	CreateConVar("sv_drc_force_sprint", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Forces all DSB weapons to use the passive-sprint system, regardless of SWEP author intention.", 0, 1)
end

if GetConVar("sv_drc_maxrmour") == nil then
	CreateConVar("sv_drc_maxrmour", 250, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_DEMO}, "Maximum armour a DSB weapon can reapply to.")
end

if GetConVar("sv_drc_server_finished_loading") == nil then
	CreateConVar("sv_drc_server_finished_loading", 0, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_DEMO}, "DO. NOT. TOUCH.")
end

if GetConVar("sv_drc_disable_distgunfire") == nil then
	CreateConVar("sv_drc_disable_distgunfire", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "If true, disables distant gunfire for weapons. Alleviates network traffic on larger servers.", 0, 1)
end

if GetConVar("sv_drc_inspections") == nil then
	CreateConVar("sv_drc_inspections", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables the ability to access the inspection mode, which shows weapon stats & puts the viewmodel in an alternate view.", 0, 1)
end

if GetConVar("sv_drc_inspect_hideHUD") == nil then
	CreateConVar("sv_drc_inspect_hideHUD", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables the ability to see the inspection menu which shows weapon stats.", 0, 1)
end

if GetConVar("sv_drc_passives") == nil then
	CreateConVar("sv_drc_passives", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables the ability to put weapons in a passive stance.", 0, 1)
end

if GetConVar("sv_drc_viewdrag") == nil then
	CreateConVar("sv_drc_viewdrag", 1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enables or disables first person camera drag effects with animations.", 0, 1)
end

if GetConVar("sv_drc_allowdebug") == nil then
	CreateConVar("sv_drc_allowdebug", 0, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_DEMO}, "Allows all players to access the debug menu of the Draconic Base.", 0, 1)
end

if GetConVar("sv_drc_disable_crosshairs") == nil then
	CreateConVar("sv_drc_disable_crosshairs", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Enable/Disable SWEP base crosshairs for all clients. Clients can still disable them on their own, but this can prevent them from using them.", 0, 1)
end

if GetConVar("sv_drc_forcebasegameammo") == nil then
	CreateConVar("sv_drc_forcebasegameammo", 0, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_DEMO}, "Force Draconic weaapons to use standard base-game ammunition. (Requires weapon respawn on toggle)", 0, 1)
end

if GetConVar("cl_drc_disable_errorhints") == nil then
	CreateConVar("cl_drc_disable_errorhints", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Disables error hints from displaying.", 0, 1)	
end

if GetConVar("sv_drc_disable_attachmentmodifying") == nil then
	CreateConVar("sv_drc_disable_attachmentmodifying", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Disallow players from modifying weapon attachments.", 0, 1)	
end

if GetConVar("cl_drc_debugmode") == nil then
	CreateConVar("cl_drc_debugmode", 0, {FCVAR_USERINFO}, "Enables / Disables debug mode of the Draconic Base. (Requires sv_drc_allowdebug.)", 0, 2)
end

if GetConVar("cl_drc_debug_invertnearfar") == nil then
	CreateConVar("cl_drc_debug_invertnearfar", 0, {FCVAR_USERINFO}, "Inverts the near/far sound effect code.", 0, 1)
end

if GetConVar("cl_drc_debug_cameradrag") == nil then
	CreateConVar("cl_drc_debug_cameradrag", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Show/hide the camera drag interpreter in debug mode.", 0, 1)
end

if GetConVar("cl_drc_debug_vmattachments") == nil then
	CreateConVar("cl_drc_debug_vmattachments", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Show/hide the viewmodel attachment visualizations.", 0, 1)
end

if GetConVar("cl_drc_debug_legacyassistant") == nil then
	CreateConVar("cl_drc_debug_legacyassistant", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Show/hide the old legacy debug window 'DSB Debug Assisstant'.", 0, 1)
end

if GetConVar("cl_drc_debug_crosshairmode") == nil then
	CreateConVar("cl_drc_debug_crosshairmode", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "0: No debug crosshair \n 1: Standard debug crosshair /n 2: Melee travel path only /n 3: Full debug crosshair", 0, 3)
end

if GetConVar("cl_drc_lowered_crosshair") == nil then
	CreateConVar("cl_drc_lowered_crosshair", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE}, "Enable Halo-styled lowered crosshair, providing more vertical viewing space.", 0, 1)	
end

if CLIENT then
--[[	if GetConVar("cl_drc_sway") == nil then
		CreateClientConVar("cl_drc_sway", 1, {FCVAR_ARCHIVE, FCVAR_USERINFO}, "Controls how much weapon-sway a weapon will have when the player looks around. (0-2, default 1)", 0, 1)
	end--]]

	if GetConVar("cl_drc_sell_soul") == nil then
		CreateClientConVar("cl_drc_sell_soul", 1, {FCVAR_DEMO, FCVAR_USERINFO}, "Give unto the dragon.", 0, 1)
	end
	
	if GetConVar("cl_drc_disable_crosshairs") == nil then
		CreateClientConVar("cl_drc_disable_crosshairs", 0, true, true, "Hides all DSB related crosshairs (except for debug mode)", 0, 1)
	end

	if GetConVar("cl_drc_eyecolour_r") == nil then
		CreateConVar("cl_drc_eyecolour_r", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_eyecolour_g") == nil then
		CreateConVar("cl_drc_eyecolour_g", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_eyecolour_b") == nil then
		CreateConVar("cl_drc_eyecolour_b", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_energycolour_r") == nil then
		CreateConVar("cl_drc_energycolour_r", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_energycolour_g") == nil then
		CreateConVar("cl_drc_energycolour_g", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_energycolour_b") == nil then
		CreateConVar("cl_drc_energycolour_b", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_tint1_r") == nil then
		CreateConVar("cl_drc_tint1_r", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_tint1_g") == nil then
		CreateConVar("cl_drc_tint1_g", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_tint1_b") == nil then
		CreateConVar("cl_drc_tint1_b", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_tint2_r") == nil then
		CreateConVar("cl_drc_tint2_r", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_tint2_g") == nil then
		CreateConVar("cl_drc_tint2_g", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end

	if GetConVar("cl_drc_tint2_b") == nil then
		CreateConVar("cl_drc_tint2_b", 127, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end
	
	if GetConVar("cl_drc_vmoffset_x") == nil then
		CreateConVar("cl_drc_vmoffset_x", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end
	
	if GetConVar("cl_drc_vmoffset_y") == nil then
		CreateConVar("cl_drc_vmoffset_y", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end
	
	if GetConVar("cl_drc_vmoffset_z") == nil then
		CreateConVar("cl_drc_vmoffset_z", 0, {FCVAR_USERINFO, FCVAR_ARCHIVE})
	end
end

if CLIENT then
surface.CreateFont("WpnDisplay", {
	font 	= "lcd",
	size	= 24,
	weight	= 300	
})

surface.CreateFont("ApercuStats", {
	font 	= "Verdana",
	size	= 22,
	weight	= 0,
	shadow	= true
})

surface.CreateFont("ApercuStatsTitle", {
	font 	= "Apercu Mono",
	size	= 24,
	weight	= 1000,	
	outline	= true
})
else end

--[[
hook.Add( "PopulateToolMenu", "DraconicSWEPSettings", function()
	spawnmenu.AddToolMenuOption( "Options", "Draconic", "SWEP Base", "SWEP Base", "", "", function( panel )
		panel:ClearControls()
		local button = panel:Button("Open Menu")
		function button:OnMousePressed()
			drc_settings()
		end
	--	panel:ControlHelp( "" )
	--	panel:ControlHelp( "Server / Admin-only Settings" )
	--	panel:CheckBox( "Enable Draconic Movement", "sv_drc_movement")
	--	panel:CheckBox( "Enable Draconic Movement Sounds", "sv_drc_movesounds")
	--	panel:CheckBox( "Allow Call of Duty Spread", "sv_drc_callofdutyspread")
	--	panel:NumSlider( "NPC Accuracy Handicap", "sv_drc_npc_accuracy", 0, 10, 1 )
	--	panel:Help( "0 = Seal Team Six" )
	--	panel:Help( "2 = HL2 Accuracy" )
	--	panel:Help( "10 = Can't hit shit." )
	--	panel:ControlHelp( "" )
	--	panel:ControlHelp( "Client Settings" )
	--	panel:NumSlider( "Viewmodel sway", "cl_drc_sway", 0, 2, 1 )
	--	panel:CheckBox( "Enable Debug HUD", "cl_drc_debugmode")
	--	panel:CheckBox( "Sell your soul to Vuthakral", "cl_drc_sell_soul")
	end )
	
	spawnmenu.AddToolMenuOption( "Options", "Draconic", "Playermodel Extensions", "Playermodel Extensions", "", "", function( panel )
	local button2 = panel:Button("Open Menu")
		function button2:OnMousePressed()
			PEXMenu( LocalPlayer() )
		end
	end )
end )
--]]

function DRCMenu( player )
    local ply = player
    
	local usekey = string.upper(ReturnKey("+use"))
	local m1key = string.upper(ReturnKey("+attack"))
	local m2key = string.upper(ReturnKey("+attack2"))
	local m3key = string.upper(ReturnKey("+attack3"))
	local sprintkey = string.upper(ReturnKey("+speed"))
	local duckkey = string.upper(ReturnKey("+duck"))
	local jumpkey = string.upper(ReturnKey("+jump"))
	local reloadkey = string.upper(ReturnKey("+reload"))
	local forwkey = string.upper(ReturnKey("+forward"))
	
    local w2 = ScrW()/2 
    local leftwide = w2
    local leftwidehalf = leftwide / 2
 	      	      	         
    local h2 = ScrH()
    local topwide = h2
    local topwidehalf = topwide / 2
	
	local TextCol = Color(220, 220, 220, 255)
	local SubtextCol = Color(170, 170, 170, 255)
	local NotifyCol = Color(255, 255, 255, 255)
    
    local Derma = vgui.Create("DFrame")
    Derma:SetPos( leftwidehalf/1.25, topwidehalf/4 )
    Derma:SetSize( leftwide*1.25, topwide/1.5)
    Derma:SetTitle("Draconic Settings Menu")
	Derma:MakePopup()
	Derma:SetBackgroundBlur(true)
	Derma:SetScreenLock(true)
    Derma.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 127))
    end
	
	local mainframe = vgui.Create("DPanel", Derma)
	mainframe:Dock( FILL )
	mainframe:SetBackgroundColor(Color(0, 0, 0, 127))
	
	local maintabs = vgui.Create( "DPropertySheet", mainframe )
	maintabs:Dock( FILL )
	maintabs:SetPadding(0)
	maintabs.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
	
	local mt1 = vgui.Create( "DPanel", maintabs )
	mt1:SetBackgroundColor(Color(255, 255, 255, 5))
	maintabs:AddSheet( "Playermodel", mt1)
    
    local frame = vgui.Create("DPanel", mt1)
    frame:SetPos(0, 0)
    frame:SetSize(512, topwide/1.5-24)
    frame:SetBackgroundColor(Color(255, 255, 255, 5))
	
	local frame2 = vgui.Create("DPanel", mt1)
	frame2:SetPos(leftwide*1.25/2, -1)
	frame2:SetSize(leftwide*1.25/2, topwide/1.5-54)
	frame2:SetBackgroundColor(Color(255, 255, 255, 15))
    
    local preview = vgui.Create("DModelPanel", frame)
    preview:SetPos(0, 0)
    preview:SetSize(leftwide*1.25/2, topwide/1.5-24)
    preview:SetFOV(72)
	preview:SetAnimated( true )
    preview:SetAnimationEnabled(true)
	preview:SetAmbientLight(Color(127, 127, 127, 255))
    preview:SetDirectionalLight(BOX_TOP, Color(200, 200, 200))
    preview:SetDirectionalLight(BOX_FRONT, Color(200, 200, 200))
	
	function preview.SetupData()
		preview.Angles = Angle( 0, 45, 0 )
		preview.Pos = Vector( 0, 0, 0 )
	end
	preview.SetupData()
	
	function preview:DragMousePress( button )
		self.DownX, self.DownY = gui.MousePos()
		self.Pressed = button
	end

	function preview:DragMouseRelease() self.Pressed = false end
	
	local fov = preview:GetFOV()
    function preview:LayoutEntity( ent )
	
        local idle = ent:SelectWeightedSequence(ACT_HL2MP_IDLE)
		local LA = (self.vLookatPos-self.vCamPos):Angle()
		local cmx, cmy = gui.MousePos()
		
		if (self.Pressed == MOUSE_LEFT) then			
			self.Angles = self.Angles - Angle(0, (self.DownX or cmx) - cmx, 0) / 5
			self.Pos = self.Pos - Vector(0, 0, (self.DownY*(-0.1) or cmy*(-0.1)) - cmy*(-0.1))
			self.DownX, self.DownY = gui.MousePos()
		--elseif (self.Pressed == MOUSE_RIGHT) then
		--	preview:SetFOV((cmy / 16) - topwide)
		end
		
        ent:SetSequence(idle)
		ent:SetAngles( self.Angles )
		ent:SetPos( self.Pos )
        preview:RunAnimation()
		
	--	yaw = yaw + 1
    end
	
	local tabs = vgui.Create( "DPropertySheet", frame2 )
	tabs:Dock( FILL )
	tabs:SetPadding(0)
	tabs.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
	
	local tab1 = vgui.Create( "DPanel", tabs )
	tab1:SetBackgroundColor( Color(245, 245, 245, 0) )
	tabs:AddSheet( "Playermodels", tab1)
				
	local tab2 = vgui.Create( "DPanel", tabs )
	tab2:SetBackgroundColor( Color(245, 245, 245, 0) )
	tab2:Dock( FILL )
	tabs:AddSheet( "Colours", tab2 )
	
	local t3c = vgui.Create( "DPanel", tabs )
	t3c:SetBackgroundColor( Color(0, 0, 0, 0) )
	t3c:SetPos(-200, 0)
	
	local t3p = t3c:Add( "DPanelList" )
	t3p:DockPadding( 64, 8, 8, 8 )
	t3p:EnableVerticalScrollbar( true )
	t3p:Dock( FILL )
	
	local tab3 = tabs:AddSheet( "#smwidget.bodygroups", t3p, "icon16/cog.png" )
	
	local modelListPnl = tab1:Add( "DPanel" )
	modelListPnl:DockPadding( 8, 0, 8, 0 )
	modelListPnl:Dock( FILL )
	modelListPnl:SetBackgroundColor(Color(0, 0, 0, 0))
	
	local SearchBar = modelListPnl:Add( "DTextEntry" )
	SearchBar:Dock( TOP )
	SearchBar:DockMargin( 0, 0, 0, 0 )
	SearchBar:SetUpdateOnType( true )
	SearchBar:SetPlaceholderText( "#spawnmenu.quick_filter" )
	
	local PanelSelect = modelListPnl:Add( "DPanelSelect" )
	PanelSelect:Dock( FILL )
	PanelSelect:SetBackgroundColor(Color(0, 0, 0, 0))
	PanelSelect.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
	
	for name, model in SortedPairs( player_manager.AllValidModels() ) do

		local icon = vgui.Create( "SpawnIcon" )
		icon:SetModel( model )
		icon:SetSize( 64, 64 )
		icon:SetTooltip( name )
		icon.playermodel = name
		icon.model_path = model

		PanelSelect:AddPanel( icon, { cl_playermodel = name } )

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
	
    local ScrollPrim = vgui.Create("DScrollPanel", tab2)
	ScrollPrim:SetPos(0, 0)
	ScrollPrim:Dock( FILL )
	ScrollPrim:DockMargin(32, 0, 16, 0)
	ScrollPrim:SetBackgroundColor(Color(255, 255, 255, 25))
	
	local row1 = vgui.Create("DPanel", ScrollPrim)
	row1:SetPos(0, 0)
	row1:SetSize(leftwide*1.25/2, topwide/6 + 12)
	row1:SetBackgroundColor(Color(255, 255, 255, 0))
	
	local row2 = vgui.Create("DPanel", ScrollPrim)
	row2:SetPos(0, topwide/6 + 12)
	row2:SetSize(leftwide*1.25/2, topwide/6 + 12)
	row2:SetBackgroundColor(Color(255, 255, 255, 0))
	
	local row3 = vgui.Create("DPanel", ScrollPrim)
	row3:SetPos(0, topwide/6 + 12 + (topwide/6 + 12))
	row3:SetSize(leftwide*1.25/2, topwide/6 + 12)
	row3:SetBackgroundColor(Color(255, 255, 255, 0))
	
	local playercolour = vgui.Create("DColorMixer", row1)
	playercolour:Dock( LEFT )
	playercolour:SetSize(leftwide*1.25/4.65, topwide/6 + 12)
	playercolour:SetLabel("Player Colour")
	playercolour:SetPalette(false)
	playercolour:SetAlphaBar(false)
	playercolour:SetVector( Vector( GetConVarString( "cl_playercolor" ) ) );
	
	local weaponcolour = vgui.Create("DColorMixer", row1)
	weaponcolour:Dock( LEFT )
	weaponcolour:SetSize(leftwide*1.25/4.65, topwide/6 + 12)
	weaponcolour:SetLabel("Weapon Colour")
	weaponcolour:SetPalette(false)
	weaponcolour:SetAlphaBar(false)
	weaponcolour:SetVector( Vector( GetConVarString( "cl_weaponcolor" ) ) );
	
	local eyecolour = vgui.Create("DColorMixer", row2)
	eyecolour:Dock( LEFT )
	eyecolour:SetSize(leftwide*1.25/4.65, topwide/6 + 12)
	eyecolour:SetLabel("Eye Colour")
	eyecolour:SetPalette(false)
	eyecolour:SetAlphaBar(false)
	eyecolour:SetConVarR("cl_drc_eyecolour_r")
	eyecolour:SetConVarG("cl_drc_eyecolour_g")
	eyecolour:SetConVarB("cl_drc_eyecolour_b")
	
	local energyColour = vgui.Create("DColorMixer", row2)
	energyColour:Dock( LEFT )
	energyColour:SetSize(leftwide*1.25/4.65, topwide/6 + 12)
	energyColour:SetLabel("Energy / Light Colour")
	energyColour:SetPalette(false)
	energyColour:SetAlphaBar(false)
	energyColour:SetConVarR("cl_drc_energycolour_r")
	energyColour:SetConVarG("cl_drc_energycolour_g")
	energyColour:SetConVarB("cl_drc_energycolour_b")
	
	local accentColour1 = vgui.Create("DColorMixer", row3)
	accentColour1:Dock( LEFT )
	accentColour1:SetSize(leftwide*1.25/4.65, topwide/6 + 12)
	accentColour1:SetLabel("Accent Colour 1")
	accentColour1:SetPalette(false)
	accentColour1:SetAlphaBar(false)
	accentColour1:SetConVarR("cl_drc_tint1_r")
	accentColour1:SetConVarG("cl_drc_tint1_g")
	accentColour1:SetConVarB("cl_drc_tint1_b")
	
	local accentColour2 = vgui.Create("DColorMixer", row3)
	accentColour2:Dock( LEFT )
	accentColour2:SetSize(leftwide*1.25/4.65, topwide/6 + 12)
	accentColour2:SetLabel("Accent Colour 2")
	accentColour2:SetPalette(false)
	accentColour2:SetAlphaBar(false)
	accentColour2:SetConVarR("cl_drc_tint2_r")
	accentColour2:SetConVarG("cl_drc_tint2_g")
	accentColour2:SetConVarB("cl_drc_tint2_b")
	
	local function UpdateGmodColours()
		RunConsoleCommand( "cl_playercolor", tostring( playercolour:GetVector() ))
		RunConsoleCommand( "cl_weaponcolor", tostring( weaponcolour:GetVector() ))
		RunConsoleCommand( "drc_refreshcolours")
	end
	
	playercolour.ValueChanged = UpdateGmodColours
	weaponcolour.ValueChanged = UpdateGmodColours
	eyecolour.ValueChanged = UpdateGmodColours
	energyColour.ValueChanged = UpdateGmodColours
	accentColour1.ValueChanged = UpdateGmodColours
	accentColour2.ValueChanged = UpdateGmodColours
	
		local function UpdateBodyGroups( pnl, val )
			if ( pnl.type == "bgroup" ) then

				preview.Entity:SetBodygroup( pnl.typenum, math.Round( val ) )

				local str = string.Explode( " ", GetConVarString( "cl_playerbodygroups" ) )
				if ( #str < pnl.typenum + 1 ) then for i = 1, pnl.typenum + 1 do str[ i ] = str[ i ] or 0 end end
				str[ pnl.typenum + 1 ] = math.Round( val )
				RunConsoleCommand( "cl_playerbodygroups", table.concat( str, " " ) )

			elseif ( pnl.type == "skin" ) then

				preview.Entity:SetSkin( math.Round( val ) )
				ply:SetSkin( math.Round( val ) )
				RunConsoleCommand( "cl_playerskin", math.Round( val ) )

			end
		end
	
		local function RebuildBodygroupTab()
			t3p:Clear()

			tab3.Tab:SetVisible( false )

			local nskins = preview.Entity:SkinCount() - 1
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

				preview.Entity:SetSkin( GetConVarNumber( "cl_playerskin" ) )

				tab3.Tab:SetVisible( true )
			end

			local groups = string.Explode( " ", GetConVarString( "cl_playerbodygroups" ) )
			for k = 0, preview.Entity:GetNumBodyGroups() - 1 do
				if ( preview.Entity:GetBodygroupCount( k ) <= 1 ) then continue end

				local bgroup = vgui.Create( "DNumSlider" )
				bgroup:Dock( TOP )
				bgroup:SetText( preview.Entity:GetBodygroupName( k ) )
				bgroup:SetDark( true )
				bgroup:SetTall( 50 )
				bgroup:SetDecimals( 0 )
				bgroup.type = "bgroup"
				bgroup.typenum = k
				bgroup:SetMax( preview.Entity:GetBodygroupCount( k ) - 1 )
				bgroup:SetValue( groups[ k + 1 ] or 0 )
				bgroup.OnValueChanged = UpdateBodyGroups

				t3p:AddItem( bgroup )

				preview.Entity:SetBodygroup( k, groups[ k + 1 ] or 0 )

				tab3.Tab:SetVisible( true )
			end

			tabs.tabScroller:InvalidateLayout()
		end
		
		local function UpdateFromConvars()

			local model = LocalPlayer():GetInfo( "cl_playermodel" )
			local modelname = player_manager.TranslatePlayerModel( model )
			util.PrecacheModel( modelname )
			preview:SetModel( modelname )
			preview.Entity.GetPlayerColor = function() return Vector( GetConVarString( "cl_playercolor" ) ) end

			playercolour:SetVector( Vector( GetConVarString( "cl_playercolor" ) ) )
			weaponcolour:SetVector( Vector( GetConVarString( "cl_weaponcolor" ) ) )

		--	PlayPreviewAnimation( preview, model )
			RebuildBodygroupTab()

		end
	UpdateFromConvars()
	
	function PanelSelect:OnActivePanelChanged( old, new )

		if ( old != new ) then -- Only reset if we changed the model
			RunConsoleCommand( "cl_playerbodygroups", "0" )
			RunConsoleCommand( "cl_playerskin", "0" )
		end

		timer.Simple( 0.1, function() UpdateFromConvars() end )

	end
	
	local mt2 = vgui.Create( "DPanel", maintabs )
	mt2:SetBackgroundColor(Color(255, 255, 255, 5))
	maintabs:AddSheet( "SWEP Base", mt2)
	
	local t2frame = vgui.Create("DPanel", mt2)
	t2frame:SetBackgroundColor(Color(255, 255, 255, 5))
	t2frame:Dock( FILL )
	
	local t2tabs = vgui.Create("DPropertySheet", t2frame)
	t2tabs:Dock( FILL )
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
	ControlsText:SetText("Primary attack: \nSecondary attack / ironsights: \nReload / Vent: \nReload secondary: \nToggle passive: \nSwitch firemode: \nInspect weapon: \nMelee (guns) / Lunge (melees): ")
	ControlsText:SetColor(TextCol)
	ControlsText:SetContentAlignment(4)
	
	local ControlsValue = vgui.Create( "DLabel", controls2 )
	ControlsValue:Dock(TOP)
	ControlsValue:SetSize(1, 160)
	ControlsValue:SetText("".. m1key .."\n".. m2key .."\n".. reloadkey .."\n".. sprintkey .." + ".. reloadkey .."\n".. sprintkey .." + ".. usekey .." + ".. m2key .."\n".. usekey .." + ".. m2key .."\n".. usekey .. " + ".. reloadkey .."\n".. usekey .. " + ".. m1key .."")
	ControlsValue:SetColor(NotifyCol)
	ControlsValue:SetContentAlignment(6)
	
	local t2tab1 = vgui.Create( "DPanel" )
	t2tab1:Dock( FILL )
	t2tab1.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
	t2tabs:AddSheet( "Client Settings", t2tab1)
	
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
	
	local VMOX = vgui.Create( "DNumSlider", t2tab1 )
	VMOX:SetPos(25, 145)
	VMOX:SetSize(300, 20)
	VMOX:SetText( "Global viewmodel offset X" )
	VMOX.Label:SetColor(TextCol)
	VMOX:SetMin( -10 )
	VMOX:SetMax( 10 )
	VMOX:SetDecimals( 4 )
	VMOX:SetConVar( "cl_drc_vmoffset_x" )
	VMOX:SetEnabled(true)
	
	local VMOY = vgui.Create( "DNumSlider", t2tab1 )
	VMOY:SetPos(25, 165)
	VMOY:SetSize(300, 20)
	VMOY:SetText( "Global viewmodel offset Y" )
	VMOY.Label:SetColor(TextCol)
	VMOY:SetMin( -10 )
	VMOY:SetMax( 10 )
	VMOY:SetDecimals( 4 )
	VMOY:SetConVar( "cl_drc_vmoffset_y" )
	VMOY:SetEnabled(true)
	
	local VMOZ = vgui.Create( "DNumSlider", t2tab1 )
	VMOZ:SetPos(25, 185)
	VMOZ:SetSize(300, 20)
	VMOZ:SetText( "Global viewmodel offset Y" )
	VMOZ.Label:SetColor(TextCol)
	VMOZ:SetMin( -10 )
	VMOZ:SetMax( 10 )
	VMOZ:SetDecimals( 4 )
	VMOZ:SetConVar( "cl_drc_vmoffset_z" )
	VMOZ:SetEnabled(true)
	
--[[
	local WeaponSway = vgui.Create( "DNumSlider", t2tab1 )
	WeaponSway:SetPos(25, 55)
	WeaponSway:SetSize(300, 20)
	WeaponSway:SetText( "View Sway Scale" )
	WeaponSway.Label:SetColor(TextCol)
	WeaponSway:SetMin( 0 )
	WeaponSway:SetMax( 1 )
	WeaponSway:SetDecimals( 2 )
	WeaponSway:SetConVar( "cl_drc_sway" )
	WeaponSway:SetEnabled(true)
	

	local SwayNotify = vgui.Create( "DLabel", t2tab1)
	SwayNotify:SetPos(25, 75)
	SwayNotify:SetSize(w2, 60)
	SwayNotify:SetText("Swaying code is currently disabled due to odd server-sided conflictions. Research is underway on another way to do this effect.")
	SwayNotify:SetColor(NotifyCol)
	SwayNotify:SetContentAlignment(7)
	--]]
	
	local t2tab2 = vgui.Create( "DPanel" )
	t2tab2:Dock( FILL )
	t2tab2.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
	t2tabs:AddSheet( "Server Settings", t2tab2)
	
				local DrcMovement = vgui.Create( "DCheckBoxLabel", t2tab2 )
				DrcMovement:SetPos(25, 15)
				DrcMovement:SetSize(20, 20)
				DrcMovement:SetText( "Enable SWEP movement speed overrides" )
				DrcMovement:SetConVar( "sv_drc_movement" )
				DrcMovement.Label:SetColor(TextCol)
				
				local DrcMoveSounds = vgui.Create( "DCheckBoxLabel", t2tab2 )
				DrcMoveSounds:SetPos(25, 35)
				DrcMoveSounds:SetSize(20, 20)
				DrcMoveSounds:SetText( "Enable SWEP movement sounds" )
				DrcMoveSounds:SetConVar( "sv_drc_movesounds" )
				DrcMoveSounds.Label:SetColor(TextCol)
				
				local DrcInspections = vgui.Create( "DCheckBoxLabel", t2tab2 )
				DrcInspections:SetPos(25, 55)
				DrcInspections:SetSize(20, 20)
				DrcInspections:SetText( "Enable SWEP Inspection Menu" )
				DrcInspections:SetConVar( "sv_drc_inspections" )
				DrcInspections.Label:SetColor(TextCol)
				
				local DrcPassive = vgui.Create( "DCheckBoxLabel", t2tab2 )
				DrcPassive:SetPos(25, 75)
				DrcPassive:SetSize(20, 20)
				DrcPassive:SetText( "Enable SWEP Passives" )
				DrcPassive:SetConVar( "sv_drc_passives" )
				DrcPassive.Label:SetColor(TextCol)
				
				local DrcSprintOverride = vgui.Create( "DCheckBoxLabel", t2tab2 )
				DrcSprintOverride:SetPos(25, 95)
				DrcSprintOverride:SetSize(20, 20)
				DrcSprintOverride:SetText( "Override all DSB weapons to enable sprint passives" )
				DrcSprintOverride:SetConVar( "sv_drc_force_sprint" )
				DrcSprintOverride.Label:SetColor(TextCol)
				
				local DrcCawadoody = vgui.Create( "DCheckBoxLabel", t2tab2 )
				DrcCawadoody:SetPos(25, 115)
				DrcCawadoody:SetSize(20, 20)
				DrcCawadoody:SetText( "Allow weapons to use unrealistic 'Call of Duty' bullet spread" )
				DrcCawadoody:SetConVar( "sv_drc_callofdutyspread" )
				DrcCawadoody.Label:SetColor(TextCol)
				
				local LGTitle = vgui.Create( "DLabel", t2tab2)
				LGTitle:SetPos(50, 125)
				LGTitle:SetSize(w2, 20)
				LGTitle:SetText("(This means 'Allow weapons to magically decrease bullet spread when down sights')")
				LGTitle:SetColor(SubtextCol)
				
				local DrcDistGunfire = vgui.Create( "DCheckBoxLabel", t2tab2 )
				DrcDistGunfire:SetPos(25, 145)
				DrcDistGunfire:SetSize(20, 20)
				DrcDistGunfire:SetText( "Disable distant gunfire sounds (can alleviate network usage on larger servers)" )
				DrcDistGunfire:SetConVar( "sv_drc_disable_distgunfire" )
				DrcDistGunfire.Label:SetColor(TextCol)
				
				--[[
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
	maintabs:AddSheet( "Credits", mt3)
	
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
				}
				h4{
					font-family: Verdana;
					
					color: lightgrey;
					margin: 0;
					margin-left: 2em;
					margin-bottom: 1em;
				}
				ul{
					font-family: "Lucida Console";
					color: lightgrey;
					margin-left: 3em;
					margin-top: 0.1em;
					margin-bottom: 0.1em;
				}
				li{
					margin-top: 0.25em;
					margin-bottom: 0.25em;
					width: 65%;
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
					
			<body style="background-color: rgba(11,11,33, 0.7); position: absolute; margin: 0 auto; width: 100%; height: auto;">
				<br>
				<h2>Draconic Base</h2>		
				<h3>Credits</h3>
				<h4>Programmming</h4>
					<p class="ultitle">Vuthakral</p>
					<ul>
						<li>Everything not listed below this credit</li>
					</ul>
					<br>
					<p class="ultitle">Clavus</p>
					<ul>
						<li>SWEP Construction Kit code</li>
					</ul>
					<br>
				<h4>Bug testing</h4>
					<p class="ultitle">Valkyries733</p>
					<ul>
						<li>Consistent help in bug testing issues with many different aspects of the Draconic Base</li>
					</ul>
					<br>
				<h4>Special Thanks</h4>
					<p class="ultitle">All of the people who have supported me through working on all of my projects</p>
					<ul>
						<li>My girlfriend, who has always been there for me even when things are at their worst. If you're reading this, I love you very much.</li>
						<li>My father, who has always been there for me with doing what I do, and putting up with my ramblings about all of it even if he doesn't understand them.</li>
					</ul>
					<br>
					<p class="ultitle">The people in TFA's Discord</p>
					<ul>
						<li>Tons of help when I ran into walls with code I was trying to do. Very helpful people.</li>
					</ul>
					<br>
					<p class="ultitle">Wingblast</p>
					<ul>
						<li>Showed me how to originally implement the perspective change for weapons when looking up/down.</li>
					</ul>
					<br>
					<p class="ultitle">Vioxtar</p>
					<ul>
						<li>Created a vFire flamethrower which allowed me to learn how to integrate vFire into my base.</li>
					</ul>
					<br>
					<p class="ultitle">Clavus</p>
					<ul>
						<li>Creator of the "SWEP Construction Kit" -- Seriously dude, your addon has greatly contributed to the Garry's Mod 13 community & experience. Thank you.</li>
					</ul>
					<br>
			</body>
		</html>
				]] )
				
	local mt4 = vgui.Create( "DPanel", maintabs )
	mt4:SetBackgroundColor(Color(255, 255, 255, 10))
	maintabs:AddSheet( "Debug", mt4)
	
	local t4tabs = vgui.Create("DPropertySheet", mt4)
	t4tabs:Dock( FILL )
	t4tabs:SetPadding(0)
	t4tabs.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
	
	local t4tab1 = vgui.Create( "DPanel" )
	t4tab1:Dock( FILL )
	t4tab1.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
	t4tabs:AddSheet( "Debug Information", t4tab1)
	
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
	DebugInfo:SetText("Ambient light: ".. tostring(render.GetAmbientLightColor()) .."")
	DebugInfo:SetColor(TextCol)
	
	local DebugInfo = vgui.Create( "DLabel", debug_gameinfo)
	DebugInfo:SetFont("DermaLarge")
	DebugInfo:SetPos(235, 155)
	DebugInfo:SetSize(50, 20)
	DebugInfo:SetText("■")
	DebugInfo:SetColor(Color(render.GetAmbientLightColor().x * 255, render.GetAmbientLightColor().y * 255, render.GetAmbientLightColor().z * 255, 255))
	
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
	
	local DebugInfo = vgui.Create( "DLabel", t4tab1)
	DebugInfo:SetPos(25, 40)
	DebugInfo:SetSize(300, 20)
	DebugInfo:SetText("Local light level >> ".. tostring(render.GetAmbientLightColor()) .."")
	DebugInfo:SetColor(TextCol)
	
	local col = render.GetLightColor(LocalPlayer():EyePos()) * 255
	local DebugInfo = vgui.Create( "DLabel", t4tab1)
	DebugInfo:SetFont("DermaLarge")
	DebugInfo:SetPos(275, 35)
	DebugInfo:SetSize(50, 20)
	DebugInfo:SetText("■")
	DebugInfo:SetColor(Color(col.x, col.y, col.z, 255))
	
	local t4tab2 = vgui.Create( "DPanel" )
	t4tab2:Dock( FILL )
	t4tab2.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
	t4tabs:AddSheet( "Debug Mode Settings", t4tab2)
	
	local DebugSetting = vgui.Create( "DCheckBoxLabel", t4tab2 )
	DebugSetting:SetPos(25, 10)
	DebugSetting:SetSize(500, 20)
	DebugSetting:SetText( "Debug mode enabled (Requires sv_drc_allowdebug 1)" )
	DebugSetting:SetConVar( "cl_drc_debugmode" )
	DebugSetting.Label:SetColor(TextCol)
	DebugSetting:SetEnabled(true)
	
	local DebugSetting = vgui.Create( "DCheckBoxLabel", t4tab2 )
	DebugSetting:SetPos(25, 30)
	DebugSetting:SetSize(500, 20)
	DebugSetting:SetText( "Legacy 'DSB Debug Assistant'" )
	DebugSetting:SetConVar( "cl_drc_debug_legacyassistant" )
	DebugSetting.Label:SetColor(TextCol)
	DebugSetting:SetEnabled(true)
	
	local DebugSetting = vgui.Create( "DCheckBoxLabel", t4tab2 )
	DebugSetting:SetPos(25, 50)
	DebugSetting:SetSize(500, 20)
	DebugSetting:SetText( "Camera drag interpreter" )
	DebugSetting:SetConVar( "cl_drc_debug_cameradrag" )
	DebugSetting.Label:SetColor(TextCol)
	DebugSetting:SetEnabled(true)
	
	local DebugSetting = vgui.Create( "DCheckBoxLabel", t4tab2 )
	DebugSetting:SetPos(25, 70)
	DebugSetting:SetSize(500, 20)
	DebugSetting:SetText( "Invert near/far sound effects" )
	DebugSetting:SetConVar( "cl_drc_debug_invertnearfar" )
	DebugSetting.Label:SetColor(TextCol)
	DebugSetting:SetEnabled(true)
	
	local DebugSetting = vgui.Create( "DCheckBoxLabel", t4tab2 )
	DebugSetting:SetPos(25, 90)
	DebugSetting:SetSize(500, 20)
	DebugSetting:SetText( "Show viewmodel attachments" )
	DebugSetting:SetConVar( "cl_drc_debug_vmattachments" )
	DebugSetting.Label:SetColor(TextCol)
	DebugSetting:SetEnabled(true)
	
	local DebugSetting = vgui.Create( "DLabel", t4tab2)
	ControlsTitle:SetFont("DermaLarge")
	DebugSetting:SetPos(25, 110)
	DebugSetting:SetSize(100, 20)
	DebugSetting:SetText("Debug Crosshair:")
	DebugSetting:SetColor(TextCol)
	
	local DebugCrosshair = vgui.Create( "DComboBox", t4tab2 )
	DebugCrosshair:SetSortItems(false)
	DebugCrosshair:SetPos(125, 110)
	DebugCrosshair:SetSize(150, 20)
	DebugCrosshair:SetConVar( "cl_drc_debug_crosshairmode" )
	DebugCrosshair:AddChoice("Disabled", 0)
	DebugCrosshair:AddChoice("Standard", 1)
	DebugCrosshair:AddChoice("Melee travel only", 2)
	DebugCrosshair:AddChoice("Full", 3)
	function DebugCrosshair:OnSelect(index, value, data)
		LocalPlayer():ConCommand("cl_drc_debug_crosshairmode ".. index - 1 .."")
	end
end

local plc = Vector()
local wpc = Vector()
local t1c = Vector()
local t2c = Vector()
local eyc = Vector()
local enc = Vector()

local function UpdatePlayerColours(ply)
	if not IsValid(ply) then return end
	if not ply:Alive() then return end
	
	if ply != ply then return end
	
	playcol = ply:GetInfo("cl_playercolor")
	
	plc = Vector(playcol)
	
	weapcol = ply:GetWeaponColor()
	
	wpc = Vector(math.Round(weapcol.x, 0), math.Round(weapcol.y, 0), math.Round(weapcol.z, 0))
	
	t1c.x = ply:GetInfoNum("cl_drc_tint1_r", 127)
	t1c.y = ply:GetInfoNum("cl_drc_tint1_g", 127)
	t1c.z = ply:GetInfoNum("cl_drc_tint1_b", 127)
	
	t2c.x = ply:GetInfoNum("cl_drc_tint2_r", 127)
	t2c.y = ply:GetInfoNum("cl_drc_tint2_g", 127)
	t2c.z = ply:GetInfoNum("cl_drc_tint2_b", 127)
	
	eyc.x = ply:GetInfoNum("cl_drc_eyecolour_r", 127)
	eyc.y = ply:GetInfoNum("cl_drc_eyecolour_g", 127)
	eyc.z = ply:GetInfoNum("cl_drc_eyecolour_b", 127)
	
	enc.x = ply:GetInfoNum("cl_drc_energycolour_r", 127)
	enc.y = ply:GetInfoNum("cl_drc_energycolour_g", 127)
	enc.z = ply:GetInfoNum("cl_drc_energycolour_b", 127)

	ply:SetNWVector( "PlayerColour_DRC", plc)
	ply:SetNWVector( "WeaponColour_DRC", wpc)
	ply:SetNWVector( "ColourTintVec1", t1c)
	ply:SetNWVector( "ColourTintVec2", t2c)
	ply:SetNWVector( "EyeTintVec", eyc)
	ply:SetNWVector( "EnergyTintVec", enc)
	
	plc = Vector()
	wpc = Vector()
	t1c = Vector()
	t2c = Vector()
	eyc = Vector()
	enc = Vector()
	return
end
concommand.Add("drc_refreshcolours", UpdatePlayerColours)

hook.Add("PlayerSpawn", "drc_DoPlayerSettings", function(ply)
	UpdatePlayerColours(ply)
	
--[[	local hands = ply:GetHands()
	if !hands then return end
	local hbg = hands:GetBodyGroups()
	
	local convar = GetConVar("cl_playerbodygroups")
	hands:SetBodyGroups(convar) --]]
end)

-- ayylmao a high enough ping can make some stuff in :Holster() and :OnRemove() not work because Source loves controlling stuff server-side
-- also :Holster() and :OnRemove() logically don't apply when an NPC dies lol
hook.Add("DoPlayerDeath", "drc_stfu1", function(ply)
	if !IsValid(ply) then return end
	
	local wpn = ply:GetActiveWeapon()
	if !IsValid(wpn) then return end
	if wpn.Draconic == nil then return end
	if wpn.ChargeSound == nil then return end
	if wpn.Primary.LoopingFireSound == nil then return end
	if wpn.LoopFireSound == nil then return end
	
	wpn:StopSound(wpn.ChargeSound)
	wpn:StopSound(wpn.Primary.LoopingFireSound)
	wpn.LoopFireSound:Stop()
end)

hook.Add("PlayerSwitchWeapon", "drc_stfu2", function(ply)
	if !IsValid(ply) then return end
	
	local wpn = ply:GetActiveWeapon()
	if !IsValid(wpn) then return end
	if wpn.Draconic == nil then return end
	if wpn.IsMelee == true then return end
	if wpn.ChargeSound == nil then return end
	if wpn.Primary.LoopingFireSound == nil then return end
	if wpn.LoopFireSound == nil then return end
	
	wpn:StopSound(wpn.ChargeSound)
	wpn:StopSound(wpn.Primary.LoopingFireSound)
	wpn.LoopFireSound:Stop()
end)

hook.Add("OnNPCKilled", "drc_stfu3", function(npc) -- why does this trigger for nextbots?
	if !IsValid(npc) then return end
	
	local wpn = nil
	if npc:IsNPC() then
		wpn = npc:GetActiveWeapon()
	elseif npc:IsNextBot() then
		wpn = npc.Weapon
	end
	
	if !IsValid(wpn) then return end
	if wpn.Draconic == nil then return end
	if wpn.IsMelee == true then return end
	if wpn.ChargeSound == nil then return end
	if wpn.Primary.LoopingFireSound == nil then return end
	if wpn.LoopFireSound == nil then return end
	
	wpn:StopSound(wpn.ChargeSound)
	wpn:StopSound(wpn.Primary.LoopingFireSound)
	wpn.LoopFireSound:Stop()
end)

hook.Add("PlayerTick", "drc_movementhook", function(ply)
	if GetConVar("sv_drc_movement"):GetString() == "0" then return end
	local wpn = ply:GetActiveWeapon()
	local cv = ply:Crouching()
	local forwkey = ply:KeyDown(IN_FORWARD)
	local backkey = ply:KeyDown(IN_BACK)
	local leftkey = ply:KeyDown(IN_MOVELEFT)
	local rightkey = ply:KeyDown(IN_MOVERIGHT)
	local sprintkey = ply:KeyDown(IN_SPEED)
	local swimming = ply:WaterLevel() >= 3
	local dry = ply:WaterLevel() <=2
		
		local ogs = ply:GetNWFloat("PlayerOGSpeed")
		local ogw = ply:GetNWFloat("PlayerOGWalk")
		local ogj = ply:GetNWFloat("PlayerOGJump")
		local ogc = ply:GetNWFloat("PlayerOGCrouch")
		
		if ogs == nil or ogs == 0 then return end
		if ogw == nil or ogw == 0 then return end
		if ogj == nil or ogj == 0 then return end
		if ogc == nil or ogc == 0 then return end
		
		if wpn.Draconic == nil then return end
		if not IsValid(ply) or not ply:Alive() then return end
	
		if cv == true then
		if swimming then
		
		elseif dry then
			if forwkey && !sprintkey then
			if wpn.SpeedCrouchForward != nil then
				ply:SetWalkSpeed( wpn.SpeedCrouchForward )
				ply:SetRunSpeed( wpn.SpeedCrouchForward )
				if wpn.CrouchingJumpHeightFront != nil then
					ply:SetJumpPower( wpn.CrouchingJumpHeightFront )
				elseif wpn.CrouchingJumpHeightFront != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedCrouchForward != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.CrouchingJumpHeightFront != nil then
					ply:SetJumpPower( wpn.CrouchingJumpHeightFront )
				elseif wpn.CrouchingJumpHeightFront != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif backkey && !sprintkey then
			if wpn.SpeedCrouchBack != nil then
				ply:SetWalkSpeed( wpn.SpeedCrouchBack )
				ply:SetRunSpeed( wpn.SpeedCrouchBack )
				if wpn.CrouchingJumpHeightBack != nil then
					ply:SetJumpPower( wpn.CrouchingJumpHeightBack )
				elseif wpn.CrouchingJumpHeightBack != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedCrouchBack != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.CrouchingJumpHeightBack != nil then
					ply:SetJumpPower( wpn.CrouchingJumpHeightBack )
				elseif wpn.CrouchingJumpHeightBack != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif leftkey && !sprintkey then
			if wpn.SpeedCrouchLeft != nil then
				ply:SetWalkSpeed( wpn.SpeedCrouchLeft )
				ply:SetRunSpeed( wpn.SpeedCrouchLeft )
				if wpn.CrouchingJumpHeightLeft != nil then
					ply:SetJumpPower( wpn.CrouchingJumpHeightLeft )
				elseif wpn.CrouchingJumpHeightLeft != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedCrouchLeft != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.CrouchingJumpHeightLeft != nil then
					ply:SetJumpPower( wpn.CrouchingJumpHeightLeft )
				elseif wpn.CrouchingJumpHeightLeft != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif rightkey && !sprintkey then
			if wpn.SpeedCrouchRight != nil then
				ply:SetWalkSpeed( wpn.SpeedCrouchRight )
				ply:SetRunSpeed( wpn.SpeedCrouchRight )
				if wpn.CrouchingJumpHeightRight != nil then
					ply:SetJumpPower( wpn.CrouchingJumpHeightRight )
				elseif wpn.CrouchingJumpHeightRight != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedCrouchRight != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.CrouchingJumpHeightRight != nil then
					ply:SetJumpPower( wpn.CrouchingJumpHeightRight )
				elseif wpn.CrouchingJumpHeightRight != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif forwkey && sprintkey then
			if wpn.SpeedSprintCrouchForward != nil then
				ply:SetWalkSpeed( wpn.SpeedSprintCrouchForward )
				ply:SetRunSpeed( wpn.SpeedSprintCrouchForward )
				if wpn.StandingSprintJumpHeightFront != nil then
					ply:SetJumpPower( wpn.CrouchingSprintJumpHeightFront )
				elseif wpn.StandingSprintJumpHeightFront != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedCrouchForward != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				if wpn.StandingSprintJumpHeightFront != nil then
					ply:SetJumpPower( wpn.StandingSprintJumpHeightFront )
				elseif wpn.StandingSprintJumpHeightFront != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
			end
			elseif backkey && sprintkey then
			if wpn.SpeedSprintCrouchBack != nil then
				ply:SetWalkSpeed( wpn.SpeedSprintCrouchBack )
				ply:SetRunSpeed( wpn.SpeedSprintCrouchBack )
				if wpn.CrouchingSprintJumpHeightBack != nil then
					ply:SetJumpPower( wpn.CrouchingSprintJumpHeightBack )
				elseif wpn.CrouchingSprintJumpHeightBack != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedCrouchBack != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.CrouchingSprintJumpHeightBack != nil then
					ply:SetJumpPower( wpn.CrouchingSprintJumpHeightBack )
				elseif wpn.CrouchingSprintJumpHeightBack != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif leftkey && sprintkey then
			if wpn.SpeedSprintCrouchLeft != nil then
				ply:SetWalkSpeed( wpn.SpeedSprintCrouchLeft )
				ply:SetRunSpeed( wpn.SpeedSprintCrouchLeft )
				if wpn.CrouchingSprintJumpHeightLeft != nil then
					ply:SetJumpPower( wpn.CrouchingSprintJumpHeightLeft )
				elseif wpn.CrouchingSprintJumpHeightLeft != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedCrouchLeft != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.CrouchingSprintJumpHeightLeft != nil then
					ply:SetJumpPower( wpn.CrouchingSprintJumpHeightLeft )
				elseif wpn.CrouchingSprintJumpHeightLeft != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif rightkey && sprintkey then
			if wpn.SpeedSprintCrouchRight != nil then
				ply:SetWalkSpeed( wpn.SpeedSprintCrouchRight )
				ply:SetRunSpeed( wpn.SpeedSprintCrouchRight )
				if wpn.CrouchingSprintJumpHeightRight != nil then
					ply:SetJumpPower( wpn.CrouchingSprintJumpHeightRight )
				elseif wpn.CrouchingSprintJumpHeightRight != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedCrouchRight != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.CrouchingSprintJumpHeightRight != nil then
					ply:SetJumpPower( wpn.CrouchingSprintJumpHeightRight )
				elseif wpn.CrouchingSprintJumpHeightRight != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			end
		end
		elseif cv == false then
		if swimming then
		
		elseif dry then
			if forwkey && !sprintkey then
			if wpn.SpeedStandForward != nil then
				ply:SetWalkSpeed( wpn.SpeedStandForward )
				ply:SetRunSpeed( wpn.SpeedStandForward )
				if wpn.StandingJumpHeightFront != nil then
					ply:SetJumpPower( wpn.StandingJumpHeightFront )
				elseif wpn.StandingJumpHeightFront != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedStandForward != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.StandingJumpHeightFront != nil then
					ply:SetJumpPower( wpn.StandingJumpHeightFront )
				elseif wpn.StandingJumpHeightFront != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif backkey && !sprintkey then
			if wpn.SpeedStandBack != nil then
				ply:SetWalkSpeed( wpn.SpeedStandBack )
				ply:SetRunSpeed( wpn.SpeedStandBack )
				if wpn.StandingJumpHeightBack != nil then
					ply:SetJumpPower( wpn.StandingJumpHeightBack )
				elseif wpn.StandingJumpHeightBack != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedStandBack != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.StandingJumpHeightBack != nil then
					ply:SetJumpPower( wpn.StandingJumpHeightBack )
				elseif wpn.StandingJumpHeightBack != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif leftkey && !sprintkey then
			if wpn.SpeedStandLeft != nil then
				ply:SetWalkSpeed( wpn.SpeedStandLeft )
				ply:SetRunSpeed( wpn.SpeedStandLeft )
				if wpn.StandingJumpHeightLeft != nil then
					ply:SetJumpPower( wpn.StandingJumpHeightLeft )
				elseif wpn.StandingJumpHeightLeft != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedStandLeft != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.StandingJumpHeightLeft != nil then
					ply:SetJumpPower( wpn.StandingJumpHeightLeft )
				elseif wpn.StandingJumpHeightLeft != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif rightkey && !sprintkey then
			if wpn.SpeedStandRight != nil then
				ply:SetWalkSpeed( wpn.SpeedStandRight )
				ply:SetRunSpeed( wpn.SpeedStandRight )
				if wpn.StandingJumpHeightRight != nil then
					ply:SetJumpPower( wpn.StandingJumpHeightRight )
				elseif wpn.StandingJumpHeightRight != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedStandRight != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.StandingJumpHeightRight != nil then
					ply:SetJumpPower( wpn.StandingJumpHeightRight )
				elseif wpn.StandingJumpHeightRight != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif forwkey && sprintkey then
			if wpn.SpeedSprintStandForward != nil then
				ply:SetWalkSpeed( wpn.SpeedStandForward )
				ply:SetRunSpeed( wpn.SpeedSprintStandForward )
				if wpn.StandingSprintJumpHeightFront != nil then
					ply:SetJumpPower( wpn.StandingSprintJumpHeightFront )
				elseif wpn.StandingSprintJumpHeightFront != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedSprintStandForward != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.StandingSprintJumpHeightFront != nil then
					ply:SetJumpPower( wpn.StandingSprintJumpHeightFront )
				elseif wpn.StandingSprintJumpHeightFront != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif backkey && sprintkey then
			if wpn.SpeedSprintStandBack != nil then
				ply:SetWalkSpeed( wpn.SpeedStandBack )
				ply:SetRunSpeed( wpn.SpeedSprintStandBack )
				if wpn.StandingSprintJumpHeightBack != nil then
					ply:SetJumpPower( wpn.StandingSprintJumpHeightBack )
				elseif wpn.StandingSprintJumpHeightBack != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedSprintStandBack != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.StandingSprintJumpHeightBack != nil then
					ply:SetJumpPower( wpn.StandingSprintJumpHeightBack )
				elseif wpn.StandingSprintJumpHeightBack != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif leftkey && sprintkey then
			if wpn.SpeedSprintStandLeft != nil then
				ply:SetWalkSpeed( wpn.SpeedStandLeft )
				ply:SetRunSpeed( wpn.SpeedSprintStandLeft )
				if wpn.StandingSprintJumpHeightLeft != nil then
					ply:SetJumpPower( wpn.StandingSprintJumpHeightLeft )
				elseif wpn.StandingSprintJumpHeightLeft != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedSprintStandLeft != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.StandingSprintJumpHeightLeft != nil then
					ply:SetJumpPower( wpn.StandingSprintJumpHeightLeft )
				elseif wpn.StandingSprintJumpHeightLeft != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			elseif rightkey && sprintkey then
			if wpn.SpeedSprintStandRight != nil then
				ply:SetWalkSpeed( wpn.SpeedStandRight )
				ply:SetRunSpeed( wpn.SpeedSprintStandRight )
				if wpn.StandingSprintJumpHeightRight != nil then
					ply:SetJumpPower( wpn.StandingSprintJumpHeightRight )
				elseif wpn.StandingSprintJumpHeightRight != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed ( 1 )
			elseif wpn.SpeedSprintStandRight != nil then
				ply:SetWalkSpeed( ply:GetNWFloat("PlayerOGWalk") )
				ply:SetRunSpeed( ply:GetNWFloat("PlayerOGSpeed") )
				if wpn.StandingSprintJumpHeightRight != nil then
					ply:SetJumpPower( wpn.StandingSprintJumpHeightRight )
				elseif wpn.StandingSprintJumpHeightRight != nil then
					ply:SetJumpPower( ply:GetNWFloat("PlayerOGJump") )
				end
				ply:SetCrouchedWalkSpeed( ply:GetNWFloat("PlayerOGCrouch") )
			end
			end
		end
		end
		
	if GetConVar("sv_drc_movesounds"):GetString() == "1" then
	if ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_FORWARD) && ply:KeyPressed(IN_SPEED) && wpn.DoSSCrouchFwd == true then
	-- crouch sprint sound forward
		ply:EmitSound( wpn.SprintSoundCrouch )
	elseif ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_BACK) && ply:KeyPressed(IN_SPEED) && wpn.DoSSCrouchBack == true then
	-- crouch sprint sound back
		ply:EmitSound( wpn.SprintSoundCrouch )
	elseif ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_MOVELEFT) && ply:KeyPressed(IN_SPEED) && wpn.DoSSCrouchLeft == true then
	-- crouch sprint sound left
		ply:EmitSound( wpn.SprintSoundCrouch )
	elseif ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_MOVERIGHT) && ply:KeyPressed(IN_SPEED) && wpn.DoSSCrouchRight == true then
	-- crouch sprint sound right
		ply:EmitSound( wpn.SprintSoundCrouch )
	end
		
	if ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_FORWARD) && ply:KeyPressed(IN_JUMP) && ply:KeyDown(IN_SPEED) && wpn.DoSJCrouchSFwd == true then
	-- Crouch Sprint Jump Sound Front
		ply:EmitSound( wpn.SJumpCrouchSound )
	elseif ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_BACK) && ply:KeyPressed(IN_JUMP) && ply:KeyDown(IN_SPEED) && wpn.DoSJCrouchSBack == true then
	-- Crouch Sprint Jump Sound Front
		ply:EmitSound( wpn.SJumpCrouchSound )
	elseif ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_MOVELEFT) && ply:KeyPressed(IN_JUMP) && ply:KeyDown(IN_SPEED) && wpn.DoSJCrouchLeft == true then
	-- Crouch Sprint Jump Sound Front
		ply:EmitSound( wpn.SJumpCrouchSound )
	elseif ply:GetMoveType() == MOVETYPE_WALK && cv == true && ply:OnGround() && ply:WaterLevel() < 1 && ply:KeyDown(IN_MOVERIGHT) && ply:KeyPressed(IN_JUMP) && ply:KeyDown(IN_SPEED) && wpn.DoSJCrouchRight == true then
	-- Crouch Sprint Jump Sound Front
		ply:EmitSound( wpn.SJumpCrouchSound )
	end
	else end	
		if wpn.FallDamage == false && wpn.NoFallDamageCrouchOnly == true then
		if cv == true then
			wpn.Owner.ShouldReduceFallDamage = true
		elseif  cv == false then
			wpn.Owner.ShouldReduceFallDamage = false
		end
		elseif wpn.FallDamage == false && wpn.NoFallDamageCrouchOnly == false then
		wpn.Owner.ShouldReduceFallDamage = true
		elseif wpn.FallDamage == true then
		wpn.Owner.ShouldReduceFallDamage = false
		end
end)

hook.Add("CalcView", "drc_tpgun", function(ply, pos, angles, fov)
	local curswep = ply:GetActiveWeapon()
	if curswep.Draconic != true then return end
	if curswep.Thirdperson != true then return end
	
	local root = LocalPlayer():LookupBone("ValveBiped.Bip01_R_Forearm")
	local av = ply:GetAimVector()
	local ea = ply:EyeAngles()
	local ep = ply:EyePos()
	local endp = ply:LocalToWorld( Vector(-20, -20, ep.z/2) )
	local po = Vector(-45 * av.x, -45 * av.y, -25 * av.z * Lerp(-ea.x, 1, 5)) - av * Vector(0, 0, -25) + Vector(0, 0, 35)
	local pole = endp - Vector(0, 0, ep.z / 2) + po
	
	local tr = util.TraceLine( {
		start = ep,
		endpos = pole,
		filter = LocalPlayer()
	} )
	
	local et = util.TraceLine( {
		start = pole,
		endpos = ply:GetEyeTrace().Hitpos,
		filter = LocalPlayer()
	} )
	
	if curswep.Thirdperson == true then
		view = {}
		view.origin = tr.HitPos
		view.angles = Angle( angles.x, angles.y, angles.z )

		view.fov = Lerp(FrameTime() * 0.01, LocalPlayer():GetFOV() or 100, 100) - 15


		view.drawviewer = true
		view.znear = 1
	else
		view = {}
		view.origin = origin
		view.angles = angles
		view.fov = fov
		view.drawviewer = false
		view.znear = 1
	end
	
	return view
end)

local function PlayReadyAnim(ply, anim)
	if !IsValid(ply) then 
		DRCNotify(nil, nil, "critical", "Player entity is null?! Something might be seriously wrong with your gamemode, that's all I know!", ENUM_ERROR, 10)
	return end
	
	if wOS then return end -- temp
	
	local seq = ply:SelectWeightedSequence(anim)
	local dur = ply:SequenceDuration(seq)
	
	local wpn = ply:GetActiveWeapon()
	
	if ply.DrcLastWeaponSwitch == nil then ply.DrcLastWeaponSwitch = CurTime() end
	
	if IsValid(ply) then
		DRCCallGesture(ply, GESTURE_SLOT_CUSTOM, anim, true)
		ply.DrcLastWeaponSwitch = CurTime() + dur
		
		if SERVER then
			net.Start("OtherPlayerWeaponSwitch")
			net.WriteEntity(ply)
			net.WriteString(anim)
			net.Broadcast()
		end
	end
end

hook.Add( "PlayerSwitchWeapon", "drc_weaponswitchanim", function(ply, ow, nw)
	local neww = nw:GetClass()
	
	local generic 	= ACT_DEPLOY
	local low 		= ACT_DOD_DEPLOY_MG
	local high 		= ACT_DOD_DEPLOY_TOMMY
	local rifle 	= ACT_RUN_AIM_RIFLE
	local pistol 	= ACT_RUN_AIM_PISTOL
	local melee 	= ACT_DOD_STAND_AIM_KNIFE
	local melee2 	= ACT_MP_STAND_MELEE
	local reset 	= ACT_RESET
	
	local geseq = ply:SelectWeightedSequence(generic)
	local gedur = ply:SequenceDuration(geseq)
	local loseq = ply:SelectWeightedSequence(low)
	local lodur = ply:SequenceDuration(loseq)
	local hiseq = ply:SelectWeightedSequence(high)
	local hidur = ply:SequenceDuration(hiseq)
	local riseq = ply:SelectWeightedSequence(rifle)
	local ridur = ply:SequenceDuration(riseq)
	local piseq = ply:SelectWeightedSequence(pistol)
	local pidur = ply:SequenceDuration(piseq)
	local meseq = ply:SelectWeightedSequence(melee)
	local medur = ply:SequenceDuration(meseq)
	local m2seq = ply:SelectWeightedSequence(melee2)
	local m2dur = ply:SequenceDuration(m2seq)
	
	if nw:IsScripted() then
		local newstats = weapons.GetStored(neww)
		local newht = newstats.HoldType
		
		local onehand = { "pistol", "slam", "magic" }
		local twohand = { "smg", "ar2", "shotgun", "crossbow", "duel", "camera", "revolver" }
		local lowtypes = { "physgun" }
		local hightypes = { "rpg" }
		local meleetypes = { "melee", "knife", "grenade", "slam" }
		local meleetwohand = {"melee2"}
		
		if CTFK(onehand, newht) then PlayReadyAnim(ply, pistol)
		elseif CTFK(twohand, newht) then PlayReadyAnim(ply, rifle)
		elseif CTFK(lowtypes, newht) then PlayReadyAnim(ply, low)
		elseif CTFK(hightypes, newht) then PlayReadyAnim(ply, high)
		elseif CTFK(meleetypes, newht) then PlayReadyAnim(ply, melee)
		elseif CTFK(meleetwohand, newht) then PlayReadyAnim(ply, melee2)
		end
	else
		local onehand = { "weapon_pistol", "weapon_glock_hl1", "weapon_snark", "weapon_tripmine" }
		local twohand = { "weapon_357", "weapon_crossbow", "weapon_ar2", "weapon_shotgun", "weapon_smg1", "weapon_357_hl1", "weapon_crossbow_hl1", "weapon_mp5_hl1", "weapon_shotgun_hl1", "weapon_gauss", "gmod_camera", "weapon_annabelle" }
		local lowtypes = { "weapon_physcannon", "weapon_egon", "weapon_hornetgun", "weapon_physgun" }
		local hightypes = { "weapon_rpg", "weapon_rpg_hl1", "" }
		local meleetypes = { "weapon_bugbait", "weapon_crowbar", "weapon_frag", "weapon_slam", "weapon_stunstick", "weapon_crowbar_hl1", "weapon_handgrenade", "weapon_satchel" }

		if CTFK(onehand, neww) then PlayReadyAnim(ply, pistol)
		elseif CTFK(twohand, neww) then PlayReadyAnim(ply, rifle)
		elseif CTFK(lowtypes, neww) then PlayReadyAnim(ply, low)
		elseif CTFK(hightypes, neww) then PlayReadyAnim(ply, high)
		elseif CTFK(meleetypes, neww) then PlayReadyAnim(ply, melee)
		elseif CTFK(meleetwohand, neww) then PlayReadyAnim(ply, melee2)
		end
	end
end)

net.Receive("OtherPlayerWeaponSwitch", function(len, ply)
	local ply = net.ReadEntity()
	local anim = net.ReadString()
	
	PlayReadyAnim(ply, anim)
end)

net.Receive("DRCPlayerMelee", function(len, ply)
	local ply = net.ReadEntity()
	local wpn = ply:GetActiveWeapon()
	local ht = wpn:GetHoldType()
	
	if !wpn.Draconic then return end
	if !wpn:CanGunMelee() then return end
	
	if ht == "ar2" or ht == "smg" or ht == "crossbow" or ht == "shotgun" or ht == "rpg" or ht == "melee2" or ht == "physgun" then
		ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2, true)
	elseif ht == "crowbar" or ht == "pistol" or ht == "revolver" or ht == "grenade" or ht == "slam" or ht == "normal" or ht == "fist" or ht == "knife" or ht == "passive" or ht == "duel" or ht == "magic" or ht == "camera" then
		ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE, true)
	end
end)

hook.Add("Tick", "drc_PlayerSpeak", function()
	if SERVER then return end 	
	for k,v in pairs(player.GetAll()) do
		local ply = v
		if v:GetPoseParameter("drc_speaking") == nil then return end
		local pose = ply:GetPoseParameter("drc_speaking")
		local vol = ply:VoiceVolume()
		
		if vol < 0.001 then return end
	--	print(vol)
		
		local drc_voicelerp = Lerp(vol, drc_voicelerp or vol, vol)
		local drc_lerpedspeak = Lerp(drc_voicelerp, 0, 1)
		local finallerp = Lerp(FrameTime() / 5, drc_lerpedspeak or 0, 0) * 3
		
		ply:SetPoseParameter("drc_speaking", finallerp)
	end
end)

DraconicAmmoTypes = {}

function DRCAddAmmoType(tbl)
	table.Add(DraconicAmmoTypes, tbl)
end

local batteryammo = {{
	Name = "ammo_drc_battery",
	Text = "Don't give yourself this ammo. It will only break your weapons.",
	DMG = DMG_BULLET,
	DamagePlayer = 0,
	DamageNPC = 0,
	Tracer = TRACER_LINE_AND_WHIZ,
	Force = 500,
	SplashMin = 5,
	SplashMax = 10,
	MaxCarry = 100,
}}
DRCAddAmmoType(batteryammo)

hook.Add( "Initialize", "drc_SetupAmmoTypes", function()
	for k,v in pairs(DraconicAmmoTypes) do
		if CLIENT then
			language.Add("" ..v.Name .."_ammo", v.Text)
		end

		game.AddAmmoType({
		name = v.Name,
		dmgtype = v.DMG,
		tracer = v.Tracer,
		plydmg = v.DamagePlayer,
		npcdmg = v.DamageNPC,
		force = v.Force,
		minsplash = v.SplashMin,
		maxsplash = v.SplashMax,
		maxcarry = v.MaxCarry
		})
	end
end )

local function Fuckyougmod(str)
	local prefix = "MAT_"
	local newstring = "".. prefix .."".. string.upper(str) ..""
	return newstring
end

local fuckedupmodels = {
	"models/combine_dropship.mdl"
}

hook.Add("EntityTakeDamage", "drc_materialdamagescale", function(tgt, dmg)
	if !IsValid(tgt) then return end
	local inflictor = dmg:GetInflictor()
	local attacker = dmg:GetAttacker()
	if !inflictor:IsWeapon() then return end
	local attacker = dmg:GetAttacker()
	if inflictor.Draconic == nil then return end
	if inflictor.IsMelee == true then return end
	local mat = nil
	if CTFK(fuckedupmodels, tgt:GetModel()) then
		mat = "MAT_DEFAULT"
	else
		mat = Fuckyougmod(tgt:GetBoneSurfaceProp(0))
	end

	local damagevalue = dmg:GetDamage()
	local BT = inflictor.ActiveAttachments.Ammunition.t.BulletTable
	local DT = inflictor.ActiveAttachments.Ammunition.t.BulletTable.MaterialDamageMuls
	local BaseProfile = scripted_ents.GetStored("drc_att_bprofile_generic")
	local BaseBT = BaseProfile.t.BulletTable
	local BaseDT = BaseBT.MaterialDamageMuls
	
	local scalar = 0
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
		local hl2diff = nil
		if GetConVarNumber("skill") == 1 then
			hl2diff = GetConVarNumber("sk_dmg_take_scale1")
		elseif GetConVarNumber("skill") == 2 then
			hl2diff = GetConVarNumber("sk_dmg_take_scale2")
		elseif GetConVarNumber("skill") == 3 then
			hl2diff = GetConVarNumber("sk_dmg_take_scale3")
		end
		
		damagevalue = (damagevalue * 0.3) * hl2diff
	end
	
	if inflictor:GetAttachmentValue("Ammunition", "PvEUseHL2Scale") == true && (attacker:IsPlayer() && (tgt:IsNPC() or tgt:IsNextBot())) then
		local hl2diff = nil
		if GetConVarNumber("skill") == 1 then
			hl2diff = GetConVarNumber("sk_dmg_inflict_scale1")
		elseif GetConVarNumber("skill") == 2 then
			hl2diff = GetConVarNumber("sk_dmg_inflict_scale2")
		elseif GetConVarNumber("skill") == 3 then
			hl2diff = GetConVarNumber("sk_dmg_inflict_scale3")
		end
		
		damagevalue = damagevalue * hl2diff
	end
	
	dmg:SetDamage(damagevalue)
end)

hook.Add("PlayerAmmoChanged", "drc_StopImpulse101FromBreakingBatteries", function(ply, id, old, new)
	local batteryammo = game.GetAmmoID("ammo_drc_battery")
	if id == batteryammo && new > 110 then
		if CLIENT then DRCNotify(nil, "hint", "critical", "Don't give yourself this ammo type! You'll only break your battery-based weapon!", NOTIFY_HINT, 5) end
		ply:SetAmmo(old, batteryammo)
		timer.Simple(0.2, function() ply:SetAmmo(old, batteryammo) end)
	end
end)

sound.Add( {
	name = "draconic.IronInGeneric",
	channel = CHAN_AUTO,
	volume = 0.32,
	level = 80,
	pitch = { 95, 105 },
	sound = { "weapons/bat_draw.wav",
	"player/taunt_surgeons_squeezebox_draw_clothes.wav",
	"weapons/melee_inspect_movement3.wav",
	"weapons/melee_inspect_movement4.wav",
	"weapons/movement1.wav",
	"weapons/movement2.wav",
	"weapons/movement3.wav" }
} )

sound.Add( {
	name = "draconic.IronOutGeneric",
	channel = CHAN_AUTO,
	volume = 0.32,
	level = 80,
	pitch = { 95, 105 },
	sound = { "weapons/bat_draw_swoosh1.wav",
	"weapons/melee_inspect_movement2.wav",
	"weapons/melee_inspect_movement2.wav",
	"weapons/movement1.wav",
	"weapons/movement2.wav",
	"weapons/movement3.wav" }
} )

sound.Add( {
	name = "draconic.BladeSwingSmall",
	channel = CHAN_WEAPON,
	volume = 0.96,
	level = 60,
	pitch = { 95, 105 },
	sound = { "physics/flesh/fist_swing_01.wav",
	"physics/flesh/fist_swing_02.wav",
	"physics/flesh/fist_swing_03.wav",
	"physics/flesh/fist_swing_04.wav",
	"physics/flesh/fist_swing_05.wav",
	"physics/flesh/fist_swing_06.wav" }
} )

sound.Add( {
	name = "draconic.BladeStabSmall",
	channel = CHAN_WEAPON,
	volume = 0.92,
	level = 80,
	pitch = { 95, 105 },
	sound = { "weapons/boxing_gloves_swing1.wav",
	"weapons/melee_inspect_movement2.wav",
	"weapons/movement1.wav",
	"weapons/movement2.wav",
	"weapons/movement3.wav" }
} )

sound.Add( {
	name = "draconic.BladeSmallHitWorld",
	channel = CHAN_AUTO,
	volume = 0.62,
	level = 80,
	pitch = { 95, 105 },
	sound = { "weapons/knife/knife_hitwall1.wav",
	"weapons/knife/knife_hitwall4.wav",
	"weapons/knife/knife_hit_05.wav",
	"weapons/knife/knife_hit_02.wav",
	"weapons/knife/knife_hit_01.wav",
	"weapons/knife/knife_hit_03.wav",
	"weapons/knife/knife_hitwall2.wav",
	"weapons/knife/knife_hitwall3.wav",
	"weapons/knife/knife_hit_04.wav" }
} )

sound.Add( {
	name = "draconic.BladeSmallHitFlesh",
	channel = CHAN_AUTO,
	volume = 0.62,
	level = 80,
	pitch = { 95, 105 },
	sound = { "weapons/knife/knife_hit1.wav",
	"weapons/knife/knife_hit2.wav",
	"weapons/knife/knife_hit3.wav",
	"weapons/knife/knife_hit4.wav",
	"weapons/spy_assassin_knife_impact_02.wav",
	"weapons/spy_assassin_knife_impact_01.wav" }
} )

sound.Add( {
	name = "draconic.BladeSmallStabFlesh",
	channel = CHAN_AUTO,
	volume = 0.62,
	level = 80,
	pitch = { 95, 105 },
	sound = { "weapons/knife/knife_hit1.wav",
	"weapons/knife/knife_hit2.wav",
	"weapons/knife/knife_hit3.wav",
	"weapons/knife/knife_hit4.wav",
	"weapons/axe_hit_flesh1.wav" }
} )

sound.Add( {
	name = "draconic.BatteryDepleted",
	channel = CHAN_AUTO,
	volume = 0.47,
	level = 80,
	pitch = { 95, 105 },
	sound = { "weapons/sniper_railgun_dry_fire.wav",
	"weapons/widow_maker_dry_fire.wav" }
} )

sound.Add( {
	name = "draconic.PewPew",
	channel = CHAN_WEAPON,
	volume = 0.47,
	level = 80,
	pitch = { 95, 105 },
	sound = { "weapons/capper_shoot.wav" }
} )

sound.Add( {
	name = "draconic.ExplosionSmallGeneric",
	channel = CHAN_AUTO,
	volume = 0.62,
	level = 90,
	pitch = { 95, 105 },
	sound = { "weapons/explode4.wav",
	"weapons/explode3.wav",
	"weapons/hegrenade/explode5.wav" }
} )

sound.Add( {
	name = "draconic.ExplosionDistGeneric",
	channel = CHAN_AUTO,
	volume = 0.62,
	level = 140,
	pitch = { 95, 105 },
	sound = { "ambient/explosions/exp4.wav" }
} )

sound.Add( {
	name = "draconic.VentGeneric",
	channel = CHAN_AUTO,
	volume = 0.4,
	level = 60,
	pitch = { 125, 132 },
	sound = { "ambient/gas/steam2.wav" }
} )

sound.Add( {
	name = "draconic.VentOpenGeneric",
	channel = CHAN_AUTO,
	volume = 0.4,
	level = 60,
	pitch = { 95, 105 },
	sound = { "weapons/grenade_launcher_drum_open.wav",
		"weapons/revolver_reload_cylinder_open.wav", 
		"weapons/scatter_gun_double_shells_in.wav" }
} )

sound.Add( {
	name = "draconic.VentCloseGeneric",
	channel = CHAN_AUTO,
	volume = 0.4,
	level = 60,
	pitch = { 95, 105 },
	sound = { "weapons/grenade_launcher_drum_open.wav",
		"weapons/scatter_gun_double_tube_open.wav", 
		"weapons/revolver_reload_cylinder_close.wav" }
} )

sound.Add( {
	name = "draconic.OverheatGeneric",
	channel = CHAN_AUTO,
	volume = 0.69,
	level = 90,
	pitch = { 100, 105 },
	sound = { "weapons/barret_arm_zap.wav" }
} )

sound.Add( {
	name = "draconic.EmptyGeneric",
	channel = CHAN_AUTO,
	volume = 0.69,
	level = 90,
	pitch = { 99, 102 },
	sound = { "weapons/clipempty_pistol.wav",
		"weapons/clipempty_rifle.wav" }
} )

sound.Add( {
	name = "draconic.vFireStopGeneric",
	channel = CHAN_AUTO,
	volume = 0.69,
	level = 90,
	pitch = { 90, 110 },
	sound = { "weapons/flame_thrower_bb_end.wav" }
} )

sound.Add( {
	name = "draconic.MenuPosGeneric",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 90,
	pitch = { 110, 110 },
	sound = { "ui/buttonclick.wav" }
} )

sound.Add( {
	name = "draconic.MenuNegGeneric",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 90,
	pitch = { 90, 90 },
	sound = { "buttons/button16.wav" }
} )

sound.Add( {
	name = "draconic.ChargeGeneric",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 40,
	pitch = { 100, 100 },
	sound = { "ambient/energy/force_field_loop1.wav" }
} )