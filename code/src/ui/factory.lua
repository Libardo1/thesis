module("ui.factory", package.seeall)

local Factory = {}

local function imagePathFor(image)
	return "assets/images/"..image
end

local function fontPathFor(font)
	return "assets/fonts/"..font
end

local charcodes = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-'
local font = MOAIFont.new()
font:loadFromTTF(fontPathFor('arialbd.ttf'), charcodes, 16, 163)

function Factory.drawTextBox(options)		
	textbox = MOAITextBox.new()
	textbox:setString(options.text)
	textbox:setFont(font)
	textbox:setLoc(options.x, options.y)
	textbox:setTextSize(16)
	textbox:setRect(-30, -30, 30, 30)
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

return Factory