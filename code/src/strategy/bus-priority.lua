module("bus-priority", package.seeall)

BusPriority = {}
BusPriority.__index = BusPriority

local currentGreen = UP

function BusPriority.new(models)
	local newBusPriority = {}
	setmetatable(newBusPriority, BusPriority)
	newBusPriority.models = models
	return newBusPriority
end

function BusPriority:decide(seconds)
	
	local model = Optional.absent()
	local nextModel = Optional.absent()
	
	local leftModel = self.models.left:peek()
	if leftModel:isPresent() and leftModel:get():toString() == "Bus" then
		currentGreen = LEFT
		self.models.left:pop()
		model = leftModel
		nextModel = self.models.left:peek()
	end
	
	local upModel = self.models.up:peek()
	if upModel:isPresent() and upModel:get():toString() == "Bus" then
		currentGreen = UP
		self.models.up:pop()
		model = upModel
		nextModel = self.models.up:peek()
	end
	
	local rightModel = self.models.right:peek()
	if rightModel:isPresent() and rightModel:get():toString() == "Bus" then
		currentGreen = RIGHT
		self.models.right:pop()
		model = rightModel
		nextModel = self.models.right:peek()
	end
	
	local downModel = self.models.down:peek()
	if downModel:isPresent() and downModel:get():toString() == "Bus" then
		currentGreen = DOWN
		self.models.down:pop()
		model = downModel
		nextModel = self.models.down:peek()		
	end
	
	if model:isAbsent() then
		if seconds % 3 == 0 then
			currentGreen = (currentGreen + 1) % 4		
		end
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

function BusPriority:setListener(listener)
	self.listener = listener
end

return BusPriority