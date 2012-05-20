WIDTH = 1024
HEIGHT = 768

MOAISim.openWindow ( "Simtlr",  WIDTH, HEIGHT )
MOAISim.setStep(1/60)
viewport = MOAIViewport.new()
viewport:setScale(WIDTH, HEIGHT)
viewport:setSize(WIDTH, HEIGHT)

function imagePathFor(image)
	return "assets/images/"..image
end

function fontPathFor(font)
	return "assets/fonts/"..font
end

function addBackground() 
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
addBackground()
	 
layer = MOAILayer2D.new()
layer:setViewport(viewport)
MOAISim.pushRenderPass(layer)

penguinGfx = MOAIGfxQuad2D.new()
penguinGfx:setTexture(imagePathFor("car.png"))
penguinGfx:setRect(-96, -96, 96, 96)

function makeCar(x, y, targetX, targetY, orientation)
	local penguin = MOAIProp2D.new()
	penguin:setDeck(penguinGfx)
	layer:insertProp(penguin)
	penguin:setLoc(x, y)
	
	function penguin:main()
		MOAICoroutine.blockOnAction(self:seekLoc(targetX, targetY, 1, MOAIEaseType.LINEAR))
		layer:removeProp(self)
	end
	
	function penguin:go()
		thread = MOAICoroutine.new()
		thread:run(self.main, self)
	end
	
	if orientation == LEFT then
		penguin:addRot(90, 0)
	elseif orientation == RIGHT then
		penguin:addRot(-90, 0)
	elseif orientation == DOWN then
		penguin:addRot(180, 0)
	end
	return penguin
end

function makeTimerBox(x, y)
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
	layer:insertProp(textbox)
	return textbox
end

LEFT = 0
DOWN = 1
RIGHT = 2
UP = 3

frames = 0
seconds = 0
currentGreen = UP

carLeft = makeCar(-400, -40, 400, -40, RIGHT)
carRight = makeCar(400, 40, -400, 40, LEFT)
carBottom = makeCar(40, -200, 40, 200, UP)
carTop = makeCar(-40, 200, -40, -200, DOWN)

timebox = makeTimerBox(450, 250)

mainThread = MOAICoroutine.new()
mainThread:run(function ()	
	while true do
		coroutine.yield()
		frames = frames + 1
		if frames % 60 == 0 then
			seconds = seconds + 1
			if seconds % 3 == 0 then
				currentGreen = (currentGreen + 1) % 4	
			end
			if currentGreen == LEFT then
				carLeft:go()
				carLeft = makeCar(-400, -40, 400, -40, RIGHT)
			elseif currentGreen == DOWN then
				carBottom:go()
				carBottom = makeCar(40, -200, 40, 200, UP)
			elseif currentGreen == RIGHT then
				carRight:go()
				carRight = makeCar(400, 40, -400, 40, LEFT)
			else
				carTop:go()
				carTop = makeCar(-40, 200, -40, -200, DOWN)
			end			
			timebox:setString(seconds .. "s")
		end		
	end
end
)