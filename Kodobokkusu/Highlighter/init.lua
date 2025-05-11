local Lexer = require(script.Lexer)

local TextService = game:GetService("TextService")

local tokenColors = table.create(8)
local tokenFormats = table.create(7)
local activeLabels = table.create(3)

local currentTextbox = nil
local lastMode = nil

local function sanitizeRichText(s)
	return string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(s,
		"&", "&amp;"),
		"<", "&lt;"),
		">", "&gt;"),
		"\"", "&quot;"),
		"'", "&apos;"
	)
end

local function sanitizeTabs(s)
	return string.gsub(s, "\t", "    ")
end

local function sanitizeControl(s)
	return string.gsub(s, "[\0\1\2\3\4\5\6\7\8\11\12\13\14\15\16\17\18\19\20\21\22\23\24\25\26\27\28\29\30\31]+", "")
end

local function highlight(textObject, src, mode)
	src = sanitizeTabs(sanitizeControl(src or textObject.Text))
	
	local CHARACTER_LIMIT = 64000
	
	if mode then
		lastMode = mode
	end
	mode = mode or lastMode or "single"
	
	textObject.RichText = false
	textObject.Text = src
	textObject.TextXAlignment = Enum.TextXAlignment.Left
	textObject.TextYAlignment = Enum.TextYAlignment.Top
	textObject.TextColor3 = tokenColors.background.Color
	textObject.TextTransparency = .5

	if mode == "single" then
		local highlightBox = textObject:FindFirstChild("SyntaxLines")
		if highlightBox and highlightBox:IsA("Folder") then
			highlightBox:Destroy()
			highlightBox = nil
		end
		if not highlightBox then
			highlightBox = Instance.new("TextLabel", textObject)
			highlightBox.BackgroundTransparency = 1
			highlightBox.Name = "SyntaxLines"
			highlightBox.RichText = true
			highlightBox.Size = UDim2.new(1, 0, 0, 0)
			highlightBox.AutomaticSize = Enum.AutomaticSize.Y
			highlightBox.ZIndex = textObject.ZIndex + 1
		end

		highlightBox.RichText = true
		highlightBox.TextXAlignment = Enum.TextXAlignment.Left
		highlightBox.TextYAlignment = Enum.TextYAlignment.Top
		highlightBox.TextColor3 = tokenColors.iden.Color
		highlightBox.TextSize = textObject.TextSize
		highlightBox.Font = textObject.Font
		highlightBox.TextWrapped = true
		highlightBox.AutomaticSize = Enum.AutomaticSize.Y

		local richText = {}

		for token, content in Lexer.scan(src) do
			local Color = tokenColors[token] or tokenColors.iden.Color
			local sanitizedText = sanitizeRichText(content)

			if Color ~= tokenColors.iden.Color and string.find(sanitizedText, "[%S%C]") then
				table.insert(richText, string.format(tokenFormats[token], sanitizedText))
			else
				table.insert(richText, sanitizedText)
			end
		end
		
		local success, err = pcall(function()
			highlightBox.Text = table.concat(richText)
		end)
		if not success then
			highlightBox.Text = ""
			warn(err)
		end

		return function()
			highlightBox.Text = src
		end

	elseif mode == "multi" then
		local linesFolder = textObject:FindFirstChild("SyntaxLines")
		if linesFolder and linesFolder:IsA("TextLabel") then
			linesFolder:Destroy()
			linesFolder = nil
		end
		if not linesFolder then
			linesFolder = Instance.new("Folder", textObject)
			linesFolder.Name = "SyntaxLines"
		end

		if textObject:FindFirstChild("SyntaxLines") then
			linesFolder = textObject:FindFirstChild("SyntaxLines")
		else
			linesFolder = Instance.new("Folder", textObject)
			linesFolder.Name = "SyntaxLines"
		end

		if textObject:IsA("TextBox") then
			currentTextbox = textObject
		end

		local textSize = textObject.TextSize

		local _, numLines = string.gsub(src, "\n", "")
		numLines += 1

		local size = TextService:GetTextSize("", textObject.TextSize, textObject.Font, Vector2.new());

		local lineLabels = activeLabels[textObject]
		if not lineLabels then
			lineLabels = table.create(numLines)
			for i = 1, numLines do
				local lineLabel = Instance.new("TextLabel")
				lineLabel.Name = "Line_" .. i
				lineLabel.RichText = true
				lineLabel.BackgroundTransparency = 1
				lineLabel.TextXAlignment = Enum.TextXAlignment.Left
				lineLabel.TextYAlignment = Enum.TextYAlignment.Top
				lineLabel.TextColor3 = tokenColors.iden.Color
				lineLabel.Font = textObject.Font
				lineLabel.TextSize = textSize
				lineLabel.ZIndex = textObject.ZIndex + 2
				lineLabel.AutomaticSize = Enum.AutomaticSize.X

				lineLabel.Size = UDim2.new(1, 0, 0, size.Y)
				lineLabel.Position = UDim2.fromOffset(0, size.Y * textObject.LineHeight * (i - 1))
				lineLabel.Text = ""

				lineLabel.Parent = linesFolder
				lineLabels[i] = lineLabel
			end
		elseif #lineLabels < numLines then
			for i = #lineLabels + 1, numLines do
				local lineLabel = Instance.new("TextLabel")
				lineLabel.Name = "Line_" .. i
				lineLabel.RichText = true
				lineLabel.BackgroundTransparency = 1
				lineLabel.TextXAlignment = Enum.TextXAlignment.Left
				lineLabel.TextYAlignment = Enum.TextYAlignment.Top
				lineLabel.TextColor3 = tokenColors.iden.Color
				lineLabel.Font = textObject.Font
				lineLabel.TextSize = textSize
				lineLabel.BorderColor3 = Color3.fromRGB(53, 17, 255)
				lineLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				lineLabel.ZIndex = textObject.ZIndex + 2
				lineLabel.AutomaticSize = Enum.AutomaticSize.X

				lineLabel.Size = UDim2.new(1, 0, 0, size.Y)
				lineLabel.Position = UDim2.fromOffset(0, size.Y * textObject.LineHeight * (i - 1))
				lineLabel.Text = ""

				lineLabel.Parent = linesFolder
				lineLabels[i] = lineLabel
			end
		elseif #lineLabels > numLines then
			for i = #lineLabels, numLines, -1 do
				lineLabels[i].Text = ""
			end
		end

		local richText, index, lineNumber = {}, 0, 1
		for token, content in Lexer.scan(src) do
			local Color = tokenColors[token] or tokenColors.iden.Color

			local lines = string.split(sanitizeRichText(content), "\n")
			for l, line in ipairs(lines) do
				if l > 1 then
					lineLabels[lineNumber].Text = table.concat(richText)
					lineNumber += 1
					index = 0
					table.clear(richText)
				end

				index += 1
				if Color ~= tokenColors.iden.Color and string.find(line, "[%S%C]") then
					richText[index] = string.format(tokenFormats[token], line)
				else
					richText[index] = line
				end
			end
		end

		lineLabels[lineNumber].Text = table.concat(richText)

		activeLabels[textObject] = lineLabels

		local cleanup
		cleanup = textObject.AncestryChanged:Connect(function()
			if textObject.Parent then
				return
			end
			activeLabels[textObject] = nil
			cleanup:Disconnect()
		end)

		return function()
			for _, label in ipairs(lineLabels) do
				label:Destroy()
			end
			table.clear(lineLabels)

			activeLabels[textObject] = nil
			cleanup:Disconnect()
		end
	else
		--error("Invalid mode specified. Use 'single' or 'multi'.")
	end
end

-- ty synapse
--[[export type HighlighterColors = {
	background: Color3?,
	iden: Color3?,
	keyword: Color3?,
	builtin: Color3?,
	string: Color3?,
	number: Color3?,
	comment: Color3?,
	operator: Color3?
}]]

local function updateColors(colors, mode)
	-- Setup color data
	tokenColors.background = (colors and colors.background) or {Color = Color3.fromRGB(255, 255, 255)}
	tokenColors.iden = (colors and colors.iden) or {Color = Color3.fromRGB(156, 220, 254)}
	tokenColors.keyword = (colors and colors.keyword) or {Color = Color3.fromRGB(255, 173, 250)}
	tokenColors.variable = (colors and colors.variable) or {Color = Color3.fromRGB(102, 186, 255)}
	tokenColors.builtin = (colors and colors.builtin) or {Color = Color3.fromRGB(255, 255, 197)}
	tokenColors.string = (colors and colors.string) or {Color = Color3.fromRGB(255, 179, 149)}
	tokenColors.number = (colors and colors.number) or {Color = Color3.fromRGB(224, 255, 208)}
	tokenColors.comment = (colors and colors.comment) or {Color = Color3.fromRGB(152, 216, 120)}
	tokenColors.operator = (colors and colors.operator) or {Color = Color3.fromRGB(255, 215, 0)}
	tokenColors.localmethod = (colors and colors.localmethod) or {Color = Color3.fromRGB(255, 255, 197)}
	tokenColors.properties = (colors and colors.properties) or {Color = Color3.fromRGB(88, 210, 255)}
	tokenColors.boolean = (colors and colors.boolean) or {Color = Color3.fromRGB(102, 186, 255)}
	tokenColors.localproperty = (colors and colors.localproperty) or {Color = Color3.fromRGB(99, 255, 221)}
	tokenColors.todo = (colors and colors.todo) or {Color = Color3.fromRGB(255, 201, 37), IsBold = true}
	tokenColors.link = (colors and colors.link) or {Color = Color3.fromRGB(51, 173, 255), IsUnderlined = true}
	tokenColors.custom = (colors and colors.custom) or {Color = Color3.fromRGB(144, 194, 255), IsBold = true}

	for key, value in pairs(tokenColors) do
		if not value.IsBold then
			tokenFormats[key] = '<font color="#'.. string.format("%.2x%.2x%.2x", value.Color.R * 255, value.Color.G * 255, value.Color.B * 255).. '">%s</font>'
		else
			tokenFormats[key] = '<b><font color="#'.. string.format("%.2x%.2x%.2x", value.Color.R * 255, value.Color.G * 255, value.Color.B * 255).. '">%s</font></b>'
		end
		if value.IsItalicized then
			tokenFormats[key] = string.format("<i>%s</i>", tokenFormats[key])
		end
		if value.IsUnderlined then
			tokenFormats[key] = string.format("<u>%s</u>", tokenFormats[key])
		end
	end

	-- Rehighlight existing labels using latest colors
	for label, lineLabels in pairs(activeLabels) do
		for _, lineLabel in ipairs(lineLabels) do
			lineLabel.TextColor3 = tokenColors.iden.Color
		end
		highlight(label)
	end
end

pcall(updateColors)
task.spawn(function()
	repeat task.wait() until currentTextbox
	local function update()
		for label, lineLabels in pairs(activeLabels) do
			for i, lineLabel in ipairs(lineLabels) do
				local size = TextService:GetTextSize("", currentTextbox.TextSize, currentTextbox.Font, Vector2.new());
				lineLabel.TextColor3 = tokenColors.iden.Color
				lineLabel.TextSize = currentTextbox.TextSize
				lineLabel.Position = UDim2.fromOffset(0, size.Y * currentTextbox.LineHeight * (i - 1))
				lineLabel.Size = UDim2.new(1, 0, 0, size.Y)
			end
			highlight(label)
		end
	end
	currentTextbox:GetPropertyChangedSignal("TextSize"):Connect(function()
		update()
	end)
	pcall(function()
		update()
	end)
end)

return setmetatable({
	UpdateColors = updateColors,
	Highlight = highlight,
	TokenColors = tokenColors,
}, {
	__call = function(_, textObject, src)
		return highlight(textObject, src)
	end
})
