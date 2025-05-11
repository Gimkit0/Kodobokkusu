local Autocomplete = {}

function Autocomplete:set(data)
	self._textbox = nil
	
	self._data = data
	
	self:init()
end

function Autocomplete:init()
	self._textbox = self._data.textbox
	self._shared = require(script.Parent.Shared)
	
	local frame = script.AutocompleteFrame:Clone()
	frame.Parent = self._textbox
	frame.Visible = false
	self._autocompleteFrame = frame
	
	self._languageKeywords = require(script.Language)
	self._keywords = {}
	self._paletes = {}
	self._theme = {
		THEME_COLOR = Color3.fromRGB(255, 0, 0),

		TEXT_COLOR = Color3.fromRGB(235, 235, 235),
		SHADED_TEXT = Color3.fromRGB(150, 150, 150),

		OUTLINE = Color3.fromRGB(50, 50, 50),
	}
	
	self._selectorLevel = 1
	self._maxLevel = 5
	self._currentIndex = 0
	self._lastCursorPos = 0
	
	self._currentChars = ""
	self._currentWord = ""
	
	for index, section in pairs(self._languageKeywords) do
		for i, keyword in pairs(self._languageKeywords[index]) do
			table.insert(self._keywords, tostring(i))
		end
	end
end

function Autocomplete:completeBracket(data)
	local text = self._shared:removeControlBytes(self._textbox.Text)
	local addedChars = string.sub(text, self._textbox.CursorPosition - 1, self._textbox.CursorPosition - 1)
	local addedWord, cursorPosUntilAddedWord do
		local textTable =  string.split(string.gsub(text, "    ", "\n"), " ")
		addedWord = table.remove(textTable, #textTable)
		addedWord = string.gsub(addedWord, "\t", "")
		addedWord = string.gsub(addedWord, "\n", "")
		textTable = table.concat(textTable, " ")
		cursorPosUntilAddedWord = if #textTable == 0 then 0 else #textTable + #(" ")
	end
	if data.debounce and data.autocompleteCharacters[addedChars] then
		if not data.deleting and not (data.focused == false) then
			data.debounce = false
			self._textbox.Text = string.sub(text, 1, self._textbox.CursorPosition - 1)..data.autocompleteCharacters[addedChars]..string.sub(text, self._textbox.CursorPosition)
		end
	else
		data.debounce = true
	end
end

function Autocomplete:setFrameVisible(boolean)
	self._lastCursorPos = self._textbox.CursorPosition
	self._autocompleteFrame.Visible = boolean
	self._textbox.MultiLine = not boolean
end

function Autocomplete:setPosition(data)
	self._shared:tween(self._autocompleteFrame, TweenInfo.new(data.speed), {Position = data.position})
end

function Autocomplete:getWordAtCursor(cursorPos)
	local text = self._shared:escapeSpecialChars(self._textbox.Text)
	local currentLine = 1
	local currentPos = 0

	for line in text:gmatch("[^\n]*") do
		local lineLength = #line + 1

		if cursorPos <= currentPos + lineLength then
			return self:getWordInLine(line, cursorPos - currentPos)
		end

		currentPos = currentPos + lineLength
		currentLine = currentLine + 1
	end

	return ""
end

function Autocomplete:getWordInLine(line)
	local position = self._textbox.CursorPosition
	local lines = self._textbox.Text:split("\n")

	local charCount = 0
	local currentLine = nil

	for i, current in ipairs(lines) do
		charCount = charCount + #current + 1
		if position <= charCount then
			currentLine = current
			position = position - (charCount - #current)
			break
		end
	end

	if not currentLine then
		return false
	end

	local wordStart, wordEnd = nil, nil

	for i = position, 1, -1 do
		local char = currentLine:sub(i, i)
		if char == " " then
			wordStart = i + 1
			break
		end
	end

	if not wordStart then
		wordStart = 1
	end

	for i = position, #currentLine do
		local char = currentLine:sub(i, i)
		if char == " " then
			wordEnd = i - 1
			break
		end
	end

	if not wordEnd then
		wordEnd = #currentLine
	end

	local word = currentLine:sub(wordStart, wordEnd)

	if word == "" or word:match("^%s+$") then
		return false
	end

	local suggestions = self:getSuggestions(word, true)
	if not suggestions then
		return false
	end

	return word
end

function Autocomplete:getSuggestions(word, isGettingWord)
	local suggestions = {}

	-- Check if the word matches any in the keywords array
	for index, value in ipairs(self._autocompleteFrame:GetChildren()) do
		if value:IsA("TextButton") then
			value:Destroy()
		end
	end
	
	local paleteIndex = 0
	self._currentIndex = 0
	
	self._paletes = {}
	
	for _, keyword in ipairs(self._keywords) do
		if keyword:sub(1, #word) == word then
			table.insert(suggestions, keyword)
			
			paleteIndex += 1
			self._currentIndex += 1
			
			local actualIndex = paleteIndex

			local palete = script.Palete:Clone()
			palete.Parent = self._autocompleteFrame
			palete.Name = keyword
			palete.Text = `<b><font color='#{self._theme.THEME_COLOR:ToHex()}'>`..word.."</font></b>".. string.rep("", #word) .. keyword:sub(#word + 1)
			palete.Activated:Connect(function()
				self._selectorLevel = actualIndex
				self:getLevel()
				self:completeWord()
			end)
			
			local paleteTable = {
				Palete = palete,
				Index = paleteIndex,
				Word = keyword
			}

			if paleteIndex > self._maxLevel then
				palete:Destroy()
			else
				table.insert(self._paletes, paleteTable)
				if self._selectorLevel > paleteIndex then
					self._selectorLevel = paleteIndex
				end
				self._currentWord = word
				
				spawn(function()
					self:getLevel()
				end)
			end
		end
	end

	return #suggestions > 0 and suggestions or false -- Return suggestions or false if none found
end

function Autocomplete:selectDown()
	if #self._paletes == 0 then
		return
	end
	if self._selectorLevel < self._maxLevel then
		if self._selectorLevel >= self._currentIndex then
			self._selectorLevel = 1
		else
			self._selectorLevel += 1
		end
	end
	
	self:getLevel()
end

function Autocomplete:selectUp()
	if #self._paletes == 0 then
		return
	end
	if self._selectorLevel > 0 then
		self._selectorLevel -= 1
		if self._selectorLevel <= 0 then
			self._selectorLevel = #self._paletes
		end
	end

	self:getLevel()
end

function Autocomplete:getLevel()
	for index, value in ipairs(self._paletes) do
		if value.Index == self._selectorLevel then
			value.Palete.BackgroundTransparency = .9
			self._currentChars = value.Word
		else
			value.Palete.BackgroundTransparency = 1
		end
	end
end

function Autocomplete:completeWord()
	if #self._paletes == 0 then
		return
	end
	
	local text = self._shared:removeControlBytes(self._textbox.Text)
	local addedChars = string.sub(text, self._textbox.CursorPosition - 1, self._textbox.CursorPosition - 1)
	local addedWord, cursorPosUntilAddedWord do
		local textTable =  string.split(string.gsub(text, "    ", "\n"), " ")
		addedWord = table.remove(textTable, #textTable)
		addedWord = string.gsub(addedWord, "\t", "")
		addedWord = string.gsub(addedWord, "\n", "")
		textTable = table.concat(textTable, " ")
		cursorPosUntilAddedWord = if #textTable == 0 then 0 else #textTable + #(" ")
	end
	
	local function autocompleteReplace(text, targetword, replacement, cpuaw, removefirsttab)
		local afterCPUAW = string.gsub(string.sub(text, cpuaw, #text), targetword, replacement, 1)
		if removefirsttab then
			afterCPUAW = string.gsub(afterCPUAW, "    ", "", 1)
		end
		return string.sub(text, 1, cpuaw)..afterCPUAW, cpuaw + #replacement + 1
	end
	
	local replacement, newPos = autocompleteReplace(text, addedWord, self._currentChars, cursorPosUntilAddedWord, false)
	self._textbox.Text = replacement
	
	task.spawn(function()
		for i = 1, 3 do
			self:setFrameVisible(false)
			task.wait()
		end
	end)
	spawn(function()
		self._textbox:CaptureFocus()
		--self._textbox.CursorPosition = newPos
	end)
end

function Autocomplete:isVisible()
	return self._autocompleteFrame.Visible
end

function Autocomplete:getCurrentChars()
	return self._currentChars
end

function Autocomplete:getCurrentWord()
	return self._currentWord
end

function Autocomplete:changeTheme(theme)
	self._autocompleteFrame.UIStroke.Color = theme.OUTLINE
	script.Palete.Icon.ImageColor3 = theme.THEME_COLOR
	script.Palete.BackgroundColor3 = theme.SELECT_BACKGROUND
	
	self._theme = theme
end

return Autocomplete
