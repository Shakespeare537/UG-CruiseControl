cruise = false
cruiseSpeedKM = false
cruiseSpeedMPH = false

if Config.Speedometer == "mph" then
    speed = 2.237
else
    speed = 3.6
end

if Config.KeyMapping then
    local ped = PlayerPedId()
    Citizen.CreateThread(function()
        while true do
            if not GetVehiclePedIsIn(ped, false) and cruise then
                cruise = false
            end
            Wait(1700)
        end
    end)
    RegisterKeyMapping('cruise', 'Cruise Control', 'keyboard', Config.CruiseControlKey)
    RegisterCommand("cruise", function()
        if GetVehiclePedIsIn(ped, false) then
            ToggleCruise()
        end
    end)
end


function ToggleCruise()
    local ped = PlayerPedId() -- Ped
    local inVehicle = IsPedSittingInAnyVehicle(ped) -- Get if ped is in any vehicle
    local vehicle = GetVehiclePedIsIn(ped, false) -- Get Vehicle In
    local cruiseSpeed = GetEntitySpeed(vehicle)
    cruise = not cruise
    cruiseSpeedKM = math.floor(cruiseSpeed * speed)
    cruiseSpeedMPH = math.floor(cruiseSpeed * speed)

    Wait(250)
    if cruise then
        Config.ClientNotification(Config.Locale["SETCRUISE"].text,Config.Locale["SETCRUISE"].time ,Config.Locale["SETCRUISE"].type)
    else
        Config.ClientNotification(Config.Locale["DISABLECRUISE"].text, Config.Locale["DISABLECRUISE"].time ,Config.Locale["DISABLECRUISE"].type)
    end
    Citizen.CreateThread(function()    
        while cruise do
            if IsVehicleOnAllWheels(vehicle) and GetEntitySpeed(vehicle) > (cruiseSpeed - 2.0) and not HasEntityCollidedWithAnything(vehicle) then
                SetVehicleForwardSpeed(vehicle, cruiseSpeed)
            else
                cruise = false
            end
            Wait(350)
        end
    end)
end