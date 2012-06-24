module("simple", package.seeall)

Simple = {}
Simple.__index = Simple

local currentGreen = UP

function Simple.new()
	local newSimple = {}
	setmetatable(newSimple, Simple)
	return newSimple
end

function Simple:decide(options)
	if options.seconds % 3 == 0 then
		currentGreen = (currentGreen + 1) % 4		
	end
	if currentGreen == LEFT then
		options.vehicles.left:move()
	elseif currentGreen == DOWN then
		options.vehicles.down:move()
	elseif currentGreen == RIGHT then
		options.vehicles.right:move()
	else
		options.vehicles.top:move()
	end
end

return Simple