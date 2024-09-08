Config = {}

Config.Speedometer = "mph" -- kmh or mph
Config.KeyMapping = true
Config.CruiseControlKey = "J"

Config.Locale = {
    ["SETCRUISE"] = {
        text = 'Enabling Cruise',
        time = 5000,
        type = "info"
    },
    ["DISABLECRUISE"] = {
        text = 'Disabling Cruise',
        time = 5000,
        type = "success"
    }
}

Config.ClientNotification = function(msg, time, type)
    if Config.Framework == "newesx" or Config.Framework == "oldesx" then
        TriggerEvent("esx:showNotification", msg, type)
    else
        TriggerEvent("QBCore:Notify", msg, type)
    end
end

Config.ServerNotification = function(src, msg, time, type)
    if Config.Framework == "newesx" or Config.Framework == "oldesx" then
        TriggerClientEvent("esx:showNotification",src, msg, type)
    else
        TriggerClientEvent("QBCore:Notify",src, msg, type)
    end
end