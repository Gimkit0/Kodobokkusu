local Indenter = {}

function Indenter:set(data)
	self._textbox = nil
	
	self._tabs = 0
	
	self._services = {}
	self._data = data
	
	self:init()
end

function Indenter:init()
	self._textbox = self._data.textbox
	
	self._indent_level = 0
	
	self._services = {
		TextService = game:GetService("TextService"),
	}
	
	self._shared = require(script.Parent.Shared)
end

function Indenter:convertTabs(text)
	return text:gsub("\t", "    ")
end

function Indenter:updateMousePos()
	self._textbox.CursorPosition += 3
end

function Indenter:indentBrackets()
	local indentableBrackets = {
		["{"] = "}",
		["("] = ")",
		["["] = "]",
	}
	
	local textboxText = self._shared:removeControlBytes(self._textbox.Text)
	
	local function makeIndent()
		self._textbox.Text = string.sub(textboxText, 1, self._textbox.CursorPosition - 1).."    " .. "\n"..""..string.sub(textboxText, self._textbox.CursorPosition)
	end
	
	for index, value in pairs(indentableBrackets) do
		if self._shared:getWord(index, 2, self._textbox) then
			makeIndent()
			spawn(function()
				self._textbox.CursorPosition += 4
			end)
		end
	end
end

function Indenter:autoIndent(currentLine, allLines)
	local previousLine = allLines[currentLine - 1] or ""
	local currentIndentation = string.match(previousLine, "^%s*") or ""
	
	--[[
	if previousLine:match("[{[(]$") or previousLine:match("function%s") or previousLine:match("then$") or previousLine:match("do$") then
		currentIndentation = currentIndentation .. "    "
	end

	if previousLine:match("end$") or previousLine:match("^%s*else$") or previousLine:match("^%s*elseif%s") or previousLine:match("^%s*until%s") then
		currentIndentation = currentIndentation:gsub("    $", "")
	end
	]]

	return currentIndentation
end

return Indenter
