local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "RAFAL HUB V1",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "RAFAL HUB",
   LoadingSubtitle = "by Anonyme",
   ShowText = "Rayfield", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "neptunecomeback", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Alpha Hub",
      Subtitle = "Key System",
      Note = "Join https://discord.gg/m7Gzcy9tJt", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"AlphaKey1"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local MainTab = Window:CreateTab("Home", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Main")

Rayfield:Notify({
   Title = "Script Executed",
   Content = "Thanks you using rafal hub",
   Duration = 5,
   Image = nil,
})

local Button = MainTab:CreateButton({
   Name = "Infinite Jump",
   Callback = function()
       loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Infinite%20Jump.lua"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "God Mod",
   Callback = function()
       -- Script à placer dans ServerScriptService

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        local humanoid = char:WaitForChild("Humanoid")

        -- Santé infinie
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge

        -- Si tu veux qu’il se soigne en cas de dégâts :
        humanoid.HealthChanged:Connect(function()
            if humanoid.Health < humanoid.MaxHealth then
                humanoid.Health = humanoid.MaxHealth
            end
        end)
    end)
end)

   end,
})

local Button = MainTab:CreateButton({
   Name = "ESP",
   Callback = function()
       loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/WRD%20ESP.lua"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "Noclip",
   Callback = function()
       loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Noclip.lua"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "Give Tools",
   Callback = function()
       loadstring(game:HttpGet("https://pastefy.app/qpbQo0lr/raw"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "Fly",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "Anti-AFK",
   Callback = function()
       loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Focus%20Anti-AFK.lua"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "Infinity Yeld",
   Callback = function()
       loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Infinite%20Yield.lua"))()
   end,
})

local Slider = MainTab:CreateSlider({
   Name = "WalkSpeed slider",
   Range = {16, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
   end,
})

local Slider = MainTab:CreateSlider({
   Name = "JumpPower slider",
   Range = {50, 500},
   Increment = 1,
   Suffix = "Jump",
   CurrentValue = 50,
   Flag = "Slider2", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = (Value)
   end,
})

local Slider = MainTab:CreateSlider({
   Name = "Fov slider",
   Range = {0.5, 999},
   Increment = 1,
   Suffix = "Fov",
   CurrentValue = 15,
   Flag = "Slider3", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Players.CameraMaxZoomDistance = (Value)
   end,
})

local MainTab = Window:CreateTab("Teleport", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Brookhaven Teleport")

local Button = MainTab:CreateButton({
   Name = "Spawn",
   Callback = function()
       local Players = game:GetService("Players")
local player = Players.LocalPlayer

local targetPosition = Vector3.new(0, 10, 0) -- X, Y, Z

local function teleportToCoords(position)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

task.wait(0.1)
teleportToCoords(targetPosition)
   end,
})

local Button = MainTab:CreateButton({
   Name = "Bank",
   Callback = function()
       local Players = game:GetService("Players")
local player = Players.LocalPlayer

local targetPosition = Vector3.new(-5,17,254) -- X, Y, Z

local function teleportToCoords(position)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

task.wait(0.1)
teleportToCoords(targetPosition)
   end,
})

local Button = MainTab:CreateButton({
   Name = "Hopital",
   Callback = function()
       local Players = game:GetService("Players")
local player = Players.LocalPlayer

local targetPosition = Vector3.new(-305,3,27) -- X, Y, Z

local function teleportToCoords(position)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

task.wait(0.1)
teleportToCoords(targetPosition)
   end,
})

local Button = MainTab:CreateButton({
   Name = "Airport",
   Callback = function()
       local Players = game:GetService("Players")
local player = Players.LocalPlayer

local targetPosition = Vector3.new(318,4,44) -- X, Y, Z

local function teleportToCoords(position)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

task.wait(0.1)
teleportToCoords(targetPosition)
   end,
})

local MainSection = MainTab:CreateSection("Maga Obby Teleport")

local Button = MainTab:CreateButton({
   Name = "End",
   Callback = function()
       local Players = game:GetService("Players")
local player = Players.LocalPlayer

local targetPosition = Vector3.new(-1089,536,423) -- X, Y, Z

local function teleportToCoords(position)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

task.wait(0.1)
teleportToCoords(targetPosition)
   end,
})

local MainSection = MainTab:CreateSection("Fun Squid Game! Glass Bridge 2")

local Button = MainTab:CreateButton({
   Name = "End",
   Callback = function()
       local Players = game:GetService("Players")
local player = Players.LocalPlayer

local targetPosition = Vector3.new(-114,14,-1329) -- X, Y, Z

local function teleportToCoords(position)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

task.wait(0.1)
teleportToCoords(targetPosition)
   end,
})

local MainTab = Window:CreateTab("ACS Killer", nil) -- Title, Image
local MainSection = MainTab:CreateSection("ACS 1.7.5 and ACS 2.0.1")

local Button = MainTab:CreateButton({
   Name = "ACS Killer",
   Callback = function()
       loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/751c7de617925e07d7f749cf3b359d85.lua"))()
   end,
})

local MainTab = Window:CreateTab("Bypass", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Stop Anti-Cheat")

local Button = MainTab:CreateButton({
   Name = "STOP ADONIS ANTI-CHEAT",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/e1998ee/adonisb1p3ss/refs/heads/main/NeptuneScripts"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "ANTI-KICK [BÊTA]",
   Callback = function()
        local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

LocalPlayer.OnKick:Connect(function(message)
    warn("Tentative de kick détectée : " .. message)
end)

   end,
})

local Button = MainTab:CreateButton({
   Name = "Bypass Voice Chat",
   Callback = function()
       lgame:GetService("VoiceChatService"):joinVoice()
   end,
})
