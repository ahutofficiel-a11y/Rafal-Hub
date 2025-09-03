-- LocalScript dans StarterPlayerScripts
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Teams = game:GetService("Teams")
local lockedTarget = nil

-- Fonction pour vérifier la ligne de vue (wall check)
local function canSee(target)
    local origin = camera.CFrame.Position
    local targetPos = target.Head.Position
    local ray = Ray.new(origin, (targetPos - origin))
    local hit = workspace:FindPartOnRay(ray, player.Character)
    if hit then
        return hit:IsDescendantOf(target)
    end
    return true
end

-- Fonction pour trouver l'ennemi le plus proche
local function getClosestTarget()
    local closest = nil
    local shortestDist = math.huge

    for _, character in pairs(workspace:GetChildren()) do
        if character:FindFirstChild("Humanoid") and character:FindFirstChild("Head") and character ~= player.Character then
            -- Team check
            if character:FindFirstChild("Team") and character.Team == player.Team then
                continue
            end

            local pos, onScreen = camera:WorldToViewportPoint(character.Head.Position)
            if onScreen and canSee(character) then
                local mouseDist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if mouseDist < shortestDist then
                    shortestDist = mouseDist
                    closest = character
                end
            end
        end
    end

    return closest
end

-- Boucle de visée
RunService.RenderStepped:Connect(function()
    if lockedTarget and lockedTarget:FindFirstChild("Head") then
        camera.CFrame = CFrame.new(camera.CFrame.Position, lockedTarget.Head.Position)
    end
end)

-- Activation / désactivation avec le clic droit
mouse.Button2Down:Connect(function() -- clic droit
    if lockedTarget then
        lockedTarget = nil
        print("Aimlock désactivé")
    else
        lockedTarget = getClosestTarget()
        if lockedTarget then
            print("Aimlock sur :", lockedTarget.Name)
        end
    end
end)
