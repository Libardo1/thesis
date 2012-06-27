local moduleLoader = require "src/module-loader"
moduleLoader:load("directions")
Optional = moduleLoader:load("optional")
UiFactory = moduleLoader:load("ui/factory")
Queue = moduleLoader:load("queue")
config = moduleLoader:load("config")

MOAISim.openWindow("Simtlr",  config.SCREEN_WIDTH, config.SCREEN_HEIGHT)
MOAISim.setStep(config.step())
viewport = MOAIViewport.new()
viewport:setScale(config.SCREEN_WIDTH, config.SCREEN_HEIGHT)
viewport:setSize(config.SCREEN_WIDTH, config.SCREEN_HEIGHT)

math.randomseed(os.time())

local simulator = moduleLoader:load("simulator")
local startState = moduleLoader:loadState("simulation")

simulator:start(startState, {})