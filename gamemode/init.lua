AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

include("sh_globals.lua")
AddCSLuaFile("sh_globals.lua")

include("sh_items.lua")
AddCSLuaFile("sh_items.lua")

AddCSLuaFile("vgui/player_hud.lua")
AddCSLuaFile("vgui/loadout_hud.lua")

util.AddNetworkString("drenched_sendloadout")
util.AddNetworkString("drenched_hurtflash")
util.AddNetworkString("drenched_hitmarker")

function GM:PlayerSetHandsModel( ply, ent )

	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end

function GM:ShowTeam(pl)
	pl:SendLua("GAMEMODE:OpenLoadout()")
end