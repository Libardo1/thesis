module("simple", package.seeall)

Simple = {}
Simple.__index = Simple

local currentGreen = UP

function Simple.new(models)
	local newSimple = {}
	setmetatable(newSimple, Simple)
	newSimple.models = models
	return newSimple
end

function Simple:decide(seconds)
	if seconds % 3 == 0 then
		currentGreen = (currentGreen + 1) % 4		
	end
	local model
	local nextModel
	if currentGreen == LEFT then
		model = self.models.left:pop()
		nextModel = self.models.left:peek()
	elseif currentGreen == DOWN then
		model = self.models.down:pop()
		nextModel = self.models.down:peek()
	elseif currentGreen == RIGHT then
		model = self.models.right:pop()
		nextModel = self.models.right:peek()
	else
		model = self.models.up:pop()				
		nextModel = self.models.up:peek()				
	end
	if model:isPresent() then
		model:get():move(function() 
			self.listener:onVehiclePassed(model:get():toString())
			if nextModel:isPresent() then
				nextModel:get():draw()
			end		
		end)		
	end
	
end

function Simple:setListener(listener)
	self.listener = listener
end

return Simple