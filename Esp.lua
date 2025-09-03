-- ESP COMPLET — LocalScript à mettre dans ton TextButton
-- Clique sur le bouton = active/désactive ESP
-- Le texte du bouton NE CHANGE PAS

local Players = game:GetService("Players")

local localPlayer = Players.LocalPlayer
local button = script.Parent
local playerConns = {}
local espEnabled = false

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

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Name = "Name"
	nameLabel.BackgroundTransparency = 1
	nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextScaled = true
	nameLabel.TextColor3 = Color3.new(1,1,1)
	nameLabel.TextStrokeTransparency = 0.5
	nameLabel.Text = player.Name
	nameLabel.Parent = billboard

	local barBg = Instance.new("Frame")
	barBg.BackgroundColor3 = Color3.fromRGB(30,30,30)
	barBg.BorderSizePixel = 0
	barBg.Size = UDim2.new(1, 0, 0.4, 0)
	barBg.Position = UDim2.new(0, 0, 0.6, 0)
	barBg.Parent = billboard

	local barFill = Instance.new("Frame")
	barFill.BackgroundColor3 = Color3.fromRGB(0,255,0)
	barFill.BorderSizePixel = 0
	barFill.Size = UDim2.new(1, 0, 1, 0)
	barFill.Parent = barBg

	local function updateHealth()
		if humanoid then
			local hp = math.max(humanoid.Health, 0)
			local maxhp = math.max(humanoid.MaxHealth, 1)
			local t = hp / maxhp
			barFill.Size = UDim2.new(t, 0, 1, 0)
			barFill.BackgroundColor3 = colorLerpRGB(255,0,0, 0,255,0, t)
		end
	end

	if humanoid then
		updateHealth()
		humanoid.HealthChanged:Connect(updateHealth)
	end
end

local function makeHighlightAndBox(character, parentFolder)
	local hl = Instance.new("Highlight")
	hl.FillTransparency = 1
	hl.OutlineColor = Color3.fromRGB(255, 70, 70)
	hl.Adornee = character
	hl.Parent = parentFolder

	local box = Instance.new("SelectionBox")
	box.LineThickness = 0.04
	box.SurfaceTransparency = 1
	box.Color3 = Color3.fromRGB(255, 0, 0)
	box.Adornee = character
	box.Parent = parentFolder
end

local function buildSkeleton(character, parentFolder)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	local list
	if humanoid.RigType == Enum.HumanoidRigType.R15 then
		list = {
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
	else
		list = {
			{"Head","Torso"},
			{"Torso","Left Arm"},
			{"Torso","Right Arm"},
			{"Torso","Left Leg"},
			{"Torso","Right Leg"},
		}
	end

	for _,pair in ipairs(list) do
		local a = character:FindFirstChild(pair[1])
		local b = character:FindFirstChild(pair[2])
		if a and b then
			makeBeam(a, b, parentFolder)
		end
	end
end

local function attachESP(player, character)
	local espFolder = Instance.new("Folder")
	espFolder.Name = "ESP_Attachments"
	espFolder.Parent = character

	makeHighlightAndBox(character, espFolder)
	buildSkeleton(character, espFolder)
	makeHealthBillboard(character, player, espFolder)
end

local function removeESP(character)
	if character and character:FindFirstChild("ESP_Attachments") then
		character.ESP_Attachments:Destroy()
	end
end

local function enableForPlayer(plr)
	if plr == localPlayer then return end
	local function onChar(char)
		task.wait(0.2)
		if espEnabled then
			attachESP(plr, char)
		end
	end
	if plr.Character then onChar(plr.Character) end
	playerConns[plr] = {
		plr.CharacterAdded:Connect(onChar),
		plr.CharacterRemoving:Connect(removeESP)
	}
end

local function disableForPlayer(plr)
	if playerConns[plr] then
		for _,c in ipairs(playerConns[plr]) do
			if c.Connected then c:Disconnect() end
		end
		playerConns[plr] = nil
	end
	removeESP(plr.Character)
end

local function enableESP()
	for _,plr in ipairs(Players:GetPlayers()) do
		enableForPlayer(plr)
	end
	playerConns["_global"] = {
		Players.PlayerAdded:Connect(enableForPlayer),
		Players.PlayerRemoving:Connect(disableForPlayer)
	}
end

local function disableESP()
	for _,plr in ipairs(Players:GetPlayers()) do
		disableForPlayer(plr)
	end
	if playerConns["_global"] then
		for _,c in ipairs(playerConns["_global"]) do
			if c.Connected then c:Disconnect() end
		end
		playerConns["_global"] = nil
	end
end

-- === Toggle avec le bouton (sans changer le texte du bouton)
button.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	if espEnabled then
		enableESP()
	else
		disableESP()
	end
end)
