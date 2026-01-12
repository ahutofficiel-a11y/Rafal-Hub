local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:AddTheme({
    Name = "Cacahuète theme", -- theme name
    
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
    Author = "by Cacahuète and Thomas",
    Folder = "AplhaHubV2",
    
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
    Title = "v2.0.0",
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
    Title = "Aimlock",
    Desc = "Aimlock for all games",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ahutofficiel-a11y/Rafal-Hub/refs/heads/main/aimlock.lua"))()
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
    Title = "Aimbot",
    Desc = "Aimbot for all games",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/new-gugus/aimbot-neptune/refs/heads/main/aimbot.lua", true))()
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

local Button = Tab:Button({
    Title = "ACS Killer",
    Desc = "ACS Killer for only game have ACS A.7.5 or 2.0.1",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/6203d711b7531ea5ce99f5877762ec82.lua"))()
    end
})

local Button = Tab:Button({
    Title = "Bueno HUB",
    Desc = "For Secours de France and others games",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://api.junkie-development.de/api/v1/luascripts/public/aed6581ff321a1e49a3413109a9fcba9da62f43863dbf6fb8e63045803d4ab63/download"))()
    end
})

local Tab = Window:Tab({
    Title = "Games",
    Icon = "bird", -- optional
    Locked = false,
})

local Button = Tab:Button({
    Title = "Secours de France RP",
    Desc = "Only for Secours de France RP V.6 (soon)",
    Locked = false,
    Callback = function()
        print("Secours de France soon...")
    end
})

local Button = Tab:Button({
    Title = "School RP FR Shibuya",
    Desc = "Key : omegal",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/omega-scriptt/SchoolRp-fr/refs/heads/main/SCHOOLRP%23FR%20OMEGA.txt"))() 
    end
})

local Button = Tab:Button({
    Title = "Site 43",
    Desc = "no't work for xeno and solara",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/e1998a/Site-43/refs/heads/main/Neptune%20Scripts"))()
    end
})

local Button = Tab:Button({
    Title = "Brookhaven",
    Desc = "Brookhaven best cheat",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/as6cd0/SP_Hub/refs/heads/main/Brookhaven"))()
    end
})

local Button = Tab:Button({
    Title = "Strasbourg",
    Desc = "Devenir criminel (recherché par la police)",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fire-all-remote-events-77205"))()
    end
})

local Tab = Window:Tab({
    Title = "Bypass",
    Icon = "bird", -- optional
    Locked = false,
})

local Button = Tab:Button({
    Title = "Bypass Secours De France",
    Desc = "Bypass leur anti-cheat de merde",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/39e160959d68c457f1979d3f249897eb.lua"))()
    end
})

local Button = Tab:Button({
    Title = "Bypass Adonis",
    Desc = "Bypass leur anti-cheat de merde",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/e1998ee/adonisb1p3ss/refs/heads/main/NeptuneScripts"))()
    end
})

local Button = Tab:Button({
    Title = "Bypass Voice Chat",
    Desc = "Bypass leur anti-ban voice de merde",
    Locked = false,
    Callback = function()
        game:GetService("VoiceChatService"):joinVoice()
    end
})
