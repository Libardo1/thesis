module("simulator", package.seeall)

local Simulator = {}
local currentState = nil

local function runner()
	local seconds = 0
	local frames = 0
	while true do
		coroutine.yield()
		frames = frames + 1
		if frames % config.FRAMES_IN_SECOND == 0 then
			seconds = seconds + 1
			currentState:onNextStep(seconds)
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
	currentState:onStart()
	mainThread = MOAIThread.new()
	mainThread:run(runner)
end

return Simulator