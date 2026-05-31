local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/FloppHub-Team/UIs/refs/heads/main/RayField%20Version%20Cracked"))()

local Window = Rayfield:CreateWindow({
   Name = "⚡ Speed Keyboard Escape v3 ⚡",
   LoadingTitle = "+1 Speed Keyboard Escape Hub",
   LoadingSubtitle = "by TheRealBanHammer",
   Theme = "DarkBlue",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SpeedKeyboardEscapeConfigV3",
      FileName = "config"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = true
   },
   KeySystem = false
})

local Tab1 = Window:CreateTab("🌾 Farms & Victorias")
local Tab2 = Window:CreateTab("🏃 Movimiento & Jugador")
local Tab3 = Window:CreateTab("⚙️ Ajustes & Extras")

local farmMode = "Solo Última Etapa"
local specificStageNum = 1
local superObbyActive = false
local autofarmActive = false
local autoWinActive = false
local autoTreadmillActive = false
local autoRebirthActive = false
local autoClickActive = false
local hyperSpeedActive = false
local speedValue = 100
local autowalkActive = false
local noclipActive = false
local infiniteJumpActive = false
local startPos = nil
local sequentialIndex = 1
local superObbyIndex = 1
local winCache = {}

local player = game:GetService("Players").LocalPlayer

local function getSpawnPos()
    local spawn = workspace:FindFirstChildOfClass("SpawnLocation")
    if spawn then
        return spawn.Position
    end
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        return root.Position
    end
    return Vector3.new(0, 0, 0)
end

local function isCharacterDescendant(v)
    for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
        if p.Character and v:IsDescendantOf(p.Character) then
            return true
        end
    end
    return false
end

local function findWinText(instance)
    local current = instance
    for _ = 1, 3 do
        if not current or current == workspace then break end
        for _, child in ipairs(current:GetDescendants()) do
            if child:IsA("TextLabel") or child:IsA("TextBox") or child:IsA("TextMesh") then
                local txt = child.Text:lower()
                if not (txt:find("paso") or txt:find("step") or txt:find("speed") or txt:find("requiere") or txt:find("require") or txt:find("req")) then
                    if txt:find("win") or txt:find("vitoria") or txt:find("victoria") or txt:find("+") or txt:find("etapa") or txt:find("stage") or txt:find("nivel") or txt:find("level") or txt:find("zona") or txt:find("zone") or txt:find("area") or txt:find("world") or txt:find("mundo") or txt:find("portal") or txt:find("gate") or txt:find("teleport") or txt:find("tp") or txt:find("pad") or txt:find("door") then
                        local num = tonumber(txt:match("%d+"))
                        if num then
                            if txt:find("world") or txt:find("mundo") then
                                return (num - 1) * 5 + 1, txt
                            end
                            return num, txt
                        end
                    end
                end
            end
        end
        current = current.Parent
    end
    return nil, nil
end

local function checkIsTreadmill(instance)
    local current = instance
    for _ = 1, 3 do
        if not current or current == workspace then break end
        for _, child in ipairs(current:GetDescendants()) do
            if child:IsA("TextLabel") or child:IsA("TextBox") or child:IsA("TextMesh") then
                local txt = child.Text:lower()
                if txt:find("paso") or txt:find("step") or txt:find("speed") or txt:find("requiere") or txt:find("require") or txt:find("req") then
                    return true
                end
            end
        end
        current = current.Parent
    end
    return false
end

local function parseNameForWin(instance)
    local current = instance
    for _ = 1, 3 do
        if not current or current == workspace then break end
        local name = current.Name:lower()
        if name:find("win") or name:find("vitoria") or name:find("victoria") or name:find("finish") or name:find("reward") or name:find("award") or name:find("prize") or name:find("stage") or name:find("etapa") or name:find("door") or name:find("portal") or name:find("gate") or name:find("level") or name:find("nivel") or name:find("zona") or name:find("zone") or name:find("area") or name:find("world") or name:find("mundo") or name:find("teleport") or name:find("tp") or name:find("pad") or name:find("button") or name:find("boton") or name:find("block") or name:find("bloque") or name:find("part") or name:find("next") or name:find("siguiente") then
            local num = tonumber(name:match("%d+"))
            if num then
                if name:find("world") or name:find("mundo") then
                    return (num - 1) * 5 + 1
                end
                return num
            end
        end
        current = current.Parent
    end
    return nil
end

local function parseNumberOnly(instance)
    local current = instance
    for _ = 1, 3 do
        if not current or current == workspace then break end
        local num = tonumber(current.Name:match("^%d+$"))
        if num then
            return num
        end
        current = current.Parent
    end
    return nil
end

local function getWinPartsSorted()
    local spawnPos = getSpawnPos()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v:FindFirstChildOfClass("TouchTransmitter") then
            if not isCharacterDescendant(v) then
                local name = v.Name:lower()
                local parentName = v.Parent and v.Parent.Name:lower() or ""
                
                local winVal, winText = findWinText(v)
                if not winVal then
                    winVal = parseNameForWin(v)
                end
                if not winVal then
                    winVal = parseNumberOnly(v)
                end
                
                local isExcluded = name:find("checkpoint") or parentName:find("checkpoint") 
                    or name:find("spawn") or parentName:find("spawn") 
                    or name:find("lobby") or parentName:find("lobby") 
                    or name:find("treadmill") or name:find("cinta")
                    or name:find("kill") or name:find("lava") 
                    or name:find("death") or name:find("hazard")
                    or name:find("event") or parentName:find("event")
                    or name:find("shop") or parentName:find("shop")
                    or name:find("modal") or parentName:find("modal")
                    or name:find("hitbox") or parentName:find("hitbox")
                    or name:find("wall") or parentName:find("wall")
                    or name:find("admin") or parentName:find("admin")
                    or name:find("abuse") or parentName:find("abuse")
                    or name:find("chest") or parentName:find("chest")
                    or name:find("gift") or parentName:find("gift")
                    or name:find("wheel") or parentName:find("wheel")
                    or name:find("spin") or parentName:find("spin")
                    or name:find("pet") or parentName:find("pet")
                    or name:find("egg") or parentName:find("egg")
                    or name:find("rebirth") or parentName:find("rebirth")
                
                if checkIsTreadmill(v) then
                    isExcluded = true
                end
                
                local isWinPart = false
                if winVal then
                    isWinPart = true
                else
                    local combined = name .. " " .. parentName
                    if combined:find("win") or combined:find("vitoria") or combined:find("victoria") or combined:find("finish") or combined:find("reward") or combined:find("stage") or combined:find("etapa") or combined:find("door") or combined:find("portal") or combined:find("gate") or combined:find("level") then
                        isWinPart = true
                    end
                end
                
                if not isExcluded and isWinPart then
                    local cacheKey = tostring(winVal or 0) .. "_" .. v.Name
                    winCache[cacheKey] = {
                        Part = v,
                        Name = v.Name,
                        StageNumber = winVal or 0,
                        CFrame = v.CFrame,
                        Position = v.Position
                    }
                end
            end
        end
    end

    local list = {}
    for _, data in pairs(winCache) do
        local partInstance = data.Part
        if not partInstance or not partInstance:IsDescendantOf(workspace) then
            partInstance = nil
        end
        table.insert(list, {
            Part = partInstance,
            Name = data.Name,
            StageNumber = data.StageNumber,
            CFrame = data.CFrame,
            Position = data.Position,
            Distance = (data.Position - spawnPos).Magnitude
        })
    end

    table.sort(list, function(a, b)
        if a.StageNumber ~= b.StageNumber then
            return a.StageNumber < b.StageNumber
        end
        return a.Distance < b.Distance
    end)
    return list
end

local function getSpecificWinPart(targetStageNum)
    local winParts = getWinPartsSorted()
    for _, data in ipairs(winParts) do
        if data.StageNumber == targetStageNum then
            return data.Part
        end
    end
    if winParts[targetStageNum] then
        return winParts[targetStageNum].Part
    end
    return nil
end

local function getKeyboardKeys()
    local keys = {}
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v:FindFirstChildOfClass("TouchTransmitter") then
            if not isCharacterDescendant(v) then
                local name = v.Name:lower()
                local parentName = v.Parent and v.Parent.Name:lower() or ""
                local isKey = false
                if #v.Name == 1 or name:find("key") or name:find("tecla") or name:find("keyboard") then
                    isKey = true
                elseif parentName:find("key") or parentName:find("keyboard") or parentName:find("spawn") or parentName:find("lobby") then
                    if not name:find("checkpoint") and not name:find("spawnlocation") then
                        isKey = true
                    end
                end
                if isKey then
                    table.insert(keys, v)
                end
            end
        end
    end
    return keys
end

local vim = game:GetService("VirtualInputManager")

task.spawn(function()
    local isW = true
    local lastSwitch = tick()
    while true do
        task.wait(0.01)
        if autofarmActive then
            local char = player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                if tick() - lastSwitch > 1.5 then
                    if isW then
                        vim:SendKeyEvent(false, Enum.KeyCode.W, false, game)
                        vim:SendKeyEvent(true, Enum.KeyCode.S, false, game)
                        isW = false
                    else
                        vim:SendKeyEvent(false, Enum.KeyCode.S, false, game)
                        vim:SendKeyEvent(true, Enum.KeyCode.W, false, game)
                        isW = true
                    end
                    lastSwitch = tick()
                end
                
                local keys = getKeyboardKeys()
                if #keys > 0 then
                    for i = 1, math.min(#keys, 20) do
                        if not autofarmActive then break end
                        local keyPart = keys[math.random(1, #keys)]
                        if keyPart and firetouchinterest then
                            firetouchinterest(root, keyPart, 0)
                            firetouchinterest(root, keyPart, 1)
                        end
                    end
                else
                    task.wait(0.1)
                end
            end
        else
            vim:SendKeyEvent(false, Enum.KeyCode.W, false, game)
            vim:SendKeyEvent(false, Enum.KeyCode.S, false, game)
            isW = true
            task.wait(0.5)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.3)
        if autoWinActive then
            local char = player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                local winParts = getWinPartsSorted()
                if #winParts > 0 then
                    local targetData = nil
                    if farmMode == "Solo Última Etapa" then
                        targetData = winParts[#winParts]
                    elseif farmMode == "Secuencial (Todas)" then
                        if not sequentialIndex or sequentialIndex > #winParts then
                            sequentialIndex = 1
                        end
                        for i = sequentialIndex, #winParts do
                            if not autoWinActive then break end
                            local data = winParts[i]
                            local currentRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                            if currentRoot then
                                currentRoot.Anchored = false
                                local targetCFrame = data.CFrame + Vector3.new(0, 1.5, 0)
                                currentRoot.CFrame = targetCFrame
                                currentRoot.AssemblyLinearVelocity = Vector3.zero
                                
                                task.wait(0.15)
                                
                                local part = data.Part
                                if not part or not part:IsDescendantOf(workspace) then
                                    for _, child in ipairs(workspace:GetDescendants()) do
                                        if child:IsA("BasePart") and child.Name == data.Name and child:FindFirstChildOfClass("TouchTransmitter") then
                                            if (child.Position - currentRoot.Position).Magnitude < 20 then
                                                part = child
                                                break
                                            end
                                        end
                                    end
                                end
                                
                                if part and firetouchinterest then
                                    firetouchinterest(currentRoot, part, 0)
                                    firetouchinterest(currentRoot, part, 1)
                                end
                                task.wait(0.15)
                                
                                if currentRoot and (currentRoot.Position - targetCFrame.Position).Magnitude > 30 then
                                    task.wait(1.5)
                                    local spawnPos = getSpawnPos()
                                    if (currentRoot.Position - spawnPos).Magnitude < 100 then
                                        sequentialIndex = i + 1
                                    else
                                        sequentialIndex = 1
                                    end
                                    break
                                else
                                    sequentialIndex = i + 1
                                end
                            end
                        end
                    elseif farmMode == "Etapa Específica" then
                        local specificNum = specificStageNum
                        for _, data in ipairs(winParts) do
                            if data.StageNumber == specificNum then
                                targetData = data
                                break
                            end
                        end
                        if not targetData and winParts[specificNum] then
                            targetData = winParts[specificNum]
                        end
                    end
                    
                    if targetData and farmMode ~= "Secuencial (Todas)" then
                        root.CFrame = targetData.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.15)
                        local part = targetData.Part
                        if not part or not part:IsDescendantOf(workspace) then
                            for _, child in ipairs(workspace:GetDescendants()) do
                                if child:IsA("BasePart") and child.Name == targetData.Name and child:FindFirstChildOfClass("TouchTransmitter") then
                                    if (child.Position - root.Position).Magnitude < 20 then
                                        part = child
                                        break
                                    end
                                end
                            end
                        end
                        if part and firetouchinterest then
                            firetouchinterest(root, part, 0)
                            task.wait(0.02)
                            firetouchinterest(root, part, 1)
                        end
                        task.wait(1.5)
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.5)
        if superObbyActive then
            local char = player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChild("Humanoid")
            if root and hum and hum.Health > 0 then
                noclipActive = true
                local winParts = getWinPartsSorted()
                if #winParts > 0 then
                    if not superObbyIndex or superObbyIndex > #winParts then
                        superObbyIndex = 1
                    end
                    for i = superObbyIndex, #winParts do
                        if not superObbyActive or not root or not hum or hum.Health <= 0 then break end
                        local data = winParts[i]
                        root.Anchored = false
                        local targetCFrame = data.CFrame + Vector3.new(0, 1.5, 0)
                        root.CFrame = targetCFrame
                        root.AssemblyLinearVelocity = Vector3.zero
                        
                        task.wait(0.15)
                        
                        local part = data.Part
                        if not part or not part:IsDescendantOf(workspace) then
                            for _, child in ipairs(workspace:GetDescendants()) do
                                if child:IsA("BasePart") and child.Name == data.Name and child:FindFirstChildOfClass("TouchTransmitter") then
                                    if (child.Position - root.Position).Magnitude < 20 then
                                        part = child
                                        break
                                    end
                                end
                            end
                        end
                        
                        if part and firetouchinterest then
                            firetouchinterest(root, part, 0)
                            firetouchinterest(root, part, 1)
                        end
                        
                        task.wait(0.15)
                        
                        if root and (root.Position - targetCFrame.Position).Magnitude > 30 then
                            task.wait(1.5)
                            local spawnPos = getSpawnPos()
                            if (root.Position - spawnPos).Magnitude < 100 then
                                superObbyIndex = i + 1
                            else
                                superObbyIndex = 1
                            end
                            break
                        else
                            superObbyIndex = i + 1
                        end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if autoTreadmillActive then
            local char = player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                local treadmillPart = nil
                for _, v in ipairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and v.Name:lower():find("treadmill") then
                        treadmillPart = v
                        break
                    end
                end
                if treadmillPart then
                    root.CFrame = treadmillPart.CFrame + Vector3.new(0, 3, 0)
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        hum:Move(Vector3.new(0, 0, -1), true)
                    end
                else
                    Rayfield:Notify({
                        Title = "Error",
                        Content = "No se encontraron cintas de correr.",
                        Duration = 3
                    })
                    autoTreadmillActive = false
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if autoRebirthActive then
            local rebirthRemote = nil
            for _, v in ipairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") and (v.Name:lower():find("rebirth") or v.Name:lower():find("prestige")) then
                    rebirthRemote = v
                    break
                end
            end
            if rebirthRemote then
                rebirthRemote:FireServer()
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.05)
        if autoClickActive then
            for _, v in ipairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") then
                    local rName = v.Name:lower()
                    if rName:find("click") or rName:find("tap") or rName:find("addspeed") or rName:find("gain") or rName:find("step") or rName:find("train") then
                        v:FireServer()
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(30)
        if setclipboard then
            setclipboard("https://discord.gg/rTGF5xhe3h")
        elseif toclipboard then
            toclipboard("https://discord.gg/rTGF5xhe3h")
        end
        Rayfield:Notify({
            Title = "Únete a nuestro Discord",
            Content = "Enlace copiado al portapapeles: discord.gg/rTGF5xhe3h",
            Duration = 5
        })
    end
end)

Tab1:CreateDropdown({
    Name = "Modo de Farm de Victorias",
    Options = {"Solo Última Etapa", "Secuencial (Todas)", "Etapa Específica"},
    CurrentOption = "Solo Última Etapa",
    MultipleOptions = false,
    Flag = "FarmModeDropdown",
    Callback = function(Option)
        farmMode = Option[1] or Option
    end
})

Tab1:CreateSlider({
    Name = "Número de Etapa Específica",
    Range = {1, 100},
    Increment = 1,
    Suffix = " Stage",
    CurrentValue = 1,
    Flag = "SpecificStageSlider",
    Callback = function(Value)
        specificStageNum = Value
    end
})

local toggleWin, toggleObby, toggleFarm, toggleTreadmill

toggleWin = Tab1:CreateToggle({
    Name = "Bucle de Victorias AFK",
    CurrentValue = false,
    Flag = "AutoWinToggle",
    Callback = function(Value)
        autoWinActive = Value
        if Value then
            if toggleObby then toggleObby:Set(false) end
            if toggleFarm then toggleFarm:Set(false) end
            if toggleTreadmill then toggleTreadmill:Set(false) end
        end
    end
})

toggleObby = Tab1:CreateToggle({
    Name = "Super Auto-Obby Caminar AFK",
    CurrentValue = false,
    Flag = "SuperObbyToggle",
    Callback = function(Value)
        superObbyActive = Value
        if Value then
            if toggleWin then toggleWin:Set(false) end
            if toggleFarm then toggleFarm:Set(false) end
            if toggleTreadmill then toggleTreadmill:Set(false) end
            local winParts = getWinPartsSorted()
            local names = {}
            for _, data in ipairs(winParts) do
                table.insert(names, data.Name .. " (" .. data.StageNumber .. ")")
            end
            if #names > 0 then
                Rayfield:Notify({
                    Title = "Obby Secuencial",
                    Content = "Ruta detectada: " .. table.concat(names, " -> "),
                    Duration = 5
                })
            else
                Rayfield:Notify({
                    Title = "Alerta",
                    Content = "No se detectaron zonas de victoria en este mapa.",
                    Duration = 5
                })
            end
        else
            noclipActive = false
        end
    end
})

toggleFarm = Tab1:CreateToggle({
    Name = "Auto Farm (Ganar Pasos en Spawn)",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        autofarmActive = Value
        if Value then
            if toggleWin then toggleWin:Set(false) end
            if toggleObby then toggleObby:Set(false) end
            if toggleTreadmill then toggleTreadmill:Set(false) end
        end
    end
})

toggleTreadmill = Tab1:CreateToggle({
    Name = "Auto Cinta de Correr (Treadmill)",
    CurrentValue = false,
    Flag = "AutoTreadmillToggle",
    Callback = function(Value)
        autoTreadmillActive = Value
        if Value then
            if toggleWin then toggleWin:Set(false) end
            if toggleObby then toggleObby:Set(false) end
            if toggleFarm then toggleFarm:Set(false) end
        end
    end
})

Tab1:CreateToggle({
    Name = "Auto Rebirth (Rebotes)",
    CurrentValue = false,
    Flag = "AutoRebirthToggle",
    Callback = function(Value)
        autoRebirthActive = Value
    end
})

Tab1:CreateToggle({
    Name = "Auto Auto-Click (Velocidad Extra)",
    CurrentValue = false,
    Flag = "AutoClickToggle",
    Callback = function(Value)
        autoClickActive = Value
    end
})

Tab1:CreateButton({
    Name = "Win Instantáneo (TP a Win Seleccionado)",
    Callback = function()
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            local winParts = getWinPartsSorted()
            if #winParts > 0 then
                local targetPart = nil
                if farmMode == "Solo Última Etapa" then
                    targetPart = winParts[#winParts].Part
                elseif farmMode == "Etapa Específica" then
                    targetPart = getSpecificWinPart(specificStageNum)
                else
                    targetPart = winParts[1].Part
                end
                
                if targetPart then
                    root.CFrame = targetPart.CFrame + Vector3.new(0, 3, 0)
                    if firetouchinterest then
                        firetouchinterest(root, targetPart, 0)
                        task.wait(0.05)
                        firetouchinterest(root, targetPart, 1)
                    end
                else
                    Rayfield:Notify({
                        Title = "Error",
                        Content = "No se encontró la zona seleccionada.",
                        Duration = 3
                    })
                end
            else
                Rayfield:Notify({
                    Title = "Error",
                    Content = "No se encontraron zonas de victoria.",
                    Duration = 3
                })
            end
        end
    end
})

game:GetService("RunService").Heartbeat:Connect(function()
    if hyperSpeedActive then
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = speedValue
        end
    end
end)

Tab2:CreateToggle({
    Name = "Activar Hyper Velocidad",
    CurrentValue = false,
    Flag = "HyperSpeedToggle",
    Callback = function(Value)
        hyperSpeedActive = Value
        if not Value then
            local char = player.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.WalkSpeed = 16
            end
        end
    end
})

Tab2:CreateSlider({
    Name = "Valor de Velocidad",
    Range = {16, 500},
    Increment = 1,
    Suffix = " Walkspeed",
    CurrentValue = 100,
    Flag = "SpeedSlider",
    Callback = function(Value)
        speedValue = Value
    end
})

game:GetService("RunService").RenderStepped:Connect(function()
    if autowalkActive then
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:Move(Vector3.new(0, 0, -1), true)
        end
    end
end)

Tab2:CreateToggle({
    Name = "Auto Caminar Adelante",
    CurrentValue = false,
    Flag = "AutoWalkToggle",
    Callback = function(Value)
        autowalkActive = Value
    end
})

game:GetService("RunService").Stepped:Connect(function()
    if noclipActive then
        local char = player.Character
        if char then
            for _, child in ipairs(char:GetDescendants()) do
                if child:IsA("BasePart") and child.CanCollide then
                    child.CanCollide = false
                end
            end
        end
    end
end)

Tab2:CreateToggle({
    Name = "Noclip (Atravesar Paredes)",
    CurrentValue = false,
    Flag = "NoclipToggle",
    Callback = function(Value)
        noclipActive = Value
    end
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if infiniteJumpActive then
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

Tab2:CreateToggle({
    Name = "Salto Infinito",
    CurrentValue = false,
    Flag = "InfJumpToggle",
    Callback = function(Value)
        infiniteJumpActive = Value
    end
})

Tab3:CreateButton({
    Name = "Reconectar Servidor",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        if #Players:GetPlayers() <= 1 then
            LocalPlayer:Kick("Reconectando...")
            task.wait(0.5)
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end
    end
})

Tab3:CreateButton({
    Name = "Servidor Serverhop",
    Callback = function()
        local HttpService = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local Servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        for _, server in ipairs(Servers.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                break
            end
        end
    end
})

Tab3:CreateButton({
    Name = "Cerrar Interfaz",
    Callback = function()
        Rayfield:Destroy()
    end
})
