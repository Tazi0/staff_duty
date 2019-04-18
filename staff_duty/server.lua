--Made by Tazio


-- add_ace Adminrole taz.staff allow
-- add_principal identifier.steam:[hexid] Adminrole

staff = "taz.staff"

-- Editing stuff below this line will be at your own risk

RegisterCommand("staffduty",function(source, args)
  if IsPlayerAceAllowed(source, staff) and OnDuty then
    local name = GetPlayerName(source) -- Gets player name
    TriggerClientEvent('chat:addMessage', -1, { args = { "^7[ ^3Staff Duty ^7] (^3 " .. name.." ^7)", " is now ^8OFF ^7duty" }, color = 255, 0, 0 })
    OnDuty = false --Set onduty to false
  elseif IsPlayerAceAllowed(source, staff) and not OnDuty then
    local name = GetPlayerName(source)
    TriggerClientEvent('chat:addMessage', -1, { args = { "^7[ ^3Staff Duty ^7] (^3 " .. name.." ^7)", " is now ^2ON ^7duty"}, color = 255, 0, 0 })
    OnDuty = true
  end
end, true)
