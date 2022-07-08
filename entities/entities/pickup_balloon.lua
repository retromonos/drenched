AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "pickup_base"

function ENT:Initialize()
	self.Weapon = "drenched_wp_balloon"

	self:SetWeaponType(self.Weapon)

    if SERVER then
	    self:SetTrigger(true)
    end
end