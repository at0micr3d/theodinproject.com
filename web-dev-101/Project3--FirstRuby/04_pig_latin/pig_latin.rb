def translate(msg)
	msg.split(' ').map {|i| translate_word(i)}.join(" ")
end

def translate_word(msg)
	orig_msg = msg
	vowels = ["a","o","u","e","i"]	
	consonant = ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "x", "z", "w", "y"]
	translation = ''
	
	if vowels.include?(orig_msg[0,1])
		translation = translate_vowels(msg)
	else
		translation = translate_consonant(msg, 1)
		if consonant.include?(orig_msg[1,1])
			translation = translate_consonant(msg, 2)
			if consonant.include?(orig_msg[2,1])
				translation = translate_consonant(msg, 3)
			end
		end		
		if orig_msg[0..1] == "qu" 
    		return orig_msg[2..-1]+"quay"
		end
		if orig_msg[0..2] == "squ" 
    		return orig_msg[3..-1]+"squay"
		end 
	end
	
	return translation
end

def translate_vowels(msg)
	msg + "ay" 
end

def translate_consonant(msg, i)
	msg[i..-1] + msg[0,i] + "ay" 
end