SWEP.Base = "drenched_wp_base"

SWEP.PrintName = "Drizzle LW-270"		

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"
SWEP.HoldType = "pistol"

SWEP.FireSound = "ambient/water/drip2.wav"

SWEP.Slot = 1
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.ViewModelFOV = 60
	SWEP.ViewModelFlip = false

	SWEP.VElements = {
		["tank"] = { type = "Model", model = "models/props_wasteland/horizontalcoolingtank04.mdl", bone = "v_weapon.FIVESEVEN_PARENT", rel = "", pos = Vector(-0.233, -3.159, -1.847), angle = Angle(90, 0, -90), size = Vector(0.017, 0.017, 0.017), color = Color(0, 229, 255, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["usp"] = { type = "Model", model = "models/weapons/w_pist_usp.mdl", bone = "v_weapon.FIVESEVEN_PARENT", rel = "", pos = Vector(-0.039, 2.421, -2.04), angle = Angle(-90, 0, -90), size = Vector(0.856, 0.856, 0.856), color = Color(255, 191, 0, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["tank"] = { type = "Model", model = "models/props_wasteland/horizontalcoolingtank04.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-0.655, -4.301, 1.331), angle = Angle(90, 0, -90), size = Vector(0.017, 0.017, 0.017), color = Color(0, 229, 255, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["usp"] = { type = "Model", model = "models/weapons/w_pist_usp.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-0.884, 1.434, 1.122), angle = Angle(90, 0, -90), size = Vector(0.856, 0.856, 0.856), color = Color(255, 191, 0, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} }
	}
		
end

SWEP.Primary.Delay = 0.225
SWEP.Primary.Damage = 18
SWEP.Cone = 1.25 // in degrees of deviation
SWEP.AmmoUsage = 6

SWEP.Velocity = 1700
SWEP.PressureDrain = 0.07
SWEP.PumpAmount = 0.1

SWEP.Zoom = 1.3