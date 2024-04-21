RegisterNetEvent('esx_pawnshop:registerShop', function()
    exports.ox_inventory:RegisterShop('Pawnshop', {
        name = 'Pawnshop',
        inventory = Config.ItemsSold,
        locations = {
            vec3(-477.6, 278.55, 82.31),
            vec3(133.31, -1776.99, 28.75),
            vec3(1705.79, 3783.57, 33.73),
        },
    })
end)

RegisterNetEvent('esx_pawnshop:sellAll', function(item, price)
    local Player = ESX.GetPlayerFromId(source)
    local itemData = Player.getInventoryItem(item)
    if itemData ~= nil then
        Player.removeInventoryItem(item, itemData.count)
        Player.addAccountMoney('bank', itemData.count * price)
        TriggerClientEvent('ox_lib:notify', source, {title = 'Payment Successful', description = 'You received $'.. itemData.count * price .. ' to your bank account', type = 'success', icon = 'building-columns', position = 'center-right'})
    end
end)

RegisterNetEvent('esx_pawnshop:sellSome', function(item, price, amount)
    local Player = ESX.GetPlayerFromId(source)
    local itemData = Player.getInventoryItem(item)
    if itemData.count >= amount then
        Player.removeInventoryItem(item, itemData.count)
        Player.addAccountMoney('bank', itemData.count * price)
        TriggerClientEvent('ox_lib:notify', source, {title = 'Payment Successful', description = 'You received $'.. itemData.count * price .. ' to your bank account', type = 'success', icon = 'building-columns', position = 'center-right'})
    else
        TriggerClientEvent('ox_lib:notify', source, {title = 'You don\'t have that much of this item', type = 'error', position = 'center-right'})
    end
end)