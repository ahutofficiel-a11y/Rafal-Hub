local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local plr = Players.LocalPlayer
local sc = nil
local clip = false

local button = script.Parent -- ton bouton

button.MouseButton1Click:Connect(function()
    clip = not clip
    if clip then
        sc = RunService.Stepped:Connect(function()
            for _, part in pairs(workspace[plr.Name]:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    else
        if sc then
            sc:Disconnect()
            sc = nil
        end
    end
end)
