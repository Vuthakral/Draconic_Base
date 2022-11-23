concommand.Add("draconic_menu", function()
	DRCMenu(LocalPlayer())
end)

concommand.Add("draconic_thirdperson_toggle", function()
	DRC.CalcView.ThirdPerson.Ang = LocalPlayer():EyeAngles()
	DRC.CalcView.ThirdPerson.Ang_Stored = LocalPlayer():EyeAngles()
	DRC.CalcView.ThirdPerson.DirectionalAng = LocalPlayer():EyeAngles()
	DRC:ThirdPerson_PokeLiveAngle(LocalPlayer())
	
	if GetConVar("cl_drc_thirdperson"):GetFloat() == 0 then
		RunConsoleCommand("cl_drc_thirdperson", 1)
	else
		RunConsoleCommand("cl_drc_thirdperson", 0)
	end
end)

concommand.Add("draconic_thirdperson_swapshoulder", function()
	if GetConVar("cl_drc_thirdperson_flipside"):GetFloat() == 0 then
		RunConsoleCommand("cl_drc_thirdperson_flipside", 1)
	else
		RunConsoleCommand("cl_drc_thirdperson_flipside", 0)
	end
end)

concommand.Add("draconic_firstperson_toggle", function()
	if GetConVar("cl_drc_experimental_fp"):GetFloat() == 0 then
		RunConsoleCommand("cl_drc_experimental_fp", 1)
	else
		RunConsoleCommand("cl_drc_experimental_fp", 0)
	end
end)

concommand.Add("draconic_voicesets_menu_toggle", function()
	DRC:VoiceMenuToggle()
end)

concommand.Add("drc_refreshcsents", function()
	if IsValid(DRC.CSPlayerModel) then DRC.CSPlayerModel:Remove() end
	if IsValid(DRC.CSPlayerHandShield) then DRC.CSPlayerHandShield:Remove() end
end)