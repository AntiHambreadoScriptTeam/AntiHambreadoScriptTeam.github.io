local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local GuiService = game:GetService("GuiService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local shared = _G
if type(getgenv) == "function" then
    local ok, env = pcall(getgenv)
    if ok and type(env) == "table" then
        shared = env
    end
end
shared.AHST_GENERATION = (shared.AHST_GENERATION or 0) + 1
local GENERATION = shared.AHST_GENERATION
local function isCurrent()
    return shared.AHST_GENERATION == GENERATION
end

for _, child in ipairs(PlayerGui:GetChildren()) do
    if child:IsA("ScreenGui") then
        local name = child.Name
        if name == "AHST" or name == "AHST_FOV" or name == "AHST_ESP" then
            child:Destroy()
        end
    end
end

local DISCORD_INVITE = "https://discord.gg/rTGF5xhe3h"
local FAB_IMAGE_URL = "https://files.catbox.moe/j8ezzd.jpg"
local LOGO_IMAGE_URL = "https://i.postimg.cc/wTpYKGqV/Anti-Hambreado.jpg"
local DISCORD_IMAGE_URL = "https://img.icons8.com/ios-filled/100/ffffff/discord-logo.png"

local THEME = {
    bg = Color3.fromRGB(0, 0, 0),
    surface = Color3.fromRGB(8, 8, 8),
    surface2 = Color3.fromRGB(16, 16, 16),
    accent = Color3.fromRGB(255, 42, 42),
    accentDim = Color3.fromRGB(255, 92, 92),
    accentDark = Color3.fromRGB(72, 0, 0),
    text = Color3.fromRGB(255, 255, 255),
    muted = Color3.fromRGB(168, 168, 168),
    gold = Color3.fromRGB(255, 255, 255),
    white = Color3.fromRGB(255, 255, 255),
}

local function clamp(value, minValue, maxValue)
    if value < minValue then return minValue end
    if value > maxValue then return maxValue end
    return value
end

local function create(className, properties)
    local object = Instance.new(className)
    for key, value in pairs(properties or {}) do
        if key ~= "Parent" then
            object[key] = value
        end
    end
    if properties and properties.Parent then
        object.Parent = properties.Parent
    end
    return object
end

local function addCorner(parent, radius)
    return create("UICorner", {
        CornerRadius = UDim.new(0, radius),
        Parent = parent,
    })
end

local function addStroke(parent, color, thickness, transparency)
    return create("UIStroke", {
        Color = color or THEME.accent,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
        Parent = parent,
    })
end

local function looksLikeImage(body)
    if type(body) ~= "string" or #body < 32 then
        return false
    end
    if string.sub(body, 1, 4) == "\137PNG" then
        return true
    end
    return string.byte(body, 1) == 255 and string.byte(body, 2) == 216
end

local function resolveImage(url, fileName)
    local function fromFile()
        if type(getcustomasset) ~= "function" or type(isfile) ~= "function" or type(readfile) ~= "function" then
            return nil
        end
        local exists = false
        pcall(function()
            exists = isfile(fileName)
        end)
        if not exists then
            return nil
        end
        local okBody, body = pcall(readfile, fileName)
        if not okBody or not looksLikeImage(body) then
            return nil
        end
        local ok, asset = pcall(getcustomasset, fileName)
        if ok and type(asset) == "string" and asset ~= "" then
            return asset
        end
        return nil
    end

    local cached = fromFile()
    if cached then
        return cached
    end

    local body = nil
    local requestFunc = nil
    if type(request) == "function" then
        requestFunc = request
    elseif type(http_request) == "function" then
        requestFunc = http_request
    elseif type(syn) == "table" and type(syn.request) == "function" then
        requestFunc = syn.request
    end
    if requestFunc then
        local ok, response = pcall(function()
            return requestFunc({
                Url = url,
                Method = "GET",
            })
        end)
        if ok and type(response) == "table" and looksLikeImage(response.Body) then
            body = response.Body
        end
    end
    if not body and type(game.HttpGet) == "function" then
        local ok, response = pcall(function()
            return game:HttpGet(url)
        end)
        if ok and looksLikeImage(response) then
            body = response
        end
    end
    if body and type(writefile) == "function" then
        pcall(writefile, fileName, body)
        local asset = fromFile()
        if asset then
            return asset
        end
    end
    return url
end

local function getViewport()
    local camera = workspace.CurrentCamera
    if camera then
        return camera.ViewportSize
    end
    return Vector2.new(1920, 1080)
end

local function currentTime()
    if type(tick) == "function" then
        return tick()
    end
    if type(DateTime) == "table" then
        local ok, value = pcall(function()
            return DateTime.now().UnixTimestampMillis / 1000
        end)
        if ok and type(value) == "number" then
            return value
        end
    end
    return os.clock()
end

local function bindClick(button, callback)
    local lastRun = nil
    local function run()
        local now = currentTime()
        if lastRun and (now - lastRun) < 0.15 then
            return
        end
        lastRun = now
        callback()
    end
    button.Activated:Connect(run)
    button.MouseButton1Click:Connect(run)
    if button.TouchTap then
        button.TouchTap:Connect(run)
    end
end

local state = {
    panelOpen = true,
    minimized = false,
    activeTab = 1,
    playerAim = false,
    playerAimMode = "both",
    monkeyAim = false,
    monkeyAimMode = "both",
    autoFire = false,
    farmLinkedCombat = false,
    smoothness = 0.35,
    fovRadius = 350,
    showFov = false,
    playerEsp = false,
    monkeyEsp = false,
    espOptions = {
        box = true,
        tracer = true,
        skeleton = true,
        name = true,
        health = true,
        distance = true,
    },
    autoFarm = false,
    farmX = 8,
    farmY = 55,
    farmZ = 133,
    infiniteJump = false,
    noclip = false,
    fly = false,
    flySpeed = 80,
    speedHack = false,
    walkSpeed = 32,
    cameraFov = 70,
    fullBright = false,
    antiAfk = false,
}

local viewport = getViewport()
local guiInsetX, guiInsetY = 0, 0
do
    local ok, topLeft, bottomRight = pcall(function()
        return GuiService:GetGuiInset()
    end)
    if ok then
        if topLeft then
            guiInsetX = guiInsetX + (topLeft.X or 0)
            guiInsetY = guiInsetY + (topLeft.Y or 0)
        end
        if bottomRight then
            guiInsetX = guiInsetX + (bottomRight.X or 0)
            guiInsetY = guiInsetY + (bottomRight.Y or 0)
        end
    end
end
local safeWidth = math.max(240, viewport.X - guiInsetX)
local safeHeight = math.max(240, viewport.Y - guiInsetY)
local PANEL_WIDTH = clamp(safeWidth - 24, 320, 480)
local PANEL_HEIGHT = clamp(safeHeight - 24, 260, 560)
local HEADER_HEIGHT = 58
local FAB_SIZE = 56

local gui = create("ScreenGui", {
    Name = "AHST",
    ResetOnSpawn = false,
    IgnoreGuiInset = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 999999,
    Parent = PlayerGui,
})

local fovGui = create("ScreenGui", {
    Name = "AHST_FOV",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 999998,
    Parent = PlayerGui,
})
local fovCircle = create("Frame", {
    Name = "FovCircle",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(700, 700),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Visible = false,
    Active = false,
    Parent = fovGui,
})
addCorner(fovCircle, 9999)
addStroke(fovCircle, THEME.accent, 1, 0.35)

local panel = create("Frame", {
    Name = "Panel",
    AnchorPoint = Vector2.new(0, 0),
    Position = UDim2.fromOffset(
        math.max(0, (safeWidth - PANEL_WIDTH) / 2),
        math.max(0, (safeHeight - PANEL_HEIGHT) / 2)
    ),
    Size = UDim2.fromOffset(PANEL_WIDTH, PANEL_HEIGHT),
    BackgroundColor3 = THEME.bg,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Active = true,
    Parent = gui,
})
addCorner(panel, 16)
addStroke(panel, THEME.accent, 1, 0.45)

local header = create("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, HEADER_HEIGHT),
    BackgroundColor3 = THEME.surface,
    BorderSizePixel = 0,
    Parent = panel,
})
addCorner(header, 16)

local logo = create("ImageLabel", {
    Name = "Logo",
    Position = UDim2.fromOffset(12, 13),
    Size = UDim2.fromOffset(32, 32),
    BackgroundColor3 = THEME.bg,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Image = LOGO_IMAGE_URL,
    ScaleType = Enum.ScaleType.Fit,
    ZIndex = 6,
    Parent = header,
})
addCorner(logo, 6)

local title = create("TextLabel", {
    Name = "Title",
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(52, 6),
    Size = UDim2.new(1, -196, 0, 28),
    Font = Enum.Font.GothamBold,
    Text = "AHST Monkeys Script",
    TextSize = 16,
    TextColor3 = THEME.white,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center,
    TextTruncate = Enum.TextTruncate.AtEnd,
    ZIndex = 2,
    Parent = header,
})

local subtitle = create("TextLabel", {
    Name = "Status",
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(52, 32),
    Size = UDim2.new(1, -196, 0, 16),
    Font = Enum.Font.GothamMedium,
    Text = "AHST",
    TextSize = 11,
    TextColor3 = THEME.muted,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center,
    TextTruncate = Enum.TextTruncate.AtEnd,
    ZIndex = 2,
    Parent = header,
})

local function setStatus(text)
    subtitle.Text = text
end

local function openUrl(url)
    local opened = false
    local function try(fn)
        if opened then
            return
        end
        local ok = pcall(fn)
        if ok then
            opened = true
        end
    end
    try(function()
        if type(syn) == "table" and type(syn.open_url) == "function" then
            syn.open_url(url)
            return
        end
        error("no syn")
    end)
    try(function()
        if type(fluxus) == "table" and type(fluxus.openurl) == "function" then
            fluxus.openurl(url)
            return
        end
        error("no fluxus")
    end)
    try(function()
        local env = type(getgenv) == "function" and getgenv() or {}
        local opener = env.openurl or env.open_url or env.OpenUrl
        if type(opener) == "function" then
            opener(url)
            return
        end
        error("no opener")
    end)
    try(function()
        GuiService:OpenBrowserWindow(url)
    end)
    return opened
end

local function openDiscord()
    openUrl(DISCORD_INVITE)
    setStatus("Discord")
end

local function addHeaderButton(parent, name, text, xOffset, color, callback)
    local button = create("TextButton", {
        Name = name,
        Size = UDim2.fromOffset(28, 28),
        Position = UDim2.new(1, xOffset, 0, 15),
        BackgroundColor3 = THEME.surface2,
        BorderSizePixel = 0,
        Font = Enum.Font.GothamBold,
        Text = text,
        TextSize = 15,
        TextColor3 = color,
        AutoButtonColor = false,
        ZIndex = 10,
        Parent = parent,
    })
    addCorner(button, 8)
    addStroke(button, color, 1, 0.5)
    bindClick(button, callback)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.12), {
            BackgroundColor3 = THEME.accentDark,
            TextColor3 = THEME.white,
        }):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.12), {
            BackgroundColor3 = THEME.surface2,
            TextColor3 = color,
        }):Play()
    end)
    return button
end

local setPanel
local setMinimized
local activeSlider = nil
local content

local dragArea = create("Frame", {
    Name = "DragArea",
    Size = UDim2.new(1, -124, 1, 0),
    BackgroundTransparency = 1,
    Active = true,
    ZIndex = 5,
    Parent = header,
})

local closeButton = addHeaderButton(header, "Close", "X", -36, THEME.white, function()
    setPanel(false)
end)
closeButton.TextSize = 14
local minButton = addHeaderButton(header, "Minimize", "-", -68, THEME.white, function()
    setMinimized(not state.minimized)
end)
minButton.TextSize = 18
local discordButton = addHeaderButton(header, "Discord", "D", -100, THEME.white, openDiscord)
discordButton.TextSize = 13
local discordIcon = create("ImageLabel", {
    Name = "DiscordIcon",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(16, 16),
    BackgroundTransparency = 1,
    Image = "",
    ScaleType = Enum.ScaleType.Fit,
    Active = false,
    ZIndex = 12,
    Parent = discordButton,
})

local separator = create("Frame", {
    Name = "Separator",
    Position = UDim2.fromOffset(16, HEADER_HEIGHT),
    Size = UDim2.new(1, -32, 0, 1),
    BackgroundColor3 = THEME.accent,
    BackgroundTransparency = 0.8,
    BorderSizePixel = 0,
    Parent = panel,
})

local tabBar = create("Frame", {
    Name = "TabBar",
    Position = UDim2.fromOffset(0, HEADER_HEIGHT + 1),
    Size = UDim2.new(1, 0, 0, 37),
    BackgroundTransparency = 1,
    Parent = panel,
})

local tabScroll = create("ScrollingFrame", {
    Name = "TabScroll",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 0,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.X,
    ScrollingDirection = Enum.ScrollingDirection.X,
    ElasticBehavior = Enum.ElasticBehavior.Never,
    Parent = tabBar,
})
create("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    Parent = tabScroll,
})
create("UIPadding", {
    PaddingLeft = UDim.new(0, 16),
    PaddingRight = UDim.new(0, 16),
    Parent = tabScroll,
})

content = create("ScrollingFrame", {
    Name = "Content",
    Position = UDim2.fromOffset(8, HEADER_HEIGHT + 38),
    Size = UDim2.new(1, -16, 1, -(HEADER_HEIGHT + 38) - 10),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = THEME.accent,
    ScrollBarImageTransparency = 0.3,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    ElasticBehavior = Enum.ElasticBehavior.Never,
    ClipsDescendants = true,
    Parent = panel,
})
create("UIPadding", {
    PaddingTop = UDim.new(0, 4),
    PaddingBottom = UDim.new(0, 12),
    PaddingLeft = UDim.new(0, 4),
    PaddingRight = UDim.new(0, 8),
    Parent = content,
})

local layoutCounters = setmetatable({}, { __mode = "k" })
local function nextLayoutOrder(parent)
    local value = (layoutCounters[parent] or 0) + 1
    layoutCounters[parent] = value
    return value
end

local function addSectionTitle(parent, text)
    local row = create("Frame", {
        Size = UDim2.new(1, 0, 0, 22),
        BackgroundTransparency = 1,
        LayoutOrder = nextLayoutOrder(parent),
        Parent = parent,
    })
    create("TextLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Font = Enum.Font.GothamBold,
        Text = text,
        TextSize = 11,
        TextColor3 = THEME.accentDim,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        Parent = row,
    })
    create("Frame", {
        Size = UDim2.new(1, -140, 0, 1),
        Position = UDim2.new(0, 140, 0.5, 0),
        BackgroundColor3 = THEME.accent,
        BackgroundTransparency = 0.8,
        BorderSizePixel = 0,
        Parent = row,
    })
    return row
end

local function addCard(parent, height)
    local card = create("Frame", {
        Size = UDim2.new(1, 0, 0, height or 44),
        BackgroundColor3 = THEME.surface,
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        LayoutOrder = nextLayoutOrder(parent),
        Parent = parent,
    })
    addCorner(card, 8)
    return card
end

local function addToggle(parent, labelText, initialValue, callback)
    local card = addCard(parent, 44)
    card.Name = "Toggle_" .. labelText
    create("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(12, 0),
        Size = UDim2.new(1, -70, 1, 0),
        Font = Enum.Font.GothamMedium,
        Text = labelText,
        TextSize = 13,
        TextColor3 = THEME.text,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        Parent = card,
    })
    local track = create("Frame", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(40, 20),
        BackgroundColor3 = initialValue and THEME.accent or THEME.surface2,
        BorderSizePixel = 0,
        Parent = card,
    })
    addCorner(track, 10)
    addStroke(track, THEME.accentDark, 1, 0.4)
    local knob = create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = initialValue and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
        Size = UDim2.fromOffset(16, 16),
        BackgroundColor3 = THEME.text,
        BorderSizePixel = 0,
        Parent = track,
    })
    addCorner(knob, 8)
    local button = create("TextButton", {
        Name = "ToggleButton",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 2,
        Parent = card,
    })
    local current = initialValue
    local function setValue(value, fireCallback)
        current = value
        TweenService:Create(track, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            BackgroundColor3 = value and THEME.accent or THEME.surface2,
        }):Play()
        TweenService:Create(knob, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = value and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
        }):Play()
        if fireCallback then
            callback(value)
        end
    end
    bindClick(button, function()
        setValue(not current, true)
    end)
    return card, setValue
end

local function addSlider(parent, labelText, minValue, maxValue, initialValue, formatValue, callback)
    local card = addCard(parent, 62)
    card.Name = "Slider_" .. labelText
    create("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(12, 8),
        Size = UDim2.new(1, -100, 0, 16),
        Font = Enum.Font.GothamMedium,
        Text = labelText,
        TextSize = 13,
        TextColor3 = THEME.text,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        Parent = card,
    })
    local valueLabel = create("TextLabel", {
        Name = "SliderValue",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -12, 0, 8),
        Size = UDim2.fromOffset(90, 16),
        Font = Enum.Font.GothamBold,
        Text = formatValue(initialValue),
        TextSize = 12,
        TextColor3 = THEME.accent,
        TextXAlignment = Enum.TextXAlignment.Right,
        TextYAlignment = Enum.TextYAlignment.Center,
        Parent = card,
    })
    local track = create("Frame", {
        Name = "SliderTrack",
        Position = UDim2.fromOffset(12, 42),
        Size = UDim2.new(1, -24, 0, 6),
        BackgroundColor3 = THEME.bg,
        BorderSizePixel = 0,
        Parent = card,
    })
    addCorner(track, 3)
    local function fractionFor(value)
        if maxValue == minValue then return 0 end
        return clamp((value - minValue) / (maxValue - minValue), 0, 1)
    end
    local fill = create("Frame", {
        Size = UDim2.new(fractionFor(initialValue), 0, 1, 0),
        BackgroundColor3 = THEME.accent,
        BorderSizePixel = 0,
        Parent = track,
    })
    addCorner(fill, 3)
    local knob = create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(fractionFor(initialValue), 0, 0.5, 0),
        Size = UDim2.fromOffset(18, 18),
        BackgroundColor3 = THEME.accent,
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = track,
    })
    addCorner(knob, 9)
    addStroke(knob, THEME.white, 1, 0.6)
    local hitbox = create("TextButton", {
        Name = "SliderHitbox",
        Position = UDim2.fromOffset(0, 30),
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 3,
        Parent = card,
    })
    local slider = {
        label = labelText,
        valueLabel = valueLabel,
        value = initialValue,
    }
    local function updateFromX(x)
        local trackPosition = track.AbsolutePosition
        local trackSize = track.AbsoluteSize
        local fraction = 0
        if trackSize.X > 0 then
            fraction = clamp((x - trackPosition.X) / trackSize.X, 0, 1)
        end
        local value = minValue + (maxValue - minValue) * fraction
        slider.value = value
        fill.Size = UDim2.new(fraction, 0, 1, 0)
        knob.Position = UDim2.new(fraction, 0, 0.5, 0)
        valueLabel.Text = formatValue(value)
        callback(value)
    end
    slider.updateFromX = updateFromX
    hitbox.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            activeSlider = slider
            content.ScrollingEnabled = false
            updateFromX(input.Position.X)
        end
    end)
    return card, slider
end

local function addButton(parent, text, callback)
    local button = create("TextButton", {
        Name = "Button_" .. text,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = THEME.surface,
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        Font = Enum.Font.GothamBold,
        Text = text,
        TextSize = 13,
        TextColor3 = THEME.accent,
        AutoButtonColor = false,
        LayoutOrder = nextLayoutOrder(parent),
        Parent = parent,
    })
    addCorner(button, 8)
    addStroke(button, THEME.accent, 1, 0.5)
    bindClick(button, callback)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.12), {
            BackgroundColor3 = THEME.accentDark,
            TextColor3 = THEME.white,
        }):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.12), {
            BackgroundColor3 = THEME.surface,
            TextColor3 = THEME.accent,
        }):Play()
    end)
    return button
end

local function addChoice(parent, labelText, options, currentId, callback)
    local card = addCard(parent, 76)
    card.Name = "Choice_" .. labelText
    create("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(12, 8),
        Size = UDim2.new(1, -24, 0, 16),
        Font = Enum.Font.GothamMedium,
        Text = labelText,
        TextSize = 13,
        TextColor3 = THEME.white,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        Parent = card,
    })
    local row = create("Frame", {
        Position = UDim2.fromOffset(8, 32),
        Size = UDim2.new(1, -16, 0, 32),
        BackgroundTransparency = 1,
        Parent = card,
    })
    local buttons = {}
    local selected = currentId
    local function paint()
        for _, item in ipairs(buttons) do
            local on = item.id == selected
            item.button.BackgroundColor3 = on and THEME.accent or THEME.surface2
            item.button.TextColor3 = THEME.white
            item.button.BackgroundTransparency = on and 0 or 0.15
        end
    end
    local count = math.max(1, #options)
    for index, option in ipairs(options) do
        local button = create("TextButton", {
            Size = UDim2.new(1 / count, -4, 1, 0),
            Position = UDim2.new((index - 1) / count, 2, 0, 0),
            BackgroundColor3 = THEME.surface2,
            BorderSizePixel = 0,
            Font = Enum.Font.GothamBold,
            Text = option.label,
            TextSize = 11,
            TextColor3 = THEME.white,
            AutoButtonColor = false,
            Parent = row,
        })
        addCorner(button, 7)
        buttons[index] = { id = option.id, button = button }
        bindClick(button, function()
            selected = option.id
            paint()
            callback(option.id)
        end)
    end
    paint()
    return card
end

local function addMulti(parent, labelText, options, selected, callback)
    local rowHeight = 30
    local headerHeight = 44
    local card = addCard(parent, headerHeight)
    card.Name = "Multi_" .. labelText
    card.ClipsDescendants = true
    local header = create("TextButton", {
        Size = UDim2.new(1, 0, 0, headerHeight),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 2,
        Parent = card,
    })
    create("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(12, 6),
        Size = UDim2.new(1, -36, 0, 16),
        Font = Enum.Font.GothamMedium,
        Text = labelText,
        TextSize = 13,
        TextColor3 = THEME.white,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = header,
    })
    local summary = create("TextLabel", {
        Name = "Summary",
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(12, 22),
        Size = UDim2.new(1, -36, 0, 16),
        Font = Enum.Font.Gotham,
        Text = "",
        TextSize = 11,
        TextColor3 = THEME.muted,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = header,
    })
    local arrow = create("TextLabel", {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(16, 16),
        Font = Enum.Font.GothamBold,
        Text = "+",
        TextSize = 16,
        TextColor3 = THEME.accent,
        Parent = header,
    })
    local list = create("Frame", {
        Position = UDim2.fromOffset(8, headerHeight),
        Size = UDim2.new(1, -16, 0, #options * rowHeight),
        BackgroundTransparency = 1,
        Visible = false,
        Parent = card,
    })
    local marks = {}
    local function summaryText()
        local names = {}
        local count = 0
        for _, option in ipairs(options) do
            if selected[option.id] then
                count = count + 1
                names[#names + 1] = option.label
            end
        end
        if count == 0 then
            return "Nada"
        end
        if count == #options then
            return "Todo"
        end
        return table.concat(names, ", ")
    end
    local function paint()
        summary.Text = summaryText()
        for _, item in ipairs(marks) do
            local on = selected[item.id] and true or false
            item.box.BackgroundColor3 = on and THEME.accent or THEME.surface2
            item.mark.Text = on and "x" or ""
        end
    end
    for index, option in ipairs(options) do
        local row = create("TextButton", {
            Position = UDim2.fromOffset(0, (index - 1) * rowHeight),
            Size = UDim2.new(1, 0, 0, rowHeight),
            BackgroundTransparency = 1,
            Text = "",
            AutoButtonColor = false,
            Parent = list,
        })
        local box = create("Frame", {
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 4, 0.5, 0),
            Size = UDim2.fromOffset(16, 16),
            BackgroundColor3 = THEME.surface2,
            BorderSizePixel = 0,
            Parent = row,
        })
        addCorner(box, 4)
        local mark = create("TextLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Font = Enum.Font.GothamBold,
            Text = "",
            TextSize = 12,
            TextColor3 = THEME.white,
            Parent = box,
        })
        create("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(28, 0),
            Size = UDim2.new(1, -32, 1, 0),
            Font = Enum.Font.GothamMedium,
            Text = option.label,
            TextSize = 13,
            TextColor3 = THEME.white,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = row,
        })
        marks[index] = { id = option.id, box = box, mark = mark }
        bindClick(row, function()
            selected[option.id] = not selected[option.id]
            paint()
            callback(option.id, selected[option.id] and true or false)
        end)
    end
    local open = false
    local function setOpen(value)
        open = value
        list.Visible = value
        arrow.Text = value and "-" or "+"
        card.Size = UDim2.new(1, 0, 0, value and (headerHeight + 6 + #options * rowHeight) or headerHeight)
    end
    bindClick(header, function()
        setOpen(not open)
    end)
    paint()
    return card
end

local camera = workspace.CurrentCamera
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    if workspace.CurrentCamera then
        camera = workspace.CurrentCamera
    end
end)
local originalCameraFov = camera and camera.FieldOfView or 70
if camera then
    state.cameraFov = camera.FieldOfView
end

local function getCharacter()
    local character = LocalPlayer.Character
    if not character or not character.Parent then
        return nil, nil, nil
    end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root or humanoid.Health <= 0 then
        return nil, nil, nil
    end
    return character, humanoid, root
end

local function updateFovCircle()
    local diameter = math.max(40, state.fovRadius * 2)
    fovCircle.Size = UDim2.fromOffset(diameter, diameter)
    fovCircle.Visible = state.showFov
end

local HIGH_FARM_Y = 20
local platform = nil
local farmRoot = nil
local targetCache = {
    players = {},
    monkeys = {},
    playerEsp = {},
    monkeyEsp = {},
}
local nextTargetScan = 0

local MONKEY_WORDS = {
    "monkey", "monke", "mono", "ape", "chimp", "gorilla",
    "baboon", "primate", "simio", "orangutan", "macaque",
}

local function nameIsMonkey(name)
    local lower = string.lower(tostring(name or ""))
    for _, word in ipairs(MONKEY_WORDS) do
        if string.find(lower, word, 1, true) then
            return true
        end
    end
    return false
end

local function clearPlatform()
    if platform then
        platform:Destroy()
        platform = nil
    end
    local leftover = workspace:FindFirstChild("AHST_PLATFORM")
    if leftover then
        leftover:Destroy()
    end
end

local function feetDrop(humanoid, root)
    local hip = 2
    if humanoid and type(humanoid.HipHeight) == "number" then
        hip = humanoid.HipHeight
    end
    local half = 1
    if root and root:IsA("BasePart") then
        half = root.Size.Y * 0.5
    end
    return half + hip
end

local function ensurePlatform(position, humanoid, root)
    if not platform or platform.Parent == nil then
        platform = Instance.new("Part")
        platform.Name = "AHST_PLATFORM"
        platform.Anchored = true
        platform.CanCollide = true
        platform.Transparency = 1
        platform.CastShadow = false
        platform.Size = Vector3.new(18, 2, 18)
        platform.TopSurface = Enum.SurfaceType.Smooth
        platform.BottomSurface = Enum.SurfaceType.Smooth
        pcall(function()
            platform.CanQuery = false
        end)
        pcall(function()
            platform.CanTouch = false
        end)
        platform.Parent = workspace
    end
    local top = position.Y - feetDrop(humanoid, root)
    platform.CFrame = CFrame.new(position.X, top - (platform.Size.Y * 0.5) + 0.05, position.Z)
end

local function releaseFarmHold()
    if farmRoot and farmRoot.Parent then
        farmRoot.Anchored = false
    end
    farmRoot = nil
    clearPlatform()
end

local function holdFarmPosition()
    if not state.autoFarm then
        return
    end
    local _, _, root = getCharacter()
    if not root then
        return
    end
    if farmRoot and farmRoot ~= root and farmRoot.Parent then
        farmRoot.Anchored = false
    end
    local pos = Vector3.new(state.farmX, state.farmY, state.farmZ)
    local rotation = root.CFrame - root.CFrame.Position
    root.AssemblyLinearVelocity = Vector3.zero
    root.AssemblyAngularVelocity = Vector3.zero
    root.CFrame = CFrame.new(pos) * rotation
    if pos.Y >= HIGH_FARM_Y then
        root.Anchored = true
        farmRoot = root
    elseif farmRoot == root then
        root.Anchored = false
        farmRoot = nil
    end
end

local function equipTool()
    local character = LocalPlayer.Character
    if not character then
        return nil
    end
    local tool = character:FindFirstChildOfClass("Tool")
    if tool then
        return tool
    end
    local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not backpack or not humanoid then
        return nil
    end
    tool = backpack:FindFirstChildOfClass("Tool")
    if tool then
        pcall(function()
            humanoid:EquipTool(tool)
        end)
    end
    return character:FindFirstChildOfClass("Tool")
end

local mouseHeld = false

local function setMouseHeld(held)
    if held == mouseHeld then
        return
    end
    mouseHeld = held
    task.defer(function()
        if not isCurrent() and held then
            return
        end
        if held then
            if type(mouse1press) == "function" then
                pcall(mouse1press)
            elseif type(mouse1click) == "function" then
                pcall(mouse1click)
            end
        elseif type(mouse1release) == "function" then
            pcall(mouse1release)
        end
    end)
end

local function attackOnce(part)
    local tool = equipTool()
    local goal = part and part.Parent and part.Position or camera.CFrame.Position
    local origin = camera.CFrame.Position
    if tool then
        pcall(function()
            tool:Activate()
        end)
        for _, inst in ipairs(tool:GetDescendants()) do
            if inst:IsA("RemoteEvent") or inst:IsA("UnreliableRemoteEvent") then
                pcall(function()
                    inst:FireServer(goal)
                end)
                pcall(function()
                    inst:FireServer(part, goal)
                end)
                pcall(function()
                    inst:FireServer(origin, goal)
                end)
            end
        end
    end
    task.defer(function()
        if not isCurrent() or not part or not part.Parent then
            return
        end
        local point, onScreen = camera:WorldToViewportPoint(part.Position)
        if not onScreen or point.Z <= 0 then
            return
        end
        if state.panelOpen and panel then
            local pos = panel.AbsolutePosition
            local size = panel.AbsoluteSize
            if point.X >= pos.X and point.X <= pos.X + size.X and point.Y >= pos.Y and point.Y <= pos.Y + size.Y then
                return
            end
        end
        if type(mousemoverel) ~= "function" then
            return
        end
        local location = UserInputService:GetMouseLocation()
        pcall(mousemoverel, point.X - location.X, point.Y - location.Y)
    end)
end

local function aimPartOf(model, humanoid)
    if humanoid and humanoid.RootPart and humanoid.RootPart:IsA("BasePart") then
        local head = model and model:FindFirstChild("Head", true)
        if head and head:IsA("BasePart") then
            return head
        end
        return humanoid.RootPart
    end
    if not model then
        return nil
    end
    local names = { "Head", "UpperTorso", "Torso", "HumanoidRootPart", "Hitbox" }
    for _, name in ipairs(names) do
        local part = model:FindFirstChild(name, true)
        if part and part:IsA("BasePart") then
            return part
        end
    end
    if model:IsA("Model") and model.PrimaryPart and model.PrimaryPart:IsA("BasePart") then
        return model.PrimaryPart
    end
    if model:IsA("Model") then
        return model:FindFirstChildWhichIsA("BasePart", true)
    end
    if model:IsA("BasePart") then
        return model
    end
    return nil
end

local function modelHumanoid(model)
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if humanoid then
        return humanoid
    end
    return model:FindFirstChildWhichIsA("Humanoid", true)
end

local function isCharacterRig(model, humanoid)
    if not model or not model:IsA("Model") or not humanoid or humanoid.Health <= 0 then
        return false
    end
    if not humanoid:IsDescendantOf(model) then
        return false
    end
    if not aimPartOf(model, humanoid) then
        return false
    end
    local ok, _, size = pcall(function()
        return model:GetBoundingBox()
    end)
    if ok and typeof(size) == "Vector3" then
        local longest = math.max(size.X, size.Y, size.Z)
        if longest > 140 then
            local root = humanoid.RootPart
            if not (root and root:IsA("BasePart") and math.max(root.Size.X, root.Size.Y, root.Size.Z) <= 50) then
                return false
            end
        end
    end
    return true
end

local function isAliveModel(model, humanoid)
    if humanoid then
        return humanoid.Health > 0
    end
    for _, name in ipairs({ "Health", "HP", "health" }) do
        local health = model:FindFirstChild(name)
        if health and (health:IsA("NumberValue") or health:IsA("IntValue")) then
            return health.Value > 0
        end
    end
    return true
end

local function refreshTargets()
    local players = {}
    local monkeys = {}
    local namedCount = 0
    local function remember(bucket, key, part, named, humanoid, title)
        if bucket[key] or not part then
            return
        end
        bucket[key] = {
            part = part,
            model = key,
            named = named and true or false,
            humanoid = humanoid,
            title = title or key.Name,
        }
        if named then
            namedCount = namedCount + 1
        end
    end
    local function consider(model)
        if not model or not model:IsA("Model") or players[model] or monkeys[model] then
            return
        end
        local character = LocalPlayer.Character
        if character and (model == character or model:IsDescendantOf(character)) then
            return
        end
        local humanoid = modelHumanoid(model)
        local owner = Players:GetPlayerFromCharacter(model)
        if owner == LocalPlayer then
            return
        end
        if not isCharacterRig(model, humanoid) then
            return
        end
        if owner then
            local title = owner.DisplayName
            if type(title) ~= "string" or title == "" then
                title = owner.Name
            end
            remember(players, model, aimPartOf(model, humanoid), false, humanoid, title)
            return
        end
        remember(monkeys, model, aimPartOf(model, humanoid), true, humanoid, model.Name)
    end

    for _, inst in ipairs(workspace:GetDescendants()) do
        if inst:IsA("Humanoid") then
            local model = inst:FindFirstAncestorOfClass("Model")
            if model then
                consider(model)
            end
        end
    end

    local monkeyList = {}
    local monkeyEsp = {}
    for _, entry in pairs(monkeys) do
        monkeyList[#monkeyList + 1] = entry.part
        monkeyEsp[#monkeyEsp + 1] = entry
    end
    local playerList = {}
    local playerEsp = {}
    for _, entry in pairs(players) do
        playerList[#playerList + 1] = entry.part
        playerEsp[#playerEsp + 1] = entry
    end
    targetCache.players = playerList
    targetCache.monkeys = monkeyList
    targetCache.playerEsp = playerEsp
    targetCache.monkeyEsp = monkeyEsp
end

local function closestInList(parts)
    local _, _, root = getCharacter()
    local origin = root and root.Position or camera.CFrame.Position
    local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    local bestPart = nil
    local bestPoint = nil
    local bestScreen = state.fovRadius
    local nearestPart = nil
    local nearestPoint = nil
    local nearestDistance = 900
    for _, part in ipairs(parts) do
        if part and part.Parent then
            local worldDistance = (part.Position - origin).Magnitude
            local point, onScreen = camera:WorldToViewportPoint(part.Position)
            local screenPoint = Vector2.new(point.X, point.Y)
            if worldDistance < nearestDistance then
                nearestDistance = worldDistance
                nearestPart = part
                nearestPoint = screenPoint
            end
            if onScreen and point.Z > 0 then
                local distance = (screenPoint - center).Magnitude
                if distance <= bestScreen then
                    bestScreen = distance
                    bestPart = part
                    bestPoint = screenPoint
                end
            end
        end
    end
    if bestPart then
        return bestPart, bestPoint, bestScreen, true
    end
    if nearestPart then
        return nearestPart, nearestPoint, nearestDistance, false
    end
    return nil, nil, nil, false
end

local function getClosestTarget()
    if not camera then
        return nil, nil, nil
    end
    local aimOn = state.playerAim or state.monkeyAim
    local pools = {}
    if state.playerAim or (state.autoFire and not aimOn) then
        pools[#pools + 1] = {
            parts = targetCache.players,
            mode = state.playerAimMode,
            aim = state.playerAim,
        }
    end
    if state.monkeyAim or (state.autoFire and not aimOn) then
        pools[#pools + 1] = {
            parts = targetCache.monkeys,
            mode = state.monkeyAimMode,
            aim = state.monkeyAim,
        }
    end
    local winner = nil
    for _, pool in ipairs(pools) do
        local part, screenPoint, distance, inFov = closestInList(pool.parts)
        if part then
            local candidate = {
                part = part,
                screenPoint = screenPoint,
                distance = distance or 9999,
                inFov = inFov,
                mode = pool.mode,
                aim = pool.aim,
            }
            if not winner then
                winner = candidate
            elseif candidate.inFov and not winner.inFov then
                winner = candidate
            elseif candidate.inFov == winner.inFov and candidate.distance < winner.distance then
                winner = candidate
            end
        end
    end
    if not winner then
        return nil, nil, nil
    end
    return winner.part, winner.screenPoint, winner.aim and winner.mode or nil
end

local baseWalkSpeed = setmetatable({}, { __mode = "k" })
local function applyWalkSpeed()
    local _, humanoid = getCharacter()
    if not humanoid then
        return
    end
    if state.speedHack then
        if baseWalkSpeed[humanoid] == nil then
            baseWalkSpeed[humanoid] = humanoid.WalkSpeed
        end
        humanoid.WalkSpeed = state.walkSpeed
    elseif baseWalkSpeed[humanoid] ~= nil then
        humanoid.WalkSpeed = baseWalkSpeed[humanoid]
        baseWalkSpeed[humanoid] = nil
    end
end

local originalLighting = nil
local function setFullBright(enabled)
    if enabled then
        if not originalLighting then
            originalLighting = {
                Brightness = Lighting.Brightness,
                ClockTime = Lighting.ClockTime,
                GlobalShadows = Lighting.GlobalShadows,
                Ambient = Lighting.Ambient,
                OutdoorAmbient = Lighting.OutdoorAmbient,
                FogEnd = Lighting.FogEnd,
            }
        end
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.fromRGB(180, 180, 180)
        Lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 180)
        Lighting.FogEnd = 100000
    elseif originalLighting then
        Lighting.Brightness = originalLighting.Brightness
        Lighting.ClockTime = originalLighting.ClockTime
        Lighting.GlobalShadows = originalLighting.GlobalShadows
        Lighting.Ambient = originalLighting.Ambient
        Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
        Lighting.FogEnd = originalLighting.FogEnd
        originalLighting = nil
    end
end

local collisionStore = setmetatable({}, { __mode = "k" })
local function setNoclip(enabled)
    state.noclip = enabled
    local character = LocalPlayer.Character
    if not character then
        return
    end
    if enabled then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                if collisionStore[part] == nil then
                    collisionStore[part] = part.CanCollide
                end
                part.CanCollide = false
            end
        end
    else
        for part, value in pairs(collisionStore) do
            if part.Parent then
                part.CanCollide = value
            end
        end
        collisionStore = setmetatable({}, { __mode = "k" })
    end
end

local flyObjects = {
    velocity = nil,
    gyro = nil,
    root = nil,
}

local function clearFly()
    if flyObjects.velocity then
        flyObjects.velocity:Destroy()
    end
    if flyObjects.gyro then
        flyObjects.gyro:Destroy()
    end
    flyObjects.velocity = nil
    flyObjects.gyro = nil
    flyObjects.root = nil
end

local function ensureFly(root)
    if not camera then
        return
    end
    if flyObjects.root == root and flyObjects.velocity and flyObjects.velocity.Parent == root then
        return
    end
    clearFly()
    local velocity = Instance.new("BodyVelocity")
    velocity.Name = "AHST_FLY_VELOCITY"
    velocity.MaxForce = Vector3.new(100000, 100000, 100000)
    velocity.Velocity = Vector3.zero
    velocity.Parent = root
    local gyro = Instance.new("BodyGyro")
    gyro.Name = "AHST_FLY_GYRO"
    gyro.MaxTorque = Vector3.new(100000, 100000, 100000)
    gyro.P = 3000
    gyro.D = 100
    gyro.CFrame = camera.CFrame
    gyro.Parent = root
    flyObjects.velocity = velocity
    flyObjects.gyro = gyro
    flyObjects.root = root
end

local function setFly(enabled)
    state.fly = enabled
    if not enabled then
        clearFly()
        local _, humanoid = getCharacter()
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
end

local function teleportToFarm()
    local _, _, root = getCharacter()
    if not root then
        setStatus("Aparece primero")
        return
    end
    root.CFrame = CFrame.new(state.farmX, state.farmY, state.farmZ)
    setStatus(string.format("Teletransportado a %.0f, %.0f, %.0f", state.farmX, state.farmY, state.farmZ))
end

local function resetCharacter()
    local _, humanoid = getCharacter()
    if humanoid then
        humanoid.Health = 0
        setStatus("Personaje reiniciado")
    else
        setStatus("Aparece primero")
    end
end

local function rejoinServer()
    setStatus("Volviendo al servidor...")
    pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end)
end

local function copyDiscord()
    local ok = pcall(function()
        if type(setclipboard) == "function" then
            setclipboard(DISCORD_INVITE)
        elseif type(toclipboard) == "function" then
            toclipboard(DISCORD_INVITE)
        else
            error("clipboard unavailable")
        end
    end)
    if ok then
        setStatus("Invitación copiada")
    else
        setStatus("Sin portapapeles")
    end
end

local rebuildActiveTab

local function addSection(parent, titleText)
    local section = create("Frame", {
        Name = "Section_" .. titleText,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = nextLayoutOrder(parent),
        Parent = parent,
    })
    create("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = section,
    })
    addSectionTitle(section, titleText)
    return section
end

local function addLabel(parent, text, height)
    local card = addCard(parent, height or 44)
    create("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(12, 0),
        Size = UDim2.new(1, -24, 1, 0),
        Font = Enum.Font.GothamMedium,
        Text = text,
        TextSize = 12,
        TextColor3 = THEME.muted,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextWrapped = true,
        Parent = card,
    })
    return card
end

local espGui = create("ScreenGui", {
    Name = "AHST_ESP",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 50,
    Parent = PlayerGui,
})
local espSlots = {}
local ESP_BONES = {
    { "Head", "UpperTorso" },
    { "UpperTorso", "LowerTorso" },
    { "UpperTorso", "LeftUpperArm" },
    { "LeftUpperArm", "LeftLowerArm" },
    { "LeftLowerArm", "LeftHand" },
    { "UpperTorso", "RightUpperArm" },
    { "RightUpperArm", "RightLowerArm" },
    { "RightLowerArm", "RightHand" },
    { "LowerTorso", "LeftUpperLeg" },
    { "LeftUpperLeg", "LeftLowerLeg" },
    { "LeftLowerLeg", "LeftFoot" },
    { "LowerTorso", "RightUpperLeg" },
    { "RightUpperLeg", "RightLowerLeg" },
    { "RightLowerLeg", "RightFoot" },
    { "Head", "Torso" },
    { "Torso", "Left Arm" },
    { "Torso", "Right Arm" },
    { "Torso", "Left Leg" },
    { "Torso", "Right Leg" },
}

local function espLine()
    local line = create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = THEME.white,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 2,
        Parent = espGui,
    })
    return line
end

local function espSlot()
    local lines = {}
    for index = 1, 24 do
        lines[index] = espLine()
    end
    local label = create("TextLabel", {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 1),
        Size = UDim2.fromOffset(180, 48),
        Font = Enum.Font.GothamBold,
        Text = "",
        TextSize = 13,
        TextColor3 = THEME.white,
        TextStrokeTransparency = 0.35,
        TextStrokeColor3 = THEME.bg,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Bottom,
        Visible = false,
        ZIndex = 3,
        Parent = espGui,
    })
    return {
        lines = lines,
        label = label,
    }
end

local function hideSlot(slot)
    for _, line in ipairs(slot.lines) do
        line.Visible = false
    end
    slot.label.Visible = false
end

local function placeLine(line, from, to, color)
    if not line or not from or not to then
        if line then
            line.Visible = false
        end
        return
    end
    local delta = to - from
    local length = delta.Magnitude
    if length < 2 then
        line.Visible = false
        return
    end
    line.Visible = true
    line.BackgroundColor3 = color
    line.Size = UDim2.fromOffset(length, 1.5)
    line.Position = UDim2.fromOffset((from.X + to.X) * 0.5, (from.Y + to.Y) * 0.5)
    line.Rotation = math.deg(math.atan2(delta.Y, delta.X))
end

local function screenPoint(world)
    if not camera then
        return nil
    end
    local point = camera:WorldToViewportPoint(world)
    if point.Z <= 0 then
        return nil
    end
    return Vector2.new(point.X, point.Y)
end

local function findBone(model, name)
    if not model then
        return nil
    end
    if model:IsA("BasePart") then
        if model.Name == name then
            return model
        end
        return nil
    end
    local inst = model:FindFirstChild(name, true)
    if inst and inst:IsA("BasePart") then
        return inst
    end
    return nil
end

local function modelBounds(model, part)
    if model and model:IsA("Model") then
        local ok, cf, size = pcall(function()
            return model:GetBoundingBox()
        end)
        if ok and typeof(cf) == "CFrame" and typeof(size) == "Vector3" then
            local longest = math.max(size.X, size.Y, size.Z)
            if longest <= 140 then
                return cf, size
            end
        end
    end
    if part and part:IsA("BasePart") then
        return part.CFrame, part.Size
    end
    return nil, nil
end

local function boxCorners(cf, size)
    local hx = size.X * 0.5
    local hy = size.Y * 0.5
    local hz = size.Z * 0.5
    return {
        (cf * CFrame.new(-hx, -hy, -hz)).Position,
        (cf * CFrame.new(hx, -hy, -hz)).Position,
        (cf * CFrame.new(-hx, hy, -hz)).Position,
        (cf * CFrame.new(hx, hy, -hz)).Position,
        (cf * CFrame.new(-hx, -hy, hz)).Position,
        (cf * CFrame.new(hx, -hy, hz)).Position,
        (cf * CFrame.new(-hx, hy, hz)).Position,
        (cf * CFrame.new(hx, hy, hz)).Position,
    }
end

local function healthText(entry)
    local humanoid = entry.humanoid
    if humanoid and humanoid.Parent then
        return string.format("%d/%d", math.floor(humanoid.Health + 0.5), math.floor(humanoid.MaxHealth + 0.5))
    end
    local model = entry.model
    if model then
        for _, name in ipairs({ "Health", "HP", "health" }) do
            local health = model:FindFirstChild(name)
            if health and (health:IsA("NumberValue") or health:IsA("IntValue")) then
                return tostring(math.floor(health.Value + 0.5))
            end
        end
    end
    return nil
end

local function updateEsp()
    local options = state.espOptions
    local active = state.playerEsp or state.monkeyEsp
    local anyPart = options.box or options.tracer or options.skeleton or options.name or options.health or options.distance
    if not active or not anyPart or not camera then
        for _, slot in ipairs(espSlots) do
            hideSlot(slot)
        end
        return
    end
    local list = {}
    if state.playerEsp then
        for _, entry in ipairs(targetCache.playerEsp or {}) do
            entry.color = THEME.white
            list[#list + 1] = entry
        end
    end
    if state.monkeyEsp then
        for _, entry in ipairs(targetCache.monkeyEsp or {}) do
            entry.color = THEME.accent
            list[#list + 1] = entry
        end
    end
    local _, _, root = getCharacter()
    local origin = root and root.Position or camera.CFrame.Position
    local used = 0
    local viewport = camera.ViewportSize
    local tracerFrom = Vector2.new(viewport.X * 0.5, viewport.Y - 4)
    for _, entry in ipairs(list) do
        if used >= 40 then
            break
        end
        local part = entry.part
        local model = entry.model
        if part and part.Parent and model and model.Parent then
            local cf, size = modelBounds(model, part)
            local minX, minY, maxX, maxY
            if cf and size then
                for _, corner in ipairs(boxCorners(cf, size)) do
                    local point = screenPoint(corner)
                    if point then
                        minX = minX and math.min(minX, point.X) or point.X
                        minY = minY and math.min(minY, point.Y) or point.Y
                        maxX = maxX and math.max(maxX, point.X) or point.X
                        maxY = maxY and math.max(maxY, point.Y) or point.Y
                    end
                end
            end
            local anchor = screenPoint(part.Position)
            if not minX and anchor and part:IsA("BasePart") then
                local distance = (part.Position - origin).Magnitude
                local half = math.clamp(420 / math.max(distance, 4), 14, 90)
                minX = anchor.X - half * 0.7
                maxX = anchor.X + half * 0.7
                minY = anchor.Y - half
                maxY = anchor.Y + half * 0.8
            end
            if minX and anchor then
                used = used + 1
                local slot = espSlots[used]
                if not slot then
                    slot = espSlot()
                    espSlots[used] = slot
                end
                local color = entry.color or THEME.white
                local cursor = 1
                local function takeLine()
                    if cursor > #slot.lines then
                        return nil
                    end
                    local line = slot.lines[cursor]
                    cursor = cursor + 1
                    return line
                end
                if options.box then
                    local a = Vector2.new(minX, minY)
                    local b = Vector2.new(maxX, minY)
                    local c = Vector2.new(maxX, maxY)
                    local d = Vector2.new(minX, maxY)
                    placeLine(takeLine(), a, b, color)
                    placeLine(takeLine(), b, c, color)
                    placeLine(takeLine(), c, d, color)
                    placeLine(takeLine(), d, a, color)
                end
                if options.tracer then
                    placeLine(takeLine(), tracerFrom, Vector2.new((minX + maxX) * 0.5, maxY), color)
                end
                if options.skeleton and model:IsA("Model") then
                    for _, bone in ipairs(ESP_BONES) do
                        if cursor > #slot.lines then
                            break
                        end
                        local first = findBone(model, bone[1])
                        local second = findBone(model, bone[2])
                        if first and second then
                            placeLine(takeLine(), screenPoint(first.Position), screenPoint(second.Position), color)
                        end
                    end
                end
                while cursor <= #slot.lines do
                    slot.lines[cursor].Visible = false
                    cursor = cursor + 1
                end
                local lines = {}
                if options.name then
                    lines[#lines + 1] = entry.title or "Objetivo"
                end
                if options.health then
                    local health = healthText(entry)
                    if health then
                        lines[#lines + 1] = "Vida " .. health
                    end
                end
                if options.distance then
                    lines[#lines + 1] = string.format("%d m", math.floor((part.Position - origin).Magnitude + 0.5))
                end
                if #lines > 0 then
                    slot.label.Visible = true
                    slot.label.Text = table.concat(lines, "\n")
                    slot.label.TextColor3 = color
                    slot.label.Position = UDim2.fromOffset((minX + maxX) * 0.5, minY - 4)
                else
                    slot.label.Visible = false
                end
            end
        end
    end
    for index = used + 1, #espSlots do
        hideSlot(espSlots[index])
    end
end

local function clearEsp()
    for _, slot in ipairs(espSlots) do
        for _, line in ipairs(slot.lines) do
            line:Destroy()
        end
        slot.label:Destroy()
    end
    espSlots = {}
    if espGui then
        espGui:Destroy()
    end
end

RunService.RenderStepped:Connect(function()
    if not isCurrent() then
        return
    end
    updateEsp()
end)

local builders = {}

builders[1] = function(page)
    local farm = addSection(page, "AUTO FARMEO")
    addToggle(farm, "Auto farmeo", state.autoFarm, function(value)
        state.autoFarm = value
        if value then
            state.monkeyAim = true
            state.autoFire = true
            state.farmLinkedCombat = true
            teleportToFarm()
            setStatus("Auto farmeo activado")
        else
            if state.farmLinkedCombat then
                state.monkeyAim = false
                state.autoFire = false
                state.farmLinkedCombat = false
            end
            releaseFarmHold()
            setStatus("Auto farmeo apagado")
        end
    end)
    addSlider(farm, "Eje X", -1000, 1000, state.farmX, function(value)
        return string.format("%.0f", value)
    end, function(value)
        state.farmX = math.floor(value)
    end)
    addSlider(farm, "Eje Y", 0, 1000, state.farmY, function(value)
        return string.format("%.0f", value)
    end, function(value)
        state.farmY = math.floor(value)
    end)
    addSlider(farm, "Eje Z", -1000, 1000, state.farmZ, function(value)
        return string.format("%.0f", value)
    end, function(value)
        state.farmZ = math.floor(value)
    end)
    addButton(farm, "Teletransportar", teleportToFarm)
    addButton(farm, "Usar posición actual", function()
        local _, _, root = getCharacter()
        if not root then
            setStatus("Aparece primero")
            return
        end
        local position = root.Position
        state.farmX = math.floor(position.X)
        state.farmY = math.floor(position.Y)
        state.farmZ = math.floor(position.Z)
        setStatus("Posición guardada")
        task.defer(function()
            if rebuildActiveTab then
                rebuildActiveTab()
            end
        end)
    end)

    local utility = addSection(page, "UTILIDAD")
    addToggle(utility, "Anti-AFK", state.antiAfk, function(value)
        state.antiAfk = value
        setStatus(value and "Anti-AFK activado" or "Anti-AFK apagado")
    end)
    addButton(utility, "Volver al servidor", rejoinServer)
    addButton(utility, "Reiniciar personaje", resetCharacter)
end

builders[2] = function(page)
    local function addAimLock(section, modeKey)
        addChoice(section, "Apuntado", {
            { id = "both", label = "Cuerpo + cam" },
            { id = "camera", label = "Cámara" },
            { id = "body", label = "Cuerpo" },
        }, state[modeKey], function(mode)
            state[modeKey] = mode
            if mode == "both" then
                setStatus("Cuerpo y cámara")
            elseif mode == "camera" then
                setStatus("Solo cámara")
            else
                setStatus("Solo cuerpo")
            end
        end)
    end

    local players = addSection(page, "JUGADORES")
    addToggle(players, "Apuntado", state.playerAim, function(value)
        state.playerAim = value
        setStatus(value and "Jugadores activado" or "Jugadores apagado")
    end)
    addAimLock(players, "playerAimMode")

    local monkeys = addSection(page, "MONOS")
    addToggle(monkeys, "Apuntado", state.monkeyAim, function(value)
        state.monkeyAim = value
        if not value then
            state.farmLinkedCombat = false
        end
        setStatus(value and "Monos activado" or "Monos apagado")
    end)
    addAimLock(monkeys, "monkeyAimMode")

    local aim = addSection(page, "DISPARO")
    addToggle(aim, "Disparo automático", state.autoFire, function(value)
        state.autoFire = value
        if not value then
            state.farmLinkedCombat = false
        end
        setStatus(value and "Disparo activado" or "Disparo apagado")
    end)
    addSlider(aim, "Radio FOV", 60, 800, state.fovRadius, function(value)
        return string.format("%.0f px", value)
    end, function(value)
        state.fovRadius = value
        updateFovCircle()
    end)
    addSlider(aim, "Suavidad", 0.05, 1, state.smoothness, function(value)
        return string.format("%d%%", math.floor(value * 100 + 0.5))
    end, function(value)
        state.smoothness = value
    end)
    addToggle(aim, "Ver círculo FOV", state.showFov, function(value)
        state.showFov = value
        updateFovCircle()
        setStatus(value and "Círculo FOV activado" or "Círculo FOV apagado")
    end)
end

builders[3] = function(page)
    local movement = addSection(page, "MOVIMIENTO")
    addToggle(movement, "Velocidad", state.speedHack, function(value)
        state.speedHack = value
        applyWalkSpeed()
        setStatus(value and "Velocidad activada" or "Velocidad apagada")
    end)
    addSlider(movement, "Velocidad al andar", 16, 200, state.walkSpeed, function(value)
        return string.format("%.0f", value)
    end, function(value)
        state.walkSpeed = math.floor(value)
        if state.speedHack then
            applyWalkSpeed()
        end
    end)
    addToggle(movement, "Salto infinito", state.infiniteJump, function(value)
        state.infiniteJump = value
        setStatus(value and "Salto infinito activado" or "Salto infinito apagado")
    end)
    addToggle(movement, "Atravesar paredes", state.noclip, function(value)
        setNoclip(value)
        setStatus(value and "Atravesar activado" or "Atravesar apagado")
    end)

    local flight = addSection(page, "VUELO")
    addToggle(flight, "Volar", state.fly, function(value)
        setFly(value)
        setStatus(value and "Vuelo activado" or "Vuelo apagado")
    end)
    addSlider(flight, "Velocidad de vuelo", 20, 300, state.flySpeed, function(value)
        return string.format("%.0f", value)
    end, function(value)
        state.flySpeed = value
    end)
    addButton(flight, "Reiniciar personaje", resetCharacter)
end

builders[4] = function(page)
    local lighting = addSection(page, "LUZ")
    addToggle(lighting, "Brillo total", state.fullBright, function(value)
        state.fullBright = value
        setFullBright(value)
        setStatus(value and "Brillo activado" or "Brillo apagado")
    end)

    local cameraSection = addSection(page, "CÁMARA")
    addSlider(cameraSection, "FOV de cámara", 50, 120, state.cameraFov, function(value)
        return string.format("%.0f", value)
    end, function(value)
        state.cameraFov = value
        if camera then
            camera.FieldOfView = value
        end
    end)
    addToggle(cameraSection, "Ver círculo FOV", state.showFov, function(value)
        state.showFov = value
        updateFovCircle()
        setStatus(value and "Círculo FOV activado" or "Círculo FOV apagado")
    end)

    local esp = addSection(page, "ESP")
    addToggle(esp, "Jugadores", state.playerEsp, function(value)
        state.playerEsp = value
        setStatus(value and "ESP jugadores activado" or "ESP jugadores apagado")
    end)
    addToggle(esp, "Monos", state.monkeyEsp, function(value)
        state.monkeyEsp = value
        setStatus(value and "ESP monos activado" or "ESP monos apagado")
    end)
    addMulti(esp, "Elementos", {
        { id = "box", label = "Caja" },
        { id = "tracer", label = "Líneas" },
        { id = "skeleton", label = "Esqueleto" },
        { id = "name", label = "Nombre" },
        { id = "health", label = "Salud" },
        { id = "distance", label = "Distancia" },
    }, state.espOptions, function(id, enabled)
        state.espOptions[id] = enabled
    end)
end

builders[5] = function(page)
    local discord = addSection(page, "DISCORD")
    addButton(discord, "Copiar invitación", copyDiscord)
    addButton(discord, "Abrir Discord", openDiscord)
    addLabel(discord, DISCORD_INVITE, 36)

    local about = addSection(page, "INFO")
    addButton(about, "Quitar script", function()
        state.speedHack = false
        state.autoFire = false
        state.playerAim = false
        state.monkeyAim = false
        state.autoFarm = false
        state.playerEsp = false
        state.monkeyEsp = false
        setMouseHeld(false)
        releaseFarmHold()
        applyWalkSpeed()
        setNoclip(false)
        setFly(false)
        setFullBright(false)
        clearPlatform()
        pcall(function()
            RunService:UnbindFromRenderStep("AHST_AIMLOCK")
        end)
        state.cameraFov = originalCameraFov
        if camera then
            camera.FieldOfView = originalCameraFov
        end
        shared.AHST_GENERATION = (shared.AHST_GENERATION or 0) + 1
        gui:Destroy()
        fovGui:Destroy()
        clearEsp()
    end)
end

local tabNames = {"PRINCIPAL", "COMBATE", "MOVIMIENTO", "VISUAL", "COMUNIDAD"}
local tabWidths = {88, 78, 108, 70, 100}
local tabButtons = {}
local setTab

for index, name in ipairs(tabNames) do
    local button = create("TextButton", {
        Name = name,
        Size = UDim2.fromOffset(tabWidths[index], 28),
        BackgroundColor3 = index == 1 and THEME.accent or THEME.surface,
        BackgroundTransparency = index == 1 and 0.1 or 0.25,
        BorderSizePixel = 0,
        Font = Enum.Font.GothamBold,
        Text = name,
        TextSize = 10,
        TextColor3 = index == 1 and THEME.white or THEME.muted,
        AutoButtonColor = false,
        LayoutOrder = index,
        Parent = tabScroll,
    })
    addCorner(button, 7)
    tabButtons[index] = button
    bindClick(button, function()
        if setTab then
            setTab(index)
        end
    end)
end

local currentPage = nil
local function newPage()
    if currentPage then
        currentPage:Destroy()
    end
    currentPage = create("Frame", {
        Name = "Page",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Parent = content,
    })
    create("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        Padding = UDim.new(0, 14),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = currentPage,
    })
    return currentPage
end

setTab = function(index)
    if not builders[index] then
        return
    end
    state.activeTab = index
    for i, button in ipairs(tabButtons) do
        local active = i == index
        button.BackgroundColor3 = active and THEME.accent or THEME.surface
        button.BackgroundTransparency = active and 0.1 or 0.25
        button.TextColor3 = active and THEME.white or THEME.muted
    end
    content.CanvasPosition = Vector2.zero
    activeSlider = nil
    content.ScrollingEnabled = true
    builders[index](newPage())
end

rebuildActiveTab = function()
    if isCurrent() and setTab then
        setTab(state.activeTab)
    end
end

setPanel = function(open)
    state.panelOpen = open
    panel.Visible = open
end

setMinimized = function(minimized)
    state.minimized = minimized
    if minimized then
        panel.Size = UDim2.fromOffset(PANEL_WIDTH, HEADER_HEIGHT)
        tabBar.Visible = false
        content.Visible = false
        separator.Visible = false
        minButton.Text = "+"
    else
        panel.Size = UDim2.fromOffset(PANEL_WIDTH, PANEL_HEIGHT)
        tabBar.Visible = true
        content.Visible = true
        separator.Visible = true
        minButton.Text = "-"
    end
end

local fabX = clamp(safeWidth - FAB_SIZE - 18, 0, math.max(0, safeWidth - FAB_SIZE))
local fabY = clamp(90, 0, math.max(0, safeHeight - FAB_SIZE))

local fab = create("CanvasGroup", {
    Name = "MonkeyButton",
    AnchorPoint = Vector2.new(0, 0),
    Position = UDim2.fromOffset(fabX, fabY),
    Size = UDim2.fromOffset(FAB_SIZE, FAB_SIZE),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    GroupTransparency = 0,
    ZIndex = 50,
    Parent = gui,
})
addCorner(fab, FAB_SIZE / 2)
addStroke(fab, THEME.accent, 1, 0.25)
local fabImage = create("ImageButton", {
    Name = "Icon",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = THEME.bg,
    BorderSizePixel = 0,
    Image = FAB_IMAGE_URL,
    ScaleType = Enum.ScaleType.Crop,
    AutoButtonColor = false,
    ZIndex = 51,
    Parent = fab,
})

local dragState = nil

local function getBounds()
    local size = gui.AbsoluteSize
    if size.X > 0 and size.Y > 0 then
        return size
    end
    return getViewport()
end

local function pointerPosition(input)
    if input and input.UserInputType == Enum.UserInputType.Touch then
        return Vector2.new(input.Position.X, input.Position.Y)
    end
    return UserInputService:GetMouseLocation()
end

local function beginDrag(target, kind, input)
    local inputType = input.UserInputType
    if inputType ~= Enum.UserInputType.MouseButton1 and inputType ~= Enum.UserInputType.Touch then
        return
    end
    dragState = {
        target = target,
        kind = kind,
        input = input,
        inputType = inputType,
        startPointer = pointerPosition(input),
        startPosition = Vector2.new(target.Position.X.Offset, target.Position.Y.Offset),
        moved = false,
    }
end

dragArea.InputBegan:Connect(function(input)
    beginDrag(panel, "panel", input)
end)

fabImage.InputBegan:Connect(function(input)
    beginDrag(fab, "fab", input)
end)

UserInputService.InputChanged:Connect(function(input)
    if not isCurrent() or not dragState then
        return
    end
    if dragState.inputType == Enum.UserInputType.Touch then
        if input ~= dragState.input then
            return
        end
    elseif input.UserInputType ~= Enum.UserInputType.MouseMovement then
        return
    end
    if dragState.inputType == Enum.UserInputType.MouseButton1
        and not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        dragState = nil
        return
    end

    local pointer = pointerPosition(input)
    local delta = pointer - dragState.startPointer
    if not dragState.moved and delta.Magnitude >= 4 then
        dragState.moved = true
    end
    if not dragState.moved then
        return
    end

    local target = dragState.target
    local viewportSize = getBounds()
    local maxX = math.max(0, viewportSize.X - target.AbsoluteSize.X)
    local maxY = math.max(0, viewportSize.Y - target.AbsoluteSize.Y)
    local x = clamp(dragState.startPosition.X + delta.X, 0, maxX)
    local y = clamp(dragState.startPosition.Y + delta.Y, 0, maxY)
    target.Position = UDim2.fromOffset(x, y)
end)

UserInputService.InputEnded:Connect(function(input)
    if not dragState then
        return
    end
    if dragState.inputType == Enum.UserInputType.Touch then
        if input ~= dragState.input then
            return
        end
    elseif input.UserInputType ~= Enum.UserInputType.MouseButton1 then
        return
    end

    local wasFab = dragState.kind == "fab"
    local moved = dragState.moved
    dragState = nil
    if wasFab and not moved then
        setPanel(not state.panelOpen)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not isCurrent() or not activeSlider then
        return
    end
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            activeSlider = nil
            content.ScrollingEnabled = true
            return
        end
        activeSlider.updateFromX(pointerPosition(input).X)
    elseif input.UserInputType == Enum.UserInputType.Touch then
        activeSlider.updateFromX(pointerPosition(input).X)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if not activeSlider then
        return
    end
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        activeSlider = nil
        content.ScrollingEnabled = true
    end
end)

UserInputService.InputBegan:Connect(function(input)
    if not isCurrent() then
        return
    end
    if input.KeyCode == Enum.KeyCode.RightShift then
        setPanel(not state.panelOpen)
    end
end)

UserInputService.WindowFocusReleased:Connect(function()
    dragState = nil
    activeSlider = nil
    content.ScrollingEnabled = true
end)

local fireClock = 0
pcall(function()
    RunService:UnbindFromRenderStep("AHST_AIMLOCK")
end)
RunService:BindToRenderStep("AHST_AIMLOCK", Enum.RenderPriority.Camera.Value + 1, function(dt)
    if not isCurrent() then
        setMouseHeld(false)
        return
    end
    if not (state.playerAim or state.monkeyAim or state.autoFire) then
        fireClock = 0
        setMouseHeld(false)
        return
    end
    local target, screenPoint, mode = getClosestTarget()
    if not target or not camera then
        fireClock = 0
        setMouseHeld(false)
        return
    end
    local aimPos = target.Position
    if mode == "camera" or mode == "both" then
        local origin = camera.CFrame.Position
        if (aimPos - origin).Magnitude > 0.1 then
            local goal = CFrame.lookAt(origin, aimPos)
            camera.CFrame = camera.CFrame:Lerp(goal, clamp(state.smoothness, 0.05, 1))
        end
    end
    if mode == "body" or mode == "both" then
        local _, _, root = getCharacter()
        if root then
            local pos = root.Position
            if state.autoFarm then
                pos = Vector3.new(state.farmX, state.farmY, state.farmZ)
            end
            local flat = Vector3.new(aimPos.X, pos.Y, aimPos.Z)
            if (flat - pos).Magnitude > 0.2 then
                local goal = CFrame.lookAt(pos, flat)
                root.CFrame = root.CFrame:Lerp(goal, clamp(state.smoothness, 0.05, 1))
                if state.autoFarm then
                    root.CFrame = CFrame.new(pos) * (root.CFrame - root.CFrame.Position)
                end
            elseif state.autoFarm then
                root.CFrame = CFrame.new(pos) * (root.CFrame - root.CFrame.Position)
            end
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
        end
    end
    if state.autoFire and target then
        fireClock = fireClock + dt
        if fireClock >= 0.15 then
            fireClock = 0
            attackOnce(target)
        end
        setMouseHeld(true)
    else
        fireClock = 0
        setMouseHeld(false)
    end
end)

RunService.RenderStepped:Connect(function()
    if not isCurrent() then
        return
    end
    if not state.fly then
        if flyObjects.velocity or flyObjects.gyro then
            clearFly()
        end
        return
    end
    if not camera then
        return
    end
    local _, humanoid, root = getCharacter()
    if not root then
        clearFly()
        return
    end
    ensureFly(root)
    if not flyObjects.velocity or not flyObjects.gyro then
        return
    end
    humanoid.PlatformStand = true
    local direction = Vector3.zero
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        direction = direction + camera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        direction = direction - camera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        direction = direction + camera.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        direction = direction - camera.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        direction = direction + Vector3.new(0, 1, 0)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        direction = direction - Vector3.new(0, 1, 0)
    end
    if direction.Magnitude > 0 then
        flyObjects.velocity.Velocity = direction.Unit * state.flySpeed
    else
        flyObjects.velocity.Velocity = Vector3.zero
    end
    flyObjects.gyro.CFrame = camera.CFrame
end)

RunService.Stepped:Connect(function()
    if not isCurrent() or not state.noclip then
        return
    end
    local character = LocalPlayer.Character
    if not character then
        return
    end
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            if collisionStore[part] == nil then
                collisionStore[part] = part.CanCollide
            end
            part.CanCollide = false
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not isCurrent() then
        return
    end
    local now = os.clock()
    if (state.autoFarm or state.playerAim or state.monkeyAim or state.autoFire or state.playerEsp or state.monkeyEsp) and now >= nextTargetScan then
        nextTargetScan = now + 0.5
        pcall(refreshTargets)
    end
    if not state.autoFarm then
        if farmRoot or platform then
            releaseFarmHold()
        end
        return
    end
    holdFarmPosition()
end)

task.spawn(function()
    while isCurrent() do
        task.wait(0.5)
        if not isCurrent() then
            break
        end
        if state.speedHack then
            applyWalkSpeed()
        end
        if camera and math.abs(camera.FieldOfView - state.cameraFov) > 0.01 then
            camera.FieldOfView = state.cameraFov
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if not isCurrent() or not state.infiniteJump then
        return
    end
    local _, humanoid = getCharacter()
    if humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

LocalPlayer.Idled:Connect(function()
    if not isCurrent() or not state.antiAfk then
        return
    end
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new(0, 0))
    end)
end)

LocalPlayer.CharacterAdded:Connect(function()
    if not isCurrent() then
        return
    end
    task.wait(0.6)
    if not isCurrent() then
        return
    end
    if state.noclip then
        setNoclip(true)
    end
    if state.speedHack then
        applyWalkSpeed()
    end
    updateFovCircle()
end)

updateFovCircle()
setTab(1)
setPanel(true)
setMinimized(false)
setStatus("AHST")
task.spawn(function()
    local fabAsset = resolveImage(FAB_IMAGE_URL, "ahst_fab.jpg")
    local logoAsset = resolveImage(LOGO_IMAGE_URL, "ahst_logo.jpg")
    local discordAsset = resolveImage(DISCORD_IMAGE_URL, "ahst_discord.png")
    if not isCurrent() then
        return
    end
    if type(fabAsset) == "string" and string.sub(fabAsset, 1, 8) == "rbxasset" then
        fabImage.Image = fabAsset
    end
    if type(logoAsset) == "string" and string.sub(logoAsset, 1, 8) == "rbxasset" then
        logo.Image = logoAsset
    end
    if type(discordAsset) == "string" and string.sub(discordAsset, 1, 8) == "rbxasset" then
        discordIcon.Image = discordAsset
        discordButton.Text = ""
    end
end)
print("[AHST] AHST Monkeys Script cargado")

