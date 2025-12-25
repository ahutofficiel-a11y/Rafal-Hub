

local Loaded_Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Loaded_Rayfield:CreateWindow({
    LoadingTitle = "Alpha Hub",
    Name = "NexHub - Noweye [RP/FR]",
    Discord = {
        Enabled = false,
        RememberJoins = true,
        Invite = "noinvitelink",
    },
    KeySystem = false,
    LoadingSubtitle = "by Alpha Hub",
    Theme = "Black",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = "NexHub",
        FileName = "NexHubConfig",
    },
})
local Exploit = Window:CreateTab("Exploit", "swords")
local Local_Player = Window:CreateTab("Local Player", "user")
local ESP = Window:CreateTab("ESP", "eye")
Exploit:CreateSection("Mass Destruction")
Exploit:CreateButton({
    Callback = function(p1_0, p2_0, p3_0, p4_0)
        for i_3, v_3 in pairs(Players:GetPlayers()) do
        error("[string \"DHmjGY\"]: attempt to index function with 'Destroy'")
        end
    end,
    Name = "Kill All",
    Icon = "zap",
})
local _ = Exploit:CreateToggle({
    Name = "Kill All Loop",
    CurrentValue = false,
    Callback = function(p1_0, p2_0)
        local var31 = p1_0[1];
        local var32 = (var31 and 2520438); -- 2520438
        local var33 = (var32 or function()--[[function ignored]]end);
        local Spawned = task.spawn(function(p1_0, p2_0, p3_0, p4_0, p5_0)
            error("[string \"DHmjGY\"]: attempt to index function with 'Destroy'")
        end);
    end,
    Icon = "repeat",
    Flag = "KillAllLoop",
})
Exploit:CreateSection("Targeting")
local Players = game.Players
for i, v in pairs(Players:GetPlayers()) do
    local _ = ((i and 10494371); -- 10494371 or function()--[[function ignored]]end)
    local LocalPlayer = Players.LocalPlayer
    local _ = (v ~= LocalPlayer)
    -- true, eq id 1
    local Name = v.Name
end
local Dropdown = Exploit:CreateDropdown({
    Callback = function(p1_0, p2_0)
        local var34 = p1_0[1]
        -- true, eq id 3
        local _ = (((type(var34) == "table") and 3413852); -- 3413852 or 11628206)
        local _ = ((var34 and 10901855); -- 10901855 or function()--[[function ignored]]end)
        local Humanoid = var34:FindFirstChild("Humanoid")
        local var41 = (Humanoid and 14329401); -- 14329401
        local var42 = (var41 or function()--[[function ignored]]end)
        var34.Humanoid.PlatformStand = false
    end,
    Name = "Select Player",
    CurrentOption = {
        "",
    },
    Flag = "PlayerDropdown",
    MultipleOptions = false,
    Icon = "crosshair",
    Options = {
        Name,
    },
})
local _ = Exploit:CreateButton({
    Callback = function()
        local Refresh = Dropdown.Refresh;
        local Players_11 = game.Players;
        local Players_12 = Players:GetPlayers();
        for i_4, v_4 in pairs(Players_12) do
            local var41 = (i_4 and 10494371); -- 10494371
            local var42 = (var41 or function()--[[function ignored]]end);
            local Players_13 = game.Players;
            local LocalPlayer_5 = Players.LocalPlayer;
            local var43 = (v_4 ~= LocalPlayer);
            -- true, eq id 4
            local Name_3 = v_4.Name;
            local Array = {};
            local var44 = table.insert(Array, Name_3);
        end
        local Refresh_2 = Dropdown:Refresh(Array, true);
    end,
    Name = "Refresh Player List",
    Icon = "refresh-cw",
})
Exploit:CreateButton({
    Callback = function(p1_0, p2_0, p3_0, p4_0, p5_0)
        Loaded_Rayfield:Notify({
            Image = "alert-circle",
            Duration = 3,
            Title = "Error",
            Content = "No player selected!",
        })
    end,
    Name = "Kill Selected Player",
    Icon = "target",
})
local Button1Down = LocalPlayer:GetMouse().Button1Down
Button1Down:Connect(function(p1_0, p2_0, p3_0)
end)
Exploit:CreateToggle({
    Name = "Click to Kill",
    CurrentValue = false,
    Callback = function(p1_0, p2_0, p3_0, p4_0)
    end,
    Icon = "mouse-pointer-2",
    Flag = "ClickToKill",
})
Exploit:CreateSection("Give Role")
local _ = Exploit:CreateDropdown({
    Callback = function(p1_0, p2_0, p3_0, p4_0, p5_0)
        local var48 = p1_0[1];
        local var49 = type(var48);
        local var49_eq_string = (var49 == "table");
        -- true, eq id 5
        local var50 = (var49_eq_string and 7592280); -- 7592280
        local var51 = (var50 or 11914045);
        local var52 = var48[1];
        local var53 = (var52 and 16287381); -- 16287381
    end,
    Name = "Select Role",
    CurrentOption = {
        "GI_GIGN",
    },
    Flag = "RoleDropdown",
    MultipleOptions = false,
    Icon = "badge",
    Options = {
        "GI_GIGN",
        "AG_Agriculteur",
        "BM_Brav'M",
    },
})
Exploit:CreateButton({
    Callback = function(p1_0, p2_0, p3_0)
        error("[string \"DHmjGY\"]: attempt to index function with 'Destroy'")
    end,
    Name = "Give Role",
    Icon = "user-plus",
})
Exploit:CreateSection("Escape")
local _ = Exploit:CreateButton({
    Callback = function(p1_0, p2_0)
        local Players_14 = game.Players;
        local LocalPlayer_6 = Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local Not_Character = not Character;
        -- false
        local var54 = (Not_Character and function()--[[function ignored]]end);
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local Not_HumanoidRootPart = not HumanoidRootPart;
        -- false
        local Humanoid_3 = Character:FindFirstChild("Humanoid");
        local var55 = (Not_HumanoidRootPart and 16348270);
        local Not_Humanoid_3 = not Humanoid_3;
        -- false
        local var56 = (Not_Humanoid_3 and function()--[[function ignored]]end);
        local Descendants = workspace:GetDescendants();
        for i_5, v_5 in pairs(Descendants) do
        error("[internal]: too many operations")
        end
    end,
    Name = "Sortir Cage (Seat Glitch)",
    Icon = "arrow-up-circle",
})
Local_Player:CreateSection("Movement")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local _ = Local_Player:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Callback = function(p1_0, p2_0, p3_0)
        local var56 = p1_0[1];
        local var57 = (var56 and 7137042); -- 7137042
        local var58 = (var57 or 10450213);
        local Players_15 = game.Players;
        local LocalPlayer_7 = Players.LocalPlayer;
        local Character_2 = LocalPlayer.Character;
        local Not_Character_2 = not Character_2;
        -- false
        local HumanoidRootPart_2 = Character_2:FindFirstChild("HumanoidRootPart");
        local Not_HumanoidRootPart_2 = not HumanoidRootPart_2;
        -- false
        local HumanoidRootPart_3 = Character_2.HumanoidRootPart;
        local BodyGyro = Instance.new("BodyGyro");
        BodyGyro.Parent = HumanoidRootPart_2;
        BodyGyro.P = 90000;
        local New = Vector3.new;
        local var59 = New(9000000000, 9000000000, 9000000000);
        BodyGyro.maxTorque = var59;
        local CFrame = HumanoidRootPart_2.CFrame;
        BodyGyro.cframe = CFrame;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Parent = HumanoidRootPart_2;
        local New_2 = Vector3.new;
        local var60 = New_2(0, 0, 1);
        BodyVelocity.velocity = var60;
        local New_3 = Vector3.new;
        local var61 = New_3(9000000000, 9000000000, 9000000000);
        BodyVelocity.maxForce = var61;
        local Players_16 = game.Players;
        local LocalPlayer_8 = Players.LocalPlayer;
        local Character_3 = LocalPlayer.Character;
        local Humanoid_4 = Character_3.Humanoid;
        Humanoid_4.PlatformStand = true;
        local var61 = (var56 and 7019614); -- 7019614
        local var62 = (var61 or 11462896);
        local var63 = (Character_2 and 13818886); -- 13818886
        local var64 = (var63 or function()--[[function ignored]]end);
        local Humanoid_5 = Character_2:FindFirstChild("Humanoid");
        local var65 = (var56 and 7019614); -- 7019614
        local var66 = (var65 or 11462896);
        local var67 = (Character_2 and 13818886); -- 13818886
        local var68 = (var67 or function()--[[function ignored]]end);
        local Humanoid_6 = Character_2:FindFirstChild("Humanoid");
        local var69 = (var56 and 7019614); -- 7019614
        local var70 = (var69 or 11462896);
        local var71 = (Character_2 and 13818886); -- 13818886
        local var72 = (var71 or function()--[[function ignored]]end);
        local Humanoid_7 = Character_2:FindFirstChild("Humanoid");
        local var73 = (var56 and 7019614); -- 7019614
        local var74 = (var73 or 11462896);
        local var75 = (Character_2 and 13818886); -- 13818886
        local var76 = (var75 or function()--[[function ignored]]end);
        local Humanoid_8 = Character_2:FindFirstChild("Humanoid");
        local var77 = (var56 and 7019614); -- 7019614
        local var78 = (var77 or 11462896);
        local var79 = (Character_2 and 13818886); -- 13818886
        local var80 = (var79 or function()--[[function ignored]]end);
        local Humanoid_9 = Character_2:FindFirstChild("Humanoid");
        local var81 = (var56 and 7019614); -- 7019614
        local var82 = (var81 or 11462896);
        local var83 = (Character_2 and 13818886); -- 13818886
        local var84 = (var83 or function()--[[function ignored]]end);
        local Humanoid_10 = Character_2:FindFirstChild("Humanoid");
        local var85 = (var56 and 7019614); -- 7019614
        local var86 = (var85 or 11462896);
        local var87 = (Character_2 and 13818886); -- 13818886
        local var88 = (var87 or function()--[[function ignored]]end);
        local Humanoid_11 = Character_2:FindFirstChild("Humanoid");
        local var89 = (var56 and 7019614); -- 7019614
        local var90 = (var89 or 11462896);
        local var91 = (Character_2 and 13818886); -- 13818886
        local var92 = (var91 or function()--[[function ignored]]end);
        local Humanoid_12 = Character_2:FindFirstChild("Humanoid");
        local var93 = (var56 and 7019614); -- 7019614
        local var94 = (var93 or 11462896);
        local var95 = (Character_2 and 13818886); -- 13818886
        local var96 = (var95 or function()--[[function ignored]]end);
        local Humanoid_13 = Character_2:FindFirstChild("Humanoid");
        local var97 = (var56 and 7019614); -- 7019614
        local var98 = (var97 or 11462896);
        local var99 = (Character_2 and 13818886); -- 13818886
        local var100 = (var99 or function()--[[function ignored]]end);
        local Humanoid_14 = Character_2:FindFirstChild("Humanoid");
        local var101 = (var56 and 7019614); -- 7019614
        local var102 = (var101 or 11462896);
        local var103 = (Character_2 and 13818886); -- 13818886
        local var104 = (var103 or function()--[[function ignored]]end);
        local Humanoid_15 = Character_2:FindFirstChild("Humanoid");
        local var105 = (var56 and 7019614); -- 7019614
        local var106 = (var105 or 11462896);
        local var107 = (Character_2 and 13818886); -- 13818886
        local var108 = (var107 or function()--[[function ignored]]end);
        local Humanoid_16 = Character_2:FindFirstChild("Humanoid");
        local var109 = (var56 and 7019614); -- 7019614
        local var110 = (var109 or 11462896);
        local var111 = (Character_2 and 13818886); -- 13818886
        local var112 = (var111 or function()--[[function ignored]]end);
        local Humanoid_17 = Character_2:FindFirstChild("Humanoid");
        local var113 = (var56 and 7019614); -- 7019614
        local var114 = (var113 or 11462896);
        local var115 = (Character_2 and 13818886); -- 13818886
        local var116 = (var115 or function()--[[function ignored]]end);
        local Humanoid_18 = Character_2:FindFirstChild("Humanoid");
        local var117 = (var56 and 7019614); -- 7019614
        local var118 = (var117 or 11462896);
        local var119 = (Character_2 and 13818886); -- 13818886
        local var120 = (var119 or function()--[[function ignored]]end);
        local Humanoid_19 = Character_2:FindFirstChild("Humanoid");
        local var121 = (var56 and 7019614); -- 7019614
        local var122 = (var121 or 11462896);
        local var123 = (Character_2 and 13818886); -- 13818886
        local var124 = (var123 or function()--[[function ignored]]end);
        local Humanoid_20 = Character_2:FindFirstChild("Humanoid");
        local var125 = (var56 and 7019614); -- 7019614
        local var126 = (var125 or 11462896);
        local var127 = (Character_2 and 13818886); -- 13818886
        local var128 = (var127 or function()--[[function ignored]]end);
        local Humanoid_21 = Character_2:FindFirstChild("Humanoid");
        local var129 = (var56 and 7019614); -- 7019614
        local var130 = (var129 or 11462896);
        local var131 = (Character_2 and 13818886); -- 13818886
        local var132 = (var131 or function()--[[function ignored]]end);
        local Humanoid_22 = Character_2:FindFirstChild("Humanoid");
        local var133 = (var56 and 7019614); -- 7019614
        local var134 = (var133 or 11462896);
        local var135 = (Character_2 and 13818886); -- 13818886
        local var136 = (var135 or function()--[[function ignored]]end);
        local Humanoid_23 = Character_2:FindFirstChild("Humanoid");
        local var137 = (var56 and 7019614); -- 7019614
        local var138 = (var137 or 11462896);
        local var139 = (Character_2 and 13818886); -- 13818886
        local var140 = (var139 or function()--[[function ignored]]end);
        local Humanoid_24 = Character_2:FindFirstChild("Humanoid");
        local var141 = (var56 and 7019614); -- 7019614
        local var142 = (var141 or 11462896);
        local var143 = (Character_2 and 13818886); -- 13818886
        local var144 = (var143 or function()--[[function ignored]]end);
        local Humanoid_25 = Character_2:FindFirstChild("Humanoid");
        local var145 = (var56 and 7019614); -- 7019614
        local var146 = (var145 or 11462896);
        local var147 = (Character_2 and 13818886); -- 13818886
        local var148 = (var147 or function()--[[function ignored]]end);
        local Humanoid_26 = Character_2:FindFirstChild("Humanoid");
        local var149 = (var56 and 7019614); -- 7019614
        local var150 = (var149 or 11462896);
        local var151 = (Character_2 and 13818886); -- 13818886
        local var152 = (var151 or function()--[[function ignored]]end);
        local Humanoid_27 = Character_2:FindFirstChild("Humanoid");
        local var153 = (var56 and 7019614); -- 7019614
        local var154 = (var153 or 11462896);
        local var155 = (Character_2 and 13818886); -- 13818886
        local var156 = (var155 or function()--[[function ignored]]end);
        local Humanoid_28 = Character_2:FindFirstChild("Humanoid");
        local var157 = (var56 and 7019614); -- 7019614
        local var158 = (var157 or 11462896);
        local var159 = (Character_2 and 13818886); -- 13818886
        local var160 = (var159 or function()--[[function ignored]]end);
        local Humanoid_29 = Character_2:FindFirstChild("Humanoid");
        local var161 = (var56 and 7019614); -- 7019614
        local var162 = (var161 or 11462896);
        local var163 = (Character_2 and 13818886); -- 13818886
        local var164 = (var163 or function()--[[function ignored]]end);
        local Humanoid_30 = Character_2:FindFirstChild("Humanoid");
        local var165 = (var56 and 7019614); -- 7019614
        local var166 = (var165 or 11462896);
        local var167 = (Character_2 and 13818886); -- 13818886
        local var168 = (var167 or function()--[[function ignored]]end);
        local Humanoid_31 = Character_2:FindFirstChild("Humanoid");
        local var169 = (var56 and 7019614); -- 7019614
        local var170 = (var169 or 11462896);
        local var171 = (Character_2 and 13818886); -- 13818886
        local var172 = (var171 or function()--[[function ignored]]end);
        local Humanoid_32 = Character_2:FindFirstChild("Humanoid");
        local var173 = (var56 and 7019614); -- 7019614
        local var174 = (var173 or 11462896);
        local var175 = (Character_2 and 13818886); -- 13818886
        local var176 = (var175 or function()--[[function ignored]]end);
        local Humanoid_33 = Character_2:FindFirstChild("Humanoid");
        local var177 = (var56 and 7019614); -- 7019614
        local var178 = (var177 or 11462896);
        local var179 = (Character_2 and 13818886); -- 13818886
        local var180 = (var179 or function()--[[function ignored]]end);
        local Humanoid_34 = Character_2:FindFirstChild("Humanoid");
        local var181 = (var56 and 7019614); -- 7019614
        local var182 = (var181 or 11462896);
        local var183 = (Character_2 and 13818886); -- 13818886
        local var184 = (var183 or function()--[[function ignored]]end);
        local Humanoid_35 = Character_2:FindFirstChild("Humanoid");
        local var185 = (var56 and 7019614); -- 7019614
        local var186 = (var185 or 11462896);
        local var187 = (Character_2 and 13818886); -- 13818886
        local var188 = (var187 or function()--[[function ignored]]end);
        local Humanoid_36 = Character_2:FindFirstChild("Humanoid");
        local var189 = (var56 and 7019614); -- 7019614
        local var190 = (var189 or 11462896);
        local var191 = (Character_2 and 13818886); -- 13818886
        local var192 = (var191 or function()--[[function ignored]]end);
        local Humanoid_37 = Character_2:FindFirstChild("Humanoid");
        local var193 = (var56 and 7019614); -- 7019614
        local var194 = (var193 or 11462896);
        local var195 = (Character_2 and 13818886); -- 13818886
        local var196 = (var195 or function()--[[function ignored]]end);
        local Humanoid_38 = Character_2:FindFirstChild("Humanoid");
        local var197 = (var56 and 7019614); -- 7019614
        local var198 = (var197 or 11462896);
        local var199 = (Character_2 and 13818886); -- 13818886
        local var200 = (var199 or function()--[[function ignored]]end);
        local Humanoid_39 = Character_2:FindFirstChild("Humanoid");
        local var201 = (var56 and 7019614); -- 7019614
        local var202 = (var201 or 11462896);
        local var203 = (Character_2 and 13818886); -- 13818886
        local var204 = (var203 or function()--[[function ignored]]end);
        local Humanoid_40 = Character_2:FindFirstChild("Humanoid");
        local var205 = (var56 and 7019614); -- 7019614
        local var206 = (var205 or 11462896);
        local var207 = (Character_2 and 13818886); -- 13818886
        local var208 = (var207 or function()--[[function ignored]]end);
        local Humanoid_41 = Character_2:FindFirstChild("Humanoid");
        local var209 = (var56 and 7019614); -- 7019614
        local var210 = (var209 or 11462896);
        local var211 = (Character_2 and 13818886); -- 13818886
        local var212 = (var211 or function()--[[function ignored]]end);
        local Humanoid_42 = Character_2:FindFirstChild("Humanoid");
        local var213 = (var56 and 7019614); -- 7019614
        local var214 = (var213 or 11462896);
        local var215 = (Character_2 and 13818886); -- 13818886
        local var216 = (var215 or function()--[[function ignored]]end);
        local Humanoid_43 = Character_2:FindFirstChild("Humanoid");
        local var217 = (var56 and 7019614); -- 7019614
        local var218 = (var217 or 11462896);
        local var219 = (Character_2 and 13818886); -- 13818886
        local var220 = (var219 or function()--[[function ignored]]end);
        local Humanoid_44 = Character_2:FindFirstChild("Humanoid");
        local var221 = (var56 and 7019614); -- 7019614
        local var222 = (var221 or 11462896);
        local var223 = (Character_2 and 13818886); -- 13818886
        local var224 = (var223 or function()--[[function ignored]]end);
        local Humanoid_45 = Character_2:FindFirstChild("Humanoid");
        local var225 = (var56 and 7019614); -- 7019614
        local var226 = (var225 or 11462896);
        local var227 = (Character_2 and 13818886); -- 13818886
        local var228 = (var227 or function()--[[function ignored]]end);
        local Humanoid_46 = Character_2:FindFirstChild("Humanoid");
        local var229 = (var56 and 7019614); -- 7019614
        local var230 = (var229 or 11462896);
        local var231 = (Character_2 and 13818886); -- 13818886
        local var232 = (var231 or function()--[[function ignored]]end);
        local Humanoid_47 = Character_2:FindFirstChild("Humanoid");
        local var233 = (var56 and 7019614); -- 7019614
        local var234 = (var233 or 11462896);
        local var235 = (Character_2 and 13818886); -- 13818886
        local var236 = (var235 or function()--[[function ignored]]end);
        local Humanoid_48 = Character_2:FindFirstChild("Humanoid");
        local var237 = (var56 and 7019614); -- 7019614
        local var238 = (var237 or 11462896);
        local var239 = (Character_2 and 13818886); -- 13818886
        local var240 = (var239 or function()--[[function ignored]]end);
        local Humanoid_49 = Character_2:FindFirstChild("Humanoid");
        local var241 = (var56 and 7019614); -- 7019614
        local var242 = (var241 or 11462896);
        local var243 = (Character_2 and 13818886); -- 13818886
        local var244 = (var243 or function()--[[function ignored]]end);
        local Humanoid_50 = Character_2:FindFirstChild("Humanoid");
        local var245 = (var56 and 7019614); -- 7019614
        local var246 = (var245 or 11462896);
        local var247 = (Character_2 and 13818886); -- 13818886
        local var248 = (var247 or function()--[[function ignored]]end);
        local Humanoid_51 = Character_2:FindFirstChild("Humanoid");
        local var249 = (var56 and 7019614); -- 7019614
        local var250 = (var249 or 11462896);
        local var251 = (Character_2 and 13818886); -- 13818886
        local var252 = (var251 or function()--[[function ignored]]end);
        local Humanoid_52 = Character_2:FindFirstChild("Humanoid");
        local var253 = (var56 and 7019614); -- 7019614
        local var254 = (var253 or 11462896);
        local var255 = (Character_2 and 13818886); -- 13818886
        local var256 = (var255 or function()--[[function ignored]]end);
        local Humanoid_53 = Character_2:FindFirstChild("Humanoid");
        local var257 = (var56 and 7019614); -- 7019614
        local var258 = (var257 or 11462896);
        local var259 = (Character_2 and 13818886); -- 13818886
        local var260 = (var259 or function()--[[function ignored]]end);
        local Humanoid_54 = Character_2:FindFirstChild("Humanoid");
        local var261 = (var56 and 7019614); -- 7019614
        local var262 = (var261 or 11462896);
        local var263 = (Character_2 and 13818886); -- 13818886
        local var264 = (var263 or function()--[[function ignored]]end);
        local Humanoid_55 = Character_2:FindFirstChild("Humanoid");
        local var265 = (var56 and 7019614); -- 7019614
        local var266 = (var265 or 11462896);
        local var267 = (Character_2 and 13818886); -- 13818886
        local var268 = (var267 or function()--[[function ignored]]end);
        local Humanoid_56 = Character_2:FindFirstChild("Humanoid");
        local var269 = (var56 and 7019614); -- 7019614
        local var270 = (var269 or 11462896);
        local var271 = (Character_2 and 13818886); -- 13818886
        local var272 = (var271 or function()--[[function ignored]]end);
        error("[internal]: too many operations")
    end,
    Icon = "plane",
    Flag = "FlyToggle",
})
Local_Player:CreateSlider({
    Callback = function(p1_0, p2_0, p3_0, p4_0, p5_0)
    end,
    Flag = "FlySpeedSlider",
    Name = "Fly Speed",
    Suffix = "Speed",
    CurrentValue = 50,
    Increment = 5,
    Icon = "gauge",
    Range = {
        10,
        200,
    },
})
Local_Player:CreateSlider({
    Callback = function(p1_0)
    end,
    Flag = "WalkSpeedSlider",
    Name = "TP Walk Speed",
    Suffix = "Speed",
    CurrentValue = 16,
    Increment = 1,
    Icon = "footprints",
    Range = {
        16,
        500,
    },
})
game:GetService("RunService")
local _ = RunService.Heartbeat:Connect(function(p1_0, p2_0, p3_0)
    local Players_17 = game.Players;
    local LocalPlayer_9 = Players.LocalPlayer;
    local Character_4 = LocalPlayer.Character;
    error("[string \"DHmjGY\"]: attempt to perform arithmetic (mod) on nil and number")
end)
game:GetService("UserInputService")
UserInputService.JumpRequest:Connect(function(p1_0)
end)
Local_Player:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(p1_0, p2_0, p3_0, p4_0, p5_0)
    end,
    Icon = "arrow-up",
    Flag = "InfJump",
})
game:GetService("RunService")
RunService.Stepped:Connect(function()
end)
Local_Player:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(p1_0, p2_0, p3_0, p4_0, p5_0, p6_0)
    end,
    Icon = "ghost",
    Flag = "NoclipToggle",
})
for i_2, v_2 in pairs(Players:GetPlayers()) do
    local _ = ((i_2 and 10494371); -- 10494371 or function()--[[function ignored]]end)
    local _ = (v_2 ~= LocalPlayer)
    -- true, eq id 2
end
local Dropdown_3 = Local_Player:CreateDropdown({
    Callback = function(p1_0, p2_0, p3_0, p4_0)
        local var277 = p1_0[1]
        -- true, eq id 6
        local _ = (((type(var277) == "table") and 10203685); -- 10203685 or 11264266)
        local var281 = var277[1]
        local var283 = ((var281 and 10501218); -- 10501218 or 10825711)
        local FindFirstChild_2 = Players:FindFirstChild(var281)
    end,
    Name = "Select TP Target",
    CurrentOption = {
        "",
    },
    Flag = "TpDropdown",
    MultipleOptions = false,
    Icon = "map-pin",
    Options = {
        v_2.Name,
    },
})
local _ = Local_Player:CreateButton({
    Callback = function(p1_0)
        local Players_19 = game.Players;
        local Players_20 = Players:GetPlayers();
        for i_6, v_6 in pairs(Players_20) do
            local var283 = (i_6 and 10494371); -- 10494371
            local var284 = (var283 or function()--[[function ignored]]end);
            local Players_21 = game.Players;
            local LocalPlayer_10 = Players.LocalPlayer;
            local var285 = (v_6 ~= LocalPlayer);
            -- true, eq id 7
            local Name_4 = v_6.Name;
            local Array_2 = {};
            local var286 = table.insert(Array_2, Name_4);
        end
        local Refresh_3 = Dropdown_3.Refresh;
        local Refresh_4 = Dropdown_3:Refresh(Array_2, true);
    end,
    Name = "Refresh TP List",
    Icon = "refresh-ccw",
})
local _ = Local_Player:CreateButton({
    Callback = function(p1_0, p2_0, p3_0, p4_0, p5_0)
        local var288 = (FindFirstChild_2 and 16351632); -- 16351632
        local Character_5 = FindFirstChild_2.Character;
        local var289 = (Character_5 and 9973564); -- 9973564
        local var290 = (var289 or 109705);
        local Character_6 = FindFirstChild_2.Character;
        local HumanoidRootPart_4 = Character_6:FindFirstChild("HumanoidRootPart");
        error("[string \"DHmjGY\"]: attempt to index function with 'Destroy'")
    end,
    Name = "Teleport to Player",
    Icon = "navigation",
})
Color3.fromRGB(255, 0, 0)
game:GetService("Players")
game:GetService("RunService")
local _ = Players.PlayerAdded:Connect(function(p1_0, p2_0, p3_0, p4_0, p5_0, p6_0)
    local var291 = p1_0[1];
    local CharacterAdded = var291.CharacterAdded;
    local Connect_2 = CharacterAdded.Connect;
    local Connected_2 = CharacterAdded:Connect(function(p1_0, p2_0, p3_0, p4_0)
        local var305 = p1_0[1];
        task.wait(0.5)
        local var306 = (var296 and 14385753); -- 14385753
        local var307 = var291[1];
        local var308 = var291[1];
        local var309 = (var308 == LocalPlayer);
        -- false, eq id 10
        local Character_10 = var308.Character;
        local Not_Character_10 = not Character_10;
        -- false
        local var310 = (Not_Character_10 and 16063967);
        local Character_11 = var308.Character;
        local FindFirstChild_4 = Character_11.FindFirstChild;
        local HumanoidRootPart_6 = Character_11:FindFirstChild("HumanoidRootPart");
        local Not_HumanoidRootPart_6 = not HumanoidRootPart_6;
        -- false
        local FromRGB_3 = Color3.fromRGB;
        local var311 = FromRGB_3(255, 255, 255);
        local Team_3 = var308.Team;
        local var312 = (Team_3 and 10773752); -- 10773752
        local Team_4 = var308.Team;
        local TeamColor_2 = Team_4.TeamColor;
        error("[string \"DHmjGY\"]: attempt to index function with 'Destroy'")
    end);
    local Character_7 = var291.Character;
    local var293 = (Character_7 and 15788357); -- 15788357
    task.wait(0.5)
end)
Players.PlayerRemoving:Connect(function(p1_0, p2_0, p3_0)
end)
ESP:CreateSection("Main ESP")
local _ = ESP:CreateToggle({
    CurrentValue = false,
    Callback = function(p1_0, p2_0)
        local var296 = p1_0[1];
        local var297 = (var296 and 13593200); -- 13593200
        local var298 = (var297 or 16230046);
        local Players_22 = Players:GetPlayers();
        for i_7, v_7 in pairs(Players_22) do
            local var298 = (i_7 and 13399196); -- 13399196
            local var299 = (var298 or function()--[[function ignored]]end);
            local var300 = (v_7 ~= LocalPlayer);
            -- true, eq id 8
            local var301 = (v_7 == LocalPlayer);
            -- false, eq id 9
            local Character_8 = v_7.Character;
            local Not_Character_8 = not Character_8;
            -- false
            local var302 = (Not_Character_8 and 16063967);
            local Character_9 = v_7.Character;
            local FindFirstChild_3 = Character_9.FindFirstChild;
            local HumanoidRootPart_5 = Character_9:FindFirstChild("HumanoidRootPart");
            local Not_HumanoidRootPart_5 = not HumanoidRootPart_5;
            -- false
            local FromRGB_2 = Color3.fromRGB;
            local var303 = FromRGB_2(255, 255, 255);
            local Team = v_7.Team;
            local var304 = (Team and 10773752); -- 10773752
            local Team_2 = v_7.Team;
            local TeamColor = Team_2.TeamColor;
        error("[string \"DHmjGY\"]: attempt to index function with 'Destroy'")
        end
    end,
    Name = "ESP",
    Flag = "ESP",
})
Loaded_Rayfield:Notify({
    Image = "shield",
    Duration = 5,
    Title = "Alpha Hub Loaded",
    Content = "Welcome to Alpha Hub - Edition Noweye [RP/FR]",
})