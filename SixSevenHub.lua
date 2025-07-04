local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "SixSevenHub"
screenGui.ResetOnSpawn = false

local themes = {
    Dark = {bg = Color3.fromRGB(25,25,25), btn = Color3.fromRGB(40,40,40), text = Color3.new(1,1,1)},
    Blue = {bg = Color3.fromRGB(20,25,60), btn = Color3.fromRGB(30,60,120), text = Color3.new(1,1,1)},
    Red  = {bg = Color3.fromRGB(50,0,0),    btn = Color3.fromRGB(140,30,30), text = Color3.new(1,1,1)}
}
local selectedTheme = themes.Dark
local wrapper, toggleBtn, contentHolder, tabs = nil, nil, nil, {}

local function createTabPage(name)
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 1000)
    scroll.ScrollBarThickness = 6
    scroll.BackgroundTransparency = 1
    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0, 10)
    tabs[name] = scroll
    return scroll
end

local function createButton(parent, text, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 0)
    btn.Text = text
    btn.Font = Enum.Font.GothamSemibold
    btn.TextScaled = true
    btn.TextColor3 = selectedTheme.text
    btn.BackgroundColor3 = selectedTheme.btn
    btn.MouseButton1Click:Connect(function()
        print("Clicked:", text)
        local s, e = pcall(callback)
        if not s then warn("Script error:", e) end
    end)
end

local function buildGUI(theme)
    selectedTheme = theme

    wrapper = Instance.new("Frame", screenGui)
    wrapper.Size = UDim2.new(0, 270, 0, 420)
    wrapper.Position = UDim2.new(0.5, -135, 0.5, -210)
    wrapper.BackgroundColor3 = theme.bg
    wrapper.Active = true
    wrapper.Draggable = true

    local header = Instance.new("TextLabel", wrapper)
    header.Size = UDim2.new(1, 0, 0, 40)
    header.Text = "SixSeven Hub 6️⃣7️⃣"
    header.Font = Enum.Font.GothamBold
    header.TextScaled = true
    header.TextColor3 = theme.text
    header.BackgroundTransparency = 1
    local tabBar = Instance.new("Frame", wrapper)
