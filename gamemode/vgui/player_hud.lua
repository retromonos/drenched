local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
    ["CHudCrosshair"] = true,
    ["CHudAmmo"] = true
}

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

hook.Add( "HUDPaint", "PlayerHUD", function()
    local pl = LocalPlayer()
    local healthfrac = pl:Health() / pl:GetMaxHealth()

    // ***************
    // HP & WEAPON HUD
    // ***************
    local left_margin = 50
    local bottom_margin = ScrH() - 160

    local hpwide = 64
    local hptall = 128
    
    draw.RoundedBoxEx(32,left_margin, bottom_margin, hpwide+136, hptall, Color(0, 183, 255,100), false, true, false, true)
	surface.SetDrawColor(255,255,255)
	surface.DrawRect(left_margin, bottom_margin, hpwide, hptall)
    surface.SetDrawColor(150, 150, 150)
    surface.DrawRect(left_margin+4, bottom_margin+4, hpwide-8, hptall-8)
    surface.SetDrawColor(0, 183, 255)
    surface.DrawRect(left_margin+4, (bottom_margin+4)+((hptall-8)*math.abs(1-healthfrac)), hpwide-8, (hptall-8)*healthfrac)

    draw.SimpleText(pl:Health(), "Drenched36", left_margin+(hpwide/2), bottom_margin+(hptall/2), Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    local wep = pl:GetActiveWeapon()

    if wep:IsValid() and pl:Alive() then
        surface.SetDrawColor(255,255,255)
        surface.DrawRect(left_margin+hpwide, bottom_margin+(hptall/2), 128, 2)
        
        if pl:GetAmmoCount("water") < GAMEMODE.TankSize then
            draw.SimpleText(GAMEMODE.TankSize .. " mL", "Drenched18", left_margin+hpwide+4, bottom_margin+(hptall/2) - 28, Color(200,200,200), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
        end

        if wep:GetRefilling() then
            for i = 1, pl:WaterLevel() do

                local w,h = 24, 24
                local lm, bm = left_margin+hpwide+68 + ((i-1) * (w*.75)), bottom_margin+(hptall/2) - 28 
    
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

        draw.SimpleText(pl:GetAmmoCount("water") .. " mL", "Drenched24", left_margin+hpwide+4, bottom_margin+(hptall/2) - 4, ((pl:GetAmmoCount("water") >= math.min(wep.AmmoUsage,2)) and Color(255,255,255)) or Color(200,200,200), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
       
        
        
       
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

    if not GAMEMODE.RoundOver then
        draw.SimpleText(pl:Frags() .. "/" .. GAMEMODE.WinFrags .. " Kills", "Drenched36", ScrW()/2, ScrH()/8, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

end )