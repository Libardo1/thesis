module("simulator", package.seeall)
local Simulator = {}

moduleLoader = require "src/module-loader"
Timer = moduleLoader:load("timer")

local currentState = nil
local timer

local function runner()
	local frames = 0
	while true do
		coroutine.yield()
		frames = frames + 1
		if frames % config.FRAMES_IN_SECOND == 0 then
			timer:advance()
			currentState:onNextStep(timer:elapsedSeconds())
		end
	end
end

function Simulator:onStateComplete()
	print("State complete")
	-- switch to the next one
end

function Simulator:start(state)
	currentState = state
	currentState:setCompleteCallback(self.onStateComplete)
	timer = Timer.new()
	timer:start()
	currentState:onStart()
	mainThread = MOAIThread.new()
	mainThread:run(runner)
end

return Simulator