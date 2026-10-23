local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
if PlayerGui:FindFirstChild("DeobfScripts") then
	PlayerGui:FindFirstChild("DeobfScripts"):Destroy()
end
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeobfScripts"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Enabled = false
ScreenGui.Parent = PlayerGui
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 320)
MainFrame.Position = UDim2.new(0.5, - 210, 0.5, - 160)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(160, 0, 0)
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.3
MainStroke.Parent = MainFrame
local BgGradient = Instance.new("UIGradient")
BgGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 0, 0)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(12, 0, 0)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 0, 0)),
})
BgGradient.Rotation = 135
BgGradient.Parent = MainFrame
local GlowInner = Instance.new("Frame")
GlowInner.Name = "GlowInner"
GlowInner.Size = UDim2.new(1, 0, 0.5, 0)
GlowInner.Position = UDim2.new(0, 0, 0, 0)
GlowInner.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
GlowInner.BackgroundTransparency = 0.95
GlowInner.BorderSizePixel = 0
GlowInner.ZIndex = 1
GlowInner.Parent = MainFrame
local GlowGrad = Instance.new("UIGradient")
GlowGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
})
GlowGrad.Rotation = 180
GlowGrad.Parent = GlowInner
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 44)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 0, 0)
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 5
TitleBar.Parent = MainFrame
local TitleBarGrad = Instance.new("UIGradient")
TitleBarGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 0, 0)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 0, 0)),
})
TitleBarGrad.Transparency = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 0.5),
	NumberSequenceKeypoint.new(1, 0.7),
})
TitleBarGrad.Rotation = 90
TitleBarGrad.Parent = TitleBar
local TitleBorder = Instance.new("Frame")
TitleBorder.Size = UDim2.new(1, 0, 0, 1)
TitleBorder.Position = UDim2.new(0, 0, 1, - 1)
TitleBorder.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
TitleBorder.BackgroundTransparency = 0.4
TitleBorder.BorderSizePixel = 0
TitleBorder.ZIndex = 6
TitleBorder.Parent = TitleBar
local TitleBorderGrad = Instance.new("UIGradient")
TitleBorderGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
	ColorSequenceKeypoint.new(0.3, Color3.fromRGB(200, 0, 0)),
	ColorSequenceKeypoint.new(0.7, Color3.fromRGB(200, 0, 0)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
})
TitleBorderGrad.Parent = TitleBorder
local BarLabel = Instance.new("TextLabel")
BarLabel.Text = "THEREALBANHAMMER | AHST"
BarLabel.Size = UDim2.new(1, - 60, 1, 0)
BarLabel.Position = UDim2.new(0, 14, 0, 0)
BarLabel.BackgroundTransparency = 1
BarLabel.Font = Enum.Font.GothamBold
BarLabel.TextSize = 11
BarLabel.TextColor3 = Color3.fromRGB(180, 60, 60)
BarLabel.TextXAlignment = Enum.TextXAlignment.Left
BarLabel.TextTransparency = 0.3
BarLabel.ZIndex = 7
BarLabel.Parent = TitleBar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, - 36, 0.5, - 14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
CloseBtn.BackgroundTransparency = 0.5
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.TextSize = 13
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.ZIndex = 8
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = TitleBar
local CloseBtnCorner = Instance.new("UICorner")
CloseBtnCorner.CornerRadius = UDim.new(1, 0)
CloseBtnCorner.Parent = CloseBtn
local CloseBtnStroke = Instance.new("UIStroke")
CloseBtnStroke.Color = Color3.fromRGB(180, 0, 0)
CloseBtnStroke.Thickness = 1
CloseBtnStroke.Transparency = 0.5
CloseBtnStroke.Parent = CloseBtn
CloseBtn.MouseEnter:Connect(function()
	TweenService:Create(CloseBtn, TweenInfo.new(0.15), {
		BackgroundColor3 = Color3.fromRGB(200, 0, 0),
		BackgroundTransparency = 0.1,
		TextColor3 = Color3.fromRGB(255, 255, 255),
	}):Play()
end)
CloseBtn.MouseLeave:Connect(function()
	TweenService:Create(CloseBtn, TweenInfo.new(0.15), {
		BackgroundColor3 = Color3.fromRGB(120, 0, 0),
		BackgroundTransparency = 0.5,
		TextColor3 = Color3.fromRGB(255, 80, 80),
	}):Play()
end)
local Body = Instance.new("Frame")
Body.Name = "Body"
Body.Size = UDim2.new(1, 0, 1, - 44)
Body.Position = UDim2.new(0, 0, 0, 44)
Body.BackgroundTransparency = 1
Body.ZIndex = 2
Body.Parent = MainFrame
local Emblem = Instance.new("TextLabel")
Emblem.Text = "◈"
Emblem.Size = UDim2.new(0, 70, 0, 70)
Emblem.Position = UDim2.new(0.5, - 35, 0, 18)
Emblem.BackgroundTransparency = 1
Emblem.Font = Enum.Font.GothamBold
Emblem.TextSize = 52
Emblem.TextColor3 = Color3.fromRGB(220, 0, 0)
Emblem.ZIndex = 3
Emblem.Parent = Body
local emblemPulse = true
task.spawn(function()
	local growing = true
	while emblemPulse do
		local target = growing and Color3.fromRGB(255, 40, 40) or Color3.fromRGB(180, 0, 0)
		TweenService:Create(Emblem, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			TextColor3 = target
		}):Play()
		growing = not growing
		task.wait(1.2)
	end
end)
local Sep = Instance.new("Frame")
Sep.Size = UDim2.new(0, 260, 0, 1)
Sep.Position = UDim2.new(0.5, - 130, 0, 96)
Sep.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
Sep.BackgroundTransparency = 0.4
Sep.BorderSizePixel = 0
Sep.ZIndex = 3
Sep.Parent = Body
local SepGrad = Instance.new("UIGradient")
SepGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 0, 0)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
})
SepGrad.Parent = Sep
local Title = Instance.new("TextLabel")
Title.Text = "AHST"
Title.Size = UDim2.new(1, - 40, 0, 36)
Title.Position = UDim2.new(0, 20, 0, 104)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextStrokeColor3 = Color3.fromRGB(200, 0, 0)
Title.TextStrokeTransparency = 0.4
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.ZIndex = 3
Title.Parent = Body
local Subtitle = Instance.new("TextLabel")
Subtitle.Text = "Presentado por TheRealBanHammer"
Subtitle.Size = UDim2.new(1, - 40, 0, 22)
Subtitle.Position = UDim2.new(0, 20, 0, 140)
Subtitle.BackgroundTransparency = 1
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 13
Subtitle.TextColor3 = Color3.fromRGB(180, 60, 60)
Subtitle.TextXAlignment = Enum.TextXAlignment.Center
Subtitle.ZIndex = 3
Subtitle.Parent = Body
local TagLine = Instance.new("TextLabel")
TagLine.Text = "── x ──"
TagLine.Size = UDim2.new(1, 0, 0, 20)
TagLine.Position = UDim2.new(0, 0, 0, 166)
TagLine.BackgroundTransparency = 1
TagLine.Font = Enum.Font.Gotham
TagLine.TextSize = 12
TagLine.TextColor3 = Color3.fromRGB(120, 0, 0)
TagLine.TextXAlignment = Enum.TextXAlignment.Center
TagLine.ZIndex = 3
TagLine.Parent = Body
local ExecBtn = Instance.new("TextButton")
ExecBtn.Name = "ExecuteBtn"
ExecBtn.Size = UDim2.new(0, 200, 0, 46)
ExecBtn.Position = UDim2.new(0.5, - 100, 0, 198)
ExecBtn.BackgroundColor3 = Color3.fromRGB(160, 0, 0)
ExecBtn.Text = ""
ExecBtn.BorderSizePixel = 0
ExecBtn.AutoButtonColor = false
ExecBtn.ZIndex = 4
ExecBtn.Parent = Body
local ExecCorner = Instance.new("UICorner")
ExecCorner.CornerRadius = UDim.new(0, 6)
ExecCorner.Parent = ExecBtn
local ExecStroke = Instance.new("UIStroke")
ExecStroke.Color = Color3.fromRGB(220, 30, 30)
ExecStroke.Thickness = 1.5
ExecStroke.Transparency = 0.2
ExecStroke.Parent = ExecBtn
local ExecGradient = Instance.new("UIGradient")
ExecGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 10, 10)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(110, 0, 0)),
})
ExecGradient.Rotation = 90
ExecGradient.Parent = ExecBtn
local ExecLabel = Instance.new("TextLabel")
ExecLabel.Text = "Execute!"
ExecLabel.Size = UDim2.new(1, 0, 1, 0)
ExecLabel.BackgroundTransparency = 1
ExecLabel.Font = Enum.Font.GothamBold
ExecLabel.TextSize = 17
ExecLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecLabel.TextStrokeColor3 = Color3.fromRGB(120, 0, 0)
ExecLabel.TextStrokeTransparency = 0.6
ExecLabel.ZIndex = 5
ExecLabel.Parent = ExecBtn
ExecBtn.MouseEnter:Connect(function()
	TweenService:Create(ExecBtn, TweenInfo.new(0.15), {
		BackgroundColor3 = Color3.fromRGB(210, 0, 0),
		Size = UDim2.new(0, 208, 0, 46),
		Position = UDim2.new(0.5, - 104, 0, 198),
	}):Play()
	TweenService:Create(ExecStroke, TweenInfo.new(0.15), {
		Transparency = 0,
	}):Play()
end)
ExecBtn.MouseLeave:Connect(function()
	TweenService:Create(ExecBtn, TweenInfo.new(0.15), {
		BackgroundColor3 = Color3.fromRGB(160, 0, 0),
		Size = UDim2.new(0, 200, 0, 46),
		Position = UDim2.new(0.5, - 100, 0, 198),
	}):Play()
	TweenService:Create(ExecStroke, TweenInfo.new(0.15), {
		Transparency = 0.2,
	}):Play()
end)
ExecBtn.MouseButton1Down:Connect(function()
	TweenService:Create(ExecBtn, TweenInfo.new(0.08), {
		BackgroundColor3 = Color3.fromRGB(100, 0, 0),
		Size = UDim2.new(0, 194, 0, 44),
		Position = UDim2.new(0.5, - 97, 0, 199),
	}):Play()
end)
local function runScript()
	TweenService:Create(ExecBtn, TweenInfo.new(0.08), {
		BackgroundColor3 = Color3.fromRGB(210, 0, 0),
		Size = UDim2.new(0, 208, 0, 46),
		Position = UDim2.new(0.5, - 104, 0, 198),
	}):Play()
	ExecBtn.Active = false
	ExecLabel.Text = "Loading..."
	Subtitle.Text = "Loading TheRealBanHammer..."
	local ActiveRayfield = nil
	local executed, executeError = xpcall(function()
	local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/FloppHub-Team/UIs/refs/heads/main/RayField%20Version%20Cracked"))()
	ActiveRayfield = Rayfield
	local RayWindow = Rayfield:CreateWindow({
		Name = 'TheRealBanHammer | Muscle Legends',
		LoadingTitle = 'TheRealBanHammer',
		LoadingSubtitle = 'Muscle Legends',
		Theme = 'Default',
		ConfigurationSaving = {
			Enabled = false,
			FolderName = 'TheRealBanHammer',
			FileName = 'MuscleLegends',
		},
		Discord = {
			Enabled = false,
			Invite = '',
			RememberJoins = false,
		},
		KeySystem = false,
		DisableRayfieldPrompts = false,
	})
	local function preserveRayfieldGui()
		local roots = {
			PlayerGui,
		}
		pcall(function()
			table.insert(roots, game:GetService('CoreGui'))
		end)
		pcall(function()
			if gethui then
				table.insert(roots, gethui())
			end
		end)
		for _, root in ipairs(roots) do
			if root then
				if root:IsA('ScreenGui') and root.Name == 'Rayfield' then
					root.ResetOnSpawn = false
				end
				for _, object in ipairs(root:GetDescendants()) do
					if object:IsA('ScreenGui') and object.Name == 'Rayfield' then
						object.ResetOnSpawn = false
					end
				end
			end
		end
	end
	preserveRayfieldGui()
	ScreenGui.Enabled = false
	local RayFlagId = 0
	local function nextFlag(prefix)
		RayFlagId = RayFlagId + 1
		return 'TheRealBanHammer_' .. prefix .. '_' .. tostring(RayFlagId)
	end
	local function rayContainer(tab)
		local container = {}
		function container:Show()
		end
		function container:AddLabel(text)
			local value = tab:CreateLabel(tostring(text))
			local proxy = {}
			function proxy:Remove()
				value:Set('')
			end
			return setmetatable(proxy, {
				__index = function(target, key)
					if key == 'Text' then
						return rawget(target, '_Text')
					end
					return rawget(target, key)
				end,
				__newindex = function(target, key, newValue)
					if key == 'Text' then
						rawset(target, '_Text', newValue)
						value:Set(tostring(newValue))
					else
						rawset(target, key, newValue)
					end
				end,
			})
		end
		function container:AddButton(name, callback)
			return tab:CreateButton({
				Name = tostring(name),
				Callback = callback,
			})
		end
		function container:AddSwitch(name, callback)
			return tab:CreateToggle({
				Name = tostring(name),
				CurrentValue = false,
				Flag = nextFlag('Toggle'),
				Callback = callback,
			})
		end
		function container:AddTextBox(name, callback)
			return tab:CreateInput({
				Name = tostring(name),
				CurrentValue = '',
				PlaceholderText = tostring(name),
				RemoveTextAfterFocusLost = false,
				Flag = nextFlag('Input'),
				Callback = callback,
			})
		end
		function container:AddDropdown(name, callback)
			local options = {}
			local dropdown = tab:CreateDropdown({
				Name = tostring(name),
				Options = options,
				CurrentOption = {},
				MultipleOptions = false,
				Flag = nextFlag('Dropdown'),
				Callback = function(value)
					callback(type(value) == 'table' and value[1] or value)
				end,
			})
			local proxy = {}
			function proxy:Add(option)
				table.insert(options, option)
				dropdown:Refresh(options)
			end
			function proxy:Remove(option)
				for index = #options, 1, -1 do
					if options[index] == option then
						table.remove(options, index)
					end
				end
				dropdown:Refresh(options)
			end
			function proxy:Clear()
				table.clear(options)
				dropdown:Refresh(options)
			end
			function proxy:Set(option)
				dropdown:Set(option)
			end
			return proxy
		end
		function container:AddFolder(name)
			tab:CreateSection(tostring(name))
			return container
		end
		return container
	end
	local _EnchantedHubMuscleLegends = {}
	function _EnchantedHubMuscleLegends:AddTab(name)
		return rayContainer(RayWindow:CreateTab(tostring(name), 0))
	end
	local _Introduction = _EnchantedHubMuscleLegends:AddTab('Inicio')
	_Introduction:Show()
	_Introduction:AddLabel('Presentado por TheRealBanHammer').TextSize = 22
	_Introduction:AddLabel('Desarrollado por TheRealBanHammer').TextSize = 22
	_Introduction:AddLabel('Creditos del script: TheRealBanHammer').TextSize = 22
	_Introduction:AddLabel('Desliza las pestañas para ver más opciones').TextSize = 22
	_Introduction:AddLabel('AHST On Top').TextSize = 22
	_Introduction:AddButton('Desbloquear gamepasses', function()
		local _gamepassIds = game:GetService('ReplicatedStorage').gamepassIds
		local _LocalPlayer = game:GetService('Players').LocalPlayer
		local v23, v24, v25 = pairs(_gamepassIds:GetChildren())
		while true do
			local v26
			v25, v26 = v23(v24, v25)
			if v25 == nil then
				break
			end
			local _IntValue = Instance.new('IntValue')
			_IntValue.Name = v26.Name
			_IntValue.Value = v26.Value
			_IntValue.Parent = _LocalPlayer.ownedGamepasses
		end
	end)
	local _Rebirthing = _EnchantedHubMuscleLegends:AddTab('Renacimientos')
	_Rebirthing:Show();
	(function(p29)
		p29:AddSwitch('Fuerza automatica', function(p30)
			isAutoStrength = p30
			local _LocalPlayer2 = game.Players.LocalPlayer
			local function v36()
				while isAutoStrength do
					local _Backpack = _LocalPlayer2:FindFirstChild('Backpack')
					local v33 = _LocalPlayer2.Character or _LocalPlayer2.CharacterAdded:Wait()
					local _Humanoid = v33:FindFirstChild('Humanoid')
					local v35 = _Backpack and _Humanoid and (not v33:FindFirstChild('Weight') and _Backpack:FindFirstChild('Weight'))
					if v35 then
						_Humanoid:EquipTool(v35)
					end
					game:GetService('Players').LocalPlayer.muscleEvent:FireServer('rep')
					task.wait(0.1)
				end
			end
			if p30 then
				task.spawn(v36)
			end
		end):Set(false)
		p29:AddSwitch('Tamaño automatico 2', function(p37)
			sizeSpam = p37
			local function v38()
				while sizeSpam do
					game:GetService('ReplicatedStorage').rEvents.changeSpeedSizeRemote:InvokeServer('changeSize', 2)
					task.wait(0.1)
				end
			end
			if p37 then
				task.spawn(v38)
			end
		end):Set(false)
		p29:AddSwitch('Bloquear posicion', function(p39)
			lockPosition = p39
			local _LocalPlayer3 = game.Players.LocalPlayer
			local v41 = _LocalPlayer3.Character or _LocalPlayer3.CharacterAdded:Wait()
			local _Humanoid2 = v41:FindFirstChild('Humanoid')
			local _HumanoidRootPart = v41:FindFirstChild('HumanoidRootPart')
			if p39 and (_Humanoid2 and _HumanoidRootPart) then
				savedPosition = _HumanoidRootPart.Position
				_Humanoid2.WalkSpeed = 0
				task.spawn(function()
					while lockPosition do
						if (_HumanoidRootPart.Position - savedPosition).magnitude > 0.1 then
							_HumanoidRootPart.CFrame = CFrame.new(savedPosition)
						end
						task.wait(0.05)
					end
				end)
			elseif _Humanoid2 then
				_Humanoid2.WalkSpeed = 16
			end
		end):Set(false)
		p29:AddSwitch('Ir automaticamente al Rey', function(p44)
			if p44 then
				teleportLoop = task.spawn(function()
					while task.wait(0) do
						if game.Players.LocalPlayer.Character then
							game.Players.LocalPlayer.Character:MoveTo(Vector3.new(- 8646, 17, - 5738))
						end
					end
				end)
			elseif teleportLoop then
				task.cancel(teleportLoop)
				teleportLoop = nil
			end
		end)
		local u45 = false
		p29:AddSwitch('Renacimiento automatico (infinito)', function(p46)
			u45 = p46
			while u45 do
				game:GetService('ReplicatedStorage').rEvents.rebirthRemote:InvokeServer('rebirthRequest')
				wait(0.1)
			end
		end)
		local u47 = 0
		p29:AddTextBox('Limite de renacimientos', function(p48)
			u47 = tonumber(p48) or 0
		end)
		local u49 = false
		p29:AddSwitch('Renacer hasta el limite', function(p50)
			u49 = p50
			while u49 do
				local _leaderstats = game.Players.LocalPlayer:FindFirstChild('leaderstats')
				if _leaderstats then
					_leaderstats = _leaderstats:FindFirstChild('Rebirths')
				end
				if _leaderstats and u47 <= _leaderstats.Value then
					u49 = false
					break
				end
				game:GetService('ReplicatedStorage').rEvents.rebirthRemote:InvokeServer('rebirthRequest')
				wait(0.1)
			end
		end)
	end)(_Rebirthing)
	_Rebirthing:AddLabel('Renacimiento rapido:').TextSize = 22
	_Rebirthing:AddSwitch('Renacimiento rapido (requiere 7 packs)', function(p52)
		fastRebirth = p52
		if fastRebirth then
			spawn(function()
				local _ReplicatedStorage = game:GetService('ReplicatedStorage')
				local _LocalPlayer4 = game:GetService('Players').LocalPlayer
				local function u64(_)
					local _petsFolder = _LocalPlayer4.petsFolder
					local v56, v57, v58 = pairs(_petsFolder:GetChildren())
					while true do
						local v59
						v58, v59 = v56(v57, v58)
						if v58 == nil then
							break
						end
						if v59:IsA('Folder') then
							local v60, v61, v62 = pairs(v59:GetChildren())
							while true do
								local v63
								v62, v63 = v60(v61, v62)
								if v62 == nil then
									break
								end
								_ReplicatedStorage.rEvents.equipPetEvent:FireServer('unequipPet', v63)
							end
						end
					end
					task.wait(0.1)
				end
				local function v70(p65)
					u64()
					task.wait(0.01)
					local v66, v67, v68 = pairs(_LocalPlayer4.petsFolder.Unique:GetChildren())
					while true do
						local v69
						v68, v69 = v66(v67, v68)
						if v68 == nil then
							break
						end
						if v69.Name == p65 then
							_ReplicatedStorage.rEvents.equipPetEvent:FireServer('equipPet', v69)
						end
					end
				end
				local v71 = u64
				local function v78(p72)
					local v73 = workspace.machinesFolder:FindFirstChild(p72)
					if not v73 then
						local v74, v75, v76 = pairs(workspace:GetChildren())
						while true do
							local v77
							v76, v77 = v74(v75, v76)
							if v76 == nil then
								break
							end
							if v77:IsA('Folder') and v77.Name:find('machines') then
								v73 = v77:FindFirstChild(p72)
								if v73 then
									break
								end
							end
						end
					end
					return v73
				end
				local function v80()
					local _VirtualInputManager = game:GetService('VirtualInputManager')
					_VirtualInputManager:SendKeyEvent(true, 'E', false, game)
					task.wait(0.1)
					_VirtualInputManager:SendKeyEvent(false, 'E', false, game)
				end
				while fastRebirth do
					local v81 = 10000 + 5000 * _LocalPlayer4.leaderstats.Rebirths.Value
					if _LocalPlayer4.ultimatesFolder:FindFirstChild('Golden Rebirth') then
						local _Value = _LocalPlayer4.ultimatesFolder['Golden Rebirth'].Value
						v81 = math.floor(v81 * (1 - _Value * 0.1))
					end
					v71()
					task.wait(0.1)
					v70('Swift Samurai')
					while _LocalPlayer4.leaderstats.Strength.Value < v81 do
						for _ = 1, 15 do
							_LocalPlayer4.muscleEvent:FireServer('rep')
						end
						task.wait()
					end
					v71()
					task.wait(0.1)
					v70('Tribal Overlord')
					local _JungleBarLift = v78('Jungle Bar Lift')
					if _JungleBarLift and _JungleBarLift:FindFirstChild('interactSeat') then
						_LocalPlayer4.Character.HumanoidRootPart.CFrame = _JungleBarLift.interactSeat.CFrame * CFrame.new(0, 3, 0)
						repeat
							task.wait(0.1)
							v80()
						until _LocalPlayer4.Character.Humanoid.Sit
					end
					local _Value2 = _LocalPlayer4.leaderstats.Rebirths.Value
					repeat
						_ReplicatedStorage.rEvents.rebirthRemote:InvokeServer('rebirthRequest')
						task.wait(0.1)
					until _Value2 < _LocalPlayer4.leaderstats.Rebirths.Value
					task.wait()
				end
			end)
		end
	end)
	_Rebirthing:AddLabel('AVISO: no actives renacimiento rapido sin tener 7 packs.').TextSize = 22
	local _Teleport = _EnchantedHubMuscleLegends:AddTab('Teletransporte')
	_Teleport:Show()
	local u86 = nil
	local u87 = {
		['Isla Pequeña'] = CFrame.new(- 39.091819763183594, 5.9991278648376465, 1886.1307373046875),
		['Isla Helada'] = CFrame.new(- 2623.022216796875, 5.84573221206665, - 409.0733337402344),
		['Isla Mistica'] = CFrame.new(2250.778076171875, 5.844851970672607, 1073.2266845703125),
		['Isla Infernal'] = CFrame.new(- 6758.9638671875, 5.845746040344238, - 1284.918701171875),
		['Isla Leyenda'] = CFrame.new(4603.28173828125, 989.9984130859375, - 3897.86572265625),
		['Rey Musculo'] = CFrame.new(- 8625.9287109375, 15.695758819580078, - 5730.47216796875),
		['Isla Jungla Antigua'] = CFrame.new(- 8642.2529296875, 6.275508880615234, 2380.506591796875),
	}
	local _SelectTeleport = _Teleport:AddDropdown('Seleccionar destino', function(p88)
		u86 = u87[p88]
	end)
	_SelectTeleport:Add('Isla Pequeña')
	_SelectTeleport:Add('Isla Helada')
	_SelectTeleport:Add('Isla Mistica')
	_SelectTeleport:Add('Isla Infernal')
	_SelectTeleport:Add('Isla Leyenda')
	_SelectTeleport:Add('Rey Musculo')
	_SelectTeleport:Add('Isla Jungla Antigua')
	_Teleport:AddButton('Teletransportar', function()
		if u86 then
			local _LocalPlayer5 = game.Players.LocalPlayer;
			(_LocalPlayer5.Character or _LocalPlayer5.CharacterAdded:Wait()):SetPrimaryPartCFrame(u86)
		else
			warn('No se selecciono una ubicacion.')
		end
	end)
	local _Rocks = _EnchantedHubMuscleLegends:AddTab('Rocas')
	local u92 = nil
	_Rocks:AddSwitch('Golpe rapido (para glitch rapido)', function(p93)
		local _LocalPlayer6 = game.Players.LocalPlayer
		if p93 then
			_G.punchanim = true
			if u92 then
				u92:Disconnect()
			end
			u92 = game:GetService('RunService').Heartbeat:Connect(function()
				if _G.punchanim then
					local _Character = _LocalPlayer6.Character
					if _Character then
						local _Humanoid3 = _Character:FindFirstChildOfClass('Humanoid')
						local v97 = _LocalPlayer6.Backpack:FindFirstChild('Punch') or _Character:FindFirstChild('Punch')
						if v97 then
							local _attackTime = v97:FindFirstChild('attackTime')
							if _attackTime then
								_attackTime.Value = 0
							end
							if _Humanoid3 and v97.Parent ~= _Character then
								_Humanoid3:EquipTool(v97)
							end
							v97:Activate()
						end
					end
				else
					if u92 then
						u92:Disconnect()
						u92 = nil
					end
					return
				end
			end)
		else
			_G.punchanim = false
			if u92 then
				u92:Disconnect()
				u92 = nil
			end
			local _Punch = _LocalPlayer6.Backpack:FindFirstChild('Punch')
			local _Character2 = _LocalPlayer6.Character
			if _Character2 then
				_Character2 = _LocalPlayer6.Character:FindFirstChild('Punch')
			end
			local v101 = _Punch or _Character2
			if v101 and v101:FindFirstChild('attackTime') then
				v101.attackTime.Value = 0.35
			end
		end
	end)
	_Rocks:AddLabel('--------------')
	_Rocks:AddSwitch('Roca de Jungla Antigua', function(p102)
		if p102 then
			local _LocalPlayer7 = game.Players.LocalPlayer
			local _LeftHand = (_LocalPlayer7.Character or _LocalPlayer7.CharacterAdded:Wait()):WaitForChild('LeftHand')
			local _Rock = game.Workspace.machinesFolder:FindFirstChild('Ancient Jungle Rock'):FindFirstChild('Rock')
			_G.jungleautorock = true
			while _G.jungleautorock do
				if _Rock then
					_Rock.Size = Vector3.new(2, 1, 1)
					_Rock.Transparency = 1
					local v106, v107, v108 = pairs(_Rock.rockGui:GetChildren())
					while true do
						local v109
						v108, v109 = v106(v107, v108)
						if v108 == nil then
							break
						end
						v109.Visible = false
					end
					_Rock.CanCollide = false
					if _Rock:FindFirstChild('rockEmitter') then
						_Rock.rockEmitter:Destroy()
					end
					if _Rock:FindFirstChild('hoopParticle') then
						_Rock.hoopParticle:Destroy()
					end
					if _Rock:FindFirstChild('lavaParticle') then
						_Rock.lavaParticle:Destroy()
					end
					_Rock.CFrame = _LeftHand.CFrame
				else
					warn('Roca no encontrada.')
				end
				wait()
			end
		else
			local v115, _ = pcall(function()
				local _Rock2 = game.Workspace.machinesFolder:FindFirstChild('Ancient Jungle Rock'):FindFirstChild('Rock')
				_G.jungleautorock = false
				if _Rock2 then
					local v111, v112, v113 = pairs(_Rock2.rockGui:GetChildren())
					while true do
						local v114
						v113, v114 = v111(v112, v113)
						if v113 == nil then
							break
						end
						v114.Visible = true
					end
					_Rock2.CanCollide = true
					_Rock2.Transparency = 0
					_Rock2.CFrame = CFrame.new(_Rock2.originalPosition.Value)
					_Rock2.Size = Vector3.new(23.18409538269043, 20.20000648498535, 24.44658088684082)
				else
					warn('Roca no encontrada en Jungla Antigua.')
				end
			end)
			if not v115 then
				warn('Error turning Ancient Jungle Rock off.')
			end
		end
	end):Set(false)
	_Rocks:AddSwitch('Roca del Rey Musculo', function(p116)
		if p116 then
			local _LocalPlayer8 = game.Players.LocalPlayer
			local _LeftHand2 = (_LocalPlayer8.Character or _LocalPlayer8.CharacterAdded:Wait()):WaitForChild('LeftHand')
			local _Rock3 = game.Workspace.machinesFolder:FindFirstChild('Muscle King Mountain'):FindFirstChild('Rock')
			_G.musclekingautorock = true
			while _G.musclekingautorock do
				if _Rock3 then
					_Rock3.Size = Vector3.new(2, 1, 1)
					_Rock3.Transparency = 1
					local v120, v121, v122 = pairs(_Rock3.rockGui:GetChildren())
					while true do
						local v123
						v122, v123 = v120(v121, v122)
						if v122 == nil then
							break
						end
						v123.Visible = false
					end
					_Rock3.CanCollide = false
					if _Rock3:FindFirstChild('rockEmitter') then
						_Rock3.rockEmitter:Destroy()
					end
					if _Rock3:FindFirstChild('hoopParticle') then
						_Rock3.hoopParticle:Destroy()
					end
					if _Rock3:FindFirstChild('lavaParticle') then
						_Rock3.lavaParticle:Destroy()
					end
					_Rock3.CFrame = _LeftHand2.CFrame
				else
					warn('Roca no encontrada.')
				end
				wait()
			end
		else
			local _, _ = pcall(function()
				local _Rock4 = game.Workspace.machinesFolder:FindFirstChild('Muscle King Mountain'):FindFirstChild('Rock')
				_G.musclekingautorock = false
				if _Rock4 then
					local v125, v126, v127 = pairs(_Rock4.rockGui:GetChildren())
					while true do
						local v128
						v127, v128 = v125(v126, v127)
						if v127 == nil then
							break
						end
						v128.Visible = true
					end
					_Rock4.CanCollide = true
					_Rock4.Transparency = 0
					_Rock4.CFrame = CFrame.new(_Rock4.originalPosition.Value)
					_Rock4.Size = Vector3.new(141.97381591796875, 123.69998931884766, 149.70497131347656)
				else
					warn('Roca no encontrada en la montaña del Rey Musculo.')
				end
			end)
		end
	end):Set(false)
	_Rocks:AddSwitch('Roca de Leyendas', function(p129)
		if p129 then
			local _LocalPlayer9 = game.Players.LocalPlayer
			local _LeftHand3 = (_LocalPlayer9.Character or _LocalPlayer9.CharacterAdded:Wait()):WaitForChild('LeftHand')
			local _Rock5 = game.Workspace.machinesFolder:FindFirstChild('Rock Of Legends'):FindFirstChild('Rock')
			_G.legendsautorock = true
			while _G.legendsautorock do
				if _Rock5 then
					_Rock5.Size = Vector3.new(2, 1, 1)
					_Rock5.Transparency = 1
					local v133, v134, v135 = pairs(_Rock5.rockGui:GetChildren())
					while true do
						local v136
						v135, v136 = v133(v134, v135)
						if v135 == nil then
							break
						end
						v136.Visible = false
					end
					_Rock5.CanCollide = false
					if _Rock5:FindFirstChild('rockEmitter') then
						_Rock5.rockEmitter:Destroy()
					end
					if _Rock5:FindFirstChild('hoopParticle') then
						_Rock5.hoopParticle:Destroy()
					end
					if _Rock5:FindFirstChild('lavaParticle') then
						_Rock5.lavaParticle:Destroy()
					end
					_Rock5.CFrame = _LeftHand3.CFrame
				else
					warn('Roca no encontrada.')
				end
				wait()
			end
		else
			local _, _ = pcall(function()
				local _Rock6 = game.Workspace.machinesFolder:FindFirstChild('Rock Of Legends'):FindFirstChild('Rock')
				_G.legendsautorock = false
				if _Rock6 then
					local v138, v139, v140 = pairs(_Rock6.rockGui:GetChildren())
					while true do
						local v141
						v140, v141 = v138(v139, v140)
						if v140 == nil then
							break
						end
						v141.Visible = true
					end
					_Rock6.CanCollide = true
					_Rock6.Transparency = 0
					_Rock6.CFrame = CFrame.new(_Rock6.originalPosition.Value)
					_Rock6.Size = Vector3.new(106.04995727539063, 92.39998626708984, 111.82489013671875)
				else
					warn('Roca no encontrada.')
				end
			end)
		end
	end):Set(false)
	_Rocks:AddSwitch('Roca Infernal', function(p142)
		if p142 then
			local _LocalPlayer10 = game.Players.LocalPlayer
			local _LeftHand4 = (_LocalPlayer10.Character or _LocalPlayer10.CharacterAdded:Wait()):WaitForChild('LeftHand')
			local _Rock7 = game.Workspace.machinesFolder:FindFirstChild('Inferno Rock'):FindFirstChild('Rock')
			_G.infernoautorock = true
			while _G.infernoautorock do
				if _Rock7 then
					_Rock7.Size = Vector3.new(2, 1, 1)
					_Rock7.Transparency = 1
					local v146, v147, v148 = pairs(_Rock7.rockGui:GetChildren())
					while true do
						local v149
						v148, v149 = v146(v147, v148)
						if v148 == nil then
							break
						end
						v149.Visible = false
					end
					_Rock7.CanCollide = false
					if _Rock7:FindFirstChild('rockEmitter') then
						_Rock7.rockEmitter:Destroy()
					end
					if _Rock7:FindFirstChild('hoopParticle') then
						_Rock7.hoopParticle:Destroy()
					end
					if _Rock7:FindFirstChild('lavaParticle') then
						_Rock7.lavaParticle:Destroy()
					end
					_Rock7.CFrame = _LeftHand4.CFrame
				else
					warn('Roca no encontrada.')
				end
				wait()
			end
		else
			local _, _ = pcall(function()
				local _Rock8 = game.Workspace.machinesFolder:FindFirstChild('Inferno Rock'):FindFirstChild('Rock')
				_G.infernoautorock = false
				if _Rock8 then
					local v151, v152, v153 = pairs(_Rock8.rockGui:GetChildren())
					while true do
						local v154
						v153, v154 = v151(v152, v153)
						if v153 == nil then
							break
						end
						v154.Visible = true
					end
					_Rock8.CanCollide = true
					_Rock8.Transparency = 0
					_Rock8.CFrame = CFrame.new(_Rock8.originalPosition.Value)
					_Rock8.Size = Vector3.new(80.6851577758789, 70.2999496459961, 85.07884979248047)
				else
					warn('Roca no encontrada en la montaña del Rey Musculo.')
				end
			end)
		end
	end):Set(false)
	_Rocks:AddSwitch('Roca Mistica', function(p155)
		if p155 then
			local _LocalPlayer11 = game.Players.LocalPlayer
			local _LeftHand5 = (_LocalPlayer11.Character or _LocalPlayer11.CharacterAdded:Wait()):WaitForChild('LeftHand')
			local _Rock9 = game.Workspace.machinesFolder:FindFirstChild('Mystic Rock'):FindFirstChild('Rock')
			_G.mysticautorock = true
			while _G.mysticautorock do
				if _Rock9 then
					_Rock9.Size = Vector3.new(2, 1, 1)
					_Rock9.Transparency = 1
					local v159, v160, v161 = pairs(_Rock9.rockGui:GetChildren())
					while true do
						local v162
						v161, v162 = v159(v160, v161)
						if v161 == nil then
							break
						end
						v162.Visible = false
					end
					_Rock9.CanCollide = false
					if _Rock9:FindFirstChild('rockEmitter') then
						_Rock9.rockEmitter:Destroy()
					end
					if _Rock9:FindFirstChild('hoopParticle') then
						_Rock9.hoopParticle:Destroy()
					end
					if _Rock9:FindFirstChild('lavaParticle') then
						_Rock9.lavaParticle:Destroy()
					end
					_Rock9.CFrame = _LeftHand5.CFrame
				else
					warn('Roca no encontrada.')
				end
				wait()
			end
		else
			local _, _ = pcall(function()
				local _Rock10 = game.Workspace.machinesFolder:FindFirstChild('Mystic Rock'):FindFirstChild('Rock')
				_G.mysticautorock = false
				if _Rock10 then
					local v164, v165, v166 = pairs(_Rock10.rockGui:GetChildren())
					while true do
						local v167
						v166, v167 = v164(v165, v166)
						if v166 == nil then
							break
						end
						v167.Visible = true
					end
					_Rock10.CanCollide = true
					_Rock10.Transparency = 0
					_Rock10.CFrame = CFrame.new(_Rock10.originalPosition.Value)
					_Rock10.Size = Vector3.new(106.04995727539063, 92.39998626708984, 111.82489013671875)
				else
					warn('Roca no encontrada en la montaña del Rey Musculo.')
				end
			end)
		end
	end):Set(false)
	_Rocks:AddSwitch('Roca Congelada', function(p168)
		local _LocalPlayer12 = game.Players.LocalPlayer
		local _LeftHand6 = (_LocalPlayer12.Character or _LocalPlayer12.CharacterAdded:Wait()):WaitForChild('LeftHand')
		local _Rock11 = game.Workspace.machinesFolder:FindFirstChild('Frozen Rock'):FindFirstChild('Rock')
		if p168 then
			_G.frozenautorock = true
			while _G.frozenautorock do
				if _Rock11 then
					_Rock11.Size = Vector3.new(2, 1, 1)
					_Rock11.Transparency = 1
					_Rock11.CanCollide = false
					local v172, v173, v174 = pairs(_Rock11.rockGui:GetChildren())
					while true do
						local v175
						v174, v175 = v172(v173, v174)
						if v174 == nil then
							break
						end
						v175.Visible = false
					end
					local v176, v177, v178 = ipairs({
						'rockEmitter',
						'hoopParticle',
						'lavaParticle',
					})
					while true do
						local v179
						v178, v179 = v176(v177, v178)
						if v178 == nil then
							break
						end
						if _Rock11:FindFirstChild(v179) then
							_Rock11[v179]:Destroy()
						end
					end
					_Rock11.CFrame = _LeftHand6.CFrame
				else
					warn('Roca congelada no encontrada.')
				end
				wait()
			end
		else
			_G.frozenautorock = false
			pcall(function()
				if _Rock11 then
					local v180, v181, v182 = pairs(_Rock11.rockGui:GetChildren())
					while true do
						local v183
						v182, v183 = v180(v181, v182)
						if v182 == nil then
							break
						end
						v183.Visible = true
					end
					_Rock11.CanCollide = true
					_Rock11.Transparency = 0
					_Rock11.Size = Vector3.new(80.6851577758789, 70.2999496459961, 85.07884979248047)
					_Rock11.CFrame = CFrame.new(_Rock11.originalPosition.Value)
				else
					warn('Roca congelada no encontrada en la montaña del Rey Musculo.')
				end
			end)
		end
	end):Set(false)
	local _TinyRock = _Rocks:AddSwitch('Roca Pequeña', function(p184)
		if p184 then
			local _LocalPlayer13 = game.Players.LocalPlayer
			local _LeftHand7 = (_LocalPlayer13.Character or _LocalPlayer13.CharacterAdded:Wait()):WaitForChild('LeftHand')
			local _Rock12 = game.Workspace.machinesFolder:FindFirstChild('Tiny Rock'):FindFirstChild('Rock')
			_G.tinyautorock = true
			while _G.tinyautorock do
				if _Rock12 then
					_Rock12.Size = Vector3.new(2, 1, 1)
					_Rock12.Transparency = 1
					_Rock12.CanCollide = false
					local v188, v189, v190 = pairs(_Rock12.rockGui:GetChildren())
					while true do
						local v191
						v190, v191 = v188(v189, v190)
						if v190 == nil then
							break
						end
						v191.Visible = false
					end
					local v192, v193, v194 = ipairs({
						'rockEmitter',
						'hoopParticle',
						'lavaParticle',
					})
					while true do
						local v195
						v194, v195 = v192(v193, v194)
						if v194 == nil then
							break
						end
						if _Rock12:FindFirstChild(v195) then
							_Rock12[v195]:Destroy()
						end
					end
					_Rock12.CFrame = _LeftHand7.CFrame
				else
					warn('Roca pequeña no encontrada.')
				end
				wait()
			end
		else
			_G.tinyautorock = false
			pcall(function()
				local _Rock13 = game.Workspace.machinesFolder:FindFirstChild('Tiny Rock'):FindFirstChild('Rock')
				if _Rock13 then
					local v197, v198, v199 = pairs(_Rock13.rockGui:GetChildren())
					while true do
						local v200
						v199, v200 = v197(v198, v199)
						if v199 == nil then
							break
						end
						v200.Visible = true
					end
					_Rock13.CanCollide = true
					_Rock13.Transparency = 0
					_Rock13.Size = Vector3.new(23.18409538269043, 20.20000648498535, 24.44658088684082)
					_Rock13.CFrame = CFrame.new(_Rock13.originalPosition.Value)
				else
					warn('Roca pequeña no encontrada en la montaña del Rey Musculo.')
				end
			end)
		end
	end)
	_TinyRock:Set(false)
	_Rocks:AddLabel('Rocas V2:').TextSize = 22
	(function(p202)
		local function u207()
			local v203, v204, v205 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())
			while true do
				local v206
				v205, v206 = v203(v204, v205)
				if v205 == nil then
					break
				end
				if v206.Name == 'Punch' and game.Players.LocalPlayer.Character:FindFirstChild('Humanoid') then
					game.Players.LocalPlayer.Character.Humanoid:EquipTool(v206)
				end
			end
			game:GetService('Players').LocalPlayer.muscleEvent:FireServer('punch', 'leftHand')
			game:GetService('Players').LocalPlayer.muscleEvent:FireServer('punch', 'rightHand')
		end
		local u208 = {
			['Tiny Rock'] = {
				Name = 'Tiny Island Rock',
				Durability = 0,
			},
			['Starter Rock'] = {
				Name = 'Starter Island Rock',
				Durability = 100,
			},
			['Legend Beach Rock'] = {
				Name = 'Legend Beach Rock',
				Durability = 5000,
			},
			['Frozen Rock'] = {
				Name = 'Frost Gym Rock',
				Durability = 150000,
			},
			['Mythical Rock'] = {
				Name = 'Mythical Gym Rock',
				Durability = 400000,
			},
			['Eternal Rock'] = {
				Name = 'Eternal Gym Rock',
				Durability = 750000,
			},
			['Legend Rock'] = {
				Name = 'Legend Gym Rock',
				Durability = 1000000,
			},
			['Muscle King Rock'] = {
				Name = 'Muscle King Gym Rock',
				Durability = 5000000,
			},
			['Jungle Rock'] = {
				Name = 'Ancient Jungle Rock',
				Durability = 10000000,
			},
		}
		local u209 = nil
		local _SelectRock = _Rocks:AddDropdown('Seleccionar roca', function(p210)
			u209 = p210
		end)
		local v212, v213, v214 = pairs(u208)
		local u215 = u209
		while true do
			local v216
			v214, v216 = v212(v213, v214)
			if v214 == nil then
				break
			end
			_SelectRock:Add(v214)
		end
		_Rocks:AddSwitch('Farmear la roca', function(p217)
			getgenv().autoFarm = p217
			task.spawn(function()
				while getgenv().autoFarm do
					task.wait()
					if not (getgenv().autoFarm and u215) then
						break
					end
					local v218 = u208[u215]
					if v218 and game:GetService('Players').LocalPlayer.Durability.Value >= v218.Durability then
						local v219, v220, v221 = pairs(game:GetService('Workspace').machinesFolder:GetDescendants())
						while true do
							local v222
							v221, v222 = v219(v220, v221)
							if v221 == nil then
								break
							end
							if v222.Name == 'neededDurability' and v222.Value == v218.Durability and (game.Players.LocalPlayer.Character:FindFirstChild('LeftHand') and game.Players.LocalPlayer.Character:FindFirstChild('RightHand')) then
								firetouchinterest(v222.Parent.Rock, game:GetService('Players').LocalPlayer.Character.RightHand, 0)
								firetouchinterest(v222.Parent.Rock, game:GetService('Players').LocalPlayer.Character.RightHand, 1)
								firetouchinterest(v222.Parent.Rock, game:GetService('Players').LocalPlayer.Character.LeftHand, 0)
								firetouchinterest(v222.Parent.Rock, game:GetService('Players').LocalPlayer.Character.LeftHand, 1)
								u207()
							end
						end
					end
				end
			end)
		end)
	end)(_Rocks)
	_Rocks:AddLabel('--------------');
	(function(p223)
		local function u228()
			local v224, v225, v226 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())
			while true do
				local v227
				v226, v227 = v224(v225, v226)
				if v226 == nil then
					break
				end
				if v227.Name == 'Punch' and game.Players.LocalPlayer.Character:FindFirstChild('Humanoid') then
					game.Players.LocalPlayer.Character.Humanoid:EquipTool(v227)
				end
			end
			game:GetService('Players').LocalPlayer.muscleEvent:FireServer('punch', 'leftHand')
			game:GetService('Players').LocalPlayer.muscleEvent:FireServer('punch', 'rightHand')
		end
		local u229 = {
			['Tiny Rock'] = {
				Name = 'Tiny Island Rock',
				Durability = 0,
			},
			['Starter Rock'] = {
				Name = 'Starter Island Rock',
				Durability = 100,
			},
			['Legend Beach Rock'] = {
				Name = 'Legend Beach Rock',
				Durability = 5000,
			},
			['Frozen Rock'] = {
				Name = 'Frost Gym Rock',
				Durability = 150000,
			},
			['Mythical Rock'] = {
				Name = 'Mythical Gym Rock',
				Durability = 400000,
			},
			['Eternal Rock'] = {
				Name = 'Eternal Gym Rock',
				Durability = 750000,
			},
			['Legend Rock'] = {
				Name = 'Legend Gym Rock',
				Durability = 1000000,
			},
			['Muscle King Rock'] = {
				Name = 'Muscle King Gym Rock',
				Durability = 5000000,
			},
			['Jungle Rock'] = {
				Name = 'Ancient Jungle Rock',
				Durability = 10000000,
			},
		}
		local u230 = nil
		local _SelectRock2 = _Rocks:AddDropdown('Seleccionar roca', function(p231)
			u230 = p231
		end)
		local v233, v234, v235 = pairs(u229)
		local u236 = u230
		while true do
			local v237
			v235, v237 = v233(v234, v235)
			if v235 == nil then
				break
			end
			_SelectRock2:Add(v235)
		end
		_Rocks:AddSwitch('Iniciar farmeo', function(p238)
			getgenv().autoFarm = p238
			task.spawn(function()
				while getgenv().autoFarm do
					task.wait()
					if not (getgenv().autoFarm and u236) then
						break
					end
					local v239 = u229[u236]
					if v239 and game:GetService('Players').LocalPlayer.Durability.Value >= v239.Durability then
						local v240, v241, v242 = pairs(game:GetService('Workspace').machinesFolder:GetDescendants())
						while true do
							local v243
							v242, v243 = v240(v241, v242)
							if v242 == nil then
								break
							end
							if v243.Name == 'neededDurability' and v243.Value == v239.Durability and (game.Players.LocalPlayer.Character:FindFirstChild('LeftHand') and game.Players.LocalPlayer.Character:FindFirstChild('RightHand')) then
								firetouchinterest(v243.Parent.Rock, game:GetService('Players').LocalPlayer.Character.RightHand, 0)
								firetouchinterest(v243.Parent.Rock, game:GetService('Players').LocalPlayer.Character.RightHand, 1)
								firetouchinterest(v243.Parent.Rock, game:GetService('Players').LocalPlayer.Character.LeftHand, 0)
								firetouchinterest(v243.Parent.Rock, game:GetService('Players').LocalPlayer.Character.LeftHand, 1)
								u228()
							end
						end
					end
				end
			end)
		end)
	end)(_Rocks)
	local _FarmV1 = _EnchantedHubMuscleLegends:AddTab('Farmeo V1');
	(function(p245)
		getgenv().working = false
		_G.selectedBenchPress = 'Starter Island'
		_G.selectedSquat = 'Starter Island'
		local function u247()
			local _VirtualInputManager2 = game:GetService('VirtualInputManager')
			_VirtualInputManager2:SendKeyEvent(true, 'E', false, game)
			task.wait(0.1)
			_VirtualInputManager2:SendKeyEvent(false, 'E', false, game)
		end
		local function u248()
			while getgenv().working and task.wait() do
				game:GetService('Players').LocalPlayer.muscleEvent:FireServer('rep')
			end
		end
		local u249 = {
			['Bench Press'] = {
				['Starter Island'] = CFrame.new(- 17, 3.3, - 2),
				['Legend Beach'] = CFrame.new(470, 3.3, - 321),
				['Frost Gym'] = CFrame.new(- 3013, 39, - 335),
				['Mythical Gym'] = CFrame.new(2371, 39, 1246),
				['Eternal Gym'] = CFrame.new(- 7176, 45, - 1106),
				['Legend Gym'] = CFrame.new(4111, 1020, - 3799),
				['Muscle King Gym'] = CFrame.new(- 8590, 46, - 6043),
				['Jungle Gym'] = CFrame.new(- 8173, 64, 1898),
			},
			Squat = {
				['Starter Island'] = CFrame.new(- 48, 3.3, - 11),
				['Legend Beach'] = CFrame.new(470, 3.3, - 321),
				['Frost Gym'] = CFrame.new(- 2933, 29, - 579),
				['Mythical Gym'] = CFrame.new(2489, 3.6, 849),
				['Eternal Gym'] = CFrame.new(- 7176, 45, - 1106),
				['Legend Gym'] = CFrame.new(4304, 987, - 4124),
				['Muscle King Gym'] = CFrame.new(- 8940, 13, - 5699),
				['Jungle Gym'] = CFrame.new(- 8352, 34, 2878),
			},
		}
		local function u254(p250, p251)
			local v252 = u249[p250][p251]
			local _Character3 = game.Players.LocalPlayer.Character
			if v252 and (_Character3 and _Character3:FindFirstChild('HumanoidRootPart')) then
				_Character3.HumanoidRootPart.CFrame = v252
				task.wait(0.5)
				getgenv().working = true
				u247()
				task.spawn(u248)
			end
		end
		local v255 = {
			'Bench Press',
			'Squat',
		}
		local v256, v257, v258 = ipairs(v255)
		local u259 = u249
		local v260 = {
			'Starter Island',
			'Legend Beach',
			'Frost Gym',
			'Mythical Gym',
			'Eternal Gym',
			'Legend Gym',
			'Muscle King Gym',
			'Jungle Gym',
		}
		while true do
			local u261
			v258, u261 = v256(v257, v258)
			if v258 == nil then
				break
			end
			local v263 = p245:AddDropdown('Seleccionar ubicacion: ' .. u261, function(p262)
				_G['selected' .. u261] = p262
			end)
			local v264, v265, v266 = ipairs(v260)
			while true do
				local v267
				v266, v267 = v264(v265, v266)
				if v266 == nil then
					break
				end
				v263:Add(v267)
			end
		end
		local v268, v269, v270 = ipairs(v255)
		while true do
			local u271
			v270, u271 = v268(v269, v270)
			if v270 == nil then
				break
			end
			_FarmV1:AddButton('Ir a ' .. u271, function()
				local v272 = _G['selected' .. u271]
				if v272 and u259[u271][v272] then
					u254(u271, v272)
				end
			end)
		end
		_FarmV1:AddLabel('----------').TextSize = 22
		_FarmV1:AddTextBox('Velocidad de repeticiones', function(p273)
			local v274 = tonumber(p273)
			if v274 and 0 < v274 then
				getgenv().ThreadCount = v274
				print('Thread count set to:', v274)
			else
				warn('Invalid number of threads entered.')
			end
		end)
		_FarmV1:AddSwitch('Empezar a ganar fuerza', function(p275)
			getgenv().isGrinding = p275
			if p275 then
				for _ = 1, getgenv().ThreadCount do
					task.spawn(function()
						while getgenv().isGrinding do
							local v276, v277 = pcall(function()
								game:GetService('Players').LocalPlayer.muscleEvent:FireServer('rep')
							end)
							if not v276 then
								warn('Fallo al ejecutar repeticion:', v277)
							end
							task.wait(0.01)
						end
					end)
				end
			end
		end)
		_FarmV1:AddButton('Reducir lag', function()
			local _LocalPlayer14 = game.Players.LocalPlayer
			local _PlayerGui = _LocalPlayer14:WaitForChild('PlayerGui')
			local _Lighting = game:GetService('Lighting')
			local v281, v282, v283 = pairs(_PlayerGui:GetChildren())
			while true do
				local v284
				v283, v284 = v281(v282, v283)
				if v283 == nil then
					break
				end
				if v284:IsA('ScreenGui') then
					v284:Destroy()
				end
			end
			(function()
				local v285, v286, v287 = pairs(workspace:GetDescendants())
				while true do
					local v288
					v287, v288 = v285(v286, v287)
					if v287 == nil then
						break
					end
					if v288:IsA('ParticleEmitter') then
						v288:Destroy()
					end
				end
			end)();
			(function()
				local v289, v290, v291 = pairs(workspace:GetDescendants())
				while true do
					local v292
					v291, v292 = v289(v290, v291)
					if v291 == nil then
						break
					end
					if v292:IsA('PointLight') or (v292:IsA('SpotLight') or v292:IsA('SurfaceLight')) then
						v292:Destroy()
					end
				end
			end)();
			(function()
				local v293 = _Lighting
				local v294, v295, v296 = pairs(v293:GetChildren())
				while true do
					local v297
					v296, v297 = v294(v295, v296)
					if v296 == nil then
						break
					end
					if v297:IsA('Sky') then
						v297:Destroy()
					end
				end
				local _Sky = Instance.new('Sky')
				_Sky.Name = 'DarkSky'
				_Sky.SkyboxBk = 'rbxassetid://0'
				_Sky.SkyboxDn = 'rbxassetid://0'
				_Sky.SkyboxFt = 'rbxassetid://0'
				_Sky.SkyboxLf = 'rbxassetid://0'
				_Sky.SkyboxRt = 'rbxassetid://0'
				_Sky.SkyboxUp = 'rbxassetid://0'
				_Sky.Parent = _Lighting
				_Lighting.Brightness = 0
				_Lighting.ClockTime = 0
				_Lighting.TimeOfDay = '00:00:00'
				_Lighting.OutdoorAmbient = Color3.new(0, 0, 0)
				_Lighting.Ambient = Color3.new(0, 0, 0)
				_Lighting.FogColor = Color3.new(0, 0, 0)
				_Lighting.FogEnd = 100
				task.spawn(function()
					while true do
						wait(5)
						if not _Lighting:FindFirstChild('DarkSky') then
							_Sky:Clone().Parent = _Lighting
						end
						_Lighting.Brightness = 0
						_Lighting.ClockTime = 0
						_Lighting.OutdoorAmbient = Color3.new(0, 0, 0)
						_Lighting.Ambient = Color3.new(0, 0, 0)
						_Lighting.FogColor = Color3.new(0, 0, 0)
						_Lighting.FogEnd = 100
					end
				end)
			end)()
		end)
		_FarmV1:AddLabel('---------------')
		local _VirtualInputManager3 = game:GetService('VirtualInputManager')
		_FarmV1:AddButton('Isla Pequeña', function()
			local _LocalPlayer15 = game.Players.LocalPlayer;
			(_LocalPlayer15.Character or _LocalPlayer15.CharacterAdded:Wait()):WaitForChild('HumanoidRootPart').CFrame = CFrame.new(- 37.1, 9.2, 1919)
		end)
		_FarmV1:AddButton('Isla Principal', function()
			local _LocalPlayer16 = game.Players.LocalPlayer;
			(_LocalPlayer16.Character or _LocalPlayer16.CharacterAdded:Wait()):WaitForChild('HumanoidRootPart').CFrame = CFrame.new(16.07, 9.08, 133.8)
		end)
		_FarmV1:AddButton('Playa', function()
			local _LocalPlayer17 = game.Players.LocalPlayer;
			(_LocalPlayer17.Character or _LocalPlayer17.CharacterAdded:Wait()):WaitForChild('HumanoidRootPart').CFrame = CFrame.new(- 8, 9, - 169.2)
		end)
		_FarmV1:AddButton('Gimnasio Rey Musculo', function()
			local _LocalPlayer18 = game.Players.LocalPlayer;
			(_LocalPlayer18.Character or _LocalPlayer18.CharacterAdded:Wait()):WaitForChild('HumanoidRootPart').CFrame = CFrame.new(- 8665.4, 17.21, - 5792.9)
		end)
		_FarmV1:AddButton('Gimnasio Jungla', function()
			local _LocalPlayer19 = game.Players.LocalPlayer;
			(_LocalPlayer19.Character or _LocalPlayer19.CharacterAdded:Wait()):WaitForChild('HumanoidRootPart').CFrame = CFrame.new(- 8543, 6.8, 2400)
		end)
		_FarmV1:AddButton('Gimnasio Leyendas', function()
			local _LocalPlayer20 = game.Players.LocalPlayer;
			(_LocalPlayer20.Character or _LocalPlayer20.CharacterAdded:Wait()):WaitForChild('HumanoidRootPart').CFrame = CFrame.new(4516, 991.5, - 3856)
		end)
		_FarmV1:AddButton('Gimnasio Infernal', function()
			local _LocalPlayer21 = game.Players.LocalPlayer;
			(_LocalPlayer21.Character or _LocalPlayer21.CharacterAdded:Wait()):WaitForChild('HumanoidRootPart').CFrame = CFrame.new(- 6759, 7.36, - 1284)
		end)
		_FarmV1:AddButton('Gimnasio Mistico', function()
			local _LocalPlayer22 = game.Players.LocalPlayer;
			(_LocalPlayer22.Character or _LocalPlayer22.CharacterAdded:Wait()):WaitForChild('HumanoidRootPart').CFrame = CFrame.new(2250, 7.37, 1073.2)
		end)
		_FarmV1:AddButton('Gimnasio Helado', function()
			local _LocalPlayer23 = game.Players.LocalPlayer;
			(_LocalPlayer23.Character or _LocalPlayer23.CharacterAdded:Wait()):WaitForChild('HumanoidRootPart').CFrame = CFrame.new(- 2623, 7.36, - 409)
		end)
		_FarmV1:AddButton('Levantamiento Jungla', function()
			local _LocalPlayer24 = game.Players.LocalPlayer;
			(_LocalPlayer24.Character or _LocalPlayer24.CharacterAdded:Wait()):WaitForChild('HumanoidRootPart').CFrame = CFrame.new(- 8642.396484375, 6.7980651855, 2086.1030273)
			task.wait(0.2)
			_VirtualInputManager3:SendKeyEvent(true, Enum.KeyCode.E, false, game)
			task.wait(0.05)
			_VirtualInputManager3:SendKeyEvent(false, Enum.KeyCode.E, false, game)
		end)
		_FarmV1:AddButton('Sentadilla Jungla', function()
			local _LocalPlayer25 = game.Players.LocalPlayer;
			(_LocalPlayer25.Character or _LocalPlayer25.CharacterAdded:Wait()):WaitForChild('HumanoidRootPart').CFrame = CFrame.new(- 8371.43359375, 6.79806327, 2858.8852539)
			task.wait(0.2)
			_VirtualInputManager3:SendKeyEvent(true, Enum.KeyCode.E, false, game)
			task.wait(0.05)
			_VirtualInputManager3:SendKeyEvent(false, Enum.KeyCode.E, false, game)
		end)
		_FarmV1:AddButton('Levantamiento Rey', function()
			local _LocalPlayer26 = game.Players.LocalPlayer;
			(_LocalPlayer26.Character or _LocalPlayer26.CharacterAdded:Wait()):WaitForChild('HumanoidRootPart').CFrame = CFrame.new(- 8769.083, 17.219, - 5665.84228)
			task.wait(0.2)
			_VirtualInputManager3:SendKeyEvent(true, Enum.KeyCode.E, false, game)
			task.wait(0.05)
			_VirtualInputManager3:SendKeyEvent(false, Enum.KeyCode.E, false, game)
		end)
		_FarmV1:AddButton('Sentadilla Rey', function()
			local _LocalPlayer27 = game.Players.LocalPlayer;
			(_LocalPlayer27.Character or _LocalPlayer27.CharacterAdded:Wait()):WaitForChild('HumanoidRootPart').CFrame = CFrame.new(- 8762.1689, 17.219, - 6044.0498)
			task.wait(0.2)
			_VirtualInputManager3:SendKeyEvent(true, Enum.KeyCode.E, false, game)
			task.wait(0.05)
			_VirtualInputManager3:SendKeyEvent(false, Enum.KeyCode.E, false, game)
		end)
		_FarmV1:AddButton('Levantamiento Leyendas', function()
			local _LocalPlayer28 = game.Players.LocalPlayer;
			(_LocalPlayer28.Character or _LocalPlayer28.CharacterAdded:Wait()):WaitForChild('HumanoidRootPart').CFrame = CFrame.new(4528.474609375, 989.0000629425, - 4001.05151367)
			task.wait(0.2)
			_VirtualInputManager3:SendKeyEvent(true, Enum.KeyCode.E, false, game)
			task.wait(0.05)
			_VirtualInputManager3:SendKeyEvent(false, Enum.KeyCode.E, false, game)
		end)
		_FarmV1:AddButton('Sentadilla Leyendas', function()
			local _LocalPlayer29 = game.Players.LocalPlayer;
			(_LocalPlayer29.Character or _LocalPlayer29.CharacterAdded:Wait()):WaitForChild('HumanoidRootPart').CFrame = CFrame.new(4431.306152, 991.5455322, - 4051.4296)
			task.wait(0.2)
			_VirtualInputManager3:SendKeyEvent(true, Enum.KeyCode.E, false, game)
			task.wait(0.05)
			_VirtualInputManager3:SendKeyEvent(false, Enum.KeyCode.E, false, game)
		end)
		_FarmV1:AddButton('Dominada Leyendas', function()
			local _LocalPlayer30 = game.Players.LocalPlayer;
			(_LocalPlayer30.Character or _LocalPlayer30.CharacterAdded:Wait()):WaitForChild('HumanoidRootPart').CFrame = CFrame.new(4298.6323, 991.5404, - 4119.97363)
			task.wait(0.2)
			_VirtualInputManager3:SendKeyEvent(true, Enum.KeyCode.E, false, game)
			task.wait(0.05)
			_VirtualInputManager3:SendKeyEvent(false, Enum.KeyCode.E, false, game)
		end)
		_FarmV1:AddLabel('Farmeo con inventario:').TextSize = 22
		_FarmV1:AddSwitch('Flexiones automaticas', function(p316)
			isAutoPushups = p316
			local _LocalPlayer31 = game.Players.LocalPlayer
			local _Backpack2 = _LocalPlayer31:FindFirstChild('Backpack')
			while isAutoPushups do
				wait(0.01)
				local v319 = _Backpack2 and _Backpack2:FindFirstChild('Pushups')
				if v319 then
					_LocalPlayer31.Character.Humanoid:EquipTool(v319)
				end
				game:GetService('Players').LocalPlayer.muscleEvent:FireServer(unpack({
					'rep',
				}))
			end
			if not isAutoPushups then
				local _Tool = _LocalPlayer31.Character:FindFirstChildOfClass('Tool')
				if _Tool and _Tool.Name == 'Pushups' then
					_Tool.Parent = _Backpack2
				end
			end
		end):Set(false)
		_FarmV1:AddSwitch('Abdominales automaticos', function(p321)
			isAutoSitups = p321
			local _LocalPlayer32 = game.Players.LocalPlayer
			local _Backpack3 = _LocalPlayer32:FindFirstChild('Backpack')
			while isAutoSitups do
				wait(0.01)
				local v324 = _Backpack3 and _Backpack3:FindFirstChild('Situps')
				if v324 then
					_LocalPlayer32.Character.Humanoid:EquipTool(v324)
				end
				game:GetService('Players').LocalPlayer.muscleEvent:FireServer(unpack({
					'rep',
				}))
			end
			if not isAutoSitups then
				local _Tool2 = _LocalPlayer32.Character:FindFirstChildOfClass('Tool')
				if _Tool2 and _Tool2.Name == 'Situps' then
					_Tool2.Parent = _Backpack3
				end
			end
		end):Set(false)
		_FarmV1:AddSwitch('Paradas de manos automaticas', function(p326)
			isAutoHandstands = p326
			local _LocalPlayer33 = game.Players.LocalPlayer
			local _Backpack4 = _LocalPlayer33:FindFirstChild('Backpack')
			while isAutoHandstands do
				wait(0.01)
				local v329 = _Backpack4 and _Backpack4:FindFirstChild('Handstands')
				if v329 then
					_LocalPlayer33.Character.Humanoid:EquipTool(v329)
				end
				game:GetService('Players').LocalPlayer.muscleEvent:FireServer(unpack({
					'rep',
				}))
			end
			if not isAutoHandstands then
				local _Tool3 = _LocalPlayer33.Character:FindFirstChildOfClass('Tool')
				if _Tool3 and _Tool3.Name == 'Handstands' then
					_Tool3.Parent = _Backpack4
				end
			end
		end):Set(false)
		_FarmV1:AddLabel('Farmeos OP:').TextSize = 22
		local u331 = nil
		_FarmV1:AddSwitch('Golpe rapido [ACTIVAR]', function(p332)
			local _LocalPlayer34 = game.Players.LocalPlayer
			if p332 then
				_G.punchanim = true
				if u331 then
					u331:Disconnect()
				end
				u331 = game:GetService('RunService').Heartbeat:Connect(function()
					if _G.punchanim then
						local _Character4 = _LocalPlayer34.Character
						if _Character4 then
							local _Humanoid4 = _Character4:FindFirstChildOfClass('Humanoid')
							local v336 = _LocalPlayer34.Backpack:FindFirstChild('Punch') or _Character4:FindFirstChild('Punch')
							if v336 then
								local _attackTime2 = v336:FindFirstChild('attackTime')
								if _attackTime2 then
									_attackTime2.Value = 0
								end
								if _Humanoid4 and v336.Parent ~= _Character4 then
									_Humanoid4:EquipTool(v336)
								end
								v336:Activate()
							end
						end
					else
						if u331 then
							u331:Disconnect()
							u331 = nil
						end
						return
					end
				end)
			else
				_G.punchanim = false
				if u331 then
					u331:Disconnect()
					u331 = nil
				end
				local _Punch2 = _LocalPlayer34.Backpack:FindFirstChild('Punch')
				local _Character5 = _LocalPlayer34.Character
				if _Character5 then
					_Character5 = _LocalPlayer34.Character:FindFirstChild('Punch')
				end
				local v340 = _Punch2 or _Character5
				if v340 and v340:FindFirstChild('attackTime') then
					v340.attackTime.Value = 0.001
				end
			end
		end)
		_FarmV1:AddSwitch('Flexiones rapidas + roca de Jungla Antigua', function(p341)
			if p341 then
				local _LocalPlayer35 = game.Players.LocalPlayer
				local _LeftHand8 = (_LocalPlayer35.Character or _LocalPlayer35.CharacterAdded:Wait()):WaitForChild('LeftHand')
				local _Rock14 = game.Workspace.machinesFolder:FindFirstChild('Ancient Jungle Rock'):FindFirstChild('Rock')
				_G.jungleautorock = true
				isAutoPushups = true
				task.spawn(function()
					while _G.jungleautorock do
						if _Rock14 then
							_Rock14.Size = Vector3.new(2, 1, 1)
							_Rock14.Transparency = 1
							local v345, v346, v347 = pairs(_Rock14.rockGui:GetChildren())
							while true do
								local v348
								v347, v348 = v345(v346, v347)
								if v347 == nil then
									break
								end
								v348.Visible = false
							end
							_Rock14.CanCollide = false
							if _Rock14:FindFirstChild('rockEmitter') then
								_Rock14.rockEmitter:Destroy()
							end
							if _Rock14:FindFirstChild('hoopParticle') then
								_Rock14.hoopParticle:Destroy()
							end
							if _Rock14:FindFirstChild('lavaParticle') then
								_Rock14.lavaParticle:Destroy()
							end
							_Rock14.CFrame = _LeftHand8.CFrame
						else
							warn('Roca no encontrada.')
						end
						wait()
					end
				end)
				task.spawn(function()
					while isAutoPushups do
						wait(0.01)
						local _Backpack5 = _LocalPlayer35:FindFirstChild('Backpack')
						local v350 = _Backpack5 and _Backpack5:FindFirstChild('Pushups')
						if v350 then
							_LocalPlayer35.Character.Humanoid:EquipTool(v350)
						end
						game:GetService('Players').LocalPlayer.muscleEvent:FireServer(unpack({
							'rep',
						}))
					end
				end)
			else
				local v356, _ = pcall(function()
					local _Rock15 = game.Workspace.machinesFolder:FindFirstChild('Ancient Jungle Rock'):FindFirstChild('Rock')
					_G.jungleautorock = false
					isAutoPushups = false
					if _Rock15 then
						local v352, v353, v354 = pairs(_Rock15.rockGui:GetChildren())
						while true do
							local v355
							v354, v355 = v352(v353, v354)
							if v354 == nil then
								break
							end
							v355.Visible = true
						end
						_Rock15.CanCollide = true
						_Rock15.Transparency = 0
						_Rock15.CFrame = CFrame.new(_Rock15.originalPosition.Value)
						_Rock15.Size = Vector3.new(23.18409538269043, 20.20000648498535, 24.44658088684082)
					else
						warn('Roca no encontrada en Jungla Antigua.')
					end
				end)
				if not v356 then
					warn('Error turning Ancient Jungle Rock off.')
				end
				local _LocalPlayer36 = game.Players.LocalPlayer
				local _Backpack6 = _LocalPlayer36:FindFirstChild('Backpack')
				if _Backpack6 then
					local _Tool4 = _LocalPlayer36.Character:FindFirstChildOfClass('Tool')
					if _Tool4 and _Tool4.Name == 'Pushups' then
						_Tool4.Parent = _Backpack6
					end
				end
			end
		end):Set(false)
		_FarmV1:AddSwitch('Flexiones rapidas + roca del Rey Musculo', function(p360)
			isAutoPushups = p360
			_G.musclekingautorock = p360
			local _LocalPlayer37 = game.Players.LocalPlayer
			local v362 = _LocalPlayer37.Character or _LocalPlayer37.CharacterAdded:Wait()
			local _Backpack7 = _LocalPlayer37:FindFirstChild('Backpack')
			if p360 then
				local _LeftHand9 = v362:WaitForChild('LeftHand')
				local _Rock16 = game.Workspace.machinesFolder:FindFirstChild('Muscle King Mountain'):FindFirstChild('Rock')
				while isAutoPushups do
					wait(0.01)
					local v366 = _Backpack7 and _Backpack7:FindFirstChild('Pushups')
					if v366 then
						_LocalPlayer37.Character.Humanoid:EquipTool(v366)
					end
					game:GetService('Players').LocalPlayer.muscleEvent:FireServer(unpack({
						'rep',
					}))
				end
				while _G.musclekingautorock do
					if _Rock16 then
						_Rock16.Size = Vector3.new(2, 1, 1)
						_Rock16.Transparency = 1
						local v367, v368, v369 = pairs(_Rock16.rockGui:GetChildren())
						while true do
							local v370
							v369, v370 = v367(v368, v369)
							if v369 == nil then
								break
							end
							v370.Visible = false
						end
						_Rock16.CanCollide = false
						if _Rock16:FindFirstChild('rockEmitter') then
							_Rock16.rockEmitter:Destroy()
						end
						if _Rock16:FindFirstChild('hoopParticle') then
							_Rock16.hoopParticle:Destroy()
						end
						if _Rock16:FindFirstChild('lavaParticle') then
							_Rock16.lavaParticle:Destroy()
						end
						_Rock16.CFrame = _LeftHand9.CFrame
					else
						warn('Roca no encontrada.')
					end
					wait()
				end
			else
				local _, _ = pcall(function()
					local _Rock17 = game.Workspace.machinesFolder:FindFirstChild('Muscle King Mountain'):FindFirstChild('Rock')
					if _Rock17 then
						local v372, v373, v374 = pairs(_Rock17.rockGui:GetChildren())
						while true do
							local v375
							v374, v375 = v372(v373, v374)
							if v374 == nil then
								break
							end
							v375.Visible = true
						end
						_Rock17.CanCollide = true
						_Rock17.Transparency = 0
						_Rock17.CFrame = CFrame.new(_Rock17.originalPosition.Value)
						_Rock17.Size = Vector3.new(141.97381591796875, 123.69998931884766, 149.70497131347656)
					else
						warn('Roca no encontrada en la montaña del Rey Musculo.')
					end
				end)
				if not isAutoPushups then
					local _Tool5 = _LocalPlayer37.Character:FindFirstChildOfClass('Tool')
					if _Tool5 and _Tool5.Name == 'Pushups' then
						_Tool5.Parent = _Backpack7
					end
				end
			end
		end):Set(false)
		_FarmV1:AddLabel('Huevos:').TextSize = 22
		local u377 = false
		local function u382()
			local _LocalPlayer38 = game.Players.LocalPlayer
			local _Backpack8 = _LocalPlayer38:WaitForChild('Backpack')
			local v380 = _LocalPlayer38.Character or _LocalPlayer38.CharacterAdded:Wait()
			local _ProteinEgg = _Backpack8:FindFirstChild('Protein Egg')
			if _ProteinEgg then
				_ProteinEgg.Parent = v380
				pcall(function()
					_ProteinEgg:Activate()
				end)
			end
		end
		task.spawn(function()
			while true do
				while u377 do
					u382()
					task.wait(1800)
				end
				task.wait(1)
			end
		end)
		_FarmV1:AddSwitch('Comer huevo (30 min)', function(p383)
			u377 = p383
		end)
		local v384, v385, u386 = pairs({
			['Swift Samurai'] = 'Equipar todos los Swift Samurai',
			['Tribal Overlord'] = 'Equipar todos los Tribal Overlord',
			['Mighty Monster'] = 'Equipar todos los Mighty Monster',
			['Wild Wizard'] = 'Equipar todos los Wild Wizard',
		})
		local function u396()
			local _petsFolder2 = game:GetService('Players').LocalPlayer:FindFirstChild('petsFolder')
			if _petsFolder2 then
				local v388, v389, v390 = pairs(_petsFolder2:GetChildren())
				while true do
					local v391
					v390, v391 = v388(v389, v390)
					if v390 == nil then
						break
					end
					if v391:IsA('Folder') then
						local v392, v393, v394 = pairs(v391:GetChildren())
						while true do
							local v395
							v394, v395 = v392(v393, v394)
							if v394 == nil then
								break
							end
							game:GetService('ReplicatedStorage').rEvents.equipPetEvent:FireServer('unequipPet', v395)
						end
					end
				end
			end
		end
		while true do
			local v397
			u386, v397 = v384(v385, u386)
			if u386 == nil then
				break
			end
			_FarmV1:AddButton(v397, function()
				u396()
				local v398, v399, v400 = pairs(game:GetService('Players').LocalPlayer.petsFolder.Unique:GetChildren())
				while true do
					local v401
					v400, v401 = v398(v399, v400)
					if v400 == nil then
						break
					end
					if v401.Name == u386 then
						game:GetService('ReplicatedStorage').rEvents.equipPetEvent:FireServer('equipPet', v401)
					end
				end
			end)
		end
	end)(_FarmV1)
	local _JungleFarm = _FarmV1:AddFolder('Farmeo de jungla')
	local u403 = false
	_JungleFarm:AddSwitch('Banco de jungla automatico', function(p404)
		u403 = p404
		if p404 then
			task.spawn(function()
				while u403 do
					game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(- 8629.88086, 64.8842468, 1855.03467))
					game:GetService('ReplicatedStorage').rEvents.machineInteractRemote:InvokeServer('useMachine', workspace.machinesFolder['Jungle Bench'].interactSeat)
					task.wait(0.1)
				end
			end)
		end
	end)
	local u405 = false
	_JungleFarm:AddSwitch('Levantamiento de jungla automatico', function(p406)
		u405 = p406
		if p406 then
			task.spawn(function()
				while u405 do
					game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(- 8678.05566, 14.5030098, 2089.25977))
					game:GetService('ReplicatedStorage').rEvents.machineInteractRemote:InvokeServer('useMachine', workspace.machinesFolder['Jungle Bar Lift'].interactSeat)
					task.wait(0.1)
				end
			end)
		end
	end)
	local u407 = false
	_JungleFarm:AddSwitch('Sentadilla de jungla automatica', function(p408)
		u407 = p408
		if p408 then
			task.spawn(function()
				while u407 do
					game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(- 8374.25586, 34.5933418, 2932.44995))
					game:GetService('ReplicatedStorage').rEvents.machineInteractRemote:InvokeServer('useMachine', workspace.machinesFolder['Jungle Squat'].interactSeat)
					task.wait(0.1)
				end
			end)
		end
	end)
	local _MuscleKingFarm = _FarmV1:AddFolder('Farmeo del Rey Musculo')
	local u410 = false
	_MuscleKingFarm:AddSwitch('Levantamiento del Rey automatico', function(p411)
		u410 = p411
		if p411 then
			task.spawn(function()
				while u410 do
					game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(- 8772.97266, 24.4272194, - 5638.37402))
					game:GetService('ReplicatedStorage').rEvents.machineInteractRemote:InvokeServer('useMachine', workspace.machinesFolder['Muscle King Lift'].interactSeat)
					task.wait(0.1)
				end
			end)
		end
	end)
	local u412 = false
	_MuscleKingFarm:AddSwitch('Roca del Rey automatica', function(p413)
		u412 = p413
		if p413 then
			task.spawn(function()
				while u412 do
					game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(- 8986.61621, 30.0510483, - 5647.14404))
					game:GetService('ReplicatedStorage').rEvents.machineInteractRemote:InvokeServer('useMachine', workspace.machinesFolder['King Boulder'].interactSeat)
					task.wait(0.1)
				end
			end)
		end
	end)
	local _LegendGymFarming = _FarmV1:AddFolder('Farmeo del gimnasio Leyenda')
	local u415 = false
	_LegendGymFarming:AddSwitch('Levantamiento Leyenda automatico', function(p416)
		u415 = p416
		if p416 then
			task.spawn(function()
				while u415 do
					game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(4551.51514, 997.727234, - 4018.90186))
					game:GetService('ReplicatedStorage').rEvents.machineInteractRemote:InvokeServer('useMachine', workspace.machinesFolder['Legends Lift'].interactSeat)
					task.wait(0.1)
				end
			end)
		end
	end)
	local u417 = false
	_LegendGymFarming:AddSwitch('Press Leyenda automatico', function(p418)
		u417 = p418
		if p418 then
			task.spawn(function()
				while u417 do
					game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(4100.08154, 1016.20416, - 3800.4187))
					game:GetService('ReplicatedStorage').rEvents.machineInteractRemote:InvokeServer('useMachine', workspace.machinesFolder['Legends Press'].interactSeat)
					task.wait(0.1)
				end
			end)
		end
	end)
	local _PetsHatch = _EnchantedHubMuscleLegends:AddTab('Mascotas')
	local _ReplicatedStorage2 = game:GetService('ReplicatedStorage')
	local u421 = 'Neon Guardian'
	local _SelectPet = _PetsHatch:AddDropdown('Seleccionar mascota', function(p422)
		u421 = p422
	end)
	local u424 = {
		'Neon Guardian',
		'Blue Birdie',
		'Blue Bunny',
		'Blue Firecaster',
		'Blue Phoenix',
		'Crimson Falcon',
		'Cybernetic Showdown Dragon',
		'Dark Golem',
		'Dark Legends Manticore',
		'Dark Vampy',
		'Darkstar Hunter',
		'Eternal Strike Leviathan',
		'Frostwave Legends Penguin',
		'Gold Warrior',
		'Golden Phoenix',
		'Golden Viking',
		'Green Butterfly',
		'Green Firecaster',
		'Infernal Dragon',
		'Lightning Strike Phantom',
		'Magic Butterfly',
		'Muscle Sensei',
		'Orange Hedgehog',
		'Orange Pegasus',
		'Phantom Genesis Dragon',
		'Purple Dragon',
		'Purple Falcon',
		'Red Dragon',
		'Red Firecaster',
		'Red Kitty',
		'Silver Dog',
		'Ultimate Supernova Pegasus',
		'Ultra Birdie',
		'White Pegasus',
		'White Phoenix',
		'Yellow Butterfly',
	}
	local v425, v426, v427 = ipairs(u424)
	local u428 = u421
	while true do
		local v429
		v427, v429 = v425(v426, v427)
		if v427 == nil then
			break
		end
		_SelectPet:Add(v429)
	end
	_PetsHatch:AddSwitch('Abrir mascota automaticamente', function(p430)
		_G.AutoHatchPet = p430
		if p430 then
			task.spawn(function()
				while _G.AutoHatchPet and u428 ~= '' do
					local v431 = _ReplicatedStorage2.cPetShopFolder:FindFirstChild(u428)
					if v431 then
						_ReplicatedStorage2.cPetShopRemote:InvokeServer(v431)
					end
					task.wait(1)
				end
			end)
		end
	end)
	local u432 = 'Blue Aura'
	local _SelectAura = _PetsHatch:AddDropdown('Seleccionar aura', function(p433)
		u432 = p433
	end)
	local v435, v436, v437 = ipairs({
		'Astral Electro',
		'Azure Tundra',
		'Blue Aura',
		'Dark Electro',
		'Dark Lightning',
		'Dark Storm',
		'Electro',
		'Enchanted Mirage',
		'Entropic Blast',
		'Eternal Megastrike',
		'Grand Supernova',
		'Green Aura',
		'Inferno',
		'Lightning',
		'Muscle King',
		'Power Lightning',
		'Purple Aura',
		'Purple Nova',
		'Red Aura',
		'Supernova',
		'Ultra Inferno',
		'Ultra Mirage',
		'Unstable Mirage',
		'Yellow Aura',
	})
	local u438 = u432
	while true do
		local v439
		v437, v439 = v435(v436, v437)
		if v437 == nil then
			break
		end
		_SelectAura:Add(v439)
	end
	_PetsHatch:AddSwitch('Abrir aura automaticamente', function(p440)
		_G.AutoHatchAura = p440
		if p440 then
			task.spawn(function()
				while _G.AutoHatchAura and u438 ~= '' do
					local v441 = _ReplicatedStorage2.cPetShopFolder:FindFirstChild(u438)
					if v441 then
						_ReplicatedStorage2.cPetShopRemote:InvokeServer(v441)
					end
					task.wait(1)
				end
			end)
		end
	end)
	_PetsHatch:AddLabel('----------')
	local u442 = 'Galaxy Oracle Crystal'
	local _SelectCrystal = _PetsHatch:AddDropdown('Seleccionar cristal', function(p443)
		u442 = p443
	end)
	local v445, v446, v447 = ipairs({
		'Blue Crystal',
		'Green Crystal',
		'Frozen Crystal',
		'Mythical Crystal',
		'Inferno Crystal',
		'Legends Crystal',
		'Muscle Elite Crystal',
		'Galaxy Oracle Crystal',
		'Sky Eclipse Crystal',
		'Jungle Crystal',
	})
	local u448 = u442
	local u449 = false
	while true do
		local v450
		v447, v450 = v445(v446, v447)
		if v447 == nil then
			break
		end
		_SelectCrystal:Add(v450)
	end
	local function u451()
		while u449 do
			_ReplicatedStorage2:WaitForChild('rEvents'):WaitForChild('openCrystalRemote'):InvokeServer('openCrystal', u448)
			task.wait(0.1)
		end
	end
	_PetsHatch:AddSwitch('Abrir cristal automaticamente', function(p452)
		u449 = p452
		if u449 then
			task.spawn(u451)
		end
	end)
	_PetsHatch:AddLabel('----------')
	local u453 = nil
	local function u459(p454)
		local v455, v456, v457 = ipairs(u424)
		while true do
			local v458
			v457, v458 = v455(v456, v457)
			if v457 == nil then
				break
			end
			if v458:lower() == p454:lower() then
				return v458
			end
		end
		if _ReplicatedStorage2.cPetShopFolder:FindFirstChild(p454) then
			return p454
		else
			return nil
		end
	end
	_PetsHatch:AddTextBox('Nombre de mascota', function(p460)
		local v461 = u459(p460)
		if v461 then
			u453 = v461
		else
			u453 = nil
		end
	end)
	_PetsHatch:AddButton('Vender mascota (pulsa para vender)', function()
		if u453 then
			local v462 = {
				'sellPet',
				u453,
			}
			_ReplicatedStorage2.rEvents.sellPetEvent:FireServer(unpack(v462))
			u453 = nil
		end
	end)
	local _Killing = _EnchantedHubMuscleLegends:AddTab('Combate')
	_Killing:Show()
	_Killing:AddLabel('Usa mascotas de packs para aumentar el daño')
	local v464, v465, u466 = pairs({
		['Mighty Monster'] = 'Equipar para durabilidad',
		['Wild Wizard'] = 'Equipar para daño',
	})
	local function u476()
		local _petsFolder3 = game:GetService('Players').LocalPlayer:FindFirstChild('petsFolder')
		if _petsFolder3 then
			local v468, v469, v470 = pairs(_petsFolder3:GetChildren())
			while true do
				local v471
				v470, v471 = v468(v469, v470)
				if v470 == nil then
					break
				end
				if v471:IsA('Folder') then
					local v472, v473, v474 = pairs(v471:GetChildren())
					while true do
						local v475
						v474, v475 = v472(v473, v474)
						if v474 == nil then
							break
						end
						game:GetService('ReplicatedStorage').rEvents.equipPetEvent:FireServer('unequipPet', v475)
					end
				end
			end
		end
	end
	while true do
		local v477
		u466, v477 = v464(v465, u466)
		if u466 == nil then
			break
		end
		_Killing:AddButton(v477, function()
			u476()
			local v478, v479, v480 = pairs(game:GetService('Players').LocalPlayer.petsFolder.Unique:GetChildren())
			while true do
				local v481
				v480, v481 = v478(v479, v480)
				if v480 == nil then
					break
				end
				if v481.Name == u466 then
					game:GetService('ReplicatedStorage').rEvents.equipPetEvent:FireServer('equipPet', v481)
				end
			end
		end)
	end
	_Killing:AddLabel('----------')
	_Killing:AddSwitch('Golpe automatico', function(p482)
		if p482 then
			local _LocalPlayer39 = game.Players.LocalPlayer
			local _Name = _LocalPlayer39.Name
			local v485 = _LocalPlayer39.Backpack:FindFirstChild('Punch') or game.Workspace:FindFirstChild(_Name):FindFirstChild('Punch')
			_G.punchanim = true
			while _G.punchanim do
				if v485 then
					if v485.Parent ~= game.Workspace:FindFirstChild(_Name) then
						v485.Parent = game.Workspace:FindFirstChild(_Name)
					end
					v485:Activate()
					wait()
				else
					warn('Punch tool not found')
					_G.punchanim = false
				end
			end
		else
			_G.punchanim = false
		end
	end):Set(false)
	_Killing:AddSwitch('Golpe rapido', function(p486)
		local _LocalPlayer40 = game.Players.LocalPlayer
		local _Punch3 = _LocalPlayer40.Backpack:FindFirstChild('Punch')
		local v489 = game.Workspace:FindFirstChild(_LocalPlayer40.Name)
		local v490
		if v489 then
			v490 = v489:FindFirstChild('Punch')
		else
			v490 = nil
		end
		if p486 then
			if _Punch3 and _Punch3:FindFirstChild('attackTime') then
				_Punch3.attackTime.Value = 0.0001
			elseif v490 and v490:FindFirstChild('attackTime') then
				v490.attackTime.Value = 0.0001
			end
		elseif _Punch3 and _Punch3:FindFirstChild('attackTime') then
			_Punch3.attackTime.Value = 0.0001
		elseif v490 and v490:FindFirstChild('attackTime') then
			v490.attackTime.Value = 0.0001
		end
	end):Set(false)
	_Killing:AddLabel('---------------')
	_Killing:AddButton('Cambiar servidor para combatir', function()
		local _Players = game:GetService('Players')
		local _TweenService = game:GetService('TweenService')
		local _UserInputService = game:GetService('UserInputService')
		local _RunService = game:GetService('RunService')
		local _TeleportService = game:GetService('TeleportService')
		local _HttpService = game:GetService('HttpService')
		local _LocalPlayer41 = _Players.LocalPlayer
		local _PlayerGui2 = _LocalPlayer41:WaitForChild('PlayerGui')
		local _PlaceId = game.PlaceId
		if _PlayerGui2:FindFirstChild('EnchantedHubGUI') then
			_PlayerGui2:FindFirstChild('EnchantedHubGUI'):Destroy()
		end
		local _ScreenGui2 = Instance.new('ScreenGui')
		_ScreenGui2.Name = 'EnchantedHubGUI'
		_ScreenGui2.Parent = _PlayerGui2
		_ScreenGui2.ResetOnSpawn = false
		local _Frame2 = Instance.new('Frame')
		_Frame2.Size = UDim2.new(0, 250, 0, 120)
		_Frame2.Position = UDim2.new(0.5, - 125, 0.1, 0)
		_Frame2.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
		_Frame2.BorderSizePixel = 3
		_Frame2.BorderColor3 = Color3.fromRGB(120, 0, 0)
		_Frame2.Active = true
		_Frame2.Draggable = true
		_Frame2.Parent = _ScreenGui2
		local _UICorner = Instance.new('UICorner')
		_UICorner.CornerRadius = UDim.new(0, 8)
		_UICorner.Parent = _Frame2
		local _UIGradient = Instance.new('UIGradient')
		_UIGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 0, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 0, 0)),
		})
		_UIGradient.Rotation = 45
		_UIGradient.Parent = _Frame2
		local u504 = nil
		local u505 = nil
		local u506 = nil
		local u507 = nil
		local function u510(p508)
			local v509 = p508.Position - u506
			_Frame2.Position = UDim2.new(u507.X.Scale, u507.X.Offset + v509.X, u507.Y.Scale, u507.Y.Offset + v509.Y)
		end
		_Frame2.InputBegan:Connect(function(p511)
			if p511.UserInputType == Enum.UserInputType.MouseButton1 or p511.UserInputType == Enum.UserInputType.Touch then
				u504 = true
				u506 = p511.Position
				u507 = _Frame2.Position
				p511.Changed:Connect(function()
					if p511.UserInputState == Enum.UserInputState.End then
						u504 = false
					end
				end)
			end
		end)
		_Frame2.InputChanged:Connect(function(p512)
			if p512.UserInputType == Enum.UserInputType.MouseMovement or p512.UserInputType == Enum.UserInputType.Touch then
				u505 = p512
			end
		end)
		_UserInputService.InputChanged:Connect(function(p513)
			if p513 == u505 and u504 then
				u510(p513)
			end
		end)
		local _TextLabel2 = Instance.new('TextLabel')
		_TextLabel2.Size = UDim2.new(1, - 10, 0.4, 0)
		_TextLabel2.Position = UDim2.new(0, 5, 0, 5)
		_TextLabel2.BackgroundTransparency = 1
		_TextLabel2.Text = 'Enchanted-Hub || ServerHop'
		_TextLabel2.TextColor3 = Color3.fromRGB(255, 40, 40)
		_TextLabel2.Font = Enum.Font.GothamBlack
		_TextLabel2.TextSize = 16
		_TextLabel2.TextStrokeTransparency = 0.8
		_TextLabel2.Parent = _Frame2
		local _TextLabel3 = Instance.new('TextLabel')
		_TextLabel3.Size = UDim2.new(1, - 10, 0.4, 0)
		_TextLabel3.Position = UDim2.new(0, 5, 0.4, 5)
		_TextLabel3.BackgroundTransparency = 1
		_TextLabel3.Text = 'Bajas: 0'
		_TextLabel3.TextColor3 = Color3.fromRGB(255, 255, 255)
		_TextLabel3.Font = Enum.Font.GothamBold
		_TextLabel3.TextSize = 18
		_TextLabel3.TextStrokeTransparency = 0.7
		_TextLabel3.Parent = _Frame2
		local _TextLabel4 = Instance.new('TextLabel')
		_TextLabel4.Size = UDim2.new(1, - 10, 0.2, 0)
		_TextLabel4.Position = UDim2.new(0, 5, 0.8, 5)
		_TextLabel4.BackgroundTransparency = 1
		_TextLabel4.Text = 'Estado: ACTIVO'
		_TextLabel4.TextColor3 = Color3.fromRGB(0, 255, 0)
		_TextLabel4.Font = Enum.Font.Gotham
		_TextLabel4.TextSize = 12
		_TextLabel4.Parent = _Frame2
		task.spawn(function()
			while task.wait(1.5) and _ScreenGui2.Parent do
				_TweenService:Create(_Frame2, TweenInfo.new(0.8), {
					BorderColor3 = Color3.fromRGB(255, 0, 0),
				}):Play()
				task.wait(0.8)
				_TweenService:Create(_Frame2, TweenInfo.new(0.8), {
					BorderColor3 = Color3.fromRGB(120, 0, 0),
				}):Play()
			end
		end)
		_G.whitelistedPlayers = _G.whitelistedPlayers or {}
		_G.killAll = true
		_G.whitelistFriends = true
		local function v522()
			local v517 = _Players
			local v518, v519, v520 = pairs(v517:GetPlayers())
			while true do
				local v521
				v520, v521 = v518(v519, v520)
				if v520 == nil then
					break
				end
				if v521 ~= _LocalPlayer41 and (v521:IsFriendsWith(_LocalPlayer41.UserId) and not table.find(_G.whitelistedPlayers, v521.Name)) then
					table.insert(_G.whitelistedPlayers, v521.Name)
				end
			end
		end
		if _G.whitelistFriends then
			v522()
		end
		_Players.PlayerAdded:Connect(function(p523)
			if p523 ~= _LocalPlayer41 and (p523:IsFriendsWith(_LocalPlayer41.UserId) and not table.find(_G.whitelistedPlayers, p523.Name)) then
				table.insert(_G.whitelistedPlayers, p523.Name)
			end
		end)
		local function u526(p524)
			local v525 = p524 and p524.Character and (p524.Character:FindFirstChild('HumanoidRootPart') and p524.Character:FindFirstChild('Humanoid'))
			if v525 then
				v525 = p524.Character.Humanoid.Health > 0
			end
			return v525
		end
		local function u531()
			local v527, v528, v529 = pairs(_LocalPlayer41.Backpack:GetChildren())
			while true do
				local v530
				v529, v530 = v527(v528, v529)
				if v529 == nil then
					break
				end
				if v530.Name == 'Punch' and _LocalPlayer41.Character:FindFirstChild('Humanoid') then
					_LocalPlayer41.Character.Humanoid:EquipTool(v530)
				end
			end
			if _LocalPlayer41:FindFirstChild('muscleEvent') then
				_LocalPlayer41.muscleEvent:FireServer('punch', 'leftHand')
				_LocalPlayer41.muscleEvent:FireServer('punch', 'rightHand')
			end
		end
		local function u534(p532)
			if u526(p532) then
				local _Character6 = _LocalPlayer41.Character
				if _Character6 and _Character6:FindFirstChild('LeftHand') and p532.Character:FindFirstChild('HumanoidRootPart') then
					pcall(function()
						firetouchinterest(p532.Character.HumanoidRootPart, _Character6.LeftHand, 0)
						firetouchinterest(p532.Character.HumanoidRootPart, _Character6.LeftHand, 1)
						u531()
					end)
				end
			end
		end
		local function u540(p535)
			local v536, v537, v538 = ipairs(_G.whitelistedPlayers)
			while true do
				local v539
				v538, v539 = v536(v537, v538)
				if v538 == nil then
					break
				end
				if v539:lower() == p535.Name:lower() then
					return true
				end
			end
			return false
		end
		local u541 = nil
		u541 = _RunService.Heartbeat:Connect(function()
			if _G.killAll and _ScreenGui2.Parent then
				local v542 = _Players
				local v543, v544, v545 = pairs(v542:GetPlayers())
				while true do
					local v546
					v545, v546 = v543(v544, v545)
					if v545 == nil then
						break
					end
					if v546 ~= _LocalPlayer41 and not u540(v546) then
						u534(v546)
					end
				end
			else
				u541:Disconnect()
			end
		end)
		local function u549()
			local _leaderstats2 = _LocalPlayer41:FindFirstChild('leaderstats')
			if _leaderstats2 then
				local u548 = _leaderstats2:FindFirstChild('Kills') or (_leaderstats2:FindFirstChild('KOs') or _leaderstats2:FindFirstChild('Eliminations'))
				if u548 then
					_TextLabel3.Text = 'Bajas: ' .. tostring(u548.Value)
					u548:GetPropertyChangedSignal('Value'):Connect(function()
						_TextLabel3.Text = 'Bajas: ' .. tostring(u548.Value)
					end)
				else
					_TextLabel3.Text = 'Bajas: (no detectadas)'
				end
			else
				_TextLabel3.Text = 'Bajas: (no detectadas)'
			end
		end
		if _LocalPlayer41:FindFirstChild('leaderstats') then
			u549()
		else
			_LocalPlayer41.ChildAdded:Connect(function(p550)
				if p550.Name == 'leaderstats' then
					u549()
				end
			end)
		end
		spawn(function()
			while task.wait(120) and _ScreenGui2.Parent do
				pcall(function()
					local v551 = {}
					local v552 = syn and syn.request or (http_request or request)
					if v552 then
						local v553 = v552({
							Url = 'https://games.roblox.com/v1/games/' .. _PlaceId .. '/servers/Public?sortOrder=Desc&limit=100',
						})
						if v553 and v553.Body then
							local v554 = _HttpService:JSONDecode(v553.Body)
							local v555, v556, v557 = ipairs(v554.data)
							while true do
								local v558
								v557, v558 = v555(v556, v557)
								if v557 == nil then
									break
								end
								if v558.playing / v558.maxPlayers >= 0.65 and v558.id ~= game.JobId then
									table.insert(v551, v558.id)
								end
							end
						end
						if # v551 > 0 then
							_TeleportService:TeleportToPlaceInstance(_PlaceId, v551[math.random(1, # v551)])
						end
					end
				end)
			end
		end)
		_ScreenGui2.Destroying:Connect(function()
			if u541 then
				u541:Disconnect()
			end
			_G.killAll = false
		end)
	end)
	local u559 = {}
	local u560 = false
	_G.autoKillActive = false
	local function u565(p561)
		local _LocalPlayer42 = game.Players.LocalPlayer
		local _Backpack9 = _LocalPlayer42:FindFirstChild('Backpack')
		local v564 = _Backpack9 and _Backpack9:FindFirstChild(p561)
		if v564 then
			_LocalPlayer42.Character.Humanoid:EquipTool(v564)
		end
	end
	local function u595(p566)
		if p566 then
			_G.autoKillActive = true
			u565('Punch')
			coroutine.wrap(function()
				while _G.autoKillActive do
					wait()
					local _LocalPlayer43 = game.Players.LocalPlayer
					_LocalPlayer43.muscleEvent:FireServer('punch', 'rightHand')
					_LocalPlayer43.muscleEvent:FireServer('punch', 'leftHand')
					local v568, v569, v570 = pairs(game.Players:GetChildren())
					while true do
						local v571
						v570, v571 = v568(v569, v570)
						if v570 == nil then
							break
						end
						if v571.Name ~= _LocalPlayer43.Name then
							local v572 = game.Workspace:FindFirstChild(v571.Name)
							local v573 = game.Workspace:FindFirstChild(_LocalPlayer43.Name)
							if v572 and v573 then
								local _LeftHand10 = v573:FindFirstChild('LeftHand')
								if _LeftHand10 then
									local _Head = v572:FindFirstChild('Head')
									if _Head then
										_Head.CFrame = _LeftHand10.CFrame
									end
									local v576, v577, v578 = pairs(v572:GetDescendants())
									while true do
										local v579
										v578, v579 = v576(v577, v578)
										if v578 == nil then
											break
										end
										if v579:IsA('BasePart') and v579.Name == 'Handle' then
											v579.CFrame = _LeftHand10.CFrame
										end
									end
									local _sweatPart = v572:FindFirstChild('sweatPart')
									if _sweatPart then
										_sweatPart.CFrame = _LeftHand10.CFrame
									end
								end
							end
						end
					end
				end
			end)()
			coroutine.wrap(function()
				while _G.autoKillActive do
					wait()
					local _LocalPlayer44 = game.Players.LocalPlayer
					_LocalPlayer44.muscleEvent:FireServer('punch', 'rightHand')
					_LocalPlayer44.muscleEvent:FireServer('punch', 'leftHand')
					local v582, v583, v584 = pairs(game.Players:GetChildren())
					while true do
						local v585
						v584, v585 = v582(v583, v584)
						if v584 == nil then
							break
						end
						if v585.Name ~= _LocalPlayer44.Name then
							local v586 = game.Workspace:FindFirstChild(v585.Name)
							local v587 = game.Workspace:FindFirstChild(_LocalPlayer44.Name)
							if v586 and v587 then
								local _LeftHand11 = v587:FindFirstChild('LeftHand')
								if _LeftHand11 then
									local _Head2 = v586:FindFirstChild('Head')
									if _Head2 then
										_Head2.Parent = nil
										wait(0.1)
										_Head2.CFrame = _LeftHand11.CFrame
										_Head2.Parent = v586
									end
									local v590, v591, v592 = pairs(v586:GetDescendants())
									while true do
										local v593
										v592, v593 = v590(v591, v592)
										if v592 == nil then
											break
										end
										if v593:IsA('BasePart') and v593.Name == 'Handle' then
											v593.CFrame = _LeftHand11.CFrame
										end
									end
									local _sweatPart2 = v586:FindFirstChild('sweatPart')
									if _sweatPart2 then
										_sweatPart2.CFrame = _LeftHand11.CFrame
									end
								end
							end
						end
					end
				end
			end)()
		else
			_G.autoKillActive = false
		end
	end
	local function u605()
		u560 = true
		u565('Punch')
		while u560 do
			local _LocalPlayer45 = game.Players.LocalPlayer
			local u597 = _LocalPlayer45.Character or _LocalPlayer45.CharacterAdded:Wait()
			local _HumanoidRootPart2 = u597:WaitForChild('HumanoidRootPart')
			local v599, v600, v601 = ipairs(game.Players:GetPlayers())
			while true do
				local u602
				v601, u602 = v599(v600, v601)
				if v601 == nil then
					break
				end
				if u602 ~= _LocalPlayer45 and not table.find(u559, u602.Name) then
					pcall(function()
						local _Character7 = u602.Character
						if _Character7 then
							_Character7 = u602.Character:FindFirstChild('HumanoidRootPart')
						end
						if _Character7 then
							_Character7.Size = Vector3.new(20, 20, 20)
							_Character7.Transparency = 1
							_Character7.Color = Color3.new(1, 0, 0)
							_Character7.Material = Enum.Material.Neon
							_Character7.CanCollide = false
							_Character7.CFrame = CFrame.new(1955.3785, 1.7816, 6170.521)
							local _Punch4 = u597:FindFirstChild('Punch')
							if _Punch4 then
								_Punch4:Activate()
							end
						end
					end)
				end
			end
			_HumanoidRootPart2.CFrame = CFrame.new(1953.2662, 1.7816, 6186.1226)
			wait(0.01)
		end
	end
	_Killing:AddSwitch('Atacar a todos automaticamente', function(p606)
		if p606 then
			if killMethod ~= 'Teletransporte' then
				_G.autoKillActive = true
				u595(true)
				print('Ataque automatico (sin teletransporte) activado')
			else
				u560 = true
				spawn(u605)
				print('Ataque automatico (teletransporte) activado')
			end
		else
			u560 = false
			_G.autoKillActive = false
			print('Ataque automatico desactivado')
		end
	end):Set(false)
	local _SelectKillMethod = _Killing:AddDropdown('Seleccionar metodo de ataque', function(p607)
		killMethod = p607
		print('Metodo de ataque seleccionado:', p607)
	end)
	_SelectKillMethod:Add('Teletransporte')
	_SelectKillMethod:Add('Sin teletransporte')
	local _WhitelistPlayers = _Killing:AddDropdown('Jugadores protegidos', function(p609)
		if table.find(u559, p609) then
			local v610, v611, v612 = ipairs(u559)
			while true do
				local v613
				v612, v613 = v610(v611, v612)
				if v612 == nil then
					break
				end
				if v613 == p609 then
					table.remove(u559, v612)
					break
				end
			end
		else
			table.insert(u559, p609)
		end
		print('Updated Whitelist:', u559)
	end)
	local v615, v616, v617 = ipairs(game.Players:GetPlayers())
	local u618 = u595
	while true do
		local v619, v620 = v615(v616, v617)
		if v619 == nil then
			break
		end
		v617 = v619
		if v620.Name ~= game.Players.LocalPlayer.Name then
			_WhitelistPlayers:Add(v620.Name)
		end
	end
	game.Players.PlayerAdded:Connect(function(p621)
		if p621.Name ~= game.Players.LocalPlayer.Name then
			_WhitelistPlayers:Add(p621.Name)
		end
	end)
	game.Players.PlayerRemoving:Connect(function(p622)
		if p622.Name ~= game.Players.LocalPlayer.Name then
			_WhitelistPlayers:Remove(p622.Name)
		end
	end)
	_Killing:AddSwitch('Ataque automatico V2', function(p623)
		u618 = p623
		task.spawn(function()
			while u618 do
				local v624 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
				local _RightHand = v624:FindFirstChild('RightHand')
				local _LeftHand12 = v624:FindFirstChild('LeftHand')
				local _Punch5 = LocalPlayer.Backpack:FindFirstChild('Punch')
				if _Punch5 and not v624:FindFirstChild('Punch') then
					_Punch5.Parent = v624
				end
				if _RightHand and _LeftHand12 then
					local v628, v629, v630 = ipairs(Players:GetPlayers())
					while true do
						local v631
						v630, v631 = v628(v629, v630)
						if v630 == nil then
							break
						end
						if v631 ~= LocalPlayer and not playerWhitelist[v631.Name] then
							local _Character8 = v631.Character
							if _Character8 then
								_Character8 = _Character8:FindFirstChild('HumanoidRootPart')
							end
							if _Character8 then
								pcall(function()
									firetouchinterest(_RightHand, _Character8, 1)
									firetouchinterest(_LeftHand12, _Character8, 1)
									firetouchinterest(_RightHand, _Character8, 0)
									firetouchinterest(_LeftHand12, _Character8, 0)
								end)
							end
						end
					end
				end
				task.wait(0.05)
			end
		end)
	end)
	_Killing:AddSwitch('Karma bueno automatico', function(p633)
		autoGoodKarma = p633
		if autoGoodKarma then
			spawn(function()
				while autoGoodKarma do
					local _LocalPlayer46 = game.Players.LocalPlayer
					local _Character9 = _LocalPlayer46.Character
					local v636
					if _Character9 then
						v636 = _Character9:FindFirstChild('RightHand')
					else
						v636 = _Character9
					end
					local v637
					if _Character9 then
						v637 = _Character9:FindFirstChild('LeftHand')
					else
						v637 = _Character9
					end
					if _Character9 and (v636 and v637) then
						local v638, v639, v640 = ipairs(game.Players:GetPlayers())
						while true do
							local v641
							v640, v641 = v638(v639, v640)
							if v640 == nil then
								break
							end
							if v641 ~= _LocalPlayer46 then
								local _evilKarma = v641:FindFirstChild('evilKarma')
								local _goodKarma = v641:FindFirstChild('goodKarma')
								if _evilKarma and (_goodKarma and (_evilKarma:IsA('IntValue') and (_goodKarma:IsA('IntValue') and _evilKarma.Value > _goodKarma.Value))) then
									local _Character10 = v641.Character
									if _Character10 then
										_Character10 = _Character10:FindFirstChild('HumanoidRootPart')
									end
									if _Character10 then
										firetouchinterest(v636, _Character10, 1)
										firetouchinterest(v637, _Character10, 1)
										firetouchinterest(v636, _Character10, 0)
										firetouchinterest(v637, _Character10, 0)
									end
								end
							end
						end
					end
					task.wait(0.1)
				end
			end)
		end
	end)
	_Killing:AddSwitch('Karma malo automatico', function(p645)
		autoBadKarma = p645
		if autoBadKarma then
			spawn(function()
				while autoBadKarma do
					local _LocalPlayer47 = game.Players.LocalPlayer
					local _Character11 = _LocalPlayer47.Character
					local v648
					if _Character11 then
						v648 = _Character11:FindFirstChild('RightHand')
					else
						v648 = _Character11
					end
					local v649
					if _Character11 then
						v649 = _Character11:FindFirstChild('LeftHand')
					else
						v649 = _Character11
					end
					if _Character11 and (v648 and v649) then
						local v650, v651, v652 = ipairs(game.Players:GetPlayers())
						while true do
							local v653
							v652, v653 = v650(v651, v652)
							if v652 == nil then
								break
							end
							if v653 ~= _LocalPlayer47 then
								local _evilKarma2 = v653:FindFirstChild('evilKarma')
								local _goodKarma2 = v653:FindFirstChild('goodKarma')
								if _evilKarma2 and (_goodKarma2 and (_evilKarma2:IsA('IntValue') and (_goodKarma2:IsA('IntValue') and _goodKarma2.Value > _evilKarma2.Value))) then
									local _Character12 = v653.Character
									if _Character12 then
										_Character12 = _Character12:FindFirstChild('HumanoidRootPart')
									end
									if _Character12 then
										firetouchinterest(v648, _Character12, 1)
										firetouchinterest(v649, _Character12, 1)
										firetouchinterest(v648, _Character12, 0)
										firetouchinterest(v649, _Character12, 0)
									end
								end
							end
						end
					end
					task.wait(0.1)
				end
			end)
		end
	end);
	(function(p657)
		p657:AddLabel('Combate V2:').TextSize = 22
		local u658 = {}
		local u659 = {}
		p657:AddTextBox('Proteger jugador', function(p660)
			table.insert(u658, p660)
		end)
		p657:AddTextBox('Quitar proteccion', function(p661)
			table.insert(u659, p661)
		end)
		p657:AddButton('Limpiar protegidos', function()
			u658 = {}
		end)
		p657:AddButton('Limpiar excluidos', function()
			u659 = {}
		end)
		_TinyRock = p657:AddSwitch('Ataque automatico', function(p662)
			if p662 then
				_G.autokillplr = true
				while true do
					local v663 = game.Players:GetPlayers()
					local _Name2 = game.Players.LocalPlayer.Name
					local v665, v666, v667 = ipairs(v663)
					while true do
						local v668
						v667, v668 = v665(v666, v667)
						if v667 == nil then
							break
						end
						local _Name3 = v668.Name
						local v670 = false
						if _Name3 == _Name2 then
							v670 = true
						else
							local v671, v672, v673 = ipairs(u658)
							while true do
								local v674
								v673, v674 = v671(v672, v673)
								if v673 == nil then
									break
								end
								if _Name3 == v674 then
									v670 = true
									break
								end
							end
							local v675, v676, v677 = ipairs(u659)
							while true do
								local v678
								v677, v678 = v675(v676, v677)
								if v677 == nil then
									break
								end
								if _Name3 == v678 then
									v670 = false
									break
								end
							end
						end
						if not v670 and v668.Character then
							local _Character13 = v668.Character
							if _Character13 and _Character13:FindFirstChild('Head') then
								local _Head3 = _Character13.Head
								local _LeftHand13 = game.Players.LocalPlayer.Character.LeftHand
								pcall(function()
									firetouchinterest(_Head3, _LeftHand13, 0)
									wait(0.01)
									firetouchinterest(_Head3, _LeftHand13, 1)
								end)
								if _G.autokillplr then
									pcall(function()
										game:GetService('Players').LocalPlayer.muscleEvent:FireServer(unpack({
											'punch',
											'leftHand',
										}))
										game:GetService('Players').LocalPlayer.muscleEvent:FireServer(unpack({
											'punch',
											'rightHand',
										}))
									end)
								end
							end
						end
					end
					game:GetService('RunService').RenderStepped:Wait()
					if not _G.autokillplr then
					end
				end
			else
				_G.autokillplr = false
				return
			end
		end)
		local u682 = false
		_TinyRock = p657:AddSwitch('Proteger amigos', function(p683)
			local _LocalPlayer48 = game.Players.LocalPlayer
			if p683 then
				local v685, v686, v687 = ipairs(game.Players:GetPlayers())
				while true do
					local v688
					v687, v688 = v685(v686, v687)
					if v687 == nil then
						break
					end
					if v688:IsFriendsWith(_LocalPlayer48.UserId) and (v688.Name ~= _LocalPlayer48.Name and not table.find(u658, v688.Name)) then
						table.insert(u658, v688.Name)
					end
				end
				u682 = true
			else
				local v689, v690, v691 = ipairs(game.Players:GetPlayers())
				while true do
					local v692
					v691, v692 = v689(v690, v691)
					if v691 == nil then
						break
					end
					if v692:IsFriendsWith(_LocalPlayer48.UserId) and v692.Name ~= _LocalPlayer48.Name then
						local v693 = table.find(u658, v692.Name)
						if v693 then
							table.remove(u658, v693)
						end
					end
				end
				u682 = false
			end
		end)
		p657:AddSwitch('Karma bueno automatico', function(p694)
			autoGoodKarma = p694
			if autoGoodKarma then
				spawn(function()
					while autoGoodKarma do
						local _LocalPlayer49 = game.Players.LocalPlayer
						local _Character14 = _LocalPlayer49.Character
						local v697
						if _Character14 then
							v697 = _Character14:FindFirstChild('RightHand')
						else
							v697 = _Character14
						end
						local v698
						if _Character14 then
							v698 = _Character14:FindFirstChild('LeftHand')
						else
							v698 = _Character14
						end
						if _Character14 and (v697 and v698) then
							local v699, v700, v701 = ipairs(game.Players:GetPlayers())
							while true do
								local v702
								v701, v702 = v699(v700, v701)
								if v701 == nil then
									break
								end
								if v702 ~= _LocalPlayer49 then
									local _evilKarma3 = v702:FindFirstChild('evilKarma')
									local _goodKarma3 = v702:FindFirstChild('goodKarma')
									if _evilKarma3 and (_goodKarma3 and (_evilKarma3:IsA('IntValue') and (_goodKarma3:IsA('IntValue') and _evilKarma3.Value > _goodKarma3.Value))) then
										local _Character15 = v702.Character
										if _Character15 then
											_Character15 = _Character15:FindFirstChild('HumanoidRootPart')
										end
										if _Character15 then
											firetouchinterest(v697, _Character15, 1)
											firetouchinterest(v698, _Character15, 1)
											firetouchinterest(v697, _Character15, 0)
											firetouchinterest(v698, _Character15, 0)
										end
									end
								end
							end
						end
						task.wait(0.1)
					end
				end)
			end
		end)
		p657:AddSwitch('Karma malo automatico', function(p706)
			autoBadKarma = p706
			if autoBadKarma then
				spawn(function()
					while autoBadKarma do
						local _LocalPlayer50 = game.Players.LocalPlayer
						local _Character16 = _LocalPlayer50.Character
						local v709
						if _Character16 then
							v709 = _Character16:FindFirstChild('RightHand')
						else
							v709 = _Character16
						end
						local v710
						if _Character16 then
							v710 = _Character16:FindFirstChild('LeftHand')
						else
							v710 = _Character16
						end
						if _Character16 and (v709 and v710) then
							local v711, v712, v713 = ipairs(game.Players:GetPlayers())
							while true do
								local v714
								v713, v714 = v711(v712, v713)
								if v713 == nil then
									break
								end
								if v714 ~= _LocalPlayer50 then
									local _evilKarma4 = v714:FindFirstChild('evilKarma')
									local _goodKarma4 = v714:FindFirstChild('goodKarma')
									if _evilKarma4 and (_goodKarma4 and (_evilKarma4:IsA('IntValue') and (_goodKarma4:IsA('IntValue') and _goodKarma4.Value > _evilKarma4.Value))) then
										local _Character17 = v714.Character
										if _Character17 then
											_Character17 = _Character17:FindFirstChild('HumanoidRootPart')
										end
										if _Character17 then
											firetouchinterest(v709, _Character17, 1)
											firetouchinterest(v710, _Character17, 1)
											firetouchinterest(v709, _Character17, 0)
											firetouchinterest(v710, _Character17, 0)
										end
									end
								end
							end
						end
						task.wait(0.1)
					end
				end)
			end
		end)
	end)(_Killing)
	_Killing:AddLabel('Equipa mascotas de packs para mas daño o durabilidad')
	local _Players2 = game:GetService('Players')
	local _ReplicatedStorage3 = game:GetService('ReplicatedStorage')
	local function u729()
		local _petsFolder4 = _Players2.LocalPlayer:FindFirstChild('petsFolder')
		if _petsFolder4 then
			local v721, v722, v723 = ipairs(_petsFolder4:GetChildren())
			while true do
				local v724
				v723, v724 = v721(v722, v723)
				if v723 == nil then
					break
				end
				if v724:IsA('Folder') then
					local v725, v726, v727 = ipairs(v724:GetChildren())
					while true do
						local v728
						v727, v728 = v725(v726, v727)
						if v727 == nil then
							break
						end
						_ReplicatedStorage3.rEvents.equipPetEvent:FireServer('unequipPet', v728)
					end
				end
			end
		end
	end
	local _SelectPetType = _Killing:AddDropdown('Seleccionar mascota de pack', function(p730)
		u729()
		local _petsFolder5 = _Players2.LocalPlayer:FindFirstChild('petsFolder')
		if _petsFolder5 then
			local _Unique = _petsFolder5:FindFirstChild('Unique')
			if _Unique then
				local v733, v734, v735 = ipairs(_Unique:GetChildren())
				while true do
					local v736
					v735, v736 = v733(v734, v735)
					if v735 == nil then
						break
					end
					if v736.Name == p730 then
						_ReplicatedStorage3.rEvents.equipPetEvent:FireServer('equipPet', v736)
					end
				end
			end
		else
			return
		end
	end)
	local v738, v739, v740 = ipairs({
		'Mighty Monster',
		'Wild Wizard',
	})
	while true do
		local v741
		v740, v741 = v738(v739, v740)
		if v740 == nil then
			break
		end
		_SelectPetType:Add(v741)
	end
	(function(p742)
		p742:AddLabel('Objetivo individual:').TextSize = 22
		local _RunService2 = game:GetService('RunService')
		local _Players3 = game:GetService('Players')
		local _Workspace = game:GetService('Workspace')
		local _LocalPlayer51 = _Players3.LocalPlayer
		local u747 = false
		local u748 = nil
		local u749 = nil
		local u750 = nil
		local u751 = {}
		local u752 = {}
		local u753 = {}
		local u754 = nil
		local u755 = nil
		local u756 = nil
		local u757 = nil
		local function u761(p758)
			local v759 = {
				'',
				'K',
				'M',
				'B',
				'T',
				'Qa',
			}
			local v760 = 1
			while 1000 <= p758 and v760 < # v759 do
				p758 = p758 * 0.001
				v760 = v760 + 1
			end
			return string.format('%.2f%s', p758, v759[v760])
		end
		local function u767()
			if u755 then
				local v762, v763, v764 = ipairs(u751)
				local v765 = {}
				while true do
					local v766
					v764, v766 = v762(v763, v764)
					if v764 == nil then
						break
					end
					table.insert(v765, v766.Name)
				end
				u755.Text = 'Jugadores seleccionados: ' .. (# v765 > 0 and table.concat(v765, ', ') or 'ninguno')
			end
		end
		local function u773()
			if u756 then
				local v768, v769, v770 = ipairs(u752)
				local v771 = {}
				while true do
					local v772
					v770, v772 = v768(v769, v770)
					if v770 == nil then
						break
					end
					table.insert(v771, v772.Name)
				end
				u756.Text = 'Lista de objetivos: ' .. (# v771 > 0 and table.concat(v771, ', ') or 'ninguno')
			end
		end
		local function u776(p774)
			local v775 = _Players3:FindFirstChild(p774)
			if v775 and not table.find(u751, v775) then
				table.insert(u751, v775)
				u767()
				if u754 then
					u754:Add(v775.Name)
				end
			end
		end
		local function v778()
			if u757 then
				local v777 = _Players3:FindFirstChild(u757)
				if v777 and not table.find(u752, v777) then
					table.insert(u752, v777)
					u773()
				end
			end
		end
		local function v780()
			if u757 then
				for v779 = # u752, 1, - 1 do
					if u752[v779].Name == u757 then
						table.remove(u752, v779)
					end
				end
				u773()
			end
		end
		local function u786(p781)
			if p781 and p781.Character then
				local _Head4 = p781.Character:FindFirstChild('Head')
				local _Character18 = _LocalPlayer51.Character
				if _Character18 and _Head4 then
					local v784 = _Character18:FindFirstChild('LeftHand') or _Character18:FindFirstChild('Left Hand')
					local v785 = _Character18:FindFirstChild('RightHand') or _Character18:FindFirstChild('Right Hand')
					if v784 then
						firetouchinterest(_Head4, v784, 0)
						firetouchinterest(_Head4, v784, 1)
					end
					if v785 then
						firetouchinterest(_Head4, v785, 0)
						firetouchinterest(_Head4, v785, 1)
					end
				end
			else
				return
			end
		end
		local function u791()
			local v787, v788, v789 = ipairs(u752)
			while true do
				local v790
				v789, v790 = v787(v788, v789)
				if v789 == nil then
					break
				end
				u786(v790)
			end
		end
		local function u792()
			u747 = true
			u748 = _RunService2.Stepped:Connect(u791)
		end
		local function u793()
			u747 = false
			if u748 then
				u748:Disconnect()
				u748 = nil
			end
		end
		local function u798()
			local v794, v795, v796 = pairs(u753)
			while true do
				local v797
				v796, v797 = v794(v795, v796)
				if v796 == nil then
					break
				end
				v797:Remove()
			end
			u753 = {}
		end
		local function v813()
			u798()
			if u757 then
				local v799 = _Players3:FindFirstChild(u757)
				if v799 then
					local _Character19 = v799.Character
					if _Character19 then
						local _Humanoid5 = _Character19:FindFirstChildOfClass('Humanoid')
						local _leaderstats3 = v799:FindFirstChild('leaderstats')
						if _Humanoid5 and _leaderstats3 then
							local _Strength = _leaderstats3:FindFirstChild('Strength')
							local _Durability = _leaderstats3:FindFirstChild('Durability')
							if _Strength and _Durability then
								local v805 = p742
								table.insert(u753, v805:AddLabel('Fuerza: ' .. u761(_Strength.Value)))
								local v806 = p742
								table.insert(u753, v806:AddLabel('Durabilidad: ' .. u761(_Durability.Value)))
								local v807 = p742
								table.insert(u753, v807:AddLabel('Vida maxima: ' .. u761(_Humanoid5.MaxHealth)))
							else
								local v808 = p742
								table.insert(u753, v808:AddLabel('Estadisticas no encontradas'))
							end
						else
							local v809 = p742
							table.insert(u753, v809:AddLabel('Estadisticas no disponibles'))
						end
					else
						local v810 = p742
						table.insert(u753, v810:AddLabel('Personaje no cargado'))
						return
					end
				else
					local v811 = p742
					table.insert(u753, v811:AddLabel('Jugador no encontrado'))
					return
				end
			else
				local v812 = p742
				table.insert(u753, v812:AddLabel('Ningun jugador seleccionado'))
				return
			end
		end
		local function u815(p814)
			_Workspace.CurrentCamera.CameraSubject = p814
		end
		local function u818()
			if u757 then
				local v816 = _Players3:FindFirstChild(u757)
				if v816 then
					u815(v816.Character or v816.CharacterAdded:Wait())
					if u749 then
						u749:Disconnect()
					end
					u749 = v816.CharacterAdded:Connect(function(p817)
						u815(p817)
					end)
					u750 = v816
				end
			else
				return
			end
		end
		local function u819()
			if u749 then
				u749:Disconnect()
				u749 = nil
			end
			u815(_LocalPlayer51.Character or _LocalPlayer51.CharacterAdded:Wait())
			u750 = nil
		end
		local function v823()
			if u757 then
				local v820 = _Players3:FindFirstChild(u757)
				if v820 and v820.Character then
					local _HumanoidRootPart3 = v820.Character:FindFirstChild('HumanoidRootPart')
					local _Character20 = _LocalPlayer51.Character
					if _Character20 then
						_Character20 = _LocalPlayer51.Character:FindFirstChild('HumanoidRootPart')
					end
					if _HumanoidRootPart3 and _Character20 then
						_Character20.CFrame = _HumanoidRootPart3.CFrame
					end
				end
			else
				return
			end
		end
		local _SelectPlayers = p742:AddDropdown('Seleccionar jugadores', function(p824)
			u776(p824)
		end)
		u755 = p742:AddLabel('Jugadores seleccionados: ninguno')
		u754 = p742:AddDropdown('Jugadores seleccionados', function(p826)
			u757 = p826
			u773()
		end)
		u756 = p742:AddLabel('Lista de objetivos: ninguno')
		p742:AddButton('Agregar a objetivos', v778)
		p742:AddButton('Quitar de objetivos', v780)
		p742:AddSwitch('Atacar objetivos automaticamente', function(p827)
			if p827 then
				u792()
			else
				u793()
			end
		end)
		p742:AddSwitch('Observar jugador', function(p828)
			if p828 then
				u818()
			else
				u819()
			end
		end)
		p742:AddButton('Mostrar estadisticas', v813)
		p742:AddButton('Ir al jugador', v823)
		local v829 = _Players3
		local v830, v831, v832 = ipairs(_Players3.GetPlayers(v829))
		local u833 = u767
		local u834 = u819
		local u835 = u750
		local u836 = u752
		local u837 = u751
		local v838 = _Players3
		local u839 = u754
		local u840 = u773
		local u841 = _LocalPlayer51
		while true do
			local v842, v843 = v830(v831, v832)
			if v842 == nil then
				break
			end
			v832 = v842
			if v843 ~= u841 then
				_SelectPlayers:Add(v843.Name)
			end
		end
		v838.PlayerAdded:Connect(function(p844)
			if p844 ~= u841 then
				_SelectPlayers:Add(p844.Name)
			end
		end)
		v838.PlayerRemoving:Connect(function(p845)
			for v846 = # u837, 1, - 1 do
				if u837[v846] == p845 then
					table.remove(u837, v846)
				end
			end
			for v847 = # u836, 1, - 1 do
				if u836[v847] == p845 then
					table.remove(u836, v847)
				end
			end
			if u835 == p845 then
				u834()
			end
			u833()
			u840()
			if u839 then
				u839:Clear()
				local v848, v849, v850 = ipairs(u837)
				while true do
					local v851
					v850, v851 = v848(v849, v850)
					if v850 == nil then
						break
					end
					u839:Add(v851.Name)
				end
			end
		end)
		local _KillWhileDying = p742:AddLabel('Atacar al morir:')
		_KillWhileDying.TextColor3 = Color3.fromRGB(200, 0, 0)
		_KillWhileDying.TextSize = 22
		local _Players4 = game:GetService('Players')
		local _StarterPack = game:GetService('StarterPack')
		local _ReplicatedStorage4 = game:GetService('ReplicatedStorage')
		local _RunService3 = game:GetService('RunService')
		local _Workspace2 = game:GetService('Workspace')
		local _LocalPlayer52 = _Players4.LocalPlayer
		local _Backpack10 = _LocalPlayer52:WaitForChild('Backpack')
		local u860 = _LocalPlayer52.Character or _LocalPlayer52.CharacterAdded:Wait()
		local u861 = CFrame.new(- 20.64, 3.68, 136.23)
		local function u864(p862)
			local _Character21 = _LocalPlayer52.Character
			if _Character21 and _Character21:FindFirstChild('HumanoidRootPart') then
				_Character21.HumanoidRootPart.CFrame = p862
			end
		end
		local function u918()
			local u865 = 'Protein Egg'
			local function u871(p866)
				local v867, v868, v869 = ipairs(p866:GetDescendants())
				while true do
					local u870
					v869, u870 = v867(v868, v869)
					if v869 == nil then
						break
					end
					if u870:IsA('BasePart') then
						u870.Transparency = 0
						pcall(function()
							u870.LocalTransparencyModifier = 0
						end)
					end
				end
			end
			local function u872()
				return _LocalPlayer52.Backpack:FindFirstChild(u865) or (_StarterPack:FindFirstChild(u865) or _ReplicatedStorage4:FindFirstChild(u865))
			end
			local function u875(p873)
				if u860 and u860:FindFirstChild('Humanoid') then
					pcall(function()
						u860.Humanoid:EquipTool(p873)
					end)
					task.wait(0.1)
					if not u860:FindFirstChild(u865) then
						p873.Parent = u860
						task.wait(0.1)
					end
					local v874 = u860:FindFirstChild(u865)
					if v874 then
						u871(v874)
					end
				end
			end
			local function u883()
				if not (_G.AllAutoSwitch and u860) then
					return
				end
				local v876 = u860:FindFirstChild(u865)
				local v877 = not v876
				if v876 then
					local v878, v879, v880 = ipairs(v876:GetDescendants())
					while true do
						local v881
						v880, v881 = v878(v879, v880)
						if v880 == nil then
							break
						end
						if v881:IsA('BasePart') and v881.Transparency > 0 then
							v877 = true
							break
						end
					end
				end
				local v882 = v877 and u872()
				if v882 then
					if v882.Parent ~= _LocalPlayer52.Backpack then
						v882 = v882:Clone()
						v882.Parent = _LocalPlayer52.Backpack
					end
					u875(v882)
				end
			end
			_LocalPlayer52.CharacterAdded:Connect(function(p884)
				u860 = p884
				task.wait(1)
				u883()
			end)
			_LocalPlayer52.Backpack.ChildAdded:Connect(function(p885)
				if _G.AllAutoSwitch and p885.Name == u865 then
					task.wait(0.2)
					u883()
				end
			end)
			_G.ProteinEggLoop = task.spawn(function()
				while _G.AllAutoSwitch do
					u883()
					task.wait(0.5)
				end
			end)
			if not getgenv().AntiFlyConnection then
				getgenv().AntiFlyConnection = _RunService3.Heartbeat:Connect(function()
					if _G.AllAutoSwitch then
						local _Character22 = _LocalPlayer52.Character
						if _Character22 then
							local _HumanoidRootPart4 = _Character22:FindFirstChild('HumanoidRootPart')
							if _HumanoidRootPart4 then
								local _Humanoid6 = _Character22:FindFirstChildOfClass('Humanoid')
								if _Humanoid6 then
									local v889, v890 = _Workspace2:FindPartOnRay(Ray.new(_HumanoidRootPart4.Position, Vector3.new(0, - 500, 0)), _Character22)
									if v889 then
										local _Y = v890.Y
										if _HumanoidRootPart4.Position.Y - _Y > 0.5 then
											_HumanoidRootPart4.CFrame = CFrame.new(_HumanoidRootPart4.Position.X, _Y + 0.5, _HumanoidRootPart4.Position.Z)
											_Humanoid6.PlatformStand = true
											_Humanoid6.PlatformStand = false
										end
									end
								end
							else
								return
							end
						else
							return
						end
					else
						return
					end
				end)
			end
			local u892 = 'Protein Egg'
			local function u898(p893)
				local v894, v895, v896 = ipairs(p893:GetDescendants())
				while true do
					local u897
					v896, u897 = v894(v895, v896)
					if v896 == nil then
						break
					end
					if u897:IsA('Script') or u897:IsA('LocalScript') then
						if u897:IsA('LocalScript') then
							u897.Disabled = true
						else
							u897:Destroy()
						end
					end
					if u897:IsA('RemoteEvent') then
						pcall(function()
							function u897.FireServer()
							end
						end)
					end
				end
			end
			local function u900(p899)
				if p899.Name == u892 then
					u898(p899)
				end
			end
			local function u907(p901)
				local v902, v903, v904 = ipairs(p901:GetChildren())
				while true do
					local v905
					v904, v905 = v902(v903, v904)
					if v904 == nil then
						break
					end
					if v905:IsA('Tool') and v905.Name == u892 then
						u898(v905)
					end
				end
				p901.ChildAdded:Connect(function(p906)
					if p906:IsA('Tool') and p906.Name == u892 then
						task.defer(function()
							u898(p906)
						end)
						p906.Equipped:Connect(u900)
					end
				end)
			end
			_LocalPlayer52.CharacterAdded:Connect(function(p908)
				u907(_LocalPlayer52.Backpack)
				u907(p908)
			end)
			if _LocalPlayer52.Character then
				u907(_LocalPlayer52.Backpack)
				u907(_LocalPlayer52.Character)
			end
			_G.TropicalLoop = task.spawn(function()
				while true do
					local v909 = _G.AllAutoSwitch and _Backpack10:FindFirstChild('Tropical Shake')
					if not v909 then
						break
					end
					v909.Parent = _LocalPlayer52.Character
					_RunService3.Heartbeat:Wait()
					if v909.Activate then
						v909:Activate()
					elseif mouse1click then
						mouse1click()
					end
					task.wait(0.1)
				end
			end)
			local function u910()
				return _LocalPlayer52:FindFirstChild('muscleEvent')
			end
			_LocalPlayer52.CharacterAdded:Connect(function(p911)
				u860 = p911
			end)
			_LocalPlayer52.ChildAdded:Connect(function(p912)
				if p912.Name == 'Backpack' then
					_Backpack10 = p912
				end
			end)
			_G.PunchLoop = task.spawn(function()
				while _G.AllAutoSwitch do
					local v913 = u910()
					u860 = _LocalPlayer52.Character
					if u860 and (u860:FindFirstChild('Humanoid') and v913) then
						local _Punch6 = u860:FindFirstChild('Punch')
						local _Punch7 = _Backpack10:FindFirstChild('Punch')
						if not _Punch6 and _Punch7 then
							u860.Humanoid:EquipTool(_Punch7)
						end
						v913:FireServer('punch', 'rightHand')
					end
					task.wait(0.0001)
				end
			end)
			_G.SizeLoop = task.spawn(function()
				while _G.AllAutoSwitch do
					_ReplicatedStorage4.rEvents.changeSpeedSizeRemote:InvokeServer('changeSize', math.huge * 0)
					task.wait()
				end
			end)
			if not getgenv().LockPositionConnection then
				getgenv().LockPositionConnection = _RunService3.Heartbeat:Connect(function()
					if _G.AllAutoSwitch then
						local _Character23 = _LocalPlayer52.Character
						if _Character23 and _Character23:FindFirstChild('HumanoidRootPart') then
							_Character23.HumanoidRootPart.CFrame = u861
						end
					end
				end)
			end
			_LocalPlayer52.CharacterAdded:Connect(function(p917)
				p917:WaitForChild('HumanoidRootPart')
				task.wait(0.2)
				if _G.AllAutoSwitch then
					u864(u861)
				end
			end)
			if _LocalPlayer52.Character and _LocalPlayer52.Character:FindFirstChild('HumanoidRootPart') then
				u864(u861)
			end
		end
		local function u923()
			local v919, v920, v921 = ipairs({
				'ProteinEggLoop',
				'TropicalLoop',
				'PunchLoop',
				'SizeLoop',
			})
			while true do
				local v922
				v921, v922 = v919(v920, v921)
				if v921 == nil then
					break
				end
				if _G[v922] then
					task.cancel(_G[v922])
					_G[v922] = nil
				end
			end
			if getgenv().LockPositionConnection then
				getgenv().LockPositionConnection:Disconnect()
				getgenv().LockPositionConnection = nil
			end
			_ReplicatedStorage4.rEvents.changeSpeedSizeRemote:InvokeServer('changeSize', 2)
		end
		p742:AddSwitch('Combo de tamaño NaN', function(p924)
			_G.AllAutoSwitch = p924
			if p924 then
				u918()
				print('Todas las funciones automaticas ACTIVADAS')
			else
				u923()
				print('Todas las funciones automaticas DESACTIVADAS')
			end
		end, 'Enable/Disable ALL automation features at once!')
		p742:AddSwitch('Anti empuje [Importante]', function(p925)
			if p925 then
				local _CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
				getgenv().posLock = game:GetService('RunService').Heartbeat:Connect(function()
					if game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart') then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = _CFrame
					end
				end)
			elseif getgenv().posLock then
				getgenv().posLock:Disconnect()
				getgenv().posLock = nil
			end
		end)
		local _Players5 = game:GetService('Players')
		local _RunService4 = game:GetService('RunService')
		local _CurrentCamera = game:GetService('Workspace').CurrentCamera
		local _LocalPlayer53 = _Players5.LocalPlayer
		local u931 = {
			targetPlayerName = nil,
			killTarget = false,
			isSpying = false,
			spyConnection = nil,
		}
		local _SelectTargetPlayer = p742:AddDropdown('Seleccionar objetivo', function(p932)
			u931.targetPlayerName = p932
			print(p932 == 'Ninguno' and 'Ningun objetivo seleccionado' or 'Objetivo seleccionado: ' .. p932)
		end)
		_SelectTargetPlayer:Add('Ninguno')
		local v934, v935, v936 = ipairs(_Players5:GetPlayers())
		local u937 = u931
		while true do
			local v938
			v936, v938 = v934(v935, v936)
			if v936 == nil then
				break
			end
			if v938 ~= _LocalPlayer53 then
				_SelectTargetPlayer:Add(v938.Name)
			end
		end
		_Players5.PlayerAdded:Connect(function(p939)
			if p939 ~= _LocalPlayer53 then
				_SelectTargetPlayer:Add(p939.Name)
			end
		end)
		_Players5.PlayerRemoving:Connect(function(p940)
			_SelectTargetPlayer:Remove(p940.Name)
		end)
		local u941 = nil
		p742:AddSwitch('Golpe rapido', function(p942)
			local _LocalPlayer54 = game.Players.LocalPlayer
			if p942 then
				_G.punchanim = true
				if u941 then
					u941:Disconnect()
				end
				u941 = game:GetService('RunService').Heartbeat:Connect(function()
					if _G.punchanim then
						local _Character24 = _LocalPlayer54.Character
						if _Character24 then
							local _Humanoid7 = _Character24:FindFirstChildOfClass('Humanoid')
							local v946 = _LocalPlayer54.Backpack:FindFirstChild('Punch') or _Character24:FindFirstChild('Punch')
							if v946 then
								local _attackTime3 = v946:FindFirstChild('attackTime')
								if _attackTime3 then
									_attackTime3.Value = 0
								end
								if _Humanoid7 and v946.Parent ~= _Character24 then
									_Humanoid7:EquipTool(v946)
								end
								v946:Activate()
							end
						end
					else
						if u941 then
							u941:Disconnect()
							u941 = nil
						end
						return
					end
				end)
			else
				_G.punchanim = false
				if u941 then
					u941:Disconnect()
					u941 = nil
				end
				local _Punch8 = _LocalPlayer54.Backpack:FindFirstChild('Punch')
				local _Character25 = _LocalPlayer54.Character
				if _Character25 then
					_Character25 = _LocalPlayer54.Character:FindFirstChild('Punch')
				end
				local v950 = _Punch8 or _Character25
				if v950 and v950:FindFirstChild('attackTime') then
					v950.attackTime.Value = 0.35
				end
			end
		end)
		p742:AddSwitch('Atacar objetivo [ACTIVA GOLPE]', function(p951)
			u937.killTarget = p951
			if p951 then
				if u937.targetPlayerName and u937.targetPlayerName ~= 'Ninguno' then
					task.spawn(function()
						while u937.killTarget do
							local v952 = _Players5:FindFirstChild(u937.targetPlayerName)
							if v952 and v952 ~= _LocalPlayer53 then
								local _Character26 = v952.Character
								if _Character26 then
									_Character26 = _Character26:FindFirstChild('HumanoidRootPart')
								end
								if _Character26 then
									local _Character27 = _LocalPlayer53.Character
									if _Character27 then
										_Character27 = _LocalPlayer53.Character:FindFirstChild('RightHand')
									end
									local _Character28 = _LocalPlayer53.Character
									if _Character28 then
										_Character28 = _LocalPlayer53.Character:FindFirstChild('LeftHand')
									end
									if _Character27 and _Character28 then
										firetouchinterest(_Character27, _Character26, 1)
										firetouchinterest(_Character28, _Character26, 1)
										firetouchinterest(_Character27, _Character26, 0)
										firetouchinterest(_Character28, _Character26, 0)
									end
								end
							end
							task.wait(0.1)
						end
					end)
					print('Ataque rapido automatico: ' .. u937.targetPlayerName)
				else
					print('Selecciona un objetivo en la lista')
				end
			else
				u937.killTarget = false
				print('Ataque rapido automatico desactivado')
			end
		end):Set(false)
		p742:AddSwitch('Observar objetivo', function(p956)
			u937.isSpying = p956
			if p956 then
				if u937.targetPlayerName and u937.targetPlayerName ~= 'Ninguno' then
					_CurrentCamera.CameraType = Enum.CameraType.Scriptable
					if u937.spyConnection then
						u937.spyConnection:Disconnect()
					end
					u937.spyConnection = _RunService4.RenderStepped:Connect(function()
						if u937.isSpying then
							local v957 = _Players5:FindFirstChild(u937.targetPlayerName)
							local v958 = v957 and v957.Character and v957.Character:FindFirstChild('HumanoidRootPart')
							if v958 then
								_CurrentCamera.CFrame = CFrame.new(v958.Position + Vector3.new(0, 5, 10), v958.Position)
							end
						else
							if u937.spyConnection then
								u937.spyConnection:Disconnect()
								u937.spyConnection = nil
							end
							_CurrentCamera.CameraType = Enum.CameraType.Custom
							local v959 = _CurrentCamera
							local _Character29 = _LocalPlayer53.Character
							if _Character29 then
								_Character29 = _LocalPlayer53.Character:FindFirstChildOfClass('Humanoid')
							end
							v959.CameraSubject = _Character29
						end
					end)
					print('Observando a: ' .. u937.targetPlayerName)
				else
					print('Selecciona un objetivo en la lista')
				end
			else
				u937.isSpying = false
				if u937.spyConnection then
					u937.spyConnection:Disconnect()
					u937.spyConnection = nil
				end
				_CurrentCamera.CameraType = Enum.CameraType.Custom
				local v961 = _CurrentCamera
				local _Character30 = _LocalPlayer53.Character
				if _Character30 then
					_Character30 = _LocalPlayer53.Character:FindFirstChildOfClass('Humanoid')
				end
				v961.CameraSubject = _Character30
				print('Observacion desactivada')
			end
		end):Set(false)
	end)(_Killing)
	_Killing:AddLabel('')
	_Killing:AddLabel('Compra la version de pago para mas opciones.')
	local _Ultimates = _EnchantedHubMuscleLegends:AddTab('Mejoras')
	_Ultimates:Show()
	local _ReplicatedStorage5 = game:GetService('ReplicatedStorage')
	local _ultimatesRemote = _ReplicatedStorage5:WaitForChild('rEvents'):WaitForChild('ultimatesRemote')
	local u966 = nil
	local _UpgradeUltimate = _Ultimates:AddDropdown('Seleccionar mejora', function(p967)
		u966 = p967
	end)
	local v969, v970, v971 = ipairs({
		'RepSpeed',
		'PetSlot',
		'ItemCapacity',
		'DailySpin',
		'ChestRewards',
		'QuestRewards',
		'MuscleMind',
		'JungleSwift',
		'InfernalHealth',
		'GalaxyGains',
		'DemonDamage',
		'GoldenRebirth',
	})
	local u972 = u966
	while true do
		local v973
		v971, v973 = v969(v970, v971)
		if v971 == nil then
			break
		end
		_UpgradeUltimate:Add(v973)
	end
	_Ultimates:AddSwitch('Comprar mejora seleccionada', function(p974)
		if p974 and u972 then
			_ultimatesRemote:InvokeServer('upgradeUltimate', u972)
		end
	end);
	(function(p975)
		local u976 = {
			TimeSpent = p975:AddLabel('Tiempo de ejecucion: 00:00'),
			Strength = p975:AddLabel('Fuerza ganada: 0'),
			Durability = p975:AddLabel('Durabilidad ganada: 0'),
			Agility = p975:AddLabel('Agilidad ganada: 0'),
			Kills = p975:AddLabel('Bajas ganadas: 0'),
			EvilKarma = p975:AddLabel('Karma malo: 0'),
			GoodKarma = p975:AddLabel('Karma bueno: 0'),
		}
		local v977 = {
			TimeSpent = Color3.fromRGB(0, 255, 245),
			Strength = Color3.fromRGB(255, 50, 100),
			Durability = Color3.fromRGB(50, 255, 50),
			Agility = Color3.fromRGB(255, 215, 0),
			Kills = Color3.fromRGB(255, 105, 180),
			EvilKarma = Color3.fromRGB(128, 0, 255),
			GoodKarma = Color3.fromRGB(0, 191, 255),
		}
		local statNames = {
			Strength = 'Fuerza ganada',
			Durability = 'Durabilidad ganada',
			Agility = 'Agilidad ganada',
			Kills = 'Bajas ganadas',
			EvilKarma = 'Karma malo',
			GoodKarma = 'Karma bueno',
		}
		local v978, v979, v980 = pairs(u976)
		local function u982(p981)
			if p981 >= 1000000000000000 then
				return string.format('%.1fQa', p981 / 1000000000000000)
			elseif p981 >= 1000000000000 then
				return string.format('%.1fT', p981 / 1000000000000)
			elseif p981 >= 1000000000 then
				return string.format('%.1fB', p981 / 1000000000)
			elseif p981 >= 1000000 then
				return string.format('%.1fM', p981 / 1000000)
			elseif p981 >= 1000 then
				return string.format('%.1fK', p981 / 1000)
			else
				return tostring(p981)
			end
		end
		while true do
			local v983
			v980, v983 = v978(v979, v980)
			if v980 == nil then
				break
			end
			v983.TextColor3 = v977[v980]
			v983.TextStrokeTransparency = 0.7
			v983.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
		end
		(function()
			local _LocalPlayer55 = game.Players.LocalPlayer
			if _LocalPlayer55 then
				local _leaderstats4 = _LocalPlayer55:WaitForChild('leaderstats')
				if _leaderstats4 then
					local u987 = {
						Strength = _leaderstats4:WaitForChild('Strength'),
						Durability = _LocalPlayer55:WaitForChild('Durability'),
						Agility = _LocalPlayer55:WaitForChild('Agility'),
						Kills = _leaderstats4:WaitForChild('Kills'),
						EvilKarma = _LocalPlayer55:WaitForChild('evilKarma'),
						GoodKarma = _LocalPlayer55:WaitForChild('goodKarma'),
					}
					local v988, v989, v990 = pairs(u987)
					local u991 = {}
					while true do
						local v992
						v990, v992 = v988(v989, v990)
						if v990 == nil then
							break
						end
						u991[v990] = v992.Value or 0
					end
					local u993 = tick()
					local function v999()
						local v994, v995, v996 = pairs(u987)
						while true do
							local v997
							v996, v997 = v994(v995, v996)
							if v996 == nil then
								break
							end
							local v998 = v997.Value - u991[v996]
							u976[v996].Text = statNames[v996] .. ': ' .. u982(v998)
						end
					end
					local function v1003()
						local v1000 = tick() - u993
						local v1001 = math.floor(v1000 / 60)
						local v1002 = math.floor(v1000 % 60)
						u976.TimeSpent.Text = string.format('Tiempo de ejecucion: %02d:%02d', v1001, v1002)
					end
					local v1004, v1005, v1006 = pairs(u987)
					while true do
						local v1007
						v1006, v1007 = v1004(v1005, v1006)
						if v1006 == nil then
							break
						end
						v1007.Changed:Connect(v999)
					end
					game:GetService('RunService').Heartbeat:Connect(v1003)
					v999()
				end
			else
				return
			end
		end)()
	end)((_EnchantedHubMuscleLegends:AddTab('Estadisticas')))
	local _ViewStats = _EnchantedHubMuscleLegends:AddTab('Ver estadisticas')
	local u1009 = nil
	local u1010 = {}
	local _LocalPlayer56 = game.Players.LocalPlayer
	local function u1013()
		if u1009 then
			local _leaderstats5 = u1009:FindFirstChild('leaderstats')
			u1010 = {
				Strength = _leaderstats5 and _leaderstats5:FindFirstChild('Strength') and (_leaderstats5.Strength.Value or 0) or 0,
				Durability = u1009:FindFirstChild('Durability') and u1009.Durability.Value or 0,
				Agility = u1009:FindFirstChild('Agility') and u1009.Agility.Value or 0,
				Rebirths = _leaderstats5 and _leaderstats5:FindFirstChild('Rebirths') and (_leaderstats5.Rebirths.Value or 0) or 0,
				Kills = _leaderstats5 and (_leaderstats5:FindFirstChild('Kills') and _leaderstats5.Kills.Value) or 0,
				EvilKarma = u1009:FindFirstChild('evilKarma') and u1009.evilKarma.Value or 0,
				GoodKarma = u1009:FindFirstChild('goodKarma') and u1009.goodKarma.Value or 0,
			}
		end
	end
	local u1014 = {
		ViewStats = _ViewStats:AddLabel('Ver estadisticas:'),
		StrengthLabel = _ViewStats:AddLabel('Fuerza: 0'),
		DurabilityLabel = _ViewStats:AddLabel('Durabilidad: 0'),
		AgilityLabel = _ViewStats:AddLabel('Agilidad: 0'),
		RebirthsLabel = _ViewStats:AddLabel('Renacimientos: 0'),
		KillsLabel = _ViewStats:AddLabel('Bajas: 0'),
		EvilKarmaLabel = _ViewStats:AddLabel('Karma malo: 0'),
		GoodKarmaLabel = _ViewStats:AddLabel('Karma bueno: 0'),
		HitsToKillLabel = _ViewStats:AddLabel('Golpes para vencer: N/D'),
		StatsGainedLabel = _ViewStats:AddLabel('Ganado en el servidor:'),
		StrengthGainedLabel = _ViewStats:AddLabel('Fuerza: 0'),
		DurabilityGainedLabel = _ViewStats:AddLabel('Durabilidad: 0'),
		AgilityGainedLabel = _ViewStats:AddLabel('Agilidad: 0'),
		RebirthsGainedLabel = _ViewStats:AddLabel('Renacimientos: 0'),
		KillsGainedLabel = _ViewStats:AddLabel('Bajas: 0'),
		EvilKarmaGainedLabel = _ViewStats:AddLabel('Karma malo: 0'),
		GoodKarmaGainedLabel = _ViewStats:AddLabel('Karma bueno: 0'),
	}
	local function u1019()
		if not (u1009 and _LocalPlayer56) then
			return 'N/A'
		end
		local _Durability2 = u1009:FindFirstChild('Durability')
		local _leaderstats6 = _LocalPlayer56:FindFirstChild('leaderstats')
		if _leaderstats6 then
			_leaderstats6 = _leaderstats6:FindFirstChild('Strength')
		end
		if not (_Durability2 and _leaderstats6) then
			return 'N/A'
		end
		local _Value3 = _Durability2.Value
		local v1018 = _leaderstats6.Value * 0.1
		return v1018 <= 0 and '\u{221e}' or math.ceil(_Value3 / v1018)
	end
	local function u1029()
		if u1009 then
			local _leaderstats7 = u1009:FindFirstChild('leaderstats')
			local _goodKarma5 = u1009:FindFirstChild('goodKarma')
			local _evilKarma5 = u1009:FindFirstChild('evilKarma')
			if _leaderstats7 then
				u1014.StrengthLabel.Text = 'Fuerza: ' .. abbreviateNumber(_leaderstats7:FindFirstChild('Strength') and (_leaderstats7.Strength.Value or 0) or 0)
				local v1023 = u1009
				u1014.DurabilityLabel.Text = 'Durabilidad: ' .. abbreviateNumber(v1023:FindFirstChild('Durability') and u1009.Durability.Value or 0)
				local v1024 = u1009
				u1014.AgilityLabel.Text = 'Agilidad: ' .. abbreviateNumber(v1024:FindFirstChild('Agility') and u1009.Agility.Value or 0)
				u1014.RebirthsLabel.Text = 'Renacimientos: ' .. abbreviateNumber(_leaderstats7:FindFirstChild('Rebirths') and (_leaderstats7.Rebirths.Value or 0) or 0)
				u1014.KillsLabel.Text = 'Bajas: ' .. abbreviateNumber(_leaderstats7:FindFirstChild('Kills') and (_leaderstats7.Kills.Value or 0) or 0)
			end
			u1014.EvilKarmaLabel.Text = 'Karma malo: ' .. abbreviateNumber(_evilKarma5 and _evilKarma5.Value or 0)
			u1014.GoodKarmaLabel.Text = 'Karma bueno: ' .. abbreviateNumber(_goodKarma5 and _goodKarma5.Value or 0)
			if u1010 then
				u1014.StrengthGainedLabel.Text = 'Fuerza: ' .. abbreviateNumber((_leaderstats7 and _leaderstats7:FindFirstChild('Strength') and (_leaderstats7.Strength.Value or 0) or 0) - u1010.Strength)
				local v1025 = u1009
				u1014.DurabilityGainedLabel.Text = 'Durabilidad: ' .. abbreviateNumber((v1025:FindFirstChild('Durability') and u1009.Durability.Value or 0) - u1010.Durability)
				local v1026 = u1009
				u1014.AgilityGainedLabel.Text = 'Agilidad: ' .. abbreviateNumber((v1026:FindFirstChild('Agility') and u1009.Agility.Value or 0) - u1010.Agility)
				u1014.RebirthsGainedLabel.Text = 'Renacimientos: ' .. abbreviateNumber((_leaderstats7 and _leaderstats7:FindFirstChild('Rebirths') and (_leaderstats7.Rebirths.Value or 0) or 0) - u1010.Rebirths)
				u1014.KillsGainedLabel.Text = 'Bajas: ' .. abbreviateNumber((_leaderstats7 and (_leaderstats7:FindFirstChild('Kills') and _leaderstats7.Kills.Value) or 0) - u1010.Kills)
				local v1027 = u1009
				u1014.EvilKarmaGainedLabel.Text = 'Karma malo: ' .. abbreviateNumber((v1027:FindFirstChild('evilKarma') and u1009.evilKarma.Value or 0) - u1010.EvilKarma)
				local v1028 = u1009
				u1014.GoodKarmaGainedLabel.Text = 'Karma bueno: ' .. abbreviateNumber((v1028:FindFirstChild('goodKarma') and u1009.goodKarma.Value or 0) - u1010.GoodKarma)
			end
			u1014.HitsToKillLabel.Text = 'Golpes para vencer: ' .. tostring(u1019())
		end
	end
	local function u1030()
		u1014.StrengthLabel.Text = 'Fuerza: 0'
		u1014.DurabilityLabel.Text = 'Durabilidad: 0'
		u1014.AgilityLabel.Text = 'Agilidad: 0'
		u1014.RebirthsLabel.Text = 'Renacimientos: 0'
		u1014.KillsLabel.Text = 'Bajas: 0'
		u1014.EvilKarmaLabel.Text = 'Karma malo: 0'
		u1014.GoodKarmaLabel.Text = 'Karma bueno: 0'
		u1014.StrengthGainedLabel.Text = 'Fuerza: 0'
		u1014.DurabilityGainedLabel.Text = 'Durabilidad: 0'
		u1014.AgilityGainedLabel.Text = 'Agilidad: 0'
		u1014.RebirthsGainedLabel.Text = 'Renacimientos: 0'
		u1014.KillsGainedLabel.Text = 'Bajas: 0'
		u1014.EvilKarmaGainedLabel.Text = 'Karma malo: 0'
		u1014.GoodKarmaGainedLabel.Text = 'Karma bueno: 0'
		u1014.HitsToKillLabel.Text = 'Golpes para vencer: N/D'
	end
	local _SelectPlayer = _ViewStats:AddDropdown('Seleccionar jugador', function(p1031)
		local v1032 = game.Players:FindFirstChild(p1031)
		if v1032 then
			u1009 = v1032
			u1013()
		else
			u1009 = nil
			u1030()
		end
	end)
	local v1034, v1035, v1036 = ipairs(game.Players:GetPlayers())
	local u1037 = u1009
	while true do
		local v1038
		v1036, v1038 = v1034(v1035, v1036)
		if v1036 == nil then
			break
		end
		_SelectPlayer:Add(v1038.Name)
	end
	task.spawn(function()
		while task.wait(0.1) do
			if u1037 then
				u1029()
			end
		end
	end)
	_ViewStats:AddLabel('---------------')
	_ViewStats:AddLabel('Estadisticas V2:').TextSize = 22
	(function(p1039)
		local _ViewStatsV1 = p1039:AddFolder('Estadisticas V1')
		local _Players6 = game:GetService('Players')
		local _LocalPlayer57 = _Players6.LocalPlayer
		local u1043 = {
			targetPlayer = nil,
			initialStats = {
				Strength = 0,
				Durability = 0,
				Agility = 0,
				Rebirths = 0,
				Kills = 0,
				EvilKarma = 0,
				GoodKarma = 0,
			},
			emojiMap = {
				Time = utf8.char(128347),
				Stats = utf8.char(128202),
				Strength = utf8.char(128170),
				Rebirths = utf8.char(128260),
				Durability = utf8.char(128737),
				Kills = utf8.char(128128),
				Agility = utf8.char(127939),
				EvilKarma = utf8.char(128520),
				GoodKarma = utf8.char(128519),
				Brawls = utf8.char(129354),
			},
			nameMap = {
				Strength = 'Fuerza',
				Rebirths = 'Renacimientos',
				Durability = 'Durabilidad',
				Kills = 'Bajas',
				Agility = 'Agilidad',
				EvilKarma = 'Karma malo',
				GoodKarma = 'Karma bueno',
			},
			labels = {},
		}
		local function u1047(p1044)
			if p1044 < 1000 then
				return tostring(p1044)
			end
			local v1045 = math.floor(math.log10(p1044) / 3)
			local v1046 = p1044 / 10 ^ (v1045 * 3)
			return string.format('%.1f%s', v1046, ({
				'K',
				'M',
				'B',
				'T',
			})[v1045] or '')
		end
		local function u1049()
			if u1043.targetPlayer then
				local _leaderstats8 = u1043.targetPlayer:FindFirstChild('leaderstats')
				u1043.initialStats = {
					Strength = _leaderstats8 and _leaderstats8:FindFirstChild('Strength') and (_leaderstats8.Strength.Value or 0) or 0,
					Durability = u1043.targetPlayer:FindFirstChild('Durability') and u1043.targetPlayer.Durability.Value or 0,
					Agility = u1043.targetPlayer:FindFirstChild('Agility') and u1043.targetPlayer.Agility.Value or 0,
					Rebirths = _leaderstats8 and _leaderstats8:FindFirstChild('Rebirths') and (_leaderstats8.Rebirths.Value or 0) or 0,
					Kills = _leaderstats8 and (_leaderstats8:FindFirstChild('Kills') and _leaderstats8.Kills.Value) or 0,
					EvilKarma = u1043.targetPlayer:FindFirstChild('evilKarma') and u1043.targetPlayer.evilKarma.Value or 0,
					GoodKarma = u1043.targetPlayer:FindFirstChild('goodKarma') and u1043.targetPlayer.goodKarma.Value or 0,
				}
			end
		end
		local function u1054()
			if not (u1043.targetPlayer and _LocalPlayer57) then
				return 'N/A'
			end
			local _Durability3 = u1043.targetPlayer:FindFirstChild('Durability')
			local _leaderstats9 = _LocalPlayer57:FindFirstChild('leaderstats')
			if _leaderstats9 then
				_leaderstats9 = _leaderstats9:FindFirstChild('Strength')
			end
			if not (_Durability3 and _leaderstats9) then
				return 'N/A'
			end
			local _Value4 = _Durability3.Value
			local v1053 = _leaderstats9.Value * 0.1
			return v1053 <= 0 and '\u{221e}' or math.ceil(_Value4 / v1053)
		end
		local function u1058()
			if u1043.targetPlayer then
				local _leaderstats10 = u1043.targetPlayer:FindFirstChild('leaderstats')
				local _goodKarma6 = u1043.targetPlayer:FindFirstChild('goodKarma')
				local _evilKarma6 = u1043.targetPlayer:FindFirstChild('evilKarma')
				if _leaderstats10 then
					u1043.labels.StrengthLabel.Text = u1043.emojiMap.Strength .. ' Fuerza: ' .. u1047(_leaderstats10:FindFirstChild('Strength') and (_leaderstats10.Strength.Value or 0) or 0)
					u1043.labels.DurabilityLabel.Text = u1043.emojiMap.Durability .. ' Durabilidad: ' .. u1047(u1043.targetPlayer:FindFirstChild('Durability') and u1043.targetPlayer.Durability.Value or 0)
					u1043.labels.AgilityLabel.Text = u1043.emojiMap.Agility .. ' Agilidad: ' .. u1047(u1043.targetPlayer:FindFirstChild('Agility') and u1043.targetPlayer.Agility.Value or 0)
					u1043.labels.RebirthsLabel.Text = u1043.emojiMap.Rebirths .. ' Renacimientos: ' .. u1047(_leaderstats10:FindFirstChild('Rebirths') and (_leaderstats10.Rebirths.Value or 0) or 0)
					u1043.labels.KillsLabel.Text = u1043.emojiMap.Kills .. ' Bajas: ' .. u1047(_leaderstats10:FindFirstChild('Kills') and (_leaderstats10.Kills.Value or 0) or 0)
				end
				u1043.labels.EvilKarmaLabel.Text = u1043.emojiMap.EvilKarma .. ' Karma malo: ' .. u1047(_evilKarma6 and _evilKarma6.Value or 0)
				u1043.labels.GoodKarmaLabel.Text = u1043.emojiMap.GoodKarma .. ' Karma bueno: ' .. u1047(_goodKarma6 and _goodKarma6.Value or 0)
				if u1043.initialStats then
					u1043.labels.StrengthGainedLabel.Text = u1043.emojiMap.Strength .. ' Fuerza: ' .. u1047((_leaderstats10 and _leaderstats10:FindFirstChild('Strength') and (_leaderstats10.Strength.Value or 0) or 0) - u1043.initialStats.Strength)
					u1043.labels.DurabilityGainedLabel.Text = u1043.emojiMap.Durability .. ' Durabilidad: ' .. u1047((u1043.targetPlayer:FindFirstChild('Durability') and u1043.targetPlayer.Durability.Value or 0) - u1043.initialStats.Durability)
					u1043.labels.AgilityGainedLabel.Text = u1043.emojiMap.Agility .. ' Agilidad: ' .. u1047((u1043.targetPlayer:FindFirstChild('Agility') and u1043.targetPlayer.Agility.Value or 0) - u1043.initialStats.Agility)
					u1043.labels.RebirthsGainedLabel.Text = u1043.emojiMap.Rebirths .. ' Renacimientos: ' .. u1047((_leaderstats10 and _leaderstats10:FindFirstChild('Rebirths') and (_leaderstats10.Rebirths.Value or 0) or 0) - u1043.initialStats.Rebirths)
					u1043.labels.KillsGainedLabel.Text = u1043.emojiMap.Kills .. ' Bajas: ' .. u1047((_leaderstats10 and (_leaderstats10:FindFirstChild('Kills') and _leaderstats10.Kills.Value) or 0) - u1043.initialStats.Kills)
					u1043.labels.EvilKarmaGainedLabel.Text = u1043.emojiMap.EvilKarma .. ' Karma malo: ' .. u1047((u1043.targetPlayer:FindFirstChild('evilKarma') and u1043.targetPlayer.evilKarma.Value or 0) - u1043.initialStats.EvilKarma)
					u1043.labels.GoodKarmaGainedLabel.Text = u1043.emojiMap.GoodKarma .. ' Karma bueno: ' .. u1047((u1043.targetPlayer:FindFirstChild('goodKarma') and u1043.targetPlayer.goodKarma.Value or 0) - u1043.initialStats.GoodKarma)
				end
				u1043.labels.HitsToKillLabel.Text = u1043.emojiMap.Kills .. ' Golpes para vencer: ' .. tostring(u1054())
			end
		end
		local function u1064()
			local v1059, v1060, v1061 = pairs(u1043.labels)
			while true do
				local v1062
				v1061, v1062 = v1059(v1060, v1061)
				if v1061 == nil then
					break
				end
				if v1061 ~= 'ViewStats' and v1061 ~= 'StatsGainedLabel' then
					local _Gained = v1061:gsub('Label', ''):gsub('Gained', '')
					v1062.Text = (u1043.emojiMap[_Gained] or '') .. ' ' .. (u1043.nameMap[_Gained] or _Gained) .. ': 0'
				end
			end
			u1043.labels.HitsToKillLabel.Text = u1043.emojiMap.Kills .. ' Golpes para vencer: N/D'
		end
		local function v1071()
			local v1065 = u1043
			local v1066 = {
				ViewStats = _ViewStatsV1:AddLabel(u1043.emojiMap.Stats .. ' Ver estadisticas:'),
				StrengthLabel = _ViewStatsV1:AddLabel(u1043.emojiMap.Strength .. ' Fuerza: 0'),
				DurabilityLabel = _ViewStatsV1:AddLabel(u1043.emojiMap.Durability .. ' Durabilidad: 0'),
				AgilityLabel = _ViewStatsV1:AddLabel(u1043.emojiMap.Agility .. ' Agilidad: 0'),
				RebirthsLabel = _ViewStatsV1:AddLabel(u1043.emojiMap.Rebirths .. ' Renacimientos: 0'),
				KillsLabel = _ViewStatsV1:AddLabel(u1043.emojiMap.Kills .. ' Bajas: 0'),
				EvilKarmaLabel = _ViewStatsV1:AddLabel(u1043.emojiMap.EvilKarma .. ' Karma malo: 0'),
				GoodKarmaLabel = _ViewStatsV1:AddLabel(u1043.emojiMap.GoodKarma .. ' Karma bueno: 0'),
				HitsToKillLabel = _ViewStatsV1:AddLabel(u1043.emojiMap.Kills .. ' Golpes para vencer: N/D'),
				StatsGainedLabel = _ViewStatsV1:AddLabel(u1043.emojiMap.Stats .. ' Ganado en el servidor:'),
				StrengthGainedLabel = _ViewStatsV1:AddLabel(u1043.emojiMap.Strength .. ' Fuerza: 0'),
				DurabilityGainedLabel = _ViewStatsV1:AddLabel(u1043.emojiMap.Durability .. ' Durabilidad: 0'),
				AgilityGainedLabel = _ViewStatsV1:AddLabel(u1043.emojiMap.Agility .. ' Agilidad: 0'),
				RebirthsGainedLabel = _ViewStatsV1:AddLabel(u1043.emojiMap.Rebirths .. ' Renacimientos: 0'),
				KillsGainedLabel = _ViewStatsV1:AddLabel(u1043.emojiMap.Kills .. ' Bajas: 0'),
				EvilKarmaGainedLabel = _ViewStatsV1:AddLabel(u1043.emojiMap.EvilKarma .. ' Karma malo: 0'),
				GoodKarmaGainedLabel = _ViewStatsV1:AddLabel(u1043.emojiMap.GoodKarma .. ' Karma bueno: 0'),
			}
			v1065.labels = v1066
			local v1067, v1068, v1069 = pairs(u1043.labels)
			while true do
				local v1070
				v1069, v1070 = v1067(v1068, v1069)
				if v1069 == nil then
					break
				end
				v1070.TextSize = 22
			end
			u1043.labels.ViewStats.TextColor3 = Color3.fromRGB(255, 215, 0)
			u1043.labels.StrengthLabel.TextColor3 = Color3.fromRGB(200, 0, 0)
			u1043.labels.DurabilityLabel.TextColor3 = Color3.fromRGB(0, 128, 255)
			u1043.labels.AgilityLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
			u1043.labels.RebirthsLabel.TextColor3 = Color3.fromRGB(255, 105, 180)
			u1043.labels.KillsLabel.TextColor3 = Color3.fromRGB(255, 69, 0)
			u1043.labels.EvilKarmaLabel.TextColor3 = Color3.fromRGB(128, 0, 128)
			u1043.labels.GoodKarmaLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
			u1043.labels.HitsToKillLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
			u1043.labels.StatsGainedLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
			u1043.labels.StrengthGainedLabel.TextColor3 = Color3.fromRGB(200, 0, 0)
			u1043.labels.DurabilityGainedLabel.TextColor3 = Color3.fromRGB(0, 128, 255)
			u1043.labels.AgilityGainedLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
			u1043.labels.RebirthsGainedLabel.TextColor3 = Color3.fromRGB(255, 105, 180)
			u1043.labels.KillsGainedLabel.TextColor3 = Color3.fromRGB(255, 69, 0)
			u1043.labels.EvilKarmaGainedLabel.TextColor3 = Color3.fromRGB(128, 0, 128)
			u1043.labels.GoodKarmaGainedLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
		end
		local v1072 = _ViewStatsV1
		local u1075 = _ViewStatsV1.AddDropdown(v1072, 'Seleccionar jugador', function(p1073)
			local _ = not (p1073 == 'Ninguno')
			local v1074 = _Players6:FindFirstChild(p1073)
			u1043.targetPlayer = v1074
			if v1074 then
				u1049()
			else
				u1064()
			end
		end)
		u1075:Add('Ninguno')
		local v1076 = _Players6
		local v1077, v1078, v1079 = ipairs(_Players6.GetPlayers(v1076))
		local u1080 = u1064
		local u1081 = u1043
		local v1082 = _Players6
		local u1083 = _LocalPlayer57
		while true do
			local v1084
			v1079, v1084 = v1077(v1078, v1079)
			if v1079 == nil then
				break
			end
			if v1084 ~= u1083 then
				u1075:Add(v1084.Name)
			end
		end
		v1082.PlayerAdded:Connect(function(p1085)
			if p1085 ~= u1083 then
				u1075:Add(p1085.Name)
			end
		end)
		v1082.PlayerRemoving:Connect(function(p1086)
			u1075:Remove(p1086.Name)
			if u1081.targetPlayer and u1081.targetPlayer == p1086 then
				u1081.targetPlayer = nil
				u1080()
			end
		end)
		task.spawn(function()
			while task.wait(0.1) do
				if u1081.targetPlayer then
					u1058()
				end
			end
		end)
		v1071()
	end)(_ViewStats)
	local _Misc = _EnchantedHubMuscleLegends:AddTab('Varios')
	local _MiscBrawl = _Misc:AddFolder('Varios de Brawl')
	local u1089 = false
	_MiscBrawl:AddSwitch('Modo dios (Brawl)', function(p1090)
		u1089 = p1090
		if p1090 then
			task.spawn(function()
				while u1089 do
					game:GetService('ReplicatedStorage').rEvents.brawlEvent:FireServer('joinBrawl')
					task.wait(0)
				end
			end)
		end
	end)
	_MiscBrawl:AddSwitch('Modo dios (gimnasio Tiny Island)', function(p1091)
		if p1091 then
			running.TinyIsland = true
			originalCFrame = nil
			threads.TinyIsland = task.spawn(function()
				local function v1093()
					local _rEvents = _ReplicatedStorage5:FindFirstChild('rEvents')
					if _rEvents then
						_rEvents = _ReplicatedStorage5.rEvents:FindFirstChild('areaTravelRemote')
					end
					return _rEvents
				end
				local function u1095()
					local _areaCircles = Workspace:FindFirstChild('areaCircles')
					if _areaCircles then
						_areaCircles = Workspace.areaCircles:FindFirstChild('areaCircle')
					end
					return _areaCircles
				end
				local function v1098()
					local _Character31 = LocalPlayer.Character
					local v1097 = _Character31 and (_Character31:FindFirstChild('HumanoidRootPart') and u1095())
					if v1097 then
						_Character31.HumanoidRootPart.CFrame = v1097.CFrame
					end
				end
				(function()
					local _legendsBeachBarrierPart = Workspace:FindFirstChild('legendsBeachBarrierPart')
					if _legendsBeachBarrierPart then
						_legendsBeachBarrierPart:Destroy()
					end
				end)();
				(function()
					local _legendsBeachGradientPart = Workspace:FindFirstChild('legendsBeachGradientPart')
					if _legendsBeachGradientPart then
						local _Character32 = LocalPlayer.Character
						if _Character32 then
							_Character32 = LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
						end
						if _Character32 then
							if not originalCFrame then
								originalCFrame = _Character32.CFrame
							end
							_Character32.CFrame = _legendsBeachGradientPart.CFrame + Vector3.new(0, Config.TinyIslandYOffset, 0)
						end
						_legendsBeachGradientPart:Destroy()
					end
				end)()
				local v1102 = true
				while running.TinyIsland do
					local v1103 = v1093()
					if v1103 and not v1102 then
						v1103:FireServer('legendsBeach')
						task.wait()
						v1098()
					end
					task.wait(Config.TinyIslandCheckInterval)
				end
			end)
		else
			running.TinyIsland = false
			if threads.TinyIsland then
				task.cancel(threads.TinyIsland)
				threads.TinyIsland = nil
			end
			local _Character33 = LocalPlayer.Character
			if originalCFrame and (_Character33 and _Character33:FindFirstChild('HumanoidRootPart')) then
				_Character33.HumanoidRootPart.CFrame = originalCFrame
				originalCFrame = nil
			end
		end
	end)
	local u1105 = false
	_MiscBrawl:AddSwitch('Unirse a Brawl automaticamente', function(p1106)
		u1105 = p1106
		if p1106 then
			task.spawn(function()
				while u1105 do
					game:GetService('ReplicatedStorage').rEvents.brawlEvent:FireServer('joinBrawl')
					task.wait(2)
				end
			end)
		end
	end)
	local _MiscV1 = _Misc:AddFolder('Varios V1')
	_MiscV1:AddButton('Eliminar portal de anuncio', function()
		local _RobloxForwardPortals = workspace:FindFirstChild('RobloxForwardPortals')
		if _RobloxForwardPortals then
			_RobloxForwardPortals:Destroy()
		end
	end)
	_MiscV1:AddButton('Shift Lock permanente', function()
		loadstring(game:HttpGet('https://pastebin.com/raw/CjNsnSDy'))()
	end)
	_MiscV1:AddButton('Anti AFK', function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/evxncodes/mainroblox/main/anti-afk', true))()
	end)
	_MiscV1:AddSwitch('Desactivar intercambios', function(p1109)
		if p1109 then
			game:GetService('ReplicatedStorage').rEvents.tradingEvent:FireServer('disableTrading')
		else
			game:GetService('ReplicatedStorage').rEvents.tradingEvent:FireServer('enableTrading')
		end
	end)
	_MiscV1:AddSwitch('Ocultar mascotas', function(p1110)
		if p1110 then
			game:GetService('ReplicatedStorage').rEvents.showPetsEvent:FireServer('hidePets')
		else
			game:GetService('ReplicatedStorage').rEvents.showPetsEvent:FireServer('showPets')
		end
	end)
	local u1111 = false
	_MiscV1:AddSwitch('Levantar automaticamente', function(p1112)
		u1111 = p1112
		if p1112 then
			task.spawn(function()
				while u1111 do
					game:GetService('Players').LocalPlayer:WaitForChild('muscleEvent'):FireServer('rep')
					task.wait(0.1)
				end
			end)
		end
	end)
	_MiscV1:AddButton('Cambiar estadisticas V1', function()
		local _ScreenGui3 = Instance.new('ScreenGui')
		local _Frame3 = Instance.new('Frame')
		local _TextButton4 = Instance.new('TextButton')
		local _UICorner2 = Instance.new('UICorner')
		local _UIGradient2 = Instance.new('UIGradient')
		_ScreenGui3.Parent = game:GetService('CoreGui')
		_ScreenGui3.Name = 'DeltaSquareUI'
		_Frame3.Parent = _ScreenGui3
		_Frame3.BackgroundColor3 = Color3.new(0, 0, 0)
		_Frame3.BackgroundTransparency = 0.5
		_Frame3.Size = UDim2.new(0, 300, 0, 300)
		_Frame3.Position = UDim2.new(0.5, - 150, 0.5, - 150)
		_Frame3.Active = true
		_Frame3.Visible = true
		_UIGradient2.Parent = _Frame3
		_UIGradient2.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50)),
		})
		local _TextLabel5 = Instance.new('TextLabel')
		_TextLabel5.Parent = _Frame3
		_TextLabel5.Size = UDim2.new(0, 300, 0, 30)
		_TextLabel5.Position = UDim2.new(0, 0, 0, 0)
		_TextLabel5.BackgroundTransparency = 1
		_TextLabel5.Text = 'CAMBIAR ESTADISTICAS'
		_TextLabel5.TextColor3 = Color3.new(1, 1, 1)
		_TextLabel5.TextScaled = true
		_TextLabel5.TextStrokeTransparency = 0.5
		_TextLabel5.Font = Enum.Font.SourceSansBold
		local v1119, v1120, v1121 = ipairs({
			{
				Name = 'Strength',
				Placeholder = 'Cambiar fuerza',
			},
			{
				Name = 'Rebirths',
				Placeholder = 'Cambiar renacimientos',
			},
			{
				Name = 'Kills',
				Placeholder = 'Cambiar bajas',
			},
			{
				Name = 'Brawls',
				Placeholder = 'Cambiar brawls',
			},
		})
		local function u1128(p1122)
			local v1123 = string.upper(p1122)
			local v1124 = {
				T = 1000000000000,
				B = 1000000000,
				M = 1000000,
				K = 1000,
				Qa = 1000000000000000,
			}
			local v1125, v1126 = string.match(v1123, '^(%d+%.?%d*)([TBMKQa]?)$')
			local v1127 = tonumber(v1125)
			if v1127 and (v1126 and v1124[v1126]) then
				return v1127 * v1124[v1126]
			else
				return v1127
			end
		end
		local function u1130(p1129)
			if p1129 >= 1000000000000000 then
				return string.format('%.1fQa', p1129 / 1000000000000000)
			elseif p1129 >= 1000000000000 then
				return string.format('%.1fT', p1129 / 1000000000000)
			elseif p1129 >= 1000000000 then
				return string.format('%.1fB', p1129 / 1000000000)
			elseif p1129 >= 1000000 then
				return string.format('%.1fM', p1129 / 1000000)
			elseif p1129 >= 1000 then
				return string.format('%.1fK', p1129 / 1000)
			else
				return tostring(p1129)
			end
		end
		local v1131 = {}
		while true do
			local u1132
			v1121, u1132 = v1119(v1120, v1121)
			if v1121 == nil then
				break
			end
			local _TextBox2 = Instance.new('TextBox')
			_TextBox2.Parent = _Frame3
			_TextBox2.Size = UDim2.new(0, 250, 0, 30)
			_TextBox2.Position = UDim2.new(0.1, 0, 0.1 + 0.2 * (v1121 - 1), 0)
			_TextBox2.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
			_TextBox2.TextColor3 = Color3.new(1, 1, 1)
			_TextBox2.TextScaled = true
			_TextBox2.Font = Enum.Font.SourceSans
			_TextBox2.Text = ''
			_TextBox2.PlaceholderText = u1132.Placeholder
			_TextBox2.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
			_TextBox2.ClearTextOnFocus = false
			local _UIStroke2 = Instance.new('UIStroke')
			_UIStroke2.Parent = _TextBox2
			_UIStroke2.Color = Color3.new(1, 1, 1)
			_UIStroke2.Thickness = 2
			_TextBox2.FocusLost:Connect(function(p1135)
				if p1135 then
					local v1136 = u1128(_TextBox2.Text)
					if v1136 then
						local _leaderstats11 = game.Players.LocalPlayer:FindFirstChild('leaderstats')
						if _leaderstats11 then
							local v1138 = _leaderstats11:FindFirstChild(u1132.Name)
							if v1138 and v1138:IsA('IntValue') then
								v1138.Value = math.floor(v1136)
								_TextBox2.Text = u1130(v1136)
							end
						end
					else
						local _leaderstats12 = game.Players.LocalPlayer:FindFirstChild('leaderstats')
						if _leaderstats12 then
							local v1140 = _leaderstats12:FindFirstChild(u1132.Name)
							if v1140 and v1140:IsA('IntValue') then
								_TextBox2.Text = tostring(v1140.Value)
							end
						end
					end
				end
			end)
			table.insert(v1131, _TextBox2)
		end
		_UICorner2.CornerRadius = UDim.new(0, 15)
		_UICorner2.Parent = _Frame3
		_TextButton4.Parent = _ScreenGui3
		_TextButton4.Size = UDim2.new(0, 100, 0, 50)
		_TextButton4.Position = UDim2.new(1, - 120, 0, 20)
		_TextButton4.BackgroundColor3 = Color3.new(0, 0, 0)
		_TextButton4.BackgroundTransparency = 0.5
		_TextButton4.Text = 'Ocultar UI'
		_TextButton4.TextColor3 = Color3.new(1, 1, 1)
		_TextButton4.TextScaled = true
		local _UICorner3 = Instance.new('UICorner')
		_UICorner3.CornerRadius = UDim.new(0, 15)
		_UICorner3.Parent = _TextButton4
		_TextButton4.MouseButton1Click:Connect(function()
			_Frame3.Visible = not _Frame3.Visible
			_TextButton4.Text = _Frame3.Visible and 'Ocultar UI' or 'Mostrar UI'
		end)
	end)
	local _MiscV2 = _Misc:AddFolder('Varios V2')
	local _openFortuneWheelRemote = nil
	local _FortuneWheel = nil
	pcall(function()
		local _ReplicatedStorage6 = game:GetService('ReplicatedStorage')
		_openFortuneWheelRemote = _ReplicatedStorage6:FindFirstChild('rEvents') and _ReplicatedStorage6.rEvents:FindFirstChild('openFortuneWheelRemote')
		local chances = _ReplicatedStorage6:FindFirstChild('fortuneWheelChances') or _ReplicatedStorage6:FindFirstChild('fortuneWheel')
		if chances then
			_FortuneWheel = chances:FindFirstChild('Fortune Wheel') or chances:FindFirstChild('Chances')
		end
	end)
	local u1146 = false
	local u1147 = nil
	_MiscV2:AddSwitch('Girar ruleta automaticamente', function(p1148)
		u1146 = p1148
		if p1148 then
			u1147 = task.spawn(function()
				while u1146 do
					pcall(function()
						_openFortuneWheelRemote:InvokeServer('openFortuneWheel', _FortuneWheel)
					end)
					task.wait(5)
				end
			end)
		else
			u1146 = false
		end
	end)
	_MiscV2:AddSwitch('Consumir inventario automaticamente', function(p1149)
		_G.AutoEgg = p1149
		if p1149 then
			task.spawn(function()
				while _G.AutoEgg do
					local _LocalPlayer58 = game.Players.LocalPlayer
					local v1151, v1152, v1153 = ipairs({
						'Protein Shake',
						'Energy Bar',
						'Ultra Shake',
						'Protein Bar',
						'Energy Shake',
					})
					while true do
						local v1154
						v1153, v1154 = v1151(v1152, v1153)
						if v1153 == nil then
							break
						end
						local v1155 = _LocalPlayer58.Backpack:FindFirstChild(v1154)
						if v1155 then
							v1155.Parent = _LocalPlayer58.Character
							local _VirtualInputManager4 = game:GetService('VirtualInputManager')
							for _ = 1, 5 do
								_VirtualInputManager4:SendMouseButtonEvent(0, 0, 0, true, game, 1)
								task.wait()
								_VirtualInputManager4:SendMouseButtonEvent(0, 0, 0, false, game, 1)
								task.wait(0.1)
							end
						end
					end
					task.wait(0.1)
				end
			end)
		end
	end)
	local _freeGiftClaimRemote = game:GetService('ReplicatedStorage').rEvents.freeGiftClaimRemote
	local u1158 = false
	local u1159 = nil
	_MiscV2:AddSwitch('Reclamar regalos automaticamente', function(p1160)
		u1158 = p1160
		if p1160 then
			u1159 = task.spawn(function()
				while u1158 do
					for v1161 = 0, 10 do
						local u1162 = v1161
						pcall(function()
							_freeGiftClaimRemote:InvokeServer('claimGift', u1162)
						end)
						task.wait(0.1)
					end
					task.wait(1)
				end
			end)
		else
			u1158 = false
		end
	end)
	_MiscV2:AddButton('Anti empuje y anti fling', function()
		local _LocalPlayer59 = game:GetService('Players').LocalPlayer
		local function u1169()
			local _Character34 = _LocalPlayer59.Character
			if _Character34 then
				local v1165, v1166, v1167 = ipairs(_Character34:GetDescendants())
				while true do
					local v1168
					v1167, v1168 = v1165(v1166, v1167)
					if v1167 == nil then
						break
					end
					if v1168:IsA('BasePart') then
						v1168.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
						v1168.Velocity = Vector3.zero
						v1168.RotVelocity = Vector3.zero
						v1168.AssemblyLinearVelocity = Vector3.zero
						v1168.AssemblyAngularVelocity = Vector3.zero
					end
				end
			end
		end
		_LocalPlayer59.CharacterAdded:Connect(function(p1170)
			p1170:WaitForChild('HumanoidRootPart')
			wait(1)
			u1169()
		end)
		u1169()
		game:GetService('RunService').Heartbeat:Connect(function()
			local _Character35 = _LocalPlayer59.Character
			if _Character35 then
				local v1172, v1173, v1174 = ipairs(_Character35:GetDescendants())
				while true do
					local v1175
					v1174, v1175 = v1172(v1173, v1174)
					if v1174 == nil then
						break
					end
					if v1175:IsA('BasePart') then
						v1175.Velocity = Vector3.zero
						v1175.RotVelocity = Vector3.zero
						v1175.AssemblyLinearVelocity = Vector3.zero
						v1175.AssemblyAngularVelocity = Vector3.zero
					end
				end
			end
		end)
	end)
	local u1176 = {}
	local u1177 = 2048
	local u1178 = Vector3.new(- 2, - 9.5, - 2)
	local u1179 = math.ceil(50000 / u1177)
	local function u1187()
		for v1180 = 0, u1179 - 1 do
			local v1181 = v1180
			for v1182 = 0, u1179 - 1 do
				local _Part = Instance.new('Part')
				_Part.Size = Vector3.new(u1177, 1, u1177)
				_Part.Position = u1178 + Vector3.new(v1181 * u1177, 0, v1182 * u1177)
				_Part.Anchored = true
				_Part.Transparency = 1
				_Part.CanCollide = true
				_Part.Name = 'Part_Side_' .. v1181 .. '_' .. v1182
				_Part.Parent = workspace
				table.insert(u1176, _Part)
				local _Part2 = Instance.new('Part')
				_Part2.Size = Vector3.new(u1177, 1, u1177)
				_Part2.Position = u1178 + Vector3.new(- v1181 * u1177, 0, v1182 * u1177)
				_Part2.Anchored = true
				_Part2.Transparency = 1
				_Part2.CanCollide = true
				_Part2.Name = 'Part_LeftRight_' .. v1181 .. '_' .. v1182
				_Part2.Parent = workspace
				table.insert(u1176, _Part2)
				local _Part3 = Instance.new('Part')
				_Part3.Size = Vector3.new(u1177, 1, u1177)
				_Part3.Position = u1178 + Vector3.new(- v1181 * u1177, 0, - v1182 * u1177)
				_Part3.Anchored = true
				_Part3.Transparency = 1
				_Part3.CanCollide = true
				_Part3.Name = 'Part_UpLeft_' .. v1181 .. '_' .. v1182
				_Part3.Parent = workspace
				table.insert(u1176, _Part3)
				local _Part4 = Instance.new('Part')
				_Part4.Size = Vector3.new(u1177, 1, u1177)
				_Part4.Position = u1178 + Vector3.new(v1181 * u1177, 0, - v1182 * u1177)
				_Part4.Anchored = true
				_Part4.Transparency = 1
				_Part4.CanCollide = true
				_Part4.Name = 'Part_UpRight_' .. v1181 .. '_' .. v1182
				_Part4.Parent = workspace
				table.insert(u1176, _Part4)
			end
		end
	end
	local function u1192()
		local v1188, v1189, v1190 = ipairs(u1176)
		while true do
			local v1191
			v1190, v1191 = v1188(v1189, v1190)
			if v1190 == nil then
				break
			end
			if v1191 and v1191.Parent then
				v1191.CanCollide = false
			end
		end
	end
	_MiscV2:AddSwitch('Caminar sobre agua completo', function(p1193)
		if p1193 then
			u1187()
		else
			u1192()
		end
	end)
	_MiscBrawl:AddLabel('---Optimizaciones---')
	_MiscV2:AddButton('Eliminar texturas', function()
		local v1194, v1195, v1196 = pairs(game:GetDescendants())
		while true do
			local v1197
			v1196, v1197 = v1194(v1195, v1196)
			if v1196 == nil then
				break
			end
			if v1197:IsA('Decal') or v1197:IsA('Texture') then
				v1197.Transparency = 1
			end
		end
		game:GetService('StarterGui'):SetCore('SendNotification', {
			Title = 'Rendimiento',
			Text = 'Texturas eliminadas.',
			Duration = 5,
		})
	end)
	_MiscV2:AddButton('Reducir graficos', function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
		game:GetService('StarterGui'):SetCore('SendNotification', {
			Title = 'Rendimiento',
			Text = 'Graficos reducidos.',
			Duration = 5,
		})
	end)
	_MiscV2:AddButton('Desactivar sombras', function()
		game:GetService('Lighting').GlobalShadows = false
		game:GetService('StarterGui'):SetCore('SendNotification', {
			Title = 'Rendimiento',
			Text = 'Sombras desactivadas.',
			Duration = 5,
		})
	end)
	_MiscV2:AddButton('Desactivar efectos', function()
		local v1198, v1199, v1200 = pairs(game:GetDescendants())
		while true do
			local v1201
			v1200, v1201 = v1198(v1199, v1200)
			if v1200 == nil then
				break
			end
			if v1201:IsA('ParticleEmitter') or (v1201:IsA('Smoke') or (v1201:IsA('Fire') or v1201:IsA('Sparkles'))) then
				v1201.Enabled = false
			end
		end
		local _Lighting2 = game:GetService('Lighting')
		local v1203, v1204, v1205 = pairs(_Lighting2:GetChildren())
		while true do
			local v1206
			v1205, v1206 = v1203(v1204, v1205)
			if v1205 == nil then
				break
			end
			if v1206:IsA('BlurEffect') or (v1206:IsA('SunRaysEffect') or (v1206:IsA('ColorCorrectionEffect') or (v1206:IsA('BloomEffect') or v1206:IsA('DepthOfFieldEffect')))) then
				v1206.Enabled = false
			end
		end
		game:GetService('StarterGui'):SetCore('SendNotification', {
			Title = 'Rendimiento',
			Text = 'Efectos desactivados.',
			Duration = 5,
		})
	end)
	_MiscV2:AddButton('Simplificar materiales', function()
		local v1207, v1208, v1209 = pairs(game:GetDescendants())
		while true do
			local v1210
			v1209, v1210 = v1207(v1208, v1209)
			if v1209 == nil then
				break
			end
			if v1210:IsA('BasePart') and not v1210:IsA('MeshPart') then
				v1210.Material = Enum.Material.SmoothPlastic
				if not (v1210.Parent and (v1210.Parent:FindFirstChild('Humanoid') or v1210.Parent.Parent:FindFirstChild('Humanoid'))) then
					v1210.Reflectance = 0
				end
			end
		end
		game:GetService('StarterGui'):SetCore('SendNotification', {
			Title = 'Rendimiento',
			Text = 'Materiales simplificados.',
			Duration = 5,
		})
	end)
	_MiscV2:AddButton('Eliminar niebla', function()
		game:GetService('Lighting').FogEnd = 10000000000
		game:GetService('StarterGui'):SetCore('SendNotification', {
			Title = 'Rendimiento',
			Text = 'Niebla eliminada.',
			Duration = 5,
		})
	end)
	_MiscV2:AddButton('Anti lag (avanzado)', function()
		local v1211, v1212, v1213 = pairs(game:GetDescendants())
		while true do
			local v1214
			v1213, v1214 = v1211(v1212, v1213)
			if v1213 == nil then
				break
			end
			if v1214:IsA('Decal') or v1214:IsA('Texture') then
				v1214:Destroy()
			end
		end
		local _Terrain = workspace:FindFirstChildOfClass('Terrain')
		if _Terrain then
			_Terrain.WaterWaveSize = 0
			_Terrain.WaterWaveSpeed = 0
			_Terrain.WaterReflectance = 0
			_Terrain.WaterTransparency = 1
			_Terrain.Decorations = false
		end
		local v1216, v1217, v1218 = pairs(workspace:GetDescendants())
		while true do
			local v1219
			v1218, v1219 = v1216(v1217, v1218)
			if v1218 == nil then
				break
			end
			if v1219:IsA('Explosion') or v1219:IsA('Debris') then
				v1219:Destroy()
			elseif v1219:IsA('BasePart') and v1219.Name:lower():find('debris') then
				v1219:Destroy()
			end
		end
		local v1220, v1221, v1222 = pairs(game:GetDescendants())
		while true do
			local v1223
			v1222, v1223 = v1220(v1221, v1222)
			if v1222 == nil then
				break
			end
			if v1223:IsA('PointLight') or (v1223:IsA('SurfaceLight') or v1223:IsA('SpotLight')) then
				v1223.Enabled = false
			end
		end
		local v1224, v1225, v1226 = pairs(workspace:GetDescendants())
		while true do
			local v1227
			v1226, v1227 = v1224(v1225, v1226)
			if v1226 == nil then
				break
			end
			if v1227:IsA('Sound') then
				v1227:Stop()
			end
		end
		print('Anti lag activado: texturas, luces, sonidos y efectos eliminados.')
	end)
	_MiscV2:AddButton('Mejora extrema de FPS', function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
		settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
		settings().Rendering.EagerBulkExecution = true
		settings().Rendering.ReloadAssets = false
		local _Lighting3 = game:GetService('Lighting')
		_Lighting3.GlobalShadows = false
		_Lighting3.FogEnd = 10000000000
		_Lighting3.Brightness = 0
		_Lighting3.EnvironmentDiffuseScale = 0
		_Lighting3.EnvironmentSpecularScale = 0
		local v1229, v1230, v1231 = ipairs(game:GetDescendants())
		while true do
			local v1232
			v1231, v1232 = v1229(v1230, v1231)
			if v1231 == nil then
				break
			end
			if v1232:IsA('ParticleEmitter') or (v1232:IsA('Trail') or (v1232:IsA('Smoke') or (v1232:IsA('Fire') or v1232:IsA('Sparkles')))) then
				v1232:Destroy()
			elseif v1232:IsA('PointLight') or (v1232:IsA('SpotLight') or v1232:IsA('SurfaceLight')) then
				v1232.Enabled = false
			end
		end
		local v1233, v1234, v1235 = pairs(game:GetDescendants())
		while true do
			local v1236
			v1235, v1236 = v1233(v1234, v1235)
			if v1235 == nil then
				break
			end
			if v1236:IsA('Sound') then
				v1236:Stop()
				v1236.Volume = 0
			end
		end
		local v1237, v1238, v1239 = ipairs(game:GetDescendants())
		while true do
			local v1240
			v1239, v1240 = v1237(v1238, v1239)
			if v1239 == nil then
				break
			end
			if v1240:IsA('Decal') or v1240:IsA('Texture') then
				v1240:Destroy()
			end
		end
		local _Terrain2 = workspace:FindFirstChildOfClass('Terrain')
		if _Terrain2 then
			_Terrain2.WaterWaveSize = 0
			_Terrain2.WaterWaveSpeed = 0
			_Terrain2.WaterReflectance = 0
			_Terrain2.WaterTransparency = 1
			_Terrain2.Decorations = false
		end
		local _LocalPlayer60 = game.Players.LocalPlayer
		local _PlayerGui3 = _LocalPlayer60:FindFirstChild('PlayerGui')
		if _PlayerGui3 then
			local v1244, v1245, v1246 = ipairs(_PlayerGui3:GetDescendants())
			while true do
				local v1247
				v1246, v1247 = v1244(v1245, v1246)
				if v1246 == nil then
					break
				end
				if v1247:IsA('TextLabel') or (v1247:IsA('ImageLabel') or v1247:IsA('ImageButton')) then
					v1247.Visible = false
				end
			end
		end
		local v1248, v1249, v1250 = ipairs(_LocalPlayer60.Character:GetChildren())
		while true do
			local v1251
			v1250, v1251 = v1248(v1249, v1250)
			if v1250 == nil then
				break
			end
			if v1251:IsA('Accessory') or v1251:IsA('Clothing') then
				v1251:Destroy()
			end
		end
		local _Humanoid8 = _LocalPlayer60.Character:FindFirstChildWhichIsA('Humanoid')
		if _Humanoid8 then
			local v1253, v1254, v1255 = pairs(_Humanoid8:GetPlayingAnimationTracks())
			while true do
				local v1256
				v1255, v1256 = v1253(v1254, v1255)
				if v1255 == nil then
					break
				end
				v1256:Stop()
			end
		end
		print('Mejora extrema de FPS aplicada.')
	end)
	_MiscV2:AddButton('Optimizacion completa', function()
		local v1257, v1258, v1259 = pairs(game:GetDescendants())
		while true do
			local v1260
			v1259, v1260 = v1257(v1258, v1259)
			if v1259 == nil then
				break
			end
			if v1260:IsA('ParticleEmitter') or (v1260:IsA('Smoke') or (v1260:IsA('Fire') or v1260:IsA('Sparkles'))) then
				v1260.Enabled = false
			end
		end
		local _Lighting4 = game:GetService('Lighting')
		_Lighting4.GlobalShadows = false
		_Lighting4.FogEnd = 9000000000
		_Lighting4.Brightness = 0
		settings().Rendering.QualityLevel = 1
		local v1262, v1263, v1264 = pairs(game:GetDescendants())
		while true do
			local v1265
			v1264, v1265 = v1262(v1263, v1264)
			if v1264 == nil then
				break
			end
			if v1265:IsA('Decal') or v1265:IsA('Texture') then
				v1265.Transparency = 1
			elseif v1265:IsA('BasePart') and not v1265:IsA('MeshPart') then
				v1265.Material = Enum.Material.SmoothPlastic
				if not (v1265.Parent and (v1265.Parent:FindFirstChild('Humanoid') or v1265.Parent.Parent:FindFirstChild('Humanoid'))) then
					v1265.Reflectance = 0
				end
			end
		end
		local v1266, v1267, v1268 = pairs(_Lighting4:GetChildren())
		while true do
			local v1269
			v1268, v1269 = v1266(v1267, v1268)
			if v1268 == nil then
				break
			end
			if v1269:IsA('BlurEffect') or (v1269:IsA('SunRaysEffect') or (v1269:IsA('ColorCorrectionEffect') or (v1269:IsA('BloomEffect') or v1269:IsA('DepthOfFieldEffect')))) then
				v1269.Enabled = false
			end
		end
		game:GetService('StarterGui'):SetCore('SendNotification', {
			Title = 'Optimizacion',
			Text = 'Optimizacion completa aplicada.',
			Duration = 5,
		})
	end)
	_MiscV2:AddSwitch('Optimizacion completa V2', function(p1270)
		if p1270 then
			local _PlayerGui4 = game.Players.LocalPlayer:WaitForChild('PlayerGui')
			local v1272, v1273, v1274 = pairs(_PlayerGui4:GetChildren())
			while true do
				local v1275
				v1274, v1275 = v1272(v1273, v1274)
				if v1274 == nil then
					break
				end
				if v1275:IsA('ScreenGui') and v1275.Enabled then
					v1275.Enabled = false
				end
			end
			settings().Rendering.QualityLevel = 1
			settings().Physics.PhysicsEnvironmentalThrottle = 1
			settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
			settings().Physics.AllowSleep = true
			settings().Physics.ForceCSGv2 = false
			settings().Rendering.EagerBulkExecution = true
			local _Lighting5 = game:GetService('Lighting')
			_Lighting5.GlobalShadows = false
			_Lighting5.FogEnd = 9000000000
			_Lighting5.Brightness = 0
			settings().Physics.NetworkOwnershipRule = Enum.NetworkOwnershipRule.Manual
			settings().Network.IncomingReplicationLag = 0
			game:GetService('NetworkClient'):SetOutgoingKBPSLimit(100)
			local v1277, v1278, v1279 = pairs(game:GetDescendants())
			while true do
				local v1280
				v1279, v1280 = v1277(v1278, v1279)
				if v1279 == nil then
					break
				end
				if v1280:IsA('ParticleEmitter') or v1280:IsA('Trail') then
					v1280.Lifetime = NumberRange.new(0)
				elseif v1280:IsA('Fire') or (v1280:IsA('SpotLight') or (v1280:IsA('Smoke') or v1280:IsA('Sparkles'))) then
					v1280.Enabled = false
				end
			end
		end
	end)
	end, function(message)
		if debug and debug.traceback then
			return debug.traceback(tostring(message), 2)
		end
		return tostring(message)
	end)
	if executed then
		emblemPulse = false
		ScreenGui:Destroy()
	else
		if ActiveRayfield and ActiveRayfield.Destroy then
			pcall(function()
				ActiveRayfield:Destroy()
			end)
		end
		warn("[TheRealBanHammer] Execute failed: " .. tostring(executeError))
		emblemPulse = false
		ScreenGui:Destroy()
	end
end
local VersionLabel = Instance.new("TextLabel")
VersionLabel.Text = "v0.1 | TheRealBanHammer"
VersionLabel.Size = UDim2.new(1, 0, 0, 18)
VersionLabel.Position = UDim2.new(0, 0, 1, - 22)
VersionLabel.BackgroundTransparency = 1
VersionLabel.Font = Enum.Font.Gotham
VersionLabel.TextSize = 10
VersionLabel.TextColor3 = Color3.fromRGB(80, 0, 0)
VersionLabel.TextXAlignment = Enum.TextXAlignment.Center
VersionLabel.ZIndex = 3
VersionLabel.Parent = Body
local dragging = false
local dragStart = nil
local startPos = nil
TitleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)
CloseBtn.MouseButton1Click:Connect(function()
	emblemPulse = false
	TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 420, 0, 0),
		Position = UDim2.new(MainFrame.Position.X.Scale, MainFrame.Position.X.Offset, MainFrame.Position.Y.Scale, MainFrame.Position.Y.Offset + 160),
	}):Play()
	task.wait(0.3)
	ScreenGui:Destroy()
end)
ScreenGui.Enabled = false
task.defer(runScript)
