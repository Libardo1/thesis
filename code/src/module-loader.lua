module("module-loader", package.seeall)

local Loader = {}

function Loader:load(moduleName)
	modulePath = "src/" .. moduleName
	return require(modulePath)
end

function Loader:loadState(stateName)
	return self:load("state/"..stateName)
end

function Loader:loadStrategy(name)
	return self:load("strategy/"..name)
end

return Loader