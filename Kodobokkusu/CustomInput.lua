local Input = {}

function Input:set(data)
	self._textbox = nil
	self._lineHighlighter = nil
	self._inputCursor = nil
	
	self._focused = false
	self._transparent = false
	self._isAnimating = false
	
	self._shared = nil
	
	self._services = {}
	self._theme = {}
	
	self._data = data
	
	self:init()
end

function Input:init()
	self._textbox = self._data.textbox
	self._lineHighlighter = script.LineHighlighter:Clone()
	self._inputCursor = script.InputCursor:Clone()
	
	self._lineHighlighter.ZIndex = self._textbox.ZIndex + 1
	self._inputCursor.ZIndex = self._textbox.ZIndex + 1
	self._lineHighlighter.Parent = self._textbox
	self._inputCursor.Parent = self._textbox
	
	self._shared = require(script.Parent.Shared)
	
	self._focused = false
	self._transparent = false
	self._isAnimating = false
	
	self._services = {
		TextService = game:GetService("TextService"),
		RunService = game:GetService("RunService"),
	}
	self._theme = self._data.theme
	
	task.spawn(function()
		self._services.RunService.RenderStepped:Connect(function()
			self._inputCursor.BackgroundColor3 = self._theme.CURSOR_COLOR
			if self._transparent then
				self._inputCursor.BackgroundTransparency = 0
			end
			if not self._focused then
				self._inputCursor.BackgroundTransparency = self._theme.CURSOR_INACTIVE_TRANSPARENCY
			end
		end)
		
		while task.wait() do
			if self._focused then
				if self._isAnimating then
					self._isAnimating = false
					self._shared:tween(self._inputCursor, TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundTransparency = 1})
					task.wait(.5)
				end
				if not self._isAnimating then
					self._isAnimating = true
					self._shared:tween(self._inputCursor, TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundTransparency = 0})
					task.wait(.5)
				end
			end
		end
	end)
end

function Input:update(data)
	local cursorPos = self._textbox.CursorPosition - 1
	local cursorLines = (cursorPos > #self._textbox.Text and self._textbox.Text .. (" "):rep(cursorPos - #self._textbox.Text) or self._textbox.Text):sub(0, cursorPos):split("\n")
	
	local cursorLineText = cursorLines[#cursorLines]
	local cursorWidth = self._services.TextService:GetTextSize(cursorLineText, self._textbox.TextSize, self._textbox.Font, Vector2.new(math.huge, math.huge)).X
	
	local textSize = self._services.TextService:GetTextSize("", self._textbox.TextSize, self._textbox.Font, Vector2.new());
	
	self._focused = data.focused
	self._transparent = data.isInputed
	
	self._lineHighlighter.Size = UDim2.new(1, 0, 0, textSize.Y + 3)
	self._inputCursor.Size = UDim2.new(0, 1, 0, textSize.Y + 3)
	
	for index = 1, #cursorLines do
		if data.focused then
			self._lineHighlighter:TweenPosition(UDim2.new(0,-2,0, textSize.Y * (#cursorLines - 1)), 'Out', 'Quad', data.speed, true,nil)
			self._inputCursor:TweenPosition(UDim2.new(0,cursorWidth,0, textSize.Y * (#cursorLines - 1)), 'Out', 'Quad', data.speed, true,nil)
		end
	end
end

function Input:setVisible(visible)
	if self._inputCursor then self._inputCursor.Visible = visible end
	if self._lineHighlighter then self._lineHighlighter.Visible = visible end
end

function Input:changeTheme(theme)
	self._theme = theme
	if self._inputCursor then
		self._inputCursor.BackgroundColor3 = theme.CURSOR_COLOR
	end
	if self._lineHighlighter then
		self._lineHighlighter.Outline.Color = theme.OUTLINE
		self._lineHighlighter.BackgroundColor3 = theme.DARK_BACKGROUND
		self._lineHighlighter.Outline.Transparency = theme.LINE_HIGHLIGHTER_OUTLINE_TRANSPARENCY
	end
end

return Input
