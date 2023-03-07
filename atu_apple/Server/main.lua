local function checkDistance()
    local src = source
    local ped = GetPlayerPed(src)
    local check = GetEntityCoords(ped)
    local distanceCheck = Config.MinDistance
        for _,v in pairs(AppleTrees) do
            if #(check - v.coords) < distanceCheck then
                return true
            end
        return false
    end
end

local function pGive(playerId, item, amount)
    local Player = ESX.GetPlayerFromId(playerId)
    if not Player then return end

    if type(item) == 'string' then
        Player.addInventoryItem(item, amount)
        if ESX.GetItemLabel(item.item) then
            local itemString = amount .. 'x ' .. ESX.GetItemLabel(item)
            --TriggerClientEvent('esx:showNotification', playerId, _U('notifies_you_got', itemString))
            --TriggerClientEvent('atu-ounatoo:notify', playerId, Config.Text["notifyTitle"], Config.Text["PickedApples"], 'inform')
        else
            --TriggerClientEvent('esx:showNotification', playerId, _U('notifies_got_nothing'))
            --TriggerClientEvent('atu-ounatoo:notify', playerId, Config.Text["notifyTitle"], Config.Text["DidntFind"], 'inform')
        end
    elseif type(item) == 'table' and amount == 10000 then
        local itemString = ''
        if #item <= 0 then return TriggerClientEvent('atu-ounatoo:notify', playerId, Config.Text["notifyTitle"], Config.Text["DidntFind"], 'inform') end
        for _,i in pairs(item) do
            Player.addInventoryItem(i.item, i.amount)
            itemString = i.amount .. 'x ' .. ESX.GetItemLabel(i.item) .. ', ' .. itemString
        end
        if itemString ~= '' then
            TriggerClientEvent('atu-ounatoo:notify', playerId, Config.Text["notifyTitle"], Config.Text["PickedApples"], 'inform')
        else
            --TriggerClientEvent('esx:showNotification', playerId, _U('notifies_got_nothing'))
            TriggerClientEvent('atu-ounatoo:notify', playerId, Config.Text["notifyTitle"], Config.Text["DidntFind"], 'inform')

        end
    end
end

function DropItem(playerId)
    local Player = ESX.GetPlayerFromId(playerId)
    if not Player then return end

    if Config.CanLootMultiple then
        local itemTable = {}
        local itemAmount = math.random(1, Config.MaxLootItem)

        for i=1, itemAmount do
            local lootChance = math.random(1,100)
            local item = Config.Apples[math.random(1, #Config.Apples)]
            if lootChance >= item.chances then
                itemTable[#itemTable+1] = {item = item.item, amount = math.floor(math.random(item.min, item.max))}
            end
        end
        return pGive(playerId, itemTable, 10000)
    else
        local lootChance = math.random(1,100)
        local item = Config.Apples[math.random(1, #Config.Apples)]
        if lootChance >= item.chances then
            return pGive(playerId, item.item, math.random(item.min, item.max))
        end
    end
end

local function LoadESXVersion()
    ESX = exports["es_extended"]:getSharedObject()

    RegisterNetEvent('atu-apple:start', function()
        DropItem(source)
    end)

    RegisterNetEvent('atu-ounamahl:algus', function()

        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        local redApple = xPlayer.getInventoryItem('apple')
        local greenApple = xPlayer.getInventoryItem('green_apple')
        local rottenApple = xPlayer.getInventoryItem('rotten_apple')

        local processingAmount = Config.OnProcess.pressingConfig.amountRedApple + Config.OnProcess.pressingConfig.amountGreenApple + Config.OnProcess.pressingConfig.amountRottenApple
        local receivingItem = Config.OnProcess.pressingConfig.receiving
        
        if redApple.count < Config.OnProcess.pressingConfig.amountRedApple or greenApple.count < Config.OnProcess.pressingConfig.amountGreenApple or rottenApple.count < Config.OnProcess.pressingConfig.amountRottenApple then
            TriggerClientEvent('atu-ounatoo:notify', src, Config.Text["notifyTitle"], Config.Text["ErrorProcessingAmount"], 'error')
            return
        end
        
        if redApple.count >= Config.OnProcess.pressingConfig.amountRedApple and greenApple.count >= Config.OnProcess.pressingConfig.amountGreenApple and rottenApple.count >= Config.OnProcess.pressingConfig.amountRottenApple then
            xPlayer.removeInventoryItem('apple', Config.OnProcess.pressingConfig.amountRedApple)
            xPlayer.removeInventoryItem('green_apple', Config.OnProcess.pressingConfig.amountGreenApple)
            xPlayer.removeInventoryItem('rotten_apple', Config.OnProcess.pressingConfig.amountRottenApple)
            TriggerClientEvent('atu-ounatoo:notify', src,Config.Text["notifyTitle"], Config.Text["ApplesProcessed"], 'success')
            Wait(50)
            xPlayer.addInventoryItem('apple_juice', receivingItem)
        else
            TriggerClientEvent('atu-ounatoo:notify', src, Config.Text["notifyTitle"], Config.Text["ErrorProcessingAmount"], 'error')
            return
        end
    end)

    SellApples = {
        apple = math.random(Config.SellPrice.Rawapples.min, Config.SellPrice.Rawapples.max)
    }

    RegisterNetEvent('atu-oun:muukvms', function()

        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local price = 0
        for k, v in pairs(SellApples) do
            local apple = xPlayer.getInventoryItem(k)
            if apple and apple.count >= 1 then
                price = price + (v * apple.count)
                xPlayer.removeInventoryItem(k, apple.count)
            end
        end
        if price > 0 then
            xPlayer.addMoney(price)
            TriggerClientEvent('atu-ounatoo:notify', src, Config.Text["notifyTitle"], Config.Text["successfully_sold"], 'success')
        else
            TriggerClientEvent('atu-ounatoo:notify', src, Config.Text["notifyTitle"], Config.Text["NoItem"], 'error')
        end
    end)

    SellJuice = {
        apple_juice = math.random(Config.SellPrice.Juice.min, Config.SellPrice.Juice.max)
    }

    RegisterNetEvent('atu-applejob:muubmahavms', function()

        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local price = 0
        for k, v in pairs(SellJuice) do
            local applejuice = xPlayer.getInventoryItem(k)
            if applejuice and applejuice.count >= 1 then
                price = price + (v * applejuice.count)
                xPlayer.removeInventoryItem(k, applejuice.count)
            end
        end
        if price > 0 then
            xPlayer.addMoney(price)
           --TriggerClientEvent('esx:showNotification', src, Config.Text["successfully_sold1"], "success")
            TriggerClientEvent('atu-ounatoo:notify', src, Config.Text["notifyTitle"], Config.Text["successfully_sold1"], 'success')
        else
            --TriggerClientEvent('esx:showNotification', src, Config.Text["NoItem"], "error")
            TriggerClientEvent('atu-ounatoo:notify', src, Config.Text["notifyTitle"], Config.Text["NoItem"], 'error')
        end
    end)
end

if Config.Framework == "ESX" then
    LoadESXVersion()
end
