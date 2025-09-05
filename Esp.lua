local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local PlayerGui = localPlayer:WaitForChild("PlayerGui")

local ESPEnabled = false
local ESPConnections = {}
local ESPFolders = {}

-- UI (bouton ESP)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ESP_UI"
screenGui.Parent = PlayerGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 120, 0, 40)
button.Position = UDim2.new(0.5, -60, 1, -60)
button.Text = "ESP"
button.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 22
button.Parent = screenGui

-- Couleur selon la team
local function getTeamColor(player)
    if player.Team and localPlayer.Team then
        if player.Team == localPlayer.Team then
            return Color3.fromRGB(0, 150, 255) -- bleu allié
        else
            return Color3.fromRGB(255, 0, 0) -- rouge ennemi
        end
    end
    return Color3.fromRGB(0, 255, 0) -- vert par défaut
end

-- Créer ESP pour un joueur
local function createESP(player)
    if player == localPlayer or not player.Character then return end

    local espFolder = Instance.new("Folder")
    espFolder.Name = "ESP_" .. player.Name
    espFolder.Parent = player.Character
    ESPFolders[player] = espFolder

    -- Billboard du pseudo (au-dessus)
    local billboardName = Instance.new("BillboardGui")
    billboardName.Name = "NameBillboard"
    billboardName.Size = UDim2.new(0, 200, 0, 50)
    billboardName.AlwaysOnTop = true
    billboardName.StudsOffset = Vector3.new(0, 3, 0)
    billboardName.Parent = espFolder

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextStrokeTransparency = 0
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextScaled = true
    nameLabel.Parent = billboardName

    -- Billboard de la distance (en-dessous)
    local billboardDist = Instance.new("BillboardGui")
    billboardDist.Name = "DistBillboard"
    billboardDist.Size = UDim2.new(0, 200, 0, 40)
    billboardDist.AlwaysOnTop = true
    billboardDist.StudsOffset = Vector3.new(0, -2, 0)
    billboardDist.Parent = espFolder

    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 1, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.TextStrokeTransparency = 0
    distLabel.Font = Enum.Font.SourceSansBold
    distLabel.TextScaled = true
    distLabel.Parent = billboardDist

    -- Box améliorée (BoundingBox du joueur)
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ESPBox"
    box.Transparency = 0.5
    box.AlwaysOnTop = true
    box.ZIndex = 0
    box.Adornee = player.Character
    box.Parent = espFolder

    -- Ligne (Beam)
    local attachmentLocal = Instance.new("Attachment")
    attachmentLocal.Parent = localPlayer.Character:WaitForChild("HumanoidRootPart")

    local attachmentTarget = Instance.new("Attachment")
    attachmentTarget.Parent = player.Character:WaitForChild("HumanoidRootPart")

    local beam = Instance.new("Beam")
    beam.Attachment0 = attachmentLocal
    beam.Attachment1 = attachmentTarget
    beam.Transparency = NumberSequence.new(0)
    beam.Width0 = 0.05
    beam.Width1 = 0.05
    beam.FaceCamera = true
    beam.Parent = espFolder

    -- Mise à jour dynamique
    ESPConnections[player] = RunService.RenderStepped:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            -- Distance
            local distance = (localPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude

            -- BoundingBox
            local cf, size = player.Character:GetBoundingBox()
            box.CFrame = cf
            box.Size = size

            -- Texte
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

-- Supprime ESP d’un joueur
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
        button.BackgroundColor3 = Color3.fromRGB(0, 170, 0) -- vert ON
    else
        disableESP()
        button.BackgroundColor3 = Color3.fromRGB(170, 0, 0) -- rouge OFF
    end
end)
