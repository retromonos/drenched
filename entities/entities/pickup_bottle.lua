AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "pickup_base"

ENT.GlowColor = Color(0,0,0)
ENT.SCKModelScale = 4

function ENT:Initialize()
	self.Weapon = "drenched_sck_bottle"

	self:SetWeaponType(self.Weapon)

    if SERVER then
	    self:SetTrigger(true)
    end
end

function ENT:CanPickup(pl)
	return pl:GetAmmoCount("water") < GAMEMODE.TankSize
end

function ENT:DoPickup(pl)
	pl:SetAmmo(math.min(pl:GetAmmoCount("water") + 200, GAMEMODE.TankSize), "water")
end