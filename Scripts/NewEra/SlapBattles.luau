local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local BanHammerName = "TheRealBanHammer " .. utf8.char(0xE000) .. utf8.char(0xE001)

local AhstIntro = Instance.new("ScreenGui")
AhstIntro.Name = "AhstIntro"
AhstIntro.ResetOnSpawn = false
AhstIntro.IgnoreGuiInset = true
AhstIntro.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
AhstIntro.Parent = PlayerGui

local BlackFrame = Instance.new("Frame")
BlackFrame.Size = UDim2.fromScale(1, 1)
BlackFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BlackFrame.BackgroundTransparency = 1
BlackFrame.Parent = AhstIntro

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0.6, 0, 0.2, 0)
TitleLabel.Position = UDim2.new(0.5, 0, -0.2, 0)
TitleLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "{ .•° AHST Slap °•. }"
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
TitleLabel.TextStrokeTransparency = 0.3
TitleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel.Parent = AhstIntro

local UIGradient = Instance.new("UIGradient", TitleLabel)
UIGradient.Color = ColorSequence.new({
  ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
  ColorSequenceKeypoint.new(0.5, Color3.fromRGB(60, 0, 0)),
  ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
})
UIGradient.Rotation = 45

local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Size = UDim2.new(0, 280, 0, 25)
SubtitleLabel.Position = UDim2.new(0.5, 0, 0.58, 0)
SubtitleLabel.AnchorPoint = Vector2.new(0.5, 0.5)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Text = "by " .. BanHammerName
SubtitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SubtitleLabel.TextTransparency = 1
SubtitleLabel.TextScaled = true
SubtitleLabel.Font = Enum.Font.Gotham
SubtitleLabel.Parent = AhstIntro

local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0, 0, 0.02, 0)
ProgressBar.Position = UDim2.new(0.5, 0, 0.85, 0)
ProgressBar.AnchorPoint = Vector2.new(0.5, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = AhstIntro

local function PlayTween(instance, info, properties)
  return TweenService:Create(instance, info, properties)
end

PlayTween(BlackFrame, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
task.wait(0.6)
PlayTween(TitleLabel, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.4, 0)}):Play()
task.wait(1)
PlayTween(TitleLabel, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextSize = TitleLabel.TextSize * 1.05}):Play()
PlayTween(SubtitleLabel, TweenInfo.new(1), {TextTransparency = 0}):Play()
task.wait(1.2)

task.spawn(function()
  while SubtitleLabel and SubtitleLabel.Parent do
    PlayTween(SubtitleLabel, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0.5}):Play()
    task.wait(1.2)
    PlayTween(SubtitleLabel, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0}):Play()
    task.wait(1.2)
  end
end)

PlayTween(ProgressBar, TweenInfo.new(2, Enum.EasingStyle.Linear), {Size = UDim2.new(0.8, 0, 0.02, 0)}):Play()

local IntroSound = Instance.new("Sound")
IntroSound.SoundId = "rbxassetid://107004225739474"
IntroSound.Volume = 2
IntroSound.Parent = AhstIntro
IntroSound.PlayOnRemove = false
IntroSound:Play()

task.wait(2.5)
PlayTween(BlackFrame, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
PlayTween(TitleLabel, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
PlayTween(SubtitleLabel, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
PlayTween(ProgressBar, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
task.wait(1)
AhstIntro:Destroy()

local NotifyGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("NotifyGui") or Instance.new("ScreenGui")
NotifyGui.Name = "NotifyGui"
NotifyGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
NotifyGui.ResetOnSpawn = false

local NotifFolder = NotifyGui:FindFirstChild("NotifFolder") or Instance.new("Folder")
NotifFolder.Name = "NotifFolder"
NotifFolder.Parent = NotifyGui

local MAX_NOTIFS = 3
local NOTIF_WIDTH = 340
local NOTIF_HEIGHT = 90
local NOTIF_SPACING = 10
local NOTIF_POS_START = UDim2.new(1, -360, 1, -100)

function Notify(iconId, message, duration)
  duration = duration or 3
  iconId = iconId or 6031075932
  message = message or "Notificación"

  for _, notif in ipairs(NotifFolder:GetChildren()) do
    if notif:IsA("Frame") then
      TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -360, 1, notif.Position.Y.Offset - NOTIF_HEIGHT + NOTIF_SPACING),
      }):Play()
    end
  end

  if MAX_NOTIFS <= #NotifFolder:GetChildren() then
    local firstNotif = NotifFolder:GetChildren()[1]
    if firstNotif then
      firstNotif:Destroy()
    end
  end

  local notifFrame = Instance.new("Frame")
  notifFrame.Size = UDim2.new(0, NOTIF_WIDTH, 0, NOTIF_HEIGHT)
  notifFrame.Position = UDim2.new(1, 360, 1, -100)
  notifFrame.AnchorPoint = Vector2.new(0, 1)
  notifFrame.BackgroundTransparency = 0
  notifFrame.BorderSizePixel = 0
  notifFrame.Parent = NotifFolder
  notifFrame.ZIndex = 10

  local gradient = Instance.new("UIGradient", notifFrame)
  gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 15)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 0, 0))
  })

  Instance.new("UICorner", notifFrame).CornerRadius = UDim.new(0, 12)
  local stroke = Instance.new("UIStroke", notifFrame)
  stroke.Thickness = 2
  stroke.Color = Color3.fromRGB(255, 0, 70)
  stroke.Transparency = 0.1

  local icon = Instance.new("ImageLabel", notifFrame)
  icon.Size = UDim2.new(0, 70, 0, 70)
  icon.Position = UDim2.new(0, 10, 0.5, -35)
  icon.BackgroundTransparency = 1
  icon.Image = "rbxassetid://" .. tostring(iconId)
  icon.ZIndex = 11

  local text = Instance.new("TextLabel", notifFrame)
  text.Size = UDim2.new(1, -90, 1, -20)
  text.Position = UDim2.new(0, 90, 0, 5)
  text.BackgroundTransparency = 1
  text.Text = message
  text.TextColor3 = Color3.fromRGB(255, 255, 255)
  text.TextSize = 19
  text.Font = Enum.Font.GothamBold
  text.TextWrapped = true
  text.TextXAlignment = Enum.TextXAlignment.Left
  text.ZIndex = 11

  local footer = Instance.new("TextLabel", notifFrame)
  footer.Size = UDim2.new(0, 120, 0, 18)
  footer.Position = UDim2.new(1, -125, 1, -20)
  footer.BackgroundTransparency = 1
  footer.Text = "AHST Slap"
  footer.TextColor3 = Color3.fromRGB(255, 0, 70)
  footer.TextSize = 14
  footer.Font = Enum.Font.GothamSemibold
  footer.TextXAlignment = Enum.TextXAlignment.Right
  footer.ZIndex = 12

  TweenService:Create(notifFrame, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = NOTIF_POS_START}):Play()

  local sound = Instance.new("Sound", notifFrame)
  sound.SoundId = "rbxassetid://8486683243"
  sound.Volume = 1
  sound:Play()

  task.delay(duration, function()
    TweenService:Create(notifFrame, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
      Position = UDim2.new(1, 360, 1, notifFrame.Position.Y.Offset),
    }):Play()
    task.wait(0.45)
    notifFrame:Destroy()
  end)
end

Notify(10734966248, "Bienvenido a AHST Slap", 5)

local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Cat558-uz/Testaaa/refs/heads/main/LibTeste.txt"))()
local Window = Lib:MakeWindow({
  Title = "AHST Slap : Slap Battles",
  SubTitle = "by " .. BanHammerName,
  SaveFolder = "AHST Slap.lua",
})

Window:AddMinimizeButton({
  Button = {
    Image = "rbxassetid://10734966248",
    BackgroundTransparency = 7,
  },
  Corner = {
    CornerRadius = UDim.new(0, 8),
  },
})

local HomeTab = Window:MakeTab({"| Inicio : Perfil", "menu"})
local CombatTab = Window:MakeTab({"| Slap : Combate/Aura", "User"})
local MovementTab = Window:MakeTab({"| Movimiento : Farm", "navigation"})
local EspTab = Window:MakeTab({"| ESP : Jugadores", "Box"})
local TycoonTab = Window:MakeTab({"| Auto click : Tycoon", "Sword"})
local FarmTab = Window:MakeTab({"| Farm : Métodos", "Script"})
local ProtecTab = Window:MakeTab({"| Protección : Ragdoll", "Shield"})

HomeTab:AddParagraph({"Ejecutor", (typeof(identifyexecutor) == "function" and identifyexecutor()) or (typeof(getexecutorname) == "function" and getexecutorname()) or "Desconocido"})
HomeTab:AddParagraph({"Apodo", LocalPlayer.Name})
HomeTab:AddParagraph({"Versión", "v1.0"})

local ServerSection = HomeTab:AddSection({" Servidor"})
HomeTab:AddButton({
  Name = "Volver a unirse al servidor",
  Callback = function()
    Notify(10709806740, "Esperando para volver a unirse", 3)
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
  end,
})

HomeTab:AddButton({
  Name = "Copiar Discord (AHST Slap)",
  Callback = function()
    local url = "https://discord.gg/rTGF5xhe3h"
    if setclipboard then
      setclipboard(url)
      Notify(10734966248, "Enlace copiado al portapapeles", 3)
    else
      print("El ejecutor no puede copiar. Enlace: " .. url)
      Notify(10734966248, "El ejecutor no puede copiar al portapapeles.", 3)
    end
  end,
})

HomeTab:AddButton({
  Name = "Abrir consola",
  Callback = function()
    print("Abriste la consola, [" .. LocalPlayer.Name .. "]")
    pcall(function()
      StarterGui:SetCore("DevConsoleVisible", true)
    end)
  end,
})

local autoWalkEnabled = false
local autoWalkConn = nil
local nextWalkUpdate = 0
local walkSpeed = 40
local detectionRadius = 200
local safeGroundDistance = 35
local minChangeTime = 0.15
local maxChangeTime = 0.35
local safeBounds = 115
local edgeIgnoreRadius = 95
local pullThreshold = 85
local emergencyThreshold = 95
local currentTargetPlayer = nil
local targetLockUntil = 0

local autoSlapEnabled = false
local autoSlapRange = 18
local autoSlapDelay = 0.28
local lastAutoSlap = 0

local function distFromCenter(pos)
  return math.sqrt(pos.X^2 + pos.Z^2)
end

local function isSafe(pos)
  local ok, result = pcall(function()
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Exclude
    rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
    local origin = pos + Vector3.new(0, 5, 0)
    local direction = Vector3.new(0, -safeGroundDistance, 0)
    return workspace:Raycast(origin, direction, rayParams)
  end)
  if not ok then
    return true
  end
  return result ~= nil
end

local function getHitPart(character, preferred)
  if not character then return nil end
  local order = {}
  if preferred then
    for _, name in ipairs(preferred) do
      table.insert(order, name)
    end
  end
  local fallback = {
    "Right Arm", "RightHand", "RightLowerArm", "RightUpperArm",
    "Left Arm", "LeftHand", "LeftLowerArm", "LeftUpperArm",
    "Right Leg", "RightFoot", "RightLowerLeg", "RightUpperLeg",
    "Left Leg", "LeftFoot", "LeftLowerLeg", "LeftUpperLeg",
    "Torso", "UpperTorso", "HumanoidRootPart",
  }
  for _, name in ipairs(fallback) do
    table.insert(order, name)
  end
  for _, name in ipairs(order) do
    local part = character:FindFirstChild(name)
    if part and part:IsA("BasePart") then
      return part
    end
  end
  return character:FindFirstChildWhichIsA("BasePart")
end

local function equipGlove()
  local char = LocalPlayer.Character
  if not char then return nil end
  local tool = char:FindFirstChildOfClass("Tool")
  if tool then return tool end
  local backpack = LocalPlayer:FindFirstChild("Backpack")
  tool = backpack and backpack:FindFirstChildOfClass("Tool")
  if not tool then return nil end
  tool.Parent = char
  return tool
end

local function GetClosestPlayer()
  local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  if not hrp then return nil end
  local closest = nil
  local dist = math.huge
  for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer and plr.Character then
      local thrp = plr.Character:FindFirstChild("HumanoidRootPart")
      local hum = plr.Character:FindFirstChildOfClass("Humanoid")
      if thrp and hum and hum.Health > 0 then
        local d = (thrp.Position - hrp.Position).Magnitude
        if d < dist then
          dist = d
          closest = plr
        end
      end
    end
  end
  return closest
end

local function faceTarget(hrp, worldPos)
  local look = Vector3.new(worldPos.X, hrp.Position.Y, worldPos.Z)
  if (look - hrp.Position).Magnitude < 0.05 then return end
  hrp.CFrame = CFrame.new(hrp.Position, look)
end

local function trySlap(target)
  if tick() - lastAutoSlap < autoSlapDelay then return false end
  local char = LocalPlayer.Character
  local hrp = char and char:FindFirstChild("HumanoidRootPart")
  if not hrp or not target or not target.Character then return false end
  local hit = getHitPart(target.Character)
  if not hit then return false end
  if (hrp.Position - hit.Position).Magnitude > autoSlapRange then return false end

  faceTarget(hrp, hit.Position)
  local tool = equipGlove()
  if tool then
    pcall(function()
      tool:Activate()
    end)
  end

  local remote = ReplicatedStorage:FindFirstChild("GeneralHit")
  if remote and remote:IsA("RemoteEvent") then
    pcall(function()
      remote:FireServer(hit)
    end)
  end

  lastAutoSlap = tick()
  return true
end

local function getTargetPosition()
  local now = tick()
  local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  if not hrp then return nil end

  if distFromCenter(hrp.Position) > emergencyThreshold then
    return Vector3.new(0, hrp.Position.Y, 0)
  end

  local target
  if currentTargetPlayer and currentTargetPlayer.Parent and currentTargetPlayer.Character and currentTargetPlayer.Character:FindFirstChild("HumanoidRootPart") and now < targetLockUntil then
    local pos = currentTargetPlayer.Character.HumanoidRootPart.Position
    if distFromCenter(pos) <= edgeIgnoreRadius then
      target = pos + Vector3.new(math.random(-4, 4), 0, math.random(-4, 4))
    else
      currentTargetPlayer = nil
      targetLockUntil = 0
    end
  end

  if not target then
    local minDist = math.huge
    local closestPlr = nil
    for _, plr in ipairs(Players:GetPlayers()) do
      if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        local hum = plr.Character:FindFirstChildOfClass("Humanoid")
        local plrPos = plr.Character.HumanoidRootPart.Position
        if hum and hum.Health > 0 and distFromCenter(plrPos) <= edgeIgnoreRadius then
          local dist = (hrp.Position - plrPos).Magnitude
          if dist < minDist and dist <= detectionRadius then
            minDist = dist
            closestPlr = plr
          end
        end
      end
    end

    if closestPlr then
      currentTargetPlayer = closestPlr
      targetLockUntil = now + 1.2
      local pos = closestPlr.Character.HumanoidRootPart.Position
      target = pos
    else
      currentTargetPlayer = nil
      targetLockUntil = 0
      local angle = math.rad(math.random(360))
      local distance = 12 + math.random() * 15
      target = hrp.Position + Vector3.new(math.cos(angle) * distance, 0, math.sin(angle) * distance)
    end
  end

  if distFromCenter(hrp.Position) > pullThreshold and hrp.Position.Magnitude > 0.01 then
    local flat = Vector3.new(hrp.Position.X, 0, hrp.Position.Z)
    if flat.Magnitude > 0.01 then
      target = target - (flat.Unit * 30)
    end
  end

  return Vector3.new(target.X, hrp.Position.Y, target.Z)
end

local function stepToward(hrp, hum, goal)
  local offset = Vector3.new(goal.X - hrp.Position.X, 0, goal.Z - hrp.Position.Z)
  local dist = offset.Magnitude
  if dist < 1 then return end
  hum:MoveTo(goal)
  if hrp.AssemblyLinearVelocity.Magnitude < 3 then
    local step = math.min(7, dist)
    local nextPos = hrp.Position + (offset.Unit * step)
    hrp.CFrame = CFrame.new(nextPos.X, hrp.Position.Y, nextPos.Z)
  end
end

local function autoWalkLoop()
  if not autoWalkEnabled then
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 16 end
    if autoWalkConn then autoWalkConn:Disconnect(); autoWalkConn = nil end
    return
  end

  local char = LocalPlayer.Character
  local hum = char and char:FindFirstChildOfClass("Humanoid")
  local hrp = char and char:FindFirstChild("HumanoidRootPart")
  if not char or not hrp or not hum or hum.Health <= 0 then
    return
  end

  hum.PlatformStand = false
  hum.Sit = false
  hum.WalkSpeed = walkSpeed

  local nearest = GetClosestPlayer()
  if nearest then
    trySlap(nearest)
  end

  if tick() >= nextWalkUpdate then
    local target = getTargetPosition()
    if not target then return end

    local safeTarget = target
    local attempts = 0
    while not isSafe(safeTarget) and attempts < 20 do
      safeTarget = target + Vector3.new(math.random(-12, 12), 0, math.random(-12, 12))
      attempts = attempts + 1
    end

    if not isSafe(safeTarget) then
      safeTarget = target
    end

    safeTarget = Vector3.new(math.clamp(safeTarget.X, -safeBounds, safeBounds), hrp.Position.Y, math.clamp(safeTarget.Z, -safeBounds, safeBounds))
    stepToward(hrp, hum, safeTarget)
    nextWalkUpdate = tick() + (minChangeTime + math.random() * (maxChangeTime - minChangeTime))
  end
end

RunService.Heartbeat:Connect(function()
  if not autoSlapEnabled then return end
  pcall(function()
    trySlap(GetClosestPlayer())
  end)
end)

local showAuraAnim = false
local auraParts = {}
local auraAnimConn = nil

local function toggleAuraAnim(enable)
  showAuraAnim = enable
  if enable then
    if not auraAnimConn then
      local segments = 64
      local thickness = 0.5
      local animationSpeed = 2
      local maxRadius = detectionRadius

      for i = 1, segments do
        local part = Instance.new("Part")
        part.Size = Vector3.new(thickness, thickness, 0)
        part.Transparency = 0.3
        part.Color = Color3.fromRGB(255, 165, 0)
        part.Material = Enum.Material.Neon
        part.CanCollide = false
        part.Anchored = true
        part.Parent = workspace
        table.insert(auraParts, part)
      end

      local animTime = 0
      auraAnimConn = RunService.Heartbeat:Connect(function(dt)
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        animTime = animTime + dt
        local progress = (animTime % animationSpeed) / animationSpeed
        local currentRadius = maxRadius * progress

        if currentRadius < 1 then
          for _, p in ipairs(auraParts) do p.Transparency = 1 end
          return
        end

        for i, part in ipairs(auraParts) do
          local angle = (i - 1) / segments * math.pi * 2
          local nextAngle = i / segments * math.pi * 2
          local midAngle = (angle + nextAngle) / 2
          local tangentAngle = midAngle + math.pi/2
          local arcLength = (currentRadius * math.pi * 2) / segments * 1.05
          local pos = Vector3.new(math.cos(midAngle) * currentRadius, 0, math.sin(midAngle) * currentRadius)
          part.Size = Vector3.new(thickness, thickness, arcLength)
          part.CFrame = CFrame.new(hrp.Position + pos) * CFrame.Angles(0, tangentAngle, 0)
          part.Transparency = 0.3
        end
      end)
    end
  else
    if auraAnimConn then auraAnimConn:Disconnect(); auraAnimConn = nil end
    for _, p in ipairs(auraParts) do if p and p.Parent then p:Destroy() end end
    auraParts = {}
  end
end

MovementTab:AddToggle({
  Name = "Farm: caminar y slap automático",
  Default = false,
  Callback = function(v)
    autoWalkEnabled = v
    if v then
      nextWalkUpdate = tick()
      if not autoWalkConn then
        autoWalkConn = RunService.Heartbeat:Connect(function()
          local ok, err = pcall(autoWalkLoop)
          if not ok then
            warn("Farm caminar: " .. tostring(err))
          end
        end)
      end
    else
      if autoWalkConn then autoWalkConn:Disconnect(); autoWalkConn = nil end
      local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
      if hum then hum.WalkSpeed = 16 end
    end
  end
})

MovementTab:AddSlider({
  Name = "Alcance del auto slap",
  Min = 5, Max = 40, Increase = 1, Default = 18,
  Callback = function(v) autoSlapRange = v end
})

MovementTab:AddToggle({
  Name = "Animación de aura (círculo naranja)",
  Default = false,
  Callback = function(v)
    toggleAuraAnim(v)
  end
})

MovementTab:AddButton({
  Name = "TP a la isla",
  Callback = function()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = CFrame.new(-7.40, -5.17, 2.60) end
  end
})

local FloatSection = MovementTab:AddSection({" Ajustes de flotar"})
local floatActive = false
local floatParts = {}
local function CreatePlatform(offset)
  local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  if not hrp then return nil end
  local p = Instance.new("Part")
  p.Anchored = true
  p.CanCollide = true
  p.Transparency = 1
  p.Size = Vector3.new(6, 1, 6)
  p.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y - offset, hrp.Position.Z)
  p.Parent = workspace
  return p
end

task.spawn(function()
  while task.wait(0.05) do
    if floatActive then
      local p = CreatePlatform(3)
      if p then
        table.insert(floatParts, p)
        task.delay(0.5, function() if p and p.Parent then p:Destroy() end end)
      end
    end
  end
end)

UserInputService.JumpRequest:Connect(function()
end)

MovementTab:AddToggle({
  Name = "Flotar (método seguro)",
  Default = false,
  Callback = function(v)
    floatActive = v
    if not v then
      for _, p in ipairs(floatParts) do if p and p.Parent then p:Destroy() end end
      table.clear(floatParts)
    end
  end
})

local autoParryEnabled = false
local auraRadius = 12
local parryAnimation = "rbxassetid://13526154547"

local function ShowGhostHighlight(player)
  if not player.Character then return end
  if player.Character:FindFirstChild("GhostHighlight") then return end
  local highlight = Instance.new("Highlight")
  highlight.Name = "GhostHighlight"
  highlight.FillColor = Color3.fromRGB(255, 0, 0)
  highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
  highlight.FillTransparency = 0.5
  highlight.Parent = player.Character
  task.delay(1.5, function() if highlight then highlight:Destroy() end end)
end

RunService.Heartbeat:Connect(function()
  if not autoParryEnabled then return end
  local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  if not hrp then return end

  for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
      if (hrp.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= auraRadius then
        local hum = plr.Character:FindFirstChild("Humanoid")
        local animator = hum and hum:FindFirstChildOfClass("Animator")
        if animator then
          for _, track in pairs(animator:GetPlayingAnimationTracks()) do
            if track.Animation and track.Animation.AnimationId == parryAnimation then
              ReplicatedStorage:WaitForChild("Counter"):FireServer()
              ShowGhostHighlight(plr)
              break
            end
          end
        end
      end
    end
  end
end)

local CombatSection = CombatTab:AddSection({" Auto contraataque"})
CombatTab:AddToggle({
  Name = "Auto Parry Counter",
  Default = false,
  Callback = function(v) autoParryEnabled = v end
})

CombatTab:AddSlider({
  Name = "Radio del aura (studs)",
  Min = 1, Max = 50, Increase = 1, Default = 12,
  Callback = function(v) auraRadius = v end
})

CombatTab:AddButton({
  Name = "Conseguir el guante del aura",
  Callback = function()
    fireclickdetector(workspace:WaitForChild("Lobby"):WaitForChild("Counter"):WaitForChild("ClickDetector"))
  end
})

local BullSection = CombatTab:AddSection({" Aura Bull (Stone)"})
local bullAuraEnabled = false
local bullDelay = 2
local lastBullHit = 0

RunService.Heartbeat:Connect(function()
  if not bullAuraEnabled or (tick() - lastBullHit < bullDelay) then return end
  local target = GetClosestPlayer()
  local hit = target and getHitPart(target.Character, {"Left Arm", "LeftHand", "LeftLowerArm", "LeftUpperArm"})
  if hit then
    local remote = ReplicatedStorage:FindFirstChild("BullHit")
    if remote then
      pcall(function() remote:FireServer(hit) end)
    end
    lastBullHit = tick()
  end
end)

CombatTab:AddToggle({
  Name = "Aura Bull (Stone)",
  Default = false,
  Callback = function(v) bullAuraEnabled = v end
})

CombatTab:AddSlider({
  Name = "Retraso del ataque (cuidado)",
  Min = 1, Max = 10, Increase = 1, Default = 2,
  Callback = function(v) bullDelay = v end
})

CombatTab:AddButton({
  Name = "Conseguir el guante del aura",
  Callback = function()
    fireclickdetector(workspace:WaitForChild("Lobby"):WaitForChild("Bull"):WaitForChild("ClickDetector"))
  end
})

local UtilsSection = CombatTab:AddSection({" Guantes que puedes spamear (seguro)"})
local spamBarrierEnabled = false
local spamBarrierFastEnabled = false
local lastBarrierSpam = 0

local function SpamBarrier()
  ReplicatedStorage:WaitForChild("Barrier"):FireServer(1)
end

RunService.Heartbeat:Connect(function()
  if spamBarrierEnabled and (tick() - lastBarrierSpam >= 1) then
    SpamBarrier()
    lastBarrierSpam = tick()
  elseif spamBarrierFastEnabled and (tick() - lastBarrierSpam >= 0.1) then
    SpamBarrier()
    lastBarrierSpam = tick()
  end
end)

CombatTab:AddToggle({
  Name = "Spam Bairry",
  Default = false,
  Callback = function(v)
    spamBarrierEnabled = v
    if v then spamBarrierFastEnabled = false end
  end
})

CombatTab:AddToggle({
  Name = "Spam Bairry rápido",
  Default = false,
  Callback = function(v)
    spamBarrierFastEnabled = v
    if v then spamBarrierEnabled = false end
  end
})

local spamSpoonEnabled = false
local spamSpoonFastEnabled = false
local lastSpoonSpam = 0

local function SpamSpoon()
  ReplicatedStorage.GeneralAbility:FireServer({
    state = "vfx",
    origin = CFrame.new(-65.91, -5.17, 46.16) * CFrame.Angles(0, -0.47, 0),
    vfx = "jumptween",
    sendplr = LocalPlayer
  })
end

RunService.Heartbeat:Connect(function()
  if spamSpoonEnabled and (tick() - lastSpoonSpam >= 1) then
    SpamSpoon()
    lastSpoonSpam = tick()
  elseif spamSpoonFastEnabled and (tick() - lastSpoonSpam >= 0.1) then
    SpamSpoon()
    lastSpoonSpam = tick()
  end
end)

CombatTab:AddToggle({
  Name = "Spam Sound Spoonfull",
  Default = false,
  Callback = function(v)
    spamSpoonEnabled = v
    if v then spamSpoonFastEnabled = false end
  end
})

CombatTab:AddToggle({
  Name = "Spam Sound Spoonfull rápido",
  Default = false,
  Callback = function(v)
    spamSpoonFastEnabled = v
    if v then spamSpoonEnabled = false end
  end
})

CombatTab:AddButton({
  Name = "Conseguir Fork",
  Callback = function()
    ReplicatedStorage.GeneralAbility:FireServer({state = "vfx", vfx = "fork"})
  end
})

CombatTab:AddButton({
  Name = "Conseguir VFX del aura",
  Callback = function()
    ReplicatedStorage.GeneralAbility:FireServer({state = "vfx", vfx = "jumpvfx"})
  end
})

local BlindSection = CombatTab:AddSection({" Aura Blind"})
local blindAuraEnabled = false
local blindDelay = 1.5
local lastBlindHit = 0

RunService.Heartbeat:Connect(function()
  if not blindAuraEnabled or (tick() - lastBlindHit < blindDelay) then return end
  local target = GetClosestPlayer()
  local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  local hit = target and getHitPart(target.Character)
  if hit and hrp then
    local remote = ReplicatedStorage:FindFirstChild("GeneralAbility")
    if remote then
      pcall(function()
        remote:FireServer("default", {
          goal = hit.CFrame,
          origin = hrp.CFrame
        })
      end)
    end
    lastBlindHit = tick()
  end
end)

CombatTab:AddToggle({
  Name = "Aura Blind (el jugador se detiene)",
  Default = false,
  Callback = function(v) blindAuraEnabled = v end
})

CombatTab:AddButton({
  Name = "Conseguir el guante del aura",
  Callback = function()
    fireclickdetector(workspace:WaitForChild("Lobby"):WaitForChild("Bind"):WaitForChild("ClickDetector"))
  end
})

local GoldenSection = CombatTab:AddSection({" Aura Golden"})
local goldenAuraEnabled = false
local goldenDelay = 1
local lastGoldenHit = 0

RunService.Heartbeat:Connect(function()
  if not goldenAuraEnabled or (tick() - lastGoldenHit < goldenDelay) then return end
  local target = GetClosestPlayer()
  local hit = target and getHitPart(target.Character, {"Right Leg", "RightFoot", "RightLowerLeg", "RightUpperLeg"})
  if hit then
    local remote = ReplicatedStorage:FindFirstChild("GoldenHit")
    if remote then
      pcall(function() remote:FireServer(hit, true) end)
    end
    lastGoldenHit = tick()
  end
end)

CombatTab:AddToggle({
  Name = "Aura Hit Golden",
  Default = false,
  Callback = function(v) goldenAuraEnabled = v end
})

CombatTab:AddButton({
  Name = "Conseguir el guante Golden",
  Callback = function()
    fireclickdetector(workspace:WaitForChild("Lobby"):WaitForChild("Golden"):WaitForChild("ClickDetector"))
  end
})

local espEnabled = false
local espNames = true
local espDist = false
local espTool = true
local espNick = false
local espMaxDist = 400
local espObjects = {}

local function CreateDrawing(type, properties)
  local d = Drawing.new(type)
  for k, v in pairs(properties) do d[k] = v end
  return d
end

local function SetupEsp(player)
  if player == LocalPlayer or espObjects[player] then return end
  espObjects[player] = {
    box = CreateDrawing("Square", {Thickness = 2, Filled = false, Color = Color3.fromRGB(255, 80, 80), Visible = false}),
    name = CreateDrawing("Text", {Size = 16, Center = true, Outline = true, Color = Color3.fromRGB(255, 255, 255), Visible = false}),
    dist = CreateDrawing("Text", {Size = 16, Center = true, Outline = true, Color = Color3.fromRGB(255, 160, 160), Visible = false}),
    tool = CreateDrawing("Text", {Size = 16, Center = true, Outline = true, Color = Color3.fromRGB(255, 220, 120), Visible = false}),
    nick = CreateDrawing("Text", {Size = 16, Center = true, Outline = true, Color = Color3.fromRGB(150, 200, 255), Visible = false}),
    age = CreateDrawing("Text", {Size = 16, Center = true, Outline = true, Color = Color3.fromRGB(200, 200, 200), Visible = false}),
  }
end

local function RemoveEsp(player)
  if espObjects[player] then
    for _, d in pairs(espObjects[player]) do d:Remove() end
    espObjects[player] = nil
  end
end

RunService.RenderStepped:Connect(function()
  if not espEnabled then
    for _, objs in pairs(espObjects) do for _, d in pairs(objs) do d.Visible = false end end
    return
  end
  local cam = workspace.CurrentCamera
  for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then
      SetupEsp(plr)
      local objs = espObjects[plr]
      local char = plr.Character
      local hrp = char and char:FindFirstChild("HumanoidRootPart")
      if hrp then
        local pos, onScreen = cam:WorldToViewportPoint(hrp.Position)
        local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local distance = myHrp and (myHrp.Position - hrp.Position).Magnitude or 0

        if onScreen and distance <= espMaxDist then
          local size = math.clamp(2000 / pos.Z, 20, 60)
          objs.box.Visible = true
          objs.box.Size = Vector2.new(size / 2, size)
          objs.box.Position = Vector2.new(pos.X - size / 4, pos.Y - size / 2)

          objs.name.Visible = espNames
          if espNames then
            objs.name.Text = plr.Name
            objs.name.Position = Vector2.new(pos.X, pos.Y - size / 1.2)
          end

          objs.dist.Visible = espDist
          if espDist then
            objs.dist.Text = string.format("%.1f", distance)
            objs.dist.Position = Vector2.new(pos.X, pos.Y + size / 1.2)
          end

          local toolName = nil
          for _, c in pairs(char:GetChildren()) do if c:IsA("Tool") then toolName = c.Name; break end end
          objs.tool.Visible = espTool and toolName ~= nil
          if espTool and toolName then
            objs.tool.Text = toolName
            objs.tool.Position = Vector2.new(pos.X, pos.Y + size / 1.8)
          end

          objs.nick.Visible = espNick
          objs.age.Visible = espNick
          if espNick then
            objs.nick.Text = plr.DisplayName
            objs.nick.Position = Vector2.new(pos.X, pos.Y - size / 1.5)
            objs.age.Text = plr.AccountAge .. "d"
            objs.age.Position = Vector2.new(pos.X, pos.Y + size / 1.4)
          end
        else
          for _, d in pairs(objs) do d.Visible = false end
        end
      else
        for _, d in pairs(objs) do d.Visible = false end
      end
    end
  end
end)

Players.PlayerAdded:Connect(SetupEsp)
Players.PlayerRemoving:Connect(RemoveEsp)
for _, plr in pairs(Players:GetPlayers()) do SetupEsp(plr) end

EspTab:AddToggle({ Name = "ESP general", Default = false, Callback = function(v) espEnabled = v end })
EspTab:AddToggle({ Name = "ESP nombre", Default = true, Callback = function(v) espNames = v end })
EspTab:AddToggle({ Name = "ESP distancia", Default = false, Callback = function(v) espDist = v end })
EspTab:AddToggle({ Name = "ESP herramienta", Default = true, Callback = function(v) espTool = v end })
EspTab:AddToggle({ Name = "ESP apodo y edad", Default = false, Callback = function(v) espNick = v end })

local autoClickTycoon = false
local autoClickTycoonFast = false
local destroyAllTycoons = false
local autoClickNearTycoon = false
local autoClickNearTycoonFast = false

local function GetTycoonByName(name)
  for _, obj in ipairs(workspace:GetChildren()) do
    if string.find(obj.Name, "Tycoon") and string.find(obj.Name, name) then return obj end
  end
  return nil
end

local function GetClosestTycoon()
  local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  if not hrp then return nil end
  local closest = nil
  local dist = math.huge
  for _, obj in ipairs(workspace:GetChildren()) do
    if string.find(obj.Name, "Tycoon") and obj:FindFirstChild("Click") and obj.Click:FindFirstChild("ClickDetector") then
      local d = (hrp.Position - obj.Click.Position).Magnitude
      if d < dist then dist = d; closest = obj end
    end
  end
  return closest
end

task.spawn(function()
  while task.wait(0.5) do
    if autoClickTycoon then
      local t = GetTycoonByName(LocalPlayer.Name)
      if t and t:FindFirstChild("Click") and t.Click:FindFirstChild("ClickDetector") then fireclickdetector(t.Click.ClickDetector) end
    end
  end
end)

task.spawn(function()
  while task.wait(0.05) do
    if autoClickTycoonFast then
      local t = GetTycoonByName(LocalPlayer.Name)
      if t and t:FindFirstChild("Click") and t.Click:FindFirstChild("ClickDetector") then fireclickdetector(t.Click.ClickDetector) end
    end
  end
end)

task.spawn(function()
  while task.wait(0.02) do
    if destroyAllTycoons then
      for _, plr in pairs(Players:GetPlayers()) do
        local t = GetTycoonByName(plr.Name)
        if t and t:FindFirstChild("Destruct") and t.Destruct:FindFirstChild("ClickDetector") then fireclickdetector(t.Destruct.ClickDetector) end
      end
    end
  end
end)

task.spawn(function()
  while task.wait(0.5) do
    if autoClickNearTycoon then
      local t = GetClosestTycoon()
      if t and t:FindFirstChild("Click") and t.Click:FindFirstChild("ClickDetector") then fireclickdetector(t.Click.ClickDetector) end
    end
  end
end)

task.spawn(function()
  while task.wait(0.05) do
    if autoClickNearTycoonFast then
      local t = GetClosestTycoon()
      if t and t:FindFirstChild("Click") and t.Click:FindFirstChild("ClickDetector") then fireclickdetector(t.Click.ClickDetector) end
    end
  end
end)

TycoonTab:AddToggle({ Name = "Auto click tycoon", Default = false, Callback = function(v) autoClickTycoon = v end })
TycoonTab:AddToggle({ Name = "Auto click tycoon rápido", Default = false, Callback = function(v) autoClickTycoonFast = v end })
TycoonTab:AddToggle({ Name = "Auto click (tycoon cercano)", Default = false, Callback = function(v) autoClickNearTycoon = v end })
TycoonTab:AddToggle({ Name = "Auto click rápido (tycoon cercano)", Default = false, Callback = function(v) autoClickNearTycoonFast = v end })

local TrollSection = TycoonTab:AddSection({" Trollear jugadores (Tycoon)"})
TycoonTab:AddToggle({ Name = "Destruir todos los tycoons", Default = false, Callback = function(v) destroyAllTycoons = v end })

TycoonTab:AddButton({
  Name = "Destruir todos los tycoons de golpe",
  Callback = function()
    for _, obj in ipairs(workspace:GetChildren()) do
      if string.find(obj.Name, "Tycoon") and obj:FindFirstChild("Destruct") and obj.Destruct:FindFirstChild("ClickDetector") then
        for i = 1, 3 do fireclickdetector(obj.Destruct.ClickDetector) end
      end
    end
  end
})

TycoonTab:AddButton({
  Name = "Destruir mi tycoon",
  Callback = function()
    local t = GetTycoonByName(LocalPlayer.Name)
    if t and t:FindFirstChild("Destruct") and t.Destruct:FindFirstChild("ClickDetector") then fireclickdetector(t.Destruct.ClickDetector) end
  end
})

local SafeSection = TycoonTab:AddSection({" Zona segura : no te protege del todo"})
local function TpToPos(pos)
  if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
  end
end

TycoonTab:AddButton({ Name = "TP : Zona segura 1", Callback = function() TpToPos(Vector3.new(257, 34, 196)) end })
TycoonTab:AddButton({ Name = "TP : Zona segura 2", Callback = function() TpToPos(Vector3.new(248, -16, -3)) end })
TycoonTab:AddButton({ Name = "TP : Zona segura 3", Callback = function() TpToPos(Vector3.new(-5, -5, -216)) end })
TycoonTab:AddButton({ Name = "TP : Zona segura 4", Callback = function() TpToPos(Vector3.new(-2, -5, 218)) end })
TycoonTab:AddButton({ Name = "TP : Zona segura 5", Callback = function() TpToPos(Vector3.new(-393, 51, -17)) end })

local aura2xEnabled = false
local aura2xDelay = 0.45
local last2xHit = 0
local autoSlapplesEnabled = false

RunService.Heartbeat:Connect(function()
  if not aura2xEnabled or (tick() - last2xHit < aura2xDelay) then return end
  local target = GetClosestPlayer()
  local hit = target and getHitPart(target.Character, {"Right Arm", "RightHand", "RightLowerArm", "RightUpperArm", "HumanoidRootPart"})
  local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  if hit and hrp then
    faceTarget(hrp, hit.Position)
    local tool = equipGlove()
    if tool then
      pcall(function() tool:Activate() end)
    end
    local remote = ReplicatedStorage:FindFirstChild("GeneralHit")
    if remote then
      pcall(function() remote:FireServer(hit) end)
    end
    last2xHit = tick()
  end
end)

local function collectSlappleTargets()
  local targets = {}
  local seen = {}
  local function add(part)
    if not part or not part:IsA("BasePart") or part.Transparency >= 1 then return end
    local key = (part.Parent and part.Parent:IsA("Model")) and part.Parent or part
    if seen[key] then return end
    seen[key] = true
    table.insert(targets, part)
  end

  local roots = {}
  local arena = workspace:FindFirstChild("Arena")
  if arena then table.insert(roots, arena) end
  local loose = workspace:FindFirstChild("Slapples")
  if loose then table.insert(roots, loose) end
  if #roots == 0 then return targets end

  for _, root in ipairs(roots) do
    local list = {root}
    if not root:IsA("BasePart") then
      for _, d in ipairs(root:GetDescendants()) do
        table.insert(list, d)
      end
    end
    for _, d in ipairs(list) do
      local name = string.lower(d.Name)
      if d.Name == "Slapples" or string.find(name, "slapple", 1, true) then
        if d:IsA("BasePart") then
          add(d)
        else
          for _, child in ipairs(d:GetChildren()) do
            if child:IsA("BasePart") then
              add(child)
            elseif child:IsA("Model") then
              add(child.PrimaryPart or child:FindFirstChildWhichIsA("BasePart"))
            end
          end
        end
      end
    end
  end
  return targets
end

local function CollectSlapples()
  local char = LocalPlayer.Character
  local hrp = char and char:FindFirstChild("HumanoidRootPart")
  if not hrp then return end
  for _, part in ipairs(collectSlappleTargets()) do
    if not autoSlapplesEnabled or not part.Parent then break end
    hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then break end
    hrp.CFrame = CFrame.new(part.Position + Vector3.new(0, 3, 0))
    if typeof(firetouchinterest) == "function" then
      pcall(firetouchinterest, hrp, part, 0)
      task.wait()
      pcall(firetouchinterest, hrp, part, 1)
    end
    task.wait(0.12)
  end
end

task.spawn(function()
  while task.wait(0.2) do
    if autoSlapplesEnabled then
      local ok, err = pcall(CollectSlapples)
      if not ok then
        warn("Farm slapples: " .. tostring(err))
      end
    end
  end
end)

FarmTab:AddToggle({
  Name = "Auto slap (jugadores cercanos)",
  Default = false,
  Callback = function(v) autoSlapEnabled = v end
})

FarmTab:AddSlider({
  Name = "Retraso del auto slap",
  Min = 0.1, Max = 2, Increase = 0.1, Default = 0.3,
  Callback = function(v) autoSlapDelay = v end
})

FarmTab:AddToggle({ Name = "Aura 2x Slaps (necesita el guante)", Default = false, Callback = function(v) aura2xEnabled = v end })
FarmTab:AddSlider({ Name = "Retraso del aura 2x", Min = 0.1, Max = 5, Increase = 0.1, Default = 0.5, Callback = function(v) aura2xDelay = v end })
local SlapplesSection = FarmTab:AddSection({" Farm: recoger slapples"})
FarmTab:AddToggle({ Name = "Auto TP a todos los slapples", Default = false, Callback = function(v) autoSlapplesEnabled = v end })

local ragdollFreezer = false
local ragdollLag = false
local ragdollReset = false

local function GetRagdollValue()
  local char = workspace:FindFirstChild(LocalPlayer.Name)
  return char and char:FindFirstChild("Ragdolled")
end

local function SetAnchored(v)
  local char = LocalPlayer.Character
  if not char then return end
  for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.Anchored = v end end
end

RunService.Heartbeat:Connect(function()
  if not ragdollFreezer then return end
  local v = GetRagdollValue()
  SetAnchored(v and v.Value == true)
end)

task.spawn(function()
  while task.wait(0.3) do
    if ragdollLag then
      local v = GetRagdollValue()
      if v and v.Value == true then SetAnchored(true); task.wait(0.1); SetAnchored(false) end
    end
  end
end)

task.spawn(function()
  while task.wait(0.2) do
    if ragdollReset then
      local v = GetRagdollValue()
      if v and v.Value == true then LocalPlayer.Reset:FireServer() end
    end
  end
end)

ProtecTab:AddToggle({ Name = "Protección ragdoll (congelar)", Default = false, Callback = function(v) ragdollFreezer = v end })
ProtecTab:AddToggle({ Name = "Protección ragdoll (lag)", Default = false, Callback = function(v) ragdollLag = v end })
ProtecTab:AddToggle({ Name = "Protección ragdoll (reset)", Default = false, Callback = function(v) ragdollReset = v end })

local mailContent = nil
local mailName = nil
ProtecTab:AddToggle({
  Name = "Protección de correo",
  Default = false,
  Callback = function(v)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local mail = char:FindFirstChild("YouHaveGotMail")
    if v and mail and mail:IsA("Script") then
      mailContent = mail.Source
      mailName = mail.Name
      mail:Destroy()
      print("Protección de correo activa.")
    elseif not v and mailContent and mailName then
      local s = Instance.new("Script")
      s.Name = mailName
      s.Source = mailContent
      s.Parent = char
      print("Script de correo restaurado.")
    end
  end
})
