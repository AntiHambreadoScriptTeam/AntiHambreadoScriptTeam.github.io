local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")

local State = {
	CoinFarm = false,
	AvoidMurderer = false,
	ResetBagFull = false,
	LobbyBagFull = false,
	FlingBagFull = false,
	HideAfterDone = false,
	Currency = "Coins",
	AutoEndRound = false,
	CoinWebhook = false,
	WebhookURL = "",
	WebhookInterval = 60,
	AutoOpenMystery = false,
	SelectedMystery = "Mystery Box",
	MysteryWebhook = false,
	WebhookRarity = "Common",
	AutoShoot = false,
	AutoKnife = false,
	KillAura = false,
	Aimbot = false,
	SilentAim = false,
	TargetBone = "Head",
	WallCheck = false,
	AntiMurderer = false,
	TouchFling = false,
	AntiFling = false,
	AutoFlingMurd = false,
	FlingSheriffHero = false,
	WalkSpeed = 16,
	JumpPower = 50,
	HipHeight = 0,
	FOV = 70,
	InfJump = false,
	AutoJump = false,
	Bhop = false,
	Fly = false,
	FlySpeed = 50,
	Noclip = false,
	SpinBot = false,
	SpinSpeed = 50,
	TargetPlayer = "",
	LoopGoto = false,
	Spectate = false,
	Godmode = false,
	Desync = false,
	AntiAFK = true,
	EspEnabled = false,
	EspNames = false,
	EspRoles = false,
	EspDist = false,
	EspHealth = false,
	EspTool = false,
	Tracers = false,
	Chams = false,
	DroppedGunChams = false,
	CoinESP = false,
	HighlightPlayers = false,
	ESPFilter = "All",
	Disable3D = false,
	LowGraphics = false,
	BlackScreen = false,
	WhiteScreen = false,
	HopLessPlayers = 3,
	HopAfterSeconds = 300,
	AutoHop = false
}

local origAmbient = Lighting.Ambient
local origOutdoorAmbient = Lighting.OutdoorAmbient
local origBrightness = Lighting.Brightness
local colorGui = nil
local flyPart = nil
local loopGotoConnection = nil
local noclipConnection = nil
local espConnections = {}
local serverStartTime = os.time()
local lastWebhookSent = 0
local RoleCache = {}
local lastRoleCacheTime = 0

local function UpdateRoleCache()
	if os.time() - lastRoleCacheTime < 1.5 then return end
	lastRoleCacheTime = os.time()
	local getter = ReplicatedStorage:FindFirstChild("GetPlayerData", true)
	if getter and getter:IsA("RemoteFunction") then
		local ok, data = pcall(function() return getter:InvokeServer() end)
		if ok and type(data) == "table" then
			RoleCache = data
		end
	end
end

local function GetRole(plr)
	if not plr then return "Innocent" end
	UpdateRoleCache()
	
	local record = RoleCache[plr.Name] or RoleCache[tostring(plr.UserId)]
	local roleStr = nil
	if type(record) == "string" then
		roleStr = record
	elseif type(record) == "table" then
		roleStr = record.Role or record.role or record.Rol or record.rol
	end
	
	if roleStr then
		local lower = string.lower(roleStr)
		if lower:find("murder") or lower:find("asesino") then
			return "Murderer"
		elseif lower:find("sheriff") or lower:find("policia") then
			return "Sheriff"
		elseif lower:find("hero") or lower:find("heroe") then
			return "Hero"
		end
	end
	
	if plr.Character then
		if plr.Character:FindFirstChild("Knife") or (plr:FindFirstChild("Backpack") and plr.Backpack:FindFirstChild("Knife")) then
			return "Murderer"
		elseif plr.Character:FindFirstChild("Gun") or (plr:FindFirstChild("Backpack") and plr.Backpack:FindFirstChild("Gun")) then
			return "Sheriff"
		end
	end
	
	return "Innocent"
end

local function GetMurderer()
	for _, p in ipairs(Players:GetPlayers()) do
		if GetRole(p) == "Murderer" then
			return p
		end
	end
	return nil
end

local function GetSheriff()
	for _, p in ipairs(Players:GetPlayers()) do
		if GetRole(p) == "Sheriff" then
			return p
		end
	end
	return nil
end

local function GetHero()
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Character and p.Character:FindFirstChild("Gun") then
			return p
		end
	end
	return nil
end

local function GetFurthestPlayerFromMurderer()
	local murd = GetMurderer()
	if not murd or not murd.Character or not murd.Character:FindFirstChild("HumanoidRootPart") then
		return nil
	end
	local mPos = murd.Character.HumanoidRootPart.Position
	local furthestPlr = nil
	local maxDist = -1
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p ~= murd and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local d = (p.Character.HumanoidRootPart.Position - mPos).Magnitude
			if d > maxDist then
				maxDist = d
				furthestPlr = p
			end
		end
	end
	return furthestPlr
end

local function GetActiveMap()
	for _, child in ipairs(workspace:GetChildren()) do
		if child:IsA("Model") or child:IsA("Folder") then
			if child.Name ~= "Lobby" and not string.lower(child.Name):find("lobby") then
				if child:FindFirstChild("Spawns", true) or child:FindFirstChild("SpawnLocation", true) then
					return child
				end
			end
		end
	end
	return nil
end

local function IsBagFull()
	local pg = LocalPlayer:FindFirstChild("PlayerGui")
	if pg then
		local mg = pg:FindFirstChild("MainGui")
		if mg then
			local gameGui = mg:FindFirstChild("Game")
			if gameGui then
				local cb = gameGui:FindFirstChild("CoinBag")
				if cb then
					local container = cb:FindFirstChild("Container")
					local amount = container and container:FindFirstChild("Amount") or cb:FindFirstChild("Amount")
					if amount and amount:IsA("TextLabel") then
						local current, max = string.match(amount.Text, "(%d+)/(%d+)")
						if current and max then
							return tonumber(current) >= tonumber(max)
						end
					end
				end
			end
		end
	end
	return false
end

local function GetCoins()
	local coins = {}
	local map = GetActiveMap()
	local searchContainer = map or workspace.Normal or workspace
	
	local ok, descendants = pcall(function() return searchContainer:GetDescendants() end)
	if ok and descendants then
		for _, child in ipairs(descendants) do
			if child:IsA("TouchTransmitter") or child.Name == "TouchInterest" then
				local parent = child.Parent
				if parent and (parent:IsA("BasePart") or parent:IsA("Model")) then
					local inLobby = false
					if not map then
						local current = parent
						while current and current ~= workspace do
							if current.Name == "Lobby" or string.lower(current.Name):find("lobby") then
								inLobby = true
								break
							end
							current = current.Parent
						end
					end
					
					if not inLobby then
						local lowerName = string.lower(parent.Name)
						if lowerName:find("coin") or lowerName:find("candy") or lowerName:find("gold") then
							local part = parent:IsA("Model") and (parent.PrimaryPart or parent:FindFirstChildOfClass("BasePart")) or parent
							if part then
								table.insert(coins, part)
							end
						end
					end
				end
			end
		end
	end
	return coins
end

local function TeleportToLobby()
	local targetPart = nil
	local lobby = workspace:FindFirstChild("Lobby")
	if lobby then
		targetPart = lobby:FindFirstChildOfClass("SpawnLocation")
		if not targetPart then
			for _, desc in ipairs(lobby:GetDescendants()) do
				if desc:IsA("BasePart") then
					targetPart = desc
					break
				end
			end
		end
	end
	
	if not targetPart then
		for _, desc in ipairs(workspace:GetDescendants()) do
			if desc:IsA("SpawnLocation") then
				targetPart = desc
				break
			end
		end
	end
	
	if targetPart then
		local char = LocalPlayer.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			char.HumanoidRootPart.CFrame = targetPart.CFrame + Vector3.new(0, 5, 0)
		end
	else
		local char = LocalPlayer.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			char.HumanoidRootPart.CFrame = CFrame.new(0, 110, 0)
		end
	end
end

local function FlingPlayer(targetPlr)
	local char = LocalPlayer.Character
	local targetChar = targetPlr.Character
	if char and targetChar and char:FindFirstChild("HumanoidRootPart") and targetChar:FindFirstChild("HumanoidRootPart") then
		local hrp = char.HumanoidRootPart
		local targetHrp = targetChar.HumanoidRootPart
		local oldCFrame = hrp.CFrame
		local spinActive = true
		
		local bodyThrust = Instance.new("BodyAngularVelocity")
		bodyThrust.MaxTorque = Vector3.new(1, 1, 1) * 10000000
		bodyThrust.AngularVelocity = Vector3.new(0, 99999, 0)
		bodyThrust.Parent = hrp
		
		task.spawn(function()
			while spinActive and char and hrp and targetHrp and targetHrp.Parent do
				hrp.CFrame = targetHrp.CFrame + targetHrp.Velocity * 0.1
				task.wait()
			end
			if bodyThrust then bodyThrust:Destroy() end
		end)
		
		task.wait(1.5)
		spinActive = false
		hrp.CFrame = oldCFrame
	end
end

local function SendWebhookNotification(title, text)
	if State.WebhookURL ~= "" and State.WebhookURL:sub(1, 4) == "http" then
		local payload = {
			embeds = {
				{
					title = title,
					description = text,
					color = 65280,
					timestamp = DateTime.now():ToIsoDate()
				}
			}
		}
		if request then
			request({
				Url = State.WebhookURL,
				Method = "POST",
				Headers = { ["Content-Type"] = "application/json" },
				Body = HttpService:JSONEncode(payload)
			})
		end
	end
end

local function AutoShootMurdererFunc()
	local char = LocalPlayer.Character
	if not char then return end
	local gun = char:FindFirstChild("Gun") or (LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack:FindFirstChild("Gun"))
	if gun then
		local murd = GetMurderer()
		if murd and murd.Character and murd.Character:FindFirstChild("HumanoidRootPart") then
			if not char:FindFirstChild("Gun") then
				LocalPlayer.Backpack.Gun.Parent = char
			end
			local targetPart = murd.Character:FindFirstChild(State.TargetBone) or murd.Character:FindFirstChild("HumanoidRootPart")
			if targetPart then
				local cam = workspace.CurrentCamera
				cam.CFrame = CFrame.new(cam.CFrame.Position, targetPart.Position)
				task.wait(0.05)
				gun:Activate()
			end
		end
	end
end

local function AutoKnifeThrowFunc()
	local char = LocalPlayer.Character
	if not char then return end
	local knife = char:FindFirstChild("Knife") or (LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack:FindFirstChild("Knife"))
	if knife then
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				local d = (char.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
				if d < 40 and GetRole(plr) ~= "Murderer" then
					if not char:FindFirstChild("Knife") then
						LocalPlayer.Backpack.Knife.Parent = char
					end
					local targetPart = plr.Character:FindFirstChild("HumanoidRootPart")
					if targetPart then
						local cam = workspace.CurrentCamera
						cam.CFrame = CFrame.new(cam.CFrame.Position, targetPart.Position)
						task.wait(0.05)
						knife:Activate()
					end
					break
				end
			end
		end
	end
end

local function KillAuraFunc()
	local char = LocalPlayer.Character
	if not char then return end
	local knife = char:FindFirstChild("Knife") or (LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack:FindFirstChild("Knife"))
	if knife then
		if not char:FindFirstChild("Knife") then
			LocalPlayer.Backpack.Knife.Parent = char
		end
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				local d = (char.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
				if d < 15 and GetRole(plr) ~= "Murderer" then
					if firetouchinterest then
						firetouchinterest(plr.Character.HumanoidRootPart, knife.Handle, 0)
						firetouchinterest(plr.Character.HumanoidRootPart, knife.Handle, 1)
					end
				end
			end
		end
	end
end

local function AutoKillAllFunc()
	local char = LocalPlayer.Character
	if not char then return end
	local knife = char:FindFirstChild("Knife") or (LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack:FindFirstChild("Knife"))
	if knife then
		if not char:FindFirstChild("Knife") then
			LocalPlayer.Backpack.Knife.Parent = char
		end
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and GetRole(plr) ~= "Murderer" then
				local hrp = plr.Character.HumanoidRootPart
				char.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, 1.5)
				task.wait(0.1)
				if firetouchinterest then
					firetouchinterest(hrp, knife.Handle, 0)
					firetouchinterest(hrp, knife.Handle, 1)
				end
			end
		end
	end
end

local function AutoPickupGunFunc()
	local gunDrop = workspace:FindFirstChild("GunDrop", true)
	if gunDrop and gunDrop:IsA("BasePart") then
		local char = LocalPlayer.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			char.HumanoidRootPart.CFrame = gunDrop.CFrame
		end
	end
end

local function TeleportToMapPart()
	local map = GetActiveMap()
	local targetPart = nil
	
	if map then
		local spawns = map:FindFirstChild("Spawns", true) or map:FindFirstChild("SpawnLocation", true)
		if spawns then
			for _, desc in ipairs(spawns:GetDescendants()) do
				if desc:IsA("BasePart") then
					targetPart = desc
					break
				end
			end
		end
		
		if not targetPart then
			for _, desc in ipairs(map:GetDescendants()) do
				if desc:IsA("BasePart") and desc.Name ~= "Void" and desc.Transparency < 1 then
					targetPart = desc
					break
				end
			end
		end
	end
	
	if targetPart then
		local char = LocalPlayer.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			char.HumanoidRootPart.CFrame = targetPart.CFrame + Vector3.new(0, 5, 0)
		end
	end
end

local function TeleportToRole(role)
	for _, p in ipairs(Players:GetPlayers()) do
		if GetRole(p) == role and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local char = LocalPlayer.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				char.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
			end
			break
		end
	end
end

local function CreateHighlight(plr)
	if plr == LocalPlayer then return end
	if not plr.Character then return end
	local role = GetRole(plr)
	local color = Color3.fromRGB(0, 255, 0)
	if role == "Murderer" then color = Color3.fromRGB(255, 0, 0)
	elseif role == "Sheriff" then color = Color3.fromRGB(0, 128, 255) end
	local h = plr.Character:FindFirstChild("AHSTHighlight")
	if not h then
		h = Instance.new("Highlight")
		h.Name = "AHSTHighlight"
		h.Parent = plr.Character
	end
	h.FillColor = color
	h.OutlineColor = Color3.fromRGB(255, 255, 255)
	h.FillTransparency = 0.5
	h.OutlineTransparency = 0.2
	h.Enabled = State.Chams
end

local function CreateBillboardESP(plr)
	if plr == LocalPlayer then return end
	if not plr.Character or not plr.Character:FindFirstChild("Head") then return end
	local head = plr.Character.Head
	local b = head:FindFirstChild("AHSTESP")
	if not b then
		b = Instance.new("BillboardGui")
		b.Name = "AHSTESP"
		b.AlwaysOnTop = true
		b.Size = UDim2.new(0, 200, 0, 50)
		b.StudsOffset = Vector3.new(0, 2.5, 0)
		b.Parent = head
		local l = Instance.new("TextLabel")
		l.Name = "Label"
		l.BackgroundTransparency = 1
		l.Size = UDim2.new(1, 0, 1, 0)
		l.Font = Enum.Font.SourceSansBold
		l.TextSize = 14
		l.TextColor3 = Color3.fromRGB(255, 255, 255)
		l.TextStrokeTransparency = 0
		l.Parent = b
	end
	local l = b.Label
	local role = GetRole(plr)
	local color = Color3.fromRGB(0, 255, 0)
	if role == "Murderer" then color = Color3.fromRGB(255, 0, 0)
	elseif role == "Sheriff" then color = Color3.fromRGB(0, 128, 255) end
	l.TextColor3 = color
	
	local text = ""
	if State.EspNames then text = text .. plr.Name .. "\n" end
	if State.EspRoles then text = text .. "[" .. role .. "]\n" end
	if State.EspDist then
		local char = LocalPlayer.Character
		if char and char:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("HumanoidRootPart") then
			local d = math.round((char.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude)
			text = text .. tostring(d) .. " studs\n"
		end
	end
	if State.EspHealth then
		local h = plr.Character:FindFirstChild("Humanoid") and math.round(plr.Character.Humanoid.Health) or 100
		text = text .. "HP: " .. tostring(h) .. "\n"
	end
	if State.EspTool then
		local t = "None"
		for _, child in ipairs(plr.Character:GetChildren()) do
			if child:IsA("Tool") then t = child.Name end
		end
		if t == "None" and plr:FindFirstChild("Backpack") then
			for _, child in ipairs(plr.Backpack:GetChildren()) do
				if child:IsA("Tool") then t = child.Name end
			end
		end
		text = text .. "Tool: " .. t
	end
	l.Text = text
	b.Enabled = State.EspEnabled
end

local function UpdateESP()
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character then
			local passFilter = true
			if State.ESPFilter ~= "All" then
				if GetRole(plr) ~= State.ESPFilter then
					passFilter = false
				end
			end
			if passFilter then
				CreateHighlight(plr)
				CreateBillboardESP(plr)
			else
				local h = plr.Character:FindFirstChild("AHSTHighlight")
				if h then h.Enabled = false end
				local head = plr.Character:FindFirstChild("Head")
				local b = head and head:FindFirstChild("AHSTESP")
				if b then b.Enabled = false end
			end
		end
	end
end

local camera = workspace.CurrentCamera
local drawingTracers = {}

local function ClearDrawingTracers()
	for plr, line in pairs(drawingTracers) do
		pcall(function()
			line.Visible = false
			line:Remove()
		end)
	end
	table.clear(drawingTracers)
end

local function RenderTracers()
	if not State.Tracers then
		ClearDrawingTracers()
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer and plr.Character then
				local targetHrp = plr.Character:FindFirstChild("HumanoidRootPart")
				if targetHrp then
					local beam = targetHrp:FindFirstChild("AHSTTracerBeam")
					if beam then beam.Enabled = false end
				end
			end
		end
		return
	end
	
	local useDrawing = (Drawing ~= nil and Drawing.new ~= nil)
	local char = LocalPlayer.Character
	local myHrp = char and char:FindFirstChild("HumanoidRootPart")
	
	local myAtt = nil
	if not useDrawing and myHrp then
		myAtt = myHrp:FindFirstChild("AHSTTracerAtt")
		if not myAtt then
			myAtt = Instance.new("Attachment")
			myAtt.Name = "AHSTTracerAtt"
			myAtt.Parent = myHrp
		end
	end
	
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer then
			local passFilter = true
			if State.ESPFilter ~= "All" and GetRole(plr) ~= State.ESPFilter then
				passFilter = false
			end
			
			if passFilter and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				local targetHrp = plr.Character.HumanoidRootPart
				local role = GetRole(plr)
				local color = Color3.fromRGB(0, 255, 0)
				if role == "Murderer" then color = Color3.fromRGB(255, 0, 0)
				elseif role == "Sheriff" then color = Color3.fromRGB(0, 128, 255) end
				
				if useDrawing then
					local oldBeam = targetHrp:FindFirstChild("AHSTTracerBeam")
					if oldBeam then oldBeam.Enabled = false end
					
					local pos, onScreen = camera:WorldToViewportPoint(targetHrp.Position)
					if onScreen then
						local line = drawingTracers[plr]
						if not line then
							local ok, newLine = pcall(function() return Drawing.new("Line") end)
							if ok and newLine then
								line = newLine
								line.Thickness = 1.5
								line.Transparency = 0.8
								drawingTracers[plr] = line
							end
						end
						if line then
							line.Color = color
							line.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
							line.To = Vector2.new(pos.X, pos.Y)
							line.Visible = true
						end
					else
						local line = drawingTracers[plr]
						if line then line.Visible = false end
					end
				else
					if myAtt then
						local targetAtt = targetHrp:FindFirstChild("AHSTTracerAtt")
						if not targetAtt then
							targetAtt = Instance.new("Attachment")
							targetAtt.Name = "AHSTTracerAtt"
							targetAtt.Parent = targetHrp
						end
						
						local beam = targetHrp:FindFirstChild("AHSTTracerBeam")
						if not beam then
							beam = Instance.new("Beam")
							beam.Name = "AHSTTracerBeam"
							beam.Width0 = 0.05
							beam.Width1 = 0.05
							beam.FaceCamera = true
							beam.Segments = 1
							beam.AlwaysOnTop = true
							beam.Transparency = NumberSequence.new(0.25)
							beam.Parent = targetHrp
						end
						
						beam.Attachment0 = myAtt
						beam.Attachment1 = targetAtt
						beam.Color = ColorSequence.new(color)
						beam.Enabled = true
					end
				end
			else
				if useDrawing then
					local line = drawingTracers[plr]
					if line then line.Visible = false end
				else
					if plr.Character then
						local targetHrp = plr.Character:FindFirstChild("HumanoidRootPart")
						if targetHrp then
							local beam = targetHrp:FindFirstChild("AHSTTracerBeam")
							if beam then beam.Enabled = false end
						end
					end
				end
			end
		end
	end
	
	if useDrawing then
		for plr, line in pairs(drawingTracers) do
			if Players:FindFirstChild(plr.Name) == nil or plr.Character == nil or plr.Character.Parent == nil then
				pcall(function()
					line.Visible = false
					line:Remove()
				end)
				drawingTracers[plr] = nil
			end
		end
	end
end

local function ToggleFlight(v)
	State.Fly = v
	local char = LocalPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	if v then
		if not flyPart then
			flyPart = Instance.new("Part")
			flyPart.Size = Vector3.new(4, 1, 4)
			flyPart.Transparency = 1
			flyPart.Anchored = true
			flyPart.Parent = workspace
		end
		task.spawn(function()
			while State.Fly and LocalPlayer.Character and hrp do
				flyPart.CFrame = hrp.CFrame + Vector3.new(0, -3.5, 0)
				local moveDir = Vector3.new(0, 0, 0)
				if UserInputService:IsKeyDown(Enum.KeyCode.W) then
					moveDir = moveDir + workspace.CurrentCamera.CFrame.LookVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.S) then
					moveDir = moveDir - workspace.CurrentCamera.CFrame.LookVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.A) then
					moveDir = moveDir - workspace.CurrentCamera.CFrame.RightVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.D) then
					moveDir = moveDir + workspace.CurrentCamera.CFrame.RightVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
					moveDir = moveDir + Vector3.new(0, 1, 0)
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
					moveDir = moveDir - Vector3.new(0, 1, 0)
				end
				if moveDir.Magnitude > 0 then
					hrp.CFrame = hrp.CFrame + moveDir.Unit * (State.FlySpeed / 10)
				end
				task.wait()
			end
			if flyPart then flyPart:Destroy() flyPart = nil end
		end)
	end
end

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/FloppHub-Team/UIs/refs/heads/main/RayField%20Version%20Cracked"))()

local Window = Rayfield:CreateWindow({
	Name = "AHST MM2 Edition",
	LoadingTitle = "AHST MM2 Edition",
	LoadingSubtitle = "by TheRealBanHammer",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "AHSTMM2",
		FileName = "Config"
	},
	Discord = {
		Enabled = false,
		Invite = "",
		RememberJoins = false
	},
	KeySystem = false
})

local TabStatus = Window:CreateTab("Estado", "activity")
local TabFarm = Window:CreateTab("Autofarm", "coins")
local TabCombat = Window:CreateTab("Combate", "swords")
local TabVisuals = Window:CreateTab("Visuales", "eye")
local TabMovement = Window:CreateTab("Movimiento", "move")
local TabSettings = Window:CreateTab("Ajustes", "settings")
local TabPerformance = Window:CreateTab("Rendimiento", "cpu")
local TabServer = Window:CreateTab("Servidor", "server")

TabStatus:CreateSection("── ESTADO DE LA PARTIDA ──")
local LabelMurd = TabStatus:CreateLabel("Asesino: Ninguno")
local LabelSher = TabStatus:CreateLabel("Sheriff: Ninguno")
local LabelHero = TabStatus:CreateLabel("Heroe: Ninguno")

TabStatus:CreateSection("── CRÉDITOS Y ENLACES ──")
local LabelCredits = TabStatus:CreateLabel("Creado por: TheRealBanHammer | The Fucking Goat")
TabStatus:CreateButton({
	Name = "Copiar link de página web",
	Callback = function()
		if setclipboard then
			setclipboard("https://antihambreadoscriptteam.github.io/")
			Rayfield:Notify({
				Title = "Enlace Copiado",
				Content = "https://antihambreadoscriptteam.github.io/ copiado al portapapeles.",
				Duration = 5
			})
		elseif toclipboard then
			toclipboard("https://antihambreadoscriptteam.github.io/")
			Rayfield:Notify({
				Title = "Enlace Copiado",
				Content = "https://antihambreadoscriptteam.github.io/ copiado al portapapeles.",
				Duration = 5
			})
		end
	end
})

TabFarm:CreateSection("── CONFIGURACIÓN DE AUTO-FARM ──")
TabFarm:CreateToggle({
	Name = "Habilitar Coin Farm",
	CurrentValue = false,
	Callback = function(v) State.CoinFarm = v end
})
TabFarm:CreateDropdown({
	Name = "Moneda Seleccionada",
	Options = {"Coins", "Candies"},
	CurrentOption = "Coins",
	Callback = function(v) State.Currency = v end
})

TabFarm:CreateSection("── EVITAR PELIGRO ──")
TabFarm:CreateToggle({
	Name = "Evitar monedas cerca del asesino",
	CurrentValue = false,
	Callback = function(v) State.AvoidMurderer = v end
})

TabFarm:CreateSection("── COMPORTAMIENTO MOCHILA LLENA ──")
TabFarm:CreateToggle({
	Name = "Reiniciar al llenar mochila",
	CurrentValue = false,
	Callback = function(v) State.ResetBagFull = v end
})
TabFarm:CreateToggle({
	Name = "Ir al Lobby al llenar mochila",
	CurrentValue = false,
	Callback = function(v) State.LobbyBagFull = v end
})
TabFarm:CreateToggle({
	Name = "Hacer Fling al Asesino al llenar mochila",
	CurrentValue = false,
	Callback = function(v) State.FlingBagFull = v end
})

TabFarm:CreateSection("── DISCORD WEBHOOK ──")
TabFarm:CreateToggle({
	Name = "Habilitar Webhook (Farm)",
	CurrentValue = false,
	Callback = function(v) State.CoinWebhook = v end
})
TabFarm:CreateInput({
	Name = "URL del Webhook",
	PlaceholderText = "https://discord.com/api/webhooks/...",
	RemoveTextAfterFocusLost = false,
	Callback = function(v) State.WebhookURL = v end
})
TabFarm:CreateSlider({
	Name = "Intervalo Webhook (Segundos)",
	Range = {10, 300},
	Increment = 1,
	Suffix = "s",
	CurrentValue = 60,
	Callback = function(v) State.WebhookInterval = v end
})
TabFarm:CreateButton({
	Name = "Probar Webhook",
	Callback = function()
		SendWebhookNotification("MM2 Webhook Test", "¡El Webhook de AHST funciona correctamente!")
	end
})

TabCombat:CreateSection("── COMBATE AUTOMÁTICO ──")
TabCombat:CreateToggle({
	Name = "Auto Disparar al Asesino (Sheriff)",
	CurrentValue = false,
	Callback = function(v) State.AutoShoot = v end
})
TabCombat:CreateToggle({
	Name = "Auto Lanzar Cuchillo (Asesino)",
	CurrentValue = false,
	Callback = function(v) State.AutoKnife = v end
})
TabCombat:CreateToggle({
	Name = "Kill Aura (Asesino)",
	CurrentValue = false,
	Callback = function(v) State.KillAura = v end
})
TabCombat:CreateButton({
	Name = "Auto Matar a Todos",
	Callback = function() AutoKillAllFunc() end
})
TabCombat:CreateToggle({
	Name = "Auto Recoger Pistola Tirada",
	CurrentValue = false,
	Callback = function(v)
		task.spawn(function()
			while v do
				AutoPickupGunFunc()
				task.wait(0.5)
			end
		end)
	end
})

TabCombat:CreateSection("── ASISTENCIA DE APUNTADO (AIMBOT) ──")
TabCombat:CreateToggle({
	Name = "Aimbot",
	CurrentValue = false,
	Callback = function(v) State.Aimbot = v end
})
TabCombat:CreateToggle({
	Name = "Silent Aim",
	CurrentValue = false,
	Callback = function(v) State.SilentAim = v end
})
TabCombat:CreateDropdown({
	Name = "Hueso Objetivo",
	Options = {"Head", "Torso"},
	CurrentOption = "Head",
	Callback = function(v) State.TargetBone = v end
})
TabCombat:CreateToggle({
	Name = "Wall Check (Aimbot)",
	CurrentValue = false,
	Callback = function(v) State.WallCheck = v end
})

TabCombat:CreateSection("── SISTEMA ANTI-ASESINO ──")
TabCombat:CreateToggle({
	Name = "Habilitar Anti-Murderer",
	CurrentValue = false,
	Callback = function(v) State.AntiMurderer = v end
})

TabCombat:CreateSection("── MECANISMOS DE FLING ──")
TabCombat:CreateToggle({
	Name = "Touch Fling",
	CurrentValue = false,
	Callback = function(v) State.TouchFling = v end
})
TabCombat:CreateToggle({
	Name = "Anti Fling",
	CurrentValue = false,
	Callback = function(v) State.AntiFling = v end
})
TabCombat:CreateToggle({
	Name = "Auto Fling Asesino",
	CurrentValue = false,
	Callback = function(v) State.AutoFlingMurd = v end
})
TabCombat:CreateToggle({
	Name = "Auto Fling Sheriff/Heroe",
	CurrentValue = false,
	Callback = function(v) State.FlingSheriffHero = v end
})

TabVisuals:CreateSection("── CONFIGURACIÓN DEL ESP ──")
TabVisuals:CreateToggle({
	Name = "Habilitar Player ESP",
	CurrentValue = false,
	Callback = function(v) State.EspEnabled = v end
})
TabVisuals:CreateDropdown({
	Name = "Filtro de Roles ESP",
	Options = {"All", "Murderer", "Sheriff", "Innocent"},
	CurrentOption = "All",
	Callback = function(v) State.ESPFilter = v end
})

TabVisuals:CreateSection("── DETALLES DE ETIQUETA (ESP) ──")
TabVisuals:CreateToggle({
	Name = "Mostrar Nombre",
	CurrentValue = false,
	Callback = function(v) State.EspNames = v end
})
TabVisuals:CreateToggle({
	Name = "Mostrar Rol",
	CurrentValue = false,
	Callback = function(v) State.EspRoles = v end
})
TabVisuals:CreateToggle({
	Name = "Mostrar Distancia",
	CurrentValue = false,
	Callback = function(v) State.EspDist = v end
})
TabVisuals:CreateToggle({
	Name = "Mostrar HP",
	CurrentValue = false,
	Callback = function(v) State.EspHealth = v end
})
TabVisuals:CreateToggle({
	Name = "Mostrar Objeto en Mano",
	CurrentValue = false,
	Callback = function(v) State.EspTool = v end
})

TabVisuals:CreateSection("── GUÍAS VISUALES Y SILUETAS ──")
TabVisuals:CreateToggle({
	Name = "Tracers (Líneas de Guía)",
	CurrentValue = false,
	Callback = function(v) State.Tracers = v end
})
TabVisuals:CreateToggle({
	Name = "Chams (Brillo a través de Paredes)",
	CurrentValue = false,
	Callback = function(v) State.Chams = v end
})
TabVisuals:CreateToggle({
	Name = "Chams en Pistola Tirada",
	CurrentValue = false,
	Callback = function(v) State.DroppedGunChams = v end
})
TabVisuals:CreateToggle({
	Name = "Chams en Monedas",
	CurrentValue = false,
	Callback = function(v) State.CoinESP = v end
})

TabVisuals:CreateSection("── CONFIGURACIÓN DEL MAPA ──")
TabVisuals:CreateToggle({
	Name = "FullBright (Iluminar Mapas)",
	CurrentValue = false,
	Callback = function(v)
		if v then
			Lighting.Ambient = Color3.fromRGB(255, 255, 255)
			Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
			Lighting.Brightness = 3
		else
			Lighting.Ambient = origAmbient
			Lighting.OutdoorAmbient = origOutdoorAmbient
			Lighting.Brightness = origBrightness
		end
	end
})

TabMovement:CreateSection("── VUELO Y NOCLIP ──")
TabMovement:CreateToggle({
	Name = "Habilitar Vuelo (Fly)",
	CurrentValue = false,
	Callback = function(v) ToggleFlight(v) end
})
TabMovement:CreateSlider({
	Name = "Velocidad de Vuelo",
	Range = {10, 150},
	Increment = 1,
	Suffix = "",
	CurrentValue = 50,
	Callback = function(v) State.FlySpeed = v end
})
TabMovement:CreateToggle({
	Name = "Noclip (Atravesar Paredes)",
	CurrentValue = false,
	Callback = function(v)
		State.Noclip = v
		if noclipConnection then noclipConnection:Disconnect() end
		if v then
			noclipConnection = RunService.Stepped:Connect(function()
				local char = LocalPlayer.Character
				if char then
					for _, part in ipairs(char:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
			end)
		end
	end
})

TabMovement:CreateSection("── AJUSTES DE VELOCIDAD Y SALTO ──")
TabMovement:CreateSlider({
	Name = "Velocidad de Caminado (Speed)",
	Range = {16, 150},
	Increment = 1,
	Suffix = "",
	CurrentValue = 16,
	Callback = function(v)
		State.WalkSpeed = v
		local c = LocalPlayer.Character
		if c and c:FindFirstChild("Humanoid") then
			c.Humanoid.WalkSpeed = v
		end
	end
})
TabMovement:CreateSlider({
	Name = "Poder de Salto (Jump)",
	Range = {50, 300},
	Increment = 1,
	Suffix = "",
	CurrentValue = 50,
	Callback = function(v)
		State.JumpPower = v
		local c = LocalPlayer.Character
		if c and c:FindFirstChild("Humanoid") then
			c.Humanoid.JumpPower = v
		end
	end
})
TabMovement:CreateSlider({
	Name = "Altura de Cadera (Hip Height)",
	Range = {0, 50},
	Increment = 1,
	Suffix = "",
	CurrentValue = 0,
	Callback = function(v)
		State.HipHeight = v
		local c = LocalPlayer.Character
		if c and c:FindFirstChild("Humanoid") then
			c.Humanoid.HipHeight = v
		end
	end
})
TabMovement:CreateSlider({
	Name = "Campo de Visión (FOV)",
	Range = {70, 120},
	Increment = 1,
	Suffix = "",
	CurrentValue = 70,
	Callback = function(v)
		State.FOV = v
		workspace.CurrentCamera.FieldOfView = v
	end
})

TabMovement:CreateSection("── CAPACIDADES DE MOVIMIENTO ESPONTÁNEAS ──")
TabMovement:CreateToggle({
	Name = "Salto Infinito",
	CurrentValue = false,
	Callback = function(v)
		State.InfJump = v
		UserInputService.JumpRequest:Connect(function()
			if State.InfJump then
				local c = LocalPlayer.Character
				if c and c:FindFirstChild("HumanoidRootPart") then
					c.HumanoidRootPart.Velocity = Vector3.new(c.HumanoidRootPart.Velocity.X, State.JumpPower, c.HumanoidRootPart.Velocity.Z)
				end
			end
		end)
	end
})
TabMovement:CreateToggle({
	Name = "Auto Salto",
	CurrentValue = false,
	Callback = function(v)
		State.AutoJump = v
		task.spawn(function()
			while State.AutoJump do
				local c = LocalPlayer.Character
				if c and c:FindFirstChild("Humanoid") then
					c.Humanoid.Jump = true
				end
				task.wait(0.1)
			end
		end)
	end
})
TabMovement:CreateToggle({
	Name = "Bhop (Bunny Hop)",
	CurrentValue = false,
	Callback = function(v) State.Bhop = v end
})
TabMovement:CreateToggle({
	Name = "SpinBot (Girar Personaje)",
	CurrentValue = false,
	Callback = function(v) State.SpinBot = v end
})
TabMovement:CreateSlider({
	Name = "Velocidad de Giro",
	Range = {10, 200},
	Increment = 1,
	Suffix = "",
	CurrentValue = 50,
	Callback = function(v) State.SpinSpeed = v end
})

TabMovement:CreateSection("── ENFOQUE Y SEGUIMIENTO DE JUGADOR ──")
TabMovement:CreateInput({
	Name = "Nombre de Jugador Objetivo",
	PlaceholderText = "Escribe el nombre...",
	RemoveTextAfterFocusLost = false,
	Callback = function(v) State.TargetPlayer = v end
})
local DropdownPlayers = TabMovement:CreateDropdown({
	Name = "Seleccionar Jugador Objetivo",
	Options = {"All"},
	CurrentOption = "All",
	Callback = function(v) State.TargetPlayer = v end
})
TabMovement:CreateButton({
	Name = "Actualizar Lista de Jugadores",
	Callback = function()
		local l = {}
		for _, p in ipairs(Players:GetPlayers()) do
			table.insert(l, p.Name)
		end
		DropdownPlayers:Refresh(l)
	end
})
TabMovement:CreateToggle({
	Name = "Espectar Jugador",
	CurrentValue = false,
	Callback = function(v)
		State.Spectate = v
		local c = workspace.CurrentCamera
		if v and State.TargetPlayer ~= "" then
			local t = Players:FindFirstChild(State.TargetPlayer)
			if t and t.Character and t.Character:FindFirstChild("Humanoid") then
				c.CameraSubject = t.Character.Humanoid
			end
		else
			local char = LocalPlayer.Character
			if char and char:FindFirstChild("Humanoid") then
				c.CameraSubject = char.Humanoid
			end
		end
	end
})
TabMovement:CreateToggle({
	Name = "Bucle Ir hacia Él (Loop Goto)",
	CurrentValue = false,
	Callback = function(v)
		State.LoopGoto = v
		if loopGotoConnection then loopGotoConnection:Disconnect() end
		if v and State.TargetPlayer ~= "" then
			loopGotoConnection = RunService.RenderStepped:Connect(function()
				local t = Players:FindFirstChild(State.TargetPlayer)
				local char = LocalPlayer.Character
				if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") and char and char:FindFirstChild("HumanoidRootPart") then
					char.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame
				end
			end)
		end
	end
})
TabMovement:CreateButton({
	Name = "Teletransportarse al Jugador",
	Callback = function()
		if State.TargetPlayer ~= "" then
			local t = Players:FindFirstChild(State.TargetPlayer)
			local char = LocalPlayer.Character
			if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") and char and char:FindFirstChild("HumanoidRootPart") then
				char.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame
			end
		end
	end
})
TabMovement:CreateButton({
	Name = "Fling al Jugador",
	Callback = function()
		if State.TargetPlayer ~= "" then
			local t = Players:FindFirstChild(State.TargetPlayer)
			if t then FlingPlayer(t) end
		end
	end
})

TabMovement:CreateSection("── TELETRANSPORTE DIRECTO DE MAPA ──")
TabMovement:CreateButton({
	Name = "Ir al Lobby",
	Callback = function() TeleportToLobby() end
})
TabMovement:CreateButton({
	Name = "Ir al Mapa",
	Callback = function() TeleportToMapPart() end
})
TabMovement:CreateButton({
	Name = "Ir al Sheriff",
	Callback = function() TeleportToRole("Sheriff") end
})
TabMovement:CreateButton({
	Name = "Ir al Héroe",
	Callback = function()
		local h = GetHero()
		if h and h.Character and h.Character:FindFirstChild("HumanoidRootPart") then
			local char = LocalPlayer.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				char.HumanoidRootPart.CFrame = h.Character.HumanoidRootPart.CFrame
			end
		end
	end
})
TabMovement:CreateButton({
	Name = "Ir al Asesino",
	Callback = function() TeleportToRole("Murderer") end
})

TabSettings:CreateSection("── MÓDULOS DE PROTECCIÓN ──")
TabSettings:CreateToggle({
	Name = "Habilitar Godmode",
	CurrentValue = false,
	Callback = function(v)
		State.Godmode = v
		local char = LocalPlayer.Character
		if char and char:FindFirstChild("Humanoid") then
			if v then
				local clone = char.Humanoid:Clone()
				char.Humanoid:Destroy()
				clone.Parent = char
			end
		end
	end
})
TabSettings:CreateToggle({
	Name = "Habilitar Desync",
	CurrentValue = false,
	Callback = function(v) State.Desync = v end
})
TabSettings:CreateToggle({
	Name = "Habilitar Anti-AFK",
	CurrentValue = true,
	Callback = function(v)
		State.AntiAFK = v
		if v then
			LocalPlayer.Idled:Connect(function()
				if State.AntiAFK then
					local vu = game:GetService("VirtualUser")
					vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
					task.wait(0.5)
					vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
				end
			end)
		end
	end
})

TabSettings:CreateSection("── APERTURA DE CAJAS MISTERIOSAS ──")
TabSettings:CreateToggle({
	Name = "Abrir Caja de Misterio Auto",
	CurrentValue = false,
	Callback = function(v)
		State.AutoOpenMystery = v
		task.spawn(function()
			while State.AutoOpenMystery do
				local r = ReplicatedStorage:FindFirstChild("BuyBox", true) or ReplicatedStorage:FindFirstChild("OpenBox", true)
				if r then
					r:FireServer(State.SelectedMystery)
				end
				task.wait(2)
			end
		end)
	end
})
TabSettings:CreateDropdown({
	Name = "Seleccionar Caja de Misterio",
	Options = {"Mystery Box", "Knife Box 1", "Knife Box 2", "Knife Box 3", "Knife Box 4", "Knife Box 5", "Gun Box 1", "Gun Box 2", "Gun Box 3"},
	CurrentOption = "Mystery Box",
	Callback = function(v) State.SelectedMystery = v end
})

TabSettings:CreateSection("── REPORTES DE CAJAS (WEBHOOK) ──")
TabSettings:CreateToggle({
	Name = "Habilitar Webhook (Mystery Box)",
	CurrentValue = false,
	Callback = function(v) State.MysteryWebhook = v end
})
TabSettings:CreateDropdown({
	Name = "Rareza Mínima Webhook",
	Options = {"Common", "Uncommon", "Rare", "Legendary", "Godly"},
	CurrentOption = "Common",
	Callback = function(v) State.WebhookRarity = v end
})

TabSettings:CreateSection("── EMOTES EXCLUSIVOS ──")
TabSettings:CreateDropdown({
	Name = "Reproducir Emotes Pro",
	Options = {"dance", "dance2", "dance3", "floss", "dab", "zombie", "ninja"},
	CurrentOption = "dance",
	Callback = function(v)
		local char = LocalPlayer.Character
		if char and char:FindFirstChild("Humanoid") then
			local a = char.Humanoid:FindFirstChildOfClass("Animator")
			if not a then
				a = Instance.new("Animator")
				a.Parent = char.Humanoid
			end
			local playRemote = ReplicatedStorage:FindFirstChild("PlayEmote", true) or ReplicatedStorage:FindFirstChild("Emote", true)
			if playRemote then
				playRemote:FireServer(v)
			end
		end
	end
})

TabSettings:CreateSection("── PERFILES DE CONFIGURACIÓN ──")
TabSettings:CreateInput({
	Name = "Nombre de Configuración",
	PlaceholderText = "DefaultConfig",
	RemoveTextAfterFocusLost = false,
	Callback = function(v) State.ConfigName = v end
})
TabSettings:CreateButton({
	Name = "Guardar Archivo (Exportar)",
	Callback = function()
		if writefile and State.ConfigName ~= "" then
			writefile("AHSTMM2_" .. State.ConfigName .. ".json", HttpService:JSONEncode(State))
			Rayfield:Notify({
				Title = "Configuración Guardada",
				Content = "Se ha exportado el archivo de configuración con éxito.",
				Duration = 5
			})
		end
	end
})
TabSettings:CreateButton({
	Name = "Cargar Archivo (Importar)",
	Callback = function()
		if readfile and isfile and State.ConfigName ~= "" then
			local filename = "AHSTMM2_" .. State.ConfigName .. ".json"
			if isfile(filename) then
				local imported = HttpService:JSONDecode(readfile(filename))
				for k, v in pairs(imported) do
					State[k] = v
				end
				Rayfield:Notify({
					Title = "Configuración Cargada",
					Content = "Se han aplicado los ajustes de la configuración seleccionada.",
					Duration = 5
				})
			end
		end
	end
})

TabPerformance:CreateSection("── EXTRACCIONES GRÁFICAS ──")
TabPerformance:CreateToggle({
	Name = "Desactivar Renderizado 3D",
	CurrentValue = false,
	Callback = function(v)
		State.Disable3D = v
		RunService:Set3dRenderingEnabled(not v)
	end
})
TabPerformance:CreateToggle({
	Name = "Gráficos Súper Bajos",
	CurrentValue = false,
	Callback = function(v)
		State.LowGraphics = v
		if v then
			for _, obj in ipairs(workspace:GetDescendants()) do
				if obj:IsA("BasePart") then
					obj.Material = Enum.Material.SmoothPlastic
				elseif obj:IsA("Decal") or obj:IsA("Texture") then
					obj.Transparency = 1
				elseif obj:IsA("ParticleEmitter") or obj:IsA("Sparkles") or obj:IsA("Fire") then
					obj.Enabled = false
				end
			end
		end
	end
})
TabPerformance:CreateButton({
	Name = "Boost de FPS Extremo",
	Callback = function()
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("PostEffect") or obj:IsA("PostProcessEffect") then
				obj.Enabled = false
			end
		end
	end
})

TabPerformance:CreateSection("── PANTALLAS DE AHORRO AFK ──")
TabPerformance:CreateToggle({
	Name = "Pantalla Negra (Afk)",
	CurrentValue = false,
	Callback = function(v)
		State.BlackScreen = v
		if colorGui then colorGui:Destroy() colorGui = nil end
		if v then
			colorGui = Instance.new("ScreenGui")
			colorGui.Name = "AHSTBlack"
			colorGui.Parent = game.CoreGui
			local f = Instance.new("Frame")
			f.Size = UDim2.new(1, 0, 1, 0)
			f.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			f.BorderSizePixel = 0
			f.Parent = colorGui
		end
	end
})
TabPerformance:CreateToggle({
	Name = "Pantalla Blanca (Afk)",
	CurrentValue = false,
	Callback = function(v)
		State.WhiteScreen = v
		if colorGui then colorGui:Destroy() colorGui = nil end
		if v then
			colorGui = Instance.new("ScreenGui")
			colorGui.Name = "AHSTWhite"
			colorGui.Parent = game.CoreGui
			local f = Instance.new("Frame")
			f.Size = UDim2.new(1, 0, 1, 0)
			f.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			f.BorderSizePixel = 0
			f.Parent = colorGui
		end
	end
})

TabServer:CreateSection("── ACCIONES DE SERVIDOR ──")
TabServer:CreateButton({
	Name = "Reconectarse (Rejoin)",
	Callback = function()
		TeleportService:Teleport(game.PlaceId, LocalPlayer)
	end
})
TabServer:CreateButton({
	Name = "Cambiar de Servidor (Serverhop)",
	Callback = function()
		if HttpService then
			local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Asc&limit=100"))
			for _, s in ipairs(servers.data) do
				if s.playing < s.maxPlayers and s.id ~= game.JobId then
					TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer)
					break
				end
			end
		end
	end
})
TabServer:CreateButton({
	Name = "Navegador de Servidores",
	Callback = function()
		Rayfield:Notify({
			Title = "Buscador de Servidores",
			Content = "Lista de servidores activos refrescada con éxito.",
			Duration = 3
		})
	end
})

TabServer:CreateSection("── CONTROL AUTOMÁTICO DE HOP ──")
TabServer:CreateToggle({
	Name = "Habilitar Auto Server Hop",
	CurrentValue = false,
	Callback = function(v) State.AutoHop = v end
})
TabServer:CreateSlider({
	Name = "Hop si hay menos de X jugadores",
	Range = {1, 12},
	Increment = 1,
	Suffix = "",
	CurrentValue = 3,
	Callback = function(v) State.HopLessPlayers = v end
})
TabServer:CreateSlider({
	Name = "Hop después de X segundos",
	Range = {30, 600},
	Increment = 1,
	Suffix = "s",
	CurrentValue = 300,
	Callback = function(v) State.HopAfterSeconds = v end
})

task.spawn(function()
	while true do
		local m = GetMurderer()
		local s = GetSheriff()
		local h = GetHero()
		
		pcall(function() LabelMurd:Set(m and "Asesino: " .. m.Name or "Asesino: Ninguno") end)
		pcall(function() LabelSher:Set(s and "Sheriff: " .. s.Name or "Sheriff: Ninguno") end)
		pcall(function() LabelHero:Set(h and "Heroe: " .. h.Name or "Heroe: Ninguno") end)
		task.wait(1)
	end
end)

task.spawn(function()
	while true do
		if State.CoinFarm then
			local char = LocalPlayer.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if hrp then
				if IsBagFull() then
					if State.ResetBagFull then
						char:BreakJoints()
						task.wait(5)
					elseif State.LobbyBagFull then
						TeleportToLobby()
						task.wait(3)
					elseif State.FlingBagFull then
						local murd = GetMurderer()
						if murd then FlingPlayer(murd) end
						task.wait(2)
					end
				else
					local coins = GetCoins()
					local target = nil
					local minDist = math.huge
					local murd = GetMurderer()
					
					for _, coin in ipairs(coins) do
						if coin and coin.Parent then
							local valid = true
							if State.AvoidMurderer and murd and murd.Character and murd.Character:FindFirstChild("HumanoidRootPart") then
								local mPos = murd.Character.HumanoidRootPart.Position
								if (coin.Position - mPos).Magnitude < 50 then
									valid = false
								end
							end
							
							if valid then
								local d = (coin.Position - hrp.Position).Magnitude
								if d < minDist then
									minDist = d
									target = coin
								end
							end
						end
					end
					
					if target then
						hrp.CFrame = target.CFrame
						if firetouchinterest then
							firetouchinterest(hrp, target, 0)
							task.wait()
							firetouchinterest(hrp, target, 1)
						end
						if State.CoinWebhook and (os.time() - lastWebhookSent) > State.WebhookInterval then
							SendWebhookNotification("MM2 Coin Farm", "Recolectando monedas. Bolsa llena: " .. tostring(IsBagFull()))
							lastWebhookSent = os.time()
						end
					end
				end
			end
		end
		task.wait(0.2)
	end
end)

task.spawn(function()
	while true do
		if State.AutoShoot then AutoShootMurdererFunc() end
		if State.AutoKnife then AutoKnifeThrowFunc() end
		if State.KillAura then KillAuraFunc() end
		if State.AntiMurderer then
			local murd = GetMurderer()
			if murd and murd.Character and murd.Character:FindFirstChild("HumanoidRootPart") then
				local char = LocalPlayer.Character
				if char and char:FindFirstChild("HumanoidRootPart") then
					local dist = (char.HumanoidRootPart.Position - murd.Character.HumanoidRootPart.Position).Magnitude
					if dist < 45 then
						local gun = char:FindFirstChild("Gun") or (LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack:FindFirstChild("Gun"))
						if gun then
							AutoShootMurdererFunc()
						else
							local safePlr = GetFurthestPlayerFromMurderer()
							if safePlr and safePlr.Character and safePlr.Character:FindFirstChild("HumanoidRootPart") then
								char.HumanoidRootPart.CFrame = safePlr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
							else
								char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 15, 0)
							end
						end
					end
				end
			end
		end
		if State.TouchFling then
			local char = LocalPlayer.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if hrp then
				hrp.Velocity = Vector3.new(0, 99999, 0)
			end
		end
		if State.AutoFlingMurd then
			local murd = GetMurderer()
			if murd then FlingPlayer(murd) end
		end
		if State.FlingSheriffHero then
			local sh = GetSheriff() or GetHero()
			if sh then FlingPlayer(sh) end
		end
		task.wait(0.1)
	end
end)

task.spawn(function()
	while true do
		pcall(UpdateESP)
		pcall(RenderTracers)
		task.wait(0.02)
	end
end)

task.spawn(function()
	while true do
		local gun = workspace:FindFirstChild("GunDrop", true)
		if gun and gun:IsA("BasePart") then
			local h = gun:FindFirstChild("AHSTGunCham")
			if not h then
				h = Instance.new("Highlight")
				h.Name = "AHSTGunCham"
				h.FillColor = Color3.fromRGB(0, 255, 255)
				h.OutlineColor = Color3.fromRGB(255, 255, 255)
				h.FillTransparency = 0.4
				h.Parent = gun
			end
			h.Enabled = State.DroppedGunChams
		end
		
		if State.CoinESP then
			for _, coin in ipairs(GetCoins()) do
				if coin and coin.Parent then
					local h = coin:FindFirstChild("AHSTCoinCham")
					if not h then
						h = Instance.new("Highlight")
						h.Name = "AHSTCoinCham"
						h.FillColor = Color3.fromRGB(255, 215, 0)
						h.OutlineColor = Color3.fromRGB(255, 255, 255)
						h.FillTransparency = 0.5
						h.Parent = coin
					end
					h.Enabled = true
				end
			end
		end
		task.wait(1)
	end
end)

task.spawn(function()
	while true do
		if State.Bhop then
			local c = LocalPlayer.Character
			if c and c:FindFirstChild("Humanoid") and c.Humanoid.MoveDirection.Magnitude > 0 then
				c.Humanoid.Jump = true
			end
		end
		task.wait(0.05)
	end
end)

task.spawn(function()
	while true do
		if State.SpinBot then
			local c = LocalPlayer.Character
			if c and c:FindFirstChild("HumanoidRootPart") then
				c.HumanoidRootPart.CFrame = c.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(State.SpinSpeed), 0)
			end
		end
		task.wait()
	end
end)

task.spawn(function()
	while true do
		if State.Desync then
			local char = LocalPlayer.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if hrp then
				local oldVel = hrp.Velocity
				hrp.Velocity = Vector3.new(99999, 99999, 99999)
				RunService.Heartbeat:Wait()
				hrp.Velocity = oldVel
			end
		end
		task.wait()
	end
end)

task.spawn(function()
	while true do
		if State.AutoHop then
			local count = #Players:GetPlayers()
			if count <= State.HopLessPlayers or (os.time() - serverStartTime) > State.HopAfterSeconds then
				local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Asc&limit=100"))
				for _, s in ipairs(servers.data) do
					if s.playing < s.maxPlayers and s.id ~= game.JobId then
						TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer)
						break
					end
				end
			end
		end
		task.wait(10)
	end
end)

if isfile and readfile and isfile("AHSTMM2_LatestConfig.json") then
	pcall(function()
		local imported = HttpService:JSONDecode(readfile("AHSTMM2_LatestConfig.json"))
		for k, v in pairs(imported) do
			State[k] = v
		end
	end)
end

Rayfield:Notify({
	Title = "AHST MM2 Ready",
	Content = "Credits: TheRealBanHammer | The Fucking Goat",
	Duration = 5
})

