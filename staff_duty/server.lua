--Made by Tazio


-- add_ace Adminrole taz.staff allow
-- add_principal identifier.steam:[hexid] Adminrole


-- If you only have one skin then set this to true
local oneskin = false

-- If you use Rolechat (Automated) then this is where you put your skins.
-- These uses the same ace's
local tmod_dutyskin = ""
local mod_dutyskin = ""
local admin_dutyskin = ""
local snr_dutyskin = ""
local management_dutyskin = ""
local owner_dutyskin = ""

-- If oneskin = true then they will all get this skin
local onskin_skin = ""

-- When they go off duty this is what there skin will be
local offdutyskin = ""


local staff = "taz.staff"

--------------------------------------- Editing stuff below this line will be at your own risk ---------------------------------------
local people = { }

RegisterCommand("staffduty",function(source, args)
  local name = GetPlayerName(source) -- Gets player name
  if IsPlayerAceAllowed(source, staff) and has_value(people, name) then
    TriggerClientEvent('chat:addMessage', -1, { args = { "^7[ ^3Staff Duty ^7] (^3 " .. name.." ^7)", " is now ^8OFF ^7duty" }, color = 255, 0, 0 })
    removeFirst(people, name) --Set table to remove the name
    ChangeToSkin(offdutyskin)
  elseif IsPlayerAceAllowed(source, staff) and not has_value(people, name) then
    TriggerClientEvent('chat:addMessage', -1, { args = { "^7[ ^3Staff Duty ^7] (^3 " .. name.." ^7)", " is now ^2ON ^7duty"}, color = 255, 0, 0 })
    table.insert(people, name)
    -- Giving the right skin to the person
    if not oneskin then
      if IsPlayerAceAllowed(source, "taz.owner") then
        ChangeToSkin(tmod_dutyskin)
      elseif IsPlayerAceAllowed(source, "taz.management") then
        ChangeToSkin(mod_dutyskin)
      elseif IsPlayerAceAllowed(source, "taz.snradmin") then
        ChangeToSkin(admin_dutyskin)
      elseif IsPlayerAceAllowed(source, "taz.admin") then
        ChangeToSkin(snr_dutyskin)
      elseif IsPlayerAceAllowed(source, "taz.mod") then
        ChangeToSkin(management_dutyskin)
      elseif IsPlayerAceAllowed(source, "taz.tmod") then
        ChangeToSkin(owner_dutyskin)
      end
    else
      ChangeToSkin(onskin_skin)
    end
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

function ChangeToSkin(skin)
    local model = GetHashKey(skin)
    RequestModel(model)
    while not HasModelLoaded(model) do -- Wait for model to load
      RequestModel(model)
      Citizen.Wait(0)
    end
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
end
