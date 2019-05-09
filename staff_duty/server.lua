-- Made by Tazio

-- add_ace Adminrole taz.staff allow
-- add_principal identifier.steam:[hexid] Adminrole
-- if discord is true then it will send clock in and out times through webhook

local DISCORD_NAME = "Staff Duty"
local DISCORD_URL = ""
local DISCORD_IMAGE = "https://pbs.twimg.com/profile_images/847824193899167744/J1Teh4Di_400x400.jpg" -- must end with .jpg or .png


local staff = "taz.staff"

-- Editing stuff below this line will be at your own risk
local people = { }

RegisterCommand("staffduty",function(source, args)
  local name = GetPlayerName(source) -- Gets player name

  if IsPlayerAceAllowed(source, staff) and has_value(people, name) then
    TriggerClientEvent('chat:addMessage', -1, { args = { "^7[ ^3Staff Duty ^7] (^3 " .. name.." ^7)", " is now ^8OFF ^7duty" }, color = 255, 0, 0 }) -- Sends message in chat
    removeFirst(people, name) -- Set table to remove the name
    sendToDiscord(name, "is now **OFF** duty") -- Sends message to discord

  elseif IsPlayerAceAllowed(source, staff) and not has_value(people, name) then
    TriggerClientEvent('chat:addMessage', -1, { args = { "^7[ ^3Staff Duty ^7] (^3 " .. name.." ^7)", " is now ^2ON ^7duty"}, color = 255, 0, 0 })
    table.insert(people, name)
    sendToDiscord(name, "is now **ON** duty")
  end
end, true)

AddEventHandler('playerDropped', function(reason) 
  name = GetPlayerName(source)
  if has_value(people, name) then
    TriggerClientEvent('chat:addMessage', -1, { args = { "^7[ ^3Staff Duty ^7] (^3 " .. name.." ^7)", " is now ^8OFF ^7duty" }, color = 255, 0, 0 }) -- Sends message in chat
    removeFirst(people, name) -- Set table to remove the name
    sendToDiscord(name, "is now **OFF** duty") -- Sends message to discord
  end
end)

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function removeFirst(tbl, val)
  for i, v in ipairs(tbl) do
    if v == val then
      return table.remove(tbl, i)
    end
  end
end

function sendToDiscord(name, message)
  local date = os.date('*t')
  local connect = {
        {
            ["color"] = "8663711",
            ["title"] = "**" .. name .. "**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Made by Tazio " .. date.hour .. ':' .. date.min .. ':' .. date.sec,
            },
        }
    }
  PerformHttpRequest(DISCORD_URL, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end
