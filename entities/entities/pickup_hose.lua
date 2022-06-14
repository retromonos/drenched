AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "pickup_base"

function ENT:Initialize()
	self.Cooldown = 15
	self.Weapon = "drenched_wp_hose"

	self:SetWeaponType(self.Weapon)

    if SERVER then
	    self:SetTrigger(true)
    end
end