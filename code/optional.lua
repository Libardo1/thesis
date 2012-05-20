Optional = {}
Optional.__index = Optional

local function new(value)
	local self = {}
	setmetatable(self, Optional)
	self.value = value
	self.defaultValue = nil
	return self
end

function Optional.of(reference)
	return new(reference)
end

function Optional.absent()
	return new(nil)
end 

function Optional:isPresent()
	return self.value ~= nil
end

function Optional:default(value)
	self.defaultValue = value
end

function Optional:get()	
	if self:isPresent() then
		return self.value
	end
	return self.defaultValue
end