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
SWEP.Range = 90

SWEP.DoHurtFlash = false

SWEP.NoPressure = true

SWEP.Zoom = 1

function SWEP:PrimaryAttack()

	if not self:CanPrimaryAttack() then return end

	local owner = self:GetOwner()

	self:MeleeTrace(self.Primary.Damage)

	self:EmitSound(self.FireSound, 75, 100, 0.5)
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    self:SendWeaponAnim(ACT_VM_MISSCENTER)
end

function SWEP:MeleeTrace(damage)
	local owner = self:GetOwner()

	owner:LagCompensation( true )

    local tr = util.TraceLine({
		start = owner:EyePos(),
		endpos = owner:EyePos() + owner:EyeAngles():Forward() * self.Range,
		filter = owner
	})

	owner:LagCompensation( false )


	local ent = tr.Entity

	if ent:IsValid() then
		if SERVER then
			ent:TakeDamage(damage,owner,self)
		end
	end

	if tr.Hit and (not tr.HitSky) then
		local effectdata = EffectData()
		effectdata:SetOrigin( tr.HitPos + tr.HitNormal )
		effectdata:SetNormal( tr.HitNormal )
		effectdata:SetSurfaceProp( tr.SurfaceProps)
		effectdata:SetHitBox(tr.HitBox )
		effectdata:SetEntity(ent)
		util.Effect( "Impact", effectdata )
	end
end

function SWEP:CanPrimaryAttack()

	if self:GetNextPrimaryFire() > CurTime() then return false end

    return true
        
end