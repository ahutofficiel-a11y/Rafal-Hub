-- ============================================================
-- MODERN ESP MENU
-- ============================================================

local TweenService = game:GetService("TweenService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ESP_MenuGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder = 999999
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================================
-- COLORS
-- ============================================================

local COLORS = {
    Background = Color3.fromRGB(18, 18, 22),
    Secondary = Color3.fromRGB(25, 25, 30),
    Button = Color3.fromRGB(32, 32, 38),
    ButtonHover = Color3.fromRGB(42, 42, 50),

    White = Color3.fromRGB(245, 245, 250),
    Gray = Color3.fromRGB(155, 155, 165),

    Green = Color3.fromRGB(55, 220, 125),
    Red = Color3.fromRGB(235, 75, 85),

    Border = Color3.fromRGB(55, 55, 65),
}

-- ============================================================
-- MAIN FRAME
-- ============================================================

local menuFrame = Instance.new("Frame")
menuFrame.Name = "Main"
menuFrame.Size = UDim2.new(0, 270, 0, 405)
menuFrame.Position = UDim2.new(0, 25, 0.5, -200)
menuFrame.BackgroundColor3 = COLORS.Background
menuFrame.BorderSizePixel = 0
menuFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = menuFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = COLORS.Border
mainStroke.Thickness = 1
mainStroke.Transparency = 0.25
mainStroke.Parent = menuFrame

-- ============================================================
-- TOP BAR
-- ============================================================

local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 55)
topBar.BackgroundColor3 = COLORS.Secondary
topBar.BorderSizePixel = 0
topBar.Active = true
topBar.Parent = menuFrame

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 12)
topCorner.Parent = topBar

-- Cache la partie basse du Corner
local topFix = Instance.new("Frame")
topFix.Size = UDim2.new(1, 0, 0, 15)
topFix.Position = UDim2.new(0, 0, 1, -15)
topFix.BackgroundColor3 = COLORS.Secondary
topFix.BorderSizePixel = 0
topFix.Parent = topBar

-- Icone
local icon = Instance.new("TextLabel")
icon.Size = UDim2.new(0, 35, 0, 35)
icon.Position = UDim2.new(0, 12, 0, 10)
icon.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
icon.Text = "◈"
icon.TextColor3 = COLORS.Green
icon.TextSize = 20
icon.Font = Enum.Font.GothamBold
icon.Parent = topBar

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(0, 9)
iconCorner.Parent = icon

-- Titre
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -105, 0, 25)
title.Position = UDim2.new(0, 55, 0, 8)
title.BackgroundTransparency = 1
title.Text = "ESP DEBUG"
title.TextColor3 = COLORS.White
title.TextSize = 17
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -105, 0, 18)
subtitle.Position = UDim2.new(0, 55, 0, 29)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Developer Tools"
subtitle.TextColor3 = COLORS.Gray
subtitle.TextSize = 11
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = topBar

-- Bouton fermer
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 12)
closeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 47)
closeButton.Text = "×"
closeButton.TextColor3 = COLORS.Gray
closeButton.TextSize = 20
closeButton.Font = Enum.Font.GothamBold
closeButton.AutoButtonColor = false
closeButton.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

closeButton.MouseEnter:Connect(function()
    TweenService:Create(
        closeButton,
        TweenInfo.new(0.15),
        {BackgroundColor3 = COLORS.Red, TextColor3 = COLORS.White}
    ):Play()
end)

closeButton.MouseLeave:Connect(function()
    TweenService:Create(
        closeButton,
        TweenInfo.new(0.15),
        {BackgroundColor3 = Color3.fromRGB(40, 40, 47), TextColor3 = COLORS.Gray}
    ):Play()
end)

closeButton.MouseButton1Click:Connect(function()
    menuFrame.Visible = false
end)

-- ============================================================
-- SEPARATOR
-- ============================================================

local separator = Instance.new("Frame")
separator.Size = UDim2.new(1, -24, 0, 1)
separator.Position = UDim2.new(0, 12, 0, 65)
separator.BackgroundColor3 = COLORS.Border
separator.BorderSizePixel = 0
separator.Parent = menuFrame

-- ============================================================
-- CONTENT
-- ============================================================

local content = Instance.new("ScrollingFrame")
content.Name = "Content"
content.Size = UDim2.new(1, -20, 1, -78)
content.Position = UDim2.new(0, 10, 0, 73)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 3
content.ScrollBarImageColor3 = COLORS.Border
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.Parent = menuFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 7)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = content

local padding = Instance.new("UIPadding")
padding.PaddingLeft = UDim.new(0, 2)
padding.PaddingRight = UDim.new(0, 2)
padding.PaddingBottom = UDim.new(0, 10)
padding.Parent = content

-- ============================================================
-- BUTTONS
-- ============================================================

local buttons = {}

local function createToggle(name, order, settingKey)

    local button = Instance.new("TextButton")
    button.Name = settingKey
    button.Size = UDim2.new(1, 0, 0, 39)
    button.BackgroundColor3 = COLORS.Button
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Text = ""
    button.LayoutOrder = order
    button.Parent = content

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button

    local stroke = Instance.new("UIStroke")
    stroke.Color = COLORS.Border
    stroke.Thickness = 1
    stroke.Transparency = 0.7
    stroke.Parent = button

    -- Texte
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -65, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = COLORS.White
    label.TextSize = 13
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = button

    -- Status
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0, 42, 1, 0)
    status.Position = UDim2.new(1, -50, 0, 0)
    status.BackgroundTransparency = 1
    status.TextSize = 11
    status.Font = Enum.Font.GothamBold
    status.Parent = button

    local function update()

        local enabled = settings[settingKey]

        if enabled then
            status.Text = "ON"
            status.TextColor3 = COLORS.Green
        else
            status.Text = "OFF"
            status.TextColor3 = COLORS.Red
        end

    end

    update()

    button.MouseEnter:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.12),
            {BackgroundColor3 = COLORS.ButtonHover}
        ):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.12),
            {BackgroundColor3 = COLORS.Button}
        ):Play()
    end)

    button.MouseButton1Click:Connect(function()

        settings[settingKey] = not settings[settingKey]

        update()

    end)

    buttons[settingKey] = button

    return button
end

-- ============================================================
-- KEYBINDS
-- ============================================================

local function createBind(name, order, settingKey)

    local button = Instance.new("TextButton")
    button.Name = settingKey
    button.Size = UDim2.new(1, 0, 0, 39)
    button.BackgroundColor3 = COLORS.Button
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Text = ""
    button.LayoutOrder = order
    button.Parent = content

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -75, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = COLORS.White
    label.TextSize = 13
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = button

    local keyLabel = Instance.new("TextLabel")
    keyLabel.Size = UDim2.new(0, 50, 0, 25)
    keyLabel.Position = UDim2.new(1, -60, 0.5, -12)
    keyLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 53)
    keyLabel.Text = settings[settingKey].Name
    keyLabel.TextColor3 = COLORS.Green
    keyLabel.TextSize = 11
    keyLabel.Font = Enum.Font.GothamBold
    keyLabel.Parent = button

    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 6)
    keyCorner.Parent = keyLabel

    button.MouseEnter:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.12),
            {BackgroundColor3 = COLORS.ButtonHover}
        ):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.12),
            {BackgroundColor3 = COLORS.Button}
        ):Play()
    end)

    button.MouseButton1Click:Connect(function()

        keyLabel.Text = "PRESS"
        keyLabel.TextColor3 = COLORS.White

        waitingForKey = {
            key = settingKey,
            label = name,
            display = keyLabel
        }

    end)

    buttons[settingKey] = button

    return button
end

-- ============================================================
-- CREATE OPTIONS
-- ============================================================

createToggle("ESP", 1, "Enabled")
createToggle("Afficher le nom", 2, "ShowName")
createToggle("Afficher la distance", 3, "ShowDistance")
createToggle("Afficher la vie", 4, "ShowHealth")
createToggle("Couleurs des équipes", 5, "UseTeamColors")
createToggle("Afficher soi-même", 6, "ShowSelf")
createToggle("Toggle souris", 7, "UseMouseToggle")

createBind("Touche du menu", 8, "MenuKey")
createBind("Touche de la souris", 9, "MouseKey")

-- ============================================================
-- DRAG SYSTEM
-- ============================================================

local dragging = false
local dragStart
local startPosition

topBar.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = true
        dragStart = input.Position
        startPosition = menuFrame.Position

    end

end)

topBar.InputEnded:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end

end)

UserInputService.InputChanged:Connect(function(input)

    if not dragging then
        return
    end

    if input.UserInputType ~= Enum.UserInputType.MouseMovement then
        return
    end

    local delta = input.Position - dragStart

    menuFrame.Position = UDim2.new(
        startPosition.X.Scale,
        startPosition.X.Offset + delta.X,
        startPosition.Y.Scale,
        startPosition.Y.Offset + delta.Y
    )

end)

-- ============================================================
-- INPUT BINDS
-- ============================================================

UserInputService.InputBegan:Connect(function(input, gameProcessed)

    if gameProcessed then
        return
    end

    if waitingForKey then

        if input.UserInputType == Enum.UserInputType.Keyboard then

            local key = waitingForKey.key

            settings[key] = input.KeyCode

            if waitingForKey.display then
                waitingForKey.display.Text = input.KeyCode.Name
                waitingForKey.display.TextColor3 = COLORS.Green
            end

            waitingForKey = nil

        end

        return
    end

    if input.KeyCode == settings.MenuKey then

        menuFrame.Visible = not menuFrame.Visible

    end

end)

print("Modern ESP Menu chargé.")
