GM.Name = "Drenched"
GM.Author = "Liverneck"
GM.Email = "N/A"
GM.Website = "N/A"

function GM:Initialize()
	self.RoundEnd = CurTime() + self.RoundTime
end

function GM:PlayerInitialSpawn(ply)
	ply.Loadout = {
		"drenched_wp_soaker",
		"drenched_wp_drizzle"
	}

	net.Start("drenched_sendloadout")
		net.WriteTable(ply.Loadout)
	net.Send(ply)
end

function GM:PlayerSpawn( ply )
    ply:SetWalkSpeed(250)
    ply:SetRunSpeed(250)
	ply:RemoveAllAmmo()
	ply:StripWeapons()
	ply:GiveAmmo(self.TankSize, "water", true)

	self:DoLoadout(ply)

    ply:SetModel("models/player/alyx.mdl")
	ply:SetupHands() 
end

function GM:DoLoadout(ply)
	for _, wep in pairs(ply.Loadout) do
		ply:Give(wep)
	end
	
	ply:Give("drenched_wp_noodle")
end

hook.Add("EntityTakeDamage", "DamageEffects", function(ent, dmginfo)
	if ent:IsPlayer() then
		if dmginfo:GetAttacker():IsPlayer() then
			net.Start("drenched_hitmarker")
				net.WriteInt(dmginfo:GetDamage(), 9)
				net.WriteBool(dmginfo:GetDamage() >= ent:Health())
				net.WriteString(ent:Name())
			net.Send(dmginfo:GetAttacker())

			if dmginfo:GetAttacker():GetActiveWeapon().DoHurtFlash then
				net.Start("drenched_hurtflash")
				net.Send(ent)
			end
		end
	end
end)

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

		if CurTime() >= self.RoundEnd and (not self.RoundOver) then
			table.sort( allplayers, function(a, b) return a:Frags() > b:Frags() end )
			self.RoundOver = true
			self.Winner = allplayers[1]
			timer.Simple(5, function() GAMEMODE:RestartGame() end)
		end
	end

	
end

function GM:RestartGame()
	self.RoundOver = false
	self.Winner = nil
	self.RoundEnd = CurTime() + self.RoundTime

	if SERVER then
		local allplayers = player.GetAll()
		if allplayers then
			for i = 1, #allplayers do
				local pl = allplayers[i]

				pl:Spawn()
				pl:SetFrags(0)
				pl:SetDeaths(0)
			end
		end
	end
end

// Ammo Types
game.AddAmmoType({name = "water"})