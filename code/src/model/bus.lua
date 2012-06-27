module("bus", package.seeall)

Bus = {}
Bus.__index = Bus

function Bus.new()
	local newBus = {}
	setmetatable(newBus, Bus)
	UiFactory.initializeModel(newBus)
	return newBus
end

function Bus:move(onCompleteCallback)
	UiFactory.moveAndRemove(self, onCompleteCallback)
end

function Bus:image()
	return "bus.png", 192
end

function Bus:draw()
	UiFactory.drawModel(self)
end

return Bus