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
