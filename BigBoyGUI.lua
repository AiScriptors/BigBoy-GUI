local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera

if playerGui:FindFirstChild("BigBoyGUI") then playerGui.BigBoyGUI:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BigBoyGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Menu
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 600, 0, 370)
main.Position = UDim2.new(0.5, -300, 0.5, -185)
main.BackgroundColor3 = Color3.fromRGB(26, 28, 38)
main.BackgroundTransparency = 0.08
main.Active = true
main.Draggable = true
main.Parent = screenGui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)
local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(65, 67, 80)
stroke.Thickness = 1.5

local top = Instance.new("Frame", main)
top.Size = UDim2.new(1, 0, 0, 42)
top.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
Instance.new("UICorner", top).CornerRadius = UDim.new(0, 12)

local grad = Instance.new("UIGradient", top)
grad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 20, 28)), ColorSequenceKeypoint.new(1, Color3.fromRGB(24, 26, 36))}

local logo = Instance.new("TextLabel", top)
logo.Size = UDim2.new(0, 120, 1, 0)
logo.Position = UDim2.new(0, 12, 0, 0)
logo.BackgroundTransparency = 1
logo.Text = "BIGBOY GUI"
logo.TextColor3 = Color3.fromRGB(0, 210, 255)
logo.TextSize = 18
logo.Font = Enum.Font.GothamBlack

local close = Instance.new("TextButton", top)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -34, 0, 6)
close.BackgroundColor3 = Color3.fromRGB(230, 65, 65)
close.Text = "✕"
close.TextColor3 = Color3.new(1,1,1)
close.TextSize = 15
close.Font = Enum.Font.GothamBold
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 6)

local minBtn = Instance.new("TextButton", top)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -68, 0, 6)
minBtn.BackgroundColor3 = Color3.fromRGB(0, 175, 225)
minBtn.Text = "▽"
minBtn.TextColor3 = Color3.new(1,1,1)
minBtn.TextSize = 15
minBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -10, 1, -50)
content.Position = UDim2.new(0, 5, 0, 46)
content.BackgroundTransparency = 1

-- Tabs
local tabContents = {}

local function createTab(name, isActive, xPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 85, 0, 28)
    btn.Position = UDim2.new(0, xPos, 0, 0)
    btn.BackgroundColor3 = isActive and Color3.fromRGB(48, 51, 62) or Color3.fromRGB(36, 38, 48)
    btn.Text = name
    btn.TextColor3 = isActive and Color3.new(1,1,1) or Color3.fromRGB(200, 200, 210)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamSemibold
    btn.Parent = content
    
    local line = Instance.new("Frame", btn)
    line.Size = UDim2.new(1, 0, 0, 2)
    line.Position = UDim2.new(0, 0, 1, -2)
    line.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
    line.Visible = isActive
    
    btn.MouseButton1Click:Connect(function()
        for _, b in pairs(content:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundColor3 = Color3.fromRGB(36, 38, 48)
                b.TextColor3 = Color3.fromRGB(200, 200, 210)
                for _, c in pairs(b:GetChildren()) do if c:IsA("Frame") then c.Visible = false end end
            end
        end
        for _, c in pairs(tabContents) do c.Visible = false end
        btn.BackgroundColor3 = Color3.fromRGB(48, 51, 62)
        btn.TextColor3 = Color3.new(1,1,1)
        line.Visible = true
        tabContents[name].Visible = true
    end)
    return btn
end

-- AIMBOT TAB
local aimTab = Instance.new("Frame", content)
aimTab.Size = UDim2.new(1, 0, 1, 0)
aimTab.BackgroundColor3 = Color3.fromRGB(36, 38, 48)
aimTab.Visible = true
Instance.new("UICorner", aimTab).CornerRadius = UDim.new(0, 8)
tabContents["Aimbot"] = aimTab

createTab("Aimbot", true, 10)

-- Settings
local settings = {
    maxDist = 500,
    fov = 120,
    wallCheck = true,
    silentAim = false,
    aimbot = false
}

-- Silent Aim
local saToggle = Instance.new("TextButton", aimTab)
saToggle.Size = UDim2.new(0, 130, 0, 26)
saToggle.Position = UDim2.new(0, 12, 0, 10)
saToggle.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
saToggle.Text = "Silent Aim"
saToggle.TextColor3 = Color3.new(1,1,1)
saToggle.TextSize = 11
saToggle.Font = Enum.Font.GothamSemibold
Instance.new("UICorner", saToggle).CornerRadius = UDim.new(0, 5)

local saStatus = Instance.new("TextLabel", aimTab)
saStatus.Size = UDim2.new(0, 40, 0, 26)
saStatus.Position = UDim2.new(0, 150, 0, 10)
saStatus.BackgroundTransparency = 1
saStatus.Text = "OFF"
saStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
saStatus.TextSize = 11
saStatus.Font = Enum.Font.GothamBold

-- Aimbot
local abToggle = Instance.new("TextButton", aimTab)
abToggle.Size = UDim2.new(0, 130, 0, 26)
abToggle.Position = UDim2.new(0, 12, 0, 42)
abToggle.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
abToggle.Text = "Aimbot"
abToggle.TextColor3 = Color3.new(1,1,1)
abToggle.TextSize = 11
abToggle.Font = Enum.Font.GothamSemibold
Instance.new("UICorner", abToggle).CornerRadius = UDim.new(0, 5)

local abStatus = Instance.new("TextLabel", aimTab)
abStatus.Size = UDim2.new(0, 40, 0, 26)
abStatus.Position = UDim2.new(0, 150, 0, 42)
abStatus.BackgroundTransparency = 1
abStatus.Text = "OFF"
abStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
abStatus.TextSize = 11
abStatus.Font = Enum.Font.GothamBold

-- Wall Check
local wcToggle = Instance.new("TextButton", aimTab)
wcToggle.Size = UDim2.new(0, 130, 0, 26)
wcToggle.Position = UDim2.new(0, 12, 0, 74)
wcToggle.BackgroundColor3 = Color3.fromRGB(0, 220, 120)
wcToggle.Text = "Wall Check"
wcToggle.TextColor3 = Color3.new(1,1,1)
wcToggle.TextSize = 11
wcToggle.Font = Enum.Font.GothamSemibold
Instance.new("UICorner", wcToggle).CornerRadius = UDim.new(0, 5)

-- Distance
local distLabel = Instance.new("TextLabel", aimTab)
distLabel.Size = UDim2.new(0, 100, 0, 22)
distLabel.Position = UDim2.new(0, 12, 0, 108)
distLabel.BackgroundTransparency = 1
distLabel.Text = "Max Distance: 500"
distLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
distLabel.TextSize = 10
distLabel.Font = Enum.Font.Gotham

local distMinus = Instance.new("TextButton", aimTab)
distMinus.Size = UDim2.new(0, 22, 0, 20)
distMinus.Position = UDim2.new(0, 120, 0, 108)
distMinus.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
distMinus.Text = "-"
distMinus.TextColor3 = Color3.new(1,1,1)
distMinus.TextSize = 12
distMinus.Font = Enum.Font.GothamBold
Instance.new("UICorner", distMinus).CornerRadius = UDim.new(0, 4)

local distPlus = Instance.new("TextButton", aimTab)
distPlus.Size = UDim2.new(0, 22, 0, 20)
distPlus.Position = UDim2.new(0, 146, 0, 108)
distPlus.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
distPlus.Text = "+"
distPlus.TextColor3 = Color3.new(1,1,1)
distPlus.TextSize = 12
distPlus.Font = Enum.Font.GothamBold
Instance.new("UICorner", distPlus).CornerRadius = UDim.new(0, 4)

-- FOV
local fovLabel = Instance.new("TextLabel", aimTab)
fovLabel.Size = UDim2.new(0, 100, 0, 22)
fovLabel.Position = UDim2.new(0, 12, 0, 134)
fovLabel.BackgroundTransparency = 1
fovLabel.Text = "FOV: 120"
fovLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
fovLabel.TextSize = 10
fovLabel.Font = Enum.Font.Gotham

local fovMinus = Instance.new("TextButton", aimTab)
fovMinus.Size = UDim2.new(0, 22, 0, 20)
fovMinus.Position = UDim2.new(0, 120, 0, 134)
fovMinus.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
fovMinus.Text = "-"
fovMinus.TextColor3 = Color3.new(1,1,1)
fovMinus.TextSize = 12
fovMinus.Font = Enum.Font.GothamBold
Instance.new("UICorner", fovMinus).CornerRadius = UDim.new(0, 4)

local fovPlus = Instance.new("TextButton", aimTab)
fovPlus.Size = UDim2.new(0, 22, 0, 20)
fovPlus.Position = UDim2.new(0, 146, 0, 134)
fovPlus.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
fovPlus.Text = "+"
fovPlus.TextColor3 = Color3.new(1,1,1)
fovPlus.TextSize = 12
fovPlus.Font = Enum.Font.GothamBold
Instance.new("UICorner", fovPlus).CornerRadius = UDim.new(0, 4)

-- ESP TAB
local espTab = Instance.new("Frame", content)
espTab.Size = UDim2.new(1, 0, 1, 0)
espTab.BackgroundColor3 = Color3.fromRGB(36, 38, 48)
espTab.Visible = false
Instance.new("UICorner", espTab).CornerRadius = UDim.new(0, 8)
tabContents["ESP"] = espTab

createTab("ESP", false, 100)

local function makeToggle(parent, text, y)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0, 16, 0, 16)
    b.Position = UDim2.new(0, 12, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
    b.Text = ""
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 3)
    
    local l = Instance.new("TextLabel", parent)
    l.Size = UDim2.new(1, -35, 0, 16)
    l.Position = UDim2.new(0, 34, 0, y)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.fromRGB(230, 230, 240)
    l.TextSize = 10
    l.Font = Enum.Font.Gotham
    return b
end

local bBoxes = makeToggle(espTab, "Boxes", 10)
local bTracers = makeToggle(espTab, "Tracers", 28)
local bNames = makeToggle(espTab, "Names + Distance", 46)
local bHealth = makeToggle(espTab, "Health Bar", 64)
local bSkeleton = makeToggle(espTab, "Skeleton", 82)
local bLook = makeToggle(espTab, "Look Direction", 100)

local master = Instance.new("TextButton", espTab)
master.Size = UDim2.new(0, 130, 0, 26)
master.Position = UDim2.new(0, 12, 0, 128)
master.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
master.Text = "Enable ESP"
master.TextColor3 = Color3.new(1,1,1)
master.TextSize = 10
master.Font = Enum.Font.GothamSemibold
Instance.new("UICorner", master).CornerRadius = UDim.new(0, 5)

local espStatus = Instance.new("TextLabel", espTab)
espStatus.Size = UDim2.new(1, -150, 0, 26)
espStatus.Position = UDim2.new(0, 150, 0, 128)
espStatus.BackgroundTransparency = 1
espStatus.Text = "OFF"
espStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
espStatus.TextSize = 10
espStatus.Font = Enum.Font.GothamBold

-- Floating
local fl = Instance.new("TextButton", screenGui)
fl.Size = UDim2.new(0, 48, 0, 48)
fl.Position = UDim2.new(1, -60, 1, -60)
fl.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
fl.Text = "BB"
fl.TextColor3 = Color3.new(1,1,1)
fl.TextSize = 20
fl.Font = Enum.Font.GothamBlack
fl.Visible = false
Instance.new("UICorner", fl).CornerRadius = UDim.new(1, 0)

-- Variables
local espOn = false
local conn = nil
local dr = {}
local fovCircle = Drawing.new("Circle")

-- FOV Circle
fovCircle.Thickness = 2
fovCircle.Color = Color3.fromRGB(0, 210, 255)
fovCircle.Transparency = 0.4
fovCircle.NumSides = 64
fovCircle.Visible = false

local function updateFOVCircle()
    if settings.silentAim or settings.aimbot then
        fovCircle.Visible = true
        fovCircle.Radius = (settings.fov / 180) * camera.ViewportSize.Y / 2
        fovCircle.Position = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    else
        fovCircle.Visible = false
    end
end

-- Settings buttons
distMinus.MouseButton1Click:Connect(function()
    settings.maxDist = math.max(100, settings.maxDist - 50)
    distLabel.Text = "Max Distance: " .. settings.maxDist
end)

distPlus.MouseButton1Click:Connect(function()
    settings.maxDist = math.min(2000, settings.maxDist + 50)
    distLabel.Text = "Max Distance: " .. settings.maxDist
end)

fovMinus.MouseButton1Click:Connect(function()
    settings.fov = math.max(30, settings.fov - 10)
    fovLabel.Text = "FOV: " .. settings.fov
end)

fovPlus.MouseButton1Click:Connect(function()
    settings.fov = math.min(180, settings.fov + 10)
    fovLabel.Text = "FOV: " .. settings.fov
end)

wcToggle.MouseButton1Click:Connect(function()
    settings.wallCheck = not settings.wallCheck
    if settings.wallCheck then
        wcToggle.BackgroundColor3 = Color3.fromRGB(0, 220, 120)
    else
        wcToggle.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
    end
end)

saToggle.MouseButton1Click:Connect(function()
    settings.silentAim = not settings.silentAim
    if settings.silentAim then
        saToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 110)
        saStatus.Text = "ON"
        saStatus.TextColor3 = Color3.fromRGB(100, 255, 160)
    else
        saToggle.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
        saStatus.Text = "OFF"
        saStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

abToggle.MouseButton1Click:Connect(function()
    settings.aimbot = not settings.aimbot
    if settings.aimbot then
        abToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 110)
        abStatus.Text = "ON"
        abStatus.TextColor3 = Color3.fromRGB(100, 255, 160)
    else
        abToggle.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
        abStatus.Text = "OFF"
        abStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

master.MouseButton1Click:Connect(function()
    espOn = not espOn
    if espOn then
        master.BackgroundColor3 = Color3.fromRGB(0, 200, 110)
        master.Text = "ESP ON"
        espStatus.Text = "ACTIVE"
        espStatus.TextColor3 = Color3.fromRGB(100, 255, 160)
        if not conn then conn = RunService.RenderStepped:Connect(updateESP) end
    else
        master.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
        master.Text = "Enable ESP"
        espStatus.Text = "OFF"
        espStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
        if conn then conn:Disconnect() conn = nil end
        for _, d in pairs(dr) do for _, v in pairs(d) do v:Remove() end end
        dr = {}
    end
end)

-- Wall Check Function
local function isVisible(targetPos)
    if not settings.wallCheck then return true end
    local ray = Ray.new(camera.CFrame.Position, (targetPos - camera.CFrame.Position).Unit * 1000)
    local hit = workspace:FindPartOnRayWithIgnoreList(ray, {player.Character})
    return hit and hit:IsDescendantOf(workspace) and (hit.Position - targetPos).Magnitude < 5
end

-- Get Best Target
local function getBestTarget()
    local best = nil
    local bestScore = math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
            local head = p.Character.Head
            local dist = (head.Position - camera.CFrame.Position).Magnitude
            if dist > settings.maxDist then continue end
            
            local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)
            if not onScreen then continue end
            
            local angle = math.deg(math.acos(camera.CFrame.LookVector:Dot((head.Position - camera.CFrame.Position).Unit)))
            if angle > settings.fov / 2 then continue end
            
            if not isVisible(head.Position) then continue end
            
            local score = dist + (angle * 2)
            if score < bestScore then
                bestScore = score
                best = p
            end
        end
    end
    return best
end

-- Silent Aim + Aimbot + FOV Circle
RunService.RenderStepped:Connect(function()
    updateFOVCircle()
    
    if settings.silentAim or settings.aimbot then
        local target = getBestTarget()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local headPos = target.Character.Head.Position
            camera.CFrame = CFrame.new(camera.CFrame.Position, headPos)
        end
    end
end)

function updateESP()
    if not espOn then return end
    local cam = workspace.CurrentCamera
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            local head = p.Character:FindFirstChild("Head")
            local hum = p.Character:FindFirstChild("Humanoid")
            
            local pos, vis = cam:WorldToViewportPoint(hrp.Position)
            local dist = (cam.CFrame.Position - hrp.Position).Magnitude
            
            if vis and dist < 1200 then
                if not dr[p] then
                    dr[p] = {
                        -- Box with outline (like popular cheats)
                        boxOutline = Drawing.new("Square"),
                        box = Drawing.new("Square"),
                        -- Tracer
                        tracer = Drawing.new("Line"),
                        -- Name
                        name = Drawing.new("Text"),
                        -- Health bar
                        healthBg = Drawing.new("Square"),
                        healthBar = Drawing.new("Square"),
                        -- Head dot
                        headDot = Drawing.new("Circle")
                    }
                    
                    -- Box outline (black)
                    dr[p].boxOutline.Thickness = 3
                    dr[p].boxOutline.Color = Color3.fromRGB(0, 0, 0)
                    dr[p].boxOutline.Filled = false
                    
                    -- Box (colored)
                    dr[p].box.Thickness = 1.5
                    dr[p].box.Filled = false
                    
                    -- Tracer
                    dr[p].tracer.Thickness = 1.8
                    
                    -- Name
                    dr[p].name.Size = 13
                    dr[p].name.Center = true
                    dr[p].name.Outline = true
                    dr[p].name.OutlineColor = Color3.fromRGB(0, 0, 0)
                    
                    -- Health bar
                    dr[p].healthBg.Thickness = 0
                    dr[p].healthBg.Filled = true
                    dr[p].healthBg.Color = Color3.fromRGB(20, 20, 20)
                    
                    dr[p].healthBar.Thickness = 0
                    dr[p].healthBar.Filled = true
                    
                    -- Head dot
                    dr[p].headDot.Thickness = 1
                    dr[p].headDot.Filled = true
                    dr[p].headDot.NumSides = 12
                end
                
                local d = dr[p]
                local s = math.clamp(2600 / dist, 42, 110)
                local hp = hum and math.clamp(hum.Health / hum.MaxHealth, 0, 1) or 1
                
                -- Color based on health
                local boxColor = Color3.fromRGB(0, 255, 140)
                if hp < 0.6 then boxColor = Color3.fromRGB(255, 210, 60) end
                if hp < 0.3 then boxColor = Color3.fromRGB(255, 70, 70) end
                
                -- BOX WITH OUTLINE (popular cheat style)
                if bBoxes.BackgroundColor3 == Color3.fromRGB(0, 220, 120) then
                    -- Outline
                    d.boxOutline.Size = Vector2.new(s, s * 1.75)
                    d.boxOutline.Position = Vector2.new(pos.X - s/2, pos.Y - s * 0.88)
                    d.boxOutline.Visible = true
                    
                    -- Main box
                    d.box.Size = Vector2.new(s, s * 1.75)
                    d.box.Position = Vector2.new(pos.X - s/2, pos.Y - s * 0.88)
                    d.box.Color = boxColor
                    d.box.Visible = true
                else
                    d.boxOutline.Visible = false
                    d.box.Visible = false
                end
                
                -- TRACERS (from bottom center)
                if bTracers.BackgroundColor3 == Color3.fromRGB(0, 220, 120) then
                    d.tracer.From = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y - 10)
                    d.tracer.To = Vector2.new(pos.X, pos.Y)
                    d.tracer.Color = boxColor
                    d.tracer.Visible = true
                else
                    d.tracer.Visible = false
                end
                
                -- NAMES + DISTANCE
                if bNames.BackgroundColor3 == Color3.fromRGB(0, 220, 120) then
                    d.name.Text = p.Name .. " [" .. math.floor(dist) .. "m]"
                    d.name.Position = Vector2.new(pos.X, pos.Y - s * 0.92 - 14)
                    d.name.Color = Color3.fromRGB(255, 255, 255)
                    d.name.Visible = true
                else
                    d.name.Visible = false
                end
                
                -- HEALTH BAR (side bar like popular cheats)
                if bHealth.BackgroundColor3 == Color3.fromRGB(0, 220, 120) then
                    local barHeight = s * 1.6
                    local barWidth = 4
                    
                    -- Background
                    d.healthBg.Size = Vector2.new(barWidth, barHeight)
                    d.healthBg.Position = Vector2.new(pos.X + s/2 + 6, pos.Y - s * 0.8)
                    d.healthBg.Visible = true
                    
                    -- Health fill
                    local healthHeight = barHeight * hp
                    d.healthBar.Size = Vector2.new(barWidth, healthHeight)
                    d.healthBar.Position = Vector2.new(pos.X + s/2 + 6, pos.Y - s * 0.8 + (barHeight - healthHeight))
                    d.healthBar.Color = Color3.fromRGB(255 * (1 - hp), 255 * hp, 50)
                    d.healthBar.Visible = true
                else
                    d.healthBg.Visible = false
                    d.healthBar.Visible = false
                end
                
                -- HEAD DOT
                if bSkeleton.BackgroundColor3 == Color3.fromRGB(0, 220, 120) and head then
                    local headPos, headVis = cam:WorldToViewportPoint(head.Position)
                    if headVis then
                        d.headDot.Position = Vector2.new(headPos.X, headPos.Y)
                        d.headDot.Radius = math.clamp(2800 / dist, 3, 7)
                        d.headDot.Color = boxColor
                        d.headDot.Visible = true
                    else
                        d.headDot.Visible = false
                    end
                else
                    d.headDot.Visible = false
                end
                
            else
                if dr[p] then 
                    for _, v in pairs(dr[p]) do v.Visible = false end 
                end
            end
        end
    end
end

-- Buttons
minBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    fl.Visible = true
end)

fl.MouseButton1Click:Connect(function()
    main.Visible = true
    fl.Visible = false
end)

close.MouseButton1Click:Connect(function()
    if conn then conn:Disconnect() end
    fovCircle:Remove()
    screenGui:Destroy()
end)
