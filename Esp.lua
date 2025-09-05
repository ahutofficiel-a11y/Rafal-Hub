-- ESP Debug / Modération
-- Highlight + Nom + Distance
-- Détection alliés / ennemis + GUI toggle

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- OPTIONS
local SHOW_SELF = false -- afficher ton propre joueur ?

-- état ESP
local espEnabled = true
local cache = {}

-- couleurs
local ALLY_COLOR = Color3.fromRGB(0, 255, 100)
local ENEMY_COLOR = Color3.fromRGB(255, 80, 80)
local NEUTRAL_COLOR = Color3.fromRGB(255, 255, 255)

---------------------------------------------------------------------
-- GUI (bouton On/Off)
---------------------------------------------------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ESP_ToggleGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 100, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.TextColor3 = Color3.new(1,1,1)
toggleButton.TextScaled = true
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.Text = "ESP: ON"
toggleButton.Parent = screenGui

local function updateButton()
    toggleButton.Text = espEnabled and "ESP: ON" or "ESP: OFF"
    toggleButton.BackgroundColor3 = espEnabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
end

toggleButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    updateButton()
end)

---------------------------------------------------------------------
-- ESP logic
---------------------------------------------------------------------

local function getRelationColor(player)
    if LocalPlayer.Team and player.Team then
        if LocalPlayer.Team == player.Team then
            return ALLY_COLOR
        else
            return ENEMY_COLOR
        end
    else
        return NEUTRAL_COLOR
    end
end

-- crée ESP pour un personnage
local function createESP(player, char)
    if not char or cache[player] then return end

    -- Highlight
    local highlight = Instance.new("Highlight")
    highlight.Name = "DevESP_Highlight"
    highlight.Adornee = char
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
    highlight.OutlineColor = getRelationColor(player)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = char

    -- Billboard
    local head = char:FindFirstChild("Head")
    local billboard
    if head then
        billboard = Instance.new("BillboardGui")
        billboard.Name = "DevESP_Billboard"
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 150, 0, 30)
        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = char

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextScaled = true
        label.Font = Enum.Font.SourceSansBold
        label.TextStrokeTransparency = 0.5
        label.TextColor3 = Color3.new(1,1,1)
        label.Text = player.Name
        label.Parent = billboard
    end

    cache[player] = {highlight = highlight, billboard = billboard}
end

-- retire ESP
local function removeESP(player)
    local entry = cache[player]
    if entry then
        if entry.highlight then entry.highlight:Destroy() end
        if entry.billboard then entry.billboard:Destroy() end
        cache[player] = nil
    end
end

-- update boucle
local function updateESP()
    local lpChar = LocalPlayer.Character
    local lpRoot = lpChar and lpChar:FindFirstChild("HumanoidRootPart")
    for player, entry in pairs(cache) do
        if player.Character and player.Character.PrimaryPart and lpRoot then
            local dist = (lpRoot.Position - player.Character.PrimaryPart.Position).Magnitude
            -- texte
            if entry.billboard then
                local label = entry.billboard:FindFirstChildOfClass("TextLabel")
                if label then
                    label.Text = string.format("%s — %d studs", player.Name, dist)
                end
                entry.billboard.Enabled = espEnabled
            end
            -- couleur + toggle
            if entry.highlight then
                entry.highlight.OutlineColor = getRelationColor(player)
                entry.highlight.Enabled = espEnabled
            end
        end
    end
end

-- gestion des joueurs
local function onCharacterAdded(player, char)
    task.wait(1)
    createESP(player, char)
    char.AncestryChanged:Connect(function(_, parent)
        if not parent then removeESP(player) end
    end)
end

local function onPlayerAdded(player)
    if player == LocalPlayer and not SHOW_SELF then return end
    player.CharacterAdded:Connect(function(char) onCharacterAdded(player, char) end)
    if player.Character then onCharacterAdded(player, player.Character) end
end

local function onPlayerRemoving(player)
    removeESP(player)
end

-- toggle via touche E
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.E then
        espEnabled = not espEnabled
        updateButton()
    end
end)

-- boucle update
task.spawn(function()
    while true do
        updateESP()
        task.wait(0.1)
    end
end)

-- init
for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LocalPlayer or SHOW_SELF then
        onPlayerAdded(p)
    end
end
Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

updateButton()
print("ESP chargé : bouton GUI + touche E")
