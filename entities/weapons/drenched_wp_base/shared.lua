SWEP.Base = "weapon_base"
SWEP.Contact 		= ""
SWEP.Author			= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.ViewModelFOV 		= 65
SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.HoldType = "pistol"
SWEP.FOVLerp = 1
SWEP.UseHands = true
SWEP.Zoom = 1.25
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "water"
SWEP.Primary.Delay 			= 0.05
SWEP.Primary.Damage 		= 10
SWEP.Primary.NumShots = 1
SWEP.Cone = 3 // in degrees of deviation
SWEP.AmmoUsage = 2
SWEP.FireSound = "weapons/ar2/fire1.wav"

SWEP.Projectile = "proj_basewater"
SWEP.Velocity = 1000
SWEP.Gravity = true

SWEP.CSMuzzleFlashes = false

SWEP.RefillRate = 50 // ticks of refill per second

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.PrintName			= "Base Weapon"			
SWEP.Slot				= 0
SWEP.SlotPos			= 1
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)

    if CLIENT then
		self:Anim_Initialize()
	end

    self.JetpackSound = CreateSound(self, "ambient/levels/canals/dam_water_loop2.wav")
end

function SWEP:Holster()
	if CLIENT then
		self:Anim_Holster()
	end

	return true
end

function SWEP:ShootBullets(damage, numshots, cone)
	local owner = self:GetOwner()

    if SERVER then
        for i = 0,numshots-1 do
            local ent = ents.Create(self.Projectile)
            if ent:IsValid() then
                ent:SetPos(owner:GetShootPos())
                ent:SetAngles(owner:EyeAngles())
                ent:SetOwner(owner)
                ent.ProjDamage = self.Primary.Damage
                ent.ProjSource = self
                ent.Gravity = self.Gravity
                ent.Team = owner:Team()
                local trail = util.SpriteTrail(ent, 0, Color(163,253,253,100), true, 8, 5, 1, 0, "trails/smoke.vmt")

                ent:Spawn()

                local phys = ent:GetPhysicsObject()
                if phys:IsValid() then
                    phys:Wake()

                    local angle = owner:GetAimVector():Angle()
                    angle:RotateAroundAxis(angle:Forward(), math.Rand(0, 360))
                    angle:RotateAroundAxis(angle:Up(), math.Rand(-cone, cone))

                    ent.PreVel = angle:Forward() * self.Velocity
                    phys:SetVelocityInstantaneous(ent.PreVel)
                end
            end
        end
    end
end

function SWEP:PrimaryAttack()

	if not self:CanPrimaryAttack() then return end

	self:EmitSound(self.FireSound, 75, 60, 0.5)
	self:ShootBullets(self.Primary.Ammo, self.Primary.NumShots, self:GetConeDeg())
	self:GetOwner():RemoveAmmo(self.AmmoUsage, self.Primary.Ammo)

    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    self:SetRefillStart(CurTime() + GAMEMODE.WaterRefillDelay)

    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
end

function SWEP:CanPrimaryAttack()

    local owner = self:GetOwner()

	if owner:GetAmmoCount(self.Primary.Ammo) < self.AmmoUsage then

		self:EmitSound( "Weapon_Pistol.Empty" )
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		self:Reload()
		return false

    elseif self:GetNextPrimaryFire() > CurTime() then return false end

    return true
        
end

function SWEP:Think()
    local owner = self:GetOwner()

    if (owner:WaterLevel() >= 1) and (owner:GetAmmoCount("water") < GAMEMODE.TankSize) and (CurTime() >= self:GetRefillStart()) then
        self:SetRefilling(true)
    else
        self:SetRefilling(false)
    end

    if self:GetRefilling() then
        self:DoRefill(owner)
    end

    if owner:KeyDown(IN_ATTACK2) then
        self:SetZoomed(true)
    else
        self:SetZoomed(false)
    end

    if self:GetZoomed() then
        self.FOVLerp = math.Approach(self.FOVLerp, 1/self.Zoom, FrameTime()*self.Zoom^2)
    elseif self.FOVLerp ~= 1 then
        self.FOVLerp = math.Approach(self.FOVLerp, 1, FrameTime()*self.Zoom^2)
    end

    if (not owner:OnGround()) and (not (owner:WaterLevel() > 1)) and owner:KeyDown(IN_JUMP) and (owner:GetAmmoCount("water") >= 2) then
        local up = owner:GetUp()
        owner:SetVelocity(12 * Vector(math.Clamp(up.x,-0.15,0.15),math.Clamp(up.y,-0.15,0.15),math.max(up.z,0.9)))
        owner:SetAmmo(math.max(owner:GetAmmoCount("water") - 2, 0), "water")

        self.JetpackSound:PlayEx(0.6, 75)

        if CLIENT then
            local pos = Vector(owner:GetPos().x,owner:GetPos().y,owner:GetPos().z+48)

            local emitter = ParticleEmitter( pos )
            emitter:SetNearClip( 48, 64 )

            local particle = emitter:Add( "particle/smokesprites_0001", pos )
                particle:SetColor( 220,220,220 )
                particle:SetDieTime( 1 )
                particle:SetStartAlpha( 100 )
                particle:SetEndAlpha( 50 )
                particle:SetStartSize( 16 )
                particle:SetEndSize( 16 )
                particle:SetRollDelta( math.Rand( -5, 5 ) )
            emitter:Finish() emitter = nil collectgarbage("step", 64)
        end

    else
        self.JetpackSound:Stop()
    end
end

function SWEP:DoRefill(owner)
    if self:GetNextRefill() <= CurTime() then
        owner:SetAmmo(math.min(owner:GetAmmoCount("water") + owner:WaterLevel(), GAMEMODE.TankSize), "water")
        self:SetNextRefill(CurTime() + (1/self.RefillRate))
    end
end

function SWEP:TranslateFOV(fov)
	return self.FOVLerp * fov
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:GetCone()
    local convertedcone = self.Cone * (math.pi/180)
    return convertedcone * ((self:GetZoomed() and 0.5) or 1)
end

function SWEP:GetConeDeg()
    return self.Cone * ((self:GetZoomed() and 0.5) or 1)
end

function SWEP:SetRefillStart(time)
    self:SetDTFloat(0,time)
end

function SWEP:GetRefillStart()
    return self:GetDTFloat(0)
end

function SWEP:SetNextRefill(time)
    self:SetDTFloat(1,time)
end

function SWEP:GetNextRefill()
    return self:GetDTFloat(1)
end

function SWEP:SetRefilling(bool)
    self:SetDTBool(0,bool)
end

function SWEP:GetRefilling()
    return self:GetDTBool(0)
end

function SWEP:SetZoomed(bool)
    self:SetDTBool(1,bool)
end

function SWEP:GetZoomed()
    return self:GetDTBool(1)
end