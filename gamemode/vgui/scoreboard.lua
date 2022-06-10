local scframe

function GM:ScoreboardShow()
    if scframe and scframe:IsVisible() then return end
	

    local w,h = 600, 550

    if not scframe then
		scframe = vgui.Create("DFrame")
	end

    scframe:SetSize(w,h)
    scframe:Center()
    scframe:SetDraggable(false)
    scframe:ShowCloseButton(false)
	scframe:SetTitle("")
    scframe:MakePopup()
    scframe:SetVisible(true)

    function scframe:Paint(w, h)
        draw.RoundedBoxEx(32, 0, 0, w, h, Color(0, 183, 255,100), true, true, true, true)
        draw.SimpleText(GetHostName(), "Drenched36", w*(1/2), 32, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Drenched", "Drenched18", w*(1/8), h-24, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(game.GetMap(), "Drenched18", w*(7/8), h-24, Color(255,255,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        surface.SetDrawColor(Color(255,255,255))
        surface.DrawRect(w*(1/8),64,w*(3/4),2)
    end

    local scorecardpanel = vgui.Create("DScrollPanel", scframe)
    scorecardpanel:SetSize(w*(3/4),h*(3/4))
    scorecardpanel:Center()
    scorecardpanel.PlayerPanels = {}
    scorecardpanel.NextRefresh = CurTime()

    function scorecardpanel:Think()
        if (self.NextRefresh <= CurTime()) then
            self:RefreshScoreboard()
            self.NextRefresh = CurTime() + 1
        end
    end
    
    function scorecardpanel:RefreshScoreboard()
        local players = player.GetAll()
        table.sort( players, function(a, b) return a:Frags() > b:Frags() end )

        for pl, card in pairs(self.PlayerPanels) do
            self:RemoveScorecard(card)
        end

        for i, pl in ipairs(players) do
            self:CreateScorecard(pl)
        end
    end

    function scorecardpanel:RemoveScorecard(card)
        if card:IsValid() then
            self.PlayerPanels[card.Player] = nil
            card:Remove()
        end
    end

    function scorecardpanel:CreateScorecard(pl)

        local scorecard = vgui.Create("DPanel", self)
        scorecard:SetSize(self:GetWide(),40)
        scorecard:Dock(TOP)
        scorecard:SetText("")
        scorecard.Player = pl
        function scorecard:Paint(w,h)
            if pl:IsValid() then
                draw.SimpleText(pl:Name(), "Drenched36", 40, 2, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                draw.SimpleText(pl:Frags().."/"..pl:Deaths(), "Drenched36", w-40, 2, Color(255,255,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
            end
        end

        local scorecard_avatar = vgui.Create( "AvatarImage", scorecard )
        scorecard_avatar:SetSize( 32, 32 )
        scorecard_avatar:SetPos( 4, 4 )
        scorecard_avatar:SetPlayer( pl, 32 )
        
        self.PlayerPanels[pl] = scorecard
    end
end

function GM:ScoreboardHide()
	gui.EnableScreenClicker(false)
	if scframe then
		scframe:SetVisible(false)
		CloseDermaMenus()
	end
end