-- Create the main screen GUI
local screenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
screenGui.Name = "BryantHub"
screenGui.ResetOnSpawn = false

-- Create the main frame
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

-- Create the title label
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Bryant's Hub"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Name = "Title"

-- Create the Home section container
local HomeSection = Instance.new("Frame", mainFrame)
HomeSection.Name = "HomeSection"
HomeSection.Position = UDim2.new(0, 0, 0, 40)
HomeSection.Size = UDim2.new(1, 0, 1, -40)
HomeSection.BackgroundTransparency = 1

-- Helper to make buttons
local function createButton(name, text, order)
    local button = Instance.new("TextButton", HomeSection)
    button.Name = name .. "Button"
    button.Text = text
    button.Size = UDim2.new(0.9, 0, 0, 30)
    button.Position = UDim2.new(0.05, 0, 0, (order - 1) * 35)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.Gotham
    button.TextSize = 16
    button.AutoButtonColor = true
    return button
end

-- Create all buttons
local TigerXButton = createButton("TigerX", "Tiger X", 1)
local GhostHubButton = createButton("GhostHub", "GhostHub", 2)
local RC7Button = createButton("RC7", "RC7", 3)
local FlyGuiButton = createButton("FlyGui", "Fly GUI V3", 4)
local HyperlaserGunButton = createButton("HyperlaserGun", "Hyperlaser Gun", 5)

-- Function to load external scripts
local function loadScriptFromURL(url)
    local success, result = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    if not success then
        warn("Failed to load script: " .. tostring(result))
    end
end

-- Button connections
TigerXButton.MouseButton1Click:Connect(function()
    loadScriptFromURL("https://example.com/tigerx.lua")
end)

GhostHubButton.MouseButton1Click:Connect(function()
    loadScriptFromURL("https://example.com/ghosthub.lua")
end)

RC7Button.MouseButton1Click:Connect(function()
    loadScriptFromURL("https://raw.githubusercontent.com/CoreGui/Scripts/main/RC7")
end)

FlyGuiButton.MouseButton1Click:Connect(function()
    loadScriptFromURL("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt")
end)

HyperlaserGunButton.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        local p = game.Players.LocalPlayer
        local Tool = Instance.new("Tool", p.Backpack)
        Tool.Name = "LaserGun"
        Tool.TextureId = "http://www.roblox.com/asset?id=130093050"

        local Handle = Instance.new("Part", Tool)
        Handle.Name = "Handle"

        local Mesh = Instance.new("SpecialMesh", Handle)
        Mesh.MeshId = "http://www.roblox.com/asset?id=130099641"
        Mesh.Scale = Vector3.new(0.65, 0.65, 0.65)
        Mesh.TextureId = "http://www.roblox.com/asset?id=130093033"

        local FireSound = Instance.new("Sound", Handle)
        FireSound.Name = "Fire"
        FireSound.SoundId = "http://www.roblox.com/asset?id=130113322"

        local ReloadSound = Instance.new("Sound", Handle)
        ReloadSound.Name = "Reload"
        ReloadSound.SoundId = "http://www.roblox.com/asset?id=130113370"

        local HitFadeSound = Instance.new("Sound", Handle)
        HitFadeSound.Name = "HitFade"
        HitFadeSound.SoundId = "http://www.roblox.com/asset?id=130113415"

        local PointLight = Instance.new("PointLight", Handle)
        PointLight.Color = Color3.new(0, 1, 1)
        PointLight.Range = 6

        local SHOT_SPEED = 100
        local SHOT_TIME = 1
        local NOZZLE_OFFSET = Vector3.new(0, 0.4, -1.1)

        local Debris = game:GetService("Debris")
        local Players = game:GetService("Players")

        local BaseShot = Instance.new("Part")
        BaseShot.Name = "Effect"
        BaseShot.Size = Vector3.new(0.2, 0.2, 3)
        BaseShot.Anchored = false
        BaseShot.BrickColor = BrickColor.new("Toothpaste")
        BaseShot.CanCollide = false
        local sb = Instance.new("SelectionBox", BaseShot)
        sb.Adornee = BaseShot
        PointLight:Clone().Parent = BaseShot
        HitFadeSound:Clone().Parent = BaseShot

        local Character, Humanoid, PlayerRef

        local function FindCharAncestor(obj)
            if obj and obj ~= workspace then
                local h = obj:FindFirstChild("Humanoid")
                if h then return obj, h else return FindCharAncestor(obj.Parent) end
            end
        end

        local function ApplyTags(hum)
            local creator = Instance.new("ObjectValue")
            creator.Name = "creator"
            creator.Value = PlayerRef
            local icon = Instance.new("StringValue", creator)
            icon.Name = "icon"
            icon.Value = Tool.TextureId
            icon.Parent = creator
            creator.Parent = hum
            Debris:AddItem(creator, 4)
        end

        local function Dematerialize(char, hum, part)
            hum.WalkSpeed = 0
            for _, c in pairs(char:GetChildren()) do
                if c:IsA("BasePart") then c.Anchored = true end
                if c:IsA("Script") or c:IsA("LocalScript") then c:Destroy() end
            end
            for _, d in pairs(char:GetDescendants()) do
                if d:IsA("BasePart") or d:IsA("Decal") then
                    d.Transparency = 1
                end
            end
            hum.Health = 0
            Debris:AddItem(char, 2)
        end

        local function OnTouched(shot, part)
            local char, hum = FindCharAncestor(part)
            if char and hum and char ~= Character then
                ApplyTags(hum)
                if shot then shot:Destroy() end
                Dematerialize(char, hum, part)
            end
        end

        Tool.Equipped:Connect(function()
            Character = Tool.Parent
            Humanoid = Character:WaitForChild("Humanoid")
            PlayerRef = Players:GetPlayerFromCharacter(Character)
        end)

        Tool.Activated:Connect(function()
            if Tool.Enabled and Humanoid and Humanoid.Health > 0 then
                Tool.Enabled = false
                FireSound:Play()
                local firePos = Handle.CFrame.p + Handle.CFrame:vectorToWorldSpace(NOZZLE_OFFSET)
                local cf = CFrame.new(firePos, Humanoid.TargetPoint)

                local shot = BaseShot:Clone()
                shot.CFrame = cf + (cf.LookVector * (BaseShot.Size.Z / 2))
                local bv = Instance.new("BodyVelocity", shot)
                bv.Velocity = cf.LookVector * SHOT_SPEED
                bv.Parent = shot
                shot.Touched:Connect(function(part)
                    OnTouched(shot, part)
                end)
                shot.Parent = Tool
                Debris:AddItem(shot, SHOT_TIME)

                wait(0.6)
                ReloadSound:Play()
                wait(0.75)
                Tool.Enabled = true
            end
        end)
    end)

    if not success then
        warn("
