function foo ()
	error("Hmm, something is wrong")
end

local okStatus, errorMessage = pcall(foo)
if okStatus then
	print("Works fine")
else
	-- error is raised
	print(errorMessage)
end