--[[
╔════════════════════════════════════════════════════════════╗
║                    BIGBOY GUI v1.6                         ║
║           Powerful Roblox Mobile Executor Menu             ║
║                                                            ║
║  Features:                                                 ║
║  • Strong ESP with Tracers, Boxes, Names + Distance        ║
║  • Minimize to floating circle button (▽)                  ║
║  • 7 beautiful tabs                                        ║
║  • Modern UI with gradients & strokes                      ║
║                                                            ║
║  Compatible with Delta Mobile and most executors           ║
╚════════════════════════════════════════════════════════════╝
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("BigBoyGUI") then
    playerGui.BigBoyGUI:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BigBoyGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 620, 0, 385)
mainFrame.Position = UDim2.new(0.5, -310, 0.5, -192)
mainFrame.BackgroundColor3 = Color3.fromRGB(28, 30, 40)
mainFrame.BackgroundTransparency = 0.08
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(70, 72, 85)
mainStroke.Thickness = 1.5
mainStroke.Transparency = 0.5
mainStroke.Parent = mainFrame

-- Floating Circle Button
local floatBtn = Instance.new("TextButton")
floatBtn.Name = "FloatButton"
floatBtn.Size = UDim2.new(0, 56, 0, 56)
floatBtn.Position = UDim2.new(1, -74, 1, -74)
floatBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
floatBtn.Text = "BB"
floatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
floatBtn.TextSize = 24
floatBtn.Font = Enum.Font.GothamBlack
floatBtn.Visible = false
floatBtn.Parent = screenGui

local floatCorner = Instance.new("UICorner")
floatCorner.CornerRadius = UDim.new(1, 0)
floatCorner.Parent = floatBtn

local floatStroke = Instance.new("UIStroke")
floatStroke.Color = Color3.fromRGB(255, 255, 255)
floatStroke.Thickness = 4
floatStroke.Transparency = 0.2
floatStroke.Parent = floatBtn

-- Top Bar
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 46)
topBar.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 14)
topCorner.Parent = topBar

local topGradient = Instance.new("UIGradient")
topGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 22, 30)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(26, 28, 38)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 22, 30))
}
topGradient.Parent = topBar

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(0, 140, 1, 0)
logo.Position = UDim2.new(0, 14, 0, 0)
logo.BackgroundTransparency = 1
logo.Text = "BIGBOY GUI"
logo.TextColor3 = Color3.fromRGB(0, 215, 255)
logo.TextSize = 21
logo.Font = Enum.Font.GothamBlack
logo.TextXAlignment = Enum.TextXAlignment.Left
logo.Parent = topBar

-- Tabs
local tabScroll = Instance.new("ScrollingFrame")
tabScroll.Size = UDim2.new(1, -205, 1, 0)
tabScroll.Position = UDim2.new(0, 150, 0, 0)
tabScroll.BackgroundTransparency = 1
tabScroll.ScrollBarThickness = 2
tabScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
tabScroll.ScrollingDirection = Enum.ScrollingDirection.X
tabScroll.CanvasSize = UDim2.new(0, 620, 0, 0)
tabScroll.Parent = topBar

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 6)
tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
tabLayout.Parent = tabScroll

local tabs = {"Aimbot", "Оружие", "Игрок", "ESP", "Цвета", "Мир", "Бинды"}
local tabButtons = {}
local contents = {}
local currentTab = "Aimbot"

local function createTabButton(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 76, 0, 32)
    btn.BackgroundColor3 = (name == "Aimbot") and Color3.fromRGB(48, 51, 62) or Color3.fromRGB(36, 38, 48)
    btn.Text = name
    btn.TextColor3 = (name == "Aimbot") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(195, 195, 205)
    btn.TextSize = 11.5
    btn.Font = Enum.Font.GothamSemibold
    btn.AutoButtonColor = false
    btn.Parent = tabScroll
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = btn
    
    local underline = Instance.new("Frame")
    underline.Size = UDim2.new(1, 0, 0, 3)
    underline.Position = UDim2.new(0, 0, 1, -3)
    underline.BackgroundColor3 = Color3.fromRGB(0, 215, 255)
    underline.BorderSizePixel = 0
    underline.Visible = (name == "Aimbot")
    underline.Parent = btn
    
    btn.MouseButton1Down:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.08), {Size = UDim2.new(0, 72, 0, 30)}):Play()
    end)
    btn.MouseButton1Up:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.08), {Size = UDim2.new(0, 76, 0, 32)}):Play()
    end)
    
    btn.MouseButton1Click:Connect(function()
        for _, b in pairs(tabButtons) do
            b.BackgroundColor3 = Color3.fromRGB(36, 38, 48)
            b.TextColor3 = Color3.fromRGB(195, 195, 205)
            for _, child in pairs(b:GetChildren()) do
                if child:IsA("Frame") and child.Name ~= "UICorner" then child.Visible = false end
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(48, 51, 62)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        underline.Visible = true
        
        for tabName, frame in pairs(contents) do frame.Visible = (tabName == name) end
        currentTab = name
    end)
    return btn
end

for _, tabName in ipairs(tabs) do
    tabButtons[tabName] = createTabButton(tabName)
end
tabScroll.CanvasSize = UDim2.new(0, (#tabs * 82) + 15, 0, 0)

-- Buttons
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 34, 0, 34)
closeBtn.Position = UDim2.new(1, -40, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(215, 60, 60)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = topBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 34, 0, 34)
minBtn.Position = UDim2.new(1, -78, 0, 6)
minBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 230)
minBtn.Text = "▽"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.TextSize = 18
minBtn.Font = Enum.Font.GothamBold
minBtn.Parent = topBar
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 8)

-- Content Area
local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -16, 1, -58)
contentArea.Position = UDim2.new(0, 8, 0, 52)
contentArea.BackgroundTransparency = 1
contentArea.Parent = mainFrame

local function createCheckbox(parent, text, yPos, default)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 30)
    row.Position = UDim2.new(0, 0, 0, yPos)
    row.BackgroundTransparency = 1
    row.Parent = parent
    
    local box = Instance.new("TextButton")
    box.Size = UDim2.new(0, 20, 0, 20)
    box.Position = UDim2.new(0, 10, 0, 5)
    box.BackgroundColor3 = default and Color3.fromRGB(0, 220, 120) or Color3.fromRGB(55, 58, 70)
    box.Text = default and "✓" or ""
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.TextSize = 15
    box.Font = Enum.Font.GothamBold
    box.AutoButtonColor = false
    box.Parent = row
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)
    
    local boxStroke = Instance.new("UIStroke")
    boxStroke.Color = Color3.fromRGB(130, 132, 145)
    boxStroke.Thickness = 1.6
    boxStroke.Transparency = default and 0.3 or 0
    boxStroke.Parent = box
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -42, 1, 0)
    label.Position = UDim2.new(0, 38, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(232, 232, 242)
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row
    
    local state = default
    box.MouseButton1Click:Connect(function()
        state = not state
        if state then
            box.BackgroundColor3 = Color3.fromRGB(0, 220, 120)
            box.Text = "✓"
            boxStroke.Transparency = 0.3
        else
            box.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
            box.Text = ""
            boxStroke.Transparency = 0
        end
    end)
    return row, box
end

-- AIMBOT Tab
local aimbotContent = Instance.new("Frame")
aimbotContent.Size = UDim2.new(1, 0, 1, 0)
aimbotContent.BackgroundTransparency = 1
aimbotContent.Visible = true
aimbotContent.Parent = contentArea
contents["Aimbot"] = aimbotContent

local leftCol = Instance.new("Frame")
leftCol.Size = UDim2.new(0.32, 0, 1, 0)
leftCol.BackgroundColor3 = Color3.fromRGB(40, 42, 52)
leftCol.Parent = aimbotContent
Instance.new("UICorner", leftCol).CornerRadius = UDim.new(0, 9)
Instance.new("UIStroke", leftCol).Color = Color3.fromRGB(65, 67, 78)

local genHeader = Instance.new("TextLabel")
genHeader.Size = UDim2.new(1, 0, 0, 28)
genHeader.BackgroundColor3 = Color3.fromRGB(30, 32, 41)
genHeader.Text = "General"
genHeader.TextColor3 = Color3.fromRGB(205, 205, 215)
genHeader.TextSize = 13
genHeader.Font = Enum.Font.GothamSemibold
genHeader.Parent = leftCol
Instance.new("UICorner", genHeader).CornerRadius = UDim.new(0, 9)

createCheckbox(leftCol, "Ignore Friends", 34, false)
createCheckbox(leftCol, "Ignore Clan", 66, false)

local distHeader = Instance.new("TextLabel")
distHeader.Size = UDim2.new(1, 0, 0, 28)
distHeader.Position = UDim2.new(0, 0, 0, 105)
distHeader.BackgroundColor3 = Color3.fromRGB(30, 32, 41)
distHeader.Text = "Distance"
distHeader.TextColor3 = Color3.fromRGB(205, 205, 215)
distHeader.TextSize = 13
distHeader.Font = Enum.Font.GothamSemibold
distHeader.Parent = leftCol
Instance.new("UICorner", distHeader).CornerRadius = UDim.new(0, 9)

local distLabel = Instance.new("TextLabel")
distLabel.Size = UDim2.new(1, -16, 0, 26)
distLabel.Position = UDim2.new(0, 10, 0, 138)
distLabel.BackgroundTransparency = 1
distLabel.Text = "Max Distance: 1500 studs"
distLabel.TextColor3 = Color3.fromRGB(185, 185, 195)
distLabel.TextSize = 12
distLabel.Font = Enum.Font.Gotham
distLabel.Parent = leftCol

local midCol = Instance.new("Frame")
midCol.Size = UDim2.new(0.32, 0, 1, 0)
midCol.Position = UDim2.new(0.34, 0, 0, 0)
midCol.BackgroundColor3 = Color3.fromRGB(40, 42, 52)
midCol.Parent = aimbotContent
Instance.new("UICorner", midCol).CornerRadius = UDim.new(0, 9)
Instance.new("UIStroke", midCol).Color = Color3.fromRGB(65, 67, 78)

local aimHeader = Instance.new("TextLabel")
aimHeader.Size = UDim2.new(1, 0, 0, 28)
aimHeader.BackgroundColor3 = Color3.fromRGB(30, 32, 41)
aimHeader.Text = "Aimbot"
aimHeader.TextColor3 = Color3.fromRGB(205, 205, 215)
aimHeader.TextSize = 13
aimHeader.Font = Enum.Font.GothamSemibold
aimHeader.Parent = midCol
Instance.new("UICorner", aimHeader).CornerRadius = UDim.new(0, 9)

createCheckbox(midCol, "Enable Aimbot", 34, false)

local rightCol = Instance.new("Frame")
rightCol.Size = UDim2.new(0.32, 0, 1, 0)
rightCol.Position = UDim2.new(0.68, 0, 0, 0)
rightCol.BackgroundColor3 = Color3.fromRGB(40, 42, 52)
rightCol.Parent = aimbotContent
Instance.new("UICorner", rightCol).CornerRadius = UDim.new(0, 9)
Instance.new("UIStroke", rightCol).Color = Color3.fromRGB(65, 67, 78)

local fovHeader = Instance.new("TextLabel")
fovHeader.Size = UDim2.new(1, 0, 0, 28)
fovHeader.BackgroundColor3 = Color3.fromRGB(30, 32, 41)
fovHeader.Text = "FOV Settings"
fovHeader.TextColor3 = Color3.fromRGB(205, 205, 215)
fovHeader.TextSize = 13
fovHeader.Font = Enum.Font.GothamSemibold
fovHeader.Parent = rightCol
Instance.new("UICorner", fovHeader).CornerRadius = UDim.new(0, 9)

local fovLabel = Instance.new("TextLabel")
fovLabel.Size = UDim2.new(1, -16, 0, 26)
fovLabel.Position = UDim2.new(0, 10, 0, 38)
fovLabel.BackgroundTransparency = 1
fovLabel.Text = "FOV: 120°"
fovLabel.TextColor3 = Color3.fromRGB(185, 185, 195)
fovLabel.TextSize = 12
fovLabel.Font = Enum.Font.Gotham
fovLabel.Parent = rightCol

-- Other Tabs
local function createSimpleTabWithToggles(name, toggles)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    frame.Parent = contentArea
    contents[name] = frame
    
    local col = Instance.new("Frame")
    col.Size = UDim2.new(0.95, 0, 0.9, 0)
    col.Position = UDim2.new(0.025, 0, 0.05, 0)
    col.BackgroundColor3 = Color3.fromRGB(40, 42, 52)
    col.Parent = frame
    Instance.new("UICorner", col).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", col).Color = Color3.fromRGB(65, 67, 78)
    
    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, 0, 0, 30)
    header.BackgroundColor3 = Color3.fromRGB(30, 32, 41)
    header.Text = name
    header.TextColor3 = Color3.fromRGB(205, 205, 215)
    header.TextSize = 14
    header.Font = Enum.Font.GothamSemibold
    header.Parent = col
    Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)
    
    local y = 38
    for _, t in ipairs(toggles) do
        createCheckbox(col, t, y, false)
        y = y + 32
    end
end

createSimpleTabWithToggles("Оружие", {"No Recoil", "Infinite Ammo", "Fast Reload"})
createSimpleTabWithToggles("Игрок", {"Speed Hack", "Infinite Jump", "God Mode"})
createSimpleTabWithToggles("Цвета", {"Rainbow ESP", "Team Color"})
createSimpleTabWithToggles("Мир", {"Full Bright", "No Fog"})

-- ESP Tab with Real Functionality
local espContent = Instance.new("Frame")
espContent.Size = UDim2.new(1, 0, 1, 0)
espContent.BackgroundTransparency = 1
espContent.Visible = false
espContent.Parent = contentArea
contents["ESP"] = espContent

local espCol = Instance.new("Frame")
espCol.Size = UDim2.new(0.95, 0, 0.9, 0)
espCol.Position = UDim2.new(0.025, 0, 0.05, 0)
espCol.BackgroundColor3 = Color3.fromRGB(40, 42, 52)
espCol.Parent = espContent
Instance.new("UICorner", espCol).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", espCol).Color = Color3.fromRGB(65, 67, 78)

local espHeader = Instance.new("TextLabel")
espHeader.Size = UDim2.new(1, 0, 0, 30)
espHeader.BackgroundColor3 = Color3.fromRGB(30, 32, 41)
espHeader.Text = "ESP"
espHeader.TextColor3 = Color3.fromRGB(205, 205, 215)
espHeader.TextSize = 14
espHeader.Font = Enum.Font.GothamSemibold
espHeader.Parent = espCol
Instance.new("UICorner", espHeader).CornerRadius = UDim.new(0, 10)

-- REAL ESP SYSTEM
local espEnabled = false
local espConnection = nil
local espDrawings = {}

local function createESP(p)
    if p == player or espDrawings[p] then return end
    local drawings = {}
    drawings.box = Drawing.new("Square")
    drawings.box.Thickness = 1.8
    drawings.box.Filled = false
    drawings.box.Color = Color3.fromRGB(0, 255, 120)
    
    drawings.tracer = Drawing.new("Line")
    drawings.tracer.Thickness = 1.8
    drawings.tracer.Color = Color3.fromRGB(255, 220, 0)
    
    drawings.name = Drawing.new("Text")
    drawings.name.Size = 14
    drawings.name.Center = true
    drawings.name.Outline = true
    drawings.name.Color = Color3.fromRGB(255, 255, 255)
    
    espDrawings[p] = drawings
end

local function removeESP(p)
    if not espDrawings[p] then return end
    for _, d in pairs(espDrawings[p]) do d:Remove() end
    espDrawings[p] = nil
end

local function updateESP()
    if not espEnabled then return end
    local camera = workspace.CurrentCamera
    local viewport = camera.ViewportSize
    for p, drawings in pairs(espDrawings) do
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            local pos, onScreen = camera:WorldToViewportPoint(hrp.Position)
            local distance = (camera.CFrame.Position - hrp.Position).Magnitude
            if onScreen and distance < 1500 then
                local size = math.clamp(2800 / distance, 45, 130)
                drawings.box.Size = Vector2.new(size, size * 1.85)
                drawings.box.Position = Vector2.new(pos.X - size/2, pos.Y - size * 0.92)
                drawings.box.Visible = true
                drawings.tracer.From = Vector2.new(viewport.X / 2, viewport.Y)
                drawings.tracer.To = Vector2.new(pos.X, pos.Y)
                drawings.tracer.Visible = true
                drawings.name.Text = p.Name .. " [" .. math.floor(distance) .. "m]"
                drawings.name.Position = Vector2.new(pos.X, pos.Y - size * 0.92 - 18)
                drawings.name.Visible = true
            else
                drawings.box.Visible = false
                drawings.tracer.Visible = false
                drawings.name.Visible = false
            end
        else
            drawings.box.Visible = false
            drawings.tracer.Visible = false
            drawings.name.Visible = false
        end
    end
end

local espRow, espBox = createCheckbox(espCol, "Enable ESP (Tracers + Boxes + Names)", 38, false)

espBox.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        espBox.BackgroundColor3 = Color3.fromRGB(0, 220, 120)
        espBox.Text = "✓"
        for _, p in pairs(Players:GetPlayers()) do createESP(p) end
        if not espConnection then
            espConnection = RunService.RenderStepped:Connect(updateESP)
        end
        print("[BIGBOY] ESP ENABLED - Tracers + Boxes + Names active")
    else
        espBox.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
        espBox.Text = ""
        if espConnection then espConnection:Disconnect() espConnection = nil end
        for _, drawings in pairs(espDrawings) do for _, d in pairs(drawings) do d:Remove() end end
        espDrawings = {}
        print("[BIGBOY] ESP DISABLED")
    end
end)

Players.PlayerAdded:Connect(function(p)
    if espEnabled then createESP(p) end
end)
Players.PlayerRemoving:Connect(removeESP)

-- Binds Tab
local bindsContent = Instance.new("Frame")
bindsContent.Size = UDim2.new(1, 0, 1, 0)
bindsContent.BackgroundTransparency = 1
bindsContent.Visible = false
bindsContent.Parent = contentArea
contents["Бинды"] = bindsContent

local bindsCol = Instance.new("Frame")
bindsCol.Size = UDim2.new(0.95, 0, 0.9, 0)
bindsCol.Position = UDim2.new(0.025, 0, 0.05, 0)
bindsCol.BackgroundColor3 = Color3.fromRGB(40, 42, 52)
bindsCol.Parent = bindsContent
Instance.new("UICorner", bindsCol).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", bindsCol).Color = Color3.fromRGB(65, 67, 78)

local bindsHeader = Instance.new("TextLabel")
bindsHeader.Size = UDim2.new(1, 0, 0, 30)
bindsHeader.BackgroundColor3 = Color3.fromRGB(30, 32, 41)
bindsHeader.Text = "Бинды"
bindsHeader.TextColor3 = Color3.fromRGB(205, 205, 215)
bindsHeader.TextSize = 14
bindsHeader.Font = Enum.Font.GothamSemibold
bindsHeader.Parent = bindsCol
Instance.new("UICorner", bindsHeader).CornerRadius = UDim.new(0, 10)

local bindsList = {"Aimbot — Mouse1", "Speed — F", "Jump — Space", "ESP — Insert", "God — G"}
for i, b in ipairs(bindsList) do
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -20, 0, 24)
    lbl.Position = UDim2.new(0, 12, 0, 36 + (i-1)*26)
    lbl.BackgroundTransparency = 1
    lbl.Text = b
    lbl.TextColor3 = Color3.fromRGB(200, 200, 210)
    lbl.TextSize = 12.5
    lbl.Font = Enum.Font.Gotham
    lbl.Parent = bindsCol
end

-- Version
local version = Instance.new("TextLabel")
version.Size = UDim2.new(1, 0, 0, 18)
version.Position = UDim2.new(0, 0, 1, -20)
version.BackgroundTransparency = 1
version.Text = "BIGBOY GUI v1.6 | Mobile Edition + Strong ESP"
version.TextColor3 = Color3.fromRGB(115, 115, 125)
version.TextSize = 10
version.Font = Enum.Font.Gotham
version.Parent = mainFrame

-- Button Connections
closeBtn.MouseButton1Click:Connect(function()
    print("[BIGBOY] Menu closed")
    screenGui:Destroy()
end)

minBtn.MouseButton1Click:Connect(function()
    print("[BIGBOY] Minimized to circle")
    mainFrame.Visible = false
    floatBtn.Visible = true
end)

floatBtn.MouseButton1Click:Connect(function()
    print("[BIGBOY] Circle clicked - menu opened")
    mainFrame.Visible = true
    floatBtn.Visible = false
end)

print("✅ BIGBOY GUI v1.6 loaded successfully!")
print("• Press ▽ to minimize to floating circle")
print("• Enable ESP in the ESP tab for tracers + boxes + names")
```