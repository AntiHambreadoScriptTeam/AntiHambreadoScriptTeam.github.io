local Desired_Values = 999999999999999 -- Amount
local Event = game:GetService("ReplicatedStorage").Remotes.UI.UIRemoteEvent

local ObtainInfPoints = function()
Event:FireServer(
(function(bytes)
local b = buffer.create(#bytes)
for i = 1, #bytes do
buffer.writeu8(b, i - 1, bytes[i])
end
return b
end)({ 82, 69, 81, 85, 69, 83, 84, 95, 65, 80, 80, 76, 89, 95, 83, 84, 65, 84, 80, 79, 73, 78, 84 }),
"Blade",
-math.huge
)
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("StatRefundService"):WaitForChild("FreeRefund"):FireServer()
end
local AddPoints = function(Stat,Amount)
Event:FireServer(
(function(bytes)
local b = buffer.create(#bytes)
for i = 1, #bytes do
buffer.writeu8(b, i - 1, bytes[i])
end
return b
end)({ 82, 69, 81, 85, 69, 83, 84, 95, 65, 80, 80, 76, 89, 95, 83, 84, 65, 84, 80, 79, 73, 78, 84 }),
Stat,
Amount
)
end

ObtainInfPoints()
AddPoints("Strength",Desired_Values)
AddPoints("Ability",Desired_Values)
AddPoints("Health",Desired_Values)
AddPoints("Stamina",Desired_Values)
AddPoints("Blade",Desired_Values)

local Event = game:GetService("ReplicatedStorage").Remotes.Inventory.ToolUpdate
Event:InvokeServer(
"Fist",
"Equip"
)
local Event = game:GetService("ReplicatedStorage").Remotes.Combat.CombatHit
Event:FireServer(
workspace.World.Alive:GetChildren(),
1
)
