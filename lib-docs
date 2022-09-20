
DarkLib v4.0 Documentation:

<lib> = the library source

lib.createLibrary(<string> name, <Enum.KeyCode> toggleKeyCode, <ColorSequence?> backgroundColor, <Enum.Font> backgroundFont)
	<new> = the value returned from lib.createLibrary
	
	<function> new:createCategory(<string> categoryName, ...) = Creates a category
		<category> = the value returned from new:createCategory
		
		<function> category:createLabel(<string> text)
			^ Returns the frame it created
			
		<function> category:createButton(<string> text)
			^ Returns <RBXScriptConnection> that is fired when the button is clicked, and also returns the frame it created.
			Returns: <RBXScriptConnection> <Frame>
			
			Sample: <box>:Connect(function() print("Clicked!") end))
		
		<function> category:createToggle(<string> text, <boolean?> defaultValue)
			^ Returns <RBXScriptConnection> that is fired with argument <boolean> isToggled, and also returns a <function> changeValue(<boolean> value) and the frame it created.
			Returns: <RBXScriptConnection> <function> <Frame>
			
			Sample: <toggle>:Connect(function(isToggled) print(isToggled) end))
		
		<function> category:createSlider(<string> text, <table> data)
			^ Returns <RBXScriptConnection> that is fired with argument <number> value, which is the slider progress count. Also returns <function> updateCurrentValue and the frame it created.
			Returns: <RBXScriptConnection> <Frame>
			
			Sample: <slider>:Connect(function(number) print("Slider value is", number) end))
			
			Data is a table that has the following:
			{
			startValue = <number>, -- the starter/default slider count
			minValue = <number>, -- the minimum count the user can slide
			maxValue = <number>, -- the maximum count the user can slide
			}
			
		<function> category:createBox(<string> text, <boolean> clearInputAfterSubmit)
			^ Returns <RBXScriptConnection> that is fired with argument <string> text, which is the text user submitted in the textbox. Also returns the frame it created.
			Returns: <RBXScriptConnection> <Frame>
			
			Sample: <box>:Connect(function(text) print(text) end))
			
		<function> category:createDropdown(<string> text, <table> options, <string> starterValue)
			^ Returns <RBXScriptConnection> that is fired with argument <string> optionChoosed, which is the option user selected in the dropdown. Also returns a <function> updateOptions(<table> newOptions), <function> updateSelected(<string> selected) and the frame it created
			Returns: <RBXScriptConnection> <function> <function> <Frame>
			
			Sample: <dropdown>:Connect(function(option) print("User picked option", option) end))
			
		
	<function> new:createNotification(<string> notificationText) = Creates a notification
	<function> new:newConnection(<RBXScriptConnection> connection) = The connection will disconnect when the script ended.
	<function> new:handleMouseHover(<GuiObject> button, <boolean?> noClickSound, <TextButton|ImageButton?> button) = You can give out the 3rd argument if your frame does not have a textbutton as its children.
	
	
	<tag: ADVANCED> <function> new:toggleInterface(<boolean> toggled)
	<tag: ADVANCED> <function> new:endScriptConnections() = Stops connections, and UI interaction
	<tag: ADVANCED> <function> new:endScriptWithAnimation() = Basically just ends the ui. Used by the End Script button
	
	<tag: ADVANCED> <function> new:createNewOptionButton(<string> text, <ColorSequence?> buttonColor, <string> Icon)
		^ will return a frame and a text button

	
	<RBXScriptConnection> new.ended = Will fire when the ui library gets ended.
	
