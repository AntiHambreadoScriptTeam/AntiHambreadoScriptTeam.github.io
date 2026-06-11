local ahst_lib = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local TextService = game:GetService("TextService")
local StatsService = game:GetService("Stats")

local LocalPlayer = Players.LocalPlayer
local ClockStart = os.clock()

ahst_lib.Name = "Anti-Hambreado Script Team UI"
ahst_lib.Version = "1.0.0"
ahst_lib.Flags = {}
ahst_lib.Windows = {}
ahst_lib.CurrentWindow = nil
ahst_lib.ConfigFolder = "Anti-Hambreado-Lib"
ahst_lib.Assets = {
    Mascot = "https://antihambreadoscriptteam.github.io/Foto/Lib/Anti-Girl-Lib.jpg",
    Background = "https://antihambreadoscriptteam.github.io/Foto/Lib/Fondo-Lib.png"
}

ahst_lib.Documentation = {
    CreateWindow = "ahst_lib:CreateWindow({Title, Size, Theme, AutoCreateDefaultTabs, MascotImage, BackgroundImage})",
    CreateTab = "Window:CreateTab(Name, Icon)",
    CreateSection = "Tab:CreateSection(Title, Description, Options)",
    Button = "Section:CreateButton({Name, Description, Callback})",
    Toggle = "Section:CreateToggle({Name, Default, Flag, Callback})",
    Slider = "Section:CreateSlider({Name, Min, Max, Default, Increment, Flag, Callback})",
    Dropdown = "Section:CreateDropdown({Name, Options, Default, Multi, Search, Flag, Callback})",
    Textbox = "Section:CreateTextbox({Name, Placeholder, Default, Validate, Flag, Callback})",
    ColorPicker = "Section:CreateColorPicker({Name, Default, Transparency, Flag, Callback})",
    Keybind = "Section:CreateKeybind({Name, Default, Flag, Callback})",
    Config = "Window:SaveConfig(Name), Window:LoadConfig(Name), Window:DeleteConfig(Name), Window:ExportConfig(), Window:ImportConfig(Json)"
}

local Themes = {
    ["AMOLED Red"] = {
        Accent = Color3.fromRGB(255, 45, 45),
        Accent2 = Color3.fromRGB(255, 94, 94),
        AccentDark = Color3.fromRGB(95, 0, 12),
        Background = Color3.fromRGB(0, 0, 0),
        Surface = Color3.fromRGB(8, 8, 12),
        Surface2 = Color3.fromRGB(16, 16, 23),
        Surface3 = Color3.fromRGB(26, 24, 32),
        Text = Color3.fromRGB(246, 246, 250),
        Muted = Color3.fromRGB(156, 156, 168),
        Border = Color3.fromRGB(255, 45, 45),
        Good = Color3.fromRGB(42, 220, 130),
        Warning = Color3.fromRGB(255, 181, 51),
        Error = Color3.fromRGB(255, 64, 84),
        Info = Color3.fromRGB(70, 155, 255)
    },
    ["AMOLED Blue"] = {
        Accent = Color3.fromRGB(54, 132, 255),
        Accent2 = Color3.fromRGB(112, 176, 255),
        AccentDark = Color3.fromRGB(0, 34, 98),
        Background = Color3.fromRGB(0, 0, 0),
        Surface = Color3.fromRGB(8, 10, 15),
        Surface2 = Color3.fromRGB(15, 18, 27),
        Surface3 = Color3.fromRGB(24, 29, 42),
        Text = Color3.fromRGB(246, 248, 255),
        Muted = Color3.fromRGB(155, 163, 180),
        Border = Color3.fromRGB(54, 132, 255),
        Good = Color3.fromRGB(42, 220, 130),
        Warning = Color3.fromRGB(255, 181, 51),
        Error = Color3.fromRGB(255, 64, 84),
        Info = Color3.fromRGB(54, 132, 255)
    },
    ["AMOLED Purple"] = {
        Accent = Color3.fromRGB(165, 92, 255),
        Accent2 = Color3.fromRGB(203, 148, 255),
        AccentDark = Color3.fromRGB(62, 0, 112),
        Background = Color3.fromRGB(0, 0, 0),
        Surface = Color3.fromRGB(10, 8, 15),
        Surface2 = Color3.fromRGB(18, 15, 27),
        Surface3 = Color3.fromRGB(31, 24, 42),
        Text = Color3.fromRGB(250, 246, 255),
        Muted = Color3.fromRGB(168, 158, 180),
        Border = Color3.fromRGB(165, 92, 255),
        Good = Color3.fromRGB(42, 220, 130),
        Warning = Color3.fromRGB(255, 181, 51),
        Error = Color3.fromRGB(255, 64, 84),
        Info = Color3.fromRGB(165, 92, 255)
    },
    ["AMOLED Emerald"] = {
        Accent = Color3.fromRGB(27, 220, 132),
        Accent2 = Color3.fromRGB(96, 255, 180),
        AccentDark = Color3.fromRGB(0, 86, 45),
        Background = Color3.fromRGB(0, 0, 0),
        Surface = Color3.fromRGB(7, 12, 10),
        Surface2 = Color3.fromRGB(13, 22, 18),
        Surface3 = Color3.fromRGB(21, 35, 29),
        Text = Color3.fromRGB(244, 255, 249),
        Muted = Color3.fromRGB(148, 172, 160),
        Border = Color3.fromRGB(27, 220, 132),
        Good = Color3.fromRGB(27, 220, 132),
        Warning = Color3.fromRGB(255, 181, 51),
        Error = Color3.fromRGB(255, 64, 84),
        Info = Color3.fromRGB(70, 155, 255)
    }
}

ahst_lib.Themes = Themes

local Icons = {
    home = "home",
    main = "spark",
    player = "user",
    visuals = "eye",
    combat = "crosshair",
    teleports = "map",
    farming = "leaf",
    misc = "grid",
    settings = "gear",
    scripts = "code",
    lightning = "bolt",
    crown = "crown",
    shield = "shield",
    search = "search",
    close = "x",
    minimize = "minus",
    maximize = "square",
    menu = "menu",
    check = "check",
    warning = "!",
    info = "i",
    error = "x",
    user = "user",
    cube = "box",
    star = "spark",
    uptime = "pulse",
    diamond = "diamond"
}

local DefaultTabs = {
    {"Home", "home"},
    {"Main", "main"},
    {"Player", "player"},
    {"Visuals", "visuals"},
    {"Combat", "combat"},
    {"Teleports", "teleports"},
    {"Farming", "farming"},
    {"Misc", "misc"},
    {"Settings", "settings"}
}

local function deepCopy(value)
    if type(value) ~= "table" then
        return value
    end
    local copy = {}
    for key, item in pairs(value) do
        copy[key] = deepCopy(item)
    end
    return copy
end

local function mergeTheme(base, override)
    local merged = deepCopy(base)
    if type(override) == "table" then
        for key, value in pairs(override) do
            merged[key] = value
        end
    end
    return merged
end

local function protect(callback, ...)
    if type(callback) ~= "function" then
        return nil
    end
    local ok, result = pcall(callback, ...)
    if not ok then
        warn("[Anti-Hambreado-Lib] " .. tostring(result))
    end
    return result
end

local function tween(object, goals, duration, style, direction)
    local info = TweenInfo.new(duration or 0.25, style or Enum.EasingStyle.Quint, direction or Enum.EasingDirection.Out)
    local animation = TweenService:Create(object, info, goals)
    animation:Play()
    return animation
end

local function create(className, properties, children)
    local object = Instance.new(className)
    for key, value in pairs(properties or {}) do
        object[key] = value
    end
    for _, child in ipairs(children or {}) do
        child.Parent = object
    end
    return object
end

local function addCorner(parent, radius)
    return create("UICorner", {
        CornerRadius = UDim.new(0, radius or 16),
        Parent = parent
    })
end

local function addStroke(parent, color, transparency, thickness)
    return create("UIStroke", {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = color,
        Transparency = transparency or 0.55,
        Thickness = thickness or 1,
        Parent = parent
    })
end

local function addGradient(parent, colors, rotation, transparency)
    return create("UIGradient", {
        Color = ColorSequence.new(colors),
        Rotation = rotation or 0,
        Transparency = transparency or NumberSequence.new(0),
        Parent = parent
    })
end

local function addPadding(parent, left, right, top, bottom)
    return create("UIPadding", {
        PaddingLeft = UDim.new(0, left or 0),
        PaddingRight = UDim.new(0, right or left or 0),
        PaddingTop = UDim.new(0, top or 0),
        PaddingBottom = UDim.new(0, bottom or top or 0),
        Parent = parent
    })
end

local function iconLine(parent, color, position, size, rotation, zIndex)
    local line = create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        Position = position,
        Rotation = rotation or 0,
        Size = size,
        ZIndex = zIndex or parent.ZIndex + 1,
        Parent = parent
    })
    addCorner(line, 8)
    return line
end

local function iconBox(parent, color, position, size, radius, zIndex)
    local box = create("Frame", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = position,
        Size = size,
        ZIndex = zIndex or parent.ZIndex + 1,
        Parent = parent
    })
    addCorner(box, radius or 8)
    addStroke(box, color, 0, 2)
    return box
end

local function tintIcon(icon, color)
    if not icon then
        return
    end
    for _, item in ipairs(icon:GetDescendants()) do
        if item:IsA("Frame") and item.Name ~= "IconRoot" then
            pcall(function()
                tween(item, {
                    BackgroundColor3 = color
                }, 0.18)
            end)
        elseif item:IsA("UIStroke") then
            pcall(function()
                tween(item, {
                    Color = color
                }, 0.18)
            end)
        elseif item:IsA("TextLabel") then
            pcall(function()
                tween(item, {
                    TextColor3 = color
                }, 0.18)
            end)
        end
    end
end

local function createVectorIcon(parent, name, color, options)
    options = options or {}
    local size = options.Size or 24
    local holder = create("Frame", {
        Name = "IconRoot",
        AnchorPoint = options.AnchorPoint or Vector2.new(0, 0),
        BackgroundTransparency = 1,
        Position = options.Position or UDim2.fromOffset(0, 0),
        Size = UDim2.fromOffset(size, size),
        ZIndex = options.ZIndex or (parent and parent.ZIndex + 1 or 1),
        Parent = parent
    })
    local c = color or Color3.fromRGB(255, 255, 255)
    local n = string.lower(tostring(name or "spark"))
    local function ln(x, y, w, h, rot)
        return iconLine(holder, c, UDim2.fromScale(x, y), UDim2.fromScale(w, h), rot, holder.ZIndex + 1)
    end
    local function bx(x, y, w, h, r)
        return iconBox(holder, c, UDim2.fromScale(x, y), UDim2.fromScale(w, h), r or math.floor(size * 0.16), holder.ZIndex + 1)
    end
    if n == "home" then
        ln(0.38, 0.32, 0.42, 0.09, -38)
        ln(0.62, 0.32, 0.42, 0.09, 38)
        bx(0.25, 0.42, 0.5, 0.42, math.floor(size * 0.12))
        ln(0.5, 0.72, 0.12, 0.24, 0)
    elseif n == "user" then
        bx(0.35, 0.16, 0.3, 0.3, size)
        bx(0.23, 0.56, 0.54, 0.28, size)
    elseif n == "eye" then
        bx(0.18, 0.28, 0.64, 0.42, size)
        bx(0.42, 0.4, 0.16, 0.16, size)
    elseif n == "crosshair" then
        bx(0.26, 0.26, 0.48, 0.48, size)
        ln(0.5, 0.12, 0.08, 0.22, 0)
        ln(0.5, 0.88, 0.08, 0.22, 0)
        ln(0.12, 0.5, 0.22, 0.08, 0)
        ln(0.88, 0.5, 0.22, 0.08, 0)
    elseif n == "map" then
        bx(0.18, 0.24, 0.64, 0.52, math.floor(size * 0.1))
        ln(0.38, 0.5, 0.05, 0.48, 0)
        ln(0.62, 0.5, 0.05, 0.48, 0)
    elseif n == "leaf" then
        bx(0.28, 0.2, 0.48, 0.48, size)
        ln(0.38, 0.72, 0.46, 0.08, -38)
    elseif n == "gear" then
        bx(0.32, 0.32, 0.36, 0.36, size)
        ln(0.5, 0.14, 0.08, 0.22, 0)
        ln(0.5, 0.86, 0.08, 0.22, 0)
        ln(0.14, 0.5, 0.22, 0.08, 0)
        ln(0.86, 0.5, 0.22, 0.08, 0)
        bx(0.43, 0.43, 0.14, 0.14, size)
    elseif n == "search" then
        bx(0.22, 0.18, 0.42, 0.42, size)
        ln(0.72, 0.72, 0.36, 0.08, 45)
    elseif n == "menu" then
        ln(0.5, 0.28, 0.58, 0.08, 0)
        ln(0.5, 0.5, 0.58, 0.08, 0)
        ln(0.5, 0.72, 0.58, 0.08, 0)
    elseif n == "minus" then
        ln(0.5, 0.5, 0.56, 0.08, 0)
    elseif n == "square" then
        bx(0.25, 0.25, 0.5, 0.5, math.floor(size * 0.1))
    elseif n == "x" then
        ln(0.5, 0.5, 0.62, 0.08, 45)
        ln(0.5, 0.5, 0.62, 0.08, -45)
    elseif n == "check" then
        ln(0.38, 0.58, 0.3, 0.08, 45)
        ln(0.62, 0.48, 0.52, 0.08, -45)
    elseif n == "shield" then
        ln(0.5, 0.2, 0.48, 0.08, 0)
        ln(0.3, 0.43, 0.45, 0.08, 80)
        ln(0.7, 0.43, 0.45, 0.08, -80)
        ln(0.41, 0.72, 0.32, 0.08, 42)
        ln(0.59, 0.72, 0.32, 0.08, -42)
    elseif n == "crown" then
        ln(0.5, 0.72, 0.62, 0.1, 0)
        ln(0.3, 0.46, 0.38, 0.1, 62)
        ln(0.5, 0.42, 0.42, 0.1, 90)
        ln(0.7, 0.46, 0.38, 0.1, -62)
    elseif n == "box" then
        bx(0.26, 0.26, 0.48, 0.48, math.floor(size * 0.1))
        ln(0.5, 0.25, 0.34, 0.07, 25)
        ln(0.5, 0.75, 0.34, 0.07, 25)
    elseif n == "diamond" then
        ln(0.5, 0.22, 0.36, 0.08, 42)
        ln(0.5, 0.22, 0.36, 0.08, -42)
        ln(0.5, 0.78, 0.36, 0.08, -42)
        ln(0.5, 0.78, 0.36, 0.08, 42)
    elseif n == "pulse" then
        ln(0.18, 0.56, 0.24, 0.08, 0)
        ln(0.38, 0.48, 0.24, 0.08, -55)
        ln(0.56, 0.58, 0.28, 0.08, 45)
        ln(0.82, 0.42, 0.34, 0.08, -32)
    elseif n == "code" then
        ln(0.34, 0.5, 0.36, 0.08, -45)
        ln(0.34, 0.5, 0.36, 0.08, 45)
        ln(0.66, 0.5, 0.36, 0.08, 45)
        ln(0.66, 0.5, 0.36, 0.08, -45)
    elseif n == "bolt" then
        ln(0.55, 0.32, 0.42, 0.1, -58)
        ln(0.45, 0.68, 0.42, 0.1, -58)
    elseif n == "grid" then
        bx(0.18, 0.18, 0.24, 0.24, math.floor(size * 0.08))
        bx(0.58, 0.18, 0.24, 0.24, math.floor(size * 0.08))
        bx(0.18, 0.58, 0.24, 0.24, math.floor(size * 0.08))
        bx(0.58, 0.58, 0.24, 0.24, math.floor(size * 0.08))
    elseif n == "!" or n == "warning" then
        ln(0.5, 0.42, 0.08, 0.44, 0)
        bx(0.45, 0.72, 0.1, 0.1, size)
    elseif n == "i" or n == "info" then
        bx(0.24, 0.24, 0.52, 0.52, size)
        ln(0.5, 0.57, 0.08, 0.26, 0)
        bx(0.45, 0.3, 0.1, 0.1, size)
    else
        ln(0.5, 0.18, 0.08, 0.36, 0)
        ln(0.5, 0.82, 0.08, 0.36, 0)
        ln(0.18, 0.5, 0.36, 0.08, 0)
        ln(0.82, 0.5, 0.36, 0.08, 0)
    end
    holder:SetAttribute("IconName", n)
    holder:SetAttribute("IconColor", c)
    return holder
end

local function textLabel(properties)
    return create("TextLabel", mergeTheme({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(245, 245, 248),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        RichText = true
    }, properties or {}))
end

local function textButton(properties)
    return create("TextButton", mergeTheme({
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Font = Enum.Font.GothamMedium,
        TextColor3 = Color3.fromRGB(245, 245, 248),
        TextSize = 14
    }, properties or {}))
end

local function textBox(properties)
    return create("TextBox", mergeTheme({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClearTextOnFocus = false,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(245, 245, 248),
        PlaceholderColor3 = Color3.fromRGB(130, 130, 145),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    }, properties or {}))
end

local function getGuiParent()
    local ok, hui = pcall(function()
        if gethui then
            return gethui()
        end
    end)
    if ok and hui then
        return hui
    end
    local coreOk = pcall(function()
        local test = Instance.new("ScreenGui")
        test.Parent = CoreGui
        test:Destroy()
    end)
    if coreOk then
        return CoreGui
    end
    if LocalPlayer then
        return LocalPlayer:WaitForChild("PlayerGui")
    end
    return CoreGui
end

local function getRequest()
    return (syn and syn.request) or (http and http.request) or http_request or request
end

local function ensureFolder(path)
    if makefolder then
        local exists = false
        if isfolder then
            exists = isfolder(path)
        end
        if not exists then
            pcall(makefolder, path)
        end
    end
end

local function resolveAsset(url, fileName)
    if type(url) ~= "string" or url == "" then
        return ""
    end
    if url:match("^rbxasset") or url:match("^rbxthumb") then
        return url
    end
    local requestFunction = getRequest()
    if requestFunction and writefile and getcustomasset then
        local folder = ahst_lib.ConfigFolder .. "/Assets"
        local path = folder .. "/" .. fileName
        local ok = pcall(function()
            ensureFolder(ahst_lib.ConfigFolder)
            ensureFolder(folder)
            if not isfile or not isfile(path) then
                local response = requestFunction({
                    Url = url,
                    Method = "GET"
                })
                if response and response.Body then
                    writefile(path, response.Body)
                end
            end
        end)
        if ok and (not isfile or isfile(path)) then
            local assetOk, asset = pcall(getcustomasset, path)
            if assetOk and asset then
                return asset
            end
        end
    end
    return url
end

local function formatTime(seconds)
    seconds = math.max(0, math.floor(seconds))
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    if hours > 0 then
        return string.format("%02d:%02d:%02d", hours, minutes, secs)
    end
    return string.format("%02d:%02d", minutes, secs)
end

local function roundNumber(value, increment)
    increment = increment or 1
    return math.floor((value / increment) + 0.5) * increment
end

local function colorToTable(color, alpha)
    return {
        R = math.floor(color.R * 255 + 0.5),
        G = math.floor(color.G * 255 + 0.5),
        B = math.floor(color.B * 255 + 0.5),
        A = alpha == nil and 0 or alpha
    }
end

local function tableToColor(value)
    if typeof(value) == "Color3" then
        return value, 0
    end
    if type(value) == "table" then
        return Color3.fromRGB(value.R or value.r or 255, value.G or value.g or 255, value.B or value.b or 255), value.A or value.a or 0
    end
    return Color3.fromRGB(255, 45, 45), 0
end

local function enumName(input)
    if typeof(input) == "EnumItem" then
        return input.Name
    end
    return tostring(input or "None")
end

local function makeRipple(button, theme, input)
    local absolute = button.AbsolutePosition
    local size = button.AbsoluteSize
    local x = size.X / 2
    local y = size.Y / 2
    if typeof(input) == "InputObject" and input.Position then
        x = input.Position.X - absolute.X
        y = input.Position.Y - absolute.Y
    end
    local diameter = math.max(size.X, size.Y) * 1.8
    local ripple = create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = theme.Accent2,
        BackgroundTransparency = 0.62,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(x, y),
        Size = UDim2.fromOffset(0, 0),
        ZIndex = (button.ZIndex or 1) + 3,
        Parent = button
    })
    addCorner(ripple, diameter)
    tween(ripple, {
        Size = UDim2.fromOffset(diameter, diameter),
        BackgroundTransparency = 1
    }, 0.48)
    task.delay(0.5, function()
        if ripple then
            ripple:Destroy()
        end
    end)
end

local function connectHover(instance, enter, leave)
    instance.MouseEnter:Connect(function()
        protect(enter)
    end)
    instance.MouseLeave:Connect(function()
        protect(leave)
    end)
end

local function searchMatch(text, query)
    query = string.lower(query or "")
    if query == "" then
        return true
    end
    return string.find(string.lower(text or ""), query, 1, true) ~= nil
end

local function serializeValue(value)
    if typeof(value) == "Color3" then
        return colorToTable(value, 0)
    end
    if typeof(value) == "EnumItem" then
        return value.Name
    end
    if type(value) == "table" then
        local result = {}
        for key, item in pairs(value) do
            if typeof(item) == "Color3" then
                result[key] = colorToTable(item, 0)
            elseif typeof(item) == "EnumItem" then
                result[key] = item.Name
            else
                result[key] = item
            end
        end
        return result
    end
    return value
end

local WindowClass = {}
WindowClass.__index = WindowClass

local TabClass = {}
TabClass.__index = TabClass

local SectionClass = {}
SectionClass.__index = SectionClass

function ahst_lib:CreateTheme(name, data)
    if type(name) == "string" and type(data) == "table" then
        Themes[name] = mergeTheme(Themes["AMOLED Red"], data)
    end
    return Themes[name]
end

function ahst_lib:GetTheme(name)
    return Themes[name] or Themes["AMOLED Red"]
end

function ahst_lib:SafeCall(callback, ...)
    return protect(callback, ...)
end

function ahst_lib:Notify(options)
    if self.CurrentWindow then
        return self.CurrentWindow:Notify(options)
    end
end

function ahst_lib:CreateWindow(options)
    options = options or {}
    local theme = mergeTheme(Themes["AMOLED Red"], Themes[options.Theme or "AMOLED Red"])
    if type(options.Theme) == "table" then
        theme = mergeTheme(theme, options.Theme)
    end
    local guiName = options.Name or "AntiHambreadoPremiumLibrary"
    local parent = getGuiParent()
    local old = parent:FindFirstChild(guiName)
    if old then
        old:Destroy()
    end
    local screenGui = create("ScreenGui", {
        Name = guiName,
        DisplayOrder = options.DisplayOrder or 999999,
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = parent
    })
    local window = setmetatable({
        Library = self,
        Options = options,
        Gui = screenGui,
        Theme = theme,
        ThemeName = options.Theme or "AMOLED Red",
        Tabs = {},
        Sections = {},
        Searchables = {},
        Flags = {},
        Components = {},
        Connections = {},
        ActiveTab = nil,
        Minimized = false,
        Maximized = false,
        SidebarCollapsed = false,
        Size = options.Size or UDim2.fromOffset(1200, 700),
        MinSize = options.MinSize or Vector2.new(760, 460),
        MaxSize = options.MaxSize or Vector2.new(1500, 860),
        NotificationCount = 0
    }, WindowClass)
    self.CurrentWindow = window
    table.insert(self.Windows, window)
    window:_build()
    if options.AutoCreateDefaultTabs then
        window:CreateDefaultTabs()
    end
    protect(options.Callback, window)
    return window
end

function WindowClass:_build()
    local theme = self.Theme
    self.Background = create("Frame", {
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        Parent = self.Gui
    })
    self.Root = create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = theme.Background,
        BackgroundTransparency = 0.04,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = self.Size,
        Parent = self.Gui
    })
    addCorner(self.Root, 24)
    self.RootStroke = addStroke(self.Root, theme.Border, 0.2, 1.4)
    self.RootScale = create("UIScale", {
        Scale = 0.985,
        Parent = self.Root
    })
    addGradient(self.Root, {
        ColorSequenceKeypoint.new(0, theme.Surface2),
        ColorSequenceKeypoint.new(0.5, theme.Background),
        ColorSequenceKeypoint.new(1, theme.AccentDark)
    }, 23, NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.15),
        NumberSequenceKeypoint.new(0.6, 0.34),
        NumberSequenceKeypoint.new(1, 0.1)
    }))
    self.BackgroundImage = create("ImageLabel", {
        BackgroundTransparency = 1,
        Image = "",
        ImageColor3 = Color3.fromRGB(255, 255, 255),
        ImageTransparency = 0.24,
        ScaleType = Enum.ScaleType.Crop,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 0,
        Parent = self.Root
    })
    task.spawn(function()
        local asset = resolveAsset(self.Options.BackgroundImage or ahst_lib.Assets.Background, "Fondo-Lib.png")
        if self.BackgroundImage and self.BackgroundImage.Parent then
            self.BackgroundImage.Image = asset
        end
    end)
    self.DimLayer = create("Frame", {
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.32,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 1,
        Parent = self.Root
    })
    self.RedGlow = create("Frame", {
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = theme.Accent,
        BackgroundTransparency = 0.8,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -70, 0, 80),
        Size = UDim2.fromOffset(300, 240),
        ZIndex = 1,
        Parent = self.Root
    })
    addCorner(self.RedGlow, 220)
    addGradient(self.RedGlow, {
        ColorSequenceKeypoint.new(0, theme.Accent),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    }, 90, NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.42),
        NumberSequenceKeypoint.new(1, 1)
    }))
    task.spawn(function()
        while self.RedGlow and self.RedGlow.Parent do
            tween(self.RedGlow, {
                BackgroundTransparency = 0.86,
                Size = UDim2.fromOffset(330, 260)
            }, 2.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            task.wait(2.4)
            tween(self.RedGlow, {
                BackgroundTransparency = 0.76,
                Size = UDim2.fromOffset(300, 240)
            }, 2.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            task.wait(2.4)
        end
    end)
    self.Sidebar = create("Frame", {
        BackgroundColor3 = theme.Surface,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 260, 1, 0),
        ZIndex = 4,
        Parent = self.Root
    })
    addStroke(self.Sidebar, theme.Text, 0.92, 1)
    addGradient(self.Sidebar, {
        ColorSequenceKeypoint.new(0, theme.Surface2),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    }, 90, NumberSequence.new(0.18))
    local sidebarLine = create("Frame", {
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = theme.Accent,
        BackgroundTransparency = 0.55,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(1, 0),
        Size = UDim2.new(0, 1, 1, 0),
        ZIndex = 5,
        Parent = self.Sidebar
    })
    addGradient(sidebarLine, {
        ColorSequenceKeypoint.new(0, theme.Accent),
        ColorSequenceKeypoint.new(0.5, theme.Accent2),
        ColorSequenceKeypoint.new(1, theme.Accent)
    }, 90)
    self.Brand = create("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 120),
        ZIndex = 6,
        Parent = self.Sidebar
    })
    self.BrandIcon = create("Frame", {
        BackgroundColor3 = theme.AccentDark,
        BackgroundTransparency = 0.28,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(28, 22),
        Size = UDim2.fromOffset(54, 54),
        ZIndex = 6,
        Parent = self.Brand
    })
    addCorner(self.BrandIcon, 16)
    self.BrandIconStroke = addStroke(self.BrandIcon, theme.Accent, 0.28, 1.2)
    self.BrandVectorIcon = createVectorIcon(self.BrandIcon, Icons.crown, theme.Accent, {
        Size = 30,
        Position = UDim2.fromOffset(12, 12),
        ZIndex = 7
    })
    self.BrandTitle = textLabel({
        Font = Enum.Font.GothamBold,
        Text = self.Options.Title or "ANUNCOS",
        TextColor3 = theme.Text,
        TextSize = 18,
        Position = UDim2.fromOffset(92, 26),
        Size = UDim2.new(1, -104, 0, 24),
        ZIndex = 6
    })
    self.BrandTitle.Parent = self.Brand
    self.BrandSubtitle = textLabel({
        Font = Enum.Font.GothamMedium,
        Text = self.Options.Subtitle or "SCRIPT HUB",
        TextColor3 = theme.Accent,
        TextSize = 13,
        Position = UDim2.fromOffset(92, 54),
        Size = UDim2.new(1, -104, 0, 20),
        ZIndex = 6
    })
    self.BrandSubtitle.Parent = self.Brand
    self.SidebarToggle = textButton({
        BackgroundColor3 = theme.Surface2,
        BackgroundTransparency = 0.35,
        Position = UDim2.new(1, -52, 0, 88),
        Size = UDim2.fromOffset(32, 32),
        Text = "",
        TextColor3 = theme.Muted,
        TextSize = 18,
        ZIndex = 7,
        Parent = self.Brand
    })
    addCorner(self.SidebarToggle, 10)
    addStroke(self.SidebarToggle, theme.Text, 0.88, 1)
    self.SidebarToggleIcon = createVectorIcon(self.SidebarToggle, Icons.menu, theme.Muted, {
        Size = 18,
        Position = UDim2.fromOffset(7, 7),
        ZIndex = 8
    })
    self.SidebarToggle.MouseButton1Click:Connect(function()
        self:ToggleSidebar()
    end)
    connectHover(self.SidebarToggle, function()
        tween(self.SidebarToggle, {
            BackgroundTransparency = 0.18
        }, 0.16)
        tintIcon(self.SidebarToggleIcon, self.Theme.Text)
    end, function()
        tween(self.SidebarToggle, {
            BackgroundTransparency = 0.35
        }, 0.16)
        tintIcon(self.SidebarToggleIcon, self.Theme.Muted)
    end)
    self.NavFrame = create("ScrollingFrame", {
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        CanvasSize = UDim2.fromOffset(0, 0),
        Position = UDim2.fromOffset(20, 140),
        ScrollBarImageColor3 = theme.Accent,
        ScrollBarThickness = 2,
        Size = UDim2.new(1, -40, 1, -290),
        ZIndex = 6,
        Parent = self.Sidebar
    })
    addPadding(self.NavFrame, 0, 0, 0, 8)
    create("UIListLayout", {
        Padding = UDim.new(0, 12),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = self.NavFrame
    })
    self.Profile = create("Frame", {
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = theme.Surface2,
        BackgroundTransparency = 0.18,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 20, 1, -54),
        Size = UDim2.new(1, -40, 0, 76),
        ZIndex = 6,
        Parent = self.Sidebar
    })
    addCorner(self.Profile, 14)
    addStroke(self.Profile, theme.Text, 0.88, 1)
    self.Avatar = create("ImageLabel", {
        BackgroundColor3 = theme.Surface,
        Image = "",
        ScaleType = Enum.ScaleType.Crop,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(16, 14),
        Size = UDim2.fromOffset(48, 48),
        ZIndex = 7,
        Parent = self.Profile
    })
    addCorner(self.Avatar, 48)
    addStroke(self.Avatar, theme.Accent, 0.28, 1.2)
    self.AvatarFallbackIcon = createVectorIcon(self.Avatar, Icons.user, theme.Accent, {
        Size = 24,
        Position = UDim2.fromOffset(12, 12),
        ZIndex = 8
    })
    task.spawn(function()
        if LocalPlayer then
            local ok, image = pcall(function()
                return Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
            end)
            if ok and image and self.Avatar and self.Avatar.Parent then
                self.Avatar.Image = image
                if self.AvatarFallbackIcon then
                    self.AvatarFallbackIcon.Visible = false
                end
            end
        end
    end)
    self.ProfileName = textLabel({
        Font = Enum.Font.GothamMedium,
        Text = self.Options.UserName or (LocalPlayer and LocalPlayer.DisplayName) or "Anuncos",
        TextColor3 = theme.Text,
        TextSize = 14,
        Position = UDim2.fromOffset(78, 16),
        Size = UDim2.new(1, -90, 0, 20),
        ZIndex = 7,
        Parent = self.Profile
    })
    self.ProfileStatus = textLabel({
        Font = Enum.Font.GothamMedium,
        Text = self.Options.UserStatus or "Premium User",
        TextColor3 = theme.Accent,
        TextSize = 12,
        Position = UDim2.fromOffset(78, 40),
        Size = UDim2.new(1, -90, 0, 18),
        ZIndex = 7,
        Parent = self.Profile
    })
    self.VersionLabel = textLabel({
        AnchorPoint = Vector2.new(0, 1),
        Font = Enum.Font.Gotham,
        Text = "v" .. ahst_lib.Version .. "  -  Premium Edition",
        TextColor3 = theme.Muted,
        TextSize = 12,
        Position = UDim2.new(0, 36, 1, -20),
        Size = UDim2.new(1, -56, 0, 20),
        ZIndex = 6,
        Parent = self.Sidebar
    })
    self.Topbar = create("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(260, 0),
        Size = UDim2.new(1, -260, 0, 86),
        ZIndex = 8,
        Parent = self.Root
    })
    self.SearchContainer = create("Frame", {
        BackgroundColor3 = theme.Surface,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(32, 22),
        Size = UDim2.fromOffset(400, 42),
        ZIndex = 9,
        Parent = self.Topbar
    })
    addCorner(self.SearchContainer, 14)
    addStroke(self.SearchContainer, theme.Text, 0.9, 1)
    self.SearchIcon = createVectorIcon(self.SearchContainer, Icons.search, theme.Muted, {
        Size = 22,
        Position = UDim2.fromOffset(16, 10),
        ZIndex = 10
    })
    self.SearchBox = textBox({
        PlaceholderText = "Search anything...",
        Text = "",
        Position = UDim2.fromOffset(52, 0),
        Size = UDim2.new(1, -64, 1, 0),
        TextColor3 = theme.Text,
        PlaceholderColor3 = theme.Muted,
        ZIndex = 10,
        Parent = self.SearchContainer
    })
    self.SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        self:_applySearch(self.SearchBox.Text)
    end)
    self.Controls = create("Frame", {
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = theme.Surface,
        BackgroundTransparency = 0.22,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -24, 0, 22),
        Size = UDim2.fromOffset(150, 42),
        ZIndex = 12,
        Parent = self.Topbar
    })
    addCorner(self.Controls, 14)
    addStroke(self.Controls, theme.Text, 0.9, 1)
    local controlsLayout = create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Parent = self.Controls
    })
    addPadding(self.Controls, 8, 8, 0, 0)
    self.MinimizeButton = self:_windowControl(Icons.minimize, function()
        self:Minimize()
    end)
    self.MaximizeButton = self:_windowControl(Icons.maximize, function()
        self:Maximize()
    end)
    self.CloseButton = self:_windowControl(Icons.close, function()
        self:Close()
    end, true)
    self.ContentHost = create("Frame", {
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Position = UDim2.fromOffset(260, 86),
        Size = UDim2.new(1, -260, 1, -132),
        ZIndex = 6,
        Parent = self.Root
    })
    self.Mascot = create("ImageLabel", {
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        Image = "",
        ImageTransparency = 0,
        Position = UDim2.new(1, -40, 0, 0),
        ScaleType = Enum.ScaleType.Fit,
        Size = UDim2.fromOffset(360, 300),
        ZIndex = 5,
        Parent = self.ContentHost
    })
    task.spawn(function()
        local asset = resolveAsset(self.Options.MascotImage or ahst_lib.Assets.Mascot, "Anti-Girl-Lib.jpg")
        if self.Mascot and self.Mascot.Parent then
            self.Mascot.Image = asset
        end
    end)
    self:_createHero()
    self.Footer = create("Frame", {
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = theme.Surface,
        BackgroundTransparency = 0.22,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 292, 1, -14),
        Size = UDim2.new(1, -324, 0, 42),
        ZIndex = 10,
        Parent = self.Root
    })
    addCorner(self.Footer, 14)
    addStroke(self.Footer, theme.Text, 0.9, 1)
    self.FooterLayout = create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 24),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Parent = self.Footer
    })
    addPadding(self.Footer, 18, 18, 0, 0)
    self.FooterStatus = self:_footerMetric("Status", "Undetected", theme.Accent)
    self.FooterFps = self:_footerMetric("FPS", "0", theme.Good)
    self.FooterPing = self:_footerMetric("Ping", "0ms", theme.Info)
    self.FooterRuntime = self:_footerMetric("Runtime", "00:00", theme.Warning)
    self.ResizeGrip = create("Frame", {
        AnchorPoint = Vector2.new(1, 1),
        BackgroundColor3 = theme.Accent,
        BackgroundTransparency = 0.35,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -12, 1, -12),
        Size = UDim2.fromOffset(18, 18),
        ZIndex = 30,
        Parent = self.Root
    })
    addCorner(self.ResizeGrip, 6)
    self.Notifications = create("Frame", {
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -22, 0, 86),
        Size = UDim2.fromOffset(330, 520),
        ZIndex = 80,
        Parent = self.Gui
    })
    create("UIListLayout", {
        Padding = UDim.new(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Parent = self.Notifications
    })
    self.ModalLayer = create("Frame", {
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        Visible = false,
        ZIndex = 100,
        Parent = self.Gui
    })
    self:_enableDrag()
    self:_enableResize()
    self:_startStats()
    tween(self.RootScale, {
        Scale = 1
    }, 0.5, Enum.EasingStyle.Exponential)
end

function WindowClass:_windowControl(text, callback, danger)
    local button = textButton({
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(38, 30),
        Text = "",
        TextColor3 = danger and self.Theme.Accent or self.Theme.Muted,
        TextSize = 22,
        ZIndex = 13,
        Parent = self.Controls
    })
    addCorner(button, 10)
    button.Icon = createVectorIcon(button, text, danger and self.Theme.Accent or self.Theme.Muted, {
        Size = 16,
        Position = UDim2.fromOffset(11, 7),
        ZIndex = 14
    })
    connectHover(button, function()
        button.BackgroundTransparency = 0.2
        button.BackgroundColor3 = danger and self.Theme.AccentDark or self.Theme.Surface3
        tintIcon(button.Icon, danger and self.Theme.Accent2 or self.Theme.Text)
    end, function()
        tintIcon(button.Icon, danger and self.Theme.Accent or self.Theme.Muted)
        tween(button, {
            BackgroundTransparency = 1
        }, 0.16)
    end)
    button.MouseButton1Click:Connect(function()
        makeRipple(button, self.Theme)
        protect(callback)
    end)
    return button
end

function WindowClass:_footerMetric(label, value, color)
    local frame = create("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(180, 28),
        ZIndex = 11,
        Parent = self.Footer
    })
    local name = textLabel({
        Font = Enum.Font.Gotham,
        Text = label,
        TextColor3 = self.Theme.Muted,
        TextSize = 11,
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.fromOffset(58, 28),
        ZIndex = 12,
        Parent = frame
    })
    local valueLabel = textLabel({
        Font = Enum.Font.GothamMedium,
        Text = value,
        TextColor3 = color,
        TextSize = 13,
        Position = UDim2.fromOffset(62, 0),
        Size = UDim2.new(1, -62, 1, 0),
        ZIndex = 12,
        Parent = frame
    })
    return valueLabel
end

function WindowClass:_heroCard(titleText, valueText, iconText, color)
    local card = create("Frame", {
        BackgroundColor3 = self.Theme.Surface,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Size = UDim2.fromOffset(160, 76),
        ZIndex = 15,
        Parent = self.HeroCards
    })
    addCorner(card, 12)
    addStroke(card, self.Theme.Text, 0.9, 1)
    local title = textLabel({
        Font = Enum.Font.Gotham,
        Text = titleText,
        TextColor3 = self.Theme.Text,
        TextSize = 12,
        Position = UDim2.fromOffset(16, 12),
        Size = UDim2.new(1, -32, 0, 20),
        ZIndex = 16,
        Parent = card
    })
    local value = textLabel({
        Font = Enum.Font.GothamBold,
        Text = valueText,
        TextColor3 = color or self.Theme.Accent,
        TextSize = 15,
        Position = UDim2.fromOffset(16, 36),
        Size = UDim2.new(1, -58, 0, 24),
        ZIndex = 16,
        Parent = card
    })
    local icon = createVectorIcon(card, iconText or Icons.star, color or self.Theme.Accent, {
        Size = 26,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -16, 0.5, 8),
        ZIndex = 16
    })
    return {
        Instance = card,
        Title = title,
        Value = value,
        Icon = icon
    }
end

function WindowClass:_createHero()
    self.HeroBlock = create("Frame", {
        BackgroundTransparency = 1,
        LayoutOrder = -100,
        Size = UDim2.new(1, -8, 0, 238),
        ZIndex = 14,
        Parent = self.ContentHost
    })
    self.Hero = create("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, 6),
        Size = UDim2.new(1, -360, 0, 128),
        ZIndex = 14,
        Parent = self.HeroBlock
    })
    self.HeroWelcome = textLabel({
        Font = Enum.Font.Gotham,
        Text = "Welcome back,",
        TextColor3 = self.Theme.Muted,
        TextSize = 18,
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.new(1, 0, 0, 28),
        ZIndex = 15,
        Parent = self.Hero
    })
    self.HeroTitle = textLabel({
        Font = Enum.Font.GothamBold,
        Text = self.Options.Title or "Anuncos",
        TextColor3 = self.Theme.Text,
        TextSize = 38,
        Position = UDim2.fromOffset(0, 28),
        Size = UDim2.new(1, 0, 0, 48),
        ZIndex = 15,
        Parent = self.Hero
    })
    self.HeroGem = createVectorIcon(self.Hero, Icons.diamond, self.Theme.Accent, {
        Size = 36,
        Position = UDim2.fromOffset(210, 32),
        ZIndex = 15
    })
    self.HeroSubtitle = textLabel({
        Font = Enum.Font.GothamMedium,
        Text = self.Options.HeroSubtitle or "Premium access - Expires in 365 days",
        TextColor3 = self.Theme.Text,
        TextSize = 13,
        Position = UDim2.fromOffset(0, 78),
        Size = UDim2.new(1, 0, 0, 24),
        ZIndex = 15,
        Parent = self.Hero
    })
    self.HeroCards = create("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, 150),
        Size = UDim2.new(1, -18, 0, 78),
        ZIndex = 14,
        Parent = self.HeroBlock
    })
    create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 14),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = self.HeroCards
    })
    self.HeroUser = self:_heroCard("User", "Premium", Icons.crown, self.Theme.Accent)
    self.HeroUptime = self:_heroCard("Uptime", "99.9%", Icons.uptime, self.Theme.Accent)
    self.HeroScripts = self:_heroCard("Scripts", "24", Icons.cube, self.Theme.Accent)
    self.HeroStatus = self:_heroCard("Status", "Undetected", Icons.shield, self.Theme.Accent)
end

function WindowClass:_createSpaceBackground(parent)
    local theme = self.Theme
    local base = create("Frame", {
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        Parent = parent
    })
    addGradient(base, {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(0.45, Color3.fromRGB(3, 6, 22)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    }, 28)
    local random = Random.new(26)
    for index = 1, 90 do
        local starSize = random:NextNumber(1, 3.4)
        local star = create("Frame", {
            BackgroundColor3 = index % 7 == 0 and theme.Accent or (index % 5 == 0 and Color3.fromRGB(56, 143, 255) or Color3.fromRGB(255, 255, 255)),
            BackgroundTransparency = random:NextNumber(0.1, 0.55),
            BorderSizePixel = 0,
            Position = UDim2.fromScale(random:NextNumber(0, 1), random:NextNumber(0, 1)),
            Size = UDim2.fromOffset(starSize, starSize),
            Parent = base
        })
        addCorner(star, 8)
        task.spawn(function()
            while star.Parent do
                tween(star, {
                    BackgroundTransparency = random:NextNumber(0.55, 0.9)
                }, random:NextNumber(1.4, 3.6), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                task.wait(random:NextNumber(1.4, 3.6))
                tween(star, {
                    BackgroundTransparency = random:NextNumber(0.08, 0.38)
                }, random:NextNumber(1.4, 3.6), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                task.wait(random:NextNumber(1.4, 3.6))
            end
        end)
    end
end

function WindowClass:_enableDrag()
    local dragging = false
    local dragStart
    local startPosition
    local dragInput
    self.Topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPosition = self.Root.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    self.Topbar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging and not self.Maximized then
            local delta = input.Position - dragStart
            self.Root.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
        end
    end)
end

function WindowClass:_enableResize()
    local resizing = false
    local startSize
    local startPoint
    self.ResizeGrip.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            startPoint = input.Position
            startSize = self.Root.AbsoluteSize
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    resizing = false
                end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and not self.Maximized then
            local delta = input.Position - startPoint
            local width = math.clamp(startSize.X + delta.X, self.MinSize.X, self.MaxSize.X)
            local height = math.clamp(startSize.Y + delta.Y, self.MinSize.Y, self.MaxSize.Y)
            self.Root.Size = UDim2.fromOffset(width, height)
        end
    end)
end

function WindowClass:_startStats()
    local frames = 0
    local last = os.clock()
    RunService.RenderStepped:Connect(function()
        frames += 1
        local now = os.clock()
        if now - last >= 1 then
            if self.FooterFps then
                self.FooterFps.Text = tostring(frames)
            end
            frames = 0
            last = now
            if self.FooterRuntime then
                self.FooterRuntime.Text = formatTime(now - ClockStart)
            end
            if self.FooterPing then
                local ping = "0ms"
                pcall(function()
                    local item = StatsService.Network.ServerStatsItem["Data Ping"]
                    ping = item:GetValueString()
                end)
                self.FooterPing.Text = tostring(ping)
            end
        end
    end)
end

function WindowClass:_applySearch(query)
    for _, entry in ipairs(self.Searchables) do
        if entry.Instance and entry.Instance.Parent then
            entry.Instance.Visible = searchMatch(entry.Text, query)
        end
    end
end

function WindowClass:_registerSearch(instance, text)
    table.insert(self.Searchables, {
        Instance = instance,
        Text = text or ""
    })
end

function WindowClass:_updateContentPositions()
    local sidebarWidth = self.SidebarCollapsed and 86 or 260
    tween(self.Sidebar, {
        Size = UDim2.new(0, sidebarWidth, 1, 0)
    }, 0.3)
    tween(self.Topbar, {
        Position = UDim2.fromOffset(sidebarWidth, 0),
        Size = UDim2.new(1, -sidebarWidth, 0, 86)
    }, 0.3)
    tween(self.ContentHost, {
        Position = UDim2.fromOffset(sidebarWidth, 86),
        Size = UDim2.new(1, -sidebarWidth, 1, -132)
    }, 0.3)
    tween(self.Footer, {
        Position = UDim2.new(0, sidebarWidth + 32, 1, -14),
        Size = UDim2.new(1, -(sidebarWidth + 64), 0, 42)
    }, 0.3)
end

function WindowClass:ToggleSidebar(force)
    if force ~= nil then
        self.SidebarCollapsed = force
    else
        self.SidebarCollapsed = not self.SidebarCollapsed
    end
    for _, tab in ipairs(self.Tabs) do
        if tab.TitleLabel then
            tab.TitleLabel.Visible = not self.SidebarCollapsed
        end
        if tab.SubtitleLabel then
            tab.SubtitleLabel.Visible = not self.SidebarCollapsed
        end
        if tab.Button then
            tween(tab.Button, {
                Size = self.SidebarCollapsed and UDim2.fromOffset(46, 58) or UDim2.new(1, 0, 0, 58)
            }, 0.25)
        end
    end
    self.BrandTitle.Visible = not self.SidebarCollapsed
    self.BrandSubtitle.Visible = not self.SidebarCollapsed
    self.ProfileName.Visible = not self.SidebarCollapsed
    self.ProfileStatus.Visible = not self.SidebarCollapsed
    self.VersionLabel.Visible = not self.SidebarCollapsed
    tween(self.BrandIcon, {
        Position = self.SidebarCollapsed and UDim2.fromOffset(16, 22) or UDim2.fromOffset(28, 22)
    }, 0.25)
    tween(self.NavFrame, {
        Position = self.SidebarCollapsed and UDim2.fromOffset(20, 140) or UDim2.fromOffset(20, 140),
        Size = self.SidebarCollapsed and UDim2.new(1, -40, 1, -290) or UDim2.new(1, -40, 1, -290)
    }, 0.25)
    self:_updateContentPositions()
end

function WindowClass:Minimize(force)
    if force ~= nil then
        self.Minimized = force
    else
        self.Minimized = not self.Minimized
    end
    if self.Minimized then
        self.StoredSize = self.Root.Size
        tween(self.Root, {
            Size = UDim2.fromOffset(420, 82)
        }, 0.32)
        self.ContentHost.Visible = false
        self.Sidebar.Visible = false
        self.Footer.Visible = false
        self.ResizeGrip.Visible = false
        self.Topbar.Position = UDim2.fromOffset(0, 0)
        self.Topbar.Size = UDim2.new(1, 0, 1, 0)
    else
        self.ContentHost.Visible = true
        self.Sidebar.Visible = true
        self.Footer.Visible = true
        self.ResizeGrip.Visible = true
        self:_updateContentPositions()
        tween(self.Root, {
            Size = self.StoredSize or self.Size
        }, 0.32)
    end
end

function WindowClass:Maximize(force)
    if force ~= nil then
        self.Maximized = force
    else
        self.Maximized = not self.Maximized
    end
    if self.Maximized then
        self.StoredSize = self.Root.Size
        self.StoredPosition = self.Root.Position
        tween(self.Root, {
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.new(1, -34, 1, -34)
        }, 0.34)
    else
        tween(self.Root, {
            Position = self.StoredPosition or UDim2.fromScale(0.5, 0.5),
            Size = self.StoredSize or self.Size
        }, 0.34)
    end
end

function WindowClass:Close()
    tween(self.Root, {
        Size = UDim2.fromOffset(math.max(120, self.Root.AbsoluteSize.X * 0.88), math.max(80, self.Root.AbsoluteSize.Y * 0.88)),
        BackgroundTransparency = 1
    }, 0.22)
    tween(self.Background, {
        BackgroundTransparency = 1
    }, 0.22)
    task.delay(0.24, function()
        if self.Gui then
            self.Gui:Destroy()
        end
    end)
end

function WindowClass:SetStatus(text, color)
    if self.FooterStatus then
        self.FooterStatus.Text = tostring(text)
        self.FooterStatus.TextColor3 = color or self.Theme.Accent
    end
end

function WindowClass:CreateDefaultTabs()
    local created = {}
    for _, info in ipairs(DefaultTabs) do
        table.insert(created, self:CreateTab(info[1], info[2]))
    end
    return created
end

function WindowClass:CreateTab(name, icon)
    local tab = setmetatable({
        Window = self,
        Name = name,
        Icon = icon or string.lower(name),
        Sections = {},
        Components = {}
    }, TabClass)
    tab.Button = textButton({
        BackgroundColor3 = self.Theme.Surface2,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 58),
        Text = "",
        ZIndex = 8,
        Parent = self.NavFrame
    })
    addCorner(tab.Button, 12)
    tab.ButtonStroke = addStroke(tab.Button, self.Theme.Accent, 1, 1)
    tab.Indicator = create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = self.Theme.Accent,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.fromOffset(3, 28),
        ZIndex = 9,
        Parent = tab.Button
    })
    addCorner(tab.Indicator, 8)
    tab.IconCircle = create("Frame", {
        BackgroundColor3 = self.Theme.Surface3,
        BackgroundTransparency = 0.42,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(16, 9),
        Size = UDim2.fromOffset(40, 40),
        ZIndex = 9,
        Parent = tab.Button
    })
    addCorner(tab.IconCircle, 14)
    tab.IconLabel = createVectorIcon(tab.IconCircle, Icons[string.lower(tostring(tab.Icon))] or tostring(icon or "spark"), self.Theme.Muted, {
        Size = 22,
        Position = UDim2.fromOffset(9, 9),
        ZIndex = 10
    })
    tab.TitleLabel = textLabel({
        Font = Enum.Font.GothamMedium,
        Text = name,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        Position = UDim2.fromOffset(70, 10),
        Size = UDim2.new(1, -82, 0, 22),
        ZIndex = 9,
        Parent = tab.Button
    })
    tab.SubtitleLabel = textLabel({
        Font = Enum.Font.Gotham,
        Text = tab:_subtitleFor(name),
        TextColor3 = self.Theme.Muted,
        TextSize = 12,
        Position = UDim2.fromOffset(70, 32),
        Size = UDim2.new(1, -82, 0, 18),
        ZIndex = 9,
        Parent = tab.Button
    })
    tab.Page = create("ScrollingFrame", {
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        CanvasSize = UDim2.fromOffset(0, 0),
        Position = UDim2.fromOffset(32, 0),
        ScrollBarImageColor3 = self.Theme.Accent,
        ScrollBarThickness = 3,
        Size = UDim2.new(1, -64, 1, 0),
        Visible = false,
        ZIndex = 12,
        Parent = self.ContentHost
    })
    addPadding(tab.Page, 0, 8, 8, 16)
    tab.Layout = create("UIListLayout", {
        Padding = UDim.new(0, 14),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = tab.Page
    })
    tab.Button.MouseButton1Click:Connect(function()
        self:SelectTab(tab)
    end)
    connectHover(tab.Button, function()
        if self.ActiveTab ~= tab then
            tween(tab.Button, {
                BackgroundTransparency = 0.78
            }, 0.16)
            tween(tab.IconCircle, {
                BackgroundTransparency = 0.2
            }, 0.16)
            tintIcon(tab.IconLabel, self.Theme.Text)
        end
    end, function()
        if self.ActiveTab ~= tab then
            tween(tab.Button, {
                BackgroundTransparency = 1
            }, 0.16)
            tween(tab.IconCircle, {
                BackgroundTransparency = 0.42
            }, 0.16)
            tintIcon(tab.IconLabel, self.Theme.Muted)
        end
    end)
    table.insert(self.Tabs, tab)
    if not self.ActiveTab then
        self:SelectTab(tab)
    end
    return tab
end

function WindowClass:SelectTab(tab)
    for _, item in ipairs(self.Tabs) do
        local active = item == tab
        item.Page.Visible = active
        tween(item.Button, {
            BackgroundTransparency = active and 0.25 or 1,
            BackgroundColor3 = active and self.Theme.AccentDark or self.Theme.Surface2
        }, 0.22)
        tween(item.ButtonStroke, {
            Transparency = active and 0.15 or 1
        }, 0.22)
        tween(item.Indicator, {
            BackgroundTransparency = active and 0 or 1
        }, 0.22)
        tween(item.IconCircle, {
            BackgroundColor3 = active and self.Theme.Accent or self.Theme.Surface3,
            BackgroundTransparency = active and 0.15 or 0.42
        }, 0.22)
        tintIcon(item.IconLabel, active and Color3.fromRGB(255, 255, 255) or self.Theme.Muted)
        if active then
            item.Page.CanvasPosition = Vector2.new(0, 0)
            if self.HeroBlock then
                self.HeroBlock.Parent = item.Page
                self.HeroBlock.LayoutOrder = -100
                self.HeroBlock.Visible = true
            end
        end
    end
    self.ActiveTab = tab
    if self.HeroTitle then
        self.HeroTitle.Text = tab.Name
    end
end

function WindowClass:Notify(options)
    options = options or {}
    if type(options) == "string" then
        options = {Title = options}
    end
    local kind = string.lower(options.Type or options.Kind or "Info")
    local color = self.Theme.Info
    local icon = Icons.info
    if kind == "success" then
        color = self.Theme.Good
        icon = Icons.check
    elseif kind == "warning" then
        color = self.Theme.Warning
        icon = Icons.warning
    elseif kind == "error" then
        color = self.Theme.Error
        icon = Icons.error
    end
    self.NotificationCount += 1
    local frame = create("Frame", {
        BackgroundColor3 = self.Theme.Surface,
        BackgroundTransparency = 0.08,
        BorderSizePixel = 0,
        LayoutOrder = -self.NotificationCount,
        Position = UDim2.fromOffset(360, 0),
        Size = UDim2.fromOffset(320, 92),
        ZIndex = 81,
        Parent = self.Notifications
    })
    addCorner(frame, 16)
    addStroke(frame, color, 0.2, 1)
    local marker = create("Frame", {
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 3, 1, -24),
        Position = UDim2.fromOffset(0, 12),
        ZIndex = 82,
        Parent = frame
    })
    addCorner(marker, 6)
    local iconLabel = createVectorIcon(frame, icon, color, {
        Size = 24,
        Position = UDim2.fromOffset(18, 14),
        ZIndex = 82
    })
    local title = textLabel({
        Font = Enum.Font.GothamBold,
        Text = options.Title or "Notification",
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        Position = UDim2.fromOffset(56, 14),
        Size = UDim2.new(1, -72, 0, 22),
        ZIndex = 82,
        Parent = frame
    })
    local content = textLabel({
        Font = Enum.Font.Gotham,
        Text = options.Content or options.Message or "",
        TextColor3 = self.Theme.Muted,
        TextSize = 12,
        TextWrapped = true,
        TextYAlignment = Enum.TextYAlignment.Top,
        Position = UDim2.fromOffset(56, 40),
        Size = UDim2.new(1, -72, 0, 38),
        ZIndex = 82,
        Parent = frame
    })
    tween(frame, {
        Position = UDim2.fromOffset(0, 0)
    }, 0.34, Enum.EasingStyle.Back)
    local duration = options.Duration or 4
    task.delay(duration, function()
        if frame.Parent then
            tween(frame, {
                Position = UDim2.fromOffset(360, 0),
                BackgroundTransparency = 1
            }, 0.28)
            task.delay(0.3, function()
                if frame then
                    frame:Destroy()
                end
            end)
        end
    end)
    return frame
end

function WindowClass:Dialog(options)
    options = options or {}
    self.ModalLayer.Visible = true
    tween(self.ModalLayer, {
        BackgroundTransparency = 0.38
    }, 0.2)
    local card = create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = self.Theme.Surface,
        BackgroundTransparency = 0.03,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(420, options.Prompt and 248 or 210),
        ZIndex = 101,
        Parent = self.ModalLayer
    })
    addCorner(card, 20)
    addStroke(card, self.Theme.Accent, 0.25, 1.2)
    local title = textLabel({
        Font = Enum.Font.GothamBold,
        Text = options.Title or "Confirm",
        TextColor3 = self.Theme.Text,
        TextSize = 19,
        Position = UDim2.fromOffset(24, 20),
        Size = UDim2.new(1, -48, 0, 28),
        ZIndex = 102,
        Parent = card
    })
    local message = textLabel({
        Font = Enum.Font.Gotham,
        Text = options.Content or options.Message or "Continue?",
        TextColor3 = self.Theme.Muted,
        TextSize = 13,
        TextWrapped = true,
        TextYAlignment = Enum.TextYAlignment.Top,
        Position = UDim2.fromOffset(24, 58),
        Size = UDim2.new(1, -48, 0, 54),
        ZIndex = 102,
        Parent = card
    })
    local promptInput
    if options.Prompt then
        local boxFrame = create("Frame", {
            BackgroundColor3 = self.Theme.Surface2,
            BackgroundTransparency = 0.08,
            BorderSizePixel = 0,
            Position = UDim2.fromOffset(24, 120),
            Size = UDim2.new(1, -48, 0, 44),
            ZIndex = 102,
            Parent = card
        })
        addCorner(boxFrame, 12)
        addStroke(boxFrame, self.Theme.Text, 0.88, 1)
        promptInput = textBox({
            PlaceholderText = options.Placeholder or "Type here...",
            Text = options.Default or "",
            Position = UDim2.fromOffset(14, 0),
            Size = UDim2.new(1, -28, 1, 0),
            ZIndex = 103,
            Parent = boxFrame
        })
    end
    local buttonRow = create("Frame", {
        AnchorPoint = Vector2.new(0, 1),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 24, 1, -24),
        Size = UDim2.new(1, -48, 0, 42),
        ZIndex = 102,
        Parent = card
    })
    local layout = create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Padding = UDim.new(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = buttonRow
    })
    local function close(result)
        tween(card, {
            Size = UDim2.fromOffset(390, options.Prompt and 228 or 190),
            BackgroundTransparency = 1
        }, 0.18)
        tween(self.ModalLayer, {
            BackgroundTransparency = 1
        }, 0.18)
        task.delay(0.2, function()
            card:Destroy()
            self.ModalLayer.Visible = false
        end)
        return result
    end
    local cancel = textButton({
        BackgroundColor3 = self.Theme.Surface3,
        BackgroundTransparency = 0.2,
        Size = UDim2.fromOffset(112, 42),
        Text = options.CancelText or "Cancel",
        ZIndex = 103,
        Parent = buttonRow
    })
    addCorner(cancel, 12)
    addStroke(cancel, self.Theme.Text, 0.86, 1)
    local confirm = textButton({
        BackgroundColor3 = self.Theme.Accent,
        BackgroundTransparency = 0,
        Size = UDim2.fromOffset(122, 42),
        Text = options.ConfirmText or "Confirm",
        ZIndex = 103,
        Parent = buttonRow
    })
    addCorner(confirm, 12)
    addGradient(confirm, {
        ColorSequenceKeypoint.new(0, self.Theme.Accent2),
        ColorSequenceKeypoint.new(1, self.Theme.Accent)
    }, 0)
    cancel.MouseButton1Click:Connect(function()
        makeRipple(cancel, self.Theme)
        close(false)
        protect(options.Cancel)
    end)
    confirm.MouseButton1Click:Connect(function()
        makeRipple(confirm, self.Theme)
        local value = promptInput and promptInput.Text or true
        close(value)
        protect(options.Callback or options.Confirm, value)
    end)
    tween(card, {
        Size = card.Size
    }, 0.25, Enum.EasingStyle.Back)
    return card
end

function WindowClass:Confirm(options)
    options = options or {}
    options.Prompt = false
    return self:Dialog(options)
end

function WindowClass:Prompt(options)
    options = options or {}
    options.Prompt = true
    return self:Dialog(options)
end

function WindowClass:SetTheme(nameOrTheme)
    local newTheme = type(nameOrTheme) == "table" and mergeTheme(self.Theme, nameOrTheme) or mergeTheme(Themes["AMOLED Red"], Themes[nameOrTheme] or self.Theme)
    self.Theme = newTheme
    self.ThemeName = type(nameOrTheme) == "string" and nameOrTheme or "Custom"
    if self.RootStroke then
        tween(self.RootStroke, {
            Color = newTheme.Border
        }, 0.22)
    end
    if self.RedGlow then
        tween(self.RedGlow, {
            BackgroundColor3 = newTheme.Accent
        }, 0.22)
    end
    if self.BrandIcon then
        tween(self.BrandIcon, {
            BackgroundColor3 = newTheme.AccentDark
        }, 0.22)
        if self.BrandIconStroke then
            tween(self.BrandIconStroke, {
                Color = newTheme.Accent
            }, 0.22)
        end
        tintIcon(self.BrandVectorIcon, newTheme.Accent)
    end
    if self.BrandSubtitle then
        tween(self.BrandSubtitle, {
            TextColor3 = newTheme.Accent
        }, 0.22)
    end
    if self.ProfileStatus then
        tween(self.ProfileStatus, {
            TextColor3 = newTheme.Accent
        }, 0.22)
    end
    tintIcon(self.AvatarFallbackIcon, newTheme.Accent)
    tintIcon(self.SidebarToggleIcon, newTheme.Muted)
    tintIcon(self.SearchIcon, newTheme.Muted)
    if self.ResizeGrip then
        tween(self.ResizeGrip, {
            BackgroundColor3 = newTheme.Accent
        }, 0.22)
    end
    if self.HeroGem then
        tintIcon(self.HeroGem, newTheme.Accent)
    end
    if self.HeroUser then
        tween(self.HeroUser.Value, {
            TextColor3 = newTheme.Accent
        }, 0.22)
        tintIcon(self.HeroUser.Icon, newTheme.Accent)
    end
    if self.HeroUptime then
        tween(self.HeroUptime.Value, {
            TextColor3 = newTheme.Accent
        }, 0.22)
        tintIcon(self.HeroUptime.Icon, newTheme.Accent)
    end
    if self.HeroScripts then
        tween(self.HeroScripts.Value, {
            TextColor3 = newTheme.Accent
        }, 0.22)
        tintIcon(self.HeroScripts.Icon, newTheme.Accent)
    end
    if self.HeroStatus then
        tween(self.HeroStatus.Value, {
            TextColor3 = newTheme.Accent
        }, 0.22)
        tintIcon(self.HeroStatus.Icon, newTheme.Accent)
    end
    if self.FooterStatus then
        tween(self.FooterStatus, {
            TextColor3 = newTheme.Accent
        }, 0.22)
    end
    for _, tab in ipairs(self.Tabs) do
        local active = self.ActiveTab == tab
        if tab.ButtonStroke then
            tab.ButtonStroke.Color = newTheme.Accent
        end
        if tab.Indicator then
            tab.Indicator.BackgroundColor3 = newTheme.Accent
        end
        if tab.IconCircle then
            tween(tab.IconCircle, {
                BackgroundColor3 = active and newTheme.Accent or newTheme.Surface3
            }, 0.22)
        end
        tintIcon(tab.IconLabel, active and Color3.fromRGB(255, 255, 255) or newTheme.Muted)
    end
    for _, section in ipairs(self.Sections) do
        if section.Accent then
            tween(section.Accent, {
                BackgroundColor3 = newTheme.Accent
            }, 0.22)
        end
        if section.HeaderIcon then
            tintIcon(section.HeaderIcon, newTheme.Muted)
        end
    end
    self:Notify({
        Type = "Info",
        Title = "Theme Updated",
        Content = "Active theme: " .. self.ThemeName
    })
end

function WindowClass:SaveConfig(name)
    name = tostring(name or "Default")
    local data = {}
    for key, component in pairs(self.Components) do
        if component.Get then
            data[key] = serializeValue(component:Get())
        elseif component.Value ~= nil then
            data[key] = serializeValue(component.Value)
        end
    end
    local encoded = HttpService:JSONEncode(data)
    if writefile then
        ensureFolder(ahst_lib.ConfigFolder)
        ensureFolder(ahst_lib.ConfigFolder .. "/Configs")
        writefile(ahst_lib.ConfigFolder .. "/Configs/" .. name .. ".json", encoded)
    end
    self.SavedConfigs = self.SavedConfigs or {}
    self.SavedConfigs[name] = encoded
    self:Notify({
        Type = "Success",
        Title = "Configuration Saved",
        Content = name
    })
    return encoded
end

function WindowClass:LoadConfig(name)
    name = tostring(name or "Default")
    local encoded
    if readfile and isfile and isfile(ahst_lib.ConfigFolder .. "/Configs/" .. name .. ".json") then
        encoded = readfile(ahst_lib.ConfigFolder .. "/Configs/" .. name .. ".json")
    elseif self.SavedConfigs then
        encoded = self.SavedConfigs[name]
    end
    if not encoded then
        self:Notify({
            Type = "Warning",
            Title = "Configuration Missing",
            Content = name
        })
        return false
    end
    return self:ImportConfig(encoded)
end

function WindowClass:DeleteConfig(name)
    name = tostring(name or "Default")
    if delfile and isfile and isfile(ahst_lib.ConfigFolder .. "/Configs/" .. name .. ".json") then
        delfile(ahst_lib.ConfigFolder .. "/Configs/" .. name .. ".json")
    end
    if self.SavedConfigs then
        self.SavedConfigs[name] = nil
    end
    self:Notify({
        Type = "Info",
        Title = "Configuration Deleted",
        Content = name
    })
    return true
end

function WindowClass:ExportConfig()
    local data = {}
    for key, component in pairs(self.Components) do
        if component.Get then
            data[key] = serializeValue(component:Get())
        elseif component.Value ~= nil then
            data[key] = serializeValue(component.Value)
        end
    end
    return HttpService:JSONEncode(data)
end

function WindowClass:ImportConfig(json)
    local ok, data = pcall(function()
        return HttpService:JSONDecode(json)
    end)
    if not ok or type(data) ~= "table" then
        self:Notify({
            Type = "Error",
            Title = "Import Failed",
            Content = "Invalid JSON"
        })
        return false
    end
    for key, value in pairs(data) do
        local component = self.Components[key]
        if component and component.Set then
            component:Set(value, true)
        end
    end
    self:Notify({
        Type = "Success",
        Title = "Configuration Loaded",
        Content = "Values restored"
    })
    return true
end

function TabClass:_subtitleFor(name)
    local map = {
        Home = "Overview",
        Main = "Core Features",
        Player = "Player Mods",
        Visuals = "ESP, Chams & More",
        Combat = "Aimbot & Weapons",
        Teleports = "Teleports & Maps",
        Farming = "Automation",
        Misc = "Utilities",
        Settings = "Configuration"
    }
    return map[name] or "Module"
end

function TabClass:CreateSection(title, description, options)
    options = options or {}
    local section = setmetatable({
        Tab = self,
        Window = self.Window,
        Title = title or "Section",
        Description = description,
        Options = options,
        Components = {}
    }, SectionClass)
    section.Frame = create("Frame", {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = self.Window.Theme.Surface,
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 70),
        ZIndex = 14,
        Parent = self.Page
    })
    addCorner(section.Frame, 16)
    section.FrameStroke = addStroke(section.Frame, self.Window.Theme.Text, 0.88, 1)
    section.Scale = create("UIScale", {
        Scale = 1,
        Parent = section.Frame
    })
    connectHover(section.Frame, function()
        tween(section.FrameStroke, {
            Color = self.Window.Theme.Accent,
            Transparency = 0.58
        }, 0.18)
        tween(section.Scale, {
            Scale = 1.003
        }, 0.18)
    end, function()
        tween(section.FrameStroke, {
            Color = self.Window.Theme.Text,
            Transparency = 0.88
        }, 0.18)
        tween(section.Scale, {
            Scale = 1
        }, 0.18)
    end)
    section.Gradient = addGradient(section.Frame, {
        ColorSequenceKeypoint.new(0, self.Window.Theme.Surface2),
        ColorSequenceKeypoint.new(1, self.Window.Theme.Background)
    }, 90, NumberSequence.new(0.22))
    section.Accent = create("Frame", {
        BackgroundColor3 = self.Window.Theme.Accent,
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, 16),
        Size = UDim2.new(0, 3, 1, -32),
        ZIndex = 16,
        Parent = section.Frame
    })
    addCorner(section.Accent, 8)
    section.Header = create("Frame", {
        BackgroundColor3 = self.Window.Theme.Surface2,
        BackgroundTransparency = 0.56,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, description and 64 or 52),
        ZIndex = 15,
        Parent = section.Frame
    })
    addCorner(section.Header, 16)
    section.HeaderIcon = createVectorIcon(section.Header, options.Icon or Icons.star, self.Window.Theme.Muted, {
        Size = 22,
        Position = UDim2.fromOffset(20, 16),
        ZIndex = 16
    })
    section.TitleLabel = textLabel({
        Font = Enum.Font.GothamBold,
        Text = section.Title,
        TextColor3 = self.Window.Theme.Text,
        TextSize = 16,
        Position = UDim2.fromOffset(56, 14),
        Size = UDim2.new(1, -76, 0, 24),
        ZIndex = 16,
        Parent = section.Header
    })
    if description then
        section.DescriptionLabel = textLabel({
            Font = Enum.Font.Gotham,
            Text = description,
            TextColor3 = self.Window.Theme.Muted,
            TextSize = 12,
            Position = UDim2.fromOffset(56, 38),
            Size = UDim2.new(1, -76, 0, 18),
            ZIndex = 16,
            Parent = section.Header
        })
    end
    section.Separator = create("Frame", {
        BackgroundColor3 = self.Window.Theme.Text,
        BackgroundTransparency = 0.92,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 18, 0, section.Header.Size.Y.Offset - 1),
        Size = UDim2.new(1, -36, 0, 1),
        ZIndex = 16,
        Parent = section.Frame
    })
    section.Container = create("Frame", {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(18, section.Header.Size.Y.Offset),
        Size = UDim2.new(1, -36, 0, 0),
        ZIndex = 15,
        Parent = section.Frame
    })
    create("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = section.Container
    })
    addPadding(section.Container, 0, 0, 0, 18)
    table.insert(self.Sections, section)
    table.insert(self.Window.Sections, section)
    return section
end

function SectionClass:_flag(options)
    return options.Flag or options.Name or ("Flag" .. tostring(#self.Window.Components + 1))
end

function SectionClass:_baseComponent(options, height)
    options = options or {}
    local frame = create("Frame", {
        BackgroundColor3 = self.Window.Theme.Surface2,
        BackgroundTransparency = 0.28,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Size = UDim2.new(1, 0, 0, height or 56),
        ZIndex = 18,
        Parent = self.Container
    })
    addCorner(frame, 12)
    local frameStroke = addStroke(frame, self.Window.Theme.Text, 0.93, 1)
    local frameScale = create("UIScale", {
        Scale = 1,
        Parent = frame
    })
    connectHover(frame, function()
        tween(frame, {
            BackgroundTransparency = 0.2
        }, 0.16)
        tween(frameStroke, {
            Transparency = 0.78,
            Color = self.Window.Theme.Accent
        }, 0.16)
        tween(frameScale, {
            Scale = 1.002
        }, 0.16)
    end, function()
        tween(frame, {
            BackgroundTransparency = 0.28
        }, 0.16)
        tween(frameStroke, {
            Transparency = 0.93,
            Color = self.Window.Theme.Text
        }, 0.16)
        tween(frameScale, {
            Scale = 1
        }, 0.16)
    end)
    self.Window:_registerSearch(frame, (options.Name or "") .. " " .. (options.Description or ""))
    local title = textLabel({
        Font = Enum.Font.GothamMedium,
        Text = options.Name or "Component",
        TextColor3 = self.Window.Theme.Text,
        TextSize = 13,
        Position = UDim2.fromOffset(14, options.Description and 8 or 0),
        Size = UDim2.new(1, -28, 0, options.Description and 22 or height or 56),
        ZIndex = 19,
        Parent = frame
    })
    local desc
    if options.Description then
        desc = textLabel({
            Font = Enum.Font.Gotham,
            Text = options.Description,
            TextColor3 = self.Window.Theme.Muted,
            TextSize = 11,
            Position = UDim2.fromOffset(14, 28),
            Size = UDim2.new(1, -28, 0, 18),
            ZIndex = 19,
            Parent = frame
        })
    end
    return frame, title, desc
end

function SectionClass:_register(flag, component)
    component.Window = self.Window
    component.Flag = flag
    self.Window.Components[flag] = component
    local value = component.Get and component:Get() or component.Value
    self.Window.Flags[flag] = value
    ahst_lib.Flags[flag] = value
    table.insert(self.Components, component)
    return component
end

function SectionClass:CreateButton(options)
    options = options or {}
    local frame, title, desc = self:_baseComponent(options, options.Description and 62 or 54)
    local button = textButton({
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = self.Window.Theme.Accent,
        BackgroundTransparency = 0,
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(options.Width or 120, 36),
        Text = options.ButtonText or "Run",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 13,
        ZIndex = 20,
        Parent = frame
    })
    addCorner(button, 11)
    addGradient(button, {
        ColorSequenceKeypoint.new(0, self.Window.Theme.Accent2),
        ColorSequenceKeypoint.new(1, self.Window.Theme.Accent)
    }, 0)
    connectHover(button, function()
        tween(button, {
            Size = UDim2.fromOffset((options.Width or 120) + 4, 38)
        }, 0.16)
    end, function()
        tween(button, {
            Size = UDim2.fromOffset(options.Width or 120, 36)
        }, 0.16)
    end)
    button.MouseButton1Down:Connect(function(input)
        makeRipple(button, self.Window.Theme, input)
        tween(button, {
            BackgroundTransparency = 0.16
        }, 0.08)
    end)
    button.MouseButton1Up:Connect(function()
        tween(button, {
            BackgroundTransparency = 0
        }, 0.14)
    end)
    button.MouseButton1Click:Connect(function()
        protect(options.Callback)
    end)
    local component = {
        Instance = frame,
        Button = button,
        Value = nil,
        SetText = function(_, text)
            button.Text = tostring(text)
        end
    }
    return component
end

function SectionClass:CreateToggle(options)
    options = options or {}
    local frame = self:_baseComponent(options, options.Description and 62 or 54)
    local flag = self:_flag(options)
    local component = {
        Instance = frame,
        Value = options.Default == true
    }
    local switch = create("Frame", {
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = component.Value and self.Window.Theme.Accent or Color3.fromRGB(76, 76, 86),
        BackgroundTransparency = component.Value and 0 or 0.12,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -14, 0.5, 0),
        Size = UDim2.fromOffset(52, 28),
        ZIndex = 20,
        Parent = frame
    })
    addCorner(switch, 20)
    local knob = create("Frame", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Position = component.Value and UDim2.fromOffset(27, 3) or UDim2.fromOffset(3, 3),
        Size = UDim2.fromOffset(22, 22),
        ZIndex = 21,
        Parent = switch
    })
    addCorner(knob, 20)
    local glow = addStroke(switch, self.Window.Theme.Accent, component.Value and 0.35 or 1, 1.4)
    function component:Set(value, silent)
        self.Value = value == true
        self.Window.Flags[flag] = self.Value
        ahst_lib.Flags[flag] = self.Value
        tween(switch, {
            BackgroundColor3 = self.Value and self.Window.Theme.Accent or Color3.fromRGB(76, 76, 86),
            BackgroundTransparency = self.Value and 0 or 0.12
        }, 0.22)
        tween(knob, {
            Position = self.Value and UDim2.fromOffset(27, 3) or UDim2.fromOffset(3, 3)
        }, 0.24, Enum.EasingStyle.Back)
        tween(glow, {
            Transparency = self.Value and 0.35 or 1
        }, 0.2)
        if not silent then
            protect(options.Callback, self.Value)
        end
    end
    function component:Get()
        return self.Value
    end
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            component:Set(not component.Value)
        end
    end)
    return self:_register(flag, component)
end

function SectionClass:CreateSlider(options)
    options = options or {}
    options.Min = options.Min or 0
    options.Max = options.Max or 100
    options.Default = options.Default or options.Min
    options.Increment = options.Increment or 1
    local frame = self:_baseComponent(options, options.Description and 76 or 68)
    local flag = self:_flag(options)
    local component = {
        Instance = frame,
        Value = math.clamp(options.Default, options.Min, options.Max)
    }
    local inputBoxFrame = create("Frame", {
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = self.Window.Theme.Surface,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -12, 0, 14),
        Size = UDim2.fromOffset(66, 30),
        ZIndex = 20,
        Parent = frame
    })
    addCorner(inputBoxFrame, 9)
    addStroke(inputBoxFrame, self.Window.Theme.Text, 0.9, 1)
    local valueBox = textBox({
        Text = tostring(component.Value),
        TextXAlignment = Enum.TextXAlignment.Center,
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.fromScale(1, 1),
        ZIndex = 21,
        Parent = inputBoxFrame
    })
    local bar = create("Frame", {
        AnchorPoint = Vector2.new(1, 1),
        BackgroundColor3 = Color3.fromRGB(52, 52, 62),
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -86, 1, -18),
        Size = UDim2.new(0.48, 0, 0, 5),
        ZIndex = 20,
        Parent = frame
    })
    addCorner(bar, 6)
    local fill = create("Frame", {
        BackgroundColor3 = self.Window.Theme.Accent,
        BorderSizePixel = 0,
        Size = UDim2.fromScale((component.Value - options.Min) / math.max(1, options.Max - options.Min), 1),
        ZIndex = 21,
        Parent = bar
    })
    addCorner(fill, 6)
    local knob = create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Position = UDim2.fromScale((component.Value - options.Min) / math.max(1, options.Max - options.Min), 0.5),
        Size = UDim2.fromOffset(16, 16),
        ZIndex = 22,
        Parent = bar
    })
    addCorner(knob, 16)
    addStroke(knob, self.Window.Theme.Accent, 0.18, 1)
    local dragging = false
    local function updateFromPosition(x, silent)
        local alpha = math.clamp((x - bar.AbsolutePosition.X) / math.max(1, bar.AbsoluteSize.X), 0, 1)
        local raw = options.Min + ((options.Max - options.Min) * alpha)
        component:Set(roundNumber(raw, options.Increment), silent)
    end
    function component:Set(value, silent)
        value = tonumber(value) or options.Min
        self.Value = math.clamp(roundNumber(value, options.Increment), options.Min, options.Max)
        self.Window.Flags[flag] = self.Value
        ahst_lib.Flags[flag] = self.Value
        valueBox.Text = tostring(self.Value)
        local alpha = (self.Value - options.Min) / math.max(1, options.Max - options.Min)
        tween(fill, {
            Size = UDim2.fromScale(alpha, 1)
        }, 0.16)
        tween(knob, {
            Position = UDim2.fromScale(alpha, 0.5)
        }, 0.16)
        if not silent then
            protect(options.Callback, self.Value)
        end
    end
    function component:Get()
        return self.Value
    end
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateFromPosition(input.Position.X)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateFromPosition(input.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    valueBox.FocusLost:Connect(function()
        component:Set(valueBox.Text)
    end)
    return self:_register(flag, component)
end

function SectionClass:CreateDropdown(options)
    options = options or {}
    options.Options = options.Options or {}
    local frame = self:_baseComponent(options, options.Description and 64 or 56)
    local flag = self:_flag(options)
    local multi = options.Multi == true
    local selected = multi and {} or (options.Default or options.Options[1])
    if multi and type(options.Default) == "table" then
        for _, value in ipairs(options.Default) do
            selected[value] = true
        end
    end
    local component = {
        Instance = frame,
        Value = selected,
        Options = options.Options,
        Open = false
    }
    local display = textButton({
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = self.Window.Theme.Surface,
        BackgroundTransparency = 0.12,
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(options.Width or 210, 36),
        Text = "",
        TextColor3 = self.Window.Theme.Text,
        TextSize = 13,
        ZIndex = 30,
        Parent = frame
    })
    addCorner(display, 10)
    addStroke(display, self.Window.Theme.Text, 0.88, 1)
    local displayText = textLabel({
        Text = "",
        TextColor3 = self.Window.Theme.Text,
        TextSize = 12,
        Position = UDim2.fromOffset(12, 0),
        Size = UDim2.new(1, -38, 1, 0),
        ZIndex = 31,
        Parent = display
    })
    local arrow = textLabel({
        Text = "v",
        TextColor3 = self.Window.Theme.Muted,
        TextSize = 18,
        Position = UDim2.new(1, -30, 0, 0),
        Size = UDim2.fromOffset(24, 36),
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = 31,
        Parent = display
    })
    local dropdown = create("Frame", {
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = self.Window.Theme.Surface,
        BackgroundTransparency = 0.04,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.new(1, -12, 1, 6),
        Size = UDim2.fromOffset(options.Width or 210, 0),
        Visible = false,
        ZIndex = 60,
        Parent = frame
    })
    addCorner(dropdown, 12)
    addStroke(dropdown, self.Window.Theme.Accent, 0.32, 1)
    frame.ClipsDescendants = false
    local search
    local listStart = 8
    if options.Search then
        local searchFrame = create("Frame", {
            BackgroundColor3 = self.Window.Theme.Surface2,
            BackgroundTransparency = 0.2,
            BorderSizePixel = 0,
            Position = UDim2.fromOffset(8, 8),
            Size = UDim2.new(1, -16, 0, 34),
            ZIndex = 61,
            Parent = dropdown
        })
        addCorner(searchFrame, 9)
        search = textBox({
            PlaceholderText = "Search...",
            Text = "",
            Position = UDim2.fromOffset(10, 0),
            Size = UDim2.new(1, -20, 1, 0),
            TextSize = 12,
            ZIndex = 62,
            Parent = searchFrame
        })
        listStart = 48
    end
    local list = create("ScrollingFrame", {
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        CanvasSize = UDim2.fromOffset(0, 0),
        Position = UDim2.fromOffset(8, listStart),
        ScrollBarImageColor3 = self.Window.Theme.Accent,
        ScrollBarThickness = 2,
        Size = UDim2.new(1, -16, 1, -listStart - 8),
        ZIndex = 61,
        Parent = dropdown
    })
    create("UIListLayout", {
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = list
    })
    local optionButtons = {}
    local function selectedText()
        if multi then
            local values = {}
            for _, option in ipairs(component.Options) do
                if component.Value[option] then
                    table.insert(values, tostring(option))
                end
            end
            return #values > 0 and table.concat(values, ", ") or "Select..."
        end
        return component.Value and tostring(component.Value) or "Select..."
    end
    local function refresh()
        displayText.Text = selectedText()
        for option, button in pairs(optionButtons) do
            local active = multi and component.Value[option] or component.Value == option
            tween(button, {
                BackgroundColor3 = active and self.Window.Theme.AccentDark or self.Window.Theme.Surface2,
                BackgroundTransparency = active and 0.18 or 0.42
            }, 0.16)
            button.TextColor3 = active and self.Window.Theme.Accent2 or self.Window.Theme.Text
        end
    end
    local function rebuild(filter)
        for _, button in pairs(optionButtons) do
            button:Destroy()
        end
        optionButtons = {}
        for _, option in ipairs(component.Options) do
            if searchMatch(tostring(option), filter) then
                local optionButton = textButton({
                    BackgroundColor3 = self.Window.Theme.Surface2,
                    BackgroundTransparency = 0.42,
                    Size = UDim2.new(1, 0, 0, 32),
                    Text = tostring(option),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextSize = 12,
                    ZIndex = 62,
                    Parent = list
                })
                addCorner(optionButton, 9)
                addPadding(optionButton, 10, 10, 0, 0)
                optionButton.MouseButton1Click:Connect(function()
                    if multi then
                        component.Value[option] = not component.Value[option]
                    else
                        component.Value = option
                        component:Toggle(false)
                    end
                    self.Window.Flags[flag] = component:Get()
                    ahst_lib.Flags[flag] = component:Get()
                    refresh()
                    protect(options.Callback, component:Get())
                end)
                optionButtons[option] = optionButton
            end
        end
        refresh()
    end
    function component:Toggle(force)
        if force ~= nil then
            self.Open = force
        else
            self.Open = not self.Open
        end
        dropdown.Visible = true
        frame.Size = UDim2.new(1, 0, 0, (options.Description and 64 or 56) + (self.Open and 210 or 0))
        tween(dropdown, {
            Size = UDim2.fromOffset(options.Width or 210, self.Open and 196 or 0)
        }, 0.24)
        tween(arrow, {
            Rotation = self.Open and 180 or 0
        }, 0.2)
        if not self.Open then
            task.delay(0.25, function()
                if not self.Open then
                    dropdown.Visible = false
                end
            end)
        end
    end
    function component:Set(value, silent)
        if multi then
            self.Value = {}
            if type(value) == "table" then
                for key, item in pairs(value) do
                    if type(key) == "number" then
                        self.Value[item] = true
                    elseif item == true then
                        self.Value[key] = true
                    end
                end
            end
        else
            self.Value = value
        end
        self.Window.Flags[flag] = self:Get()
        ahst_lib.Flags[flag] = self:Get()
        refresh()
        if not silent then
            protect(options.Callback, self:Get())
        end
    end
    function component:Get()
        if multi then
            local values = {}
            for _, option in ipairs(self.Options) do
                if self.Value[option] then
                    table.insert(values, option)
                end
            end
            return values
        end
        return self.Value
    end
    display.MouseButton1Click:Connect(function()
        component:Toggle()
    end)
    if search then
        search:GetPropertyChangedSignal("Text"):Connect(function()
            rebuild(search.Text)
        end)
    end
    rebuild("")
    return self:_register(flag, component)
end

function SectionClass:CreateTextbox(options)
    options = options or {}
    local frame = self:_baseComponent(options, options.Description and 64 or 56)
    local flag = self:_flag(options)
    local component = {
        Instance = frame,
        Value = options.Default or ""
    }
    local boxFrame = create("Frame", {
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = self.Window.Theme.Surface,
        BackgroundTransparency = 0.12,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(options.Width or 230, 36),
        ZIndex = 20,
        Parent = frame
    })
    addCorner(boxFrame, 10)
    local stroke = addStroke(boxFrame, self.Window.Theme.Text, 0.88, 1)
    local input = textBox({
        PlaceholderText = options.Placeholder or "Type...",
        Text = tostring(component.Value),
        Position = UDim2.fromOffset(12, 0),
        Size = UDim2.new(1, -24, 1, 0),
        TextSize = 12,
        ZIndex = 21,
        Parent = boxFrame
    })
    function component:Set(value, silent)
        local text = tostring(value or "")
        local valid = true
        if type(options.Validate) == "function" then
            valid = protect(options.Validate, text) ~= false
        end
        tween(stroke, {
            Color = valid and self.Window.Theme.Text or self.Window.Theme.Error,
            Transparency = valid and 0.88 or 0.25
        }, 0.16)
        if valid then
            self.Value = text
            input.Text = text
            self.Window.Flags[flag] = self.Value
            ahst_lib.Flags[flag] = self.Value
            if not silent then
                protect(options.Callback, self.Value)
            end
        end
    end
    function component:Get()
        return self.Value
    end
    input.FocusLost:Connect(function(enterPressed)
        if enterPressed or options.CallbackOnFocusLost ~= false then
            component:Set(input.Text)
        end
    end)
    return self:_register(flag, component)
end

function SectionClass:CreateLabel(options)
    if type(options) == "string" then
        options = {Name = options}
    end
    options = options or {}
    local frame = create("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, options.Height or 28),
        ZIndex = 18,
        Parent = self.Container
    })
    local label = textLabel({
        Font = options.Bold and Enum.Font.GothamBold or Enum.Font.Gotham,
        Text = options.Text or options.Name or "Label",
        TextColor3 = options.Color or self.Window.Theme.Text,
        TextSize = options.TextSize or 13,
        TextWrapped = true,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 19,
        Parent = frame
    })
    local component = {
        Instance = frame,
        Label = label,
        Value = label.Text,
        Set = function(self, value)
            self.Value = tostring(value)
            label.Text = self.Value
        end,
        Get = function(self)
            return self.Value
        end
    }
    self.Window:_registerSearch(frame, label.Text)
    return component
end

function SectionClass:CreateParagraph(options)
    options = options or {}
    local text = options.Content or options.Text or ""
    local frame = create("Frame", {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = self.Window.Theme.Surface2,
        BackgroundTransparency = 0.32,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 72),
        ZIndex = 18,
        Parent = self.Container
    })
    addCorner(frame, 12)
    addStroke(frame, self.Window.Theme.Text, 0.92, 1)
    addPadding(frame, 14, 14, 12, 12)
    local title
    if options.Title then
        title = textLabel({
            Font = Enum.Font.GothamBold,
            Text = options.Title,
            TextColor3 = self.Window.Theme.Text,
            TextSize = 14,
            Size = UDim2.new(1, 0, 0, 22),
            ZIndex = 19,
            Parent = frame
        })
    end
    local paragraph = textLabel({
        AutomaticSize = Enum.AutomaticSize.Y,
        Font = Enum.Font.Gotham,
        Text = text,
        TextColor3 = self.Window.Theme.Muted,
        TextSize = 12,
        TextWrapped = true,
        TextYAlignment = Enum.TextYAlignment.Top,
        Position = UDim2.fromOffset(0, options.Title and 26 or 0),
        Size = UDim2.new(1, 0, 0, 34),
        ZIndex = 19,
        Parent = frame
    })
    self.Window:_registerSearch(frame, (options.Title or "") .. " " .. text)
    local component = {
        Instance = frame,
        Paragraph = paragraph,
        Value = text,
        Set = function(self, value)
            self.Value = tostring(value)
            paragraph.Text = self.Value
        end,
        Get = function(self)
            return self.Value
        end
    }
    return component
end

function SectionClass:CreateProgressBar(options)
    options = options or {}
    local frame = self:_baseComponent(options, options.Description and 68 or 60)
    local flag = self:_flag(options)
    local max = options.Max or 100
    local component = {
        Instance = frame,
        Value = math.clamp(options.Default or 0, 0, max)
    }
    local value = textLabel({
        AnchorPoint = Vector2.new(1, 0),
        Font = Enum.Font.GothamMedium,
        Text = tostring(component.Value) .. "%",
        TextColor3 = self.Window.Theme.Text,
        TextSize = 12,
        Position = UDim2.new(1, -14, 0, 12),
        Size = UDim2.fromOffset(68, 22),
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = 20,
        Parent = frame
    })
    local bar = create("Frame", {
        AnchorPoint = Vector2.new(1, 1),
        BackgroundColor3 = Color3.fromRGB(52, 52, 62),
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -14, 1, -16),
        Size = UDim2.new(0.55, 0, 0, 7),
        ZIndex = 20,
        Parent = frame
    })
    addCorner(bar, 8)
    local fill = create("Frame", {
        BackgroundColor3 = self.Window.Theme.Accent,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(component.Value / max, 1),
        ZIndex = 21,
        Parent = bar
    })
    addCorner(fill, 8)
    addGradient(fill, {
        ColorSequenceKeypoint.new(0, self.Window.Theme.Accent),
        ColorSequenceKeypoint.new(1, self.Window.Theme.Accent2)
    }, 0)
    function component:Set(amount, silent)
        self.Value = math.clamp(tonumber(amount) or 0, 0, max)
        self.Window.Flags[flag] = self.Value
        ahst_lib.Flags[flag] = self.Value
        value.Text = tostring(math.floor((self.Value / max) * 100 + 0.5)) .. "%"
        tween(fill, {
            Size = UDim2.fromScale(self.Value / max, 1)
        }, 0.25)
        if not silent then
            protect(options.Callback, self.Value)
        end
    end
    function component:Get()
        return self.Value
    end
    return self:_register(flag, component)
end

function SectionClass:CreateCard(options)
    options = options or {}
    local frame = create("Frame", {
        BackgroundColor3 = self.Window.Theme.Surface2,
        BackgroundTransparency = 0.18,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, options.Height or 82),
        ZIndex = 18,
        Parent = self.Container
    })
    addCorner(frame, 14)
    addStroke(frame, self.Window.Theme.Text, 0.9, 1)
    local icon = createVectorIcon(frame, options.Icon or Icons.cube, options.Color or self.Window.Theme.Accent, {
        Size = 28,
        Position = UDim2.fromOffset(16, 14),
        ZIndex = 19
    })
    local title = textLabel({
        Font = Enum.Font.GothamMedium,
        Text = options.Title or options.Name or "Card",
        TextColor3 = self.Window.Theme.Text,
        TextSize = 13,
        Position = UDim2.fromOffset(70, 14),
        Size = UDim2.new(1, -88, 0, 20),
        ZIndex = 19,
        Parent = frame
    })
    local value = textLabel({
        Font = Enum.Font.GothamBold,
        Text = tostring(options.Value or ""),
        TextColor3 = options.Color or self.Window.Theme.Accent,
        TextSize = 18,
        Position = UDim2.fromOffset(70, 36),
        Size = UDim2.new(1, -88, 0, 24),
        ZIndex = 19,
        Parent = frame
    })
    if options.Description then
        value.TextSize = 15
        local desc = textLabel({
            Font = Enum.Font.Gotham,
            Text = options.Description,
            TextColor3 = self.Window.Theme.Muted,
            TextSize = 11,
            Position = UDim2.fromOffset(70, 58),
            Size = UDim2.new(1, -88, 0, 18),
            ZIndex = 19,
            Parent = frame
        })
    end
    self.Window:_registerSearch(frame, (options.Title or options.Name or "") .. " " .. tostring(options.Value or "") .. " " .. (options.Description or ""))
    local component = {
        Instance = frame,
        Value = options.Value,
        Set = function(self, newValue)
            self.Value = newValue
            value.Text = tostring(newValue)
        end,
        Get = function(self)
            return self.Value
        end
    }
    return component
end

function SectionClass:CreateStatsWidget(options)
    options = options or {}
    local frame = create("Frame", {
        BackgroundColor3 = self.Window.Theme.Surface2,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 96),
        ZIndex = 18,
        Parent = self.Container
    })
    addCorner(frame, 14)
    addStroke(frame, self.Window.Theme.Text, 0.9, 1)
    local layout = create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 18),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Parent = frame
    })
    addPadding(frame, 18, 18, 0, 0)
    local function metric(name, color)
        local box = create("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(0.33, -12, 1, -18),
            ZIndex = 19,
            Parent = frame
        })
        local label = textLabel({
            Font = Enum.Font.Gotham,
            Text = name,
            TextColor3 = self.Window.Theme.Muted,
            TextSize = 12,
            Position = UDim2.fromOffset(0, 12),
            Size = UDim2.new(1, 0, 0, 20),
            ZIndex = 20,
            Parent = box
        })
        local value = textLabel({
            Font = Enum.Font.GothamBold,
            Text = "...",
            TextColor3 = color,
            TextSize = 18,
            Position = UDim2.fromOffset(0, 38),
            Size = UDim2.new(1, 0, 0, 24),
            ZIndex = 20,
            Parent = box
        })
        return value
    end
    local fps = metric("FPS", self.Window.Theme.Good)
    local ping = metric("Ping", self.Window.Theme.Info)
    local runtime = metric("Runtime", self.Window.Theme.Warning)
    local frames = 0
    local last = os.clock()
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not frame.Parent then
            connection:Disconnect()
            return
        end
        frames += 1
        local now = os.clock()
        if now - last >= 1 then
            fps.Text = tostring(frames)
            frames = 0
            last = now
            runtime.Text = formatTime(now - ClockStart)
            local pingText = "0ms"
            pcall(function()
                pingText = StatsService.Network.ServerStatsItem["Data Ping"]:GetValueString()
            end)
            ping.Text = pingText
        end
    end)
    return {
        Instance = frame,
        FPS = fps,
        Ping = ping,
        Runtime = runtime
    }
end

function SectionClass:CreateKeybind(options)
    options = options or {}
    local frame = self:_baseComponent(options, options.Description and 62 or 54)
    local flag = self:_flag(options)
    local component = {
        Instance = frame,
        Value = options.Default or "None",
        Listening = false
    }
    local button = textButton({
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = self.Window.Theme.Surface,
        BackgroundTransparency = 0.12,
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(150, 36),
        Text = enumName(component.Value),
        TextSize = 12,
        ZIndex = 20,
        Parent = frame
    })
    addCorner(button, 10)
    addStroke(button, self.Window.Theme.Text, 0.88, 1)
    function component:Set(value, silent)
        self.Value = enumName(value)
        button.Text = self.Value
        self.Window.Flags[flag] = self.Value
        ahst_lib.Flags[flag] = self.Value
        if not silent then
            protect(options.Callback, self.Value)
        end
    end
    function component:Get()
        return self.Value
    end
    button.MouseButton1Click:Connect(function()
        component.Listening = true
        button.Text = "Press key..."
        tween(button, {
            BackgroundColor3 = self.Window.Theme.AccentDark
        }, 0.16)
    end)
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if component.Listening then
            component.Listening = false
            tween(button, {
                BackgroundColor3 = self.Window.Theme.Surface
            }, 0.16)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                component:Set(input.KeyCode)
            elseif input.UserInputType.Name:match("MouseButton") then
                component:Set(input.UserInputType)
            else
                button.Text = component.Value
            end
            return
        end
        if not gameProcessed and component.Value ~= "None" then
            if input.KeyCode.Name == component.Value or input.UserInputType.Name == component.Value then
                protect(options.Pressed or options.Callback, component.Value, input)
            end
        end
    end)
    return self:_register(flag, component)
end

function SectionClass:CreateColorPicker(options)
    options = options or {}
    local defaultColor, defaultAlpha = tableToColor(options.Default or Color3.fromRGB(255, 45, 45))
    if options.Transparency ~= nil then
        defaultAlpha = options.Transparency
    end
    local frame = self:_baseComponent(options, options.Description and 64 or 56)
    frame.ClipsDescendants = false
    local flag = self:_flag(options)
    local component = {
        Instance = frame,
        Value = defaultColor,
        Alpha = defaultAlpha,
        Open = false
    }
    local swatch = textButton({
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = defaultColor,
        BackgroundTransparency = defaultAlpha,
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(70, 34),
        Text = "",
        ZIndex = 25,
        Parent = frame
    })
    addCorner(swatch, 10)
    addStroke(swatch, self.Window.Theme.Text, 0.82, 1)
    local panel = create("Frame", {
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = self.Window.Theme.Surface,
        BackgroundTransparency = 0.04,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.new(1, -12, 1, 8),
        Size = UDim2.fromOffset(320, 0),
        Visible = false,
        ZIndex = 60,
        Parent = frame
    })
    addCorner(panel, 14)
    addStroke(panel, self.Window.Theme.Accent, 0.35, 1)
    local values = {
        R = math.floor(defaultColor.R * 255 + 0.5),
        G = math.floor(defaultColor.G * 255 + 0.5),
        B = math.floor(defaultColor.B * 255 + 0.5),
        A = defaultAlpha
    }
    local h, s, v = defaultColor:ToHSV()
    values.H = math.floor(h * 360 + 0.5)
    values.S = math.floor(s * 100 + 0.5)
    values.V = math.floor(v * 100 + 0.5)
    local sliders = {}
    local function call(silent)
        component.Value = Color3.fromRGB(values.R, values.G, values.B)
        component.Alpha = values.A
        swatch.BackgroundColor3 = component.Value
        swatch.BackgroundTransparency = component.Alpha
        self.Window.Flags[flag] = colorToTable(component.Value, component.Alpha)
        ahst_lib.Flags[flag] = self.Window.Flags[flag]
        if not silent then
            protect(options.Callback, component.Value, component.Alpha, self.Window.Flags[flag])
        end
    end
    local function updateHSVFromRGB()
        local color = Color3.fromRGB(values.R, values.G, values.B)
        local hh, ss, vv = color:ToHSV()
        values.H = math.floor(hh * 360 + 0.5)
        values.S = math.floor(ss * 100 + 0.5)
        values.V = math.floor(vv * 100 + 0.5)
    end
    local function updateRGBFromHSV()
        local color = Color3.fromHSV(values.H / 360, values.S / 100, values.V / 100)
        values.R = math.floor(color.R * 255 + 0.5)
        values.G = math.floor(color.G * 255 + 0.5)
        values.B = math.floor(color.B * 255 + 0.5)
    end
    local function sliderRow(name, max, order, color)
        local row = create("Frame", {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(16, 12 + (order - 1) * 28),
            Size = UDim2.new(1, -32, 0, 24),
            ZIndex = 61,
            Parent = panel
        })
        local label = textLabel({
            Text = name,
            TextColor3 = self.Window.Theme.Muted,
            TextSize = 11,
            Size = UDim2.fromOffset(28, 24),
            ZIndex = 62,
            Parent = row
        })
        local bar = create("Frame", {
            BackgroundColor3 = Color3.fromRGB(46, 46, 56),
            BorderSizePixel = 0,
            Position = UDim2.fromOffset(36, 10),
            Size = UDim2.new(1, -88, 0, 5),
            ZIndex = 62,
            Parent = row
        })
        addCorner(bar, 6)
        local fill = create("Frame", {
            BackgroundColor3 = color,
            BorderSizePixel = 0,
            Size = UDim2.fromScale(values[name] / max, 1),
            ZIndex = 63,
            Parent = bar
        })
        addCorner(fill, 6)
        local number = textLabel({
            Font = Enum.Font.GothamMedium,
            Text = tostring(values[name]),
            TextColor3 = self.Window.Theme.Text,
            TextSize = 11,
            Position = UDim2.new(1, -44, 0, 0),
            Size = UDim2.fromOffset(44, 24),
            TextXAlignment = Enum.TextXAlignment.Right,
            ZIndex = 62,
            Parent = row
        })
        local dragging = false
        local function setFromX(x, silent)
            local alpha = math.clamp((x - bar.AbsolutePosition.X) / math.max(1, bar.AbsoluteSize.X), 0, 1)
            values[name] = name == "A" and math.floor(alpha * 100 + 0.5) / 100 or math.floor(alpha * max + 0.5)
            if name == "R" or name == "G" or name == "B" then
                updateHSVFromRGB()
            elseif name == "H" or name == "S" or name == "V" then
                updateRGBFromHSV()
            end
            for sliderName, slider in pairs(sliders) do
                local sliderMax = sliderName == "H" and 360 or ((sliderName == "S" or sliderName == "V") and 100 or (sliderName == "A" and 1 or 255))
                slider.Number.Text = tostring(values[sliderName])
                tween(slider.Fill, {
                    Size = UDim2.fromScale(values[sliderName] / sliderMax, 1)
                }, 0.1)
            end
            call(silent)
        end
        bar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                setFromX(input.Position.X)
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                setFromX(input.Position.X)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        sliders[name] = {
            Fill = fill,
            Number = number
        }
    end
    sliderRow("R", 255, 1, Color3.fromRGB(255, 72, 72))
    sliderRow("G", 255, 2, Color3.fromRGB(72, 255, 142))
    sliderRow("B", 255, 3, Color3.fromRGB(72, 142, 255))
    sliderRow("H", 360, 4, self.Window.Theme.Accent)
    sliderRow("S", 100, 5, Color3.fromRGB(255, 255, 255))
    sliderRow("V", 100, 6, Color3.fromRGB(255, 255, 255))
    sliderRow("A", 1, 7, Color3.fromRGB(180, 180, 190))
    function component:Toggle(force)
        if force ~= nil then
            self.Open = force
        else
            self.Open = not self.Open
        end
        panel.Visible = true
        frame.Size = UDim2.new(1, 0, 0, (options.Description and 64 or 56) + (self.Open and 232 or 0))
        tween(panel, {
            Size = UDim2.fromOffset(320, self.Open and 220 or 0)
        }, 0.24)
        if not self.Open then
            task.delay(0.25, function()
                if not self.Open then
                    panel.Visible = false
                end
            end)
        end
    end
    function component:Set(value, silent)
        local color, alpha = tableToColor(value)
        if type(value) == "table" and value.A then
            alpha = value.A
        end
        self.Value = color
        self.Alpha = alpha
        values.R = math.floor(color.R * 255 + 0.5)
        values.G = math.floor(color.G * 255 + 0.5)
        values.B = math.floor(color.B * 255 + 0.5)
        values.A = alpha
        updateHSVFromRGB()
        for sliderName, slider in pairs(sliders) do
            local sliderMax = sliderName == "H" and 360 or ((sliderName == "S" or sliderName == "V") and 100 or (sliderName == "A" and 1 or 255))
            slider.Number.Text = tostring(values[sliderName])
            slider.Fill.Size = UDim2.fromScale(values[sliderName] / sliderMax, 1)
        end
        call(silent)
    end
    function component:Get()
        return colorToTable(self.Value, self.Alpha)
    end
    swatch.MouseButton1Click:Connect(function()
        component:Toggle()
    end)
    call(true)
    return self:_register(flag, component)
end

function SectionClass:CreateThemeSelector(options)
    options = options or {}
    options.Name = options.Name or "Theme"
    options.Options = {}
    for name in pairs(Themes) do
        table.insert(options.Options, name)
    end
    table.sort(options.Options)
    options.Default = self.Window.ThemeName
    options.Callback = function(value)
        self.Window:SetTheme(value)
        protect(options.OnChanged, value)
    end
    return self:CreateDropdown(options)
end

function SectionClass:CreateConfigManager(options)
    options = options or {}
    local manager = self:CreateParagraph({
        Title = options.Title or "Configuration Manager",
        Content = "Save, load, export and import JSON settings through the library API."
    })
    self:CreateTextbox({
        Name = "Config Name",
        Placeholder = "Default",
        Default = "Default",
        Flag = "__AHST_ConfigName"
    })
    self:CreateButton({
        Name = "Save Configuration",
        ButtonText = "Save",
        Callback = function()
            self.Window:SaveConfig(self.Window.Flags.__AHST_ConfigName or "Default")
        end
    })
    self:CreateButton({
        Name = "Load Configuration",
        ButtonText = "Load",
        Callback = function()
            self.Window:LoadConfig(self.Window.Flags.__AHST_ConfigName or "Default")
        end
    })
    self:CreateButton({
        Name = "Delete Configuration",
        ButtonText = "Delete",
        Callback = function()
            self.Window:DeleteConfig(self.Window.Flags.__AHST_ConfigName or "Default")
        end
    })
    return manager
end

function SectionClass:AddButton(options)
    return self:CreateButton(options)
end

function SectionClass:AddToggle(options)
    return self:CreateToggle(options)
end

function SectionClass:AddSlider(options)
    return self:CreateSlider(options)
end

function SectionClass:AddDropdown(options)
    return self:CreateDropdown(options)
end

function SectionClass:AddTextbox(options)
    return self:CreateTextbox(options)
end

function SectionClass:AddLabel(options)
    return self:CreateLabel(options)
end

function SectionClass:AddParagraph(options)
    return self:CreateParagraph(options)
end

function TabClass:AddSection(title, description, options)
    return self:CreateSection(title, description, options)
end

function WindowClass:Destroy()
    return self:Close()
end

return ahst_lib
