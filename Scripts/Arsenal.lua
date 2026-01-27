local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ESPEnabled = true
local Rainbow = true
local TeamCheck = true
local AimbotEnabled = false
local IsArsenal = game.PlaceId == 286090429
local AimFOV = 250
local AimSpeed = 0.12

local ESPHighlights = {}
local ESPBillboards = {}

local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "FeliciaLoading"
LoadingGui.ResetOnSpawn = false
LoadingGui.IgnoreGuiInset = true
LoadingGui.Parent = PlayerGui

local Background = Instance.new("Frame", LoadingGui)
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.new(0, 0, 0)
Background.BorderSizePixel = 0

local CenterFrame = Instance.new("Frame", Background)
CenterFrame.Size = UDim2.new(0, 400, 0, 300)
CenterFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
CenterFrame.BackgroundTransparency = 1

local MainTitle = Instance.new("TextLabel", CenterFrame)
MainTitle.Size = UDim2.new(1, 0, 0, 80)
MainTitle.Position = UDim2.new(0, 0, 0.3, 0)
MainTitle.BackgroundTransparency = 1
MainTitle.Text = "FeliciaXxxTop"
MainTitle.TextColor3 = Color3.new(1, 1, 1)
MainTitle.Font = Enum.Font.GothamBlack
MainTitle.TextScaled = true

local TitleGradient = Instance.new("UIGradient", MainTitle)
TitleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 20, 147)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 182, 193)),
    ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
}
TitleGradient.Rotation = 45

local BlurEffect = Instance.new("BlurEffect", game.Lighting)
BlurEffect.Size = 24

local ProgressContainer = Instance.new("Frame", CenterFrame)
ProgressContainer.Size = UDim2.new(0.8, 0, 0, 6)
ProgressContainer.Position = UDim2.new(0.1, 0, 0.65, 0)
ProgressContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ProgressContainer.BorderSizePixel = 0
Instance.new("UICorner", ProgressContainer).CornerRadius = UDim.new(1, 0)

local ProgressBar = Instance.new("Frame", ProgressContainer)
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
ProgressBar.BorderSizePixel = 0
Instance.new("UICorner", ProgressBar).CornerRadius = UDim.new(1, 0)

local ProgressBarGradient = Instance.new("UIGradient", ProgressBar)
ProgressBarGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 20, 147)),
    ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
}

local LoadingText = Instance.new("TextLabel", CenterFrame)
LoadingText.Size = UDim2.new(1, 0, 0, 20)
LoadingText.Position = UDim2.new(0, 0, 0.7, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "Loading..."
LoadingText.TextColor3 = Color3.fromRGB(200, 200, 200)
LoadingText.Font = Enum.Font.Gotham
LoadingText.TextSize = 14

local loadingDone = false
task.spawn(function()
    TweenService:Create(MainTitle, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true), {TextTransparency = 0.2}):Play()
    
    local duration = 3.5
    local start = tick()
    while tick() - start < duration do
        local p = math.clamp((tick() - start) / duration, 0, 1)
        TweenService:Create(ProgressBar, TweenInfo.new(0.1), {Size = UDim2.new(p, 0, 1, 0)}):Play()
        LoadingText.Text = "Loading Assets... " .. math.floor(p * 100) .. "%"
        task.wait(0.02)
    end
    
    ProgressBar.Size = UDim2.new(1, 0, 1, 0)
    LoadingText.Text = "Welcome"
    task.wait(0.5)
    
    local fadeOutInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(Background, fadeOutInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(MainTitle, fadeOutInfo, {TextTransparency = 1}):Play()
    TweenService:Create(ProgressContainer, fadeOutInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(ProgressBar, fadeOutInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(LoadingText, fadeOutInfo, {TextTransparency = 1}):Play()
    TweenService:Create(BlurEffect, fadeOutInfo, {Size = 0}):Play()
    
    task.wait(0.8)
    LoadingGui:Destroy()
    BlurEffect:Destroy()
    loadingDone = true
end)

repeat task.wait() until loadingDone

local HubGui = Instance.new("ScreenGui")
HubGui.Name = "FeliciaHub"
HubGui.ResetOnSpawn = false
HubGui.Parent = PlayerGui

local HubFrame = Instance.new("Frame", HubGui)
HubFrame.Size = UDim2.new(0, 260, 0, 400)
HubFrame.Position = UDim2.new(0.02, 0, 0.3, 0)
HubFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
HubFrame.BorderSizePixel = 0
Instance.new("UICorner", HubFrame).CornerRadius = UDim.new(0, 12)

local HubStroke = Instance.new("UIStroke", HubFrame)
HubStroke.Thickness = 2
HubStroke.Color = Color3.fromRGB(50, 50, 50)

local HubGradient = Instance.new("UIGradient", HubStroke)
HubGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 20, 147)),
    ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
}
HubGradient.Rotation = 90

local TitleBar = Instance.new("Frame", HubFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

local TitleSep = Instance.new("Frame", TitleBar)
TitleSep.Size = UDim2.new(1, 0, 0, 1)
TitleSep.Position = UDim2.new(0, 0, 1, -1)
TitleSep.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
TitleSep.BorderSizePixel = 0

local TitleLabel = Instance.new("TextLabel", TitleBar)
TitleLabel.Size = UDim2.new(1, -20, 1, -5)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "FeliciaXxxTop | Arsenal"
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBlack

local TitleTextGradient = Instance.new("UIGradient", TitleLabel)
TitleTextGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 105, 180)),
    ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
}

local dragging, dragInput, mousePos, framePos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        mousePos = input.Position
        framePos = HubFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        HubFrame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
    end
end)

local function createToggleButton(textBase, valueGetterSetter, posY)
    local btn = Instance.new("TextButton")
    btn.Parent = HubFrame
    btn.Size = UDim2.new(0, 220, 0, 45)
    btn.Position = UDim2.new(0, 20, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Thickness = 1
    btnStroke.Color = Color3.fromRGB(60, 60, 60)
    btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local function updateText()
        local isOn = valueGetterSetter()
        btn.Text = textBase .. (isOn and "ON" or "OFF")
        if isOn then
            btn.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
            btn.TextColor3 = Color3.new(1,1,1)
            btnStroke.Color = Color3.fromRGB(255, 105, 180)
        else
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            btn.TextColor3 = Color3.fromRGB(200, 200, 200)
            btnStroke.Color = Color3.fromRGB(60, 60, 60)
        end
    end
    updateText()

    btn.MouseEnter:Connect(function() 
        if not valueGetterSetter() then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
        end
    end)
    btn.MouseLeave:Connect(function() 
        if not valueGetterSetter() then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
        end
    end)

    btn.MouseButton1Click:Connect(function()
        local current = valueGetterSetter()
        valueGetterSetter(not current)
        updateText()
    end)

    return btn
end

createToggleButton("ESP: ", function(v) if v~=nil then ESPEnabled = v end return ESPEnabled end, 70)
createToggleButton("Rainbow: ", function(v) if v~=nil then Rainbow = v end return Rainbow end, 130)
createToggleButton("Team Check: ", function(v) if v~=nil then TeamCheck = v end return TeamCheck end, 190)
createToggleButton("Aimbot: ", function(v) if v~=nil then AimbotEnabled = v end return AimbotEnabled end, 250)

local function createESP(player)
    if player == LocalPlayer then return end
    local char = player.Character
    if not char or char:FindFirstChild("ESP_HIGHLIGHT") then return end

    if TeamCheck and IsArsenal and player.TeamColor == LocalPlayer.TeamColor then return end

    local hl = Instance.new("Highlight")
    hl.Name = "ESP_HIGHLIGHT"
    hl.FillTransparency = 0.5
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = char
    ESPHighlights[player] = hl

    local head = char:FindFirstChild("Head")
    if head then
        local bb = Instance.new("BillboardGui")
        bb.Name = "ESP_NAME"
        bb.Size = UDim2.new(0, 220, 0, 45)
        bb.StudsOffset = Vector3.new(0, 2.5, 0)
        bb.AlwaysOnTop = true
        bb.Adornee = head
        bb.Parent = char

        local txt = Instance.new("TextLabel", bb)
        txt.Size = UDim2.new(1,0,1,0)
        txt.BackgroundTransparency = 1
        txt.TextStrokeTransparency = 0
        txt.TextStrokeColor3 = Color3.new(0,0,0)
        txt.TextScaled = true
        txt.Font = Enum.Font.GothamBold
        txt.TextColor3 = Color3.new(1,1,1)
        ESPBillboards[player] = {text = txt, char = char}
    end
end

local function removeESP(player)
    if ESPHighlights[player] then
        ESPHighlights[player]:Destroy()
        ESPHighlights[player] = nil
    end
    if ESPBillboards[player] then
        if ESPBillboards[player].text.Parent then
            ESPBillboards[player].text.Parent:Destroy()
        end
        ESPBillboards[player] = nil
    end
end

local function refreshAllESP()
    if not ESPEnabled then return end
    for _, player in Players:GetPlayers() do
        if player ~= LocalPlayer and player.Character then
            createESP(player)
        end
    end
end

for _, player in Players:GetPlayers() do
    if player.Character then createESP(player) end
    player.CharacterAdded:Connect(createESP)
    player.CharacterRemoving:Connect(function() removeESP(player) end)
end
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(createESP)
    player.CharacterRemoving:Connect(function() removeESP(player) end)
end)

RunService.RenderStepped:Connect(function()
    if ESPEnabled then
        for player, hl in pairs(ESPHighlights) do
            if not hl.Parent then
                ESPHighlights[player] = nil
                continue
            end
            hl.Enabled = true

            local data = ESPBillboards[player]
            if data then
                local hrp = data.char:FindFirstChild("HumanoidRootPart")
                local myhrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp and myhrp then
                    local dist = math.floor((myhrp.Position - hrp.Position).Magnitude)
                    data.text.Text = player.Name .. "\n[" .. dist .. "m]"
                end

                local col = Rainbow and Color3.fromHSV((tick() % 5)/5, 1, 1) or Color3.fromRGB(255, 105, 180)
                hl.FillColor = col
                hl.OutlineColor = Color3.new(1,1,1)
                data.text.TextColor3 = col
            end
        end
    else
        for _, hl in pairs(ESPHighlights) do
            hl.Enabled = false
        end
    end

    if AimbotEnabled then
        local cam = Workspace.CurrentCamera
        local center = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
        local target, minDist = nil, AimFOV

        for _, p in Players:GetPlayers() do
            if p == LocalPlayer or not p.Character then continue end
            if TeamCheck and IsArsenal and p.TeamColor == LocalPlayer.TeamColor then continue end

            local head = p.Character:FindFirstChild("Head")
            if not head then continue end

            local pos, onScreen = cam:WorldToViewportPoint(head.Position)
            if not onScreen then continue end

            local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
            if dist < minDist then
                minDist = dist
                target = head
            end
        end

        if target then
            local targetCF = CFrame.lookAt(cam.CFrame.Position, target.Position)
            cam.CFrame = cam.CFrame:Lerp(targetCF, AimSpeed)
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.L then
        ESPEnabled = not ESPEnabled
        if ESPEnabled then
            refreshAllESP()
        end
    elseif input.KeyCode == Enum.KeyCode.RightShift then
        AimbotEnabled = not AimbotEnabled
    end
end)

print("FeliciaXxxTop Script loaded - ESP can now be toggled on/off multiple times")
