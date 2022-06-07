include("shared.lua")

include("animations.lua")

function SWEP:OnRemove()
	self:Anim_OnRemove()
end

function SWEP:ViewModelDrawn()
	self:Anim_ViewModelDrawn()
end

function SWEP:DrawWorldModel()
	if self.WElements ~= nil then
		self:Anim_DrawWorldModel()
	else
		self:DrawModel()
	end
end

function SWEP:PreDrawViewModel(vm)
	local owner = self:GetOwner()
	if self.ShowViewModel == false then
		render.SetBlend(0)
	end
end

function SWEP:PostDrawViewModel(vm)
	if self.ShowViewModel == false then
		render.SetBlend(1)
	end
end