-- LocalScript dans StarterPlayerScripts
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local aimlockEnabled = false
local lockedTarget = nil

-- Fonction wall check moderne
local function canSee(target)
    local origin = camera.CFrame.Position
    local targetPos = target.Head.Position
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    rayParams.FilterDescendantsInstances = {player.Character}

    local result = workspace:Raycast(origin, targetPos - origin, rayParams)
    if result then
        return result.Instance:IsDescendantOf(target)
    else
        return true
    end
end

-- Trouver l'ennemi le plus proche
local function getClosestTarget()
    local closest = nil
    local shortestDist = math.huge

    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("Humanoid") and otherPlayer.Character:FindFirstChild("Head") then
            -- Ne pas lock les coéquipiers
            if player.Team and otherPlayer.Team == player.Team then
                continue
            end

            local headPos = otherPlayer.Character.Head.Position
            local screenPos, onScreen = camera:WorldToViewportPoint(headPos)
            if onScreen and canSee(otherPlayer.Character) then
                local mouseDist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                if mouseDist < shortestDist then
                    shortestDist = mouseDist
                    closest = otherPlayer.Character
                end
            end
        end
    end

    return closest
end

-- Activer aimlock quand clic droit est appuyé
mouse.Button2Down:Connect(function()
    aimlockEnabled = true
end)

-- Désactiver aimlock quand clic droit relâché
mouse.Button2Up:Connect(function()
    aimlockEnabled = false
    lockedTarget = nil
end)

-- Boucle de visée
RunService.RenderStepped:Connect(function()
    if aimlockEnabled then
        lockedTarget = getClosestTarget()
        if lockedTarget and lockedTarget:FindFirstChild("Head") then
            camera.CFrame = CFrame.new(camera.CFrame.Position, lockedTarget.Head.Position)
        end
    end
end)
