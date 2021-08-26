ESX = nil

TriggerEvent("esx:getSharedObject", function(response)
    ESX = response
end)

RegisterServerEvent('fishing:cought')
AddEventHandler('fishing:cought', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local fishQuantity = xPlayer.getInventoryItem('fish').count
	if fishQuantity < 100 then
		local luck = math.random(1, 10)
		xPlayer.addInventoryItem('fish', luck)
		TriggerClientEvent('esx:showNotification', source, '~g~You caught a fish kg ~y~'.. luck)
	else
	TriggerClientEvent('esx:showNotification', source, '~r~You cant carry more fish.')
	end
end)

ESX.RegisterUsableItem('rod', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('rod:onUse', source)
end)


function notification(text)
	TriggerClientEvent('esx:showNotification', source, text)
end

