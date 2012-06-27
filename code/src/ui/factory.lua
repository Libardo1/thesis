module("ui.factory", package.seeall)

local Factory = {}

local function imagePathFor(image)
	return "assets/images/"..image
end

local function fontPathFor(font)
	return "assets/fonts/"..font
end

local function loadTexture(file, x1, y1, x2, y2)
	texture = MOAIGfxQuad2D.new()
	texture:setTexture(imagePathFor(file))
	texture:setRect(x1, y1, x2, y2)
	return texture
end

local charcodes = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-'
local font = MOAIFont.new()
font:loadFromTTF(fontPathFor('arialbd.ttf'), charcodes, 16, 163)

function Factory.drawTextBox(options)		
	local textbox = MOAITextBox.new()
	textbox:setString(options.text)
	textbox:setFont(font)
	textbox:setLoc(options.x, options.y)
	textbox:setTextSize(16)
	textbox:setRect(-100, -30, 100, 30)
	textbox:setYFlip(true)
	options.layer:insertProp(textbox)
	return textbox
end

function Factory.drawImage(imageName, width, height)
	texture = MOAIGfxQuad2D.new()
	texture:setTexture(imagePathFor(imageName))
	texture:setRect(-(width / 2), -(height / 2), (width / 2), (height / 2))

	image = MOAILayer2D.new()
	image:setViewport(viewport)
	MOAISim.pushRenderPass(image)

	prop = MOAIProp2D.new()
	prop:setDeck(texture)
	image:insertProp(prop)
end

function Factory.drawLayer()
	layer = MOAILayer2D.new()
	layer:setViewport(viewport)
	MOAISim.pushRenderPass(layer)
	return layer
end

function Factory.initializeModel(model)
	model.prop = MOAIProp2D.new()
end

function Factory.drawModel(model)
	local image, side = model:image()
	model.prop:setDeck(loadTexture(image, -(side / 2), -(side / 2), (side / 2), (side / 2)))
	model.layer:insertProp(model.prop)
	model.prop:setLoc(model.x, model.y)
	local orientation = model.orientation
	if orientation == LEFT then
		model.prop:addRot(90, 0)
	elseif orientation == RIGHT then
		model.prop:addRot(-90, 0)
	elseif orientation == DOWN then
		model.prop:addRot(180, 0)
	end
end

function Factory.moveAndRemove(model, onCompleteCallback)
	thread = MOAICoroutine.new()
	thread:run(function()
		MOAICoroutine.blockOnAction(model.prop:seekLoc(model.targetX, model.targetY, 1, MOAIEaseType.LINEAR))
		model.layer:removeProp(model.prop)
		onCompleteCallback()
	end)
end

function Factory.clearScreen()
	MOAIRenderMgr.setRenderTable({})
end

return Factory