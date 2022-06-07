GM.Name = "Drenched"
GM.Author = "Liverneck"
GM.Email = "N/A"
GM.Website = "N/A"

function GM:Initialize()
	-- Do stuff
end

function GM:PlayerSpawn( ply )
    ply:SetWalkSpeed(350)
    ply:SetRunSpeed(350)
	ply:RemoveAllAmmo()
	ply:GiveAmmo(self.TankSize, "water", true)
	ply:Give("drenched_wp_soaker")
	ply:Give("drenched_wp_drizzle")

    ply:SetModel("models/player/alyx.mdl")
	ply:SetupHands() 
end

function GM:Tick()
	local allplayers = player.GetAll()
	if allplayers then
		for i, pl in ipairs(allplayers) do
		    if (pl:Frags() >= self.WinFrags) and (not self.RoundOver) then
				self.RoundOver = true
				self.Winner = pl
				timer.Simple(5, function() GAMEMODE:RestartGame() end)
			end
		end
	end
end

function GM:RestartGame()
	self.RoundOver = false
	self.Winner = nil

	if SERVER then
		local allplayers = player.GetAll()
		if allplayers then
			for i = 1, #allplayers do
				local pl = allplayers[i]

				pl:Kill()
				pl:StripWeapons()
				pl:StripAmmo()
				pl:SetFrags(0)
				pl:SetDeaths(0)
			end
		end
	end
end

// Ammo Types
game.AddAmmoType({name = "water"})