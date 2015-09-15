def merge(arr1, arr2)
	arr = []
	
	while not (arr1 + arr2).empty?
		begin
			arr << arr1.shift if arr1[0] <= arr2[0]
			arr << arr2.shift if arr1[0] > arr2[0]
		rescue
			arr << arr2.shift if arr1.empty? && !arr2.empty?
			arr << arr1.shift if arr2.empty? && !arr1.empty?
		end
	end
	arr
end

def merge_sort(arr)
	if arr.length > 2
		arr_tmp = arr.each_slice((arr.size/2.0).round).to_a
		res1 = merge_sort(arr_tmp[0])
		res2 = merge_sort(arr_tmp[1])
		arr = merge(res1, res2)
	end

	if arr.length == 2  
		if arr[0].to_i >= arr[1].to_i
			swap = arr[0]
			arr[0] = arr[1]
			arr[1] = swap
		end		
	end
	return arr
end

arr = (1..20).to_a.map { |e| e = (rand * 10).to_i }
puts merge_sort(arr) == arr.sort


