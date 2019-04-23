-- Made by Tazio

-- add_ace Adminrole taz.staff allow
-- add_principal identifier.steam:[hexid] Adminrole
-- if discord is true then it will send clock in and out times through webhook

local Discord = true
local DISCORD_NAME = "Staff Duty"
local DISCORD_URL = "Your webhook"
local DISCORD_ICON = "" -- must end with .jpg or .png


local staff = "taz.staff"

-- Editing stuff below this line will be at your own risk
local people = { }

RegisterCommand("staffduty",function(source, args)
  local name = GetPlayerName(source) -- Gets player name
  if IsPlayerAceAllowed(source, staff) and has_value(people, name) then
    TriggerClientEvent('chat:addMessage', -1, { args = { "^7[ ^3Staff Duty ^7] (^3 " .. name.." ^7)", " is now ^8OFF ^7duty" }, color = 255, 0, 0 }) -- sends message in chat
    removeFirst(people, name) --Set table to remove the name
    sendToDiscord('Clock in', name .. "Clocked in as a staff member") -- send discord embed
  elseif IsPlayerAceAllowed(source, staff) and not has_value(people, name) then
    TriggerClientEvent('chat:addMessage', -1, { args = { "^7[ ^3Staff Duty ^7] (^3 " .. name.." ^7)", " is now ^2ON ^7duty"}, color = 255, 0, 0 })
    table.insert(people, name)
    sendToDiscord('Clock out', "**" .. name .. "** \nClocked out as a staff member")
  end
end, true)

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

function sendToDiscord(title, message)
  local connect = {
    ["color"] = "8663711", -- the side colo(u)r
    ["title"] = title, -- the title of the message
    ["description"] = message, -- what the message holds
    ["footer"] = {
      ["text"] = "Made by Tazio", -- give some love and leave it
      ["icon_url"] = DISCORD_ICON, -- the icon it shows
    },
    ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S') -- sets the timestamp
  }
  if message == nil or message == '' or DISCORD_URL == nil then return FALSE end
  if DISCORD_ICON == nil then DISCORD_ICON = "https://cdn.discordapp.com/avatars/174505110569877505/a_a74b859cf196517abe3eec5ff32164ae.jpg" end
  if DISCORD_NAME == nil then DISCORD_NAME = "Staff Duty" end
  PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect}), { ['Content-Type'] = 'application/json' })end
