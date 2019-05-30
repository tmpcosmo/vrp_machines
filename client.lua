Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
local cvRP = module("vrp", "client/vRP")
vRP = cvRP()

local vRPmachines = class("vRPmachines", vRP.Extension)

function vRPmachines:__construct()
  vRP.Extension.__construct(self)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.55, 0.55) --0.35
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

drinks = {
    [1] = 992069095,        --https://objects.gt-mp.net/objects/prop_vend_soda_01.jpg
    [2] = 1114264700,       --https://objects.gt-mp.net/objects/prop_vend_soda_02.jpg
    [3] = 690372739,        --https://objects.gt-mp.net/objects/prop_vend_coffe_01.jpg
    [4] = 1099892058        --https://objects.gt-mp.net/objects/prop_vend_water_01.jpg
}

foods = {
    [1] = -1581502570,      --https://objects.gt-mp.net/objects/prop_hotdogstand_01.jpg
    [2] = 1129053052,       --https://objects.gt-mp.net/objects/prop_burgerstand_01.jpg
    [3] = -654402915        --https://objects.gt-mp.net/objects/prop_vend_snak_01.jpg
}

local drinksLoc = {}
local foodsLoc = {}

-- Drinks loop
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local myCoords = GetEntityCoords(GetPlayerPed(-1))
        for i = 1, #drinks do
            local closestDrink = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 1.0, drinks[i], false, false)
            if closestDrink ~= nil and closestDrink ~= 0 then
                local coords = GetEntityCoords(closestDrink)
                local distance  = GetDistanceBetweenCoords(myCoords.x, myCoords.y, myCoords.z, coords.x, coords.y, coords.z)
                if distance < 1 then
                    drinksLoc  = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z}
                    if drinks[i] == 992069095 then
                        DrawText3Ds(drinksLoc['x'], drinksLoc['y'], drinksLoc['z'], "Press ~g~E ~w~to buy eCola.\n~g~$~w~5")
                        if IsControlJustReleased(0, 38) then
                            TriggerServerEvent('machine:buy',"eCola")
                            Citizen.Wait(5000)
                        end
                    elseif drinks[i] == 1114264700 then
                        DrawText3Ds(drinksLoc['x'], drinksLoc['y'], drinksLoc['z'], "Press ~g~E ~w~to buy Sprunk.\n~g~$~w~5")
                        if IsControlJustReleased(0, 38) then
                            TriggerServerEvent('machine:buy',"Sprunk")
                            Citizen.Wait(5000)
                        end
                    elseif drinks[i] == 690372739 then
                        DrawText3Ds(drinksLoc['x'], drinksLoc['y'], drinksLoc['z']+1, "Press ~g~E ~w~to buy Coffee.\n~g~$~w~5")
                        if IsControlJustReleased(0, 38) then
                            TriggerServerEvent('machine:buy',"Coffee")
                            Citizen.Wait(5000)
                        end
                    elseif drinks[i] == 1099892058 then
                        DrawText3Ds(drinksLoc['x'], drinksLoc['y'], drinksLoc['z']+1, "Press ~g~E ~w~to buy Water.\n~g~$~w~5")
                        if IsControlJustReleased(0, 38) then
                            TriggerServerEvent('machine:buy',"Water")
                            Citizen.Wait(5000)
                        end
                    end
                end
            end
        end
    end
end)

-- Foods loop
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local myCoords = GetEntityCoords(GetPlayerPed(-1))
        for i = 1, #foods do
            local closestFood = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 1.0, foods[i], false, false)
            if closestFood ~= nil and closestFood ~= 0 then
                local coords = GetEntityCoords(closestFood)
                local distance  = GetDistanceBetweenCoords(myCoords.x, myCoords.y, myCoords.z, coords.x, coords.y, coords.z)
                if distance < 1 then
                    foodsLoc  = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z}
                    if foods[i] == -1581502570 then
                        DrawText3Ds(foodsLoc['x'], foodsLoc['y'], foodsLoc['z']+1, "Press ~g~E ~w~to buy HotDog.\n~g~$~w~5")
                        if IsControlJustReleased(0, 38) then
                            TriggerServerEvent('machine:buy',"HotDog")
                            Citizen.Wait(5000)
                        end
                    elseif foods[i] == 1129053052 then
                        DrawText3Ds(foodsLoc['x'], foodsLoc['y'], foodsLoc['z']+1, "Press ~g~E ~w~to buy Burger.\n~g~$~w~5")
                        if IsControlJustReleased(0, 38) then
                            TriggerServerEvent('machine:buy',"Burger")
                            Citizen.Wait(5000)
                        end
                    elseif foods[i] == -654402915 then
                        DrawText3Ds(foodsLoc['x'], foodsLoc['y'], foodsLoc['z'], "Press ~g~E ~w~to buy Phat Chips.\n~g~$~w~5")
                        if IsControlJustReleased(0, 38) then
                            TriggerServerEvent('machine:buy',"Phat Chips")
                            Citizen.Wait(5000)
                        end
                    end
                end
            end
        end
    end
end)