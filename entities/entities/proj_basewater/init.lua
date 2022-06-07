AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/Items/CrossbowRounds.mdl")
	self:PhysicsInitSphere(1)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetModelScale(0.3, 0)
	
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

	if eHitEntity:IsValid() then
		eHitEntity:TakeDamage(self.ProjDamage,owner,self)
	end

	self:SetAngles(vOldVelocity:Angle())
end

function ENT:PhysicsCollide(data, phys)
	if self.FinishedCollide then return end
	
	self.FinishedCollide = true
	phys:EnableMotion(false)
	
	self.PhysicsData = data

	self:NextThink(CurTime())
end
