SWEP.Base = "drenched_wp_base"

SWEP.PrintName = "Base Melee"		

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.HoldType = "melee2"

SWEP.Slot = 0
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ShowViewModel = true
	SWEP.ShowWorldModel = true
	SWEP.ViewModelFOV = 60
	SWEP.ViewModelFlip = false
end

SWEP.Primary.Delay = 0.15
SWEP.Primary.Damage = 10
SWEP.Primary.Ammo = "none"
SWEP.Cone = 0.5 // in degrees of deviation
SWEP.AmmoUsage = 5
SWEP.FireSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.Range = 75

SWEP.NoPressure = true

SWEP.Zoom = 1

function SWEP:PrimaryAttack()

	if not self:CanPrimaryAttack() then return end

	local owner = self:GetOwner()

	self:FireBullets({
		Num = 1,
		Src = owner:GetShootPos(),
		Dir = owner:GetAimVector(),
		Spread = Vector(0, 0, 0),
		Tracer = 0,
		TracerName = nil,
		AmmoType = self.Primary.Ammo,
		Force = self.Primary.Damage * 0.1,
		Damage = self.Primary.Damage,
		Distance = self.Range, 
		Callback = self.HitCallback
	})

	self:EmitSound(self.FireSound, 75, 100, 0.5)
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    self:SendWeaponAnim(ACT_VM_MISSCENTER)
end


function SWEP:CanPrimaryAttack()

	if self:GetNextPrimaryFire() > CurTime() then return false end

    return true
        
end