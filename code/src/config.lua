module("config", package.seeall)

config = {}

--
-- VISUAL SETTINGS
--
config.SCREEN_WIDTH = 1024
config.SCREEN_HEIGHT = 768
config.FRAMES_IN_SECOND = 60

function config.step()
	return 1 / config.FRAMES_IN_SECOND
end

--
-- SIMULATION SETTINGS
--
config.STRATEGY = "simple"
config.TOTAL_RUNNING_TIME = 20
config.MAXIMUM_MODELS_PER_SIDE = 100

--
-- CONGESTION MULTIPLIERS
--
config.BUS_CONGESTION_MULTIPLIER = 40
config.CAR_CONGESTION_MULTIPLIER = 2

return config