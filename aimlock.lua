-- LocalScript dans StarterPlayerScripts

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local aimlockEnabled = false
local lockedTarget = nil

-- Configuration
local MAX_FOV = 250 -- Distance maximale autour de la souris
local SMOOTHNESS = 0.18 -- 0 = instantané, 1 = très lent

-- Vérifie si une partie du personnage est visible
local function canSee(character)
	local head = character:FindFirstChild("Head")
	if not head then
		return false
	end

	local origin = camera.CFrame.Position
	local direction = head.Position - origin

	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.FilterDescendantsInstances = {
		player.Character
	}

	local result = workspace:Raycast(origin, direction, rayParams)

	if not result then
		return true
	end

	return result.Instance:IsDescendantOf(character)
end

-- Vérifie si le joueur peut être ciblé
local function isValidTarget(otherPlayer)
	if otherPlayer == player then
		return false
	end

	local character = otherPlayer.Character
	if not character then
		return false
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local head = character:FindFirstChild("Head")

	if not humanoid or not head then
		return false
	end

	if humanoid.Health <= 0 then
		return false
	end

	-- Ignore les coéquipiers
	if player.Team and otherPlayer.Team == player.Team then
		return false
	end

	return true
end

-- Trouve la cible la plus proche de la souris
local function getClosestTarget()
	local mousePosition = UserInputService:GetMouseLocation()

	local closestCharacter = nil
	local shortestDistance = MAX_FOV

	for _, otherPlayer in ipairs(Players:GetPlayers()) do
		if isValidTarget(otherPlayer) then
			local character = otherPlayer.Character
			local head = character.Head

			local screenPosition, onScreen =
				camera:WorldToViewportPoint(head.Position)

			if onScreen and screenPosition.Z > 0 then
				local distance = (
					Vector2.new(screenPosition.X, screenPosition.Y)
					- mousePosition
				).Magnitude

				if distance < shortestDistance and canSee(character) then
					shortestDistance = distance
					closestCharacter = character
				end
			end
		end
	end

	return closestCharacter
end

-- Vérifie que la cible actuelle est toujours valide
local function isTargetValid(character)
	if not character then
		return false
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local head = character:FindFirstChild("Head")

	if not humanoid or not head or humanoid.Health <= 0 then
		return false
	end

	if not canSee(character) then
		return false
	end

	return true
end

-- Activation avec clic droit
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		aimlockEnabled = true
		lockedTarget = getClosestTarget()
	end
end)

-- Désactivation avec relâchement du clic droit
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		aimlockEnabled = false
		lockedTarget = nil
	end
end)

-- Boucle de visée
RunService.RenderStepped:Connect(function()
	if not aimlockEnabled then
		return
	end

	-- Cherche une nouvelle cible uniquement si nécessaire
	if not isTargetValid(lockedTarget) then
		lockedTarget = getClosestTarget()
	end

	if not lockedTarget then
		return
	end

	local head = lockedTarget:FindFirstChild("Head")
	if not head then
		lockedTarget = nil
		return
	end

	-- Visée progressive
	local targetCFrame = CFrame.lookAt(
		camera.CFrame.Position,
		head.Position
	)

	camera.CFrame = camera.CFrame:Lerp(
		targetCFrame,
		SMOOTHNESS
	)
end)
