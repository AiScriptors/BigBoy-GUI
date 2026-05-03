local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("BigBoyGUI") then playerGui.BigBoyGUI:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BigBoyGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

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

local tabs = {"Aimbot", "Weapon", "Player", "ESP", "Colors", "World", "Binds"}
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

createSimpleTabWithToggles("Weapon", {"No Recoil", "Infinite Ammo", "Fast Reload"})
createSimpleTabWithToggles("Player", {"Speed Hack", "Infinite Jump", "God Mode"})
createSimpleTabWithToggles("Colors", {"Rainbow ESP", "Team Color"})
createSimpleTabWithToggles("World", {"Full Bright", "No Fog"})

-- ==================== ESP TAB ====================
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
espHeader.Text = "ESP - Separate Features"
espHeader.TextColor3 = Color3.fromRGB(0, 210, 255)
espHeader.TextSize = 14
espHeader.Font = Enum.Font.GothamSemibold
espHeader.Parent = espCol
Instance.new("UICorner", espHeader).CornerRadius = UDim.new(0, 10)

local function createNiceToggle(parent, text, yPos)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 28)
    row.Position = UDim2.new(0, 0, 0, yPos)
    row.BackgroundTransparency = 1
    row.Parent = parent
    
    local box = Instance.new("TextButton")
    box.Size = UDim2.new(0, 18, 0, 18)
    box.Position = UDim2.new(0, 10, 0, 5)
    box.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
    box.Text = ""
    box.TextColor3 = Color3.new(1,1,1)
    box.TextSize = 13
    box.Font = Enum.Font.GothamBold
    box.Parent = row
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -35, 1, 0)
    label.Position = UDim2.new(0, 35, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(230, 230, 240)
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row
    
    return box
end

local boxesToggle = createNiceToggle(espCol, "Boxes", 32)
local tracersToggle = createNiceToggle(espCol, "Tracers", 60)
local namesToggle = createNiceToggle(espCol, "Names + Distance", 88)
local healthToggle = createNiceToggle(espCol, "Health Bar", 116)
local skeletonToggle = createNiceToggle(espCol, "Skeleton", 144)
local lookToggle = createNiceToggle(espCol, "Look Direction", 172)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 22)
status.Position = UDim2.new(0, 0, 1, -24)
status.BackgroundTransparency = 1
status.Text = "ESP Disabled"
status.TextColor3 = Color3.fromRGB(255, 100, 100)
status.TextSize = 11
status.Font = Enum.Font.Gotham
status.Parent = espCol

local espEnabled = false
local espConnection = nil
local drawings = {}

local function createESP(p)
    if p == player or drawings[p] then return end
    local d = {}
    d.box = Drawing.new("Square")
    d.box.Thickness = 2
    d.box.Filled = false
    
    d.tracer = Drawing.new("Line")
    d.tracer.Thickness = 1.8
    
    d.name = Drawing.new("Text")
    d.name.Size = 13
    d.name.Center = true
    d.name.Outline = true
    
    d.healthBg = Drawing.new("Square")
    d.healthBg.Thickness = 0
    d.healthBg.Filled = true
    d.healthBg.Color = Color3.fromRGB(40, 40, 40)
    
    d.health = Drawing.new("Square")
    d.health.Thickness = 0
    d.health.Filled = true
    
    d.skeleton = {}
    for i = 1, 6 do
        d.skeleton[i] = Drawing.new("Line")
        d.skeleton[i].Thickness = 1.6
    end
    
    d.look = Drawing.new("Line")
    d.look.Thickness = 2.2
    d.look.Color = Color3.fromRGB(100, 200, 255)
    
    drawings[p] = d
end

local function removeESP(p)
    if not drawings[p] then return end
    for _, v in pairs(drawings[p]) do
        if type(v) == "table" then
            for _, s in pairs(v) do s:Remove() end
        else
            v:Remove()
        end
    end
    drawings[p] = nil
end

local function updateESP()
    if not espEnabled then return end
    local cam = workspace.CurrentCamera
    
    for p, d in pairs(drawings) do
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            local hum = p.Character:FindFirstChild("Humanoid")
            local pos, visible = cam:WorldToViewportPoint(hrp.Position)
            local dist = (cam.CFrame.Position - hrp.Position).Magnitude
            
            if visible and dist < 1400 then
                local size = math.clamp(2700 / dist, 44, 115)
                local hp = hum and math.clamp(hum.Health / hum.MaxHealth, 0, 1) or 1
                local boxColor = Color3.fromRGB(0, 255, 120)
                if hp < 0.6 then boxColor = Color3.fromRGB(255, 200, 50) end
                if hp < 0.3 then boxColor = Color3.fromRGB(255, 80, 80) end
                
                if boxesToggle.BackgroundColor3 == Color3.fromRGB(0, 220, 120) then
                    d.box.Size = Vector2.new(size, size * 1.75)
                    d.box.Position = Vector2.new(pos.X - size/2, pos.Y - size * 0.88)
                    d.box.Color = boxColor
                    d.box.Visible = true
                else d.box.Visible = false end
                
                if tracersToggle.BackgroundColor3 == Color3.fromRGB(0, 220, 120) then
                    d.tracer.From = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y)
                    d.tracer.To = Vector2.new(pos.X, pos.Y)
                    d.tracer.Color = boxColor
                    d.tracer.Visible = true
                else d.tracer.Visible = false end
                
                if namesToggle.BackgroundColor3 == Color3.fromRGB(0, 220, 120) then
                    d.name.Text = p.Name .. " [" .. math.floor(dist) .. "m]"
                    d.name.Position = Vector2.new(pos.X, pos.Y - size * 0.92 - 15)
                    d.name.Visible = true
                else d.name.Visible = false end
                
                if healthToggle.BackgroundColor3 == Color3.fromRGB(0, 220, 120) then
                    local barH = size * 1.5
                    d.healthBg.Size = Vector2.new(4, barH)
                    d.healthBg.Position = Vector2.new(pos.X + size/2 + 7, pos.Y - size * 0.75)
                    d.healthBg.Visible = true
                    
                    d.health.Size = Vector2.new(4, barH * hp)
                    d.health.Position = Vector2.new(pos.X + size/2 + 7, pos.Y - size * 0.75 + barH * (1 - hp))
                    d.health.Color = Color3.fromRGB(255 * (1 - hp), 255 * hp, 40)
                    d.health.Visible = true
                else
                    d.healthBg.Visible = false
                    d.health.Visible = false
                end
                
                if skeletonToggle.BackgroundColor3 == Color3.fromRGB(0, 220, 120) and p.Character then
                    local head = p.Character:FindFirstChild("Head")
                    local torso = p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("Torso")
                    if head and torso then
                        local h = cam:WorldToViewportPoint(head.Position)
                        local t = cam:WorldToViewportPoint(torso.Position)
                        d.skeleton[1].From = Vector2.new(h.X, h.Y)
                        d.skeleton[1].To = Vector2.new(t.X, t.Y)
                        d.skeleton[1].Visible = true
                        
                        local larm = p.Character:FindFirstChild("LeftUpperArm") or p.Character:FindFirstChild("Left Arm")
                        local rarm = p.Character:FindFirstChild("RightUpperArm") or p.Character:FindFirstChild("Right Arm")
                        if larm then
                            local la = cam:WorldToViewportPoint(larm.Position)
                            d.skeleton[2].From = Vector2.new(t.X, t.Y)
                            d.skeleton[2].To = Vector2.new(la.X, la.Y)
                            d.skeleton[2].Visible = true
                        end
                        if rarm then
                            local ra = cam:WorldToViewportPoint(rarm.Position)
                            d.skeleton[3].From = Vector2.new(t.X, t.Y)
                            d.skeleton[3].To = Vector2.new(ra.X, ra.Y)
                            d.skeleton[3].Visible = true
                        end
                    end
                else
                    for _, s in pairs(d.skeleton) do s.Visible = false end
                end
                
                if lookToggle.BackgroundColor3 == Color3.fromRGB(0, 220, 120) then
                    local lookPos = hrp.Position + hrp.CFrame.LookVector * 7
                    local lookScreen = cam:WorldToViewportPoint(lookPos)
                    d.look.From = Vector2.new(pos.X, pos.Y)
                    d.look.To = Vector2.new(lookScreen.X, lookScreen.Y)
                    d.look.Visible = true
                else d.look.Visible = false end
                
            else
                for _, v in pairs(d) do
                    if type(v) == "table" then for _, s in pairs(v) do s.Visible = false end
                    else v.Visible = false end
                end
            end
        end
    end
end

local function toggle(box)
    if box.BackgroundColor3 == Color3.fromRGB(0, 220, 120) then
        box.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
        box.Text = ""
    else
        box.BackgroundColor3 = Color3.fromRGB(0, 220, 120)
        box.Text = "✓"
    end
end

boxesToggle.MouseButton1Click:Connect(function() toggle(boxesToggle) end)
tracersToggle.MouseButton1Click:Connect(function() toggle(tracersToggle) end)
namesToggle.MouseButton1Click:Connect(function() toggle(namesToggle) end)
healthToggle.MouseButton1Click:Connect(function() toggle(healthToggle) end)
skeletonToggle.MouseButton1Click:Connect(function() toggle(skeletonToggle) end)
lookToggle.MouseButton1Click:Connect(function() toggle(lookToggle) end)

local espBox = createCheckbox(espCol, "Enable ESP (Master)", 200, false)
espBox[2].MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        espBox[2].BackgroundColor3 = Color3.fromRGB(0, 220, 120)
        espBox[2].Text = "✓"
        status.Text = "ESP Active"
        status.TextColor3 = Color3.fromRGB(100, 255, 160)
        if not espConnection then
            espConnection = RunService.RenderStepped:Connect(updateESP)
        end
    else
        espBox[2].BackgroundColor3 = Color3.fromRGB(55, 58, 70)
        espBox[2].Text = ""
        status.Text = "ESP Disabled"
        status.TextColor3 = Color3.fromRGB(255, 100, 100)
        if espConnection then espConnection:Disconnect() espConnection = nil end
        for _, d in pairs(drawings) do
            for _, v in pairs(d) do
                if type(v) == "table" then for _, s in pairs(v) do s:Remove() end
                else v:Remove() end
            end
        end
        drawings = {}
    end
end)

local fl = Instance.new("TextButton", screenGui)
fl.Size = UDim2.new(0, 52, 0, 52)
fl.Position = UDim2.new(1, -68, 1, -68)
fl.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
fl.Text = "BB"
fl.TextColor3 = Color3.new(1,1,1)
fl.TextSize = 22
fl.Font = Enum.Font.GothamBlack
fl.Visible = false
Instance.new("UICorner", fl).CornerRadius = UDim.new(1, 0)

fl.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    fl.Visible = false
end)

minBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    fl.Visible = true
end)

closeBtn.MouseButton1Click:Connect(function()
    if espConnection then espConnection:Disconnect() end
    screenGui:Destroy()
end)

print("✅ BIGBOY GUI v2.1 loaded!")
