--Made by Tazio


-- add_ace Adminrole taz.staff allow
-- add_principal identifier.steam:[hexid] Adminrole

local people = { }

local staff = "taz.staff"

-- Editing stuff below this line will be at your own risk

RegisterCommand("staffduty",function(source, args)
  local name = GetPlayerName(source) -- Gets player name
  if IsPlayerAceAllowed(source, staff) and has_value(people, name) then
    TriggerClientEvent('chat:addMessage', -1, { args = { " ^7[ ^3Staff Duty ^7] (^3 " .. name.." ^7)", " is now ^8OFF ^7duty" }, color = 255, 0, 0 })
    removeFirst(people, name) --Set table to remove the name
  elseif IsPlayerAceAllowed(source, staff) and not has_value(people, name) then
    TriggerClientEvent('chat:addMessage', -1, { args = { " ^7[ ^3Staff Duty ^7] (^3 " .. name.." ^7)", " is now ^2ON ^7duty"}, color = 255, 0, 0 })
    table.insert(people, name)
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
