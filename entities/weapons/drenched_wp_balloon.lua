SWEP.Base = "drenched_wp_base"

SWEP.PrintName = "Water Balloon"		

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Slot = 1
SWEP.SlotPos = 0

SWEP.HoldType = "grenade"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/weapons/w_grenade.mdl"

SWEP.Projectile = "proj_balloon"
SWEP.TrailColor = Color(255,172,172,75)

SWEP.FireSound = Sound("WeaponFrag.Throw")

if CLIENT then

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

	SWEP.VElements = {
		["balloon"] = { type = "Model", model = "models/maxofs2d/balloon_classic.mdl", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(1.1, 1.132, -6.136), angle = Angle(0, 0, 0), size = Vector(0.499, 0.499, 0.499), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["balloon"] = { type = "Model", model = "models/maxofs2d/balloon_classic.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(1.225, 2.948, -2.252), angle = Angle(0, 0, -53.314), size = Vector(0.499, 0.499, 0.499), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
end

SWEP.Primary.Delay = 0.9
SWEP.Primary.Damage = 60
SWEP.Cone = 0.5 // in degrees of deviation
SWEP.AmmoUsage = 50

SWEP.Velocity = 1100
SWEP.PressureDrain = 0

SWEP.Zoom = 1.5

function SWEP:PrimaryAttack()

	if not self:CanPrimaryAttack() then return end

	self:EmitSound(self.FireSound, 100, 100, 100)
	self:ShootBullets(self.Primary.Ammo, self.Primary.NumShots, self:GetConeDeg())
	self:GetOwner():RemoveAmmo(self.AmmoUsage, self.Primary.Ammo)

    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    self:SetRefillStart(CurTime() + GAMEMODE.WaterRefillDelay)
    
    self:SetPressure(math.max(self:GetPressure() - self.PressureDrain,self.MinimumPressure))

    self:SendWeaponAnim(ACT_VM_THROW)
	timer.Simple(0.25, function()
		if self:IsValid() then
			self:SendWeaponAnim(ACT_VM_DRAW) 
		end
	end)
end