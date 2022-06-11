GM.Name = "Drenched"
GM.Author = "Liverneck"
GM.Email = "N/A"
GM.Website = "N/A"

function GM:Initialize()
	self.RoundEnd = CurTime() + self.WaitTime

	self.WaitingForPlayers = true
end

function GM:PlayerInitialSpawn(ply)
	ply.Loadout = {
		"drenched_wp_soaker",
		"drenched_wp_drizzle"
	}

	ply.LastDamaged = 0
	ply.NextHeal = 0

	net.Start("drenched_sendloadout")
		net.WriteTable(ply.Loadout)
	net.Send(ply)

	net.Start("drenched_synchronizetime")
		net.WriteFloat(self.RoundEnd)
	net.Send(ply)
end

function GM:PlayerSpawn( ply )
	ply:UnSpectate()
    ply:SetWalkSpeed(280)
    ply:SetRunSpeed(280)
	ply:RemoveAllAmmo()
	ply:StripWeapons()
	ply:GiveAmmo(self.TankSize, "water", true)

	self:DoLoadout(ply)

    ply:SetModel(player_manager.TranslatePlayerModel(ply:GetInfo("cl_playermodel")))
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
		net.Start("drenched_wipedeathscreen")
		net.Send(ent)

		ent.LastDamaged = CurTime()

		if dmginfo:GetAttacker():IsPlayer() then
			local killed = dmginfo:GetDamage() >= ent:Health()

			net.Start("drenched_hitmarker")
				net.WriteInt(dmginfo:GetDamage(), 9)
				net.WriteBool(killed)
				net.WriteString(ent:Name())
			net.Send(dmginfo:GetAttacker())

			if killed then
				net.Start("drenched_deathscreen")
					net.WriteEntity(dmginfo:GetAttacker())
					net.WriteString(dmginfo:GetAttacker():GetActiveWeapon().PrintName)
				net.Send(ent)
			end

			if dmginfo:GetAttacker():GetActiveWeapon().DoHurtFlash then
				net.Start("drenched_hurtflash")
				net.Send(ent)
			end
		end
	end
end)

hook.Add("PlayerDeath", "DeathScreen", function(ent, inflictor, attacker)

	net.Start("drenched_wipedeathscreen")
	net.Send(ent)

	if attacker:IsPlayer() and (attacker ~= ent) then
		ent:Spectate(OBS_MODE_FREEZECAM)
		ent:SpectateEntity(attacker)

		net.Start("drenched_deathscreen")
			net.WriteEntity(attacker)
			net.WriteString(attacker:GetActiveWeapon().PrintName)
		net.Send(ent)
	end
end)

function GM:Tick()
	local allplayers = player.GetAll()
	
	if allplayers then
		for i, pl in ipairs(allplayers) do
		    if (pl:Frags() >= GetConVar("drenched_scorelimit"):GetInt()) and (not self.RoundOver) then
				self.RoundOver = true
				self.Winner = pl
				timer.Simple(5, function() GAMEMODE:RestartGame() end)
			end

			if SERVER then
				local towel = pl:HasWeapon("drenched_wp_towel")
				local healtime = 5
				local healdelay = 0.15
				if towel then
					healtime = 3
					healdelay = 0.075
				end

				if ((pl.LastDamaged + healtime) <= CurTime()) and (pl.NextHeal <= CurTime()) then
					pl:SetHealth(math.min(pl:Health()+1,pl:GetMaxHealth()))
					pl.NextHeal = CurTime() + healdelay
				end
			end
		end

		if CurTime() >= self.RoundEnd and (not self.RoundOver) then
			if self.WaitingForPlayers then
				self:RestartGame()
				self.WaitingForPlayers = false
			else
				table.sort( allplayers, function(a, b) return a:Frags() > b:Frags() end )
				self.RoundOver = true
				self.Winner = allplayers[1]
				timer.Simple(5, function() GAMEMODE:RestartGame() end)
			end
		end

	end
	
end

function GM:RestartGame()
	self.RoundOver = false
	self.Winner = nil

	if SERVER then
		self.RoundEnd = CurTime() + GetConVar("drenched_roundtime"):GetInt() + self.PreRoundTime

		local allplayers = player.GetAll()
		if allplayers then
			for i = 1, #allplayers do
				local pl = allplayers[i]

				net.Start("drenched_synchronizetime")
					net.WriteFloat(self.RoundEnd)
					net.WriteEntity(self.Winner)
				net.Send(pl)

				pl:Spawn()
				pl:SetFrags(0)
				pl:SetDeaths(0)
			end
		end
	end

	self:PreRoundStart()
end

function GM:PreRoundStart()
	local allplayers = player.GetAll()
	
	if SERVER then

		self.PreRoundTimer = CurTime() + self.PreRoundTime
		if allplayers then

			for i, pl in ipairs(allplayers) do
				pl:Lock()
	
				net.Start("drenched_synchronizetime")
					net.WriteFloat(self.RoundEnd)
					net.WriteEntity(self.Winner)
				net.Send(pl)

				net.Start("drenched_synchronizepretime")
					net.WriteFloat(self.PreRoundTimer)
				net.Send(pl)
			end
		end
	end

	timer.Simple(self.PreRoundTime, function()
		if allplayers then
			for i, pl in ipairs(allplayers) do
				if SERVER then
					pl:UnLock()

					net.Start("drenched_synchronizetime")
						net.WriteFloat(self.RoundEnd)
						net.WriteEntity(self.Winner)
					net.Send(pl)
				end
			end
		end
	end)
end

// Ammo Types
game.AddAmmoType({name = "water"})