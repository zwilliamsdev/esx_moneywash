ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--  TODO: Log to discord bot
RegisterServerEvent('esx_moneywash:cleanMoney')
AddEventHandler('esx_moneywash:cleanMoney', function(target)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local cash = xPlayer.getMoney()
    local dirtyMoney = xPlayer.getAccount("black_money")
    local cleanMoney = math.ceil(dirtyMoney.money - (dirtyMoney.money * Config.laundryTax))
    xPlayer.addMoney(cleanMoney)
    xPlayer.removeAccountMoney("black_money", dirtyMoney.money)
end)
