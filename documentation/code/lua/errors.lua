function foo ()        
	-- everytime raise an error
	error("Hmm, something is wrong")
end

local okStatus, errorMessage = pcall(foo)
if okStatus then
	-- no errors are raised
	print("Works fine")
else
	-- error is raised
	print(errorMessage)
end