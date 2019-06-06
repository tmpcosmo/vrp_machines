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

machines = {
    [1] = 992069095,        --https://objects.gt-mp.net/objects/prop_vend_soda_01.jpg
    [2] = 1114264700,       --https://objects.gt-mp.net/objects/prop_vend_soda_02.jpg
    [3] = 690372739,        --https://objects.gt-mp.net/objects/prop_vend_coffe_01.jpg
    [4] = 1099892058,       --https://objects.gt-mp.net/objects/prop_vend_water_01.jpg
    [5] = -1581502570,      --https://objects.gt-mp.net/objects/prop_hotdogstand_01.jpg
    [6] = 1129053052,       --https://objects.gt-mp.net/objects/prop_burgerstand_01.jpg
    [7] = -654402915        --https://objects.gt-mp.net/objects/prop_vend_snak_01.jpg
}

local props = {}
local toofar = true
local zone

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if toofar then
            local myCoords = GetEntityCoords(GetPlayerPed(-1))
            local cont = 0
            for i = 1, #machines do
                cont = cont + 1
                if not zone then
                    local zoneMachine = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 2.0, machines[i], false, false)
                    if zoneMachine ~= nil and zoneMachine ~= 0 then
                        local coords = GetEntityCoords(zoneMachine)
                        local distance  = GetDistanceBetweenCoords(myCoords.x, myCoords.y, myCoords.z, coords.x, coords.y, coords.z)
                        if distance < 1 then
                            table.insert(props, machines[i])
                        end
                    end
                end
            end
            if cont == 7 and #props ~= 0 and not zone then
                zone = true
                toofar = false
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if not toofar then
            for i = 1, #props do
                if zone then
                    local myCoords = GetEntityCoords(GetPlayerPed(-1))
                    local closestMachine = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 0.75, props[i], false, false)
                    local coords = GetEntityCoords(closestMachine)
                    local distance  = GetDistanceBetweenCoords(myCoords.x, myCoords.y, myCoords.z, coords.x, coords.y, coords.z)
                    if distance > 2 then
                        zone = false
                        toofar = true
                        props = {}
                    else
                        local machinesLoc  = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z}
                        if props[i] == 992069095 then
                            DrawText3Ds(machinesLoc['x'], machinesLoc['y'], machinesLoc['z'], "Press ~g~E ~w~to buy eCola.\n~g~$~w~5")
                            if IsControlJustReleased(0, 38) then
                                TriggerServerEvent('machine:buy',"eCola")
                                Citizen.Wait(5000)
                            end
                        elseif props[i] == 1114264700 then
                            DrawText3Ds(machinesLoc['x'], machinesLoc['y'], machinesLoc['z'], "Press ~g~E ~w~to buy Sprunk.\n~g~$~w~5")
                            if IsControlJustReleased(0, 38) then
                                TriggerServerEvent('machine:buy',"Sprunk")
                                Citizen.Wait(5000)
                                end
                        elseif props[i] == 690372739 then
                            DrawText3Ds(machinesLoc['x'], machinesLoc['y'], machinesLoc['z']+1, "Press ~g~E ~w~to buy Coffee.\n~g~$~w~5")
                            if IsControlJustReleased(0, 38) then
                                TriggerServerEvent('machine:buy',"Coffee")
                                Citizen.Wait(5000)
                            end
                        elseif props[i] == 1099892058 then
                            DrawText3Ds(machinesLoc['x'], machinesLoc['y'], machinesLoc['z']+1, "Press ~g~E ~w~to buy Water.\n~g~$~w~5")
                            if IsControlJustReleased(0, 38) then
                                TriggerServerEvent('machine:buy',"Water")
                                Citizen.Wait(5000)
                            end
                        elseif props[i] == -1581502570 then
                            DrawText3Ds(machinesLoc['x'], machinesLoc['y'], machinesLoc['z']+1, "Press ~g~E ~w~to buy HotDog.\n~g~$~w~5")
                            if IsControlJustReleased(0, 38) then
                                TriggerServerEvent('machine:buy',"HotDog")
                                Citizen.Wait(5000)
                            end
                        elseif props[i] == 1129053052 then
                            DrawText3Ds(machinesLoc['x'], machinesLoc['y'], machinesLoc['z']+1, "Press ~g~E ~w~to buy Burger.\n~g~$~w~5")
                            if IsControlJustReleased(0, 38) then
                                TriggerServerEvent('machine:buy',"Burger")
                                Citizen.Wait(5000)
                            end
                        elseif props[i] == -654402915 then
                            DrawText3Ds(machinesLoc['x'], machinesLoc['y'], machinesLoc['z'], "Press ~g~E ~w~to buy Phat Chips.\n~g~$~w~5")
                            if IsControlJustReleased(0, 38) then
                                TriggerServerEvent('machine:buy',"Phat Chips")
                                Citizen.Wait(5000)
                            end
                        end
                    end
                end
            end
        end
    end
end)