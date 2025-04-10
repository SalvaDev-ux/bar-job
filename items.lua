-- Ajoutez ces items dans le fichier data/items.lua d'ox_inventory

['cocktail'] = {
    label = 'Cocktail',
    weight = 200,
    stack = true,
    consume = 0,
    client = {
        status = { thirst = 50 },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = { model = `prop_cocktail`, pos = { x = 0.01, y = 0.01, z = 0.06 }, rot = { x = 5.0, y = 5.0, z = -180.5 } },
        usetime = 5000,
    }
},

['beer'] = {
    label = 'Bière',
    weight = 350,
    stack = true,
    consume = 0,
    client = {
        status = { thirst = 30 },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = { model = `prop_amb_beer_bottle`, pos = { x = 0.01, y = 0.01, z = 0.06 }, rot = { x = 5.0, y = 5.0, z = -180.5 } },
        usetime = 5000,
    }
},

['wine'] = {
    label = 'Vin',
    weight = 300,
    stack = true,
    consume = 0,
    client = {
        status = { thirst = 40 },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = { model = `prop_wine_bot_01`, pos = { x = 0.01, y = 0.01, z = 0.06 }, rot = { x = 5.0, y = 5.0, z = -180.5 } },
        usetime = 5000,
    }
},

['vodka'] = {
    label = 'Vodka',
    weight = 300,
    stack = true,
    consume = 0,
    client = {
        status = { thirst = 40, drunk = 90 },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = { model = `prop_vodka_bottle`, pos = { x = 0.01, y = 0.01, z = 0.06 }, rot = { x = 5.0, y = 5.0, z = -180.5 } },
        usetime = 5000,
    }
},

['whiskey'] = {
    label = 'Whiskey',
    weight = 300,
    stack = true,
    consume = 0,
    client = {
        status = { thirst = 30, drunk = 80 },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = { model = `prop_whiskey_bottle`, pos = { x = 0.01, y = 0.01, z = 0.06 }, rot = { x = 5.0, y = 5.0, z = -180.5 } },
        usetime = 5000,
    }
},