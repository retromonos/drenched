AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
AddCSLuaFile("cl_animations.lua")

function ENT:KeyValue(key, value)
	key = string.lower(key)
	if key == "respawn_time" then
		self.Cooldown = value
	end
end