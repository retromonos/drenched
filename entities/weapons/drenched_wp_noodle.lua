SWEP.Base = "drenched_wp_basemelee"

SWEP.PrintName = "Pool Noodle"		

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.HoldType = "melee2"

SWEP.Slot = 0
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.ViewModelFOV = 60
	SWEP.ViewModelFlip = false

	SWEP.VElements = {
		["tube"] = { type = "Model", model = "models/hunter/tubes/tube1x1x8.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(14.593, 0.064, -30.404), angle = Angle(5.823, 3.918, 0), size = Vector(0.084, 0.084, 0.31), color = Color(127, 0, 255, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["tube"] = { type = "Model", model = "models/hunter/tubes/tube1x1x8.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.622, 0.927, -31.27), angle = Angle(5.823, 3.918, 0), size = Vector(0.139, 0.139, 0.165), color = Color(127, 0, 255, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
	}
		
end

SWEP.Primary.Delay = 0.25
SWEP.Primary.Damage = 10

SWEP.FireSound = "weapons/iceaxe/iceaxe_swing1.wav"

