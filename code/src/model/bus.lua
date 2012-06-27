module("bus", package.seeall)

Bus = {}
Bus.__index = Bus

function Car.new()
	local newBus = {}
	setmetatable(newBus, Bus)
	return newBus
end

return Bus