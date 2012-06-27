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
	drawBackground()
	drawLayer = drawLayer()
	timerBox = drawTimerBox(450, 250)
	
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

function drawTimerBox(x, y)
	charcodes = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-'
	font = MOAIFont.new()
	font:loadFromTTF(fontPathFor('arialbd.ttf'), charcodes, 16, 163)
	
	textbox = MOAITextBox.new()
	textbox:setString("0s")
	textbox:setFont(font)
	textbox:setLoc(x, y)
	textbox:setTextSize(16)
	textbox:setRect(-30, -30, 30, 30)
	textbox:setYFlip(true)
	drawLayer:insertProp(textbox)
	return textbox
end

function drawBackground() 
	backgroundGfx = MOAIGfxQuad2D.new()
	backgroundGfx:setTexture(imagePathFor("background.jpg"))
	backgroundGfx:setRect(-512, -384, 512, 384)

	background = MOAILayer2D.new()
	background:setViewport(viewport)
	MOAISim.pushRenderPass(background)

	backgroundProp = MOAIProp2D.new()
	backgroundProp:setDeck(backgroundGfx)
	background:insertProp(backgroundProp)
end

function drawLayer()
	layer = MOAILayer2D.new()
	layer:setViewport(viewport)
	MOAISim.pushRenderPass(layer)
	return layer
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
	print("Simulation complete")
end

function Simulation:setListener(stateListener)
	listener = stateListener
end

return Simulation