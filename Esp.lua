-- LocalScript à mettre directement dans ton bouton
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Button = script.Parent

local ESPEnabled = false
local Highlights = {}

-- ajoute un ESP à un joueur
local function addESP(player)
	if player == LocalPlayer then return end
	if not player.Character then return end
	if Highlights[player] then return end

	local highlight = Instance.new("Highlight")
	highlight.Adornee = player.Character
	highlight.FillTransparency = 0.7
	highlight.OutlineTransparency = 0
	highlight.FillColor = Color3.fromRGB(255, 0, 0) -- rouge
	highlight.Parent = player.Character

	Highlights[player] = highlight
end

-- supprime un ESP d’un joueur
local function removeESP(player)
	if Highlights[player] then
		Highlights[player]:Destroy()
		Highlights[player] = nil
	end
end

-- active l’ESP
local function enableESP()
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			addESP(player)
		end
	end
end

-- désactive l’ESP
local function disableESP()
	for _, player in ipairs(Players:GetPlayers()) do
		removeESP(player)
	end
end

-- toggle quand on clique sur le bouton
Button.MouseButton1Click:Connect(function()
	ESPEnabled = not ESPEnabled
	if ESPEnabled then
		enableESP()
		print("ESP ON")
	else
		disableESP()
		print("ESP OFF")
	end
end)

-- gère les nouveaux joueurs / respawn
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		if ESPEnabled then
			addESP(player)
		end
	end)
end)
