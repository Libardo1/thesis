local moduleLoader = require "src/module-loader"
moduleLoader:load("directions")
config = moduleLoader:load("config")

MOAISim.openWindow("Simtlr",  config.SCREEN_WIDTH, config.SCREEN_HEIGHT)
MOAISim.setStep(config.step())
viewport = MOAIViewport.new()
viewport:setScale(config.SCREEN_WIDTH, config.SCREEN_HEIGHT)
viewport:setSize(config.SCREEN_WIDTH, config.SCREEN_HEIGHT)

function imagePathFor(image)
	return "assets/images/"..image
end

function fontPathFor(font)
	return "assets/fonts/"..font
end

local simulator = moduleLoader:load("simulator")
local startState = moduleLoader:loadState("running")
simulator:start(startState)