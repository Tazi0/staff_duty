RegisterNetEvent('taz:applyskin')
AddEventHandler('taz:applyskin', function(skin)
    Citizen.CreateThread(function()
        local model = GetHashKey(skin)

        RequestModel(model)
        while not HasModelLoaded(model) do -- Wait for model to load
            RequestModel(model)
            Citizen.Wait(0)
        end

        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
    end)
end)
