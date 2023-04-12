local awful   = require("awful")
local naughty = require("naughty")
local gears   = require("gears")
local wibox   = require("wibox")

local json    = require("modules/json")

local function factory(args)
    local args = args or {}

    local coins_to_test = args.coins or {"bitcoin"}
    local coins_to_show = args.coins_to_show or 1

    local coins = {
        coins    = coins_to_test,
        shorts   = args.shorts or {},
        widget   = args.widget or wibox.widget.textbox(),
        settings = args.settings or function(self) end,
        timeout  = args.timeout or 30,
        timer    = gears.timer,
        state    = "",
    }

    local url = "'https://api.coingecko.com/api/v3/simple/price?vs_currencies=usd&precision=3&ids="..table.concat(coins_to_test, ",").."'"
    -- naughty.notify({text="url:"..url})

    _, coins.timer = awful.widget.watch(
        {"bash", "-c", "curl -X GET -H 'accept: application/json' " .. url },
        coins.timeout,
        function(self, stdout, stderr, exitreason, exitcode)
            local prices = json.decode(stdout)
            if prices == nil then
                naughty.notify({text="req done: ?" ..
                    string.format("sderr: %s exreason: %s ecode: %d", stderr, exitreason, exitcode)
                })
                naughty.notify({text=stdout})
                return
            end
            local show = {}
            for i = 1, coins_to_show do
                local coin = self.coins[i]
                local price = prices[coin]["usd"]
                coin = coins.shorts[coin] or coin
                table.insert(show, string.format("%s: %s", coin, price))
            end

            self.widget:set_text(table.concat(show, " "))
        end,
        coins) -- argument for callback function as first parameter

    -- add mouse click
    coins.widget:connect_signal("button::press", function(c, _, _, button)
        naughty.notify({text="pressed"})
    end)
    return coins
end

return factory
