-- Author: Venelin Valkov
-- You will need Moai SDK to run this
-- based on hello-moai sample from the Moai SDK
MOAISim.openWindow ( "hello-moai", 320, 480 )

viewport = MOAIViewport.new ()
viewport:setSize ( 320, 480 )
viewport:setScale ( 320, 480 )

layer = MOAILayer2D.new ()
layer:setViewport ( viewport )
MOAISim.pushRenderPass ( layer )

font = MOAIFont.new ()
font:loadFromTTF ( "assets/fonts/arialbd.ttf", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,.?!", 12, 163 )

textbox = MOAITextBox.new ()
textbox:setFont ( font )
textbox:setTextSize ( 12 )
textbox:setRect ( -160, -80, 160, 80 )
textbox:setLoc ( 0, 100 )
textbox:setYFlip ( true )
textbox:setAlignment ( MOAITextBox.CENTER_JUSTIFY )
layer:insertProp ( textbox )

textbox:setString ( "Hello from Moai" )
textbox:spool ()
