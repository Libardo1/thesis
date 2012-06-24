module("timer", package.seeall)

Timer = {}
Timer.__index = Timer

function Timer.new()
	local newTimer = {}
	setmetatable(newTimer, Timer)
	return newTimer
end

function Timer:start()
	self.seconds = 0
end

function Timer:advance()
	self.seconds = self.seconds + 1
end

function Timer:elapsedSeconds()
	return self.seconds
end

return Timer