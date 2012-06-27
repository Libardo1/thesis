module("queue", package.seeall)

Queue = {}
Queue.__index = Queue

function Queue.new()
	local self = {}
	setmetatable(self, Queue)
	self.data = {}
	return self
end

function Queue:push(item)
	table.insert(self.data, item)
end

function Queue:isEmpty()
	return next(self.data) == nil
end

function Queue:size()
	return table.getn(self.data)
end

function Queue:pop()
	if self:isEmpty() then
		return Optional.absent()
	end
	local item = Optional.of(self.data[1])
	table.remove(self.data, 1)
	return item
end

function Queue:peek()
	if self:isEmpty() then
		return Optional.absent()
	end	
	return Optional.of(self.data[1])
end

return Queue