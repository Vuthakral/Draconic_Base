SWEP.Base				= "draconic_gun_base"

SWEP.HoldType			= "normal"
SWEP.CrouchHoldType		= "normal"
SWEP.Category			= "Draconic Base Tools"
SWEP.PrintName			= "Cubemap Tester w/ Material Proxies"
SWEP.InfoName			= "Cubemap"

SWEP.Purpose			= "Checking cubemaps with Draconic material proxies."
SWEP.Instructions		= "Cry when you realize how many people don't know how to set up envmaps."
 
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
SWEP.ViewModel 		= "models/shadertest/envballs.mdl"
SWEP.WorldModel 	= "models/shadertest/envballs.mdl"
SWEP.ViewModelFOV   = 54
SWEP.VMPos 			= Vector(0, 0, 0)
SWEP.VMAng 			= Vector(0, 0, 0)
SWEP.VMPosCrouch 	= Vector(0, 0, 0)
SWEP.VMAngCrouch 	= Vector(0, 0, 0)
SWEP.IronSightsPos 	= Vector(10, -25, -7)
SWEP.SS 			= 0
SWEP.BS 			= 0
SWEP.NearWallPower		= 0
SWEP.RollingPower		= 0
SWEP.PerspectivePower	= 0

SWEP.Primary.Disabled = true
SWEP.Secondary.Disabled = false

SWEP.Secondary.Ironsights 	= true
SWEP.Secondary.IronFOV		= 90

function SWEP:DoCustomDeploy()
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	local vm = ply:GetViewModel()
	vm:SetSubMaterial(0, "models/vuthakral/shadertest/envball_6")
	vm:SetSubMaterial(1, "models/vuthakral/shadertest/envball_5")
	vm:SetSubMaterial(2, "models/vuthakral/shadertest/envball_1")
	vm:SetSubMaterial(3, "models/vuthakral/shadertest/envball_4")
	vm:SetSubMaterial(4, "models/vuthakral/shadertest/envball_2")
	vm:SetSubMaterial(5, "models/vuthakral/shadertest/envball_3")
end

function SWEP:DoCustomHolster()
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	local vm = ply:GetViewModel()
	vm:SetSubMaterial(0, nil)
	vm:SetSubMaterial(1, nil)
	vm:SetSubMaterial(2, nil)
	vm:SetSubMaterial(3, nil)
	vm:SetSubMaterial(4, nil)
	vm:SetSubMaterial(5, nil)
end

function SWEP:DoCustomRemove()
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	local vm = ply:GetViewModel()
	vm:SetSubMaterial(0, nil)
	vm:SetSubMaterial(1, nil)
	vm:SetSubMaterial(2, nil)
	vm:SetSubMaterial(3, nil)
	vm:SetSubMaterial(4, nil)
	vm:SetSubMaterial(5, nil)
end

function SWEP:DrawCustomCrosshairElements()
	if self.SightsDown == false then
		draw.DrawText( "Standard Cubemap", "TargetID", ScrW() * 0.25, ScrH() * 0.37, color_white, TEXT_ALIGN_CENTER )
		draw.DrawText( "Basic Proxy Cubemap", "TargetID", ScrW() * 0.5, ScrH() * 0.37, color_white, TEXT_ALIGN_CENTER )
		draw.DrawText( "Proxy Cubemap w/ Animated Normal", "TargetID", ScrW() * 0.75, ScrH() * 0.37, color_white, TEXT_ALIGN_CENTER )
		
		draw.DrawText( "Basic Proxy Cubemap on Complex Model", "TargetID", ScrW() * 0.25, ScrH() * 0.6, color_white, TEXT_ALIGN_CENTER )
		draw.DrawText( "Colour-tinted Proxy Cubemap", "TargetID", ScrW() * 0.5, ScrH() * 0.6, color_white, TEXT_ALIGN_CENTER )
		draw.DrawText( "Normal mapped & Alpha Masked Proxy Cubemap", "TargetID", ScrW() * 0.75, ScrH() * 0.6, color_white, TEXT_ALIGN_CENTER )
	end
end