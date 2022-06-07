include("shared.lua")
local matGlow = Material("sprites/glow04_noz")
function ENT:Initialize()
	--[[
	local cmodel = ClientsideModel("models/healthvial.mdl")
	if cmodel:IsValid() then
		cmodel:SetPos(self:LocalToWorld(Vector(-4, 0, 0)))
		cmodel:SetAngles(self:LocalToWorldAngles(Angle(90, 0, 0)))
		cmodel:SetSolid(SOLID_NONE)
		cmodel:SetMoveType(MOVETYPE_NONE)
		cmodel:SetParent(self)
		cmodel:SetOwner(self)
		cmodel:SetColor(Color(alt and 50 or 255, 50, alt and 255 or 50))
		cmodel:SetModelScale(0.4, 0)
		cmodel:Spawn()

		self.CModel = cmodel
	end
	]]
end

function ENT:OnRemove()

	local pos = self:GetPos()

	local emitter = ParticleEmitter( pos )
	emitter:SetNearClip( 48, 64 )

	local particle = emitter:Add( "particle/smokesprites_0001", pos )
		particle:SetColor( 163,253,253 )
		particle:SetDieTime( 0.3 )
		particle:SetStartAlpha( 100 )
		particle:SetEndAlpha( 50 )
		particle:SetStartSize( 16 )
		particle:SetEndSize( 16 )
		particle:SetRollDelta( math.Rand( -5, 5 ) )
	emitter:Finish() emitter = nil collectgarbage("step", 64)
	
end

function ENT:Draw()
	local pos = self:GetPos()

	render.SetMaterial(matGlow)
	render.DrawSprite(pos, 16, 16, Color(163,253,253,100))

	--self:DrawModel()
end
