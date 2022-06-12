SWEP.Base = "drenched_wp_base"

SWEP.PrintName = "Soaker S-800"		

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = "models/weapons/cstrike/c_rif_galil.mdl"
SWEP.WorldModel = "models/weapons/w_rif_galil.mdl"


SWEP.Slot = 2
SWEP.SlotPos = 0

if CLIENT then
	SWEP.HoldType = "ar2"
	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.ViewModelFOV = 50
	SWEP.ViewModelFlip = false

	SWEP.VElements = {
		["barrel"] = { type = "Model", model = "models/props_c17/lampShade001a.mdl", bone = "v_weapon.galil", rel = "", pos = Vector(0.176, -1.122, 18.569), angle = Angle(180, 0, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "v_weapon.galil", rel = "", pos = Vector(0.002, 1.616, 12.809), angle = Angle(-90, 0, -90), size = Vector(0.019, 0.019, 0.014), color = Color(109, 109, 109, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "v_weapon.galil", rel = "", pos = Vector(-0.039, 1.626, 3.481), angle = Angle(90, 0, -90), size = Vector(0.019, 0.019, 0.009), color = Color(109, 109, 109, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["grip"] = { type = "Model", model = "models/weapons/w_pist_fiveseven.mdl", bone = "v_weapon.galil", rel = "", pos = Vector(-0.055, 5.753, -0.763), angle = Angle(90, -90, 0), size = Vector(0.882, 0.882, 0.882), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["idk"] = { type = "Model", model = "models/Items/combine_rifle_ammo01.mdl", bone = "v_weapon.bolt", rel = "", pos = Vector(-0.311, -0.257, -1.332), angle = Angle(0, 0, 0), size = Vector(0.17, 0.17, 0.17), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/gibs/metalgibs/metal_gibs", skin = 0, bodygroup = {} },
		["idk+"] = { type = "Model", model = "models/Items/combine_rifle_ammo01.mdl", bone = "v_weapon.bolt", rel = "", pos = Vector(-1.401, -0.217, -1.298), angle = Angle(0, 0, 0), size = Vector(0.17, 0.17, 0.17), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/gibs/metalgibs/metal_gibs", skin = 0, bodygroup = {} },
		["pipes"] = { type = "Model", model = "models/props_pipes/pipeset08d_128_001a.mdl", bone = "v_weapon.galil", rel = "", pos = Vector(0.94, 0.352, 2.358), angle = Angle(-90, -87.042, 0), size = Vector(0.078, 0.053, 0.053), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["smtn"] = { type = "Model", model = "models/Items/BoxFlares.mdl", bone = "v_weapon.galil", rel = "", pos = Vector(0.62, 1.605, 13.245), angle = Angle(-90, 90, 0), size = Vector(0.5, 0.45, 0.372), color = Color(45, 230, 243, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["tank"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360x2.mdl", bone = "v_weapon.galil", rel = "", pos = Vector(0.538, -1.851, 2.593), angle = Angle(0, 0, 0), size = Vector(0.006, 0.006, 0.073), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["tank+"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360x2.mdl", bone = "v_weapon.galil", rel = "", pos = Vector(-0.47, -1.831, 2.597), angle = Angle(0, 0, 0), size = Vector(0.006, 0.006, 0.073), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["tank++"] = { type = "Model", model = "models/props_wasteland/horizontalcoolingtank04.mdl", bone = "v_weapon.galil", rel = "", pos = Vector(0.022, -1.795, 0.596), angle = Angle(90, 0, -90), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["tank+++"] = { type = "Model", model = "models/props_wasteland/horizontalcoolingtank04.mdl", bone = "v_weapon.magazine", rel = "", pos = Vector(0.147, 0.466, -0.314), angle = Angle(90, 180, -90), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["barrel"] = { type = "Model", model = "models/props_c17/lampShade001a.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-0.794, -5.74372, 18.6135), angle = Angle(180, 0, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-0.91469, -3.09094, 12.19927), angle = Angle(-90, 0, -90), size = Vector(0.019, 0.019, 0.014), color = Color(109, 109, 109, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-0.9238, -2.57954, 3.12764), angle = Angle(90, 0, -90), size = Vector(0.019, 0.019, 0.009), color = Color(109, 109, 109, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["pipes"] = { type = "Model", model = "models/props_pipes/pipeset08d_128_001a.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(0.04504, -3.98379, 2.23705), angle = Angle(-90, -87.042, 0), size = Vector(0.078, 0.053, 0.053), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["smtn"] = { type = "Model", model = "models/Items/BoxFlares.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-0.25558, -2.4783, 13.18304), angle = Angle(-90, 90, 0), size = Vector(0.5, 0.45, 0.372), color = Color(45, 230, 243, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["tank"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360x2.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-0.16485, -5.15838, 2.38528), angle = Angle(0, 0, 0), size = Vector(0.006, 0.006, 0.073), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["tank+"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360x2.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-1.2698, -5.639, 2.53428), angle = Angle(0, 0, 0), size = Vector(0.006, 0.006, 0.073), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["tank++"] = { type = "Model", model = "models/props_wasteland/horizontalcoolingtank04.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-0.7146, -5.34484, 0.59578), angle = Angle(90, 0, -90), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["tank+++"] = { type = "Model", model = "models/props_wasteland/horizontalcoolingtank04.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-1.148, -2.314, 3.166), angle = Angle(90, 180, -90), size = Vector(0.02, 0.02, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} }
	}	
end

SWEP.Primary.Delay = 0.075
SWEP.Primary.Damage = 7
SWEP.Primary.NumShots = 2
SWEP.Cone = 3 // in degrees of deviation
SWEP.AmmoUsage = 5

SWEP.Zoom = 1.1

SWEP.PressureDrain = 0.015
SWEP.MinimumPressure = 0.35

SWEP.Velocity = 1100