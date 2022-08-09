ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('clock', function(source) --{zmień nazwę przedmiotu}

    local _source = source

    TriggerClientEvent('esx_sprawdzaniezegarka:clock', source)

    
end)

