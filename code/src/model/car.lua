module("car", package.seeall)

Car = {}
Car.__index = Car

local carTexture = MOAIGfxQuad2D.new()
carTexture:setTexture(imagePathFor("car.png"))
carTexture:setRect(-96, -96, 96, 96)

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

function Car:draw()
	self.prop:setDeck(carTexture)
	self.layer:insertProp(self.prop)
	self.prop:setLoc(self.x, self.y)
	local orientation = self.orientation
	if orientation == LEFT then
		self.prop:addRot(90, 0)
	elseif orientation == RIGHT then
		self.prop:addRot(-90, 0)
	elseif orientation == DOWN then
		self.prop:addRot(180, 0)
	end
end

return Car