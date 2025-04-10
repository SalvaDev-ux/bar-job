--[[
  Bar Job for FiveM (ESX Legacy)
  Author: SalvaDev
  Version: 1.0.0
  
  Server-side script
]]

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('bar:toggleDuty')
AddEventHandler('bar:toggleDuty', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if xPlayer.job.name == 'bar' then
        if xPlayer.job.grade_name == 'off' then
            xPlayer.setJob('bar', 0)
            TriggerClientEvent('esx:showNotification', src, _U('duty_on'))
        else
            xPlayer.setJob('bar', xPlayer.job.grade - 1)
            TriggerClientEvent('esx:showNotification', src, _U('duty_off'))
        end
    end
end)

-- Créer les stashes au chargement de la ressource
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        -- À adapter selon votre système d'inventaire
        exports.ox_inventory:RegisterStash('bar_storage', 'Bar Storage', 50, 100000, nil)
        exports.ox_inventory:RegisterStash('bar_fridge', 'Bar Fridge', 50, 100000, nil)
        exports.ox_inventory:RegisterStash('bar_tray', 'Bar Tray', 10, 10000, nil)
    end
end)

-- Créer le job dans la base de données au premier lancement
MySQL.ready(function()
    MySQL.Async.execute('INSERT IGNORE INTO `jobs` (name, label) VALUES (@name, @label)', {
        ['@name'] = 'bar',
        ['@label'] = 'Bar'
    })
    
    MySQL.Async.execute('INSERT IGNORE INTO `job_grades` (job_name, grade, name, label, salary) VALUES (@job_name, @grade, @name, @label, @salary)', {
        ['@job_name'] = 'bar',
        ['@grade'] = 0,
        ['@name'] = 'barman',
        ['@label'] = 'Barman',
        ['@salary'] = 150
    })
    
    MySQL.Async.execute('INSERT IGNORE INTO `job_grades` (job_name, grade, name, label, salary) VALUES (@job_name, @grade, @name, @label, @salary)', {
        ['@job_name'] = 'bar',
        ['@grade'] = 1,
        ['@name'] = 'boss',
        ['@label'] = 'Patron',
        ['@salary'] = 300
    })
    
    MySQL.Async.execute('INSERT IGNORE INTO `job_grades` (job_name, grade, name, label, salary) VALUES (@job_name, @grade, @name, @label, @salary)', {
        ['@job_name'] = 'bar',
        ['@grade'] = 2,
        ['@name'] = 'off',
        ['@label'] = 'Hors service',
        ['@salary'] = 0
    })
    
    -- Créer la société pour le job
    MySQL.Async.execute('INSERT IGNORE INTO `addon_account` (name, label, shared) VALUES (@name, @label, @shared)', {
        ['@name'] = 'society_bar',
        ['@label'] = 'Bar',
        ['@shared'] = 1
    })
    
    MySQL.Async.execute('INSERT IGNORE INTO `addon_account_data` (account_name, money) VALUES (@account_name, @money)', {
        ['@account_name'] = 'society_bar',
        ['@money'] = 0
    })
end)