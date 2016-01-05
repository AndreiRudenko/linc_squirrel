function test(){
	print("calling test() func")
	return "Squirrel is awesome!"
}

function test2(a){
	print("calling test2() func")
	print(a)
	return a
}

local ret = callBack("test callback")
print(ret)

print("file script.nut loaded!")
