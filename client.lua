

if cfg.esxLegacy == false then
    ESX = nil -- ESX 
    CreateThread(function()
	    while ESX == nil do
	    	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		    Wait(0)
	    end
    end)
end

RegisterNetEvent('esx:playerLoaded') -- toto načte postavu prostě základ
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local blip = nil
local blip1 = nil
local blip2 = nil
local sell = nil
local buy = true
local isMenuOpen = false
local fishing = false
local rent = true
local boat = true
local sellfish = true
local nastaveni = {
	{label = cfg.translation['rodname'], value = 'rod'}, 
}

CreateThread(function()
	while true do
        Citizen.Wait(0)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == cfg.job['job'] then
            if blip == nil then
                blip = AddBlipForCoord(cfg.blip['blip'])
                AddTextEntry('MYBLIP', cfg.translation['jobblip'])
                SetBlipSprite(blip, 88)
                SetBlipColour(blip, 2)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, 1.0)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName('MYBLIP')
                EndTextCommandSetBlipName(blip)
            end
            if blip1 == nil then
                blip1 = AddBlipForCoord(cfg.blip['blipfishing'])
                AddTextEntry('MYBLIP', cfg.translation['blipfishing'])
                SetBlipSprite(blip1, 88)
                SetBlipColour(blip1, 2)
                SetBlipDisplay(blip1, 4)
                SetBlipScale(blip1, 1.0)
                SetBlipAsShortRange(blip1, true)
                BeginTextCommandSetBlipName('MYBLIP')
                EndTextCommandSetBlipName(blip1)
            end
            if blip2 == nil then
                blip2 = AddBlipForCoord(cfg.blip['boatrent'])
                AddTextEntry('MYBLIP', cfg.translation['boat'])
                SetBlipSprite(blip2, 410)
                SetBlipColour(blip2, 2)
                SetBlipDisplay(blip2, 4)
                SetBlipScale(blip2, 1.0)
                SetBlipAsShortRange(blip2, true)
                BeginTextCommandSetBlipName('MYBLIP')
                EndTextCommandSetBlipName(blip2)
            end
            if sell == nil then
                sell = AddBlipForCoord(cfg.blip['sell'])
                AddTextEntry('blip', cfg.translation['sell'])
                SetBlipSprite(sell, 293)
                SetBlipColour(sell, 2)
                SetBlipDisplay(sell, 4)
                SetBlipScale(sell, 1.0)
                SetBlipAsShortRange(sell, true)
                BeginTextCommandSetBlipName('blip')
                EndTextCommandSetBlipName(sell)
            end

        else
            if blip ~= nil then
                RemoveBlip(blip)
                blip = nil
            end
            if blip1 ~= nil then
                RemoveBlip(blip1)
                blip1 = nil
            end
            if blip2 ~= nil then
                RemoveBlip(blip2)
                blip2 = nil
            end
            if sell ~= nil then
                RemoveBlip(sell)
                sell = nil
            end

        end
    
    
    end
end)

CreateThread(function()
	while true do
        cas = 1000
		local playerPed = PlayerPedId()
        local Coords = GetEntityCoords(PlayerPedId())
        local pos = (cfg.marker['buy'])
		local dist = #(Coords - pos)
        if dist < 10 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == cfg.job['job'] then
                if buy then
                    buy = true
                    if buy == true then
                        cas = 5
                        ShowFloatingHelpNotification(cfg.translation['buy'], pos)
                        if IsControlJustPressed(0, 38) and dist < 1 then
                            buy = true
                            shop()
                        end
                    end
                end
            end
        end
        Wait(cas)
	end
end)
CreateThread(function()
	while true do
        cas = 1000
		local playerPed = PlayerPedId()
        local Coords = GetEntityCoords(PlayerPedId())
        local pos = (cfg.marker['sell'])
		local dist = #(Coords - pos)
        if dist < 5 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == cfg.job['job'] then
                if sellfish then
                    sellfish = true
                    if sellfish == true then
                        cas = 5
                        ShowFloatingHelpNotification(cfg.translation['sellfish'], pos)
                        if IsControlJustPressed(0, 38) and dist < 1 then
                            sellfish = true
                            TriggerServerEvent('fish:sell')
                            Wait(250)
                        end
                    end
                end
            end
        end
        Wait(cas)
	end
end)

CreateThread(function()
	while true do
        cas = 1000
		local playerPed = PlayerPedId()
        local Coords = GetEntityCoords(PlayerPedId())
        local pos = (cfg.marker['rentboat'])
		local dist = #(Coords - pos)
        if dist < 5 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == cfg.job['job'] then
                if rent then
                    rent = true
                    if rent == true then
                        cas = 5
                        ShowFloatingHelpNotification(cfg.translation['rentboat'], pos)
                        if IsControlJustPressed(0, 38) and dist < 1 then
                            rent = true
                            SpawnBoat()
                        end
                    end
                end
            end
        end
        Wait(cas)
	end
end)



shop = function()
	isMenuOpen = true

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "shop", {
        title = "Shop", 
        align = "top", 
        elements = nastaveni  
    }, function(data, menu) 
        if data.current.value == 'rod' then
            TriggerServerEvent('buy:rod')
            menu.close()
            isMenuOpen = false
		end
    end,function(data, menu)
        menu.close()
        isMenuOpen = false
    end)


end


RegisterNetEvent('fishing:start')
AddEventHandler('fishing:start', function()
	playerPed = GetPlayerPed(-1)
	local pos = GetEntityCoords(GetPlayerPed(-1))
	if IsPedInAnyVehicle(playerPed) then
		ESX.ShowNotification(cfg.translation['cannotfish'])
	else
		if pos.y >= 7700 or pos.y <= -4000 or pos.x <= -3700 or pos.x >= 4300 then
			ESX.ShowNotification(cfg.translation['startedfish'])
			TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true)
            exports.rprogress:MiniGame({
                Difficulty = "Easy",
                Timeout = 5000, 
                onComplete = function(success)
                        if success then
                            TriggerServerEvent("fish:fish")
                            ClearPedTasks(playerPed)
                        else
                            local breakChance = math.random(1,100)
                            if breakChance < cfg.breakrodchance['chance'] then
                                Notify(cfg.translation['rodbroke'])
                                TriggerServerEvent("fish:break")  
                                fishing = false
                            end
                            ClearPedTasks(playerPed)  
                        end    
                end,
            })
			fishing = true
		else
			ESX.ShowNotification(cfg.translation['awayfromshore'])
		end
	end
	
end, false)

SpawnBoat = function()
    local vehiclehash = GetHashKey("Dinghy")
    RequestModel(vehiclehash)
    while not HasModelLoaded(vehiclehash) do
        RequestModel(vehiclehash)
        Wait(0)
    end
    boat = CreateVehicle(vehiclehash, cfg.marker['boatspawn'], 0.0, true, false)
    SetEntityAsMissionEntity(boat, true, true)
    TaskWarpPedIntoVehicle(PlayerPedId(), boat, -1)
end

returnboat = function()
    if (GetVehiclePedIsIn(PlayerPedId(), false) == boat) then
        DeleteVehicle(boat)
    else
        Notify(cfg.translation['returnBoat'])
    end
end

ShowFloatingHelpNotification = function(msg, pos)
    AddTextEntry('hs', msg)
    SetFloatingHelpTextWorldPosition(1, pos.x, pos.y, pos.z)
    SetFloatingHelpTextStyle(2, 1, 25, -1, 3, 0)
    BeginTextCommandDisplayHelp('hs')
    EndTextCommandDisplayHelp(2, false, false, -1)
end


