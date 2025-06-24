local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SixSevenHub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Main Frame
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Title
local title = Instance.new("TextLabel")
title.Text = "SixSeven Hub 💀💻"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = frame

-- Button creator
local function createButton(name, order)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Text = name
    button.Size = UDim2.new(0.9, 0, 0, 35)
    button.Position = UDim2.new(0.05, 0, 0, 45 + (order-1)*40)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.new(1,1,1)
    button.Font = Enum.Font.Gotham
    button.TextSize = 16
    button.AutoButtonColor = true
    button.Parent = frame
    return button
end

-- Create Buttons
local TigerXButton = createButton("Tiger X", 1)
local GhostHubButton = createButton("GhostHub", 2)
local RC7Button = createButton("RC7", 3)
local FlyGuiButton = createButton("Fly GUI V3", 4)
local HyperlaserGunButton = createButton("Hyperlaser Gun", 5)

-- Script loader
local function loadScriptFromURL(url)
    pcall(function()
        loadstring(game:HttpGet(url))()
    end)
end

-- Button Logic
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
    pcall(function()
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

        local Debris = game:GetService("Debris")
        local function onHit(part)
            local char = part:FindFirstAncestorOfClass("Model")
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.Health = 0
                Debris:AddItem(char, 2)
            end
        end

        Tool.Equipped:Connect(function()
            Tool.Activated:Connect(function()
                local shot = Instance.new("Part")
                shot.Size = Vector3.new(0.2, 0.2, 3)
                shot.BrickColor = BrickColor.new("Toothpaste")
                shot.Anchored = false
                shot.CanCollide = false
                shot.CFrame = Handle.CFrame * CFrame.new(0, 0.4, -1.1)
                local bv = Instance.new("BodyVelocity", shot)
                bv.Velocity = Handle.CFrame.LookVector * 100
                shot.Touched:Connect(function(hit)
                    onHit(hit)
                    shot:Destroy()
                end)
                shot.Parent = Tool
                Debris:AddItem(shot, 1)
                FireSound:Play()
                wait(0.6)
                ReloadSound:Play()
            end)
        end)
    end)
end)
