
local function loadAnimDict(dict)
    if HasAnimDictLoaded(dict) then return end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

CreateThread(function()
    for k, v in pairs(Config.Pawnshops) do
        blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
        SetBlipSprite(blip, 431)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, 5)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString('Pawnshop')
        EndTextCommandSetBlipName(blip)

        local current = v.ped

        RequestModel(current)
	    while not HasModelLoaded(current) do
	        Wait(0)
	    end
    
	    pawnPed = CreatePed(0, current, v.pedcoords.x, v.pedcoords.y, v.pedcoords.z, v.heading, false, false)
        loadAnimDict("anim@heists@heist_corona@team_idles@male_a")
        TaskPlayAnim(pawnPed, "anim@heists@heist_corona@team_idles@male_a", "idle", 2.0, 1.0, -1, 1, 0, 0, 0, 0 )       
        FreezeEntityPosition(pawnPed, true)
	    SetEntityInvincible(pawnPed, true)
	    SetBlockingOfNonTemporaryEvents(pawnPed, true)
    end
end)

CreateThread(function()
    for k, v in pairs(Config.Pawnshops) do
        exports.ox_target:addBoxZone({
            name = 'Pawnshop'..k,
            coords = vec3(v.pedcoords.x, v.pedcoords.y, v.pedcoords.z+0.98),
            size = vec3(v.length, v.width, 2.0),
            rotation = v.heading,
            debug = Config.Debug,
            distance = v.distance,
            options = {
                {
                    icon = 'fas fa-ring',
                    label = 'Open pawnshop',
                    event = 'esx_pawnshop:openShop',
                }
            }
        })
    end
end)