local morphModel = "s_m_y_cop_01" -- Change this to the model you want to morph to
local model = GetHashKey(modelName)
RequestModel(model)
while not HasModelLoaded(model) do
    Wait(0)
end
SetPlayerModel(PlayerId(), model)
SetModelAsNoLongerNeeded(model)