local function AmountMenu(itemLabel, itemPrice, itemName)
    local options = {
        {
            title = 'Sell All',
            description = 'Sell all your items.',
            event = 'esx_pawnshop:client:sellAll',
            args = {
                item = itemName,
                price = itemPrice
            }
        },
        {
            title = 'Sell Specific Amount',
            description = 'Sell only some of your items.',
            event = 'esx_pawnshop:client:sellSome',
            args = {
                item = itemName,
                price = itemPrice
            }
        },
    }
    
    lib.registerContext({
        id = 'amount_menu',
        title = 'Sell '..  itemLabel,
        menu = 'sell_menu',
        options = options,
    })

    lib.showContext('amount_menu')
end

local function SellMenu()
    local options = {}

    for k, v in pairs(Config.ItemsBuy) do
        table.insert(options, {
            header = k,
            title = v.label .. ' ($' .. v.price .. ')',
            description = 'Sell item for $' .. v.price,
            icon = Config.ImagePath .. k .. '.png',
            onSelect = function()
                AmountMenu(v.label, v.price, k)
            end,
        })
    end

    lib.registerContext({
        id = 'sell_menu',
        title = 'Sell Items',
        menu = 'pawn_menu',
        options = options,
    })

    lib.showContext('sell_menu')
end

RegisterNetEvent('esx_pawnshop:openShop', function()
    lib.registerContext({
        id = 'pawn_menu',
        title = 'Pawn Shop',
        options = {
            {
                title = 'Buy Items',
                description = 'Buy items from the pawnshop',
                onSelect = function()
                    TriggerServerEvent('esx_pawnshop:registerShop')
                    exports.ox_inventory:openInventory('shop', { id = 1, type = 'Pawnshop' })
                end,
                icon = 'shopping-cart'
            },
            {
                title = 'Sell Items',
                description = 'Sell items to the pawnshop',
                onSelect = function()
                    SellMenu()
                end,
                icon = 'bars'
            },
        }
    })
    lib.showContext('pawn_menu')
end)

RegisterNetEvent('esx_pawnshop:client:sellAll', function(args)
    if exports.ox_inventory:GetItemCount(args.item) >= 1 then
        TriggerServerEvent('esx_pawnshop:sellAll', args.item, args.price)
    else
        lib.notify({title = 'You don\'t have any of this item', type = 'error', position = 'center-right'})
    end
end)

RegisterNetEvent('esx_pawnshop:client:sellSome', function(args)
    if exports.ox_inventory:GetItemCount(args.item) >= 1 then
        local input = lib.inputDialog('Sell Items', {{type = 'number', label = 'Sell Items', description = 'Ammount of items to sell', icon = 'hashtag', required = true, min = 0, }})
        if input ~= nil then
            TriggerServerEvent('esx_pawnshop:sellSome', args.item, args.price, input[1])
        else
            lib.showContext('sell_menu')
        end
    else
        lib.notify({title = 'You don\'t have any of this item', type = 'error', position = 'center-right'})
    end
end)