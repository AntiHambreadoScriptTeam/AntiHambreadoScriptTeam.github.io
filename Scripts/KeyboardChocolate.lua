local Config = {
    RayfieldUrl = "https://sirius.menu/rayfield",
    WindowTitle = "[CRACKED] 🍫 +1 Speed Keyboard Escape | Candy & Chocolate",
    LoadingTitle = "[CRACKED] 🍫 +1 Speed Keyboard Escape",
    LoadingSubtitle = "BY TheRealBanHammer",
    DiscordInvite = "rTGF5xhe3h",
    KeySystem = true,
    Key = "ElCreadorDeEsteScriptEsUnGranMonoNegro",
    KeyTitle = "TheRealBanHammer - Skidder Final Boss",
    KeySubtitle = "Script Crackeado Lol",
    KeyNote = "Key: ElCreadorDeEsteScriptEsUnGranMonoNegro",
    Keys = {"ElCreadorDeEsteScriptEsUnGranMonoNegro"},
    ConfigFolder = "CrackeadoHub",
    KeyFileName = "CrackeadoKeySystem",
    LoadedNotificationTitle = "CrackeadoHub",
    LoadedNotificationContent = "Script loaded. Selected route: ",
    ToggleUIKeybind = "K",
    DefaultTweenSpeed = 65,
    DefaultPointDelay = 0.05,
    DefaultCollectRadius = 45,
    DefaultAutoBuyDelay = 1.5,
    DefaultFlySpeed = 55,
    TeleportYOffset = 2.75,
    SupportPlatformGap = 0.12,
    SupportPlatformSize = Vector3.new(9, 0.35, 9),
    CheckpointForwardTime = 2
}

local Services = {
    Players = game:GetService("Players"),
    TweenService = game:GetService("TweenService"),
    RunService = game:GetService("RunService"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    UserInputService = game:GetService("UserInputService"),
    VirtualUser = game:GetService("VirtualUser"),
    Workspace = game:GetService("Workspace")
}

local LocalPlayer = Services.Players.LocalPlayer
local unpackValue = unpack or table.unpack
local CrackedKey = Config.Keys[1]

local Theme = {
    TextColor = Color3.fromRGB(235, 235, 245),
    Background = Color3.fromRGB(15, 15, 35),
    Topbar = Color3.fromRGB(22, 22, 50),
    Shadow = Color3.fromRGB(10, 10, 25),
    NotificationBackground = Color3.fromRGB(18, 18, 40),
    NotificationActionsBackground = Color3.fromRGB(180, 140, 255),
    TabBackground = Color3.fromRGB(40, 40, 90),
    TabStroke = Color3.fromRGB(70, 60, 120),
    TabBackgroundSelected = Color3.fromRGB(120, 90, 255),
    TabTextColor = Color3.fromRGB(235, 235, 245),
    SelectedTabTextColor = Color3.fromRGB(20, 20, 30),
    ElementBackground = Color3.fromRGB(25, 25, 55),
    ElementBackgroundHover = Color3.fromRGB(35, 35, 75),
    SecondaryElementBackground = Color3.fromRGB(18, 18, 40),
    ElementStroke = Color3.fromRGB(80, 70, 140),
    SecondaryElementStroke = Color3.fromRGB(60, 55, 110),
    SliderBackground = Color3.fromRGB(120, 90, 255),
    SliderProgress = Color3.fromRGB(140, 110, 255),
    SliderStroke = Color3.fromRGB(180, 150, 255),
    ToggleBackground = Color3.fromRGB(20, 20, 45),
    ToggleEnabled = Color3.fromRGB(130, 90, 255),
    ToggleDisabled = Color3.fromRGB(80, 80, 100),
    ToggleEnabledStroke = Color3.fromRGB(170, 130, 255),
    ToggleDisabledStroke = Color3.fromRGB(100, 100, 130),
    ToggleEnabledOuterStroke = Color3.fromRGB(70, 60, 120),
    ToggleDisabledOuterStroke = Color3.fromRGB(50, 50, 80),
    DropdownSelected = Color3.fromRGB(30, 30, 65),
    DropdownUnselected = Color3.fromRGB(20, 20, 45),
    InputBackground = Color3.fromRGB(20, 20, 45),
    InputStroke = Color3.fromRGB(90, 80, 150),
    PlaceholderColor = Color3.fromRGB(160, 160, 190)
}

local State = {
    SelectedWorld = "World 1",
    SelectedShopItem = "Candy",
    TweenSpeed = Config.DefaultTweenSpeed,
    PointDelay = Config.DefaultPointDelay,
    CollectRadius = Config.DefaultCollectRadius,
    AutoBuyDelay = Config.DefaultAutoBuyDelay,
    AutoFarm = false,
    AutoFarmThread = nil,
    SelectedCheckpoint = "Checkpoint 1 | -7.72, 8.86, 284.85",
    CheckpointFlyLoop = false,
    CheckpointFlyThread = nil,
    CheckpointFlyActive = false,
    AutoCollect = false,
    AutoBuy = false,
    LoopRoute = true,
    Noclip = false,
    InfiniteJump = false,
    Fly = false,
    FlySpeed = Config.DefaultFlySpeed,
    AntiAfk = false,
    RouteRunning = false,
    ActiveTween = nil,
    NoclipConnection = nil,
    InfiniteJumpConnection = nil,
    FlyConnection = nil,
    FlyBodyVelocity = nil,
    FlyBodyGyro = nil,
    SupportPlatform = nil,
    SupportPlatformConnection = nil,
    AntiAfkConnection = nil,
    AutoCollectThread = nil,
    AutoBuyThread = nil
}

local Esp = {
    Enabled = false,
    ShowNames = false,
    ShowDistance = false,
    Color = Color3.fromRGB(160, 120, 255),
    Objects = {},
    Connection = nil,
    LastUpdate = 0
}

local ObstacleKeywords = {
    "obstacle",
    "kill",
    "killbrick",
    "lava",
    "damage",
    "dead",
    "hurt",
    "spinner",
    "laser",
    "saw",
    "barrier",
    "trap",
    "hazard",
    "spike",
    "blade",
    "wave",
    "ball",
    "chocolate",
    "boss",
    "bear",
    "wall"
}

local ProtectedWorldKeywords = {
    "checkpoint",
    "spawn",
    "teleport",
    "portal",
    "coin",
    "candy",
    "chocolate",
    "reward",
    "collect",
    "shop",
    "egg",
    "finish",
    "win"
}

local WorldRoutes = {
    ["World 1"] = {
        Vector3.new(2.81, 7.68, 129.98),
        Vector3.new(-0.48, 7.68, 284.92),
        Vector3.new(50.45, 7.68, 399.32),
        Vector3.new(0.22, 7.68, 504.8),
        Vector3.new(-12.28, 7.68, 526.86),
        Vector3.new(-15.79, 7.68, 559.83),
        Vector3.new(-16.23, 49.29, 677.16),
        Vector3.new(-15.94, 75.96, 757.34),
        Vector3.new(17.74, 75.96, 789.65),
        Vector3.new(15.94, 75.96, 929.52),
        Vector3.new(3.16, 75.96, 1111.83),
        Vector3.new(4.08, 75.96, 1150.4),
        Vector3.new(0.54, 75.96, 1365.5),
        Vector3.new(1.57, 75.96, 1414.83),
        Vector3.new(-126.49, 53.31, 1444.94),
        Vector3.new(-433.16, 53.31, 1463.62),
        Vector3.new(-546.43, 53.32, 1463.7),
        Vector3.new(-712.52, 53.32, 1465.25),
        Vector3.new(-1007.36, 53.32, 1466.5),
        Vector3.new(-1080.07, 53.32, 1468.84),
        Vector3.new(-1080.09, 322.48, 1468.84),
        Vector3.new(-1122.78, 295.32, 1465.14),
        Vector3.new(-1244.95, 302.75, 1470.11),
        Vector3.new(-1858.42, 314.87, 1464.63),
        Vector3.new(-2520.88, 321.59, 1464.34),
        Vector3.new(-2972.63, 295.32, 1465.91),
        Vector3.new(-3251.58, 295.32, 1468.47),
        Vector3.new(-3732.62, 295.32, 1464.91),
        Vector3.new(-3943.55, 295.32, 1466.12),
        Vector3.new(-4123.24, 295.32, 1467.74),
        Vector3.new(-4296.84, 295.32, 1471.44),
        Vector3.new(-4314.44, 472.78, 1528.26),
        Vector3.new(-4368.97, 469.83, 1530.54),
        Vector3.new(-4584.82, 469.65, 1529.69),
        Vector3.new(-4628.37, 469.65, 1141.16),
        Vector3.new(-5046.67, 469.65, 1588.44),
        Vector3.new(-5266.65, 469.65, 1477.57),
        Vector3.new(-5341.57, 469.43, 1477.3),
        Vector3.new(-5398.84, 476.83, 1480.4),
        Vector3.new(-5902.1, 486.11, 1565.53),
        Vector3.new(-6479.85, 488.56, 1388.15),
        Vector3.new(-6808.44, 520.43, 1487.06),
        Vector3.new(-6808.57, 523.6, 1470.37)
    },
    ["World 2"] = {
        Vector3.new(-396.22, 503.82, -89.15),
        Vector3.new(-395.11, 502.91, -3.26),
        Vector3.new(-399.85, 502.63, 62.19),
        Vector3.new(-400.23, 502.91, 132.14),
        Vector3.new(-395.21, 498.99, 192.76),
        Vector3.new(-392.64, 498.99, 364.55),
        Vector3.new(-391.59, 498.85, 465.59),
        Vector3.new(-345.09, 498.85, 468.92),
        Vector3.new(-347.68, 525.92, 578.02),
        Vector3.new(-455.16, 525.92, 576.05),
        Vector3.new(-454.9, 552.92, 463.35),
        Vector3.new(-347.07, 552.92, 464.38),
        Vector3.new(-345.93, 579.99, 577.71),
        Vector3.new(-453.01, 579.99, 578.51),
        Vector3.new(-449.94, 606.99, 465.45),
        Vector3.new(-398.96, 606.99, 467.96),
        Vector3.new(-399.56, 606.78, 615.39),
        Vector3.new(-400.07, 626.87, 748.33),
        Vector3.new(-400.47, 606.34, 844.2),
        Vector3.new(-399.26, 606.34, 1050.49),
        Vector3.new(-400.15, 606.34, 1275.53),
        Vector3.new(-390.74, 616.23, 1327.35),
        Vector3.new(-391.24, 606.34, 1454.43),
        Vector3.new(-361.57, 627.13, 1601.27),
        Vector3.new(-359.82, 604.22, 1715.61),
        Vector3.new(-359.21, 614.4, 1787.58),
        Vector3.new(-397.93, 606.35, 1922.74),
        Vector3.new(-396.77, 606.34, 2103.07),
        Vector3.new(-395.8, 606.34, 2247.85),
        Vector3.new(-395.34, 616.58, 2312.83),
        Vector3.new(-400.62, 622.28, 2401.14),
        Vector3.new(-417.13, 625.91, 2413.93),
        Vector3.new(-402.18, 622.24, 2521.79),
        Vector3.new(-403.84, 622.23, 2650.09),
        Vector3.new(-398.01, 622.24, 2734.83),
        Vector3.new(-396.32, 622.24, 2854.44),
        Vector3.new(-399.09, 622.24, 2977.76),
        Vector3.new(-402.67, 622.25, 3156.06),
        Vector3.new(-325.14, 622.25, 3338.71),
        Vector3.new(-210.07, 622.25, 3651.9),
        Vector3.new(-100.59, 622.25, 3857.55),
        Vector3.new(188.2, 622.41, 3863.21),
        Vector3.new(544.92, 622.38, 3863.84),
        Vector3.new(596.06, 622.41, 3817.04),
        Vector3.new(593.71, 626.04, 3801.68)
    }
}

local CheckpointTargets = {
    {Name = "Checkpoint 1 | -7.72, 8.86, 284.85", Position = Vector3.new(-7.72, 8.86, 284.85)},
    {Name = "Checkpoint 2 | -5.40, 8.86, 506.93", Position = Vector3.new(-5.40, 8.86, 506.93)},
    {Name = "Checkpoint 3 | -8.02, 77.15, 773.73", Position = Vector3.new(-8.02, 77.15, 773.73)},
    {Name = "Checkpoint 4 | -6.97, 77.15, 1109.22", Position = Vector3.new(-6.97, 77.15, 1109.22)},
    {Name = "Checkpoint 5 | -7.32, 77.15, 1411.90", Position = Vector3.new(-7.32, 77.15, 1411.90)},
    {Name = "Checkpoint 6 | -540.73, 54.50, 1457.41", Position = Vector3.new(-540.73, 54.50, 1457.41)},
    {Name = "Checkpoint 7 | -1009.88, 54.50, 1456.93", Position = Vector3.new(-1009.88, 54.50, 1456.93)},
    {Name = "Checkpoint 8 | -1124.39, 296.50, 1455.23", Position = Vector3.new(-1124.39, 296.50, 1455.23)},
    {Name = "Checkpoint 9 | -2970.94, 296.50, 1457.82", Position = Vector3.new(-2970.94, 296.50, 1457.82)},
    {Name = "Checkpoint 10 | -3940.07, 296.50, 1457.86", Position = Vector3.new(-3940.07, 296.50, 1457.86)},
    {Name = "Checkpoint 11 | -4367.68, 471.01, 1523.05", Position = Vector3.new(-4367.68, 471.01, 1523.05)},
    {Name = "Checkpoint 12 | -5342.58, 470.61, 1467.19", Position = Vector3.new(-5342.58, 470.61, 1467.19)},
    {Name = "Checkpoint 13 | -6810.36, 521.61, 1479.14", Position = Vector3.new(-6810.36, 521.61, 1479.14)},
    {Name = "Checkpoint 14 | -8353.23, 484.49, 1476.83", Position = Vector3.new(-8353.23, 484.49, 1476.83)},
    {Name = "Checkpoint 15 | -14003.84, 750.54, 3080.51", Position = Vector3.new(-14003.84, 750.54, 3080.51)}
}

local CheckpointNames = {}
for _, checkpoint in ipairs(CheckpointTargets) do
    table.insert(CheckpointNames, checkpoint.Name)
end

local ShopItems = {
    {Name = "Candy", Hints = {"Candy", "BuyCandy", "PurchaseCandy", "CandyShop"}, Args = {"Candy"}},
    {Name = "Chocolate", Hints = {"Chocolate", "BuyChocolate", "PurchaseChocolate", "ChocolateShop"}, Args = {"Chocolate"}},
    {Name = "Speed Coil", Hints = {"SpeedCoil", "Coil", "BuySpeedCoil", "PurchaseSpeedCoil"}, Args = {"Speed Coil"}},
    {Name = "Gravity Coil", Hints = {"GravityCoil", "BuyGravityCoil", "PurchaseGravityCoil"}, Args = {"Gravity Coil"}},
    {Name = "Trail", Hints = {"Trail", "BuyTrail", "PurchaseTrail"}, Args = {"Trail"}},
    {Name = "Skip Stage", Hints = {"SkipStage", "StageSkip", "BuySkip"}, Args = {"Skip Stage"}},
    {Name = "Win Potion", Hints = {"WinPotion", "Potion", "BuyPotion", "PurchasePotion"}, Args = {"Win Potion"}}
}

local ShopItemNames = {}
for _, item in ipairs(ShopItems) do
    table.insert(ShopItemNames, item.Name)
end

local function numberFromText(value, fallback, minimum, maximum)
    local parsed = tonumber(value)
    if not parsed then
        return fallback
    end
    if minimum and parsed < minimum then
        parsed = minimum
    end
    if maximum and parsed > maximum then
        parsed = maximum
    end
    return parsed
end

local function optionValue(value, fallback)
    if type(value) == "table" then
        return tostring(value[1] or fallback)
    end
    if value == nil then
        return fallback
    end
    return tostring(value)
end

local function getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function getHumanoid()
    local character = getCharacter()
    return character and character:FindFirstChildOfClass("Humanoid")
end

local function getRoot()
    local character = getCharacter()
    return character and character:FindFirstChild("HumanoidRootPart")
end

local Rayfield = loadstring(game:HttpGet(Config.RayfieldUrl))()

local function notify(title, content, duration)
    pcall(function()
        Rayfield:Notify({
            Title = title,
            Content = content,
            Duration = duration or 4,
            Image = 4483362458
        })
    end)
end

local function createButton(tab, config)
    if type(tab.CreateButton) == "function" then
        local ok, result = pcall(function()
            return tab:CreateButton(config)
        end)
        if ok then
            return result
        end
    end
    return tab:CreateToggle({
        Name = config.Name,
        CurrentValue = false,
        Flag = (config.Flag or config.Name) .. "Fallback",
        Callback = function(value)
            if value and config.Callback then
                config.Callback()
            end
        end
    })
end

local function createLabel(tab, text)
    local ok, label = pcall(function()
        return tab:CreateLabel(text)
    end)
    if ok then
        return label
    end
    return nil
end

local function setLabel(label, text)
    if not label then
        return
    end
    pcall(function()
        if type(label.Set) == "function" then
            label:Set(text)
        elseif type(label.SetText) == "function" then
            label:SetText(text)
        end
    end)
end

local function cancelTween()
    if State.ActiveTween then
        pcall(function()
            State.ActiveTween:Cancel()
        end)
        State.ActiveTween = nil
    end
end

local function clearSupportPlatform()
    if State.SupportPlatformConnection then
        State.SupportPlatformConnection:Disconnect()
        State.SupportPlatformConnection = nil
    end
    if State.SupportPlatform then
        State.SupportPlatform:Destroy()
        State.SupportPlatform = nil
    end
end

local function getSupportPlatformCFrame(root)
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local rootHalfHeight = root.Size.Y * 0.5
    local platformHalfHeight = Config.SupportPlatformSize.Y * 0.5
    local hipHeight = humanoid and humanoid.HipHeight or 2
    local yOffset = rootHalfHeight + hipHeight + platformHalfHeight + Config.SupportPlatformGap
    return CFrame.new(root.Position - Vector3.new(0, yOffset, 0))
end

local function ensureSupportPlatform()
    if State.SupportPlatform then
        return State.SupportPlatform
    end
    local platform = Instance.new("Part")
    platform.Name = "ORVA_AutoFarmSupport"
    platform.Size = Config.SupportPlatformSize
    platform.Transparency = 1
    platform.Anchored = true
    platform.CanCollide = true
    platform.CanTouch = false
    platform.CanQuery = false
    platform.CastShadow = false
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if root then
        platform.CFrame = getSupportPlatformCFrame(root)
    end
    platform.Parent = Services.Workspace
    State.SupportPlatform = platform
    return platform
end

local function updateSupportPlatform()
    if not State.AutoFarm and not State.Fly and not State.CheckpointFlyActive and not State.CheckpointFlyLoop then
        clearSupportPlatform()
        return
    end
    ensureSupportPlatform()
    if State.SupportPlatformConnection then
        return
    end
    State.SupportPlatformConnection = Services.RunService.Heartbeat:Connect(function()
        if not State.AutoFarm and not State.Fly and not State.CheckpointFlyActive and not State.CheckpointFlyLoop then
            clearSupportPlatform()
            return
        end
        local character = LocalPlayer.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")
        if not root or not State.SupportPlatform then
            return
        end
        local velocity = root.AssemblyLinearVelocity
        if velocity.Y < -1 then
            root.AssemblyLinearVelocity = Vector3.new(velocity.X, 0, velocity.Z)
        end
        State.SupportPlatform.CFrame = getSupportPlatformCFrame(root)
    end)
end

local function applyMovement()
    local humanoid = getHumanoid()
    if not humanoid then
        return
    end
    if State.WalkSpeed then
        humanoid.WalkSpeed = State.WalkSpeed
    end
    if State.JumpPower then
        pcall(function()
            humanoid.UseJumpPower = true
        end)
        humanoid.JumpPower = State.JumpPower
    end
end

local function tweenTo(position, shouldStop)
    local root = getRoot()
    if not root then
        return false
    end
    cancelTween()
    local targetPosition = position + Vector3.new(0, Config.TeleportYOffset, 0)
    local distance = (root.Position - targetPosition).Magnitude
    local duration = math.max(distance / State.TweenSpeed, 0.08)
    local tween = Services.TweenService:Create(root, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        CFrame = CFrame.new(targetPosition)
    })
    local completed = false
    local connection = tween.Completed:Connect(function()
        completed = true
    end)
    State.ActiveTween = tween
    tween:Play()
    while not completed do
        if shouldStop and shouldStop() then
            cancelTween()
            break
        end
        task.wait()
    end
    if connection then
        connection:Disconnect()
    end
    State.ActiveTween = nil
    return completed
end

local function followSelectedRoute(shouldStop)
    local route = WorldRoutes[State.SelectedWorld] or WorldRoutes["World 1"]
    for _, position in ipairs(route) do
        if shouldStop and shouldStop() then
            return false
        end
        local success = tweenTo(position, shouldStop)
        if not success then
            return false
        end
        if State.PointDelay > 0 then
            task.wait(State.PointDelay)
        end
    end
    return true
end

local function startAutoFarm()
    if State.AutoFarmThread then
        return
    end
    State.AutoFarm = true
    updateSupportPlatform()
    State.AutoFarmThread = task.spawn(function()
        repeat
            updateSupportPlatform()
            followSelectedRoute(function()
                return not State.AutoFarm
            end)
            task.wait(0.15)
        until not State.AutoFarm or not State.LoopRoute
        State.AutoFarm = false
        State.AutoFarmThread = nil
        cancelTween()
        updateSupportPlatform()
    end)
    notify("Auto Farm", "Started on " .. State.SelectedWorld)
end

local function stopAutoFarm()
    State.AutoFarm = false
    cancelTween()
    updateSupportPlatform()
    notify("Auto Farm", "Stopped")
end

local function getSelectedCheckpoint()
    for _, checkpoint in ipairs(CheckpointTargets) do
        if checkpoint.Name == State.SelectedCheckpoint then
            return checkpoint
        end
    end
    return CheckpointTargets[1]
end

local function walkLeftForSeconds(seconds)
    local endTime = os.clock() + seconds
    while os.clock() < endTime and State.CheckpointFlyActive do
        local character = LocalPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local root = character and character:FindFirstChild("HumanoidRootPart")
        if humanoid and root then
            humanoid.PlatformStand = false
            humanoid:ChangeState(Enum.HumanoidStateType.Running)
            humanoid:Move(Vector3.new(1, 0, 0), true)
            local camera = Services.Workspace.CurrentCamera
            local rightVector = camera and camera.CFrame.RightVector or root.CFrame.RightVector
            local left = Vector3.new(rightVector.X, 0, rightVector.Z)
            if left.Magnitude > 0 then
                local speed = math.max(humanoid.WalkSpeed, 16)
                local velocity = root.AssemblyLinearVelocity
                root.AssemblyLinearVelocity = Vector3.new(left.Unit.X * speed, math.max(velocity.Y, 0), left.Unit.Z * speed)
            end
        end
        Services.RunService.Heartbeat:Wait()
    end
    local humanoid = getHumanoid()
    if humanoid then
        humanoid:Move(Vector3.new(0, 0, 0), false)
    end
    local root = getRoot()
    if root then
        local velocity = root.AssemblyLinearVelocity
        root.AssemblyLinearVelocity = Vector3.new(0, velocity.Y, 0)
    end
end

local function getNearestAutoFarmRouteIndex(position)
    local route = WorldRoutes["World 1"]
    local nearestIndex = 1
    local nearestDistance = math.huge
    for index, routePosition in ipairs(route) do
        local distance = (routePosition - position).Magnitude
        if distance < nearestDistance then
            nearestDistance = distance
            nearestIndex = index
        end
    end
    return nearestIndex
end

local function flyToSelectedCheckpoint()
    if State.CheckpointFlyActive then
        notify("Checkpoint Fly", "Already flying")
        return false
    end
    local checkpoint = getSelectedCheckpoint()
    if not checkpoint then
        return false
    end
    State.CheckpointFlyActive = true
    updateSupportPlatform()
    local success = true
    local route = WorldRoutes["World 1"]
    local targetRouteIndex = getNearestAutoFarmRouteIndex(checkpoint.Position)
    for index = 1, targetRouteIndex do
        if not State.CheckpointFlyActive then
            success = false
            break
        end
        success = tweenTo(route[index], function()
            return not State.CheckpointFlyActive
        end)
        if not success then
            break
        end
        if State.PointDelay > 0 then
            task.wait(State.PointDelay)
        end
    end
    if success and State.CheckpointFlyActive and (route[targetRouteIndex] - checkpoint.Position).Magnitude > 1 then
        success = tweenTo(checkpoint.Position, function()
            return not State.CheckpointFlyActive
        end)
    end
    if success and State.CheckpointFlyActive then
        walkLeftForSeconds(Config.CheckpointForwardTime)
    end
    State.CheckpointFlyActive = false
    updateSupportPlatform()
    return success
end

local function startCheckpointFlyLoop()
    if State.CheckpointFlyThread then
        return
    end
    State.CheckpointFlyLoop = true
    updateSupportPlatform()
    State.CheckpointFlyThread = task.spawn(function()
        while State.CheckpointFlyLoop do
            flyToSelectedCheckpoint()
            if State.CheckpointFlyLoop then
                task.wait(0.25)
            end
        end
        State.CheckpointFlyThread = nil
        updateSupportPlatform()
    end)
    notify("Checkpoint Fly", "Loop started: " .. State.SelectedCheckpoint)
end

local function stopCheckpointFlyLoop()
    State.CheckpointFlyLoop = false
    State.CheckpointFlyActive = false
    cancelTween()
    updateSupportPlatform()
    notify("Checkpoint Fly", "Loop stopped")
end

local function runRouteOnce()
    if State.RouteRunning then
        notify("Route", "A route is already running")
        return
    end
    State.RouteRunning = true
    task.spawn(function()
        followSelectedRoute(function()
            return State.AutoFarm
        end)
        State.RouteRunning = false
    end)
end

local function teleportToFirstCheckpoint()
    local route = WorldRoutes[State.SelectedWorld] or WorldRoutes["World 1"]
    local root = getRoot()
    if root and route[1] then
        root.CFrame = CFrame.new(route[1] + Vector3.new(0, Config.TeleportYOffset, 0))
        notify("Teleport", "Moved to first checkpoint")
    end
end

local function setNoclip(enabled)
    State.Noclip = enabled
    if State.NoclipConnection then
        State.NoclipConnection:Disconnect()
        State.NoclipConnection = nil
    end
    if enabled then
        State.NoclipConnection = Services.RunService.Stepped:Connect(function()
            local character = LocalPlayer.Character
            if not character then
                return
            end
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    end
end

local function setInfiniteJump(enabled)
    State.InfiniteJump = enabled
    if State.InfiniteJumpConnection then
        State.InfiniteJumpConnection:Disconnect()
        State.InfiniteJumpConnection = nil
    end
    if enabled then
        State.InfiniteJumpConnection = Services.UserInputService.JumpRequest:Connect(function()
            local humanoid = getHumanoid()
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end

local function clearFlyObjects()
    if State.FlyConnection then
        State.FlyConnection:Disconnect()
        State.FlyConnection = nil
    end
    if State.FlyBodyVelocity then
        State.FlyBodyVelocity:Destroy()
        State.FlyBodyVelocity = nil
    end
    if State.FlyBodyGyro then
        State.FlyBodyGyro:Destroy()
        State.FlyBodyGyro = nil
    end
end

local function setFly(enabled)
    State.Fly = enabled
    clearFlyObjects()
    local humanoid = getHumanoid()
    local root = getRoot()
    if not enabled then
        if humanoid then
            humanoid.PlatformStand = false
        end
        updateSupportPlatform()
        return
    end
    if not root then
        State.Fly = false
        updateSupportPlatform()
        notify("Fly", "Character not ready")
        return
    end
    updateSupportPlatform()
    if humanoid then
        humanoid.PlatformStand = true
    end
    local velocity = Instance.new("BodyVelocity")
    velocity.Name = "ORVA_FlyVelocity"
    velocity.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000)
    velocity.Velocity = Vector3.new(0, 0, 0)
    velocity.Parent = root
    local gyro = Instance.new("BodyGyro")
    gyro.Name = "ORVA_FlyGyro"
    gyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000)
    gyro.P = 90000
    gyro.CFrame = root.CFrame
    gyro.Parent = root
    State.FlyBodyVelocity = velocity
    State.FlyBodyGyro = gyro
    State.FlyConnection = Services.RunService.RenderStepped:Connect(function()
        local camera = Services.Workspace.CurrentCamera
        local character = LocalPlayer.Character
        local currentHumanoid = character and character:FindFirstChildOfClass("Humanoid")
        local currentRoot = character and character:FindFirstChild("HumanoidRootPart")
        if not camera or not currentRoot or not State.FlyBodyVelocity or not State.FlyBodyGyro then
            return
        end
        updateSupportPlatform()
        if currentHumanoid then
            currentHumanoid.PlatformStand = true
        end
        local move = Vector3.new(0, 0, 0)
        if currentHumanoid and currentHumanoid.MoveDirection.Magnitude > 0 then
            move = currentHumanoid.MoveDirection
        end
        local look = camera.CFrame.LookVector
        local right = camera.CFrame.RightVector
        if Services.UserInputService:IsKeyDown(Enum.KeyCode.W) then
            move = move + look
        end
        if Services.UserInputService:IsKeyDown(Enum.KeyCode.S) then
            move = move - look
        end
        if Services.UserInputService:IsKeyDown(Enum.KeyCode.D) then
            move = move + right
        end
        if Services.UserInputService:IsKeyDown(Enum.KeyCode.A) then
            move = move - right
        end
        if Services.UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            move = move + Vector3.new(0, 1, 0)
        end
        if Services.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            move = move - Vector3.new(0, 1, 0)
        end
        if move.Magnitude <= 0 then
            move = look
        end
        State.FlyBodyVelocity.Velocity = move.Unit * State.FlySpeed
        State.FlyBodyGyro.CFrame = camera.CFrame
    end)
end

local function setAntiAfk(enabled)
    State.AntiAfk = enabled
    if State.AntiAfkConnection then
        State.AntiAfkConnection:Disconnect()
        State.AntiAfkConnection = nil
    end
    if enabled then
        State.AntiAfkConnection = LocalPlayer.Idled:Connect(function()
            pcall(function()
                Services.VirtualUser:CaptureController()
                Services.VirtualUser:ClickButton2(Vector2.new())
            end)
        end)
    end
    notify("Anti AFK", enabled and "Enabled" or "Disabled")
end

local function combinedObjectName(object)
    local text = string.lower(object.Name or "")
    local parent = object.Parent
    if parent then
        text = text .. " " .. string.lower(parent.Name or "")
    end
    return text
end

local function textHasKeyword(text, keywords)
    for _, keyword in ipairs(keywords) do
        if string.find(text, keyword, 1, true) then
            return true
        end
    end
    return false
end

local function isPlayerObject(object)
    for _, player in ipairs(Services.Players:GetPlayers()) do
        local character = player.Character
        if character and (object == character or object:IsDescendantOf(character)) then
            return true
        end
    end
    return false
end

local function isProtectedWorldObject(object)
    return textHasKeyword(combinedObjectName(object), ProtectedWorldKeywords)
end

local function isObstacleObject(object)
    local text = combinedObjectName(object)
    if textHasKeyword(text, ObstacleKeywords) then
        return true
    end
    if object:IsA("BasePart") and object:FindFirstChildOfClass("TouchTransmitter") then
        return true
    end
    return false
end

local function deleteObstacles()
    local removed = 0
    for _, object in ipairs(Services.Workspace:GetDescendants()) do
        if object.Parent and not isPlayerObject(object) and not isProtectedWorldObject(object) and isObstacleObject(object) then
            if object:IsA("BasePart") then
                pcall(function()
                    object.CanCollide = false
                end)
                pcall(function()
                    object.CanTouch = false
                end)
                pcall(function()
                    object.Transparency = 1
                end)
                pcall(function()
                    object:Destroy()
                end)
                removed = removed + 1
            elseif object:IsA("Model") and textHasKeyword(combinedObjectName(object), ObstacleKeywords) then
                pcall(function()
                    object:Destroy()
                end)
                removed = removed + 1
            end
        end
    end
    notify("Delete Obstacles", "Removed " .. tostring(removed) .. " obstacle objects")
end

local function getEspParent()
    local ok, coreGui = pcall(function()
        return game:GetService("CoreGui")
    end)
    if ok and coreGui then
        return coreGui
    end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local function destroyEspFor(player)
    local object = Esp.Objects[player]
    if not object then
        return
    end
    if object.Gui then
        object.Gui:Destroy()
    end
    if object.Highlight then
        object.Highlight:Destroy()
    end
    Esp.Objects[player] = nil
end

local function clearEsp()
    for player in pairs(Esp.Objects) do
        destroyEspFor(player)
    end
end

local function createEspFor(player)
    if player == LocalPlayer then
        return
    end
    local character = player.Character
    local adornee = character and (character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart"))
    if not adornee then
        return
    end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ORVA_PlayerESP_" .. player.Name
    billboard.Adornee = adornee
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 180, 0, 38)
    billboard.StudsOffset = Vector3.new(0, 3.1, 0)
    billboard.Parent = getEspParent()
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextColor3 = Esp.Color
    label.TextStrokeTransparency = 0.25
    label.Parent = billboard
    Esp.Objects[player] = {Gui = billboard, Label = label, Highlight = nil}
end

local function updateHighlight(player, object)
    local character = player.Character
    if not character then
        return
    end
    if Esp.Enabled then
        if not object.Highlight then
            pcall(function()
                local highlight = Instance.new("Highlight")
                highlight.Name = "ORVA_PlayerHighlight"
                highlight.FillColor = Esp.Color
                highlight.OutlineColor = Esp.Color
                highlight.FillTransparency = 0.65
                highlight.OutlineTransparency = 0
                highlight.Parent = character
                object.Highlight = highlight
            end)
        elseif object.Highlight then
            object.Highlight.FillColor = Esp.Color
            object.Highlight.OutlineColor = Esp.Color
        end
    elseif object.Highlight then
        object.Highlight:Destroy()
        object.Highlight = nil
    end
end

local function distanceToPlayer(player)
    local root = getRoot()
    local character = player.Character
    local otherRoot = character and character:FindFirstChild("HumanoidRootPart")
    if not root or not otherRoot then
        return nil
    end
    return math.floor((root.Position - otherRoot.Position).Magnitude)
end

local function updateEsp()
    if os.clock() - Esp.LastUpdate < 0.18 then
        return
    end
    Esp.LastUpdate = os.clock()
    local active = Esp.Enabled or Esp.ShowNames or Esp.ShowDistance
    if not active then
        clearEsp()
        return
    end
    for _, player in ipairs(Services.Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            local adornee = character and (character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart"))
            if not adornee then
                destroyEspFor(player)
            else
                if not Esp.Objects[player] then
                    createEspFor(player)
                end
                local object = Esp.Objects[player]
                if object then
                    object.Gui.Adornee = adornee
                    object.Label.TextColor3 = Esp.Color
                    local parts = {}
                    if Esp.ShowNames or not Esp.ShowDistance then
                        table.insert(parts, player.Name)
                    end
                    if Esp.ShowDistance then
                        local distance = distanceToPlayer(player)
                        if distance then
                            table.insert(parts, tostring(distance) .. " studs")
                        end
                    end
                    object.Label.Text = table.concat(parts, " | ")
                    updateHighlight(player, object)
                end
            end
        end
    end
end

local function syncEspConnection()
    local active = Esp.Enabled or Esp.ShowNames or Esp.ShowDistance
    if active and not Esp.Connection then
        Esp.Connection = Services.RunService.Heartbeat:Connect(updateEsp)
    elseif not active and Esp.Connection then
        Esp.Connection:Disconnect()
        Esp.Connection = nil
        clearEsp()
    end
    updateEsp()
end

local function findShopItem(name)
    for _, item in ipairs(ShopItems) do
        if item.Name == name then
            return item
        end
    end
    return ShopItems[1]
end

local function findRemoteByHints(hints)
    local containers = {Services.ReplicatedStorage, Services.Workspace}
    for _, container in ipairs(containers) do
        local ok, descendants = pcall(function()
            return container:GetDescendants()
        end)
        if ok then
            for _, object in ipairs(descendants) do
                if object:IsA("RemoteEvent") or object:IsA("RemoteFunction") then
                    local remoteName = string.lower(object.Name)
                    for _, hint in ipairs(hints) do
                        local hintName = string.lower(hint)
                        if remoteName == hintName or string.find(remoteName, hintName, 1, true) then
                            return object
                        end
                    end
                end
            end
        end
    end
    return nil
end

local function fireShopItem(item, quiet)
    local remote = findRemoteByHints(item.Hints)
    if not remote then
        if not quiet then
            notify("Items Shop", "No matching remote found for " .. item.Name)
        end
        return false
    end
    local ok = pcall(function()
        if remote:IsA("RemoteEvent") then
            remote:FireServer(unpackValue(item.Args or {item.Name}))
        else
            remote:InvokeServer(unpackValue(item.Args or {item.Name}))
        end
    end)
    if ok and not quiet then
        notify("Items Shop", "Request sent for " .. item.Name)
    elseif not ok and not quiet then
        notify("Items Shop", "Remote call failed for " .. item.Name)
    end
    return ok
end

local function startAutoBuy()
    if State.AutoBuyThread then
        return
    end
    State.AutoBuy = true
    State.AutoBuyThread = task.spawn(function()
        while State.AutoBuy do
            local item = findShopItem(State.SelectedShopItem)
            if item then
                fireShopItem(item, true)
            end
            task.wait(State.AutoBuyDelay)
        end
        State.AutoBuyThread = nil
    end)
    notify("Items Shop", "Auto buy started")
end

local function stopAutoBuy()
    State.AutoBuy = false
    notify("Items Shop", "Auto buy stopped")
end

local function collectNearbyDrops(quiet)
    local root = getRoot()
    if not root then
        return
    end
    local touched = 0
    local keywords = {"candy", "chocolate", "coin", "gem", "drop", "orb", "pickup", "reward"}
    for _, object in ipairs(Services.Workspace:GetDescendants()) do
        if object:IsA("BasePart") then
            local objectName = string.lower(object.Name)
            local matched = false
            for _, keyword in ipairs(keywords) do
                if string.find(objectName, keyword, 1, true) then
                    matched = true
                    break
                end
            end
            if matched and (object.Position - root.Position).Magnitude <= State.CollectRadius then
                pcall(function()
                    firetouchinterest(root, object, 0)
                    firetouchinterest(root, object, 1)
                end)
                touched = touched + 1
            end
        end
    end
    if not quiet then
        notify("Collector", "Touched " .. tostring(touched) .. " nearby objects")
    end
end

local function startAutoCollect()
    if State.AutoCollectThread then
        return
    end
    State.AutoCollect = true
    State.AutoCollectThread = task.spawn(function()
        while State.AutoCollect do
            collectNearbyDrops(true)
            task.wait(0.8)
        end
        State.AutoCollectThread = nil
    end)
    notify("Collector", "Auto collect started")
end

local function stopAutoCollect()
    State.AutoCollect = false
    notify("Collector", "Auto collect stopped")
end

local function leaderstatsText()
    local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
    if not leaderstats then
        return "leaderstats: not found"
    end
    local parts = {}
    for _, value in ipairs(leaderstats:GetChildren()) do
        if value:IsA("ValueBase") then
            table.insert(parts, value.Name .. ": " .. tostring(value.Value))
        end
    end
    if #parts == 0 then
        return "leaderstats: empty"
    end
    return table.concat(parts, " | ")
end

local function currentPositionText()
    local root = getRoot()
    if not root then
        return "Position: unavailable"
    end
    local position = root.Position
    return string.format("Position: %.2f, %.2f, %.2f", position.X, position.Y, position.Z)
end

local function copyText(text, title)
    if setclipboard then
        setclipboard(text)
        notify(title or "Clipboard", "Copied")
    else
        notify(title or "Clipboard", text)
    end
end

local function copyKeyToClipboard()
    local clipboardFunctions = {
        setclipboard,
        toclipboard,
        set_clipboard,
        Clipboard and Clipboard.set,
        syn and syn.write_clipboard
    }
    for _, clipboardFunction in ipairs(clipboardFunctions) do
        if type(clipboardFunction) == "function" then
            local success = pcall(clipboardFunction, CrackedKey)
            if success then
                return true
            end
        end
    end
    return false
end

local function getUiParent()
    if type(gethui) == "function" then
        local success, result = pcall(gethui)
        if success and result ~= nil then
            return result
        end
    end
    local success, result = pcall(function()
        return game:GetService("CoreGui")
    end)
    if success and result ~= nil then
        return result
    end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local function createCrackedKeyNotification()
    local parent = getUiParent()
    local existing = parent:FindFirstChild("CrackedKeyNotification")
    if existing ~= nil then
        existing:Destroy()
    end
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CrackedKeyNotification"
    screenGui.IgnoreGuiInset = true
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = parent
    local frame = Instance.new("Frame")
    frame.AnchorPoint = Vector2.new(0.5, 0)
    frame.Position = UDim2.new(0.5, 0, 0, -120)
    frame.Size = UDim2.new(0.92, 0, 0, 88)
    frame.BackgroundColor3 = Color3.fromRGB(18, 18, 40)
    frame.BackgroundTransparency = 0.08
    frame.BorderSizePixel = 0
    frame.ZIndex = 1000
    frame.Parent = screenGui
    local sizeLimit = Instance.new("UISizeConstraint")
    sizeLimit.MaxSize = Vector2.new(620, 88)
    sizeLimit.MinSize = Vector2.new(280, 88)
    sizeLimit.Parent = frame
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 18)
    corner.Parent = frame
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(180, 140, 255)
    stroke.Thickness = 1.4
    stroke.Transparency = 0.18
    stroke.Parent = frame
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 18)
    padding.PaddingRight = UDim.new(0, 18)
    padding.PaddingTop = UDim.new(0, 12)
    padding.PaddingBottom = UDim.new(0, 12)
    padding.Parent = frame
    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Size = UDim2.new(1, 0, 0, 34)
    title.Font = Enum.Font.GothamSemibold
    title.Text = "Hola, este script ha sido crackeado lol. La key es " .. CrackedKey
    title.TextColor3 = Color3.fromRGB(245, 243, 255)
    title.TextSize = 17
    title.TextWrapped = true
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextYAlignment = Enum.TextYAlignment.Center
    title.ZIndex = 1001
    title.Parent = frame
    local subtitle = Instance.new("TextLabel")
    subtitle.BackgroundTransparency = 1
    subtitle.Position = UDim2.new(0, 0, 0, 38)
    subtitle.Size = UDim2.new(1, 0, 0, 28)
    subtitle.Font = Enum.Font.Gotham
    subtitle.Text = "Dale las gracias a TheRealBanHammer por desofuscar el script y a WeAreDevs.net por hacer un ofuscador de mierda"
    subtitle.TextColor3 = Color3.fromRGB(210, 205, 235)
    subtitle.TextSize = 13
    subtitle.TextWrapped = true
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.TextYAlignment = Enum.TextYAlignment.Center
    subtitle.ZIndex = 1001
    subtitle.Parent = frame
    task.spawn(function()
        frame.Position = UDim2.new(0.5, 0, 0, -120)
        frame.BackgroundTransparency = 0.18
        title.TextTransparency = 1
        subtitle.TextTransparency = 1
        stroke.Transparency = 1
        Services.TweenService:Create(frame, TweenInfo.new(0.42, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, 0, 20),
            BackgroundTransparency = 0.08
        }):Play()
        Services.TweenService:Create(title, TweenInfo.new(0.32, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 0
        }):Play()
        Services.TweenService:Create(subtitle, TweenInfo.new(0.36, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 0
        }):Play()
        Services.TweenService:Create(stroke, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 0.18
        }):Play()
        task.wait(5)
        Services.TweenService:Create(frame, TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, 0, 0, -120),
            BackgroundTransparency = 1
        }):Play()
        Services.TweenService:Create(title, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            TextTransparency = 1
        }):Play()
        Services.TweenService:Create(subtitle, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            TextTransparency = 1
        }):Play()
        Services.TweenService:Create(stroke, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Transparency = 1
        }):Play()
        task.wait(0.45)
        if screenGui then
            screenGui:Destroy()
        end
    end)
end

copyKeyToClipboard()
createCrackedKeyNotification()

local Window = Rayfield:CreateWindow({
    Name = Config.WindowTitle,
    Icon = 0,
    LoadingTitle = Config.LoadingTitle,
    LoadingSubtitle = Config.LoadingSubtitle,
    ShowText = "Rayfield",
    Theme = Theme,
    ToggleUIKeybind = Config.ToggleUIKeybind,
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = true,
        FileName = Config.ConfigFolder
    },
    Discord = {
        Enabled = true,
        Invite = Config.DiscordInvite,
        RememberJoins = false
    },
    KeySystem = Config.KeySystem,
    KeySettings = {
        Title = Config.KeyTitle,
        Subtitle = Config.KeySubtitle,
        Note = Config.KeyNote,
        FileName = Config.KeyFileName,
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = Config.Keys
    }
})

local MainTab = Window:CreateTab("⚙️ Main")
local MiscTab = Window:CreateTab("👀 Misc")
local ItemsTab = Window:CreateTab("🛒 Items Shop")
local StatsTab = Window:CreateTab("📈 Stats")
local CreditTab = Window:CreateTab("⭐ Credit")

MainTab:CreateSection("World Selection")
MainTab:CreateDropdown({
    Name = "🌎 Select World",
    Options = {"World 1", "World 2"},
    CurrentOption = {State.SelectedWorld},
    MultipleOptions = false,
    Flag = "SelectWorld",
    Callback = function(value)
        State.SelectedWorld = optionValue(value, State.SelectedWorld)
        notify("World Selected", "Selected " .. State.SelectedWorld)
    end
})

MainTab:CreateSection("Auto Farm")
MainTab:CreateToggle({
    Name = "🚀 Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(value)
        if value then
            startAutoFarm()
        else
            stopAutoFarm()
        end
    end
})
MainTab:CreateToggle({
    Name = "🔁 Loop Route",
    CurrentValue = true,
    Flag = "LoopRoute",
    Callback = function(value)
        State.LoopRoute = value
    end
})
MainTab:CreateInput({
    Name = "⚡ Tween Speed",
    CurrentValue = tostring(State.TweenSpeed),
    PlaceholderText = "65",
    RemoveTextAfterFocusLost = false,
    Flag = "TweenSpeed",
    Callback = function(value)
        State.TweenSpeed = numberFromText(value, State.TweenSpeed, 5, 500)
    end
})
MainTab:CreateInput({
    Name = "⏱️ Point Delay",
    CurrentValue = tostring(State.PointDelay),
    PlaceholderText = "0.05",
    RemoveTextAfterFocusLost = false,
    Flag = "PointDelay",
    Callback = function(value)
        State.PointDelay = numberFromText(value, State.PointDelay, 0, 10)
    end
})
MainTab:CreateKeybind({
    Name = "⌨️ Toggle Auto Farm",
    CurrentKeybind = "F",
    HoldToInteract = false,
    Flag = "AutoFarmKeybind",
    Callback = function()
        if State.AutoFarm then
            stopAutoFarm()
        else
            startAutoFarm()
        end
    end
})
createButton(MainTab, {
    Name = "▶️ Run Selected Route Once",
    Flag = "RunRouteOnce",
    Callback = runRouteOnce
})
createButton(MainTab, {
    Name = "⛔ Stop Auto Farm",
    Flag = "StopAutoFarmButton",
    Callback = stopAutoFarm
})
MainTab:CreateDropdown({
    Name = "Volar a checkpoint",
    Options = CheckpointNames,
    CurrentOption = {State.SelectedCheckpoint},
    MultipleOptions = false,
    Flag = "FlyToCheckpointDropdown",
    Callback = function(value)
        State.SelectedCheckpoint = optionValue(value, State.SelectedCheckpoint)
        notify("Checkpoint Fly", "Selected " .. State.SelectedCheckpoint)
    end
})
createButton(MainTab, {
    Name = "Volar al checkpoint seleccionado",
    Flag = "FlySelectedCheckpointOnce",
    Callback = function()
        task.spawn(function()
            flyToSelectedCheckpoint()
        end)
    end
})
MainTab:CreateToggle({
    Name = "Loop al checkpoint seleccionado",
    CurrentValue = false,
    Flag = "LoopSelectedCheckpoint",
    Callback = function(value)
        if value then
            startCheckpointFlyLoop()
        else
            stopCheckpointFlyLoop()
        end
    end
})
createButton(MainTab, {
    Name = "📍 Teleport To First Checkpoint",
    Flag = "TeleportFirstCheckpoint",
    Callback = teleportToFirstCheckpoint
})

MainTab:CreateSection("Auto Collect")
MainTab:CreateToggle({
    Name = "🍬 Auto Collect Drops",
    CurrentValue = false,
    Flag = "AutoCollectDrops",
    Callback = function(value)
        if value then
            startAutoCollect()
        else
            stopAutoCollect()
        end
    end
})
MainTab:CreateInput({
    Name = "📏 Collect Radius",
    CurrentValue = tostring(State.CollectRadius),
    PlaceholderText = "45",
    RemoveTextAfterFocusLost = false,
    Flag = "CollectRadius",
    Callback = function(value)
        State.CollectRadius = numberFromText(value, State.CollectRadius, 5, 500)
    end
})
createButton(MainTab, {
    Name = "🧲 Collect Nearby Once",
    Flag = "CollectNearbyOnce",
    Callback = function()
        collectNearbyDrops(false)
    end
})

MiscTab:CreateSection("Player ESP Section")
MiscTab:CreateToggle({
    Name = "👤 Show Player Names",
    CurrentValue = false,
    Flag = "ShowPlayerNames",
    Callback = function(value)
        Esp.ShowNames = value
        syncEspConnection()
    end
})
MiscTab:CreateToggle({
    Name = "📏 Show Distance",
    CurrentValue = false,
    Flag = "ShowDistance",
    Callback = function(value)
        Esp.ShowDistance = value
        syncEspConnection()
    end
})
MiscTab:CreateToggle({
    Name = "👤 Player ESP",
    CurrentValue = false,
    Flag = "PlayerESP",
    Callback = function(value)
        Esp.Enabled = value
        syncEspConnection()
    end
})
MiscTab:CreateColorPicker({
    Name = "🎨 ESP Color",
    Color = Esp.Color,
    Flag = "ESPColor",
    Callback = function(value)
        Esp.Color = value
        updateEsp()
    end
})

MiscTab:CreateSection("Player Utilities")
MiscTab:CreateToggle({
    Name = "🧱 Noclip",
    CurrentValue = false,
    Flag = "Noclip",
    Callback = setNoclip
})
MiscTab:CreateToggle({
    Name = "🪂 Infinite Jump",
    CurrentValue = false,
    Flag = "InfiniteJump",
    Callback = setInfiniteJump
})
MiscTab:CreateInput({
    Name = "🏃 WalkSpeed",
    CurrentValue = "",
    PlaceholderText = "16",
    RemoveTextAfterFocusLost = false,
    Flag = "WalkSpeed",
    Callback = function(value)
        State.WalkSpeed = numberFromText(value, nil, 1, 500)
        applyMovement()
    end
})
MiscTab:CreateInput({
    Name = "🦘 JumpPower",
    CurrentValue = "",
    PlaceholderText = "50",
    RemoveTextAfterFocusLost = false,
    Flag = "JumpPower",
    Callback = function(value)
        State.JumpPower = numberFromText(value, nil, 1, 500)
        applyMovement()
    end
})
createButton(MiscTab, {
    Name = "🔄 Reset Movement",
    Flag = "ResetMovement",
    Callback = function()
        State.WalkSpeed = nil
        State.JumpPower = nil
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
        end
        notify("Movement", "Movement values reset")
    end
})
createButton(MiscTab, {
    Name = "✈️ Fly (Mobile Toggle)",
    Flag = "FlyMobileToggle",
    Callback = function()
        setFly(not State.Fly)
        notify("Fly", State.Fly and "Enabled" or "Disabled")
    end
})

MiscTab:CreateSection("World Modifiers")
createButton(MiscTab, {
    Name = "🧹 Delete Obstacles",
    Flag = "DeleteObstacles",
    Callback = deleteObstacles
})
MiscTab:CreateToggle({
    Name = "💤 Anti AFK",
    CurrentValue = false,
    Flag = "AntiAFK",
    Callback = setAntiAfk
})

ItemsTab:CreateSection("Shop")
ItemsTab:CreateDropdown({
    Name = "🛍️ Select Item",
    Options = ShopItemNames,
    CurrentOption = {State.SelectedShopItem},
    MultipleOptions = false,
    Flag = "SelectShopItem",
    Callback = function(value)
        State.SelectedShopItem = optionValue(value, State.SelectedShopItem)
        notify("Items Shop", "Selected " .. State.SelectedShopItem)
    end
})
createButton(ItemsTab, {
    Name = "🛒 Buy Selected Item",
    Flag = "BuySelectedItem",
    Callback = function()
        fireShopItem(findShopItem(State.SelectedShopItem), false)
    end
})
ItemsTab:CreateToggle({
    Name = "🔁 Auto Buy Selected Item",
    CurrentValue = false,
    Flag = "AutoBuySelectedItem",
    Callback = function(value)
        if value then
            startAutoBuy()
        else
            stopAutoBuy()
        end
    end
})
ItemsTab:CreateInput({
    Name = "⏱️ Auto Buy Delay",
    CurrentValue = tostring(State.AutoBuyDelay),
    PlaceholderText = "1.5",
    RemoveTextAfterFocusLost = false,
    Flag = "AutoBuyDelay",
    Callback = function(value)
        State.AutoBuyDelay = numberFromText(value, State.AutoBuyDelay, 0.2, 20)
    end
})
createButton(ItemsTab, {
    Name = "🔎 Scan Shop Remote",
    Flag = "ScanShopRemote",
    Callback = function()
        local item = findShopItem(State.SelectedShopItem)
        local remote = item and findRemoteByHints(item.Hints)
        if remote then
            notify("Items Shop", "Found " .. remote.Name)
        else
            notify("Items Shop", "No remote found for " .. State.SelectedShopItem)
        end
    end
})

StatsTab:CreateSection("Live Stats")
local StatsLabels = {
    Player = createLabel(StatsTab, "Player: " .. LocalPlayer.Name),
    World = createLabel(StatsTab, "World: " .. State.SelectedWorld),
    Route = createLabel(StatsTab, "Route Points: " .. tostring(#WorldRoutes[State.SelectedWorld])),
    Position = createLabel(StatsTab, currentPositionText()),
    Leaderstats = createLabel(StatsTab, leaderstatsText()),
    Movement = createLabel(StatsTab, "WalkSpeed: default | JumpPower: default")
}

local function refreshStatsLabels()
    local route = WorldRoutes[State.SelectedWorld] or {}
    local humanoid = getHumanoid()
    setLabel(StatsLabels.Player, "Player: " .. LocalPlayer.Name)
    setLabel(StatsLabels.World, "World: " .. State.SelectedWorld)
    setLabel(StatsLabels.Route, "Route Points: " .. tostring(#route))
    setLabel(StatsLabels.Position, currentPositionText())
    setLabel(StatsLabels.Leaderstats, leaderstatsText())
    if humanoid then
        setLabel(StatsLabels.Movement, "WalkSpeed: " .. tostring(humanoid.WalkSpeed) .. " | JumpPower: " .. tostring(humanoid.JumpPower))
    end
end

createButton(StatsTab, {
    Name = "🔄 Refresh Stats",
    Flag = "RefreshStats",
    Callback = refreshStatsLabels
})
createButton(StatsTab, {
    Name = "📋 Copy Position",
    Flag = "CopyPosition",
    Callback = function()
        copyText(currentPositionText(), "Position")
    end
})
createButton(StatsTab, {
    Name = "📋 Copy World",
    Flag = "CopyWorld",
    Callback = function()
        copyText(State.SelectedWorld, "World")
    end
})

CreditTab:CreateSection("Credit")
createLabel(CreditTab, "TheRealBanHammer - La mera verdura del caldo 🥵")
createLabel(CreditTab, "+1 Speed Keyboard Escape | Candy & Chocolate")
createLabel(CreditTab, "Discord: https://discord.gg/" .. Config.DiscordInvite)
createLabel(CreditTab, "Key: " .. Config.Key)
createLabel(CreditTab, "Rayfield: sirius.menu/rayfield")
createButton(CreditTab, {
    Name = "📋 Copy Discord",
    Flag = "CopyDiscord",
    Callback = function()
        copyText("https://discord.gg/" .. Config.DiscordInvite, "Discord")
    end
})
createButton(CreditTab, {
    Name = "⭐ Show Credits",
    Flag = "ShowCredits",
    Callback = function()
        notify("Credit", "TheRealBanHammer | Discord: discord.gg/" .. Config.DiscordInvite)
    end
})

Services.Players.PlayerRemoving:Connect(function(player)
    destroyEspFor(player)
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    applyMovement()
    updateSupportPlatform()
    if State.Fly then
        setFly(true)
    end
end)

task.spawn(function()
    while task.wait(1) do
        refreshStatsLabels()
    end
end)

notify(Config.LoadedNotificationTitle, Config.LoadedNotificationContent .. State.SelectedWorld)
