Config = {}

Config.Framework = "ESX"      -- ESX Framework      ---- MAY DO TO QB LATER
Config.Target = "OX"         --OX Target            ---- MAY DO TO QB LATER

Config.UseBlips = true -- True turns blips on | false turns blips off

Config.MinDistance = 2.5 -- Minimal distance from the tree to collect (Exploiter Check)

Config.Blips = {
    Field = {
        label = "Apple trees", -- Blip label
        coords = vector3(235.7183, 6519.5884, 31.2172), -- Coords  for blips
        sprite = 1, -- Blip Spirte
        colour = 6, -- Blip color
        scale = 0.85, -- Blip Scale
        display = 6, -- Blip Display
    },
    Processing = {
        label = "Apple juice",
        coords = vector4(1680.9293, 6428.5781, 32.1713 - 1, 328.2904),  -- z coords is  - 1 because ped will be in air if you copy coords from tx admin like i do
        sprite = 280,
        colour = 6,
        scale = 0.7,
        display = 6,
    },
    Seller = {
        label = "Sell apples",
        coords = vector4(1465.7437, 6547.8828, 14.1546 - 1, 91.5254), -- z coords is  - 1 because ped will be in air if you copy coords from tx admin like i do
        sprite = 605,
        colour = 6,
        scale = 0.7,
        display = 6,
    }
}

Config.PedModel = "a_m_m_farmer_01" -- Ped model choose from here: https://docs.fivem.net/docs/game-references/ped-models/


Config.CanLootMultiple = true -- Can the player loot multiple items?
Config.MaxLootItem = 2 -- If Config.CanLootMultiple = true. Max items the player can loot
Config.Apples = {
    [1] = {item = 'apple', chances = 49, min = 1, max = 3},
    [2] = {item = 'green_apple', chances = 49, min = 1, max = 2},
    [3] = {item = 'rotten_apple', chances = 2, min = 1, max = 1},
}

Config.OnProcess = {
    pressingConfig = {
        timer = 5000,
        amountRedApple = 5, -- Amount needed red apples to press into apple juice
        amountGreenApple = 3, -- Amount needed green apples to press into apple juice
        amountRottenApple = 1, -- Amount needed rotten apples to press into apple juice
        receiving = 1, -- Amount to receive ( 1 apple Juice)
    }
}

Config.SellPrice = {
    Rawapples = {
        min = 20, --- How much money? Min for selling apples
        max = 32  --- How much money? max for selling apples
    },
    Juice = {
        min = 275,  --- How much money? Min for selling juice.
        max = 320,  --- How much money? Max for selling juice.
    }
}


Config.TargetCoords = {
    processingCoords = vec3(1680.9293, 6428.5781, 32.1713 - 1), -- Ox Target Placement
    processingHeading = 328.2904,
    sellingCoords = vector3(1465.7437, 6547.8828, 14.1546 - 1),
    sellingHeading = 36.14,
}

Config.Text = { -- Text / langs
    --- Notify title
    notifyTitle = "Apple",

    -- Target label
    PickApple = "Pick Apples",
    SellApplesLabel = "Sell Apples",
    ProcessingLabel = "Process Apples",
    SellJuice = "Sell Apples",

    -- Other Text
    PickedApples = "You've Picked apples",
    DidntFind = "You didn't find any apples",
    ProcessingNotification = "Pressing apples",
    ApplesProcessed = "You have pressed apples ",
    ApplesProcessed1 = " To apple juice",
    successfully_sold = "You Have Sold apples",
    successfully_sold1 = "You Have Sold apple juice",

    -- Error
    FailedPickingApples = "Couldn't Pick apples",
    CancelledProcessing = "Interrupted",
    ErrorProcessingAmount = "You Don't Have Enough Apples",
    NoItem = "You Don't Have Any Apples",


    -- Context when making juice
    ContectTitle = 'Press apples into juice',
    ContectDescription = 'Make one juice. You need to have: 5x Red apple, 3x Green Apple, 1x Rotten Apple',
}
