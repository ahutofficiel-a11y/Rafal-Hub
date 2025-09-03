-- ESP Amélioré (Box + HealthBar + Skeleton + Distance)
-- Place ce script dans StarterPlayerScripts
-- ESP Amélioré (Box + HealthBar + Skeleton + Distance) - Design Propre
-- À placer dans StarterPlayerScripts

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Fonction pour dessiner une ligne (squelette et box)
local function drawLine()
-- Fonction pour créer une ligne (Box / Skeleton)
local function createLine(thickness, color)
    local line = Drawing.new("Line")
    line.Thickness = 1.5
    line.Color = Color3.fromRGB(0, 255, 0)
    line.Thickness = thickness or 1.5
    line.Color = color or Color3.fromRGB(0, 255, 0)
    line.Transparency = 1
    line.Visible = false
    return line
end

-- Fonction pour dessiner du texte
local function drawText(size)
-- Fonction pour créer un texte
local function createText(size, color)
    local text = Drawing.new("Text")
    text.Size = size or 16
    text.Color = Color3.fromRGB(0, 255, 0)
    text.Color = color or Color3.fromRGB(0, 255, 0)
    text.Center = true
    text.Outline = true
    text.Visible = true
    text.OutlineColor = Color3.fromRGB(0, 0, 0)
    text.Visible = false
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
    local skeletonLines = {}
    local boxLines = {}
    local healthBar = createLine(3, Color3.fromRGB(0, 255, 0))
    local healthBarBG = createLine(5, Color3.fromRGB(0, 0, 0))
    local nameTag = createText(16, Color3.fromRGB(255, 255, 255))
    local distanceTag = createText(14, Color3.fromRGB(0, 170, 255))

    -- créer lignes du squelette
    local skeletonParts = {
    -- Skeleton pairs
    local skeletonPairs = {
        {"Head","UpperTorso"},
        {"UpperTorso","LowerTorso"},
        {"UpperTorso","LeftUpperArm"},
@@ -53,34 +56,34 @@ local function addESP(player)
        {"RightUpperLeg","RightLowerLeg"},
        {"RightLowerLeg","RightFoot"},
    }
    for _ = 1, #skeletonParts do
        table.insert(lines, drawLine())
    for _ = 1, #skeletonPairs do
        table.insert(skeletonLines, createLine(1.5, Color3.fromRGB(0,255,0)))
    end
    -- box
    -- Box (4 côtés)
    for _ = 1, 4 do
        table.insert(lines, drawLine())
        table.insert(boxLines, createLine(2, Color3.fromRGB(255,255,255)))
    end

    -- update loop
    RunService.RenderStepped:Connect(function()
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            for _, l in ipairs(lines) do l.Visible = false end
            for _, l in ipairs(skeletonLines) do l.Visible = false end
            for _, l in ipairs(boxLines) do l.Visible = false end
            healthBar.Visible = false
            healthBarOutline.Visible = false
            healthBarBG.Visible = false
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
            for _, l in ipairs(skeletonLines) do l.Visible = false end
            for _, l in ipairs(boxLines) do l.Visible = false end
            healthBar.Visible = false
            healthBarOutline.Visible = false
            healthBarBG.Visible = false
            nameTag.Visible = false
            distanceTag.Visible = false
            return
@@ -92,85 +95,78 @@ local function addESP(player)
            if part:IsA("BasePart") then
                local pos = Camera:WorldToViewportPoint(part.Position)
                if not minVec then
                    minVec = Vector2.new(pos.X, pos.Y)
                    maxVec = minVec
                    minVec, maxVec = Vector2.new(pos.X,pos.Y), Vector2.new(pos.X,pos.Y)
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
                    lines[i].Visible = false
                    skeletonLines[i].Visible = false
                end
            else
                lines[i].Visible = false
                skeletonLines[i].Visible = false
            end
        end

        -- HealthBar
        -- Health Bar
        if humanoid then
            local healthRatio = humanoid.Health / humanoid.MaxHealth
            local ratio = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
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
            local x = minVec.X - 8

            healthBarBG.From, healthBarBG.To = Vector2.new(x,minVec.Y), Vector2.new(x,maxVec.Y)
            healthBarBG.Visible = true

            healthBar.From = Vector2.new(x,maxVec.Y)
            healthBar.To = Vector2.new(x, maxVec.Y - barHeight * ratio)
            healthBar.Color = Color3.fromRGB(255 - (255*ratio), 255*ratio, 0) -- dégradé vert->rouge
            healthBar.Visible = true
        end

        -- NameTag + Distance
        -- Pseudo
        nameTag.Text = player.Name
        nameTag.Position = Vector2.new(hrpPos.X, minVec.Y - 15)
        nameTag.Visible = true

        local distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) and (hrp.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude or 0
        distanceTag.Text = string.format("[%.0f]", distance)
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

-- ESP pour tous les joueurs
for _, p in ipairs(Players:GetPlayers()) do
    addESP(p)
-- Ajout ESP pour chaque joueur
for _, plr in ipairs(Players:GetPlayers()) do
    addESP(plr)
end
Players.PlayerAdded:Connect(addESP)
