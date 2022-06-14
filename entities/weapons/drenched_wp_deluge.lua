SWEP.Base = "drenched_wp_base"

SWEP.PrintName = "Deluge WR-600"		

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 50
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"

if CLIENT then

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.ViewModelBoneMods = {}

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/hunter/triangles/1x1x1.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.201, -5.106, -4.012), angle = Angle(0, 0, 0), size = Vector(0.025, 0.039, 0.142), color = Color(225, 255, 0, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/hunter/blocks/cube1x1x1.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.199, -6.043, -13.554), angle = Angle(0, 0, 0), size = Vector(0.025, 0.039, 0.27), color = Color(225, 255, 0, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["base++"] = { type = "Model", model = "models/hunter/blocks/cube1x1x1.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.191, -5.043, -13.556), angle = Angle(0, 0, 0), size = Vector(0.025, 0.039, 0.27), color = Color(225, 255, 0, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["bolt"] = { type = "Model", model = "models/Items/combine_rifle_ammo01.mdl", bone = "v_weapon.AK47_Bolt", rel = "", pos = Vector(-0.211, -0.346, -1.52), angle = Angle(0, 0, 0), size = Vector(0.167, 0.167, 0.167), color = Color(0, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["bolt+"] = { type = "Model", model = "models/Items/combine_rifle_ammo01.mdl", bone = "v_weapon.AK47_Bolt", rel = "", pos = Vector(-0.218, -1.378, -1.528), angle = Angle(0, 0, 0), size = Vector(0.167, 0.167, 0.167), color = Color(0, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["canister"] = { type = "Model", model = "models/props_junk/PropaneCanister001a.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.712, -4.955, 1.861), angle = Angle(180, 0, 0), size = Vector(0.092, 0.092, 0.323), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["canister+"] = { type = "Model", model = "models/props_junk/PropaneCanister001a.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.672, -5.901, 1.605), angle = Angle(180, 0, 0), size = Vector(0.092, 0.092, 0.323), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["canister++"] = { type = "Model", model = "models/props_junk/PropaneCanister001a.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.73, -3.988, 1.741), angle = Angle(180, 0, 0), size = Vector(0.092, 0.092, 0.323), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["grip"] = { type = "Model", model = "models/weapons/w_pist_p228.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.193, -0.029, -0.047), angle = Angle(-90, 90, 0), size = Vector(0.73, 0.73, 0.73), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["muzzle"] = { type = "Model", model = "models/props_c17/lampShade001a.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.16207, -6.108, -21.131), angle = Angle(0, 0, 0), size = Vector(0.103, 0.103, 0.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["muzzle+"] = { type = "Model", model = "models/props_c17/lampShade001a.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.146, -4.724, -21.129), angle = Angle(0, 0, 0), size = Vector(0.103, 0.103, 0.103), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["pipe"] = { type = "Model", model = "models/hunter/tubes/tube1x1x3.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.174, -5.472, -6.855), angle = Angle(0, 0, 0), size = Vector(0.017, 0.017, 0.042), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/gibs/metalgibs/metal_gibs", skin = 0, bodygroup = {} },
		["pipe+"] = { type = "Model", model = "models/hunter/tubes/tube1x1x3.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.092, -6.514, -7.02), angle = Angle(0, 0, 0), size = Vector(0.017, 0.017, 0.042), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/gibs/metalgibs/metal_gibs", skin = 0, bodygroup = {} },
		["pipe++"] = { type = "Model", model = "models/hunter/tubes/tube1x1x3.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.23, -4.638, -4.367), angle = Angle(0, 0, 0), size = Vector(0.017, 0.017, 0.042), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/gibs/metalgibs/metal_gibs", skin = 0, bodygroup = {} },
		["sidething"] = { type = "Model", model = "models/Items/BoxFlares.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.85, -6.812, -13.763), angle = Angle(90, 0, 90), size = Vector(0.398, 0.398, 0.398), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/hunter/triangles/1x1x1.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-1.51, -4.351, 4.433), angle = Angle(180, 0, 7.5), size = Vector(0.025, 0.039, 0.142), color = Color(225, 255, 0, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/hunter/blocks/cube1x1x1.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-1.535, -5.65, 14.087), angle = Angle(180, 0, 7.5), size = Vector(0.025, 0.039, 0.27), color = Color(225, 255, 0, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["base++"] = { type = "Model", model = "models/hunter/blocks/cube1x1x1.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-1.411, -7.014, 13.963), angle = Angle(180, 0, 7.5), size = Vector(0.025, 0.039, 0.27), color = Color(225, 255, 0, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["canister"] = { type = "Model", model = "models/props_junk/PropaneCanister001a.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-0.782, -4.362, 1.715), angle = Angle(0, 0, -7.5), size = Vector(0.092, 0.092, 0.323), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["canister+"] = { type = "Model", model = "models/props_junk/PropaneCanister001a.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-1.018, -3.468, 1.727), angle = Angle(0, 0, -7.5), size = Vector(0.092, 0.092, 0.323), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["canister++"] = { type = "Model", model = "models/props_junk/PropaneCanister001a.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-0.797, -5.513, 1.416), angle = Angle(0, 0, -7.5), size = Vector(0.092, 0.092, 0.323), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["grip"] = { type = "Model", model = "models/weapons/w_pist_p228.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-0.749, 1.723, 0.581), angle = Angle(99.228, -90, 0), size = Vector(0.73, 0.73, 0.73), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["pipe"] = { type = "Model", model = "models/hunter/tubes/tube1x1x3.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-1.30956, -6.61876, 3.35711), angle = Angle(0, 0, 0), size = Vector(0.017, 0.017, 0.042), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/gibs/metalgibs/metal_gibs", skin = 0, bodygroup = {} },
		["pipe+"] = { type = "Model", model = "models/hunter/tubes/tube1x1x3.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-1.40116, -5.83869, 3.41358), angle = Angle(0, 0, 0), size = Vector(0.017, 0.017, 0.042), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/gibs/metalgibs/metal_gibs", skin = 0, bodygroup = {} },
		["pipe++"] = { type = "Model", model = "models/hunter/tubes/tube1x1x3.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-1.43755, -4.93518, 3.91443), angle = Angle(0, 0, 0), size = Vector(0.017, 0.017, 0.042), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/gibs/metalgibs/metal_gibs", skin = 0, bodygroup = {} },
		["sidething"] = { type = "Model", model = "models/Items/BoxFlares.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-2.011, -7.888, 14.136), angle = Angle(90, 0, 90), size = Vector(0.398, 0.398, 0.398), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["sidething+"] = { type = "Model", model = "models/Items/BoxFlares.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-0.873, -7.852, 14.256), angle = Angle(90, 0, 90), size = Vector(0.398, 0.398, 0.398), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} }
	}
		
end

SWEP.Primary.Delay = 0.12
SWEP.Primary.Damage = 15
SWEP.Cone = 1.3 // in degrees of deviation
SWEP.AmmoUsage = 12

SWEP.Velocity = 2800
SWEP.PressureDrain = 0.017

SWEP.Zoom = 1.2