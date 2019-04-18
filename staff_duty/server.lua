--Made by Tazio


-- add_ace Adminrole taz.staff allow
-- add_principal identifier.steam:[hexid] Adminrole

list = Set {}

staff = "taz.staff"

-- Editing stuff below this line will be at your own risk

RegisterCommand("staffduty",function(source, args)
  local name = GetPlayerName(source) -- Gets player name
  if IsPlayerAceAllowed(source, staff) and list[name] then
    TriggerClientEvent('chat:addMessage', -1, { args = { "^7[ ^3Staff Duty ^7] (^3 " .. name.." ^7)", " is now ^8OFF ^7duty" }, color = 255, 0, 0 })
    table.remove(list, name) --Set table to remove the name
  elseif IsPlayerAceAllowed(source, staff) and not list[name] then
    TriggerClientEvent('chat:addMessage', -1, { args = { "^7[ ^3Staff Duty ^7] (^3 " .. name.." ^7)", " is now ^2ON ^7duty"}, color = 255, 0, 0 })
    table.insert(list, name)
  end
end, true)

function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end
