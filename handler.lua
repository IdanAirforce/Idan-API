SetHttpHandler(function(req, res)
    local path = req.path:sub(2)
    local ip = req.address:match("([^:]+)") or "unknown"
    local method = req.method

    if Config.Settings.Debug then
        print("[Idan-API Debug] Incoming request from " .. ip .. " to " .. path)
    end

    if method ~= "POST" then
        res.send("Method Not Allowed")
        return
    end

    req.setDataHandler(function(body)
        if not body or body == "" then
            res.send("Missing Body")
            return
        end

        local success, data = pcall(json.decode, body)
        if not success or type(data) ~= "table" then
            res.send("Invalid Body")
            return
        end

        if Config.Settings.Whitelist then
            local whitelist = Config.Whitelist[ip]
            if not whitelist then
                res.send("Unauthorized")
                return
            end

            if not Config.EndPoints[path] then
                res.send("Unknown Endpoint")
                return
            end

            if whitelist ~= "Full" then
                local allowed = false
                for _, allowedEndpoint in pairs(whitelist) do
                    if allowedEndpoint == path then
                        allowed = true
                        break
                    end
                end
                if not allowed then
                    res.send("Unauthorized")
                    return
                end
            end
        end

        if not Config.EndPoints[path] then
            res.send("Unknown Endpoint")
            return
        end

        if Config.Settings.Logs then
            local webhook = Config.Webhooks[path]
            if webhook then
                PerformHttpRequest(webhook, function() end, 'POST', json.encode({
                    username = "Idan-API Logger",
                    embeds = {{
                        title = "API Action: " .. path,
                        description = "```json\n" .. json.encode(data, { indent = true }) .. "\n```",
                        color = 16753920
                    }}
                }), { ['Content-Type'] = 'application/json' })
            end
        end

        Config.EndPoints[path](data)
        res.send("OK")
    end)
end)

CreateThread(function()

    while true do

        Wait(3000)

        for k,v in pairs(Config.EndPoints) do

            print('[Idan-API] EndPoint Registered: '..k)

        end

        break

    end

end)