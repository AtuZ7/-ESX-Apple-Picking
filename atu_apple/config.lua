Config = {}

Config.UseBlips = true -- True turns blips on | false turns blips off
Config.PedModel = "a_m_m_farmer_01" -- Ped model choose from here: https://docs.fivem.net/docs/game-references/ped-models/

Config.Blips = {
    Field = {
        label = "Apple trees", -- Blip label
        coords = vector3(235.7183, 6519.5884, 31.2172), -- Coords  for blips
        sprite = 1, -- Blip Spirte
        colour = 6, -- Blip color
        scale = 0.85, -- Blip Scale
        display = 6, -- Blip Display
        active = true
    },
    Processing = {
        label = "Apple juice",
        coords = vector4(1680.9293, 6428.5781, 32.1713 - 1, 328.2904),  -- z coords is  - 1 because ped will be in air if you copy coords from tx admin like i do
        sprite = 280,
        colour = 6,
        scale = 0.7,
        display = 6,
        active = true
    },
    Seller = {
        label = "Sell apples",
        coords = vector4(1465.7437, 6547.8828, 14.1546 - 1, 91.5254), -- z coords is  - 1 because ped will be in air if you copy coords from tx admin like i do
        sprite = 605,
        colour = 6,
        scale = 0.7,
        display = 6,
        active = true
    }
}

Config.CanLootMultiple = true -- Can the player loot multiple items?
Config.MaxLootItem = 2 -- If Config.CanLootMultiple = true. Max items the player can loot
Config.Apples = {
    [1] = {item = 'apple', chances = 49, min = 1, max = 3},
    [2] = {item = 'green_apple', chances = 49, min = 1, max = 2},
    [3] = {item = 'rotten_apple', chances = 2, min = 1, max = 1},
}

Config.OnProcess = {
    pressingConfig = {
        amountRedApple = 5, -- Amount needed red apples to press into apple juice
        amountGreenApple = 3, -- Amount needed green apples to press into apple juice
        amountRottenApple = 1, -- Amount needed rotten apples to press into apple juice
        receiving = 1, -- Amount to receive ( 1 apple Juice)
    }
}

Config.SellPrice = {
    Juice = {
        min = 275,  --- How much money? Min for selling juice.
        max = 320,  --- How much money? Max for selling juice.
    }
}

Config.TargetCoords = {
    Processing = {
        Coords = {
            {pos = vec3(1680.9293, 6428.5781, 31.1713), activate = true}
        },
        Heading = 328.2904,
        Size = vec3(1, 1, 4),
        event = 'proccess_apples:ounamenuu',
        servervent = 'atu-apple:start',
        args = 'processing',
        icon = 'fa-solid fa-filter',
        label = "Process Apples",
        animation = {
            duration = 5000,
            dict = 'missfam4',
            clip = 'base',
            prop = {
                model = `p_amb_clipboard_01`,
                pos = vec3(0.00, 0.00, 0.00),
                rot = vec3(0.0, 0.0, -1.5)
            },
        }
    },
    Selling = {
        Coords = {
            {pos = vector3(1465.7437, 6547.8828, 13.1546), activate = true}
        },
        Heading = 36.14,
        Size = vec3(1, 1, 4),
        event = 'atu-applejob:SellingJuice',
        servervent = 'atu-apple:start',
        args = 'selling',
        icon = 'fa-solid fa-bottle-water',
        label = "Sell Apples",
        animation = {
            duration = 4000,
            dict = 'missfam4',
            clip = 'base',
            prop = {
                model = `p_amb_clipboard_01`,
                pos = vec3(0.00, 0.00, 0.00),
                rot = vec3(0.0, 0.0, -1.5)
            },
        }
    },
    Pickup = {
        Coords = {
            {pos = vec3(224.0111, 6523.6496, 31.3488), activate = true},
            {pos = vec3(233.4463, 6524.9463, 31.2423), activate = true},
            {pos = vec3(242.8530, 6526.2943, 31.1194), activate = true},
            {pos = vec3(251.8434, 6527.2734, 30.9697), activate = true},
            {pos = vec3(261.4966, 6527.6738, 30.7516), activate = true},
            {pos = vec3(270.5160, 6530.5913, 30.5140), activate = true},
            {pos = vec3(280.3726, 6530.8213, 30.2113), activate = true},
            {pos = vec3(281.3847, 6518.7593, 30.1759), activate = true},
            {pos = vec3(272.5428, 6519.0347, 30.4537), activate = true},
            {pos = vec3(262.3057, 6516.3647, 30.7270), activate = true},
            {pos = vec3(253.5471, 6513.8364, 30.9344), activate = true},
            {pos = vec3(244.7999, 6515.2314, 31.0955), activate = true},
            {pos = vec3(234.4441, 6512.3140, 31.2421), activate = true},
            {pos = vec3(225.9627, 6511.3428, 31.3348), activate = true},
            {pos = vec3(217.9120, 6510.0156, 31.4044), activate = true},
            {pos = vec3(208.5137, 6509.5146, 31.4737), activate = true},
            {pos = vec3(199.5782, 6508.6895, 31.5093), activate = true},
            {pos = vec3(185.1954, 6498.0049, 31.5402), activate = true},
            {pos = vec3(193.9419, 6497.1230, 31.5254), activate = true},
            {pos = vec3(201.6348, 6497.0942, 31.4752), activate = true},
            {pos = vec3(209.8630, 6498.1689, 31.4596), activate = true},
            {pos = vec3(220.0066, 6499.3047, 31.3878), activate = true},
            {pos = vec3(227.7547, 6501.3613, 31.3186), activate = true},
            {pos = vec3(236.6761, 6501.9258, 31.2113), activate = true},
            {pos = vec3(246.7421, 6502.8467, 31.0598), activate = true},
            {pos = vec3(255.9491, 6503.5439, 30.8818), activate = true},
            {pos = vec3(263.8873, 6506.1631, 30.6918), activate = true},
            {pos = vec3(273.5343, 6507.3608, 30.4267), activate = true},
            {pos = vec3(282.0461, 6506.5659, 30.1485), activate = true}
        },
        Heading = 0,
        Size = vec3(1, 1, 2),
        event = 'atu-applejob:SellingJuice',
        servervent = 'atu-apple:start',
        args = 'pickup',
        icon = 'fa-solid fa-hand',
        label = "Pick Apples",
        animation = {
            duration = 2500,
            dict = 'missmechanic',
            clip = 'work_base',
            prop = {
                model = `prop_food_burg1`,
                pos = vec3(0.03, 0.03, 0.03),
                rot = vec3(0.0, 0.0, -1.5)
            },
        }
    }
}

Config.Text = {
    notifyTitle = "Apple",
    ProcessingLabel = "Process Apples",
    PickedApples = "You've Picked apples",
    DidntFind = "You didn't find any apples",
    ApplesProcessed = "You have pressed apples ",
    successfully_sold = "You Have Sold apple juice",
    FailedPickingApples = "Couldn't Pick apples",
    CancelledProcessing = "Interrupted",
    ErrorProcessingAmount = "You Don't Have Enough Apples",
    NoItem = "You Don't Have Any Apples",
    ContectTitle = 'Press apples into juice',
    ContectDescription = 'Make one juice. You need to have: 5x Red apple, 3x Green Apple, 1x Rotten Apple',
}