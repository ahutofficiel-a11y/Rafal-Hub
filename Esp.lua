-- ESP COMPLET — LocalScript à mettre DANS ton TextButton (le bouton déjà créé)
-- Toggle ON/OFF à chaque clic

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local button = script.Parent  -- ton TextButton
local espEnabled = false

-- Stocke les connexions pour pouvoir nettoyer
local playerConns = {}

-- ========= UTILITAIRES =========

local function lerp(a, b, t) return a + (b - a) * t end
local function colorLerpRGB(r1,g1,b1, r2,g2,b2, t)
	return Color3.fromRGB(
		math.floor(lerp(r1, r2, t)),
		math.floor(lerp(g1, g2, t)),
		math.floor(lerp(b1, b2, t))
	)
end

local function ensureAttachment(part)
	if not part then return nil end
	local att = part:FindFirstChild("ESP_Attach")
	if not att then
		att = Instance.new("Attachment")
		att.Name = "ESP_Attach"
		att.Parent = part
	end
	return att
end

-- Crée un Beam (ligne 3D) entre 2 parties
local function makeBeam(part0, part1, parentFolder)
	if not (part0 and part1) then return nil end
	local a0 = ensureAttachment(part0)
	local a1 = ensureAttachment(part1)
	if not (a0 and a1) then return nil end

	local beam = Instance.new("Beam")
	beam.Name = "ESP_Beam"
	beam.Attachment0 = a0
	beam.Attachment1 = a1
	beam.Width0 = 0.05
	beam.Width1 = 0.05
	beam.FaceCamera = true
	beam.Color = ColorSequence.new(Color3.fromRGB(0,255,0))
	beam.Transparency = NumberSequence.new(0.15)
	beam.LightInfluence = 0
	beam.Parent = parentFolder
	return beam
end

local function makeHealthBillboard(character, player, parentFolder)
	local head = character:FindFirstChild("Head")
	if not head then return nil end

	local humanoid = character:FindFirstChildOfClass("Humanoid")

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "ESP_Billboard"
	billboard.Adornee = head
	billboard.AlwaysOnTop = true
	billboard.ExtentsOffset = Vector3.new(0, 1.5, 0)
	billboard.Size = UDim2.new(0, 140, 0, 36)
	billboard.MaxDistance = 200
	billboard.Parent = parentFolder

	-- Nom
	local nameLabel = Instance.new("TextLabel")
	nameLabel.Name = "Name"
	nameLabel.BackgroundTransparency = 1
	nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
	nameLabel.Position = UDim2.new(0, 0, 0, 0)
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextScaled = true
	nameLabel.TextColor3 = Color3.new(1,1,1)
	nameLabel.TextStrokeTransparency = 0.5
	nameLabel.Text = (player.DisplayName and #player.DisplayName>0) and player.DisplayName or player.Name
	nameLabel.Parent = billboard

	-- Barre de vie (fond)
	local barBg = Instance.new("Frame")
	barBg.Name = "BarBg"
	barBg.BackgroundColor3 = Color3.fromRGB(30,30,30)
	barBg.BackgroundTransparency = 0.2
	barBg.BorderSizePixel = 0
	barBg.Size = UDim2.new(1, 0, 0.4, 0)
	barBg.Position = UDim2.new(0, 0, 0.6, 0)
	barBg.Parent = billboard

	-- Barre de vie (remplissage)
	local barFill = Instance.new("Frame")
	barFill.Name = "BarFill"
	barFill.BackgroundColor3 = Color3.fromRGB(0,255,0)
	barFill.BorderSizePixel = 0
	barFill.Size = UDim2.new(1, 0, 1, 0)
	barFill.Parent = barBg

	-- Masque arrondi léger
	for _,f in ipairs({barBg, barFill}) do
		local ui = Instance.new("UICorner")
		ui.CornerRadius = UDim.new(0, 4)
		ui.Parent = f
	end

	-- Met à jour la barre
	local function updateHealth()
		if not humanoid then return end
		local hp = math.max(humanoid.Health, 0)
		local maxhp = math.max(humanoid.MaxHealth, 1)
		local t = hp / maxhp
		barFill.Size = UDim2.new(t, 0, 1, 0)
		-- Vert -> Rouge
		barFill.BackgroundColor3 = colorLerpRGB(255,0,0, 0,255,0, t)
		nameLabel.Text = string.format("%s - %d HP", nameLabel.Text:match("^[^%-]+") or player.Name, math.floor(hp))
	end

	if humanoid then
		updateHealth()
		humanoid.HealthChanged:Connect(updateHealth)
		-- Si MaxHealth change (certains jeux), on rafraîchit
		humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(updateHealth)
	end

	return billboard
end

local function makeHighlightAndBox(character, parentFolder)
	-- Highlight (contour “officiel” Roblox)
	local hl = Instance.new("Highlight")
	hl.Name = "ESP_Highlight"
	hl.FillTransparency = 1
	hl.OutlineColor = Color3.fromRGB(255, 70, 70)
	hl.OutlineTransparency = 0
	hl.Adornee = character
	hl.Parent = parentFolder

	-- Box (boîte englobante)
	local box = Instance.new("SelectionBox")
	box.Name = "ESP_Box"
	box.LineThickness = 0.04
	box.SurfaceTransparency = 1
	box.Color3 = Color3.fromRGB(255, 0, 0)
	box.Adornee = character
	box.Parent = parentFolder

	return hl, box
end

local function buildSkeleton(character, parentFolder)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	local isR15 = humanoid.RigType == Enum.HumanoidRigType.R15

	local pairsR6 = {
		{"Head","Torso"},
		{"Torso","Left Arm"},
		{"Torso","Right Arm"},
		{"Torso","Left Leg"},
		{"Torso","Right Leg"},
	}

	local pairsR15 = {
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

	local bonesFolder = Instance.new("Folder")
	bonesFolder.Name = "ESP_Bones"
	bonesFolder.Parent = parentFolder

	local list = isR15 and pairsR15 or pairsR6
	for _,pair in ipairs(list) do
		local a = character:FindFirstChild(pair[1])
		local b = character:FindFirstChild(pair[2])
		if a and b then
			makeBeam(a, b, bonesFolder)
		end
	end

	return bonesFolder
end

-- Crée/attache tout l’ESP sur un Character
local function attachESPToCharacter(player, character)
	-- Dossier pour tout retrouver/cleaner facilement
	local espFolder = Instance.new("Folder")
	espFolder.Name = "ESP_Attachments"
	espFolder.Parent = character

	makeHighlightAndBox(character, espFolder)
	buildSkeleton(character, espFolder)
	makeHealthBillboard(character, player, espFolder)
end

local function removeESPFromCharacter(character)
	if not character then return end
	local f = character:FindFirstChild("ESP_Attachments")
	if f then f:Destroy() end
	-- Supprime aussi les Attachments ajoutés
	for _,part in ipairs(character:GetDescendants()) do
		if part:IsA("Attachment") and part.Name == "ESP_Attach" then
			part:Destroy()
		end
	end
end

local function enableForPlayer(plr)
	if plr == localPlayer then return end

	local conns = {}
	playerConns[plr] = conns

	-- Quand le character spawn
	local function onChar(char)
		if not espEnabled then return end
		-- Petite attente pour que les parties existent
		task.wait(0.2)
		attachESPToCharacter(plr, char)
	end

	-- Déjà présent ?
	if plr.Character then onChar(plr.Character) end
	table.insert(conns, plr.CharacterAdded:Connect(onChar))
	table.insert(conns, plr.CharacterRemoving:Connect(function(char)
		removeESPFromCharacter(char)
	end))
end

local function disableForPlayer(plr)
	-- Nettoie connexions
	if playerConns[plr] then
		for _,c in ipairs(playerConns[plr]) do
			if c.Connected then c:Disconnect() end
		end
		playerConns[plr] = nil
	end
	-- Nettoie visuel
	if plr.Character then
		removeESPFromCharacter(plr.Character)
	end
end

local function enableESP()
	-- Pour tous les joueurs actuels
	for _,plr in ipairs(Players:GetPlayers()) do
		enableForPlayer(plr)
	end
	-- Pour les prochains
	playerConns["_players"] = {
		Players.PlayerAdded:Connect(enableForPlayer),
		Players.PlayerRemoving:Connect(function(plr)
			disableForPlayer(plr)
		end),
	}
end

local function disableESP()
	-- Retire pour tous
	for _,plr in ipairs(Players:GetPlayers()) do
		disableForPlayer(plr)
	end
	-- Retire listeners globaux
	if playerConns["_players"] then
		for _,c in ipairs(playerConns["_players"]) do
			if c.Connected then c:Disconnect() end
		end
		playerConns["_players"] = nil
	end
end

-- ========= TOGGLE BOUTON =========
local function setButton(on)
	if on then
		button.Text = "ESP ON"
		button.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
	else
		button.Text = "ESP OFF"
		button.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
	end
end

setButton(false)

button.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	if espEnabled then
		enableESP()
	else
		disableESP()
	end
	setButton(espEnabled)
end)
