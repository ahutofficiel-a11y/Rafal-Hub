local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:AddTheme({
    Name = "normal theme", -- theme name
    
    Accent = Color3.fromHex("#18181b"),
    Background = Color3.fromHex("#101010"), -- Accent
    Outline = Color3.fromHex("#FFFFFF"),
    Text = Color3.fromHex("#FFFFFF"),
    Placeholder = Color3.fromHex("#7a7a7a"),
    Button = Color3.fromHex("#52525b"),
    Icon = Color3.fromHex("#a1a1aa"),
})

local Window = WindUI:CreateWindow({
    Title = "Alpha Hub V.2",
    Icon = "door-open", -- lucide icon
    Author = "by random",
    Folder = "ValmoriaV2",
    
    -- ↓ This all is Optional. You can remove it.
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    
    -- ↓ Optional. You can remove it.
    --[[ You can set 'rbxassetid://' or video to Background.
        'rbxassetid://':
            Background = "rbxassetid://", -- rbxassetid
        Video:
            Background = "video:YOUR-RAW-LINK-TO-VIDEO.webm", -- video 
    --]]
    
    -- ↓ Optional. You can remove it.
    User = {
        Enabled = true,
        Anonymous = true,
        Callback = function()
            print("clicked")
        end,
    },
    
    --       remove this all, 
    -- !  ↓  if you DON'T need the key system
    KeySystem = { 
        -- ↓ Optional. You can remove it.
        Key = { "AlphaHubKey1" },
        
        Note = "key system",
        
        -- ↓ Optional. You can remove it.
        Thumbnail = {
            Image = "rbxassetid://",
            Title = "Alpha Hub",
        },
        
        -- ↓ Optional. You can remove it.
        URL = "https://discord.gg/xcuerzrYXj",
        
        -- ↓ Optional. You can remove it.
        SaveKey = true, -- automatically save and load the key.
        
        -- ↓ Optional. You can remove it.
        -- API = {} ← Services. Read about it below ↓
    },
})

local Tab = Window:Tab({
    Title = "Basic",
    Icon = "bird", -- optional
    Locked = false,
})

local Dialog = Window:Dialog({
    Icon = "bird",
    Title = "All cheat basic",
    Content = "Hi, my cheat is open for everyone, good cheat for everyone !!!",
    Buttons = {
        {
            Title = "Confirm",
            Callback = function()
                print("Confirmed!")
            end,
        },
        {
        },
    },
})

Window:Tag({
    Title = "v1.0.0",
    Icon = "github",
    Color = Color3.fromHex("#30ff6a"),
    Radius = 0, -- from 0 to 13
})

Window:Tag({
    Title = "undetect",
    Icon = "github",
    Color = Color3.fromHex("#30ff6a"),
    Radius = 0, -- from 0 to 13
})

WindUI:Notify({
    Title = "Welcome",
    Content = "Thanks for using Alpha Hub",
    Duration = 3, -- 3 seconds
    Icon = "bird",
})

local Slider = Tab:Slider({
    Title = "WalkSpeed",
    Desc = "Change you speed of walk",
    
    -- To make float number supported, 
    -- make the Step a float number.
    -- example: Step = 0.1
    Step = 1,
    Value = {
        Min = 16,
        Max = 300,
        Default = 16,
    },
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
    end
})

local Slider = Tab:Slider({
    Title = "JumpPower",
    Desc = "Change you jumpPower",
    
    -- To make float number supported, 
    -- make the Step a float number.
    -- example: Step = 0.1
    Step = 1,
    Value = {
        Min = 50,
        Max = 500,
        Default = 50,
    },
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = (Value)
    end
})

local Button = Tab:Button({
    Title = "Infinite Jump",
    Desc = "Infinite Jump !!!!!!!!!!!!",
    Locked = false,
    Callback = function()
         loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Infinite%20Jump.lua"))()
    end
})

local Button = Tab:Button({
    Title = "Staff in service",
    Desc = "Notify you",
    Locked = false,
    Callback = function()
         local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")

local staffTeam = Teams:WaitForChild("STAFF")

------------------------------------------------
-- Création GUI
------------------------------------------------

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "StaffDetectorGUI"
gui.Parent = player:WaitForChild("PlayerGui")

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0,300,0,50)
label.Position = UDim2.new(0.5,-150,0,20)
label.BackgroundColor3 = Color3.fromRGB(25,25,25)
label.TextColor3 = Color3.fromRGB(255,170,0)
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.Parent = gui

------------------------------------------------
-- Son
------------------------------------------------

local alertSound = Instance.new("Sound")
alertSound.SoundId = "rbxassetid://9118823101"
alertSound.Volume = 1
alertSound.Parent = SoundService

------------------------------------------------
-- Fonctions
------------------------------------------------

local function getStaffCount()
	local count = 0
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr.Team == staffTeam then
			count += 1
		end
	end
	return count
end

local previousCount = getStaffCount()

local function updateGUI()
	local count = getStaffCount()

	label.Text = "STAFF en ligne : "..count

	if count > 0 then
		label.TextColor3 = Color3.fromRGB(0,255,0)
	else
		label.TextColor3 = Color3.fromRGB(255,0,0)
	end

	-- Si un staff vient d'arriver
	if count > previousCount then
		alertSound:Play()

		StarterGui:SetCore("SendNotification", {
			Title = "STAFF Détecté",
			Text = "Un membre du STAFF vient de rejoindre !",
			Duration = 4
		})
	end

	previousCount = count
end

------------------------------------------------
-- Events
------------------------------------------------

updateGUI()

Players.PlayerAdded:Connect(function()
	wait(1)
	updateGUI()
end)

Players.PlayerRemoving:Connect(function()
	wait(1)
	updateGUI()
end)

for _, plr in ipairs(Players:GetPlayers()) do
	plr:GetPropertyChangedSignal("Team"):Connect(updateGUI)
end

Players.PlayerAdded:Connect(function(plr)
	plr:GetPropertyChangedSignal("Team"):Connect(updateGUI)
end)
    end
})

local Button = Tab:Button({
    Title = "Givetools",
    Desc = "Givetools pour tous les jeux",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/new-gugus/NeptuneScripts/main/Givetools.lua"))()
    end
})

local Button = Tab:Button({
    Title = "Fly",
    Desc = "Fly for all games",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
    end
})

local Button = Tab:Button({
    Title = "Anti-Afk",
    Desc = "Anti-Afk for all games",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Focus%20Anti-AFK.lua"))()
    end
})

local Button = Tab:Button({
    Title = "ESP",
    Desc = "ESP for all games",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ahutofficiel-a11y/Rafal-Hub/refs/heads/main/Esp.lua"))()
    end
})

local Button = Tab:Button({
    Title = "Private Server",
    Desc = "Private Server for everyone",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/PrivateServer"))
    end
})

local Tab = Window:Tab({
    Title = "Others menu",
    Icon = "bird", -- optional
    Locked = false,
})

local Button = Tab:Button({
    Title = "Infinity Yeld",
    Desc = "CMD for all games",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Infinite%20Yield.lua"))()
    end
})

local Button = Tab:Button({
    Title = "Car Mods",
    Desc = "Mods you cars for all games",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Documantation12/Universal-Vehicle-Script/main/Main.lua'))()
    end
})

local Tab = Window:Tab({
    Title = "Bypass",
    Icon = "bird", -- optional
    Locked = false,
})

local Button = Tab:Button({
    Title = "Bypass Adonis",
    Desc = "Bypass leur anti-cheat de merde",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/e1998ee/adonisb1p3ss/refs/heads/main/NeptuneScripts"))()
    end
})
