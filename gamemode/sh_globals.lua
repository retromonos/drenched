GM.WaterRefillDelay = .75
GM.TankSize = 750
GM.WinFrags = 15
GM.RoundTime = 300
GM.PreRoundTime = 5
GM.WaitTime = 30

if CLIENT then
    function Screenscale()
        return math.max(ScrH() / 1080, 0.851)
    end
end