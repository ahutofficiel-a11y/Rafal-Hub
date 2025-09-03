-- ESP Amélioré (Box + HealthBar + Skeleton + Distance)
-- Place ce script dans StarterPlayerScripts

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Fonction pour dessiner une ligne (squelette et box)
local function drawLine()
    local line = Drawing.new("Line")
    line.Thickness = 1.5
    line.Color = Color3.fromRGB(0, 255, 0)
    line.Transparency = 1
    return line
end

-- Fonction pour dessiner du texte
local function drawText(size)
    local text = Drawing.new("Text")
    text.Size = size or 16
    text.Color = Color3.fromRGB(0, 255, 0)
    text.Center = true
    text.Outline = true
    text.Visible = true
    return text
end

-- Fonction principale ESP
local function addESP(player)
    if player == LocalPlayer then return end

    local lines = {} -- pour squelette et box
    local healthBarOutline = Drawing.new("Line")
    local healthBar = Drawing.new("Line")
    local nameTag = drawText(16)
    local distanceTag = drawText(14)

    -- créer lignes du squelette
    local skeletonParts = {
        {"Head","UpperTorso"},
        {"UpperTorso","LowerTorso"},
        {"UpperTorso","LeftUpperArm"},
        {"LeftUpperArm","LeftLowerArm"},
        {"LeftLowerArm","LeftHand"},
        {"UpperTorso","RightUpperArm"},
        {"RightUpperArm","RightLowerArm"},
        {"RightLowerArm","RightHand"},
        {"LowerTorso","LeftUpperLeg"},
        {"LeftUpperLeg","LeftLowerLeg"},
        {"LeftLowerLeg","LeftFoot"},
        {"LowerTorso","RightUpperLeg"},
        {"RightUpperLeg","RightLowerLeg"},
        {"RightLowerLeg","RightFoot"},
    }
    for _ = 1, #skeletonParts do
        table.insert(lines, drawLine())
    end
    -- box
    for _ = 1, 4 do
        table.insert(lines, drawLine())
    end

    -- update loop
    RunService.RenderStepped:Connect(function()
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            for _, l in ipairs(lines) do l.Visible = false end
            healthBar.Visible = false
            healthBarOutline.Visible = false
            nameTag.Visible = false
            distanceTag.Visible = false
            return
        end

        local hrp = player.Character.HumanoidRootPart
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")

        -- convertir position écran
        local hrpPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
        if not onScreen then
            for _, l in ipairs(lines) do l.Visible = false end
            healthBar.Visible = false
            healthBarOutline.Visible = false
            nameTag.Visible = false
            distanceTag.Visible = false
            return
        end

        -- Box ESP
        local minVec, maxVec
        for _, part in ipairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") then
                local pos = Camera:WorldToViewportPoint(part.Position)
                if not minVec then
                    minVec = Vector2.new(pos.X, pos.Y)
                    maxVec = minVec
                else
                    minVec = Vector2.new(math.min(minVec.X,pos.X), math.min(minVec.Y,pos.Y))
                    maxVec = Vector2.new(math.max(maxVec.X,pos.X), math.max(maxVec.Y,pos.Y))
                end
            end
        end
        if minVec and maxVec then
            -- 4 côtés
            lines[#lines-3].From = Vector2.new(minVec.X, minVec.Y)
            lines[#lines-3].To = Vector2.new(maxVec.X, minVec.Y)

            lines[#lines-2].From = Vector2.new(maxVec.X, minVec.Y)
            lines[#lines-2].To = Vector2.new(maxVec.X, maxVec.Y)

            lines[#lines-1].From = Vector2.new(maxVec.X, maxVec.Y)
            lines[#lines-1].To = Vector2.new(minVec.X, maxVec.Y)

            lines[#lines].From = Vector2.new(minVec.X, maxVec.Y)
            lines[#lines].To = Vector2.new(minVec.X, minVec.Y)

            for i = #lines-3, #lines do
                lines[i].Visible = true
            end
        end

        -- Skeleton ESP
        for i, pair in ipairs(skeletonParts) do
            local part1 = player.Character:FindFirstChild(pair[1])
            local part2 = player.Character:FindFirstChild(pair[2])
            if part1 and part2 then
                local p1, vis1 = Camera:WorldToViewportPoint(part1.Position)
                local p2, vis2 = Camera:WorldToViewportPoint(part2.Position)
                if vis1 and vis2 then
                    lines[i].From = Vector2.new(p1.X, p1.Y)
                    lines[i].To = Vector2.new(p2.X, p2.Y)
                    lines[i].Visible = true
                else
                    lines[i].Visible = false
                end
            else
                lines[i].Visible = false
            end
        end

        -- HealthBar
        if humanoid then
            local healthRatio = humanoid.Health / humanoid.MaxHealth
            local barHeight = (maxVec.Y - minVec.Y)
            local xPos = minVec.X - 6

            healthBarOutline.From = Vector2.new(xPos, minVec.Y)
            healthBarOutline.To = Vector2.new(xPos, maxVec.Y)
            healthBarOutline.Color = Color3.new(0,0,0)
            healthBarOutline.Thickness = 3
            healthBarOutline.Visible = true

            healthBar.From = Vector2.new(xPos, maxVec.Y)
            healthBar.To = Vector2.new(xPos, maxVec.Y - barHeight * healthRatio)
            healthBar.Color = Color3.fromRGB(255 - 255*healthRatio, 255*healthRatio, 0)
            healthBar.Thickness = 2
            healthBar.Visible = true
        end

        -- NameTag + Distance
        nameTag.Text = player.Name
        nameTag.Position = Vector2.new(hrpPos.X, minVec.Y - 15)
        nameTag.Visible = true

        local distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) and (hrp.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude or 0
        distanceTag.Text = string.format("[%.0f]", distance)
        distanceTag.Position = Vector2.new(hrpPos.X, maxVec.Y + 15)
        distanceTag.Visible = true
    end)
end

-- ESP pour tous les joueurs
for _, p in ipairs(Players:GetPlayers()) do
    addESP(p)
end
Players.PlayerAdded:Connect(addESP)
