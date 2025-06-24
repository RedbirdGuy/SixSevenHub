local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "SixSevenHub"
screenGui.ResetOnSpawn = false

-- Theme Styles
local themes = {
    Dark = {bg = Color3.fromRGB(25,25,25), btn = Color3.fromRGB(40,40,40), text = Color3.new(1,1,1)},
    Blue = {bg = Color3.fromRGB(20,25,60), btn = Color3.fromRGB(30,60,120), text = Color3.new(1,1,1)},
    Red =  {bg = Color3.fromRGB(50,0,0),    btn = Color3.fromRGB(140,30,30), text = Color3.new(1,1,1)}
}
local selectedTheme = themes.Dark

-- Toggle Button (hidden until theme picked)
local toggleBtn = Instance.new("TextButton", screenGui)
toggleBtn.Size = UDim2.new(0, 100, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0.5, -20)
toggleBtn.Text = "Toggle UI"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Visible = false

-- Top Footer
local footer = Instance.new("TextLabel", screenGui)
footer.Text = "SixSeven Script Made By Gustavo199140"
footer.Font = Enum.Font.GothamSemibold
footer.TextColor3 = Color3.new(1,1,1)
footer.TextSize = 14
footer.Size = UDim2.new(0, 250, 0, 20)
footer.Position = UDim2.new(0.5, -125, 0, 20)
footer.BackgroundTransparency = 1

-- Main GUI Wrapper
local wrapper = Instance.new("Frame", screenGui)
wrapper.Size = UDim2.new(0, 270, 0, 420)
wrapper.Position = UDim2.new(0.5, -135, 0.5, -210)
wrapper.BackgroundColor3 = selectedTheme.bg
wrapper.BorderSizePixel = 0
wrapper.Active = true
wrapper.Draggable = true
wrapper.Visible = false

-- Header
local header = Instance.new("TextLabel", wrapper)
header.Size = UDim2.new(1, 0, 0, 40)
header.Text = "SixSeven Hub 6️⃣7️⃣"
header.Font = Enum.Font.GothamBold
header.TextColor3 = Color3.new(1,1,1)
header.TextScaled = true
header.BackgroundTransparency = 1

-- Tab Bar
local tabBar = Instance.new("Frame", wrapper)
tabBar.Size = UDim2.new(1, 0, 0, 35)
tabBar.Position = UDim2.new(0, 0, 0, 40)
tabBar.BackgroundTransparency = 1

-- Section Pages
local contentHolder = Instance.new("Frame", wrapper)
contentHolder.Size = UDim2.new(1, 0, 1, -75)
contentHolder.Position = UDim2.new(0, 0, 0, 75)
contentHolder.BackgroundTransparency = 1

local tabs = {}
local function switchTab(name)
    for t, f in pairs(tabs) do
        f.Visible = (t == name)
    end
end

local function createTabPage(name)
    local scroll = Instance.new("ScrollingFrame", contentHolder)
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 1000)
    scroll.ScrollBarThickness = 6
    scroll.BackgroundTransparency = 1
    scroll.Visible = false
    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0, 10)
    tabs[name] = scroll
    return scroll
end

local function createTabBtn(label, tabName, position)
    local btn = Instance.new("TextButton", tabBar)
    btn.Size = UDim2.new(0.33, -5, 1, 0)
    btn.Position = UDim2.new(position, 5 * position, 0, 0)
    btn.Text = label
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.TextColor3 = selectedTheme.text
    btn.BackgroundColor3 = selectedTheme.btn
    btn.MouseButton1Click:Connect(function() switchTab(tabName) end)
end

-- Theme Picker UI
local themeFrame = Instance.new("Frame", screenGui)
themeFrame.Size = UDim2.new(0, 250, 0, 200)
themeFrame.Position = UDim2.new(0.5, -125, 0.5, -100)
themeFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
themeFrame.BorderSizePixel = 0

local themeLabel = Instance.new("TextLabel", themeFrame)
themeLabel.Size = UDim2.new(1, 0, 0, 40)
themeLabel.Text = "Choose Theme"
themeLabel.Font = Enum.Font.GothamBold
themeLabel.TextScaled = true
themeLabel.TextColor3 = Color3.new(1, 1, 1)
themeLabel.BackgroundTransparency = 1

local function createThemeBtn(text, posY, themeKey)
    local btn = Instance.new("TextButton", themeFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = themes[themeKey].btn
    btn.MouseButton1Click:Connect(function()
        selectedTheme = themes[themeKey]
        wrapper.BackgroundColor3 = selectedTheme.bg
        toggleBtn.BackgroundColor3 = selectedTheme.btn
        toggleBtn.Visible = true
        wrapper.Visible = true
        themeFrame:Destroy()
        switchTab("Home")
    end)
end

createThemeBtn("Dark", 50, "Dark")
createThemeBtn("Blue", 100, "Blue")
createThemeBtn("Red", 150, "Red")

toggleBtn.MouseButton1Click:Connect(function()
    wrapper.Visible = not wrapper.Visible
end)
-- Create Section Helper
local function createButton(parent, text, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 0)
    btn.Text = text
    btn.Font = Enum.Font.GothamSemibold
    btn.TextScaled = true
    btn.TextColor3 = selectedTheme.text
    btn.BackgroundColor3 = selectedTheme.btn
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Tabs
createTabBtn("Home", "Home", 0)
createTabBtn("Script Executor", "Executor", 0.33)
createTabBtn("Fe / Non Fe Scripts", "Scripts", 0.66)

-- HOME TAB
local homeTab = createTabPage("Home")
createButton(homeTab, "Launch GhostHub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub"))()
end)

createButton(homeTab, "Launch Tiger X", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/TigerXOfficial/Main/main/TigerXLoader.lua"))()
end)

createButton(homeTab, "Launch G14", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/G14Hub/G14/main/G14Loader.lua"))()
end)

-- EXECUTOR TAB
local execTab = createTabPage("Executor")

local label = Instance.new("TextLabel", execTab)
label.Size = UDim2.new(1, -20, 0, 25)
label.Position = UDim2.new(0, 10, 0, 0)
label.Text = "Execute Custom Script:"
label.Font = Enum.Font.Gotham
label.TextScaled = true
label.TextColor3 = selectedTheme.text
label.BackgroundTransparency = 1

local box = Instance.new("TextBox", execTab)
box.Size = UDim2.new(1, -20, 0, 100)
box.Position = UDim2.new(0, 10, 0, 30)
box.Text = "-- enter code here"
box.Font = Enum.Font.Code
box.TextSize = 14
box.TextColor3 = selectedTheme.text
box.BackgroundColor3 = selectedTheme.btn
box.ClearTextOnFocus = false
box.MultiLine = true
box.TextWrapped = true
box.TextXAlignment = Enum.TextXAlignment.Left
box.TextYAlignment = Enum.TextYAlignment.Top

createButton(execTab, "Execute", function()
    local success, result = pcall(function()
        loadstring(box.Text)()
    end)
    if not success then
        warn("Execution failed:", result)
    end
end)

-- SCRIPTS TAB (Fe / Non Fe)
local scriptTab = createTabPage("Scripts")

createButton(scriptTab, "Fly GUI V3", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/1f0yt/community/main/FlyGuiV3.lua"))()
end)

createButton(scriptTab, "Red Laser Gun Gear", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/FM0tbkMA"))()
end)
