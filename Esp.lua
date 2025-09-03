-- ⚡ ESP COMPLET (LocalScript) ⚡
-- A placer dans StarterPlayerScripts ou dans ton bouton GUI

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local localPlayer = Players.LocalPlayer
local espEnabled = false

-- === UTILITAIRES ===
local function drawLine()
    local line = Drawing.new("Line")
    line.Thickness = 2
    line.Color = Color3.fromRGB(0,255,0)
    return line
end

local function drawBox()
    local box = Drawing.new("Square")
    box.Thickness = 2
    box.Color = Color3.fromRGB(255,0,0)
    box.Filled = false
    return box
end

local function drawText()
    local txt = Drawing.new("Text")
    txt.Size = 15
    txt.Center = true
    txt.Outline = true
    txt.Color = Color3.fromRGB(255,255,255)
    return txt
end

local function drawBar()
    local bar = Drawing.new("Square")
    bar.Thickness = 1
    bar.Color = Color3.fromRGB(0,255,0)
    bar.Filled = true
    return bar
end

-- === CREER ESP POUR UN PLAYER ===
local function createESP(player)
    if player == localPlayer then return end

    local box = drawBox()
    local nameTag = drawText()
    local healthBar = drawBar()

    local bones = {}
    local parts = {"Head","Torso","Left Arm","Right Arm","Left Leg","Right Leg"}
    for i=1,#parts-1 do
        bones[parts[i]] = drawLine()
    end

    local conn
    conn = RunService.RenderStepped:Connect(function()
        if not espEnabled or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            box.Visible = false
            nameTag.Visible = false
            healthBar.Visible = false
            for _,bone in pairs(bones) do bone.Visible = false end
            return
        end

        local hrp = player.Character.HumanoidRootPart
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        local head = player.Character:FindFirstChild("Head")

        if hrp and Camera then
            local pos, onscreen = Camera:WorldToViewportPoint(hrp.Position)
            if onscreen then
                -- Box
                local size = Vector3.new(4,6,0)
                local topLeft = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(-2,3,0))
                local bottomRight = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(-2,-3,0))

                box.Size = Vector2.new(bottomRight.X - topLeft.X, bottomRight.Y - topLeft.Y)
                box.Position = Vector2.new(topLeft.X, topLeft.Y)
                box.Visible = true

                -- Name
                if head then
                    local headPos, hScreen = Camera:WorldToViewportPoint(head.Position + Vector3.new(0,0.5,0))
                    if hScreen then
                        nameTag.Text = player.Name
                        nameTag.Position = Vector2.new(headPos.X, headPos.Y - 15)
                        nameTag.Visible = true
                    end
                end

                -- Health bar
                if humanoid then
                    local healthPercent = humanoid.Health / humanoid.MaxHealth
                    local barHeight = (bottomRight.Y - topLeft.Y) * healthPercent

                    healthBar.Size = Vector2.new(3, barHeight)
                    healthBar.Position = Vector2.new(topLeft.X - 6, bottomRight.Y - barHeight)
                    healthBar.Color = Color3.fromRGB(255*(1-healthPercent),255*healthPercent,0)
                    healthBar.Visible = true
                end

                -- Skeleton (très simplifié)
                local function connectPart(p1,p2)
                    local part1, part2 = player.Character:FindFirstChild(p1), player.Character:FindFirstChild(p2)
                    if part1 and part2 then
                        local p1s, s1 = Camera:WorldToViewportPoint(part1.Position)
                        local p2s, s2 = Camera:WorldToViewportPoint(part2.Position)
                        if s1 and s2 then
                            bones[p1].From = Vector2.new(p1s.X, p1s.Y)
                            bones[p1].To = Vector2.new(p2s.X, p2s.Y)
                            bones[p1].Visible = true
                        end
                    end
                end

                connectPart("Head","Torso")
                connectPart("Left Arm","Torso")
                connectPart("Right Arm","Torso")
                connectPart("Left Leg","Torso")
                connectPart("Right Leg","Torso")

            else
                box.Visible = false
                nameTag.Visible = false
                healthBar.Visible = false
                for _,bone in pairs(bones) do bone.Visible = false end
            end
        end
    end)

    player.AncestryChanged:Connect(function(_,parent)
        if not parent then
            conn:Disconnect()
            box:Remove()
            nameTag:Remove()
            healthBar:Remove()
            for _,bone in pairs(bones) do bone:Remove() end
        end
    end)
end

-- === ACTIVER/DESACTIVER ESP ===
local function enableESP()
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= localPlayer then
            createESP(plr)
        end
    end

    Players.PlayerAdded:Connect(function(plr)
        createESP(plr)
    end)
end
