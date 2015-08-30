def add(n1, n2)
 	n1 + n2
end 

def subtract(n1, n2)
	n1 - n2
end

def sum(arr)
	sum = 0 
	for i in arr
		sum = add(sum, i)
	end
	return sum
end

def multiply(*arr)
	sum = 1 
	for i in arr
		sum = sum * i
	end
	return sum
end

def power(base, power)
	pwr = 1
	power.times do
		pwr = pwr * base
	end
	return pwr
end

def fact(nr)
	i = 1.0
	total = 1
	nr.times do 
		total = total * i
		i += 1
	end
	total
end
