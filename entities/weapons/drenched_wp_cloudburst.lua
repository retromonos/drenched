SWEP.Base = "drenched_wp_base"

SWEP.PrintName = "Cloudburst ST-120"		

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Slot = 1
SWEP.SlotPos = 0

SWEP.HoldType = "revolver"
SWEP.ViewModelFOV = 50
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/c_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"

if CLIENT then

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

	SWEP.VElements = {
		["barrel"] = { type = "Model", model = "models/props_junk/PopCan01a.mdl", bone = "Python", rel = "", pos = Vector(0.086, -0.575, 2.868), angle = Angle(0, 0, 0), size = Vector(0.316, 0.316, 1.017), color = Color(182, 182, 182, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["grip"] = { type = "Model", model = "models/weapons/w_pist_elite_single.mdl", bone = "Python", rel = "", pos = Vector(0.076, 4.269, -0.578), angle = Angle(90, 0, -90), size = Vector(0.73, 0.73, 0.73), color = Color(182, 182, 182, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["mag"] = { type = "Model", model = "models/props_junk/PropaneCanister001a.mdl", bone = "Cylinder", rel = "", pos = Vector(0.99, 0.714, -0.317), angle = Angle(0, 0, 0), size = Vector(0.143, 0.143, 0.143), color = Color(0, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["muzzle"] = { type = "Model", model = "models/props_c17/lampShade001a.mdl", bone = "Python", rel = "", pos = Vector(0.166, -0.65, 6.897), angle = Angle(180, 0, 0), size = Vector(0.063, 0.063, 0.063), color = Color(127, 255, 0, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["valve"] = { type = "Model", model = "models/props_pipes/valvewheel001.mdl", bone = "Python", rel = "", pos = Vector(0.197, 0.114, -2.769), angle = Angle(-180, 0, -30), size = Vector(0.038, 0.038, 0.038), color = Color(155, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["barrel"] = { type = "Model", model = "models/props_junk/PopCan01a.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-1.417, -2.116, 4.245), angle = Angle(0, 0, 0), size = Vector(0.316, 0.316, 1.017), color = Color(182, 182, 182, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["grip"] = { type = "Model", model = "models/weapons/w_pist_elite_single.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-1.375, 2.409, -0.334), angle = Angle(90, 0, -90), size = Vector(0.73, 0.73, 0.73), color = Color(182, 182, 182, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["mag"] = { type = "Model", model = "models/props_junk/PropaneCanister001a.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-0.446, -0.974, 0.622), angle = Angle(0, 0, 0), size = Vector(0.143, 0.143, 0.143), color = Color(0, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["muzzle"] = { type = "Model", model = "models/props_c17/lampShade001a.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-1.394, -2.055, 8.14), angle = Angle(180, 0, 0), size = Vector(0.063, 0.063, 0.063), color = Color(127, 255, 0, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} }
	}
	
end

SWEP.Primary.Delay = 0.3
SWEP.Primary.Damage = 40
SWEP.Cone = 1 // in degrees of deviation
SWEP.AmmoUsage = 25
SWEP.FireSound = "weapons/ar2/fire1.wav"

SWEP.PressureEffectsDamage = true
SWEP.PressureDamageTaper = 0.8

SWEP.Velocity = 2700
SWEP.PressureDrain = 0.1

SWEP.Zoom = 1.5