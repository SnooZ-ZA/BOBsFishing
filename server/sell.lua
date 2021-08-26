local ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)


RegisterServerEvent("esx-fish:packagefish")
AddEventHandler("esx-fish:packagefish", function()
    local player = ESX.GetPlayerFromId(source)

    local currentfish = player.getInventoryItem("fish")["count"]
    
    if currentfish >= 25 then
        player.removeInventoryItem("fish", 25)
		TriggerClientEvent("esx-fish:packagePl", source)      
    else
        TriggerClientEvent("esx:showNotification", source, "You don't have enough fish to Package.")
    end
end)

RegisterServerEvent("esx-fish:sell")
AddEventHandler("esx-fish:sell", function()
    local player = ESX.GetPlayerFromId(source)
        player.addMoney(1200)
        TriggerClientEvent("esx:showNotification", source, "You got Paid $1200.")
end)