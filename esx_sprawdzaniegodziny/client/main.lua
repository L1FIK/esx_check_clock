ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local playAnim = function(animDict, animName, duration)
    
	RequestAnimDict(animDict)
    
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
    
	TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    
	RemoveAnimDict(animDict)
end

RandomAnim = {
    "idle_b",
    "idle_a",
    "idle_d",
    "intro",
    "idle_e"
}

local RandomAnimClock = function()
    return RandomAnim[math.random(#RandomAnim)]
end

RegisterNetEvent("esx_sprawdzaniezegarka:clock")
AddEventHandler("esx_sprawdzaniezegarka:clock", function()

    local player = PlayerPedId()

    if not zegarek then
        
        exports['dopamineNotify']:Alert("Powiadomienie", "<span style='color:#c7c7c7'>Zakładasz zegarek", 5000, 'info') --{Tutaj zmień notyfikacje}
        
        playAnim("anim@random@shop_clothes@watches", RandomAnimClock(), 3100) 

        Wait (3100)
        
        ClearPedSecondaryTask(player)
        
        zegarek = true
        
        SetPedPropIndex(player, 6)
        
    elseif zegarek then
        
        zegarek = false
        
        exports['dopamineNotify']:Alert("Powiadomienie", "<span style='color:#c7c7c7'>Zdejmujesz zegarek", 5000, 'info')    --{Tutaj zmień notyfikacje}

        playAnim("anim@random@shop_clothes@watches", "idle_c", 3100) 
        
        Wait (3100)
        
        ClearPedSecondaryTask(player)

        ClearPedProp(player, 6)
    end
end)

local czas = function()

    local ped = GetPlayerPed(-1)

    if IsPedAPlayer(ped) and zegarek or IsPedInAnyVehicle(ped, false) and not IsPedOnAnyBike(ped) then
        
        local godzina, minuta, dzien = GetClockHours(), GetClockMinutes(), GetClockDayOfWeek()

        if dzien == 0 then                
            dzien = "Poniedziałek"      --{Tutaj zmień string jak chcesz}
        elseif dzien == 1 then
            dzien = "Wtorek"            --{Tutaj zmień string jak chcesz}
        elseif dzien == 2 then
            dzien = "Środa"             --{Tutaj zmień string jak chcesz}
        elseif dzien == 3 then
            dzien = "Czwartek"          --{Tutaj zmień string jak chcesz}
        elseif dzien == 4 then
            dzien = "Piątek"            --{Tutaj zmień string jak chcesz}
        elseif dzien == 5 then
            dzien = "Sobota"            --{Tutaj zmień string jak chcesz}
        elseif dzien == 6 then
            dzien = "Niedziela"         --{Tutaj zmień string jak chcesz}
        end

        exports['dopamineNotify']:Alert("Powiadomienie", "<span style='color:#c7c7c7'>Spoglądasz na zegarek i widzisz "  ..godzina..":"..minuta..", "..dzien, 5000, 'info') --{Tutaj zmień notyfikacje, zachowaj zmienne(godzina, minuta, dzien)}

        playAnim('amb@code_human_wander_idles@male@idle_a', 'idle_a_wristwatch', 2100)  --{animacja}

    else

        exports['dopamineNotify']:Alert("Powiadomienie", "<span style='color:#c7c7c7'>Nie masz jak sprawdzić godziny, zakup zegarek", 5000, 'info')   --{Tutaj zmień notyfikacje}

        Wait(7000)                                                  --{Czas kiedy ma wysłać się komenda na dole}

        exports['dopamineNotify']:Alert("Powiadomienie", "<span style='color:#c7c7c7'>Możesz spróbować spytać o godzinę innego gracza", 5000, 'info')     --{Tutaj zmień notyfikacje}

    end
end

RegisterCommand("clock", function(source, args, raw)    
    czas()
end)

-- LIFIK.app --

