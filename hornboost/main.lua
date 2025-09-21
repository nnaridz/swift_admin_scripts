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

        while _G.hornBoostActive do
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)

            if veh ~= 0 and IsPedInAnyVehicle(ped, false) then
                -- Check if horn is being pressed
                if IsControlPressed(0, 86) then -- 86 = INPUT_VEH_HORN (E)
                    local currentSpeed = GetEntitySpeed(veh)
                    local boostSpeed = currentSpeed + 5.0

                    -- Force boost effect
                    SetVehicleBoostActive(veh, true)
                    ModifyVehicleTopSpeed(veh, 50.0) -- allow higher top speed temporarily
                    SetVehicleCheatPowerIncrease(veh, 5.0) -- multiplier for acceleration
                    SetVehicleForwardSpeed(veh, boostSpeed)
                else
                    -- Reset when horn not pressed
                    SetVehicleBoostActive(veh, false)
                    ModifyVehicleTopSpeed(veh, 0.0)
                    SetVehicleCheatPowerIncrease(veh, 0.0)
                end
            end

            Wait(0)
        end
    end)
end