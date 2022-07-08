include("shared.lua")
local matGlow = Material("sprites/glow04_noz")
function ENT:Initialize()
end

function ENT:OnRemove()

	local pos = self:GetPos()

	local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetScale(8)
	util.Effect( "watersplash", effectdata )
	
end

function ENT:Draw()
	local pos = self:GetPos()

	render.SetMaterial(matGlow)
	render.DrawSprite(pos, 16, 16, Color(253,163,163,100))

	render.SetColorModulation(1,0,0)
	self:DrawModel()
	render.SetColorModulation(1,1,1)
end
