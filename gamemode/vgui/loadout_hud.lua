function GM:OpenLoadout()
    if gui.IsGameUIVisible() then return end
	if gui.IsConsoleVisible() then return end
	if LocalPlayer():IsTyping() then return end

    if frame then return end

    local screenscale = Screenscale()

    local w,h = 600*screenscale, 600*screenscale

    local frame = vgui.Create("DFrame")
    frame:SetSize(w,h)
    frame:Center()
    frame:SetDraggable(false)
    frame:ShowCloseButton(false)
	frame:SetTitle("")
    frame:MakePopup()
    function frame:Paint(w, h)
        draw.RoundedBoxEx(32, 0, 0, w, h, Color(0, 183, 255,100), true, true, true, true)
        --draw.RoundedBoxEx(32, w*(1/8)-(16*screenscale), h*(1/8)-(16*screenscale), w*(3/4)+(32*screenscale),h*(3/4)+(32*screenscale), Color(0, 183, 255,150), true, true, true, true)
        draw.SimpleText("Loadout", "Drenched36", w*(1/2), 40*screenscale, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Select up to 2 guns", "Drenched18", w*(1/2), h-24, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    function frame:Think()
        local mx, my = gui.MousePos()
		local x, y = frame:GetPos()
        if mx < x - 64 or my < y - 64 or mx > x + frame:GetWide() + 64 or my > y + frame:GetTall() + 64 then
			frame:Remove()
		end
    end

    local itempanel = vgui.Create("DScrollPanel", frame)
    itempanel:SetSize(w*(3/4),h*(3/4))
    itempanel:Center()
    
    for i, wep in ipairs(self.Items) do
        local weppanel = vgui.Create("DPanel", itempanel)
        weppanel:SetSize(itempanel:GetWide(),100)
        weppanel:SetText("")
        weppanel:Dock(TOP)

        function weppanel:Paint(w, h)
            draw.SimpleText(wep.PrintName, "Drenched36", 0, 4, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

            surface.SetDrawColor(255,255,255)
            surface.DrawRect(0,40*screenscale,250*screenscale,2)

            local dmgappend = ""
            if wep.Primary.NumShots > 1 then
                dmgappend = " x "..wep.Primary.NumShots
            end

            if wep.NoPressure then
                draw.SimpleText(wep.Description, "Drenched24", 0, 42*screenscale, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            else
                draw.SimpleText(wep.Primary.Damage .. dmgappend .. " Damage", "Drenched24", 0, 42*screenscale, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                draw.SimpleText("-"..math.Round((1/wep.Primary.Delay)*wep.AmmoUsage,1) .. " mL/s", "Drenched24", 150*screenscale, 70*screenscale, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

                draw.SimpleText(math.Round(wep.Velocity/16,1) .. " psi", "Drenched24", 150*screenscale, 42*screenscale, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                draw.SimpleText(wep.Primary.Delay .. "s Delay", "Drenched24", 0, 70*screenscale, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            end
        end

        local wepcheck = vgui.Create("DButton", weppanel)
        wepcheck:SetPos(weppanel:GetWide()-64,10)
        wepcheck:SetText("")
        wepcheck:SetSize(24,24)
        
        function wepcheck:Paint(w,h)
            if (#LocalPlayer().Loadout < 2) or table.KeyFromValue(LocalPlayer().Loadout, GAMEMODE.ItemIDs[i]) then
                draw.RoundedBoxEx(4, 0, 0, w, h, Color(200, 200, 200), true, true, true, true)
            end
            
            if table.KeyFromValue(LocalPlayer().Loadout, GAMEMODE.ItemIDs[i]) then
                draw.RoundedBoxEx(4, w*(1/8), h*(1/8), w*(3/4), h*(3/4), Color(0, 183, 255), true, true, true, true)
            end         

        end

        function wepcheck:DoClick()

            if table.KeyFromValue(LocalPlayer().Loadout, GAMEMODE.ItemIDs[i]) then
                table.RemoveByValue(LocalPlayer().Loadout, GAMEMODE.ItemIDs[i])
                surface.PlaySound("buttons/button9.wav")
            elseif #LocalPlayer().Loadout < 2 then
                LocalPlayer():AddLoadout(GAMEMODE.ItemIDs[i])
                surface.PlaySound("buttons/button9.wav")
            else
                surface.PlaySound("buttons/button10.wav")
            end 

        end

    end

end