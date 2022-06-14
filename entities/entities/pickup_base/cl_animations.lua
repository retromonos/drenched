function ENT:RenderModels(ble, cmod)
	if not self.WElements then return end

	if not self.wRenderOrder then
		self.wRenderOrder = {}
		for k, v in pairs( self.WElements ) do
			if (v.type == "Model") then
				table.insert(self.wRenderOrder, 1, k)
			elseif (v.type == "Sprite" or v.type == "Quad") then
				table.insert(self.wRenderOrder, k)
			end
		end
	end

	for k, name in pairs( self.wRenderOrder ) do
		local v = self.WElements[name]
		if (!v) then self.wRenderOrder = nil break end
		if (v.hide) then continue end


		local pos, ang

		if (v.bone) then
			pos, ang = self:GetBoneOrientation( self.WElements, v )
		else
			pos, ang = self:GetBoneOrientation( self.WElements, v, "ValveBiped.Bip01_R_Hand" )
		end

		pos, ang = self:GetPos(), Angle(self:GetAngles().x,self:GetAngles().y,90)

		local model = v.modelEnt
		local sprite = v.spriteMaterial
		
		if (v.type == "Model") then
			
			local bool = self:GetCooldown() <= CurTime()

			model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)

			model:SetAngles(ang)
			--model:SetModelScale(v.size)
			local matrix = Matrix()
			local multi = cmod and 1.02 or self.SCKModelScale
			if (!bool) then multi = 0 end
			matrix:Scale(v.size * multi)
			model:EnableMatrix( "RenderMultiply", matrix )

			if (v.material == "") then
				model:SetMaterial("")
			elseif (model:GetMaterial() != v.material) then
				model:SetMaterial( v.material )
			end

			if (v.skin and v.skin != model:GetSkin()) then
				model:SetSkin(v.skin)
			end

			if (v.bodygroup) then
				for k, v in ipairs( v.bodygroup ) do
					if (model:GetBodygroup(k) != v) then
						model:SetBodygroup(k, v)
					end
				end
			end

			if (v.surpresslightning) then
				render.SuppressEngineLighting(true)
			end

			if not cmod then
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
			else
				render.SetColorModulation(unpack(cmod))
			end
			if not ble then
				render.SetBlend(v.color.a/255)
			else
				render.SetBlend(ble)
			end
			model:DrawModel()
			render.SetBlend(1)
			render.SetColorModulation(1, 1, 1)

			if (v.surpresslightning) then
				render.SuppressEngineLighting(false)
			end
		elseif (v.type == "Sprite" and sprite) then
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			render.SetMaterial(sprite)
			render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
		elseif (v.type == "Quad" and v.draw_func) then
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)

			cam.Start3D2D(drawpos, ang, v.size)
				v.draw_func( self )
			cam.End3D2D()
		end
	end
end

function ENT:GetBoneOrientation( basetab, tab, bone_override )
	local bone, pos, ang
	bone = self:LookupBone(bone_override or tab.bone)

	if (!bone) then return end

	pos, ang = Vector(0,0,0), Angle(0,0,0)
	local m = self:GetBoneMatrix(bone)
	if (m) then
		pos, ang = m:GetTranslation(), m:GetAngles()
	end

	return pos, ang
end

function ENT:CreateModels( tab )
	if (!tab) then return end

	for k, v in pairs( tab ) do
		if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and
				string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then

			v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
			if (IsValid(v.modelEnt)) then
				v.modelEnt:SetPos(self:GetPos())
				v.modelEnt:SetAngles(self:GetAngles())
				v.modelEnt:SetParent(self)
				v.modelEnt:SetNoDraw(false)
				v.createdModel = v.model
			else
				v.modelEnt = nil
			end
		elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite)
			and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then

			local name = v.sprite.."-"
			local params = { ["$basetexture"] = v.sprite }
			-- make sure we create a unique name based on the selected options
			local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
			for i, j in pairs( tocheck ) do
				if (v[j]) then
					params["$"..j] = 1
					name = name.."1"
				else
					name = name.."0"
				end
			end

			v.createdSprite = v.sprite
			v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
		end
	end
end

function ENT:RemoveModels()
	if (self.WElements) then
		for k, v in pairs( self.WElements ) do
			if (IsValid( v.modelEnt )) then
				v.modelEnt:Remove()
				v.modelEnt = nil
			end
		end
	end
end
