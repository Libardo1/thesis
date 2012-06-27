module("simulator", package.seeall)
local Simulator = {}

moduleLoader = require "src/module-loader"
Timer = moduleLoader:load("timer")

local currentState = nil
local timer
local mainCoroutine

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

function Simulator:onStateComplete(options)
	currentState:onFinish()
	MOAISim.forceGarbageCollection()
	if options.nextState:isAbsent() then
		return
	end
	nextState = moduleLoader:loadState(options.nextState:get())
	currentState = nextState
	currentState:setListener(self)
	currentState:onStart(options.parameters)
end

function Simulator:start(state, parameters)
	currentState = state
	currentState:setListener(self)
	timer = Timer.new()
	timer:start()
	currentState:onStart(parameters)
	mainCoroutine = MOAICoroutine.new()
	mainCoroutine:run(runner)
end

return Simulator