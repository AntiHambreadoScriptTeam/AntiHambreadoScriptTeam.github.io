local Library = loadstring(game:HttpGet("https://rawz.vercel.app/skidlib.txt"))()
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = Players.LocalPlayer

local DiscordLink = "https://discord.gg/rTGF5xhe3h"

local function getroot()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then return char.HumanoidRootPart end
    local npcs = Workspace:FindFirstChild("NPCs")
    if npcs then
        local ragdolls = npcs:FindFirstChild("Ragdolls") or npcs
        local myRagdoll = ragdolls:FindFirstChild(LocalPlayer.Name)
        if myRagdoll then
            return myRagdoll:FindFirstChild("HumanoidRootPart") or myRagdoll:FindFirstChildOfClass("BasePart")
        end
    end
    return nil
end

if getgenv().imRunning then
    getgenv().imRunning = false
    task.wait(0.2)
end
getgenv().imRunning = true

local Window = Library:CreateWindow({
    Title = "AHST ITEM ASYLUM",
    Accent = Color3.fromRGB((1e2 * 2), (250 - (88 + 1)), 255 - (1954 / 1954))
})

local function BindDiscordButton()
    local parent = (gethui and gethui()) or game:GetService("CoreGui")
    local gui = parent:FindFirstChild("VaehzUI")
    if not gui then return end
    for _, obj in ipairs(gui:GetDescendants()) do
        if obj:IsA("TextLabel") and obj.Text == "discord" and obj.Parent and obj.Parent:IsA("TextButton") then
            local old = obj.Parent
            local btn = old:Clone()
            btn.Parent = old.Parent
            old:Destroy()
            btn.Activated:Connect(function()
                if setclipboard then
                    setclipboard(DiscordLink)
                elseif toclipboard then
                    toclipboard(DiscordLink)
                end
                pcall(function()
                    local request = (syn and syn.request) or http_request or request
                    if not request then return end
                    request({
                        Url = "http://127.0.0.1:6463/rpc?v=1",
                        Method = "POST",
                        Headers = { ["Content-Type"] = "application/json", Origin = "https://discord.com" },
                        Body = game:GetService("HttpService"):JSONEncode({
                            cmd = "INVITE_BROWSER",
                            args = { code = "rTGF5xhe3h" },
                            nonce = game:GetService("HttpService"):GenerateGUID(false)
                        })
                    })
                end)
                Library:Notify({ Title = "Discord", Content = "Enlace copiado: discord.gg/rTGF5xhe3h", Duration = 3 })
            end)
            break
        end
    end
end
BindDiscordButton()

local MainTab = Window:CreateTab({ Name = "Principal", Icon = "house" })
local EspTab = Window:CreateTab({ Name = "ESP", Icon = "eye" })
local MiscTab = Window:CreateTab({ Name = "Varios", Icon = "gear" })

local RoleColors = {
    murder = Color3.fromRGB(255, 60, 60),
    sheriff = Color3.fromRGB(80, 160, 255),
    watchdog = Color3.fromRGB(70, 90, 255),
    innocent = Color3.fromRGB(80, 220, 120)
}

local PlayerPalette = {
    Color3.fromRGB(255, 70, 70),
    Color3.fromRGB(80, 220, 120),
    Color3.fromRGB(255, 190, 60),
    Color3.fromRGB(170, 110, 255),
    Color3.fromRGB(255, 120, 190),
    Color3.fromRGB(255, 140, 40),
    Color3.fromRGB(80, 230, 210),
    Color3.fromRGB(240, 240, 90)
}

local RoleByLabel = {
    ["Asesino"] = "murder",
    ["Sheriff"] = "sheriff",
    ["Vigilante"] = "watchdog",
    ["Inocente"] = "innocent"
}

local Toggles = {
    RoleESP = false,
    RoleTracer = false,
    GunESP = false,
    ClueESP = false,
    NoCooldown = false,
    Fullbright = false,
    CameraLoop = false
}

local SelectedRoles = { murder = true, sheriff = true, watchdog = true, innocent = true }
local SelectedGun = false

local function ApplyEspSelection(selected)
    SelectedRoles = {}
    SelectedGun = false
    local function add(label)
        if type(label) ~= "string" then return end
        if label == "Arma" then
            SelectedGun = true
            return
        end
        local role = RoleByLabel[label]
        if role then SelectedRoles[role] = true end
    end
    if type(selected) == "string" then
        add(selected)
    elseif type(selected) == "table" then
        for key, value in pairs(selected) do
            if type(key) == "number" then
                add(value)
            elseif value then
                add(key)
            end
        end
    end
end
local OrigLighting = { fe = Lighting.FogEnd }
local defZoom = LocalPlayer.CameraMaxZoomDistance
local chatConnection = nil

local function GetPlayerRole(p)
    local role = "innocent"
    for _, c in ipairs({p.Character, p:FindFirstChildOfClass("Backpack")}) do
        if c then
            for _, v in ipairs(c:GetDescendants()) do
                if v:IsA("Tool") then
                    local n = v.Name:lower()
                    if n:find("watchdog", 1, true) then
                        role = "watchdog"
                    elseif (n:sub(1, 3) == "mu_" or n:find("murder", 1, true) or n == "knife") and role ~= "watchdog" then
                        role = "murder"
                    elseif (n == "gun" or n:find("sheriff", 1, true)) and role == "innocent" then
                        role = "sheriff"
                    end
                end
            end
        end
    end
    return role
end

local function TeamsDiffer()
    local seen
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Team then
            local color = p.TeamColor.Color
            if not seen then
                seen = color
            elseif seen ~= color then
                return true
            end
        end
    end
    return false
end

local function GetPlayerColor(p, role)
    if role ~= "innocent" then
        return RoleColors[role]
    end
    if TeamsDiffer() and p.Team then
        return p.TeamColor.Color
    end
    return PlayerPalette[(math.abs(p.UserId) % #PlayerPalette) + 1]
end

local function CreateBeam(att1, targetPart, name, color)
    if not att1 or not targetPart or not targetPart:IsA("BasePart") then return end
    local beam = targetPart:FindFirstChild(name)
    if not beam then
        beam = Instance.new("Beam")
        beam.Name = name
        beam.FaceCamera = true
        beam.Width0, beam.Width1 = 0.1, 0.1
        local att2 = targetPart:FindFirstChild(name .. "Attachment")
        if not att2 then
            att2 = Instance.new("Attachment")
            att2.Name = name .. "Attachment"
            att2.Parent = targetPart
        end
        beam.Attachment1 = att2
        beam.Parent = targetPart
    end
    beam.Attachment0 = att1
    beam.Color = ColorSequence.new(color)
end

local function ClearBeams(name)
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Beam") and obj.Name == name then obj:Destroy() end
    end
end

local function GetTargetPart(obj)
    if not obj then return nil end
    if obj:IsA("BasePart") then return obj end
    if obj:IsA("Model") then
        return obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)
    end
    return obj:FindFirstChildWhichIsA("BasePart", true)
end

local function GetTargetPosition(obj)
    if obj:IsA("BasePart") then return obj.Position end
    if obj:IsA("Model") then return obj:GetPivot().Position end
end

task.spawn(function()
    while getgenv().imRunning and task.wait(0.1) do
        local lpRoot = getroot()
        local att1 = lpRoot and lpRoot:FindFirstChild("TracerAttachment")
        if lpRoot and not att1 then
            att1 = Instance.new("Attachment")
            att1.Name = "TracerAttachment"
            att1.Parent = lpRoot
        end

        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local char = p.Character
                local hrp = char.HumanoidRootPart
                local role = GetPlayerRole(p)
                local color = GetPlayerColor(p, role)
                local highlight = char:FindFirstChild("RoleHighlight")

                if Toggles.RoleESP and SelectedRoles[role] then
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "RoleHighlight"
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.Parent = char
                    end
                    highlight.FillColor, highlight.OutlineColor = color, color
                elseif highlight then
                    highlight:Destroy()
                end

                if Toggles.RoleTracer and att1 and SelectedRoles[role] then
                    CreateBeam(att1, hrp, "RoleTracerBeam", color)
                else
                    local beam = hrp:FindFirstChild("RoleTracerBeam")
                    if beam then beam:Destroy() end
                end
            end
        end

        if Toggles.CameraLoop then
            LocalPlayer.CameraMaxZoomDistance = 999
        end

        local debris = Workspace:FindFirstChild("Debris")
        local eccense = debris and debris:FindFirstChild("Eccense")
        if eccense and att1 then
            local gunPart = GetTargetPart(eccense)
            if (Toggles.GunESP or SelectedGun) and gunPart then
                CreateBeam(att1, gunPart, "GunBeam", Color3.fromRGB(255, 255, 0))
            elseif gunPart then
                local beam = gunPart:FindFirstChild("GunBeam")
                if beam then beam:Destroy() end
            end
        elseif not Toggles.GunESP and not SelectedGun then
            ClearBeams("GunBeam")
        end

        local area = Workspace:FindFirstChild("Area")
        local map = area and area:GetChildren()[1]
        if map then
            local cluesFolder = map:FindFirstChild("CluesFolder")
            if cluesFolder then
                for _, highlight in ipairs(cluesFolder:GetDescendants()) do
                    if highlight:IsA("Highlight") then
                        local target = highlight.Parent
                        local targetPart = GetTargetPart(target)
                        local prox = target:IsA("BasePart") and target:FindFirstChildOfClass("ProximityPrompt")
                        if Toggles.ClueESP and att1 and targetPart then
                            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            CreateBeam(att1, targetPart, "ClueTrackingBeam", Color3.fromRGB(255, 0, 255))
                        else
                            if targetPart then
                                local beam = targetPart:FindFirstChild("ClueTrackingBeam")
                                if beam then beam:Destroy() end
                            end
                            highlight.DepthMode = Enum.HighlightDepthMode.Occluded
                        end
                    end
                end
            end
        end

        if Toggles.NoCooldown then
            for _, prox in ipairs(Workspace:GetDescendants()) do
                if prox:IsA("ProximityPrompt") then prox.HoldDuration = 0 end
            end
        end
    end

    ClearBeams("RoleTracerBeam")
    ClearBeams("ClueTrackingBeam")
    ClearBeams("GunBeam")

    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj.Name == "RoleHighlight" then obj:Destroy() end
    end
end)

MainTab:CreateLabel("Funciones")

MainTab:CreateButton({
    Name = "Recoger arma",
    Callback = function()
        local debris = Workspace:FindFirstChild("Debris")
        local eccense = debris and debris:FindFirstChild("Eccense")
        local hrp = getroot()
        if eccense and hrp then
                eccense.CFrame = hrp.CFrame
            end
        end
})

MainTab:CreateButton({
    Name = "TP a la pista más cercana",
    Callback = function()
        local root = getroot()
        if not root then return end

        local target, dist = nil, math.huge
        local area = Workspace:FindFirstChild("Area")
        local map = area and area:GetChildren()[1]

        if map and map:FindFirstChild("CluesFolder") then
            for _, v in ipairs(map.CluesFolder:GetDescendants()) do
                if v:IsA("Highlight") and v.Parent then
                    local pos = GetTargetPosition(v.Parent)
                    if pos then
                        local d = (pos - root.Position).Magnitude
                        if d < dist then
                            target, dist = v.Parent, d
                        end
                    end
                end
            end
        end

        if target then
            if target:IsA("BasePart") then
                root.CFrame = target.CFrame + Vector3.new(0,2,1)
            elseif target:IsA("Model") then
                root.CFrame = target:GetPivot() + Vector3.new(0,2,1)
            end
        end
    end
})

MainTab:CreateToggle({
    Name = "Sin espera en interacciones",
    Default = false,
    Callback = function(state)
        Toggles.NoCooldown = state
    end
})

EspTab:CreateLabel("ESP de jugadores")

EspTab:CreateToggle({
    Name = "ESP de roles",
    Default = false,
    Callback = function(state)
        Toggles.RoleESP = state
        if not state then
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj.Name == "RoleHighlight" then obj:Destroy() end
            end
        end
    end
})

EspTab:CreateToggle({
    Name = "Rastreador de roles",
    Default = false,
    Callback = function(state)
        Toggles.RoleTracer = state
        if not state then ClearBeams("RoleTracerBeam") end
    end
})

EspTab:CreateDropdown({
    Name = "Selector de ESP",
    Options = {"Asesino", "Sheriff", "Vigilante", "Inocente", "Arma"},
    Multi = true,
    Callback = function(selected)
        ApplyEspSelection(selected)
        if not SelectedGun and not Toggles.GunESP then ClearBeams("GunBeam") end
        if not Toggles.RoleTracer then return end
        if not next(SelectedRoles) then ClearBeams("RoleTracerBeam") end
    end
})

EspTab:CreateLabel("ESP de objetos")

EspTab:CreateToggle({
    Name = "ESP del arma",
    Default = false,
    Callback = function(state)
        Toggles.GunESP = state
        if not state then ClearBeams("GunBeam") end
    end
})

EspTab:CreateToggle({
    Name = "ESP de pistas",
    Default = false,
    Callback = function(state)
        Toggles.ClueESP = state
        if not state then
            ClearBeams("ClueTrackingBeam")
            local area = Workspace:FindFirstChild("Area")
            local map = area and area:GetChildren()[1]
            local cluesFolder = map and map:FindFirstChild("CluesFolder")
            if cluesFolder then
                for _, highlight in ipairs(cluesFolder:GetDescendants()) do
                    if highlight:IsA("Highlight") then
                        highlight.DepthMode = Enum.HighlightDepthMode.Occluded
                    end
                end
            end
        end
    end
})

MiscTab:CreateButton({
    Name = "Sin niebla",
    Callback = function()
        Lighting.FogEnd = 999999
    end
})

MiscTab:CreateToggle({
    Name = "Desbloquear zoom de cámara",
    Default = false,
    Callback = function(state)
        Toggles.CameraLoop = state
        if not state then
            LocalPlayer.CameraMaxZoomDistance = defZoom
        end
    end
})

MiscTab:CreateToggle({
    Name = "Mostrar chat",
    Default = false,
    Callback = function(state)
        if state then
            TextChatService.ChatWindowConfiguration.Enabled = true
            if chatConnection then chatConnection:Disconnect() end
            chatConnection = TextChatService.ChatWindowConfiguration.Changed:Connect(function()
                if not TextChatService.ChatWindowConfiguration.Enabled then
                    TextChatService.ChatWindowConfiguration.Enabled = true
                end
            end)
        else
            if chatConnection then
                chatConnection:Disconnect()
                chatConnection = nil
            end
            TextChatService.ChatWindowConfiguration.Enabled = false
        end
    end
})

MiscTab:CreateLabel("Discord: " .. DiscordLink)

MiscTab:CreateButton({
    Name = "Copiar Discord",
    Callback = function()
        if setclipboard then
            setclipboard(DiscordLink)
        elseif toclipboard then
            toclipboard(DiscordLink)
        end
        Library:Notify({Title = "AHST ITEM ASYLUM", Content = "Enlace copiado: discord.gg/rTGF5xhe3h", Duration = 4})
    end
})

Library:Notify({Title = "AHST ITEM ASYLUM", Content = "Cargado correctamente", Duration = 4})
