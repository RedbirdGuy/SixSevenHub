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
    tabBar.Size = UDim2.new(1, 0, 0, 35)
    tabBar.Position = UDim2.new(0, 0, 0, 40)
    tabBar.BackgroundTransparency = 1

    contentHolder = Instance.new("Frame", wrapper)
    contentHolder.Size = UDim2.new(1, 0, 1, -75)
    contentHolder.Position = UDim2.new(0, 0, 0, 75)
    contentHolder.BackgroundTransparency = 1

    toggleBtn = Instance.new("TextButton", screenGui)
    toggleBtn.Size = UDim2.new(0, 100, 0, 40)
    toggleBtn.Position = UDim2.new(0, 10, 0.5, -20)
    toggleBtn.Text = "Toggle UI"
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextColor3 = theme.text
    toggleBtn.BackgroundColor3 = theme.btn
    toggleBtn.MouseButton1Click:Connect(function()
        wrapper.Visible = not wrapper.Visible
    end)

    local function createTabBtn(text, name, pos)
        local b = Instance.new("TextButton", tabBar)
        b.Size = UDim2.new(0.33, -5, 1, 0)
        b.Position = UDim2.new(pos, 5 * pos, 0, 0)
        b.Text = text
        b.Font = Enum.Font.GothamBold
        b.TextScaled = true
        b.TextColor3 = theme.text
        b.BackgroundColor3 = theme.btn
        b.MouseButton1Click:Connect(function()
            for t, frame in pairs(tabs) do frame.Visible = (t == name) end
        end)
    end

    createTabBtn("Home", "Home", 0)
    createTabBtn("Script Executor", "Executor", 0.33)
    createTabBtn("Fe / Non Fe Scripts", "Scripts", 0.66)

    local homeTab = createTabPage("Home")
    local execTab = createTabPage("Executor")
    local scriptTab = createTabPage("Scripts")

    homeTab.Parent = contentHolder
    execTab.Parent = contentHolder
    scriptTab.Parent = contentHolder

    -- HOME BUTTONS
    createButton(homeTab, "GhostHub", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub"))()
    end)

    createButton(homeTab, "Tiger X", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BalintTheDevXBack/Universal/refs/heads/main/TigerXHubV4"))()
    end)

    createButton(homeTab, "Rc7 Hub", function()
        --[[
            WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
        ]]
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CoreGui/Scripts/main/RC7"))()
    end)

    createButton(homeTab, "Infinite Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

    createButton(homeTab, "FE Ultimate Trolling GUI", function()
    loadstring(game:HttpGet("https://gist.githubusercontent.com/dark-modz/3e50ce0fdd03713dfbeb1845ee6f52d7/raw/630318908f56a984db9568a89e33eadb7998158a/feutg1", true))()
end)


    -- EXECUTOR
    local label = Instance.new("TextLabel", execTab)
    label.Size = UDim2.new(1, -20, 0, 25)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Text = "Execute Custom Script:"
    label.Font = Enum.Font.Gotham
    label.TextScaled = true
    label.TextColor3 = theme.text
    label.BackgroundTransparency = 1

    local box = Instance.new("TextBox", execTab)
    box.Size = UDim2.new(1, -20, 0, 100)
    box.Position = UDim2.new(0, 10, 0, 30)
    box.Text = "-- enter code here"
    box.Font = Enum.Font.Code
    box.TextSize = 14
    box.TextColor3 = theme.text
    box.BackgroundColor3 = theme.btn
    box.ClearTextOnFocus = false
    box.MultiLine = true
    box.TextWrapped = true
    box.TextXAlignment = Enum.TextXAlignment.Left
    box.TextYAlignment = Enum.TextYAlignment.Top

    createButton(execTab, "Execute", function()
        loadstring(box.Text)()
    end)

    -- SCRIPTS TAB
    createButton(scriptTab, "Fly GUI V3", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
    end)

    createButton(scriptTab, "Get All Gears", function()
        loadstring(game:HttpGet("https://pastebin.com/raw/AZVi2tuK"))()
    end)

    createButton(scriptTab, "AnnaBypasser", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AnnaRoblox/AnnaBypasser/refs/heads/main/AnnaBypasser.lua", true))()
end)

    createButton(scriptTab, "Red Hyperlaser Gun", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Red-hyperlaser-gun-24963"))()
end)



    for n, f in pairs(tabs) do f.Visible = (n == "Home") end
end

-- Theme selector
local selector = Instance.new("Frame", screenGui)
selector.Size = UDim2.new(0, 250, 0, 200)
selector.Position = UDim2.new(0.5, -125, 0.5, -100)
selector.BackgroundColor3 = Color3.fromRGB(30,30,30)

local label = Instance.new("TextLabel", selector)
label.Size = UDim2.new(1, 0, 0, 40)
label.Text = "Choose Theme"
label.Font = Enum.Font.GothamBold
label.TextScaled = true
label.TextColor3 = Color3.new(1,1,1)
label.BackgroundTransparency = 1

for i, name in ipairs({"Dark","Blue","Red"}) do
    local btn = Instance.new("TextButton", selector)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, 40 + (i-1)*50)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = themes[name].btn
    btn.MouseButton1Click:Connect(function()
        selector:Destroy()
        buildGUI(themes[name])
    end)
end
