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

function environment()
	--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88 
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  CONVERTER
]=]

	-- Instances: 33 | Scripts: 0 | Modules: 0
	local G2L = {};

	-- StarterGui.Stuff
	G2L["1"] = Instance.new("Folder");
	G2L["1"]["Name"] = [[PACKAGE]];

	-- StarterGui.Stuff.AutocompleteFrame
	G2L["2"] = Instance.new("Frame", G2L["1"]);
	G2L["2"]["ZIndex"] = 5;
	G2L["2"]["BorderSizePixel"] = 0;
	G2L["2"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
	G2L["2"]["Size"] = UDim2.new(0, 200, 0, 0);
	G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["2"]["AutomaticSize"] = Enum.AutomaticSize.Y;
	G2L["2"]["Name"] = [[AutocompleteFrame]];

	-- StarterGui.Stuff.AutocompleteFrame.UIStroke
	G2L["3"] = Instance.new("UIStroke", G2L["2"]);
	G2L["3"]["Color"] = Color3.fromRGB(51, 51, 51);
	G2L["3"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

	-- StarterGui.Stuff.AutocompleteFrame.UIListLayout
	G2L["4"] = Instance.new("UIListLayout", G2L["2"]);
	G2L["4"]["VerticalAlignment"] = Enum.VerticalAlignment.Bottom;
	G2L["4"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

	-- StarterGui.Stuff.AutocompleteFrame.UICorner
	G2L["5"] = Instance.new("UICorner", G2L["2"]);
	G2L["5"]["CornerRadius"] = UDim.new(0, 5);

	-- StarterGui.Stuff.Highlighter
	G2L["6"] = Instance.new("Frame", G2L["1"]);
	G2L["6"]["BorderSizePixel"] = 0;
	G2L["6"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["6"]["BackgroundTransparency"] = 0.8999999761581421;
	G2L["6"]["Size"] = UDim2.new(1, 5, 0, 14);
	G2L["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["6"]["Position"] = UDim2.new(0, -2, 0, 0);
	G2L["6"]["Name"] = [[Highlighter]];

	-- StarterGui.Stuff.Highlighter.UIPadding
	G2L["7"] = Instance.new("UIPadding", G2L["6"]);
	G2L["7"]["PaddingLeft"] = UDim.new(0, 10);

	-- StarterGui.Stuff.Highlighter.Outline
	G2L["8"] = Instance.new("UIStroke", G2L["6"]);
	G2L["8"]["Color"] = Color3.fromRGB(46, 46, 46);
	G2L["8"]["Name"] = [[Outline]];
	G2L["8"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

	-- StarterGui.Stuff.InputCursor
	G2L["9"] = Instance.new("Frame", G2L["1"]);
	G2L["9"]["ZIndex"] = 5;
	G2L["9"]["BorderSizePixel"] = 0;
	G2L["9"]["BackgroundColor3"] = Color3.fromRGB(162, 162, 162);
	G2L["9"]["BackgroundTransparency"] = 1;
	G2L["9"]["Size"] = UDim2.new(0, 1, 0, 16);
	G2L["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["9"]["Name"] = [[InputCursor]];

	-- StarterGui.Stuff.LineHighlighter
	G2L["a"] = Instance.new("Frame", G2L["1"]);
	G2L["a"]["BorderSizePixel"] = 0;
	G2L["a"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["a"]["BackgroundTransparency"] = 0.8999999761581421;
	G2L["a"]["Size"] = UDim2.new(1, 5, 0, 14);
	G2L["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["a"]["Name"] = [[LineHighlighter]];

	-- StarterGui.Stuff.LineHighlighter.Outline
	G2L["b"] = Instance.new("UIStroke", G2L["a"]);
	G2L["b"]["Color"] = Color3.fromRGB(46, 46, 46);
	G2L["b"]["Name"] = [[Outline]];
	G2L["b"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

	-- StarterGui.Stuff.LineHighlighter.UIPadding
	G2L["c"] = Instance.new("UIPadding", G2L["a"]);
	G2L["c"]["PaddingLeft"] = UDim.new(0, 10);

	-- StarterGui.Stuff.Textbox
	G2L["d"] = Instance.new("Frame", G2L["1"]);
	G2L["d"]["BorderSizePixel"] = 0;
	G2L["d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["d"]["BackgroundTransparency"] = 1;
	G2L["d"]["Size"] = UDim2.new(1, 0, 1, 0);
	G2L["d"]["ClipsDescendants"] = true;
	G2L["d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["d"]["Name"] = [[Textbox]];

	-- StarterGui.Stuff.Textbox.Main
	G2L["e"] = Instance.new("Frame", G2L["d"]);
	G2L["e"]["BorderSizePixel"] = 0;
	G2L["e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["e"]["BackgroundTransparency"] = 1;
	G2L["e"]["Size"] = UDim2.new(1, 0, 1, 0);
	G2L["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["e"]["Name"] = [[Main]];

	-- StarterGui.Stuff.Textbox.Main.TextboxLayout
	G2L["f"] = Instance.new("UIListLayout", G2L["e"]);
	G2L["f"]["FillDirection"] = Enum.FillDirection.Horizontal;
	G2L["f"]["Name"] = [[TextboxLayout]];

	-- StarterGui.Stuff.Textbox.Main.Lines
	G2L["10"] = Instance.new("ScrollingFrame", G2L["e"]);
	G2L["10"]["Active"] = true;
	G2L["10"]["ScrollingDirection"] = Enum.ScrollingDirection.Y;
	G2L["10"]["ZIndex"] = 2;
	G2L["10"]["BorderSizePixel"] = 0;
	G2L["10"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
	G2L["10"]["ScrollBarImageTransparency"] = 1;
	G2L["10"]["BackgroundColor3"] = Color3.fromRGB(36, 36, 36);
	G2L["10"]["ScrollingEnabled"] = false;
	G2L["10"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
	G2L["10"]["BackgroundTransparency"] = 1;
	G2L["10"]["Size"] = UDim2.new(0, 50, 1, 0);
	G2L["10"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["10"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["10"]["ScrollBarThickness"] = 0;
	G2L["10"]["Name"] = [[Lines]];

	-- StarterGui.Stuff.Textbox.Main.Lines.Label
	G2L["11"] = Instance.new("TextLabel", G2L["10"]);
	G2L["11"]["ZIndex"] = 4;
	G2L["11"]["BorderSizePixel"] = 0;
	G2L["11"]["RichText"] = true;
	G2L["11"]["TextYAlignment"] = Enum.TextYAlignment.Top;
	G2L["11"]["BackgroundColor3"] = Color3.fromRGB(31, 31, 31);
	G2L["11"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	G2L["11"]["TextSize"] = 14;
	G2L["11"]["TextColor3"] = Color3.fromRGB(148, 148, 148);
	G2L["11"]["AutomaticSize"] = Enum.AutomaticSize.X;
	G2L["11"]["Size"] = UDim2.new(0, 50, 1, 0);
	G2L["11"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["11"]["Text"] = [[1]];
	G2L["11"]["Name"] = [[Label]];
	G2L["11"]["BackgroundTransparency"] = 1;

	-- StarterGui.Stuff.Textbox.Main.Lines.Label.UIPadding
	G2L["12"] = Instance.new("UIPadding", G2L["11"]);
	G2L["12"]["PaddingTop"] = UDim.new(0, 5);
	G2L["12"]["PaddingRight"] = UDim.new(0, 5);
	G2L["12"]["PaddingLeft"] = UDim.new(0, 5);

	-- StarterGui.Stuff.Textbox.Main.Lines.Label.UIStroke
	G2L["13"] = Instance.new("UIStroke", G2L["11"]);
	G2L["13"]["Color"] = Color3.fromRGB(51, 51, 51);
	G2L["13"]["Transparency"] = 1;
	G2L["13"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

	-- StarterGui.Stuff.Textbox.Main.Textbox
	G2L["14"] = Instance.new("ScrollingFrame", G2L["e"]);
	G2L["14"]["Active"] = true;
	G2L["14"]["BorderSizePixel"] = 0;
	G2L["14"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
	G2L["14"]["BackgroundColor3"] = Color3.fromRGB(25, 25, 25);
	G2L["14"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
	G2L["14"]["AutomaticCanvasSize"] = Enum.AutomaticSize.X;
	G2L["14"]["BackgroundTransparency"] = 1;
	G2L["14"]["Size"] = UDim2.new(1, -50, 1, 0);
	G2L["14"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["14"]["ScrollBarThickness"] = 5;
	G2L["14"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
	G2L["14"]["Name"] = [[Textbox]];

	-- StarterGui.Stuff.Textbox.Main.Textbox.Input
	G2L["15"] = Instance.new("TextBox", G2L["14"]);
	G2L["15"]["ZIndex"] = 2;
	G2L["15"]["BorderSizePixel"] = 0;
	G2L["15"]["TextSize"] = 14;
	G2L["15"]["TextXAlignment"] = Enum.TextXAlignment.Left;
	G2L["15"]["TextTransparency"] = 1;
	G2L["15"]["TextYAlignment"] = Enum.TextYAlignment.Top;
	G2L["15"]["BackgroundColor3"] = Color3.fromRGB(31, 31, 31);
	G2L["15"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["15"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	G2L["15"]["ShowNativeInput"] = false;
	G2L["15"]["MultiLine"] = true;
	G2L["15"]["BackgroundTransparency"] = 1;
	G2L["15"]["Size"] = UDim2.new(1, 0, 1, 0);
	G2L["15"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["15"]["Text"] = [[]];
	G2L["15"]["AutomaticSize"] = Enum.AutomaticSize.XY;
	G2L["15"]["Name"] = [[Input]];
	G2L["15"]["ClearTextOnFocus"] = false;

	-- StarterGui.Stuff.Textbox.Main.Textbox.Input.UIPadding
	G2L["16"] = Instance.new("UIPadding", G2L["15"]);
	G2L["16"]["PaddingTop"] = UDim.new(0, 5);
	G2L["16"]["PaddingRight"] = UDim.new(0, 5);
	G2L["16"]["PaddingLeft"] = UDim.new(0, 2);

	-- StarterGui.Stuff.Textbox.Main.Unaligned
	G2L["17"] = Instance.new("Folder", G2L["e"]);
	G2L["17"]["Name"] = [[Unaligned]];

	-- StarterGui.Stuff.Textbox.Main.Unaligned.Shadow
	G2L["18"] = Instance.new("Frame", G2L["17"]);
	G2L["18"]["BorderSizePixel"] = 0;
	G2L["18"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["18"]["BackgroundTransparency"] = 1;
	G2L["18"]["Size"] = UDim2.new(0, 50, 1, 0);
	G2L["18"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["18"]["Name"] = [[Shadow]];

	-- StarterGui.Stuff.Textbox.Main.Unaligned.Shadow.DropShadow
	G2L["19"] = Instance.new("ImageLabel", G2L["18"]);
	G2L["19"]["BorderSizePixel"] = 0;
	G2L["19"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
	G2L["19"]["ScaleType"] = Enum.ScaleType.Slice;
	G2L["19"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["19"]["ImageTransparency"] = 1;
	G2L["19"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
	G2L["19"]["Image"] = [[rbxassetid://6015897843]];
	G2L["19"]["Size"] = UDim2.new(1, 47, 1, 47);
	G2L["19"]["Name"] = [[DropShadow]];
	G2L["19"]["BackgroundTransparency"] = 1;
	G2L["19"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

	-- StarterGui.Stuff.Textbox.Others
	G2L["1a"] = Instance.new("Frame", G2L["d"]);
	G2L["1a"]["BorderSizePixel"] = 0;
	G2L["1a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["1a"]["BackgroundTransparency"] = 1;
	G2L["1a"]["Size"] = UDim2.new(1, 0, 1, 0);
	G2L["1a"]["ClipsDescendants"] = true;
	G2L["1a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["1a"]["Name"] = [[Others]];

	-- StarterGui.Stuff.Textbox.Others.Hidden
	G2L["1b"] = Instance.new("Frame", G2L["1a"]);
	G2L["1b"]["BorderSizePixel"] = 0;
	G2L["1b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["1b"]["BackgroundTransparency"] = 1;
	G2L["1b"]["Size"] = UDim2.new(1, 0, 1, 0);
	G2L["1b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["1b"]["Visible"] = false;
	G2L["1b"]["Name"] = [[Hidden]];

	-- StarterGui.Stuff.Textbox.Others.Hidden.Icon
	G2L["1c"] = Instance.new("ImageLabel", G2L["1b"]);
	G2L["1c"]["BorderSizePixel"] = 0;
	G2L["1c"]["ScaleType"] = Enum.ScaleType.Fit;
	G2L["1c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["1c"]["ImageColor3"] = Color3.fromRGB(255, 0, 0);
	G2L["1c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
	G2L["1c"]["Image"] = [[http://www.roblox.com/asset/?id=13571270194]];
	G2L["1c"]["Size"] = UDim2.new(0.4000000059604645, 0, 0.4000000059604645, 0);
	G2L["1c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["1c"]["Name"] = [[Icon]];
	G2L["1c"]["BackgroundTransparency"] = 1;
	G2L["1c"]["Position"] = UDim2.new(0.5, 0, 0.30000001192092896, 0);

	-- StarterGui.Stuff.Textbox.Others.Hidden.TextLabel
	G2L["1d"] = Instance.new("TextLabel", G2L["1b"]);
	G2L["1d"]["BorderSizePixel"] = 0;
	G2L["1d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["1d"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
	G2L["1d"]["TextSize"] = 20;
	G2L["1d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["1d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
	G2L["1d"]["AutomaticSize"] = Enum.AutomaticSize.X;
	G2L["1d"]["Size"] = UDim2.new(0, 200, 0, 50);
	G2L["1d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["1d"]["Text"] = [[This content is hidden!]];
	G2L["1d"]["BackgroundTransparency"] = 1;
	G2L["1d"]["Position"] = UDim2.new(0.5, 0, 0.550000011920929, 0);

	-- StarterGui.Stuff.Palete
	G2L["1e"] = Instance.new("TextButton", G2L["1"]);
	G2L["1e"]["ZIndex"] = 6;
	G2L["1e"]["BorderSizePixel"] = 0;
	G2L["1e"]["RichText"] = true;
	G2L["1e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
	G2L["1e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["1e"]["TextSize"] = 14;
	G2L["1e"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	G2L["1e"]["TextColor3"] = Color3.fromRGB(226, 226, 226);
	G2L["1e"]["Size"] = UDim2.new(0, 200, 0, 25);
	G2L["1e"]["Name"] = [[Palete]];
	G2L["1e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["1e"]["Text"] = [[getfenv]];
	G2L["1e"]["BackgroundTransparency"] = 1;

	-- StarterGui.Stuff.Palete.UIPadding
	G2L["1f"] = Instance.new("UIPadding", G2L["1e"]);
	G2L["1f"]["PaddingLeft"] = UDim.new(0, 35);

	-- StarterGui.Stuff.Palete.Icon
	G2L["20"] = Instance.new("ImageLabel", G2L["1e"]);
	G2L["20"]["ZIndex"] = 6;
	G2L["20"]["BorderSizePixel"] = 0;
	G2L["20"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["20"]["ImageColor3"] = Color3.fromRGB(255, 0, 0);
	G2L["20"]["AnchorPoint"] = Vector2.new(1, 0.5);
	G2L["20"]["Image"] = [[rbxassetid://119893371750481]];
	G2L["20"]["Size"] = UDim2.new(0, 15, 0, 15);
	G2L["20"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["20"]["Name"] = [[Icon]];
	G2L["20"]["BackgroundTransparency"] = 1;
	G2L["20"]["Position"] = UDim2.new(0, -10, 0.5, 0);

	-- StarterGui.Stuff.Palete.UICorner
	G2L["21"] = Instance.new("UICorner", G2L["1e"]);
	G2L["21"]["CornerRadius"] = UDim.new(0, 5);

	return G2L["1"]
end

local script = environment()

function autocompleteModule()
	local Autocomplete = {}

	function Autocomplete:set(data)
		self._textbox = nil

		self._data = data

		self:init()
	end

	function Autocomplete:init()
		self._textbox = self._data.textbox
		self._shared = sharedModule()

		local frame = script.AutocompleteFrame:Clone()
		frame.Parent = self._textbox
		frame.Visible = false
		self._autocompleteFrame = frame

		self._languageKeywords = languageModule()
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
end

function customInputModule()
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

		self._shared = sharedModule()

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
end

function highlighterModule()
	local Lexer = lexerModule()

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
end

function indenterModule()
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

		self._shared = sharedModule()
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
end

function linesModule()
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
end

function sharedModule()
	local Shared = {}

	function Shared:removeControlBytes(text)
		return string.gsub(text, "[\0\1\2\3\4\5\6\7\8\11\12\13\14\15\16\17\18\19\20\21\22\23\24\25\26\27\28\29\30\31]+", "")
	end

	function Shared:escapeSpecialChars(string)
		return (string:gsub('%%', '%%%%')
			:gsub('^%^', '%%^')
			:gsub('%$$', '%%$')
			:gsub('%(', '%%(')
			:gsub('%)', '%%)')
			:gsub('%.', '%%.')
			:gsub('%[', '%%[')
			:gsub('%]', '%%]')
			:gsub('%*', '%%*')
			:gsub('%+', '%%+')
			:gsub('%-', '%%-')
			:gsub('%?', '%%?'))
	end

	function Shared:tween(object, info, goal)
		local tween = game:GetService("TweenService"):Create(object, info, goal)
		tween:Play()
		return tween
	end

	function Shared:getWord(word, start, textbox)
		if type(word) == "string" then else return false end
		local len = word:len()
		local addedWord = ""
		for index = 1, len + 1 do
			local addedChars = string.sub(textbox.Text, textbox.CursorPosition - (1-index) - start, textbox.CursorPosition - (1-index) - start)
			local char = string.sub(word, index, index)
			if char == addedChars then
				addedWord = addedWord..char
			end
			if addedWord == word then
				return true
			end
		end
	end

	return Shared
end

function lexerModule()
	--[=[
	Lexical scanner for creating a sequence of tokens from Lua source code.
	This is a heavily modified and Roblox-optimized version of
	the original Penlight Lexer module:
		https://github.com/stevedonovan/Penlight
	Authors:
		stevedonovan <https://github.com/stevedonovan> ----------- Original Penlight lexer author
		ryanjmulder <https://github.com/ryanjmulder> ------------- Penlight lexer contributer
		mpeterv <https://github.com/mpeterv> --------------------- Penlight lexer contributer
		Tieske <https://github.com/Tieske> ----------------------- Penlight lexer contributer
		boatbomber <https://github.com/boatbomber> --------------- Roblox port, added builtin token,
		                                                           added patterns for incomplete syntax, bug fixes,
		                                                           behavior changes, token optimization, thread optimization
		                                                           Added lexer.navigator() for non-sequential reads
		Sleitnick <https://github.com/Sleitnick> ----------------- Roblox optimizations
		howmanysmall <https://github.com/howmanysmall> ----------- Lua + Roblox optimizations

	List of possible tokens:
		- iden
		- keyword
		- builtin
		- string
		- number
		- comment
		- operator
--]=]

	local lexer = {}

	local Prefix, Suffix, Cleaner = "^[%c%s]*", "[%c%s]*", "[%c%s]+"
	local UNICODE = "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]+"
	local NUMBER_A = "0x[%da-fA-F]+"
	local NUMBER_B = "%d+%.?%d*[eE][%+%-]?%d+"
	local NUMBER_C = "%d+[%._]?[%d_eE]*"
	local OPERATORS = "[:;<>/~%*%(%)%-={},%.#%^%+%%]+"
	local BRACKETS = "[%[%]]+" -- needs to be separate pattern from other operators or it'll mess up multiline strings
	local IDEN = "[%a_][%w_]*"
	local STRING_EMPTY = "(['\"])%1" --Empty String
	local STRING_PLAIN = "(['\"])[^\n]-([^\\]%1)" --TODO: Handle escaping escapes
	local STRING_INCOMP_A = "(['\"]).-\n" --Incompleted String with next line
	local STRING_INCOMP_B = "(['\"])[^\n]*" --Incompleted String without next line
	local STRING_MULTI = "%[(=*)%[.-%]%1%]" --Multiline-String
	local STRING_MULTI_INCOMP = "%[=*%[.-.*" --Incompleted Multiline-String
	local COMMENT_MULTI = "%-%-%[(=*)%[.-%]%1%]" --Completed Multiline-Comment
	local COMMENT_MULTI_INCOMP = "%-%-%[=*%[.-.*" --Incompleted Multiline-Comment
	local COMMENT_PLAIN = "%-%-.-\n" --Completed Singleline-Comment
	local COMMENT_INCOMP = "%-%-.*" --Incompleted Singleline-Comment
	--local TYPED_VAR = ":%s*([%w%?%| \t]+%s*)" --Typed variable, parameter, function 
	local lang = languageModule()
	local lua_keyword = lang.keyword
	local lua_variables = lang.variables
	local lua_builtin = lang.builtin
	local lua_selection = lang.selection
	local lua_libraries = lang.libraries
	local lua_properties = lang.properties
	local lua_booleans = lang.booleans
	local lua_comments = lang.comments
	local lua_customKeywords = lang.customKeywords

	local lua_matches = {
		-- Indentifiers
		{ Prefix .. IDEN .. Suffix, "var" },
		--{ Prefix .. TYPED_VAR .. Suffix, "localmethod" },

		-- Numbers
		{ Prefix .. NUMBER_A .. Suffix, "number" },
		{ Prefix .. NUMBER_B .. Suffix, "number" },
		{ Prefix .. NUMBER_C .. Suffix, "number" },

		-- Strings
		{ Prefix .. STRING_EMPTY .. Suffix, "string" },
		{ Prefix .. STRING_PLAIN .. Suffix, "string" },
		{ Prefix .. STRING_INCOMP_A .. Suffix, "string" },
		{ Prefix .. STRING_INCOMP_B .. Suffix, "string" },
		{ Prefix .. STRING_MULTI .. Suffix, "string" },
		{ Prefix .. STRING_MULTI_INCOMP .. Suffix, "string" },

		-- Comments
		{ Prefix .. COMMENT_MULTI .. Suffix, "comment" },
		{ Prefix .. COMMENT_MULTI_INCOMP .. Suffix, "comment" },
		{ Prefix .. COMMENT_PLAIN .. Suffix, "comment" },
		{ Prefix .. COMMENT_INCOMP .. Suffix, "comment" },

		-- Operators
		{ Prefix .. OPERATORS .. Suffix, "operator" },
		{ Prefix .. BRACKETS .. Suffix, "operator" },

		-- Unicode
		{ Prefix .. UNICODE .. Suffix, "iden" },

		-- Unknown
		{ "^.", "iden" },
	}

	--- Create a plain token iterator from a string.
	-- @tparam string s a string.

	function lexer.scan(s)
		-- local startTime = os.clock()
		lexer.finished = false

		local index = 1
		local sz = #s
		local p1, p2, p3, pT = "", "", "", ""

		return function()
			if index <= sz then
				for _, m in ipairs(lua_matches) do
					local i1, i2 = string.find(s, m[1], index)
					if i1 then
						local tok = string.sub(s, i1, i2)
						index = i2 + 1
						lexer.finished = index > sz
						--if lexer.finished then
						--	print((os.clock()-startTime)*1000, "ms")
						--end

						local t = m[2]
						local t2 = t

						-- Process t into t2
						if string.find(tok, "^https://") then
							t2 = "link"
						end

						if t == "var" and t2 ~= "link" then
							-- Since we merge spaces into the tok, we need to remove them
							-- in order to check the actual word it contains
							local cleanTok = string.gsub(tok, Cleaner, "")

							if lua_keyword[cleanTok] then
								t2 = "keyword"
							elseif lua_builtin[cleanTok] then
								t2 = "builtin"
							elseif lua_properties[cleanTok] then
								t2 = "properties"
							elseif lua_booleans[cleanTok] then
								t2 = "boolean"
							elseif lua_variables[cleanTok] then
								t2 = "variable"
							elseif lua_customKeywords[cleanTok] then
								t2 = "custom"
							else
								t2 = "iden"
							end

						--[[
						if string.find(p1, ":%s*[%s%c]*$") and pT ~= "comment" then
							-- The previous was a : so we need to special case method indexing
							local parent = string.gsub(p2, Cleaner, "")
							local lib = lua_libraries[parent]
							if lib and lib[cleanTok] and not string.find(p3, "%.[%s%c]*$") then
								-- Indexing a builtin lib with existing item, treat as a builtin
								t2 = "localmethod"
							else
								-- Indexing a non-builtin, can't be treated as a keyword/builtin
								t2 = "localmethod"
							end
						end
						]]

							-- make it so if it has "https://" then it'll count as a link

							if string.find(p1, "%.[%s%c]*$") and pT ~= "comment" then
								-- The previous was a . so we need to special case indexing things
								local parent = string.gsub(p2, Cleaner, "")
								local lib = lua_libraries[parent]
								if lib and lib[cleanTok] and not string.find(p3, "%.[%s%c]*$") then
									-- Indexing a builtin lib with existing item, treat as a builtin
									t2 = "builtin"
								else
									-- Indexing a non builtin, can't be treated as a keyword/builtin
									t2 = "localproperty"
								end
								-- print("indexing",parent,"with",cleanTok,"as",t2)
							end
							if t2 ~= "builtin" and t2 ~= "keyword" then
								if string.find(s, "^%s*%(", index) or string.find(s, "^%s*'", index) or string.find(s, '^%s*"', index) or string.find(s, '^%s*{', index) then
									-- The next character after this token is an open parenthesis
									t2 = "localmethod"
								end
							end
						end

						-- Record last 3 tokens for the indexing context check
						p3 = p2
						p2 = p1
						p1 = tok
						pT = t2
						return t2, tok
					end
				end
			end
		end
	end

	function lexer.navigator()
		local nav = {
			Source = "",
			TokenCache = table.create(50),

			_RealIndex = 0,
			_UserIndex = 0,
			_ScanThread = nil,
		}

		function nav:Destroy()
			self.Source = nil
			self._RealIndex = nil
			self._UserIndex = nil
			self.TokenCache = nil
			self._ScanThread = nil
		end

		function nav:SetSource(SourceString)
			self.Source = SourceString

			self._RealIndex = 0
			self._UserIndex = 0
			table.clear(self.TokenCache)

			self._ScanThread = coroutine.create(function()
				for Token, Src in lexer.scan(self.Source) do
					self._RealIndex += 1
					self.TokenCache[self._RealIndex] = { Token, Src }
					coroutine.yield(Token, Src)
				end
			end)
		end

		function nav.Next()
			nav._UserIndex += 1

			if nav._RealIndex >= nav._UserIndex then
				-- Already scanned, return cached
				return table.unpack(nav.TokenCache[nav._UserIndex])
			else
				if coroutine.status(nav._ScanThread) == "dead" then
					-- Scan thread dead
					return
				else
					local success, token, src = coroutine.resume(nav._ScanThread)
					if success and token then
						-- Scanned new data
						return token, src
					else
						-- Lex completed
						return
					end
				end
			end
		end

		function nav.Peek(PeekAmount)
			local GoalIndex = nav._UserIndex + PeekAmount

			if nav._RealIndex >= GoalIndex then
				-- Already scanned, return cached
				if GoalIndex > 0 then
					return table.unpack(nav.TokenCache[GoalIndex])
				else
					-- Invalid peek
					return
				end
			else
				if coroutine.status(nav._ScanThread) == "dead" then
					-- Scan thread dead
					return
				else
					local IterationsAway = GoalIndex - nav._RealIndex

					local success, token, src = nil, nil, nil

					for _ = 1, IterationsAway do
						success, token, src = coroutine.resume(nav._ScanThread)
						if not (success or token) then
							-- Lex completed
							break
						end
					end

					return token, src
				end
			end
		end

		return nav
	end

	return lexer
end

function languageModule()
	function asciiDecode(str : string)
		local decoded = ""

		str = string.gsub(str, "%s+", "") str = string.gsub(str, "\n+", "")
		str = string.gsub(str, "\t+", "") str = string.gsub(str, "\r+", "")

		for code in str:gmatch("\\(%d+)") do
			decoded = decoded .. string.char(tonumber(code))
		end

		return decoded
	end

	return {
		customKeywords = {},

		keyword = {
			["and"] = true,
			["break"] = true,
			["do"] = true,
			["else"] = true,
			["elseif"] = true,
			["end"] = true,
			["for"] = true,
			["function"] = true,
			["if"] = true,
			["in"] = true,
			["not"] = true,
			["while"] = true,
			["or"] = true,
			["repeat"] = true,
			["return"] = true,
			["then"] = true,
			["self"] = true,
			["until"] = true,
			["continue"] = true,
			["export"] = true,
			["type"] = true,
			["typeof"] = true,
		},

		variables = {
			["local"] = true,
		},

		builtin = {
			-- Lua Functions
			["assert"] = true,
			["collectgarbage"] = true,
			["error"] = true,
			[asciiDecode([[
			\103
			\101
			\116
			\102
			\101
			\110
			\118
		]])] = true,
			["getmetatable"] = true,
			["ipairs"] = true,
			[asciiDecode([[
			\108
			\111
			\97
			\100
			\115
			\116
			\114
			\105
			\110
			\103
		]])] = true,
			["newproxy"] = true,
			["next"] = true,
			["pairs"] = true,
			["pcall"] = true,
			["print"] = true,
			["rawequal"] = true,
			["rawget"] = true,
			["rawset"] = true,
			["select"] = true,
			[asciiDecode([[
			\115
			\101
			\116
			\102
			\101
			\110
			\118
		]])] = true,
			["setmetatable"] = true,
			["tonumber"] = true,
			["tostring"] = true,
			["unpack"] = true,
			["xpcall"] = true,
			["buffer"] = true,
			["Font"] = true,

			-- API functions

			-- Lua Variables
			["_G"] = true,
			["_VERSION"] = true,

			-- Lua Tables
			["bit32"] = true,
			["coroutine"] = true,
			["debug"] = true,
			["math"] = true,
			["os"] = true,
			["string"] = true,
			["table"] = true,
			["utf8"] = true,

			-- Roblox Functions
			["delay"] = true,
			["elapsedTime"] = true,
			["gcinfo"] = true,
			[asciiDecode([[
			\114
			\101
			\113
			\117
			\105
			\114
			\101
		]])] = true,
			["settings"] = true,
			["spawn"] = true,
			["tick"] = true,
			["time"] = true,
			["UserSettings"] = true,
			["wait"] = true,
			["warn"] = true,
			["ypcall"] = true,

			-- Roblox Variables
			["Enum"] = true,
			["shared"] = true,
			["script"] = true,
			["workspace"] = true,
			["Workspace"] = true,
			["plugin"] = true,
			["game"] = true,
			["Game"] = true,

			-- Roblox Tables
			["Axes"] = true,
			["BrickColor"] = true,
			["CatalogSearchParams"] = true,
			["CellId"] = true,
			["CFrame"] = true,
			["Color3"] = true,
			["ColorSequence"] = true,
			["ColorSequenceKeypoint"] = true,
			["DateTime"] = true,
			["DockWidgetPluginGuiInfo"] = true,
			["Faces"] = true,
			["File"] = true,
			["FloatCurveKey"] = true,
			["Instance"] = true,
			["NumberRange"] = true,
			["NumberSequence"] = true,
			["NumberSequenceKeypoint"] = true,
			["OverlapParams"] = true,
			["PathWaypoint"] = true,
			["PhysicalProperties"] = true,
			["PluginDrag"] = true,
			["Random"] = true,
			["Ray"] = true,
			["RaycastParams"] = true,
			["Rect"] = true,
			["Region3"] = true,
			["Region3int16"] = true,
			["RotationCurveKey"] = true,
			["task"] = true,
			["TextChatMessageProperties"] = true,
			["TweenInfo"] = true,
			["UDim"] = true,
			["UDim2"] = true,
			["Vector2"] = true,
			["Vector2int16"] = true,
			["Vector3"] = true,
			["Vector3int16"] = true,
		},

		properties = {
			-- Appearance
			["BrickColor"] = true,
			["CastShadows"] = true,
			["Color"] = true,
			["Material"] = true,
			["Reflectance"] = true,
			["MaterialVariant"] = true,
			["Transparency"] = true,
			["MeshId"] = true,
			["RenderFidelity"] = true,
			["TextureID"] = true,

			-- Data
			["Parent"] = true,
			["Name"] = true,
			["Archivable"] = true,
			["ClassName"] = true,
			["Locked"] = true,
			["ResizeableFaces"] = true,
			["ResizeIncrement"] = true,

			-- Transform
			["Size"] = true,
			["CFrame"] = true,
			["Orgin"] = true,
			["Position"] = true,
			["Orientation"] = true,
			["PivotOffset"] = true,

			-- Collision
			["CanCollide"] = true,
			["CanTouch"] = true,
			["CollisionGroup"] = true,

			-- Object
			["Anchored"] = true,
			["CenterOfMass"] = true,
			["CurrentPhysicalProperties"] = true,
			["CustomPhysicalProperties"] = true,
			["Mass"] = true,
			["Massless"] = true,
			["RootPriority"] = true,
			["Shape"] = true,
			["PrimaryPart"] = true,
			["Scale"] = true,

			-- Behavior
			["ModelStreamingMode"] = true,

			-- Assembly
			["AssemblyLinearVelocity"] = true,
			["AssemblyAngularVelocity"] = true,
			["AssemblyCenterOfMass"] = true,
			["AssemblyMass"] = true,
			["AssemblyRootPart"] = true,

			-- Script
			["Enabled"] = true,
			["Disabled"] = true,
			["Source"] = true,
			["CurrentEditor"] = true,
			["RunContext"] = true,
		},

		booleans = {
			["true"] = true,
			["false"] = true,
			["nil"] = true,
		},

		comments = {
			["TODO"] = true,
		},

		libraries = {

			-- Lua Libraries
			math = {
				abs = true,
				acos = true,
				asin = true,
				atan = true,
				atan2 = true,
				ceil = true,
				clamp = true,
				cos = true,
				cosh = true,
				deg = true,
				exp = true,
				floor = true,
				fmod = true,
				frexp = true,
				ldexp = true,
				log = true,
				log10 = true,
				max = true,
				min = true,
				modf = true,
				noise = true,
				pow = true,
				rad = true,
				random = true,
				round = true,
				sinh = true,
				sqrt = true,
				tan = true,
				tanh = true,
				sign = true,
				sin = true,
				randomseed = true,

				huge = true,
				pi = true,
			},

			string = {
				byte = true,
				char = true,
				find = true,
				format = true,
				gmatch = true,
				gsub = true,
				len = true,
				lower = true,
				match = true,
				pack = true,
				packsize = true,
				rep = true,
				reverse = true,
				split = true,
				sub = true,
				unpack = true,
				upper = true,
			},

			table = {
				clear = true,
				concat = true,
				foreach = true,
				foreachi = true,
				freeze = true,
				getn = true,
				insert = true,
				isfrozen = true,
				maxn = true,
				remove = true,
				sort = true,
				find = true,
				pack = true,
				unpack = true,
				move = true,
				create = true,
			},

			debug = {
				dumpheap = true,
				info = true,
				profilebegin = true,
				profileend = true,
				resetmemorycategory = true,
				setmemorycategory = true,
				traceback = true,
				getconstant = true,
				getconstants = true,
				getinfo = true,
				getproto = true,
				getprotos = true,
				getstack = true,
				getupvalue = true,
				getupvalues = true,
				setconstant = true,
				setstack = true,
				setupvalue = true,
				getregistry = true,
				setmetatable = true,
				getlocals = true,
				getlocal = true,
				setlocal = true,
			},

			os = {
				time = true,
				date = true,
				difftime = true,
				clock = true,
			},

			coroutine = {
				create = true,
				isyieldable = true,
				resume = true,
				running = true,
				status = true,
				wrap = true,
				yield = true,
			},

			bit32 = {
				arshift = true,
				band = true,
				bnot = true,
				bor = true,
				btest = true,
				bxor = true,
				countlz = true,
				countrz = true,
				extract = true,
				lrotate = true,
				lshift = true,
				replace = true,
				rrotate = true,
				rshift = true,
			},

			utf8 = {
				char = true,
				codepoint = true,
				codes = true,
				graphemes = true,
				len = true,
				nfcnormalize = true,
				nfdnormalize = true,
				offset = true,

				charpattern = true,
			},

			-- Roblox Libraries
			Axes = {
				new = true,
			},

			BrickColor = {
				new = true,
				New = true,
				Random = true,
				Black = true,
				Blue = true,
				DarkGray = true,
				Gray = true,
				Green = true,
				Red = true,
				White = true,
				Yellow = true,
				palette = true,
				random = true,
			},

			CatalogSearchParams = {
				new = true,
			},

			CellId = {
				new = true,
			},

			CFrame = {
				new = true,
				Angles = true,
				fromAxisAngle = true,
				fromEulerAnglesXYZ = true,
				fromEulerAnglesYXZ = true,
				fromMatrix = true,
				fromOrientation = true,
				lookAt = true,

				identity = true,
			},

			Color3 = {
				new = true,
				fromRGB = true,
				fromHSV = true,
				fromHex = true,
				toHSV = true,
			},

			ColorSequence = {
				new = true,
			},

			ColorSequenceKeypoint = {
				new = true,
			},

			DateTime = {
				now = true,
				fromIsoDate = true,
				fromLocalTime = true,
				fromUniversalTime = true,
				fromUnixTimestamp = true,
				fromUnixTimestampMillis = true,
			},

			DockWidgetPluginGuiInfo = {
				new = true,
			},

			Faces = {
				new = true,
			},

			FloatCurveKey = {
				new = true,
			},

			Instance = {
				new = true,
			},

			NumberRange = {
				new = true,
			},

			NumberSequence = {
				new = true,
			},

			NumberSequenceKeypoint = {
				new = true,
			},

			OverlapParams = {
				new = true,
			},

			PathWaypoint = {
				new = true,
			},

			PhysicalProperties = {
				new = true,
			},

			PluginDrag = {
				new = true,
			},

			Random = {
				new = true,
			},

			Ray = {
				new = true,
			},

			RaycastParams = {
				new = true,
			},

			Rect = {
				new = true,
			},

			Region3 = {
				new = true,
			},

			Region3int16 = {
				new = true,
			},

			RotationCurveKey = {
				new = true,
			},

			task = {
				wait = true,
				spawn = true,
				delay = true,
				defer = true,
				synchronize = true,
				desynchronize = true,
			},

			TweenInfo = {
				new = true,
			},

			UDim = {
				new = true,
			},

			UDim2 = {
				new = true,
				fromScale = true,
				fromOffset = true,
			},

			Vector2 = {
				new = true,

				one = true,
				zero = true,
				xAxis = true,
				yAxis = true,
			},

			Vector2int16 = {
				new = true,
			},

			Vector3 = {
				new = true,
				fromAxis = true,
				fromNormalId = true,
				FromAxis = true,
				FromNormalId = true,

				one = true,
				zero = true,
				xAxis = true,
				yAxis = true,
				zAxis = true,
			},

			Vector3int16 = {
				new = true,
			},

			buffer = {
				tostring = true,
				len = true,
				readi8 = true,
				readf32 = true,
				readu8 = true,
				readf64 = true,
				readi16 = true,
				readi32 = true,
				readu16 = true,
				readu32 = true,
				copy = true,
				fill = true,
				create = true,
				writei8 = true,
				writeu8 = true,
				writef32 = true,
				writef64 = true,
				writei16 = true,
				writei32 = true,
				writeu16 = true,
				writeu32 = true,
				fromstring = true,
				readstring = true,
				writestring = true,
			},

			Font = {
				new = true,
				fromId = true,
				fromEnum = true,
				fromName = true,
			},

			Enum = {
				KeyCode = true,
				Button = true,
				Material = true,
				AutomaticSize = true,
				UserInputType = true,
				Font = true,
				NormalId = true,
				EasingStyle = true,
				EasingDirection = true,
				PoseEasingStyle = true,
				CameraType = true,
				SortOrder = true,
				CoreGuiType = true,
				InOut = true,
				RigType = true,
				ExplosionType = true,
				FontSize = true,
				VerticalAlignment = true,
				HorizontalAlignment = true,
				CameraMode = true,
				TextXAlignment = true,
				HumanoidRigType = true,
				BodyPart = true,
				InputType = true,
				ScaleType = true,
				AspectType = true,
				ChatVersion = true,
				DominantAxis = true,
				FillDirection = true,
				TextYAlignment = true,
				ApplyStrokeMode = true,
				HumanoidStateType = true,
				Language = true,
				MeshType = true,
				UserInputState = true,
				ZIndexBehavior = true,
				RaycastFilterType = true,
				ModelStreamingMode = true,
				Axis = true,
				Limb = true,
				AdShape = true,
				AlignType = true,
				AlphaMode = true,
				AssetType = true,
				ActionType = true,
				AdEventType = true,
				ActuatorType = true,
				AdUnitStatus = true,
				AudioSubType = true,
			},
		},
	}
end

function beautifyModule()
	function beautify(code)
		local indent_level = 0
		local indent_char = "    "

		local function trim(s)
			return s:match("^%s*(.-)%s*$")
		end

		local function increase_indent()
			indent_level = indent_level + 1
		end

		local function decrease_indent()
			indent_level = math.max(indent_level - 1, 0)
		end

		local function get_indent()
			return string.rep(indent_char, indent_level)
		end

		local formatted_code = {}
		for line in code:gmatch("[^\n]+") do
			line = trim(line)

			if line:match("^end$") or line:match("^elseif ") or line:match("^else$") then
				decrease_indent()
			end

			table.insert(formatted_code, get_indent() .. line)

			if line:match("then$") or line:match("do$") or line:match("function%s") then
				increase_indent()
			end
		end

		return table.concat(formatted_code, "\n")
	end

	return beautify
end

function obfuscateModule()
	function obfuscate(script)
		-- Helper Functions
		local function generateRandomName()
			return "var" .. math.random(1000000, 9999999)
		end

		local function encryptString(str)
			local result = ""
			for i = 1, #str do
				local c = str:sub(i, i)
				local enc = string.format("\\x%02X", string.byte(c))
				result = result .. enc
			end
			return result
		end

		local function decryptString(str)
			return (str:gsub("\\x(%x%x)", function(hex)
				return string.char(tonumber(hex, 16))
			end))
		end

		-- Variable and Function Renaming
		local renamed = {}
		local counter = 0
		script = script:gsub("%f[%a_](%w+)%f[^%w_]", function(var)
			if not renamed[var] then
				counter = counter + 1
				renamed[var] = generateRandomName()
			end
			return renamed[var]
		end)

		-- String Encryption
		script = script:gsub('"(.-)"', function(str)
			return '"..decryptString(' .. encryptString(str) .. ').."'
		end)

		-- Add Decryption Function to the Script
		script = [[
        local function decryptString(str) 
            return (str:gsub("\\x(%x%x)", function(hex) 
                return string.char(tonumber(hex, 16)) 
            end)) 
        end 
    ]] .. script

		-- Complex Control Flow Obfuscation
		script = script .. [[
        local function wrapper() 
            local function _a() return true end 
            local function _b() if _a() then 
                while not false do 
                    if true then 
                        local function _c() return not false end 
                        if _c() then 
                            local _d = 0 
                            repeat 
                                local _e = function() return _d < 10 end 
                                if _e() then 
                                    local _f = function() 
                                        local _g = function() 
                                            return not not true 
                                        end 
                                        if _g() then 
                                            local _h = function() 
                                                return true 
                                            end 
                                            if _h() then 
                                                local _i = 1 
                                                while _i <= 10 do 
                                                    if _i % 2 == 0 then 
                                                        print("Hello from Roblox") 
                                                    end 
                                                    _i = _i + 1 
                                                end 
                                            end 
                                        end 
                                    end 
                                end 
                                _d = _d + 1 
                            until _d >= 10 
                        end 
                    end
                    break
                end 
            end end 
            _b() 
        end 
        wrapper() 
    ]]

		-- Additional Obfuscation
		script = "local dummy = function() return true end; local junk = function() " ..
			"for i=1,500 do if i % 3 == 0 then local a = i * 2 end end end; junk(); dummy(); " .. script

		-- Whitespace Removal & Code Flattening
		--script = script:gsub("%s+", "") -- Remove whitespace and newlines
		--script = script:gsub("\n", "") -- Remove newlines
		script = script:gsub("endend", "end") -- Flatten end statements

		return script
	end

	return obfuscate
end

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
		Highlighter = highlighterModule(),
		Autocomplete = autocompleteModule(),
		Lines = linesModule(),
		Indenter = indenterModule(),
		CustomInput = customInputModule(),
		Shared = sharedModule(),

		Beautify = beautifyModule(),
		Obfuscate = obfuscateModule(),
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
