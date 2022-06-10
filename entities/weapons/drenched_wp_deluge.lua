SWEP.Base = "drenched_wp_base"

SWEP.PrintName = "Deluge WR-600"		

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"
SWEP.HoldType = "pistol"

SWEP.Slot = 2
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = true
	SWEP.ViewModelFOV = 60
	SWEP.ViewModelFlip = false

	SWEP.VElements = {
		["tank"] = { type = "Model", model = "models/props_wasteland/horizontalcoolingtank04.mdl", bone = "v_weapon.FIVESEVEN_PARENT", rel = "", pos = Vector(-0.233, -3.159, -1.847), angle = Angle(90, 0, -90), size = Vector(0.017, 0.017, 0.017), color = Color(0, 229, 255, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["usp"] = { type = "Model", model = "models/weapons/w_pist_usp.mdl", bone = "v_weapon.FIVESEVEN_PARENT", rel = "", pos = Vector(-0.039, 2.421, -2.04), angle = Angle(-90, 0, -90), size = Vector(0.856, 0.856, 0.856), color = Color(255, 191, 0, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} }
	}
end

SWEP.Primary.Delay = 0.1
SWEP.Primary.Damage = 15
SWEP.Cone = 1.75 // in degrees of deviation
SWEP.AmmoUsage = 12
SWEP.FireSound = "weapons/ar2/fire1.wav"

SWEP.Velocity = 2800
SWEP.PressureDrain = 0.02

SWEP.Zoom = 1.2