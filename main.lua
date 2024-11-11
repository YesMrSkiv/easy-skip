local player = game.Players.LocalPlayer
local screenGui


local function createGUI()
    screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
   
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(0, 255, 0) 
    frame.Parent = screenGui

  
    local dragging = false
    local dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    frame.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input)
        end
    end)

    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 280, 0, 50)
    button.Position = UDim2.new(0, 10, 0, 50)
    button.Text = "Skip"
    button.TextSize = 36
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(0, 255, 0) 
    button.Font = Enum.Font.GothamBold
    button.Parent = frame

  
    button.TextStrokeTransparency = 0.5
    button.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

 
    button.MouseButton1Click:Connect(function()
        local character = player.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 0, -23)
            end
        end
        


createGUI()


player.CharacterAdded:Connect(function()

    player:WaitForChild("PlayerGui"):WaitForChild("ScreenGui"):Destroy()  
    createGUI()  
end)
