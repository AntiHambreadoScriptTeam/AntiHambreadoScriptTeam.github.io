local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

getgenv().godMode = false
getgenv().mapFarm = false
getgenv().speedHack = false
getgenv().speedValue = 16
getgenv().infJump = false
getgenv().noclip = false

local floatPlatform

local mapBounds = {
	minX = -500,
	maxX = 500,
	minZ = -500,
	maxZ = 500,
	height = 30
}

local function createFloatPlatform()
	if floatPlatform and floatPlatform.Parent then return end
	floatPlatform = Instance.new("Part")
	floatPlatform.Name = "FloatPlatform"
	floatPlatform.Anchored = true
	floatPlatform.CanCollide = true
	floatPlatform.Transparency = 1
	floatPlatform.Size = Vector3.new(6, 1.5, 6)
	floatPlatform.Parent = workspace
end

local function removeFloatPlatform()
	if floatPlatform then
		floatPlatform:Destroy()
		floatPlatform = nil
	end
end

local function updateFloatPlatform(targetPosition)
	if not floatPlatform then return end
	if not targetPosition then
		if not character or not character:FindFirstChild("HumanoidRootPart") then return end
		targetPosition = character.HumanoidRootPart.Position
	end
	floatPlatform.CFrame = CFrame.new(targetPosition - Vector3.new(0, 3.5, 0))
end

player.Idled:Connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

RunService.Heartbeat:Connect(function()
	if floatPlatform and (getgenv().godMode or getgenv().mapFarm) then
		pcall(function()
			if character and character:FindFirstChild("HumanoidRootPart") then
				updateFloatPlatform(character.HumanoidRootPart.Position)
			end
		end)
	end
end)

RunService.Stepped:Connect(function()
	if character and character:FindFirstChild("Humanoid") then
		if getgenv().speedHack then
			character.Humanoid.WalkSpeed = getgenv().speedValue
		end
	end
	
	if getgenv().noclip and character then
		for _, part in pairs(character:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then
				part.CanCollide = false
			end
		end
	end
end)

UserInputService.JumpRequest:Connect(function()
	if getgenv().infJump and character and character:FindFirstChild("Humanoid") then
		character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

task.spawn(function()
	while true do
		if getgenv().godMode then
			character = player.Character or player.CharacterAdded:Wait()
			local hrp = character:FindFirstChild("HumanoidRootPart")
			
			if hrp then
				if character:GetAttribute("Downed") then
					pcall(function()
						ReplicatedStorage.Events.Player.ChangePlayerMode:FireServer(true)
					end)
				end
			end
			task.wait(0.1)
		else
			task.wait(0.5)
		end
	end
end)

task.spawn(function()
	while true do
		if getgenv().mapFarm then
			character = player.Character or player.CharacterAdded:Wait()
			local hrp = character:FindFirstChild("HumanoidRootPart")
			
			if hrp then
				if character:GetAttribute("Downed") then
					pcall(function()
						ReplicatedStorage.Events.Player.ChangePlayerMode:FireServer(true)
					end)
				end
				
				local randomX = math.random(mapBounds.minX, mapBounds.maxX)
				local randomZ = math.random(mapBounds.minZ, mapBounds.maxZ)
				local targetPos = Vector3.new(randomX, mapBounds.height, randomZ)
				
				hrp.CFrame = CFrame.new(targetPos)
				updateFloatPlatform(targetPos)
				
				task.wait(math.random(20, 40) / 10)
			end
		else
			task.wait(0.5)
		end
	end
end)

local function createGradientText(textLabel)
	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 105, 180))
	}
	gradient.Rotation = 45
	gradient.Parent = textLabel
end

local function playIntro()
	local introGui = Instance.new("ScreenGui")
	introGui.Name = "IntroGui"
	introGui.Parent = player.PlayerGui
	
	local background = Instance.new("Frame")
	background.Size = UDim2.new(1, 0, 1, 0)
	background.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	background.BackgroundTransparency = 0
	background.Parent = introGui
	
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(0, 400, 0, 100)
	textLabel.Position = UDim2.new(0.5, -200, 0.5, -50)
	textLabel.BackgroundTransparency = 1
	textLabel.Text = "FeliciaXxxTop"
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.Font = Enum.Font.GothamBold
	textLabel.TextSize = 48
	textLabel.TextTransparency = 1
	textLabel.Parent = background
	
	createGradientText(textLabel)
	
	local fadeIn = TweenService:Create(textLabel, TweenInfo.new(1.5), {TextTransparency = 0})
	local fadeOut = TweenService:Create(textLabel, TweenInfo.new(1.5), {TextTransparency = 1})
	local bgFade = TweenService:Create(background, TweenInfo.new(1), {BackgroundTransparency = 1})
	
	fadeIn:Play()
	fadeIn.Completed:Wait()
	task.wait(1)
	fadeOut:Play()
	bgFade:Play()
	fadeOut.Completed:Wait()
	
	introGui:Destroy()
end

local function createGUI()
	if player.PlayerGui:FindFirstChild("FeliciaGUI") then
		player.PlayerGui.FeliciaGUI:Destroy()
	end

	local gui = Instance.new("ScreenGui")
	gui.Name = "FeliciaGUI"
	gui.Parent = player.PlayerGui
	gui.ResetOnSpawn = false

	local mainFrame = Instance.new("Frame")
	mainFrame.Size = UDim2.new(0, 320, 0, 450)
	mainFrame.Position = UDim2.new(0.05, 0, 0.2, 0) -- Moved to left side
	mainFrame.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
	mainFrame.BorderSizePixel = 0
	mainFrame.Active = true 
	mainFrame.Draggable = true 
	mainFrame.Parent = gui

	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 15)
	uiCorner.Parent = mainFrame
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(180, 80, 200)
	stroke.Thickness = 1.5
	stroke.Parent = mainFrame
	
	local titleBar = Instance.new("Frame")
	titleBar.Size = UDim2.new(1, 0, 0, 40)
	titleBar.BackgroundTransparency = 1
	titleBar.Parent = mainFrame
	
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -90, 1, 0)
	titleLabel.Position = UDim2.new(0, 10, 0, 0)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = "Evade v2"
	titleLabel.TextColor3 = Color3.fromRGB(255, 200, 255)
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 18
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = titleBar
	
	local contentFrame = Instance.new("ScrollingFrame")
	contentFrame.Size = UDim2.new(1, -20, 1, -90)
	contentFrame.Position = UDim2.new(0, 10, 0, 50)
	contentFrame.BackgroundTransparency = 1
	contentFrame.BorderSizePixel = 0
	contentFrame.ScrollBarThickness = 2
	contentFrame.Parent = mainFrame
	
	local waterMark = Instance.new("TextLabel") 
	waterMark.Size = UDim2.new(1, 0, 0, 20)
	waterMark.Position = UDim2.new(0, 0, 1, -25)
	waterMark.BackgroundTransparency = 1
	waterMark.Text = "By FeliciaXxxTop"
	waterMark.TextColor3 = Color3.fromRGB(255, 150, 255)
	waterMark.Font = Enum.Font.Gotham
	waterMark.TextSize = 12
	waterMark.TextTransparency = 0.5
	waterMark.Parent = mainFrame

	-- Minimize/Close Buttons
	local closeBtn = Instance.new("TextButton")
	closeBtn.Size = UDim2.new(0, 30, 0, 30)
	closeBtn.Position = UDim2.new(1, -35, 0.5, -15)
	closeBtn.AnchorPoint = Vector2.new(0, 0.5)
	closeBtn.Position = UDim2.new(1, -5, 0.5, 0)
	closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
	closeBtn.BackgroundTransparency = 1
	closeBtn.Text = "X"
	closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeBtn.Font = Enum.Font.GothamBold
	closeBtn.TextSize = 18
	closeBtn.Parent = titleBar
	
	local minBtn = Instance.new("TextButton")
	minBtn.Size = UDim2.new(0, 30, 0, 30)
	minBtn.Position = UDim2.new(1, -40, 0.5, 0)
	minBtn.AnchorPoint = Vector2.new(0, 0.5)
	minBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 255)
	minBtn.BackgroundTransparency = 1
	minBtn.Text = "+"
	minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	minBtn.Font = Enum.Font.GothamBold
	minBtn.TextSize = 22
	minBtn.Parent = titleBar
	
	local isMinimized = false
	local originalSize = mainFrame.Size
	
	minBtn.MouseButton1Click:Connect(function()
		isMinimized = not isMinimized
		if isMinimized then
			minBtn.Text = "+"
			contentFrame.Visible = false
			waterMark.Visible = false
			mainFrame:TweenSize(UDim2.new(0, 320, 0, 40), "Out", "Quad", 0.3, true)
		else
			minBtn.Text = "-"
			mainFrame:TweenSize(originalSize, "Out", "Quad", 0.3, true, function()
				contentFrame.Visible = true
				waterMark.Visible = true
			end)
		end
	end)
	
	closeBtn.MouseButton1Click:Connect(function()
		gui:Destroy()
	end)
	
	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 10)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.Parent = contentFrame

	local function createToggleButton(text, featureVar, callback)
		local button = Instance.new("TextButton")
		button.Size = UDim2.new(1, 0, 0, 40)
		button.BackgroundColor3 = Color3.fromRGB(40, 30, 50)
		button.Text = ""
		button.Parent = contentFrame
		button.AutoButtonColor = true
		
		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(0, 8)
		btnCorner.Parent = button
		
		local btnLabel = Instance.new("TextLabel")
		btnLabel.Size = UDim2.new(1, -50, 1, 0)
		btnLabel.Position = UDim2.new(0, 15, 0, 0)
		btnLabel.BackgroundTransparency = 1
		btnLabel.Text = text
		btnLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
		btnLabel.Font = Enum.Font.GothamSemibold
		btnLabel.TextSize = 14
		btnLabel.TextXAlignment = Enum.TextXAlignment.Left
		btnLabel.Parent = button
		
		local indicator = Instance.new("Frame")
		indicator.Size = UDim2.new(0, 10, 0, 10)
		indicator.Position = UDim2.new(1, -25, 0.5, -5)
		indicator.BackgroundColor3 = getgenv()[featureVar] and Color3.fromRGB(255, 100, 200) or Color3.fromRGB(80, 70, 90)
		indicator.Parent = button
		
		local indCorner = Instance.new("UICorner")
		indCorner.CornerRadius = UDim.new(1, 0)
		indCorner.Parent = indicator
		
		button.MouseButton1Click:Connect(function()
			getgenv()[featureVar] = not getgenv()[featureVar]
			local enabled = getgenv()[featureVar]
			
			local targetColor = enabled and Color3.fromRGB(255, 100, 200) or Color3.fromRGB(80, 70, 90)
			TweenService:Create(indicator, TweenInfo.new(0.3), {BackgroundColor3 = targetColor}):Play()
			
			if callback then callback(enabled) end
		end)
	end
	
	createToggleButton("God Mode", "godMode", function(enabled)
		if enabled then
			getgenv().mapFarm = false
			createFloatPlatform()
		else
			removeFloatPlatform()
		end
	end)
	
	createToggleButton("Map Farm (Auto)", "mapFarm", function(enabled)
		if enabled then
			getgenv().godMode = false
			createFloatPlatform()
		else
			removeFloatPlatform()
		end
	end)
	
	createToggleButton("Infinite Jump", "infJump")
	createToggleButton("Noclip", "noclip")
	createToggleButton("Speed Hack", "speedHack")
	
	local sliderFrame = Instance.new("Frame")
	sliderFrame.Size = UDim2.new(1, 0, 0, 50)
	sliderFrame.BackgroundColor3 = Color3.fromRGB(40, 30, 50)
	sliderFrame.Parent = contentFrame
	
	local slCorner = Instance.new("UICorner")
	slCorner.CornerRadius = UDim.new(0, 8)
	slCorner.Parent = sliderFrame
	
	local slLabel = Instance.new("TextLabel")
	slLabel.Size = UDim2.new(1, -20, 0, 20)
	slLabel.Position = UDim2.new(0, 10, 0, 5)
	slLabel.BackgroundTransparency = 1
	slLabel.Text = "WalkSpeed: " .. getgenv().speedValue
	slLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
	slLabel.Font = Enum.Font.GothamSemibold
	slLabel.TextSize = 14
	slLabel.TextXAlignment = Enum.TextXAlignment.Left
	slLabel.Parent = sliderFrame
	
	local sliderBg = Instance.new("TextButton")
	sliderBg.Size = UDim2.new(1, -20, 0, 6)
	sliderBg.Position = UDim2.new(0, 10, 0, 30)
	sliderBg.BackgroundColor3 = Color3.fromRGB(60, 50, 80)
	sliderBg.Text = ""
	sliderBg.AutoButtonColor = false
	sliderBg.Parent = sliderFrame
	
	local sBgCorner = Instance.new("UICorner")
	sBgCorner.CornerRadius = UDim.new(1, 0)
	sBgCorner.Parent = sliderBg
	
	local sliderFill = Instance.new("Frame")
	sliderFill.Size = UDim2.new((getgenv().speedValue - 15) / (100 - 15), 0, 1, 0)
	sliderFill.BackgroundColor3 = Color3.fromRGB(255, 100, 200)
	sliderFill.BorderSizePixel = 0
	sliderFill.Parent = sliderBg
	
	local sFillCorner = Instance.new("UICorner")
	sFillCorner.CornerRadius = UDim.new(1, 0)
	sFillCorner.Parent = sliderFill
	
	local draggingSlider = false
	
	sliderBg.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingSlider = true
		end
	end)
	
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingSlider = false
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local mousePos = UserInputService:GetMouseLocation().X
			local relativePos = mousePos - sliderBg.AbsolutePosition.X
			local percentage = math.clamp(relativePos / sliderBg.AbsoluteSize.X, 0, 1)
			local newValue = math.floor(15 + (percentage * 85))
			getgenv().speedValue = newValue
			sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
			slLabel.Text = "WalkSpeed: " .. newValue
		end
	end)
end

playIntro()
createGUI()

player.CharacterAdded:Connect(function(newChar)
	character = newChar
	humanoid = character:WaitForChild("Humanoid")

	humanoid.Died:Connect(function()
		repeat task.wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")

		if getgenv().godMode or getgenv().mapFarm then
			task.wait(0.3)
			createFloatPlatform()
		end
	end)

	task.wait(0.05)
	createGUI()
end)
