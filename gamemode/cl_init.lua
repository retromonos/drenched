include( "shared.lua" )
include("sh_globals.lua")
include("sh_items.lua")
include("vgui/player_hud.lua")
include("vgui/help_hud.lua")
include("vgui/loadout_hud.lua")
include("vgui/scoreboard.lua")

local basefont = "Trebuchet MS"

local screenscale = Screenscale()

surface.CreateFont("Drenched18", {
    font = basefont,
	extended = false,
	size = 18*screenscale,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
})

surface.CreateFont("Drenched21", {
    font = basefont,
	extended = false,
	size = 21*screenscale,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
})

surface.CreateFont("Drenched24", {
    font = basefont,
	extended = false,
	size = 24*screenscale,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
})

surface.CreateFont("Drenched36", {
    font = basefont,
	extended = false,
	size = 36*screenscale,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
})

net.Receive("drenched_synchronizetime", function()
	local servertime = net.ReadFloat()
	local winner = net.ReadEntity()

	GAMEMODE.RoundEnd = servertime
	if winner then
		GAMEMODE.Winner = winner
	end
end)

net.Receive("drenched_synchronizepretime", function()
	local servertime = net.ReadFloat()

	GAMEMODE.PreRoundTimer = servertime
end)

--killicon.Add("proj_basewater", "killicons/proj_basewater", Color(255,255,255))
--killicon.Add("drenched_wp_noodle", "killicons/drenched_wp_noodle", Color(255,255,255))