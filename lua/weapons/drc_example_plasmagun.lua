SWEP.Base			= "draconic_battery_base"
SWEP.Gun			= "draconic_plasmagun_example"

SWEP.HoldType			= "ar2"
SWEP.Category			= "Draconic Examples"
SWEP.PrintName			= "Plasma Gun Example"
SWEP.InfoName			= "Plasmagun"
SWEP.Auhtor				= "Vuthakral"
SWEP.Contact			= " https://discord.gg/6Y7WXrX // Steam: Vuthakral // Disc: Vuthakral#9761 "
SWEP.Purpose			= "Example weapon for the 'battery' base of DSB"
SWEP.Instructions		= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Slot				= 2
SWEP.SlotPos			= 0

SWEP.ViewModelFOV		= 54
SWEP.ViewModelFlip		= false

SWEP.UseHands			= true
SWEP.ViewModel			= "models/weapons/cstrike/c_shot_xm1014.mdl"
SWEP.WorldModel			= "models/weapons/w_shot_xm1014.mdl"
SWEP.VMPos 				= Vector(0, 0, 0)
SWEP.VMAng 				= Vector(0, 0, 0)
SWEP.IronSightsPos = Vector(-6.861, -10.429, 2.671)
SWEP.IronSightsAng = Vector(-0.5, -0.84, 0)
SWEP.SS = 1
SWEP.BS = 1

SWEP.FireModes_CanAuto	= true
SWEP.FireModes_CanBurst = true
SWEP.FireModes_CanSemi	= true
SWEP.FireModes_BurstShots = 3
SWEP.FireModes_SwitchSound = Sound("Weapon_AR2.Empty")

SWEP.DisperseHeatPassively = true
SWEP.CanOverheat			= true
SWEP.CanVent				= true
SWEP.LowerRPMWithHeat		= true
SWEP.DoOverheatDamage		= true
SWEP.DoOverheatAnimation	= false
SWEP.DoVentingAnimation		= false
SWEP.DoOverheatSound		= true
SWEP.DoVentingSound			= true
SWEP.OverheatHoldType		= "knife"
SWEP.VentingHoldType		= "slam"
SWEP.OverheatDamagePerInt	= 1
SWEP.HPS					= 6
SWEP.HeatLossInterval		= 0.1
SWEP.HeatLossPerInterval	= 1
SWEP.OverheatStrength		= 2
SWEP.OverHeatFinishPercent	= 0.32
SWEP.VentingStrength		= 4
SWEP.HeatRPMmin				= 400
SWEP.BatteryConsumPerShot	= 0.5

SWEP.Primary.NumShots 		= 1
SWEP.Primary.Spread			= 12
SWEP.Primary.SpreadDiv		= 200
SWEP.Primary.Kick			= 0.36
SWEP.Primary.RecoilUp		= 0.3
SWEP.Primary.RecoilDown		= 0.3
SWEP.Primary.RecoilHoriz	= 25
SWEP.Primary.Force			= 0.2
SWEP.Primary.Damage			= 12
SWEP.Primary.RPM			= 700
SWEP.Primary.Automatic		= true
SWEP.Primary.Tracer			= 1 -- https://wiki.garrysmod.com/page/Enums/TRACER
SWEP.Primary.Sound = Sound("draconic.PewPew")

SWEP.Primary.Projectile		= nil
SWEP.Primary.ProjSpeed			 = 750
SWEP.Primary.ProjInheritVelocity = false

SWEP.Secondary.Ironsights	= true
SWEP.Secondary.Scoped		= false
SWEP.Secondary.SightsSuppressAnim = true
SWEP.Secondary.IronFOV		= 80

SWEP.NPCBurstShots = 8
SWEP.JackalSniper = false

SWEP.VElements = {
	["Screen_Base+"] = { type = "Model", model = "models/Items/battery.mdl", bone = "v_weapon.xm1014_Parent", rel = "Screen_Base", pos = Vector(-0.48, 0.158, 0.56), angle = Angle(90, -90, 0), size = Vector(0.128, 0.128, 0.212), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Screen_Base"] = { type = "Model", model = "models/Items/HealthKit.mdl", bone = "v_weapon.xm1014_Parent", rel = "", pos = Vector(-0.24, -4.074, -2.869), angle = Angle(0, 90, -43.188), size = Vector(0.143, 0.193, 0.143), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metal", skin = 0, bodygroup = {} },
	["HeatINdicator"] = { type = "Quad", bone = "v_weapon.xm1014_Parent", rel = "Screen_Base", pos = Vector(0.68, -0.05, 0.85), angle = Angle(0, -90, -2.343), size = 0.025, draw_func = nil},
	["HeatINdicator+"] = { type = "Quad", bone = "v_weapon.xm1014_Parent", rel = "Screen_Base", pos = Vector(0.77, -0.05, 0.84), angle = Angle(0, -90, -2.343), size = 0.015, draw_func = nil},
	["HeatINdicator++"] = { type = "Quad", bone = "v_weapon.xm1014_Parent", rel = "Screen_Base", pos = Vector(0.233, -0.99, 0.697), angle = Angle(0, -90, -2.343), size = 0.015, draw_func = nil}
}

SWEP.WElements = {
	["HeatINdicator"] = { type = "Quad", bone = "ValveBiped.Bip01_R_Hand", rel = "Screen_Base", pos = Vector(0.552, -0.077, 0.856), angle = Angle(0, -90, -2.343), size = 0.015, draw_func = nil},
	["Screen_Base"] = { type = "Model", model = "models/Items/HealthKit.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.105, 1.712, -3.651), angle = Angle(-90, -155.114, 0), size = Vector(0.143, 0.193, 0.143), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metal", skin = 0, bodygroup = {} },
	["HeatINdicator+"] = { type = "Quad", bone = "ValveBiped.Bip01_R_Hand", rel = "Screen_Base", pos = Vector(0.233, -1.499, 0.697), angle = Angle(0, -90, -2.343), size = 0.025, draw_func = nil},
	["Screen_Base+"] = { type = "Model", model = "models/Items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Screen_Base", pos = Vector(-0.48, 0.158, 0.56), angle = Angle(90, -90, 0), size = Vector(0.128, 0.128, 0.212), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:DoCustomInitialize()
local ply = self:GetOwner()
	if CLIENT then
	local ply = self:GetOwner()
		self.VElements["HeatINdicator"].draw_func = function( weapon ) 
			draw.SimpleTextOutlined(self:Clip1(), "HalfLife2", 0, 3, Color(0,200,200,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255))
		end
		self.VElements["HeatINdicator++"].draw_func = function( weapon )
			draw.SimpleText(""..(204 + (8 * ply:GetAmmoCount(self.Primary.Ammo))).." °C", "HalfLife2", 0, 3, Color(0,200,200,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
		end
		self.VElements["HeatINdicator+"].draw_func = function( weapon )
			draw.SimpleTextOutlined("▉▉▉", "DermaLarge", 0, 8, Color((1 * ply:GetAmmoCount(self.Primary.Ammo)),(100 - (1 * (ply:GetAmmoCount(self.Primary.Ammo)))),0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 4, Color((2.55 * ply:GetAmmoCount(self.Primary.Ammo)),(255 - (2.55 * (ply:GetAmmoCount(self.Primary.Ammo)))),0,255))
		end
	else end
end