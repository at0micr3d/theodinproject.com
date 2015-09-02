def bubble_sort(arr)
	for i in (0..arr.length-2)
		for j in (0..arr.length - i - 2)
			if arr[j+1] < arr[j]
				tmp = arr[j] 
				arr[j] = arr[j+1]
				arr[j+1] = tmp
			end
		end
	end
	arr
end

p bubble_sort([4,3,78,2,0,2]).inspect


def bubble_sort_by(arr)
	for i in 0..arr.length - 2
		for j in (0..arr.length - i - 2)
			if (yield arr[j], arr[j+1]) > 0
				tmp = arr[j+1] 
				arr[j+1] = arr[j]
				arr[j] = tmp
			end
		end
	end
	p arr
end

bubble_sort_by(["hi","hello","hey"]) do |left,right|
    left.length - right.length
end