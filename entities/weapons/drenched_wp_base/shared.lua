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

SWEP.DoHurtFlash = true
SWEP.PressureDamageTaper = 1
SWEP.PressureEffectsDamage = false

SWEP.TrailColor = Color(163,253,253,100)

SWEP.PumpAmount = 0.05
SWEP.PumpDelay = 0.15
SWEP.PressureDrain = 0.025
SWEP.MinimumPressure = 0.25

SWEP.NoPressure = false

SWEP.CSMuzzleFlashes = false

SWEP.RefillRate = 50 // ticks of refill per second

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.ProjectileOffset = Vector(10,-6,10)

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
    
    self:SetPressure(1)

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

    owner:ViewPunch(Angle(-(self.Primary.Damage*self.Primary.NumShots*self:GetPressure())/30,0,0))

    if SERVER then
        for i = 0,numshots-1 do
            local ent = ents.Create(self.Projectile)
            if ent:IsValid() then

                local shootpos = owner:GetShootPos() + (owner:GetRight()*self.ProjectileOffset.x) + (owner:GetUp()*self.ProjectileOffset.y) +  (owner:GetForward()*self.ProjectileOffset.z)

                ent:SetPos(shootpos)
                ent:SetAngles(owner:EyeAngles())
                ent:SetOwner(owner)
                if self.PressureEffectsDamage then
                    ent.ProjDamage = self.Primary.Damage * math.min(self:GetPressure() * (1/self.PressureDamageTaper),1)
                else
                    ent.ProjDamage = self.Primary.Damage
                end
                ent.ProjSource = self
                ent.Gravity = self.Gravity
                ent.Team = owner:Team()
                local trail = util.SpriteTrail(ent, 0, self.TrailColor, true, 8, 5, 1, 0, "trails/smoke.vmt")

                ent:Spawn()

                local phys = ent:GetPhysicsObject()
                if phys:IsValid() then
                    phys:Wake()

                    local angle = owner:GetAimVector():Angle()
                    angle:RotateAroundAxis(angle:Forward(), math.Rand(0, 360))
                    angle:RotateAroundAxis(angle:Up(), math.Rand(-cone, cone))

                    ent.PreVel = angle:Forward() * (self.Velocity * self:GetPressure())
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
    
    self:SetPressure(math.max(self:GetPressure() - self.PressureDrain,self.MinimumPressure))

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

    if owner:KeyDown(IN_RELOAD) and (self:GetPressure() < 1) and (self:GetNextPump() <= CurTime()) then
        self:SetPressure(math.min(self:GetPressure() + self.PumpAmount,1))
        self:EmitSound("weapons/crossbow/fire1.wav",75,50+(self:GetPressure()*30),0.8)
        self:SetNextPump(CurTime() + self.PumpDelay)
        self:SetNextPrimaryFire(CurTime()+0.5)
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
                particle:SetDieTime( 1.5 )
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

function SWEP:FireAnimationEvent( _pos, _ang, _event, _options )

	if string.find( self.ViewModel, 'models/weapons/cstrike/' ) then
		--firstperson css muzzle flashes
		if ( _event == 20 ) then return true end
		if ( _event == 5001 ) then return true end
			
			--print('Is CSS! = true')
	else
		--firstperson hl2 muzzle flashes
		if ( _event == 21 ) then return true end
		if ( _event == 6001 ) then return true end
			
			--print('Is Hl2! = true')
	end
		
	--thirdperson muzzle flashes both hl2/css
	if ( _event == 22 ) then return true end
	if ( _event == 5003 ) then return true end
    
end

function SWEP:DoRefill(owner)
    if self:GetNextRefill() <= CurTime() then
        owner:SetAmmo(math.min(owner:GetAmmoCount("water") + owner:WaterLevel() + 1, GAMEMODE.TankSize), "water")
        self:SetNextRefill(CurTime() + (1/self.RefillRate))
    end
end

function SWEP:TranslateFOV(fov)
	return self.FOVLerp * fov
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:Reload()
end

function SWEP:GetCone()
    --((self:GetZoomed() and 0.5) or 1)
    local convertedcone = self.Cone * (math.pi/180)
    return convertedcone * (1/self:GetPressure())
end

function SWEP:GetConeDeg()
    return self.Cone * (1/self:GetPressure())
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

function SWEP:SetNextPump(time)
    self:SetDTFloat(2,time)
end

function SWEP:GetNextPump()
    return self:GetDTFloat(2)
end

function SWEP:GetPressure()
    return self:GetDTFloat(3)
end

function SWEP:SetPressure(amount)
    self:SetDTFloat(3,amount)
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