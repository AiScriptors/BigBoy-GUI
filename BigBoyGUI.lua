local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("BigBoyGUI") then playerGui.BigBoyGUI:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BigBoyGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Settings (можно менять)
local AIM_FOV = 90          -- Поле зрения аимбота (градусы)
local AIM_DISTANCE = 400    -- Максимальная дистанция
local WALL_CHECK = true     -- Проверка стен

-- Menu
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 560, 0, 340)
main.Position = UDim2.new(0.5, -280, 0.5, -170)
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
top.Size = UDim2.new(1, 0, 0, 40)
top.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
Instance.new("UICorner", top).CornerRadius = UDim.new(0, 12)

local grad = Instance.new("UIGradient", top)
grad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 20, 28)), ColorSequenceKeypoint.new(1, Color3.fromRGB(24, 26, 36))}

local logo = Instance.new("TextLabel", top)
logo.Size = UDim2.new(0, 110, 1, 0)
logo.Position = UDim2.new(0, 10, 0, 0)
logo.BackgroundTransparency = 1
logo.Text = "BIGBOY GUI"
logo.TextColor3 = Color3.fromRGB(0, 210, 255)
logo.TextSize = 17
logo.Font = Enum.Font.GothamBlack

local close = Instance.new("TextButton", top)
close.Size = UDim2.new(0, 28, 0, 28)
close.Position = UDim2.new(1, -32, 0, 6)
close.BackgroundColor3 = Color3.fromRGB(230, 65, 65)
close.Text = "✕"
close.TextColor3 = Color3.new(1,1,1)
close.TextSize = 14
close.Font = Enum.Font.GothamBold
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 5)

local minBtn = Instance.new("TextButton", top)
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -64, 0, 6)
minBtn.BackgroundColor3 = Color3.fromRGB(0, 175, 225)
minBtn.Text = "▽"
minBtn.TextColor3 = Color3.new(1,1,1)
minBtn.TextSize = 14
minBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 5)

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -8, 1, -48)
content.Position = UDim2.new(0, 4, 0, 44)
content.BackgroundTransparency = 1

-- Tabs
local aimTab = Instance.new("Frame", content)
aimTab.Size = UDim2.new(1, 0, 1, 0)
aimTab.BackgroundColor3 = Color3.fromRGB(36, 38, 48)
aimTab.Visible = true
Instance.new("UICorner", aimTab).CornerRadius = UDim.new(0, 8)

local espTab = Instance.new("Frame", content)
espTab.Size = UDim2.new(1, 0, 1, 0)
espTab.BackgroundColor3 = Color3.fromRGB(36, 38, 48)
espTab.Visible = false
Instance.new("UICorner", espTab).CornerRadius = UDim.new(0, 8)

-- Tab buttons
local aimBtn = Instance.new("TextButton", content)
aimBtn.Size = UDim2.new(0, 75, 0, 26)
aimBtn.Position = UDim2.new(0, 8, 0, 0)
aimBtn.BackgroundColor3 = Color3.fromRGB(48, 51, 62)
aimBtn.Text = "Aimbot"
aimBtn.TextColor3 = Color3.new(1,1,1)
aimBtn.TextSize = 10
aimBtn.Font = Enum.Font.GothamSemibold
Instance.new("UICorner", aimBtn).CornerRadius = UDim.new(0, 5)

local espBtn = Instance.new("TextButton", content)
espBtn.Size = UDim2.new(0, 75, 0, 26)
espBtn.Position = UDim2.new(0, 88, 0, 0)
espBtn.BackgroundColor3 = Color3.fromRGB(36, 38, 48)
espBtn.Text = "ESP"
espBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
espBtn.TextSize = 10
espBtn.Font = Enum.Font.GothamSemibold
Instance.new("UICorner", espBtn).CornerRadius = UDim.new(0, 5)

aimBtn.MouseButton1Click:Connect(function()
    aimTab.Visible = true
    espTab.Visible = false
    aimBtn.BackgroundColor3 = Color3.fromRGB(48, 51, 62)
    aimBtn.TextColor3 = Color3.new(1,1,1)
    espBtn.BackgroundColor3 = Color3.fromRGB(36, 38, 48)
    espBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
end)

espBtn.MouseButton1Click:Connect(function()
    aimTab.Visible = false
    espTab.Visible = true
    espBtn.BackgroundColor3 = Color3.fromRGB(48, 51, 62)
    espBtn.TextColor3 = Color3.new(1,1,1)
    aimBtn.BackgroundColor3 = Color3.fromRGB(36, 38, 48)
    aimBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
end)

-- AIMBOT TAB CONTENT
local saToggle = Instance.new("TextButton", aimTab)
saToggle.Size = UDim2.new(0, 150, 0, 26)
saToggle.Position = UDim2.new(0, 10, 0, 8)
saToggle.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
saToggle.Text = "Silent Aim"
saToggle.TextColor3 = Color3.new(1,1,1)
saToggle.TextSize = 11
saToggle.Font = Enum.Font.GothamSemibold
Instance.new("UICorner", saToggle).CornerRadius = UDim.new(0, 5)

local saStatus = Instance.new("TextLabel", aimTab)
saStatus.Size = UDim2.new(0, 40, 0, 26)
saStatus.Position = UDim2.new(0, 165, 0, 8)
saStatus.BackgroundTransparency = 1
saStatus.Text = "OFF"
saStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
saStatus.TextSize = 10
saStatus.Font = Enum.Font.GothamBold

local abToggle = Instance.new("TextButton", aimTab)
abToggle.Size = UDim2.new(0, 150, 0, 26)
abToggle.Position = UDim2.new(0, 10, 0, 38)
abToggle.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
abToggle.Text = "Aimbot (Visible)"
abToggle.TextColor3 = Color3.new(1,1,1)
abToggle.TextSize = 11
abToggle.Font = Enum.Font.GothamSemibold
Instance.new("UICorner", abToggle).CornerRadius = UDim.new(0, 5)

local abStatus = Instance.new("TextLabel", aimTab)
abStatus.Size = UDim2.new(0, 40, 0, 26)
abStatus.Position = UDim2.new(0, 165, 0, 38)
abStatus.BackgroundTransparency = 1
abStatus.Text = "OFF"
abStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
abStatus.TextSize = 10
abStatus.Font = Enum.Font.GothamBold

local wcToggle = Instance.new("TextButton", aimTab)
wcToggle.Size = UDim2.new(0, 150, 0, 26)
wcToggle.Position = UDim2.new(0, 10, 0, 68)
wcToggle.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
wcToggle.Text = "Wall Check"
wcToggle.TextColor3 = Color3.new(1,1,1)
wcToggle.TextSize = 11
wcToggle.Font = Enum.Font.GothamSemibold
Instance.new("UICorner", wcToggle).CornerRadius = UDim.new(0, 5)

local wcStatus = Instance.new("TextLabel", aimTab)
wcStatus.Size = UDim2.new(0, 40, 0, 26)
wcStatus.Position = UDim2.new(0, 165, 0, 68)
wcStatus.BackgroundTransparency = 1
wcStatus.Text = "ON"
wcStatus.TextColor3 = Color3.fromRGB(100, 255, 160)
wcStatus.TextSize = 10
wcStatus.Font = Enum.Font.GothamBold

-- FOV & Distance
local fovLabel = Instance.new("TextLabel", aimTab)
fovLabel.Size = UDim2.new(0, 80, 0, 20)
fovLabel.Position = UDim2.new(0, 10, 0, 100)
fovLabel.BackgroundTransparency = 1
fovLabel.Text = "FOV: "..AIM_FOV
fovLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
fovLabel.TextSize = 10
fovLabel.Font = Enum.Font.Gotham

local fovMinus = Instance.new("TextButton", aimTab)
fovMinus.Size = UDim2.new(0, 22, 0, 20)
fovMinus.Position = UDim2.new(0, 95, 0, 100)
fovMinus.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
fovMinus.Text = "-"
fovMinus.TextColor3 = Color3.new(1,1,1)
fovMinus.TextSize = 12
fovMinus.Font = Enum.Font.GothamBold
Instance.new("UICorner", fovMinus).CornerRadius = UDim.new(0, 3)

local fovPlus = Instance.new("TextButton", aimTab)
fovPlus.Size = UDim2.new(0, 22, 0, 20)
fovPlus.Position = UDim2.new(0, 120, 0, 100)
fovPlus.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
fovPlus.Text = "+"
fovPlus.TextColor3 = Color3.new(1,1,1)
fovPlus.TextSize = 12
fovPlus.Font = Enum.Font.GothamBold
Instance.new("UICorner", fovPlus).CornerRadius = UDim.new(0, 3)

local distLabel = Instance.new("TextLabel", aimTab)
distLabel.Size = UDim2.new(0, 100, 0, 20)
distLabel.Position = UDim2.new(0, 10, 0, 125)
distLabel.BackgroundTransparency = 1
distLabel.Text = "Distance: "..AIM_DISTANCE
distLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
distLabel.TextSize = 10
distLabel.Font = Enum.Font.Gotham

local distMinus = Instance.new("TextButton", aimTab)
distMinus.Size = UDim2.new(0, 22, 0, 20)
distMinus.Position = UDim2.new(0, 115, 0, 125)
distMinus.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
distMinus.Text = "-"
distMinus.TextColor3 = Color3.new(1,1,1)
distMinus.TextSize = 12
distMinus.Font = Enum.Font.GothamBold
Instance.new("UICorner", distMinus).CornerRadius = UDim.new(0, 3)

local distPlus = Instance.new("TextButton", aimTab)
distPlus.Size = UDim2.new(0, 22, 0, 20)
distPlus.Position = UDim2.new(0, 140, 0, 125)
distPlus.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
distPlus.Text = "+"
distPlus.TextColor3 = Color3.new(1,1,1)
distPlus.TextSize = 12
distPlus.Font = Enum.Font.GothamBold
Instance.new("UICorner", distPlus).CornerRadius = UDim.new(0, 3)

-- ESP TAB
local bBoxes = Instance.new("TextButton", espTab)
bBoxes.Size = UDim2.new(0, 14, 0, 14)
bBoxes.Position = UDim2.new(0, 10, 0, 10)
bBoxes.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
bBoxes.Text = ""
Instance.new("UICorner", bBoxes).CornerRadius = UDim.new(0, 3)

local lBoxes = Instance.new("TextLabel", espTab)
lBoxes.Size = UDim2.new(1, -30, 0, 14)
lBoxes.Position = UDim2.new(0, 30, 0, 10)
lBoxes.BackgroundTransparency = 1
lBoxes.Text = "Boxes"
lBoxes.TextColor3 = Color3.fromRGB(230, 230, 240)
lBoxes.TextSize = 10
lBoxes.Font = Enum.Font.Gotham

local bTracers = Instance.new("TextButton", espTab)
bTracers.Size = UDim2.new(0, 14, 0, 14)
bTracers.Position = UDim2.new(0, 10, 0, 28)
bTracers.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
bTracers.Text = ""
Instance.new("UICorner", bTracers).CornerRadius = UDim.new(0, 3)

local lTracers = Instance.new("TextLabel", espTab)
lTracers.Size = UDim2.new(1, -30, 0, 14)
lTracers.Position = UDim2.new(0, 30, 0, 28)
lTracers.BackgroundTransparency = 1
lTracers.Text = "Tracers"
lTracers.TextColor3 = Color3.fromRGB(230, 230, 240)
lTracers.TextSize = 10
lTracers.Font = Enum.Font.Gotham

local bNames = Instance.new("TextButton", espTab)
bNames.Size = UDim2.new(0, 14, 0, 14)
bNames.Position = UDim2.new(0, 10, 0, 46)
bNames.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
bNames.Text = ""
Instance.new("UICorner", bNames).CornerRadius = UDim.new(0, 3)

local lNames = Instance.new("TextLabel", espTab)
lNames.Size = UDim2.new(1, -30, 0, 14)
lNames.Position = UDim2.new(0, 30, 0, 46)
lNames.BackgroundTransparency = 1
lNames.Text = "Names + Distance"
lNames.TextColor3 = Color3.fromRGB(230, 230, 240)
lNames.TextSize = 10
lNames.Font = Enum.Font.Gotham

local bHealth = Instance.new("TextButton", espTab)
bHealth.Size = UDim2.new(0, 14, 0, 14)
bHealth.Position = UDim2.new(0, 10, 0, 64)
bHealth.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
bHealth.Text = ""
Instance.new("UICorner", bHealth).CornerRadius = UDim.new(0, 3)

local lHealth = Instance.new("TextLabel", espTab)
lHealth.Size = UDim2.new(1, -30, 0, 14)
lHealth.Position = UDim2.new(0, 30, 0, 64)
lHealth.BackgroundTransparency = 1
lHealth.Text = "Health Bar"
lHealth.TextColor3 = Color3.fromRGB(230, 230, 240)
lHealth.TextSize = 10
lHealth.Font = Enum.Font.Gotham

local master = Instance.new("TextButton", espTab)
master.Size = UDim2.new(0, 120, 0, 24)
master.Position = UDim2.new(0, 10, 0, 90)
master.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
master.Text = "Enable ESP"
master.TextColor3 = Color3.new(1,1,1)
master.TextSize = 10
master.Font = Enum.Font.GothamSemibold
Instance.new("UICorner", master).CornerRadius = UDim.new(0, 4)

local espStatus = Instance.new("TextLabel", espTab)
espStatus.Size = UDim2.new(1, -140, 0, 24)
espStatus.Position = UDim2.new(0, 140, 0, 90)
espStatus.BackgroundTransparency = 1
espStatus.Text = "OFF"
espStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
espStatus.TextSize = 10
espStatus.Font = Enum.Font.GothamBold

-- Floating
local fl = Instance.new("TextButton", screenGui)
fl.Size = UDim2.new(0, 46, 0, 46)
fl.Position = UDim2.new(1, -56, 1, -56)
fl.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
fl.Text = "BB"
fl.TextColor3 = Color3.new(1,1,1)
fl.TextSize = 18
fl.Font = Enum.Font.GothamBlack
fl.Visible = false
Instance.new("UICorner", fl).CornerRadius = UDim.new(1, 0)

-- Variables
local espOn = false
local saOn = false
local abOn = false
local conn = nil
local dr = {}

local function toggle(b)
    if b.BackgroundColor3 == Color3.fromRGB(0, 220, 120) then
        b.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
        b.Text = ""
    else
        b.BackgroundColor3 = Color3.fromRGB(0, 220, 120)
        b.Text = "✓"
    end
end

bBoxes.MouseButton1Click:Connect(function() toggle(bBoxes) end)
bTracers.MouseButton1Click:Connect(function() toggle(bTracers) end)
bNames.MouseButton1Click:Connect(function() toggle(bNames) end)
bHealth.MouseButton1Click:Connect(function() toggle(bHealth) end)

saToggle.MouseButton1Click:Connect(function()
    saOn = not saOn
    if saOn then
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
    abOn = not abOn
    if abOn then
        abToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 110)
        abStatus.Text = "ON"
        abStatus.TextColor3 = Color3.fromRGB(100, 255, 160)
    else
        abToggle.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
        abStatus.Text = "OFF"
        abStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

wcToggle.MouseButton1Click:Connect(function()
    WALL_CHECK = not WALL_CHECK
    if WALL_CHECK then
        wcToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 110)
        wcStatus.Text = "ON"
        wcStatus.TextColor3 = Color3.fromRGB(100, 255, 160)
    else
        wcToggle.BackgroundColor3 = Color3.fromRGB(55, 58, 70)
        wcStatus.Text = "OFF"
        wcStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- FOV buttons
fovMinus.MouseButton1Click:Connect(function()
    AIM_FOV = math.max(30, AIM_FOV - 10)
    fovLabel.Text = "FOV: "..AIM_FOV
end)

fovPlus.MouseButton1Click:Connect(function()
    AIM_FOV = math.min(180, AIM_FOV + 10)
    fovLabel.Text = "FOV: "..AIM_FOV
end)

-- Distance buttons
distMinus.MouseButton1Click:Connect(function()
    AIM_DISTANCE = math.max(50, AIM_DISTANCE - 50)
    distLabel.Text = "Distance: "..AIM_DISTANCE
end)

distPlus.MouseButton1Click:Connect(function()
    AIM_DISTANCE = math.min(1000, AIM_DISTANCE + 50)
    distLabel.Text = "Distance: "..AIM_DISTANCE
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

-- Wall check function
local function hasWall(startPos, endPos)
    if not WALL_CHECK then return false end
    local ray = Ray.new(startPos, (endPos - startPos).Unit * (endPos - startPos).Magnitude)
    local hit = workspace:FindPartOnRayWithIgnoreList(ray, {player.Character})
    return hit ~= nil
end

-- Get closest target
local function getTarget()
    local closest = nil
    local bestDist = math.huge
    local cam = workspace.CurrentCamera
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
            local head = p.Character.Head
            local dist = (head.Position - cam.CFrame.Position).Magnitude
            if dist > AIM_DISTANCE then continue end
            
            -- FOV check
            local screenPos, onScreen = cam:WorldToViewportPoint(head.Position)
            if not onScreen then continue end
            
            local center = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
            local angle = math.deg(math.atan2(screenPos.X - center.X, screenPos.Y - center.Y))
            if math.abs(angle) > AIM_FOV/2 then continue end
            
            -- Wall check
            if hasWall(cam.CFrame.Position, head.Position) then continue end
            
            if dist < bestDist then
                bestDist = dist
                closest = p
            end
        end
    end
    return closest
end

-- Silent Aim (no visible camera move when not shooting)
UserInputService.InputBegan:Connect(function(input)
    if saOn and input.UserInputType == Enum.UserInputType.MouseButton1 then
        local target = getTarget()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local cam = workspace.CurrentCamera
            local oldCFrame = cam.CFrame
            cam.CFrame = CFrame.new(cam.CFrame.Position, target.Character.Head.Position)
            task.wait(0.03) -- короткая задержка
            cam.CFrame = oldCFrame
        end
    end
end)

-- Aimbot (visible lock)
RunService.RenderStepped:Connect(function()
    if abOn then
        local target = getTarget()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local cam = workspace.CurrentCamera
            cam.CFrame = CFrame.new(cam.CFrame.Position, target.Character.Head.Position)
        end
    end
end)

function updateESP()
    if not espOn then return end
    local cam = workspace.CurrentCamera
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            local pos, vis = cam:WorldToViewportPoint(hrp.Position)
            local dist = (cam.CFrame.Position - hrp.Position).Magnitude
            if vis and dist < 1200 then
                if not dr[p] then
                    dr[p] = {
                        box = Drawing.new("Square"),
                        line = Drawing.new("Line"),
                        txt = Drawing.new("Text"),
                        hb = Drawing.new("Square"),
                        hbb = Drawing.new("Square")
                    }
                    dr[p].box.Thickness = 1.5
                    dr[p].line.Thickness = 1.4
                    dr[p].txt.Size = 11
                    dr[p].txt.Center = true
                    dr[p].txt.Outline = true
                    dr[p].hb.Thickness = 0
                    dr[p].hb.Filled = true
                    dr[p].hbb.Thickness = 0
                    dr[p].hbb.Filled = true
                    dr[p].hbb.Color = Color3.fromRGB(40, 40, 40)
                end
                local d = dr[p]
                local s = math.clamp(2300 / dist, 36, 95)
                local hp = p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health / p.Character.Humanoid.MaxHealth or 1
                local col = hp > 0.6 and Color3.fromRGB(0, 255, 130) or (hp > 0.3 and Color3.fromRGB(255, 200, 50) or Color3.fromRGB(255, 80, 80))
                
                if bBoxes.BackgroundColor3 == Color3.fromRGB(0, 220, 120) then
                    d.box.Size = Vector2.new(s, s * 1.65)
                    d.box.Position = Vector2.new(pos.X - s/2, pos.Y - s * 0.82)
                    d.box.Color = col
                    d.box.Visible = true
                else d.box.Visible = false end
                
                if bTracers.BackgroundColor3 == Color3.fromRGB(0, 220, 120) then
                    d.line.From = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y)
                    d.line.To = Vector2.new(pos.X, pos.Y)
                    d.line.Color = col
                    d.line.Visible = true
                else d.line.Visible = false end
                
                if bNames.BackgroundColor3 == Color3.fromRGB(0, 220, 120) then
                    d.txt.Text = p.Name .. " ["..math.floor(dist).."m]"
                    d.txt.Position = Vector2.new(pos.X, pos.Y - s * 0.85 - 10)
                    d.txt.Visible = true
                else d.txt.Visible = false end
                
                if bHealth.BackgroundColor3 == Color3.fromRGB(0, 220, 120) then
                    local bh = s * 1.45
                    d.hbb.Size = Vector2.new(3, bh)
                    d.hbb.Position = Vector2.new(pos.X + s/2 + 4, pos.Y - s * 0.72)
                    d.hbb.Visible = true
                    d.hb.Size = Vector2.new(3, bh * hp)
                    d.hb.Position = Vector2.new(pos.X + s/2 + 4, pos.Y - s * 0.72 + bh * (1 - hp))
                    d.hb.Color = Color3.fromRGB(255 * (1 - hp), 255 * hp, 40)
                    d.hb.Visible = true
                else d.hbb.Visible = false; d.hb.Visible = false end
            else
                if dr[p] then for _, v in pairs(dr[p]) do v.Visible = false end end
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
    screenGui:Destroy()
end)

print("✅ BIGBOY GUI v2.3 - Silent Aim + Aimbot + WallCheck + FOV/Distance")
