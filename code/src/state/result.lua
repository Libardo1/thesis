module("result", package.seeall)

local Result = {}

local listener

function Result:onStart()
	print("Result started")
	self:finish()
end

function Result:onNextStep(seconds)
	
end

function Result:finish()
	listener:onStateComplete{nextState = Optional.absent(), parameters = {}}
end

function Result:onFinish()
	print("Result complete")
end

function Result:setListener(stateListener)
	listener = stateListener
end

return Result