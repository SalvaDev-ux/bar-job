fx_version 'cerulean'
game 'gta5'

author 'SalvaDev'
description 'Job Bar pour ESX Legacy avec ox-target'
version '1.0.0'

shared_scripts {
    '@es_extended/imports.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

dependencies {
    'es_extended',
    'ox_target',
    'esx_society',
    'esx_billing'
}