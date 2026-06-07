--[[
TheRealBanHammer - Skidder Final Boss 🥵

"Usen Buenos Ofuscadores"

Ofuscadores Basura:
- Luraph
- WeAreDevs.net
- Moonsec V3
- Ferib

Desofuscado por: Sr_KevinYT
Modder: TheRealBanHammer
]]--

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local CurrentCamera = game:GetService("Workspace").CurrentCamera

local HTTPRequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local VerifyURL = "https://kellyz-bot-production.up.railway.app/verify"

local function Verify(key)
    if not HTTPRequest then return false, nil end
    local clientId = game:GetService("RbxAnalyticsService"):GetClientId()
    local playerName = LocalPlayer.Name
    local executor = (identifyexecutor and identifyexecutor()) or "Unknown"
    local fullUrl = VerifyURL .. "?key=" .. key .. "&hwid=" .. clientId .. "&rbx_user=" .. playerName .. "&executor=" .. executor
    
    local success, response = pcall(function()
        return HTTPRequest({Url = fullUrl, Method = "GET"})
    end)
    
    if success and response and type(response) == "table" and response.StatusCode == 200 then
        local decodeSuccess, decodedBody = pcall(function()
            return HttpService:JSONDecode(response.Body)
        end)
        if decodeSuccess and decodedBody and decodedBody.valid == true then
            return true, decodedBody
        end
    end
    return false, nil
end

pcall(function()
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        if self == LocalPlayer and getnamecallmethod() == "Kick" then
            return
        end
        return oldNamecall(self, ...)
    end)
end)

local MapName = "Mendeteksi Map..."
pcall(function()
    local productInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
    if productInfo and productInfo.Name then
        MapName = productInfo.Name
    else
        MapName = "Map ID: " .. tostring(game.PlaceId)
    end
end)

local SaveFileName = "SkidderProMaxKey_Save.txt"
local IconUrl1 = "rbxthumb://type=Asset&id=128843396504484&w=150&h=150"
local IconUrl2 = "rbxthumb://type=Asset&id=112582597558400&w=420&h=420"

getgenv().CurrentLang = "en"
getgenv().ThemeColor = Color3.fromRGB(0, 200, 255)
getgenv().ThemedElements = {Bgs = {}, Strokes = {}, Texts = {}, Toggles = {}, Checks = {}, ScrollBars = {}}
getgenv().ActiveTab = nil

local ConfigFileName = "SkidderProMaxConfig_Save.json"

local function SaveConfig()
    if writefile then
        local configData = {
            r = math.floor(getgenv().ThemeColor.R * 255),
            g = math.floor(getgenv().ThemeColor.G * 255),
            b = math.floor(getgenv().ThemeColor.B * 255),
            lang = getgenv().CurrentLang
        }
        pcall(function()
            writefile(ConfigFileName, HttpService:JSONEncode(configData))
        end)
    end
end

local function LoadConfig()
    if isfile and isfile(ConfigFileName) and readfile then
        pcall(function()
            local decoded = HttpService:JSONDecode(readfile(ConfigFileName))
            if decoded.r and decoded.g and decoded.b then
                getgenv().ThemeColor = Color3.fromRGB(decoded.r, decoded.g, decoded.b)
            end
            if decoded.lang then
                getgenv().CurrentLang = decoded.lang
            end
        end)
    end
end
LoadConfig()

local function UpdateTheme(color)
    for _, textElement in pairs(getgenv().ThemedElements.Texts) do
        pcall(function() TweenService:Create(textElement, TweenInfo.new(0.3), {TextColor3 = color}):Play() end)
    end
    for _, toggleElement in pairs(getgenv().ThemedElements.Toggles) do
        pcall(function()
            if toggleElement.state then
                TweenService:Create(toggleElement.obj, TweenInfo.new(0.3), {BackgroundColor3 = color}):Play()
            end
        end)
    end
    for _, checkElement in pairs(getgenv().ThemedElements.Checks) do
        pcall(function() TweenService:Create(checkElement, TweenInfo.new(0.3), {TextColor3 = color}):Play() end)
    end
    for _, scrollElement in pairs(getgenv().ThemedElements.ScrollBars) do
        pcall(function() TweenService:Create(scrollElement, TweenInfo.new(0.3), {ScrollBarImageColor3 = color}):Play() end)
    end
    for _, bgElement in pairs(getgenv().ThemedElements.Bgs) do
        pcall(function() TweenService:Create(bgElement, TweenInfo.new(0.3), {BackgroundColor3 = color}):Play() end)
    end
    for _, strokeElement in pairs(getgenv().ThemedElements.Strokes) do
        pcall(function() TweenService:Create(strokeElement, TweenInfo.new(0.3), {Color = color}):Play() end)
    end
    getgenv().ThemeColor = color
    SaveConfig()
    if getgenv().ActiveTab then
        pcall(function() TweenService:Create(getgenv().ActiveTab, TweenInfo.new(0.3), {BackgroundColor3 = color}):Play() end)
    end
end

if CoreGui:FindFirstChild("SkidderProMaxNotifUI") then
    CoreGui.SkidderProMaxNotifUI:Destroy()
end

local NotifUI = Instance.new("ScreenGui")
NotifUI.Name = "SkidderProMaxNotifUI"
NotifUI.Parent = CoreGui

local NotifContainer = Instance.new("Frame")
NotifContainer.Size = UDim2.new(0, 300, 1, -20)
NotifContainer.Position = UDim2.new(1, -20, 1, -20)
NotifContainer.AnchorPoint = Vector2.new(1, 1)
NotifContainer.BackgroundTransparency = 1
NotifContainer.Parent = NotifUI

local NotifLayout = Instance.new("UIListLayout", NotifContainer)
NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifLayout.Padding = UDim.new(0, 12)

local function CreateNotification(title, text, duration)
    local frameContainer = Instance.new("Frame")
    frameContainer.Size = UDim2.new(1, 0, 0, 70)
    frameContainer.BackgroundTransparency = 1
    frameContainer.Parent = NotifContainer

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(1, 0, 1, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    mainFrame.BackgroundTransparency = 0.2
    mainFrame.Position = UDim2.new(1, 50, 0, 0)
    mainFrame.Parent = frameContainer
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

    local sideBar = Instance.new("Frame")
    sideBar.Size = UDim2.new(0, 3, 1, -20)
    sideBar.Position = UDim2.new(0, 8, 0, 10)
    sideBar.BackgroundColor3 = getgenv().ThemeColor
    sideBar.BorderSizePixel = 0
    sideBar.Parent = mainFrame
    Instance.new("UICorner", sideBar).CornerRadius = UDim.new(1, 0)
    table.insert(getgenv().ThemedElements.Bgs, sideBar)

    local stroke = Instance.new("UIStroke", mainFrame)
    stroke.Thickness = 1
    stroke.Color = getgenv().ThemeColor
    stroke.Transparency = 0.5
    table.insert(getgenv().ThemedElements.Strokes, stroke)

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -30, 0, 28)
    titleLbl.Position = UDim2.new(0, 20, 0, 6)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = title
    titleLbl.TextColor3 = getgenv().ThemeColor
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextSize = 13
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = mainFrame
    table.insert(getgenv().ThemedElements.Texts, titleLbl)

    local textLbl = Instance.new("TextLabel")
    textLbl.Size = UDim2.new(1, -30, 0, 24)
    textLbl.Position = UDim2.new(0, 20, 0, 34)
    textLbl.BackgroundTransparency = 1
    textLbl.Text = text
    textLbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    textLbl.Font = Enum.Font.Gotham
    textLbl.TextSize = 11
    textLbl.TextXAlignment = Enum.TextXAlignment.Left
    textLbl.TextWrapped = true
    textLbl.Parent = mainFrame

    local timeBarBg = Instance.new("Frame")
    timeBarBg.Size = UDim2.new(1, -40, 0, 2)
    timeBarBg.Position = UDim2.new(0, 20, 1, -10)
    timeBarBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    timeBarBg.BackgroundTransparency = 0.8
    timeBarBg.BorderSizePixel = 0
    timeBarBg.Parent = mainFrame

    local timeBar = Instance.new("Frame")
    timeBar.Size = UDim2.new(1, 0, 1, 0)
    timeBar.BackgroundColor3 = getgenv().ThemeColor
    timeBar.BorderSizePixel = 0
    timeBar.Parent = timeBarBg
    table.insert(getgenv().ThemedElements.Bgs, timeBar)

    TweenService:Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
    
    task.spawn(function()
        local waitTime = duration or 4
        TweenService:Create(timeBar, TweenInfo.new(waitTime, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 0, 1, 0)}):Play()
        task.wait(waitTime)
        local outTween = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(1, 50, 0, 0)})
        outTween:Play()
        outTween.Completed:Connect(function()
            local collapseTween = TweenService:Create(frameContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 0)})
            collapseTween:Play()
            collapseTween.Completed:Connect(function()
                frameContainer:Destroy()
            end)
        end)
    end)
end

local MainUI = nil
local MainFrame = nil
local RegisteredElements = {}

local function RegisterElement(obj, texts, type, state)
    table.insert(RegisteredElements, {obj = obj, texts = texts, type = type, state = state})
end

local function UpdateLanguage()
    for _, element in pairs(RegisteredElements) do
        pcall(function()
            local text = element.texts[getgenv().CurrentLang] or element.texts['en'] or ""
            if element.type == "Label" or element.type == "Button" then
                element.obj.Text = text
            elseif element.type == "Tab" then
                element.obj.Text = "   " .. text
            elseif element.type == "Toggle" then
                local descLbl = element.obj:FindFirstChild("DescLbl")
                if descLbl then
                    local descText = element.texts[getgenv().CurrentLang .. "_desc"] or element.texts['en_desc'] or ""
                    descLbl.Text = descText
                end
                local titleLbl = element.obj:FindFirstChild("TitleLbl")
                if titleLbl then
                    titleLbl.Text = text
                else
                    element.obj.Text = "   " .. text
                end
            elseif element.type == "Input" then
                element.obj.PlaceholderText = text
            elseif element.type == "MultiDropdown" then
                local selected = (element.state and element.state.selected and #element.state.selected > 0 and table.concat(element.state.selected, ", ")) or "None"
                element.obj.Text = "   " .. text .. ": " .. selected
            elseif element.type == "Dropdown" then
                local selected = (element.state and element.state.selected) or "None"
                element.obj.Text = "   " .. text .. ": " .. selected
            end
        end)
    end
end

local function AddHoverEffect(button, defaultColor, hoverColor)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
    end)
    button.MouseLeave:Connect(function()
        if getgenv().ActiveTab ~= button then
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = defaultColor}):Play()
        end
    end)
end

local function CreateUI()
    if CoreGui:FindFirstChild("SkidderProMaxUltimateHub") then
        CoreGui.SkidderProMaxUltimateHub:Destroy()
    end

    MainUI = Instance.new("ScreenGui")
    MainUI.Name = "SkidderProMaxUltimateHub"
    MainUI.Parent = CoreGui
    MainUI.ResetOnSpawn = false

    local FloatingIcon = Instance.new("ImageButton")
    FloatingIcon.Name = "FloatingIcon"
    FloatingIcon.Size = UDim2.new(0, 60, 0, 60)
    FloatingIcon.Position = UDim2.new(0.05, 0, 0.1, 0)
    FloatingIcon.BackgroundTransparency = 1
    FloatingIcon.Image = "rbxassetid://6031075931"
    FloatingIcon.Active = true
    FloatingIcon.Draggable = true
    FloatingIcon.Visible = false
    FloatingIcon.ZIndex = 50
    FloatingIcon.Parent = MainUI

    MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 750, 0, 460)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    MainFrame.BackgroundTransparency = 0.25
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = MainUI
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

    local mainStroke = Instance.new("UIStroke", MainFrame)
    mainStroke.Color = Color3.fromRGB(255, 255, 255)
    mainStroke.Thickness = 1
    mainStroke.Transparency = 0.85

    local dropShadow = Instance.new("ImageLabel")
    dropShadow.Name = "DropShadow"
    dropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    dropShadow.BackgroundTransparency = 1
    dropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    dropShadow.Size = UDim2.new(1, 60, 1, 60)
    dropShadow.ZIndex = -1
    dropShadow.Image = "rbxassetid://6015043444"
    dropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    dropShadow.ImageTransparency = 0.5
    dropShadow.ScaleType = Enum.ScaleType.Slice
    dropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
    dropShadow.Parent = MainFrame

    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
    TopBar.BackgroundTransparency = 0.4
    TopBar.BorderSizePixel = 0
    TopBar.ZIndex = 5
    TopBar.Parent = MainFrame

    local TopBarLine = Instance.new("Frame", TopBar)
    TopBarLine.Size = UDim2.new(1, 0, 0, 1)
    TopBarLine.Position = UDim2.new(0, 0, 1, 0)
    TopBarLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TopBarLine.BackgroundTransparency = 0.9
    TopBarLine.BorderSizePixel = 0

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -150, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "Skidder Pro Max - TheRealBanHammer | " .. MapName
    TitleLabel.TextColor3 = getgenv().ThemeColor
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 13
    TitleLabel.ZIndex = 5
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TopBar

    local LangBtn = Instance.new("TextButton")
    LangBtn.Size = UDim2.new(0, 45, 0, 26)
    LangBtn.Position = UDim2.new(1, -175, 0, 7)
    LangBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    LangBtn.Text = (getgenv().CurrentLang == "id" and "🇮🇩 ID") or "🇬🇧 EN"
    LangBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    LangBtn.Font = Enum.Font.GothamBold
    LangBtn.TextSize = 11
    LangBtn.ZIndex = 6
    LangBtn.Parent = TopBar
    Instance.new("UICorner", LangBtn).CornerRadius = UDim.new(0, 6)

    local langStroke = Instance.new("UIStroke", LangBtn)
    langStroke.Color = getgenv().ThemeColor
    langStroke.Thickness = 1
    langStroke.Transparency = 0.5
    table.insert(getgenv().ThemedElements.Strokes, langStroke)

    LangBtn.MouseButton1Click:Connect(function()
        getgenv().CurrentLang = (getgenv().CurrentLang == "id" and "en") or "id"
        LangBtn.Text = (getgenv().CurrentLang == "id" and "🇮🇩 ID") or "🇬🇧 EN"
        UpdateLanguage()
        SaveConfig()
    end)

    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Size = UDim2.new(0, 40, 0, 40)
    MinimizeBtn.Position = UDim2.new(1, -120, 0, 0)
    MinimizeBtn.BackgroundTransparency = 1
    MinimizeBtn.Text = "—"
    MinimizeBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.TextSize = 14
    MinimizeBtn.ZIndex = 5
    MinimizeBtn.Parent = TopBar

    local MaximizeBtn = Instance.new("TextButton")
    MaximizeBtn.Size = UDim2.new(0, 40, 0, 40)
    MaximizeBtn.Position = UDim2.new(1, -80, 0, 0)
    MaximizeBtn.BackgroundTransparency = 1
    MaximizeBtn.Text = "▢"
    MaximizeBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    MaximizeBtn.Font = Enum.Font.GothamBold
    MaximizeBtn.TextSize = 16
    MaximizeBtn.ZIndex = 5
    MaximizeBtn.Parent = TopBar

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 40, 0, 40)
    CloseBtn.Position = UDim2.new(1, -40, 0, 0)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 16
    CloseBtn.ZIndex = 5
    CloseBtn.Parent = TopBar

    for _, btn in pairs({MinimizeBtn, MaximizeBtn, CloseBtn}) do
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9}):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        end)
    end

    CloseBtn.MouseEnter:Connect(function()
        TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 50, 50), BackgroundTransparency = 0.5, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    end)
    CloseBtn.MouseLeave:Connect(function()
        TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(180, 180, 180)}):Play()
    end)

    local ConfirmCloseBg = Instance.new("Frame")
    ConfirmCloseBg.Size = UDim2.new(1, 0, 1, 0)
    ConfirmCloseBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ConfirmCloseBg.BackgroundTransparency = 0.5
    ConfirmCloseBg.Visible = false
    ConfirmCloseBg.ZIndex = 99
    ConfirmCloseBg.Active = true
    ConfirmCloseBg.Parent = MainUI

    local ConfirmCloseFrame = Instance.new("Frame")
    ConfirmCloseFrame.Size = UDim2.new(0, 300, 0, 160)
    ConfirmCloseFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    ConfirmCloseFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    ConfirmCloseFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
    ConfirmCloseFrame.ZIndex = 100
    ConfirmCloseFrame.Parent = ConfirmCloseBg
    Instance.new("UICorner", ConfirmCloseFrame).CornerRadius = UDim.new(0, 8)

    local ccStroke = Instance.new("UIStroke", ConfirmCloseFrame)
    ccStroke.Color = Color3.fromRGB(100, 100, 200)
    ccStroke.Thickness = 1.5
    table.insert(getgenv().ThemedElements.Strokes, ccStroke)

    local ccTitle = Instance.new("TextLabel")
    ccTitle.Size = UDim2.new(1, 0, 0, 30)
    ccTitle.Position = UDim2.new(0, 0, 0, 15)
    ccTitle.BackgroundTransparency = 1
    ccTitle.Text = "Skidder Pro Max Window"
    ccTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ccTitle.Font = Enum.Font.GothamBold
    ccTitle.TextSize = 18
    ccTitle.ZIndex = 101
    ccTitle.Parent = ConfirmCloseFrame

    local ccDesc = Instance.new("TextLabel")
    ccDesc.Size = UDim2.new(1, -40, 0, 40)
    ccDesc.Position = UDim2.new(0, 20, 0, 45)
    ccDesc.BackgroundTransparency = 1
    ccDesc.Text = "Do you want to close this window?\nYou will not be able to open it again"
    ccDesc.TextColor3 = Color3.fromRGB(180, 180, 180)
    ccDesc.Font = Enum.Font.Gotham
    ccDesc.TextSize = 13
    ccDesc.ZIndex = 101
    ccDesc.Parent = ConfirmCloseFrame

    local ccYesBtn = Instance.new("TextButton")
    ccYesBtn.Size = UDim2.new(0, 120, 0, 35)
    ccYesBtn.Position = UDim2.new(0, 20, 0, 100)
    ccYesBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    ccYesBtn.Text = "Yes"
    ccYesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ccYesBtn.Font = Enum.Font.GothamBold
    ccYesBtn.ZIndex = 101
    ccYesBtn.Parent = ConfirmCloseFrame
    Instance.new("UICorner", ccYesBtn).CornerRadius = UDim.new(0, 6)

    local ccCancelBtn = Instance.new("TextButton")
    ccCancelBtn.Size = UDim2.new(0, 120, 0, 35)
    ccCancelBtn.Position = UDim2.new(1, -140, 0, 100)
    ccCancelBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    ccCancelBtn.Text = "Cancel"
    ccCancelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ccCancelBtn.Font = Enum.Font.GothamBold
    ccCancelBtn.ZIndex = 101
    ccCancelBtn.Parent = ConfirmCloseFrame
    Instance.new("UICorner", ccCancelBtn).CornerRadius = UDim.new(0, 6)

    local ResizeBtn = Instance.new("TextButton")
    ResizeBtn.Size = UDim2.new(0, 20, 0, 20)
    ResizeBtn.Position = UDim2.new(1, -20, 1, -20)
    ResizeBtn.BackgroundTransparency = 1
    ResizeBtn.Text = "⌟"
    ResizeBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    ResizeBtn.Font = Enum.Font.GothamBold
    ResizeBtn.TextSize = 16
    ResizeBtn.ZIndex = 50
    ResizeBtn.Parent = MainFrame

    local isResizing = false
    local resizeStart = nil
    local initialSize = nil

    ResizeBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isResizing = true
            resizeStart = input.Position
            initialSize = MainFrame.Size
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isResizing = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if isResizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - resizeStart
            local newX = math.clamp(initialSize.X.Offset + delta.X, 400, 1200)
            local newY = math.clamp(initialSize.Y.Offset + delta.Y, 300, 800)
            MainFrame.Size = UDim2.new(0, newX, 0, newY)
        end
    end)

    local isMaximized = false
    local prevSize = UDim2.new(0, 750, 0, 460)

    local function OpenHub()
        FloatingIcon.Visible = false
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = (isMaximized and UDim2.new(0, 950, 0, 600)) or prevSize}):Play()
    end

    local function MinimizeHub()
        local tw = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
        tw:Play()
        tw.Completed:Connect(function()
            if MainFrame.Size.X.Offset == 0 then
                MainFrame.Visible = false
                FloatingIcon.Visible = true
            end
        end)
    end

    MinimizeBtn.MouseButton1Click:Connect(MinimizeHub)
    FloatingIcon.MouseButton1Click:Connect(OpenHub)

    MaximizeBtn.MouseButton1Click:Connect(function()
        isMaximized = not isMaximized
        if isMaximized then
            prevSize = MainFrame.Size
            TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 950, 0, 600)}):Play()
        else
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = prevSize}):Play()
        end
    end)

    CloseBtn.MouseButton1Click:Connect(function() ConfirmCloseBg.Visible = true end)
    ccCancelBtn.MouseButton1Click:Connect(function() ConfirmCloseBg.Visible = false end)
    ccYesBtn.MouseButton1Click:Connect(function() MainUI:Destroy() end)

    local TabContainer = Instance.new("Frame")
    TabContainer.Size = UDim2.new(0, 160, 1, -40)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    TabContainer.BackgroundTransparency = 0.3
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = MainFrame

    local TabListLayout = Instance.new("UIListLayout", TabContainer)
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 4)

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -160, 1, -40)
    ContentContainer.Position = UDim2.new(0, 160, 0, 40)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.ClipsDescendants = true
    ContentContainer.Parent = MainFrame

    local Decal1 = Instance.new("ImageLabel")
    Decal1.Size = UDim2.new(0, 500, 0, 380)
    Decal1.Position = UDim2.new(1, 20, 1, 0)
    Decal1.AnchorPoint = Vector2.new(1, 1)
    Decal1.BackgroundTransparency = 1
    Decal1.Image = IconUrl2
    Decal1.ImageTransparency = 0.1
    Decal1.ScaleType = Enum.ScaleType.Fit
    Decal1.ZIndex = 0
    Decal1.Parent = ContentContainer



    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Visible = true
    TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 750, 0, 460)}):Play()
    CreateNotification("Script Executed!", "Selamat datang di Skidder Pro Max - TheRealBanHammer Premium.", 5)

    local TabsList = {}

    local function CreateTab(tabData)
        local isSection = typeof(tabData) == "Instance"
        local TabContent

        if isSection then
            TabContent = tabData
        else
            local TabBtn = Instance.new("TextButton")
            TabBtn.Size = UDim2.new(1, -12, 0, 35)
            TabBtn.Position = UDim2.new(0, 8, 0, 0)
            TabBtn.BackgroundTransparency = 1
            TabBtn.TextColor3 = Color3.fromRGB(140, 140, 150)
            TabBtn.Font = Enum.Font.GothamSemibold
            TabBtn.TextSize = 12
            TabBtn.Text = "   " .. tabData.en
            TabBtn.TextXAlignment = Enum.TextXAlignment.Left
            TabBtn.Parent = TabContainer
            Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

            RegisterElement(TabBtn, tabData, "Tab", nil)

            TabContent = Instance.new("ScrollingFrame")
            TabContent.Name = tabData.en .. "_Content"
            TabContent.Size = UDim2.new(1, -20, 1, -20)
            TabContent.Position = UDim2.new(0, 10, 0, 10)
            TabContent.BackgroundTransparency = 1
            TabContent.ScrollBarThickness = 2
            TabContent.ScrollBarImageColor3 = getgenv().ThemeColor
            TabContent.ScrollBarImageTransparency = 0.5
            TabContent.Visible = false
            TabContent.ZIndex = 2
            TabContent.Parent = ContentContainer
            table.insert(getgenv().ThemedElements.ScrollBars, TabContent)

            local ContentLayout = Instance.new("UIListLayout", TabContent)
            ContentLayout.Padding = UDim.new(0, 8)
            ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
            end)

            TabBtn.MouseButton1Click:Connect(function()
                for _, child in pairs(TabContainer:GetChildren()) do
                    if child:IsA("TextButton") then
                        TweenService:Create(child, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(140, 140, 150), BackgroundTransparency = 1}):Play()
                    end
                end
                for _, child in pairs(ContentContainer:GetChildren()) do
                    if child:IsA("ScrollingFrame") then
                        child.Visible = false
                    end
                end
                TweenService:Create(TabBtn, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(255, 255, 255), BackgroundColor3 = Color3.fromRGB(30, 30, 35), BackgroundTransparency = 0}):Play()
                getgenv().ActiveTab = TabBtn
                TabContent.Visible = true
            end)

            if #TabsList == 0 then
                TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                TabBtn.BackgroundTransparency = 0
                TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
                getgenv().ActiveTab = TabBtn
                TabContent.Visible = true
            end
            table.insert(TabsList, TabBtn)
        end

        local TabFunctions = {}

        TabFunctions.AddLabel = function(self, lblData)
            local Lbl = Instance.new("TextLabel")
            Lbl.Size = UDim2.new(1, 0, 0, 25)
            Lbl.BackgroundTransparency = 1
            Lbl.TextColor3 = getgenv().ThemeColor
            Lbl.Font = Enum.Font.GothamBold
            Lbl.TextSize = 13
            Lbl.Text = lblData.en
            Lbl.ZIndex = 3
            Lbl.TextXAlignment = Enum.TextXAlignment.Left
            Lbl.Parent = TabContent
            RegisterElement(Lbl, lblData, "Label", nil)
            table.insert(getgenv().ThemedElements.Texts, Lbl)
        end

        TabFunctions.AddToggle = function(self, toggleData, callback)
            local state = false
            local hasDesc = (toggleData.id_desc ~= nil) or (toggleData.en_desc ~= nil)
            
            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Size = UDim2.new(1, 0, 0, (hasDesc and 48) or 40)
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
            ToggleBtn.BackgroundTransparency = 0.2
            ToggleBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
            ToggleBtn.Font = Enum.Font.GothamSemibold
            ToggleBtn.TextSize = 12
            ToggleBtn.Text = ""
            ToggleBtn.ZIndex = 3
            ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
            ToggleBtn.Parent = TabContent
            Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8)

            local stroke = Instance.new("UIStroke", ToggleBtn)
            stroke.Color = getgenv().ThemeColor
            stroke.Thickness = 0.6
            stroke.Transparency = 0.8
            table.insert(getgenv().ThemedElements.Strokes, stroke)

            RegisterElement(ToggleBtn, toggleData, "Toggle", state)
            AddHoverEffect(ToggleBtn, Color3.fromRGB(24, 24, 32), Color3.fromRGB(32, 28, 42))

            local TitleLbl = Instance.new("TextLabel")
            TitleLbl.Name = "TitleLbl"
            TitleLbl.Size = UDim2.new(1, -60, 0, 16)
            TitleLbl.Position = UDim2.new(0, 15, 0, (hasDesc and 8) or 12)
            TitleLbl.BackgroundTransparency = 1
            TitleLbl.TextColor3 = Color3.fromRGB(200, 200, 210)
            TitleLbl.Font = Enum.Font.GothamSemibold
            TitleLbl.TextSize = 12
            TitleLbl.ZIndex = 3
            TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
            TitleLbl.Parent = ToggleBtn

            if hasDesc then
                local DescLbl = Instance.new("TextLabel")
                DescLbl.Name = "DescLbl"
                DescLbl.Size = UDim2.new(1, -60, 0, 14)
                DescLbl.Position = UDim2.new(0, 15, 0, 26)
                DescLbl.BackgroundTransparency = 1
                DescLbl.TextColor3 = Color3.fromRGB(130, 130, 140)
                DescLbl.Font = Enum.Font.Gotham
                DescLbl.TextSize = 10
                DescLbl.ZIndex = 3
                DescLbl.TextXAlignment = Enum.TextXAlignment.Left
                DescLbl.Parent = ToggleBtn
            end

            local IndicatorBg = Instance.new("Frame")
            IndicatorBg.Size = UDim2.new(0, 36, 0, 20)
            IndicatorBg.Position = UDim2.new(1, -48, 0.5, -10)
            IndicatorBg.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
            IndicatorBg.ZIndex = 3
            IndicatorBg.Parent = ToggleBtn
            Instance.new("UICorner", IndicatorBg).CornerRadius = UDim.new(1, 0)

            local indStroke = Instance.new("UIStroke", IndicatorBg)
            indStroke.Color = getgenv().ThemeColor
            indStroke.Thickness = 0.7
            indStroke.Transparency = 0.6
            table.insert(getgenv().ThemedElements.Strokes, indStroke)

            local Indicator = Instance.new("Frame")
            Indicator.Size = UDim2.new(0, 16, 0, 16)
            Indicator.Position = UDim2.new(0, 2, 0.5, -8)
            Indicator.BackgroundColor3 = Color3.fromRGB(110, 110, 120)
            Indicator.ZIndex = 3
            Indicator.Parent = IndicatorBg
            Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)
            table.insert(getgenv().ThemedElements.Toggles, {obj = IndicatorBg, state = state})

            ToggleBtn.MouseButton1Click:Connect(function()
                state = not state
                for _, el in pairs(RegisteredElements) do
                    if el.obj == ToggleBtn then el.state = state end
                end
                for _, el in pairs(getgenv().ThemedElements.Toggles) do
                    if el.obj == IndicatorBg then el.state = state end
                end

                if state then
                    TweenService:Create(Indicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -18, 0.5, -8), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    TweenService:Create(IndicatorBg, TweenInfo.new(0.3), {BackgroundColor3 = getgenv().ThemeColor}):Play()
                    if TitleLbl then
                        TweenService:Create(TitleLbl, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    end
                    indStroke.Transparency = 0.3
                else
                    TweenService:Create(Indicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 2, 0.5, -8), BackgroundColor3 = Color3.fromRGB(110, 110, 120)}):Play()
                    TweenService:Create(IndicatorBg, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(18, 18, 25)}):Play()
                    if TitleLbl then
                        TweenService:Create(TitleLbl, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(200, 200, 210)}):Play()
                    end
                    indStroke.Transparency = 0.6
                end
                UpdateLanguage()
                callback(state)
            end)
        end

        TabFunctions.AddButton = function(self, btnData, callback)
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, 0, 0, 40)
            Btn.BackgroundColor3 = getgenv().ThemeColor
            Btn.BackgroundTransparency = 0.1
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.Font = Enum.Font.GothamBold
            Btn.TextSize = 12
            Btn.Text = btnData.en
            Btn.ZIndex = 3
            Btn.Parent = TabContent
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)

            local stroke = Instance.new("UIStroke", Btn)
            stroke.Thickness = 1
            stroke.Transparency = 0.3
            table.insert(getgenv().ThemedElements.Strokes, stroke)

            RegisterElement(Btn, btnData, "Button", nil)
            table.insert(getgenv().ThemedElements.Bgs, Btn)

            Btn.MouseEnter:Connect(function()
                TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.15}):Play()
                stroke.Transparency = 0.1
            end)
            Btn.MouseLeave:Connect(function()
                TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
                stroke.Transparency = 0.3
            end)
            Btn.MouseButton1Click:Connect(function()
                TweenService:Create(Btn, TweenInfo.new(0.08), {Size = UDim2.new(0.97, 0, 0, 38)}):Play()
                task.wait(0.1)
                TweenService:Create(Btn, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, 40)}):Play()
                pcall(callback)
            end)
        end

        TabFunctions.AddSlider = function(self, sliderData, min, max, default, callback)
            local state = {value = default}
            local SliderBg = Instance.new("Frame")
            SliderBg.Size = UDim2.new(1, 0, 0, 55)
            SliderBg.BackgroundColor3 = Color3.fromRGB(24, 22, 32)
            SliderBg.BackgroundTransparency = 0.2
            SliderBg.ZIndex = 3
            SliderBg.Parent = TabContent
            Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(0, 8)

            local stroke = Instance.new("UIStroke", SliderBg)
            stroke.Color = getgenv().ThemeColor
            stroke.Thickness = 0.6
            stroke.Transparency = 0.8
            table.insert(getgenv().ThemedElements.Strokes, stroke)

            local TitleLbl = Instance.new("TextLabel")
            TitleLbl.Size = UDim2.new(1, -60, 0, 20)
            TitleLbl.Position = UDim2.new(0, 15, 0, 8)
            TitleLbl.BackgroundTransparency = 1
            TitleLbl.TextColor3 = Color3.fromRGB(220, 220, 230)
            TitleLbl.Font = Enum.Font.GothamSemibold
            TitleLbl.TextSize = 11
            TitleLbl.Text = sliderData.en
            TitleLbl.ZIndex = 3
            TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
            TitleLbl.Parent = SliderBg
            RegisterElement(TitleLbl, sliderData, "Label", nil)

            local BarBg = Instance.new("Frame")
            BarBg.Size = UDim2.new(1, -30, 0, 6)
            BarBg.Position = UDim2.new(0, 15, 0, 38)
            BarBg.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
            BarBg.ZIndex = 3
            BarBg.Parent = SliderBg
            Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1, 0)

            local barStroke = Instance.new("UIStroke", BarBg)
            barStroke.Color = getgenv().ThemeColor
            barStroke.Thickness = 0.6
            barStroke.Transparency = 0.7
            table.insert(getgenv().ThemedElements.Strokes, barStroke)

            local FillBar = Instance.new("Frame")
            local initPct = (default - min) / (max - min)
            FillBar.Size = UDim2.new(initPct, 0, 1, 0)
            FillBar.BackgroundColor3 = getgenv().ThemeColor
            FillBar.ZIndex = 4
            FillBar.Parent = BarBg
            Instance.new("UICorner", FillBar).CornerRadius = UDim.new(1, 0)
            table.insert(getgenv().ThemedElements.Bgs, FillBar)

            local Knob = Instance.new("Frame")
            Knob.Size = UDim2.new(0, 14, 0, 14)
            Knob.Position = UDim2.new(1, -7, 0.5, -7)
            Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Knob.ZIndex = 5
            Knob.Parent = FillBar
            Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

            local knobStroke = Instance.new("UIStroke", Knob)
            knobStroke.Color = getgenv().ThemeColor
            knobStroke.Thickness = 1.5
            table.insert(getgenv().ThemedElements.Strokes, knobStroke)

            local TriggerBtn = Instance.new("TextButton")
            TriggerBtn.Size = UDim2.new(1, 0, 1, 0)
            TriggerBtn.BackgroundTransparency = 1
            TriggerBtn.Text = ""
            TriggerBtn.ZIndex = 4
            TriggerBtn.Parent = BarBg

            local ValueLbl = Instance.new("TextLabel")
            ValueLbl.Size = UDim2.new(0, 40, 0, 20)
            ValueLbl.Position = UDim2.new(1, -55, 0, 8)
            ValueLbl.BackgroundTransparency = 1
            ValueLbl.TextColor3 = getgenv().ThemeColor
            ValueLbl.Text = tostring(default)
            ValueLbl.Font = Enum.Font.GothamBold
            ValueLbl.TextSize = 12
            ValueLbl.ZIndex = 3
            ValueLbl.TextXAlignment = Enum.TextXAlignment.Right
            ValueLbl.Parent = SliderBg
            table.insert(getgenv().ThemedElements.Texts, ValueLbl)

            local isDragging = false

            local function UpdateSlider(input)
                local pct = math.clamp((input.Position.X - BarBg.AbsolutePosition.X) / BarBg.AbsoluteSize.X, 0, 1)
                local val = math.floor(min + ((max - min) * pct))
                state.value = val
                TweenService:Create(FillBar, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(pct, 0, 1, 0)}):Play()
                ValueLbl.Text = tostring(val)
                callback(val)
            end

            TriggerBtn.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    isDragging = true
                    UpdateSlider(input)
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    isDragging = false
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    UpdateSlider(input)
                end
            end)
        end

        TabFunctions.AddInput = function(self, inputData, callback)
            local InputBox = Instance.new("TextBox")
            InputBox.Size = UDim2.new(1, 0, 0, 40)
            InputBox.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
            InputBox.BackgroundTransparency = 0.2
            InputBox.Text = ""
            InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            InputBox.PlaceholderText = inputData.en
            InputBox.Font = Enum.Font.GothamSemibold
            InputBox.TextSize = 12
            InputBox.ZIndex = 3
            InputBox.ClearTextOnFocus = false
            InputBox.Parent = TabContent
            Instance.new("UICorner", InputBox).CornerRadius = UDim.new(0, 8)

            local stroke = Instance.new("UIStroke", InputBox)
            stroke.Color = getgenv().ThemeColor
            stroke.Thickness = 1
            stroke.Transparency = 0.5
            table.insert(getgenv().ThemedElements.Strokes, stroke)

            RegisterElement(InputBox, inputData, "Input", nil)
            InputBox.FocusLost:Connect(function()
                callback(InputBox.Text)
            end)
        end

        TabFunctions.AddMultiDropdown = function(self, ddData, options, callback)
            local state = {selected = {}}
            local DDBg = Instance.new("Frame")
            DDBg.Size = UDim2.new(1, 0, 0, 40)
            DDBg.BackgroundColor3 = Color3.fromRGB(24, 22, 32)
            DDBg.BackgroundTransparency = 0.2
            DDBg.ClipsDescendants = true
            DDBg.ZIndex = 3
            DDBg.Parent = TabContent
            Instance.new("UICorner", DDBg).CornerRadius = UDim.new(0, 8)

            local stroke = Instance.new("UIStroke", DDBg)
            stroke.Color = getgenv().ThemeColor
            stroke.Thickness = 0.6
            stroke.Transparency = 0.8
            table.insert(getgenv().ThemedElements.Strokes, stroke)

            local MainBtn = Instance.new("TextButton")
            MainBtn.Size = UDim2.new(1, 0, 0, 40)
            MainBtn.BackgroundTransparency = 1
            MainBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
            MainBtn.Font = Enum.Font.GothamSemibold
            MainBtn.TextSize = 11
            MainBtn.Text = "   " .. ddData.en
            MainBtn.TextXAlignment = Enum.TextXAlignment.Left
            MainBtn.ZIndex = 3
            MainBtn.Parent = DDBg

            local Arrow = Instance.new("TextLabel")
            Arrow.Size = UDim2.new(0, 40, 0, 40)
            Arrow.Position = UDim2.new(1, -40, 0, 0)
            Arrow.BackgroundTransparency = 1
            Arrow.Text = "▼"
            Arrow.TextColor3 = getgenv().ThemeColor
            Arrow.Font = Enum.Font.GothamBold
            Arrow.TextSize = 11
            Arrow.ZIndex = 3
            Arrow.Parent = DDBg
            table.insert(getgenv().ThemedElements.Texts, Arrow)

            RegisterElement(MainBtn, ddData, "MultiDropdown", state)

            local ScrollContainer = Instance.new("ScrollingFrame")
            ScrollContainer.Size = UDim2.new(1, 0, 1, -40)
            ScrollContainer.Position = UDim2.new(0, 0, 0, 40)
            ScrollContainer.BackgroundTransparency = 1
            ScrollContainer.ScrollBarThickness = 3
            ScrollContainer.ScrollBarImageColor3 = getgenv().ThemeColor
            ScrollContainer.ScrollBarImageTransparency = 0.5
            ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
            ScrollContainer.ZIndex = 3
            ScrollContainer.Parent = DDBg
            table.insert(getgenv().ThemedElements.ScrollBars, ScrollContainer)

            local Layout = Instance.new("UIListLayout", ScrollContainer)
            Layout.SortOrder = Enum.SortOrder.LayoutOrder
            Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)
            end)

            local optionBtns = {}
            local isOpen = false

            MainBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                local visibleCount = 0
                for _, btn in ipairs(optionBtns) do
                    if btn.Visible then visibleCount = visibleCount + 1 end
                end
                local targetHeight = isOpen and (40 + (math.min(visibleCount, 5) * 30)) or 40
                TweenService:Create(Arrow, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = isOpen and 180 or 0}):Play()
                TweenService:Create(DDBg, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, targetHeight)}):Play()
            end)

            for _, opt in ipairs(options) do
                local OptBtn = Instance.new("TextButton")
                OptBtn.Name = opt
                OptBtn.Size = UDim2.new(1, 0, 0, 30)
                OptBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
                OptBtn.BackgroundTransparency = 0.6
                OptBtn.Text = "        " .. opt
                OptBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
                OptBtn.Font = Enum.Font.GothamSemibold
                OptBtn.TextSize = 11
                OptBtn.TextXAlignment = Enum.TextXAlignment.Left
                OptBtn.ZIndex = 3
                OptBtn.Parent = ScrollContainer
                table.insert(optionBtns, OptBtn)
                AddHoverEffect(OptBtn, Color3.fromRGB(30, 30, 35), Color3.fromRGB(45, 45, 52))

                local CheckIcon = Instance.new("TextLabel")
                CheckIcon.Size = UDim2.new(0, 20, 0, 20)
                CheckIcon.Position = UDim2.new(0, 10, 0.5, -10)
                CheckIcon.BackgroundTransparency = 1
                CheckIcon.Text = "✓"
                CheckIcon.TextColor3 = getgenv().ThemeColor
                CheckIcon.TextTransparency = 1
                CheckIcon.Font = Enum.Font.GothamBold
                CheckIcon.TextSize = 14
                CheckIcon.ZIndex = 3
                CheckIcon.Parent = OptBtn
                table.insert(getgenv().ThemedElements.Checks, CheckIcon)

                OptBtn.MouseButton1Click:Connect(function()
                    local idx = table.find(state.selected, opt)
                    if idx then
                        table.remove(state.selected, idx)
                        TweenService:Create(CheckIcon, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
                        TweenService:Create(OptBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(180, 180, 180)}):Play()
                    else
                        table.insert(state.selected, opt)
                        TweenService:Create(CheckIcon, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
                        TweenService:Create(OptBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    end
                    UpdateLanguage()
                    callback(state.selected)
                end)
            end
        end

        TabFunctions.AddSingleDropdown = function(self, ddData, options, callback)
            local state = {selected = options[1]}
            local DDBg = Instance.new("Frame")
            DDBg.Size = UDim2.new(1, 0, 0, 40)
            DDBg.BackgroundColor3 = Color3.fromRGB(24, 22, 32)
            DDBg.BackgroundTransparency = 0.2
            DDBg.ClipsDescendants = true
            DDBg.ZIndex = 3
            DDBg.Parent = TabContent
            Instance.new("UICorner", DDBg).CornerRadius = UDim.new(0, 8)

            local stroke = Instance.new("UIStroke", DDBg)
            stroke.Color = getgenv().ThemeColor
            stroke.Thickness = 0.6
            stroke.Transparency = 0.8
            table.insert(getgenv().ThemedElements.Strokes, stroke)

            local MainBtn = Instance.new("TextButton")
            MainBtn.Size = UDim2.new(1, 0, 0, 40)
            MainBtn.BackgroundTransparency = 1
            MainBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
            MainBtn.Font = Enum.Font.GothamSemibold
            MainBtn.TextSize = 11
            MainBtn.Text = "   " .. ddData.en
            MainBtn.TextXAlignment = Enum.TextXAlignment.Left
            MainBtn.ZIndex = 3
            MainBtn.Parent = DDBg

            local Arrow = Instance.new("TextLabel")
            Arrow.Size = UDim2.new(0, 40, 0, 40)
            Arrow.Position = UDim2.new(1, -40, 0, 0)
            Arrow.BackgroundTransparency = 1
            Arrow.Text = "▼"
            Arrow.TextColor3 = getgenv().ThemeColor
            Arrow.Font = Enum.Font.GothamBold
            Arrow.TextSize = 11
            Arrow.ZIndex = 3
            Arrow.Parent = DDBg
            table.insert(getgenv().ThemedElements.Texts, Arrow)

            RegisterElement(MainBtn, ddData, "Dropdown", state)

            local ScrollContainer = Instance.new("ScrollingFrame")
            ScrollContainer.Size = UDim2.new(1, 0, 1, -40)
            ScrollContainer.Position = UDim2.new(0, 0, 0, 40)
            ScrollContainer.BackgroundTransparency = 1
            ScrollContainer.ScrollBarThickness = 3
            ScrollContainer.ScrollBarImageColor3 = getgenv().ThemeColor
            ScrollContainer.ScrollBarImageTransparency = 0.5
            ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
            ScrollContainer.ZIndex = 3
            ScrollContainer.Parent = DDBg
            table.insert(getgenv().ThemedElements.ScrollBars, ScrollContainer)

            local Layout = Instance.new("UIListLayout", ScrollContainer)
            Layout.SortOrder = Enum.SortOrder.LayoutOrder
            Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)
            end)

            local optionBtns = {}
            local isOpen = false

            MainBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                local visibleCount = 0
                for _, btn in ipairs(optionBtns) do
                    if btn.Visible then visibleCount = visibleCount + 1 end
                end
                local targetHeight = isOpen and (40 + (math.min(visibleCount, 5) * 30)) or 40
                TweenService:Create(Arrow, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = isOpen and 180 or 0}):Play()
                TweenService:Create(DDBg, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, targetHeight)}):Play()
            end)

            for _, opt in ipairs(options) do
                local OptBtn = Instance.new("TextButton")
                OptBtn.Name = opt
                OptBtn.Size = UDim2.new(1, 0, 0, 30)
                OptBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
                OptBtn.BackgroundTransparency = 0.6
                OptBtn.Text = "        " .. opt
                OptBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
                OptBtn.Font = Enum.Font.GothamSemibold
                OptBtn.TextSize = 11
                OptBtn.TextXAlignment = Enum.TextXAlignment.Left
                OptBtn.ZIndex = 3
                OptBtn.Parent = ScrollContainer
                table.insert(optionBtns, OptBtn)
                AddHoverEffect(OptBtn, Color3.fromRGB(30, 30, 35), Color3.fromRGB(45, 45, 52))

                local CheckIcon = Instance.new("TextLabel")
                CheckIcon.Size = UDim2.new(0, 20, 0, 20)
                CheckIcon.Position = UDim2.new(0, 10, 0.5, -10)
                CheckIcon.BackgroundTransparency = 1
                CheckIcon.Text = "✓"
                CheckIcon.TextColor3 = getgenv().ThemeColor
                CheckIcon.TextTransparency = 1
                CheckIcon.Font = Enum.Font.GothamBold
                CheckIcon.TextSize = 14
                CheckIcon.ZIndex = 3
                CheckIcon.Parent = OptBtn
                table.insert(getgenv().ThemedElements.Checks, CheckIcon)

                OptBtn.MouseButton1Click:Connect(function()
                    state.selected = opt
                    UpdateLanguage()
                    isOpen = false
                    TweenService:Create(Arrow, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                    TweenService:Create(DDBg, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 40)}):Play()
                    callback(opt)
                end)
            end
        end

        TabFunctions.AddImage = function(self, imageUrl, height)
            local ImgContainer = Instance.new("Frame")
            ImgContainer.Size = UDim2.new(1, 0, 0, height)
            ImgContainer.BackgroundTransparency = 1
            ImgContainer.ZIndex = 3
            ImgContainer.Parent = TabContent

            local Img = Instance.new("ImageLabel")
            Img.Size = UDim2.new(1, 0, 1, 0)
            Img.BackgroundTransparency = 1
            Img.Image = imageUrl
            Img.ScaleType = Enum.ScaleType.Fit
            Img.ZIndex = 3
            Img.Parent = ImgContainer
            Instance.new("UICorner", Img).CornerRadius = UDim.new(0, 8)
        end

        TabFunctions.AddSection = function(self, secData, isOpenDefault)
            local isOpen = isOpenDefault == true
            local SecFrame = Instance.new("Frame")
            SecFrame.Size = UDim2.new(1, 0, 0, (isOpen and 40) or 35)
            SecFrame.BackgroundTransparency = 1
            SecFrame.Parent = TabContent

            local SecBtn = Instance.new("TextButton")
            SecBtn.Size = UDim2.new(1, 0, 0, 35)
            SecBtn.BackgroundColor3 = Color3.fromRGB(28, 26, 36)
            SecBtn.BackgroundTransparency = 0.5
            SecBtn.Text = ""
            SecBtn.Parent = SecFrame
            Instance.new("UICorner", SecBtn).CornerRadius = UDim.new(0, 6)

            local SecTitle = Instance.new("TextLabel")
            SecTitle.Size = UDim2.new(1, -40, 1, 0)
            SecTitle.Position = UDim2.new(0, 12, 0, 0)
            SecTitle.BackgroundTransparency = 1
            SecTitle.Text = secData.en
            SecTitle.TextColor3 = getgenv().ThemeColor
            SecTitle.Font = Enum.Font.GothamBold
            SecTitle.TextSize = 12
            SecTitle.TextXAlignment = Enum.TextXAlignment.Left
            SecTitle.Parent = SecBtn
            RegisterElement(SecTitle, secData, "Label", nil)
            table.insert(getgenv().ThemedElements.Texts, SecTitle)

            local Arrow = Instance.new("TextLabel")
            Arrow.Size = UDim2.new(0, 35, 0, 35)
            Arrow.Position = UDim2.new(1, -35, 0, 0)
            Arrow.BackgroundTransparency = 1
            Arrow.Text = "▼"
            Arrow.TextColor3 = getgenv().ThemeColor
            Arrow.Font = Enum.Font.GothamBold
            Arrow.TextSize = 12
            Arrow.Rotation = (isOpen and 0) or -90
            Arrow.Parent = SecBtn
            table.insert(getgenv().ThemedElements.Texts, Arrow)

            local InnerContainer = Instance.new("Frame")
            InnerContainer.Size = UDim2.new(1, -20, 0, 0)
            InnerContainer.Position = UDim2.new(0, 6, 0, 40)
            InnerContainer.BackgroundTransparency = 1
            InnerContainer.ClipsDescendants = not isOpen
            InnerContainer.Parent = SecFrame

            local InnerLayout = Instance.new("UIListLayout", InnerContainer)
            InnerLayout.SortOrder = Enum.SortOrder.LayoutOrder
            InnerLayout.Padding = UDim.new(0, 6)

            local function UpdateSecSize()
                if isOpen then
                    InnerContainer.Size = UDim2.new(1, -6, 0, InnerLayout.AbsoluteContentSize.Y)
                    SecFrame.Size = UDim2.new(1, 0, 0, 40 + InnerLayout.AbsoluteContentSize.Y)
                end
            end
            InnerLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateSecSize)

            SecBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                if isOpen then
                    TweenService:Create(Arrow, TweenInfo.new(0.3), {Rotation = 0}):Play()
                    TweenService:Create(InnerContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(1, -6, 0, InnerLayout.AbsoluteContentSize.Y)}):Play()
                    TweenService:Create(SecFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 40 + InnerLayout.AbsoluteContentSize.Y)}):Play()
                    task.delay(0.3, function() if isOpen then InnerContainer.ClipsDescendants = false end end)
                else
                    InnerContainer.ClipsDescendants = true
                    TweenService:Create(Arrow, TweenInfo.new(0.3), {Rotation = -90}):Play()
                    TweenService:Create(InnerContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(1, -6, 0, 0)}):Play()
                    TweenService:Create(SecFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 35)}):Play()
                end
            end)

            task.spawn(function()
                task.wait(0.1)
                if isOpen then
                    UpdateSecSize()
                    InnerContainer.ClipsDescendants = false
                else
                    InnerContainer.Size = UDim2.new(1, -6, 0, 0)
                    SecFrame.Size = UDim2.new(1, 0, 0, 35)
                    InnerContainer.ClipsDescendants = true
                end
            end)

            return CreateTab(InnerContainer) 
        end
        return TabFunctions
    end
    return CreateTab
end

local TabConstructor = CreateUI()

local RarityList = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret", "Divine", "Hacked", "OG", "Celestial", "Eternal", "Impossible", "Godly"}
local MutationList = {"Diamond", "Plasma", "Void", "Neon", "Enchanted", "Shadows", "Bacon", "No Mutation"}
local ColorPalette = {
    ["Cyan (Light Blue)"] = Color3.fromRGB(0, 200, 255),
    ["Amethyst (Purple)"] = Color3.fromRGB(130, 90, 230),
    ["Ruby (Red)"] = Color3.fromRGB(230, 50, 50),
    ["Sapphire (Blue)"] = Color3.fromRGB(50, 100, 230),
    ["Emerald (Green)"] = Color3.fromRGB(50, 200, 80),
    ["Gold (Yellow)"] = Color3.fromRGB(230, 180, 50),
    ["Pink (Kawaii)"] = Color3.fromRGB(255, 100, 180)
}

getgenv().FlySettings = {Enabled = false, Speed = 50}
getgenv().SpeedhackSettings = {Enabled = false, Speed = 16}
getgenv().AntiAFK = false
getgenv().AutoCollectIBH = false
getgenv().SpamEquipGlitch = false
getgenv().AutoSellBrainrot = false
getgenv().SellRarities = {}
getgenv().AutoSellCoil = false
getgenv().AutoSellLuckyBlock = false
getgenv().AutoRewards = false
getgenv().AutoWheel = false
getgenv().AutoLuckyBlock = false
getgenv().AutoUpgradeBase = false
getgenv().AutoEquipBest = false
getgenv().AutoBat = false
getgenv().WebhookURL = ""
getgenv().SendAllToWebhook = false
getgenv().AutoWeightX2 = false
getgenv().AutoCollectKLB = false
getgenv().AutoUpgradeKLB = false
getgenv().ShowLiveLogs = false
getgenv().AutoFarmingKLB = false
getgenv().AutoTweenBackKLB = false
getgenv().AutoMobs = false
getgenv().AutoAttack = false
getgenv().AutoTrain = false
getgenv().AutoCollectCashLBR = false
getgenv().AutoUpgradeLBR = false
getgenv().AutoRebirthLBR = false

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.K then
        if MainUI then MainUI.Enabled = not MainUI.Enabled end
    end
end)

local isMap1 = false
local isMap2 = false
local isMap3 = false
local Map1ID = 105633123928470
local Map2ID = 89469502395823

if game.PlaceId == Map1ID then
    isMap1 = true
elseif game.PlaceId == Map2ID then
    isMap2 = true
else
    pcall(function()
        local lowerMapName = string.lower(MapName)
        if string.find(lowerMapName, "inside brainrot") then
            isMap1 = true
        elseif string.find(lowerMapName, "kick a lucky") or (ReplicatedStorage:FindFirstChild("Shared") and ReplicatedStorage.Shared:FindFirstChild("Packages") and ReplicatedStorage.Shared.Packages:FindFirstChild("Network")) then
            isMap2 = true
        elseif string.find(lowerMapName, "lucky block rush") or (ReplicatedStorage:FindFirstChild("Packages") and ReplicatedStorage.Packages:FindFirstChild("_Index") and ReplicatedStorage.Packages._Index:FindFirstChild("sleitnick_knit@1.7.0")) then
            isMap3 = true
        end
    end)
end

local TabInfo = TabConstructor({id = "Info", en = "Info"})
local TabMain = TabConstructor({id = "Main", en = "Main"})
local TabAuto = TabConstructor({id = "Automatically", en = "Automatically"})
local TabMisc = TabConstructor({id = "Miscellaneous", en = "Miscellaneous"})
local TabWebhook = nil

local SecProfile = TabInfo:AddSection({id = "Profil Hub", en = "Hub Profile"}, true)
SecProfile:AddLabel({id = "🎉 Selamat Datang di Skidder Pro Max - TheRealBanHammer", en = "🎉 Welcome to Skidder Pro Max - TheRealBanHammer"})
SecProfile:AddLabel({id = "🗺️ Map Saat Ini: " .. MapName, en = "🗺️ Current Map: " .. MapName})
SecProfile:AddLabel({id = "🔥 Script Paling OP, 100% Undetected!", en = "🔥 The Most OP Script, 100% Undetected!"})
SecProfile:AddImage(IconUrl2, 180)

local SecComm = TabInfo:AddSection({id = "Komunitas", en = "Community"}, true)
SecComm:AddLabel({id = "✨ Ayo Gabung Komunitas Discord Kami! ✨", en = "✨ Join Our Discord Community! ✨"})
SecComm:AddButton({id = "📢 Salin Link Discord", en = "📢 Copy Discord Link"}, function()
    if setclipboard then
        setclipboard("https://discord.gg/rTGF5xhe3h")
        CreateNotification("Link Tersalin! 💖", "Link Discord berhasil disalin ke clipboard!", 5)
    else
        CreateNotification("Gagal", "Eksekutormu tidak mendukung fitur setclipboard.", 4)
    end
end)

local SecCredits = TabInfo:AddSection({id = "Créditos", en = "Credits"}, true)
SecCredits:AddLabel({id = "Desofuscador: Sr_KevinYT", en = "Deobfuscator: Sr_KevinYT"})

local SecTheme = TabInfo:AddSection({id = "🎨 Pengaturan Tema", en = "🎨 Theme Settings"}, true)
SecTheme:AddSingleDropdown({id = "Warna Tema UI", en = "UI Theme Color"}, {"Cyan (Light Blue)", "Amethyst (Purple)", "Ruby (Red)", "Sapphire (Blue)", "Emerald (Green)", "Gold (Yellow)", "Pink (Kawaii)"}, function(val)
    if ColorPalette[val] then UpdateTheme(ColorPalette[val]) end
end)
SecTheme:AddInput({id = "Custom Warna (Hex: #FFFFFF / RGB: 255,255,255)", en = "Custom Color (Hex: #FFFFFF / RGB: 255,255,255)"}, function(val)
    local cleanVal = val:gsub(" ", "")
    local c = nil
    if cleanVal:find(",") then
        local r, g, b = cleanVal:match("(%d+),(%d+),(%d+)")
        if r and g and b then
            c = Color3.fromRGB(math.clamp(tonumber(r), 0, 255), math.clamp(tonumber(g), 0, 255), math.clamp(tonumber(b), 0, 255))
        end
    elseif cleanVal:sub(1, 1) == "#" or #cleanVal == 6 then
        local hex = cleanVal:gsub("#", "")
        if #hex == 6 and tonumber(hex, 16) then
            c = Color3.fromRGB(tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16))
        end
    end
    if c then
        UpdateTheme(c)
        CreateNotification("Tema Diperbarui", "Warna kustom berhasil diterapkan dengan mulus!", 4)
    else
        CreateNotification("Format Salah!", "Gunakan format RGB (Cth: 255,0,0) atau Hex (Cth: #FF0000).", 4)
    end
end)

local SecMove = TabMisc:AddSection({id = "🏃‍♂️ Gerakan Cepat & Terbang", en = "🏃‍♂️ Movement Hacks & Fly Safe"})
SecMove:AddToggle({id = "Kecepatan Lari (Aman)", en = "Safe Speedhack", id_desc = "Mempercepat lari tanpa terdeteksi", en_desc = "Increase walk speed safely"}, function(val)
    getgenv().SpeedhackSettings.Enabled = val
end)
SecMove:AddSlider({id = "Atur Kecepatan Berjalan", en = "Walk Speed"}, 16, 200, 16, function(val)
    getgenv().SpeedhackSettings.Speed = val
end)
SecMove:AddToggle({id = "Terbang & Tembus Tembok", en = "Fly & NoClip", id_desc = "Terbang bebas ke mana saja", en_desc = "Fly anywhere freely"}, function(val)
    getgenv().FlySettings.Enabled = val
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    if not val then
        if root:FindFirstChild("HackFlyBV") then root.HackFlyBV:Destroy() end
        if root:FindFirstChild("HackFlyBG") then root.HackFlyBG:Destroy() end
    end
end)
SecMove:AddSlider({id = "Atur Kecepatan Terbang", en = "Fly Speed"}, 10, 300, 50, function(val)
    getgenv().FlySettings.Speed = val
end)

local SecSec = TabMisc:AddSection({id = "🛡️ Fitur Keamanan (Anti-Kick)", en = "🛡️ Security Utilities"})
SecSec:AddToggle({id = "Anti-AFK (Anti-Keluar)", en = "Anti-AFK (Anti-Disconnect)", id_desc = "Mencegah kick dari game saat diam", en_desc = "Prevents idle kick from the game"}, function(val)
    getgenv().AntiAFK = val
    if val then CreateNotification("Anti-AFK Aktif", "Anda tidak akan di-kick karena diam.", 4) end
end)

local function InitMap1()
    local function GetRemo()
        local r = nil
        pcall(function() r = ReplicatedStorage.packages._Index["littensy_remo@1.5.3"].remo.container end)
        if not r then
            for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                if v.Name == "container" and v.Parent and v.Parent.Name == "remo" then
                    r = v
                    break
                end
            end
        end
        return r
    end

    local SecBaseNav = TabMain:AddSection({id = "🌀 Navigasi Markas", en = "🌀 Base Navigation"})
    SecBaseNav:AddButton({id = "Teleportasi ke Markas (Instan)", en = "Teleport to Base (Instant)"}, function()
        pcall(function()
            local r = GetRemo()
            if r and r:FindFirstChild("game.base.teleportToBase") then r["game.base.teleportToBase"]:FireServer() end
        end)
    end)
    SecBaseNav:AddButton({id = "👑 TP ke Head Terbaik (lordVeyrath)", en = "👑 TP to Best Head (lordVeyrath)"}, function()
        pcall(function()
            local r = GetRemo()
            if r and r:FindFirstChild("game.nest.enterNest") then r["game.nest.enterNest"]:FireServer("lordVeyrath") end
        end)
    end)
    SecBaseNav:AddButton({id = "👑 TP ke Head Terbaik (Meowl)", en = "👑 TP to Best Head (Meowl)"}, function()
        pcall(function()
            local r = GetRemo()
            if r and r:FindFirstChild("game.nest.enterNest") then r["game.nest.enterNest"]:FireServer("meowl") end
        end)
    end)
    SecBaseNav:AddButton({id = "🚪 Keluar Markas (Instan)", en = "🚪 Leave Base (Instant)"}, function()
        pcall(function()
            local r = GetRemo()
            if r and r:FindFirstChild("game.nest.leaveNest") then r["game.nest.leaveNest"]:FireServer() end
        end)
    end)
    SecBaseNav:AddButton({id = "🚀 Berjalan ke Markas", en = "🚀 Walk to Base"}, function()
        pcall(function()
            local char = LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            local dest = CFrame.new(-35, 33, -295)
            local dist = (root.Position - dest.Position).Magnitude
            local speed = 150
            local time = dist / speed
            if time < 0.1 then time = 0.1 end
            TweenService:Create(root, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = dest}):Play()
        end)
    end)

    local SecCombat = TabMain:AddSection({id = "⚔️ Pertarungan & Utilitas", en = "⚔️ Combat & Utilities"})
    SecCombat:AddToggle({id = "Pukul Tongkat Otomatis (Aura)", en = "Auto Hit Bat (Kill Aura)"}, function(val) getgenv().AutoBat = val end)
    SecCombat:AddButton({id = "Beli Speed Coil Instan", en = "Buy Speed Coil Instantly"}, function()
        local r = GetRemo()
        if r and r:FindFirstChild("data.toolShop.buySpeedCoil") then
            pcall(function() r:FindFirstChild("data.toolShop.buySpeedCoil"):FireServer("yellow") end)
        end
    end)

    local SecFarm = TabAuto:AddSection({id = "💸 Mode Farming", en = "💸 Auto Farm Mode"})
    SecFarm:AddToggle({id = "Ambil Uang Otomatis", en = "Auto Collect Money", id_desc = "Otomatis mengumpulkan uang dari markas", en_desc = "Auto collect cash from plot"}, function(val) getgenv().AutoCollectIBH = val end)
    SecFarm:AddToggle({id = "🔥 Glitch Pasang Copot (Uang Cepat)", en = "🔥 Spam Equip Glitch (Quick Cash)", id_desc = "Glitch untuk mendapatkan uang dengan cepat", en_desc = "Glitch to get quick cash"}, function(val) getgenv().SpamEquipGlitch = val end)
    SecFarm:AddToggle({id = "Bangun/Tingkatkan Markas Otomatis", en = "Auto Build/Upgrade Base"}, function(val) getgenv().AutoUpgradeBase = val end)
    SecFarm:AddToggle({id = "Pasang Brainrot Terbaik Otomatis", en = "Auto Equip Best Brainrots"}, function(val) getgenv().AutoEquipBest = val end)

    local SecSell = TabAuto:AddSection({id = "🎒 Mode Penjualan Otomatis", en = "🎒 Auto Sell Mode"})
    SecSell:AddMultiDropdown({id = "Pilih Rarity Dijual (Brainrot)", en = "Select Rarities to Sell (Brainrot)"}, RarityList, function(val) getgenv().SellRarities = val end)
    SecSell:AddToggle({id = "Mulai Jual Otomatis (Brainrot)", en = "Start Auto Sell (Brainrot)"}, function(val) getgenv().AutoSellBrainrot = val end)
    SecSell:AddToggle({id = "Mulai Jual Otomatis (Coil)", en = "Start Auto Sell (Coils)"}, function(val) getgenv().AutoSellCoil = val end)
    SecSell:AddToggle({id = "Mulai Jual Otomatis (Lucky Block)", en = "Start Auto Sell (Lucky Blocks)"}, function(val) getgenv().AutoSellLuckyBlock = val end)

    local SecClaim = TabAuto:AddSection({id = "🎁 Klaim Hadiah Otomatis", en = "🎁 Auto Claim Rewards"})
    SecClaim:AddToggle({id = "Klaim Waktu Main & Gratisan", en = "Auto Claim Freebies & Playtime"}, function(val) getgenv().AutoRewards = val end)
    SecClaim:AddToggle({id = "Putar Roda (Wheel) Otomatis", en = "Auto Spin Reward Wheel"}, function(val) getgenv().AutoWheel = val end)
    SecClaim:AddToggle({id = "Buka Lucky Block Otomatis", en = "Auto Open Lucky Blocks"}, function(val) getgenv().AutoLuckyBlock = val end)
    SecClaim:AddButton({id = "Ambil Hadiah Grup & Discord (1x)", en = "Claim Group & Discord Rewards (1x)"}, function()
        local r = GetRemo()
        if r then
            pcall(function() r:FindFirstChild("data.discord.claimReward"):FireServer() end)
            pcall(function() r:FindFirstChild("data.group.claimReward"):FireServer() end)
        end
    end)

    task.spawn(function()
        local guidPattern = "^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$"
        while task.wait(1) do
            pcall(function()
                local r = GetRemo()
                if not r then return end
                if getgenv().AutoRewards then
                    pcall(function()
                        r:FindFirstChild("data.rewards.claimPlayReward"):FireServer()
                        r:FindFirstChild("data.rewards.claimFreebie"):FireServer()
                        r:FindFirstChild("data.rewards.claimOfflineMoney"):FireServer()
                    end)
                end
                if getgenv().AutoWheel then pcall(function() r:FindFirstChild("game.wheels.claimReward"):FireServer() end) end
                if getgenv().AutoLuckyBlock then pcall(function() r:FindFirstChild("data.luckyBlock.claimReward"):FireServer() end) end
                if getgenv().AutoUpgradeBase then pcall(function() r:FindFirstChild("data.base.upgradeBase"):FireServer() end) end
                if getgenv().AutoEquipBest then pcall(function() r:FindFirstChild("data.base.equipBestBrainrots"):FireServer() end) end
                
                if getgenv().AutoCollectIBH then
                    local pad = r:FindFirstChild("data.base.collectPadMoney")
                    if pad then
                        for i = 1, 48 do
                            task.spawn(function() pcall(function() if pad:IsA("RemoteFunction") then pad:InvokeServer(i) else pad:FireServer(i) end end) end)
                        end
                    end
                end

                if getgenv().AutoSellBrainrot or getgenv().AutoSellCoil or getgenv().AutoSellLuckyBlock then
                    pcall(function()
                        local sellItem = r:FindFirstChild("data.backpack.sellItem")
                        local backpackGui = LocalPlayer.PlayerGui:FindFirstChild("BackpackGui")
                        if sellItem and backpackGui then
                            local soldIds = {}
                            local entitiesData = nil
                            pcall(function() entitiesData = require(ReplicatedStorage.Shared.Data.EntitiesData) end)
                            
                            for _, v in pairs(backpackGui:GetDescendants()) do
                                local id = nil
                                if type(v.Name) == "string" and string.match(v.Name, guidPattern) then id = v.Name end
                                if not id and v:IsA("StringValue") and string.match(v.Value, guidPattern) then id = v.Value end
                                if not id then
                                    for _, attr in pairs(v:GetAttributes()) do
                                        if type(attr) == "string" and string.match(attr, guidPattern) then id = attr break end
                                    end
                                end

                                if id and not soldIds[id] then
                                    soldIds[id] = true
                                    local isCoil, isLucky = false, false
                                    local rarityFound = nil
                                    local parentFrame = v:FindFirstAncestorWhichIsA("Frame") or v.Parent

                                    if parentFrame then
                                        for _, textLbl in pairs(parentFrame:GetDescendants()) do
                                            if textLbl:IsA("TextLabel") then
                                                local lowerText = string.lower(textLbl.Text)
                                                if string.find(lowerText, "coil") then isCoil = true end
                                                if string.find(lowerText, "lucky") or string.find(lowerText, "block") then isLucky = true end
                                                for _, rType in pairs(RarityList) do
                                                    if string.find(lowerText, string.lower(rType)) then rarityFound = rType break end
                                                end
                                            end
                                        end
                                        if not rarityFound and not isCoil and not isLucky and entitiesData and entitiesData.Brainrots then
                                            for _, textLbl in pairs(parentFrame:GetDescendants()) do
                                                if textLbl:IsA("TextLabel") and entitiesData.Brainrots[textLbl.Text] then
                                                    rarityFound = entitiesData.Brainrots[textLbl.Text].Rarity
                                                    break
                                                end
                                            end
                                        end
                                    end

                                    local shouldSell = false
                                    if getgenv().AutoSellCoil and isCoil then shouldSell = true
                                    elseif getgenv().AutoSellLuckyBlock and isLucky then shouldSell = true
                                    elseif getgenv().AutoSellBrainrot and rarityFound and not isCoil and not isLucky then
                                        for _, rType in pairs(getgenv().SellRarities) do
                                            if string.lower(rarityFound) == string.lower(rType) then shouldSell = true break end
                                        end
                                    end

                                    if shouldSell then
                                        sellItem:FireServer(id)
                                        task.wait(0.05)
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end)

    task.spawn(function()
        while task.wait(0.08) do
            if getgenv().SpamEquipGlitch then
                pcall(function()
                    local r = GetRemo()
                    if r then
                        local unplace = r:FindFirstChild("data.base.unplaceBrainrot")
                        local place = r:FindFirstChild("data.base.placeBrainrot")
                        if unplace and place then
                            unplace:FireServer(7)
                            task.wait(0.01)
                            place:FireServer("87d1185a-ab87-4077-a3a8-0ed458894700", 7)
                        end
                    end
                end)
            end
        end
    end)

    task.spawn(function()
        while task.wait(0.1) do
            pcall(function()
                if getgenv().AutoBat then
                    local r = GetRemo()
                    if r then pcall(function() r:FindFirstChild("game.backpack.bat.hit"):FireServer() end) end
                end
            end)
        end
    end)
end

local function InitMap2()
    pcall(function() require(ReplicatedStorage.Shared.Packages.Network) end)
    TabWebhook = TabConstructor({id = "Webhook", en = "Webhook"})
    
    if CoreGui:FindFirstChild("SkidderProMaxLiveLogUI") then CoreGui.SkidderProMaxLiveLogUI:Destroy() end
    local LogUI = Instance.new("ScreenGui")
    LogUI.Name = "SkidderProMaxLiveLogUI"
    LogUI.Enabled = false
    LogUI.Parent = CoreGui

    local BgBlocker = Instance.new("Frame")
    BgBlocker.Size = UDim2.new(0, 520, 0, 360)
    BgBlocker.Position = UDim2.new(0, 20, 0.5, -180)
    BgBlocker.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BgBlocker.BackgroundTransparency = 0.6
    BgBlocker.BorderSizePixel = 0
    BgBlocker.Parent = LogUI
    Instance.new("UICorner", BgBlocker).CornerRadius = UDim.new(0, 14)

    local LogFrame = Instance.new("Frame")
    LogFrame.Size = UDim2.new(0, 520, 0, 360)
    LogFrame.Position = UDim2.new(0, 20, 0.5, -180)
    LogFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    LogFrame.BorderSizePixel = 0
    LogFrame.BackgroundTransparency = 0.2
    LogFrame.Active = true
    LogFrame.Draggable = true
    LogFrame.Parent = LogUI
    Instance.new("UICorner", LogFrame).CornerRadius = UDim.new(0, 14)

    local logStroke = Instance.new("UIStroke", LogFrame)
    logStroke.Color = Color3.fromRGB(255, 255, 255)
    logStroke.Thickness = 0.8
    logStroke.Transparency = 0.8

    local LogTitle = Instance.new("TextLabel")
    LogTitle.Size = UDim2.new(1, 0, 0, 50)
    LogTitle.BackgroundTransparency = 1
    LogTitle.Text = "✨ Live Gacha Logs Skidder Pro Max - TheRealBanHammer ✨"
    LogTitle.TextColor3 = getgenv().ThemeColor
    LogTitle.Font = Enum.Font.GothamBold
    LogTitle.TextSize = 18
    LogTitle.TextXAlignment = Enum.TextXAlignment.Center
    LogTitle.Parent = LogFrame

    local TitleLine = Instance.new("Frame", LogFrame)
    TitleLine.Size = UDim2.new(0.6, 0, 0, 2)
    TitleLine.Position = UDim2.new(0.2, 0, 0, 50)
    TitleLine.BackgroundColor3 = getgenv().ThemeColor
    TitleLine.BackgroundTransparency = 0.3
    TitleLine.BorderSizePixel = 0
    Instance.new("UICorner", TitleLine).CornerRadius = UDim.new(1, 0)

    local HeaderBar = Instance.new("Frame")
    HeaderBar.Size = UDim2.new(1, -20, 0, 40)
    HeaderBar.Position = UDim2.new(0, 10, 0, 60)
    HeaderBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    HeaderBar.BackgroundTransparency = 0.5
    HeaderBar.Parent = LogFrame
    Instance.new("UICorner", HeaderBar).CornerRadius = UDim.new(0, 8)

    local Header1 = Instance.new("TextLabel", HeaderBar)
    Header1.Size = UDim2.new(0.4, 0, 1, 0)
    Header1.Position = UDim2.new(0, 12, 0, 0)
    Header1.Text = "🎮 Brainrot"
    Header1.BackgroundTransparency = 1
    Header1.TextColor3 = getgenv().ThemeColor
    Header1.Font = Enum.Font.GothamBold
    Header1.TextSize = 12
    Header1.TextXAlignment = Enum.TextXAlignment.Left

    local Header2 = Instance.new("TextLabel", HeaderBar)
    Header2.Size = UDim2.new(0.3, 0, 1, 0)
    Header2.Position = UDim2.new(0.4, 0, 0, 0)
    Header2.Text = "⭐ Rarity"
    Header2.BackgroundTransparency = 1
    Header2.TextColor3 = getgenv().ThemeColor
    Header2.Font = Enum.Font.GothamBold
    Header2.TextSize = 12
    Header2.TextXAlignment = Enum.TextXAlignment.Center

    local Header3 = Instance.new("TextLabel", HeaderBar)
    Header3.Size = UDim2.new(0.3, 0, 1, 0)
    Header3.Position = UDim2.new(0.7, 0, 0, 0)
    Header3.Text = "✨ Mutasi"
    Header3.BackgroundTransparency = 1
    Header3.TextColor3 = getgenv().ThemeColor
    Header3.Font = Enum.Font.GothamBold
    Header3.TextSize = 12
    Header3.TextXAlignment = Enum.TextXAlignment.Center

    local LogScroll = Instance.new("ScrollingFrame")
    LogScroll.Size = UDim2.new(1, -20, 1, -120)
    LogScroll.Position = UDim2.new(0, 10, 0, 110)
    LogScroll.BackgroundTransparency = 1
    LogScroll.ScrollBarThickness = 2
    LogScroll.ScrollBarImageColor3 = getgenv().ThemeColor
    LogScroll.ScrollBarImageTransparency = 0.5
    LogScroll.Parent = LogFrame

    local LogLayout = Instance.new("UIListLayout", LogScroll)
    LogLayout.SortOrder = Enum.SortOrder.LayoutOrder
    LogLayout.Padding = UDim.new(0, 6)
    LogLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        LogScroll.CanvasSize = UDim2.new(0, 0, 0, LogLayout.AbsoluteContentSize.Y + 16)
        task.spawn(function()
            TweenService:Create(LogScroll, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CanvasPosition = Vector2.new(0, LogLayout.AbsoluteContentSize.Y + 16)}):Play()
        end)
    end)

    local function AddLogEntry(rot, rty, mut)
        if not getgenv().ShowLiveLogs then return end
        local EntryBg = Instance.new("Frame")
        EntryBg.Size = UDim2.new(1, -12, 0, 0)
        EntryBg.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        EntryBg.BackgroundTransparency = 0.5
        EntryBg.LayoutOrder = #LogScroll:GetChildren()
        EntryBg.Parent = LogScroll
        Instance.new("UICorner", EntryBg).CornerRadius = UDim.new(0, 6)

        local Lbl1 = Instance.new("TextLabel", EntryBg)
        Lbl1.Size = UDim2.new(0.4, -6, 1, 0)
        Lbl1.Position = UDim2.new(0, 12, 0, 0)
        Lbl1.Text = rot
        Lbl1.BackgroundTransparency = 1
        Lbl1.Font = Enum.Font.GothamBold
        Lbl1.TextSize = 11
        Lbl1.TextXAlignment = Enum.TextXAlignment.Left

        local Lbl2 = Instance.new("TextLabel", EntryBg)
        Lbl2.Size = UDim2.new(0.3, 0, 1, 0)
        Lbl2.Position = UDim2.new(0.4, 0, 0, 0)
        Lbl2.Text = rty
        Lbl2.BackgroundTransparency = 1
        Lbl2.Font = Enum.Font.GothamSemibold
        Lbl2.TextSize = 10
        Lbl2.TextXAlignment = Enum.TextXAlignment.Center

        local Lbl3 = Instance.new("TextLabel", EntryBg)
        Lbl3.Size = UDim2.new(0.3, 0, 1, 0)
        Lbl3.Position = UDim2.new(0.7, 0, 0, 0)
        Lbl3.Text = mut
        Lbl3.BackgroundTransparency = 1
        Lbl3.Font = Enum.Font.GothamSemibold
        Lbl3.TextSize = 10
        Lbl3.TextXAlignment = Enum.TextXAlignment.Center

        TweenService:Create(EntryBg, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, -12, 0, 32)}):Play()

        task.spawn(function()
            while EntryBg and EntryBg.Parent do
                local hsvVal = ((tick() * 0.25) + (EntryBg.LayoutOrder * 0.06)) % 1
                local rainbow = Color3.fromHSV(hsvVal, 0.8, 0.95)
                Lbl1.TextColor3 = rainbow
                Lbl2.TextColor3 = rainbow
                Lbl3.TextColor3 = rainbow
                RunService.RenderStepped:Wait()
            end
        end)

        if #LogScroll:GetChildren() > 50 then
            for _, child in pairs(LogScroll:GetChildren()) do
                if child:IsA("Frame") then
                    local out = TweenService:Create(child, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Size = UDim2.new(1, -12, 0, 0)})
                    out:Play()
                    out.Completed:Connect(function() child:Destroy() end)
                    break
                end
            end
        end
    end

    local SecGacha = TabMain:AddSection({id = "⚡ Pengaturan Gacha", en = "⚡ Gacha Settings"})
    SecGacha:AddToggle({id = "Tampilkan Live Logs (UI)", en = "Show Live Logs (UI)", id_desc = "Menampilkan riwayat gacha di layar (Rainbow)", en_desc = "Display gacha history on screen"}, function(val)
        getgenv().ShowLiveLogs = val
        LogUI.Enabled = val
    end)
    SecGacha:AddToggle({id = "Auto Farm (Safe)", en = "Auto Farm (Safe)", id_desc = "Auto kick + tahan saat dapat gacha", en_desc = "Auto kick + hold when rolling gacha"}, function(val)
        getgenv().AutoFarmingKLB = val
        if val then
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = CFrame.new(699, 3, 226)
                end
            end)
        end
    end)
    SecGacha:AddToggle({id = "Auto Back Base (Safe)", en = "Auto Return to Base", id_desc = "Karakter berjalan otomatis dan aman ke markas", en_desc = "Character automatically walks back to base safely"}, function(val)
        getgenv().AutoTweenBackKLB = val
    end)

    local SecBase = TabAuto:AddSection({id = "💸 Fitur Markas (Base)", en = "💸 Base Features"})
    SecBase:AddToggle({id = "Ambil Uang Otomatis", en = "Auto Collect Money", id_desc = "Otomatis mengumpulkan uang dari markas", en_desc = "Auto collect cash from plot"}, function(val) getgenv().AutoCollectKLB = val end)
    SecBase:AddToggle({id = "Upgrade Brainrot Otomatis", en = "Auto Upgrade Brainrots", id_desc = "Otomatis meningkatkan level brainrot", en_desc = "Automatically upgrades brainrot level"}, function(val) getgenv().AutoUpgradeKLB = val end)
    SecBase:AddToggle({id = "x2 Otomatis Barbel", en = "Auto-Click x2 Weight", id_desc = "Otomatis klik item barbel di layar", en_desc = "Auto click x2 weight item on screen"}, function(val) getgenv().AutoWeightX2 = val end)

    local SecWeb = TabWebhook:AddSection({id = "🌐 Sistem Webhook", en = "🌐 Discord Webhook System"})
    SecWeb:AddInput({id = "URL Webhook Discord", en = "Webhook URL"}, function(val) getgenv().WebhookURL = val end)
    SecWeb:AddToggle({id = "Kirim SEMUA Hasil ke Webhook", en = "Send ALL to Webhook"}, function(val) getgenv().SendAllToWebhook = val end)
    SecWeb:AddButton({id = "Test Kirim Webhook", en = "Test Webhook"}, function()
        if getgenv().WebhookURL ~= "" then
            pcall(function() HTTPRequest({Url = getgenv().WebhookURL, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = HttpService:JSONEncode({content = "[Skidder Pro Max - TheRealBanHammer] Test Webhook Success!"})}) end)
        end
    end)

    task.spawn(function()
        while task.wait(0.05) do
            if getgenv().AutoCollectKLB then
                pcall(function()
                    local network = ReplicatedStorage:FindFirstChild("Shared") and ReplicatedStorage.Shared:FindFirstChild("Packages") and ReplicatedStorage.Shared.Packages:FindFirstChild("Network")
                    local collectEvt = network and network:FindFirstChild("rev_B_Collect")
                    if collectEvt then
                        for i = 1, 30 do
                            task.spawn(function() pcall(function() collectEvt:FireServer(i) end) end)
                        end
                    end
                end)
            end
        end
    end)

    task.spawn(function()
        while task.wait(0.05) do
            if getgenv().AutoUpgradeKLB then
                pcall(function()
                    local network = ReplicatedStorage:FindFirstChild("Shared") and ReplicatedStorage.Shared:FindFirstChild("Packages") and ReplicatedStorage.Shared.Packages:FindFirstChild("Network")
                    local upgradeEvt = network and network:FindFirstChild("rev_B_Upgrade")
                    if upgradeEvt then
                        for i = 1, 30 do
                            task.spawn(function() pcall(function() upgradeEvt:FireServer(i) end) end)
                        end
                    end
                end)
            end
        end
    end)

    task.spawn(function()
        while task.wait(0.5) do
            if getgenv().AutoFarmingKLB then
                pcall(function()
                    local network = ReplicatedStorage:FindFirstChild("Shared") and ReplicatedStorage.Shared:FindFirstChild("Packages") and ReplicatedStorage.Shared.Packages:FindFirstChild("Network")
                    if network then
                        local kickEvt = network:FindFirstChild("rev_KickEvent")
                        if kickEvt then kickEvt:FireServer(1, 1) end
                    end
                end)
            end
        end
    end)

    local function SendWebhook(rot, rty, mut, foundTarget)
        if getgenv().WebhookURL == "" or not HTTPRequest then return end
        local m = (mut == "" or mut == "None") and "None" or mut
        local payload = {}
        if foundTarget then
            payload = {content = "@everyone 🚨 **TARGET FOUND!**", embeds = {{title = "🎉 GACHA SUCCESS", color = 65280, fields = {{name = "Brainrot", value = rot, inline = true}, {name = "Rarity", value = rty, inline = true}, {name = "Mutation", value = m, inline = true}}}}}
        else
            payload = {embeds = {{title = "🎲 Live Roll", color = 16753920, fields = {{name = "Brainrot", value = rot, inline = true}, {name = "Rarity", value = rty, inline = true}, {name = "Mutation", value = m, inline = true}}}}}
        end
        pcall(function() HTTPRequest({Url = getgenv().WebhookURL, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = HttpService:JSONEncode(payload)}) end)
    end

    local function ProcessRoll(name, mut)
        local rarity = "Unknown"
        local m = (mut == "" or mut == "None") and "None" or mut
        pcall(function()
            local entitiesData = require(ReplicatedStorage.Shared.Data.EntitiesData)
            if entitiesData.Brainrots and entitiesData.Brainrots[name] then rarity = entitiesData.Brainrots[name].Rarity or "Common" end
        end)
        task.spawn(function() AddLogEntry(name, rarity, m) end)

        if getgenv().AutoTweenBackKLB then
            task.spawn(function()
                local char = LocalPlayer.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                if root then
                    local targetPos = CFrame.new(703, 3, 257)
                    local dist = (root.Position - targetPos.Position).Magnitude
                    local t = math.max(dist / 60, 0.1)
                    TweenService:Create(root, TweenInfo.new(t, Enum.EasingStyle.Linear), {CFrame = targetPos}):Play()
                    root.Anchored = false
                    root.Velocity = Vector3.new(0, 0, 0)
                end
            end)
        end

        if getgenv().SendAllToWebhook then
            task.spawn(function() SendWebhook(name, rarity, m, false) end)
        end
    end

    pcall(function()
        for _, v in pairs(ReplicatedStorage:GetDescendants()) do
            if v:IsA("RemoteEvent") and string.find(v.Name, "rev_") then
                v.OnClientEvent:Connect(function(...)
                    local args = {...}
                    pcall(function()
                        local playerMatch = false
                        local function SearchArgs(arg)
                            if type(arg) == "string" then
                                for _, p in pairs(Players:GetPlayers()) do
                                    if p ~= LocalPlayer and (arg == p.Name or arg == p.DisplayName) then playerMatch = true end
                                end
                            elseif type(arg) == "table" then
                                for _, val in pairs(arg) do SearchArgs(val) end
                            end
                        end
                        for _, a in pairs(args) do SearchArgs(a) end
                        if playerMatch then return end

                        local a1, a2 = args[1], args[2]
                        if a1 == "Brainrot" and type(a2) == "table" then
                            ProcessRoll(a2.Name or "Unknown", a2.Mutation or "None")
                        elseif type(a2) == "table" and (a2.Name or a2[1]) then
                            local a3 = a2[1] or a2
                            if a3.Name then ProcessRoll(a3.Name, a3.Mutation or "None") end
                        end
                    end)
                end)
            end
        end
    end)

    task.spawn(function()
        local function SimulateClick(btn)
            pcall(function()
                if getconnections then
                    for _, conn in pairs(getconnections(btn.MouseButton1Click)) do conn:Fire() end
                    for _, conn in pairs(getconnections(btn.MouseButton1Down)) do conn:Fire() end
                    for _, conn in pairs(getconnections(btn.Activated)) do conn:Fire() end
                end
            end)
            pcall(function()
                if firesignal then
                    firesignal(btn.MouseButton1Click)
                    firesignal(btn.MouseButton1Down)
                    firesignal(btn.Activated)
                end
            end)
        end

        task.spawn(function()
            while task.wait(0.5) do
                if getgenv().AutoWeightX2 then
                    pcall(function()
                        for _, v in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                            if (v:IsA("ImageButton") or v:IsA("TextButton")) and v.Visible and v.AbsoluteSize.X > 0 then
                                local valid = false
                                local n = string.lower(v.Name)
                                if string.find(n, "x2") or string.find(n, "weight") then valid = true end
                                if not valid then
                                    for _, child in pairs(v:GetDescendants()) do
                                        if child:IsA("TextLabel") then
                                            local t = string.lower(child.Text)
                                            if string.find(t, "x2") or string.find(t, "weight") then valid = true break end
                                        end
                                    end
                                end
                                if valid then SimulateClick(v) end
                            end
                        end
                    end)
                end
            end
        end)

        task.spawn(function()
            while task.wait(2) do
                if getgenv().AutoWeightX2 then
                    pcall(function()
                        for _, v in pairs(workspace:GetDescendants()) do
                            if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
                                for _, btn in pairs(v:GetDescendants()) do
                                    if (btn:IsA("ImageButton") or btn:IsA("TextButton")) and btn.Visible then SimulateClick(btn) end
                                end
                            end
                            if v:IsA("ClickDetector") then
                                local p = v.Parent
                                if p then
                                    local pn = string.lower(p.Name)
                                    if string.find(pn, "x2") or string.find(pn, "weight") then
                                        pcall(function() fireclickdetector(v) end)
                                    else
                                        local hasBg = false
                                        for _, c in pairs(p:GetChildren()) do
                                            if c:IsA("BillboardGui") then hasBg = true break end
                                        end
                                        if hasBg then pcall(function() fireclickdetector(v) end) end
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end)
    end)
end

local function InitMap3()
    local KnitServices = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services")
    
    local function GetKnitServiceFunc(svcName, funcName)
        local s, r = pcall(function() return KnitServices:WaitForChild(svcName):WaitForChild("RF"):WaitForChild(funcName) end)
        return (s and r) or nil
    end

    local function EquipDummyTool()
        local char = LocalPlayer.Character
        local backpack = LocalPlayer:FindFirstChild("Backpack")
        local hum = char and char:FindFirstChild("Humanoid")
        if not char or not backpack or not hum then return end
        for _, t in pairs(char:GetChildren()) do if t:IsA("Tool") then t.Parent = backpack end end
        for _, t in pairs(backpack:GetChildren()) do
            if t:IsA("Tool") and t.Name:lower():find("dummy") then hum:EquipTool(t) break end
        end
    end

    local function UnequipDummyTool()
        local char = LocalPlayer.Character
        local backpack = LocalPlayer:FindFirstChild("Backpack")
        if char and backpack then
            for _, t in pairs(char:GetChildren()) do
                if t:IsA("Tool") and t.Name:lower():find("dummy") then t.Parent = backpack end
            end
        end
    end

    local SecCombatAuto = TabMain:AddSection({id = "⚔️ Auto Farming", en = "⚔️ Auto Farming"})
    SecCombatAuto:AddToggle({id = "Auto Attack & Proceed", en = "Auto Attack & Proceed Boss"}, function(val) getgenv().AutoAttack = val end)
    SecCombatAuto:AddToggle({id = "Auto 2x Train (+ Claim)", en = "Auto 2x Train (+ Claim)"}, function(val)
        getgenv().AutoTrain = val
        if val then
            EquipDummyTool()
            task.spawn(function() pcall(function() GetKnitServiceFunc("PlayerStateService", "StartTraining"):InvokeServer() end) end)
        else
            UnequipDummyTool()
            task.spawn(function()
                pcall(function()
                    GetKnitServiceFunc("TrainingService", "StopTrainingSession"):InvokeServer()
                    GetKnitServiceFunc("PlayerStateService", "StopTraining"):InvokeServer()
                end)
            end)
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character.Humanoid:UnequipTools()
            end
        end
    end)

    task.spawn(function()
        pcall(function()
            local spawnBonus = KnitServices:WaitForChild("TrainingService"):WaitForChild("RE"):WaitForChild("SpawnBonus")
            local claimBonus = KnitServices:WaitForChild("TrainingService"):WaitForChild("RF"):WaitForChild("ClaimBonus")
            spawnBonus.OnClientEvent:Connect(function(bonusData)
                if getgenv().AutoTrain then
                    task.spawn(function() pcall(function() task.wait(0.2) claimBonus:InvokeServer(bonusData) end) end)
                end
            end)
        end)
    end)

    local SecUpgrades = TabAuto:AddSection({id = "💸 Upgrades & Prestiges", en = "💸 Upgrades & Prestiges"})
    SecUpgrades:AddToggle({id = "Auto Collect Cash", en = "Auto Collect Cash"}, function(val) getgenv().AutoCollectCashLBR = val end)
    SecUpgrades:AddToggle({id = "Auto Upgrades All", en = "Auto Upgrades All"}, function(val) getgenv().AutoUpgradeLBR = val end)
    SecUpgrades:AddToggle({id = "Auto Rebirth", en = "Auto Rebirth"}, function(val) getgenv().AutoRebirthLBR = val end)

    task.spawn(function()
        while task.wait(0.1) do
            if getgenv().AutoAttack then
                pcall(function()
                    local atk = GetKnitServiceFunc("CombatService", "Attack")
                    local proceed = GetKnitServiceFunc("CombatService", "ProceedTransition")
                    if atk then atk:InvokeServer() end
                    if proceed then proceed:InvokeServer() end
                end)
            end
        end
    end)

    task.spawn(function()
        while task.wait(0.5) do
            if getgenv().AutoUpgradeLBR then
                pcall(function()
                    local upg = GetKnitServiceFunc("ContainerService", "UpgradeBrainrot")
                    if upg then for i = 1, 30 do upg:InvokeServer(tostring(i)) end end
                end)
            end
        end
    end)

    task.spawn(function()
        while task.wait(2) do
            if getgenv().AutoRebirthLBR then
                pcall(function()
                    local rb = GetKnitServiceFunc("RebirthService", "Rebirth")
                    if rb then rb:InvokeServer() end
                end)
            end
        end
    end)
end

if isMap1 then
    InitMap1()
elseif isMap2 then
    InitMap2()
elseif isMap3 then
    InitMap3()
else
    task.spawn(function()
        task.wait(2.5)
        CreateNotification("Peringatan Map", "Game tidak dikenali!\nHanya fitur Universal yang dimuat.", 6)
    end)
end

RunService.RenderStepped:Connect(function(dt)
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        
        if hum and root and getgenv().SpeedhackSettings.Enabled and not getgenv().FlySettings.Enabled then
            if hum.MoveDirection.Magnitude > 0 then
                local speed = getgenv().SpeedhackSettings.Speed
                if speed > 16 then
                    local boost = speed - 16
                    root.CFrame = root.CFrame + (hum.MoveDirection * boost * dt)
                end
            end
        end

        if root and getgenv().FlySettings.Enabled then
            local flyBv = root:FindFirstChild("HackFlyBV")
            local flyBg = root:FindFirstChild("HackFlyBG")
            if not flyBv then
                flyBv = Instance.new("BodyVelocity")
                flyBv.Name = "HackFlyBV"
                flyBv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                flyBv.Velocity = Vector3.new(0, 0, 0)
                flyBv.Parent = root
            end
            if not flyBg then
                flyBg = Instance.new("BodyGyro")
                flyBg.Name = "HackFlyBG"
                flyBg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                flyBg.P = 90000
                flyBg.Parent = root
            end
            
            local moveVec = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVec = moveVec + CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVec = moveVec - CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVec = moveVec - CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVec = moveVec + CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVec = moveVec + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveVec = moveVec - Vector3.new(0, 1, 0) end
            
            flyBv.Velocity = moveVec * getgenv().FlySettings.Speed
            flyBg.CFrame = CurrentCamera.CFrame
            
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
end)

LocalPlayer.Idled:Connect(function()
    if getgenv().AntiAFK then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

UpdateLanguage()
