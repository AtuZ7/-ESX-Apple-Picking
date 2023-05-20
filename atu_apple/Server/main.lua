local function pGive(playerId, item, amount)
    local Player = ESX.GetPlayerFromId(playerId)
    if not Player then return end
    if type(item) == 'string' then
        Player.addInventoryItem(item, amount)
    elseif type(item) == 'table' and amount == 10000 then
        local itemString = ''
        if #item <= 0 then return TriggerClientEvent('ox_lib:notify', playerId, {title = Config.Text["notifyTitle"], description = Config.Text["DidntFind"], type = 'inform'}) end
        for _,i in pairs(item) do
            Player.addInventoryItem(i.item, i.amount)
            itemString = i.amount .. 'x ' .. ESX.GetItemLabel(i.item) .. ', ' .. itemString
        end
        if itemString ~= '' then
            TriggerClientEvent('ox_lib:notify', playerId, {title = Config.Text["notifyTitle"], description = Config.Text["PickedApples"], type = 'inform'})
        else
            TriggerClientEvent('ox_lib:notify', playerId, {title = Config.Text["notifyTitle"], description = Config.Text["DidntFind"], type = 'inform'})
        end
    end
end

RegisterNetEvent('atu-apple:start', function(args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if args == Config.TargetCoords.Pickup.args then
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
            return pGive(src, itemTable, 10000)
        else
            local lootChance = math.random(1,100)
            local item = Config.Apples[math.random(1, #Config.Apples)]
            if lootChance >= item.chances then
                return pGive(src, item.item, math.random(item.min, item.max))
            end
        end
    elseif args == Config.TargetCoords.Selling.args then
        local price = 0
        SellJuice = {apple_juice = math.random(Config.SellPrice.Juice.min, Config.SellPrice.Juice.max)}
        for k, v in pairs(SellJuice) do
            local applejuice = xPlayer.getInventoryItem(k)
            if applejuice and applejuice.count >= 1 then
                price = price + (v * applejuice.count)
                xPlayer.removeInventoryItem(k, applejuice.count)
            end
        end
        if price > 0 then
            xPlayer.addMoney(price)
            TriggerClientEvent('ox_lib:notify', src, {title = Config.Text["notifyTitle"], description = Config.Text["successfully_sold"], type = 'success'})
        else
            TriggerClientEvent('ox_lib:notify', src, {title = Config.Text["notifyTitle"], description = Config.Text["NoItem"], type = 'error'})
        end
    elseif args == Config.TargetCoords.Processing.args then
        local redApple = xPlayer.getInventoryItem('apple')
        local greenApple = xPlayer.getInventoryItem('green_apple')
        local rottenApple = xPlayer.getInventoryItem('rotten_apple')
        local receivingItem = Config.OnProcess.pressingConfig.receiving
        if redApple.count < Config.OnProcess.pressingConfig.amountRedApple or greenApple.count < Config.OnProcess.pressingConfig.amountGreenApple or rottenApple.count < Config.OnProcess.pressingConfig.amountRottenApple then
            TriggerClientEvent('ox_lib:notify', src, {title = Config.Text["notifyTitle"], description =Config.Text["ErrorProcessingAmount"], type = 'error'})
            return
        end
        if redApple.count >= Config.OnProcess.pressingConfig.amountRedApple and greenApple.count >= Config.OnProcess.pressingConfig.amountGreenApple and rottenApple.count >= Config.OnProcess.pressingConfig.amountRottenApple then
            xPlayer.removeInventoryItem('apple', Config.OnProcess.pressingConfig.amountRedApple)
            xPlayer.removeInventoryItem('green_apple', Config.OnProcess.pressingConfig.amountGreenApple)
            xPlayer.removeInventoryItem('rotten_apple', Config.OnProcess.pressingConfig.amountRottenApple)
            TriggerClientEvent('ox_lib:notify', src, {title = Config.Text["notifyTitle"], description = Config.Text["ApplesProcessed"], type = 'success'})
            Wait(50)
            xPlayer.addInventoryItem('apple_juice', receivingItem)
        else
            TriggerClientEvent('ox_lib:notify', src, {title = Config.Text["notifyTitle"], description = Config.Text["ErrorProcessingAmount"], type = 'error'})
            return
        end
    end
end)