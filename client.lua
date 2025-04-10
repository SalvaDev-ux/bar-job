--[[
  Bar Job for FiveM (ESX Legacy)
  Author: SalvaDev
  Version: 1.0.0
  
  Client-side script
]]

-- Vérification de version
CreateThread(function()
    local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
    PerformHttpRequest('https://raw.githubusercontent.com/SalvaDev-ux/bar-job/main/version.json', function(code, res, headers)
        if code == 200 then
            local rv = json.decode(res)
            if rv.version ~= currentVersion then
                print('^1[bar-job] ^1Une nouvelle version est disponible: ' .. rv.version)
                print('^1[bar-job] ^1Votre version: ' .. currentVersion)
                print('^1[bar-job] ^1Veuillez mettre à jour:https://github.com/SalvaDev-ux/bar-job.git')
            end
        else
            print('^1[bar-job] ^1Impossible de vérifier la version')
        end
    end, 'GET')
end)

-- Initialisation ESX
ESX = nil
local PlayerData = {}

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

-- Initialisation des blips
CreateThread(function()
    local blip = AddBlipForCoord(127.71, -1283.57, 29.27)
    SetBlipSprite(blip, 121)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.7)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, 27)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Bar")
    EndTextCommandSetBlipName(blip)
end)

-- Fonctions ox-target
CreateThread(function()
    if Config.Debug then
        print("Initialisation de ox-target")
    end

    -- Vérifier que ox-target est présent
    if GetResourceState('ox_target') ~= 'started' then
        print("^1[ERROR] ox_target n'est pas démarré, les interactions ne fonctionneront pas!")
        return
    end

    -- Points de service
    exports.ox_target:addBoxZone({
        coords = Config.Locations["duty"][1],
        size = vector3(1.0, 1.0, 2.0),
        rotation = 45.0,
        debug = Config.Debug,
        options = {
            {
                label = 'Prendre son service',
                icon = 'fas fa-sign-in-alt',
                event = 'bar:toggleDuty',
                job = 'bar',
            }
        }
    })

    -- Menu boss
    exports.ox_target:addBoxZone({
        coords = Config.Locations["boss"][1],
        size = vector3(1.0, 1.0, 2.0),
        rotation = 45.0,
        debug = Config.Debug,
        options = {
            {
                label = _U('boss_menu'),
                icon = 'fas fa-briefcase',
                event = 'bar:openBossMenu',
                job = {
                    ['bar'] = 'boss',
                }
            }
        }
    })

    -- Coffre
    exports.ox_target:addBoxZone({
        coords = Config.Locations["storage"][1],
        size = vector3(1.0, 1.0, 2.0),
        rotation = 45.0,
        debug = Config.Debug,
        options = {
            {
                label = _U('storage_menu'),
                icon = 'fas fa-box',
                event = 'bar:openStorage',
                job = 'bar',
            }
        }
    })

    -- Frigo
    exports.ox_target:addBoxZone({
        coords = Config.Locations["fridge"][1],
        size = vector3(1.0, 1.0, 2.0),
        rotation = 45.0,
        debug = Config.Debug,
        options = {
            {
                label = _U('fridge_menu'),
                icon = 'fas fa-snowflake',
                event = 'bar:openFridge',
                job = 'bar',
            }
        }
    })

    -- Garage
    exports.ox_target:addBoxZone({
        coords = Config.Locations["garage"][1].xyz,
        size = vector3(3.0, 3.0, 2.0),
        rotation = 45.0,
        debug = Config.Debug,
        options = {
            {
                label = _U('garage_menu'),
                icon = 'fas fa-car',
                event = 'bar:openGarage',
                job = 'bar',
            }
        }
    })

    -- Plateau
    exports.ox_target:addBoxZone({
        coords = Config.Locations["tray"][1],
        size = vector3(1.0, 1.0, 2.0),
        rotation = 45.0,
        debug = Config.Debug,
        options = {
            {
                label = 'Plateau',
                icon = 'fas fa-hand-holding',
                event = 'bar:openTray',
            }
        }
    })
end)

-- Events ox-target
RegisterNetEvent('bar:toggleDuty')
AddEventHandler('bar:toggleDuty', function()
    if PlayerData.job.name == 'bar' then
        TriggerServerEvent('bar:toggleDuty')
    end
end)

RegisterNetEvent('bar:openBossMenu')
AddEventHandler('bar:openBossMenu', function()
    if PlayerData.job.name == 'bar' and PlayerData.job.grade_name == 'boss' then
        TriggerEvent('esx_society:openBossMenu', 'bar', function(data, menu)
            menu.close()
        end, {wash = false})
    end
end)

RegisterNetEvent('bar:openStorage')
AddEventHandler('bar:openStorage', function()
    if PlayerData.job.name == 'bar' then
        TriggerEvent('inventory:openStash', 'bar_storage')
    end
end)

RegisterNetEvent('bar:openFridge')
AddEventHandler('bar:openFridge', function()
    if PlayerData.job.name == 'bar' then
        TriggerEvent('inventory:openStash', 'bar_fridge')
    end
end)

RegisterNetEvent('bar:openTray')
AddEventHandler('bar:openTray', function()
    TriggerEvent('inventory:openStash', 'bar_tray')
end)

RegisterNetEvent('bar:openGarage')
AddEventHandler('bar:openGarage', function()
    if PlayerData.job.name == 'bar' then
        OpenGarageMenu()
    end
end)

-- Menu Garage
function OpenGarageMenu()
    local elements = {}
    
    for k, v in pairs(Config.Vehicles) do
        table.insert(elements, {
            label = v.label .. ' - ' .. v.price .. '€',
            value = k
        })
    end
    
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage_menu', {
        title = _U('garage_menu'),
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        local vehicle = data.current.value
        SpawnVehicle(Config.Vehicles[vehicle].vehicle)
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end

-- Spawn un véhicule
function SpawnVehicle(vehicle)
    local coords = Config.Locations["garage"][1]
    local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(coords.x, coords.y, coords.z, 0, 3, 0)
    
    if found then
        ESX.Game.SpawnVehicle(vehicle, coords.xyz, coords.w, function(veh)
            SetVehicleNumberPlateText(veh, "BAR" .. math.random(100, 999))
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
            SetVehicleEngineOn(veh, true, true)
            ESX.ShowNotification(_U('vehicle_spawned'))
        end)
    else
        ESX.ShowNotification(_U('vehicle_in_spot'))
    end
end

-- Création de facture
RegisterCommand('barfacture', function()
    if PlayerData.job.name == 'bar' then
        OpenBillingMenu()
    else
        ESX.ShowNotification(_U('need_job'))
    end
end, false)

function OpenBillingMenu()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
        title = _U('create_bill'),
    }, function(data, menu)
        local amount = tonumber(data.value)
        
        if amount == nil or amount < 0 then
            ESX.ShowNotification('Montant invalide')
        else
            menu.close()
            
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            
            if closestPlayer == -1 or closestDistance > 3.0 then
                ESX.ShowNotification(_U('no_players_nearby'))
            else
                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_bar', 'Bar', amount)
                ESX.ShowNotification(_U('bill_sent'))
            end
        end
    end, function(data, menu)
        menu.close()
    end)
end