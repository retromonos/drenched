local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
    ["CHudCrosshair"] = true,
    ["CHudAmmo"] = true,
    ["CHudDamageIndicator"] = true
}

local screenscale = Screenscale()

local flashmat = Material("models/shadertest/shader3")

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then
		return false
	end
end )

local function DrawLine(x, y, rot)
    rot = 270 - rot

    draw.NoTexture()
    surface.SetDrawColor(Color(0,0,0))
    surface.DrawTexturedRectRotated(x, y, 13, 3, rot)
    surface.SetDrawColor(Color(255,255,255))
    surface.DrawTexturedRectRotated(x, y, 12, 2, rot)
    
end

net.Receive("drenched_hurtflash", function()
    surface.PlaySound("player/pl_drown"..math.random(1,3)..".wav")
end)

net.Receive("drenched_hitmarker", function()
    local dmg = net.ReadInt(9)
    local killed = net.ReadBool()
    local name = net.ReadString()

    if LocalPlayer().HitmarkTime and LocalPlayer().HitmarkTime >= CurTime() then
        dmg = LocalPlayer().HitmarkDmg + dmg
    end

    if LocalPlayer():GetActiveWeapon():IsValid() then
        LocalPlayer().HitmarkTime = CurTime() + (LocalPlayer():GetActiveWeapon().Primary.Delay*1.5) + 0.1 + (killed and 0.3 or 0)
        LocalPlayer().HitmarkDmg = dmg
        LocalPlayer().HitmarkKill = killed
    end

    if killed then
        surface.PlaySound("weapons/grenade/tick1.wav")
        LocalPlayer().KillNoticeName = name
        LocalPlayer().KillNoticeTime = CurTime() + 2
    else
        surface.PlaySound("physics/cardboard/cardboard_box_impact_bullet3.wav")
    end
end)

net.Receive("drenched_wipedeathscreen", function()

    LocalPlayer().Killer = nil
    LocalPlayer().KillerWeapon = nil

end)

net.Receive("drenched_deathscreen", function()
    local killer = net.ReadEntity()
    local wep = net.ReadString()

    LocalPlayer().Killer = killer
    LocalPlayer().KillerWeapon = wep

end)

function GM:HUDDrawTargetID()

end

hook.Add( "HUDPaint", "PlayerHUD", function()
    local pl = LocalPlayer()
    local wep = pl:GetActiveWeapon()
    local healthfrac = pl:Health() / pl:GetMaxHealth()

    // ***************
    // HP & WEAPON HUD
    // ***************
    
    local left_margin = 50*screenscale
    local bottom_margin = ScrH() - (160*screenscale)

    local hpwide = 64*screenscale
    local hptall = 128*screenscale

    draw.SimpleText("F1 = Help", "Drenched24", 8,8, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText("F2 = Loadout", "Drenched24", 8,32, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    if pl:Alive() then

        if pl.HitmarkTime and pl.HitmarkTime >= CurTime() and (wep:IsValid()) then
            local color = Color(0, 183, 255,150*((pl.HitmarkTime-CurTime())/(LocalPlayer():GetActiveWeapon().Primary.Delay*1.5)))
            if pl.HitmarkKill then
                color = Color(255, 51, 0,150*((pl.HitmarkTime-CurTime())/(LocalPlayer():GetActiveWeapon().Primary.Delay*1.5)))   
            end

            draw.RoundedBox(4,(ScrW()/2)-4,(ScrH()/2)-4,8,8,color)
            draw.SimpleText(pl.HitmarkDmg, "Drenched21", (ScrW()/2),(ScrH()/2)-16, Color(255,255,255,255*((pl.HitmarkTime-CurTime())/(LocalPlayer():GetActiveWeapon().Primary.Delay*1.5))), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        if pl.KillNoticeTime and pl.KillNoticeTime >= CurTime() then
            local killcol = Color(255,255,255,255*((pl.KillNoticeTime-CurTime())/0.75))

            draw.SimpleText("Drenched", "Drenched21", (ScrW()/2),(ScrH()/2)+128, killcol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText(pl.KillNoticeName, "Drenched36", (ScrW()/2),(ScrH()/2)+160, killcol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        
        draw.RoundedBoxEx(32,left_margin, bottom_margin, hpwide+(136*screenscale), hptall, Color(0, 183, 255,100), false, true, false, true)
        surface.SetDrawColor(255,255,255)
        surface.DrawRect(left_margin, bottom_margin, hpwide, hptall)
        surface.SetDrawColor(150, 150, 150)
        surface.DrawRect(left_margin+2, bottom_margin+2, hpwide-4, hptall-4)
        surface.SetDrawColor(0, 183, 255)
        surface.DrawRect(left_margin+2, (bottom_margin+2)+((hptall-4)*math.abs(1-healthfrac)), hpwide-4, (hptall-4)*healthfrac)

        draw.SimpleText(pl:Health(), "Drenched36", left_margin+(hpwide/2), bottom_margin+(hptall/2), Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        if wep:IsValid() then
            surface.SetDrawColor(255,255,255)
            surface.DrawRect(left_margin+hpwide, bottom_margin+(hptall/2), 128*screenscale, 2)
            
            if pl:GetAmmoCount("water") < GAMEMODE.TankSize then
                draw.SimpleText(GAMEMODE.TankSize .. " mL", "Drenched18", left_margin+hpwide+4, bottom_margin+(hptall/2) - (28*screenscale), Color(200,200,200), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
            end

            if wep:GetRefilling() then
                for i = 1, pl:WaterLevel() do

                    local w,h = 24*screenscale, 24*screenscale
                    local lm, bm = left_margin+hpwide+(68*screenscale) + ((i-1) * (w*.75)), bottom_margin+(hptall/2) - (28*screenscale) 
        
                    surface.SetDrawColor(Color(255,255,255))
                    draw.NoTexture()
                    local arrow_vert = {
                        {x = lm + (w/4), y = bm + (3*(h/4))},
                        {x = lm + (w/2), y = bm + (h/4)},
                        {x = lm + (3*(w/4)), y = bm + (3*(h/4))},
                    }
                    surface.DrawPoly(arrow_vert)
                end
            end

            draw.SimpleText(pl:GetAmmoCount("water") .. " mL", "Drenched24", left_margin+hpwide+4, bottom_margin+(hptall/2) - 4, ((pl:GetAmmoCount("water") >= wep.AmmoUsage) and Color(255,255,255)) or Color(200,200,200), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)   
            
            if not wep.NoPressure then
                draw.SimpleText(math.Round(wep:GetPressure()*(wep.Velocity/16),1) .. " psi", "Drenched24", left_margin+hpwide+4, bottom_margin+(hptall/2) + 4, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                if wep:GetPressure() <= 0.5 then
                    draw.SimpleText("RELOAD to Pump!", "Drenched18", left_margin+hpwide+4, bottom_margin+(hptall/2) + 28, Color(200,200,200,255*math.abs(math.sin(CurTime()*4))), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                end
            else
                draw.SimpleText(wep.PrintName, "Drenched24", left_margin+hpwide+4, bottom_margin+(hptall/2) + 4, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            end

            local x = ScrW() * 0.5
            local y = ScrH() * 0.5
                    
            local cone = wep:GetConeDeg()
                
            local pos = Vector(x, y)
            
            if cone > 0 then 
                cone = ScrH() * 0.0003125 * cone
                cone = cone * 90 / pl:GetFOV()
                
                local midarea = 40 * cone

                local ang = Angle(0, 0, 0)
                for i=0, 359, 360 / 4 do
                    ang.roll = i
                    local p = ang:Up() * midarea
                    DrawLine(math.Round(pos.x + p.y), math.Round(pos.y + p.z), ang.roll)
                end
            end
        end
    else
        local killer = "Unknown"
        local killwep = "Unknown"

        if pl.Killer and pl.Killer:IsValid() and pl.KillerWeapon then
            killer = pl.Killer:Name()
            killwep = pl.KillerWeapon
        end

        surface.SetDrawColor(Color(0,0,0))
        surface.DrawRect(0,0,ScrW(),ScrH()*(1/8))
        surface.DrawRect(0,ScrH()-(ScrH()*(1/8)),ScrW(),ScrH()*(1/8))

        draw.RoundedBoxEx(32,(ScrW()/2)-(150*screenscale), (ScrH()/2)-(75*screenscale), 300*screenscale, 150*screenscale, Color(0, 183, 255,100), true, true, true, true)
        draw.SimpleText("Drenched by", "Drenched24", ScrW()/2, (ScrH()/2)-32, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText(killer, "Drenched36", ScrW()/2, (ScrH()/2), Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("using "..killwep, "Drenched24", ScrW()/2, (ScrH()/2)+32, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    // *************
    // PRE-ROUND HUD
    // *************

    if GAMEMODE.PreRoundTimer and GAMEMODE.PreRoundTimer >= (CurTime()-1) then
        if GAMEMODE.PreRoundTimer >= CurTime() then
            draw.SimpleText(math.ceil(GAMEMODE.PreRoundTimer - CurTime()), "Drenched36", ScrW()/2, ScrH()/3, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else
            draw.SimpleText("Go!", "Drenched36", ScrW()/2, ScrH()/3, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end

    if GAMEMODE.WaitingForPlayers then
        draw.SimpleText("Waiting for players: "..string.ToMinutesSeconds(math.max(GAMEMODE.RoundEnd - CurTime(),0)), "Drenched36", ScrW()/2, ScrH()/3, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    // ****************
    // END OF ROUND HUD
    // ****************

    if GAMEMODE.RoundOver and GAMEMODE.Winner then
        if GAMEMODE.Winner:IsPlayer() then
            draw.SimpleText(GAMEMODE.Winner:Name() .. " has won!", "Drenched36", ScrW()/2, ScrH()/3, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end

    // **********
    // FRAG COUNT
    // **********

    
    draw.RoundedBoxEx(32,(ScrW()/2)-(300*screenscale), 0, (600*screenscale), (40*screenscale), Color(0, 183, 255,100), false, false, true, true)
    draw.RoundedBoxEx(32,(ScrW()/2)-(58*screenscale), (40*screenscale), (116*screenscale), (60*screenscale), Color(0, 183, 255,100), false, false, true, true)
    draw.SimpleText("You: "..pl:Frags(), "Drenched36", (ScrW()/2)-(284*screenscale), 20, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

    local players = player.GetAll()
    table.sort( players, function(a, b) return a:Frags() > b:Frags() end )

    local opposingplayer

    if players[1] == pl then
        opposingplayer = players[math.min(2,#players)]
    else
        opposingplayer = players[1]
    end

    draw.SimpleText(opposingplayer:Name()..": "..opposingplayer:Frags(), "Drenched36", (ScrW()/2)+(284*screenscale), 20*screenscale, Color(255,255,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    draw.SimpleText(string.ToMinutesSeconds(math.max(GAMEMODE.RoundEnd - CurTime(),0)), "Drenched36", (ScrW()/2), 60*screenscale, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.SimpleText("Playing to "..GetConVar("drenched_scorelimit"):GetInt(), "Drenched18", (ScrW()/2), 85*screenscale, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    
    surface.SetDrawColor(255,255,255)
    surface.DrawRect((ScrW()/2)-(58*screenscale), 40*screenscale, 116*screenscale, 2)

end )