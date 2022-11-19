QBCore = exports['qb-core']:GetCoreObject()
PlayerJob = {}
onDuty = false

----------------
-- DrawText3D --
----------------

local function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

----------
-- Blip --
----------

CreateThread(function()
	for _, info in pairs(Config.BlipLocation) do
		if Config.UseBlips then
			info.blip = AddBlipForCoord(info.x, info.y, info.z)
			SetBlipSprite(info.blip, info.id)
			SetBlipDisplay(info.blip, 4)
			SetBlipScale(info.blip, 0.7)	
			SetBlipColour(info.blip, info.colour)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(info.title)
			EndTextCommandSetBlipName(info.blip)
		end
	end	
end)

--------------
-- Handlers --
--------------

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == "reporter" then
                TriggerServerEvent("QBCore:ToggleDuty")
            end
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
    if PlayerJob.name == "nudler" then
    end
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

RegisterNetEvent("nudler:Duty", function()
    onDuty = not onDuty
    TriggerServerEvent("QBCore:ToggleDuty")
end)

RegisterNetEvent("nudler:shop", function()
    if not onDuty then TriggerEvent('QBCore:Notify', "Ikke på vakt!", 'error') else
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "reporter", {
            label = "Lager",
            items = Config.Items,
            slots = #Config.Items,
        })
    end
end)

CreateThread(function()
    for k, v in pairs(Config.Locations["duty"]) do
        exports['qb-target']:AddBoxZone("Duty_"..k, vector3(v.x, v.y, v.z), 1, 1, {
            name = "Duty_"..k,
            heading = 32,
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        }, {
            options = {
                {  
                    type = "client",
                    event = "nudler:Duty",
                    icon = "far fa-clipboard",
                    label = "På/Av Vakt",
                    job = "nudler",
                },
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for k, v in pairs(Config.Locations["shop"]) do
        exports['qb-target']:AddBoxZone("NewsArmory_"..k, vector3(v.x, v.y, v.z), 1, 1, {
            name = "NewsArmory_"..k,
            heading = 32,
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        }, {
            options = {
                {  
                    type = "client",
                    event = "nudler:shop",
                    icon = "fas fa-basket-shopping",
                    label = "Åpne Lager",
                    job = "nudler",
                },
            },
            distance = 1.5
        })
    end
end)
