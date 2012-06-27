module("simulation", package.seeall)

local Simulation = {}

local moduleLoader = require "src/module-loader"
local Car = moduleLoader:load("model/car")
local Bus = moduleLoader:load("model/bus")
local Strategy = moduleLoader:loadStrategy(config.STRATEGY)

local listener
local timerBox
local drawLayer
local elapsedSeconds
local vehiclesPassed = 0
local strategy

local models = {left = Queue.new(), up = Queue.new(), right = Queue.new(), down = Queue.new()}

local function initializeSide(side)	
	local modelCount = math.random(2, 100)
	for i = 1, modelCount, 1 do		
		local modelProb = math.random(1, 5)
		local model
		if modelProb < 4 then
			model = Car.new()
		else
			model = Bus.new()
		end
		model.layer = drawLayer
		if side == LEFT then
			model.orientation = RIGHT
			model.x = -400
			model.y = -40
			model.targetX = 400
			model.targetY = -40
			models.left:push(model)
		elseif side == UP then
			model.orientation = DOWN
			model.x = -40
			model.y = 200
			model.targetX = -40
			model.targetY = -200
			models.up:push(model)
		elseif side == RIGHT then
			model.orientation = LEFT
			model.x = 400
			model.y = 40
			model.targetX = -400
			model.targetY = 40
			models.right:push(model)
		else
			model.orientation = UP
			model.x = 40
			model.y = -200
			model.targetX = 40
			model.targetY = 200
			models.down:push(model)
		end
	end
end

local function initializeModels()
	initializeSide(LEFT)
	initializeSide(UP)
	initializeSide(RIGHT)
	initializeSide(DOWN)
end

function Simulation:onStart(parameters)
	UiFactory.drawImage("background.jpg", 1024, 768)	
	drawLayer = UiFactory.drawLayer()
	timerBox = UiFactory.drawTextBox{text = "0s", x = 450, y = 250, layer = drawLayer}
	initializeModels()
	strategy = Strategy.new(models)
	strategy:setListener(self)
	
	models.left:peek():get():draw()
	models.up:peek():get():draw()
	models.right:peek():get():draw()
	models.down:peek():get():draw()
end

function Simulation:onNextStep(seconds)
	if	config.TOTAL_RUNNING_TIME <= seconds then
		elapsedSeconds = seconds
		return self:finish()
	end
	timerBox:setString(seconds .. "s")	
	strategy:decide(seconds)
end

function Simulation:onVehiclePassed()
	vehiclesPassed = vehiclesPassed + 1
end

function Simulation:finish()
	listener:onStateComplete{nextState = Optional.of("result"), parameters = {elapsedSeconds = elapsedSeconds, vehiclesPassed = vehiclesPassed}}
end

function Simulation:onFinish()
	UiFactory.clearScreen()	
end

function Simulation:setListener(stateListener)
	listener = stateListener
end

return Simulation