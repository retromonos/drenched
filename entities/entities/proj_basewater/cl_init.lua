include("shared.lua")
local matGlow = Material("sprites/glow04_noz")
function ENT:Initialize()
end

function ENT:OnRemove()

	local pos = self:GetPos()

	local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetScale(2)
	util.Effect( "watersplash", effectdata )
	
end

function ENT:Draw()
	local pos = self:GetPos()

	render.SetMaterial(matGlow)
	render.DrawSprite(pos, 16, 16, Color(163,253,253,100))

	--self:DrawModel()
end
