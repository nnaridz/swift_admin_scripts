_G.moonwalkActive = true -- ปรับเป็น false เพื่อปิดการใช้งานแล้วกด Execute อีกครั้ง

if _G.moonwalkThread then
    print("Moonwalk Stopped")
    TerminateThread(_G.moonwalkThread)
    _G.moonwalkThread = nil
    Wait(100)
end

if _G.moonwalkActive then
    _G.moonwalkThread = Citizen.CreateThread(function()
        print("Moonwalk Activated")

        local toggleKey = 168 -- F7
        local enabled = true
        print("Moonwalk: ON (F7 to toggle)")

        local function getCamHeading()
            local rot = GetGameplayCamRot(2)
            return rot.z
        end

        while _G.moonwalkActive do
            if IsControlJustPressed(0, toggleKey) then
                enabled = not enabled
                print(("Moonwalk: %s"):format(enabled and "ON" or "OFF"))
            end

            if enabled then
                local ped = PlayerPedId()
                if ped ~= 0
                    and not IsEntityDead(ped)
                    and not IsPedInAnyVehicle(ped, false)
                    and not IsPedRagdoll(ped)
                    and not IsPedFalling(ped)
                    and not IsPedJumping(ped) then

                    SetEntityHeading(ped, getCamHeading())
                    local forward = GetEntityForwardVector(ped)
                    local vx, vy, vz = table.unpack(GetEntityVelocity(ped))
                    local speed = 2.2

                    local w = IsControlPressed(0, 32) -- INPUT_MOVE_UP_ONLY (W)
                    local s = IsControlPressed(0, 33) -- INPUT_MOVE_DOWN_ONLY (S)

                    if w then
                        DisableControlAction(0, 32, true)
                        SetEntityVelocity(ped, -forward.x * speed, -forward.y * speed, vz)
                    elseif s then
                        DisableControlAction(0, 33, true)
                        SetEntityVelocity(ped, forward.x * speed, forward.y * speed, vz)
                    end
                end
            end

            Wait(0)
        end
    end)
end

