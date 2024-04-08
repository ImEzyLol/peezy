if game.PlaceId == 13643807539 then --13643807539
    local ArrayField = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
    local Window = ArrayField:CreateWindow({
            Name = "Requisition | South Bronx",
            LoadingTitle = "Requisition Script Hub",
            LoadingSubtitle = "discord.gg/8yDaDVQWNC",
            ConfigurationSaving = {
                Enabled = true,
                FolderName = nil, -- Create a custom folder for your hub/game
                FileName = "Requisition"
            },
            Discord = {
                Enabled = true,
                Invite = "8yDaDVQWNC", -- The Discord invite code, do not include discord.gg/
                RememberJoins = true -- Set this to false to make them join the discord every time they load it up
            },
            KeySystem = false, -- Set this to true to use our key system
            KeySettings = {
                Title = "Requisition",
                Subtitle = "Key System",
                Note = "Join the discord (discord.gg/8yDaDVQWNC)",
                FileName = "RequisitionKeys",
                SaveKey = false,
                GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like ArrayField to get the key from
                Key = {"https://raw.githubusercontent.com/ImEzyLol/tester/main/key.txt"},
                Actions = {
                    [1] = {
                        Text = 'Click here to copy the key link',
                        OnPress = function()
                            setclipboard("discord.gg/8yDaDVQWNC")
                        end,
                    }
                },
            }
        })
        
    local c = workspace.CurrentCamera
    local ps = game:GetService("Players")
    local lp = ps.LocalPlayer
    local rs = game:GetService("RunService")

    _G.ESP_ENABLED = false 

    local function ftool(cr)
        for _, b in ipairs(cr:GetChildren()) do 
            if b:IsA("Tool") then
                return tostring(b.Name)
            end
        end
        return 'empty'
    end

    local function esp(p, cr)
        local h = cr:WaitForChild("Humanoid")
        local hrp = cr:WaitForChild("HumanoidRootPart")

        local text = Drawing.new('Text')
        text.Visible = false
        text.Center = true
        text.Outline = true
        text.Color = Color3.new(1, 1, 1)
        text.Font = 2
        text.Size = 13

        local c1 
        local c2
        local c3 

        local function dc()
            text.Visible = false
            text:Remove()
            if c3 then
                c1:Disconnect()
                c2:Disconnect()
                c3:Disconnect()
                c1 = nil 
                c2 = nil
                c3 = nil
            end
        end

        c2 = cr.AncestryChanged:Connect(function(_, parent)
            if not parent then
                dc()
            end
        end)

        c3 = h.HealthChanged:Connect(function(v)
            if (v <= 0) or (h:GetState() == Enum.HumanoidStateType.Dead) then
                dc()
            end
        end)

        c1 = rs.Heartbeat:Connect(function()
            local hrp_pos, hrp_os = c:WorldToViewportPoint(hrp.Position)
            if hrp_os and _G.ESP_ENABLED then
                text.Position = Vector2.new(hrp_pos.X, hrp_pos.Y)
                text.Text = '[ '..tostring(ftool(cr))..' ]'
                text.Visible = true
            else
                text.Visible = false
            end
        end)
    end

    local function p_added(p)
        if p.Character then
            esp(p, p.Character)
        end
        p.CharacterAdded:Connect(function(cr)
            esp(p, cr)
        end)
    end


    local function toggleESP()
        _G.ESP_ENABLED = not _G.ESP_ENABLED
    end


    ps.PlayerAdded:Connect(p_added)


    for _, b in ipairs(ps:GetPlayers()) do 
        if b ~= lp then
            p_added(b)
        end
    end



        local MainTab = Window:CreateTab("Combat Tab", 4483362458)
        local FarmTab = Window:CreateTab("Autofarm Tab", 4483362458)
        local VisTab = Window:CreateTab("Visuals Tab", 4483362458)
        local MiscTab = Window:CreateTab("Misc Tab", 4483362458)
        local CreditTab = Window:CreateTab("Credit Tab", 4483362458)

        -- [Main Tab] --
        local AimbotToggle = MainTab:CreateToggle({
            Name = "Toggle Aimbot",
            CurrentValue = false,
            Flag = "AimbotToggle", 
            Callback = function(Value)
                local Camera = workspace.CurrentCamera
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local UserInputService = game:GetService("UserInputService")
                local TweenService = game:GetService("TweenService")
                local LocalPlayer = Players.LocalPlayer
                local Holding = false

                _G.AimbotEnabled = Value
                _G.TeamCheck = false -- If set to true then the script would only lock your aim at enemy team members.
                _G.AimPart = "Head" -- Where the aimbot script would lock at.
                _G.Sensitivity = 0 -- How many seconds it takes for the aimbot script to officially lock onto the target's aimpart.

                _G.CircleSides = 64 -- How many sides the FOV circle would have.
                _G.CircleColor = Color3.fromRGB(255, 255, 255) -- (RGB) Color that the FOV circle would appear as.
                _G.CircleTransparency = 0.7 -- Transparency of the circle.
                _G.CircleRadius = 80 -- The radius of the circle / FOV.
                _G.CircleFilled = false -- Determines whether or not the circle is filled.
                _G.CircleVisible = true -- Determines whether or not the circle is visible.
                _G.CircleThickness = 0 -- The thickness of the circle.

                if Value == false then
                    _G.CircleVisible = false
                end

                local FOVCircle = Drawing.new("Circle")
                FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                FOVCircle.Radius = _G.CircleRadius
                FOVCircle.Filled = _G.CircleFilled
                FOVCircle.Color = _G.CircleColor
                FOVCircle.Visible = _G.CircleVisible
                FOVCircle.Radius = _G.CircleRadius
                FOVCircle.Transparency = _G.CircleTransparency
                FOVCircle.NumSides = _G.CircleSides
                FOVCircle.Thickness = _G.CircleThickness

                local function GetClosestPlayer()
                    local MaximumDistance = _G.CircleRadius
                    local Target = nil

                    for _, v in next, Players:GetPlayers() do
                        if v.Name ~= LocalPlayer.Name then
                            if _G.TeamCheck == true then
                                if v.Team ~= LocalPlayer.Team then
                                    if v.Character ~= nil then
                                        if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                                            if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                                local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                                local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                                                
                                                if VectorDistance < MaximumDistance then
                                                    Target = v
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if v.Character ~= nil then
                                    if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                                        if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                            local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                            local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                                            
                                            if VectorDistance < MaximumDistance then
                                                Target = v
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end

                    return Target
                end

                UserInputService.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
                        Holding = true
                    end
                end)

                UserInputService.InputEnded:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
                        Holding = false
                    end
                end)

                RunService.RenderStepped:Connect(function()
                    FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
                    FOVCircle.Radius = _G.CircleRadius
                    FOVCircle.Filled = _G.CircleFilled
                    FOVCircle.Color = _G.CircleColor
                    FOVCircle.Visible = _G.CircleVisible
                    FOVCircle.Radius = _G.CircleRadius
                    FOVCircle.Transparency = _G.CircleTransparency
                    FOVCircle.NumSides = _G.CircleSides
                    FOVCircle.Thickness = _G.CircleThickness

                    if Holding == true and _G.AimbotEnabled == true then
                        TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.AimPart].Position)}):Play()
                    end
                end)
            end,
         })

         local AimPart = MainTab:CreateDropdown({
            Name = "Aim Part",
            Options = {"Head","HumanoidRootPart"},
            CurrentOption = {"Head"},
            MultipleOptions = false,
            Flag = "AimPart", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Option)
                local selectedOption
                if type(Option) == "table" then
                    selectedOption = Option[1] -- Extract the first element if it's a table
                else
                    selectedOption = Option -- Use directly if it's already a string
                end
                
                _G.AimPart = selectedOption
            end,
         })

         local FOVSlider = MainTab:CreateSlider({
            Name = "Fov Size",
            Range = {0, 150},
            Increment = 5,
            Suffix = "",
            CurrentValue = 80,
            Flag = "FOVSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                _G.CircleRadius = Value
            end,
         })

         local CircleVisible = MainTab:CreateToggle({
            Name = "Visible FOV",
            CurrentValue = true,
            Flag = "CircleVisible", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                _G.CircleVisible = Value
            end,
         })

         local FilledFOV = MainTab:CreateToggle({
            Name = "Filled FOV",
            CurrentValue = false,
            Flag = "FilledFOV", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                _G.CircleFilled = Value
            end,
         })

         local CircleColor = MainTab:CreateColorPicker({
            Name = "Circle Color",
            Color = Color3.fromRGB(255,255,255),
            Flag = "CircleColor", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                print(Value)
                _G.CircleColor = Value
                -- The function that takes place every time the color picker is moved/changed
                -- The variable (Value) is a Color3fromRGB value based on which color is selected
            end
        })

        -- [Farm Tab] --
        local BoxToggle = FarmTab:CreateToggle({
            Name = "Box Job Autofarm",
            CurrentValue = false,
            Flag = "BoxFarm",
            Callback = function(Value)
                local teleport_table = {
                    location1 = Vector3.new(-551.0175170898438, 3.537144184112549, -85.6669692993164), -- start
                    location2 = Vector3.new(-400.960754, 3.41219378, -72.2366257, -0.999820769, -2.88791675e-08, -0.0189329591, -2.808512e-08, 1, -4.22059294e-08, 0.0189329591, -4.1666631e-08, -0.999820769) -- end
                }
                
                local tween_s = game:GetService('TweenService')
                
                local lp = game.Players.LocalPlayer
                
                _G.TELEPORT_ENABLED = Value
                
                function bypass_teleport(v, speed)
                    if lp.Character and lp.Character:FindFirstChild('HumanoidRootPart') then
                        local cf = CFrame.new(v)
                        local distance = (lp.Character.HumanoidRootPart.Position - cf.p).magnitude
                        local baseDuration = 1
                        local duration = baseDuration + (distance / speed)
                        
                        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
                        local tween = tween_s:Create(lp.Character.HumanoidRootPart, tweenInfo, {CFrame = cf})
                        tween:Play()
                        tween.Completed:Wait() -- Wait for the tween to complete before proceeding
                    end
                end
                
                while true do
                    if _G.TELEPORT_ENABLED then
                        bypass_teleport(teleport_table.location1, 25)
                        wait(1)
                        fireproximityprompt(game:GetService("Workspace").PlaceHere.Attachment.ProximityPrompt)
                        -- Equip tool "Crate" here
                        
                        wait(0.5)
                        local crateTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Crate")
                        if crateTool then
                            game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(crateTool)
                        end
                        bypass_teleport(teleport_table.location2, 25)
                        local character = game.Players.LocalPlayer.Character
                        local humanoid = character:WaitForChild("Humanoid")
                        humanoid:Move(Vector3.new(0, 0, -5))
                        wait(1)
                        -- Wait until the "Crate" tool is removed from inventory here
                        while game.Players.LocalPlayer.Backpack:FindFirstChild("Crate") or game.Players.LocalPlayer.Character:FindFirstChild("Crate") do
                            fireproximityprompt(game:GetService("Workspace").cratetruck2.Model.ClickBox.ProximityPrompt)
                            wait(1)
                        end        
                    else
                        wait(1) -- Wait if teleport is not enabled
                    end
                end                
            end,
        })
        
        local ATMToggle = FarmTab:CreateToggle({
            Name = "ATM Farm",
            CurrentValue = false,
            Flag = "ATMToggle",
            Callback = function(Value)
                local playerName = game.Players.LocalPlayer.Name
                local lp = game.Players.LocalPlayer
                
                local moneyAmount = game:GetService("Players")[playerName].PlayerGui.Main.Money.Amount
                
                print(moneyAmount.Text)
                
                local moneyValueText = moneyAmount.Text:gsub("%$", "")
                local moneyValue = tonumber(moneyValueText)
                
                local teleport_table = {
                    location1 = Vector3.new(214.934265, 3.73713231, -335.223938),
                    location2 = Vector3.new(-48.807437896728516, 3.735410213470459, -320.9378356933594) 
                }
                
                local hasTeleportedToLocation2 = false
                
                local tween_s = game:GetService('TweenService')
                
                _G.shouldRun = Value -- Toggleable variable
                
                function bypass_teleport(v, speed)
                    if lp.Character and lp.Character:FindFirstChild('HumanoidRootPart') then
                        local cf = CFrame.new(v)
                        local distance = (lp.Character.HumanoidRootPart.Position - cf.p).magnitude
                        local baseDuration = 1
                        local duration = baseDuration + (distance / speed)
                        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
                        local teleportTween = tween_s:Create(lp.Character.HumanoidRootPart, tweenInfo, {CFrame = cf})
                        teleportTween:Play()
                        teleportTween.Completed:Wait()
                    end
                end
                
                -- Main loop
                while _G.shouldRun do
                    if moneyValue and moneyValue >= 850 then
                        print("Player has more/equal to 850 money")
                        
                        -- Perform teleportation actions
                        bypass_teleport(teleport_table.location1, 22) -- Teleport to location1 with speed 25 studs per second
                        wait(1)  -- Adjust if additional delay is needed after teleporting
                        fireproximityprompt(game:GetService("Workspace").NPCs.FakeIDSeller.UpperTorso.Attachment.ProximityPrompt)
                        wait(1)
                        local fakeID = game.Players.LocalPlayer.Backpack:FindFirstChild("Fake ID")
                        if fakeID then
                            game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(fakeID)
                        end
                        
                        local bankTeller = game:GetService("Workspace").NPCs["Bank Teller"]
                        local proximityPrompt = bankTeller.UpperTorso.Attachment.ProximityPrompt
                        if proximityPrompt then
                            local isActive = false
                            local function CheckPromptActive()
                                isActive = proximityPrompt.Enabled
                                return isActive
                            end
                            repeat
                                wait(0.1)
                            until CheckPromptActive()
                            print("Proximity prompt for Bank Teller is now active")
                            if not hasTeleportedToLocation2 then
                                bypass_teleport(teleport_table.location2, 22) -- Teleport to location2 with speed 25 studs per second
                                hasTeleportedToLocation2 = true 
                            end
                            fireproximityprompt(game:GetService("Workspace").NPCs["Bank Teller"].UpperTorso.Attachment.ProximityPrompt)
                            wait(40.2)
                            print("done")
                            wait(1)
                            bypass_teleport(Vector3.new(-39.2600784, 6.71216249, -330.2117), 22) -- Teleport to another location with speed 25 studs per second
                            fireproximityprompt(game:GetService("Workspace").Blank.Attachment.ProximityPrompt)
                            wait(1)
                            local BlankCard = game.Players.LocalPlayer.Backpack:FindFirstChild("Card")
                            if BlankCard then
                                game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(BlankCard)
                            end
                            local ATMSFolder = game:GetService("Workspace").ATMS
                            local activeATM = nil
                            for _, ATM in pairs(ATMSFolder:GetChildren()) do
                                local proximityPrompt = ATM:FindFirstChild("Attachment") and ATM.Attachment:FindFirstChild("ProximityPrompt")
                                if proximityPrompt and proximityPrompt.Enabled then
                                    activeATM = ATM
                                    break
                                end
                            end
                            if activeATM then
                                local targetPosition = activeATM.Position
                                print("Teleporting to ATM at position:", targetPosition)
                                bypass_teleport(targetPosition, 22) -- Teleport to ATM location with speed 25 studs per second
                                local character = game.Players.LocalPlayer.Character
                                local humanoid = character:WaitForChild("Humanoid")
                                humanoid:Move(Vector3.new(0, 0, -5))
                                wait(1)
                            else
                                print("No active ATM found")
                            end
                        else
                            print("Proximity prompt for Bank Teller not found")
                        end
                    else
                        print("Player does not have enough money")
                    end
                    hasTeleportedToLocation2 = false
                    wait(5) -- Repeat the loop every 5 seconds
                end                 
            end,
        })


        -- [Visuals Tab] --
        local BoxToggle = VisTab:CreateToggle({
            Name = "Box ESP",
            CurrentValue = false,
            Flag = "BoxESP",
            Callback = function(Value)
                -- settings
                local settings = {
                    defaultcolor = Color3.fromRGB(255,0,0),
                    teamcheck = false,
                    teamcolor = true
                };
                
                -- Initialize global control for ESP
                _G.BoxEnabled = Value
                
                -- services
                local runService = game:GetService("RunService");
                local players = game:GetService("Players");
                
                -- variables
                local localPlayer = players.LocalPlayer;
                local camera = workspace.CurrentCamera;
                
                -- functions
                local newVector2, newColor3, newDrawing = Vector2.new, Color3.new, Drawing.new;
                local tan, rad = math.tan, math.rad;
                local round = function(...) local a = {}; for i,v in next, table.pack(...) do a[i] = math.round(v); end return unpack(a); end;
                local wtvp = function(...) local a, b = camera.WorldToViewportPoint(camera, ...) return newVector2(a.X, a.Y), b, a.Z end;
                
                local espCache = {};
                local function createEsp(player)
                    local drawings = {};
                    
                    drawings.box = newDrawing("Square");
                    drawings.box.Thickness = 1;
                    drawings.box.Filled = false;
                    drawings.box.Color = settings.defaultcolor;
                    drawings.box.Visible = false;
                    drawings.box.ZIndex = 2;
                
                    drawings.boxoutline = newDrawing("Square");
                    drawings.boxoutline.Thickness = 3;
                    drawings.boxoutline.Filled = false;
                    drawings.boxoutline.Color = newColor3(0, 0, 0); -- Default outline color, you can change it as needed.
                    drawings.boxoutline.Visible = false;
                    drawings.boxoutline.ZIndex = 1;
                
                    espCache[player] = drawings;
                end
                
                local function removeEsp(player)
                    if rawget(espCache, player) then
                        for _, drawing in next, espCache[player] do
                            drawing:Remove();
                        end
                        espCache[player] = nil;
                    end
                end
                
                local function updateEsp(player, esp)
                    if not _G.BoxEnabled then -- Check if ESP is enabled globally
                        esp.box.Visible = false;
                        esp.boxoutline.Visible = false;
                        return
                    end
                    
                    local character = player and player.Character;
                    if character then
                        local cframe = character:GetModelCFrame();
                        local position, visible, depth = wtvp(cframe.Position);
                        esp.box.Visible = visible;
                        esp.boxoutline.Visible = visible;
                
                        if cframe and visible then
                            local scaleFactor = 1 / (depth * tan(rad(camera.FieldOfView / 2)) * 2) * 1000;
                            local width, height = round(4 * scaleFactor, 5 * scaleFactor);
                            local x, y = round(position.X, position.Y);
                
                            esp.box.Size = newVector2(width, height);
                            esp.box.Position = newVector2(x - width / 2, y - height / 2);
                            esp.box.Color = settings.teamcolor and player.TeamColor.Color or settings.defaultcolor;
                
                            esp.boxoutline.Size = esp.box.Size;
                            esp.boxoutline.Position = esp.box.Position;
                        end
                    else
                        esp.box.Visible = false;
                        esp.boxoutline.Visible = false;
                    end
                end
                
                -- main
                for _, player in next, players:GetPlayers() do
                    if player ~= localPlayer then
                        createEsp(player);
                    end
                end
                
                players.PlayerAdded:Connect(function(player)
                    createEsp(player);
                end);
                
                players.PlayerRemoving:Connect(function(player)
                    removeEsp(player);
                end)
                
                runService:BindToRenderStep("esp", Enum.RenderPriority.Camera.Value, function()
                    for player, drawings in next, espCache do
                        if settings.teamcheck and player.Team == localPlayer.Team then
                            continue;
                        end
                
                        if drawings and player ~= localPlayer then
                            updateEsp(player, drawings);
                        end
                    end
                end)
 
            end,
        })

        local ATMToggle = VisTab:CreateToggle({
            Name = "Active ATM ESP",
            CurrentValue = false,
            Flag = "ActiveATMESP",
            Callback = function(Value)
                local ATMSFolder = game:GetService("Workspace").ATMS
                local activeATMs = {}
                _G.TextVisible = Value -- Initially not visible

                -- Function to create or update the text drawing object for an ATM
                local function updateTextDrawing(atm)
                    if not _G.TextVisible then return end -- Check if text visibility is disabled

                    if activeATMs[atm] then
                        activeATMs[atm]:Remove()
                    end
                    
                    local text = "ATM Active"
                    local textDrawing = Drawing.new("Text")
                    textDrawing.Text = text
                    textDrawing.Size = 20
                    textDrawing.Color = Color3.fromRGB(255, 255, 255)
                    
                    local viewportPosition = game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(atm.Position)
                    textDrawing.Position = Vector2.new(viewportPosition.X, viewportPosition.Y) -- Convert to Vector2
                    textDrawing.Visible = true
                    activeATMs[atm] = textDrawing
                end

                -- Function to check for active ATMs and update text drawings
                local function updateActiveATMs()
                    if not _G.TextVisible then
                        for _, textDrawing in pairs(activeATMs) do
                            textDrawing:Remove() -- Remove all text drawings
                        end
                        activeATMs = {} -- Clear the table
                        return
                    end

                    for _, ATM in pairs(ATMSFolder:GetChildren()) do
                        local proximityPrompt = ATM:FindFirstChild("Attachment") and ATM.Attachment:FindFirstChild("ProximityPrompt")
                        if proximityPrompt and proximityPrompt.Enabled then
                            updateTextDrawing(ATM)
                        elseif activeATMs[ATM] then
                            activeATMs[ATM]:Remove()
                            activeATMs[ATM] = nil
                        end
                    end
                end

                -- Call the function initially and set up a loop to continuously check for active ATMs
                updateActiveATMs()
                game:GetService("RunService").Stepped:Connect(function()
                    updateActiveATMs()
                end)
 
            end,
        })

        local EquipToggle = VisTab:CreateToggle({
            Name = "Equipped ESP",
            CurrentValue = false,
            Flag = "EquippedESP",
            Callback = function(Value)
                toggleESP()  
            end,
        })

        local NameToggle = VisTab:CreateToggle({
            Name = "Name ESP",
            CurrentValue = false,
            Flag = "NameESP",
            Callback = function(Value)
                local c = workspace.CurrentCamera
                local ps = game:GetService("Players")
                local lp = ps.LocalPlayer
                local rs = game:GetService("RunService")

                -- Define a global variable to control ESP state
                _G.ESPEnabled = Value

                local function esp(p,cr)
                    local h = cr:WaitForChild("Humanoid")
                    local hrp = cr:WaitForChild("HumanoidRootPart")

                    local text = Drawing.new("Text")
                    text.Visible = false
                    text.Center = true
                    text.Outline = true 
                    text.Font = 2
                    text.Color = Color3.fromRGB(255,255,255)
                    text.Size = 13

                    local c1
                    local c2
                    local c3

                    local function dc()
                        text.Visible = false
                        text:Remove()
                        if c1 then
                            c1:Disconnect()
                            c1 = nil 
                        end
                        if c2 then
                            c2:Disconnect()
                            c2 = nil 
                        end
                        if c3 then
                            c3:Disconnect()
                            c3 = nil 
                        end
                    end

                    c2 = cr.AncestryChanged:Connect(function(_,parent)
                        if not parent then
                            dc()
                        end
                    end)

                    c3 = h.HealthChanged:Connect(function(v)
                        if (v<=0) or (h:GetState() == Enum.HumanoidStateType.Dead) then
                            dc()
                        end
                    end)

                    c1 = rs.RenderStepped:Connect(function()
                        if _G.ESPEnabled then -- Check if ESP is enabled
                            local hrp_pos,hrp_onscreen = c:WorldToViewportPoint(hrp.Position)
                            if hrp_onscreen then
                                local yOffset = 50 -- Adjust this value to change the height of the text
                                text.Position = Vector2.new(hrp_pos.X, hrp_pos.Y - yOffset)
                                text.Text = p.Name
                                text.Visible = true
                            else
                                text.Visible = false
                            end
                        else
                            dc() -- Disable ESP if not enabled
                        end
                    end)    
                end

                local function p_added(p)
                    if p.Character then
                        esp(p,p.Character)
                    end
                    p.CharacterAdded:Connect(function(cr)
                        esp(p,cr)
                    end)
                end

                for i,p in next, ps:GetPlayers() do 
                    if p ~= lp then
                        p_added(p)
                    end
                end

                ps.PlayerAdded:Connect(p_added)

            end,
        })

        -- [Misc Tab] --
        local IPButton = MiscTab:CreateButton({
            Name = "Instant Proximity",
            Callback = function()
                for i,v in ipairs(game:GetService("Workspace"):GetDescendants()) do
                    if v.ClassName == "ProximityPrompt" then
                     v.HoldDuration = 0
                    end
                   end                   
            end,
         })

         local SmallButton = MiscTab:CreateButton({
            Name = "Join smallest server",
            Callback = function()
                local Http = game:GetService("HttpService")
                local TPS = game:GetService("TeleportService")
                local Api = "https://games.roblox.com/v1/games/"
                
                local _place = game.PlaceId
                local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
                function ListServers(cursor)
                  local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
                  return Http:JSONDecode(Raw)
                end
                
                local Server, Next; repeat
                  local Servers = ListServers(Next)
                  Server = Servers.data[1]
                  Next = Servers.nextPageCursor
                until Server
                
                TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)               
            end,
         })

         
         local RejoinButton = MiscTab:CreateButton({
            Name = "Rejoin server",
            Callback = function()
                local ts = game:GetService("TeleportService")
                local p = game:GetService("Players").LocalPlayer
                ts:Teleport(game.PlaceId, p)        
            end,
         })

         local HopButton = MiscTab:CreateButton({
            Name = "Server Hop",
            Callback = function()
                local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua")()
                module:Teleport(game.PlaceId)     
            end,
         })

        -- [Credit Tab] --
        local DiscordButton = CreditTab:CreateButton({
            Name = "Join the Discord!",
            Callback = function()
                local HttpService = game:GetService("HttpService")
                local requestFunction = (syn and syn.request) or (http and http.request) or http_request
                
                if requestFunction then
                    local nonce = HttpService:GenerateGUID(false)
                    local requestBody = HttpService:JSONEncode({
                        cmd = 'INVITE_BROWSER',
                        nonce = nonce,
                        args = {code = "8yDaDVQWNC"}
                    })
                    
                    requestFunction({
                        Url = 'http://127.0.0.1:6463/rpc?v=1',
                        Method = 'POST',
                        Headers = {
                            ['Content-Type'] = 'application/json',
                            Origin = 'https://discord.com'
                        },
                        Body = requestBody
                    })
                else
                    warn("Unable to make HTTP request: requestFunction is not available")
                end                
            end,
         })



elseif game.PlaceId == 14413475235 then
    local ArrayField = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
    local Window = ArrayField:CreateWindow({
            Name = "Requisition | South Bronx",
            LoadingTitle = "Requisition Script Hub",
            LoadingSubtitle = "discord.gg/8yDaDVQWNC",
            ConfigurationSaving = {
                Enabled = true,
                FolderName = nil, -- Create a custom folder for your hub/game
                FileName = "Requisition"
            },
            Discord = {
                Enabled = true,
                Invite = "8yDaDVQWNC", -- The Discord invite code, do not include discord.gg/
                RememberJoins = true -- Set this to false to make them join the discord every time they load it up
            },
            KeySystem = false, -- Set this to true to use our key system
            KeySettings = {
                Title = "Requisition",
                Subtitle = "Key System",
                Note = "Join the discord (discord.gg/8yDaDVQWNC)",
                FileName = "RequisitionKeys",
                SaveKey = false,
                GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like ArrayField to get the key from
                Key = {"https://raw.githubusercontent.com/ImEzyLol/tester/main/key.txt"},
                Actions = {
                    [1] = {
                        Text = 'Click here to copy the key link',
                        OnPress = function()
                            setclipboard("discord.gg/8yDaDVQWNC")
                        end,
                    }
                },
            }
        })
        
    local c = workspace.CurrentCamera
    local ps = game:GetService("Players")
    local lp = ps.LocalPlayer
    local rs = game:GetService("RunService")

    _G.ESP_ENABLED = false 

    local function ftool(cr)
        for _, b in ipairs(cr:GetChildren()) do 
            if b:IsA("Tool") then
                return tostring(b.Name)
            end
        end
        return 'empty'
    end

    local function esp(p, cr)
        local h = cr:WaitForChild("Humanoid")
        local hrp = cr:WaitForChild("HumanoidRootPart")

        local text = Drawing.new('Text')
        text.Visible = false
        text.Center = true
        text.Outline = true
        text.Color = Color3.new(1, 1, 1)
        text.Font = 2
        text.Size = 13

        local c1 
        local c2
        local c3 

        local function dc()
            text.Visible = false
            text:Remove()
            if c3 then
                c1:Disconnect()
                c2:Disconnect()
                c3:Disconnect()
                c1 = nil 
                c2 = nil
                c3 = nil
            end
        end

        c2 = cr.AncestryChanged:Connect(function(_, parent)
            if not parent then
                dc()
            end
        end)

        c3 = h.HealthChanged:Connect(function(v)
            if (v <= 0) or (h:GetState() == Enum.HumanoidStateType.Dead) then
                dc()
            end
        end)

        c1 = rs.Heartbeat:Connect(function()
            local hrp_pos, hrp_os = c:WorldToViewportPoint(hrp.Position)
            if hrp_os and _G.ESP_ENABLED then
                text.Position = Vector2.new(hrp_pos.X, hrp_pos.Y)
                text.Text = '[ '..tostring(ftool(cr))..' ]'
                text.Visible = true
            else
                text.Visible = false
            end
        end)
    end

    local function p_added(p)
        if p.Character then
            esp(p, p.Character)
        end
        p.CharacterAdded:Connect(function(cr)
            esp(p, cr)
        end)
    end


    local function toggleESP()
        _G.ESP_ENABLED = not _G.ESP_ENABLED
    end


    ps.PlayerAdded:Connect(p_added)


    for _, b in ipairs(ps:GetPlayers()) do 
        if b ~= lp then
            p_added(b)
        end
    end


    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Y then
            toggleESP()
        end
    end)



        local MainTab = Window:CreateTab("Combat Tab", 4483362458)
        local FarmTab = Window:CreateTab("Autofarm Tab", 4483362458)
        local VisTab = Window:CreateTab("Visuals Tab", 4483362458)
        local MiscTab = Window:CreateTab("Misc Tab", 4483362458)
        local CreditTab = Window:CreateTab("Credit Tab", 4483362458)

        -- [Main Tab] --
        local AimbotToggle = MainTab:CreateToggle({
            Name = "Toggle Aimbot",
            CurrentValue = false,
            Flag = "AimbotToggle", 
            Callback = function(Value)
                local Camera = workspace.CurrentCamera
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local UserInputService = game:GetService("UserInputService")
                local TweenService = game:GetService("TweenService")
                local LocalPlayer = Players.LocalPlayer
                local Holding = false

                _G.AimbotEnabled = Value
                _G.TeamCheck = false -- If set to true then the script would only lock your aim at enemy team members.
                _G.AimPart = "Head" -- Where the aimbot script would lock at.
                _G.Sensitivity = 0 -- How many seconds it takes for the aimbot script to officially lock onto the target's aimpart.

                _G.CircleSides = 64 -- How many sides the FOV circle would have.
                _G.CircleColor = Color3.fromRGB(255, 255, 255) -- (RGB) Color that the FOV circle would appear as.
                _G.CircleTransparency = 0.7 -- Transparency of the circle.
                _G.CircleRadius = 80 -- The radius of the circle / FOV.
                _G.CircleFilled = false -- Determines whether or not the circle is filled.
                _G.CircleVisible = true -- Determines whether or not the circle is visible.
                _G.CircleThickness = 0 -- The thickness of the circle.

                if Value == false then
                    _G.CircleVisible = false
                end

                local FOVCircle = Drawing.new("Circle")
                FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                FOVCircle.Radius = _G.CircleRadius
                FOVCircle.Filled = _G.CircleFilled
                FOVCircle.Color = _G.CircleColor
                FOVCircle.Visible = _G.CircleVisible
                FOVCircle.Radius = _G.CircleRadius
                FOVCircle.Transparency = _G.CircleTransparency
                FOVCircle.NumSides = _G.CircleSides
                FOVCircle.Thickness = _G.CircleThickness

                local function GetClosestPlayer()
                    local MaximumDistance = _G.CircleRadius
                    local Target = nil

                    for _, v in next, Players:GetPlayers() do
                        if v.Name ~= LocalPlayer.Name then
                            if _G.TeamCheck == true then
                                if v.Team ~= LocalPlayer.Team then
                                    if v.Character ~= nil then
                                        if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                                            if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                                local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                                local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                                                
                                                if VectorDistance < MaximumDistance then
                                                    Target = v
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if v.Character ~= nil then
                                    if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                                        if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                            local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                            local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                                            
                                            if VectorDistance < MaximumDistance then
                                                Target = v
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end

                    return Target
                end

                UserInputService.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
                        Holding = true
                    end
                end)

                UserInputService.InputEnded:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
                        Holding = false
                    end
                end)

                RunService.RenderStepped:Connect(function()
                    FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
                    FOVCircle.Radius = _G.CircleRadius
                    FOVCircle.Filled = _G.CircleFilled
                    FOVCircle.Color = _G.CircleColor
                    FOVCircle.Visible = _G.CircleVisible
                    FOVCircle.Radius = _G.CircleRadius
                    FOVCircle.Transparency = _G.CircleTransparency
                    FOVCircle.NumSides = _G.CircleSides
                    FOVCircle.Thickness = _G.CircleThickness

                    if Holding == true and _G.AimbotEnabled == true then
                        TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.AimPart].Position)}):Play()
                    end
                end)
            end,
         })

         local AimPart = MainTab:CreateDropdown({
            Name = "Aim Part",
            Options = {"Head","HumanoidRootPart"},
            CurrentOption = {"Head"},
            MultipleOptions = false,
            Flag = "AimPart", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Option)
                local selectedOption
                if type(Option) == "table" then
                    selectedOption = Option[1] -- Extract the first element if it's a table
                else
                    selectedOption = Option -- Use directly if it's already a string
                end
                
                _G.AimPart = selectedOption
            end,
         })

         local FOVSlider = MainTab:CreateSlider({
            Name = "Fov Size",
            Range = {0, 150},
            Increment = 5,
            Suffix = "",
            CurrentValue = 80,
            Flag = "FOVSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                _G.CircleRadius = Value
            end,
         })

         local CircleVisible = MainTab:CreateToggle({
            Name = "Visible FOV",
            CurrentValue = true,
            Flag = "CircleVisible", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                _G.CircleVisible = Value
            end,
         })

         local FilledFOV = MainTab:CreateToggle({
            Name = "Filled FOV",
            CurrentValue = false,
            Flag = "FilledFOV", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                _G.CircleFilled = Value
            end,
         })

         local CircleColor = MainTab:CreateColorPicker({
            Name = "Circle Color",
            Color = Color3.fromRGB(255,255,255),
            Flag = "CircleColor", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                print(Value)
                _G.CircleColor = Value
                -- The function that takes place every time the color picker is moved/changed
                -- The variable (Value) is a Color3fromRGB value based on which color is selected
            end
        })

        -- [Farm Tab] --
        local BoxToggle = FarmTab:CreateToggle({
            Name = "Box Job Autofarm",
            CurrentValue = false,
            Flag = "BoxFarm",
            Callback = function(Value)
                local teleport_table = {
                    location1 = Vector3.new(-551.0175170898438, 3.537144184112549, -85.6669692993164), -- start
                    location2 = Vector3.new(-400.960754, 3.41219378, -72.2366257, -0.999820769, -2.88791675e-08, -0.0189329591, -2.808512e-08, 1, -4.22059294e-08, 0.0189329591, -4.1666631e-08, -0.999820769) -- end
                }
                
                local tween_s = game:GetService('TweenService')
                
                local lp = game.Players.LocalPlayer
                
                _G.TELEPORT_ENABLED = Value
                
                function bypass_teleport(v, speed)
                    if lp.Character and lp.Character:FindFirstChild('HumanoidRootPart') then
                        local cf = CFrame.new(v)
                        local distance = (lp.Character.HumanoidRootPart.Position - cf.p).magnitude
                        local baseDuration = 1
                        local duration = baseDuration + (distance / speed)
                        
                        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
                        local tween = tween_s:Create(lp.Character.HumanoidRootPart, tweenInfo, {CFrame = cf})
                        tween:Play()
                        tween.Completed:Wait() -- Wait for the tween to complete before proceeding
                    end
                end
                
                while true do
                    if _G.TELEPORT_ENABLED then
                        bypass_teleport(teleport_table.location1, 25)
                        wait(1)
                        fireproximityprompt(game:GetService("Workspace").PlaceHere.Attachment.ProximityPrompt)
                        -- Equip tool "Crate" here
                        
                        wait(0.5)
                        local crateTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Crate")
                        if crateTool then
                            game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(crateTool)
                        end
                        bypass_teleport(teleport_table.location2, 25)
                        local character = game.Players.LocalPlayer.Character
                        local humanoid = character:WaitForChild("Humanoid")
                        humanoid:Move(Vector3.new(0, 0, -5))
                        wait(1)
                        -- Wait until the "Crate" tool is removed from inventory here
                        while game.Players.LocalPlayer.Backpack:FindFirstChild("Crate") or game.Players.LocalPlayer.Character:FindFirstChild("Crate") do
                            fireproximityprompt(game:GetService("Workspace").cratetruck2.Model.ClickBox.ProximityPrompt)
                            wait(1)
                        end        
                    else
                        wait(1) -- Wait if teleport is not enabled
                    end
                end                
            end,
        })
        
        local ATMToggle = FarmTab:CreateToggle({
            Name = "ATM Farm",
            CurrentValue = false,
            Flag = "ATMToggle",
            Callback = function(Value)
                local playerName = game.Players.LocalPlayer.Name
                local lp = game.Players.LocalPlayer
                
                local moneyAmount = game:GetService("Players")[playerName].PlayerGui.Main.Money.Amount
                
                print(moneyAmount.Text)
                
                local moneyValueText = moneyAmount.Text:gsub("%$", "")
                local moneyValue = tonumber(moneyValueText)
                
                local teleport_table = {
                    location1 = Vector3.new(214.934265, 3.73713231, -335.223938),
                    location2 = Vector3.new(-48.807437896728516, 3.735410213470459, -320.9378356933594) 
                }
                
                local hasTeleportedToLocation2 = false
                
                local tween_s = game:GetService('TweenService')
                
                _G.shouldRun = Value -- Toggleable variable
                
                function bypass_teleport(v, speed)
                    if lp.Character and lp.Character:FindFirstChild('HumanoidRootPart') then
                        local cf = CFrame.new(v)
                        local distance = (lp.Character.HumanoidRootPart.Position - cf.p).magnitude
                        local baseDuration = 1
                        local duration = baseDuration + (distance / speed)
                        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
                        local teleportTween = tween_s:Create(lp.Character.HumanoidRootPart, tweenInfo, {CFrame = cf})
                        teleportTween:Play()
                        teleportTween.Completed:Wait()
                    end
                end
                
                -- Main loop
                while _G.shouldRun do
                    if moneyValue and moneyValue >= 850 then
                        print("Player has more/equal to 850 money")
                        
                        -- Perform teleportation actions
                        bypass_teleport(teleport_table.location1, 22) -- Teleport to location1 with speed 25 studs per second
                        wait(1)  -- Adjust if additional delay is needed after teleporting
                        fireproximityprompt(game:GetService("Workspace").NPCs.FakeIDSeller.UpperTorso.Attachment.ProximityPrompt)
                        wait(1)
                        local fakeID = game.Players.LocalPlayer.Backpack:FindFirstChild("Fake ID")
                        if fakeID then
                            game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(fakeID)
                        end
                        
                        local bankTeller = game:GetService("Workspace").NPCs["Bank Teller"]
                        local proximityPrompt = bankTeller.UpperTorso.Attachment.ProximityPrompt
                        if proximityPrompt then
                            local isActive = false
                            local function CheckPromptActive()
                                isActive = proximityPrompt.Enabled
                                return isActive
                            end
                            repeat
                                wait(0.1)
                            until CheckPromptActive()
                            print("Proximity prompt for Bank Teller is now active")
                            if not hasTeleportedToLocation2 then
                                bypass_teleport(teleport_table.location2, 22) -- Teleport to location2 with speed 25 studs per second
                                hasTeleportedToLocation2 = true 
                            end
                            fireproximityprompt(game:GetService("Workspace").NPCs["Bank Teller"].UpperTorso.Attachment.ProximityPrompt)
                            wait(40.2)
                            print("done")
                            wait(1)
                            bypass_teleport(Vector3.new(-39.2600784, 6.71216249, -330.2117), 22) -- Teleport to another location with speed 25 studs per second
                            fireproximityprompt(game:GetService("Workspace").Blank.Attachment.ProximityPrompt)
                            wait(1)
                            local BlankCard = game.Players.LocalPlayer.Backpack:FindFirstChild("Card")
                            if BlankCard then
                                game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(BlankCard)
                            end
                            local ATMSFolder = game:GetService("Workspace").ATMS
                            local activeATM = nil
                            for _, ATM in pairs(ATMSFolder:GetChildren()) do
                                local proximityPrompt = ATM:FindFirstChild("Attachment") and ATM.Attachment:FindFirstChild("ProximityPrompt")
                                if proximityPrompt and proximityPrompt.Enabled then
                                    activeATM = ATM
                                    break
                                end
                            end
                            if activeATM then
                                local targetPosition = activeATM.Position
                                print("Teleporting to ATM at position:", targetPosition)
                                bypass_teleport(targetPosition, 22) -- Teleport to ATM location with speed 25 studs per second
                                local character = game.Players.LocalPlayer.Character
                                local humanoid = character:WaitForChild("Humanoid")
                                humanoid:Move(Vector3.new(0, 0, -5))
                                wait(1)
                            else
                                print("No active ATM found")
                            end
                        else
                            print("Proximity prompt for Bank Teller not found")
                        end
                    else
                        print("Player does not have enough money")
                    end
                    hasTeleportedToLocation2 = false
                    wait(5) -- Repeat the loop every 5 seconds
                end                 
            end,
        })


        -- [Visuals Tab] --
        local BoxToggle = VisTab:CreateToggle({
            Name = "Box ESP",
            CurrentValue = false,
            Flag = "BoxESP",
            Callback = function(Value)
                -- settings
                local settings = {
                    defaultcolor = Color3.fromRGB(255,0,0),
                    teamcheck = false,
                    teamcolor = true
                };
                
                -- Initialize global control for ESP
                _G.BoxEnabled = Value
                
                -- services
                local runService = game:GetService("RunService");
                local players = game:GetService("Players");
                
                -- variables
                local localPlayer = players.LocalPlayer;
                local camera = workspace.CurrentCamera;
                
                -- functions
                local newVector2, newColor3, newDrawing = Vector2.new, Color3.new, Drawing.new;
                local tan, rad = math.tan, math.rad;
                local round = function(...) local a = {}; for i,v in next, table.pack(...) do a[i] = math.round(v); end return unpack(a); end;
                local wtvp = function(...) local a, b = camera.WorldToViewportPoint(camera, ...) return newVector2(a.X, a.Y), b, a.Z end;
                
                local espCache = {};
                local function createEsp(player)
                    local drawings = {};
                    
                    drawings.box = newDrawing("Square");
                    drawings.box.Thickness = 1;
                    drawings.box.Filled = false;
                    drawings.box.Color = settings.defaultcolor;
                    drawings.box.Visible = false;
                    drawings.box.ZIndex = 2;
                
                    drawings.boxoutline = newDrawing("Square");
                    drawings.boxoutline.Thickness = 3;
                    drawings.boxoutline.Filled = false;
                    drawings.boxoutline.Color = newColor3(0, 0, 0); -- Default outline color, you can change it as needed.
                    drawings.boxoutline.Visible = false;
                    drawings.boxoutline.ZIndex = 1;
                
                    espCache[player] = drawings;
                end
                
                local function removeEsp(player)
                    if rawget(espCache, player) then
                        for _, drawing in next, espCache[player] do
                            drawing:Remove();
                        end
                        espCache[player] = nil;
                    end
                end
                
                local function updateEsp(player, esp)
                    if not _G.BoxEnabled then -- Check if ESP is enabled globally
                        esp.box.Visible = false;
                        esp.boxoutline.Visible = false;
                        return
                    end
                    
                    local character = player and player.Character;
                    if character then
                        local cframe = character:GetModelCFrame();
                        local position, visible, depth = wtvp(cframe.Position);
                        esp.box.Visible = visible;
                        esp.boxoutline.Visible = visible;
                
                        if cframe and visible then
                            local scaleFactor = 1 / (depth * tan(rad(camera.FieldOfView / 2)) * 2) * 1000;
                            local width, height = round(4 * scaleFactor, 5 * scaleFactor);
                            local x, y = round(position.X, position.Y);
                
                            esp.box.Size = newVector2(width, height);
                            esp.box.Position = newVector2(x - width / 2, y - height / 2);
                            esp.box.Color = settings.teamcolor and player.TeamColor.Color or settings.defaultcolor;
                
                            esp.boxoutline.Size = esp.box.Size;
                            esp.boxoutline.Position = esp.box.Position;
                        end
                    else
                        esp.box.Visible = false;
                        esp.boxoutline.Visible = false;
                    end
                end
                
                -- main
                for _, player in next, players:GetPlayers() do
                    if player ~= localPlayer then
                        createEsp(player);
                    end
                end
                
                players.PlayerAdded:Connect(function(player)
                    createEsp(player);
                end);
                
                players.PlayerRemoving:Connect(function(player)
                    removeEsp(player);
                end)
                
                runService:BindToRenderStep("esp", Enum.RenderPriority.Camera.Value, function()
                    for player, drawings in next, espCache do
                        if settings.teamcheck and player.Team == localPlayer.Team then
                            continue;
                        end
                
                        if drawings and player ~= localPlayer then
                            updateEsp(player, drawings);
                        end
                    end
                end)
 
            end,
        })

        local ATMToggle = VisTab:CreateToggle({
            Name = "Active ATM ESP",
            CurrentValue = false,
            Flag = "ActiveATMESP",
            Callback = function(Value)
                local ATMSFolder = game:GetService("Workspace").ATMS
                local activeATMs = {}
                _G.TextVisible = Value -- Initially not visible

                -- Function to create or update the text drawing object for an ATM
                local function updateTextDrawing(atm)
                    if not _G.TextVisible then return end -- Check if text visibility is disabled

                    if activeATMs[atm] then
                        activeATMs[atm]:Remove()
                    end
                    
                    local text = "ATM Active"
                    local textDrawing = Drawing.new("Text")
                    textDrawing.Text = text
                    textDrawing.Size = 20
                    textDrawing.Color = Color3.fromRGB(255, 255, 255)
                    
                    local viewportPosition = game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(atm.Position)
                    textDrawing.Position = Vector2.new(viewportPosition.X, viewportPosition.Y) -- Convert to Vector2
                    textDrawing.Visible = true
                    activeATMs[atm] = textDrawing
                end

                -- Function to check for active ATMs and update text drawings
                local function updateActiveATMs()
                    if not _G.TextVisible then
                        for _, textDrawing in pairs(activeATMs) do
                            textDrawing:Remove() -- Remove all text drawings
                        end
                        activeATMs = {} -- Clear the table
                        return
                    end

                    for _, ATM in pairs(ATMSFolder:GetChildren()) do
                        local proximityPrompt = ATM:FindFirstChild("Attachment") and ATM.Attachment:FindFirstChild("ProximityPrompt")
                        if proximityPrompt and proximityPrompt.Enabled then
                            updateTextDrawing(ATM)
                        elseif activeATMs[ATM] then
                            activeATMs[ATM]:Remove()
                            activeATMs[ATM] = nil
                        end
                    end
                end

                -- Call the function initially and set up a loop to continuously check for active ATMs
                updateActiveATMs()
                game:GetService("RunService").Stepped:Connect(function()
                    updateActiveATMs()
                end)
 
            end,
        })

        local EquipToggle = VisTab:CreateToggle({
            Name = "Equipped ESP",
            CurrentValue = false,
            Flag = "EquippedESP",
            Callback = function(Value)
                toggleESP()  
            end,
        })

        local NameToggle = VisTab:CreateToggle({
            Name = "Name ESP",
            CurrentValue = false,
            Flag = "NameESP",
            Callback = function(Value)
                local c = workspace.CurrentCamera
                local ps = game:GetService("Players")
                local lp = ps.LocalPlayer
                local rs = game:GetService("RunService")

                -- Define a global variable to control ESP state
                _G.ESPEnabled = Value

                local function esp(p,cr)
                    local h = cr:WaitForChild("Humanoid")
                    local hrp = cr:WaitForChild("HumanoidRootPart")

                    local text = Drawing.new("Text")
                    text.Visible = false
                    text.Center = true
                    text.Outline = true 
                    text.Font = 2
                    text.Color = Color3.fromRGB(255,255,255)
                    text.Size = 13

                    local c1
                    local c2
                    local c3

                    local function dc()
                        text.Visible = false
                        text:Remove()
                        if c1 then
                            c1:Disconnect()
                            c1 = nil 
                        end
                        if c2 then
                            c2:Disconnect()
                            c2 = nil 
                        end
                        if c3 then
                            c3:Disconnect()
                            c3 = nil 
                        end
                    end

                    c2 = cr.AncestryChanged:Connect(function(_,parent)
                        if not parent then
                            dc()
                        end
                    end)

                    c3 = h.HealthChanged:Connect(function(v)
                        if (v<=0) or (h:GetState() == Enum.HumanoidStateType.Dead) then
                            dc()
                        end
                    end)

                    c1 = rs.RenderStepped:Connect(function()
                        if _G.ESPEnabled then -- Check if ESP is enabled
                            local hrp_pos,hrp_onscreen = c:WorldToViewportPoint(hrp.Position)
                            if hrp_onscreen then
                                local yOffset = 50 -- Adjust this value to change the height of the text
                                text.Position = Vector2.new(hrp_pos.X, hrp_pos.Y - yOffset)
                                text.Text = p.Name
                                text.Visible = true
                            else
                                text.Visible = false
                            end
                        else
                            dc() -- Disable ESP if not enabled
                        end
                    end)    
                end

                local function p_added(p)
                    if p.Character then
                        esp(p,p.Character)
                    end
                    p.CharacterAdded:Connect(function(cr)
                        esp(p,cr)
                    end)
                end

                for i,p in next, ps:GetPlayers() do 
                    if p ~= lp then
                        p_added(p)
                    end
                end

                ps.PlayerAdded:Connect(p_added)

            end,
        })

        -- [Misc Tab] --
        local IPButton = MiscTab:CreateButton({
            Name = "Instant Proximity",
            Callback = function()
                for i,v in ipairs(game:GetService("Workspace"):GetDescendants()) do
                    if v.ClassName == "ProximityPrompt" then
                     v.HoldDuration = 0
                    end
                   end                   
            end,
         })

        local SmallButton = MiscTab:CreateButton({
            Name = "Join smallest server",
            Callback = function()
                local Http = game:GetService("HttpService")
                local TPS = game:GetService("TeleportService")
                local Api = "https://games.roblox.com/v1/games/"
                
                local _place = game.PlaceId
                local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
                function ListServers(cursor)
                  local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
                  return Http:JSONDecode(Raw)
                end
                
                local Server, Next; repeat
                  local Servers = ListServers(Next)
                  Server = Servers.data[1]
                  Next = Servers.nextPageCursor
                until Server
                
                TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)               
            end,
         })

         
         local RejoinButton = MiscTab:CreateButton({
            Name = "Rejoin server",
            Callback = function()
                local ts = game:GetService("TeleportService")
                local p = game:GetService("Players").LocalPlayer
                ts:Teleport(game.PlaceId, p)        
            end,
         })

         local HopButton = MiscTab:CreateButton({
            Name = "Server Hop",
            Callback = function()
                local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua")()
                module:Teleport(game.PlaceId)     
            end,
         })

        -- [Credit Tab] --
        local DiscordButton = CreditTab:CreateButton({
            Name = "Join the Discord!",
            Callback = function()
                local HttpService = game:GetService("HttpService")
                local requestFunction = (syn and syn.request) or (http and http.request) or http_request
                
                if requestFunction then
                    local nonce = HttpService:GenerateGUID(false)
                    local requestBody = HttpService:JSONEncode({
                        cmd = 'INVITE_BROWSER',
                        nonce = nonce,
                        args = {code = "8yDaDVQWNC"}
                    })
                    
                    requestFunction({
                        Url = 'http://127.0.0.1:6463/rpc?v=1',
                        Method = 'POST',
                        Headers = {
                            ['Content-Type'] = 'application/json',
                            Origin = 'https://discord.com'
                        },
                        Body = requestBody
                    })
                else
                    warn("Unable to make HTTP request: requestFunction is not available")
                end                
            end,
         })
elseif game.PlaceId == 9874911474 then
------\\Booting//
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Requisition | Tha Bronx 2",
    LoadingTitle = "Requisition Script Hub",
    LoadingSubtitle = "discord.gg/8yDaDVQWNC",
    ConfigurationSaving = {
       Enabled = false,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "Requisition"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = False, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided",
       FileName = "Quis", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"Test"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })

------\\Chat Spy//------
enabled = true -- chat "/spy" to toggle!
spyOnMyself = true -- if true will check your messages too
public = false -- if true will chat the logs publicly (fun, risky)
publicItalics = true -- if true will use /me to stand out
privateProperties = { -- customize private logs
    Color = Color3.fromRGB(0,255,255),
    Font = Enum.Font.SourceSansBold,
    TextSize = 18,
}

local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() or Players.LocalPlayer
local saymsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
local instance = (_G.chatSpyInstance or 0) + 1
_G.chatSpyInstance = instance

local function onChatted(p, msg)
    if _G.chatSpyInstance == instance then
        if p == player and msg:lower():sub(1, 4) == "/spy" then
            enabled = not enabled
            wait(0.3)
            privateProperties.Text = "{SPY " .. (enabled and "EN" or "DIS") .. "ABLED}"
            StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)
        elseif enabled and (spyOnMyself == true or p ~= player) then
            msg = msg:gsub("[\n\r]", ''):gsub("\t", ' '):gsub("[ ]+", ' ')
            local hidden = true
            local conn = getmsg.OnClientEvent:Connect(function(packet, channel)
                if packet.SpeakerUserId == p.UserId and packet.Message == msg:sub(#msg - #packet.Message + 1) and (channel == "All" or (channel == "Team" and public == false and Players[packet.FromSpeaker].Team == player.Team)) then
                    hidden = false
                end
            end)
            wait(1)
            conn:Disconnect()
            if hidden and enabled then
                if public then
                    saymsg:FireServer((publicItalics and "/me " or '') .. "{SPY} [" .. p.Name .. "]: " .. msg, "All")
                else
                    privateProperties.Text = "{SPY} [" .. p.Name .. "]: " .. msg
                    StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)
                end
            end
        end
    end
end

for _, p in ipairs(Players:GetPlayers()) do
    p.Chatted:Connect(function(msg) onChatted(p, msg) end)
end

Players.PlayerAdded:Connect(function(p)
    p.Chatted:Connect(function(msg) onChatted(p, msg) end)
end)

privateProperties.Text = "{SPY " .. (enabled and "EN" or "DIS") .. "ABLED}"
StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)

if not player.PlayerGui:FindFirstChild("Chat") then wait(3) end

local chatFrame = player.PlayerGui.Chat.Frame
chatFrame.ChatChannelParentFrame.Visible = true
chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), chatFrame.ChatChannelParentFrame.Size.Y)



------\\Spec//------
 local Players = game.Players
 local LocalPlayer = Players.LocalPlayer
  local function teleportToPlayer(playerName)
     local playerToTeleport = Players:FindFirstChild(playerName)
     if playerToTeleport then
         local character = LocalPlayer.Character
         local humanoid = character:FindFirstChildOfClass("Humanoid")
         local rootPart = character:FindFirstChild("HumanoidRootPart")
 
         local targetCharacter = playerToTeleport.Character
         local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
 
         if targetRootPart then
             rootPart.CFrame = targetRootPart.CFrame
         end
     end
 end
 
 ------\\Esp Library//------
 local c = workspace.CurrentCamera
local ps = game:GetService("Players")
local lp = ps.LocalPlayer
local rs = game:GetService("RunService")

_G.ESP_ENABLED = false 

local function ftool(cr)
    for _, b in ipairs(cr:GetChildren()) do 
        if b:IsA("Tool") then
            return tostring(b.Name)
        end
    end
    return 'empty'
end

local function esp(p, cr)
    local h = cr:WaitForChild("Humanoid")
    local hrp = cr:WaitForChild("HumanoidRootPart")

    local text = Drawing.new('Text')
    text.Visible = false
    text.Center = true
    text.Outline = true
    text.Color = Color3.new(1, 1, 1)
    text.Font = 2
    text.Size = 13

    local c1 
    local c2
    local c3 

    local function dc()
        text.Visible = false
        text:Remove()
        if c3 then
            c1:Disconnect()
            c2:Disconnect()
            c3:Disconnect()
            c1 = nil 
            c2 = nil
            c3 = nil
        end
    end

    c2 = cr.AncestryChanged:Connect(function(_, parent)
        if not parent then
            dc()
        end
    end)

    c3 = h.HealthChanged:Connect(function(v)
        if (v <= 0) or (h:GetState() == Enum.HumanoidStateType.Dead) then
            dc()
        end
    end)

    c1 = rs.Heartbeat:Connect(function()
        local hrp_pos, hrp_os = c:WorldToViewportPoint(hrp.Position)
        if hrp_os and _G.ESP_ENABLED then
            text.Position = Vector2.new(hrp_pos.X, hrp_pos.Y)
            text.Text = '[ '..tostring(ftool(cr))..' ]'
            text.Visible = true
        else
            text.Visible = false
        end
    end)
end

local function p_added(p)
    if p.Character then
        esp(p, p.Character)
    end
    p.CharacterAdded:Connect(function(cr)
        esp(p, cr)
    end)
end


local function toggleESP()
    _G.ESP_ENABLED = not _G.ESP_ENABLED
end


ps.PlayerAdded:Connect(p_added)


for _, b in ipairs(ps:GetPlayers()) do 
    if b ~= lp then
        p_added(b)
    end
end


local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local function teleportToPlayer(playerName)
    local playerToTeleport = Players:FindFirstChild(playerName)
    if playerToTeleport then
        local character = LocalPlayer.Character
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart")

        local targetCharacter = playerToTeleport.Character
        local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")

        if targetRootPart then
            rootPart.CFrame = targetRootPart.CFrame
        end
    end
end
 
 
 
 
 ------\\SPIN BOT//------
 -- Create a function to handle the spin bot behavior
 local player = game.Players.LocalPlayer
 local spinEnabled = false
 local spinSpeed = 0
 
 local function spinBot(speed)
     while spinEnabled do
         game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(speed), 0)
         wait(0.1)
     end
 end
 
 local function adjustSpin()
     if spinEnabled then
         spinBot(spinSpeed)
     else
         -- You can add code here to stop the spinning effect
     end
 end
 
 ------//Send money\\
 function SendMoneyToPlayer(playerName, amount)
    local args = {
        [1] = "Send",
        [2] = amount,
        [3] = playerName
    }
    game:GetService("ReplicatedStorage").BankProcessRemote:InvokeServer(unpack(args))
end

local toggleLoop
 

 
 ------\\G.functions//
 
 _G.Moneyfarm = true
 
 ------\\button Functions//

 function RemoteSpy()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpyBeta.lua"))()
   wait(.01)
end
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local TeleportOptions = {}

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        table.insert(TeleportOptions, player.Name)
    end
end
 
 ------\\REAL FUNCTIONS//

 local noclipEnabled = false
 local Noclip = nil
 
 local function enableNoclip()
     if not noclipEnabled then
         noclipEnabled = true
 
         if Noclip then
             Noclip:Disconnect()
         end
 
         local character = game.Players.LocalPlayer.Character
         if character then
             for _, part in ipairs(character:GetDescendants()) do
                 if part:IsA('BasePart') then
                     part.CanCollide = false
                 end
             end
         end
 
         Noclip = game:GetService('RunService').Stepped:Connect(noclip)
     end
 end
 
 local function disableNoclip()
     if noclipEnabled then
         noclipEnabled = false
 
         if Noclip then
             Noclip:Disconnect()
         end
 
         local character = game.Players.LocalPlayer.Character
         if character then
             for _, part in ipairs(character:GetDescendants()) do
                 if part:IsA('BasePart') then
                     part.CanCollide = true
                 end
             end
         end
     end
 end
 
------\\Legit-Hitbox Toggle function//------
local player = game.Players.LocalPlayer
local HitboxEnabled4 = false

local function adjustHitbox(player)
    print("Adjusting hitbox for player:", player.Name)
    if player.Character then
        local upperTorso = player.Character:FindFirstChild("UpperTorso")
        local lowerTorso = player.Character:FindFirstChild("LowerTorso")
        if upperTorso and lowerTorso then
            if HitboxEnabled4 then
                pcall(function()
                    -- Adjust the hitbox properties when enabled
                    upperTorso.Size = Vector3.new(2, 2, 2)
                    upperTorso.Transparency = 0.9
                    upperTorso.BrickColor = BrickColor.new("Glass")
                    upperTorso.Material = "Glass"
                    upperTorso.CanCollide = false
                    
                    lowerTorso.Size = Vector3.new(2, 2, 2)
                    lowerTorso.Transparency = 0.9
                    lowerTorso.BrickColor = BrickColor.new("Glass")
                    lowerTorso.Material = "Glass"
                    lowerTorso.CanCollide = false
                end)
            else
                pcall(function()
                    -- Reset the hitbox properties when disabled
                    upperTorso.Size = Vector3.new(2, 2, 1)
                    upperTorso.Transparency = 0.1
                    upperTorso.BrickColor = BrickColor.new("Glass")
                    upperTorso.Material = "Glass"
                    upperTorso.CanCollide = true
                    
                    lowerTorso.Size = Vector3.new(0, 0, 0)
                    lowerTorso.Transparency = 0.1
                    lowerTorso.BrickColor = BrickColor.new("Glass")
                    lowerTorso.Material = "Glass"
                    lowerTorso.CanCollide = true
                end)
            end
        end
    end
end

-- Function to apply hitbox state to all players
local function applyHitboxStateToAllPlayers4()
    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player then
            adjustHitbox(otherPlayer)
        end
    end
end

-- Function to handle player added events
local function onPlayerAdded(player)
    print("Player added:", player.Name)
    player.CharacterAdded:Connect(function(character)
        wait(1) -- Delay to ensure character fully loads
        adjustHitbox(player)
    end)
end

local function onPlayerRespawn(player)
    print("Player respawned:", player.Name)
    player.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid").Died:Connect(function()
            wait(35) -- Delay to allow time for respawn
            adjustHitbox(player)
        end)
    end)
end

-- Initialize hitbox state when the script starts
applyHitboxStateToAllPlayers4()

-- Listen for player added events
game.Players.PlayerAdded:Connect(onPlayerAdded)
print("Player added event connected")

game.Players.PlayerAdded:Connect(function(player)
    onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        wait(1) -- Delay to ensure character fully loads
        adjustHitbox(player)
    end)
end)
print("Player added and respawn events connected")

------\\Semi-Legit-Hitbox//------
local player = game.Players.LocalPlayer
local HitboxEnabled3 = false

local function adjustHitbox(player)
    print("Adjusting hitbox for player:", player.Name)
    if player.Character then
        local head = player.Character:FindFirstChild("Head")
        if head then
            if HitboxEnabled3 then
                pcall(function()
                    -- Adjust the hitbox properties when enabled
                    head.Size = Vector3.new(2, 2, 2)
                    head.Transparency = 0.9
                    head.BrickColor = BrickColor.new("Glass")
                    head.Material = "Glass"
                    head.CanCollide = false
                end)
            else
                pcall(function()
                    -- Reset the hitbox properties when disabled
                    -- You can adjust these properties as needed when the hitbox is disabled
                    head.Size = Vector3.new(0, 0, 0)
                    head.Transparency = 0
                    head.BrickColor = BrickColor.new("Glass")
                    head.Material = "Glass"
                    head.CanCollide = true
                end)
            end
        end
    end
end

-- Function to apply hitbox state to all players
local function applyHitboxStateToAllPlayers3()
    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player then
            adjustHitbox(otherPlayer)
        end
    end
end

-- Function to handle player added events
local function onPlayerAdded(player)
    print("Player added:", player.Name)
    player.CharacterAdded:Connect(function(character)
        wait(1) -- Delay to ensure character fully loads
        adjustHitbox(player)
    end)
end

local function onPlayerRespawn(player)
    print("Player respawned:", player.Name)
    player.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid").Died:Connect(function()
            wait(35) -- Delay to allow time for respawn
            adjustHitbox(player)
        end)
    end)
end

-- Initialize hitbox state when the script starts
applyHitboxStateToAllPlayers3()

-- Listen for player added events
game.Players.PlayerAdded:Connect(onPlayerAdded)
print("Player added event connected")

game.Players.PlayerAdded:Connect(function(player)
    onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        wait(1) -- Delay to ensure character fully loads
        adjustHitbox(player)
    end)
end)
print("Player added and respawn events connected")

------\\Rage-Hitbox V2 Toggle Function//------
local player = game.Players.LocalPlayer
local HitboxEnabled = false

local function adjustHitbox(player)
    print("Adjusting hitbox for player:", player.Name)
    if player.Character then
        local head = player.Character:FindFirstChild("Head")
        if head then
            if HitboxEnabled then
                pcall(function()
                    -- Adjust the hitbox properties when enabled
                    head.Size = Vector3.new(5, 5, 5)
                    head.Transparency = 0.9
                    head.BrickColor = BrickColor.new("Glass")
                    head.Material = "Glass"
                    head.CanCollide = false
                end)
            else
                pcall(function()
                    -- Reset the hitbox properties when disabled
                    -- You can adjust these properties as needed when the hitbox is disabled
                    head.Size = Vector3.new(1, 1, 1)
                    head.Transparency = 0.9
                    head.BrickColor = BrickColor.new("Glass")
                    head.Material = "Glass"
                    head.CanCollide = true
                end)
            end
        end
    end
end

-- Function to apply hitbox state to all players
local function applyHitboxStateToAllPlayers()
    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player then
            adjustHitbox(otherPlayer)
        end
    end
end

-- Function to handle player added events
local function onPlayerAdded(player)
    print("Player added:", player.Name)
    player.CharacterAdded:Connect(function(character)
        wait(0) -- Delay to ensure character fully loads
        adjustHitbox(player)
    end)
end

local function onPlayerRespawn(player)
    print("Player respawned:", player.Name)
    player.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid").Died:Connect(function()
            wait(0) -- Delay to allow time for respawn
            adjustHitbox(player)
        end)
    end)
end

-- Initialize hitbox state when the script starts
applyHitboxStateToAllPlayers()

-- Listen for player added events
game.Players.PlayerAdded:Connect(onPlayerAdded)
print("Player added event connected")

game.Players.PlayerAdded:Connect(function(player)
    onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        wait(0) -- Delay to ensure character fully loads
        adjustHitbox(player)
    end)
end)
print("Player added and respawn events connected")


------\\Rage Keybind//------
local player = game.Players.LocalPlayer
local HitboxEnabled5 = false

local function adjustHitbox(targetPlayer)
    print("Adjusting hitbox for player:", targetPlayer.Name)
    if targetPlayer.Character then
        local head = targetPlayer.Character:FindFirstChild("Head")
        if head then
            if HitboxEnabled5 then
                pcall(function()
                    -- Adjust the hitbox properties when enabled
                    head.Size = Vector3.new(5, 5, 5)
                    head.Transparency = 0.9
                    head.BrickColor = BrickColor.new("Glass")
                    head.Material = "Glass"
                    head.CanCollide = false
                end)
            else
                pcall(function()
                    -- Reset the hitbox properties when disabled
                    head.Size = Vector3.new(1, 1, 1)
                    head.Transparency = 0.9
                    head.BrickColor = BrickColor.new("Glass")
                    head.Material = "Glass"
                    head.CanCollide = true
                end)
            end
        end
    end
end

-- Function to apply hitbox state to all players
local function applyHitboxStateToAllPlayers5()
    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player then
            adjustHitbox(otherPlayer)
        end
    end
end

-- Toggle function to be called by the keybind
local function toggleHitbox()
    HitboxEnabled5 = not HitboxEnabled5 -- Toggle the state
    applyHitboxStateToAllPlayers5() -- Apply the new state to all players
end





------\\Money Farm Function//------
 -- Define global variable to control the autofarm state
 _G.autofarmEnabled = false

 local function pickUpMoney()
     for _, moneyInstance in pairs(workspace.Dollas:GetChildren()) do
         if moneyInstance:FindFirstChild("ProximityPrompt") then
             fireproximityprompt(moneyInstance.ProximityPrompt)
         end
     end
 end
 
 local function autofarm()
     while _G.autofarmEnabled do
         -- Step 1: Drop money
         local argsDrop = {
             [1] = "Drop",
             [2] = 0/0 -- NaN
         }
         game:GetService("ReplicatedStorage").BankProcessRemote:InvokeServer(unpack(argsDrop))
 
         -- Short wait to ensure money has been dropped
        
 
         -- Step 2: Attempt to pick up dropped money
         pickUpMoney()
 
         -- Short wait to ensure money has been picked up
         wait(0)
 
         -- Step 3: Deposit picked up money
         local argsDeposit = {
             [1] = "depo",
             [2] = "29000" -- Update this value to the amount you want to deposit
         }
         game:GetService("ReplicatedStorage").BankAction:FireServer(unpack(argsDeposit))
 
         -- Adjust the wait time as needed for your use case
         wait(0)
     end
 end
 

------\\Hitbox keybind//------
local player = game.Players.LocalPlayer
local HitboxEnabled5 = false

local function adjustHitbox(targetPlayer)
    print("Adjusting hitbox for player:", targetPlayer.Name)
    if targetPlayer.Character then
        local head = targetPlayer.Character:FindFirstChild("Head")
        if head then
            if HitboxEnabled5 then
                pcall(function()
                    -- Adjust the hitbox properties when enabled
                    head.Size = Vector3.new(5, 5, 5)
                    head.Transparency = 0.9
                    head.BrickColor = BrickColor.new("Glass")
                    head.Material = "Glass"
                    head.CanCollide = false
                end)
            else
                pcall(function()
                    -- Reset the hitbox properties when disabled
                    head.Size = Vector3.new(1, 1, 1)
                    head.Transparency = 0.9
                    head.BrickColor = BrickColor.new("Glass")
                    head.Material = "Glass"
                    head.CanCollide = true
                end)
            end
        end
    end
end

-- Function to apply hitbox state to all players
local function applyHitboxStateToAllPlayers5()
    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player then
            adjustHitbox(otherPlayer)
        end
    end
end

-- Toggle function to be called by the keybind
local function toggleHitbox()
    HitboxEnabled5 = not HitboxEnabled5 -- Toggle the state
    applyHitboxStateToAllPlayers5() -- Apply the new state to all players
end

 ------\\Tab 1//------
 local MainTab = Window:CreateTab("Home🏠", nil) -- Title, Image
 local MainSection = MainTab:CreateSection("Main")

 local VisTab = Window:CreateTab("Visuals", nil) -- Title, Image
 local VisSection = VisTab:CreateSection("Esp")
 
 ------\\Tab 2//------
  local MoneyTab = Window:CreateTab("Money-Farm💲💵", nil) -- Title, Image
  local MoneySection = MoneyTab:CreateSection("Money")
 
 ------\\Tab 3//------
  local PvpTab = Window:CreateTab("Target🎯", nil) -- Title, Image
  local PvpSection = PvpTab:CreateSection("Pvp")

  ------\\Tab 4//------
  local MiscTab = Window:CreateTab("Misc✔", nil) -- Title, Image
  local MiscSection = MiscTab:CreateSection("Misc")

  ------\\Tab 5//------
  local BlatantTab = Window:CreateTab("Blatant😎", nil) -- Title, Image
  local BlatantSection = BlatantTab:CreateSection("Blatant")


  ------\\Tab 6//------
  local LocationTab = Window:CreateTab("Locations📍", nil) -- Title, Image
  local LocationSection = LocationTab:CreateSection("Teleport")

  ------\\Tab 7//------
  local ShopTab = Window:CreateTab("Shop🛒", nil) -- Title, Image
  local ShopSection = ShopTab:CreateSection("Shop")


  ------\\Main Tab//------

 local Slider = MainTab:CreateSlider({
	Name = "[Walk-Speed]",
	Range = {16, 250},
	Increment = 10,
	Suffix = "Walkspeed",
	CurrentValue = 10,
	Flag = "WalkspeedSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(V)
        _G.WS = (V); -- Enter speed here
        local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid;
        Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        Humanoid.WalkSpeed = _G.WS;
        end)
        Humanoid.WalkSpeed = _G.WS;
    end,
})

local Slider = MainTab:CreateSlider({
	Name = "[Jump-Power]",
	Range = {16, 250},
	Increment = 10,
	Suffix = "Jump Power",
	CurrentValue = 85,
	Flag = "JumpPowerSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(G)
		game:GetService('Players').LocalPlayer.Character.Humanoid.JumpPower = G
    		-- The variable (Value) is a number which correlates to the value the slider is currently at
	end,
})

local Slider = MainTab:CreateSlider({
    Name = "[Gravity]",
    Range = {0, 85},
    Increment = 10,
    Suffix = "Gravity Slider",
    CurrentValue = 10,
    Flag = "GravitySlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(V)
        wait()
        game.workspace.Gravity = V
    end,
 })

local Toggle = MainTab:CreateToggle({
	Name = "[Inf Jump]",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(infjmp)
		local infjmp = true
        game:GetService("UserInputService").jumpRequest:Connect(function()
            if infjmp then
                game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass"Humanoid":ChangeState("Jumping")
            end
        end)
        
	end,
})

local Label = MainTab:CreateLabel("Feel Free To Support Us❤")
local Button = MainTab:CreateButton({
    Name = "[Send Tweet]",
    Callback = function()
        local args = {
            [1] = "Tweet",
            [2] = {
                [1] = "CreateTweet",
                [2] = "Want Free Money? join,gg/NhpfQWJJ❤"
            }
        }
        
        game:GetService("ReplicatedStorage").Resources["#Phone"].Main:FireServer(unpack(args))
        
    end,
 })
















------\\Pvp Tab//------
local Label = PvpTab:CreateLabel("[Selected Target]")
local TargetName = ""
local function CheckPlr2(arg)
    for i,v in pairs(game.Players:GetChildren()) do
        if (string.sub(string.lower(v.Name),1,string.len(arg))) == string.lower(arg) then
            TargetName = v.Name
        end
        if (string.sub(string.lower(v.DisplayName),1,string.len(arg))) == string.lower(arg) then
            TargetName = v.Name
        end
    end
    return nil
end
local Input = PvpTab:CreateInput({
    Name = "[Target Name]",
    PlaceholderText = "type here",
    RemoveTextAfterFocusLost = false,
    Callback = function(Target)
    -- The function that takes place when the input is changed
    -- The variable (Text) is a string for the value in the text box
    CheckPlr2(Target)
    Label:Set("Selected target:".. Target)
    for i = 1, 10 do
    print(Target)
    end
    end
 })

 local button = PvpTab:CreateButton({
    Name = "[Teleport to Player📍]",
    Callback = function()
        --game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[TargetName].Character.HumanoidRootPart.CFrame
        teleportToPlayer(TargetName)
      end    
   })
 


local Toggle = PvpTab:CreateToggle({
    Name = "[Spectate👀]",
    CurrentValue = false,
    Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
if Value == true then
    game.Workspace.Camera.CameraSubject = game.Players[TargetName].Character:FindFirstChild("HumanoidRootPart")
elseif Value ~= true then
    game.Workspace.Camera.CameraSubject = LocalPlayer.Character.HumanoidRootPart 
    end
end,
 })

------\\MONEY TAB//------
local Button = MoneyTab:CreateButton({
	Name = "[Deposit Money]",
	Callback = function()
		local args = {
            [1] = "depo",
            [2] = "29000"
        }
        
        game:GetService("ReplicatedStorage").BankAction:FireServer(unpack(args))
        
	end,
})

local Button = MoneyTab:CreateButton({
	Name = "[Withdraw Money]",
	Callback = function()
		local args = {
            [1] = "with",
            [2] = "90000"
        }
        
        game:GetService("ReplicatedStorage").BankAction:FireServer(unpack(args))
        
	end,
})


-- Create the toggle control in your UI library
local Toggle = MoneyTab:CreateToggle({
    Name = "[Autofarm-Money]",
    CurrentValue = false,
    Flag = "AutofarmMoneyToggle", -- Make sure this flag is unique
    Callback = function(Value)
        _G.autofarmEnabled = Value
        if _G.autofarmEnabled then
            autofarm() -- Start autofarming when toggle is turned on
        end
    end,
})

local Toggle = PvpTab:CreateToggle({
    Name = "[Send Money]",
    CurrentValue = false,
    Flag = "SendMoneyToggle",
    Callback = function(Value)
        -- The function that takes place when the toggle is pressed
        -- The variable (Value) is a boolean on whether the toggle is true or false
        if Value then
            toggleLoop = true
            while toggleLoop do
                local selectedPlayer = TargetName -- Replace this with your method of getting the selected player
                local amountToSend = 9999 -- Change this to the desired amount
                SendMoneyToPlayer(selectedPlayer, amountToSend)
                wait(1) -- Wait for a certain amount of time before sending money again (in seconds)
            end
        else
            toggleLoop = false
        end
    end,
})

------\\ANNOY TOGGLE AND  FUNCTIONS//------
-- Declare the toggle variable at a scope accessible by both the function and the button callback
local toggleAttack = false

local function AttackCheckKnockPickUpAndTeleportFunction()
    local originalCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

    while toggleAttack do -- Loop will continue as long as toggleAttack is true
        local playerToAttack = game.Players:FindFirstChild(TargetName)
        if playerToAttack then
            local targetPlayerCFrame = playerToAttack.Character.HumanoidRootPart.CFrame
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayerCFrame

            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Fist") or game.Players.LocalPlayer.Character:FindFirstChild("Fist")
            if tool then
                if not game.Players.LocalPlayer.Character:FindFirstChild(tool.Name) then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                end

                if playerToAttack.Character.Humanoid.Health > 30 then
                    tool.MeleeSystem.AttackEvent:FireServer(playerToAttack)
                end

                wait(0.1)

                if playerToAttack.Character.Humanoid.Health <= 10 then
                    local pickupArgs = {
                        [1] = playerToAttack
                    }
                    game:GetService("ReplicatedStorage").PickUpRemote:InvokeServer(unpack(pickupArgs))

                    wait(0.5)

                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = originalCFrame
                    toggleAttack = false -- Turn off the toggle if the player is knocked
                end
            else
                break
            end
        else
            break
        end
        wait()
    end
end

-- Create a toggle button that turns the attack on or off when pressed
local AttackKnockPickupToggleButton = PvpTab:CreateToggle({
    Name = "[AutoKnock-Annoy👿]",
    Default = false,
    Callback = function(state)
        toggleAttack = state -- Update the toggle variable with the new state
        if toggleAttack then
            AttackCheckKnockPickUpAndTeleportFunction() -- Start the function if toggled on
        end
    end,
})

------\\AutoKill Button//------

-- Define the existing auto-kill functionality as a separate function
local function AutoKillFunction()
    local function CheckPlayerDeath(player)
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            return player.Character.Humanoid.Health <= 0
        end
        return false
    end

    -- Store the original position before teleporting and attacking
    local originalCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

    local IsAttacking = true
    while IsAttacking do
        local playerToAttack = game.Players:FindFirstChild(TargetName)
        if playerToAttack then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Fist") or game.Players.LocalPlayer.Backpack:FindFirstChild("Fist"))
            if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid:TakeDamage(0) -- Reset Humanoid health to avoid crashing
            end
            game:GetService("Players").LocalPlayer.Character.Fist.MeleeSystem.AttackEvent:FireServer(playerToAttack)
            wait(0.1) -- Add a 0.1-second delay between each punch
        end

        local playerToTeleport = game.Players:FindFirstChild(TargetName)
        if playerToTeleport then
            local targetPlayerCFrame = playerToTeleport.Character.HumanoidRootPart.CFrame

            -- Teleport to the target player
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayerCFrame

            -- Check if the target player dies
            if CheckPlayerDeath(playerToTeleport) then
                -- Teleport back to the original position after killing the player
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = originalCFrame
                IsAttacking = false -- Stop attacking when the target player dies
            else
                wait(0) -- Add a delay after each teleportation if the player is still alive
            end
        end
        
        wait() -- Rapidly perform both teleportation and auto-attack with adjusted delays
    end
end

-- Create a button that triggers the AutoKillFunction when pressed
local Button = PvpTab:CreateButton({
    Name = "[Kill-Player💀]",
    Callback = function()
        AutoKillFunction()
    end,
})

------\\BLATANT TAB//------
------\\Legit Hitbox//------

local Toggle = BlatantTab:CreateToggle({
    Name = "= [Legit-Hitbox] =",
    CurrentValue = false,
    Flag = "LegitHitbox", -- Unique flag for configuration saving
    Callback = function(Value)
        -- Function to toggle hitbox
        HitboxEnabled4 = Value
        applyHitboxStateToAllPlayers4() -- Apply hitbox state when toggle changes
    end,
})



------\\semi Legit hitbox//------
local Toggle = BlatantTab:CreateToggle({
    Name = "= [Semi-Legit-Hitbox] =",
    CurrentValue = false,
    Flag = "semiLegit", -- Flag to store toggle state
    Callback = function(Value)
        HitboxEnabled3 = Value -- Update HitboxEnabled based on the toggle value
        applyHitboxStateToAllPlayers3() -- Apply the new hitbox state to all players
    end,
})

------\\Rage Hitbox//------
local Toggle = BlatantTab:CreateToggle({
    Name = "= [Rage-Hitbox] =",
    CurrentValue = false,
    Flag = "rage hitbox", -- Flag to store toggle state
    Callback = function(Value)
        HitboxEnabled = Value -- Update HitboxEnabled based on the toggle value
        applyHitboxStateToAllPlayers() -- Apply the new hitbox state to all players
    end,
})


-- Register the keybind with your UI library
local Keybind = BlatantTab:CreateKeybind({
    Name = "Toggle Hitbox",
    CurrentKeybind = "X",
    HoldToInteract = false,
    Flag = "HitboxKeybind", -- Unique flag for the keybind
    Callback = toggleHitbox, -- Set the callback to the toggle function
})








------\\SPIN BOT//------
local Toggle = BlatantTab:CreateToggle({
    Name = "[Spin-Bot]",
    CurrentValue = false,
    Flag = "SpinBotToggle",
    Callback = function(Value)
        spinEnabled = Value
        adjustSpin()
    end,
})

local Slider = BlatantTab:CreateSlider({
    Name = "[Spin-Speed]",
    Range = {40, 500},
    Increment = 10,
    Suffix = "Speed",
    CurrentValue = 0,
    Flag = "SpinSpeedSlider",
    Callback = function(Value)
        spinSpeed = Value
        if spinEnabled then
            adjustSpin()
        end
    end,
})

------\\Visuals//------
local BoxToggle = VisTab:CreateToggle({
    Name = "Box ESP",
    CurrentValue = false,
    Flag = "BoxESP",
    Callback = function(Value)
        -- settings
        local settings = {
            defaultcolor = Color3.fromRGB(255,0,0),
            teamcheck = false,
            teamcolor = true
        };
        
        -- Initialize global control for ESP
        _G.BoxEnabled = Value
        
        -- services
        local runService = game:GetService("RunService");
        local players = game:GetService("Players");
        
        -- variables
        local localPlayer = players.LocalPlayer;
        local camera = workspace.CurrentCamera;
        
        -- functions
        local newVector2, newColor3, newDrawing = Vector2.new, Color3.new, Drawing.new;
        local tan, rad = math.tan, math.rad;
        local round = function(...) local a = {}; for i,v in next, table.pack(...) do a[i] = math.round(v); end return unpack(a); end;
        local wtvp = function(...) local a, b = camera.WorldToViewportPoint(camera, ...) return newVector2(a.X, a.Y), b, a.Z end;
        
        local espCache = {};
        local function createEsp(player)
            local drawings = {};
            
            drawings.box = newDrawing("Square");
            drawings.box.Thickness = 1;
            drawings.box.Filled = false;
            drawings.box.Color = settings.defaultcolor;
            drawings.box.Visible = false;
            drawings.box.ZIndex = 2;
        
            drawings.boxoutline = newDrawing("Square");
            drawings.boxoutline.Thickness = 3;
            drawings.boxoutline.Filled = false;
            drawings.boxoutline.Color = newColor3(0, 0, 0); -- Default outline color, you can change it as needed.
            drawings.boxoutline.Visible = false;
            drawings.boxoutline.ZIndex = 1;
        
            espCache[player] = drawings;
        end
        
        local function removeEsp(player)
            if rawget(espCache, player) then
                for _, drawing in next, espCache[player] do
                    drawing:Remove();
                end
                espCache[player] = nil;
            end
        end
        
        local function updateEsp(player, esp)
            if not _G.ESPEnabled then -- Check if ESP is enabled globally
                esp.box.Visible = false;
                esp.boxoutline.Visible = false;
                return
            end
            
            local character = player and player.Character;
            if character then
                local cframe = character:GetModelCFrame();
                local position, visible, depth = wtvp(cframe.Position);
                esp.box.Visible = visible;
                esp.boxoutline.Visible = visible;
        
                if cframe and visible then
                    local scaleFactor = 1 / (depth * tan(rad(camera.FieldOfView / 2)) * 2) * 1000;
                    local width, height = round(4 * scaleFactor, 5 * scaleFactor);
                    local x, y = round(position.X, position.Y);
        
                    esp.box.Size = newVector2(width, height);
                    esp.box.Position = newVector2(x - width / 2, y - height / 2);
                    esp.box.Color = settings.teamcolor and player.TeamColor.Color or settings.defaultcolor;
        
                    esp.boxoutline.Size = esp.box.Size;
                    esp.boxoutline.Position = esp.box.Position;
                end
            else
                esp.box.Visible = false;
                esp.boxoutline.Visible = false;
            end
        end
        
        -- main
        for _, player in next, players:GetPlayers() do
            if player ~= localPlayer then
                createEsp(player);
            end
        end
        
        players.PlayerAdded:Connect(function(player)
            createEsp(player);
        end);
        
        players.PlayerRemoving:Connect(function(player)
            removeEsp(player);
        end)
        
        runService:BindToRenderStep("esp", Enum.RenderPriority.Camera.Value, function()
            for player, drawings in next, espCache do
                if settings.teamcheck and player.Team == localPlayer.Team then
                    continue;
                end
        
                if drawings and player ~= localPlayer then
                    updateEsp(player, drawings);
                end
            end
        end)

    end,
})

local EquipToggle = VisTab:CreateToggle({
    Name = "Equipped ESP",
    CurrentValue = false,
    Flag = "EquippedESP",
    Callback = function(Value)
        toggleESP()  
    end,
})

local NameToggle = VisTab:CreateToggle({
    Name = "Name ESP",
    CurrentValue = false,
    Flag = "NameESP",
    Callback = function(Value)
        local c = workspace.CurrentCamera
        local ps = game:GetService("Players")
        local lp = ps.LocalPlayer
        local rs = game:GetService("RunService")

        -- Define a global variable to control ESP state
        _G.ESPEnabled = Value

        local function esp(p,cr)
            local h = cr:WaitForChild("Humanoid")
            local hrp = cr:WaitForChild("HumanoidRootPart")

            local text = Drawing.new("Text")
            text.Visible = false
            text.Center = true
            text.Outline = true 
            text.Font = 2
            text.Color = Color3.fromRGB(255,255,255)
            text.Size = 13

            local c1
            local c2
            local c3

            local function dc()
                text.Visible = false
                text:Remove()
                if c1 then
                    c1:Disconnect()
                    c1 = nil 
                end
                if c2 then
                    c2:Disconnect()
                    c2 = nil 
                end
                if c3 then
                    c3:Disconnect()
                    c3 = nil 
                end
            end

            c2 = cr.AncestryChanged:Connect(function(_,parent)
                if not parent then
                    dc()
                end
            end)

            c3 = h.HealthChanged:Connect(function(v)
                if (v<=0) or (h:GetState() == Enum.HumanoidStateType.Dead) then
                    dc()
                end
            end)

            c1 = rs.RenderStepped:Connect(function()
                if _G.ESPEnabled then -- Check if ESP is enabled
                    local hrp_pos,hrp_onscreen = c:WorldToViewportPoint(hrp.Position)
                    if hrp_onscreen then
                        local yOffset = 50 -- Adjust this value to change the height of the text
                        text.Position = Vector2.new(hrp_pos.X, hrp_pos.Y - yOffset)
                        text.Text = p.Name
                        text.Visible = true
                    else
                        text.Visible = false
                    end
                else
                    dc() -- Disable ESP if not enabled
                end
            end)    
        end

        local function p_added(p)
            if p.Character then
                esp(p,p.Character)
            end
            p.CharacterAdded:Connect(function(cr)
                esp(p,cr)
            end)
        end

        for i,p in next, ps:GetPlayers() do 
            if p ~= lp then
                p_added(p)
            end
        end

        ps.PlayerAdded:Connect(p_added)

    end,
})















------\\Misc//
local Toggle = MiscTab:CreateToggle({
    Name = "[No clip]",
    CurrentValue = false,
    Flag = "NoclipToggle", -- A unique flag identifier
    Callback = function(Value)
        if Value then
            enableNoclip()
        else
            disableNoclip()
        end
    end,
})



local Slider = MiscTab:CreateSlider({
	Name = "[Brightness Changer]",
	Range = {1, 1000},
	Increment = 10,
	Suffix = "Brightness",
	CurrentValue = 10,
	Flag = "Brightness Changer", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(V)
		local Lighting = game:GetService("Lighting")
          Lighting.Brightness = 1
          Lighting.OutdoorAmbient = Color3.fromRGB(V, V, V)

    		-- The variable (Value) is a number which correlates to the value the slider is currently at
	end,
})
















------\\TESTING DUMB STUFF//------


------\\TEST V2//------
local Button = ShopTab:CreateButton({
	Name = "[Buy Shiesty😷]",
	Callback = function()
		local args = {
            [1] = "Shiesty"
        }
         game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(unpack(args))
        
	end,
})

local Button = ShopTab:CreateButton({
	Name = "[Buy Taco🌮]",
	Callback = function()
		local args = {
            [1] = "Taco"
        }
         game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(unpack(args))
        
	end,
})

local Button = ShopTab:CreateButton({
	Name = "[Buy Pizza🍕]",
	Callback = function()
		local args = {
            [1] = "Pizza"
        }
         game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(unpack(args))
        
	end,
})

local Button = ShopTab:CreateButton({
	Name = "[Buy Green Apple Juice🍏]",
	Callback = function()
		local args = {
            [1] = "GreenAppleJuice"
        }
        
        game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(unpack(args))
        
        
	end,
})

local Button = ShopTab:CreateButton({
	Name = "[Buy Apple Juice🍎]",
	Callback = function()
		local args = {
            [1] = "AppleJuice"
        }
        
        game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(unpack(args))
        
        
	end,
})

local Button = ShopTab:CreateButton({
	Name = "[Buy Grape Juice🍇]",
	Callback = function()
		local args = {
            [1] = "GrapeJuice"
        }
        
        game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(unpack(args))
        
        
        
	end,
})

local Button = ShopTab:CreateButton({
	Name = "[Buy Water💦]",
	Callback = function()
		local args = {
            [1] = "Water"
        }
        
        game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(unpack(args))
        
        
        
	end,
})





















------\\Locations//

local Button = LocationTab:CreateButton({
	Name = "[GunStore🔫]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1230.27, 262, -814.3)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Mask🎭]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-647.19, 255.03, -708.66)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Melee Shop🗡]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-912.69, 253.54, -1216.32)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Bank💰]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(9241.35, 317.55, -1964.76)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Bank Vault💴]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(9246.95, 317.57, -2100.68)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Studio🎤]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(10886.88, 109.66, -1082.73)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Ice Box💎]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-613.21, 250.91, -1116.86)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Cardealer🚗]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-412.81, 254.03, -1221.86)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Rice Job🍲]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-452.23, 276.55, -356.68)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Job 1⚒]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1002.4, 253.06, -812.17)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Job 2⚒]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1461.54, 253, -594.8)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[New Job 3⚒]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1082.72, 253.61, -952.54)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Clothe Store👚]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-966.18, 253.76, -350.04)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Bed🛏]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1142.67, 259.32, -699.17)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Hotel 1🛏]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(10331.62, 102.31, -817.35)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Hotel 2🛏]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-721.84, 268.64, -726.13)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Hotel 3🛏]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-684.73, 253.78, -820.26)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Rent home🛏💰]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-728.14, 296.93, -906.89)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Rent home 2🛏💰]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1531.72, 373.91, -394.23)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Hospital First Floor🦺]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1154.44, 253.64, -288.04)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Hospital Gear Room🦺]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1209.21, 254.52, -252.8)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Hospital Up Stairs]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1174.97, 402.22, -253.16)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Safe spot 1🚧]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1060.78, 279.99, -768.66)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Safe spot 2🚧]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1112.55, -29.68, 9085)

	end,
})


Rayfield:LoadConfiguration()
elseif game.PlaceId == 12077443856 then
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
        local Window = Rayfield:CreateWindow({
            Name = "Requisition | Cali Shootout",
            LoadingTitle = "Requisition",
            LoadingSubtitle = "discord.gg/8yDaDVQWNC",
            ConfigurationSaving = {
            Enabled = true,
            FolderName = nil, 
            FileName = "Requisition"
            },
            Discord = {
            Enabled = true,
            Invite = "8yDaDVQWNC", 
            RememberJoins = true 
            },
            KeySystem = false, 
            KeySettings = {
            Title = "Untitled",
            Subtitle = "Key System",
            Note = "No method of obtaining the key is provided",
            FileName = "Key", 
            SaveKey = true, 
            GrabKeyFromSite = false, 
            Key = {"Hello"}
            }
        })

   

        local tween_s = game:GetService('TweenService')
        local lp = game.Players.LocalPlayer
        
        function bypass_teleport(x, y, z, speed)
            if lp.Character and lp.Character:FindFirstChild('HumanoidRootPart') then
                local targetPosition = Vector3.new(x, y, z)
                local distance = (lp.Character.HumanoidRootPart.Position - targetPosition).magnitude
                local baseDuration = 1
                local duration = baseDuration + (distance / speed)
                
                local cf = CFrame.new(targetPosition)
                local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
                local tween = tween_s:Create(lp.Character.HumanoidRootPart, tweenInfo, {CFrame = cf})
                tween:Play()
                tween.Completed:Wait() -- Wait for the tween to complete before proceeding
            end
        end

    

    ------\\Tabs//------

    local MainTab = Window:CreateTab("Main🏠", nil) -- Title, Image
    local MainSection = MainTab:CreateSection("Home")

    local FarmTab = Window:CreateTab("Autofarm Tab", nil) -- Title, Image
    local FarmSection = FarmTab:CreateSection("Esp")

    local VisTab = Window:CreateTab("Visual", nil) -- Title, Image
    local VisSection = VisTab:CreateSection("Esp")

    local PvpTab = Window:CreateTab("Pvp🔫", nil) -- Title, Image
    local PvpSection = PvpTab:CreateSection("Target")
    
    local GunModsTab = Window:CreateTab("GunMods", nil) -- Title, Image
    local GunModsSection = GunModsTab:CreateSection("👿")

    local MiscTab = Window:CreateTab("Misc", nil) -- Title, Image
    local MiscSection = MiscTab:CreateSection("✅")

    local TeleportTab = Window:CreateTab("Locations", nil) -- Title, Image
    local TeleportSection = TeleportTab:CreateSection("📍")

    local CreditTab = Window:CreateTab("Credit", nil) -- Title, Image

    ------\\Functions//------
    local Players = game.Players
    local LocalPlayer = Players.LocalPlayer
    local function teleportToPlayer(playerName)
        local playerToTeleport = Players:FindFirstChild(playerName)
        if playerToTeleport then
            local character = LocalPlayer.Character
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local rootPart = character:FindFirstChild("HumanoidRootPart")
    
            local targetCharacter = playerToTeleport.Character
            local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
    
            if targetRootPart then
                rootPart.CFrame = targetRootPart.CFrame
            end
        end
    end

    local c = workspace.CurrentCamera
    local ps = game:GetService("Players")
    local lp = ps.LocalPlayer
    local rs = game:GetService("RunService")

    _G.ESP_ENABLED = false 

    local function ftool(cr)
        for _, b in ipairs(cr:GetChildren()) do 
            if b:IsA("Tool") then
                return tostring(b.Name)
            end
        end
        return 'empty'
    end

    local function esp(p, cr)
        local h = cr:WaitForChild("Humanoid")
        local hrp = cr:WaitForChild("HumanoidRootPart")

        local text = Drawing.new('Text')
        text.Visible = false
        text.Center = true
        text.Outline = true
        text.Color = Color3.new(1, 1, 1)
        text.Font = 2
        text.Size = 13

        local c1 
        local c2
        local c3 

        local function dc()
            text.Visible = false
            text:Remove()
            if c3 then
                c1:Disconnect()
                c2:Disconnect()
                c3:Disconnect()
                c1 = nil 
                c2 = nil
                c3 = nil
            end
        end

        c2 = cr.AncestryChanged:Connect(function(_, parent)
            if not parent then
                dc()
            end
        end)

        c3 = h.HealthChanged:Connect(function(v)
            if (v <= 0) or (h:GetState() == Enum.HumanoidStateType.Dead) then
                dc()
            end
        end)

        c1 = rs.Heartbeat:Connect(function()
            local hrp_pos, hrp_os = c:WorldToViewportPoint(hrp.Position)
            if hrp_os and _G.ESP_ENABLED then
                text.Position = Vector2.new(hrp_pos.X, hrp_pos.Y)
                text.Text = '[ '..tostring(ftool(cr))..' ]'
                text.Visible = true
            else
                text.Visible = false
            end
        end)
    end

    local function p_added(p)
        if p.Character then
            esp(p, p.Character)
        end
        p.CharacterAdded:Connect(function(cr)
            esp(p, cr)
        end)
    end


    local function toggleESP()
        _G.ESP_ENABLED = not _G.ESP_ENABLED
    end


    ps.PlayerAdded:Connect(p_added)


    for _, b in ipairs(ps:GetPlayers()) do 
        if b ~= lp then
            p_added(b)
        end
    end

    ------\\Chat Spy//------
    enabled = true -- chat "/spy" to toggle!
    spyOnMyself = true -- if true will check your messages too
    public = false -- if true will chat the logs publicly (fun, risky)
    publicItalics = true -- if true will use /me to stand out
    privateProperties = { -- customize private logs
        Color = Color3.fromRGB(0,255,255),
        Font = Enum.Font.SourceSansBold,
        TextSize = 18,
    }

    local StarterGui = game:GetService("StarterGui")
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() or Players.LocalPlayer
    local saymsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
    local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
    local instance = (_G.chatSpyInstance or 0) + 1
    _G.chatSpyInstance = instance

    local function onChatted(p, msg)
        if _G.chatSpyInstance == instance then
            if p == player and msg:lower():sub(1, 4) == "/spy" then
                enabled = not enabled
                wait(0.3)
                privateProperties.Text = "{SPY " .. (enabled and "EN" or "DIS") .. "ABLED}"
                StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)
            elseif enabled and (spyOnMyself == true or p ~= player) then
                msg = msg:gsub("[\n\r]", ''):gsub("\t", ' '):gsub("[ ]+", ' ')
                local hidden = true
                local conn = getmsg.OnClientEvent:Connect(function(packet, channel)
                    if packet.SpeakerUserId == p.UserId and packet.Message == msg:sub(#msg - #packet.Message + 1) and (channel == "All" or (channel == "Team" and public == false and Players[packet.FromSpeaker].Team == player.Team)) then
                        hidden = false
                    end
                end)
                wait(1)
                conn:Disconnect()
                if hidden and enabled then
                    if public then
                        saymsg:FireServer((publicItalics and "/me " or '') .. "{SPY} [" .. p.Name .. "]: " .. msg, "All")
                    else
                        privateProperties.Text = "{SPY} [" .. p.Name .. "]: " .. msg
                        StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)
                    end
                end
            end
        end
    end

    for _, p in ipairs(Players:GetPlayers()) do
        p.Chatted:Connect(function(msg) onChatted(p, msg) end)
    end

    Players.PlayerAdded:Connect(function(p)
        p.Chatted:Connect(function(msg) onChatted(p, msg) end)
    end)

    privateProperties.Text = "{SPY " .. (enabled and "EN" or "DIS") .. "ABLED}"
    StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)

    if not player.PlayerGui:FindFirstChild("Chat") then wait(3) end

    local chatFrame = player.PlayerGui.Chat.Frame
    chatFrame.ChatChannelParentFrame.Visible = true
    chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), chatFrame.ChatChannelParentFrame.Size.Y)

    ------\\Spin bot//------
    local player = game.Players.LocalPlayer
    local spinEnabled = false
    local spinSpeed = 0
    
    local function spinBot(speed)
        while spinEnabled do
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(speed), 0)
            wait(0.1)
        end
    end
    
    local function adjustSpin()
        if spinEnabled then
            spinBot(spinSpeed)
        else
            
        end
    end

    ------\\Legit Hitbox//------
    local player = game.Players.LocalPlayer
    local HitboxEnabled4 = false

    local function adjustHitbox(player)
        print("Adjusting hitbox for player:", player.Name)
        if player.Character then
            local upperTorso = player.Character:FindFirstChild("UpperTorso")
            local lowerTorso = player.Character:FindFirstChild("LowerTorso")
            if upperTorso and lowerTorso then
                if HitboxEnabled4 then
                    pcall(function()
                        -- Adjust the hitbox properties when enabled
                        upperTorso.Size = Vector3.new(4, 2, 4)
                        upperTorso.Transparency = 0.9
                        upperTorso.BrickColor = BrickColor.new("Glass")
                        upperTorso.Material = "Glass"
                        upperTorso.CanCollide = false
                        
                        lowerTorso.Size = Vector3.new(2, 1, 2)
                        lowerTorso.Transparency = 0.9
                        lowerTorso.BrickColor = BrickColor.new("Glass")
                        lowerTorso.Material = "Glass"
                        lowerTorso.CanCollide = false
                    end)
                else
                    pcall(function()
                        -- Reset the hitbox properties when disabled
                        upperTorso.Size = Vector3.new(2, 2, 1)
                        upperTorso.Transparency = 0.1
                        upperTorso.BrickColor = BrickColor.new("Glass")
                        upperTorso.Material = "Glass"
                        upperTorso.CanCollide = true
                        
                        lowerTorso.Size = Vector3.new(0, 0, 0)
                        lowerTorso.Transparency = 0.1
                        lowerTorso.BrickColor = BrickColor.new("Glass")
                        lowerTorso.Material = "Glass"
                        lowerTorso.CanCollide = true
                    end)
                end
            end
        end
    end

    -- Function to apply hitbox state to all players
    local function applyHitboxStateToAllPlayers4()
        for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
            if otherPlayer ~= player then
                adjustHitbox(otherPlayer)
            end
        end
    end

    -- Function to handle player added events
    local function onPlayerAdded(player)
        print("Player added:", player.Name)
        player.CharacterAdded:Connect(function(character)
            wait(1) -- Delay to ensure character fully loads
            adjustHitbox(player)
        end)
    end

    local function onPlayerRespawn(player)
        print("Player respawned:", player.Name)
        player.CharacterAdded:Connect(function(character)
            character:WaitForChild("Humanoid").Died:Connect(function()
                wait(35) -- Delay to allow time for respawn
                adjustHitbox(player)
            end)
        end)
    end

    -- Initialize hitbox state when the script starts
    applyHitboxStateToAllPlayers4()

    -- Listen for player added events
    game.Players.PlayerAdded:Connect(onPlayerAdded)
    print("Player added event connected")

    game.Players.PlayerAdded:Connect(function(player)
        onPlayerAdded(player)
        player.CharacterAdded:Connect(function(character)
            wait(1) -- Delay to ensure character fully loads
            adjustHitbox(player)
        end)
    end)
    print("Player added and respawn events connected")

    ------\\Semi Legit//------
    
    
    
    
    
    
    
    
    
    
    
    
    
    ------\\Main Tab//------
    local Slider = MainTab:CreateSlider({
        Name = "Walk-Speed",
        Range = {16, 250},
        Increment = 10,
        Suffix = "Walkspeed",
        CurrentValue = 10,
        Flag = "WalkspeedSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(V)
            _G.WS = (V); -- Enter speed here
            local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid;
            Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            Humanoid.WalkSpeed = _G.WS;
            end)
            Humanoid.WalkSpeed = _G.WS;
        end,
    })

    local Slider = MainTab:CreateSlider({
        Name = "Jump-Power",
        Range = {16, 250},
        Increment = 10,
        Suffix = "Jump Power",
        CurrentValue = 85,
        Flag = "JumpPowerSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(G)
            game:GetService('Players').LocalPlayer.Character.Humanoid.JumpPower = G
                -- The variable (Value) is a number which correlates to the value the slider is currently at
        end,
    })

    local Toggle = MainTab:CreateToggle({
        Name = "Inf Jump",
        CurrentValue = false,
        Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(infjmp)
            local infjmp = true
            game:GetService("UserInputService").jumpRequest:Connect(function()
                if infjmp then
                    game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass"Humanoid":ChangeState("Jumping")
                end
            end)
            
        end,
    })

    local SpinBotToggle = MainTab:CreateToggle({
        Name = "[Spin-Bot]",
        CurrentValue = false,
        Flag = "SpinBotToggle",
        Callback = function(Value)
            spinEnabled = Value
            adjustSpin()
        end,
    })

    local SpinBotSlider = MainTab:CreateSlider({
        Name = "[Spin-Speed]",
        Range = {40, 500},
        Increment = 10,
        Suffix = "Speed",
        CurrentValue = 0,
        Flag = "SpinSpeedSlider",
        Callback = function(Value)
            spinSpeed = Value
            if spinEnabled then
                adjustSpin()
            end
        end,
    })

    ------\\Farm Tab//------

    local BoxFarm = FarmTab:CreateToggle({
    Name = "Box Job Farm",
    CurrentValue = false,
    Flag = "BoxFarm", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        _G.BoxFarm = Value
        while _G.BoxFarm do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1943.4696, 3.40753126, -51.8913345, 0.741057515, -1.1683353e-08, 0.671441555, -2.3360287e-09, 1, 1.99786339e-08, -0.671441555, -1.63738232e-08, 0.741057515)
            wait(0.4) --ensure user is at location cuz if not no point in firing
            fireproximityprompt(game:GetService("Workspace")["Job System"].BoxPickingJob.BOX1.ProximityPrompt)
            wait(0.4) -- dont wanna equip to early cuz then break
            local BoxTool = game.Players.LocalPlayer.Backpack:FindFirstChild("BOX")
            if BoxTool then
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(BoxTool)
            end
            wait(0.3) --ensure its equip
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1924.97913, 3.10753107, -22.564846, -0.0977756754, -1.08461542e-07, -0.995208502, 4.81380935e-09, 1, -1.09456678e-07, 0.995208502, -1.54929438e-08, -0.0977756754)
            wait(4)
        end
    end,
    })

    ------\\Visual Tab//------
    local BoxToggle = VisTab:CreateToggle({
        Name = "Box ESP",
        CurrentValue = false,
        Flag = "BoxESP",
        Callback = function(Value)
            -- settings
            local settings = {
                defaultcolor = Color3.fromRGB(255,0,0),
                teamcheck = false,
                teamcolor = true
            };
            
            -- initialize global control for ESP
            _G.BoxEnabled = Value
            
            -- services
            local runService = game:GetService("RunService");
            local players = game:GetService("Players");
            
            -- variables
            local localPlayer = players.LocalPlayer;
            local camera = workspace.CurrentCamera;
            
            -- functions
            local newVector2, newColor3, newDrawing = Vector2.new, Color3.new, Drawing.new;
            local tan, rad = math.tan, math.rad;
            local round = function(...) local a = {}; for i,v in next, table.pack(...) do a[i] = math.round(v); end return unpack(a); end;
            local wtvp = function(...) local a, b = camera.WorldToViewportPoint(camera, ...) return newVector2(a.X, a.Y), b, a.Z end;
            
            local espCache = {};
            local function createEsp(player)
                local drawings = {};
                
                drawings.box = newDrawing("Square");
                drawings.box.Thickness = 1;
                drawings.box.Filled = false;
                drawings.box.Color = settings.defaultcolor;
                drawings.box.Visible = false;
                drawings.box.ZIndex = 2;
            
                drawings.boxoutline = newDrawing("Square");
                drawings.boxoutline.Thickness = 3;
                drawings.boxoutline.Filled = false;
                drawings.boxoutline.Color = newColor3(0, 0, 0); -- Default outline color, you can change it as needed.
                drawings.boxoutline.Visible = false;
                drawings.boxoutline.ZIndex = 1;
            
                espCache[player] = drawings;
            end
            
            local function removeEsp(player)
                if rawget(espCache, player) then
                    for _, drawing in next, espCache[player] do
                        drawing:Remove();
                    end
                    espCache[player] = nil;
                end
            end
            
            local function updateEsp(player, esp)
                if not _G.BoxEnabled then -- Check if ESP is enabled globally
                    esp.box.Visible = false;
                    esp.boxoutline.Visible = false;
                    return
                end
                
                local character = player and player.Character;
                if character then
                    local cframe = character:GetModelCFrame();
                    local position, visible, depth = wtvp(cframe.Position);
                    esp.box.Visible = visible;
                    esp.boxoutline.Visible = visible;
            
                    if cframe and visible then
                        local scaleFactor = 1 / (depth * tan(rad(camera.FieldOfView / 2)) * 2) * 1000;
                        local width, height = round(4 * scaleFactor, 5 * scaleFactor);
                        local x, y = round(position.X, position.Y);
            
                        esp.box.Size = newVector2(width, height);
                        esp.box.Position = newVector2(x - width / 2, y - height / 2);
                        esp.box.Color = settings.teamcolor and player.TeamColor.Color or settings.defaultcolor;
            
                        esp.boxoutline.Size = esp.box.Size;
                        esp.boxoutline.Position = esp.box.Position;
                    end
                else
                    esp.box.Visible = false;
                    esp.boxoutline.Visible = false;
                end
            end
            
            -- main
            for _, player in next, players:GetPlayers() do
                if player ~= localPlayer then
                    createEsp(player);
                end
            end
            
            players.PlayerAdded:Connect(function(player)
                createEsp(player);
            end);
            
            players.PlayerRemoving:Connect(function(player)
                removeEsp(player);
            end)
            
            runService:BindToRenderStep("esp", Enum.RenderPriority.Camera.Value, function()
                for player, drawings in next, espCache do
                    if settings.teamcheck and player.Team == localPlayer.Team then
                        continue;
                    end
            
                    if drawings and player ~= localPlayer then
                        updateEsp(player, drawings);
                    end
                end
            end)

        end,
    })

    local EquipToggle = VisTab:CreateToggle({
        Name = "Equipped ESP",
        CurrentValue = false,
        Flag = "EquippedESP",
        Callback = function(Value)
            toggleESP()  
        end,
    })

    local NameToggle = VisTab:CreateToggle({
        Name = "Name ESP",
        CurrentValue = false,
        Flag = "NameESP",
        Callback = function(Value)
            local c = workspace.CurrentCamera
            local ps = game:GetService("Players")
            local lp = ps.LocalPlayer
            local rs = game:GetService("RunService")

            _G.NameEnabled = Value

            local function esp(p,cr)
                local h = cr:WaitForChild("Humanoid")
                local hrp = cr:WaitForChild("HumanoidRootPart")

                local text = Drawing.new("Text")
                text.Visible = false
                text.Center = true
                text.Outline = true 
                text.Font = 2
                text.Color = Color3.fromRGB(255,255,255)
                text.Size = 13

                local c1
                local c2
                local c3

                local function dc()
                    text.Visible = false
                    text:Remove()
                    if c1 then
                        c1:Disconnect()
                        c1 = nil 
                    end
                    if c2 then
                        c2:Disconnect()
                        c2 = nil 
                    end
                    if c3 then
                        c3:Disconnect()
                        c3 = nil 
                    end
                end

                c2 = cr.AncestryChanged:Connect(function(_,parent)
                    if not parent then
                        dc()
                    end
                end)

                c3 = h.HealthChanged:Connect(function(v)
                    if (v<=0) or (h:GetState() == Enum.HumanoidStateType.Dead) then
                        dc()
                    end
                end)

                c1 = rs.RenderStepped:Connect(function()
                    if _G.NameEnabled then 
                        local hrp_pos,hrp_onscreen = c:WorldToViewportPoint(hrp.Position)
                        if hrp_onscreen then
                            local yOffset = 50 
                            text.Position = Vector2.new(hrp_pos.X, hrp_pos.Y - yOffset)
                            text.Text = p.Name
                            text.Visible = true
                        else
                            text.Visible = false
                        end
                    else
                        dc() -- Disable ESP if not enabled
                    end
                end)    
            end

            local function p_added(p)
                if p.Character then
                    esp(p,p.Character)
                end
                p.CharacterAdded:Connect(function(cr)
                    esp(p,cr)
                end)
            end

            for i,p in next, ps:GetPlayers() do 
                if p ~= lp then
                    p_added(p)
                end
            end

            ps.PlayerAdded:Connect(p_added)

        end,
    })

    ------\\PVP Tab//------
    local Label = PvpTab:CreateLabel("[Selected Target]")
    local TargetName = ""
    local function CheckPlr2(arg)
        for i,v in pairs(game.Players:GetChildren()) do
            if (string.sub(string.lower(v.Name),1,string.len(arg))) == string.lower(arg) then
                TargetName = v.Name
            end
            if (string.sub(string.lower(v.DisplayName),1,string.len(arg))) == string.lower(arg) then
                TargetName = v.Name
            end
        end
        return nil
    end
    local Input = PvpTab:CreateInput({
        Name = "[Target Name]",
        PlaceholderText = "type here",
        RemoveTextAfterFocusLost = false,
        Callback = function(Target)
        -- The function that takes place when the input is changed
        -- The variable (Text) is a string for the value in the text box
        CheckPlr2(Target)
        Label:Set("Selected target:".. Target)
        for i = 1, 10 do
        print(Target)
        end
        end
    })

    local Toggle = PvpTab:CreateToggle({
        Name = "[Spectate👀]",
        CurrentValue = false,
        Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
    if Value == true then
        game.Workspace.Camera.CameraSubject = game.Players[TargetName].Character:FindFirstChild("HumanoidRootPart")
    elseif Value ~= true then
        game.Workspace.Camera.CameraSubject = LocalPlayer.Character.HumanoidRootPart 
        end
    end,
    })
    
    local button = PvpTab:CreateButton({
        Name = "[Teleport to Player📍]",
        Callback = function()
            --game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[TargetName].Character.HumanoidRootPart.CFrame
            teleportToPlayer(TargetName)
        end    
    })

    local Toggle = PvpTab:CreateToggle({
        Name = "Legit Hitbox",
        CurrentValue = false,
        Flag = "LegitHitbox", -- Unique flag for configuration saving
        Callback = function(Value)
            -- Function to toggle hitbox
            HitboxEnabled4 = Value
            applyHitboxStateToAllPlayers4() -- Apply hitbox state when toggle changes
        end,
    })

    local Toggle = PvpTab:CreateToggle({
        Name = "Semi Legit",
        CurrentValue = false,
        Flag = "semiLegit", -- Flag to store toggle state
        Callback = function(Value)
            HitboxEnabled3 = Value -- Update HitboxEnabled based on the toggle value
            applyHitboxStateToAllPlayers3() -- Apply the new hitbox state to all players
        end,
    })


    ------\\GM Tab//------

    ------\\Misc Tab//------
    local IPButton = MiscTab:CreateButton({
    Name = "Instant Proximity",
    Callback = function()
        for i,v in ipairs(game:GetService("Workspace"):GetDescendants()) do
            if v.ClassName == "ProximityPrompt" then
                v.HoldDuration = 0
            end
            end                   
    end,
    })

    local SmallButton = MiscTab:CreateButton({
    Name = "Join smallest server",
    Callback = function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/"
        
        local _place = game.PlaceId
        local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
        function ListServers(cursor)
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
            return Http:JSONDecode(Raw)
        end
        
        local Server, Next; repeat
            local Servers = ListServers(Next)
            Server = Servers.data[1]
            Next = Servers.nextPageCursor
        until Server
        
        TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)               
    end,
    })


    local RejoinButton = MiscTab:CreateButton({
    Name = "Rejoin server",
    Callback = function()
        local ts = game:GetService("TeleportService")
        local p = game:GetService("Players").LocalPlayer
        ts:Teleport(game.PlaceId, p)        
    end,
    })

    local HopButton = MiscTab:CreateButton({
    Name = "Server Hop",
    Callback = function()
        local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua")()
        module:Teleport(game.PlaceId)     
    end,
    })

    -----\\TP Tab//------

    local GunTeleport = TeleportTab:CreateButton({
        Name = "Gun Shop",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1637.5, 3.51, -94.66)
        end,
    })

    local SwipeTeleport = TeleportTab:CreateButton({
        Name = "Swipe",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1538.98, 3.49, -322.12)
        end,
    })


    local BankTeleport = TeleportTab:CreateButton({
        Name = "Bank",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2360.4, 3.54, 137.21)
        end,
    })

    local WeedFarmTeleport = TeleportTab:CreateButton({
        Name = "WeedFarm",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2000.08, 3.49, 187.14)
        end,
    })
    
    local CardealerTeleport = TeleportTab:CreateButton({
        Name = "Car Dealer",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1415.16, 3.49, -130.63)
        end,
    })
    
    local JobTeleport = TeleportTab:CreateButton({
        Name = "Job💼-Clean",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1675.15, 3.51, 49.36)
        end,
    })
    
    local Job2Teleport = TeleportTab:CreateButton({
        Name = "Job💼-Box",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1947.41, 3.41, -39.05)
        end,
    })
    
    local ShopTeleport = TeleportTab:CreateButton({
        Name = "Shop[Blank Card]",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1922.95, 3.48, 88.8)
        end,
    })
    
    local CasinoTeleport = TeleportTab:CreateButton({
        Name = "Diamond casino-Wanna be gta 5 ahh game",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2371.58, 3.41, -653.86)
        end,
    })
    
    local McDonaldsTeleport = TeleportTab:CreateButton({
        Name = "McDonalds",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1919.08, 3.51, -654.15)
        end,
    })
    
    local AptTeleport = TeleportTab:CreateButton({
        Name = "Cali Apt",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2441.63, 5.81, -292.36)
        end,
    })
    
    local PdTeleport = TeleportTab:CreateButton({
        Name = "Police DP[Pay off bounty]",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2430.4, 3.49, 597.68)
        end,
    })
    
    
    
    
    ------\\Credit Tab//------
    local DiscordButton = CreditTab:CreateButton({
    Name = "Join the Discord!",
    Callback = function()
        local HttpService = game:GetService("HttpService")
        local requestFunction = (syn and syn.request) or (http and http.request) or http_request
        
        if requestFunction then
            local nonce = HttpService:GenerateGUID(false)
            local requestBody = HttpService:JSONEncode({
                cmd = 'INVITE_BROWSER',
                nonce = nonce,
                args = {code = "8yDaDVQWNC"}
            })
            
            requestFunction({
                Url = 'http://127.0.0.1:6463/rpc?v=1',
                Method = 'POST',
                Headers = {
                    ['Content-Type'] = 'application/json',
                    Origin = 'https://discord.com'
                },
                Body = requestBody
            })
        else
            warn("Unable to make HTTP request: requestFunction is not available")
        end                
    end,
    })

    Rayfield:LoadConfiguration()
end  
