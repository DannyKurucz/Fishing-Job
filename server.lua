if cfg.esxLegacy == false then
    ESX = nil
    TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
end

RegisterNetEvent('buy:rod')
AddEventHandler('buy:rod', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.canCarryItem(cfg.items['rod'], 1) then
        xPlayer.addInventoryItem(cfg.items['rod'], 1)
        xPlayer.removeMoney(cfg.shop['price'])
    else
        TriggerClientEvent('esx:showNotification', source, cfg.translation['limit'])

    end
end)

ESX.RegisterUsableItem(cfg.items['rod'], function(source)
	local _source = source
	TriggerClientEvent('fishing:start', _source)
end)

RegisterNetEvent('fish:fish')
AddEventHandler('fish:fish', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.canCarryItem(RandomItem(), RandomNumber()) then
        xPlayer.addInventoryItem(RandomItem(), RandomNumber())    
    end
end)

Items = {
  cfg.items['fish'],
  cfg.items['fish1'],
  cfg.items['fish2'],
}

function RandomItem()
  return Items[math.random(#Items)]
end

function RandomNumber()
	return math.random(1,2)
end

RegisterNetEvent('fish:break')
AddEventHandler('fish:break', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem(cfg.items['rod'], 1)
    
end)

local maxmoney = 1100

RegisterNetEvent("fish:sell")
AddEventHandler("fish:sell", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local money = 1000
    if xPlayer ~= nil then
        if money >= maxmoney then
            xPlayer.kick("Cheater")
        else
            local randomMoney = math.random(30,60)
            if xPlayer.getInventoryItem(cfg.items['fish']).count > 0 then
                xPlayer.addMoney(randomMoney)
                xPlayer.removeInventoryItem(cfg.items['fish'], 1)
            else
                TriggerClientEvent('esx:showNotification', source, cfg.translation['nofish'])

            end
            if xPlayer.getInventoryItem(cfg.items['fish1']).count > 0 then
                xPlayer.addMoney(randomMoney)
                xPlayer.removeInventoryItem(cfg.items['fish1'], 1)
            else
                TriggerClientEvent('esx:showNotification', source, cfg.translation['nofish'])

            end
            if xPlayer.getInventoryItem(cfg.items['fish2']).count > 0 then
                xPlayer.addMoney(randomMoney)
                xPlayer.removeInventoryItem(cfg.items['fish2'], 1)
            else
                TriggerClientEvent('esx:showNotification', source, cfg.translation['nofish'])

            end

        end
    end
end)

