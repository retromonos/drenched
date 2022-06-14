include("shared.lua")
include("cl_animations.lua")

function ENT:DrawTranslucent()

	local pos = self:GetPos()
	local eAng = self:GetAngles()

	eyepos = LocalPlayer():EyePos()
	distance = eyepos:DistToSqr(pos)

	ang = (eyepos - pos):Angle()
	ang:RotateAroundAxis(ang:Right(), 270)
	ang:RotateAroundAxis(ang:Up(), 90)

	self:SetAngles(Angle(eAng.x,CurTime()*50,eAng.z))

	if self:GetCooldown() > CurTime() then
		cam.Start3D2D(pos, ang, 0.5)
			draw.SimpleText(math.ceil(self:GetCooldown() - CurTime()), "Drenched36", 0, 0, Color(255,255,255,100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		cam.End3D2D()
	end
	
	if not self.ShowBaseModel then
		render.SetBlend(0)
	end
	self:DrawModel()
	if not self.ShowBaseModel then
		render.SetBlend(1)
	end
	if self:GetCooldown() > CurTime() then
		render.SetBlend(0)
	end
	self:RenderModels()

	local dlight = DynamicLight(self:EntIndex())
	if ( dlight ) and self:GetCooldown() <= CurTime() then
		dlight.pos = Vector(pos.x,pos.y,pos.z-16)
		dlight.r = self.GlowColor.r
		dlight.g = self.GlowColor.g
		dlight.b = self.GlowColor.b
		dlight.brightness = 4
		dlight.Decay = 2048
		dlight.Size = 128
		dlight.Style = 6				
		dlight.DieTime = CurTime() + 1
		dlight.noworld = false
		dlight.nomodel = false
	end
end

function ENT:OnRemove()
	self:RemoveModels()
end
