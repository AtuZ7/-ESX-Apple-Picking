CreateThread(function()
    RequestModel(Config.PedModel)
    while (not HasModelLoaded(Config.PedModel)) do
        Wait(1)
    end
    AppleFarmer1 = CreatePed(1, Config.PedModel, Config.Blips.Processing.coords, false, true)
    AppleFarmer2 = CreatePed(1, Config.PedModel, Config.Blips.Seller.coords, false, true)
    SetEntityInvincible(AppleFarmer1, true)
    SetBlockingOfNonTemporaryEvents(AppleFarmer1, true)
    FreezeEntityPosition(AppleFarmer1, true)
    SetEntityInvincible(AppleFarmer2, true)
    SetBlockingOfNonTemporaryEvents(AppleFarmer2, true)
    FreezeEntityPosition(AppleFarmer2, true)
end)

if Config.UseBlips then
    CreateThread(function()
        for _, v in pairs(Config.Blips) do
            if v.active then
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
        end
    end)
end

RegisterNetEvent('proccess_apples:ounamenuu', function(args, anim, servervent)
    lib.registerContext({
        id = 'proccess_apples',
        title = Config.Text["ProcessingLabel"],
        options = {
            {
                title = Config.Text["ContectTitle"],
                description = Config.Text["ContectDescription"],
                onSelect = function ()
                    TriggerEvent('atu-applejob:SellingJuice', args, anim, servervent)
                end
            },
        },
    })
    lib.showContext('proccess_apples')
end)

RegisterNetEvent('atu-applejob:SellingJuice', function(args, anim, serverevent)
    FreezeEntityPosition(PlayerPedId(), true)
    if args == Config.TargetCoords.Pickup.args then
        local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 1}})
        if success then
            lib.progressCircle({
                FreezeEntityPosition(PlayerPedId(), true),
                duration = anim.duration,
                position = 'bottom',
                useWhileDead = false,
                canCancel = false,
                disable = {
                    car = true,
                },
                anim = {
                    dict = anim.dict,
                    clip = anim.clip
                },
                prop = {
                    model = anim.prop.model,
                    pos = anim.prop.pos,
                    rot = anim.prop.rot
                },
            })
            TriggerServerEvent(serverevent, args)
        else
            lib.notify({title = Config.Text["notifyTitle"], description = Config.Text["FailedPickingApples"], type = 'error'})
        end
    elseif args == Config.TargetCoords.Selling.args or args == Config.TargetCoords.Processing.args then
        if lib.progressCircle({
            duration = anim.duration,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = anim.dict,
                clip = anim.clip
            },
            prop = {
                model = anim.prop.model,
                pos = anim.prop.pos,
                rot = anim.prop.rot
            },
        })
        then
            TriggerServerEvent(serverevent, args)
        else
            lib.notify({Config.Text["notifyTitle"], Config.Text["CancelledProcessing"], type = 'error'})
        end
    end
    FreezeEntityPosition(PlayerPedId(), false)
end)

for k,v in pairs (Config.TargetCoords) do
    for i=1, #v.Coords, 1 do
        exports.ox_target:addBoxZone({
            coords = v.Coords[i].pos,
            size = v.Size,
            rotation = v.Heading,
            debug = false,
            options = {
                {
                    name = 'ProcessingApple',
                    icon = v.icon,
                    label = v.label,
                    onSelect = function()
                        TriggerEvent(v.event, v.args, v.animation, v.servervent)
                        v.Coords[i].activate = false
                        Wait(math.random(5000,15000))
                        v.Coords[i].activate = true
                    end,
                    canInteract = function()
                        if k == 'Processing' or k == 'Selling' then
                            return true
                        elseif v.Coords[i].activate then
                            return true
                        end
                    end
                },
            }
        })
    end
end