local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local PlayerGui = localPlayer:WaitForChild("PlayerGui")

local ESPEnabled = false
local ESPConnections = {}
local ESPFolders = {}

-- UI (bouton ESP stylisé)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ESP_UI"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 100, 0, 40)
button.Position = UDim2.new(0.5, -50, 1, -70)
button.Text = "ESP"
button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.TextSize = 20
button.AutoButtonColor = true
button.Parent = screenGui

-- arrondir le bouton
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = button

-- petite ombre
local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0, 200, 0)
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = button

-- Couleur selon la team
local function getTeamColor(player)
    if player.Team and localPlayer.Team then
        if player.Team == localPlayer.Team then
            return Color3.fromRGB(0, 150, 255) -- bleu allié
        else
            return Color3.fromRGB(255, 80, 80) -- rouge ennemi
        end
    end
    return Color3.fromRGB(80, 255, 80) -- vert par défaut
end

-- Créer ESP
local function createESP(player)
    if player == localPlayer or not player.Character then return end

    local espFolder = Instance.new("Folder")
    espFolder.Name = "ESP_" .. player.Name
    espFolder.Parent = player.Character
    ESPFolders[player] = espFolder

    -- Pseudo au-dessus
    local billboardName = Instance.new("BillboardGui")
    billboardName.Size = UDim2.new(0, 200, 0, 40)
    billboardName.AlwaysOnTop = true
    billboardName.StudsOffset = Vector3.new(0, 3, 0)
    billboardName.Parent = espFolder

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextScaled = true
    nameLabel.Parent = billboardName

    -- Distance en-dessous
    local billboardDist = Instance.new("BillboardGui")
    billboardDist.Size = UDim2.new(0, 200, 0, 30)
    billboardDist.AlwaysOnTop = true
    billboardDist.StudsOffset = Vector3.new(0, -2, 0)
    billboardDist.Parent = espFolder

    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 1, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.TextStrokeTransparency = 0
    distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    distLabel.Font = Enum.Font.GothamSemibold
    distLabel.TextScaled = true
    distLabel.Parent = billboardDist

    -- Box fine et transparente
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ESPBox"
    box.Transparency = 0.8
    box.AlwaysOnTop = true
    box.ZIndex = 0
    box.Adornee = player.Character
    box.Parent = espFolder

    -- Ligne discrète
    local attachmentLocal = Instance.new("Attachment")
    attachmentLocal.Parent = localPlayer.Character:WaitForChild("HumanoidRootPart")

    local attachmentTarget = Instance.new("Attachment")
    attachmentTarget.Parent = player.Character:WaitForChild("HumanoidRootPart")

    local beam = Instance.new("Beam")
    beam.Attachment0 = attachmentLocal
    beam.Attachment1 = attachmentTarget
    beam.Transparency = NumberSequence.new(0.3) -- un peu transparent
    beam.Width0 = 0.03
    beam.Width1 = 0.03
    beam.FaceCamera = true
    beam.Parent = espFolder

    -- Mise à jour dynamique
    ESPConnections[player] = RunService.RenderStepped:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (localPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude

            local cf, size = player.Character:GetBoundingBox()
            box.CFrame = cf
            box.Size = size + Vector3.new(0.5, 0.5, 0.5) -- marge légère

            local teamColor = getTeamColor(player)
            nameLabel.Text = player.Name
            nameLabel.TextColor3 = teamColor

            distLabel.Text = "[" .. math.floor(distance) .. "m]"
            distLabel.TextColor3 = teamColor

            box.Color3 = teamColor
            beam.Color = ColorSequence.new(teamColor)
        end
    end)
end

-- Supprimer ESP
local function removeESP(player)
    if ESPConnections[player] then
        ESPConnections[player]:Disconnect()
        ESPConnections[player] = nil
    end
    if ESPFolders[player] then
        ESPFolders[player]:Destroy()
        ESPFolders[player] = nil
    end
end

-- Active ESP
local function enableESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            if player.Character then
                createESP(player)
            end
            player.CharacterAdded:Connect(function()
                if ESPEnabled then
                    task.wait(1)
                    createESP(player)
                end
            end)
        end
    end
end

-- Désactive ESP
local function disableESP()
    for player, _ in pairs(ESPFolders) do
        removeESP(player)
    end
end

-- Toggle bouton
button.MouseButton1Click:Connect(function()
    ESPEnabled = not ESPEnabled
    if ESPEnabled then
        enableESP()
        button.BackgroundColor3 = Color3.fromRGB(30, 120, 30)
        stroke.Color = Color3.fromRGB(0, 255, 0)
    else
        disableESP()
        button.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
        stroke.Color = Color3.fromRGB(255, 0, 0)
    end
end)
