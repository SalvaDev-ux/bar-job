--[[
  Bar Job for FiveM (ESX Legacy)
  Author: SalvaDev
  Version: 1.0.0
]]

-- Configuration
Config = {}
Config.Debug = false
Config.Locale = 'fr'

-- Positions
Config.Locations = {
    ["duty"] = {
        [1] = vector3(127.71, -1283.57, 29.27),
    },
    ["tray"] = {
        [1] = vector3(129.04, -1284.7, 29.27),
    },
    ["fridge"] = {
        [1] = vector3(129.24, -1280.96, 29.27),
    },
    ["storage"] = {
        [1] = vector3(135.53, -1287.64, 29.27),
    },
    ["garage"] = {
        [1] = vector4(139.86, -1274.75, 29.0, 209.61),
    },
    ["boss"] = {
        [1] = vector3(131.13, -1282.9, 29.27),
    },
}

-- Véhicules du garage
Config.Vehicles = {
    ["sultan"] = {
        ["label"] = "Voiture de livraison",
        ["vehicle"] = "sultan",
        ["price"] = 0,
    },
    ["faggio"] = {
        ["label"] = "Scooter de livraison",
        ["vehicle"] = "faggio",
        ["price"] = 0,
    },
}

-- Items du bar
Config.Items = {
    ["cocktail"] = {
        ["price"] = 12,
    },
    ["beer"] = {
        ["price"] = 8,
    },
    ["wine"] = {
        ["price"] = 15,
    },
    ["vodka"] = {
        ["price"] = 20,
    },
    ["whiskey"] = {
        ["price"] = 25,
    },
}

-- Traductions
Locales = {}
Locales['fr'] = {
    ['duty_on'] = 'Vous êtes en service!',
    ['duty_off'] = 'Vous êtes hors service!',
    ['boss_menu'] = 'Menu Patron',
    ['storage_menu'] = 'Stockage',
    ['garage_menu'] = 'Garage',
    ['billing_menu'] = 'Facturation',
    ['fridge_menu'] = 'Réfrigérateur',
    ['open_bossmenu'] = 'Appuyez sur ~g~E~w~ pour accéder au menu patron',
    ['open_storage'] = 'Appuyez sur ~g~E~w~ pour accéder au stockage',
    ['open_garage'] = 'Appuyez sur ~g~E~w~ pour accéder au garage',
    ['open_fridge'] = 'Appuyez sur ~g~E~w~ pour accéder au réfrigérateur',
    ['create_bill'] = 'Créer une facture',
    ['amount'] = 'Montant',
    ['bill_sent'] = 'Facture envoyée',
    ['no_players_nearby'] = 'Aucun joueur à proximité',
    ['vehicle_spawned'] = 'Véhicule sorti',
    ['already_have_vehicle'] = 'Vous avez déjà un véhicule dehors',
    ['vehicle_in_spot'] = 'Il y a déjà un véhicule à cet endroit',
    ['need_job'] = 'Vous devez être employé du bar',
}

-- Fonction pour traduire
function _U(str)
    if Locales[Config.Locale] ~= nil then
        if Locales[Config.Locale][str] ~= nil then
            return Locales[Config.Locale][str]
        else
            return 'Translation [' .. Config.Locale .. '][' .. str .. '] does not exist'
        end
    else
        return 'Locale [' .. Config.Locale .. '] does not exist'
    end
end