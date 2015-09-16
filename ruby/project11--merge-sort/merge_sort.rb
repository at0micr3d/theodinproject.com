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
	if arr.length > 1
		arr_tmp = arr.each_slice((arr.size/2.0).round).to_a
		res1 = merge_sort(arr_tmp[0])
		res2 = merge_sort(arr_tmp[1])
		arr = merge(res1, res2)
	end
	return arr
end

10.times do
	arr = (1..20).to_a.map { |e| e = (rand * 100).to_i }
	arr2 = arr.clone
	puts merge_sort(arr) == arr2.sort
end

