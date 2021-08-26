ESX                           = nil


Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)

        Citizen.Wait(5)
    end
end)


Citizen.CreateThread(function()
	if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	ESX.PlayerData = response
end)


local blips = {
      {title="Sell Fish", colour=4, id=68, x = -1806.66, y = -1183.85, z = 12.52}  
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.8)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

local fishloc = {
    {x = -1806.66, y = -1183.85, z = 12.52}
}
local sellfishloc = {
    {x = -1816.12, y = -1192.71, z = 13.80}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(fishloc) do
            DrawMarker(27, fishloc[k].x, fishloc[k].y, fishloc[k].z, 0, 0, 0, 0, 0, 0, 1.600, 1.600, 0.3001, 0, 153, 255, 255, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(sellfishloc) do
            DrawMarker(27, sellfishloc[k].x, sellfishloc[k].y, sellfishloc[k].z, 0, 0, 0, 0, 0, 0, 1.600, 1.600, 0.3001, 0, 153, 255, 255, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(fishloc) do
		
            local plyrefCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local recfdist = Vdist(plyrefCoords.x, plyrefCoords.y, plyrefCoords.z, fishloc[k].x, fishloc[k].y, fishloc[k].z)
			
            if recfdist <= 1.5 then
				drawText3D(fishloc[k].x, fishloc[k].y, fishloc[k].z + 1.0, '[E] ~b~Package Fish Here~s~')
				
				if IsControlJustPressed(0, 38) then
					TriggerServerEvent("esx-fish:packagefish")
				end			
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(sellfishloc) do
		
            local plyrefCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local recfSelldist = Vdist(plyrefCoords.x, plyrefCoords.y, plyrefCoords.z, sellfishloc[k].x, sellfishloc[k].y, sellfishloc[k].z)
			
            if recfSelldist <= 1.5 then
				drawText3D(sellfishloc[k].x, sellfishloc[k].y, sellfishloc[k].z + 1.0, '[E] ~b~Unpack Trolley Here~s~')
				
				if IsControlJustPressed(0, 38) then
					TriggerEvent("esx-fish:box")
				end			
            end
        end
    end
end)



RegisterNetEvent("esx-fish:packagePl")
AddEventHandler("esx-fish:packagePl",function()
		Citizen.Wait(10)
					exports.rprogress:Custom({
								Async = true,
								x = 0.5,
								y = 0.5,
								From = 0,
								To = 100,
								Duration = 10000,
								Radius = 60,
								Stroke = 10,
								MaxAngle = 360,
								Rotation = 0,
								Easing = "easeLinear",
								Label = "Packaging",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
								--animationDictionary = "missheistfbisetup1", -- https://alexguirre.github.io/animations-list/
								--animationName = "unlock_loop_janitor",
								},
								DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
								},
								})
					Citizen.Wait(10000)
					ClearPedTasks(PlayerPedId())
					Citizen.Wait(300)
					RequestAnimDict("anim@heists@box_carry@")
					while not HasAnimDictLoaded("anim@heists@box_carry@") do
					Citizen.Wait(1)
					end
					TaskPlayAnim(GetPlayerPed(-1),"anim@heists@box_carry@","idle",1.0, -1.0, -1, 49, 0, 0, 0, 0)
					Citizen.Wait(300)
						attachModel = GetHashKey('prop_rub_trolley03a')
						boneNumber = 28422
						SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263) 
						local bone = GetPedBoneIndex(GetPlayerPed(-1), boneNumber)
						RequestModel(attachModel)
							while not HasModelLoaded(attachModel) do
								Citizen.Wait(100)
							end
							attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
							AttachEntityToEntity(attachedProp, GetPlayerPed(-1), bone, 0.0, -0.25, -0.70, 0.0, 10.0, -90.0, 1, 1, 0, 0, 2, 1)
							ESX.ShowNotification("Push the Trolley to storage!")
end)


RegisterNetEvent("esx-fish:box")
AddEventHandler("esx-fish:box",function()
	if DoesEntityExist(attachedProp) then
		Citizen.Wait(10)
					exports.rprogress:Custom({
								Async = true,
								x = 0.5,
								y = 0.5,
								From = 0,
								To = 100,
								Duration = 3000,
								Radius = 60,
								Stroke = 10,
								MaxAngle = 360,
								Rotation = 0,
								Easing = "easeLinear",
								Label = "Unpacking",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
								--animationDictionary = "missheistfbisetup1", -- https://alexguirre.github.io/animations-list/
								--animationName = "unlock_loop_janitor",
								},
								DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
								},
								})
					Citizen.Wait(3000)
					ClearPedTasks(PlayerPedId())
					RemoveAnimDict("anim@heists@box_carry@")
					DeleteEntity(attachedProp)
					TriggerServerEvent("esx-fish:sell")
		else
		ESX.ShowNotification("Go Package First!")
		end
end)