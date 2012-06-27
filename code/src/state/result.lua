module("result", package.seeall)

local Result = {}

local listener

function Result:onStart(parameters)
	local drawLayer = UiFactory.drawLayer()
	UiFactory.drawTextBox{text = "Running time: ".. parameters.elapsedSeconds .."s", x = 0, y = 50, layer = drawLayer}
	UiFactory.drawTextBox{text = "Vehicles passed: ".. parameters.vehiclesPassed, x = 0, y = 10, layer = drawLayer}
	local congestionFactor = parameters.busesPassed * config.BUS_CONGESTION_MULTIPLIER + parameters.carsPassed * config.CAR_CONGESTION_MULTIPLIER
	UiFactory.drawTextBox{text = "Congestion factor: ".. congestionFactor, x = 0, y = -30, layer = drawLayer}
end

function Result:onNextStep(seconds)
end

function Result:finish()
	listener:onStateComplete{nextState = Optional.absent(), parameters = {}}
end

function Result:onFinish()
end

function Result:setListener(stateListener)
	listener = stateListener
end

return Result