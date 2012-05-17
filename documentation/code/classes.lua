Dog = {}
Dog.__index = Dog

function Dog.create(balance)
   local dog = {}         -- our new doggy
   setmetatable(dog,Dog)  -- make Dog handle lookup
   return dog
end

function Dog:speak()
	return "Bay Bay"
end

-- create and use an Dog
dog = Dog.create("Barky")
print("While playing with the dog, it says: ", dog:speak())