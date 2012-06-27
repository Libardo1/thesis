module("car", package.seeall)

Car = {}
Car.__index = Car

function Car.new()
	local newCar = {}
	newCar.prop = MOAIProp2D.new()
	setmetatable(newCar, Car)
	return newCar
end

function Car:move()
	thread = MOAICoroutine.new()
	thread:run(function() 
		MOAICoroutine.blockOnAction(self.prop:seekLoc(self.targetX, self.targetY, 1, MOAIEaseType.LINEAR))
		self.layer:removeProp(self.prop)
	end)
end

function Car:image()
	return "car.png", 192
end

function Car:draw()
	UiFactory.drawModel(self)
end

return Car