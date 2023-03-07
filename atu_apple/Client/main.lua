local PedCoords = Config.Blips.Processing.coords
local PedCoords1 = Config.Blips.Seller.coords
local PedModel = Config.PedModel

local Target = exports.ox_target
local Input = lib.inputDialog

RegisterNetEvent('atu-ounatoo:notify')
AddEventHandler('atu-ounatoo:notify', function(title, message, msgType)	
    -- Place notification system info here, ex: exports['mythic_notify']:SendAlert('inform', message)
    if not msgType then
        lib.notify({
            title = title,
            description = message,
            type = 'inform'
        })
    else
        lib.notify({
            title = title,
            description = message,
            type = msgType
        })
    end
end)
-- Blip
if Config.UseBlips then
    CreateThread(function()
        for _, v in pairs(Config.Blips) do
            local Blips = AddBlipForCoord(v.coords)
            SetBlipSprite(Blips, v.sprite)
            SetBlipDisplay(Blips, v.display)
            SetBlipColour(Blips, v.colour)
            SetBlipScale(Blips, v.scale)
            SetBlipAsShortRange(Blips, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(v.label)
            EndTextCommandSetBlipName(Blips)
        end
    end)
end

local function LoadESXVersion()
    ESX = exports["es_extended"]:getSharedObject()
    -- Peds
    CreateThread(function()
        RequestModel(PedModel)
        while (not HasModelLoaded(PedModel)) do
            Wait(1)
        end
        AppleFarmer1 = CreatePed(1, PedModel, PedCoords, false, true)
        AppleFarmer2 = CreatePed(1, PedModel, PedCoords1, false, true)
        SetEntityInvincible(AppleFarmer1, true)
        SetBlockingOfNonTemporaryEvents(AppleFarmer1, true)
        FreezeEntityPosition(AppleFarmer1, true)
        SetEntityInvincible(AppleFarmer2, true)
        SetBlockingOfNonTemporaryEvents(AppleFarmer2, true)
        FreezeEntityPosition(AppleFarmer2, true)
    end)

    CreateThread(function()
        for _, v in pairs(AppleTrees) do
            exports.ox_target:addBoxZone({
                coords = vec3(v.coords.x, v.coords.y, v.coords.z),
                size = v.size,
                rotation = v.heading,
                debug = false,
                options = {
                    {
                        name = v.name,
                        event = 'atu-applejob:PickingApples',
                        icon = 'fa-solid fa-hand',
                        label = Config.Text["PickApple"],
                    }
                }
            })
        end
    end)

    -- exports.ox_target:addBoxZone({
    --     coords = Config.TargetCoords.processingCoords,
    --     size = vec3(1, 1, 4),
    --     rotation = Config.TargetCoords.processingHeading,
    --     debug = false,
    --     options = {
    --         {
    --             name = 'ProcessingApple',
    --             event = 'atu-apple:startukskas',
    --             icon = 'fa-solid fa-filter',
    --             label = Config.Text["ProcessingLabel"],
    --         },
    --         {
    --             name = 'SellingRawApples',
    --             event = 'atu-applejob:SellRawApple',
    --             icon = 'fa-solid fa-hand-holding-dollar',
    --             label = Config.Text["SellApplesLabel"],
    --         }
    --     }
    -- })
    RegisterNetEvent('proccess_apples:ounamenuu', function()
        lib.registerContext({
            id = 'proccess_apples',
            title = Config.Text["ProcessingLabel"],
            options = {
                {
                    title = Config.Text["ContectTitle"],
                    description = Config.Text["ContectDescription"],
                    event = 'atu-apple:startukskas'
                },
                
            },
        })
        lib.showContext('proccess_apples')
    end)
    exports.ox_target:addBoxZone({
        coords = Config.TargetCoords.processingCoords,
        size = vec3(1, 1, 4),
        rotation = Config.TargetCoords.processingHeading,
        debug = false,
        options = {
            {
                name = 'ProcessingApple',
                event = 'proccess_apples:ounamenuu',
                icon = 'fa-solid fa-filter',
                label = Config.Text["ProcessingLabel"],
            },
        }
    })
    

    exports.ox_target:addBoxZone({
        coords = Config.TargetCoords.sellingCoords,
        size = vec3(1, 1, 4),
        rotation = Config.TargetCoords.sellingHeading,
        debug = false,
        options = {
            {
                name = 'selljuices',
                event = 'atu-applejob:SellingJuice',
                icon = 'fa-solid fa-bottle-water',
                label = Config.Text["SellJuice"],
            }
        }
    })

    --Apple Picking Event
    RegisterNetEvent('atu-applejob:PickingApples', function()
        local Ped = PlayerPedId()
        local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 1}})
        if success then
            lib.progressCircle({
                FreezeEntityPosition(Ped, true),
                duration = 2500,
                position = 'bottom',
                useWhileDead = false,
                canCancel = false,
                disable = {
                    car = true,
                },
                anim = {
                    dict = 'missmechanic',
                    clip = 'work_base'
                },
                prop = {
                    model = `prop_food_burg1`,
                    pos = vec3(0.03, 0.03, 0.03),
                    rot = vec3(0.0, 0.0, -1.5)
                },
            })
            TriggerServerEvent('atu-apple:start')
        else
            --ESX.ShowNotification(Config.Text["FailedPickingApples"], "error")
            lib.notify({
                title = Config.Text["notifyTitle"],
                description = Config.Text["FailedPickingApples"],
                type = 'error'
            })
        end
        FreezeEntityPosition(Ped, false)
    end)

    --Processing Event
    RegisterNetEvent('atu-apple:startukskas', function()
        local Ped = PlayerPedId()
        FreezeEntityPosition(Ped, true)
        if lib.progressCircle({
            duration = Config.OnProcess.pressingConfig.timer,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true
            },
            anim = {
                dict = 'missfam4',
                clip = 'base'
            },
            prop = {
                model = `p_amb_clipboard_01`,
                pos = vec3(0.00, 0.00, 0.00),
                rot = vec3(0.0, 0.0, -1.5)
            },
        })
        then
            TriggerServerEvent("atu-ounamahl:algus")
        else
            lib.notify({
                title = Config.Text["notifyTitle"],
                description = Config.Text["CancelledProcessing"],
                type = 'error'
            })
            
            
        end
        FreezeEntityPosition(Ped, false)
    end)

    RegisterNetEvent('atu-applejob:SellRawApple', function()
        local Ped = PlayerPedId()
        FreezeEntityPosition(Ped, true)
        if lib.progressCircle({
            duration = 4000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = 'missfam4',
                clip = 'base'
            },
            prop = {
                model = `p_amb_clipboard_01`,
                pos = vec3(0.00, 0.00, 0.00),
                rot = vec3(0.0, 0.0, -1.5)
            },
        })
        then
            TriggerServerEvent("atu-oun:muukvms")
        else
            --ESX.ShowNotification(Config.Text["CancelledProcessing"], "error")
            lib.notify({
                title = Config.Text["notifyTitle"],
                description = Config.Text["CancelledProcessing"],
                type = 'error'
            })
            
        end
        FreezeEntityPosition(Ped, false)
    end)

    RegisterNetEvent('atu-applejob:SellingJuice', function()
        local Ped = PlayerPedId()
        FreezeEntityPosition(Ped, true)
        if lib.progressCircle({
            duration = 4000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = 'missfam4',
                clip = 'base'
            },
            prop = {
                model = `p_amb_clipboard_01`,
                pos = vec3(0.00, 0.00, 0.00),
                rot = vec3(0.0, 0.0, -1.5)
            },
        })
        then
            TriggerServerEvent("atu-applejob:muubmahavms")

        else
            --ESX.ShowNotification(Config.Text["CancelledProcessing"], "error")
            lib.notify({
                Config.Text["notifyTitle"],
                Config.Text["CancelledProcessing"],
                type = 'error'
            })
        end
        FreezeEntityPosition(Ped, false)
    end)
end

if Config.Framework == "ESX" then
    LoadESXVersion()
end


