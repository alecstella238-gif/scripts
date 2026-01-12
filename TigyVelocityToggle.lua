-- Tigy Velocity Toggle (Loadstring Ready)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TigyVelocityToggle"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 130, 0, 50)
ToggleButton.Position = UDim2.new(0.05, 0, 0.8, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 120, 255)
ToggleButton.Text = "Enable Move"
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextScaled = true
ToggleButton.AutoButtonColor = false
ToggleButton.Parent = ScreenGui

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 10)
ButtonCorner.Parent = ToggleButton

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Thickness = 2
ButtonStroke.Color = Color3.fromRGB(100, 150, 255)
ButtonStroke.Parent = ToggleButton

local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(0, 60, 0, 50)
SpeedBox.Position = UDim2.new(0.05, 140, 0.8, 0)
SpeedBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.PlaceholderText = "25"
SpeedBox.Text = ""
SpeedBox.Font = Enum.Font.GothamBold
SpeedBox.TextScaled = true
SpeedBox.ClearTextOnFocus = false
SpeedBox.Parent = ScreenGui

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 10)
BoxCorner.Parent = SpeedBox

local BoxStroke = Instance.new("UIStroke")
BoxStroke.Thickness = 2
BoxStroke.Color = Color3.fromRGB(70, 70, 70)
BoxStroke.Parent = SpeedBox

local enabled = false
local moveConnection

ToggleButton.MouseButton1Click:Connect(function()
	enabled = not enabled

	if enabled then
		ToggleButton.Text = "Disable Move"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
		ButtonStroke.Color = Color3.fromRGB(255, 100, 100)

		moveConnection = RunService.Heartbeat:Connect(function()
			local character = LocalPlayer.Character
			if not character then return end

			local hrp = character:FindFirstChild("HumanoidRootPart")
			local humanoid = character:FindFirstChildOfClass("Humanoid")

			if hrp and humanoid then
				local speed = tonumber(SpeedBox.Text) or 25
				hrp.Velocity = hrp.CFrame.LookVector * speed
			end
		end)
	else
		ToggleButton.Text = "Enable Move"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 120, 255)
		ButtonStroke.Color = Color3.fromRGB(100, 150, 255)

		if moveConnection then
			moveConnection:Disconnect()
			moveConnection = nil
		end
	end
end)

SpeedBox.FocusLost:Connect(function()
	if SpeedBox.Text == "" then
		SpeedBox.Text = "25"
	end
end)
