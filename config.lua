Config = {}

Config.Settings = {
    Whitelist = true,
    Debug = false,
    Logs = true, -- Webhooks
}

-- Permissions = Full Permission (Everything) / Specific Endpoints
Config.Whitelist = {
    ['191.96.229.18'] = {'Kick'}, -- This IP can only use "Kick"
    ['127.0.0.1'] = 'Full' -- This IP has full access
}

Config.EndPoints = {
    ['Kick'] = function(data)
        if data.id then
            local reason = data.reason or 'No Reason Sent                   '
            DropPlayer(data.id, reason)
        end
    end,

    ['Announce'] = function(data)
        if data.message then
            TriggerClientEvent('chat:addMessage', -1, {
                args = {"[Idan-API]", data.message}
            })
        end
    end
}

Config.Webhooks = {
    ['Kick'] = 'https://discord.com/api/webhooks/1366168920196780082/AGdBzHURCzb58I9R3N2gAFQW6j_y9oIxDYUbZEwsEOIXbGiRt_jXfdNEAeSE64Gr6K9K',
    ['Announce'] = 'https://discord.com/api/webhooks/1366168920196780082/AGdBzHURCzb58I9R3N2gAFQW6j_y9oIxDYUbZEwsEOIXbGiRt_jXfdNEAeSE64Gr6K9K',
}