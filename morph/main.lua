-- Default Model: mp_m_freemode_01, mp_f_freemode_01
local morphModel = "a_c_chimp" -- https://docs.fivem.net/docs/game-references/ped-models/

local model = GetHashKey(morphModel)
RequestModel(model)
local start = GetGameTimer()
while not HasModelLoaded(model) and (GetGameTimer() - start) < 5000 do
    Wait(0)
end
if HasModelLoaded(model) then
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
end