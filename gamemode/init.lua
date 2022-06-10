AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

include("sh_globals.lua")
AddCSLuaFile("sh_globals.lua")

include("sh_items.lua")
AddCSLuaFile("sh_items.lua")

AddCSLuaFile("vgui/player_hud.lua")
AddCSLuaFile("vgui/help_hud.lua")
AddCSLuaFile("vgui/loadout_hud.lua")
AddCSLuaFile("vgui/scoreboard.lua")

util.AddNetworkString("drenched_sendloadout")
util.AddNetworkString("drenched_hurtflash")
util.AddNetworkString("drenched_deathscreen")
util.AddNetworkString("drenched_wipedeathscreen")
util.AddNetworkString("drenched_hitmarker")
util.AddNetworkString("drenched_synchronizetime")
util.AddNetworkString("drenched_synchronizepretime")

resource.AddFile( "materials/killicons/proj_basewater.vmt" )
resource.AddFile( "materials/killicons/drenched_wp_noodle.vmt" )

function GM:PlayerSetHandsModel( ply, ent )

	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end

function GM:ShowHelp(pl)
	pl:SendLua("GAMEMODE:OpenHelp()")
end

function GM:ShowTeam(pl)
	pl:SendLua("GAMEMODE:OpenLoadout()")
end