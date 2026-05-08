local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera
local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

if pg:FindFirstChild("BigBoyGUI") then pg.BigBoyGUI:Destroy() end

local sg = Instance.new("ScreenGui")
sg.Name = "BigBoyGUI"
sg.ResetOnSpawn = false
sg.Parent = pg

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 420, 0, 280)
main.Position = UDim2.new(0.5, -210, 0.5, -140)
main.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 38)
title.BackgroundColor3 = Color3.fromRGB(14, 16, 22)
title.Text = "BIGBOY GUI"
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBlack
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)

local close = Instance.new("TextButton", title)
close.Size = UDim2.new(0, 28, 0, 28)
close.Position = UDim2.new(1, -34, 0, 5)
close.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
close.Text = "✕"
close.TextColor3 = Color3.new(1,1,1)
close.TextSize = 14
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 6)

local minBtn = Instance.new("TextButton", title)
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -66, 0, 5)
minBtn.BackgroundColor3 = Color3.fromRGB(0, 155, 205)
minBtn.Text = "–"
minBtn.TextColor3 = Color3.new(1,1,1)
minBtn.TextSize = 16
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

-- ESP Button
local espBtn = Instance.new("TextButton", main)
espBtn.Size = UDim2.new(0, 180, 0, 48)
espBtn.Position = UDim2.new(0.5, -90, 0, 55)
espBtn.BackgroundColor3 = Color3.fromRGB(42, 47, 60)
espBtn.Text = "ESP: OFF"
espBtn.TextColor3 = Color3.new(1,1,1)
espBtn.TextSize = 16
espBtn.Font = Enum.Font.GothamSemibold
Instance.new("UICorner", espBtn).CornerRadius = UDim.new(0, 8)

-- Aimbot Button
local aimBtn = Instance.new("TextButton", main)
aimBtn.Size = UDim2.new(0, 180, 0, 48)
aimBtn.Position = UDim2.new(0.5, -90, 0, 115)
aimBtn.BackgroundColor3 = Color3.fromRGB(42, 47, 60)
aimBtn.Text = "AIMBOT: OFF"
aimBtn.TextColor3 = Color3.new(1,1,1)
aimBtn.TextSize = 16
aimBtn.Font = Enum.Font.GothamSemibold
Instance.new("UICorner", aimBtn).CornerRadius = UDim.new(0, 8)

-- Floating
local float = Instance.new("TextButton", sg)
float.Size = UDim2.new(0, 48, 0, 48)
float.Position = UDim2.new(1, -62, 1, -68)
float.BackgroundColor3 = Color3.fromRGB(0, 185, 255)
float.Text = "BB"
float.TextColor3 = Color3.new(1,1,1)
float.TextSize = 22
float.Font = Enum.Font.GothamBlack
float.Visible = false
Instance.new("UICorner", float).CornerRadius = UDim.new(1, 0)

-- Variables
local espOn = false
local aimOn = false
local drawings = {}
local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 1.8
fovCircle.Color = Color3.fromRGB(0, 200, 255)
fovCircle.Transparency = 0.45
fovCircle.NumSides = 60
fovCircle.Visible = false

local function getDraw(p)
    if drawings[p] then return drawings[p] end
    local d = {}
    d.boxOut = Drawing.new("Square") d.boxOut.Thickness = 4 d.boxOut.Color = Color3.new(0,0,0) d.boxOut.Filled = false
    d.box = Drawing.new("Square") d.box.Thickness = 1.4 d.box.Filled = false
    d.tracer = Drawing.new("Line") d.tracer.Thickness = 1.8
    d.name = Drawing.new("Text") d.name.Size = 12 d.name.Center = true d.name.Outline = true
    d.hpBg = Drawing.new("Square") d.hpBg.Filled = true d.hpBg.Color = Color3.fromRGB(18,18,18)
    d.hp = Drawing.new("Square") d.hp.Filled = true
    d.head = Drawing.new("Circle") d.head.Radius = 3 d.head.Filled = true
    drawings[p] = d
    return d
end

local function updateESP()
    if not espOn then return end
    for _, p in pairs(Players:GetPlayers()) do
        if p == lp or not p.Character then continue end
        local root = p.Character:FindFirstChild("HumanoidRootPart")
        local head = p.Character:FindFirstChild("Head")
        local hum = p.Character:FindFirstChild("Humanoid")
        if not root or not hum then continue end
        
        local pos, vis = camera:WorldToViewportPoint(root.Position)
        local dist = (camera.CFrame.Position - root.Position).Magnitude
        if not vis or dist > 750 then
            if drawings[p] then for _, v in pairs(drawings[p]) do v.Visible = false end end
            continue
        end
        
        local d = getDraw(p)
        local size = math.clamp(2300 / dist, 40, 100)
        local hp = hum.Health / hum.MaxHealth
        local col = hp > 0.6 and Color3.fromRGB(55,255,75) or (hp > 0.35 and Color3.fromRGB(255,195,25) or Color3.fromRGB(255,40,40))
        
        d.boxOut.Size = Vector2.new(size, size*1.85)
        d.boxOut.Position = Vector2.new(pos.X - size/2, pos.Y - size*0.92)
        d.boxOut.Visible = true
        
        d.box.Size = d.boxOut.Size
        d.box.Position = d.boxOut.Position
        d.box.Color = col
        d.box.Visible = true
        
        d.tracer.From = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y-2)
        d.tracer.To = Vector2.new(pos.X, pos.Y)
        d.tracer.Color = col
        d.tracer.Visible = true
        
        d.name.Text = p.Name.." ["..math.floor(dist).."m]"
        d.name.Position = Vector2.new(pos.X, pos.Y - size*0.94 - 9)
        d.name.Visible = true
        
        local barH = size*1.65
        d.hpBg.Size = Vector2.new(5, barH)
        d.hpBg.Position = Vector2.new(pos.X + size/2 + 6, pos.Y - size*0.82)
        d.hpBg.Visible = true
        
        d.hp.Size = Vector2.new(5, barH * hp)
        d.hp.Position = Vector2.new(pos.X + size/2 + 6, pos.Y - size*0.82 + barH*(1-hp))
        d.hp.Color = col
        d.hp.Visible = true
        
        if head then
            local hpos = camera:WorldToViewportPoint(head.Position)
            d.head.Position = Vector2.new(hpos.X, hpos.Y)
            d.head.Color = col
            d.head.Visible = true
        end
    end
end

-- Aimbot
RunService.RenderStepped:Connect(function()
    fovCircle.Visible = aimOn
    fovCircle.Radius = camera.ViewportSize.Y * 0.26
    fovCircle.Position = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
    
    if not aimOn then return end
    
    local best, bestDist = nil, 999
    for _, p in pairs(Players:GetPlayers()) do
        if p \~= lp and p.Character and p.Character:FindFirstChild("Head") then
            local head = p.Character.Head
            local dist = (head.Position - camera.CFrame.Position).Magnitude
            if dist > 600 then continue end
            local screen, onScreen = camera:WorldToViewportPoint(head.Position)
            if not onScreen then continue end
            local angle = math.deg(math.acos(camera.CFrame.LookVector:Dot((head.Position - camera.CFrame.Position).Unit)))
            if angle > 55 then continue end
            if dist < bestDist then bestDist = dist best = head end
        end
    end
    if best then
        camera.CFrame = CFrame.new(camera.CFrame.Position, best.Position)
    end
end)

-- Buttons
espBtn.MouseButton1Click:Connect(function()
    espOn = not espOn
    espBtn.BackgroundColor3 = espOn and Color3.fromRGB(0,195,85) or Color3.fromRGB(42,47,60)
    espBtn.Text = espOn and "ESP: ON" or "ESP: OFF"
end)

aimBtn.MouseButton1Click:Connect(function()
    aimOn = not aimOn
    aimBtn.BackgroundColor3 = aimOn and Color3.fromRGB(0,195,85) or Color3.fromRGB(42,47,60)
    aimBtn.Text = aimOn and "AIMBOT: ON" or "AIMBOT: OFF"
end)

close.MouseButton1Click:Connect(function() sg:Destroy() end)
minBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    float.Visible = true
end)
float.MouseButton1Click:Connect(function()
    main.Visible = true
    float.Visible = false
end)

RunService.RenderStepped:Connect(updateESP)

print("✅ BIGBOY GUI Compact + Aimbot")
