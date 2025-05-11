local Lines = {}

function Lines:set(data)
	self._label = nil
	self._editor = nil
	self._textbox = nil
	
	self._highlighter = nil
	
	self._lineCount = 0
	self._charCount = 0
	self._lines = 0
	
	self._services = {}
	self._theme = {}
	self._data = data
	
	self:init()
end

function Lines:init()
	self._label = self._data.label
	self._editor = self._data.editor
	self._textbox = self._data.textbox
	
	self._highlighter = script.Highlighter:Clone()
	
	self._highlighter.ZIndex = self._label.ZIndex + 1
	self._highlighter.Parent = self._label
	self._label.ZIndex += 2
	
	self._label.Text = 1
	
	self._lineCount = 0
	self._lines = 1
	
	self.RESIZE_ADD = 9
	self.RESIZE_MULT = 15
	
	self._services = {
		TextService = game:GetService("TextService"),
	}
	self._theme = self._data.theme
	
	spawn(function()
		task.wait()
		self:update()
	end)
end

function Lines:update(data)
	data = data or {}
	
	local textSize = self._services.TextService:GetTextSize("", self._textbox.TextSize, self._textbox.Font, Vector2.new());
	local cursorPos = self._textbox.CursorPosition

	local currentLine = 1
	
	self._lineCount = 0
	self._lines = 1
	
	local _, charCount = self._textbox.Text:gsub("", "")
	charCount -= 1
	
	if charCount > 0 then
		_, self._lineCount = self._textbox.Text:gsub("\n", "")
		self._lineCount += 1
	end
		
	self._textbox.Size = UDim2.new(
		self._textbox.Size.X.Scale,
		self._textbox.Size.X.Offset,
		1,
		self._lineCount*(textSize.Y*self._textbox.LineHeight) + (self.RESIZE_ADD) * (self.RESIZE_MULT)
	)
	self._editor.CanvasSize = UDim2.new(
		self._editor.CanvasSize.X.Scale,
		self._editor.CanvasSize.X.Offset,
		0,
		self._lineCount*(textSize.Y*self._textbox.LineHeight) + (self.RESIZE_ADD) * (self.RESIZE_MULT)
	)
	self._label.Size = UDim2.new(
		self._label.Size.X.Scale,
		self._label.Size.X.Offset,
		1,
		self._editor.AbsoluteCanvasSize.Y + 6
	)
	
	if cursorPos > 1 then
		local subText = self._textbox.Text:sub(1, cursorPos - 1)
		currentLine = #subText:split("\n")
	end
	
	self._textbox.Text:gsub("\n", function()
		self._lines = self._lines + 1
	end)
	
	self._label.Text = ""
	
	local cursorPos = self._textbox.CursorPosition - 1
	local cursorLines = (cursorPos > #self._textbox.Text and self._textbox.Text .. (" "):rep(cursorPos - #self._textbox.Text) or self._textbox.Text):sub(0, cursorPos):split("\n")
	
	self._highlighter.Size = UDim2.new(1, 0, 0, textSize.Y + 3)
	self._highlighter:TweenPosition(UDim2.new(0,-2,0, textSize.Y * (#cursorLines - 1)), 'Out', 'Quad', data.speed or .1, true,nil)
	
	for index = 1, self._lines do
		if index == currentLine then
			local format = "<b>%s</b>"
			format = string.format("<font color='#%s'>", self._theme.TEXT_COLOR:ToHex())..format.."</font>"
			
			self._label.Text = self._label.Text .. string.format(format, index) .. "\n"
		else
			self._label.Text = self._label.Text .. index .. "\n"
		end
	end
end

function Lines:changeTheme(theme)
	self._theme = theme
	self._highlighter.BackgroundColor3 = theme.DARK_BACKGROUND
	self._highlighter.Outline.Color = theme.OUTLINE
	self._highlighter.Outline.Transparency = theme.LINE_HIGHLIGHTER_OUTLINE_TRANSPARENCY
	self:update()
end

return Lines
