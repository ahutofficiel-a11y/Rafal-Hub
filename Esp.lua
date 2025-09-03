-- ESP Amélioré (Box + HealthBar + Skeleton + Distance) - Design Propre
-- À placer dans StarterPlayerScripts

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Fonction pour créer une ligne (Box / Skeleton)
local function createLine(thickness, color)
    local line = Drawing.new("Line")
    line.Thickness = thickness or 1.5
    line.Color = color or Color3.fromRGB(0, 255, 0)
    line.Transparency = 1
    line.Visible = false
    return line
end

-- Fonction pour créer un texte
local function createText(size, color)
    local text = Drawing.new("Text")
    text.Size = size or 16
    text.Color = color or Color3.fromRGB(0, 255, 0)
    text.Center = true
    text.Outline = true
    text.OutlineColor = Color3.fromRGB(0, 0, 0)
    text.Visible = false
    return text
end

-- Fonction principale ESP
local function addESP(player)
    if player == LocalPlayer then return end

    local skeletonLines = {}
    local boxLines = {}
    local healthBar = createLine(3, Color3.fromRGB(0, 255, 0))
    local healthBarBG = createLine(5, Color3.fromRGB(0, 0, 0))
    local nameTag = createText(16, Color3.fromRGB(255, 255, 255))
    local distanceTag = createText(14, Color3.fromRGB(0, 170, 255))

    -- Skeleton pairs
    local skeletonPairs = {
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
    for _ = 1, #skeletonPairs do
        table.insert(skeletonLines, createLine(1.5, Color3.fromRGB(0,255,0)))
    end
    -- Box (4 côtés)
    for _ = 1, 4 do
        table.insert(boxLines, createLine(2, Color3.fromRGB(255,255,255)))
    end

    RunService.RenderStepped:Connect(function()
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            for _, l in ipairs(skeletonLines) do l.Visible = false end
            for _, l in ipairs(boxLines) do l.Visible = false end
            healthBar.Visible = false
            healthBarBG.Visible = false
            nameTag.Visible = false
            distanceTag.Visible = false
            return
        end

        local hrp = player.Character.HumanoidRootPart
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        local hrpPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)

        if not onScreen then
            for _, l in ipairs(skeletonLines) do l.Visible = false end
            for _, l in ipairs(boxLines) do l.Visible = false end
            healthBar.Visible = false
            healthBarBG.Visible = false
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
                    minVec, maxVec = Vector2.new(pos.X,pos.Y), Vector2.new(pos.X,pos.Y)
                else
                    minVec = Vector2.new(math.min(minVec.X,pos.X), math.min(minVec.Y,pos.Y))
                    maxVec = Vector2.new(math.max(maxVec.X,pos.X), math.max(maxVec.Y,pos.Y))
                end
            end
        end

        if minVec and maxVec then
            -- haut
            boxLines[1].From, boxLines[1].To = Vector2.new(minVec.X,minVec.Y), Vector2.new(maxVec.X,minVec.Y)
            -- droite
            boxLines[2].From, boxLines[2].To = Vector2.new(maxVec.X,minVec.Y), Vector2.new(maxVec.X,maxVec.Y)
            -- bas
            boxLines[3].From, boxLines[3].To = Vector2.new(maxVec.X,maxVec.Y), Vector2.new(minVec.X,maxVec.Y)
            -- gauche
            boxLines[4].From, boxLines[4].To = Vector2.new(minVec.X,maxVec.Y), Vector2.new(minVec.X,minVec.Y)

            for _, l in ipairs(boxLines) do l.Visible = true end
        end

        -- Skeleton ESP
        for i, pair in ipairs(skeletonPairs) do
            local p1, p2 = player.Character:FindFirstChild(pair[1]), player.Character:FindFirstChild(pair[2])
            if p1 and p2 then
                local v1, ok1 = Camera:WorldToViewportPoint(p1.Position)
                local v2, ok2 = Camera:WorldToViewportPoint(p2.Position)
                if ok1 and ok2 then
                    skeletonLines[i].From = Vector2.new(v1.X,v1.Y)
                    skeletonLines[i].To = Vector2.new(v2.X,v2.Y)
                    skeletonLines[i].Visible = true
                else
                    skeletonLines[i].Visible = false
                end
            else
                skeletonLines[i].Visible = false
            end
        end

        -- Health Bar
        if humanoid then
            local ratio = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
            local barHeight = (maxVec.Y - minVec.Y)
            local x = minVec.X - 8

            healthBarBG.From, healthBarBG.To = Vector2.new(x,minVec.Y), Vector2.new(x,maxVec.Y)
            healthBarBG.Visible = true

            healthBar.From = Vector2.new(x,maxVec.Y)
            healthBar.To = Vector2.new(x, maxVec.Y - barHeight * ratio)
            healthBar.Color = Color3.fromRGB(255 - (255*ratio), 255*ratio, 0) -- dégradé vert->rouge
            healthBar.Visible = true
        end

        -- Pseudo
        nameTag.Text = player.Name
        nameTag.Position = Vector2.new(hrpPos.X, minVec.Y - 15)
        nameTag.Visible = true

        -- Distance
        local dist = 0
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            dist = (hrp.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        end
        distanceTag.Text = string.format("[%.0f studs]", dist)
        distanceTag.Position = Vector2.new(hrpPos.X, maxVec.Y + 15)
        distanceTag.Visible = true
    end)
end

-- Ajout ESP pour chaque joueur
for _, plr in ipairs(Players:GetPlayers()) do
    addESP(plr)
end
Players.PlayerAdded:Connect(addESP)
