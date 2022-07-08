AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/maxofs2d/balloon_classic.mdl")
	self:PhysicsInitSphere(3)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetModelScale(0.5, 0)
	
	self:SetCustomCollisionCheck(true)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMass(1)
		phys:SetBuoyancyRatio(0.0001)
		phys:EnableMotion(true)
		if not self.Gravity then phys:EnableGravity(self.Gravity) end
		phys:EnableDrag(false)
		phys:Wake()
	end

	self:DrawShadow(false)

	self:Fire("kill", "", 30)
end

function ENT:Think()
	if self.PhysicsData then
		self:Hit(self.PhysicsData.HitPos, self.PhysicsData.HitNormal, self.PhysicsData.HitEntity, self.PhysicsData.OurOldVelocity)
	end

	local parent = self:GetParent()
	if parent:IsValid() and parent:IsPlayer() and not parent:Alive() then
		self:Remove()
	end

	if self:WaterLevel() == 3 then
		self:Explode()
		self:Remove()
	end

	self:NextThink(CurTime())
end

function ENT:Hit(vHitPos, vHitNormal, eHitEntity, vOldVelocity)

	self:Fire("kill", "", 0.1)

	local owner = self:GetOwner()
	if not owner:IsValid() then owner = self end

	vHitPos = vHitPos or self:GetPos()
	vHitNormal = (vHitNormal or Vector(0, 0, -1)) * -1

	self:SetSolid(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)

	self:SetPos(vHitPos + vHitNormal)

	self:Explode()

	self:SetAngles(vOldVelocity:Angle())
end

function ENT:Explode()
	local targetCount = 0
	for i, ent in ipairs(ents.FindInSphere(self:GetPos(),64)) do
		if ent:IsValid() and ent:IsPlayer() then
			targetCount = targetCount + 1
			if ent == self:GetOwner() then
				ent:SetVelocity(-300 * ent:GetAimVector())
			end
		end
	end
	
	util.BlastDamage(self, self:GetOwner(), self:GetPos(), 96, self.ProjDamage/math.max(targetCount*.75,1))
end

function ENT:PhysicsCollide(data, phys)
	if self.FinishedCollide then return end
	
	self.FinishedCollide = true
	phys:EnableMotion(false)
	
	self.PhysicsData = data

	self:NextThink(CurTime())
end
