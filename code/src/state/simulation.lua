module("simulation", package.seeall)

local Simulation = {}

local moduleLoader = require "src/module-loader"
local Car = moduleLoader:load("model/car")
local Strategy = moduleLoader:loadStrategy(config.STRATEGY)

local listener
local timerBox
local drawLayer
local elapsedSeconds
local vehiclesPassed = 0
local strategy

local models = {left = Queue.new(), up = Queue.new(), right = Queue.new(), down = Queue.new()}

local leftCar, rightCar, topCar, downCar

local function initializeSide(orientation)
	
end

local function initializeModels()
	initializeSide("left")
	initializeSide("up")
	initializeSide("right")
	initializeSide("down")
end

function Simulation:onStart(parameters)
	initializeModels()
	strategy = Strategy.new(models)
	strategy:setListener(self)
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
		elapsedSeconds = seconds
		return self:finish()
	end
	timerBox:setString(seconds .. "s")	
	strategy:decide{seconds=seconds, 
					vehicles={left=leftCar, top=topCar, right=rightCar, down=downCar}
					}	
end

function Simulation:onVehiclePassed()
	vehiclesPassed = vehiclesPassed + 1
end

function Simulation:finish()
	listener:onStateComplete{nextState = Optional.of("result"), parameters = {elapsedSeconds = elapsedSeconds, vehiclesPassed = vehiclesPassed}}
end

function Simulation:onFinish()
	MOAIRenderMgr.setRenderTable({})
	print("Simulation complete")
end

function Simulation:setListener(stateListener)
	listener = stateListener
end

return Simulation