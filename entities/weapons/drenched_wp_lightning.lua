SWEP.Base = "drenched_wp_base"

SWEP.PrintName = "Lightning SR-80"		

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"
SWEP.HoldType = "pistol"

SWEP.Slot = 3
SWEP.SlotPos = 1

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

SWEP.Primary.Delay = 0.75
SWEP.Primary.Damage = 60
SWEP.Cone = 0.5 // in degrees of deviation
SWEP.AmmoUsage = 5
SWEP.FireSound = "weapons/ar2/fire1.wav"

SWEP.PressureEffectsDamage = true
SWEP.PressureDamageTaper = 0.75
SWEP.Velocity = 3500
SWEP.PumpAmount = 0.035
SWEP.PressureDrain = 0.85
SWEP.MinimumPressure = 0.15
SWEP.AmmoUsage = 40

SWEP.Zoom = 2