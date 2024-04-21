Config = {}

Config.ImagePath = 'nui://ox_inventory/web/images/' -- Source of images
Config.Debug = false -- Box zone debug

Config.Pawnshops = {
    [1] = {
        coords = vector3(412.14, 315.06, 102.15), -- Blip coords
        pedcoords = vector3(412.14, 315.06, 102.15), -- NPC coords
        heading = 205.0, -- NPC heading
        ped = 'ig_josh', -- NPC model | https://docs.fivem.net/docs/game-references/ped-models/
        length = 1.0, -- Lenght of third eye box zone
        width = 1.0, -- Width of third eye box zone
        distance = 3.0 -- Distance that the player can interact with the npc
    },
}

Config.ItemsSold = { -- Items sold at the pawnshop
    { name = 'phone', price = 500 },
    { name = 'water', price = 7 },
}

Config.ItemsBuy = { -- Items bought by the pawnshop
    ['phone'] = {
       label = 'Phone',
       price = 400,
    },
    ['water'] = {
       label = 'Water',
       price = 5,
    },
}