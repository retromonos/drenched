ENT.Type = "anim"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.GlowColor = Color(255,100,0)
ENT.SCKModelScale = 1.5

function ENT:Initialize()
	self.Weapon = "drenched_wp_lightning"

	self:SetWeaponType(self.Weapon)
end

function ENT:SetWeaponType(wep)
    local weptab = weapons.Get(wep)

	if weptab.ModelScale then
		self:SetModelScale(weptab.ModelScale, 0)
	end

    self:SetModel(weptab.WorldModel)
    self:SetDTString(0,wep)
end

function ENT:GetWeaponType()
    return self:GetDTString(0)
end

function ENT:SetCooldown(time)
    self:SetDTInt(0,time)
end

function ENT:GetCooldown(time)
    return self:GetDTInt(0)
end

function ENT:Think()
    
	if CLIENT then
        local class = self:GetWeaponType()
		if class ~= self.LastWeaponType then
			self.LastWeaponType = class

			self:RemoveModels()

			local weptab = weapons.Get(class)
			if weptab then
				local showmdl = weptab.ShowWorldModel or not self:LookupBone("ValveBiped.Bip01_R_Hand") and not weptab.NoDroppedWorldModel
				self.ShowBaseModel = weptab.ShowWorldModel == nil and true or showmdl

				if weptab.WElements then
					self.WElements = table.FullCopy(weptab.WElements)
					self:CreateModels(self.WElements)
				end
			end
		end
	end

    if SERVER then
        local entities = ents.FindInSphere(self:GetPos(), 24)
        local pl
        for _, ent in ipairs(entities) do
            if ent:IsValid() and ent:IsPlayer() then
                pl = ent
            end
        end

        if pl and (not pl:HasWeapon(self:GetWeaponType())) and (self:GetCooldown() <= CurTime()) and (not GAMEMODE.WaitingForPlayers) and (self:CanPickup(pl)) then
            self:DoPickup(pl)
            self:SetCooldown(CurTime() + (self.Cooldown or 15))
			pl:EmitSound("ambient/energy/zap8.wav", 100, 100, 1)
        end
    end
end

function table.FullCopy( tab )

	if (!tab) then return nil end

	local res = {}
	for k, v in pairs( tab ) do
		if (type(v) == "table") then
			res[k] = table.FullCopy(v) -- recursion ho!
		elseif (type(v) == "Vector") then
			res[k] = Vector(v.x, v.y, v.z)
		elseif (type(v) == "Angle") then
			res[k] = Angle(v.p, v.y, v.r)
		else
			res[k] = v
		end
	end

	return res

end