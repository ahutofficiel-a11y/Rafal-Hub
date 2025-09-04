-- Script Local à mettre dans ton bouton (ex: TextButton)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local button = script.Parent

local ESPEnabled = false
local ESPConnections = {}
local ESPFolders = {}

-- Détermine la couleur selon la team
local function getTeamColor(player)
    if player.Team and localPlayer.Team then
        if player.Team == localPlayer.Team then
            return Color3.fromRGB(0, 150, 255) -- bleu (allié)
        else
            return Color3.fromRGB(255, 0, 0) -- rouge (ennemi)
        end
    end
    return Color3.fromRGB(0, 255, 0) -- vert si pas de team
end

-- Crée l'ESP pour un joueur
local function createESP(player)
    if player == localPlayer or not player.Character then return end

    local espFolder = Instance.new("Folder")
    espFolder.Name = "ESP_" .. player.Name
    espFolder.Parent = player.Character
    ESPFolders[player] = espFolder

    -- Billboard (texte)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESPBillboard"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Parent = espFolder

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextStrokeTransparency = 0
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextScaled = true
    textLabel.Parent = billboard

    -- Box
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ESPBox"
    box.Adornee = player.Character:WaitForChild("HumanoidRootPart")
    box.Size = Vector3.new(4, 6, 2)
    box.Transparency = 0.5
    box.AlwaysOnTop = true
    box.ZIndex = 0
    box.Parent = espFolder

    -- Ligne
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
            local distance = (localPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            textLabel.Text = player.Name .. " [" .. math.floor(distance) .. "m]"

            local teamColor = getTeamColor(player)
            textLabel.TextColor3 = teamColor
            box.Color3 = teamColor
            beam.Color = ColorSequence.new(teamColor)
        end
    end)
end

-- Supprimer l’ESP d’un joueur
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

-- Toggle quand tu cliques sur le bouton
button.MouseButton1Click:Connect(function()
    ESPEnabled = not ESPEnabled
    if ESPEnabled then
        enableESP()
    else
        disableESP()
    end
end)
