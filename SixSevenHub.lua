local plr = game:GetService("Players").LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:FindFirstChild("Humanoid") or char:WaitForChild("Humanoid")
local anim = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator")
local pack = plr:FindFirstChild("Backpack") or plr:WaitForChild("Backpack")

if workspace:FindFirstChild("aaa") then
workspace:FindFirstChild("aaa"):Destroy()
end

local function getmodel()
return hum.RigType == Enum.HumanoidRigType.R15 and "R15" or "R6"
end

local function Notify(Title, Text, Duration)
game:GetService('StarterGui'):SetCore('SendNotification', {
Title = Title,
Text = Text or '',
Duration = Duration}
)
end

Notify("Script Made By guest666", 20)

loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Red-hyperlaser-gun-24963"))()

