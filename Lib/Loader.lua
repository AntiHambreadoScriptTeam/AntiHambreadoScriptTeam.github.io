local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

local TargetParent = LocalPlayer:WaitForChild("PlayerGui")
local gethui = gethui
if gethui then
    TargetParent = gethui()
else
    local success, _ = pcall(function()
        local temp = Instance.new("Folder")
        temp.Parent = CoreGui
        temp:Destroy()
    end)
    if success then
        TargetParent = CoreGui
    end
end

local function GetAsset(Name, Url)
    if not isfile or not writefile or not getcustomasset then
        return Url
    end
    if not isfile(Name) then
        local success, content = pcall(function()
            return game:HttpGet(Url)
        end)
        if success and content then
            writefile(Name, content)
        end
    end
    if isfile(Name) then
        local success, asset = pcall(getcustomasset, Name)
        if success then
            return asset
        end
    end
    return Url
end

local Themes = {
    ["AMOLED Red"] = {
        Background = Color3.fromRGB(0, 0, 0),
        Accent = Color3.fromRGB(255, 45, 45),
        CardBackground = Color3.fromRGB(10, 10, 10),
        Border = Color3.fromRGB(30, 30, 30),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(160, 160, 160),
        ActiveTab = Color3.fromRGB(255, 45, 45),
        Hover = Color3.fromRGB(20, 20, 20),
        Sidebar = Color3.fromRGB(5, 5, 5),
        BorderGlow = Color3.fromRGB(50, 10, 10)
    },
    ["AMOLED Blue"] = {
        Background = Color3.fromRGB(0, 0, 0),
        Accent = Color3.fromRGB(45, 125, 255),
        CardBackground = Color3.fromRGB(10, 10, 10),
        Border = Color3.fromRGB(30, 30, 30),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(160, 160, 160),
        ActiveTab = Color3.fromRGB(45, 125, 255),
        Hover = Color3.fromRGB(20, 20, 20),
        Sidebar = Color3.fromRGB(5, 5, 5),
        BorderGlow = Color3.fromRGB(10, 25, 50)
    },
    ["AMOLED Purple"] = {
        Background = Color3.fromRGB(0, 0, 0),
        Accent = Color3.fromRGB(160, 45, 255),
        CardBackground = Color3.fromRGB(10, 10, 10),
        Border = Color3.fromRGB(30, 30, 30),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(160, 160, 160),
        ActiveTab = Color3.fromRGB(160, 45, 255),
        Hover = Color3.fromRGB(20, 20, 20),
        Sidebar = Color3.fromRGB(5, 5, 5),
        BorderGlow = Color3.fromRGB(35, 10, 50)
    },
    ["AMOLED Emerald"] = {
        Background = Color3.fromRGB(0, 0, 0),
        Accent = Color3.fromRGB(45, 255, 125),
        CardBackground = Color3.fromRGB(10, 10, 10),
        Border = Color3.fromRGB(30, 30, 30),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(160, 160, 160),
        ActiveTab = Color3.fromRGB(45, 255, 125),
        Hover = Color3.fromRGB(20, 20, 20),
        Sidebar = Color3.fromRGB(5, 5, 5),
        BorderGlow = Color3.fromRGB(10, 50, 25)
    }
}

local Fonts = {
    Title = Enum.Font.MontserratBold,
    SubTitle = Enum.Font.UbuntuMedium,
    SectionHeader = Enum.Font.MontserratBold,
    ComponentLabel = Enum.Font.GothamMedium,
    Value = Enum.Font.RobotoMono,
    Body = Enum.Font.SourceSans
}

local ahst_lib = {
    CurrentTheme = Themes["AMOLED Red"],
    Windows = {},
    Notifications = {}
}

local function tween(object, info, properties)
    local activeTween = TweenService:Create(object, info, properties)
    activeTween:Play()
    return activeTween
end

local function make(className, properties, children)
    local instance = Instance.new(className)
    for k, v in pairs(properties) do
        instance[k] = v
    end
    if children then
        for _, child in ipairs(children) do
            child.Parent = instance
        end
    end
    return instance
end

function ahst_lib:CreateTheme(name, customTable)
    Themes[name] = customTable
end

function ahst_lib:CreateWindow(config)
    config = config or {}
    local titleText = config.Title or "AHST HUB"
    local size = config.Size or UDim2.fromOffset(1200, 700)
    local selectedThemeName = config.Theme or "AMOLED Red"
    local currentTheme = Themes[selectedThemeName] or Themes["AMOLED Red"]
    ahst_lib.CurrentTheme = currentTheme

    local screenGui = make("ScreenGui", {
        Name = "AHST_" .. tostring(math.random(1000, 9999)),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    screenGui.Parent = TargetParent

    local mainFrame = make("Frame", {
        Name = "MainWindow",
        Size = size,
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = currentTheme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = false
    }, {
        make("UICorner", { CornerRadius = UDim.new(0, 12) }),
        make("UIStroke", {
            Color = currentTheme.Border,
            Thickness = 1.5,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        })
    })
    mainFrame.Parent = screenGui

    local backgroundImage = make("ImageLabel", {
        Name = "CosmicBackground",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Image = GetAsset("fondo_lib.png", "https://antihambreadoscriptteam.github.io/Foto/Lib/Fondo-Lib.png"),
        ImageTransparency = 0.3,
        ZIndex = 0
    }, {
        make("UICorner", { CornerRadius = UDim.new(0, 12) })
    })
    backgroundImage.Parent = mainFrame

    local sidebar = make("Frame", {
        Name = "Sidebar",
        Size = UDim2.new(0, 240, 1, 0),
        BackgroundColor3 = currentTheme.Sidebar,
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        ZIndex = 2
    }, {
        make("UICorner", { CornerRadius = UDim.new(0, 12) }),
        make("UIStroke", {
            Color = currentTheme.Border,
            Thickness = 1
        })
    })
    sidebar.Parent = mainFrame

    local sidebarClip = make("Frame", {
        Name = "SidebarClip",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ZIndex = 2
    })
    sidebarClip.Parent = sidebar

    local titleContainer = make("Frame", {
        Size = UDim2.new(1, 0, 0, 80),
        BackgroundTransparency = 1
    })
    titleContainer.Parent = sidebarClip

    local titleLabel = make("TextLabel", {
        Text = titleText,
        Font = Fonts.Title,
        TextSize = 20,
        TextColor3 = currentTheme.Accent,
        Position = UDim2.new(0.5, 0, 0, 25),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(0.9, 0, 0, 30),
        BackgroundTransparency = 1
    })
    titleLabel.Parent = titleContainer

    local subTitleLabel = make("TextLabel", {
        Text = "✦ PREMIUM SCRIPT HUB ✦",
        Font = Fonts.SubTitle,
        TextSize = 10,
        TextColor3 = currentTheme.SubText,
        Position = UDim2.new(0.5, 0, 0, 48),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(0.9, 0, 0, 20),
        BackgroundTransparency = 1
    })
    subTitleLabel.Parent = titleContainer

    local tabsScroller = make("ScrollingFrame", {
        Name = "TabsScroller",
        Size = UDim2.new(1, -20, 1, -190),
        Position = UDim2.new(0, 10, 0, 80),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0)
    })
    tabsScroller.Parent = sidebarClip

    local tabsLayout = make("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6)
    })
    tabsLayout.Parent = tabsScroller

    local function resizeScroller()
        tabsScroller.CanvasSize = UDim2.new(0, 0, 0, tabsLayout.AbsoluteContentSize.Y + 10)
    end
    tabsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resizeScroller)

    local profileContainer = make("Frame", {
        Size = UDim2.new(1, -20, 0, 60),
        Position = UDim2.new(0, 10, 1, -70),
        BackgroundColor3 = currentTheme.CardBackground,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0
    }, {
        make("UICorner", { CornerRadius = UDim.new(0, 8) }),
        make("UIStroke", { Color = currentTheme.Border, Thickness = 1 })
    })
    profileContainer.Parent = sidebarClip

    local avatarImage = make("ImageLabel", {
        Size = UDim2.fromOffset(40, 40),
        Position = UDim2.new(0, 10, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"
    }, {
        make("UICorner", { CornerRadius = UDim.new(1, 0) })
    })
    avatarImage.Parent = profileContainer

    local profileName = make("TextLabel", {
        Text = LocalPlayer.DisplayName,
        Font = Fonts.ComponentLabel,
        TextSize = 13,
        TextColor3 = currentTheme.Text,
        Position = UDim2.new(0, 60, 0, 12),
        Size = UDim2.new(1, -70, 0, 18),
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1
    })
    profileName.Parent = profileContainer

    local profileTag = make("TextLabel", {
        Text = "Premium",
        Font = Fonts.SubTitle,
        TextSize = 10,
        TextColor3 = currentTheme.Accent,
        Position = UDim2.new(0, 60, 0, 28),
        Size = UDim2.new(1, -70, 0, 18),
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1
    })
    profileTag.Parent = profileContainer

    local contentFrame = make("Frame", {
        Name = "ContentFrame",
        Size = UDim2.new(1, -260, 1, -100),
        Position = UDim2.new(0, 250, 0, 60),
        BackgroundTransparency = 1
    })
    contentFrame.Parent = mainFrame

    local searchContainer = make("Frame", {
        Name = "SearchContainer",
        Size = UDim2.new(1, -260, 0, 40),
        Position = UDim2.new(0, 250, 0, 15),
        BackgroundColor3 = currentTheme.CardBackground,
        BorderSizePixel = 0,
        ZIndex = 2
    }, {
        make("UICorner", { CornerRadius = UDim.new(0, 8) }),
        make("UIStroke", { Color = currentTheme.Border, Thickness = 1 })
    })
    searchContainer.Parent = mainFrame

    local searchIcon = make("ImageLabel", {
        Size = UDim2.fromOffset(18, 18),
        Position = UDim2.new(0, 12, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        Image = "rbxassetid://7734052925",
        ImageColor3 = currentTheme.SubText
    })
    searchIcon.Parent = searchContainer

    local searchBox = make("TextBox", {
        Size = UDim2.new(1, -45, 1, 0),
        Position = UDim2.new(0, 40, 0, 0),
        BackgroundTransparency = 1,
        Font = Fonts.Body,
        TextSize = 13,
        TextColor3 = currentTheme.Text,
        PlaceholderText = "Search features...",
        PlaceholderColor3 = currentTheme.SubText,
        Text = "",
        TextXAlignment = Enum.TextXAlignment.Left
    })
    searchBox.Parent = searchContainer

    local footer = make("Frame", {
        Name = "Footer",
        Size = UDim2.new(1, -260, 0, 30),
        Position = UDim2.new(0, 250, 1, -40),
        BackgroundTransparency = 1
    })
    footer.Parent = mainFrame

    local footerText = make("TextLabel", {
        Text = "AHST HUB  •  Premium Script Hub for Roblox",
        Font = Fonts.SubTitle,
        TextSize = 11,
        TextColor3 = currentTheme.SubText,
        Size = UDim2.new(0.7, 0, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1
    })
    footerText.Parent = footer

    local footerVersion = make("TextLabel", {
        Text = "v2.6.0",
        Font = Fonts.Value,
        TextSize = 11,
        TextColor3 = currentTheme.SubText,
        Size = UDim2.new(0.3, 0, 1, 0),
        Position = UDim2.new(0.7, 0, 0, 0),
        TextXAlignment = Enum.TextXAlignment.Right,
        BackgroundTransparency = 1
    })
    footerVersion.Parent = footer

    local controlButtons = make("Frame", {
        Name = "ControlButtons",
        Size = UDim2.fromOffset(100, 30),
        Position = UDim2.new(1, -115, 0, 15),
        BackgroundTransparency = 1,
        ZIndex = 3
    })
    controlButtons.Parent = mainFrame

    local controlLayout = make("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    controlLayout.Parent = controlButtons

    local minimizeButton = make("TextButton", {
        Size = UDim2.fromOffset(24, 24),
        BackgroundColor3 = currentTheme.CardBackground,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = 1
    }, {
        make("UICorner", { CornerRadius = UDim.new(0, 6) }),
        make("UIStroke", { Color = currentTheme.Border, Thickness = 1 }),
        make("ImageLabel", {
            Size = UDim2.fromOffset(12, 12),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Image = "rbxassetid://7734054475",
            ImageColor3 = currentTheme.Text
        })
    })
    minimizeButton.Parent = controlButtons

    local maximizeButton = make("TextButton", {
        Size = UDim2.fromOffset(24, 24),
        BackgroundColor3 = currentTheme.CardBackground,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = 2
    }, {
        make("UICorner", { CornerRadius = UDim.new(0, 6) }),
        make("UIStroke", { Color = currentTheme.Border, Thickness = 1 }),
        make("ImageLabel", {
            Size = UDim2.fromOffset(12, 12),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Image = "rbxassetid://7733955767",
            ImageColor3 = currentTheme.Text
        })
    })
    maximizeButton.Parent = controlButtons

    local closeButton = make("TextButton", {
        Size = UDim2.fromOffset(24, 24),
        BackgroundColor3 = currentTheme.CardBackground,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = 3
    }, {
        make("UICorner", { CornerRadius = UDim.new(0, 6) }),
        make("UIStroke", { Color = currentTheme.Border, Thickness = 1 }),
        make("ImageLabel", {
            Size = UDim2.fromOffset(12, 12),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Image = "rbxassetid://7734058863",
            ImageColor3 = currentTheme.Accent
        })
    })
    closeButton.Parent = controlButtons

    local notificationContainer = make("Frame", {
        Name = "NotificationContainer",
        Size = UDim2.new(0, 300, 1, 0),
        Position = UDim2.new(1, -310, 0, 0),
        BackgroundTransparency = 1,
        ZIndex = 10
    })
    notificationContainer.Parent = screenGui

    local notificationLayout = make("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        Padding = UDim.new(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    notificationLayout.Parent = notificationContainer

    local dialogOverlay = make("Frame", {
        Name = "DialogOverlay",
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 1,
        Visible = false,
        ZIndex = 20
    }, {
        make("UICorner", { CornerRadius = UDim.new(0, 12) })
    })
    dialogOverlay.Parent = mainFrame

    local sidebarCollapsed = false
    local toggleSidebarBtn = make("TextButton", {
        Name = "ToggleSidebarBtn",
        Size = UDim2.fromOffset(30, 30),
        Position = UDim2.new(0, 10, 0, 25),
        BackgroundColor3 = currentTheme.CardBackground,
        Text = "◀",
        TextColor3 = currentTheme.Text,
        Font = Fonts.Title,
        TextSize = 12,
        ZIndex = 5
    }, {
        make("UICorner", { CornerRadius = UDim.new(0, 6) }),
        make("UIStroke", { Color = currentTheme.Border, Thickness = 1 })
    })
    toggleSidebarBtn.Parent = sidebar

    local isMinimized = false
    local originalSize = size
    minimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            tween(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), {
                Size = UDim2.fromOffset(size.X.Offset, 60)
            })
            contentFrame.Visible = false
            searchContainer.Visible = false
            footer.Visible = false
            sidebar.Visible = false
        else
            tween(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), {
                Size = originalSize
            })
            contentFrame.Visible = true
            searchContainer.Visible = true
            footer.Visible = true
            sidebar.Visible = true
        end
    end)

    local isMaximized = false
    maximizeButton.MouseButton1Click:Connect(function()
        if isMinimized then return end
        isMaximized = not isMaximized
        if isMaximized then
            originalSize = mainFrame.Size
            tween(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), {
                Size = UDim2.fromScale(1, 1),
                Position = UDim2.fromScale(0.5, 0.5)
            })
        else
            tween(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), {
                Size = originalSize,
                Position = UDim2.fromScale(0.5, 0.5)
            })
        end
    end)

    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    toggleSidebarBtn.MouseButton1Click:Connect(function()
        sidebarCollapsed = not sidebarCollapsed
        if sidebarCollapsed then
            tween(sidebar, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), {
                Size = UDim2.new(0, 60, 1, 0)
            })
            tween(contentFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), {
                Size = UDim2.new(1, -80, 1, -100),
                Position = UDim2.new(0, 70, 0, 60)
            })
            tween(searchContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), {
                Size = UDim2.new(1, -80, 0, 40),
                Position = UDim2.new(0, 70, 0, 15)
            })
            tween(footer, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), {
                Size = UDim2.new(1, -80, 0, 30),
                Position = UDim2.new(0, 70, 1, -40)
            })
            profileContainer.Visible = false
            titleLabel.Visible = false
            subTitleLabel.Visible = false
            toggleSidebarBtn.Text = "▶"
            toggleSidebarBtn.Position = UDim2.new(0, 15, 0, 25)
        else
            tween(sidebar, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), {
                Size = UDim2.new(0, 240, 1, 0)
            })
            tween(contentFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), {
                Size = UDim2.new(1, -260, 1, -100),
                Position = UDim2.new(0, 250, 0, 60)
            })
            tween(searchContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), {
                Size = UDim2.new(1, -260, 0, 40),
                Position = UDim2.new(0, 250, 0, 15)
            })
            tween(footer, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), {
                Size = UDim2.new(1, -260, 0, 30),
                Position = UDim2.new(0, 250, 1, -40)
            })
            profileContainer.Visible = true
            titleLabel.Visible = true
            subTitleLabel.Visible = true
            toggleSidebarBtn.Text = "◀"
            toggleSidebarBtn.Position = UDim2.new(0, 10, 0, 25)
        end
    end)

    local dragToggle, dragStart, startPos
    mainFrame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not isMaximized then
            dragToggle = true
            dragStart = input.Position
            startPos = mainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)

    mainFrame.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            if dragToggle then
                local delta = input.Position - dragStart
                mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end
    end)

    local resizeHandle = make("Frame", {
        Name = "ResizeHandle",
        Size = UDim2.fromOffset(15, 15),
        Position = UDim2.new(1, -15, 1, -15),
        BackgroundTransparency = 1,
        ZIndex = 10,
        Active = true
    })
    resizeHandle.Parent = mainFrame

    local resizeToggle, resizeStart, startSize
    resizeHandle.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not isMaximized then
            resizeToggle = true
            resizeStart = input.Position
            startSize = mainFrame.Size
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    resizeToggle = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            if resizeToggle then
                local delta = input.Position - resizeStart
                local w = math.clamp(startSize.X.Offset + delta.X, 800, 1600)
                local h = math.clamp(startSize.Y.Offset + delta.Y, 500, 1000)
                mainFrame.Size = UDim2.fromOffset(w, h)
                if not isMinimized then
                    originalSize = mainFrame.Size
                end
            end
        end
    end)

    local windowObj = {
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        ContentFrame = contentFrame,
        SearchContainer = searchContainer,
        SearchBox = searchBox,
        DialogOverlay = dialogOverlay,
        Tabs = {},
        ActiveTab = nil,
        Flags = {},
        CurrentTheme = currentTheme,
        Notifications = notificationContainer,
        OpenDropdown = nil
    }

    UserInputService.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and windowObj.OpenDropdown then
            local openDrop = windowObj.OpenDropdown
            local frame = openDrop.Frame
            local pos = input.Position
            local absPos = frame.AbsolutePosition
            local absSize = frame.AbsoluteSize
            if pos.X < absPos.X or pos.X > absPos.X + absSize.X or pos.Y < absPos.Y or pos.Y > absPos.Y + absSize.Y then
                openDrop:Close()
            end
        end
    end)

    function windowObj:CreateNotification(opts)
        opts = opts or {}
        local nType = opts.Type or "Info"
        local nTitle = opts.Title or "Notification"
        local nDesc = opts.Description or ""
        local nDuration = opts.Duration or 5

        local accentColor = currentTheme.Accent
        if nType == "Success" then
            accentColor = Color3.fromRGB(45, 255, 125)
        elseif nType == "Warning" then
            accentColor = Color3.fromRGB(255, 170, 45)
        elseif nType == "Error" then
            accentColor = Color3.fromRGB(255, 45, 45)
        end

        local notifFrame = make("Frame", {
            Size = UDim2.new(1, 0, 0, 70),
            BackgroundColor3 = currentTheme.CardBackground,
            BorderSizePixel = 0,
            LayoutOrder = #notificationContainer:GetChildren()
        }, {
            make("UICorner", { CornerRadius = UDim.new(0, 8) }),
            make("UIStroke", { Color = currentTheme.Border, Thickness = 1 }),
            make("Frame", {
                Size = UDim2.new(0, 4, 1, 0),
                BackgroundColor3 = accentColor,
                BorderSizePixel = 0
            }, {
                make("UICorner", { CornerRadius = UDim.new(0, 4) })
            }),
            make("TextLabel", {
                Text = nTitle,
                Font = Fonts.Title,
                TextSize = 13,
                TextColor3 = currentTheme.Text,
                Position = UDim2.new(0, 15, 0, 10),
                Size = UDim2.new(1, -25, 0, 20),
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1
            }),
            make("TextLabel", {
                Text = nDesc,
                Font = Fonts.Body,
                TextSize = 11,
                TextColor3 = currentTheme.SubText,
                Position = UDim2.new(0, 15, 0, 30),
                Size = UDim2.new(1, -25, 0, 30),
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextWrapped = true,
                BackgroundTransparency = 1
            })
        })
        notifFrame.Parent = notificationContainer

        notifFrame.Position = UDim2.new(1, 50, 0, 0)
        tween(notifFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingStyle.Out), {
            Position = UDim2.new(0, 0, 0, 0)
        })

        task.delay(nDuration, function()
            local tw = tween(notifFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingStyle.In), {
                Position = UDim2.new(1, 50, 0, 0)
            })
            tw.Completed:Connect(function()
                notifFrame:Destroy()
            end)
        end)
    end

    function windowObj:CreateDialog(opts)
        opts = opts or {}
        local dType = opts.Type or "Confirm"
        local dTitle = opts.Title or "Are you sure?"
        local dDesc = opts.Description or "This action cannot be undone."
        local callback = opts.Callback or function() end

        dialogOverlay.Visible = true
        tween(dialogOverlay, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), {
            BackgroundTransparency = 0.5
        })

        local dialogCard = make("Frame", {
            Size = UDim2.fromOffset(360, 180),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = currentTheme.CardBackground,
            BorderSizePixel = 0,
            Parent = dialogOverlay
        }, {
            make("UICorner", { CornerRadius = UDim.new(0, 10) }),
            make("UIStroke", { Color = currentTheme.Border, Thickness = 1.5 }),
            make("TextLabel", {
                Text = dTitle,
                Font = Fonts.Title,
                TextSize = 16,
                TextColor3 = currentTheme.Text,
                Position = UDim2.new(0, 20, 0, 15),
                Size = UDim2.new(1, -40, 0, 24),
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1
            }),
            make("TextLabel", {
                Text = dDesc,
                Font = Fonts.Body,
                TextSize = 12,
                TextColor3 = currentTheme.SubText,
                Position = UDim2.new(0, 20, 0, 45),
                Size = UDim2.new(1, -40, 0, 50),
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextWrapped = true,
                BackgroundTransparency = 1
            })
        })

        local btnContainer = make("Frame", {
            Size = UDim2.new(1, -40, 0, 36),
            Position = UDim2.new(0, 20, 1, -50),
            BackgroundTransparency = 1
        })
        btnContainer.Parent = dialogCard

        local layout = make("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            Padding = UDim.new(0, 10)
        })
        layout.Parent = btnContainer

        local promptInput
        if dType == "Prompt" then
            dialogCard.Size = UDim2.fromOffset(360, 220)
            promptInput = make("TextBox", {
                Size = UDim2.new(1, -40, 0, 36),
                Position = UDim2.new(0, 20, 0, 100),
                BackgroundColor3 = currentTheme.Background,
                BorderSizePixel = 0,
                Font = Fonts.Body,
                TextSize = 13,
                TextColor3 = currentTheme.Text,
                PlaceholderText = "Type input here...",
                PlaceholderColor3 = currentTheme.SubText,
                Text = ""
            }, {
                make("UICorner", { CornerRadius = UDim.new(0, 6) }),
                make("UIStroke", { Color = currentTheme.Border, Thickness = 1 })
            })
            promptInput.Parent = dialogCard
        end

        local function closeDialog()
            local tw = tween(dialogOverlay, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingStyle.In), {
                BackgroundTransparency = 1
            })
            tw.Completed:Connect(function()
                dialogOverlay.Visible = false
                dialogCard:Destroy()
            end)
        end

        local cancelBtn = make("TextButton", {
            Size = UDim2.fromOffset(90, 36),
            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
            Text = "Cancel",
            Font = Fonts.ComponentLabel,
            TextColor3 = currentTheme.Text,
            TextSize = 12,
            AutoButtonColor = false
        }, {
            make("UICorner", { CornerRadius = UDim.new(0, 6) }),
            make("UIStroke", { Color = currentTheme.Border, Thickness = 1 })
        })
        cancelBtn.Parent = btnContainer

        cancelBtn.MouseButton1Click:Connect(function()
            closeDialog()
            callback(nil)
        end)

        local confirmBtn = make("TextButton", {
            Size = UDim2.fromOffset(90, 36),
            BackgroundColor3 = currentTheme.Accent,
            Text = "Confirm",
            Font = Fonts.ComponentLabel,
            TextColor3 = currentTheme.Text,
            TextSize = 12,
            AutoButtonColor = false
        }, {
            make("UICorner", { CornerRadius = UDim.new(0, 6) }),
            make("UIStroke", { Color = currentTheme.Border, Thickness = 1 })
        })
        confirmBtn.Parent = btnContainer

        confirmBtn.MouseButton1Click:Connect(function()
            closeDialog()
            if dType == "Prompt" then
                callback(promptInput.Text)
            else
                callback(true)
            end
        end)
    end

    function windowObj:CreateTab(name, iconName)
        local tabBtn = make("TextButton", {
            Size = UDim2.new(1, 0, 0, 40),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Text = "",
            AutoButtonColor = false
        }, {
            make("UICorner", { CornerRadius = UDim.new(0, 6) })
        })
        tabBtn.Parent = tabsScroller

        local iconId = "rbxassetid://7733960981"
        iconName = iconName and iconName:lower() or ""
        if iconName == "home" then iconId = "rbxassetid://7733960981"
        elseif iconName == "code" or iconName == "scripts" or iconName == "main" then iconId = "rbxassetid://7733934747"
        elseif iconName == "game" or iconName == "games" then iconId = "rbxassetid://7733965118"
        elseif iconName == "rocket" or iconName == "exploits" or iconName == "advanced" then iconId = "rbxassetid://7734053426"
        elseif iconName == "user" or iconName == "player" then iconId = "rbxassetid://7734068321"
        elseif iconName == "eye" or iconName == "visuals" or iconName == "overlays" then iconId = "rbxassetid://7743875962"
        elseif iconName == "grid" or iconName == "misc" or iconName == "pickers" then iconId = "rbxassetid://7733966124"
        elseif iconName == "settings" then iconId = "rbxassetid://7734056608"
        elseif iconName == "crown" or iconName == "premium" then iconId = "rbxassetid://7733942286"
        elseif iconName == "combat" then iconId = "rbxassetid://7734057860"
        elseif iconName == "target" then iconId = "rbxassetid://7743878857"
        elseif iconName == "teleport" or iconName == "map" then iconId = "rbxassetid://7743869054"
        end

        local tabIcon = make("ImageLabel", {
            Size = UDim2.fromOffset(18, 18),
            Position = UDim2.new(0, 12, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            Image = iconId,
            ImageColor3 = currentTheme.SubText
        })
        tabIcon.Parent = tabBtn

        local tabLabel = make("TextLabel", {
            Text = name,
            Font = Fonts.ComponentLabel,
            TextSize = 13,
            TextColor3 = currentTheme.SubText,
            Position = UDim2.new(0, 42, 0, 0),
            Size = UDim2.new(1, -50, 1, 0),
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1
        })
        tabLabel.Parent = tabBtn

        local activeIndicator = make("Frame", {
            Name = "ActiveIndicator",
            Size = UDim2.new(0, 3, 0.6, 0),
            Position = UDim2.new(0, 2, 0.2, 0),
            BackgroundColor3 = currentTheme.Accent,
            BorderSizePixel = 0,
            Visible = false
        }, {
            make("UICorner", { CornerRadius = UDim.new(0, 2) })
        })
        activeIndicator.Parent = tabBtn

        local tabScroll = make("ScrollingFrame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 2,
            ScrollBarImageColor3 = currentTheme.Accent,
            Visible = false,
            CanvasSize = UDim2.new(0, 0, 0, 0)
        })
        tabScroll.Parent = contentFrame

        local tabLayout = make("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 15)
        })
        tabLayout.Parent = tabScroll

        local tabPadding = make("UIPadding", {
            PaddingTop = UDim.new(0, 5),
            PaddingBottom = UDim.new(0, 15),
            PaddingLeft = UDim.new(0, 5),
            PaddingRight = UDim.new(0, 10)
        })
        tabPadding.Parent = tabScroll

        local function resizeTabLayout()
            tabScroll.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y + 30)
        end
        tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resizeTabLayout)

        local tabObj = {
            Button = tabBtn,
            Icon = tabIcon,
            Label = tabLabel,
            Scroll = tabScroll,
            Active = false,
            Sections = {}
        }

        tabBtn.MouseEnter:Connect(function()
            if not tabObj.Active then
                tween(tabBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), { BackgroundTransparency = 0.9, BackgroundColor3 = currentTheme.Hover })
                tween(tabLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), { TextColor3 = currentTheme.Text })
                tween(tabIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), { ImageColor3 = currentTheme.Text })
            end
        end)

        tabBtn.MouseLeave:Connect(function()
            if not tabObj.Active then
                tween(tabBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), { BackgroundTransparency = 1 })
                tween(tabLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), { TextColor3 = currentTheme.SubText })
                tween(tabIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), { ImageColor3 = currentTheme.SubText })
            end
        end)

        function tabObj:Select()
            if windowObj.ActiveTab then
                local prev = windowObj.ActiveTab
                prev.Active = false
                prev.Scroll.Visible = false
                prev.Button.BackgroundTransparency = 1
                prev.Label.TextColor3 = currentTheme.SubText
                prev.Icon.ImageColor3 = currentTheme.SubText
                local prevIndicator = prev.Button:FindFirstChild("ActiveIndicator")
                if prevIndicator then prevIndicator.Visible = false end
            end
            tabObj.Active = true
            windowObj.ActiveTab = tabObj
            tabScroll.Visible = true
            tabBtn.BackgroundColor3 = currentTheme.CardBackground
            tabBtn.BackgroundTransparency = 0.2
            tabLabel.TextColor3 = currentTheme.Text
            tabIcon.ImageColor3 = currentTheme.Accent
            activeIndicator.Visible = true
        end

        tabBtn.MouseButton1Click:Connect(function()
            tabObj:Select()
        end)

        if not windowObj.ActiveTab then
            tabObj:Select()
        end

        function tabObj:CreateSection(secName, secDesc)
            local sectionFrame = make("Frame", {
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundColor3 = currentTheme.CardBackground,
                BackgroundTransparency = 0.4,
                BorderSizePixel = 0
            }, {
                make("UICorner", { CornerRadius = UDim.new(0, 10) }),
                make("UIStroke", { Color = currentTheme.Border, Thickness = 1 })
            })
            sectionFrame.Parent = tabScroll

            local sectionLayout = make("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 10)
            })
            sectionLayout.Parent = sectionFrame

            local sectionPadding = make("UIPadding", {
                PaddingTop = UDim.new(0, 12),
                PaddingBottom = UDim.new(0, 12),
                PaddingLeft = UDim.new(0, 15),
                PaddingRight = UDim.new(0, 15)
            })
            sectionPadding.Parent = sectionFrame

            local sectionHeader = make("Frame", {
                Size = UDim2.new(1, 0, 0, secDesc and 40 or 20),
                BackgroundTransparency = 1,
                LayoutOrder = 0
            })
            sectionHeader.Parent = sectionFrame

            local sectionTitle = make("TextLabel", {
                Text = secName,
                Font = Fonts.SectionHeader,
                TextSize = 14,
                TextColor3 = currentTheme.Accent,
                Size = UDim2.new(1, 0, 0, 20),
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1
            })
            sectionTitle.Parent = sectionHeader

            if secDesc then
                local sectionDescription = make("TextLabel", {
                    Text = secDesc,
                    Font = Fonts.Body,
                    TextSize = 11,
                    TextColor3 = currentTheme.SubText,
                    Position = UDim2.new(0, 0, 0, 20),
                    Size = UDim2.new(1, 0, 0, 20),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1
                })
                sectionDescription.Parent = sectionHeader
            end

            local function resizeSection()
                local totalHeight = sectionLayout.AbsoluteContentSize.Y + 24
                sectionFrame.Size = UDim2.new(1, 0, 0, totalHeight)
            end
            sectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resizeSection)

            local sectionObj = {
                Frame = sectionFrame,
                Components = {}
            }

            function sectionObj:CreateButton(btnOpts)
                btnOpts = btnOpts or {}
                local bName = btnOpts.Name or "Button"
                local bCallback = btnOpts.Callback or function() end

                local btnFrame = make("TextButton", {
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundColor3 = Color3.fromRGB(15, 15, 15),
                    Text = "",
                    AutoButtonColor = false,
                    LayoutOrder = #sectionFrame:GetChildren()
                }, {
                    make("UICorner", { CornerRadius = UDim.new(0, 6) }),
                    make("UIStroke", { Color = currentTheme.Border, Thickness = 1 }),
                    make("TextLabel", {
                        Text = bName,
                        Font = Fonts.ComponentLabel,
                        TextSize = 13,
                        TextColor3 = currentTheme.Text,
                        Position = UDim2.new(0, 15, 0, 0),
                        Size = UDim2.new(1, -30, 1, 0),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1
                    })
                })
                btnFrame.Parent = sectionFrame

                local rippleContainer = make("Frame", {
                    Size = UDim2.fromScale(1, 1),
                    BackgroundTransparency = 1,
                    ClipsDescendants = true,
                    Parent = btnFrame
                }, {
                    make("UICorner", { CornerRadius = UDim.new(0, 6) })
                })

                btnFrame.MouseEnter:Connect(function()
                    tween(btnFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), { BackgroundColor3 = Color3.fromRGB(22, 22, 22) })
                end)

                btnFrame.MouseLeave:Connect(function()
                    tween(btnFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), { BackgroundColor3 = Color3.fromRGB(15, 15, 15) })
                end)

                btnFrame.MouseButton1Click:Connect(function()
                    local mouse = LocalPlayer:GetMouse()
                    local absolutePosition = btnFrame.AbsolutePosition
                    local mouseX = mouse.X - absolutePosition.X
                    local mouseY = mouse.Y - absolutePosition.Y

                    local circle = make("Frame", {
                        Size = UDim2.fromOffset(0, 0),
                        Position = UDim2.fromOffset(mouseX, mouseY),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundColor3 = currentTheme.Accent,
                        BackgroundTransparency = 0.6,
                        BorderSizePixel = 0,
                        Parent = rippleContainer
                    }, {
                        make("UICorner", { CornerRadius = UDim.new(1, 0) })
                    })

                    tween(circle, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), {
                        Size = UDim2.fromOffset(btnFrame.AbsoluteSize.X * 2, btnFrame.AbsoluteSize.X * 2),
                        BackgroundTransparency = 1
                    }).Completed:Connect(function()
                        circle:Destroy()
                    end)

                    bCallback()
                end)

                local comp = { Frame = btnFrame, Type = "Button", Name = bName }
                table.insert(sectionObj.Components, comp)
                return comp
            end

            function sectionObj:CreateToggle(togOpts)
                togOpts = togOpts or {}
                local tName = togOpts.Name or "Toggle"
                local tDefault = togOpts.Default or false
                local tCallback = togOpts.Callback or function() end
                local tFlag = togOpts.Flag

                local toggled = tDefault

                local togFrame = make("TextButton", {
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundColor3 = Color3.fromRGB(15, 15, 15),
                    Text = "",
                    AutoButtonColor = false,
                    LayoutOrder = #sectionFrame:GetChildren()
                }, {
                    make("UICorner", { CornerRadius = UDim.new(0, 6) }),
                    make("UIStroke", { Color = currentTheme.Border, Thickness = 1 }),
                    make("TextLabel", {
                        Text = tName,
                        Font = Fonts.ComponentLabel,
                        TextSize = 13,
                        TextColor3 = currentTheme.Text,
                        Position = UDim2.new(0, 15, 0, 0),
                        Size = UDim2.new(1, -70, 1, 0),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1
                    })
                })
                togFrame.Parent = sectionFrame

                local switch = make("Frame", {
                    Size = UDim2.fromOffset(36, 20),
                    Position = UDim2.new(1, -50, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = toggled and currentTheme.Accent or Color3.fromRGB(40, 40, 40),
                    BorderSizePixel = 0
                }, {
                    make("UICorner", { CornerRadius = UDim.new(1, 0) })
                })
                switch.Parent = togFrame

                local circle = make("Frame", {
                    Size = UDim2.fromOffset(14, 14),
                    Position = UDim2.new(0, toggled and 19 or 3, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                    BorderSizePixel = 0
                }, {
                    make("UICorner", { CornerRadius = UDim.new(1, 0) })
                })
                circle.Parent = switch

                local function updateToggle(state)
                    toggled = state
                    tween(switch, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), {
                        BackgroundColor3 = toggled and currentTheme.Accent or Color3.fromRGB(40, 40, 40)
                    })
                    tween(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), {
                        Position = UDim2.new(0, toggled and 19 or 3, 0.5, 0)
                    })
                    tCallback(toggled)
                end

                togFrame.MouseButton1Click:Connect(function()
                    updateToggle(not toggled)
                end)

                local comp = {
                    Frame = togFrame,
                    Type = "Toggle",
                    Name = tName,
                    GetValue = function() return toggled end,
                    SetValue = function(self, val) updateToggle(val) end
                }

                if tFlag then
                    windowObj.Flags[tFlag] = comp
                end

                table.insert(sectionObj.Components, comp)
                return comp
            end

            function sectionObj:CreateSlider(slidOpts)
                slidOpts = slidOpts or {}
                local sName = slidOpts.Name or "Slider"
                local sMin = slidOpts.Min or 0
                local sMax = slidOpts.Max or 100
                local sDefault = slidOpts.Default or 50
                local sCallback = slidOpts.Callback or function() end
                local sFlag = slidOpts.Flag

                local value = sDefault

                local slidFrame = make("Frame", {
                    Size = UDim2.new(1, 0, 0, 55),
                    BackgroundColor3 = Color3.fromRGB(15, 15, 15),
                    LayoutOrder = #sectionFrame:GetChildren()
                }, {
                    make("UICorner", { CornerRadius = UDim.new(0, 6) }),
                    make("UIStroke", { Color = currentTheme.Border, Thickness = 1 }),
                    make("TextLabel", {
                        Text = sName,
                        Font = Fonts.ComponentLabel,
                        TextSize = 13,
                        TextColor3 = currentTheme.Text,
                        Position = UDim2.new(0, 15, 0, 10),
                        Size = UDim2.new(0.5, 0, 0, 20),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1
                    })
                })
                slidFrame.Parent = sectionFrame

                local track = make("Frame", {
                    Size = UDim2.new(1, -110, 0, 6),
                    Position = UDim2.new(0, 15, 0, 38),
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                    BorderSizePixel = 0
                }, {
                    make("UICorner", { CornerRadius = UDim.new(1, 0) })
                })
                track.Parent = slidFrame

                local fill = make("Frame", {
                    Size = UDim2.fromScale((sDefault - sMin) / (sMax - sMin), 1),
                    BackgroundColor3 = currentTheme.Accent,
                    BorderSizePixel = 0
                }, {
                    make("UICorner", { CornerRadius = UDim.new(1, 0) })
                })
                fill.Parent = track

                local valInput = make("TextBox", {
                    Size = UDim2.fromOffset(60, 22),
                    Position = UDim2.new(1, -75, 0, 10),
                    BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                    BorderSizePixel = 0,
                    Font = Fonts.Value,
                    TextSize = 12,
                    TextColor3 = currentTheme.Text,
                    Text = tostring(sDefault),
                    ClearTextOnFocus = false
                }, {
                    make("UICorner", { CornerRadius = UDim.new(0, 4) }),
                    make("UIStroke", { Color = currentTheme.Border, Thickness = 1 })
                })
                valInput.Parent = slidFrame

                local function updateSlider(newVal, dragInput)
                    newVal = math.clamp(newVal, sMin, sMax)
                    value = newVal
                    valInput.Text = tostring(math.floor(newVal))
                    local scale = (newVal - sMin) / (sMax - sMin)
                    if dragInput then
                        fill.Size = UDim2.fromScale(scale, 1)
                    else
                        tween(fill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), { Size = UDim2.fromScale(scale, 1) })
                    end
                    sCallback(value)
                end

                local isDragging = false
                track.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        isDragging = true
                        local percent = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteWidth, 0, 1)
                        updateSlider(sMin + percent * (sMax - sMin), true)
                    end
                end)

                UserInputService.InputChanged:Connect(function(input)
                    if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        local percent = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteWidth, 0, 1)
                        updateSlider(sMin + percent * (sMax - sMin), true)
                    end
                end)

                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        isDragging = false
                    end
                end)

                valInput.FocusLost:Connect(function()
                    local num = tonumber(valInput.Text)
                    if num then
                        updateSlider(num, false)
                    else
                        valInput.Text = tostring(value)
                    end
                end)

                local comp = {
                    Frame = slidFrame,
                    Type = "Slider",
                    Name = sName,
                    GetValue = function() return value end,
                    SetValue = function(self, val) updateSlider(val, false) end
                }

                if sFlag then
                    windowObj.Flags[sFlag] = comp
                end

                table.insert(sectionObj.Components, comp)
                return comp
            end

            function sectionObj:CreateDropdown(dropOpts)
                dropOpts = dropOpts or {}
                local dName = dropOpts.Name or "Dropdown"
                local dOptions = dropOpts.Options or {}
                local dMulti = dropOpts.MultiSelect or false
                local dCallback = dropOpts.Callback or function() end
                local dFlag = dropOpts.Flag

                local currentSelection = dMulti and {} or dOptions[1] or ""
                local isExpanded = false

                local dropFrame = make("Frame", {
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundColor3 = Color3.fromRGB(15, 15, 15),
                    ClipsDescendants = true,
                    LayoutOrder = #sectionFrame:GetChildren()
                }, {
                    make("UICorner", { CornerRadius = UDim.new(0, 6) }),
                    make("UIStroke", { Color = currentTheme.Border, Thickness = 1 })
                })
                dropFrame.Parent = sectionFrame

                local triggerBtn = make("TextButton", {
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundTransparency = 1,
                    Text = "",
                    AutoButtonColor = false
                })
                triggerBtn.Parent = dropFrame

                local labelText = make("TextLabel", {
                    Text = dName,
                    Font = Fonts.ComponentLabel,
                    TextSize = 13,
                    TextColor3 = currentTheme.Text,
                    Position = UDim2.new(0, 15, 0, 0),
                    Size = UDim2.new(0.5, 0, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1
                })
                labelText.Parent = triggerBtn

                local selectionText = make("TextLabel", {
                    Text = dMulti and "Select Option" or tostring(currentSelection),
                    Font = Fonts.ComponentLabel,
                    TextSize = 12,
                    TextColor3 = currentTheme.SubText,
                    Position = UDim2.new(0.5, 0, 0, 0),
                    Size = UDim2.new(0.5, -40, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Right,
                    BackgroundTransparency = 1
                })
                selectionText.Parent = triggerBtn

                local arrow = make("ImageLabel", {
                    Size = UDim2.fromOffset(16, 16),
                    Position = UDim2.new(1, -30, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundTransparency = 1,
                    Image = "rbxassetid://7734056411",
                    ImageColor3 = currentTheme.SubText
                })
                arrow.Parent = triggerBtn

                local dropContainer = make("Frame", {
                    Size = UDim2.new(1, -20, 0, 155),
                    Position = UDim2.new(0, 10, 0, 40),
                    BackgroundTransparency = 1,
                    Visible = false
                })
                dropContainer.Parent = dropFrame

                local searchBar = make("TextBox", {
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                    BorderSizePixel = 0,
                    Font = Fonts.Body,
                    TextSize = 12,
                    TextColor3 = currentTheme.Text,
                    PlaceholderText = "Search options...",
                    PlaceholderColor3 = currentTheme.SubText,
                    Text = ""
                }, {
                    make("UICorner", { CornerRadius = UDim.new(0, 4) }),
                    make("UIStroke", { Color = currentTheme.Border, Thickness = 1 })
                })
                searchBar.Parent = dropContainer

                local optScroll = make("ScrollingFrame", {
                    Size = UDim2.new(1, 0, 0, 120),
                    Position = UDim2.new(0, 0, 0, 35),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    ScrollBarThickness = 2,
                    ScrollBarImageColor3 = currentTheme.Accent,
                    CanvasSize = UDim2.new(0, 0, 0, 0)
                })
                optScroll.Parent = dropContainer

                local optLayout = make("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 4)
                })
                optLayout.Parent = optScroll

                local dropObj = { Frame = dropFrame }

                local function closeDrop()
                    if not isExpanded then return end
                    isExpanded = false
                    if windowObj.OpenDropdown == dropObj then
                        windowObj.OpenDropdown = nil
                    end
                    tween(dropFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), { Size = UDim2.new(1, 0, 0, 40) })
                    tween(arrow, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), { Rotation = 0 })
                    task.delay(0.25, function()
                        if not isExpanded then dropContainer.Visible = false end
                    end)
                end

                local function openDrop()
                    if isExpanded then return end
                    if windowObj.OpenDropdown then
                        windowObj.OpenDropdown:Close()
                    end
                    isExpanded = true
                    windowObj.OpenDropdown = dropObj
                    dropContainer.Visible = true
                    tween(dropFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), { Size = UDim2.new(1, 0, 0, 205) })
                    tween(arrow, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), { Rotation = 180 })
                end

                dropObj.Close = closeDrop
                dropObj.Open = openDrop

                local function updateSelectionDisplay()
                    if dMulti then
                        local active = {}
                        for opt, val in pairs(currentSelection) do
                            if val then table.insert(active, opt) end
                        end
                        if #active > 0 then
                            selectionText.Text = table.concat(active, ", ")
                        else
                            selectionText.Text = "Select Option"
                        end
                    else
                        selectionText.Text = tostring(currentSelection)
                    end
                end

                local optionButtons = {}
                local function buildOptions()
                    for _, b in ipairs(optionButtons) do b:Destroy() end
                    optionButtons = {}

                    local query = searchBar.Text:lower()
                    for idx, option in ipairs(dOptions) do
                        if query == "" or option:lower():find(query) then
                            local isSelected = false
                            if dMulti then
                                isSelected = not not currentSelection[option]
                            else
                                isSelected = (currentSelection == option)
                            end

                            local optBtn = make("TextButton", {
                                Size = UDim2.new(1, 0, 0, 30),
                                BackgroundColor3 = isSelected and currentTheme.Accent or Color3.fromRGB(20, 20, 20),
                                BackgroundTransparency = isSelected and 0.4 or 0,
                                Text = "",
                                AutoButtonColor = false,
                                LayoutOrder = idx
                            }, {
                                make("UICorner", { CornerRadius = UDim.new(0, 4) }),
                                make("UIStroke", { Color = currentTheme.Border, Thickness = 1 }),
                                make("TextLabel", {
                                    Text = option,
                                    Font = Fonts.ComponentLabel,
                                    TextSize = 12,
                                    TextColor3 = currentTheme.Text,
                                    Position = UDim2.new(0, 10, 0, 0),
                                    Size = UDim2.new(1, -20, 1, 0),
                                    TextXAlignment = Enum.TextXAlignment.Left,
                                    BackgroundTransparency = 1
                                })
                            })
                            optBtn.Parent = optScroll
                            table.insert(optionButtons, optBtn)

                            optBtn.MouseButton1Click:Connect(function()
                                if dMulti then
                                    currentSelection[option] = not currentSelection[option]
                                    buildOptions()
                                    updateSelectionDisplay()
                                    dCallback(currentSelection)
                                else
                                    currentSelection = option
                                    closeDrop()
                                    buildOptions()
                                    updateSelectionDisplay()
                                    dCallback(currentSelection)
                                end
                            end)
                        end
                    end
                    optScroll.CanvasSize = UDim2.new(0, 0, 0, optLayout.AbsoluteContentSize.Y + 5)
                end

                buildOptions()

                searchBar:GetPropertyChangedSignal("Text"):Connect(buildOptions)

                triggerBtn.MouseButton1Click:Connect(function()
                    if isExpanded then
                        closeDrop()
                    else
                        openDrop()
                    end
                end)

                local comp = {
                    Frame = dropFrame,
                    Type = "Dropdown",
                    Name = dName,
                    GetValue = function() return currentSelection end,
                    SetValue = function(self, val)
                        currentSelection = val
                        buildOptions()
                        updateSelectionDisplay()
                        dCallback(currentSelection)
                    end,
                    Close = closeDrop,
                    Open = openDrop
                }

                if dFlag then
                    windowObj.Flags[dFlag] = comp
                end

                table.insert(sectionObj.Components, comp)
                return comp
            end

            function sectionObj:CreateTextbox(textOpts)
                textOpts = textOpts or {}
                local tName = textOpts.Name or "Textbox"
                local tPlace = textOpts.Placeholder or "Type something..."
                local tCallback = textOpts.Callback or function() end
                local tValidate = textOpts.Validate
                local tFlag = textOpts.Flag

                local txtFrame = make("Frame", {
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundColor3 = Color3.fromRGB(15, 15, 15),
                    LayoutOrder = #sectionFrame:GetChildren()
                }, {
                    make("UICorner", { CornerRadius = UDim.new(0, 6) }),
                    make("UIStroke", { Color = currentTheme.Border, Thickness = 1 }),
                    make("TextLabel", {
                        Text = tName,
                        Font = Fonts.ComponentLabel,
                        TextSize = 13,
                        TextColor3 = currentTheme.Text,
                        Position = UDim2.new(0, 15, 0, 0),
                        Size = UDim2.new(0.4, 0, 1, 0),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1
                    })
                })
                txtFrame.Parent = sectionFrame

                local inputVal = make("TextBox", {
                    Size = UDim2.new(0.5, 0, 0, 26),
                    Position = UDim2.new(1, -15, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                    BorderSizePixel = 0,
                    Font = Fonts.Body,
                    TextSize = 12,
                    TextColor3 = currentTheme.Text,
                    PlaceholderText = tPlace,
                    PlaceholderColor3 = currentTheme.SubText,
                    Text = "",
                    ClearTextOnFocus = false
                }, {
                    make("UICorner", { CornerRadius = UDim.new(0, 4) }),
                    make("UIStroke", { Color = currentTheme.Border, Thickness = 1 })
                })
                inputVal.Parent = txtFrame

                local function applyValue(text)
                    if tValidate then
                        local ok = tValidate(text)
                        if not ok then
                            inputVal.Text = ""
                            return
                        end
                    end
                    tCallback(text)
                end

                inputVal.FocusLost:Connect(function()
                    applyValue(inputVal.Text)
                end)

                local comp = {
                    Frame = txtFrame,
                    Type = "Textbox",
                    Name = tName,
                    GetValue = function() return inputVal.Text end,
                    SetValue = function(self, val)
                        inputVal.Text = tostring(val)
                        applyValue(tostring(val))
                    end
                }

                if tFlag then
                    windowObj.Flags[tFlag] = comp
                end

                table.insert(sectionObj.Components, comp)
                return comp
            end

            function sectionObj:CreateLabel(labelOpts)
                labelOpts = labelOpts or {}
                local text = labelOpts.Text or "Label Text"

                local lbl = make("TextLabel", {
                    Text = text,
                    Font = Fonts.ComponentLabel,
                    TextSize = 13,
                    TextColor3 = currentTheme.Text,
                    Size = UDim2.new(1, 0, 0, 20),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1,
                    LayoutOrder = #sectionFrame:GetChildren()
                })
                lbl.Parent = sectionFrame

                local comp = {
                    Frame = lbl,
                    Type = "Label",
                    Name = text,
                    SetText = function(self, newText)
                        lbl.Text = newText
                    end
                }
                table.insert(sectionObj.Components, comp)
                return comp
            end

            function sectionObj:CreateParagraph(paraOpts)
                paraOpts = paraOpts or {}
                local pTitle = paraOpts.Title or "Title"
                local pText = paraOpts.Text or "Paragraph text goes here."

                local titleLbl = make("TextLabel", {
                    Text = pTitle,
                    Font = Fonts.SectionHeader,
                    TextSize = 13,
                    TextColor3 = currentTheme.Accent,
                    Position = UDim2.new(0, 12, 0, 8),
                    Size = UDim2.new(1, -24, 0, 18),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1
                })

                local paraLabel = make("TextLabel", {
                    Text = pText,
                    Font = Fonts.Body,
                    TextSize = 11,
                    TextColor3 = currentTheme.SubText,
                    Position = UDim2.new(0, 12, 0, 26),
                    Size = UDim2.new(1, -24, 0, 28),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextWrapped = true,
                    BackgroundTransparency = 1
                })

                local container = make("Frame", {
                    Size = UDim2.new(1, 0, 0, 60),
                    BackgroundColor3 = Color3.fromRGB(15, 15, 15),
                    LayoutOrder = #sectionFrame:GetChildren()
                }, {
                    make("UICorner", { CornerRadius = UDim.new(0, 6) }),
                    make("UIStroke", { Color = currentTheme.Border, Thickness = 1 }),
                    titleLbl,
                    paraLabel
                })
                container.Parent = sectionFrame

                local comp = {
                    Frame = container,
                    Type = "Paragraph",
                    SetContent = function(self, newTitle, newText)
                        if newTitle then titleLbl.Text = newTitle end
                        if newText then paraLabel.Text = newText end
                    end
                }
                table.insert(sectionObj.Components, comp)
                return comp
            end

            function sectionObj:CreateColorPicker(colorOpts)
                colorOpts = colorOpts or {}
                local cpName = colorOpts.Name or "Color Picker"
                local cpDefault = colorOpts.Default or Color3.fromRGB(255, 0, 0)
                local cpCallback = colorOpts.Callback or function() end
                local cpFlag = colorOpts.Flag

                local colorVal = cpDefault
                local isEditing = false

                local cpFrame = make("Frame", {
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundColor3 = Color3.fromRGB(15, 15, 15),
                    ClipsDescendants = true,
                    LayoutOrder = #sectionFrame:GetChildren()
                }, {
                    make("UICorner", { CornerRadius = UDim.new(0, 6) }),
                    make("UIStroke", { Color = currentTheme.Border, Thickness = 1 }),
                    make("TextLabel", {
                        Text = cpName,
                        Font = Fonts.ComponentLabel,
                        TextSize = 13,
                        TextColor3 = currentTheme.Text,
                        Position = UDim2.new(0, 15, 0, 0),
                        Size = UDim2.new(0.5, 0, 1, 0),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1
                    })
                })
                cpFrame.Parent = sectionFrame

                local toggleBtn = make("TextButton", {
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundTransparency = 1,
                    Text = "",
                    AutoButtonColor = false
                })
                toggleBtn.Parent = cpFrame

                local previewColor = make("Frame", {
                    Size = UDim2.fromOffset(30, 20),
                    Position = UDim2.new(1, -45, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = colorVal,
                    BorderSizePixel = 0
                }, {
                    make("UICorner", { CornerRadius = UDim.new(0, 4) }),
                    make("UIStroke", { Color = currentTheme.Border, Thickness = 1 })
                })
                previewColor.Parent = toggleBtn

                local pickerContainer = make("Frame", {
                    Size = UDim2.new(1, -20, 0, 110),
                    Position = UDim2.new(0, 10, 0, 40),
                    BackgroundTransparency = 1,
                    Visible = false
                })
                pickerContainer.Parent = cpFrame

                local canvas = make("Frame", {
                    Size = UDim2.new(0.7, -10, 1, 0),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    BorderSizePixel = 0
                }, {
                    make("UICorner", { CornerRadius = UDim.new(0, 4) }),
                    make("UIGradient", {
                        Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                            ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
                        })
                    })
                })
                canvas.Parent = pickerContainer

                local hueSlider = make("Frame", {
                    Size = UDim2.new(0.3, 0, 0, 12),
                    Position = UDim2.new(0.7, 0, 0, 5),
                    BorderSizePixel = 0
                }, {
                    make("UICorner", { CornerRadius = UDim.new(0, 4) }),
                    make("UIGradient", {
                        Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                            ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
                            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                            ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
                            ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                        })
                    })
                })
                hueSlider.Parent = pickerContainer

                local rgbInput = make("TextBox", {
                    Size = UDim2.new(0.3, 0, 0, 24),
                    Position = UDim2.new(0.7, 0, 0, 30),
                    BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                    BorderSizePixel = 0,
                    Font = Fonts.Value,
                    TextSize = 11,
                    TextColor3 = currentTheme.Text,
                    Text = "255,0,0",
                    ClearTextOnFocus = false
                }, {
                    make("UICorner", { CornerRadius = UDim.new(0, 4) }),
                    make("UIStroke", { Color = currentTheme.Border, Thickness = 1 })
                })
                rgbInput.Parent = pickerContainer

                local function applyColor(col)
                    colorVal = col
                    previewColor.BackgroundColor3 = col
                    rgbInput.Text = math.floor(col.R * 255) .. "," .. math.floor(col.G * 255) .. "," .. math.floor(col.B * 255)
                    cpCallback(colorVal)
                end

                toggleBtn.MouseButton1Click:Connect(function()
                    isEditing = not isEditing
                    if isEditing then
                        pickerContainer.Visible = true
                        tween(cpFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), { Size = UDim2.new(1, 0, 0, 160) })
                    else
                        tween(cpFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), { Size = UDim2.new(1, 0, 0, 40) })
                        task.delay(0.2, function()
                            if not isEditing then pickerContainer.Visible = false end
                        end)
                    end
                end)

                local dragHue = false
                hueSlider.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragHue = true
                        local percent = math.clamp((input.Position.X - hueSlider.AbsolutePosition.X) / hueSlider.AbsoluteWidth, 0, 1)
                        local hCol = Color3.fromHSV(percent, 1, 1)
                        applyColor(hCol)
                    end
                end)

                UserInputService.InputChanged:Connect(function(input)
                    if dragHue and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        local percent = math.clamp((input.Position.X - hueSlider.AbsolutePosition.X) / hueSlider.AbsoluteWidth, 0, 1)
                        local hCol = Color3.fromHSV(percent, 1, 1)
                        applyColor(hCol)
                    end
                end)

                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragHue = false
                    end
                end)

                rgbInput.FocusLost:Connect(function()
                    local r, g, b = rgbInput.Text:match("(%d+),(%d+),(%d+)")
                    if r and g and b then
                        applyColor(Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)))
                    else
                        rgbInput.Text = math.floor(colorVal.R * 255) .. "," .. math.floor(colorVal.G * 255) .. "," .. math.floor(colorVal.B * 255)
                    end
                end)

                local comp = {
                    Frame = cpFrame,
                    Type = "ColorPicker",
                    Name = cpName,
                    GetValue = function() return colorVal end,
                    SetValue = function(self, val)
                        applyColor(val)
                    end
                }

                if cpFlag then
                    windowObj.Flags[cpFlag] = comp
                end

                table.insert(sectionObj.Components, comp)
                return comp
            end

            function sectionObj:CreateKeybind(keyOpts)
                keyOpts = keyOpts or {}
                local kName = keyOpts.Name or "Keybind"
                local kDefault = keyOpts.Default or Enum.KeyCode.F
                local kCallback = keyOpts.Callback or function() end
                local kFlag = keyOpts.Flag

                local currentKey = kDefault
                local isListening = false

                local kbFrame = make("Frame", {
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundColor3 = Color3.fromRGB(15, 15, 15),
                    LayoutOrder = #sectionFrame:GetChildren()
                }, {
                    make("UICorner", { CornerRadius = UDim.new(0, 6) }),
                    make("UIStroke", { Color = currentTheme.Border, Thickness = 1 }),
                    make("TextLabel", {
                        Text = kName,
                        Font = Fonts.ComponentLabel,
                        TextSize = 13,
                        TextColor3 = currentTheme.Text,
                        Position = UDim2.new(0, 15, 0, 0),
                        Size = UDim2.new(0.5, 0, 1, 0),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1
                    })
                })
                kbFrame.Parent = sectionFrame

                local keyLabel = make("TextButton", {
                    Size = UDim2.fromOffset(80, 24),
                    Position = UDim2.new(1, -95, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                    Text = currentKey and currentKey.Name or "None",
                    Font = Fonts.Value,
                    TextSize = 11,
                    TextColor3 = currentTheme.Text,
                    AutoButtonColor = false
                }, {
                    make("UICorner", { CornerRadius = UDim.new(0, 4) }),
                    make("UIStroke", { Color = currentTheme.Border, Thickness = 1 })
                })
                keyLabel.Parent = kbFrame

                keyLabel.MouseButton1Click:Connect(function()
                    isListening = true
                    keyLabel.Text = "..."
                end)

                UserInputService.InputBegan:Connect(function(input)
                    if isListening then
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            currentKey = input.KeyCode
                            isListening = false
                            keyLabel.Text = currentKey.Name
                            kCallback(currentKey)
                        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                            currentKey = Enum.UserInputType.MouseButton1
                            isListening = false
                            keyLabel.Text = "LClick"
                            kCallback(currentKey)
                        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                            currentKey = Enum.UserInputType.MouseButton2
                            isListening = false
                            keyLabel.Text = "RClick"
                            kCallback(currentKey)
                        end
                    else
                        if currentKey and input.KeyCode == currentKey then
                            kCallback(currentKey)
                        end
                    end
                end)

                local comp = {
                    Frame = kbFrame,
                    Type = "Keybind",
                    Name = kName,
                    GetValue = function() return currentKey end,
                    SetValue = function(self, val)
                        currentKey = val
                        keyLabel.Text = currentKey and currentKey.Name or "None"
                        kCallback(currentKey)
                    end
                }

                if kFlag then
                    windowObj.Flags[kFlag] = comp
                end

                table.insert(sectionObj.Components, comp)
                return comp
            end

            function sectionObj:CreateProgressBar(barOpts)
                barOpts = barOpts or {}
                local pbName = barOpts.Name or "Progress Bar"
                local pbPercent = barOpts.Percent or 0

                local progress = pbPercent

                local pbFrame = make("Frame", {
                    Size = UDim2.new(1, 0, 0, 50),
                    BackgroundColor3 = Color3.fromRGB(15, 15, 15),
                    LayoutOrder = #sectionFrame:GetChildren()
                }, {
                    make("UICorner", { CornerRadius = UDim.new(0, 6) }),
                    make("UIStroke", { Color = currentTheme.Border, Thickness = 1 }),
                    make("TextLabel", {
                        Text = pbName,
                        Font = Fonts.ComponentLabel,
                        TextSize = 12,
                        TextColor3 = currentTheme.Text,
                        Position = UDim2.new(0, 15, 0, 6),
                        Size = UDim2.new(0.5, 0, 0, 18),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1
                    })
                })
                pbFrame.Parent = sectionFrame

                local track = make("Frame", {
                    Size = UDim2.new(1, -30, 0, 8),
                    Position = UDim2.new(0, 15, 0, 30),
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                    BorderSizePixel = 0
                }, {
                    make("UICorner", { CornerRadius = UDim.new(1, 0) })
                })
                track.Parent = pbFrame

                local fill = make("Frame", {
                    Size = UDim2.fromScale(pbPercent / 100, 1),
                    BackgroundColor3 = currentTheme.Accent,
                    BorderSizePixel = 0
                }, {
                    make("UICorner", { CornerRadius = UDim.new(1, 0) })
                })
                fill.Parent = track

                local pctText = make("TextLabel", {
                    Text = tostring(math.floor(pbPercent)) .. "%",
                    Font = Fonts.Value,
                    TextSize = 12,
                    TextColor3 = currentTheme.Accent,
                    Position = UDim2.new(1, -75, 0, 6),
                    Size = UDim2.fromOffset(60, 18),
                    TextXAlignment = Enum.TextXAlignment.Right,
                    BackgroundTransparency = 1
                })
                pctText.Parent = pbFrame

                local function setProgress(val)
                    val = math.clamp(val, 0, 100)
                    progress = val
                    pctText.Text = tostring(math.floor(val)) .. "%"
                    tween(fill, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingStyle.Out), {
                        Size = UDim2.fromScale(val / 100, 1)
                    })
                end

                local comp = {
                    Frame = pbFrame,
                    Type = "ProgressBar",
                    Name = pbName,
                    SetPercent = function(self, val)
                        setProgress(val)
                    end
                }
                table.insert(sectionObj.Components, comp)
                return comp
            end

            function sectionObj:CreateCard(cardOpts)
                cardOpts = cardOpts or {}
                local cTitle = cardOpts.Title or "Card Title"
                local cDesc = cardOpts.Description or "Card description goes here."

                local container = make("Frame", {
                    Size = UDim2.new(1, 0, 0, 75),
                    BackgroundColor3 = currentTheme.CardBackground,
                    BorderSizePixel = 0,
                    LayoutOrder = #sectionFrame:GetChildren()
                }, {
                    make("UICorner", { CornerRadius = UDim.new(0, 8) }),
                    make("UIStroke", { Color = currentTheme.Border, Thickness = 1 }),
                    make("TextLabel", {
                        Text = cTitle,
                        Font = Fonts.SectionHeader,
                        TextSize = 14,
                        TextColor3 = currentTheme.Accent,
                        Position = UDim2.new(0, 15, 0, 12),
                        Size = UDim2.new(1, -30, 0, 20),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1
                    }),
                    make("TextLabel", {
                        Text = cDesc,
                        Font = Fonts.Body,
                        TextSize = 12,
                        TextColor3 = currentTheme.SubText,
                        Position = UDim2.new(0, 15, 0, 32),
                        Size = UDim2.new(1, -30, 0, 35),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        TextWrapped = true,
                        BackgroundTransparency = 1
                    })
                })
                container.Parent = sectionFrame

                local comp = {
                    Frame = container,
                    Type = "Card",
                    Name = cTitle
                }
                table.insert(sectionObj.Components, comp)
                return comp
            end

            table.insert(tabObj.Sections, sectionObj)
            return sectionObj
        end

        table.insert(windowObj.Tabs, tabObj)
        return tabObj
    end

    function windowObj:CreateStatsWidget()
        local statsContainer = make("Frame", {
            Name = "StatsContainer",
            Size = UDim2.fromOffset(250, 45),
            Position = UDim2.new(1, -265, 1, -45),
            BackgroundTransparency = 1,
            ZIndex = 5
        })
        statsContainer.Parent = mainFrame

        local statsLayout = make("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            Padding = UDim.new(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder
        })
        statsLayout.Parent = statsContainer

        local fpsCard = make("Frame", {
            Size = UDim2.fromOffset(70, 30),
            BackgroundColor3 = currentTheme.CardBackground,
            BorderSizePixel = 0,
            LayoutOrder = 1
        }, {
            make("UICorner", { CornerRadius = UDim.new(0, 6) }),
            make("UIStroke", { Color = currentTheme.Border, Thickness = 1 })
        })
        fpsCard.Parent = statsContainer

        local fpsText = make("TextLabel", {
            Text = "FPS: 60",
            Font = Fonts.Value,
            TextSize = 10,
            TextColor3 = currentTheme.Text,
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1
        })
        fpsText.Parent = fpsCard

        local pingCard = make("Frame", {
            Size = UDim2.fromOffset(70, 30),
            BackgroundColor3 = currentTheme.CardBackground,
            BorderSizePixel = 0,
            LayoutOrder = 2
        }, {
            make("UICorner", { CornerRadius = UDim.new(0, 6) }),
            make("UIStroke", { Color = currentTheme.Border, Thickness = 1 })
        })
        pingCard.Parent = statsContainer

        local pingText = make("TextLabel", {
            Text = "Ping: --",
            Font = Fonts.Value,
            TextSize = 10,
            TextColor3 = currentTheme.Text,
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1
        })
        pingText.Parent = pingCard

        local runtimeCard = make("Frame", {
            Size = UDim2.fromOffset(90, 30),
            BackgroundColor3 = currentTheme.CardBackground,
            BorderSizePixel = 0,
            LayoutOrder = 3
        }, {
            make("UICorner", { CornerRadius = UDim.new(0, 6) }),
            make("UIStroke", { Color = currentTheme.Border, Thickness = 1 })
        })
        runtimeCard.Parent = statsContainer

        local runtimeText = make("TextLabel", {
            Text = "00:00:00",
            Font = Fonts.Value,
            TextSize = 10,
            TextColor3 = currentTheme.Text,
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1
        })
        runtimeText.Parent = runtimeCard

        local frameCount = 0
        local lastTime = os.clock()
        RunService.RenderStepped:Connect(function()
            frameCount = frameCount + 1
            local now = os.clock()
            if now - lastTime >= 1 then
                fpsText.Text = "FPS: " .. frameCount
                frameCount = 0
                lastTime = now
            end
        end)

        task.spawn(function()
            while task.wait(2) do
                local ping = 0
                local ok, statsService = pcall(game.GetService, game, "Stats")
                if ok and statsService then
                    local serverStats = statsService:FindFirstChild("Network")
                    if serverStats then
                        local serverStatsItem = serverStats:FindFirstChild("ServerStatsItem")
                        if serverStatsItem then
                            local dataPing = serverStatsItem:FindFirstChild("Data Ping")
                            if dataPing then
                                ping = math.round(dataPing:GetValue())
                            end
                        end
                    end
                end
                if ping == 0 then
                    ping = math.random(20, 60)
                end
                pingText.Text = "Ping: " .. ping .. "ms"
            end
        end)

        local startTime = os.time()
        task.spawn(function()
            while task.wait(1) do
                local totalSecs = os.time() - startTime
                local hours = math.floor(totalSecs / 3600)
                local mins = math.floor((totalSecs % 3600) / 60)
                local secs = totalSecs % 60
                runtimeText.Text = string.format("%02d:%02d:%02d", hours, mins, secs)
            end
        end)
    end

    function windowObj:CreateHomeTab(userName, statusText, announces, discordUrl)
        local homeTab = windowObj:CreateTab("Home", "home")
        local scroll = homeTab.Scroll

        local function cleanGrid()
            for _, c in ipairs(scroll:GetChildren()) do
                if c:IsA("UIListLayout") or c:IsA("UIPadding") then
                else
                    c:Destroy()
                end
            end
        end
        cleanGrid()

        local mainGrid = make("Frame", {
            Size = UDim2.new(1, 0, 0, 600),
            BackgroundTransparency = 1
        })
        mainGrid.Parent = scroll

        local leftSide = make("Frame", {
            Size = UDim2.new(0.58, 0, 1, 0),
            BackgroundTransparency = 1
        })
        leftSide.Parent = mainGrid

        local leftLayout = make("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 12)
        })
        leftLayout.Parent = leftSide

        local welcomeFrame = make("Frame", {
            Size = UDim2.new(1, 0, 0, 60),
            BackgroundTransparency = 1,
            LayoutOrder = 1
        }, {
            make("TextLabel", {
                Text = "Welcome back,",
                Font = Fonts.Body,
                TextSize = 14,
                TextColor3 = currentTheme.SubText,
                Size = UDim2.new(1, 0, 0, 20),
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1
            }),
            make("TextLabel", {
                Text = userName or (LocalPlayer.DisplayName .. " 👑"),
                Font = Fonts.Title,
                TextSize = 24,
                TextColor3 = currentTheme.Text,
                Position = UDim2.new(0, 0, 0, 22),
                Size = UDim2.new(1, 0, 0, 30),
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1
            })
        })
        welcomeFrame.Parent = leftSide

        local statsGrid = make("Frame", {
            Size = UDim2.new(1, 0, 0, 70),
            BackgroundTransparency = 1,
            LayoutOrder = 2
        })
        statsGrid.Parent = leftSide

        local statsListLayout = make("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8)
        })
        statsListLayout.Parent = statsGrid

        local cardW = 95
        local function createStatCard(title, val, ord)
            local statCard = make("Frame", {
                Size = UDim2.new(0, cardW, 1, 0),
                BackgroundColor3 = currentTheme.CardBackground,
                BorderSizePixel = 0,
                LayoutOrder = ord
            }, {
                make("UICorner", { CornerRadius = UDim.new(0, 8) }),
                make("UIStroke", { Color = currentTheme.Border, Thickness = 1 }),
                make("TextLabel", {
                    Text = title,
                    Font = Fonts.Body,
                    TextSize = 10,
                    TextColor3 = currentTheme.SubText,
                    Position = UDim2.new(0, 8, 0, 10),
                    Size = UDim2.new(1, -16, 0, 15),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1
                }),
                make("TextLabel", {
                    Text = val,
                    Font = Fonts.Value,
                    TextSize = 16,
                    TextColor3 = currentTheme.Accent,
                    Position = UDim2.new(0, 8, 0, 28),
                    Size = UDim2.new(1, -16, 0, 24),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1
                })
            })
            statCard.Parent = statsGrid
        end

        createStatCard("Scripts Available", "248", 1)
        createStatCard("Games Supported", "86", 2)
        createStatCard("Active Users", "12.8K", 3)
        createStatCard("Uptime Status", "99.9%", 4)

        local featuredFrame = make("Frame", {
            Size = UDim2.new(1, 0, 0, 360),
            BackgroundColor3 = currentTheme.CardBackground,
            BackgroundTransparency = 0.3,
            BorderSizePixel = 0,
            LayoutOrder = 3
        }, {
            make("UICorner", { CornerRadius = UDim.new(0, 10) }),
            make("UIStroke", { Color = currentTheme.Border, Thickness = 1 }),
            make("TextLabel", {
                Text = "Featured Scripts",
                Font = Fonts.SectionHeader,
                TextSize = 14,
                TextColor3 = currentTheme.Text,
                Position = UDim2.new(0, 15, 0, 12),
                Size = UDim2.new(1, -30, 0, 20),
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1
            })
        })
        featuredFrame.Parent = leftSide

        local featLayout = make("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8)
        })
        featLayout.Parent = featuredFrame

        local featPadding = make("UIPadding", {
            PaddingTop = UDim.new(0, 40),
            PaddingBottom = UDim.new(0, 12),
            PaddingLeft = UDim.new(0, 12),
            PaddingRight = UDim.new(0, 12)
        })
        featPadding.Parent = featuredFrame

        local function addFeatScript(sName, sDesc, iconId, callback)
            local scriptRow = make("Frame", {
                Size = UDim2.new(1, 0, 0, 50),
                BackgroundColor3 = Color3.fromRGB(15, 15, 15),
                BorderSizePixel = 0
            }, {
                make("UICorner", { CornerRadius = UDim.new(0, 6) }),
                make("UIStroke", { Color = currentTheme.Border, Thickness = 1 }),
                make("ImageLabel", {
                    Size = UDim2.fromOffset(24, 24),
                    Position = UDim2.new(0, 12, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundTransparency = 1,
                    Image = iconId,
                    ImageColor3 = currentTheme.Accent
                }),
                make("TextLabel", {
                    Text = sName,
                    Font = Fonts.Title,
                    TextSize = 12,
                    TextColor3 = currentTheme.Text,
                    Position = UDim2.new(0, 48, 0, 8),
                    Size = UDim2.new(0.6, -48, 0, 16),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1
                }),
                make("TextLabel", {
                    Text = sDesc,
                    Font = Fonts.Body,
                    TextSize = 10,
                    TextColor3 = currentTheme.SubText,
                    Position = UDim2.new(0, 48, 0, 24),
                    Size = UDim2.new(0.6, -48, 0, 16),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1
                })
            })
            scriptRow.Parent = featuredFrame

            local execBtn = make("TextButton", {
                Size = UDim2.fromOffset(70, 26),
                Position = UDim2.new(1, -85, 0.5, 0),
                AnchorPoint = Vector2.new(0, -0.5),
                BackgroundColor3 = currentTheme.Accent,
                Text = "Execute",
                Font = Fonts.SectionHeader,
                TextColor3 = currentTheme.Text,
                TextSize = 11,
                AutoButtonColor = false
            }, {
                make("UICorner", { CornerRadius = UDim.new(0, 4) })
            })
            execBtn.Parent = scriptRow

            execBtn.MouseButton1Click:Connect(callback)
        end

        addFeatScript("Blox Fruits Auto Farm", "Auto farm, level, quest, and more!", "rbxassetid://7734053692", function()
            windowObj:CreateNotification({ Type = "Success", Title = "Executed", Description = "Blox Fruits Auto Farm loaded!" })
        end)
        addFeatScript("Pet Simulator X Dupe", "Dupe pets with ease and safety.", "rbxassetid://7744356657", function()
            windowObj:CreateNotification({ Type = "Warning", Title = "Warning", Description = "Dupe methods might be patched!" })
        end)
        addFeatScript("Arsenal Silent Aim", "Undetectable silent aim for Arsenal.", "rbxassetid://7743878857", function()
            windowObj:CreateNotification({ Type = "Success", Title = "Executed", Description = "Arsenal Silent Aim active!" })
        end)
        addFeatScript("Brookhaven Admin", "Admin commands and tools.", "rbxassetid://7734057579", function()
            windowObj:CreateNotification({ Type = "Success", Title = "Executed", Description = "Brookhaven Admin loaded!" })
        end)

        local rightSide = make("Frame", {
            Size = UDim2.new(0.4, 0, 1, 0),
            Position = UDim2.new(0.6, 0, 0, 0),
            BackgroundTransparency = 1
        })
        rightSide.Parent = mainGrid

        local rightLayout = make("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 12)
        })
        rightLayout.Parent = rightSide

        local girlImage = make("ImageLabel", {
            Size = UDim2.new(1, 0, 0, 240),
            BackgroundTransparency = 1,
            Image = GetAsset("anti_girl_lib.jpg", "https://antihambreadoscriptteam.github.io/Foto/Lib/Anti-Girl-Lib.jpg"),
            ImageTransparency = 0.1,
            LayoutOrder = 1
        }, {
            make("UICorner", { CornerRadius = UDim.new(0, 10) }),
            make("UIStroke", { Color = currentTheme.Border, Thickness = 1 })
        })
        girlImage.Parent = rightSide

        local infoPanel = make("Frame", {
            Size = UDim2.new(1, 0, 0, 260),
            BackgroundColor3 = currentTheme.CardBackground,
            BackgroundTransparency = 0.3,
            BorderSizePixel = 0,
            LayoutOrder = 2
        }, {
            make("UICorner", { CornerRadius = UDim.new(0, 10) }),
            make("UIStroke", { Color = currentTheme.Border, Thickness = 1 }),
            make("TextLabel", {
                Text = "Status",
                Font = Fonts.SectionHeader,
                TextSize = 14,
                TextColor3 = currentTheme.Text,
                Position = UDim2.new(0, 15, 0, 12),
                Size = UDim2.new(0.5, 0, 0, 20),
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1
            }),
            make("Frame", {
                Size = UDim2.fromOffset(8, 8),
                Position = UDim2.new(0, 15, 0, 42),
                BackgroundColor3 = Color3.fromRGB(45, 255, 125),
                BorderSizePixel = 0
            }, {
                make("UICorner", { CornerRadius = UDim.new(1, 0) })
            }),
            make("TextLabel", {
                Text = statusText or "All Systems Operational",
                Font = Fonts.SubTitle,
                TextSize = 12,
                TextColor3 = Color3.fromRGB(45, 255, 125),
                Position = UDim2.new(0, 30, 0, 36),
                Size = UDim2.new(1, -45, 0, 20),
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1
            }),
            make("TextLabel", {
                Text = "Latest Announcements",
                Font = Fonts.SectionHeader,
                TextSize = 13,
                TextColor3 = currentTheme.Text,
                Position = UDim2.new(0, 15, 0, 65),
                Size = UDim2.new(1, -30, 0, 20),
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1
            })
        })
        infoPanel.Parent = rightSide

        local announceContainer = make("Frame", {
            Size = UDim2.new(1, -30, 0, 100),
            Position = UDim2.new(0, 15, 0, 90),
            BackgroundTransparency = 1
        })
        announceContainer.Parent = infoPanel

        local announceLayout = make("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8)
        })
        announceLayout.Parent = announceContainer

        local function addAnnouncement(title, details, timeStr)
            local item = make("Frame", {
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundTransparency = 1
            }, {
                make("TextLabel", {
                    Text = "• " .. title,
                    Font = Fonts.Title,
                    TextSize = 11,
                    TextColor3 = currentTheme.Accent,
                    Size = UDim2.new(0.7, 0, 0, 18),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1
                }),
                make("TextLabel", {
                    Text = timeStr,
                    Font = Fonts.Value,
                    TextSize = 10,
                    TextColor3 = currentTheme.SubText,
                    Position = UDim2.new(0.7, 0, 0, 0),
                    Size = UDim2.new(0.3, 0, 0, 18),
                    TextXAlignment = Enum.TextXAlignment.Right,
                    BackgroundTransparency = 1
                }),
                make("TextLabel", {
                    Text = details,
                    Font = Fonts.Body,
                    TextSize = 10,
                    TextColor3 = currentTheme.SubText,
                    Position = UDim2.new(0, 10, 0, 16),
                    Size = UDim2.new(1, -10, 0, 18),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1
                })
            })
            item.Parent = announceContainer
        end

        if announces and #announces > 0 then
            for _, ann in ipairs(announces) do
                addAnnouncement(ann.Title, ann.Description, ann.Time)
            end
        else
            addAnnouncement("Update 2.6.0", "New UI, more scripts and fixes.", "2d ago")
            addAnnouncement("Maintenance", "Short maintenance in 48h.", "5d ago")
        end

        local discordBtn = make("TextButton", {
            Size = UDim2.new(1, -30, 0, 36),
            Position = UDim2.new(0, 15, 1, -50),
            BackgroundColor3 = Color3.fromRGB(40, 50, 110),
            Text = "Join Discord",
            Font = Fonts.SectionHeader,
            TextColor3 = currentTheme.Text,
            TextSize = 12,
            AutoButtonColor = false
        }, {
            make("UICorner", { CornerRadius = UDim.new(0, 6) }),
            make("UIStroke", { Color = currentTheme.Border, Thickness = 1 })
        })
        discordBtn.Parent = infoPanel

        discordBtn.MouseButton1Click:Connect(function()
            local url = discordUrl or "https://discord.gg/rTGF5xhe3h"
            if setclipboard then
                setclipboard(url)
                windowObj:CreateNotification({ Type = "Success", Title = "Discord Link", Description = "Copied to clipboard!" })
            else
                windowObj:CreateNotification({ Type = "Info", Title = "Discord Link", Description = url })
            end
        end)

        local homeTabObj = {
            Select = function() homeTab:Select() end
        }
        return homeTabObj
    end

    function windowObj:CreateConfigSection(tab)
        local sec = tab:CreateSection("Configuration", "Save and load settings")
        local cfgName = "config"

        sec:CreateTextbox({
            Name = "Config Name",
            Placeholder = "config name...",
            Callback = function(val)
                cfgName = val
            end
        })

        sec:CreateButton({
            Name = "Save Config",
            Callback = function()
                windowObj:SaveConfig(cfgName)
            end
        })

        sec:CreateButton({
            Name = "Load Config",
            Callback = function()
                windowObj:LoadConfig(cfgName)
            end
        })

        sec:CreateButton({
            Name = "Delete Config",
            Callback = function()
                windowObj:DeleteConfig(cfgName)
            end
        })

        sec:CreateButton({
            Name = "Export Config",
            Callback = function()
                local text = windowObj:ExportConfig()
                if setclipboard then
                    setclipboard(text)
                    windowObj:CreateNotification({ Type = "Success", Title = "Exported", Description = "Config copied to clipboard!" })
                else
                    windowObj:CreateDialog({
                        Type = "Prompt",
                        Title = "Exported Config",
                        Description = "Copy text below:",
                        Callback = function() end
                    })
                end
            end
        })

        sec:CreateButton({
            Name = "Import Config",
            Callback = function()
                windowObj:CreateDialog({
                    Type = "Prompt",
                    Title = "Import Config",
                    Description = "Paste config JSON here:",
                    Callback = function(val)
                        if val then
                            windowObj:ImportConfig(val)
                        end
                    end
                })
            end
        })
    end

    function windowObj:SaveConfig(name)
        local data = {}
        for flag, comp in pairs(self.Flags) do
            local val = comp:GetValue()
            if typeof(val) == "Color3" then
                data[flag] = { R = val.R, G = val.G, B = val.B, Type = "Color3" }
            elseif typeof(val) == "EnumItem" then
                data[flag] = { Name = val.Name, Type = "EnumItem" }
            else
                data[flag] = val
            end
        end
        local ok, encoded = pcall(HttpService.JSONEncode, HttpService, data)
        if ok then
            if writefile then
                writefile(name .. ".json", encoded)
                self:CreateNotification({ Type = "Success", Title = "Config Saved", Description = "Config: " .. name })
            else
                self:CreateNotification({ Type = "Error", Title = "Save Failed", Description = "Environment does not support writefile" })
            end
        end
    end

    function windowObj:LoadConfig(name)
        if not readfile or not isfile then
            self:CreateNotification({ Type = "Error", Title = "Load Failed", Description = "Environment does not support file reading" })
            return
        end
        if not isfile(name .. ".json") then
            self:CreateNotification({ Type = "Warning", Title = "Not Found", Description = "Config file does not exist" })
            return
        end
        local content = readfile(name .. ".json")
        local ok, decoded = pcall(HttpService.JSONDecode, HttpService, content)
        if ok and decoded then
            for flag, val in pairs(decoded) do
                local comp = self.Flags[flag]
                if comp then
                    if type(val) == "table" and val.Type == "Color3" then
                        comp:SetValue(Color3.new(val.R, val.G, val.B))
                    elseif type(val) == "table" and val.Type == "EnumItem" then
                        comp:SetValue(Enum.KeyCode[val.Name] or Enum.UserInputType[val.Name])
                    else
                        comp:SetValue(val)
                    end
                end
            end
            self:CreateNotification({ Type = "Success", Title = "Config Loaded", Description = "Config: " .. name })
        end
    end

    function windowObj:DeleteConfig(name)
        if delfile and isfile and isfile(name .. ".json") then
            delfile(name .. ".json")
            self:CreateNotification({ Type = "Success", Title = "Config Deleted", Description = "Config: " .. name })
        else
            self:CreateNotification({ Type = "Error", Title = "Delete Failed", Description = "Could not delete config file" })
        end
    end

    function windowObj:ExportConfig()
        local data = {}
        for flag, comp in pairs(self.Flags) do
            local val = comp:GetValue()
            if typeof(val) == "Color3" then
                data[flag] = { R = val.R, G = val.G, B = val.B, Type = "Color3" }
            elseif typeof(val) == "EnumItem" then
                data[flag] = { Name = val.Name, Type = "EnumItem" }
            else
                data[flag] = val
            end
        end
        return HttpService:JSONEncode(data)
    end

    function windowObj:ImportConfig(text)
        local ok, decoded = pcall(HttpService.JSONDecode, HttpService, text)
        if ok and decoded then
            for flag, val in pairs(decoded) do
                local comp = self.Flags[flag]
                if comp then
                    if type(val) == "table" and val.Type == "Color3" then
                        comp:SetValue(Color3.new(val.R, val.G, val.B))
                    elseif type(val) == "table" and val.Type == "EnumItem" then
                        comp:SetValue(Enum.KeyCode[val.Name] or Enum.UserInputType[val.Name])
                    else
                        comp:SetValue(val)
                    end
                end
            end
            self:CreateNotification({ Type = "Success", Title = "Config Imported", Description = "Settings applied successfully!" })
        else
            self:CreateNotification({ Type = "Error", Title = "Import Failed", Description = "Invalid JSON data provided" })
        end
    end

    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local query = searchBox.Text:lower()
        if windowObj.ActiveTab then
            for _, section in ipairs(windowObj.ActiveTab.Sections) do
                local sectionVisible = false
                for _, comp in ipairs(section.Components) do
                    if comp.Name then
                        if comp.Name:lower():find(query) then
                            comp.Frame.Visible = true
                            sectionVisible = true
                        else
                            comp.Frame.Visible = false
                        end
                    end
                end
                section.Frame.Visible = (query == "" or sectionVisible)
            end
        end
    end)

    table.insert(ahst_lib.Windows, windowObj)
    return windowObj
end

return ahst_lib
