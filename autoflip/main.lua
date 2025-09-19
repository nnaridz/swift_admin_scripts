_G.autoFlipActive = true -- ปรับเป็น false เพื่อปิดการใช้งานแล้วกด Execute อีกครั้ง

if _G.autoFlipThread then
    print("Autoflip Stopped")
    TerminateThread(_G.autoFlipThread)
    _G.autoFlipThread = nil
end

if _G.autoFlipActive then
    _G.autoFlipThread = Citizen.CreateThread(function()
        print("Autoflip Started")
        while _G.autoFlipActive do
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)
            if veh ~= 0 and IsEntityUpsidedown(veh) then
                SetEntityRotation(veh, 0.0, 0.0, GetEntityHeading(veh), 2, true)
            end
            Wait(1000)
        end
    end)
end