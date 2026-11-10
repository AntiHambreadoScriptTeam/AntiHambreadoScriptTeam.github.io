local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local env = getgenv and getgenv() or _G

for _, key in ipairs({
    "MedvedCrateFarmCleanup",
    "AhstMedvedCleanup"
}) do
    if type(env[key]) == "function" then
        pcall(env[key])
        env[key] = nil
    end
end

for _, name in ipairs({
    "MedvedCrateFarmGui",
    "AhstMedved"
}) do
    local old = playerGui:FindFirstChild(name)
    if old then
        old:Destroy()
    end
end

local alive = true
local connections = {}
local visuals = {}

local settings = {
    bearESP = true,
    friendlyESP = true,
    trackers = true,
    range = 1000
}

local MIN_RANGE = 250
local MAX_RANGE = 2500
local RANGE_STEP = 250

local colors = {
    background = Color3.fromRGB(12, 14, 18),
    panel = Color3.fromRGB(21, 25, 32),
    track = Color3.fromRGB(52, 58, 70),
    muted = Color3.fromRGB(140, 150, 166),
    hostile = Color3.fromRGB(255, 115, 115),
    friendly = Color3.fromRGB(125, 235, 160),
    warning = Color3.fromRGB(255, 195, 105),
    dangerHover = Color3.fromRGB(60, 34, 38)
}

local defaultTheme = {
    accent = Color3.fromRGB(115, 185, 255),
    button = Color3.fromRGB(30, 35, 44),
    text = Color3.fromRGB(240, 244, 250)
}

local theme = {
    accent = defaultTheme.accent,
    button = defaultTheme.button,
    text = defaultTheme.text
}

local espColors = {
    hostile = colors.hostile,
    friendly = colors.friendly
}

local PANEL_WIDTH = 560
local PANEL_HEIGHT = 315
local ICON_URL = "https://files.catbox.moe/0brklx.jpg"
local ICON_FILE = "ahst_medved_icon.jpg"

local sizeOptions = {
    { name = "Pequeño", scale = 0.8 },
    { name = "Mediano", scale = 1 },
    { name = "Grande", scale = 1.2 }
}
local uiSize = 2

local themed = {}
local themedGradients = {}
local toggles = {}
local colorDots = {}

local function connect(signal, callback)
    local connection = signal:Connect(callback)
    table.insert(connections, connection)
    return connection
end

local function tween(object, duration, properties, style, direction)
    local info = TweenInfo.new(
        duration,
        style or Enum.EasingStyle.Quint,
        direction or Enum.EasingDirection.Out
    )
    local animation = TweenService:Create(object, info, properties)
    animation:Play()
    return animation
end

local function themeValue(key)
    if key == "hover" then
        return theme.button:Lerp(Color3.new(1, 1, 1), 0.09)
    end
    return theme[key] or colors[key]
end

local function accentSequence()
    return ColorSequence.new(
        theme.accent,
        theme.accent:Lerp(Color3.new(1, 1, 1), 0.45)
    )
end

local function bind(instance, property, key)
    table.insert(themed, { instance = instance, property = property, key = key })
    instance[property] = themeValue(key)
    return instance
end

local function bindGradient(gradient)
    table.insert(themedGradients, gradient)
    gradient.Color = accentSequence()
    return gradient
end

local function corner(parent, radius)
    local item = Instance.new("UICorner")
    item.CornerRadius = UDim.new(0, radius or 8)
    item.Parent = parent
    return item
end

local function round(parent)
    local item = Instance.new("UICorner")
    item.CornerRadius = UDim.new(0.5, 0)
    item.Parent = parent
    return item
end

local function stroke(parent, color, transparency, thickness)
    local item = Instance.new("UIStroke")
    item.Color = color
    item.Transparency = transparency or 0
    item.Thickness = thickness or 1
    item.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    item.Parent = parent
    return item
end

local function setText(label, text)
    if label.Text == text then return end
    label.Text = text
    label.TextTransparency = 0.7
    tween(label, 0.3, { TextTransparency = 0 })
end

local function addInteractions(button, baseKey, hoverKey)
    local scale = Instance.new("UIScale")
    scale.Parent = button

    connect(button.MouseEnter, function()
        tween(button, 0.18, { BackgroundColor3 = themeValue(hoverKey or "hover") })
    end)

    connect(button.MouseLeave, function()
        tween(button, 0.25, { BackgroundColor3 = themeValue(baseKey) })
        tween(scale, 0.25, { Scale = 1 })
    end)

    connect(button.MouseButton1Down, function()
        tween(scale, 0.1, { Scale = 0.96 })
    end)

    connect(button.MouseButton1Up, function()
        tween(scale, 0.3, { Scale = 1 }, Enum.EasingStyle.Back)
    end)
end

local function makeDraggable(handle, target, onClick)
    local dragging = false
    local moved = false
    local dragInput
    local dragStart
    local startPosition

    connect(handle.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            moved = false
            dragStart = input.Position
            startPosition = target.Position

            if input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end
    end)

    connect(handle.InputChanged, function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    connect(UIS.InputChanged, function(input)
        if dragging and input == dragInput and dragStart and startPosition then
            local delta = input.Position - dragStart

            if delta.Magnitude > 5 then
                moved = true
            end

            if moved then
                tween(target, 0.12, {
                    Position = UDim2.new(
                        startPosition.X.Scale,
                        startPosition.X.Offset + delta.X,
                        startPosition.Y.Scale,
                        startPosition.Y.Offset + delta.Y
                    )
                }, Enum.EasingStyle.Quad)
            end
        end
    end)

    connect(UIS.InputEnded, function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch) then
            dragging = false

            if not moved and onClick then
                onClick()
            end
        end
    end)
end

local screen = Instance.new("ScreenGui")
screen.Name = "AhstMedved"
screen.ResetOnSpawn = false
screen.IgnoreGuiInset = true
screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screen.Parent = playerGui

local visualFolder = Instance.new("Folder")
visualFolder.Name = "BearVisuals"
visualFolder.Parent = screen

local lineFolder = Instance.new("Folder")
lineFolder.Name = "TrackerLines"
lineFolder.Parent = screen

local function makeFader(parent)
    local fader = Instance.new("CanvasGroup")
    fader.Size = UDim2.fromScale(1, 1)
    fader.BackgroundTransparency = 1
    fader.BorderSizePixel = 0
    fader.GroupTransparency = 1
    fader.Parent = parent
    return fader
end

local function fade(object, fader, visible, duration, style, direction)
    object.Parent = fader
    local animation = tween(fader, duration, { GroupTransparency = visible and 0 or 1 }, style, direction)
    animation.Completed:Connect(function(state)
        if state ~= Enum.PlaybackState.Completed then return end
        if visible then
            object.Parent = fader.Parent
        else
            object.Visible = false
        end
    end)
    return animation
end

local mainFader = makeFader(screen)

local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Size = UDim2.fromOffset(PANEL_WIDTH, PANEL_HEIGHT)
main.Position = UDim2.new(0, 40 + PANEL_WIDTH / 2, 0.5, 0)
main.BackgroundColor3 = colors.background
main.BorderSizePixel = 0
main.Visible = false
main.Parent = mainFader
corner(main, 14)

local mainStroke = stroke(main, theme.accent, 0.6)
bind(mainStroke, "Color", "accent")

local aspect = Instance.new("UIAspectRatioConstraint")
aspect.AspectRatio = 16 / 9
aspect.Parent = main

local mainScale = Instance.new("UIScale")
mainScale.Scale = 0.9
mainScale.Parent = main

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 48)
header.BackgroundColor3 = colors.panel
header.BorderSizePixel = 0
header.Active = true
header.Parent = main
corner(header, 14)

local headerFill = Instance.new("Frame")
headerFill.Position = UDim2.new(0, 0, 1, -14)
headerFill.Size = UDim2.new(1, 0, 0, 14)
headerFill.BackgroundColor3 = colors.panel
headerFill.BorderSizePixel = 0
headerFill.Parent = header

local headerLine = Instance.new("Frame")
headerLine.ZIndex = 2
headerLine.Position = UDim2.new(0, 0, 1, -2)
headerLine.Size = UDim2.new(1, 0, 0, 2)
headerLine.BorderSizePixel = 0
headerLine.BackgroundColor3 = Color3.new(1, 1, 1)
headerLine.Parent = header

local headerGradient = bindGradient(Instance.new("UIGradient"))
headerGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.2),
    NumberSequenceKeypoint.new(0.5, 0),
    NumberSequenceKeypoint.new(1, 0.8)
})
headerGradient.Parent = headerLine

local title = Instance.new("TextLabel")
title.Position = UDim2.fromOffset(16, 6)
title.Size = UDim2.new(1, -290, 0, 22)
title.BackgroundTransparency = 1
title.Text = "AHST MEDVED"
title.TextSize = 17
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header
bind(title, "TextColor3", "text")

local subtitle = Instance.new("TextLabel")
subtitle.Position = UDim2.fromOffset(16, 27)
subtitle.Size = UDim2.new(1, -290, 0, 14)
subtitle.BackgroundTransparency = 1
subtitle.Text = "F6 páginas  •  F7 cajas  •  RightShift"
subtitle.TextColor3 = colors.muted
subtitle.TextSize = 10
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.TextTruncate = Enum.TextTruncate.AtEnd
subtitle.Parent = header

local hideButton = Instance.new("TextButton")
hideButton.AnchorPoint = Vector2.new(1, 0.5)
hideButton.Position = UDim2.new(1, -12, 0.5, -1)
hideButton.Size = UDim2.fromOffset(30, 30)
hideButton.BorderSizePixel = 0
hideButton.AutoButtonColor = false
hideButton.Text = "−"
hideButton.TextSize = 20
hideButton.Font = Enum.Font.GothamBold
hideButton.Parent = header
corner(hideButton, 8)
bind(hideButton, "BackgroundColor3", "button")
bind(hideButton, "TextColor3", "text")
addInteractions(hideButton, "button")

local tabBar = Instance.new("Frame")
tabBar.AnchorPoint = Vector2.new(1, 0.5)
tabBar.Position = UDim2.new(1, -52, 0.5, -1)
tabBar.Size = UDim2.fromOffset(220, 30)
tabBar.BackgroundColor3 = colors.background
tabBar.BorderSizePixel = 0
tabBar.Parent = header
corner(tabBar, 8)

local tabIndicator = Instance.new("Frame")
tabIndicator.Position = UDim2.new(0, 2, 0, 2)
tabIndicator.Size = UDim2.new(0.5, -4, 1, -4)
tabIndicator.BackgroundTransparency = 0.8
tabIndicator.BorderSizePixel = 0
tabIndicator.Parent = tabBar
corner(tabIndicator, 7)
bind(tabIndicator, "BackgroundColor3", "accent")

local tabIndicatorStroke = stroke(tabIndicator, theme.accent, 0.4)
bind(tabIndicatorStroke, "Color", "accent")

local content = Instance.new("Frame")
content.Position = UDim2.fromOffset(0, 48)
content.Size = UDim2.new(1, 0, 1, -48)
content.BackgroundTransparency = 1
content.ClipsDescendants = true
content.Parent = main

local pages = {}
local tabButtons = {}
local currentTab = 1

local function makePage(index)
    local page = Instance.new("Frame")
    page.Position = UDim2.fromScale(index - 1, 0)
    page.Size = UDim2.fromScale(1, 1)
    page.BackgroundTransparency = 1
    page.Parent = content
    pages[index] = page
    return page
end

local function refreshTabs(instant)
    for index, button in ipairs(tabButtons) do
        tween(button, instant and 0 or 0.3, {
            TextColor3 = index == currentTab and theme.text or colors.muted
        })
    end
end

local function switchTab(index)
    if index == currentTab then return end
    currentTab = index

    for i, page in ipairs(pages) do
        tween(page, 0.45, { Position = UDim2.fromScale(i - index, 0) })
    end

    tween(tabIndicator, 0.4, {
        Position = UDim2.new((index - 1) / #tabButtons, 2, 0, 2)
    }, Enum.EasingStyle.Back)

    refreshTabs()
end

local function makeTab(index, text)
    local button = Instance.new("TextButton")
    button.Position = UDim2.fromScale((index - 1) / 2, 0)
    button.Size = UDim2.fromScale(0.5, 1)
    button.BackgroundTransparency = 1
    button.Text = text
    button.TextColor3 = colors.muted
    button.TextSize = 12
    button.Font = Enum.Font.GothamBold
    button.Parent = tabBar
    tabButtons[index] = button

    connect(button.MouseButton1Click, function()
        if alive then
            switchTab(index)
        end
    end)
end

makeTab(1, "Home")
makeTab(2, "Configuración")
refreshTabs(true)

local homePage = makePage(1)
local configPage = makePage(2)

local function makeColumn(parent, position, heading)
    local column = Instance.new("Frame")
    column.Position = position
    column.Size = UDim2.new(0.5, -21, 1, -24)
    column.BackgroundTransparency = 1
    column.Parent = parent

    local list = Instance.new("UIListLayout")
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0, 6)
    list.Parent = column

    local label = Instance.new("TextLabel")
    label.LayoutOrder = 0
    label.Size = UDim2.new(1, 0, 0, 16)
    label.BackgroundTransparency = 1
    label.Text = heading
    label.TextSize = 10
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = column
    bind(label, "TextColor3", "accent")

    local count = 0
    local function nextOrder()
        count += 1
        return count
    end

    return column, nextOrder
end

local function makeStatus(parent, order, text)
    local card = Instance.new("Frame")
    card.LayoutOrder = order
    card.Size = UDim2.new(1, 0, 0, 30)
    card.BackgroundColor3 = colors.panel
    card.BorderSizePixel = 0
    card.Parent = parent
    corner(card, 8)

    local dot = Instance.new("Frame")
    dot.AnchorPoint = Vector2.new(0, 0.5)
    dot.Position = UDim2.new(0, 12, 0.5, 0)
    dot.Size = UDim2.fromOffset(8, 8)
    dot.BackgroundColor3 = colors.muted
    dot.BorderSizePixel = 0
    dot.Parent = card
    corner(dot, 4)

    local label = Instance.new("TextLabel")
    label.Position = UDim2.fromOffset(28, 0)
    label.Size = UDim2.new(1, -36, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextSize = 11
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.Parent = card
    bind(label, "TextColor3", "text")

    return label, dot
end

local function makeToggle(parent, order, text, initial, onClick)
    local button = Instance.new("TextButton")
    button.LayoutOrder = order
    button.Size = UDim2.new(1, 0, 0, 32)
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Text = ""
    button.Parent = parent
    corner(button, 8)
    bind(button, "BackgroundColor3", "button")
    addInteractions(button, "button")

    local label = Instance.new("TextLabel")
    label.Position = UDim2.fromOffset(12, 0)
    label.Size = UDim2.new(1, -64, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = colors.muted
    label.TextSize = 12
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = button

    local track = Instance.new("Frame")
    track.AnchorPoint = Vector2.new(1, 0.5)
    track.Position = UDim2.new(1, -10, 0.5, 0)
    track.Size = UDim2.fromOffset(36, 18)
    track.BackgroundColor3 = colors.track
    track.BorderSizePixel = 0
    track.Parent = button
    corner(track, 9)

    local knob = Instance.new("Frame")
    knob.AnchorPoint = Vector2.new(0, 0.5)
    knob.Position = UDim2.new(0, 2, 0.5, 0)
    knob.Size = UDim2.fromOffset(14, 14)
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    knob.BorderSizePixel = 0
    knob.Parent = track
    corner(knob, 7)

    local toggle = { button = button, label = label, state = initial }

    function toggle.set(value, instant)
        toggle.state = value
        local duration = instant and 0 or 0.3
        tween(track, duration, {
            BackgroundColor3 = value and theme.accent or colors.track
        })
        tween(knob, duration, {
            Position = value and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
        }, Enum.EasingStyle.Back)
        tween(label, duration, {
            TextColor3 = value and theme.text or colors.muted
        })
    end

    toggle.set(initial, true)
    table.insert(toggles, toggle)

    connect(button.MouseButton1Click, function()
        if alive then
            onClick(toggle.set)
        end
    end)

    return toggle
end

local function makeActionButton(parent, order, text, textKey, hoverKey)
    local button = Instance.new("TextButton")
    button.LayoutOrder = order
    button.Size = UDim2.new(1, 0, 0, 32)
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Text = text
    button.TextSize = 12
    button.Font = Enum.Font.GothamBold
    button.Parent = parent
    corner(button, 8)
    bind(button, "BackgroundColor3", "button")
    bind(button, "TextColor3", textKey or "text")
    addInteractions(button, "button", hoverKey)
    return button
end

local function makeColorDot(parent, target, position)
    local dot = Instance.new("TextButton")
    dot.AnchorPoint = Vector2.new(1, 0.5)
    dot.Position = position
    dot.Size = UDim2.fromOffset(18, 18)
    dot.BorderSizePixel = 0
    dot.AutoButtonColor = false
    dot.Text = ""
    dot.Parent = parent
    round(dot)
    stroke(dot, Color3.new(1, 1, 1), 0.55, 1.5)

    local scale = Instance.new("UIScale")
    scale.Parent = dot

    connect(dot.MouseEnter, function()
        tween(scale, 0.2, { Scale = 1.2 }, Enum.EasingStyle.Back)
    end)

    connect(dot.MouseLeave, function()
        tween(scale, 0.25, { Scale = 1 })
    end)

    colorDots[target] = dot
    return dot
end

local leftColumn, leftOrder = makeColumn(homePage, UDim2.fromOffset(14, 12), "VISUALES")
local rightColumn, rightOrder = makeColumn(homePage, UDim2.new(0.5, 7, 0, 12), "FARM")

local bearStatus, bearDot = makeStatus(leftColumn, leftOrder(), "Osos: buscando...")

local bearToggle = makeToggle(leftColumn, leftOrder(), "ESP de osos", settings.bearESP, function(set)
    settings.bearESP = not settings.bearESP
    set(settings.bearESP)
end)

local friendlyToggle = makeToggle(leftColumn, leftOrder(), "Osos amistosos", settings.friendlyESP, function(set)
    settings.friendlyESP = not settings.friendlyESP
    set(settings.friendlyESP)
end)

makeToggle(leftColumn, leftOrder(), "Líneas rastreadoras", settings.trackers, function(set)
    settings.trackers = not settings.trackers
    set(settings.trackers)
end)

local rangeCard = Instance.new("Frame")
rangeCard.LayoutOrder = leftOrder()
rangeCard.Size = UDim2.new(1, 0, 0, 40)
rangeCard.BackgroundColor3 = colors.panel
rangeCard.BorderSizePixel = 0
rangeCard.Parent = leftColumn
corner(rangeCard, 8)

local function rangeButton(text, position)
    local button = Instance.new("TextButton")
    button.AnchorPoint = Vector2.new(0, 0.5)
    button.Size = UDim2.fromOffset(28, 28)
    button.Position = position
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Text = text
    button.TextSize = 16
    button.Font = Enum.Font.GothamBold
    button.Parent = rangeCard
    corner(button, 7)
    bind(button, "BackgroundColor3", "button")
    bind(button, "TextColor3", "text")
    addInteractions(button, "button")
    return button
end

local minus = rangeButton("−", UDim2.new(0, 6, 0.5, 0))
local plus = rangeButton("+", UDim2.new(1, -34, 0.5, 0))

local rangeLabel = Instance.new("TextLabel")
rangeLabel.Position = UDim2.fromOffset(42, 4)
rangeLabel.Size = UDim2.new(1, -84, 0, 16)
rangeLabel.BackgroundTransparency = 1
rangeLabel.TextSize = 11
rangeLabel.Font = Enum.Font.GothamMedium
rangeLabel.Parent = rangeCard
bind(rangeLabel, "TextColor3", "text")

local rangeBar = Instance.new("Frame")
rangeBar.Position = UDim2.fromOffset(42, 25)
rangeBar.Size = UDim2.new(1, -84, 0, 6)
rangeBar.BackgroundColor3 = colors.track
rangeBar.BorderSizePixel = 0
rangeBar.Parent = rangeCard
corner(rangeBar, 3)

local rangeFill = Instance.new("Frame")
rangeFill.Size = UDim2.fromScale(1, 1)
rangeFill.BackgroundColor3 = Color3.new(1, 1, 1)
rangeFill.BorderSizePixel = 0
rangeFill.Parent = rangeBar
corner(rangeFill, 3)

bindGradient(Instance.new("UIGradient")).Parent = rangeFill

local function refreshRange(instant)
    setText(rangeLabel, "Alcance: " .. settings.range .. " studs")
    tween(rangeFill, instant and 0 or 0.35, {
        Size = UDim2.fromScale(settings.range / MAX_RANGE, 1)
    })
end

refreshRange(true)

connect(minus.MouseButton1Click, function()
    settings.range = math.clamp(settings.range - RANGE_STEP, MIN_RANGE, MAX_RANGE)
    refreshRange()
end)

connect(plus.MouseButton1Click, function()
    settings.range = math.clamp(settings.range + RANGE_STEP, MIN_RANGE, MAX_RANGE)
    refreshRange()
end)

local toggleFarm
local cleanup
local updateBears
local applyTheme

local farmStatus, farmDot = makeStatus(rightColumn, rightOrder(), "Farm: desactivado")

local pageToggle = makeToggle(rightColumn, rightOrder(), "Autofarm de páginas  [F6]", false, function()
    toggleFarm("pages")
end)

local crateToggle = makeToggle(rightColumn, rightOrder(), "Autofarm de cajas  [F7]", false, function()
    toggleFarm("crates")
end)

local hint = Instance.new("TextLabel")
hint.LayoutOrder = rightOrder()
hint.Size = UDim2.new(1, 0, 0, 28)
hint.BackgroundTransparency = 1
hint.Text = "Al activar un farm, el otro se detiene automáticamente."
hint.TextColor3 = colors.warning
hint.TextSize = 10
hint.Font = Enum.Font.Gotham
hint.TextWrapped = true
hint.TextXAlignment = Enum.TextXAlignment.Left
hint.Parent = rightColumn

local stopButton = makeActionButton(rightColumn, rightOrder(), "DESACTIVAR SCRIPT", "hostile", "dangerHover")
stroke(stopButton, colors.hostile, 0.65)

local colorColumn, colorOrder = makeColumn(configPage, UDim2.fromOffset(14, 12), "COLORES DE LA UI")
local sizeColumn, sizeOrder = makeColumn(configPage, UDim2.new(0.5, 7, 0, 12), "TAMAÑO DE LA UI")

local function makeColorRow(parent, order, text, target)
    local row = Instance.new("TextButton")
    row.LayoutOrder = order
    row.Size = UDim2.new(1, 0, 0, 32)
    row.BorderSizePixel = 0
    row.AutoButtonColor = false
    row.Text = ""
    row.Parent = parent
    corner(row, 8)
    bind(row, "BackgroundColor3", "button")
    addInteractions(row, "button")

    local label = Instance.new("TextLabel")
    label.Position = UDim2.fromOffset(12, 0)
    label.Size = UDim2.new(1, -50, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextSize = 12
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row
    bind(label, "TextColor3", "text")

    local dot = makeColorDot(row, target, UDim2.new(1, -12, 0.5, 0))
    return row, dot
end

local accentRow = makeColorRow(colorColumn, colorOrder(), "Sliders e interruptores", "accent")
local buttonRow = makeColorRow(colorColumn, colorOrder(), "Botones", "button")
local textRow = makeColorRow(colorColumn, colorOrder(), "Textos", "text")

local resetButton = makeActionButton(colorColumn, colorOrder(), "Restablecer colores")

local sizeCard = Instance.new("Frame")
sizeCard.LayoutOrder = sizeOrder()
sizeCard.Size = UDim2.new(1, 0, 0, 34)
sizeCard.BackgroundColor3 = colors.panel
sizeCard.BorderSizePixel = 0
sizeCard.Parent = sizeColumn
corner(sizeCard, 8)

local sizeIndicator = Instance.new("Frame")
sizeIndicator.Position = UDim2.new((uiSize - 1) / 3, 3, 0, 3)
sizeIndicator.Size = UDim2.new(1 / 3, -6, 1, -6)
sizeIndicator.BorderSizePixel = 0
sizeIndicator.Parent = sizeCard
corner(sizeIndicator, 6)
bind(sizeIndicator, "BackgroundColor3", "button")

local sizeIndicatorStroke = stroke(sizeIndicator, theme.accent, 0.4)
bind(sizeIndicatorStroke, "Color", "accent")

local sizeButtons = {}

local function refreshSizeButtons(instant)
    for index, button in ipairs(sizeButtons) do
        tween(button, instant and 0 or 0.3, {
            TextColor3 = index == uiSize and theme.text or colors.muted
        })
    end
end

local sizeInfo = Instance.new("TextLabel")
sizeInfo.LayoutOrder = sizeOrder()
sizeInfo.Size = UDim2.new(1, 0, 0, 44)
sizeInfo.BackgroundTransparency = 1
sizeInfo.Text = "El panel se ajusta automáticamente si no cabe en tu pantalla."
sizeInfo.TextColor3 = colors.muted
sizeInfo.TextSize = 10
sizeInfo.Font = Enum.Font.Gotham
sizeInfo.TextWrapped = true
sizeInfo.TextXAlignment = Enum.TextXAlignment.Left
sizeInfo.TextYAlignment = Enum.TextYAlignment.Top
sizeInfo.Parent = sizeColumn

local shortcutInfo = Instance.new("TextLabel")
shortcutInfo.LayoutOrder = sizeOrder()
shortcutInfo.Size = UDim2.new(1, 0, 0, 60)
shortcutInfo.BackgroundColor3 = colors.panel
shortcutInfo.BorderSizePixel = 0
shortcutInfo.Text = "RightShift  —  mostrar / ocultar\nF6  —  autofarm de páginas\nF7  —  autofarm de cajas"
shortcutInfo.TextSize = 11
shortcutInfo.Font = Enum.Font.GothamMedium
shortcutInfo.TextXAlignment = Enum.TextXAlignment.Left
shortcutInfo.Parent = sizeColumn
corner(shortcutInfo, 8)
bind(shortcutInfo, "TextColor3", "text")

local shortcutPadding = Instance.new("UIPadding")
shortcutPadding.PaddingLeft = UDim.new(0, 12)
shortcutPadding.Parent = shortcutInfo

local openButton = Instance.new("ImageButton")
openButton.Name = "ShowMenu"
openButton.AnchorPoint = Vector2.new(0.5, 0.5)
openButton.Position = UDim2.fromOffset(56, 150)
openButton.Size = UDim2.fromOffset(64, 64)
openButton.BackgroundColor3 = colors.panel
openButton.BorderSizePixel = 0
openButton.AutoButtonColor = false
openButton.Image = ""
openButton.ScaleType = Enum.ScaleType.Crop
openButton.Visible = false
openButton.Parent = screen
corner(openButton, 32)

local openStroke = stroke(openButton, theme.accent, 0.2, 2)
bind(openStroke, "Color", "accent")

local openScale = Instance.new("UIScale")
openScale.Scale = 0
openScale.Parent = openButton

local openFallback = Instance.new("TextLabel")
openFallback.Size = UDim2.fromScale(1, 1)
openFallback.BackgroundTransparency = 1
openFallback.Text = "AHST"
openFallback.TextSize = 13
openFallback.Font = Enum.Font.GothamBold
openFallback.Parent = openButton
bind(openFallback, "TextColor3", "accent")

task.spawn(function()
    local getAsset = getcustomasset or getsynasset
    if not (writefile and getAsset) then return end

    local ok, asset = pcall(function()
        if not (isfile and isfile(ICON_FILE)) then
            writefile(ICON_FILE, game:HttpGet(ICON_URL))
        end
        return getAsset(ICON_FILE)
    end)

    if ok and asset and alive then
        openButton.Image = asset
        openFallback.Visible = false
    elseif not ok then
        warn("[AHST MEDVED] No se pudo cargar el icono:", asset)
    end
end)

local pickerOverlay = Instance.new("TextButton")
pickerOverlay.Name = "ColorPicker"
pickerOverlay.Size = UDim2.fromScale(1, 1)
pickerOverlay.BackgroundColor3 = Color3.new(0, 0, 0)
pickerOverlay.BackgroundTransparency = 1
pickerOverlay.BorderSizePixel = 0
pickerOverlay.AutoButtonColor = false
pickerOverlay.Text = ""
pickerOverlay.ZIndex = 10
pickerOverlay.Visible = false
pickerOverlay.Parent = main
corner(pickerOverlay, 14)

local pickerFader = makeFader(pickerOverlay)

local picker = Instance.new("Frame")
picker.AnchorPoint = Vector2.new(0.5, 0.5)
picker.Position = UDim2.fromScale(0.5, 0.5)
picker.Size = UDim2.fromOffset(284, 262)
picker.BackgroundColor3 = colors.panel
picker.BorderSizePixel = 0
picker.Active = true
picker.Parent = pickerFader
corner(picker, 14)

local pickerStroke = stroke(picker, theme.accent, 0.5)
bind(pickerStroke, "Color", "accent")

local pickerScale = Instance.new("UIScale")
pickerScale.Scale = 0.7
pickerScale.Parent = picker

local pickerTitle = Instance.new("TextLabel")
pickerTitle.Position = UDim2.fromOffset(14, 10)
pickerTitle.Size = UDim2.new(1, -60, 0, 24)
pickerTitle.BackgroundTransparency = 1
pickerTitle.Text = "Color"
pickerTitle.TextSize = 13
pickerTitle.Font = Enum.Font.GothamBold
pickerTitle.TextXAlignment = Enum.TextXAlignment.Left
pickerTitle.Parent = picker
bind(pickerTitle, "TextColor3", "text")

local pickerClose = Instance.new("TextButton")
pickerClose.AnchorPoint = Vector2.new(1, 0)
pickerClose.Position = UDim2.new(1, -10, 0, 9)
pickerClose.Size = UDim2.fromOffset(26, 26)
pickerClose.BorderSizePixel = 0
pickerClose.AutoButtonColor = false
pickerClose.Text = "X"
pickerClose.TextSize = 13
pickerClose.Font = Enum.Font.GothamBold
pickerClose.Parent = picker
corner(pickerClose, 13)
bind(pickerClose, "BackgroundColor3", "button")
bind(pickerClose, "TextColor3", "text")
addInteractions(pickerClose, "button", "dangerHover")

local wheel = Instance.new("Frame")
wheel.Position = UDim2.fromOffset(12, 46)
wheel.Size = UDim2.fromOffset(204, 204)
wheel.BackgroundTransparency = 1
wheel.Parent = picker

local neutralColumn = Instance.new("Frame")
neutralColumn.Position = UDim2.fromOffset(226, 46)
neutralColumn.Size = UDim2.fromOffset(46, 204)
neutralColumn.BackgroundColor3 = colors.background
neutralColumn.BorderSizePixel = 0
neutralColumn.Parent = picker
corner(neutralColumn, 10)

local pickerTitles = {
    hostile = "Color de osos",
    friendly = "Color de amistosos",
    accent = "Color de acento",
    button = "Color de botones",
    text = "Color de textos"
}

local swatches = {}
local pickerTarget = "hostile"
local pickerOpen = false

local function getTargetColor(target)
    return espColors[target] or theme[target]
end

local function sameColor(a, b)
    return math.abs(a.R - b.R) < 0.01
        and math.abs(a.G - b.G) < 0.01
        and math.abs(a.B - b.B) < 0.01
end

local function highlightSwatch(color)
    for _, swatch in ipairs(swatches) do
        local selected = sameColor(swatch.color, color)
        tween(swatch.stroke, 0.2, { Transparency = selected and 0 or 1 })
        tween(swatch.scale, 0.3, { Scale = selected and 1.15 or 1 }, Enum.EasingStyle.Back)
    end
end

local function refreshColorDots(instant)
    for target, dot in pairs(colorDots) do
        tween(dot, instant and 0 or 0.3, { BackgroundColor3 = getTargetColor(target) })
    end
end

local function chooseColor(color)
    if espColors[pickerTarget] then
        espColors[pickerTarget] = color
        if updateBears then
            updateBears()
        end
    else
        theme[pickerTarget] = color
        applyTheme()
    end

    highlightSwatch(color)
    refreshColorDots()
end

local function makeSwatch(parent, color, position, size)
    local swatch = Instance.new("TextButton")
    swatch.AnchorPoint = Vector2.new(0.5, 0.5)
    swatch.Position = position
    swatch.Size = UDim2.fromOffset(size, size)
    swatch.BackgroundColor3 = color
    swatch.BorderSizePixel = 0
    swatch.AutoButtonColor = false
    swatch.Text = ""
    swatch.Parent = parent
    round(swatch)

    local entry = {
        color = color,
        stroke = stroke(swatch, Color3.new(1, 1, 1), 1, 2),
        scale = Instance.new("UIScale")
    }
    entry.scale.Parent = swatch
    table.insert(swatches, entry)

    connect(swatch.MouseEnter, function()
        tween(entry.scale, 0.2, { Scale = 1.22 }, Enum.EasingStyle.Back)
    end)

    connect(swatch.MouseLeave, function()
        local selected = sameColor(entry.color, getTargetColor(pickerTarget))
        tween(entry.scale, 0.25, { Scale = selected and 1.15 or 1 })
    end)

    connect(swatch.MouseButton1Click, function()
        if alive and pickerOpen then
            chooseColor(color)
        end
    end)
end

for i = 0, 17 do
    local angle = math.rad(i * 20 - 90)
    makeSwatch(
        wheel,
        Color3.fromHSV(i / 18, 0.85, 1),
        UDim2.new(0.5, math.cos(angle) * 84, 0.5, math.sin(angle) * 84),
        26
    )
end

for i = 0, 11 do
    local angle = math.rad(i * 30 - 75)
    makeSwatch(
        wheel,
        Color3.fromHSV((i + 0.5) / 12, 0.4, 1),
        UDim2.new(0.5, math.cos(angle) * 52, 0.5, math.sin(angle) * 52),
        22
    )
end

makeSwatch(wheel, Color3.new(1, 1, 1), UDim2.fromScale(0.5, 0.5), 28)

local neutrals = {
    defaultTheme.text,
    Color3.fromRGB(175, 180, 190),
    Color3.fromRGB(110, 115, 125),
    Color3.fromRGB(55, 60, 72),
    defaultTheme.button,
    Color3.fromRGB(16, 16, 20)
}

for index, color in ipairs(neutrals) do
    makeSwatch(neutralColumn, color, UDim2.new(0.5, 0, 0, 17 + (index - 1) * 34), 24)
end

local function openPicker(target)
    if not alive then return end

    pickerTarget = target
    pickerOpen = true
    pickerTitle.Text = pickerTitles[target] or "Color"
    highlightSwatch(getTargetColor(target))

    pickerOverlay.Visible = true
    picker.Visible = true
    pickerScale.Scale = 0.7
    tween(pickerOverlay, 0.3, { BackgroundTransparency = 0.45 })
    fade(picker, pickerFader, true, 0.3)
    tween(pickerScale, 0.45, { Scale = 1 }, Enum.EasingStyle.Back)
end

local function closePicker()
    if not pickerOpen then return end
    pickerOpen = false

    tween(pickerOverlay, 0.22, { BackgroundTransparency = 1 })
    tween(pickerScale, 0.22, { Scale = 0.8 }, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    local animation = fade(picker, pickerFader, false, 0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    animation.Completed:Connect(function(state)
        if state == Enum.PlaybackState.Completed and not pickerOpen then
            pickerOverlay.Visible = false
        end
    end)
end

connect(pickerClose.MouseButton1Click, closePicker)
connect(pickerOverlay.MouseButton1Click, closePicker)

bearToggle.label.Size = UDim2.new(1, -96, 1, 0)
friendlyToggle.label.Size = UDim2.new(1, -96, 1, 0)
makeColorDot(bearToggle.button, "hostile", UDim2.new(1, -56, 0.5, 0))
makeColorDot(friendlyToggle.button, "friendly", UDim2.new(1, -56, 0.5, 0))

for target, dot in pairs(colorDots) do
    connect(dot.MouseButton1Click, function()
        openPicker(target)
    end)
end

for _, row in ipairs({ { accentRow, "accent" }, { buttonRow, "button" }, { textRow, "text" } }) do
    connect(row[1].MouseButton1Click, function()
        openPicker(row[2])
    end)
end

refreshColorDots(true)

applyTheme = function(instant)
    local duration = instant and 0 or 0.35

    for _, entry in ipairs(themed) do
        if entry.instance.Parent then
            tween(entry.instance, duration, { [entry.property] = themeValue(entry.key) })
        end
    end

    for _, gradient in ipairs(themedGradients) do
        gradient.Color = accentSequence()
    end

    for _, toggle in ipairs(toggles) do
        toggle.set(toggle.state, instant)
    end

    refreshTabs(instant)
    refreshSizeButtons(instant)
end

connect(resetButton.MouseButton1Click, function()
    theme.accent = defaultTheme.accent
    theme.button = defaultTheme.button
    theme.text = defaultTheme.text
    applyTheme()
    refreshColorDots()
end)

local menuOpen = false
local hovering = false

local function targetScale()
    local camera = Workspace.CurrentCamera
    local viewport = camera and camera.ViewportSize or Vector2.new(1920, 1080)
    local fit = math.min((viewport.X - 40) / PANEL_WIDTH, (viewport.Y - 40) / PANEL_HEIGHT)
    return math.clamp(math.min(sizeOptions[uiSize].scale, fit), 0.4, 1.5)
end

local function selectSize(index)
    uiSize = index

    tween(sizeIndicator, 0.4, {
        Position = UDim2.new((index - 1) / 3, 3, 0, 3)
    }, Enum.EasingStyle.Back)

    refreshSizeButtons()

    if menuOpen then
        tween(mainScale, 0.45, { Scale = targetScale() }, Enum.EasingStyle.Back)
    end
end

for index, option in ipairs(sizeOptions) do
    local button = Instance.new("TextButton")
    button.Position = UDim2.fromScale((index - 1) / 3, 0)
    button.Size = UDim2.fromScale(1 / 3, 1)
    button.BackgroundTransparency = 1
    button.Text = option.name
    button.TextColor3 = colors.muted
    button.TextSize = 12
    button.Font = Enum.Font.GothamBold
    button.Parent = sizeCard
    sizeButtons[index] = button

    connect(button.MouseButton1Click, function()
        if alive then
            selectSize(index)
        end
    end)
end

refreshSizeButtons(true)

local function openMenu()
    if menuOpen or not alive then return end
    menuOpen = true

    local scale = targetScale()
    main.Visible = true
    mainScale.Scale = scale * 0.9

    fade(main, mainFader, true, 0.35)
    tween(mainScale, 0.5, { Scale = scale }, Enum.EasingStyle.Back)

    local hide = tween(openScale, 0.2, { Scale = 0 }, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    hide.Completed:Connect(function()
        if menuOpen then
            openButton.Visible = false
        end
    end)
end

local function closeMenu()
    if not menuOpen or not alive then return end
    menuOpen = false

    closePicker()

    tween(mainScale, 0.25, { Scale = targetScale() * 0.9 }, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    fade(main, mainFader, false, 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In)

    openButton.Visible = true
    openScale.Scale = 0
    task.delay(0.12, function()
        if not menuOpen and alive then
            tween(openScale, 0.5, { Scale = hovering and 1.08 or 1 }, Enum.EasingStyle.Back)
        end
    end)
end

connect(hideButton.MouseButton1Click, closeMenu)

connect(openButton.MouseEnter, function()
    hovering = true
    if not menuOpen then
        tween(openScale, 0.25, { Scale = 1.08 }, Enum.EasingStyle.Back)
    end
end)

connect(openButton.MouseLeave, function()
    hovering = false
    if not menuOpen then
        tween(openScale, 0.25, { Scale = 1 })
    end
end)

makeDraggable(header, main)
makeDraggable(openButton, openButton, openMenu)

local function getRoot(model)
    if not model or not model:IsA("Model") then
        return nil
    end

    local root = model:FindFirstChild("HumanoidRootPart")
        or model:FindFirstChild("RootPart")
        or model.PrimaryPart

    if root and root:IsA("BasePart") then
        return root
    end

    return nil
end

local function destroyVisual(visual)
    if visual.billboard then visual.billboard:Destroy() end
    if visual.line then visual.line:Destroy() end
end

local function clearVisuals()
    for model, visual in pairs(visuals) do
        destroyVisual(visual)
        visuals[model] = nil
    end
end

local function createVisual(root, color)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "BearLabel"
    billboard.Adornee = root
    billboard.Size = UDim2.fromOffset(180, 44)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = settings.range
    billboard.Parent = visualFolder

    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromScale(1, 1)
    label.BackgroundTransparency = 1
    label.TextColor3 = color
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.TextStrokeTransparency = 0
    label.TextTransparency = 1
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.TextWrapped = true
    label.Parent = billboard
    tween(label, 0.4, { TextTransparency = 0 })

    local line = Instance.new("Frame")
    line.Name = "BearTracker"
    line.AnchorPoint = Vector2.new(0.5, 0.5)
    line.BorderSizePixel = 0
    line.BackgroundColor3 = color
    line.BackgroundTransparency = 0.25
    line.Visible = false
    line.Parent = lineFolder

    return {
        root = root,
        billboard = billboard,
        label = label,
        line = line
    }
end

updateBears = function()
    local myRoot = getRoot(player.Character)

    if not myRoot then
        clearVisuals()
        setText(bearStatus, "Osos: esperando al personaje")
        bearDot.BackgroundColor3 = colors.muted
        return
    end

    local wanted = {}
    local hostileCount = 0
    local friendlyCount = 0

    local function scan(folderName, enabled, friendly)
        if not enabled then return end

        local folder = Workspace:FindFirstChild(folderName)
        if not folder then return end

        for _, model in ipairs(folder:GetChildren()) do
            if model:IsA("Model") and model ~= player.Character then
                local root = getRoot(model)
                local humanoid = model:FindFirstChildOfClass("Humanoid")

                if root and (not humanoid or humanoid.Health > 0) then
                    local distance = (root.Position - myRoot.Position).Magnitude

                    if distance <= settings.range then
                        wanted[model] = true

                        if friendly then
                            friendlyCount += 1
                        else
                            hostileCount += 1
                        end

                        local color = friendly and espColors.friendly or espColors.hostile
                        local visual = visuals[model]

                        if visual and visual.root ~= root then
                            destroyVisual(visual)
                            visuals[model] = nil
                            visual = nil
                        end

                        if not visual then
                            visual = createVisual(root, color)
                            visuals[model] = visual
                        end

                        visual.label.TextColor3 = color
                        visual.line.BackgroundColor3 = color
                        visual.billboard.MaxDistance = settings.range

                        local name = model.Name
                        local bearId = model:GetAttribute("BearID")

                        if type(bearId) == "string"
                            and bearId ~= ""
                            and bearId ~= name then
                            name = name .. " [" .. bearId .. "]"
                        end

                        if friendly then
                            name = "AMISTOSO: " .. name
                        end

                        visual.label.Text = name
                            .. "\n" .. math.floor(distance) .. " studs"
                    end
                end
            end
        end
    end

    scan("Bears", settings.bearESP, false)
    scan("FriendlyBears", settings.friendlyESP, true)

    for model, visual in pairs(visuals) do
        if not wanted[model] then
            destroyVisual(visual)
            visuals[model] = nil
        end
    end

    setText(bearStatus, "Osos: " .. hostileCount .. "  |  Amistosos: " .. friendlyCount)

    local dotColor = hostileCount > 0 and espColors.hostile
        or friendlyCount > 0 and espColors.friendly
        or colors.muted
    tween(bearDot, 0.3, { BackgroundColor3 = dotColor })
end

local function updateLines()
    local camera = Workspace.CurrentCamera

    for _, visual in pairs(visuals) do
        local line = visual.line
        line.Visible = false

        if settings.trackers
            and camera
            and visual.root
            and visual.root:IsDescendantOf(Workspace) then

            local point, onScreen = camera:WorldToViewportPoint(
                visual.root.Position
            )

            if onScreen and point.Z > 0 then
                local viewport = camera.ViewportSize
                local startPoint = Vector2.new(viewport.X / 2, viewport.Y - 20)
                local endPoint = Vector2.new(point.X, point.Y)
                local delta = endPoint - startPoint
                local middle = (startPoint + endPoint) / 2

                line.Size = UDim2.fromOffset(delta.Magnitude, 2)
                line.Position = UDim2.fromOffset(middle.X, middle.Y)
                line.Rotation = math.deg(math.atan2(delta.Y, delta.X))
                line.Visible = true
            end
        end
    end
end

local farmMode = nil
local farmBusy = false
local farmToken = 0
local farmContext = nil
local pendingMode = nil
local startFarm

local function validCharacter(character, humanoid, root)
    return character
        and humanoid
        and root
        and player.Character == character
        and character:IsDescendantOf(Workspace)
        and humanoid.Parent ~= nil
        and humanoid.Health > 0
        and root:IsDescendantOf(character)
end

local function returnToStart(context)
    if not context or context.returned then return end
    context.returned = true

    if validCharacter(context.character, context.humanoid, context.root) then
        local ok, err = pcall(function()
            context.character:PivotTo(context.original)
        end)

        if not ok then
            warn("[AHST MEDVED] Error al regresar:", err)
        end
    else
        print("[AHST MEDVED] Regreso omitido: el personaje murió o cambió")
    end
end

local function isActive(token)
    return alive and farmMode ~= nil and farmToken == token
end

local function waitActive(seconds, token)
    local deadline = os.clock() + seconds

    while isActive(token) and os.clock() < deadline do
        task.wait(0.05)
    end

    return isActive(token)
end

local function refreshFarmButtons()
    local active = pendingMode or farmMode
    pageToggle.set(active == "pages")
    crateToggle.set(active == "crates")
end

local function getNearestPage(root, attempted)
    local folder = Workspace:FindFirstChild("Pages")
    if not folder then
        return nil, nil, "No se encontró la carpeta Pages"
    end

    local selected, selectedPrompt, nearestDistance

    for _, page in ipairs(folder:GetChildren()) do
        if page:IsA("BasePart") and not attempted[page] then
            local prompt = page:FindFirstChildWhichIsA("ProximityPrompt", true)

            if prompt and prompt.Enabled then
                local distance = (page.Position - root.Position).Magnitude

                if not nearestDistance or distance < nearestDistance then
                    selected = page
                    selectedPrompt = prompt
                    nearestDistance = distance
                end
            end
        end
    end

    return selected, selectedPrompt
end

local function getNearestCrate(root, attempted)
    local interactables = Workspace:FindFirstChild("Interactables")
    local folder = interactables and interactables:FindFirstChild("Crates")

    if not folder then
        return nil, nil, nil, "No se encontró la carpeta Crates"
    end

    local selected, selectedPart, selectedPrompt, nearestDistance

    for _, model in ipairs(folder:GetChildren()) do
        if model:IsA("Model")
            and not attempted[model]
            and model:GetAttribute("Collected") ~= true then

            local part = model:FindFirstChild("Crate")
            local prompt = part and part:FindFirstChild("CratePrompt")

            if part and part:IsA("BasePart")
                and prompt and prompt:IsA("ProximityPrompt")
                and prompt.Enabled then

                local distance = (part.Position - root.Position).Magnitude

                if not nearestDistance or distance < nearestDistance then
                    selected = model
                    selectedPart = part
                    selectedPrompt = prompt
                    nearestDistance = distance
                end
            end
        end
    end

    return selected, selectedPart, selectedPrompt
end

local function runPages(context, token)
    local attempted = {}
    local attempts = 0
    local confirmed = 0
    local reason = "no quedan más páginas disponibles"

    while isActive(token) do
        if not validCharacter(context.character, context.humanoid, context.root) then
            reason = "el personaje murió o cambió"
            break
        end

        local page, prompt, err = getNearestPage(context.root, attempted)

        if err then
            reason = err
            break
        end

        if not page then break end

        attempted[page] = true
        attempts += 1
        setText(farmStatus, "Página: " .. page.Name .. "  |  intento " .. attempts)

        local ok, teleportError = pcall(function()
            context.character:PivotTo(page.CFrame * CFrame.new(0, 3, 0))
        end)

        if not ok then
            warn("[AHST MEDVED] Teletransporte a la página:", teleportError)
        elseif waitActive(1, token)
            and validCharacter(context.character, context.humanoid, context.root)
            and page:IsDescendantOf(Workspace)
            and prompt.Parent
            and prompt.Enabled then

            local fired, fireError = pcall(function()
                fireproximityprompt(prompt)
            end)

            if not fired then
                warn("[AHST MEDVED] Recolección de página:", fireError)
            end

            if not waitActive(1.5, token) then
                reason = "detenido"
                break
            end

            if not page:IsDescendantOf(Workspace)
                or not prompt.Parent
                or not prompt.Enabled then
                confirmed += 1
            end
        end
    end

    return reason, "Páginas: " .. confirmed .. "/" .. attempts
end

local function runCrates(context, token)
    local attempted = {}
    local attempts = 0
    local opened = 0
    local itemAttempts = 0
    local reason = "no quedan más cajas disponibles"

    while isActive(token) do
        if not validCharacter(context.character, context.humanoid, context.root) then
            reason = "el personaje murió o cambió"
            break
        end

        local crate, cratePart, prompt, err =
            getNearestCrate(context.root, attempted)

        if err then
            reason = err
            break
        end

        if not crate then break end

        attempted[crate] = true
        attempts += 1
        setText(farmStatus, "Caja: " .. crate.Name .. "  |  intento " .. attempts)

        local ok, teleportError = pcall(function()
            context.character:PivotTo(cratePart.CFrame * CFrame.new(0, 3, 0))
        end)

        if not ok then
            warn("[AHST MEDVED] Teletransporte a la caja:", teleportError)
        elseif waitActive(0.7, token)
            and validCharacter(context.character, context.humanoid, context.root)
            and crate:IsDescendantOf(Workspace)
            and prompt.Parent
            and prompt.Enabled then

            local fired, fireError = pcall(function()
                fireproximityprompt(prompt)
            end)

            if not fired then
                warn("[AHST MEDVED] Apertura de caja:", fireError)
            end

            if not waitActive(1.5, token) then
                reason = "detenido"
                break
            end

            if crate:GetAttribute("Collected") == true
                or not prompt.Parent
                or not prompt.Enabled then
                opened += 1
            end

            if crate:IsDescendantOf(Workspace) then
                for _, obj in ipairs(crate:GetDescendants()) do
                    if not isActive(token)
                        or not validCharacter(
                            context.character,
                            context.humanoid,
                            context.root
                        ) then
                        break
                    end

                    if obj:IsA("ProximityPrompt")
                        and obj.Name == "ItemPrompt"
                        and obj.Enabled then

                        itemAttempts += 1
                        print("[AHST MEDVED] Objeto:", obj.ObjectText)

                        local itemOk, itemError = pcall(function()
                            fireproximityprompt(obj)
                        end)

                        if not itemOk then
                            warn("[AHST MEDVED] Recolección de objeto:", itemError)
                        end

                        if not waitActive(0.35, token) then
                            reason = "detenido"
                            break
                        end
                    end
                end
            end
        end
    end

    return reason, "Cajas: " .. opened .. "/" .. attempts
        .. "  |  objetos: " .. itemAttempts
end

local function runFarm(mode, token)
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    if not validCharacter(character, humanoid, root) then
        farmBusy = false
        farmMode = nil
        pendingMode = nil

        if alive then
            refreshFarmButtons()
            setText(farmStatus, "Farm: no se encontró un personaje vivo")
        end
        return
    end

    local context = {
        character = character,
        root = root,
        humanoid = humanoid,
        original = character:GetPivot(),
        returned = false
    }

    farmContext = context

    local ok, reason, result = xpcall(function()
        if mode == "pages" then
            return runPages(context, token)
        else
            return runCrates(context, token)
        end
    end, debug.traceback)

    returnToStart(context)

    if farmContext == context then
        farmContext = nil
    end

    farmBusy = false

    if farmToken == token then
        farmMode = nil
    end

    if not ok then
        warn("[AHST MEDVED] Error del farm:", reason)
        result = "Farm: error, revisa la consola"
    else
        print("[AHST MEDVED] Farm terminado:", reason, result)
    end

    if alive then
        refreshFarmButtons()
        setText(farmStatus, result or "Farm terminado")

        if pendingMode then
            local nextMode = pendingMode
            pendingMode = nil
            startFarm(nextMode)
        end
    end
end

startFarm = function(mode)
    farmMode = mode
    farmBusy = true
    farmToken += 1

    refreshFarmButtons()
    setText(farmStatus, "Farm: iniciando...")
    task.spawn(runFarm, mode, farmToken)
end

toggleFarm = function(mode)
    if farmMode == mode or pendingMode == mode then
        pendingMode = nil

        if farmMode == mode then
            farmMode = nil
            farmToken += 1
        end

        refreshFarmButtons()
        setText(farmStatus, farmBusy and "Deteniendo y regresando..." or "Farm: desactivado")
        return
    end

    if type(fireproximityprompt) ~= "function" then
        setText(farmStatus, "fireproximityprompt no está disponible")
        return
    end

    if farmBusy then
        farmMode = nil
        farmToken += 1
        pendingMode = mode

        refreshFarmButtons()
        setText(farmStatus, "Cambiando de farm...")
        return
    end

    startFarm(mode)
end

connect(stopButton.MouseButton1Click, function()
    cleanup()
end)

connect(UIS.InputBegan, function(input)
    if UIS:GetFocusedTextBox() then
        return
    end

    if input.KeyCode == Enum.KeyCode.RightShift then
        if menuOpen then
            closeMenu()
        else
            openMenu()
        end
    elseif input.KeyCode == Enum.KeyCode.F6 then
        toggleFarm("pages")
    elseif input.KeyCode == Enum.KeyCode.F7 then
        toggleFarm("crates")
    end
end)

local elapsed = 0

connect(RunService.Heartbeat, function(dt)
    if not alive then return end

    elapsed += dt
    if elapsed >= 0.5 then
        elapsed = 0
        updateBears()
    end

    local pulse = (math.sin(os.clock() * 4) + 1) / 2

    if farmMode then
        farmDot.BackgroundColor3 = theme.accent
        farmDot.BackgroundTransparency = pulse * 0.6
    else
        farmDot.BackgroundColor3 = colors.muted
        farmDot.BackgroundTransparency = 0
    end

    if openButton.Visible then
        openStroke.Transparency = 0.1 + pulse * 0.5
    end

    headerGradient.Offset = Vector2.new(math.sin(os.clock() * 0.8) * 0.5, 0)
end)

connect(RunService.RenderStepped, function()
    if alive then
        updateLines()
    end
end)

cleanup = function()
    if not alive then return end

    farmMode = nil
    pendingMode = nil
    farmToken += 1

    returnToStart(farmContext)
    farmContext = nil

    alive = false

    for _, connection in ipairs(connections) do
        connection:Disconnect()
    end

    clearVisuals()

    tween(mainScale, 0.25, { Scale = mainScale.Scale * 0.9 }, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    main.Parent = mainFader
    tween(mainFader, 0.25, { GroupTransparency = 1 }, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    tween(openScale, 0.2, { Scale = 0 }, Enum.EasingStyle.Quint, Enum.EasingDirection.In)

    task.delay(0.3, function()
        screen:Destroy()
    end)

    if env.AhstMedvedCleanup == cleanup then
        env.AhstMedvedCleanup = nil
    end

    print("[AHST MEDVED] Script desactivado.")
end

env.AhstMedvedCleanup = cleanup

updateBears()
task.defer(openMenu)

print("[AHST MEDVED] Cargado.")
print("[AHST MEDVED] RightShift — menú | F6 — páginas | F7 — cajas.")
print("[AHST MEDVED] Si las teclas F no responden, prueba Fn + F6/F7.")
