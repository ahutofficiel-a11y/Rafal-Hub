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
            Title = "Thumbnail",
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

local Section = Window:Section({
    Title = "Informations",
    Icon = "bird",
    Opened = true,
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
            Title = "Cancel",
            Callback = function()
                print("Cancelled!")
            end,
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
