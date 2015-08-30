def stock_picker(arr)
	rslt = [0, 0]
	for i in 0..arr.length-1 
		for j in i..arr.length-1
			rslt = [i, j] if (arr[j] - arr[i]) > (arr[rslt[1]] - arr[rslt[0]])
		end
	end 
	return rslt
end

puts stock_picker([17,3,6,9,15,8,6,1,10]).inspect
puts stock_picker([3,6,9,15,8,6,1,10,17]).inspect
puts stock_picker([3,6,9,15,8,6,10,1,17]).inspect
