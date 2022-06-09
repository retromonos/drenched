GM.Items = {}
GM.ItemIDs = {}
GM.Loadout = {}
function GM:RegisterWeapon(name)
    local sweptab = weapons.Get(name)

    table.insert(self.Items,sweptab)
    table.insert(self.ItemIDs,name)

end

hook.Add("Initialize", "AddWeapons", function()
    GAMEMODE:RegisterWeapon("drenched_wp_soaker")
	GAMEMODE:RegisterWeapon("drenched_wp_drizzle")
	GAMEMODE:RegisterWeapon("drenched_wp_lightning")
	GAMEMODE:RegisterWeapon("drenched_wp_hose")
end)

local meta = FindMetaTable("Player")

net.Receive("drenched_sendloadout", function()
    local loadout = net.ReadTable()
    
    meta.Loadout = loadout
end)

function meta:AddLoadout(wep)
    table.insert(self.Loadout, wep)

    net.Start("drenched_sendloadout")
        net.WriteTable(self.Loadout)
    net.SendToServer()
end

function meta:GetLoadout()
    return self.Loadout
end