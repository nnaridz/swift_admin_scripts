_G.driftActive = true -- ปรับเป็น false เพื่อปิดการใช้งานแล้วกด Execute อีกครั้ง

if _G.driftThread then
    print("Drift Mode Stopped")
    TerminateThread(_G.driftThread)
    _G.driftThread = nil
end

if _G.driftActive then
    _G.driftThread = CreateThread(function()
        print("Drift Mode Activated")
        while _G.driftActive do
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)
            if veh ~= 0 then
                if IsControlPressed(0, 21) then -- Shift
                    SetVehicleReduceGrip(veh, true)
                else
                    SetVehicleReduceGrip(veh, false)
                end
            end
            Wait(0)
        end
    end)
end