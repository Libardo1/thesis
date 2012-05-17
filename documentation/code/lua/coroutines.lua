function foo (a)
	print("foo", a)
	return coroutine.yield(2*a)
end

myCoroutine = coroutine.create(function (a,b)
	print("myCoroutine-body", a, b)
	local r = foo(a+1)
	print("myCoroutine-body", r)
	local r, s = coroutine.yield(a+b, a-b)
	print("myCoroutine-body", r, s)
	return b, "end"
end)
     
print("main", coroutine.resume(myCoroutine, 1, 10))
print("main", coroutine.resume(myCoroutine, "r"))
print("main", coroutine.resume(myCoroutine, "x", "y"))
print("main", coroutine.resume(myCoroutine, "x", "y"))