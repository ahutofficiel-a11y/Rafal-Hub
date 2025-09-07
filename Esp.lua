-- ESP Debug / Modération avec MENU déplaçable
-- Menu toujours devant + touches personnalisables
-- Souris débloquée avec MouseBehavior
-- Auto-ajout joueurs + respawn

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

---------------------------------------------------------------------
-- OPTIONS (par défaut)
---------------------------------------------------------------------
local settings = {
    Enabled = true,
    ShowName = true,
    ShowDistance = true,
    ShowHealth = true,
    UseTeamColors = true,
    ShowSelf = false,
    UseMouseToggle = true,
    MenuKey = Enum.KeyCode.M,
    MouseKey = Enum.KeyCode.V,
}

-- couleurs
local ALLY_COLOR = Color3.fromRGB(0, 255, 100)
local ENEMY_COLOR = Color3.fromRGB(255, 80, 80)
local NEUTRAL_COLOR = Color3.fromRGB(255, 255, 255)

local cache = {}
local mouseVisible = false
local waitingForKey = nil -- pour savoir si on attend un nouveau bind

---------------------------------------------------------------------
-- GUI MENU
---------------------------------------------------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ESP_MenuGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder = 999999999 -- toujours devant absolument tout
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 220, 0, 320)
menuFrame.Position = UDim2.new(0, 10, 0, 10)
menuFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
menuFrame.BorderSizePixel = 2
menuFrame.Active = true
menuFrame.ZIndex = 9999
menuFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.SourceSansBold
title.Text = "ESP MENU"
title.ZIndex = 9999
title.Parent = menuFrame

-- Drag & Drop
local dragging, dragStart, startPos
title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = menuFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        menuFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

---------------------------------------------------------------------
-- CREATION TOGGLES & BINDS
---------------------------------------------------------------------
local buttons = {}

local function createToggle(name, order, settingKey)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Position = UDim2.new(0, 5, 0, 30 + (order-1)*35)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.new(1,1,1)
    button.TextScaled = true
    button.Font = Enum.Font.SourceSans
    button.ZIndex = 9999
    button.Text = name..": "..(settings[settingKey] and "ON" or "OFF")
    button.Parent = menuFrame
    buttons[settingKey] = button

    button.MouseButton1Click:Connect(function()
        settings[settingKey] = not settings[settingKey]
        button.Text = name..": "..(settings[settingKey] and "ON" or "OFF")
    end)
end

local function createBind(name, order, settingKey)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Position = UDim2.new(0, 5, 0, 30 + (order-1)*35)
    button.BackgroundColor3 = Color3.fromRGB(80, 60, 60)
    button.TextColor3 = Color3.new(1,1,1)
    button.TextScaled = true
    button.Font = Enum.Font.SourceSans
    button.ZIndex = 9999
    button.Text = name..": "..tostring(settings[settingKey].Name)
    button.Parent = menuFrame
    buttons[settingKey] = button

    button.MouseButton1Click:Connect(function()
        button.Text = name..": [Appuie sur une touche]"
        waitingForKey = {key = settingKey, label = name}
    end)
end

-- toggles
createToggle("ESP", 1, "Enabled")
createToggle("Afficher Nom", 2, "ShowName")
createToggle("Afficher Distance", 3, "ShowDistance")
createToggle("Afficher Vie", 4, "ShowHealth")
createToggle("Couleurs Equipes", 5, "UseTeamColors")
createToggle("Afficher Soi-même", 6, "ShowSelf")
createToggle("Toggle Souris", 7, "UseMouseToggle")
-- binds
createBind("Touche Menu", 8, "MenuKey")
createBind("Touche Souris", 9, "MouseKey")

---------------------------------------------------------------------
-- ESP LOGIC
---------------------------------------------------------------------
local function getRelationColor(player)
    if not settings.UseTeamColors then
        return NEUTRAL_COLOR
    end
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

local function createESP(player, char)
    if not char then return end

    if cache[player] then
        if cache[player].highlight then cache[player].highlight:Destroy() end
        if cache[player].billboard then cache[player].billboard:Destroy() end
        cache[player] = nil
    end

    local highlight = Instance.new("Highlight")
    highlight.Adornee = char
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
    highlight.OutlineColor = getRelationColor(player)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = char

    local head = char:FindFirstChild("Head")
    local billboard, nameLabel, hpLabel
    if head then
        billboard = Instance.new("BillboardGui")
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
        billboard.AlwaysOnTop = true
        billboard.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        billboard.Parent = char

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundTransparency = 1
        frame.Parent = billboard

        nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextScaled = true
        nameLabel.Font = Enum.Font.SourceSansBold
        nameLabel.TextStrokeTransparency = 0.5
        nameLabel.TextColor3 = Color3.new(1,1,1)
        nameLabel.Text = player.Name
        nameLabel.Parent = frame

        hpLabel = Instance.new("TextLabel")
        hpLabel.Size = UDim2.new(1, 0, 0.5, 0)
        hpLabel.Position = UDim2.new(0, 0, 0.5, 0)
        hpLabel.BackgroundTransparency = 1
        hpLabel.TextScaled = true
        hpLabel.Font = Enum.Font.SourceSans
        hpLabel.TextStrokeTransparency = 0.7
        hpLabel.TextColor3 = Color3.new(0.8, 1, 0.8)
        hpLabel.Text = "Vie : ..."
        hpLabel.Parent = frame
    end

    cache[player] = {highlight = highlight, billboard = billboard, nameLabel = nameLabel, hpLabel = hpLabel}

    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid and hpLabel then
        local function updateHP()
            if settings.ShowHealth then
                hpLabel.Text = string.format("Vie : %d / %d", humanoid.Health, humanoid.MaxHealth)
            else
                hpLabel.Text = ""
            end
        end
        humanoid.HealthChanged:Connect(updateHP)
        humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(updateHP)
        updateHP()
    end
end

local function removeESP(player)
    if cache[player] then
        if cache[player].highlight then cache[player].highlight:Destroy() end
        if cache[player].billboard then cache[player].billboard:Destroy() end
        cache[player] = nil
    end
end

local function updateESP()
    local lpChar = LocalPlayer.Character
    local lpRoot = lpChar and lpChar:FindFirstChild("HumanoidRootPart")
    for player, entry in pairs(cache) do
        if player.Character and player.Character.PrimaryPart and lpRoot then
            local dist = (lpRoot.Position - player.Character.PrimaryPart.Position).Magnitude
            if entry.nameLabel then
                if settings.ShowName then
                    local text = player.Name
                    if settings.ShowDistance then
                        text = text.." — "..math.floor(dist).." studs"
                    end
                    entry.nameLabel.Text = text
                else
                    entry.nameLabel.Text = ""
                end
            end
            if entry.highlight then
                entry.highlight.OutlineColor = getRelationColor(player)
                entry.highlight.Enabled = settings.Enabled
            end
            if entry.billboard then
                entry.billboard.Enabled = settings.Enabled
            end
        end
    end
end

---------------------------------------------------------------------
-- EVENTS
---------------------------------------------------------------------
local function onCharacterAdded(player, char)
    task.wait(0.5)
    createESP(player, char)
    char:WaitForChild("Humanoid").Died:Connect(function()
        removeESP(player)
    end)
end

local function onPlayerAdded(player)
    if player == LocalPlayer and not settings.ShowSelf then return end
    player.CharacterAdded:Connect(function(char) onCharacterAdded(player, char) end)
    if player.Character then onCharacterAdded(player, player.Character) end
end

local function onPlayerRemoving(player) removeESP(player) end

-- input
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end

    if waitingForKey then
        settings[waitingForKey.key] = input.KeyCode
        buttons[waitingForKey.key].Text = waitingForKey.label..": "..tostring(input.KeyCode.Name)
        waitingForKey = nil
        return
    end

    if input.KeyCode == settings.MenuKey then
        menuFrame.Visible = not menuFrame.Visible
    elseif input.KeyCode == settings.MouseKey and settings.UseMouseToggle then
        mouseVisible = not mouseVisible
        UserInputService.MouseIconEnabled = mouseVisible
        if mouseVisible then
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        else
            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        end
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
    if p ~= LocalPlayer or settings.ShowSelf then
        onPlayerAdded(p)
    end
end
Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

print("ESP chargé avec souris toggle complète (MouseBehavior) + menu toujours devant")
