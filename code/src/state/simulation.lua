module("simulation", package.seeall)

local Simulation = {}

local moduleLoader = require "src/module-loader"
local Car = moduleLoader:load("model/car")
local strategy = moduleLoader:loadStrategy(config.STRATEGY)

local listener
local timerBox
local drawLayer

local leftCar, rightCar, topCar, downCar

function Simulation:onStart()
	UiFactory.drawImage("background.jpg", 1024, 768)
	drawLayer = UiFactory.drawLayer()
	timerBox = UiFactory.drawTextBox{text = "0s", x = 450, y = 250, layer = drawLayer}
	
	leftCar = Car.new()
	leftCar.orientation = RIGHT
	leftCar.x = -400
	leftCar.y = -40
	leftCar.targetX = 400
	leftCar.targetY = -40
	leftCar.layer = drawLayer
	leftCar:draw()
	
	rightCar = Car.new()
	rightCar.orientation = LEFT
	rightCar.x = 400
	rightCar.y = 40
	rightCar.targetX = -400
	rightCar.targetY = 40
	rightCar.layer = drawLayer
	rightCar:draw()
	
	topCar = Car.new()
	topCar.orientation = DOWN
	topCar.x = -40
	topCar.y = 200
	topCar.targetX = -40
	topCar.targetY = -200
	topCar.layer = drawLayer
	topCar:draw()
	
	downCar = Car.new()
	downCar.orientation = UP
	downCar.x = 40
	downCar.y = -200
	downCar.targetX = 40
	downCar.targetY = 200
	downCar.layer = drawLayer
	downCar:draw()
end

function Simulation:onNextStep(seconds)
	if	config.TOTAL_RUNNING_TIME <= seconds then
		return self:finish()
	end
	timerBox:setString(seconds .. "s")
	strategy:decide{seconds=seconds, 
					vehicles={left=leftCar, top=topCar, right=rightCar, down=downCar}
					}	
end

function Simulation:finish()
	listener:onStateComplete{nextState = Optional.of("result"), parameters = {}}
end

function Simulation:onFinish()
	MOAIRenderMgr.setRenderTable{}
	print("Simulation complete")
end

function Simulation:setListener(stateListener)
	listener = stateListener
end

return Simulation