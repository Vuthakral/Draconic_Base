SWEP.Base				= "draconic_gun_base"

SWEP.HoldType			= "rpg" -- https://wiki.garrysmod.com/page/Hold_Types
SWEP.CrouchHoldType		= "rpg"
SWEP.Category			= "Draconic Base Tools"
SWEP.PrintName			= "Camera (DRC)"
SWEP.InfoName			= "Camera"

SWEP.Purpose			= "''Cinematic par-excel-ahnce''"
SWEP.Instructions		= "Press R to open settings."
 
SWEP.Spawnable      = true
SWEP.AdminSpawnable = false
SWEP.NPCSpawnable 	= false
SWEP.DrawCrosshair  = false
SWEP.Slot           = 5
SWEP.SlotPos        = 0

SWEP.UseHands		= false
SWEP.DoesPassiveSprint = false
SWEP.ViewModel 		= ""
SWEP.WorldModel 	= "models/weapons/w_rocket_launcher.mdl"
SWEP.ViewModelFOV   = 54
SWEP.ShowWorldModel = false

SWEP.Primary.DefaultClip 	= 0
SWEP.Primary.Ammotype 		= nil
SWEP.Primary.Force			= 0

SWEP.Primary.Disabled	= true
SWEP.Secondary.Disabled	= true

SWEP.WElements = {
	["cam"] = { type = "Model", model = "models/dav0r/camera.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, -3, -10), angle = Angle(180, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:DoCustomPrimary()
end

function SWEP:DoCustomSecondary()
end

function SWEP:DoCustomThink()
	local ply = self:GetOwner()
	if CLIENT && !ply:Alive() then
		if IsValid(self.Menu) then self.Menu:Remove() end
	end
	if CLIENT && IsValid(self.Menu) then
		self.BollywoodSpeed = self.Menu.BollywoodSpeed:GetValue() / 100
		self.BollywoodPower = self.Menu.BollywoodSlider:GetValue() / 100
		self.CameraSmoothness = self.Menu.CameraSmoothness:GetValue()
		self.FOV = self.Menu.FOV:GetValue()
		
		if GetConVar("cl_drawownshadow"):GetFloat() == 1 then RunConsoleCommand("cl_drawownshadow", 0) end
	end
end

if !CLIENT then return end
SWEP.BollywoodSpeed = 0
SWEP.BollywoodPower = 0
SWEP.CameraSmoothness = 100
SWEP.FOV = 90
DRC.CameraOverlay = ""

function SWEP:CalcView( ply, origin, angles, fov )
	local left = ply:KeyDown(IN_MOVELEFT)
	local right = ply:KeyDown(IN_MOVERIGHT)
	local speed = ply:GetVelocity():Length()
	self.NewAng = LerpAngle(self.CameraSmoothness/1000, self.NewAng or ply:EyeAngles(), ply:EyeAngles())
	self.NewPos = LerpVector(self.CameraSmoothness/1000, self.NewPos or ply:EyePos(), ply:EyePos())
	self.NewFOV = self.FOV
	
	self.BollywoodInterp = TimedSin(0.7, -1, 1, 0) * self.BollywoodPower
	self.BollywoodAng = Angle(TimedSin(1, -.1, .1 * self.BollywoodInterp, 0), TimedSin(1, -.1 * self.BollywoodInterp, .1, 0), 0) * self.BollywoodSpeed
	
	self.NewAng = self.NewAng + self.BollywoodAng
	
--[[	if left then
		self.NewAng.Roll = Lerp(self.CameraSmoothness/10000, self.NewAng.Roll or -speed/20, -speed/20)
	elseif right then
		self.NewAng.Roll = Lerp(self.CameraSmoothness/10000, self.NewAng.Roll or speed/20, speed/20)
	end ]]
	
	return self.NewPos, self.NewAng, self.NewFOV
end


function SWEP:DoCustomReload()
	self:OpenSettings()
end

function SWEP:CloseSettings()
	if IsValid(self.Menu) then self.Menu:Remove() end
end

function SWEP:OpenSettings()
	if IsValid(self.Menu) then return end
	local ply = self:GetOwner()
	
	self.Menu = vgui.Create("DFrame")
	self.Menu:SetPos(80, ScrH() - 480)
	self.Menu:SetSize(200, 400)
	self.Menu:SetTitle("Camera Settings")
	self.Menu:MakePopup()
	self.Menu.Paint = function(self, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(25, 25, 25, 200))
	end
	
	self.Menu.BollywoodSlider = vgui.Create("DNumSlider", self.Menu)
	self.Menu.BollywoodSlider:SetPos(20, 30)
	self.Menu.BollywoodSlider:SetSize(200, 30)
	self.Menu.BollywoodSlider:SetText("Bollywood Shake")
	self.Menu.BollywoodSlider:SetMin(0)
	self.Menu.BollywoodSlider:SetMax(100)
	self.Menu.BollywoodSlider:SetValue(self.BollywoodPower * 100)
	self.Menu.BollywoodSlider:SetDecimals(0)
	
	self.Menu.BollywoodSpeed = vgui.Create("DNumSlider", self.Menu)
	self.Menu.BollywoodSpeed:SetPos(20, 60)
	self.Menu.BollywoodSpeed:SetSize(200, 30)
	self.Menu.BollywoodSpeed:SetText("Bollywood Power")
	self.Menu.BollywoodSpeed:SetMin(0)
	self.Menu.BollywoodSpeed:SetMax(100)
	self.Menu.BollywoodSpeed:SetValue(self.BollywoodSpeed * 100)
	self.Menu.BollywoodSpeed:SetDecimals(0)
	
	local div1 = vgui.Create("DPanel", self.Menu)
	div1:SetPos(10, 95)
	div1:SetSize(180, 1)
	
	self.Menu.CameraSmoothness = vgui.Create("DNumSlider", self.Menu)
	self.Menu.CameraSmoothness:SetPos(20, 100)
	self.Menu.CameraSmoothness:SetSize(200, 30)
	self.Menu.CameraSmoothness:SetText("Update Speed")
	self.Menu.CameraSmoothness:SetMin(0)
	self.Menu.CameraSmoothness:SetMax(100)
	self.Menu.CameraSmoothness:SetValue(self.CameraSmoothness)
	self.Menu.CameraSmoothness:SetDecimals(0)
	
	self.Menu.FOV = vgui.Create("DNumSlider", self.Menu)
	self.Menu.FOV:SetPos(20, 130)
	self.Menu.FOV:SetSize(200, 30)
	self.Menu.FOV:SetText("Camera FOV")
	self.Menu.FOV:SetMin(0)
	self.Menu.FOV:SetMax(100)
	self.Menu.FOV:SetValue(self.FOV)
	self.Menu.FOV:SetDecimals(3)
	
	local div2 = vgui.Create("DPanel", self.Menu)
	div2:SetPos(10, 165)
	div2:SetSize(180, 1)
	
	local overlays = {
		{"", 0},
		{"effects/combine_binocoverlay", 0},
		{"effects/tvscreen_noise002a", 0},
		{"effects/flicker_256", 0},
	}
	self.Menu.Overlay = vgui.Create("DComboBox", self.Menu)
	self.Menu.Overlay:SetPos(0, 170)
	self.Menu.Overlay:SetSize(200, 30)
	self.Menu.Overlay:SetValue("Select overlay")
	self.Menu.Overlay:AddChoice("!None")
	self.Menu.Overlay:AddChoice("Combine")
	self.Menu.Overlay:AddChoice("Distortion & Noise")
	self.Menu.Overlay:AddChoice("Old Film")
	self.Menu.Overlay.OnSelect = function(self, index, value)
		DRC.CameraOverlay = overlays[index][1]
		DRC.CameraPower = overlays[index][2]
	end
end