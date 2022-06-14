SWEP.Base = "drenched_wp_basemelee"

SWEP.PrintName = "Bottle Pickup Model"		

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.HoldType = "pistol"

SWEP.Slot = 0
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.ViewModelFOV = 60
	SWEP.ViewModelFlip = false

	SWEP.WElements = {
		["bottle"] = { type = "Model", model = "models/props/cs_office/water_bottle.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, -70), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}	
		
end

