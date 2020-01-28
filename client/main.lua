ESX = nil
local hasAlreadyEnteredMarker, lastZone
local currentAction, currentActionMsg, currentActionData = nil, nil, {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Show / Hide text
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())

        if Vdist2(playerCoords.x, playerCoords.y, playerCoords.z, Config.washLocation.x, Config.washLocation.y, Config.washLocation.z) <= Config.drawDistance then
            Draw3dText(Config.washLocation.x, Config.washLocation.y, Config.washLocation.z, "Press [E] to do laundry")
            if IsControlJustReleased(0, 38) then
                TriggerServerEvent('esx_moneywash:cleanMoney', PlayerPedId())
            end
        end
	end
end)

function Draw3dText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = Vdist2(p.z, p.y, p.z, x, y, z)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 150)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
