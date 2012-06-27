module("config", package.seeall)

config = {}

config.SCREEN_WIDTH = 1024
config.SCREEN_HEIGHT = 768

config.TOTAL_RUNNING_TIME = 1
config.FRAMES_IN_SECOND = 60

config.STRATEGY = "simple"

function config.step()
	return 1 / config.FRAMES_IN_SECOND
end

return config