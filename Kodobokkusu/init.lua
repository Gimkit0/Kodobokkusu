--[[
	██╗░░██╗░█████╗░██████╗░░█████╗░██████╗░░█████╗░██╗░░██╗██╗░░██╗██╗░░░██╗░██████╗██╗░░░██╗
	██║░██╔╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║░██╔╝██║░██╔╝██║░░░██║██╔════╝██║░░░██║
	█████═╝░██║░░██║██║░░██║██║░░██║██████╦╝██║░░██║█████═╝░█████═╝░██║░░░██║╚█████╗░██║░░░██║
	██╔═██╗░██║░░██║██║░░██║██║░░██║██╔══██╗██║░░██║██╔═██╗░██╔═██╗░██║░░░██║░╚═══██╗██║░░░██║
	██║░╚██╗╚█████╔╝██████╔╝╚█████╔╝██████╦╝╚█████╔╝██║░╚██╗██║░╚██╗╚██████╔╝██████╔╝╚██████╔╝
	╚═╝░░╚═╝░╚════╝░╚═════╝░░╚════╝░╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝░╚═════╝░╚═════╝░░╚═════╝░

	// サーバーの IDE テキストボックス \\

	- クレジット -
	* Boatbomber と iK4oS: ハイライト
	* Maidenless/RadiatedExodus: オートコンプリートとブラケット オートコンプリート (https://devforum.roblox.com/t/making-a-lua-editor-with-autocomplete/2073946)
	* ceat_ceat: カスタム入力位置

	- TODO -
	* 実際に機能する自動インデンターを作成する
	* オートコンプリーターを終了する
]]

local Kodobokkusu = {}
Kodobokkusu.__index = Kodobokkusu

function Kodobokkusu.new(data)
	local self = setmetatable({}, Kodobokkusu)
	
	self._meta = {}
	self._modules = {}
	self._connections = {}
	self._services = {}
	self._states = {}
	self._data = data
	
	if self._data.Parent then else return end

	--// 変数の開始 \\--
	self._modules = {
		Highlighter = require(script.Highlighter),
		Autocomplete = require(script.Autocomplete),
		Lines = require(script.Lines),
		Indenter = require(script.Indenter),
		CustomInput = require(script.CustomInput),
		Shared = require(script.Shared),
		
		Beautify = require(script.Methods.Beautify),
		Obfuscate = require(script.Methods.Obfuscate),
	}
	self._services = {
		RunService = game:GetService("RunService"),
		UserInputService = game:GetService("UserInputService"),
		TextService = game:GetService("TextService"),
	}
	self._states = {
		Focused = false,
		RemovingText = false,
		AddingText = false,
		IsTyping = false,
		MovingCursor = false,
		AutocompleteWasVisible = false,
		IsSelecting = false,
		
		FocusedFirst = false,
		
		HoldingDownMouse = false,
		MouseDragging = false,
		KeybindScrolling = false,
		
		SyntaxVisible = true,
		AutocompleteEnabled = true,
		AutoCloseBracketDebounce = true,
	}
	self._values = {
		LastText = 0,
		TypingTick = 0,
		StartDragTime = 0,
		TextSize = 0,
		LastCursorPosition = 0,
		SelectionStart = 0,
		SelectionEnd = 0,
		
		BeforeText = "",
	}
	self._brackets = {
		["\""] = "\"";
		["'"] = "'";
		["("] = ")";
		["["] = "]";
		["{"] = "}";
		["`"] = "`";
	}
	self._foldablePattenrs = {
		{"function%s+[%w_:]+%s*%(.-%)", "end"},
		{"if%s+.-%s+then", "end"},
		{"do", "end"},
		{"while%s+.-%s+do", "end"},
		{"for%s+.-%s+do", "end"}
	}
	self._config = {
		CURSOR_SPEED = .1,
		TEXT_SIZE = 14,
		
		FOLD_MARKER = "▼ ",
		UNFOLD_MARKER = "▶ ",
		
		HIGHLIGHT_MODE = "single",
		
		HOLD_DOWN_SMOOTHNESS = .15,
	}
	self._properties = {
		PreviousSelection = "",
	}
	self._theme = {
		THEME_COLOR = Color3.fromRGB(255, 0, 0),

		TEXT_COLOR = Color3.fromRGB(235, 235, 235),
		SHADED_TEXT = Color3.fromRGB(150, 150, 150),

		OUTLINE = Color3.fromRGB(50, 50, 50),

		DARK_BACKGROUND = Color3.fromRGB(150, 150, 150),
		SELECT_BACKGROUND = Color3.fromRGB(235, 235, 235),
		SHADOW_COLOR = Color3.fromRGB(0, 0, 0),
		
		CURSOR_COLOR = Color3.fromRGB(255, 255, 255),

		LINE_HIGHLIGHTER_OUTLINE_TRANSPARENCY = 1,
		CURSOR_INACTIVE_TRANSPARENCY = .75,
	}
	self._onEditFunctions = {}
	self._selectionFrames = {}
	self._wordHighlights = {}

	local codeEditor = script.Textbox:Clone()
	codeEditor.Parent = self._data.Parent
	local main = codeEditor.Main
	local others = codeEditor.Others
	
	self._main = main
	self._others = others
	
	self._codeEditor = codeEditor
	self._editor = main.Textbox
	self._lines = main.Lines
	self._unaligned = main.Unaligned
	self._textbox = self._editor.Input
	self._fakeTextbox = Instance.new("TextBox")
	self._indentLinesFolder = Instance.new("Folder")
	self._syntaxHighlightingFolder = self._textbox:FindFirstChild("SyntaxLines")
	self._highlightFolder = Instance.new("Folder", self._textbox)
	
	self._highlightFolder.Name = "Highlights"
	
	self._modules.Highlighter.UpdateColors({
		background = {Color = self._data.Parent.BackgroundColor3},
	})

	repeat task.wait() until game:IsLoaded()
	
	--// 機能 \\--
	
	self.validateConfig = function(defaults, newConfig)
		for index, value in pairs(defaults) do
			if newConfig[index] == nil then
				newConfig[index] = value
			end
		end
		return newConfig
	end
	
	self.addConnection = function(name, connection)
		table.insert(self._connections, {Name = name, Connection = connection})
	end

	self.removeConnection = function(name)
		for index, connection in pairs(self._connections) do
			if connection.Name == name and connection.Connection then
				connection.Connection:Disconnect()
				table.remove(self._connections, index)
			end
		end
	end
	
	self.getInputed = function()
		if self._states.IsTyping or self._states.RemovingText or self._states.AddingText or self._states.MovingCursor then
			return true
		end
		
		return false
	end
	
	self.updateStates = function()
		if #self._textbox.Text < self._values.LastText then
			self._states.RemovingText = true
			self._states.AddingText = false
		elseif #self._textbox.Text > self._values.LastText then
			self._states.RemovingText = false
			self._states.AddingText = true
		elseif #self._textbox.Text == self._values.LastText then
			self._states.RemovingText = false
			self._states.AddingText = false
		end
		
		self._states.IsTyping = true
		self._values.TypingTick = 0
	end
	
	self.getAutocompleteVisible = function(cursor)
		if self._states.AutocompleteEnabled then
			local getSuggestion = self._modules.Autocomplete:getWordAtCursor(self._textbox.CursorPosition)
			if getSuggestion then
				if (not cursor) and (not self._services.UserInputService.TouchEnabled) then
					self._modules.Autocomplete:setFrameVisible(true)
				end
			else
				spawn(function()
					if self._states.AutocompleteWasVisible then
						self._modules.Autocomplete:setFrameVisible(false)
					end
				end)
			end
		else
			self._states.AutocompleteWasVisible = false
			self._modules.Autocomplete:setFrameVisible(false)
		end
	end
	
	self.setAutocompleteEnabled = function(boolean)
		if boolean then
			self._states.AutocompleteEnabled = true
		else
			self._states.AutocompleteEnabled = false
			self._states.AutocompleteWasVisible = false
			self._modules.Autocomplete:setFrameVisible(false)
		end
	end
	
	self.textUpdate = function()
		self.updateStates()
		
		self._modules.Lines:update({
			speed = self._config.CURSOR_SPEED,
		})
		self._modules.Highlighter.Highlight(self._textbox, self._textbox.Text, self._config.HIGHLIGHT_MODE)
		
		if self._states.Focused then
			if self._services.UserInputService.TouchEnabled then
				task.spawn(function()
					self.setSyntaxVisible(false)
				end)
			end
		end
		task.spawn(function()
			for _, func in ipairs(self._onEditFunctions) do
				if not (type(func) == "function") then
					return
				end
				func()
			end
		end)
		
		self.getAutocompleteVisible()
		self.updateIndentationGuide()
	end
	
	self.cursorUpdate = function()
		self._states.MovingCursor = true
		self._values.LastCursorPosition = self._textbox.CursorPosition + 1
		
		self.getAutocompleteVisible(true)
		
		task.spawn(function()
			if not self._states.Focused then
				self._fakeTextbox.CursorPosition = -1
			else
				self._fakeTextbox.CursorPosition = self._textbox.CursorPosition
			end

			if self._fakeTextbox.CursorPosition == -1 then
				return
			end

			self._modules.CustomInput:update({
				focused = self._states.Focused,
				isInputed = self.getInputed(),
				speed = self._config.CURSOR_SPEED,
			})
			self._modules.Lines:update({
				speed = self._config.CURSOR_SPEED,
			})
			
			local cursorPos = self._textbox.CursorPosition - 1
			local cursorLines = (cursorPos > #self._textbox.Text and self._textbox.Text .. (" "):rep(cursorPos - #self._textbox.Text) or self._textbox.Text):sub(0, cursorPos):split("\n")
			local cursorLineText = cursorLines[#cursorLines]
			local cursorWidth = self._services.TextService:GetTextSize(cursorLineText, self._textbox.TextSize, self._textbox.Font, Vector2.new(math.huge, math.huge)).X
			
			self._modules.Autocomplete:setPosition({
				position = UDim2.new(0,cursorWidth,0, self._values.TextSize.Y * (#cursorLines - 1) + self._values.TextSize.Y + 3),
				speed = self._config.CURSOR_SPEED,
			})
			
			while self._states.HoldingDownMouse do
				if tick() - self._values.StartDragTime >= 1 then
					self._states.MouseDragging = true
					self.updateCanvasPos()
				end
				task.wait()
			end
			self._states.MouseDragging = false
		end)
		
		spawn(function()
			task.wait()
			self._values.LastCursorPosition = self._textbox.CursorPosition
		end)
	end
	
	self.updateSelection = function(startIndex, endIndex)
		for _, frame in pairs(self._selectionFrames) do
			frame:Destroy()
		end
		self._selectionFrames = {}
		
		--print(startIndex, endIndex)
		
		local function getPosOfChar(arg1)
			local textObject = arg1.textObject
			local char = arg1.char
			if char < 0 or textObject == nil then
				return Vector2.zero
			end
			local string_sub_result1 = string.sub(arg1.text, 1, char - 1)
			local string_split_result1 = string.split(string_sub_result1, '\n')
			local TextSize = textObject.TextSize
			local GetTextBoundsParams = Instance.new("GetTextBoundsParams")
			GetTextBoundsParams.Text = string_split_result1[#string_split_result1]..string.rep('X', char - #string_sub_result1 - 1)
			GetTextBoundsParams.Font = textObject.FontFace
			GetTextBoundsParams.Size = TextSize
			GetTextBoundsParams.Width = math.huge
			return Vector2.new(self._services.TextService:GetTextBoundsAsync(GetTextBoundsParams).X, (#string_split_result1 - 1) * TextSize)
		end

		local textObject = self._textbox
		if not textObject then return end

		local fullText = textObject.Text
		if startIndex < 0 or endIndex < 0 then return end

		local selectionStart = math.min(startIndex, endIndex)
		local selectionEnd = math.max(startIndex, endIndex)
		local selectedText = string.sub(fullText, selectionStart, selectionEnd)

		-- Get character positions
		local startCharInfo = { char = selectionStart, text = selectedText, textObject = textObject }
		local endCharInfo = { char = selectionEnd, text = selectedText, textObject = textObject }

		local startPos = getPosOfChar(startCharInfo)
		local endPos = getPosOfChar(endCharInfo)

		-- If selection is within one line
		if startPos.Y == endPos.Y then
			local highlightFrame = Instance.new("Frame")
			highlightFrame.AnchorPoint = Vector2.new(0, 0)
			highlightFrame.Name = "Selection"
			highlightFrame.BorderSizePixel = 0
			highlightFrame.ZIndex = 0
			highlightFrame.BackgroundTransparency = 0.75
			highlightFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			highlightFrame.Size = UDim2.new(0, endPos.X - startPos.X, 0, self._values.TextSize.Y)
			highlightFrame.Position = UDim2.new(0, startPos.X+10, 0, startPos.Y+5)
			highlightFrame.Parent = textObject.Parent

			table.insert(self._selectionFrames, highlightFrame)
			return
		end

		local selectedLines = string.split(selectedText, '\n')

		for lineIndex, lineText in ipairs(selectedLines) do
			local lineStartX = (lineIndex == 1) and startPos.X or 0
			local lineY = startPos.Y + (lineIndex - 1) * textObject.TextSize
			
			local textWidth = self._services.TextService:GetTextSize(lineText, textObject.TextSize, textObject.Font, Vector2.new(math.huge, math.huge)).X

			local highlightFrame = Instance.new("Frame")
			highlightFrame.AnchorPoint = Vector2.new(0, 0)
			highlightFrame.Name = "Line_" .. lineIndex
			highlightFrame.BorderSizePixel = 0
			highlightFrame.ZIndex = 0
			highlightFrame.BackgroundTransparency = 0.75
			highlightFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			highlightFrame.Size = UDim2.new(0, textWidth, 0, textObject.TextSize)
			highlightFrame.Position = UDim2.new(0, lineStartX+10, 0, lineY+5)
			highlightFrame.Parent = textObject.Parent

			table.insert(self._selectionFrames, highlightFrame)
		end
	end
	
	self.updateWordHighlights = function()
		self.clearWordHighlights()
		
		local text = self._textbox.Text
		local cursorPos = self._textbox.CursorPosition
		local selectionStart = self._textbox.SelectionStart

		if cursorPos == -1 or selectionStart == -1 then
			return
		end

		local startPos = math.min(cursorPos, selectionStart)
		local endPos = math.max(cursorPos, selectionStart)

		-- Adjust for Lua string indexing (inclusive end)
		if endPos > #text then
			endPos = #text
		end

		local selectedWord = string.sub(
			self._textbox.Text,
			startPos,
			endPos
		)
		
		if #selectedWord == 0 or not selectedWord:match("^%w+$") then
			return
		end

		local searchPos = 1
		task.spawn(pcall, function()
			while true do
				local matchStart, matchEnd = text:find(selectedWord, searchPos, true)
				if not matchStart then break end
				searchPos = matchEnd + 1

				local prefix = text:sub(1, matchStart - 1)
				local wordText = text:sub(matchStart, matchEnd)
				local wordSize = self._services.TextService:GetTextSize(wordText, self._textbox.TextSize, self._textbox.Font, Vector2.new(math.huge, math.huge))

				local prefixLines = select(2, prefix:gsub("\n", ""))
				local yPos = self._values.TextSize.Y * prefixLines

				local prefixStart = prefix:match("[^\n]*$")

				local highlight = Instance.new("Frame")
				highlight.BackgroundColor3 = self._theme.OUTLINE
				highlight.BackgroundTransparency = .5
				highlight.BorderSizePixel = 0
				highlight.Size = UDim2.new(0, wordSize.X, 0, wordSize.Y)
				highlight.Position = UDim2.new(0, self._services.TextService:GetTextSize(prefixStart, self._textbox.TextSize, self._textbox.Font, Vector2.new(math.huge, math.huge)).X, 0, yPos)
				highlight.ZIndex = self._textbox.ZIndex + 1
				highlight.Parent = self._highlightFolder

				local outline = Instance.new("UIStroke", highlight)
				outline.Color = self._theme.OUTLINE

				table.insert(self._wordHighlights, highlight)

				if #self._wordHighlights >= 25 then
					highlight:Destroy()
				end
				task.wait()
			end
		end)
	end
	
	self.clearWordHighlights = function()
		for _, highlight in ipairs(self._wordHighlights) do
			if type(highlight) ~= "number" then
				if highlight:IsA("Frame") then
					highlight:Destroy()
				end
			end
		end
		self._wordHighlights = {}
	end
	
	self.setSyntaxVisible = function(boolean)
		self._syntaxHighlightingFolder = self._textbox:FindFirstChild("SyntaxLines")
		self._states.SyntaxVisible = boolean
		
		self._modules.CustomInput:setVisible(boolean)
		
		if self._syntaxHighlightingFolder then
			if self._syntaxHighlightingFolder:IsA("TextLabel") then
				self._syntaxHighlightingFolder.Visible = boolean
			end

			for _, label in ipairs(self._syntaxHighlightingFolder:GetChildren()) do
				local name = string.lower("Line_")
				if string.lower(label.Name:sub(1,5)) == name then
					label.Visible = boolean
				end
			end
			for _, indentation in ipairs(self._indentLinesFolder:GetChildren()) do
				if indentation:IsA("Frame") then
					indentation.Visible = boolean
				end
			end
		end
	end
	
	self.changeTheme = function(theme)
		theme = self.validateConfig(self._theme, theme or {})
		
		codeEditor.Main.Lines.Label.TextColor3 = theme.SHADED_TEXT
		codeEditor.Main.Lines.Label.UIStroke.Color = theme.OUTLINE
		
		codeEditor.Others.Hidden.Icon.ImageColor3 = theme.THEME_COLOR
		codeEditor.Others.Hidden.TextLabel.TextColor3 = theme.TEXT_COLOR
		
		self._modules.Lines:changeTheme(theme)
		self._modules.Autocomplete:changeTheme(theme)
		self._modules.CustomInput:changeTheme(theme)
		
		self._theme = theme
	end
	
	self.findFoldableBlocks = function(text)
		local blocks = {}
		local stack = {}
		local lines = string.split(text, "\n")

		for i, line in ipairs(lines) do
			for _, pattern in ipairs(self._foldablePattenrs) do
				local startPattern, endPattern = pattern[1], pattern[2]

				if string.match(line, startPattern) then
					table.insert(stack, {start = i, endPattern = endPattern})
				elseif string.match(line, endPattern) then
					local block = table.remove(stack)
					if block then
						block["end"] = i
						table.insert(blocks, block)
					end
				end
			end
		end
		return blocks
	end
	
	self.applyFolding = function(textbox, blocks)
		local lines = string.split(textbox.Text, "\n")
		local folded = {}

		for _, block in ipairs(blocks) do
			local start, stop = block.start, block["end"]
			lines[start] = self._config.FOLD_MARKER .. lines[start]
			for i = start + 1, stop do
				folded[i] = true
			end
		end

		local newText = {}
		for i, line in ipairs(lines) do
			if not folded[i] then
				table.insert(newText, line)
			end
		end

		textbox.Text = table.concat(newText, "\n")
	end
	
	self.updateIndentationGuide = function()
		self._indentLinesFolder.Parent = self._textbox
		self._indentLinesFolder.Name = "IndentLines"

		for _, child in pairs(self._indentLinesFolder:GetChildren()) do
			if child:IsA("Frame") and child.Name == "IndentLine" then
				child:Destroy()
			end
		end

		local lines = self._textbox.Text:split("\n")
		for lineIndex, line in ipairs(lines) do
			local indentationLevel = 0

			for char in line:gmatch(".") do
				if char == " " then
					indentationLevel += 0.25
				elseif char == "\t" or char == "" then
					indentationLevel += 1
				else
					break
				end
			end

			for i = 1, math.floor(indentationLevel) do
				i -= 1

				task.spawn(function()
					repeat task.wait() until type(self._values.TextSize) ~= "number"
					local indentLine = Instance.new("Frame")
					indentLine.Name = "IndentLine"
					indentLine.Size = UDim2.new(0, 1, 0, self._values.TextSize.Y + 2)
					indentLine.Position = UDim2.new(0, (i * (self._values.TextSize.Y*2)+(i*2))-2, 0, (lineIndex - 1) * self._values.TextSize.Y)
					indentLine.BackgroundColor3 = self._theme.OUTLINE
					indentLine.BackgroundTransparency = .5
					indentLine.BorderSizePixel = 0
					indentLine.Parent = self._indentLinesFolder
				end)
			end
		end
	end
	
	self.updateCanvasPos = function()
		local cursorPos = self._textbox.CursorPosition - 1
		local cursorLines = (cursorPos > #self._textbox.Text and self._textbox.Text .. (" "):rep(cursorPos - #self._textbox.Text) or self._textbox.Text):sub(0, cursorPos):split("\n")

		pcall(function()
			self._modules.Shared:tween(self._editor, TweenInfo.new(self._config.HOLD_DOWN_SMOOTHNESS), {CanvasPosition = Vector2.new(self._editor.CanvasPosition.X, self._values.TextSize.Y * (#cursorLines - 1))})
		end)
	end
	
	--// スクリプト \\--
	self._modules.Lines:set({
		textbox = self._textbox,
		label = self._lines.Label,
		editor = self._editor,
		theme = self._theme,
	})
	self._modules.CustomInput:set({
		textbox = self._textbox,
		theme = self._theme,
	})
	self._modules.Indenter:set({
		textbox = self._textbox,
	})
	self._modules.Autocomplete:set({
		textbox = self._textbox,
	})
	
	self.textUpdate()
	self.cursorUpdate()
	
	--// 入力 \\--
	self.addConnection("InputBegan", self._services.UserInputService.InputBegan:Connect(function(input)
		if not self._states.Focused then return end
		if input.KeyCode == Enum.KeyCode.Tab then
			spawn(function()
				self._modules.Indenter:updateMousePos()
			end)
		end
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			self._states.HoldingDownMouse = true
			self._states.IsSelecting = true
			
			--self.updateSelection(0, 0)
			self._values.SelectionStart = self._textbox.CursorPosition
		end
		if input.KeyCode == Enum.KeyCode.Backspace then
			self._states.RemovingText = true
			
			local text = self._modules.Shared:removeControlBytes(self._textbox.Text)
			local afterChar = string.sub(text, self._textbox.CursorPosition, self._textbox.CursorPosition)
			local beforeChar = string.sub(self._modules.Shared:removeControlBytes(self._values.BeforeText), self._textbox.CursorPosition, self._textbox.CursorPosition)
			
			for index, value in pairs(self._brackets) do
				if beforeChar == index and afterChar == value then
					self._textbox.Text = string.sub(text, 1, self._textbox.CursorPosition - 1)..string.sub(text, self._textbox.CursorPosition+1)
					self._values.BeforeText = self._textbox.Text
				end
			end
		end
		if input.KeyCode == Enum.KeyCode.Return then
			self._textbox:CaptureFocus()
			self._modules.Indenter:indentBrackets()
			
			--[[
			local allLines = self._textbox.Text:split("\n")
			local currentLine = #allLines

			local newIndentation = self._modules.Indenter:autoIndent(currentLine, allLines)

			local cursorPos = self._textbox.CursorPosition + 1
			local textBeforeCursor = self._textbox.Text:sub(1, cursorPos)
			local textAfterCursor = self._textbox.Text:sub(cursorPos + 1)
			
			if newIndentation ~= nil or newIndentation ~= "" then
				self._textbox.Text = textBeforeCursor .. "" .. newIndentation .. textAfterCursor
				self._textbox.CursorPosition = cursorPos + (#newIndentation)
			end
			]]
		end
		if input.KeyCode == Enum.KeyCode.Up then
			self._states.KeybindScrolling = true
			self._modules.Autocomplete:selectUp()
			if self._states.AutocompleteWasVisible then
				self._values.LastCursorPosition = self._textbox.CursorPosition
				self._textbox.CursorPosition = self._values.LastCursorPosition
			end
		end
		if input.KeyCode == Enum.KeyCode.Down then
			self._states.KeybindScrolling = true
			self._modules.Autocomplete:selectDown()
			if self._states.AutocompleteWasVisible then
				self._values.LastCursorPosition = self._textbox.CursorPosition
				self._textbox.CursorPosition = self._values.LastCursorPosition
			end
		end
	end))
	
	self.addConnection("InputChanged", self._services.UserInputService.InputChanged:Connect(function(input)
		if self._states.IsSelecting and input.UserInputType == Enum.UserInputType.MouseMovement then
			self._values.SelectionEnd = self._textbox.CursorPosition
			--self.updateSelection(self._values.SelectionStart, self._values.SelectionEnd)
		end
	end))
	
	self.addConnection("InputEnded", self._services.UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			self._states.HoldingDownMouse = false
			self._states.IsSelecting = false
		end
		if input.KeyCode == Enum.KeyCode.Up or input.KeyCode == Enum.KeyCode.Down then
			self._states.KeybindScrolling = false
		end
	end))
	
	--// イベント \\--
	self.addConnection("TextboxEdited", self._textbox:GetPropertyChangedSignal("Text"):Connect(function()
		self.textUpdate()
		
		self._textbox.CursorPosition = self._values.LastCursorPosition - 1
		
		if not self._states.RemovingText then
			self._modules.Autocomplete:completeBracket({
				autocompleteCharacters = self._brackets,
				debounce = self._states.AutoCloseBracketDebounce,
				focused = self._states.Focused,
			})
		end
		self._states.AutoCloseBracketDebounce = false
		
		self._states.AutocompleteWasVisible = self._modules.Autocomplete:isVisible()
		
		spawn(function()
			task.wait()
			self._values.BeforeText = self._textbox.Text
		end)
	end))
	self.addConnection("PlaceholderEdited", self._data.Parent:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
		self._textbox.PlaceholderColor3 = self._data.Parent.BackgroundColor3
	end))
	self.addConnection("TextboxCursorChanged", self._textbox:GetPropertyChangedSignal("CursorPosition"):Connect(function()
		self.cursorUpdate()
		self.updateWordHighlights()
		spawn(function()
			self._states.AutocompleteWasVisible = self._modules.Autocomplete:isVisible()
		end)
	end))
	self.addConnection("TextboxFocused", self._textbox.Focused:Connect(function()
		self._states.Focused = true
		self.cursorUpdate()
		self._modules.Autocomplete:setFrameVisible(false)
		if self._services.UserInputService.TouchEnabled then
			self.setSyntaxVisible(false)
		end
	end))
	self.addConnection("TextboxFocuslost", self._textbox.FocusLost:Connect(function(enterPressed)
		self._states.Focused = false
		if self._modules.Autocomplete:isVisible() then
			if enterPressed then
				self._modules.Autocomplete:completeWord()
				--[[
				spawn(function()
					self._textbox.CursorPosition = self._textbox.CursorPosition
						+ #self._modules.Autocomplete:getCurrentWord() + 2
				end)
				]]
			end
			self._modules.Autocomplete:setFrameVisible(false)
		end
		self.cursorUpdate()
		if self._services.UserInputService.TouchEnabled then
			self.setSyntaxVisible(true)
		end
	end))
	self.addConnection("SelectionStart", self._textbox:GetPropertyChangedSignal("SelectionStart"):Connect(function()
		self.updateWordHighlights()
	end))
	self.addConnection("CanvasSizeChanged", self._editor:GetPropertyChangedSignal("CanvasSize"):Connect(function()
		self.updateCanvasPos()
	end))
	self.addConnection("CanvasPositionChanged", self._editor:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
		if self._editor.CanvasPosition.X > 0 then
			self._lines.BackgroundTransparency = 0
			self._unaligned.Shadow.DropShadow.ImageTransparency = .5
		else
			self._lines.BackgroundTransparency = 1
			self._unaligned.Shadow.DropShadow.ImageTransparency = 1
		end
	end))
	self.addConnection("Rendered", self._services.RunService.RenderStepped:Connect(function()
		self._values.LastText = #self._textbox.Text
		
		self._states.Focused = self._textbox:IsFocused()
		
		self._lines.CanvasSize = UDim2.new(0, 0, 0, self._editor.CanvasSize.Y.Offset)
		self._lines.CanvasPosition = Vector2.new(0, self._editor.CanvasPosition.Y)
		
		self._values.TextSize = self._services.TextService:GetTextSize("", self._textbox.TextSize, self._textbox.Font, Vector2.new());
		
		self._textbox.TextSize = self._config.TEXT_SIZE
		self._lines.Label.TextSize = self._config.TEXT_SIZE
		
		self._lines.BackgroundColor3 = self._data.Parent.BackgroundColor3
		self._unaligned.Shadow.DropShadow.ImageColor3 = self._theme.SHADOW_COLOR
		
		if self._states.KeybindScrolling then
			self.updateCanvasPos()
		end
		
		if self.getInputed() and not self._states.FocusedFirst then
			if self._values.TypingTick >= 25 then
				self._states.IsTyping = false
				self._states.AddingText = false
				self._states.RemovingText = false
				self._states.MovingCursor = false
				
				self._values.TypingTick = 0
				self._modules.CustomInput:update({
					focused = self._states.Focused,
					isInputed = self._states.IsTyping,
					speed = self._config.CURSOR_SPEED,
				})
				return
			end
			self._values.TypingTick += 1
		else
			self._states.FocusedFirst = false
		end
		
		if not self._states.AutoCloseBracketDebounce then
			self._states.AutoCloseBracketDebounce = true
		end
		if not self._states.SyntaxVisible then
			self._textbox.TextColor3 = self._modules.Highlighter.TokenColors.iden.Color
			self._textbox.TextTransparency = 0
		else
			self._textbox.TextColor3 = self._data.Parent.BackgroundColor3
			self._textbox.TextTransparency = .5
		end
	end))
	
	self._values.LastText = #self._textbox.Text
	self._values.LastCursorPosition = #self._textbox.Text + 1
	self._values.BeforeText = self._textbox.Text
	self._textbox.PlaceholderColor3 = self._data.Parent.BackgroundColor3
	--self._textbox.TextColor3 = self._data.Parent.BackgroundColor3
	
	self.changeTheme()
	
	return self
end

-- // 方法 \\ --
function Kodobokkusu:Write(text)
	self._textbox.Text = text
	self._textbox.CursorPosition = #self._textbox.Text
end

function Kodobokkusu:Hide()
	self._main.Visible = false
	self._others.Hidden.Visible = true
	
	self._others.Hidden.Icon.ImageTransparency = 1
	self._others.Hidden.TextLabel.TextTransparency = 1
	self._others.Hidden.Icon.Position = UDim2.new(.5, 0, .4, 0)
	self._others.Hidden.TextLabel.Position = UDim2.new(.5, 0, .6, 0)
	
	self._modules.Shared:tween(self._others.Hidden.Icon, TweenInfo.new(.5), {
		ImageTransparency = 0,
		Position = UDim2.new(.5, 0, .3, 0),
	})
	self._modules.Shared:tween(self._others.Hidden.TextLabel, TweenInfo.new(.5), {
		TextTransparency = 0,
		Position = UDim2.new(.5, 0, .55, 0)
	})
end

function Kodobokkusu:Unhide()
	self._main.Visible = true
	self._others.Hidden.Visible = false
end

function Kodobokkusu:Clear()
	self:Write("")
end

function Kodobokkusu:ChangeSyntaxColor(colors)
	self._modules.Highlighter.UpdateColors(colors)
end

function Kodobokkusu:ChangeTheme(themeTable)
	self.changeTheme(themeTable)
end

function Kodobokkusu:ChangeHighlightMode(mode)
	local lastText = self:GetText()
	
	self._config.HIGHLIGHT_MODE = string.lower(mode)
	self._modules.Highlighter.Highlight(self._textbox, self._textbox.Text, self._config.HIGHLIGHT_MODE)
end

function Kodobokkusu:SetCursorSpeed(speed)
	self._config.CURSOR_SPEED = speed
end

function Kodobokkusu:SetCursorPosition(position)
	self._textbox.CursorPosition = position
end

function Kodobokkusu:SetTextSize(size)
	self._config.TEXT_SIZE = size
end

function Kodobokkusu:SetAutocompleteEnabled(boolean)
	self.setAutocompleteEnabled(boolean)
end

function Kodobokkusu:SetLinesVisible(boolean)
	if boolean then
		self._lines.Visible = true
		self._unaligned.Shadow.Visible = true
		self._editor.Size = UDim2.new(1, -50, 1, 0)
	else
		self._lines.Visible = false
		self._unaligned.Shadow.Visible = false
		self._editor.Size = UDim2.new(1, 0, 1, 0)
	end
end

function Kodobokkusu:Beautify()
	self._textbox.Text = self._modules.Beautify(self._textbox.Text)
end

function Kodobokkusu:Obfuscate()
	self._textbox.Text = self._modules.Obfuscate(self._textbox.Text)
end

-- // フェッチメソッド \\ --
function Kodobokkusu:GetText()
	return self._textbox.Text
end

function Kodobokkusu:GetCursorPos()
	return self._textbox.CursorPosition
end

function Kodobokkusu:CountLines()
	return #self._textbox.Text:split("\n")
end

function Kodobokkusu:OnEdit(func)
	table.insert(self._onEditFunctions, func)
end

function Kodobokkusu:Destroy()
	for _, v in pairs(self._connections) do
		v:Disconnect()
	end
	self._codeEditor:Destroy()
	self._onEditFunctions = {}
	self._connections = {}
end

return Kodobokkusu
