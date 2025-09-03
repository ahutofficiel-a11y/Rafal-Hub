-- Place ce script dans StarterPlayerScripts
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Fonction pour ajouter un ESP (Highlight + pseudo)
local function addESP(player)
    if player ~= LocalPlayer then
        local function onCharacterAdded(character)
            -- Supprimer les anciens ESP si déjà présents
            if character:FindFirstChild("AdminESP") then
                character.AdminESP:Destroy()
            end
            if character:FindFirstChild("NameTag") then
                character.NameTag:Destroy()
            end

            -- Highlight (contour lumineux)
            local highlight = Instance.new("Highlight")
            highlight.Name = "AdminESP"
            highlight.Parent = character
            highlight.Adornee = character
            highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Vert
            highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
            highlight.FillTransparency = 0.5

            -- BillboardGui pour le pseudo
            local head = character:WaitForChild("Head", 5)
            if head then
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "NameTag"
                billboard.Parent = head
                billboard.Adornee = head
                billboard.Size = UDim2.new(0, 200, 0, 50)
                billboard.StudsOffset = Vector3.new(0, 2, 0)
                billboard.AlwaysOnTop = true

                local textLabel = Instance.new("TextLabel")
                textLabel.Parent = billboard
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.Text = player.Name
                textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                textLabel.TextStrokeTransparency = 0
                textLabel.TextScaled = true
                textLabel.Font = Enum.Font.SourceSansBold
            end
        end

        -- Si le joueur a déjà un perso
        if player.Character then
            onCharacterAdded(player.Character)
        end

        -- Quand le joueur respawn
        player.CharacterAdded:Connect(onCharacterAdded)
    end
end

-- Ajoute ESP aux joueurs déjà présents
for _, player in ipairs(Players:GetPlayers()) do
    addESP(player)
end

-- Pour les nouveaux joueurs
Players.PlayerAdded:Connect(function(player)
    addESP(player)
end)
