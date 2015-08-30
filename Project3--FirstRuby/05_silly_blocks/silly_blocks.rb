def reverser
	yield.split(" ").map {|i| i.reverse!}.join(" ")
end

def adder(integer = 1)
  	yield + integer
end

def repeater(n = 1)
	n.times {yield} 
end

