-->
-- Dark Lib V4
-- _dark#9619
-->

--[[
TODO:
* Color Picker
* Key Bind
]]--

-- Tables:

local lib = {}
lib.__index = lib
local categories = {}
categories.__index = categories

local miscFunctions = {}

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
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local uis = game:GetService("UserInputService")

local player = players.LocalPlayer
local mouse = player:GetMouse()

-- Misc Functions:
function miscFunctions.setUILibraryVisibility(uiLib, toggled)
	if toggled == nil then
		toggled = false
	end
	
	local priorityId = {}
	uiLibraryAnimationPriority[uiLib] = priorityId
	
	if toggled then
		uiLib:WaitForChild("UI").Visible = true
		tweenService:Create(uiLib:WaitForChild("Background"), TweenInfo.new(.6), {BackgroundTransparency = 0.5}):Play()
		--task.spawn(function()
		--	wait(.15)
		--	if uiLibraryAnimationPriority[uiLib] == priorityId then
		--		uiLibraryAnimationPriority[uiLib] = nil
		--		uiLib:WaitForChild("UI").Visible = true
		--	end
		--end)
	else
		uiLib:WaitForChild("UI").Visible = false
		tweenService:Create(uiLib:WaitForChild("Background"), TweenInfo.new(.6), {BackgroundTransparency = 1}):Play()
	end
	
end

-- Library Setup:
function lib.createLibrary(name, toggleKey, backgroundColor, textFont)
	
	-- Defaults:
	textFont = textFont or Enum.Font.Jura
	assert(name, "A name is required to create a ui library.")
	backgroundColor = backgroundColor or ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(64, 166, 230))
	
	
	-- Clearing:
	for index, child in pairs(coreGui:GetChildren()) do
		if child.Name == "DarkLibV4" and child:IsA("ScreenGui") and child:GetAttribute("ScriptName") == name then
			debris:AddItem(child, 0)
		end
	end
	
	-- Setting Up The UI:
	local uiInterface = Instance.new("ScreenGui")
	uiInterface.Name = "DarkLibV4"
	uiInterface.IgnoreGuiInset = true
	uiInterface.DisplayOrder = 10000
	uiInterface:SetAttribute("ScriptName", name)
	uiInterface.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	uiInterface.Enabled = false
	
	local audio = Instance.new("Folder", uiInterface)
	audio.Name = "Audio"
	
	--+> Audio Setup:
	do
		local ids = {
			{"Click", "rbxassetid://3848738002", {Volume = .6}},
			{"Open", "rbxassetid://3785107916", {Volume = .5}},
			{"Close", "rbxassetid://3932634866", {Volume = .5}},
			{"ToggleOn", "rbxassetid://3848738002", {Volume = .6}},
			{"ToggleOff", "rbxassetid://3848738002", {Volume = .5, PlaybackSpeed = 0.8}},
		}
		
		for i,v in pairs(ids) do
			local new = Instance.new("Sound")
			new.Name = v[1]
			new.SoundId = v[2]
			for i,v in pairs(v[3]) do
				new[i]=v
			end
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
			backgroundFrame.AnchorPoint = Vector2.new(.5,.5)
			backgroundFrame.Position = UDim2.new(.5,0,.5,0)
			backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
			backgroundFrame.BackgroundTransparency = 1 -- 0.7
			backgroundFrame.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
			backgroundFrame.Visible = false
			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			UIAspectRatioConstraint.AspectRatio = 2.2242799
			UIAspectRatioConstraint.Parent = backgroundFrame
			
			local ImageLabel = Instance.new("ImageLabel")
			ImageLabel.ZIndex = -1
			ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			ImageLabel.Size = UDim2.new(2, 0, 2, 0)
			ImageLabel.BackgroundTransparency = 1
			ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
			ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageLabel.ScaleType = Enum.ScaleType.Tile
			ImageLabel.TileSize = UDim2.new(0, 15, 0, 15)
			ImageLabel.Image = "rbxassetid://9940394650"
			ImageLabel.ImageTransparency = .98
			ImageLabel.Parent = backgroundFrame
			
			uiFrame = backgroundFrame
			backgroundFrame.Parent = uiInterface
			
			local Frame = Instance.new("Frame")
			Frame.Name = "Bottom"
			Frame.Size = UDim2.new(10, 0, 10, 0)
			Frame.BackgroundTransparency = 0
			Frame.Position = UDim2.new(0, 0, 1, 0)
			Frame.BorderSizePixel = 0
			Frame.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Frame.Parent = backgroundFrame
			local UIGradient = Instance.new("UIGradient")
			UIGradient.Rotation = -20
			UIGradient.Color = ColorSequence.new(Color3.fromRGB(50, 50, 50), Color3.fromRGB(29, 29, 29))
			UIGradient.Parent = Frame
			local Frame = Instance.new("Frame")
			Frame.Size = UDim2.new(10, 0, 10, 0)
			Frame.BackgroundTransparency = 0
			Frame.AnchorPoint = Vector2.new(0, 1)
			Frame.Name = "Top"
			Frame.Position = UDim2.new(0, 0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Frame.Parent = backgroundFrame
			local UIGradient = Instance.new("UIGradient")
			UIGradient.Rotation = 20
			UIGradient.Color = ColorSequence.new(Color3.fromRGB(50, 50, 50), Color3.fromRGB(29, 29, 29))
			UIGradient.Parent = Frame
		end
		
		do
			local backgroundFrame = Instance.new("Frame")
			backgroundFrame.Name = "Background"
			backgroundFrame.ZIndex = 0
			backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
			backgroundFrame.BackgroundTransparency = 1 -- 0.7
			backgroundFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
			backgroundFrame.Parent = uiInterface
		end
		
		do
			local Options = Instance.new("Frame")
			Options.Name = "Options"
			Options.AnchorPoint = Vector2.new(0, 1)
			Options.Size = UDim2.new(0.147086, 0, 0.4506173, 0)
			Options.BackgroundTransparency = 1
			Options.Position = UDim2.new(.018, 0, .971, 0)
			Options.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0.03, 0)
			UIListLayout.Parent = Options
			Options.Parent = uiFrame
		end
		
		do
			local userDetails = Instance.new("Frame")
			userDetails.Name = "UserDetails"
			userDetails.AnchorPoint = Vector2.new(1, 0)
			userDetails.Size = UDim2.new(0.2617946, 0, 0.1440329, 0)
			userDetails.Position = UDim2.new(0.28, 0, 0.03, 0)
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
			WelcomeText.Text = "Welcome, ".. player.DisplayName .. "."
			WelcomeText.TextWrapped = true
			WelcomeText.Font = textFont
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
			AvatarHeadshot.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=".. tostring(player.UserId) .."&width=420&height=420&format=png"
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
			ScriptName.Font = textFont
			ScriptName.TextWrap = true
			ScriptName.TextScaled = true
			ScriptName.Parent = userDetails

			local UIGradient3 = Instance.new("UIGradient")
			UIGradient3.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
			UIGradient3.Rotation = 90
			UIGradient3.Color = backgroundColor
			UIGradient3.Parent = ScriptName

			--local UIAspectRatioConstraint1 = Instance.new("UIAspectRatioConstraint")
			--UIAspectRatioConstraint1.AspectRatio = 4.0428572
			--UIAspectRatioConstraint1.Parent = userDetails

			userDetails.Parent = uiFrame
		end
	end
	
	-- Setting Up Self:
	
	local self = {}
	self.canDoActions = true
	self.connections = {}
	self.latestCategory = nil
	self.categoryCount = 0
	
	self.interface = uiInterface
	self.textFont = textFont
	self.uiFrame = uiFrame
	self.audio = audio
	
	self.scriptName = name
	self.backgroundColor = backgroundColor
	self.keyCode = toggleKey
	self.enabled = false
	self.queue = {}
	
	self._e = Instance.new("BindableEvent")
	self.ended = self._e.Event
	
	setmetatable(self, lib)
	
	-- Auto-End If UI Destroyed
	self:newConnection(coreGui.ChildRemoved:Connect(function(child)
		if child == uiInterface then
			self:endScriptConnections()
		end
	end))
	
	-- Toggle UI
	self:newConnection(uis.InputBegan:Connect(function(input, bg)
		if bg then
			return
		end
		if self.canDoActions == false then
			return
		end
		
		if input.KeyCode == self.keyCode then
			self:toggleInterface(not self.enabled)
		end
	end))
	
	-- Big Frames:
	self.scriptFeaturesFrame = self:createBigUIFrameWithOptionsScroll("Script Features", name)
	self.scriptFeaturesFrame.Visible = true
	uiInterface.Parent = coreGui
	
	-- Setting up script features:
	do
		local scriptFeatures = self.scriptFeaturesFrame
		local options = scriptFeatures.Options
		
		options.Size = UDim2.new(.967, 0, 0.832, 0)
		options.Position =  UDim2.new(.5, 0, .159, 0)
		
		local Categories = Instance.new("ScrollingFrame")
		Categories.Name = "Categories"
		Categories.SelectionGroup = false
		Categories.Selectable = false
		Categories.AnchorPoint = Vector2.new(0.5, 0)
		Categories.Size = UDim2.new(0.9668456, 0, 0.0584281, 0)
		Categories.BackgroundTransparency = 1
		Categories.Position = UDim2.new(0.5, 0, 0.09, 0)
		Categories.BorderSizePixel = 0
		Categories.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Categories.AutomaticCanvasSize = Enum.AutomaticSize.X
		Categories.CanvasSize = UDim2.new(0, 0, 0, 0)
		Categories.ScrollBarImageColor3 = Color3.fromRGB(85, 170, 255)
		Categories.ScrollBarThickness = 0

		local UIListLayout = Instance.new("UIListLayout")
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 5)
		UIListLayout.Parent = Categories

		local InvisStart = Instance.new("Frame")
		InvisStart.Name = "InvisStart"
		InvisStart.Size = UDim2.new(0.005, 0, 1, 0)
		InvisStart.BackgroundTransparency = 1
		InvisStart.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		InvisStart.Parent = Categories
		
		Categories.Parent = scriptFeatures
	end
	
	-- Action Button:
	do
		local buttonFrame, button = self:createNewOptionButton("Rejoin Game", nil, "rbxassetid://7072721188")
		buttonFrame.Parent = uiFrame.Options

		button.MouseButton1Down:Connect(function()
			self:createNotification("Rejoining...")
			game:GetService("TeleportService"):Teleport(game.PlaceId, player)
		end)
	end
	
	do
		local buttonFrame, button = self:createNewOptionButton("Server Hop", nil, "rbxassetid://7072721188")
		buttonFrame.Parent = uiFrame.Options
		
		button.MouseButton1Down:Connect(function()
			self:createNotification("Server hopping...")
			
			if not game.HttpGetAsync then
				return self:createNotification("Your executor is incompatible.")
			end
			local x = {}
			for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
				if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
					x[#x + 1] = v.id
				end
			end
			if #x > 0 then
				game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
			else
				self:createNotification("Couldn't find any other servers! Please try again later.")
			end
		end)
	end
	
	do
		local exitScriptButton, exitScriptClick = self:createNewOptionButton("End Script", ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(230, 69, 69)), "rbxassetid://7072718459")
		exitScriptButton.Parent = uiFrame.Options

		local latest = {}
		self:newConnection(exitScriptClick.MouseButton1Down:Connect(function()
			local c = "[ Confirm ]"
			if exitScriptButton.TextLabel.Text == c then
				self:endScriptWithAnimation()
				return
			end

			local id = {}
			latest = id
			exitScriptButton.TextLabel.Text = c
			task.spawn(function()
				wait(2)
				if latest == id then
					exitScriptButton.TextLabel.Text = "End Script"
				end
			end)
		end))
	end
	
	-- UI Setting
	local uiSettingsCategory = self:createCategory("⚙", true, true)
	uiSettingsCategory:createLabel("DarkLib v4.0 Configuration:")
	local streamerMode = uiSettingsCategory:createToggle("> Streamer Mode")
	uiSettingsCategory:createButton("> Force Stop Script"):Connect(function()
		debris:AddItem(uiInterface, 0)
	end)
	uiSettingsCategory:createLabel("Developers:")
	uiSettingsCategory:createLabel("> _dark - UI Designer & Scripter  ")
	uiSettingsCategory:createLabel("> Paladinzzz2 - Sound Effects  ")

	uiSettingsCategory.button.TextLabel.Position = UDim2.new(0,0,.12,0)
	streamerMode:Connect(function(value)
		if value then
			uiFrame.UserDetails.AvatarHeadshot.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=559550224&width=420&height=420&format=png"
			uiFrame.UserDetails.WelcomeText.Text = "Welcome!"
		else
			uiFrame.UserDetails.AvatarHeadshot.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..tostring(player.UserId) .."&width=420&height=420&format=png"
			uiFrame.UserDetails.WelcomeText.Text = "Welcome, ".. player.DisplayName .. "."
		end
	end)
	
	self.uiSettingsCategory = uiSettingsCategory
	
	-- Enabling:
	
	task.spawn(function()
		wait(.6)
		uiInterface.Enabled = true
	end)
	
	return self
end


function lib:createCategory(name, doNotIncreaseCount, doNotAddSpaces)
	local categorySelf = {}	
	categorySelf.id = tostring(math.random())
	categorySelf.name = name
	categorySelf.currentDropdownFrame = nil
	categorySelf.realSelf = self
	local realSelf = categorySelf.realSelf
	if doNotIncreaseCount ~= true then
		realSelf.categoryCount +=1
		if realSelf.categoryCount == 1 then
			realSelf.latestCategory = categorySelf.id
			realSelf:refreshCategoriesVisibility()
		end
	end
	
	
	local scriptFeaturesFrame = realSelf.scriptFeaturesFrame
	local categoriesFrame = scriptFeaturesFrame.Categories
	local optionsFrame = scriptFeaturesFrame.Options

	local optionsFolder = nil
	local categoryButton = nil
	
	categorySelf.container = optionsFolder
	
	if realSelf.uiSettingsCategory then
		realSelf.uiSettingsCategory.button.Parent = nil
	end
	
	do
		local categoryFolder = Instance.new("Folder")
		categoryFolder.Name = categorySelf.id
		
		categorySelf.folder = categoryFolder
		
		local uiListLayout = Instance.new("UIListLayout")
		uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
		uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		uiListLayout.Padding = UDim.new(0, 5)
		uiListLayout.Parent = categoryFolder
		
		local InvisStart = Instance.new("Frame")
		InvisStart.Name = "InvisStart"
		InvisStart.Size = UDim2.new(1, 0, 0.01, 0)
		InvisStart.BackgroundTransparency = 1
		InvisStart.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		InvisStart.Parent = categoryFolder
		
		categoryFolder.Parent = optionsFrame
		categorySelf.container = categoryFolder
	end
	
	do
		local CategoryButton = Instance.new("Frame")
		CategoryButton.Name = categorySelf.id
		CategoryButton.AnchorPoint = Vector2.new(0, 1)
		CategoryButton.AutomaticSize = Enum.AutomaticSize.X
		CategoryButton.Size = UDim2.new(0, 60, 0.9, 0)
		CategoryButton.Position = UDim2.new(0.018, 0, 0.88, 0)
		CategoryButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		
		categorySelf.button = CategoryButton
		local UICorner = Instance.new("UICorner")
		UICorner.CornerRadius = UDim.new(0, 5)
		UICorner.Parent = CategoryButton

		local UIGradient = Instance.new("UIGradient")
		UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
		UIGradient.Rotation = 90
		UIGradient.Color = ColorSequence.new(Color3.fromRGB(44, 44, 44), Color3.fromRGB(26, 26, 26))
		UIGradient.Parent = CategoryButton

		local UIStroke = Instance.new("UIStroke")
		UIStroke.Transparency = 0.5
		UIStroke.Parent = CategoryButton

		local TextLabel = Instance.new("TextLabel")
		TextLabel.AutomaticSize = Enum.AutomaticSize.X
		TextLabel.Size = UDim2.new(1, 0, 0.8, 0)
		TextLabel.BorderColor3 = Color3.fromRGB(27, 42, 53)
		TextLabel.BackgroundTransparency = 1
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.FontSize = Enum.FontSize.Size14
		TextLabel.TextSize = 14
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.Text = doNotAddSpaces ~= true and (" ".. name .. " ") or name
		TextLabel.TextWrapped = true
		TextLabel.Font = realSelf.textFont
		TextLabel.TextWrap = true
		TextLabel.TextScaled = true
		TextLabel.Parent = CategoryButton

		local UIGradient1 = Instance.new("UIGradient")
		UIGradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
		UIGradient1.Rotation = 90
		UIGradient1.Color = realSelf.backgroundColor
		UIGradient1.Parent = TextLabel

		local TextButton = Instance.new("TextButton")
		TextButton.Size = UDim2.new(1, 0, 1, 0)
		TextButton.BackgroundTransparency = 1
		TextButton.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
		TextButton.FontSize = Enum.FontSize.Size14
		TextButton.TextTransparency = 1
		TextButton.TextSize = 14
		TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		TextButton.Font = Enum.Font.SourceSans
		TextButton.Parent = CategoryButton

		local UICorner1 = Instance.new("UICorner")
		UICorner1.CornerRadius = UDim.new(0, 5)
		UICorner1.Parent = TextButton
		
		categoryButton = CategoryButton
		CategoryButton.Parent = categoriesFrame
		realSelf:handleMouseHover(CategoryButton, true)
		
		TextButton.MouseButton1Down:Connect(function()
			if categorySelf.id ~= realSelf.latestCategory then
				realSelf.audio.Click:Play()
				realSelf.latestCategory = categorySelf.id
				realSelf:refreshCategoriesVisibility()
			end
		end)
	end
	
	
	if realSelf.uiSettingsCategory then
		realSelf.uiSettingsCategory.button.Parent = categoriesFrame
	end
	realSelf:refreshCategoriesVisibility()
	setmetatable(categorySelf, categories)
	return categorySelf
end

function lib:createNotification(desc, scaled)
	if scaled == nil then
		scaled = false
	end
	task.spawn(function()
		for i,v in pairs(self.uiFrame:GetChildren()) do
			if v.Name == "Notification" then
				v:Destroy()
			end
		end
		local Notification = Instance.new("Frame")
		Notification.Name = "Notification"
		Notification.AnchorPoint = Vector2.new(1, 1)
		Notification.Size = UDim2.new(0.1978408, 0, 0.1442927, 0)
		Notification.Position = UDim2.new(0, 0, 0.3698229, 0)
		Notification.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

		local UICorner = Instance.new("UICorner")
		UICorner.CornerRadius = UDim.new(0, 5)
		UICorner.Parent = Notification

		local UIGradient = Instance.new("UIGradient")
		UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
		UIGradient.Rotation = 90
		UIGradient.Color = ColorSequence.new(Color3.fromRGB(44, 44, 44), Color3.fromRGB(26, 26, 26))
		UIGradient.Parent = Notification

		local UIStroke = Instance.new("UIStroke")
		UIStroke.Transparency = 0.5
		UIStroke.Thickness = 2
		UIStroke.Parent = Notification

		local Title = Instance.new("TextLabel")
		Title.Name = "Title"
		Title.AnchorPoint = Vector2.new(0.5, 0)
		Title.Size = UDim2.new(0.7067138, 0, 0.1997854, 0)
		Title.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Title.BackgroundTransparency = 1
		Title.Position = UDim2.new(0.5, 0, 0.07, 0)
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.FontSize = Enum.FontSize.Size14
		Title.TextSize = 14
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.Text = "Notification:"
		Title.TextWrapped = true
		Title.Font = Enum.Font.Arcade
		Title.TextWrap = true
		Title.TextScaled = true 
		Title.Parent = Notification

		local UIGradient1 = Instance.new("UIGradient")
		UIGradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
		UIGradient1.Rotation = 90
		UIGradient1.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(64, 166, 230))
		UIGradient1.Parent = Title

		local Desc = Instance.new("TextLabel")
		Desc.Name = "Desc"
		Desc.AnchorPoint = Vector2.new(0.5, 0)
		Desc.Size = UDim2.new(0.9250332, 0, 0.5616415, 0)
		Desc.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Desc.BackgroundTransparency = 1
		Desc.Position = UDim2.new(0.5, 0, 0.3305362, 0)
		Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Desc.FontSize = Enum.FontSize.Size10
		Desc.TextTruncate = Enum.TextTruncate.AtEnd
		Desc.TextSize = 10
		Desc.TextColor3 = Color3.fromRGB(181, 181, 181)
		Desc.Text = desc
		Desc.TextYAlignment = Enum.TextYAlignment.Top
		Desc.TextWrapped = true
		Desc.Font = Enum.Font.Arcade
		Desc.TextWrap = true
		Desc.TextScaled = scaled 
		Desc.TextXAlignment = Enum.TextXAlignment.Center
		Desc.Parent = Notification
		if scaled then
			Desc.TextYAlignment = Enum.TextYAlignment.Center
			Desc.TextXAlignment = Enum.TextXAlignment.Center
		end

		local UIGradient2 = Instance.new("UIGradient")
		UIGradient2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
		UIGradient2.Rotation = 90
		UIGradient2.Color = self.backgroundColor
		UIGradient2.Offset = Vector2.new(0, -.3)
		UIGradient2.Parent = Desc

		Notification.Parent = self.uiFrame
		pcall(function()
			Desc.TextSize = Desc.AbsoluteSize.X * 0.06
			tweenService:Create(Notification, TweenInfo.new(.3), {Position = UDim2.new(.215,0,.37,0)}):Play()
			wait(2)
			tweenService:Create(Notification, TweenInfo.new(.3), {Position = UDim2.new(0,0,.37,0)}):Play()
			debris:AddItem(Notification, .35)
		end)
	end)
end

function categories:createToggle(text, default)
	if default == nil then
		default = false
	end
	local Label = Instance.new("Frame")
	Label.Name = "Toggle_"..string.gsub(text, " ", "_")
	Label.AnchorPoint = Vector2.new(1, 0)
	Label.Size = UDim2.new(0.99, 0, 0.06, 0)
	Label.Position = UDim2.new(0.2792669, 0, 0.0566183, 0)
	Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 5)
	UICorner.Parent = Label

	local UIGradient = Instance.new("UIGradient")
	UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient.Rotation = 90
	UIGradient.Color = ColorSequence.new(Color3.fromRGB(44, 44, 44), Color3.fromRGB(26, 26, 26))
	UIGradient.Parent = Label

	local Image = Instance.new("ImageLabel")
	Image.Name = "Image"
	Image.AnchorPoint = Vector2.new(1, 0.5)
	Image.Size = UDim2.new(0.05, 0, 0.9, 0)
	Image.BackgroundTransparency = 1
	Image.Position = UDim2.new(1, 0, 0.5, 0)
	Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Image.ScaleType = Enum.ScaleType.Fit
	Image.ImageTransparency = 0.5
	Image.Image = ""
	Image.Parent = Label
	
	local UIGradient1 = Instance.new("UIGradient")
	UIGradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient1.Rotation = 90
	UIGradient1.Color = (self.realSelf.backgroundColor)
	UIGradient1.Parent = Image
	
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Transparency = 0.5
	UIStroke.Parent = Label

	local Label1 = Instance.new("TextLabel")
	Label1.Name = "Label"
	Label1.AnchorPoint = Vector2.new(0.5, 0.5)
	Label1.Size = UDim2.new(0.95, 0, 0.8, 0)
	Label1.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Label1.BackgroundTransparency = 1
	Label1.Position = UDim2.new(0.482, 0, 0.5, 0)
	Label1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Label1.FontSize = Enum.FontSize.Size14
	Label1.TextSize = 14
	Label1.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label1.Text = text
	Label1.TextWrapped = true
	Label1.Font = self.realSelf.textFont
	Label1.TextWrap = true
	Label1.TextScaled = true
	Label1.Parent = Label
	Label1.TextXAlignment = Enum.TextXAlignment.Left
	
	local UIGradient1 = Instance.new("UIGradient")
	UIGradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient1.Rotation = 90
	UIGradient1.Color = self.realSelf.backgroundColor
	UIGradient1.Parent = Label1

	local Click = Instance.new("TextButton")
	Click.Name = "Click"
	Click.Size = UDim2.new(1, 0, 1, 0)
	Click.BackgroundTransparency = 1
	Click.TextTransparency = 1
	Click.ZIndex = 2
	Click.Parent = Label

	Label.Parent = self.container
	
	local value = default
	local ev = Instance.new("BindableEvent")
	
	local function update()
		Image.Image = value and "rbxassetid://7072706576" or "rbxassetid://7072725299"
		ev:Fire(value)
	end	
	
	update()
	
	self.realSelf:newConnection(Click.MouseButton1Down:Connect(function()
		value = not value
		update()
		if value then
			self.realSelf.audio.ToggleOn:Play()
		else
			self.realSelf.audio.ToggleOff:Play()
		end
	end))
	
	self.realSelf:handleMouseHover(Label, true, Click)
	self.realSelf:refreshCategoriesVisibility()
	
	return ev.Event, function(new)
		value = new
		update()
	end, Label
end
function categories:createButton(text)
	local Label = Instance.new("Frame")
	Label.Name = "Button_"..string.gsub(text, " ", "_")
	Label.AnchorPoint = Vector2.new(1, 0)
	Label.Size = UDim2.new(0.99, 0, 0.06, 0)
	Label.Position = UDim2.new(0.2792669, 0, 0.0566183, 0)
	Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 5)
	UICorner.Parent = Label

	local UIGradient = Instance.new("UIGradient")
	UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient.Rotation = 90
	UIGradient.Color = ColorSequence.new(Color3.fromRGB(44, 44, 44), Color3.fromRGB(26, 26, 26))
	UIGradient.Parent = Label
	
	local Image = Instance.new("ImageLabel")
	Image.Name = "Image"
	Image.AnchorPoint = Vector2.new(1, 0.5)
	Image.Size = UDim2.new(0.05, 0, 0.9, 0)
	Image.BackgroundTransparency = 1
	Image.Position = UDim2.new(1, 0, 0.5, 0)
	Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Image.ScaleType = Enum.ScaleType.Fit
	Image.ImageTransparency = 0.5
	Image.Image = "rbxassetid://7072719587"
	Image.Parent = Label
	
	local UIGradient1 = Instance.new("UIGradient")
	UIGradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient1.Rotation = 90
	UIGradient1.Color = (self.realSelf.backgroundColor)
	UIGradient1.Parent = Image
	
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Transparency = 0.5
	UIStroke.Parent = Label

	local Label1 = Instance.new("TextLabel")
	Label1.Name = "Label"
	Label1.AnchorPoint = Vector2.new(0.5, 0.5)
	Label1.Size = UDim2.new(0.95, 0, 0.8, 0)
	Label1.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Label1.BackgroundTransparency = 1
	Label1.Position = UDim2.new(0.482, 0, 0.5, 0)
	Label1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Label1.FontSize = Enum.FontSize.Size14
	Label1.TextSize = 14
	Label1.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label1.Text = text
	Label1.TextWrapped = true
	Label1.Font = self.realSelf.textFont
	Label1.TextWrap = true
	Label1.TextScaled = true
	Label1.Parent = Label
	Label1.TextXAlignment = Enum.TextXAlignment.Left

	local UIGradient1 = Instance.new("UIGradient")
	UIGradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient1.Rotation = 90
	UIGradient1.Color = self.realSelf.backgroundColor
	UIGradient1.Parent = Label1
	
	local Click = Instance.new("TextButton")
	Click.Name = "Click"
	Click.Size = UDim2.new(1, 0, 1, 0)
	Click.BackgroundTransparency = 1
	Click.TextTransparency = 1
	Click.ZIndex = 2
	Click.Parent = Label
	
	Label.Parent = self.container
	self.realSelf:handleMouseHover(Label, nil, Click)
	self.realSelf:refreshCategoriesVisibility()
	return Click.MouseButton1Down, Label
end

function categories:createBox(text, clearAfterSubmit)
	if clearAfterSubmit == nil then
		clearAfterSubmit = true
	end
	
	local Label = Instance.new("Frame")
	Label.Name = "Box_"..string.gsub(text, " ", "_")
	Label.AnchorPoint = Vector2.new(1, 0)
	Label.Size = UDim2.new(0.99, 0, 0.06, 0)
	Label.Position = UDim2.new(0.2792669, 0, 0.0566183, 0)
	Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 5)
	UICorner.Parent = Label

	local UIGradient = Instance.new("UIGradient")
	UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient.Rotation = 90
	UIGradient.Color = ColorSequence.new(Color3.fromRGB(44, 44, 44), Color3.fromRGB(26, 26, 26))
	UIGradient.Parent = Label

	local UIStroke = Instance.new("UIStroke")
	UIStroke.Transparency = 0.5
	UIStroke.Parent = Label

	local fakeBox = Instance.new("TextLabel")
	fakeBox.Name = "fake"
	fakeBox.AnchorPoint = Vector2.new(0.5, 0.5)
	fakeBox.Size = UDim2.new(0.95, 0, 0.8, 0)
	fakeBox.BorderColor3 = Color3.fromRGB(27, 42, 53)
	fakeBox.BackgroundTransparency = 1
	fakeBox.Position = UDim2.new(0.482, 0, 0.5, 0)
	fakeBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	fakeBox.FontSize = Enum.FontSize.Size14
	fakeBox.TextSize = 14
	fakeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	fakeBox.Text = ""
	fakeBox.TextWrapped = true
	fakeBox.Font = self.realSelf.textFont
	fakeBox.TextWrap = true
	fakeBox.TextScaled = true
	fakeBox.TextXAlignment = Enum.TextXAlignment.Left
	fakeBox.Parent = Label
	
	local Underline = Instance.new("Frame")
	Underline.Name = "Underline"
	Underline.AnchorPoint = Vector2.new(0, 0)
	Underline.Size = UDim2.new(0, 250, 0.02, 0)
	Underline.BackgroundTransparency = 1
	Underline.Position = UDim2.new(0, 0, 1, 0)
	Underline.BorderSizePixel = 0
	Underline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Underline.Parent = fakeBox
	
	local UIGradient1 = Instance.new("UIGradient")
	UIGradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient1.Rotation = 90
	UIGradient1.Color = (self.realSelf.backgroundColor)
	UIGradient1.Parent = Underline
	
	local Label1 = Instance.new("TextBox")
	Label1.Name = "Label"
	Label1.AnchorPoint = Vector2.new(0.5, 0.5)
	Label1.Size = UDim2.new(0.95, 0, 0.8, 0)
	Label1.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Label1.BackgroundTransparency = 1
	Label1.Position = UDim2.new(0.482, 0, 0.5, 0)
	Label1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Label1.FontSize = Enum.FontSize.Size14
	Label1.TextSize = 14
	Label1.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label1.Text = ""
	Label1.ClearTextOnFocus = false
	Label1.PlaceholderText = text
	Label1.TextTransparency = 1
	Label1.TextWrapped = true
	Label1.Font = self.realSelf.textFont
	Label1.TextWrap = true
	Label1.TextScaled = true
	Label1.Parent = Label
	Label1.TextXAlignment = Enum.TextXAlignment.Left

	local Image = Instance.new("ImageLabel")
	Image.Name = "Image"
	Image.AnchorPoint = Vector2.new(1, 0.5)
	Image.Size = UDim2.new(0.05, 0, 0.9, 0)
	Image.BackgroundTransparency = 1
	Image.Position = UDim2.new(1, 0, 0.5, 0)
	Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Image.ScaleType = Enum.ScaleType.Fit
	Image.ImageTransparency = 0.5
	Image.Image = "rbxassetid://7072717909"
	Image.Parent = Label
	local UIGradient1 = Instance.new("UIGradient")
	UIGradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient1.Rotation = 90
	UIGradient1.Color = (self.realSelf.backgroundColor)
	UIGradient1.Parent = Image
	
	local UIGradient1 = Instance.new("UIGradient")
	UIGradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient1.Rotation = 90
	UIGradient1.Color = self.realSelf.backgroundColor
	UIGradient1.Parent = fakeBox

	Label.Parent = self.container
	self.realSelf:refreshCategoriesVisibility()
	
	local ev = Instance.new("BindableEvent")
	local lastId = {}
	
	local alreadyHide = false
	local function updateFakeBoxText()
		if Label1.Text == "" then
			fakeBox.TextColor3 = Color3.new(0.67451, 0.67451, 0.67451)
			fakeBox.Text = Label1.PlaceholderText
		else
			fakeBox.TextColor3 = Color3.new(1,1,1)
			fakeBox.Text = Label1.Text
		end
	end
	
	self.realSelf:newConnection(Label1.Changed:Connect(function(t)
		if t == "Text" then
			updateFakeBoxText()
		end
	end))
	
	self.realSelf:newConnection(game:GetService("RunService").RenderStepped:Connect(function()
		if Label1:IsFocused() then
			if alreadyHide == true then
				alreadyHide = false
				tweenService:Create(Underline, TweenInfo.new(.3), {BackgroundTransparency = 0.6}):Play()
			else
				local size = UDim2.new(0, (Label1.Text == "" and 4 or Label1.TextBounds.X+5), .07,0)
				tweenService:Create(Underline, TweenInfo.new((0.15)), {Size = size, BackgroundTransparency = (Label1.Text == "" and 1 or 0.6)}):Play()
			end
		else
			if alreadyHide == false then
				alreadyHide = true
				tweenService:Create(Underline, TweenInfo.new(.3), {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0.07, 0)}):Play()
			end
			fakeBox.TextTransparency = 0
		end
	end))
	
	updateFakeBoxText()
	
	self.realSelf:newConnection(Label1.FocusLost:Connect(function(e)
		if e then
			local id = {}
			lastId = id

			ev:Fire(Label1.Text)
			if clearAfterSubmit then
				Label1.Text = ""
			end

			Image.Image = "rbxassetid://7072706620"
			task.spawn(function()
				wait(1)
				if lastId == id then
					Image.Image = "rbxassetid://7072717909"
				end
			end)
		end
	end))
	
	self.realSelf:refreshCategoriesVisibility()
	return ev.Event, Label
end


function categories:createSlider(text, data, bePrecise)	
	-- contents
	local Slider = Instance.new("Frame")
	Slider.Name = "Slider"
	Slider.AnchorPoint = Vector2.new(1, 0)
	Slider.Size = UDim2.new(0.99, 0, 0.06, 0)
	Slider.Position = UDim2.new(0.2792669, 0, 0.0566183, 0)
	Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 5)
	UICorner.Parent = Slider

	local UIGradient = Instance.new("UIGradient")
	UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient.Rotation = 90
	UIGradient.Color = ColorSequence.new(Color3.fromRGB(44, 44, 44), Color3.fromRGB(26, 26, 26))
	UIGradient.Parent = Slider

	local UIStroke = Instance.new("UIStroke")
	UIStroke.Transparency = 0.5
	UIStroke.Parent = Slider

	local Label = Instance.new("TextLabel")
	Label.Name = "Label"
	Label.AnchorPoint = Vector2.new(0, 0.5)
	Label.Size = UDim2.new(0.431, 0, 0.8, 0)
	Label.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Label.BackgroundTransparency = 1
	Label.Position = UDim2.new(0.007, 0, 0.5, 0)
	Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Label.FontSize = Enum.FontSize.Size14
	Label.TextSize = 14
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label.Text = text
	Label.TextWrapped = true
	Label.Font = self.realSelf.textFont
	Label.TextWrap = true
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.TextScaled = true
	Label.Parent = Slider

	local UIGradient1 = Instance.new("UIGradient")
	UIGradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient1.Rotation = 90
	UIGradient1.Color = self.realSelf.backgroundColor
	UIGradient1.Parent = Label

	local Max = Instance.new("TextButton")
	Max.Name = "Max"
	Max.AnchorPoint = Vector2.new(0, 0.5)
	Max.Size = UDim2.new(0.49, 0, 0.3, 0)
	Max.BackgroundTransparency = 0.95
	Max.Position = UDim2.new(0.505, 0, 0.5, 0)
	Max.BorderSizePixel = 0
	Max.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Max.AutoButtonColor = false
	Max.FontSize = Enum.FontSize.Size14
	Max.TextSize = 14
	Max.TextColor3 = Color3.fromRGB(0, 0, 0)
	Max.Text = ""
	Max.Font = Enum.Font.SourceSans
	Max.Parent = Slider

	local Bar = Instance.new("Frame")
	Bar.Name = "Bar"
	Bar.Size = UDim2.new(0, 0, 1, 0)
	Bar.BorderSizePixel = 0
	Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Bar.Parent = Max

	local UIGradient2 = Instance.new("UIGradient")
	UIGradient2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient2.Rotation = 90
	UIGradient2.Color = self.realSelf.backgroundColor
	UIGradient2.Offset = Vector2.new(0, .1)
	UIGradient2.Parent = Bar

	Slider.Parent = self.container
	
	local Count = Instance.new("TextLabel")
	Count.Name = "Count"
	Count.AnchorPoint = Vector2.new(1, 0.5)
	Count.Size = UDim2.new(0.1, 0, 2, 0)
	Count.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Count.BackgroundTransparency = 1
	Count.Position = UDim2.new(0, 0, 0.5, 0)
	Count.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Count.FontSize = Enum.FontSize.Size14
	Count.TextSize = 14
	Count.TextColor3 = Color3.fromRGB(255, 255, 255)
	Count.Text = ""
	Count.TextWrapped = true
	Count.Font = self.realSelf.textFont
	Count.TextWrap = true
	Count.TextScaled = true

	local UIGradient = Instance.new("UIGradient")
	UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient.Rotation = 90
	UIGradient.Color = self.realSelf.backgroundColor
	UIGradient.Parent = Count
	Count.Parent = Max
	-- code
	local startV = 0
	local minV = 0
	local maxV = 100	
	local isDown = false
	local latest = nil
	local ev = Instance.new("BindableEvent")	
	
	Count.Text = ""
	
	if data then
		if data.startValue then
			startV = data.startValue
		end
		if data.minValue then
			minV = data.minValue
		end
		if data.maxValue then
			maxV = data.maxValue
		end
	end
	
	local function setCurrentValue(num)
		tweenService:Create(Bar, TweenInfo.new(0.05), {Size=UDim2.new(num/maxV, 0, 1, 0)}):Play()
		Count.Text = "[ ".. tostring(num) .. " ]"
	end
	
	local function sliding(input)
		local size = UDim2.new(math.clamp((input.X - Max.AbsolutePosition.X) / Max.AbsoluteSize.X, 0, 1), 0, 1.15, 0)
		tweenService:Create(Bar, TweenInfo.new(0.2), {Size = size}):Play()

		local preciseVal = ((size.X.Scale * maxV) / maxV) * (maxV - minV) + minV
		local normalVal = math.floor(preciseVal)

		local result = (bePrecise and preciseVal or normalVal)
		result = tonumber(string.format("%.2f", result))
		
		if latest ~= result then
			ev:Fire(result)
			latest = result
			Count.Text = "[ ".. tostring(result) .. " ]"
		end
	end

	self.realSelf:newConnection(Max.MouseButton1Down:Connect(function(input)
		isDown = true
	end))

	self.realSelf:newConnection(uis.InputEnded:Connect(function(input, bg)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and isDown then
			isDown = false
		end
	end))
	
	self.realSelf:newConnection(mouse.Move:Connect(function()
		if isDown == true then
			sliding(mouse)
		end
	end))
	
	
	setCurrentValue((startV or 0))
	self.realSelf:refreshCategoriesVisibility()
	return ev.Event, setCurrentValue, Slider
end

function categories:createDropdown(text, options, _starter)
	local currentOptions = nil
	local selected = nil
	local toggled = false
	local onOptionSelected = Instance.new("BindableEvent")
	
	local Dropdown = Instance.new("Frame")
	Dropdown.Name = "Dropdown_"..string.gsub(text, " ", "_")
	Dropdown.AnchorPoint = Vector2.new(1, 0)
	Dropdown.Size = UDim2.new(0.99, 0, 0.06, 0)
	Dropdown.Position = UDim2.new(0.2792669, 0, 0.0566183, 0)
	Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 5)
	UICorner.Parent = Dropdown

	local UIGradient = Instance.new("UIGradient")
	UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient.Rotation = 90
	UIGradient.Color = ColorSequence.new(Color3.fromRGB(44, 44, 44), Color3.fromRGB(26, 26, 26))
	UIGradient.Parent = Dropdown

	local UIStroke = Instance.new("UIStroke")
	UIStroke.Transparency = 0.5
	UIStroke.Parent = Dropdown

	local Image = Instance.new("ImageLabel")
	Image.Name = "Image"
	Image.AnchorPoint = Vector2.new(1, 0.5)
	Image.Size = UDim2.new(0.05, 0, 0.9, 0)
	Image.BackgroundTransparency = 1
	Image.Position = UDim2.new(1, 0, 0.5, 0)
	Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Image.ScaleType = Enum.ScaleType.Fit
	Image.ImageTransparency = 0.5
	Image.Image = "rbxassetid://7072723282"
	Image.Parent = Dropdown
	
	local UIGradient1 = Instance.new("UIGradient")
	UIGradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient1.Rotation = 90
	UIGradient1.Color = (self.realSelf.backgroundColor)
	UIGradient1.Parent = Image
	local Label = Instance.new("TextLabel")
	Label.Name = "Label"
	Label.AnchorPoint = Vector2.new(0.5, 0.5)
	Label.Size = UDim2.new(0.6511514, 0, 0.8383883, 0)
	Label.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Label.BackgroundTransparency = 1
	Label.Position = UDim2.new(0.3329826, 0, 0.4735007, 0)
	Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Label.FontSize = Enum.FontSize.Size14
	Label.TextSize = 14
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label.Text = text
	Label.TextWrapped = true
	Label.Font = self.realSelf.textFont
	Label.TextWrap = true
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.TextScaled = true
	Label.Parent = Dropdown

	local UIGradient1 = Instance.new("UIGradient")
	UIGradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient1.Rotation = 90
	UIGradient1.Color = self.realSelf.backgroundColor
	UIGradient1.Parent = Label

	local DropdownPart = Instance.new("Frame")
	DropdownPart.Name = "DropdownPart"
	DropdownPart.ZIndex = 2
	DropdownPart.AnchorPoint = Vector2.new(0, 0.5)
	DropdownPart.Size = UDim2.new(0.281179, 0, 0.7853916, 0)
	DropdownPart.Position = UDim2.new(0.668821, 0, 0.4999998, 0)
	DropdownPart.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	DropdownPart.Parent = Dropdown

	local UICorner1 = Instance.new("UICorner")
	UICorner1.CornerRadius = UDim.new(0, 5)
	UICorner1.Parent = DropdownPart

	local UIGradient2 = Instance.new("UIGradient")
	UIGradient2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient2.Rotation = 90
	UIGradient2.Color = ColorSequence.new(Color3.fromRGB(44, 44, 44), Color3.fromRGB(26, 26, 26))
	UIGradient2.Parent = DropdownPart

	local UIStroke1 = Instance.new("UIStroke")
	UIStroke1.Transparency = 0.5
	UIStroke1.Parent = DropdownPart

	local CurrentOption = Instance.new("TextLabel")
	CurrentOption.Name = "CurrentOption"
	CurrentOption.Size = UDim2.new(1, 0, 0.8, 0)
	CurrentOption.BorderColor3 = Color3.fromRGB(27, 42, 53)
	CurrentOption.BackgroundTransparency = 1
	CurrentOption.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CurrentOption.FontSize = Enum.FontSize.Size14
	CurrentOption.TextSize = 14
	CurrentOption.TextColor3 = Color3.fromRGB(255, 255, 255)
	CurrentOption.Text = ""
	CurrentOption.TextWrapped = true
	CurrentOption.Font = self.realSelf.textFont
	CurrentOption.TextWrap = true
	CurrentOption.TextScaled = true
	CurrentOption.Parent = DropdownPart

	local UIGradient3 = Instance.new("UIGradient")
	UIGradient3.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient3.Rotation = 90
	UIGradient3.Color = self.realSelf.backgroundColor
	UIGradient3.Parent = CurrentOption

	local Click = Instance.new("TextButton")
	Click.Name = "Click"
	Click.Size = UDim2.new(1, 0, 1, 0)
	Click.BackgroundTransparency = 1
	Click.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
	Click.FontSize = Enum.FontSize.Size14
	Click.TextTransparency = 1
	Click.TextSize = 14
	Click.TextColor3 = Color3.fromRGB(0, 0, 0)
	Click.Font = Enum.Font.SourceSans
	Click.Parent = DropdownPart

	local UICorner2 = Instance.new("UICorner")
	UICorner2.CornerRadius = UDim.new(0, 5)
	UICorner2.Parent = Click

	local List = Instance.new("Frame")
	List.Name = "List"
	List.AnchorPoint = Vector2.new(0.5, 0)
	List.Size = UDim2.new(1, 0, 5, 0)
	List.Position = UDim2.new(0.5, 0, 1, 0)
	List.BorderSizePixel = 0
	List.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	List.Parent = DropdownPart

	local UICorner3 = Instance.new("UICorner")
	UICorner3.CornerRadius = UDim.new(0, 1)
	UICorner3.Parent = List

	local UIGradient4 = Instance.new("UIGradient")
	UIGradient4.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient4.Rotation = 90
	UIGradient4.Color = ColorSequence.new(Color3.fromRGB(44, 44, 44), Color3.fromRGB(26, 26, 26))
	UIGradient4.Parent = List

	local UIStroke2 = Instance.new("UIStroke")
	UIStroke2.Transparency = 0.5
	UIStroke2.Parent = List

	local Scroll = Instance.new("ScrollingFrame")
	Scroll.Name = "Scroll"
	Scroll.AnchorPoint = Vector2.new(0.5, 0.5)
	Scroll.Size = UDim2.new(0.9385387, 0, 0.8604053, 0)
	Scroll.BackgroundTransparency = 0.999
	Scroll.Position = UDim2.new(0.5, 0, 0.5, 0)
	Scroll.Active = true
	Scroll.BorderSizePixel = 0
	Scroll.BackgroundColor3 = Color3.fromRGB(64, 140, 230)
	Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	Scroll.ScrollBarImageColor3 = Color3.fromRGB(64, 140, 230)
	Scroll.ScrollBarThickness = 1
	Scroll.Parent = List

	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 4)
	UIListLayout.Parent = Scroll

	local InvisStart = Instance.new("Frame")
	InvisStart.Name = "InvisStart"
	InvisStart.Size = UDim2.new(1, 0, 0, 0)
	InvisStart.BackgroundTransparency = 1
	InvisStart.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	InvisStart.Parent = Scroll
	
	
	local function refreshSelected()
		CurrentOption.Text = (selected or "")
	end
	
	local function changeSelected(new)
		selected = new
		refreshSelected()
		onOptionSelected:Fire(new)
	end
	
	

	local function toggleVisibility(vis)
		toggled = vis
		List.Visible = toggled
		if toggled then
			if self.currentDropdownFrame ~= nil then
				self.currentDropdownFrame.ZIndex = 1
			end
			self.currentDropdownFrame = Dropdown
			Dropdown.ZIndex = 5
		else
			if self.currentDropdownFrame == Dropdown then
				self.currentDropdownFrame = nil
			end
			Dropdown.ZIndex = 1
		end
	end
	
	local function refresh()
		for i,v in pairs(Scroll:GetChildren()) do
			if v:IsA("Frame") and v.Name ~= "InvisStart" then
				v:Destroy()
			end
		end
		
		for index, option in pairs(currentOptions) do
			local DropdownButton = Instance.new("Frame")
			DropdownButton.Name = "Option_"..option
			DropdownButton.AnchorPoint = Vector2.new(0, 1)
			DropdownButton.Size = UDim2.new(0.95, 0, 0.2, 0)
			DropdownButton.Position = UDim2.new(0.018, 0, 0.88, 0)
			DropdownButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

			local UICorner = Instance.new("UICorner")
			UICorner.CornerRadius = UDim.new(0, 5)
			UICorner.Parent = DropdownButton

			local UIGradient = Instance.new("UIGradient")
			UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
			UIGradient.Rotation = 90
			UIGradient.Color = ColorSequence.new(Color3.fromRGB(44, 44, 44), Color3.fromRGB(26, 26, 26))
			UIGradient.Parent = DropdownButton

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Transparency = 0.5
			UIStroke.Parent = DropdownButton

			local TextLabel = Instance.new("TextLabel")
			TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			TextLabel.Size = UDim2.new(1, 0, 0.95, 0)
			TextLabel.BorderColor3 = Color3.fromRGB(27, 42, 53)
			TextLabel.BackgroundTransparency = 1
			TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.FontSize = Enum.FontSize.Size14
			TextLabel.TextSize = 14
			TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.Text = option
			TextLabel.TextWrapped = true
			TextLabel.Font = self.realSelf.textFont
			TextLabel.TextWrap = true
			TextLabel.TextScaled = true
			TextLabel.Parent = DropdownButton

			local UIGradient1 = Instance.new("UIGradient")
			UIGradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
			UIGradient1.Rotation = 90
			UIGradient1.Color = self.realSelf.backgroundColor
			UIGradient1.Parent = TextLabel

			local TextButton = Instance.new("TextButton")
			TextButton.Size = UDim2.new(1, 0, 1, 0)
			TextButton.BackgroundTransparency = 1
			TextButton.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
			TextButton.FontSize = Enum.FontSize.Size14
			TextButton.TextTransparency = 1
			TextButton.TextSize = 14
			TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			TextButton.Font = Enum.Font.SourceSans
			TextButton.Parent = DropdownButton

			local UICorner1 = Instance.new("UICorner")
			UICorner1.CornerRadius = UDim.new(0, 5)
			UICorner1.Parent = TextButton
			
			self.realSelf:handleMouseHover(DropdownButton, nil, TextButton)
			self.realSelf:newConnection(TextButton.MouseButton1Down:Connect(function()
				changeSelected(option)
				toggleVisibility(false)
			end))
			
			DropdownButton.Parent = Scroll
		end
		local InvisStart = Instance.new("Frame")
		InvisStart.Name = "InvisEnd"
		InvisStart.Size = UDim2.new(1, 0, 0, 0)
		InvisStart.BackgroundTransparency = 1
		InvisStart.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		InvisStart.Parent = Scroll
	end
	
	local function updateOptions(new)
		currentOptions = new
		refresh()
	end
	
	self.realSelf:newConnection(Click.MouseButton1Down:Connect(function()
		toggleVisibility(not toggled)
	end))
	
	self.realSelf:handleMouseHover(DropdownPart, nil, Click)
	
	toggleVisibility(false)
	updateOptions(options)
	changeSelected((_starter or "None"))
	Dropdown.Parent = self.container
	self.realSelf:refreshCategoriesVisibility()
	return onOptionSelected.Event, updateOptions, changeSelected, Dropdown
end

function categories:createLabel(text)
	local Label = Instance.new("Frame")
	Label.Name = "Label_"..string.gsub(text, " ", "_")
	Label.AnchorPoint = Vector2.new(1, 0)
	Label.Size = UDim2.new(0.99, 0, 0.06, 0)
	Label.Position = UDim2.new(0.2792669, 0, 0.0566183, 0)
	Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 5)
	UICorner.Parent = Label

	local UIGradient = Instance.new("UIGradient")
	UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient.Rotation = 90
	UIGradient.Color = ColorSequence.new(Color3.fromRGB(44, 44, 44), Color3.fromRGB(26, 26, 26))
	UIGradient.Parent = Label

	local UIStroke = Instance.new("UIStroke")
	UIStroke.Transparency = 0.5
	UIStroke.Parent = Label

	local Label1 = Instance.new("TextLabel")
	Label1.Name = "Label"
	Label1.AnchorPoint = Vector2.new(0.5, 0.5)
	Label1.Size = UDim2.new(0.95, 0, 0.8, 0)
	Label1.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Label1.BackgroundTransparency = 1
	Label1.Position = UDim2.new(0.482, 0, 0.5, 0)
	Label1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Label1.FontSize = Enum.FontSize.Size14
	Label1.TextSize = 14
	Label1.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label1.Text = text
	Label1.TextWrapped = true
	Label1.Font = self.realSelf.textFont
	Label1.TextWrap = true
	Label1.TextScaled = true
	Label1.Parent = Label
	Label1.TextXAlignment = Enum.TextXAlignment.Left

	local UIGradient1 = Instance.new("UIGradient")
	UIGradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0625), NumberSequenceKeypoint.new(0.9563025, 0.6875), NumberSequenceKeypoint.new(1, 0.29375)})
	UIGradient1.Rotation = 90
	UIGradient1.Color = self.realSelf.backgroundColor
	UIGradient1.Parent = Label1

	
	Label.Parent = self.container
	self.realSelf:refreshCategoriesVisibility()
	return Label
end

function lib:refreshCategoriesVisibility()
	for i,v in pairs(self.scriptFeaturesFrame.Options:GetChildren()) do
		for a, b in pairs(v:GetChildren()) do
			if b:IsA("GuiBase") then
				b.Visible = (v.Name == self.latestCategory)
			end
		end
	end
end

function lib:createBigUIFrameWithOptionsScroll(name, txt)
	local uiBigFrameTemplateWithOptions = Instance.new("Frame")
	uiBigFrameTemplateWithOptions.Name = string.gsub(name, " ", "")
	uiBigFrameTemplateWithOptions.Visible = false
	uiBigFrameTemplateWithOptions.Size = UDim2.new(0.669, 0,0.941, 0)
	uiBigFrameTemplateWithOptions.Position = UDim2.new(.64,0,.03,0)
	uiBigFrameTemplateWithOptions.AnchorPoint = Vector2.new(.5,0)
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
	Title.Size = UDim2.new(.707, 0, 0.051, 0)
	Title.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Title.BackgroundTransparency = 1
	Title.Position = UDim2.new(0.146, 0, 0.017, 0)
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.FontSize = Enum.FontSize.Size14
	Title.TextSize = 14
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.Text = (txt or name)
	Title.TextWrapped = true
	Title.Font = self.textFont
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
	Options.CanvasSize = UDim2.new(0,0,0,0)
	Options.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Options.BorderSizePixel = 0
	Options.ScrollBarThickness = 1
	Options.ScrollBarImageColor3 = Color3.new(1,1,1)
	Options.AnchorPoint = Vector2.new(0.5, 0)
	Options.Size = UDim2.new(0.9668456, 0, 0.8703133, 0)
	Options.BackgroundTransparency = 1
	Options.Position = UDim2.new(0.5, 0, 0.1205842, 0)
	Options.ScrollBarImageColor3 = self.backgroundColor.Keypoints[2].Value
	Options.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Options.Parent = uiBigFrameTemplateWithOptions
	Options.ClipsDescendants = true
	
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0.03, 0)
	UIListLayout.Parent = Options

	uiBigFrameTemplateWithOptions.Parent = self.uiFrame
	return uiBigFrameTemplateWithOptions
end	

function lib:newConnection(connection)
	table.insert(self.connections, connection)
end

function lib:createNewOptionButton(text, color, icon)
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
	UIGradient1.Color = (color or self.backgroundColor)
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
	TextLabel.Font = self.textFont
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
	
	return OptionButton, TextButton
end

function lib:handleMouseHover(bg, noClickSound, btn)
	local button = (btn or bg:FindFirstChildOfClass("TextButton"))
	
	self:newConnection(bg.MouseEnter:Connect(function()
		tweenService:Create(bg, TweenInfo.new(.5), {BackgroundColor3 = Color3.fromRGB(152, 152, 152)}):Play()
	end))
	self:newConnection(bg.MouseLeave:Connect(function()
		tweenService:Create(bg, TweenInfo.new(.5), {BackgroundColor3 = Color3.fromRGB(255,255,255)}):Play()
	end))
	
	if button then
		if noClickSound ~= true then
			self:newConnection(button.MouseButton1Down:Connect(function()
				self.audio.Click:Play()
			end))
		end
	end
end

function setCoreUIEnabled(bool)
	coreGui.PlayerList.Enabled = bool
	coreGui.RobloxGui.Enabled = bool
	coreGui.ThemeProvider.Enabled = bool
end

function lib:endScriptConnections()
	setCoreUIEnabled(true)
	
	self._e:Fire()
	self.canDoActions = false
	for i,v in pairs(self.connections) do
		if typeof(v) == "RBXScriptConnection" then
			v:Disconnect()
		end
	end
	for i,v in pairs(self) do
		self[i]=nil
	end
	setmetatable(self, nil)
	return true
end

function lib:endScriptWithAnimation()
	self.canDoActions = false
	self:toggleInterface(false)
	debris:AddItem(self.interface, .6)
end

function lib:toggleInterface(toggled)
	if toggled then
		setCoreUIEnabled(false)
		self.audio.Open:Play()
	else
		setCoreUIEnabled(true)
		self.audio.Close:Play()
	end
	self.enabled = toggled
	return miscFunctions.setUILibraryVisibility(self.interface, toggled)
end

return lib
