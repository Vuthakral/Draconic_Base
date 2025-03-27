SWEP.Base				= "draconic_gun_base"

SWEP.HoldType			= "normal"
SWEP.CrouchHoldType		= "normal"
SWEP.Category			= "Draconic Base Tools"
SWEP.PrintName			= "Shader Examples"
SWEP.InfoName			= "Source Shaders"

SWEP.Purpose			= "Example use of various shaders."
 
SWEP.Spawnable      = true
SWEP.AdminSpawnable = true
SWEP.AdminOnly		= true
SWEP.NPCSpawnable	= false
SWEP.CanStore		= false

SWEP.DrawCrosshair  = false
SWEP.Slot           = 2
SWEP.SlotPos        = 0

SWEP.UseHands		= false
SWEP.DoesPassiveSprint = false
SWEP.ViewModel 		= "models/vuthakral/drc_unarmed.mdl"
SWEP.ViewModelFOV   = 70
SWEP.VMPos 			= Vector(0, 0, -5)
SWEP.VMAng 			= Vector(0, 0, 0)
SWEP.VMPosCrouch 	= Vector(0, 0, 0)
SWEP.VMAngCrouch 	= Vector(0, 0, 0)
SWEP.IronSightsPos 	= Vector(0, -60, -20)
SWEP.SS 			= 0
SWEP.BS 			= 0
SWEP.NearWallPower		= 0
SWEP.RollingPower		= 0
SWEP.PerspectivePower	= 0

SWEP.Primary.Disabled = true
SWEP.Secondary.Disabled = false

SWEP.Secondary.Ironsights 	= true
SWEP.Secondary.IronFOV		= 90

SWEP.VElements = {
	["JellyFish1"] = { type = "Model", model = "models/maxofs2d/hover_classic.mdl", bone = "ValveBiped.Bip01_Pelvis", rel = "", pos = Vector(0, 0, 80), angle = Angle(0, 0, 90), size = Vector(1.6, 1.6, 1.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/vuthakral/shaderexamples/jellyfish", skin = 0, bodygroup = {} },
	["SolidEnergy"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "ValveBiped.Bip01_Pelvis", rel = "", pos = Vector(-42, 0, 80), angle = Angle(0, -90, 0), size = Vector(0.666, 0.666, 0.666), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/vuthakral/shaderexamples/solidenergy", skin = 0, bodygroup = {} },
	["VertexLitGeneric"] = { type = "Model", model = "models/maxofs2d/hover_classic.mdl", bone = "ValveBiped.Bip01_Pelvis", rel = "", pos = Vector(42, -40.556, 80), angle = Angle(0, 0, 90), size = Vector(1.6, 1.6, 1.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/vuthakral/shaderexamples/vertexlitgeneric", skin = 0, bodygroup = {} },
	["Modulate1"] = { type = "Model", model = "models/maxofs2d/hover_classic.mdl", bone = "ValveBiped.Bip01_Pelvis", rel = "", pos = Vector(-42, -40.556, 80), angle = Angle(0, 0, 90), size = Vector(1.6, 1.6, 1.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/vuthakral/shaderexamples/modulate", skin = 0, bodygroup = {} },
	["Modulate2"] = { type = "Model", model = "models/maxofs2d/hover_classic.mdl", bone = "ValveBiped.Bip01_Pelvis", rel = "Modulate1", pos = Vector(-20, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/vuthakral/shaderexamples/modulate_b", skin = 0, bodygroup = {} },
	["VolumeClouds"] = { type = "Model", model = "models/maxofs2d/hover_classic.mdl", bone = "ValveBiped.Bip01_Pelvis", rel = "", pos = Vector(42, 0, 80), angle = Angle(0, 0, 90), size = Vector(1.6, 1.6, 1.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/vuthakral/shaderexamples/volumeclouds", skin = 0, bodygroup = {} },
	["Refract"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "ValveBiped.Bip01_Pelvis", rel = "", pos = Vector(0, -40.556, 80), angle = Angle(0, -90, 0), size = Vector(0.666, 0.666, 0.666), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/vuthakral/shaderexamples/refract", skin = 0, bodygroup = {} }
}

function SWEP:DoCustomThink()	
	self.VElements["Modulate1"].angle = Angle(RealTime()*60, 0, 90)
end

function SWEP:DoCustomDeploy()
end

function SWEP:DoCustomHolster()
end

function SWEP:DoCustomRemove()
end

function SWEP:DrawCustomCrosshairElements()
	if self.SightsDown == false then
		draw.DrawText( "VertexLitGeneric", "TargetID", ScrW() * 0.23, ScrH() * 0.475, color_white, TEXT_ALIGN_CENTER )
		draw.DrawText( "Refract", "TargetID", ScrW() * 0.5, ScrH() * 0.475, color_white, TEXT_ALIGN_CENTER )
		draw.DrawText( "Modulate ($mod2x 1)", "TargetID", ScrW() * 0.77, ScrH() * 0.475, color_white, TEXT_ALIGN_CENTER )
		
		draw.DrawText( "VolumeClouds", "TargetID", ScrW() * 0.23, ScrH() * 0.6, color_white, TEXT_ALIGN_CENTER )
		draw.DrawText( "JellyFish\n(with drc_ReflectionTint)", "TargetID", ScrW() * 0.5, ScrH() * 0.6, color_white, TEXT_ALIGN_CENTER )
		draw.DrawText( "SolidEnergy (Portal 2)", "TargetID", ScrW() * 0.77, ScrH() * 0.6, color_white, TEXT_ALIGN_CENTER )
	end
end