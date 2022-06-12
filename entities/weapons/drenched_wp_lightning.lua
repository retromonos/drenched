SWEP.Base = "drenched_wp_base"

SWEP.PrintName = "Lightning SR-80"		

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/cstrike/c_snip_g3sg1.mdl"
SWEP.WorldModel = "models/weapons/w_snip_g3sg1.mdl"

if CLIENT then

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.ViewModelBoneMods = {}

	SWEP.VElements = {
		["barrel"] = { type = "Model", model = "models/props_c17/lampShade001a.mdl", bone = "v_weapon.g3sg1_Parent", rel = "", pos = Vector(0.073, -5.189, -16.021), angle = Angle(180, 0, 0), size = Vector(0.165, 0.165, 1.889), color = Color(186, 126, 255, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["body"] = { type = "Model", model = "models/hunter/tubes/tube1x1x2.mdl", bone = "v_weapon.g3sg1_Parent", rel = "", pos = Vector(0.044, -5.214, -4.906), angle = Angle(0, 0, 0), size = Vector(0.06, 0.06, 0.079), color = Color(186, 126, 255, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["body+"] = { type = "Model", model = "models/hunter/misc/sphere1x1.mdl", bone = "v_weapon.g3sg1_Parent", rel = "", pos = Vector(0.044, -5.214, 2.75), angle = Angle(0, 0, 0), size = Vector(0.06, 0.06, 0.079), color = Color(0, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["grip"] = { type = "Model", model = "models/weapons/w_pist_elite_single.mdl", bone = "v_weapon.g3sg1_Parent", rel = "", pos = Vector(-0.132, 1.573, 0.583), angle = Angle(-90, 90, 0), size = Vector(0.936, 0.936, 0.936), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["sight"] = { type = "Model", model = "models/props_interiors/Furniture_chair01a.mdl", bone = "v_weapon.g3sg1_Parent", rel = "", pos = Vector(0, -6.886, -2.2), angle = Angle(90, -90, 0), size = Vector(0.059, 0.059, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["sight+"] = { type = "Model", model = "models/props_interiors/Furniture_chair01a.mdl", bone = "v_weapon.g3sg1_Parent", rel = "", pos = Vector(0.022, -6.314, -23.43), angle = Angle(90, -90, 0), size = Vector(0.059, 0.059, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["valve"] = { type = "Model", model = "models/props_pipes/valvewheel001.mdl", bone = "v_weapon.g3sg1_Parent", rel = "", pos = Vector(0.077, -5.324, 4.279), angle = Angle(0, 0, 0), size = Vector(0.058, 0.058, 0.058), color = Color(159, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["barrel"] = { type = "Model", model = "models/props_c17/lampShade001a.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-0.031, -4.45163, 16.02527), angle = Angle(0, 0, 0), size = Vector(0.165, 0.165, 1.889), color = Color(186, 126, 255, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["body"] = { type = "Model", model = "models/hunter/tubes/tube1x1x2.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-0.066, -4.657, 5.516), angle = Angle(180, 0, 0), size = Vector(0.06, 0.06, 0.079), color = Color(186, 126, 255, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["body+"] = { type = "Model", model = "models/hunter/misc/sphere1x1.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-0.111, -4.671, -2.383), angle = Angle(180, 0, 0), size = Vector(0.06, 0.06, 0.079), color = Color(0, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["grip"] = { type = "Model", model = "models/weapons/w_pist_elite_single.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-0.132, 1.573, 0.583), angle = Angle(90, -90, 0), size = Vector(0.936, 0.936, 0.936), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} }
	}
		
end

SWEP.Primary.Delay = 0.75
SWEP.Primary.Damage = 65
SWEP.Cone = 0.5 // in degrees of deviation
SWEP.AmmoUsage = 5
SWEP.FireSound = "weapons/ar2/fire1.wav"
SWEP.PressureEffectsDamage = true
SWEP.PressureDamageTaper = 0.75
SWEP.Velocity = 4200
SWEP.PumpAmount = 0.08
SWEP.PressureDrain = 0.85
SWEP.MinimumPressure = 0.15
SWEP.AmmoUsage = 40

SWEP.Zoom = 2