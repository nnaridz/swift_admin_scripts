_G.rainbowActive = true -- ปรับเป็น false เพื่อปิดการใช้งานแล้วกด Execute อีกครั้ง

if _G.rainbowThread then
    print("Rainbow Vehicle Stopped")
    TerminateThread(_G.rainbowThread)
    _G.rainbowThread = nil
end

if _G.rainbowActive then
    _G.rainbowThread = CreateThread(function()
        print("Rainbow Vehicle Activated")

        local r, g, b = 255, 0, 0
        local step = 2
        while _G.rainbowActive do
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            if veh ~= 0 then
                SetVehicleCustomPrimaryColour(veh, r, g, b)
                SetVehicleCustomSecondaryColour(veh, r, g, b)
            end

            if r > 0 and b == 0 then
                r = r - step
                g = g + step
            elseif g > 0 and r == 0 then
                g = g - step
                b = b + step
            elseif b > 0 and g == 0 then
                b = b - step
                r = r + step
            end

            Wait(100)
        end
    end)
end