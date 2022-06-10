function GM:OpenHelp()
    if gui.IsGameUIVisible() then return end
	if gui.IsConsoleVisible() then return end
	if LocalPlayer():IsTyping() then return end

    if frame then return end

    local screenscale = Screenscale()

    local w,h = 600*screenscale, 550*screenscale

    local frame = vgui.Create("DFrame")
    frame:SetSize(w,h)
    frame:Center()
    frame:SetDraggable(false)
    frame:ShowCloseButton(false)
	frame:SetTitle("")
    frame:MakePopup()
    function frame:Paint(w, h)
        draw.RoundedBoxEx(32, 0, 0, w, h, Color(0, 183, 255,100), true, true, true, true)
        draw.SimpleText("Drenched", "Drenched36", w*(1/2), 32*screenscale, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Created by Liverneck", "Drenched18", w*(1/2), h-(24*screenscale), Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    function frame:Think()
        local mx, my = gui.MousePos()
		local x, y = frame:GetPos()
        if mx < x - 64 or my < y - 64 or mx > x + frame:GetWide() + 64 or my > y + frame:GetTall() + 64 then
			frame:Remove()
		end
    end

    local textpanel = vgui.Create("DLabel", frame)
    textpanel:SetSize(w*(3/4),h*(3/4))
    textpanel:Center()
    textpanel:SetFont("Drenched21")
    textpanel:SetMultiline(true)
	textpanel:SetWrap(true)
    textpanel:SetTextColor(Color(255,255,255))
	textpanel:SetAutoStretchVertical(true)
    textpanel:SetText("Drenched is an arena-style gamemode in which players attempt to 'drench' other players with water guns. Whoever has reaches the score-limit first, or whoever has the highest score when the timer runs out, wins.\n\nAll weapons, as well as your jetpack, share the same tank of water, which has a capacity of "..self.TankSize.." mL. Water can be refilled by standing in bodies of water scattered across the map, filling faster the more submerged you are. All weapons also have water pressure, which determines the velocity of your shots, and drains when you fire them. You can refill your weapon's water pressure by pumping the gun using RELOAD, but you cannot fire while doing so.\n\nYou can change what weapons you spawn with by pressing F2, which opens your loadout. Here you can see all available weapons, as well as their stats, such as damage, fire-rate, pressure, and water consumption. You can only select up to 2 guns to use at once, however you always spawn with the Pool Noodle.")

end