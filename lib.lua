-->
-- Dark Lib V4
-->

-- Tables:

local lib = {}
lib.__index = lib
local miscFunctions = {}

-- Settings:
local debugEnabled = false

-- Fenv Library:
if getfenv()["DarkLibV4"] == nil then
	getfenv()["DarkLibV4"] = {
		uiLibraryAnimationPriority = {},
	}
end

local fenvLib = getfenv()["DarkLibV4"]
local uiLibraryAnimationPriority = fenvLib.uiLibraryAnimationPriority

-- Services:
local tweenService = game:GetService("TweenService")
local debris = game:GetService("Debris")
local coreGui: StarterGui = game:GetService("CoreGui")
local players = game:GetService("Players")

local player = players.LocalPlayer

-- Misc Functions:
function miscFunctions.setUILibraryVisibility(uiLib, toggled: boolean)
	if toggled == nil then
		toggled = false
	end
	
	local priorityId = {}
	uiLibraryAnimationPriority[uiLib] = priorityId
	
	if toggled then
		uiLib:WaitForChild("UI").Visible = false
		tweenService:Create(uiLib:WaitForChild("Background"), TweenInfo.new(.5), {BackgroundTransparency = 0.7}):Play()
		task.spawn(function()
			wait(.4)
			if uiLibraryAnimationPriority[uiLib] == priorityId then
				uiLibraryAnimationPriority[uiLib] = nil
				uiLib:WaitForChild("UI").Visible = true
			end
		end)
	else
		uiLib:WaitForChild("UI").Visible = true
		tweenService:Create(uiLib:WaitForChild("Background"), TweenInfo.new(.5), {BackgroundTransparency = 1}):Play()
		task.spawn(function()
			wait(.4)
			if uiLibraryAnimationPriority[uiLib] == priorityId then
				uiLibraryAnimationPriority[uiLib] = nil
				uiLib:WaitForChild("UI").Visible = false
			end
		end)
	end
	
end

-- Library Setup:
function lib.createLibrary(name: string, backgroundColor: ColorSequence?, toggleKey: Enum.KeyCode)
	
	-- Defaults:
	assert(name, "A name is required to create a ui library.")
	backgroundColor = backgroundColor or nil
	
	
	-- Clearing:
	for index, child in pairs(coreGui:GetChildren()) do
		if child.Name == "DarkLibV4" and child:IsA("ScreenGui") and child:GetAttribute("ScriptName") == name then
			debris:AddItem(child, 0)
		end
	end
	
	-- Setting Up The UI:
	local uiInterface = Instance.new("ScreenGui")
	uiInterface.Name = "DarkLibV4"
	uiInterface:SetAttribute("ScriptName", name)
	uiInterface.Enabled = false
	
	local audio = Instance.new("Folder", uiInterface)
	audio.Name = "UIAudio"
	
	--+> Audio Setup:
	do
		local ids = {
			{"Click", "rbxassetid://"}
		}
		
		for i,v in pairs(ids) do
			local new = Instance.new("Sound")
			new.Name = v[1]
			new.SoundId = v[2]
			new.Parent = audio
		end
	end
	
	
	--+> Main Frame Setup
	local uiFrame = nil
	
	do
		do
			local backgroundFrame = Instance.new("Frame")
			backgroundFrame.Name = "UI"
			backgroundFrame.ZIndex = 1
			backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
			backgroundFrame.BackgroundTransparency = 1 -- 0.7
			backgroundFrame.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
			backgroundFrame.Parent = uiInterface
			uiFrame = backgroundFrame
		end
		
		do
			local backgroundFrame = Instance.new("Frame")
			backgroundFrame.Name = "Background"
			backgroundFrame.ZIndex = 0
			backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
			backgroundFrame.BackgroundTransparency = 1 -- 0.7
			backgroundFrame.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
			backgroundFrame.Parent = uiInterface
		end
		
		do
			local userDetails = Instance.new("Frame")
			userDetails.Name = "userDetails"
			userDetails.AnchorPoint = Vector2.new(1, 0.5)
			userDetails.Size = UDim2.new(0.2617946, 0, 0.1440329, 0)
			userDetails.Position = UDim2.new(0.28, 0, 0.13, 0)
			userDetails.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

			local UICorner = Instance.new("UICorner")
			UICorner.CornerRadius = UDim.new(0, 5)
			UICorner.Parent = userDetails

			local UIGradient = Instance.new("UIGradient")
			UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
			UIGradient.Rotation = 90
			UIGradient.Color = ColorSequence.new(Color3.fromRGB(44, 44, 44), Color3.fromRGB(26, 26, 26))
			UIGradient.Parent = userDetails

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Transparency = 0.5
			UIStroke.Thickness = 2
			UIStroke.Parent = userDetails

			local WelcomeText = Instance.new("TextLabel")
			WelcomeText.Name = "WelcomeText"
			WelcomeText.Size = UDim2.new(0.7067138, 0, 0.3, 0)
			WelcomeText.BorderColor3 = Color3.fromRGB(27, 42, 53)
			WelcomeText.BackgroundTransparency = 1
			WelcomeText.Position = UDim2.new(0.254, 0, 0.2, 0)
			WelcomeText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			WelcomeText.FontSize = Enum.FontSize.Size14
			WelcomeText.TextSize = 14
			WelcomeText.TextColor3 = Color3.fromRGB(255, 255, 255)
			WelcomeText.Text = "Welcome, Player."
			WelcomeText.TextWrapped = true
			WelcomeText.Font = Enum.Font.Arcade
			WelcomeText.TextWrap = true
			WelcomeText.TextScaled = true
			WelcomeText.Parent = userDetails

			local UIGradient1 = Instance.new("UIGradient")
			UIGradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
			UIGradient1.Rotation = 90
			UIGradient1.Color = backgroundColor
			UIGradient1.Parent = WelcomeText

			local AvatarHeadshot = Instance.new("ImageLabel")
			AvatarHeadshot.Name = "AvatarHeadshot"
			AvatarHeadshot.AnchorPoint = Vector2.new(1, 0.5)
			AvatarHeadshot.Size = UDim2.new(0.2, 0, 1, 0)
			AvatarHeadshot.BackgroundTransparency = 1
			AvatarHeadshot.Position = UDim2.new(0.22, 0, 0.5, 0)
			AvatarHeadshot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			AvatarHeadshot.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=".. tostring(player) .."&width=420&height=420&format=png"
			AvatarHeadshot.Parent = userDetails

			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			UIAspectRatioConstraint.AspectRatio = 1.0107143
			UIAspectRatioConstraint.Parent = AvatarHeadshot

			local UICorner1 = Instance.new("UICorner")
			UICorner1.CornerRadius = UDim.new(0, 5)
			UICorner1.Parent = AvatarHeadshot

			local UIGradient2 = Instance.new("UIGradient")
			UIGradient2.Transparency = NumberSequence.new(0.0375, 0.55625)
			UIGradient2.Rotation = 90
			UIGradient2.Parent = AvatarHeadshot

			local ScriptName = Instance.new("TextLabel")
			ScriptName.Name = "ScriptName"
			ScriptName.Size = UDim2.new(0.7067138, 0, 0.2428571, 0)
			ScriptName.BorderColor3 = Color3.fromRGB(27, 42, 53)
			ScriptName.BackgroundTransparency = 1
			ScriptName.Position = UDim2.new(0.254417, 0, 0.5285714, 0)
			ScriptName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ScriptName.FontSize = Enum.FontSize.Size14
			ScriptName.TextSize = 14
			ScriptName.TextColor3 = Color3.fromRGB(189, 189, 189)
			ScriptName.Text = name
			ScriptName.TextWrapped = true
			ScriptName.Font = Enum.Font.Arcade
			ScriptName.TextWrap = true
			ScriptName.TextScaled = true
			ScriptName.Parent = userDetails

			local UIGradient3 = Instance.new("UIGradient")
			UIGradient3.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
			UIGradient3.Rotation = 90
			UIGradient3.Color = backgroundColor
			UIGradient3.Parent = ScriptName

			local UIAspectRatioConstraint1 = Instance.new("UIAspectRatioConstraint")
			UIAspectRatioConstraint1.AspectRatio = 4.0428572
			UIAspectRatioConstraint1.Parent = userDetails

			userDetails.Parent = game:GetService("StarterGui").ScreenGui.UI
		end
	end
	
	-- Setting Up Self:
	
	local self = {}
	self.canDoActions = true
	self.connections = {}
	
	self.interface = uiInterface
	self.uiFrame = uiFrame
	self.audio = audio
	
	self.scriptName = name
	self.backgroundColor = backgroundColor
	self.keyCode = toggleKey
	self.enabled = false
	
	setmetatable(self, lib)
	
	-- Auto-End If UI Destroyed
	self:newConnection(coreGui.ChildRemoved:Connect(function(child)
		if child == uiInterface then
			self:endScriptConnections()
		end
	end))
	
	self:newConnection(game:GetService("UserInputService").InputBegan:Connect(function(input, bg)
		if bg then
			return
		end
		
		if input.KeyCode == self.keyCode then
			self:toggleInterface(not self.enabled)
		end
	end))
	
	-- Big Frames:
	self.uiSettingsFrame = self:createBigUIFrameWithOptionsScroll("UI Settings")
	self.scriptFeaturesFrame = self:createBigUIFrameWithOptionsScroll("Script Features")
	self.scriptFeaturesFrame.Visible = true
	uiInterface.Parent = coreGui
	
	-- Option Buttons:
	local uiSettingsButton = self:createNewOptionButton("UI Settings", nil, "rbxassetid://7072721682")
	local exitScriptButton = self:createNewOptionButton("End Script", ColorSequence.new(Color3.fromRGB(255, 37, 37), Color3.fromRGB(230, 69, 69)), "rbxassetid://7072721682")
	
	self:newConnection(uiSettingsButton.MouseButton1Down:Connect(function()
		local frame = uiFrame:WaitForChild("UI_Settings")
		local frame2 = uiFrame:WaitForChild("Script_Features")
		if frame.Visible then
			frame.Visible = false
			frame2.Visible = true
		else
			frame2.Visible = false
			frame.Visible = true
		end
	end))

	
	self:newConnection(exitScriptButton.MouseButton1Down:Connect(function()
		self:endScriptWithAnimation()
	end))
	
	task.spawn(function()
		wait(.6)
		uiInterface.Enabled = true
	end)
	
	return self
end
	
function lib:createBigUIFrameWithOptionsScroll(name)
	local uiBigFrameTemplateWithOptions = Instance.new("Frame")
	uiBigFrameTemplateWithOptions.Name = string.gsub(name, " ", "_")
	uiBigFrameTemplateWithOptions.Visible = false
	uiBigFrameTemplateWithOptions.Size = UDim2.new(0.692877, 0, 0.9214404, 0)
	uiBigFrameTemplateWithOptions.Position = UDim2.new(0.2969473, 0, 0.0579835, 0)
	uiBigFrameTemplateWithOptions.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	uiBigFrameTemplateWithOptions.Visible = false

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 5)
	UICorner.Parent = uiBigFrameTemplateWithOptions

	local UIGradient = Instance.new("UIGradient")
	UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient.Rotation = 90
	UIGradient.Color = ColorSequence.new(Color3.fromRGB(44, 44, 44), Color3.fromRGB(26, 26, 26))
	UIGradient.Parent = uiBigFrameTemplateWithOptions

	local UIStroke = Instance.new("UIStroke")
	UIStroke.Transparency = 0.5
	UIStroke.Thickness = 2
	UIStroke.Parent = uiBigFrameTemplateWithOptions

	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.Size = UDim2.new(0.7067138, 0, 0.0746639, 0)
	Title.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Title.BackgroundTransparency = 1
	Title.Position = UDim2.new(0.1458558, 0, 0.0168907, 0)
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.FontSize = Enum.FontSize.Size14
	Title.TextSize = 14
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.Text = name
	Title.TextWrapped = true
	Title.Font = Enum.Font.Arcade
	Title.TextWrap = true
	Title.TextScaled = true
	Title.Parent = uiBigFrameTemplateWithOptions

	local UIGradient1 = Instance.new("UIGradient")
	UIGradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient1.Rotation = 90
	UIGradient1.Color = self.backgroundColor
	UIGradient1.Parent = Title

	local Options = Instance.new("ScrollingFrame")
	Options.Name = "Options"
	Options.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Options.BorderSizePixel = 0
	Options.ScrollBarThickness = 3
	Options.ScrollBarImageColor3 = Color3.new(1,1,1)
	Options.AnchorPoint = Vector2.new(0.5, 0)
	Options.Size = UDim2.new(0.9668456, 0, 0.8703133, 0)
	Options.BackgroundTransparency = 1
	Options.Position = UDim2.new(0.5, 0, 0.1205842, 0)
	Options.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Options.Parent = uiBigFrameTemplateWithOptions

	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0.03, 0)
	UIListLayout.Parent = Options

	uiBigFrameTemplateWithOptions.Parent = self.uiFrame
	return uiBigFrameTemplateWithOptions
end	

function lib:newConnection(connection: RBXScriptConnection)
	table.insert(self.connections, connection)
end

function lib:createNewOptionButton(text: string, color: ColorSequence, icon: string)
	local OptionButton = Instance.new("Frame")
	OptionButton.Name = string.gsub(text, " ", "_")
	OptionButton.AnchorPoint = Vector2.new(0, 1)
	OptionButton.Size = UDim2.new(1, 0, 0.15, 0)
	OptionButton.Position = UDim2.new(0.018, 0, 0.88, 0)
	OptionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 5)
	UICorner.Parent = OptionButton

	local UIGradient = Instance.new("UIGradient")
	UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient.Rotation = 90
	UIGradient.Color = ColorSequence.new(Color3.fromRGB(44, 44, 44), Color3.fromRGB(26, 26, 26))
	UIGradient.Parent = OptionButton

	local UIStroke = Instance.new("UIStroke")
	UIStroke.Transparency = 0.5
	UIStroke.Thickness = 2
	UIStroke.Parent = OptionButton

	local ImageLabel = Instance.new("ImageLabel")
	ImageLabel.AnchorPoint = Vector2.new(1, 0.5)
	ImageLabel.Size = UDim2.new(0.17, 0, 1, 0)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.Position = UDim2.new(0.2, 0, 0.5, 0)
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.Image = icon
	ImageLabel.Parent = OptionButton

	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint.AspectRatio = 1.0107143
	UIAspectRatioConstraint.Parent = ImageLabel

	local UICorner1 = Instance.new("UICorner")
	UICorner1.CornerRadius = UDim.new(0, 5)
	UICorner1.Parent = ImageLabel

	local UIGradient1 = Instance.new("UIGradient")
	UIGradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient1.Rotation = 90
	UIGradient1.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(64, 166, 230))
	UIGradient1.Parent = ImageLabel

	local TextLabel = Instance.new("TextLabel")
	TextLabel.AnchorPoint = Vector2.new(0, 0.5)
	TextLabel.Size = UDim2.new(0.707, 0, 0.7, 0)
	TextLabel.BorderColor3 = Color3.fromRGB(27, 42, 53)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Position = UDim2.new(0.254, 0, 0.5, 0)
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.FontSize = Enum.FontSize.Size14
	TextLabel.TextSize = 14
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.Text = text
	TextLabel.TextWrapped = true
	TextLabel.Font = Enum.Font.Arcade
	TextLabel.TextWrap = true
	TextLabel.TextScaled = true
	TextLabel.Parent = OptionButton

	local UIGradient2 = Instance.new("UIGradient")
	UIGradient2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient2.Rotation = 90
	UIGradient2.Color = (color or self.backgroundColor)
	UIGradient2.Parent = TextLabel

	local TextButton = Instance.new("TextButton")
	TextButton.Size = UDim2.new(1, 0, 1, 0)
	TextButton.BackgroundTransparency = 1
	TextButton.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
	TextButton.FontSize = Enum.FontSize.Size14
	TextButton.TextTransparency = 1
	TextButton.TextSize = 14
	TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.Font = Enum.Font.SourceSans
	TextButton.Parent = OptionButton

	local UICorner2 = Instance.new("UICorner")
	UICorner2.CornerRadius = UDim.new(0, 5)
	UICorner2.Parent = TextButton
	
	self:handleMouseHover(OptionButton)
	
	return TextButton
end

function lib:handleMouseHover(bg: Frame)
	local button = bg:FindFirstChildOfClass("TextButton")
	
	if button then
		button.MouseEnter:Connect(function()
			tweenService:Create(bg, TweenInfo.new(.5), {BackgroundColor3 = Color3.fromRGB(152, 152, 152)}):Play()
		end)
		button.MouseLeave:Connect(function()
			tweenService:Create(bg, TweenInfo.new(.5), {BackgroundColor3 = Color3.fromRGB(255,255,255)}):Play()
		end)
		button.MouseButton1Down:Connect(function()
			self.audio.Click:Play()
		end)
	end
end

function lib:endScriptConnections()
	self.canDoActions = false
	for i,v in pairs(self.connections) do
		if typeof(v) == "RBXScriptConnection" then
			v:Disconnect()
		end
	end
end

function lib:endScriptWithAnimation()
	self.canDoActions = false
	self:toggleInterface(false)
	debris:AddItem(self.interface, .6)
end

function lib:toggleInterface(toggled: boolean)
	self.enabled = toggled
	return miscFunctions.setUILibraryVisibility(self.interface, toggled)
end

return lib
