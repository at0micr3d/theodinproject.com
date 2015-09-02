def substrings(str, dict)
	result = {}
	str.split(' ').each do |word|
		dict.each do |item| 
			if word.downcase.include? item 
				result[item] = 0 if result[item].nil?
				result[item] += 1
			end
		end
	end
	result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
p substrings("below", dictionary)
p substrings("Howdy partner, sit down! How's it going?", dictionary)