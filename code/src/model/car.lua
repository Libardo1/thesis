module("car", package.seeall)

Car = {}
Car.__index = Car

function Car.new()
	local newCar = {}
	setmetatable(newCar, Car)
	UiFactory.initializeModel(newCar)
	return newCar
end

function Car:move(onCompleteCallback)
	UiFactory.moveAndRemove(self, onCompleteCallback)
end

function Car:image()
	return "car.png", 192
end

function Car:draw()
	UiFactory.drawModel(self)
end

function Car:toString()
	return "Car"
end

return Car