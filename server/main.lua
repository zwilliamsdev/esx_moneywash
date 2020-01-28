ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--  TODO: Log to discord bot
RegisterServerEvent('esx_moneywash:cleanMoney')
AddEventHandler('esx_moneywash:cleanMoney', function(target)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local dirtyMoney = xPlayer.getAccount("black_money")
    if dirtyMoney.money > 0 then
        local cash = xPlayer.getMoney()
        local cleanMoney = math.ceil(dirtyMoney.money - (dirtyMoney.money * Config.laundryTax))
        xPlayer.addMoney(cleanMoney)
        xPlayer.removeAccountMoney("black_money", dirtyMoney.money)
        TriggerClientEvent('esx:showNotification', _source, '~g~Exchanged ~r~$'..dirtyMoney.money..' dirty money ~g~for $'..cleanMoney..' cash.')
    else
        TriggerClientEvent('esx:showNotification', _source, '~r~Come back when you have something to wash.')
    end
end)
