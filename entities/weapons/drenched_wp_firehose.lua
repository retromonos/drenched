SWEP.Base = "drenched_wp_base"

SWEP.PrintName = "Fire Hose"		

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/c_physcannon.mdl"
SWEP.WorldModel = "models/weapons/w_physics.mdl"

SWEP.ProjectileOffset = Vector(16,-14,-12)

if CLIENT then

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.ViewModelBoneMods = {
		["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(0.999, 0.999, 0.999), pos = Vector(-12.911, 5.692, 8.851), angle = Angle(0, 0, 0) }
	}

	SWEP.VElements = {
		["end"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "Base", rel = "", pos = Vector(2.44, 0.29, -14.44), angle = Angle(0, 0, 0), size = Vector(0.046, 0.046, 2.121), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["end+"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "Base", rel = "", pos = Vector(2.49, 0.27, -17.16), angle = Angle(0, 0, 0), size = Vector(0.052, 0.052, 0.557), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["end++"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "Base", rel = "", pos = Vector(2.48, 0.22, -10.52), angle = Angle(0, 0, 0), size = Vector(0.052, 0.052, 0.557), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["end+++"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "Base", rel = "", pos = Vector(2.882, 1.74, -25.99), angle = Angle(0, 17.918, -9.496), size = Vector(0.028, 0.028, 7.05), color = Color(255, 75, 75, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["lever"] = { type = "Model", model = "models/props_wasteland/panel_leverhandle001a.mdl", bone = "Base", rel = "", pos = Vector(2.36, -0.12, -13.84), angle = Angle(-120, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["end"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-1.25282, -3.83106, 11.12456), angle = Angle(0, 0, 0), size = Vector(0.046, 0.046, 2.121), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["end+"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-1.28054, -3.86805, 7.22938), angle = Angle(0, 0, 0), size = Vector(0.052, 0.052, 0.557), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["end++"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-1.324, -3.81, 14.886), angle = Angle(0, 0, 0), size = Vector(0.052, 0.052, 0.557), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["end+++"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-0.61294, -1.99444, -2.36432), angle = Angle(0, 17.918, -9.496), size = Vector(0.028, 0.028, 7.05), color = Color(255, 75, 75, 255), surpresslightning = false, material = "phoenix_storms/grey_steel", skin = 0, bodygroup = {} },
		["lever"] = { type = "Model", model = "models/props_wasteland/panel_leverhandle001a.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(-1.96211, -4.25203, 12.05253), angle = Angle(-120, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}	
end

function SWEP:PrimaryAttack()

	if not self:CanPrimaryAttack() then return end

	self:EmitSound(self.FireSound, 75, 60, 0.5)
	self:ShootBullets(self.Primary.Ammo, self.Primary.NumShots, self:GetConeDeg())
	self:GetOwner():RemoveAmmo(self.AmmoUsage, self.Primary.Ammo)

    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    self:SetRefillStart(CurTime() + GAMEMODE.WaterRefillDelay)
    
    self:SetPressure(math.max(self:GetPressure() - self.PressureDrain,self.MinimumPressure))

    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
end


SWEP.Primary.Delay = 0.035
SWEP.Primary.Damage = 4
SWEP.Primary.NumShots = 1
SWEP.Cone = 1 // in degrees of deviation
SWEP.AmmoUsage = 3

SWEP.Velocity = 5500
SWEP.PumpAmount = 0.04
SWEP.PressureDrain = 0
SWEP.MinimumPressure = 0.15
SWEP.AmmoUsage = 3

SWEP.Zoom = 1.1