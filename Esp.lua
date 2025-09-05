-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

-- Variables
local ESPEnabled = false
local ESPObjects = {}

-- === UI Toggle ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ESP_UI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local button = Instance.new("TextButton")
button.Size = UDim2.fromOffset(100, 40)
button.Position = UDim2.new(0.5, -50, 1, -70)
button.Text = "ESP"
button.Font = Enum.Font.GothamBold
button.TextSize = 20
button.BackgroundColor3 = Color3.fromRGB(120, 30, 30) -- OFF = rouge
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Parent = screenGui

local corner = Instance.new("UICorner", button)
corner.CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", button)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(255, 0, 0)

-- === Utilitaires ===
local function getTeamColor(player)
	if player.Team and localPlayer.Team then
		if player.Team == localPlayer.Team then
			return Color3.fromRGB(0, 150, 255) -- allié
		else
			return Color3.fromRGB(255, 80, 80) -- ennemi
		end
	end
	return Color3.fromRGB(80, 255, 80) -- neutre
end

-- === Création ESP ===
local function createESP(player)
	if player == localPlayer then return end
	if ESPObjects[player] then return end
	if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end

	local char = player.Character
	local hrp = char:WaitForChild("HumanoidRootPart")

	local espFolder = Instance.new("Folder")
	espFolder.Name = "ESP_" .. player.Name
	espFolder.Parent = char
	ESPObjects[player] = espFolder

	-- Box contour (wireframe)
	local box = Instance.new("BoxHandleAdornment")
	box.Adornee = hrp
	box.AlwaysOnTop = true
	box.ZIndex = 5
	box.Transparency = 0
	box.Color3 = getTeamColor(player)
	box.Wireframe = true
	box.Size = Vector3.new(4, 6, 2)
	box.Parent = espFolder

	-- Pseudo
	local nameGui = Instance.new("BillboardGui")
	nameGui.Size = UDim2.fromOffset(200, 40)
	nameGui.AlwaysOnTop = true
	nameGui.StudsOffset = Vector3.new(0, 3, 0)
	nameGui.Adornee = hrp
	nameGui.Parent = espFolder

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.fromScale(1, 1)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextScaled = true
	nameLabel.TextStrokeTransparency = 0
	nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	nameLabel.Text = player.Name
	nameLabel.TextColor3 = getTeamColor(player)
	nameLabel.Parent = nameGui

	-- Distance
	local distGui = Instance.new("BillboardGui")
	distGui.Size = UDim2.fromOffset(200, 30)
	distGui.AlwaysOnTop = true
	distGui.StudsOffset = Vector3.new(0, -3, 0)
	distGui.Adornee = hrp
	distGui.Parent = espFolder

	local distLabel = Instance.new("TextLabel")
	distLabel.Size = UDim2.fromScale(1, 1)
	distLabel.BackgroundTransparency = 1
	distLabel.Font = Enum.Font.GothamSemibold
	distLabel.TextScaled = true
	distLabel.TextStrokeTransparency = 0
	distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	distLabel.TextColor3 = getTeamColor(player)
	distLabel.Parent = distGui

	-- Update dynamique
	ESPObjects[player].Conn = RunService.RenderStepped:Connect(function()
		if not char.Parent then return end
		local localHRP = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not localHRP then return end

		-- Distance
		local dist = (localHRP.Position - hrp.Position).Magnitude
		distLabel.Text = string.format("[%dm]", math.floor(dist))

		-- Taille box
		local cf, size = char:GetBoundingBox()
		box.CFrame = cf
		box.Size = size + Vector3.new(0.3, 0.3, 0.3)

		-- Couleur
		local col = getTeamColor(player)
		nameLabel.TextColor3 = col
		distLabel.TextColor3 = col
		box.Color3 = col
	end)
end

-- === Suppression ESP ===
local function removeESP(player)
	if ESPObjects[player] then
		if ESPObjects[player].Conn then
			ESPObjects[player].Conn:Disconnect()
		end
		ESPObjects[player]:Destroy()
		ESPObjects[player] = nil
	end
end

-- === Activation ===
local function enableESP()
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= localPlayer then
			createESP(plr)
			plr.CharacterAdded:Connect(function()
				if ESPEnabled then createESP(plr) end
			end)
		end
	end
end

-- === Désactivation ===
local function disableESP()
	for plr in pairs(ESPObjects) do
		removeESP(plr)
	end
end

-- === Toggle bouton ===
button.MouseButton1Click:Connect(function()
	ESPEnabled = not ESPEnabled
	if ESPEnabled then
		enableESP()
		button.BackgroundColor3 = Color3.fromRGB(30, 120, 30) -- ON = vert
		stroke.Color = Color3.fromRGB(0, 255, 0)
	else
		disableESP()
		button.BackgroundColor3 = Color3.fromRGB(120, 30, 30) -- OFF = rouge
		stroke.Color = Color3.fromRGB(255, 0, 0)
	end
end)
