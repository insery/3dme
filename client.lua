-----------
-- 3D ME --
-----------

local pedDisplaying = {}

Citizen.CreateThread(function()
	TriggerEvent('chat:addSuggestion', '/me', 'Can show personal actions, face expressions & much more.')
end)

local badword = {
    "noclip",
    "fallout",
    "menuself",
    "dopameme",
    "aimbot",
    "give specific",
    "maxout",
    "magic bullet",
    "crash player",
    "event blocker",
    "executor",
    "anticheat",
    "superjump",
    "freecam",
    "lynx",
    "reaper",
    "hydromenu",
    "lumia",
    "absolute",
    "spawn object",
    "destroyer",
    "exploit",
    "kill menu",
    "magic carpet",
    "trigger bot",
    "godmode",
    "chocohax",
    "screenshot-basic",
    "screenshotbasic",
    "brutan",
    "maestro",
    "teleport to",
    "no reload",
    "does not support",
    "displayeISelf",
    "displayTself",
    "drive to waypoint requires",
    "infinite stamina",
    "antiafk",
    "resource build",
    "weapon option",
    "semi-godmode",
    "semi",
    "no ragdoll",
    "weapon list",
    "triggerbot",
    "aim bot",
    "trigger",
    "troll option",
    "bullet option",
    "vehicle option",
    "explosive ammo",
    "cheat",
    "panic button",
    "destroy option",
    "modmenu",
    "mod menu",
    "fuck server",
    "close menu",
    "resourcelbuild",
    "resourcebuild",
    "give armor",
    "self menu",
    "clear blood"
}

local derercooldownfister = false

RegisterCommand('me', function(source, args, raw)
    local text = string.sub(raw, 4)
    if derercooldownfister == true then return end
    TriggerServerEvent('3dme:shareDisplay', text, 'me')
    derercooldownfister = true

    Citizen.Wait(5000)
    derercooldownfister = false
end)

RegisterNetEvent('3dme:triggerDisplay')
AddEventHandler('3dme:triggerDisplay', function(text, source, type)
    local player = GetPlayerFromServerId(source)

    if player ~= -1 then
        local ped = GetPlayerPed(player)
        Display(ped, text, type)
    end
end)

Display = function(ped, text, type)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local pedCoords = GetEntityCoords(ped)
    local dist = #(playerCoords - pedCoords)

    if dist <= 50.0 then
        local pedDisplaying = {}
        pedDisplaying[ped] = (pedDisplaying[ped] or 1) + 1

        local display = true

        Citizen.CreateThread(function()
            Wait(5000)
            display = false
        end)

        local offset = pedDisplaying[ped] * 0.15
        while display do
            if HasEntityClearLosToEntity(playerPed, ped, 17) then
                local x, y, z = table.unpack(GetEntityCoords(ped))
                local lol = text
                for k, v in ipairs(badword) do
                    lol = string.gsub(lol, v, "dårlig ord!")
                end

                DrawText3D(x, y, z + offset, lol, type)
            end
            Wait(0)
        end

        pedDisplaying[ped] = pedDisplaying[ped] - 1
    end
end



DrawText3D = function(x,y,z, text, type)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)

        if type == 'do' then
            SetTextColour(255, 184, 77, 255)
        else
            SetTextColour(255, 255, 255, 215)
        end

        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 90)
    end
end
