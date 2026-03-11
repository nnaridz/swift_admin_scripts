_G.hornBoostActive = true -- ปรับเป็น false เพื่อปิดการใช้งานแล้วกด Execute อีกครั้ง

if _G.hornBoostThread then
    print("Horn Boost Stopped")
    TerminateThread(_G.hornBoostThread)
    _G.hornBoostThread = nil
    Wait(100)
end

if _G.hornBoostActive then
    _G.hornBoostThread = Citizen.CreateThread(function()
        print("Horn Boost Activated")

        local function normalizeTopSpeedModifier(mod)
            if mod == nil or mod < 0.0 then
                return 1.0
            end
            return mod
        end

        local function resetVehicleMods(veh, originalTopSpeedMod)
            if veh == 0 or veh == nil then
                return
            end

            SetVehicleBoostActive(veh, false)
            ModifyVehicleTopSpeed(veh, normalizeTopSpeedModifier(originalTopSpeedMod))
            SetVehicleCheatPowerIncrease(veh, 0.0)
        end

        local lastVeh = 0
        local lastVehTopSpeedMod = 1.0
        local boosting = false

        while _G.hornBoostActive do
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)

            if veh ~= lastVeh then
                if lastVeh ~= 0 then
                    resetVehicleMods(lastVeh, lastVehTopSpeedMod)
                end

                lastVeh = veh
                lastVehTopSpeedMod = (veh ~= 0) and GetVehicleTopSpeedModifier(veh) or 1.0
                boosting = false
            end

            local isDriver = veh ~= 0 and GetPedInVehicleSeat(veh, -1) == ped

            if veh ~= 0 and IsPedInAnyVehicle(ped, false) and isDriver then
                local hornPressed = IsControlPressed(0, 86) -- 86 = INPUT_VEH_HORN

                if hornPressed then
                    local currentSpeed = GetEntitySpeed(veh)
                    local boostSpeed = currentSpeed + 5.0

                    SetVehicleBoostActive(veh, true)
                    ModifyVehicleTopSpeed(veh, 50.0)
                    SetVehicleCheatPowerIncrease(veh, 5.0)
                    SetVehicleForwardSpeed(veh, boostSpeed)

                    boosting = true
                elseif boosting then
                    resetVehicleMods(veh, lastVehTopSpeedMod)
                    boosting = false
                end
            elseif veh == 0 and lastVeh ~= 0 and boosting then
                resetVehicleMods(lastVeh, lastVehTopSpeedMod)
                boosting = false
            end

            Wait(0)
        end

        if lastVeh ~= 0 then
            resetVehicleMods(lastVeh, lastVehTopSpeedMod)
        end
    end)
end
